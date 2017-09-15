prim ffi
primUserAuth: userName size: nameSize publicKeyFromFile: publicKeyPath privateKeyFromFile: privateKeyPath password: privateKeyPassword

	^self ffiCall: #(int libssh2_userauth_publickey_fromfile_ex(LIBSSH2_SESSION *session,
                                            char *userName,
                                            int nameSize,
                                            char * publicKeyPath,
                                            char * privateKeyPath,
                                            char * privateKeyPassword);)