import socket
import dbus
import gi
gi.require_version("GSound", "1.0")
from gi.repository import  GLib, GSound
import alsaaudio
from math import ceil
from threading import Thread
import sys
import random

sound_context = GSound.Context()
sound_context.init()


def get_progress_string(items: int, status: int):
    filled = int(items * status / 100 + 0.5)
    return "▄" * filled + "▁" * (items - filled)

class Notification:
    """ Interface to create and send notifications with sound """
    interface = dbus.Interface(
            object = dbus.SessionBus().get_object("org.freedesktop.Notifications", "/org/freedesktop/Notifications") , 
            dbus_interface = "org.freedesktop.Notifications"
            )

    def __init__(self):
        self.title = ""
        self.desc = ""
        self.imagepath = ""
        self.urgency = 1
        self.audio = ""
        self.targets = [self.notify_send, self.sound]

    def notify_send(self):
        """ Send the notification """
        Notification.interface.Notify("", id(self) & 0xffffffff, "", 
             self.title, self.desc, [], {"image-path": self.imagepath, "urgency": self.urgency, }, 10000)

    def sound(self):
        """ Play a sound """
        sound_context.play_simple({ GSound.ATTR_EVENT_ID: self.audio })

    def notify(self):
        """ Send the notification while playing a sound """
        threads = [Thread(target = t) for t in self.targets]
        for t in threads: t.start()
        for t in threads: t.join()

class Volume(Notification):
    def __init__(self):
        super().__init__()
        self.icons = [
		    "audio-volume-muted",
		    "audio-volume-low",
		    "audio-volume-medium",
		    "audio-volume-high"
        ]

        self.audio = "audio-volume-change"
        self.items = 30
        self.update()

    def volume(self, flag):
        m = alsaaudio.Mixer()
        stereo_vol = m.getvolume()[0]
        if flag == "VOLUP":
            new_val = stereo_vol + 5
            stereo_vol = new_val if new_val < 100 else 100 
        if flag == "VOLDN":
            new_val = stereo_vol - 5
            stereo_vol = new_val if new_val > 0 else 0 
        m.setvolume(stereo_vol)

    def update(self):
        stereo_vol = alsaaudio.Mixer().getvolume()
        volume_perc = sum(stereo_vol)/len(stereo_vol)
        self.title = f"Volume level: {volume_perc:2.0f}%"
        self.desc = f"{get_progress_string(self.items, volume_perc)}"
        self.imagepath = self.icons[ceil(0.03 * volume_perc)]

    def toggle(self):
        muted = not alsaaudio.Mixer().getmute()[0]
        if muted:
            self.title = "Volume level: Muted"
            self.imagepath = self.icons[0]
        else: 
            self.update()

s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.connect("/var/run/acpid.socket")
v = Volume()
while True:
    try:
        command = s.recv(4096).decode("utf-8")[:-1].split()
        if command[0][:len("button/volume")] == "button/volume":
            v.volume(command[1])
            v.update()
            v.notify()
        if command[0][:len("button/mute")] == "button/mute":
            v.toggle()
            v.notify()
    except socket.error as e:
        print(e)
        sys.exit(1)
    except Exception as e:
        print(e)
        continue
        

s.close()
