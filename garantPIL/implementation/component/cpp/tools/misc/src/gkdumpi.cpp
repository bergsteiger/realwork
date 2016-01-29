#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/sys/AutoInit.h"
#include "shared/Morpho/Facade/Factory.h"

#include <cstdio>
#include <cstdlib>
#include <locale.h>
#include <cstring>

#include "garver.h"
#include "osdep.h"
#include "basemask.h"
#include "SearchB.h"
#include "DBComm.h"
#include "pack.h"

#include "common/components/rtl/Garant/EVD/eeReader.h"
#include "common/components/rtl/Garant/EVD/evddata.h"
#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"

// now we use either 1 or 2 streams per key
#define MAX_STREAMS 3

// add IDs in this array in future releases
static char *TagId [] =
{
	"IDD_NONE","IDD_NAME","IDD_DATE","IDD_ID","IDD_CHDATE_EXEX", "IDD_ADDCODE", "IDD_TERRITORY", "IDD_CHANGE",
	"IDD_SOURCE","IDD_DIV","IDD_KEY","IDD_TYPE", "IDD_KIND", "IDD_INFO","IDD_DOCKIND","IDD_CLASS6",
	"IDD_SUBS", "IDD_SUBS_EX", "IDD_DOCSTRUCT", "IDD_RUNS","IDD_BLOCKS","IDD_BASES","IDD_RCODE",
	"IDD_CALIN", "IDD_CALAB", "IDD_CALCH", "IDD_MARKEDTEXT",
	"IDD_VINCLUDED","IDD_VCHANGED","IDD_VABOLISHED","IDD_RDATE",
	"IDD_SORTDATE","IDD_WARNING","IDD_VANONCED","IDD_PREANNODATE","IDD_VLCONTROL", "IDD_ANNODATE",
	"IDD_SOURCEFILE","IDD_CATEGORY","IDD_PUBLISHEDIN", "IDD_PARAHEIGHTS"
#ifdef	VERSION56
	,"IDD_ACTIVE", "IDD_ACTIVEEX", "IDD_PAGEBREAKS", "IDD_CHDATE", "IDD_CHDATE_EX", "IDD_CONTENTS", "IDD_COMPARECONTENTS", "IDD_NOTSURE", "IDD_REFS", "IDD_BLOBS", "IDD_DIVISION",
#endif
	"IDD_ANNOUSER","IDD_PREANNOUSER",
	"IDD_ANNOORGANIZATION","IDD_PREANNOORGANIZATION",
	"IDD_ANNOTAX","IDD_PREANNOTAX",
	"IDD_ANNOINTEREST","IDD_PREANNOINTEREST",
	"IDD_ANNOKIND","IDD_PREANNOKIND", "IDD_HANDMASK", "IDD_HANDHANDMASK", "IDD_REFS_BLOCKS", "IDD_TFDIF", "IDD_SERVICEINFO",
	"IDD_PARAIDS", "IDD_CASECODE",

	"IDD_INPHARMFIRM", "IDD_INPHARMCOUNTRY", "IDD_REGDATE", "IDD_ANNULDATE", "IDD_TRADENAME", "IDD_INTNAME",
	"IDD_PHARMGROUP", "IDD_PHARMEFFECT", "IDD_CHAPTER", "IDD_ATC", "IDD_REGSTATUS", "IDD_LEKFORM", "IDD_MKB",
	"IDD_LIFE", "IDD_UNRECIPE", "IDD_ALLOWED", "IDD_NOTLIFE", "IDD_RECIPE", "IDD_NOTALLOWED", "IDD_EVD", "IDD_BLOB", "IDD_TAG", "IDD_PROFDATE"
};

struct IndexDumpInfo;

typedef void (*printKeyFunction ) ( const void *, FILE * );
typedef void (*printDataFunction) ( const char *d, u_int32_t s, FILE *f	);
typedef int  (*DumpIndexFunction) ( const Base *, const char *name,
					printKeyFunction,
					printDataFunction,
					FILE *,	const char *, const char *,
					int quiet, int strno );

static int readHindex ( HIndex *idx, int strno, printDataFunction );
static int PrintIndexTree ( HIndex *idx, int quiet, printDataFunction printData, int strno, const char* key = 0 );
static int DeleteIndexTree ( void );

struct IndexDumpInfo
{
	const char *	  name;				// index name
	DumpIndexFunction dumpIdx;			// dispatch function
	printKeyFunction  printKey;			// print key
	printDataFunction printData [MAX_STREAMS];	// print data
};

// printing keys funcs
static void key_printASCIIZ   ( const void *key, FILE *f );
static void key_printRef      ( const void *key, FILE *f );
static void key_printBlob     ( const void *key, FILE *f );
static void key_printInt32    ( const void *key, FILE *f );
static void key_printInt16    ( const void *key, FILE *f );
static void key_printStatus   ( const void *key, FILE *f );
static void key_printStatus_ex( const void *key, FILE *f );
static void key_printDate     ( const void *key, FILE *f );
static void key_printContext  ( const void *key, FILE *f );
#ifdef MULTI_INDEX_STREAM_FILE
static void key_printNContxt ( const void *key, FILE *f );
static void printSWordContxt ( const char *d, u_int32_t s, FILE *f );
	#ifdef STORE_FORM_N
		static void printWContxt2 ( const char *start, u_int32_t s, FILE *f );
		static void printWContxt ( const char *d, u_int32_t s, FILE *f );
		static void key_printNFContxt ( const void *key, FILE *f );
	#endif
#endif

// printing data funcs
static void printActiveSet( const char *d, u_int32_t s, FILE *f );
static void printActiveExSet( const char *d, u_int32_t s, FILE *f );
static void printDivision( const char *d, u_int32_t s, FILE *f );
static void printChDate( const char *d, u_int32_t s, FILE *f );
static void printChDateEx( const char *d, u_int32_t s, FILE *f );
static void printNotSure( const char *d, u_int32_t s, FILE *f );
static void printRefs( const char *d, u_int32_t s, FILE *f );
static void printContents( const char *d, u_int32_t s, FILE *f );
static void printCompareContents( const char *d, u_int32_t s, FILE *f );
static void printBlobInfos( const char *d, u_int32_t s, FILE *f );
static void printPageBreaks( const char *d, u_int32_t s, FILE *f );
static void printStrSet ( const char *d, u_int32_t s, FILE *f );
static void printStrSetHead ( const char *d, u_int32_t s, FILE *f );
static void printStrSetReal ( const char *d, u_int32_t s, FILE *f );
static void printKindCorr78 ( const char *d, u_int32_t s, FILE *f );
static void printKindCorr ( const char *d, u_int32_t s, FILE *f );
static void printInt32A	( const char *d, u_int32_t s, FILE *f );
static void printSubs	( const char *d, u_int32_t s, FILE *f );
static void printSubsEx	( const char *d, u_int32_t s, FILE *f );
static void printDocStruct ( const char *d, u_int32_t s, FILE *f );
static void printEVD ( const char *d, u_int32_t s, FILE *f );
static void printInt16A	( const char *d, u_int32_t s, FILE *f );
static void printRefWeight	( const char *d, u_int32_t s, FILE *f );
static void printRefA	( const char *d, u_int32_t s, FILE *f );
static void printRefB	( const char *d, u_int32_t s, FILE *f );
static void printRefC	( const char *d, u_int32_t s, FILE *f );
static void printDateA  ( const char *d, u_int32_t s, FILE *f );
static void printDateB  ( const char *d, u_int32_t s, FILE *f );
static void printBLOB   ( const char *d, u_int32_t s, FILE *f );
static void printControl( const char *d, u_int32_t s, FILE *f );
static void printMarkedText( const char *d, u_int32_t s, FILE *f );

#ifdef MULTI_INDEX_STREAM_FILE
static void printNContxt ( const char *d, u_int32_t s, FILE *f );
	#ifdef STORE_FORM_N
		static void printNFContxt ( const char *d, u_int32_t s, FILE *f );
		static void printNBContxt ( const char *d, u_int32_t s, FILE *f );
	#endif
#endif

// dispath funcs
static int dump_RawIndex ( const Base*, const char*,
			   printKeyFunction, printDataFunction,
			   FILE*, const char*, const char*, int, int );
static int dump_AtrIndex ( const Base*, const char*,
			   printKeyFunction, printDataFunction,
			   FILE*, const char*, const char*, int, int );
static int dump_AuxIndex ( const Base*, const char*,
			   printKeyFunction, printDataFunction,
			   FILE*, const char*, const char*, int, int );
static int dump_HieIndex ( const Base*, const char*,
			   printKeyFunction, printDataFunction,
			   FILE*, const char*, const char*, int, int );

static struct IndexDumpInfo indexTable [] =
{
 { "Adopted"	  , dump_HieIndex, key_printASCIIZ , { printInt32A, printStrSet } },
 { "PhGroup"	  , dump_HieIndex, key_printASCIIZ , { printInt32A, 0 } },
 { "PhEffect"     , dump_HieIndex, key_printASCIIZ , { printInt32A, 0 } },
 { "Mkb"          , dump_HieIndex, key_printASCIIZ , { printRefC, 0 } },
 { "Chapter"      , dump_HieIndex, key_printASCIIZ , { printRefC, 0 } },
 { "AnnoClass"	  , dump_HieIndex, key_printASCIIZ , { printInt32A, printStrSet } },
 { "Class"	  , dump_HieIndex, key_printASCIIZ , { printRefA  , printStrSet } },
 { "Class6"	  , dump_HieIndex, key_printASCIIZ , { printRefA  , printStrSet } },
 { "Type"	  , dump_HieIndex, key_printASCIIZ , { printRefA  , 0 } },
 { "Kind"	  , dump_HieIndex, key_printASCIIZ , { printRefA  , 0 } },
 { "ServiceInfo"  , dump_HieIndex, key_printASCIIZ , { printRefA  , 0 } },
 { "Atc"          , dump_HieIndex, key_printASCIIZ , { printInt32A, 0 } },
 { "RegStatus"    , dump_HieIndex, key_printASCIIZ , { printRefC  , 0 } },
 { "LekForm"      , dump_HieIndex, key_printASCIIZ , { printRefC  , 0 } },
 { "PhFirm"       , dump_HieIndex, key_printASCIIZ , { printRefC  , 0 } },
 { "PhCountry"    , dump_HieIndex, key_printASCIIZ , { printRefC , 0 } },
 { "KeyWord"	  , dump_HieIndex, key_printASCIIZ , { printRefA  , 0 } },
 { "DocKind"	  , dump_HieIndex, key_printASCIIZ , { printRefA  , printStrSet } },
 { "PublishedIn"  , dump_HieIndex, key_printASCIIZ , { printInt32A, 0 } },
 { "Territory"    , dump_HieIndex, key_printASCIIZ , { printInt32A, 0 } },
 { "Respondent"	  , dump_RawIndex, key_printInt32  , { printRefA  , 0 } },
 { "Correspondent", dump_RawIndex, key_printInt32  , { printRefA  , 0 } },
 { "NewCorr",       dump_RawIndex, key_printInt32  , { printRefB  , 0 } },
 { "Control",       dump_RawIndex, key_printDate  ,  { printControl, 0 } },
 { "AnnoUser",			dump_HieIndex, key_printASCIIZ , { printInt32A  , printStrSet } },
 { "AnnoOrganization",	dump_HieIndex, key_printASCIIZ , { printInt32A  , printStrSet } },
 { "AnnoTax",			dump_HieIndex, key_printASCIIZ , { printInt32A  , printStrSet } },
 { "AnnoInterest",		dump_HieIndex, key_printASCIIZ , { printInt32A  , printStrSet } },
 { "AnnoKind",			dump_HieIndex, key_printASCIIZ , { printInt32A  , printStrSet } },
 { "Category",			dump_RawIndex, key_printASCIIZ , { printInt32A, 0 } },
 { "Tag",				dump_RawIndex, key_printASCIIZ , { printRefWeight, 0 } },
 { "IntName",			dump_RawIndex, key_printASCIIZ , { printInt32A, 0 } },
 { "TradeName",			dump_RawIndex, key_printASCIIZ , { printInt32A, 0 } },
 { "Number",			dump_RawIndex, key_printASCIIZ , { printInt32A, 0 } },
 { "RCode",				dump_RawIndex, key_printASCIIZ , { printInt32A, 0 } },

 { "Date"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "RegDate"      , dump_RawIndex, key_printDate   , { printRefC, 0 } },
 { "AnnulDate"    , dump_RawIndex, key_printDate   , { printRefC, 0 } },
 { "Active"	  , dump_RawIndex, key_printDate   , { printRefC, 0 } },
 { "RDate"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "VIncluded"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "VChanged"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "VAbolished"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "VAnonced"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "AnnoDate"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "VLControl"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "SortDate"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "CalIn"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "CalAb"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },
 { "CalCh"	  , dump_RawIndex, key_printDate   , { printInt32A, 0 } },

 { "Context"	  , dump_RawIndex, key_printNContxt,  { printWContxt,  printWContxt2 } },
#ifdef MULTI_INDEX_STREAM_FILE
 { "NPContxt"	  , dump_RawIndex, key_printNContxt, { printNContxt, 0 } },
 { "NContxt"	  , dump_RawIndex, key_printNContxt, { printNContxt, 0 } },
 { "SWords"       , dump_RawIndex, key_printInt32,   { printSWordContxt, 0 } },
	#ifdef STORE_FORM_N
		{ "NWCntxt"	  , dump_RawIndex, key_printNContxt,  { printWContxt,  printWContxt2 } },
		{ "NFContxt"  , dump_RawIndex, key_printNFContxt, { printNFContxt, 0 } },
		{ "NBCntxt"	  , dump_RawIndex, key_printNContxt,  { printNBContxt, 0 } },
	#endif
#endif

 { "SubName"   , dump_RawIndex, key_printRef	   , { printStrSetReal, 0 } },
 { Base::m_SubNamesName   , dump_RawIndex, key_printRef	   , { printStrSetReal, 0 } },
 { "KindCorr"  , dump_RawIndex, key_printRef       , { printKindCorr  , 0 } },

 { "Status"	  , dump_RawIndex, key_printStatus , { printInt32A, 0 } },
 { "Status_ex"	  , dump_RawIndex, key_printStatus_ex , { printRefC, 0 } },
 { "Segment"	  , dump_RawIndex, key_printInt16  , { printInt32A, 0 } },

 { "Aux"	  , dump_AuxIndex, 0		   , { printInt32A  , 0 } },
 { "Attrs"	  , dump_AtrIndex, 0		   , { printInt32A  , 0 } },

 { "Blob"	  , dump_RawIndex, key_printBlob   , { printBLOB    , printInt16A } },
};

bool	print_length = false;

//////////////////////////////////////////////////////////////////////////

void syndecrypt (char* ptr) {
	const char* from = "#gvnrc$kzh%iyl&maopf(sjt)uedqwx+b\0";
	const char* to   = "ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÜÛÚÝÞß\0";

	for (; *ptr; ++ptr) {
		const char*	at = ACE_OS::strchr (from, *ptr);
		if (at) {
			int offset = at - from;
			*ptr = *(to + offset);
		}
	}
}

