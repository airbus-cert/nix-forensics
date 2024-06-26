@test "libvmdk" {
	run -0 vmdkinfo -h
}

@test "libvshadow" {
	run -0 vshadowinfo -h
}

@test "libvhdi" {
	run -0 vhdiinfo -h
}

@test "libmsiecf" {
	run -0 msiecfinfo -h
}

@test "liblnk" {
	run -0 lnkinfo -h
}

@test "libesedb" {
	run -0 esedbinfo -h
}
