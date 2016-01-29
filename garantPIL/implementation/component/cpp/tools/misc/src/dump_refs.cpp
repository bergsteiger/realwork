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

		EndtTools::EndtParser obj (base);
		Core::Aptr <EndtTools::LongVector> refs = obj.get_resp_documents (pDoc, true);
		delete pDoc;

		if ( refs->size()) {
			printf ("%ld:", doc);
			EndtTools::LongVector::const_iterator it = refs->begin();
			for ( ; it != refs->end(); it++ )
				printf (" %ld", *it);
			printf ("\n");
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
