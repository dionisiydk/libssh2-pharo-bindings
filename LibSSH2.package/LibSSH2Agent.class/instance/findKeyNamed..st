private
findKeyNamed: keyName
	| error key |
	error := self primListIdentities.
	error = 0 ifFalse: [ self primError: error ].
	
	key := self findFirstKey.
	[(Path from: key printComment) basename = keyName] 
		whileFalse: [ self loadNextKey: key ].		

	^key