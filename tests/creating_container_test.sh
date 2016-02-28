#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_create_and_destroy_container_with_default_options() {
  ./holodev create >> $LOGFILE 2>&1
  assertEquals "can't create container" 0 $?
  ./holodev destroy >> $LOGFILE 2>&1
  assertEquals "can't destroy container" 0 $?
}

test_create_container_and_mount_the_current_directory_into_container() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  touch file.txt
  $WORKING_DIR/holodev create >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev run ls | grep --count file.txt`
  assertEquals "'file.txt' doesn't exists" 1 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

. shunit2
