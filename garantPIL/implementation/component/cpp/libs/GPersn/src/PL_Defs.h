#ifndef PL_INC_DEFS
#define PL_INC_DEFS
	//////////////////////////////////////////////////
	// PL_PROTO.H									//
	//												//
	// C/C++ Header file for Personification API	//
	//////////////////////////////////////////////////

	#define PL_INC_CRYPTO
	// first little synchro fof QuickGenerater a pseudorandom number
	#define START_VALUE 0x38549391
	// QuickGenerater a pseudorandom number
	#define QUICK_RAND(XX) ((XX = (832262L * XX + 506952111) * 2 + 1 + XX) >> 5)
	// 32Bits
	#define SIZE_CRYPTO_TICK 1
	// 64Bits
	#define SIZE_CRYPTO_KYE_PER_DWORD 2
	// 64Bits
	#define SIZE_SYNHRO_PER_DWORD 2
	// 32Bits * (SIZE_CRYPTO_TICK+SIZE_SYNHRO_PER_DWORD)
	#define SIZE_CRYPTO_HEADER (sizeof(long) * (SIZE_CRYPTO_TICK+SIZE_SYNHRO_PER_DWORD))
	//
	#define LOGIN_SIZE_PER_BYTES 16
	#define PSSWRD_SIZE_PER_BYTES 16

	#define FZ1_HDR_SIGN		0x31487a46
	#define FZ1_POST_HDR_SIGN	0x32487a46
	#define FZ1_CIB_SIGN		0x33487a46

	#define FZ2_HDR_SIGN		0x31487246
	#define FZ2_POST_HDR_SIGN	0x32487246
	#define FZ2_CIB_SIGN		0x33487246

#ifdef RD_AS_ETALON
	#define UIDDB_STREAM_SIGN	"GrntUIDB"
#else
	#define PL_VIP_FLAG 0x50495649
	#define PL_TRIAL_FLAG 0x00007254
	#define PL_FREE_FLAG 0x65657246
	#define PL_FLP_FLAG 0x00004446
	#define PL_HASP_FLAG 0x50534148
	#define UIDDB_STREAM_SIGN	"53UID_DB"
	#define MULTI_LCNS_SIGN	0x4c46434c
#endif

	#ifdef _DEBUG
		#define PL_ALLOC_STEP 10
	#else
		#define PL_ALLOC_STEP 100
	#endif
#ifndef PL_INSTALL_FLAG
	#define PL_INSTALL_FLAG 0x75757575
#endif
#ifndef PL_MAX_HDD_NUMBER
	#define PL_MAX_HDD_NUMBER 101l
#endif
#ifndef PL_MAX_FRANDS_COUNT
	#define PL_MAX_FRANDS_COUNT 100
#endif
#ifndef PL_MAX_BELNGS_COUNT
	#define PL_MAX_BELNGS_COUNT (255*sizeof(WORD))
#endif

#ifdef MAKE_HDD
	#ifndef NOT_RD
		#define PL_HDD_SIGN -1968L
	#else
		#define PL_HDD_SIGN -1970L
	#endif
#else
	#define PL_HDD_SIGN -2001L
#endif

 #ifdef INSTLL_CIB
	#define MAX_CRYPTED_BLOCK ((int)4096*2)
 #else
	#define MAX_CRYPTED_BLOCK (4096*100*2)
	#define MAX_CRYPTED_BLOCK_IN_WORK (4096*2)
 #endif
#endif
