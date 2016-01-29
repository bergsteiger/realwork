ROOT:=../../..
INCLUDES=../src ../../../include

ifdef PLATFORM
INCLUDES+=../../../include/$(PLATFORM)
endif

DEFS+=WITH_DBL_THREAD

INCLUDES+= $(ROOT)/libs/gctx/src
INCLUDES+= $(ROOT)/libs/gkdb/src
INCLUDES+= $(ROOT)/libs/cchlp/src
INCLUDES+= $(ROOT)/libs/gsscreen/src
INCLUDES+= $(ROOT)/libs/gc/src
INCLUDES+= $(ROOT)/libs/gchange/include
INCLUDES+= $(ROOT)/libs/lex/include
INCLUDES+= $(ROOT)/tools/gctools/src

targets:=gc

gc_o= ../../gctools/src/MyPipe.o\
 ../../../libs/cchlp/src/advlog.o\
 ../../../libs/cchlp/src/date.Set.o\
 ../../../libs/cchlp/src/date.SplayNode.o\
 ../../../libs/cchlp/src/date.SplaySet.o\
 ../../../libs/cchlp/src/errhandler.o\
 ../../../libs/cchlp/src/FString.caddr_t.Map.o\
 ../../../libs/cchlp/src/FString.caddr_t.SplayMap.o\
 ../../../libs/cchlp/src/fstring.o\
 ../../../libs/cchlp/src/FString.FString.Map.o\
 ../../../libs/cchlp/src/FString.FString.SplayMap.o\
 ../../../libs/cchlp/src/FString.SplayNode.o\
 ../../../libs/cchlp/src/FString.long.Map.o\
 ../../../libs/cchlp/src/FString.long.SplayMap.o\
 ../../../libs/cchlp/src/FString.Set.o\
 ../../../libs/cchlp/src/FString.SplaySet.o\
 ../../../libs/cchlp/src/hidxhlp.o\
 ../../../libs/cchlp/src/hnode.o\
 ../../../libs/cchlp/src/long.SplayNode.o\
 ../../../libs/cchlp/src/long.longSplaySet.Map.o\
 ../../../libs/cchlp/src/long.longSplaySet.SplayMap.o\
 ../../../libs/cchlp/src/long.Set.o\
 ../../../libs/cchlp/src/long.SplaySet.o\
 ../../../libs/cchlp/src/long.VHSet.o\
 ../../../libs/cchlp/src/u_int32_t.caddr_t.Map.o\
 ../../../libs/cchlp/src/u_int32_t.caddr_t.SplayMap.o\
 ../../../libs/cchlp/src/u_int32_t.FString.Map.o\
 ../../../libs/cchlp/src/u_int32_t.FString.SplayMap.o\
 ../../../libs/cchlp/src/u_int32_t.FString.VHMap.o\
 ../../../libs/cchlp/src/u_int32_t.Set.o\
 ../../../libs/cchlp/src/u_int32_t.SplayNode.o\
 ../../../libs/cchlp/src/u_int32_t.SplaySet.o\
 ../../../libs/cchlp/src/u_int32_t.VHSet.o\
 ../../../libs/cchlp/src/u_int64_t.Set.o\
 ../../../libs/cchlp/src/u_int64_t.SplayNode.o\
 ../../../libs/cchlp/src/u_int64_t.SplaySet.o\
 ../../../libs/cchlp/src/u_int64_t.VHSet.o\
 ../../../libs/cchlp/src/recode.o\
\
 ../../../libs/gc/src/dbproc.o\
 ../../../libs/gc/src/dbproc.mf.o\
 ../../../libs/gc/src/gclog.o\
