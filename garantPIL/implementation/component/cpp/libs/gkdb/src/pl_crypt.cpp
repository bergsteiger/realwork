#include "shared/Core/fix/mpcxc.h"
//#include "stdio.h" // MPCXC printf not used

#ifdef VERSION61
	#include "gardefs.h"
#endif

#ifdef BRDR32
  #ifndef VERSION61
	#include "gardefs.h"
  #endif
#endif

#include "../../GPersn/src/pl_crypt.h"
#include "pagefile.h"

#include <cstring>
#include "ace/Basic_Types.h"
#include "ace/OS.h"
// GARANT_GCC

extern "C" {

#if defined(WIN32) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
	static HINSTANCE handle2GLink= 0;
	static WORD ( __stdcall *imp_HaspAllocComplect)(WORD CountCIBs, DWORD MediaID) = 0;
	static WORD ( __stdcall *imp_HaspGetMediaId)(PDWORD MediaID) = 0;
	static WORD ( __stdcall *imp_HaspAddTry)(WORD CIB_number) = 0;
	static WORD ( __stdcall *imp_HaspAddSuccess)(WORD CIB_number) = 0;
	#ifdef TEST_MAKE_HDD
		static WORD ( __stdcall *imp_HaspClearStat)(void) = 0;
	#endif
#endif

#if defined(WIN32) && defined(MAKE_HDD) && !defined(RD_AS_ETALON)
	#pragma pack(1)
	typedef struct PL_UDDB_SERVICES_TAG
	{
		DWORD Service_ID[SIZE_CRYPTO_KYE_PER_DWORD];
		long MaxNumber, *pMediaIDs, lAllocMediaIDs, lCountMediaIDs;
		int NotSavedMediaID_Numbr, NotSavedMediaID_lCD;
	} PL_UDDB_SERVICES, *LPPL_UDDB_SERVICES;
	#pragma pack()
	static PL_UDDB_SERVICES *pSERVICES= 0;
	long AllocSERVICES= 0, CountSERVICES= 0;
#endif

int pl_write(PBYTE *, long *, long *, void *, int);

#pragma pack(1)
typedef struct PL_UDDB_NAME_TAG
{
	char *pSource;
	char *pTarget;
	void *pMem;
} PL_UDDB_NAME, *LPPL_UDDB_NAME;
#pragma pack()

//#if defined (WIN32) || defined (GARANT_MPCXC)
//	static int hTickThread;
//	static HWND call_hWnd;
//#endif

static ACE_thread_t m_ThreadID;
static ACE_hthread_t m_ThreadHandle;
static DWORD	m_Tick;

static DWORD pCrptKy[]= { 0x6C884CA9, 0x85C34AF5, 0x00000000 };
PDWORD pextCrptKy= pCrptKy;

//static char pOldCrptKy[]= "Yaroslav";
//PDWORD pextCrptKy= (PDWORD)pOldCrptKy;

static char pDefLoginForWorkCD[]="Work_CD_from_HDD\x0------------------------";

// buffer for current value from QuickGenerater
static DWORD m_RandSeed = START_VALUE;
// pointer for current value CryptoKey
static DWORD *pCryptoKey= 0;
// pointer for current value Synchro
static DWORD pSynhro[SIZE_SYNHRO_PER_DWORD];
// Crypto_TAG
static DWORD Crypto_TAG[SIZE_CRYPTO_KYE_PER_DWORD];

#ifndef RD_AS_ETALON
long IsG6X_NDT[SIZE_SYNHRO_PER_DWORD];

#define HASH_TBL_SIZE 512

static DWORD glb_uz[HASH_TBL_SIZE]= {
 0x59a09d1c, 0x4406b217, 0x5ff2ce20, 0x9918ee86, 0x444bac3d, 0x710605e9, 0x57ed724f, 0x328456e4,
 0xf26ceab, 0x18f5aaff, 0xa394c600, 0x17140bd9, 0x2f59c880, 0xe4388949, 0xdcd183ce, 0x4db8fe1c,
 0x3153d84a, 0xfc727859, 0xc2ec905d, 0x2cf81557, 0x707f1adf, 0xff74ad66, 0x94c9b342, 0xd697856d,
 0x95a4daa1, 0xdc5f0963, 0x1a5395b9, 0x1277751c, 0x760043a3, 0xf5b80810, 0xa73e1cc4, 0xd1737246,
 0x4ab6e222, 0xec475ccf, 0x111faee2, 0x2ab1ceb6, 0xac6b575c, 0x3ee91a61, 0x4e96dd0b, 0xbe73aa24,
 0x8cbbb642, 0xa3f85212, 0x6fee8916, 0x94f0474, 0xf95fb04c, 0x4a87f66c, 0x42ed5beb, 0xf02b3b64,
 0x43c5d578, 0xd222e7f3, 0x4ba358fd, 0xd4faa878, 0x9421e532, 0x69d91d64, 0x65ff13a3, 0x73d01a4f,
 0x8792272d, 0x984b6e2e, 0xa50e2ce, 0xb31cd559, 0xcb4ff467, 0x2029aa7f, 0xa900c96c, 0xb01ebfdb,
 0xd47a60ae, 0xa8f255d0, 0x76df2047, 0x52fb91c8, 0xb4dd563c, 0xc08540f8, 0x3a08c352, 0xb2bb13b0,
 0x8e35b86e, 0xc5e6b6a2, 0x58c238cb, 0x9f7a9f45, 0x9aaed3b3, 0x57929ac, 0x47878c7b, 0xa5eaed17,
 0x41ceff16, 0x53a82bb0, 0xfcfda49d, 0x19de7ff2, 0x2342d328, 0xa6d17270, 0xe09d7bf1, 0x43b6cbd5,
 0x64f86df5, 0x283729a3, 0xbd0cc018, 0x5c33e1ba, 0x49df3f2, 0xe4d75119, 0x93237ecf, 0x7e10b9a2,
 0x84fe56d2, 0xb070dfe6, 0x75d12865, 0xecf5b8e8, 0x3d085336, 0x3b2638c9, 0x779bc018, 0xaddbf8be,
 0x30281488, 0x40407693, 0x95d64ee1, 0xf5a2706e, 0x94ee421c, 0xbf9ab074, 0xf4764a63, 0x37cc300,
 0x8ad49a0, 0xfd5724c5, 0x62c1f59d, 0x5703f04, 0xec4dfbc5, 0x99054bdd, 0xd18e421d, 0x368b7f1f,
 0x65af3287, 0x26ec58f2, 0x4141467d, 0xe20c23da, 0x7bccecb9, 0xa569e43, 0x77e342a0, 0xafc03211,
 0xb2ab0466, 0xfcd4ddd1, 0x1311e89a, 0x46cf5658, 0x6591eb90, 0x18ff819c, 0xa260db56, 0x309d92b0,
 0x8858bf34, 0x853b5c88, 0x2ad9fef5, 0x1741a00, 0x91580300, 0x3010c4f5, 0x26f811f8, 0xa6bd2da0,
 0x653da6b, 0xfcd413bf, 0xbea91578, 0xf492ae53, 0xa5d93c90, 0xb22996e4, 0xc7dcf30c, 0xf2426ec6,
 0x2eebfd97, 0x6fc2eb42, 0x32cbe42d, 0x9bfad0ed, 0xd8609c41, 0x4b72e357, 0x340a8c7d, 0x73a60e8d,
 0x576c03e4, 0xa0e15261, 0x5a6f9ea7, 0x25c71155, 0xe05e45f7, 0x21fe7a1f, 0x5401f8c3, 0x6b51ff59,
 0xeeff71c9, 0x4c4fc929, 0x567a8620, 0x4d5c57fb, 0x89e08f78, 0x84eb10a3, 0xbe122d9e, 0xcfcf2bd2,
 0xd6c50116, 0xbf171fbc, 0xbc07d3e2, 0x53174ddb, 0x64b67a24, 0x29d93854, 0xcb87e804, 0x563c734f,
 0xaad2661c, 0x3971ede5, 0x7caf7607, 0x3dbfea50, 0x4697e8a0, 0x62b52ba1, 0x274d300a, 0x6da73d8c,
 0xd08813a5, 0xc2e83732, 0x8055370f, 0x4fb9882, 0xacb08380, 0x8729fe7e, 0x85fdfd96, 0x179afabb,
 0x5eb39bdd, 0xf6cfc0e3, 0xf9dc3c49, 0x27415206, 0xedf8b76b, 0xd30737f3, 0xdb278055, 0xfd0c6d93,
 0x487770fc, 0xbe9c0ed, 0x642f54f, 0x61325e71, 0x66672e4b, 0xca4a05bb, 0x2d9bb3fb, 0xd7f3b2a9,
 0xc76101d, 0x96ad8958, 0x1625a809, 0xcd583771, 0xd47fc39d, 0xeb303f7e, 0x1a5c4451, 0x11a0ccae,
 0xd2576d9c, 0x22ea25dd, 0x9c9b77cd, 0x45da7cbe, 0x14bd16d4, 0x21c81313, 0x483e7810, 0x12b592ea,
 0xf649526d, 0xe5d9fb26, 0x6404f887, 0x1eafd1ed, 0x3f349992, 0xd5007646, 0x8f7fe178, 0x3e893591,
 0xfdcecb9b, 0xbee6bd09, 0x9820c107, 0x18e0e509, 0x3799c14d, 0x9e7a40b, 0x646ae82f, 0x25669396,
 0xe97608b3, 0xef65fda2, 0x72eb7d8c, 0x418ba6d6, 0xe04ecae8, 0x1c70acf4, 0x3234c73c, 0x50e1f8d,
 0x1583589b, 0x4ac6d6de, 0x6c71fd7c, 0x89e2d419, 0x2fd66a48, 0x604508ac, 0x25109cd5, 0x4c5e954a,
 0x6f6e4c82, 0xe90f22df, 0xf4aabd9c, 0x1c07148d, 0xd7cff024, 0x2dec498b, 0x4356e901, 0x46ec644a,
 0xd05776a4, 0x24f7f9d6, 0x947af7e9, 0x98d5fedb, 0xb907f943, 0x89fc9b56, 0x8a425fca, 0xbdf6f8c6,
 0xfdbb2ea4, 0x498605cc, 0x2442f292, 0x335da03c, 0x4574eaed, 0x37cdf977, 0xea717aa8, 0xf6e6d04,
 0xa73021e5, 0xb9d2d488, 0xf4b8aff9, 0x43414e85, 0xc4bb03d8, 0x49b00e19, 0x7014de4c, 0xed5e17a7,
 0xe66615a2, 0x7c8ae8e0, 0xdf593f0e, 0xa3ecf782, 0xd2e4780c, 0xd3398437, 0x947c2575, 0x48832166,
 0xbb03123a, 0x78c29b60, 0xda826790, 0x52782a41, 0x6a82abf0, 0x5b4fba62, 0x82db85e5, 0x74f69520,
 0x31bf72e0, 0xee32cf70, 0xaddb7603, 0xa3109b6e, 0x7a96159b, 0x5cf84d94, 0xe188c9e7, 0x20938f98,
 0x9b4b001f, 0x838cfef5, 0xaf36582, 0x5a119a89, 0xecef68d6, 0x502aad, 0xef41f045, 0x88ac5b71,
 0xc3eb4c6f, 0x6c02b10e, 0x8920e60c, 0x758bcd8d, 0x32c21b2f, 0xf4901a54, 0xde512838, 0x3a92de72,
 0xd6d04abd, 0xfc4805d7, 0xc96ad54b, 0x49a00607, 0x4fca3951, 0xf84510af, 0xbbf8c49c, 0x53dbf607,
 0x8e9c37c3, 0xc128a2e6, 0x1408e6be, 0xe7e48b84, 0xb8acf5d2, 0xbd66bb0d, 0x6b3091e7, 0x56a684a,
 0xc04cbec5, 0x227a99c8, 0x41973f4c, 0x7eb0b90d, 0xe621614, 0x9b74dd03, 0xd66cb99a, 0x251e4c30,
 0xc41b940d, 0xafb2e103, 0x79bc1d62, 0x74b9acf7, 0xca50bcfc, 0xde499b23, 0x868123df, 0x8afdf97a,
 0x5cda70a0, 0x7c811c1a, 0xca241b5f, 0xe7770584, 0xd2f2fde, 0x53db61db, 0x154e88e2, 0x44cafdab,
 0xd705d20c, 0x4a57a9f, 0x8d66ba80, 0x43e36c90, 0x7b2ac0dc, 0x85a1d57f, 0x849f42d, 0xc3734554,
 0xe0aa75d0, 0x16a365e3, 0xae1a3610, 0xb9daebb9, 0x90100405, 0x6037bb73, 0x91a627f1, 0x578118f7,
 0x9f3c3aa7, 0xc47c200a, 0x307ee212, 0xd75ca015, 0xfec0be39, 0x864f012b, 0x152110b9, 0x15d62b95,
 0x4a6bab2e, 0x41250f04, 0x57187df0, 0x62673275, 0x716f37a7, 0x6e51ddf5, 0xa46ed60f, 0x8a8a6339,
 0xb02e5a16, 0xce788e59, 0x54cd9ea6, 0x9cdf7642, 0x56c551c1, 0x8c1a17b9, 0x65ed96dd, 0xe8344d76,
 0x15434a81, 0x46d4846, 0x8894d971, 0x9becd59f, 0xd02dd0d3, 0x8d152f37, 0xe80f8609, 0xf3f83eea,
 0x702cab01, 0x1e546c70, 0x105405d5, 0xba1c2dec, 0xd9160e24, 0x82e71114, 0x74afed10, 0xc609d4c6,
 0x1879c582, 0xd5ef349d, 0x55ca9a08, 0x28e20056, 0x8aacf4a5, 0xe3b140cf, 0x5379225a, 0x2e01fcc2,
 0x8ba74616, 0x374444a6, 0x6380d9a9, 0x648367f1, 0xd9f0c97, 0x730551b5, 0x2874bf12, 0x5de339f2,
 0xa5dde493, 0x36b9a1d8, 0x731f5b91, 0xe299f1b3, 0xc220f62b, 0x52dcb8f6, 0x5a1c18ba, 0x4de23a3c,
 0x5e810f11, 0x412c7200, 0x63202fe9, 0x8e3aa506, 0xf06e5bb8, 0x1cd21df9, 0xa2bf619, 0x96506b2b,
 0x88bbca94, 0x78a52fb7, 0x5c75a93b, 0x71319820, 0xe96f3905, 0x1905dd7d, 0x5fee867f, 0xed3a7078,
 0xf8eb449, 0x486974e5, 0x6309c7ba, 0x68fd1206, 0x6c69e852, 0x678e4be6, 0x79d7a735, 0x44ff2e32,
 0x43558274, 0x9ec89930, 0xfad92805, 0x135df94c, 0x58b6dfeb, 0xaaa1561e, 0x34c65401, 0xf1823a02,
 0xd6eb4dc3, 0x3e703748, 0xd18dd146, 0x36665f78, 0xcd963366, 0xcc854473, 0xe76e5570, 0xa43c3173,
 0x40b9528e, 0x6ad50736, 0x904dc29a, 0xc41f0b6f, 0x4f7e0487, 0x5d2208b2, 0x4c7e0400, 0x6610b7b3,
 0xaf3c1c, 0xd95831c9, 0xa3c94320, 0xd69cd9c9, 0x5023c501, 0xd2d3f9dd, 0xec6622f9, 0x72dd3db6};

static DWORD *hash_tbl= 0;
#endif

//#ifdef WIN32
//	// Timer Ticker //
//	void tickProc(DWORD *thisVal)
//	{
//	R:	_asm mov eax,dword ptr [thisVal]
//	_asm inc dword ptr [eax]
//	_asm jmp R
//	}
//#else
#if defined (WIN32) || defined (GARANT_MPCXC)
static ACE_mutex_t tick_mutex_stop [1];
static bool tick_mutex_val = false;
ACE_THR_FUNC_RETURN tickProc(void* thisVal)
	{
R:		(*(DWORD *)thisVal)++;
		ACE_OS::mutex_lock (tick_mutex_stop);
		bool b = tick_mutex_val;
		ACE_OS::mutex_unlock (tick_mutex_stop);
		if (b) {
			return (ACE_THR_FUNC_RETURN) 0;
		}
        goto R;
	}
#endif
//#endif

void local_sscanf( char *pStr, int *pRet )
{
	while(*pStr == (char)' ') pStr++;
	{
		char *pFirst= pStr;
		int ii= 1;

		while(*pStr >= (char)'0' && *pStr <= (char)'9') pStr++;

		*pRet= 0;
		do{
			pStr--;
			*pRet += (*pStr - (char)'0') * ii;
			ii *= 10;
		}while(pStr != pFirst);
	}
}

void local_sscanf2( char *pStr, PDWORD pRet0, PDWORD pRet1 )
{
	char *pFirst= pStr, ctmp;
	int ii= 1;
	DWORD dwRet0;

	pStr += 8;

	dwRet0= 0;
	do{
		pStr--;
		if((ctmp= *pStr - (char)'0') < 10 )
			dwRet0 += ctmp * ii;
		else
			dwRet0 += (ctmp - ((char)'a' - (char)'0') + 10) * ii;
		ii *= 16;
	}while(pStr != pFirst);
	*pRet0= dwRet0;

	pStr += 8;
	pFirst= pStr;
	pStr += 8;
	dwRet0= 0;
	ii= 1;

	do{
		pStr--;
		if((ctmp= *pStr - (char)'0') < 10 )
			dwRet0 += ctmp * ii;
		else
			dwRet0 += (ctmp - ((char)'a' - (char)'0') + 10) * ii;
		ii *= 16;
	}while(pStr != pFirst);
	*pRet1= dwRet0;
}

void local_sprintfX(char *pOut, DWORD val0, DWORD val1)
{
	*pOut= (char)(val0 >> 28);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val0 & 0xf000000) >> 24);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val0 & 0xf00000) >> 20);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val0 & 0xf0000) >> 16);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val0 & 0xf000) >> 12);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val0 & 0xf00) >> 8);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val0 & 0xf0) >> 4);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)(val0 & 0xf);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;

	*pOut= (char)(val1 >> 28);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val1 & 0xf000000) >> 24);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val1 & 0xf00000) >> 20);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val1 & 0xf0000) >> 16);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val1 & 0xf000) >> 12);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val1 & 0xf00) >> 8);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)((val1 & 0xf0) >> 4);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;
	*pOut= (char)(val1 & 0xf);
	if(*pOut > 9) *pOut += 'a' - 10; else *pOut += '0'; pOut++;

	*pOut= '\0';
}

void local_sprintf(char *pOut, BYTE val)
{
	if(val > 99){
		pOut[0]= (char)(val/100) + (char)'0';
		pOut[1]= (char)((val%100)/10) + (char)'0';
		pOut[2]= (char)(val%10) + (char)'0';
		pOut[3]= ',';
	}else if(val > 9){
		pOut[0]= (char)(val/10) + (char)'0';
		pOut[1]= (char)(val%10) + (char)'0';
		pOut[2]= ',';
	}else{
		pOut[0]= (char)val+ (char)'0';
		pOut[1]= ',';
	}
}

int pl_GetLoginOffest()
{
	return SIZE_CRYPTO_HEADER+SIZE_CRYPTO_HEADER+LOGIN_SIZE_PER_BYTES + SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)+1;
}

#if !defined(RD_AS_ETALON) && defined(MAKE_HDD) && defined(WIN32)
	static char MyTableForLogin[]= "Q9OmAnZb2vWc0Sx1zL5lXMIkEj4hDKgCfRd3sFaJ7pVoTi6uGyBtYr8eHwNqUP";
/*
	typedef	unsigned __int64 QWORD;
	typedef	QWORD* PQWORD;

	static void MyPrintfFromTable(char *pOut, PQWORD pGet64)
	{
		int ccc= StrLength(MyTableForLogin);
		QWORD tmp64= (*pGet64) / (QWORD)ccc;
		*pOut= MyTableForLogin[(int)((*pGet64) % (QWORD)ccc)];
		while(tmp64){
			pOut++;
			*pOut= MyTableForLogin[(int)(tmp64 % (QWORD)ccc)];
			tmp64 /= (QWORD)ccc;
		}
		*pOut= 0;
	}
*/
	static void MyPrintfFromTable(char *pOut, PDWORD pGet32_L, PDWORD pGet32_H)
	{
		int ccc= StrLength(MyTableForLogin);
		DWORD tmp32= (*pGet32_L) / (DWORD)ccc;
		*pOut= MyTableForLogin[(int)((*pGet32_L) % (DWORD)ccc)];
		while(tmp32){
			pOut++;
			*pOut= MyTableForLogin[(int)(tmp32 % (DWORD)ccc)];
			tmp32 /= (DWORD)ccc;
		}
		tmp32= (*pGet32_H) / (DWORD)ccc;
		*pOut= MyTableForLogin[(int)((*pGet32_H) % (DWORD)ccc)];
		while(tmp32){
			pOut++;
			*pOut= MyTableForLogin[(int)(tmp32 % (DWORD)ccc)];
			tmp32 /= (DWORD)ccc;
		}
		*pOut= 0;
	}
#endif

#ifdef RD_AS_ETALON
void Hash(void *pStream)
{
	static char Msk[]= "Псефдо X";
	PDWORD pDW= (PDWORD)Msk;
	((PDWORD)pStream)[0] ^= pDW[0];
	((PDWORD)pStream)[1] ^= pDW[1];
	return;
}
void pl_HashEx(void *Result)
{
	BYTE tmp0[PSSWRD_SIZE_PER_BYTES+PSSWRD_SIZE_PER_BYTES];
	PBYTE pBytes= (PBYTE)tmp0;
	int ii;

	MemCopy(tmp0, Result, PSSWRD_SIZE_PER_BYTES);

	for(ii = 0; ii < PSSWRD_SIZE_PER_BYTES;
						ii+= sizeof(DWORD)*SIZE_SYNHRO_PER_DWORD,
						pBytes += sizeof(DWORD)*SIZE_SYNHRO_PER_DWORD)
		Hash(pBytes);

	MemCopy(Result,tmp0,PSSWRD_SIZE_PER_BYTES);
}
#else
void Hash(PDWORD pRet)
{
	long	szB=-1, szTbl= HASH_TBL_SIZE, left= sizeof(DWORD)*8, all= left * 2,
			next=0, synchro= 26;
	DWORD mask, first, *pNxt= pRet, tt, ttt, splitted;
	unsigned char *pcNxt= (unsigned char *)(pRet+2);
	while(szTbl){
		szTbl /= 2;
		szB++;
	}
	for(first= *pNxt; ((pRet+2) - pNxt) > 0 ; next= szB - (left - next)){
		// Набераем "мешочек" из значений хеш-таблицы (synchro - предыдущий шумок)
		while(left > (next+szB)){
			tt= (first >> next) & (HASH_TBL_SIZE-1);
			mask= hash_tbl[tt] ^ synchro;
			synchro = tt;
			first ^= mask << next;
			next+= szB;
		}
		splitted = first >> next;
		ttt= left % szB;
		if(((pRet+1) - pNxt) > 0){
			splitted |= (pNxt[1] & ((HASH_TBL_SIZE-1) >> ttt)) << ttt;
		}
		tt= splitted & (HASH_TBL_SIZE-1);
		mask= hash_tbl[tt] ^ synchro;
		synchro = tt;
		splitted ^= mask;
		*pNxt= (first & (((DWORD)-1) >> ttt)) | (splitted << (DWORD)next);
		pNxt++;
		first &= splitted >> ttt;
	}
	mask= 0;
	do{
		// псевдо - иммито
		mask ^= *(--pcNxt);
	}while((PDWORD)pcNxt != pRet);
	mask %= 8;
	do{
		// сдвигаем на иммито
		tt= *(--pNxt) << mask;
		*pNxt >>= left - mask;
		*pNxt |= tt;
	}while(pNxt != pRet);
}
void HashDWORD(PDWORD pRet)
{
	DWORD tmpHash[2];
	tmpHash[0]= *pRet;
	tmpHash[1]= *pRet;
	Hash(tmpHash);
	tmpHash[0] ^= tmpHash[1];
	*pRet= *tmpHash;
}
void pl_HashEx(void *Result)
{
	PBYTE pBytes= (PBYTE)Result;
	int ii;

	for(ii = 0; ii < PSSWRD_SIZE_PER_BYTES;
						ii+= sizeof(DWORD)*SIZE_SYNHRO_PER_DWORD,
						pBytes += sizeof(DWORD)*SIZE_SYNHRO_PER_DWORD)
		Hash((unsigned long*)pBytes);
}
#endif

void LoadCryptoKey(char *pKey, HANDLE hWnd)
{
	MemCopy(Crypto_TAG, pKey, sizeof(DWORD) * SIZE_CRYPTO_KYE_PER_DWORD);
	Hash(Crypto_TAG);
	pCryptoKey= Crypto_TAG;
	return;
}

void LoadCryptoKeyFromStr(char *pKey, HANDLE hWnd)
{
	int Pos= (int)((pKey[StrLength(pKey)-1] - 0x41) & 0x7), ii= 0;
	char *pOut= (char*)Crypto_TAG;
	while(ii < Pos){
		*pOut++ = pKey[ii] ^ pKey[ii + sizeof(DWORD) * SIZE_CRYPTO_KYE_PER_DWORD];
		ii++;
	}
	ii= sizeof(DWORD) * SIZE_CRYPTO_KYE_PER_DWORD;
	while(ii-- > Pos){
		*pOut++ = pKey[ii] ^ pKey[ii + sizeof(DWORD) * SIZE_CRYPTO_KYE_PER_DWORD];
	}
	Hash(Crypto_TAG);
	pCryptoKey= Crypto_TAG;
	return;
}

void UnLoadCryptoKey(DWORD *pRet, HANDLE hWnd)
{
	pCryptoKey= 0;
	pRet[0]= 0;
	return;
}

DWORD CryptoTick()
{
	return QUICK_RAND(m_RandSeed);
}

int NextSynchro()
{
	/*
		Для версии 7.7, как и в версии 7.6, для НЕ Windows платформ,
		мультипоточный ГСЧ выключаем - убираем GARANT_MPCXC.

		история:
			Многопоточная генерация ГСЧ, как и прежде, не уверенно работала под фришкой,
			и была закрыта "заплаткой", Григорий, на радостях виндовые функции перекрыл
			ace-вскими и включил оную генерацию...
			Вот Мы и накушались...

			"Неуверенно" в том смысле, что не всегда срабатывает многопоточный
				ГСЧ, чего-то там со стеком...
	*/
#ifndef __WIN16__
	static DWORD firstNextSynchro= true; 
	DWORD	ii=0
#ifndef _PLDEBUG
		, sz
#endif
		; // real returned value from rand() = 16 bits;
#ifdef _REPEAT_CICLE
	int qq= 10;
#endif

	LPVOID lpMsgBuf= 0;

	if(!firstNextSynchro){
		// printf("\n First synchro... ");
		pSynhro[1] ^= CryptoTick();
		pSynhro[0] ^= CryptoTick();
	}else{
		firstNextSynchro= ii; 
#ifdef _PLDEBUG
		pSynhro[0] = 0xf1f2f3f4;
		pSynhro[1] = 0x1f2f3f4f;
#else
		/* Seed the random-number generator with current time so that
		* the numbers will be different every time we run.
		*/
#if defined(BRDR32)
		srand( (unsigned)time( 0 ) );
#endif
		// real returned value from Timer Ticker = 8 bits;
		sz= SIZE_SYNHRO_PER_DWORD*sizeof(DWORD);

		{
			m_Tick= 0;
#ifdef WIN32
			ACE_OS::mutex_init (tick_mutex_stop);
			tick_mutex_val = false;
			int res = ACE_OS::thr_create (
				tickProc
				, &m_Tick
				, THR_NEW_LWP | THR_JOINABLE
				, &m_ThreadID
				, &m_ThreadHandle
				, ACE_DEFAULT_THREAD_PRIORITY
				, 0
				, 1024*1024
				);
			if(res < 0){
/*				FormatMessage(	FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
								0,
								GetLastError(),
								MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
								(LPTSTR) &lpMsgBuf,    0,    0 );
				MessageBox( 0, (char*)lpMsgBuf, "CreateThread - Error:",
							MB_OK|MB_ICONERROR );
				LocalFree( lpMsgBuf );*/
				ACE_OS::mutex_destroy (tick_mutex_stop);
				return -1;
			}
			//SetThreadPriority(hTickThread,THREAD_PRIORITY_NORMAL); // THREAD_PRIORITY_HIGHEST
#endif
	#ifdef _REPEAT_CICLE
		while(qq--){
	#endif
			for(ii= 0; ii < sz; ii++ ){
				if(ii){
					//printf("\r... Random Ticker : [x%8x,%8x]",pSynhro[1], pSynhro[0]);
					ace_os_sleep(((BYTE*)pSynhro)[ii-1]*5);
				}else if(!firstNextSynchro){
					pSynhro[1]= pSynhro[0]= 0;
					//printf("\r... Random Ticker : [x        ,        ]");
					//firstNextSynchro= true;
#ifdef BRDR32
					ace_os_sleep(rand()%8096);
					((PWORD)&m_Tick)[0]= (WORD)rand();
					((PWORD)&m_Tick)[1]= (WORD)rand();
#else
					ace_os_sleep(453678972%8096);
#endif
				}else{
					//printf("\r... Random Ticker : [x        ,        ]");
					pSynhro[1]= pSynhro[0]= 0;
					ace_os_sleep(((BYTE*)pSynhro)[ii]*5);
				}
				((BYTE*)pSynhro)[ii] = (BYTE)(m_Tick & 0xFF);
	#ifdef _REPEAT_CICLE
		}
	#endif
			//printf("\rEnd Random Ticker : [x%8x,%8x]\n",pSynhro[1], pSynhro[0]);
			}
#ifdef WIN32
			ACE_OS::mutex_lock (tick_mutex_stop);
			tick_mutex_val = true;
			ACE_OS::mutex_unlock (tick_mutex_stop);
			ACE_THR_FUNC_RETURN status = 0;
			ACE_OS::thr_join (m_ThreadHandle, &status);
			ACE_OS::mutex_destroy (tick_mutex_stop);
//			if(res2 < 0){
/*				FormatMessage(	FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
								0,
								GetLastError(),
								MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
								(LPTSTR) &lpMsgBuf,    0,    0 );
				MessageBox( 0, (char*)lpMsgBuf, "TerminateThread - Error:",
							MB_OK|MB_ICONERROR );
				LocalFree( lpMsgBuf );*/
//			}
#endif
		}
#endif
	}
#endif
	return 0;
}

#ifndef RD_AS_ETALON
int _InitHash()
{
	if(hash_tbl)
		return 0;
	hash_tbl= (PDWORD)alloc_in_heap(HASH_TBL_SIZE*sizeof(DWORD));
	if(hash_tbl != 0){
		int sz_h= HASH_TBL_SIZE, pos, iter= 0;
		DWORD tmp;
		MemSeting(hash_tbl, 0, HASH_TBL_SIZE*sizeof(DWORD));
		while(sz_h--)
			// Заполним порядковыми с нуля
			hash_tbl[sz_h] = sz_h;
		sz_h= HASH_TBL_SIZE;
		while(sz_h--){
			// Взбалтаем случайно
			pos= ((((PDWORD)glb_uz)[sz_h])>>6)%(HASH_TBL_SIZE-iter);
			tmp= hash_tbl[HASH_TBL_SIZE-iter-1];
			hash_tbl[HASH_TBL_SIZE-iter-1]= hash_tbl[pos];
			hash_tbl[pos]= tmp;
			iter++;
		}
	}else
		return -5;

	return 0;
}
#endif

static int __stdcall pl_InitSynhro()
{
	static int FirstInitSynhro= 1;
	int ret= 0;

	if(!FirstInitSynhro)
		return 0;

	FirstInitSynhro= 0;

	ret = 
		// Generate first best random-number //
		NextSynchro();

	if(ret){
		//MessageBox( hWnd, "Error...", "InitCrypto32", MB_ICONSTOP|MB_OK);
		return ret;
	}
	// Hide first little synchro //
	ret= ((BYTE*)pSynhro)[3];
	while(ret--)
		CryptoTick();

	return 0;
}

