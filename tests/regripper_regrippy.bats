# Common test file because they're using the same fixture

setup_file() {
	wget -OSYSTEM https://github.com/EricZimmerman/Registry/raw/8c3ee3b00b0863c4353dbd020463d997c2e4b3fe/Registry.Test/Hives/SYSTEM
}

teardown_file() {
	rm -f SYSTEM
}

setup() {
	bats_load_library bats-support
	bats_load_library bats-assert
}

@test "[Regripper] Extract computer name" {
	run -0 regripper -p compname -r SYSTEM
	assert_line --partial HAXOR4
}

@test "[Regrippy] Extract computer name with regrip.py" {
	run -0 --separate-stderr regrippy -y SYSTEM compname
	assert_output "HAXOR4"
}

@test "[Regrippy] Extract computer name with reg_compname" {
	run -0 --separate-stderr reg_compname -y SYSTEM

	assert_output "HAXOR4"
}
