prim ffi
primOpenChannelType: typeName size: typeNameSize windowSize: windowSize packetSize: packetSize message: message size: messageSize
	"Establish a generic session channel with parameters:
		channel_type - Channel type to open. Typically one of session, direct-tcpip, or tcpip-forward. The SSH2 protocol allowed for additional types including local, custom channel types.
		channel_type_len - Length of channel_type
		window_size - Maximum amount of unacknowledged data remote host is allowed to send before receiving an SSH_MSG_CHANNEL_WINDOW_ADJUST packet.
		packet_size - Maximum number of bytes remote host is allowed to send in a single SSH_MSG_CHANNEL_DATA or SSG_MSG_CHANNEL_EXTENDED_DATA packet.
		message - Additional data as required by the selected channel_type.
		message_len - Length of message parameter."
		
	^self ffiCall: #(LibSSH2Channel * libssh2_channel_open_ex(self, 
			char* typeName, int typeNameSize, 
			int windowSize, int packetSize, 
			char* message, int messageSize))