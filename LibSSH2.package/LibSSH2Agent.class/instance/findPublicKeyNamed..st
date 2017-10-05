private
findPublicKeyNamed: keyName
	| error key |
	error := self primListIdentities.
	error = 0 ifFalse: [ self primError: error ].
	
	key := self findFirstPublicKey.
	[(Path from: key printComment) basename = keyName] 
		whileFalse: [ self loadNextPublicKey: key ].		

	^key