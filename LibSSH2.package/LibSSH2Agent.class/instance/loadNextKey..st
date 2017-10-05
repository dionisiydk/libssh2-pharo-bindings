private
loadNextKey: aKey
	| error |

	error := self primLoadIdentityInto: aKey getHandle previousKey: aKey.
	error = 0 ifFalse: [ self primError: error ].
