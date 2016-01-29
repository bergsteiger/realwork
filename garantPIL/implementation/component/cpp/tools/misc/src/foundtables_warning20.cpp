#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "shared/Core/os/IniFile.h"
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"
#include "basemask.h"

#include "SearchB.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

static inline void getDate (const char *s, int l, date &d)
{
	const char *p = s;
	const char *dd;
	const char *mm;
	const char *yyyy;

	if (!l) return;
	while (*p == ' ' || *p == '\t') p++;
	if (*p >= '0' && *p <= '9') dd = p;
	while (*p >= '0' && *p <= '9') p++; p++;
	if (*(p-1) == '/' && *p >= '0' && *p <= '9') mm = p;
	while (*p >= '0' && *p <= '9') p++; p++;
	if (*(p-1) == '/' && *p >= '0' && *p <= '9') yyyy = p;
	d.da_day = atoi( dd );
	d.da_mon = atoi( mm );
	d.da_year = atoi( yyyy );
	while (*p >= '0' && *p <= '9') p++;
	while ((*p == ' ' || *p <= '\t') && p-s < l) p++;
}

int main_logic ( int argc, char *argv[] )
{
	{
		/*
		if (argc < 4)
			exit (-1);
		*/

		SearchBase* base = new SearchBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		base->is_morpho_exist();
		base->check_version();
		base->get_index ("Status");
		base->FindIndex ("Attrs");

		/*
		date from_date, to_date;
		getDate (argv [2], strlen (argv [2]), from_date);
		getDate (argv [3], strlen (argv [3]), to_date);

		AttrKey set_key = {ID_BORDER, IDD_WARNING};
		for (BTIterator it (base->FindIndex ("Attrs"), &set_key); !it.End (); ++it) {
			AttrKey *key = (AttrKey*) it.Key ();
			if (key->AttrTag != IDD_WARNING)
				break;
			long id = key->DocId, size = 0;

			char* warning = (char*) base->LoadAttr (id, IDD_WARNING, size);
			if (size && !strcmp (warning, "Внимание! Настоящий документ не прошел корректорскую вычитку по официальному источнику")) {
				date* idd_vincluded = (date*) base->LoadAttr (id, IDD_VINCLUDED, size);
				if (!size)
					continue;

				if (CompDates (&from_date, idd_vincluded) <= 0 && CompDates (idd_vincluded, &to_date) <= 0)
					printf ("%ld\n", id);
			}			
		}
		*/

		DocCollection *all_docs = base->AllTopics (ID_BORDER);
		for (int i = 0; i < all_docs->ItemCount; i++) {
			long id = (*all_docs) [i];
			Document *doc = base->GetDoc (id);
			for (int j = 0; j < doc->Stat.ParaCount; j++) {
				char *para = doc->GetPara (j);
				int size = doc->EVDTextSize (para);
				para = doc->EVDParaText (para);
				bool found = false;
				for (int k = 0; k < size && !found; k++)
					if ((unsigned char)para [k] == 192 || (unsigned char)para [k] == 195 || (unsigned char)para [k] == 197 || (unsigned char)para [k] == 180)
						found = true;
				if (found) {
					printf ("%ld\n", id - ID_BORDER);
					break;
				}
			}
			delete doc;
		}
		
		exit (EXIT_SUCCESS);
	}
}

