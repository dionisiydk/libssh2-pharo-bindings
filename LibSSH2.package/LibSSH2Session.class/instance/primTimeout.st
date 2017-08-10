prim ffi
primTimeout

	^self ffiCall: #(long libssh2_session_get_timeout(self))