int __stdcall pl_InitCrypto(HANDLE hWnd)
{
#ifdef WIN32
//	call_hWnd= (HWND)hWnd;
#endif
#if !defined(RD_AS_ETALON) && !defined(BRDR32)
	if(_InitHash())
		return -5;
#endif
#if !defined(RD_AS_ETALON)&& defined(WIN32) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
	AllocSERVICES= 222;
	pSERVICES= (LPPL_UDDB_SERVICES)alloc_in_heap(
							AllocSERVICES*sizeof(PL_UDDB_SERVICES));
	if(pSERVICES == 0){
		return -5;
	}
	MemSeting(pSERVICES, 0, AllocSERVICES * sizeof(PL_UDDB_SERVICES));
#endif
#if !defined(RD_AS_ETALON)&& (defined(BRDR32) || defined(MAKE_HDD))
	pl_InitSynhro();
#endif
	return 0;
}
void __stdcall pl_DoneCrypto(HANDLE hWnd)
{
	DWORD Ret;
#ifndef RD_AS_ETALON
	if(hash_tbl){
		free_in_heap(hash_tbl);
		hash_tbl= 0;
	}
#endif
	UnLoadCryptoKey( &Ret, hWnd);
#if !defined(RD_AS_ETALON)&& defined(WIN32) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
	CountSERVICES= AllocSERVICES= 0;
	if(pSERVICES != 0){
		free_in_heap(pSERVICES);
		pSERVICES= 0;
	}
#endif
#if defined(WIN32) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
	if (handle2GLink != 0) {
		FreeLibrary(handle2GLink);
		handle2GLink= 0;
		imp_HaspAllocComplect= 0;
		imp_HaspGetMediaId= 0;
		imp_HaspAddTry= 0;
		imp_HaspAddSuccess= 0;
		#ifdef TEST_MAKE_HDD
			imp_HaspClearStat= 0;
		#endif
	}
#endif
	//if(Ret)
	//	assert(hWnd);
}

