#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"
#include "SearchB.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

struct CorrRefSorter {
	bool operator () (const CorrRef& ref1, const CorrRef& ref2) const {
		return ref1.DocId == ref2.DocId ? ref1.RealPara < ref2.RealPara : ref1.DocId < ref2.DocId;
	}
};

struct CorrRefUnique {
	bool operator () (const CorrRef& ref1, const CorrRef& ref2) const {
		return ref1.DocId == ref2.DocId && ref1.RealPara == ref2.RealPara;
	}
};

int main_logic ( int argc, char *argv[] )
{
	YBase *base = new ToolsBase (argv [1]);

	RefCollection selected_blocks, kind_refs;
	Ref ref = {10900200, 0};
	ref.Sub = 0; selected_blocks.Add (ref);
	ref.Sub = 2; selected_blocks.Add (ref);
	ref.Sub = 346504212; selected_blocks.Add (ref);

	Index *kind_index = base->FindIndex ("Kind");
	BTIterator it (kind_index);
	HIndex::HIndexKey *key = (HIndex::HIndexKey*) it.Key ();
	Stream *str = kind_index->Index::OpenN (key, 0);
	if (str) {
		kind_refs.Get (str);
		kind_index->Close (str);
	}

	{
		long id = selected_blocks [0].DocId, i;
		std::deque<long> selection;
		for (i = 0; i < selected_blocks.ItemCount; i++)
			selection.push_back (selected_blocks [i].Sub);
		std::deque<long>::const_iterator selection_it = selection.begin ();
		long sub = *selection_it;

		std::deque<CorrRef> maybe_corrs;

		static const int max_portion = sizeof (CorrRef) * 4096;
		CorrRef buffer [4096], *ptr;

		Stream *str = base->FindIndex ("NewCorr")->Open (&id);
		if (str) {
			long str_length = str->Length ();
			while (true) {
				long portion = std::min <long> (max_portion, str_length);
				if (portion == 0)
					break;
				portion = str->Read (buffer, portion);
				str_length -= portion;
				for (ptr = buffer, portion /= sizeof (CorrRef); portion; portion--, ptr++) {
					if (ptr->Sub < sub)
						continue;
					else if (ptr->Sub > sub) {
						while (ptr->Sub >= sub && selection_it != selection.end ()) {
							selection_it++;
							sub = *selection_it;
						}
						if (ptr->Sub > sub)
							break;
					}					
					maybe_corrs.push_back (*ptr);
				}
			}
			base->FindIndex ("NewCorr")->Close (str);

			std::sort (maybe_corrs.begin (), maybe_corrs.end (), CorrRefSorter ());
			maybe_corrs.erase (std::unique (maybe_corrs.begin (), maybe_corrs.end (), CorrRefUnique ()), maybe_corrs.end ());

			CorrRefCollection result;
			int page = 0, page_count = kind_refs.PageCount, count = 0, max_count = kind_refs.Count [page];
			Ref *kind_ref = (Ref*) kind_refs.Pages [page], item;
			for (std::deque<CorrRef>::const_iterator corr_it = maybe_corrs.begin (); corr_it != maybe_corrs.end (); corr_it++) {
				item.DocId = corr_it->DocId;
				item.Sub = corr_it->Block;
				while (CompRefsMinus (kind_ref, &item) < 0) {
					kind_ref++;
					if (++count == max_count) {
						if (++page == page_count) {
							kind_ref = 0;
							break;
						}
						kind_ref = (Ref*) kind_refs.Pages [page];
						count = 0;
						max_count = kind_refs.Count [page];
					}
				}
				if (kind_ref && !CompRefsMinus (kind_ref, &item)) {
					CorrRef at_corr_it = *corr_it;
					result.Collection::Add (&at_corr_it);
					printf ("%ld.%ld\n", item.DocId, item.Sub);
				}
			}
		}
	}


	delete base;
	return 0;
}
