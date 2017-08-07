accessing platform
init
	^self ffiCall: #(int libssh2_init(0))