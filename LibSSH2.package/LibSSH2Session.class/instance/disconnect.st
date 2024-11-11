prim ffi
disconnect

	^self ffiCall: #(int libssh2_session_disconnect_ex(self, int 0, NULL, NULL))