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
#include "protect.h"
#include "pack.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{	
	{
		SearchBase *base = new SearchBase (argv [1]);
		base->check_version ();
		base->IsOk ();
		YBase *stdbase = new YBase (argv [1], ACE_OS_O_RDONLY);
		FILE *in_file = fopen (argv [2], "rt");
		long size = 10000000;
		if (argv [3]) size = atol (argv [3]) * 1024;
		int out_count = 1;
		char out_name [32];
		sprintf (out_name, "part_%03d.txt", out_count++);
		FILE *out_file = fopen (out_name, "wt");

		IndexReq* req = (IndexReq*) malloc (sizeof (IndexReq) + 128);
		req->ItemCount = 1;
		req->ItemSize  = 0;
		req->SearchOp = SO_AND | SO_KEYS_AND | SV_MBODIES;
		strcpy (req->Name, "Morpho");
		IndexReq *reqs [1];
		reqs [0] = req;

		while (!feof (in_file)) {
			char str [256];
			if ( !fgets (str, sizeof (str), in_file)) {
				break;
			}

			int length = strlen (str);
			if (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;

			strcpy ((char gk_huge*)(req+1), str);
			Recoding (cd_win, cd_dos, str);
			SortedCollection* foundlist = base->Search (1,reqs,0,SO_AND,0,1,1,false,false)->list;
			if (foundlist && foundlist->ItemCount) {
				RefwRele *at0 = (RefwRele*) foundlist->GetItem (0);
				long count = foundlist->ItemCount, doc_id = at0->DocId, apara = base->find_paras_with_word (doc_id, at0->Word);
				fprintf (out_file, "\n%s\n%ld\n0\n=                                        \n#\n", str, foundlist->ItemCount);

				Document* doc = stdbase->GetDoc (doc_id);
				char* para = doc->GetPara (apara);
				if (doc->EVDCodePage (para) == CP_OEM) {
					for (int i = apara - 1; i < apara + 2; i++) {
						if (i >= 0 && i < doc->Stat.ParaCount)
							fprintf (out_file, "%s\n", doc->EVDParaText (doc->GetPara (i)));
					}
				} else {
					fprintf (out_file, "%s\n", doc->EVDParaText (para));
				}
				fprintf (out_file, "#\n");
				fpos_t pos;
				fgetpos (out_file, &pos);
				if (pos > size) {
					fclose (out_file);
					sprintf (out_name, "part_%03d.txt", out_count++);
					out_file = fopen (out_name, "wt");
				}
				delete doc;

			}
			if (foundlist)
				delete foundlist;
		}
		fclose (out_file);
		fclose (in_file);
		delete base;
		delete stdbase;
		exit (EXIT_SUCCESS);
	}

}
