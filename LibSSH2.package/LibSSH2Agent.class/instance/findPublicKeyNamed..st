private
findPublicKeyNamed: keyName
	| error key |
	error := self primListIdentities.
	error = 0 ifFalse: [ self primError: error ].
	
	key := self findPublicKey.
	[(Path from: key printComment) basename = keyName] 
		doWhileFalse: [ self loadNextPublicKey: key ].		

	^key