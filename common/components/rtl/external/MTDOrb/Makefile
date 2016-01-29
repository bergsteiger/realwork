FPC=fpc
FPC_FLAGS=-Sd -Isrc -Fusrc/orb -Fusrc/orbint

targets=lib/libmtdorb.so idltopas/idltopas demo/codesets/Server demo/codesets/Client

all: ${targets}

lib/libmtdorb.so: lib/mtdorb.dpr

idltopas/idltopas: idltopas/idltopas.dpr

demo/codesets/Server: demo/codesets/Server.dpr
demo/codesets/Client: demo/codesets/Client.dpr

%: %.dpr
	${FPC} ${FPC_FLAGS} $^

lib%.so: %.dpr
	${FPC} ${FPC_FLAGS} $^

clean: 
	rm -f ${targets}
	find -iname \*.ppu -exec rm \{\} \;
