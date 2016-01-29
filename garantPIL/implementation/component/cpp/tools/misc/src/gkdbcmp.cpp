#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"
#include "shared/ContextSearch/Defs/Defs.h"

#include "osdep.h"
#include "garver.h"
#include "gardefs.h"
#include "basemask.h"
#include "garutils.h"
#include "refcol.h"
#include "StorableSplaySet.h"
#include "stringz.h"
#include "SearchB.h"
#include "pack.h"
#include "advlog.h"

#include "shared/Core/sys/AutoInit.h"

#include <boost/thread.hpp>
#include "boost/assign/std/deque.hpp"

// constants for check(..)
#define KV_NONE		0
#define KV_ASCIIZ	1
#define KV_INT16	2
#define KV_DATE		3
#define KV_INT32	4
#define KV_8BYTES	5
#define KV_REF		6
#define KV_H		7
#define KV_ATTR		8
#define KV_BLOB		9
#define KV_NCONTXT  10
#define	KV_REFC		11
#define	KV_REFKC	12

class BaseInfoMap : public SplayMap<short, BaseInfo>
{
	static BaseInfo bi_dummy;

public :
	BaseInfoMap( Base* base ) : SplayMap<short, BaseInfo>(bi_dummy) {
		if ( base ) {			
			StorableSplaySet<short> here;
			Stream* str = base->FindIndex ("Aux")->Open ( "Here" );			
			here.Get ( str );
			base->FindIndex ("Aux")->Close ( str );
			here._add(0);
			
			for ( Point p = here.first(); p; here.next(p) ) {
				BaseInfo info;
				if ( base->FindBaseInfo ( here.contents (p), info ) )
					add ( here.contents (p), info );
			}
		}		
	}
	BaseInfoMap(const BaseInfoMap& a) : SplayMap<short, BaseInfo>(a) {}
};

BaseInfo BaseInfoMap::bi_dummy;

#define	MAX_THREADS	16
struct thread_data_struct {
	YBase *base1, *base2;
	volatile int done, run;
	long from_id, to_id;
	long id;
	bool error;
	std::vector<std::string> errors;
};
thread_data_struct thread_data [MAX_THREADS + 4];

std::deque<long> old_docs, new_docs;

void	get_docs_in_bases (YBase *b1, YBase* b2)
{
	if (new_docs.size () + old_docs.size () == 0) {
		for (std::vector<Base*>::const_iterator base_it = b1->bases_ptrs.begin (); base_it != b1->bases_ptrs.end (); base_it++) {
			AttrKey attr_key = {ID_BORDER, IDD_INFO};
			for (BTIterator it ((*base_it)->FindIndex ("Attrs"), &attr_key); !it.End (); ++it) {
				AttrKey *key = (AttrKey*) it.Key ();
				if (key->AttrTag != IDD_INFO)
					break;
				old_docs.push_back (key->DocId);
			}
		}
		std::sort (old_docs.begin (), old_docs.end ()); old_docs.erase (std::unique (old_docs.begin (), old_docs.end ()), old_docs.end ());

		for (std::vector<Base*>::const_iterator base_it = b2->bases_ptrs.begin (); base_it != b2->bases_ptrs.end (); base_it++) {
			AttrKey attr_key = {ID_BORDER, IDD_INFO};
			for (BTIterator it ((*base_it)->FindIndex ("Attrs"), &attr_key); !it.End (); ++it) {
				AttrKey *key = (AttrKey*) it.Key ();
				if (key->AttrTag != IDD_INFO)
					break;
				new_docs.push_back (key->DocId);
			}
		}
		std::sort (new_docs.begin (), new_docs.end ()); new_docs.erase (std::unique (new_docs.begin (), new_docs.end ()), new_docs.end ());
	}
}

bool	fatalError = false;
short	check_only_attr = 0;
int hcheck ( Base *b1, Base* b2, char* name, int keyId, int itemsize, int second, std::vector<std::string> *strings = 0 );

struct IndexRec
{
	char	*name;
	char status;
	int	id;
	int	itemsize;
	int	second;
};

IndexRec Indexes [] =
{
	{ "Date",			'e', KV_DATE  , 4 }, // contains docs
	{ "RegDate",		'e', KV_DATE  , 8 },
	{ "AnnulDate",		'e', KV_DATE  , 8 },
	{ "Active",		    'e', KV_DATE  , 8 },
	{ "AnnoDate",		'e', KV_DATE  , 4 }, // contains docs
	{ "CalIn", 			'e', KV_DATE  , 4 }, // contains docs
	{ "CalAb", 			'e', KV_DATE  , 4 }, // contains docs
	{ "CalCh", 			'e', KV_DATE  , 4 }, // contains docs
	{ "RDate",			'e', KV_DATE  , 4 }, // contains docs
	{ "VIncluded", 		'e', KV_DATE  , 4 }, // contains docs
	{ "VChanged",		'e', KV_DATE  , 4 }, // contains docs
	{ "VAbolished",		'e', KV_DATE  , 4 }, // contains docs
	{ "SortDate", 		'e', KV_DATE  , 4 }, // contains docs /*?*/
	{ "VAnonced",		'e', KV_DATE  , 4 }, // contains docs
	{ "VLControl",		'e', KV_DATE  , 4 }, // contains docs
	{ "Category",		'e', KV_ASCIIZ, 4 }, // contains docs
	{ "TradeName",		'e', KV_ASCIIZ, 4 },
	{ "IntName",		'e', KV_ASCIIZ, 4 },
	{ "Number", 		'e', KV_ASCIIZ, 4 }, // contains docs
	{ "RCode",  		'e', KV_ASCIIZ, 4 }, // contains docs
	{ "Status", 		'e', KV_INT16 , 4 }, // contains docs
	{ "Status_ex", 		'e', KV_INT16 , 8 },
	{ "Segment", 		'e', KV_INT16 , 4 }, // contains docs
	{ "Respondent", 	'e', KV_INT32 , 8 }, // contains refs
	{ "Correspondent", 	'e', KV_INT32 , 8 }, // contains refs
	{ "KindCorr", 	    'e', KV_REFKC,  sizeof (KindCorrRef) },
	{ "SubName", 		'e', KV_REF       }, // contains asciiz
	{ "Attribs",		'f', KV_ATTR      }, // contains misc info
	{ "Attrs",			'f', KV_ATTR      }, // contains misc info
	{ "Blob",			'f', KV_BLOB, 1,1 },	// contains blob
	{ "NewCorr",		'w', KV_REFC, sizeof(CorrRef) }, // contains misc info
	{ "Control",		'f', KV_DATE , sizeof(long)*2 },
	{ "Tag", 			'f', KV_ASCIIZ, sizeof (RefwWeight)  },
	{ "" }
};

IndexRec TurboIndexes [] =
{
	{ "SWords",			'f', KV_INT32   },
	{ "NWCntxt",		'f', KV_NCONTXT },
	{ "NFContxt",		'w', KV_ASCIIZ  },
	{ "" }
};

IndexRec HIndexes [] =
{
	{ "ServiceInfo", 'f', KV_H, 8    },	// contains refs
	{ "Type", 		 'f', KV_H, 8    },	// contains refs
	{ "KeyWord",	 'f', KV_H, 8    },	// contains refs
	{ "PublishedIn", 'f', KV_H, 4    },	// contains docs
	{ "Territory",	 'f', KV_H, 4    },	// contains docs
	{ "Class",		 'f', KV_H, 8    },	// contains refs, asciiz
	{ "Class6",		 'f', KV_H, 8    },	// contains refs, asciiz
	{ "DocKind",	 'f', KV_H, 8    },	// contains refs, asciiz
	{ "Kind",	     'f', KV_H, 8    },	// contains refs
	{ "Adopted",	 'f', KV_H, 4    },	// contains docs, asciiz
	{ "AnnoUser",			'f', KV_H, 4 },
	{ "AnnoOrganization",	'f', KV_H, 4 },
	{ "AnnoTax",			'f', KV_H, 4 },
	{ "AnnoInterest",		'f', KV_H, 4 },
	{ "AnnoKind",			'f', KV_H, 4 },
	{ "PhGroup",			'f', KV_H, 4 },
	{ "PhEffect",		'f', KV_H, 4 },
	{ "Chapter",			'f', KV_H, 8 },
	{ "Mkb",				'f', KV_H, 8 },
	{ "PhFirm",		'f', KV_H, 8 },
	{ "PhCountry",		'f', KV_H, 8 },
	{ "Atc",				'f', KV_H, 4 },
	{ "RegStatus",			'f', KV_H, 8 },
	{ "LekForm",			'f', KV_H, 8 },
	{ "" }
};

/////////////////////////////////////////////////////////////////////////
static int sstrcmp ( const void *s1, const void *s2 )
{
	char **p1 = (char**) s1;
	char **p2 = (char**) s2;
	return strcmp ( *p1, *p2 );
}

static int CheckStrSet ( char *buf1, char *buf2, u_int32_t len, std::vector<std::string> *strings = 0 )
{
	u_int32_t c1 = 0, c2 = 0;
	u_int32_t i, i1, i2;

	if ( !len )
		return 0;

	for ( i = 0; i < len; i++ )	// let's count the strings
	{
		if ( !buf1 [i] ) c1++;
		if ( !buf2 [i] ) c2++;
	}

	if ( c1 != c2 )
		return 1;		// different number of strings

	u_int32_t c = c1;

	if ( !c )			// no strings ? very strange...
	{
		mpcxc_printfwin (strings, "... no strings ???...");
		return 1;
	}

	char **p1 = (char**) malloc ( c * sizeof (char*) );
	char **p2 = (char**) malloc ( c * sizeof (char*) );

	p1 [0] = (char*) buf1;
	p2 [0] = (char*) buf2;

	for ( i = i1 = i2 = 1; i < len - 1; i++ )
	{
		if ( !buf1 [i] ) p1 [i1++] = (char*) (&(buf1 [i+1]));
		if ( !buf2 [i] ) p2 [i2++] = (char*) (&(buf2 [i+1]));
	}

	qsort ( p1, c, sizeof ( char* ), sstrcmp );
	qsort ( p2, c, sizeof ( char* ), sstrcmp );

	int res = 0;
	for ( i = 0; i < c; i++ ) {	// now check
		res = strcmp ( p1 [i], p2 [i] );
		if ( res ) break;
	}

	free ( p1 );
	free ( p2 );
	return res;
}

static void DiffStrSet ( char *buf1, u_int32_t len1, char *buf2, u_int32_t len2, std::vector<std::string> *strings = 0 )
{
	StringZ str1 ( buf1, len1, 0 );
	StringZ str2 ( buf2, len2, 0 );
	
	while ( !str1.End () ) {
		if ( str2.Find ( str1() ) == -1 )
			mpcxc_printfwin (strings, "not in base2: %s\n", str1() );
		++str1;
	}
	
	while ( !str2.End () ) {
		if ( str1.Find ( str2() ) == -1 )
			mpcxc_printfwin (strings, "not in base1: %s\n", str2() );
		++str2;
	}
}

static int datecmp ( const void *d1, const void *d2 )
{
	return memcmp ( d1, d2, sizeof ( date ) );
}

int CheckDateSet ( char *buf1, char *buf2, u_int32_t len )
{
	qsort ( buf1, len / sizeof ( date ), sizeof ( date ), datecmp );
	qsort ( buf2, len / sizeof ( date ), sizeof ( date ), datecmp );
	return memcmp ( buf1, buf2, len );
}

#ifdef	VERSION56
int CheckActives( char *buf1, char *buf2, u_int32_t len )
{
	return memcmp ( buf1, buf2, len );
}
#endif

static int uint64tcmp ( const void *s1, const void *s2 )
{
	return memcmp ( s1, s2, 8);
}

int CheckDateRefSet ( char *buf1, char *buf2, u_int32_t len )
{
	qsort ( buf1, len / sizeof (u_int64_t), sizeof (u_int64_t), uint64tcmp);
	qsort ( buf2, len / sizeof (u_int64_t), sizeof (u_int64_t), uint64tcmp);
	return memcmp ( buf1, buf2, len );
}

static int subcmp ( const void *s1, const void *s2 )
{
	return memcmp ( s1, s2, sizeof ( SubDesc ) );
}

int CheckSubSet ( char *buf1, char *buf2, u_int32_t len )
{
	qsort ( buf1, len / sizeof ( SubDesc ), sizeof ( SubDesc ), subcmp );
	qsort ( buf2, len / sizeof ( SubDesc ), sizeof ( SubDesc ), subcmp );
	return memcmp ( buf1, buf2, len );
}

int checkStreams ( Stream* str1, Stream *str2 );
int checkStreamsInfo ( void* str1, void *str2 );
int checkStreamsBlob ( Stream* str1, Stream *str2 );
/////////////////////////////////////////////////////////////////////////
void printAttrTag ( int tag, std::vector<std::string> *strings = 0 )
{
	switch ( tag ) {
#ifndef	VERSION61
		case IDD_NAME	: mpcxc_printfwin ( "IDD_NAME"       ); break;
		case IDD_PARAIDS:	mpcxc_printfwin( "IDD_PARAIDS" );	break;
#else
		case IDD2_PARAIDS:	mpcxc_printfwin(strings, "IDD_PARAIDS");		break;
#endif
		case IDD_DATE	: mpcxc_printfwin (strings, "IDD_DATE"       ); break;
		case IDD_ID: mpcxc_printfwin (strings, "IDD_ID"         ); break;
		case IDD_CHDATE_EXEX: mpcxc_printfwin ( strings, "IDD_CHDATE_EXEX" ); break;
		case IDD_ADDCODE: mpcxc_printfwin (strings,  "IDD_ADDCODE" ); break;
		case IDD_SOURCE	: mpcxc_printfwin (strings,  "IDD_SOURCE"     ); break;
		case IDD_DIV	: mpcxc_printfwin (strings,  "IDD_DIV"        ); break;
		case IDD_DOCKIND: mpcxc_printfwin (strings,  "IDD_DOCKIND"    ); break;
		case IDD_KEY	: mpcxc_printfwin (strings,  "IDD_KEY"	    ); break;
		case IDD_TYPE	: mpcxc_printfwin (strings,  "IDD_TYPE"	    ); break;
		case IDD_TAG	: mpcxc_printfwin (strings,  "IDD_TAG"	    ); break;
		case IDD_CLASS6	: mpcxc_printfwin (strings,  "IDD_CLASS6"    ); break;
		case IDD_INFO	: mpcxc_printfwin (strings,  "IDD_INFO"	    ); break;
		case IDD_SUBS	: mpcxc_printfwin (strings,  "IDD_SUBS"	    ); break;
		case IDD_DOCSTRUCT : mpcxc_printfwin (strings,  "IDD_DOCSTRUCT" ); break;
		case IDD_CHANGE	: mpcxc_printfwin (strings,  "IDD_CHANGE"    ); break;
		case IDD_RUNS	: mpcxc_printfwin (strings,  "IDD_RUNS"	    ); break;
		case IDD_BLOCKS	: mpcxc_printfwin (strings,  "IDD_BLOCKS"     ); break;
		case IDD_BASES	: mpcxc_printfwin (strings,  "IDD_BASES"	    ); break;
		case IDD_RCODE	: mpcxc_printfwin (strings,  "IDD_RCODE"	    ); break;
		case IDD_HANDMASK	: mpcxc_printfwin (strings,  "IDD_HANDMASK"   ); break;
		case IDD_HANDHANDMASK	: mpcxc_printfwin (strings,  "IDD_HANDHANDMASK" ); break;
		case IDD_CALIN : mpcxc_printfwin (strings,  "IDD_CALIN"  ); break;
		case IDD_CALAB : mpcxc_printfwin (strings,  "IDD_CALAB"  ); break;
		case IDD_CALCH : mpcxc_printfwin (strings,  "IDD_CALCH"  ); break;
		case IDD_VINCLUDED	: mpcxc_printfwin (strings,  "IDD_VINCLUDED"  ); break;
		case IDD_VCHANGED	: mpcxc_printfwin (strings,  "IDD_VCHANGED"   ); break;
		case IDD_VABOLISHED : mpcxc_printfwin (strings,  "IDD_VABOLISHED" ); break;
		case IDD_RDATE	: mpcxc_printfwin (strings,  "IDD_RDATE"	    ); break;
		case IDD_SORTDATE	: mpcxc_printfwin (strings,  "IDD_SORTDATE"   ); break;
		case IDD_WARNING	: mpcxc_printfwin (strings,  "IDD_WARNING"    ); break;
		case IDD_VANONCED	: mpcxc_printfwin (strings,  "IDD_VANONCED"   ); break;
		case IDD_VLCONTROL	: mpcxc_printfwin (strings,  "IDD_VLCONTROL"  ); break;
		case IDD_SOURCEFILE : mpcxc_printfwin (strings,  "IDD_SOURCEFILE" ); break;
		case IDD_CATEGORY	: mpcxc_printfwin (strings,  "IDD_CATEGORY"   ); break;
		case IDD_PUBLISHEDIN: mpcxc_printfwin (strings,  "IDD_PUBLISHEDIN"); break;
		case IDD_TERRITORY  : mpcxc_printfwin (strings,  "IDD_TERRITORY"  ); break;
		case IDD_ACTIVE:	mpcxc_printfwin(strings,  "IDD_ACTIVE" );		break;
		case IDD_PAGEBREAKS:	mpcxc_printfwin(strings,  "IDD_PAGEBREAKS");	break;
		case IDD_CHDATE:	mpcxc_printfwin(strings,  "IDD_CHDATE" );		break;
		case IDD_PROFDATE:	mpcxc_printfwin(strings,  "IDD_PROFDATE" );		break;
		case IDD_CHDATE_EX:	mpcxc_printfwin(strings,  "IDD_CHDATE_EX" );		break;
		case IDD_CONTENTS:	mpcxc_printfwin(strings,  "IDD_CONTENTS");		break;
		case IDD_COMPARECONTENTS:	mpcxc_printfwin(strings,  "IDD_COMPARECONTENTS");		break;
		case IDD_NOTSURE:	mpcxc_printfwin(strings,  "IDD_NOTSURE");		break;
		case IDD_SAMEDOCS:	mpcxc_printfwin(strings,  "IDD_SAMEDOCS");		break;
		case IDD_SERVICEINFO:	mpcxc_printfwin(strings,  "IDD_SERVICEINFO");	break;
		case IDD_REFS:		mpcxc_printfwin(strings,  "IDD_REFS");		break;
		case IDD_BLOBS:		mpcxc_printfwin(strings,  "IDD_BLOBS");		break;
		case IDD_DIVISION:	mpcxc_printfwin(strings,  "IDD_DIVISION");	break;
		case IDD_PREANNODATE:			mpcxc_printfwin(strings,  "IDD_PREANNODATE" ); break;
		case IDD_ANNODATE:				mpcxc_printfwin(strings,  "IDD_ANNODATE" ); break;
		case IDD_PREANNOUSER:			mpcxc_printfwin(strings,  "IDD_PREANNOUSER" ); break;
		case IDD_PREANNOORGANIZATION:	mpcxc_printfwin(strings,  "IDD_PREANNOORGANIZATION" ); break;
		case IDD_PREANNOTAX:			mpcxc_printfwin(strings,  "IDD_PREANNOTAX" ); break;
		case IDD_PREANNOINTEREST:		mpcxc_printfwin(strings,  "IDD_PREANNOINTEREST" ); break;
		case IDD_PREANNOKIND:			mpcxc_printfwin(strings,  "IDD_PREANNOKIND" ); break;
		case IDD_ANNOUSER:				mpcxc_printfwin(strings,  "IDD_ANNOUSER" ); break;
		case IDD_ANNOORGANIZATION:		mpcxc_printfwin(strings,  "IDD_ANNOORGANIZATION" ); break;
		case IDD_ANNOTAX:				mpcxc_printfwin(strings,  "IDD_ANNOTAX" ); break;
		case IDD_ANNOINTEREST:			mpcxc_printfwin(strings,  "IDD_ANNOINTEREST" ); break;
		case IDD_ANNOKIND:				mpcxc_printfwin(strings,  "IDD_ANNOKIND" ); break;
		case IDD_ANNULDATE:				mpcxc_printfwin(strings,  "IDD_ANNULDATE" ); break;
		case IDD_REGDATE:				mpcxc_printfwin(strings,  "IDD_REGDATE" ); break;
		case IDD_SUBS_EX:				mpcxc_printfwin(strings,  "IDD_SUBS_EX" ); break;
		case IDD_EVD:					mpcxc_printfwin(strings,  "IDD_EVD" ); break;
		case IDD_KIND:					mpcxc_printfwin(strings,  "IDD_KIND"); break;
		case IDD_ACTIVEEX:				mpcxc_printfwin(strings,  "IDD_ACTIVEEX"); break;
		case IDD_REFS_BLOCKS:			mpcxc_printfwin(strings,  "IDD_REFS_BLOCKS"); break;

		default:
			mpcxc_printfwin (strings,  "Unknown tag: %d (0x%02X)\n", tag, tag );
	}
}

