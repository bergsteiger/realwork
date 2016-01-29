// 69toCode.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include <afxwin.h>         // MFC core and standard components
#include "../../BdrPersn/msvc.win32/LongInt.h"
#include "../../gkdb/src/pagefile.h"

extern "C"
{
	char *GetBasedExtFileName( char *pStr, int iVal)
	{
		return 0;
	}
	int	IsNextTom(	LPPF_PARAM pPrm )
	{
		return 0;
	}
	char *sel_Belngs= 0;
	int gsplit_Method(int argc, char **argv, void *pCntx)
	{
		return -1;
	}
	extern char *pl_getResponce(char *, long *, long *);
	extern int __stdcall pl_InitCrypto(HANDLE hWnd);
	extern void __stdcall pl_DoneCrypto(HANDLE hWnd);
	extern long _getAnswerVal(long);
	long MaskAnswerVal= 0x12345678;
}

int main(int argc, char* argv[])
{
	if(argc != 2)
		return -1;
	char *pNxt= argv[1], *pOut= pNxt;
	while(*pNxt){
		if(*pNxt < '0' || *pNxt > '9'){
			// skip char //
		}else{
			*pOut= *pNxt;
			pOut++;
		}
		pNxt++;
	}
	*pOut= 0;

	printf("\nPlease wait... ");
	if(pl_InitCrypto( 0 )){
		printf("Error in Password !\n");
		return -2;
	}

	CLongInt<128> cur_passw(argv[1], 10);
	long ID_Data, ID_Client, tst;
	pOut= pl_getResponce(	(char*)(LPCTSTR)cur_passw.ToString(16),
							&ID_Data, &ID_Client);
	if(pOut == 0){
		printf("Error in Password !\n");
		return -2;
	}
	// real synchro val //
	tst= _getAnswerVal(atoi(pOut));
	pl_DoneCrypto( 0 );
	printf("%s\n",pOut);
	return 0;
}

