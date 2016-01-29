#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include "stdbase.h"
#include "btiter.h"
#include "garver.h"


int main(int argc, char **argv)
{
	if (argc != 2) {
		printf("Garant base per doc stat");
		printf("Usage: %s <base>\n", argv[0]);
		return -1;
	}
	YBase *base = new YBase(argv[1], ACE_OS_O_RDONLY);
	if (!base || !base->IsOk()) {
		printf("Error opening base.");
		return -1;
	}
	AttrKey *k = new AttrKey;

	k->DocId = 0;
	k->AttrTag = IDD_INFO;

	printf("Id\tcommts\trefs\n");
	for( BTIterator it(base->docInd, k); !it.End(); ++it ){
		k = (AttrKey *) it.Key();
		if( k->AttrTag != IDD_INFO ) break;
		if( k->DocId <= 100000 ) continue;
		struct DocInfo di;
		Stream *str = base->docInd->Open(k );
		if( str ){
			str->Read(&di, sizeof(di) );
			printf("%ld\t%d\t%d\n",k->DocId - 100000, 
				di.GreenComments, di.HyperRefs);
			base->docInd->Close(str);
		}else{
			fprintf(stderr, "No stream for doc %ld???\n", k->DocId - 100000 );
		}
	}
	delete base;
}


