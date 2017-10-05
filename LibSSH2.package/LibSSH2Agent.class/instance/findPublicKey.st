private
findPublicKey
	| error key |
	error := self primListIdentities.
	error = 0 ifFalse: [ self primError: error ].
	
	key := LibSSH2PublicKey externalNew.
	error := self primLoadIdentityInto: key getHandle  previousKey: nil.
	error := self primLoadIdentityInto: key getHandle  previousKey: key.
	error = 0 ifFalse: [ self primError: error ].

	^key