#include "shared/Core/fix/mpcxc.h"
// Demo_PAPI.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "Demo_PAPI.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// The one and only application object

CWinApp theApp;

#include "fcntl.h"

extern "C" {
	#include "..\..\GPersn\src\PL_Crypt.h"
	extern int __stdcall gCopyPX_32(char *RestoreFileName, char *BackupFileName);
  #if defined(PL_REPLCTR_FUNC) || defined(_DEBUG)
	extern int open_Win32( const char *path, int oflag, int shflag);
	extern int write_Win32( int fh, const void *pOut, unsigned int count);
  #endif
}

int _tmain(int argc, TCHAR* argv[], TCHAR* envp[])
{
	char ttt[]="FDXX";
	long *pLong= (long*)ttt;
	short *pOut=(short*)(ttt+sizeof(short));
	short *pShort= (short*)((char*)pLong+sizeof(short));
	// initialize MFC and print and error on failure
	if (!AfxWinInit(::GetModuleHandle(0), 0, ::GetCommandLine(), 0))
	{
		// TODO: change error code to suit your needs
		std::cerr << _T("Fatal Error: MFC initialization failed") << std::endl;
		return -1;
	}

	std::cout << "Init, please wait..." << std::endl;

	int nRetCode;
#ifndef RD_AS_ETALON
	if((nRetCode= pl_InitCrypto(0))){
		AfxMessageBox("Исходная эталонная база - не указана !");
		return -1;
	}
#endif

	char	LicenseFileName[]		= 
#ifndef RD_AS_ETALON
		".\\SO_LicenseFileName"
#else
		"E:\\TestDlph\\Test_Service\\SO_LicenseFileName"
#endif
			,LoginInitiator[]		= "Maker",

	///////////////////////////////////////////////////////////////////
	// ВНИМАНИЕ ! копия Хеша для хранения пароля Инициатора отсутствует
	// Пока он хранится в коде библиотеки !
	PasswordInitiator[]		= "Демо_Функции_ПУ",
	///////////////////////////////////////////////////////////////////

	LoginSerivice[]			= "SGCENTER",
	PasswordSerivice[]		= "SGCEN2436",
	LoginReplicator0[]		= "TGCENTER",
	PasswordReplicator0[]	= "TGCEN2498",
	LoginReplicator1[]		= "SOVP",
	PasswordReplicator1[]	= "SOVP2499";

	PL_IMPORT_HASH	SeriviceDepPasswordHash,
						SeriviceRp0PasswordHash,
							SeriviceRp1PasswordHash;

	PL_SDB_IMPORT_RECRD pTU0[2], *pTU1= pTU0 + 1;

	pTU0->ID= 2498;
	pTU1->ID= 2499;

	SeriviceDepPasswordHash.pInput= PasswordSerivice;
	pl_HashPassword(&SeriviceDepPasswordHash);

	strcpy(pTU0->pLogin, LoginReplicator0);

	SeriviceRp0PasswordHash.pInput= PasswordReplicator0;
	pl_HashPassword(&SeriviceRp0PasswordHash);

	memcpy(pTU0->pPsswrdHash, SeriviceRp0PasswordHash.Result, PSSWRD_SIZE_PER_BYTES);
	pTU0->BelngsSize= 5;
	pTU0->pTable= (PWORD)"\x5\x00\xf\x00\x10\x00\x13\x00\x19\x00";

	strcpy(pTU1->pLogin, LoginReplicator1);

	SeriviceRp1PasswordHash.pInput= PasswordReplicator1;
	pl_HashPassword(&SeriviceRp1PasswordHash);

	memcpy(pTU1->pPsswrdHash, SeriviceRp1PasswordHash.Result, PSSWRD_SIZE_PER_BYTES);
	pTU1->BelngsSize= 3;
	pTU1->pTable= (PWORD)"\x01\x0\xf\x0\x19\x0";
#ifndef RD_AS_ETALON
	PL_MULTI_SDB_IMPORT_RECRD pArray0[3],
								*pArray1= pArray0+1,
									*pArray2= pArray0+2;
	pArray0->FriendedReplicatorsCount=
		pArray1->FriendedReplicatorsCount=
			pArray2->FriendedReplicatorsCount= 2;
	pArray0->pFriendedReplicatorsList=
		pArray1->pFriendedReplicatorsList=
			pArray2->pFriendedReplicatorsList= pTU0;
	pArray0->pSeriviceDepPasswordHash=
		pArray1->pSeriviceDepPasswordHash=
			pArray2->pSeriviceDepPasswordHash= &SeriviceDepPasswordHash;
	pArray0->ServiceDepID=
		pArray1->ServiceDepID=
			pArray2->ServiceDepID= 2436;
	pArray0->LoginSerivice=LoginSerivice;
		pArray1->LoginSerivice= LoginSerivice;
			pArray2->LoginSerivice= LoginSerivice;

	#if !defined(PL_REPLCTR_FUNC) || defined(_DEBUG)
	if((nRetCode= /*pl_CreateMultiLicense(LicenseFileName,
									LoginInitiator,
									PasswordInitiator,
									"This is info for Service Dep",
									3, pArray0)*/
					pl_CreateDebugMultiLicense(LicenseFileName,
									"This is info for Service Dep",
									3, pArray0)
									)){
		pl_DoneCrypto(	//theApp.m_pMainWnd->m_hWnd
						0
						);
		return nRetCode;
	}
	if((nRetCode= /*pl_CreateLicense(	LicenseFileName,
									LoginInitiator,
									PasswordInitiator,
									LoginSerivice,
									&SeriviceDepPasswordHash,
									2436, // Service ID //
									"This is info for Service Dep",
									2, pTU0)*/
					pl_CreateDebugLicense(	LicenseFileName,
											LoginSerivice,
											&SeriviceDepPasswordHash,
											2436, // Service ID //
											"This is info for Service Dep",
											2, pTU0)
									)){
		pl_DoneCrypto(	//theApp.m_pMainWnd->m_hWnd
						0
						);
		return nRetCode;
	}
	// Блок формата ФЗ1 счиатаем из файла,
	// но реально его должен делать АРМ РП или АРМ СО //
	CFile file;
	CFileException fe;
	void *pMemBin= 0;
	DWORD sz;

	if (!file.Open(	
					//"./Order2_19_9_2002.FZ"
					//"./Order2_18_9_2002.FZ_m"
					//"./Order2_13_9_2002.FZ_m"
					//"./Order2_9_9_2002.FZ_m"
					//"./temp.mem_m"
					//"./Order6_9_2002_2.FZ_m"
					"./1/2_15_12_2002.FZ_m"
					, CFile::modeRead | CFile::shareDenyWrite, &fe)
			|| (pMemBin= malloc((sz= file.GetLength()))) == 0)
	{
		pl_DoneCrypto(0);
		return 1;
	}
	TRY
	{
		file.ReadHuge(pMemBin, sz);
		file.Close();
	}
	CATCH (CFileException, eLoad)
	{
		file.Abort(); // will not throw an exception
		pl_DoneCrypto(0);
		return 2;
	}
	END_CATCH

	char *ppRet;
	if((nRetCode= pl_UnCryptoAvancedInfo(	"./1/Test_Licence.lic"
											//LicenseFileName
											, 
				// ЗАМЕЧАНИЕ ! при обращении к данной функции из АРМ СО //
				// значение FileNameLicense равно URL сервера ББС //
  										"uo_login_2"//LoginSerivice
										,
										"uo_password_2"//PasswordSerivice
										,
							// указатель на блок памяти в формате ФЗ1 //
										&ppRet))){
		free(pMemBin);
		pl_DoneCrypto(0);
		AfxMessageBox("Библиотека персонификации. !");
		return nRetCode;
	}
	if(ppRet)
		pl_FreeMemWithAvancedInfo(ppRet);
/*
	long o0,o1;

	if((ppRet= pl_GetResponce(	"02A9F3527C0741BA78", 
								LoginSerivice,
								PasswordSerivice,
								LicenseFileName,
								&o0, &o1)) == 0
			|| ppRet == (char*)-1){
		free(pMemBin);
		pl_DoneCrypto(0);
		AfxMessageBox("Библиотека персонификации. !");
		return nRetCode;
	}
*/
	#endif
#endif
	char FZ_FileName[]=
#ifndef RD_AS_ETALON
						".\\Result.FZ1"
#else
						"E:/TestDlph/CryptoFZ1.bin"
#endif
						;
	char pBackup[]= "x:\\backup.etln", msg0[1024];
#ifdef PL_REPLCTR_FUNC
	char *pRetMem;
  #ifndef RD_AS_ETALON
	long RetTime;
  #endif
#endif
#if !defined(PL_REPLCTR_FUNC) || defined(_DEBUG)
	/*void *pMemWithFz2;
	if((nRetCode= pl_UnCryptoReport(	"./Licence.lic"//LicenseFileName
										,
										"uo_login_2",
										"uo_password_2",
										"C:\\new_Report",
										(void**)&pMemWithFz2))){
		sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
		AfxMessageBox(msg0);
		pl_DoneCrypto(0);
		return nRetCode;
	}*/
	if((nRetCode= pl_CreateFileOrder (	FZ_FileName, 
				// ЗАМЕЧАНИЕ ! при обращении к данной функции из АРМ СО //
				// значение FileNameLicense равно URL сервера ББС //
  										"./1/Test_Licence.lic"
										//LicenseFileName
										, 
										"uo_password_2"
										//PasswordSerivice
										,
							// указатель на блок памяти в формате ФЗ1 //
										pMemBin))){
		sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
		AfxMessageBox(msg0);
		free(pMemBin);
		pl_DoneCrypto(0);
		return nRetCode;
	}
#endif
#if defined(PL_REPLCTR_FUNC) || defined(_DEBUG)
	/*LPPL_BASE_FILE_LIST pList, pNxt;
	if((nRetCode= pl_GetFileList(argv[1], &pList))){
		sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
		AfxMessageBox(msg0);
		pl_DoneCrypto(0);
		return nRetCode;
	}
	if((pNxt= pList)){
		do{
			printf("\nFile:[%s]", pNxt->pFileName);
		}while((pNxt=(LPPL_BASE_FILE_LIST)pNxt->pNext));
		pl_FreeFileList(pList);
	}*/
	if((nRetCode= gUnCryptoFileOrder_32(
										//"./1/2_13_1_2003.FZ"//FZ_FileName
										//"O:\\NSRC\\test.fz"
										"E:\\CVS\\garant4x.my\\libs\\VControl\\msvc.win32\\Ярик.FZ"
										, 
  										"TU_2"
										//LoginReplicator0
										,
										"TU_2"
										//PasswordReplicator0
										,

										&pRetMem))){
		sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
		AfxMessageBox(msg0);
		pl_DoneCrypto(0);
		return nRetCode;
	}
	if(pRetMem){
		int ff= CreateFileHandle("d:/tttt", ACE_OS_O_CREAT|ACE_OS_O_BINARY|ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_RDWR,
								0664), xxx= 552;
		if(ff != -1){
			WriteInFile(ff, pRetMem, xxx);
			CloseFileHandle(ff);
		}
#ifdef _DEBUG
		pl_FreeMem(pRetMem);
#else
#endif
	}
	/*char *pMemWithFz2= "1234567890123456";
	if((nRetCode= pl_EnCryptoReport(	"C:\\new_Report", "./Result._FZ1"//FZ_FileName
										,
  										"TU_2"
										//LoginReplicator0
										,
										"TU_2"
										//PasswordReplicator0
										,
										pMemWithFz2, 17))){
		sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
		AfxMessageBox(msg0);
		pl_DoneCrypto(0);
		return nRetCode;
	}*/
#endif
#if defined(PL_REPLCTR_FUNC) || defined(_DEBUG)
	// Инсталляционный КИБ
	//if((nRetCode= gCopyPX_32( pBackup, argv[1]))){
	if((nRetCode= gCopyPX_32( argv[1], pBackup))){
		sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
		AfxMessageBox(msg0);
		pl_DoneCrypto(0);
		return nRetCode;
	}
	if((nRetCode= gPerson_32(	argv[1],
								"TU_2"
								//LoginReplicator0
								,
								"TU_2"
								//PasswordReplicator0
								,
								//"c0f38263dcec3670"		// Inst HDD
								  //"efde6137b8175c5d", // ??? Error -12
								  "febcac6714fc49b8",
								"E:\\CVS\\garant4x.my\\libs\\VControl\\msvc.win32\\Ярик.FZ"
#ifndef RD_AS_ETALON
								,&RetTime
#endif
								))){
		sprintf(msg0, "ERROR:Библиотека персонификации. (%s) !", pl_GetLastError(nRetCode));
		AfxMessageBox(msg0);
		if((nRetCode= gCopyPX_32( pBackup, argv[1]))){
			sprintf(msg0, "ERROR:Библиотека персонификации. (%s) !", pl_GetLastError(nRetCode));
			AfxMessageBox(msg0);
			pl_DoneCrypto(0);
			return nRetCode;
		}
		pl_DoneCrypto(0);
		return nRetCode;
	}
/*	LPPL_IMPORT_COMPLECT_DATA pListCIBS;
	if((nRetCode= pl_Get_InstalledCIBsFromInstalledDisk(	argv[1],
								"TU_2"
								//LoginReplicator0
								,
								//"c0f38263dcec3670"		// Inst HDD
								//"153b90f473b9d8c3"
								//"9df40b2186e773b1"
								//"e31f132d55fe805e"
								//"cd5abe6002eebef0"
								  "cbbf3e94d7dc146c",
								"./2_11_11_2002.FZ"//FZ_FileName
								,&pListCIBS
								))){
		sprintf(msg0, "ERROR:Библиотека персонификации. (%s) !", pl_GetLastError(nRetCode));
		AfxMessageBox(msg0);
		if((nRetCode= gCopyPX_32( pBackup, argv[1]))){
			sprintf(msg0, "ERROR:Библиотека персонификации. (%s) !", pl_GetLastError(nRetCode));
			AfxMessageBox(msg0);
			pl_DoneCrypto(0);
			return nRetCode;
		}
		pl_DoneCrypto(0);
		return nRetCode;
	}*/
	sprintf(msg0, "Инсталляционный дистрибутив - готов (%s)!", argv[1]);
	AfxMessageBox(msg0);
	if((nRetCode= gCopyPX_32( pBackup, argv[1]))){
		sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
		AfxMessageBox(msg0);
		pl_DoneCrypto(0);
		return nRetCode;
	}
/*	if((nRetCode= gPerson_32(	argv[1],
								"TU_2"//LoginReplicator0
								,
								"TU_2"//PasswordReplicator0
								,
								"a9b578593589d216",			// Work CD
								"O:\\NSRC\\test.fz"//FZ_FileName
#ifndef RD_AS_ETALON
								,&RetTime
#endif
								))){
		sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
		AfxMessageBox(msg0);
		if((nRetCode= gCopyPX_32( pBackup, argv[1]))){
			sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
			AfxMessageBox(msg0);
			pl_DoneCrypto(0);
			return nRetCode;
		}
		pl_DoneCrypto(0);
		return nRetCode;
	}
	if((nRetCode= gBreeder_32(argv[1],
								//LoginReplicator0
								"TU_2"
								,
								"TU_2"
								//PasswordReplicator0
								,
								"a9b578593589d216"			// Work CD
								))){
		sprintf(msg0, "Библиотека персонификации. (%s) !",
			pl_GetLastError(nRetCode));
		AfxMessageBox(msg0);
		if((nRetCode= gCopyPX_32( pBackup, argv[1]))){
			sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
			AfxMessageBox(msg0);
			pl_DoneCrypto(0);
			return nRetCode;
		}
		pl_DoneCrypto(0);
		return nRetCode;
	}
	sprintf(msg0, "Рабочий дистрибутив - готов (%s)!", argv[1]);
	AfxMessageBox(msg0);
*/
	if((nRetCode= gCopyPX_32( pBackup, argv[1]))){
		sprintf(msg0, "Библиотека персонификации. (%d) !", nRetCode);
		AfxMessageBox(msg0);
		pl_DoneCrypto(0);
		return nRetCode;
	}
#endif
//#endif
	pl_DoneCrypto(0);
	return nRetCode;
}

#if defined (_DEBUG) && defined (WIN32)
extern "C" {
	void *malloc( size_t size ){
		return (void*)LocalAlloc(LMEM_FIXED, size);
	}
	void *realloc( void *memblock, size_t size ){
		if(memblock)
			return (void*)LocalReAlloc((HANDLE)memblock, size, LMEM_MOVEABLE);
		return (void*)LocalAlloc(LMEM_FIXED, size);
	}
	void free( void *memblock )
	{
		LocalFree((HANDLE)memblock);
	}
	void *calloc( size_t num, size_t size )
	{
		void *pMem= (void*)LocalAlloc(LMEM_FIXED, size*num);
		if(pMem)
			return memset(pMem, 0, size*num);
		return 0;
	}
}
#endif

