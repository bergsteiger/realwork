#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "SearchB.h"

#include <utility>
#include <math.h>

#include "shared/Core/sys/AutoInit.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	Core::AutoInit init;

	if ( argc < 2 )
		return 0;

	ToolsBase *base = new ToolsBase (argv [1]);

	bool b_docsonly = argv [3] && !stricmp (argv [3], "docs");

	FILE *rulesFile = fopen (argv [2], "rt");
	std::vector<std::string> strings_to_execute;
	while (!feof (rulesFile)) {
		char str [2048];

		if (!fgets (str, sizeof (str), rulesFile))
			break;

		int length = strlen (str);
		if (length && (str [length-1] == 10 || str [length-1] == 13))
			str [--length] = 0;

		if (!strlen (str)) {
			if (strings_to_execute.size ()) {
				SearchResult* result = base->execute_search (strings_to_execute);
				if (result) {
					SortedCollection* list = result->list;
					if (list) {
						for (std::vector<std::string>::const_iterator it = strings_to_execute.begin (); it != strings_to_execute.end (); it++)
							if (!b_docsonly)
								printf ("%s\n", it->c_str ());
						if (!b_docsonly)
							printf ("found: %ld\n", list->ItemCount);

						if (b_docsonly) {
							DocCollection *docs = new DocCollection ();
							if (list->Tag () == OT_DOCCOLLECTION) {
								docs->Move (*list);
							} else if (list->Tag () == OT_REFCOLLECTION) {
								docs->Merge (*list);
							} else if (list->Tag () == OT_RELECOLLECTION || list->Tag () == OT_RELESUBCOLLECTION) {
								for (int i = 0; i < list->ItemCount; i++) {
									RefwRele ati = *(RefwRele*) list->GetItem (i);
									docs->Insert (&ati.DocId);
								}
							}
							delete list;
							list = docs;
						}
						if (list->Tag () == OT_DOCCOLLECTION) {
							for (int i = 0; i < list->ItemCount; i++)
								printf ("%ld\n", *(long*)list->GetItem (i));
						} else if (list->Tag () == OT_REFCOLLECTION) {
							for (int i = 0; i < list->ItemCount; i++) {
								Ref ati = *(Ref*) list->GetItem (i);
								printf ("%ld.%ld\n", ati.DocId, ati.Sub);
							}
						} else if (list->Tag () == OT_RELECOLLECTION || list->Tag () == OT_RELESUBCOLLECTION) {
							for (int i = 0; i < list->ItemCount; i++) {
								RefwRele ati = *(RefwRele*) list->GetItem (i);
								printf ("%ld.%ld.%ld\n", ati.DocId, ati.Word, ati.Rele);
							}
						} else {
							printf ("unknown collection type\n");
						}
						printf ("\n");
						delete list;
					}
					delete result;
				}
				strings_to_execute.clear ();
			}
		} else {
			strings_to_execute.push_back (str);
		}
	}
	fclose (rulesFile);

	delete base;

	exit (EXIT_SUCCESS);
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
