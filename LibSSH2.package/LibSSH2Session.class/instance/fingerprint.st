API
fingerprint
	"last argument is hash_type:
	#define LIBSSH2_HOSTKEY_HASH_MD5                            1
#define LIBSSH2_HOSTKEY_HASH_SHA1                           2
#define LIBSSH2_HOSTKEY_HASH_SHA256                         3"
	^((self primHostKeyHash: 1) collect: [ :each | each hex allButFirst: 3 ] as: Array)
		joinUsing: ':'