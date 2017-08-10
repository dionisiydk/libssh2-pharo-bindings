API
close
	
	^self ffiCall: #(int libssh2_channel_close(self))