char* __stdcall	pl_GetLastError(int iErrorCode)
{
	static char *pListErrorStrings[]= {
		"аллоцирования в ключе",
		"ввода-вывода",
		"Записи в файл",
		"создания файла",
		"открытия файла",
		"нет свободного ОЗУ",
		"чтения файла",
		"загрузки Dongle.dll",
		"импорта функции из Dongle.dll",
		"UIDDB - пуста",
		"плохая сигнатура блока 0",
		"UIDDB - плоха",
		"неверный пароль инициатора",
		"плохая сигнатура блока 2",
		"неверный логин в блоке 2",
		"длина ключа шифрования или шифруемый блок короче 64 бит",
		"шифрования",
		"выгрузки ключа шифрования",
		"в файле мулти-лицензий нет лицензии для указанного СО",
		"неверный логин ТУ в блоке 0",
		"плохой NDT файл в ППД",
		"инициатор или получатель неопределены в UIDDB",
		"запрещён переход от инициатора к получателю",
		"плохая сигнатура блока 1",
		"плохой тип инсталляции в блоке 1",
		"плохое описание РД",
		"плохой тип транспорта в блоке 1",
		"запрещён переход от инициатора к получателю в указанном наборе сегментов",
		"плохой Логин комплекта",
		"отсуствует сегментное наполнение для одного из ТУ",
		"колл-во заказов в Блок 0 меньше одного",
		"неверное колл-во Блоков 2 после Блока 1",
		"неверно указан логин СО в Блок 0",
		"отсутствуют сегмент(ы) в Блоков 2",
		"превышено максимальное кол-во Блоков 2",
		"размещения заказов на неименнованном носителе",
		"плохой Логин ППД"
	};
	static char unError[]= "неизвестная";
	static int pListErrorCodes[]= {
		900,
		-1,
		-2,
		-3,
		-4,
		-5,
		-6,
		-76,
		-77,
		-8,
		-9,
		-449,
		-559,
		-15,
		-14,
		-47,
		-48,
		-49,
		-989,
		-17,
		-16,
		-116,
		-117,
		-115,
		-125,
		-126,
		-127,
		-95,
		-669,
		-670,
		-671,
		-672,
		-673,
		-674,
		-675,
		-676,
		-677
	};
	int ii= sizeof(pListErrorCodes)/sizeof(*pListErrorCodes);
	while(ii--){
		if(iErrorCode == pListErrorCodes[ii])
			break;
	}
	if(ii != -1)
		return pListErrorStrings[ii];
	return unError;
}
void EnCryptoPost( char *pStr, DWORD *pCount )
{
#ifndef RD_AS_ETALON
	char *dest= pStr, *src= pStr;

	DWORD	preTick, retTick, szCryptoTick= sizeof(DWORD)-1, ii, rr,
			sz= pCount[0]/2, lst= pCount[0]%szCryptoTick;

	if(pCryptoKey == 0 || pl_InitSynhro()){
		pCount[0]= 1;
		return;
	}
	preTick= m_RandSeed;
	if(pCount[0] < SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)){
		pCount[0]= 2;
		return;
	}
	for(ii=0; ii < sz; ii++){
		src[*pCount]= src[ii];
		src[ii]= src[ii+sz];
		src[ii+sz]= src[*pCount];
	}
	for(ii=0, sz= pCount[0]/szCryptoTick; ii < sz; ii++){
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[4] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[5] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[7] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
	switch(lst){
	case 1:
	{
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
		break;
	case 2:
	{
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[4] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[7] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
		break;
	default:
		break;
	}
	dest += pCount[0];

	ii = pSynhro[0] ^ pCryptoKey[1];
	MemCopy(dest, &ii, sizeof(DWORD));	dest += sizeof(DWORD);

	ii = pSynhro[1] ^ pCryptoKey[0];
	MemCopy(dest, &ii, sizeof(DWORD));	dest += sizeof(DWORD);

	ii = preTick ^ *((DWORD*)(((char *)pCryptoKey)+sizeof(DWORD)/2));
	MemCopy(dest, &ii, sizeof(DWORD));

	if((ii= NextSynchro())){
		pCount[0] = ii;
		return;
	}
	pCount[0] += SIZE_CRYPTO_HEADER;
#endif
	return;
}

#if defined(BRDR32) || defined(MAKE_HDD)
void EnCrypto( char *pStr, DWORD *pCount )
{
	char *dest= pStr, *src= pStr;

	DWORD	preTick, retTick, szCryptoTick= sizeof(DWORD)-1, ii, rr,
			sz= pCount[0]/2, lst= pCount[0]%szCryptoTick;



	if(pCryptoKey == 0  || pl_InitSynhro()){
		pCount[0]= 1;
		return;
	}
	preTick= m_RandSeed;
	if(pCount[0] < SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)){
		pCount[0]= 2;
		return;
	}
	for(ii=0; ii < sz; ii++){
		src[*pCount]= src[ii];
		src[ii]= src[ii+sz];
		src[ii+sz]= src[*pCount];
	}
	for(ii=0, sz= pCount[0]/szCryptoTick; ii < sz; ii++){
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[4] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[5] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[7] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
	switch(lst){
	case 1:
	{
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
		break;
	case 2:
	{
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[4] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[7] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
		break;
	default:
		break;
	}
	dest += pCount[0];

	ii = pSynhro[0] ^ pCryptoKey[1];
	MemCopy(dest, &ii, sizeof(DWORD));	dest += sizeof(DWORD);

	ii = pSynhro[1] ^ pCryptoKey[0];
	MemCopy(dest, &ii, sizeof(DWORD));	dest += sizeof(DWORD);

	ii = preTick ^ *((DWORD*)(((char *)pCryptoKey)+sizeof(DWORD)/2));
	MemCopy(dest, &ii, sizeof(DWORD));

	if((ii= NextSynchro())){
		pCount[0] = ii;
		return;
	}
	pCount[0] += SIZE_CRYPTO_HEADER;
	return;
}

void UnCrypto( char *pStr, DWORD *pCount )
{
	char *dest= pStr, *src= pStr;

	DWORD	preTick= m_RandSeed, retTick, pPreSyncro[SIZE_SYNHRO_PER_DWORD],
			szCryptoTick= sizeof(DWORD)-1, ii= pCount[0]-SIZE_CRYPTO_HEADER, rr,
			sz= ii/szCryptoTick, lst= ii%szCryptoTick;

	if(pCryptoKey == 0){
		pCount[0]= 1;
		return;
	}
	if(ii < SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)){
		pCount[0]= 2;
		return;
	}
	MemCopy(pPreSyncro, pSynhro, sizeof(DWORD)*SIZE_SYNHRO_PER_DWORD);

	src += pCount[0] - sizeof(DWORD);
	MemCopy(&m_RandSeed, src, sizeof(DWORD));
	m_RandSeed ^= *((DWORD*)(((char *)pCryptoKey)+sizeof(DWORD)/2));

	src -= sizeof(DWORD);
	MemCopy(pSynhro+1, src, sizeof(DWORD));
	pSynhro[1] ^= pCryptoKey[0];

	src -= sizeof(DWORD);
	MemCopy(pSynhro, src, sizeof(DWORD));
	pSynhro[0] ^= pCryptoKey[1];

	src -= pCount[0] - SIZE_CRYPTO_HEADER;

	for(ii=0; ii < sz; ii++){
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[4] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[5] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[7] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
	switch(lst){
	case 1:
	{
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
		break;
	case 2:
	{
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[4] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[7] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
		break;
	default:
		break;
	}
	m_RandSeed= preTick;
	MemCopy(pSynhro, pPreSyncro, sizeof(DWORD)*SIZE_SYNHRO_PER_DWORD);
	//free_in_heap(pPreSyncro);
	//pPreSyncro= 0;
	pCount[0] -= SIZE_CRYPTO_HEADER;
	for(ii=0, sz= pCount[0]/2; ii < sz; ii++){
		dest[*pCount]= dest[ii];
		dest[ii]= dest[ii+sz];
		dest[ii+sz]= dest[*pCount];
	}
	return;
}
void UnCryptoPost( char *pStr, DWORD *pCount )
#else
void EnCrypto( char *pStr, DWORD *pCount )
{
	EnCryptoPost(pStr, pCount);
}
void UnCrypto( char *pStr, DWORD *pCount )
#endif
{
	char *dest= pStr, *src= pStr;

	DWORD	preTick= m_RandSeed, retTick, pPreSyncro[SIZE_SYNHRO_PER_DWORD],
			szCryptoTick= sizeof(DWORD)-1, ii= pCount[0]-SIZE_CRYPTO_HEADER, rr,
			sz= ii/szCryptoTick, lst= ii%szCryptoTick;

	if(pCryptoKey == 0){
		pCount[0]= 1;
		return;
	}
	if(ii < SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)){
		pCount[0]= 2;
		return;
	}
	MemCopy(pPreSyncro, pSynhro, sizeof(DWORD)*SIZE_SYNHRO_PER_DWORD);


	src += pCount[0] - sizeof(DWORD);
	MemCopy(&m_RandSeed, src, sizeof(DWORD));
	m_RandSeed ^= *((DWORD*)(((char *)pCryptoKey)+sizeof(DWORD)/2));

	src -= sizeof(DWORD);
	MemCopy(pSynhro+1, src, sizeof(DWORD));
	pSynhro[1] ^= pCryptoKey[0];

	src -= sizeof(DWORD);
	MemCopy(pSynhro, src, sizeof(DWORD));
	pSynhro[0] ^= pCryptoKey[1];

	src -= pCount[0] - SIZE_CRYPTO_HEADER;

	for(ii=0; ii < sz; ii++){
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[4] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[5] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[7] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
	switch(lst){
	case 1:
	{
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
		break;
	case 2:
	{
		retTick= CryptoTick();
		switch(szCryptoTick){
		case 3:
			{
				rr= ii % 4;
				switch(rr){
				case 0:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[0] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 1:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[3] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[4] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					break;
				case 2:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[6] ^ src[rr] ^ ((char*)&retTick)[2];rr++;
					dest[rr]= ((char*)pSynhro)[7] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				case 3:
					rr= ii*szCryptoTick;
					dest[rr]= ((char*)pSynhro)[1] ^ src[rr] ^ ((char*)&retTick)[1];rr++;
					dest[rr]= ((char*)pSynhro)[2] ^ src[rr] ^ ((char*)&retTick)[0];rr++;
					break;
				}
			}
		default:
			break;
		}
	}
		break;
	default:
		break;
	}
	m_RandSeed= preTick;
	MemCopy(pSynhro, pPreSyncro, sizeof(DWORD)*SIZE_SYNHRO_PER_DWORD);
	//free_in_heap(pPreSyncro);
	//pPreSyncro= 0;
	pCount[0] -= SIZE_CRYPTO_HEADER;
	for(ii=0, sz= pCount[0]/2; ii < sz; ii++){
		dest[*pCount]= dest[ii];
		dest[ii]= dest[ii+sz];
		dest[ii+sz]= dest[*pCount];
	}
	return;
}
int __stdcall pl_GetCryptoHeader()
{
	return SIZE_CRYPTO_HEADER;
}

int __stdcall EnCryptoMem(	void *pMemBlock,	int iSizeMemBlock,
							void *pKey,			int iSizeKey)
{
	DWORD tmp= (DWORD)iSizeMemBlock;
	if(	iSizeMemBlock < SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD) ||
		iSizeKey < SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD))
		return -47;

	LoadCryptoKey((char*)pKey, 0);
	EnCrypto((char*)pMemBlock, &tmp);
	if(tmp - (DWORD)pl_GetCryptoHeader() != (DWORD)iSizeMemBlock)
		return -48;
	UnLoadCryptoKey((PDWORD)&iSizeMemBlock, 0);
	if(iSizeMemBlock)
		return -49;

	return (int)tmp;
}
int __stdcall UnCryptoMem(	void *pMemBlock,	int iSizeMemBlock,
							void *pKey,			int iSizeKey)
{
	DWORD tmp= (DWORD)iSizeMemBlock;
	if(iSizeMemBlock  < SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD) ||
		iSizeKey < SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD))
		return -47;

	LoadCryptoKey((char*)pKey, 0);
	UnCrypto((char*)pMemBlock, &tmp);
	if(tmp + (DWORD)pl_GetCryptoHeader() != (DWORD)iSizeMemBlock)
		return -48;
	UnLoadCryptoKey((PDWORD)&iSizeMemBlock, 0);
	if(iSizeMemBlock)
		return -49;
	MemSeting((char*)pMemBlock+tmp, 0, pl_GetCryptoHeader());
	return (int)tmp;
}
//#endif
// ============================================================================= //
#if defined(BRDR32) || defined(MAKE_HDD) || defined(INSTLL_CIB)
// ============================================================================= //

#include "pagefile.h"
static	const char newExtens[]="01111112333456789QWERTYUIOPA-_'~DFGHJLZXCVBM1234566678888889";

	int	_PutAttr (	short PageSize, char *SystemPageBuf, const char * name, void * buf, int size )
	{
		int	len = (int)(strlen( name )&0x7fffffff), Offs, tmpLen;
		for(Offs=0; Offs<PageSize && SystemPageBuf[Offs]!='\0'; Offs+=SystemPageBuf[Offs]){
			tmpLen= (int)(strlen(SystemPageBuf+Offs+1)&0x7fffffff);
			if (tmpLen == len && !memcmp(SystemPageBuf+Offs+1, name, len))	// attrs found
			{
				if(memcpy(SystemPageBuf+Offs+2+len, buf, SystemPageBuf[Offs]-len-2)){
					memcpy(SystemPageBuf+Offs+2+len, buf, SystemPageBuf[Offs]-len-2);
				}
				return 1;
			}
		}
		if ( Offs + len + 2 + size >= PageSize )
			return 0;

		SystemPageBuf[Offs] = (1+len+size) + 1;

		memcpy(SystemPageBuf+Offs+1, name, len+1);
		memcpy(SystemPageBuf+Offs+1+len+1, buf, size);
		SystemPageBuf[Offs+1+len+1+size]= 0;

		return 1;
	}
	char *GetBasedExtFileName( char *pFileName, int indx )
	{
		int len;
		if(pFileName == 0 || MAX_COUNT_FILE_HANDLES <= indx 
									|| (len=(int)(strlen(pFileName)&0x7fffffff)+1) < 2)
			return 0;

		if(pFileName[len-4] == 'n'){
			pFileName[len-3]= 'd';
			pFileName[len-2]= 't';
		}else if(	pFileName[len-4] == 'k'
					|| pFileName[len-4] == newExtens[0]
					|| pFileName[len-4] == newExtens[1]
					|| pFileName[len-4] == newExtens[2]
					|| pFileName[len-4] == newExtens[3]){
			pFileName[len-3]= 'e';
			pFileName[len-2]= 'y';
		}else  if(pFileName[len-4] == 's'
					|| pFileName[len-4] == newExtens[(sizeof(newExtens)/sizeof(*newExtens))-2]
					|| pFileName[len-4] == newExtens[(sizeof(newExtens)/sizeof(*newExtens))-3]
					|| pFileName[len-4] == newExtens[(sizeof(newExtens)/sizeof(*newExtens))-4]
					|| pFileName[len-4] == newExtens[(sizeof(newExtens)/sizeof(*newExtens))-5]){
			pFileName[len-3]= 't';
			pFileName[len-2]= 'r';
		}
		if(indx == 0){
			return pFileName;
		}
		indx--;
		if(indx < 10){
			pFileName[len-2]= '0'+ (char)indx;
		}else if(indx < 10+26){
			pFileName[len-2]= 'A'+ (char)indx - 10;
			if(pFileName[len-2] == 'R')
				pFileName[len-2]= '[';
			else if(pFileName[len-2] == 'T')
				pFileName[len-2]= '_';
			else if(pFileName[len-2] == 'Y')
				pFileName[len-2]= ']';
		}else if(indx < 10+26+10){
			pFileName[len-2]= 'Z';
			pFileName[len-3]= '0'+ (char)indx - 10-26;
		}else{
			pFileName[len-2]= 'Z';
			if(indx < 49)
				pFileName[len-3]= 'A'+ (char)indx - 10-26-10;
			else{
				pFileName[len-3]= ('A'+ (char)indx - 10-27-10)- ((indx-49)/24)*24;
				pFileName[len-2]= ('A'+ (char)49 - 10-27-10)+(indx-49)/24;
				if(pFileName[len-3] == 'T')
					pFileName[len-3]= '_';
				if(pFileName[len-3] == 'D')
					pFileName[len-3]= '-';
				if(pFileName[len-3] == 'E')
					pFileName[len-3]= '\'';
			}

		}
		for (int i = len - 4; i < len - 1; i++)
			if (pFileName [i] >= 'A' && pFileName [i] <= 'Z')
				pFileName [i] += 'a' - 'A';
		return pFileName;
	}

#if defined(PL_REPLCTR_FUNC) || defined(INSTLL_CIB) || defined(BRDR32)
/*#ifndef MAKE_HDD // версия для С объектника
int	_PutAttr (	short PageSize, char *SystemPageBuf, const char * name, void * buf, int size )
{
	int	len = StrLength( name ), Offs, tmpLen;
	for(Offs=0; Offs<PageSize && SystemPageBuf[Offs]!='\0'; Offs+=SystemPageBuf[Offs]){
		tmpLen= StrLength(SystemPageBuf+Offs+1);
		if (tmpLen == len && !MemComp(SystemPageBuf+Offs+1, name, len))	// attrs found
		{
			if(MemComp(SystemPageBuf+Offs+2+len, buf, SystemPageBuf[Offs]-len-2)){
				MemCopy(SystemPageBuf+Offs+2+len, buf, SystemPageBuf[Offs]-len-2);
			}
			return 1;
		}
	}
	if ( Offs + len + 2 + size >= PageSize )
		return 0;

	SystemPageBuf[Offs] = (1+len+size) + 1;

	MemCopy(SystemPageBuf+Offs+1, name, len+1);
	MemCopy(SystemPageBuf+Offs+1+len+1, buf, size);
	SystemPageBuf[Offs+1+len+1+size]= 0;

	return 1;
}
#endif*/

#if defined(MULTI_INDEX_STREAM_FILE) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
size_t strlen_Win32( const char *pOut )
{
	char *pbOut= (char *)pOut;

	while(1)
	{
		if( *pbOut == (char)'\0' )
			break;
		pbOut++;
	}
	return ((size_t)pbOut - (size_t)pOut);
}

char *strrchr_Win32( const char *pOut, int c )
{
	char *pLast= (char*)pOut + strlen_Win32(pOut);
	do{
		pLast--;
		if(*pLast == (char)c)
			return pLast;
	}while(pOut != pLast);

	return NULL;
}
#endif

	void impModifyName(char *pModify)
	{
	static const char *extIndex[]= { "Aux", "Attrs", "SubName", "CalIn", "CalAb", "CalCh", "Tag", "Context", "NContxt", "NWCntxt", "SWords", "NBCntxt", "NFContxt", "NCntxts", "" };

		char *pExt= 
#if defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
					strrchr_Win32
#else
					strrchr
#endif
							(pModify, '.')+1, *pFnd= pExt-3, **pNxt= (char**)extIndex;
		while(*pFnd != '.' && *pFnd != '\\'
				&& *pFnd != '/' && pFnd > pModify) pFnd--;
		if(*pFnd != '.')
			return;
		pFnd++;
		while(
#if defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
				memcmp
#else
				memcmp
#endif
					(pFnd, *pNxt, 
#if defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
									strlen
#else
									strlen
#endif
											(*pNxt)))
				pNxt++;
		if(*pExt == 'k'){
			*pFnd= newExtens[((char*)pNxt-(char*)(char**)extIndex)/sizeof(char*)];
		}else{
			*pFnd= newExtens[((sizeof(newExtens)/sizeof(*newExtens))-2)-(((char*)pNxt-(char*)(char**)extIndex)/sizeof(char*))];
		}
		*(pFnd+1)= *(pExt+1);
		*(pFnd+2)= *(pExt+2);
		*(pFnd+3)= 0;
	}
/*#ifndef MAKE_HDD // версия для С объектника
char *GetBasedExtFileName( char *pFileName, int indx )
{
	int len;
	if(pFileName == 0 || MAX_COUNT_FILE_HANDLES <= indx 
								|| (len=StrLength(pFileName)+1) < 2)
		return 0;

	if(pFileName[len-4] == 'n'){
		pFileName[len-3]= 'd';
		pFileName[len-2]= 't';
	}else if(pFileName[len-4] == 'k'
#ifdef MULTI_INDEX_STREAM_FILE
		|| pFileName[len-4] == newExtens[0]
		|| pFileName[len-4] == newExtens[1]
		|| pFileName[len-4] == newExtens[2]
		|| pFileName[len-4] == newExtens[3]
#endif
		){
		pFileName[len-3]= 'e';
		pFileName[len-2]= 'y';
	}else  if(pFileName[len-4] == 's'
#ifdef MULTI_INDEX_STREAM_FILE
		|| pFileName[len-4] == newExtens[(sizeof(newExtens)/sizeof(*newExtens))-2]
		|| pFileName[len-4] == newExtens[(sizeof(newExtens)/sizeof(*newExtens))-3]
		|| pFileName[len-4] == newExtens[(sizeof(newExtens)/sizeof(*newExtens))-4]
		|| pFileName[len-4] == newExtens[(sizeof(newExtens)/sizeof(*newExtens))-5]
#endif
		){
		pFileName[len-3]= 't';
		pFileName[len-2]= 'r';
	}
	if(indx == 0){
		return pFileName;
	}
	indx--;
	if(indx < 10){
		pFileName[len-2]= '0'+ (char)indx;
	}else if(indx < 10+26){
		pFileName[len-2]= 'A'+ (char)indx - 10;
		if(pFileName[len-2] == 'R')
			pFileName[len-2]= '[';
		else if(pFileName[len-2] == 'T')
			pFileName[len-2]= '_';
		else if(pFileName[len-2] == 'Y')
			pFileName[len-2]= ']';
	}else if(indx < 10+26+10){
		pFileName[len-2]= 'Z';
		pFileName[len-3]= '0'+ (char)indx - 10-26;
	}else{
		pFileName[len-2]= 'Z';
		if(indx < 49)
			pFileName[len-3]= 'A'+ (char)indx - 10-26-10;
		else{
			pFileName[len-3]= ('A'+ (char)indx - 10-27-10)- ((indx-49)/24)*24;
			pFileName[len-2]= ('A'+ (char)49 - 10-27-10)+(indx-49)/24;
			if(pFileName[len-3] == 'T')
				pFileName[len-3]= '_';
			if(pFileName[len-3] == 'D')
				pFileName[len-3]= '-';
			if(pFileName[len-3] == 'E')
				pFileName[len-3]= '\'';
		}

	}
	return pFileName;
}
#endif*/

#ifdef BRDR32
int pl_MakeLoginForBase(char *NullPage, char *pCrptInfo, PDWORD pKey)
{
	memcpy(strcpy(NullPage + 512 - pl_GetLoginOffest() - 8, pCrptInfo) + 8
			+ LOGIN_SIZE_PER_BYTES + 1, pKey, sizeof(DWORD) * SIZE_CRYPTO_KYE_PER_DWORD);
	return 0;
}
#endif

void pl_GetLoginFromBase(char **pLogin, char *NullPage, int PageSize)
{
	if(PageSize == 512)
		*pLogin= NullPage+PageSize - pl_GetLoginOffest();
}

int __stdcall pl_FreeFileList(LPPL_BASE_FILE_LIST pList)
{
	LPPL_BASE_FILE_LIST pNext= pList, pPre= 0;

	if(pNext != 0){
		do{
			free_in_heap(pNext->pFileName);
			pNext->pFileName= (char*)pPre;
			pPre= pNext;
		}while((pNext= (LPPL_BASE_FILE_LIST)pNext->pNext) != 0);

		do{
			pNext= (LPPL_BASE_FILE_LIST)pPre->pFileName;
			free_in_heap(pPre);
		}while((pPre= pNext) != 0);
	}

	return 0;
}

static char *ppLst[]={".key", ".0ey", ".1ey", ".2ey", ".3ey", ".4ey", ".5ey", "", ".9tr", ".8tr", ".7tr", ".6tr", ".5tr", ".4tr", ""};

char *memstrchr( void *pOut, char *pstr, int size )
{
	int nxt=0, len= (int)(StrLength(pstr)&0x7fffffff);
	char *pFnd;

	while((pFnd= (char*)memchr( (char*)pOut+nxt, *pstr, size-nxt ))){
		nxt = ((int)((pFnd - (char*)pOut)&0x7fffffff)) + 1;
		if(!memcmp(pFnd, pstr, len)){
			return pFnd;
		}
	}
	return 0;
}

int CheckInfoPagedFile(int ikey, PF_PARAM *ptmp)
{
	char *pFnd= memstrchr(ptmp->pHeader, ID_PACKED, ((struct PagedFileHeader *)ptmp->pHeader)->PageSize);
	ptmp->page= ((struct PagedFileHeader *)ptmp->pHeader)->LastPage;
	ptmp->PackArraySize= 0;
	if( pFnd != 0 && 0 != *(pFnd-1)){
		unsigned long maxPos;
		ptmp->PackArraySize=
			(((struct PagedFileHeader *)ptmp->pHeader)->LastPage + 1l) * sizeof(u_int32_t);
		if(	SetFilePos(ikey, -4, ACE_OS_SEEK_END) == -1 || 
			ReadFromFile(ikey, &maxPos, sizeof(long)) != sizeof(long)){
			return -6;
		}
		ptmp->page = (long)(maxPos / (unsigned long)(((struct PagedFileHeader *)ptmp->pHeader)->PageSize));
	}
	return 0;
}

int __stdcall pl_GetFileList(char *InputedBaseFileName, LPPL_BASE_FILE_LIST *ppList)
{
	PF_PARAM tmp;
	int sz, indt, istr, ikey, lst, ret= 0, count;
	char *ps, **ppNxt= ppLst;


	LPPL_BASE_FILE_LIST pList= 0, pNext= 0;
#ifdef MULTI_INDEX_STREAM_FILE
	LPPL_BASE_FILE_LIST pKeyNext;
	char *ppLstSkip[]={
   #ifndef __SIMPLE_LOCALES__
 				ppLst[3], ppLst[4], ppLst[5], ppLst[6], ppLst[10], ppLst[11], ppLst[12], ppLst[13], ppLst[7]
   #else
 	// ѓ ўс­­л© Є®¬ЇЁ«пв®а ®в Ѓ®а« ­¤®ў Їа®бЁа Ґв Ё­ЁжЁ«Ё§ жЁо !!!
 	// ЇаЁе®¤Ёвбп агзЄ ¬Ё § ў®¤Ёвм ў data Є®ЇЁЁ Є®­бв ­в  !!!
 
 				".2ey", ".3ey", ".4ey", ".5ey", ".7tr", ".6tr", ".5tr", ".4tr", ""
   #endif
 									}, *pKeyName;
#endif

	*ppList= 0;

	if((ps= (char*)alloc_in_heap((sz=(int)(StrLength(InputedBaseFileName)&0x7fffffff))+5+4096)) == 0){
		return -5;
	}
	MemCopy(ps, InputedBaseFileName, sz);
	MemCopy(ps+sz, ".ndt", 5);
	if((indt= CreateFileHandle( ps, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX S_IREAD unused
		ret= -4; goto Err;
	}
	if(	(pList= pNext= (LPPL_BASE_FILE_LIST)alloc_in_heap(sizeof(PL_BASE_FILE_LIST))) == 0
			||
		(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0){
		ret= -5; goto Err;
	}
	MemCopy(pNext->pFileName, ps, sz+5);

	MemCopy(ps+sz, ".str", 5);
	if((istr= CreateFileHandle( ps, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
		ret= -4; goto Err0;
	}
	if(	(pNext= (LPPL_BASE_FILE_LIST)(pNext->pNext= alloc_in_heap(sizeof(PL_BASE_FILE_LIST)))) == 0
			||
		(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0){
		ret= -5; goto Err1;
	}
	MemCopy(pNext->pFileName, ps, sz+5);

#ifdef MULTI_INDEX_STREAM_FILE
  do{
#endif
	  if (!strcmp (*ppNxt, ".4ey"))
		  continue;
	MemCopy(ps+sz, *ppNxt, 5);
	if((ikey= CreateFileHandle( ps, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
#ifdef MULTI_INDEX_STREAM_FILE
		ikey= 0;
		while(*ppLstSkip[ikey] &&
	#ifndef __SIMPLE_LOCALES__
									ppLstSkip[ikey] != *ppNxt
	#else
									MemComp(ppLstSkip[ikey],*ppNxt, 4)
	#endif
																		) ikey++;
		if(*ppLstSkip[ikey]){
			ikey= -1;
			continue;
		}
		ikey= -1;
#endif
		ret= -4; goto Err1;
	}

	if(	(pNext= (LPPL_BASE_FILE_LIST)(pNext->pNext= alloc_in_heap(sizeof(PL_BASE_FILE_LIST)))) == 0
			||
		(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0){
		ret= -5; goto Err2;
	}
	MemCopy(pNext->pFileName, ps, sz+5);
	pNext->pNext= 0;
	
	MemSeting(&tmp, 0, sizeof(PF_PARAM));
	if(ReadFromFile(ikey, ps+sz+5, 2048) != 2048 ||
		(*(long*)(ps+sz+5) != BASE_DATA_VERSION && *(long*)(ps+sz+5) != PL_HDD_SIGN)){
		ret= -6; goto Err2;
	}
	tmp.pHeader= ps+sz+5;
	if((ret= CheckInfoPagedFile(ikey, &tmp)))
		goto Err2;
	tmp.iPost= 0;
	tmp.FileName= ps;
	tmp.maxFile_per_bytes= MAX_BYTE_FILE_SIZE;

	if(((struct PagedFileHeader*)tmp.pHeader)->TomPerPages >= MAX_COUNT_FILE_HANDLES){
		tmp.maxFile_per_bytes=
			((struct PagedFileHeader*)tmp.pHeader)->TomPerPages * ((struct PagedFileHeader*)tmp.pHeader)->PageSize;
	}
	count= IsNextTom(&tmp);lst= 1;
	while(lst <= count){
		if(	GetBasedExtFileName(ps, lst) == 0
				||
			(pNext= (LPPL_BASE_FILE_LIST)(pNext->pNext= alloc_in_heap(sizeof(PL_BASE_FILE_LIST)))) == 0
				||
			(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0){
			ret= -5; goto Err2;
		}
		MemCopy(pNext->pFileName, ps, sz+5);
		MemCopy(ps+sz, *ppNxt, 5);
		lst++;
	}
#ifdef MULTI_INDEX_STREAM_FILE
	if(ikey != -1){
		CloseFileHandle(ikey);ikey= -1;
	}
  }while((*(++ppNxt))[0]);
#endif
	if(*(long*)(ps+sz+5) == PL_HDD_SIGN){
		if(	(pNext= (LPPL_BASE_FILE_LIST)(pNext->pNext= alloc_in_heap(sizeof(PL_BASE_FILE_LIST)))) == 0
				||
			(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0){
			ret= -5; goto Err;
		}
		MemCopy(ps+sz, ".uid", 5);
		MemCopy(pNext->pFileName, ps, sz+5);
		pNext->pNext= 0;
	}
#ifdef MULTI_INDEX_STREAM_FILE
	pKeyName= ((LPPL_BASE_FILE_LIST)((LPPL_BASE_FILE_LIST)pList->pNext)->pNext)->pFileName;
	((LPPL_BASE_FILE_LIST)((LPPL_BASE_FILE_LIST)pList->pNext)->pNext)->pFileName
			= pNext->pFileName;
	pNext->pFileName= pKeyName;
	pKeyNext= pNext;
	ppNxt= ppLst;
	while((*(++ppNxt))[0]);
	ppNxt++;
  do{
	  if (!strcmp (*ppNxt, ".5tr"))
		  continue;
	MemCopy(ps+sz, *ppNxt, 5);
	if((ikey= CreateFileHandle( ps, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
#ifdef MULTI_INDEX_STREAM_FILE
		ikey= 0;
		while(*ppLstSkip[ikey] &&
	#ifndef __SIMPLE_LOCALES__
									ppLstSkip[ikey] != *ppNxt
	#else
									MemComp(ppLstSkip[ikey],*ppNxt, 4)
	#endif
																		) ikey++;
		if(*ppLstSkip[ikey]){
			ikey= -1;
			continue;
		}
		ikey= -1;
#endif
		ret= -4; goto Err1;
	}
	if(	(pNext= (LPPL_BASE_FILE_LIST)(pNext->pNext= alloc_in_heap(sizeof(PL_BASE_FILE_LIST)))) == 0
			||
		(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0){
		ret= -5; goto Err2;
	}
	MemCopy(pNext->pFileName, ps, sz+5);
	if(ikey != -1){
		CloseFileHandle(ikey);ikey= -1;
	}
  }while((*(++ppNxt))[0]);
	pKeyNext->pFileName = pNext->pFileName;
	pNext->pFileName= pKeyName;
	ppNxt= ppLst;
	while((*(++ppNxt))[0]);
	ppNxt++;
  do{
	MemCopy(ps+sz, *ppNxt, 5);
	if((ikey= CreateFileHandle( ps, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
#ifdef MULTI_INDEX_STREAM_FILE
		ikey= 0;
		while(*ppLstSkip[ikey] &&
	#ifndef __SIMPLE_LOCALES__
									ppLstSkip[ikey] != *ppNxt
	#else
									MemComp(ppLstSkip[ikey],*ppNxt, 4)
	#endif
																		) ikey++;
		if(*ppLstSkip[ikey]){
			ikey= -1;
			continue;
		}
		ikey= -1;
#endif
		ret= -4; goto Err1;
	}
	MemSeting(&tmp, 0, sizeof(PF_PARAM));
	if(ReadFromFile(ikey, ps+sz+5, 4096) != 4096 ||
		(*(long*)(ps+sz+5) != BASE_DATA_VERSION && *(long*)(ps+sz+5) != PL_HDD_SIGN)){
		ret= -6; goto Err2;
	}
	tmp.pHeader= ps+sz+5;
	if((ret= CheckInfoPagedFile(ikey, &tmp)))
		goto Err2;
	tmp.iPost= 0;
	tmp.FileName= ps;
	tmp.maxFile_per_bytes= MAX_BYTE_FILE_SIZE;

	if(((struct PagedFileHeader*)tmp.pHeader)->TomPerPages >= MAX_COUNT_FILE_HANDLES){
		tmp.maxFile_per_bytes=
			((struct PagedFileHeader*)tmp.pHeader)->TomPerPages * ((struct PagedFileHeader*)tmp.pHeader)->PageSize;
	}
	count= IsNextTom(&tmp);lst= 1;
	while(lst <= count){
		if(	GetBasedExtFileName(ps, lst) == 0
				||
		(lst > 0 &&
			((pNext= (LPPL_BASE_FILE_LIST)(pNext->pNext= alloc_in_heap(sizeof(PL_BASE_FILE_LIST)))) == 0
				||
			(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0)
		)
			){
			ret= -5; goto Err2;
		}
		MemCopy(pNext->pFileName, ps, sz+5);
		MemCopy(ps+sz, *ppNxt, 5);
		lst++;
	}
	if(ikey != -1){
		CloseFileHandle(ikey);ikey= -1;
	}
  }while((*(++ppNxt))[0]);
#endif
	MemSeting(&tmp, 0, sizeof(PF_PARAM));
	if(ReadFromFile(istr, ps+sz+5, 4096) != 4096 ||
		(*(long*)(ps+sz+5) != BASE_DATA_VERSION && *(long*)(ps+sz+5) != PL_HDD_SIGN)){
		ret= -6; goto Err2;
	}
	MemCopy(ps+sz, ".str", 5);
	tmp.pHeader= ps+sz+5;
	if((ret= CheckInfoPagedFile(istr, &tmp)))
		goto Err2;
	tmp.FileName= ps;
	tmp.maxFile_per_bytes= MAX_BYTE_FILE_SIZE;

	if(((struct PagedFileHeader*)tmp.pHeader)->TomPerPages >= MAX_COUNT_FILE_HANDLES){
		tmp.maxFile_per_bytes=
			((struct PagedFileHeader*)tmp.pHeader)->TomPerPages * ((struct PagedFileHeader*)tmp.pHeader)->PageSize;
	}
	if((count= IsNextTom(&tmp))){
		lst= 1;
		while(lst <= count){
		if(	GetBasedExtFileName(ps, lst) == 0
				||
			(pNext= (LPPL_BASE_FILE_LIST)(pNext->pNext= alloc_in_heap(sizeof(PL_BASE_FILE_LIST)))) == 0
				||
			(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0){
			ret= -5; goto Err2;
		}
		MemCopy(pNext->pFileName, ps, sz+5);
		lst++;
	  }
	}
	MemSeting(&tmp, 0, sizeof(PF_PARAM));
	if(ReadFromFile(indt, ps+sz+5, 512) != 512 ||
		(*(long*)(ps+sz+5) != BASE_DATA_VERSION && *(long*)(ps+sz+5) != PL_HDD_SIGN)){
		ret= -6; goto Err2;
	}
	MemCopy(ps+sz, ".ndt", 5);
	tmp.pHeader= ps+sz+5;
	if((ret= CheckInfoPagedFile(indt, &tmp)))
		goto Err2;
	tmp.FileName= ps;
	tmp.maxFile_per_bytes= MAX_BYTE_FILE_SIZE;
	count= ((struct PagedFileHeader*)tmp.pHeader)->TomPerPages;

	if(!count){
		tmp.maxFile_per_bytes= MAX_BYTE_FILE_SIZE;
		count= IsNextTom(&tmp);
	}else if(count >= MAX_COUNT_FILE_HANDLES){
		tmp.maxFile_per_bytes=
		((struct PagedFileHeader*)tmp.pHeader)->TomPerPages * ((struct PagedFileHeader*)tmp.pHeader)->PageSize;
		count= IsNextTom(&tmp);
	}// else Logical count
	lst= 1;
	while(lst <= count){
		if(	GetBasedExtFileName(ps, lst) == 0
				||
			(pNext= (LPPL_BASE_FILE_LIST)(pNext->pNext= alloc_in_heap(sizeof(PL_BASE_FILE_LIST)))) == 0
				||
			(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0){
			ret= -5; goto Err2;
		}
		MemCopy(pNext->pFileName, ps, sz+5);
		lst++;
	}
	/*
	MemCopy(ps+sz, ".blb", 5);
	if((lst= CreateFileHandle( ps, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) != -1){ // GARANT_XXX
		CloseFileHandle(lst);
		if(	(pNext= (LPPL_BASE_FILE_LIST)(pNext->pNext= alloc_in_heap(sizeof(PL_BASE_FILE_LIST)))) == 0
				||
			(pNext->pFileName= (char*)alloc_in_heap(sz+5)) == 0){
			ret= -5; goto Err2;
		}
		MemCopy(pNext->pFileName, ps, sz+5);
	}
	*/
	//else
	//	ret= -4;
Err2:
	pNext->pNext= 0;
	if(ikey != -1)
		CloseFileHandle(ikey);
Err1:
	if(istr != -1)
		CloseFileHandle(istr);
Err0:
	CloseFileHandle(indt);
Err:
	free_in_heap(ps);

	if(!ret)
		*ppList= pList;
	else if(pList != 0)
		pl_FreeFileList(pList);
	return ret;
}


#endif

int __stdcall pl_FreeMemWithCryptoOrder(char *pMem)
{
	if(pMem == 0)
		return 0;
	free_in_heap(pMem);
	return 0;
}

int __stdcall pl_FreeMemWithReport(void *pMem)
{
	return pl_FreeMemWithCryptoOrder((char*)pMem);
}

int __stdcall pl_FreeMemWithAvancedInfo(char *pMem)
{
	return pl_FreeMemWithCryptoOrder(pMem);
}

#ifdef PL_REPLCTR_FUNC
	#ifdef MULTI_INDEX_STREAM_FILE
		int pl_ModifySignOnOtherFiles(char *, int);
	#endif
int gCopyPX_32Ex(char *RestoreFileName, char *BackupFileName)
{
	int i0, sz, indt, istr, ikey, ret= 0;
	char *ps, *bff;
	long sign= -0x54545454, szstr, szkey, readed;
	if((i0= CreateFileHandle( RestoreFileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0 )) == -1){ // GARANT_XXX
		if((i0= CreateFileHandle(	BackupFileName,
									ACE_OS_O_CREAT| ACE_OS_O_TRUNC | ACE_OS_O_RDWR | ACE_OS_O_BINARY,
									0)) == -1){ // GARANT_XXX
			return -3;
		}
		// Backup //
		if((ps= (char*)alloc_in_heap((sz=StrLength(RestoreFileName))+100)) == 0){
			return -5;
		}
		MemCopy(ps, RestoreFileName, sz);
		MemCopy(ps+sz, ".ndt", 5);
		if((indt= CreateFileHandle( ps, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
			free_in_heap(ps);
			return -4;
		}
		MemCopy(ps+sz, ".str", 5);
		if((istr= CreateFileHandle( ps, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
			free_in_heap(ps);
			CloseFileHandle(indt);
			CloseFileHandle(i0);
			return -4;
		}
		if((szstr= SetFilePos(istr, 0, ACE_OS_SEEK_END)) == -1){
			free_in_heap(ps);
			CloseFileHandle(indt);
			CloseFileHandle(i0);
			return -4;
		}
		SetFilePos(istr, 0, ACE_OS_SEEK_SET);

		MemCopy(ps+sz, ".key", 5);
		if((ikey= CreateFileHandle( ps, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
			free_in_heap(ps);
			CloseFileHandle(istr);
			CloseFileHandle(indt);
			CloseFileHandle(i0);
			return -4;
		}
		if((szkey= SetFilePos(ikey, 0, ACE_OS_SEEK_END)) == -1){
			free_in_heap(ps);
			CloseFileHandle(istr);
			CloseFileHandle(indt);
			CloseFileHandle(ikey);
			CloseFileHandle(i0);
			return -4;
		}
		SetFilePos(ikey, 0, ACE_OS_SEEK_SET);
		if(szstr < 0xa00000 || szkey < 0xa00000){
			if(szstr < szkey)
				readed= (int)szstr;
			else
				readed= (int)szkey;
		}else
			readed= (int)0xa00000;

		if((bff= (char*)alloc_in_heap(readed)) == 0){
			free_in_heap(ps);
			CloseFileHandle(istr);
			CloseFileHandle(indt);
			CloseFileHandle(ikey);
			CloseFileHandle(i0);
			return -5;
		}
		if(ReadFromFile(indt, bff, 512) != 512 || *(long*)bff != BASE_DATA_VERSION){
			ret= -6; goto Error0;
		}
		if(	WriteInFile(i0, &sign, sizeof(long)) != sizeof(long)
				||
			WriteInFile(i0, &readed, sizeof(long)) != sizeof(long)
				||
			WriteInFile(i0, bff, 512) != 512){
			ret= -2; goto Error0;
		}
		if(ReadFromFile(istr, bff, readed) != readed || *(long*)bff != BASE_DATA_VERSION){
			ret= -6; goto Error0;
		}
		if(	WriteInFile(i0, bff, readed) != readed){
			ret= -2; goto Error0;
		}
		if(ReadFromFile(ikey, bff, readed) != readed || *(long*)bff != BASE_DATA_VERSION){
			ret= -6; goto Error0;
		}
		if(	WriteInFile(i0, bff, readed) != readed){
			ret= -2; goto Error0;
		}
	}else{
		// Restore //
		if(	ReadFromFile(i0, &szstr, sizeof(long)) != sizeof(long)
				||
			szstr != sign
				||
			ReadFromFile(i0, &readed, sizeof(long)) != sizeof(long)){
			CloseFileHandle(i0);
			return -6;
		}
		if((ps= (char*)alloc_in_heap((sz=StrLength(BackupFileName))+100)) == 0){
			CloseFileHandle(i0);
			return -5;
		}
		if((bff= (char*)alloc_in_heap(readed)) == 0){
			CloseFileHandle(i0);
			return -5;
		}
		MemCopy(ps, BackupFileName, sz);
		MemCopy(ps+sz, ".ndt", 5);
		if((indt= CreateFileHandle( ps, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
			CloseFileHandle(i0);
			free_in_heap(ps);
			free_in_heap(bff);
			return -4;
		}
		MemCopy(ps+sz, ".str", 5);
		if((istr= CreateFileHandle( ps, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
			free_in_heap(ps);
			CloseFileHandle(i0);
			CloseFileHandle(indt);
			free_in_heap(bff);
			return -4;
		}
		MemCopy(ps+sz, ".key", 5);
		if((ikey= CreateFileHandle( ps, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
			free_in_heap(ps);
			CloseFileHandle(i0);
			CloseFileHandle(indt);
			CloseFileHandle(istr);
			free_in_heap(bff);
			return -4;
		}
		if(	ReadFromFile(i0, bff, 512) != 512 ){
			ret= -6; goto Error0;
		}
		if(	WriteInFile(indt, bff, 512) != 512){
			ret= -2; goto Error0;
		}
		if(	ReadFromFile(i0, bff, readed) != readed ){
			ret= -6; goto Error0;
		}
		if(	WriteInFile(istr, bff, readed) != readed){
			ret= -2; goto Error0;
		}
		if(	ReadFromFile(i0, bff, readed) != readed ){
			ret= -6; goto Error0;
		}
		if(	WriteInFile(ikey, bff, readed) != readed){
			ret= -2; goto Error0;
		}
#ifdef MULTI_INDEX_STREAM_FILE
		ps[sz]= 0;
		if(pl_ModifySignOnOtherFiles(ps, 2)){
			ret= -2; goto Error0;
		}
#endif
	}
Error0:
	free_in_heap(bff);
	free_in_heap(ps);
	CloseFileHandle(istr);
	CloseFileHandle(indt);
	CloseFileHandle(ikey);
	CloseFileHandle(i0);
	return ret;
}
int __stdcall gCopyPX_32(char *RestoreFileName, char *BackupFileName)
{
	int retLocal= gCopyPX_32Ex(RestoreFileName, BackupFileName);
/*
#ifdef WIN32
	if(retLocal && LastCretatedFileHandle != -1){
		if(LastCretatedFileHandle != -2)
			CloseHandle((HANDLE)LastCretatedFileHandle);
		DeleteFile(LastCretatedFileName);
	}
	LastCretatedFileHandle= -1;
#endif
*/
	return retLocal;
}
#endif

int WordComp( const void *arg1, const void *arg2 )
{
	if(**(PWORD*)arg1 == **(PWORD*)arg2)
		return 0;
	else if(**(PWORD*)arg1 > **(PWORD*)arg2)
		return -1;

	return 1;
}
void NormalizeSDBRecord(LPPL_SDB_RECRD pUpdate)
{
	pUpdate->pFrands= (PDWORD)((char*)pUpdate + sizeof(*pUpdate));
	pUpdate->account.Attrib.pTable=
		(PWORD)((PBYTE)pUpdate->pFrands 
			+ (SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD) * pUpdate->frandsCount));
}

int pl_writeOffset(	PBYTE *ppStream, long *psz, long *pAsz, long currPos, long woffset)
{
	//SetFilePos(fh, woffset, ACE_OS_SEEK_SET);
	*(long*)((*ppStream) + woffset)= currPos;
	//if(pl_write(ppStream, psz, pAsz, &currPos, sizeof(long)) != sizeof(long))
	//	return 0;
	//SetFilePos(fh, 0l, ACE_OS_SEEK_END);
	return sizeof(long);
}

int	pl_writeRecord(	PBYTE *ppStream, long *psz, long *pAsz, LPPL_SDB_RECRD pCurr)
{
	long len= sizeof(*pCurr);
	if(pl_write(ppStream, psz, pAsz, pCurr, len) != len){
		return -2;
	}
	len= SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD) * pCurr->frandsCount;
	if(pl_write(ppStream, psz, pAsz, pCurr->pFrands, len) != len){
		return -2;
	}
	len= pCurr->account.Attrib.BelngsSize * sizeof(WORD);
	if(pl_write(ppStream, psz, pAsz, pCurr->account.Attrib.pTable, len) != len){
		return -2;
	}
	return 0;
}

void pl_strip_Belngs(PWORD	*pAll, int ln, PWORD pTable, PWORD pCount)
{
	int fh;
	PWORD	ptmp0;

	LocSort( pAll, (size_t)ln, sizeof( PBYTE ), WordComp );

	*pTable= **pAll;
	*pCount= 1;

	for(fh= 1, ptmp0= pTable; fh < ln; fh++) {
		if(*ptmp0 != *pAll[fh]){
			(*pCount)++;
			ptmp0++;
			*ptmp0= *pAll[fh];
		}
	}
}
#if !defined(PL_REPLCTR_FUNC) && defined(MAKE_HDD)
int
#ifndef WIN32
	pl_CreateLicenseEx
#else
	pl_CreateLicenseExWin32
#endif
					(	char *FileName, char *pServiceLogin, char *pServicePasswordedHash,
						PDWORD pId, char *AdvancedInfo, long frandsCount, LPPL_SDB_RECRD pFrands)
{
	PL_SDB_RECRD srvc;
	int len, ln, fh;
	LPPL_SDB_RECRD pNext;
	PWORD	*pAll, ptmp, *pptmp;
	long currPos, ltmp, checkpoint;

	PBYTE pNewMem;
	long szNewMem= 0, szAllocNewMem= 0;

	len=StrLength(pServiceLogin);
	if(len < LOGIN_SIZE_PER_BYTES){
		MemSeting(srvc.account.pLogin, 0, LOGIN_SIZE_PER_BYTES);
		MemCopy(srvc.account.pLogin, pServiceLogin, len);
	}else
		MemCopy(srvc.account.pLogin, pServiceLogin, LOGIN_SIZE_PER_BYTES);

	MemCopy(srvc.account.pPsswrd, pServicePasswordedHash, PSSWRD_SIZE_PER_BYTES);

	MemCopy(srvc.account.pId, pId, SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD));

	srvc.frandsCount= frandsCount;

	for(frandsCount=0, len= 0;
			frandsCount < srvc.frandsCount; frandsCount++) {
		if((int)pFrands[frandsCount].account.Attrib.BelngsSize)
			len += (int)pFrands[frandsCount].account.Attrib.BelngsSize;
		else
			return -670;
	}

	if((pAll=(PWORD*)alloc_in_heap(sizeof(PWORD)*len)) == 0
		|| (srvc.account.Attrib.pTable= (PWORD)alloc_in_heap(sizeof(WORD)*len)) == 0){
		if(pAll != 0)
			free_in_heap(pAll);
		return -5;
	}

	ln= len;

	for(pNext= pFrands, frandsCount=0l, pptmp= pAll;
			frandsCount < srvc.frandsCount; frandsCount++, pNext++) {
		len= (int)pNext->account.Attrib.BelngsSize;
		ptmp= pNext->account.Attrib.pTable;
		while(len--){
			*pptmp= ptmp;
			ptmp++;
			pptmp++;
		}
	}

	pl_strip_Belngs(	pAll, ln, srvc.account.Attrib.pTable,
							&srvc.account.Attrib.BelngsSize);
	free_in_heap(pAll);

	if(FileName[0] != 1){
		if((fh= CreateFileHandle( FileName, ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
			free_in_heap(srvc.account.Attrib.pTable);
			return -3;
		}
	}else{
		fh= *(int*)(FileName+1);
	}

	if(pl_write(&pNewMem, &szNewMem, &szAllocNewMem, UIDDB_STREAM_SIGN, SIZE_SYNHRO_PER_DWORD * sizeof(DWORD))
		!= SIZE_SYNHRO_PER_DWORD * sizeof(DWORD)){
		free_in_heap(srvc.account.Attrib.pTable);
		free_in_heap(pNewMem);
		return -2;
	}

	GetCurrentDate(&checkpoint);
	if(pl_write(&pNewMem, &szNewMem, &szAllocNewMem, &checkpoint, sizeof(long)) != sizeof(long)){
		free_in_heap(srvc.account.Attrib.pTable);
		free_in_heap(pNewMem);
		return -2;
	}
	currPos= StrLength(AdvancedInfo);
	if(pl_write(&pNewMem, &szNewMem, &szAllocNewMem, &currPos, sizeof(long)) != sizeof(long)){
		free_in_heap(srvc.account.Attrib.pTable);
		free_in_heap(pNewMem);
		return -2;
	}
	if(pl_write(&pNewMem, &szNewMem, &szAllocNewMem, AdvancedInfo, currPos) != currPos){
		free_in_heap(srvc.account.Attrib.pTable);
		free_in_heap(pNewMem);
		return -2;
	}
	currPos= szNewMem;

	for(pNext= pFrands, frandsCount=0l;
			frandsCount < srvc.frandsCount; frandsCount++, pNext++) {
		pNext->frandsCount= 1;
		pNext->pFrands= srvc.account.pId;
		if(pl_writeRecord(&pNewMem, &szNewMem, &szAllocNewMem, pNext)){
			free_in_heap(srvc.account.Attrib.pTable);
			free_in_heap(pNewMem);
			return -2;
		}
		ltmp= szNewMem;
		if(!pl_writeOffset(&pNewMem, &szNewMem, &szAllocNewMem, ltmp, currPos)){
			free_in_heap(srvc.account.Attrib.pTable);
			CloseFileHandle(fh);
			free_in_heap(pNewMem);
			return -2;
		}
		currPos= ltmp;
	}
	srvc.offset_to_next= 0;
	srvc.frandsCount= 0;
	if(pl_writeRecord(&pNewMem, &szNewMem, &szAllocNewMem, &srvc))
		return -2;

	/*ltmp= GetFilePos(fh) - currStart;
	if((ptmp=(PWORD)alloc_in_heap((int)ltmp+SIZE_CRYPTO_HEADER)) == 0){
		free_in_heap(srvc.account.Attrib.pTable);
		CloseFileHandle(fh);
		return -5;
	}*/
	ltmp= szNewMem;
	ptmp=(PWORD)pNewMem;

	LoadCryptoKeyFromStr((char*)srvc.account.pLogin, 0);
	/*if(SetFilePos( fh, currStart, ACE_OS_SEEK_SET ) != currStart
		|| ReadFromFile(fh, ptmp, (int)ltmp) != ltmp){
		UnLoadCryptoKey((PDWORD)(&ltmp), 0);
		free_in_heap(srvc.account.Attrib.pTable);
		free_in_heap(ptmp);
		CloseFileHandle(fh);
		return -555;
	}*/
	EnCrypto((char*)ptmp, (PDWORD)(&ltmp));
	if(	/*SetFilePos( fh, currStart, ACE_OS_SEEK_SET ) != currStart
		||*/ WriteInFile(fh, ptmp, (int)ltmp) != ltmp){
		UnLoadCryptoKey((PDWORD)(&ltmp), 0);
		free_in_heap(srvc.account.Attrib.pTable);
		free_in_heap(ptmp);
		CloseFileHandle(fh);
		return -2;
	}
	UnLoadCryptoKey((PDWORD)(&ltmp), 0);
	free_in_heap(ptmp);
	if(FileName[0] != 1)
		CloseFileHandle(fh);
	free_in_heap(srvc.account.Attrib.pTable);
	return 0;
}
#ifdef WIN32
int pl_CreateLicenseEx(	char *FileName, char *pServiceLogin, char *pServicePasswordedHash,
						PDWORD pId, char *AdvancedInfo, long frandsCount, LPPL_SDB_RECRD pFrands)
{
	int retLocal= pl_CreateLicenseExWin32(	FileName, pServiceLogin, pServicePasswordedHash,
											pId, AdvancedInfo, frandsCount, pFrands);
/*
	if(retLocal && LastCretatedFileHandle != -1){
		if(LastCretatedFileHandle != -2)
			CloseHandle((HANDLE)LastCretatedFileHandle);
		DeleteFile(LastCretatedFileName);
	}
	LastCretatedFileHandle= -1;
*/
	return retLocal;
}
#endif
#elif defined(BRDR32) && !defined(RD_AS_ETALON)
#endif
void __stdcall pl_HashPassword(LPPL_IMPORT_HASH pStruct)
{
	BYTE tmp0[PSSWRD_SIZE_PER_BYTES+PSSWRD_SIZE_PER_BYTES];
	int szstr= (int)(StrLength((char*)pStruct->pInput)&0x7fffffff);

	if(szstr< LOGIN_SIZE_PER_BYTES){
		MemSeting(tmp0, 0, LOGIN_SIZE_PER_BYTES);
		MemCopy(tmp0, pStruct->pInput, szstr);
	}else
		MemCopy(tmp0, pStruct->pInput, LOGIN_SIZE_PER_BYTES);

	pl_HashEx(tmp0);
	MemCopy(pStruct->Result, tmp0, LOGIN_SIZE_PER_BYTES);
}

#if defined(MAKE_HDD) && !defined(PL_REPLCTR_FUNC)

int __stdcall pl_CreateDebugLicense(	char* LicenseFileName,
								char* LoginSerivice,
								LPPL_IMPORT_HASH pSeriviceDepPasswordHash,
								long ServiceDepID,
								char *AdvancedInfo,
								long FriendedReplicatorsCount,
								LPPL_SDB_IMPORT_RECRD pFriendedReplicatorsList )
{
	BYTE tmp0[LOGIN_SIZE_PER_BYTES];
	DWORD	pID[SIZE_CRYPTO_KYE_PER_DWORD];
	LPPL_SDB_IMPORT_RECRD pNext= pFriendedReplicatorsList;
	int count= (int)FriendedReplicatorsCount;
	void *pFnd;

	pID[0]= (DWORD)ServiceDepID;
	MemCopy(pID+1, "7777", sizeof(DWORD));

	while(count--){
		if((pFnd= MemChar( pNext->pLogin, '\0', LOGIN_SIZE_PER_BYTES)) != 0){
			MemSeting(tmp0, 0, LOGIN_SIZE_PER_BYTES);
			MemCopy(tmp0, pNext->pLogin, (int)pFnd - (int)pNext->pLogin);
			MemCopy(pNext->pLogin, tmp0, LOGIN_SIZE_PER_BYTES);
		}
		pNext++;
	}
	return pl_CreateLicenseEx(	LicenseFileName,
								LoginSerivice, (char*)pSeriviceDepPasswordHash->Result,
								pID,
								AdvancedInfo,
								FriendedReplicatorsCount,
								(LPPL_SDB_RECRD)pFriendedReplicatorsList);
}

int __stdcall pl_CreateLicense(	char* LicenseFileName,
								char* LoginInitiator,
								char* PasswordInitiator,
								char* LoginSerivice,
								LPPL_IMPORT_HASH pSeriviceDepPasswordHash,
								long ServiceDepID,
								char *AdvancedInfo,
								long FriendedReplicatorsCount,
								LPPL_SDB_IMPORT_RECRD pFriendedReplicatorsList )
{
	BYTE tmp0[LOGIN_SIZE_PER_BYTES];
	DWORD	pID[SIZE_CRYPTO_KYE_PER_DWORD];
	LPPL_SDB_IMPORT_RECRD pNext= pFriendedReplicatorsList;
	int count= (int)FriendedReplicatorsCount, len;
	void *pFnd;
	PL_IMPORT_HASH ttt;

	len= StrLength(PasswordInitiator);
	if(len < LOGIN_SIZE_PER_BYTES){
		MemSeting(ttt.Result, 0, PSSWRD_SIZE_PER_BYTES);
		MemCopy(ttt.Result, PasswordInitiator, len);
	}else
		MemCopy(ttt.Result, PasswordInitiator, PSSWRD_SIZE_PER_BYTES);

	pl_HashEx(ttt.Result);

	return -559;

	pID[0]= (DWORD)ServiceDepID;
	MemCopy(pID+1, "7777", sizeof(DWORD));

	while(count--){
		if((pFnd= MemChar( pNext->pLogin, '\0', LOGIN_SIZE_PER_BYTES)) != 0){
			MemSeting(tmp0, 0, LOGIN_SIZE_PER_BYTES);
			MemCopy(tmp0, pNext->pLogin, (int)pFnd - (int)pNext->pLogin);
			MemCopy(pNext->pLogin, tmp0, LOGIN_SIZE_PER_BYTES);
		}
		pNext++;
	}
	return pl_CreateLicenseEx(	LicenseFileName,
								LoginSerivice, (char*)pSeriviceDepPasswordHash->Result,
								pID,
								AdvancedInfo,
								FriendedReplicatorsCount,
								(LPPL_SDB_RECRD)pFriendedReplicatorsList);
}

#ifndef RD_AS_ETALON
int __stdcall pl_CreateDebugMultiLicense(
								char* LicenseFileName,
								char *AdvancedInfo,
								long ServiceDepCount,
								LPPL_MULTI_SDB_IMPORT_RECRD pServiceDepArray )
{
	int ret, ii;
	long	len;
	char tmpExt10[10], sign[10];
	WORD wlen;

	((long*)sign)[0]= MULTI_LCNS_SIGN;
	((long*)sign)[1]= 0;

	if((ret= CreateFileHandle( LicenseFileName, ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
		return -3;
	}
	if(WriteInFile(ret, sign, 8) != 8){
		CloseFileHandle(ret);
		return -2;
	}
	tmpExt10[0]= 1;

	*(int*)(tmpExt10+1)= ret;

	ii= 4;

	while(ServiceDepCount--){
		wlen= (WORD)StrLength(pServiceDepArray->LoginSerivice);
		if(	WriteInFile(ret, &wlen, 2) != 2
				||
			WriteInFile(ret, pServiceDepArray->LoginSerivice, (int)wlen) != (int)wlen
				||
			pl_CreateDebugLicense(	tmpExt10,
				pServiceDepArray->LoginSerivice,
				pServiceDepArray->pSeriviceDepPasswordHash,
				pServiceDepArray->ServiceDepID,
				AdvancedInfo,
				pServiceDepArray->FriendedReplicatorsCount,
				pServiceDepArray->pFriendedReplicatorsList
			)){
			return -2;
		}
		if(ServiceDepCount)
			len = GetFilePos(ret);
		else
			len= 0;
		if(SetFilePos( ret, ii, ACE_OS_SEEK_SET ) != ii
			||
			WriteInFile(ret, &len, sizeof(len)) != sizeof(len)){
			CloseFileHandle(ret);
			return -2;
		}
		if(ServiceDepCount){
			ii= len;
			len += sizeof(len);
			if(SetFilePos( ret, len, ACE_OS_SEEK_SET ) != len){
				CloseFileHandle(ret);
				return -2;
			}
		}
		pServiceDepArray++;
	}
	CloseFileHandle(ret);
	return 0;
}
int __stdcall pl_CreateMultiLicense(
								char* LicenseFileName,
								char* LoginInitiator,
								char* PasswordInitiator,
								char *AdvancedInfo,
								long ServiceDepCount,
								LPPL_MULTI_SDB_IMPORT_RECRD pServiceDepArray )
{
	int ret, ii;
	long	len;
	char tmpExt10[10], sign[10];
	WORD wlen;

	((long*)sign)[0]= MULTI_LCNS_SIGN;
	((long*)sign)[1]= 0;

	if((ret= CreateFileHandle( LicenseFileName, ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
		return -3;
	}
	if(WriteInFile(ret, sign, 8) != 8){
		CloseFileHandle(ret);
		return -2;
	}
	tmpExt10[0]= 1;

	*(int*)(tmpExt10+1)= ret;

	ii= 4;

	while(ServiceDepCount--){
		wlen= (WORD)StrLength(pServiceDepArray->LoginSerivice);
		if(	WriteInFile(ret, &wlen, 2) != 2
				||
			WriteInFile(ret, pServiceDepArray->LoginSerivice, (int)wlen) != (int)wlen
				||
			pl_CreateLicense(	tmpExt10, LoginInitiator, PasswordInitiator,
				pServiceDepArray->LoginSerivice,
				pServiceDepArray->pSeriviceDepPasswordHash,
				pServiceDepArray->ServiceDepID,
				AdvancedInfo,
				pServiceDepArray->FriendedReplicatorsCount,
				pServiceDepArray->pFriendedReplicatorsList
			)){
			return -2;
		}
		if(ServiceDepCount)
			len = GetFilePos(ret);
		else
			len= 0;
		if(SetFilePos( ret, ii, ACE_OS_SEEK_SET ) != ii
			||
			WriteInFile(ret, &len, sizeof(len)) != sizeof(len)){
			CloseFileHandle(ret);
			return -2;
		}
		if(ServiceDepCount){
			ii= len;
			len += sizeof(len);
			if(SetFilePos( ret, len, ACE_OS_SEEK_SET ) != len){
				CloseFileHandle(ret);
				return -2;
			}
		}
		pServiceDepArray++;
	}
	CloseFileHandle(ret);
	return 0;
}
#endif
#endif

int pl_ServiseIsValid(	LPPL_SDB_RECRD pService, LPPL_SDB_RECRD pCopyer)
{
	int count= pCopyer->frandsCount;
	while(count--){
		if(	pCopyer->pFrands[count*SIZE_CRYPTO_KYE_PER_DWORD]
				== pService->account.pId[0]
						&&
			pCopyer->pFrands[count*SIZE_CRYPTO_KYE_PER_DWORD+1]
				== pService->account.pId[1] )
						return 0;
	}
	return 1;
}

int pl_GetNextCIB(	LPPL_FZ1_CIB *ppRet, LPPL_FZ1_CIB_POST *ppPost,
					PBYTE	*ppBelngs, int process)
{
	int loginSz;
	//
	if(FZ1_CIB_SIGN != (*ppRet)->lSgntr){
		if(FZ1_POST_HDR_SIGN == (*ppRet)->lSgntr)
			return -672;
		return -15;
	}

	if((short)0 != (loginSz= (int)*(short*)(*ppPost= (LPPL_FZ1_CIB_POST)((char*)*ppRet
										+ sizeof(**ppRet)
										+ (*ppRet)->NameClientSz
										// add size for CIB ID //
										+ sizeof(long))))){
		if(!process || loginSz != LOGIN_SIZE_PER_BYTES)
			return -14;
	}

	*ppPost= (LPPL_FZ1_CIB_POST)
				((char*)*ppPost + loginSz + sizeof(short) + sizeof(short)
					+ *(short*)((char*)*ppPost + loginSz + sizeof(short)));

	*ppBelngs= (PBYTE)((char*)*ppPost + sizeof(**ppPost)
								+ (*ppPost)->lSpecStringSz
								+ sizeof(short));
	if(!*((short*)(*ppBelngs)-1) && !(*ppPost)->lSpec)
		return -674;

	*ppRet= (LPPL_FZ1_CIB)((char*)*ppBelngs + *((short*)*ppBelngs - 1));
#ifndef RD_AS_ETALON
	*ppRet= (LPPL_FZ1_CIB)
		((char*)*ppRet + *(short*)*ppRet + sizeof(short) + sizeof(long));
#endif
	return 0;
}

int pl_write(PBYTE *ppStream, long *pSz, long *pAllocSz, void *pInput, int len)
	{
	PBYTE pTmp;
	if(*pAllocSz < *pSz + len){
		*pAllocSz += len*PL_ALLOC_STEP;
		if((pTmp= (PBYTE)alloc_in_heap(*pAllocSz)) == 0){
			if(*pSz != 0l){
				free_in_heap(*ppStream);
			}
			*ppStream= 0;
			return -5;
		}
		if(*pSz != 0l){
			MemCopy(pTmp, *ppStream, *pSz);
			free_in_heap(*ppStream);
		}
		*ppStream= pTmp;
	}
	MemCopy(*ppStream+ *pSz, pInput, len);
	*pSz += len;
	return len;
}

void pl_freeBlngsTbls(LPPL_SDB_RECRD pArray, int sz)
{
	while(sz--){
		if(pArray->account.Attrib.pTable != 0)
			free_in_heap(pArray->account.Attrib.pTable);
		pArray++;
	}
}

void pl_CalcCryptoSizeInBase(int *pRet, long iKeySz, long iStrSz, int DefaultSize)
{
	*pRet= DefaultSize;
	iKeySz -= 4096;
	iStrSz -= 4096;
	if(iKeySz < iStrSz && iKeySz < (long)*pRet)
		*pRet= ((int)iKeySz/4096)*4096;
	else if(iStrSz <= iKeySz && iStrSz < (long)*pRet)
		*pRet= ((int)iStrSz/4096)*4096;
}

int pl_UnCryptBase(int iKey, int iStr, char *pNDT_Header, char *pK, char *pS, int CryptoCount)
{
	long retCrpt;
	long iKeySz;
#ifndef RD_AS_ETALON
	char *pNDT_Attrs= pNDT_Header+pl_GetLoginOffest()-sizeof(struct PagedFileHeader);
#endif
	if(	ReadFromFile(iStr, pK+sizeof(long), CryptoCount) == CryptoCount
			&&
		ReadFromFile(iKey, pS+sizeof(long), CryptoCount) == CryptoCount
			&&
		MemCopy(pK+sizeof(long)+CryptoCount, pNDT_Header+(iKeySz=LOGIN_SIZE_PER_BYTES
									+SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)+1),
					SIZE_CRYPTO_HEADER) != 0
			&&
		MemCopy(pS+sizeof(long)+CryptoCount, pNDT_Header+iKeySz+SIZE_CRYPTO_HEADER,
					SIZE_CRYPTO_HEADER) != 0)
	{
		LoadCryptoKey(pNDT_Header+LOGIN_SIZE_PER_BYTES+1, 0);
#ifndef RD_AS_ETALON
		IsG6X_NDT[0]= 0;IsG6X_NDT[1]= 0;
		retCrpt= SIZE_CRYPTO_HEADER*(16-0);
	#if defined(MAKE_HDD) && defined(INC_DONGLE_DLL)  && defined(MULTI_INDEX_STREAM_FILE)
		if(CryptoCount == MAX_CRYPTED_BLOCK_IN_WORK){
			UnCryptoPost(pNDT_Attrs, (PDWORD)(&retCrpt));
		}else
	#endif
		UnCrypto(pNDT_Attrs, (PDWORD)(&retCrpt));
		if(*(long*)pNDT_Attrs == 0x52455609 /*VER*/ && *(long*)(pNDT_Attrs+41) == 0x56494309 /*CIV*/){
			MemCopy(IsG6X_NDT, pNDT_Attrs+41, SIZE_SYNHRO_PER_DWORD*sizeof(long));
			Hash((PDWORD)(IsG6X_NDT)); // MPCXC C++ type violation
		}
#endif
		retCrpt= CryptoCount+SIZE_CRYPTO_HEADER;
	#if defined(MAKE_HDD) && defined(INC_DONGLE_DLL)  && defined(MULTI_INDEX_STREAM_FILE)
		if(CryptoCount == MAX_CRYPTED_BLOCK_IN_WORK)
			UnCryptoPost(pK+sizeof(long), (PDWORD)(&retCrpt));
		else
	#endif
		UnCrypto(pK+sizeof(long), (PDWORD)(&retCrpt));
		if(retCrpt == (long)CryptoCount){
			retCrpt= CryptoCount+SIZE_CRYPTO_HEADER;
	#if defined(MAKE_HDD) && defined(INC_DONGLE_DLL)  && defined(MULTI_INDEX_STREAM_FILE)
			if(CryptoCount == MAX_CRYPTED_BLOCK_IN_WORK)
				UnCryptoPost(pS+sizeof(long), (PDWORD)(&retCrpt));
			else
	#endif
			UnCrypto(pS+sizeof(long), (PDWORD)(&retCrpt));
			if(retCrpt == (long)CryptoCount){
				UnLoadCryptoKey((PDWORD)(&retCrpt), 0);
				if(retCrpt == 0
#if defined(MAKE_HDD) && defined(INC_DONGLE_DLL)  && defined(MULTI_INDEX_STREAM_FILE)
								&& CryptoCount == MAX_CRYPTED_BLOCK_IN_WORK)
					return 0;
				else if(retCrpt == 0
#endif
								&& SetFilePos(iStr, 4096, ACE_OS_SEEK_SET) == 4096
								&& SetFilePos(iKey, 2048, ACE_OS_SEEK_SET) == 2048	)
				{
					*((long*)pK)= (long)CryptoCount+2048;
					*((long*)pS)= (long)CryptoCount+4096;
					return 0;
				}
			}
		}
		free_in_heap(pK);
		free_in_heap(pS);
		UnLoadCryptoKey((PDWORD)(&retCrpt), 0);
	}
	return 1;
}

#include "gkdb_ver.h"

#if defined(BRDR32) || defined(MAKE_HDD) || defined(INSTLL_CIB)
	#if defined(MULTI_INDEX_STREAM_FILE) && !defined(INC_DONGLE_DLL)
		char *preCryptoKeyTag, *preCryptoStrTag;
		long iRetSynchro;
	#endif

int pl_ModifyBaseEx(int iKey, int iStr, int iNdt,
						char **ppBuff, char **ppBuff0, char *pKeyUP, int CryptoCount)
{
	long countCIB, lUpID, countPost;
	int iKeySz, iStrSz, AsWorked=
#ifndef INSTLL_CIB
									1
#else
									0
#endif
										;
#ifndef RD_AS_ETALON
	char *pNDT_Attrs= 0;
	int szNDT_Attrs= 12*16-SIZE_CRYPTO_HEADER;
#endif
	if(	(*ppBuff == 0 && (
		ReadFromFile(iKey, &countCIB, sizeof(long)) != sizeof(long)
			||
		countCIB != BASE_DATA_VERSION
			||
		ReadFromFile(iStr, &countCIB, sizeof(long)) != sizeof(long)
			||
		countCIB != BASE_DATA_VERSION
			||
		ReadFromFile(iNdt, &countCIB, sizeof(long)) != sizeof(long)
			||
		countCIB != BASE_DATA_VERSION
			||
		#if defined(RD_AS_ETALON) || defined(NOT_RD)
			(	(countCIB == BASE_DATA_VERSION && (countCIB= PL_HDD_SIGN) != PL_HDD_SIGN)
					||
				(countCIB != PL_HDD_SIGN && (countCIB= -1999l) != -1999l)	)
			||
		#elif defined(INC_DONGLE_DLL)
				(countCIB= PL_HDD_SIGN) != PL_HDD_SIGN
			||
		#endif
		SetFilePos(iKey, 0, ACE_OS_SEEK_SET) != 0
			||
		SetFilePos(iStr, 0, ACE_OS_SEEK_SET) != 0
			||
		SetFilePos(iNdt, 0, ACE_OS_SEEK_SET) != 0
			||
		WriteInFile(iKey, &countCIB, sizeof(long)) != sizeof(long)
			||
		WriteInFile(iStr, &countCIB, sizeof(long)) != sizeof(long)
			||
		WriteInFile(iNdt, &countCIB, sizeof(long)) != sizeof(long)
			||
		(iKeySz=SetFilePos(iKey, 0l, ACE_OS_SEEK_END)) == -1
			||
		(iStrSz=SetFilePos(iStr, 0l, ACE_OS_SEEK_END)) == -1))
			||
		SetFilePos(iKey, 2048L, ACE_OS_SEEK_SET) != 2048
			||
		SetFilePos(iStr, 4096L, ACE_OS_SEEK_SET) != 4096
		)
	{
		return -2;
	}
	if(!CryptoCount){
		AsWorked= 0;
		pl_CalcCryptoSizeInBase(&CryptoCount, iKeySz, iStrSz, MAX_CRYPTED_BLOCK);
	}
#ifndef INSTLL_CIB
	else if(CryptoCount == MAX_CRYPTED_BLOCK)
		AsWorked= 0;
	if(	*ppBuff != 0
			||
		(	(*ppBuff0= 0) == 0
				&&
			((*ppBuff)= 
  #ifndef RD_AS_ETALON
		(char*)alloc_in_heap((CryptoCount+SIZE_CRYPTO_HEADER)*2+512+SIZE_CRYPTO_HEADER)) != 0
				&&
		(pNDT_Attrs= *ppBuff+(CryptoCount+SIZE_CRYPTO_HEADER)*2) != 0
				&&
#if !defined(NOT_RD) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
		SetFilePos(iNdt, 0, ACE_OS_SEEK_SET) == 0
				&&
		ReadFromFile(iNdt,	pNDT_Attrs, 512) == 512
				&&
		SetFilePos(iNdt, sizeof(struct PagedFileHeader), ACE_OS_SEEK_SET) == sizeof(struct PagedFileHeader)
#else
		SetFilePos(iNdt, sizeof(struct PagedFileHeader), ACE_OS_SEEK_SET) == sizeof(struct PagedFileHeader)
				&&
		ReadFromFile(iNdt,	pNDT_Attrs, szNDT_Attrs) == szNDT_Attrs
#endif
  #else
		(char*)alloc_in_heap((CryptoCount+SIZE_CRYPTO_HEADER)*2)) != 0
  #endif
				&& 
			(*ppBuff0= *ppBuff+CryptoCount+SIZE_CRYPTO_HEADER) != 0
				&&
  #if !defined(NOT_RD) && defined(MAKE_HDD) && !defined(INC_DONGLE_DLL)
			memcpy(*ppBuff, preCryptoKeyTag+sizeof(long), CryptoCount) != 0
				&&
			memcpy(*ppBuff0, preCryptoStrTag+sizeof(long), CryptoCount) != 0
  #elif !defined(NOT_RD) && !defined(RD_AS_ETALON)
			// Делаем как крипто Теги из PagedFile
			(*ppBuff -= sizeof(long)) && (*ppBuff0 -= sizeof(long))
			&& !pl_UnCryptBase(	iKey, iStr, pNDT_Attrs+512- pl_GetLoginOffest(),
								*ppBuff, *ppBuff0, MAX_CRYPTED_BLOCK_IN_WORK)
			&& (*ppBuff += sizeof(long)) && (*ppBuff0 += sizeof(long)) &&
			// Дочитываем до CryptoCount текущего ППД
			ReadFromFile(iKey, *ppBuff+MAX_CRYPTED_BLOCK_IN_WORK, CryptoCount-MAX_CRYPTED_BLOCK_IN_WORK)
							== CryptoCount-MAX_CRYPTED_BLOCK_IN_WORK
				&&
			ReadFromFile(iStr, *ppBuff0+MAX_CRYPTED_BLOCK_IN_WORK, CryptoCount-MAX_CRYPTED_BLOCK_IN_WORK)
							== CryptoCount-MAX_CRYPTED_BLOCK_IN_WORK
				&& (pNDT_Attrs += sizeof(struct PagedFileHeader))
  #else
			ReadFromFile(iKey, *ppBuff, CryptoCount) == CryptoCount
				&&
			ReadFromFile(iStr, *ppBuff0, CryptoCount) == CryptoCount
  #endif
		))
#else
	if((pNDT_Attrs= pKeyUP + sizeof(struct PagedFileHeader)) && (pKeyUP += 512 - pl_GetLoginOffest() + LOGIN_SIZE_PER_BYTES + 1))
#endif
	{
		LoadCryptoKey(pKeyUP, 0);
		lUpID= CryptoCount;
		countPost= CryptoCount;
		countCIB= PL_HDD_SIGN;
#ifndef INSTLL_CIB
		if(AsWorked){
#if defined(RD_AS_ETALON) || defined(NOT_RD)
			char *pTempo= *ppBuff;
 #ifdef MAKE_HDD
			long newSign= -1999l;
			if(	SetFilePos(iKey, 0, ACE_OS_SEEK_SET) != 0
					||
				SetFilePos(iStr, 0, ACE_OS_SEEK_SET) != 0
					||
				SetFilePos(iNdt, 0, ACE_OS_SEEK_SET) != 0
					||
				WriteInFile(iKey, &newSign, sizeof(long)) != sizeof(long)
					||
				WriteInFile(iStr, &newSign, sizeof(long)) != sizeof(long)
					||
				WriteInFile(iNdt, &newSign, sizeof(long)) != sizeof(long)
			){
				return -2;
			}
   #endif
			*ppBuff= *ppBuff0;
			*ppBuff0= pTempo;
			lUpID += SIZE_CRYPTO_HEADER;
			countPost += SIZE_CRYPTO_HEADER;
 #else
		#ifndef NOT_RD
			pNDT_Attrs= pKeyUP + sizeof(struct PagedFileHeader);
			pKeyUP += 512 - pl_GetLoginOffest() + LOGIN_SIZE_PER_BYTES + 1;
			UnLoadCryptoKey((PDWORD)&countCIB, 0);
			countCIB= PL_HDD_SIGN;
			LoadCryptoKey(pKeyUP, 0);
			EnCryptoPost(pNDT_Attrs, (PDWORD)(&szNDT_Attrs));
			AsWorked= 0;
		#endif
			EnCryptoPost(*ppBuff, (PDWORD)(&lUpID));
			EnCryptoPost(*ppBuff0, (PDWORD)(&countPost));
 #endif
		}else
#endif
		{
			EnCrypto(*ppBuff, (PDWORD)(&lUpID));
			EnCrypto(*ppBuff0, (PDWORD)(&countPost));
#ifndef RD_AS_ETALON
			*((long*)(pNDT_Attrs+szNDT_Attrs)-1)= *((long*)pKeyUP+2);
			EnCrypto(pNDT_Attrs, (PDWORD)(&szNDT_Attrs));
#endif
		}
		UnLoadCryptoKey((PDWORD)&countCIB, 0);
		if(
			countCIB != 0
				||
			lUpID != CryptoCount+(int)SIZE_CRYPTO_HEADER
				||
			countPost != CryptoCount+(int)SIZE_CRYPTO_HEADER
				||
			SetFilePos(iKey, 2048L, ACE_OS_SEEK_SET) != 2048
				||
			SetFilePos(iStr, 4096L, ACE_OS_SEEK_SET) != 4096
				||
			WriteInFile(iStr, *ppBuff, CryptoCount) != CryptoCount
				||
			WriteInFile(iKey, *ppBuff0, CryptoCount) != CryptoCount
#ifndef RD_AS_ETALON
				||
		(pNDT_Attrs != 0
			&&	(	(int)SetFilePos(iNdt, sizeof(struct PagedFileHeader), ACE_OS_SEEK_SET) != sizeof(struct PagedFileHeader)
						||
					WriteInFile(iNdt, pNDT_Attrs, szNDT_Attrs) != szNDT_Attrs
				)
		)
				||
			(int)SetFilePos(iNdt, 512-(int)(SIZE_CRYPTO_HEADER+SIZE_CRYPTO_HEADER
									+SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)), ACE_OS_SEEK_SET)
							!= 512-(int)(SIZE_CRYPTO_HEADER+SIZE_CRYPTO_HEADER
									+(iStrSz=SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)))
				||
  #ifdef NOT_RD
		(!AsWorked && (
  #endif
			WriteInFile(iNdt, pKeyUP, iStrSz) != iStrSz
				||
			WriteInFile(iNdt, *ppBuff+CryptoCount, SIZE_CRYPTO_HEADER) != SIZE_CRYPTO_HEADER
				||
			WriteInFile(iNdt, *ppBuff0+CryptoCount, SIZE_CRYPTO_HEADER) != SIZE_CRYPTO_HEADER
  #ifdef NOT_RD
										)
		)
  #endif

  #ifndef MULTI_INDEX_STREAM_FILE
				||
    #ifdef NOT_RD
		(AsWorked &&	(
			(int)SetFilePos(iNdt, -(LOGIN_SIZE_PER_BYTES+1), ACE_OS_SEEK_CUR) == -1
				||
    #endif
			WriteInFile(iNdt,"* Copyright (C) НПП'Гарант-Сервис'2003 *             " ,
						(iStrSz+=SIZE_CRYPTO_HEADER+SIZE_CRYPTO_HEADER
									+LOGIN_SIZE_PER_BYTES+1)) != iStrSz
    #ifdef NOT_RD
														)
		)
    #endif
  #endif
			)
#else
			)
#endif
		{
			return -2;
		}
	}
	if(*ppBuff0 == 0)
		return -5;
	return 0;
}

int pl_ModifyBase(int iKey, int iStr, int iNdt, char **ppBuff, char *pKeyUP)
{
	char *pSecond;
	return pl_ModifyBaseEx(iKey, iStr, iNdt, ppBuff, &pSecond, pKeyUP, 0);
}
#endif

extern char *sel_Belngs;

int pl_TestBelngs(	LPPL_SDB_ATTRIB pTested, LPPL_SDB_ATTRIB pEtaln)
{
	int ii0= (int)pTested->BelngsSize, ii1, zz0= 0;
	while(ii0--){
		ii1= (int)pEtaln->BelngsSize;
		while(ii1--){
			if(pTested->pTable[ii0] == pEtaln->pTable[ii1])
				zz0++;
		}
	}
	return (int)pTested->BelngsSize != zz0;
}
//#endif

char *GetLoginSerivceFromMemBlockFZ1(LPPL_FZ1_HDR pSourceMem, short *pLiginSize)
{
#ifdef RD_AS_ETALON
	*pLiginSize= pSourceMem->LoginServiceSz;
#else
	*pLiginSize= *(short*)((char*)pSourceMem+ sizeof(pSourceMem->lSgntr)
					+ pSourceMem->ServiceSz
					+ sizeof(pSourceMem->ServiceSz));
#endif
	return ((char*)pSourceMem+ sizeof(pSourceMem->lSgntr)
#ifndef RD_AS_ETALON
						+ pSourceMem->ServiceSz
						+ sizeof(pSourceMem->ServiceSz)
#endif
						+ sizeof(*pLiginSize));
}

#if defined(BRDR32) || defined(MAKE_HDD)

char *strrev( char *pOut )
{
	size_t len= strlen(pOut);
	char *pLast= pOut + len, *pFirst= pOut, *pTmp= pLast;
	while((len-=2) > -1)
	{
		pLast--;
		*pTmp= *pLast;
		*pLast= *pFirst;
		*pFirst= *pTmp;
		pFirst++;
	}
	*pTmp= '\0';
	return pOut;
}

#ifdef PL_REPLCTR_FUNC
	static char VerInfoForTU[]=
  #ifndef RD_AS_ETALON
		#ifdef BIG_TURTLE
    #ifndef MULTI_INDEX_STREAM_FILE
								"PLib ver.54(Big)"
	#else
								"PLib ver.56(Big)"
    #endif
		#else
    #ifndef MULTI_INDEX_STREAM_FILE
								"PLib ver.54(Mini)"
	#else
								"PLib ver.56(Mini)"
    #endif
		#endif
  #else
								"PLib ver.52(Mini)"
  #endif
																			;
#endif

#ifndef NOT_SORT_BELONGS
int QSortStringInputedBelongs(PWORD pSortBlngs, char *pBelngs)
{
	PWORD pNextBelngs= pSortBlngs;
	int ii, sortBlngs;

	sortBlngs= (int)*((short*)pBelngs - 1);
	MemCopy(pBelngs - 1, pBelngs, sortBlngs);
	pBelngs--;
	pBelngs[sortBlngs]= '\0';

	do{
		local_sscanf((char*)pBelngs, &ii);
		*pNextBelngs= (WORD)ii;
		pNextBelngs++;
		if(ii > 99)
			ii=3;
		else if(ii > 9)
			ii=2;
		else
			ii=1;
	}while(pBelngs[ii] != '\0' && (pBelngs += ii+1) != 0);
	pBelngs += ii;
	if((ii= ((int)pNextBelngs-(int)pSortBlngs) / sizeof(WORD)) > 1){
		/////////
		PWORD	*pAll= 0;
		if((pAll=(PWORD*)alloc_in_heap(sizeof(PBYTE)*ii)) == 0){
			return -5;
		}
		while(ii--){
			pAll[ii]= pSortBlngs+ii;
		}
		ii= ((int)pNextBelngs-(int)pSortBlngs) / sizeof(WORD);
		LocSort( pAll, (size_t)ii, sizeof( PBYTE ), WordComp );
		pBelngs -= sortBlngs - 1;
		sortBlngs= 0;
		while(--ii){
			local_sprintf(pBelngs+sortBlngs, (BYTE)(*(pAll[ii])));
			if(*(pAll[ii]) > 99) sortBlngs+=4;
			else if(*(pAll[ii]) > 9) sortBlngs+=3;
			else sortBlngs+=2;
		}
		if(*(pAll[ii]) > 99){
			*(pBelngs+sortBlngs++)= (char)((*(pAll[ii]))/100) + (char)'0';
			*(pBelngs+sortBlngs++)= (char)(((*(pAll[ii]))%100)/10) + (char)'0';
			*(pBelngs+sortBlngs++)= (char)((*(pAll[ii]))%10) + (char)'0';
		}else if(*(pAll[ii]) > 9){
			*(pBelngs+sortBlngs++)= (char)((*(pAll[ii]))/10) + (char)'0';
			*(pBelngs+sortBlngs++)= (char)((*(pAll[ii]))%10) + (char)'0';
		}else{
			*(pBelngs+sortBlngs++)= (char)(*(pAll[ii])) + (char)'0';
		}
		free_in_heap(pAll);
		*((short*)pBelngs-1)= (short)sortBlngs;
		/////////
	}else{
		ii= sortBlngs;
		while(ii--){
			*pBelngs= *(pBelngs-1);
			pBelngs--;
		}
		pBelngs++;
	}
	*((short*)pBelngs-1)= (short)sortBlngs;
	return 0;
}
#endif

#if defined(MULTI_INDEX_STREAM_FILE) && defined(PL_REPLCTR_FUNC)
int pl_ModifySignOnOtherFiles(char *pTmp, int mode)
{
#ifdef	WIN32 // GARANT_WIN32 called from Vcontrol/msvc.win32/Demo_PAPI.cpp by gCopyPX_32 ()
	LPPL_BASE_FILE_LIST pList, pNxt;
	int iKey;
	char *pFND;
	long countCIB;
	if(pl_GetFileList(pTmp, &pList))
		return -1;
	pNxt= pList;
	while(MemComp((pFND=StrRFind(pNxt->pFileName, '.')), *(ppLst+1), 5)
			&& MemComp((pFND=StrRFind(pNxt->pFileName, '.')), *(ppLst+2), 5)
				&& MemComp((pFND=StrRFind(pNxt->pFileName, '.')), *(ppLst+3), 5)
					&& MemComp((pFND=StrRFind(pNxt->pFileName, '.')), *(ppLst+4), 5)
						&& MemComp((pFND=StrRFind(pNxt->pFileName, '.')), *(ppLst+5), 5)
							&& MemComp((pFND=StrRFind(pNxt->pFileName, '.')), *(ppLst+6), 5)){
		if(!(pNxt=(LPPL_BASE_FILE_LIST)pNxt->pNext))
			break;
	}
	if(!pNxt)
		return -1;
	else do{
		pFND= (StrRFind(pNxt->pFileName, '.')+3);
		if((*(pFND-2) != 'k' && *(pFND-1) == 'e' && *pFND == 'y') || (*(pFND-1) == 't' && *pFND == 'r')){
			if((iKey= CreateFileHandle(	pNxt->pFileName,
										ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0)) // GARANT_XXX
											== -1
				||
			ReadFromFile(iKey, &countCIB, sizeof(long)) != sizeof(long)
				||
			(mode == 1 && countCIB == BASE_DATA_VERSION && (countCIB= PL_HDD_SIGN) != PL_HDD_SIGN)
				||
			(mode == 2 && countCIB == PL_HDD_SIGN && (countCIB= BASE_DATA_VERSION) != BASE_DATA_VERSION)
				||
			SetFilePos(iKey, 0, ACE_OS_SEEK_SET) != 0
				||
			WriteInFile(iKey, &countCIB, sizeof(long)) != sizeof(long)
			){
				if(iKey != -1)
					CloseFileHandle(iKey);
				pl_FreeFileList(pList);
				return -1;
			}else{
				CloseFileHandle(iKey);
			}
		}
	}while((pNxt=(LPPL_BASE_FILE_LIST)pNxt->pNext));
	pl_FreeFileList(pList);
#endif
	return 0;
}
#endif

#if defined(PL_REPLCTR_FUNC)
	char *pl_getPassword(long Service_ID, long baseDate, long Client_ID, long *pRetRnd);
#endif

int pl_CreateFZ1Ex(	char *LicenseFileName, LPPL_FZ1_HDR pSourceMem, char *OutputFileName,
					char *LoginHDD, int process)
{
	int fh, len, allcSz= 0, currSz= 0, ii, szBf= 0, szBf0= 0,
		szAllocBf= 0, szAllocBf0= 0, sortBlngs, iStart, iEnd, iLogin, iPostHdr, iCurrHDD;
	long fSz, countPost= 0, countCIB=0, *pLong, lUpID, *pOffset
#ifndef RD_AS_ETALON
	#ifdef MAKE_HDD
		, remainder= -1
	#endif
		, *pDisks= 0, countDisks= 0, AllocDisks= 0
		, *pNumbers= 0, countNumbers= 0, AllocNumbers= 0, iPostSz, *pNewHeader= 0
	#ifndef PL_REPLCTR_FUNC
		, lNet
	#endif
#endif
		;
#if !defined(RD_AS_ETALON) && defined(WIN32) && defined(MAKE_HDD)
	long StoreClientID= 0;
	PL_UDDB_SERVICES *pSERVICE= 0;
#endif
	void *pMem;
	DWORD	ret, pFrands[PL_MAX_FRANDS_COUNT*SIZE_CRYPTO_KYE_PER_DWORD]
#ifndef RD_AS_ETALON
		, *pMediaID
#endif
		;
	char	*pTmp, *pchar, *pFirst= (char*)pSourceMem
#ifndef RD_AS_ETALON
		, *ppClients[PL_MAX_FRANDS_COUNT]
#endif
		;
	WORD	pSortBlngs[PL_MAX_FRANDS_COUNT*PL_MAX_BELNGS_COUNT], *pNextBelngs= 0, wDungle= 1;
	PBYTE	pBelngs, pBytes, pNewFsStructrs, pNewFsStructrs0= (PBYTE)pSourceMem;
	time_t checkpoint;
	short szstr, LoginServiceSz=0;

	char pLogin[LOGIN_SIZE_PER_BYTES], pLoginCp[LOGIN_SIZE_PER_BYTES],
		pLoginTmp[LOGIN_SIZE_PER_BYTES+1
#ifndef RD_AS_ETALON
			+ SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD)
#endif
		];

	LPPL_SDB_RECRD		pNext = 0, pService= 0, pCopyer= 0, pTmpR;
	LPPL_FZ1_POST_HDR	pPostHdr;
	LPPL_FZ1_CIB		pCIB, pRet, pCurrHDD_CIB;
	LPPL_FZ1_CIB_POST	pCIBPost;
	LPPL_FZ1_HDR		pSrcMem;

	LPPL_IMPORT_COMPLECT_DATA pEprt= 0;

#ifndef BRDR32
	if(FZ1_HDR_SIGN != pSourceMem->lSgntr && !process)
		return -9;
  #if !defined(RD_AS_ETALON) && !defined(INC_DONGLE_DLL) && defined(MAKE_HDD) && defined(PL_REPLCTR_FUNC) && defined(MULTI_INDEX_STREAM_FILE)
	if(process == 1 || process == 41){
		fSz= *(long*)LicenseFileName;
		if((pMem= alloc_in_heap((int)fSz+szBf)) == 0){
			return -5;
		}
		MemCopy(pMem, LicenseFileName + sizeof(long), (int)fSz);
	}else
  #endif
#endif
	{
		if((fh= CreateFileHandle( LicenseFileName, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
			return -4;
		}
		SetFilePos(	fh, 0l, ACE_OS_SEEK_END);	// seek to eof
		fSz= GetFilePos(fh);			// get file length
		SetFilePos(	fh, 0l, ACE_OS_SEEK_SET);	// seek to beginning
		if(fSz == 0){
			CloseFileHandle(fh);
			return -4;
		}
		if(process == 81){
			if((iEnd= CreateFileHandle( OutputFileName, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1){ // GARANT_XXX
				return -4;
			}
			SetFilePos(	iEnd, 0l, ACE_OS_SEEK_END);	// seek to eof
			szBf= (int)GetFilePos(iEnd);			// get file length
			SetFilePos(	iEnd, 0l, ACE_OS_SEEK_SET);	// seek to beginning
			if(fSz == 0){
				CloseFileHandle(iEnd);
				CloseFileHandle(fh);
				return -4;
			}
		}
		if((pMem= alloc_in_heap((int)fSz+szBf)) == 0){
			CloseFileHandle(fh);
			return -5;
		}
		if(ReadFromFile(fh, pMem, (int)fSz) != (int)fSz){
			CloseFileHandle(fh);
			free_in_heap(pMem);
			return -6;
		}
		CloseFileHandle(fh);
		if(process == 21 || process == 11){
			// Достаём крипто Заголовок из центра зашифрованного блока //
			char tttt[SIZE_CRYPTO_HEADER];
			MemCopy(tttt, (char*)pMem+ ((fSz-SIZE_CRYPTO_HEADER)/2), SIZE_CRYPTO_HEADER);
			MemCopy((char*)pMem+ ((fSz-SIZE_CRYPTO_HEADER)/2),
						(char*)pMem+fSz-SIZE_CRYPTO_HEADER, SIZE_CRYPTO_HEADER);
			MemCopy((char*)pMem+fSz-SIZE_CRYPTO_HEADER, tttt, SIZE_CRYPTO_HEADER);
		}
	}
	fh= 0;
	if(process == 81){
		pchar = (char*)((LPPL_UDDB_NAME)pSourceMem)->pMem;
		szstr= (short)(StrLength(pchar)&0x7fff);
	}else if(!process){
#if defined(PL_REPLCTR_FUNC) && !defined(BIG_TURTLE)
		CloseFileHandle(fh);
		free_in_heap(pMem);
		return -6;
#endif
#ifndef RD_AS_ETALON
		pCrptKy[2]= 0xffffffff;
#endif
		pchar= GetLoginSerivceFromMemBlockFZ1(pSourceMem, &LoginServiceSz);
		if(!LoginServiceSz){
			CloseFileHandle(fh);
			free_in_heap(pMem);
			return -673;
		}
		if(!*(short*)(pchar+LoginServiceSz)){
			CloseFileHandle(fh);
			free_in_heap(pMem);
			return -17;
		}
		szstr= LoginServiceSz;
	}else{
		pchar= OutputFileName;
		szstr= (short)(StrLength(OutputFileName)&0x7fff);
	}
#ifndef RD_AS_ETALON
	if(*(long*)pMem == MULTI_LCNS_SIGN && (pTmp= (char*)pMem)){
		char *pNxt7= pTmp + sizeof(long);
		long nxt7, first7= sizeof(long);
		short	szLogin7;
		do{
			nxt7= *(long*)pNxt7;
			szLogin7= *(short*)(pNxt7+sizeof(nxt7));
			if(	szLogin7 == szstr
					&& 
				!MemComp(pNxt7+sizeof(nxt7)+sizeof(szLogin7), pchar, szLogin7)){
				pNextBelngs= (WORD*)pTmp;
				pTmp= pNxt7+ sizeof(nxt7)+ sizeof(szLogin7) + szLogin7;
				if(nxt7){
					fSz = nxt7 - (first7 + sizeof(nxt7)+ sizeof(szLogin7) + szLogin7);
				}else{
					fSz = fSz - (first7 + sizeof(nxt7)+ sizeof(szLogin7) + szLogin7);
				}
				nxt7= -1;
				break;
			}
			pNxt7= (char*)pTmp + nxt7;
			first7= nxt7;
		}while(nxt7);
		if(nxt7 != -1){
			free_in_heap(pMem);
			UnLoadCryptoKey(&ret, 0);
			return -989;
		}else
			MemCopy(pMem, pTmp, fSz);
	}
#endif
	if(szstr < LOGIN_SIZE_PER_BYTES){
		MemSeting(pLogin, 0, LOGIN_SIZE_PER_BYTES);
		MemCopy(pLogin, pchar, (int)szstr);
	}else
		MemCopy(pLogin, pchar, LOGIN_SIZE_PER_BYTES);

	if(process == 21 || process == 11){
		local_sscanf2( (char*)pLogin, (PDWORD)pFrands, (PDWORD)pFrands+1);
#ifdef BRDR32
		((long*)pFrands)[0] ^= IsG6X_NDT[0];
		((long*)pFrands)[1] ^= IsG6X_NDT[1];
#endif
		LoadCryptoKey((char*)pFrands, 0);
	}else// if(process && process != 81)
		LoadCryptoKeyFromStr(pLogin, 0);
	//else LoadCryptoKey(pLogin, 0);
	
	UnCrypto((char*)pMem, (PDWORD)(&fSz));

	if((pTmp= (char*)pMem) == 0
		|| *((long*)pMem) == 0l){
		free_in_heap(pMem);
		UnLoadCryptoKey(&ret, 0);
		if(ret){
			return -49;
		}
		return -8;
	}
	if(process && process != 81){
		pSourceMem= (LPPL_FZ1_HDR)pMem;
#ifdef RD_AS_ETALON
		LoginServiceSz= pSourceMem->LoginServiceSz;
#endif
		if(FZ1_HDR_SIGN != pSourceMem->lSgntr
#ifdef RD_AS_ETALON
				||
			LoginServiceSz != 8
				||
			pSourceMem->LoginCopyerSz != 18259
#endif
			){
			free_in_heap(pMem);
			return -9;
		}
#ifndef BRDR32
		if(process != 21){
#endif
			UnLoadCryptoKey(&ret, 0);
			if(ret){
				free_in_heap(pMem);
				return -49;
			}
			pchar= GetLoginSerivceFromMemBlockFZ1(pSourceMem, &LoginServiceSz);
			ii= LoginServiceSz;
			// Проверяем правильность логина ТУ //
			if((process == 1 || process == 71) &&
				((len= (int)(StrLength(OutputFileName)&0x7fffffff)) != (int)*(short*)(pchar+ii)
							|| MemComp(OutputFileName, pchar+ii+sizeof(short),len))){
				free_in_heap(pMem);
				return -17;
			}
			if(process != 11
#ifdef BRDR32
					&& process != 21
#endif
					){
				szstr= ii;
				if(szstr < LOGIN_SIZE_PER_BYTES){
					MemSeting(pLoginCp, 0, LOGIN_SIZE_PER_BYTES);
					MemCopy(pLoginCp, pchar, (int)szstr);
				}else
					MemCopy(pLoginCp, pchar, LOGIN_SIZE_PER_BYTES);
				LoadCryptoKeyFromStr(pLoginCp, 0);
			}else{
				MemCopy(pLogin, OutputFileName, LOGIN_SIZE_PER_BYTES);
				pl_HashEx(pLogin);
				LoadCryptoKey(pLogin, 0);
				szstr= (short)(StrLength(OutputFileName)&0x7fff);
				MemCopy(pLogin, OutputFileName, LOGIN_SIZE_PER_BYTES);
#ifdef BRDR32
				OutputFileName= pFirst;
#endif
			}
			len= (int)*((short*)(pchar+ (int)LoginServiceSz));
			lUpID= *(long*)(pchar	+ sizeof(pSourceMem->LoginCopyerSz)
									+ (int)LoginServiceSz
									+ len
									+ sizeof(pSourceMem->lOffsetList)
									+ sizeof(pSourceMem->lCountList));
			// For clear memory //
			countPost= lUpID;
			countCIB= fSz;
			//
			fSz -= lUpID;
			pTmp += (int)lUpID;
			UnCrypto(pTmp, (PDWORD)(&fSz));
			if(fSz == 0l){
				free_in_heap(pMem);
				return -48;
			}
#ifndef RD_AS_ETALON
			if(process == 1){
				LicenseFileName= ((LPPL_UDDB_NAME)LoginHDD)->pTarget;
				pMediaID= (PDWORD)((LPPL_UDDB_NAME)LoginHDD)->pMem;
				LoginHDD= ((LPPL_UDDB_NAME)LoginHDD)->pSource;
				process= 1;
			}
#endif
			pchar = LoginHDD;
#ifdef MAKE_HDD
			if(process == 11){
				if((pchar= StrRFind(LicenseFileName, '.')) == 0
						||
					MemCopy(pchar+1, "ndt", 3) == 0
						||
					(fh= CreateFileHandle( LicenseFileName, ACE_OS_O_RDONLY | ACE_OS_O_BINARY, 0)) == -1 // GARANT_XXX
						||
					(int)SetFilePos(fh, 512-(int)(len=pl_GetLoginOffest()), ACE_OS_SEEK_SET)
								!= 512-len
						||
					ReadFromFile(fh, pFrands, LOGIN_SIZE_PER_BYTES) != LOGIN_SIZE_PER_BYTES)
				{
					if(fh != -1)
						CloseFileHandle(fh);
					free_in_heap(pMem);
					return -6;
				}
				CloseFileHandle(fh);
				len= LOGIN_SIZE_PER_BYTES;
				OutputFileName= LoginHDD;
				pchar = LoginHDD= (char*)pFrands;
				if(*pchar == 0){
					free_in_heap(pMem);
					return -16;
				}
			}else
#endif
			len= (int)(StrLength(LoginHDD)&0x7fffffff);
			pBytes= (PBYTE)pTmp;
#ifndef BRDR32
		}else{
			pchar= GetLoginSerivceFromMemBlockFZ1(pSourceMem, &LoginServiceSz);
			len= (int)*((short*)(pchar+ (int)LoginServiceSz));
			pchar += sizeof(pSourceMem->LoginCopyerSz) + (int)LoginServiceSz;
		}
#endif
	}else if(process == 81){
		pBytes= (PBYTE)pMem;
		pBelngs= (PBYTE)pMem + fSz;
		if(ReadFromFile(iEnd, pBelngs, szBf) != szBf){
			*(void**)((LPPL_UDDB_NAME)pSourceMem)->pSource= 0;
			CloseFileHandle(fh);
			free_in_heap(pMem);
			return -6;
		}
		CloseFileHandle(iEnd);
		UnCrypto((char*)pBelngs, (PDWORD)(&szBf));
		pchar = (char*)pBelngs+sizeof(short);
		len= *(short*)pBelngs;
		if(len < 1 || len > LOGIN_SIZE_PER_BYTES ||
				MemComp((char*)pBelngs+sizeof(short)+len+sizeof(long)+sizeof(short),
								pLogin, szstr)){
			*(void**)((LPPL_UDDB_NAME)pSourceMem)->pSource= 0;
			CloseFileHandle(fh);
			free_in_heap(pMem);
			return -673;
		}
	}else{
		pBytes= (PBYTE)pMem;
		if(pNextBelngs != 0)
			pMem= pNextBelngs;
		len= (int)*((short*)(pchar+ (int)LoginServiceSz));
		pchar += sizeof(pSourceMem->LoginCopyerSz) + (int)LoginServiceSz;
	}
	if(len < LOGIN_SIZE_PER_BYTES)
		MemSeting(pLoginCp, 0, LOGIN_SIZE_PER_BYTES);
	else
		len = LOGIN_SIZE_PER_BYTES;

	MemCopy(pLoginCp, pchar, len);
#ifndef BRDR32
	if(process != 21){
#endif
		if(MemComp(pTmp, UIDDB_STREAM_SIGN, SIZE_SYNHRO_PER_DWORD * sizeof(DWORD))){
			pSrcMem= (LPPL_FZ1_HDR)pTmp;
			if(process && FZ1_HDR_SIGN == pSrcMem->lSgntr){
				pBelngs= (PBYTE)GetLoginSerivceFromMemBlockFZ1(pSrcMem, &LoginServiceSz);
				lUpID= *(long*)(pBelngs	+ sizeof(pSrcMem->LoginCopyerSz)
										+ (int)LoginServiceSz
					+ (int)*((short*)(pBelngs+ (int)LoginServiceSz))
										+ sizeof(pSrcMem->lOffsetList)
										+ sizeof(pSrcMem->lCountList));
				pTmp += (int)lUpID;
				if(MemComp(pTmp, UIDDB_STREAM_SIGN, SIZE_SYNHRO_PER_DWORD * sizeof(DWORD))){
					free_in_heap(pMem);
					return -449;
				}
			}else if(process){
				free_in_heap(pMem);
				return -9;
			}else{
				free_in_heap(pMem);
				return -673;
			}
		}
		/*{
			SYSTEMTIME ttt;
			FILETIME ftm;
			DosDateTimeToFileTime(
				*(LPWORD)(pTmp + SIZE_SYNHRO_PER_DWORD * sizeof(DWORD)),
				*((LPWORD)(pTmp + SIZE_SYNHRO_PER_DWORD * sizeof(DWORD))+1),
				 &ftm);
			FileTimeToSystemTime(&ftm, &ttt);
		}*/
		pTmp += SIZE_SYNHRO_PER_DWORD * sizeof(DWORD) + sizeof(long);
		if(*(long*)pLoginCp == 0){
			pSourceMem= (LPPL_FZ1_HDR)pTmp;
		}
		if(!process || process == 81)
			pTmp += sizeof(long) + *(long*)pTmp;
#ifdef BRDR32
		else if(process == 21){
			pService= (LPPL_SDB_RECRD)pTmp;
			pSourceMem= (LPPL_FZ1_HDR)pMem; // GARANT_STDC
			pchar= GetLoginSerivceFromMemBlockFZ1(pSourceMem, &LoginServiceSz);
			len= (int)*((short*)(pchar+ (int)LoginServiceSz));
			pchar += sizeof(pSourceMem->LoginCopyerSz) + (int)LoginServiceSz;
		}
		if(process == 11){
#endif
		do{
			pNext= (LPPL_SDB_RECRD)pTmp;
			if(process != 41 && pCopyer == 0 && !MemComp(pNext->account.pLogin, pLoginCp, len)){
				pCopyer= pNext;
				if(process && process != 81){
					pchar= GetLoginSerivceFromMemBlockFZ1(pSourceMem, &LoginServiceSz);
					len= (int)*((short*)(pchar+ (int)LoginServiceSz));
					pchar += sizeof(pSourceMem->LoginCopyerSz) + (int)LoginServiceSz;
				}
			}else if(pService == 0 &&
						!MemComp(pNext->account.pLogin, pLogin, szstr)){
				pService= pNext;
#ifndef RD_AS_ETALON
				if(!process){
					pCrptKy[2]= pService->account.pId[0];
					if(pCopyer)
						pCopyer->account.pId[1]= pService->account.pId[0];
				}
#endif
				if(!process || process == 1 || process == 41 || process == 71 || process == 81){
					// Test Password //
					if(!process || process == 81)
						pFirst= LoginHDD;

					szstr= (short)(StrLength(pFirst)&0x7fff);
					if(szstr < LOGIN_SIZE_PER_BYTES){
						MemSeting(pLoginTmp, 0, PSSWRD_SIZE_PER_BYTES);
						MemCopy(pLoginTmp, pFirst, (int)szstr);
					}else
						MemCopy(pLoginTmp, pFirst, PSSWRD_SIZE_PER_BYTES);

					pl_HashEx(pLoginTmp);

					if(MemComp(pLoginTmp, pNext->account.pPsswrd, PSSWRD_SIZE_PER_BYTES)){
						free_in_heap(pMem);
						return -559;
					}
					if(process == 41 || process == 71){
						if(process == 71){
	if((fh= CreateFileHandle( ((LPPL_UDDB_NAME)LoginHDD)->pTarget, ACE_OS_O_CREAT | ACE_OS_O_TRUNC | ACE_OS_O_WRONLY | ACE_OS_O_BINARY, 0 )) == -1){ // GARANT_XXX
		return -3;
	}
	{
		free_in_heap(pMem);
		szstr= (short)((StrLength(pLogin)+sizeof(short))&0x7fff);
		if((pMem= alloc_in_heap(szstr+*(int*)((LPPL_UDDB_NAME)LoginHDD)->pSource+SIZE_CRYPTO_HEADER)) == 0){
			CloseFileHandle(fh);
			return -5;
		}
		*(short*)pMem= szstr-sizeof(short);
		MemCopy((char*)pMem+sizeof(short), pLogin, szstr-sizeof(short));
		MemCopy((char*)pMem+szstr, ((LPPL_UDDB_NAME)LoginHDD)->pMem, *(int*)((LPPL_UDDB_NAME)LoginHDD)->pSource);
		*(int*)((LPPL_UDDB_NAME)LoginHDD)->pSource += szstr;
		EnCrypto((char*)pMem, (PDWORD)((LPPL_UDDB_NAME)LoginHDD)->pSource);
		((LPPL_UDDB_NAME)LoginHDD)->pMem= pMem;
	}
	if(WriteInFile(fh, ((LPPL_UDDB_NAME)LoginHDD)->pMem, *(int*)((LPPL_UDDB_NAME)LoginHDD)->pSource) !=
								*(int*)((LPPL_UDDB_NAME)LoginHDD)->pSource){
		return -2;
	}
	free_in_heap(pMem);
	CloseFileHandle(fh);
	return 0;
						}else{
							*(int*)((LPPL_UDDB_NAME)LoginHDD)->pSource= fSz;
							MemSeting((char*)pMem+countPost, 0, countCIB-countPost);
							((LPPL_UDDB_NAME)LoginHDD)->pMem= pMem;
						}
						return 0;
					}
					pFirst= (char*)pSourceMem;
				}
			}
		}while(pNext->offset_to_next != 0l && (pService == 0 || pCopyer == 0) &&
				(pTmp = (char*)pBytes+ pNext->offset_to_next) != 0);

		if(*(long*)pLoginCp == 0){
			ret= 0;
			len= (int)*(long*)pFirst;
			pFirst += sizeof(long);
			*((char**)OutputFileName)= (char*)alloc_in_heap(len+1);
			if(*(char**)OutputFileName == 0)
				ret= -5;
			else{
				MemCopy(*(char**)OutputFileName, pFirst, len);
				(*(char**)OutputFileName)[len]= 0;
			}
			free_in_heap(pMem);
			return ret;
		}else if(pService == 0 || pCopyer == 0){
			free_in_heap(pMem);
			return -116;
		}
		NormalizeSDBRecord(pService);
		NormalizeSDBRecord(pCopyer);

#if !defined(RD_AS_ETALON) && !defined(BRDR32)
		if(pl_ServiseIsValid(pService, pCopyer)){
			free_in_heap(pMem);
			return -117;
		}
#endif
	}else if(MemComp(pFirst, pchar, len)){
		UnLoadCryptoKey(&ret, 0);
		free_in_heap(pMem);
		return -116;
	}
	UnLoadCryptoKey(&ret, 0);
	if(ret){
		free_in_heap(pMem);
		return -49;
	}
	if(process == 81){
		MemCopy(pMem, pBelngs+len+sizeof(short), szBf-len-sizeof(short));
		*(void**)((LPPL_UDDB_NAME)pSourceMem)->pSource= pMem;
		return 0;
	}
  do{
	pPostHdr= (LPPL_FZ1_POST_HDR)((char*)pSourceMem + *(long*)(pchar + len));
	countPost= *(pOffset= (long*)(pchar + len + sizeof(long)));
	if(countPost < 1){
		free_in_heap(pMem);
		return -671;
	}
	pOffset++;
		
	while(countPost--){

		pNextBelngs= 0;
		if(process)
			pCurrHDD_CIB= (LPPL_FZ1_CIB)pSourceMem;
		else
			pCurrHDD_CIB= 0;

		if(FZ1_POST_HDR_SIGN != pPostHdr->lSgntr){
			free_in_heap(pMem);
#ifndef RD_AS_ETALON
			free_in_heap(pNumbers);
			free_in_heap(pDisks);
#endif
			return -115;
		}
		if(pPostHdr->lCountList < PL_MAX_FRANDS_COUNT){
#ifndef RD_AS_ETALON
  #ifndef PL_REPLCTR_FUNC
	lNet= 0;
  #endif
	MemSeting(ppClients, 0, sizeof(char*)*PL_MAX_FRANDS_COUNT)
#endif
			;
		}else{
			free_in_heap(pMem);
#ifndef RD_AS_ETALON
			free_in_heap(pNumbers);
			free_in_heap(pDisks);
#endif
			return -675;
		}
#if !defined(RD_AS_ETALON) && defined(MAKE_HDD) && defined(WIN32)
		if(process == 3){
			if(countNumbers == AllocNumbers){
				AllocNumbers += 64;
				pRet= (LPPL_FZ1_CIB)alloc_in_heap(AllocNumbers*2*sizeof(long));
				if(pRet == 0){
					free_in_heap(pNumbers);
					free_in_heap(pDisks);
					free_in_heap(pMem);
					return -5;
				}
				if(pNumbers){
					MemCopy(pRet, pNumbers, countNumbers*2*sizeof(long));
					free_in_heap(pNumbers);
				}
				pNumbers= (long*)pRet;
			}
			process= countNumbers*2;
			while(process){
				process -= 2;
				if(pNumbers[process] == pPostHdr->lNumber){
					process++;
					pNumbers[process]+=pPostHdr->lCountList;
					break;
				}
			}
			if(!process){
				pNumbers[countNumbers*2]= pPostHdr->lNumber;
				pNumbers[countNumbers*2+1]= pPostHdr->lCountList;
				countNumbers++;
			}
#if !defined(RD_AS_ETALON) && defined(WIN32) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL) && defined(STORE_HDD_MEDIA)
			if(	!pSERVICE->NotSavedMediaID_lCD && pPostHdr->lCDNumber){
				if(countDisks == AllocDisks){
					AllocDisks += 64;
					pRet= (LPPL_FZ1_CIB)alloc_in_heap(AllocDisks*2*sizeof(long));
					if(pRet == 0){
						free_in_heap(pNumbers);
						free_in_heap(pDisks);
						free_in_heap(pMem);
						return -5;
					}
					if(pDisks){
						MemCopy(pRet, pDisks, countDisks*2*sizeof(long));
						free_in_heap(pDisks);
					}
					pDisks= (long*)pRet;
				}
				process= countDisks*2;
				while(process){
					process -= 2;
					if(pDisks[process] == pPostHdr->lCDNumber){
						process++;
						if(pPostHdr->lProtectType == PL_HASP_FLAG)
							pDisks[process] += pPostHdr->lCountList;
						if(remainder != -1){
							pSERVICE->NotSavedMediaID_lCD= 1;
							countPost= 0;
							countCIB= 0;
						}
						break;
					}
				}
				if(!process){
					pDisks[countDisks*2]= pPostHdr->lCDNumber;
					if(pPostHdr->lProtectType == PL_HASP_FLAG)
						pDisks[countDisks*2+1]= pPostHdr->lCountList;
					else
						pDisks[countDisks*2+1]= 0;
					countDisks++;
				}
			}
#endif
			process= 3;
		}
#endif
		countCIB= pPostHdr->lCountList;
		pRet= pCIB= (LPPL_FZ1_CIB)((char*)pPostHdr	+ sizeof(PL_FZ1_POST_HDR)
													+ pPostHdr->NameServiceSz);
#ifndef RD_AS_ETALON
		pRet= pCIB= (LPPL_FZ1_CIB)
			((char*)pCIB + *(short*)pCIB + sizeof(short) + sizeof(long));
#endif
		lUpID= PL_MAX_HDD_NUMBER;
		while(countCIB--){
			if(	lUpID == PL_MAX_HDD_NUMBER ){
				if((ret= pl_GetNextCIB(&pRet, &pCIBPost, &pBelngs, process))){
					if(currSz){
						free_in_heap(pTmpR);
					}
#ifndef RD_AS_ETALON
					free_in_heap(pNumbers);
					free_in_heap(pDisks);
#endif
					free_in_heap(pMem);
					return ret;
				}
#if !defined(RD_AS_ETALON) && defined(MAKE_HDD) && defined(WIN32)
		if(	pPostHdr->lProtectType == PL_HASP_FLAG ||
			(pPostHdr->lProtectType & 0xffff) == PL_FLP_FLAG ||
			pPostHdr->lProtectType == PL_PASS_FLAG);
		else{
			free_in_heap(pMem);
#ifndef RD_AS_ETALON
			free_in_heap(pNumbers);
			free_in_heap(pDisks);
#endif
			return -125;
		}
		if( pCIBPost->lInstall == PL_WORK_FLAG && pPostHdr->lCountList == 1
			&& pPostHdr->lTransprtType == 0 && pPostHdr->lProtectType == PL_HASP_FLAG)
			;
		else if(pCIBPost->lInstall != PL_WORK_FLAG && pPostHdr->lCountList > 0)
			;
		else{
			free_in_heap(pMem);
#ifndef RD_AS_ETALON
			free_in_heap(pNumbers);
			free_in_heap(pDisks);
#endif
			return -126;
		}
		if(	pPostHdr->lTransprtType == 0 || pPostHdr->lTransprtType == 1)
		;
		else{
#ifndef RD_AS_ETALON
			free_in_heap(pNumbers);
			free_in_heap(pDisks);
#endif
			free_in_heap(pMem);
			return -127;
		}
#endif
			}
			pLong= (long*)((char*)pCIB + sizeof(*pCIB) + pCIB->NameClientSz);
			if(pPostHdr->lCDNumber >= PL_MAX_HDD_NUMBER){
				fh= pPostHdr->lCDNumber;
				pPostHdr->lCDNumber= 0;
			}
	if(	!process
			// Export CIB Names
			|| process == 21
			// Find selected HDD //
#ifdef MAKE_HDD
			// Find first CIB for selected HDD //
			|| ((remainder == -1 || remainder == fSz) && process == 3
							&&	(	(pPostHdr->lCDNumber	&& fSz == countPost)
	|| (pCIBPost->lInstall == PL_WORK_FLAG && fh == countPost && (fSz= *pLong))
	|| (pCIBPost->lInstall != PL_WORK_FLAG && fSz == countPost && (fSz= *pLong))
											))
			|| (process == 1
					&& !MemComp(	((char*)pLong	// add size for CIB ID //
												+ sizeof(long)
												// add size for CIB ID //
												+ sizeof(pCIB->NameClientSz)),
								pLoginCp, LOGIN_SIZE_PER_BYTES))
			|| (process == 11
					&& !MemComp(	((char*)pLong	// add size for CIB ID //
												+ sizeof(long)
												// add size for CIB ID //
												+ sizeof(pCIB->NameClientSz)),
								OutputFileName, LOGIN_SIZE_PER_BYTES))
#else
			|| ((process == 1 || process == 11)
					&& !MemComp(	((char*)pLong	// add size for CIB ID //
												+ sizeof(long)
												// add size for CIB ID //
												+ sizeof(pCIB->NameClientSz)),
								pLoginCp, LOGIN_SIZE_PER_BYTES))
#endif
								
								){
		if(process == 1){
#if !defined(RD_AS_ETALON) && defined(WIN32) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
	////////////
	process= CountSERVICES;
	while(process){
		process--;
		if(!MemComp(	pSERVICES[process].Service_ID,
						Crypto_TAG,
						SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD))
						&& pPostHdr->lNumber <= pSERVICES[process].MaxNumber){
				pSERVICE= pSERVICES+process;
				process++;
				break;
			}
	}
	if(!process){
		if(CountSERVICES + 1 > AllocSERVICES){
			AllocSERVICES += 222;
			pMediaID= (PDWORD)alloc_in_heap(
									AllocSERVICES*sizeof(PL_UDDB_SERVICES));
			if(pMediaID == 0){
				return -5;
			}
			MemCopy(pMediaID, pSERVICES, CountSERVICES * sizeof(PL_UDDB_SERVICES));
			MemSeting((char*)pMediaID+ CountSERVICES * sizeof(PL_UDDB_SERVICES), 0,
						(AllocSERVICES-CountSERVICES) * sizeof(PL_UDDB_SERVICES));
			free_in_heap(pSERVICES);
			pSERVICES= (LPPL_UDDB_SERVICES)pMediaID;
		}
		pSERVICE= pSERVICES+CountSERVICES;
		MemCopy(pSERVICE->Service_ID,
				Crypto_TAG, SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD));
		pSERVICE->MaxNumber= -1;
		pSERVICE->lAllocMediaIDs= 222;
		if((pBytes= (char*)alloc_in_heap(pSERVICE->lAllocMediaIDs*sizeof(long)))
				== 0){
			return -5;
		}
		pSERVICE->pMediaIDs= (long*)pBytes;
		pSERVICE->lCountMediaIDs= 0;
		CountSERVICES++;
	}
	////////////
#endif
			process= 2;
			break;
		}
#if defined(PL_REPLCTR_FUNC) || defined(BRDR32)
		else if(process == 11){
  #ifdef BRDR32
			pBytes= (PBYTE)StrRFind(LicenseFileName, '.');
			*pBytes= '\0';
			pTmp= StrRFind(OutputFileName, '\0');
			*pTmp= '*';pTmp++;
			*pTmp= ':';pTmp++;
	#if defined(RD_AS_ETALON) || defined(NOT_RD)
			ii= *((short*)sel_Belngs);
			MemCopy(pTmp, sel_Belngs+sizeof(short), ii);
	#else
			ii= *((short*)pBelngs - 1);
			MemCopy(pTmp, pBelngs, ii);
	#endif
			pTmp[ii]= '\n';ii++;
			pTmp[ii]= '\0';
  #else
			pTmp= OutputFileName + StrLength(OutputFileName) + 1;
			pCrptKy[0]= CryptoTick() & 0xfff;
			pBytes= (PBYTE)pl_getPassword(	pCopyer->account.pId[0] & (0xffffffff>>17), 384, pPostHdr->lNumber, (long *)pCrptKy);
			MemCopy(pTmp, pBytes, StrLength((const char *)pBytes)+1);
			HashDWORD((PDWORD)&pCIB->lID);
			pCrptKy[0]= (DWORD)pCIB->lID;
			pCrptKy[1]= pCopyer->account.pId[0];
  #endif
			if(currSz){
				free_in_heap(pTmpR);
			}
			pl_freeBlngsTbls(pNext, currSz);
			free_in_heap(pMem);
  #ifndef RD_AS_ETALON
					if(pNumbers)
						free_in_heap(pNumbers);
					if(pDisks)
						free_in_heap(pDisks);
  #endif
			return 0;
		}
#endif
	////////
#ifdef BRDR32
		if(process == 21){
			LPPL_IMPORT_CIB_DATA		pCIBs;
			LPPL_IMPORT_COMPLECT_DATA	pNextC= 0;
			char *pNewStruct, *pOtherStat;
			// Login size //
			len= (int)*(short*)(pLong+1);
			// CIB Name size //
			ii=(int) *(short*)((char*)(pLong+1) + sizeof(short) + len);
			// size belongs string //
			process= (int) *(short*)(pNewStruct= ((char*)(pLong+1) + sizeof(short) + len
							 + sizeof(short) + ii
							 + sizeof(long)*6 + sizeof(short) +
							 (int) *(short*)((char*)(pLong+1) + sizeof(short) + len
							 + sizeof(short) + ii
							 + sizeof(long)*6)));
  #ifndef RD_AS_ETALON
			if(*(short*)(pNewStruct + sizeof(short) + process)){
				int iLen;
				iLen= *(short*)(pNewStruct + sizeof(short) + process + sizeof(short));
				*(pNewStruct + sizeof(short) + process)= '~';
				MemCopy(pNewStruct + sizeof(short) + process + 1,
						pNewStruct + sizeof(short) + process + sizeof(short) + sizeof(short),
						iLen);
				*(pNewStruct + sizeof(short) + process + 1 + iLen)= ',';
				process += iLen;
				iLen= *(short*)(pNewStruct + sizeof(short) + process + sizeof(short) + sizeof(short));
				MemCopy(pNewStruct + sizeof(short) + process + 2,
						pNewStruct + sizeof(short) + process + sizeof(short) + sizeof(short) + sizeof(short),
						iLen);
				pOtherStat= pNewStruct + sizeof(short) + process + sizeof(short) + sizeof(short) + sizeof(short) + iLen;
				process += iLen + 2;
			}
  #endif
			if((pCIBs= (LPPL_IMPORT_CIB_DATA)alloc_in_heap(sizeof(PL_IMPORT_CIB_DATA))) == 0
						||
				(pCIBs->Alias= (char*)alloc_in_heap(pCIB->NameClientSz + len + ii
					+ process + 30 + 5*4 + 32*1024	)) == 0 ||
					
					(pCIBs->pLogin= (char*)alloc_in_heap(len+1)) == 0){
				if(szBf)
					free_in_heap(pNewFsStructrs);
				free_in_heap(pMem);
  #ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
  #endif
				return -5;
			}
			MemCopy(pCIBs->Alias, (char*)pCIB+sizeof(*pCIB), pCIB->NameClientSz);
			pCIBs->Alias[pCIB->NameClientSz] = 0;//'(';
			MemCopy(pCIBs->Alias + pCIB->NameClientSz + sizeof(char),
					(char*)(pLong+1) + sizeof(short) + len + sizeof(short), ii);
			pCIBs->Alias[pCIB->NameClientSz + sizeof(char) + ii] = 0;//')';
			MemCopy(pCIBs->Alias + pCIB->NameClientSz + sizeof(char)
						+ ii + sizeof(char), pNewStruct + sizeof(short), process);
			pCIBs->Alias[	pCIB->NameClientSz
										+ sizeof(char) + ii + sizeof(char)
										+ process] = '\0';
#ifndef RD_AS_ETALON
			ii += pCIB->NameClientSz;
			HashDWORD((unsigned long*)&pCIB->lID);
			process += sizeof(char) + ii + sizeof(char) + 1;
			// Клиент инсталлятора - Комплект
			*(long*)(pCIBs->Alias+process)
				= *(long*)((char*)pCIB+sizeof(*pCIB)+pCIB->NameClientSz);
			process += sizeof(long);
			*(long*)(pCIBs->Alias+process)= 0;
			if(pCIBPost->lInstall == PL_VIP_FLAG){
				*(long*)(pCIBs->Alias+process)= PL_VIP_FLAG;
			}else if((pPostHdr->lProtectType & 0xffff) == PL_FLP_FLAG){
				*(long*)(pCIBs->Alias+process)= pPostHdr->lProtectType;
			}else if(pPostHdr->lProtectType == PL_HASP_FLAG){
				*(long*)(pCIBs->Alias+process)= PL_HASP_FLAG;
			}
			if(pCIBPost->lInstall != PL_WORK_FLAG){
				int SzMove= 8*4;
				// Export ID Service //
				*(long*)(pCIBs->Alias+process+sizeof(long))= pService->account.pId[0];
				// Export ID Complect //
				*(long*)(pCIBs->Alias+process+sizeof(long)+sizeof(long))=
	//				*(long*)((char*)pCIB+sizeof(*pCIB)+pCIB->NameClientSz)
	//				Номер заказа и порядковое как позиция 
					pPostHdr->lNumber | ((pPostHdr->lCountList - (countCIB+1)) << (32-7))
					;
	// Export Net Type //
	*(long*)(pCIBs->Alias+process+sizeof(long)+sizeof(long)+sizeof(long))=
		pCIBPost->lFloppyCount;
	// Export ID User //
	*(long*)(pCIBs->Alias+process+sizeof(long)+sizeof(long)+sizeof(long)+sizeof(long))=
		pCIB->lID;
	// Export delivery type //
	if((pCIBPost->lDemo & 0xffff) == PL_TRIAL_FLAG){
		*(long*)(pCIBs->Alias+process+sizeof(long)+sizeof(long)+sizeof(long)+sizeof(long)+sizeof(long))=
				pCIBPost->lDemo;
	}else if(pCIBPost->lDemo == PL_FREE_FLAG){
		*(long*)(pCIBs->Alias+process+sizeof(long)+sizeof(long)+sizeof(long)+sizeof(long)+sizeof(long))=
				PL_FREE_FLAG;
	}
	// Максимальное колличество одновременно работающих пользователей и всё, всё ... всё //
	if(((long*)pOtherStat)[5] >= 3020400){
		*(long*)(pOtherStat+4*4)= *(long*)(pOtherStat+SzMove);SzMove += 4;

		// ID Flash-накопителя
		if( ((short*)(pOtherStat+SzMove))[0] > 0) SzMove += 2 + ((short*)(pOtherStat+SzMove))[0];
		else SzMove += 2;
		// Пробные блоки
		if( ((short*)(pOtherStat+SzMove))[0] > 0) SzMove += 2 + ((short*)(pOtherStat+SzMove))[0];
		else SzMove += 2;
		// Номер карточки РП
		if( ((short*)(pOtherStat+SzMove))[0] > 0) SzMove += 2 + ((short*)(pOtherStat+SzMove))[0];
		else SzMove += 2;
		MemCopy(pOtherStat+5*4,pOtherStat+SzMove,2 + (0x7fff & ((short*)(pOtherStat+SzMove))[0]));
		SzMove= 5*4 + 2 + (0x7fff & ((short*)(pOtherStat+SzMove))[0]);
	}else{
		*(long*)(pOtherStat+4*4)= 0;
		*(short*)(pOtherStat+5*4)= 0;
		SzMove= 5*4+2;
	}
	MemCopy(pCIBs->Alias+process+4+4+4+4+4+4, pOtherStat, SzMove);
			}
#endif
			MemCopy(pCIBs->pLogin,(short*)(pLong+1) + 1, len);
			pCIBs->pLogin[len]= '\0';
			//
			MemSeting(pLoginTmp, 0, SIZE_SYNHRO_PER_DWORD*sizeof(DWORD));
			MemCopy(pLoginTmp, &pCIB->lID, sizeof(long));
			pl_HashEx(pLoginTmp);
			pCIBs->next= 0;

			if(pEprt != 0){
				LPPL_IMPORT_COMPLECT_DATA pNextNew= pEprt;
				pNextC= pEprt;
				do{
					if(*(long*)pLoginTmp == *(long*)pNextC->Key){
						LPPL_IMPORT_CIB_DATA pNxt= pNextC->pCIBs;
						while(pNxt->next != 0)
							pNxt= (LPPL_IMPORT_CIB_DATA)pNxt->next;
						pNxt->next= pCIBs;
						pNextNew= 0;
					}
				}while(pNextC->next != 0 && (pNextC= (LPPL_IMPORT_COMPLECT_DATA)pNextC->next) != 0);
				if(pNextNew != 0){
					if((pNextNew= (LPPL_IMPORT_COMPLECT_DATA)alloc_in_heap(
							sizeof(PL_IMPORT_COMPLECT_DATA)*pPostHdr->lCountList)) == 0){
						if(szBf)
							free_in_heap(pNewFsStructrs);
						free_in_heap(pMem);
#ifndef RD_AS_ETALON
						free_in_heap(pNumbers);
						free_in_heap(pDisks);
#endif
						return -5;
					}
					pNextC->next= pNextNew;
					pNextC= pNextNew;
					pNextC->pCIBs= pCIBs;
					MemCopy(pNextC->Key, pLoginTmp, SIZE_SYNHRO_PER_DWORD*sizeof(DWORD));
				}
			}else{
			  if((*(LPPL_IMPORT_COMPLECT_DATA *)LoginHDD= 0) == 0 &&
				(*(LPPL_IMPORT_COMPLECT_DATA *)LoginHDD= pEprt= (LPPL_IMPORT_COMPLECT_DATA)alloc_in_heap(
					sizeof(PL_IMPORT_COMPLECT_DATA)*pPostHdr->lCountList)) == 0){
				if(szBf)
					free_in_heap(pNewFsStructrs);
				free_in_heap(pMem);
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				return -5;
			  }
			  pNextC= pEprt;
			  pNextC->pCIBs= pCIBs;
			  MemCopy(pNextC->Key, pLoginTmp, SIZE_SYNHRO_PER_DWORD*sizeof(DWORD));
			}
			pNextC->next= 0;
			//
			pCIB= pRet;
			ii= 0;
			currSz--;
			if(pPostHdr->lCDNumber == 0l)
				countCIB= 0;
			process= 21;
		}else
#endif
			{
			if(currSz == allcSz){
				allcSz += PL_ALLOC_STEP;
				if((pTmpR= (LPPL_SDB_RECRD)alloc_in_heap(sizeof(PL_SDB_RECRD) * allcSz)) == 0){
					if(szBf)
						free_in_heap(pNewFsStructrs);
					if(currSz)
						free_in_heap(pNext);
					free_in_heap(pMem);
#ifndef RD_AS_ETALON
					free_in_heap(pNumbers);
					free_in_heap(pDisks);
#endif
					return -5;
				}
				if(currSz){
					MemCopy(pTmpR, pNext, sizeof(PL_SDB_RECRD) * currSz);
					free_in_heap(pNext);
				}
				pNext= pTmpR;
			}
			// Analize CIB //
			/////////////////
			*(short*)(pLong + 1) = LOGIN_SIZE_PER_BYTES;
			if(	lUpID == PL_MAX_HDD_NUMBER ){
				*pLong += lUpID;
				if(!process)
					fSz= *pLong;

				pNext[currSz].pFrands= pFrands;

			}else{
				if(pPostHdr->lCDNumber != 0l)
					// ID for HDD //
					pLong= &lUpID;
				// else // For Installed CDROM // (*pLong == fSz) = OK;
				iCurrHDD= currSz;
			}
			pNext[currSz].frandsCount= 1l;
			pNext[currSz].pFrands= pCopyer->account.pId;

		if(!*((short*)pBelngs-1)){
			// Пустышка вместо логина //
			MemCopy(pLoginTmp, "Пустышка", 8);
		}else{
			// Generate AutoLogin //
			if(process == 3 && !currSz){
				local_sscanf2(pLoginCp, (PDWORD)pLoginTmp, (PDWORD)pLoginTmp+1);
			}else{
				*(PDWORD)pLoginTmp= CryptoTick();
				*(PDWORD)(pLoginTmp+3)= CryptoTick();
				*(PDWORD)(pLoginTmp+6)= CryptoTick();
			}
		}
			local_sprintfX( pLoginTmp,	((PDWORD)pLoginTmp)[0], ((PDWORD)pLoginTmp)[1]);
			// Update in UIDDB Record //
			MemCopy(pNext[currSz].account.pLogin, pLoginTmp, LOGIN_SIZE_PER_BYTES);
			// Generate AutoPassword //
			StrReverse(pLoginTmp);
			pl_HashEx(pLoginTmp);

			MemCopy(pNext[currSz].account.pPsswrd, pLoginTmp, (ii=PSSWRD_SIZE_PER_BYTES));
			pNext[currSz].account.Attrib.BelngsSize= (BYTE)0;
			pNext[currSz].account.Attrib.pTable= 0;
#ifndef RD_AS_ETALON
			if(process == 3){
				pNext[currSz].account.pId[0]= (pService->account.pId[0] << 17) | pService->account.pId[1];
#if defined(WIN32) && defined(MAKE_HDD)
				if(pCIBPost->lInstall == PL_WORK_FLAG){
					StoreClientID= pCIB->lID;
					StoreClientID |= 0x80000000;
				}
#endif
				pNext[currSz].account.pId[1]=
					*(PDWORD)(pCIB+sizeof(PL_FZ1_CIB)+pCIB->NameClientSz);
			}
#endif
			///////////////////////////
			if(pCurrHDD_CIB == 0){
				lUpID= pPostHdr->lCDNumber;
				pCurrHDD_CIB= pCIB;
				countCIB++;
			}else{
#ifndef RD_AS_ETALON
  #ifndef PL_REPLCTR_FUNC
	lNet |= pCIBPost->lNet;
  #endif
	for(ii= 0; ppClients[ii]; ii++){
		if(*(short*)ppClients[ii] == 
			*(short*)((char*)pCIB + sizeof(*pCIB) - sizeof(pCIB->NameClientSz))
				&&
			!MemComp(	ppClients[ii]+sizeof(short),
		(char*)pCIB + sizeof(*pCIB) - sizeof(pCIB->NameClientSz) + sizeof(short)
						,*(short*)ppClients[ii]))
				break;// Такой клиент уже внесён в список //
	}
	if(!ppClients[ii])
		ppClients[ii]
			= (char*)pCIB + sizeof(*pCIB) - sizeof(pCIB->NameClientSz);
	ii= PSSWRD_SIZE_PER_BYTES;
#endif
				if(lUpID != PL_MAX_HDD_NUMBER){
					pNextBelngs= pSortBlngs;
					if(sortBlngs){
						do{
							local_sscanf((char*)pBelngs, &ii);
							*pNextBelngs= (WORD)ii;
							pNextBelngs++;
							if(ii > 99)
								ii=3;
							else if(ii > 9)
								ii=2;
							else
								ii=1;
						}while(pBelngs[ii] != '\0' && (pBelngs += ii+1) != 0);
						pBelngs += ii;
						// Restore Format FZ1 //
						for(ii= sortBlngs; ii; ii--, pBelngs--)
							*pBelngs= *(pBelngs-1);
						*(short*)(pBelngs - 1)= sortBlngs;
					}
					ii= 0;
				}else if(pPostHdr->lCDNumber && process != 3){
#ifndef NOT_SORT_BELONGS
					if(!process)
						QSortStringInputedBelongs(pNextBelngs, (char *)pBelngs); // GARANT_STDC
#endif
					// Make belongs string for parser  //
					sortBlngs= (int)*((short*)pBelngs - 1);
					MemCopy(pBelngs - 1, pBelngs, sortBlngs);
					pBelngs--;
					pBelngs[sortBlngs]= '\0';
					/////////////////////////////////////
				}
				lUpID= PL_MAX_HDD_NUMBER;
				pCIB= pRet;
			}
		}
			///////////////////////////
			if(	ii == PSSWRD_SIZE_PER_BYTES ){
				// Update in Buffers //
				len= (int)((short*)pLong + 3)-(int)pFirst;
				if(pNextBelngs != 0){
					do{
						local_sscanf((char*)pBelngs, &ii);
						*pNextBelngs= (BYTE)ii;
						pNextBelngs++;
						if(ii > 99)
							ii=3;
						else if(ii > 9)
							ii=2;
						else
							ii=1;
					}while(pBelngs[ii] != '\0' && (pBelngs += ii+1) != 0);
					pBelngs += ii;
					// Restore Format FZ1 //
					for(ii= sortBlngs; ii; ii--, pBelngs--)
						*pBelngs= *(pBelngs-1);
					*(short*)(pBelngs - 1)= sortBlngs;
					////////////////////////
				}else{
					iStart= szBf;
					iLogin= iStart + 
#ifndef RD_AS_ETALON
						(int)&pCIB->NameClientSz -(int)pFirst
#else
						len
#endif
						;
#ifndef NOT_SORT_BELONGS
					if(!process)
						QSortStringInputedBelongs(pSortBlngs, (char *)pBelngs); // GARANT_STDC
#endif
					iPostHdr= ((int)pPostHdr - (int)pFirst);
				}
#if !defined(RD_AS_ETALON) && defined(MAKE_HDD) && defined(WIN32)
				if(process == 3){
					remainder= countPost;
					if(!pPostHdr->lCDNumber)
						countPost= 0;
  ///////////////////
  if(*(PDWORD)pFirst == FZ1_POST_HDR_SIGN){
	// Первая запись в копию ФЗ для UID //
	process= countNumbers*2;
	while(process){
		process -= 2;
		if(pNumbers[process] == pPostHdr->lNumber){
			process++;
			break;
		}
	}
	if(!process){
		free_in_heap(pNumbers);
		free_in_heap(pDisks);
		if(currSz)
			free_in_heap(pNext);
		free_in_heap(pMem);
		return -5;
	}
	pNewHeader= (long*)pFirst + 1;
	*pNewHeader |= pNumbers[process] -	(pPostHdr->lCountList << (32-7));
#if !defined(RD_AS_ETALON) && defined(MAKE_HDD) && defined(WIN32) && defined(INC_)
	if(pSERVICE->MaxNumber != -1){
		free_in_heap(pNumbers);
		pNumbers= 0;
	}
#endif
	if(pCIBPost->lInstall != PL_WORK_FLAG){
#ifdef STORE_HDD_MEDIA
		if(	pPostHdr->lCDNumber){
			// Учитываем ранее размещённые ППД на данном ЛН //
			process= countDisks*2;
			while(process){
				process -= 2;
				if(pDisks[process] == pPostHdr->lCDNumber){
					process++;
					break;
				}
			}
			if(!process){
				free_in_heap(pDisks);
				free_in_heap(pNext);
				free_in_heap(pMem);
				return -5;
			}
			//*(pNewHeader+3) |= pDisks[process] - pPostHdr->lCountList << (32-7);
			if(pDisks[process]-pPostHdr->lCountList)
				pSERVICE->NotSavedMediaID_lCD= -2;
			if(pSERVICE->MaxNumber != -1){
				free_in_heap(pDisks);
				pDisks= 0;
			}
		}
#endif
		// Формировать Заголовок для Инсталляционного ППД //
		process= 3333;
	}else
		process= 3;
  }
  ///////////////////
				}
  ///////////////////
  if(process == 3333){
	char xxx[]="[Login:;Password:]";
	int zzz= sizeof(long)*8;
	short *pSize= (short*)(pNewFsStructrs + szBf + zzz);
	zzz += *(short*)(pFirst+zzz) + sizeof(short);

	if(pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pFirst, zzz) != zzz
		||
	(pSize[0] += 7+10+1+ LOGIN_SIZE_PER_BYTES + *(short*)pSourceMem) == 0
		||
	pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, xxx, 7) != 7
		||
	pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pNext[currSz].account.pLogin, LOGIN_SIZE_PER_BYTES) != LOGIN_SIZE_PER_BYTES
		||
	pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, xxx+7, 10) != 10
		||
	pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, (char*)pSourceMem+2, *(short*)pSourceMem) != *(short*)pSourceMem
		||
	pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, xxx+17, 1) != 1
		||
	pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pFirst+zzz, len-zzz) != len-zzz
		){
		if(currSz)
			free_in_heap(pNext);
		free_in_heap(pMem);
		return -2;
	}
	process= 3;
	pOffset= (long*)((char*)pOffset + *(short*)pSourceMem - *((short*)pchar-1));
  }else
  ///////////////////
#endif
				{
					if(pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pFirst, len) != len){
						if(currSz)
							free_in_heap(pNext);
						free_in_heap(pMem);
	#ifndef RD_AS_ETALON
						free_in_heap(pNumbers);
						free_in_heap(pDisks);
	#endif
						return -2;
					}
				}
				ret= 0;
				pFirst += len;
				////
				if(process == 3){
					if(pCIBPost->lInstall == PL_WORK_FLAG){
						MemCopy(pFirst, pDefLoginForWorkCD, LOGIN_SIZE_PER_BYTES);
					}else
						MemCopy(pFirst, pNext[currSz].account.pLogin, LOGIN_SIZE_PER_BYTES);
				}else if(pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf,
								pNext[currSz].account.pLogin, LOGIN_SIZE_PER_BYTES)
									!= LOGIN_SIZE_PER_BYTES){
					if(currSz)
						free_in_heap(pNext);
					free_in_heap(pMem);
#ifndef RD_AS_ETALON
					free_in_heap(pNumbers);
					free_in_heap(pDisks);
#endif
					return -2;
				}
				//
				if(pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pFirst,
					(ii= (int)pRet-(int)pFirst)) != ii){
					if(currSz)
						free_in_heap(pNext);
					free_in_heap(pMem);
					return -2;
				}
				if(process == 3 && pCIBPost->lInstall == PL_WORK_FLAG){
					MemCopy(pFirst, pNext[currSz].account.pLogin, LOGIN_SIZE_PER_BYTES);
				}
				pFirst += ii;
				if(pNextBelngs == 0){
					// Make belongs string for parser  //
					if((sortBlngs= (int)*((short*)pBelngs - 1))){
						MemCopy(pBelngs - 1, pBelngs, sortBlngs);
						pBelngs--;
						pBelngs[sortBlngs]= '\0';
					}
					iEnd= szBf - sizeof(short) - sortBlngs
#ifndef RD_AS_ETALON
						- (iPostSz= *(short*)(pBelngs + 1 + sortBlngs) + sizeof(short) + sizeof(long))
#endif
						;
				}
				//
				if(!process && pCurrHDD_CIB != 0)
					currSz--; // not put in UID DB //
			}
			currSz++;
	}else{
		pCIB= pRet;
		pFirst= (char*)pRet;
	}
	/////
		if(pNextBelngs != 0 && (!countCIB || pPostHdr->lCDNumber == 0l)){
			// Create belongs for HDD //
			PWORD	*pAll= 0, pTable= 0;

			len= ((int)pNextBelngs-(int)pSortBlngs) / sizeof(WORD);
		  if(len){
			if((pAll=(PWORD*)alloc_in_heap(sizeof(PBYTE)*len)) == 0
									|| (pTable= (PWORD)alloc_in_heap(sizeof(WORD)*
																		(len+1+len*4))) == 0){
				if(pAll != 0)
					free_in_heap(pAll);
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				return -5;
			}
			while(len--){
				pAll[len]= &(pSortBlngs[len]);
			}
			len= ((int)pNextBelngs-(int)pSortBlngs) / sizeof(WORD);

			pl_strip_Belngs(pAll, len, pTable, pTable+len);

			pNext[iCurrHDD].account.Attrib.BelngsSize= *(pTable+len);
			pNext[iCurrHDD].account.Attrib.pTable= pTable;

			if(pNext[iCurrHDD].account.Attrib.BelngsSize > pCopyer->account.Attrib.BelngsSize
					||
					pl_TestBelngs(	(LPPL_SDB_ATTRIB)&pNext[iCurrHDD].account.Attrib,
									(LPPL_SDB_ATTRIB)&pCopyer->account.Attrib)){
				if(pAll != 0)
					free_in_heap(pAll);
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				return -95;
			}

			pTable += len + 1;
			len= (int)pNext[iCurrHDD].account.Attrib.BelngsSize;
			sortBlngs= 0;
			while(--len){
				local_sprintf((char*)pTable+sortBlngs, (BYTE)(pNext[iCurrHDD].account.Attrib.pTable[len]));
				if(pNext[iCurrHDD].account.Attrib.pTable[len] > 99) sortBlngs+=4;
				else if(pNext[iCurrHDD].account.Attrib.pTable[len] > 9) sortBlngs+=3;
				else sortBlngs+=2;
			}
			local_sprintf((char*)pTable+sortBlngs, (BYTE)(pNext[iCurrHDD].account.Attrib.pTable[len]));
			if(pNext[iCurrHDD].account.Attrib.pTable[len] > 99) sortBlngs+=3;
			else if(pNext[iCurrHDD].account.Attrib.pTable[len] > 9) sortBlngs+=2;
			else sortBlngs+=1;
		  }else{
			pNext[iCurrHDD].account.Attrib.BelngsSize= 0;
			pNext[iCurrHDD].account.Attrib.pTable= 0;
		  }
			len= iLogin - iStart;
			if(pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
							pNewFsStructrs + iStart, len) != len){
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				free_in_heap(pAll);
				free_in_heap(pTable);
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				return -2;
			}
			if(fh){
				((LPPL_FZ1_POST_HDR)(pNewFsStructrs0
					+ iPostHdr + szBf0 - len))->lCDNumber= (long)fh;
				fh= 0;
			}
			if(pPostHdr->lCDNumber == 0l){
			}else{
				((LPPL_FZ1_POST_HDR)(pNewFsStructrs0
										+ iPostHdr + szBf0 - len))->lCountList= 1l;
			}
#ifndef RD_AS_ETALON
			for(len= 0, szstr= 0; ppClients[len]; len++){
				szstr += *(short*)ppClients[len] + 1;
			}
			szstr--;
			if(pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
							&szstr, sizeof(szstr)) != sizeof(szstr)){
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				free_in_heap(pAll);
				free_in_heap(pTable);
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
				return -2;
			}
			for(len= 0; ppClients[len];){
				if(pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
								ppClients[len]+sizeof(short), *(short*)ppClients[len])
									!= *(short*)ppClients[len]){
					if(currSz)
						free_in_heap(pNext);
					free_in_heap(pMem);
					free_in_heap(pAll);
					free_in_heap(pTable);
					free_in_heap(pNumbers);
					free_in_heap(pDisks);
					return -2;
				}
				len++;
				if(	ppClients[len] &&
					pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
								"\n", 1) != 1){
					if(currSz)
						free_in_heap(pNext);
					free_in_heap(pMem);
					free_in_heap(pAll);
					free_in_heap(pTable);
					free_in_heap(pNumbers);
					free_in_heap(pDisks);
					return -2;
				}
			}
			len =	sizeof(long)	// ID части КК
					+ sizeof(short)	// Длина Login
						;
			if(pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
							pNewFsStructrs + iLogin + *(short*)(pNewFsStructrs + iLogin)
								+ sizeof(short), len)!= len){
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				free_in_heap(pAll);
				free_in_heap(pTable);
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
				return -2;
			}
			iLogin += *(short*)(pNewFsStructrs + iLogin) + sizeof(short) + len;
#endif
			if(pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
							pNext[iCurrHDD].account.pLogin, LOGIN_SIZE_PER_BYTES)
								!= LOGIN_SIZE_PER_BYTES){
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				free_in_heap(pAll);
				free_in_heap(pTable);
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				return -2;
			}
			len= iEnd - iLogin - LOGIN_SIZE_PER_BYTES;
#if !defined(RD_AS_ETALON) && !defined(PL_REPLCTR_FUNC)
			ii=  *(short*)(pNewFsStructrs + iLogin + LOGIN_SIZE_PER_BYTES)
						+ sizeof(short) + sizeof(long) + szBf0;
#endif
			if(pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
							pNewFsStructrs + iLogin + LOGIN_SIZE_PER_BYTES,
							len) != len){
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				free_in_heap(pAll);
				free_in_heap(pTable);
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				return -2;
			}
#if !defined(RD_AS_ETALON) && !defined(PL_REPLCTR_FUNC)
			if(!process)
				// Save Net masks //
				*(long*)(pNewFsStructrs0 + ii) = lNet;
#endif
			if(pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
							&sortBlngs, sizeof(short)) != sizeof(short)){
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				free_in_heap(pAll);
				free_in_heap(pTable);
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				return -2;
			}
			if(pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
							pTable, sortBlngs) != sortBlngs){
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				free_in_heap(pAll);
				free_in_heap(pTable);
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				return -2;
			}
#ifndef RD_AS_ETALON
			iLogin += len + LOGIN_SIZE_PER_BYTES;
			if(pl_write( &pNewFsStructrs0, (long*)&szBf0, (long*)&szAllocBf0,
							pNewFsStructrs + iLogin
							// Size Belongs in Source
							+ *(short*)(pNewFsStructrs+iLogin) + sizeof(short),
							iPostSz) != iPostSz){
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				free_in_heap(pAll);
				free_in_heap(pTable);
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
				return -2;
			}
#endif
			if(pAll)
				free_in_heap(pAll);
			// Update real Buff //
			if(pPostHdr->lCDNumber == 0l){
				pCurrHDD_CIB= 0;
				lUpID= PL_MAX_HDD_NUMBER;
				pNextBelngs= 0;
			}
		}else if(process == 3 && currSz && !pPostHdr->lCDNumber && fSz == (*pLong-PL_MAX_HDD_NUMBER)){
			// Изготовление одиночного инсталляционного не на ЛН или ПДД для РД //
			countCIB= 0l;
			fSz= pPostHdr->lCDNumber;
			pPostHdr->lCountList= currSz;
		}
		}
		if(process == 2){
			pSourceMem= pSrcMem;
			pchar= GetLoginSerivceFromMemBlockFZ1(pSourceMem, &LoginServiceSz);
			len= (int)*((short*)(pchar+ (int)LoginServiceSz));
			pchar += sizeof(pSourceMem->LoginCopyerSz) + (int)LoginServiceSz;

			pFirst= (char*)pSrcMem;
			ii= *(long*)(pchar + len);

			if(pCIBPost->lInstall != PL_WORK_FLAG){
				fSz= countPost;
			}
			fh= countPost;
			// Save Main Header //
#if !defined(RD_AS_ETALON) && defined(MAKE_HDD) && defined(WIN32)
			if(pCIBPost->lInstall != PL_WORK_FLAG){
				int new_ii= sizeof(long) + sizeof(short)
									+ sizeof(short)
									+ LoginServiceSz
									+ *(short*)(pFirst + sizeof(long));

	if(NextSynchro()){
		if(currSz)
			free_in_heap(pNext);
		free_in_heap(pMem);
#ifndef RD_AS_ETALON
		free_in_heap(pNumbers);
		free_in_heap(pDisks);
#endif
		return -5;
	}
	if(pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pFirst, new_ii) != new_ii){
		if(currSz)
			free_in_heap(pNext);
		free_in_heap(pMem);
#ifndef RD_AS_ETALON
		free_in_heap(pNumbers);
		free_in_heap(pDisks);
#endif
		return -2;
	}
	pl_HashEx(pSynhro);

	new_ii += sizeof(short) + len;
	if(pPostHdr->lTransprtType)
		//MyPrintfFromTable(pFirst+sizeof(short), (PQWORD)pSynhro);
		MyPrintfFromTable(pFirst+sizeof(short), pSynhro, pSynhro+1);
	else
		MemCopy(pFirst+sizeof(short), "TGCENTER", 9);
	*(short*)pFirst= (short)StrLength(pFirst+sizeof(short));
	if(pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pFirst,
			(int)((*(short*)pFirst)+sizeof(short)))
					!= (int)(*(short*)pFirst+sizeof(short))){
		if(currSz)
			free_in_heap(pNext);
		free_in_heap(pMem);
#ifndef RD_AS_ETALON
		free_in_heap(pNumbers);
		free_in_heap(pDisks);
#endif
		return -2;
	}
	if(pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf,
					pFirst+new_ii, sizeof(long)) != sizeof(long)){
		if(currSz)
			free_in_heap(pNext);
		free_in_heap(pMem);
#ifndef RD_AS_ETALON
		free_in_heap(pNumbers);
		free_in_heap(pDisks);
#endif
		return -2;
	}
	*(long*)((char*)pNewFsStructrs + szBf - sizeof(long)) += *(short*)pFirst - len;
	new_ii += sizeof(long);
	pFirst += new_ii;
	ii -= new_ii;
			}
#endif
			if(pl_write( &pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pFirst, ii) != ii){
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				return -2;
			}
			pFirst += ii;
			break;
		}else if(process == 3 && fSz == countPost){
			if(pPostHdr->lCountList != currSz){
				// Not correct HDD List Size //
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				return -672;
			}
#ifndef RD_AS_ETALON
/*			MediaID=	// Время в секундах с 01.11 прошлого года //
						getSeconds() << 7;
			MediaID |=	// Номер ППД //
						(pPostHdr->lCDNumber & 0x7f);*/
			*pMediaID = CryptoTick();
#endif

#if defined(WIN32) && defined(INC_DONGLE_DLL) && defined(MAKE_HDD)
	#ifndef RD_AS_ETALON
			*pMediaID= pSERVICE->lCountMediaIDs;
			while((long)(*pMediaID -= 2) > -1){
				if( (pPostHdr->lCDNumber
						&&
						pSERVICE->pMediaIDs[*pMediaID]
							== - (long)(pPostHdr->lCDNumber & (0xffffffff >> (32-(32-7)))))
					||
					pSERVICE->pMediaIDs[*pMediaID]
					== (long)(pPostHdr->lNumber & (0xffffffff >> (32-(32-7)))))
					break;
			}
			if(*pMediaID == (DWORD)-2){
				if(pSERVICE->lCountMediaIDs + 4 > pSERVICE->lAllocMediaIDs){
					pSERVICE->lAllocMediaIDs += 222;
					if((pMediaID= (PDWORD)alloc_in_heap(pSERVICE->lAllocMediaIDs*sizeof(long)))
										== 0){
						if(currSz)
							free_in_heap(pNext);
						free_in_heap(pMem);
						return -5;
					}
					MemCopy(pMediaID, pSERVICE->pMediaIDs, pSERVICE->lCountMediaIDs*sizeof(long));
					MemSeting((char*)pMediaID + pSERVICE->lCountMediaIDs*sizeof(long),
								0,
							(pSERVICE->lAllocMediaIDs-pSERVICE->lCountMediaIDs)*sizeof(long));
					free_in_heap(pSERVICE->pMediaIDs);
					pSERVICE->pMediaIDs= (long*)pMediaID;
				}
	#ifdef STORE_HDD_MEDIA
				if(!pSERVICE->NotSavedMediaID_lCD && pPostHdr->lCDNumber){
					pSERVICE->pMediaIDs[pSERVICE->lCountMediaIDs]= -(long)(pPostHdr->lCDNumber & (0xffffffff >> (32-(32-7))));
					*pMediaID= pSERVICE->pMediaIDs[pSERVICE->lCountMediaIDs+1]= pPostHdr->lNumber | (CryptoTick() << 22);
					pSERVICE->lCountMediaIDs += 2;
				}
	#endif
				if(!pSERVICE->NotSavedMediaID_Numbr && (
	#ifdef STORE_HDD_MEDIA
															pPostHdr->lCDNumber ||
	#endif
															pPostHdr->lProtectType == PL_HASP_FLAG)){
					pSERVICE->pMediaIDs[pSERVICE->lCountMediaIDs]= pPostHdr->lNumber & (0xffffffff >> (32-(32-7)));
	#ifdef STORE_HDD_MEDIA
					if(!pSERVICE->NotSavedMediaID_lCD && pPostHdr->lCDNumber){
						*pMediaID= pSERVICE->pMediaIDs[pSERVICE->lCountMediaIDs-1];
					}else
	#endif
			if(pCIBPost->lInstall == PL_WORK_FLAG){
				*pMediaID= pSERVICE->pMediaIDs[pSERVICE->lCountMediaIDs+1]=
				pService->account.pId[0] << 17 | (pService->account.pId[1] << 4) | (CryptoTick() & 0xf);
			}else{
				*pMediaID= pSERVICE->pMediaIDs[pSERVICE->lCountMediaIDs+1]= pPostHdr->lNumber | (CryptoTick() << 22);
			}
					pSERVICE->lCountMediaIDs += 2;
				}
			}else
				*pMediaID= pSERVICE->pMediaIDs[(*pMediaID)+1];
	#endif
			if((wDungle= (*imp_HaspAllocComplect)(
	#ifndef RD_AS_ETALON
				(WORD)50//currSz
	#else
				(WORD)20
	#endif
				, *pMediaID)) != (WORD)0)
			{
#ifndef RD_AS_ETALON
				free_in_heap(pNumbers);
				free_in_heap(pDisks);
#endif
				// Not correct HDD List Size //
				if(currSz)
					free_in_heap(pNext);
				free_in_heap(pMem);
				return 900;
			}
#endif
			// update PostHeaders count //
			*(long*)(pNewFsStructrs+ ((int)pOffset- (int)pSourceMem) - sizeof(countPost))
				= 1l;
			OutputFileName= LicenseFileName;
			countPost= 0;
	#if !defined(RD_AS_ETALON) && defined(WIN32) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
			if(pSERVICE->MaxNumber != -1){
				pNewHeader= 0;
				free_in_heap(pNumbers);
				pNumbers= 0;
				free_in_heap(pDisks);
				pDisks= 0;
			}else{
				fSz= -1;
				countPost= remainder;
			}
	#endif
	#ifdef MAKE_HDD
			if(pCIBPost->lInstall == PL_WORK_FLAG)
				remainder = PL_WORK_FLAG;
	#endif
		}else if(process == 21){
			// End Create exported List //
			pl_freeBlngsTbls(pNext, currSz);
			free_in_heap(pMem);
			return 0;
		}else if(process == 11 && szBf == 0l){
			// Not Find Selected CIB in HDD //
			free_in_heap(pMem);
#ifndef RD_AS_ETALON
			free_in_heap(pNumbers);
			free_in_heap(pDisks);
#endif
			return -669;
		}
		pPostHdr= (LPPL_FZ1_POST_HDR)pRet;
	}
  }while(++process == 3);
  //
#if defined(PL_REPLCTR_FUNC) && !defined(RD_AS_ETALON) && defined(MAKE_HDD)
  if(process == 4){
		int	iKey, iStr, iNdt;

		char Key[256], Str[256], Ndt[256],
				*pLoginOut= LoginHDD;
  #if !defined(RD_AS_ETALON) && defined(WIN32) && defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
		if(pSERVICE->MaxNumber == -1){
			pSERVICE->NotSavedMediaID_Numbr= 1;
	#ifdef STORE_HDD_MEDIA
			if(!pSERVICE->NotSavedMediaID_lCD)
				pSERVICE->NotSavedMediaID_lCD= 1;
			else
	#endif
				pSERVICE->NotSavedMediaID_lCD= 0;
			process= countNumbers*2;
			while(process){
				process -= 2;
				if(pNumbers[process] > pSERVICE->MaxNumber){
					pSERVICE->MaxNumber= pNumbers[process];
				}
				if(pNumbers[process+1] > *(pNewHeader+1)){
					pSERVICE->NotSavedMediaID_Numbr= 0;
				}
			}
			if(pSERVICE->NotSavedMediaID_Numbr){
				pSERVICE->pMediaIDs[2]= 0;
				pSERVICE->pMediaIDs[3]= 0;
				pSERVICE->lCountMediaIDs -= 2;
			}
	#ifdef STORE_HDD_MEDIA
			if(pSERVICE->NotSavedMediaID_lCD && *(pNewHeader+3)){
				pSERVICE->pMediaIDs[0]= pSERVICE->pMediaIDs[2];
				pSERVICE->pMediaIDs[1]= pSERVICE->pMediaIDs[3];
				pSERVICE->pMediaIDs[2]= 0;
				pSERVICE->pMediaIDs[3]= 0;
				pSERVICE->lCountMediaIDs -= 2;
			}
	#endif
			process= 4;
			pNewHeader= 0;
			free_in_heap(pNumbers);
			pNumbers= 0;
			free_in_heap(pDisks);
			pDisks= 0;
		}
  #endif
		ii= StrLength(OutputFileName);
		if((pTmp= (char*)alloc_in_heap(ii+5)) == 0){
			if(currSz)
				free_in_heap(pNext);
			if(szBf)
				free_in_heap(pNewFsStructrs);
			free_in_heap(pMem);
#ifndef RD_AS_ETALON
			free_in_heap(pNumbers);
			free_in_heap(pDisks);
#endif
			return -5;
		}
		MemCopy(pTmp, OutputFileName, ii);
		pTmp[ii]= '.'; ii++;
/*#ifndef RD_AS_ETALON
		if(MemComp(	pNewFsStructrs+sizeof(long)+sizeof(short)
						+ *(short*)(pNewFsStructrs+sizeof(long))+sizeof(short),
						pchar, *((short*)pchar - 1))){
			MemCopy(pTmp+ii, "idb", 4);
		}else
#endif*/
			MemCopy(pTmp+ii, "uid", 4);
		MemCopy(Key, pTmp, ii);MemCopy(Key+ii, "key", 4);
		MemCopy(Str, pTmp, ii);MemCopy(Str+ii, "str", 4);
		MemCopy(Ndt, pTmp, ii);MemCopy(Ndt+ii, "ndt", 4);
#ifdef MULTI_INDEX_STREAM_FILE
	pTmp[ii-1]= 0;
	if(pl_ModifySignOnOtherFiles(pTmp, 1))
		countCIB= BASE_DATA_VERSION;
	pTmp[ii-1]= '.';
#endif
		pBytes= 0;
#ifndef RD_AS_ETALON
	#if defined(WIN32) && defined(MAKE_HDD)
		if(StoreClientID){
			HashDWORD((PDWORD)&StoreClientID);
			pextCrptKy[2]= StoreClientID;
		}else
	#endif
			pextCrptKy[2]= *pMediaID;
#endif
		iKey= iStr= iNdt= -1;
	  if(
#ifdef MULTI_INDEX_STREAM_FILE
			countCIB == BASE_DATA_VERSION
				||
#endif
			(iKey= CreateFileHandle( Key, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0 )) == -1 // GARANT_XXX
				||
			(iStr= CreateFileHandle( Str, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0 )) == -1 // GARANT_XXX
				||
			(iNdt= CreateFileHandle( Ndt, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0 )) == -1 // GARANT_XXX
				||
			pl_ModifyBase(iKey, iStr, iNdt, (char**)&pBytes, (char*)pextCrptKy))
	  {
		  if(iKey != -1)
			CloseFileHandle(iKey);
		  if(iStr != -1)
			CloseFileHandle(iStr);
		  if(iNdt != -1)
			CloseFileHandle(iNdt);
		  free_in_heap(pBytes);
		  //free_in_heap(OutputFileName);
		  if(currSz)
			  free_in_heap(pNext);
		  if(szBf)
			  free_in_heap(pNewFsStructrs);
		  free_in_heap(pMem);
#ifndef RD_AS_ETALON
		  free_in_heap(pNumbers);
		  free_in_heap(pDisks);
#endif
		  return -3;
	  }
#ifdef MULTI_INDEX_STREAM_FILE
#endif
	  if(remainder == PL_WORK_FLAG)
		  ii= LOGIN_SIZE_PER_BYTES;
	  else
		  ii= 0;
#ifdef MAKE_HDD
		MemCopy(pLoginTmp, pLoginOut, LOGIN_SIZE_PER_BYTES);
		local_sscanf2( pLoginTmp, (PDWORD)pLoginTmp, (PDWORD)pLoginTmp+1);
  #ifndef RD_AS_ETALON
		*((PDWORD)pLoginTmp + SIZE_CRYPTO_KYE_PER_DWORD) = *(PDWORD)pLoginTmp;
		*((PDWORD)pLoginTmp + 1+ SIZE_CRYPTO_KYE_PER_DWORD) = *((PDWORD)pLoginTmp +1);

		*((PDWORD)pLoginTmp+SIZE_CRYPTO_KYE_PER_DWORD) ^= *pMediaID;
		*((PDWORD)pLoginTmp+1+SIZE_CRYPTO_KYE_PER_DWORD) ^= *pMediaID;

		*((PDWORD)pLoginTmp + SIZE_CRYPTO_KYE_PER_DWORD
			 + SIZE_CRYPTO_KYE_PER_DWORD)
				= *((PDWORD)pLoginTmp+SIZE_CRYPTO_KYE_PER_DWORD);
		*((PDWORD)pLoginTmp + SIZE_CRYPTO_KYE_PER_DWORD
			 + SIZE_CRYPTO_KYE_PER_DWORD + 1)
				= *((PDWORD)pLoginTmp+SIZE_CRYPTO_KYE_PER_DWORD + 1);

		Hash(((PDWORD)pLoginTmp + SIZE_CRYPTO_KYE_PER_DWORD
									+ SIZE_CRYPTO_KYE_PER_DWORD));

		*((PDWORD)pLoginTmp) ^= *((PDWORD)pLoginTmp + SIZE_CRYPTO_KYE_PER_DWORD
													+ SIZE_CRYPTO_KYE_PER_DWORD);
		*((PDWORD)pLoginTmp+1) ^= *((PDWORD)pLoginTmp + SIZE_CRYPTO_KYE_PER_DWORD
													+ SIZE_CRYPTO_KYE_PER_DWORD + 1);

		local_sprintfX( (char*)((PDWORD)pLoginTmp+SIZE_CRYPTO_KYE_PER_DWORD),
			*((PDWORD)pLoginTmp+SIZE_CRYPTO_KYE_PER_DWORD),
			*((PDWORD)pLoginTmp+1+SIZE_CRYPTO_KYE_PER_DWORD));
		pLoginOut= (char*)((PDWORD)pLoginTmp+SIZE_CRYPTO_KYE_PER_DWORD);
  #else
		*((PDWORD)pLoginTmp) ^= 0x12563478;
		*((PDWORD)pLoginTmp+1) ^= 0x12563478;
		local_sprintfX( pLoginTmp, *((PDWORD)pLoginTmp), *((PDWORD)pLoginTmp+1));
		pLoginOut= (char*)pLoginTmp;
  #endif
#endif
	  if(
			(remainder == PL_WORK_FLAG &&
	((int)SetFilePos(iNdt, 512-(int)(ii=pl_GetLoginOffest()), ACE_OS_SEEK_SET)!= 512-ii
				||
	WriteInFile(iNdt, pNext->account.pLogin, LOGIN_SIZE_PER_BYTES) != LOGIN_SIZE_PER_BYTES))
				||
			(remainder != PL_WORK_FLAG &&
	  ((int)SetFilePos(iNdt, 512-(int)(ii=pl_GetLoginOffest()
			+ii + SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)), ACE_OS_SEEK_SET) != 512-ii
				||
#ifndef RD_AS_ETALON
			WriteInFile(iNdt, (PDWORD)pLoginTmp,
						LOGIN_SIZE_PER_BYTES+1+SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD))
				!= LOGIN_SIZE_PER_BYTES+1+SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)
#else
			WriteInFile(iNdt, pLoginTmp , LOGIN_SIZE_PER_BYTES+1) != LOGIN_SIZE_PER_BYTES+1
#endif
			)))
	  {
		  CloseFileHandle(iKey);
		  CloseFileHandle(iStr);
		  CloseFileHandle(iNdt);
		  free_in_heap(pBytes);
		  free_in_heap(OutputFileName);
		  if(currSz)
			  free_in_heap(pNext);
		  if(szBf)
			  free_in_heap(pNewFsStructrs);
		  free_in_heap(pMem);
#ifndef RD_AS_ETALON
		  free_in_heap(pNumbers);
		  free_in_heap(pDisks);
#endif
		  return -3;
	  }
	  CloseFileHandle(iKey);
	  CloseFileHandle(iStr);
	  CloseFileHandle(iNdt);
	  free_in_heap(pBytes);
	  OutputFileName= pTmp;
	}else
#endif
		if(!currSz && process == 2){
			free_in_heap(pMem);
#ifndef RD_AS_ETALON
			free_in_heap(pNumbers);
			free_in_heap(pDisks);
#endif
			return -677;
	}
	if((fh= CreateFileHandle( OutputFileName, ACE_OS_O_CREAT | ACE_OS_O_TRUNC | ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0 )) == -1){ // GARANT_XXX
		if(currSz)
			free_in_heap(pNext);
		if(szBf)
			free_in_heap(pNewFsStructrs);
		free_in_heap(pMem);
#ifndef RD_AS_ETALON
		free_in_heap(pNumbers);
		free_in_heap(pDisks);
#endif
		return -3;
	}
	if(szBf0){
		*(long*)(pNewFsStructrs+ ((int)pOffset- (int)pSourceMem))= szBf;
		pBytes= pNewFsStructrs;
		pNewFsStructrs= pNewFsStructrs0;
		szAllocBf= szAllocBf0;
		lUpID= szBf;
		szBf= szBf0;
		szBf0= lUpID;
	}
	*(long*)(pNewFsStructrs+ ((int)pOffset- (int)pSourceMem))= szBf;
	lUpID= szBf;
	if(szBf0){
		if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pBytes, szBf0) != szBf0)
			goto Error_2_1;
		free_in_heap(pBytes);
	}
	if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf,
				UIDDB_STREAM_SIGN, SIZE_SYNHRO_PER_DWORD * sizeof(DWORD)) != SIZE_SYNHRO_PER_DWORD * sizeof(DWORD))
		goto Error_2_1;
	if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, &checkpoint, sizeof(long)) != sizeof(long))
		goto Error_2_1;
	countCIB= szBf;
	ii= currSz;
	while(currSz--){
		len= sizeof(pNext[currSz]);
		if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pNext+currSz, len) != len)
			goto Error_2_1;
		len= SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD) * pNext[currSz].frandsCount;
		if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pNext[currSz].pFrands, len) != len)
			goto Error_2_1;
		len= (int)pNext[currSz].account.Attrib.BelngsSize;
		if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pNext[currSz].account.Attrib.pTable, len) != len)
			goto Error_2_1;
		*(long*)(pNewFsStructrs+countCIB)= szBf - lUpID;
		countCIB= szBf;
	}
	pl_freeBlngsTbls(pNext, ii);

	pCopyer->offset_to_next= 0l;
	len= sizeof(*pCopyer);
	if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pCopyer, len) != len)
		goto Error_2_1;
	len= SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD) * pCopyer->frandsCount;
	if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pCopyer->pFrands, len) != len)
		goto Error_2_1;
	len= pCopyer->account.Attrib.BelngsSize;
	if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pCopyer->account.Attrib.pTable, len) != len)
		goto Error_2_1;
	// for Crypto //
	if(pl_write(&pNewFsStructrs, (long*)&szBf, (long*)&szAllocBf, pNewFsStructrs,
					SIZE_CRYPTO_HEADER*2 ) != SIZE_CRYPTO_HEADER*2)
		goto Error_2_1;
	szBf -= lUpID + SIZE_CRYPTO_HEADER*2;
