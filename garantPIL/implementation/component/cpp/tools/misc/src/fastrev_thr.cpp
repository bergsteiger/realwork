#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "basemask.h"
#include "StorableSplaySet.h"
#include "pack.h"
#include "UpdtMorph.h"

#include <map>
#include <vector>
#include <algorithm>
#include <boost/thread.hpp>

static int sstrcmp( const void *s1, const void *s2 )
{
	char **p1 = (char**) s1;
	char **p2 = (char**) s2;
	return strcmp( *p1, *p2 );
}

static int CheckStrSet( char *buf1, char *buf2, u_int32_t len )
{
	u_int32_t c1 = 0, c2 = 0;
	u_int32_t i, i1, i2;

	for ( i = 0; i < len; i++ )	{
		if ( !buf1[i] ) c1++;
		if ( !buf2[i] ) c2++;
	}

	if ( c1 != c2 )
		return 1;

	u_int32_t c = c1;

	char **p1 = (char**) malloc( c * sizeof(char*) );
	char **p2 = (char**) malloc( c * sizeof(char*) );

	p1[0] = (char*) buf1;
	p2[0] = (char*) buf2;

	for ( i = i1 = i2 = 1; i < len - 1; i++ ) {
		if ( !buf1 [i] ) p1 [i1++] = (char*) (&(buf1 [i+1]));
		if ( !buf2 [i] ) p2 [i2++] = (char*) (&(buf2 [i+1]));
	}

	qsort( p1, c, sizeof ( char* ), sstrcmp );
	qsort( p2, c, sizeof ( char* ), sstrcmp );

	int res = 0;
	for ( i = 0; i < c; i++ ) {
		res = strcmp ( p1 [i], p2 [i] );
		if ( res ) break;
	}

	free ( p1 );
	free ( p2 );
	return res;
}

static int datecmp( const void *d1, const void *d2 )
{
	return memcmp( d1, d2, sizeof( date ) );
}

int CheckDateSet( char *buf1, char *buf2, u_int32_t len )
{
	qsort( buf1, len / sizeof( date ), sizeof( date ), datecmp );
	qsort( buf2, len / sizeof( date ), sizeof( date ), datecmp );
	return memcmp( buf1, buf2, len );
}

int CheckSubSet( char *buf1, char *buf2, u_int32_t len )
{
	//qsort( buf1, len / sizeof( SubDesc ), sizeof( SubDesc ), compare_subdesc );
	//qsort( buf2, len / sizeof( SubDesc ), sizeof( SubDesc ), compare_subdesc );
	return memcmp( buf1, buf2, len );
}

int DocInfoCmp (DocInfo *a, DocInfo *b)
{
	int res = strcmp ( a->Title, b->Title );
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

int StrRev( char * pStr, revision& theRev )
{	
	if ( !strcmp( pStr, "cur" ) ) {
		struct tm *tmCur;        
		time_t lTime;
		time( &lTime );
		tmCur = localtime( &lTime );
		if ( !tmCur ) return 0;

		theRev.RevisionDate.da_day = tmCur->tm_mday;
		theRev.RevisionDate.da_mon = tmCur->tm_mon + 1;
		theRev.RevisionDate.da_year = tmCur->tm_year + 1900;
		theRev.RevisionTime.ti_min = tmCur->tm_min;
		theRev.RevisionTime.ti_hour = tmCur->tm_hour;
	} else {
		unsigned short day = 0, month = 0, year = 0, hour = 0, min = 0;
		day = atol (pStr);
		pStr = strchr (pStr, '/');
		if (pStr) {			
			month = atol (++pStr);
			pStr = strchr (pStr, '/');
			if (pStr) {
				year = atol (++pStr);
				pStr = strchr (pStr, ':');
				if (pStr) {
					hour = atol (++pStr);
					pStr = strchr (pStr, ':');
					if (pStr)
						min = atol (++pStr);
				}
			}
		}
		if ( day > 31 || month > 12 || day == 0 || month == 0) return 0;
		if ( year < 100 ) year += 2000;
		if ( hour > 23 || min > 59 ) return 0;
		
		theRev.RevisionDate.da_day = (unsigned char)day;
		theRev.RevisionDate.da_mon = (unsigned char)month;
		theRev.RevisionDate.da_year = year;
		theRev.RevisionTime.ti_min = (unsigned char)min;
		theRev.RevisionTime.ti_hour = (unsigned char)hour;
	}

	return 1;
}

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	if (argc < 4) {
		printf ("Run: fastrev_thr oldbase newbase -r:revision threads\n");
		exit (EXIT_FAILURE);
	}
	return main_logic (argc, argv);
}

#define	MAX_THREADS	16
struct thread_data_struct {
	YBase *old_base, *new_base;
	volatile int done, run;
	long from_id, to_id, id;
	std::set<long> chgdocs, gctxdocs, gctxdeldocs;
};

thread_data_struct thread_data [MAX_THREADS];

std::deque<long> old_docs;
std::set<long> chgdocs, gctxdocs, gctxdeldocs, gctxkinddocs, deldocs;

ACE_Recursive_Thread_Mutex chgdoc_mutex;

bool is_chg (long id)
{
	RWRITE_GUARD (chgdoc_mutex) {
		return (chgdocs.find (id) != chgdocs.end ());
	}
}

