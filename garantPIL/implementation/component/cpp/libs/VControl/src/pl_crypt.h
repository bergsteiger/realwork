#ifndef PL_INC_CRYPTO
	#define PL_INC_CRYPTO
	// first little synchro fof QuickGenerater a pseudorandom number
	#define START_VALUE 0x38549391
	// QuickGenerater a pseudorandom number
	#define QUICK_RAND(XX) ((XX = 1664525L * XX + 1013904223L) >> 5)
	// 32Bits
	#define SIZE_CRYPTO_TICK 1
	// 64Bits
	#define SIZE_CRYPTO_KYE_PER_DWORD 2
	// 64Bits
	#define SIZE_SYNHRO_PER_DWORD 2
	// 32Bits * (SIZE_CRYPTO_TICK+SIZE_SYNHRO_PER_DWORD)
	#define SIZE_CRYPTO_HEADER (sizeof(DWORD) * (SIZE_CRYPTO_TICK+SIZE_SYNHRO_PER_DWORD))
	//
	#define LOGIN_SIZE_PER_BYTES 16
	#define PSSWRD_SIZE_PER_BYTES 16

	// 2b	-> (0) сетевой, (1) локальный, (2) однопользовательский сетевой
	// 1b	-> (0) демо, (1) не демо
	// 13b	-> 8191	>= 3072 - Service (5636 >= Iniciator (2636))
	//						>= 2048 - Writers
	//								>= 1024 Makers
	// 13b	-> Copyer
	// 11b	-> 2047 >= 1 - Complects
	// 7b	-> 127	>= 1 - HD identificator ( 0 -> CD )
	// 13b	-> 8191 >= 1 - Clients

	//typedef unsigned char BYTE;
	//typedef BYTE* PBYTE;
	typedef unsigned long DWORD;
	//typedef DWORD* PDWORD;

#define FZ1_HDR_SIGN		0x31487a46
#define FZ1_POST_HDR_SIGN	0x32487a46
#define FZ1_CIB_SIGN		0x33487a46
#define UIDDB_STREAM_SIGN	"GrntUIDB"

#ifdef _DEBUG
	#define PL_ALLOC_STEP 10
#else
	#define PL_ALLOC_STEP 100
#endif

#define PL_WORK_FLAG 0x6b726f77
#define PL_INSTALL_FLAG 0x75757575
#define PL_MAX_HDD_NUMBER 101l
#define PL_MAX_FRANDS_COUNT 100
#define PL_MAX_BELNGS_COUNT 255

	typedef struct PL_FZ1_HDR_TAG
	{
		long	lSgntr;
		short	LoginServiceSz;
		short	LoginCopyerSz;
		long	lOffsetList;
		long	lCountList;
		long	lOffsetUIDB;
		time_t	timeMake;
	} PL_FZ1_HDR, *LPPL_FZ1_HDR;

	typedef struct PL_FZ1_POST_HDR_TAG
	{
		long	lSgntr;
		long	lNumber;
		long	lCountList;
		long	lCDType;
		long	lCDNumber;
		long	lProtectType;
		long	lPriority;
		short	NameServiceSz;
		time_t	timeMake;
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
		BYTE	BelngsSize;
		PBYTE	pTable;
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

	extern void InitCrypto(int *pRet, HANDLE hWnd);
	extern void DoneCrypto(DWORD *pRet, HANDLE hWnd);

	extern int pl_CreateFZ1(	char *LicenseFileName, LPPL_FZ1_HDR pSourceMem,
								char *OutputFileName);

	extern int pl_CreateLicenseEx(	char *FileName,
									char *pServiceLogin, char *pServicePasswordedHash,
									PDWORD pId,
									long frandsCount, LPPL_SDB_RECRD pFrands);

	extern int _writeOffset(int fh, long currPos, long woffset);
#endif
