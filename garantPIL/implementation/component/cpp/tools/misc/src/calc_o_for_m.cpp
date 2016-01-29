#include "ace/ACE.h"
#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <sys/types.h>
#include "shared/Core/os/IniFile.h"
#include "gardefs.h"
#include "garutils.h"
#include "stdbase.h"
#include "SearchB.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "shared/ContextSearch/Search/Search.h"
#include "garantPIL/implementation/component/cpp/tools/CSAdapter/StreamReader.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		SearchBase *base = new SearchBase (argv [1]);
		base->FindIndex ("Status");
		DocCollection *all_docs = base->AllDocs ();
		base->IsOk ();
		base->check_version ();

		DocCollection laws;
		Index* index = base->FindIndex ("Type");
		for (BTIterator it (index); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			if (!strcmp (key->text + 4, "Закон") || !strcmp (key->text + 4, "Федеральный закон")) {
				DocCollection part;
				Stream *str = index->Index::OpenN (key, 0);
				if (str) {
					part.FastLoadRefs (str);
					index->Close (str);
					laws.Merge (part);
				}
			}
		}
		laws.Intersect (*all_docs);

		short status_ex = DS_IZM;
		Stream *str = base->FindIndex ("Status_ex")->Open (&status_ex);
		if (str) {
			DocCollection docs;
			docs.FastLoadRefs (str);
			laws.Minus (docs);
			base->FindIndex ("Status_ex")->Close (str);
		}

		std::map<long,long> doc_pos_of_o;
		index = base->FindIndex ("NWCntxt");
		char key [32];
		gk_bzero (key, sizeof (key));
		key [0] = 2;
		key [1] = 'О';
		Stream *str0 = index->Open (key), *str2 = index->OpenN (key, 2);
		{
		ContextSearchAdapter::PositionsReader pos_reader (str2, -1, ContextSearch::Morpho::SP_TEXT);
		ContextSearchAdapter::StreamReader str_reader (str0);
		ContextSearch::DBComm::Ref ref = {0,0};
		while (str_reader.get_next (ref)) {
			long id = ref.doc_id, from, to;
			if (laws.IndexOf (&id) == -1)
				continue;

			ContextSearch::Relevancy::Positions positions;
			pos_reader.get_data (positions, ref, ContextSearch::Morpho::PositionsType::dt_Text);

			for (ContextSearch::Relevancy::Positions::const_iterator pos_it = positions.begin (); pos_it != positions.end (); pos_it++) {
				long pos = *pos_it;
				if ((pos & ContextSearch::POS_FLAGS) == ContextSearch::POS_HEADER) {
					pos &= ContextSearch::POS_TEXT;
					std::map<long,long>::iterator it = doc_pos_of_o.find (id);
					if (it == doc_pos_of_o.end ()) {
						doc_pos_of_o.insert (std::map<long,long>::value_type (id, pos));
					} else {
						it->second = std::min (it->second, pos);
					}
					break;
				}
			}
		}
		}
		index->Close (str2);
		index->Close (str0);

		key [0] = 3;
		key [2] = 'Б';
		str0 = index->Open (key), str2 = index->OpenN (key, 2);
		{
		ContextSearchAdapter::PositionsReader pos_reader (str2, -1, ContextSearch::Morpho::SP_TEXT);
		ContextSearchAdapter::StreamReader str_reader (str0);
		ContextSearch::DBComm::Ref ref = {0,0};
		while (str_reader.get_next (ref)) {
			long id = ref.doc_id, from, to;
			if (laws.IndexOf (&id) == -1)
				continue;

			ContextSearch::Relevancy::Positions positions;
			pos_reader.get_data (positions, ref, ContextSearch::Morpho::PositionsType::dt_Text);

			for (ContextSearch::Relevancy::Positions::const_iterator pos_it = positions.begin (); pos_it != positions.end (); pos_it++) {
				long pos = *pos_it;
				if ((pos & ContextSearch::POS_FLAGS) == ContextSearch::POS_HEADER) {
					pos &= ContextSearch::POS_TEXT;
					std::map<long,long>::iterator it = doc_pos_of_o.find (id);
					if (it == doc_pos_of_o.end ()) {
						doc_pos_of_o.insert (std::map<long,long>::value_type (id, pos));
					} else {
						it->second = std::min (it->second, pos);
					}
					break;
				}
			}
		}
		}
		index->Close (str2);
		index->Close (str0);
		delete base;

		if (doc_pos_of_o.size ()) {
			long size = doc_pos_of_o.size () * sizeof (long) * 2, *data = (long*) malloc (size), *ptr = data;
			for (std::map<long,long>::const_iterator it = doc_pos_of_o.begin (); it != doc_pos_of_o.end (); it++, ptr++) {
				*ptr = it->first;
				ptr++;
				*ptr = it->second;
			}
			//записать data в Aux.AUX_O_POSITIONS

			StdBigBase *out_base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Stream* str = out_base->FindIndex ("Aux")->Open (AUX_O_POSITIONS, 1);
			if (str) {
				str->Write (data, size);
				str->Trunc ();
				out_base->FindIndex ("Aux")->Close (str);
			}
			delete out_base;
			gk_free (data);
		}

	}

	return 0;
}
