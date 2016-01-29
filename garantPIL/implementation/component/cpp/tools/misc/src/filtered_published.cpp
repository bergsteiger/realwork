#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "SearchB.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	ToolsBase *base = new ToolsBase (argv [1]);

	char* indexes [] = {AUX_FILTERED_PUBLISHED_JU, AUX_FILTERED_PUBLISHED_HR, AUX_FILTERED_PUBLISHED_BO, AUX_FILTERED_PUBLISHED, AUX_FILTERED_PUBLISHED_PH};
	for (int i = 0; i < sizeof (indexes) / sizeof (char*); i++) {
		std::vector <bool> is_filtered;
		std::vector<HIndex::HIndexKey*> keys;
		base->get_filtered_tree (indexes [i], "PublishedIn", keys, is_filtered);

		DocCollection publ_docs;

		std::map<long,std::string> map_id_name;
		std::map<long,long> map_id_parentid;
		std::set<std::string> full_names, processed_parents, ok_keys;

		std::vector<HIndex::HIndexKey*>::const_iterator it;
		long count = 0;
		for (it = keys.begin (); it != keys.end (); it++, count++) {
			HIndex::HIndexKey* key = *it;
			map_id_parentid.insert (std::map<long,long>::value_type (key->id, key->parent));
			if (key->level) {
				std::string name = map_id_name.find (key->parent)->second;
				name += "\\";
				name += key->text;
				map_id_name.insert (std::map<long,std::string>::value_type (key->id, name));
				full_names.insert (name);
			} else {
				map_id_name.insert (std::map<long,std::string>::value_type (key->id, key->text));
				full_names.insert (key->text);
			}
		}
		for (std::set<std::string>::reverse_iterator name_it = full_names.rbegin (); name_it != full_names.rend (); name_it++) {
			char* name = strdup (name_it->c_str ()), *slash = strrchr (name, '\\');
			if (slash) {
				if (processed_parents.find (name_it->c_str ()) == processed_parents.end ())
					ok_keys.insert (*name_it);
				*slash = 0;
				processed_parents.insert (name);
			} else {
				if (processed_parents.find (name_it->c_str ()) == processed_parents.end ())
					ok_keys.insert (*name_it);
			}
		}
		if (0 == ok_keys.size ())
			continue;
		printf ("[!%s]\n", indexes [i]);
		for (std::set<std::string>::const_iterator str_it = ok_keys.begin (); str_it != ok_keys.end (); str_it++) {
			std::vector<std::string> parts;
			boost::split (parts, *str_it, boost::is_any_of ("\\"));
			std::vector<std::string>::const_iterator part_it;
			for (part_it = parts.begin (); part_it != parts.end (); part_it++) {
				if (part_it != parts.begin ()) printf ("\\");
				printf ("%s", part_it->c_str () + 4);
			}
			printf ("=PublishedIn:");
			for (part_it = parts.begin (); part_it != parts.end (); part_it++) {
				if (part_it != parts.begin ()) printf ("\\");
				printf ("%s", part_it->c_str () + 4);
			}
			printf ("\n");
		}
		printf ("\n");
	}

	delete base;

	return 0;
}
