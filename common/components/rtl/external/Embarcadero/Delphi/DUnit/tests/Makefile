#$Id: Makefile,v 1.2 2013/05/24 13:30:13 lulin Exp $
ROOT=..

include $(ROOT)\\Rules.mak

bin:
	-$(MKDIR) $(BIN_DIR)
	$(DCC) -B -E$(BIN_DIR) UnitTests.dpr

test:
	$(DCC) -CC -B UnitTests.dpr
	$(BIN_DIR)\\UnitTests.exe -text-mode
