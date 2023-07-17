#!/usr/bin/python2.7

from subprocess import Popen, PIPE
import time

BATTERY_THRESHOLD = 8

def is_charging():
    with open("/sys/class/power_supply/BAT0/status") as f:
        return True if f.read().strip('\n') == "Charging" else False


def check_capacity():
    with open("/sys/class/power_supply/BAT0/capacity") as f:
        return int(f.read())


while True:
    delay_interval_sec = 30
    if check_capacity() <= BATTERY_THRESHOLD and not is_charging():
        p = Popen(['osd_cat', \
                   '-A', 'center', \
                   '-p', 'middle', \
                   '-f', '-*-*-bold-*-*-*-96-120-*-*-*-*-*-*' ], stdin=PIPE)
        msg = "!!BATTEY LOW. REMAINING " + str(check_capacity()) + "%!!"
        p.communicate(input=msg)
        p.wait()
        # Drop delay, to solid notification.
        delay_interval_sec = 0

    time.sleep(delay_interval_sec)

