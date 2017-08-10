prim ffi
primStartupProcess: commandType size: commandTypeSize message: command size: commandSize
	"Request a shell on a channel with parameters:
		commandType - Type of process to startup. The SSH2 protocol currently defines shell, exec, and 	subsystem as standard process services.
		command - Request specific message data to include"
		
	^self ffiCall: #(int libssh2_channel_process_startup(self,
                                     char* commandType,
                                     int commandTypeSize,
                                     char* command, int commandSize))