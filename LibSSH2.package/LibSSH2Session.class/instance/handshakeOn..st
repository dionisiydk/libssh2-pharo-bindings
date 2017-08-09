controlling
handshakeOn: aSocket
	| osHandle errorCode |
	osHandle := aSocket osSocketHandle.
	[(errorCode := self primHandshakeOn: osHandle) = -9] whileTrue. 
	errorCode = 0 ifFalse: [ 
		self error: 'SSH2 handshake failed with ', errorCode asString]