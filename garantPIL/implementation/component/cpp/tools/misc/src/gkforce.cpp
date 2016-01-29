#include "shared/Core/fix/mpcxc.h"
// gkdumpi.cc
#include <cstdio>
#include <cstdlib>
//#include <unistd.h>
#include <ctime>

#include "stdbase.h"
#include "btiter.h"
#include <cstring>

static void usage(char *str)
{
	printf("Usage: %s -m <min_force_value> <base>\n", str);
	printf("         -h for this help\n");
}
static void dump_forced_docs(Base *b,int mf,FILE *of) 
{
	AttrKey ks = { 0, IDD_INFO };
	DocInfo di;
	int total_docs =0, mark_docs =0;

	for(BTIterator it(b->docInd, &ks); !it.End() ; ++it ){
		AttrKey *k = (AttrKey*) it.Key();
		if( k->AttrTag != IDD_INFO )
			break;
		if( k->DocId < 100000 ) continue;
		total_docs ++;

		Stream *str = b->docInd->Open(k);
		if( str ){
			str->Read(&di, sizeof di );
			if( di.Force <= mf ){
				mark_docs ++;
				fprintf(of,"%ld (%d): %s\n", k->DocId - 100000,
											di.Force, di.Title );
				
			}
			b->docInd->Close(str);
		}else{
			fprintf(of,"Warning: no stream for doc %ld.\n", k->DocId - 100000);
		}
	}
	fprintf(of,"Total %d topics checked, %d has force less or equal to %d.\n",
		total_docs, mark_docs, mf );
}
int main(int argc, char **argv)
{
	int rv = 0;
	int option_char;
	extern char *optarg;
	extern int optind;
	char *mypath = argv[0];
	int min_force = 0;

	while ((option_char = getopt(argc,argv,"hm:")) != EOF) {
		switch(option_char) {
			case 'h':
				usage(mypath);
				return 0;
			case 'm':
				min_force = atoi(optarg);
				break;
			default:
				usage(mypath);
				return 1;
		}
	}
	argc -= optind;
	argv += optind;

	if( !argc ){
		usage(mypath);
		return 1;
	}
	if( !min_force ){
		printf("min_force_value must be greater then 0.\n");
		usage(mypath);
		return 1;
	}

	Base *base = new YBase( argv[0], ACE_OS_O_RDONLY );
	if( !base || !base->IsOk()){
		printf("Base %s not OK.\n", argv[0] );
		return 1;
	}
	dump_forced_docs(base,min_force,stdout);
	delete base;
	return rv;
}





