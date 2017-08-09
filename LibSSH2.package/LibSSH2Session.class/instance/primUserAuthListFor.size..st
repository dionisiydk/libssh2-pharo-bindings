prim ffi
primUserAuthListFor: userName size: nameSize

	^self ffiCall: #(char* libssh2_userauth_list(self, char* userName, int nameSize))