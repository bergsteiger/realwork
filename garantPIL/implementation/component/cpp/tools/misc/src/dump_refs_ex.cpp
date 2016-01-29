#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"
#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "SearchB.h"

#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

int main ( int argc, char *argv[] ) {
	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->check_version ();
	base->IsOk ();

	FILE *topics_file = fopen (argv [2], "rt");
	DocCollection docs;
	while (!feof (topics_file)) {
		char str [256];

		if (!fgets (str, sizeof (str), topics_file))
			break;

		int length = strlen (str);
		if (length && (str [length-1] == 10 || str [length-1] == 13))
			str [--length] = 0;

		long doc = atol (str) + ID_BORDER;
		if (doc)
			docs.Insert (&doc);

	}
	fclose (topics_file);

	for (int i = 0; i < docs.ItemCount; i++) {
		long doc = docs [i];

		Document *pDoc = base->GetDoc (doc);
		if (!pDoc)
			continue;

		if (!(pDoc->Stat.Status & DS_EVD) || !pDoc->IsOk ()) {
			delete pDoc;
			continue;
		}

		long j, resps_size = 0;
		RespRef *resps = (RespRef*) base->LoadAttr (doc, IDD_REFS, resps_size), *ptr = resps;
		if (resps_size) {
			resps_size /= sizeof (RespRef);
			std::map<u_int64_t,long> map_ref_count;
			for (ptr = resps, j = 0; j < resps_size; j++, ptr++) {
				u_int64_t at_i = (((u_int64_t) ptr->DocId) << 32) + ptr->Sub;
				std::map<u_int64_t,long>::iterator map_ref_count_it = map_ref_count.find (at_i);
				if (map_ref_count_it == map_ref_count.end ())
					map_ref_count.insert (std::map<u_int64_t,long>::value_type (at_i, 1));
				else
					map_ref_count_it->second++;
			}
			printf ("%ld:", doc);
			for (std::map<u_int64_t,long>::const_iterator map_it = map_ref_count.begin (); map_it != map_ref_count.end (); map_it++)
				for (j = 0; j < map_it->second; j++)
					printf (" %ld.%ld", (long) (map_it->first >> 32), (long) (map_it->first & 0xFFFFFFFF));
			printf ("\n");
			gk_free (resps);
		}
	}

	delete base;

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
