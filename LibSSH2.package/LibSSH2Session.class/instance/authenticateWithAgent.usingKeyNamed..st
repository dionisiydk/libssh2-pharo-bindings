API
authenticateWithAgent: userName usingKeyNamed: publicKeyName

	| agent |
	agent := self primInitAuthAgent.
	agent authenticateUser: userName usingKeyNamed: publicKeyName.
	agent free