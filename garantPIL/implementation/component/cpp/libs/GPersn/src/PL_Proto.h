#include "shared/Core/fix/mpcxc.h"
#ifndef PL_INC_PROTO
#define PL_INC_PROTO
	//////////////////////////////////////////////////////////
	// PL_PROTO.H											//
	//														//
	// C/C++ Header file for Personification API			//
	//														//
	//	Order		- �����									//
	//	ServiceDep	- �������� �����						//
	//	Replicator	- ����������� ����						//
	//	CIB			- ��� (���� ������, �.�. NDT,STR � KEY)	//
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
// �������� ��� ��������� � �� ������ �� ���������, ���������� ��,	//
// �� ��� ��, � ��������������� ������ �� �������� ������ ��� ��	//
// ��������� ������.												//
// ������, ������������ � ��� ��� ������� ������ �� ������			//
// ���������� �� ����������� ��������� ����������					//

	extern void __stdcall pl_HashPassword(LPPL_IMPORT_HASH pStruct);

// ������� � ������������� ���������� ������ ���� ����������� � �������� ���� ������������ ������ //
// ���������� ��������� ���, �.�. ���-�� ���� ������������ �� � ���� .OBJ //
	extern void *__stdcall pl_ImportInicatorHashFromBBS(char* LoginInitiator);

/*==========================================================================*/
	//////////////////////////////////////////////////////////
	// �������� �����-����� �������� ��� ����������� ��� �� //
	//////////////////////////////////////////////////////////
	extern int __stdcall pl_CreateMultiLicense(
									char* LicenseFileName,
									char* LoginInitiator,
									char* PasswordInitiator,
									char *AdvancedInfo,
									long ServiceDepCount,
									LPPL_MULTI_SDB_IMPORT_RECRD pServiceDepArray );

	////////////////////////////////////////////////
	// �������� ����� �������� ��� ����������� �� //
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
	// �������� �������������� ����� ������, ������������� � �� //
	//////////////////////////////////////////////////////////////
	extern int __stdcall pl_CreateFileOrder (	char *FileNameOrder, 
				// ��������� ! ��� ��������� � ������ ������� �� ��� �� //
				// �������� FileNameLicense ����� URL ������� ��� //
  									char *FileNameLicense,
									char *PasswordServiceDep,
							// ��������� �� ���� ������ � ������� ��1 //
									void *Mem);

// �������� ! ��� ����������� ������� ��1 ���������� //
// �����������, ��� � ����� ������ �� ����� �������������� ����� //
// ������ �����-������� ���������� ��������������� � ����� ��������. //

// �������� ! ����������� ���� ��� �� ������ ���������� //
// �� ����������� ��������� ���������� //

/*==========================================================================*/
	///////////////////////////////////
	// ����������� ��1 � ���� ������ //
	///////////////////////////////////
	extern int __stdcall gUnCryptoFileOrder_32(	char *FileNameOrder,
												char *LoginReplicator,
												char *PasswordReplicator,
												char **pMem);
	// ���� ����� ������ ��1 //
	#define pl_FreeMem(X) free(X)
/*==========================================================================*/
	//////////////////////////////////////////////////////////////////
	// �������� ��� �� ������ �������� ������� � ��1, �����������	//
	// �� ��														//  
	//////////////////////////////////////////////////////////////////
	extern int __stdcall gPerson_32(	char *BaseFileName, 
										char *LoginReplicator,
										char *PasswordReplicator,
										// ������ �������� ���������� �� //
										// ��������������� �������������� //
										// ����� ��1//
										char *LoginInstalledCIB,
										char *FileNameOrder
#ifndef RD_AS_ETALON
										,long *pRetTime
#endif
										);

/*==========================================================================*/
	///////////////////////////////////////////
	// ���������� ����� ������ � ���� ������ //
	///////////////////////////////////////////
	extern int __stdcall pl_EnCryptoReport(	char *OutputedFileNameReport,
											char *FileNameOrder,
											char *LoginReplicator,
											char *PasswordReplicator,
											char *Mem,	// ���� ������ � ������� ��2 //
											int  MemSize);
/*==========================================================================*/
 	/////////////////////////////////////////
	// ��������� ����� �� ������ � ��� ��  //
	/////////////////////////////////////////
	extern char* __stdcall pl_GetResponce(
	// ���������������� ����� � ������,���������� �������, �������� Breeder32
			char *pPassword,
			char *pLoginService,	// ����� ��
			char *pPasswordService,	// ������ ��
			char *LicenseFileName,	// ��� ����� ��������
			long *pRetData,
			long *pRetID);
 	////////////////////////////////////////////
	// ����������� ����� ������ � ���� ������ //
	////////////////////////////////////////////
	extern int __stdcall pl_UnCryptoReport(
									char *FileNameLicense,
				// ��������� ! ��� ��������� � ������ ������� �� ��� ��	//
				// �������� FileNameLicense ����� URL ������� ���		//
									char *LoginServiceDep,
									char *PasswordServiceDep,
									char *FileNameReport,
					void **ppMem	// ���� ������ ���������� ����� ������� ������ //
									// ��������� �� ����� ������				   //
									);
	// ����� �������� �� ������ ������� MemSize �������� �����	//
	// ����� ��������������� ����� ������						//
	extern int __stdcall pl_FreeMemWithReport(void *pMem);
/*==========================================================================*/
	//////////////////////////////////////////////
	// ����������� ���������� �� ����� �������� //
	//////////////////////////////////////////////
	extern int __stdcall pl_UnCryptoAvancedInfo(
									char *FileNameLicense,
				// ��������� ! ��� ��������� � ������ ������� �� ��� ��	//
				// �������� FileNameLicense ����� URL ������� ���		//
									char *LoginServiceDep,
									char *PasswordServiceDep,
					char **ppStr	// ���� ������ ���������� ������ ����������	//
									);
	extern int __stdcall pl_FreeMemWithAvancedInfo(char *pStr);
/*==========================================================================*/
	//////////////////////////////////////////////////////////////////////////////////
	// ��������� ��������� ������ ���-�� ��������� ��� ���������� � ����������� ��� //
	//////////////////////////////////////////////////////////////////////////////////
	extern int pl_Get_InstalledCIBsFromInstalledDisk(	char *LoginCIB,
																char *LoginReplicator,
																char *BaseFileName,
																LPPL_IMPORT_COMPLECT_DATA *ppList);
	// ����� ������� ���� 
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
	// ����������� ���������� ���-� � ����������� ��� //
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
