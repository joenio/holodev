#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_create_DebianJessie_container_using_long_option() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create --release jessie >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev run cat /etc/debian_version | grep --count "8.\|jessie"`
  assertEquals "container file '/etc/debian_version' doesn't match '8.|jessie'" 1 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

test_create_DebianJessie_container_using_short_option() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create -r jessie >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev run cat /etc/debian_version | grep --count "8.\|jessie"`
  assertEquals "container file '/etc/debian_version' doesn't match '8.|jessie'" 1 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

. shunit2