void printValue ( const void *key, int id, HIndex *idx, std::vector<std::string> *strings = 0 )
{
	switch ( id )
	{
	    case KV_ASCIIZ:
			mpcxc_printfwin (strings, "'%s'", (char *) key );
			break;
	    case KV_DATE:
			mpcxc_printfwin (strings, "dated %02d/%02d/%04d",
				((date*) key) -> da_day,
				((date*) key) -> da_mon,
				((date*) key) -> da_year );
			break;
	    case KV_INT16:
			mpcxc_printfwin (strings, "%d", *((int16_t*) key ) );
			break;
	    case KV_REF:
		case KV_REFKC:
			mpcxc_printfwin (strings, "%d.%d", ((Ref*)key)->DocId, ((Ref*)key)->Sub );
			break;
	    case KV_INT32:
			mpcxc_printfwin (strings, "%d", *((int32_t*) key ) );
			break;
	    case KV_8BYTES:
		{
			char tmp [9];
			memcpy ( tmp, key, 8 );
			tmp [8] = 0;
			mpcxc_printfwin (strings, "%s", tmp );
			break;
		}
	    case KV_H:
			mpcxc_printfwin (strings, "(%ld|%ld|%ld|%ld) '%s'",
				idx -> Id ( key ),
				idx -> Parent ( key ),
				idx -> AllChildrenCount ( key ),
				idx -> OwnChildrenCount ( key ),
				idx -> Text ( key ) );
			break;
	    case KV_ATTR:
			printAttrTag ( ( ( AttrKey*) key ) -> AttrTag, strings );
			mpcxc_printfwin (strings, " docid=%ld", ( (AttrKey*) key ) -> DocId );
			break;
	    case KV_BLOB:
			mpcxc_printfwin (strings, "BLOB#%ld", *(long*) key );
			break;
		case KV_NCONTXT:
			static char tmpZZZ[32+1];
			memcpy(tmpZZZ, (char*)key+1, (*(char*)key & 0x7f) - 1);
			tmpZZZ[(*(char*)key & 0x7f) -1]= 0;
			if(*(unsigned char*)key & 0x80)
				mpcxc_printfwin (strings, "P(%s)", tmpZZZ );
			else
				mpcxc_printfwin (strings, "N(%s)", tmpZZZ );
			break;
		case KV_REFC:
			mpcxc_printfwin (strings, "%d", *((int32_t*) key ) );
			break;
	}
	if (!strings) fflush(stdout);
}

#define ERROR_MPCXC	{error_count++; hError = true; } // GARANT_MSVC7: system macro

