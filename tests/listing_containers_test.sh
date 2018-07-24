#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_list_containers() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create >> $LOGFILE 2>&1
  assertEquals "can't create container" 0 $?
  NAME=`$WORKING_DIR/holodev info | grep 'Name:' | sed 's/Name:\s\+//'`
  COUNT=`$WORKING_DIR/holodev list | grep --count ^$NAME$`
  assertEquals "container '$NAME' wasn't found on the list of containers" 1 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  assertEquals "can't destroy container" 0 $?
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

. shunit2
