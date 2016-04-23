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
