FPC=fpc
FPC_FLAGS=-Sd -I../../src -Fu../../src/orb -Fu../../src/orbint
IDLTOPAS=../../idltopas/idltopas
IDLTOPAS_FLAGS=-ns -guid

targets=Server Client 
idlout=hello.pas hello_int.pas

all: ${targets}

Server: Server.dpr hello
Client: Client.dpr hello
hello: hello.idl

%: %.dpr
	${FPC} ${FPC_FLAGS} $<

%: %.idl
	${IDLTOPAS} ${IDLTOPAS_FLAGS} $<
	
clean: 
	rm -f ${targets} ${idlout} *.o *.ppu idltopas.ini
