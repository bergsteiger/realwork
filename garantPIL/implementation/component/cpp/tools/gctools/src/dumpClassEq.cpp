#include <cstdio>
#include "classes.h"
#include "fstring.h"
#include "FString.long.SplayMap.h"


int main( int argc, char ** argv)
{
	int status;
	if( argc < 2 ){
		printf("Usage is:\n%s <class-file> [class]\n", argv[0]);
		return 1;
	}
	ClassesInfo ci;

	if( (status = readClassInfo(ci, argv[1])) != 0  ){
		printf("readClassInfo: error %d\n", status );
		return 0;
	}else{
		if( argc < 3 ){
			for( int i=0; i< ci.classCount; i++ ){

				if( ci.clInfo[i].nEquals < 1 ) continue;

				printf("%s:\n", ci.clInfo[i].className );
				for(int eq=0; eq< ci.clInfo[i].nEquals; eq++ ){
					printf("\t%s\n",
						ci.clInfo[ci.clInfo[i].equals[eq]].className);
				}
			}
		}else{
			FString tmp(argv[2]);
			if( ci.cm->contains(tmp ) ){
				int i= (*(ci.cm))[tmp];
				printf("%s:\n", ci.clInfo[i].className );
				for(int eq=0; eq< ci.clInfo[i].nEquals; eq++ ){
					printf("\t%s\n",
						ci.clInfo[ci.clInfo[i].equals[eq]].className);
				}
			}else{
				printf("Class `%s' unknown.\n", argv[2] );
			}
		}
	}
	return 0;
}