void add_chg (long id, bool and_gctx = false)
{
	RWRITE_GUARD (chgdoc_mutex) {
		chgdocs.insert (id);
		if (and_gctx) gctxdocs.insert (id);
	}
}

std::map<long,long> map_id_controlstatus;
void add_control (long id, long status)
{
	RWRITE_GUARD (chgdoc_mutex) {
		map_id_controlstatus.insert (std::map<long,long>::value_type (id, status));
	}
}

ACE_Recursive_Thread_Mutex new_doc_mutex;
std::deque<long> doc_ids;
std::deque<long>::iterator get_doc_it;

long	get_doc (bool next)
{
	RWRITE_GUARD (new_doc_mutex) {
		if (get_doc_it == doc_ids.end ())
			return 0;
		long result = *get_doc_it;
		if (next)
			get_doc_it++;
		return result;
	}
}

void	compare_attrs (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->run = 1;
	long from_id = thread_data_ptr->from_id, to_id = thread_data_ptr->to_id;

	AttrIndex* oldAttrs = (AttrIndex*) thread_data_ptr->old_base->FindIndex ("Attrs");
	AttrIndex* newAttrs = (AttrIndex*) thread_data_ptr->new_base->FindIndex ("Attrs");
	
	BTIterator oldit (oldAttrs);
	BTIterator newit (newAttrs);

	AttrKey oldkey; oldkey.DocId = ID_BORDER; oldkey.AttrTag = IDD_DATE; oldit.Set (&oldkey);
	AttrKey newkey; newkey.DocId = ID_BORDER; newkey.AttrTag = IDD_DATE; newit.Set (&newkey);

	std::set<long> *chgdocs = &thread_data_ptr->chgdocs;
	std::set<long> *gctxdocs = &thread_data_ptr->gctxdocs;
	std::set<long> *gctxdeldocs = &thread_data_ptr->gctxdeldocs;

	std::set<short> gctx_attrs;
	gctx_attrs.insert (IDD_MARKEDTEXT);
	gctx_attrs.insert (IDD_HANDMASK);
	gctx_attrs.insert (IDD_HANDHANDMASK);
	gctx_attrs.insert (IDD_INVISIBLELENS);
	gctx_attrs.insert (IDD_INVISIBLERELES);
	gctx_attrs.insert (IDD_INVISIBLEBLOCKSLENS);
	gctx_attrs.insert (IDD_TYPE);
	gctx_attrs.insert (IDD_SOURCE);
	gctx_attrs.insert (IDD_KIND);
	gctx_attrs.insert (IDD_SUBS);

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
				if (std::binary_search (doc_ids.begin (), doc_ids.end (), oldId)) {
					if (chgdocs->find (oldId) == chgdocs->end ()) {
						chgdocs->insert (oldId);
						printf ("%ld.%ld ", oldId, oldtag);
					}
					if (gctx_attrs.find (oldtag) != gctx_attrs.end ())
						gctxdocs->insert (oldId);
				}
				oldit.next();
			} else if (oldId == newId) {
				if (chgdocs->find (oldId) == chgdocs->end () || gctx_attrs.find (oldtag) != gctx_attrs.end () || oldtag == IDD_INFO) {
					Stream* oldstr = oldAttrs->OpenN (&oldkey, 0);
					Stream* newstr = newAttrs->OpenN (&newkey, 0);

					int oldlength = oldstr->Length ();
					int newlength = newstr->Length ();

					if (oldlength != newlength && oldtag != IDD_DIV) {
						printf ("%ld.%ld ", oldId, oldtag);
						chgdocs->insert (oldId);
						if (gctx_attrs.find (oldtag) != gctx_attrs.end ())
							gctxdocs->insert (oldId);
					} else {
						char *oldbuf = (char*) malloc (oldlength);
						char *newbuf = (char*) malloc (newlength);
						oldstr->Read (oldbuf, oldlength);
						newstr->Read (newbuf, newlength);
						int chg = 0;
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

							case IDD_INFO:
								chg = DocInfoCmp ((DocInfo*) oldbuf, (DocInfo*) newbuf);
								if (chg) {
									DocInfo *oldinfo = (DocInfo*) oldbuf;
									DocInfo *newinfo = (DocInfo*) newbuf;
									if ((oldinfo->Status & (DS_DOC | DS_EDITION)) != (newinfo->Status & (DS_DOC | DS_EDITION))) {
										if (newinfo->Status & (DS_DOC | DS_EDITION))
											gctxdocs->insert (oldId);
										else
											gctxdeldocs->insert (oldId);
									}
									if (((newinfo->Status & (DS_DOC | DS_EDITION)) || (newinfo->Status_ex & DS_MEDTOPIC)) && (oldinfo->Size != newinfo->Size || oldinfo->ParaCount != newinfo->ParaCount))
										gctxdocs->insert (oldId);
								}

								break;

							default:
								chg = memcmp( oldbuf, newbuf, oldlength );
								break;
						}
						if (chg) {
							printf ("%ld.%ld ", oldId, oldtag);
							chgdocs->insert (oldId);
							if (gctx_attrs.find (oldtag) != gctx_attrs.end ())
								gctxdocs->insert (oldId);
						}

						free( oldbuf );
						free( newbuf );
					}

					oldAttrs->Close (oldstr);
					newAttrs->Close (newstr);
				}

				oldit.next();
				newit.next();
			} else {
				if (chgdocs->find (newId) == chgdocs->end ()) {
					printf ("%ld.%ld ", newId, newtag);
					chgdocs->insert (newId);
				}
				if (gctx_attrs.find (oldtag) != gctx_attrs.end ())
					gctxdocs->insert (newId);
				else if (newtag == IDD_INFO) {
					Stream* newstr = newAttrs->OpenN (&newkey, 0);
					int newlength = newstr->Length ();
					DocInfo *newinfo = (DocInfo*) malloc (newlength);
					newstr->Read (newinfo, newlength);
					newAttrs->Close (newstr);
					if ((newinfo->Status & (DS_DOC|DS_EDITION)) || (newinfo->Status_ex & DS_MEDTOPIC))
						gctxdocs->insert (newId);
					free (newinfo);
				}
				newit.next ();
			}
		} else {
			if (oldtag < newtag) {
				if (std::binary_search (doc_ids.begin (), doc_ids.end (), oldId) && chgdocs->find (oldId) == chgdocs->end ()) {
					printf ("%ld.%ld ", oldId, oldtag, this_thread_id);
					chgdocs->insert (oldId);
				}
				if (gctx_attrs.find (oldtag) != gctx_attrs.end ())
					gctxdocs->insert (oldId);
				oldit.next();
			} else {
				if (chgdocs->find (newId) == chgdocs->end ()) {
					printf ("%ld.%ld ", newId, newtag);
					chgdocs->insert (newId);
				}
				if (gctx_attrs.find (newtag) != gctx_attrs.end ())
					gctxdocs->insert (newId);
				newit.next ();
			}
		}
	}

	for (; !oldit.End (); oldit.next ()) {
		oldkey = *(AttrKey*) oldit.Key();
		long oldtag = oldkey.AttrTag, oldId = oldkey.DocId;
		if (oldtag == IDD_RUNS || oldtag == IDD_BLOCKS || oldtag == IDD_SOURCEFILE || oldId < from_id || oldId > to_id)
			continue;

		if (std::binary_search (doc_ids.begin (), doc_ids.end (), oldId)) {
			if (chgdocs->find (oldId) == chgdocs->end ()) {
				printf ("to.%ld.%ld ", oldId, oldtag);
				chgdocs->insert (oldId);
			}
			if (gctx_attrs.find (oldtag) != gctx_attrs.end () || oldtag == IDD_INFO)
				gctxdeldocs->insert (oldId);
		}
	}

	for (; !newit.End (); newit.next ()) {
		newkey = *(AttrKey*) newit.Key();
		long newtag = newkey.AttrTag, newId = newkey.DocId;
		if (newtag == IDD_RUNS || newtag == IDD_BLOCKS || newtag == IDD_SOURCEFILE || newId < from_id || newId > to_id)
			continue;

		if (std::binary_search (doc_ids.begin (), doc_ids.end (), newId)) {
			if (chgdocs->find (newId) == chgdocs->end ()) {
				chgdocs->insert (newId);
				printf ("tn.%ld.%ld ", newId, newtag);
			}
			if (gctx_attrs.find (newtag) != gctx_attrs.end ())
				gctxdocs->insert (newId);
			else if (newtag == IDD_INFO) {
				Stream* newstr = newAttrs->OpenN (&newkey, 0);
				int newlength = newstr->Length ();
				DocInfo *newinfo = (DocInfo*) malloc (newlength);
				newstr->Read (newinfo, newlength);
				newAttrs->Close (newstr);
				if ((newinfo->Status & (DS_DOC|DS_EDITION)) || (newinfo->Status_ex & DS_MEDTOPIC))
					gctxdocs->insert (newId);
				free (newinfo);
			}
		}
	}

	thread_data_ptr->done = 1;
}

