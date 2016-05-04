#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_get_the_status_of_a_stopped_container() {
  ./holodev create >> $LOGFILE 2>&1
  assertEquals "can't create container" 0 $?
  ./holodev stop >> $LOGFILE 2>&1
  assertEquals "can't stop the container" 0 $?
  COUNT=`./holodev info | grep --count -e 'State:.\+STOPPED'`
  assertEquals "container doesn't have status = STOPPED" 1 $COUNT
  ./holodev destroy >> $LOGFILE 2>&1
  assertEquals "can't destroy container" 0 $?
}

. shunit2
