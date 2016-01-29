#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "newdoc.h"
#include "advlog.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"
#include "long.long.SplayMap.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

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

char shrinked_str [2048];
char*	remove_trash (char* index_str, bool sub = false)
{
	char *toput = shrinked_str, *str = index_str;
	*toput = 0;
	if (sub) str = strchr (str, ':') + 1;
	char *token = strtok (str, "\\");
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
		std::map<long,std::string> map_id_name;

		FILE	*belongs_file = fopen (argv[2], "rt");
		while (!feof (belongs_file)) {
			char str [2048];
			if ( !fgets (str, sizeof (str), belongs_file))
				break;

			int length = strlen (str);
			if (length) {
				if (str [length-1] == 10)
					str [--length] = 0;
				if (length && str [length-1] == 13)
					str [--length] = 0;
			} 
			if (!length || str [0] == ';')
				continue;

			char* ptr = str;
			while (*ptr == ' ') ptr++;
			while (*ptr != ' ') ptr++;
			while (*ptr == ' ') ptr++;
			while (*ptr != ' ') ptr++;
			*ptr = 0;

			map_id_name.insert (std::map<long,std::string>::value_type (atol (str), strrchr (str, ' ')+1));
		}
		fclose (belongs_file);		

		date from_date;
		if (argv [3])
			getDate (argv [3], strlen (argv [3]), from_date);
		else {
			from_date.da_day = 1;
			from_date.da_mon = 1;
			from_date.da_year= 2008;
		}
		SearchBase *base = new SearchBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		base->check_version ();
		base->FindIndex ("Attrs");

		IndexLoader loader (base);
		DocCollection* alldocs = base->AllTopics (ID_BORDER);
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long doc_id = (*alldocs) [i];
			if (doc_id >= BIG_INFO_DOC && doc_id < BIG_INFO_DOC + BIG_INFO_COUNT)
				continue;
			DocInfo docinfo;
			base->FindDocInfo (doc_id, docinfo);
			if (is_lt (from_date, docinfo.Revision.RevisionDate) || is_eq (from_date, docinfo.Revision.RevisionDate)) {
				printf ("!TOPIC %ld %s\n", doc_id - ID_BORDER, docinfo.Title);

				std::map<long,std::set<std::string> > map_types, map_classes, map_prefixes;
				std::set<long> subs;

				printf ("!BELONGS ");
				long belongs_count;
				INDEX_DATA (short) belongs = loader.load <short> (doc_id, IDD_BASES, belongs_count, true);
				if (belongs.ptr ()) {
					short* belongs_ptr = belongs.ptr ();
					for (int belong = 0; belong < belongs_count; belongs_ptr++, belong++) {
						if (map_id_name.find (*belongs_ptr) == map_id_name.end ())
							continue;
						printf ("%s", map_id_name.find (*belongs_ptr)->second.c_str ());
						if (belong < belongs_count - 1)
							printf ("\\");
						else
							printf ("\n");
					}
				}

				printf ("!SIZE %ld\n", docinfo.Size);
				if (docinfo.Status & DS_DOC)
					printf ("!DOC\n");
				else
					printf ("!NODOC\n");

				long types_size;
				char *types = (char*) base->LoadAttr (doc_id, IDD_TYPE, types_size), *types_ptr = types;
				if (types_size) {
					while (types_ptr - types_size != types) {
						int len = strlen (types_ptr) + 1, sub = atol (types_ptr);
						std::set<std::string> empty;
						map_types.insert (std::map<long, std::set<std::string> >::value_type (sub, empty));
						map_types.find (sub)->second.insert (remove_trash (types_ptr, true));
						subs.insert (sub);							 
						//printf ("!TYPE %s\n", remove_trash (types_ptr, true));
						types_ptr += len;
					}
					gk_free (types);
				}

				long serviceinfos_size;
				char *serviceinfos = (char*) base->LoadAttr (doc_id, IDD_SERVICEINFO, serviceinfos_size), *serviceinfos_ptr = serviceinfos;
				if (serviceinfos_size) {
					while (serviceinfos_ptr - serviceinfos_size != serviceinfos) {
						int len = strlen (serviceinfos_ptr) + 1;
						printf ("!SERVICEINFO %s\n", remove_trash (serviceinfos_ptr, true));
						serviceinfos_ptr += len;
					}
					gk_free (serviceinfos);
				}

				{
				long size;
				date *idd_date = (date*) base->LoadAttr (doc_id, IDD_VANONCED, size), *ptrd = idd_date;
				std::set<std::string> vanonceds;
				for (int i = 0; i < size; ptrd++, i+=sizeof (date))
					printf ("!VANONCED %02ld/%02ld/%02ld\n", (long) ptrd->da_day, (long) ptrd->da_mon, (long) ptrd->da_year);
				gk_free (idd_date);
				}

				{
				long size;
				date *idd_date = (date*) base->LoadAttr (doc_id, IDD_VABOLISHED, size), *ptrd = idd_date;
				std::set<std::string> vanonceds;
				for (int i = 0; i < size; ptrd++, i+=sizeof (date))
					printf ("!VABOLISHED %02ld/%02ld/%02ld\n", (long) ptrd->da_day, (long) ptrd->da_mon, (long) ptrd->da_year);
				gk_free (idd_date);
				}

				{
				long size;
				date *idd_date = (date*) base->LoadAttr (doc_id, IDD_VCHANGED, size), *ptrd = idd_date;
				std::set<std::string> vanonceds;
				for (int i = 0; i < size; ptrd++, i+=sizeof (date))
					printf ("!VCHANGED %02ld/%02ld/%02ld\n", (long) ptrd->da_day, (long) ptrd->da_mon, (long) ptrd->da_year);
				gk_free (idd_date);
				}

				{
				long size;
				date *idd_date = (date*) base->LoadAttr (doc_id, IDD_VINCLUDED, size), *ptrd = idd_date;
				std::set<std::string> vanonceds;
				for (int i = 0; i < size; ptrd++, i+=sizeof (date))
					printf ("!VINCLUDED %02ld/%02ld/%02ld\n", (long) ptrd->da_day, (long) ptrd->da_mon, (long) ptrd->da_year);
				gk_free (idd_date);
				}

				{
				long size;
				date *idd_date = (date*) base->LoadAttr (doc_id, IDD_VLCONTROL, size), *ptrd = idd_date;
				std::set<std::string> vanonceds;
				for (int i = 0; i < size; ptrd++, i+=sizeof (date))
					printf ("!VLCONTROL %02ld/%02ld/%02ld\n", (long) ptrd->da_day, (long) ptrd->da_mon, (long) ptrd->da_year);
				gk_free (idd_date);
				}

				{
				char buff [4096] = "";
				int len = base->FindDocAttr (doc_id, IDD_ACTIVE, buff, sizeof(buff)), i = 0;
				if (len) {
					DocActivity d;
					while (i < len) {
						memcpy (&d, &buff[i], 2 * sizeof (date));
						i += 2 * sizeof (date);
						d.text = &buff[i];
						if (*d.text == '\0') {
							if ( d.to.da_year && d.from.da_year ) {
								printf ("!ACTIVE %d/%d/%d-%d/%d/%d\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.to.da_day, d.to.da_mon, d.to.da_year);
							} else {
								if (d.to.da_year) {
									d.to = date_plusdays (d.to, 1);
									printf ("!NOACTIVE %d/%d/%d\n", d.to.da_day, d.to.da_mon, d.to.da_year);
								} else {
									if (docinfo.Status & DS_ACTIVE)
										printf ("!ACTIVE %d/%d/%d\n", d.from.da_day, d.from.da_mon, d.from.da_year);
									else
									if (docinfo.Status & DS_PREACTIVE)
										if (d.from.da_year)
											printf ("!ACTIVE %d/%d/%d\n", d.from.da_day, d.from.da_mon, d.from.da_year);
										else
											printf ("!PREACTIVE\n");
									else
										printf ("!ACTIVE %d/%d/%d\n", d.from.da_day, d.from.da_mon, d.from.da_year);
								}
							}
						} else {
							if ( d.to.da_year && d.from.da_year ) {
								printf ("!ACTIVE %d/%d/%d-%d/%d/%d \"%s\"\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.to.da_day, d.to.da_mon, d.to.da_year, d.text);
							} else {
								if (d.to.da_year ) {
									d.to = date_plusdays( d.to, 1 );
									printf ("!NOACTIVE %d/%d/%d \"%s\"\n", d.to.da_day, d.to.da_mon, d.to.da_year, d.text);
								} else {
									if (docinfo.Status & DS_ACTIVE)
										printf ("!ACTIVE %d/%d/%d \"%s\"\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.text);
									else
									if (docinfo.Status & DS_PREACTIVE)
										printf ("!ACTIVE %d/%d/%d \"%s\"\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.text);
									else
										printf ("!ACTIVE %d/%d/%d \"%s\"\n", d.from.da_day, d.from.da_mon, d.from.da_year, d.text); //будущая редакция?
								}
							}
						}
						i += strlen (d.text) + 2;
						if (buff[i] == '\0') {
							break;
						} else {
							--i;
						}
					}					
				} else {
					if ((docinfo.Status & DS_EDITION) && (docinfo.Status & DS_ABOLISHED)) {
						printf ("!NOACTIVE\n");
					}
				}
				}

				long prefixes_size;
				char *prefixes = (char*) base->LoadAttr (doc_id, IDD_DOCKIND, prefixes_size), *prefixes_ptr = prefixes;
				if (prefixes_size) {
					while (prefixes_ptr - prefixes_size != prefixes) {
						int len = strlen (prefixes_ptr) + 1, sub = atol (prefixes_ptr);
						std::set<std::string> empty;
						map_prefixes.insert (std::map<long, std::set<std::string> >::value_type (sub, empty));
						map_prefixes.find (sub)->second.insert (remove_trash (prefixes_ptr, true));
						subs.insert (sub);							 
						//printf ("!PREFIX %s\n", remove_trash (prefixes_ptr, true));
						prefixes_ptr += len;
					}
					gk_free (prefixes);
				}

				long classes_size;
				char *classes = (char*) base->LoadAttr (doc_id, IDD_DIV, classes_size), *classes_ptr = classes;
				if (classes_size) {
					while (classes_ptr - classes_size != classes) {
						int len = strlen (classes_ptr) + 1, sub = atol (classes_ptr);
						std::set<std::string> empty;
						map_classes.insert (std::map<long, std::set<std::string> >::value_type (sub, empty));
						map_classes.find (sub)->second.insert (remove_trash (classes_ptr, true));
						subs.insert (sub);							 
						//printf ("!CLASS %s\n", remove_trash (classes_ptr, true));
						classes_ptr += len;
					}
					gk_free (classes);
				}

				for (std::set<long>::const_iterator it = subs.begin (); it != subs.end (); it++) {
					long sub = *it;
					if (sub & 0x40000000)
						continue;
					if (sub)
						printf ("!BLOCK %ld\n", sub);
					std::map<long, std::set<std::string> >::const_iterator map_it;
					map_it = map_types.find (sub);
					if (map_it != map_types.end ()) {
						for (std::set<std::string>::const_iterator set_it = map_it->second.begin (); set_it != map_it->second.end (); set_it++)
							printf ("!TYPE %s\n", set_it->c_str ());
					}

					map_it = map_classes.find (sub);
					if (map_it != map_classes.end ()) {
						for (std::set<std::string>::const_iterator set_it = map_it->second.begin (); set_it != map_it->second.end (); set_it++)
							printf ("!CLASS %s\n", set_it->c_str ());
					}

					map_it = map_prefixes.find (sub);
					if (map_it != map_prefixes.end ()) {
						for (std::set<std::string>::const_iterator set_it = map_it->second.begin (); set_it != map_it->second.end (); set_it++)
							printf ("!PREFIX %s\n", set_it->c_str ());
					}
				}

				printf ("\n");
			}
		}
		delete base;
		exit (EXIT_SUCCESS);
	}

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
