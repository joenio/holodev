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
  cd ../../
}

test_create_command_with_dummy_option() {
  HOLODEV_OUTPUT=$(./holodev create --dummy 2>&1)
  COUNT=$(echo $HOLODEV_OUTPUT | grep -c 'sudo .*lxc-create -n ')
  assertEquals "'create' command didn't run 'lxc-create'" 1 $COUNT
}

test_attach_command_with_dummy_option() {
  HOLODEV_OUTPUT=$(./holodev attach --dummy 2>&1)
  COUNT=$(echo $HOLODEV_OUTPUT | grep -c 'sudo lxc-attach \(--clear-env \)\?-n ')
  assertEquals "'attach' command didn't run 'lxc-attach'" 1 $COUNT
}

test_destroy_command_with_dummy_option() {
  HOLODEV_OUTPUT=$(./holodev destroy --dummy 2>&1)
  COUNT=$(echo $HOLODEV_OUTPUT | grep -c 'sudo lxc-destroy -n ')
  assertEquals "'destroy' command didn't run 'lxc-destroy'" 1 $COUNT
}

test_start_command_with_dummy_option() {
  HOLODEV_OUTPUT=$(./holodev start --dummy 2>&1)
  COUNT=$(echo $HOLODEV_OUTPUT | grep -c 'sudo lxc-start -n ')
  assertEquals "'start' command didn't run 'lxc-start'" 1 $COUNT
}

test_stop_command_with_dummy_option() {
  HOLODEV_OUTPUT=$(./holodev stop --dummy 2>&1)
  COUNT=$(echo $HOLODEV_OUTPUT | grep -c 'sudo lxc-stop -n ')
  assertEquals "'stop' command didn't run 'lxc-stop'" 1 $COUNT
}

test_list_command_with_dummy_option() {
  HOLODEV_OUTPUT=$(./holodev list --dummy 2>&1)
  COUNT=$(echo $HOLODEV_OUTPUT | grep -c 'sudo lxc-ls -1')
  assertEquals "'list' command didn't run 'lxc-ls'" 1 $COUNT
}

test_run_command_with_dummy_option_under_git_repository() {
  cd tests; tar -xf repository.tar; cd repository
  HOLODEV_OUTPUT=$(../../holodev run --dummy 'ls' 2>&1)
  COUNT=$(echo $HOLODEV_OUTPUT | grep -c "sudo lxc-attach \(--clear-env \)\?-n repository-master -- su - $USER -c ls")
  assertEquals "'run' command didn't run 'ls' under container" 1 $COUNT
  cd ..; rm -rf repository; cd ..
}

test_run_command_with_dummy_option_and_nobranch_under_git_repository() {
  cd tests; tar -xf repository.tar; cd repository
  HOLODEV_OUTPUT=$(../../holodev run --dummy --no-branch 'ls' 2>&1)
  COUNT=$(echo $HOLODEV_OUTPUT | grep -c "sudo lxc-attach \(--clear-env \)\?-n repository -- su - $USER -c ls")
  assertEquals "'run' command didn't run 'ls' under container" 1 $COUNT
  cd ..; rm -rf repository; cd ..
}

test_creating_dummy_i386_container() {
  HOLODEV_OUTPUT=$(./holodev create --dummy --arch i386 2>&1)
  COUNT=$(echo $HOLODEV_OUTPUT | grep -c 'sudo .*lxc-create -n .* -a i386')
  assertEquals "'create' command didn't pass '-a i386' option to 'lxc-create'" 1 $COUNT
}

. shunit2