#ifndef BRDR32
	if(process == 4){
		MemCopy(pLogin, pLoginCp, PSSWRD_SIZE_PER_BYTES);
		pl_HashEx(pLogin);
		LoadCryptoKey(pLogin, 0);
	}else
#endif
		LoadCryptoKeyFromStr(pLogin, 0);

	EnCrypto((char*)pNewFsStructrs+lUpID, (PDWORD)(&szBf));

	if(szBf == 0l)
		goto Error_2_0;
	UnLoadCryptoKey(&ret, 0);
	szBf += lUpID;
#ifndef BRDR32
	if(process == 4){
		// Использовать всю уникальность логина //
		local_sscanf2(pLoginCp, (PDWORD)pLoginCp, (PDWORD)pLoginCp + 1);
		if(remainder != PL_WORK_FLAG){
			((long*)pLoginCp)[0] ^= IsG6X_NDT[0];
			((long*)pLoginCp)[1] ^= IsG6X_NDT[1];
		}
		IsG6X_NDT[0]= IsG6X_NDT[1]= 0;
		LoadCryptoKey(pLoginCp, 0);
	}else
#endif
		LoadCryptoKeyFromStr(pLoginCp, 0);

	EnCrypto((char*)pNewFsStructrs, (PDWORD)(&szBf));
