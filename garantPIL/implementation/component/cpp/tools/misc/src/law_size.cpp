#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "garutils.h"
#include "stdbase.h"

#include <stack>

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int	StrRev (char *pStr, revision& theRev)
{	
	unsigned short day, month, year, hour, min, find;
	find = sscanf( pStr, "%hd/%hd/%hd:%hd:%hd", &day, &month, &year, &hour, &min );

	if ( find != 3 && find != 5 ) return 0;
	if ( day > 31 || month > 12 ) return 0;
	if ( year < 100 ) year += 2000;
	theRev.RevisionDate.da_day = (unsigned char)day;
	theRev.RevisionDate.da_mon = (unsigned char)month;
	theRev.RevisionDate.da_year = year;
	if ( find == 5 ) {
		if ( hour > 23 || min > 59 ) return 0;
		theRev.RevisionTime.ti_min = (unsigned char)min;
		theRev.RevisionTime.ti_hour = (unsigned char)hour;
	} else {
		theRev.RevisionTime.ti_min = 0;
		theRev.RevisionTime.ti_hour = 0;
	}
	return 1;
}

int main_logic ( int argc, char *argv[] )
{
	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);

	revision from, to, vincluded;
	gk_bzero (&vincluded, sizeof (revision));
	gk_bzero (&from, sizeof (revision));
	gk_bzero (&to, sizeof (revision));
	from.RevisionDate.da_year = 1900;
	to.RevisionDate.da_year = 2099;
	if (argc > 2) StrRev (argv [2], from);
	if (argc > 3) StrRev (argv [3], to);

	DocCollection laws;
	for (BTIterator btit(base->FindIndex ("Type")); !btit.End (); ++btit) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
		if (key->level == 0 && (!strcmp (key->text + 4, "Закон") || !strcmp (key->text + 4, "Устав"))) {
			Stream* str = base->FindIndex ("Type")->Index::OpenN (key, 0);
			if (str) {
				DocCollection docs;
				docs.FastLoadRefs (str);
				base->FindIndex ("Type")->Close (str);
				laws.Merge (docs);
			}
		}
	}

	std::vector<long> docs_to_process;
	for (int i = 0; i < laws.ItemCount; i++) {
		long doc_id = laws [i], size = 0;
		DocInfo docinfo;
		base->FindDocInfo (doc_id, docinfo);
		if (!(docinfo.Status & DS_DOC))
			continue;

		date *vincluded_date = (date*) base->LoadAttr (doc_id, IDD_VINCLUDED, size);
		if (size) {
			vincluded.RevisionDate = *vincluded_date;
			if (CompRevs (&from, &vincluded) <= 0 && CompRevs (&vincluded, &to) <= 0)
				docs_to_process.push_back (doc_id);
			gk_free (vincluded_date);
		}
	}

	long total_size = 0, tables_size = 0;
	for (std::vector<long>::const_iterator it = docs_to_process.begin (); it != docs_to_process.end (); it++) {
		long doc_id = *it;
		Document* doc = base->GetDoc (doc_id);
		long doc_size = 0;
		for (int i = 0; i < doc->Stat.ParaCount; i++) {
			char *ptr = doc->GetPara (i);
			unsigned len = doc->EVDTextSize (ptr);
			const char *src = doc->EVDParaText (ptr);
			for (int j = 0; j < len; j++)
				if (*(src+j) != ' ') {
					doc_size++;
					/*
					if (strchr ("ЪВїіГЕґДАБЩ", *(src+j)))
						tables_size++;
					*/
				}
		}
		total_size += doc_size;
		delete doc;
	}
	delete base;

	printf ("законов+уставов: %ld; из размер: %ld байт; с %ld.%ld.%ld по %ld.%ld.%ld; %s\n", docs_to_process.size (), total_size, from.RevisionDate.da_day, from.RevisionDate.da_mon, from.RevisionDate.da_year, to.RevisionDate.da_day, to.RevisionDate.da_mon, to.RevisionDate.da_year, argv [1]);
	return 0;
}