static int dump_AuxIndex ( const Base *b, const char *name,
	printKeyFunction printKey, printDataFunction printData,
	FILE *f, const char *s1, const char *s2,
	int quiet, int strno )
{
// name == "Aux"
	fprintf ( f, "Working on AUX index\n" );
	Index *idx = ((Base *)b) -> FindIndex ( name );
	if ( !idx )
	{
		fprintf ( f     , "No Aux Index ?!\n" ); // GARANT_GCC: trigraph warning
		printf ( "No Aux Index ?!\n" );
		return 0;
	}

	fprintf ( f, "Index exists and claims:\n" );
	fprintf ( f, "KeyCount: %ld\n", idx -> KeyCount );
	fprintf ( f, "KeyLength: %d\n", idx -> KeyLength );
	fprintf ( f, "Btree height: %d\n", idx -> Height );
	fprintf ( f, "----- Key dump follows: -----\n" );

	int size;

	if (s1 && !stricmp (s1, "Protection")) {
		for (int i = 0; i < 12; i++) {
			char key [5];
			sprintf (key, "PRO%X", i);
			Stream *str = idx->Open (key);
			if (str) {
				char dummy [5];
				dummy [4] = 0;
				str->Read (&dummy, 4);
				printf ("%s", dummy);
				idx->Close (str);
			}
		}
		printf ("\n");
		return 0;
	}

	if (s1 && !stricmp (s1, "Percents")) {
		for (int i = 0; i < 16; i++) {
			char key [5];
			sprintf (key, "%%%%%%%X", i);
			Stream *str = idx->Open (key);
			if (str) {
				if (i) printf (",");
				long perc;
				str->Read (&perc, 4);
				printf ("%ld", perc);
				idx->Close (str);
			}
		}
		printf ("\n");
		return 0;
	}
	if (s1 && !strcmp (s1, "DOCD")) {
		Stream *str = idx->Open (s1);
		if (str) {
			printf ("total size: %ld\n", str->Length ());
			while (str->Pos < str->Length ()) {
				short count;
				str->Read (&count, sizeof (count)); printf ("blocks: %ld ", count);
				str->SeekCur (count * sizeof (BlockRec));
				str->Read (&count, sizeof (count)); printf ("runs: %ld\n", count);
				str->SeekCur (count * sizeof (PageRun));
			}
			idx->Close (str);
		}
		return 0;
	}
	
	if (s1 && (!strcmp (s1, "ISyn") || !strcmp (s1, "Indexes"))) {
		Stream *str = idx->Open (s1);
		if (str) {
			long size = str->Length ();
			char *data = new char [size], *ptr = data;
			str->Read (data, size);
			idx->Close (str);
			while (ptr - data < size) {
				fprintf (f, "%s\n", ptr);
				ptr += strlen (ptr) + 1;
			}
		}
		return 0;
	}
	if (s1 && s1 [0] == '!') {
		Stream* str = idx->Open (s1);
		if (str) {
			long size = str->Length ();
			char *data = new char [size], *ptr = data;
			str->Read (data, size);
			idx->Close (str);
			while (ptr - data < size) {
				fprintf (f, "%s :", ptr);
				ptr += strlen (ptr) + 1;
				short count = *(short*) ptr;
				ptr += sizeof (short);
				for (short seg = 0; seg < count; seg++, ptr += sizeof (short))
					fprintf (f, " %ld", *(short*)ptr);
				fprintf (f, "\n");
			}
			delete []data;
		}
		return 0;
	}

	if (s1 != 0 && s1 [0] == '-') {
		Stream *str = idx->Open (s1);
		if (str) {
			fprintf (f, "\n");
			while (str->Tell () < str->Length ()) {
				long request_str_length;
				str->Read (&request_str_length, sizeof (long));
				char* request_str = (char*) malloc (request_str_length);
				str->Read (request_str, request_str_length);
				long offset;
				str->Read (&offset, sizeof (long));
				fprintf (f, "%s:%ld\n", request_str, offset);
			}
			idx->Close (str);
		}

		fprintf (f, "\n");
		char *name = strdup (s1);
		name [0] = '|';
		str = idx->Open (name);
		if (str) {
			fprintf (f, "\n");
			while (str->Tell () < str->Length ()) {
				fprintf (f, "offset:%ld\n", str->Tell ());
				long count;
				str->Read (&count, sizeof (long));
				fprintf (f, "  %ld\n  ", count);
				for (long i = 0; i < count; i++) {
					RefwRele rele;
					str->Read (&rele, sizeof (rele));
					fprintf (f, "%ld.%ld.%ld ", rele.DocId, rele.Rele, rele.Word);
				}
				fprintf (f, "\n");	
			}
			idx->Close (str);
		}
		return 0;
	}

	if ((s1 != NULL) && ( !stricmp (s1, "IInf"))){
		Stream *str = idx->Open ("IInf");
		if (str) {
			fprintf (f, "\n");
			long size = str->Length ();
			char *info = (char*) malloc (size), *ptr = info;
			str->Read (info, size);
			idx->Close (str);
			while (ptr - info < size) {
				printf ("%ld.%04X.%s\n", ((InpharmAttribute*) ptr)->m_id, (long) ((InpharmAttribute*)ptr)->m_status_ex, ptr + sizeof (long) + sizeof (short));
				ptr += sizeof (long) + sizeof (short) + strlen (ptr + sizeof (short) + sizeof (long)) + 1;
			}
			gk_free (info);
		}
		return 0;
	}

	if (s1 && !strcmp (s1, AUX_MEDICINE_GLOSSARY)) {
		Stream *str = idx->Open (s1);
		if (str) {
			long length = str->Length ();
			char *data = new char [length], *ptr = data;
			str->Read (data, length);
			idx->Close (str);
			while (ptr - data < length) {
				long id;
				memcpy (&id, ptr, sizeof (id));
				ptr += sizeof (id);
				printf ("%ld %s\n", id, ptr);
				ptr += strlen (ptr) + 1;
			}
			delete []data;
		}
		return 0;
	}
	
	if (s1 && (!strcmp (s1, AUX_CORR_WEIGHT) || !strcmp (s1, "CorrespondentWeight"))) {
		fprintf (f, "%s:", AUX_CORR_WEIGHT);
		RefCollection refs;
		Stream *str = idx->Open (AUX_CORR_WEIGHT);
		refs.Get (str);
		idx->Close (str);
		for (int i = 0; i < refs.ItemCount; i++) {
			Ref ati = refs[i];
			fprintf (f, " %ld.%ld", ati.DocId, ati.Sub);
		}
		fprintf (f, "\n");
		return 0;
	}

	if (s1 && (!strcmp (s1, AUX_CORR_PAIR_WEIGHT) || !strcmp (s1, "CorrespondentPairWeight"))) {
		fprintf (f, "%s:\n", AUX_CORR_PAIR_WEIGHT);
		Stream *str = idx->Open (AUX_CORR_PAIR_WEIGHT);
		while (str->Pos < str->Length ()) {
			Ref ref;
			str->Read (&ref, sizeof (Ref));
			fprintf (f, "%ld.%ld:", ref.DocId, ref.Sub);
			long count;
			str->Read (&count, sizeof (count));
			for (; count; count--) {
				str->Read (&ref, sizeof (Ref));
				fprintf (f, " %ld.%ld", ref.DocId, ref.Sub);
			}
			fprintf (f, "\n");
		}
		idx->Close (str);
		return 0;
	}

	if (s1 && (!strcmp (s1, AUX_CORR_PAIR_WEIGHT) || !strcmp (s1, "CorrespondentPairSubWeight"))) {
		fprintf (f, "%s:\n", AUX_CORR_PAIR_SUB_WEIGHT);
		Stream *str = idx->Open (AUX_CORR_PAIR_SUB_WEIGHT);
		while (str->Pos < str->Length ()) {
			Ref ref;
			str->Read (&ref, sizeof (Ref));
			fprintf (f, "%ld.%ld:", ref.DocId, ref.Sub);
			long count;
			str->Read (&count, sizeof (count));
			for (; count; count--) {
				str->Read (&ref, sizeof (Ref));
				short weight;
				str->Read (&weight, sizeof (weight));
				fprintf (f, " %ld.%ld;%ld", ref.DocId, ref.Sub, (long)weight);
			}
			fprintf (f, "\n");
		}
		idx->Close (str);
		return 0;
	}

	if (s1 && (!strcmp (s1, AUX_CORR_PAIR_DOC_WEIGHT) || !strcmp (s1, "CorrespondentPairDocWeight"))) {
		fprintf (f, "%s:\n", AUX_CORR_PAIR_DOC_WEIGHT);
		Stream *str = idx->Open (AUX_CORR_PAIR_DOC_WEIGHT);
		while (str->Pos < str->Length ()) {
			long doc;
			str->Read (&doc, sizeof (doc));
			fprintf (f, "%ld:", doc);
			long count;
			str->Read (&count, sizeof (count));
			for (; count; count--) {
				Ref ref;
				str->Read (&ref, sizeof (Ref));
				fprintf (f, " %ld.%ld", ref.DocId, ref.Sub);
			}
			fprintf (f, "\n");
		}
		idx->Close (str);
		return 0;
	}

	if ((s1 != NULL) && ( !stricmp (s1, AUX_SEARCH_CACHE_OFFSETS))){
		Stream *str = idx->Open (AUX_SEARCH_CACHE_OFFSETS);
		if (str) {
			fprintf (f, "\n");
			while (str->Tell () < str->Length ()) {
				long request_str_length;
				str->Read (&request_str_length, sizeof (long));
				char* request_str = (char*) malloc (request_str_length);
				str->Read (request_str, request_str_length);
				long offset;
				str->Read (&offset, sizeof (long));
				fprintf (f, "%s:%ld\n", request_str, offset);
			}
			idx->Close (str);
		}
		return 0;
	}
	if ((s1 != NULL) && ( !stricmp (s1, AUX_SEARCH_CACHE_RESULTS))){
		Stream *str = idx->Open (AUX_SEARCH_CACHE_RESULTS);
		if (str) {
			fprintf (f, "\n");
			while (str->Tell () < str->Length ()) {
				fprintf (f, "offset:%ld\n", str->Tell ());
				long segs, all_count = 0;
				str->Read (&segs, sizeof (long));
				fprintf (f, "  segs:%ld\n  ", segs);
				std::map<long,long> map_seg_count;
				for (long i = 0; i < segs; i++) {
					long seg, count;
					str->Read (&seg, sizeof (long));
					str->Read (&count, sizeof (long));
					fprintf (f, "%ld:%ld ", seg, count);
					map_seg_count.insert (std::map<long,long>::value_type (seg, count));
					all_count += count;
				}
				fprintf (f, "\n  ");
				std::map<long,long>::const_iterator it = map_seg_count.begin ();
				long it_count = 0;
				for (long i = 0; i < all_count; i++) {
					RefwRele rele;
					str->Read (&rele, sizeof (rele));
					fprintf (f, "%ld.%ld.%ld ", rele.DocId, rele.Rele, rele.Word);
					if (++it_count == it->second) {
						it_count = 0;
						fprintf (f, "\n  ");
						if (it != map_seg_count.end ())
							it++;
					}
				}
				fprintf (f, "\n");
	
			}
			idx->Close (str);
		}
		return 0;
	}

	/*
	if ((s1 != NULL) && (!stricmp(s1,AUX_HANDMASK_LENS))){
		Stream *str = idx -> Open (AUX_HANDMASK_LENS);
		if (str) {
			long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
			str->Read (data, size);
			size /= sizeof (long);
			idx->Close (str);
			long zeros = 0;
			while (ptr - data < size) {
				if (!zeros) {
					printf ("%ld:", *ptr++);
					zeros++;
					continue;
				}
				if (*ptr == 0)
					zeros++;
				printf (" %ld", *ptr++);
				if (zeros == 3) {
					printf ("\n");
					zeros = 0;
				}
			}
			gk_free (data);
		}
		return 0;
	}
	*/

	if (s1 && !strcmp(s1,AUX_INFORMERS)) {
		Stream *str = idx->Open (AUX_INFORMERS);
		long length = str->Length ();
		char *data = (char*) malloc (length), *ptr = data;
		str->Read (data, length);
		idx->Close (str);
		while (ptr - data < length) {
			printf ("%s;", ptr);
			ptr += strlen (ptr) + 1;
			printf ("%s;", ptr);
			ptr += strlen (ptr) + 1;
			printf ("%ld.%ld\n", ((Ref*) ptr)->DocId, ((Ref*) ptr)->Sub);
			ptr += sizeof (Ref);
		}
		gk_free (data);
		return 0;
	}

	if (s1 && !strcmp(s1,AUX_INFORMERS_EX)) {
		Stream *str = idx->Open (AUX_INFORMERS_EX);
		long length = str->Length ();
		char *data = (char*) malloc (length), *ptr = data;
		str->Read (data, length);
		idx->Close (str);
		while (ptr - data < length) {
			printf ("%s;", ptr);
			ptr += strlen (ptr) + 1;
			printf ("%s;", ptr);
			ptr += strlen (ptr) + 1;
			printf ("%ld.%ld;", ((Ref*) ptr)->DocId, ((Ref*) ptr)->Sub);
			ptr += sizeof (Ref);
			printf ("%ld\n", *(long*) ptr);
			ptr += sizeof (long);
		}
		gk_free (data);
		return 0;
	}

	if ((s1 != NULL) && (!stricmp(s1,AUX_INVISIBLE_LENS))){
		Stream *str = idx -> Open (AUX_INVISIBLE_LENS);
		if (str) {
			long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
			str->Read (data, size);
			size /= sizeof (long);
			idx->Close (str);
			while (ptr - data < size) {
				printf ("%ld:", *ptr++);
				long count = *ptr++;
				for (int i = 0; i < count; i++, ptr += 3)
					printf (" %ld:%ld:%ld", *ptr, *(ptr+1), *(ptr+2));
				printf ("\n");
			}
			gk_free (data);
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp(s1,AUX_INVISIBLE_RELES))){
		Stream *str = idx -> Open (AUX_INVISIBLE_RELES);
		if (str) {
			long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
			str->Read (data, size);
			size /= sizeof (long);
			idx->Close (str);
			while (ptr - data < size) {
				printf ("%ld:", *ptr++);
				long count = *ptr++;
				for (int i = 0; i < count; i++, ptr += 2)
					printf (" %ld:%ld", *ptr, *(ptr+1));
				printf ("\n");
			}
			gk_free (data);
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp(s1,AUX_MORPHO_HASHES))){
		Stream *str = idx -> Open (AUX_MORPHO_HASHES);
		if (str) {
			long size = str->Length ();
			char *data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			idx->Close (str);
			while (ptr - data < size) {
				printf ("%s: ", ptr);
				ptr += strlen (ptr) + 1;
				printf ("%lu\n", *(unsigned long*)ptr);
				ptr += sizeof (unsigned long);
			}
			gk_free (data);
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp(s1,AUX_TYPING_ERRORS) || !stricmp(s1,AUX_SEGMENT_INDEXES) || !stricmp(s1,AUX_MISTAKES_MORPHO) || !stricmp(s1,AUX_MORPHO_SYNS))){
		Stream *str = idx -> Open (s1);
		if (str) {
			long size = str->Length ();
			char *data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			idx->Close (str);
			while (ptr - data < size) {
				printf ("%s - ", ptr);
				ptr += strlen (ptr) + 1;
				printf ("%s\n", ptr);
				ptr += strlen (ptr) + 1;
			}
			gk_free (data);
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp (s1,AUX_ENDINGS) || !stricmp (s1,AUX_NORMALIZER_EXCLUDE))){
		Stream *str = idx -> Open (s1);
		if (str) {
			long size = str->Length ();
			char *data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			idx->Close (str);
			while (ptr - data < size) {
				printf ("%s - ", ptr);
				ptr += strlen (ptr) + 1;
				printf ("%s\n", ptr);
				ptr += strlen (ptr) + 1;
			}
			gk_free (data);
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp (s1, AUX_BIGRAMS))) {
		Stream *str = idx -> Open (s1);
		if (str) {
			long size = str->Length ();
			char *data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			idx->Close (str);
			while (ptr - data < size) {
				printf ("%s -", ptr);
				ptr += strlen (ptr) + 1;
				long count;
				memcpy (&count, ptr, sizeof (long));
				ptr += sizeof (long);
				for (int i = 0; i < count; i++) {
					if (i) printf (",");
					printf (" %s", ptr);
					ptr += strlen (ptr) + 1;
				}
				printf ("\n");
			}
			gk_free (data);
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp(s1,AUX_SYN_TYPE))){
		Stream *str = idx -> Open ( AUX_SYN_TYPE );
		if ( str ) {
			fprintf( f, "%s:\n", AUX_SYN_TYPE );
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			idx->Close(str);

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
				printf( "%s\n", ptr );
				pos += length;
				ptr += length;
				long syns = *(long*)ptr;
				ptr += sizeof( long );
				pos += sizeof( long );
				for ( long i = 0; i < syns; i++ ) {
					length = strlen( ptr ) + 1;
					printf( "\t%s\n", ptr );
					ptr += length;
					pos += length;
				}
			}
			free( data );
		}
		return 0;
	}

	if (s1 && !stricmp (s1, AUX_COUNTRY_FIRMS)) {
		Stream *str = idx -> Open (AUX_COUNTRY_FIRMS);
		if (str) {
			long size = str->Length (), pos = 0;
			char *data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			idx->Close (str);
			while (pos < size) {
				printf ("%s: ", ptr);
				pos += strlen (ptr) + 1;
				ptr += strlen (ptr) + 1;
				long* id = (long*) ptr;
				while (*id) {
					printf ("%ld, ", *id);
					id++;
					pos += sizeof (long);
					ptr += sizeof (long);
				}
				printf ("%ld\n", *id);
				ptr += sizeof (long);
				pos += sizeof (long);
			}
			gk_free (data);
		}
		return 0;
	}

	if ((s1 != NULL) && (!stricmp(s1,AUX_SYN_CODEXES))){
		Stream *str = idx -> Open ( AUX_SYN_CODEXES);
		if ( str ) {
			fprintf( f, "%s:\n", AUX_SYN_CODEXES);
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			idx->Close(str);

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
				printf( "%s: ", ptr );
				pos += length;
				ptr += length;
				length = strlen( ptr ) + 1;
				printf( "%s\n", ptr );
				ptr += length;
				pos += length;
			}
			free( data );
		}
		return 0;
	}
	if ((s1 != NULL) && (!strcmp(s1,AUX_FILTERED_CLASS) || !strcmp(s1,AUX_FILTERED_CORR) || !strcmp(s1,AUX_FILTERED_ADOPTED) || !strcmp(s1,AUX_FILTERED_KIND) || !strcmp(s1,AUX_FILTERED_PREFIX) || !strcmp(s1,AUX_FILTERED_PUBLISHED) || !strcmp(s1,AUX_FILTERED_PUBLISHED_JU) || !strcmp(s1,AUX_FILTERED_PUBLISHED_HR) || !strcmp(s1,AUX_FILTERED_PUBLISHED_BO) || !strcmp(s1,AUX_FILTERED_PUBLISHED_PH) || !strcmp(s1,AUX_FILTERED_LEKFORM))){
		Stream *str = idx -> Open (s1);
		if ( str ) {
			int length = str->Length ();
			TreeNodeLevel* data = (TreeNodeLevel*) malloc (length);
			str->Read (data, length);
			idx->Close (str);
			length /= sizeof (TreeNodeLevel);
			for (int i = 0; i < length; i++)
				printf ("%ld.%ld ", data[i].id, (long) data[i].level);
			printf ("\n");
			free (data);
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp(s1,AUX_BELONGS))){
		Stream *str = idx -> Open (s1);
		if ( str ) {
			fprintf( f, "%s:\n", s1);
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			idx->Close(str);

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
				printf ("%s: ", ptr);
				ptr += length;
				pos += length;
				length = strlen( ptr ) + 1;
				printf ("%s\n", ptr);
				ptr += length;
				pos += length;
			}
			free( data );
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp(s1,AUX_SYN_TYPES) || !stricmp(s1,AUX_SYN_ADOPTED))){
		Stream *str = idx -> Open (s1);
		if ( str ) {
			fprintf( f, "%s:\n", s1);
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			idx->Close(str);

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
				printf( "%s - ", ptr );
				pos += length;
				ptr += length;
				length = strlen( ptr ) + 1;
				printf( "%s: ", ptr );
				int count = atoi (ptr);
				pos += length;
				ptr += length;
				for (int i = 0; i < count; i++) {
					length = strlen( ptr ) + 1;
					printf( "%s", ptr );
					if (i < count-1)
						printf (", ");
					ptr += length;
					pos += length;
				}
				printf ("\n");
			}
			free( data );
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp(s1,AUX_SYNS) || !strcmp (s1, AUX_SYN_MORPHO) || !strcmp (s1, AUX_SYN_MORPHO_PATTERN))){
		Stream *str = idx -> Open (s1);
		if ( str ) {
			fprintf( f, "%s:\n", s1);
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			idx->Close(str);

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
				printf( "%s\n", ptr );
				pos += length;
				ptr += length;
				long syns = *(long*)ptr;
				ptr += sizeof( long );
				pos += sizeof( long );
				for ( long i = 0; i < syns; i++ ) {
					length = strlen( ptr ) + 1;
					printf( "\t%s\n", ptr );
					ptr += length;
					pos += length;
				}
			}
			free( data );
		}
		return 0;
	}
	/*
	if ((s1 != NULL) && (!stricmp(s1,AUX_SYN_MORPHO))){
		Stream *str = idx -> Open ( AUX_SYN_MORPHO );
		if ( str ) {
			fprintf( f, "%s:\n", AUX_SYN_MORPHO );
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			idx->Close(str);

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
//#if	defined(unix) || defined(_DEBUG)
				syndecrypt (ptr);
//#endif
				printf( "%s\n", ptr );
				pos += length;
				ptr += length;
				long syns = *(long*)ptr;
				ptr += sizeof( long );
				pos += sizeof( long );
				for ( long i = 0; i < syns; i++ ) {
					length = strlen( ptr ) + 1;
//#if	defined(unix) || defined(_DEBUG)
					syndecrypt (ptr);
//#endif
					printf( "\t%s\n", ptr );
					ptr += length;
					pos += length;
				}
			}
			free( data );
		}
		return 0;
	}
	*/
	if ((s1 != NULL) && (!stricmp(s1,AUX_SYN_DATES))){
		Stream *str = idx -> Open (AUX_SYN_DATES);
		if ( str ) {
			fprintf (f, "%s:\n", AUX_SYN_DATES);
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			idx->Close(str);

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
				printf( "%s\n", ptr );
				pos += length;
				ptr += length;
				long syns = *(long*)ptr;
				ptr += sizeof( long );
				pos += sizeof( long );
				for ( long i = 0; i < syns; i++ ) {
					length = strlen( ptr ) + 1;
					printf( "\t%s\n", ptr );
					ptr += length;
					pos += length;
				}
			}
			free( data );
		}
		return 0;
	}
	if ((s1 != NULL) && (!stricmp(s1,AUX_SUPPORT_WORDS))){
		Stream *str = idx -> Open (AUX_SUPPORT_WORDS);
		if ( str ) {
			fprintf( f, "%s:\n", AUX_SUPPORT_WORDS);
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			idx->Close(str);

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
				printf( "%s\n", ptr );
				pos += length;
				ptr += length;
				long syns = *(long*)ptr;
				ptr += sizeof( long );
				pos += sizeof( long );
				for ( long i = 0; i < syns; i++ ) {
					length = strlen( ptr ) + 1;
					printf( "\t%s\n", ptr );
					ptr += length;
					pos += length;
				}
			}
			free( data );
		}
		return 0;
	}

	if ((s1 != NULL) && (!stricmp(s1,AUX_INFO))){
		Stream *str = idx -> Open (AUX_INFO);
		if ( str ) {
			long size = str->Length(), pos = 0;
			char* data = (char*) malloc (size), *ptr = data;
			str->Read( data, size );
			idx->Close(str);
			while ( pos < size ) {
				pos += strlen (ptr) + 1;
				printf ("%s\n", ptr);
				ptr += strlen (ptr) + 1;
			}
		}
		return 0;
	}

	if ((s1 != NULL) && (!stricmp(s1,"gc"))){
		Stream *str = idx -> Open (AUX_GC);
		if ( str ) {
			long size = str->Length(), pos = 0;
			char* data = (char*) malloc (size), *ptr = data;
			str->Read( data, size );
			idx->Close(str);
			while ( pos < size ) {
				pos += strlen (ptr) + 1;
				printf ("%s\n", ptr);
				ptr += strlen (ptr) + 1;
			}
		}
		return 0;
	}

	if (s1 && (!strcmp (s1, AUX_DOC_BASE) || !strcmp (s1, AUX_BLOB_BASE))) {
		Stream *str = idx->Open (s1);
		if (str) {
			long length = str->Length ();
			char *data = new char [length], *ptr = data;
			str->Read (data, length);
			while (length) {
				printf ("%ld:", *(long*)ptr);
				ptr += sizeof (long);
				length -= sizeof (long);
				printf ("%ld\n", *ptr);
				ptr++;
				length--;
			}
			delete []data;
			idx->Close (str);
		}
		return 0;
	}
	
	if ((s1 != NULL) && (!stricmp (s1,"Number"))){
		Stream *str = idx->Open (AUX_NUMBERS);
		if (str) {
			long count;
			str->Read (&count, sizeof (long));
			printf ("Total: %ld\n", count);
			while (str->Tell () < str->Length ()) {
				long packed_size, unpacked_size;
				str->Read (&packed_size, sizeof (long));
				str->Read (&unpacked_size, sizeof (long));
				char* packed_buf = new char [packed_size];
				str->Read (packed_buf, packed_size);
				char* unpacked_buf = new char [unpacked_size], *ptr = unpacked_buf;
				G_UNZIP (packed_buf, packed_size, unpacked_buf, unpacked_size);
				while (ptr - unpacked_buf < unpacked_size) {
					printf ("%s\n", ptr);
					ptr += strlen (ptr) + 1;
				}
				delete [] packed_buf;
				delete [] unpacked_buf;
			}
			idx->Close(str);
		}
		return 0;
	}

	if ((s1 != NULL) && (!stricmp (s1,"RCode"))){
		Stream *str = idx->Open (AUX_NUMBERS_RCODE);
		if (str) {
			long count;
			str->Read (&count, sizeof (long));
			printf ("Total: %ld\n", count);
			while (str->Tell () < str->Length ()) {
				long packed_size, unpacked_size;
				str->Read (&packed_size, sizeof (long));
				str->Read (&unpacked_size, sizeof (long));
				char* packed_buf = new char [packed_size];
				str->Read (packed_buf, packed_size);
				char* unpacked_buf = new char [unpacked_size], *ptr = unpacked_buf;
				G_UNZIP (packed_buf, packed_size, unpacked_buf, unpacked_size);
				while (ptr - unpacked_buf < unpacked_size) {
					printf ("%s\n", ptr);
					ptr += strlen (ptr) + 1;
				}
				delete [] packed_buf;
				delete [] unpacked_buf;
			}
			idx->Close(str);
		}
		return 0;
	}

	if ((s1 != NULL) && (!stricmp (s1, AUX_RELEVANCY_CALCULATED_CHANGES))) {
		Stream *str = idx->Open (AUX_RELEVANCY_CALCULATED_CHANGES);
		if (str) {
			long count;
			str->Read (&count, sizeof (count));
			for (int i = 0; i < count; i++) {
				int rele;
				str->Read (&rele, sizeof (rele));
				fprintf (f, "rele: %ld, docs: ", rele);
				long docs_count, packed_size;
				str->Read (&docs_count, sizeof (docs_count));
				str->Read (&packed_size, sizeof (packed_size));
				long *docs = new long [docs_count], *ptr = docs;
				if (packed_size) {
					char* packed_data = new char [packed_size];
					str->Read (packed_data, packed_size);
					G_UNZIP (packed_data, packed_size, (char*) docs, docs_count * sizeof (long));
					delete [] packed_data;
				} else {
					str->Read (docs, docs_count * sizeof (long));
				}
				for (int j = 0; j < docs_count; j++, ptr++) {
					fprintf (f, "%ld", *ptr);
					if (j < docs_count - 1)
						fprintf (f, ", ");
				}
				fprintf (f, "\n");
				delete [] docs;
			}
		}
		return 0;
	}

	if ((s1 != NULL) && (!stricmp (s1,"Inf7"))){
		Stream *str = idx->Open ("Inf7");
		if ( str ) {
			idx->Close(str);

			str = idx->Open ("InfL");
			long count;
			str->Read (&count, sizeof (long));
			idx->Close(str);

			str = idx -> Open ("Inf7");
			long packed_length = str->Length ();
			fprintf( f, "\nInf7 packed length: %ld\n", packed_length);
			char *unpacked_buffer = (char*) malloc (3096 * sizeof (CommonAttribute));
			while (str->Tell () < str->Length ()) {
				long small_count = std::min <long> (count, 3096), packed_size;
				str->Read (&packed_size, sizeof (long));
				char *packed_buffer = (char*) malloc (packed_size);
				str->Read (packed_buffer, packed_size);
				G_UNZIP (packed_buffer, packed_size, unpacked_buffer, small_count * sizeof (CommonAttribute));
				CommonAttribute *ptr = (CommonAttribute*) unpacked_buffer;
				for (int i = 0; i < small_count; i++, ptr++) {
					long m_published = ptr->m_published;
					long m_changed = ptr->m_changed;
					fprintf( f, "%ld %d %ld/%ld/%ld %ld/%ld/%ld %04X %08X%08X %ld\n", ptr->m_id, (long)ptr->m_force, m_published & 0xFF, (m_published >> 8) & 0xFF, m_published >> 16, m_changed & 0xFF, (m_changed >> 8) & 0xFF, m_changed >> 16, ((long)ptr->m_status) & 0xFFFF, (long)((ptr->mask >> 32) & 0xFFFFFFFF), (long)(ptr->mask & 0xFFFFFFFF), ptr->m_number);
				}
				gk_free (packed_buffer);
				count -= small_count;					
			}
			idx->Close(str);
			gk_free (unpacked_buffer);
		}
		return 0;
	}
	
	if ((s1 != NULL) && (!stricmp (s1, AUX_DSS_FLAGS))){
		Stream *str = idx->Open (AUX_DSS_FLAGS);
		if ( str ) {
			idx->Close(str);

			str = idx->Open (AUX_DSS_FLAGS_LENGTH);
			long count;
			str->Read (&count, sizeof (long));
			idx->Close(str);

			str = idx -> Open (AUX_DSS_FLAGS);
			long packed_length = str->Length ();
			fprintf( f, "\n%s packed length: %ld\n", AUX_DSS_FLAGS, packed_length);
			char *unpacked_buffer = (char*) malloc (4096 * sizeof (DSSAttribute));
			while (str->Tell () < str->Length ()) {
				long small_count = std::min <long> (count, 4096), packed_size;
				str->Read (&packed_size, sizeof (long));
				char *packed_buffer = (char*) malloc (packed_size);
				str->Read (packed_buffer, packed_size);
				G_UNZIP (packed_buffer, packed_size, unpacked_buffer, small_count * sizeof (CommonAttribute));
				DSSAttribute *ptr = (DSSAttribute*) unpacked_buffer;
				for (int i = 0; i < small_count; i++, ptr++) {
					fprintf (f, "%ld :", ptr->m_id);
					bool b_print = false;
					if (ptr->m_flags & DSS_DIC)
						fprintf (f, " DSS_DIC"), b_print = true;
					if (ptr->m_flags & DSS_REF)
						fprintf (f, " DSS_REF"), b_print = true;
					if (ptr->m_flags & DSS_BOOK)
						fprintf (f, " DSS_BOOK"), b_print = true;
					if (ptr->m_flags & DSS_TIP)
						fprintf (f, " DSS_TIP"), b_print = true;
					if (ptr->m_flags & DSS_MEDFIRM)
						fprintf (f, " DSS_MEDFIRM"), b_print = true;
					if (ptr->m_flags & DSS_MEDDICT)
						fprintf (f, " DSS_MEDDICT"), b_print = true;
					if (ptr->m_flags & DSS_MEDTOPIC)
						fprintf (f, " DSS_MEDTOPIC"), b_print = true;
					if (ptr->m_flags & DSS_FLASH)
						fprintf (f, " DSS_FLASH"), b_print = true;
					if (ptr->m_flags & DSS_AAKTOPIC)
						fprintf (f, " DSS_AAKTOPIC"), b_print = true;
					if (ptr->m_flags & DSS_AAKCONTENTS)
						fprintf (f, " DSS_AAKCONTENTS"), b_print = true;
					if (ptr->m_flags & DSS_LIKEABLE)
						fprintf (f, " DSS_LIKEABLE"), b_print = true;
					if (!b_print)
						fprintf (f, " %ld", ptr->m_flags);
					fprintf (f, "\n");
				}
				gk_free (packed_buffer);
				count -= small_count;					
			}
			idx->Close(str);
			gk_free (unpacked_buffer);
		}
		return 0;
	}
	
	if ((s1 != NULL) && (!stricmp(s1,AUX_SIMPLE_SYNS))){
		Stream *str = idx -> Open (AUX_SIMPLE_SYNS);
		if ( str ) {
			fprintf( f, "%s:\n", AUX_SIMPLE_SYNS);
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			idx->Close(str);

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
				printf( "%s\n", ptr);
				pos += length;
				ptr += length;
				long syns = *(long*)ptr;
				ptr += sizeof( long );
				pos += sizeof( long );
				for ( long i = 0; i < syns; i++ ) {
					length = strlen( ptr ) + 1;
					printf( "\t%s\n", ptr);
					ptr += length;
					pos += length;
				}
			}
			free( data );
		}
		return 0;
	}

	if ((s1 != 0) && !strcmp(s1,"Edis")){
		Stream *str = idx -> Open ( "Edis" );
		if ( str ) {
			fprintf( f, "'Edis:'\n" );
			long acount = str->Length() / sizeof( long );
			long* data = new long[ acount ];
			str->Read( data, str->Length() );
			for ( long i = 0; i < acount; i += 2 ) {
				fprintf( f, "%ld %ld\n", data[i], data[i+1] );
			}
			idx->Close(str);
		}
		return 0;
	}
	if ((s1 != 0) && !strcmp(s1,AUX_O_POSITIONS)){
		Stream *str = idx -> Open (AUX_O_POSITIONS);
		if ( str ) {
			fprintf( f, "'PosO:'\n" );
			long acount = str->Length() / sizeof( long );
			long* data = new long[ acount ];
			str->Read( data, str->Length() );
			for ( long i = 0; i < acount; i += 2 ) {
				fprintf( f, "%ld %ld\n", data[i], data[i+1] );
			}
			idx->Close(str);
		}
		return 0;
	}
	if ((s1 != 0) && !strcmp (s1,AUX_MEDTOPICS_SUBNAMES)){
		Stream *str = idx -> Open (AUX_MEDTOPICS_SUBNAMES);
		if ( str ) {
			fprintf( f, "'%s:'\n", AUX_MEDTOPICS_SUBNAMES);
			long size = str->Length();
			char* data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			idx->Close(str);
			while (ptr - data < size) {
				long doc_id = *(long*) ptr; ptr += sizeof (long);
				long count =  *(long*) ptr; ptr += sizeof (long);
				printf ("doc_id: %ld, count: %ld\n", doc_id, count);
				for (int i = 0; i < count; i++) {
					long sub = *(long*) ptr; ptr += sizeof (long);
					printf ("  sub: %ld, name:%s\n", sub, ptr);
					ptr += strlen (ptr) + 1;
				}
			}
			gk_free (data);
		}
		return 0;
	}
	if ((s1 != 0) && !strcmp(s1,"WAno")){
		Stream *str = idx -> Open ( "WAno" );
		if ( str ) {
			fprintf( f, "'WAno:'\n" );
			long acount = str->Length() / sizeof( long );
			long* data = new long[ acount ];
			str->Read( data, str->Length() );
			for ( long i = 0; i < acount; i++ ) {
				fprintf( f, "%ld\n", data[i] );
			}
			idx->Close(str);
		}
		return 0;
	}
	if ((s1 != 0) && !strcmp (s1, AUX_CONTEXT_EVARIANTS)){
		Stream *str = idx -> Open (AUX_CONTEXT_EVARIANTS);
		if ( str ) {
			fprintf (f, "'%s:'\n", AUX_CONTEXT_EVARIANTS);
			long size = str->Length();
			char *data = new char [size], *ptr = data;
			str->Read (data, size);
			idx->Close (str);
			while (ptr - data < size) {
				printf ("%s: ", ptr);
				ptr += strlen (ptr) + 1;
				long count = *(long*) ptr;
				ptr += sizeof (long);
				if (count) {
					for (int i = 0; i < count; i++) {
						printf ("%ld", *(long*)ptr);
						ptr += sizeof (long);
						if (i < count - 1)
							printf (", ");
						else
							printf ("\n");
					}
				} else {
					printf ("0\n");
				}
			}
			delete data;
		}
		return 0;
	}
	if ((s1 != 0) && !strcmp (s1, AUX_CONTEXT_MVARIANTS)){
		Stream *str = idx -> Open (AUX_CONTEXT_MVARIANTS);
		if ( str ) {
			fprintf (f, "'%s:'\n", AUX_CONTEXT_MVARIANTS);
			long size = str->Length();
			char *data = new char [size], *ptr = data;
			str->Read (data, size);
			idx->Close (str);
			while (ptr - data < size) {
				printf ("%s : ", ptr);
				ptr += strlen (ptr) + 1;
				printf ("%s : ", ptr);
				ptr += strlen (ptr) + 1;
				long count = *(long*) ptr;
				ptr += sizeof (long);
				if (count) {
					for (int i = 0; i < count; i++) {
						printf ("%ld", *(long*)ptr);
						ptr += sizeof (long);
						if (i < count - 1)
							printf (", ");
						else
							printf ("\n");
					}
				} else {
					printf ("0\n");
				}
			}
			delete data;
		}
		return 0;
	}
	if ((s1 != 0) && !strcmp(s1,"BaseInfo") && (strno == 0)){
		Stream *str = idx -> Open ( "Base" );
		if ( str )
			if ( 0 != ( size = str -> Length ( ) ) )
			{
				BaseInfo *data = (BaseInfo*) malloc ( size );
				if ( !data ) MemoryError ( );
				int n = str -> Read ( data, size ) / sizeof ( BaseInfo );
				idx -> Close ( str );

				fprintf (f, "Full dump of BaseInfo\n");
				for ( int i = 0; i < n; i++ ){
					fprintf(f," BaseId:%d, ",data [i].BaseId);
					fprintf(f,"Name:'%s', ",data [i].Name);
					fprintf(f,"NameEng:'%s', ",data [i].NameEng);
					fprintf(f,"AuthorName:'%s', ",data [i].AuthorName);
					fprintf(f,"RecCount:%ld, ",data [i].RecCount);
					fprintf(f,"RecSize:%ld, ",data [i].RecSize);
					fprintf(f,"FormsCount:%ld, ",data [i].FormsCount);
					fprintf(f,"GreenComments:%ld, ",data [i].GreenComments);
					fprintf(f,"HyperRefs:%ld, ",data [i].HyperRefs);
					fprintf(f,"LastUpdate.RevisionDate:'%d-%d-%d', ",data [i].LastUpdate.RevisionDate.da_day,data [i].LastUpdate.RevisionDate.da_mon,data [i].LastUpdate.RevisionDate.da_year);
					fprintf(f,"LastUpdate.RevisionTime:'%d:%d:%d.%d', ",data [i].LastUpdate.RevisionTime.ti_hour,data [i].LastUpdate.RevisionTime.ti_min,data [i].LastUpdate.RevisionTime.ti_sec,data [i].LastUpdate.RevisionTime.ti_hund);
					fprintf(f,"Weight:%u, ",data [i].Weight);
					fprintf(f,"UserName:%u, ",data [i].UserName);
					fprintf(f,"CommonDocCount:%ld, ",data [i].CommonDocCount);
					fprintf(f,"CommonDocSize:%ld, ",data [i].CommonDocSize);
					fprintf(f,"SplashTopic:%ld ",data [i].SplashTopic);
					fprintf(f,"BannerTopic:%ld",data [i].BannerTopic);
					fprintf(f,"\n");
				}

				free ( data );
			}
			else
				fprintf ( f, "Empty 'Base' key.\n" );
		else
			fprintf ( f, "No 'Base' key found.\n" );

		return 0;
	} else
	{

///------ 'Here' key in Aux
	Stream *str = idx -> Open ( "Here" );
	if ( str )
		if ( 0 != ( size = str -> Length ( ) ) )
		{
			short *data = (short*) malloc ( size );
			if ( !data ) MemoryError ( );
			int n = str -> Read ( data, size ) / sizeof ( short );
			idx -> Close ( str );

			fprintf ( f, "'Here': " );
			for ( int i = 0; i < n; i++ )
				fprintf ( f, "%hu ", data [i] );
			fprintf ( f, "\n" );
			free ( data );
		}
		else
			fprintf ( f, "Empty 'Here' key.\n" );
	else
		fprintf ( f, "No 'Here' key found.\n" );

///------ 'Base' key in Aux
	str = idx -> Open ( "Base" );
	if ( str )
		if ( 0 != ( size = str -> Length ( ) ) )
		{
			BaseInfo *data = (BaseInfo*) malloc ( size );
			if ( !data ) MemoryError ( );
			int n = str -> Read ( data, size ) / sizeof ( BaseInfo );
			idx -> Close ( str );

			fprintf ( f, "'Base': /*stream len=%d, count=%d, sizeof(BaseInfo)=%d*/:\n",
				size, n, sizeof ( BaseInfo ) );
			for ( int i = 0; i < n; i++ )
				fprintf ( f, "  (%d)\t%s\n",
					data [i].BaseId,
					data [i].Name );
			free ( data );
		}
		else
			fprintf ( f, "Empty 'Base' key.\n" );
	else
		fprintf ( f, "No 'Base' key found.\n" );

	unsigned int i;
	static const char *Root_mask [] = {PR_DOCS, PR_COMMENTS, PR_FORMS, PR_PROJECTS, PR_PRACTICE, PR_INTERS, PR_ACCOUNTING_TRANSACTION};
	for (i = 0; i < sizeof ( Root_mask ) / sizeof ( Root_mask [0] ); i++ ) {
		str = idx -> Open ( Root_mask [i] );
		if ( str ) {
			u_int64_t power, data, j;
			str->Read (&data, sizeof (data));
			fprintf ( f, "'%s': %lld:", Root_mask [i], data);
			for (j = 0, power = 1; j < 64; j++, power <<= 1)
				if (data & power)
					fprintf (f, " %s", ((SearchBase*)b)->kind_uid_to_text (((SearchBase*)b)->kind_bit_to_uid (power)));
			fprintf (f, "\n");
			idx -> Close (str);
		}
	}

	static const char *kind_uids [] = {AUX_KIND_CORRESPONDENTS};
	for (i = 0; i < sizeof ( kind_uids ) / sizeof ( kind_uids [0] ); i++ ) {
		str = idx -> Open ( kind_uids [i] );
		if ( str ) {
			fprintf ( f, "'%s':", kind_uids [i]);
			long count = str->Length () / sizeof (long);
			for (int j = 0; j < count; j++) {
				long data;
				str->Read (&data, sizeof (data));
				fprintf (f, " %ld:%s", data, ((SearchBase*)b)->kind_uid_to_text (data));
			}
			fprintf (f, "\n");
			idx -> Close (str);
		}
	}

	static const char *Rootc [] = {PR_ALL, AUX_SERV, AUX_SYN_EXAMPLE, AUX_RELE_PLUS, AUX_IGNORE_BELONGS, AUX_IGNORE_K3_BELONGS, AUX_IGNORE_GL_BELONGS, AUX_EXCLUDE_WORDS, AUX_EXCLUDE_WORDS_3, AUX_EXCLUDE_WORDS_8, AUX_CLASS6_KEYS, AUX_EXCLUDE_RF, AUX_CONTEXT_VARIANTS, AUX_ERRORS_GOODWORDS, AUX_NOT_NORMALIZE, AUX_ANNO_UIDS, AUX_KIND_UIDS, AUX_STOP_LEMMS, AUX_MPREFIXES, AUX_fPre, AUX_fKnd, AUX_fCla, AUX_fAdo, AUX_fCor, AUX_fPub, AUX_fPJU, AUX_fPHR, AUX_fPBO, AUX_fPPH, AUX_fILF, AUX_BASENAMES, AUX_PartsSpeechAnalyzer, AUX_KIND_GCTX, AUX_KIND_BLOCK, AUX_KIND_BASESEARCH, AUX_RELEVANCY_CHANGES, AUX_HARD, AUX_FILTER_JSONS, AUX_LIST_KINDS, AUX_TOP_LEMMS, AUX_INDEXES_CHANGES, AUX_PERC, AUX_PHRASAL_NORMALIZER, AUX_BASES_LIST, AUX_NAME_SEARCH};

	for (i = 0; i < sizeof ( Rootc ) / sizeof ( Rootc [0] ); i++ ) {
		str = idx -> Open ( Rootc [i] );
		if ( str )
			if ( 0 != ( size = str -> Length ( ) ) ) {
				char *data = (char*) malloc ( size );
				if ( !data ) MemoryError ( );
				int n = str -> Read ( data, size );
				if (n) {
					for(int i=0;((n != 0) && (i < n-1));i++) {
						if (data[i] == '\0') {
							data[i]=';';
						}
					}
				}
				idx -> Close ( str );

				fprintf ( f, "'%s': %s (%d)\n", Rootc [i], data, n );
				free ( data );
			}
			else
				fprintf ( f,"No '%s' key found.\n", Rootc [i] );
		else
			fprintf ( f, "No '%s' key found.\n", Rootc [i] );
	}

	static const char *Rooti [] = { "User", "Cale", "Clas", AUX_CLASS6_CODEX, AUX_CLASS6_CALENDAR, AUX_CLASS6_MSFORMS, AUX_CLASS6_OTHER_BUS, AUX_CLASS6_MONITORING, AUX_CLASS6_HOTINFO, AUX_CLASS6_NEWDOCS, AUX_CLASS6_NAVIGATOR, AUX_CLASS6_SERVICEINFO, AUX_CLASS6_INPHARM_INPHARM, AUX_CLASS6_INPHARM_SEARCH, AUX_CLASS6_INPHARM_CHAPTERS, AUX_CLASS6_INPHARM_LEKS, AUX_CLASS6_INPHARM_FIRMS, AUX_CLASS6_INPHARM_DIC, AUX_TIPS, AUX_MDICS, AUX_CODEPAGE, AUX_VERSION, AUX_DEMO, AUX_CLASS6_TAXFINANCE, AUX_CLASS6_JURISPRUDENCE, AUX_CLASS6_HR, AUX_CLASS6_LAWFORALL, AUX_CLASS6_BUDGETORGS, AUX_INTERNET_BASE, AUX_PACKED_NEWCORR, AUX_PARTS};
	for ( unsigned j = 0; j < sizeof ( Rooti ) / sizeof ( Rooti [0] ); j++ ) {
		str = idx -> Open ( Rooti [j] );
		if ( str )
			if ( 0 != ( size = str -> Length ( ) ) ) {
				int *data = (int*) malloc ( size );
				if ( !data ) MemoryError ( );
				int n = str -> Read ( data, size );
				idx -> Close ( str );

				if ( n != sizeof ( int ) )	// 4 bytes
					printf ( "invalid stream '%s' size", Rooti [j] );
				else
					fprintf ( f, "'%s': %d\n", Rooti [j], *data );
				free ( data );
			}
			else
				fprintf ( f, "No '%s' key.\n", Rooti [j] );
		else
			fprintf ( f, "No '%s' key found.\n", Rooti [j] );
	}
///------ misc user keys in Aux

///------ misc2 integer keys in Aux
	static const char *Rooti2 [] = {"Prt0", "Prt1", "Prt2", "Prt3", "Prt4", "Prt5", "PrtE", "PrtI", "PrtM", AUX_SPLASH, AUX_BANNERS, AUX_MAIN_PAGES, AUX_RELEF_LAWS, AUX_RELE_IZM, AUX_RELE_PLUS8, "sDel", "sUpd", "InfL", AUX_DSS_FLAGS_LENGTH, AUX_FASTSNIPPETS_DOCS, AUX_SHORTLISTSIZE, AUX_RELE_PLUS4, AUX_RELE_Y, AUX_KIND_BITS, AUX_TIME_ONLINECHECKING, AUX_ANNO_LEAFS, AUX_BELONGS_DECISIONSARCHIVE, AUX_IMPORTANT_ANNOS, AUX_HOTINFOTOPIC, AUX_VIP, AUX_IMPORTANT_ANNOS_1, AUX_IMPORTANT_ANNOS_2, AUX_LARGE_DOCS, "csbo", "cshr", "csju", "csnf"};

	for ( unsigned j2 = 0; j2 < sizeof ( Rooti2 ) / sizeof ( Rooti2 [0] ); j2++ ) {
		str = idx -> Open ( Rooti2 [j2] );
		if (str) {
			size = str -> Length ();
			if (!strcmp (Rooti2 [j2], AUX_KIND_BITS)) {
				char *data = (char*) malloc (size), *ptr = data;
				int n = str -> Read (data, size);
				idx -> Close (str);

				fprintf ( f, "'%s': ", Rooti2 [j2] );
				for (long i = 0; i < size / (sizeof (long) + sizeof (u_int64_t)); i++, ptr += sizeof (long) + sizeof (u_int64_t)) {
					fprintf ( f, "%ld %lld ", *(long*) ptr, *(u_int64_t*)(ptr + sizeof (long)));
				}
				fprintf ( f, "\n" );
				free ( data );
			} else if (0 != size) {
				int *data = (int*) malloc ( size );
				if ( !data ) MemoryError ( );
				int n = str -> Read ( data, size );
				idx -> Close ( str );

				if ( n % sizeof ( int ) != 0 )
					printf ( "invalid stream '%s' size", Rooti2 [j2] );

				fprintf ( f, "'%s': ", Rooti2 [j2] );
				for (unsigned i=0;(i < n/sizeof(int));i++){
					fprintf ( f, "%ld ", data[i] );
				}
				fprintf ( f, "\n" );
				free ( data );
			}
			else
				fprintf ( f, "No '%s' key.\n", Rooti2 [j2] );
		} else {
			fprintf ( f, "No '%s' key found.\n", Rooti2 [j2] );
	}
	}

///------ misc short keys in Aux
	static const char *Rootshort [] = { AUX_BELONGS_ENCYCLOPEDIA};
	for ( unsigned j2 = 0; j2 < sizeof ( Rootshort ) / sizeof ( Rootshort [0] ); j2++ ) {
		str = idx -> Open ( Rootshort [j2] );
		if (str) {
			size = str -> Length ();
			if (0 != size) {
				short *data = (short*) malloc ( size );
				if ( !data ) MemoryError ( );
				int n = str -> Read ( data, size );
				idx -> Close ( str );

				if ( n % sizeof ( short ) != 0 )
					printf ( "invalid stream '%s' size", Rooti2 [j2] );

				fprintf ( f, "'%s': ", Rootshort [j2] );
				for (unsigned i=0;(i < n/sizeof(short));i++){
					fprintf ( f, "%ld ", data[i] );
				}
				fprintf ( f, "\n" );
				free ( data );
			}
			else
				fprintf ( f, "No '%s' key.\n", Rootshort [j2] );
		} else {
			fprintf ( f, "No '%s' key found.\n", Rootshort [j2] );
	}
	}

	str = idx -> Open ( AUX_KIND_ANALYSEMASK);
	if (str) {
		u_int64_t mask;
		str->Read (&mask, sizeof (mask));
		fprintf (f, "'AMsk': %lld\n", mask);
		idx->Close(str);
	}

	str = idx -> Open ( "Dics" );
	if ( str ) {
		unsigned short data;
		str->Read (&data, sizeof (data));
		fprintf (f, "'Dics': %ld\n", (long) data);
		idx->Close(str);
	}

	str = idx -> Open ( "TMWM" );
	if ( str ) {
		char *data = (char*) malloc ( str -> Length ( ) );
		if ( !data ) MemoryError ( );
		int n = str -> Read ( data, str -> Length ( ) );
		idx -> Close ( str );
		fprintf ( f, "'TMWM': %s\n", data);
		free(data);
	}
	else
		fprintf ( f, "No 'TMWM' key found.\n" );
	
	str = idx -> Open ( "TMWR" );
	if ( str ) {
		u_int32_t t;
		int n = str -> Read ( &t, str -> Length() );
		idx -> Close ( str );
		fprintf ( f, "'TMWR': %ld\n", t);
	}
	else
		fprintf ( f, "No 'TMWR' key found.\n" );
	
	str = idx -> Open ( "DDM" );
	if ( str ) {
		char *data = (char*) malloc ( str -> Length ( ) );
		if ( !data ) MemoryError ( );
		int n = str -> Read ( data, str -> Length ( ) );
		idx -> Close ( str );
		fprintf ( f, "'DDM': %s\n", data);
		free(data);
	}
	else
		fprintf ( f, "No 'DDM' key found.\n" );
	
	str = idx -> Open ( "DDI" );
	if ( str ) {
		u_int32_t t = 0;
		int n = str -> Read ( &t, str -> Length() );
		idx -> Close ( str );
		fprintf ( f, "'DDI': ");
		if (t & DDI_FOR_WARNING) fprintf ( f, "DDI_FOR_WARNING ");
		if (t & DDI_FOR_DUMMY) fprintf ( f, "DDI_FOR_DUMMY ");
		fprintf ( f, "\n");
	}
	else
		fprintf ( f, "No 'DDI' key found.\n" );

	str = idx -> Open ( "sort" );
	if ( str ) {
		long packed_length = str->Length ();
		fprintf( f, "\nsort packed length: %ld\n", packed_length);
		char* packed_data = (char*) malloc (packed_length);
		str->Read (packed_data, packed_length);
		idx->Close(str);

		str = idx->Open ("InfL");
		long count;
		str->Read (&count, sizeof (long));
		idx->Close(str);
		long* unpacked_data = new long [count], *data = unpacked_data;
		G_UNZIP (packed_data, packed_length, unpacked_data, count * sizeof (long));
		for ( long i = 0; i < count; i++ )
			fprintf( f, "%ld ", data [i]);

		delete unpacked_data;
		gk_free (packed_data);
	}

	return 0;
	}
}

