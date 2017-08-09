prim ffi
disconnect

	^self ffiCall: #(int libssh2_session_disconnect_ex(self, 0, nil, nil))