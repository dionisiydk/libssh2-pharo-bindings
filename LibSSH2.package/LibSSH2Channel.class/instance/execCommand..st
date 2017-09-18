API
execCommand: commandLine
	| error |
	[error := self 
		primStartupProcess: 'exec' size: 'exec' size message: commandLine size: commandLine size]
		doWhileTrue: [ error = -9 ].
		
	error = 0 ifFalse: [ self error: 'SSH2 command failed: ', error asString ]