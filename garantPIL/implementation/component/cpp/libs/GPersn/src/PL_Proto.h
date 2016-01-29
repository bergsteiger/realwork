#include "shared/Core/fix/mpcxc.h"
#ifndef PL_INC_PROTO
#define PL_INC_PROTO
	//////////////////////////////////////////////////////////
	// PL_PROTO.H											//
	//														//
	// C/C++ Header file for Personification API			//
	//														//
	//	Order		- Заказ									//
	//	ServiceDep	- Сбытовой Отдел						//
	//	Replicator	- Тиражирущий Узел						//
	//	CIB			- КИБ (база Гарант, т.е. NDT,STR и KEY)	//
	//														//
	//////////////////////////////////////////////////////////
#ifdef  __cplusplus
	extern "C" {
#endif

#ifdef	__SIMPLE_LOCALES__
	extern void *_memcpy_Delphi(void *, const void*, int);
	#define	MEMCPY _memcpy_Delphi
#else
	#define	MEMCPY memcpy
#endif
	#include "PL_Defs.h"
	#include "PL_Types.h"

	extern int	__stdcall	pl_InitCrypto(HANDLE hWnd);
	extern void	__stdcall	pl_DoneCrypto(HANDLE hWnd);
	extern char* __stdcall	pl_GetLastError(int iErrorCode);
	extern int __stdcall pl_GetCryptoHeader();
	extern int __stdcall EnCryptoMem(	void *pMemBlock,	int iSizeMemBlock,
										void *pKey,			int iSizeKey);
	extern int __stdcall UnCryptoMem(	void *pMemBlock,	int iSizeMemBlock,
										void *pKey,			int iSizeKey);
/*==========================================================================*/
// ВНИМАНИЕ При заведении в БС любого из субъектов, являющихся ПУ,	//
// ТУ или СО, в соответствующую запись БД вносится только Хеш от	//
// введённого пароля.												//
// Пароль, содержащийся в ОЗУ как цепочка байтов НЕ ДОЛЖЕН			//
// появляться на статических носителях информации					//

	extern void __stdcall pl_HashPassword(LPPL_IMPORT_HASH pStruct);

// Функция с нижеуказааным прототипом должна быть реализована в сегменте кода программного модуля //
// интрефэйса менеджера ББС, т.е. там-же куда встраивается БП в виде .OBJ //
	extern void *__stdcall pl_ImportInicatorHashFromBBS(char* LoginInitiator);

/*==========================================================================*/
	//////////////////////////////////////////////////////////
	// Создание мулти-файла лицензии для конкретного АРМ РП //
	//////////////////////////////////////////////////////////
	extern int __stdcall pl_CreateMultiLicense(
									char* LicenseFileName,
									char* LoginInitiator,
									char* PasswordInitiator,
									char *AdvancedInfo,
									long ServiceDepCount,
									LPPL_MULTI_SDB_IMPORT_RECRD pServiceDepArray );

	////////////////////////////////////////////////
	// Создание файла лицензии для конкретного СО //
	////////////////////////////////////////////////
	extern int __stdcall pl_CreateLicense(
									char* LicenseFileName,
									char* LoginInitiator,
									char* PasswordInitiator,
									char* LoginSerivice,
									LPPL_IMPORT_HASH pSeriviceDepPasswordHash,
									long ServiceDepID,
									char *AdvancedInfo,
									long FriendedReplicatorsCount,
									LPPL_SDB_IMPORT_RECRD pFriendedReplicatorsList );
/*==========================================================================*/
	//////////////////////////////////////////////////////////////
	// Создание зашифрованного файла заказа, отправляемого в ТУ //
	//////////////////////////////////////////////////////////////
	extern int __stdcall pl_CreateFileOrder (	char *FileNameOrder, 
				// ЗАМЕЧАНИЕ ! при обращении к данной функции из АРМ СО //
				// значение FileNameLicense равно URL сервера ББС //
  									char *FileNameLicense,
									char *PasswordServiceDep,
							// указатель на блок памяти в формате ФЗ1 //
									void *Mem);

// ВНИМАНИЕ ! для адекватного анализа ФЗ1 необходимо //
// подчеркнуть, что в одном заказе не может присутствовать более //
// одного много-КИБовых комплектов ассоциированных с одним клиентом. //

// ВНИМАНИЕ ! оперируемый блок ОЗУ НЕ ДОЛЖЕН появляться //
// на статических носителях информации //

/*==========================================================================*/
	///////////////////////////////////
	// Расшифровка ФЗ1 в блок памяти //
	///////////////////////////////////
	extern int __stdcall gUnCryptoFileOrder_32(	char *FileNameOrder,
												char *LoginReplicator,
												char *PasswordReplicator,
												char **pMem);
	// Блок имеет формат ФЗ1 //
	#define pl_FreeMem(X) free(X)
/*==========================================================================*/
	//////////////////////////////////////////////////////////////////
	// Создание ППД на основе текущего эталона и ФЗ1, полученного	//
	// из СО														//  
	//////////////////////////////////////////////////////////////////
	extern int __stdcall gPerson_32(	char *BaseFileName, 
										char *LoginReplicator,
										char *PasswordReplicator,
										// Данной значение выбирается из //
										// соответствующей расшифрованной //
										// копии ФЗ1//
										char *LoginInstalledCIB,
										char *FileNameOrder
#ifndef RD_AS_ETALON
										,long *pRetTime
#endif
										);

/*==========================================================================*/
	///////////////////////////////////////////
	// Зашифровка блока памяти в файл отчёта //
	///////////////////////////////////////////
	extern int __stdcall pl_EnCryptoReport(	char *OutputedFileNameReport,
											char *FileNameOrder,
											char *LoginReplicator,
											char *PasswordReplicator,
											char *Mem,	// блок памяти в формате ФЗ2 //
											int  MemSize);
/*==========================================================================*/
 	/////////////////////////////////////////
	// Получение ответ на пароль в АРМ РП  //
	/////////////////////////////////////////
	extern char* __stdcall pl_GetResponce(
	// шестадцатиричное число в строке,являющиеся паролем, выданным Breeder32
			char *pPassword,
			char *pLoginService,	// Логин СО
			char *pPasswordService,	// Пароль СО
			char *LicenseFileName,	// Имя файла лицензии
			long *pRetData,
			long *pRetID);
 	////////////////////////////////////////////
	// Расшифровка файла отчёта в блок памяти //
	////////////////////////////////////////////
	extern int __stdcall pl_UnCryptoReport(
									char *FileNameLicense,
				// ЗАМЕЧАНИЕ ! при обращении к данной функции из АРМ СО	//
				// значение FileNameLicense равно URL сервера ББС		//
									char *LoginServiceDep,
									char *PasswordServiceDep,
									char *FileNameReport,
					void **ppMem	// блок памяти содержащий копию цепочки байтов //
									// считанных из файла отчета				   //
									);
	// после возврата из данной функции MemSize содержит длину	//
	// оного расшифрованного блока памяти						//
	extern int __stdcall pl_FreeMemWithReport(void *pMem);
/*==========================================================================*/
	//////////////////////////////////////////////
	// Расшифровка Информации из файла лицензии //
	//////////////////////////////////////////////
	extern int __stdcall pl_UnCryptoAvancedInfo(
									char *FileNameLicense,
				// ЗАМЕЧАНИЕ ! при обращении к данной функции из АРМ СО	//
				// значение FileNameLicense равно URL сервера ББС		//
									char *LoginServiceDep,
									char *PasswordServiceDep,
					char **ppStr	// блок памяти содержащий строку информации	//
									);
	extern int __stdcall pl_FreeMemWithAvancedInfo(char *pStr);
/*==========================================================================*/
	//////////////////////////////////////////////////////////////////////////////////
	// получение Возможных частей КИБ-ов доступных для инсталяции с конкретного ППД //
	//////////////////////////////////////////////////////////////////////////////////
	extern int pl_Get_InstalledCIBsFromInstalledDisk(	char *LoginCIB,
																char *LoginReplicator,
																char *BaseFileName,
																LPPL_IMPORT_COMPLECT_DATA *ppList);
	// Чтобы чистить лист 
	extern int pl_FreeImportedComplectList(LPPL_IMPORT_COMPLECT_DATA);
/*==========================================================================*/
#if defined(WIN32) && defined(MAKE_HDDD)
	extern int __stdcall pl_GetFileList(char *InputedBaseFileName, LPPL_BASE_FILE_LIST *ppList);
	extern int __stdcall pl_FreeFileList(LPPL_BASE_FILE_LIST pList);
	extern int __stdcall gCopyPX_32(char *RestoreFileName, char *BackupFileName);
	extern int __stdcall pl_FreeMemWithCryptoOrder(char *pMem);
#endif
/*==========================================================================*/
	////////////////////////////////////////////////////
	// Инсталляция Возможного КИБ-а с конкретного ППД //
	////////////////////////////////////////////////////
#ifdef BRDR32
	extern int pl_MakeCIBFromInstalledDisk(	void *pContext,
											char *InputedBaseFileName,
											char *OutputedBasePath,
											char *LoginHDD,
											char *PasswordHDD,
											char *LoginCIB);
#else
	extern int __stdcall gBreeder_32(	char *InputedBaseFileName,
										char *LoginReplicator,
										char *PasswordReplicator,
										char *LoginHDD);

	extern int pl_InstallFromHDD(	char *LoginHDD, char *PassHDD,
									char *FZ1FileBase,
									char *LoginCIB);
#endif

#if defined(WIN32) && !defined(BRDR32)
	#define alloc_in_heap(x)			((LPVOID)LocalAlloc(0, x))
	#define free_in_heap(x)				LocalFree(x)
#ifdef INSTLL_CIB
	#define CreateFileHandle(x,y,z)		c_io_open(x,y) // GARANT_XXX
	#define CloseFileHandle(hh)		c_io_close(hh);
	#define SetFilePos(hh, pp, tt)		c_io_lseek(hh, pp, tt)
	#define WriteInFile(hh, pp, tt)		c_io_write(hh, pp, tt)
	#define ReadFromFile(hh, pp, tt)	c_io_read(hh, pp, tt)
#else
	#define CreateFileHandle(x,y,z)		c_io_open(x,y) 
	#define CloseFileHandle(hh)		c_io_close(hh)
	#define SetFilePos(hh, pp, tt)		c_io_lseek(hh, pp, tt)
	#define WriteInFile(hh, pp, tt)		c_io_write(hh, pp, tt)
	#define ReadFromFile(hh, pp, tt)	c_io_read(hh, pp, tt)
#endif
	#define GetFilePos(hh)			c_io_lseek(hh, 0, SEEK_CUR)
	#define RemoveFile(hh)			ace_os_unlink(hh)
	#define MemCopy(pp0, pp1, pp2)		memcpy(pp0, pp1, pp2)
	#define MemComp(pp0, pp1, pp2)		memcmp(pp0, pp1, pp2)
	#define MemSeting(pp0, pp1, pp2)	memset(pp0, pp1, pp2)
	#define MemChar(pp0, pp1, pp2)		memchr(pp0, pp1, pp2)
	#define StrLength(pp0)			strlen(pp0)
	#define StrRFind(pp0, pp1)		strrchr(pp0, pp1)
	#define StrReverse(pp0)			mpcxc_strrev(pp0)
	#define LocSort(pp0, pp1, pp2, pp3)	qsort(pp0, pp1, pp2, pp3)
	#define GetCurrentDate(pp0)			ace_os_date_win32(pp0)
/*
	#define MemCopy(pp0, pp1, pp2)		memcpy_Win32(pp0, pp1, pp2)
	#define MemComp(pp0, pp1, pp2)		memcmp_Win32(pp0, pp1, pp2)
	#define MemSeting(pp0, pp1, pp2)	memset_Win32(pp0, pp1, pp2)
	#define MemChar(pp0, pp1, pp2)		memchr_Win32(pp0, pp1, pp2)
	#define StrLength(pp0)				strlen_Win32(pp0)
	#define StrRFind(pp0, pp1)			strrchr_Win32(pp0, pp1)
	#define MemFind(pp0, pp1, pp2)		memchr_Win32(pp0, pp1, pp2)
	#define MemStrRFind(pp0, pp1, pp2)	memstrchr_Win32(pp0, pp1, pp2)
	#define StrReverse(pp0)				strrev_Win32(pp0)
	#define GetCurrentDate(pp0)			date_Win32(pp0)
	#define LocSort(pp0, pp1, pp2, pp3)	qsort_Win32(pp0, pp1, pp2, pp3)
*/
#else // MPCXC not windows our case
  #ifndef __WIN16__
	#define alloc_in_heap(x)			malloc(x)
	#define free_in_heap(x)				free(x)
  #endif
	#define CreateFileHandle(x,y,z)		c_io_open(x,y) // GARANT_XXX
	#define CloseFileHandle(hh)		c_io_close(hh);
	#define SetFilePos(hh, ppp, ttt)	c_io_lseek(hh, ppp, ttt)
	#define WriteInFile(hh, pp, tt)		c_io_write(hh, pp, tt)
	#define ReadFromFile(hh, pp, tt)	c_io_read(hh, pp, tt)
	#define GetFilePos(hh)			c_io_lseek(hh, 0, ACE_OS_SEEK_CUR)
	#define RemoveFile(hh)			ace_os_unlink(hh)
	#define MemCopy(pp0, pp1, pp2)		memcpy(pp0, pp1, pp2)
	#define MemComp(pp0, pp1, pp2)		memcmp(pp0, pp1, pp2)
	#define MemSeting(pp0, pp1, pp2)	memset(pp0, pp1, pp2)
	#define MemChar(pp0, pp1, pp2)		memchr(pp0, pp1, pp2)
	#define StrLength(pp0)			strlen(pp0)
	#define StrRFind(pp0, pp1)		strrchr(pp0, pp1)
	#define StrReverse(pp0)			mpcxc_strrev(pp0)
	#define LocSort(pp0, pp1, pp2, pp3)	qsort(pp0, pp1, pp2, pp3)
//#if defined(WIN32) || defined(GARANT_MPCXC) // GARANT_PLAN
	#define GetCurrentDate(pp0)			ace_os_date_win32(pp0)
//#endif
#endif

	#ifdef  __cplusplus
		}
	#endif
#endif
