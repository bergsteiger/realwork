#include "shared/Core/fix/mpcxc.h"

#include "shared/Core/sys/AutoInit.h"
#include "SearchB.h"

#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Common/Constants.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/DBComm.h"

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
	Core::AutoInit init;
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		SearchBase *base = new SearchBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		base->is_morpho_exist();

		DBCore::IBase_var obj = DBCore::DBFactory::make ((Base*) base);
		Morpho::Def::ICache_var cache = Morpho::Factory::make ();
		cache->load (obj.in (), true);
		Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (cache.in ());

		FILE *infile = fopen (argv [2], "rt");
		while (!feof (infile)) {
			char str [1024]; str [0] = '\0';
			fgets (str, sizeof (str), infile);

			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13 || str [length-1] == 32))
				str [--length] = 0;
			if (!length)
				continue;

			std::vector<std::string> result, parts;
			boost::split (parts, str, boost::is_any_of (" "));

			if (parts.size () > 4)
				continue;

			for (std::vector<std::string>::const_iterator it = parts.begin (); it != parts.end (); it++) {
				char index_str [33];
				strcpy (index_str + 1, it->c_str ());
				index_str [0] = (char)((it->size () + 1) & 0x7F);
				Stream *str = base->FindIndex ("NWCntxt.str")->Index::OpenN (index_str, 1);
				std::vector<std::string> forms;

				if (!str) {
					Core::Aptr <GCL::StrSet> res = normalizer->execute (std::string (*it), true);
					for (GCL::StrSet::const_iterator it2 = res->begin (); it2 != res->end (); it2++) {
						strcpy (index_str, it2->c_str ());
						str = base->FindIndex ("NWCntxt.str")->Index::OpenN (index_str, 1);
						if (str) {
							length = str->Length ();
							char *data = new char [length], *ptr = data;
							str->Read (data, length);
							base->FindIndex ("NWCntxt.str")->Close (str);
							gk_bzero (index_str, sizeof (index_str));
							while (ptr - data < length) {
								strncpy (index_str, ptr + 1, 31);
								forms.push_back (index_str);
								ptr += 32;
							}
							break;
						}
					}
					std::sort (forms.begin (), forms.end ());
					forms.erase (std::unique (forms.begin (), forms.end ()), forms.end ());
				}
				if (forms.size () == 0) {
					if (!str) {
						index_str [0] |= 0x80;
						str = base->FindIndex ("NWCntxt.str")->Index::OpenN (index_str, 1);
					}
					if (!str)
						continue;
					if (str) {
						length = str->Length ();
						char *data = new char [length], *ptr = data;
						str->Read (data, length);
						base->FindIndex ("NWCntxt.str")->Close (str);
						gk_bzero (index_str, sizeof (index_str));
						while (ptr - data < length) {
							strncpy (index_str, ptr + 1, 31);
							forms.push_back (index_str);
							ptr += 32;
						}
					}
				}

				if (result.size ()) {
					std::vector<std::string> new_result;
					for (std::vector<std::string>::const_iterator res_it = result.begin (); res_it != result.end (); res_it++)
						for (std::vector<std::string>::const_iterator form_it = forms.begin (); form_it != forms.end (); form_it++) {
							std::string newform = *res_it + " " + *form_it;
							new_result.push_back (newform);
						}
						result.swap (new_result);
				} else {
					result.insert (result.begin (), forms.begin (), forms.end ());
				}
			}

			for (std::vector<std::string>::const_iterator res_it = result.begin (); res_it != result.end (); res_it++)
				printf ("%s-%s\n", res_it->c_str (), str);
		}
		fclose (infile);
		delete base;		
	}

	return 0;
}