void	compare_attribs (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->run = 1;

	AttrIndex* oldAttribs = (AttrIndex*) thread_data_ptr->old_base->FindIndex ("Attribs");
	AttrIndex* newAttribs = (AttrIndex*) thread_data_ptr->new_base->FindIndex ("Attribs");
	
	AttrKey oldkey; oldkey.AttrTag = IDD2_PARAIDS;
	AttrKey newkey; newkey.AttrTag = IDD2_PARAIDS;

	for (;;) {
		long id = get_doc (true);
		if (!id)
			break;

		if (is_chg (id))
			continue;

		oldkey.DocId = id; Stream* oldstr = oldAttribs->OpenN (&oldkey, 0);
		newkey.DocId = id; Stream* newstr = newAttribs->OpenN (&newkey, 0);

		if (oldstr && newstr) {
			int oldlength = oldstr->Length ();
			int newlength = newstr->Length ();

			if (oldlength != newlength) {
				printf ("%ld ", id);
				add_chg (id);
			} else {
				char *oldbuf = (char*) malloc (oldlength);
				char *newbuf = (char*) malloc (newlength);
				oldstr->Read (oldbuf, oldlength);
				newstr->Read (newbuf, newlength);
				if (memcmp( oldbuf, newbuf, oldlength )) {
					printf ("%ld ", id);
					add_chg (id);
				}
				free (oldbuf);
				free (newbuf);
			}
		} else {
			if (oldstr || newstr) {
				printf ("%ld ", id);
				add_chg (id);
			}
		}
		if (oldstr) oldAttribs->Close (oldstr);
		if (newstr) newAttribs->Close (newstr);
	}

	thread_data_ptr->done = 1;
}