static void printStrSet ( const char *d, u_int32_t s, FILE *f )
{
	if ( s ) {
		int cnt = 0;
		for ( const char *p = d; s; s-- )
			if ( *p == '\0' ) {
				cnt++;
				if (strchr( d, ':' )) {
					long aSub = atol( d );
					if ( aSub & INHERITED_BLOCK )
						fprintf( f, "\t'!%d%s'\n", aSub & MINUS_INHERITED_BLOCK, strchr( d, ':' ));
					else
						fprintf( f, "\t'%d%s'\n", aSub, strchr( d, ':' ));
				}
				else
					fprintf ( f, "\t'%s'\n", d );
				p++;
				d = p;
			}
			else
				p++;

		if ( !cnt )	{
			fprintf ( f     , "Warning: No zero-ended strings ?!\n" );
			printf ( "Warning: No zero-ended strings ?!\n" );
		}
	}
	else
	{
		fprintf ( f     , "Warning: Zero data length ?!\n" );
		printf ( "Warning: Zero data length ?!\n" );
	}
}

static void printStrSetHead ( const char *d, u_int32_t s, FILE *f )
{
	if ( s ) {
		int cnt = 0;
		for ( const char *p = d; s; s-- )
			if ( *p == '\0' ) {
				cnt++;
				fprintf ( f, "\t'%s'\n", d );
				p++;
				d = p;
			}
			else
				p++;

		if ( !cnt )	{
			fprintf ( f     , "Warning: No zero-ended strings ?!\n" );
			printf ( "Warning: No zero-ended strings ?!\n" );
		}
	}
	else
	{
		fprintf ( f     , "Warning: Zero data length ?!\n" );
		printf ( "Warning: Zero data length ?!\n" );
	}
}

