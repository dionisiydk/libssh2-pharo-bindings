# Pharo bindings to libssh2 library

## Installation 
```Smalltalk
Metacello new
  baseline: 'LibSSH2';
  repository: 'github://dionisiydk/libssh2-pharo-bindings';
  load.
```
Notice currently bindings are in very raw state. There are many issues.

So it is more prove of concept right now. 
## Create SSH session
First you should establish normal TCP connection to ssh server:
```Smalltalk
socket  := Socket newTCP.
socket connectTo: #[169 254 0 2] port: 22 waitForConnectionFor: secondsTimeout.
socket isConnected
		ifFalse: [ self error: 'Cannot connect to ', aTCPAddress printString ].
```
And then you are able create SSH session on your socket: 
```Smalltalk
lib := LibSSH2Library uniqueInstance.
lib init.
session := lib newSession.
session handshakeOn: socket.
session authenticate: 'login' password: 'password'.
```
Other auth methods is also supported:
- agent based authentication:
```Smalltalk
session authenticateWithAgent: 'login'.
```
- authentication with private and public keys:
```Smalltalk
session 
   authenticate: 'login' 
   withPublicKeyFrom: FileLocator home / '.ssh/rsa.pub' 
   privateKeyFrom: FileLocator home / '.ssh/rsa'
   password: '***'.
```
You can also check server fingerprint and supported auth methods:
```Smalltalk
session fingerprint. 
session printAuthMethodsFor: 'login'.  
```
Strangelly print method works only after second call. At first call it always return nll.

## Execute remote commands
```Smalltalk
channel := session openCommandChannel.
channel execCommand: 'ls'.
channel readInputData.
```
## Establish direct SSH tunnel to remote server
SSH tunnel gives you secure communication between your program and server.
Imaging that server 169.254.0.2 running some service on port 8080. Following script will send data to it using secure SSH channel:
```Smalltalk
channel := session openDirectTunnelTo: '169.254.0.2' port: 8080.
channel writeOutputData: 'hello', String crlf.
```
## Issues
Main issue now is strange -39 error on IO operations with opened channels.
When you will play with scripts you will see that only second created channel is working (command channel or tunnel channel, no matter).
In ssh2 docs "-39" is defined as LIBSSH2_ERROR_BAD_USE. But I not found actual reason for such behaviour.

## Cleaning resources
```Smalltalk
channel close.
session disconnect.
session free.
```
