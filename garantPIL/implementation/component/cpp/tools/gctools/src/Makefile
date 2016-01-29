PLATFORM=none

targets=sttop.cpp sources.cpp classes.cpp gcini.cpp belongs.cpp \
	    complect.cpp blobtable.h depend

all: $(targets)

clean:
distclean: clean
	rm -f makefile.dep

flex: sources.cpp blobtable.cpp normfile.cpp loadStringMap.cpp classes.cpp sttop.cpp kwfile.cpp gcini.cpp belongs.cpp complect.cpp

sources.cpp: ./sources.flex
	flex -o$@ ./sources.flex

blobtable.cpp: ./blobtable.flex
	flex -o$@ ./blobtable.flex

normfile.cpp: ./normfile.flex
	flex -o$@ ./normfile.flex

loadStringMap.cpp: ./loadStringMap.flex
	flex -o$@ ./loadStringMap.flex

classes.cpp: ./classes.flex
	flex -o$@ ./classes.flex

sttop.cpp: ./sttop.flex
	flex -o$@ ./sttop.flex

kwfile.cpp: ./kwfile.flex
	flex -o$@ ./kwfile.flex

gcini.cpp: ./gcini.flex
	flex -o$@ ./gcini.flex

belongs.cpp: ./belongs.flex
	flex -o$@ ./belongs.flex

complect.cpp: ./complect.flex
	flex -o$@ ./complect.flex


