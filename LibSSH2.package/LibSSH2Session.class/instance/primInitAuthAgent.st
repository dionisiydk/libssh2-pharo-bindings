prim ffi
primInitAuthAgent
	^self ffiCall: #(LibSSH2Agent* libssh2_agent_init(self))