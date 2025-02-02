#!/bin/bash

i3-nagbar -t warning -m "You pressed the exit shortcut. This will end your DICE session and log out of $(hostname)." -B "Confirm, leave Appleton" 'i3-msg exit'
