API
openCommandChannel
	| channel |
	channel := self 
		primOpenChannelType: 'session' size: 'session' size
		windowSize: 2*1024*1024 "LIBSSH2_CHANNEL_WINDOW_DEFAULT"
		packetSize: 32768 "LIBSSH2_CHANNEL_PACKET_DEFAULT"
		message: nil size: 0.
	channel close. "somehow only second channel is working"
	^self 
		primOpenChannelType: 'session' size: 'session' size
		windowSize: 2*1024*1024 "LIBSSH2_CHANNEL_WINDOW_DEFAULT"
		packetSize: 32768 "LIBSSH2_CHANNEL_PACKET_DEFAULT"
		message: nil size: 0.