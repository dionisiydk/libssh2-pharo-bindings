prim ffi
primLoadIdentityInto: storePtr previousKey: previousStore
	
	^self ffiCall: #(int libssh2_agent_get_identity(self, void * storePtr, LibSSH2PublicKey * previousStore))