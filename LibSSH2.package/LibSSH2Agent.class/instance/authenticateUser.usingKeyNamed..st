API
authenticateUser: userName usingKeyNamed: publicKeyName
	| key error |

	error := self primConnect.
	error = 0 ifFalse: [ self primError: error].
	
	key := self findPublicKeyNamed: publicKeyName.

	[error := self primAuthUser: userName with: key] doWhileTrue: [error = -9].
	error = 0 ifFalse: [ self primError: error ]