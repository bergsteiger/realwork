#$Id: Makefile,v 1.2 2013/05/24 13:29:54 lulin Exp $
ROOT=..\..

include $(ROOT)\Rules.mak

structure:
	$(DCC) -B -CC testXpgen.dpr 
	$(BIN_DIR)\testXpgen.exe

guitest:
	$(DCC) -B -CG testXpgen.dpr 
	$(BIN_DIR)\testXpgen.exe  
