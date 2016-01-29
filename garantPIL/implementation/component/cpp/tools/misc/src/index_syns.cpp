#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
#include "SearchB.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

typedef	std::pair<std::string, std::string> index_key_pair;
typedef	std::vector<index_key_pair> vector_of_syns;
typedef	std::vector<std::pair<std::string, vector_of_syns> > key_syns;
std::map<std::string, key_syns> map_indexname_keys;

void	get_tree (const char* index_name, std::vector<HIndex::HIndexKey*> &keys)
{
	keys.clear ();
	std::map<std::string, key_syns>::const_iterator found_it = map_indexname_keys.find (index_name);
	if (found_it == map_indexname_keys.end ())
		return ;

	std::map<std::string, long> map_fullkey_id;
	std::map<long, std::string> map_id_fullkey;
	std::map<long, long> map_id_parentid;
	std::map<long, std::set<std::string> > map_id_children;
	long id = 0;
	for (key_syns::const_iterator keys_it = found_it->second.begin (); keys_it != found_it->second.end (); keys_it++) {
		std::string key = keys_it->first;
		if (strchr (key.c_str (), '\\')) {
			std::vector<std::string> parts;
			boost::split (parts, key, boost::is_any_of ("\\"));
			for (int i = 1; i < parts.size (); i++) {
				std::string parent_str;
				for (int parent = 0; parent < i; parent++) {
					if (parent_str.size ()) parent_str += "\\";
					parent_str += parts.at (parent);
				}
				std::string child_str = parent_str + "\\" + parts.at (i);

				std::map<std::string,long>::const_iterator found_parent = map_fullkey_id.find (parent_str);
				long parent_id;
				if (found_parent == map_fullkey_id.end ()) {
					map_id_parentid.insert (std::map<long,long>::value_type (parent_id = ++id, 0));
					map_fullkey_id.insert (std::map<std::string, long>::value_type (parent_str, id));
					map_id_fullkey.insert (std::map<long, std::string>::value_type (id, parent_str));
				} else {
					parent_id = found_parent->second;
				}

				if (map_fullkey_id.find (child_str) == map_fullkey_id.end ()) {
					map_fullkey_id.insert (std::map<std::string, long>::value_type (child_str, ++id));
					map_id_fullkey.insert (std::map<long, std::string>::value_type (id, child_str));
					map_id_children.insert (std::map<long,std::set<std::string> >::value_type (id, std::set<std::string> ()));
				}
				map_id_parentid.insert (std::map<long,long>::value_type (id, parent_id));

				std::map<long,std::set<std::string> >::iterator map_id_children_it = map_id_children.find (parent_id);
				if (map_id_children_it == map_id_children.end ()) {
					std::set<std::string> children_set;
					children_set.insert (child_str);
					map_id_children.insert (std::map<long,std::set<std::string> >::value_type (parent_id, children_set));
				} else {
					map_id_children_it->second.insert (child_str);
				}
			}
		} else {
			map_id_parentid.insert (std::map<long,long>::value_type (++id, 0));
			map_fullkey_id.insert (std::map<std::string, long>::value_type (key, id));
			map_id_fullkey.insert (std::map<long, std::string>::value_type (id, key));
			map_id_children.insert (std::map<long,std::set<std::string> >::value_type (id, std::set<std::string> ()));
		}
	}

	for (std::map<long,std::string>::const_iterator map_it = map_id_fullkey.begin (); map_it != map_id_fullkey.end (); map_it++) {
		std::vector<std::string> parts;
		boost::split (parts, map_it->second, boost::is_any_of ("\\"));

		HIndex::HIndexKey *key = (HIndex::HIndexKey*) malloc (sizeof (HIndexKeyData) + parts.at (parts.size () - 1).size ());
		key->level = parts.size () - 1;
		long id = map_it->first, parent_id = map_id_parentid.find (id)->second, ch_count = map_id_children.find (id)->second.size ();
		key->id = id;
		key->parent = parent_id;
		key->chCount = ch_count;
		key->achCount = 0;

		strcpy (key->text, parts.at (parts.size () - 1).c_str ());
		keys.push_back (key);
	}

	for (std::vector<HIndex::HIndexKey*>::const_iterator result_it = keys.begin (); result_it != keys.end (); result_it++) {
		HIndex::HIndexKey* key = *result_it;
		printf ("level: %ld, id: %ld, parent: %ld, chcount: %ld, achcount: %ld, name: %s\n", key->level, key->id, key->parent, key->chCount, key->achCount, key->text);
	}
}

int main_logic ( int argc, char *argv[] )
{
	FILE *file = mpcxc_fopen (argv [1], "rt");
	if (!file)
		return -1;

	char str [8192];
	std::string index_name;
	while (!feof (file)) {
		if (!fgets (str, sizeof (str), file))
			break;

		int length = strlen (str);
		while (length && (str [length-1] == 10 || str [length-1] == 13))
			str [--length] = 0;

		if (!length) {
			index_name = "";
			continue;
		}

		if (str [0] == '[') {
			if (strchr (str, '|')) {
				*strchr (str, ']') = 0;
				index_name = str+1;
				map_indexname_keys.insert (std::map<std::string, key_syns>::value_type (index_name, key_syns ()));
			}
		} else {
			if (index_name.size ()) {
				if (strchr (str, '=')) {
					//синонимы
					std::vector<std::string> parts;
					boost::split (parts, str, boost::is_any_of ("="));

					std::string key = *parts.begin ();

					std::vector<std::string> pairs;
					boost::split (pairs, parts.at (1), boost::is_any_of ("|"));

					vector_of_syns syns;
					for (std::vector<std::string>::const_iterator it = pairs.begin (); it != pairs.end (); it++) {
						std::vector<std::string> pairofs;
						boost::split (pairofs, *it, boost::is_any_of (":"));
						index_key_pair apair (pairofs.at (0), pairofs.at (1));
						syns.push_back (apair);
					}

					std::pair<std::string,vector_of_syns> apair (key, syns);
					map_indexname_keys.find (index_name)->second.push_back (apair);
				} else {
					//возможно, тут >, т.е. вызов "карточки" с индексом
				}
			}
		}
	}
	fclose (file);

	{
		std::vector<HIndex::HIndexKey*> tree_keys;
		get_tree ("Судебная Практика|Полный список судебных органов", tree_keys);
	}
	{
		std::vector<HIndex::HIndexKey*> tree_keys;
		get_tree ("dummy|dummy", tree_keys);
	}

	return 0;
}
