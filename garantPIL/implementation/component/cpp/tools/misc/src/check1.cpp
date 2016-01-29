#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "garutils.h"
#include "stdbase.h"
#include "SearchB.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);

	DocCollection laws;
	Index* types = base->FindIndex ("Type");
	for (BTIterator it (types); !it.End (); ++it) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*) it.Key ();
		if (key->level == 0 && !strcmp (key->text+4, "Закон")) {
			Stream *str = types->Index::OpenN (key, 0);
			if (str) {
				laws.FastLoadRefs (str);
				types->Close (str);
			}
			break;
		}
	}
	for (int i = 0; i < laws.ItemCount; i++) {
		long id = laws [i];
		DocInfo docinfo;
		base->FindDocInfo (id, docinfo);
		if ((docinfo.Status & DS_DOC) && (docinfo.prevEdition || docinfo.nextEdition)) {
			bool found_oem = false;
			Document* doc = base->GetDoc (id);
			for (int j = 0; j < docinfo.ParaCount && !found_oem; j++) {
				char* ptr = doc->GetPara (j);
				if (doc->EVDCodePage (ptr)== CP_OEM && doc->EVDTextSize (ptr) > 0) {
					//printf ("%ld.%ld:%s\n", id, j, doc->EVDParaText (ptr));
					found_oem = true;
				}
			}
			if (!found_oem) {
				printf ("%ld\n", id);
			}
			delete doc;
		}
	}

	delete base;
	return 0;
}
