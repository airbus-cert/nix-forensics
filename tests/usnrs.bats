setup_file() {
	wget -OUSN https://github.com/janstarke/usnjrnl/raw/ffa92d4f8ad8bffdefdc078b9d17c47a12ef2e75/tests/data/sample1.bin
}

teardown_file() {
	rm -f USN
}

setup() {
	bats_load_library bats-support
	bats_load_library bats-assert
}

@test "Bodyfile output" {
	run -0 usnrs-cli --start 0 -f bodyfile USN

	assert_equal $(echo "$output" | wc -l) 104
}

@test "Regular output" {
	run -0 usnrs-cli --start 0 USN

	assert_equal $(echo "$output" | wc -l) 104
}