#ifndef BRDR32
	if(process == 4){
		// Прячем крипто Заголовок в центре зашифрованного блока //
		char tttt[SIZE_CRYPTO_HEADER];
		MemCopy(tttt, (char*)pNewFsStructrs+ ((szBf-SIZE_CRYPTO_HEADER)/2), SIZE_CRYPTO_HEADER);
		MemCopy((char*)pNewFsStructrs+ ((szBf-SIZE_CRYPTO_HEADER)/2),
					(char*)pNewFsStructrs+szBf-SIZE_CRYPTO_HEADER, SIZE_CRYPTO_HEADER);
		MemCopy((char*)pNewFsStructrs+szBf-SIZE_CRYPTO_HEADER, tttt, SIZE_CRYPTO_HEADER);
	}
#endif
	/////////////////////////////////////////////////////////
	if(szBf == 0l || WriteInFile(fh, pNewFsStructrs, szBf) != szBf)
		goto Error_2_0;
	goto No_Error;
Error_2_0:
	UnLoadCryptoKey(&ret, 0);
	if(szBf)
		free_in_heap(pNewFsStructrs);
Error_2_1:
	if(currSz)
		free_in_heap(pNext);
	if(szBf)
		free_in_heap(pNewFsStructrs);
	free_in_heap(pMem);
	CloseFileHandle(fh);
