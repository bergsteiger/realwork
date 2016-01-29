#ifndef PL_INC_CRYPTO
	#define PL_INC_CRYPTO
	// 2b	-> (0) сетевой, (1) локальный, (2) однопользовательский сетевой
	// 1b	-> (0) демо, (1) не демо
	// 13b	-> 8191	>= 3072 - Service (5636 >= Iniciator (2636))
	//						>= 2048 - Writers
	//								>= 1024 Makers
	// 13b	-> Copyer
	// 11b	-> 2047 >= 1 - Complects
	// 7b	-> 127	>= 1 - HD identificator ( 0 -> CD )
	// 13b	-> 8191 >= 1 - Clients

#ifdef _DEBUG
	#define PL_ALLOC_STEP 10
#else
	#define PL_ALLOC_STEP 100
#endif

#define PL_WORK_FLAG 0x4b524f57
#define PL_INSTALL_FLAG 0x75757575
#define PL_HASP_FLAG 0x50534148
#define PL_PASS_FLAG 0x53534150
#define PL_MAX_HDD_NUMBER 1001l
#define PL_MAX_FRANDS_COUNT 100
#define PL_MAX_BELNGS_COUNT (255*sizeof(WORD))

	#include "./PL_Proto.h"

#pragma pack(1)
	typedef struct PL_FZ1_HDR_TAG
	{
		long	lSgntr;
#ifndef RD_AS_ETALON
		short	ServiceSz;
#else
		short	LoginServiceSz;
#endif
		short	LoginCopyerSz;
		long	lOffsetList;
		long	lCountList;
		long	lOffsetUIDB;
		long	timeMake;
	} PL_FZ1_HDR, *LPPL_FZ1_HDR;

	typedef struct PL_FZ1_POST_HDR_TAG
	{
		long	lSgntr;
		long	lNumber;
		long	lCountList;
		long	lCDType;
		long	lCDNumber;
#ifndef RD_AS_ETALON
		long	lTransprtType;
#endif
		long	lProtectType;
		long	lPriority;
		short	NameServiceSz;
		long	timeMake;
	} PL_FZ1_POST_HDR, *LPPL_FZ1_POST_HDR;

	typedef struct PL_FZ1_CIB_TAG
	{
		long	lSgntr;
		long	lID;
		short	NameClientSz;
	} PL_FZ1_CIB, *LPPL_FZ1_CIB;

	typedef struct PL_FZ1_CIB_POST_TAG
	{
		long	lFloppyCount;
		long	lNet;
		long	lType;
		long	lInstall;
		long	lDemo;
		long	lSpec;
		short	lSpecStringSz;
	} PL_FZ1_CIB_POST, *LPPL_FZ1_CIB_POST;

	typedef struct PL_SDB_ATTRIB_TAG
	{
		WORD	BelngsSize;
		PWORD	pTable;
	} PL_SDB_ATTRIB, *LPPL_SDB_ATTRIB;

	typedef struct PL_SDB_PRE_RECORD_TAG
	{
		BYTE			pLogin[LOGIN_SIZE_PER_BYTES];
		BYTE			pPsswrd[PSSWRD_SIZE_PER_BYTES];
		DWORD			pId[SIZE_CRYPTO_KYE_PER_DWORD];
		PL_SDB_ATTRIB	Attrib;
	} PL_SDB_PRE_RECRD, *LPPL_SDB_PRE_RECRD;

	typedef struct PL_SDB_RECORD_TAG
	{
		long				offset_to_next;
		long				frandsCount;
		PL_SDB_PRE_RECRD	account;
		PDWORD				pFrands;
	} PL_SDB_RECRD, *LPPL_SDB_RECRD;
#pragma pack()

	extern void InitCrypto(int *pRet, HANDLE hWnd);
	extern void DoneCrypto(DWORD *pRet, HANDLE hWnd);

#ifdef __cplusplus
extern "C" {
#endif
	extern int pl_CreateFZ1(	char *LicenseFileName, LPPL_FZ1_HDR pSourceMem,
								char *OutputFileName);

	extern int pl_CreateLicenseEx(	char *FileName,
									char *pServiceLogin, char *pServicePasswordedHash,
									PDWORD pId,
									char *AdvancedInfo,
									long frandsCount, LPPL_SDB_RECRD pFrands);
#ifdef __cplusplus
}
#endif

	extern int _writeOffset(int fh, long currPos, long woffset);
#endif

/*
MPCXC
-change: #include "./PL_Proto.h" enforced
*/

