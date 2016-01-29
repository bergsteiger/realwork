#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "SearchB.h"

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

int StrRev( char * pStr, revision& theRev )
{	
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

	return 1;
}

int main_logic ( int argc, char *argv[] )
{
	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->IsOk ();
	Index *docind = base->FindIndex ("Attrs");

	Stream* str = base->FindIndex ("Aux")->Open ("Here");
	long seg_count = str->Length () / 2;
	short *here_segs = new short [seg_count], *ptr = here_segs;
	str->Read (here_segs, seg_count << 1);
	base->FindIndex ("Aux")->Close (str);

	std::map<int,u_int64_t> count_less100kb, count_more100kb, count_law, size_less100kb, size_more100kb, size_law;
	std::set<int> heres;

	if (seg_count > 1) {
		count_less100kb.insert (std::map<int,u_int64_t>::value_type (0, 0));
		count_more100kb.insert (std::map<int,u_int64_t>::value_type (0, 0));
		count_law.insert (std::map<int,u_int64_t>::value_type (0, 0));
		size_less100kb.insert (std::map<int,u_int64_t>::value_type (0, 0));
		size_more100kb.insert (std::map<int,u_int64_t>::value_type (0, 0));
		size_law.insert (std::map<int,u_int64_t>::value_type (0, 0));
		heres.insert (0);
	}
	for (int i = 0; i < seg_count; i++, ptr++) {
		heres.insert (*ptr);
		count_less100kb.insert (std::map<int,u_int64_t>::value_type (*ptr, 0));
		count_more100kb.insert (std::map<int,u_int64_t>::value_type (*ptr, 0));
		count_law.insert (std::map<int,u_int64_t>::value_type (*ptr, 0));
		size_less100kb.insert (std::map<int,u_int64_t>::value_type (*ptr, 0));
		size_more100kb.insert (std::map<int,u_int64_t>::value_type (*ptr, 0));
		size_law.insert (std::map<int,u_int64_t>::value_type (*ptr, 0));
	}
	delete [] here_segs;

	bool b_topics = false;
	
	revision from, to;
	gk_bzero (&from, sizeof (from));
	gk_bzero (&to, sizeof (to));

	DocCollection* alltopics = base->AllTopics (ID_BORDER);

	if (argv [2]) {
		FILE *in_file = fopen (argv [2], "rt");
		if (in_file) {
			alltopics->FreeAll ();
			b_topics = true;

			while (!feof (in_file)) {
				char str [2048];

				if (!fgets (str, sizeof (str), in_file))
					break;

				int length = strlen (str);
				if (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;

				if (!strlen (str))
					continue;

				long id = atol (str);
				alltopics->Insert (&id);
			}
			fclose (in_file);
		} else {
			StrRev (argv [2], from);
			StrRev (argv [3], to);
		}
	} else {
		return 0;
	}

	DocCollection laws;
	for (BTIterator it (base->FindIndex ("Type")); !it.End (); ++it) {
		HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
		if (!strcmp (key->text + 4, "Çàêîí") || !strcmp (key->text + 4, "Óñòàâ")) {
			Stream* str = base->FindIndex ("Type")->Index::OpenN (key, 0);
			if (str) {
				DocCollection docs;
				docs.FastLoadRefs (str);
				base->FindIndex ("Type")->Close (str);
				laws.Merge (docs);
			}
		}
	}

	AttrKey	included_key = { 0, IDD_VINCLUDED };
	IndexLoader loader (base);
	for (int i = 0; i < alltopics->ItemCount; i++) {
		long id = (*alltopics) [i], size = 0;
		date vincluded;
		if (!b_topics) {
			included_key.DocId = id;
			Stream *str = docind->Open (&included_key);
			if (!str)
				continue;
			str->Read (&vincluded, sizeof (vincluded));
			docind->Close (str);
		}

		if (b_topics || ((is_lt (vincluded, to.RevisionDate) || is_eq (vincluded, to.RevisionDate)) && (is_lt (from.RevisionDate, vincluded) || is_eq (from.RevisionDate, vincluded)))) {
			Document *doc = base->GetDoc (id);
			for (int j = 0; j < doc->Stat.ParaCount; j++) {
				char* para = doc->GetPara (j);
				long parasize = doc->EVDTextSize (para);
				para = doc->EVDParaText (para);
				for (int k = 0; k < parasize; k++, para++) {
					if (strchr (" ¿ÂÃÚÅ´Ä³ÀÁÙ", *para) == 0)
						size++;
				}
				//size += doc->EVDTextSize (doc->GetPara (j));
			}
			delete doc;

			long belongs_count;
			INDEX_DATA (short) belongs = loader.load <short> (id, IDD_BASES, belongs_count, true);
			if (belongs.ptr ()) {
				short* belongs_ptr = belongs.ptr ();
				for (int belong = 0; belong <= belongs_count; belongs_ptr++, belong++) {
					short at = belong == belongs_count ? 0 : *belongs_ptr;

					if (heres.find (at) == heres.end ())
						continue;

					if (laws.IndexOf (&id) != -1) {
						count_law.find (at)->second++;
						size_law.find (at)->second += size;
					}

					if (size <= 102400) {
						count_less100kb.find (at)->second++;
						size_less100kb.find (at)->second += size;
					} else {
						count_more100kb.find (at)->second++;
						size_more100kb.find (at)->second += size;
					}
				}
			}
		}
	}

	for (std::set<int>::const_iterator it = heres.begin (); it != heres.end (); it++) {
		BaseInfo bi;
		base->FindBaseInfo (*it, bi);
		printf ("%s;%s - %s;%lld;%lld;%lld;%lld;%lld;%lld\n", bi.Name, b_topics ? "?" : argv [2], b_topics ? "?" : argv [3], count_less100kb.find (*it)->second, size_less100kb.find (*it)->second, count_more100kb.find (*it)->second, size_more100kb.find (*it)->second, count_law.find (*it)->second, size_law.find (*it)->second);
	}

	delete alltopics;
	delete base;

	return 0;
}
