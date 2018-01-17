#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_create_container_and_copy_ssh_dot_files() {
  # skip test if ~/.ssh/config not exists
  [ -e ~/.ssh/config ] || startSkipping

  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev run ls /HOLODEV/.ssh/ | grep --count config`
  assertEquals "file '/HOLODEV/.ssh/config' doesn't exists" 1 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

. shunit2
