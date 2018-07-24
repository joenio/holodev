#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_create_and_list_snapshot_snap0() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create >> $LOGFILE 2>&1
  $WORKING_DIR/holodev snapshot >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev snapshot -- -L | grep --count -e 'snap0'`
  assertEquals "snapshot 'snap0' not found" 1 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

test_restore_snapshot_snap0() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create >> $LOGFILE 2>&1
  $WORKING_DIR/holodev snapshot >> $LOGFILE 2>&1
  $WORKING_DIR/holodev run touch /HOLODEV/snapshot.txt 2>&1
  COUNT=`$WORKING_DIR/holodev run ls /HOLODEV | grep --count snapshot.txt`
  assertEquals "file /HOLODEV/snapshot.txt not found in snapshot snap0" 1 $COUNT
  $WORKING_DIR/holodev snapshot -- -r snap0 >> $LOGFILE 2>&1
  COUNT=`$WORKING_DIR/holodev run ls /HOLODEV | grep --count snapshot.txt`
  assertEquals "file /HOLODEV/snapshot.txt found in snapshot snap0, but it shouldn't exist" 0 $COUNT
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

. shunit2
