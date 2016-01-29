#$Id: Makefile,v 1.1 2009/03/11 15:17:05 lulin Exp $
ROOT=..\..

include $(ROOT)\Rules.mak

structure:
	$(DCC) -B -CC testXpgen.dpr 
	$(BIN_DIR)\testXpgen.exe

guitest:
	$(DCC) -B -CG testXpgen.dpr 
	$(BIN_DIR)\testXpgen.exe  
