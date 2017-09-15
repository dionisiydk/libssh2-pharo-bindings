API
authenticateUser: userName
	| key error |

	error := self primConnect.
	error = 0 ifFalse: [ self primError: error].
	
	key := self findPublicKey.
	
	[error := self primAuthUser: 'git' with: key] doWhileTrue: [error = -9].
	error = 0 ifFalse: [ self primError: error ]