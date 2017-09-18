API
authenticate: userName withPublicKeyFrom: publicKeyFile privateKeyFrom: privateKeyFile password: privateKeyPassword
	| errorCode |
	[errorCode := self 
			primUserAuth: userName size: userName size 
			publicKeyFromFile: publicKeyFile pathString 
			privateKeyFromFile: privateKeyFile pathString password: privateKeyPassword] 
		doWhileTrue: [ errorCode = -9 ].
		
	errorCode = 0 ifFalse: [ self error: 'SSH2 authentication failed with ', errorCode asString ]	