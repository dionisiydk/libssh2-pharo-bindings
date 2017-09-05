API
readInputData
	
	| buffer readSize |
	^String streamContents: [ :s | 
		[buffer := ByteArray new: 4000.
		readSize := self 
			primReadDataFrom: 0 "standard I/O substream"
			into: buffer size: buffer size.
		readSize > 0] whileTrue: [ s nextPutAll: (buffer first: readSize) asString ].
		readSize < 0 ifTrue: [self error: 'Data write failed with ', readSize asString ]
	]