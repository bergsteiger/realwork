#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "newdoc.h"
#include "advlog.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"
#include "long.long.SplayMap.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

#include "SearchB.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		if (!argv [2])
			exit (-1);

		SearchBase *base = new SearchBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		base->check_version ();
		base->FindIndex ("Attrs");

		revision from, to, vincluded;
		gk_bzero (&vincluded, sizeof (revision));
		gk_bzero (&from, sizeof (revision));
		gk_bzero (&to, sizeof (revision));

		date from_date, to_date;
		from_date.da_day = 1;
		from_date.da_mon = atol (argv [2]);
		from_date.da_year = atol (strchr (argv [2], '.') + 1);
		from.RevisionDate = from_date;

		to_date = from_date;
		to_date.da_day = 31;
		to.RevisionDate = to_date;

		IndexLoader loader (base);
		DocCollection* alldocs = base->AllTopics (ID_BORDER);
		std::vector<long> docs_to_process;

		for (int i = 0; i < alldocs->ItemCount; i++) {
			long doc_id = (*alldocs) [i];
			if (doc_id >= BIG_INFO_DOC && doc_id < BIG_INFO_DOC + BIG_INFO_COUNT)
				continue;
			
			long size;
			date *vincluded_date = (date*) base->LoadAttr (doc_id, IDD_VINCLUDED, size);
			if (size) {
				vincluded.RevisionDate = *vincluded_date;
				if (CompRevs (&from, &vincluded) <= 0 && CompRevs (&vincluded, &to) <= 0)
					docs_to_process.push_back (doc_id);
				gk_free (vincluded_date);
			}
		}

		std::map<long,long> map_seg_docs_b100; //ключ - сегмент, данные - количество документов размером below 100k
		std::map<long,long> map_seg_docs_a100;
		std::map<long,long> map_seg_docssize_b100;
		std::map<long,long> map_seg_docssize_a100;
		std::map<long,long> map_seg_tablessize_b100;
		std::map<long,long> map_seg_tablessize_a100;

		for (int i = 1; i < 300; i++) {
			map_seg_docs_b100.insert (std::map<long,long>::value_type (i, 0));
			map_seg_docs_a100.insert (std::map<long,long>::value_type (i, 0));
			map_seg_docssize_b100.insert (std::map<long,long>::value_type (i, 0));
			map_seg_docssize_a100.insert (std::map<long,long>::value_type (i, 0));
			map_seg_tablessize_b100.insert (std::map<long,long>::value_type (i, 0));
			map_seg_tablessize_a100.insert (std::map<long,long>::value_type (i, 0));
		}

		for (std::vector<long>::const_iterator it = docs_to_process.begin (); it != docs_to_process.end (); it++) {
			long doc_id = *it;

			DocInfo docinfo;
			base->FindDocInfo (doc_id, docinfo);

			bool *intable = new bool [docinfo.ParaCount];
			gk_bzero (intable, sizeof (bool) * docinfo.ParaCount);

			long subs_count;
			SubDescEx *org_subs = (SubDescEx*) base->LoadAttr (doc_id, IDD_SUBS_EX, subs_count), *subs = org_subs;
			subs_count /= sizeof (SubDescEx);
			if (subs_count) {
				long i, from_para;
				for (i = 0; i < subs_count; i++, subs++) {
					unsigned short flags = subs->Flags;
					if (flags == SUBDESCEX_TABLE) {
						from_para = subs->Para;
					} else if (flags == SUBDESCEX_TABLEEND) {
						for (long j = from_para; j < subs->Para; j++)
							intable [j] = true;
					}
				}
			}
			gk_free (org_subs);

			long doc_size = 0, intable_size = 0;
			Document *doc = base->GetDoc (doc_id);
			for (int i = 0; i < docinfo.ParaCount; i++) {
				char *ptr = doc->GetPara (i);
				unsigned len = doc->EVDTextSize (ptr);
				const char *src = doc->EVDParaText (ptr);
				for (int j = 0; j < len; j++)
					if (*(src+j) != ' ') {
						doc_size++;
						if (intable [i])
							intable_size++;
					}
			}
			delete doc;

			long belongs_count;
			INDEX_DATA (short) belongs = loader.load <short> (doc_id, IDD_BASES, belongs_count, true);
			if (belongs.ptr ()) {
				short* belongs_ptr = belongs.ptr ();
				for (int belong = 0; belong < belongs_count; belongs_ptr++, belong++) {
					long segment = *belongs_ptr;
					if (doc_size < 100*1024) {
						map_seg_docs_b100.find (segment)->second++;
						map_seg_docssize_b100.find (segment)->second += doc_size;
						map_seg_tablessize_b100.find (segment)->second += intable_size;
					} else {
						map_seg_docs_a100.find (segment)->second++;
						map_seg_docssize_a100.find (segment)->second += doc_size;
						map_seg_tablessize_a100.find (segment)->second += intable_size;
					}
				}
			}
		}

		for (int i = 1; i < 300; i++) {
			long docs_b100 = map_seg_docs_b100.find (i)->second;
			long docs_a100 = map_seg_docs_a100.find (i)->second;
			if (docs_b100 == 0 && docs_a100 == 0)
				continue;
			BaseInfo baseinfo;
			base->FindBaseInfo (i, baseinfo);
			printf ("%ld;%s;%ld;%ld;%ld;%ld;%ld;%ld\n", i, baseinfo.Name, docs_b100, map_seg_docssize_b100.find(i)->second, map_seg_tablessize_b100.find(i)->second, docs_a100, map_seg_docssize_a100.find(i)->second, map_seg_tablessize_a100.find(i)->second );
		}

		delete base;
		exit (EXIT_SUCCESS);
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
