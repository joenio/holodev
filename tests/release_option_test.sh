#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_create_DebianStretch_container_using_long_option() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create --release stretch >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev run cat /etc/debian_version | grep --count stretch`
  assertEquals "container file '/etc/debian_version' doesn't match 'stretch'" 1 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

test_create_DebianStretch_container_using_short_option() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create -r stretch >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev run cat /etc/debian_version | grep --count stretch`
  assertEquals "container file '/etc/debian_version' doesn't match 'stretch'" 1 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

. shunit2
