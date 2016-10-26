#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_create_xinetd_config_file() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create >> $LOGFILE 2>&1
  CONTAINER_NAME=$(basename $TEMP_DIR)
  if [ ! -e "/tmp/holodev-$CONTAINER_NAME.xinetd"  ]; then
    fail "xinetd config file /tmp/holodev-$CONTAINER_NAME.xinetd not-found"
  fi
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

test_create_xinetd_config_file_with_default_port() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create >> $LOGFILE 2>&1
  CONTAINER_NAME=$(basename $TEMP_DIR)
  if [ ! -e "/tmp/holodev-$CONTAINER_NAME.xinetd"  ]; then
    fail "xinetd config file /tmp/holodev-$CONTAINER_NAME.xinetd not-found"
  else
    PORT=$(grep port /tmp/holodev-$CONTAINER_NAME.xinetd | sed 's/.\+port.\+= //')
    assertEquals "xinetd port isn't 3000" 3000 $PORT
  fi
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

test_create_xinetd_config_file_with_3003_port() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create --bind 3003 >> $LOGFILE 2>&1
  CONTAINER_NAME=$(basename $TEMP_DIR)
  if [ ! -e "/tmp/holodev-$CONTAINER_NAME.xinetd"  ]; then
    fail "xinetd config file /tmp/holodev-$CONTAINER_NAME.xinetd not-found"
  else
    PORT=$(grep port /tmp/holodev-$CONTAINER_NAME.xinetd | sed 's/.\+port.\+= //')
    assertEquals "xinetd port isn't 3003" 3003 $PORT
  fi
  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR
}

test_xinetd_pidfile() {
  WORKING_DIR=`pwd`
  TEMP_DIR=`mktemp --directory`
  cd $TEMP_DIR
  $WORKING_DIR/holodev create >> $LOGFILE 2>&1
  CONTAINER_NAME=$(basename $TEMP_DIR)

  test -e /run/$CONTAINER_NAME.xinetd.pid
  assertEquals "xinetd pidfile doesn't exists" 0 $?

  $WORKING_DIR/holodev destroy >> $LOGFILE 2>&1
  cd $WORKING_DIR
  rm -rf $TEMP_DIR

  test -e /run/$CONTAINER_NAME.xinetd.pid
  assertEquals "xinetd pidfile exists" 1 $?
}

. shunit2