void	compare_texts (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->run = 1;

	for (;;) {
		long id = get_doc (true);
		if (!id)
			break;

		if (std::binary_search (old_docs.begin (), old_docs.end (), id)) {
			Document* olddoc = thread_data_ptr->old_base->GetDoc (id);
			Document* newdoc = thread_data_ptr->new_base->GetDoc (id);

			if (gctxdocs.find (id) == gctxdocs.end () && ((newdoc->Stat.Status & (DS_DOC | DS_EDITION)) || (newdoc->Stat.Status_ex & DS_MEDTOPIC) || !is_chg (id))) {
				int bodyDiff = olddoc->Stat.ParaCount != newdoc->Stat.ParaCount;
				for (long l = 0; l < olddoc->Stat.ParaCount && !bodyDiff; l++) {
					char* oldpara = olddoc->GetPara (l);
					char* newpara = newdoc->GetPara (l);

					bodyDiff = ParaSize (oldpara) != ParaSize (newpara);
					if (!bodyDiff)
						bodyDiff = memcmp (newpara, oldpara, ParaSize (newpara) + 3);
				}
				if (bodyDiff) {
					printf ("%ld ", id);
					add_chg (id, true);
				}
			}
			delete olddoc;
			delete newdoc;
		}
	}

	thread_data_ptr->done = 1;
}

void	compare_control (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->run = 1;

	AttrIndex* oldAttrs = (AttrIndex*) thread_data_ptr->old_base->FindIndex ("Attrs");
	AttrIndex* newAttrs = (AttrIndex*) thread_data_ptr->new_base->FindIndex ("Attrs");

	for (;;) {
		long id = get_doc (true);
		if (!id)
			break;

		if (std::binary_search (old_docs.begin (), old_docs.end (), id)) {
			//документ есть и в старой базе

			long status = 0;
			DocInfo oldinfo, newinfo;
			thread_data_ptr->old_base->FindDocInfo (id, oldinfo);
			thread_data_ptr->new_base->FindDocInfo (id, newinfo);

			if ((oldinfo.Status & DS_ACTIVE) && (newinfo.Status & DS_ABOLISHED))
				status |= CS_ABOLISHED; //утратил силу
			if ((newinfo.Status & DS_ACTIVE ) && !(oldinfo.Status & DS_ACTIVE))
				status |= CS_ACTIVE; //вступил в силу
			if ((newinfo.Status & DS_MOJREG) && !(oldinfo.Status & DS_MOJREG))
				status |= CS_REGISTERED; //зарегистрировали в МЮ
			if ((newinfo.Status & DS_MOJNOTREG) && !(oldinfo.Status & DS_MOJNOTREG))
				status |= CS_NOT_REGISTERED; //отказали в регистрации

			AttrKey aKey = {id, IDD_VCHANGED};
			Stream* oldStr = oldAttrs->Open (&aKey);
			Stream* newStr = newAttrs->Open (&aKey);

			long iOldSize = oldStr ? oldStr->Length () : 0;
			long iNewSize = newStr ? newStr->Length () : 0;
			
			if (iOldSize != iNewSize) {
				status |= CS_CHANGED;
				if (oldStr) oldAttrs->Close (oldStr);
				if (newStr) newAttrs->Close (newStr);
			} else {
				StorableSplaySet<date> oldSet; oldAttrs->Load (oldStr, oldSet);
				StorableSplaySet<date> newSet; newAttrs->Load (newStr, newSet);
				if (newSet != oldSet)
					status |= CS_CHANGED;
			}

			if (status) {
				printf ("%ld.%ld ", id, status);
				add_control (id, status);
			}
		}
	}

	thread_data_ptr->done = 1;
}

