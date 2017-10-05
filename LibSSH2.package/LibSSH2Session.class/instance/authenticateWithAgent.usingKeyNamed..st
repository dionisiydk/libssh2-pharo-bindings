API
authenticateWithAgent: userName usingKeyNamed: privateKeyName

	| agent |
	agent := self primInitAuthAgent.
	agent authenticateUser: userName usingKeyNamed: privateKeyName.
	agent free