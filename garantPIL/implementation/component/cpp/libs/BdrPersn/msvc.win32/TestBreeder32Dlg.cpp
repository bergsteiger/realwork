// TestBreeder32Dlg.cpp : implementation file
//

#include "stdafx.h"

#include <wininet.h>

#include "recode.h"
#include "TestBreeder32.h"
#include "TestBreeder32Dlg.h"
#include "selcttreectrl.h"
#include "NewName.h"

#include "stdbase.h"

#include "LoginDlg.h"
#include "PathMsgDlg.h"

#include "shared/Core/Params/Params.h"
#include "shared/Internet/impl/Inet_i/Connect_i_factory.h"
#include "shared/Internet/impl/Inet_i/Connection_i_factory.h"
#include "shared/Internet/Manage/ConnectManager.h"
#include "shared/Internet/Inet/Inet.h"
#include "shared/GCL/alg/cryptography.h"

#ifdef	_GCD_CLIENT
#include "ace/ACE.h"
#include "htmlhelp.h"
#include "SyncUpdate.h"
#include "SelectBaseFolder.h"
#include "WaitServer.h"
#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Services/GslDataPipe/Server/PipeManager_i.h"
#include "garantServer/src/Services/GslDataPipe/Server/Stream.h"
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

static char realPass[128];
#ifdef VERSION63
	static long Export_ID_CIB, PL_Process_step= (1001 + 1001);
#endif

#define DEALER_FILE_NAME "dealer.inf"
#define MAXIMUM_COUNT_SEGS 20
//#define AS_HDD_ROOT

static CString curTitle("");

char bkpMask[]= "~*.*";
#include "../../../libs/cchlp/src/QMap.hpp"
typedef QuickSplayMap<int,char> fHandlesMap;
fHandlesMap allFHndls(0);

static int gCopyKill= 0, waitCopy= 1, waitKill= 0, gBrwsAfterReadError= 0, gBrwsAfterReadErrorNot= 0, waitKillAsBrowse= 0;


extern "C" {
	int gsplit_Method(int argc, char **argv, void *pCntx);
	#include "../../../libs/protins/src/pfunc.c"
	extern DWORD CryptoTick();
#ifndef	_GCD_CLIENT
	int makedKey, makedStr, makedNdt, makedTmp;
#endif
	extern unsigned long adler32(	unsigned long adler,
									const unsigned char *buf,
									unsigned int len);
	char *pUnPackFrmt, *NotFreeSpace;
	extern void local_sscanf2( char *, PDWORD, PDWORD);
	extern void local_sprintfX( char *, DWORD, DWORD);
	extern DWORD CryptoTick();
#ifndef RD_AS_ETALON
	extern int _InitHash();
#endif
	extern void impModifyName(char *);
	extern int CompStringsZZZX(const void *l1, const void *l2);
}

#include "../../../tools/update/Utils.cpp"
#include "../../../tools/update/AnimateDlgIcon.cpp"
#include "../../../tools/update/Protection.cpp"
#include "../../../tools/update/TryToOpenBases.cpp"

const char*  ATTR_NAME_MAX_USERS			= "MU"; //"MaxUsers";
const char* ATTR_NAME_PERM_USERS		= "PU"; //"PermUsers";
const char* ATTR_NAME_MAX_PROFILES		= "MP"; //"MaxProfiles";

u_int16_t sid = 0;

bool	remoteInstall = false;
char	remotePath[ MAX_PATH ];

bool b_module_filename_taken = false;
char module_filename [MAX_PATH];
	
bool b_real_base_name_taken = false;
char real_base_name [MAX_PATH];
	
int inBkp, pcPreInst2Gfiles= 0;
char *ppPreInst2Gfiles[2048];

typedef struct BKP_FILE_TAG
{
	char *pFullName;
	int offsExt;
} BKP_FILE, *LPBKP_FILE;

BKP_FILE gbkp_files[2048];
int gbkp_files_count= 0;

char BRDR_EXIT[2]= "\x03";
#define IS_BRDR_EXIT_MSG !strcmp(BRDR_EXIT,pText)

LONGLONG CorrectMyGetDiskFreeSpace( LPCTSTR aPath )
{
	LONGLONG retS= 0;
	if (b_real_base_name_taken) {
		char correct_path [MAX_PATH];
		strcpy (correct_path, real_base_name);
		if (real_base_name[0] == '\\' ) {
			*(strchr (strchr (correct_path+2, '\\')+1, '\\')+1) = '\0';
		} else {
			if (strrchr (correct_path, '\\'))
				*strrchr (correct_path, '\\') = 0;
		}
		retS= MyGetDiskFreeSpace (correct_path);
	} else {
		retS= MyGetDiskFreeSpace(aPath);
		CFileFind ffB;
		char ppB[4000], *ff= (char*)(strrchr(aPath,'\\'));
		inBkp= 0;
		if(ff){
			BOOL nxt;
			ff[0]= 0;
			sprintf(ppB,"%s\\%s",aPath,bkpMask);
			ff[0]= '\\';
			if(ffB.FindFile(ppB)){
				do{
					nxt= ffB.FindNextFile();
					retS += 0x7fffffff;
					if(ffB.GetFileName()[1] == '-')
						inBkp += (int)(((ffB.GetLength()/1024)/1024)&0x7fffffff);
					else
						inBkp += 2*1024;
					if(!nxt)
						ffB.Close();
				}while(nxt);
			}
		}
	}
	return retS;
	/*
	if (!b_module_filename_taken) {
		ACE_OS::strcpy (module_filename, Core::ParamManagerFactory::get ().get_string ("-GCMConfigFile").c_str ());
		b_module_filename_taken = true;
	}
	if (strlen(module_filename)) {
		LONGLONG result;
		if (module_filename[0] == '\\' ) {
			char correct_path [MAX_PATH];
			strcpy (correct_path, module_filename);
			*(strchr (strchr (correct_path+2, '\\')+1, '\\')+1) = '\0';
			result = MyGetDiskFreeSpace (correct_path);
		} else {
			char newpath [4];
			newpath [3] = 0;
			strncpy (newpath, module_filename, 3);
			result = MyGetDiskFreeSpace (newpath);
		}
		return result;
	} else {
		return MyGetDiskFreeSpace(aPath);
	}
	*/
}

extern "C" {
	unsigned long OtherDiskFreeSpace()
	{
		if ( remoteInstall )
			return (unsigned long) (MyGetDiskFreeSpace( remotePath ) / 1024 );
		else
		return (unsigned long)(CorrectMyGetDiskFreeSpace("\\")/1024);
	}
#ifndef RD_AS_ETALON
	extern long _getAnswerVal(long);
	long MaskAnswerVal= 0x12345678;
	int Answertoi(char *pStr)
	{
		char Valstr[8], *pStrTmp= Valstr;
		while(pStrTmp != Valstr+7 && *pStr){
			if(*pStr < ':' && *pStr > '/'){
				*pStrTmp= *pStr;
				pStrTmp++;
			}
			pStr++;
		}
		*pStrTmp= 0;
		long val= atoi(Valstr) ^ MaskAnswerVal;
		if(MaskAnswerVal)
			return _getAnswerVal(val);
		return ((val^((val >> 10) & 0x3ff)) & 0x3ff);
	}
	char *returnRD_Name(char *pAlias)
	{
		return (char*)memchr(pAlias, 0, 0xffff) + 1;
	}
	char *returnRD_Blngs(char *pAlias)
	{
		return (char*)memchr(returnRD_Name(pAlias), 0, 0xffff) + 1;
	}
	unsigned long *returnRD_ClntHash(char *pAlias)
	{
		return (unsigned long *)
						((char*)memchr(returnRD_Blngs(pAlias), 0, 0xffff) + 1);
	}
	unsigned long *returnVIP_Flag(char *pAlias)
	{
		return returnRD_ClntHash(pAlias)+1;
	}
	unsigned long *returnID_Service(char *pAlias)
	{
		return returnVIP_Flag(pAlias)+1;
	}
	unsigned long *returnID_CIB(char *pAlias)
	{
		return returnID_Service(pAlias)+1;
	}
	unsigned long *returnServerType_CIB(char *pAlias)
	{
		return returnID_CIB(pAlias)+1;
	}
	unsigned long *returnID_User_CIB(char *pAlias)
	{
		return returnServerType_CIB(pAlias)+1;
	}
	unsigned long *returnDelivery_Type(char *pAlias)
	{
		return returnID_User_CIB(pAlias)+1;
	}
	extern void HashDWORD(PDWORD);
	char *FloppyLabels[]= {"CLASSICP","UNIVERSP","EXPERT","ENGONE",
		"ENGTWO","UNIVCONS","PROFCONS","MASTCONS", "MAXICONS","SMAXIMUM",
		"ENGTHR","CPRACONS","BUS&LAW","EXPECONS","ENGFOU", "ENGFIV","ENGSIX",
		"ARBITR","PRIVATE","COMMENT","MAXIMUM","MASTER","UNIVERSL", "CLASSIC",
		"CPRAKTIK","MEDICINE","PROFESNL","\x8f\xe0\xae\xe7\xa5\xa5",""};
	extern DWORD CryptoTick();
	extern char *pl_getPassword(long, long, long, long *);
	extern char *pl_getResponce(char *, long *, long *, long*);
	char *pCrptInfo;
#endif
	extern void Hash(PDWORD);
}

#define CHECK_PERIOD_IN_MS 2000
#define MAX_TIM_IN_MS 180000

CString	Msg_0,Msg_1,Msg_2,Msg_3,Frmt0,Frmt01,Frmt1,Frmt1a,Frmt2,
				Frmt3,Frmt20,Frmt21,Frmt30,Frmt31,Frmt31a,Frmt41,Msg_20,
				Msg_21,Msg_50,Msg_51,Msg_60a,Msg_60,Msg_61,Frmt50,
				Frmt51,Frmt52,Msg_62,Msg_63,Msg_64,Msg_65,Msg_66,Msg_67,Msg_68,
				Bad_Installed_CIBs,NotFind_Installed_CIBs,
				Msg_69, Msg_70, Msg_71, Msg_72, Msg_73, Msg_74, Msg_75, Msg_76,
#ifndef RD_AS_ETALON
				Msg_P01,Msg_P02,Msg_P03,Msg_P04,Msg_P05,Msg_P06,Msg_P07,Msg_P08,
#endif
				Msg_77, Msg_78, Msg_79, Msg_80, Msg_81, Msg_82, Msg_83, Msg_84, Msg_85, Msg_86,
				Msg_100, Msg_101, Msg_102, Msg_103, Msg_104;

#if !defined(RD_AS_ETALON)// && !defined(ONLY_DISTR_WITH_KEY)
	static long TypeProtect= 0;
#endif

long GetInPharmFilesSize(CString *p_path, CStringArray *p_InPharmFiles)
{
	long AllSize= 0;
	BOOL nxt;
	CString SubFiles;
	CStringArray NewFiles;
	CFileFind finder;
	NewFiles.RemoveAll();
	int ii = 0, jj = 0; // GARANT_FORSCOPING
	for(ii= 0; ii < p_InPharmFiles->GetSize(); ii++){
		SubFiles= *p_path + p_InPharmFiles->GetAt(ii);
		if(finder.FindFile(SubFiles)){
		  do{
			nxt= finder.FindNextFile();
			if(finder.IsDots())
				;
			else if(finder.IsDirectory()){
				SubFiles += '\\';
				CStringArray TmpFiles;
				TmpFiles.RemoveAll();
				TmpFiles.Add("*.*");
				AllSize += GetInPharmFilesSize(&SubFiles, &TmpFiles);
				SubFiles= p_InPharmFiles->GetAt(ii) + '\\';
				for(jj= 0; jj < TmpFiles.GetSize(); jj++){
					NewFiles.Add(SubFiles + TmpFiles.GetAt(jj));
				}
				finder.Close();
			}else{
				AllSize += (long)(finder.GetLength() && 0xffffffff);
				NewFiles.Add(finder.GetFileName());
				if(!nxt)
					finder.Close();
			}
		  }while(nxt);
		}
	}
	p_InPharmFiles->RemoveAll();
	for(jj= 0; jj < NewFiles.GetSize(); jj++){
		p_InPharmFiles->Add(NewFiles.GetAt(jj));
	}
	return AllSize;
}

typedef struct B_TSTPASS_TAG
{
	CTestBreeder32Dlg *pDlg;
	int *tLock, fLocked;
	BOOL tstPass;
} B_TSTPASS, *LPB_TSTPASS;

#include <sys/locking.h>
#include <share.h>

void tickProc111(LPB_TSTPASS pTCntxt)
{
	while(*pTCntxt->tLock) Sleep(50); *pTCntxt->tLock= 1;
	PDDBase *pHDD;
	char N256[1256];
	strcpy(N256, pTCntxt->pDlg->pHDD->keyFile->FileName);
	*strrchr(N256, '.')= 0;
	if((pHDD= new PDDBase( N256, O_RDONLY, 1000, 1000, 1000, (FILE *)pTCntxt->pDlg->pGSScreen)) != NULL && pHDD->IsOk() ){
		pTCntxt->pDlg->m_AnswerCount++;
		pTCntxt->tstPass= 
	#ifndef RD_AS_ETALON
		*(pTCntxt->pDlg->aCodeNew+pTCntxt->pDlg->aCode-1) != Answertoi( (char*)(LPCTSTR)pTCntxt->pDlg->m_AnswerStr );
	#endif
		delete pHDD;
	#if defined (_DEBUG)
		pTCntxt->tstPass = 0; // Ответ всегда Валиден в Release
	#endif
		if(!pTCntxt->tstPass){
			lseek( pTCntxt->fLocked, 0L, SEEK_SET );
			locking( pTCntxt->fLocked, LK_UNLCK, 30L );
			close( pTCntxt->fLocked );
		}
	}
	*pTCntxt->tLock= 0;
}

static int allTimeMs= 0;

void tickProc100(CTestBreeder32Dlg *pDlg)
{
	pDlg->pGSScreen->OtherShowMessage(Msg_81);
	pDlg->m_Progress.ShowWindow(SW_SHOWNORMAL);
	pDlg->m_Progress.SetRange32( 0, MAX_TIM_IN_MS - CHECK_PERIOD_IN_MS  );
	do{
		if(allTimeMs > MAX_TIM_IN_MS){
			CString titl;
			titl.LoadString(IDS_QTITLE);
			if(pDlg->MessageBox(Msg_82, titl, MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2 ) != IDYES){
				pDlg->EndDialog(-1);
				return;
			}
			allTimeMs= 0;
			pDlg->m_Progress.SetRange32( 0, MAX_TIM_IN_MS - CHECK_PERIOD_IN_MS  );
		}
		allTimeMs += CHECK_PERIOD_IN_MS;
		pDlg->m_Progress.SetPos(allTimeMs);
		Sleep(CHECK_PERIOD_IN_MS);
	}while(!IsFileOk(&pDlg->testFile));
	pDlg->m_Progress.SetRange( 0, 100 );
	pDlg->m_BttnNext.EnableWindow();
	pDlg->PrevDlgCtrl();
	pDlg->m_Progress.ShowWindow(SW_HIDE);
	pDlg->PostMessage(WM_ON_INSTALL);
}

#define NOT_LOGIN 11111

void deleteOpenedBase(Base *p_Base)
{
	delete p_Base;
}

static char	g4xPathORG[]= "..\\bases.org";
static char	g4xPathINI[]= "..\\garant.ini";

#define BLNGS_BUFF_SIZE 10000
static char sel_tmp_Belngs[BLNGS_BUFF_SIZE];

//#ifdef RD_AS_ETALON
extern "C" {
	char *sel_Belngs= sel_tmp_Belngs;
}
//#endif

int pl_MakeCIBFromInstalledInPharmDisk(
	GWinScreen* pContext
	, CString* pInputedBaseFileName
	, char* OutputedBasePath
	, CStringArray* pFiles
) {
	CString msg;
	msg.LoadString (IDS_COPYING_FILE);
				;
	CString inPath((LPCTSTR)*pInputedBaseFileName), outPath(OutputedBasePath),
			msgFile;
	inPath= inPath.Left(inPath.ReverseFind('\\')+1);
	outPath= outPath.Left(outPath.ReverseFind('\\')+1);
	char bff[0x10000];
	long sz, count, percnt, delta, tmp;
	for(int ii= 0, fh, fi; ii < pFiles->GetSize(); ii++){
		msgFile.Format (msg.GetBuffer (), (LPCTSTR)pFiles->GetAt(ii));
		pContext->OtherShowMessage((LPCTSTR)msgFile);
		pContext->SetProgress(0);
		fi= open((LPCTSTR)(inPath+pFiles->GetAt(ii)), O_BINARY|O_RDONLY, 0664);
		if(fi != -1){
			if((fh= open((LPCTSTR)( outPath+pFiles->GetAt(ii)),
									O_BINARY|O_CREAT|O_TRUNC|O_WRONLY,
									0664)) != -1){
	////////////
	if(fh != -1 && fi != -1){
		bff[0x10000];
		sz= lseek(fi, 0, SEEK_END); count= sz/0x10000;
		percnt= delta= 0;
		lseek(fi, 0, SEEK_SET);
		percnt= 0;
		while(count--){
			pContext->rdStats= 0;
			if(read(fi, bff, 0x10000) != 0x10000){
				pContext->rdStats= 1;
				pContext->pFileNameError= strdup((LPCTSTR)pFiles->GetAt(ii));
				close(fh);
				close(fi);
				return -65;
			}
			pContext->wrStats= 0;
			if(write(fh, bff, 0x10000) != 0x10000){
				pContext->wrStats= 1;
				pContext->pFileNameError= strdup((LPCTSTR)pFiles->GetAt(ii));
				close(fh);
				close(fi);
				return -65;
			}
			pContext->AllCpd += 0x10000/1024;
			delta += 0x10000;
			if((tmp= (long)(((__int64)delta*100)/sz)) > percnt){
				percnt= tmp;
				pContext->SetProgress(percnt);
			}
		}
		count= sz%0x10000;
		pContext->rdStats= 0;
		if(read(fi, bff, count) != count){
			pContext->rdStats= 1;
			pContext->pFileNameError= strdup((LPCTSTR)pFiles->GetAt(ii));
			close(fh);
			close(fi);
			return -65;
		}
		pContext->wrStats= 0;
		if(write(fh, bff, count) != count){
			pContext->wrStats= 1;
			pContext->pFileNameError= strdup((LPCTSTR)pFiles->GetAt(ii));
			close(fh);
			close(fi);
			return -65;
		}
		pContext->AllCpd += count/1024;
	}
	////////////
				close(fh);
			}else{
				close(fi);
				pContext->wrStats= 1;
				pContext->pFileNameError= strdup((LPCTSTR)pFiles->GetAt(ii));
				return -65;
			}
			close(fi);
		}else{
			pContext->wrStats= 1;
			pContext->pFileNameError= strdup((LPCTSTR)pFiles->GetAt(ii));
			return -65;
		}
		pContext->SetProgress(100);
	}
	return 0;
}

#if !defined(NOT_RD) && !defined(RD_AS_ETALON)
	extern "C" PDWORD pextCrptKy;
#endif

LPPL_IMPORT_CIB_DATA *ppCurrCIBs= 0;
const char regInstallAsPacked [17] = "-InstallAsPacked";
const char regInstallWithDisconnect [23] = "-InstallWithDisconneсt";
const char regInstallLastCacheName [22] = "-InstallLastCacheName";
const char regInstallSize [13] = "-InstallSize";

int stored_regInstallAsPacked;
int stored_regInstallWithDisconnect;
char stored_regInstallLastCacheName[256];
int stored_regInstallSize;

bool gb_delAllBkp_In_TerminateBreederThread= true;

void delAllBkp (bool silent_mode = true, CWnd *pParent= 0)
{
	CFileFind finder;
	int lmask= strlen(bkpMask)+1;
	char *fndT= strrchr(real_base_name,'\\'), *delFiles= (char*)alloca(fndT-real_base_name+1+lmask);
	memcpy(delFiles,real_base_name,fndT-real_base_name+1);
	memcpy(delFiles+(fndT-real_base_name)+1,bkpMask,lmask);
	CString titl; titl.LoadString (IDS_QTITLE);
	if(finder.FindFile(delFiles)){
		if (!silent_mode)
			((CTestBreeder32App*)AfxGetApp())->TimeLog ("Задан вопрос: Установка прервана. Удалить данные для ее возобновления?\n");

		if (silent_mode || MessageBox( pParent ? pParent->GetSafeHwnd() : 0, get_app ()->get_rc_lang () == rl_Eng ? "Installation aborted. Remove data to restore it?" : "Установка прервана. Удалить данные для ее возобновления?", titl, MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2 ) == IDYES){
			if (!silent_mode) {
				((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Да\n");
				Core::ParamManagerFactory::get ().set_long (regInstallAsPacked, -1);
				Core::ParamManagerFactory::get ().set_long (regInstallWithDisconnect, -1);
			}
			do{
				lmask= finder.FindNextFile();
				unlink(finder.GetFilePath());
			}while(lmask);
		} else {
			if (!silent_mode)
				((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Нет\n");
		}
	} else {
		Core::ParamManagerFactory::get ().set_long (regInstallAsPacked, -1);
		Core::ParamManagerFactory::get ().set_long (regInstallWithDisconnect, -1);
	}
}

char *curr_msgBrs, exprt_msgBrs[1024];
int gProcMssg= 0, waitBrowse= 1;

void AfterWriteHandlesClosed()
{
	G_Point ij= allFHndls.first();
	while(ij){
		c_io_close(allFHndls.key(ij));
		allFHndls.next(ij);
	}
}

void waitAfterWriteHandlesClosed()
{
	AfterWriteHandlesClosed();
	waitCopy= 0;
	while(1) Sleep(1000);
}

int OnInstall(CTestBreeder32Dlg *pDlg)
{
#if !defined(NOT_RD) && !defined(RD_AS_ETALON)
	ppCurrCIBs= &(pDlg->pCurrCIBs);
	pextCrptKy[0]= *returnID_User_CIB(pDlg->pCurrCIBs->Alias);
	pextCrptKy[1]= *returnID_Service(pDlg->pCurrCIBs->Alias);
	HashDWORD(pextCrptKy+1);
	pCrptInfo= pl_getPassword(	*returnID_Service(pDlg->pCurrCIBs->Alias),
								384, *returnID_CIB(pDlg->pCurrCIBs->Alias),
								(long*)pDlg->pHDD->textFile->m_pCryptoTag);
  //#ifdef	_GCD_CLIENT
	if(!pDlg->realACode){
		strcpy(realPass, pCrptInfo);
#ifdef VERSION63
		Export_ID_CIB= pDlg->m_DefaultRD_Hash - PL_Process_step;
#endif
		pDlg->realACode= 1;
	}
  //#endif
#endif

	ACE_UINT32 CRC;
	memcpy (&CRC, "GSF1", sizeof (CRC));

	char aLogString [128];
	sprintf (aLogString, "%s\n", pDlg->str_password.c_str ());
	((CTestBreeder32App*)AfxGetApp())->Log(aLogString,true);

	//CRC := 0x('GSF1'); // SEED для CRC
	//CRC := CRC32(CRC, <строчка 1>) XOR NOT (1);
	//CRC := CRC32(CRC, <строчка 2>) XOR NOT (2);

	//CRC {
	//[YYYY-MM-DD HH:mm:SS.msec/<GetTickCount>] On update: <последовательность символов пароля>
	//[YYYY-MM-DD HH:mm:SS.msec/<GetTickCount>] On update filename: <имя .CRY-файла>
	//} CRC <контрольная сумма>

	CTime theTime = CTime::GetCurrentTime();
	char str1 [128];
	sprintf (str1, "[%04d-%02d-%02d %02d:%02d:%02d.00/%u] On update:%s", theTime.GetYear(), theTime.GetMonth(), theTime.GetDay(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond(), GetTickCount (), strrchr (pDlg->str_password.c_str (), ' '));
	CRC = ACE::crc32 (str1, strlen (str1), CRC) ^ (~1);
	char str2 [128];
	theTime = CTime::GetCurrentTime();
	sprintf (str2, "[%04d-%02d-%02d %02d:%02d:%02d.00/%u] On update filename: %s", theTime.GetYear(), theTime.GetMonth(), theTime.GetDay(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond(), GetTickCount (), ((CTestBreeder32App*)AfxGetApp())->log_file_prefix.GetBuffer (0));
	CRC = ACE::crc32 (str2, strlen (str2), CRC) ^ (~2);
	char str3 [64];
	sprintf (str3, "} CRC %u\n", CRC);

	char aCurDir [MAX_PATH], aLogFileName [MAX_PATH];
	strcpy (aCurDir, ((CTestBreeder32App*)AfxGetApp())->module_file_name);
	*strrchr (aCurDir, '\\') = '\0';
	strcpy (aLogFileName, aCurDir);
	if (strrchr (aLogFileName, '\\')) *strrchr (aLogFileName, '\\') = '\0';
	if (strrchr (aLogFileName, '\\')) *strrchr (aLogFileName, '\\') = '\0';
	strcat (aLogFileName, "\\Logs\\install.log");
	FILE *aLogFile = ACE_OS::fopen (aLogFileName, "a");
	if (aLogFile)	{
		ACE_OS::fputs ("CRC {\n", aLogFile);
		ACE_OS::fputs (str1, aLogFile);
		ACE_OS::fputs ("\n", aLogFile);
		ACE_OS::fputs (str2, aLogFile);
		ACE_OS::fputs ("\n", aLogFile);
		ACE_OS::fputs (str3, aLogFile);
		ACE_OS::fclose (aLogFile);
	}

	*(long*)(pDlg->pHDD->textFile->m_pCryptoTag)= 0;

	if(pDlg->pGSScreen->pUpdatedBase != NULL){
		if(pDlg->pGSScreen->notSplit){
		((PDDBase*)pDlg->pGSScreen->pUpdatedBase)->keyFile->SetFileHandle(
			::open(((PDDBase*)pDlg->pGSScreen->pUpdatedBase)->keyFile->FileName, O_RDONLY | O_BINARY, 0664));
		((PDDBase*)pDlg->pGSScreen->pUpdatedBase)->strFile->SetFileHandle(
			::open(((PDDBase*)pDlg->pGSScreen->pUpdatedBase)->strFile->FileName, O_RDONLY | O_BINARY, 0664));
		((PDDBase*)pDlg->pGSScreen->pUpdatedBase)->textFile->SetFileHandle(
			::open(((PDDBase*)pDlg->pGSScreen->pUpdatedBase)->textFile->FileName, O_RDONLY | O_BINARY, 0664));
	if(((PDDBase*)pDlg->pGSScreen->pUpdatedBase)->pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp=
			((PDDBase*)pDlg->pGSScreen->pUpdatedBase)->pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pStreamFile){
				pOtherNextIndexTmp->pStreamFile->file->SetFileHandle(
					::open(pOtherNextIndexTmp->pStreamFile->file->FileName, O_RDONLY | O_BINARY, 0664));
			}
			pOtherNextIndexTmp->pKey->SetFileHandle(
				::open(pOtherNextIndexTmp->pKey->FileName, O_RDONLY | O_BINARY, 0664));
			pOtherNextIndexTmp++;
		}
	}
		}else{
			delete pDlg->pGSScreen->pUpdatedBase;
			pDlg->pGSScreen->pUpdatedBase = NULL;
		}
	}
	if(pDlg->pGSScreen->notSplit){
		if(pDlg->InPharmFiles.GetSize()){
			CString paths= pDlg->SelectedPath;
			paths= paths.Left(paths.ReverseFind('\\'));
			::CreateDirectory(paths, NULL);
			paths += "\\PICTURES";
			::CreateDirectory(paths, NULL);
		}
		pDlg->pGSScreen->notSplit= pDlg->m_currBaseSz;
	}else if(!pDlg->pHDD->streamFile->Fat)
		pDlg->pHDD->streamFile->LoadFat();

	pDlg->m_CurrHlpTopicID= 100;
	pDlg->m_Progress.ShowWindow(SW_SHOWNORMAL);
#if defined (_GCD_CLIENT) || defined (PILOT)
	strcpy(pDlg->SelectedPath,(LPCTSTR)*pDlg->pPilotBaseName);
#endif

#if !defined (_GCD_CLIENT) && !defined (PILOT)
	if ( ((CTestBreeder32App*)AfxGetApp())->AskFileName && pDlg->pGSScreen->notSplit ) {
		CNewName newName;
		newName.m_pName = strrchr( pDlg->SelectedPath, '\\' ) + 1;
		if ( newName.DoModal() == IDOK )
			StrUpr( strcat( strcpy( strrchr( pDlg->SelectedPath, '\\'), "\\" ), newName.m_pName ));
	}
#endif
	if(	(!pDlg->InPharmFiles.GetSize() && (!pDlg->pGSScreen->notSplit && !pDlg->pHDD->streamFile->Fat && (pDlg->retVal= -1))
			|| ((pDlg->retVal= pl_MakeCIBFromInstalledDisk(	pDlg->pGSScreen
															,(char*)(LPCTSTR)pDlg->FileName
															,pDlg->SelectedPath
															,(char*)(LPCTSTR)pDlg->m_pLoginDlg->m_Login
															,(char*)(LPCTSTR)pDlg->m_pLoginDlg->m_Password
															,pDlg->pLogin))
					&& pDlg->retVal != 55 && pDlg->retVal != 555))
		|| (pDlg->retVal= pl_MakeCIBFromInstalledInPharmDisk(	pDlg->pGSScreen
																,&pDlg->FileName, pDlg->SelectedPath
																,&pDlg->InPharmFiles)))
	{
		pDlg->m_Progress.ShowWindow(SW_HIDE);
		pDlg->m_BttnNext.EnableWindow(FALSE);
		pDlg->restoreBase();
		if((pDlg->retVal == -65 && pDlg->pGSScreen->rdStats == 0 && pDlg->pGSScreen->lastReaded->iPost == 0)||/*
			pDlg->retVal= -75; // не стали исправлять возникшею ошибку чтения, а просто прервали работу //
		else if(*/pDlg->pGSScreen->rdStats){
			pDlg->BeepWarning();
			pDlg->setInstallThread(0);
			char *fndt37= strchr((char*)pDlg->pGSScreen->pReadErrorMsg, '.');
			if(fndt37){
				char tmpend= fndt37[1];
				fndt37[1]= 0;
				sprintf(exprt_msgBrs, pDlg->pGSScreen->pReadErrorMsg, pDlg->pGSScreen->pFileNameError);
				fndt37[1]= fndt37[1];
			}else
			sprintf(exprt_msgBrs, pDlg->pGSScreen->pReadErrorMsg, pDlg->pGSScreen->pFileNameError); curr_msgBrs= exprt_msgBrs;
			gProcMssg= 1;
			pDlg->PostMessage(WM_ON_INSTALL);
			while(waitBrowse) Sleep(200); waitBrowse= 1;
			waitAfterWriteHandlesClosed();
			//pDlg->MessageBox(pDlg->qqq, Msg_76, MB_OK|MB_ICONERROR);
		}else if(pDlg->retVal == -65 || pDlg->pGSScreen->wrStats ){
			pDlg->BeepWarning();
			pDlg->qqq.Format(pDlg->pGSScreen->pWriteErrorMsg, pDlg->pGSScreen->pFileNameError);
			pDlg->MessageBox(pDlg->qqq, Msg_76, MB_OK|MB_ICONERROR);
			((CTestBreeder32App*)AfxGetApp())->Log (pDlg->qqq.GetBuffer (0));
			((CTestBreeder32App*)AfxGetApp())->Log ("\n");
			if(!(gb_delAllBkp_In_TerminateBreederThread= false)) delAllBkp (false, pDlg->pGSScreen->m_pParent);
		}else if(pDlg->retVal == -75){
			;
		}else{
			pDlg->BeepWarning();
			pDlg->MessageBox(Msg_62, Msg_76, MB_OK|MB_ICONERROR);
			((CTestBreeder32App*)AfxGetApp())->Log (Msg_62.GetBuffer (0));
			((CTestBreeder32App*)AfxGetApp())->Log ("\n");

			pDlg->install_status = 2;
			pDlg->send_internet_result ();
		}
		if(pDlg->pGSScreen->pFileNameError != NULL){
			free(pDlg->pGSScreen->pFileNameError);
			pDlg->pGSScreen->pFileNameError= NULL;
		}
		pDlg->EndDialog(-1);
		return -1;
	}else{
		if(curTitle != ""){
			pDlg->SetWindowText(curTitle);
			pDlg->pGSScreen->notSplit= 0;
		}
		pDlg->m_CurrHlpTopicID= 110;
		pDlg->m_Progress.ShowWindow(SW_HIDE);
		if(pDlg->retVal == 555){
			memcpy(strrchr(pDlg->SelectedPath, '*')+1, "!???", 5);
			CFileFind finder;
			if(finder.FindFile(pDlg->SelectedPath)){
				BOOL bFindNext;
				do{
					bFindNext = finder.FindNextFile();
					unlink(finder.GetFilePath());
				}while(bFindNext);
				finder.Close();
			}
			pDlg->retVal=0;
		}else{
			pDlg->retVal=0;
		}
		if(	(pDlg->installed= TRUE) && !pDlg->aCode && ((pDlg->m_hasp_ret && !pDlg->IsKeyFlpp((pDlg->m_keyDiskProcess= 2)) && !pDlg->IsKeyFlpp(pDlg->m_keyDiskProcess)))){
			pDlg->BeepWarning();
			if(!pDlg->m_iColor){
				pDlg->OnPasswordForm();
				return -1;
			}
			pDlg->qqq.Format(Frmt21, Msg_64);
			pDlg->m_Msg1.SetWindowText(pDlg->qqq);
			pDlg->ShowControl(&pDlg->m_Radio4);
			pDlg->ShowControl(&pDlg->m_Radio3);
			pDlg->ProcessFlppError(pDlg->NameCIB);
			return -1;
		}else{
			int ll, retR= 0;
			char trgName[4096],trgTmpName[4096], trgErrName[4096], *fndT= strrchr(real_base_name,'\\'), firstCh= fndT[1];
			while(pcPreInst2Gfiles-- > 0){
				ll= strlen(ppPreInst2Gfiles[pcPreInst2Gfiles]);
				fndT[1]= 0;
				sprintf(trgTmpName,"%s~%s",real_base_name,ppPreInst2Gfiles[pcPreInst2Gfiles]+1);
				fndT[1]= firstCh;
				sprintf(trgName,"%s.%s",real_base_name,ppPreInst2Gfiles[pcPreInst2Gfiles]+ll-3);
				if(!retR){
					if((retR= rename(trgTmpName,trgName))){
						strcpy(trgErrName,trgName);
					}
				}
				free(ppPreInst2Gfiles[pcPreInst2Gfiles]);
			}
			if(retR){
				pDlg->BeepWarning();
				pDlg->qqq.Format(pDlg->pGSScreen->pWriteErrorMsg, trgErrName);
				pDlg->MessageBox(pDlg->qqq, Msg_76, MB_OK|MB_ICONERROR);
				((CTestBreeder32App*)AfxGetApp())->Log (pDlg->qqq.GetBuffer (0));
				((CTestBreeder32App*)AfxGetApp())->Log ("\n");
				pDlg->EndDialog(-1);
				return -1;
			}
			pDlg->Bind(&pDlg->txt);
			delAllBkp (true);
			return -1;
		}
	}
	return 0;
}
/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	public:
	virtual BOOL DestroyWindow();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTestBreeder32Dlg dialog

GWinScreen::GWinScreen(CWnd* pParent /*=NULL*/) : GSScreen(cd_koi, cd_win)
{
	percents = 0;
	value = 0;
	start_time = 0;

	m_pParent= pParent;
	pBase= pUpdatedBase= NULL;

	rdStats= wrStats= AllCpd= 0;

	pFileNameError= NULL;
}

static int rpRd= 0;

DWORD makeMsgNxtFile(const char *pText, CString *fileMsg, CString *findCheck, bool &next_disk, int asOld= 1)
{
	next_disk = false;
	CString frmt= asOld ? (pText+1) : pText, section= frmt.Left(frmt.GetLength()- (asOld ? 1 : 0));
	char diskN[32];
	if(asOld) (*findCheck)= section;
	section = section.Right(section.GetLength() - section.ReverseFind('\\')-1);
	section.MakeUpper();

	CString filename = frmt.Left (frmt.ReverseFind ('.')) + ".lst";
	DWORD success = 0;
	FILE *inifile = fopen (filename, "rt");
	if (inifile) {
		while (!feof (inifile )) {
			char str [256];

			if (!fgets (str, sizeof (str), inifile))
				continue;

			int length = strlen (str);
			while (length && str [length-1] == 10)
				str [--length] = 0;

			if (strstr (str, section.GetBuffer (0)) && fgets (str, sizeof (str), inifile)) {
				length = strlen (str);
				while (length && str [length-1] == 10)
					str [--length] = 0;
				if (strrchr (str, '=')) {
					strcpy (diskN, strrchr (str, '=') + 1);
					success = strlen (diskN);
					if (success) {
						char disk_n [MAX_PATH];
						strcpy (disk_n, filename.GetBuffer (0));
						*strrchr (disk_n, '\\') = 0;
						*strrchr (disk_n, '\\') = 0;
						strcat (disk_n, "\\disk.");
						strcat (disk_n, diskN);
						if (FileExist (disk_n))
							success = false;
					}

					break;
				}
			}
		}
		fclose (inifile );
	}
	if (success) {
		frmt.LoadString (IDS_NEXT_DISK);
		fileMsg->Format ((LPCTSTR)frmt, diskN);
		next_disk = true;
	} else {
		frmt.LoadString (IDS_NEXT_SPF);
		fileMsg->Format ((LPCTSTR)frmt, strrchr (pText, '\\') ? strrchr (pText, '\\') + 1 : pText);
	}
	return success;
}

static int szsrcRead, g_iCloseType= 0;
char srcRead[MAX_PATH+MAX_PATH], *psrcRead= 0;

int GWinScreen::ShowQuestionYesOrNo(const char *pText, int RetryAbort)
{
	int defMsk= MB_ICONQUESTION | MB_YESNO, retMsg= IDYES;
	bool next_disk = false;
	CString fileMsg, titl, findCheck(""), emsg;
	((CTestBreeder32Dlg*)m_pParent)->BeepWarning();
	if(RetryAbort){
		defMsk= MB_ICONERROR | MB_RETRYCANCEL;
		retMsg= IDRETRY;
	}
	if(IS_BRDR_EXIT_MSG){
		CString titlExit, emsgExit, logtxt, logtxtfrmt("Пользователь ответил: %s\n"), retLog0, retLog1;
		int param4, retParam4;
		if(g_iCloseType == 1){
			char tmpFrmt[1000];
			strcpy(tmpFrmt,(LPCTSTR)Msg_78);
			char *pfndBigB= strchr(tmpFrmt,	'В'// первая буква из русского 'Возможно'
																						);
			if(pfndBigB){
				pfndBigB[-1]= 0;
				while(pfndBigB[0] != ' ') pfndBigB++;
				pfndBigB[1]= 'Н';
				char *pfndEngt= strchr(pfndBigB,	't'// предпоследняя буква из английского 'data'
																								);
				if(pfndEngt)
					pfndEngt[2]= 0;
				sprintf(tmpFrmt, "%s%s", tmpFrmt, pfndBigB);
			}
			emsgExit.Format(tmpFrmt,pFileNameError);
			param4= MB_ICONERROR | MB_RETRYCANCEL;
			retParam4= IDCANCEL;
			retLog0.Format(logtxtfrmt,"Далее");
			retLog1.Format(logtxtfrmt,"Отмена");
		}else{
			titlExit.LoadString(IDS_EXIT_TITLE);
			emsgExit.LoadString(IDS_EXIT_MSG);
			param4= MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2;
			retParam4= IDYES;
			retLog0.Format(logtxtfrmt,"Нет");
			retLog1.Format(logtxtfrmt,"Да");
		}
		((CTestBreeder32App*)AfxGetApp())->TimeLog ("Задан вопрос: ");
		((CTestBreeder32App*)AfxGetApp())->Log (emsgExit.GetBuffer (0));
		((CTestBreeder32App*)AfxGetApp())->Log ("\n");

		do{
			if (::AfxCtxMessageBox(this->m_pParent->GetSafeHwnd(), emsgExit, titlExit, param4) != retParam4) {
				((CTestBreeder32App*)AfxGetApp())->TimeLog ((char*)(LPCTSTR)retLog0);
				if(g_iCloseType == 1){
					LONGLONG llFreeSpaceKB;
					if(!IsNotFreeSpace(&llFreeSpaceKB)){
						g_iCloseType= 0;
					}
				}else
					g_iCloseType= 0;
			} else {
				((CTestBreeder32App*)AfxGetApp())->TimeLog ((char*)(LPCTSTR)retLog1);
				g_iCloseType= 0;
				return 1;
			}
		}while(g_iCloseType);
		return 0;
	}
	titl.LoadString(IDS_QTITLE);

	int localRet;
	if(RetryAbort){
		CBRCDialog CBRCDlg(m_pParent);
		if(!waitKill){
			makeMsgNxtFile (pText, &fileMsg, &findCheck, next_disk, 0);
			CString tttRm = "\n";
			tttRm += fileMsg;
			tttRm += "\n\n";
			if (next_disk) {
				if (get_app ()->get_rc_lang () == rl_Eng) {
					tttRm += "«Browse» - selecting a different directory with the source distribution for installation.";
				} else {
					tttRm += "«Обзор» - выбор другого каталога с исходным дистрибутивом для продолжения установки.";
				}
			} else {
				if (get_app ()->get_rc_lang () == rl_Eng) {
					tttRm += "Retry the operation or specify another directory with the source distribution to continue installation.";
				} else {
					tttRm += "Попробуйте повторить операцию или укажите другой каталог с дистрибутивом для продолжения установки.";
				}
			}

			CBRCDlg.m_importText = tttRm;

			do{
				((CTestBreeder32App*)AfxGetApp())->TimeLog ("Задан вопрос: ");
				((CTestBreeder32App*)AfxGetApp())->Log (strchr (tttRm.GetBuffer (0), '\n') + 1);
				((CTestBreeder32App*)AfxGetApp())->Log ("\n");
				localRet= CBRCDlg.DoModal();
				{
					if(localRet == IDCANCEL)
						((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Отмена/Cancel\n");
					else if(localRet == IDYES) {
						char log_str [1024];
						sprintf (log_str, "Пользователь ответил: Обзор и выбрал каталог %s\n", srcRead);
						((CTestBreeder32App*)AfxGetApp())->TimeLog (log_str);
						localRet = IDRETRY;
					} else
						((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Повтор\n");
				}
			}while(localRet == IDCANCEL && !ShowQuestionYesOrNo(BRDR_EXIT));
		}else if(waitKillAsBrowse){
			if(!(((CTestBreeder32Dlg*)m_pParent)->ShowQuestionBrowse())){
				do{
					LPITEMIDLIST	aBrowse= PidlBrowse( m_pParent->GetSafeHwnd(), CSIDL_DRIVES, (char*)pText, IDS_SELECT_FOLDER );
					if(!aBrowse){
						;
					}else if ( aBrowse && SHGetPathFromIDList( aBrowse, (char*)pText )){
						szsrcRead= strlen((char*)pText);memcpy(srcRead,(char*)pText,szsrcRead);srcRead[szsrcRead]= 0;
						break;
					}else{
						break;
					}
				}while(1);
			}
			localRet= IDRETRY;
		}else{
			if(ShowQuestionYesOrNo(BRDR_EXIT)){
				localRet= IDCANCEL;
			}else{
				localRet= IDRETRY;
			}
		}
		if(localRet == IDCANCEL && !(gb_delAllBkp_In_TerminateBreederThread= false)) {
			((CTestBreeder32Dlg*)m_pParent)->install_status = 2;
			((CTestBreeder32Dlg*)m_pParent)->send_internet_result ();
			delAllBkp(false, this->m_pParent);
		}
	}else{
		((CTestBreeder32App*)AfxGetApp())->TimeLog ("Задан вопрос: ");
		((CTestBreeder32App*)AfxGetApp())->Log ((char*) pText);
		((CTestBreeder32App*)AfxGetApp())->Log ("\n");
		localRet= ((CTestBreeder32Dlg*)m_pParent)->MessageBox(pText, titl, defMsk);
		if (localRet == IDNO)
			((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Нет\n");
		else if (localRet == IDYES)
			((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Да\n");
	}

	if(localRet == retMsg){
		//((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Да/Повторить/Ok\n"); выше уже говорится
		if(findCheck != ""){
			CFileFind tmpFnd;
			BOOL ret;
			while(!(ret= tmpFnd.FindFile(findCheck))){
				((CTestBreeder32Dlg*)m_pParent)->BeepWarning();
				if(((CTestBreeder32Dlg*)m_pParent)->MessageBox(pText, titl, defMsk) != retMsg)
					break;
			}
			tmpFnd.Close();
			if(ret)
				return 0;
		}else
			return 0;
	} else {
		gBrwsAfterReadError= 1;
		gBrwsAfterReadErrorNot= 0;
		if(RetryAbort && localRet != IDCANCEL){
			; //((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Обзор\n"); выже уже говорится?
		} else {
			/*
			if (localRet == IDNO)
				((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Нет\n");
			else if (localRet == IDYES)
				((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Да\n");
			*/

			if(RetryAbort){
				gBrwsAfterReadErrorNot= 1;
			} else{
				gBrwsAfterReadError= 0;
			}
		}
	}
	return 1;
}

void GWinScreen::ShowMessage(const char *pText, int sub)
{
	if(waitKill || gCopyKill)
		;
	else{
		//if(isNT) Sleep(2);
	#ifndef	_DEBUG
		((CTestBreeder32Dlg*)m_pParent)->UpdateData();
	#endif
		((CTestBreeder32Dlg*)m_pParent)->m_ProcessMsg.SetWindowText(pText);

		if (strlen( pText)) {
			((CTestBreeder32App*)AfxGetApp())->TimeLog ("Показано сообщение: ");
			((CTestBreeder32App*)AfxGetApp())->Log ((char*)pText);
			((CTestBreeder32App*)AfxGetApp())->Log ("\n");
		}
	}
}

bool GWinScreen::IsNotFreeSpace( LONGLONG *p_llRetSize)
{
	*p_llRetSize= remoteInstall ? (MyGetDiskFreeSpace( remotePath ) / 1024) : (CorrectMyGetDiskFreeSpace("\\") / 1024);
	if(*p_llRetSize <=	100*1024	// меньше 100\-а мегов
									//((CTestBreeder32Dlg*)m_pParent)->m_currBaseSz/100		// меньше одного % копируемого объёма
																																	){
		return true;
	}
	return false;
}

int GWinScreen::SetProgress(int avalue)
{
	if(waitKill || gCopyKill || g_iCloseType == 1)
		;
	else{
		if (start_time == 0)
			start_time = time (0);

		if (value != avalue) {
			value = avalue;
			if(isNT) Sleep(2);
			((CTestBreeder32Dlg*)m_pParent)->m_Progress.SetPos( value );
			LONGLONG llFreeSpaceKB;
			if(IsNotFreeSpace(&llFreeSpaceKB)){
				g_iCloseType= 1;
				m_pParent->PostMessage(WM_CLOSE);
				return 1;
			}
			((CTestBreeder32Dlg*)m_pParent)->qqq.Format(Frmt2, llFreeSpaceKB/1024);
			((CTestBreeder32Dlg*)m_pParent)->m_Msg2.SetWindowText(((CTestBreeder32Dlg*)m_pParent)->qqq);

			if(notSplit){
				int new_percents = (int)(((__int64)AllCpd * (__int64)100)/(__int64)notSplit);
				if (percents != new_percents) {
					percents = new_percents;

					CString new_title;
					if(curTitle == "") m_pParent->GetWindowText(curTitle);
					if (percents > 5) {
						int time_passed = (int)((time (0) - start_time) & 0xffffffff);
						if (0 == time_passed) time_passed = 1;
						int wait_sec = (notSplit - AllCpd) / (AllCpd / time_passed);
						if (wait_sec > 100) {
							if (get_app ()->get_rc_lang () == rl_Eng)
								new_title.Format("%s (%d%%, installation may take %ld min)", curTitle, percents, (wait_sec / 60) + 1);
							else
								new_title.Format("%s (%d%%, установка займет %ld мин)", curTitle, percents, (wait_sec / 60) + 1);
						} else {
							if (get_app ()->get_rc_lang () == rl_Eng)
								new_title.Format("%s (%d%%, installation may take %ld sec)", curTitle, percents, wait_sec);
							else
								new_title.Format("%s (%d%%, установка займет %ld сек)", curTitle, percents, wait_sec);
						}
					} else {
						new_title.Format("%s (%d%%)", curTitle, percents);
					}
					m_pParent->SetWindowText (new_title);
				}
			}
		}
	}
	return 1;
}

#ifndef AS_HDD_ROOT
	static int iTreeRegen= 0, iID_LstUser, iID_User;
	static CString currClientName, currCIBName;
	static char *pLastCIB_Name;
	static TV_INSERTSTRUCT TreeCtrlItemAdded;
	static HTREEITEM m_hFirstInsertCurr= 0;
	static BOOL First= TRUE;
#endif

static bool bLoadMsgs= true;

unsigned long install_time = 0;
bool b_result_send = false;

CTestBreeder32Dlg::CTestBreeder32Dlg(CWnd* pParent /*=NULL*/)
	: CDialog(CTestBreeder32Dlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CTestBreeder32Dlg)
	m_iColor= 1;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32

	if (install_time == 0)
		install_time = time (0);
	install_status = 0;

	internet_answer = false;
	internet_was_checked = false;

	pInstalledNet= 0;
	TypeProtect= 0;
	iTreeRegen= 0;
	m_hFirstInsertCurr= 0;
	First= TRUE;
	allTimeMs= 0;

	m_select= 0;
	if(bLoadMsgs){bLoadMsgs=false;
		Frmt0.LoadString(IDS_FRMT0);
		Frmt01.LoadString(IDS_FRMT01);
		Frmt1.LoadString(IDS_FRMT1);
		Frmt1a.LoadString(IDS_FRMT1A);
		Frmt2.LoadString(IDS_FRMT2);
		Frmt3.LoadString(IDS_FRMT3);
		Frmt20.LoadString(IDS_FRMT20);
		Frmt21.LoadString(IDS_FRMT21);
		Frmt30.LoadString(IDS_FRMT30);
		Frmt31.LoadString(IDS_FRMT31);
		Frmt31a.LoadString(IDS_FRMT31A);
		Frmt41.LoadString(IDS_FRMT41);
		Frmt50.LoadString(IDS_FRMT50);
		Frmt51.LoadString(IDS_FRMT51);
		Frmt52.LoadString(IDS_FRMT52);

		Msg_0.LoadString(IDS_MSG_0);
		Msg_1.LoadString(IDS_MSG_1);
		Msg_2.LoadString(IDS_MSG_2);
		Msg_3.LoadString(IDS_MSG_3);
		Msg_20.LoadString(IDS_MSG_20);
		Msg_21.LoadString(IDS_MSG_21);
		Msg_50.LoadString(IDS_MSG_50);
		Msg_51.LoadString(IDS_MSG_51);
		Msg_60a.LoadString(IDS_MSG_60A);
		Msg_60.LoadString(IDS_MSG_60);
		Msg_61.LoadString(IDS_MSG_61);
		Msg_62.LoadString(IDS_MSG_62);
		Msg_63.LoadString(IDS_MSG_63);
		Msg_64.LoadString(IDS_MSG_64);
		Msg_65.LoadString(IDS_MSG_65);
		Msg_66.LoadString(IDS_MSG_66);
		Msg_67.LoadString(IDS_MSG_67);
		Msg_68.LoadString(IDS_MSG_68);
		Msg_69.LoadString(IDS_MSG_69);
		Msg_70.LoadString(IDS_MSG_70);
		Msg_71.LoadString(IDS_MSG_71);
		Msg_72.LoadString(IDS_MSG_72);
		Msg_73.LoadString(IDS_MSG_73);
		Msg_74.LoadString(IDS_MSG_74);
		Msg_75.LoadString(IDS_MSG_75);
		Msg_76.LoadString(IDS_MSG_76);
		Msg_77.LoadString(IDS_MSG_77);
		Msg_78.LoadString(IDS_MSG_78);
		Msg_79.LoadString(IDS_MSG_79);
		Msg_80.LoadString(IDS_MSG_80);
		Msg_81.LoadString(IDS_MSG_81);
		Msg_82.LoadString(IDS_MSG_82);
		Msg_83.LoadString(IDS_MSG_83);
		Msg_84.LoadString(IDS_MSG_84);
		Msg_85.LoadString(IDS_MSG_85);
		Msg_86.LoadString(IDS_MSG_86);
	#ifndef RD_AS_ETALON
		isFree= FALSE;
		Msg_P01.LoadString(IDS_MSG_87);
		Msg_P02.LoadString(IDS_MSG_88);
		Msg_P03.LoadString(IDS_MSG_89);
		Msg_P04.LoadString(IDS_MSG_90);
		Msg_P05.LoadString(IDS_MSG_96);
		Msg_P06.LoadString(IDS_MSG_97);
		Msg_P07.LoadString(IDS_MSG_98);
		Msg_P08.LoadString(IDS_MSG_99);
	#else
		pList= NULL;
	#endif
		Msg_100.LoadString(IDS_MSG_100);
		Msg_101.LoadString(IDS_MSG_101);
		Msg_102.LoadString(IDS_MSG_102);
		Msg_103.LoadString(IDS_MSG_103);
		Msg_104.LoadString(IDS_MSG_104);
	}
	pUnPackFrmt= (char*)(LPCTSTR)Msg_77;
	NotFreeSpace= (char*)(LPCTSTR)Msg_83;

	Bad_Installed_CIBs.LoadString(IDS_BAD_INST_SRC);
	NotFind_Installed_CIBs.LoadString(IDS_NOT_FIND_INST_SRC);

	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_pLoginDlg= NULL;
	pRBI= NULL;

	ppHDDs= (LPBRDR32_HDD)malloc(sizeof(BRDR32_HDD) * MAX_HDD_COUNT);
	memset(ppHDDs, 0, sizeof(BRDR32_HDD) * MAX_HDD_COUNT);

	pSelctMesgs[0]= pSelctMesgs[1]= (char*)(LPCTSTR)Msg_0;
	pSelctMesgs[2]= (char*)(LPCTSTR)Msg_1;
	pSelctMesgs[3]= (char*)(LPCTSTR)Msg_2;
	pSelctMesgs[4]= (char*)(LPCTSTR)Msg_3;

	realACode= aCode= 0;

	m_keyDiskProcess= 0;

	hTickThread0= hTickThread= hInstllThread= NULL;

	m_restoreINI= FALSE;

	bOnMake= FALSE;

	initFirst= TRUE;
	installed= FALSE;
#ifndef	_GCD_CLIENT
	makedKey= makedStr= makedNdt= makedTmp= -1;
#endif
	bOnRestore= TRUE;

	m_SpacePrnt= m_hPrnt= NULL;

	szFrmt= (char*)(LPCTSTR)Frmt1;
	szFrmtN= (char*)(LPCTSTR)Frmt1a;
	szFrmtU= (char*)(LPCTSTR)Frmt01;
	szUnk= (char*)(LPCTSTR)Msg_60;

	timeOn10sec= 0;

	getOldPathBase= isTrial= 0;

	m_TrialQ= TRUE;

#if defined (_GCD_CLIENT)
	m_CurrHlpName= "\\GBABREEDER.HLP";
#else
	#if defined (PILOT)
	m_CurrHlpName= "\\GBLPILOTSERVERBREEDR.HLP";
	#else
	m_CurrHlpName= "\\BREEDR32.HLP";
	#endif
#endif
	m_CurrHlpTopicID= 60;
	m_AnswerCount= m_SelectNext= 0;
	m_sRet= "";
	iHASPFind= 0;
	pRegOrg= pRegNum= 0;
}

int GWinScreen::Init(const char* title)
{
	InitScreen("");
	ShowMessage((char*)(LPCTSTR)Msg_63);
	return 1;
}


void CTestBreeder32Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CTestBreeder32Dlg)
	DDX_Control(pDX, IDC_MSG_DEALER, m_MsgDealer);
	DDX_Control(pDX, IDC_LIST2, m_DealerInfo);
	DDX_Control(pDX, IDCANCEL, m_BttnExit);
	DDX_Control(pDX, IDC_INET_SETTINGS, m_BttnSettings);
	DDX_Text(pDX, IDC_EDIT_ANSWER, m_AnswerStr);
	DDX_Control(pDX, ID_COPYPASSWORD, m_CopyPassword);
	DDX_Control(pDX, IDC_EDIT_ANSWER, m_EditCtrl);
	DDX_Control(pDX, IDC_RADIO3, m_Radio3);
	DDX_Control(pDX, IDC_RADIO4, m_Radio4);
	DDX_Radio(pDX, IDC_RADIO3, m_iColor);
	DDX_Control(pDX, ID_NEXT, m_BttnNext);
	DDX_Control(pDX, IDC_TREE1, m_CIBsTree);
	DDX_Control(pDX, IDC_PROCESS_MSG, m_ProcessMsg);
	DDX_Control(pDX, IDC_PROGRESS1, m_Progress);
	DDX_Control(pDX, IDC_MSG_0, m_Msg0);
	DDX_Control(pDX, IDC_MSG_1, m_Msg1);
	DDX_Control(pDX, IDC_MSG_2, m_Msg2);
	DDX_Control(pDX, IDC_STATIC_01, m_Static_01);
	DDX_Control(pDX, IDC_STATIC_02, m_Static_02);
	DDX_Control(pDX, IDC_STATIC_03, m_Static_03);
	DDX_Control(pDX, IDC_RADIO6, m_Static_73);
	DDX_Control(pDX, IDC_BROWSE, m_BttnBrws);
	DDX_Control(pDX, IDC_STATIC_AD1, m_Msg70);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CTestBreeder32Dlg, CDialog)
	//{{AFX_MSG_MAP(CTestBreeder32Dlg)
#if (defined(_WIN64) || defined(__LP64__))
	// я Так и не вьехал почему нельзя преобразовать адрес функции.... Только чтоб собиралось и не сбивало 64-е сборку
#else
	ON_WM_TIMER()
#endif
	ON_EN_CHANGE(IDC_EDIT_ANSWER, OnChangeEditAnswer)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_NOTIFY(TVN_SELCHANGED, IDC_TREE1, OnSelchangedTree1)
	ON_BN_CLICKED(ID_NEXT, OnNext)
	ON_MESSAGE(WM_ON_OPEN, OnFileOpen)
	ON_MESSAGE(WM_ON_INSTALL, OnTryInstall)
	ON_BN_CLICKED(IDC_BROWSE, OnBrowse)
	ON_BN_CLICKED(ID_COPYPASSWORD, OnCopyPassword)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


static COMPLECTINFO *pCIB_Info;
static int old_CIB_is_install;
static char old_install_path[2048];
static char distrib_path[ MAX_PATH ];

#ifndef RD_AS_ETALON
int IsBelongsOk(COMPLECTINFO *p_Info, char *pBlngs)
{
	int i= 0, next, curr;
	WORD ComplectCount= pCIB_Info->ComplectCount/2;
	if(memcmp(p_Info->Bases[0], "0", 2)){
		do{
			next= atoi(pCIB_Info->Bases[i++]);
			while((curr= atoi(pBlngs)) < next){
				if((pBlngs= strchr(pBlngs, ',')) == NULL)
					return 1;
				pBlngs++;
			}
		}while(curr == next && i < ComplectCount);
	}else
		// Для Максимума может не совподать !
		return 0;
	return (!(curr == next && i == ComplectCount));
}
#endif

int PassEntered= 0, defSelParam= 1, notTruncTarget= 0;
char currInstallName[256], defAllFullName[6]= "*.ndt";

/////////////////////////////////////////////////////////////////////////////
// CTestBreeder32Dlg message handlers

BOOL CTestBreeder32Dlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	InPharmFiles.RemoveAll();
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);
#ifdef RD_AS_ETALON
	m_EditCtrl.pParentDlg= this;
#else
	m_DefaultRD_Hash= 0;
	lOnFloppy= -1;
#endif

	m_tooltip.Create(this);
	m_tooltip.Activate(TRUE);
	m_tooltip.AddTool( GetDlgItem (ID_COPYPASSWORD), IDS_COPYPASSWORD);

	HICON m_bIcon = AfxGetApp()->LoadIcon(IDI_COPYPASSWORD);
	::SendMessage(m_CopyPassword.m_hWnd,BM_SETIMAGE,IMAGE_ICON,(long)m_bIcon);

	HideControl(&m_MsgDealer);
	HideControl(&m_DealerInfo);
	HideControl(&m_Static_02);
	HideControl(&m_Static_03);
	HideControl(&m_CopyPassword);

	HideControl(&m_Radio3);
	HideControl(&m_Radio4);

	HideControl(&m_EditCtrl);
	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Create the image list we will need
	m_ImageList.Create (IDB_BITMAP_ICONS, 16, 1, RGB (255, 0, 255));

	// Associate the image list with the tree
	m_CIBsTree.SetImageList(&m_ImageList, TVSIL_NORMAL);

	m_CIBsTree.pDlg= this;

	//qqq.Format(Frmt0, Msg_60a);
	m_Msg0.SetWindowText("");//qqq);

	qqq.Format(Frmt01, Msg_60);
	m_Msg1.SetWindowText(qqq);

	char* apath = strdup(pPilotBaseName->GetBuffer(0));
	if ( strlen( apath )) {
		qqq.Format(Frmt2, CorrectMyGetDiskFreeSpace (apath)/(1024*1024));
		/*
		if (apath[0] == '\\' )
			qqq.Format(Frmt2, (MyGetDiskFreeSpace(apath)/(1024*1024)));
		else {
			char newpath[4];
			strncpy(newpath,apath,3);
			newpath[3] = 0;
			qqq.Format(Frmt2, (MyGetDiskFreeSpace(newpath)/(1024*1024)));
		}
		*/
		m_Msg2.SetWindowText(qqq);
		free( apath );
	}
	m_BttnNext.EnableWindow( FALSE );

	m_BttnBrws.EnableWindow( FALSE );
	HideControl(&m_BttnBrws);
	m_Static_73.EnableWindow( FALSE );
	HideControl(&m_Static_73);
	m_Msg70.EnableWindow( FALSE );
	HideControl(&m_Msg70);

	m_Progress.SetRange( 0, 100 );

	pHDD= NULL;

	pGSScreen= new GWinScreen(this);
	pGSScreen->Init("");
	pGSScreen->pReadErrorMsg= (LPCTSTR)Msg_85;
	pGSScreen->pWriteErrorMsg= (LPCTSTR)Msg_78;
#ifdef INC_OLD_FAST_CPY
	pGSScreen->not_Cache= not_Cache;
#endif

	pGSScreen->notSplit= 0;

	if(isLookFlpp())
		pGSScreen->isNT= 0;
	else
		pGSScreen->isNT= 1;

	m_pLoginDlg= new CLoginDlg(this);

	#ifndef RD_AS_ETALON
	_InitHash();
	#endif
#if defined (_GCD_CLIENT) || defined (PILOT)
	int old_CIB_is_install = FALSE;
	strcpy (old_install_path, pPilotDistribPath->operator LPCTSTR ());
	strcpy (distrib_path, pPilotDistribPath->operator LPCTSTR ());
	m_VerType = VERTYPE_NET;
#else
	if((old_CIB_is_install= open( g4xPathINI, O_RDONLY, 0664)) != -1){
		close(old_CIB_is_install);
	}else{
		BeepWarning();
		MessageBox(Msg_71, Msg_76, MB_OK|MB_ICONERROR);
		EndDialog(-1);
		return FALSE;
	}
	#ifndef RD_AS_ETALON
		if(!::GetPrivateProfileString("Setup", "RD_Hash_LW", "", old_install_path, 1024, g4xPathINI )){
				m_DefaultRD_Hash= 0;
				m_ThreadID= 0;
		}else if(!(m_DefaultRD_Hash= (DWORD)atoi(old_install_path)) ||
			!::GetPrivateProfileString("Setup", "RD_Hash_HI", "", old_install_path, 1024,g4xPathINI )){
		}else{
			DWORD dwTmp= (DWORD)atoi(old_install_path);
			m_ThreadID= m_DefaultRD_Hash;
			HashDWORD(&m_ThreadID);
			if(	m_ThreadID != dwTmp )
				m_ThreadID= -1;
		}
		if(m_ThreadID == -1){
			BeepWarning();
			MessageBox(Msg_71, Msg_76, MB_OK|MB_ICONERROR);
			EndDialog(-1);
			return FALSE;
		}
	#endif
		::GetPrivateProfileString("Setup", "Source", "", old_install_path, 1024, g4xPathINI);
		PROTINFO tmp;

		strcpy(pathBasesOrigin, g4xPathORG );

		if(::ReadProtInfo( &tmp, "PRIMARY" ) != 1){
			BeepWarning();
			MessageBox(Msg_70, Msg_76, MB_OK|MB_ICONERROR);
			EndDialog(-1);
			return FALSE;
		};

		m_VerType= tmp.VerType;
		m_HardwareID= tmp.HardwareID;

		pCIB_Info = (COMPLECTINFO*)malloc( 1024*26 );

		old_CIB_is_install= ::ReadComplectInfo( pCIB_Info );

		if ( old_CIB_is_install > 0 )
			((CTestBreeder32App*)AfxGetApp())->AskFileName = false;			

		if ((old_CIB_is_install > 0 && pCIB_Info->ComplectWeight & 4)
			|| !(pRegOrg= new char[SIZE_PROT_REGFIELD])
			|| !(pRegNum= new char[SIZE_PROT_REGFIELD])
			|| ::ReadUserInfo ( pRegOrg, pRegNum ) != 1){
			BeepWarning();
			MessageBox(Msg_72, Msg_76, MB_OK|MB_ICONERROR);
			EndDialog(-1);
			return FALSE;
		}
#endif
	m_CIBsTree.EnableWindow(FALSE);
	m_Progress.ShowWindow(SW_HIDE);
	SetDefID(ID_NEXT);
	if(PassEntered){
		//NextDlgCtrl();
		HideControl(&m_BttnSettings);
	}
	m_uTimerID = SetTimer(0x451,1000,NULL);
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CTestBreeder32Dlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX) {
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	} else {
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CTestBreeder32Dlg::OnPaint() 
{
	if (IsIconic()) {
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	} else {
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CTestBreeder32Dlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

BOOL CAboutDlg::DestroyWindow() 
{
	return CDialog::DestroyWindow();
}

void CTestBreeder32Dlg::deleteHDDs()
{
	for(int ss=0; ss < MAX_HDD_COUNT; ss++){
		if(ppHDDs[ss].pHDD != NULL && ppHDDs[ss].pHDD != pHDD){
			deleteOpenedBase(ppHDDs[ss].pHDD);
			ppHDDs[ss].pHDD= NULL;
		}
		delete [](ppHDDs[ss].bws);
		ppHDDs[ss].bws= NULL;
	}
}

BOOL CTestBreeder32Dlg::DestroyWindow() 
{
	Sleep(500);
	if(hTickThread != NULL){
		TerminateThread(hTickThread, 0);
	}
	deleteHDDs();
	free(ppHDDs);

	if(	pHDD != NULL ){
		deleteOpenedBase(pHDD);
		pHDD= NULL;
	}
	if(m_pLoginDlg != NULL){
		delete m_pLoginDlg;
		m_pLoginDlg= NULL;
	}
#ifdef RD_AS_ETALON
	if(pList != NULL){
		pl_FreeImportedComplectList(pList);
		pList= NULL;
	}
#endif
	if(pGSScreen != NULL){
		//if(pGSScreen->isNT) Sleep(200);
		//delete pGSScreen;
		pGSScreen= NULL;
	}
	if(pRBI != NULL){
		delete []pRBI;
		pRBI= NULL;
	}
	if(m_restoreINI){
		::WritePrivateProfileString("Environment", "Data", tmp_valuies1,g4xPathINI );
		::WritePrivateProfileString(NULL, NULL, NULL, g4xPathINI );
		char *tstFile= strdup(testFile);
		memcpy(strrchr(tstFile, '.'), ".LCK", 5);
		unlink(tstFile);
		free(tstFile);
	}
	if(pRegOrg){
		delete []pRegOrg;
		pRegOrg= NULL;
	}
	if(pRegNum){
		delete []pRegNum;
		pRegNum= NULL;
	}
	return CDialog::DestroyWindow();
}

LRESULT CTestBreeder32Dlg::OnTryInstall(WPARAM wParam, LPARAM lParam)
{
	if(gProcMssg){
		OnBrowse();
	}else
		OnNext();
	return 0;
}

extern int isLastFile(LPPF_PARAM);
extern void preCheckMultiDisk(Base *);

void CTestBreeder32Dlg::OnSelchangedTree1(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_TREEVIEW* pNMTreeView = (NM_TREEVIEW*)pNMHDR;
	if(!pNMTreeView->itemNew.hItem)
		return;

#if !defined(RD_AS_ETALON) && !defined(AS_HDD_ROOT)
	if(!iTreeRegen){
		HideControl(&m_EditCtrl);
		ShowControl(&m_Msg2);
	}
#endif

	m_baseIndx= pNMTreeView->itemNew.lParam / MAX_HDD_COUNT;
	pHDD= ppHDDs[m_baseIndx].pHDD;
	int *pCurrentWeight= ppHDDs[m_baseIndx].currentWeight, aa= 1, OkNext= FALSE;

	while(*pCurrentWeight){
		if(*pCurrentWeight < 0){
			aa= 0;
			break;
		}
		pCurrentWeight += 2;
	}

	if(m_pLoginDlg != NULL && !(pNMTreeView->itemNew.lParam % MAX_HDD_COUNT)){
#if !defined(RD_AS_ETALON) && !defined(AS_HDD_ROOT)
		if(iTreeRegen == -1){
			if( m_CIBsTree.GetParentItem(pNMTreeView->itemOld.hItem) == pNMTreeView->itemNew.hItem){
				m_CIBsTree.SetItemImage(pNMTreeView->itemOld.hItem, 1, 1);
				return;
			}else if(!(m_CIBsTree.GetItemData(pNMTreeView->itemOld.hItem)% MAX_HDD_COUNT)){
				m_CIBsTree.SetItemImage(pNMTreeView->itemOld.hItem, 0, 4);
			}else
				m_CIBsTree.SetItemImage(m_CIBsTree.GetParentItem(m_SpacePrnt), 0, 4);
			m_CIBsTree.SetItemImage(m_SpacePrnt, 0, 1);
			m_CIBsTree.SetItemImage(pNMTreeView->itemNew.hItem, 4, 4);
		}
#endif
		pGSScreen->OtherShowMessage(*pSelctMesgs);
		if(pNMTreeView->itemNew.hItem != m_hPrnt){
#ifdef RD_AS_ETALON
			m_CIBsTree.SetItemImage(m_hPrnt, 0, 0);
			if(aa)
				m_CIBsTree.SetItemImage(pNMTreeView->itemNew.hItem, 1, 1);
			else
				m_CIBsTree.SetItemImage(pNMTreeView->itemNew.hItem, 4, 4);
#else
			if(m_hPrnt == NULL){
				m_hPrnt= pNMTreeView->itemNew.hItem;
				if(m_SpacePrnt){
					if(First){
						First= FALSE;
						m_CIBsTree.SelectItem(m_SpacePrnt);
					}
					return;
				}
			}else{
				m_hPrnt= pNMTreeView->itemNew.hItem;
				if(ppHDDs[m_baseIndx].pList == NULL)
					m_SpacePrnt= 0;
				else{
					if(m_SpacePrnt && m_CIBsTree.GetParentItem(m_SpacePrnt)
											== pNMTreeView->itemNew.hItem)
					;
					else{
						m_SpacePrnt= m_CIBsTree.GetChildItem(pNMTreeView->itemNew.hItem);
						if(m_SpacePrnt){
							m_CIBsTree.SelectItem(m_SpacePrnt);
							return;
						}
					}
				}
			}
#endif
			m_hPrnt= pNMTreeView->itemNew.hItem;
			OkNext= TRUE;
		}
#ifndef RD_AS_ETALON
		else
			;//m_CIBsTree.SelectItem(m_SpacePrnt);

		if(!m_SpacePrnt){
			if(!ppHDDs[m_baseIndx].pList){
				qqq.Format(Msg_P01, bff);
				m_Msg0.SetWindowText(qqq);
				m_Msg1.SetWindowText("");
				pGSScreen->OtherShowMessage(Msg_P02);
				HideControl(&m_Msg2);
				ShowControl(&m_EditCtrl);
				/*if(old_CIB_is_install != 1){
					m_CIBsTree.EnableWindow(FALSE);
				}*/
			}else{
				BeepWarning();
				MessageBox(Msg_62, Msg_76, MB_OK|MB_ICONERROR);
				((CTestBreeder32App*)AfxGetApp())->Log (Msg_62.GetBuffer (0));
				((CTestBreeder32App*)AfxGetApp())->Log ("\n");

				install_status = 2;
				send_internet_result ();

				EndDialog(-1);
			}
			return;
		}
#else
		hTreeItem_curr= pNMTreeView->itemNew.hItem;
#endif
		NameCIB= m_CIBsTree.GetItemText(pNMTreeView->itemNew.hItem);
		NameCC = m_CIBsTree.GetItemText(m_CIBsTree.GetParentItem(pNMTreeView->itemOld.hItem));
	}else{
		HTREEITEM hPrnt= m_CIBsTree.GetParentItem(pNMTreeView->itemNew.hItem);
  #ifndef AS_HDD_ROOT
		if(iTreeRegen != -1)
  #endif
			NameCIB= m_CIBsTree.GetItemText(hPrnt);
		if(hPrnt && hPrnt != m_hPrnt){
			if(m_hPrnt)
#ifdef RD_AS_ETALON
				m_CIBsTree.SetItemImage(m_hPrnt, 0, 0);
			hTreeItem_curr= 
#elif !defined(AS_HDD_ROOT)
		if(iTreeRegen == -1 && pNMTreeView->itemOld.hItem){
			if((m_CIBsTree.GetItemData(pNMTreeView->itemOld.hItem)% MAX_HDD_COUNT))
				m_CIBsTree.SetItemImage(
					m_CIBsTree.GetParentItem(pNMTreeView->itemOld.hItem), 0, 4);
			else{
				m_CIBsTree.SetItemImage(
					m_CIBsTree.GetParentItem(m_SpacePrnt), 0, 4);
				m_CIBsTree.SetItemImage(m_SpacePrnt, 0, 1);
			}
			m_CIBsTree.SetItemImage(
				m_CIBsTree.GetParentItem(pNMTreeView->itemNew.hItem), 4, 4);
		}
#endif
			m_hPrnt= hPrnt;
			OkNext= TRUE;
#ifdef RD_AS_ETALON
			if(aa)
				m_CIBsTree.SetItemImage(hPrnt, 1, 1);
			else
				m_CIBsTree.SetItemImage(hPrnt, 4, 4);
#endif
		}
#ifndef AS_HDD_ROOT
		else if(iTreeRegen == -1 && m_SpacePrnt){
			m_CIBsTree.SetItemImage(m_SpacePrnt, 0, 1);
		}
#endif
#ifndef RD_AS_ETALON
		LPPL_IMPORT_CIB_DATA pTmpCIBs;
	    LPPL_IMPORT_COMPLECT_DATA pList= ppHDDs[m_baseIndx].pList;
		LPPL_IMPORT_COMPLECT_DATA pNext= pList;
		aa= pNMTreeView->itemNew.lParam % MAX_HDD_COUNT;
		if(iTreeRegen == -1){
			defSelParam= aa;
			if(PassEntered)
				m_CIBsTree.EnableWindow(FALSE);
		}
		m_SpacePrnt= pNMTreeView->itemNew.hItem;

			do{
				pTmpCIBs= pNext->pCIBs;
		do{
			if(!--aa){
				pCurrCIBs= pTmpCIBs;
				pCurrentWeight=  ppHDDs[m_baseIndx].currentWeight;
				while(*pCurrentWeight){
					if(*pCurrentWeight < 0){
						*pCurrentWeight *= -1;
					}
					pCurrentWeight += 2;
				}
				strcpy(sTr, returnRD_Name(pCurrCIBs->Alias));
				rrr= returnRD_Blngs(pCurrCIBs->Alias);
				int ccc= rrr.Find('~');
				if(ccc != -1){
					rrr= rrr.Left(ccc);
				}
				OkNext= atoi(rrr);
				pCurrentWeight=  ppHDDs[m_baseIndx].currentWeight;
				while(*pCurrentWeight){
					if(*pCurrentWeight < OkNext){
						*pCurrentWeight *= -1;
					}else if(strchr((LPCTSTR)rrr, ',')){
						rrr= (strchr((LPCTSTR)rrr, ',')+1);
						OkNext= atoi(rrr);
					}else{
						pCurrentWeight += 2;
						break;
					}
					pCurrentWeight += 2;
				}
				while(*pCurrentWeight){
					*pCurrentWeight *= -1;
					pCurrentWeight += 2;
				}
				pLogin= pCurrCIBs->pLogin;
				m_DefaultRD_Hash= *returnRD_ClntHash(pCurrCIBs->Alias);

				isFree= m_TrialQ=  lOnFloppy= isTrial= lVIP_flag= FALSE;

				if((lVIP_flag= *returnDelivery_Type(pCurrCIBs->Alias)) == PL_FREE_FLAG){
					isFree= TRUE;
				}else if((lVIP_flag & 0xffff) == PL_TRIAL_FLAG){
					isTrial= lVIP_flag >> 16;
				}
if(PassEntered)
lVIP_flag= PL_VIP_FLAG;
else{
				if((lVIP_flag= *returnVIP_Flag(pCurrCIBs->Alias)) == PL_VIP_FLAG)
					lVIP_flag= PL_VIP_FLAG;
				else if((lVIP_flag & 0xffff) == PL_FLP_FLAG){
					lOnFloppy= (lVIP_flag >> 16)+1;
	/*
		Закоментарино т.к. дискета всегда подходит в Win 95-98
	#ifndef ONLY_DISTR_WITH_KEY
					if(isLookFlpp()){
						if(m_hPrnt)
							m_CIBsTree.SetItemImage(m_hPrnt, 5, 5);
					}
	#endif*/
				}
}
	/*
		Закоментарино т.к. подходящий ППД с HASP итак только один
	#ifndef ONLY_DISTR_WITH_KEY
				else if(DistribHASP_Ok == TRUE){
					if(m_hPrnt)
						m_CIBsTree.SetItemImage(m_hPrnt, 5, 5);
				}
	#endif*/
  #ifndef AS_HDD_ROOT
				iID_User= *returnID_User_CIB(pCurrCIBs->Alias);
  #endif
			}
		}while((pTmpCIBs= (LPPL_IMPORT_CIB_DATA)pTmpCIBs->next));
 			}while((pNext= (LPPL_IMPORT_COMPLECT_DATA)pNext->next));
#ifdef RD_AS_ETALON
		Recoding( cd_dos, cd_win, sTr );
		m_CIBsTree.SetItemText(	m_hPrnt, (NameCIB= sTr));
#else
  #ifdef AS_HDD_ROOT
		m_CIBsTree.SetItemText(	m_hPrnt, (NameCIB= sTr));
  #else
		if(old_CIB_is_install == 1){
			m_CIBsTree.SetItemText(	m_hPrnt, 
									m_CIBsTree.GetItemText(pNMTreeView->itemNew.hItem));
			m_CIBsTree.SetItemImage( m_hPrnt, 4, 4 );
			m_CIBsTree.SetItemText(	pNMTreeView->itemNew.hItem, (NameCIB= sTr));
			iTreeRegen= -1;
		}else if(!iTreeRegen){
			HTREEITEM	m_hNxtChild, m_hCurrFirst, m_hFirstInsert= 0,
						m_hDeleted= 0;
			CString TstCIB;
			do{
				TstCIB= sTr;
//				m_hNxtTest= m_CIBsTree.GetNextItem(
//									pNMTreeView->itemNew.hItem, TVGN_CHILD);
				iTreeRegen= 0;
				currClientName= m_CIBsTree.GetItemText(pNMTreeView->itemNew.hItem);
				iID_LstUser= iID_User;
				currCIBName= TstCIB;
				m_hCurrFirst= pNMTreeView->itemNew.hItem;
				m_hNxtChild= pNMTreeView->itemNew.hItem;
				TreeCtrlItemAdded.hParent = m_hPrnt;
				TreeCtrlItemAdded.item.iImage = 0;
				TreeCtrlItemAdded.item.iSelectedImage = 1;
				TreeCtrlItemAdded.hInsertAfter = TVI_LAST;
				TreeCtrlItemAdded.item.mask = TVIF_TEXT | TVIF_PARAM | TVIF_IMAGE | TVIF_SELECTEDIMAGE;
				do {
					do{
						iTreeRegen++;
						if(iTreeRegen > 1){
							if(m_hDeleted){
								m_CIBsTree.DeleteItem(m_hDeleted);
								m_hDeleted= 0;
							}
							if(//currClientName == CString(m_CIBsTree.GetItemText(pNMTreeView->itemNew.hItem))
								iID_LstUser == iID_User){
		/////////////////////////
		if(m_CIBsTree.GetParentItem(m_hCurrFirst) == m_hPrnt){
			if((m_hNxtChild= m_CIBsTree.GetNextItem(m_hCurrFirst, TVGN_NEXT))
				!= pNMTreeView->itemNew.hItem){
				TreeCtrlItemAdded.item.lParam =
					m_CIBsTree.GetItemData(pNMTreeView->itemNew.hItem);
				m_CIBsTree.SetItemText(	pNMTreeView->itemNew.hItem,
										m_CIBsTree.GetItemText(m_hNxtChild));
				m_CIBsTree.SetItemData(	pNMTreeView->itemNew.hItem,
										m_CIBsTree.GetItemData(m_hNxtChild));
				m_CIBsTree.SetItemData(	m_hNxtChild, TreeCtrlItemAdded.item.lParam);
			}
			m_CIBsTree.SetItemText(	m_hCurrFirst, currCIBName);
			m_hCurrFirst= m_hNxtChild;
			currCIBName= pLastCIB_Name;
			m_hNxtChild= pNMTreeView->itemNew.hItem;
		}else{
								TreeCtrlItemAdded.item.pszText = pLastCIB_Name;
								TreeCtrlItemAdded.item.lParam = m_CIBsTree.GetItemData(m_hNxtChild);
								if(!m_hFirstInsert){
									m_hFirstInsert= m_CIBsTree.InsertItem(&TreeCtrlItemAdded);
									if(!m_hFirstInsertCurr)
										m_hFirstInsertCurr= m_hFirstInsert;
								}else{
									m_CIBsTree.InsertItem(&TreeCtrlItemAdded);
								}
								m_CIBsTree.SelectItem(0);
								if(!m_CIBsTree.GetNextItem(m_hNxtChild, TVGN_NEXT)
									&& m_hNxtChild == m_CIBsTree.GetChildItem(m_hPrnt)
									&& (m_hPrnt= m_CIBsTree.GetNextItem(m_hPrnt, TVGN_NEXT))){
									pNMTreeView->itemNew.hItem= m_hPrnt;
									//m_hDeleted= m_CIBsTree.GetParentItem(m_hNxtChild);
									//m_CIBsTree.DeleteItem(m_hNxtChild);
									m_CIBsTree.DeleteItem(m_CIBsTree.GetParentItem(m_hNxtChild));
								}else{
									m_hDeleted= pNMTreeView->itemNew.hItem;
								}
		}
		/////////////////////////
							}
						}
					}while( ((pNMTreeView->itemNew.hItem == m_hPrnt
								&& (m_hNxtChild= m_CIBsTree.GetNextItem(m_hPrnt, TVGN_CHILD))
								&& (pNMTreeView->itemNew.hItem= m_hNxtChild)) ||
							(m_hNxtChild= m_CIBsTree.GetNextItem(pNMTreeView->itemNew.hItem, TVGN_NEXT)))
								&& (pNMTreeView->itemNew.hItem= m_hNxtChild)
								&& m_CIBsTree.SelectItem(m_hNxtChild));
					iTreeRegen += 100;
				}while(m_CIBsTree.SelectItem(m_CIBsTree.GetNextItem(m_hPrnt, TVGN_NEXT)) &&
						(m_hNxtChild= pNMTreeView->itemNew.hItem= m_CIBsTree.GetSelectedItem()));

				m_CIBsTree.SetItemText(	m_hCurrFirst, currCIBName);
				m_CIBsTree.SetItemImage(	m_hCurrFirst, 0, 1);
				m_CIBsTree.SetItemText(	TreeCtrlItemAdded.hParent, currClientName);
				m_CIBsTree.SetItemImage(	TreeCtrlItemAdded.hParent, 0, 4);

				if((pNMTreeView->itemNew.hItem= m_CIBsTree.GetNextItem(m_hCurrFirst, TVGN_NEXT))
						&& pNMTreeView->itemNew.hItem != m_hFirstInsertCurr){
					iTreeRegen= 0;
					if((TreeCtrlItemAdded.hParent= m_hPrnt=
							m_CIBsTree.GetNextItem(m_CIBsTree.GetParentItem(
														m_hCurrFirst), TVGN_NEXT))){
						;
					}else{
						TreeCtrlItemAdded.hParent= TVI_ROOT;
						TreeCtrlItemAdded.item.iImage = 0;
						TreeCtrlItemAdded.item.lParam = 0;
						TreeCtrlItemAdded.item.iSelectedImage = 4;
						TreeCtrlItemAdded.item.pszText = "";
						TreeCtrlItemAdded.hParent= m_hPrnt
							=m_CIBsTree.InsertItem(&TreeCtrlItemAdded);
					}
					if(!iTreeRegen){
						do{
							m_hCurrFirst= pNMTreeView->itemNew.hItem;
							TstCIB= m_CIBsTree.GetItemText(m_hCurrFirst);
							TreeCtrlItemAdded.item.pszText = "";
							TreeCtrlItemAdded.item.lParam = m_CIBsTree.GetItemData(m_hCurrFirst);
							m_CIBsTree.SetItemText(m_CIBsTree.InsertItem(&TreeCtrlItemAdded), TstCIB);
						}while((pNMTreeView->itemNew.hItem= m_CIBsTree.GetNextItem(m_hCurrFirst, TVGN_NEXT))
								&& pNMTreeView->itemNew.hItem != m_hFirstInsertCurr
								&& m_CIBsTree.DeleteItem(m_hCurrFirst));
						m_hFirstInsertCurr= m_CIBsTree.GetParentItem(m_hCurrFirst);
						m_CIBsTree.DeleteItem(m_hCurrFirst);
						m_CIBsTree.Expand(m_hFirstInsertCurr, TVE_COLLAPSE);
						m_hFirstInsertCurr= 0;
						m_CIBsTree.SelectItem(m_CIBsTree.GetChildItem(m_hPrnt));
						return;
					}else
						break;
				}else{
					if(m_hDeleted){
						m_CIBsTree.DeleteItem(m_CIBsTree.GetParentItem(m_hDeleted));
						m_hDeleted= 0;
					}
					m_hFirstInsertCurr= m_CIBsTree.GetParentItem(m_hCurrFirst);
					pNMTreeView->itemNew.hItem= m_CIBsTree.GetNextItem(m_hFirstInsertCurr, TVGN_NEXT);
					if(pNMTreeView->itemNew.hItem){
						iTreeRegen= 0;
						m_CIBsTree.Expand(m_hFirstInsertCurr, TVE_COLLAPSE);
						m_hFirstInsertCurr= m_hPrnt= 0;
						m_SpacePrnt= m_CIBsTree.GetChildItem(pNMTreeView->itemNew.hItem);
						First= TRUE;
						m_CIBsTree.SelectItem(pNMTreeView->itemNew.hItem);
						return;
					}
					break;
				}
			}while(TRUE);
			iTreeRegen = -1;
			// Уроды из Microsoft в первых версиях comctl32.dll
			// не умели работать с рутовой нодой TVI_ROOT
			// пришлось делать "ручками" !!!
			HTREEITEM hTmp0= m_hPrnt, hTmp1;
			while((hTmp1= m_CIBsTree.GetPrevSiblingItem(hTmp0))){
				hTmp0= hTmp1;
			}
			if(
				//m_CIBsTree.GetChildItem(TVI_ROOT)
				hTmp0
						== m_hPrnt){
				m_CIBsTree.SetItemImage(m_hPrnt, 4, 4);
				m_CIBsTree.SelectItem(m_hCurrFirst);
			}else{
				m_CIBsTree.Expand(m_hPrnt, TVE_COLLAPSE);
				m_hCurrFirst= 
								//m_CIBsTree.GetChildItem(TVI_ROOT)
								hTmp0
																	;
				m_CIBsTree.SetItemImage(m_hCurrFirst, 4, 4);
				m_CIBsTree.SelectItem(m_CIBsTree.GetChildItem(m_hCurrFirst));
			}
			return;
		}else if(iTreeRegen > 0){
			pLastCIB_Name= sTr;
			return;
		}else if(iTreeRegen == -1){
			NameCC = m_CIBsTree.GetItemText(m_hPrnt);
			NameCIB= sTr;
		}
  #endif
#endif
		OkNext= TRUE;
		aa= 1;
		pCurrentWeight=  ppHDDs[m_baseIndx].currentWeight;
		while(*pCurrentWeight){
			if(*pCurrentWeight < 0){
				aa= 0;
				break;
			}
			pCurrentWeight += 2;
		}
#endif
		pGSScreen->OtherShowMessage(Msg_75);
	}
  char tmpOldInstallPath[1024];
  if(!getOldPathBase){
	getOldPathBase++;
//#ifdef RD_AS_ETALON
	memcpy(old_install_path, "..", 2);
	if(old_CIB_is_install == 1){
		char pFrmtInfo[]= "\\Data\\%s.ndt", *pDef;
		if(pCIB_Info->ComplectSet)
			pDef= pCIB_Info->ComplectName;
		else{
			pDef= pCIB_Info->Bases[1];
		}
		sprintf(old_install_path+2, pFrmtInfo, pDef);
//#endif

		testFile= old_install_path;
		*(old_install_path+strlen(old_install_path)-4)= '\0';
		strcpy(tmpOldInstallPath, old_install_path);

		pGSScreen->pUpdatedBase= new PDDBase ( tmpOldInstallPath,
												O_RDONLY|O_NOT_FAT, 0, 0, 0 );
		if(!((PDDBase*)pGSScreen->pUpdatedBase)->IsPagedFilesOk()){
			((PDDBase*)pGSScreen->pUpdatedBase)->DeletePagedFiles(0);
			delete pGSScreen->pUpdatedBase;
			pGSScreen->pUpdatedBase= NULL;
		}
	}else{
		strcpy(old_install_path, "..\\DATA\\");
	}
  }
#if defined (_GCD_CLIENT) || defined (PILOT)
	strcpy(old_install_path, (LPCTSTR)*pPilotBaseDir );
#endif
	m_currBaseSz= 0;
	if(aa){
		long oldSize= 0;
		if(pGSScreen->pUpdatedBase){
			oldSize= ((PDDBase*)pGSScreen->pUpdatedBase)->GetSizeInKbytes() / 1024;
		}
		m_currBaseSz=pHDD->GetSizeInKbytes();

		if(pHDD->IsPacked())
			qqq.Format( Frmt1a, m_currBaseSz/1024 - oldSize, pHDD->GetSizeInKbytes(pHDD->IsPacked())/ 1024 - oldSize);
		else
			qqq.Format(Frmt1, m_currBaseSz/1024 - oldSize);
		m_Msg1.SetWindowText(qqq);
	}else{
		qqq.Format(Frmt01, Msg_60);
		m_Msg1.SetWindowText(qqq);
	}
	if(OkNext){
		iFnd= (FileName= pHDD->textFile->FileName).ReverseFind('.');
		*(((char *)(LPCTSTR)FileName)+iFnd)= '\0';
		if(old_CIB_is_install != 1){
			qqq.Format(Frmt0, NameCIB);
			m_Msg0.SetWindowText(qqq);
		}else{
			m_Msg0.SetWindowText("");
		}
	}
	*pResult= 0;
}

void CTestBreeder32Dlg::HideControl(CWnd *pWnd)
{
	pWnd->EnableWindow(FALSE);
	pWnd->ShowWindow(SW_HIDE);
}

void CTestBreeder32Dlg::ShowControl(CWnd *pWnd)
{
	pWnd->ShowWindow(SW_SHOWNORMAL);
	pWnd->EnableWindow(TRUE);
}

int CTestBreeder32Dlg::IsKeyFlpp(int process)
{
	if(!isLookFlpp())
		return 0;
    STARTUPINFO si;
    PROCESS_INFORMATION pi;

	CString pCmdLine;
	if(!process){
		pCmdLine.Format(Frmt41, "IsKeyDisk", " ");
		/*{int zzz= 1;
			return zzz; ///Debug
		}*/
	}else switch(process){
		case 1:
#ifdef RD_AS_ETALON
			if(isTrial){
				pCmdLine.Format(Frmt41, "CheckCopy", (LPCTSTR)pHaspName, 4);
			}else
#endif
				pCmdLine.Format(Frmt41, "CheckCopy", (LPCTSTR)pHaspName, m_VerType);
			/*{int zzz= 1;
				return zzz; ///Debug
			}*/
			break;
		case 2:
#ifdef RD_AS_ETALON
			if(isTrial){
				pCmdLine.Format(Frmt41, "DecreaseCopy", (LPCTSTR)pHaspName, 4);
			}else
#endif
				pCmdLine.Format(Frmt41, "DecreaseCopy", (LPCTSTR)pHaspName, m_VerType);
			/*{int zzz= 0;
				return zzz; ///Debug
			}*/
			break;
		default:
			return 0;
	}

    ::ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ::ZeroMemory( &pi, sizeof(pi) );

    // Start the child process. 
    if( !::CreateProcess(
		NULL,		// No module name (use command line). 
        (char*)(LPCTSTR)pCmdLine,		// Command line. 
        NULL,			// Process handle not inheritable. 
        NULL,			// Thread handle not inheritable. 
        FALSE,			// Set handle inheritance to FALSE. 
        CREATE_NO_WINDOW,	// No creation flags. 
        NULL,			// Use parent's environment block. 
        NULL,			// Use parent's starting directory. 
        &si,			// Pointer to STARTUPINFO structure.
        &pi )			// Pointer to PROCESS_INFORMATION structure.
    ) 
    {
		return 0;
    }

    // Wait until child process exits.
    ::WaitForSingleObject( pi.hProcess, INFINITE );

	DWORD ret;
	::GetExitCodeProcess( pi.hProcess, &ret );

    // Close process and thread handles. 
    ::CloseHandle( pi.hProcess );
    ::CloseHandle( pi.hThread );

	UpdateData();
	return ret == 0;
}

#ifdef	_GCD_CLIENT
enum SetLicenceCode { 
	PL_OK = 0, PL_INVARG = -1, PL_INVDB = -2, PL_PUTATTR = -3, PL_EXCPT = -4 
};

const unsigned long SI_LEGACY_STORAGE = 1;
const unsigned long SI_PROFILE_STORAGE = 2;

const unsigned long CI_TOPIC = (SI_LEGACY_STORAGE << 16) | 1;
const unsigned long CI_BLOB = (SI_LEGACY_STORAGE << 16) | 2;
const unsigned long CI_GROUP = (SI_PROFILE_STORAGE << 16) | 0;
const unsigned long CI_USER = (SI_PROFILE_STORAGE << 16) | 1;

const unsigned long AI_GET_FULL_ATTRIBUTES = 102;
const unsigned long AI_GET_PARAGRAPH_TEXT = 101;
const unsigned long AI_GET_OBJECT_STREAM = 201;
const unsigned long AI_ADMINISTRATOR = 500;
const unsigned long AI_CHANGE_IDLE_TIMEOUT = 302;

const char* ATTR_NAME_BASE_ACL_COUNT	= "BRC";//"BaseRightsCount";
const char* ATTR_NAME_BASE_ACL_ARRAY	= "BRA";//"BaseRightsArray";
const char* ATTR_NAME_TOPIC_ACL_COUNT	= "TC";//"TopicCount";
const char* ATTR_NAME_TOPIC_ACL_ARRAY	= "TA";//"TopicArray";
const char* ATTR_NAME_BLOB_ACL_COUNT	= "OC";//"ObjectCount";
const char* ATTR_NAME_BLOB_ACL_ARRAY	= "OA";//"ObjectArray";
const char* ATTR_NAME_GROUP_ACL_COUNT	= "GC";//"GroupCount";
const char* ATTR_NAME_GROUP_ACL_ARRAY	= "GA";//"GroupArray";
const char* ATTR_NAME_USER_ACL_COUNT	= "UC";//"UserCount";
const char* ATTR_NAME_USER_ACL_ARRAY	= "UA";//"UserArray";
const char* ATTR_NAME_CRC				= "CIV"; //"CRC MU+PU+MP";
const char* ATTR_NAME_GUEST_ENABLED		= "GE"; //"Guest Enabled";
const char* ATTR_NAME_VERSION			= "VER"; //"Version";
const unsigned SEED_FOR_ADLER32			= 0x31304947;//(unsigned)"GI01";

unsigned long VERSION = 1;

#pragma	pack(push,4)
typedef struct _acl_t {
	unsigned short m_aid;
	unsigned char m_right;
} acl_t;
#pragma	pack(pop)

int PutAttributeArray(PagedFile* pNDT, const char* pCountName, const char* pArrayName, unsigned char nCount, acl_t* pAcl)
{
	if(!pNDT->PutAttr(pCountName, &nCount, sizeof(unsigned char)))
		return PL_PUTATTR;

	if(nCount > 0)
		if(!pNDT->PutAttr(pArrayName, pAcl, sizeof(acl_t)*nCount))
			return PL_PUTATTR;

	return 0;
}

void	SetLicence( PagedFile* pNDT, int max_profiles, int max_num )
{
	int guest_enabled = 1;
	int max_perm = 0;
	int ClientCategory= 0;

	short szSegmentsScale= 0;
	char *SegmentsScale= 0;

#if defined (_GCD_CLIENT) && !defined (RD_AS_ETALON)
	if(ppCurrCIBs){
		guest_enabled= (0x7fffffff & ((returnDelivery_Type((*ppCurrCIBs)->Alias))[1]));
		max_profiles= (0x7fffffff & ((returnDelivery_Type((*ppCurrCIBs)->Alias))[2]));
		max_num = (0x7fffffff & ((returnDelivery_Type((*ppCurrCIBs)->Alias))[3]));
		max_perm= (0x7fffffff & ((returnDelivery_Type((*ppCurrCIBs)->Alias))[4]));

		ClientCategory= (0x7fffffff & ((returnDelivery_Type((*ppCurrCIBs)->Alias))[5]));
		SegmentsScale= (char*)((returnDelivery_Type((*ppCurrCIBs)->Alias))+6);
		szSegmentsScale= (0x7fff & (((short*)SegmentsScale)[0]));
		SegmentsScale += 2;
	}
#endif

	{
		char is_vip = ClientCategory == 10 || ClientCategory == 11 ? 1 : 0;
		pNDT->PutAttr (AUX_VIP, &is_vip, sizeof (is_vip));
	}

	if (SegmentsScale) {
		char perc [40];
		gk_bzero (perc, sizeof (perc));
		strncpy (perc, SegmentsScale, szSegmentsScale);
		pNDT->PutAttr (AUX_PERC, perc, strlen (perc) + 1);
	}

	pNDT->DelAttr("GSec");

	pNDT->PutAttr (BASE_SID, &sid, sizeof (sid));
	pNDT->PutAttr(tagPswdAttr, realPass, sizePswdAttr);

#ifdef VERSION63
	pNDT->PutAttr(tagKIAttr, &Export_ID_CIB, sizeof(long));
#endif
	pNDT->PutAttr(ATTR_NAME_VERSION, &VERSION, sizeof(VERSION));
	pNDT->PutAttr(ATTR_NAME_MAX_USERS, &max_num, sizeof(int));

	pNDT->PutAttr(ATTR_NAME_PERM_USERS, &max_perm, sizeof(int));
	pNDT->PutAttr(ATTR_NAME_MAX_PROFILES, &max_profiles, sizeof(int));
	pNDT->PutAttr(ATTR_NAME_GUEST_ENABLED, &guest_enabled, sizeof(int));

	int buf[4];
	buf[0] = max_num; buf[1] = max_perm; buf[2] = max_profiles; buf[3]=guest_enabled;
	unsigned crc = adler32 ( SEED_FOR_ADLER32, (unsigned char*) buf, sizeof (buf) );
	pNDT->PutAttr(ATTR_NAME_CRC, &crc, sizeof(int));

	unsigned char nTopic = 0, nBlob = 0, nUser = 0, nGroup = 0;
	acl_t aclTopic[] = { {AI_GET_PARAGRAPH_TEXT, 0}, {AI_GET_FULL_ATTRIBUTES, 0} };
	acl_t aclBlob[] = { {AI_GET_OBJECT_STREAM, 0}};
	acl_t aclUser[] = { {AI_ADMINISTRATOR, 0}, {AI_CHANGE_IDLE_TIMEOUT, 0} };
	acl_t aclGroup[] = { {AI_ADMINISTRATOR, 0}};

	//commercial
	nTopic = sizeof(aclTopic) / sizeof(acl_t);
	aclTopic[0].m_right = 1;
	aclTopic[1].m_right = 0;
	nBlob = sizeof(aclBlob) / sizeof(acl_t);
	aclBlob[0].m_right = 1;

	PutAttributeArray(pNDT, ATTR_NAME_TOPIC_ACL_COUNT, ATTR_NAME_TOPIC_ACL_ARRAY,nTopic, aclTopic);
	PutAttributeArray(pNDT, ATTR_NAME_BLOB_ACL_COUNT, ATTR_NAME_BLOB_ACL_ARRAY, nBlob, aclBlob);
	//PutAttributeArray(pNDT, ATTR_NAME_USER_ACL_COUNT, ATTR_NAME_USER_ACL_ARRAY,	nUser, aclUser);
	//PutAttributeArray(pNDT, ATTR_NAME_GROUP_ACL_COUNT, ATTR_NAME_GROUP_ACL_ARRAY, nGroup, aclGroup);


}

u_int64_t get_file_set_size = 0;
GslDataPipe::FileReadingSet* get_file_set (const std::string& base_path) {
	get_file_set_size = 0;

	typedef std::pair<std::string, GslDataPipe::PipeManager_var> FileData;
	typedef std::vector<FileData> FileDataVector;

	_finddata_t find_data;
	char aMask[ MAX_PATH ];
	MakePath( aMask, (char*)base_path.c_str(), "data.*" );
	std::string mask (aMask);
	long find_file_handle = _findfirst (mask.c_str (), &find_data);
	FileDataVector pipe_managers;
	FileData fd;
	char file_name[ MAX_PATH ];
	for (long i = find_file_handle; i != -1; i = _findnext (find_file_handle, &find_data)) {
		if (strcmp (find_data.name, ".") == 0
				|| strcmp (find_data.name, "..") == 0
				|| stricmp (find_data.name, "data.lic") == 0
				|| ( find_data.attrib & _A_SUBDIR )
			) {
			continue;
		}
		MakePath (file_name, (char*)base_path.c_str (), find_data.name);
		GslDataPipeServer::Stream* str = new GslDataPipeServer::FileStream (file_name);
		if (false == str->is_open ()) {
			for (FileDataVector::size_type j = 0; j < pipe_managers.size (); j++) {
				pipe_managers[j].second->close_pipe ();
			}
			delete str;
			printf ("::get_file_set: can't open %s\n", file_name);
			return NULL;
		}
		get_file_set_size += FileSize (file_name);
		GslDataPipeServer::PipeManager_i* manager = new GslDataPipeServer::PipeManager_i (str, true);
		PortableServer::ObjectId_var oid = GCM::get_cached_root_poa()->activate_object (manager);
		CORBA::Object_var obj = GCM::get_cached_root_poa()->id_to_reference (oid);
		fd.second = GslDataPipe::PipeManager::_narrow (obj);
		fd.first = find_data.name;
		pipe_managers.push_back (fd);		
	}
	if (-1 != find_file_handle) {
		_findclose (find_file_handle);
	}
	if (0 == pipe_managers.size ()) {
		printf ("::get_file_set: no files in %s\n", base_path.c_str ());
		return NULL;
	}
	//
	static const char* DEALER_INF_FILE = "dealer.inf";
	MakePath (file_name, (char*)base_path.c_str (), (char*)DEALER_INF_FILE);
	GslDataPipeServer::Stream* str = new GslDataPipeServer::FileStream (file_name);
	if (true == str->is_open ()) {
		GslDataPipeServer::PipeManager_i* manager = new GslDataPipeServer::PipeManager_i (str, true);
		PortableServer::ObjectId_var oid = GCM::get_cached_root_poa()->activate_object (manager);
		CORBA::Object_var obj = GCM::get_cached_root_poa()->id_to_reference (oid);
		fd.second = GslDataPipe::PipeManager::_narrow (obj);
		fd.first = DEALER_INF_FILE;
		pipe_managers.push_back (fd);	
	} else {
		delete str;
	}
	//
	GslDataPipe::FileReadingSet_var file_set = new GslDataPipe::FileReadingSet ();
	file_set->length (pipe_managers.size ());
	for (FileDataVector::size_type j = 0; j < pipe_managers.size (); j++) {
		file_set[j].m_name = pipe_managers[j].first.c_str ();
		file_set[j].m_data_reading = pipe_managers[j].second->get_reading_interface ();
		file_set[j].m_data_reading->add_reference ();
	}
	get_file_set_size /= 1024;
	return file_set._retn ();
}
#endif

volatile	int	bu_remote_update_result;
volatile	int	bu_update_complete_result;
volatile	bool	startWorking;
volatile	bool	endWorking;
CString		bu_update_complete_str;
#ifdef	_GCD_CLIENT
CWaitServer*		waitDialog;
CUpdateComplete*	wait2Dialog;
CWaitUsers*		wait3Dialog;
UpdateRunner*		localpUR;
GslDataPipe::FileReadingSet_var	file_set;
CString		newPilotBaseName;
CTestBreeder32Dlg *pBreederDlg;

DWORD	bu_sync_update_start( void* params )
{
	startWorking = true;
	endWorking = false;
	newPilotBaseName = localpUR->bu->sync_update_start();

	Sleep (2000);
	endWorking = true;
	wait3Dialog->EndDialog (IDOK);
	//PostMessage( wait3Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	return 0;
}

DWORD	bu_update_complete (void* params) {
	startWorking = true;
	endWorking = false;
	bu_update_complete_result = 0;

	try {
		localpUR->bu->update_complete ();

	} catch (GCD::InvalidDatastoreKey&) {
		bu_update_complete_result = 1;
	} catch (CORBA::TRANSIENT&) {
		bu_update_complete_result = 2;
	} catch (CORBA::Exception& ex) {
		bu_update_complete_result = 3;

		bu_update_complete_str.LoadString (IDS_INSTALL_BASE_EXEPTION);
		bu_update_complete_str += "\nCORBA::Exception ";
		bu_update_complete_str += ex._rep_id ();
	} catch (...) {
		bu_update_complete_result = 4;
	}

	Sleep (2000);
	endWorking = true;
	wait2Dialog->EndDialog (IDOK);
	//PostMessage( wait2Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	return bu_update_complete_result;
}

DWORD	bu_remote_update( void* params )
{
	startWorking = true;
	ACE_OS::sleep(1);
	bu_remote_update_result = 0;
	for (;;) {
		try {
			int updateType = *(int*)params;
			if ( updateType == 0 ) {
				localpUR->bu->remote_update(file_set);
			} else {
				localpUR->bu->remote_sync_update(file_set);
			}
		}
		catch(GCD::AccessDenied) {
			bu_remote_update_result = 1;
		}
		catch(GCD::CopyProcessFailed) {
			bu_remote_update_result = 2;
		}
		catch(GCD::NotEnoughRoom) {
			bu_remote_update_result = 3;
		}
		catch(...) {
			bu_remote_update_result = 4;
		}

		if (0 == bu_remote_update_result)
			break;

		waitDialog->ShowWindow (SW_HIDE);
		if (pBreederDlg->pGSScreen->ShowQuestionYesOrNo("Возможно, нет необходимого свободного места в каталоге data\n\nПродолжить установку?"))
			break;
		waitDialog->ShowWindow (SW_SHOW);
	}


	Sleep (2000);
	waitDialog->EndDialog (IDOK);
	//PostMessage( waitDialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	return bu_remote_update_result;
}
#endif

void CTestBreeder32Dlg::Bind(CString *pTXT)
{
	if(install_status == 2)
		install_status= 0;

	HideControl(&m_CIBsTree);
	HideControl(&m_BttnBrws);
	//эти три строчки - костыль. (http://mdp.garant.ru/pages/viewpage.action?pageId=112722346)
	//при переключении базы кто-то или (вероятнее) logout_current кидает exception, и до таких же
	//трех строк не доходит. Костыль работает, единственный побочный эффект - f1datasetup.run остается висеть в памяти
	//Огромная просьба до выяснения истинных причин ошибки костыль не убирать
	pGSScreen->OtherShowMessage(Msg_51);
	m_BttnExit.SetWindowText(Msg_80);
	bOnRestore= FALSE;

#if defined (_GCD_CLIENT) && !defined (RD_AS_ETALON)
	HideControl(&m_BttnNext);

	int lenAlias = strlen(pCurrCIBs->Alias);
	CString orgName( pCurrCIBs->Alias, lenAlias >= SIZE_PROT_REGFIELD ? SIZE_PROT_REGFIELD-1 : lenAlias);

	//Recoding(cd_dos,cd_win,aUserName);
	char aUserFile[ MAX_PATH ];
	strcpy( aUserFile, pPilotBaseName->GetBuffer(0) );
/*
	ForceExt( aUserFile, "txt" );
	FILE *aFile = fopen( aUserFile, "w+t" );
	if ( aFile != NULL ) {
		fprintf( aFile, orgName.GetBuffer(0) );
		fclose( aFile );
	}
*/

	CString regNumber = "RegNum";
	CString tmpNum = returnRD_Blngs(pCurrCIBs->Alias);
	int ccc = tmpNum.Find('~');
	if ( ccc != -1) {
		regNumber = tmpNum.Mid( ccc + 1 );
		ccc = regNumber.Find( ',' );
		if ( ccc != -1 )
			regNumber = regNumber.Left( ccc );
	}

	char aBasesOrg[ MAX_PATH ];
	strcpy( aBasesOrg, pPilotBaseName->GetBuffer(0) );
	ForceExt( aBasesOrg, "ORG" );
	strcpy( pathBasesOrigin, aBasesOrg );
	{
		CString user_name (orgName);
		user_name += "~~";
		user_name += realPass;
		user_name += "|";
		char s_date [32];
		CTime theTime = CTime::GetCurrentTime();
		sprintf (s_date, "%ld/%ld/%ld", theTime.GetDay(), theTime.GetMonth(), theTime.GetYear());
		user_name += s_date;
		WriteUserInfo( user_name.GetBuffer(0), regNumber.GetBuffer(0) );
	}

	//надо потом записать признаки некоммерческого и прочего использования
	PROTINFO protInfo;
	ForceExt( aUserFile, "NDT" );
	if ( strrchr( aUserFile, '\\' )) StrUpr( strrchr( aUserFile, '\\' ) );
	GetProtInfo( &protInfo, aUserFile, m_VerType );
	WriteProtInfo( &protInfo );

	char drive  [_MAX_DRIVE];
	char dir    [_MAX_DIR];
	char ext    [_MAX_EXT];
	char nameNDT[_MAX_FNAME];
	_splitpath(pPilotBaseName->GetBuffer(0), drive, dir, nameNDT, ext);
	StrUpr( nameNDT );
	pCIB_Info = (COMPLECTINFO*)malloc( sizeof( COMPLECTINFO ) + 2*SIZE_COMPLECT_NAME + 16 );
	strcpy( pCIB_Info->ComplectName, nameNDT );
	pCIB_Info -> StructID    = PROT_COMPL_STRUCT_ID;
	pCIB_Info->ComplectSet   = 1;
	pCIB_Info->ComplectCount = 2;
	pCIB_Info->ComplectWeight= 0;
	memcpy(pCIB_Info -> Bases[0], "0", 2);

	if (isTrial) {
		pCIB_Info->ComplectWeight |= 0x0004U;

		const long c_seconds_per_day = 24l*60l*60l;

		long time_init = (long)(ACE_OS::time () & 0x7fffffff);
		long time_fini = time_init + (static_cast <long> (isTrial))*c_seconds_per_day;

		try {
			if (!pUR->um->set_trial_period (time_init, time_fini)) {
				CString string = "Произошел системный сбой при установке срока действия ознакомительной версии, свяжитесь с разработчиками.";
				MessageBox (string, "Установка", MB_OK);

				EndDialog(IDCANCEL);
				return;
			}
		} catch (CORBA::TRANSIENT&) {
			CString string;
			string.LoadString (IDS_TRANSIENT);
			MessageBox (string, "Установка", MB_OK);

			EndDialog (IDCANCEL);
			return;
		} catch (CORBA::Exception& ex) {
			CString string = CString ("Произошел системный сбой при установке срока действия ознакомительной версии, свяжитесь с разработчиками.\n(CORBA::Исключение ")+ex._rep_id ()+")";
			MessageBox (string, "Установка", MB_OK);

			EndDialog(IDCANCEL);
			return;
		} catch (...) {
			CString string = "Произошел системный сбой при установке срока действия ознакомительной версии, свяжитесь с разработчиками.";
			MessageBox (string, "Установка", MB_OK);

			EndDialog(IDCANCEL);
			return;
		}
	}

	if (isFree) {
		pCIB_Info->ComplectWeight |= 0x8000U;
	}
	WriteComplectInfo( pCIB_Info );

	char srcFile[ MAX_PATH ], dstFile[ MAX_PATH ];
	MakePath( srcFile, distrib_path, DEALER_FILE_NAME );
	strcpy( dstFile, pPilotBaseName->GetBuffer(0) );
	if ( strrchr( dstFile, '\\' )) strcpy( strrchr( dstFile, '\\' ) + 1, DEALER_FILE_NAME );
	CopyFile( srcFile, dstFile, 0 );
	DWORD dwAttrs = GetFileAttributes( dstFile ); 
        if ( dwAttrs & FILE_ATTRIBUTE_READONLY )
            SetFileAttributes( dstFile, dwAttrs & !FILE_ATTRIBUTE_READONLY ); 

	localpUR = pUR;
	if (remoteInstall) {
		CSyncUpdate syncUpdate;
		syncUpdate.pUR = pUR;
		ShowWindow(SW_HIDE);
		syncUpdate.bSync = 1;
		if (!pUR->bu->is_base_exist() || syncUpdate.DoModal() == IDOK ) {
			((CTestBreeder32App*)AfxGetApp())->Log ("Информация: Данные будут скопированы на сервер ");
			u_int64_t free_space = 0;

			if (syncUpdate.bSync) {
				((CTestBreeder32App*)AfxGetApp())->Log ("c отключением пользователей\n");
				free_space = pUR->bu->get_free_space_for_sync ();
			} else {
				((CTestBreeder32App*)AfxGetApp())->Log ("без отключения пользователей\n");
				free_space = pUR->bu->get_free_space_for_async ();
			}

			GslDataPipe::FileReadingSet_var real_file_set = get_file_set (remotePath);
			file_set = new GslDataPipe::FileReadingSet (real_file_set.in ());

			if (free_space < get_file_set_size && pGSScreen->ShowQuestionYesOrNo ("Возможно, на сервере недостаточно свободного места для копирования данных.\n\nПродолжить установку?")) {
				bu_remote_update_result = 3;
			} else {
				waitDialog = new CWaitServer();
				startWorking = false;

				ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();

				pBreederDlg = this;
				if (inst->spawn ((ACE_THR_FUNC)bu_remote_update, &syncUpdate.bSync, THR_DETACHED) == -1) {
					((CTestBreeder32App*)AfxGetApp())->ErrorLog ("Ошибка при создании потока копирования информационного банка");
					CString err;
					err.LoadString (IDS_BASE_COPY_ERROR);
					MessageBox (err.GetBuffer ());
				} else {
					while (!startWorking) ACE_OS::sleep (1);
					waitDialog->DoModal ();
				}

				delete waitDialog;
			}

			CString err;

			if ( bu_remote_update_result == 0 ) {
				((CTestBreeder32App*)AfxGetApp())->global_success = true;
			} else if (bu_remote_update_result == 1) {
				((CTestBreeder32App*)AfxGetApp())->ErrorLog ("Access Denied");
				err = "remote_update (): access denied";
			} else if (bu_remote_update_result == 2) {
				((CTestBreeder32App*)AfxGetApp())->ErrorLog ("Ошибка при копировании данных");
				err.LoadString (IDS_COPY_DATA_ERROR);
			} else if (bu_remote_update_result == 3) {
				((CTestBreeder32App*)AfxGetApp())->ErrorLog ("Недостаточно места на диске для копирования комплекта");
				err.LoadString (IDS_ENOUGH_ROOM);
			} else if (bu_remote_update_result == 4 || bu_remote_update_result != 0) {
				((CTestBreeder32App*)AfxGetApp())->ErrorLog ("remote_update(): неизвестное исключение");
				err = "remote_update (): unknown exception";
			}

			if (!err.IsEmpty ()) {
				install_status = 3;
				send_internet_result ();

				CString title;
				title.LoadString (IDS_SETUP_DATA);
				MessageBox (err.GetBuffer (), title.GetBuffer (), MB_OK);
				EndDialog (IDCANCEL);
				return;
			}

			for (CORBA::ULong i = 0; i < real_file_set->length (); i++) {
				char aFileName[ MAX_PATH ];
				MakePath( aFileName, remotePath, (char*)real_file_set[i].m_name.in() );
				DeleteFile( aFileName );
			}

			file_set = 0;
			((CTestBreeder32App*)AfxGetApp())->TimeLog ("Информация: Данные скопированы на сервер\n");

			pUR->logout_current();
			ShowWindow(SW_SHOW);
		} else {
			ShowWindow (SW_SHOW);
			EndDialog (IDCANCEL);
			return;
		}
	} else {
		ShowWindow (SW_HIDE);
		((CTestBreeder32App*)AfxGetApp())->TimeLog ("Начали ожидание переключения на новую базу\n");

		wait2Dialog = new CUpdateComplete ();
		startWorking = false;
		endWorking = false;

		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		bu_update_complete_result = 0;

		if (inst->spawn ((ACE_THR_FUNC)bu_update_complete, NULL, THR_DETACHED) == -1) {
			((CTestBreeder32App*)AfxGetApp())->Log ("Информация: вызываем update_complete\n");
			try {
				pUR->bu->update_complete ();
				((CTestBreeder32App*)AfxGetApp())->global_success = true;
			} catch (GCD::InvalidDatastoreKey&) {
				bu_update_complete_result = 1;
			} catch (CORBA::TRANSIENT&) {
				bu_update_complete_result = 2;
			} catch (CORBA::Exception& ex) {
				bu_update_complete_result = 3;
				bu_update_complete_str.LoadString (IDS_INSTALL_BASE_EXEPTION);
				bu_update_complete_str += "\nCORBA::Exception ";
				bu_update_complete_str += ex._rep_id ();
			} catch (...) {
				bu_update_complete_result = 4;
			}
		} else {
			while (!startWorking) ACE_OS::sleep (1);
			if (!endWorking) wait2Dialog->DoModal ();
		}

		delete wait2Dialog;

		ShowWindow (SW_SHOW);
		((CTestBreeder32App*)AfxGetApp())->TimeLog ("Завершили ожидание переключения на новую базу\n");
		CString err;

		switch (bu_update_complete_result) {
			case 0:
				((CTestBreeder32App*)AfxGetApp())->global_success = true;
				break;
			case 1:
				err.LoadString (IDS_MSG_94);
				((CTestBreeder32App*)AfxGetApp())->ErrorLog (err.GetBuffer (0));
				break;
			case 2:
				err.LoadString (IDS_TRANSIENT);
				((CTestBreeder32App*)AfxGetApp())->ErrorLog (err.GetBuffer (0));
				break;
			case 3:
				err = bu_update_complete_str;
				((CTestBreeder32App*)AfxGetApp())->ErrorLog (bu_update_complete_str.GetBuffer (0));
				break;
			case 4:
				err.LoadString (IDS_INSTALL_BASE_EXEPTION);
				((CTestBreeder32App*)AfxGetApp())->ErrorLog (err.GetBuffer (0));
				break;
		}

		if (!err.IsEmpty ()) {
			install_status = 3;
			send_internet_result ();

			CString title;
			title.LoadString (IDS_SETUP_DATA);
			MessageBox (err.GetBuffer (), title.GetBuffer (), MB_OK);
			EndDialog (IDCANCEL);
			return;
		}

		pUR->logout_current ();
	}

	char* apath = strdup(m_currSourcePath);
	char* slashpos = strrchr(apath, '\\' );
	if (slashpos) {
		if ( !stricmp (slashpos,"\\DATA")) {
			*slashpos = '\0';
		}
	}
	CString m_towrite (apath);
	Core::ParamManagerFactory::get ().set_string( "-DSDataPath", "\"" + m_towrite + "\"" );
	Core::ParamManagerFactory::get ().set_long (regInstallAsPacked, -1);
	Core::ParamManagerFactory::get ().set_long (regInstallWithDisconnect, -1);	
	pUR->function_mng->set_enable_installation_status_saving ((bool)LoggingStatus);

	free (apath);
#else
#if	!defined(PILOT) && !defined(_GCD_CLIENT)
	pCIB_Info -> StructID       = PROT_COMPL_STRUCT_ID;
	pCIB_Info -> ComplectCount  = 0;
	pCIB_Info -> ComplectSet    = TRUE;
	if(old_CIB_is_install == 1)
		pCIB_Info -> ComplectWeight |= m_VerType;
	else
		pCIB_Info -> ComplectWeight = m_VerType;

	char *pFnd, *pName;
	if(InPharmFiles.GetSize()){
		pFnd= strrchr(old_install_path, '\\');
		strcpy(pFnd+1, (LPCTSTR)InPharmFiles.GetAt(0));
		pFnd= strrchr(old_install_path, '.');
		strcpy(pFnd, "*:");
	}
	pFnd= strrchr(old_install_path, '*');
	*pFnd= '\0';
	pName= strrchr(old_install_path, '\\')+1;
	memcpy( pCIB_Info -> ComplectName,  pName, (int)pFnd - (int)pName + 1);
	*pFnd= '*';

	int *pCurrentWeight= ppHDDs[m_baseIndx].currentWeight, ii= 0;
	sel_Belngs += sizeof(short);
	while(*pCurrentWeight){
		if(*pCurrentWeight > 0){
			pFnd= strchr(sel_Belngs, ' ');
			if(pFnd != NULL){
				*pFnd= '\0';
				memcpy(pCIB_Info -> Bases[ii++], sel_Belngs,
							(int)pFnd- (int)sel_Belngs + 1);
				sel_Belngs= pFnd + 1;
			}else
				strcpy(pCIB_Info -> Bases[ii++], sel_Belngs);
			pCIB_Info -> ComplectCount += 2;
		}
		pCurrentWeight += 2;
	}
	if(pCIB_Info -> ComplectCount > (MAXIMUM_COUNT_SEGS*2)){
		pCIB_Info -> ComplectCount= 2;
		memcpy(pCIB_Info -> Bases[0], "0", 2);
	}

	rrr= CString("") + m_currSourcePath;
	rrr.MakeUpper();
	char *rrrFnd= strrchr((LPCTSTR)rrr, '\\');
	if(rrrFnd != NULL && !strcmp(rrrFnd, "\\DATA")){
		rrr= m_currSourcePath.Left((int)rrrFnd-(int)(LPCTSTR)rrr);
	}else
		rrr= m_currSourcePath;

	::WritePrivateProfileString("Setup", "Source", (LPCTSTR)rrr, g4xPathINI );

#if	!defined(RD_AS_ETALON)
	rrr.Format("%d", m_DefaultRD_Hash);
	::WritePrivateProfileString("Setup", "RD_Hash_LW", (LPCTSTR)rrr, g4xPathINI );
	m_ThreadID= m_DefaultRD_Hash;
	HashDWORD(&m_ThreadID);
	rrr.Format("%d", m_ThreadID);
	::WritePrivateProfileString("Setup", "RD_Hash_HI", (LPCTSTR)rrr, g4xPathINI );
	if(isFree ){
		pCIB_Info->ComplectWeight |= 0x8000;
	} else
#endif

	if(isTrial){
		pCIB_Info->ComplectWeight |= 4;
		long	aStart = time( NULL );
		long	aEnd = aStart + (long)isTrial * (3600l*24l);
		char ttt[64];

		char	aStartEnd[ 32 ];
		sprintf( aStartEnd, "!%ld,%ld!", aStart, aEnd );
		unsigned long crc = adler32( 0l, NULL, 0 );
		crc = adler32( crc, (const unsigned char *)aStartEnd, strlen( aStartEnd ));

		::WritePrivateProfileString("Setup", "Start", itoa(aStart, ttt, 10), g4xPathINI );
		::WritePrivateProfileString("Setup", "End", itoa(aEnd, ttt, 10), g4xPathINI );
		::WritePrivateProfileString("Setup", "Crc", itoa(crc, ttt, 10), g4xPathINI );
	}

	WriteComplectInfo( pCIB_Info );
	PROTINFO *lpProtInfo= (PROTINFO *) malloc( sizeof( PROTINFO ));
	GM_PROTINFO *lpMProtInfo= (GM_PROTINFO *) malloc( sizeof( PROTINFO ));

	pName--;
	if(!InPharmFiles.GetSize()){
		pFnd= strrchr(old_install_path, '*');
		memcpy(pFnd, ".NDT", 5);
	}else{
		strcpy(strrchr(old_install_path, '\\')+1, (LPCTSTR)InPharmFiles.GetAt(0));

		strcpy(strrchr(pathBasesOrigin, '\\'), "\\INPHARM.ORG");
		GM_GetProtInfo( lpMProtInfo, old_install_path, m_VerType );
		GM_WriteProtInfo( lpMProtInfo );
	  #ifndef	RD_AS_ETALON
		int lenAlias = strlen(pCurrCIBs->Alias);
		CString tmpOrg(pCurrCIBs->Alias, lenAlias >= SIZE_PROT_REGFIELD ? SIZE_PROT_REGFIELD-1 : lenAlias);
		strcpy(pRegOrg, (LPCTSTR)tmpOrg);
		CString tmpNum= returnRD_Blngs(pCurrCIBs->Alias);
		int ccc= tmpNum.Find('~');
		if(ccc != -1){
			strcpy(pRegNum, (LPCTSTR)tmpNum.Mid(ccc+1));
		}

		::WriteUserInfo( pRegOrg, pRegNum );
	  #endif
		/////
		strcpy(strrchr(old_install_path, '\\')+1, (LPCTSTR)InPharmFiles.GetAt(1));
		GM_GetProtInfo( lpMProtInfo, old_install_path, m_VerType );
		GM_WriteProtInfo( lpMProtInfo );
		strcpy(strrchr(pathBasesOrigin, '\\'), strrchr(g4xPathORG, '\\'));
	}

	GetProtInfo( lpProtInfo, old_install_path, m_VerType );
	if(!InPharmFiles.GetSize()){
		char *pFnd1= strrchr(old_install_path, '.');
		memcpy(pFnd1, ".LCK", 5);
		unlink(old_install_path);
		memcpy(pFnd1, ".NDT", 5);
	}
	*pName= '\0';
	pFnd= strrchr(old_install_path, '\\');
	*pName= '\\';

	::WritePrivateProfileString("Environment", "Data", pFnd, g4xPathINI );
	::WritePrivateProfileString(NULL, NULL, NULL, g4xPathINI );
	lpProtInfo->HardwareID= m_HardwareID;
	::WriteProtInfo( lpProtInfo );
#ifndef	RD_AS_ETALON
	if(!InPharmFiles.GetSize()){
		int lenAlias = strlen(pCurrCIBs->Alias);
		CString tmpOrg(pCurrCIBs->Alias,
			lenAlias >= SIZE_PROT_REGFIELD ? SIZE_PROT_REGFIELD-1 : lenAlias);
		Recoding(cd_win, cd_dos, strcpy(pRegOrg, (LPCTSTR)tmpOrg) );
		CString tmpNum= returnRD_Blngs(pCurrCIBs->Alias);
		int ccc= tmpNum.Find('~');
		if(ccc != -1){
			strcpy(pRegNum, (LPCTSTR)tmpNum.Mid(ccc+1));
		}

		::WriteUserInfo( pRegOrg, pRegNum );
	}
#endif
	if(InPharmFiles.GetSize()){
		lpMProtInfo->HardwareID= m_HardwareID;
		pFnd= strrchr(pathBasesOrigin, '\\');
		strcpy(pFnd, "\\INPHARM.ORG");
		GM_WriteProtInfo( lpMProtInfo );
		strcpy(pFnd, strrchr(g4xPathORG, '\\'));
	}
	free(pCIB_Info);
	free(lpProtInfo);
	free(lpMProtInfo);
#endif
#endif
	bOnRestore= FALSE;

	KillTimer(m_uTimerID);
	m_Msg0.SetWindowText("");

	qqq.Format(Frmt2, (CorrectMyGetDiskFreeSpace("\\")/(1024*1024)));
	m_Msg2.SetWindowText(qqq);

	qqq.Format(Frmt52, timeOn10sec/60, timeOn10sec%60);
	m_Msg1.SetWindowText(qqq);

	pGSScreen->OtherShowMessage(Msg_51);
	m_BttnExit.SetWindowText(Msg_80);
	BeepOk();
	m_CIBsTree.EnableWindow(FALSE);

	m_BttnNext.EnableWindow();
	GotoDlgCtrl(&m_BttnNext);
	NextDlgCtrl();
	m_BttnNext.EnableWindow(FALSE);
	m_BttnBrws.EnableWindow(FALSE);

	send_internet_result ();
}

void CTestBreeder32Dlg::SetItemTextAsUnknwn(HTREEITEM hTreeItem, char* pName)
{
	if(pName == NULL){
		m_BttnNext.EnableWindow(FALSE);
		pName= (char*)(LPCTSTR)Msg_60a;
	}else
		m_BttnNext.EnableWindow();

	CString tmp;
	tmp.Format(Frmt50, pName);

	m_CIBsTree.SetItemText(hTreeItem, tmp);

	tmp.Format(Frmt0, pName);
	m_Msg0.SetWindowText(tmp);
}

int CTestBreeder32Dlg::IsDistribHASP_Ok(PDWORD pdwMediaID)
{
#ifdef TEST_HASP
	if(DistribHASP_Ok == 1 && !(*((CTestBreeder32App*)AfxGetApp())->imp_HaspGetMediaId)(pdwMediaID))
		return FALSE;
#else
#ifndef RD_AS_ETALON
	if(DistribHASP_Ok == 1)
		return FALSE;
	if(*returnVIP_Flag(pCurrCIBs->Alias) == PL_HASP_FLAG
		&& !((*((CTestBreeder32App*)AfxGetApp())->imp_HaspGetMediaId)(pdwMediaID))){
		WORD ret;
		char *LoginReplicator1 = strdup("TGCENTER");
		LPPL_IMPORT_COMPLECT_DATA pList= ppHDDs[m_baseIndx].pList;
		TestedHaspOnHDD((char*)bff, pdwMediaID, &ret, m_baseIndx, LoginReplicator1, &pList);
		free(LoginReplicator1);
		if(!ret){
			DistribHASP_Ok= 1;
			return FALSE;
		}
	}
#endif
#endif
	return TRUE;
}

static B_TSTPASS tstSynchro;
static int LockSynchro= 0, checkOther= 1, closeFistHandle= 1;

int CTestBreeder32Dlg::ShowQuestionBrowse()
{
	char	msgBrs[1024]
			, frmt_msgBrs[]= "%s\n\nВыбрать другой каталог с исходным дистрибутивом для продолжения установки?\n\n\n«Нет» %s"
			, frmt_msgBrs_e[]= "%s\n\nSelect another directory with the source distribution to continue the installation?\n\n\n<No> %s"
			, defBrs[]= "Установка приостановлена."
			, defBrs_e[]= "Installation paused.";

	if(PassEntered){
		notTruncTarget= 1;
		if(gProcMssg){
			sprintf(msgBrs,get_app ()->get_rc_lang () == rl_Eng ? frmt_msgBrs_e : frmt_msgBrs,curr_msgBrs, get_app ()->get_rc_lang () == rl_Eng ? "exit the program." : "выход из программы.");
		}else{
			curr_msgBrs= get_app ()->get_rc_lang () == rl_Eng ? defBrs_e : defBrs;
			sprintf(msgBrs, get_app ()->get_rc_lang () == rl_Eng ? frmt_msgBrs_e : frmt_msgBrs, curr_msgBrs, get_app ()->get_rc_lang () == rl_Eng ? "to continue the installation from the current directory." : "для продолжения установки из текущего каталога.");
		}
	}
	return pGSScreen->ShowQuestionYesOrNo(msgBrs);
}

void CTestBreeder32Dlg::OnBrowse() 
{
	if(hTickThread != NULL) ::SuspendThread(hTickThread);
	if(hInstllThread != NULL){
		if(rpRd){
			if(!waitKill) { waitKill= 1; waitKillAsBrowse= 1; }
			return;
		}
		waitKill= 1;
	}

	bool b_asked = false;
	if (PassEntered && !gBrwsAfterReadError) {
		b_asked = true;
		if (ShowQuestionBrowse()) {
			if(hTickThread != NULL) ::ResumeThread(hTickThread);
			if(hInstllThread != NULL) waitKill= 0;
			else if(pGSScreen->rdStats == -1){
				// прерываем работу когда ответили отказом				//
				// предоставить следующий файл дистрибутива для чтения	//
				TerminateBreederThread();
			}
			return ;
		}
	}

	if(PassEntered && hInstllThread != NULL){
		waitBrowse= 0;
		waitKill= 1;
		Sleep(1000);
		waitKill= 0;
		gCopyKill= 1;
		while(waitCopy) Sleep(100); waitCopy= 1;
		::TerminateThread(hInstllThread, 0);
		gCopyKill= 0;
		allFHndls.clear();
		hInstllThread= NULL;
		checkOther= 1;
		while(gbkp_files_count--) free(gbkp_files[gbkp_files_count].pFullName);
		gbkp_files_count= 0;
		while(pcPreInst2Gfiles--) free(ppPreInst2Gfiles[pcPreInst2Gfiles]);
		pcPreInst2Gfiles= 0;
	}
	if (!UpdateData())
		return;

	do{
		int eXiT= 0;
		if(!PassEntered || gBrwsAfterReadError || b_asked){
			gBrwsAfterReadError= 0;
			char SelectedPath[MAX_PATH+MAX_PATH];
			LPITEMIDLIST	aBrowse= 0;
			if(!gBrwsAfterReadErrorNot)
				aBrowse= PidlBrowse( m_hWnd, CSIDL_DRIVES, SelectedPath, IDS_SELECT_FOLDER );
			else{
				eXiT= 1;
			}
			if(PassEntered && !aBrowse){
				BeepOk();
			}else if ( aBrowse && SHGetPathFromIDList( aBrowse, SelectedPath )){
				char *_path = strdup (SelectedPath);
				*secondPilotDistribPath = CString(SelectedPath);
				allFHndls.clear();
				EndDialog(selectDefPath);
				break;
			}else{
				NextDlgCtrl();
				NextDlgCtrl();
				NextDlgCtrl();
				gProcMssg= 0;
				break;
			}
		}else{
			eXiT= 1;
		}
		if(eXiT){
			if(PassEntered){
				if(gProcMssg){
					TerminateBreederThread();
				}
				strcpy(SelectedPath,(LPCTSTR)(*pPilotDistribPath));
				*secondPilotDistribPath = CString(SelectedPath);
				EndDialog(selectDefPath);
			}
			gProcMssg= 0;
			break;
		}
	}while(1);
}

char *nameZ= 0,  msgTsts[]= "Предыдущая установка не была завершена. Продолжить с места остановки?", msgTsts_e[]= "A previous installation was not completed. Continue from where it stopped?" ;
int removeOtherThis= 0, MsgYesUseCache= 1;

void CTestBreeder32Dlg::OnNext() 
{
	if (!UpdateData())
		return;

	m_BttnBrws.EnableWindow( FALSE );
	HideControl(&m_BttnBrws);
	m_Static_73.EnableWindow( FALSE );
	HideControl(&m_Static_73);
	m_Msg70.EnableWindow( FALSE );
	HideControl(&m_Msg70);

	int *pCurrentWeight;
#ifndef RD_AS_ETALON
	LPPL_IMPORT_COMPLECT_DATA pList= ppHDDs[m_baseIndx].pList;
	if(pList == NULL){
		if(((nRetCode= pl_Get_InstalledCIBsFromInstalledDisk((char*)bff,
				(char*)(LPCTSTR)m_AnswerStr, ppHDDs[m_baseIndx].pHDD->m_pUIDBFileName,
				&ppHDDs[m_baseIndx].pList))
					&&
				nRetCode != -116)
				||
			( (pList= ppHDDs[m_baseIndx].pList) == NULL && nRetCode != -116)){
		}else if(!nRetCode){
			BOOL bz2;
			int indx= (m_baseIndx*MAX_HDD_COUNT)+1;
			HTREEITEM hRoot= m_CIBsTree.GetSelectedItem();
			if(pList->pCIBs->next){
				m_CIBsTree.SetItemImage(hRoot,4,4);
			}else
				m_CIBsTree.SetItemImage(hRoot,1,1);
			MakeTreeNodes(	pList, &hRoot, &indx, NULL, 0,
							&bz2);
			if(old_CIB_is_install != 1){
				m_CIBsTree.EnableWindow();
			}
			m_AnswerCount= 0;
			m_CIBsTree.SelectItem(m_SpacePrnt);
		}else{
			m_AnswerCount++;
			if(m_AnswerCount >= 3){
				BeepWarning();
				MessageBox(Msg_P03, Msg_76, MB_OK|MB_ICONERROR);
				EndDialog(-1);
				return;
			}else{
				BeepWarning();
				MessageBox(Msg_P03, Msg_86, MB_OK|MB_ICONERROR);
				return;
			}
		}
		return;
	} else {
		((CTestBreeder32App*)AfxGetApp())->Log ("Для установки выбран ");
		((CTestBreeder32App*)AfxGetApp())->Log (NameCC.GetBuffer (0));
		((CTestBreeder32App*)AfxGetApp())->Log (", ");
		((CTestBreeder32App*)AfxGetApp())->Log (NameCIB.GetBuffer (0));
		((CTestBreeder32App*)AfxGetApp())->Log ("\n");

		long lNet= *returnServerType_CIB(pCurrCIBs->Alias);
		//int order_mask = (0x7fffffff & ((returnDelivery_Type(pCurrCIBs->Alias))[5]));
		bool b_clientserver = (lNet == 2);
		bool b_fileserver = (lNet == 4);
		bool b_desktop = (lNet == 1);
		//GblPilot::AssemblyType assembly_type = pUR->function_mng->assembly_type ();
		GblPilot::VersionType version_type = pUR->function_mng->get_product_info ();

		//if ((assembly_type == GblPilot::AT_NET /*Клиент-Сервер*/ && !b_clientserver) || (assembly_type == GblPilot::AT_LOCAL && !(b_fileserver || b_desktop))){
#ifdef	_DEBUG
		if (false) {
#else
		if ((version_type == GblPilot::VT_CLIENTSERVER && !b_clientserver) || (version_type == GblPilot:: VT_DESKTOP && !b_desktop) || (version_type == GblPilot::VT_FILESERVER && !b_fileserver)){
#endif
			CString error;
			error.LoadString (IDS_FZ_NET_ERROR);
			MessageBox(error, 0, MB_OK|MB_ICONERROR);

			m_BttnBrws.EnableWindow (true);
			ShowControl(&m_BttnBrws);
			m_Static_73.EnableWindow (true);
			ShowControl(&m_Static_73);
			m_Msg70.EnableWindow (true);
			ShowControl (&m_Msg70);

			return ;
		}
 		pInstalledNet= 0;
 		int iBadNet= 0;
 		CString OtherMsg;
 		switch(lNet){
 		case 1:
 			pInstalledNet= (char*)(LPCTSTR)Msg_P06;
 			break;
 		case 4:
 			pInstalledNet= (char*)(LPCTSTR)Msg_P07;
 			break;
 		case 2:
 			pInstalledNet= (char*)(LPCTSTR)Msg_P08;
 			break;
 		default:
 			iBadNet= 1;
 			/*do{
 				switch((lNet & iBadNet)){
 					case 1:
 						OtherMsg += Msg_P06;
 						OtherMsg += '/';
 						break;
 					case 2:
 						OtherMsg += Msg_P07;
 						OtherMsg += '/';
 						break;
 					case 4:
 						OtherMsg += Msg_P08;
 						OtherMsg += '/';
 						break;
 					default:
 						break;
 				}
 			}while((iBadNet <<= 1) && iBadNet < 0x70);
 			OtherMsg += "null";*/
 			OtherMsg= "неизвестная";
 			pInstalledNet= (char*)(LPCTSTR)OtherMsg;
 			break;
 		}
#if defined (_GCD_CLIENT) || defined (PILOT)
	pHDD->m_max_profiles= 2000;
	pHDD->m_max_num= 1;
	if (b_desktop){
		m_VerType = VERTYPE_LOCAL;
		pHDD->m_max_profiles= 32;
	}else if (b_fileserver){
		m_VerType = VERTYPE_NET_ONEUSER;
	}else if (b_clientserver){
		m_VerType = VERTYPE_NET;
		pHDD->m_max_num= 2000;
	}else{
		m_VerType = VERTYPE_NET_ONEUSER;
	}

		if (false){
#else
 		if( iBadNet ||	(m_VerType == 1 && lNet != 1)||
 						(m_VerType == 2 && lNet != 4)||
 						(m_VerType == 3 && lNet != 2)	 ) {
#endif
 			BeepWarning();
 			switch(m_VerType){
 			case 1:
 				qqq.Format(Msg_P05, pInstalledNet, Msg_P06);
 				break;
 			case 2:
 				qqq.Format(Msg_P05, pInstalledNet, Msg_P08);
 				break;
 			case 3:
 				qqq.Format(Msg_P05, pInstalledNet, Msg_P07);
 				break;
 			default:
 				MessageBox(Msg_62, Msg_76, MB_OK|MB_ICONERROR);
				((CTestBreeder32App*)AfxGetApp())->Log (Msg_62.GetBuffer (0));
				((CTestBreeder32App*)AfxGetApp())->Log ("\n");

				install_status = 2;
				send_internet_result ();

 				EndDialog(-1);
 				return;
 			}
 			MessageBox(qqq, Msg_76, MB_OK|MB_ICONERROR);
 			if(old_CIB_is_install == 1)
				// Один единственный из найденных ППД не подходит по сетёвости //
 				EndDialog(-1);
 			return;
 		}
   #ifdef MULTI_INDEX_STREAM_FILE
	if(!pHDD->keyFile->GetAttr("Attrs", (char*)"", 0))
   #endif
#endif
		{
			pCurrentWeight=  ppHDDs[m_baseIndx].currentWeight;
			pGSScreen->notSplit= 1;
			while(*pCurrentWeight){
				if(*pCurrentWeight < 0){
					pGSScreen->notSplit= 0;
					break;
				}
				pCurrentWeight += 2;
			}
			if(!pGSScreen->notSplit){
#ifdef INCLUDE_SPLIT
				preCheckMultiDisk(pHDD);
				if(	isLastFile(&pHDD->textFile->m_readed)
							||
						isLastFile(&pHDD->strFile->m_readed)
								||
							isLastFile(&pHDD->keyFile->m_readed))
#endif
				{
 						BeepWarning();
 						MessageBox(Msg_104, Msg_76, MB_OK|MB_ICONERROR);
						return;
				}
			}
		}
#ifndef RD_AS_ETALON
 	}
#endif
	if(m_currBaseSz && m_currBaseSz > (CorrectMyGetDiskFreeSpace(old_install_path)/1024)){
		rrr.LoadString(IDS_EXIT_TITLE);
		qqq.LoadString(IDS_EXIT_MSG);
		do{
			if(pGSScreen->ShowQuestionYesOrNo(NotFreeSpace)){
				if(MessageBox(qqq, rrr, MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2 ) == IDYES){
					install_status = 2;
					send_internet_result ();
					EndDialog(-1);
					return;
				}
			}else
				break;
		}while(1);
	}
#ifdef RD_AS_ETALON
  #if defined (_GCD_CLIENT) || defined (PILOT)
	m_TrialQ= FALSE;
  #else
	if(m_TrialQ && old_CIB_is_install != 1)
	{
		m_TrialQ= FALSE;
		m_CurrHlpTopicID= -1;
		TrialDlg tmpTrial(this);
		if(tmpTrial.DoModal() == IDOK){
			ShowWindow(SW_SHOWNORMAL);
			switch(tmpTrial.m_iTrialType){
			case 1:
				isTrial= 60;
			case 2:
				isTrial= 30;
			case 3:
				isTrial= atoi(tmpTrial.m_retVal);
			default:
				break;
			}
		}else
			return;
	}
  #endif
#endif
	DWORD dwMediaID;
	int fnd;
#ifdef RD_AS_ETALON
	txt= m_DefaultRD_Login;
	fnd= txt.Find('|');
	pLogin= (char*)(LPCTSTR)txt + fnd +1;
#else
	if(m_DefaultRD_Login != "")
		pLogin= (char*)(LPCTSTR)m_DefaultRD_Login;
	txt= pLogin;
#endif
	if(initFirst){
		pGSScreen->OtherShowMessage(Msg_61);
		m_CIBsTree.EnableWindow(FALSE);
		UpdateData();
	}
    if(!isLookFlpp()){
		m_iColor= 0;
    }
#ifndef RD_AS_ETALON
	else if(lOnFloppy < 1)
		m_iColor= 0;
#endif
	HideControl(&m_Radio4);
	HideControl(&m_Radio3);
	HideControl(&m_EditCtrl);

	if(!initFirst && !m_iColor){
		ShowControl(&m_CIBsTree);
	}
	retVal= 1; 

	long szRet= 0, allWeight= 0;
	pCurrentWeight= ppHDDs[m_baseIndx].currentWeight;

	if(initFirst){
		while(*pCurrentWeight){
			if(*pCurrentWeight > 0){
				sprintf(sel_Belngs+retVal, " %d", *pCurrentWeight);
				retVal+= strlen(sel_Belngs+retVal);
				allWeight += pCurrentWeight[1];
			}else
				szRet++;
			pCurrentWeight += 2;
		}
#ifdef RD_AS_ETALON
		if(old_CIB_is_install == 1 && (szRet || RBIcount < pCIB_Info->ComplectCount/2)){
			for(szRet= (int)ppHDDs->bwcount; szRet--;){
				if(	ppHDDs->bws[szRet].min <= (unsigned long)allWeight
						&&
					ppHDDs->bws[szRet].max >= (unsigned long)allWeight ){
					SetItemTextAsUnknwn(	hTreeItem_curr,
#ifdef ENGLISH_DEF_RC
												ppHDDs->bws[szRet].nameEng
#else
												ppHDDs->bws[szRet].name
#endif
												);
					break;
				}
			}
		}
#endif
		*(short*)sel_Belngs= (short)retVal-2;
	}
#ifndef SEL_OUT_PATH
	SelectedPath= old_install_path;
#endif
   if(!bOnMake){
#ifndef RD_AS_ETALON
	m_hasp_number= (WORD)(*returnID_CIB(pCurrCIBs->Alias) >> (32-7));
  #if defined(NOT_RD) || defined(MULTI_INDEX_STREAM_FILE)
	if(lOnFloppy){
		pHaspName= FloppyLabels[(lOnFloppy-1) % (sizeof(FloppyLabels)
										/
									sizeof(*FloppyLabels))];
	}else pHaspName= FloppyLabels[	CryptoTick()%(sizeof(FloppyLabels)
									/
								sizeof(*FloppyLabels))];
  #else
	pHaspName= "std_base";
  #endif
#else
	for(m_hasp_number= (int)ppHDDs[m_baseIndx].bwcount; m_hasp_number--;){
		if(	ppHDDs[m_baseIndx].bws[m_hasp_number].min <= (unsigned long)allWeight
				&&
			ppHDDs[m_baseIndx].bws[m_hasp_number].max >= (unsigned long)allWeight ){
			pHaspName= ppHDDs[m_baseIndx].bws[m_hasp_number].haspName;
			break;
		}
	}
#endif
	bOnMake= TRUE;
	if(old_CIB_is_install == 1){
		if(pGSScreen->pUpdatedBase != NULL){
			close(((PDDBase*)pGSScreen->pUpdatedBase)->keyFile->GetFileHandle());
			((PDDBase*)pGSScreen->pUpdatedBase)->keyFile->SetFileHandle(-1);
			close(((PDDBase*)pGSScreen->pUpdatedBase)->strFile->GetFileHandle());
			((PDDBase*)pGSScreen->pUpdatedBase)->strFile->SetFileHandle(-1);
			close(((PDDBase*)pGSScreen->pUpdatedBase)->textFile->GetFileHandle());
			((PDDBase*)pGSScreen->pUpdatedBase)->textFile->SetFileHandle(-1);
#ifdef MULTI_INDEX_STREAM_FILE
	if(((PDDBase*)pGSScreen->pUpdatedBase)->pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp=
			((PDDBase*)pGSScreen->pUpdatedBase)->pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pStreamFile){
				close(pOtherNextIndexTmp->pStreamFile->file->GetFileHandle());
				pOtherNextIndexTmp->pStreamFile->file->SetFileHandle(-1);
			}
			close(pOtherNextIndexTmp->pKey->GetFileHandle());
			pOtherNextIndexTmp->pKey->SetFileHandle(-1);
			pOtherNextIndexTmp++;
		}
	}
#endif
		}
		char *tstFile= strdup(testFile);
		memcpy(strrchr(tstFile, '.'), ".LCK", 5);
		if((fnd= open(	tstFile,
						O_CREAT | O_RDWR | O_TRUNC, 0664)) != -1)
			close(fnd);
		free(tstFile);
		::GetPrivateProfileString("Environment", "Data", "", tmp_valuies1, 1024, g4xPathINI );
		::WritePrivateProfileString("Environment", "Data", "**LOCKED**", g4xPathINI );
		::WritePrivateProfileString(NULL, NULL, NULL, g4xPathINI );
		m_restoreINI= TRUE;
		while(!IsFileOk(&testFile)){
			NextDlgCtrl();
			m_BttnNext.EnableWindow(FALSE);
			m_CIBsTree.EnableWindow(FALSE);
			hTickThread = ::CreateThread(	NULL, 0,
											(LPTHREAD_START_ROUTINE)tickProc100,
											this, /*CREATE_SUSPENDED*/0,(LPDWORD)&m_ThreadID);
			if(hTickThread == NULL){
				void *lpMsgBuf;
				::FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM, NULL, ::GetLastError(), MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR) &lpMsgBuf, 0, NULL );
				MessageBox( (char*)lpMsgBuf, (LPCTSTR)Msg_62, MB_OK|MB_ICONERROR );
				((CTestBreeder32App*)AfxGetApp())->Log ((char*)lpMsgBuf);
				::LocalFree( lpMsgBuf );

				install_status = 2;
				send_internet_result ();

				EndDialog(-1);
			}
			//::SetThreadPriority(hTickThread, THREAD_PRIORITY_ABOVE_NORMAL);
			//::ResumeThread(hTickThread);
			return;
		}
	}
   }
	int bDisableNext= FALSE;
   if(!initFirst || (
	#ifndef RD_AS_ETALON
			lVIP_flag != PL_VIP_FLAG && (lOnFloppy || (bDisableNext= IsDistribHASP_Ok(&dwMediaID))))
	#else
			(bDisableNext= (*((CTestBreeder32App*)AfxGetApp())->imp_HaspGetMediaId)(&dwMediaID)))
	#endif
	   ){
	bDisableNext= FALSE;
	m_CurrHlpTopicID= 70;
	if(m_iColor == 1){
		m_BttnNext.EnableWindow(FALSE);
		m_Progress.ShowWindow(SW_HIDE);
		HideControl(&m_CIBsTree);

		ShowControl(&m_Radio4);
		ShowControl(&m_Radio3);

		m_Radio4.SetWindowText(Msg_21);
		m_Radio3.SetWindowText(Msg_20);

		qqq.Format(Frmt20, Msg_66);
		m_Msg0.SetWindowText(qqq);
		if(!IsKeyFlpp(m_keyDiskProcess) && !IsKeyFlpp(m_keyDiskProcess)){
			ProcessFlppError(NameCIB);
			return;
		}else{
			qqq.Format(Frmt21, Msg_67);
			m_Msg1.SetWindowText(qqq);
		}
	}else if(!aCode && !m_iColor){
		OnPasswordForm();
		return;
	}else if(aCode){
		if(!m_AnswerCount){
			if(!pHDD->IsHDD()){
				EndDialog(-1);
				return;
			}
			tstSynchro.pDlg= this;
			tstSynchro.tLock= &LockSynchro;
			tstSynchro.fLocked = _sopen( pHDD->strFile->FileName, _O_RDONLY, _SH_DENYNO,  _S_IREAD);
			if( ( tstSynchro.fLocked == -1 ) ||
			    ( -1 == lseek(tstSynchro.fLocked, *(long*)pHDD->strFile->m_pCryptoTag, SEEK_SET )) ||
			    ( -1 == locking(tstSynchro.fLocked, LK_NBLCK, pHDD->strFile->PageSize))) {
				// Для любителей вытаскивать Носитель ППД и подделывать(или шарить) оный
				void *lpMsgBuf;
				::FormatMessage(	FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
								NULL,
								ERROR_CANT_DISABLE_MANDATORY,
								MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
								(LPTSTR) &lpMsgBuf,    0,    NULL );
				MessageBox( (char*)lpMsgBuf, (LPCTSTR)Msg_62, MB_OK|MB_ICONERROR );

				install_status = 2;
				send_internet_result ();

				EndDialog(-1);
				return;
			}
		}
		hTickThread0 = ::CreateThread(	NULL, 0,
										(LPTHREAD_START_ROUTINE)tickProc111,
										&tstSynchro, 0,(LPDWORD)&m_ThreadID);
		if(hTickThread0 == NULL){
			void *lpMsgBuf;
			::FormatMessage(	FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
							NULL,
							::GetLastError(),
							MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
							(LPTSTR) &lpMsgBuf,    0,    NULL );
			MessageBox( (char*)lpMsgBuf, (LPCTSTR)Msg_62, MB_OK|MB_ICONERROR );
			::LocalFree( lpMsgBuf );

			install_status = 2;
			send_internet_result ();

			EndDialog(-1);
		}
		Sleep(1000);
		while(LockSynchro) {
			PDDBase *pHDDTTT;
			char N256[256];
			strcpy(N256, pHDD->keyFile->FileName);
			*strrchr(N256, '.')= 0;
			if((pHDDTTT= new PDDBase( N256, O_RDONLY, 1000, 1000, 1000, (FILE *)pGSScreen)) != NULL && pHDDTTT->IsOk() ){
				delete pHDDTTT;
			}
			Sleep(0);
		}
		LockSynchro= 1;
		if(tstSynchro.tstPass && m_AnswerCount >= 3){
			HideControl(&m_Static_02);
			HideControl(&m_Static_03);
			HideControl(&m_MsgDealer);
			HideControl(&m_CopyPassword);
			HideControl(&m_DealerInfo);
			BeepWarning();
			MessageBox(Msg_79, Msg_76, MB_OK|MB_ICONERROR);
			EndDialog(-1);
			return;
		}else if(tstSynchro.tstPass){
			BeepWarning();
			MessageBox(Msg_79, Msg_86, MB_OK|MB_ICONERROR);
			HideControl(&m_Static_02);
			HideControl(&m_Static_03);
			HideControl(&m_MsgDealer);
			HideControl(&m_CopyPassword);
			HideControl(&m_DealerInfo);
			OnPasswordForm();
			LockSynchro= 0;
			return;
		}
		HideControl(&m_MsgDealer);
		HideControl(&m_CopyPassword);
		HideControl(&m_DealerInfo);
		HideControl(&m_Static_02);
		HideControl(&m_Static_03);
		ShowControl(&m_Msg0);
		ShowControl(&m_Msg1);
		ShowControl(&m_Msg2);
		ShowControl(&m_Static_01);
		bDisableNext= TRUE;
	#ifndef RD_AS_ETALON
		qqq.Format(Frmt0, returnRD_Name(pCurrCIBs->Alias));
		m_Msg0.SetWindowText(qqq);
	#endif
	}
	else bDisableNext= TRUE;
	if(bDisableNext){
		if(m_hasp_ret || aCode){
			SetDefID(IDCANCEL);
			m_BttnNext.EnableWindow(FALSE);
		}
		m_CIBsTree.EnableWindow(FALSE);
	}
   }else{
#ifndef RD_AS_ETALON
   if(lVIP_flag == PL_VIP_FLAG){
	   aCode= PL_VIP_FLAG;HideControl(&m_CIBsTree);
	   dwMediaID= *(PDWORD)(pHDD->textFile->SystemPageBuf
		   +512/2+12*16-SIZE_CRYPTO_HEADER-sizeof(dwMediaID));
   }
#endif
	m_iColor= 0;
   }
   initFirst= FALSE;
   if(aCode){
#ifndef RD_AS_ETALON
	if(lVIP_flag != PL_VIP_FLAG)
		m_Msg1.SetWindowText(Frmt31a);
#elif
	qqq.Format(Frmt0, m_CIBsTree.GetItemText( hTreeItem_curr ));
	m_Msg0.SetWindowText(qqq);
	m_Msg1.SetWindowText("");
#endif
   }
	if(installed){
		if(!aCode && m_iColor && m_keyDiskProcess != 2){
		 BOOL berror= FALSE;
		 if(IsFlppInsert()){
			qqq.Format(Frmt20, Msg_66);
			m_Msg0.SetWindowText(qqq);
			if(!IsKeyFlpp((m_keyDiskProcess= 2)) && !IsKeyFlpp(m_keyDiskProcess))
				berror= TRUE;
		 }else{
			qqq.Format(Frmt20, Msg_68);
			m_Msg0.SetWindowText(qqq);
			berror= TRUE;
		 }
		 if(berror){
			qqq.Format(Frmt21, Msg_64);
			m_Msg1.SetWindowText(qqq);
#ifndef RD_AS_ETALON
			qqq.Format(Frmt3, txt.Mid(1, txt.GetLength()-2));
#else
			qqq.Format(Frmt3, NameCIB);
#endif
			pGSScreen->OtherShowMessage(qqq);
			return;
		 }
		}
		Bind(&txt);
		return;
	}
	ShowControl(&m_Msg2);

#ifdef SEL_OUT_PATH
	LPITEMIDLIST	aBrowse = PidlBrowse( m_hWnd, CSIDL_DRIVES, SelectedPath, IDS_SELECT_FOLDER );
	if ( aBrowse && SHGetPathFromIDList( aBrowse, SelectedPath ))
#else
	if ( 1 )
#endif
	{
		UpdateData(FALSE);
		Sleep(1000);
		WORD ret= 0;
		m_hasp_ret= -4;
		dwMediaID= (DWORD)0x12563478;
		if(!ret)
			m_hasp_ret= 5;
		if(aCode || m_iColor){
#ifdef RD_AS_ETALON
			dwMediaID= (DWORD)0x12563478;
#else
		  dwMediaID= *(PDWORD)(pHDD->textFile->SystemPageBuf
			  +512/2+12*16-SIZE_CRYPTO_HEADER-sizeof(dwMediaID));
#endif
		}else if(!m_iColor && (m_hasp_ret || ret)){
			OnPasswordForm();
			return;
		}else if(!m_iColor && !m_hasp_ret){
			PrevDlgCtrl();
			m_BttnNext.EnableWindow(FALSE);
		}
		BYTE bff[LOGIN_SIZE_PER_BYTES+1];
		char *pBff= (char*)bff;
		local_sscanf2( pHDD->textFile->m_pCryptoTag+sizeof(long), (PDWORD)pBff, (PDWORD)pBff+1);
		local_sprintfX(	pBff, *((PDWORD)pBff) ^ dwMediaID, *((PDWORD)pBff+1) ^ dwMediaID);
		m_pLoginDlg->m_Login= pBff;
		m_pLoginDlg->m_Password= pBff;
		if(	!aCode && ( (m_iColor && m_BttnNext.EnableWindow(FALSE) && !IsKeyFlpp((m_keyDiskProcess= 1)) && !IsKeyFlpp(m_keyDiskProcess) )
							|| (!m_iColor && m_hasp_ret != (WORD)0))){
			BeepWarning();
			qqq.Format(Frmt21, Msg_64);
			m_Msg1.SetWindowText(qqq);
			ProcessFlppError(NameCIB);
			return;
		}else{
			m_BttnNext.EnableWindow();
			//BeepWarning();
			pGSScreen->pBase= pHDD;
			if(old_CIB_is_install != 1){
				// Автомат формирования нового имени для файлов КИБ //
				char	*pFnd1= strrchr(SelectedPath, '\0')
#ifndef NEW_AUTO_NAME
						, *pFnd2
#endif
						;
#ifndef NEW_AUTO_NAME
	#ifdef RD_AS_ETALON
		int img, simg;
		m_CIBsTree.GetItemImage(m_hPrnt, img, simg);
	#else
		int *pCurrentWeight= 
				ppHDDs[m_baseIndx].currentWeight, aa= 1, OkNext= FALSE;

		while(*pCurrentWeight){
			if(*pCurrentWeight < 0){
				aa= 0;
				break;
			}
			pCurrentWeight += 2;
		}
	#endif

	#ifdef RD_AS_ETALON
		if(img != 1){
			strcpy(pFnd1, pHaspName);
	#else
		if(!aa){
			for(retVal= (int)ppHDDs[m_baseIndx].bwcount; retVal--;){
				if(	ppHDDs[m_baseIndx].bws[retVal].min <= (unsigned long)allWeight
						&&
					ppHDDs[m_baseIndx].bws[retVal].max >= (unsigned long)allWeight ){
					strcpy(pFnd1, ppHDDs[m_baseIndx].bws[retVal].haspName);
					break;
				}
			}
	#endif
		}else{
			pFnd2= strrchr(pHDD->textFile->FileName, '.');
			*pFnd2= '\0';
			strcpy(pFnd1, strrchr(pHDD->textFile->FileName, '\\')+1);
			*pFnd2= '.';
		}
#else
				memcpy(pFnd1, pLogin, 8);
#endif
				*(pFnd1+8)= '\0';
			}
	if(old_CIB_is_install != 1){
		m_CIBsTree.EnableWindow(FALSE);
	}
	if(m_keyDiskProcess){
		pGSScreen->OtherShowMessage(Msg_61);
		qqq.Format(Frmt0, NameCIB);
		m_Msg0.SetWindowText(qqq);
		m_Msg1.SetWindowText("");
		HideControl(&m_Radio3);
		HideControl(&m_Radio4);
		m_BttnNext.EnableWindow(FALSE);
		PrevDlgCtrl();
	}
	//m_BttnNext.EnableWindow(FALSE);

	pHDD->IsHDD();

#ifdef	_GCD_CLIENT
  if(!PassEntered){
	ShowWindow(SW_HIDE);
	remoteInstall = false;

	if ( pUR->bu->is_base_exist()) {
		*pPilotBaseName = pUR->bu->get_local_dir_for_async ();/*pUR->bu->update_start(false);*/
		b_real_base_name_taken = true;
		strcpy (real_base_name, pPilotBaseName->GetBuffer (0));
	} else {
		*pPilotBaseName = pUR->bu->get_local_dir_for_sync (); /*pUR->bu->sync_update_start ();*/
		b_real_base_name_taken = true;
		strcpy (real_base_name, pPilotBaseName->GetBuffer (0));
	}
	*pPilotBaseDir = *pPilotBaseName->Left(1+pPilotBaseName->ReverseFind('\\'));

	if (false == GCM::is_server_running_on_that_mashine()) {
		((CTestBreeder32App*)AfxGetApp())->Log ("Информация: Бридер запущен не на сервере\n");
		CSelectBaseFolder	selectBaseFolder( pGSScreen->notSplit, m_currBaseSz/1024, pHDD->GetSizeInKbytes(pHDD->IsPacked()) / 1024 );
		if ( selectBaseFolder.DoModal() == IDOK ) {
			ShowWindow(SW_SHOW);
			remoteInstall = true;
			strcpy( remotePath, selectBaseFolder.selectedPath );
			((CTestBreeder32App*)AfxGetApp())->Log ("Для локальной установки данных выбран каталог: ");
			((CTestBreeder32App*)AfxGetApp())->Log (remotePath);
			((CTestBreeder32App*)AfxGetApp())->Log ("\n");

			char aNewName[ MAX_PATH ];
			MakePath( aNewName, remotePath, "DATA" );
			CString newPilotBaseName = aNewName;

			CString newPilotBaseDir  = newPilotBaseName.Left(1+newPilotBaseName.ReverseFind('\\'));
			CString newPilotBaseRoot;
			newPilotBaseDir = newPilotBaseName.Left(1+newPilotBaseName.ReverseFind('\\'));
			if ( newPilotBaseName[ 1 ] == ':' )
				newPilotBaseRoot = newPilotBaseName.Left(3);
			else
				newPilotBaseRoot = newPilotBaseName.Left(newPilotBaseName.Find('\\',1+newPilotBaseName.Find('\\',2)));

			*pPilotBaseName = newPilotBaseName;
			*pPilotBaseDir  = newPilotBaseDir;
			*pPilotBaseRoot = newPilotBaseRoot;
			strcpy (real_base_name, pPilotBaseName->GetBuffer (0));
		} else {
			ShowWindow( SW_SHOW );
			EndDialog(-1);
			return;
		}
	} else {
		CSyncUpdate syncUpdate;
		syncUpdate.pUR = pUR;
		long iwd = Core::ParamManagerFactory::get ().get_long (regInstallWithDisconnect, -1), ii= iwd;
		static bool gFirstCheckCache= true;
		if(gFirstCheckCache){
			gFirstCheckCache= false;
			if(iwd != -1){
				if(!pUR->bu->is_base_exist())
					ii= 1;
				ACE_OS::strcpy (stored_regInstallLastCacheName, Core::ParamManagerFactory::get ().get_string (regInstallLastCacheName).c_str ());
				long _InstallSize = Core::ParamManagerFactory::get ().get_long (regInstallSize, -1);
				char *localfnd= (char*)(strrchr(FileName,'\\'));
				if(localfnd){
					localfnd++;
					size_t lencmp= strlen(localfnd);
					//int delAll= 0;
					if(!strncmp(localfnd,stored_regInstallLastCacheName+3,lencmp) && _InstallSize == pHDD->GetSizeInKbytes (true)){
						if(ii){
							localfnd= pUR->bu->get_local_dir_for_sync();
						}else{
							localfnd= pUR->bu->get_local_dir_for_async();
						}
						strcpy(stored_regInstallLastCacheName,localfnd);
						localfnd= (char*)(strrchr(stored_regInstallLastCacheName,'\\'));
						*localfnd= 0;
						if(	CFileFind().FindFile((LPCTSTR)(CString(stored_regInstallLastCacheName)+Core::ParamManagerFactory::get ().get_string (regInstallLastCacheName).c_str ())) ){
							if(!(pGSScreen->ShowQuestionYesOrNo(get_app ()->get_rc_lang () == rl_Eng ? msgTsts_e : msgTsts)))
								MsgYesUseCache= 0;
							else{
								lencmp= 0;
							}
						}else{
							lencmp= 0;
						}
					}else{
						lencmp= 0;
					}
					if(!lencmp){
						removeOtherThis= 1;
						if(ii){
							strcpy(stored_regInstallLastCacheName,pUR->bu->get_local_dir_for_sync());
						}else{
							strcpy(stored_regInstallLastCacheName,pUR->bu->get_local_dir_for_async());
						}
						CFileFind finder;
						localfnd= (char*)(strrchr(stored_regInstallLastCacheName,'\\'));
						localfnd[1]= 0;
						if(finder.FindFile((LPCTSTR)(CString(stored_regInstallLastCacheName)+bkpMask))) do{
							ii= finder.FindNextFile();
							unlink(finder.GetFilePath());
						}while(ii);
						finder.Close();
						iwd= -1;
						Core::ParamManagerFactory::get ().set_long	(regInstallWithDisconnect, -1);
						Core::ParamManagerFactory::get ().set_long	(regInstallAsPacked, -1);
						Core::ParamManagerFactory::get ().set_long	(regInstallSize, -1);
					}	
				}
			}
		}
		syncUpdate.bSync = (iwd == 1 ? 1 : 0);
		if (!pUR->bu->is_base_exist() || iwd != -1 || syncUpdate.DoModal() == IDOK) {
			ShowWindow(SW_SHOW);
			if ( syncUpdate.bSync ) {
				stored_regInstallWithDisconnect= 1;
				((CTestBreeder32App*)AfxGetApp())->Log ("Пользователь выбрал: отключить пользователей на время процесса обновления\n");
				localpUR = pUR;
				ShowWindow (SW_HIDE);

				OSVERSIONINFOEX osvi;
				ZeroMemory (&osvi, sizeof (OSVERSIONINFOEX));
				osvi.dwOSVersionInfoSize = sizeof (OSVERSIONINFOEX);

				bool is_2000 = false;
				if (GetVersionEx ((OSVERSIONINFO *) &osvi))
					if (osvi.dwPlatformId == VER_PLATFORM_WIN32_NT && osvi.dwMajorVersion == 5 && osvi.dwMinorVersion ==  0)
						is_2000 = true;

				((CTestBreeder32App*)AfxGetApp())->TimeLog ("Начали ожидание освобождения базы пользователями\n");
				if (is_2000) {
					newPilotBaseName = pUR->bu->sync_update_start();
				} else {
					wait3Dialog = new CWaitUsers();
					startWorking = false;
					ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
					if (inst->spawn ((ACE_THR_FUNC)bu_sync_update_start, 0, THR_DETACHED) == -1)
						newPilotBaseName = pUR->bu->sync_update_start();
					else {
						while (!startWorking) ACE_OS::sleep(1);
						if (!endWorking) wait3Dialog->DoModal();
					}
					delete wait3Dialog;
				}
				ShowWindow (SW_SHOW);
				((CTestBreeder32App*)AfxGetApp())->TimeLog ("Завершили ожидание освобождения базы пользователями\n");

				pUR->updateType = 1;
				CString newPilotBaseDir  = newPilotBaseName.Left(1+newPilotBaseName.ReverseFind('\\'));
				CString newPilotBaseRoot;
				newPilotBaseDir = newPilotBaseName.Left(1+newPilotBaseName.ReverseFind('\\'));
				if ( newPilotBaseName[ 1 ] == ':' )
					newPilotBaseRoot = newPilotBaseName.Left(3);
				else
					newPilotBaseRoot = newPilotBaseName.Left(newPilotBaseName.Find('\\',1+newPilotBaseName.Find('\\',2)));

				*pPilotBaseName = newPilotBaseName;
				*pPilotBaseDir  = newPilotBaseDir;
				*pPilotBaseRoot = newPilotBaseRoot;
				strcpy (real_base_name, pPilotBaseName->GetBuffer (0));
			} else {
				stored_regInstallWithDisconnect= 0;
				newPilotBaseName = pUR->bu->is_base_exist() ? pUR->bu->update_start (false) : pUR->bu->sync_update_start ();
				((CTestBreeder32App*)AfxGetApp())->Log ("Пользователь выбрал: не отключать пользователей на время процесса обновления\n");
			}
			((CTestBreeder32App*)AfxGetApp())->Log ("База устанавливается в ");
			((CTestBreeder32App*)AfxGetApp())->Log (pPilotBaseName->GetBuffer (0));
			((CTestBreeder32App*)AfxGetApp())->Log ("\n");
		} else {
			ShowWindow(SW_SHOW);
			EndDialog(-1);
			return;
		}
	}
  }
#endif

	///////////////
	setInstallThread(::CreateThread(	NULL, 32*1024*1024,(LPTHREAD_START_ROUTINE)OnInstall,this, CREATE_SUSPENDED,(LPDWORD)&m_ThreadID));
	if(hInstllThread == NULL){
		void *lpMsgBuf;
		::FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM, NULL, ::GetLastError(), MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR) &lpMsgBuf, 0, NULL );
		MessageBox( (char*)lpMsgBuf, "CreateThread - Error:", MB_OK|MB_ICONERROR );
		::LocalFree( lpMsgBuf );
		EndDialog(-1);
	} else {
		m_BttnNext.EnableWindow(FALSE);
		timeOn10sec = 1;
		m_uTimerID = SetTimer(0x451,10000,NULL);
	}
	::SetThreadPriority(hInstllThread, THREAD_PRIORITY_ABOVE_NORMAL);
	::ResumeThread(hInstllThread);
	///////////////
			}
	}else{
		pGSScreen->OtherShowMessage("Not select outputed Path, please, retry...");
	}
	pGSScreen->SetProgress(0);
}

void CTestBreeder32Dlg::setInstallThread(HANDLE hNew)
{
	hInstllThread= hNew;
}

void CTestBreeder32Dlg::OnChangeEditAnswer() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.
	
	if (!UpdateData())
		return;
}

#ifdef	_GCD_CLIENT
void CTestBreeder32Dlg::Help( const char* html )
{
	char buffer [MAX_PATH];
	char helpFileName [MAX_PATH + 128];
	buffer [GetModuleFileName ((HMODULE)NULL, buffer, MAX_PATH)] = '\0';
	char* slash = strrchr( buffer, '\\' );
	if ( slash ) *slash = '\0';
	strcat( strcpy( helpFileName, buffer ), "\\..\\..\\help\\F1DataTools.chm" );
	if ( !FileExist( helpFileName ))
		strcat( strcpy( helpFileName, buffer ), "\\F1DataTools.chm" );
	strcat( strcat( helpFileName, "::/" ), html );
	::HtmlHelp( NULL, helpFileName, HH_DISPLAY_TOPIC, NULL );
}
#endif

Internet::InternetAccessInfo m_access_info;

void CTestBreeder32Dlg::write_to_ini (LPCTSTR key_name, LPCTSTR str) {
	if (0 == m_ini_name.size ())
		m_ini_name = Core::ParamManagerFactory::get ().get_string ("-GCMConfigFile");
	::WritePrivateProfileString ("Downloader", key_name, str, m_ini_name.c_str ()); 
	::WritePrivateProfileString (NULL, NULL, NULL, m_ini_name.c_str ());
}

void CTestBreeder32Dlg::read_from_ini (LPCTSTR key_name, LPSTR str, DWORD sz) {
	if (0 == m_ini_name.size ())
		m_ini_name = Core::ParamManagerFactory::get ().get_string ("-GCMConfigFile");
	ACE_OS::memset (str, 0, sz);
	::GetPrivateProfileString ("Downloader", key_name, _T (""), str, sz, m_ini_name.c_str ());
}

void CTestBreeder32Dlg::read_inet_settings () {
	class Local {
	public:
		static char* decode (const char *key) {
			if (0 == strlen (key)) {
				return strdup (key);
			}
			if (1024 <= strlen (key)) {
				assert (0);
			}
			unsigned char s [1024];
			int j = 0;
			for (unsigned i = 0; i < strlen (key); i += 2) {
				int code = ('A' <= key [i] && 'F' >= key [i]) ? 16 * (key [i] - 65 + 10) : 16 * (key [i] - 48);
				code += ('A' <= key [i + 1] && 'F' >= key [i + 1]) ? (key [i + 1] - 65 + 10) : (key [i + 1] - 48);
				s [j++] = code;
			}
			GCL::SimpleCrypto::Buffer buf_in ((void*)s, j);
			GCL::SimpleCrypto::Buffer buf_out;
			GCL::SimpleCrypto cryp;
			cryp.decrypt (buf_in, buf_out);
			if (1024 <= buf_out.m_len) {
				assert (0);
			}

			char* ret = (char*) malloc ((buf_out.m_len + 1) * sizeof (char));
			memcpy (ret, buf_out.m_buf, buf_out.m_len);
			ret [buf_out.m_len] = '\0';
			return ret;
		}
	};

	char buffer [512];

	*buffer = 0;

	this->read_from_ini ("accesstype", buffer, sizeof (buffer));

	if (strlen (buffer)) {
		m_access_info.access_type = atoi (buffer);
	} else {
		m_access_info.access_type = INTERNET_OPEN_TYPE_PRECONFIG;
	}

	m_access_info.open_query_flags = 0;

	this->read_from_ini ("proxyadress", buffer, sizeof (buffer));
	m_access_info.proxy_info.host = buffer;
	this->read_from_ini ("proxyport", buffer, sizeof (buffer));
	m_access_info.proxy_info.port = buffer;
	this->read_from_ini ("proxylogin", buffer, sizeof (buffer));
	{
		char* res = Local::decode (buffer);
		if (res) {
			m_access_info.proxy_info.login = res;
			free (res); 
		}
	}
	this->read_from_ini ("proxypassword", buffer, sizeof (buffer));
	{
		char* res = Local::decode (buffer);
		if (res) {
			m_access_info.proxy_info.password = Local::decode (buffer);
			free (res); 
		}
	}
	this->read_from_ini ("proxyauthentication", buffer, sizeof (buffer));
	m_access_info.proxy_info.is_authentication = (atol (buffer) == 1);
}

void CTestBreeder32Dlg::write_inet_settings () {
	class Local {
	public:
		static void encode (const char *str, char *key) {
			if (0 == strlen (str)) {
				key [0] = '\0';
				return;
			}

			GCL::SimpleCrypto::Buffer buf_in ((void*)str, strlen (str));
			GCL::SimpleCrypto::Buffer buf_out;
			GCL::SimpleCrypto cryp;

			cryp.encrypt (buf_in, buf_out);

			if (2048 <= buf_out.m_len * 2) {
				assert (0);
			}

			for (long i = 0; i < buf_out.m_len; i++) {
				unsigned int c = *(static_cast<unsigned char*>(buf_out.m_buf) + i);
				sprintf (key + i * 2, "%.2X\0", c);
			}
		}
	};

	char buffer [2048];

	Local::encode (m_access_info.proxy_info.login.c_str (), buffer);
	this->write_to_ini ("proxylogin", buffer);
	Local::encode (m_access_info.proxy_info.password.c_str (), buffer);
	this->write_to_ini ("proxypassword", buffer);

	this->write_to_ini ("proxyadress", m_access_info.proxy_info.host.c_str ());
	this->write_to_ini ("proxyport", m_access_info.proxy_info.port.c_str ());
	this->write_to_ini ("proxyauthentication", ltoa (m_access_info.proxy_info.is_authentication, buffer, 10));
	this->write_to_ini ("accesstype", ltoa (m_access_info.access_type, buffer, 10));
}

BOOL CTestBreeder32Dlg::OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo) 
{
	if(nID == IDC_INET_SETTINGS){
		ShowWindow (SW_HIDE);
		read_inet_settings ();
		CInetAccessSettingsDlg dlg;
		dlg.set_settings (m_access_info);
		if (dlg.DoModal () == IDOK) {
			dlg.get_settings (m_access_info);
			write_inet_settings ();
		}
		ShowWindow (SW_SHOW);
		SetForegroundWindow ();
		return false;
	}
	if(nID == ID_HELP){
		if(m_hPrnt != NULL && -1 != m_CurrHlpTopicID){
#ifdef	_GCD_CLIENT
			switch (m_CurrHlpTopicID) {
			case 100:
				//copying
				Help( "page-brd_order_copying.htm" );
				break;
			case 110:
				//complete
				Help( "page-brd_order_ending.htm" );
				break;
			case 60:
				//select complect
				Help( "page-brd_order_product_inst.htm" );
				break;
			case 70:
				//authorization
				break;
			case 80:
				Help( "page-brd_order_parol.htm" );
				//password
				break;
			}
#else
			::WinHelp(m_hWnd, m_CurrHlpName, HELP_CONTEXT, m_CurrHlpTopicID);
#endif
		}
		return FALSE;
	}else if(nID == IDCANCEL){
		if(!bOnRestore)
		#if defined (_GCD_CLIENT) || defined (PILOT)
		{
			EndDialog(IDOK);
			return IDOK;
		}
		#else
			return CDialog::OnCmdMsg(nID, nCode, pExtra, pHandlerInfo);
		#endif
		if(rpRd){
			if(!waitKill) waitKill= 1;
			return FALSE;
		}
		if(hTickThread != NULL)
			::SuspendThread(hTickThread);

		if(hInstllThread != NULL) waitKill= 1;

		if (!(pGSScreen->ShowQuestionYesOrNo(BRDR_EXIT))) {
			if(hTickThread != NULL)
				::ResumeThread(hTickThread);
			if(hInstllThread != NULL) waitKill= 0;
			return FALSE;
		} else {
			::WinHelp(m_hWnd, m_CurrHlpName, HELP_QUIT, 0);
			if(hTickThread != NULL){
				::TerminateThread(hTickThread, 0);
			}
			hTickThread= NULL;
			if(hInstllThread != NULL){
				install_status= 1;
				send_internet_result ();

				waitKill= 0;
				gCopyKill= 1;
				while(waitCopy) Sleep(100); waitCopy= 1;
				::TerminateThread(hInstllThread, 0);
				restoreBase();
				TerminateBreederThread();
				return FALSE;
			}
			hInstllThread= NULL;
		}
	}
	return CDialog::OnCmdMsg(nID, nCode, pExtra, pHandlerInfo);
}

void CTestBreeder32Dlg::TerminateBreederThread()
{
	if(gb_delAllBkp_In_TerminateBreederThread){
		gb_delAllBkp_In_TerminateBreederThread= false;
		delAllBkp (false);
	}
  #if defined (_GCD_CLIENT) || defined (PILOT)
	EndDialog (IDCANCEL);
	((CTestBreeder32App*)AfxGetApp())->TimeLog ("Выход\n\n------------------------------------------------------------\n\n");
	pUR->b_exit_requested = true;
	pUR->status (GCM::cs_exit_requested);
	pUR->logout_current ();
	exit (0);
  #else
	::TerminateThread(::GetCurrentThread(), 0);
  #endif
}

void CTestBreeder32Dlg::OnTimer(UINT nIDEvent)
{
	if(!timeOn10sec){
	KillTimer(m_uTimerID);
	//CDialog::OnTimer(nIDEvent);

	pGSScreen->OtherShowMessage(Msg_74);
	UpdateData();
	// Getnerate Synchro //
	if(pl_InitCrypto(	//theApp.m_pMainWnd->m_hWnd
									NULL
									)){
		BeepWarning();
		pGSScreen->OtherShowMessage(Msg_76);
		Sleep(1000);
		BeepOk();
		Sleep(1000);
		BeepWarning();
		Sleep(1000);
		BeepOk();
		Sleep(2000);
		EndDialog(-1);
		return;
	}
	PostMessage(WM_ON_OPEN);
	// Eat spurious WM_TIMER messages
	//MSG msg;
	//while(::PeekMessage(&msg, m_hWnd, WM_TIMER, WM_TIMER, PM_REMOVE));
	}else if(m_SelectNext){
	KillTimer(m_uTimerID);
	//CDialog::OnTimer(nIDEvent);
	m_BttnNext.EnableWindow();
#ifndef RD_AS_ETALON
	if(timeOn10sec == -1){
		if(old_CIB_is_install == 1 && m_SelectNext == 1){
			txt.Format(Frmt0, "");
			pGSScreen->OtherShowMessage(txt);
		}
	}else
		pGSScreen->OtherShowMessage(Msg_75);
	if(OkCount > 1){
		m_CIBsTree.EnableWindow();
	}else
#endif
	m_CIBsTree.EnableWindow(FALSE);
	SetDefID(ID_NEXT);
	if(m_SelectNext == 1000) {
		GotoDlgCtrl(&m_EditCtrl);
		if (internet_answer) {
			OnNext ();
		}
	}
	else
		GotoDlgCtrl(&m_BttnNext);
	m_SelectNext= 0;
	}else if(timeOn10sec > 0){
		if(timeOn10sec == 1)
		{
	ShowControl(&m_BttnBrws);
	m_BttnBrws.EnableWindow();
	//m_Static_73.EnableWindow( FALSE );
	ShowControl(&m_Static_73);
	//m_Msg70.EnableWindow( FALSE );
	ShowControl(&m_Msg70);
		}
	//CDialog::OnTimer(nIDEvent);
	timeOn10sec += 10;
	}
}

int CTestBreeder32Dlg::IsFlppInsert()
{
	pGSScreen->OtherShowMessage(Msg_65);
	CFileFind sss;
	//return 0; // Debug
	return sss.FindFile("A:\\*.*");
}

int CTestBreeder32Dlg::isLookFlpp()
{
	//return 1; // Debug

	DWORD dwVersion = GetVersion(), dwWindowsMajorVersion, dwWindowsMinorVersion;

	dwWindowsMajorVersion =  (DWORD)(LOBYTE(LOWORD(dwVersion)));
	dwWindowsMinorVersion =  (DWORD)(HIBYTE(LOWORD(dwVersion)));

	// Get the build number.

	if (dwVersion < 0x80000000)              // Windows NT/2000, Whistler
		return 0;
	else if (dwWindowsMajorVersion < 4)      // Win32s
		return 0;
	else
#ifndef RD_AS_ETALON
		if(lOnFloppy == -1 || (lOnFloppy > -1
	#if !defined(NOT_RD) && !defined(MULTI_INDEX_STREAM_FILE)
			&& lOnFloppy <= (sizeof(FloppyLabels) / sizeof(*FloppyLabels))
	#endif
			))
#endif
		//if (dwWindowsMajorVersion == 4 && dwWindowsMinorVersion == 0)
		// Only Windows 95 //
		return 1;

	return 0;
}

void CTestBreeder32Dlg::ProcessFlppError(CString name)
{
	CFileFind finder;
	if(!finder.FindFile("a:\\*.*")){
		qqq.Format(Frmt20, Msg_68);
		m_Msg0.SetWindowText(qqq);
	}
	if(!m_keyDiskProcess){
		qqq.Format(Frmt21, Msg_64);
		m_Msg1.SetWindowText(qqq);
	}
	//////////////////////////////////////
	#ifdef RD_AS_ETALON
		rrr= name;
		name.Format(Frmt3, rrr);
	#else
		name.Format(Frmt3, NameCIB);
	#endif
	pGSScreen->OtherShowMessage(name);
	//////////////////////////////////////
	m_BttnNext.EnableWindow();
	GotoDlgCtrl(&m_BttnNext);
	SetDefID(ID_NEXT);
}

void CTestBreeder32Dlg::restoreBase()
{
	if(!bOnRestore)
		return;

	if(pGSScreen->pUpdatedBase != NULL){
		delete pGSScreen->pUpdatedBase;
		pGSScreen->pUpdatedBase= NULL;
	}
#ifndef	_GCD_CLIENT
	if(makedKey != -1)
		close(makedKey);
	if(makedStr != -1)
		close(makedStr);
	if(makedNdt != -1)
		close(makedNdt);
	if(makedTmp != -1)
		close(makedTmp);
#endif
	if(strrchr(SelectedPath, '*'))
		memcpy(strrchr(SelectedPath, '*'), ".*", 3);
	else
		memcpy(strrchr(SelectedPath, '\0'), "*.*", 4);
	CFileFind finder;
	if (finder.FindFile (SelectedPath)){
		BOOL bFindNext;
		do{
			bFindNext = finder.FindNextFile ();
			CString file_path = finder.GetFilePath ();
#if defined (_GCD_CLIENT)
			// не удаляем `data.lic`
			const char* data_lic_pos = ACE_OS::strstr (file_path.GetString (), "data.lic");
			if ((data_lic_pos != 0) && (data_lic_pos [8] == '\0')) {
				continue;
			}
#endif
			unlink (file_path);
		} while (bFindNext);
		finder.Close ();
	}
	memcpy(strrchr(SelectedPath, '.'), "!???", 5);
	if(finder.FindFile(SelectedPath)){
		BOOL bFindNext;
		char *pStr;
		do{
			bFindNext = finder.FindNextFile();
			rrr= finder.GetFilePath();
			rrr.MakeLower();
			qqq= rrr.Right(3);
			if( qqq == "str"){
				pStr= strdup((LPCTSTR)rrr);
				memcpy(strrchr(pStr, '!'), ".str", 5);
				rename(rrr, pStr);
				free(pStr);pStr= NULL;
			}else if( qqq == "ndt"){
				pStr= strdup((LPCTSTR)rrr);
				memcpy(strrchr(pStr, '!'), ".ndt", 5);
				rename(rrr, pStr);
				free(pStr);pStr= NULL;
			}else if( qqq == "key"){
				pStr= strdup((LPCTSTR)rrr);
				memcpy(strrchr(pStr, '!'), ".key", 5);
				rename(rrr, pStr);
				free(pStr);pStr= NULL;
			}
			unlink(rrr);
		}while(bFindNext);
		finder.Close();
	}
}

WORD CTestBreeder32Dlg::IsNextRnd()
{
	WORD wRet= (WORD)(CryptoTick()%0xffff);
	if(isTrial){
		wRet %= 100;
		wRet += 1100;
	}
	return wRet;
}

CWaitDatasetupGarantRu* waitIADialog;
CString val10;

DWORD	internet_autorization (void* params) {
	CTestBreeder32Dlg* breeder_dialog = (CTestBreeder32Dlg*) params;

	startWorking = true;
	endWorking = false;

	Sleep (200);

	try {
		Internet::Inet_i::Connect_i_factory_var factory = new  Internet::Inet_i::Connect_i_factory ();
		factory->registrate_me (0);
	}
	catch(...) {
	}
	try {
		Internet::Inet_i::Connection_i_factory_var factory = new Internet::Inet_i::Connection_i_factory ();
		factory->registrate_me (0);
	}
	catch(...) {
	}

	try {
		Internet::ConnectManager* manager = Internet::ConnectManager::instance ();
		manager->init (m_access_info, true);
		Internet::IConnect_var connect = Internet::ConnectManager::instance ()->get_connect ();

		std::string host = Core::ParamManagerFactory::get ().get_string ("-DSHost").c_str ();
		if (0 == host.size ()) host = "datasetup.garant.ru";
		std::string agent = AfxGetAppName ();

		char aLogString [128];
		sprintf (aLogString, "Авторизация будет проходить на сервере %s\n", host.c_str ());
		((CTestBreeder32App*)AfxGetApp())->Log(aLogString);

		connect->execute (host, agent);
		Internet::IConnection_var m_connection = connect->get_connection ();

		char request [128];
		sprintf (request, "/datasetup/validate?key=%s&hwidc=%ld", val10.GetBuffer (0), (long) GetComputerID ());
		sprintf (aLogString, "Отправляем пароль %s%s\n", val10.GetLength() < 23 ? "0" : "", val10.GetBuffer (0));
		((CTestBreeder32App*)AfxGetApp())->Log(aLogString);

		try {
			if (m_connection->open_request (request, 0)) {
				try {
					if (m_connection->send_request ()) {
						((CTestBreeder32App*)AfxGetApp())->Log("Пароль отправлен, получаем ответ от сервера\n");
						std::string content;
						try {
							m_connection->get_info (HTTP_QUERY_RAW_HEADERS_CRLF, content);
						} catch (...) {
						}
						if (content.empty () == false) {
							char* buffer = strdup (content.c_str ());
							char* pos = strstr (buffer, "Garant-Response: ");
							if (pos) {
								char* answer = strdup (pos + 17), *ptr = answer;
								while (*ptr >= '0' && *ptr <= '9')
									ptr++;
								*ptr = 0;

								sprintf (aLogString, "Ответ: %s\n", answer);
								((CTestBreeder32App*)AfxGetApp())->Log(aLogString);

								breeder_dialog->m_EditCtrl.SetWindowText (answer);
								breeder_dialog->m_AnswerStr = answer;						
								free (answer);

								breeder_dialog->HideControl(&breeder_dialog->m_MsgDealer);
								breeder_dialog->HideControl(&breeder_dialog->m_CopyPassword);
								breeder_dialog->HideControl(&breeder_dialog->m_DealerInfo);
								breeder_dialog->HideControl(&breeder_dialog->m_Static_02);
								breeder_dialog->HideControl(&breeder_dialog->m_Static_03);
								breeder_dialog->ShowControl(&breeder_dialog->m_Msg0);
								breeder_dialog->ShowControl(&breeder_dialog->m_Msg1);
								breeder_dialog->ShowControl(&breeder_dialog->m_Msg2);
								breeder_dialog->ShowControl(&breeder_dialog->m_Static_01);

								breeder_dialog->internet_answer = true;
							} else {
								pos = strstr (buffer, "Garant-Status: ");
								if (pos) {
									char* status = strdup (pos + 15), *ptr = status;
									while ((*ptr >= 'A' && *ptr <= 'Z') || *ptr == '_')
										ptr++;
									*ptr = 0;
									sprintf (aLogString, "Статус в ответе сервера: %s\n", status);
									((CTestBreeder32App*)AfxGetApp())->Log(aLogString);
									free (status);
								}
								pos = strstr (buffer, "Garant-Response-Count: ");
								if (pos) {
									char* count = strdup (pos + 23), *ptr = count;
									while ((*ptr >= '0' && *ptr <= '9') || *ptr == '-')
										ptr++;
									*ptr = 0;
									sprintf (aLogString, "Ошибка в ответе сервера: %s\n", count);
									((CTestBreeder32App*)AfxGetApp())->Log(aLogString);
									free (count);
								}
							}
							free (buffer);
						} else {
							((CTestBreeder32App*)AfxGetApp())->Log("От сервера получен пустой ответ\n");
						}
					} else {
						((CTestBreeder32App*)AfxGetApp())->Log("Не смогли отправить пароль\n");
					}
				} catch (...) {
					((CTestBreeder32App*)AfxGetApp())->Log("При отправке/получении пароля произошла ошибка\n");
				}
			} else {
				((CTestBreeder32App*)AfxGetApp())->Log("При отправке/получении пароля произошла ошибка\n");
			}
		} catch (...) {
			((CTestBreeder32App*)AfxGetApp())->Log("При отправке/получении пароля произошла ошибка\n");
		}
	} catch (...) {
		((CTestBreeder32App*)AfxGetApp())->Log("При отправке/получении пароля произошла ошибка\n");
	}

	try {
		waitIADialog->EndDialog (IDOK);
	} catch (...) {}

	Sleep (200);
	endWorking = true;

	return 0;
}

DWORD	internet_complete (void* params) {
	CTestBreeder32Dlg* breeder_dialog = (CTestBreeder32Dlg*) params;

	startWorking = true;
	endWorking = false;

	Sleep (200);

	try {
		Internet::Inet_i::Connect_i_factory_var factory = new  Internet::Inet_i::Connect_i_factory ();
		factory->registrate_me (0);
	} catch(...) {}

	try {
		Internet::Inet_i::Connection_i_factory_var factory = new Internet::Inet_i::Connection_i_factory ();
		factory->registrate_me (0);
	} catch(...) {}

	try {
		Internet::ConnectManager* manager = Internet::ConnectManager::instance ();
		manager->init (m_access_info, true);
		Internet::IConnect_var connect = Internet::ConnectManager::instance ()->get_connect ();

		std::string host = Core::ParamManagerFactory::get ().get_string ("-DSHost").c_str ();
		if (0 == host.size ()) host = "datasetup.garant.ru";
		connect->execute (host, AfxGetAppName ());

		Internet::IConnection_var m_connection = connect->get_connection ();

		char request [128];
		sprintf (request, "/datasetup/install?key=%s&time=%ld&status=%ld", val10.GetBuffer (0), install_time, breeder_dialog->install_status);

		try {
			if (m_connection->open_request (request, 0)) {
				try {
					m_connection->send_request ();
				} catch (...) {}
			}
		} catch (...) {}
	} catch (...) {}

	try {
		waitIADialog->EndDialog (IDOK);
	} catch (...) {}

	Sleep (200);
	endWorking = true;

	return 0;
}

void	CTestBreeder32Dlg::send_internet_result ()
{
	if (b_result_send)
		return;

	b_result_send = true;
	install_time = time (0) - install_time;

	if (!internet_was_checked) {
		read_inet_settings ();
		internet_was_checked = true;
	}

	waitIADialog = new CWaitDatasetupGarantRu();
	ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
	startWorking = false;

	if (inst->spawn ((ACE_THR_FUNC)internet_complete, this, THR_DETACHED) != -1) {
		while (!startWorking) Sleep (100);
		waitIADialog->DoModal ();
	}

	delete waitIADialog;
}

void CTestBreeder32Dlg::OnPasswordForm()
{
	HideControl(&m_BttnSettings);
	m_Msg1.SetWindowText(Frmt31);
	m_CurrHlpTopicID= 80;

	qqq.Format(Frmt3, NameCIB);
	pGSScreen->OtherShowMessage(qqq);

	HideControl(&m_Msg2);
	HideControl(&m_CIBsTree);
	ShowControl(&m_EditCtrl);

	if(!aCode){
		HideControl(&m_Msg0);
		HideControl(&m_Msg1);
		HideControl(&m_Msg2);
		HideControl(&m_Static_01);
	}
	ShowControl(&m_Static_02);
	ShowControl(&m_Static_03);
	ShowControl(&m_MsgDealer);
	ShowControl(&m_CopyPassword);
	ShowControl(&m_DealerInfo);

	if(!aCode){
		CString fName(pHDD->textFile->FileName);
		fName= fName.Left(fName.ReverseFind('\\')+1) + DEALER_FILE_NAME;
		FILE *stream;
		CFileFind finder;
		BOOL FindOk= finder.FindFile(fName);
		if(FindOk){
			finder.FindNextFile();
			aCode= (int)finder.GetLength();
			finder.Close();
		}
		if( aCode && (stream = fopen( fName, "r" )) != NULL){
			char *line = (char*)malloc((aCode+1)*2);
			if( !line /*|| fgets( line, aCode, stream ) == NULL*/ ) {
				m_DealerInfo.SetText(Msg_101 + DEALER_FILE_NAME);
			} else {
				/*
				int lenRd, zzz= aCode, OldSize= 0;
				char *pStr= line;
				while((lenRd= strlen(line)) < zzz){
					zzz -= lenRd + 1;
					memcpy(line+aCode+1+OldSize, line, lenRd+1);
					OldSize += lenRd;
					if(zzz && fgets( line, zzz, stream ) == NULL) {
						strcpy(line+aCode+1, (LPCTSTR)(Msg_101 + DEALER_FILE_NAME));
						break;
					}
				}
				if(OldSize)
					pStr= line+aCode+1;
				line[aCode]= 0;
				*/
				char* pStr = line;
				for(;;) {
					char* aString = fgets( pStr, aCode, stream );
					if ( !aString ) break;
					pStr += strlen( pStr );
					*pStr++ = ' ';
				}
				*pStr = 0;
				pStr = line;			
				Recoding( cd_dos, cd_win, pStr );
				char *pFnd= pStr;
				while(*pFnd){
					if(*pFnd == 9)
						*pFnd= ' ';
					else if(*pFnd == '\n'){
						char *pNxt= pFnd-1;
						while(*pNxt == ' ')
							pNxt--;
						strcpy(pNxt+1, pFnd);
						pFnd= pNxt+1;
					}
					pFnd++;
				}
				m_DealerInfo.SetText(pStr);
				free(line);
			}
			fclose( stream );
	   }else{
			m_DealerInfo.SetText(Msg_102 + DEALER_FILE_NAME);
	   }
	   aCode= 0;
#ifndef RD_AS_ETALON
		/*
			CTimeSpan( CTime(ppHDDs[m_baseIndx].LastUpdate.RevisionDate.da_year,
						ppHDDs[m_baseIndx].LastUpdate.RevisionDate.da_mon,
					ppHDDs[m_baseIndx].LastUpdate.RevisionDate.da_day,
					0, 0, 0)-CTime(2002, 7, 12, 0, 0, 0)).GetDays(),
		*/
	    aCode= (CryptoTick() & 0xfff)+1;
		pXXX= pl_getPassword(	*returnID_Service(pCurrCIBs->Alias),
								384, *returnID_CIB(pCurrCIBs->Alias), aCodeNew+aCode-1);
/*
		long o1, o2, o3, zcz;
		char *pRet= pl_getResponce(pXXX, &o1, &o2, &o3);

		zcz= Answertoi(pRet);
		aCode= zcz;*/
#else
		aCode= IsNextRnd();
#endif
	}
#ifdef RD_AS_ETALON
	m_sRet.Format("%u", Pfunc((short)aCode));
#else
	m_sRet= "?";
#endif

#ifdef RD_AS_ETALON
	rrr.Format("XX%u", aCode);

	char *pEdt= (char*)(LPCTSTR)rrr;

	*pEdt= pEdt[2];
	pEdt[2]= '-';
	pEdt[1]= 'A'+ ( pEdt[rrr.GetLength()-1] - '0');
	qqq.Format(Frmt30, rrr);
#else
	CLongInt<128> cur_passw((char*)(LPCTSTR)pXXX, 16);
	val10 = (char*)(LPCTSTR)cur_passw.ToString(10);
	while (val10.GetLength () != 23)
		val10 = "0" + val10;
	qqq = Msg_P04.Mid(0, Msg_P04.Find('%'));

	sid = (u_int16_t)(pUR->function_mng->get_sid_hash () & 0xFFFF);
	/*
	if (pUR->function_mng->get_product_info () == GblPilot::VT_FILESERVER) {
		sid = GetComputerID_FS (pUR->bu->get_local_dir_for_async ());
	}
	*/

	char s_sid [6];
	sprintf (s_sid, "%05d", sid);
	char s_sid_code [64];
	strcat (strcpy (s_sid_code, s_sid), val10.GetBuffer (0));
	u_int16_t hash = (u_int16_t) (gkdb_HashRot13 (s_sid_code) & 0xFFFF);
	u_int32_t hash_sid = (((u_int32_t)hash) << 16) + sid;
	char s_hash_sid [16];
	sprintf (s_hash_sid, "%010u", hash_sid);
	val10 = s_hash_sid + val10;

	for (int i = 0; i < 33; i += i < 15 ? 5 : 3) {
		if (i) qqq += '-';
		qqq += val10.Mid (i, i < 15 ? 5 : 3);
	}

#endif
	CString tmpMsg88;
	str_password.assign (qqq);
	tmpMsg88.Format(Msg_100, qqq);
	m_MsgDealer.SetWindowText(tmpMsg88);
	m_Static_03.SetWindowText(Msg_103);
	m_BttnNext.EnableWindow(FALSE);
	KillTimer(m_uTimerID);
	m_SelectNext= 1000;
	timeOn10sec= -1;

	if (!internet_was_checked) {
		read_inet_settings ();
		internet_was_checked = true;

		waitIADialog = new CWaitDatasetupGarantRu();
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		startWorking = false;

		EnableWindow (0);
		if (inst->spawn ((ACE_THR_FUNC)internet_autorization, this, THR_DETACHED) != -1) {
			while (!startWorking) Sleep (100);
			waitIADialog->DoModal ();
		}

		delete waitIADialog;
		EnableWindow ();
		SetForegroundWindow ();
	}

	m_uTimerID = SetTimer(0x451,internet_answer ? 10 : 2000,NULL);
}

int CTestBreeder32Dlg::MakeTreeNodes(	LPPL_IMPORT_COMPLECT_DATA pList,
										HTREEITEM *p_hRoot, int *pIndex,
										BaseInfo *pbi, WORD ret,
#ifdef RD_AS_ETALON
										BOOL *p_bFindNext,
#endif
										BOOL *p_bAutoInstall)
{
	TV_INSERTSTRUCT TreeCtrlItem;
	long l;
#ifndef RD_AS_ETALON
	OkCount= 0;
	#ifndef ONLY_DISTR_WITH_KEY
		TypeProtect= 0;
	#endif
#endif
	Stream *str = pHDD->FindIndex("Aux")->Open("Here");
	if (!str || !str->Length()) {
	}
	RBIcount = str->Length() / sizeof(short);
	short *here = new short[RBIcount];
	str->Read(here, str->Length());

	int *pBelngs= ppHDDs[(*pIndex)/MAX_HDD_COUNT].currentWeight, one= -1;
	pRBI= new BaseInfo[RBIcount];

	for(l= 0; l < RBIcount; l++)
	  if (pHDD->FindBaseInfo(here[l], *(pRBI+l)) == sizeof(BaseInfo)) {
		TreeCtrlItem.hParent = *p_hRoot;
		TreeCtrlItem.hInsertAfter = TVI_LAST;
		TreeCtrlItem.item.mask = TVIF_TEXT | TVIF_PARAM | TVIF_IMAGE | TVIF_SELECTEDIMAGE;

		if (*p_hRoot == TVI_ROOT) {

			if (get_app ()->get_rc_lang () == rl_Eng) {
				ACE_OS::sprintf (sTr, Frmt50, pbi->NameEng);
			} else {
				ACE_OS::sprintf (sTr, Frmt50, pbi->Name);
#ifndef	WINENCODE
				Recoding (cd_dos, cd_win, sTr);
#endif
			}

			TreeCtrlItem.item.pszText = sTr;
			TreeCtrlItem.item.lParam = (*pIndex)++;
			TreeCtrlItem.item.iImage = 0;

#ifndef RD_AS_ETALON
			if(nRetCode == -116){
				TreeCtrlItem.item.iSelectedImage = 1;
				*p_hRoot = m_CIBsTree.InsertItem(&TreeCtrlItem);
			}else{
if(PassEntered)
TypeProtect= PL_VIP_FLAG;
else{
			  TypeProtect= *returnVIP_Flag(pList->pCIBs->Alias);
}
			  if(pList->pCIBs->next){
	#ifndef ONLY_DISTR_WITH_KEY
				if(TypeProtect == PL_HASP_FLAG){
#ifdef TEST_HASP
					if(!iHASPFind){
						// Повторить генерацию дерева но с HASP //
						iHASPFind++;
						delete str;
						delete here;
						return LOOK_HDD_NOT_HASP;
					}
#endif
					if(DistribHASP_Ok == TRUE){
						TreeCtrlItem.item.iImage = 6;
						TreeCtrlItem.item.iSelectedImage = 6;
					}else{
						TreeCtrlItem.item.iImage = 10;
						TreeCtrlItem.item.iSelectedImage = 10;
					}
				}else if((TypeProtect & 0xffff) == PL_FLP_FLAG){
					//if(isLookFlpp()){
						TreeCtrlItem.item.iImage = 6;
						TreeCtrlItem.item.iSelectedImage = 6;
					//}
/*
		Закоментарино т.к. дискета всегда подходит в Win 95-98
					else{
						TreeCtrlItem.item.iImage = 10;
						TreeCtrlItem.item.iSelectedImage = 10;
					}	*/
				}else{
	#endif
		#ifdef AS_HDD_ROOT
					TreeCtrlItem.item.iSelectedImage = 4;
					TreeCtrlItem.item.iImage = 4;
		#else
					TreeCtrlItem.item.iSelectedImage = 1;
					TreeCtrlItem.item.iImage = 0;
		#endif
	#ifndef ONLY_DISTR_WITH_KEY
				}
	#endif
			  }
	#ifndef ONLY_DISTR_WITH_KEY
			  else if(TypeProtect == PL_HASP_FLAG){
#ifdef TEST_HASP
				  if(!iHASPFind){
					  // Повторить генерацию дерева но с HASP //
					  iHASPFind++;
					  delete str;
					  delete here;
					  return LOOK_HDD_NOT_HASP;
				  }
#endif
				  if(DistribHASP_Ok == TRUE){
					  TreeCtrlItem.item.iImage = 5;
					  TreeCtrlItem.item.iSelectedImage = 5;//7;
				  }else{
					  TreeCtrlItem.item.iImage = 8;
					  TreeCtrlItem.item.iSelectedImage = 8;//10;
				  }
			  }else if(isLookFlpp() && (TypeProtect & 0xffff) == PL_FLP_FLAG){
				  if(isLookFlpp()){
					  TreeCtrlItem.item.iImage = 5;
					  TreeCtrlItem.item.iSelectedImage = 5;//7;
/*
		Закоментарино т.к. дискета всегда подходит в Win 95-98
				  }else{
					  TreeCtrlItem.item.iImage = 8;
					  TreeCtrlItem.item.iSelectedImage = 10;*/
				  }
			  }
	#endif
			  else
#endif
#ifndef RD_AS_ETALON
				TreeCtrlItem.item.iSelectedImage = 0;
#else
				TreeCtrlItem.item.iSelectedImage = 1;
#endif

			  *p_hRoot = m_CIBsTree.InsertItem(&TreeCtrlItem);
#ifndef RD_AS_ETALON
			}
		}
		if(l == 0 && nRetCode != -116){
#endif

			TreeCtrlItem.hParent = *p_hRoot;
			TreeCtrlItem.hInsertAfter = TVI_LAST;
			//TreeCtrlItem.item.mask = TVIF_TEXT | TVIF_PARAM | TVIF_IMAGE | TVIF_SELECTEDIMAGE;
#ifdef RD_AS_ETALON
			TreeCtrlItem.item.iImage = 3;
			TreeCtrlItem.item.iSelectedImage = 3;
#ifdef ENGLISH_DEF_RC
			sprintf(sTr, Frmt51, (pRBI+l)->NameEng);
#else
			sprintf(sTr, Frmt51, (pRBI+l)->Name);
		#ifndef	WINENCODE
			Recoding( cd_dos, cd_win, sTr );
		#endif
#endif
			TreeCtrlItem.item.pszText = sTr;
			TreeCtrlItem.item.lParam = (*pIndex)++;
			m_CIBsTree.InsertItem(&TreeCtrlItem);
#else
			LPPL_IMPORT_COMPLECT_DATA pNext= pList;
			do{
			LPPL_IMPORT_CIB_DATA pCIBs= pNext->pCIBs;
			do{
				TreeCtrlItem.item.iImage = 0;
				TreeCtrlItem.item.iSelectedImage = 1;

				char *fndT= strrchr(pHDD->textFile->FileName,'\\');
				if(fndT){
					*fndT= 0;
					sprintf(sTr, Frmt51, pCIBs->Alias);
					//sprintf (sTr, Frmt51, pCIBs->Alias, pHDD->textFile->FileName);
					m_Msg70.SetWindowText(pHDD->textFile->FileName);
					*fndT= '\\';
				}else
					sprintf(sTr, Frmt51, pCIBs->Alias);

				TreeCtrlItem.item.pszText = sTr;
				TreeCtrlItem.item.lParam = (*pIndex)++;
				rrr= returnRD_Blngs(pCIBs->Alias);
				int ccc= rrr.Find('~');
				if(ccc != -1){
					rrr= rrr.Left(ccc);
				}
			if(old_CIB_is_install == 1
					&&
(	// другой Клиент //
	(m_DefaultRD_Hash && m_DefaultRD_Hash != *returnRD_ClntHash(pCIBs->Alias))
							||
	// часть Клиент-комплекта другого наполнения ! //
	IsBelongsOk(pCIB_Info,(char*)(LPCTSTR)rrr)
)
					){
				// Чужой КИБ //
				m_OtherSelPath= "";
		}else{
 				OkCount++;
				if(PassEntered && OkCount > defSelParam)
					break;
				else{
					if(!m_SpacePrnt){
						m_SpacePrnt= m_CIBsTree.InsertItem(&TreeCtrlItem);
						if(rrr.Find(',') > 0)
							rrr= rrr.Mid(rrr.Find(',')+1);

						if(old_CIB_is_install == 1 && m_DefaultRD_Hash)
							break;
					}else{
						m_CIBsTree.InsertItem(&TreeCtrlItem);
					}
				}
 		}
 			}while((pCIBs= (LPPL_IMPORT_CIB_DATA)pCIBs->next));
 			}while((pNext= (LPPL_IMPORT_COMPLECT_DATA)pNext->next));
#ifdef RD_AS_ETALON
			// Ребёнок один - Выбор откючён // 
			if(OkCount == 1){
				m_CIBsTree.SetItemImage(*p_hRoot,1,1);
			}
			else
#endif
				if(!OkCount && pList){
				*pIndex= *pIndex / MAX_HDD_COUNT;
				if(ppHDDs[*pIndex].pList){
					pl_FreeImportedComplectList(ppHDDs[*pIndex].pList);
					ppHDDs[*pIndex].pList= NULL;
				}
				m_CIBsTree.DeleteItem(*p_hRoot);
				*p_hRoot= 0;
				return 0;
			}
			if(!(*pIndex / MAX_HDD_COUNT))
				m_CIBsTree.Expand(*p_hRoot, TVE_EXPAND);
		}
#endif
#ifdef RD_AS_ETALON
		}
		else{
			TreeCtrlItem.item.iImage = 3;
			TreeCtrlItem.item.iSelectedImage = 3;

#ifdef ENGLISH_DEF_RC
			sprintf(sTr, Frmt51, (pRBI+l)->NameEng);
#else
			sprintf(sTr, Frmt51, (pRBI+l)->Name);
		#ifndef	WINENCODE
			Recoding( cd_dos, cd_win, sTr );
		#endif
#endif
			TreeCtrlItem.item.pszText = sTr;
			TreeCtrlItem.item.lParam = (*pIndex)++;
			m_CIBsTree.InsertItem(&TreeCtrlItem);
		}
#endif
		*pBelngs= (int)(pRBI+l)->BaseId;
		if(old_CIB_is_install == 1){
			if(memcmp(pCIB_Info->Bases[0], "0", 2))
			{
				if(one == -1 && *pBelngs == atoi(pCIB_Info->Bases[0]))
				{
					one+=2;
					if(one == pCIB_Info->ComplectCount/2){
						pBelngs++;
						*pBelngs= (int)(pRBI+l)->Weight;
#ifdef RD_AS_ETALON
						*p_bFindNext= FALSE;
#endif
						*p_bAutoInstall= TRUE;
						break;
					}
				}else if(one > 0){
					int sgmnt= atoi(pCIB_Info->Bases[one]);
					if(*pBelngs == sgmnt){
						one++;
					}else if(sgmnt <= *pBelngs)
					{
						one= -2;
					}else
						ppHDDs[(*pIndex)/MAX_HDD_COUNT].currentWeight[l*2] *= -1;

					if(one == pCIB_Info->ComplectCount/2){
						pBelngs++;
						*pBelngs= (int)(pRBI+l)->Weight;
#ifdef RD_AS_ETALON
						*p_bFindNext= FALSE;
#endif
						*p_bAutoInstall= TRUE;
						break;
					}
				}else{
					//ppHDDs[indx/MAX_HDD_COUNT].currentWeight[l*2]
					(*pBelngs)
						*= -1;
				}
			}
		}
		pBelngs++;
		*pBelngs= (int)(pRBI+l)->Weight;
		pBelngs++;
	}
#ifdef RD_AS_ETALON
	for(l++; l < RBIcount; l++)
		ppHDDs[(*pIndex)/MAX_HDD_COUNT].currentWeight[l*2] = -1;
#else
	for(l++;
		l < RBIcount && pHDD->FindBaseInfo(here[l], *(pRBI+l)) == sizeof(BaseInfo);
		l++){
		*pBelngs= (int)(pRBI+l)->BaseId;
		pBelngs++;
		*pBelngs= (int)(pRBI+l)->Weight;
		pBelngs++;
	}
#endif

	Index *aux = pHDD->FindIndex("Aux");
	Stream *compStr = aux->Open("Comp");

	ppHDDs[(*pIndex)/MAX_HDD_COUNT].bws = new BaseWeight[compStr->Length()];
	compStr->Read(ppHDDs[(*pIndex)/MAX_HDD_COUNT].bws, compStr->Length());
	ppHDDs[(*pIndex)/MAX_HDD_COUNT].bwcount = compStr->Length()/sizeof(BaseWeight);
	aux->Close(compStr);

	for(l= 0; l < (long)ppHDDs[(*pIndex)/MAX_HDD_COUNT].bwcount; l++){
		Recoding( cd_dos, cd_win, (ppHDDs[(*pIndex)/MAX_HDD_COUNT].bws+l)->name );
	}

	delete str;
	delete here;

	if(old_CIB_is_install == 1
		&& ((!(l= memcmp(pCIB_Info->Bases[0], "0", 2)) && RBIcount < MAXIMUM_COUNT_SEGS)
				|| (l && one != pCIB_Info->ComplectCount/2))){
		m_CIBsTree.DeleteItem(*p_hRoot);
		delete pHDD;
		pHDD= NULL;
		*pIndex = 0;
		m_SpacePrnt= NULL;
		memset(ppHDDs->currentWeight, 0, (256+256)*sizeof(int));
	}else{
		if(old_CIB_is_install == 1){
#ifdef RD_AS_ETALON
			*p_bFindNext= FALSE;
#endif
			*p_bAutoInstall= TRUE;
			if(!l)
				one= RBIcount;
		}
		ppHDDs[(*pIndex)/MAX_HDD_COUNT].pHDD= pHDD;
#ifndef RD_AS_ETALON
		if(pbi)
			ppHDDs[(*pIndex)/MAX_HDD_COUNT].LastUpdate= pbi->LastUpdate;
#endif
		pHDD= NULL;
		*pIndex = ((*pIndex)/MAX_HDD_COUNT) * MAX_HDD_COUNT + MAX_HDD_COUNT;
		pGSScreen->OtherShowMessage(Msg_61);
	}
	return one;
}

void CTestBreeder32Dlg::TestedHaspOnHDD(	char *pBff, PDWORD pdwMediaID, PWORD pret,
											int indx, char *LoginReplicator1,
											LPPL_IMPORT_COMPLECT_DATA *ppList)
{
#ifndef TEST_HASP
	pHDD->textFile->m_pCryptoTag += sizeof(long);
#ifndef RD_AS_ETALON
	*ppList= ppHDDs[indx/MAX_HDD_COUNT].pList;
#endif
#endif
	  local_sscanf2( pHDD->textFile->m_pCryptoTag, (PDWORD)pBff, (PDWORD)pBff+1);
	  local_sprintfX(pBff, *((PDWORD)pBff) ^ *pdwMediaID, *((PDWORD)pBff+1) ^ *pdwMediaID);
	  m_pLoginDlg->m_Login= pBff;
	  m_pLoginDlg->m_Password= pBff;
	  if(pHDD->IsHDD() && (*pret= pl_Get_InstalledCIBsFromInstalledDisk((char*)(LPCTSTR)m_pLoginDlg->m_Login,
				(char*)LoginReplicator1, pHDD->m_pUIDBFileName,
#ifndef RD_AS_ETALON
				&ppHDDs[indx/MAX_HDD_COUNT].pList
#else
				&pList
#endif
				)) == (WORD)-35){
		  *pret= (WORD)LOOK_HDD_NOT_HASP;
	  }
#ifndef RD_AS_ETALON
	  else{
#ifdef ONLY_DISTR_WITH_KEY
		  *ppList= ppHDDs[indx/MAX_HDD_COUNT].pList;
#else
		  if(!*pret){
#ifndef TEST_HASP
			  WORD wSuccessCount, wTryCount;
			  if(!(*((CTestBreeder32App*)AfxGetApp())->imp_HaspComplectState)
	((WORD)(*returnID_CIB(pCurrCIBs->Alias) >> (32-7)), &wSuccessCount, &wTryCount)
						&& wSuccessCount)
				*pret= 277;

			  LPPL_IMPORT_COMPLECT_DATA pList= *ppList;
			  *ppList= ppHDDs[indx/MAX_HDD_COUNT].pList;
			  ppHDDs[indx/MAX_HDD_COUNT].pList= pList;
#endif
			  pl_FreeImportedComplectList(*ppList);
		  }
		  *ppList= NULL;
#endif
	  }
#endif
	  if(*ppList != NULL){
		pl_FreeImportedComplectList(*ppList);
		*ppList= NULL;
	  }
#ifndef TEST_HASP
	pHDD->textFile->m_pCryptoTag -= sizeof(long);
#endif
}

bool CTestBreeder32Dlg::check_version_All()
{
	if(!pHDD->check_version())
		return false;

	((CTestBreeder32App*)AfxGetApp())->Log ("Данные ищем в каталоге ");
	((CTestBreeder32App*)AfxGetApp())->Log (FileName.GetBuffer (0));
	((CTestBreeder32App*)AfxGetApp())->Log ("\n");

	char	version_txt[ MAX_PATH ];
	strcpy (version_txt, FileName);
	*strrchr (version_txt, '\\') = '\0';
	strcat (version_txt, "\\data.vrs");

	UINT major = GetPrivateProfileInt( "Version info", "Major", 0, version_txt );
	UINT minor = GetPrivateProfileInt( "Version info", "Minor", 0, version_txt );
	UINT bugfix= GetPrivateProfileInt( "Version info", "Bugfix",0, version_txt );
	UINT overide=GetPrivateProfileInt( "Version info", "Override",0, version_txt );

	char buffer [32767], *ptr = buffer;
	buffer [0] = 0;
	UINT buffer_size = sizeof (buffer);
	GetPrivateProfileSection ("Log", buffer, buffer_size, version_txt);
	bool b_found = false;
	while (*ptr) {
		if (strstr (ptr, "EnableInstallationStatusSaving") == ptr) {
			b_found = true;
			break;
		}
		ptr += strlen (ptr) + 1;
	}
	if (b_found)
		LoggingStatus = GetPrivateProfileInt( "Log", "EnableInstallationStatusSaving", 1, version_txt );
	else
		LoggingStatus = -1;

	char log_str [128];
	sprintf (log_str, "Из файла data.vrs взято значение EnableInstallationStatusSaving=%ld\n", LoggingStatus);
	((CTestBreeder32App*)AfxGetApp())->Log (log_str);

	if ( major + minor + bugfix == 0 ) {
		major = pUR->version_info.major;
		minor = pUR->version_info.minor;
		bugfix= pUR->version_info.bugfix;
	}

	CString message;
	if ( pUR->version_info.major == major && pUR->version_info.minor == minor && pUR->version_info.bugfix == bugfix  ) {
		//стандартная установка данных
	} else
	if ((pUR->version_info.major < major) || (pUR->version_info.major == major && pUR->version_info.minor < minor) ||
		(pUR->version_info.major == major && pUR->version_info.minor == minor && pUR->version_info.bugfix < bugfix && overide)) {
		//версия дистрибутива новее, новая версия системы; или багфикс, но override
		message.LoadString(IDS_MSG_VERSION_NEW);
		((CTestBreeder32App*)AfxGetApp())->Log ("Сказали: ");
		((CTestBreeder32App*)AfxGetApp())->Log (message.GetBuffer (0));
		MessageBox(message);
		EndDialog(-1);
	} else
	if ( pUR->version_info.major == major && pUR->version_info.minor == minor && pUR->version_info.bugfix < bugfix  ) {
		//версия дистрибутива новее, багфигс
		message.LoadString(IDS_MSG_VERSION_BUGFIX);
		int mbresult = MessageBox(message,0,MB_YESNO);
		((CTestBreeder32App*)AfxGetApp())->TimeLog ("Задан вопрос: ");
		((CTestBreeder32App*)AfxGetApp())->Log (message.GetBuffer (0));
		((CTestBreeder32App*)AfxGetApp())->Log ("\n");
		if ( mbresult == IDYES || mbresult == IDCANCEL ) {
			((CTestBreeder32App*)AfxGetApp())->Log ("Пользователь выбрал 'Выход'\n");
			EndDialog(-1);
		}
	} else
	if ( pUR->version_info.major == major && pUR->version_info.minor == minor && pUR->version_info.bugfix > bugfix  ) {
		//версия дистрибутива старее
		message.LoadString(IDS_MSG_VERSION_OLDER);
		((CTestBreeder32App*)AfxGetApp())->Log ("Задан вопрос: ");
		((CTestBreeder32App*)AfxGetApp())->Log (message.GetBuffer (0));
		((CTestBreeder32App*)AfxGetApp())->Log ("\n");
		int mbresult = MessageBox(message,0,MB_YESNO);
		if ( mbresult == IDYES || mbresult == IDCANCEL ) {
			((CTestBreeder32App*)AfxGetApp())->Log ("Пользователь выбрал 'Выход'\n");
			EndDialog(-1);
		}
	} else
	if ( pUR->version_info.major > major || ( pUR->version_info.major == major && pUR->version_info.minor > minor )) {
		//версия дистрибутива полностью устаревшая
		message.LoadString(IDS_MSG_VERSION_EXIT);
		((CTestBreeder32App*)AfxGetApp())->Log ("Сказали: ");
		((CTestBreeder32App*)AfxGetApp())->Log (message.GetBuffer (0));
		MessageBox(message);
		return false;
	}
	return true;
}

LRESULT CTestBreeder32Dlg::OnFileOpen(WPARAM wParam, LPARAM lParam) 
{
	m_CIBsTree.ShowWindow(SW_HIDE);

	HTREEITEM hRoot, defSelect= 0;
	BOOL	bAutoInstall= FALSE;
	m_CIBsTree.DeleteAllItems();
	static char BASED_CODE szFilter[] = "Installed HDD (*.ndt)|*.ndt|All Files (*.*)|*.*||";
	CFileDialog GetNDT( TRUE, NULL, NULL, OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT, szFilter, this);

	char *LoginReplicator1 = NULL;
	BOOL	bWorking, bFindNext;
	bool	bCanceled = false;
	CFileFind finder;
	int quiest, HDDCount, one = -1;

#ifndef RD_AS_ETALON
	DistribHASP_Ok= FALSE;
#endif
	do{
///////
		if (bCanceled)
			break;
		bWorking= FALSE;
		quiest= 0; HDDCount= 0;
		m_currSourcePath= old_install_path;

		if(m_OtherSelPath != "" && m_OtherSelPath[1] == '@'){
			iFnd= (FileName= CString(old_install_path)+"\\findmask.ndt").ReverseFind('\\');
			m_OtherSelPath= "";
			strcpy( distrib_path, old_install_path );
		}else {
			iFnd= (FileName= CString(old_install_path)+"\\data\\findmask.ndt").ReverseFind('\\');
			strcat( strcpy( distrib_path, old_install_path ), "\\data" );
		}

		int	indx= 0, FindNdt;

		pHDD= NULL;
		m_CIBsTree.DeleteItem(TVI_ROOT);
		deleteHDDs();
		CString LastFindMask, LastFindMaskForContinue;

char *p_defAllFullName= defAllFullName;

if(PassEntered)
p_defAllFullName= currInstallName;

		do {
			FindNdt= 0;
			if(	iFnd && (FileName= FileName.Left(iFnd+1)) != "" && (LastFindMask= FileName+p_defAllFullName) != "" && (bWorking = finder.FindFile(LastFindMask)) && (LastFindMaskForContinue= LastFindMask) != "") do {
				bFindNext = finder.FindNextFile();
				iFnd= (FileName= finder.GetFilePath()).ReverseFind('.');
				hRoot= 0;

				try {
				if(
			#ifdef	_GCD_CLIENT
					((*secondPilotDistribPath) == "" || (bFindNext= false)) &&
			#endif
					(pHDD= new PDDBase( FileName, O_RDONLY, 1000, 1000, 1000, (FILE *)pGSScreen)) != NULL && pHDD->IsOk()
			#ifdef	_GCD_CLIENT
					&& check_version_All()
			#endif
				){
					FindNdt++;
					WORD ret;
					DWORD dwMediaID= (DWORD)0x12563478;

					LoginReplicator1 = strdup("TGCENTER");
				#ifdef RD_AS_ETALON
					BYTE bff[LOGIN_SIZE_PER_BYTES+1];
					ret= 0;
				#else
					iHASPFind= TRUE;
					ret= (WORD)LOOK_HDD_NOT_HASP;
					LPPL_IMPORT_COMPLECT_DATA pList= ppHDDs[indx/MAX_HDD_COUNT].pList;
				#endif
					HDDCount++;
					char *pBff= (char*)bff;
					*(((char *)(LPCTSTR)FileName)+iFnd)= '\0';
				#ifdef TEST_HASP
					if(ret == (WORD)0)
						TestedHaspOnHDD(pBff, &dwMediaID, &ret, indx, LoginReplicator1, &pList);
				#endif

				#ifndef RD_AS_ETALON
					if(ret == (WORD)LOOK_HDD_NOT_HASP && pHDD->IsHDD()) {
						c_io_lseek(pHDD->textFile->GetFileHandle(), pHDD->textFile->PageSize - (pl_GetLoginOffest() + SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD)), SEEK_SET);
						c_io_read(pHDD->textFile->GetFileHandle(), pBff,	SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD));
						local_sscanf2( pHDD->textFile->m_pCryptoTag, (PDWORD)pBff+SIZE_CRYPTO_KYE_PER_DWORD, (PDWORD)pBff+1+SIZE_CRYPTO_KYE_PER_DWORD);
						Hash((PDWORD)pBff+SIZE_CRYPTO_KYE_PER_DWORD);
						local_sprintfX(	pBff, *((PDWORD)pBff) ^ *((PDWORD)pBff+SIZE_CRYPTO_KYE_PER_DWORD), *((PDWORD)pBff+1) ^ *((PDWORD)pBff+SIZE_CRYPTO_KYE_PER_DWORD+1));
						m_pLoginDlg->m_Login= pBff;
						m_pLoginDlg->m_Password= pBff;
						c_io_lseek(pHDD->textFile->GetFileHandle(), 0, SEEK_SET);
					}
				#else
					local_sscanf2( pHDD->textFile->m_pCryptoTag, (PDWORD)pBff, (PDWORD)pBff+1);
					local_sprintfX(pBff, *((PDWORD)pBff) ^ dwMediaID, *((PDWORD)pBff+1) ^ dwMediaID);
					m_pLoginDlg->m_Login= pBff;
					m_pLoginDlg->m_Password= pBff;
				#endif

				#ifdef OPEN_OTHER_PATH
					if(	m_pLoginDlg->DoModal() == IDOK ) {
				#else
					if( 1 ) {
				#endif
						pHDD->textFile->m_pCryptoTag -= sizeof(long);
					#ifdef RD_AS_ETALON
						if(pHDD->IsHDD()){
					#endif
							if( (
							#if !defined(RD_AS_ETALON) && !defined(ONLY_DISTR_WITH_KEY)
								((nRetCode= 0) || pList == ppHDDs[indx/MAX_HDD_COUNT].pList/*(pList= ppHDDs[indx/MAX_HDD_COUNT].pList) || TRUE*/) &&
							#endif
								((nRetCode= pl_Get_InstalledCIBsFromInstalledDisk((char*)(LPCTSTR)m_pLoginDlg->m_Login, (char*)LoginReplicator1, pHDD->m_pUIDBFileName,
							#ifndef RD_AS_ETALON
									&ppHDDs[indx/MAX_HDD_COUNT].pList)))
									&& nRetCode != -116
							#else
									&pList)))
							#endif
							)
								||
							#ifndef RD_AS_ETALON
								( (pList= ppHDDs[indx/MAX_HDD_COUNT].pList) == NULL && nRetCode != -116)
							#else
								pList == NULL
							#endif
							){
							#ifndef RD_AS_ETALON
								if(!DistribHASP_Ok)
									DistribHASP_Ok= -1;
							#endif
								*(((char *)(LPCTSTR)FileName)+iFnd)= '.';
								deleteOpenedBase(pHDD);
								pHDD= NULL;
							}else{
							#ifndef RD_AS_ETALON
								if(LastFindMask != ""){
									if(!ret)
										DistribHASP_Ok= 1;
								}
								if(nRetCode != -116)
									free(LoginReplicator1);
							#else
								free(LoginReplicator1);
								m_DefaultRD_Login= pList->pCIBs->pLogin;
							#endif
								BaseInfo bi;
								short notGl = 0;
								//long l;
								if (pHDD->FindBaseInfo(0, bi) != sizeof(BaseInfo))
									notGl = 1;
								hRoot= TVI_ROOT;
								one= MakeTreeNodes(	pList,&hRoot,&indx,&bi,ret,
								#ifdef RD_AS_ETALON
									&bFindNext,
								#endif
									&bAutoInstall);
								if(one == LOOK_HDD_NOT_HASP){
									// Стереть всё для повторной генерацию дерева но с HASP //
									finder.Close();
									deleteHDDs();
									delete pHDD;
									pHDD= NULL;
									LastFindMask= LastFindMaskForContinue;
									bFindNext= bWorking = finder.FindFile(LastFindMask);
									if(m_SpacePrnt){
										HTREEITEM hTmp0= m_CIBsTree.GetParentItem(m_SpacePrnt), hTmp1;
										while((hTmp1= m_CIBsTree.GetNextItem(hTmp0, TVGN_NEXT))){
											m_CIBsTree.DeleteItem(hTmp0);
											hTmp0= hTmp1;
										}
										m_CIBsTree.DeleteItem(hTmp0);
									}
									m_SpacePrnt= NULL;
									indx= 0;
									continue;
								}
							#ifndef RD_AS_ETALON
								if(nRetCode == -116){
									if(old_CIB_is_install == 1)
										bFindNext= FALSE;
								}else if(m_SpacePrnt && one){
									if(!ret)
										LastFindMask= "";
									int iCurrIndex= m_CIBsTree.GetItemData(m_SpacePrnt)/MAX_HDD_COUNT;
									LPPL_IMPORT_COMPLECT_DATA pNext= pList=	ppHDDs[iCurrIndex].pList;
									int		*pCurrentWeight, OkNext= FALSE,
									aa= m_CIBsTree.GetItemData(m_SpacePrnt) % MAX_HDD_COUNT;
									do{
										LPPL_IMPORT_CIB_DATA pCIBs= pNext->pCIBs;
										do{
											if(!--aa){
												// Проверка базы на обслуживание найденных КИБ-ов //
												pCurrentWeight=  ppHDDs[iCurrIndex].currentWeight;
												rrr= returnRD_Blngs(pCIBs->Alias);
												int ccc= rrr.Find('~');			
												if(ccc != -1){
													rrr= rrr.Left(ccc);
												}
												OkNext= atoi(rrr);
												while(*pCurrentWeight){
													if(*pCurrentWeight < OkNext){
														;
													}else if(strchr((LPCTSTR)rrr, ',')){
														rrr= (strchr((LPCTSTR)rrr, ',')+1);
														OkNext= atoi(rrr);
													}else{
														pCurrentWeight += 2;
														break;
													}
													pCurrentWeight += 2;
												}
												if(*(pCurrentWeight-2) != OkNext){
													HTREEITEM m_hNXT;
													if((m_hNXT= m_CIBsTree.GetNextItem(m_SpacePrnt, TVGN_NEXT))){
														aa= m_CIBsTree.GetItemData(m_SpacePrnt);
														m_CIBsTree.DeleteItem(m_SpacePrnt);
														m_SpacePrnt= m_hNXT;
														m_CIBsTree.SetItemData(m_SpacePrnt, aa);
														aa %= MAX_HDD_COUNT;
													}else{
														m_CIBsTree.DeleteItem(m_SpacePrnt);
														m_SpacePrnt= 0;
													}
												}
											}
										}while((pCIBs= (LPPL_IMPORT_CIB_DATA)pCIBs->next));
 									}while((pNext= (LPPL_IMPORT_COMPLECT_DATA)pNext->next));

									if(!m_SpacePrnt){
										pl_FreeImportedComplectList(pList);
										ppHDDs[iCurrIndex].pList= NULL;
										pList= NULL;
										m_CIBsTree.DeleteItem(hRoot);
										hRoot= NULL;
										*(((char *)(LPCTSTR)FileName)+iFnd)= '.';
									}else if(old_CIB_is_install == 1){
										bFindNext= FALSE;
									}else if(indx > MAX_HDD_COUNT && ppHDDs->pList == NULL)
										m_SpacePrnt= NULL;
								}else if(!ret){
									deleteOpenedBase(pHDD);
									pHDD= NULL;
									ret= -1;
									DistribHASP_Ok= -1;
								}
							#endif
							}
						#ifdef RD_AS_ETALON
							if(pList != NULL){
								pl_FreeImportedComplectList(pList);
								pList= NULL;
							}
						}else if(pHDD != NULL){
							*(((char *)(LPCTSTR)FileName)+iFnd)= '.';
							deleteOpenedBase(pHDD);
							pHDD= NULL;
						}else{
							*(((char *)(LPCTSTR)FileName)+iFnd)= '.';
						}
						#endif
					}
					}
					}catch(...){
					}
					if(pHDD && pHDD->baseStatus == 1){
						BeepWarning();
						MessageBox(Msg_62, Msg_76, MB_OK|MB_ICONERROR);
						((CTestBreeder32App*)AfxGetApp())->Log (Msg_62.GetBuffer (0));
						((CTestBreeder32App*)AfxGetApp())->Log ("\n");

						install_status = 2;
						send_internet_result ();

						EndDialog(-1);
						return -1;
					}
					if(!defSelect && old_CIB_is_install != 1 && hRoot){
						defSelect= hRoot;
					}
				#if !defined(RD_AS_ETALON)// && !defined(ONLY_DISTR_WITH_KEY
					if(!bFindNext && LastFindMask != "" && DistribHASP_Ok == -1){
						if(bWorking) finder.Close();
						bWorking = finder.FindFile(LastFindMask);
						LastFindMask= "";
						bFindNext= TRUE;
					}
			#endif
				}while(bFindNext);

				if(bWorking)
					finder.Close();
			}while(0);

			int goInstall= FALSE;

			if(bAutoInstall){
				goInstall= TRUE;
				m_OtherSelPath = "";

				m_CIBsTree.SelectItem(hRoot);
				if(m_sRet == "")
					m_sRet= old_install_path;
				else
					strcpy(old_install_path, m_sRet);

/*		if(one != RBIcount){
			preCheckMultiDisk(pHDD);
			if(	isLastFile(&pHDD->textFile->m_readed)
					||
				isLastFile(&pHDD->strFile->m_readed)
					||
				isLastFile(&pHDD->keyFile->m_readed)){
					goInstall= -1;
					m_CIBsTree.SelectItem(0);
					m_CIBsTree.DeleteItem(m_hPrnt);
					bAutoInstall= 0;
					indx = 0;
					memset(ppHDDs->currentWeight, 0, (256+256)*sizeof(int));
			}
		}*/
				if(goInstall != -1){
				#ifndef RD_AS_ETALON
					if(ppHDDs[m_baseIndx].pList){
				#endif
					pGSScreen->OtherShowMessage("");
					m_Progress.ShowWindow(SW_HIDE);
					m_BttnNext.EnableWindow(FALSE);
					KillTimer(m_uTimerID);
					m_SelectNext++;
					timeOn10sec= -1;
					m_uTimerID = SetTimer(0x451,2000,NULL);
					m_CIBsTree.EnableWindow(FALSE);
				#ifndef RD_AS_ETALON
					}else{
						m_BttnNext.EnableWindow();
						PrevDlgCtrl();
						PrevDlgCtrl();
					}
				#endif
				}
			}
	
			////////////////////////////////////////////////
			if(goInstall > 0)
				;
			else if(defSelect){
				m_OtherSelPath= "";
				m_CIBsTree.EnableWindow();

				if(PassEntered){
					m_CIBsTree.SelectItem(defSelect);
					//m_BttnNext.EnableWindow();
					OnNext();
				}else{
					m_BttnNext.EnableWindow();
					ShowControl(&m_BttnBrws);
					m_Static_73.EnableWindow();
					ShowControl(&m_Static_73);
					m_Msg70.EnableWindow();
					ShowControl(&m_Msg70);
					m_CIBsTree.SelectItem(defSelect);
					PrevDlgCtrl();
				}
			}else{
				int notBases= 1;
				if(m_OtherSelPath == "" && (*secondPilotDistribPath) == "")
					BeepWarning();
					//if(old_CIB_is_install == 1){
					if(HDDCount){
						//notBases= 0;
						//MessageBox(Bad_Installed_CIBs, "Внимание!", MB_OK|MB_ICONERROR);
					}
					if(m_OtherSelPath == "" && notBases){
						CPathMsgDlg ttt(this);
						ttt.m_Message= Bad_Installed_CIBs;
						if(HDDCount){
							if(goInstall == -1){
								ttt.m_Message= Msg_84;
							}
						}else if(!FindNdt)
							ttt.m_Message= NotFind_Installed_CIBs;

						if((*secondPilotDistribPath) == "" && ttt.DoModal() != IDOK) {
							install_status = 1;
							send_internet_result ();
							bCanceled = true;
							EndDialog(-1);
						} else{
							if((*secondPilotDistribPath) == "") {
								char *_path = strdup (ttt.m_NewPath.GetBuffer (0)), *_pos = strstr (_path, "\\GARANT\\DATA");
								long _len = strlen (_path);
								bool b_add = true;
								if (_pos == _path + _len - 12) {
									b_add = false;
									*_pos = 0;
									m_OtherSelPath = _path;									
								} else {
									_pos = strstr (_path, "\\GARANT");
									if (_pos == _path + _len - 7) {
										*_pos = 0;
										m_OtherSelPath = _path;
										b_add = false;
									}
								}
								if (b_add) {
									m_OtherSelPath= ttt.m_NewPath;
								}								
							}else{
								m_OtherSelPath= *secondPilotDistribPath;
								*secondPilotDistribPath= CString("");
							}
							if(m_OtherSelPath[1] == ':'){
								if (old_install_path [0] == '\\' || old_install_path [0] == 0) {
									strcpy (old_install_path, ttt.m_NewPath.GetBuffer (0));
								}
								//memcpy(old_install_path, (LPCTSTR)m_OtherSelPath, 2);
								//strcpy(old_install_path+2, "\\garant");
							}else{
								CString tmpPth= m_OtherSelPath;
								tmpPth += "\\garant";
								strcpy(old_install_path, (LPCTSTR)tmpPth);
							}
						}
					}else if(m_OtherSelPath != ""){
						if (m_OtherSelPath [0] == '\\') {
							CPathMsgDlg ttt(this);
							ttt.m_Message= NotFind_Installed_CIBs;
							if((*secondPilotDistribPath) == "" && ttt.DoModal() != IDOK) {
								install_status = 1;
								send_internet_result ();
								bCanceled = true;
								EndDialog(-1);
							} else {
								if((*secondPilotDistribPath) == "")
									m_OtherSelPath= ttt.m_NewPath;
								else{
									m_OtherSelPath= *secondPilotDistribPath;
									*secondPilotDistribPath= CString("");
								}
								if(m_OtherSelPath[1] == ':'){
									//memcpy(old_install_path, (LPCTSTR)m_OtherSelPath, 2);
									//strcpy(old_install_path+2, "\\garant");
								}else{
									CString tmpPth= m_OtherSelPath;
									char *_path = strdup (m_OtherSelPath.GetBuffer (0)), *_pos = strstr (_path, "\\GARANT\\DATA");
									long _len = strlen (_path);
									bool b_add = true;
									if (_pos == _path + _len - 12) {
										b_add = false;
										*_pos = 0;
										strcat (strcpy (old_install_path, _path), "\\garant");
									} else {
										_pos = strstr (_path, "\\GARANT");
										if (_pos == _path + _len - 7) {
											strcpy (old_install_path, _path);
											b_add = false;
										}
									}
									if (b_add) {
										tmpPth += "\\garant";
										strcpy(old_install_path, (LPCTSTR)tmpPth);
									}
								}
							}
						} else if(m_OtherSelPath[1] == ':') {
							if (old_install_path[1] == ':'){
								//memcpy(old_install_path, (LPCTSTR)m_OtherSelPath, 2);
								//old_install_path[2]= 0;
								m_OtherSelPath.SetAt(1, '!');
							} else {
								//memcpy(old_install_path, (LPCTSTR)m_OtherSelPath, 2);
								//old_install_path[2]= 0;
								//m_OtherSelPath.SetAt(1, '!');
							}
						}else if(m_OtherSelPath[1] == '!'){
							strcpy(old_install_path, (LPCTSTR)m_OtherSelPath);
							old_install_path[1]= ':';
							strcpy(old_install_path+strlen(old_install_path), "\\garant");
							m_OtherSelPath.SetAt(1, '#');
						}else if(m_OtherSelPath[1] == '#'){
							strcpy(old_install_path, (LPCTSTR)m_OtherSelPath);
							old_install_path[1]= ':';
							m_OtherSelPath.SetAt(1, '&');
						}else if(m_OtherSelPath[1] == '&'){
							strcpy(old_install_path, (LPCTSTR)m_OtherSelPath);
							old_install_path[1]= ':';
							m_OtherSelPath.SetAt(1, '@');
						}
					}
/*		}else if(notBases){
			MessageBox(NotFind_Installed_CIBs, "Внимание!", MB_OK|MB_ICONERROR);
			EndDialog(-1);
		}*/
		}
/////////////
	}while(m_OtherSelPath != "");

	if (bCanceled)
		return 0;

	m_CIBsTree.ShowWindow(SW_SHOW);

	return 0;
}


/////////////////////////////////////////////////////////////////////////////
// CInetAccessSettingsDlg dialog

CInetAccessSettingsDlg::CInetAccessSettingsDlg (CWnd* pParent /*=NULL*/)
	: CDialog (CInetAccessSettingsDlg::IDD, pParent) {
	//{{AFX_DATA_INIT(CInetAccessSettingsDlg)
	//}}AFX_DATA_INIT

	m_open_type = INTERNET_OPEN_TYPE_PRECONFIG;
	m_is_proxy_authentication = FALSE;
	m_open_query_flags = 0;
	m_proxy_address = "";
	m_proxy_port = "";
	m_proxy_login = "";
	m_proxy_password = "";
}

void CInetAccessSettingsDlg::DoDataExchange (CDataExchange* pDX) {
	CDialog::DoDataExchange (pDX);
	//{{AFX_DATA_MAP(CInetAccessSettingsDlg)
	DDX_Control (pDX, IDC_RADIO_OPEN_TYPE_PROXY,      m_rbOpenTypeProxy);
	DDX_Control (pDX, IDC_RADIO_OPEN_TYPE_PRECONFIG,  m_rbOpenTypePreconfig);
	DDX_Control (pDX, IDC_CHECK_PROXY_AUTHENTICATION, m_cbProxyAuthentication);
	DDX_Control (pDX, IDC_EDIT_PROXY_NAME,            m_edtProxyAddress);
	DDX_Control (pDX, IDC_EDIT_PROXY_PORT,            m_edtProxyPort);
	DDX_Control (pDX, IDC_EDIT_PROXY_LOGIN,           m_edtProxyLogin);
	DDX_Control (pDX, IDC_EDIT_PROXY_PASSWORD,        m_edtProxyPassword);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP (CInetAccessSettingsDlg, CDialog)
	//{{AFX_MSG_MAP(CInetAccessSettingsDlg)
	ON_BN_CLICKED (IDC_RADIO_OPEN_TYPE_DIRECT,     OnRbTypeDirect)
	ON_BN_CLICKED (IDC_RADIO_OPEN_TYPE_PROXY,      OnRbTypeProxy)
	ON_BN_CLICKED (IDC_RADIO_OPEN_TYPE_PRECONFIG,  OnRbTypePreconfig)
	ON_BN_CLICKED (IDC_CHECK_PROXY_AUTHENTICATION, OnCbProxyAuthentication)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP ()

/////////////////////////////////////////////////////////////////////////////
// CInetAccessSettingsDlg message handlers

BOOL CInetAccessSettingsDlg::OnInitDialog () {
	CDialog::OnInitDialog ();

	HICON m_hIcon = AfxGetApp()->LoadIcon (IDR_MAINFRAME);
	SetIcon (m_hIcon, TRUE);

	m_cbProxyAuthentication.SetCheck (m_is_proxy_authentication);

	if (m_open_type == INTERNET_OPEN_TYPE_PROXY) {
		this->SetProxyParamGroupState (TRUE);
		this->SetProxyAuthGroupState (m_is_proxy_authentication);
	} else {
		this->SetProxyGroupState (FALSE);
	}

	switch (m_open_type) {
		case INTERNET_OPEN_TYPE_PROXY:
			m_rbOpenTypeProxy.SetCheck (1);
			break;
		case INTERNET_OPEN_TYPE_DIRECT:
			m_rbOpenTypeDirect.SetCheck (1);
			break;
		case INTERNET_OPEN_TYPE_PRECONFIG:
			m_rbOpenTypePreconfig.SetCheck (1);
			break;
		default:
			m_rbOpenTypePreconfig.SetCheck (1);
			break;
	}

	m_edtProxyAddress.SetWindowText (m_proxy_address);
	m_edtProxyPort.SetWindowText (m_proxy_port);
	m_edtProxyLogin.SetWindowText (m_proxy_login);
	m_edtProxyPassword.SetWindowText (m_proxy_password);
	
	return FALSE;  // return TRUE unless you set the focus to a control
}

void CInetAccessSettingsDlg::OnOK () {
	UpdateWindow ();

	m_edtProxyAddress.GetWindowText (m_proxy_address);
	m_edtProxyPort.GetWindowText (m_proxy_port);
	m_edtProxyLogin.GetWindowText (m_proxy_login);
	m_edtProxyPassword.GetWindowText (m_proxy_password);

	if (m_rbOpenTypeProxy.GetCheck ()) {
		m_open_type = INTERNET_OPEN_TYPE_PROXY;

		CString str_err;

		try {
			if (m_proxy_address.IsEmpty ()) {
				str_err.Format (IDS_ERROR_PROXY_ADDR_EMPTY);
				throw std::exception ();
			} 

			if (m_proxy_port.IsEmpty ()) {
				str_err.Format (IDS_ERROR_PROXY_PORT_EMPTY);
				throw std::exception ();
			} else {
				CString digits = m_proxy_port.SpanIncluding ("0123456789");
				if (digits != m_proxy_port) {
					str_err.Format (IDS_BAD_PROXYPORT);
					throw std::exception ();
				}
			}

			if (m_cbProxyAuthentication.GetCheck ()) {
				if (m_proxy_login.IsEmpty ()) {
					str_err.Format (IDS_ERROR_PROXY_LOGIN_EMPTY);
					throw std::exception ();
				}
				if (m_proxy_password.IsEmpty ()) {
					str_err.Format (IDS_ERROR_PROXY_PASSWORD_EMPTY);
					throw std::exception ();
				}
			}
		} catch (...) {
			CString title;
			title.LoadString (IDS_ATTENTION);
			MessageBox (str_err.GetBuffer (), title.GetBuffer ());
			return;
		}
	} else if (m_rbOpenTypeDirect.GetCheck ()) {
		m_open_type = INTERNET_OPEN_TYPE_DIRECT;
	} else if (m_rbOpenTypePreconfig.GetCheck ()) {
		m_open_type = INTERNET_OPEN_TYPE_PRECONFIG;
	}

	m_open_query_flags = 0;

	CDialog::OnOK ();
}

void CInetAccessSettingsDlg::OnCancel () {
	CDialog::OnCancel ();
}

void CInetAccessSettingsDlg::OnRbTypeDirect () {
	m_edtProxyAddress.EnableWindow (FALSE);
	m_edtProxyPort.EnableWindow (FALSE);
}

void CInetAccessSettingsDlg::OnRbTypeProxy () {
	m_cbProxyAuthentication.EnableWindow (TRUE);
	this->SetProxyAuthGroupState (m_cbProxyAuthentication.GetCheck ());
	this->SetProxyParamGroupState (TRUE);
}

void CInetAccessSettingsDlg::OnRbTypePreconfig () {
	this->SetProxyGroupState (FALSE);
}

void CInetAccessSettingsDlg::OnCbProxyAuthentication () {
	m_is_proxy_authentication = !m_is_proxy_authentication;
	this->SetProxyAuthGroupState (m_is_proxy_authentication);
}

void CInetAccessSettingsDlg::SetProxyAuthGroupState (BOOL bState) {
	m_edtProxyLogin.EnableWindow (bState);
	m_edtProxyPassword.EnableWindow (bState);
}

void CInetAccessSettingsDlg::SetProxyParamGroupState (BOOL bState) {
	m_edtProxyAddress.EnableWindow (bState);
	m_edtProxyPort.EnableWindow (bState);
}

void CInetAccessSettingsDlg::SetProxyGroupState (BOOL bState) {
	m_cbProxyAuthentication.EnableWindow (bState);
	this->SetProxyParamGroupState (bState);
	this->SetProxyAuthGroupState (bState);
}

void CInetAccessSettingsDlg::set_settings (Internet::InternetAccessInfo& info) {
	m_open_type = info.access_type; 
	m_open_query_flags = info.open_query_flags; 

	m_proxy_address = info.proxy_info.host.c_str ();
	m_proxy_port = info.proxy_info.port.c_str ();
	m_proxy_login = info.proxy_info.login.c_str ();
	m_proxy_password = info.proxy_info.password.c_str ();
	m_is_proxy_authentication = (info.proxy_info.is_authentication)? TRUE : FALSE;
}

void CInetAccessSettingsDlg::get_settings (Internet::InternetAccessInfo& info) {
	info.access_type = m_open_type; 
	info.open_query_flags = m_open_query_flags; 

	info.proxy_info.host = m_proxy_address.GetBuffer ();
	info.proxy_info.port = m_proxy_port.GetBuffer ();
	info.proxy_info.login = m_proxy_login.GetBuffer ();
	info.proxy_info.password = m_proxy_password.GetBuffer ();
	info.proxy_info.is_authentication = (m_is_proxy_authentication == TRUE);
}

void GetNameOther(char *buf){
	ForceExt (buf, GB_KEY_EXT);
	impModifyName(buf);
}

#include "../../gkdb/src/ncpf.h"

int gTstTmp= 1;

extern "C" char *GetBasedExtFileName( char *, int );
extern int chk_sleep();

int c_io_update_create(const char *hTargetName, int writeMode)
{
	int rmHv= ACE_OS_O_TRUNC|ACE_OS_O_CREAT|writeMode|ACE_OS_O_BINARY;
	if(notTruncTarget){
		rmHv= c_io_open(hTargetName, rmHv & (~ACE_OS_O_TRUNC));
	}else{
		rmHv= c_io_open(hTargetName, rmHv);
	}
	return rmHv;
}

class BreederFile : public NCPagedFile {
public:
	void Create  ( short, bool bLockPath= false );
	BreederFile (LPPF_PARAM pAttrs) : NCPagedFile (pAttrs)
	{
		pPreCopy= 0;
		pPrePackedBuff= 0;
	}
	BreederFile (const char *n, int m, int npages, unsigned t=4 ):NCPagedFile(n,m,npages,t)
	{
		pPreCopy= 0;
		pPrePackedBuff= 0;
	}
	virtual void ROinitCntxt () {
		m_readed.pScreenCntxt= pContext;
	}
	void *CopyAs(const char *, int max_paged_file_per_bytes = MAX_BYTE_FILE_SIZE);
	void *CopyAs(const char *, int max_paged_file_per_bytes, int iAsUnpacked= 0);
	int Backup();
	BreederFile *pPreCopy;
	char *pPrePackedBuff;
protected:
	int chk_WGP(int fhR, char *pRBuff, int sizeR, GSScreen *pRContxt, int WriteError= 0);
	char directReadFileName[2048], directWriteFileName [2048];
	int chk_wr(int fhR, void *pRBuff, int sizeR, GSScreen *pRContxt){
		return chk_WGP(fhR, (char*)pRBuff, sizeR, pRContxt, 1);
	}
	int chk_getPage(void *fhR, void *pRBuff, int sizeR, GSScreen *pRContxt){
		return chk_WGP((int)fhR, (char*)pRBuff, sizeR, pRContxt, 2);
	}
	int backup2G(BreederFile *pTarget, int, int*, int*, char*, int, int l01= 0, int *l02= 0);
	int chk_backup2G(BreederFile *pTarget, int, int*, int*, char*, int, int, int*);
	int make_nxt_trgt(BreederFile *pTarget, int retFile)
	{
		if(nameZ) free(nameZ);
		nameZ= strdup(pTarget->FileName);
		GetBasedExtFileName( nameZ, retFile++ );
		int rmHv= c_io_update_create( nameZ, ACE_OS_O_WRONLY );
		pTarget->SetFileHandle(rmHv);
		allFHndls[rmHv]= 0;
		return retFile;
	}
	void end_backup2G(BreederFile *pTarget, int retFile, int *cpages, int *ii, char *pBuff, int iAsUnpacked, int wCnt= 0, int *RfN= 0)
	{
		if(iAsUnpacked) m_bkp_closed_pos= c_io_tell(*(pTarget->m_postFileHandles));
		_commit(*(pTarget->m_postFileHandles));
		c_io_close(*(pTarget->m_postFileHandles));
		allFHndls.del(*(pTarget->m_postFileHandles));
		if(pPreCopy == (BreederFile*)1 || ((!pPreCopy || pPreCopy == pTarget) && retFile > 1 && (*(long*)m_pCryptoTag > PageSize || PageSize == 512))){
			pTarget->SetFileHandle(-2);
			*(pTarget->m_postFileHandles)= -1;
			if(m_mode & 0x2000)	backup2G(pTarget, retFile, cpages, pTarget->m_postFileHandles, pBuff, iAsUnpacked, *(pTarget->m_postFileHandles),	RfN);
			else				backup2G(pTarget, retFile, cpages, pTarget->m_postFileHandles, pBuff, iAsUnpacked, wCnt,							RfN);
		}
		if(pPreCopy != (BreederFile*)1){
			int rmHv= c_io_open(pTarget->FileName, ACE_OS_O_RDWR|ACE_OS_O_BINARY);
			pTarget->SetFileHandle(rmHv);
			allFHndls[rmHv]= 0;
		}
		if(nameZ) free(nameZ); nameZ= 0;
	}
	int m_bkp_closed_pos;
	bool GetHardPage(int p0g, char *pBuff, int cpages)
	{
		if((!(pContext->rdStats= 0) && (pContext->lastReaded= &m_readed)
				&& !PagedFile::GetPage(p0g, pBuff+cpages) && (!m_readed.iPost || (pContext->rdStats= 1))))
		{
			if(pContext->rdStats == 0){
				free(pContext->pFileNameError);
				pContext->pFileNameError= strdup((char*)(m_readed.buf));
			}
			return true;
		}
		return false;
	}
};

#include "../../mrglib/src/gdbapi.h"

extern "C" int pl_ReMakeCryptoTags(	int, int, char **, char **, char *, char *);

	#define chk__getPage(zz, yy, xx, aa) (!(aa->rdStats= 0) && !((PagedFile*)zz)->GetPage(xx, yy) && chk_sleep() && !((PagedFile*)zz)->GetPage(xx, yy) && chk_sleep() && !((PagedFile*)zz)->GetPage(xx, yy) && chk_sleep() && (aa->rdStats= 1))
	#define chk__putPage(zz, yy, xx, aa) (!(aa->wrStats= 0) && !((PagedFile*)zz)->PutPage(xx, yy) && chk_sleep() && !((PagedFile*)zz)->PutPage(xx, yy) && chk_sleep() && !((PagedFile*)zz)->PutPage(xx, yy) && chk_sleep() && (aa->wrStats= 1))
	int BreederFile::chk_WGP(int fhR, char *pRBuff, int sizeR, GSScreen *pRContxt, int WriteError)
	{
		const char *pEMsg, *filename = 0;
		//int wrtOk= 0;
		do{
			if(WriteError == 3){
				pEMsg = pRContxt->pWriteErrorMsg;
				filename = strrchr (directWriteFileName, '\\') + 1;
				if(!chk__putPage(fhR, pRBuff, sizeR, pRContxt)){
					return 0;
				}
			}else if(WriteError == 2){
				pEMsg= pRContxt->pReadErrorMsg;
				filename = strrchr (directReadFileName, '\\') + 1;
				if(!chk__getPage(fhR, pRBuff, sizeR, pRContxt)){
					return 0;
				}
				return 1;
			}else if(WriteError){
				pEMsg = pRContxt->pWriteErrorMsg;
				filename = strrchr (directWriteFileName, '\\') + 1;
				if(		/*(!wrtOk ||  c_io_lseek(fhR, -wrtOk, ACE_OS_SEEK_CUR) != -1)
						&&*/ !((/*wrtOk= */c_io_write(fhR, pRBuff, sizeR)) != sizeR && (pRContxt->wrStats= 1))
					){
					return 0;
				}
			}
			/*{
				char msgBuf[4096];
				sprintf (msgBuf, pEMsg, filename);
				CString titlExit;
				titlExit.LoadString(IDS_ABOUTBOX);

				((CTestBreeder32App*)AfxGetApp())->TimeLog ("Задан вопрос: ");
				((CTestBreeder32App*)AfxGetApp())->Log (msgBuf);
				((CTestBreeder32App*)AfxGetApp())->Log ("\n");

				if(::AfxCtxMessageBox(((GWinScreen*)pRContxt)->m_pParent->GetSafeHwnd(), msgBuf, titlExit, MB_ICONERROR | MB_RETRYCANCEL) == IDCANCEL){
					((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Отмена\n");
					if(!(gb_delAllBkp_In_TerminateBreederThread= false)){
						delAllBkp (false, ((GWinScreen*)pRContxt)->m_pParent);
					}*/
					return 1;
			/*	} else {
					((CTestBreeder32App*)AfxGetApp())->TimeLog ("Пользователь ответил: Повтор\n");
				}
				pRContxt->wrStats= 0;
			}*/
		}while(1);
		return 1;
	}

extern "C" int _IsNT(void *pCurrent)
{
#ifdef _DEBUG
	return 1;
#else
	return ((GSScreen *)pCurrent)->isNT;
#endif
}
extern "C" int _IsNotSplit(void *pCurrent)
{
	return ((GSScreen *)pCurrent)->notSplit;
}

extern "C"{
	extern int pl_MakeLoginForBase(char *NullPage, char *pCrptInfo, PDWORD pKey);
	extern PDWORD pextCrptKy;
}

//#include "..\..\GPersn\src\PL_Proto.h"
extern "C" void add_crypto_tag(char **, int);
extern "C" int pl_ModifyBaseEx(int iKey, int iStr, int iNdt,
								char **ppBuff, char **ppBuff0, char *pKeyUP, int CryptoCount);

extern "C" int pl_ModifyBaseAsWorked(	PagedFile *pKey, PagedFile *pStr, PagedFile *pNdt,
										char *pKeyUp)
{
	int iRetV;

	pKey->m_pCryptoTag += sizeof(long);
	pStr->m_pCryptoTag += sizeof(long);

	if(!(iRetV= pl_ModifyBaseEx(	pKey->GetFileHandle(),
									pStr->GetFileHandle(),
									pNdt->GetFileHandle(),
									&pKey->m_pCryptoTag, &pStr->m_pCryptoTag,
									pKeyUp,
									MAX_CRYPTED_BLOCK_IN_WORK)))
	{
		pNdt->PageSize -= SIZE_CRYPTO_HEADER+SIZE_CRYPTO_HEADER
								+SIZE_CRYPTO_KYE_PER_DWORD*sizeof(DWORD);
	}
	pKey->m_pCryptoTag -= sizeof(long);
	pStr->m_pCryptoTag -= sizeof(long);

	if(pKey->m_pCryptoTag != 0) free(pKey->m_pCryptoTag);pKey->m_pCryptoTag= 0;
	if(pStr->m_pCryptoTag != 0) free(pStr->m_pCryptoTag);pStr->m_pCryptoTag= 0;
	pNdt->m_pCryptoTag= 0;

	return iRetV;
}

extern const char *getCopyingFormat();

extern "C" int CopyAsFromContext(void *pCurrent, char *source, char *target, int AsUnPacked)
{
	PagedFile *pPFKey, *pPFStr, *pPFNdt;
	char *pFnd= 0;
	PDDBase	*b1 = (PDDBase*)((GSScreen *)pCurrent)->pBase;

	static char *pCurrKeyTagGlobal= 0;closeFistHandle= 1;
	if(!PassEntered){
		pCurrKeyTagGlobal= (char*)malloc(4+*(long*)(b1->keyFile->m_pCryptoTag));
		memcpy(pCurrKeyTagGlobal, b1->keyFile->m_pCryptoTag, 4+*(long*)(b1->keyFile->m_pCryptoTag));
	}
	int iRetV= 1;
	rpRd= 0;
	pPFKey=pPFStr=pPFNdt= 0;

	if(b1 == 0 || !b1->IsHDD()){
		return -55;
	}
	if(!(AsUnPacked & 8)){
		char *pFnd= strrchr(source, '.');
		if(pFnd == 0){
			return -1;
		}
		*pFnd= '\0';
	}
	PDDBase	*b2=	(PDDBase*)((GSScreen *)pCurrent)->pUpdatedBase;
	if(b2 == 0){
		b2 = new PDDBase(target, ACE_OS_O_RDONLY|ACE_OS_O_CREAT|O_NOT_FAT, 0, 0, 0);
		if(b2->pOtherIndex == 0){
			if((b2->pOtherIndex= (LPG_OTHER_INDEX)calloc(
			(sizeof(b2->indTable)/sizeof(*b2->indTable)), sizeof(*b2->pOtherIndex))) == 0){
				return -1;
			}
			b2->pOtherNextIndex= b2->pOtherIndex;
		}
	}
	b1->SetScreenContext((GSScreen*)pCurrent);
	if(AsUnPacked & 8){
		iRetV= !create_base(target, (base_st *)source);
#ifndef	_GCD_CLIENT
		makedKey= ((base_st *)source)->key.PrmExt.pFileHandles[0];
		makedStr= ((pgfile_st *)&((base_st *)source)->str)->PrmExt.pFileHandles[0];
		makedNdt= ((base_st *)source)->ndt.PrmExt.pFileHandles[0];
#endif
		memcpy(	((base_st *)source)->ndt.attr_area,
	((PDDBase *)((GSScreen*)pCurrent)->pBase)->textFile->SystemPageBuf
			+ ((PDDBase *)((GSScreen*)pCurrent)->pBase)->textFile->PageSize/2,
#ifndef RD_AS_ETALON
							12*16-12-4
#else
		((PDDBase *)((GSScreen*)pCurrent)->pBase)->textFile->PageSize/2
#endif
							);
	}else{
	char pNewFileName[1024];
	PagedFile *pIndexKey= 0, *pIndexStr= 0, *pIndexAKey= 0, *pIndexAStr= 0;

	((CTestBreeder32Dlg*)((GWinScreen*)pCurrent)->m_pParent)->install_status= 2;

	b1->CopyPagedFilesByIndex(	"Aux.str", b2->keyFile->FileName,
								&pIndexAKey, &pIndexAStr,
								MAX_BYTE_FILE_SIZE,
								AsUnPacked & 1 || AsUnPacked & 2);
	if(pIndexAKey == 0 || pIndexAStr == 0){
		delete b2;
		b2= 0;
		((GSScreen *)pCurrent)->pUpdatedBase= 0;
	}else
	  {
			Index *zz= b1->FindIndex("Aux.str");
		/*{
			if(	((BreederFile*)zz->streams->file)->pPreCopy ){
				strcpy(pNewFileName, b2->keyFile->FileName);
				strcpy(pNewFileName, ForceExt (pNewFileName, "Aux.str"));
				ForceExt (pNewFileName, "str");
				impModifyName(pNewFileName);
				if(zz->streams->file->IsPacked() && (AsUnPacked & 1 || AsUnPacked & 2)){
					((BreederFile*)zz->streams->file)->CopyAs(pNewFileName, MAX_BYTE_FILE_SIZE, 1);
					*(int*)pIndexAKey->m_pCryptoTag= 1;
				}else
					((BreederFile*)zz->streams->file)->CopyAs(pNewFileName, MAX_BYTE_FILE_SIZE, 0);
			}
			pIndexAKey->m_pCryptoTag= 0;
			pIndexAStr->m_pCryptoTag= 0;
			if(*(pIndexAKey->m_postFileHandles) > 0) allFHndls.del(*(pIndexAKey->m_postFileHandles));delete pIndexAKey;
			if(*(pIndexAStr->m_postFileHandles) > 0) allFHndls.del(*(pIndexAStr->m_postFileHandles));delete pIndexAStr;
		}*/
		((BreederFile*)b1->strFile)->pPreCopy= (BreederFile*)-1;
		((BreederFile*)b1->textFile)->pPreCopy= (BreederFile*)-1;
		//((BreederFile*)b1->keyFile)->pPreCopy= (BreederFile*)-1;
		{
			pPFKey= ( PagedFile *)
				((BreederFile*)b1->keyFile)->CopyAs(b2->keyFile->FileName, MAX_BYTE_FILE_SIZE,
						AsUnPacked & 1 || AsUnPacked & 2);
			if(pPFKey != 0)
			  pPFStr= ( PagedFile *)
				((BreederFile*)b1->strFile)->CopyAs(b2->strFile->FileName, MAX_BYTE_FILE_SIZE,
						AsUnPacked & 1 || AsUnPacked & 2);
		}
		if(pPFKey != 0 && pPFStr != 0){
			pl_ReMakeCryptoTags(	pPFKey->GetFileHandle(), pPFStr->GetFileHandle(),
									&pPFKey->m_pCryptoTag, &pPFStr->m_pCryptoTag,
									pCurrKeyTagGlobal, b1->strFile->m_pCryptoTag);

			*strrchr(b1->textFile->FileName, '\0')= '.';
			if(AsUnPacked & 4){
				pPFNdt= ( PagedFile *)
					((BreederFile*)b1->textFile)->CopyAs(b2->textFile->FileName, MAX_BYTE_FILE_SIZE, 1);
			}else{
				pPFNdt= ( PagedFile *)
					((BreederFile*)b1->textFile)->CopyAs(b2->textFile->FileName);
			}
			if(pPFNdt){
				SetLicence( pPFNdt, b1->m_max_profiles, b1->m_max_num );
				pPFNdt->SkipWriteSystemBuff();
			}
			{
	b1->bLoadFatInOpened= 0;
	b1->CopyPagedFilesByIndex(	"Attrs.str", b2->keyFile->FileName,
								&pIndexKey, &pIndexStr,
								MAX_BYTE_FILE_SIZE,
								AsUnPacked & 1 || AsUnPacked & 2);
	if(pIndexKey == 0 || pIndexKey == 0)
		pPFNdt= 0;
	else{
		PagedFile *pIndexKey1, *pIndexStr1;
		b1->CopyPagedFilesByIndex(	"Context.str", b2->keyFile->FileName,
									&pIndexKey1, &pIndexStr1,
									MAX_BYTE_FILE_SIZE,
									AsUnPacked & 1 || AsUnPacked & 2);
		if(pIndexKey1 == 0 || pIndexKey1 == 0)
			pPFNdt= 0;
		else{
	PagedFile *pIndexKey2= 0, *pIndexStr2= 0, *pIndexKey3= 0, *pIndexStr3= 0;
	char	buf [1024], *pNNN, pFNN[]= "NFContxt.str";
	int oo, sss;
	memcpy(buf, b1->textFile->FileName, (oo= strrchr(b1->textFile->FileName, '.') - b1->textFile->FileName + 1));
	memcpy(buf+oo, "NWCntxt", 8);
	GetNameOther(buf);
	if((sss= c_io_open(buf, ACE_OS_O_RDONLY | ACE_OS_O_BINARY)) != -1){
		  c_io_close(sss);
		  b1->CopyPagedFilesByIndex(	pFNN, b2->keyFile->FileName,
										&pIndexKey3, &pIndexStr3,
										MAX_BYTE_FILE_SIZE, AsUnPacked & 1 || AsUnPacked & 2);
		  if(pIndexKey3 == 0 || pIndexKey3 == 0)
			  ;
		  else
			b1->CopyPagedFilesByIndex(	(pNNN= "NWCntxt.str"), b2->keyFile->FileName,
										&pIndexKey2, &pIndexStr2,
										MAX_BYTE_FILE_SIZE, AsUnPacked & 1 || AsUnPacked & 2);
	}else{
		memcpy(buf+oo, "NBCntxt", 8);
		GetNameOther(buf);
		if((sss= c_io_open(buf, ACE_OS_O_RDONLY | ACE_OS_O_BINARY)) != -1){
		  c_io_close(sss);
		  b1->CopyPagedFilesByIndex(	pFNN, b2->keyFile->FileName,
										&pIndexKey3, &pIndexStr3,
										MAX_BYTE_FILE_SIZE, AsUnPacked & 1 || AsUnPacked & 2);
		  if(pIndexKey3 == 0 || pIndexKey3 == 0)
			  ;
		  else
			b1->CopyPagedFilesByIndex(	(pNNN= "NBCntxt.str"), b2->keyFile->FileName,
										&pIndexKey2, &pIndexStr2,
										MAX_BYTE_FILE_SIZE, AsUnPacked & 1 || AsUnPacked & 2);
		}
	}
		  if(sss != -1 && (pIndexKey3 == 0 || pIndexKey3 == 0 || pIndexKey2 == 0 || pIndexKey2 == 0))
			pPFNdt= 0;
		  else{
			void *pRet= (void *)-1;
			if(	sss != -1 && ((BreederFile*)zz->streams->file)->pPreCopy ){
				strcpy(pNewFileName, b2->keyFile->FileName);
				strcpy(pNewFileName, ForceExt (pNewFileName, "Aux.str"));
				ForceExt (pNewFileName, "str");
				impModifyName(pNewFileName);
				if(zz->streams->file->IsPacked() && (AsUnPacked & 1 || AsUnPacked & 2)){
					pRet= ((BreederFile*)zz->streams->file)->CopyAs(pNewFileName, MAX_BYTE_FILE_SIZE, 1);
					*(int*)pIndexAKey->m_pCryptoTag= 1;
				}else
					pRet= ((BreederFile*)zz->streams->file)->CopyAs(pNewFileName, MAX_BYTE_FILE_SIZE, 0);
			}
			pIndexAKey->m_pCryptoTag= 0;
			pIndexAStr->m_pCryptoTag= 0;
			if(*(pIndexAKey->m_postFileHandles) > 0) allFHndls.del(*(pIndexAKey->m_postFileHandles));delete pIndexAKey;
			if(*(pIndexAStr->m_postFileHandles) > 0) allFHndls.del(*(pIndexAStr->m_postFileHandles));delete pIndexAStr;

			if(pRet){
				if(AsUnPacked & 1 || AsUnPacked & 2){
					rpRd++;
#ifdef _DEBUG
	  ::OutputDebugString("\nБроза и прерывание установки распаковкой НЕ убивает поток копирования !\n");
#endif
				}/*else if(!(AsUnPacked & 1) && ((BreederFile*)b1->keyFile)->pPreCopy)
					pRet= ((BreederFile*)b1->keyFile)->CopyAs(pNewFileName,MAX_BYTE_FILE_SIZE,0);*/
			}
			if(	pRet && !(AsUnPacked & 1) && ((BreederFile*)b1->FindIndex("Attrs.str")->file)->pPreCopy ){
				strcpy(pNewFileName, b2->keyFile->FileName);
				strcpy(pNewFileName, ForceExt (pNewFileName, "Attrs.str"));
				ForceExt (pNewFileName, "key");
				impModifyName(pNewFileName);
				pRet= ((BreederFile*)b1->FindIndex("Attrs.str")->file)->CopyAs(	pNewFileName, 
												MAX_BYTE_FILE_SIZE,
												AsUnPacked & 1 || AsUnPacked & 2);
			}
			if( pRet && ((BreederFile*)b1->FindIndex(pFNN)->streams->file)->pPreCopy ){
				strcpy(pNewFileName, b2->keyFile->FileName);
				strcpy(pNewFileName, ForceExt (pNewFileName, pNNN));
				ForceExt (pNewFileName, "str");
				impModifyName(pNewFileName);
				pRet= ((BreederFile*)b1->FindIndex(pNNN)->streams->file)->CopyAs(	pNewFileName, 
												MAX_BYTE_FILE_SIZE, AsUnPacked & 1 || AsUnPacked & 2);
			}
			if(	pRet && ((BreederFile*)b1->FindIndex("Attrs.str")->streams->file)->pPreCopy ){
				strcpy(pNewFileName, b2->keyFile->FileName);
				strcpy(pNewFileName, ForceExt (pNewFileName, "Attrs.str"));
				ForceExt (pNewFileName, "str");
				impModifyName(pNewFileName);
				pRet= ((BreederFile*)b1->FindIndex("Attrs.str")->streams->file)->CopyAs(	pNewFileName, 
												MAX_BYTE_FILE_SIZE,
												AsUnPacked & 1 || AsUnPacked & 2);
			}
			if(	pRet && ((BreederFile*)b1->FindIndex("Context.str")->streams->file)->pPreCopy ){
				strcpy(pNewFileName, b2->keyFile->FileName);
				strcpy(pNewFileName, ForceExt (pNewFileName, "Context.str"));
				ForceExt (pNewFileName, "str");
				impModifyName(pNewFileName);
				pRet= ((BreederFile*)b1->FindIndex("Context.str")->streams->file)->CopyAs(	pNewFileName, 
												MAX_BYTE_FILE_SIZE,
												AsUnPacked & 1 || AsUnPacked & 2);
			}
			if(pRet && sss != -1){
				if(	pRet && ((BreederFile*)b1->FindIndex(pNNN)->streams->file)->pPreCopy ){
					strcpy(pNewFileName, b2->keyFile->FileName);
					strcpy(pNewFileName, ForceExt (pNewFileName, pNNN));
					ForceExt (pNewFileName, "str");
					impModifyName(pNewFileName);
					pRet= ((BreederFile*)b1->FindIndex(pNNN)->streams->file)->CopyAs(	pNewFileName, 
													MAX_BYTE_FILE_SIZE, AsUnPacked & 1 || AsUnPacked & 2);
				}
				if(pRet){
					pIndexKey2->m_pCryptoTag= 0;
					pIndexStr2->m_pCryptoTag= 0;
					pIndexKey3->m_pCryptoTag= 0;
					pIndexStr3->m_pCryptoTag= 0;
					if(*(pIndexKey2->m_postFileHandles) > 0) allFHndls.del(*(pIndexKey2->m_postFileHandles));delete pIndexKey2;
					if(*(pIndexStr2->m_postFileHandles) > 0) allFHndls.del(*(pIndexStr2->m_postFileHandles));delete pIndexStr2;
					if(*(pIndexKey3->m_postFileHandles) > 0) allFHndls.del(*(pIndexKey3->m_postFileHandles));delete pIndexKey3;
					if(*(pIndexStr3->m_postFileHandles) > 0) allFHndls.del(*(pIndexStr3->m_postFileHandles));delete pIndexStr3;
				}else
					return -65;
			}
			if(pRet){
				pIndexKey1->m_pCryptoTag= 0;
				pIndexStr1->m_pCryptoTag= 0;
				pIndexKey->m_pCryptoTag= 0;
				pIndexStr->m_pCryptoTag= 0;
				if(*(pIndexKey1->m_postFileHandles) > 0) allFHndls.del(*(pIndexKey1->m_postFileHandles));delete pIndexKey1;
				if(*(pIndexStr1->m_postFileHandles) > 0) allFHndls.del(*(pIndexStr1->m_postFileHandles));delete pIndexStr1;
				if(*(pIndexKey->m_postFileHandles) > 0) allFHndls.del(*(pIndexKey->m_postFileHandles));delete pIndexKey;
				if(*(pIndexStr->m_postFileHandles) > 0) allFHndls.del(*(pIndexStr->m_postFileHandles));delete pIndexStr;
			}else
				return -65;
	// Continue Copy ... //
	if(	((BreederFile*)b1->strFile)->pPreCopy ){
		if(pPFStr == ( PagedFile *)((BreederFile*)b1->strFile)->CopyAs(	b2->strFile->FileName, MAX_BYTE_FILE_SIZE,
														AsUnPacked & 2)){
			;
		}else{
			pPFStr= 0;
		}
	}
	if(	pPFStr ){
	  if(((BreederFile*)b1->textFile)->pPreCopy){
		pPFNdt= (PagedFile *)((BreederFile*)b1->textFile)->CopyAs(	b2->textFile->FileName,
													MAX_BYTE_FILE_SIZE, AsUnPacked & 4);
	  }
	  waitCopy= 0;
	}
	//////////////////////
		  }
		}
	}
			}
		}
		if(pPFKey == 0 || pPFStr == 0 || pPFNdt == 0)
		{
			delete b2;
			b2= 0;
			((GSScreen *)pCurrent)->pUpdatedBase= 0;
			iRetV= -65;
		}else if(
	#if defined(RD_AS_ETALON) || defined(NOT_RD)
			(iRetV= pl_ModifyBaseAsWorked(	pPFKey, pPFStr, pPFNdt, "Yaroslav"))
	#else
			pl_MakeLoginForBase(pPFNdt->SystemPageBuf, pCrptInfo, pextCrptKy)
			||
			(iRetV= pl_ModifyBaseAsWorked(	pPFKey, pPFStr, pPFNdt, pPFNdt->SystemPageBuf))
	#endif
			)
		{
			pPFKey->Delete(1);
			pPFStr->Delete(1);
			pPFNdt->Delete(1);
			delete b2;
			b2= 0;
			((GSScreen *)pCurrent)->pUpdatedBase= 0;
			delete pPFKey;
			delete pPFStr;
			delete pPFNdt;
		}else{
			delete pPFKey;
			delete pPFStr;
			delete pPFNdt;
		}
	  }
	}
	if(b2 != 0){
		((GSScreen *)pCurrent)->pUpdatedBase= 0;
		delete b2;
		b2= 0;
	}
	if(pFnd != 0)
		 *pFnd= '.';

	if(AsUnPacked & 8){
		((base_st *)source)->ndt.PrmExt.pScreenCntxt=
			((base_st *)source)->key.PrmExt.pScreenCntxt= 
				((pgfile_st*)&((base_st *)source)->str)->PrmExt.pScreenCntxt= pCurrent;
	}
	if(!iRetV/* && !isBakuped*/)
		iRetV= 55;

	return iRetV;
}

int PDDBase::IsHDD()
{
    if(textFile != 0){
        char *pFnd= 0;
        if(m_pUIDBFileName == 0)
            pFnd= strrchr(textFile->FileName, '.');
        if( (m_pUIDBFileName != 0 || pFnd != 0)
            && textFile->Exist() != -1 && textFile->SystemPageBuf != 0){

            if(m_pUIDBFileName == 0){
                strcpy(pFnd + sizeof(char), gbase_FilesExt[3]);
                m_pUIDBFileName= strdup(textFile->FileName);
            }
            int tst;
            char msgNxtFile[1024];
            sprintf(msgNxtFile,"<%s>",m_pUIDBFileName);

            while((tst= c_io_open(m_pUIDBFileName, ACE_OS_O_RDONLY)) == -1){
                if(((GSScreen *)(strFile->m_readed.pScreenCntxt))->ShowQuestionYesOrNo(msgNxtFile)){
                    if(pFnd != 0) strcpy(pFnd + sizeof(char), GB_NDT_EXT);
                    return 0;
                }
            }
            if(pFnd != 0) strcpy(pFnd + sizeof(char), GB_NDT_EXT);
            c_io_close(tst);
            return 1;
        }
        return 0;
    }
    return textFile->Exist();
}

extern "C" void pl_OpenBase (LPPF_PARAM pKey, LPPF_PARAM pStr, char** keyTag, char** strTag, char** ndtTag);

PagedFile *makePagedFile(const char *name, int omode)
{
	if(!omode){
		return new BreederFile(name, omode, 2000);
	}
	return new PagedFile(name, omode);
}

PDDBase::~PDDBase()
{
	if(textFile0)
		free(textFile0);
	if(textFile1)
		free(textFile1);
	if(textFile2)
		free(textFile2);

	if(m_pUIDBFileName != 0){
        free(m_pUIDBFileName);
    }

	Base::FreeIndices ();

	if(pOtherIndex){
		pOtherNextIndex= pOtherIndex;
		while(pOtherNextIndex->pKey){
			if(pOtherNextIndex->pStreamFile){
				pOtherNextIndex->pStreamFile->file->m_pCryptoTag= 0;
				delete pOtherNextIndex->pStreamFile;
			}
			pOtherNextIndex->pKey->m_pCryptoTag= 0;
			delete pOtherNextIndex->pKey;
			pOtherNextIndex++;
		}
		free(pOtherIndex);
		pOtherNextIndex= pOtherIndex= 0;
	}
}

PDDBase::PDDBase(const char *n,int m,int kc, int sc, int nc, FILE *stf) : Base ()
{
	textFile0= textFile1= textFile2= 0;
	//initMultiIndex(n,m,kc,sc,nc,stf);
	pOtherNextIndex = pOtherIndex = 0;
	curr_mode = 0;
	bLoadFatInOpened = 1;
	{
		char	buf [1024];
		strcpy(buf, n);
		m_iFirstCD= 0;
		for(int ii= 0; ii < MAX_NDT_DISK_COUNT; ii++){
			m_iFirstKeyHandleOnCD[ii]= -1;
			m_iFirstStrHandleOnCD[ii]= -1;
		}
		if (nc == -1)
			nc = DEFAULT_NDT_CACHE;
		else if(!nc) {
			if(m & O_NOT_FAT)
				bLoadFatInOpened= 0;
		}

	#ifdef RESTORE_HDD
		m |= ACE_OS_O_RDWR;
	#endif
			
		docInd= 0;
		subNames= 0;

		if(!nc || (m & ACE_OS_O_CREAT))
			textFile  = makePagedFile(ForceExt (buf, GB_NDT_EXT), m & ~(ACE_OS_O_CREAT));
		else
		textFile  = new BreederFile(ForceExt (buf, GB_NDT_EXT), m & ~(ACE_OS_O_CREAT), nc);
		m_iFirstCD= textFile->m_readed.currentDisk= 0;
		reConnectKeyAndStr( n, m);
		if(m & ACE_OS_O_CREAT){
		}else if(	textFile->IsOk() && keyFile->IsOk() && strFile->IsOk() )
		{
			pl_OpenBase(	&keyFile->m_readed, &strFile->m_readed,
							&keyFile->m_pCryptoTag, &strFile->m_pCryptoTag,
							&textFile->m_pCryptoTag);
		}else{
			keyFile->m_pCryptoTag= (char*)malloc(sizeof(long));
			strFile->m_pCryptoTag= (char*)malloc(sizeof(long));
			*(long*)keyFile->m_pCryptoTag= 0L;
			*(long*)strFile->m_pCryptoTag= 0L;
		}
		docInd2 = 0;
	}
	//////////////////////////////////
	keyFile->m_readed.pScreenCntxt = strFile->m_readed.pScreenCntxt = textFile->m_readed.pScreenCntxt = stf;
	keyFile->pContext= strFile->pContext= textFile->pContext = (GSScreen *)stf;
	curr_mode= m;
	if(keyFile->IsOpened()){
		if(!(keyFile->SignatureValid()))
		{
			textFile->Delete(); textFile0= textFile->SystemPageBuf;
			strFile->Delete(); textFile1= strFile->SystemPageBuf;
			keyFile->Delete(); textFile2= keyFile->SystemPageBuf;
		}else if((!FindIndex("Aux.str") || (bLoadFatInOpened= 0)
			|| !FindIndex("Attrs.str") || !FindIndex("Context.str") || !FindIndex("NWCntxt.str") || !FindIndex("NFContxt.str")))
		{
			delete textFile;
			textFile= 0;
		}
	}
	m_pUIDBFileName= 0;
}

#if defined (WIN32) || defined (GARANT_MPCXC)
  #ifdef	_GCD_CLIENT
	extern void	SetLicence( PagedFile* pNDT, int max_profiles, int max_num );
  #endif
	PagedFile *makePagedFile_afterGSplit(LPPF_PARAM pAttrs)
	{
		return new NCPagedFile(pAttrs);
	}

extern "C" int create_base_inAsCopy(void *pCntx, const char *destname, base_st *target)
{
	int iRetV= 0;
	iRetV= CopyAsFromContext(pCntx, (char*)target, (char*)destname, 8);
	return iRetV;
}
extern "C" void init_streams_cache(streamfile_st *, u_int32_t);

int open_pgfile_from_base(PagedFile *pClass, pgfile_st *pFile)
{
	short PageSz= pClass->PageSize >> 1;

	//memcpy(&pFile->PrmExt, &pClass->m_readed, sizeof(PF_PARAM));

	pFile->PrmExt.pFileHandles= pClass->m_postFileHandles;
	pFile->PrmExt.accesMode= pClass->m_mode;
	pFile->PrmExt.FileName= pClass->FileName;
	pFile->PrmExt.maxFile_per_bytes= pClass->m_max_paged_file_per_bytes;
	pFile->PrmExt.pFilePoss= pClass->m_postFilePoss;
	pFile->PrmExt.pHeader= pClass->SystemPageBuf;
	pFile->PrmExt.pUncompressBuffer= pClass->rbuf;
	pFile->PrmExt.pPackTable= (unsigned int*)pClass->pageOffs;
	pFile->PrmExt.PackArraySize= pClass->m_PackArraySize;
	if(pFile->PrmExt.PackArraySize && pClass->PageSize == 2048){
		c_io_lseek(pFile->PrmExt.pFileHandles[0], pClass->PageSize * 2, ACE_OS_SEEK_SET);
		pFile->PrmExt.pFilePoss[0]= 2;
	}
	pFile->PrmExt.MessageForNextFunc= pClass->m_MessageForNextFunc;
	pFile->PrmExt.CloseProcessFunc= pClass->m_CloseProcessFunc;
	pFile->PrmExt.pCrptTag= pClass->m_pCryptoTag;
	pFile->PrmExt.iPost= 1;

	pFile->pfhdr= (pfhdr_st *)pClass->SystemPageBuf;
	pFile->attr_area= pClass->SystemPageBuf + pClass->AttrOffs;
	for(pFile->pgpow= 0;PageSz; pFile->pgpow++, PageSz >>= 1);

	return 1;
}
extern "C" int preInitBase(base_st *pbase, unsigned long mode);
extern "C" int open_base(const char *, base_st *, u_int32_t);
extern "C" int open_base_from_base(void *pCurrent, base_st *pbase)
{
	unsigned long mode;
	PDDBase *pBase=(PDDBase*)((GSScreen*)pCurrent)->pBase;

	if(!pbase){
		pbase = (base_st *)ml_malloc(sizeof(base_st));
	}
	mode= OBSC_SEQSP | OBSC_LARGE;
	pbase->openMode= mode;
	if (!(mode & OB_NONDT)) {
		if(!open_pgfile_from_base(pBase->textFile, &pbase->ndt))
			return 0;
	}
	else pbase->ndt.hfile = -1;
	if(!open_pgfile_from_base(pBase->keyFile, &pbase->key))
		return 0;
	if(!open_pgfile_from_base(pBase->strFile, &pbase->str.pgfile))
		return 0;

	pbase->str.pgfile.PrmExt.pScreenCntxt=
		pbase->key.PrmExt.pScreenCntxt= pbase->ndt.PrmExt.pScreenCntxt
			= pBase->strFile->pContext;

	if(!preInitBase(pbase, mode))
		return 0;
	pbase->key.name= strdup(pBase->keyFile->FileName);
	return 1;
}

extern int garlink( Base*, ProgressScreen*, int, int, int, int, int, FILE*, DBCore::RelevancyTuneData* chg_rel_data, int);

extern "C" void otherCopyIndexs(void *pCntx, base_st *pbase)
{
	u_int32_t size;
	PDDBase *b1= (PDDBase*)((GSScreen *)pCntx)->pBase;
	pbase->pNextSubToms->pKey= (pgfile_st*)calloc(1, sizeof(pgfile_st));
	pbase->pNextSubToms->pStr= (streamfile_st*)calloc(1, sizeof(streamfile_st));
	if(!open_pgfile_from_base(b1->indTable[0]->file,
								pbase->pNextSubToms->pKey))
		return;
	pbase->pNextSubToms->pKey->name= strdup(b1->indTable[0]->file->FileName);
	if(!open_pgfile_from_base(b1->indTable[0]->streams->file,
								&pbase->pNextSubToms->pStr->pgfile))
		return;

	pbase->pNextSubToms->pStr->pgfile.PrmExt.pScreenCntxt=
		pbase->pNextSubToms->pKey->PrmExt.pScreenCntxt=
				b1->strFile->pContext;

	get_info(&pbase->pNextSubToms->pStr->pgfile, "FatSize",
				&pbase->pNextSubToms->pStr->fat_size);
	size = ((u_int32_t)(pbase->pNextSubToms->pStr->fat_size))
				<< pbase->pNextSubToms->pStr->pgfile.pgpow;
	pbase->pNextSubToms->pStr->fat = (fat_rec_type *)ml_malloc(size);
	memcpy(	pbase->pNextSubToms->pStr->fat,
			b1->indTable[0]->streams->Fat, size);
	init_streams_cache(pbase->pNextSubToms->pStr, pbase->openMode);
	pbase->pNextSubToms->pName= strdup(b1->indTable[0]->Name);
	pbase->pNextSubToms++;
}
extern "C" void otherCopyFat(void *pCntx, unsigned long *pOut, int sizeCpy)
{
	PDDBase *b1= (PDDBase*)((GSScreen *)pCntx)->pBase;
	if(!((GSScreen *)pCntx)->notSplit){
		memcpy(pOut, ((PDDBase*)((GSScreen *)pCntx)->pBase)->streamFile->Fat, sizeCpy);
	}
}

extern "C" int get_language();
#include "basemask.h"

extern "C" void PostGL(
#ifdef BRDR32
						base_st *targets,
#endif
						void *pCurrent, char* aBasePath, FILE* aLogFile, int iPacked)
{
	PDDBase* b;
	char strErr[]= "Error in Base after GSPLIT !";

	b = new PDDBase (&targets->key.PrmExt,
						&((pgfile_st*)((streamfile_st *)&targets->str))->PrmExt,
							&targets->ndt.PrmExt);
	if(b->pOtherIndex == 0){
		if((b->pOtherIndex= (LPG_OTHER_INDEX)calloc(
		(sizeof(b->indTable)/sizeof(*b->indTable)), sizeof(*b->pOtherIndex))) == 0){
			((GSScreen *)pCurrent)->ShowQuestionYesOrNo(strErr);
			delete b;
			return;
		}
		b->pOtherNextIndex= b->pOtherIndex;
	}
  #ifdef	_GCD_CLIENT
	SetLicence( b->textFile,
				((PDDBase*)((GSScreen *)pCurrent)->pBase)->m_max_profiles,
				((PDDBase*)((GSScreen *)pCurrent)->pBase)->m_max_num );
  #endif
	b->curr_mode= ACE_OS_O_RDWR;
	b->textFile->m_readed.pBase= b;
	b->strFile->m_readed.pBase= b;
	b->streamFile= new StreamFile (b->strFile, 0);
	b->streamFile->fatPages= targets->str.fat_size;
	b->streamFile->Fat= b->streamFile->m_deletedFat= (int gk_huge*)targets->str.fat;
	targets->pNextSubToms= targets->pSubToms;
	PagedFile *strFile;
	while(targets->pNextSubToms->pKey){
		b->pOtherNextIndex->pKey= makePagedFile_afterGSplit(&targets->pNextSubToms->pKey->PrmExt );
		strFile= makePagedFile_afterGSplit(&targets->pNextSubToms->pStr->pgfile.PrmExt );
		b->pOtherNextIndex->pStreamFile= new StreamFile (strFile, 0);
		b->pOtherNextIndex->pStreamFile->Fat= b->pOtherNextIndex->pStreamFile->m_deletedFat
			= (int gk_huge*)targets->pNextSubToms->pStr->fat;
		b->pOtherNextIndex->pStreamFile->fatPages= targets->pNextSubToms->pStr->fat_size;
		b->pOtherNextIndex->pStreamFile->Flags |= PF_MODIFIED;
		PagedFile   *pKeyTmp= b->pOtherNextIndex->pKey;
		StreamFile  *pStreamFileTmp= b->pOtherNextIndex->pStreamFile;
		if(!strcmp(targets->pNextSubToms->pName, "SubName.str")){
		  if(!b->FindIndexOther("Attrs.str", b->pOtherNextIndex)){
			((GSScreen *)pCurrent)->ShowQuestionYesOrNo(strErr);
			delete b;
			return;
		  }
		  b->pOtherNextIndex->pKey= pKeyTmp;
		  b->pOtherNextIndex->pStreamFile= pStreamFileTmp;
		  if(!b->FindIndexOther(targets->pNextSubToms->pName, b->pOtherNextIndex)){
			((GSScreen *)pCurrent)->ShowQuestionYesOrNo(strErr);
			delete b;
			return;
		  }
		}else if(!b->FindIndexOther(targets->pNextSubToms->pName, b->pOtherNextIndex)){
			((GSScreen *)pCurrent)->ShowQuestionYesOrNo(strErr);
			delete b;
			return;
		}
		// Не для Клона !! //
		b->pOtherNextIndex->pKey= pKeyTmp;
		b->pOtherNextIndex->pStreamFile= pStreamFileTmp;
		b->pOtherNextIndex++;
		/////////////////////
		free(targets->pNextSubToms->pName);
		targets->pNextSubToms++;
	}
	b->openIndicesForUpdate();
	free(targets->pSubToms);
	targets->pNextSubToms= targets->pSubToms= 0;

	((GSScreen *)pCurrent)->pBase= b;
	if ( b -> IsOk() ) {
		if (aLogFile) fprintf( aLogFile, "Add Menu... " );
		DBCore::RelevancyTuneData obj;
		garlink( b, (ProgressScreen*)pCurrent, get_language (),1,0,0,0,aLogFile, &obj,0);
		if (aLogFile) fprintf( aLogFile, "Ok.\n" );
		b -> SetReady( TID_GL );
		if(iPacked){
			char	*pStr= strdup(b->strFile->FileName),
					*pKey= strdup(b->keyFile->FileName);
			delete b;

			if (aLogFile) fprintf( aLogFile, "\nPack %s... ", pStr );
			int err=0;
            PagedFile *nf = new PagedFile ( pStr, ACE_OS_O_RDWR );
            if( !nf || !nf -> IsOk ( ) )
				err++;
            else{
				nf->pContext= (GSScreen*)pCurrent;
				// Архивацию в Бридере не исполльзуем if(nf->PackFile(nf->LastPage))
					err++;
			}
			if(err){
				if (aLogFile) fprintf( aLogFile, strErr);
				nf->Delete(1);
			}else{
				if (aLogFile) fprintf( aLogFile, "Ok");
				delete nf;
			}
			if (aLogFile) fprintf( aLogFile, "\nPack %s... ", pKey );
			err=0;
            nf = new PagedFile ( pKey, ACE_OS_O_RDWR );
            if( !nf || !nf -> IsOk ( ) )
				err++;
            else{
				nf->pContext= (GSScreen*)pCurrent;
				// Архивацию в Бридере не исполльзуем if(nf->PackFile(nf->LastPage))
					err++;
			}
			if(err){
				if (aLogFile) fprintf( aLogFile, strErr);
				nf->Delete(1);
			}else{
				if (aLogFile) fprintf( aLogFile, "Ok");
				delete nf;
			}
		}else{
#ifdef BRDR32
			StreamFile	*pStr= b->streamFile;
			PagedFile	*pKey= b->keyFile;
			b->pOtherNextIndex= b->pOtherIndex;
		  do{
			pStr->SaveFat ();
			pKey->flushpages(pKey->cpn);
			pStr->file->flushpages(pStr->file->cpn);
			pKey->cpn= 0;
			pStr->file->cpn= 0;
			*(long*)pKey->SystemPageBuf= BASE_DATA_VERSION_OUT;
			*(long*)pStr->file->SystemPageBuf= BASE_DATA_VERSION_OUT;
		  }while( (pKey=b->pOtherNextIndex->pKey)
					&&
				  (pStr= b->pOtherNextIndex->pStreamFile)
				    &&
					b->pOtherNextIndex++);
			b->textFile->flushpages(b->textFile->cpn);
			b->textFile->cpn= 0;

	#if defined(RD_AS_ETALON) || defined(NOT_RD)
			if(pl_ModifyBaseAsWorked(b->keyFile, b->strFile, b->textFile, (char*)pextCrptKy)){
				((GSScreen *)pCurrent)->ShowQuestionYesOrNo(strErr);
			}
    #else
			pl_MakeLoginForBase(b->textFile->SystemPageBuf, pCrptInfo, pextCrptKy);
			if(pl_ModifyBaseAsWorked(b->keyFile, b->strFile, b->textFile, b->textFile->SystemPageBuf)){
				((GSScreen *)pCurrent)->ShowQuestionYesOrNo(strErr);
			}
	#endif
			*(long*)b->textFile->SystemPageBuf= BASE_DATA_VERSION_OUT;
#endif
			delete b;
		}
	}else{
		((GSScreen *)pCurrent)->ShowQuestionYesOrNo(strErr);
		delete b;
	}
}
#endif

extern "C" 
{
#ifdef BRDR32
	extern char *pUnPackFrmt, *NotFreeSpace;
  #ifndef	_GCD_CLIENT
	extern int makedKey, makedStr, makedNdt, makedTmp;
  #endif
	extern unsigned long OtherDiskFreeSpace();
#endif
	int CIB_AsUpdated(void *pCurrent)
	{
		char tmpUnPackMsg[4096];
		PDDBase *b1= (PDDBase*)
								((GSScreen *)pCurrent)->pBase,
				*b2= (PDDBase*)
								((GSScreen *)pCurrent)->pUpdatedBase;
		int ret, UnPackSz= b1->GetSizeInKbytes(1), sBkKb= 0;
		if(!remoteInstall)
			sBkKb= inBkp;

		sprintf(	tmpUnPackMsg, pUnPackFrmt
					,(((GSScreen *)pCurrent)->notSplit -(b2 == 0 ? 0 : b2->GetSizeInKbytes()) )/1024
					,(UnPackSz -(b2 == 0 ? 0 : b2->GetSizeInKbytes()) )/1024
					, sBkKb+(OtherDiskFreeSpace()/1024));

		ret = Core::ParamManagerFactory::get ().get_long (regInstallAsPacked, -1);
		if (ret == -1) {
			ret = ((GSScreen *)pCurrent)->ShowQuestionYesOrNo(tmpUnPackMsg);
			stored_regInstallAsPacked= ret;
			stored_regInstallSize = UnPackSz;
		}
		if(!ret){
				((GSScreen *)pCurrent)->notSplit= UnPackSz;
		}
		return ret;
	}
}

void PDDBase::SetScreenContext(GSScreen* pNew)
{

	if(keyFile->PageSize){
		keyFile->m_readed.pScreenCntxt=keyFile->pContext= pNew;
	}
	if(strFile->PageSize){
		strFile->m_readed.pScreenCntxt=strFile->pContext= pNew;
	}
	if(textFile->PageSize){
		textFile->m_readed.pScreenCntxt=textFile->pContext= pNew;
	}
	if(pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp= pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pStreamFile
				&& pOtherNextIndexTmp->pStreamFile->file->PageSize){
				pOtherNextIndexTmp->pStreamFile->file->m_readed.pScreenCntxt
					=pOtherNextIndexTmp->pStreamFile->file->pContext= pNew;
			}
			if(pOtherNextIndexTmp->pKey->PageSize){
				pOtherNextIndexTmp->pKey->m_readed.pScreenCntxt
					=pOtherNextIndexTmp->pKey->pContext= pNew;
			}
			pOtherNextIndexTmp++;
		}
	}
}

int PDDBase::Backup()
{
	int iIsPacked= ((keyFile->IsOpened() && ((BreederFile*)keyFile)->Backup())
						|| (strFile->IsOpened() && ((BreederFile*)strFile)->Backup())
							|| (textFile->IsOpened() && ((BreederFile*)textFile)->Backup()));

	if(!iIsPacked && pOtherIndex)
	{
		LPG_OTHER_INDEX pOtherNextIndexTmp= pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pStreamFile && pOtherNextIndexTmp->pStreamFile->file->IsOpened() && ((BreederFile*)pOtherNextIndexTmp->pStreamFile->file)->Backup())
					return 1;
			if(pOtherNextIndexTmp->pKey->IsOpened() && ((BreederFile*)pOtherNextIndexTmp->pKey)->Backup())
				return 1;
			pOtherNextIndexTmp++;
		}
	}
	return iIsPacked;
}

void PDDBase :: RemovePagedFiles()
{
	if(keyFile->IsOpened()){
		keyFile->Delete(1);keyFile->SystemPageBuf= 0;
	}
	if(strFile->IsOpened()){
		strFile->Delete(1);strFile->SystemPageBuf= 0;
	}
	if(textFile->IsOpened()){
		textFile->Delete(1);textFile->SystemPageBuf= 0;
	}
	if(pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp= pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pStreamFile
				&& pOtherNextIndexTmp->pStreamFile->file->IsOpened()){
				pOtherNextIndexTmp->pStreamFile->file->Delete(1);
				pOtherNextIndexTmp->pStreamFile->file->SystemPageBuf= 0;
			}
			if(pOtherNextIndexTmp->pKey->IsOpened()){
				pOtherNextIndexTmp->pKey->Delete(1);
				pOtherNextIndexTmp->pKey->SystemPageBuf= 0;
			}
			pOtherNextIndexTmp++;
		}
	}
}

extern "C" int DefValCryptoTag;

void PDDBase :: CopyPagedFilesByIndex(	const char *name,
										const char *pNewBaseName,
										PagedFile** ppKey, PagedFile** ppStr,
										long max_paged_file_per_bytes,
										int iAsUnpacked)
{
	Index* pIndex= FindIndex(name);
	pIndex->file->m_pCryptoTag= (char*)&DefValCryptoTag;
	pIndex->streams->file->m_pCryptoTag= (char*)&DefValCryptoTag;
	char pNewFileName[1024];
	const char *pExt= strchr(name, '.');
	*ppKey= 0;
	*ppStr= 0;
	if(	pIndex && pExt && strcpy(pNewFileName, pNewBaseName)){
		strcpy(pNewFileName, ForceExt (pNewFileName, name));
		pIndex->file->pContext=
			pIndex->streams->file->pContext= keyFile->pContext;
		((BreederFile*)pIndex->streams->file)->pPreCopy= (BreederFile*)-1;
		ForceExt (pNewFileName, GB_KEY_EXT);
		impModifyName(pNewFileName);
		if(iAsUnpacked && (*ppKey= ( PagedFile *)((BreederFile*)pIndex->file)->CopyAs(pNewFileName,
										max_paged_file_per_bytes,pIndex->file->IsPacked())))
		{
		  strcpy(pNewFileName, pNewBaseName);
		  strcpy(pNewFileName, ForceExt (pNewFileName, name));
		  ForceExt (pNewFileName, GB_STR_EXT);
		  impModifyName(pNewFileName);
		  if((*ppStr= ( PagedFile *)((BreederFile*)pIndex->streams->file)->CopyAs(	pNewFileName,max_paged_file_per_bytes
																					, pIndex->streams->file->IsPacked()))){
				return;
		  }
		}else if(!iAsUnpacked || *ppKey){
	/////
	strcpy(pNewFileName, pNewBaseName);
	strcpy(pNewFileName, ForceExt (pNewFileName, name));
	ForceExt (pNewFileName, GB_KEY_EXT);
	impModifyName(pNewFileName);
	((BreederFile*)(pIndex->file))->pPreCopy= (BreederFile*)-1;
	if((*ppKey= ( PagedFile *)((BreederFile*)pIndex->file)->CopyAs(pNewFileName,max_paged_file_per_bytes,0))){
		strcpy(pNewFileName, pNewBaseName);
		strcpy(pNewFileName, ForceExt (pNewFileName, name));
		ForceExt (pNewFileName, GB_STR_EXT);
		impModifyName(pNewFileName);
		if((*ppStr= ( PagedFile *)((BreederFile*)pIndex->streams->file)->CopyAs(pNewFileName,max_paged_file_per_bytes,0))!= 0){
			return;
		}
	}
	/////
		}
	}
	if(rpRd && *ppKey){
		if(*((*ppKey)->m_postFileHandles) > 0) allFHndls.del(*((*ppKey)->m_postFileHandles));(*ppKey)->Delete(1);
		delete (*ppKey);
	}
	*ppKey= 0;
	*ppStr= 0;
}

PDDBase::PDDBase (LPPF_PARAM pKey, LPPF_PARAM pStr, LPPF_PARAM pNdt) : Base()
{
	m_iFirstCD= 0;
	for(int ii= 0; ii < MAX_NDT_DISK_COUNT; ii++){
		m_iFirstKeyHandleOnCD [ii] = -1;
		m_iFirstStrHandleOnCD [ii] = -1;
	}
	keyFile = new BreederFile (pKey);
	strFile = new BreederFile (pStr);
	textFile = new BreederFile (pNdt);
}

int BreederFile :: Backup()
{
	char *pBackupName= strdup(FileName), *pFind= strrchr(pBackupName, '.');
	if(pBackupName == 0)
		return 1;
	if(pFind == 0){
		free(pBackupName);
		return 1;
	}
	*pFind = '!';
#ifdef BRDR32
	*(int*)m_pCryptoTag= 0L;
#endif
	PagedFile *pBuckuped= (PagedFile *)CopyAs(pBackupName);
	if(pBuckuped == 0){
		free(pBackupName);
		return 1;
	}
	free(pBackupName);
	delete pBuckuped;
	return 0;
}

void *BreederFile :: CopyAs(const char *name, int max_paged_file_per_bytes)
{
	return CopyAs(name, max_paged_file_per_bytes, 0);
}
extern void makeErrorFilename(GSScreen *pContext, PagedFile *pCurrent, PagedFile *pTarget);
//extern int chk_putPage(void *fhR, void *pRBuff, int sizeR, GSScreen *pRContxt);

int BreederFile :: backup2G(BreederFile *pTarget, int retFile, int *cpages, int *ii, char *pBuff, int iAsUnpacked, int wCnt, int *RfN)
{
	char ttt[4000];
	if((PageSize > 512 && *(long*)m_pCryptoTag < PageSize) || retFile > 1){
		if(!nameZ) nameZ= strdup(pTarget->FileName);
		char	*pf0= strrchr (FileName, '\\'), *pf1= strrchr(pf0+1,'.'), *pf01= strrchr (pTarget->FileName, '\\'), *pf02, firstCh= pf01[1];
		pf01[1]= 0;

		if(iAsUnpacked)
			sprintf(ttt,"%s~%d,%d,%d]%s",pTarget->FileName,*ii,pTarget->Total,*cpages,pf0+1);
		else{
			if(m_mode & 0x2000){
				sprintf(ttt,"%s~%d;%d,%d,%d]%s", pTarget->FileName,	wCnt,	*RfN,pTarget->Total,*cpages,pf0+1);
			}else
				sprintf(ttt,"%s~%d'%d,%d,%d]%s", pTarget->FileName,	*ii,	*RfN,pTarget->Total,*cpages,pf0+1);
		}
		GetBasedExtFileName( ttt, retFile-1 );
		pf01[1]= firstCh;
		pf02= strrchr(ttt,'.');
		do{
			*(pf02--)=pf02[-1];
		}while(pf02[-1] != ']');
		if(!iAsUnpacked){
			pf02[-1]= '[';
		}
		*pf02='.';
		if(rename(nameZ, ttt)){
			pContext->wrStats= 1;
			return -1;
		}else{
			static bool gEnd_first_rename= true;
			if(gEnd_first_rename){
				gEnd_first_rename= false;
				Core::ParamManagerFactory::get ().set_long	(regInstallWithDisconnect, stored_regInstallWithDisconnect);
				Core::ParamManagerFactory::get ().set_long	(regInstallAsPacked, stored_regInstallAsPacked);
				Core::ParamManagerFactory::get ().set_long	(regInstallSize, stored_regInstallSize);
				Core::ParamManagerFactory::get ().set_string(regInstallLastCacheName, stored_regInstallLastCacheName);
			}
			ppPreInst2Gfiles[pcPreInst2Gfiles++]= strdup(ttt+(pf01-pTarget->FileName)+1);
		};
	}else{
		retFile= chk_backup2G(pTarget, retFile, cpages, ii, pBuff, iAsUnpacked, wCnt, RfN);
	}
	return retFile;
}

extern "C" int IsPostExist	(int, LPPF_PARAM);
extern "C" int IsPostExistL	(int, LPPF_PARAM, int);

int BreederFile :: chk_backup2G(BreederFile *pTarget, int retFile, int *cpages, int *ii, char *pBuff, int iAsUnpacked, int wCnt, int *RfN)
{
	int chk=retFile, p0g= 0, p1g, p2g, endF= 1, buffRPos, bkp, upRet= 0;
	char ntmp[256], *pExt;
	if(PageSize > 512 && *(long*)m_pCryptoTag < PageSize){
		chk= 0;
		upRet++;
	}
	while(endF){
		bkp= gbkp_files_count;
		strcpy(ntmp, strrchr (pTarget->FileName, '\\') + 1);
		GetBasedExtFileName( ntmp, chk );
		pExt=strchr(ntmp,'.')+1;
		while(bkp-- && strcmp(gbkp_files[bkp].pFullName+gbkp_files[bkp].offsExt,pExt));
		if(bkp > -1){
			pExt= gbkp_files[bkp].pFullName+gbkp_files[bkp].offsExt-1;
			while(*pExt-- != '~');pExt++;
			ppPreInst2Gfiles[pcPreInst2Gfiles++]= strdup(pExt);
			if(m_mode & 0x2000 && !iAsUnpacked){
				sscanf(pExt,"~%d;%d,%d,%d", &buffRPos,	&p0g, &p1g, &p2g);
				*ii= (buffRPos+COPY_BUFF_SIZE)/PageSize + 1;
			}else{
				if(iAsUnpacked)
					sscanf(pExt,"~%d,%d,%d", &p0g, &p1g, &p2g);
				else{
					sscanf(pExt,"~%d'%d,%d,%d", ii, &p0g, &p1g, &p2g);
					if(*ii < 0)
						buffRPos= -1;
					else
						buffRPos= ii[0]*PageSize-PageSize*(COPY_BUFF_SIZE/PageSize)-PageSize;
				}
			}
			pContext->AllCpd += FileSize (gbkp_files[bkp].pFullName) / 1024;
			free(gbkp_files[bkp].pFullName);
			gbkp_files_count--;
			gbkp_files[bkp].pFullName= gbkp_files[gbkp_files_count].pFullName;
			gbkp_files[bkp].offsExt= gbkp_files[gbkp_files_count].offsExt;
			if(!chk){
				c_io_close(*(pTarget->m_postFileHandles));
				allFHndls.del(*(pTarget->m_postFileHandles));
				pContext->AllCpd -= FileSize (pTarget->FileName) / 1024;
				unlink(pTarget->FileName);
			}
			chk++;
		}else
			endF=0;
		}
		if(p0g){
			pTarget->Total= p1g; *cpages= p2g; retFile= chk + upRet;
			if(iAsUnpacked){
				if(p0g > 0){
					*ii= p0g; 
					if(GetHardPage(p0g, pBuff, PageSize)) return -1;
				}else{
					pTarget->SetFileHandle(-2);
					*(pTarget->m_postFileHandles)= -1;
				}
			}else{
				if(buffRPos > 0){
					m_readed.buf= pBuff;
					((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= COPY_BUFF_SIZE;
					if(IsPostExistL((*RfN= p0g),&m_readed, buffRPos) == -1 || !IsPostExist(p0g,&m_readed)){
						((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= PageSize;
						pContext->rdStats= 1;
						return -1;
					}
					((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= PageSize;
				}else{
					pTarget->SetFileHandle(-2);
					*(pTarget->m_postFileHandles)= -1;
				}
			}
		}
	return retFile;
}

void	BreederFile :: Create ( short psize, bool)
{
	PageSize = psize;
	file= c_io_update_create( FileName, ACE_OS_O_RDWR );
	if (file == -1) {
		fprintf(stderr, "Cannot create file %s.\n", FileName);
		return;		// cannot be created
	}

	allFHndls[file]= 0;

	m_mode= ACE_OS_O_RDWR | ACE_OS_O_CREAT | ACE_OS_O_EXCL;
	if ( ( SystemPageBuf = (char *)calloc ( 2, PageSize ) ) == 0 )
		return;
	
	strcpy ( SystemPageBuf + 4, "Garant Database file. Copyright (C) 1990,96 Garant-Service" );

	((PagedFileHeader*)SystemPageBuf)->Signature = BASE_DATA_VERSION;
	((PagedFileHeader*)SystemPageBuf)->PageSize = psize;

	LastPage     = 0l;
	FreePage     = -1l;
	lastFreePage = -1l;
	AttrOffs     = sizeof(PagedFileHeader);
	Flags        = PF_MODIFIED;
	isPacked	 = 0;

	*m_postFileHandles= file;
	*m_postFilePoss= 0;

	initCache();
}

void *BreederFile :: CopyAs(const char *name, int max_paged_file_per_bytes, int iAsUnpacked)
{
	strcpy (directWriteFileName, name);
	if(!psrcRead){
		psrcRead= srcRead;
		szsrcRead= strrchr(FileName, '\\') - FileName;
		memcpy(srcRead,FileName,szsrcRead);
		srcRead[szsrcRead]= 0;
	}
	BreederFile *pTarget;
	do{
		if(!rpRd){
			if(gCopyKill) goto Error115;
			while(waitKill){
				Sleep(200);
			}
		}
  if(pPreCopy && pPreCopy != (BreederFile*)-1){
		pTarget= (BreederFile*)pPreCopy;
		makeErrorFilename(pContext, this, pTarget);
		if(max_paged_file_per_bytes == MAX_BYTE_FILE_SIZE)
			max_paged_file_per_bytes= m_max_paged_file_per_bytes;
		break;
  }else{
		pTarget= new BreederFile(defAllFullName, ACE_OS_O_RDWR, 1);
		pContext->lastReaded= &m_readed;
		pContext->lastReaded->iPost= 1;
		strcpy(pTarget->FileName,name);
		makeErrorFilename(pContext, this, pTarget);
		if(pTarget == 0)
			return 0;
		if(pTarget->m_mode == 0 && PageSize > 0){
			pTarget->Create(PageSize);
			if(pTarget->Flags != PF_MODIFIED)
				return 0;

			//pTarget->lastFreePage= tell(file);

			if( c_io_lseek(file, 0, ACE_OS_SEEK_SET) != 0l
				||
				 c_io_read(file, SystemPageBuf, sizeof(PagedFileHeader)) != sizeof(PagedFileHeader)
				 ||
				 c_io_lseek(file, PageSize, ACE_OS_SEEK_SET) != PageSize)
			{
					pContext->rdStats= 1;
					makeErrorFilename(pContext, this, pTarget);
					return 0;
			}
			if(!iAsUnpacked && ((PagedFileHeader*)SystemPageBuf)->TomPerPages == 0){
				max_paged_file_per_bytes= m_max_paged_file_per_bytes= MAX_BYTE_FILE_SIZE - COPY_BUFF_SIZE;
			}else if(max_paged_file_per_bytes == MAX_BYTE_FILE_SIZE)
				// Размер не указан - берём текущий //
				max_paged_file_per_bytes= m_max_paged_file_per_bytes;
			else
				((PagedFileHeader*)pTarget->SystemPageBuf)->TomPerPages=
					max_paged_file_per_bytes / PageSize;

			m_readed.iPost= ((PagedFileHeader*)SystemPageBuf)->TomPerPages;
			((PagedFileHeader*)SystemPageBuf)->TomPerPages=0;
			*(int*)SystemPageBuf= BASE_DATA_VERSION_OUT;

			if(c_io_lseek(pTarget->file, 0, ACE_OS_SEEK_SET) != 0l
				|| c_io_write(pTarget->file, SystemPageBuf, PageSize) != (int)PageSize)
			{
				pContext->wrStats= 1;
				goto Error114;
			}
			((PagedFileHeader*)SystemPageBuf)->TomPerPages= m_readed.iPost;
			m_readed.iPost= 1;
			pTarget->Flags &= ~PF_MODIFIED;
			if(isPacked){
				if(max_paged_file_per_bytes != m_max_paged_file_per_bytes || iAsUnpacked){
					memcpy(pTarget->SystemPageBuf, SystemPageBuf, PageSize);
					((PagedFileHeader*)pTarget->SystemPageBuf)->TomPerPages=0;
					if(m_mode & 0x1000)
						pTarget->PagedFile::DelAttr(ID_PACKED_NEW);
					else
						pTarget->PagedFile::DelAttr(ID_PACKED);
					pTarget->Flags &= ~PF_MODIFIED;
					if(	c_io_lseek(pTarget->file, 0, ACE_OS_SEEK_SET) ||
						c_io_write(pTarget->file, pTarget->SystemPageBuf, PageSize) != PageSize){
						pContext->wrStats= 1;
						goto Error114;
					}
				}else if(c_io_write(pTarget->file, pageOffs, m_PackArraySize)
						!= (int)m_PackArraySize){
					pContext->wrStats= 1;
					goto Error114;
				}
			}
			int rmHv= pTarget->GetFileHandle();
			if(pTarget->PageSize == 512){
				char *pPostBuff= pTarget->SystemPageBuf;
				delete pTarget;
				free(pPostBuff);
			}else
				delete pTarget;

			allFHndls.del(rmHv);

			pTarget= new BreederFile(name, ACE_OS_O_RDWR|ACE_OS_O_EXCL,1);
			if(pTarget == 0 || pTarget->m_mode == 0 || c_io_lseek(pTarget->GetFileHandle(), 0, ACE_OS_SEEK_SET) != 0){
				pContext->wrStats= 1;
				goto Error114;
			}
			allFHndls[pTarget->GetFileHandle()]= 0;
			*(int*)SystemPageBuf= BASE_DATA_VERSION;
			break;
		}else{
			if(PageSize < 1){
				pContext->wrStats= 1;
				goto Error114;
			}
			if(*(pTarget->m_postFileHandles) > 0) allFHndls.del(*(pTarget->m_postFileHandles));pTarget->Delete(1);
			delete pTarget;
		}
  }
	}while(1);

	int ii, cpages, retFile= 1, ok_Mesg, percnt;

	char	*pBuff=(char*)malloc(COPY_BUFF_SIZE);

if(checkOther){checkOther= 0;
	char ttt[4000], *pf0= strrchr(FileName,'\\'), *pf31= pf0, *pf01= strrchr(pTarget->FileName,'\\'), *pf02, chkC= '[', firstC= pf01[1];

	int chk, szNm= 0, fst= !removeOtherThis, dlf= 1, fnd_curr= 0;
	{
		pf01[1]= 0;
		if(iAsUnpacked){
			chkC= ']';
		}
		sprintf(ttt,"%s%[%s",pTarget->FileName,pf0+1);
		pf02= strrchr(ttt,'.');pf02[1]=pf02[2]=pf02[3]='?';
		do{
			*pf02--=pf02[-1];
			szNm++;
		}while(*pf02 != '[');
		pf01[1]= firstC;
		pf02[1]='.';
		pf02[0]= '*';
		{
			CFileFind finder;
			strcpy(stored_regInstallLastCacheName,strrchr(ttt,'\\'));
			if(finder.FindFile(ttt)) do{
				chk= finder.FindNextFile();
				ppPreInst2Gfiles[pcPreInst2Gfiles++]= pf0= strdup(finder.GetFileName());
				pf02= (char*)strrchr(pf0,'.');
				if(pf02[szNm] == 'n' || pf02[szNm] == 'N'){
					pf02=pf02;
					gbkp_files[gbkp_files_count].pFullName= strdup(finder.GetFilePath());
					gbkp_files[gbkp_files_count++].offsExt= (pf01-pTarget->FileName)+1+(pf02-pf0)+szNm;
				}else if(pf02[-1] != chkC) {
					if(fst){
						//не спрашиваем, http://mdp.garant.ru/pages/viewpage.action?pageId=543452094
						/*
						fst=0;
						CString tmpMS("Удалить неактуальные кэши установки этого комплекта ");
						if(iAsUnpacked){
							if(pContext->ShowQuestionYesOrNo((LPCTSTR)(tmpMS+"Упакованным ?")))
								dlf= 0;
						}else if(pContext->ShowQuestionYesOrNo((LPCTSTR)(tmpMS+"Распакованным ?")))
								dlf= 0;
						*/
						dlf = 1;
					}
					if(dlf){
						unlink(finder.GetFilePath());
						free(ppPreInst2Gfiles[--pcPreInst2Gfiles]);
					}
				}else{
					gbkp_files[gbkp_files_count].pFullName= strdup(finder.GetFilePath());
					gbkp_files[gbkp_files_count++].offsExt= (pf01-pTarget->FileName)+1+(pf02-pf0)+szNm;
					fnd_curr++;
				}
			}while(chk);
			finder.Close();

			strcpy(ttt+(pf01-pTarget->FileName)+1, bkpMask);
			fst= !removeOtherThis; dlf= 1;
			if(finder.FindFile(ttt)) do{
				chk= finder.FindNextFile();
				if(pcPreInst2Gfiles){
					szNm= pcPreInst2Gfiles;
					ppPreInst2Gfiles[pcPreInst2Gfiles++]= pf0= strdup(finder.GetFileName());
					while(szNm-- && strcmp(pf0,ppPreInst2Gfiles[szNm]));
					free(pf0);
					--pcPreInst2Gfiles;
				}else{
					szNm= -1;
				}
				if(szNm < 0){
					/*
					// не спрашивать, http://mdp.garant.ru/pages/viewpage.action?pageId=528421597
					if(fst){
						fst=0;
						if(pContext->ShowQuestionYesOrNo("Удалить неактуальные кэши установки иных комплектов ?"))
							 break;
					}
					*/
					fst = 0;
					unlink(finder.GetFilePath());
				}else{
					free(ppPreInst2Gfiles[szNm]);
					ppPreInst2Gfiles[szNm]= ppPreInst2Gfiles[pcPreInst2Gfiles-1];
					pcPreInst2Gfiles--;
				}
			}while(chk);
			finder.Close();
			while(pcPreInst2Gfiles--) free(ppPreInst2Gfiles[pcPreInst2Gfiles]);
			pcPreInst2Gfiles= 0;
			if (fnd_curr && (!PassEntered && (removeOtherThis || (MsgYesUseCache && pContext->ShowQuestionYesOrNo(get_app ()->get_rc_lang () == rl_Eng ? msgTsts_e : msgTsts))))) {
				Core::ParamManagerFactory::get ().set_long (regInstallAsPacked, -1);
				Core::ParamManagerFactory::get ().set_long (regInstallWithDisconnect, -1);
				while(gbkp_files_count--){
					unlink(gbkp_files[gbkp_files_count].pFullName);
					free(gbkp_files[gbkp_files_count].pFullName);
				}
				gbkp_files_count= 0;
			}
			if(!PassEntered){
				do{
					currInstallName[PassEntered]= pf31[1+PassEntered++];
				}while(pf31[PassEntered] != '.');
				strcpy(currInstallName+PassEntered,defAllFullName+2);
				PassEntered= 1;
			}
		}
	}
}
	if(max_paged_file_per_bytes == m_max_paged_file_per_bytes
		&& ((isPacked && !iAsUnpacked) || (!isPacked))){
			PF_PARAM tmp;memset(&tmp, 0, sizeof(tmp));
			rpRd= 0;
			int rpWr= 0, max, mm, firstPos= PageSize, post=0, ddd= 0;
			unsigned int pos;

			tmp.pFileHandles= m_postFileHandles;
			tmp.accesMode= m_mode;
			tmp.processMode= ACE_OS_O_RDONLY;
			if(m_mode & 0x2000){
				if(m_mode & 0x1000){
					tmp.page= 
	(int)(( ((((u_int64_t)0xffffffff) << 8)|(u_int64_t)0xff) & *(u_int64_t*)(5 * (LastPage-1) + (char*)pageOffs))
			/ (u_int64_t)PageSize);
				}else
					tmp.page= pageOffs[LastPage-1] / PageSize;
			}else
				tmp.page= LastPage;
			tmp.FileName= FileName;
			if(((PagedFileHeader*)SystemPageBuf)->TomPerPages)
				tmp.maxFile_per_bytes= m_max_paged_file_per_bytes;
			else{
				tmp.maxFile_per_bytes= 0x7fffffff;
			}
			tmp.pFilePoss= m_postFilePoss;
			tmp.pHeader= SystemPageBuf;
			tmp.pUncompressBuffer= rbuf;
			tmp.pPackTable= pageOffs;
			tmp.PackArraySize= m_PackArraySize;
			tmp.pCrptTag= m_readed.pCrptTag;
#ifndef	_GCD_CLIENT
			if(PageSize == 512){
				makedNdt= pTarget->m_postFileHandles[0];
			}else if(PageSize == 2048){
				makedKey= pTarget->m_postFileHandles[0];
			}else if(PageSize == 4096){
				if(strrchr(FileName,'.') && strrchr(FileName,'.')[1] == '1')
					makedKey= pTarget->m_postFileHandles[0];
				else
					makedStr= pTarget->m_postFileHandles[0];
			}
#endif
			if(c_io_lseek(pTarget->m_postFileHandles[0], PageSize, ACE_OS_SEEK_SET) != PageSize)
			{
				pContext->wrStats= 1;
				goto Error113;
			}
			max= IsNextTom(&tmp);
			if(pContext != 0){
				char* slashPos = strrchr( pTarget->FileName, '\\' );
				if ( !slashPos ) slashPos = pTarget->FileName; else slashPos++;
				sprintf(pBuff, getCopyingFormat(), slashPos);
				pContext->OtherShowMessage(pBuff);
				pContext->SetProgress(0);
			}
			do{
				if(pTarget == pPreCopy){
					pPreCopy= 0;
					c_io_lseek(pTarget->m_postFileHandles[rpWr], 0, ACE_OS_SEEK_END);
					rpRd++;
					firstPos= 0;
					ddd += 100 / (max+1);
				}else if(pPreCopy == (BreederFile*)-1)
					pTarget->Total= 1;

				pTarget->m_postFilePoss[rpWr]= -1l;
				if(rpRd > 0){
					if( strcpy(pBuff, FileName) == 0
						||
						GetBasedExtFileName(pBuff, rpRd) == 0)
					{
						pContext->rdStats= 1;
						goto Error113;
					}
					free(pContext->pFileNameError);
					pContext->pFileNameError= strdup(pBuff);
					strcpy(directReadFileName,pBuff);
				}else{
					strcpy(directReadFileName,FileName);
				}
				m_postFilePoss[rpRd]= firstPos;
				if(!max){
					mm= (int)((pos= c_io_lseek(m_postFileHandles[rpRd], 0, ACE_OS_SEEK_END))/PageSize);
					if(c_io_lseek(m_postFileHandles[rpRd], firstPos, ACE_OS_SEEK_SET) != firstPos && (pContext->rdStats= 1))
						goto Error113;
				}else if(rpRd){
					mm= (int)((pos= m_max_paged_file_per_bytes + PageSize)/PageSize);
				}else{
					if(m_PackArraySize){
						if((pos= c_io_lseek(m_postFileHandles[rpRd], 0, ACE_OS_SEEK_END)) == -1){
							goto Error113;
						}
						if(((PagedFileHeader*)SystemPageBuf)->TomPerPages)
							pos -= m_PackArraySize;
						else{
							pos -= m_PackArraySize + COPY_BUFF_SIZE;
							if(!pPreCopy){
								pTarget->Total= 1;
								pPreCopy= (BreederFile*)-1;
							}
						}
						mm= 1;
						if(m_mode & 0x1000){
							unsigned int tmpPos;
							do{
								tmpPos= 
	(unsigned int)( ((((u_int64_t)0xffffffff) << 8)|(u_int64_t)0xff) & *(u_int64_t*)(5 * (mm-1) + (char*)pageOffs));
							}while(tmpPos < pos && mm++);
							mm= tmpPos / PageSize;
						}else{
							while(pageOffs[mm] < (u_int32_t)pos)
								mm++;
							mm= pageOffs[mm]/PageSize;
						}
						pos= (unsigned int)(mm * PageSize);
					}else{
						mm= (int)((pos= /*c_io_lseek(m_postFileHandles[rpRd], 0, ACE_OS_SEEK_END)*/m_max_paged_file_per_bytes)/PageSize);
					}
					if(c_io_lseek(m_postFileHandles[rpRd], firstPos, ACE_OS_SEEK_SET) != firstPos && (pContext->rdStats= 1))
						goto Error113;
				}
		//////////
		cpages= 0;
		ok_Mesg= 0;
		percnt= 0;
		ii=1;
		m_readed.buf= pBuff;
		while(ii++ < mm){
	////////
	if(gCopyKill) goto Error115;
	////////
			cpages += PageSize;
			pTarget->Total++;	
			if(cpages == COPY_BUFF_SIZE){
	////////
	((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= COPY_BUFF_SIZE;
	if(rpRd){
		if(m_postFileHandles[rpRd] == -1){
			if(IsPostExistL(rpRd,&m_readed, rpRd == max ? -2 : 0) == -1){
				((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= PageSize;
				goto Error113;
			}else if(rpRd == max){
				mm= (int)((pos= c_io_tell(m_postFileHandles[rpRd])+PageSize)/PageSize);
				if(c_io_lseek(	m_postFileHandles[rpRd], 0, ACE_OS_SEEK_SET ) != 0){
					((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= PageSize;
					goto Error113;
				}
			}
			if(((PagedFileHeader*)SystemPageBuf)->TomPerPages == 0){
				if(!IsPostExist(rpRd-1,&m_readed)){
					((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= PageSize;
					goto Error113;
				}
				((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= 0;
				ii -= COPY_BUFF_SIZE/PageSize;
				m_postFilePoss[rpRd] -= COPY_BUFF_SIZE;
			}
		}
	}
	if(((struct PagedFileHeader *)(m_readed.pHeader))->PageSize && !IsPostExist(rpRd,&m_readed)){
		((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= PageSize;
		goto Error113;
	}
	((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= PageSize;
	////////
	if(!pPreCopy && rpRd == 1 && PageSize > 512 && *(long*)m_pCryptoTag < PageSize){
		pPreCopy= (BreederFile*)1;
		if((retFile= chk_backup2G(pTarget, retFile, &cpages, &ii, pBuff, iAsUnpacked, m_postFilePoss[rpRd], &rpRd )) == -1)
			goto Error113;
		if(retFile > 1){
			if(*(pTarget->m_postFileHandles) == -1)
				break;
			retFile= make_nxt_trgt(pTarget, retFile-1);
		}
		else cpages= 0;
	}else
	////////
				if(pTarget->Total > ((pTarget->m_max_paged_file_per_bytes/PageSize)*retFile
										- (m_PackArraySize ? (m_PackArraySize / PageSize + 1) : 0)
																									)){
					cpages= COPY_BUFF_SIZE-PageSize*(
								pTarget->Total-((pTarget->m_max_paged_file_per_bytes/PageSize)*retFile
									- (m_PackArraySize ? (m_PackArraySize / PageSize + 1) : 0)
																								));
					if(	chk_wr(	*(pTarget->m_postFileHandles), pBuff, cpages, pContext)
						|| (retFile == 1 && m_PackArraySize && chk_wr(	*(pTarget->m_postFileHandles), pageOffs, m_PackArraySize, pContext))
						|| _commit(*(pTarget->m_postFileHandles))
						|| c_io_close(*(pTarget->m_postFileHandles)))
					{
						goto Error113;
					}
					allFHndls.del(*(pTarget->m_postFileHandles));
	////////////////
	if((retFile= backup2G(pTarget, retFile, &cpages, &ii, pBuff, iAsUnpacked, m_postFilePoss[rpRd], &rpRd )) == -1)
		goto Error113;
	if(pTarget->GetFileHandle() == -2){
		pTarget->SetFileHandle(c_io_open(pTarget->FileName, ACE_OS_O_WRONLY|ACE_OS_O_BINARY));
		*(pTarget->m_postFileHandles)= -1;
		break;
	}else
		retFile= make_nxt_trgt(pTarget, retFile);
	////////////////
				}else{
					cpages= 0;
				}
	////////
	m_postFilePoss[rpRd] += COPY_BUFF_SIZE;
	////////

				if(chk_wr(*pTarget->m_postFileHandles, pBuff+cpages, COPY_BUFF_SIZE-cpages, pContext))
					goto Error113;
				cpages= 0;
				pContext->AllCpd += COPY_BUFF_SIZE/1024;
				if(isPacked){
					if(m_mode & 0x1000){
						percnt= (pTarget->Total*100) / (
(int)(( ((((u_int64_t)0xffffffff) << 8)|(u_int64_t)0xff) & *(u_int64_t*)(5 * (LastPage-1) + (char*)pageOffs))
								/ (u_int64_t)PageSize)
							) + 1;
					}else
						percnt= (pTarget->Total*100) / (pageOffs[LastPage]/PageSize) + 1;
				}else
					percnt= (pTarget->Total*100) / LastPage + 1;
				if(ok_Mesg == 50){
					ok_Mesg= 0;
#ifndef NO_GSSCREEN
					pContext->SetProgress(percnt);
#endif
				}
				ok_Mesg++;
			}
	////////
	while(!rpRd && waitKill) Sleep(200);
	////////
		}
				if(*(pTarget->m_postFileHandles) == -1)
					rpRd= max + 1;
				else{
					///
					firstPos= cpages;
					if((pos -= mm * PageSize) > 0l) firstPos += (int)(pos & 0x7fffffff);
					//
					if(firstPos > 0){
						((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= (short)(firstPos & 0x7fff);
						if(!IsPostExist(rpRd,&m_readed)){
							((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= PageSize;
							goto Error113;
						}
						((struct PagedFileHeader *)(m_readed.pHeader))->PageSize= PageSize;
						//
						if( chk_wr(pTarget->m_postFileHandles[rpWr], pBuff, firstPos, pContext))
							goto Error113;
					}
					///
					if(rpRd+1 <= max){
						if(pPreCopy == (BreederFile*)-1){
							pPreCopy= pTarget;
							firstPos= rpRd+1;
							break;
						}
						firstPos= 0;
						ddd += 100 / (max+1);
						rpRd++;
					}else{
						firstPos= rpRd+1;
						break;
					}
				}
	////////
	if(!rpRd){
		if(gCopyKill) goto Error115;
		while(waitKill) Sleep(200);
	}
	////////
			}while(rpRd <= max);
			if(*(pTarget->m_postFileHandles) > -1){
				if(retFile < 2 && max && pPreCopy != pTarget && chk_wr(pTarget->m_postFileHandles[rpWr], pageOffs, m_PackArraySize, pContext))
					goto Error113;
				end_backup2G(pTarget, retFile, &cpages, &ii, pBuff, iAsUnpacked, 0, &firstPos);
			}
	#ifndef NO_GSSCREEN
			if(pContext != 0)
				pContext->SetProgress(100);
	#endif
	}else{
#ifndef NO_GSSCREEN
		if(pContext != 0){
		#ifdef	BRDR32
			char* slashPos = strrchr( pTarget->FileName, '\\' );
			if ( !slashPos ) slashPos = pTarget->FileName; else slashPos++;
			sprintf(pBuff, getCopyingFormat(), slashPos);
		#else
			sprintf(pBuff, getCopyingFormat(), pTarget->FileName);
		#endif
			pContext->OtherShowMessage(pBuff);
			pContext->SetProgress(0);
		}
#endif
		if(pTarget->m_pCryptoTag == 0 && *(int*)m_pCryptoTag == 1){
			pTarget->m_pCryptoTag= (char*)&DefValCryptoTag;
		}else if(pTarget->m_pCryptoTag == 0){
			add_crypto_tag(&pTarget->m_pCryptoTag, pTarget->PageSize);
			// import crypto block for RD
			memcpy(pTarget->m_pCryptoTag+4,m_pCryptoTag+4,((*(int*)pTarget->m_pCryptoTag / PageSize)-1)*PageSize);
		}else if(*(int*)m_pCryptoTag > 1){
				if(c_io_lseek(*pTarget->m_postFileHandles, 0, ACE_OS_SEEK_END) != LastPage*PageSize+PageSize)
					goto Error113;
				*(int*)pTarget->m_pCryptoTag = 0;
			}else
				*(int*)pTarget->m_pCryptoTag = 0;
#ifndef	_GCD_CLIENT
		if(PageSize == 512){
			makedNdt= pTarget->m_postFileHandles[0];
		}else if(PageSize == 2048){
			makedKey= pTarget->m_postFileHandles[0];
		}else if(PageSize == 4096){
			if(strrchr(name,'.') && strrchr(name,'.')[1] == '1')
				makedKey= pTarget->m_postFileHandles[0];
			else
				makedStr= pTarget->m_postFileHandles[0];
		}
#endif
		if(	pTarget->LastPage == LastPage &&
			c_io_lseek(*pTarget->m_postFileHandles, (int)PageSize, ACE_OS_SEEK_CUR) != (int)PageSize)
				goto Error113;
		m_postFilePoss[0]= 0;
		cpages= 0;
		ok_Mesg= 0;
		percnt= 0;
		ii=0;
		if(pTarget->LastPage == LastPage){
			if(m_PackArraySize){
				if(pPreCopy == (BreederFile*)-1 && LastPage*4 > (int)(PageSize & 0x7fff)){
					int tmpPos;
					ii= c_io_lseek(m_postFileHandles[0], 0, ACE_OS_SEEK_END) - m_PackArraySize;
					LastPage= 1;
					if(m_mode & 0x1000){
						do{
							tmpPos= 
(int)( ((((u_int64_t)0xffffffff) << 8)|(u_int64_t)0xff) & *(u_int64_t*)(5 * (LastPage-1) + (char*)pageOffs));
						}while(tmpPos < ii && LastPage++);
					}else while(pageOffs[LastPage] < (u_int32_t)ii)
						LastPage++;
					if(LastPage != pTarget->LastPage){
						ii= m_readed.page;
						if(m_mode & 0x1000)
							m_readed.page= 
	(int)(( ((((u_int64_t)0xffffffff) << 8)|(u_int64_t)0xff) & *(u_int64_t*)(5 * (LastPage-1) + (char*)pageOffs))
			/ (u_int64_t)PageSize);
						else
							m_readed.page= pageOffs[LastPage-1] / PageSize;
						m_readed.accesMode &= ~0x2000;
						m_readed.pCrptTag= m_pCryptoTag;
						m_readed.buf= pTarget->pPrePackedBuff= new char[PageSize+PageSize];
						if(IsNextTom(&m_readed)){
							LastPage--;
							if(m_mode & 0x1000)
								m_readed.page= 
		(int)(( ((((u_int64_t)0xffffffff) << 8)|(u_int64_t)0xff) & *(u_int64_t*)(5 * (LastPage-1) + (char*)pageOffs))
				/ (u_int64_t)PageSize);
							else
								m_readed.page= pageOffs[LastPage-1] / PageSize;
						}
						otherReadOrWrite(&m_readed);
						m_readed.accesMode |= 0x2000;
						LastPage--;
					}
					pTarget->Total= 1;
				}
			}else
				LastPage= c_io_lseek(m_postFileHandles[0], 0, ACE_OS_SEEK_END)/PageSize;
			ii= 0;
		}else{
			if(pTarget->pPrePackedBuff){
				memcpy(m_readed.pUncompressBuffer+PageSize, pTarget->pPrePackedBuff, PageSize);
				if(m_mode & 0x1000){
					m_postFilePoss[0]= 
(int)(( ((((u_int64_t)0xffffffff) << 8)|(u_int64_t)0xff) & *(u_int64_t*)(5 * (LastPage+1) + (char*)pageOffs))
			/ (u_int64_t)PageSize);
				}else
					m_postFilePoss[0]= pageOffs[LastPage+1] / PageSize;
			}
			ii= LastPage;
			LastPage= pTarget->LastPage;
		}
		int first2G= 1;
		if(pPreCopy){
			first2G= 0;
		}
		while(ii++ < LastPage){
	////////
	if(gCopyKill) goto Error115;
	////////
			if(GetHardPage(ii, pBuff, cpages)){
				goto Error113;
			}
			if(pTarget->pPrePackedBuff && m_postFileHandles[1] != -1){
				delete []pTarget->pPrePackedBuff;
				pTarget->pPrePackedBuff= 0;
				m_postFilePoss[1]= -1;
			}
			cpages += PageSize;
			pTarget->Total++;
			if(cpages == COPY_BUFF_SIZE){
		///////
		if(((!pPreCopy && LastPage == pTarget->LastPage)||(pPreCopy && pPreCopy != (BreederFile*)-1 && pPreCopy != (BreederFile*)1)) && PageSize > 512 && *(long*)m_pCryptoTag < PageSize){
			m_bkp_closed_pos= -1;
			pPreCopy= (BreederFile*)1;
			if((retFile= chk_backup2G(pTarget, retFile, &cpages, &ii, pBuff, iAsUnpacked, 0, 0)) == -1)
				goto Error113;
			if(retFile > 1){
				if(*(pTarget->m_postFileHandles) == -1){
					pPreCopy= 0;
					break;
				}
				retFile= make_nxt_trgt(pTarget, retFile-1);	
			}else cpages= 0;
		}else
		///////
				if(pTarget->Total+first2G > (pTarget->m_max_paged_file_per_bytes/PageSize)*retFile)
				{
					cpages= COPY_BUFF_SIZE-PageSize*(first2G+pTarget->Total-(pTarget->m_max_paged_file_per_bytes/PageSize)*retFile);
					if(	chk_wr( *pTarget->m_postFileHandles, pBuff, cpages, pContext)
						|| _commit(*(pTarget->m_postFileHandles))
						|| c_io_close(*(pTarget->m_postFileHandles)))
					{
						pContext->wrStats= 1;
						goto Error113;
					}
	////////////////
	if((retFile= backup2G(pTarget, retFile, &cpages, &ii, pBuff, iAsUnpacked)) == -1)
		goto Error113;
	if(pTarget->GetFileHandle() == -2){
		pTarget->SetFileHandle(c_io_open(pTarget->FileName, ACE_OS_O_RDWR|ACE_OS_O_BINARY));
		*(pTarget->m_postFileHandles)= -1;
		break;
	}else
		retFile= make_nxt_trgt(pTarget, retFile);
	////////////////
				}else{
					cpages= 0;
				}
				if(chk_wr(*pTarget->m_postFileHandles, pBuff+cpages, COPY_BUFF_SIZE-cpages, pContext))
					goto Error113;
				cpages= 0;
				pContext->AllCpd += COPY_BUFF_SIZE/1024;
				if((ii*100) / pTarget->LastPage != (int)percnt){
					percnt= (ii*100) / pTarget->LastPage + 1;
					if(ok_Mesg == 50){
						ok_Mesg= 0;
	#ifndef NO_GSSCREEN
						pContext->SetProgress(percnt);
	#endif
					}
					ok_Mesg++;
				}
			}
	////////
	while(!rpRd && waitKill) Sleep(200);
	////////
 		}
		if(retFile > 1) pTarget->Total= 0;
		if(*(pTarget->m_postFileHandles) > -1){
			if(chk_wr(*pTarget->m_postFileHandles, pBuff, cpages, pContext))
				goto Error113;
			end_backup2G(pTarget, retFile, &cpages, &ii, pBuff, iAsUnpacked);
		}
	}
	if(pPreCopy == (BreederFile*)-1){
		if(pTarget->LastPage > LastPage){
			if(m_bkp_closed_pos > -1 && *(pTarget->m_postFileHandles) > -1 && c_io_lseek( pTarget->file, m_bkp_closed_pos, ACE_OS_SEEK_SET ) != m_bkp_closed_pos)
				goto Error113;
			pPreCopy= pTarget;
		}else
			pPreCopy= 0;
	}else if(pPreCopy == pTarget && !iAsUnpacked && ((PagedFileHeader*)SystemPageBuf)->TomPerPages == 0){
		if(!CopyAs(	name, MAX_BYTE_FILE_SIZE, 0))
			pTarget= 0;
		rpRd= 0;
		pPreCopy= 0;
	}
	free(pBuff);
	return pTarget;
Error113:
	free(pBuff);
Error114:
	if(pContext->rdStats || pContext->lastReaded->iPost == 0);
	else{
		makeErrorFilename(pContext, this, pTarget);
		if(*(pTarget->m_postFileHandles) > 0) allFHndls.del(*(pTarget->m_postFileHandles));pTarget->Delete(1);
		delete pTarget;
	}
	return 0;
Error115:
	waitAfterWriteHandlesClosed();
	return 0;
}

extern "C" {
		int curr_io_file(LPPF_PARAM pPrm)
		{
			int zz;
			if((zz= c_io_open((char*)pPrm->buf, pPrm->accesMode | ACE_OS_O_BINARY)) != -1){
				c_io_close(zz);
				free(((GSScreen *)(pPrm->pScreenCntxt))->pFileNameError);
				((GSScreen *)(pPrm->pScreenCntxt))->pFileNameError= strdup((char*)(pPrm->buf));
			}
			return zz;
		}
		int c_io_multi_open(char *name_buf, int *patched_len)
		{
			int retH, len= patched_len[0];
			char add1[13]= "\\GARANT\\DATA";
			if((retH= c_io_open(name_buf, ACE_OS_O_BINARY)) != -1)
				return retH;
			while(name_buf[--len] != '\\') name_buf[len+12]= name_buf[len];
			name_buf[len+12]= name_buf[len];
			memcpy(name_buf+len,add1,12);
			if((retH= c_io_open(name_buf, ACE_OS_O_BINARY)) != -1){
				memcpy(psrcRead+szsrcRead, add1, 12); *patched_len += 12;szsrcRead += 12;
				return retH;
			}
			memcpy(name_buf+len,name_buf+len+7,5+patched_len[0]-szsrcRead);
			if((retH= c_io_open(name_buf, ACE_OS_O_BINARY)) != -1){
				memcpy(psrcRead+szsrcRead, add1+7, 5); *patched_len += 5;szsrcRead += 5;
				return retH;
			}
			memcpy(name_buf+len,name_buf+len+5,patched_len[0]-szsrcRead);
			return -1;
		}
		int breeder_io_read(int fd, void* buf, int len){
			int ret_bytes= 0;
			if((ret_bytes=c_io_read(fd,buf,len)) == len)
				return len;
			if(ret_bytes > 0)
				c_io_lseek(fd, -ret_bytes, ACE_OS_SEEK_CUR);
			return 0;
		}
		int IsPostExistL(	int indx, LPPF_PARAM pPrm, int pos )
		{
			int len, operationRepeat= 0, currPostPos= -1, reOpen= 0;
			while(	(indx && waitKill && (operationRepeat= 3))
					||
					pPrm->pFileHandles[indx] == -1
					||
					(pos != -1 && (c_io_lseek(	pPrm->pFileHandles[indx], pos == -2 ? 0 : pos, pos == -2 ? ACE_OS_SEEK_END : ACE_OS_SEEK_SET ) == -1))
					||
					(pos == -1 && breeder_io_read( pPrm->pFileHandles[indx], pPrm->buf, (int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize ) < 1)		)
					// для эмуляции ошибки чтения, раскоментарить нижнюю строчку взамен верхней
					//(pos == -1 && ((indx > 0 && pPrm->pFileHandles[indx] != -1) || c_io_read( pPrm->pFileHandles[indx], pPrm->buf, (int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize ) < 1))		)
			{
				if(psrcRead){
					strcpy(psrcRead + szsrcRead, strrchr(pPrm->FileName,'\\'));
					strcpy(pPrm->FileName,psrcRead);
				}
				len=strlen(pPrm->FileName)+1;
				///
				  if(	pPrm->pScreenCntxt &&
						(	len < 2
							|| GetBasedExtFileName((char*)memcpy(pPrm->buf,pPrm->FileName,len), indx) == 0
							|| (pPrm->pFileHandles[indx] != -1 && (curr_io_file(pPrm) != -1 || ((reOpen= 1) && (operationRepeat= 3))) )
							|| (indx > 0 && pPrm->pFileHandles[indx] == -1 && (operationRepeat= 3)
									&& (	(pPrm->pFileHandles[indx]= c_io_multi_open((char*)(pPrm->buf), &len)) == -1
											|| ( !c_io_close(pPrm->pFileHandles[indx]) && (pPrm->pFileHandles[indx]= -1) && (operationRepeat= 0))
										)
								)
						)
					){
					  if ( (pPrm->pFileHandles[indx] != -1 && operationRepeat++ < 3 && chk_sleep())
						  || !(!(operationRepeat=0) && ((GSScreen *)(pPrm->pScreenCntxt))->ShowQuestionYesOrNo((char*)pPrm->buf, 1)))
					  {
						  if(!operationRepeat && psrcRead){
							  if(reOpen || strcmp(psrcRead,pPrm->FileName)){								  
								  if(((struct PagedFileHeader *)pPrm->pHeader)->PageSize >= COPY_BUFF_SIZE){
									currPostPos= pPrm->pFilePoss[indx];
								  }else if(pos != -1 && pos != -2){
									currPostPos= pos;
								  }else{
									currPostPos= (pPrm->pFilePoss[indx]-1)*(int)(((struct PagedFileHeader *)pPrm->pHeader)->PageSize);
								  }
								  if(pPrm->pFileHandles[indx] != -1){
									c_io_close(pPrm->pFileHandles[indx]);
									pPrm->pFileHandles[indx]= -1;
								  }
							  }
							  reOpen= 0;
						  }
						  if(waitKill){
							  waitKill= 0;
							  operationRepeat= 0;
							  waitKillAsBrowse= 0;
						  }
						  continue;
					  }
					  ((GSScreen *)(pPrm->pScreenCntxt))->rdStats= 1;
					  AfterWriteHandlesClosed();
					  if(pos != -1 || pos == -2)
						  return -1;
					  return 0;
				  }
				  if(pPrm->pFileHandles[indx] == -1){
					  if((pPrm->pFileHandles[indx]= c_io_open((char*)(pPrm->buf), ACE_OS_O_BINARY)) == -1){
						  continue;
					  }
#ifdef _DEBUG
					  {
						  char msgDbg[2048];
						  sprintf(msgDbg, "\nOpened [%s]",(char*)(pPrm->buf));
						  ::OutputDebugString(msgDbg);
					  }
#endif
					  char path [MAX_PATH];
					  strcpy (path, (char*)(pPrm->buf));
					  char *slash = strrchr (path, '\\');
					  if (slash) *slash = 0;
					  if (strlen (path) > 4 && path [2] == '\\' && path [3] == '\\')
						  strcpy (path + 2, path + 3);
					  ((CTestBreeder32Dlg*)((GWinScreen*)pPrm->pScreenCntxt)->m_pParent)->m_Msg70.SetWindowText (path);

					  if(currPostPos != -1){
						  if(c_io_lseek(pPrm->pFileHandles[indx], currPostPos, ACE_OS_SEEK_SET) != currPostPos){
							  c_io_close(pPrm->pFileHandles[indx]);
							  pPrm->pFileHandles[indx]= -1;
						  }
					  }else
						  pPrm->pFilePoss[indx]= 0;
				  }
			}
			return pos;
		}
		int IsPostExist(	int indx, LPPF_PARAM pPrm )
		{
			int ret= IsPostExistL(indx, pPrm, -1);
			if(ret)
				return 1;
			return 0;
		}
}

// CBRCDialog dialog

CBRCDialog::CBRCDialog(CWnd* pParent /*=NULL*/)
	: CDialog(CBRCDialog::IDD, pParent)
{
}

CBRCDialog::~CBRCDialog()
{
}

void CBRCDialog::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CBRCDialog)
	DDX_Control(pDX, IDC_BROWSE, m_BttnB);
	DDX_Control(pDX, ID_NEXT, m_BttnR);
	DDX_Control(pDX, IDCLOSE, m_BttnC);
	DDX_Control(pDX, IDC_STATIC_AD1, m_Msg);
	//}}AFX_MSG_MAP
}

BEGIN_MESSAGE_MAP(CBRCDialog, CDialog)
	//{{AFX_MSG_MAP(CBRCDialog)
	ON_BN_CLICKED(IDCLOSE, OnCancel)
	ON_BN_CLICKED(ID_NEXT, OnRetry)
	ON_BN_CLICKED(IDC_BROWSE, OnBrowse)
	ON_WM_CTLCOLOR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

BOOL CBRCDialog::OnInitDialog()
{
	CDialog::OnInitDialog();
	SetWindowText(get_app ()->get_rc_lang () == rl_Eng ? "Data Setup Wizard" : "Мастер установки данных");
	m_Msg.SetWindowText((LPCTSTR)m_importText);
	return TRUE;
}

HBRUSH CBRCDialog::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor)
{
    HBRUSH hbr = CDialog::OnCtlColor(pDC, pWnd, nCtlColor);

	if (nCtlColor == CTLCOLOR_STATIC && pWnd->GetDlgCtrlID() == IDC_STATIC_AD1) {
		pDC->SetTextColor (RGB(0,0,0));
        pDC->SetBkColor (RGB(255,255,255));
		pDC->SetBkMode(1);
		hbr = (HBRUSH)GetStockObject (NULL_BRUSH);
	}

    return hbr;
}

void CBRCDialog::OnBrowse() 
{
	if(rpRd > 0){
		char SelectedPath[MAX_PATH+MAX_PATH];
		LPITEMIDLIST	aBrowse= 0;
		aBrowse= PidlBrowse( m_hWnd, CSIDL_DRIVES, SelectedPath, IDS_SELECT_FOLDER );
		if(!aBrowse){
			;
		}else if( aBrowse && SHGetPathFromIDList( aBrowse, SelectedPath )){
			szsrcRead= strlen(SelectedPath);memcpy(srcRead,SelectedPath,szsrcRead);srcRead[szsrcRead]= 0;
			EndDialog(IDYES);
		}
	}else
		EndDialog(IDIGNORE);
}
void CBRCDialog::OnRetry() 
{
	EndDialog(IDRETRY);
}
void CBRCDialog::OnCancel() 
{
	EndDialog(IDCANCEL);
}
BOOL CTestBreeder32Dlg::PreTranslateMessage(MSG* pMsg)
{
	m_tooltip.RelayEvent(pMsg);
	return CDialog::PreTranslateMessage(pMsg);
}

void CTestBreeder32Dlg::OnCopyPassword() 
{
	OpenClipboard ();
	EmptyClipboard ();	
	HGLOBAL hg = GlobalAlloc (GMEM_MOVEABLE,val10.GetLength () + 1);
	if (!hg) {
		CloseClipboard ();
		return ;
	}
	memcpy (GlobalLock (hg), val10.GetBuffer (0), val10.GetLength () + 1);
	GlobalUnlock (hg);
	SetClipboardData (CF_TEXT, hg);
	CloseClipboard ();
}

