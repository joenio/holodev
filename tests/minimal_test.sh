#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_code_returned_by_holodev_without_no_arguments() {
  ./holodev >> $LOGFILE 2>&1
  assertEquals "shouldn't return '2'" 2 $?
}

test_code_returned_by_invalid_arguments() {
  ./holodev invalid-crazy-argument >> $LOGFILE 2>&1
  assertEquals "shouldn't return '3'" 3 $?
}

test_code_returned_by_valid_arguments() {
  ./holodev info >> $LOGFILE 2>&1
  assertEquals "shouldn't return '0'" 0 $?
}

. shunit2
