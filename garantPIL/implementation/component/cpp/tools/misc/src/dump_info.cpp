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

char	shrinked_str [2048];
char*	shrink_str (char* index_str)
{
	char* toput = shrinked_str;
	*toput = 0;
	char *token = strtok (index_str, "\\");
	while (token) {
		if (toput != shrinked_str) {
			toput++;
			*toput = '\\';
			toput++;
		}
		int length = strlen (token)-4;
		memcpy (toput, token+4, length+1);
		toput += length - 1;
		token = strtok (0, "\\");
	}
	return shrinked_str;
}

int main_logic ( int argc, char *argv[] )
{
	{
		YBase* base = new YBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();

		std::map<long, std::set<long> > map_doc_editions;

		Stream *str = base->FindIndex ("Aux")->Open ("Edis");
		if (str) {
			long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
			str->Read (data, size);
			base->FindIndex ("Aux")->Close (str);
			size >>= 3;
			for (int i = 0; i < size; i++) {
				long edition = *ptr++, doc = *ptr++;
				std::map<long, std::set<long> >::iterator it = map_doc_editions.find (doc);
				if (it == map_doc_editions.end ()) {
					std::set<long> editions;
					editions.insert (edition);
					map_doc_editions.insert (std::map<long, std::set<long> >::value_type (doc, editions));
				} else {
					it->second.insert (edition);
				}
			}
		}

		bool b_subs = true;
		
		DocCollection* docs;
		if (argv [2]) {
			if (!strcmp (argv [2], "-subs")) {
				b_subs = false;
				docs = base->AllDocs ();
			} else {
				docs = new DocCollection ();
				FILE *file = fopen (argv [2], "rt");
				while (!feof (file)) {
					char str [1024]; str [0] = '\0';
					fgets (str, sizeof (str), file);

					int length = strlen (str);
					while (length && (str [length-1] == 10 || str [length-1] == 13))
						str [--length] = 0;
					if (!length)
						continue;

					long doc = atol (str);
					docs->Insert (&doc);
				}
				fclose (file);
			}
		} else {
			docs = base->AllDocs ();
		}

		for (int i = 0; i < docs->ItemCount; i++) {
			long id = (*docs) [i], subs_size = 0, types_size, classes_size, kinds_size, sources_size, dates_size, codes_size, addcodes_size, casecodes_size, terrs_size, rcodes_size, rdates_size;

			std::map<long, std::set<long> > map_para_subs;
			std::set<long> subs_0;
			subs_0.insert (0);
			map_para_subs.insert (std::map<long, std::set<long> >::value_type (0, subs_0));

			SubDesc *subs_ptr = (SubDesc*) base->LoadAttr (id, IDD_SUBS, subs_size), *s_ptr = subs_ptr;
			for (int sub = 0; sub < subs_size / sizeof (SubDesc); sub++, s_ptr++) {
				long asub = s_ptr->Sub;
				if (!(asub & INHERITED_BLOCK)) {
					long apara = s_ptr->Para;
					std::map<long, std::set<long> >::iterator it = map_para_subs.find (apara);
					if (it == map_para_subs.end ()) {
						std::set<long> subs;
						subs.insert (asub);
						map_para_subs.insert (std::map<long, std::set<long> >::value_type (apara, subs));
					} else {
						it->second.insert (asub);
					}
				}
			}
			gk_free (subs_ptr);

			std::set<long> blocks;
			{
			long structs_count;
			DocStruct *org_structs = (DocStruct*) base->LoadAttr (id, IDD_DOCSTRUCT, structs_count), *structs = org_structs;
			structs_count /= sizeof (DocStruct);
			for (int ds = 0; ds < structs_count; ds++, structs++)
				if ((short) ((structs->m_para_list_type >> 24) & 0xFF) == SUBDESCEX_BLOCK)
					blocks.insert (structs->m_para_list_id);
			gk_free (org_structs);
			}

			char *types = (char*) base->LoadAttr (id, IDD_TYPE, types_size), *ptr = types;
			std::map<long,std::vector <std::string> > map_sub_types;
			for (; ptr < types + types_size; ) {
				char* next_str = ptr + strlen (ptr) + 1;
				long sub = atol (ptr);
				char* str = shrink_str (strchr (ptr, ':') + 1);
				std::map<long,std::vector <std::string> >::iterator map_it = map_sub_types.find (sub);
				if (map_it == map_sub_types.end ()) {
					std::vector<std::string> types_vector;
					types_vector.push_back (str);
					map_sub_types.insert (std::map<long,std::vector <std::string> >::value_type (sub, types_vector));
				} else {
					map_it->second.push_back (str);
				}
				ptr = next_str;
			}
			gk_free (types);

			char *terrs = (char*) base->LoadAttr (id, IDD_TERRITORY, terrs_size);
			std::vector <std::string> vector_terrs;
			for (ptr = terrs; ptr < terrs + terrs_size; ) {
				char* next_str = ptr + strlen (ptr) + 1;
				vector_terrs.push_back (shrink_str (ptr));
				ptr = next_str;
			}
			gk_free (terrs);

			char *kinds = (char*) base->LoadAttr (id, IDD_KIND, kinds_size); ptr = kinds;
			std::map<long,std::vector <std::string> > map_sub_kinds;
			for (; ptr < kinds + kinds_size; ) {
				char* next_str = ptr + strlen (ptr) + 1;
				long sub = atol (ptr);
				char* str = shrink_str (strchr (ptr, ':') + 1);
				std::map<long,std::vector <std::string> >::iterator map_it = map_sub_kinds.find (sub);
				if (map_it == map_sub_kinds.end ()) {
					std::vector<std::string> kinds_vector;
					kinds_vector.push_back (str);
					map_sub_kinds.insert (std::map<long,std::vector <std::string> >::value_type (sub, kinds_vector));
				} else {
					map_it->second.push_back (str);
				}
				ptr = next_str;
			}
			gk_free (kinds);

			char *classes = (char*) base->LoadAttr (id, IDD_DIV, classes_size); ptr = classes;
			std::map<long,std::vector <std::string> > map_sub_classes;
			for (; ptr < classes + classes_size; ) {
				char* next_str = ptr + strlen (ptr) + 1;
				long sub = atol (ptr);
				char* str = shrink_str (strchr (ptr, ':') + 1);
				std::map<long,std::vector <std::string> >::iterator map_it = map_sub_classes.find (sub);
				if (map_it == map_sub_classes.end ()) {
					std::vector<std::string> classes_vector;
					classes_vector.push_back (str);
					map_sub_classes.insert (std::map<long,std::vector <std::string> >::value_type (sub, classes_vector));
				} else {
					map_it->second.push_back (str);
				}
				ptr = next_str;
			}
			gk_free (classes);

			char *sources = (char*) base->LoadAttr (id, IDD_SOURCE, sources_size);
			std::vector <std::string> vector_sources;
			for (ptr = sources; ptr < sources + sources_size; ) {
				char* next_str = ptr + strlen (ptr) + 1;
				vector_sources.push_back (shrink_str (ptr));
				ptr = next_str;
			}
			gk_free (sources);

			char *codes = (char*) base->LoadAttr (id, IDD_ID, codes_size);
			std::vector <std::string> vector_codes;
			for (ptr = codes; ptr < codes + codes_size; ) {
				char* next_str = ptr + strlen (ptr) + 1;
				vector_codes.push_back (ptr);
				ptr = next_str;
			}
			gk_free (codes);

			char *addcodes = (char*) base->LoadAttr (id, IDD_ADDCODE, addcodes_size);
			std::vector <std::string> vector_addcodes;
			for (ptr = addcodes; ptr < addcodes + addcodes_size; ) {
				char* next_str = ptr + strlen (ptr) + 1;
				vector_addcodes.push_back (ptr);
				ptr = next_str;
			}
			gk_free (addcodes);

			char *casecodes = (char*) base->LoadAttr (id, IDD_CASECODE, casecodes_size);
			std::vector <std::string> vector_casecodes;
			for (ptr = casecodes; ptr < casecodes + casecodes_size; ) {
				char* next_str = ptr + strlen (ptr) + 1;
				vector_casecodes.push_back (ptr);
				ptr = next_str;
			}
			gk_free (casecodes);

			date *dates = (date*) base->LoadAttr (id, IDD_DATE, dates_size), *dates_ptr = dates;
			std::vector <std::string> vector_dates;
			for (; dates_ptr - dates < dates_size / sizeof (date); dates_ptr++) {
				char sdate [32];
				sprintf (sdate, "%ld/%ld/%ld", dates_ptr->da_day, dates_ptr->da_mon, dates_ptr->da_year);
				vector_dates.push_back (sdate);
			}
			gk_free (dates);

			char *rcodes = (char*) base->LoadAttr (id, IDD_RCODE, rcodes_size);
			std::vector <std::string> vector_rcodes;
			for (ptr = rcodes; ptr < rcodes + rcodes_size; ) {
				char* next_str = ptr + strlen (ptr) + 1;
				vector_rcodes.push_back (ptr);
				ptr = next_str;
			}
			gk_free (rcodes);

			date *rdates = (date*) base->LoadAttr (id, IDD_RDATE, rdates_size), *rdates_ptr = rdates;
			std::vector <std::string> vector_rdates;
			for (; rdates_ptr - rdates < rdates_size / sizeof (date); rdates_ptr++) {
				char sdate [32];
				sprintf (sdate, "%ld/%ld/%ld", rdates_ptr->da_day, rdates_ptr->da_mon, rdates_ptr->da_year);
				vector_rdates.push_back (sdate);
			}
			gk_free (rdates);

			printf ("TOPIC=%ld\n", id);
			DocInfo docinfo;
			base->FindDocInfo (id, docinfo);
			printf ("STATUS=%s\n", docinfo.Status & DS_DOC ? "DOC" : (docinfo.Status & DS_EDITION ? "EDITION" : "?"));
			printf ("ACTIVESTATUS=%s\n", docinfo.Status & DS_ACTIVE ? "YES" : "NO");
			printf ("LASTDATE=%ld/%ld/%ld\n", docinfo.LastDate.da_day, docinfo.LastDate.da_mon, docinfo.LastDate.da_year);

			long warnsize = 0;
			char* warning = (char*) base->LoadAttr (id, IDD_WARNING, warnsize);
			if (warnsize) {
				printf ("WARNING=%s\n", warning);
				gk_free (warning);
			}

			printf ("BELONGS=");
			long belosize = 0;
			short *belongs = (short*) base->LoadAttr (id, IDD_BASES, belosize), *bptr = belongs;
			for (int i = 0; i < belosize / 2; i++,bptr++) {
				if (i) printf (",");
				printf ("%ld", (long)*bptr);
			}
			printf ("\n");
			gk_free (belongs);

			{
			long activesize = 0, i = 0;
			char *data = (char*) base->LoadAttr (id, IDD_ACTIVE, activesize), *ptr = data;
			while (i < activesize) {
				DocActivity* da = (DocActivity*) ptr;
				char* text = ptr + sizeof (da->from) + sizeof (da->to);
				printf ("ACTIVE=%02d/%02d/%04d-%02d/%02d/%04d %s\n", (int) da->from.da_day, (int) da->from.da_mon, (int) da->from.da_year, (int) da->to.da_day, (int) da->to.da_mon, (int) da->to.da_year, text);
				u_int32_t len = strlen (text) + 1;
				i += len + sizeof (da->from) + sizeof (da->to);
				ptr = text + len;
			}
			gk_free (data);
			}

			{
			long chdatesize = 0;
			char *data = (char*) base->LoadAttr (id, IDD_CHDATE, chdatesize), *ptr = data;
			for (chdatesize /= sizeof (DocChDate); chdatesize; chdatesize--, ptr += sizeof (DocChDate))
				printf ("CHDATE=%02d/%02d/%04d\n", (int) ((DocChDate*)ptr)->anonce.da_day, (int) ((DocChDate*)ptr)->anonce.da_mon, (int) ((DocChDate*)ptr)->anonce.da_year, (int) ((DocChDate*)ptr)->active.da_day, (int) ((DocChDate*)ptr)->active.da_mon, (int) ((DocChDate*)ptr)->active.da_year);
			gk_free (data);
			}

			std::map<long, std::set<long> >::const_iterator map_doc_edi_it = map_doc_editions.find (id);
			if (map_doc_edi_it != map_doc_editions.end ()) {
				for (std::set<long>::const_iterator edi_it = map_doc_edi_it->second.begin (); edi_it != map_doc_edi_it->second.end (); edi_it++)
					printf ("EDITION=%ld\n", *edi_it);
			}
			for (std::map<long, std::set<long> >::const_iterator map_it = map_para_subs.begin (); map_it != map_para_subs.end (); map_it++) {
				for (std::set<long>::const_iterator subs_it = map_it->second.begin (); subs_it != map_it->second.end (); subs_it++) {
					long sub = *subs_it;
					if (sub && !b_subs)
						continue;
					char buffer [DOC_NAME_SIZE];
					buffer [0] = 0;
					if (!base->FindSubName (id, sub, buffer) && sub)
						continue;

					std::vector<std::string> types, classes, kinds, sources, terrs, dates, codes, addcodes, casecodes, rcodes, rdates;
					if (sub == 0) {
						dates = vector_dates;
						sources = vector_sources;
						terrs = vector_terrs;
						codes = vector_codes;
						addcodes = vector_addcodes;
						casecodes = vector_casecodes;
						rcodes = vector_rcodes;
						rdates = vector_rdates;
					}
					if (map_sub_types.find (sub) != map_sub_types.end ())
						types = map_sub_types.find (sub)->second;

					if (map_sub_classes.find (sub) != map_sub_classes.end ())
						classes = map_sub_classes.find (sub)->second;

					if (map_sub_kinds.find (sub) != map_sub_kinds.end ())
						kinds = map_sub_kinds.find (sub)->second;

					if (sub) {
						if (blocks.find (sub) == blocks.end ())
							printf ("SUB=%ld.%ld\n", id, sub);
						else
							printf ("BLOCK=%ld.%ld\n", id, sub);
					}

					std::vector<std::string>::const_iterator it;
					for (it = types.begin (); it != types.end (); it++)
						printf ("TYPE=%s\n", it->c_str ());
					for (it = classes.begin (); it != classes.end (); it++)
						printf ("CLASS=%s\n", it->c_str ());
					for (it = kinds.begin (); it != kinds.end (); it++)
						printf ("KIND=%s\n", it->c_str ());
					for (it = sources.begin (); it != sources.end (); it++)
						printf ("SOURCE=%s\n", it->c_str ());
					for (it = terrs.begin (); it != terrs.end (); it++)
						printf ("TERRITORY=%s\n", it->c_str ());
					for (it = codes.begin (); it != codes.end (); it++)
						printf ("CODE=%s\n", it->c_str ());
					for (it = addcodes.begin (); it != addcodes.end (); it++)
						printf ("ADDCODE=%s\n", it->c_str ());
					for (it = casecodes.begin (); it != casecodes.end (); it++)
						printf ("CASECODE=%s\n", it->c_str ());
					for (it = dates.begin (); it != dates.end (); it++)
						printf ("DATE=%s\n", it->c_str ());
					for (it = rcodes.begin (); it != rcodes.end (); it++)
						printf ("RCODE=%s\n", it->c_str ());
					for (it = rdates.begin (); it != rdates.end (); it++)
						printf ("RDATE=%s\n", it->c_str ());

					if (buffer [0]) printf ("NAME=%s\n", buffer);
			}
			}
			printf ("\n");
		}
		
		exit (EXIT_SUCCESS);
	}

	return 0;
}
