#ifndef PL_INC_DEFS
#define PL_INC_DEFS
	//////////////////////////////////////////////////
	// PL_PROTO.H									//
	//												//
	// C/C++ Header file for Personification API	//
	//////////////////////////////////////////////////
	#include "Windows.h"
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

	#define FZ1_HDR_SIGN		0x31487a46
	#define FZ1_POST_HDR_SIGN	0x32487a46
	#define FZ1_CIB_SIGN		0x33487a46
	#define UIDDB_STREAM_SIGN	"GrntUIDB"

	#ifdef _DEBUG
		#define PL_ALLOC_STEP 10
	#else
		#define PL_ALLOC_STEP 100
	#endif

	#define PL_INSTALL_FLAG 0x75757575
	#define PL_MAX_HDD_NUMBER 101l
	#define PL_MAX_FRANDS_COUNT 100
	#define PL_MAX_BELNGS_COUNT 255

#ifdef MAKE_HDD
	#define PL_HDD_SIGN -1968L
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
