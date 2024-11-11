Class {
	#name : 'LibSSH2Channel',
	#superclass : 'FFIExternalStructure',
	#category : 'LibSSH2',
	#package : 'LibSSH2'
}

{ #category : 'API' }
LibSSH2Channel >> close [
	
	^self ffiCall: #(int libssh2_channel_close(self))
]

{ #category : 'API' }
LibSSH2Channel >> execCommand: commandLine [
	| error |
	[error := self 
		primStartupProcess: 'exec' size: 'exec' size message: commandLine size: commandLine size]
		doWhileTrue: [ error = -9 ].
		
	error = 0 ifFalse: [ self error: 'SSH2 command failed: ', error asString ]
]

{ #category : 'library path' }
LibSSH2Channel >> ffiLibraryName [
	^LibSSH2Library 
]

{ #category : 'prim ffi' }
LibSSH2Channel >> primReadDataFrom: streamId into: buffer size: bufferSize [
	"Attempt to read data from an active channel stream. All channel streams have one standard I/O substream (streamId == 0), and may have up to 2^32 extended data streams as identified by the selected stream_id. The SSH2 protocol currently defines a stream ID of 1 to be the stderr substream.
		streamId - substream ID number (e.g. 0 or SSH_EXTENDED_DATA_STDERR)
		buffer - pointer to storage buffer to read data into"
		
	^self ffiCall: #(int libssh2_channel_read_ex(self, int streamId, char *buffer, int bufferSize))
]

{ #category : 'prim ffi' }
LibSSH2Channel >> primStartupProcess: commandType size: commandTypeSize message: command size: commandSize [
	"Request a shell on a channel with parameters:
		commandType - Type of process to startup. The SSH2 protocol currently defines shell, exec, and 	subsystem as standard process services.
		command - Request specific message data to include"
		
	^self ffiCall: #(int libssh2_channel_process_startup(self,
                                     char* commandType,
                                     int commandTypeSize,
                                     char* command, int commandSize))
]

{ #category : 'prim ffi' }
LibSSH2Channel >> primWriteDataInto: streamId from: buffer size: bufferSize [
	"Write data to a channel stream. All channel streams have one standard I/O substream (stream_id == 0), and may have up to 2^32 extended data streams as identified by the selected stream_id. The SSH2 protocol currently defines a stream ID of 1 to be the stderr substream.
		streamId - substream ID number (e.g. 0 or SSH_EXTENDED_DATA_STDERR)
		buffer - pointer to buffer to write data from"
		
	^self ffiCall: #(int libssh2_channel_write_ex(self, int streamId, char* buffer, int bufferSize))
]

{ #category : 'API' }
LibSSH2Channel >> readInputData [
	
	| buffer readSize |
	^String streamContents: [ :s | 
		[buffer := ByteArray new: 4000.
		[readSize := self 
			primReadDataFrom: 0 "standard I/O substream"
			into: buffer size: buffer size] doWhileTrue: [readSize = -9].
		readSize > 0] whileTrue: [ s nextPutAll: (buffer first: readSize) asString ].
		readSize < 0 ifTrue: [self error: 'Data write failed with ', readSize asString ]
	]
]

{ #category : 'API' }
LibSSH2Channel >> writeOutputData: aByteArray [
	
	| buffer writtenSize |
	buffer := aByteArray.
	[
	[writtenSize := self 
			primWriteDataInto: 0 "standard I/O substream"
			from: buffer size: buffer size] doWhileTrue: [writtenSize = -9].
	writtenSize > 0 and: [ writtenSize < buffer size]]
		whileTrue: [ buffer := buffer allButFirst: writtenSize ].
	
	writtenSize <= 0 ifTrue: [ self error: 'Data write failed with ', writtenSize asString ]
]
