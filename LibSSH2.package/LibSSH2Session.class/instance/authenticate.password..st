API
authenticate: userName password: password

	| errorCode |
	[errorCode := self 
			primUserAuth: userName size: userName size 
			password: password size: password size] doWhileTrue: [ errorCode = -9 ].
	errorCode = 0 ifFalse: [ self error: 'SSH2 authentication failed with ', errorCode asString ]	