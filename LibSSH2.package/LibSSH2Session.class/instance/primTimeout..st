prim ffi
primTimeout: milliSeconds

	^self ffiCall: #(void libssh2_session_set_timeout(self, long milliSeconds))