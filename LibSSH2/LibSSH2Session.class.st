Class {
	#name : 'LibSSH2Session',
	#superclass : 'FFIExternalStructure',
	#category : 'LibSSH2',
	#package : 'LibSSH2'
}

{ #category : 'field definition' }
LibSSH2Session class >> fieldsDesc [
	"self rebuildFieldAccessors"
	^ super fieldsDesc
]

{ #category : 'API' }
LibSSH2Session >> authenticate: userName password: password [

	| errorCode |
	[errorCode := self 
			primUserAuth: userName size: userName size 
			password: password size: password size] doWhileTrue: [ errorCode = -9 ].
	errorCode = 0 ifFalse: [ self error: 'SSH2 authentication failed with ', errorCode asString ]	
]

{ #category : 'API' }
LibSSH2Session >> authenticate: userName withPublicKeyFrom: publicKeyFile privateKeyFrom: privateKeyFile password: privateKeyPassword [
	| errorCode |
	[errorCode := self 
			primUserAuth: userName size: userName size 
			publicKeyFromFile: publicKeyFile pathString 
			privateKeyFromFile: privateKeyFile pathString password: privateKeyPassword] 
		doWhileTrue: [ errorCode = -9 ].
		
	errorCode = 0 ifFalse: [ self error: 'SSH2 authentication failed with ', errorCode asString ]	
]

{ #category : 'API' }
LibSSH2Session >> authenticateWithAgent: userName [

	| agent |
	agent := self primInitAuthAgent.
	agent authenticateUser: userName.
	agent free
]

{ #category : 'API' }
LibSSH2Session >> authenticateWithAgent: userName usingKeyNamed: privateKeyName [

	| agent |
	agent := self primInitAuthAgent.
	agent authenticateUser: userName usingKeyNamed: privateKeyName.
	agent free
]

{ #category : 'prim ffi' }
LibSSH2Session >> disconnect [

	^self ffiCall: #(int libssh2_session_disconnect_ex(self, int 0, NULL, NULL))
]

{ #category : 'library path' }
LibSSH2Session >> ffiLibraryName [
	^LibSSH2Library 
]

{ #category : 'API' }
LibSSH2Session >> fingerprint [
	"last argument is hash_type:
	#define LIBSSH2_HOSTKEY_HASH_MD5                            1
#define LIBSSH2_HOSTKEY_HASH_SHA1                           2
#define LIBSSH2_HOSTKEY_HASH_SHA256                         3"
	^((self primHostKeyHash: 1) collect: [ :each | each hex allButFirst: 3 ] as: Array)
		joinUsing: ':'
]

{ #category : 'API' }
LibSSH2Session >> free [
	^self ffiCall: #(int libssh2_session_free(self))
]

{ #category : 'API' }
LibSSH2Session >> handshakeOn: aSocket [
	| osHandle errorCode |
	osHandle := aSocket osSocketHandle.
	[(errorCode := self primHandshakeOn: osHandle) = -9] whileTrue. 
	errorCode = 0 ifFalse: [ 
		self error: 'SSH2 handshake failed with ', errorCode asString]
]

{ #category : 'API' }
LibSSH2Session >> openCommandChannel [
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
]

{ #category : 'API' }
LibSSH2Session >> openDirectTunnelTo: remoteHost port: remotePort [
	"Tunnel a TCP/IP connection through the SSH transport via the remote host to a third party. Communication from the client to the SSH server remains encrypted, communication from the server to the 3rd party host travels in cleartext
	remoteHost - Third party host to connect to using the SSH host as a proxy.
	remotePort - Port on third party host to connect to"
		
	^self primOpenDirectTunnelTo: remoteHost port: remotePort from: '' port: 0
]

{ #category : 'prim ffi' }
LibSSH2Session >> primDisconnectWith: aMessageString [

	^self ffiCall: #(int libssh2_session_disconnect(self, char *aMessageString))
]

{ #category : 'prim ffi' }
LibSSH2Session >> primHandshakeOn: osSocketHandle [
	^self ffiCall: #(int libssh2_session_handshake(self, int osSocketHandle))
]

{ #category : 'prim ffi' }
LibSSH2Session >> primHostKeyHash: hashType [
	"hash_type:
	#define LIBSSH2_HOSTKEY_HASH_MD5                            1
#define LIBSSH2_HOSTKEY_HASH_SHA1                           2
#define LIBSSH2_HOSTKEY_HASH_SHA256                         3"
	^self ffiCall: #(char* libssh2_hostkey_hash(self, int hashType))
]

{ #category : 'prim ffi' }
LibSSH2Session >> primInitAuthAgent [
	^self ffiCall: #(LibSSH2Agent* libssh2_agent_init(self))
]

{ #category : 'prim ffi' }
LibSSH2Session >> primOpenChannelType: typeName size: typeNameSize windowSize: windowSize packetSize: packetSize message: message size: messageSize [
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
]

{ #category : 'prim ffi' }
LibSSH2Session >> primOpenDirectTunnelTo: remoteHost port: remotePort from: sourceHost port: sourcePort [
	"Tunnel a TCP/IP connection through the SSH transport via the remote host to a third party. Communication from the client to the SSH server remains encrypted, communication from the server to the 3rd party host travels in cleartext
	remoteHost - Third party host to connect to using the SSH host as a proxy.
	remotePort - Port on third party host to connect to.
	sourceHost - Host to tell the SSH server the connection originated on.
	sourcePort - Port to tell the SSH server the connection originated from"
		
	^self ffiCall: #(LibSSH2Channel * libssh2_channel_direct_tcpip_ex(self, 
							char* remoteHost, int remotePort, 
							char* sourceHost, int sourcePort))
]

{ #category : 'prim ffi' }
LibSSH2Session >> primTimeout [

	^self ffiCall: #(long libssh2_session_get_timeout(self))
]

{ #category : 'prim ffi' }
LibSSH2Session >> primTimeout: milliSeconds [

	^self ffiCall: #(void libssh2_session_set_timeout(self, long milliSeconds))
]

{ #category : 'prim ffi' }
LibSSH2Session >> primUserAuth: userName size: nameSize password: password size: passSize [

	^self ffiCall: #(int libssh2_userauth_password_ex(self, char* userName, int nameSize, char* password, int passSize, nil))
]

{ #category : 'prim ffi' }
LibSSH2Session >> primUserAuth: userName size: nameSize publicKeyFromFile: publicKeyPath privateKeyFromFile: privateKeyPath password: privateKeyPassword [

	^self ffiCall: #(int libssh2_userauth_publickey_fromfile_ex(self,
                                            char * userName,
                                            int nameSize,
                                            char * publicKeyPath,
                                            char * privateKeyPath,
                                            char * privateKeyPassword))
]

{ #category : 'prim ffi' }
LibSSH2Session >> primUserAuthListFor: userName size: nameSize [

	^self ffiCall: #(char* libssh2_userauth_list(self, char* userName, int nameSize))
]

{ #category : 'API' }
LibSSH2Session >> printAuthMethodsFor: userName [

	^self primUserAuthListFor: userName size: userName size
]

{ #category : 'API' }
LibSSH2Session >> timeout [

	^self primTimeout milliSeconds
]

{ #category : 'API' }
LibSSH2Session >> timeout: aDuration [

	self primTimeout: aDuration asMilliSeconds
]
