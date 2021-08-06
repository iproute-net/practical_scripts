#!/bin/bash
# The script help you to extract all information you need to add in the udev rules and make ethernet cards permanent
for f in /sys/class/net/*; do
    dev=$(basename $f)
    driver=$(readlink $f/device/driver/module)
    if [ $driver ]; then
        driver=$(basename $driver)
    fi
    if [ $driver ]; then
    addr=$(cat $f/address)
    kernel_id=$(grep PCI_SLOT_NAME $f/device/uevent | cut -d= -f2- )
    operstate=$(cat $f/operstate)
    printf "%10s [%s]: [%s] %10s (%s)\n" "$dev" "$addr" "$kernel_id" "$driver" "$operstate"
    fi
done
