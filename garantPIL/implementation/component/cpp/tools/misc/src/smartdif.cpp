#include "ace/ACE.h"
#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "shared/Core/os/IniFile.h"
#include "gardefs.h"
#include "garutils.h"
#include "garver.h"
#include "stdbase.h"
#include "basemask.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	return main_logic (argc, argv);
}

std::map<long,std::string> map_doc_name;

YBase *_base;
char buffer [4096];

int compare_docs_by_name (const void *arg1, const void *arg2)
{
	long id1 = *(long*) arg1;
	long id2 = *(long*) arg2;
	std::map<long,std::string>::iterator it1 = map_doc_name.find (id1);
	if (it1 == map_doc_name.end ()) {
		_base->FindDocName (id1, buffer);
		map_doc_name.insert (std::map<long,std::string>::value_type (id1, buffer));
		it1 = map_doc_name.find (id1);
	}
	std::map<long,std::string>::iterator it2 = map_doc_name.find (id2);
	if (it2 == map_doc_name.end ()) {
		_base->FindDocName (id2, buffer);
		map_doc_name.insert (std::map<long,std::string>::value_type (id2, buffer));
		it2 = map_doc_name.find (id2);
	}
	return strcmp (it1->second.c_str (), it2->second.c_str ());
}

int main_logic ( int argc, char *argv[] )
{
	{
		std::vector<long> old_ids, new_ids;
		std::set<long> old_sort_ids, new_sort_ids;
		FILE *in1 = fopen (argv [1], "rt");
		while (!feof (in1)) {
			char str [256];
			if (!fgets (str, sizeof (str), in1))
				break;

			int length = strlen (str);
			if (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;

			old_ids.push_back (atol (str));
			old_sort_ids.insert (atol (str));
		}
		fclose (in1);
		std::vector<long> old_ids_copy (old_ids);

		FILE *in2 = fopen (argv [2], "rt");
		while (!feof (in2)) {
			char str [256];
			if (!fgets (str, sizeof (str), in2))
				break;

			int length = strlen (str);
			if (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;

			new_ids.push_back (atol (str));
			new_sort_ids.insert (atol (str));
		}
		fclose (in2);

		std::vector<long>::iterator it;
		std::vector<long> del_vector (old_ids.size ());
		del_vector.erase (set_difference (old_sort_ids.begin (), old_sort_ids.end (), new_sort_ids.begin (), new_sort_ids.end (), del_vector.begin ()), del_vector.end ());
		std::set<long> del_set;
		del_set.insert (del_vector.begin (), del_vector.end ());
		for (it = del_vector.begin (); it != del_vector.end (); it++)
			printf ("%ld\n", *it);
		printf ("\n");

		std::vector<long> new_vector (new_ids.size ());
		new_vector.erase (set_difference (new_sort_ids.begin (), new_sort_ids.end (), old_sort_ids.begin (), old_sort_ids.end (), new_vector.begin ()), new_vector.end ());
		std::set<long> new_set;
		new_set.insert (new_vector.begin (), new_vector.end ());
		for (it = new_vector.begin (); it != new_vector.end (); it++)
			printf ("%ld\n", *it);

		//из нового удалить del_setные, из старого удалить new_setные
		std::vector<long> del_positions;
		long del_pos = 0;
		for (it = old_ids.begin (); it != old_ids.end (); it++, del_pos++)
			if (del_set.find (*it) != del_set.end ())
				del_positions.push_back (del_pos);
		for (std::vector<long>::reverse_iterator rit = del_positions.rbegin (); rit != del_positions.rend (); rit++) {
			long del_pos = *rit;
			old_ids.erase (old_ids.begin () + del_pos);
		}

		std::map<long,long> map_at_insert;
		for (it = new_ids.begin (); it != new_ids.end (); it++)
			if (new_set.find (*it) != new_set.end ())
				map_at_insert.insert (std::map<long,long>::value_type (it - new_ids.begin (), *it));

		for (std::map<long,long>::reverse_iterator map_rit = map_at_insert.rbegin (); map_rit != map_at_insert.rend (); map_rit++)
			new_ids.erase (new_ids.begin () + map_rit->first);

		std::vector<long> new_ids_copy (new_ids);
		std::vector<long> remove_positions;
		std::vector<long>::iterator old_it = old_ids.begin (), new_it = new_ids.begin ();
		//вычислим, какие элементы надо удалить
		for (; old_it != old_ids.end ();) {
			if (*old_it == *new_it) {
				old_it++;
				new_it++;
				continue;
			}
			if (*old_it == *(new_it+1)) {
				//найти элемент, который надо перенести в текущее место
				long move_id = *new_it;
				new_ids.erase (new_it);

				std::vector<long>::iterator move_it = old_it;
				while (*move_it != move_id) move_it++;
				remove_positions.push_back (move_it - old_ids.begin ());
				old_ids.erase (move_it);
			} else {
				//надо текущий элемент перенести в другое место
				long move_id = *old_it;
				remove_positions.push_back (old_it - old_ids.begin ());
				old_ids.erase (old_it);
				std::vector<long>::iterator move_it = new_it;
				while (*move_it != move_id) move_it++;
				new_ids.erase (move_it);
			}
		}
		printf ("removes: %ld\n", remove_positions.size ());

		//теперь вычислим, куда вставить удаленные элементы
		old_sort_ids.clear ();
		old_sort_ids.insert (old_ids.begin (), old_ids.end ());
		new_ids.assign (new_ids_copy.begin (), new_ids_copy.end ());
		std::map<long,long> map_insertat_value;
		for (new_it = new_ids.begin (); new_it != new_ids.end (); new_it++) {
			long id = *new_it;
			if (old_sort_ids.find (id) == old_sort_ids.end ())
				map_insertat_value.insert (std::map<long,long>::value_type (new_it - new_ids.begin (), id));
		}
		printf ("inserts: %ld\n", map_insertat_value.size ());

		old_ids.assign (old_ids_copy.begin (), old_ids_copy.end ());
		{
		//шаг1. удалить удаленные документы
		std::vector<long>::reverse_iterator rit;
		for (rit = del_positions.rbegin (); rit != del_positions.rend (); rit++)
			old_ids.erase (old_ids.begin () + *rit);
		
		//шаг2. удалить документы, которые будут вставлены в другое место
		std::vector<long>::const_iterator it;
		for (it = remove_positions.begin (); it != remove_positions.end (); it++)
			old_ids.erase (old_ids.begin () + *it);

		//шаг3. вставить эти элементы в нужные позиции
		for (std::map<long,long>::const_iterator map_it = map_insertat_value.begin (); map_it != map_insertat_value.end (); map_it++)
			old_ids.insert (old_ids.begin () + map_it->first, map_it->second);
		
		//шаг4. вставить новые
		for (std::map<long,long>::const_iterator map_it = map_at_insert.begin (); map_it != map_at_insert.end (); map_it++)
			old_ids.insert (old_ids.begin () + map_it->first, map_it->second);

		for (old_it = old_ids.begin (); old_it != old_ids.end (); old_it++)
			printf ("%ld\n", *old_it);

		}

		return 0;
		exit (EXIT_SUCCESS);
	}
	{
		_base = new YBase (argv [1], ACE_OS_O_RDONLY);
		DocCollection *alldocs = _base->AllDocs ();
		long *docs = new long [alldocs->ItemCount], *ptr = docs, i;
		for (i = 0; i < alldocs->ItemCount; i++, ptr++)
			*ptr = (*alldocs)[i];
		qsort (docs, alldocs->ItemCount, sizeof (long), compare_docs_by_name);
		for (i = 0, ptr = docs; i < alldocs->ItemCount; i++, ptr++)
			printf ("%ld\n", *ptr);
		return 0;
		exit (EXIT_SUCCESS);
	}

	return 0;
}
