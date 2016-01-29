
#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

#include "../../gctools/src/cacheIndex.cpp"

#include "advlog.h"

int main_logic ( int argc, char *argv[] );

bool	b_recode = true;

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

	short tags[] = {IDD_ANNODATE, IDD_ANNOUSER, IDD_ANNOORGANIZATION, IDD_ANNOTAX, IDD_ANNOINTEREST, IDD_ANNOKIND};

	if (!strcmp (argv [1], "-copy")) {
		YBase *source = new YBase (argv [2], ACE_OS_O_RDONLY); source->IsOk ();
		source->open_saw_bases (ACE_OS_O_RDONLY);
		
		StdBigBase *target = new StdBigBase (argv [3], ACE_OS_O_RDWR);
		target->open_saw_bases (ACE_OS_O_RDWR);
		for (std::vector<Base*>::const_iterator base_it = source->bases_ptrs.begin (); base_it != source->bases_ptrs.end (); base_it++) {
			for (int tag_it = 0; tag_it < sizeof (tags) / sizeof (short); tag_it++) {
				short tag = tags [tag_it];
				AttrKey attrkey = {ID_BORDER, tag};
				for (BTIterator it((*base_it)->FindIndex ("Attrs"), &attrkey); !it.End (); ++it) {
					AttrKey* key = (AttrKey*) it.Key ();
					if (key->AttrTag != tag)
						break;
					long size;
					void* data = (*base_it)->LoadAttr (key->DocId, tag, size);
					target->ReplaceAttr (key->DocId, tag, data, size);
					gk_free (data);
				}
			}
		}

		target->close_saw_bases ();
		delete target;
		source->close_saw_bases ();
		delete source;

		exit (EXIT_SUCCESS);
	}

	YBase* aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	aBase->open_saw_bases (ACE_OS_O_RDWR);

	Index* annoDateIndex = aBase->FindIndex( "AnnoDate" );
	CIdxAdopted *cidxAnnoUser = new CIdxAdopted( (HIndex*) aBase->FindIndex( "AnnoUser" ));
	CIdxAdopted *cidxAnnoOrganization = new CIdxAdopted( (HIndex*) aBase->FindIndex( "AnnoOrganization" ));
	CIdxAdopted *cidxAnnoTax = new CIdxAdopted( (HIndex*) aBase->FindIndex( "AnnoTax" ));
	CIdxAdopted *cidxAnnoInterest = new CIdxAdopted( (HIndex*) aBase->FindIndex( "AnnoInterest" ));
	CIdxAdopted *cidxAnnoKind = new CIdxAdopted( (HIndex*) aBase->FindIndex( "AnnoKind" ));

	std::set<long> docs_with_annodate, docs_with_annouser, docs_with_annoorg, docs_with_annotax, docs_with_annointerest, docs_with_annokind;

	DocCollection toDelete;

	for (std::vector<Base*>::const_iterator base_it = aBase->bases_ptrs.begin (); base_it != aBase->bases_ptrs.end (); base_it++) {
		AttrIndex* docInd = (AttrIndex*) (*base_it)->FindIndex( "Attrs" );

		AttrKey aKey = { ID_BORDER, IDD_INFO };
		BTIterator* it = new BTIterator (docInd);
		it->Set (&aKey);
		for ( ; !it->End (); ++(*it) ) {
			AttrKey *ptr = (AttrKey*) it->Key();

			if ( ptr -> AttrTag != IDD_INFO )
				break;

			Stream* str = docInd->Open (ptr);
			if ( !str )
				continue;

			DocInfo docInfo;
			str->Read( &docInfo, sizeof( docInfo ));
			docInd->Close(str);
			if ( ! ( docInfo.Status & DS_ANNO ))
				continue;

			long docId = ptr->DocId;
			mpcxc_printfwin( "%ld ", docId );
			long ownTopic = GetDocMonitoring(&docInfo);

			DocInfo ownDocInfo;
			if ( (*base_it)->FindDocAttr( ownTopic, IDD_INFO, &ownDocInfo, sizeof( DocInfo )) != sizeof( DocInfo )) {
				mpcxc_printfwin( "bad! Документ, к которому написана аннотация, отсутствует\n" );
				toDelete.Add( docId );
			} else 
			if ( ( ownDocInfo.Status & (DS_NODOC | DS_EDITION )) && ownTopic != 105 + ID_BORDER ) {
				mpcxc_printfwin( "bad! Аннотация не может быть у EDITION и NODOC\n" );
				toDelete.Add( docId );
			} else {
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
					mpcxc_printfwin( "bad! Нет !ANNODATE и !VANONCED\n" );
					toDelete.Add( docId );
					continue;
				}

				mpcxc_printfwin( "good\n" );

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

				aBase->ReplaceAttr (ownTopic, IDD_ANNODATE, &annoDate, sizeof( annoDate ));
				docs_with_annodate.insert (ownTopic);

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
				aBase->ReplaceAttr (ownTopic, IDD_INFO, &ownDocInfo, sizeof( ownDocInfo ));

				//взять у аннотации все IDD_ANNO* и перекинуть их в документ
				//сформировать индексы Anno*
				AttrKey annoUser = { docId, IDD_PREANNOUSER };
				str = docInd->Open( &annoUser );
				if ( str ) {
					long maxlength = str->Length();
					char* annos = (char*) malloc( maxlength );
					str->Read( annos, maxlength );
					char* anno = annos;
					long length = 0;
					while ( length < maxlength ) {
						long len = strlen( anno ) + 1;
					#ifdef	WINENCODE
						Recoding( cd_win, cd_dos, anno );
					#endif
						cidxAnnoUser->add(anno,len-1,ownTopic);
					#ifdef	WINENCODE
						Recoding( cd_dos, cd_win, anno );
					#endif
						anno += len;
						length += len;
					}
					docInd->Close(str);
					docInd->Del( docId, IDD_PREANNOUSER );
					aBase->ReplaceAttr (ownTopic, IDD_ANNOUSER, annos, maxlength);
					docs_with_annouser.insert (ownTopic);				
				}

				AttrKey annoOrganization = { docId, IDD_PREANNOORGANIZATION };
				str = docInd->Open( &annoOrganization );
				if ( str ) {
					long maxlength = str->Length();
					char* annos = (char*) malloc( maxlength );
					str->Read( annos, maxlength );
					char* anno = annos;
					long length = 0;
					while ( length < maxlength ) {
						long len = strlen( anno ) + 1;
					#ifdef	WINENCODE
						Recoding( cd_win, cd_dos, anno );
					#endif
						cidxAnnoOrganization->add(anno,len-1,ownTopic);
					#ifdef	WINENCODE
						Recoding( cd_dos, cd_win, anno );
					#endif
						anno += len;
						length += len;
					}
					docInd->Close(str);
					docInd->Del( docId, IDD_PREANNOORGANIZATION );
					aBase->ReplaceAttr (ownTopic, IDD_ANNOORGANIZATION, annos, maxlength);
					docs_with_annoorg.insert (ownTopic);
				}

				AttrKey annoTax = { docId, IDD_PREANNOTAX };
				str = docInd->Open( &annoTax );
				if ( str ) {
					long maxlength = str->Length();
					char* annos = (char*) malloc( maxlength );
					str->Read( annos, maxlength );
					char* anno = annos;
					long length = 0;
					while ( length < maxlength ) {
						long len = strlen( anno ) + 1;
					#ifdef	WINENCODE
						Recoding( cd_win, cd_dos, anno );
					#endif
						cidxAnnoTax->add(anno,len-1,ownTopic);
					#ifdef	WINENCODE
						Recoding( cd_dos, cd_win, anno );
					#endif
						anno += len;
						length += len;
					}
					docInd->Close(str);
					docInd->Del( docId, IDD_PREANNOTAX );
					aBase->ReplaceAttr (ownTopic, IDD_ANNOTAX, annos, maxlength);
					docs_with_annotax.insert (ownTopic);
				}

				AttrKey annoInterest = { docId, IDD_PREANNOINTEREST };
				str = docInd->Open( &annoInterest );
				if ( str ) {
					long maxlength = str->Length();
					char* annos = (char*) malloc( maxlength );
					str->Read( annos, maxlength );
					char* anno = annos;
					long length = 0;
					while ( length < maxlength ) {
						long len = strlen( anno ) + 1;
					#ifdef	WINENCODE
						Recoding( cd_win, cd_dos, anno );
					#endif
						cidxAnnoInterest->add(anno,len-1,ownTopic);
					#ifdef	WINENCODE
						Recoding( cd_dos, cd_win, anno );
					#endif
						anno += len;
						length += len;
					}
					docInd->Close(str);
					docInd->Del( docId, IDD_PREANNOINTEREST );
					aBase->ReplaceAttr (ownTopic, IDD_ANNOINTEREST, annos, maxlength);
					docs_with_annointerest.insert (ownTopic);
				}

				AttrKey annoKind = { docId, IDD_PREANNOKIND };
				str = docInd->Open( &annoKind );
				if ( str ) {
					long maxlength = str->Length();
					char* annos = (char*) malloc( maxlength );
					str->Read( annos, maxlength );
					char* anno = annos;
					long length = 0;
					while ( length < maxlength ) {
						long len = strlen( anno ) + 1;
					#ifdef	WINENCODE
						Recoding( cd_win, cd_dos, anno );
					#endif
						cidxAnnoKind->add(anno,len-1,ownTopic);
					#ifdef	WINENCODE
						Recoding( cd_dos, cd_win, anno );
					#endif
						anno += len;
						length += len;
					}
					docInd->Close(str);
					docInd->Del( docId, IDD_PREANNOKIND );
					aBase->ReplaceAttr (ownTopic, IDD_ANNOKIND, annos, maxlength);
					docs_with_annokind.insert (ownTopic);
				}
			}
		}
	}

	for ( int i = 0; i < toDelete.ItemCount; i++ ) {
		long id = toDelete [i];
		aBase->base_for_doc (id)->DelDoc (id);
	}
	{
	short status = DS_NODOC;
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
	}

	delete cidxAnnoUser;
	delete cidxAnnoOrganization;
	delete cidxAnnoTax;
	delete cidxAnnoInterest;
	delete cidxAnnoKind;

	mpcxc_printfwin( "\n" );

	if (argc > 2 && !strcmp (argv [2], "-check")) {
		short tags[] = {IDD_ANNODATE, IDD_ANNOUSER, IDD_ANNOORGANIZATION, IDD_ANNOTAX, IDD_ANNOINTEREST, IDD_ANNOKIND};
		std::set<long> docs_in_base;
		for (std::vector<Base*>::const_iterator base_it = aBase->bases_ptrs.begin (); base_it != aBase->bases_ptrs.end (); base_it++) {
			for (int tag_it = 0; tag_it < sizeof (tags) / sizeof (short); tag_it++) {
				short tag = tags [tag_it];
				AttrKey attrkey = {ID_BORDER, tag};
				for (BTIterator it((*base_it)->FindIndex ("Attrs"), &attrkey); !it.End (); ++it) {
					AttrKey* key = (AttrKey*) it.Key ();
					if (key->AttrTag != tag)
						break;
					docs_in_base.insert (key->DocId);
				}
				std::deque <long> docs_to_delete;
				switch (tag) {
					case IDD_ANNODATE:
						std::set_difference  (docs_in_base.begin (), docs_in_base.end (), docs_with_annodate.begin (), docs_with_annodate.end (), std::back_inserter (docs_to_delete));
						break;
					case IDD_ANNOUSER:
						std::set_difference  (docs_in_base.begin (), docs_in_base.end (), docs_with_annouser.begin (), docs_with_annouser.end (), std::back_inserter (docs_to_delete));
						break;
					case IDD_ANNOORGANIZATION:
						std::set_difference  (docs_in_base.begin (), docs_in_base.end (), docs_with_annoorg.begin (), docs_with_annoorg.end (), std::back_inserter (docs_to_delete));
						break;
					case IDD_ANNOTAX:
						std::set_difference  (docs_in_base.begin (), docs_in_base.end (), docs_with_annotax.begin (), docs_with_annotax.end (), std::back_inserter (docs_to_delete));
						break;
					case IDD_ANNOINTEREST:
						std::set_difference  (docs_in_base.begin (), docs_in_base.end (), docs_with_annointerest.begin (), docs_with_annointerest.end (), std::back_inserter (docs_to_delete));
						break;
					case IDD_ANNOKIND:
						std::set_difference  (docs_in_base.begin (), docs_in_base.end (), docs_with_annokind.begin (), docs_with_annokind.end (), std::back_inserter (docs_to_delete));
						break;
				}
				for (std::deque<long>::const_iterator it = docs_to_delete.begin (); it != docs_to_delete.end (); it++) {
					mpcxc_printfwin( "del %ld.%ld\n", *it, tag );
					(*base_it)->DelAttr (*it, tag);
				}
			}
		}
	}

	aBase->close_saw_bases ();
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
