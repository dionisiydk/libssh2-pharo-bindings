field definition
fieldsDesc
" self rebuildFieldAccessors "
	^ #(
		int magic;              "magic stored by the library" 
    	void* node;     "handle to the internal representation of key"
    	byte* blob;           "public key blob"
    	int blob_len;	"length of the public key blob "
	 	char* comment;        
		)