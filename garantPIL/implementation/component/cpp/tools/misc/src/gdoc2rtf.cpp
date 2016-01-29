#include "shared/Core/fix/mpcxc.h"
// gkgetdoc.cc
#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include "stdbase.h"
#include "rtffile.h"
#include "rtfgar.h"


int main ( int argc, char **argv )
{
	if( argc < 4 ){
		fprintf(stderr,"Usage: %s <base> <DocId> <out_file>\n", argv[0] );
		return 1;
	}
	YBase *base = new YBase( argv[1], ACE_OS_O_RDONLY );
	if( !base || !base->IsOk() ){
		fprintf(stderr, "Can't check base.\n");
		return 1;
	}
	unsigned	  Id = atoi(argv[2]);
	printf("Searching for doc %d\n", Id);
	Document * doc = base -> GetDoc ( Id );
	if( doc ){
		fprintf(stderr, "Processing doc %d\n", Id ); 
		GRTFWriter grtf;
		RTFFileWriter rtf(0);

		FILE* fl = mpcxc_fopen(argv[3], "w");
		rtf.set_file(fl);
		grtf.Attach(&rtf);
		grtf.StartRTF("a", "b");

		for ( int j = 0; j < doc -> Stat.ParaCount; j++ ) {
			char  * ptr  = doc -> GetPara ( j );

			unsigned len = TextSize ( ptr );
			const char *src = ParaText ( ptr );
			
		}
		grtf.FinishRTF();
		grtf.Detach();
		fclose(fl);
		delete doc;
	}else{
		fprintf(stderr, "Can't find doc %d\n", Id );
	}
	delete base;
	return 0;
}




