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

test_container_name_under_git_repository() {
  cd tests; tar -xf repository.tar; cd repository
  CONTAINER_NAME=$(../../holodev info 2> /dev/null | sed 's/.\+info about //' | sed "s/'//g")
  COUNT=$(echo $CONTAINER_NAME | grep -c 'repository-master')
  assertEquals "container name '$CONTAINER_NAME' isn't 'repository-master'" 1 $COUNT
  cd ..; rm -rf repository; cd ..
}

test_container_name_under_directory() {
  cd tests/directory
  CONTAINER_NAME=$(../../holodev info 2> /dev/null | sed 's/.\+info about //' | sed "s/'//g")
  COUNT=$(echo $CONTAINER_NAME | grep -c 'directory')
  assertEquals "container name '$CONTAINER_NAME' isn't 'directory'" 1 $COUNT
}

. shunit2
