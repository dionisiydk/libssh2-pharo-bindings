API
openDirectTunnelTo: remoteHost port: remotePort
	"Tunnel a TCP/IP connection through the SSH transport via the remote host to a third party. Communication from the client to the SSH server remains encrypted, communication from the server to the 3rd party host travels in cleartext
	remoteHost - Third party host to connect to using the SSH host as a proxy.
	remotePort - Port on third party host to connect to"
		
	^self primOpenDirectTunnelTo: remoteHost port: remotePort from: '' port: 0