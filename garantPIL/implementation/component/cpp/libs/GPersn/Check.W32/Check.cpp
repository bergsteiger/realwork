#include "shared/Core/fix/mpcxc.h"
// Check.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "windows.h"
#include "stdbase.h"
#include "PL_Defs.h"

extern "C" void HashDWORD(PDWORD pRet);
extern "C" int _InitHash();

int main(int argc, char* argv[])
{
	if(argc < 2 || argc > 2){
		printf("Usage: Check filename\n");
		printf("\nNote: 'filename' - file with first megabytes from NDT file.\n");
		return -1;
	}
	_InitHash();
	PagedFile NDT(argv[1], ACE_OS_O_RDONLY);

	// Сначала на старых лицензиях только СО
	DWORD result= 1, tmp;
	printf("\n Check Service & Replicator...");
	for(int ii= 0; ii < 1000; ii++, result++){
		tmp= result;
		HashDWORD(&tmp);
		if(((PDWORD)(NDT.m_pCryptoTag+LOGIN_SIZE_PER_BYTES+1))[1]
			== tmp){
			printf("\n Service - N %d, Replicator - not define.", result);
			ii= -1;
			break;
		}
	}
	if(ii != -1){
		printf(" Continue check...");
		// ... на Валидных лицензиях только СО и ТУ
		result= 1;
		DWORD second;
		for(int jj= 0; jj < 1000; jj++, result++){
			tmp= result;
			second= 1;
			for(ii= 0; ii < 1000; ii++, second++, tmp= result){
				tmp |= second << 17;
				HashDWORD(&tmp);
				if(((PDWORD)(NDT.m_pCryptoTag+LOGIN_SIZE_PER_BYTES+1))[1]
					== tmp){
					printf("\n Service - N %d, Replicator - N %d.", result, second);
					ii= -1;
					jj= 1000 + 1;
					break;
				}
			}
		}
	}
	printf("\n Check Client...");
	for(result= 1, ii= 0; ii < 0x7fffffff; ii++, result++){
		tmp= result;
		HashDWORD(&tmp);
		if(((PDWORD)(NDT.m_pCryptoTag+LOGIN_SIZE_PER_BYTES+1))[0]
			== tmp){
			printf("\n Client - N %d.", result);
			ii= -1;
			break;
		}
	}
	result= 1;
	return 0;
}

