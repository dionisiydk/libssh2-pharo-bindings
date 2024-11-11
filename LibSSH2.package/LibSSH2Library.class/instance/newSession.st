API
newSession
	^self ffiCall: #(LibSSH2Session * libssh2_session_init_ex(NULL, NULL, NULL, NULL))