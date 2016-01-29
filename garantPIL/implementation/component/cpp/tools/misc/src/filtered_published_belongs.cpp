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
	long docs [] = {57970416, 57970417, 57970418, 57970419, 57970420};
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

				Stream* str = base->FindIndex ("PublishedIn")->Index::OpenN (key, 0);
				if (str) {
					DocCollection tmp;
					tmp.Get (str);
					base->FindIndex ("PublishedIn")->Close (str);
					publ_docs.Merge (tmp);
				}
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

		long id = docs [i], bcount = 0;
		printf ("if\n  DocId==%ld;\nthen\n", id);
		short *data = (short*) base->LoadAttr (id, IDD_BASES, bcount), *ptr = data;
		for (int j = 0; j < bcount / 2; j++, ptr++)
			printf ("  Belongs.remove(%ld);\n", *ptr);
		gk_free (data);
		std::set<short> segs;
		for (long j = 0; j < publ_docs.ItemCount; j++) {
			long id = publ_docs [j], bcount = 0;
			short *data = (short*) base->LoadAttr (id, IDD_BASES, bcount), *ptr = data;
			for (int k = 0; k < bcount / 2; k++, ptr++)
				segs.insert (*ptr);
			gk_free (data);
		}
		for (std::set<short>::const_iterator it = segs.begin (); it != segs.end (); it++)
			printf ("  Belongs.add(%ld);\n", *it);
		printf ("end\n\n");
	}

	delete base;

	return 0;
}
