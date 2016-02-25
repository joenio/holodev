#!/bin/sh

oneTimeSetUp() {
  ./holodev setup
}

test_code_returned_by_holodev_without_no_arguments() {
  ./holodev > /dev/null 2>&1
  assertEquals "should return '2' when has no arguments in command line!" 2 $?
}

test_code_returned_by_invalid_arguments() {
  ./holodev invalid-crazy-argument > /dev/null 2>&1
  assertEquals "should return '3' for invalid arguments!" 3 $?
}

test_code_returned_by_valid_arguments() {
  ./holodev info > /dev/null 2>&1
  assertEquals "should return '0' for valid arguments!" 0 $?
}

test_create_and_destroy_container_with_default_options() {
  ./holodev create > /dev/null 2>&1
  assertEquals "should create LXC container!" 0 $?
  ./holodev destroy > /dev/null 2>&1
  assertEquals "should destroy LXC container!" 0 $?
}

test_create_container_and_mount_the_current_directory_into_container() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  touch file.txt
  $WORKING_DIR/holodev create > /dev/null 2>&1
  COUNT=`$WORKING_DIR/holodev run ls | grep --count file.txt`
  assertEquals "'file.txt' exists in the LXC container!" 1 $COUNT
  $WORKING_DIR/holodev destroy > /dev/null 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}
