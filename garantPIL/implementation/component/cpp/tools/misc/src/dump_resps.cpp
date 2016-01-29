#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"
#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

int main ( int argc, char *argv[] ) {
	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);

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
		docs.Insert (&doc);

	}
	fclose (topics_file);

	DocCollection *all_topics = base->AllTopics (ID_BORDER);
	for (int i = 0; i < all_topics->ItemCount; i++) {
		long doc = (*all_topics) [i];
		Document *pDoc = base->GetDoc (doc);
		if (!(pDoc->Stat.Status & DS_EVD)) {
			delete pDoc;
			continue;
		}

		EndtTools::EndtParser obj (base);
		Core::Aptr <EndtTools::LongVector> refs = obj.get_resp_documents (pDoc, true);
		delete pDoc;
		
		if (!refs)
			continue;

		if ( refs->size()) {
			EndtTools::LongVector::const_iterator it = refs->begin();
			bool b_sect = false;
			for ( ; it != refs->end(); it++ ) {
				long resp = *it;
				if (docs.IndexOf (&resp) != -1) {
					b_sect = true;
					break;
				}
			}
			if (b_sect)
				printf ("%ld\n", doc);
		}
	}
	delete all_topics;

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
