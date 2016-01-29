ifeq ($(PLATFORM),solaris)
PLATFORM_DIR:=solaris.x86
else
PLATFORM_DIR:=$(PLATFORM)
endif

include ../../../platforms/$(PLATFORM).inc

DIRECT_INCLUDES=-I../../../include -I../../../include/$(PLATFORM)
DIRECT_INCLUDES+=-I../src
DIRECT_INCLUDES+=-I../../../libs/cchlp/src
DIRECT_INCLUDES+=-I../../../libs/gkdb/src
DIRECT_INCLUDES+=-I../../../libs/gsscreen/src
DIRECT_INCLUDES+=-I../../../libs/VControl/src
DIRECT_INCLUDES+=-I../../../libs/gl/src
DIRECT_INCLUDES+=-I../../../libs/inifile/src

CXXFLAGS+= $(DIRECT_INCLUDES)

ifeq ($(PLATFORM),solaris.x86.sunspro)
FLCTL=
else
FLCTL=-funsigned-char
endif

CXXFLAGS+=$(FLCTL)

LDFLAGS += -L../../../libs/gkdb/$(PLATFORM_DIR)
LDFLAGS += -L../../../libs/cchlp/$(PLATFORM_DIR)
LDFLAGS += -L../../../libs/gl/$(PLATFORM_DIR)
LDFLAGS += -L../../../libs/inifile/$(PLATFORM_DIR)
LDFLAGS += -L../../../libs/gsscreen/$(PLATFORM_DIR)
LDFLAGS += -L../../../libs/VControl/$(PLATFORM_DIR)
LDFLAGS += -lcchlp -losdep -lgkdb -lgsscreen -lVControl

EXTRA_LIBS = ../../../libs/gkdb/$(PLATFORM_DIR)/libgkdb.a
EXTRA_LIBS+=../../../libs/cchlp/$(PLATFORM_DIR)/libcchlp.a
EXTRA_LIBS+=../../../libs/gsscreen/$(PLATFORM_DIR)/gsscreen.a
EXTRA_LIBS+=../../../libs/VControl/$(PLATFORM_DIR)/libVControl.a

gkdumpkw_o = gkdumpkw.o

balancer_o = balancer.o

gstatus_o = gstatus.o

gstat_o = gstat.o 

gkdumpi_o = gkdumpi.o

doc2html_o = doc2html.o

newcorrs_o = newcorrs.o

newcorrs2_o = newcorrs2.o

newrefs_o = newrefs.o

calcpara_o = calcpara.o
fixannos_o = fixannos.o

enumparas_o = enumparas.o

6x_infos_o = 6x_infos.o

gkdbcmp_o = gkdbcmp.o

gregtst_o = gregtst.o

gsec_o = gsec.o

gkgetdoc_o = gkgetdoc.o

gktouch_o = gktouch.o

gkdbchkstr_o = gkdbchkstr.o

gattrfix_o = gattrfix.o

gready_o = gready.o

gettopic_o = gettopic.o

addannos_o = addannos.o

write-here_o = write-here.o

# basestat_o = basestat.o

gmonth_o = gmonth.o

GSETNAME_LDFLAGS:=$(LDFLAGS) -linifile -losdep
gsetname_o = gsetname.o

gsetrev_o = gsetrev.o

basestat_o = basestat.o

new_belongs_to_old_o = # new_belongs_to_old.o

gfintst_o = gfintst.o

gardbclean_o = gardbclean.o

# flimit_o = flimit.o

cc_o = $(gkdumpkw_o) $(gregtst_o) $(gstatus_o) $(gstat_o) $(gkdumpi_o) $(gkdbcmp_o) $(gsec_o) $(gkgetdoc_o) $(gattrfix_o) $(gkdbchkstr_o) $(gmonth_o) $(gready_o) $(gettopic_o) $(addannos_o) $(write-here_o) $(gsetname_o) $(gsetrev_o) $(new_belongs_to_old_o) $(gktouch_o) $(gfintst_o) $(doc2html_o) $(newcorrs_o) $(newcorrs2_o) $(calcpara_o) $(fixannos_o) $(newrefs_o) $(enumparas_o) $(6x_infos)

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32 gnuwin32))
	cc_o+=$(balancer_o)
endif
c_o = n_malloc.o

all_o = $(cc_o)

