#!/bin/bash

echo ""

echo "`date`: RUNNING: brew update"
/usr/local/bin/brew update
echo "`date`: FINISHED: brew update"

echo ""

echo "`date`: RUNNING: brew upgrade"
/usr/local/bin/brew upgrade
echo "`date`: FINISHED: brew upgrade"

echo ""

echo "`date`: RUNNING: brew cleanup"
/usr/local/bin/brew cleanup
echo "`date`: FINISHED: brew cleanup"

echo ""

echo "All done! Enjoy a cold one! 🍺 "

echo ""