static void printStrSetReal ( const char *d, u_int32_t s, FILE *f )
{
	if ( s ) {
		int cnt = 0;
		for ( const char *p = d; s; s-- )
			if ( *p == '\0' ) {
				cnt++;
				fprintf ( f, "\t'%s'\n", d );
				p++;
				d = p;
			}
			else
				p++;

		if ( !cnt )	{
			fprintf ( f     , "Warning: No zero-ended strings ?!\n" );
			printf ( "Warning: No zero-ended strings ?!\n" );
		}
	} else {
		fprintf ( f     , "Warning: Zero data length ?!\n" );
		printf ( "Warning: Zero data length ?!\n" );
	}
}

long b_packed_newcorr = false;

static void printKindCorr ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( KindCorrRef ); s; s--, d += sizeof ( KindCorrRef ) ) {
		KindCorrRef* ref = (KindCorrRef*)d;
		fprintf ( f, "%ld.%llu ", (long)ref->seg, ref->mask);
	}
	fprintf ( f, "\n" );
}

static void printBLOB ( const char *d, u_int32_t s, FILE *f )
{
#ifndef OLDBASE
	ObjInfo *oi = (ObjInfo*) d;

	fprintf ( f, "\n" );

	char aType[sizeof(oi->type)+1];
	memcpy(aType,&oi->type,sizeof(oi->type));
	for (int i=0; i<sizeof(oi->type); i++) if(!aType[i]) aType[i] = ' ';
	aType[sizeof(oi->type)] = 0;
	while(aType[0]==' ') memcpy(aType,aType+1,sizeof(oi->type));

	fprintf ( f, "ObjInfo.size   = %ld\n", (long) oi -> size );
	fprintf ( f, "ObjInfo.crc32  = %x\n", (long) oi -> crc32 );
	fprintf ( f, "ObjInfo.type   = %s\n", aType );

	fprintf ( f, "ObjInfo.packed = %ld\n",  (long) oi -> packed );
	fprintf ( f, "ObjInfo.name   = '%s'\n", oi -> name );
	fprintf ( f, "Stream size = '%ld'\n", s  );
#endif
}