\
 ../../../libs/gkdb/src/adler32.o\
 ../../../libs/gkdb/src/base.o\
 ../../../libs/gkdb/src/basemask.o\
 ../../../libs/gkdb/src/btiter.o\
 ../../../libs/gkdb/src/btree.o\
 ../../../libs/gkdb/src/collect.o\
 ../../../libs/gkdb/src/crc32.o\
 ../../../libs/gkdb/src/deflate.o\
 ../../../libs/gkdb/src/doccol.o\
 ../../../libs/gkdb/src/dociter.o\
 ../../../libs/gkdb/src/document.o\
 ../../../libs/gkdb/src/dummies.o\
 ../../../libs/gkdb/src/garutils.o\
 ../../../libs/gkdb/src/hindex.o\
 ../../../libs/gkdb/src/index.o\
 ../../../libs/gkdb/src/indices.o\
 ../../../libs/gkdb/src/infblock.o\
 ../../../libs/gkdb/src/infcodes.o\
 ../../../libs/gkdb/src/inffast.o\
 ../../../libs/gkdb/src/inflate.o\
 ../../../libs/gkdb/src/inftrees.o\
 ../../../libs/gkdb/src/infutil.o\
 ../../../libs/gkdb/src/ncpf.o\
 ../../../libs/gkdb/src/newdoc.o\
 ../../../libs/gkdb/src/osdummy.o\
 ../../../libs/gkdb/src/pack.o\
 ../../../libs/gkdb/src/pagefile.o\
 ../../../libs/gkdb/src/refcol.o\
 ../../../libs/gkdb/src/stdbase.o\
 ../../../libs/gkdb/src/paracol.o\
 ../../../libs/gkdb/src/streams.o\
 ../../../libs/gkdb/src/trees.o\
 ../../../libs/gkdb/src/unzip.o\
 ../../../libs/gkdb/src/zutil.o\
 ../../../libs/gkdb/src/docblock.o\
 ../../../libs/gkdb/src/pl_crypt.o\
\
 ../../../libs/VControl/src/vapi.o\
 ../../../libs/gctx/src/ctxwords.o\
 ../../../libs/gctx/src/u_int64_t.CtxLongSet.Map.o\
 ../../../libs/gctx/src/u_int64_t.CtxLongSet.SplayMap.o\
\
 ../../../libs/gsscreen/src/face.o\
 ../../../libs/gsscreen/src/gsscreen.o\
 ../../../libs/gsscreen/src/pscreen.o\
 ../../../libs/gsscreen/src/screen.o\
\
 ../../../libs/gchange/src/context.o\
 ../../../libs/gchange/src/parser.o\
 ../../../libs/lex/src/lex_basis.o\
 ../../../libs/lex/src/lex_operator.o\
 ../../../libs/lex/src/lex_parser.o\
\
 ../../gctools/src/belongs.o\
 ../../gctools/src/blobtable.o\
 ../../gctools/src/cacheIndex.o\
 ../../gctools/src/classes.o\
 ../../gctools/src/complect.o\
 ../../gctools/src/dbproc.m-reader.o\
 ../../gctools/src/dbproc.m-to-gkdb.o\
 ../../gctools/src/dbproc.m-writer.o\
 ../../gctools/src/fstringer.o\
 ../../gctools/src/gcini.o\
 ../../gctools/src/gcpass1.o\
 ../../gctools/src/kwfile.o\
 ../../gctools/src/loadStringMap.o\
 ../../gctools/src/normfile.o\
 ../../gctools/src/nsrcparser.o\
 ../../gctools/src/publish.o\
 ../../gctools/src/sources.o\
 ../../gctools/src/sttop.o\
 ../src/garcomp.o

dumpClassEq_o = dumpClassEq.o classes.o

cc_o = $(gc_o)

all_o = $(cc_o)

ifdef PLATFORM
include $(ROOT)/Mk/$(PLATFORM).mk
endif

ifeq ($(PLATFORM),solaris)
LDFLAGS_LIBS+=-lrt
LDFLAGS_LIBS+=-lpthread
else
LDFLAGS_LIBS+=-lstdc++ -lm
LDFLAGS_LIBS+=-pthread
endif

include $(ROOT)/Mk/tools.mk
include ../src/makefile.dep
include $(ROOT)/Mk/tagdep.mk
