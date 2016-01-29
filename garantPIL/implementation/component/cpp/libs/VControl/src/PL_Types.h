#ifndef PL_INC_TYPES
#define PL_INC_TYPES
	//////////////////////////////////////////////////
	// PL_TYPES.H									//
	//												//
	// C/C++ Header file for Personification API	//
	//////////////////////////////////////////////////
	#include "PL_Defs.h"

	typedef struct PL_IMPORT_HASH_TAG
	{
		void	*Reserve;
		BYTE	Result[PSSWRD_SIZE_PER_BYTES];
	} PL_IMPORT_HASH, *LPPL_IMPORT_HASH;

	typedef struct PL_IMPORT_CIB_DATA_TAG
	{
		char	*pLogin;
		char	*Alias;
		void	*next;
	} PL_IMPORT_CIB_DATA, *LPPL_IMPORT_CIB_DATA;

	typedef struct PL_IMPORT_COMPLECT_DATA_TAG
	{
		long					Key[SIZE_SYNHRO_PER_DWORD*sizeof(DWORD)];
		LPPL_IMPORT_CIB_DATA	pCIBs;
		void					*next;
	} PL_IMPORT_COMPLECT_DATA, *LPPL_IMPORT_COMPLECT_DATA;

	typedef struct PL_SDB_IMPORT_RECORD_TAG
	{
		long	reserve0[2];
		BYTE	pLogin[LOGIN_SIZE_PER_BYTES];
		BYTE	pPsswrdHash[PSSWRD_SIZE_PER_BYTES];
		long	ID;
		long	reserve1;
		BYTE	BelngsSize;
		PBYTE	pTable;
		PDWORD	reserve2;
	} PL_SDB_IMPORT_RECRD, *LPPL_SDB_IMPORT_RECRD;
#endif
