import sys, os

import redirect

config.load_autoconfig(True)

c.aliases = { 
        "q"   : "close",
        "qa"  : "quit",
        "w"   : "session-save",
        "wq"  : "quit --save",
        "wqa" : "quit --save",
        "mpv" : "spawn --userscript /usr/share/qutebrowser/userscripts/view_in_mpv",
        }


keybinds = {
        ',i'             : 'hint images spawn mpv {hint-url}',
        ',I'             : 'hint images download',
        ',m'             : 'mpv',
        ',M'             : 'hint links spawn mpv {hint-url}',
        ';M'             : 'hint --rapid links spawn mpv {hint-url}',
        ';d'             : 'hint links download',
        ';D'             : 'hint --rapid links download',
        'eu'             : 'edit-url',
        '<return>'       : 'selection-follow',
        'zl'             : 'spawn --userscript qute-pass',
        '<Ctrl+T>'       : 'spawn --userscript translate',
        '<Ctrl+Shift+T>' : 'spawn --userscript translate --text',

        # Hide tabs and navigation bar (old keybinds)
        'xt'       : 'config-cycle tabs.show multiple switching',
        #'xb': 'config-cycle statusbar.hide',
}

settings = {

        # Fingerprint Settings
        # 'content.headers.user_agent'        : 'Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0',
        # 'content.headers.accept_language'   : 'en-US,en;q=0.5',
        # 'content.headers.custom'            : {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"},

        # Tor
        # 'content.proxy'                   : 'socks://localhost:9050',

        # Fonts
        'fonts.default_family'              : ["Uw Ttyp0", "Kochi Gothic","Hack", "Noto Color Emoji"],
        'fonts.prompts'                      : "(TTF) Terminus",
        'fonts.default_size'                : "10pt",

        # Downloads Directory
        'downloads.location.directory'      : '/HDD/Downloads',

        # UI
        # 'colors.webpage.bg'                 : 'black',
        # 'colors.webpage.darkmode.enabled'   : True,
        'tabs.show'                         : 'multiple',
        'scrolling.smooth'                  : True,
        'content.notifications.presenter'   : 'libnotify',
        'content.notifications.show_origin' : False,

        # Misc
        'editor.command'                    : ['st', '-c', 'StFloat', 'nvim', '-f','{file}', '-c', 'normal {line}G{column0}l'],
        'auto_save.session'                 : True,
        'content.pdfjs'                     : True,
        'content.blocking.enabled'          : True,
        'content.blocking.method'           : 'adblock',
        'spellcheck.languages'              : ["en-GB", "el-GR"],

        # Adblock lists
        'content.blocking.adblock.lists'    : [
                                                "https://easylist.to/easylist/easylist.txt", 
                                                "https://easylist.to/easylist/easyprivacy.txt",
                                                "https://easylist.to/easylist/fanboy-annoyance.txt",
                                                "https://easylist.to/easylist/fanboy-social.txt",
                                                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
                                                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",
                                                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
                                                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
                                                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
                                                "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
                                                "https://raw.githubusercontent.com/kargig/greek-adblockplus-filter/master/void-gr-filters.txt",
                                                "https://gitlab.com/Sorrow-San/9anime-adblock-filters/raw/master/9Anime%20filter%20list"
                                              ]
}

for bind, action in keybinds.items():
    config.bind(bind, action)

for setting, value in settings.items():
    config.set(setting, value)
