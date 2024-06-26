setup() {
  bats_load_library bats-support
  bats_load_library bats-assert
}

setup_file() {
  wget -Oyarp-1.0.33.tar.gz "https://github.com/msuhanov/yarp/archive/refs/tags/1.0.33.tar.gz"
  tar -xzf yarp-1.0.33.tar.gz
  rm yarp-1.0.33.tar.gz
}

teardown_file() {
  rm -rf yarp-1.0.33
}

@test "Hive flushing" {
  run -0 registryFlush.py -f yarp-1.0.33/hives_for_tests/NewDirtyHive1/NewDirtyHive
}
