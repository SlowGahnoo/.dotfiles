#!/usr/bin/env python2
from subprocess import check_output

def get_pass(account):
    return check_output("pass " + account, shell = True).splitlines()[0]


if __name__ == "__main__":
    print(get_pass())
