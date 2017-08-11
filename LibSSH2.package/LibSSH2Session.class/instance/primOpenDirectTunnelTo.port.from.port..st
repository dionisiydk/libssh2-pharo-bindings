prim ffi
primOpenDirectTunnelTo: remoteHost port: remotePort from: sourceHost port: sourcePort
	"Tunnel a TCP/IP connection through the SSH transport via the remote host to a third party. Communication from the client to the SSH server remains encrypted, communication from the server to the 3rd party host travels in cleartext
	remoteHost - Third party host to connect to using the SSH host as a proxy.
	remotePort - Port on third party host to connect to.
	sourceHost - Host to tell the SSH server the connection originated on.
	sourcePort - Port to tell the SSH server the connection originated from"
		
	^self ffiCall: #(LibSSH2Channel * libssh2_channel_direct_tcpip_ex(self, 
							char* remoteHost, int remotePort, 
							char* sourceHost, int sourcePort))