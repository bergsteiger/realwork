#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <fstream.h>

#include "osdep.h"

#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

#include "long.SplaySet.h"

int usage ( char *str )
{
	fprintf ( stderr, "Usage: %s <base> <filename>\n", str);
	fprintf ( stderr, "\t<base>: current base\n");
	fprintf ( stderr, "\t<filename>: output filename.\n");
	return 0;
}

void	RemoveAbsents( RefCollection *aRefs, Base* aBase )
{
	for ( long i = 0; i < aRefs->ItemCount; )
	{
		if ( aBase -> FindDoc( aRefs -> GetItem( i ).DocId ))
			i++;
		else
			aRefs -> atDelete( i );
	}
}

int main ( int argc, char **argv )
{
	fprintf ( stderr, "Garant document statistics dumper.\n" );

	if ( argc < 3 )
	       return usage ( argv [0] );

	Base * base = new YBase ( argv [1], ACE_OS_O_RDONLY );

	if ( !base || !base -> IsOk ( ) )
	{
		fprintf ( stderr, "Base %s not ok.\n", argv [1] );
		return usage ( argv [0] );
	}

	BTIterator it( base -> docInd );
	double key_count_step = base -> docInd -> KeyCount / 100;
	double count = 0;
	longSplaySet docIDs;

	int perc = 0;
	printf("Collecting documents' information... %ld%% \r",perc);
	for (count=0 ; !it.End ( ); count += 1)
	{
		if ((int)(count / key_count_step) != perc)
				printf("Collecting documents' information... %ld%% \r",perc = (int)(count / key_count_step));
		long docID = ((AttrKey*) it.Key ( )) -> DocId;
		if ( docID > 100000 )
		{
			docIDs.add(docID);
		}
		++it;
	}

	printf("\n");

	// init source
	
	AttrKey attrKey;
	DocInfo	Info;
	Pix pix;

	attrKey.AttrTag = IDD_INFO;

	ofstream OF(argv[2],ios::out);

	DocCollection* allDocs = base -> AllDocs();

	key_count_step = docIDs.length() / 100;
	perc = 0;
	printf("Flushing documents' info... %ld%% \r",perc);
	for (pix = docIDs.first(), count=0 ; pix; docIDs.next(pix), count += 1)
	{
		if ((int)(count / key_count_step) != perc)
				printf("Flushing documents' info... %ld%% \r",perc = (int)(count / key_count_step));

		attrKey.DocId = docIDs(pix);
		Stream *str = base -> docInd -> Open ( &attrKey );
		if( !str )
		{
			printf("þ+L -+++-L -¦T (%ld, %ld).\n",attrKey.DocId, attrKey.AttrTag);
			exit( 1 );
		}       
		if( str -> Length() != sizeof(DocInfo) )
		{
			printf("ÿ-ãTT+ ã+-+TL+ +LTãT-L¦+ -¦T (%ld, %ld).\n",	attrKey.DocId, attrKey.AttrTag);
			exit( 1 );
		}
		
		if (!(str->Read(&Info, sizeof(DocInfo)) == sizeof(DocInfo)))
		{
			printf("ÿ-ãTT+ ¦L++ãT ã+-+TL+.\n");
			exit(1);
		}

		if (Info.Status & DS_DOC)
		{
			OF << "| " << (attrKey.DocId - 100000) << "\t| " << Info.HyperRefs << "\t| " << Info.GreenComments << "\t| ";

			Stream * resp_str = base->FindIndex("Respondent")->Open(&attrKey.DocId);
			if (resp_str)
			{
				RefCollection aRefs;
				aRefs.Get( resp_str );
				aRefs.ReduceRefsBySub( base );			
				//RemoveAbsents( &aRefs, base );
				aRefs.Intersect(*allDocs);
				OF << aRefs.ItemCount << "\t| ";

				//OF << (resp_str->Length()/sizeof(Ref)) << "\t| ";

				base->FindIndex("Respondent")->Close(resp_str);
			}
			else OF << "0\t| ";

			Stream * corr_str = base->FindIndex("Correspondent")->Open(&attrKey.DocId);
			if (corr_str)
			{
				RefCollection aRefs;
				aRefs.Get( corr_str );
				//RemoveAbsents( &aRefs, base );
				aRefs.Intersect( *allDocs );
				OF << aRefs.ItemCount << "\t| ";

				//OF << (corr_str->Length()/sizeof(Ref)) << "\t| ";

				base->FindIndex("Correspondent")->Close(corr_str);
			}
			else OF << "0\t| ";

			OF << endl << flush;
		}
		
		base -> docInd -> Close ( str );

		// Flush Info.
	}

	return 0;
}