#ifndef RD_AS_ETALON
	free_in_heap(pNumbers);
	free_in_heap(pDisks);
#endif
	return -2;
No_Error:
	UnLoadCryptoKey(&ret, 0);
	if(currSz)
		free_in_heap(pNext);
	if(szBf)
		free_in_heap(pNewFsStructrs);
	CloseFileHandle(fh);
	free_in_heap(pMem);
	if(process == 4)
		free_in_heap(pTmp);
	return 0;
}

int __stdcall pl_UnCryptoAvancedInfo(	char *FileNameLicense,
										char *LoginServiceDep,
										char *PasswordServiceDep,
										char **ppStr)
{
#if defined(PL_REPLCTR_FUNC)
	*ppStr= 0;
	return 0;
#else
	char tmp[256], *pSecond;
	LPPL_FZ1_HDR ptmp= (LPPL_FZ1_HDR)&tmp;
	int len= (int)(StrLength(LoginServiceDep)&0x7fffffff);

	if(len > LOGIN_SIZE_PER_BYTES)
		len= LOGIN_SIZE_PER_BYTES;

#ifndef RD_AS_ETALON
	ptmp->ServiceSz= 0;
	ptmp->LoginCopyerSz
#else
	ptmp->LoginServiceSz
#endif
		= (short)len;
	*(short*)(pSecond= ((char*)&
#ifndef RD_AS_ETALON
								ptmp->LoginCopyerSz
#else
								ptmp->LoginServiceSz
#endif
		+ len + sizeof(short)))
		= sizeof(long);
	MemCopy(pSecond-len, LoginServiceDep, len);
	*(long*)(pSecond+sizeof(short))= 0;

	ptmp->lSgntr= FZ1_HDR_SIGN;

	return pl_CreateFZ1Ex(	FileNameLicense, ptmp, (char*)ppStr,
							PasswordServiceDep, 0);
#endif
}

