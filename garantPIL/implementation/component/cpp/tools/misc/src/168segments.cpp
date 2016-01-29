#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
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

std::map<long, DocCollection*> map_belongs_docs;

int main_logic ( int argc, char *argv[] )
{
	SearchBase* base = new SearchBase (argv [1]);
	base->IsOk ();
	delete base->AllDocs ();

	FILE *rules = fopen (argv [2], "rt");
	if (!rules)
		exit (EXIT_FAILURE);

	std::vector<std::string> search_request;	
	while (!feof (rules)) {
		char buffer [16384];
		if (!fgets (buffer, sizeof (buffer), rules))
			break;
		
		int length = strlen (buffer);
		while (length && (buffer [length-1] == 10 || buffer [length-1] == 13))
			buffer [--length] = 0;

		if (!length)
			continue;

		Recoding (cd_dos, cd_win, buffer);

		if (strstr (buffer, "[Belongs=") == buffer) {
			if (0 == search_request.size ())
				continue;
			SearchResult* search_result = base->execute_search (search_request);
			if (search_result) {
				if (search_result->list && search_result->list->ItemCount) {
					int belongs = atol (buffer + 9);
					DocCollection docs;
					docs.Merge (*search_result->list);
					if (docs.ItemCount == 0) {
						printf ("cant merge result for rule:\n");
						for (std::vector<std::string>::const_iterator str_it = search_request.begin (); str_it != search_request.end (); str_it++)
							printf ("%s\n", str_it->c_str ());
						printf ("\n");
					}
					delete search_result->list;

					std::map<long,DocCollection*>::iterator map_it = map_belongs_docs.find (belongs);
					if (map_it == map_belongs_docs.end ()) {
						DocCollection *map_docs = new DocCollection (docs);
						map_belongs_docs.insert (std::map<long,DocCollection*>::value_type (belongs, map_docs));
					} else {
						map_it->second->Merge (docs);
					}
				} else {
					printf ("empty result for rule:\n");
					for (std::vector<std::string>::const_iterator str_it = search_request.begin (); str_it != search_request.end (); str_it++)
						printf ("%s\n", str_it->c_str ());
					printf ("\n");
				}
				delete search_result;

			}
			search_request.clear ();
		} else {
			search_request.push_back (buffer);
		}
	}
	fclose (rules);
	delete base;

	FILE *gchange = fopen (argv [3], "wt");
	if (!gchange)
		exit (EXIT_FAILURE);

	char str_to_write [1024];
	strcpy (str_to_write, "once\n");
	fputs (str_to_write, gchange);
	for (std::map<long,DocCollection*>::const_iterator map_it = map_belongs_docs.begin (); map_it != map_belongs_docs.end (); map_it++) {
		int i;
		DocCollection *docs = map_it->second;

		sprintf (str_to_write, "  BelongsForIds.add(%ld", map_it->first);
		fputs (str_to_write, gchange);
		for (i = 0; i < docs->ItemCount; i++) {
			sprintf (str_to_write, ",%ld", (*docs)[i]);
			fputs (str_to_write, gchange);
		}
		strcpy (str_to_write, ");\n");
		fputs (str_to_write, gchange);

		sprintf (str_to_write, "  BelongsForIdsRelateds.add(%ld", map_it->first);
		fputs (str_to_write, gchange);
		for (i = 0; i < docs->ItemCount; i++) {
			sprintf (str_to_write, ",%ld", (*docs)[i]);
			fputs (str_to_write, gchange);
		}
		strcpy (str_to_write, ");\n");
		fputs (str_to_write, gchange);

		sprintf (str_to_write, "  BelongsForIdsEditions.add(%ld", map_it->first);
		fputs (str_to_write, gchange);
		for (i = 0; i < docs->ItemCount; i++) {
			sprintf (str_to_write, ",%ld", (*docs)[i]);
			fputs (str_to_write, gchange);
		}
		strcpy (str_to_write, ");\n");
		fputs (str_to_write, gchange);

		sprintf (str_to_write, "  BelongsForIdsBlobs.add(%ld", map_it->first);
		fputs (str_to_write, gchange);
		for (i = 0; i < docs->ItemCount; i++) {
			sprintf (str_to_write, ",%ld", (*docs)[i]);
			fputs (str_to_write, gchange);
		}
		strcpy (str_to_write, ");\n");
		fputs (str_to_write, gchange);
	}
	strcpy (str_to_write, "end\n\n");
	fputs (str_to_write, gchange);
	fclose (gchange);
	
	return 0;
}
