Extension { #name : 'Socket' }

{ #category : '*LibSSH2' }
Socket >> osSocketHandle [
	^(socketHandle pointerAt: 9) signedLongAt: 1
]
