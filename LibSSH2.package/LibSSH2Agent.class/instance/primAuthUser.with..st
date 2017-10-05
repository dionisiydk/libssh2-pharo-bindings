prim ffi
primAuthUser: userName with: key
	
	^self ffiCall: #(int libssh2_agent_userauth(self, String userName, LibSSH2Key * key))