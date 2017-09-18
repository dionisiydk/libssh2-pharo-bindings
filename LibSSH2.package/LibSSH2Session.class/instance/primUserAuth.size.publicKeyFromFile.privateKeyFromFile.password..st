prim ffi
primUserAuth: userName size: nameSize publicKeyFromFile: publicKeyPath privateKeyFromFile: privateKeyPath password: privateKeyPassword

	^self ffiCall: #(int libssh2_userauth_publickey_fromfile_ex(self,
                                            char * userName,
                                            int nameSize,
                                            char * publicKeyPath,
                                            char * privateKeyPath,
                                            char * privateKeyPassword))