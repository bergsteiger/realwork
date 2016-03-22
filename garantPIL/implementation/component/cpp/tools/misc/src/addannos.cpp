#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

#include "advlog.h"

void	DelOwn( AttrKey ownKey, AttrKey preannoKey, AttrIndex* docInd, Index* index, bool& foundPre, bool hIndex = true )
{
	Stream* str = docInd->Open( &preannoKey );
	if ( str ) {
		docInd->Close( str );
		foundPre = true;
		str = docInd->Open( &ownKey );
		if ( str ) {
			if ( hIndex ) {
				long maxlength = str->Length();
				char* annos = (char*)malloc( maxlength );
				str->Read( annos, maxlength );
				docInd->Close(str);

				char* anno = annos;
				long length = 0;
				while ( length < maxlength ) {
					char* pPrevLevel = 0;
					long len = strlen( anno ) + 1;
					char* savedanno = anno;
					do {
						str = index->Open( anno );
						DocCollection aDocs;
						aDocs.Get( str );
						aDocs.Del( ownKey.DocId );
						str->Seek( 0 );
						aDocs.Put( str );
						str->Trunc();
						index->Close( str );
						pPrevLevel = strrchr( anno, '\\' );
						if ( pPrevLevel ) *pPrevLevel = '\x0';
					} while ( pPrevLevel );
					anno = savedanno + len;
					length += len;
				}							
				free( annos );
				docInd->Del( ownKey.DocId, ownKey.AttrTag );
			} else {
				date annoDate;
				str->Read( &annoDate, sizeof( date ));
				docInd->Close(str);

				str = index->Open( &annoDate );
				if ( str ) {
					DocCollection aDocs;
					aDocs.Get( str );
					aDocs.Del( ownKey.DocId );
					if ( aDocs.ItemCount ) {
						str->Seek( 0 );
						aDocs.Put( str );
						str->Trunc();
						index->Close( str );
					} else {
						index->Close( str );
						index->Delete( &annoDate );
					}
				}
				docInd->Del( ownKey.DocId, ownKey.AttrTag );
			}
		}
	}
}

