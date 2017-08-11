prim ffi
primWriteDataInto: streamId from: buffer size: bufferSize
	"Write data to a channel stream. All channel streams have one standard I/O substream (stream_id == 0), and may have up to 2^32 extended data streams as identified by the selected stream_id. The SSH2 protocol currently defines a stream ID of 1 to be the stderr substream.
		streamId - substream ID number (e.g. 0 or SSH_EXTENDED_DATA_STDERR)
		buffer - pointer to buffer to write data from"
		
	^self ffiCall: #(int libssh2_channel_write_ex(self, int streamId, char* buffer, int bufferSize))