void	compare_subnames (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->run = 1;

	Index* old_names = thread_data_ptr->old_base->FindIndex ("SubName");
	Index* new_names = thread_data_ptr->new_base->FindIndex ("SubName");

	char old_name [DOC_NAME_SIZE*3], new_name [DOC_NAME_SIZE*3];

	for (;;) {
		long id = get_doc (true);
		if (!id)
			break;

		//if (is_chg (id))
		//	continue;
		if (gctxdocs.find (id) != gctxdocs.end ())
			continue;

		Ref ref = {id ,0};
		Stream* old_str = old_names->Open (&ref);
		Stream* new_str = new_names->Open (&ref);

		if ((old_str && new_str) || (!old_str && !new_str)) {
			if (old_str && new_str) {
				int length = old_str->Length ();
				if (length != new_str->Length ()) {
					printf ("%ld.0 ", id);
					add_chg (id, true);
					old_names->Close (old_str);
					new_names->Close (new_str);
					continue;
				}

				old_str->Read (old_name, length);
				new_str->Read (new_name, length);
				old_names->Close (old_str);
				new_names->Close (new_str);

				if (strcmp (old_name, new_name)) {
					printf ("%ld.0 ", id);
					add_chg (id, true);
					continue;
				}
			}

			Ref old_ref = {id, 1};
			Ref new_ref = {id, 1};
			for (BTIterator old_it (old_names, &old_ref), new_it (new_names, &new_ref); !old_it.End () && !new_it.End (); ++old_it, ++new_it) {
				old_ref = *(Ref*) old_it.Key ();
				new_ref = *(Ref*) new_it.Key ();
				if (old_ref.DocId != id && new_ref.DocId != id)
					break;

				if (old_ref.DocId == id && new_ref.DocId == id) {
					old_str = old_names->Open (&old_ref);
					new_str = new_names->Open (&new_ref);

					if (!old_str || !new_str) {
						printf ("%ld.%ld ", id, old_ref.Sub);
						add_chg (id, true);
						if (old_str) old_names->Close (old_str);
						if (new_str) new_names->Close (new_str);
						break;
					}

					int length = old_str->Length ();
					if (length != new_str->Length ()) {
						printf ("%ld.%ld ", id, old_ref.Sub);
						add_chg (id, true);
						old_names->Close (old_str);
						new_names->Close (new_str);
						break;
					}

					old_str->Read (old_name, length);
					new_str->Read (new_name, length);
					old_names->Close (old_str);
					new_names->Close (new_str);

					if (strcmp (old_name, new_name)) {
						printf ("%ld.%ld ", id, old_ref.Sub);
						add_chg (id, true);
						break;
					}
				} else {
					printf ("%ld.%ld ", id, old_ref.DocId == id ? old_ref.Sub : new_ref.Sub);
					add_chg (id, true);
					break;
				}
			}
		} else {
			if (old_str || new_str) {
				printf ("%ld.0 ", id);
				add_chg (id, true);
			}
			if (old_str) old_names->Close (old_str);
			if (new_str) new_names->Close (new_str);
			continue;
		}
	}

	thread_data_ptr->done = 1;
}

void	compare_respondents (long &thread_id)
{
	long this_thread_id = thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->run = 1;

	Index* old_resps = thread_data_ptr->old_base->FindIndex ("Respondent");
	Index* new_resps = thread_data_ptr->new_base->FindIndex ("Respondent");

	for (;;) {
		long id = get_doc (true);
		if (!id)
			break;

		if (is_chg (id))
			continue;

		Stream* old_str = old_resps->Open (&id);
		Stream* new_str = new_resps->Open (&id);
		if (old_str && new_str) {
			int length = old_str->Length ();
			if (length != new_str->Length ()) {
				printf ("%ld ", id);
				add_chg (id);
			} else {
				char *old_buf = (char*) malloc (length);
				char *new_buf = (char*) malloc (length);
				old_str->Read (old_buf, length);
				new_str->Read (new_buf, length);
				if (memcmp (old_buf, new_buf, length)) {
					printf ("%ld ", id);
					add_chg (id);
				}
				free (old_buf);
				free (new_buf);
			}
		} else {
			if (old_str || new_str) {
				printf ("%ld ", id);
				add_chg (id);
			}
		}
		if (old_str) old_resps->Close (old_str);
		if (new_str) new_resps->Close (new_str);
	}

	thread_data_ptr->done = 1;
}

class BaseInfoSet : public StorableSplaySet<BaseInfo>
{
public:
	BaseInfoSet ( Base* base ) {
		Stream * str = base->FindIndex( "Aux" )->Open( "Base" );
		if ( str ) {
			Get ( str );
			base->FindIndex( "Aux" )->Close( str );
		}
	}

	BaseInfoSet (const BaseInfoSet& a) : StorableSplaySet<BaseInfo>(a) {}

	void ReplaceRevision ( revision& rev ) {
		for ( Point p = first(); p; next(p) )
			contents (p).LastUpdate = rev;
	}

	void SaveInfo ( Base* base ) {
		Stream * str = base->FindIndex( "Aux" )->Open( "Base" );
		if ( str ) {
			Put ( str );
			str->Trunc();
			base->FindIndex( "Aux" )->Close( str );
		}
	}
};

