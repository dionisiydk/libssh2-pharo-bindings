accessing platform
init
	^self ffiCall: #(int libssh2_init(int32 0))