//////////////////////////////////////////////////////////////////////////
static int dump_AtrIndex ( const Base *b, const char *name,
	printKeyFunction printKey, printDataFunction printData,
	FILE *f, const char *s1, const char *s2,
	int quiet, int strno )
{
// name == "Attrs"
// s1 = DocId
// s2 = TagId
	int DocId = atoi ( s1 );
	/*
	if ( !DocId ) {
		printf ( "error in params. use document number\n");
		return 0;
	}
	*/

	AttrKey k;
	k.DocId = DocId;

	if ( !strcmpi ( s2, "IDD_NONE"	      ) ) k.AttrTag = IDD_NONE; else
#ifndef	VERSION61
	if ( !strcmpi (	s2, "IDD_NAME"	      ) ) k.AttrTag = IDD_NAME; else
#endif
	if ( !strcmpi (	s2, "IDD_DATE"	      ) ) k.AttrTag = IDD_DATE; else
	if ( !strcmpi (	s2, "IDD_PROFDATE"    ) ) k.AttrTag = IDD_PROFDATE; else
	if ( !strcmpi (	s2, "IDD_ID"	      ) ) k.AttrTag = IDD_ID; else
	if ( !strcmpi (	s2, "IDD_CHDATE_EXEX" ) ) k.AttrTag = IDD_CHDATE_EXEX; else
	if ( !strcmpi (	s2, "IDD_MARKEDTEXT" ) ) k.AttrTag = IDD_MARKEDTEXT; else
	if ( !strcmpi (	s2, "IDD_ADDCODE"    ) ) k.AttrTag = IDD_ADDCODE; else
	if ( !strcmpi (	s2, "IDD_SOURCE"      ) ) k.AttrTag = IDD_SOURCE; else
	if ( !strcmpi (	s2, "IDD_DIV"	      ) ) k.AttrTag = IDD_DIV; else
	if ( !strcmpi (	s2, "IDD_CLASS6"	      ) ) k.AttrTag = IDD_CLASS6; else
	if ( !strcmpi (	s2, "IDD_KEY"	      ) ) k.AttrTag = IDD_KEY; else
	if ( !strcmpi (	s2, "IDD_HANDMASK"    ) ) k.AttrTag = IDD_HANDMASK; else
	if ( !strcmpi (	s2, "IDD_HANDHANDMASK" ) ) k.AttrTag = IDD_HANDHANDMASK; else
	if ( !strcmpi (	s2, "IDD_TYPE"	      ) ) k.AttrTag = IDD_TYPE; else
	if ( !strcmpi (	s2, "IDD_TAG"	      ) ) k.AttrTag = IDD_TAG; else
	if ( !strcmpi (	s2, "IDD_KIND"	      ) ) k.AttrTag = IDD_KIND; else
	if ( !strcmpi (	s2, "IDD_CHANGE"      ) ) k.AttrTag = IDD_CHANGE; else
	if ( !strcmpi (	s2, "IDD_SERVICEINFO"  ) ) k.AttrTag = IDD_SERVICEINFO; else
	if ( !strcmpi (	s2, "IDD_ANNOUSER"  ) ) k.AttrTag = IDD_ANNOUSER; else
	if ( !strcmpi (	s2, "IDD_PREANNOUSER"  ) ) k.AttrTag = IDD_PREANNOUSER; else
	if ( !strcmpi (	s2, "IDD_ANNOORGANIZATION"  ) ) k.AttrTag = IDD_ANNOORGANIZATION; else
	if ( !strcmpi (	s2, "IDD_PREANNOORGANIZATION"  ) ) k.AttrTag = IDD_PREANNOORGANIZATION; else
	if ( !strcmpi (	s2, "IDD_ANNOTAX"  ) ) k.AttrTag = IDD_ANNOTAX; else
	if ( !strcmpi (	s2, "IDD_PREANNOTAX"  ) ) k.AttrTag = IDD_PREANNOTAX; else
	if ( !strcmpi (	s2, "IDD_ANNOINTEREST"  ) ) k.AttrTag = IDD_ANNOINTEREST; else
	if ( !strcmpi (	s2, "IDD_PREANNOINTEREST"  ) ) k.AttrTag = IDD_PREANNOINTEREST; else
	if ( !strcmpi (	s2, "IDD_ANNOKIND"  ) ) k.AttrTag = IDD_ANNOKIND; else
	if ( !strcmpi (	s2, "IDD_PREANNOKIND"  ) ) k.AttrTag = IDD_PREANNOKIND; else
	if ( !strcmpi ( s2, "IDD_INFO"	      ) ) k.AttrTag = IDD_INFO; else
	if ( !strcmpi (	s2, "IDD_SUBS"	      ) ) k.AttrTag = IDD_SUBS; else
	if ( !strcmpi (	s2, "IDD_SUBS_EX"     ) ) k.AttrTag = IDD_SUBS_EX; else
	if ( !strcmpi (	s2, "IDD_DOCSTRUCT"   ) ) k.AttrTag = IDD_DOCSTRUCT; else
	if ( !strcmpi (	s2, "IDD_EVD"	      ) ) k.AttrTag = IDD_EVD; else
	if ( !strcmpi (	s2, "IDD_RUNS"        ) ) k.AttrTag = IDD_RUNS; else
	if ( !strcmpi (	s2, "IDD_BLOCKS"      ) ) k.AttrTag = IDD_BLOCKS; else
	if ( !strcmpi (	s2, "IDD_BASES"	      ) ) k.AttrTag = IDD_BASES; else
	if ( !strcmpi (	s2, "IDD_PARAIDS"	      ) ) k.AttrTag = IDD2_PARAIDS; else
	if ( !strcmpi (	s2, "IDD_RCODE"	      ) ) k.AttrTag = IDD_RCODE; else
	if ( !strcmpi (	s2, "IDD_CALIN"   ) ) k.AttrTag = IDD_CALIN; else
	if ( !strcmpi (	s2, "IDD_CALAB"   ) ) k.AttrTag = IDD_CALAB; else
	if ( !strcmpi (	s2, "IDD_CALCH"   ) ) k.AttrTag = IDD_CALCH; else
	if ( !strcmpi (	s2, "IDD_VINCLUDED"   ) ) k.AttrTag = IDD_VINCLUDED; else
	if ( !strcmpi (	s2, "IDD_VCHANGED"    ) ) k.AttrTag = IDD_VCHANGED; else
	if ( !strcmpi (	s2, "IDD_VABOLISHED"  ) ) k.AttrTag = IDD_VABOLISHED; else
	if ( !strcmpi (	s2, "IDD_RDATE"	      ) ) k.AttrTag = IDD_RDATE; else
	if ( !strcmpi (	s2, "IDD_SORTDATE"    ) ) k.AttrTag = IDD_SORTDATE; else
	if ( !strcmpi (	s2, "IDD_WARNING"     ) ) k.AttrTag = IDD_WARNING; else
#ifdef	VERSION56
	if ( !strcmpi (	s2, "IDD_ACTIVE"      ) ) k.AttrTag = IDD_ACTIVE; else
	if ( !strcmpi (	s2, "IDD_ACTIVEEX"    ) ) k.AttrTag = IDD_ACTIVEEX; else
	if ( !strcmpi (	s2, "IDD_DIVISION"    ) ) k.AttrTag = IDD_DIVISION; else
	if ( !strcmpi (	s2, "IDD_PAGEBREAKS"  ) ) k.AttrTag = IDD_PAGEBREAKS; else
	if ( !strcmpi (	s2, "IDD_CHDATE"      ) ) k.AttrTag = IDD_CHDATE; else
	if ( !strcmpi (	s2, "IDD_CHDATE_EX"   ) ) k.AttrTag = IDD_CHDATE_EX; else
	if ( !strcmpi (	s2, "IDD_CONTENTS"    ) ) k.AttrTag = IDD_CONTENTS; else
	if ( !strcmpi (	s2, "IDD_COMPARECONTENTS"    ) ) k.AttrTag = IDD_COMPARECONTENTS; else
	if ( !strcmpi (	s2, "IDD_NOTSURE"     ) ) k.AttrTag = IDD_NOTSURE; else
	if ( !strcmpi (	s2, "IDD_REFS"        ) ) k.AttrTag = IDD_REFS; else
	if ( !strcmpi (	s2, "IDD_BLOB"        ) ) k.AttrTag = IDD_BLOB; else
	if ( !strcmpi (	s2, "IDD_PARAHEIGHTS" ) ) k.AttrTag = IDD_PARAHEIGHTS; else
	if ( !strcmpi (	s2, "IDD_BLOBS"       ) ) k.AttrTag = IDD_BLOBS; else
	if ( !strcmpi (	s2, "IDD_REFS_BLOCKS" ) ) k.AttrTag = IDD_REFS_BLOCKS; else
	if ( !strcmpi (	s2, "IDD_TFIDF"       ) ) k.AttrTag = IDD_TFIDF; else
	if ( !strcmpi (	s2, "IDD_SAMEDOCS"    ) ) k.AttrTag = IDD_SAMEDOCS; else
	if ( !strcmpi (	s2, "IDD_SAMES"       ) ) k.AttrTag = IDD_SAMES; else
	if ( !strcmpi (	s2, "IDD_PARAGCTXLENS") ) k.AttrTag = IDD_PARAGCTXLENS; else
	if ( !strcmpi (	s2, "IDD_INVISIBLELENS") ) k.AttrTag = IDD_INVISIBLELENS; else
	if ( !strcmpi (	s2, "IDD_INVISIBLERELES") ) k.AttrTag = IDD_INVISIBLERELES; else
#endif
	if ( !strcmpi (	s2, "IDD_VANONCED"    ) ) k.AttrTag = IDD_VANONCED; else
	if ( !strcmpi (	s2, "IDD_PREANNODATE" ) ) k.AttrTag = IDD_PREANNODATE; else
	if ( !strcmpi (	s2, "IDD_ANNODATE"    ) ) k.AttrTag = IDD_ANNODATE; else
	if ( !strcmpi (	s2, "IDD_VANONCED"    ) ) k.AttrTag = IDD_VANONCED; else
	if ( !strcmpi (	s2, "IDD_VLCONTROL"   ) ) k.AttrTag = IDD_VLCONTROL; else
	if ( !strcmpi (	s2, "IDD_SOURCEFILE"  ) ) k.AttrTag = IDD_SOURCEFILE; else
	if ( !strcmpi ( s2, "IDD_CATEGORY"    ) ) k.AttrTag = IDD_CATEGORY; else
	if ( !strcmpi ( s2, "IDD_PUBLISHEDIN" ) ) k.AttrTag = IDD_PUBLISHEDIN; else
#ifndef OLDBASE
	if ( !strcmpi ( s2, "IDD_TERRITORY"   ) ) k.AttrTag = IDD_TERRITORY; else
	if ( !strcmpi ( s2, "IDD_DOCKIND"     ) ) k.AttrTag = IDD_DOCKIND; else
	if (!strcmpi (s2, "IDD_INPHARMFIRM")) k.AttrTag = IDD_INPHARMFIRM; else
	if (!strcmpi (s2, "IDD_INPHARMCOUNTRY")) k.AttrTag = IDD_INPHARMCOUNTRY; else
	if (!strcmpi (s2, "IDD_REGDATE")) k.AttrTag = IDD_REGDATE; else
	if (!strcmpi (s2, "IDD_ANNULDATE")) k.AttrTag = IDD_ANNULDATE; else
	if (!strcmpi (s2, "IDD_TRADENAME")) k.AttrTag = IDD_TRADENAME; else
	if (!strcmpi (s2, "IDD_INTNAME")) k.AttrTag = IDD_INTNAME; else
	if (!strcmpi (s2, "IDD_PHARMGROUP")) k.AttrTag = IDD_PHARMGROUP; else
	if (!strcmpi (s2, "IDD_PHARMEFFECT")) k.AttrTag = IDD_PHARMEFFECT; else
	if (!strcmpi (s2, "IDD_CHAPTER")) k.AttrTag = IDD_CHAPTER; else
	if (!strcmpi (s2, "IDD_ATC")) k.AttrTag = IDD_ATC; else
	if (!strcmpi (s2, "IDD_REGSTATUS")) k.AttrTag = IDD_REGSTATUS; else
	if (!strcmpi (s2, "IDD_LEKFORM")) k.AttrTag = IDD_LEKFORM; else
	if (!strcmpi (s2, "IDD_MKB")) k.AttrTag = IDD_MKB; else
	if (!strcmpi (s2, "IDD_LIFE")) k.AttrTag = IDD_LIFE; else
	if (!strcmpi (s2, "IDD_NOTLIFE")) k.AttrTag = IDD_NOTLIFE; else
	if (!strcmpi (s2, "IDD_RECIPE")) k.AttrTag = IDD_RECIPE; else
	if (!strcmpi (s2, "IDD_UNRECIPE")) k.AttrTag = IDD_UNRECIPE; else
	if (!strcmpi (s2, "IDD_ALLOWED")) k.AttrTag = IDD_ALLOWED; else
	if (!strcmpi (s2, "IDD_NOTALLOWED")) k.AttrTag = IDD_NOTALLOWED; else
	if (!strcmpi (s2, "IDD_CASECODE")) k.AttrTag = IDD_CASECODE; else
#endif
	if (!s2 [0]) {
		for ( unsigned j = 0; j < sizeof ( TagId ) / sizeof ( TagId [0] ); j++ )
			dump_AtrIndex ( b, name, printKey, printData, f, s1, TagId [j], quiet, strno );
		return 0;
	} else {
		fprintf ( f     , "Warning: Unknown Attribute.\n" );
		printf ( "Warning: Unknown Attribute.\n" );
		return 0;
	}

	DocCollection *all;
	if (!DocId) {
		//all = ((Base*)b)->AllTopics (ID_BORDER);
		all = new DocCollection;
		AttrKey atkey = {0, k.AttrTag};
		for (BTIterator it (((Base*)b)->FindIndex ("Attrs"), &atkey); !it.End (); ++it) {
			AttrKey *key = (AttrKey*)it.Key ();
			if (key->AttrTag != k.AttrTag)
				break;
			all->Insert (&key->DocId);
		}
	} else {
		all = new DocCollection ();
		all->Insert (&DocId);
	}

	for (int i = 0; i < all->ItemCount; i++) {
		DocId = (*all)[i];
		k.DocId = DocId;

		long n = 0;
		char *buf = (char*) ((Base*)b)->LoadAttr (DocId, k.AttrTag, n);
		if (!n)
			continue;

		fprintf ( f, "\n%d -- %s.\n", DocId, s2 );
		fprintf ( f, "Stream length=%d\n", n );

		switch ( k.AttrTag ) {
			 case IDD_SUBS:
				printSubs ( buf, n, f );
				fprintf ( f, "\n" );
				break;

			 case IDD_SUBS_EX:
				printSubsEx ( buf, n, f );
				fprintf ( f, "\n" );
				break;

			 case IDD_DOCSTRUCT:
				printDocStruct ( buf, n, f );
				fprintf ( f, "\n" );
				break;

			 case IDD_EVD:
				printEVD ( buf, n, f );
				fprintf ( f, "\n" );
				break;

			 case IDD_INFO:
			{
			DocInfo *docinfo = (DocInfo*) buf;

			fprintf ( f, "Title: `%s'\n"   , docinfo -> Title );
			fprintf ( f, "Size: %ld\n"     , docinfo -> Size );
			fprintf ( f, "Revision: %d/%d/%d %d:%d:%d\n", docinfo->Revision.RevisionDate.da_day, docinfo->Revision.RevisionDate.da_mon, docinfo->Revision.RevisionDate.da_year, docinfo->Revision.RevisionTime.ti_hour, docinfo->Revision.RevisionTime.ti_min, docinfo->Revision.RevisionTime.ti_sec );
			fprintf ( f, "FirstDate: %d/%d/%d\n", docinfo->FirstDate.da_day, docinfo->FirstDate.da_mon, docinfo->FirstDate.da_year );
			fprintf ( f, "LastDate: %d/%d/%d\n", docinfo->LastDate.da_day, docinfo->LastDate.da_mon, docinfo->LastDate.da_year );
			fprintf ( f, "ParaCount: %ld\n", docinfo -> ParaCount );
			fprintf ( f, "Priority: %d\n"  , docinfo -> Force );
			fprintf ( f, "Comments: %d\n"  , docinfo -> GreenComments );
			fprintf ( f, "Status: (0x%04X) ", docinfo -> Status );

			if ( docinfo -> Status & DS_ACTIVE     ) fprintf ( f, " DS_ACTIVE" );
			if ( docinfo -> Status & DS_ABOLISHED  ) fprintf ( f, " DS_ABOLISHED" );
			if ( docinfo -> Status & DS_PREACTIVE  ) fprintf ( f, " DS_PREACTIVE" );
			if ( docinfo -> Status & DS_MOJREG     ) fprintf ( f, " DS_MOJREG" );
			if ( docinfo -> Status & DS_MOJNOTREG  ) fprintf ( f, " DS_MOJNOTREG" );
			if ( docinfo -> Status & DS_MOJOTHER   ) fprintf ( f, " DS_MOJOTHER" );
			if ( docinfo -> Status & DS_ANNO       ) fprintf ( f, " DS_ANNO" );
			if ( docinfo -> Status & DS_NODOC      ) fprintf ( f, " DS_NODOC" );
			if ( docinfo -> Status & DS_DOC	       ) fprintf ( f, " DS_DOC" );
			if ( docinfo -> Status & DS_WARNING    ) fprintf ( f, " DS_WARNING" );
			if ( docinfo -> Status & DS_WWW        ) fprintf ( f, " DS_WWW" );
			if ( docinfo -> Status & DS_REFDOC     ) fprintf ( f, " DS_REFDOC" );
	#ifdef	VERSION56
			if ( docinfo -> Status & DS_EDITION    ) fprintf ( f, " DS_EDITION" );
			if ( docinfo -> Status & DS_EVD        ) fprintf ( f, " DS_EVD"     );
			if ( docinfo -> Status & DS_NOTTM      ) fprintf ( f, " DS_NOTTM" );
			if ( docinfo -> Status & DS_BOOK       ) fprintf ( f, " DS_BOOK" );
	#endif
			fprintf ( f, "\n" );

			fprintf ( f, "Status_ex: (0x%04X) ", docinfo -> Status_ex );
			if (docinfo -> Status_ex & DS_MEDTOPIC) fprintf (f, " DS_MEDTOPIC" );
			if (docinfo -> Status_ex & DS_FIRMTOPIC) fprintf (f, " DS_FIRMTOPIC" );
			if (docinfo -> Status_ex & DS_NARCOTIC) fprintf (f, " DS_NARCOTIC" );
			if (docinfo -> Status_ex & DS_LIFE) fprintf (f, " DS_LIFE" );
			if (docinfo -> Status_ex & DS_UNRECIPE) fprintf (f, " DS_UNRECIPE" );
			if (docinfo -> Status_ex & DS_ALLOWED) fprintf (f, " DS_ALLOWED" );
			if (docinfo -> Status_ex & DS_MDICTTOPIC) fprintf (f, " DS_MDICTTOPIC" );
			if (docinfo -> Status_ex & DS_IZM) fprintf (f, " DS_IZM" );
			if (docinfo -> Status_ex & DS_RECIPE) fprintf (f, " DS_RECIPE" );
			if (docinfo -> Status_ex & DS_NOTNARCOTIC) fprintf (f, " DS_NOTNARCOTIC" );
			if (docinfo -> Status_ex & DS_NOTLIFE) fprintf (f, " DS_NOTLIFE" );
			if (docinfo -> Status_ex & DS_NOTALLOWED) fprintf (f, " DS_NOTALLOWED" );
			if (docinfo -> Status_ex & DS_FLASH) fprintf (f, " DS_FLASH" );
			if (docinfo -> Status_ex & DS_NOCOMPARE) fprintf (f, " DS_NOCOMPARE" );
			if (docinfo -> Status_ex & DS_DATE) fprintf (f, " DS_DATE" );
			fprintf ( f, "\n" );

			unsigned short status_exex = GetDocStatusExEx (docinfo);
			fprintf ( f, "Status_exex: (0x%04X) ", status_exex);
			if (status_exex & DS_AAKCONTENT) fprintf (f, " DS_AAKCONTENT" );
			if (status_exex & DS_AAKTEXT) fprintf (f, " DS_AAKTEXT" );
			fprintf ( f, "\n" );

			fprintf ( f,"Related: %ld\n", docinfo -> Related );
			fprintf ( f,"Anno: %ld\n", GetDocMonitoring(docinfo));
	#ifdef	VERSION56
			fprintf ( f,"prevEdition: %ld\n", docinfo -> prevEdition );
			fprintf ( f,"nextEdition: %ld\n", docinfo -> nextEdition );
			fprintf ( f,"lastParaID: %ld\n",  docinfo -> lastParaID  );

			u_int64_t resps = GetDocRespondents64 (docinfo), power, j;
			fprintf ( f,"Respondents: (%lld) ", resps);
			for (j = 0, power = 1; j < 64; j++, power <<= 1)
				if (resps & power)
					fprintf (f, " %s", ((SearchBase*)b)->kind_uid_to_text (((SearchBase*)b)->kind_bit_to_uid (power)));
			fprintf ( f, "\n" );

	#endif
			} break;

			case IDD_BASES:
				printInt16A ( buf, n, f );
				fprintf ( f, "\n" );
			break;

			case IDD2_PARAIDS:
				printInt32A ( buf, n, f );
				fprintf ( f, "\n" );
			break;

			case IDD_REGDATE:
			case IDD_ANNULDATE:
				printDateB ( buf, n, f );
				fprintf ( f, "\n" );
			break;

			case IDD_CALIN:
			case IDD_CALAB:
			case IDD_CALCH:
			case IDD_DATE:
			case IDD_PROFDATE:
			case IDD_RDATE:
			case IDD_VANONCED:
			case IDD_PREANNODATE:
			case IDD_ANNODATE:
			case IDD_VINCLUDED:
			case IDD_VABOLISHED:
			case IDD_VLCONTROL:
			case IDD_SORTDATE:
			case IDD_VCHANGED:
				printDateA ( buf, n, f );
				fprintf ( f, "\n" );
			break;

			case IDD_REFS_BLOCKS:
			case IDD_PARAHEIGHTS:
				{
				long count = n / ( sizeof(long) * 2 );
				long* ati = (long*) buf;
				for ( int i = 0; i < count; i++ ) {
					printf( "%ld.", *ati );
					ati++;
					printf( "%ld\n", *ati );
					ati++;
				}
			}
			break;

			case IDD_TFIDF: {
				long count = n / sizeof (lemma_tfidf);
				lemma_tfidf* ati = (lemma_tfidf*) buf;
				for ( int i = 0; i < count; i++, ati++ )
					printf( "%s:%f\n", ati->lemma, ati->tfidf );
			}
			break;

			case IDD_CHANGE: {
				long count = n / sizeof (IddChangeStruct);
				IddChangeStruct *ati = (IddChangeStruct*) buf;
				for (int i = 0; i < count; i++, ati++)
					printf( "!CHANGE %ld %c\n", ati->id, ati->reason);
			}
			break;

			case IDD_PARAGCTXLENS:
			case IDD_INVISIBLERELES:
			{
				long count = n / (sizeof (long) * 2), *ati = (long*) buf;
				for ( int i = 0; i < count; i++, ati+=2)
					printf( "%ld.%ld\n", *ati, *(ati+1));
			}
			break;
			case IDD_INVISIBLELENS:
			{
				long count = n / (sizeof (long) * 3), *ati = (long*) buf;
				for ( int i = 0; i < count; i++, ati+=3)
					printf( "%ld.%ld.%ld\n", *ati, *(ati+1), *(ati+2));
			}
			break;

			case IDD_SAMEDOCS: {
				long count = n / sizeof (DocRele);
				DocRele* ati = (DocRele*) buf;
				for ( int i = 0; i < count; i++, ati++ )
					printf( "%ld.%ld\n", ati->DocId, ati->Rele );
			}
			break;

			case IDD_SAMES: {
				long count = n / sizeof (SameRele);
				SameRele* ati = (SameRele*) buf;
				for ( int i = 0; i < count; i++, ati++ )
					printf( "%ld:%ld.%ld.%ld\n", ati->Sub, ati->ref.DocId, ati->ref.Sub, ati->Rele );
			}
			break;

			case IDD_SOURCEFILE:
				printStrSetReal ( buf, n, f );
				break;

	#ifndef	VERSION61
			case IDD_NAME:
	#endif
			case IDD_DOCKIND:
			case IDD_TYPE:
			case IDD_KIND:
			case IDD_SERVICEINFO:
			case IDD_DIV:
			case IDD_CLASS6:
			case IDD_KEY:
			case IDD_PUBLISHEDIN:
			case IDD_TRADENAME:
			case IDD_INTNAME:
			case IDD_INPHARMFIRM:
			case IDD_INPHARMCOUNTRY:
			case IDD_ATC:
			case IDD_REGSTATUS:
			case IDD_LEKFORM:
			case IDD_CASECODE:
			case IDD_TAG:
				printStrSet (buf, n, f);
				break;

			case IDD_TERRITORY:
			case IDD_SOURCE:
			case IDD_WARNING:
			case IDD_CATEGORY:
			case IDD_RCODE:
			case IDD_ID:
			case IDD_CHDATE_EXEX:
			case IDD_ADDCODE:
			case IDD_PREANNOUSER:
			case IDD_ANNOUSER:
			case IDD_PREANNOORGANIZATION:
			case IDD_ANNOORGANIZATION:
			case IDD_PREANNOTAX:
			case IDD_ANNOTAX:
			case IDD_PREANNOINTEREST:
			case IDD_ANNOINTEREST:
			case IDD_PREANNOKIND:
			case IDD_ANNOKIND:
			case IDD_HANDMASK:
			case IDD_HANDHANDMASK:
			case IDD_PHARMGROUP:
			case IDD_PHARMEFFECT:
			case IDD_CHAPTER:
			case IDD_MKB:
				printStrSetHead ( buf, n, f);
				break;


			case IDD_NOTLIFE:
			case IDD_LIFE:
			case IDD_UNRECIPE:
			case IDD_RECIPE:
			case IDD_ALLOWED:
			case IDD_NOTALLOWED:
			case IDD_BLOB:
				printInt32A ( buf, n, f );
				fprintf ( f, "\n" );
				break;

	#ifdef	VERSION56
			case IDD_ACTIVE:
				printActiveSet( buf, n, f );
				break;
			case IDD_ACTIVEEX:
				printActiveExSet( buf, n, f );
				break;
			case IDD_DIVISION:
				printDivision( buf, n, f );
				break;
			case IDD_PAGEBREAKS:
				printPageBreaks( buf, n, f );
				break;
			case IDD_CHDATE:
				printChDate( buf, n, f );
				break;
			case IDD_CHDATE_EX:
				printChDateEx( buf, n, f );
				break;
			case IDD_NOTSURE:
				printNotSure( buf, n, f );
				break;
			case IDD_REFS:
				printRefs( buf, n, f );
				break;
			case IDD_CONTENTS:
				printContents( buf, n, f );
				break;
			case IDD_COMPARECONTENTS:
				printCompareContents( buf, n, f );
				break;
			case IDD_BLOBS:
				printBlobInfos( buf, n, f );
				break;

			case IDD_MARKEDTEXT:
				printMarkedText (buf, n, f);
				break;
	#endif

			default:
			fprintf ( f, "Don't know how to handle attribute 0x%X.\n", k.AttrTag );
		}

		gk_free (buf);
	}
	return 0;
}

#ifdef RD_RDONLY
int GetFirstParaFromDoc( FILE *f, const Base *b, long docID)
{
	DocInfo info;
	if ( ((YBase*)b)->FindDocAttr ( docID, IDD_INFO, &info, sizeof (info) ) != sizeof (info) )
		abort();
	if ( !((YBase*)b)->IsBaseOn1CD())
	{
		int	aNeed;
		fprintf ( f, "\n\n");
		while( ((YBase*)b)->m_iFirstCD != ( aNeed = ((YBase*)b)->GetDocTmNumber( docID )))
		{
			fprintf ( f, "\rChange disk N %d ? (Y or N): ", aNeed + 1);
			if((((YBase*)b)->textFile->m_readed.iPost
					=(((YBase*)b)->textFile->m_readed.MessageForNextFunc)())){
				abort();
			}
			b->textFile->m_readed.currentDisk= aNeed;
			*strchr(b->textFile->FileName, '.')= 0;
			((YBase*)b)->reConnectKeyAndStr(b->textFile->FileName, ACE_OS_O_RDONLY);
			*strchr(b->textFile->FileName, 0)= '.';
		}
	}
	Document *pDoc= ((YBase*)b)->GetDoc(docID);
	char *ptr;
	int ret = (ptr= pDoc->GetPara(0)) != 0;
	if(ret){
		fprintf ( f, "\n\nFirst Para form Document N %d\n\n", docID);
		unsigned len = TextSize( ptr );
		const char *src = ParaText ( ptr );
		fwrite(src, len, 1, f );
		fputc('\n', f);
	}
	delete pDoc;
	return ret;
}
void TestNewCorr(FILE *f, const Base *b)
{
	int first= 0;
	LongIndex *nCorr= (LongIndex *)((Base *)b) -> FindIndex ( "NewCorr" );
	if(!nCorr)
		abort();
	for ( BTIterator it_nCorr ( nCorr ); !it_nCorr.End ( ); ++it_nCorr ){
		if(!first++){
			fprintf ( f, "\n\nFirst Key in NewCorr [");
			key_printInt32(it_nCorr.Key (),f);
			fprintf ( f, "] -> ");
			Stream *sss= nCorr->Open(it_nCorr.Key ());
			if(!sss)
				abort();
			int l = sss -> Length ( );
			char *buf = (char *) malloc ( l );
			sss->Read( buf, l );
			nCorr->Close(sss);
			printRefA(buf, l, f);
			free(buf);
		}
	}
}
#include "conio.h"
#endif

static int curr_max= -1;

const char *headerflag = "hdr", *invisibleflag = "inv", *invisibleblock = "blc", *unknownflag = "???";

const char* contextsearch_flags (long d)
{
	d &= GKDB_POS_FLAGS;
	if (d == GKDB_POS_HEADER)
		return headerflag;
	else if (d == GKDB_POS_INVISIBLE)
		return invisibleflag;
	else if (d == GKDB_POS_INVISIBLE_BLOCK)
		return invisibleblock;
	return unknownflag;
}

