#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "basemask.h"
#include "StorableSplaySet.h"
#include "pack.h"

#include <map>
#include <vector>
#include <algorithm>

YBase* aBase;

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

int DocInfoCmp( DocInfo& a, DocInfo& b )
{
	int res = strcmp ( a.Title, b.Title );
	if ( !res )
		res = CompDates( &a.FirstDate, &b.FirstDate );
	if ( !res )
		res = CompDates( &a.LastDate, &b.LastDate );
	if ( !res )
		res = !( a.Force == b.Force
			&& a.HyperRefs == b.HyperRefs
			&& a.GreenComments == b.GreenComments
			&& a.Status == b.Status
			&& a.Status_ex == b.Status_ex
			&& a.Related == b.Related 
			&& a.prevEdition == b.prevEdition
			&& a.nextEdition == b.nextEdition
			&& a.Status_exex_part1 == b.Status_exex_part1
			&& a.Status_exex_part2 == b.Status_exex_part2
			&& a.reserved_short == b.reserved_short
			&& a.reserved_short2== b.reserved_short2
			&& a.long_respondents == b.long_respondents
			&& a.hi_long_respondents == b.hi_long_respondents
			&& a.lastParaID == b.lastParaID
			&& a.ParaCount == b.ParaCount
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
		unsigned short day = 0, month = 0, year = 0, hour = 0, min = 0, find;
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
	return main_logic (argc, argv);
}

int main_logic ( int argc, char *argv[] )
{
	if (argc < 3)
		exit (EXIT_SUCCESS);

	revision rrevision;
	gk_bzero (&rrevision, sizeof (rrevision));

	if (argv [1][0] == '-' && (argv [1][1] == 'c' || argv [1][1] == 'C') && argv [1][2] == ':') {
		//fastrev -s:%rev_date% %newsup% fastrev_thr.part
		StrRev (&argv[1][3], rrevision);

		char str [64];
		RefCollection control;
		bool b_daily = false;
		for (int i = 4; i < argc; i++) {
			if (!strcmp (argv [i], "-daily")) {
				b_daily = true;
				continue;
			}
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

					Ref ref;
					ref.DocId = atol (str);
					ref.Sub = atol (strchr (str, ':') + 1);
					control.Add (ref);
				}
				fclose (part_file);
			}
		}

		StdBigBase *base = new StdBigBase (argv [3], ACE_OS_O_RDWR);
		DateIndex *newcontrol = (DateIndex*) base->FindIndex ("Control");

		if (!b_daily) {
			YBase *oldbase = new YBase (argv [2], ACE_OS_O_RDONLY);
			oldbase->IsOk ();
			DateIndex *oldcontrol = (DateIndex*) oldbase->FindIndex ("Control");
			for (BTIterator it (oldcontrol); !it.End (); ++it) {
				date adate = *(date*)it.Key ();
				if (adate.da_year < 2014)
					continue;
				Stream *str = oldcontrol->Index::OpenN (it.Key (), 0);
				if (str) {
					long size = str->Length ();
					char *data = new char [size];
					str->Read (data, size);
					oldcontrol->Close (str);
					str = newcontrol->Open (it.Key(), 1);
					if (str) {
						str->Write (data, size);
						str->Trunc ();
						newcontrol->Close (str);
					}
					delete []data;
				}
			}
			delete oldbase;
		}

		if (control.ItemCount) {
			Stream *str = newcontrol->Open (&rrevision.RevisionDate, 1);
			if (str) {
				control.Put (str);
				str->Trunc ();
				newcontrol->Close (str);
			}
		}
		delete base;
		return 0;
	}

	if (argv [1][0] == '-' && (argv [1][1] == 's' || argv [1][1] == 'S') && argv [1][2] == ':') {
		StrRev (&argv[1][3], rrevision);
		StdBigBase *base = new StdBigBase (argv [2], ACE_OS_O_RDWR);

		char str [64];
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
					revision r; gk_bzero (&r, sizeof (r));

					if (StrRev (strchr (str, ':') + 1, r)) {
						DocInfo docinfo;
						if (base->FindDocInfo (id, docinfo) == sizeof (DocInfo)) {
							docinfo.Revision = r;
							base->ReplaceAttr (id, IDD_INFO, &docinfo, sizeof (docinfo));
						}
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

	bool b_set_revision = false;
	if ( argc > 3 && ( argv[3][0] == '-' && ( argv[3][1] == 'r' || argv[3][1] == 'R' ) && argv[3][2] == ':' ) && ( StrRev( &argv[3][3], rrevision )))
		b_set_revision = true;

	if (argc > 4 && !strcmp (argv [4], "samedocs")) {
		if (!b_set_revision) {
			printf ("Usage: fastrev oldbase newbase -r:revision samedocs\n");
			exit (EXIT_FAILURE);
		}
		YBase *oldbase = new YBase (argv [1], ACE_OS_O_RDONLY); oldbase->IsOk ();
		YBase *newbase = new YBase (argv [2], ACE_OS_O_RDONLY); newbase->IsOk ();
		AttrKey attrkey = {ID_BORDER, IDD_SAMEDOCS};
		std::vector<long> chgdocs;
		for (BTIterator it (newbase->FindIndex ("Attrs"), &attrkey); !it.End (); it.next()) {
			AttrKey *key = (AttrKey*) it.Key ();
			if (key->AttrTag != IDD_SAMEDOCS)
				break;
			long id = key->DocId, oldsize, newsize;
			char* newsamedocs = (char*) newbase->LoadAttr (id, IDD_SAMEDOCS, newsize);
			char* oldsamedocs = (char*) oldbase->LoadAttr (id, IDD_SAMEDOCS, oldsize);
			if ((oldsize != newsize) || memcmp (newsamedocs, oldsamedocs, oldsize))
				chgdocs.push_back (id);
			if (newsize) gk_free (newsamedocs);
			if (oldsize) gk_free (oldsamedocs);
		}
		delete oldbase;
		delete newbase;
		printf ("IDD_SAMEDOCS changed for %ld docs\n", chgdocs.size ());
		if (chgdocs.size ()) {
			StdBigBase *newbase = new StdBigBase (argv [2], ACE_OS_O_RDWR);
			for (std::vector<long>::const_iterator it = chgdocs.begin (); it != chgdocs.end (); it++) {
				long id = *it;
				DocInfo docinfo;
				newbase->FindDocInfo (id, docinfo);
				if (memcmp (&docinfo.Revision, &rrevision, sizeof (revision))) {
					printf ("%ld\r", id);
					docinfo.Revision = rrevision;
					newbase->ReplaceAttr (id, IDD_INFO, &rrevision, sizeof (revision));
				}
			}
			printf ("\n");
			delete newbase;
		}
		exit (EXIT_SUCCESS);
	}

	bool b_part_work = false;
	long from_part = 0, total_parts = 1;
	if (argc == 6) {
		b_part_work = true;
		from_part = atol (argv [4]);
		total_parts = atol (argv [5]);
	}

	aBase = new YBase (argv [1], ACE_OS_O_RDONLY);
	if ( !aBase || !aBase->IsOk ())
		exit(EXIT_FAILURE);

	YBase* aNewBase = new YBase (argv [2], ACE_OS_O_RDONLY);
	if ( !aNewBase || !aNewBase->IsOk ())
		exit(EXIT_FAILURE);

	AttrIndex* oldAttrs = (AttrIndex*) aBase->FindIndex( "Attrs" );
	AttrIndex* newAttrs = (AttrIndex*) aNewBase->FindIndex( "Attrs" );

	BTIterator oldit( oldAttrs );
	BTIterator newit( newAttrs );
	AttrKey oldkey = { ID_BORDER, IDD_INFO };
	AttrKey newkey = { ID_BORDER, IDD_INFO };
	oldit.Set( &oldkey );
	newit.Set( &newkey );

	DocInfo oldInfo, newInfo;

	std::set<long> docs_to_process;

	std::set<long> newdocs, chgdocs, equdocs, chgtdocs, deldocs;
	std::map<long,revision> *revs = new std::map<long,revision>;
	std::vector<long> doc_ids;

	printf( "Step1: checking IDD_INFO\n" );
	bool read_next_newId = true;
	for ( ; ; ) {
		oldkey = *(AttrKey*) oldit.Key();
		newkey = *(AttrKey*) newit.Key();

		if ( newkey.AttrTag != IDD_INFO || oldkey.AttrTag != IDD_INFO ) {
			while ( oldkey.AttrTag == IDD_INFO ) {
				long oldId = oldkey.DocId;
				deldocs.insert( oldId );
				oldit.next();
				oldkey = *(AttrKey*) oldit.Key();
			}
			while ( newkey.AttrTag == IDD_INFO ) {
				long newId = newkey.DocId;
				doc_ids.push_back (newId);
				newdocs.insert( newId );
				newit.next();
				newkey = *(AttrKey*) newit.Key();
			}
			break;
		}

		long oldId = oldkey.DocId;
		long newId = newkey.DocId;

		bool chg = false;

		if ( oldId > newId ) {
			//новый документ
			newdocs.insert( newId );
			doc_ids.push_back (newId);
			chg = true;
			newit.next();
			read_next_newId = true;
			continue;
		} else {
			oldAttrs->Get( oldId, IDD_INFO, &oldInfo, sizeof( oldInfo ));
			if ( revs->find( oldId ) == revs->end())
				revs->insert( std::map<long,revision>::value_type( oldId, oldInfo.Revision ));

			if ( read_next_newId ) newAttrs->Get( newId, IDD_INFO, &newInfo, sizeof( newInfo ));

			oldit.next();
			if ( oldId == newId ) {
				doc_ids.push_back (newId);
				//сравнить DocInfo
				if ( oldInfo.Size != newInfo.Size || oldInfo.ParaCount != newInfo.ParaCount || DocInfoCmp( oldInfo, newInfo )) {
					chgdocs.insert( newId );
					chg = true;
				} else {
					equdocs.insert( newId );
				}
				newit.next();
				read_next_newId = true;
			}
			else {
				chg = true;
				deldocs.insert( oldId );
				read_next_newId = false;
			}
		}
		if ( chg ) {
			printf( "Chg: %ld, new: %ld, del: %ld\r", chgdocs.size(), newdocs.size(), deldocs.size() );
		}
	}

	std::set<long>::const_iterator it;
	for ( it = newdocs.begin(); it != newdocs.end(); it++ )
		chgdocs.insert( *it );

	/*
	int thread_id;
	for (thread_id = 0; thread_id < MAX_THREADS; thread_id++) {
		thread_data [thread_id].old_base = new YBase (argv [1], ACE_OS_O_RDONLY);
		thread_data [thread_id].new_base = new YBase (argv [2], ACE_OS_O_RDONLY);
		thread_data [thread_id].newdocs.insert (newdocs.begin (), newdocs.end ());
		thread_data [thread_id].chgdocs.insert (chgdocs.begin (), chgdocs.end ());
		thread_data [thread_id].equdocs.insert (equdocs.begin (), equdocs.end ());
		thread_data [thread_id].done = 0;
	}
	printf ("\nrun threads\n");
	ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
	thread_id = 0; inst->spawn ((ACE_THR_FUNC)check_idd, &thread_id, THR_DETACHED); ACE_OS::sleep (1);
	thread_id = 1; inst->spawn ((ACE_THR_FUNC)check_paraids, &thread_id, THR_DETACHED); ACE_OS::sleep (1);
	thread_id = 2; inst->spawn ((ACE_THR_FUNC)check_texts, &thread_id, THR_DETACHED); ACE_OS::sleep (1);
	thread_id = 3; inst->spawn ((ACE_THR_FUNC)check_subnames, &thread_id, THR_DETACHED); ACE_OS::sleep (1);
	thread_id = 4; inst->spawn ((ACE_THR_FUNC)check_respondents, &thread_id, THR_DETACHED); ACE_OS::sleep (1);
	while (true) {
		int dones = 0;
		for (thread_id = 0; thread_id < MAX_THREADS; thread_id++)
			dones += thread_data [thread_id].done;
		printf ("%ld\r", dones); fflush (stdout);
		if (dones == MAX_THREADS)
			break;
		ACE_OS::sleep (30);
	}
	*/

	long from_id = *doc_ids.begin (), to_id = *doc_ids.rbegin ();
	std::vector<long>::const_iterator from_it, to_it;
	if (b_part_work) {
		long size = doc_ids.size ();
		long step = size / total_parts;
		from_it = doc_ids.begin () + (step * (from_part-1));
		from_id = *from_it;
		if (from_part < total_parts) {
			to_it = doc_ids.begin ()+ step * from_part;
			docs_to_process.insert (from_it, to_it);
		} else {
			to_it = doc_ids.begin () + doc_ids.size ();
			docs_to_process.insert (from_it, to_it);
			to_it--;
		}
		to_id = *to_it;
	}

	printf( "\n\nStep2: compare Attrs\n" );
	//теперь надо бежать по всему Attrs и, если AttrKey.DocId входит в equdocs, то надо сравнить данные
	//при этом не смотрим на IDD_INFO
	//далее, теперь наличие нового реквизита или его отсутствие - это значит документ chg
	oldkey.DocId = ID_BORDER; oldkey.AttrTag = IDD_DATE;
	newkey.DocId = ID_BORDER; newkey.AttrTag = IDD_DATE;
	oldit.Set( &oldkey );
	newit.Set( &newkey );

	while ( !oldit.End() && !newit.End()) {
		oldkey = *(AttrKey*) oldit.Key();
		long oldtag = oldkey.AttrTag;
		if ( oldtag == IDD_INFO || oldtag == IDD_RUNS || oldtag == IDD_BLOCKS || oldtag == IDD_SOURCEFILE ) {
			oldit.next();
			continue;
		}
		long oldId = oldkey.DocId;
		if ( oldId < ID_BORDER ) {
			oldit.next();
			continue;
		}

		newkey = *(AttrKey*) newit.Key();
		long newtag = newkey.AttrTag;
		if ( newtag == IDD_INFO || newtag == IDD_RUNS || newtag == IDD_BLOCKS || newtag == IDD_SOURCEFILE ) {
			newit.next();
			continue;
		}

		long newId = newkey.DocId;
		if ( newId < ID_BORDER ) {
			newit.next();
			continue;
		}

		bool chg = false;

		if ( oldtag == newtag ) {
			if ( oldId < newId ) {
				if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
					chg = true;
					chgdocs.insert( oldId );
					std::set<long>::iterator _find = equdocs.find (oldId);
					if (_find != equdocs.end ()) equdocs.erase(_find);
				}
				oldit.next();
			} else if ( oldId == newId ) {
				if ( chgdocs.find( oldId ) == chgdocs.end()) {
					if (b_part_work && (newId < from_id || newId > to_id)) {
						oldit.next();
						newit.next();
						continue;
					}

					Stream* oldstr = oldAttrs->OpenN( &oldkey, 0 );
					Stream* newstr = newAttrs->OpenN( &newkey, 0 );

					int oldlength = oldstr->Length();
					int newlength = newstr->Length();

					if (oldlength != newlength && oldtag != IDD_DIV) {
						chg = true;
						chgdocs.insert( oldId );
						std::set<long>::iterator _find = equdocs.find (oldId);
						if (_find != equdocs.end ()) equdocs.erase(_find);
					} else {
						char *oldbuf = (char*) malloc( oldlength );
						char *newbuf = (char*) malloc( newlength );
						oldstr->Read( oldbuf, oldlength );
						newstr->Read( newbuf, newlength );
						int eq = 0;
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
								if (oldlength != newlength)
									eq = 1;
								else
									eq = CheckStrSet( oldbuf, newbuf, oldlength );
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
								eq = CheckDateSet( oldbuf, newbuf, oldlength );
								break;

							case IDD_SUBS:
								eq = CheckSubSet( oldbuf, newbuf, oldlength );
								break;

							default:
								eq = memcmp( oldbuf, newbuf, oldlength );
								break;
						}
						if ( eq ) {
							chg = true;
							chgdocs.insert( oldId );
							std::set<long>::iterator _find = equdocs.find (oldId);
							if (_find != equdocs.end ()) equdocs.erase(_find);
						}
						free( oldbuf );
						free( newbuf );
					}

					oldAttrs->Close( oldstr );
					newAttrs->Close( newstr );
				}

				oldit.next();
				newit.next();
			} else {
				if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
					chg = true;
					chgdocs.insert( newId );
					std::set<long>::iterator _find = equdocs.find (newId);
					if (_find != equdocs.end ()) equdocs.erase(_find);
				}
				newit.next();
			}
		} else {
			if ( oldtag < newtag ) {
				if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
					chg = true;
					chgdocs.insert( oldId );
					std::set<long>::iterator _find = equdocs.find (oldId);
					if (_find != equdocs.end ()) equdocs.erase(_find);
				}
				oldit.next();
			} else {
				if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
					chg = true;
					chgdocs.insert( newId );
					std::set<long>::iterator _find = equdocs.find (newId);
					if (_find != equdocs.end ()) equdocs.erase(_find);
				}
				newit.next();
			}
		}

		if ( chg ) {
			printf( "Chg: %ld, doc: %ld, tag: %ld\r", chgdocs.size() - newdocs.size(), oldId, oldtag); fflush (stdout);
		}
	}

	//рассмотреть хвост старого итератора. Это могут быть измененные или удаленные документы
	while ( !oldit.End()) {
		oldkey = *(AttrKey*) oldit.Key();
		long oldtag = oldkey.AttrTag;
		if ( oldtag == IDD_INFO ) {
			oldit.next();
			continue;
		}
		long oldId = oldkey.DocId;
		if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
			chgdocs.insert( oldId );
			std::set<long>::iterator _find = equdocs.find (oldId);
			if (_find != equdocs.end ()) equdocs.erase(_find);
		}
		oldit.next();
	}
	printf( "Chg: %ld\r", chgdocs.size() - newdocs.size());

	//рассмотреть хвост  нового итератора. Это могут быть новые или измененные документы
	while ( !newit.End()) {
		newkey = *(AttrKey*) newit.Key();
		long newtag = newkey.AttrTag;
		if ( newtag == IDD_INFO ) {
			newit.next();
			continue;
		}

		long newId = newkey.DocId;
		if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
			chgdocs.insert( newId );
			std::set<long>::iterator _find = equdocs.find (newId);
			if (_find != equdocs.end ()) equdocs.erase(_find);
		}
		newit.next();
	}
	printf( "Chg: %ld\r", chgdocs.size() - newdocs.size()); fflush (stdout);

	{
	printf( "\n\nStep3: compare Attribs (IDD_PARAIDS)\n" ); fflush (stdout);
	AttrIndex* oldAttribs = (AttrIndex*) aBase->FindIndex( "Attribs" );
	AttrIndex* newAttribs = (AttrIndex*) aNewBase->FindIndex( "Attribs" );

	BTIterator oldit( oldAttribs );
	BTIterator newit( newAttribs );
	AttrKey oldkey = { ID_BORDER, IDD2_PARAIDS };
	AttrKey newkey = { ID_BORDER, IDD2_PARAIDS };
	oldit.Set( &oldkey );
	newit.Set( &newkey );

	while ( !oldit.End() && !newit.End()) {
		oldkey = *(AttrKey*) oldit.Key();
		newkey = *(AttrKey*) newit.Key();
		long oldId = oldkey.DocId;
		long newId = newkey.DocId;

		if ( oldId < newId ) {
			if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
				chgdocs.insert( oldId );
				std::set<long>::iterator _find = equdocs.find (oldId);
				if (_find != equdocs.end ()) equdocs.erase (_find);
			}
			oldit.next();
		} else if ( oldId == newId ) {
			if ( chgdocs.find( oldId ) == chgdocs.end()) {
				if (b_part_work && (newId < from_id || newId > to_id)) {
					oldit.next();
					newit.next();
					continue;
				}
				Stream* oldstr = oldAttribs->Open( &oldkey );
				Stream* newstr = newAttribs->Open( &newkey );

				int oldlength = oldstr->Length();
				int newlength = newstr->Length();

				bool chg = false;
				if ( oldlength != newlength ) {
					chg = true;
					chgdocs.insert( oldId );
					std::set<long>::iterator _find = equdocs.find (oldId);
					if (_find != equdocs.end ()) equdocs.erase (_find);
				} else {
					char *oldbuf = (char*) malloc( oldlength );
					char *newbuf = (char*) malloc( newlength );
					oldstr->Read( oldbuf, oldlength );
					newstr->Read( newbuf, newlength );
					if ( memcmp( oldbuf, newbuf, oldlength )) {
						chg = true;
						chgdocs.insert (oldId);
						std::set<long>::iterator _find = equdocs.find (oldId);
						if (_find != equdocs.end ()) equdocs.erase (_find);
					}
					free( oldbuf );
					free( newbuf );
				}

				oldAttribs->Close( oldstr );
				newAttribs->Close( newstr );
				if (chg) printf( "Chg: %ld. document: %ld\r", chgdocs.size() - newdocs.size(), oldId);
			}

			oldit.next();
			newit.next();
		} else {
			if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
				chgdocs.insert( newId );
				std::set<long>::iterator _find = equdocs.find (newId);
				if (_find != equdocs.end ()) equdocs.erase (_find);
			}
			newit.next();
		}
	}
	while ( !oldit.End()) {
		long oldId = ((AttrKey*) oldit.Key())->DocId;
		if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
			chgdocs.insert( oldId );
			std::set<long>::iterator _find = equdocs.find (oldId);
			if (_find != equdocs.end ()) equdocs.erase (_find);
		}
		oldit.next();
	}

	//рассмотреть хвост  нового итератора. Это могут быть новые или измененные документы
	while ( !newit.End()) {
		long newId = ((AttrKey*) newit.Key())->DocId;
		if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
			chgdocs.insert( newId );
			std::set<long>::iterator _find = equdocs.find (newId);
			if (_find != equdocs.end ()) equdocs.erase (_find);
		}
		newit.next();
	}
	}

	{
	printf( "\n\nStep4: compare texts\n" ); fflush (stdout);
	std::set<long>::const_iterator equ_it;
	for (equ_it = equdocs.begin (); equ_it != equdocs.end (); equ_it++) {
		long id = *equ_it;
		if (b_part_work && (id < from_id || id > to_id))
			continue;

		//printf ("compare %ld text\r", id);
		Document* olddoc = aBase->GetDoc (id);
		Document* newdoc = aNewBase->GetDoc (id);
		int maxpara = olddoc->Stat.ParaCount;
		int bodyDiff = false;
		for ( long l = 0; l < maxpara && !bodyDiff; l++ ) {
			char* oldpara = olddoc->GetPara ( l );
			char* newpara  = newdoc->GetPara ( l );

			bodyDiff = ParaSize (oldpara) != ParaSize (newpara);
			if (!bodyDiff)
				bodyDiff = memcmp (newpara, oldpara, ParaSize (newpara) + 3);
		}
		delete olddoc;
		delete newdoc;
		if  (bodyDiff) {
			chgtdocs.insert (id);
			chgdocs.insert (id);
			printf( "Chg: %ld, document: %ld\r", chgdocs.size() - newdocs.size(), id ); fflush (stdout);
		}
	}
	std::set<long>::const_iterator chg_it;
	for (chg_it = chgtdocs.begin(); chg_it != chgtdocs.end (); chg_it++) {
		long id = *chg_it;
		std::set<long>::iterator _find = equdocs.find (id);
		if (_find != equdocs.end ()) equdocs.erase (_find);
	}
	chgtdocs.clear ();
	}

	{
	//сравнить индекс SubName
	printf( "\n\nStep5: compare SubName\n" ); fflush (stdout);

	char oldname [DOC_NAME_SIZE*3], newname [DOC_NAME_SIZE*3];

	Index* oldNames = aBase->FindIndex( "SubName" );
	Index* newNames = aNewBase->FindIndex( "SubName" );
	long oldcount = oldNames->KeyCount;
	long newcount = newNames->KeyCount;

	BTIterator oldit( oldNames );
	BTIterator newit( newNames );

	while ( oldcount && ((Ref*) oldit.Key())->DocId < ID_BORDER ) {
		oldit.next();
		oldcount--;
	}

	while ( newcount && ((Ref*) newit.Key())->DocId < ID_BORDER ) {
		newit.next();
		newcount--;
	}

	while ( oldcount && newcount ) {
		Ref oldref = *(Ref*) oldit.Key();
		Ref newref = *(Ref*) newit.Key();

		if ( oldref.Sub || newref.Sub )
			break;

		long oldId = oldref.DocId;
		long newId = newref.DocId;

		bool chg = false;
	
		if ( oldId == newId ) {
			if ( chgdocs.find( oldId ) == chgdocs.end()) {
				if (b_part_work && (newId < from_id || newId > to_id)) {
					oldit.next(); oldcount--;
					newit.next(); newcount--;
					continue;
				}

				Stream* oldstr = oldNames->Open( &oldref );
				Stream* newstr = newNames->Open( &newref );

				if (oldstr && newstr) {
					int oldlength = oldstr->Length();
					int newlength = newstr->Length();

					if ( oldlength != newlength ) {
						chg = true;
						chgdocs.insert( oldId );
						std::set<long>::iterator _find = equdocs.find (oldId);
						if (_find != equdocs.end ()) equdocs.erase (_find);
					} else {
						oldstr->Read( oldname, oldlength );
						newstr->Read( newname, newlength );
						if ( strcmp( oldname, newname )) {
							chg = true;
							chgdocs.insert( oldId );
							std::set<long>::iterator _find = equdocs.find (oldId);
							if (_find != equdocs.end ()) equdocs.erase (_find);
						}
					}
				}
				if (oldstr) oldNames->Close( oldstr );
				if (newstr) newNames->Close( newstr );
			}
			oldit.next(); oldcount--;
			newit.next(); newcount--;
		} else {
			if ( oldId < newId ) {
				if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
					chg = true;
					chgdocs.insert (oldId);
					std::set<long>::iterator _find = equdocs.find (oldId);
					if (_find != equdocs.end ()) equdocs.erase (_find);
				}
				oldit.next();
				oldcount--;
			} else {
				if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
					chg = true;
					chgdocs.insert( newId );
					std::set<long>::iterator _find = equdocs.find (newId);
					if (_find != equdocs.end ()) equdocs.erase (_find);
				}
				newit.next();
				newcount--;
			}
		}
		if ( chg ) {
			printf( "Chg: %ld, document: %ld   \r", chgdocs.size() - newdocs.size(), oldId ); fflush (stdout);
		}
	}
	while ( oldcount && !((Ref*) oldit.Key())->Sub ) {
		long oldId = ((Ref*) oldit.Key())->DocId;
		if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
			chgdocs.insert( oldId );
			std::set<long>::iterator _find = equdocs.find (oldId);
			if (_find != equdocs.end ()) equdocs.erase (_find);
		}
		oldit.next();
		oldcount--;
	}
	while ( newcount && !((Ref*) newit.Key())->Sub ) {
		long newId = ((Ref*) newit.Key())->DocId;
		if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
			chgdocs.insert( newId );
			std::set<long>::iterator _find = equdocs.find (newId);
			if (_find != equdocs.end ()) equdocs.erase (_find);
		}
		newit.next();
		newcount--;
	}

	while ( oldcount && newcount ) {
		Ref oldref = *(Ref*) oldit.Key();
		Ref newref = *(Ref*) newit.Key();

		long oldId = oldref.DocId;
		long newId = newref.DocId;

		bool chg = false;
	
		if ( oldId == newId ) {
			if ( oldref.Sub < newref.Sub ) {
				if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
					chg = true;
					chgdocs.insert( oldId );
					std::set<long>::iterator _find = equdocs.find (oldId);
					if (_find != equdocs.end ()) equdocs.erase (_find);
				}
				oldit.next();
				oldcount--;
			} else if ( oldref.Sub == newref.Sub ) {
				if ( chgdocs.find( oldId ) == chgdocs.end()) {
					if (b_part_work && (newId < from_id || newId > to_id)) {
						oldit.next(); oldcount--;
						newit.next(); newcount--;
						continue;
					}
					Stream* oldstr = oldNames->Open( &oldref );
					Stream* newstr = newNames->Open( &newref );
					if (oldstr && newstr) {
						int oldlength = oldstr->Length();
						int newlength = newstr->Length();

						if ( oldlength != newlength ) {
							chg = true;
							chgdocs.insert( oldId );
							std::set<long>::iterator _find = equdocs.find (oldId);
							if (_find != equdocs.end ()) equdocs.erase (_find);
						} else {
							oldstr->Read( oldname, oldlength );
							newstr->Read( newname, newlength );
							if ( strcmp( oldname, newname )) {
								chg = true;
								chgdocs.insert( oldId );
								std::set<long>::iterator _find = equdocs.find (oldId);
								if (_find != equdocs.end ()) equdocs.erase (_find);
							}
						}
					}
					if (oldstr) oldNames->Close( oldstr );
					if (newstr) newNames->Close( newstr );
				}
				oldit.next(); oldcount--;
				newit.next(); newcount--;
			} else {
				if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
					chg = true;
					chgdocs.insert( newId );
					std::set<long>::iterator _find = equdocs.find (newId);
					if (_find != equdocs.end ()) equdocs.erase (_find);
				}
				newit.next();
				newcount--;
			}
		} else {
			if ( oldId < newId ) {
				if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
					chg = true;
					chgdocs.insert( oldId );
					std::set<long>::iterator _find = equdocs.find (oldId);
					if (_find != equdocs.end ()) equdocs.erase (_find);
				}
				oldit.next();
				oldcount--;
			} else {
				if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
					chg = true;
					chgdocs.insert( newId );
					std::set<long>::iterator _find = equdocs.find (newId);
					if (_find != equdocs.end ()) equdocs.erase (_find);
				}
				newit.next();
				newcount--;
			}
		}
		if ( chg ) {
			printf( "Chg: %ld, document: %ld   \r", chgdocs.size() - newdocs.size(), oldId ); fflush (stdout);
		}
	}
	while ( oldcount ) {
		long oldId = ((Ref*) oldit.Key())->DocId;
		if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end()) {
			chgdocs.insert( oldId );
			std::set<long>::iterator _find = equdocs.find (oldId);
			if (_find != equdocs.end ()) equdocs.erase (_find);
		}
		oldit.next();
		oldcount--;
	}
	while ( newcount ) {
		long newId = ((Ref*) newit.Key())->DocId;
		if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end()) {
			chgdocs.insert( newId );
			std::set<long>::iterator _find = equdocs.find (newId);
			if (_find != equdocs.end ()) equdocs.erase (_find);
		}
		newit.next();
		newcount--;
	}
	}

	{
	//сравнить индекс Respondent
	printf( "\n\nStep6: compare Respondent\n" ); fflush (stdout);

	Index* oldresps = aBase->FindIndex( "Respondent" );
	Index* newresps = aNewBase->FindIndex( "Respondent" );

	BTIterator oldit( oldresps );
	BTIterator newit( newresps );

	while ( !oldit.End() && !newit.End()) {
		long oldId = *(long*) oldit.Key();
		long newId = *(long*) newit.Key();

		bool chg = false;
	
		if ( oldId == newId ) {
			if ( chgdocs.find( oldId ) == chgdocs.end() && equdocs.find( oldId ) != equdocs.end() ) {
				if (b_part_work && (newId < from_id || newId > to_id)) {
					oldit.next();
					newit.next();
				}
				Stream* oldstr = oldresps->Open( &oldId );
				Stream* newstr = newresps->Open( &newId );
				if (oldstr && newstr) {
					int oldlength = oldstr->Length();
					int newlength = newstr->Length();

					if ( oldlength != newlength ) {
						chg = true;
						chgdocs.insert( oldId );
						std::set<long>::iterator _find = equdocs.find (oldId);
						if (_find != equdocs.end ()) equdocs.erase (_find);
					} else {
						char *oldbuf = (char*) malloc( oldlength );
						char *newbuf = (char*) malloc( newlength );
						oldstr->Read( oldbuf, oldlength );
						newstr->Read( newbuf, newlength );
						if ( memcmp( oldbuf, newbuf, oldlength )) {
							chg = true;
							chgdocs.insert( oldId );
							std::set<long>::iterator _find = equdocs.find (oldId);
							if (_find != equdocs.end ()) equdocs.erase (_find);
						}
						free( oldbuf );
						free( newbuf );
					}
				}
				if (oldstr) oldresps->Close( oldstr );
				if (newstr) newresps->Close( newstr );
			}
			oldit.next();
			newit.next();
		} else {
			if ( oldId < newId ) {
				if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end() && equdocs.find( oldId ) != equdocs.end()) {
					chg = true;
					chgdocs.insert( oldId );
					std::set<long>::iterator _find = equdocs.find (oldId);
					if (_find != equdocs.end ()) equdocs.erase (_find);
				}
				oldit.next();
			} else {
				if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end() && equdocs.find( oldId ) != equdocs.end()) {
					chg = true;
					chgdocs.insert( newId );
					std::set<long>::iterator _find = equdocs.find (newId);
					if (_find != equdocs.end ()) equdocs.erase (_find);
				}
				newit.next();
			}
		}
		if ( chg ) {
			printf( "Chg: %ld, document: %ld   \r", chgdocs.size() - newdocs.size(), oldId ); fflush (stdout);
		}
	}
	while ( !oldit.End()) {
		long oldId = *(long*) oldit.Key();
		if ( chgdocs.find( oldId ) == chgdocs.end() && deldocs.find( oldId ) == deldocs.end() && equdocs.find( oldId ) != equdocs.end()) {
			chgdocs.insert( oldId );
			std::set<long>::iterator _find = equdocs.find (oldId);
			if (_find != equdocs.end ()) equdocs.erase (_find);
		}
		oldit.next();
	}
	while ( !newit.End()) {
		long newId = *(long*) newit.Key();
		if ( newdocs.find( newId ) == newdocs.end() && chgdocs.find( newId ) == chgdocs.end() && equdocs.find( newId ) != equdocs.end()) {
			chgdocs.insert( newId );
			std::set<long>::iterator _find = equdocs.find (newId);
			if (_find != equdocs.end ()) equdocs.erase (_find);
		}
		newit.next();
	}
	}

	printf( "\n\nReplace revisions\n" ); fflush (stdout);

	delete aBase;
	delete aNewBase;

	if (b_part_work) {
		char part_file_name [32];
		sprintf (part_file_name, "fastrev_%ld.part", from_part);
		FILE* part_file = mpcxc_fopen (part_file_name, "w" );
		std::map<long,revision>::iterator revsiter;
		char str [128];
		for (std::set<long>::const_iterator docs_iter = docs_to_process.begin (); docs_iter != docs_to_process.end (); docs_iter++) {
			long id = *docs_iter;
			if (equdocs.find (id) != equdocs.end ()) {
				revision rev = revs->find(id)->second;
				sprintf (str, "%ld: %ld/%ld/%ld\n", id, rev.RevisionDate.da_day, rev.RevisionDate.da_mon, rev.RevisionDate.da_year);
				fputs (str, part_file);
			} else if (b_set_revision) {
				sprintf (str, "%ld: %ld/%ld/%ld\n", id, rrevision.RevisionDate.da_day, rrevision.RevisionDate.da_mon, rrevision.RevisionDate.da_year);
				fputs (str, part_file);
			}
		}
		fclose (part_file);
	} else {
		StdBigBase *aNewBigBase = new StdBigBase (argv[2], ACE_OS_O_RDWR);

		std::map<long,revision>::iterator revsiter;
		for ( it = equdocs.begin(); it != equdocs.end(); it++ ) {
			long id = *it;
			revision rev = revs->find(id)->second;

			DocInfo docinfo;
			aNewBigBase->FindDocInfo( id, docinfo );
			docinfo.Revision = rev;
			aNewBigBase->ReplaceAttr( id, IDD_INFO, &docinfo, sizeof( docinfo ));
		}
		if ( b_set_revision ) {
			for ( it = chgdocs.begin(); it != chgdocs.end(); it++ ) {
				long id = *it;
				DocInfo docinfo;
				aNewBigBase->FindDocInfo( id, docinfo );
				docinfo.Revision = rrevision;
				aNewBigBase->ReplaceAttr( id, IDD_INFO, &docinfo, sizeof( docinfo ));
			}
			BaseInfoSet bis( aNewBigBase );
			bis.ReplaceRevision( rrevision );
			bis.SaveInfo( aNewBigBase );

			aNewBigBase->SetReady(TID_GREV_2);
		}

		aNewBigBase->SetReady(TID_GREV_1);
		delete aNewBigBase;
	}

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
