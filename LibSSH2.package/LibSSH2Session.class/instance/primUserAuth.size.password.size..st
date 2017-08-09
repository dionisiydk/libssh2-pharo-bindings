prim ffi
primUserAuth: userName size: nameSize password: password size: passSize

	^self ffiCall: #(int libssh2_userauth_password_ex(self, char* userName, int nameSize, char* password, int passSize, nil))