prim ffi
primConnect
	
	^self ffiCall: #(int libssh2_agent_connect(self))