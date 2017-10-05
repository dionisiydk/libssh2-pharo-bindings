API
authenticateUser: userName usingKeyNamed: privateKeyName
	| key error |

	error := self primConnect.
	error = 0 ifFalse: [ self primError: error].
	
	key := self findKeyNamed: privateKeyName.

	[error := self primAuthUser: userName with: key] doWhileTrue: [error = -9].
	error = 0 ifFalse: [ self primError: error ]