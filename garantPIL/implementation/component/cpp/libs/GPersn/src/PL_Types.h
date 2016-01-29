#ifndef PL_INC_TYPES
#define PL_INC_TYPES
	//////////////////////////////////////////////////
	// PL_TYPES.H									//
	//												//
	// C/C++ Header file for Personification API	//
	//////////////////////////////////////////////////
	#include "PL_Defs.h"

#ifndef DEF_MY_BYTE_AS_WITH_WINDOWS
	#define DEF_MY_BYTE_AS_WITH_WINDOWS
	typedef unsigned char BYTE;
	typedef BYTE* PBYTE;
	typedef unsigned short WORD;
	typedef WORD* PWORD;
	typedef unsigned long DWORD;
	typedef DWORD* PDWORD;
	typedef void *HANDLE;
	typedef HANDLE LPVOID;
	//#define TRUE 1
	//#define FASLE 0
	#include <time.h>
#endif

#pragma pack(1)
	typedef struct PL_IMPORT_HASH_TAG
	{
		char*	pInput;
		BYTE	Result[PSSWRD_SIZE_PER_BYTES];
	} PL_IMPORT_HASH, *LPPL_IMPORT_HASH;

	typedef struct PL_IMPORT_CIB_DATA_TAG
	{
		char	*pLogin;
		char	*Alias;
		void	*next;
	} PL_IMPORT_CIB_DATA, *LPPL_IMPORT_CIB_DATA;

	typedef struct PL_BASE_FILE_LIST_TAG
	{
		char	*pFileName;
		void	*pNext;
	} PL_BASE_FILE_LIST, *LPPL_BASE_FILE_LIST;

	typedef struct PL_IMPORT_COMPLECT_DATA_TAG
	{
		long					Key[SIZE_SYNHRO_PER_DWORD*sizeof(DWORD)];
		LPPL_IMPORT_CIB_DATA	pCIBs;
		void					*next;
	} PL_IMPORT_COMPLECT_DATA, *LPPL_IMPORT_COMPLECT_DATA;

	typedef struct PL_SDB_IMPORT_RECORD_TAG
	{
		long	reserve0[2];
		char	pLogin[LOGIN_SIZE_PER_BYTES];
		BYTE	pPsswrdHash[PSSWRD_SIZE_PER_BYTES];
		long	ID;
		long	reserve1;
		WORD	BelngsSize;
		PWORD	pTable;
		PDWORD	reserve2;
	} PL_SDB_IMPORT_RECRD, *LPPL_SDB_IMPORT_RECRD;

	typedef struct PL_MULTI_SDB_IMPORT_RECORD_TAG
	{
		char* LoginSerivice;
		LPPL_IMPORT_HASH pSeriviceDepPasswordHash;
		long ServiceDepID;
		long FriendedReplicatorsCount;
		LPPL_SDB_IMPORT_RECRD pFriendedReplicatorsList;
	} PL_MULTI_SDB_IMPORT_RECRD, *LPPL_MULTI_SDB_IMPORT_RECRD;
#pragma pack()

#endif

