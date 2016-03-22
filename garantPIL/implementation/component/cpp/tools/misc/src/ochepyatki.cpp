
#include "ace/ACE.h"

#include "shared/Core/sys/AutoInit.h"
#include "shared/Morpho/Facade/Factory.h"

#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"
#include "shared/ContextSearch/Defs/Defs.h"

#include "DBComm.h"
#include "SearchB.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	Core::AutoInit init;
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		Core::Aptr <SearchBase> base = new SearchBase (argv [1]);

		base->IsOk ();
		base->check_version ();
		base->FindIndex ("Attrs");

		DBCore::IBase_var obj = DBCore::DBFactory::make (base.in ());

		Morpho::Def::ICache_var cache = Morpho::Factory::make ();
		cache->load (obj.in ());

		Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (cache.in ());

		Index* index = base->FindIndex ("NWCntxt");

		FILE *in_file = fopen (argv [2], "rt");
		while (!feof (in_file)) {
			char str [256];
			if ( !fgets (str, sizeof (str), in_file)) {
				break;
			}

			int length = strlen (str);
			if (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;

			bool has_form = false;

			WinStrUpr (str);

			Core::Aptr <GCL::StrSet> res = normalizer->execute (std::string (str), true);
			const char* key = res->begin ()->c_str ();

			std::vector<long> docs;

			char forma = -1;
			Stream* str_forms = index->OpenN (key, 1);
			if (str_forms) {
				has_form = (str_forms->Length () > 32);
				char* forms = new char [str_forms->Length ()];
				str_forms->Read (forms, str_forms->Length ());
				for (int i = 0; i < str_forms->Length () / 32; i++) {
					if (!strcmp (forms + i * 32 + 1, str)) {
						forma = i;
						break;
					}
				}
				index->Close (str_forms);
				delete forms;
			}

			if (forma == -1)
				continue;

			Stream *str0 = index->Open (key), *str2 = index->OpenN (key, 2);
			if (str0 && str2) {
				DBCore::IDataStream_var data_stream = new DBExt::PositionsReader (str2, forma, DBExt::Def::dt_Text, has_form, 0);
				DBCore::IRefStream_var ref_stream = new DBExt::StreamReader (str0, 0);

				DBCore::Ref_ ref = {0,0,0};
				DBCore::ExtrPair extr;

				while (ref_stream->get_next (ref, 0)) {
					long id = ref.doc_id;
					ContextSearch::Defs::Positions positions;
					data_stream->get (positions, ref, extr);
					if (positions.size ())
						docs.push_back (id);
				}
				index->Close (str2);
				index->Close (str0);
			}

			printf ("%s\n", str);
			for (std::vector<long>::const_iterator it = docs.begin (); it != docs.end (); it++) {
				printf ("doc %ld: ", *it);
				long segs_count;
				short* segs = (short*) base->LoadAttr (*it, IDD_BASES, segs_count), *ptr = segs;
				for (short seg = 0; seg < segs_count / 2; ptr++, seg++) {
					printf ("%ld ", (long) *ptr);
				}
				printf ("\n");
			}

		}
		fclose (in_file);
	}

	return 0;
}