void	AddOwn( AttrKey ownKey, AttrKey preannoKey, AttrIndex* docInd, Index* index )
{
	Stream* str = docInd->Open( &preannoKey );
	if ( str ) {
		long maxlength = str->Length();
		char* annos = (char*) malloc( maxlength );
		str->Read( annos, maxlength );
		char* anno = annos;
		long length = 0;
		while ( length < maxlength ) {
			char* pPrevLevel = 0;
			long len = strlen( anno ) + 1;
			char* savedanno = anno;
			do {
				int iCreated = 0;
				Stream *str = index->Open( anno, 1, &iCreated );
				DocCollection aDocs;
				aDocs.Get( str );
				aDocs.Add( ownKey.DocId );
				str->Seek( 0 );
				aDocs.Put( str );
				index->Close( str );
				pPrevLevel = strrchr( anno, '\\' );
				if ( pPrevLevel ) *pPrevLevel = '\x0';
			} while ( pPrevLevel );
			anno = savedanno + len;
			length += len;
		}
		str->Seek(0);
		str->Read( annos, maxlength );
		docInd->Close(str);
		docInd->Del( preannoKey.DocId, preannoKey.AttrTag );
		docInd->Put( ownKey.DocId, ownKey.AttrTag, annos, maxlength );
		free(annos);
	}
}

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
	Index* annoDateIndex = aBase->FindIndex( "AnnoDate" );
	HIndex* cidxAnnoUser = (HIndex*) aBase->FindIndex( "AnnoUser" );
	HIndex* cidxAnnoOrganization = (HIndex*) aBase->FindIndex( "AnnoOrganization" );
	HIndex* cidxAnnoTax = (HIndex*) aBase->FindIndex( "AnnoTax" );
	HIndex* cidxAnnoInterest = (HIndex*) aBase->FindIndex( "AnnoInterest" );
	HIndex* cidxAnnoKind = (HIndex*) aBase->FindIndex( "AnnoKind" );

	DocCollection toDelete;
	DocCollection add_significant, del_significant;

	AttrKey aKey = { ID_BORDER, IDD_INFO };
	BTIterator* it = new BTIterator( docInd, &aKey );
	for ( ; !it->End (); ++(*it) ) {
		AttrKey *ptr = (AttrKey*) it->Key();

		if ( ptr -> AttrTag != IDD_INFO )
			break;

		Stream* str = docInd->Open( ptr );
		if ( !str )
			continue;

		DocInfo docInfo;
		str->Read( &docInfo, sizeof( docInfo ));
		docInd->Close(str);
		if (!(docInfo.Status & DS_ANNO))
			continue;

		long docId = ptr->DocId;
		mpcxc_printfwin( "%ld ", docId );
		long ownTopic = GetDocMonitoring(&docInfo);

		DocInfo ownDocInfo;
		if ( aBase->FindDocAttr( ownTopic, IDD_INFO, &ownDocInfo, sizeof( DocInfo )) != sizeof( DocInfo )) {
			mpcxc_printfwin( "bad! ƒокумент, к которому написана аннотаци€, отсутствует\n" );
			toDelete.Add( docId );
		} else 
		if ( ( ownDocInfo.Status & (DS_NODOC | DS_EDITION )) && ownTopic != 105 + ID_BORDER ) {
			mpcxc_printfwin( "bad! јннотаци€ не может быть у EDITION и NODOC\n" );
			toDelete.Add( docId );
		} else {
			long fromOwn = GetDocMonitoring( &ownDocInfo );
			if ( fromOwn ) {
				bool foundPre = false;
				if ( ownTopic != 100105 ) {
					//у аннотации могли помен€ть реквизиты
					AttrKey	preannoKey = { docId, IDD_PREANNODATE };
					AttrKey ownKey = { ownTopic, IDD_ANNODATE };
					DelOwn( ownKey, preannoKey, docInd, annoDateIndex, foundPre, false );
					ownKey.AttrTag = IDD_ANNOUSER;         preannoKey.AttrTag = IDD_PREANNOUSER;         DelOwn( ownKey, preannoKey, docInd, cidxAnnoUser,         foundPre );
					ownKey.AttrTag = IDD_ANNOORGANIZATION; preannoKey.AttrTag = IDD_PREANNOORGANIZATION; DelOwn( ownKey, preannoKey, docInd, cidxAnnoOrganization, foundPre );
					ownKey.AttrTag = IDD_ANNOTAX;          preannoKey.AttrTag = IDD_PREANNOTAX;          DelOwn( ownKey, preannoKey, docInd, cidxAnnoTax,          foundPre );
					ownKey.AttrTag = IDD_ANNOINTEREST;     preannoKey.AttrTag = IDD_PREANNOINTEREST;     DelOwn( ownKey, preannoKey, docInd, cidxAnnoInterest,     foundPre );
					ownKey.AttrTag = IDD_ANNOKIND;         preannoKey.AttrTag = IDD_PREANNOKIND;         DelOwn( ownKey, preannoKey, docInd, cidxAnnoKind,         foundPre );
				}
				if ( !foundPre ) {
					short annoBelongs = ANNO_SEGMENT;
					docInd->Replace( docId, IDD_BASES, &annoBelongs, sizeof( short ));
					mpcxc_printfwin( "skip \n" );
					continue;
				}
			}

			//собственно у документа еще нет аннотации, т.е. будет нова€
			mpcxc_printfwin( "%ld ", ownTopic );
			//дата AnnoDate у документа - это max( PreAnnoDate мониторинга и анонса документа)
			bool	wasPreAnno = false;
			date	preAnnoDate;
			AttrKey	preannoKey = { docId, IDD_PREANNODATE };
			str = docInd->Open( &preannoKey );
			if ( str ) {
				str->Read( &preAnnoDate, sizeof( date ));
				docInd->Close( str );
				wasPreAnno = true;
			}

			AttrKey	anonceKey = { ownTopic, IDD_VANONCED };
			bool	wasAnonce = false;
			date	anonceDate;
			str = docInd->Open( &anonceKey );
			if ( str ) {
				str->Read( &anonceDate, sizeof( date ));
				docInd->Close( str );
				wasAnonce = true;
			}
			if ( !wasAnonce ) {
				anonceKey.AttrTag = IDD_VINCLUDED;
				str = docInd->Open( &anonceKey );
				if ( str ) {
					str->Read( &anonceDate, sizeof( date ));
					docInd->Close( str );
					wasAnonce = true;
				}
			}

			if ( !wasPreAnno && !wasAnonce ) {
				mpcxc_printfwin( "bad! Ќет !ANNODATE и !VANONCED\n" );
				toDelete.Add( docId );
				continue;
			}

			mpcxc_printfwin( "good\n" );

			if (docInfo.Status_ex & DS_SIGNIFICANT) {
				add_significant.Add (ownTopic);
				docInfo.Status_ex &= ~DS_SIGNIFICANT;
				docInd->Replace (docId, IDD_INFO, &docInfo, sizeof (docInfo));
				ownDocInfo.Status_ex |= DS_SIGNIFICANT;
			} else {
				del_significant.Add (ownTopic);
				ownDocInfo.Status_ex &= ~DS_SIGNIFICANT;
			}

			date	annoDate;
			if ( wasPreAnno & wasAnonce ) {
				if ( CompDates( &preAnnoDate, &anonceDate ) > 0 )
					annoDate = preAnnoDate;
				else
					annoDate = anonceDate;
			} else
			if ( wasPreAnno )
				annoDate = preAnnoDate;
			else
				annoDate = anonceDate;

			{
			//если у документа есть  какой-то annodate, то надо его вычистить из индекса
			AttrKey ownDate = { ownTopic, IDD_ANNODATE };
			bool foundPre;
			DelOwn( ownDate, ownDate, docInd, annoDateIndex, foundPre, false );
			}

			docInd->Replace( ownTopic, IDD_ANNODATE, &annoDate, sizeof( annoDate ));
			int	iCreated = 0;
			str = annoDateIndex->Open( &annoDate, 1, &iCreated );
			if ( str ) {
				DocCollection aDocs;
				aDocs.Get( str );
				aDocs.Add( ownTopic );
				str->Seek( 0 );
				aDocs.Put( str );
				annoDateIndex->Close( str );
			}
			if ( wasPreAnno ) docInd->Del( docId, IDD_PREANNODATE );

			// belongs аннотации равен белонгсу сегмента_аннотаций
			short annoBelongs = ANNO_SEGMENT;
			docInd->Replace( docId, IDD_BASES, &annoBelongs, sizeof( short ));

			//у ownтопика надо SetDocMonitoring
			SetDocMonitoring( &ownDocInfo, docId );
			docInd->Replace( ownTopic, IDD_INFO, &ownDocInfo, sizeof( ownDocInfo ));

			//вз€ть у аннотации все IDD_ANNO* и перекинуть их в документ
			//сформировать индексы Anno*
			AttrKey annoUser = { docId, IDD_PREANNOUSER };
			AttrKey ownUser  = { ownTopic, IDD_ANNOUSER };
			AddOwn( ownUser, annoUser, docInd, cidxAnnoUser );

			AttrKey annoOrganization = { docId, IDD_PREANNOORGANIZATION };
			AttrKey ownOrganization  = { ownTopic, IDD_ANNOORGANIZATION };
			AddOwn( ownOrganization, annoOrganization, docInd, cidxAnnoOrganization );

			AttrKey annoTax = { docId, IDD_PREANNOTAX };
			AttrKey ownTax  = { ownTopic, IDD_ANNOTAX };
			AddOwn( ownTax, annoTax, docInd, cidxAnnoTax );

			AttrKey annoInterest = { docId, IDD_PREANNOINTEREST };
			AttrKey ownInterest  = { ownTopic, IDD_ANNOINTEREST };
			AddOwn( ownInterest, annoInterest, docInd, cidxAnnoInterest );

			AttrKey annoKind = { docId, IDD_PREANNOKIND };
			AttrKey ownKind  = { ownTopic, IDD_ANNOKIND };
			AddOwn( ownKind, annoKind, docInd, cidxAnnoKind );
		}
	}

	for ( int i = 0; i < toDelete.ItemCount; i++ )
		aBase->DelDoc( toDelete[ i ] );
	{
	unsigned short status = DS_NODOC;
	Stream *str = aBase->FindIndex ("Status")->Open (&status);
	if (str) {
		DocCollection nodocs;
		nodocs.Get (str);
		nodocs.Minus (toDelete);
		if (nodocs.ItemCount) {
			str->Seek (0);
			nodocs.Put (str);
			str->Trunc ();
			aBase->FindIndex ("Status")->Close (str);
		} else {
			aBase->FindIndex ("Status")->Close (str);
			aBase->FindIndex ("Status")->Delete (&status);
		}
	}
	status = DS_ANNO;
	str = aBase->FindIndex ("Status")->Open (&status);
	if (str) {
		DocCollection annos;
		annos.Get (str);
		annos.Minus (toDelete);
		if (annos.ItemCount) {
			str->Seek (0);
			annos.Put (str);
			str->Trunc ();
			aBase->FindIndex ("Status")->Close (str);
		} else {
			aBase->FindIndex ("Status")->Close (str);
			aBase->FindIndex ("Status")->Delete (&status);
		}
	}
	status = DS_SIGNIFICANT;
	str = aBase->FindIndex ("Status_ex")->Open (&status);
	if (str) {
		RefCollection refs;
		refs.Get (str);
		refs.Minus (del_significant);
		refs.Merge (add_significant);
		if (refs.ItemCount) {
			str->Seek (0);
			refs.Put (str);
			str->Trunc ();
			aBase->FindIndex ("Status_ex")->Close (str);
		} else {
			aBase->FindIndex ("Status_ex")->Close (str);
			aBase->FindIndex ("Status_ex")->Delete (&status);
		}
	}

	}


	mpcxc_printfwin( "\n" );

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