int __stdcall pl_CreateFileOrder (	char *FileNameOrder,  char *FileNameLicense,
							char *PasswordServiceDep,
							void *Mem)
{
#if defined(PL_REPLCTR_FUNC) && !defined(BIG_TURTLE)
	return 0;
#else
	int retLocal= pl_CreateFZ1Ex(	FileNameLicense, (LPPL_FZ1_HDR)Mem, FileNameOrder,
							PasswordServiceDep, 0);
/*
#ifdef WIN32
	if(retLocal && LastCretatedFileHandle != -1){
		if(LastCretatedFileHandle != -2)
			CloseHandle((HANDLE)LastCretatedFileHandle);
		DeleteFile(LastCretatedFileName);
	}
	LastCretatedFileHandle= -1;
#endif
*/
	return retLocal;
#endif
}

int pl_CreateHDD(	char *LoginCopyer, char *PassCopyer, char *FZ1FileName,
					char *LoginHDD)
{
	int ret;
	ret= pl_CreateFZ1Ex(FZ1FileName, (LPPL_FZ1_HDR)PassCopyer, LoginCopyer, LoginHDD, 1);

	return ret;
}

int pl_Get_InstalledCIBsFromInstalledDisk(	char *LoginHDD, char *LoginCopyer,
														char *FZ1FileName,
														LPPL_IMPORT_COMPLECT_DATA *ppList)
{
	int ret;
#ifdef MAKE_HDD
	char *pCIB;
	if((pCIB= (char*)alloc_in_heap((ret=StrLength(FZ1FileName))+100)) == 0){
		return -5;
	}
	MemCopy(pCIB, FZ1FileName, ret);
	MemCopy(pCIB+ret, ".uid", 5);
#endif
	ret= pl_CreateFZ1Ex(	
#ifdef MAKE_HDD
							pCIB
#else
							FZ1FileName
#endif
							, (LPPL_FZ1_HDR)LoginCopyer, LoginHDD, (char*)ppList, 21);
#ifdef MAKE_HDD
	free_in_heap(pCIB);
#endif
	return ret;
}
int __stdcall pl_UnCryptoReport(
								char *FileNameLicense,
			// ЗАМЕЧАНИЕ ! при обращении к данной функции из АРМ СО	//
			// значение FileNameLicense равно URL сервера ББС		//
								char *LoginServiceDep,
								char *PasswordServiceDep,
								char *FileNameReport,
				void **ppMem	// блок памяти содержащий копию цепочки байтов //
								// считанных из файла отчета				   //
								)
{
	PL_UDDB_NAME tmpStrct;
	tmpStrct.pSource= (char*)ppMem;
	tmpStrct.pMem= LoginServiceDep;
	return pl_CreateFZ1Ex(	FileNameLicense, (LPPL_FZ1_HDR)&tmpStrct, FileNameReport,
							PasswordServiceDep, 81);
}
	#if defined(PL_REPLCTR_FUNC)
int __stdcall gUnCryptoFileOrder_32(	char *FileNameOrder,
									char *LoginReplicator,
									char *PasswordReplicator,
									char **pMem)
{
	int ret;
	static PL_UDDB_NAME tmpStrct;
	int MemSize;

	tmpStrct.pSource= (char*)&MemSize;
	tmpStrct.pMem= 0;

	if((ret= pl_CreateFZ1Ex(FileNameOrder,
						(LPPL_FZ1_HDR)PasswordReplicator, LoginReplicator,
						(char*)&tmpStrct, 41))){
		if(tmpStrct.pMem != 0)
			free_in_heap(tmpStrct.pMem);
	}else{
		*pMem= (char*)tmpStrct.pMem;
		tmpStrct.pMem= 0;
	}
	return ret;
}
int __stdcall pl_EnCryptoReport(	char *OutputedFileNameReport,
									char *FileNameOrder,
									char *LoginReplicator,
									char *PasswordReplicator,
									char *Mem,	// блок памяти в формате ФЗ2 //
									int  MemSize)
{
	PL_UDDB_NAME tmpStrct;
	tmpStrct.pMem= Mem;
	tmpStrct.pTarget= OutputedFileNameReport;
	tmpStrct.pSource= (char*)&MemSize;

	return pl_CreateFZ1Ex(	FileNameOrder,
							(LPPL_FZ1_HDR)PasswordReplicator, LoginReplicator,
							(char*)&tmpStrct, 71);
}

int __stdcall gPerson_32(	char *BaseFileName, 
							char *LoginReplicator,
							char *PasswordReplicator,
							char *LoginInstalledCIB,
							char *FileNameOrder
#ifndef RD_AS_ETALON
							,long *pRetTime
#endif
							)
{
	int ret;
	PL_UDDB_NAME tmpStrct;

#if defined(WIN32) && defined(INC_DONGLE_DLL) && defined(MAKE_HDD)
	if ( handle2GLink == 0 && (handle2GLink = LoadLibrary(".\\dongle.dll")) == 0)
	{
		ret= -76;
	}
	else 
	{
		if(imp_HaspAllocComplect == 0 && (imp_HaspAllocComplect=
			(WORD ( __stdcall *)(WORD, DWORD))GetProcAddress(handle2GLink, "HaspAllocComplect"))
				== 0)	return -77;
#endif
		tmpStrct.pSource= LoginInstalledCIB;
		tmpStrct.pTarget= BaseFileName;
#ifndef RD_AS_ETALON
		tmpStrct.pMem= pRetTime;
#endif
		ret= pl_CreateFZ1Ex(FileNameOrder,
							(LPPL_FZ1_HDR)PasswordReplicator, LoginReplicator,
							(char*)&tmpStrct, 1);
/*
#ifdef WIN32
	if(ret && LastCretatedFileHandle != -1){
		if(LastCretatedFileHandle != -2)
			CloseHandle((HANDLE)LastCretatedFileHandle);
		DeleteFile(LastCretatedFileName);
	}
	LastCretatedFileHandle= -1;
#endif
*/

#if defined(WIN32) && defined(INC_DONGLE_DLL) && defined(MAKE_HDD)
	}
#endif
	return ret;
}
	#endif

void add_crypto_tag(char **ppBuff, int PageSize)
{
	if(PageSize == 512){
		*ppBuff= (char*)alloc_in_heap(sizeof(long));
		*(long*)(*ppBuff)= 0;
	}else if(*ppBuff == 0){
		*ppBuff= (char*)alloc_in_heap(MAX_CRYPTED_BLOCK_IN_WORK+SIZE_CRYPTO_HEADER+sizeof(long));
		*(long*)(*ppBuff)= (long)PageSize + MAX_CRYPTED_BLOCK_IN_WORK;
	}
}

int pl_ReMakeCryptoTags(	int iKey, int iStr,
							char **ppKeyTag, char **ppStrTag,
							char *pKeyTag, char *pStrTag)
{
	long current= *(long*)pKeyTag-2048;

	if(*ppKeyTag == 0){
		add_crypto_tag(ppKeyTag, 2048);
		pKeyTag += sizeof(long);
		if(	SetFilePos(iKey, MAX_CRYPTED_BLOCK_IN_WORK + 2048, ACE_OS_SEEK_SET)
										!= MAX_CRYPTED_BLOCK_IN_WORK + 2048
				||
			WriteInFile(	iKey, pKeyTag+ MAX_CRYPTED_BLOCK_IN_WORK,
				current- MAX_CRYPTED_BLOCK_IN_WORK) != current- MAX_CRYPTED_BLOCK_IN_WORK
				||
			MemCopy(*ppKeyTag+ sizeof(long), pKeyTag, MAX_CRYPTED_BLOCK_IN_WORK)
					== 0)
					return -1;
	}
	if(*ppStrTag == 0){
		add_crypto_tag(ppStrTag, 4096);
		pStrTag += sizeof(long);
		if(	SetFilePos(iStr, MAX_CRYPTED_BLOCK_IN_WORK + 4096, ACE_OS_SEEK_SET)
											!= MAX_CRYPTED_BLOCK_IN_WORK + 4096
				||
			WriteInFile(	iStr, pStrTag+ MAX_CRYPTED_BLOCK_IN_WORK,
				current- MAX_CRYPTED_BLOCK_IN_WORK) != current- MAX_CRYPTED_BLOCK_IN_WORK
				||
			MemCopy(*ppStrTag+ sizeof(long), pStrTag, MAX_CRYPTED_BLOCK_IN_WORK)
					== 0)
					return -1;
	}
	return 0;
}

#ifdef MAKE_HDD
	#if defined(PL_REPLCTR_FUNC)
int __stdcall gBreeder_32(	char *InputedBaseFileName,
									char *LoginReplicator,
									char *PasswordReplicator,
									char *LoginHDD)
{
	int nRetCode;
	LPPL_IMPORT_COMPLECT_DATA pList= 0;

#if defined(TEST_MAKE_HDD) && defined(INC_DONGLE_DLL)
/////
	if( handle2GLink == 0 && (handle2GLink = LoadLibrary(".\\dongle.dll")) == 0)
	{
		return -76;
	}
	if( (imp_HaspGetMediaId == 0 && (imp_HaspGetMediaId=
	(WORD ( __stdcall *)(PDWORD))GetProcAddress(	handle2GLink, "HaspGetMediaId"))
											== 0)
			||
		(imp_HaspAddTry == 0 && (imp_HaspAddTry=
			(WORD ( __stdcall *)(WORD))GetProcAddress(	handle2GLink, "HaspAddTry"))
											== 0)
			||
		(imp_HaspAddSuccess == 0 && (imp_HaspAddSuccess=
			(WORD ( __stdcall *)(WORD))GetProcAddress(	handle2GLink, "HaspAddSuccess"))
											== 0))
	{
		FreeLibrary(handle2GLink);
		return -77;
	}
#endif

	nRetCode= pl_InstallFromHDD(	LoginHDD, LoginHDD, InputedBaseFileName, pDefLoginForWorkCD);
	return nRetCode;
}
	#endif
#endif

	#if defined(PL_REPLCTR_FUNC) || defined(BRDR32)
