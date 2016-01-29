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
	#include "PL_Defs.h"
	#include "PL_Types.h"

	extern int	pl_InitCrypto(HANDLE hWnd);
	extern void	pl_DoneCrypto(HANDLE hWnd);
	extern int	pl_GetLastError(int iErrorCode, char** ppRet);
/*==========================================================================*/
// �������� ��� ��������� � �� ������ �� ���������, ���������� ��,	//
// �� ��� ��, � ��������������� ������ �� �������� ������ ��� ��	//
// ��������� ������.												//
// ������, ������������ � ��� ��� ������� ������ �� ������			//
// ���������� �� ����������� ��������� ����������					//

	// memcopy(pStruct->Result, pPassword, len);
	// len = strlen(pPassword);
	// if(len < SIZE_SYNHRO_PER_DWORD)
	//		memcopy(pStruct->Result, pPassword, len);
	// else
	//		memcopy(pStruct->Result, pPassword, SIZE_SYNHRO_PER_DWORD);

	extern void pl_Hash(LPPL_IMPORT_HASH pStruct);
	// ����� �������� �� ������ ������� ������� ������, ���������� �������� //
	// ������ �������� ��� //

/*==========================================================================*/
	////////////////////////////////////////////////
	// �������� ����� �������� ��� ����������� �� //
	////////////////////////////////////////////////
	extern int pl_CreateLicense(	char* LicenseFileName,
									char* LoginInitiator,
									char* PasswordInitiator,
									char* LoginSerivice,
									LPPL_IMPORT_HASH pSeriviceDepPasswordHash,
									long ServiceDepID,
									long FriendedReplicatorsCount,
									LPPL_SDB_IMPORT_RECRD pFriendedReplicatorsList );
/*==========================================================================*/
	//////////////////////////////////////////////////////////////
	// �������� �������������� ����� ������, ������������� � �� //
	//////////////////////////////////////////////////////////////
	extern int pl_CreateFileOrder (	char *FileNameOrder, 
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
	extern int pl_UnCryptoOrder(	char *FileNameOrder,
									char *LoginReplicator,
									char *PasswordReplicator,
									void **pMem,// ��������� �� ���� ������, ��������� � //
												// ����������� ������ ������ ������� //
												///////////////////////////////////////
									int *MemSize// ����� ����������� ����� ������ //
									);
	// ����� �������� �� pl_UnCryptoOrder MemSize �������� ����� //
	// ����� ����� ������. ���� ����� ������ ��1 //

	#define pl_FreeMem(X) free(X)

/*==========================================================================*/
	//////////////////////////////////////////////////////////////////
	// �������� ��� �� ������ �������� ������� � ��1, �����������	//
	// �� ��														//  
	//////////////////////////////////////////////////////////////////
	extern int pl_CreateInsalledDisk(	char *FileNameOrder,
										char *BaseFileName, 
										char *LoginReplicator,
										char *PasswordReplicator,
										// ������ �������� ���������� �� //
										// ��������������� �������������� //
										// ����� ��1//
										char *LoginInstalledCIB);

/*==========================================================================*/
	///////////////////////////////////////////
	// ���������� ����� ������ � ���� ������ //
	///////////////////////////////////////////
	extern int pl_EnCryptoReport(	char *OutputedFileNameReport,
									char *FileNameOrder,
									char *LoginReplicator,
									char *PasswordReplicator,
									void *Mem,	// ���� ������ � ������� ��2	//
									int  MemSize);
/*==========================================================================*/
	////////////////////////////////////////////
	// ����������� ����� ������ � ���� ������ //
	////////////////////////////////////////////
	extern int pl_UnCryptoReport(	char *FileNameLicense,
				// ��������� ! ��� ��������� � ������ ������� �� ��� ��	//
				// �������� FileNameLicense ����� URL ������� ���		//
									char *LoginServiceDep,
									char *PasswordServiceDep,
						void *Mem,	// ���� ������ ���������� ����� ������� ������	//
									// ��������� �� ����� ������					//
									// ����� ����������� ����� ������				//
									int MemSize);
	// ����� �������� �� ������ ������� MemSize �������� �����	//
	// ����� ��������������� ����� ������						//
/*==========================================================================*/
	//////////////////////////////////////////////////////////////////////////////////
	// ��������� ��������� ������/���-�� ��������� ��� ���������� � ����������� ��� //
	//////////////////////////////////////////////////////////////////////////////////
	extern int pl_Get_InstalledCIBsFromInstalledDisk(	char *LoginCIB,
														char *LoginReplicator,
														char *BaseFileName,
														LPPL_IMPORT_COMPLECT_DATA *ppList);
	// ����� ������� ���� 
	extern void pl_FreeImportedComplectList(LPPL_IMPORT_COMPLECT_DATA ppList);
/*==========================================================================*/
	////////////////////////////////////////////////////
	// ����������� ���������� ���-� � ����������� ��� //
	////////////////////////////////////////////////////
	extern int pl_MakeCIBFromInstalledDisk(	void *pContext,
											char *InputedBaseFileName,
#ifdef BRDR32
											char *OutputedBasePath,
#endif
											char *LoginHDD,
											char *PasswordHDD
#ifdef BRDR32
											,char *LoginCIB
#endif
											);

	#ifdef  __cplusplus
		}
	#endif
#endif
