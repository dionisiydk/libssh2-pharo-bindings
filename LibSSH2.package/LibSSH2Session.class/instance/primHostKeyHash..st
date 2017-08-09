prim ffi
primHostKeyHash: hashType
	"hash_type:
	#define LIBSSH2_HOSTKEY_HASH_MD5                            1
#define LIBSSH2_HOSTKEY_HASH_SHA1                           2
#define LIBSSH2_HOSTKEY_HASH_SHA256                         3"
	^self ffiCall: #(char* libssh2_hostkey_hash(self, int hashType))