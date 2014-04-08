#!/bin/bash

set -eu

project=$1
files=$(find "$HOME/ros_ws/src/$project" -name '*.[ch]pp')

# Call uncrustify which formats the source code.
uncrustify -c uncrustify.cfg --replace --no-backup $files
