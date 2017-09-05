prim ffi
primListIdentities
	
	^self ffiCall: #(int libssh2_agent_list_identities(self))