void printWContxtAll ( const char *start, u_int32_t s, FILE *f, char *pArrayS )
{
	long count, pre;
	const unsigned char *d= (const unsigned char*) start;
	bool printWContxtMulti= false;
	if(0x80000000 & *(long*)d){
		printWContxtMulti= true;
		*(long*)d &= 0x7fffffff;
	}
	while (((u_int32_t)d - (u_int32_t)start) < s) {
		fprintf (f, "\n%d(", *(long*)d ); d += sizeof (long);
		count = 1;
		pre= 0;
		while (count--) {
			if(!(*(long*)d & 0x4000))
				count++;
			long atd, PosV;
			if(printWContxtMulti){
				if((*(long*)d & 0x8000)){
					atd= (((*(long*)d) & 0xff0000) >> 2) | ((*(long*)d) & 0x3fff);
					d += 3;
				}else{
					atd= (*(long*)d) & 0x3fff;
					d += 2;
				}
				PosV= (atd+pre)>>2;
				if (count)
					if (atd & GKDB_POS_FLAGS)
						fprintf (f, "%d[%s%ld].%d ", atd+pre, contextsearch_flags (atd+pre), PosV, *d);
					else
						fprintf (f, "%d.%d ", PosV, *d);
				else
					if (atd & GKDB_POS_FLAGS)
						fprintf (f, "%ld[%s%ld].%d)", atd+pre, contextsearch_flags (atd+pre), PosV, *d);
					else
						fprintf (f, "%d.%d)", PosV, *d);
				pre += atd & 0x3ffffc;
				d++;
			}else{
				if((*(long*)d & 0x8000)){
					atd= (((*(long*)d) & 0xff0000) >> 2) | ((*(long*)d) & 0x3fff);
					d += 3;
				}else{
					atd= (*(long*)d) & 0x3fff;
					d += 2;
				}
				PosV= (atd+pre)>>2;
				if (count)
					if (atd & GKDB_POS_FLAGS)
						fprintf (f, "%ld[%s%ld] ", atd + pre, contextsearch_flags (atd+pre), PosV);
					else
						fprintf (f, "%d ", PosV);
				else
					if (atd & GKDB_POS_FLAGS)
						fprintf (f, "%ld[%s%ld])", atd + pre, contextsearch_flags (atd+pre), PosV);
					else
						fprintf (f, "%d)", PosV);
				pre += atd & 0x3ffffc;
			}
		}
	}
	fprintf (f, "\n");
	fflush (f);
}

/////////////////////////////////////////
static int dump_RawIndex ( const Base *b, const char *name,
	printKeyFunction printKey, printDataFunction printData,
	FILE *f, const char *s1, const char *s2,
	int quiet, int strno )
{
	if (!strcmp (name, "NewCorr")) {
		b_packed_newcorr = false;
		Stream *str = ((Base*)b)->FindIndex ("Aux")->Open (AUX_PACKED_NEWCORR);
		if (str) {
			str->Read (&b_packed_newcorr, sizeof (b_packed_newcorr));
			((Base*)b)->FindIndex ("Aux")->Close (str);
		}
	}
#ifdef RD_RDONLY
	int aBlobTom= 0;
	if(!GetFirstParaFromDoc(f,b,10103000))
		abort();

	TestNewCorr(f,b);

	Index *blb = ((Base *)b) -> FindIndex ( "Blob" );
	long blbID= 994454;
	Stream *bbb= blb->Open(&blbID);
	if(bbb && bbb->Pos == MAX_BYTE_FILE_SIZE){
		fprintf ( f, "\n\n");
		while ( ((YBase*)b)->m_iFirstCD != ( aBlobTom = ((YBase*)b)->GetObjTmNumber()) - 1 && aBlobTom > 0 )
		{
			fprintf ( f, "\rChange disk N %d ? (Y or N): ", aBlobTom );
			if((((YBase*)b)->textFile->m_readed.iPost
					=(((YBase*)b)->textFile->m_readed.MessageForNextFunc)())){
				abort();
			}
			// Ñìåíèòå äèñê ñ ¹ aBlobTom //
			b->textFile->m_readed.currentDisk= aBlobTom;
			*strchr(b->textFile->FileName, '.')= 0;
			((YBase*)b)->reConnectKeyAndStr(b->textFile->FileName, ACE_OS_O_RDONLY);
			*strchr(b->textFile->FileName, 0)= '.';
		}
	}
	if(bbb){
		int l = bbb -> Length ( );
		char *buf = (char *) malloc ( l );
		bbb -> Read ( buf, l );
		blb->Close(bbb);
		printBLOB(buf, l, f);
		free(buf);
	}
	TestNewCorr(f,b);
	if(!GetFirstParaFromDoc(f,b,12133449))
		abort();
	TestNewCorr(f,b);
	if(!GetFirstParaFromDoc(f,b,10103000))
		abort();
	TestNewCorr(f,b);
	fprintf ( f, "\n\n Test End. Press any key to continue GKDUPMI ..." );
	getch();
	fprintf ( f, "Working on RAW index %s.\n", name );
#endif
	Index *idx = ((Base*)b)->FindIndex (name);

	if ( !idx )
	{
		fprintf ( f     , "Can't found index '%s'.\n", name );
		printf ( "Can't found index '%s'.\n", name );
		return 1;
	}
	if(!idx->streams->Fat)
		idx->streams->LoadFat();

	fprintf ( f, "Index exists and claims:\n" );
	fprintf ( f, "KeyCount: %ld\n", idx -> KeyCount );
	fprintf ( f, "KeyLength: %d\n", idx -> KeyLength );
	fprintf ( f, "Btree height: %d\n", idx -> Height );
	fprintf ( f, "----- Key dump follows: -----\n" );

	int count = 0;
	bool isMixed= false;
	BTIterator *scnd= 0;

	bool b_dump_ngrams = false;

	if ( s1 ) {
		// dump only this key
		void * k = 0;

		if (	!strcmp(name,"Date")	||
				!strcmp(name,"RDate")	||
				!strcmp(name,"Active")	||
				!strcmp(name,"VIncluded")	||
				!strcmp(name,"CalIn")	||
				!strcmp(name,"CalAb")	||
				!strcmp(name,"CalCh")	||
				!strcmp(name,"VChanged")	||
				!strcmp(name,"VAbolished")	||
				!strcmp(name,"VAnonced")	||
				!strcmp(name,"AnnoDate")	||
				!strcmp(name,"VLControl")	||
				!strcmp(name,"SortDate")) {
			date * k_date = new date;
			bzero((caddr_t)k_date,sizeof(date));

			const char *p = s1, *q = strchr(p,'/');
			k_date->da_day = atoi(p);
			p = q+1; q = strchr(p,'/');
			k_date->da_mon = atoi(p);
			k_date->da_year = atoi(q+1);

			k = k_date;
		}
		else if (	!strcmp(name,"Respondent")	||
					!strcmp(name,"Correspondent")	||
#ifdef	VERSION56
					!strcmp(name,"NewCorr")	||
#endif
					!strcmp(name,"Segment")	||
					!strcmp(name,"Status")	||
					!strcmp(name,"Status_ex") ||
					!strcmp(name,"Blob")) {
			u_int32_t * k_int = new u_int32_t;
			(*k_int) = atoi(s1);
			k = k_int;
		}
		else if (	!strcmp(name,"Category")	||
					!strcmp(name,"Tag")	||
					!strcmp(name,"Number")	||
					!strcmp(name,"RCode")	||
					!strcmp(name,"Context")) {
			k = (void*)s1;
		}
		else if (!strcmp(name,"SubName")) {
			Ref * k_ref = new Ref;
			bzero((caddr_t)k_ref,sizeof(Ref));

			const char * p = strchr(s1,'.');
			if (p) {
				k_ref->DocId = atoi(s1);
				k_ref->Sub = atoi(p+1);
				k = k_ref;
			} else {
				long doc_id = atol (s1);
				for ( BTIterator it ( idx ); !it.End ( ); ++it ) {
				    Ref *key = (Ref*) it.Key ();
					if (key->DocId == doc_id) {
						printKey ( key, f );
						fprintf ( f, ": " );
						Stream *str = idx -> OpenN ( key, strno );
						if ( str ) {
							int l = str -> Length ( );
							char *buf = (char *) malloc ( l+16 );
							str -> Read ( buf, l );
							idx->Close (str);
							printData ( buf, l, f );
							fputc ( '\n', f );
							free ( buf );
						}
					}
				}
				return 0;
			}
		}
		else if (!strcmp(name,"KindCorr")){
			Ref * k_ref = new Ref;
			bzero((caddr_t)k_ref,sizeof(Ref));

			const char * p = strchr(s1,'.');
			if (p) {
				k_ref->DocId = atoi(s1);
				k_ref->Sub = atoi(p+1);

				k = k_ref;
			} else {
				long doc_id = atol (s1);
				for ( BTIterator it ( idx ); !it.End ( ); ++it ) {
				    Ref *key = (Ref*) it.Key ();
					if (key->DocId == doc_id) {
						printKey ( key, f );
						fprintf ( f, ": " );
						Stream *str = idx -> OpenN ( key, strno );
						if ( str ) {
							int l = str -> Length ( );
							char *buf = (char *) malloc ( l+16 );
							str -> Read ( buf, l );
							idx->Close (str);
							printData ( buf, l, f );
							fputc ( '\n', f );
							free ( buf );
						}
					}
				}
				return 0;
			}
		}
		else if (!strcmp (name, "NWCntxt")) {
			if (!strcmp (s1, "-")) {
				b_dump_ngrams = true;
				goto dumpAll;
			} else {
				DBCore::IBase_var obj = DBCore::DBFactory::make ((Base*) b);
				Morpho::Def::ICache_var cache = Morpho::Factory::make ();
				cache->load (obj.in (), true);
				Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (cache.in ());
				Core::Aptr <GCL::StrSet> res = normalizer->execute (std::string (s1), true);
				k = strdup (res->begin ()->c_str ());
			}
		} else if (!strcmp (name, "SWords")) {
			long id = atol (s1);
			k = &id;
		} else if (!strcmp (name, "NFContxt")) {
			k = (void*) s1;
		}

		bool b_medfirm = false;
		if (!strcmp (name, "Status_ex") && *(int*)k == (DS_MEDTOPIC + DS_FIRMTOPIC))
			b_medfirm = true;
	    else
			printKey ( k, f );

	    if ( printData ) {
			if (b_medfirm) {
				DocCollection docs;
				int i;
				for (i = 0; i < 2; i++) {
					short status = i ? DS_MEDTOPIC : DS_FIRMTOPIC;
					Stream *str = idx->Open (&status);
					if (str) {
						DocCollection strdocs;
						strdocs.FastLoadRefs (str);
						docs.Merge (strdocs);
						idx->Close (str);
					}
				}
				fprintf (f, "inpharm:");
				for (i = 0; i < docs.ItemCount; i++)
					fprintf (f, " %ld", docs [i]);
				fprintf (f, "\n");
			} else {
				fprintf ( f, ": " );
				Stream *str = idx -> OpenN ( k, strno );
				if ( str ) {
					bool printWContxtMulti= false, firstDocOut= true;
					int l = str -> Length ( );
					char *buf = (char *) malloc ( l+16 );
					str -> Read ( buf, l );
					if(!strno && idx->nstreams == 3){
						char *new_data= 0, *new_write;
						u_int32_t nxt_sz= 0;

						if(idx -> recordData(str->IndexBuf,1)->header.realDataLength > 32)
							printWContxtMulti= true;
						idx -> Close ( str );
						str= idx -> OpenN ( k, 2 );
						int l0 = str -> Length ( );
						if(!(new_write=(new_data= (char*)malloc(l/2+l0+idx->streams->file->PageSize)))){
							idx -> Close ( str );
						}
						char *pRefs= buf;
						l0= l;
						do{
							memcpy(new_write, pRefs, 4);
							if(firstDocOut && printWContxtMulti){
								firstDocOut= false;
								(*(long*)new_write) |= 0x80000000;
							}
							nxt_sz= ((Ref*)pRefs)->Sub - nxt_sz;
							new_write += 4;
							str -> Read ( new_write, nxt_sz );
							new_write += nxt_sz;
							nxt_sz= ((Ref*)pRefs)->Sub;
							pRefs += sizeof(Ref);
							l0 -= sizeof(Ref);
						}while(l0);
						free(buf);
						buf= new_data;
						l= new_write - new_data;
						idx -> Close ( str );
						str= idx -> OpenN ( k, 1 );
						l0 = str->Length()/32;
						char *pAA= (char*)calloc(33, l0+1), *pOutAA= pAA;
						while(l0--){
							str->Read(pOutAA,32);
							pOutAA += 33;
						}
						printWContxtAll ( buf, l, f, pAA );
						free(pAA);
					} else {
						idx -> Close ( str );
						printData ( buf, l, f );
					}
					fputc ( '\n', f );
					free ( buf );
				} else {
					fprintf ( f, " has no stream.\n" );
				}
			}
		} else {
			fprintf ( f, "\n" );
		}
	} else {
dumpAll:
	    const void *key = 0;
		Stream *str= 0;
		bool repeatOut= false;
		if(!strcmp (name, "NWCntxt")){
			Index *tst = ((Base*)b)->FindIndex ("Context.str");
			if(tst->KeyCount > 1){
				scnd= new BTIterator(tst);
				while(!scnd->End ( ) && !(*(char*)scnd->Key ())) ++(*scnd);
				isMixed= true;
			}
		}
		int NotAllPrint= 1;
		for ( BTIterator it ( idx ); !it.End ( ); ++it ) {
			/*if(!NotAllPrint || (!memcmp(((char*)(it.Key()))+1, "ÏÓÒÈÍ", 6) 
					//|| !memcmp(((char*)(it.Key()))+1, "ÏÓÒÈÍÀ", 7)
																		))
					;
			else
				continue;*/
			do{
		// dump all keys
	    key = 0;
		str= 0;
		repeatOut= false;
		if(!isMixed){
			key = it.Key ( );
			if (b_dump_ngrams) {
				if (strchr ((char*)key + 1, '-') == 0)
					continue;
			}

			if (!strcmp (name, "Context") && ((*(unsigned char*)key & 0x40) || (*(unsigned char*)key == 0) /*|| (*(unsigned char*)key & 0x80)*/)) {
				char tmpZZZ[32+1];
				if(*(unsigned char*)key & 0x40) {
					fprintf ( f, "F(%s)", ((char*)key+1) );
					if ( printData ) {
						fprintf ( f, ": ");
						str = idx->keyOpen( key, strno );
						int l = str -> Length ( );
						char *buf = (char *) malloc ( l+16 );
						str -> Read ( buf, l );
						printNFContxt (buf, l, f);
						idx -> Close ( str );
						free ( buf );
					} else {
						fprintf ( f, "\n");
					}
				} else if(*(unsigned char*)key == 0) {
					fprintf ( f, "W(%d)\n", *(long*)((char*)key+1) );
				} else if(*(unsigned char*)key & 0x80) {
					memcpy(tmpZZZ, (char*)key+1, (*(unsigned char*)key & 0x7f) - 1);
					tmpZZZ[(*(unsigned char*)key & 0x7f) -1]= 0;
					fprintf ( f, "P(%s)\n", tmpZZZ );
				}else{
					memcpy(tmpZZZ, (char*)key+1, (*(unsigned char*)key & 0x7f) - 1);
					tmpZZZ[(*(unsigned char*)key & 0x7f) -1]= 0;
					fprintf ( f, "N(%s)\n", tmpZZZ );
				}
				continue;
			}

			printKey ( key, f );
			if ( printData )
				str = idx->keyOpen( key, strno );
			else
				str = idx->keyOpen( key, 0 );
		}else{
			int retC= 1;
			if( scnd && (retC= idx->Compare(scnd->Key (),it.Key ( ))) < 0){
				key = scnd->Key ( );
				//if(!memcmp(((char*)key)+1, "ISDOC", 6))
				//	repeatOut= true;
				repeatOut= true;
				if ( printData )
					str = ((Index*)(scnd->tree))->keyOpen( key, strno );
				else
					str = ((Index*)(scnd->tree))->keyOpen( key, 0 );
			}else{
				key = it.Key ( );
				//if(!memcmp(((char*)key)+1, "ÏÓÒÈÍ", 6))
				//	key = key;
				{
					if ( printData )
						str = idx->keyOpen( key, strno );
					else
						str = idx->keyOpen( key, 0 );
				}
			}
			if(!retC){
				++(*scnd);
				if((*(char*)scnd->Key ()) & 0x40){
					delete scnd;
					scnd= 0;
				}
			}
		}
	    if ( printData ) {
			if(!isMixed) { fprintf ( f, ": " );count++; }
			if ( str ) {
				bool printWContxtMulti= false, firstDocOut= true;
				if(isMixed && (++count)) { printKey ( key, f ); fprintf ( f, ": " );}
				int l = str -> Length ( );
				char *buf = (char *) malloc ( l+16 );

				str -> Read ( buf, l );
				if(!strno && idx->nstreams == 3){
					char *new_data= 0, *new_write;
					u_int32_t nxt_sz= 0;

					idx -> Close ( str );
					if(idx -> recordData(key,1)->header.realDataLength > 32)
						printWContxtMulti= true;
					if(repeatOut){
						str = ((Index*)(scnd->tree))->keyOpen( key, 2 );
					}else
						str= idx -> keyOpen( key, 2 );
					if(!str){
						continue;
					}
					int l0 = str -> Length ( );
					if(!(new_write=(new_data= (char*)malloc(l/2+l0+idx->streams->file->PageSize)))){
						idx -> Close ( str );
						continue;
					}
					char *pRefs= buf;
					l0= l;
					do{
						memcpy(new_write, pRefs, 4);
						if(firstDocOut && printWContxtMulti){
							firstDocOut= false;
							(*(long*)new_write) |= 0x80000000;
						}
						nxt_sz= ((Ref*)pRefs)->Sub - nxt_sz;
						new_write += 4;
						str -> Read ( new_write, nxt_sz );
						new_write += nxt_sz;
						nxt_sz= ((Ref*)pRefs)->Sub;
						pRefs += sizeof(Ref);
						l0 -= sizeof(Ref);
					}while(l0);
					free(buf);
					buf= new_data;
					l= new_write - new_data;
				}
				idx -> Close ( str );
				printData ( buf, l, f );
				fputc ( '\n', f );
				free ( buf );
			}
			else
				if(!isMixed) fprintf ( f, " has no stream.\n" );

			fflush( f );
		} else {
			if(str) {
				if (!strcmp (name, "NWCntxt")) {
					if(isMixed && (++count)) printKey ( key, f );
					Stream* str2 = 0;
					if(repeatOut)
						str2 = ((Index*)(scnd->tree))->keyOpen( key, 2 );
					else
						str2 = idx->keyOpen( key, 2 );
					if (str2) {
						fprintf ( f, ": %d, %ld bytes data.\n", str -> Length (), str2->Length ());
						idx->Close (str2);
					} else {
						fprintf ( f, ": %d bytes data.\n", str -> Length ( ));
					}
				} else {
					fprintf ( f, ": %d bytes data.\n", str -> Length ( ));
				}
				idx -> Close ( str );
			} else {
				if(!isMixed)
					fprintf ( f, ": 0 bytes data.\n");
			}
		}
		if( repeatOut ){
			if(scnd){
				++(*scnd);
				if((*(char*)scnd->Key ()) & 0x40){
					delete scnd;
					scnd= 0;
				}
			}
		}
		}while(repeatOut);
	}
	}

	if(scnd)
		delete scnd;

	if ( printData || isMixed) {
		fprintf ( f, "----- Key dump end -----\n" );
		fprintf ( f, "Total %d keys found.\n", count );
	}

	return 0;
}

static int dump_HieIndex ( const Base *b, const char *name,
	printKeyFunction printKey, printDataFunction printData,
	FILE *f, const char *s1, const char *s2,
	int quiet, int strno )
{
	HIndex *idx = (HIndex*) ((Base *)b) -> FindIndex ( name );

	if ( !idx ) {
		fprintf ( f     , "Can't found hindex '%s'.\n", name );
		printf ( "Can't found hindex '%s'.\n", name );
		return 0;
	}
	if(!idx->streams->Fat)
		idx->streams->LoadFat();

	readHindex ( idx, strno, printData );
	PrintIndexTree ( idx, quiet, printData, strno, s1 );
	DeleteIndexTree ( );

	return 0;
}

//////////// print key functions //////////////

#ifdef MULTI_INDEX_STREAM_FILE
void printSWordContxt ( const char *start, u_int32_t s, FILE *f )
{
	int repeat= s/3, para= 0;
	long val;
	while(repeat--){
		val= 0;
		memcpy(&val, start, 3); start += 3;
		fprintf(f, "%d>=%d;", ++para, val);
	}
	fprintf ( f, "\n" );
}

