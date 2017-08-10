prim ffi
primReadDataFrom: streamId into: buffer size: bufferSize
	"Attempt to read data from an active channel stream. All channel streams have one standard I/O substream (streamId == 0), and may have up to 2^32 extended data streams as identified by the selected stream_id. The SSH2 protocol currently defines a stream ID of 1 to be the stderr substream.
		streamId - substream ID number (e.g. 0 or SSH_EXTENDED_DATA_STDERR)
		buf - pointer to storage buffer to read data into"
		
	^self ffiCall: #(int libssh2_channel_read_ex(self, int streamId, char *buffer, int bufferSize))