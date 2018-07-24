#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_create_container_setting_branch_passing_long_option() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  CONTAINER_NAME=$(basename $TEMP_DIR)-mybranch
  $WORKING_DIR/holodev create --branch mybranch >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev info --branch mybranch | grep --count "Name: .\+ $CONTAINER_NAME"`
  assertEquals "container '$CONTAINER_NAME' wasn't found" 1 $COUNT
  $WORKING_DIR/holodev destroy --branch mybranch >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

test_create_container_setting_branch_passing_short_option() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  CONTAINER_NAME=$(basename $TEMP_DIR)-mybranch
  $WORKING_DIR/holodev create -b mybranch >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev info -b mybranch | grep --count "Name: .\+ $CONTAINER_NAME"`
  assertEquals "container '$CONTAINER_NAME' wasn't found" 1 $COUNT
  $WORKING_DIR/holodev destroy -b mybranch >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

. shunit2
