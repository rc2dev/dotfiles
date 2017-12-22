#!/bin/sh
VBoxManage list vms -s | awk -F'"' '{print $2}' > vbox.txt
