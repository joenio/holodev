#!/bin/sh

LOGFILE=/tmp/holodev-tests.log

oneTimeSetUp() {
  ./holodev setup
}

test_using_special_characters_under_container() {
  ./holodev create >> $LOGFILE 2>&1
  assertEquals "can't create container" 0 $?
  ./holodev run echo 'Métodos Ágeis' > utf8.txt 2>&1
  COUNT=$(cat utf8.txt | grep -x -c 'Métodos Ágeis')
  assertEquals "file content doesn't match 'Métodos Ágeis'" 1 $COUNT
  rm -f utf8.txt
  ./holodev destroy >> $LOGFILE 2>&1
  assertEquals "can't destroy container" 0 $?
}

. shunit2
