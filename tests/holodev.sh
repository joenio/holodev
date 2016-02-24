#!/bin/sh

test_code_returned_by_holodev_without_no_arguments() {
  ./holodev > /dev/null 2>&1
  assertEquals "should return '2' when has no arguments in command line!" 2 $?
}

test_code_returned_by_holodev_with_invalid_arguments() {
  ./holodev invalid-crazy-argument > /dev/null 2>&1
  assertEquals "should return '3' for invalid arguments!" 3 $?
}
