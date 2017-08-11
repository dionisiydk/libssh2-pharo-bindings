API
writeOutputData: aByteArray
	
	| buffer writtenSize |
	buffer := aByteArray.
	[writtenSize := self 
			primWriteDataInto: 0 "standard I/O substream"
			from: buffer size: buffer size.
	writtenSize > 0 and: [ writtenSize < buffer size]]
		whileTrue: [ buffer := buffer allButFirst: writtenSize ].
	
	writtenSize <= 0 ifTrue: [ self error: 'Data write failed with ', writtenSize asString ]