void printWContxt2 ( const char *start, u_int32_t s, FILE *f )
{
	int repeat= s/32, nxt= 1;
	char word [32];
	gk_bzero (word, sizeof (word));
	while(repeat--){
		strncpy (word, start + nxt, 31);
		if (repeat)
			fprintf (f, "%s;", word);
		else
			fprintf (f, "%s.", word);
		nxt += 32;
	}
	fprintf ( f, "\n" );
}

void printWContxt ( const char *start, u_int32_t s, FILE *f)
{
	long count, pre;
	const unsigned char *d= (unsigned char*) start;
	bool printWContxtMulti= false;
	if(0x80000000 & *(long*)d){
		printWContxtMulti= true;
		*(long*)d &= 0x7fffffff;
	}
	while (((u_int32_t)d - (u_int32_t)start) < s) {
		fprintf (f, "\n%d(", *(long*)d ); d += sizeof (long);
		count = 1;
		pre= 0;
		while (count--) {
			if(!(*(long*)d & 0x4000))
				count++;
			long atd, PosV;
			if(printWContxtMulti){
				if((*(long*)d & 0x8000)){
					atd= (((*(long*)d) & 0xff0000) >> 2) | ((*(long*)d) & 0x3fff);
					d += 3;
				}else{
					atd= (*(long*)d) & 0x3fff;
					d += 2;
				}
				PosV= (atd+pre)>>2;
				if (count)
					if (atd & GKDB_POS_FLAGS)
						fprintf (f, "%ld[%s%ld].%d ", atd+pre, contextsearch_flags (atd+pre), PosV, *d);
					else
						fprintf (f, "%d.%d ", PosV, *d);
				else
					if (atd & GKDB_POS_FLAGS)
						fprintf (f, "%ld[%s%ld].%d)", atd+pre, contextsearch_flags (atd+pre), PosV, *d);
					else
						fprintf (f, "%d.%d)", PosV, *d);
				pre += atd & 0x3ffffc;
				d++;
			}else{
				if((*(long*)d & 0x8000)){
					atd= (((*(long*)d) & 0xff0000) >> 2) | ((*(long*)d) & 0x3fff);
					d += 3;
				}else{
					atd= (*(long*)d) & 0x3fff;
					d += 2;
				}
				PosV= (atd+pre)>>2;
				if (count)
					if (atd & GKDB_POS_FLAGS)
						fprintf (f, "%ld[%s%ld] ", atd+pre, contextsearch_flags (atd+pre), PosV);
					else
						fprintf (f, "%d ", PosV);
				else
					if (atd & GKDB_POS_FLAGS)
						fprintf (f, "%ld[%s%ld])", atd+pre, contextsearch_flags (atd+pre), PosV);
					else
						fprintf (f, "%d)", PosV);
				pre += atd & 0x3ffffc;
			}
		}
	}
	fprintf (f, "\n");
	fflush (f);
}

void key_printNContxt ( const void *key, FILE *f )
{
	char tmpZZZ[32+1];
	if(*(unsigned char*)key & 0x40)
		fprintf ( f, "F(%s)", ((char*)key+1) );
	else if(*(unsigned char*)key == 0)
		fprintf ( f, "W(%d)", *(long*)((char*)key+1) );
	else if(*(unsigned char*)key & 0x80){
		memcpy(tmpZZZ, (char*)key+1, (*(unsigned char*)key & 0x7f) - 1);
		tmpZZZ[(*(unsigned char*)key & 0x7f) -1]= 0;
		fprintf ( f, "P(%s)", tmpZZZ );
	}else{
		memcpy(tmpZZZ, (char*)key+1, (*(unsigned char*)key & 0x7f) - 1);
		tmpZZZ[(*(unsigned char*)key & 0x7f) -1]= 0;
		fprintf ( f, "N(%s)", tmpZZZ );
	}
}
#ifdef STORE_FORM_N
void key_printNFContxt ( const void *key, FILE *f )
{
	fprintf ( f, "%s", key );
}

#endif

#endif

void key_printDate ( const void *key, FILE *f )
{
	fprintf ( f, "(%02d/%02d/%04d)",
		(int) ((date*) key) -> da_day,
		(int) ((date*) key) -> da_mon,
		(int) ((date*) key) -> da_year );
}

void key_printContext ( const void *key, FILE *f )
{
	char buf [CTX_WORD_SIZE + 1];

	memcpy ( buf, key, CTX_WORD_SIZE );
	buf [CTX_WORD_SIZE] = 0;
	fprintf ( f, "%s", buf );
}

void key_printInt32 ( const void *key, FILE *f )
{
	fprintf ( f, "%d", *(int*) key );
}

void key_printInt16 ( const void *key, FILE *f )
{
	fprintf ( f, "0x%04X", (int) ( *(short*) key ) );
}

void key_printStatus ( const void *key, FILE *f )
{
	switch ( *(unsigned short*) key )
	{
		case DS_ACTIVE:	    fprintf ( f, "DS_ACTIVE" );     break;
		case DS_ABOLISHED:  fprintf ( f, "DS_ABOLISHED" );  break;
#ifndef OLDBASE
		case DS_PREACTIVE:  fprintf ( f, "DS_PREACTIVE" );  break;
		case DS_MOJREG:     fprintf ( f, "DS_MOJREG" );     break;
		case DS_MOJNOTREG:  fprintf ( f, "DS_MOJNOTREG" );  break;
		case DS_MOJOTHER:   fprintf ( f, "DS_MOJOTHER" );   break;
#endif
		case DS_NODOC:      fprintf ( f, "DS_NODOC" );      break;
		case DS_DOC:        fprintf ( f, "DS_DOC" );        break;
		case DS_EDITION:    fprintf ( f, "DS_EDITION" );    break;
		case DS_WARNING:    fprintf ( f, "DS_WARNING" );    break;
		case DS_WWW:        fprintf ( f, "DS_WWW" );        break;
		case DS_ANNO:       fprintf ( f, "DS_ANNO" );       break;
		case DS_REFDOC:     fprintf ( f, "DS_REFDOC" );     break;
		default: fprintf ( f, "0x%04X", (int) ( *(short*) key ) );
	}
}

void key_printStatus_ex ( const void *key, FILE *f )
{
	switch ( *(unsigned short*) key ) {
		case DS_MEDTOPIC:
			fprintf ( f, "DS_MEDTOPIC" );
			break;
		case DS_FLASH:
			fprintf ( f, "DS_FLASH" );
			break;
		case DS_NOCOMPARE:
			fprintf ( f, "DS_NOCOMPARE" );
			break;
		case DS_FIRMTOPIC:
			fprintf ( f, "DS_FIRMTOPIC" );
			break;
		case DS_NARCOTIC:
			fprintf ( f, "DS_NARCOTIC" );
			break;
		case DS_LIFE:
			fprintf ( f, "DS_LIFE" );
			break;
		case DS_UNRECIPE:
			fprintf ( f, "DS_UNRECIPE" );
			break;
		case DS_ALLOWED:
			fprintf ( f, "DS_ALLOWED" );
			break;
		case DS_MDICTTOPIC:
			fprintf ( f, "DS_MDICTTOPIC" );
			break;
		case DS_IZM:
			fprintf ( f, "DS_IZM" );
			break;
		case DS_RECIPE:
			fprintf ( f, "DS_RECIPE" );
			break;
		case DS_NOTNARCOTIC:
			fprintf ( f, "DS_NOTNARCOTIC" );
			break;
		case DS_NOTLIFE:
			fprintf ( f, "DS_NOTLIFE" );
			break;
		case DS_NOTALLOWED:
			fprintf ( f, "DS_NOTALLOWED" );
			break;
		case DS_DATE:
			fprintf ( f, "DS_DATE" );
			break;
		default:
			fprintf ( f, "0x%04X", (int) ( *(short*) key ) );
	}
}

void key_printRef ( const void *key, FILE *f )
{
#ifdef	BLOCKSINHERIT
	if ( ( (Ref*) key) -> Sub & INHERITED_BLOCK )
		fprintf ( f, "(%ld.!%ld)", ((Ref*) key) -> DocId, ((Ref*) key) -> Sub & MINUS_INHERITED_BLOCK );
	else
#endif
	fprintf ( f, "(%ld.%ld)", ((Ref*) key) -> DocId, ((Ref*) key) -> Sub );
}

void key_printBlob ( const void *key, FILE *f )
{
	fprintf ( f, "(%ld[%d,%d,%d,%d])",
		((ObjKey*) key) -> id,
		((ObjKey*) key) -> reserved [0],
		((ObjKey*) key) -> reserved [1],
		((ObjKey*) key) -> reserved [2],
		((ObjKey*) key) -> reserved [3] );
}

void key_printASCIIZ ( const void *key, FILE *f )
{
	fprintf ( f, "%s\n", (const char *) key );
}

////////////////// dump data functions //////////////

#ifdef MULTI_INDEX_STREAM_FILE
	#ifdef STORE_FORM_N
void printNFContxt ( const char *start, u_int32_t s, FILE *f )
{
	fprintf ( f, "%d[", ((short*)start)[1] & 0xff );
	key_printNContxt(start+sizeof(long), f);
	fprintf ( f, "]\n" );
}
void printNBContxt ( const char *start, u_int32_t s, FILE *f )
{
	long count, blck, Multi, tstM, indxs;
	const char *d= start;
	curr_max= 0;
	s= *(long*)d;
	start += sizeof(long);
	d += sizeof(long);
	while( ((u_int32_t)d - (u_int32_t)start) < s){
		Multi=0;
		if(*(long*)d  & 0x80000000)
			Multi++;
		fprintf ( f, " %d(", 0x7fffffff & *(long*)d );
		d += sizeof(long);
		if((blck= *(long*)d) & 0x80000000){
			tstM= 2;
			count= 1;
		}else{
			tstM= 3;
			d += sizeof(long);
			count= *(long*)d;
		}
		while(count--){
			d += sizeof(long);
			if(blck & 0x40000000){
				if(Multi){
if(curr_max < (int)*d)
curr_max= (int)*d;
	if(count)
		fprintf ( f, "%d.%d ", blck & 0x3fffffff, (int)*d);
	else
		fprintf ( f, "%d.%d)", blck & 0x3fffffff, (int)*d);
					d++;
				}else{
	if(count)
		fprintf ( f, "%d.0 ", blck & 0x3fffffff);
	else
		fprintf ( f, "%d.0)", blck & 0x3fffffff);
				}
			}else if(tstM == 2){
				count = ((int)*d);d++;
				while(count--){
if(curr_max < (int)*d)
curr_max= (int)*d;
	if(count)
		fprintf ( f, "%d.%d ", blck & 0x3fffffff, (int)*d);
	else
		fprintf ( f, "%d.%d)", blck & 0x3fffffff, (int)*d);
					d++;
				}
				break;
			}else if(tstM == 3){
				indxs = ((int)*d);d++;
				while(indxs--){
if(curr_max < (int)*d)
curr_max= (int)*d;
	if(indxs || count)
		fprintf ( f, "%d.%d ", blck & 0x3fffffff, (int)*d);
	else
		fprintf ( f, "%d.%d)", blck & 0x3fffffff, (int)*d);
					d++;
				}
			}
			if(((u_int32_t)d - (u_int32_t)start) < s)
				blck= *(long*)d;
		}
	}
	fprintf ( f, "\n" );
}
	#endif
void printNContxt ( const char *start, u_int32_t s, FILE *f )
{
	long count;
	const char *d= start;
#ifdef STORE_FORM_N
	s= *(long*)d;
	start += sizeof(long);
	d += sizeof(long);
#endif
	while( ((u_int32_t)d - (u_int32_t)start) < s){
		fprintf ( f, "\n%d(", *(long*)d ); d += sizeof(long);
		count= *(long*)d; d += sizeof(long);
		while(count--){
#ifdef STORE_FORM_N
			if(!(*(long*)d & 0x4000)){
	if(count)
		fprintf ( f, "%d.%d.%X ", (*(long*)d) >> 15, *(long*)d & 0x3fff, *(d+sizeof(long)));
	else
		fprintf ( f, "%d.%d.%d)", (*(long*)d) >> 15, *(long*)d & 0x3fff, *(d+sizeof(long)));
				d++;
			}else{
	if(count)
		fprintf ( f, "%d.%d.0 ", (*(long*)d) >> 15, *(long*)d & 0x3fff);
	else
		fprintf ( f, "%d.%d.0)", (*(long*)d) >> 15, *(long*)d & 0x3fff);
			}
#else
	if(count)
		fprintf ( f, "%d.%d ", (*(long*)d) >> 15, *(long*)d & 0x3fff);
	else
		fprintf ( f, "%d.%d)", (*(long*)d) >> 15, *(long*)d & 0x3fff);
#endif
			d += sizeof(long);
		}
	}
	fprintf ( f, "\n" );
}
#endif

#ifdef	VERSION56
static void printActiveSet( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		u_int32_t ss = 0;
		while ( ss < s ) {
			DocActivity* da = (DocActivity*)d;
			const char* aText = d + sizeof(da->from) + sizeof(da->to);
			fprintf ( f, "  %02d/%02d/%04d - %02d/%02d/%04d  %s\n",
				(int) da->from.da_day,
				(int) da->from.da_mon,
				(int) da->from.da_year,
				(int) da->to.da_day,
				(int) da->to.da_mon,
				(int) da->to.da_year,
				aText );
			u_int32_t aLen = strlen(aText) + 1;
			ss += aLen + sizeof(da->from) + sizeof(da->to);
			d = aText + aLen;
		}
	}
}

static void printActiveExSet( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		u_int32_t ss = 0;
		DocActivitySmall* da = (DocActivitySmall*) d;
		while ( ss < s ) {
			fprintf ( f, "  %ld:%02d/%02d/%04d\n",  da->block, da->from.da_day, da->from.da_mon, da->from.da_year);
			da++;
			ss += sizeof (*da);
		}
	}
}

static void printDivision( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		u_int32_t ss = 0;
		while ( ss < s ) {
			DivisionInfo* da = (DivisionInfo*)d;
			const char* aText = d + sizeof(da->Para) + sizeof(da->Symbol);
			fprintf ( f, "  %ld %c %s\n", da->Para, da->Symbol, aText );
			u_int32_t aLen = strlen(aText) + 1;
			ss += aLen + sizeof(da->Para) + sizeof(da->Symbol);
			d = aText + aLen;
		}
	}
}
static void printBlobInfos( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		u_int32_t ss = 0;
		while (ss < s) {
			BlobInfo* bi = (BlobInfo*)d;
			const char* aText = d + 8;

			char aType [5];
			memcpy (aType, &bi->type, 4);
			for (int i = 0; i < 4; i++) 
				if (!aType [i])
					aType [i] = ' ';
			aType [4] = 0;
			while (aType [0] == ' ')
				memcpy (aType, aType + 1, 4);

			fprintf ( f, "  %d %s %s\n", bi->Para, aType, bi->Name );
			u_int32_t aLen = strlen(aText) + 1;
			ss += aLen + 8;
			d = aText + aLen;
		}
	}
}

static void printChDate( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		for ( s /= sizeof( DocChDate ); s; s--, d += sizeof( DocChDate ) )
			fprintf ( f, "%02d/%02d/%04d %02d/%02d/%04d\n",
				(int) ((DocChDate*)d)->anonce.da_day,
				(int) ((DocChDate*)d)->anonce.da_mon,
				(int) ((DocChDate*)d)->anonce.da_year,
				(int) ((DocChDate*)d)->active.da_day,
				(int) ((DocChDate*)d)->active.da_mon,
				(int) ((DocChDate*)d)->active.da_year );

		fprintf ( f, "\n" );
	}
}

static void printChDateEx( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		for ( s /= sizeof( ChDateEx ); s; s--, d += sizeof( ChDateEx ) )
			fprintf ( f, "%02d/%02d/%04d %ld.%ld\n",
				(int) ((ChDateEx*)d)->anonce.da_day,
				(int) ((ChDateEx*)d)->anonce.da_mon,
				(int) ((ChDateEx*)d)->anonce.da_year,
				(int) ((ChDateEx*)d)->ref.DocId,
				(int) ((ChDateEx*)d)->ref.Sub);

		fprintf ( f, "\n" );
	}
}

static void printNotSure( const char *d, u_int32_t s, FILE *f )
{
#ifdef	VERSION61
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		u_int32_t ss = 0;
		while ( ss < s ) {
			DocNotSure* ns = (DocNotSure*)d;
			const char* aText = d + sizeof(ns->from) + sizeof(ns->to);
			fprintf ( f, "  %02d/%02d/%04d - %02d/%02d/%04d  %s\n",
				(int) ns->from.da_day,
				(int) ns->from.da_mon,
				(int) ns->from.da_year,
				(int) ns->to.da_day,
				(int) ns->to.da_mon,
				(int) ns->to.da_year,
				aText );
			u_int32_t aLen = strlen(aText) + 1;
			ss += aLen + sizeof(ns->from) + sizeof(ns->to);
			d = aText + aLen;
		}
	}
#else
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		for ( s /= sizeof( DocNotSure ); s; s--, d += sizeof( DocNotSure ) )
			fprintf ( f, "%02d/%02d/%04d %02d/%02d/%04d\n",
				(int) ((DocNotSure*)d)->from.da_day,
				(int) ((DocNotSure*)d)->from.da_mon,
				(int) ((DocNotSure*)d)->from.da_year,
				(int) ((DocNotSure*)d)->to.da_day,
				(int) ((DocNotSure*)d)->to.da_mon,
				(int) ((DocNotSure*)d)->to.da_year );

		fprintf ( f, "\n" );
	}
#endif
}

static void printRefs( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		for ( s /= sizeof( RespRef ); s; s--, d += sizeof( RespRef ) )
			fprintf ( f, "%ld.%d.%ld.%ld ", ((RespRef*)d)->ParaId, ((RespRef*)d)->Offset, ((RespRef*)d)->DocId, ((RespRef*)d)->Sub );

		fprintf ( f, "\n" );
	}
}

static void printContents( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		for ( s /= sizeof( ContentsStruct ); s; s--, d += sizeof( ContentsStruct ) )
			fprintf ( f, "%d.%hd.%hd ", ((ContentsStruct*)d)->Sub, ((ContentsStruct*)d)->Size, ((ContentsStruct*)d)->Extended );
		fprintf ( f, "\n" );
	}
}

static void printCompareContents( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		for ( s /= sizeof( CompareContentsStruct ); s; s--, d += sizeof( CompareContentsStruct ) )
			fprintf ( f, "%d.%hd ", ((CompareContentsStruct*)d)->Sub, ((CompareContentsStruct*)d)->Levels);
		fprintf ( f, "\n" );
	}
}

static void printPageBreaks( const char *d, u_int32_t s, FILE *f )
{
	if ( !d ) {
		fprintf( f, "Warning: Zero data length ?!\n" );
		printf( "Warning: Zero data length ?!\n" );
	} else {
		for ( s /= sizeof( PageBreak ); s; s--, d += sizeof( PageBreak ) )
			fprintf ( f, "%d.%hd ", ((PageBreak*)d)->Para, ((PageBreak*)d)->Count );
		fprintf ( f, "\n" );
	}
}
#endif

static void printDateA ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( date ); s; s--, d += sizeof ( date ) )
		fprintf ( f, "%02d/%02d/%04d ",
			(int) ((date*) d) -> da_day,
			(int) ((date*) d) -> da_mon,
			(int) ((date*) d) -> da_year );
	fprintf ( f, "\n" );
}

static void printDateB ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= (sizeof (date) + sizeof (long)); s; s--) {
		fprintf ( f, "%ld:", *(long*)d);
		d += sizeof (long);
		fprintf ( f, "%02d/%02d/%04d ", (int) ((date*) d) -> da_day, (int) ((date*) d) -> da_mon, (int) ((date*) d) -> da_year );
		d += sizeof (date);
	}
	fprintf ( f, "\n" );
}

static void printRefWeight ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( RefwWeight ); s; s--, d += sizeof ( RefwWeight ) )
		fprintf ( f, "%lu.%lu.%ld ", (unsigned long) ((RefwWeight*) d) -> DocId, (unsigned long) ((RefwWeight*) d) -> Sub, (unsigned long) ((RefwWeight*) d) -> Weight );
	fprintf ( f, "\n" );
}

static void printRefA ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( Ref ); s; s--, d += sizeof ( Ref ) )
#ifdef	BLOCKSINHERIT
		if ( ((Ref*) d) -> Sub & INHERITED_BLOCK )
			fprintf ( f, "%lu.!%lu ", (unsigned long) ((Ref*) d) -> DocId, (unsigned long) ((Ref*) d) -> Sub & MINUS_INHERITED_BLOCK );
		else
