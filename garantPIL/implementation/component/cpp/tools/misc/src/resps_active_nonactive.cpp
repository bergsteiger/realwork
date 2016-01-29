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

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		SearchBase* base = new SearchBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		base->is_morpho_exist();
		base->check_version();
		base->get_index ("Status");
		base->FindIndex ("Attrs");

		std::map<long, long> map_edition_doc;
		std::set<long> docs;
		std::map<long, std::set<long> > map_doc_editions;

		Stream *str = base->FindIndex ("Aux")->Open ("Edis");
		if (!str) {
			if (!base->FindIndex ("Aux")->Open ("InfL")) {
				printf ( "run gl first!\n");
				exit (EXIT_FAILURE);
			}
		} else {
			long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
			str->Read (data, size);
			base->FindIndex ("Aux")->Close (str);
			size >>= 3;
			for (int i = 0; i < size; i++) {
				long edition = *ptr;
				ptr++;
				long doc = *ptr;
				docs.insert (doc);
				ptr++;

				map_edition_doc.insert (std::map<long,long>::value_type (edition, doc));
				if (map_edition_doc.find (doc) == map_edition_doc.end ())
					map_edition_doc.insert (std::map<long,long>::value_type (doc, doc));

				std::map<long, std::set<long> >::iterator it = map_doc_editions.find (doc);
				if (it == map_doc_editions.end ()) {
					std::set<long> editions;
					editions.insert (edition);
					editions.insert (doc);
					map_doc_editions.insert (std::map<long, std::set<long> >::value_type (doc, editions));
				} else {
					it->second.insert (edition);
				}
			}
		}

		std::map<long,short> map_doc_status;
		DocCollection *alldocs;
		if (argv [2]) {
			alldocs = new DocCollection ();

			FILE *docsfile = fopen (argv [2], "rt");
			while (!feof (docsfile)) {
				char str [256];

				if (!fgets (str, sizeof (str), docsfile))
					continue;

				int length = strlen (str);
				if (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;

				while (length && str [length-1] == ' ')
					str [--length] = 0;

				long id = atol (str);
				alldocs->Insert (&id);
			}
			fclose (docsfile);
		} else {
			alldocs = base->AllTopics ();
		}

		for (int i = 0; i < alldocs->ItemCount; i++) {
			long id = (*alldocs)[i], real_id = id, size = 0;
			DocInfo docinfo;
			base->FindDocInfo (id, docinfo);
			if (!(docinfo.Status & (DS_DOC | DS_EDITION)))
				continue;

			std::map<long, long>::const_iterator map_it = map_edition_doc.find (id);
			if (map_it != map_edition_doc.end ())
				real_id = map_it->second;

			RespRef *refs = (RespRef*) base->LoadAttr (id, IDD_REFS, size), *ptr = refs;
			if (size) {
				long active = 0, notactive = 0, unknown = 0;
				size /= sizeof (RespRef);
				for (long j = 0; j < size; j++, ptr++) {
					long resp_id = ptr->DocId, real_resp_id = resp_id;

					map_it = map_edition_doc.find (resp_id);
					if (map_it != map_edition_doc.end ())
						real_resp_id = map_it->second;

					if (resp_id == id || real_resp_id == real_id)
						continue;

					std::map<long,short>::const_iterator it = map_doc_status.find (resp_id);
					if (it == map_doc_status.end ()) {
						if (base->FindDocInfo (resp_id, docinfo) == sizeof (DocInfo)) {
							if (docinfo.Status & (DS_DOC | DS_EDITION)) {
								map_doc_status.insert (std::map<long,short>::value_type (resp_id, docinfo.Status));
								it = map_doc_status.find (resp_id);
							}
							else
								continue;
						}
					}
					if (it == map_doc_status.end ())
						unknown++;
					else
					if (it->second & DS_ACTIVE)
						active++;
					else
						notactive++;
				}
				gk_free (refs);
				if (unknown)
					printf ("%ld:%ld;%ld;%ld\n", id, active, notactive, unknown);
				else
					printf ("%ld:%ld;%ld\n", id, active, notactive);
			}
		}

		exit (EXIT_SUCCESS);
	}
}



