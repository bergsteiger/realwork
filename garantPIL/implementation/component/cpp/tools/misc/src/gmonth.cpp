#include "shared/Core/fix/mpcxc.h"
#include <iostream.h>
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

char *monNames[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun",
		"Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };

int main(int argc, char **argv)
{
	if (argc < 2) {
		cout << "Usage: " << argv[0] << " <base>" << endl;
		return -1;
	}
	YBase *base = new YBase(argv[1], ACE_OS_O_RDONLY);
	if (!base || !base->IsOk()) {
		cout << "Error opening base." << endl;
		return -1;
	}
	Index *idx = base->FindIndex("VIncluded");
	if (!idx) {
		cout << "No index!" << endl;
		return -1;
	}
	BTIterator it(idx);
	char curMon = 0;
	int curYear = 0;
	int count = 0;
	while (!it.End()) {
		date *key = (date *)it.Key();
		if (key->da_mon != curMon) {
			if (curMon) 
				printf("%d documents added in %s/%d\n", count, monNames[curMon-1], curYear);
			count = 0;
			curMon = key->da_mon;
			curYear = key->da_year;
		}
		Stream *str = idx->Open(key);
		count += str->Length() / 4;
		idx->Close(str);
		++it;
	}
	delete base;
}

