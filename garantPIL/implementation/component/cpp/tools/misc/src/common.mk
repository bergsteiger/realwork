ROOT:=../../..
INCLUDES:=../src ../../../include

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
endif

INCLUDES+=../../../libs/cchlp/src ../../../libs/gkdb/src
INCLUDES+=../../../libs/inifile/src  ../../../libs/gsscreen/src
INCLUDES+=../../../libs/gctx/src  ../../../libs/mrglib/src
INCLUDES+=../../../libs/VControl/src

LIBS+=../../../libs/gkdb:gkdb
LIBS+=../../../libs/inifile:inifile
LIBS+=../../../libs/gkdb:osdep
LIBS+=../../../libs/mrglib:mrglib
LIBS+=../../../libs/gctx:gctx
LIBS+=../../../libs/gsscreen:gsscreen
LIBS+=../../../libs/VControl:VControl
LIBS+=../../../libs/cchlp:cchlp

gkdumpkw_o = gkdumpkw.o
balancer_o = balancer.o
gstatus_o = gstatus.o
gstat_o = gstat.o 
gkdumpi_o = gkdumpi.o
doc2html_o= doc2html.o
#newcorrs_o= newcorrs.o
newcorrs2_o= newcorrs2.o
fixannos_o= fixannos.o
calcpara_o= calcpara.o
newrefs_o= newrefs.o
enumparas_o= enumparas.o
#6x_infos_o= 6x_infos.o
fixbases_o = fixbases.o
fixnames_o = fixnames.o
gkdbcmp_o = gkdbcmp.o
gregtst_o = gregtst.o
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
gsetname_o = gsetname.o
gsetrev_o = gsetrev.o
basestat_o = basestat.o
new_belongs_to_old_o = # new_belongs_to_old.o
gfintst_o = gfintst.o
gardbclean_o = gardbclean.o
# flimit_o = flimit.o

cc_o = $(gkdumpkw_o) $(gregtst_o) $(gstatus_o) $(gstat_o) $(gkdumpi_o) $(doc2html_o) $(gkgetdoc_o) $(gattrfix_o) $(gkdbchkstr_o) $(gmonth_o) $(gready_o) $(gettopic_o) $(addannos_o) $(write-here_o) $(gsetname_o) $(gsetrev_o) $(new_belongs_to_old_o) $(gktouch_o) $(gfintst_o) $(newcorrs2_o) $(calcpara_o) $(fixannos_o) $(newrefs_o) $(enumparas_o) $(gkdbcmp_o) $(fixbases_o) $(fixnames_o)
#$(newcorrs_o) $(6x_infos_o)

ifneq (,$(findstring $(PLATFORM),linux go32 freebsd cygwin32 gnuwin32))
	cc_o+=$(balancer_o)
endif
c_o = n_malloc.o

all_o = $(cc_o)

targets:=gsetname
ifneq ($(PLATFORM),go32)
targets+=gregtst gkdumpi doc2html gkgetdoc gstat gkdbchkstr gktouch gready gettopic addannos gsetrev gstatus newcorrs2 calcpara fixannos newrefs enumparas gkdbcmp fixbases fixnames
#newcorrs 6x_infos
endif

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk

