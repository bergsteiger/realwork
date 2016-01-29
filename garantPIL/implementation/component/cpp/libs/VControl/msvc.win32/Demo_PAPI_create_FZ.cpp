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

extern "C" {
	#include "..\..\GPersn\src\PL_Crypt.h"
	#include "..\..\gkdb\src\pl_Crypt.c"
}

int _tmain(int argc, TCHAR* argv[], TCHAR* envp[])
{
	// initialize MFC and print and error on failure
	if (!AfxWinInit(::GetModuleHandle(0), 0, ::GetCommandLine(), 0))
	{
		// TODO: change error code to suit your needs
		std::cerr << _T("Fatal Error: MFC initialization failed") << std::endl;
		return -1;
	}

	LPPL_BASE_FILE_LIST pLst, pNxt;
	pl_GetFileList((char*)(LPCTSTR)"D:\\c17382", &pLst);
	if(pLst){
		pNxt= pLst;
		do{
			std::cout << pNxt->pFileName << std::endl;
		}while((pNxt= (LPPL_BASE_FILE_LIST)pNxt->pNext) != 0);
		pl_FreeFileList(pLst);
	}
	return 1;

	static char BASED_CODE szFilter[] = "Base standard (*.ndt)|*.ndt|All Files (*.*)|*.*||";

	CFileFind finder;

	if(argc < 5){
		std::cerr << _T("Fatal Error: bad parametrs count !") << std::endl;
		return 0;
	}

	if(!finder.FindFile(	"C:\\CryptoFZ1.bin"
							//argv[1]
							)){
		AfxMessageBox("Файл Заказа не найден !");
		return -4;
	}

#ifndef _DEBUG
	CFileDialog GetNDT( true, 0, 0, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter);
#endif
	std::cout << "Init, please wait..." << std::endl;
	if(pl_InitCrypto(0)
#ifndef _DEBUG
		|| GetNDT.DoModal() != IDOK
#endif
		){
		AfxMessageBox("Исходная эталонная база - не указана !");
		return -1;
	}

	finder.FindNextFile();

	CString FileName;

	int nRetCode= (FileName=
#ifdef _DEBUG
								"e:\\15_25.ndt"
#else
								GetNDT.GetPathName()
#endif
													).ReverseFind('.'), fnd= nRetCode;

	*(((char *)(LPCTSTR)FileName)+nRetCode)= '\0';


	char	LicenseFileName[]		= ".\\SO_LicenseFileName",
			LoginInitiator[]		= "Maker",
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

		strcpy((char*)SeriviceDepPasswordHash.Result, PasswordSerivice);
		pl_Hash(&SeriviceDepPasswordHash);

		strcpy((char*)pTU0->pLogin, LoginReplicator0);
		strcpy((char*)SeriviceRp0PasswordHash.Result, PasswordReplicator0);
		pl_Hash(&SeriviceRp0PasswordHash);
		memcpy(pTU0->pPsswrdHash, SeriviceRp0PasswordHash.Result, PSSWRD_SIZE_PER_BYTES);
		pTU0->BelngsSize= 3;
		pTU0->pTable= (PBYTE)"\0x02\0x13\0x29";

		strcpy((char*)pTU1->pLogin, LoginReplicator1);
		strcpy((char*)SeriviceRp1PasswordHash.Result, PasswordReplicator1);
		pl_Hash(&SeriviceRp1PasswordHash);
		memcpy(pTU1->pPsswrdHash, SeriviceRp1PasswordHash.Result, PSSWRD_SIZE_PER_BYTES);
		pTU1->BelngsSize= 3;
		pTU1->pTable= (PBYTE)"\0x01\0x0f\0x19";


		/*if((nRetCode= pl_CreateLicense(	LicenseFileName,
										LoginInitiator,
										PasswordInitiator,
										LoginSerivice,
										&SeriviceDepPasswordHash,
										2436, // Service ID //
										2, pTU0))){
			pl_DoneCrypto(	//theApp.m_pMainWnd->m_hWnd
							0
							);
			return nRetCode;
		}*/
		// Блок формата ФЗ1 счиатаем из файла,
		// но реально его должен делать АРМ РП или АРМ СО //
		CFile file;
		CFileException fe;
		void *pMemBin= 0;
/*		DWORD sz;

		if (!file.Open(".\\FZ1.bin", CFile::modeRead | CFile::shareDenyWrite, &fe)
				|| (pMemBin= malloc((sz= file.GetLength()))) == 0)
		{
			pl_DoneCrypto(0);
			return 1;
		}
		TRY
		{
			file.ReadHuge(pMemBin, sz);
		}
		CATCH (CFileException, eLoad)
		{
			file.Abort(); // will not throw an exception
			pl_DoneCrypto(0);
			return 2;
		}
		END_CATCH

		if((nRetCode= pl_CreateFileOrder (	(char*)(LPCTSTR)finder.GetFilePath(), 
					// ЗАМЕЧАНИЕ ! при обращении к данной функции из АРМ СО //
					// значение FileNameLicense равно URL сервера ББС //
  											LicenseFileName,
											PasswordSerivice,
								// указатель на блок памяти в формате ФЗ1 //
											pMemBin))){
			pl_DoneCrypto(0);
			AfxMessageBox("Библиотека персонификации. !");
			return nRetCode;
		}
		free(pMemBin);
*/
#ifdef _DEBUG
	LPPL_FZ1_HDR pMem;

	if((nRetCode= gUnCryptoFileOrder_32( (char*)(LPCTSTR)finder.GetFilePath(),
											LoginReplicator0,
											PasswordReplicator0,
											(char**)&pMem))){
		*(((char *)(LPCTSTR)FileName)+fnd)= '.';
		pl_DoneCrypto(0);
		AfxMessageBox("Библиотека персонификации. !");
		return nRetCode;
	}
	int fh;
	if((fh= ace_os_open( "c:\\qqq.fz1", ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY, S_IREAD | S_IWRITE )) != -1){
		ace_os_write(fh, pMem, 801);
		ace_os_close(fh);
	}
	//pl_FreeMem(pMem);
#endif
	//LPPL_BASE_FILE_LIST pLst, pNxt;
	pl_GetFileList((char*)(LPCTSTR)FileName, &pLst);
	pNxt= pLst;
	do{
		std::cout << pNxt->pFileName << std::endl;
	}while((pNxt= (LPPL_BASE_FILE_LIST)pNxt->pNext) != 0);
	pl_FreeFileList(pLst);

	if((nRetCode= gPerson_32(	(char*)(LPCTSTR)FileName,
								argv[2],
								argv[3],
#ifndef _DEBUG
								argv[4]
#else
								"f4e0b3cf316deee4"
#endif
								, (char*)(LPCTSTR)finder.GetFilePath()))){
		*(((char *)(LPCTSTR)FileName)+fnd)= '.';
		pl_DoneCrypto(0);
		AfxMessageBox("Библиотека персонификации. !");
		return nRetCode;
	}
#ifndef _DEBUG
	pl_DoneCrypto(0);
	return nRetCode;
#endif

#ifdef _DEBUG
	LPPL_IMPORT_COMPLECT_DATA pList= 0, pNext;
	LPPL_IMPORT_CIB_DATA pCIBs;

	if((nRetCode= pl_Get_InstalledCIBsFromInstalledDisk(	//"f4e0b3cf316deee4"
															argv[4]
															, argv[2],
															(char*)(LPCTSTR)FileName,
															&pList))){
		*(((char *)(LPCTSTR)FileName)+fnd)= '.';
		pl_DoneCrypto(0);
		AfxMessageBox("Библиотека персонификации. !");
		return nRetCode;
	}

	std::cout << "\n*** Installed HDD ***" << std::endl;
	if((pNext= pList) != 0){
		do{
			std::cout << "--------" << std::endl;
			pCIBs= pNext->pCIBs;
			do{
				std::cout << "\t[" << (LPCTSTR)pCIBs->Alias
					<< "]-[" << (LPCTSTR)pCIBs->pLogin << ']'<< std::endl;
			}while(pCIBs->next != 0 && (pCIBs= (LPPL_IMPORT_CIB_DATA)pCIBs->next) != 0);
		}while(pNext->next != 0 && (pNext= (LPPL_IMPORT_COMPLECT_DATA)pNext->next) != 0);
		std::cout << "--------" << std::endl;

		pl_FreeImportedComplectList(pList);
	}
	pList= 0;

	if((nRetCode= pl_InstallFromHDD(	//argv[4], argv[4],
										"f4e0b3cf316deee4", "f4e0b3cf316deee4",
										(char*)(LPCTSTR)FileName,
										"Work_CD_from_HDD"))){
		*(((char *)(LPCTSTR)FileName)+fnd)= '.';
		pl_DoneCrypto(0);
		AfxMessageBox("Библиотека персонификации. !");
		return nRetCode;
	}
#endif
	*(((char *)(LPCTSTR)FileName)+fnd)= '.';

	pl_DoneCrypto(0);
	return nRetCode;
}


