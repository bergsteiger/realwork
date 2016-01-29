PLATFORM=solaris.x86.sunspro

include ../src/makefile.inc

libs = $(EXTRA_LIBS)

LDFLAGS+=-lCrun

VPATH=../src


.PHONY: clean

targets = gready gkdumpi gkdbcmp gkgetdoc gattrfix gkdbchkstr gktouch gready gsetrev

all: $(targets) 

gktouch: $(gktouch_o) $(libs)
	$(CC) -o $@ $(gktouch_o) $(LDFLAGS)

g_avral: $(g_avral_o) $(libs)
	$(CC) -o $@ $(g_avral_o) $(LDFLAGS)

gdoc2rtf: $(gdoc2rtf_o) $(libs) malloc.o
	$(CC) -o $@ $(gdoc2rtf_o) malloc.o $(LDFLAGS)


gkdumpi: $(gkdumpi_o) $(libs)
	$(CC) -o $@ $(gkdumpi_o) $(LDFLAGS)

gkdbchkstr: $(gkdbchkstr_o) $(libs)
	$(CC) -o $@ $(gkdbchkstr_o) $(LDFLAGS)

gkdbcmp: $(gkdbcmp_o) $(libs)
	$(CC) -o $@ $(gkdbcmp_o) $(LDFLAGS)

gkgetdoc: $(gkgetdoc_o) $(libs)
	$(CC) -o $@ $(gkgetdoc_o) $(LDFLAGS)

gattrfix: $(gattrfix_o) $(libs)
		$(CC) -o $@ $(gattrfix_o) $(LDFLAGS)

gready: $(gready_o) $(libs)
		$(CC) -o $@ $(gready_o) $(LDFLAGS)

basestat: $(basestat_o) $(libs)
	$(CC) -o $@ $(basestat_o) $(LDFLAGS)

gsetname: $(gsetname_o) $(libs)
	$(CC) -o $@ $(gsetname_o) $(LDFLAGS)

gsetrev: $(gsetrev_o) $(libs)
	$(CC) -o $@ $(gsetrev_o) $(LDFLAGS)

clean:
	-rm -f $(all_o)

distclean: clean
	-rm -f $(targets)

copy: $(targets)
	for i in $(targets); do \
		cp $$i $(PLACE); \
	done

include ../src/makefile.dep