#define PRINT_DIFFER(n)						\
if ( col##n.ItemCount )						\
{								\
	mpcxc_printfwin ( "In base %d (but not in other base):\n", n );	\
	result = 1;						\
	for ( int i = 0; i < col##n.ItemCount; i++ )		\
		mpcxc_printfwin ( "%ld ", col##n [i] );			\
	mpcxc_printfwin ( "\n" );					\
}

#define PRINT_DIFFER_REF(n)						   \
if ( col##n.ItemCount )							   \
{									   \
	mpcxc_printfwin ( "In base %d (but not in other base):\n", n );		   \
	result = 1;							   \
	for ( int i = 0; i < col##n.ItemCount; i++ )			   \
		mpcxc_printfwin ( "(%ld.%ld) ", col##n [i].DocId, col##n [i].Sub ); \
	mpcxc_printfwin ( "\n" );						   \
}

int checkCollections ( char* name, char* s1, char* s2, Stream* str1, Stream *str2, int itemsize, std::vector<std::string> *strings = 0 )
{
	int result = 0;

	/*
	if (!strcmp (name, "Class6")) {
		RefCollection col1, col2;

		col1.Get ( str1 );
		col2.Get ( str2 );

		RefCollection tmp ( col1 );
		tmp.Intersect ( col2 );
		col1.Minus ( tmp );
		col2.Minus ( tmp );

		PRINT_DIFFER_REF ( 1 );
		PRINT_DIFFER_REF ( 2 );
		return result;
	}
	*/

	void *aData1 = malloc ( str1->Length() );
	void *aData2 = malloc( str2->Length() );
	str1->Read( aData1, str1->Length() );
	str2->Read( aData2, str2->Length() );
	if ( memcmp( aData1, aData2, str1->Length() ) ) result = 1;
	free( aData1 );
	free( aData2 );
	if ( result ) {
		mpcxc_printfwin(strings, "mismatch of data for keys \"%s\" and \"%s\"\n", s1, s2 );
		if (!strings) fflush(stdout);
	}
	return result;
}

int checkStreams ( Stream* str1, Stream *str2 )
{
	int len1 = str1 -> Length ( );
	int len2 = str2 -> Length ( );
	int len  = std::min ( len1, len2 ); // GARANT_STL

	void *buf1 = malloc ( len );
	void *buf2 = malloc ( len );

	str1 -> Read ( buf1, len );
	str2 -> Read ( buf2, len );

	int res = memcmp ( buf1, buf2, len ) || ( len1 != len2 );

	free ( buf1 );
	free ( buf2 );

	return res;
}

int checkStreamsInfo ( void* str1, void *str2)
{
	DocInfo *d1 = (DocInfo*)str1;
	DocInfo *d2 = (DocInfo*)str2;

	int res = 0;
	if ( strcmp ( d1 -> Title, d2 -> Title ) )
		res=1,mpcxc_printfwin ( "\nmismatch in 'Title':\n\t>%s<\n\t>%s<", d1 -> Title, d2 -> Title ),fflush(stdout);
	if ( d1 -> ParaCount != d2 -> ParaCount )
		res=1,mpcxc_printfwin ( "\nmismatch in 'ParaCount' ( %ld, %ld )", d1 -> ParaCount, d2 -> ParaCount ),fflush(stdout);
	if ( d1 -> Force != d2 -> Force )
		res=1,mpcxc_printfwin ( "\nmismatch in 'Force' ( %d, %d )", d1 -> Force, d2 -> Force ),fflush(stdout);
	if ( d1 -> HyperRefs != d2 -> HyperRefs )
		res=1,mpcxc_printfwin ( "\nmismatch in 'HyperRefs' ( %d, %d )", d1 -> HyperRefs, d2 -> HyperRefs ),fflush(stdout);
	if ( d1 -> GreenComments != d2 -> GreenComments )
		res=1,mpcxc_printfwin ( "\nmismatch in 'GreenComments' ( %d, %d )", d1 -> GreenComments, d2 -> GreenComments ),fflush(stdout);
	if ( d1 -> Status != d2 -> Status )
		res=1,mpcxc_printfwin ( "\nmismatch in 'Status' ( 0x%hX, 0x%hX )", d1 -> Status, d2 -> Status ),fflush(stdout);
	if ( d1 -> Status_ex != d2 -> Status_ex )
		res=1,mpcxc_printfwin ( "\nmismatch in 'Status_ex' ( 0x%hX, 0x%hX )", d1 -> Status_ex, d2 -> Status_ex ),fflush(stdout);
	if ( d1 -> Related != d2 -> Related )
		res=1,mpcxc_printfwin ( "\nmismatch in 'Related' ( %ld, %ld )", d1 -> Related, d2 -> Related ),fflush(stdout);
	if ( memcmp ( &d1 -> Revision, &d2 -> Revision, sizeof ( revision ) ) )
		res=1,mpcxc_printfwin ( "\nmismatch in 'Revision'" ),fflush(stdout);
	if ( memcmp ( &d1 -> FirstDate, &d2 -> FirstDate, sizeof ( date ) ) )
		res=1,mpcxc_printfwin ( "\nmismatch in 'FirstDate'" ),fflush(stdout);
	if ( memcmp ( &d1 -> LastDate, &d2 -> LastDate, sizeof ( date ) ) )
		res=1,mpcxc_printfwin ( "\nmismatch in 'LastDate'" ),fflush(stdout);
	if ( GetDocStatusExEx (d1) != GetDocStatusExEx (d2))
		res=1,mpcxc_printfwin ( "\nmismatch in 'Status_ExEx'" ),fflush(stdout);
	if ( d1 -> prevEdition != d2 -> prevEdition )
		res=1,mpcxc_printfwin ( "\nmismatch in 'prevEdition' ( %ld, %ld )", d1 -> prevEdition, d2 -> prevEdition ),fflush(stdout);
	if ( d1 -> nextEdition != d2 -> nextEdition )
		res=1,mpcxc_printfwin ( "\nmismatch in 'nextEdition' ( %ld, %ld )", d1 -> nextEdition, d2 -> nextEdition ),fflush(stdout);
	if ( GetDocRespondents64(d1) != GetDocRespondents64(d2))
		res=1,mpcxc_printfwin ( "\nmismatch in 'respondents' ( %lld, %lld )", GetDocRespondents64 (d1), GetDocRespondents64 (d2)),fflush(stdout);
	if ( GetDocMonitoring (d1) != GetDocMonitoring (d2) )
		res=1,mpcxc_printfwin ( "\nmismatch in 'anno' ( %ld, %ld )", GetDocMonitoring (d1), GetDocMonitoring (d2)),fflush(stdout);
	if ( d1 -> lastParaID != d2 -> lastParaID)
		res=1,mpcxc_printfwin ( "\nmismatch in 'lastParaID' ( %ld, %ld )", d1 -> lastParaID, d2 -> lastParaID),fflush(stdout);

	return res;
}

int checkStreamsBlob ( Stream* str1, Stream *str2 )
{
        int res = 0;

        int len1 = str1 -> Length ( );
        int len2 = str2 -> Length ( );
        int len	 = std::min ( len1, len2 );

	if (len1 != len2)
		res=1,mpcxc_printfwin ( "\nlength not equalent" );

        void *buf1 = malloc ( len );
        void *buf2 = malloc ( len );

        str1 -> Read ( buf1, len );
        str2 -> Read ( buf2, len );

        ObjInfo *o1 = (ObjInfo*)buf1;
        ObjInfo *o2 = (ObjInfo*)buf2;

        if ( o1 -> size != o2 -> size )
                res=1,mpcxc_printfwin ( "\nmismatch in 'size' ( %ld, %ld )", o1 -> size, o2 -> size ),fflush(stdout);
        if ( o1 -> crc32 != o2 -> crc32 )
                res=1,mpcxc_printfwin ( "\nmismatch in 'crc32' ( %ld, %ld )", o1 -> crc32, o2 -> crc32 ),fflush(stdout);
        if ( o1 -> type != o2 -> type )
                res=1,mpcxc_printfwin ( "\nmismatch in 'type' ( %ud, %ud )", o1 -> type, o2 -> type ),fflush(stdout);
        if ( o1 -> packed != o2 -> packed )
                res=1,mpcxc_printfwin ( "\nmismatch in 'packed' ( %d, %d )", o1 -> packed, o2 -> packed ),fflush(stdout);
        if ( strcmp ( o1 -> name, o2 -> name ) )
                res=1,mpcxc_printfwin ( "\nmismatch in 'name':\n\t>%s<\n\t>%s<", o1 -> name, o2 -> name ),fflush(stdout);
        if ( memcmp (((char*)buf1)+sizeof(ObjInfo), ((char*)buf2)+sizeof(ObjInfo), len-sizeof(ObjInfo)) )
                res=1,mpcxc_printfwin ( "\ndata corupted" ),fflush(stdout);

        free ( buf1 );
        free ( buf2 );

        return res;
}

/*static void printStrSet ( const char *n, const char *d, int size )
{
	mpcxc_printfwin ( "\n%s\n", n );
	for ( int i = 0; i < size; i++ )
		mpcxc_printfwin ( "%c", d [i] ? d [i] : '\n' );
}*/

static void printDateSet ( const char *n, const char *d, int size, std::vector<std::string> *strings = 0)
{
	mpcxc_printfwin (strings, "\n%s\n", n );
	date *dd = (date*) d;
	for ( int i = 0; i < (int)(size / sizeof ( date )); i++, dd++ )
		mpcxc_printfwin (strings, "(%02d/%02d/%04d) ", dd -> da_day, dd -> da_mon, dd -> da_year );
	mpcxc_printfwin (strings, "\n" );
	fflush(stdout);
}

static void printSubSet ( const char *n, const char *d, int size, std::vector<std::string> *strings = 0)
{
	mpcxc_printfwin (strings, "\n%s\n", n );
	SubDesc *dd = (SubDesc*) d;
	for ( int i = 0; i < (int)(size / sizeof ( SubDesc )); i++, dd++ )
		mpcxc_printfwin (strings, "(%02ld.%02ld) ", dd -> Sub, dd -> Para );
	mpcxc_printfwin (strings, "\n" );
	fflush(stdout);
}


#define OPEN_INDEX(n)							   \
Index *ind##n = b##n -> FindIndex ( name ); 					   \
if ( !ind##n )								   \
{									   \
	mpcxc_printfwin (strings, "Cannot find index %s for base %d\n", name, n ); \
	if (!strings) fflush(stdout); \
	return 1; 							   \
}

#define OPEN_HHINDEX(n)							   \
HIndex *ind##n = (HIndex*) b##n -> FindIndex ( name ); 					   \
if ( !ind##n )								   \
{									   \
	mpcxc_printfwin (strings, "Cannot find hindex %s for base %d\n", name, n ); \
	fflush(stdout); \
	return 1; 							   \
}

#define IT_OPEN_STREAM(n,i)					\
Stream *str##n = it##n.keyOpen ( i );		\
if ( !str##n )							\
{								\
	mpcxc_printfwin (strings, "No data in index '%s' for the key ", name );	\
	printValue ( key##n, keyId, (HIndex*)ind##n, strings );		\
	mpcxc_printfwin (strings, "in base %d\n", n );				\
	++it1;							\
	++it2;							\
	ERROR_MPCXC;							\
	continue;						\
}

#define OPEN_STREAM(n,i)					\
Stream *str##n = ind##n -> keyOpen ( key##n, i );		\
if ( !str##n )							\
{								\
	mpcxc_printfwin (strings, "No data in index '%s' for the key ", name );	\
	printValue ( key##n, keyId, (HIndex*)ind##n, strings );		\
	mpcxc_printfwin (strings, "in base %d\n", n );				\
	++it1;							\
	++it2;							\
	ERROR_MPCXC;							\
	continue;						\
}

#define H_OPEN_STREAM(key,n,i)					\
HIndex *ind##n = (HIndex*)b##n -> FindIndex ( name ); 			\
Stream *str##n = ind##n -> OpenN ( key, i );			\
if ( !str##n )							\
{								\
	mpcxc_printfwin (strings, "No data in index '%s' for the key ", name );	\
	mpcxc_printfwin (strings, key );						\
	mpcxc_printfwin (strings, "in base %d\n", n );				\
	ERROR_MPCXC;							\
}

#define ITERATOR_END(n,m)						    \
if ( it##n.End ( ) && ( !it##m.End ( )) )				    \
{									    \
	mpcxc_printfwin (strings, "\nIterator %d for index %s is longer then in %d\n",m,name,n);\
	while ( !it##m.End ( ) )					    \
	{								    \
		printValue ( it##m.Key ( ), keyId, (HIndex*)ind##m, strings );	    \
		mpcxc_printfwin(strings, "\n");						    \
		++it##m;						    \
	}								    \
}

#define KEY_DISBALANCE(nd,n,m)					\
while ( nd -> Compare ( key##n, key##m ) < 0 )			\
{								\
	mpcxc_printfwin (strings, "\nNo key " );					\
	printValue ( key##n, keyId, (HIndex*)ind##n, strings );		\
	mpcxc_printfwin (strings, " in base %d in index %s", m, name );		\
	++it##n;						\
	if ( it##n.End ( ) ) {							\
		mpcxc_printfwin (strings, "Index %s in base %d ended occationaly finding key ", name, n );			\
		printValue ( key##m, keyId, (HIndex*)ind##m, strings );	\
		return 0;				\
	}							\
	key##n = it##n.Key ( );					\
}

/*
#define HKEY_DISBALANCE(nd,n,m)					\
while ( HCompare ( key##n, key##m ) < 0 )			\
{								\
	ERROR_MPCXC; \
	mpcxc_printfwin ( "\nNo key " );					\
	printValue ( key##n, keyId, (HIndex*)ind##n );		\
	mpcxc_printfwin ( " in base %d in index %s", m, name );		\
	++it##n;						\
	if ( it##n.End ( ) )					\
	{							\
		mpcxc_printfwin ( "Index %s in base %d ended occationaly finding key ", \
				name, n );			\
		printValue ( key##m, keyId, (HIndex*)ind##m );	\
			return 0;				\
	}							\
	key##n = it##n.Key ( );					\
}
*/

//////// check usual indexes //////////

#include "paracol.h"

class	BTIteratorOld : public BTIterator
{
public:
	BTIteratorOld (Base *b1, const BTree *itree, const void * start_key = 0);
	BTIterator *pnew;

	virtual BTKEY Key ();
	virtual int	End ();
	virtual void next ();
	Stream* keyOpen(int sn= 0);
	void CloseStream(Stream *pstr);

public:
	char pCurrKey[256];
	int iCurrKeyFull;
	Stream *pTst;
	bool isSWords;
	long *pDel, *pDelNxt, pDelCount;
};

BTIteratorOld::BTIteratorOld (Base *b1, const BTree *itree, const void * start_key) : BTIterator(itree, start_key) {
	pDelNxt= pDel= 0; pDelCount= 0;
	isSWords= false;
	if((((Index*)itree)->Name[0] == 'N' && ((Index*)itree)->Name[1] == 'W') || (isSWords=(((Index*)itree)->Name[0] == 'S' && ((Index*)itree)->Name[1] == 'W'))) {
		Index *pNN= b1->FindIndex("Context.str");
		if(pNN->KeyCount > 1){
			pnew= new BTIterator(pNN);
			if(!isSWords)
				while(!pnew->End ( ) && !(*(char*)pnew->Key ())) ++(*pnew);
			else{
				Stream *ps= pNN->Index::keyOpen(pnew->Key(),1);
				if(ps){
					pDelCount= ps->Length()/sizeof(*pDel);
					pDelNxt= pDel= (long*)malloc(ps->Length());
					ps->Read(pDel, ps->Length());
					pNN->Close(ps);
				}
			}
		}else{
			pnew= 0;
			pNN->KeyCount= 0;
		}
	}else
		pnew= 0;

	iCurrKeyFull= 0;
	pTst= 0;
}

BTKEY BTIteratorOld::Key ()
{
	if(!pnew)
		return BTIterator::Key();
	return (BTKEY)pCurrKey;
}

int	BTIteratorOld::End ()
{  // whether iterator reached end of tree in either direction
	if(!pnew){
		return BTIterator::End();
	}
	if(iCurrKeyFull)
		return 0;

	int ret;
	do{
		if( (!isSWords && (*(char*)pnew->Key ()) & 0x40) || (isSWords && *(char*)pnew->Key ())){
			if(!BTIterator::End())
				ret= 1;
			else{
				delete pnew;
				pnew= 0;
				return 1;
			}
		}else if((ret= ((Index*)tree)->Compare((isSWords ? (((char*)(pnew->Key()))+1) : pnew->Key()), BTIterator::Key()))
					< (isSWords ? 1 : 0)){
			iCurrKeyFull= 1;
			if(isSWords){
				*(long*)pCurrKey = *(long*)((char*)pnew->Key() + 1);
				if(ret == 0)
					iCurrKeyFull= 2;
			}else
				memcpy((void*)pCurrKey, pnew->Key(), tree->KeyLength);
			return 0;
		}
		if(ret >= 0){
			if(isSWords){
				while(pDelCount && *pDelNxt < *(long*)(BTIterator::Key())){
					pDelCount--; pDelNxt++;
				}
				if(*pDelNxt == *(long*)(BTIterator::Key()))
					pTst= 0;
				else
					pTst= ((Index*)tree)->Index::keyOpen(BTIterator::Key());
			}else
				pTst= ((Index*)tree)->keyOpen(BTIterator::Key());
			if(pTst){
				memcpy((void*)pCurrKey, BTIterator::Key(), tree->KeyLength);
				if(ret == 0)
					iCurrKeyFull= 2;
				else
					iCurrKeyFull= 3;
			}else if(!BTIterator::End()){
				((BTIteratorOld*)this)->BTIterator::next();
				ret= 0x7fffffff;
			}else{
				delete pnew;
				pnew= 0;
				return 1;
			}
		}
	}while(ret == 0x7fffffff);
	return 0;
}

void BTIteratorOld::next ()
{
	if(!pnew){
		BTIterator::next();
	}else{
		if(pTst){
			if(pTst->Buf)
				free(pTst->Buf);
			pTst->Buf= 0;
			((Index*)tree)->Close(pTst);
		}
		pTst= 0;

		if(iCurrKeyFull == 1 || iCurrKeyFull == 2){
			pnew->next();
			if(iCurrKeyFull == 2)
				BTIterator::next();
			iCurrKeyFull= 0;
		}else{
			iCurrKeyFull= 0;
			BTIterator::next();
		}
	}
}

Stream* BTIteratorOld::keyOpen(int sn)
{
	if(!pnew || (!isSWords && iCurrKeyFull == 2) || (isSWords && iCurrKeyFull == 3)){
		if(pnew && pTst && sn == 0)
			return pTst;
		return ((Index*)this->tree)->keyOpen(this->Key(),sn);
	}
	if((!isSWords && iCurrKeyFull == 1) || (isSWords && iCurrKeyFull != 3))
		return ((Index*)pnew->tree)->keyOpen(pnew->Key(),sn);
	return ((Index*)tree)->keyOpen(Key(),sn);
}

void BTIteratorOld::CloseStream(Stream *pstr)
{
	if(pstr){
		if(pstr->getTempBuf()){
			free(pstr->getTempBuf());
		}
		if(pTst && pTst == pstr){
			pstr->setTempBuf(0);
		}else{
			pstr->setTempBuf(0);
			if((!isSWords && iCurrKeyFull != 1)||(isSWords && (!iCurrKeyFull || iCurrKeyFull == 3)))
				((Index*)tree)->Close(pstr);
			else 
				((Index*)pnew->tree)->Close(pstr);

		}
	}
}

int check ( Base *b1, Base* b2, char* name, int keyId, int itemsize, int col, int second, bool &hError, bool &iError, std::vector<std::string> *strings = 0)
{
	int error_count = 0, test_context= 1;
	bool b_check_attrs = !strcmp (name, "Attrs");

	if ((!stricmp (name, "Blob") || !stricmp (name, "Attribs")) && (b1->bases_ptrs.size () > 1 || b2->bases_ptrs.size () > 1)) {
		if (!stricmp (name, "Blob")) {
			std::set<long> blobs1, blobs2;
			std::vector<Base*>::const_iterator base_ptr;
			for (base_ptr = b1->bases_ptrs.begin (); base_ptr != b1->bases_ptrs.end (); base_ptr++) {
				for (BTIterator it ((*base_ptr)->FindIndex ("Blob")); !it.End (); ++it) {
					ObjKey *key = (ObjKey*) it.Key ();
					blobs1.insert (key->id);
				}
			}
			for (base_ptr = b2->bases_ptrs.begin (); base_ptr != b2->bases_ptrs.end (); base_ptr++) {
				for (BTIterator it ((*base_ptr)->FindIndex ("Blob")); !it.End (); ++it) {
					ObjKey *key = (ObjKey*) it.Key ();
					blobs2.insert (key->id);
				}
			}
			std::vector<long> diff_blobs;
			std::set_difference (blobs1.begin (), blobs1.end (), blobs2.begin (), blobs2.end (), std::back_inserter (diff_blobs));
			if (diff_blobs.size ()) {
				for (std::vector<long>::const_iterator diff_it = diff_blobs.begin (); diff_it != diff_blobs.end (); diff_it++) {
					long id = *diff_it;
					mpcxc_printfwin (strings, "No data in index %s for the key %ld", name, id);
					error_count++;
					if (blobs1.find (id) != blobs1.end ()) {
						mpcxc_printfwin ( "Blob %ld in base1, not in base2\n", id);
					} else {
						mpcxc_printfwin ( "Blob %ld in base2, not in base1\n", id);
					}
				}
			}
			for (std::set<long>::const_iterator blob_it = blobs1.begin (); blob_it != blobs1.end (); blob_it++) {
				long id = *blob_it;
				if (blobs2.find (id) == blobs2.end ())
					continue;
				ObjKey key;
				gk_bzero (&key, sizeof (key));
				key.id = id;

				for (int stream = 0; stream < 2; stream++) {
					Stream* str1 = b1->base_for_blob (id)->FindIndex ("Blob")->OpenN (&key, stream);
					Stream* str2 = b2->base_for_blob (id)->FindIndex ("Blob")->OpenN (&key, stream);

					if (str1 && str2) {
						int len1 = str1->Length ();
						int len2 = str2->Length ();
						if (len1 != len2) {
							mpcxc_printfwin (strings, "mismatch in stream %ld for index '%s', blob %ld\n", stream, name, id);
							error_count++;
						} else {
							char *buf1 = (char*) malloc (len1);
							char *buf2 = (char*) malloc (len2);
							str1->Read (buf1, len1);
							str2->Read (buf2, len2);
							if (memcmp (buf1, buf2, len1)) {
								mpcxc_printfwin (strings, "\nData for the key %ld in index %s mismatch, stream %ld\n", id, name, stream);
								error_count++;
							}
							gk_free (buf1);
							gk_free (buf2);
						}
					} else {
						mpcxc_printfwin (strings, "No data in index '%s', stream %ld for the key %ld in base %ld\n", name, stream, id, str1 ? 2 : 1);
						error_count++;
					}
					if (str1) b1->base_for_blob (id)->FindIndex ("Blob")->Close (str1);
					if (str2) b2->base_for_blob (id)->FindIndex ("Blob")->Close (str2);
				}
			}
		} else {
			std::set<long> ids1, ids2;
			std::vector<Base*>::const_iterator base_ptr;
			for (base_ptr = b1->bases_ptrs.begin (); base_ptr != b1->bases_ptrs.end (); base_ptr++) {
				for (BTIterator it ((*base_ptr)->FindIndex ("Attribs")); !it.End (); ++it) {
					ids1.insert (((AttrKey*)it.Key ())->DocId);
				}
			}
			for (base_ptr = b2->bases_ptrs.begin (); base_ptr != b2->bases_ptrs.end (); base_ptr++) {
				for (BTIterator it ((*base_ptr)->FindIndex ("Attribs")); !it.End (); ++it) {
					ids2.insert (((AttrKey*)it.Key ())->DocId);
				}
			}
			std::vector<long> diff_ids;
			std::set_difference (ids1.begin (), ids1.end (), ids2.begin (), ids2.end (), std::back_inserter (diff_ids));
			if (diff_ids.size ()) {
				for (std::vector<long>::const_iterator diff_it = diff_ids.begin (); diff_it != diff_ids.end (); diff_it++) {
					long id = *diff_it;
					mpcxc_printfwin (strings, "No data in index %s for the key %ld", name, id);
					error_count++;
					if (ids1.find (id) != ids1.end ()) {
						mpcxc_printfwin ( "Document %ld in base1, not in base2\n", id);
					} else {
						mpcxc_printfwin ( "Document %ld in base2, not in base1\n", id);
					}
				}
			}
			for (std::set<long>::const_iterator doc_it = ids1.begin (); doc_it != ids1.end (); doc_it++) {
				long id = *doc_it;
				if (ids2.find (id) == ids2.end ())
					continue;
				AttrKey key = {id, IDD2_PARAIDS};

				Stream* str1 = b1->base_for_doc (id)->FindIndex ("Attribs")->OpenN (&key, 0);
				Stream* str2 = b2->base_for_doc (id)->FindIndex ("Attribs")->OpenN (&key, 0);

				if (str1 && str2) {
					int len1 = str1->Length ();
					int len2 = str2->Length ();
					if (len1 != len2) {
						mpcxc_printfwin (strings, "mismatch for index '%s', doc %ld\n", name, id);
						error_count++;
					} else {
						char *buf1 = (char*) malloc (len1);
						char *buf2 = (char*) malloc (len2);
						str1->Read (buf1, len1);
						str2->Read (buf2, len2);
						if (memcmp (buf1, buf2, len1)) {
							mpcxc_printfwin (strings, "\nData for the key %ld in index %s mismatch\n", id, name);
							error_count++;
						}
						gk_free (buf1);
						gk_free (buf2);
					}
				} else {
					mpcxc_printfwin (strings, "No data in index '%s' for the key %ld in base %ld\n", name, id, str1 ? 2 : 1);
					error_count++;
				}
				if (str1) b1->base_for_doc (id)->FindIndex ("Attribs")->Close (str1);
				if (str2) b2->base_for_doc (id)->FindIndex ("Attribs")->Close (str2);
			}
		}
		return error_count;
	}

	OPEN_INDEX ( 1 );
	OPEN_INDEX ( 2 );
#ifdef	MULTI_INDEX_STREAM_FILE
	char nnn[]= "Context";
	if ( !stricmp( name, nnn ) || !(test_context= stricmp( name, "SWords" )) || !(test_context= stricmp( name, "NWCntxt" )) || !(test_context= stricmp( name, "NFContxt" ))) {
		int old_tst= 0;
		if(test_context){
			Index *pNN= b1->FindIndex(nnn);
			if(pNN->KeyCount > 0){
				old_tst= 1;
			}else{
				pNN= b2->FindIndex(nnn);
				if(pNN->KeyCount > 0){
					old_tst= 1;
				}
			}
		}else if ( ind1->Root == -1 || ind2->Root == -1 )
			old_tst= 1;
		if(old_tst){
			mpcxc_printfwin (strings, "Skipping..." );
			if (!strings) fflush(stdout);
			return 0;
		}
	}
#endif
	BTIteratorOld it1 ( b1, ind1 );
	BTIteratorOld it2 ( b2, ind2 );

	//if ( second )
	//	mpcxc_printfwin ( " (with second stream)" );

	while ( 1 ) {
		if ( it1.End ( ) && it2.End ( ) )
			break;

		if ( it1.End ( ) || it2.End ( ) ) {
			ITERATOR_END ( 1, 2 );
			ITERATOR_END ( 2, 1 );
			return 3;
		}


		const void *key1 = (void*) it1.Key ( );
		const void *key2 = (void*) it2.Key ( );

		while ( ( KV_ATTR == keyId ) && ( IDD_SOURCEFILE == ( ( AttrKey*) key1 ) -> AttrTag ) )
			{ ++it1; if ( it1.End()) break; key1 = (void*) it1.Key ( ); }
		while ( ( KV_ATTR == keyId ) && ( IDD_SOURCEFILE == ( ( AttrKey*) key2 ) -> AttrTag ) )
			{ ++it2; if ( it2.End()) break; key2 = (void*) it2.Key ( ); }

		if ( it1.End() || it2.End()) {
			if ( it1.End() && it2.End())
				break;
			else {
				ITERATOR_END ( 1, 2 );
				ITERATOR_END ( 2, 1 );
				return 3;
			}
		}

		while ( ( KV_ATTR == keyId ) && ( IDD_RUNS == ( ( AttrKey*) key1 ) -> AttrTag ) )
			{ ++it1; if ( it1.End()) break; key1 = (void*) it1.Key ( ); }
		while ( ( KV_ATTR == keyId ) && ( IDD_RUNS == ( ( AttrKey*) key2 ) -> AttrTag ) )
			{ ++it2; if ( it2.End()) break; key2 = (void*) it2.Key ( ); }
		while ( ( KV_ATTR == keyId ) && ( IDD_BLOCKS == ( ( AttrKey*) key1 ) -> AttrTag ) )
			{ ++it1; if ( it1.End()) break; key1 = (void*) it1.Key ( ); }
		while ( ( KV_ATTR == keyId ) && ( IDD_BLOCKS == ( ( AttrKey*) key2 ) -> AttrTag ) )
			{ ++it2; if ( it2.End()) break; key2 = (void*) it2.Key ( ); }
		while ( ( KV_ATTR == keyId )  && ( 100000 > ( ( AttrKey*) key1 ) -> DocId ) )
			{ ++it1; if ( it1.End()) break; key1 = (void*) it1.Key ( ); }
		while ( ( KV_ATTR == keyId )  && ( 100000 > ( ( AttrKey*) key2 ) -> DocId ) )
			{ ++it2; if ( it2.End()) break; key2 = (void*) it2.Key ( ); }

		KEY_DISBALANCE ( ind1, 1, 2 );
		KEY_DISBALANCE ( ind1, 2, 1 );

		int tag = ( (AttrKey*) key1 ) -> AttrTag;
		if (b_check_attrs && check_only_attr && tag != check_only_attr) {
			++it1;
			++it2;
			continue;
		}

		IT_OPEN_STREAM ( 1,0 );
		IT_OPEN_STREAM ( 2,0 );

		if ( KV_ATTR != keyId )
			tag = -1;		// not use

		int len1 = str1 -> Length ( );
		int len2 = str2 -> Length ( );

		if ( keyId == KV_BLOB && ( !len1 || !len2 )) {
			if (len1 + len2)
				mpcxc_printfwin (strings, "mismatch in streams (%ld)\n", *(long*)key1 );
			else
				mpcxc_printfwin (strings, "zero-length streams (%ld)\n", *(long*)key1 );
			fflush(stdout);
			++it1;
			++it2;
			continue;
		}

		if ( col ) {
			if ( itemsize ) {
				if ( len1 % itemsize ) {
					mpcxc_printfwin (strings, "Data for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in base 1 is invalid\n" );
					if (!strings) fflush(stdout);
					ERROR_MPCXC;
				} 
				if ( len2 % itemsize ) {
					mpcxc_printfwin (strings, "Data for the key " );
					printValue ( key2, keyId, 0, strings );
					mpcxc_printfwin (strings, " in base 2 is invalid\n" );
					if (!strings) fflush(stdout);
					ERROR_MPCXC;
				}
			}
			if (itemsize==8) {
				StorableSplaySet<Ref> one;
				StorableSplaySet<Ref> two;

				one.Get ( str1 );
				two.Get ( str2 );
				if ( one != two ) {
					mpcxc_printfwin (strings, "\nData for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );

					StorableSplaySet<Ref> andd;
					(andd = one) &= two;
					one -=andd;
					two -=andd;

					Point p;
					if ( one.length() ) mpcxc_printfwin (strings, "In base1 but not in base2:\n");
					for ( p = one.first(); p; one.next(p) )
						mpcxc_printfwin (strings, "\t(%ld, %ld)\n", one(p).DocId, one(p).Sub );
					if ( two.length() ) mpcxc_printfwin (strings, "In base2 but not in base1:\n" );
					for ( p = two.first(); p; two.next(p) )
						mpcxc_printfwin (strings, "\t(%ld, %ld)\n", two(p).DocId, two(p).Sub );
					if (!strings) fflush(stdout);
				} else if ( len1 != len2 ) {
					mpcxc_printfwin (strings, "\nLength of data for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					if (!strings) fflush(stdout);
				}
			} else if (itemsize==4) {
				if ( len1 != len2 ) {
					mpcxc_printfwin (strings, "\nLength of data for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					if (!strings) fflush(stdout);
				} else {
					long* one = (long*) malloc( len1 );
					long* two = (long*) malloc( len2 );
					str1->Read(one,len1);
					str2->Read(two,len2);

					if ( memcmp( one,two,len1 )) {
						mpcxc_printfwin (strings, "\nData for the key " );
						printValue ( key1, keyId, 0, strings );
						mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					}
					free( one );
					free( two );
				}
				/*
				StorableSplaySet<long> one;
				StorableSplaySet<long> two;

				one.Get ( str1 );
				two.Get ( str2 );
				if ( one != two ) {
					mpcxc_printfwin ( "\nData for the key " );
					printValue ( key1, keyId, 0 );
					mpcxc_printfwin ( " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );

					StorableSplaySet<long> andd;
					(andd = one) &= two;
					one -=andd;
					two -=andd;

					Point p;
					if ( one.length() ) mpcxc_printfwin ( "In base1 but not in base2:\n" );
					for ( p = one.first(); p; one.next(p) )
						mpcxc_printfwin ( "\t(%ld)\n", one(p) );
					if ( two.length() ) mpcxc_printfwin ( "In base2 but not in base1:\n" );
					for ( p = two.first(); p; two.next(p) )
						mpcxc_printfwin ( "\t(%ld)\n", two(p) );
					fflush(stdout);
				} else if ( len1 != len2 ) {
					mpcxc_printfwin ( "\nLength of data for the key " );
					printValue ( key1, keyId, 0 );
					mpcxc_printfwin ( " in index %s mismatch (%ld, %ld)\n",
						name, len1, len2 );
					fflush(stdout);
				}
				*/
			} else if (itemsize==2) {
				StorableSplaySet<short> one;
				StorableSplaySet<short> two;

				one.Get ( str1 );
				two.Get ( str2 );
				if ( one != two ) {
					mpcxc_printfwin (strings, "\nData for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );

					StorableSplaySet<short> andd;
					(andd = one) &= two;
					one -=andd;
					two -=andd;

					Point p;
					if ( one.length() ) mpcxc_printfwin (strings, "In base1 but not in base2:\n" );
					for ( p = one.first(); p; one.next(p) )
						mpcxc_printfwin (strings, "\t(%d)\n", one(p) );
					if ( two.length() ) mpcxc_printfwin (strings, "In base2 but not in base1:\n" );
					for ( p = two.first(); p; two.next(p) )
						mpcxc_printfwin (strings, "\t(%d)\n", two(p) );
					if (!strings) fflush(stdout);
				} else if ( len1 != len2 ) {
					mpcxc_printfwin (strings, "\nLength of data for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					if (!strings) fflush(stdout);
				}
			} else {
				if ( keyId == KV_BLOB ) {
				  if ( checkStreamsBlob ( str1, str2 ) ) {
					ObjKey* objkey = (ObjKey*)key1;
					mpcxc_printfwin (strings, "\nmismatch in streams0(%ld)\n", objkey->id );
					iError = true;
					fflush(stdout);
				  }
				} else {
					if ( !strcmp( name, "NWCntxt" )) {
						Stream *str1_0 = ind1->Open (key1), *str1_1 = ind1->OpenN (key1, 1), *str1_2 = ind1->OpenN (key1, 2);
						Stream *str2_0 = ind2->Open (key1), *str2_1 = ind2->OpenN (key1, 1), *str2_2 = ind2->OpenN (key1, 2);

						if (!str1_0 || !str2_0) {
							if (str1_0) ind1->Close (str1_0);
							if (str1_1) ind1->Close (str1_1);
							if (str1_2) ind1->Close (str1_2);

							if (str2_0) ind2->Close (str2_0);
							if (str2_1) ind2->Close (str2_1);
							if (str2_2) ind2->Close (str2_2);

							continue;
						}

						if (str1_0->Length () != str2_0->Length ()) {
							mpcxc_printfwin (strings, "\nLength of streams#0 for the key " );
							printValue (key1, keyId, NULL, strings);
							mpcxc_printfwin (strings, " in index %s mismatch\n", name );
							if (!strings) fflush(stdout);
						} else {
							if ((str1_1->Length () > 32) != (str2_1->Length () > 32)) {
								mpcxc_printfwin (strings, "\nLength of streams#1 for the key " );
								printValue (key1, keyId, NULL, strings);
								mpcxc_printfwin (strings, " in index %s mismatch\n", name );
								if (!strings) fflush(stdout);
							}

							DBCore::IDataStream_var pos_reader_1 = new DBExt::PositionsReader (str1_2, -1, DBExt::Def::dt_All, str1_1->Length () > 32, 0);
							DBCore::IRefStream_var str_reader_1 = new DBExt::StreamReader (str1_0, 0);

							DBCore::IDataStream_var pos_reader_2  = new DBExt::PositionsReader(str2_2, -1, DBExt::Def::dt_All, str2_1->Length () > 32, 0);
							DBCore::IRefStream_var str_reader_2 = new DBExt::StreamReader (str2_0, 0);

							DBCore::Ref_ ref_1 = {0,0,0}, ref_2 = {0,0,0};
							DBCore::ExtrPair extr;

							while (str_reader_1->get_next (ref_1, 0) && str_reader_2->get_next (ref_2, 0)) {
								long id_1 = ref_1.doc_id;
								long id_2 = ref_2.doc_id;

								if (id_1 != id_2) {
									mpcxc_printfwin (strings, "\nData for the key " );
									printValue (key1, keyId, NULL, strings);
									mpcxc_printfwin (strings, " in index %s mismatch\n", name );
									if (!strings) fflush(stdout);
									break;
								}

								ContextSearch::Defs::Positions positions_1;
								pos_reader_1->get (positions_1, ref_1, extr);

								ContextSearch::Defs::Positions positions_2;
								pos_reader_2->get (positions_2, ref_2, extr);

								if (positions_1 != positions_2) {
									mpcxc_printfwin (strings, "\nData for the key " );
									printValue (key1, keyId, NULL, strings);
									mpcxc_printfwin (strings, " in index %s mismatch\n", name );
									if (!strings) fflush(stdout);
									break;
								}
							}
						}

						ind1->Close (str1_0);
						ind1->Close (str1_1);
						ind1->Close (str1_2);

						ind2->Close (str2_0);
						ind2->Close (str2_1);
						ind2->Close (str2_2);
					}else if ( !strcmp( name, "NFContxt" )) {
						if ( len1 != len2 ) {
							mpcxc_printfwin (strings, "\nLength of data for the key " );
							printValue ( key1, keyId, NULL, strings );
							mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
							if (!strings) fflush(stdout);
						}						
					} else
					if ( !strcmp( name, "NewCorr" )) {
						if ( len1 != len2 ) {
							mpcxc_printfwin (strings, "\nLength of data for the key " );
							printValue ( key1, keyId, NULL, strings );
							mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
							if (!strings) fflush(stdout);
						} else {
							CorrRef* one = (CorrRef*) malloc( len1 );
							CorrRef* two = (CorrRef*) malloc( len2 );
							str1->Read(one,len1);
							str2->Read(two,len2);

							if ( memcmp( one,two,len1 )) {
								mpcxc_printfwin (strings, "\nData for the key " );
								printValue ( key1, keyId, NULL, strings );
								mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
								if (!strings) fflush(stdout);
							}
							free( one );
							free( two );
						}

					} else {
						if ( checkStreams ( str1, str2 ) ) {
							if (!strcmp (name, "KindCorr")) {
								mpcxc_printfwin (strings, "\nmismatch in streams for %ld.%ld\n", ((Ref*)key1)->DocId, ((Ref*)key2)->Sub);
							} else {
								mpcxc_printfwin (strings, "\nmismatch in streams0\n" );
							}
							if (!strings) fflush(stdout);
						}
					}
				}
			}
		} else {	// contains string sets		
			char *buf1 = (char*) malloc ( len1 );
			char *buf2 = (char*) malloc ( len2 );
			str1 -> Read ( buf1, len1 );
			str2 -> Read ( buf2, len2 );

			if (tag == IDD_DIV) {
				char* data = (char*) buf1;
				if (data [3] == 0) {
					long unpacked_size = *(long*) buf1;
					void gk_huge* unpacked_data = malloc (unpacked_size);
					G_UNZIP (data + sizeof (long), len1 - sizeof (long), unpacked_data, unpacked_size);
					gk_free (buf1);
					buf1 = (char*) unpacked_data;
					len1 = unpacked_size;
				}
				data = (char*) buf2;
				if (data [3] == 0) {
					long unpacked_size = *(long*) buf2;
					void gk_huge* unpacked_data = malloc (unpacked_size);
					G_UNZIP (data + sizeof (long), len2 - sizeof (long), unpacked_data, unpacked_size);
					gk_free (buf2);
					buf2 = (char*) unpacked_data;
					len2 = unpacked_size;
				}
			}

			switch ( tag ) {
#ifndef	VERSION61
			case IDD_NAME:
#endif
			case IDD_ID:
			case IDD_CHDATE_EXEX:
			case IDD_ADDCODE:
			case IDD_TERRITORY:
			case IDD_SOURCE:
			case IDD_DIV:
			case IDD_KEY:
			//case IDD_HANDMASK:
			//case IDD_HANDHANDMASK:
			case IDD_TYPE:
			case IDD_TAG:
			case IDD_CLASS6:
			case IDD_DOCKIND:
			case IDD_KIND:
			case IDD_RCODE:
			case IDD_WARNING:
			case IDD_CATEGORY:
			case IDD_PUBLISHEDIN:
			case IDD_SERVICEINFO:
#ifdef	VERSION62
			case IDD_PREANNOUSER:
			case IDD_PREANNOORGANIZATION:
			case IDD_PREANNOTAX:
			case IDD_PREANNOINTEREST:
			case IDD_PREANNOKIND:
			case IDD_ANNOUSER:
			case IDD_ANNOORGANIZATION:
			case IDD_ANNOTAX:
			case IDD_ANNOINTEREST:
			case IDD_ANNOKIND:
			case IDD_INPHARMFIRM:
			case IDD_INPHARMCOUNTRY:
			case IDD_TRADENAME:
			case IDD_INTNAME:
			case IDD_PHARMGROUP:
			case IDD_PHARMEFFECT:
			case IDD_CHAPTER:
			case IDD_ATC:
			case IDD_REGSTATUS:
			case IDD_LEKFORM:
			case IDD_MKB:
#endif				  
					if ( len1 != len2 ) {
						mpcxc_printfwin (strings, "\nLength of data for the key " );
						printValue ( key1, keyId, 0, strings );
						mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
						iError = true;
						fflush(stdout);
					} else
					if ( CheckStrSet ( buf1, buf2, len1 ) ) {
						mpcxc_printfwin (strings, "\nmismatch of data in index '%s', key ", name );
						printValue ( key1, keyId, 0, strings );
						DiffStrSet ( buf1, len1, buf2, len2, strings );
						fflush(stdout);
						iError = true;
						error_count++;
					}
					break;

			#ifdef	VERSION56
			  case IDD_ACTIVE:
				if ( len1 != len2 ) {
					mpcxc_printfwin (strings, "\nLength of data for the keys in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					error_count++;
					iError = true;
					fflush(stdout);
			    	}
				else if ( CheckActives( buf1, buf2, len1 )) {
					mpcxc_printfwin (strings, "\nmismatch of data in index '%s', key: IDD_ACTIVE, doc: %ld", name, ((AttrKey*)key1)->DocId );
					error_count++;
					iError = true;
					fflush(stdout);
				}
				break;
			#endif

			  case IDD_REGDATE:
			  case IDD_ANNULDATE:
			  case IDD_ACTIVEEX:
				if ( len1 != len2 ) {
					mpcxc_printfwin (strings, "\nLength of data for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					iError = true;
					fflush(stdout);
				} else
				if ( CheckDateRefSet ( buf1, buf2, len1) ) {
					mpcxc_printfwin (strings, "\nmismatch of data in index '%s', key ", name );
					printValue ( key1, keyId, 0, strings );
					printDateSet ( "First base:",  buf1, len1, strings );
					printDateSet ( "Second base:", buf2, len2, strings );
					iError = true;
					error_count++;
					fflush(stdout);
				}
				break;
			  
			  case IDD_CALIN:
			  case IDD_CALAB:
			  case IDD_CALCH:
			  case IDD_DATE:
			  case IDD_VCHANGED:
			  case IDD_RDATE:
			  case IDD_VINCLUDED:
			  case IDD_VABOLISHED:
			  case IDD_SORTDATE:
			  case IDD_VANONCED:
			  case IDD_VLCONTROL:
				if ( len1 != len2 ) {
					mpcxc_printfwin (strings, "\nLength of data for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					iError = true;
					fflush(stdout);
				} else
				if ( CheckDateSet ( buf1, buf2, len1 ) ) {
					mpcxc_printfwin ( "\nmismatch of data in index '%s', key ", name, strings );
					printValue ( key1, keyId, 0, strings );
					printDateSet ( "First base:",  buf1, len1, strings );
					printDateSet ( "Second base:", buf2, len2, strings );
					iError = true;
					error_count++;
					fflush(stdout);
				}
				break;

			  case IDD_SUBS:
				if ( len1 != len2 ) {
					mpcxc_printfwin (strings, "\nLength of data for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					iError = true;
					fflush(stdout);
				} else
				if ( CheckSubSet ( buf1, buf2, len1 ) ) {
					mpcxc_printfwin (strings, "\nmismatch of data in index '%s', key ", name );
					printValue ( key1, keyId, 0, strings );
					printSubSet ( "First base:",  buf1, len1, strings );
					printSubSet ( "Second base:", buf2, len2, strings );
					error_count++;
					iError = true;
					fflush(stdout);
				}
				break;

			  case IDD_INFO:
				if ( len1 != len2 ) {
					mpcxc_printfwin (strings, "\nLength of data for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					iError = true;
					fflush(stdout);
				} else if ( checkStreamsInfo ( buf1, buf2 ) ) {
					mpcxc_printfwin (strings, "\nmismatch of data in index '%s', key ", name );
					printValue ( key1, keyId, 0, strings );
					error_count++;
					iError = true;
					fflush(stdout);
				}
				break;

			  case IDD2_PARAIDS:
				  {
						long l1, l2;
						void *buf1 = b1->LoadAttrEx (( (AttrKey*) key1 ) -> DocId, tag, l1);
						void *buf2 = b2->LoadAttrEx (( (AttrKey*) key2 ) -> DocId, tag, l2);
						if (l1 != l2) {
							mpcxc_printfwin (strings, "\nLength of data for the key " );
							printValue ( key1, keyId, 0, strings );
							mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, l1, l2 );
							iError = true;
							fflush(stdout);
						} else if (memcmp (buf1, buf2, l1)) {
							mpcxc_printfwin (strings, "\nmismatch of data in index '%s', key ", name );
							printValue ( key1, keyId, 0, strings );
							error_count++;
							iError = true;
							fflush(stdout);
						}
						gk_free (buf1);
						gk_free (buf2);
				  }
				  break;			

			  case IDD_SUBS_EX:
			  case IDD_DOCSTRUCT:
			  case IDD_EVD:
				  {
						long l1, l2;
						void *buf1 = b1->LoadAttr (( (AttrKey*) key1 ) -> DocId, tag, l1);
						void *buf2 = b2->LoadAttr (( (AttrKey*) key2 ) -> DocId, tag, l2);
						if (l1 != l2) {
							mpcxc_printfwin (strings, "\nLength of data for the key " );
							printValue ( key1, keyId, 0, strings );
							mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, l1, l2 );
							iError = true;
							fflush(stdout);
						} else if (memcmp (buf1, buf2, l1)) {
							mpcxc_printfwin (strings, "\nmismatch of data in index '%s', key ", name );
							printValue ( key1, keyId, 0, strings );
							error_count++;
							iError = true;
							fflush(stdout);
						}
						gk_free (buf1);
						gk_free (buf2);
				  }
				  break;			

			  default:
				if ( len1 != len2 ) {
					mpcxc_printfwin (strings, "\nLength of data for the key " );
					printValue ( key1, keyId, 0, strings );
					mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
					iError = true;
					fflush(stdout);
				/*
				if(KV_NCONTXT == keyId){
					ParaCollection col1, col2;
					str1->Seek(0);
					str2->Seek(0);
					col1.Get(str1);
					col2.Get(str2);
					long ii= 0, jj= 0;
					do{
						Ref Ref1= col1.GetItem(ii);
						Ref Ref2= col2.GetItem(jj);
						if(Ref1.DocId != Ref2.DocId || Ref1.Sub != Ref2.Sub){
							mpcxc_printfwin ( "Ref(%d) %d.%d.%d != %d.%d.%d ", jj, Ref1.DocId,
										Ref1.Sub >> 15,  Ref1.Sub & 0x3fff,Ref2.DocId,
										Ref2.Sub >> 15,  Ref2.Sub & 0x3fff);
							fflush(stdout);
							break;
						}
						ii++;
						jj++;
					}while(1);
				}
				*/
				} else
				if ( memcmp ( buf1, buf2, len1 ) ) {
					mpcxc_printfwin (strings, "\nmismatch of data in index '%s', key ", name );
					printValue ( key1, keyId, 0, strings );
					error_count++;
					iError = true;
					fflush(stdout);
				}
			}
			free ( buf1 );
			free ( buf2 );
		}
		it1.CloseStream(str1);
		it2.CloseStream(str2);

////////////////////    second

		if ( second ) {
			OPEN_STREAM ( 1,1 );
			OPEN_STREAM ( 2,1 );

			int len1 = str1 -> Length ( );
			int len2 = str2 -> Length ( );

			if ( len1 != len2 ) {
				mpcxc_printfwin (strings, "\n(second stream) Length of data for the key " );
				printValue ( key1, keyId, 0, strings );
				mpcxc_printfwin (strings, " in index %s mismatch (%ld, %ld)\n", name, len1, len2 );
				iError = true;
				error_count++;
				fflush(stdout);
			} else {
				if ( keyId == KV_BLOB ) {
					if ( checkStreams ( str1, str2) ) {
						ERROR_MPCXC;
						iError = true;
					}
				}
			}

			ind1 -> Close ( str1 );
			ind2 -> Close ( str2 );
		}

		++it1;
		++it2;
	}
	return error_count;
}

//////// check hierarhial indexes //////////

AttrKey* getNextInfoKey ( BTIterator &it, int m )
{
	while(1){
		++it;
		if(it.End())
			break;
		if (	( ((AttrKey*) it.Key()) -> AttrTag == IDD_INFO )
				&& ( ((AttrKey*) it.Key ( )) -> DocId >= m ) )
		{
			return (AttrKey*) it.Key();
		}
	}
	return 0;
}

int compare_texts_n ( YBase *b1, YBase *b2, char* name1, char* name2, int threads_count);

int checkText ( const Base *b1, const Base *b2, bool &tError )
{
	Index *ind1 = ((Base*)b1) -> FindIndex ( "Attrs" );
	Index *ind2 = ((Base*)b2) -> FindIndex ( "Attrs" );

	if ( ( !ind1 ) || ( !ind2 ) ) {
		tError = true;
		mpcxc_printfwin ( "Error creating index for 'Attrs'\n" );
		return 1;
	}

	BTIterator it1 ( ind1 );
	BTIterator it2 ( ind2 );
	Stream *str1;
	Stream *str2;
	AttrKey *key1;
	AttrKey *key2;

	while ( 1 )	{
		key1 = getNextInfoKey ( it1, 1 );
		key2 = getNextInfoKey ( it2, 1 );

begin:
		if ( !key1 && !key2 )
			break;

		if ( !key1 || !key2 ) {
			mpcxc_printfwin ( "Unexpected end of index\n" );
			tError = true;
			fflush(stdout);
			return 0;
		}

		//mpcxc_printfwin( "%ld\r", key1 -> DocId );

		if ( key1 -> DocId != key2 -> DocId ) {
		    while ( key1 -> DocId < key2 -> DocId ) {
				mpcxc_printfwin ( "No document %ld in base 2\n", key1 -> DocId );
				tError = true;
				fflush(stdout);
				key1 = getNextInfoKey ( it1, 1 );
				if ( !key1 )
					break;
		    }
			if ( !key1 )
				goto begin;
		    while ( key2 -> DocId < key1 -> DocId ) {
				mpcxc_printfwin ( "No document %ld in base 1\n", key2 -> DocId );
				tError = true;
				fflush(stdout);
				key2 = getNextInfoKey ( it2, 1 );
				if ( !key2 )
					break;
		    }
		    goto begin;
		}

		str1 = ind1 -> Open ( key1 );
		str2 = ind2 -> Open ( key2 );

		if ( !str1 )
		{
			mpcxc_printfwin ( "No data in index 'Attrs' for the key (%ld,IDD_INFO) in base 1\n", ((AttrKey *)key1)->DocId);
			tError = true;
			fflush(stdout);
			continue;
		}

		if ( !str2 )
		{
			mpcxc_printfwin ( "No data in index 'Attrs' for the key (%ld,IDD_INFO) in base 2\n", ((AttrKey *)key2)->DocId);
			tError = true;
			fflush(stdout);
			ind1->Close(str1);
			continue;
		}
/////////

		//printf ("%ld ", ((AttrKey *)key2)->DocId); fflush(stdout);

		DocInfo doc1;
		DocInfo doc2;
		Document* docum1;
		Document* docum2;
		char *para1, *para2;
		int i;

		str1 -> Read ( &doc1, sizeof (DocInfo) ); ind1 -> Close ( str1 );
		str2 -> Read ( &doc2, sizeof (DocInfo) ); ind2 -> Close ( str2 );

		//printf ("%ld\n", key1->DocId); fflush (stdout);

		if ( doc1.ParaCount != doc2.ParaCount ) {
			mpcxc_printfwin ( "Number of paragraphs for DocId %ld differ\n", key1 -> DocId );
			tError = true;
			fflush(stdout);
			continue;
		}

		docum1 = new Document ( (Base*) b1, key1 -> DocId );
		if ( !docum1 ) {
			mpcxc_printfwin("Document with Id %ld not found in base1\n", key1->DocId);
			tError = true;
			fflush(stdout);
			continue;
		}

		docum2 = new Document ( (Base*) b2, key2 -> DocId );
		if ( !docum2 ) {
			mpcxc_printfwin("Document with Id %ld not found in base2\n", key2->DocId);
			tError = true;
			fflush(stdout);
			delete docum1;
			continue;
		}

		for ( i = 0; i < doc1.ParaCount; i++ ) {
			para1 = docum1 -> GetPara ( i );
			para2 = docum2 -> GetPara ( i );

			int paralen1 = ParaSize ( para1 );
			int paralen2 = ParaSize ( para2 );

			if ( ( paralen1 != paralen2 ) || ( memcmp ( para1, para2, paralen1 ) ) ) {
				if ( ( doc1.Status & DS_EVD ) && ( doc2.Status & DS_EVD )) {
					int	  len11 = docum1->EVDTextSize( para1 );
					int	  len22 = docum1->EVDTextSize( para1 );
					if	(0 == len11 + len22)
						continue;

					if ( len11 == len22 ) {
						unsigned char* para11 = (unsigned char*)docum1->EVDParaText( para1 );
						unsigned char* para22 = (unsigned char*)docum2->EVDParaText( para1 );
						if ( memcmp( para11, para22, len11 )) {
							mpcxc_printfwin ( "Documents %d mismatch, para %ld\n", key1 -> DocId, i );
							fflush(stdout);
							break;
						} else {
							bool len1 = false;
							if ( abs (paralen1 - paralen2) == 1) {
								len1 = true;
								int len = std::min(TextSize (para1), TextSize (para2));
								para1 = ParaText (para1);
								para2 = ParaText (para2);
								if ( memcmp (para1, para2, len)) {
									mpcxc_printfwin ( "Documents %d mismatch, para %ld\n", key1 -> DocId, i );
									fflush(stdout);
									break;
								}
							}

							bool fatalErrors = false;
							bool spaces = false;
							for ( int ii = 0; ii < len11 && !fatalErrors; ii++ )
								if ( para11[ii] != para22[ii] )
									if ( para11[ii] != 32 && para11[ii] != 255 && para22[ii] != 32 && para22[ii] != 255 )
										fatalErrors = true;
									else
										spaces = true;

							if ( fatalErrors ) {
								mpcxc_printfwin ( "Documents %d mismatch\n", key1 -> DocId );
								tError = true;
								fflush(stdout);
								break;
							} else {
								if ( spaces )
									mpcxc_printfwin( "Documents %d: warning in para %ld - unbreakable space\n", key1->DocId, i );
								else if (!len1) {
									tError = true;
									mpcxc_printfwin( "Documents %d: warning in para %ld - different evd\n", key1->DocId, i );
								}

								fflush(stdout);
							}
						}
					} else {
						mpcxc_printfwin ( "Documents %d mismatch, para %ld\n", key1 -> DocId, i );
						tError = true;
						fflush(stdout);
						break;
					}
				} else {
					mpcxc_printfwin ( "Documents %d mismatch, para %ld\n", key1 -> DocId, i);
					tError = true;
					fflush(stdout);
					break;
				}
			}
		}
		delete docum1;
		delete docum2;
	}

	return 0;
}

void baseInfoCmp ( BaseInfo& bi1, BaseInfo& bi2, std::vector<std::string> *strings = 0)
{
	if ( bi1.BaseId != bi2.BaseId ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: BaseId (%d != %d )\n", bi1.BaseId, bi1.BaseId, bi2.BaseId );

	if ( strcmp ( bi1.Name, bi2.Name ) ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: Name (%s != %s )\n", bi1.BaseId, bi1.Name, bi2.Name );

	if ( strcmp ( bi1.NameEng, bi2.NameEng ) ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: NameEng (%s != %s )\n", bi1.BaseId, bi1.NameEng, bi2.NameEng );

	if ( strcmp ( bi1.AuthorName , bi2.AuthorName  ) ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: AuthorName  (%s != %s )\n", bi1.BaseId, bi1.AuthorName , bi2.AuthorName  );
	
	if ( bi1.RecCount != bi2.RecCount ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: RecCount (%ld != %ld )\n", bi1.BaseId, bi1.RecCount, bi2.RecCount );

	if ( bi1.RecSize != bi2.RecSize ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: RecSize (%ld != %ld )\n", bi1.BaseId, bi1.RecSize, bi2.RecSize );

	if ( bi1.DocSize != bi2.DocSize ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: DocSize (%ld != %ld )\n", bi1.BaseId, bi1.DocSize, bi2.DocSize );

	if ( bi1.FormsCount != bi2.FormsCount ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: FormsCount (%ld != %ld )\n", bi1.BaseId, bi1.FormsCount, bi2.FormsCount );
	
	if ( bi1.GreenComments != bi2.GreenComments ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: GreenComments (%ld != %ld )\n", bi1.BaseId, bi1.GreenComments, bi2.GreenComments );
	
	if ( bi1.HyperRefs != bi2.HyperRefs ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: HyperRefs (%ld != %ld )\n", bi1.BaseId, bi1.HyperRefs, bi2.HyperRefs );
		
	if ( CompRevs ( &bi1.LastUpdate, &bi2.LastUpdate ) ) {
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: LastUpdate (", bi1.BaseId );
		printRev ( &bi1.LastUpdate );
		mpcxc_printfwin ( " != " );
		printRev ( &bi2.LastUpdate );
		mpcxc_printfwin ( "\n" );
	}
	
	if ( bi1.SplashTopic != bi2.SplashTopic ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: SplashTopic (%ld != %ld )\n", bi1.BaseId, bi1.SplashTopic, bi2.SplashTopic );
	
	if ( bi1.BannerTopic != bi2.BannerTopic ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: BannerTopic (%ld != %ld )\n", bi1.BaseId, bi1.BannerTopic, bi2.BannerTopic );
	
	if ( bi1.Weight != bi2.Weight ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: Weight (%d != %d )\n", bi1.BaseId, bi1.Weight, bi2.Weight );
	
	if ( bi1.UserName != bi2.UserName ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: UserName (%d != %d )\n", bi1.BaseId, bi1.UserName, bi2.UserName );
	
	if ( bi1.CommonDocCount != bi2.CommonDocCount ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: CommonDocCount (%ld != %ld )\n", bi1.BaseId, bi1.CommonDocCount, bi2.CommonDocCount );
	
	if ( bi1.CommonDocSize != bi2.CommonDocSize ) 
		mpcxc_printfwin ( "BaseInfo (%d) mismatch: CommonDocSize (%ld != %ld )\n", bi1.BaseId, bi1.CommonDocSize, bi2.CommonDocSize );

}

void checkBaseInfo ( YBase* b1, YBase* b2, std::vector<std::string> *strings = 0)
{
	bool local_fatalError = false;

	std::set<std::string> processed_keys;
	mpcxc_printfwin (strings, "Index name: Aux (f)...");
	BaseInfoMap bim1 (b1);
	BaseInfoMap bim2 (b2);

	Point p;
	for ( p = bim1.first(); p; bim1.next(p) ) {
		Point p2;
		if ( p2 = bim2.seek ( bim1.key(p) ) )
			baseInfoCmp ( bim1.contents(p), bim2.contents(p2), strings );
		else {
			mpcxc_printfwin (strings, "BaseInfo for %d seg, exist in base1 but not in base2\n", bim1.key(p));
		}
	}

	for ( p = bim2.first(); p; bim2.next(p) )
		if ( !bim1.contains ( bim2.key(p) ) )
			mpcxc_printfwin (strings, "BaseInfo for %d seg, exist in base1 but not in base2\n", bim2.key(p));

	Index *idx1 = b1->FindIndex ("Aux");
	if ( !idx1 ) mpcxc_printfwin (strings, "No Aux Index in base1 ?!\n"); // GARANT_GCC: trigraph warning

	Index *idx2 = b2->FindIndex ("Aux");
	if ( !idx2 ) mpcxc_printfwin (strings, "No Aux Index in base2 ?!\n");

	static const char *IndexNames[] = {PR_ALL, PR_DOCS, PR_COMMENTS, PR_FORMS, PR_PROJECTS, PR_PRACTICE, PR_INTERS, PR_QUES, PR_BREF, AUX_SERV, "Clas", "Spla", AUX_SYN_EXAMPLE, AUX_SYN_CODEXES, AUX_SYN_TYPES, AUX_SYN_ADOPTED, AUX_BELONGS, AUX_RELEF_LAWS, AUX_RELE_IZM, AUX_TYPING_ERRORS, AUX_ERRORS_GOODWORDS, AUX_ANNO_UIDS, AUX_KIND_UIDS, AUX_CLASS6_KEYS, AUX_SIMPLE_SYNS, AUX_EXCLUDE_WORDS, AUX_EXCLUDE_WORDS_3, AUX_EXCLUDE_WORDS_8 };

	unsigned int i;
	for (i = 0; i < sizeof ( IndexNames ) / sizeof ( IndexNames [0] ); i++ ) {
		processed_keys.insert (IndexNames [i]);
		Stream *str1 = idx1 -> Open (IndexNames [i]);
		Stream *str2 = idx2 -> Open (IndexNames [i]);

		if ((!str1) && (!str2)) ;
		else if (((!str1) && str2) || (str1 && (!str2))) mpcxc_printfwin(strings, "mismatch %s in Aux index\n", IndexNames [i]);
		else {
			if (!strcmp (IndexNames [i], AUX_CLASS6_KEYS) && (str1->Length() == str2->Length())) {
				long len = str1->Length ();
				char *buf1 = (char*) malloc ( len );
				char *buf2 = (char*) malloc ( len );
				str1 -> Read ( buf1, len );
				str2 -> Read ( buf2, len );
				if (CheckStrSet (buf1, buf2, len, strings)) {
					mpcxc_printfwin (strings, "mismatch %s in Aux index\n", IndexNames [i]);
				}
				gk_free (buf1);
				gk_free (buf2);
			} else {
				if ( checkStreams ( str1, str2 ) ) mpcxc_printfwin (strings, "mismatch %s in Aux index\n", IndexNames [i]);
			}
		}

		if (str2) idx2->Close(str2);
		if (str1) idx1->Close(str1);
	}

	Stream* str = idx1->Open ("Here");
	processed_keys.insert ("Here");
	std::set<short> segs;
	if (str) {
		for (int i = 0; i < str->Length () / 2; i++) {
			short seg;
			str->Read (&seg, sizeof (seg));
			segs.insert (seg);
		}
		idx1->Close (str);
	}
	
	for (i = 1; i < 400; i++) {
		if (segs.find (i) == segs.end ())
			continue;
		char name [5];
		sprintf (name, "-%03d", i);
		Stream *str1 = idx1 -> Open (name);
		Stream *str2 = idx2 -> Open (name);
		processed_keys.insert (name);

		if (!str1 && !str2)
			;
		else if ((!str1 && str2) || (str1 && !str2))  {
			mpcxc_printfwin (strings, "mismatch %s in Aux index\n", name);
			local_fatalError = true;
		}
		else if ( checkStreams ( str1, str2 ) ) {
			mpcxc_printfwin (strings, "mismatch %s in Aux index\n", name);
			local_fatalError = true;
		}

		if (str2) idx2->Close(str2);
		if (str1) idx1->Close(str1);
	}

	for (i = 1; i < 400; i++) {
		if (segs.find (i) == segs.end ())
			continue;
		char name [5];
		sprintf (name, "|%03d", i);
		Stream *str1 = idx1 -> Open (name);
		Stream *str2 = idx2 -> Open (name);
		processed_keys.insert (name);

		if (!str1 && !str2)
			;
		else if ((!str1 && str2) || (str1 && !str2)) {
			mpcxc_printfwin (strings, "mismatch %s in Aux index\n", name);
			local_fatalError = true;
		}
		else if ( checkStreams ( str1, str2 ) ) {
			mpcxc_printfwin (strings, "mismatch %s in Aux index\n", name);
			local_fatalError = true;
		}

		if (str2) idx2->Close(str2);
		if (str1) idx1->Close(str1);
	}

	{
		Stream *str1 = idx1->Open (AUX_RELEVANCY_CALCULATED_CHANGES);
		Stream *str2 = idx2->Open (AUX_RELEVANCY_CALCULATED_CHANGES);
		if (str1 && str2) {
			long count1, count2;
			str1->Read (&count1, sizeof (count1));
			str2->Read (&count2, sizeof (count2));
			if (count1 == count2) for (int i = 0; i < count1; i++) {
				int rele1, rele2;
				str1->Read (&rele1, sizeof (rele1));
				str2->Read (&rele2, sizeof (rele2));
				long docs_count1, packed_size1, docs_count2, packed_size2;
				str1->Read (&docs_count1, sizeof (docs_count1));
				str2->Read (&docs_count2, sizeof (docs_count2));
				str1->Read (&packed_size1, sizeof (packed_size1));
				str2->Read (&packed_size2, sizeof (packed_size2));
				long *docs1 = new long [docs_count1], *ptr1 = docs1;
				long *docs2 = new long [docs_count2], *ptr2 = docs2;
				if (packed_size1) {
					char* packed_data1 = new char [packed_size1];
					str1->Read (packed_data1, packed_size1);
					G_UNZIP (packed_data1, packed_size1, (char*) docs1, docs_count1 * sizeof (long));
					delete [] packed_data1;
				} else {
					str1->Read (docs1, docs_count1 * sizeof (long));
				}
				if (packed_size2) {
					char* packed_data2 = new char [packed_size2];
					str2->Read (packed_data2, packed_size2);
					G_UNZIP (packed_data2, packed_size2, (char*) docs2, docs_count2 * sizeof (long));
					delete [] packed_data2;
				} else {
					str2->Read (docs2, docs_count2 * sizeof (long));
				}
				if (docs_count1 == docs_count2 && !memcmp (docs1, docs2, docs_count1 * sizeof (long)) && rele1 == rele2) {
					//all ok
				} else {
					mpcxc_printfwin (strings, "mismatch data for %s in Aux index\n", AUX_RELEVANCY_CALCULATED_CHANGES);
				}
				delete [] docs1;
				delete [] docs2;
			} else {
				mpcxc_printfwin (strings, "mismatch %s.count in Aux index\n", AUX_RELEVANCY_CALCULATED_CHANGES);
				local_fatalError = true;
			}
		} else {
			if (str1 || str2) {
				mpcxc_printfwin (strings, "mismatch %s in Aux index\n", AUX_RELEVANCY_CALCULATED_CHANGES);
				local_fatalError = true;
			}
		}
		if (str1) idx1->Close (str1);
		if (str2) idx2->Close (str2);

		processed_keys.insert (AUX_RELEVANCY_CALCULATED_CHANGES);
	}

	{
		Stream *str1 = idx1->Open (AUX_INDEXES_SYNS);
		Stream *str2 = idx2->Open (AUX_INDEXES_SYNS);
		if (str1 && str2) {
			std::map<std::string, std::vector<std::string> > old_values, new_values;

			long length1 = str1->Length ();
			char *data1 = new char [length1], *ptr1 = data1;
			str1->Read (data1, length1);

			long length2 = str2->Length ();
			char *data2 = new char [length2], *ptr2 = data2;
			str2->Read (data2, length2);

			std::vector<std::string> *old_values_ptr;
			while (ptr1 - data1 < length1) {
				if (*ptr1 == '[') {
					old_values.insert (std::map<std::string, std::vector<std::string> >::value_type (ptr1, std::vector<std::string> ()));
					old_values_ptr = &old_values.find (ptr1)->second;
					ptr1 += strlen (ptr1) + 1;
				} else if (*ptr1) {
					old_values_ptr->push_back (ptr1);
					ptr1 += strlen (ptr1) + 1;
				} else {
					ptr1++;
				}
			}
			delete []data1;

			std::vector<std::string> *new_values_ptr;
			while (ptr2 - data2 < length2) {
				if (*ptr2 == '[') {
					new_values.insert (std::map<std::string, std::vector<std::string> >::value_type (ptr2, std::vector<std::string> ()));
					new_values_ptr = &new_values.find (ptr2)->second;
					ptr2 += strlen (ptr2) + 1;
				} else if (*ptr2) {
					new_values_ptr->push_back (ptr2);
					ptr2 += strlen (ptr2) + 1;
				} else {
					ptr2++;
				}
			}
			delete []data2;

			if (new_values != old_values)
				mpcxc_printfwin (strings, "mismatch data for %s in Aux index\n", AUX_INDEXES_SYNS);
		} else {
			if (str1 || str2) {
				mpcxc_printfwin (strings, "mismatch %s in Aux index\n", AUX_INDEXES_SYNS);
				local_fatalError = true;
			}
		}
		if (str1) idx1->Close (str1);
		if (str2) idx2->Close (str2);
		processed_keys.insert (AUX_INDEXES_SYNS);
	}

	processed_keys.insert (AUX_FILTERED_ADOPTED);
	processed_keys.insert (AUX_FILTERED_CLASS);
	processed_keys.insert (AUX_FILTERED_PREFIX);
	processed_keys.insert (AUX_FILTERED_PUBLISHED);
	processed_keys.insert (AUX_FILTERED_PUBLISHED_JU);
	processed_keys.insert (AUX_FILTERED_PUBLISHED_HR);
	processed_keys.insert (AUX_FILTERED_PUBLISHED_BO);
	processed_keys.insert (AUX_FILTERED_PUBLISHED_PH);
	processed_keys.insert (AUX_SYN_MORPHO);
	processed_keys.insert ("Base");
	processed_keys.insert (AUX_MORPHO_HASHES);
	processed_keys.insert ("sort");
	processed_keys.insert (AUX_COUNTRY_FIRMS);
	processed_keys.insert (AUX_O_POSITIONS);
	processed_keys.insert (AUX_INFO);
	processed_keys.insert ("Inf7");

	BTIterator it (idx1);
	for (; !it.End (); ++it) {
		char* key = (char*) it.Key ();
		if (key [0] == '-' || key [0] == '|')
			continue;
		if (key [0] == 'c' && key [1] == '6')
			continue;
		if (processed_keys.find (key) == processed_keys.end ()) {
			Stream *str1 = idx1 -> Open (key);
			Stream *str2 = idx2 -> Open (key);
			if (!str1 && !str2)
				;
			else if ((!str1 && str2) || (str1 && !str2))  {
				mpcxc_printfwin (strings, "mismatch %s in Aux index\n", key);
				local_fatalError = true;
			}
			else if ( checkStreams ( str1, str2 ) ) {
				mpcxc_printfwin (strings, "mismatch %s in Aux index\n", key);
				local_fatalError = true;
			}

			if (str2) idx2->Close(str2);
			if (str1) idx1->Close(str1);			
		}
	}

	mpcxc_printfwin (strings, local_fatalError ? "not ok" : "ok!\n");
	fatalError |= local_fatalError;
}

int DocInfoCmp (DocInfo *a, DocInfo *b)
{
	int res = strcmp ( a->Title, b->Title );
	if ( !res )
		res = CompDates( &a->Revision.RevisionDate, &b->Revision.RevisionDate );
	if ( !res )
		res = CompDates( &a->FirstDate, &b->FirstDate );
	if ( !res )
		res = CompDates( &a->LastDate, &b->LastDate );
	if ( !res )
		res = !( a->Force == b->Force
			&& a->HyperRefs == b->HyperRefs
			&& a->GreenComments == b->GreenComments
			&& a->Status == b->Status
			&& a->Status_ex == b->Status_ex
			&& a->Related == b->Related 
			&& a->prevEdition == b->prevEdition
			&& a->nextEdition == b->nextEdition
			&& a->Status_exex_part1 == b->Status_exex_part1
			&& a->Status_exex_part2 == b->Status_exex_part2
			&& a->reserved_short == b->reserved_short
			&& a->reserved_short2== b->reserved_short2
			&& a->long_respondents == b->long_respondents
			&& a->hi_long_respondents == b->hi_long_respondents
			&& a->lastParaID == b->lastParaID
			&& a->ParaCount == b->ParaCount
		);

	return res;
}

void	compare_attrs (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->run = 1;
	thread_data_ptr->error = false;
	long from_id = thread_data_ptr->from_id, to_id = thread_data_ptr->to_id;

	YBase *base1 = thread_data_ptr->base1, *base2 = thread_data_ptr->base2;

	if (base1->bases_ptrs.size () > 1 || base2->bases_ptrs.size () > 1 ) {
		std::deque<long>::const_iterator from_it = std::find (new_docs.begin (), new_docs.end (), from_id);
		std::deque<long>::const_iterator to_it = std::find (new_docs.begin (), new_docs.end (), to_id);
		if (++to_it != new_docs.end ()) to_it--;
		for (std::deque<long>::const_iterator doc_it = from_it; doc_it != to_it; doc_it++) {
			long id = *doc_it;

			Base* base1_ptr = base1->base_for_doc (id);
			Base* base2_ptr = base2->base_for_doc (id);
			for (short tag = IDD_NONE; tag <= IDD_TAG; tag++) {
				if (tag == IDD_RUNS || tag == IDD_BLOCKS || tag == IDD_SOURCEFILE)
					continue;

				AttrKey key = {id, tag};

				Stream* str1 = base1_ptr->FindIndex ("Attrs")->OpenN (&key, 0);
				Stream* str2 = base2_ptr->FindIndex ("Attrs")->OpenN (&key, 0);
				bool chg = false;

				if (str1 && str2) {
					int length1 = str1->Length (), length2 = str2->Length ();

					if (length1 != length2 && tag != IDD_DIV) {
						chg = true;
					} else {
						char *buf1 = (char*) malloc (length1), *buf2 = (char*) malloc (length2);
						str1->Read (buf1, length1);
						str2->Read (buf2, length2);
						switch (tag) {
							case IDD_DIV:
								{
								char* data = (char*) buf1;
								if (data [3] == 0) {
									long unpacked_size = *(long*) buf1;
									void gk_huge* unpacked_data = malloc (unpacked_size);
									G_UNZIP (data + sizeof (long), length1 - sizeof (long), unpacked_data, unpacked_size);
									gk_free (buf1);
									buf1 = (char*) unpacked_data;
									length1 = unpacked_size;
								}
								data = (char*) buf2;
								if (data [3] == 0) {
									long unpacked_size = *(long*) buf2;
									void gk_huge* unpacked_data = malloc (unpacked_size);
									G_UNZIP (data + sizeof (long), length2 - sizeof (long), unpacked_data, unpacked_size);
									gk_free (buf2);
									buf2 = (char*) unpacked_data;
									length2 = unpacked_size;
								}
								}
							case IDD_ID:
							case IDD_CHDATE_EXEX:
							case IDD_ADDCODE:
							case IDD_TERRITORY:
							case IDD_SOURCE:
							case IDD_KEY:
							case IDD_TYPE:
							case IDD_TAG:
							case IDD_KIND:
							case IDD_SERVICEINFO:
							case IDD_DOCKIND:
							case IDD_RCODE:
							case IDD_WARNING:
							case IDD_CATEGORY:
							case IDD_PUBLISHEDIN:
							case IDD_PREANNOUSER:
							case IDD_PREANNOORGANIZATION:
							case IDD_PREANNOTAX:
							case IDD_PREANNOINTEREST:
							case IDD_PREANNOKIND:
							case IDD_ANNOUSER:
							case IDD_ANNOORGANIZATION:
							case IDD_ANNOTAX:
							case IDD_ANNOINTEREST:
							case IDD_ANNOKIND:
							case IDD_CLASS6:
							case IDD_INPHARMFIRM:
							case IDD_INPHARMCOUNTRY:
							case IDD_TRADENAME:
							case IDD_INTNAME:
							case IDD_PHARMGROUP:
							case IDD_PHARMEFFECT:
							case IDD_CHAPTER:
							case IDD_ATC:
							case IDD_REGSTATUS:
							case IDD_LEKFORM:
							case IDD_MKB:
							case IDD_CASECODE:
								if (length1 == length2)
									chg = CheckStrSet (buf1, buf2, length1);
								else
									chg = true;
								break;

							case IDD_REGDATE:
							case IDD_ANNULDATE:
							case IDD_ACTIVEEX:
								chg = CheckDateRefSet (buf1, buf2, length1);
								break;

							case IDD_DATE:
							case IDD_VCHANGED:
							case IDD_RDATE:
							case IDD_VINCLUDED:
							case IDD_VABOLISHED:
							case IDD_SORTDATE:
							case IDD_VANONCED:
							case IDD_VLCONTROL:
							case IDD_ANNODATE:
							case IDD_PREANNODATE:
							case IDD_CHDATE:
							case IDD_PROFDATE:
								chg = CheckDateSet (buf1, buf2, length1);
								break;

							case IDD_SUBS:
								chg = CheckSubSet (buf1, buf2, length1);
								break;

							case IDD_INFO:
								chg = DocInfoCmp ((DocInfo*) buf1, (DocInfo*) buf2);
								break;

							default:
								chg = memcmp (buf1, buf2, length1);
								break;
						}

						if (chg) {
							mpcxc_printfwin ( "\nmismatch of data for %ld.", id);
							printAttrTag (tag);
						}
						free (buf1);
						free (buf2);
					}
				} else if (str1 || str2) {
					chg = true;
					mpcxc_printfwin ("\nNo key %ld.", id);
					printAttrTag (tag);
					mpcxc_printfwin (str1 ? " in base 2" : " in base1");
				}
				if (chg) thread_data_ptr->error = true;
				if (str1) base1_ptr->FindIndex ("Attrs")->Close (str1);
				if (str2) base2_ptr->FindIndex ("Attrs")->Close (str2);
			}
		}
		thread_data_ptr->done = 1;
		return ;
	}

	AttrIndex* attrs1 = (AttrIndex*) base1->FindIndex ("Attrs");
	AttrIndex* attrs2 = (AttrIndex*) base2->FindIndex ("Attrs");

	BTIterator oldit (attrs1);
	BTIterator newit (attrs2);

	AttrKey oldkey; oldkey.DocId = ID_BORDER; oldkey.AttrTag = IDD_DATE; oldit.Set (&oldkey);
	AttrKey newkey; newkey.DocId = ID_BORDER; newkey.AttrTag = IDD_DATE; newit.Set (&newkey);

	while (!oldit.End() && !newit.End()) {
		oldkey = *(AttrKey*) oldit.Key();
		long oldtag = oldkey.AttrTag, oldId = oldkey.DocId;
		if (oldtag == IDD_RUNS || oldtag == IDD_BLOCKS || oldtag == IDD_SOURCEFILE || oldId < from_id || oldId > to_id) {
			oldit.next();
			continue;
		}

		newkey = *(AttrKey*) newit.Key();
		long newtag = newkey.AttrTag, newId = newkey.DocId;
		if (newtag == IDD_RUNS || newtag == IDD_BLOCKS || newtag == IDD_SOURCEFILE || newId < from_id || newId > to_id) {
			newit.next();
			continue;
		}

		bool chg = false;
		if (oldtag == newtag) {
			if (oldId < newId) {
				chg = true;
				mpcxc_printfwin ("\nNo key %ld.", oldId);
				printAttrTag (oldtag);
				mpcxc_printfwin (" in base 2");
				oldit.next();
			} else if (oldId == newId) {
				Stream* oldstr = attrs1->OpenN (&oldkey, 0);
				Stream* newstr = attrs2->OpenN (&newkey, 0);

				int oldlength = oldstr->Length ();
				int newlength = newstr->Length ();

				if (oldlength != newlength && oldtag != IDD_DIV) {
					chg = true;
				} else {
					char *oldbuf = (char*) malloc (oldlength);
					char *newbuf = (char*) malloc (newlength);
					oldstr->Read (oldbuf, oldlength);
					newstr->Read (newbuf, newlength);
					switch ( oldtag ) {
						case IDD_DIV:
							{
							char* data = (char*) oldbuf;
							if (data [3] == 0) {
								long unpacked_size = *(long*) oldbuf;
								void gk_huge* unpacked_data = malloc (unpacked_size);
								G_UNZIP (data + sizeof (long), oldlength - sizeof (long), unpacked_data, unpacked_size);
								gk_free (oldbuf);
								oldbuf = (char*) unpacked_data;
								oldlength = unpacked_size;
							}
							data = (char*) newbuf;
							if (data [3] == 0) {
								long unpacked_size = *(long*) newbuf;
								void gk_huge* unpacked_data = malloc (unpacked_size);
								G_UNZIP (data + sizeof (long), newlength - sizeof (long), unpacked_data, unpacked_size);
								gk_free (newbuf);
								newbuf = (char*) unpacked_data;
								newlength = unpacked_size;
							}
							}
						case IDD_ID:
						case IDD_CHDATE_EXEX:
						case IDD_ADDCODE:
						case IDD_TERRITORY:
						case IDD_SOURCE:
						case IDD_KEY:
						case IDD_TYPE:
						case IDD_TAG:
						case IDD_KIND:
						case IDD_SERVICEINFO:
						case IDD_DOCKIND:
						case IDD_RCODE:
						case IDD_WARNING:
						case IDD_CATEGORY:
						case IDD_PUBLISHEDIN:
						case IDD_PREANNOUSER:
						case IDD_PREANNOORGANIZATION:
						case IDD_PREANNOTAX:
						case IDD_PREANNOINTEREST:
						case IDD_PREANNOKIND:
						case IDD_ANNOUSER:
						case IDD_ANNOORGANIZATION:
						case IDD_ANNOTAX:
						case IDD_ANNOINTEREST:
						case IDD_ANNOKIND:
						case IDD_CLASS6:
						case IDD_INPHARMFIRM:
						case IDD_INPHARMCOUNTRY:
						case IDD_TRADENAME:
						case IDD_INTNAME:
						case IDD_PHARMGROUP:
						case IDD_PHARMEFFECT:
						case IDD_CHAPTER:
						case IDD_ATC:
						case IDD_REGSTATUS:
						case IDD_LEKFORM:
						case IDD_MKB:
						case IDD_CASECODE:
							if (oldlength == newlength)
								chg = CheckStrSet( oldbuf, newbuf, oldlength );
							else
								chg = 1;
							break;

						case IDD_DATE:
						case IDD_VCHANGED:
						case IDD_RDATE:
						case IDD_VINCLUDED:
						case IDD_VABOLISHED:
						case IDD_SORTDATE:
						case IDD_VANONCED:
						case IDD_VLCONTROL:
						case IDD_ANNODATE:
						case IDD_PREANNODATE:
						case IDD_CHDATE:
						case IDD_PROFDATE:
							chg = CheckDateSet( oldbuf, newbuf, oldlength );
							break;

						case IDD_SUBS:
							chg = CheckSubSet( oldbuf, newbuf, oldlength );
							break;

						case IDD_REGDATE:
						case IDD_ANNULDATE:
						case IDD_ACTIVEEX:
							chg = CheckDateRefSet (oldbuf, newbuf, oldlength);
							break;

						case IDD_INFO:
							chg = DocInfoCmp ((DocInfo*) oldbuf, (DocInfo*) newbuf);
							break;

						default:
							chg = memcmp( oldbuf, newbuf, oldlength );
							break;
					}

					free( oldbuf );
					free( newbuf );
				}

				attrs1->Close (oldstr);
				attrs2->Close (newstr);

				oldit.next();
				newit.next();

				if (chg) {
					mpcxc_printfwin ( "\nmismatch of data for %ld.", newId);
					printAttrTag (newtag);
				}
			} else {
				chg = true;
				mpcxc_printfwin ("\nNo key %ld.", newId);
				printAttrTag (newtag);
				mpcxc_printfwin (" in base 1");
				newit.next ();
			}
		} else {
			if (oldtag < newtag) {
				chg = true;
				mpcxc_printfwin ("\nNo key %ld.");
				printAttrTag (oldtag);
				mpcxc_printfwin ("in base 2");
				oldit.next();
			} else {
				chg = true;
				mpcxc_printfwin ("\nNo key %ld.", newId);
				printAttrTag (newtag);
				mpcxc_printfwin ("in base 1");
				newit.next ();
			}
		}
		if (chg)
			thread_data_ptr->error = true;
	}

	for (; !oldit.End (); oldit.next ()) {
		oldkey = *(AttrKey*) oldit.Key();
		long oldtag = oldkey.AttrTag, oldId = oldkey.DocId;

		if (oldtag == IDD_RUNS || oldtag == IDD_BLOCKS || oldtag == IDD_SOURCEFILE || oldId < from_id || oldId > to_id)
			continue;

		mpcxc_printfwin ("\nNo key %ld.");
		printAttrTag (oldtag);
		mpcxc_printfwin ("in base 2");
		thread_data_ptr->error = true;
	}

	for (; !newit.End (); newit.next ()) {
		newkey = *(AttrKey*) newit.Key();
		long newtag = newkey.AttrTag, newId = newkey.DocId;

		if (newtag == IDD_RUNS || newtag == IDD_BLOCKS || newtag == IDD_SOURCEFILE || newId < from_id || newId > to_id)
			continue;

		mpcxc_printfwin ("\nNo key %ld.", newId);
		printAttrTag (newtag);
		mpcxc_printfwin ("in base 1");
		thread_data_ptr->error = true;
	}

	thread_data_ptr->done = 1;
}

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

std::deque<u_int64_t> refs_in_subnames_1, refs_in_subnames_2;
std::deque<u_int64_t>::const_iterator subname_it;
ACE_Recursive_Thread_Mutex subname_mutex;

std::deque<std::string> keys_nwcntxt_1, keys_nwcntxt_2;
std::deque<std::string>::const_iterator nwcntxt_it;
ACE_Recursive_Thread_Mutex nwcntxt_mutex;

std::deque<std::string> indexes_to_compare;
std::deque<std::string>::const_iterator index_it;
ACE_Recursive_Thread_Mutex index_mutex;
ACE_Recursive_Thread_Mutex print_mutex;

ACE_Recursive_Thread_Mutex get_doc_mutex;
std::deque<long>::const_iterator get_doc_it;

void	compare_texts_thread (long &thread_id)
{
	thread_data_struct* thread_data_ptr = & (thread_data [thread_id]);
	std::vector<std::string> *strings = &thread_data_ptr->errors;
	thread_data_ptr->run = 1;
	thread_data_ptr->error = false;

	Base* b1 = thread_data_ptr->base1;
	Base* b2 = thread_data_ptr->base2;

	bool b_1_saw = b1->bases_ptrs.size () > 1;
	bool b_2_saw = b2->bases_ptrs.size () > 1;

	for (long count = 0; ; count++) {
		long doc_id = 0;
		{
			RWRITE_GUARD (get_doc_mutex);
			if (get_doc_it != new_docs.end ()) {
				doc_id = *get_doc_it;
				get_doc_it++;
			}
		}
		if (0 == doc_id)
			break;

		if (b_1_saw) b1 = thread_data_ptr->base1->base_for_doc (doc_id);
		if (b_2_saw) b2 = thread_data_ptr->base2->base_for_doc (doc_id);

		Document *docum1, *docum2;
		char *para1, *para2;
		int i;

		docum1 = new Document (b1, doc_id);
		if ( !docum1 ) {
			mpcxc_printfwin(strings, "Document with Id %ld not found in base1\n", doc_id);
			thread_data_ptr->error = true;
			fflush(stdout);
			continue;
		}

		docum2 = new Document (b2, doc_id);
		if ( !docum2 ) {
			mpcxc_printfwin(strings, "Document with Id %ld not found in base2\n", doc_id);
			thread_data_ptr->error = true;
			fflush(stdout);
			delete docum1;
			continue;
		}

		if ( docum1->Stat.ParaCount != docum2->Stat.ParaCount ) {
			mpcxc_printfwin (strings, "Number of paragraphs for DocId %ld differ\n", doc_id);
			delete docum1;
			delete docum2;
			thread_data_ptr->error = true;
			fflush(stdout);
			continue;
		}

		for ( i = 0; i < docum1->Stat.ParaCount; i++ ) {
			para1 = docum1 -> GetPara (i);
			para2 = docum2 -> GetPara (i);

			int paralen1 = ParaSize ( para1 );
			int paralen2 = ParaSize ( para2 );

			if ( ( paralen1 != paralen2 ) || ( memcmp ( para1, para2, paralen1 ) ) ) {
				if ( ( docum1->Stat.Status & DS_EVD ) && ( docum2->Stat.Status & DS_EVD )) {
					int	  len11 = docum1->EVDTextSize( para1 );
					int	  len22 = docum1->EVDTextSize( para1 );
					if	(0 == len11 + len22)
						continue;

					if ( len11 == len22 ) {
						unsigned char* para11 = (unsigned char*)docum1->EVDParaText( para1 );
						unsigned char* para22 = (unsigned char*)docum2->EVDParaText( para1 );
						if ( memcmp( para11, para22, len11 )) {
							mpcxc_printfwin (strings, "Documents %d mismatch, para %ld\n", doc_id, i );
							fflush(stdout);
							break;
						} else {
							bool len1 = false;
							if ( abs (paralen1 - paralen2) == 1) {
								len1 = true;
								int len = std::min(TextSize (para1), TextSize (para2));
								para1 = ParaText (para1);
								para2 = ParaText (para2);
								if ( memcmp (para1, para2, len)) {
									mpcxc_printfwin (strings, "Documents %d mismatch, para %ld\n", doc_id, i );
									fflush(stdout);
									break;
								}
							}

							bool fatalErrors = false;
							bool spaces = false;
							for ( int ii = 0; ii < len11 && !fatalErrors; ii++ )
								if ( para11[ii] != para22[ii] )
									if ( para11[ii] != 32 && para11[ii] != 255 && para22[ii] != 32 && para22[ii] != 255 )
										fatalErrors = true;
									else
										spaces = true;

							if ( fatalErrors ) {
								mpcxc_printfwin (strings, "Documents %d mismatch\n", doc_id);
								thread_data_ptr->error = true;
								fflush (stdout);
								break;
							} else {
								if ( spaces )
									mpcxc_printfwin (strings, "Documents %d: warning in para %ld - unbreakable space\n", doc_id, i );
								else if (!len1) {
									thread_data_ptr->error = true;
									mpcxc_printfwin (strings, "Documents %d: warning in para %ld - different evd\n", doc_id, i );
								}

								fflush(stdout);
							}
						}
					} else {
						mpcxc_printfwin (strings, "Documents %d mismatch, para %ld\n", doc_id, i );
						thread_data_ptr->error = true;
						fflush(stdout);
						break;
					}
				} else {
					mpcxc_printfwin (strings, "Documents %d mismatch, para %ld\n", doc_id, i);
					thread_data_ptr->error = true;
					fflush(stdout);
					break;
				}
			}
		}
		delete docum1;
		delete docum2;
	}

	if (thread_data_ptr->error)
		fatalError = true;
	thread_data_ptr->done = 1;
}

void	compare_subnames (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->error = false;
	thread_data_ptr->run = 1;

	YBase *base1 = thread_data_ptr->base1;
	bool b_1_saw = base1->bases_ptrs.size () > 1;

	YBase *base2 = thread_data_ptr->base2;
	bool b_2_saw = base2->bases_ptrs.size () > 1;

	Index* subname1 = base1->FindIndex ("SubName");
	Index* subname2 = base2->FindIndex ("SubName");

	for (;;) {
		u_int64_t ref64 = 0;
		{
		RWRITE_GUARD (subname_mutex);
		if (subname_it != refs_in_subnames_1.end ()) {
			ref64 = *subname_it;
			subname_it++;
		}
		}
		if (ref64 == 0)
			break;
		Ref ref = {(long)(ref64 >> 32),(long)(ref64 & 0xFFFFFFFF)};

		if (b_1_saw) subname1 = base1->base_for_doc (ref.DocId)->FindIndex ("SubName"); 
		if (b_2_saw) subname2 = base2->base_for_doc (ref.DocId)->FindIndex ("SubName"); 		

		Stream *str1 = subname1->Open (&ref);
		Stream *str2 = subname2->Open (&ref);
		if (str1 && str2) {
			long l1 = str1->Length (), l2 = str2->Length ();
			if (l1 == l2) {
				char *data1 = new char [l1], *data2 = new char [l2];
				str1->Read (data1, l1);
				str2->Read (data2, l2);
				if (memcmp (data1, data2, l1)) {
					mpcxc_printfwin ( "\nData for the key %ld.%ld in index SubName mismatch (\"%s\", \"%s\")\n", ref.DocId, ref.Sub, data1, data2);
					thread_data_ptr->error = true;
				}
				delete []data1;
				delete []data2;
			} else {
				mpcxc_printfwin ( "\nLength of data for the key %ld.%ld in index SubName mismatch (%ld, %ld)\n", ref.DocId, ref.Sub, l1, l2);
				thread_data_ptr->error = true;
			}
		}
		if (str1) subname1->Close (str1);
		if (str2) subname2->Close (str2);
	}

	thread_data_ptr->done = 1;
}

void	print_errors (std::vector<std::string> *errors)
{
	RWRITE_GUARD (print_mutex);
	for (std::vector<std::string>::const_iterator it = errors->begin (); it != errors->end (); it++) {
		mpcxc_printwin (it->c_str ());
	}
	errors->clear ();
	fflush (stdout);
}

void	compare_nwcntxt (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->error = false;
	thread_data_ptr->run = 1;
	std::vector<std::string> *strings = &thread_data_ptr->errors;

	Index* ind1 = thread_data_ptr->base1->FindIndex ("NWCntxt");
	Index* ind2 = thread_data_ptr->base2->FindIndex ("NWCntxt");

	ContextSearch::Defs::Positions positions_1, positions_2;
	positions_1.reserve (ContextSearch::POS_TEXT);
	positions_2.reserve (ContextSearch::POS_TEXT);

	for (;;) {
		const char* key = 0;
		{
		RWRITE_GUARD (nwcntxt_mutex);
		if (nwcntxt_it != keys_nwcntxt_1.end ()) {
			key = nwcntxt_it->c_str ();
			nwcntxt_it++;
		}
		}
		if (!key)
			break;

		Stream *str1_0 = ind1->Open (key), *str1_1 = ind1->OpenN (key, 1), *str1_2 = ind1->OpenN (key, 2);
		Stream *str2_0 = ind2->Open (key), *str2_1 = ind2->OpenN (key, 1), *str2_2 = ind2->OpenN (key, 2);

		if (!str1_0 || !str2_0) {
			if (str1_0) ind1->Close (str1_0);
			if (str1_1) ind1->Close (str1_1);
			if (str1_2) ind1->Close (str1_2);

			if (str2_0) ind2->Close (str2_0);
			if (str2_1) ind2->Close (str2_1);
			if (str2_2) ind2->Close (str2_2);

			continue;
		}

		if (str1_0->Length () != str2_0->Length ()) {
			mpcxc_printfwin (strings, "Length of streams#0 for the key ");
			printValue (key, KV_NCONTXT, 0, strings);
			mpcxc_printfwin (strings, " in index NWCntxt mismatch\n");
		} else {
			if ((str1_1->Length () > 32) != (str2_1->Length () > 32)) {
				mpcxc_printfwin (strings, "Length of streams#1 for the key ");
				printValue (key, KV_NCONTXT, 0, strings);
				mpcxc_printfwin (strings, " in index NWCntxt mismatch\n");
			}

			DBCore::IDataStream_var pos_reader_1 = new DBExt::PositionsReader (str1_2, -1, DBExt::Def::dt_All, str1_1->Length () > 32, 0);
			DBCore::IRefStream_var str_reader_1 = new DBExt::StreamReader (str1_0, 0);

			DBCore::IDataStream_var pos_reader_2  = new DBExt::PositionsReader(str2_2, -1, DBExt::Def::dt_All, str2_1->Length () > 32, 0);
			DBCore::IRefStream_var str_reader_2 = new DBExt::StreamReader (str2_0, 0);

			DBCore::Ref_ ref_1 = {0,0,0}, ref_2 = {0,0,0};
			DBCore::ExtrPair extr;

			while (str_reader_1->get_next (ref_1, 0) && str_reader_2->get_next (ref_2, 0)) {
				long id_1 = ref_1.doc_id;
				long id_2 = ref_2.doc_id;

				if (id_1 != id_2) {
					mpcxc_printfwin (strings, "Data for the key ");
					printValue (key, KV_NCONTXT, 0, strings);
					mpcxc_printfwin (strings, " in index NWCntxt mismatch\n");
					break;
				}

				pos_reader_1->get (positions_1, ref_1, extr);
				pos_reader_2->get (positions_2, ref_2, extr);

				if (positions_1 != positions_2) {
					mpcxc_printfwin (strings, "Data for the key ");
					printValue (key, KV_NCONTXT, 0, strings);
					mpcxc_printfwin (strings, " in index NWCntxt mismatch\n");
					break;
				}

				positions_1.clear ();
				positions_2.clear ();
			}
		}

		ind1->Close (str1_0);
		ind1->Close (str1_1);
		ind1->Close (str1_2);

		ind2->Close (str2_0);
		ind2->Close (str2_1);
		ind2->Close (str2_2);
	}

	print_errors (strings);
	thread_data_ptr->done = 1;
}


void	read_subname (long &thread_id)
{
	long id = thread_data [thread_id].id;
	for (std::vector<Base*>::const_iterator base_it = thread_data [thread_id].base1->bases_ptrs.begin (); base_it != thread_data [thread_id].base1->bases_ptrs.end (); base_it++) {
		Index *subname = (*base_it)->FindIndex ("SubName");
		for (BTIterator it (subname); !it.End (); ++it) {
			Ref *ref = (Ref*) it.Key ();
			u_int64_t ref64 = (((u_int64_t)ref->DocId) << 32) + ref->Sub;
			if (id == 0)
				refs_in_subnames_1.push_back (ref64);
			else
				refs_in_subnames_2.push_back (ref64);
		}
	}

	if (id == 0) {
		std::sort (refs_in_subnames_1.begin (), refs_in_subnames_1.end ());
		refs_in_subnames_1.erase (std::unique (refs_in_subnames_1.begin (), refs_in_subnames_1.end ()), refs_in_subnames_1.end ());
	} else {
		std::sort (refs_in_subnames_2.begin (), refs_in_subnames_2.end ());
		refs_in_subnames_2.erase (std::unique (refs_in_subnames_2.begin (), refs_in_subnames_2.end ()), refs_in_subnames_2.end ());
	}
}

void	read_nwcntxt (long &thread_id)
{
	long id = thread_data [thread_id].id;
	Index *nwcntxt = thread_data [thread_id].base1->FindIndex ("NWCntxt");
	char lemma [33];
	for (BTIterator it (nwcntxt); !it.End (); ++it) {
		gk_bzero (lemma, sizeof (lemma));
		char *key = (char*) it.Key (), length = *key & 0x7F;
		strncpy (lemma, key, length);
		lemma [length] = 0;
		if (id == 0)
			keys_nwcntxt_1.push_back (lemma);
		else
			keys_nwcntxt_2.push_back (lemma);
	}
}

struct Node
{
	Node *parent, *next, *child;
	char *name;
	void *key;
	int  id, pid, ac, oc;
};

// locate parent node
static Node *Locate ( Node *root, int id )
{
	Node *r, *q;
	for ( r = root; r; r = r -> next )
		if ( r -> id == id )
			return r;

	for ( r = root; r; r = r -> next )
		if ( r -> child && ( q = Locate ( r -> child, id ) ) )
			return q;

	return (Node*) 0;
}

// insert item to a tree
static int InsertItem ( Node *root, int id, int pid, int ac, int oc, char *name, const void *key, int size )
{
	Node *r;
	if ( !( r = Locate ( root, pid ) ) ) {
		mpcxc_printfwin ( "\nError in hindex! id=%d, pid=%d, text=%s\n", id, pid, name );
		return 1;
	}

	Node *q = (Node*) calloc ( 1, sizeof ( Node ) );

	q -> id     = id;
	q -> pid    = pid;
	q -> parent = r;
	q -> ac     = ac;
	q -> oc     = oc;
	memcpy ( q -> key  = (char*) malloc ( size ), key, size );
	strcpy ( q -> name = (char*) malloc ( 1 + strlen ( name ) ), name );

	q -> next  = r -> child;
	r -> child = q;

	return 0;
}

// read hindex to a tree
static int readHindex ( HIndex *idx, Node *root, char *name, bool &hError, std::vector<std::string> *strings = 0 )
{
	int len = idx -> KeyLength;
	for ( BTIterator it ( idx ); !it.End ( ); ++it )
	{
		const void *k	= it.Key ( );
		long id		= idx -> Id ( k );
		long pid	= idx -> Parent ( k );
		int  ac		= idx -> AllChildrenCount ( k );
		int  oc		= idx -> OwnChildrenCount ( k );

		if ( InsertItem ( root, id, pid, ac, oc, (char*) idx -> Text ( k ), k, len ) ){
			mpcxc_printfwin (strings, "\nHindex '%s' not read. Compare for this index stopped\n", name );
			hError = true;
			return 1;
		}
	}
//	mpcxc_printfwin ( "\nh read\n" );
	return 0;
}

// delete hindex tree
static void DelTr ( Node *r )
{
	if ( r )
	{
		if ( r -> child )
			DelTr ( r -> child );
		if ( r -> next )
			DelTr ( r -> next );
		if ( r -> name [0] )
			free ( r -> name );
		if ( r -> key )
			free ( r -> key );
		free ( r );
	}
}

static void MakeKey ( Node *r, char *key )
{
	char *tmp = (char*) malloc ( 1 + strlen ( key ) );

	if ( tmp == 0 )
		mpcxc_printfwin ( "not enough memory in MakeKey" );

	strcpy ( tmp, key );
	strcpy ( key, r -> name ? r -> name : "" );
	if ( tmp [0] )
	{
		strcat ( key, "\\" );
		strcat ( key, tmp );
	}
	free ( tmp );

	if ( r -> parent )
		MakeKey ( r -> parent, key );
}

static Node *LocateKey ( char *str, Node *root )
{
	Node *rr = root;

start:
	char *pos = strchr ( str, '\\' );
	int len = pos ? ( pos - str ) : 1000;

	for ( ; rr; rr = rr -> next )
	{
	    Node *r = rr;
	    if ( ( ( len == 1000 ) && ( !strncmp ( r -> name, str, len ) ) ) ||
		 ( ( len < 1000 ) && ( !strncmp ( r -> name, str, len ) ) && ( r -> name [len] == 0 ) ) )
		if ( strcmp ( r -> name, str ) )
		{
			rr = r -> child;
			str += 1 + strlen ( r -> name );
			goto start;
		}
		else
			return r;
	}
	return (Node*)0;
}

Node *Root1PublishedIn = 0, *Root2PublishedIn = 0;

void	read_publishedin (long &thread_id)
{
	bool hError = false;
	HIndex *publishedin = (HIndex*) thread_data [thread_id].base1->FindIndex ("PublishedIn");
	if (thread_id == MAX_THREADS + 2) {
		Root1PublishedIn = (Node*) calloc (1, sizeof (Node));
		Root1PublishedIn->name = "";
		readHindex (publishedin, Root1PublishedIn, "PublishedIn", hError);
	} else if (thread_id == MAX_THREADS + 3) {
		Root2PublishedIn = (Node*) calloc (1, sizeof (Node));
		Root2PublishedIn->name = "";
		readHindex (publishedin, Root2PublishedIn, "PublishedIn", hError);
	}
}

void	compare_attrs_n (YBase *b1, YBase*b2, char* name1, char* name2, long threads_count)
{
	get_docs_in_bases (b1, b2);

	std::deque<long>::const_iterator from_it, to_it;
	long from_id = *new_docs.begin (), to_id = *new_docs.rbegin ();
	long size = new_docs.size (), step = size / threads_count, ok_threads = 0, parts;
	for (parts = 0; parts < threads_count; parts++) {
		thread_data [parts].base1 = new YBase (name1, ACE_OS_O_RDONLY); thread_data [parts].base1->IsOk (); thread_data [parts].base1->open_saw_bases (ACE_OS_O_RDONLY);
		thread_data [parts].base2 = new YBase (name2, ACE_OS_O_RDONLY); thread_data [parts].base2->IsOk (); thread_data [parts].base2->open_saw_bases (ACE_OS_O_RDONLY);
		thread_data [parts].run  = 0;
		thread_data [parts].done = 0;

		int from_part = parts + 1;
		from_it = new_docs.begin () + (step * (from_part-1));
		from_id = *from_it;
		if (from_part < threads_count) {
			to_it = new_docs.begin ()+ step * from_part;
		} else {
			to_it = new_docs.begin () + new_docs.size ();
			to_it--;
		}
		to_id = *to_it;

		thread_data [parts].from_id = from_id;
		thread_data [parts].to_id = to_id;
		thread_data [parts].id = parts;

		boost::thread thread (compare_attrs, thread_data [parts].id);
		thread.detach ();
		ok_threads++;
	}

	for (;;) {
		long dones = 0;
		for (int thread_id = 0; thread_id < threads_count; thread_id++)
			if (thread_data [thread_id].run && thread_data [thread_id].done)
				dones++;
		if (dones == ok_threads)
			break;
		else
			ACE_OS::sleep (1);
	}
	for (int thread_id = 0; thread_id < threads_count; thread_id++)
		if (thread_data [thread_id].error)
			fatalError = true;

	mpcxc_printfwin (fatalError ? "mismatch\n" : "ok!\n");
	fflush(stdout);
}

boost::thread *thread_read_publishedin_1 = 0, *thread_read_publishedin_2 = 0;
boost::thread *thread_read_nwcntxt_1 = 0, *thread_read_nwcntxt_2 = 0;

std::set<std::string> skip_indexes;

void	compare_index_n (long &thread_id)
{
	thread_data_struct* thread_data_ptr = & (thread_data [thread_id]);
	thread_data_ptr->run = 1;
	std::vector<std::string> *errors = &thread_data_ptr->errors;
	errors->clear ();

	YBase* b1 = thread_data_ptr->base1;
	YBase* b2 = thread_data_ptr->base2;

	for (;;) {
		std::string index_name;
		{
		RWRITE_GUARD (index_mutex);
		if (index_it != indexes_to_compare.end ()) {
			index_name = *index_it;
			index_it++;
		}
		}
		if (0 == index_name.size ())
			break;

		if (skip_indexes.find (index_name) != skip_indexes.end ())
			continue;

		if (index_name == "Aux") {
			checkBaseInfo (b1, b2, errors);
			print_errors (errors);
			continue;
		} else if (index_name == "PublishedIn") {
			if (thread_read_publishedin_1) thread_read_publishedin_1->join ();
			if (thread_read_publishedin_2) thread_read_publishedin_2->join ();
		} else if (index_name == "Text") {
			compare_texts_thread (thread_id);
			print_errors (errors);
			continue;
		}

		long i;
		bool hError = false, iError = false;
		for (i = 0; HIndexes [i].name [0]; i++) {
			if (!strcmp (index_name.c_str (), HIndexes [i].name)) {
				if (hcheck (b1, b2, HIndexes [i].name, HIndexes [i].id, HIndexes [i].itemsize, HIndexes [i].second, errors)) {
					mpcxc_printfwin (errors, "HIndex name: %s (%c)...mismatch\n", HIndexes [i].name, HIndexes [i].status);
					if (Indexes [i].status != 'w') fatalError = true;
				} else {
					mpcxc_printfwin (errors, "HIndex name: %s (%c)...ok!\n", HIndexes [i].name, HIndexes [i].status);
				}
				print_errors (errors);
				goto next;
			}
		}

		for (i = 0; Indexes [i].name [0]; i++) {
			if (!strcmp (index_name.c_str (), Indexes [i].name)) {
				int col = 1;
				if (!strcmpi (Indexes [i].name, "SubName")) col = 0;
				if (!strcmpi (Indexes [i].name, "Attribs")) col = 0;

				if (check (b1, b2, Indexes [i].name, Indexes [i].id, Indexes [i].itemsize, col, Indexes [i].second, hError, iError, errors)) {
					mpcxc_printfwin (errors, "Index name: %s (%c)...mismatch\n", Indexes [i].name, Indexes [i].status);
					if (iError && Indexes [i].status != 'w') fatalError = true;
				} else { 
					mpcxc_printfwin (errors, "Index name: %s (%c)...ok!\n", Indexes [i].name, Indexes [i].status);
				}
				print_errors (errors);
				goto next;
			}
		}

		for (i = 0; TurboIndexes [i].name [0]; i++) {
			if (!strcmpi (index_name.c_str (), TurboIndexes [i].name)) {
				int col = strcmpi (TurboIndexes [i].name, "SWords") ? 1 : 0;
				if (check (b1, b2, TurboIndexes [i].name, TurboIndexes [i].id, TurboIndexes [i].itemsize, col, TurboIndexes [i].second, hError, iError, errors) ) {
					mpcxc_printfwin (errors, "Index name: %s (%c)...mismatch\n", TurboIndexes [i].name, TurboIndexes [i].status);
					if (iError && TurboIndexes [i].status != 'w') fatalError = true;
					mpcxc_printfwin (errors, "mismatch\n");
				} else { 
					mpcxc_printfwin (errors, "Index name: %s (%c)...ok!\n", TurboIndexes [i].name, Indexes [i].status);
				}
				print_errors (errors);
				goto next;
			}
		}

next:
		;

	}

	thread_data_ptr->done = 1;
}


int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	Core::AutoInit init;
	return main_logic (argc, argv);
}

FILE	*presfile = 0;

int main_logic ( int argc, char *argv[] )
{
	char* resultFile = 0;
#ifndef _DEBUG
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GKDBCMP;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i != VC_ADD_OK)
				exit (i);				
		}
	}
#endif

	YBase *b1, *b2;
	int check_par = 1, check_ndx = 1, check_turbo = 1;
	char *iname = 0;

	if ( argc < 3 ) {
		mpcxc_printfwin( "GARANT Base comparator v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
		mpcxc_printfwin( "Usage: compare [-p] [-n] <base1> <base2>\n" );
		mpcxc_printfwin( "\t -p to disable paragraphs checking\n" );
		mpcxc_printfwin( "\t -n to disable indices checking\n" );
		return 1;
	}

	int i = 1;
	long threads_count = 1;
	while ( i < argc ) {
		if (argv [i][0] == '-') {
			if (strstr (argv [i], "-threads:")) {
				threads_count = atol (argv [i] + 9);
			} else
			if ( !strcmpi ( argv [i], "-t" ) ) {
				check_turbo = 0;
				mpcxc_printfwin ( "Checking turbo skipped\n" );
			} else
			if ( !strcmpi ( argv [i], "-n" ) ) {
				check_ndx = 0;
				mpcxc_printfwin ( "Checking indices skipped\n" );
			} else if ( !strcmpi ( argv [i], "-p" ) ) {
				check_par = 0;
				mpcxc_printfwin ( "Checking paragraphs skipped\n" );
			} else if ( !strcmpi ( argv [i], "-r" ) ) {
				i++;
				resultFile = argv[i];
				ace_os_unlink( resultFile );
			} else {
				skip_indexes.insert (argv [i] + 1);
			}
		}
		else if ( argv [i][0] != '-' )
			break;
		else
			mpcxc_printfwin ( "unknown parameter\n" );
		i++;
	}

	b1 = new YBase (argv [i], ACE_OS_O_RDONLY);
	char *name1 = strdup (argv [i]);
	if ( !b1 || !b1 -> IsOk ()) {
		//mpcxc_printfwin ( "seems like base '%s' does not exist or not ok.\n", argv [i] );
		//return 1;
	}
	b1->open_saw_bases (ACE_OS_O_RDONLY);
	mpcxc_printfwin ( "Base1 = %s\n", argv [i] );

	i++;

	char *name2 = strdup (argv [i]);
	b2 = new YBase (argv [i], ACE_OS_O_RDONLY);
	if ( !b2 || !b2 -> IsOk ( )) {
		//mpcxc_printfwin ( "seems like base '%s' does not exist or not ok.\n", argv [i] );
		//return 1;
	}
	b2->open_saw_bases (ACE_OS_O_RDONLY);
	mpcxc_printfwin ( "Base2 = %s\n", argv [i] );

	if (threads_count > 1) {
		boost::thread *thread_read_subnames_1 = 0, *thread_read_subnames_2 = 0;

		if (resultFile) presfile = mpcxc_fopen (resultFile, "wtc");

		for (long thread_id = 0; thread_id < MAX_THREADS; thread_id++) {
			thread_data [thread_id].base1 = 0;
			thread_data [thread_id].base2 = 0;
		}

		get_docs_in_bases (b1, b2);
		std::vector<long> diff_docs;
		std::set_difference (new_docs.begin (), new_docs.end (), old_docs.begin (), old_docs.end (), std::back_inserter (diff_docs));
		if (diff_docs.size ()) {
			fatalError = true;
			for (std::vector<long>::const_iterator diff_it = diff_docs.begin (); diff_it != diff_docs.end (); diff_it++) {
				long id = *diff_it;
				if (std::binary_search (old_docs.begin (), old_docs.end (), id)) {
					mpcxc_printfwin ( "Document %ld in base1, not in base2\n", id);
				} else {
					mpcxc_printfwin ( "Document %ld in base2, not in base1\n", id);
				}
			}
		}
		
		long thread_id, ok_threads, parts;
		//пустить потоки, которые прочитают из SubName и PublishedIn ключи
		thread_id = MAX_THREADS+0; thread_data [thread_id].id = 0; thread_data [thread_id].base1 = new YBase (name1, ACE_OS_O_RDONLY); thread_data [thread_id].base1->IsOk (); thread_data [thread_id].base1->open_saw_bases (ACE_OS_O_RDONLY);
		if (skip_indexes.find ("SubName") == skip_indexes.end ()) {
			thread_read_subnames_1 = new boost::thread (read_subname, thread_id);
			ACE_OS::sleep (1);
		}

		thread_id = MAX_THREADS+1; thread_data [thread_id].id = 1; thread_data [thread_id].base1 = new YBase (name2, ACE_OS_O_RDONLY); thread_data [thread_id].base1->IsOk (); thread_data [thread_id].base1->open_saw_bases (ACE_OS_O_RDONLY);
		if (skip_indexes.find ("SubName") == skip_indexes.end ()) {
			thread_read_subnames_2 = new boost::thread (read_subname, thread_id);
			ACE_OS::sleep (1);
		}

		thread_id = MAX_THREADS+2; thread_data [thread_id].base1 = new YBase (name1, ACE_OS_O_RDONLY); thread_data [thread_id].base1->IsOk (); thread_data [thread_id].base1->open_saw_bases (ACE_OS_O_RDONLY);
		if (skip_indexes.find ("PublishedIn") == skip_indexes.end ()) {
			thread_read_publishedin_1 = new boost::thread (read_publishedin, thread_id);
			ACE_OS::sleep (1);
		}
		thread_id = MAX_THREADS+3; thread_data [thread_id].base1 = new YBase (name2, ACE_OS_O_RDONLY); thread_data [thread_id].base1->IsOk (); thread_data [thread_id].base1->open_saw_bases (ACE_OS_O_RDONLY);
		if (skip_indexes.find ("PublishedIn") == skip_indexes.end ()) {
			thread_read_publishedin_2 = new boost::thread (read_publishedin, thread_id);
			ACE_OS::sleep (1);
		}

		if (skip_indexes.find ("Attrs") == skip_indexes.end ()) {
			mpcxc_printfwin ("Comparing index Attrs (f)...");
			compare_attrs_n (b1, b2, name1, name2, threads_count);
		}

		if (thread_read_subnames_1) thread_read_subnames_1->join ();
		if (thread_read_subnames_2) thread_read_subnames_2->join ();

		if (skip_indexes.find ("NWCntxt") == skip_indexes.end ()) {
			thread_id = MAX_THREADS+0; thread_read_nwcntxt_1 = new boost::thread (read_nwcntxt, thread_id);
			ACE_OS::sleep (1);
			thread_id = MAX_THREADS+1; thread_read_nwcntxt_2 = new boost::thread (read_nwcntxt, thread_id);
			ACE_OS::sleep (1);
		}

		if (skip_indexes.find ("SubName") == skip_indexes.end ()) {
			mpcxc_printfwin ("Index name: SubName (e)...");
			std::deque<u_int64_t> and_refs;
			std::set_intersection (refs_in_subnames_1.begin (), refs_in_subnames_1.end (), refs_in_subnames_2.begin (), refs_in_subnames_2.end (), std::back_inserter (and_refs));
			std::deque<u_int64_t> diff1_refs, diff2_refs;
			std::set_difference (refs_in_subnames_1.begin (), refs_in_subnames_1.end (), and_refs.begin (), and_refs.end (), std::back_inserter (diff1_refs));
			std::set_difference (refs_in_subnames_2.begin (), refs_in_subnames_2.end (), and_refs.begin (), and_refs.end (), std::back_inserter (diff2_refs));
			if (diff1_refs.size ()) {
				fatalError = true;
				for (std::deque<u_int64_t>::const_iterator diff_it = diff1_refs.begin (); diff_it != diff1_refs.end (); diff_it++) {
					u_int64_t diff = *diff_it;
					mpcxc_printfwin ("SubName %lld.%lld in base1, not in base2\n", diff >> 32, diff & 0xFFFFFFFF);
				}
			}
			if (diff2_refs.size ()) {
				fatalError = true;
				for (std::deque<u_int64_t>::const_iterator diff_it = diff2_refs.begin (); diff_it != diff2_refs.end (); diff_it++) {
					u_int64_t diff = *diff_it;
					mpcxc_printfwin ("SubName %lld.%lld in base2, not in base1\n", diff >> 32, diff & 0xFFFFFFFF);
				}
			}

			subname_it = refs_in_subnames_1.begin ();
			for (parts = 0, ok_threads = 0; parts < threads_count; parts++) {
				if (0 == thread_data [parts].base1) {
					thread_data [parts].base1 = new YBase (name1, ACE_OS_O_RDONLY);
					thread_data [parts].base1->IsOk ();
					thread_data [parts].base1->open_saw_bases (ACE_OS_O_RDONLY);
				}
				if (0 == thread_data [parts].base2) {
					thread_data [parts].base2 = new YBase (name2, ACE_OS_O_RDONLY);
					thread_data [parts].base2->IsOk ();
					thread_data [parts].base2->open_saw_bases (ACE_OS_O_RDONLY);
				}
				thread_data [parts].id   = parts;
				thread_data [parts].run  = 0;
				thread_data [parts].done = 0;

				boost::thread thread (compare_subnames, thread_data [parts].id);
				thread.detach ();
				ok_threads++;
				ACE_OS::sleep (1);
			}
			for (;;) {
				long dones = 0;
				for (int thread_id = 0; thread_id < threads_count; thread_id++)
					if (thread_data [thread_id].run && thread_data [thread_id].done)
						dones++;
				if (dones == ok_threads)
					break;
				else
					ACE_OS::sleep (1);
			}
			for (int thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].error)
					fatalError = true;
			mpcxc_printfwin ("ok!\n");

			{
				std::deque<u_int64_t> empty1, empty2;
				refs_in_subnames_1.swap (empty1);
				refs_in_subnames_2.swap (empty2);
			}
		}
		
		using namespace boost::assign;
		indexes_to_compare += "Aux", "PublishedIn", "SWords", "NFContxt", "NewCorr", "Attribs", "Blob", "KindCorr", "Respondent", "Class", "Correspondent", "Number";
		indexes_to_compare += "Date", "RegDate", "AnnulDate", "Active", "AnnoDate", "CalIn", "CalAb", "CalCh", "RDate", "VIncluded", "VChanged", "VAbolished";
		indexes_to_compare += "SortDate", "VAnonced", "VLControl", "Category", "TradeName", "IntName", "RCode", "Status", "Status_ex", "Segment", "Control";
		indexes_to_compare += "ServiceInfo", "Type", "KeyWord", "Territory", "Class6", "DocKind", "Kind", "Adopted", "AnnoUser", "AnnoOrganization", "AnnoTax";
		indexes_to_compare += "AnnoInterest", "AnnoKind", "PhGroup", "PhEffect", "Chapter", "Mkb", "PhFirm", "PhCountry", "Atc", "RegStatus", "LekForm";
		if (b1->FindIndex ("CalIn.str")->file->GetAttr ("Tag.str", 0, 0))
			indexes_to_compare += "Tag";
		for (parts = 0; parts < threads_count; parts++)
			indexes_to_compare += "Text";

		index_it = indexes_to_compare.begin ();
		get_doc_it = new_docs.begin ();

		for (parts = 0, ok_threads = 0; parts < threads_count; parts++) {
			if (0 == thread_data [parts].base1) {
				thread_data [parts].base1 = new YBase (name1, ACE_OS_O_RDONLY);
				thread_data [parts].base1->IsOk ();
				thread_data [parts].base1->open_saw_bases (ACE_OS_O_RDONLY);
			}
			if (0 == thread_data [parts].base2) {
				thread_data [parts].base2 = new YBase (name2, ACE_OS_O_RDONLY);
				thread_data [parts].base2->IsOk ();
				thread_data [parts].base2->open_saw_bases (ACE_OS_O_RDONLY);
			}
			thread_data [parts].run  = 0;
			thread_data [parts].done = 0;
			thread_data [parts].id   = parts;

			boost::thread thread (compare_index_n, parts);
			thread.detach ();
			ok_threads++;
			ACE_OS::sleep (1);
		}
		for (;;) {
			long dones = 0;
			for (int thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].run && thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
			else
				ACE_OS::sleep (1);
		}

		{
			std::deque<long> empty1, empty2;
			old_docs.swap (empty1);
			new_docs.swap (empty2);
		}
		if (skip_indexes.find ("Text") == skip_indexes.end ()) {
			mpcxc_printfwin ("Checking document texts complete\n");
			fflush (stdout);
		}

		if (skip_indexes.find ("NWCntxt") == skip_indexes.end ()) {
			mpcxc_printfwin ("Index name: NWCntxt (e)...");
			if (thread_read_nwcntxt_1) thread_read_nwcntxt_1->join ();
			if (thread_read_nwcntxt_2) thread_read_nwcntxt_2->join ();

			std::deque<std::string> diff_keys;
			std::set_difference (keys_nwcntxt_1.begin (), keys_nwcntxt_1.end (), keys_nwcntxt_2.begin (), keys_nwcntxt_2.end (), std::back_inserter (diff_keys));
			if (diff_keys.size ()) {
				fatalError = true;
				for (std::deque<std::string>::const_iterator diff_it = diff_keys.begin (); diff_it != diff_keys.end (); diff_it++) {
					std::string diff = *diff_it;
					if (std::binary_search (keys_nwcntxt_1.begin (), keys_nwcntxt_1.end (), diff)) {
						mpcxc_printfwin ("Key %s in base1, not in base2\n", diff.c_str () + 1);
					} else {
						mpcxc_printfwin ("Key %s in base2, not in base1\n", diff.c_str () + 1);
					}
				}
			}

			nwcntxt_it = keys_nwcntxt_1.begin ();

			for (parts = 0, ok_threads = 0; parts < threads_count; parts++) {
				if (0 == thread_data [parts].base1) {
					thread_data [parts].base1 = new YBase (name1, ACE_OS_O_RDONLY);
					thread_data [parts].base1->IsOk ();
					thread_data [parts].base1->open_saw_bases (ACE_OS_O_RDONLY);
				}
				if (0 == thread_data [parts].base2) {
					thread_data [parts].base2 = new YBase (name2, ACE_OS_O_RDONLY);
					thread_data [parts].base2->IsOk ();
					thread_data [parts].base2->open_saw_bases (ACE_OS_O_RDONLY);
				}
				thread_data [parts].id   = parts;
				thread_data [parts].run  = 0;
				thread_data [parts].done = 0;

				boost::thread thread (compare_nwcntxt, parts);
				thread.detach ();
				ok_threads++;
				ACE_OS::sleep (1);
			}
			for (;;) {
				long dones = 0;
				for (int thread_id = 0; thread_id < threads_count; thread_id++)
					if (thread_data [thread_id].run && thread_data [thread_id].done)
						dones++;
				if (dones == ok_threads)
					break;
				else {
					ACE_OS::sleep (1);
				}
			}
			for (int thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].error)
					fatalError = true;
			mpcxc_printfwin ("ok!\n");
		}

		goto finish;
	}

	if ( check_ndx ) {
		if ( ++i < argc ) {
			mpcxc_printfwin ( "Comparing only index %s\n", iname = argv [i] );
			check_par = 0;
		} else {
			checkBaseInfo ( b1, b2 );
		}

		if (iname && !strcmp (iname, "Attrs") && argv [++i] && threads_count == 1) {
			//сравниваетс€ только Tag, указанный в ком.строке
			check_only_attr = (short)((atol (argv [i]))&0x7fff);			
		}

		if (iname && !strcmp (iname, "Aux")) {
			checkBaseInfo (b1, b2);
			fflush(stdout);
		}

		for ( i = 0; HIndexes [i].name [0]; i++ ) {
			if (skip_indexes.find (HIndexes [i].name) != skip_indexes.end ()) {
				mpcxc_printfwin ( "HIndex name: %s - skipped\n", HIndexes [i].name);
				continue;
			}
			if ( ( iname && !strcmpi ( iname, HIndexes [i].name ) ) || ( !iname ) ) {
				long time0 = time (0);
				mpcxc_printfwin ( "HIndex name: %s (%c)...", HIndexes [i].name, HIndexes [i].status );
				if ( hcheck ( b1, b2, HIndexes [i].name, HIndexes [i].id, HIndexes [i].itemsize, HIndexes [i].second ) ) {
					fatalError = true;
					mpcxc_printfwin ( "mismatch\n" );
					fflush(stdout);
				} else {
					mpcxc_printfwin ( "ok! (%ld)\n", time (0) - time0 );
					fflush(stdout);
				}
			}
		}

		for ( i = 0; Indexes [i].name [0]; i++ ) {
	#ifndef	unix
			if (!strcmp (Indexes [i].name, "NewCorr") && !iname)
				continue;
	#endif
			if (skip_indexes.find (Indexes [i].name) != skip_indexes.end ()) {
				mpcxc_printfwin ( "Index name: %s - skipped\n", Indexes [i].name);
				continue;
			}
			if ( ( iname && !strcmpi ( iname, Indexes [i].name ) ) || ( !iname ) ) {
				bool hError = false, iError = false;
				mpcxc_printfwin ( "Index name: %s (%c)...", Indexes [i].name, Indexes [i].status );

				int col = 1;
				if ( !strcmpi ( Indexes [i].name, "SubName" ) ) col = 0;
				if ( !strcmpi ( Indexes [i].name, "Attribs"   ) ) col = 0;
				if ( !strcmpi ( Indexes [i].name, "Attrs"   ) ) col = 0;
				if ( !strcmpi ( Indexes [i].name, "SWords" ) ) col = 0;

				long time0 = time (0);
				if ( check ( b1, b2, Indexes [i].name, Indexes [i].id, Indexes [i].itemsize, col, Indexes [i].second, hError, iError ) ) {
					if ( iError ) fatalError = true;
					mpcxc_printfwin ( "mismatch\n" );
					fflush(stdout);
				} else { 
					mpcxc_printfwin ( "ok! (%ld)\n", time (0) - time0 );
					fflush(stdout);
				}
			}
		}
	}

	if (check_turbo) {
		for ( i = 0; TurboIndexes [i].name [0]; i++ ) {
			if ( ( iname && !strcmpi ( iname, TurboIndexes [i].name ) ) || ( !iname ) ) {
				bool hError = false, iError = false;
				mpcxc_printfwin ( "Index name: %s (%c)...", TurboIndexes [i].name, TurboIndexes [i].status );
				int col = strcmpi ( TurboIndexes [i].name, "SWords" ) ? 1 : 0;
				if ( check ( b1, b2, TurboIndexes [i].name, TurboIndexes [i].id, TurboIndexes [i].itemsize, col, TurboIndexes [i].second, hError, iError ) ) {
					if ( iError ) fatalError = true;
					mpcxc_printfwin ( "mismatch\n" );
					fflush(stdout);
				} else { 
					mpcxc_printfwin ( "ok!\n" );
					fflush(stdout);
				}
			}
		}
	}

	bool tError = false;
	if ( check_par ) {
		if (threads_count == 1) {
			mpcxc_printfwin ( "Checking document texts (f)...\n" );
			checkText ( b1, b2, tError );
			mpcxc_printfwin ( "Checking document texts complete\n" );
			fflush(stdout);
		} else {
			mpcxc_printfwin ( "Checking document texts (f)...\n" );
			compare_texts_n (b1, b2, name1, name2, threads_count);
			mpcxc_printfwin ( "Checking document texts complete\n" );
			fflush(stdout);
		}
	}
	if ( tError ) fatalError = true;

finish:

	if (resultFile && !presfile)
		presfile = mpcxc_fopen (resultFile, "wtc");
	if (presfile) {
		fprintf ( presfile, fatalError ? "1" : "0" );
		fclose( presfile );
	}

#ifndef	_WIN64
	delete b1;
	delete b2;
#endif
	
	return fatalError ? 1 : 0;
}
/////////////////////////////
int MemoryError ( )
{
	mpcxc_printfwin ( "М†ЂЃ ѓ†ђпв®" );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	mpcxc_printfwin ( "Message:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	mpcxc_printfwin ( "Message:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

static int RunCompare ( char*, char*, char* name, int keyId, int itemsize, int second, Base *b1, Base *b2, bool &, std::vector<std::string> *strings = 0);

static int WalkTree ( Node *root_a, Node *root_b, char *ndx, char* name, int keyId, int itemsize, int second, Base *b1, Base *b2, int n, bool &hError, std::vector<std::string> *strings = 0 )
{
	int error_count = 0;
	Node *r, *q;

	for ( r = root_a; r; r = r -> next )
	{
		char *str1 = (char*) calloc (1, 1000);
		char *str2 = (char*) calloc (1, 1000);

		if ( !str1 || !str2 )
			mpcxc_printfwin (strings, "Memory error at WalkTree\n" );

		MakeKey ( r, str1 );
		if ( !str1 [0] )
		{
			free ( str1 );
			free ( str2 );
			continue;
		}

//		mpcxc_printfwin ("locate %s\n", str1 + 1 );
		q = LocateKey ( str1 + 1, root_b );
		if ( !q ) {
			mpcxc_printfwin (strings, "No key '%s' in index '%s' in base %d\n", str1 + 1, ndx, n );
			ERROR_MPCXC;
		}
//		mpcxc_printfwin ( "%s\n", str1 + 1 );

		if ( q )
		    if ( n == 1 )
		    {
			MakeKey ( q, str2 );
			if ( RunCompare ( str1 + 1, str2 + 1, name, keyId, itemsize, second, b1, b2, hError, strings ) ) {
//				mpcxc_printfwin ( "compare for %s mismatch", str1 );
				error_count++;
			}
		    }

		free ( str1 );
		free ( str2 );
	}

	for ( r = root_a; r; r = r -> next )
		if ( r -> child )
			error_count += WalkTree ( r -> child, root_b, ndx, name, keyId, itemsize, second, b1, b2, n, hError, strings );

	return error_count;
}

int hcheck ( Base *b1, Base* b2, char* name, int keyId, int itemsize, int second, std::vector<std::string> *strings )
{
	int error_count = 0;
	bool hError = false;

	OPEN_HHINDEX ( 1 );
	OPEN_HHINDEX ( 2 );

	//if ( second )
	//	mpcxc_printfwin ( " (with second stream)" );

	Node *Root1, *Root2;
	if (!strcmp (name, "PublishedIn") && Root1PublishedIn) {
		Root1 = Root1PublishedIn;
		Root2 = Root2PublishedIn;
	} else {
		Root1 = (Node*) calloc ( 1, sizeof ( Node ) ); Root1 -> name = "";
		Root2 = (Node*) calloc ( 1, sizeof ( Node ) ); Root2 -> name = "";
		if ( readHindex ( ind1, Root1, name, hError, strings ) )
			return 1;
		hError = false;
		if ( readHindex ( ind2, Root2, name, hError, strings ) )
			return 1;
	}

	hError = false;
	error_count += WalkTree ( Root1 -> child, Root2 -> child, name, name, keyId, itemsize, second, b1, b2, 1, hError, strings );
	if (hError) error_count++;
	hError = false;
	error_count += WalkTree ( Root2 -> child, Root1 -> child, name, name, keyId, itemsize, second, b2, b1, 2, hError, strings );
	if (hError) error_count++;

	DelTr ( Root1 );
	DelTr ( Root2 );

	return error_count ;
}

static int RunCompare ( char *s1, char *s2, char* name, int keyId, int itemsize, int second, Base *b1, Base *b2, bool &hError, std::vector<std::string> *strings )
{
	int error_count = 0;

	H_OPEN_STREAM ( s1,1,0 );
	H_OPEN_STREAM ( s2,2,0 );

	if ( str1 -> Length ( ) % itemsize ) {
		mpcxc_printfwin (strings, "Data for the key " );
		printValue (s1, KV_ASCIIZ, ind1, strings );
		mpcxc_printfwin (strings, " in base 1 is invalid\n" );
		ERROR_MPCXC;
	} else if ( str2 -> Length ( ) % itemsize ) {
		mpcxc_printfwin (strings, "Data for the key " );
		printValue (s2, KV_ASCIIZ, ind2, strings );
		mpcxc_printfwin (strings, " in base 2 is invalid\n" );
		ERROR_MPCXC;
	} else if ( str2 -> Length ( ) != str1 -> Length ( ) ) {
		mpcxc_printfwin (strings, "\nLength of data for the key " );
		printValue (s1, KV_ASCIIZ, ind1, strings );
		mpcxc_printfwin (strings, " in hindex %s mismatch (%ld, %ld)\n", name, str1 -> Length ( ), str2 -> Length ( ) );
		ERROR_MPCXC;
	} //else

	if ( checkCollections ( name, s1, s2, str1, str2, itemsize, strings ) )
		ERROR_MPCXC;

	ind1 -> Close ( str1 );
	ind2 -> Close ( str2 );

// now check second streams.

	if ( second )
	{
		H_OPEN_STREAM ( s1,1,1 );
		H_OPEN_STREAM ( s2,2,1 );

		int len1 = str1 -> Length ( );
		int len2 = str2 -> Length ( );
		int len = std::min ( len1, len2 );

		char *buf1 = (char*) malloc ( len1 );
		char *buf2 = (char*) malloc ( len2 );
		str1 -> Read ( buf1, len1 );
		str2 -> Read ( buf2, len2 );

		if ( len1 != len2 ){
			mpcxc_printfwin (strings, "\n(second stream) Length of data for the key\n" );
			printValue (s1, KV_ASCIIZ, ind1, strings );
			mpcxc_printfwin (strings, " in hindex %s mismatch (%ld, %ld)\n", name, len1, len2 );

			DiffStrSet ( buf1, len1, buf2, len2, strings );
			ERROR_MPCXC;
		} else if ( CheckStrSet ( buf1, buf2, len1, strings ) ) {
			mpcxc_printfwin (strings, "mismatch of data in hindex '%s', key '%s', stream1\n", name, s1 );
			DiffStrSet (buf1, len1, buf2, len2, strings );
			ERROR_MPCXC;
		}
		free ( buf1 );
		free ( buf2 );
		ind1 -> Close ( str1 );
		ind2 -> Close ( str2 );
	}

	return error_count;
}

void DefaultWin16CloseProcessFunc(int)
{
}

int DefaultWin16MessageForNextFunc(void)
{
	return 1;
}

int compare_texts_n (YBase *b1, YBase *b2, char* name1, char* name2, int threads_count) {
	get_docs_in_bases (b1, b2);

	std::vector<long> diff_docs;
	std::set_difference (new_docs.begin (), new_docs.end (), old_docs.begin (), old_docs.end (), std::back_inserter (diff_docs));
	if (diff_docs.size ()) {
		fatalError = true;
		for (std::vector<long>::const_iterator diff_it = diff_docs.begin (); diff_it != diff_docs.end (); diff_it++) {
			long id = *diff_it;
			if (std::binary_search (old_docs.begin (), old_docs.end (), id)) {
				mpcxc_printfwin ( "Document %ld in base1, not in base2\n", id);
			} else {
				mpcxc_printfwin ( "Document %ld in base2, not in base1\n", id);
			}
		}
	}

	get_doc_it = new_docs.begin ();

	long ok_threads = 0;
	for (long parts = 0; parts < threads_count; parts++) {
		if (0 == thread_data [parts].base1) {
			thread_data [parts].base1 = new YBase (name1, ACE_OS_O_RDONLY);
			thread_data [parts].base1->IsOk ();
		}
		if (0 == thread_data [parts].base2) {
			thread_data [parts].base2 = new YBase (name2, ACE_OS_O_RDONLY);
			thread_data [parts].base2->IsOk ();
		}
		thread_data [parts].run  = 0;
		thread_data [parts].done = 0;
		thread_data [parts].id   = parts;

		boost::thread thread (compare_texts_thread, thread_data [parts].id);
		thread.detach ();
		ok_threads++;
	}
	for (;;) {
		long dones = 0;
		for (int thread_id = 0; thread_id < threads_count; thread_id++)
			if (thread_data [thread_id].run && thread_data [thread_id].done)
				dones++;
		if (dones == ok_threads)
			break;
		else
			ACE_OS::sleep (1);
	}

	mpcxc_printfwin ( "Checking document texts complete\n" );
	for (int thread_id = 0; thread_id < threads_count; thread_id++)
		if (thread_data [thread_id].error)
			fatalError = true;

	return 0;
}