int main_logic ( int argc, char *argv[] )
{
	revision rrevision;
	gk_bzero (&rrevision, sizeof (rrevision));

	if (argv [1][0] == '-' && (argv [1][1] == 's' || argv [1][1] == 'S') && argv [1][2] == ':') {
		StrRev (&argv[1][3], rrevision);
		StdBigBase *base = new StdBigBase (argv [2], ACE_OS_O_RDWR);

		char str [64];
		revision r;
		gk_bzero (&r, sizeof (r));
		for (int i = 3; i < argc; i++) {
			FILE* part_file = mpcxc_fopen (argv [i], "rt");
			if (part_file) {
				while (!feof (part_file)) {
					if (!fgets (str, sizeof (str), part_file))
						break;

					int length = strlen (str);
					while (length && (str [length-1] == 10 || str [length-1] == 13))
						str [--length] = 0;
					if (!length)
						continue;

					long id = atol (str);
					StrRev (strchr (str, ':') + 1, r);

					DocInfo docinfo;
					if (base->FindDocInfo (id, docinfo) == sizeof (DocInfo)) {
						docinfo.Revision = r;
						base->ReplaceAttr (id, IDD_INFO, &docinfo, sizeof (docinfo));
					}
				}
				fclose (part_file);
			}
		}
		BaseInfoSet bis (base);
		bis.ReplaceRevision (rrevision);
		bis.SaveInfo (base);

		base->SetReady (TID_GREV_2);
		base->SetReady (TID_GREV_1);

		delete base;

		return 0;
	}

	if (argc != 5)
		exit (EXIT_SUCCESS);

	long threads_count = atol (argv [4]);
	if (threads_count > MAX_THREADS)
		threads_count = MAX_THREADS;

	if (argv [3][0] == '-' && (argv [3][1] == 'c' || argv [3][1] == 'C') && argv [3][2] == ':') {
		printf ("create files\n");
		StrRev (&argv[3][3], rrevision);
		char part_file_name [32];
		strcpy (part_file_name, "fastrev_control.part");
		FILE* part_file = fopen (part_file_name, "w" );
		if (!part_file) {
			printf ("Cant create fastrev_thr.part\n");
			exit (EXIT_FAILURE);
		}

		//control revising
		printf ("open bases for control revising\n");
		YBase* old_base = new YBase (argv [1], ACE_OS_O_RDONLY);
		{
		AttrKey attr_key = {ID_BORDER, IDD_INFO};
		for (BTIterator it (old_base->FindIndex ("Attrs"), &attr_key); !it.End (); ++it) {
			AttrKey *key = (AttrKey*) it.Key ();
			if (key->AttrTag != IDD_INFO)
				break;
			old_docs.push_back (key->DocId);
		}
		printf ("old docs: %ld\n", old_docs.size ());
		}

		YBase* new_base = new YBase (argv [2], ACE_OS_O_RDONLY);
		{
		AttrKey attr_key = {ID_BORDER, IDD_INFO};
		for (BTIterator it (new_base->FindIndex ("Attrs"), &attr_key); !it.End (); ++it) {
			AttrKey *key = (AttrKey*) it.Key ();
			if (key->AttrTag != IDD_INFO)
				break;
			doc_ids.push_back (key->DocId);
		}
		printf ("new docs: %ld\n", doc_ids.size ());
		}

		get_doc_it = doc_ids.begin ();
		long thread, ok_threads = 0;
		for (int thread = 0; thread < threads_count; thread++) {
			thread_data [thread].id = thread;
			thread_data [thread].old_base = new YBase (argv [1], ACE_OS_O_RDONLY); thread_data [thread].old_base->IsOk ();
			thread_data [thread].new_base = new YBase (argv [2], ACE_OS_O_RDONLY); thread_data [thread].new_base->IsOk ();
			thread_data [thread].run  = 0;
			thread_data [thread].done = 0;
			boost::thread bthread (compare_control, thread_data [thread].id);
			bthread.detach ();
			ok_threads++;
		}
		for (;;) {
			long id = get_doc (false);
			if (id) {
				ACE_OS::sleep (10);
			} else {
				long dones = 0;
				for (int thread_id = 0; thread_id < threads_count; thread_id++)
					if (thread_data [thread_id].run && thread_data [thread_id].done)
						dones++;
				if (dones == ok_threads)
					break;
				else
					ACE_OS::sleep (1);
			}
		}

		std::vector<long> deleted_docs;
		std::set_difference (old_docs.begin (), old_docs.end (), doc_ids.begin (), doc_ids.end (), std::back_inserter (deleted_docs));
		printf ("\ndeleted docs: %ld\n", deleted_docs.size ());
		for (std::vector<long>::const_iterator del_it = deleted_docs.begin (); del_it != deleted_docs.end (); del_it++)
			map_id_controlstatus.insert (std::map<long,long>::value_type (*del_it, CS_DELETED));

		for (std::map<long,long>::const_iterator control_it = map_id_controlstatus.begin (); control_it != map_id_controlstatus.end (); control_it++) {
			char str [32];
			sprintf (str, "%ld:%ld\n", control_it->first, control_it->second);
			fputs (str, part_file);
		}
		fclose (part_file);

		return 0;
		
	}

	std::map<long, std::set<std::string> > old_kinds, new_kinds;
	get_gctx_kinds old_get_kinds, new_get_kinds;

	printf ("create files\n");
	StrRev (&argv[3][3], rrevision);
	char part_file_name [32];
	strcpy (part_file_name, "fastrev_thr.part");
	FILE* part_file = fopen (part_file_name, "w" );
	if (!part_file) {
		printf ("Cant create fastrev_thr.part\n");
		exit (EXIT_FAILURE);
	}
	FILE *deldocs_file = fopen ("sdel.txt", "w");
	FILE *upddocs_file = fopen ("supd.txt", "w");

	printf ("open bases\n");
	YBase* old_base = new YBase (argv [1], ACE_OS_O_RDONLY);
	{
	AttrKey attr_key = {0, IDD_INFO};
	for (BTIterator it (old_base->FindIndex ("Attrs"), &attr_key); !it.End (); ++it) {
		AttrKey *key = (AttrKey*) it.Key ();
		if (key->AttrTag != IDD_INFO)
			break;
		old_docs.push_back (key->DocId);
	}
	old_get_kinds.fill_kindsset (old_base, old_kinds);
	}

	{
	YBase* new_base = new YBase (argv [2], ACE_OS_O_RDONLY);
	new_base->IsOk ();
	AttrKey attr_key = {0, IDD_INFO};
	for (BTIterator it (new_base->FindIndex ("Attrs"), &attr_key); !it.End (); ++it) {
		AttrKey *key = (AttrKey*) it.Key ();
		if (key->AttrTag != IDD_INFO)
			break;
		doc_ids.push_back (key->DocId);
	}
	new_get_kinds.fill_kindsset (new_base, new_kinds);

	std::set<std::string> diff_kinds_set, old_kinds_set, new_kinds_set;
	for (long i = 0; i < 2; i++) {
		for (std::set<std::string>::const_iterator it = old_kinds.find (i)->second.begin (); it != old_kinds.find (i)->second.end (); it++)
			old_kinds_set.insert (*it);
		for (std::set<std::string>::const_iterator it = new_kinds.find (i)->second.begin (); it != new_kinds.find (i)->second.end (); it++)
			new_kinds_set.insert (*it);
	}

	std::set<std::string>::const_iterator it;
	for (it = new_kinds_set.begin (); it != new_kinds_set.end (); it++) {
		std::string kind = *it;
		if (old_kinds_set.find (kind) == old_kinds_set.end ()) {
			diff_kinds_set.insert (kind);
		}
	}
	for (it = old_kinds_set.begin (); it != old_kinds_set.end (); it++) {
		std::string kind = *it;
		if (new_kinds_set.find (kind) == new_kinds_set.end ()) {
			diff_kinds_set.insert (kind);
		}
	}

	DocCollection docs_to_reindex;
	for (it = diff_kinds_set.begin (); it != diff_kinds_set.end (); it++) {
		std::string kind = *it;
		HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) new_base->FindIndex ("Kind")->FullKey (kind.c_str ());
		if (hkey) {
			Stream* str = new_base->FindIndex ("Kind")->Index::OpenN (hkey, 0);
			if (str) {
				RefCollection refs;
				refs.Get (str);
				new_base->FindIndex ("Kind")->Close (str);
				docs_to_reindex.Merge (refs);
			}
			free (hkey);
		}
	}
	for (int docs = 0; docs < docs_to_reindex.ItemCount; docs++)
		gctxkinddocs.insert (docs_to_reindex [docs]);

#ifndef	_WIN64
	delete new_base;
#endif
	}

	std::deque<long>::const_iterator new_it, old_it;
	for (new_it = doc_ids.begin (), old_it = old_docs.begin (); old_it != old_docs.end () && new_it != doc_ids.end (); ) {
		if (*old_it < *new_it) {
			deldocs.insert (*old_it);
			old_it++;
		} else {
			if (*old_it == *new_it)
				old_it++;
			else
				chgdocs.insert (*new_it);
			new_it++;
		}
	}
	for (; old_it != old_docs.end (); old_it++)
		deldocs.insert (*old_it);
	gctxdeldocs.insert (deldocs.begin (), deldocs.end ());

	printf ("create threads");
	std::deque<long>::const_iterator from_it, to_it;
	long from_id = *doc_ids.begin (), to_id = *doc_ids.rbegin ();
	long size = doc_ids.size (), step = size / threads_count, ok_threads = 0, parts;
	for (parts = 0; parts < threads_count; parts++) {
		thread_data [parts].old_base = new YBase (argv [1], ACE_OS_O_RDONLY); thread_data [parts].old_base->IsOk ();
		thread_data [parts].new_base = new YBase (argv [2], ACE_OS_O_RDONLY); thread_data [parts].new_base->IsOk ();
		thread_data [parts].run  = 0;
		thread_data [parts].done = 0;

		int from_part = parts + 1;
		from_it = doc_ids.begin () + (step * (from_part-1));
		from_id = *from_it;
		if (from_part < threads_count) {
			to_it = doc_ids.begin ()+ step * from_part;
		} else {
			to_it = doc_ids.begin () + doc_ids.size ();
			to_it--;
		}
		to_id = *to_it;

		thread_data [parts].from_id = from_id;
		thread_data [parts].to_id = to_id;
		thread_data [parts].id = parts;

		/*
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		if (inst->spawn ((ACE_THR_FUNC)compare_attrs, &thread_data [parts].id, THR_DETACHED) != -1)
			ok_threads++;
		*/
		boost::thread thread (compare_attrs, thread_data [parts].id);
		thread.detach ();
		ok_threads++;
	}
	printf ("\nstep1 (Attrs) ");  fflush (stdout);
	for (;;) {
		long dones = 0;
		for (int thread_id = 0; thread_id < threads_count; thread_id++)
			if (thread_data [thread_id].run && thread_data [thread_id].done)
				dones++;
		if (dones == ok_threads)
			break;
		else
			ACE_OS::sleep (10);
	}
	for (int thread_id = 0; thread_id < threads_count; thread_id++) {
		chgdocs.insert (thread_data [thread_id].chgdocs.begin (), thread_data [thread_id].chgdocs.end ());
		gctxdocs.insert (thread_data [thread_id].gctxdocs.begin (), thread_data [thread_id].gctxdocs.end ());
		gctxdeldocs.insert (thread_data [thread_id].gctxdeldocs.begin (), thread_data [thread_id].gctxdeldocs.end ());
	}
	std::set<long>::const_iterator set_it;
	for (set_it = deldocs.begin (); set_it != deldocs.end (); set_it++)
		chgdocs.erase (*set_it);

	printf ("\nstep2 (Attribs) "); fflush (stdout);
	get_doc_it = doc_ids.begin ();
	for (ok_threads = parts = 0; parts < threads_count; parts++) {
		thread_data [parts].done = 0;
		thread_data [parts].run  = 0;
		/*
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		if (inst->spawn ((ACE_THR_FUNC)compare_attribs, &thread_data [parts].id, THR_DETACHED) != -1)
			ok_threads++;
		*/
		boost::thread thread (compare_attribs, thread_data [parts].id);
		thread.detach ();
		ok_threads++;
	}
	for (;;) {
		long id = get_doc (false);
		if (id) {
			ACE_OS::sleep (10);
		} else {
			long dones = 0;
			for (int thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].run && thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
			else
				ACE_OS::sleep (1);
		}
	}

	printf ("\nstep3 (Texts) "); fflush (stdout);	
	get_doc_it = doc_ids.begin ();
	for (parts = ok_threads = 0; parts < threads_count; parts++) {
		thread_data [parts].done = 0;
		thread_data [parts].run  = 0;
		/*
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		if (inst->spawn ((ACE_THR_FUNC)compare_texts, &thread_data [parts].id, THR_DETACHED) != -1)
			ok_threads++;
		*/
		boost::thread thread (compare_texts, thread_data [parts].id);
		thread.detach ();
		ok_threads++;
	}
	for (;;) {
		long id = get_doc (false);
		if (id) {
			ACE_OS::sleep (10);
		} else {
			long dones = 0;
			for (int thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].run && thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
			else
				ACE_OS::sleep (1);
		}
	}

	printf ("\nstep4 (SubName) "); fflush (stdout);
	get_doc_it = doc_ids.begin ();
	for (parts = ok_threads = 0; parts < threads_count; parts++) {
		thread_data [parts].done = 0;
		thread_data [parts].run  = 0;
		/*
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		if (inst->spawn ((ACE_THR_FUNC)compare_subnames, &thread_data [parts].id, THR_DETACHED) != -1)
			ok_threads++;
		*/
		boost::thread thread (compare_subnames, thread_data [parts].id);
		thread.detach ();
		ok_threads++;
	}
	for (;;) {
		long id = get_doc (false);
		if (id) {
			ACE_OS::sleep (10);
		} else {
			long dones = 0;
			for (int thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].run && thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
			else
				ACE_OS::sleep (1);
		}
	}

	printf ("\nstep5 (Respondent) "); fflush (stdout);
	get_doc_it = doc_ids.begin ();
	for (parts = ok_threads = 0; parts < threads_count; parts++) {
		thread_data [parts].done = 0;
		thread_data [parts].run  = 0;
		/*
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		if (inst->spawn ((ACE_THR_FUNC)compare_respondents, &thread_data [parts].id, THR_DETACHED) != -1)
			ok_threads++;
		*/
		boost::thread thread (compare_respondents, thread_data [parts].id);
		thread.detach ();
		ok_threads++;
	}
	for (;;) {
		long id = get_doc (false);
		if (id) {
			ACE_OS::sleep (10);
		} else {
			long dones = 0;
			for (int thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].run && thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
			else
				ACE_OS::sleep (1);
		}
	}
	printf ("\n");  fflush (stdout);
