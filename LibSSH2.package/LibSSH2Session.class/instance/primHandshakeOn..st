prim ffi
primHandshakeOn: osSocketHandle
	^self ffiCall: #(int libssh2_session_handshake(self, int osSocketHandle))