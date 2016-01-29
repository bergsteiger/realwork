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
	#include "PL_Defs.h"
	#include "PL_Types.h"

	extern int	pl_InitCrypto(HANDLE hWnd);
	extern void	pl_DoneCrypto(HANDLE hWnd);
	extern int	pl_GetLastError(int iErrorCode, char** ppRet);
/*==========================================================================*/
// ВНИМАНИЕ При заведении в БС любого из субъектов, являющихся ПУ,	//
// ТУ или СО, в соответствующую запись БД вносится только Хеш от	//
// введённого пароля.												//
// Пароль, содержащийся в ОЗУ как цепочка байтов НЕ ДОЛЖЕН			//
// появляться на статических носителях информации					//

	// memcopy(pStruct->Result, pPassword, len);
	// len = strlen(pPassword);
	// if(len < SIZE_SYNHRO_PER_DWORD)
	//		memcopy(pStruct->Result, pPassword, len);
	// else
	//		memcopy(pStruct->Result, pPassword, SIZE_SYNHRO_PER_DWORD);

	extern void pl_Hash(LPPL_IMPORT_HASH pStruct);
	// после возврата из данной функции цепочка байтов, содержащая значения //
	// пароля содержит Хеш //

/*==========================================================================*/
	////////////////////////////////////////////////
	// Создание файла лицензии для конкретного СО //
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
	// Создание зашифрованного файла заказа, отправляемого в ТУ //
	//////////////////////////////////////////////////////////////
	extern int pl_CreateFileOrder (	char *FileNameOrder, 
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
	extern int pl_UnCryptoOrder(	char *FileNameOrder,
									char *LoginReplicator,
									char *PasswordReplicator,
									void **pMem,// указатель на блок памяти, отводимый и //
												// заполняемый внутри данной функции //
												///////////////////////////////////////
									int *MemSize// длина упомянутого блока памяти //
									);
	// после возврата из pl_UnCryptoOrder MemSize содержит длину //
	// оного блока памяти. Блок имеет формат ФЗ1 //

	#define pl_FreeMem(X) free(X)

/*==========================================================================*/
	//////////////////////////////////////////////////////////////////
	// Создание ППД на основе текущего эталона и ФЗ1, полученного	//
	// из СО														//  
	//////////////////////////////////////////////////////////////////
	extern int pl_CreateInsalledDisk(	char *FileNameOrder,
										char *BaseFileName, 
										char *LoginReplicator,
										char *PasswordReplicator,
										// Данной значение выбирается из //
										// соответствующей расшифрованной //
										// копии ФЗ1//
										char *LoginInstalledCIB);

/*==========================================================================*/
	///////////////////////////////////////////
	// Зашифровка блока памяти в файл отчёта //
	///////////////////////////////////////////
	extern int pl_EnCryptoReport(	char *OutputedFileNameReport,
									char *FileNameOrder,
									char *LoginReplicator,
									char *PasswordReplicator,
									void *Mem,	// блок памяти в формате ФЗ2	//
									int  MemSize);
/*==========================================================================*/
	////////////////////////////////////////////
	// Расшифровка файла отчёта в блок памяти //
	////////////////////////////////////////////
	extern int pl_UnCryptoReport(	char *FileNameLicense,
				// ЗАМЕЧАНИЕ ! при обращении к данной функции из АРМ СО	//
				// значение FileNameLicense равно URL сервера ББС		//
									char *LoginServiceDep,
									char *PasswordServiceDep,
						void *Mem,	// блок памяти содержащий копию цепочки байтов	//
									// считанных из файла отчета					//
									// длина упомянутого блока памяти				//
									int MemSize);
	// после возврата из данной функции MemSize содержит длину	//
	// оного расшифрованного блока памяти						//
/*==========================================================================*/
	//////////////////////////////////////////////////////////////////////////////////
	// получение Возможных Клиент/КИБ-ов доступных для инсталяции с конкретного ППД //
	//////////////////////////////////////////////////////////////////////////////////
	extern int pl_Get_InstalledCIBsFromInstalledDisk(	char *LoginCIB,
														char *LoginReplicator,
														char *BaseFileName,
														LPPL_IMPORT_COMPLECT_DATA *ppList);
	// Чтобы чистить лист 
	extern void pl_FreeImportedComplectList(LPPL_IMPORT_COMPLECT_DATA ppList);
/*==========================================================================*/
	////////////////////////////////////////////////////
	// Инсталляция Возможного КИБ-а с конкретного ППД //
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
