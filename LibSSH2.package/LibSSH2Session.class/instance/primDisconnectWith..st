prim ffi
primDisconnectWith: aMessageString

	^self ffiCall: #(int libssh2_session_disconnect(self, char *aMessageString))