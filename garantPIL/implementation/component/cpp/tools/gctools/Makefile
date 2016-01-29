
TARGETOS=src $(shell uname -s | tr "[A-Z]" "[a-z]")

all: makedirs

makedirs:
	@for p in $(TARGETOS); do \
		(cd $$p && $(MAKE) ) ;\
	done

clean:
	@for p in $(TARGETOS); do \
		(cd $$p && $(MAKE) clean ) ;\
	done

distclean:
	@for p in $(TARGETOS); do \
		(cd $$p && $(MAKE) distclean ) ;\
	done