int pl_InstallFromHDD(	char *LoginHDD, char *PassHDD,
#if defined(MAKE_HDD) || defined(BRDR32)
									char *FZ1FileBase,
#else
									char *FZ1FileName,
#endif
									char *LoginCIB)
{
	int iret
#ifdef MAKE_HDD
		, iKey, iStr, iNdt, iret1
#endif
	;
#if defined(MAKE_HDD) || defined(BRDR32)
	char *FZ1FileName;
	int len0= (int)(StrLength(FZ1FileBase)&0x7fffffff), len1= (int)(StrLength("uid")&0x7fffffff);
 #ifdef MAKE_HDD
	BYTE bff[LOGIN_SIZE_PER_BYTES+1];
	char *pBff= (char*)bff;
	DWORD dwMediaID;
#ifdef INC_DONGLE_DLL
	WORD ret, ret1;
	if ( (handle2GLink = LoadLibrary(".\\dongle.dll")) == 0)
	{
		return -76;
	}
	if((imp_HaspGetMediaId=
			(WORD ( __stdcall *)(PDWORD))GetProcAddress(	handle2GLink, "HaspGetMediaId"))
						== 0
			||
		(imp_HaspAddTry=
			(WORD ( __stdcall *)(WORD))GetProcAddress(	handle2GLink, "HaspAddTry"))
											== 0
			||
		(imp_HaspAddSuccess=
			(WORD ( __stdcall *)(WORD))GetProcAddress(	handle2GLink, "HaspAddSuccess"))
											== 0)
	{
		FreeLibrary(handle2GLink);
		return -77;
	}
	ret= (*imp_HaspGetMediaId)(&dwMediaID);
	if(ret != (WORD)0){
		FreeLibrary(handle2GLink);
		return 700+ret;
	}
	//ret1= (*imp_HaspAddTry)(0);
	if(ret != (WORD)0){
		FreeLibrary(handle2GLink);
		return 800+ret;
	}
#elif defined(MULTI_INDEX_STREAM_FILE) && !defined(INC_DONGLE_DLL)
	dwMediaID= (DWORD)iRetSynchro;
#else
	dwMediaID= 0x12563478;
#endif
	local_sscanf2( LoginHDD, (PDWORD)pBff, (PDWORD)pBff+1);
	local_sprintfX( pBff, *((PDWORD)pBff) ^ dwMediaID, *((PDWORD)pBff+1) ^ dwMediaID);
	pBff[LOGIN_SIZE_PER_BYTES]= 0;
	local_sscanf2( pBff, (PDWORD)pBff, (PDWORD)pBff+1);
	local_sprintfX( pBff, *((PDWORD)pBff) ^ dwMediaID, *((PDWORD)pBff+1) ^ dwMediaID);
	pBff[LOGIN_SIZE_PER_BYTES]= 0;
 #endif
	if((FZ1FileName= (char*)alloc_in_heap(len0+len1+2)) == 0){
#if defined(MAKE_HDD) && defined(INC_DONGLE_DLL)
		FreeLibrary(handle2GLink);
#endif
		return -5;
	}
	MemCopy(FZ1FileName, FZ1FileBase, len0);
	FZ1FileName[len0]= '.';len0++;
	MemCopy(FZ1FileName+len0, "uid", len1+1);
#endif
	iret= pl_CreateFZ1Ex(	FZ1FileName,
#ifdef MAKE_HDD
							(LPPL_FZ1_HDR)pBff, pBff,
#else
							(LPPL_FZ1_HDR)PassHDD, LoginHDD, 
#endif
							LoginCIB, 11);
	//return -5; // Debug in Breeder32 (not install CIB)
#if defined(MAKE_HDD) || defined(BRDR32)
 #ifdef MAKE_HDD
	if(!iret && MemCopy(FZ1FileName+len0, "key", len1+1) != 0 &&
		(iKey= CreateFileHandle( FZ1FileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0 )) != -1){ // GARANT_XXX
		MemCopy(FZ1FileName+len0, "str", len1);
		if((iStr= CreateFileHandle( FZ1FileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0 )) != -1){ // GARANT_XXX
			MemCopy(FZ1FileName+len0, "ndt", len1);
			if((iNdt= CreateFileHandle( FZ1FileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY, 0 )) != -1){ // GARANT_XXX
	////////////////
	long iKeySz, iStrSz;
	char *pKeyTag, *pStrTag, NDT[4096], *pLogin, *pKTag= 0, *pSTag= 0;
	int CryptoCount= MAX_CRYPTED_BLOCK;
	if(	(iKeySz=SetFilePos(iKey, 0l, ACE_OS_SEEK_END)) == -1
			||
		SetFilePos(iKey, 2048L, ACE_OS_SEEK_SET) != 2048
			||
		(iStrSz=SetFilePos(iStr, 0l, ACE_OS_SEEK_END)) == -1
			||
		SetFilePos(iStr, 4096L, ACE_OS_SEEK_SET) != 4096
			||
		ReadFromFile(iNdt, NDT, 512) != 512)
	{
		free_in_heap(FZ1FileName);
		CloseFileHandle(iNdt);
		CloseFileHandle(iStr);
		CloseFileHandle(iKey);
#ifdef INC_DONGLE_DLL
		FreeLibrary(handle2GLink);
#endif
		return -1;
	}
	pl_CalcCryptoSizeInBase(&CryptoCount, iKeySz, iStrSz, CryptoCount);
	
	pKeyTag= (char*)alloc_in_heap(CryptoCount+SIZE_CRYPTO_HEADER+sizeof(long));
	pStrTag= (char*)alloc_in_heap(CryptoCount+SIZE_CRYPTO_HEADER+sizeof(long));

	pl_GetLoginFromBase(&pLogin, NDT, 512);
	
	if((iret= pl_UnCryptBase(	iKey, iStr, pLogin, pKeyTag, pStrTag, CryptoCount)))
	{
		if(pKeyTag != 0)
			free_in_heap(pKeyTag);
		if(pStrTag != 0)
			free_in_heap(pStrTag);
		free_in_heap(FZ1FileName);
		CloseFileHandle(iNdt);
		CloseFileHandle(iStr);
		CloseFileHandle(iKey);
#ifdef INC_DONGLE_DLL
		FreeLibrary(handle2GLink);
#endif
		return -1;
	}
#if defined(MAKE_HDD) && !defined(RD_AS_ETALON)
	//pextCrptKy[0]= pextCrptKy[2];
	//pextCrptKy[1]= (dwMediaID & (~0x1ffffff)) | ((dwMediaID >> 4) & 0x1fff);
	HashDWORD(pextCrptKy+1);
#endif
	if((iret= pl_ReMakeCryptoTags( iKey, iStr, &pKTag, &pSTag, pKeyTag, pStrTag))
			||
		!(pKTag += sizeof(long))
			||
		!(pSTag += sizeof(long))
#if defined(MAKE_HDD) && !defined(RD_AS_ETALON)
	#ifdef NOT_RD
			||
		SetFilePos(iNdt, sizeof(struct PagedFileHeader), ACE_OS_SEEK_SET) != sizeof(struct PagedFileHeader)
			||
		WriteInFile(iNdt, NDT+sizeof(struct PagedFileHeader), SIZE_CRYPTO_HEADER*(16-1)) != SIZE_CRYPTO_HEADER*(16-1)
	#else
			||
		MemCopy(NDT+sizeof(struct PagedFileHeader), FZ1FileBase+len0+len1+1 ,256) == 0
			||
		!_PutAttr((short)512, NDT+sizeof(struct PagedFileHeader), tagPswdAttr,
					LoginCIB + StrLength(LoginCIB)+1, sizePswdAttr)
			||
		MemCopy(NDT + 512 - pl_GetLoginOffest() + LOGIN_SIZE_PER_BYTES + 1, 
					pextCrptKy,
					SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD) + sizeof(DWORD)) == 0
			||
		!(pextCrptKy= (PDWORD)NDT)
	#endif
#endif
			||
		(iret1= pl_ModifyBaseEx(	iKey, iStr, iNdt, &pKTag, &pSTag, (char*)pextCrptKy,
								MAX_CRYPTED_BLOCK_IN_WORK)))
	{
		pextCrptKy= pCrptKy;
		if(iret){
			free_in_heap(pKTag);
			free_in_heap(pSTag);
		}else{
			pKTag -= sizeof(long);
			free_in_heap(pKTag);
			pSTag -= sizeof(long);
			free_in_heap(pSTag);
		}
		if(pKeyTag != 0)
			free_in_heap(pKeyTag);
		if(pStrTag != 0)
			free_in_heap(pStrTag);
		CloseFileHandle(iNdt);
		CloseFileHandle(iStr);
		CloseFileHandle(iKey);
		free_in_heap(FZ1FileName);
#ifdef INC_DONGLE_DLL
		FreeLibrary(handle2GLink);
#endif
		return -1;
	}
	pextCrptKy= pCrptKy;
	pKTag -= sizeof(long);
	free_in_heap(pKTag);
	pSTag -= sizeof(long);
	free_in_heap(pSTag);

	if(pKeyTag != 0)
		free_in_heap(pKeyTag);
	if(pStrTag != 0)
		free_in_heap(pStrTag);
	////////////////
				CloseFileHandle(iNdt);
			}
			CloseFileHandle(iStr);
		}
		CloseFileHandle(iKey);
	}
#ifdef INC_DONGLE_DLL
  #ifdef MULTI_INDEX_STREAM_FILE
	iKey= 0;
	iNdt= -1968l;
	iStr= CreateFileHandle( FZ1FileName, ACE_OS_O_WRONLY | ACE_OS_O_BINARY, 0 ); // GARANT_XXX
	WriteInFile(iStr, &iNdt, sizeof(int));
	CloseFileHandle(iStr);
	while(*ppLst[iKey]){
		MemCopy(FZ1FileName+len0, ppLst[iKey]+1, len1);
		iStr= CreateFileHandle( FZ1FileName, ACE_OS_O_WRONLY | ACE_OS_O_BINARY, 0 ); // GARANT_XXX
		WriteInFile(iStr, &iNdt, sizeof(int));
		CloseFileHandle(iStr);
		iKey++;
	}
	MemCopy(FZ1FileName+len0, "str", len1);iKey++;
	iStr= CreateFileHandle( FZ1FileName, ACE_OS_O_WRONLY | ACE_OS_O_BINARY, 0 ); // GARANT_XXX
	WriteInFile(iStr, &iNdt, sizeof(int));
	CloseFileHandle(iStr);
	while(*ppLst[iKey]){
		MemCopy(FZ1FileName+len0, ppLst[iKey]+1, len1);
		iStr= CreateFileHandle( FZ1FileName, ACE_OS_O_WRONLY | ACE_OS_O_BINARY, 0 ); // GARANT_XXX
		WriteInFile(iStr, &iNdt, sizeof(int));
		CloseFileHandle(iStr);
		iKey++;
	}
  #endif
	ret1= (*imp_HaspAddSuccess)(0);
	if(ret != (WORD)0){
		FreeLibrary(handle2GLink);
		free_in_heap(FZ1FileName);
		return 1000+ret;
	}
	FreeLibrary(handle2GLink);
#endif

#endif
	free_in_heap(FZ1FileName);
#endif
	return iret;
}
	#endif

int pl_CreateFZ1(	char *LicenseFileName, LPPL_FZ1_HDR pSourceMem, char *OutputFileName)
{
	return pl_CreateFZ1Ex(LicenseFileName, pSourceMem, OutputFileName, 0, 0);
}
#endif

#if defined(PL_REPLCTR_FUNC) || defined(BRDR32)
int pl_FreeImportedComplectList(LPPL_IMPORT_COMPLECT_DATA pList)
{
	LPPL_IMPORT_COMPLECT_DATA pNext, pPre= 0;

	if((pNext= pList) != 0){
		LPPL_IMPORT_CIB_DATA pCIBs, pPreCIBs= 0;
		do{
			pCIBs= pNext->pCIBs;

			do{
				free_in_heap(pCIBs->pLogin);
				free_in_heap(pCIBs->Alias);
				pCIBs->pLogin= (char*)pPreCIBs;
				pPreCIBs= pCIBs;
			}while((pCIBs= (LPPL_IMPORT_CIB_DATA)pCIBs->next) != 0);

			do{
				pCIBs= (LPPL_IMPORT_CIB_DATA)pPreCIBs->pLogin;
				free_in_heap(pPreCIBs);
			}while((pPreCIBs= pCIBs) != 0);

			pNext->pCIBs= (LPPL_IMPORT_CIB_DATA)pPre;
			pPre= pNext;
		}while((pNext= (LPPL_IMPORT_COMPLECT_DATA)pNext->next) != 0);

		do{
			pNext= (LPPL_IMPORT_COMPLECT_DATA)pPre->pCIBs;
			free_in_heap(pPre);
		}while((pPre= pNext) != 0);
	}
	return 0;
}
#endif

#if !defined(RD_AS_ETALON) && !defined(INSTLL_CIB)
//////////////////////////////////////////////////////////////////////////////////
 typedef unsigned char u8;
 typedef unsigned short u16;
 typedef unsigned long u32;

// Calculate new CRC from old^(byte<<8)
u16 crc16_t8(u16 crcval)
{
   u16 f1,f2,f3;

   f1 = (crcval>>8) | ((crcval<<8) & 0xFFFF);
   f2 = (crcval>>12) | (crcval&0xF000) | ((crcval>>7)&0x01E0);
   f3 = ((crcval>>3) & 0x1FE0) ^ ((crcval<<4) & 0xF000);
   return f1^f2^f3;
}

u16 my_CRC16(u8 *buffer, int len)
{
   // Run sample message through check routine.
   u16 crc = 0;
   int i;

   for (i = 0; i < len; i++)
       crc = crc16_t8((u16)(crc ^ (buffer[i]<<8)));

   return crc;
}

u8 other_CRC8(u8 *pMem, int len)
{
	u32 sum= 0;
	while(len--) sum += *pMem++;
	return (u8)(sum%0xff);
}

long _getAnswerVal(long val)
{
	long mask;
#if  defined(NEW_AND_OLD_PASSWORD)
	mask= (val >> 11) & 0x7ff;
	return ((((val ^ (mask >> 7)) & 0x1f) | ((val ^ (mask << 5)) & 0x7e0)) & 0x7ff);
#endif
	mask= (val >> 10) & 0x3ff;
	return ((val^mask) & 0x3ff);
}
//////////////////////////////////////////////////////////////////////////////////
#if defined(BRDR32) || defined(PL_REPLCTR_FUNC)

	#ifdef BRDR32
		extern long MaskAnswerVal;
	#else
		static long MaskAnswerVal;
	#endif
#ifndef __SIMPLE_LOCALES__
char *pl_getPassword(long Service_ID, long baseDate, long Client_ID, long *pRetRnd)
{
	static char rtPassword[128], *retPassword, *pRetPassword;
	ACE_UINT64 z64= 0, z0;
	u16 crc16_tmp;
	long oldRnd;
#if (defined(NEW_AND_OLD_PASSWORD) || defined(MAKE_HDD))
	BYTE checkBuff[16];
	checkBuff[0] = (BYTE)((Client_ID >> 19) & 0x0000000f);
	Service_ID &= 0x2fff;
	Client_ID &= 0xfe07ffff;
	retPassword= &(rtPassword[1]);
#endif
	pRetPassword= retPassword;
	// Случайное в 10 бит //
	if(Client_ID & 0x1ff){
		*pRetRnd = oldRnd= (QUICK_RAND(m_RandSeed) % 0x7ff);
		MaskAnswerVal= glb_uz[(Client_ID & 0x1ff)-1] & 0x7fffff;
		Service_ID |= 0x2000;
		Client_ID= (Client_ID << 1) | (oldRnd & 1);
		oldRnd >>= 1;
	}else{
		*pRetRnd = oldRnd= (QUICK_RAND(m_RandSeed) % 0x3ff);
		MaskAnswerVal= 0;
	}
	// Заполняем битовую цепочку //
	//z0= baseDate & 0x3ff;
	z0= (Client_ID >> (32-7)) & 0x3f;
	z64 |= z0;
	//z0= Client_ID & 0xfffff;
	z0= Client_ID & 0x1fffff;
	z64 |= z0 << 10;
	z0= Service_ID & 0x3fff;
	z64 |= z0 << (10+20);
	z0= oldRnd;
	z64 |= z0 << (10+20+14);
	// Маскируем случайным с зависимостью от предыдущих //
	z64 ^= z0;
	z0 = (z64 & 0x3ff) << 10;
	z64 ^= z0;
	z0 = (z64 & (0x3ff << 10)) << 10;
	z64 ^= z0;
	z0 = (z64 & (0x3ff << 20)) << 10;
	z64 ^= z0;

	z0 = (z64 & ((ACE_UINT64)0x3ff << 30)) << 10;
	z64 ^= z0 & ((ACE_UINT64)0xf << 40);

	*(ACE_UINT64*)(checkBuff+1)= z64;
	crc16_tmp= my_CRC16(checkBuff, 9);

	z0= crc16_tmp & 0x3ff;

	z64 |= z0 << 54;

	crc16_tmp= (crc16_tmp >> 10) & 0x1f;

	z0= 0xf;

	if(checkBuff[0] < 10)
		rtPassword[0]= '0' + checkBuff[0];
	else
		rtPassword[0]= 'A' - 10 + checkBuff[0];
	do{
		if((char)((z64 & z0) >> ((pRetPassword-retPassword)*4)) < 10)
			*pRetPassword= '0'+ (char)((z64 & z0) >> ((pRetPassword-retPassword)*4));
		else
			*pRetPassword= 'A' - 10 + (char)((z64 & z0) >> ((pRetPassword-retPassword)*4));
		pRetPassword++;
		z0 <<= 4;
	}while((pRetPassword-retPassword) < 16);
	if((crc16_tmp & 0xf) < 10)
		*pRetPassword= '0'+ (char)(crc16_tmp & 0xf);
	else
		*pRetPassword= 'A' - 10 + (char)(crc16_tmp & 0xf);
	crc16_tmp >>= 4;
	pRetPassword++;
	if((crc16_tmp & 0xf) < 10)
		*pRetPassword= '0'+ (char)(crc16_tmp & 0xf);
	else
		*pRetPassword= 'A' - 10 + (char)(crc16_tmp & 0xf);

	pRetPassword = rtPassword+34;
	crc16_tmp= 19;

	while(crc16_tmp--){
		*pRetPassword++ = rtPassword[crc16_tmp];
	}
	*pRetPassword= 0;

	return rtPassword+34;
}
#else
static ACE_UINT64 lSH64(ACE_UINT64 *pVal, int d)
{
	unsigned long *pRet= (unsigned long *)pVal;
	if(d >= 32){
		pRet[1]= pRet[0];
		pRet[0]= 0;
		pRet[1] <<= d - 32;
	}else{
		pRet[1]= (pRet[1] << d) | ((pRet[0] & (0xffffffff << (32 - d))) >> (32 - d));
		pRet[0] <<= d;
	}
	return *(ACE_UINT64*)pRet;
}

static ACE_UINT64 rSH64(ACE_UINT64 *pVal, int d)
{
	unsigned long *pRet= (unsigned long *)pVal;
	if(d >= 32){
		pRet[0]= pRet[1];
		pRet[1]= 0;
		pRet[0] >>= d - 32;
	}else{
		pRet[0]= (pRet[0] >> d) | ((pRet[1] & (0xffffffff >> (32 - d))) << (32 - d));
		pRet[1] >>= d;
	}
	return *(ACE_UINT64*)pRet;
}

char *pl_getPassword(long Service_ID, long baseDate, long Client_ID, long *pRetRnd)
{
	static char retPassword[128], *pRetPassword;
	ACE_UINT64 z64= 0, z0, z1;
	u16 crc16_tmp;
	long oldRnd;

#if defined(NEW_AND_OLD_PASSWORD)
	Service_ID &= 0x2fff;
#endif
	pRetPassword= retPassword;
	// Случайное в 10 бит //
	if(Client_ID & 0x1ff){
		*pRetRnd = oldRnd= (QUICK_RAND(m_RandSeed) % 0x7ff);
		MaskAnswerVal= glb_uz[(Client_ID & 0x1ff)-1] & 0x7fffff;
		Service_ID |= 0x2000;
		Client_ID= (Client_ID << 1) | (oldRnd & 1);
		oldRnd >>= 1;
	}else{
		*pRetRnd = oldRnd= (QUICK_RAND(m_RandSeed) % 0x3ff);
		MaskAnswerVal= 0;
	}
/*	*pRetRnd = oldRnd= (QUICK_RAND(m_RandSeed)
#if defined(NEW_AND_OLD_PASSWORD)
	 % 0x7ff);
	MaskAnswerVal= glb_uz[(Client_ID & 0x1ff)-1] & 0x7fffff;
	Service_ID |= 0x2000;
	Client_ID= (Client_ID << 1) | (oldRnd & 1);
	oldRnd >>= 1;
#else
	 % 0x3ff);
	MaskAnswerVal= 0;
#endif*/
	// Заполняем битовую цепочку //
	//z0= baseDate & 0x3ff;
	z0= (Client_ID >> (32-7)) & 0x3f;
	z64 |= z0;
	//z0= Client_ID & 0xfffff;
	z0= Client_ID & 0x1fffff;
	z64 |= lSH64(&z0, 10);
	z0= Service_ID & 0x3fff;
	z64 |= lSH64(&z0, 10+20);
/*#ifndef NOT_RD // New passwords serial 
	memcpy(pextCrptKy, &z64, sizeof(z64));
	Hash(pextCrptKy);
#endif*/
	z0= oldRnd;
	z1= z0; z64 |= lSH64(&z1, 10+20+14);
	// Маскируем случайным с зависимостью от предыдущих //
	z64 ^= z0;
	z1= z64 & 0x3ff; z0= lSH64(&z1, 10);
	z64 ^= z0;
	z1= z64 & (0x3ff << 10); z0= lSH64(&z1, 10);
	z64 ^= z0;
	z1= z64 & (0x3ff << 20); z0= lSH64(&z1, 10);
	z64 ^= z0;
	z1= 0x3ff;z1= z64 & lSH64(&z1, 30);z0= lSH64(&z1, 10);

	z1= 0xf; z64 ^= z0 & lSH64(&z1, 40);

	crc16_tmp= my_CRC16((PBYTE)&z64, 8);

	z0= crc16_tmp & 0x3ff;

	z1= z0; z64 |= lSH64(&z1, 54);

	crc16_tmp= (crc16_tmp >> 10) & 0x1f;

	z0= 0xf;

	do{
		z1= z64 & z0; rSH64(&z1, ((pRetPassword-retPassword)*4));
		if((char)z1 < 10)
			*pRetPassword= '0'+ (char)z1;
		else
			*pRetPassword= 'A' - 10 + (char)z1;
		pRetPassword++;
		lSH64(&z0, 4);
	}while((pRetPassword-retPassword) < 16);
	if((crc16_tmp & 0xf) < 10)
		*pRetPassword= '0'+ (char)(crc16_tmp & 0xf);
	else
		*pRetPassword= 'A' - 10 + (char)(crc16_tmp & 0xf);
	crc16_tmp >>= 4;
	pRetPassword++;
	if((crc16_tmp & 0xf) < 10)
		*pRetPassword= '0'+ (char)(crc16_tmp & 0xf);
	else
		*pRetPassword= 'A' - 10 + (char)(crc16_tmp & 0xf);

	pRetPassword = retPassword+33;
	crc16_tmp= 18;
	while(crc16_tmp--){
		*pRetPassword++ = retPassword[crc16_tmp];
	}
	*pRetPassword= 0;

	return retPassword+33;
}
#endif
#endif
#if !defined(BRDR32) && !defined(INSTLL_CIB) && defined(WIN32) // GARANT_WIN32 called by Breeder
char *pl_getOldResponce(char *pPsswrd, long *pBaseDate, long *pClient_ID, long *pProcess)
{
		static char retAnswerOld[64];
		unsigned long z32[2], z0_32;
#if defined(NEW_AND_OLD_PASSWORD)
		int NewRspnce= 0;
#endif
		u16 crc16_tmp;
		char *pFrmt= pPsswrd+StrLength(pPsswrd);
		int ii= 0;
		unsigned long UpCRC= 0, z00= 0;

		z32[0]= z32[1]= 0;
		do{
			pFrmt--;
			if(*pFrmt < 'A'){
				z0_32 = (*pFrmt - '0');
			}else{
				z0_32 = (*pFrmt - 'A' + 10);
			}
			z32[0] |= z0_32 << (ii++ *4);
		}while(ii < (sizeof(z0_32)*2));
		ii= 0;
		do{
			pFrmt--;
			if(*pFrmt < 'A'){
				z0_32 = (*pFrmt - '0');
			}else{
				z0_32 = (*pFrmt - 'A' + 10);
			}
			z32[1] |= z0_32 << (ii++ *4);
		}while(ii < (sizeof(z0_32)*2));
		ii= 0;
		if(*pFrmt) do{
			pFrmt--;
			if(!*pFrmt)
				break;
			if(*pFrmt < 'A'){
				z00 = (*pFrmt - '0');
			}else{
				z00 = (*pFrmt - 'A' + 10);
			}
			UpCRC |= z00 << (ii++ *4);
		}while(ii < (sizeof(UpCRC)*2) && pFrmt != pPsswrd);
		z0_32= z32[1]; z32[1] &= 0x3fffff;
		crc16_tmp= my_CRC16((PBYTE)&z32, 8);
		if((z0_32 >> 22) != (unsigned long)(crc16_tmp & 0x3ff)
				||
			(unsigned long)((crc16_tmp >> 10) & 0x1f) != UpCRC
			)
			return NULL;

		z00= (z32[0]>>20) | (z32[1]<<12);
		UpCRC= z32[1] >> 12;
		z0_32= z32[0] << 10;
		*pBaseDate= (UpCRC ^ z32[0]) & 0x3ff;
		z32[0] ^= z0_32 & (0x3ff << 10);
		z32[0] ^= z0_32 & (0x3ff << 20);
		*pClient_ID= (long)((z32[0] >> 10) & 0xfffff);
		z32[0]= (z32[0] >> 30) | (z32[1] << 2);
		z32[0] ^= z00 & 0x3ff;
		z32[0] ^= z00 & (0xf << 10);
		z00 = z32[0]  & 0x3fff;
#if defined(NEW_AND_OLD_PASSWORD)
		if(z00 & 0x2000){
			UpCRC= (UpCRC << 1) | ((*pClient_ID) & 1);
			(*pClient_ID) >>= 1;
			(*pBaseDate) >>= 1;
			NewRspnce= (*pClient_ID) & 0x1ff;
		}
		z00 &= 0x1fff;
#endif
#ifndef IGNORE_ID
		if(pProcess)
			*pProcess= z00;
		else if(z00 != pCrptKy[2])
			return (char*)-1;
#else
		printf(" Ok.\n");
		printf("\n Days:\t\t\t%d", *pBaseDate);
		printf("\n ID Complect:\t\t%d", *pClient_ID);
		printf("\n ID ServiceDep:\t\t%d", z00);
		printf("\n Responce:\t\t");
#endif
		return retAnswerOld;
}
char *pl_getResponce(char *pPsswrd, long *pBaseDate, long *pClient_ID, long *pProcess)
{
		static char retAnswer[64];
		unsigned long z32[3], z0_32;

#if defined(NEW_AND_OLD_PASSWORD)
		int NewRspnce= 0;
		char *pOldRet= 0;
#endif
		u16 crc16_tmp;
		char *pFrmt= pPsswrd+StrLength(pPsswrd);
		int ii= 0;
		unsigned long UpCRC= 0, z00= 0;
#if defined(NEW_AND_OLD_PASSWORD)
		if((pOldRet= pl_getOldResponce(pPsswrd, pBaseDate, pClient_ID, pProcess)))
			return pOldRet;
#endif
		z32[0]= z32[1]= z32[2]= 0;
		pFrmt--;
		if(*pFrmt < 'A'){
			*(3+(PBYTE)z32) = (*pFrmt - '0');
		}else{
			*(3+(PBYTE)z32) = (*pFrmt - 'A' + 10);
		}
		do{
			pFrmt--;
			if(*pFrmt < 'A'){
				z0_32 = (*pFrmt - '0');
			}else{
				z0_32 = (*pFrmt - 'A' + 10);
			}
			z32[1] |= z0_32 << (ii++ *4);
		}while(ii < (sizeof(z0_32)*2));
		ii= 0;
		do{
			pFrmt--;
			if(*pFrmt < 'A'){
				z0_32 = (*pFrmt - '0');
			}else{
				z0_32 = (*pFrmt - 'A' + 10);
			}
			z32[2] |= z0_32 << (ii++ *4);
		}while(ii < (sizeof(z0_32)*2));
		ii= 0;
		if(*pFrmt) do{
			pFrmt--;
			if(!*pFrmt)
				break;
			if(*pFrmt < 'A'){
				z00 = (*pFrmt - '0');
			}else{
				z00 = (*pFrmt - 'A' + 10);
			}
			UpCRC |= z00 << (ii++ *4);
		}while(ii < (sizeof(UpCRC)*2) && pFrmt != pPsswrd);

		z0_32= z32[2]; z32[2] &= 0x3fffff;
		crc16_tmp= my_CRC16((3+(PBYTE)&z32), 9);

		if((z0_32 >> 22) != (unsigned long)(crc16_tmp & 0x3ff)
				||
			(unsigned long)((crc16_tmp >> 10) & 0x1f) != UpCRC
			)
			return NULL;

		z00= (z32[1]>>20) | (z32[2]<<12);
		UpCRC= z32[2] >> 12;
		z0_32= z32[1] << 10;
		*pBaseDate= (UpCRC ^ z32[1]) & 0x3ff;
		z32[1] ^= z0_32 & (0x3ff << 10);
		z32[1] ^= z0_32 & (0x3ff << 20);
		*pClient_ID= (long)((z32[1] >> 10) & 0xfffff);
		z32[1]= (z32[1] >> 30) | (z32[2] << 2);
		z32[1] ^= z00 & 0x3ff;
		z32[1] ^= z00 & (0xf << 10);
		z00 = z32[1]  & 0x3fff;
#if defined(NEW_AND_OLD_PASSWORD)
		if(z00 & 0x2000){
			UpCRC= (UpCRC << 1) | ((*pClient_ID) & 1);
			(*pClient_ID) >>= 1;
			(*pBaseDate) >>= 1;
			NewRspnce= (*pClient_ID) & 0x1ff;
		}
		(*pClient_ID) |= z32[0] >> 5;
		z00 &= 0x1fff;
#endif
#ifndef IGNORE_ID
		if(pProcess)
			*pProcess= z00;
		else if(z00 != pCrptKy[2])
			return (char*)-1;
#else
		printf(" Ok.\n");
		printf("\n Days:\t\t\t%d", *pBaseDate);
		printf("\n ID Complect:\t\t%d", *pClient_ID);
		printf("\n ID ServiceDep:\t\t%d", z00);
		printf("\n Responce:\t\t");
#endif
		return retAnswer;
}

char* __stdcall pl_GetDebugResponce(
// шестадцатиричное число в строке,являющиеся паролем, выданным Breeder32
		char *pPassword,
		long *pRetServiceID,
		long *pRetPos,
		long *pRetNumber)
{
	return 0;
}

char* __stdcall pl_GetResponce(	char *pPassword,
								char *pLoginService,	// Логин СО
								char *pPasswordService,	// Пароль СО
								char *LicenseFileName,	// Имя файла лицензии
								long *pRetData,
								long *pRetID)
{
	return 0;
}
#endif
#endif

#ifndef INSTLL_CIB
  #ifndef MAKE_HDD
	#ifdef BRDR32
		extern int gsplit_Method(int argc, char **argv, void *pCntx);
	#endif

	int pl_MakeCIBFromInstalledDisk(

	#ifdef BRDR32
										void *pContext,
	#endif
										char *InputedBaseFileName,
	#ifdef BRDR32
										char *OutputedBasePath,
	#endif
										char *LoginHDD,
										char *PasswordHDD
	#ifdef BRDR32
										,char *LoginCIB
	#endif
																		)
	{
		int retV;
		if(	!(retV= pl_InstallFromHDD(	LoginHDD,
	#ifdef BRDR32
										OutputedBasePath,
	#else
										PasswordHDD,
	#endif
										InputedBaseFileName,
	#ifdef BRDR32
										LoginCIB
	#else
										"Login TU"
	#endif
										))){
	#ifdef BRDR32
			char *argv[3];
			argv[0]= 0;
			argv[1]= InputedBaseFileName;
			argv[2]= OutputedBasePath;
			retV= gsplit_Method(3, argv, pContext);
			argv[1]= StrRFind(InputedBaseFileName, '\0');
	#endif
		}
		return retV;
	}
  #endif
#endif
// ============================================================================= //
#endif
// ============================================================================= //

} // extern "C"
