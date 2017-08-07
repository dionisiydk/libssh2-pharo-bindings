controlling
free
	^self ffiCall: #(int libssh2_session_free(self))