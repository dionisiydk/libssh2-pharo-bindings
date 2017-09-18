API
authenticateWithAgent: userName

	| agent |
	agent := self primInitAuthAgent.
	agent authenticateUser: userName.
	agent free