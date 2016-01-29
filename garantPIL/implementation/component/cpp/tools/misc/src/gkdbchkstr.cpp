#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include "stdbase.h"

int main(int argc, char ** argv)
{
	if( argc < 2 ){
		printf("usage is:\n%s base [base..]", argv[0]);
		return 0;
	}
	for( int i=1; i<argc; i++ ){
		YBase b(argv[i], ACE_OS_O_RDONLY);
		if( !b.IsOk() ){
			printf("Base %s not ok.\n", argv[i] );
		}else{
			printf("Checking base %s \n", argv[i] );
			b.streamFile->Check();
		}
	}
	return 0;
}


