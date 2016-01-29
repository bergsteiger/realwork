#$Id: Makefile,v 1.1 2009/03/11 15:17:58 lulin Exp $
ROOT=..

include $(ROOT)\\Rules.mak

bin:
	-$(MKDIR) $(BIN_DIR)
	$(DCC) -B -E$(BIN_DIR) UnitTests.dpr

test:
	$(DCC) -CC -B UnitTests.dpr
	$(BIN_DIR)\\UnitTests.exe -text-mode
