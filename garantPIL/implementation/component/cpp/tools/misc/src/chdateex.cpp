#include "shared/Core/fix/mpcxc.h"

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

int main_logic ( int argc, char *argv[] )
{
	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->open_saw_bases (ACE_OS_O_RDONLY);

	bool b_english_base = false;
	{
	Index* auxInd = base->FindIndex ( "Aux" );
	Stream *hereStr = auxInd->Open("Here");
	short hcount = (short) hereStr->Length () / sizeof (short), *heres = (short*) malloc (hereStr->Length ());
	hereStr->Read (heres, hereStr->Length ());
	auxInd->Close (hereStr);

	for (int i = 0; i<hcount; i++)
		if (heres [i] == 32 || (heres [i] >= 240 && heres [i] <= 255)) {
			b_english_base = true;
			break;
		}
	}

	std::map<long,std::string> map_id_result;

	for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
		AttrIndex *attrs = (AttrIndex*) (*base_it)->FindIndex ("Attrs");
		AttrKey attrkey = {ID_BORDER, IDD_CHDATE_EX};

		for (BTIterator it (attrs, &attrkey); !it.End (); ++it) {
			AttrKey *key = (AttrKey*) it.Key ();
			if (key->AttrTag != IDD_CHDATE_EX)
				break;
			
			long ch_count = 0;
			ChDateEx *chdateex = (ChDateEx*)(*base_it)->LoadAttr (key->DocId, key->AttrTag, ch_count), *ptr = chdateex;
			ch_count /= sizeof (ChDateEx);

			std::set<long> ids; //изменяющие документы
			std::map<std::string, std::set<long> > map_date_ids; //мапа дата->какие изменяющие документы
			std::map<long,long> map_id_subs; //мапа изменяющий->изменяющие сабы
			std::map<long, std::set<std::string> > map_id_dates; //мапа документ->даты (на случай, когда есть !chdate с разными датами, но одним изменяющим)
			for (int ch = 0; ch < ch_count; ch++, ptr++) {
				char chdate [9];
				sprintf (chdate, "%ld%02d%02d", ptr->anonce.da_year, ptr->anonce.da_mon, ptr->anonce.da_day);
				std::map<std::string, std::set<long> >::iterator map_it = map_date_ids.find (chdate);

				ids.insert (ptr->ref.DocId);
				map_id_subs.insert (std::map<long,long>::value_type (ptr->ref.DocId, ptr->ref.Sub));

				if (map_it == map_date_ids.end ()) {
					std::set<long> docs;
					docs.insert (ptr->ref.DocId);
					map_date_ids.insert (std::map<std::string, std::set<long> >::value_type (chdate, docs));
				} else {
					map_it->second.insert (ptr->ref.DocId);
				}

				std::map<long, std::set<std::string> >::iterator map_it2 = map_id_dates.find (ptr->ref.DocId);
				if (map_it2 == map_id_dates.end ()) {
					std::set<std::string> dates;
					dates.insert (chdate);
					map_id_dates.insert (std::map<long, std::set<std::string> >::value_type (ptr->ref.DocId, dates));
				} else {
					map_it2->second.insert (chdate);
				}
			}
			std::string result;
			bool b_last_empty_date = true;
			for (std::map<std::string, std::set<long> >::const_iterator map_date_it = map_date_ids.begin (); map_date_it != map_date_ids.end (); map_date_it++) {
				for (std::set<long>::const_iterator doc_it = map_date_it->second.begin (); doc_it != map_date_it->second.end (); doc_it++) {
					long id = *doc_it;

					std::string for_id;
					if (id) {
						if (ids.find (id) == ids.end ())
							continue; //ранее был chdate с меньшей датой и этим документом, и документ был уже обработан.

						ids.erase (ids.find (id));
						
						long codes_size;
						char *codes = (char*) (*base_it)->LoadAttr (id, IDD_ID, codes_size), *ptr = codes;
						if (codes_size) {
							std::set<std::string> codes_set;
							while (ptr - codes < codes_size) {
								codes_set.insert (ptr);
								ptr += strlen (ptr) + 1;
							}
							gk_free (codes);
							for_id += "N";
							if (codes_set.size () > 1) for_id += "N";
							for_id += " ";
							for (std::set<std::string>::const_iterator it = codes_set.begin (); it != codes_set.end (); it++) {
								if (it != codes_set.begin ())
									for_id += ", ";
								for_id += *it;
							}
							for_id += " ";
						}

						std::set<std::string> dates = map_id_dates.find (id)->second;
						for_id += b_english_base ? "dated " : "от ";
						for (std::set<std::string>::const_iterator date_it = dates.begin (); date_it != dates.end (); date_it++) {
							if (date_it != dates.begin ())
								for_id += ", ";
							char year [5], month [4], day [4];
							const char *at_date_it = date_it->c_str ();
							strcpy (day + 2, "."); memcpy (day, at_date_it + 6, 2);
							for_id += day;
							strcpy (month + 2, "."); memcpy (month, at_date_it + 4, 2);
							for_id += month;
							memcpy (year, at_date_it, 4); year [4] = 0;
							for_id += year;
						}
						b_last_empty_date = true;
					} else {
						if (b_last_empty_date)
							for_id += b_english_base ? "dated " : "от ";

						const char *at_date_it = map_date_it->first.c_str ();
						char year [5], month [4], day [4];
						strcpy (day + 2, "."); memcpy (day, at_date_it + 6, 2);
						for_id += day;
						strcpy (month + 2, "."); memcpy (month, at_date_it + 4, 2);
						for_id += month;
						memcpy (year, at_date_it, 4); year [4] = 0;
						for_id += year;

						b_last_empty_date = false;
					}
					/*
					if (result.size ())
						result += ", ";
					result += for_id;
					*/
					if (result.size ())
						result += "|";
					result += for_id;
					result += "|";
					char str_id [32];
					sprintf (str_id, "%ld.%ld", id, map_id_subs.find (id)->second);
					result += str_id;
				}
			}
			map_id_result.insert (std::map<long,std::string>::value_type (key->DocId, result));
		}
	}

	//Edis
	std::set<long> docs, editions;
	std::map<long, std::set<long> > map_doc_editions;
	{
	Stream *str = base->FindIndex ("Aux")->Open ("Edis");
	if (str) {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		base->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr;
			editions.insert (edition);
			ptr++;
			long doc = *ptr;
			docs.insert (doc);
			ptr++;

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
		free (data);
	}
	}
	base->close_saw_bases ();
	delete base;

	/*
	std::map<long, std::deque<std::pair <long, std::string> > > map_doc_chdateexex;
	for (std::map<long,std::string>::const_iterator map_it = map_id_result.begin (); map_it != map_id_result.end (); map_it++) {
		long doc = map_it->first;
		if (editions.find (doc) != editions.end ())
			continue;

		std::deque<std::pair <long, std::string> > chdateexex;
		if (map_doc_editions.find (doc) == map_doc_editions.end ()) {
			std::pair<long,std::string> pair_chdate (doc, map_it->second);
			chdateexex.push_back (pair_chdate);
		} else {
			std::set<long> edis = map_doc_editions.find (doc)->second;
			for (std::set<long>::const_iterator edi_it = edis.begin (); edi_it != edis.end (); edi_it++) {
				long edi = *edi_it;
				std::pair<long,std::string> pair_chdate (edi, "");
				std::map<long,std::string>::const_iterator chdate_it = map_id_result.find (edi);
				if (chdate_it != map_id_result.end ())
					pair_chdate.second = chdate_it->second;
				chdateexex.push_back (pair_chdate);
			}
		}
		map_doc_chdateexex.insert (std::map<long,std::deque<std::pair<long,std::string> > >::value_type (doc, chdateexex));
	}
	for (std::map<long, std::deque<std::pair <long, std::string> > >::const_iterator result_it = map_doc_chdateexex.begin (); result_it != map_doc_chdateexex.end (); result_it++) {
		printf ("%ld\n", result_it->first);
		for (std::deque<std::pair <long, std::string> >::const_iterator chdate_it = result_it->second.begin (); chdate_it != result_it->second.end (); chdate_it++)
			printf ("  %ld %s\n", chdate_it->first, chdate_it->second.c_str ());
	}
	*/

	{
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		base->open_saw_bases (ACE_OS_O_RDWR);
		for (std::map<long,std::string>::const_iterator map_it = map_id_result.begin (); map_it != map_id_result.end (); map_it++) {
			long size = map_it->second.size () + 1;
			char *buffer = (char*) malloc (size);
			strcpy (buffer, map_it->second.c_str ());
			base->ReplaceAttr (map_it->first, IDD_CHDATE_EXEX, buffer, size);
			gk_free (buffer);
		}
		base->close_saw_bases ();
		delete base;
	}

	return 0;
}



