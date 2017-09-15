prim ffi
primAuthUser: userName with: key
	
	^self ffiCall: #(int libssh2_agent_userauth(self, char * userName, LibSSH2PublicKey * key))