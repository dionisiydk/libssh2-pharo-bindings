API
free
	^self ffiCall: #(int libssh2_agent_free(self))