#endif
		fprintf ( f, "%lu.%lu ", (unsigned long) ((Ref*) d) -> DocId, (unsigned long) ((Ref*) d) -> Sub );
	fprintf ( f, "\n" );
}

static void printRefC ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( Ref ); s; s--, d += sizeof ( Ref ) )
		fprintf ( f, "%lu.%lu ", (unsigned long) ((Ref*) d) -> DocId, (unsigned long) ((Ref*) d) -> Sub );
	fprintf ( f, "\n" );
}

static void printRefB ( const char *d, u_int32_t s, FILE *f )
{
	if (b_packed_newcorr) {
		while (s) {
			long packed_size, unpacked_size;
			memcpy (&packed_size, d, sizeof (long));
			d += sizeof (long); s -= sizeof (long);
			memcpy (&unpacked_size, d, sizeof (long));
			d += sizeof (long); s -= sizeof (long);
			char *unpacked_data = new char [unpacked_size], *ptr = unpacked_data;
			G_UNZIP ((char*) d, packed_size, unpacked_data, unpacked_size);
			d += packed_size; s -= packed_size;
			for (int i = 0; i < unpacked_size / sizeof (CorrRef); i++, ptr += sizeof (CorrRef)) {
				fprintf ( f, "%lu.%lu.%lu.%lu.%lu ",
					(unsigned long) ((CorrRef*) ptr) -> Sub,
					(unsigned long) ((CorrRef*) ptr) -> DocId,
					(unsigned long) ((CorrRef*) ptr) -> Para,
					(unsigned long) ((CorrRef*) ptr) -> RealPara,
					(unsigned long) ((CorrRef*) ptr) -> Block);
			}
			delete []unpacked_data;
		}
	} else {
		for ( s /= sizeof ( CorrRef ); s; s--, d += sizeof ( CorrRef ) )
			fprintf ( f, "%lu.%lu.%lu.%lu.%lu ",
				(unsigned long) ((CorrRef*) d) -> Sub,
				(unsigned long) ((CorrRef*) d) -> DocId,
				(unsigned long) ((CorrRef*) d) -> Para,
				(unsigned long) ((CorrRef*) d) -> RealPara,
				(unsigned long) ((CorrRef*) d) -> Block);
	}
	fprintf ( f, "\n" );
}

static void printControl( const char *d, u_int32_t s, FILE *f )
{
#ifdef	VERSION56
	for ( s /= sizeof ( long ) * 2; s; s--, d += sizeof ( long ) * 2 )
		fprintf ( f, "%lu.%lu ",
			*(long*)d,
			*((long*) (d+sizeof(long))));
	fprintf ( f, "\n" );
#endif
}

void printInt16A ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( int16_t ); s; s--, d += sizeof ( u_int16_t ) )
		fprintf ( f, "%u ", (unsigned) *(u_int16_t*) d );
	fprintf ( f, "\n" );
}

void printInt32A ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( int32_t ); s; s--, d += sizeof ( u_int32_t ) )
		fprintf ( f, "%u ", (unsigned) *(u_int32_t*) d );
	fprintf ( f, "\n" );
}

void printSubs ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( SubDesc ); s; s--, d += sizeof( SubDesc ) )
#ifdef	BLOCKSINHERIT
		if ( ((SubDesc*) d)->Sub > 0 && ((SubDesc*) d)->Sub & INHERITED_BLOCK ) {
			fprintf ( f, "!%d.%d ", ((SubDesc*) d)->Sub & MINUS_INHERITED_BLOCK, ((SubDesc*)d)->Para );
		} else
#endif
		fprintf ( f, "%d.%d ", ((SubDesc*) d)->Sub, ((SubDesc*)d)->Para );
	fprintf ( f, "\n" );
}

char* flags_to_str (unsigned short Flags) {
	std::string result;
	switch (Flags) {
		case SUBDESCEX_BLOCK:
			result = "block";
			break;
		case SUBDESCEX_BLOCKEND:
			result = "blockend";
			break;
		case SUBDESCEX_SBS:
			result = "sbs";
			break;
		case SUBDESCEX_SBSEND:
			result = "sbsend";
			break;
		case SUBDESCEX_TABLE:
			result = "table";
			break;
		case SUBDESCEX_TABLEEND:
			result = "tableend";
			break;
		case SUBDESCEX_STRING:
			result = "row";
			break;
		case SUBDESCEX_SBSSTRING:
			result = "sbsrow";
			break;
		case SUBDESCEX_STRINGEND:
			result = "rowend";
			break;
		case SUBDESCEX_SBSSTRINGEND:
			result = "sbsrowend";
			break;
		case SUBDESCEX_CELL:
			result = "cell";
			break;
		case SUBDESCEX_SBSCELL:
			result = "sbscell";
			break;
		case SUBDESCEX_CELLEND:
			result = "cellend";
			break;
		case SUBDESCEX_SBSCELLEND:
			result = "sbscellend";
			break;
		case SUBDESCEX_SUB:
			result = "sub";
			break;
		default:
			result = "?";
	}
	return (strdup (result.c_str ()));
}

void printSubsEx ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( SubDescEx ); s; s--, d += sizeof( SubDescEx ) )
		fprintf ( f, "%d.para:%d.%s ", ((SubDescEx*) d)->Sub, ((SubDescEx*)d)->Para, flags_to_str(((SubDescEx*)d)->Flags));
	fprintf ( f, "\n" );
}

void printDocStruct ( const char *d, u_int32_t s, FILE *f )
{
	for ( s /= sizeof ( DocStruct ); s; s--, d += sizeof( DocStruct ) ) {
		DocStruct *ptr = (DocStruct*) d;
		short evd_type = (short) ((ptr->m_para_list_type >> 24) & 0xFF);
		std::string type;
		switch (evd_type) {
			case SUBDESCEX_DOCUMENT:
				type = "id_Document";
				break;
			case SUBDESCEX_BLOCK:
				type = "id_Block";
				break;
			case SUBDESCEX_SBS:
				type = "id_SBS";
				break;
			case SUBDESCEX_TABLE:
				type = "id_Table";
				break;
			case SUBDESCEX_STRING:
				type = "id_TableRow";
				break;
			case SUBDESCEX_CELL:
				type = "id_TableColumn";
				break;
			case SUBDESCEX_SBSSTRING:
				type = "id_SBSRow";
				break;
			case SUBDESCEX_SBSCELL:
				type = "id_SBSCell";
				break;
			default:
				type = "???";
				break;
		}
		printf ("%X.%ld.%s|%d.%ld.%ld.%ld.%ld\n", ptr->m_id, ptr->m_para_list_id, type.c_str (), ptr->m_para_list_type & 0xFFFFFF, ptr->m_start_para, ptr->m_end_para, ptr->m_first_child, ptr->m_last_child);
	}
	fprintf ( f, "\n" );
}

struct BlockDecompileFactory {
	static evd::IeeGenerator* make (std::string& value);
};

class BlockDecompile_i
	: virtual public evd::IeeGenerator 
	, virtual public Core::RefCountObjectBase {
public:
	BlockDecompile_i (std::string& value) : m_value (value) {
	}

	virtual ~BlockDecompile_i () {
	}

public:
	virtual void StartChild (long tag_id) {
	}

	virtual void Start () {
	}

	virtual void Finish (bool is_need_undo = false) {
	}

	virtual void StartTag (long tag_id) {
	}

	virtual void AddIntegerAtom (long tag_id, long value) {
		if (tag_id == evd::ti_ViewKind && value == EVD::bvk_Right) {
			m_value = "RIGHT";
		}
	}

	virtual void AddBoolAtom (long tag_id, bool value) {
	}

	virtual void AddStringAtom (long tag_id, const char* buf, long len = 0xffffffff, long code_page = 0x0) {
	}

	virtual void AddStreamAtom (long tag_id, GCI::IO::Stream* stream) {
	}

	virtual void AddMemAtom (long tag_id, const char* mem_buf, long len) {
	}

	virtual void AddRawData (const char* mem_buf, long len) {
	}

	virtual void StartDefaultChild (void) {
	}

	virtual void AddTransparentAtom (unsigned short atom_index) {
	}

private:
	std::string& m_value;
};

evd::IeeGenerator* BlockDecompileFactory::make (std::string& value) {
	evd::IeeGenerator_var ret;

	try {
		ret = new BlockDecompile_i (value);
	} catch (...) {
	}

	return ret._retn ();
}

void printEVD ( const char *d, u_int32_t s, FILE *f )
{
	const char* ptr = d;
	while (ptr - d < (int)(s&0x7fffffff)) {
		long id = *(long*)ptr;
		ptr += sizeof (long);
		long size = (long) ptr [0];

		/*
		std::string info;
		evd::IeeGenerator_var generator = BlockDecompileFactory::make (info);
		evd::EvdReader_var evd_reader = new evd::EvdReader (ptr+1, size, generator.in ());
		evd_reader->convert_binary_object ();
		if (info.size ())
			printf ("%s\n", info.c_str ());
		*/

		ptr += size + 1;
		fprintf (f, "id:%ld.size:%ld.data... ", id, size);
	}
	fprintf ( f, "\n" );
}

//////////////// misc functions ///////////////////

int usage ( char *str )
{
	printf("GARANT Base index dumper v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
	printf( "Usage: %s [-s] <base> <index>\n", str);
	printf( "Options: -s for short listing, keys only\n");
	printf( "         -h for this help\n");
	return 0;
}

int main_logic (int argc, char *argv[]);

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	Core::AutoInit init;
	//int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	int res = main_logic (argc, argv);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GKDUMPI;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GKDUMPI Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	int s = 0;
	if ( argc < 3 )
	       return usage ( argv [0] );

	if ( !strcmpi ( argv [1], "-s" ) )
		s = 1;
	else
	if (!strcmpi (argv [1], "-length")) {
		print_length = true;
		s = 1;
	}
	else
	if ( !strcmpi ( argv [1], "-h" ) )
	       return usage ( argv [0] );

	setlocale (LC_ALL, "ru_RU.CP1251");

	SearchBase *base = new SearchBase ( argv [1 + s], ACE_OS_O_RDONLY );
	base->IsOk ();
	base->is_morpho_exist();
	base->FindIndex ("Status");

	/*if(*(argv [2]) != 'N'){
		// Òåñòîâûé êîä èç êàðêóëÿòîðà ðåëåâàíòíîñòè
		FILE *request_file = fopen (argv [2], "rt");
		char request_str [256]; request_str [0] = '\0';
		fgets (request_str, sizeof (request_str), request_file);

		int length = strlen (request_str);
		if (length && (request_str [length-1] == 10 || request_str [length-1] == 13))
			request_str [--length] = 0;
		fclose (request_file);

		unlink (argv [3]);
		int log_handle = ace_os_open (argv [3], ACE_OS_O_CREAT | ACE_OS_O_WRONLY | ACE_OS_O_TEXT);

		IndexReq* req = (IndexReq*) malloc (sizeof (IndexReq) + 2000);
		req->ItemCount = 1;
		req->ItemSize  = 0;
		req->SearchOp = SO_AND | SO_KEYS_AND | SV_MBODIES;
		strcpy (req->Name, "Morpho");
		char* ptr = (char gk_huge*)(req+1);
		strcpy (ptr, request_str);

		IndexReq *reqs [1];
		reqs [0] = req;
		SortedCollection* foundlist = base->Search (1,reqs,0,SO_AND,0,0,0,1,0,0,true,log_handle,argv [4] ? atol (argv [4]) : 0);
		
		ace_os_close (log_handle);
		exit (EXIT_SUCCESS);
	}*/

	AttrIndex* docInd = (AttrIndex*) base->FindIndex ("Attrs");
	int  sno = ( argc > 3 + s ) ? atoi ( argv [3 + s] ) : -1;

	if ( sno < -1 || sno >= MAX_STREAMS ) {
		printf ( "invalid value (%d) for stream #\n", sno );
		return usage ( argv [0] );
	}

	char *s1 = (char *)(( argc > 4 + s ) ? argv [4 + s] : 0 );
	char *s2 = (char *)(( argc > 5 + s ) ? argv [5 + s] : 0 );

	if (!strcmpi (argv [2], "AllDocs")) {
		DocCollection *alldocs = base->AllDocs ();
		printf ("AllDocs: ");
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long id = (*alldocs)[i];
			printf ("%ld ", id);
		}
		printf ("\n");
		delete alldocs;
		delete base;
		exit (EXIT_SUCCESS);
	}
	if (!strcmpi (argv [2], "AllTopics")) {
		printf ("AllTopics: ");
		DocCollection *alldocs = base->AllTopics ();
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long id = (*alldocs)[i];
			printf ("%ld ", id);
		}
		printf ("\n");
		delete alldocs;
		delete base;
		exit (EXIT_SUCCESS);
	}
	if (!strcmpi (argv [2], "Pics") && argv [3]) {
		FILE* out_file = fopen (argv [3], "wt");
		Index* blobs = base->FindIndex ("Blob");
		ObjInfo info;
		for (BTIterator it (blobs); !it.End (); ++it) {
			long *id = (long*)it.Key ();
			Stream* str = blobs->Open (id);
			if (str) {
				str->Read (&info, sizeof (info));
				blobs->Close (str);
				if (info.type == EOT_PIC || info.type == EOT_PNG || info.type == EOT_GIF || info.type == EOT_JPG)
					fprintf (out_file,"%ld\n", *id);
			}
		}
		fclose (out_file);
		delete base;
		exit (EXIT_SUCCESS);
	}
	if (!strcmpi (argv [2], "Force")) {
		DocCollection *alldocs = base->AllTopics (ID_BORDER);
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long id = (*alldocs)[i];
			DocInfo docinfo;
			if (base->FindDocInfo (id, docinfo) == sizeof (DocInfo))
				printf ("%ld %ld\n", id, docinfo.Force);
		}
		printf ("\n");
		delete alldocs;
		delete base;
		exit (EXIT_SUCCESS);
	}
	
	printf ( "Garant base index dumper.\n" );

	char sss1 [20];
	if ( !strcmpi ( argv [2], "Segment" ) )
		if ( s1 ) {
			*(int*) sss1 = atoi ( s1 );
			s1 = sss1;
		}

	for ( unsigned i = 0; i < sizeof ( indexTable ) / sizeof ( IndexDumpInfo ); i++ )
		if ( !strcmpi ( argv [2 + s], indexTable [i].name ) ) {
			if ( sno < 2 && sno != -1 && indexTable [i].printData [sno] == 0 ) {
				printf ( "Index '%s' has no stream %d", argv [2 + s], sno );
				return 0;
			}
			
			return indexTable [i].dumpIdx (
				base,				// base handle
				indexTable [i].name,		// index name
				indexTable [i].printKey,	// key print
				( sno == -1 ) ? 0 : indexTable [i].printData [sno],	// data print
				stdout,				// output file
				s1, s2,				// key
				s,				// quiet mode
				sno );				// stream no
		}
		
		printf ( "Unknown index '%s'\n", argv [2 + s] );

		return 0;
}

//////////////////////////////////

struct Tree
{
	Tree *parent, *next, *child;
	char *name;
	void *key;
	int  id, pid, ac, oc;
};

static Tree Root;

static Tree *Locate ( Tree *root, int id )
{
	Tree *r = root;
	Tree *q;

	static Tree *lastp = &Root;
	if ( lastp -> id == id )
		return lastp;

// locate parent
	Tree *rr = r;
	while ( rr )
	{
		if ( rr -> id == id )
			return lastp = rr;
		rr = rr -> next;
	}

	while ( r )
	{
		if ( r -> child )
			if ( 0 != ( q = Locate ( r -> child, id ) ) )
				return q;
		r = r -> next;
	}
	return 0;
}

static int InsertItem ( int id, int pid, int ac, int oc, char *name,
	const void *key, int size )
{
	Tree *r;

	if ( 0 == ( r = Locate ( &Root, pid ) ) )
	{
		printf ( "\nError node: id = %d, pid = %d, text=%s\n", id, pid, name );
		return 1;
	}

	Tree *q = (Tree*) malloc (sizeof (Tree));
	memset ( q, 0, sizeof (Tree));

	q -> id  = id;
	q -> pid = pid;
	q -> parent = r;
	q -> ac = ac;
	q -> oc = oc;
	memcpy ( q -> key =          malloc ( size                ), key, size );
	strcpy ( q -> name = (char*) malloc ( 1 + strlen ( name ) ), name );

	if ( !r -> child )
		r -> child = q;
	else
	{
		Tree *qq = r -> child;

		while ( qq -> next )
			qq = qq -> next;

		qq -> next = q;
	}
	return 0;
}

char form_str [100];

int PrintTree ( Tree *r, int n, HIndex *idx, printDataFunction printData, int strno, const char* key = 0 )
{
	while ( r )	{
		if ((key && atol (key) == r->id) || !key) {
			printf ( form_str, r -> id, r -> pid, r -> ac, r -> oc );

			printf ( "| " );
			for ( int i = 0; i < n; i++ )
				printf ( "  " );
			printf ( "%s\n", r -> name );

			void *data = 0;
			int size = 0;
			if ( printData ) {
	#ifndef OLDBASE
				Stream *str = idx -> Index::OpenN ( r -> key, strno );
	#else
				 Stream *str = idx -> Index::Open ( r -> key );
	#endif

				if ( str )
				if ( 0 != ( size = str -> Length ( ) ) ) {
					 data = malloc ( size );
					 if ( !data ) MemoryError ( );
					 str -> Read ( data, size );
					 //RefCollection qqq;
					 //qqq.Get(str);
					 //printf( " | %ld %ld\n", qqq.ItemCount, qqq.DocCount() );
					 idx -> Close ( str );
				}
				else
					 printf ( "Empty stream for key %s.\n", r -> name );
				else
				printf ( "No stream for key %s\n", r -> name );
			}

			if ( printData && data && size ) {
				if (print_length)
					fprintf (stdout, "length: %ld, ", size);
				printData ( (const char*) data, size, stdout );
				fprintf ( stdout, "\n" );
			}

			if ( data )
				free ( data );
		}

		PrintTree ( r -> child, n + 1, idx, printData, strno, key);
		r = r -> next;
	}
	return 0;
}

static int readHindex ( HIndex *idx, int strno, printDataFunction printData )
{
	for ( BTIterator it ( idx ); !it.End ( ); ++it )
	{
		const void *k	= it.Key ( );
		long id		= idx -> Id ( k );
		long pid	= idx -> Parent ( k );
		int  ac		= idx -> AllChildrenCount ( k );
		int  oc		= idx -> OwnChildrenCount ( k );

		InsertItem ( id, pid, ac, oc, (char*) idx -> Text ( k ), k, idx -> KeyLength );
	}
	return 0;
}

static int PrintIndexTree ( HIndex *idx, int quiet, printDataFunction printData, int strno, const char* key )
{
	fprintf ( stdout, "Index exists and claims:\n" );
	fprintf ( stdout, "KeyCount: %ld\n", idx -> KeyCount );
	fprintf ( stdout, "KeyLength: %d\n", idx -> KeyLength );
	fprintf ( stdout, "Btree height: %d\n", idx -> Height );
	fprintf ( stdout, "LastId: %d\n", idx -> LastId);
	fprintf ( stdout, "----- Key dump follows: -----\n" );
	fprintf ( stdout, "id | pid | ac | oc\n\n" );

	int mx = 1;

	if (  idx -> KeyCount >= 10 ) mx = 2;
	if (  idx -> KeyCount >= 100 ) mx = 3;
	if (  idx -> KeyCount >= 1000 ) mx = 4;
	if (  idx -> KeyCount >= 10000 ) mx = 5;
	if (  idx -> KeyCount >= 100000 ) mx = 6;

//	sprintf ( form_str, "id=%%-%dd|pid=%%-%dd|ac=%%-%dd|oc=%%-%dd", mx, mx, mx, mx );
	sprintf ( form_str, " %%-%dd | %%-%dd | %%-%dd | %%-%dd ", mx, mx, mx, mx );

	if ( quiet )
		form_str [0] = 0;

	PrintTree ( Root.child, 0, idx, printData, strno, key );
	return 0;
}

static int DelTr ( Tree *r )
{
	if ( r )
	{
		if ( r -> child )
			DelTr ( r -> child );
		if ( r -> next )
			DelTr ( r -> next );
		free ( r -> name );
		free ( r -> key );
		free ( r );
	}
	return 0;
}

static int DeleteIndexTree ( )
{
	DelTr ( Root.child );
	return 0;
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}
static void printMarkedText ( const char *d, u_int32_t s, FILE *f )
{
	if (s) {
		long* ptr = (long*) d, scount = s / sizeof (long);
		while (scount) {
			printf ("%ld :", *ptr++); scount--;
			long count = *ptr++; scount--;
			for (; count; count--, scount--)
				printf (" %ld", *ptr++);
			printf ("\n");
		}
	}
}
