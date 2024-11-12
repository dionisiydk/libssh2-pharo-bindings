Class {
	#name : 'LibSSH2Agent',
	#superclass : 'FFIExternalStructure',
	#category : 'LibSSH2',
	#package : 'LibSSH2'
}

{ #category : 'API' }
LibSSH2Agent >> authenticateUser: userName [
	| key error |

	error := self primConnect.
	error = 0 ifFalse: [ self primError: error].
	
	key := self findFirstKey.
	[
		[error := self primAuthUser: userName with: key] doWhileTrue: [error = -9].
		error = 0 | (error = -18) ifFalse: [ self primError: error ].
		error = -18
	] whileTrue: [ self loadNextKey: key ]
]

{ #category : 'API' }
LibSSH2Agent >> authenticateUser: userName usingKeyNamed: privateKeyName [
	| key error |

	error := self primConnect.
	error = 0 ifFalse: [ self primError: error].
	
	key := self findKeyNamed: privateKeyName.

	[error := self primAuthUser: userName with: key] doWhileTrue: [error = -9].
	error = 0 ifFalse: [ self primError: error ]
]

{ #category : 'library path' }
LibSSH2Agent >> ffiLibraryName [
	^LibSSH2Library 
]

{ #category : 'private' }
LibSSH2Agent >> findFirstKey [
	| error key |
	error := self primListIdentities.
	error = 0 ifFalse: [ self primError: error ].
	
	key := LibSSH2Key externalNew.
	error := self primLoadIdentityInto: key getHandle  previousKey: nil.
	error = 0 ifFalse: [ self primError: error ].

	^key
]

{ #category : 'private' }
LibSSH2Agent >> findKeyNamed: keyName [
	| error key |
	error := self primListIdentities.
	error = 0 ifFalse: [ self primError: error ].
	
	key := self findFirstKey.
	[(Path from: key printComment) basename = keyName] 
		whileFalse: [ self loadNextKey: key ].		

	^key
]

{ #category : 'API' }
LibSSH2Agent >> free [
	^self ffiCall: #(int libssh2_agent_free(self))
]

{ #category : 'private' }
LibSSH2Agent >> loadNextKey: aKey [
	| error |

	error := self primLoadIdentityInto: aKey getHandle previousKey: aKey.
	error = 0 ifFalse: [ self primError: error ].

]

{ #category : 'prim ffi' }
LibSSH2Agent >> primAuthUser: userName with: key [
	
	^self ffiCall: #(int libssh2_agent_userauth(self, String userName, LibSSH2Key * key))
]

{ #category : 'prim ffi' }
LibSSH2Agent >> primConnect [
	
	^self ffiCall: #(int libssh2_agent_connect(self))
]

{ #category : 'private' }
LibSSH2Agent >> primError: errorCode [
	self error: 'Agent ffi call failed: ', errorCode asString
]

{ #category : 'prim ffi' }
LibSSH2Agent >> primListIdentities [
	
	^self ffiCall: #(int libssh2_agent_list_identities(self))
]

{ #category : 'prim ffi' }
LibSSH2Agent >> primLoadIdentityInto: storePtr previousKey: previousStore [
	
	^self ffiCall: #(int libssh2_agent_get_identity(self, void ** storePtr, LibSSH2Key * previousStore))
]
