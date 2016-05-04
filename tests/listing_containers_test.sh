#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_list_containers() {
  ./holodev create >> $LOGFILE 2>&1
  assertEquals "can't create container" 0 $?
  NAME=`./holodev info | grep 'Name:' | sed 's/Name:\s\+//'`
  COUNT=`./holodev list | grep --count $NAME`
  assertEquals "container '$NAME' wasn't found on the list of containers" 1 $COUNT
  ./holodev destroy >> $LOGFILE 2>&1
  assertEquals "can't destroy container" 0 $?
}

. shunit2
