Class {
	#name : 'LibSSH2Key',
	#superclass : 'FFIExternalStructure',
	#classVars : [
		'OFFSET_BLOB',
		'OFFSET_BLOB_LEN',
		'OFFSET_COMMENT',
		'OFFSET_MAGIC',
		'OFFSET_NODE'
	],
	#category : 'LibSSH2',
	#package : 'LibSSH2'
}

{ #category : 'field definition' }
LibSSH2Key class >> fieldsDesc [
" self rebuildFieldAccessors "
	^ #(
		int magic;              "magic stored by the library" 
    	void* node;     "handle to the internal representation of key"
    	byte* blob;           "public key blob"
    	int blob_len;	"length of the public key blob "
	 	char* comment;        
		)
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> blob [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_BLOB) type: ExternalType byte asPointerType
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> blob: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_BLOB put: anObject getHandle.
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> blob_len [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_BLOB_LEN
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> blob_len: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_BLOB_LEN put: anObject
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> comment [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_COMMENT) type: ExternalType char asPointerType
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> comment: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_COMMENT put: anObject getHandle.
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> magic [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_MAGIC
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> magic: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_MAGIC put: anObject
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> node [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_NODE) type: ExternalType void asPointerType
]

{ #category : 'accessing structure variables' }
LibSSH2Key >> node: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_NODE put: anObject getHandle.
]

{ #category : 'printing' }
LibSSH2Key >> printComment [
	^self comment fromCString
]
