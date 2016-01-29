#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

#include "SplaySet.h"

#include "advlog.h"

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	StdBigBase* aBase = new StdBigBase( argv[ 1 ], ACE_OS_O_RDWR );
	AttrIndex* docInd = (AttrIndex*) aBase->FindIndex( "Attrs" );

	Stream *hereStr = aBase->FindIndex("Aux")->Open("Here");
	short hcount = hereStr->Length()/sizeof(short);
	short* heres = (short*)malloc(hereStr->Length());
	hereStr->Read(heres, hereStr->Length());
	aBase->FindIndex("Aux")->Close(hereStr);

	BaseInfo* bInfos = new BaseInfo [400];
	BaseInfo* newbInfos = new BaseInfo [400];

	std::set<long> splash_topics, banner_topics;

	short i;
	for ( i = 0; i < hcount; i++ ) {
		short segId = heres[i];
		if (segId > 399)
			continue;

		aBase->FindBaseInfo( segId, bInfos[ segId ] );
		if (bInfos [segId].BannerTopic)
			banner_topics.insert (bInfos [segId].BannerTopic);
		if (bInfos [segId].SplashTopic)
			splash_topics.insert (bInfos [segId].SplashTopic);

		memcpy (&newbInfos[ segId ], &bInfos[ segId ], sizeof (BaseInfo));
		newbInfos[ segId ].DocCount = 0;
		newbInfos[ segId ].DocSize  = 0;
		newbInfos[ segId ].CommonDocCount = 0;
		newbInfos[ segId ].CommonDocSize  = 0;
		newbInfos[ segId ].RecCount = 0;
		newbInfos[ segId ].RecSize  = 0;
		newbInfos[ segId ].HyperRefs = 0;
		newbInfos[ segId ].GreenComments = 0;
		newbInfos[ segId ].FormsCount = 0;
	}

	short	seg_buff[1024];

	static const AttrKey key = { ID_BORDER, IDD_INFO };
	BTIterator* it = new BTIterator( docInd, &key );
	for ( ; !it->End (); ++(*it) ) {
		AttrKey * ptr = (AttrKey *) it->Key();
		if ( ptr -> AttrTag == IDD_INFO ) {
			long docId = ptr->DocId;
			//mpcxc_printfwin( "%ld\r", docId );
			Stream *str = docInd->Open( ptr );
			if ( str ) {
				DocInfo docInfo;
				str->Read( &docInfo, sizeof( DocInfo ));
				docInd->Close(str);

				short seg_size = aBase->FindDocAttr( docId,IDD_BASES,seg_buff,sizeof (seg_buff)) / sizeof( short );
				for ( short i= 0; i < seg_size; i++) {
					short segId = seg_buff[ i ];
					if ( segId > 299)
						continue;
					if ((docInfo.Status & DS_DOC) || (docInfo.Status_ex & (DS_FLASH | DS_MEDTOPIC))) {
						newbInfos[ segId ].CommonDocCount++;
						newbInfos[ segId ].CommonDocSize += docInfo.Size;
					}
					newbInfos [segId].RecCount++;
					newbInfos [segId].RecSize += docInfo.Size;
					newbInfos [segId].GreenComments += docInfo.GreenComments;
					newbInfos [segId].HyperRefs += docInfo.HyperRefs;

					if (!newbInfos [segId].SplashTopic && splash_topics.find (docId) != splash_topics.end ())
						newbInfos [segId].SplashTopic = docId;
					if (!newbInfos [segId].BannerTopic && banner_topics.find (docId) != banner_topics.end ())
						newbInfos [segId].BannerTopic = docId;
				}
			}
		} else {
			//mpcxc_printfwin( "\n" );
			break;
		}
	}
	delete it;

	Index* blobs = aBase->FindIndex ("Blob");
	it = new BTIterator (blobs);
	ObjInfo objinfo;
	for (; !it->End (); ++(*it)) {
		long id = *(long*) it->Key ();
		//mpcxc_printfwin( "%ld\r", id);
		if (id < DOC_TIP_OF_THE_DAY_LOW || id > DOC_TIP_OF_THE_DAY_HI) {
			Stream *str = blobs->OpenN (&id, 0);
			if (str) {
				str->Read (&objinfo, sizeof (ObjInfo));
				blobs->Close (str);
				if (objinfo.type == EOT_XLS || objinfo.type == EOT_RTF) {
					str = blobs->OpenN (&id, 1);
					if (str) {
						long count = str->Length () / 2;
						short *segs = new short [count];
						str->Read (segs, str->Length ());
						blobs->Close (str);
						for (int i = 0; i < count; i++)
							newbInfos [segs [i]].FormsCount++;
						delete segs;
					}					
				}
			}
		}
	}
	//mpcxc_printfwin ("\n");
	delete it;

	for ( i = 0; i < hcount; i++ ) {
		short segId = heres[i];
		if (segId >299)
			continue;
		aBase->ReplaceBaseInfo( segId, &newbInfos[ segId ] );
	}
	
	delete aBase;

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



