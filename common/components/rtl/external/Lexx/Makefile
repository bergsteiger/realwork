#######################################################################  
#       GNU makefile for Pascal yacc and lex 
#        (with Free Pascal compiler)
#######################################################################

# Compiler to use
PP=ppc386

# Compiler version
VERSION=0.99.14

# Install prefix (this should match the directory where you installed fpc)
PREFIX=/usr

# options to pass (needed options are added by makefile)
OPT=-OG2p3 -Xs

#######################################################################
# Probably no need to change these.
#######################################################################

# Where are the Units ?
UNITDIR=$(PREFIX)/lib/fpc/$(VERSION)/units/linux/

# Where to install binaries ?
BININSTALLDIR=$(PREFIX)/bin

# Where to install the lexlib and yacclib units ?
UNITINSTALLDIR=$(PREFIX)/lib/fpc/$(VERSION)/units/linux/

# Where to install .cod files ?
CODINSTALLDIR=$(PREFIX)/lib/fpc/lexyacc

#######################################################################
# No need to edit below this line.
#######################################################################

# General stuff
OBJECTS = pyacc plex 
CODFILES = yylex.cod yyparse.cod
LEXYACCNAMES = lexlib yacclib
LEXYACCUNITS = $(addsuffix .ppu, $(LEXYACCNAMES))
LEXYACCOBJECTS = $(addsuffix .o, $(LEXYACCNAMES))
LEXYACCSOURCES = $(addsuffix .pas, $(LEXYACCNAMES))

.PHONY: all install clean
.SUFFIXES: .pas .ppu

# Add needed options
override OPT:=$(OPT) -Sg -Fu$(UNITDIR)

# Default rule for units

.pas.ppu:
	$(PP) $(OPT) $<

all: $(OBJECTS) $(LEXYACCUNITS)

pyacc: yacc.pas $(LEXYACCUNITS)
	sed s:/usr/lib/fpc/lexyacc:$(CODINSTALLDIR): <yacc.pas >yacc.sed
	mv -f yacc.sed yacc.pas
	$(PP) $(OPT) yacc.pas
	mv -f yacc pyacc

plex: lex.pas $(LEXYACCUNITS)
	sed s:/usr/lib/fpc/lexyacc:$(CODINSTALLDIR): <lex.pas >lex.sed
	mv -f lex.sed lex.pas
	$(PP) $(OPT) lex.pas
	mv -f lex plex

test:
	sed s:/usr/lib/fpc/lexyacc:$(CODINSTALLDIR): <yacc.y >yacc.sed
	mv -f yacc.sed yacc.y
	pyacc yacc.y test.pas
	diff yacc.pas test.pas

clean:
	-rm -f *.o *.ppu test.pas core $(OBJECTS)

install: all
	install -m 755 -d $(BININSTALLDIR)
	install -m 755 $(OBJECTS) $(BININSTALLDIR)
	install -m 755 -d $(UNITINSTALLDIR)
	install -m 666 $(LEXYACCUNITS) $(LEXYACCOBJECTS) $(UNITINSTALLDIR)
	install -m 755 -d $(CODINSTALLDIR)
	install -m 666 $(CODFILES) $(LEXYACCSOURCES) $(CODINSTALLDIR)
