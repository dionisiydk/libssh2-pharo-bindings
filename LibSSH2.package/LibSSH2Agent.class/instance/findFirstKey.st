private
findFirstKey
	| error key |
	error := self primListIdentities.
	error = 0 ifFalse: [ self primError: error ].
	
	key := LibSSH2Key externalNew.
	error := self primLoadIdentityInto: key getHandle  previousKey: nil.
	error = 0 ifFalse: [ self primError: error ].

	^key