#ifndef	_WIN64
	for (parts = 0; parts < threads_count; parts++) {
		delete thread_data [parts].old_base;
		delete thread_data [parts].new_base;
	}
#endif

	printf ("%s\n", argv [3]);
	char str [128];
	DocInfo docinfo;

	for (get_doc_it = doc_ids.begin (); get_doc_it != doc_ids.end (); get_doc_it++) {
		long id = *get_doc_it;
		if (chgdocs.find (id) == chgdocs.end ()) {
			old_base->FindDocInfo (id, docinfo);
			sprintf (str, "%ld: %ld/%ld/%ld\n", id, docinfo.Revision.RevisionDate.da_day, docinfo.Revision.RevisionDate.da_mon, docinfo.Revision.RevisionDate.da_year);
		} else {
			sprintf (str, "%ld: %ld/%ld/%ld\n", id, rrevision.RevisionDate.da_day, rrevision.RevisionDate.da_mon, rrevision.RevisionDate.da_year);
		}
		fputs (str, part_file);
	}
	fclose (part_file);

	if (deldocs_file) {
		for (std::set<long>::const_iterator del_it = gctxdeldocs.begin (); del_it != gctxdeldocs.end (); del_it++) {
			sprintf (str, "%ld\n", *del_it);
			fputs (str, deldocs_file);
		}
		fclose (deldocs_file);
	}

	gctxdocs.insert (gctxkinddocs.begin (), gctxkinddocs.end ());
	if (upddocs_file) {
		for (std::set<long>::const_iterator upd_it = gctxdocs.begin (); upd_it != gctxdocs.end (); upd_it++) {
			long id = *upd_it;
			if (gctxdeldocs.find (id) == gctxdeldocs.end ()) {
				sprintf (str, "%ld\n", id);
				fputs (str, upddocs_file);
			}
		}
		fclose (upddocs_file);
	}

#ifndef	_WIN64
	delete old_base;
#endif

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
