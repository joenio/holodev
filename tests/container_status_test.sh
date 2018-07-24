#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_get_the_status_of_a_stopped_container() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create >> $LOGFILE 2>&1
  assertEquals "can't create container" 0 $?
  $WORKING_DIR/holodev stop >> $LOGFILE 2>&1
  assertEquals "can't stop the container" 0 $?
  COUNT=`$WORKING_DIR/holodev info | grep --count -e 'State:.\+STOPPED'`
  assertEquals "container doesn't have status = STOPPED" 1 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  assertEquals "can't destroy container" 0 $?
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

. shunit2
