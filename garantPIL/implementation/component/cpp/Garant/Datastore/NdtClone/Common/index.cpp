#include "shared/Core/fix/mpcxc.h"
//
// Basic index class for managing search
// Based of BTree class to provide add/delete/find capabilities
//
// Author Alex V. Boreskoff
//

#include "shared/Core/fix/PragmaWarningDisable.h"

//extern "C" int ace_os_ltrunc(int fd, long loffset);

#include "../../../../Garant/Datastore/NdtClone/Common/index.h"

#include <cstdio>
#include <cstdlib>
#include <cassert>

  #ifndef PLAIN_GKDB
#include "ace/OS.h"
  #endif

namespace NdtClone {

extern char pFatSizeName[];

#ifndef WRITE_KEYS_PAGE_INBACKUP
static NDTKPage MapDeflt;
#endif

//static const int createIndexCount= 0;

static const char formftCreate[]= ".ntmp(%d)";

static const FILE *pNDTCloneLOG= 0, *pNDTGlobaTransactionLog= 0;
static const int NDTGlobaTransactionNotCopy= 0;
static const char pNDTCloneLOG_FileName[]=
	#ifdef WITH_LOG_FILE
										"backup.log"
	#else
										"nul"
	#endif
														;
static const char pNDTCloneLOG_Dir[]= "backup.dir";
static const char	StartFormat[]="\nStart create hand-backup...\t\t%s ...", // GARANT_U
			CopyFormat[]="\n\tfiles %s & %s ...",
			EndFormat[]="\nEnd create hand-backup...\t\t%s.", // GARANT_U
			extBckK[]= ".5kp", extBckS[]= ".6kp";

#ifdef WITH_LOG_FILE
	static char m_NameGlobalBuckupPath[2048];
#endif
static const int m_setNameGlobalBuckupPath= 0;
  #ifndef PLAIN_GKDB
static Core::Mutex m_mutexSetNameGlobalBuckupPath;
  #endif

/*static int unlink_rdonly(const char *pName)
{
	mpcxc_chmod(pName, MPCXC_FILE_ATTR_RW); // GARANT_CROSSP
	return ace_os_unlink(pName);
}

static int rename_rdonly(const char *pOld, const char *pNew)
{
	mpcxc_chmod(pOld, MPCXC_FILE_ATTR_RW); // GARANT_CROSSP
	return ace_os_rename(pOld, pNew);
}*/

static BackupedFileNameMap BackupedFileNameMapAll(0);

  #ifndef PLAIN_GKDB
static Core::Mutex m_mutexBackupedFileNameMap;
  #endif


#ifdef WITH_LOG_FILE
  const char *GetNameGlobalBuckupPath()
  {
	return (const char *)m_NameGlobalBuckupPath;
  }
#endif
  #ifndef PLAIN_GKDB
static Core::Mutex m_mutexNDTGlobaTransactionLog;
  #endif

void set_global_transaction_path(const char *pNewPath)
{
	//GUARD (m_mutexNDTGlobaTransactionLog);
	size_t len= strlen(pNewPath);
	/*memcpy(m_NameGlobalBuckupPath, pNewPath, len);
	if(pNewPath[len-1] != '\\')
		m_NameGlobalBuckupPath[len++]= '\\';
	else if(pNewPath[len-1] == '/')
		m_NameGlobalBuckupPath[len-1]= '\\';
	m_NameGlobalBuckupPath[len]= 0;
	m_setNameGlobalBuckupPath++;*/
}

static int m_GlobalTransactionCount= 0;

class NDTGlobaTransactionLogFileName
{
public:
	NDTGlobaTransactionLogFileName()
	{
		name= new char[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE];
#ifdef WITH_LOG_FILE
		strcpy(name, m_NameGlobalBuckupPath);
		strcat(name, "global.dic");
#else
		strcat(name, "nul");
#endif
	}
	const char* GetName() { return name; }
	~NDTGlobaTransactionLogFileName()
	{
		if(name)
			delete name;
	}
protected:
	char *name;
};

const char *FormatNDTGlobaTransactionLog= "%s\n%s\n";

const char *pBuckupFileExt=
#ifdef WITH_LOG_FILE
	// в этом режими журналы последних валидных транзакций(".tmp") всегда остаются на FS OS //
							".bkp"
#else
							".tmp"
#endif
									;

extern FILE* copy_In_Pre(const char *fname, BackupedFileNameMap *pOutFiles= 0, int skipSecond= 0);

void testLastGlobalTransactin(PagedFile * tf= 0, StreamFile * s= 0, int clearOnly= 0)
{
	if(!pNDTGlobaTransactionLog){
		NDTGlobaTransactionLogFileName tmp;
		const char *pFF= tmp.GetName();
		int skipCopy= 0;
#ifdef WITH_LOG_FILE
		FILE *pLastNDTGlobaTransactionLog= mpcxc_fopen(pFF, "r");
		if(pLastNDTGlobaTransactionLog){
			BackupedFileNameMap BackupedFiles(0), *pGetList= 0;
#ifndef USE_GLOBAL_DIC
			if(!pNDTCloneLOG){
				char *tmpName= (char*)alloca(NDTC_MAX_PATH_SIZE), *fnd= (char*)strrchr(pFF, '\\');
				int len= (int)(fnd - pFF) + 1;
				memcpy(tmpName, pFF, len);
				strcpy(tmpName+len, pNDTCloneLOG_FileName);
				pGetList= &BackupedFiles;
				pNDTCloneLOG= copy_In_Pre(tmpName, pGetList, 1);
			}
#endif
			int		keyRe= 0, strRe= 0;
			char	*getExt= strdup(pBuckupFileExt), *pEnd, rtsr;
			char	nameKey[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE],
					nameStr[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE];
			BackupedFileNameMap DeleteFileNameMap(0);
			BackupedFileNameMap RemoveFileNameMap(0);
			char *pfnd, *pfnd0;
			G_Point NxtFile= 0;
			if(pGetList){
				NxtFile= BackupedFiles.first();
			}
			while(NxtFile || fscanf(	pLastNDTGlobaTransactionLog
							, FormatNDTGlobaTransactionLog
							, nameKey
							, nameStr) != EOF){
				if(pGetList){
					strcpy(nameKey, BackupedFiles.key(NxtFile).GetName());
					BackupedFiles.next(NxtFile);
					strcpy(nameStr, BackupedFiles.key(NxtFile).GetName());
				}
				pfnd0= strrchr(nameKey, '\\');
				pfnd= strrchr( pfnd0, '(');
				if(pfnd){
					DeleteFileNameMap[BackupedFileName(nameKey)];
					*(pfnd-5)= 0;
				}else if(clearOnly)
					DeleteFileNameMap[BackupedFileName(nameKey)];
				else
					RemoveFileNameMap[BackupedFileName(nameKey)];

				if(!clearOnly){
					*pfnd0= 0;
					strcpy(strrchr(nameKey, '\\')+1, pfnd0+1);
					DeleteFileNameMap[BackupedFileName(nameKey)];
				}
				pfnd0= strrchr(nameStr, '\\');
				pfnd= strrchr( pfnd0, '(');
				if(pfnd){
					unlink_rdonly(nameStr);
					pEnd= strrchr(nameStr, 0);
					rtsr= getExt[1];

					getExt[1]= '~';
					strcat(nameStr, getExt);
					unlink_rdonly(nameStr);
					*pEnd= 0;

					getExt[1]= '#';
					strcat(nameStr, getExt);
					unlink_rdonly(nameStr);
					*pEnd= 0;

					getExt[1]= rtsr;
					strcat(nameStr, getExt);
					unlink_rdonly(nameStr);
					*(pfnd-5)= 0;
				}else  if(clearOnly)
					DeleteFileNameMap[BackupedFileName(nameStr)];
				else
					RemoveFileNameMap[BackupedFileName(nameStr)];

				if(!clearOnly){
					*pfnd0= 0;
					strcpy(strrchr(nameStr, '\\')+1, pfnd0+1);
					DeleteFileNameMap[BackupedFileName(nameStr)];
					pEnd= strrchr(nameStr, 0);
					rtsr= getExt[1];

					getExt[1]= '~';
					strcat(nameStr, getExt);
					unlink_rdonly(nameStr);
					*pEnd= 0;

					getExt[1]= '#';
					strcat(nameStr, getExt);
					unlink_rdonly(nameStr);
					*pEnd= 0;

					getExt[1]= rtsr;
					strcat(nameStr, getExt);
					unlink_rdonly(nameStr);
				}
				if(pGetList)
					BackupedFiles.next(NxtFile);
			}
			G_Point t;
			for(t= DeleteFileNameMap.first(); t; DeleteFileNameMap.next(t)){
				if(tf && !strcmp(DeleteFileNameMap.key(t).GetName(), tf->FileName)){
					keyRe= 1;
					tf->Delete();
				}else if(s && !strcmp(DeleteFileNameMap.key(t).GetName(), s->file->FileName)){
					strRe= 1;
					s->file->Delete();
				}
				unlink_rdonly(DeleteFileNameMap.key(t).GetName());
			}
			for(t= RemoveFileNameMap.first(); t; RemoveFileNameMap.next(t)){
				strcpy(nameKey, RemoveFileNameMap.key(t).GetName());
				pfnd= strrchr(nameKey, '\\');
				*pfnd= 0;
				strcpy(strrchr(nameKey, '\\')+1, pfnd+1);
				rename_rdonly(RemoveFileNameMap.key(t).GetName(), nameKey);
			}
			fclose(pLastNDTGlobaTransactionLog);
			unlink_rdonly(tmp.GetName());
			if(getExt)
				free(getExt);
			if(keyRe){
				tf->Connect(tf->FileName, tf->m_mode);
			}
			if(strRe){
				s->file->Connect(s->file->FileName, s->file->m_mode);
			}
			skipCopy++;
		}
#endif
		if(!pNDTCloneLOG){
			char *tmpName= (char*)alloca(NDTC_MAX_PATH_SIZE), *fnd= (char*)strrchr(pFF, '\\');
			int len= ((int)((fnd - pFF)&0x7fffffff)) + 1;
			memcpy(tmpName, pFF, len);
			strcpy(tmpName+len, pNDTCloneLOG_FileName);
                        if(skipCopy){
                            ace_os_unlink(tmpName);
                            //unlink_rdonly(tmpName);
                            pNDTCloneLOG= mpcxc_fopen( tmpName, "a+");
                        }else
                            pNDTCloneLOG= copy_In_Pre(tmpName);
		}
	}
}

static int realStartGlobalTransaction= 0;

static void set_start_global_transaction()
{
	if(realStartGlobalTransaction == 2){
		realStartGlobalTransaction= 1;
		if(!pNDTGlobaTransactionLog){
			NDTGlobaTransactionLogFileName tmp;
			pNDTGlobaTransactionLog= mpcxc_fopen(tmp.GetName(), "a+");
		}
#ifdef USE_GLOBAL_DIC
		char *pFirst= 0, *pSecond= 0, *pf1, *pf2, *pnxt;
		char	nameKey[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE],
				nameStr[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE];
		int len;
#endif
		int *pStatus;
		for(G_Point t= BackupedFileNameMapAll.first(); t; BackupedFileNameMapAll.next(t)){
			pStatus= &(BackupedFileNameMapAll.contents(t));
			if(*pStatus == 1){
#ifdef USE_GLOBAL_DIC
				if(!pFirst)
					pFirst= (char*)(BackupedFileNameMapAll.key(t).GetName());
				else{
					pSecond= (char*)(BackupedFileNameMapAll.key(t).GetName());
					*(pf1= strrchr(pFirst, '.')) = 0;
					*(pf2= strrchr(pSecond, '.')) = 0;

					pnxt= strrchr(pFirst, '\\');
					len= pnxt - pFirst + 1;
					memcpy(nameKey, pFirst, len);
					strcpy(nameKey+len, pNDTCloneLOG_Dir);
					strcat(nameKey+len, pnxt);

					pnxt= strrchr(pSecond, '\\');
					len= pnxt - pSecond + 1;
					memcpy(nameStr, pSecond, len);
					strcpy(nameStr+len, pNDTCloneLOG_Dir);
					strcat(nameStr+len, pnxt);
					fprintf(pNDTGlobaTransactionLog, FormatNDTGlobaTransactionLog
							, nameKey, nameStr);
					fflush(pNDTGlobaTransactionLog);
					*pf1= '.';
					*pf2= '.';
					pFirst= 0;
				}
#endif
				*pStatus = 2;
			}
		}
	}
}

typedef QuickSplayMap<Index*,StreamFile*> TransactionIndexMap;

//static TransactionIndexMap atlIndexes(0);

static void start_auto_local_transaction(Index *pIndex)
{
#ifndef USE_GLOBAL_DIC
	//GUARD (m_mutexNDTGlobaTransactionLog);
//LOG_D(("\n**ADD** %x-%s-%s", pIndex->streams->pFirst, pIndex->streams->pFirst->Name, pIndex->streams->file->FileName));
	//atlIndexes[pIndex->streams->pFirst]= pIndex->streams;
	pIndex->streams->Flags &= ~SF_IN_PRE_ATRANSCTN;
	pIndex->streams->Flags |= SF_IN_AUTOTRANSCTN;
	if(NDTGlobaTransactionNotCopy)
		pIndex->streams->Flags |= SF_IN_NOT_COPY;
	else if(BackupedFileNameMapAll.seek(BackupedFileName(pIndex->file->FileName))){
		pIndex->streams->Flags |= SF_IN_NOT_COPY;
	}else if((pIndex->streams->Flags & SF_IN_NOT_COPY))
		pIndex->streams->Flags |= SF_IN_FIRST_COPY;
	pIndex->streams->StartTransaction();
#endif
}

void Index::StartAutoLocalTransaction()
{
	start_auto_local_transaction(this);
}

int Index::IsGlobalTransaction(int SkipGlobalBuckup)
{
	//GUARD (m_mutexNDTGlobaTransactionLog);
	if(pNDTGlobaTransactionLog){
		if(SkipGlobalBuckup == SF_IN_NOT_COPY){
			BackupedFileNameMapAll[BackupedFileName(file->FileName)]= 3;
			BackupedFileNameMapAll[BackupedFileName(streams->file->FileName)]= 3;
			/*if(streams->m_hBackupKeys)
				c_io_close(streams->m_hBackupKeys);
			streams->m_hBackupKeys= 0;*/
		}else if(SkipGlobalBuckup == SF_IN_FIRST_COPY){
			char outPutK[NDTC_MAX_PATH_SIZE];
			int len_pKS= (int)(strlen(file->FileName)&0x7fffffff);
			memcpy(outPutK, file->FileName, len_pKS);
			strcpy(outPutK+len_pKS, extBckK);
			if(BackupedFileNameMapAll.seek(BackupedFileName(outPutK))){
				return -1;
			}
		}
		return 1;
	}
	return 0;
}

void start_global_transaction(int notCopy)
{
#ifdef USE_GLOBAL_DIC
	if(m_GlobalTransactionCount++ == 0){
		GUARD (m_mutexNDTGlobaTransactionLog);
		{
			GUARD (m_mutexSetNameGlobalBuckupPath);
			if(notCopy)
				NDTGlobaTransactionNotCopy= 1;
			if(m_setNameGlobalBuckupPath){
				realStartGlobalTransaction= 2;
				testLastGlobalTransactin();
				set_start_global_transaction();
			}else
				realStartGlobalTransaction= 2;
		}
	}
#endif
}

void end_global_transaction(BackupedFileNameMap *pAsCompact)
{
	if(!pAsCompact)
		return;
	for(G_Point i_i= pAsCompact->first(); i_i; pAsCompact->next(i_i)){
		char	nameKey[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE];
		char nameKeyFirst[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE];
		strcpy(nameKey, pAsCompact->key(i_i).GetName());
		strcpy(nameKeyFirst, nameKey);
		*strrchr(nameKey,'k')= 's';	
		{
						PagedFile *kk= GetUpdatedPagedFile(nameKeyFirst, 13);
						if(((struct ::PagedFileHeader *)kk->SystemPageBuf)->TomPerPages){
							delete kk;
						}else if(kk->IsOk()){
							PagedFile *ss= GetUpdatedPagedFile(nameKey, 13);
							if(ss->IsOk()){
								StreamFile s_ss(ss);
{
	char KK[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE], SS[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE];
	strcpy(KK, nameKeyFirst);*(strrchr(KK,'.')-1)= '_';strcpy(SS, nameKey);*(strrchr(SS,'.')-1)= '_';
	PagedFile *k_= GetUpdatedPagedFile(KK, kk->database_version ());k_->Create(kk->PageSize);
	if(k_->IsOk()){
		PagedFile *s_= GetUpdatedPagedFile(SS, ss->database_version ());s_->Create(ss->PageSize);
		if(s_->IsOk()){
			StreamFile sss(s_);sss.Create();
			Index *ii[100], *io[100];
			char *nms[100];
			memset(ii,0,100*sizeof(*ii));
			int z= 0, x;
  for ( int Offs = kk->AttrOffs; Offs < kk->PageSize && kk->SystemPageBuf [Offs] != '\0'; Offs += kk->SystemPageBuf [Offs]){
    nms[z]= (char*)malloc(strlen(kk->SystemPageBuf + Offs + 1)+1);
	strcpy(nms[z++],kk->SystemPageBuf + Offs + 1);
  }
	class IAdd  : public Index
	{
	public:
		IAdd (PagedFile* tf, const char* name, StreamFile* str):Index(tf,name,str)
		{
		}
		virtual	int	Compare (BTKEY key1, BTKEY key2) const {
			return 1;
		}
		virtual	void PrepareRecord  ( BTKEY key, char * buf1= 0 )
		{
			return;
		}
	};
	x= z;
  while(z--){
	  ii[z]= new Index(kk,nms[z],&s_ss);
	  io[z]= new IAdd(k_,ii[z]->Name,&sss);
	  io[z]->Create(	ii[z]->KeyLength - ii[z]->nstreams*(int(STRSZSZ & 0x7fffffff)+ii[z]->ImmDataSize),
					ii[z]->roundv, ii[z]->nstreams, ii[z]->ImmDataSize );
	  free(nms[z]);
  }
	z= x;

  io[z-1]->streams->StartTransaction();
  io[z-1]->StartBackupEx();
  while(z--){
	  ii[z]->CloneAsCompact(io[z]);
	  io[z]->update_SystemPage();
  }
  io[x-1]->streams->EndTransaction();
  char del_optimize_backup_name[2048];
  strcpy(del_optimize_backup_name, io[x-1]->streams->GetBackupName());

  /*for(z++; z < x; z++){
	  delete ii[z];
	  delete io[z];
  }*/
  ace_os_unlink(del_optimize_backup_name);
		}
	}
	delete k_;
	/*int retrnm_key= rename_rdonly(KK, nameKeyFirst);
	if(retrnm_key || rename_rdonly(SS, nameKey))
	{
		char error_msg[]= "abort in testLastGlobalTransactin(rename new index(%) as old(%s) !)";
		if(retrnm_key)
			LOG_E ((error_msg, nameKeyFirst, KK));
		else
			LOG_E ((error_msg, nameKey, SS));
		abort();
	}*/
}
							}
							delete kk;
						}
					}
	}
}

void IndexFilesCopy(char *pK, char *pS, PagedFile *pPK, PagedFile *pPS)
{
	int *pStatus, *pStatusS;
	{
		//GUARD (m_mutexBackupedFileNameMap);
		pStatus= &(BackupedFileNameMapAll[BackupedFileName(pK)]);
		pStatusS= 
#ifdef USE_GLOBAL_DIC
					&(BackupedFileNameMapAll[BackupedFileName(pS)])
#else
					pStatus
#endif
																		;
	}
	if(0 == *pStatus){
#ifndef _NOT_CREATE_BUCKUPED_SUBDIR
		char	nameKey[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE],
				nameStr[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE],
				*fnd0= strrchr(pK, '\\');

		*(fnd0+1)= 0;
		strcpy(nameKey, pK);
                //ace_os_mkdir(strcat(nameKey, pNDTCloneLOG_Dir)); // GARANT_MSVCRT

		pK=  strcat(nameKey, strrchr(pPK->FileName,'\\'));

		strcpy(nameStr, nameKey);
		fnd0= strrchr(nameStr, '\\');
		*fnd0= 0;
		pS=  strcat(nameStr, strrchr(pPS->FileName,'\\'));
#endif
		FILE *pWriteBuckup= 0;
		{
			//GUARD (m_mutexNDTGlobaTransactionLog);
			if(pNDTGlobaTransactionLog){
				//pWriteBuckup= pNDTGlobaTransactionLog;
				pStatus[0]= 2;
				pStatusS[0]= 2;
			}else{
				pStatus[0]= 1;
				pStatusS[0]= 1;
			}
		}
		PagedFile oPK(pK, ACE_OS_O_WRONLY, pPK->database_version ()), oPS(pS, ACE_OS_O_WRONLY, pPS->database_version ()), *pOP= &oPK, *pIP= pPK;
		int repeat= 0;
		int DefCopyValCryptoTag= 1;
		do{
			pOP->Create(pIP->PageSize);
			if (pOP->setFHandle(c_io_open(pOP->FileName, ACE_OS_O_EXCL| ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT)) == -1) {
				LOG_E (("(%s)abort in IndexFilesCopy(!)", pOP->FileName));
				pOP->abort();
			}
                        //ace_os_ltrunc(pOP->getFHandle(), 0);
			memcpy(pOP->SystemPageBuf, pIP->SystemPageBuf, pIP->PageSize);
			pOP->LastPage= pIP->LastPage;
			pOP->m_pCryptoTag= (char*)&DefCopyValCryptoTag;
			int ii= pIP->LastPage;
			char *Bff= (char*)pIP->AllocBuf();
			while(ii){
				pIP->GetPage(ii, Bff);
				pOP->PutPage(ii, Bff);
				ii--;
			}
			pIP->FreeBuf(Bff);
			if(!repeat++){
				pOP= &oPS;pIP= pPS;
			}else
				break;
		}while(1);
#ifdef USE_GLOBAL_DIC
		if(pWriteBuckup){
			fprintf(pWriteBuckup, FormatNDTGlobaTransactionLog, pK, pS);
			fflush(pWriteBuckup);
		}
#endif
	}
}

void IndexInLogEx(const char *fileName, const char *file_sName, PagedFile *file= 0, PagedFile *file_s= 0)
{
	char outPutK[NDTC_MAX_PATH_SIZE], outPutS[NDTC_MAX_PATH_SIZE];
	
	int len_pKS= (int)(strlen(fileName)&0x7fffffff);
	memcpy(outPutK, fileName, len_pKS);
	strcpy(outPutK+len_pKS, extBckK);
#ifdef USE_GLOBAL_DIC
	len_pKS= (int)strlen(file_sName);
	memcpy(outPutS, file_sName, len_pKS);
	strcpy(outPutS+len_pKS, extBckS);

	char tmpbufDT[256];
	ACE_OS::tzset();
	time_t seconds_since_1970 = ACE_OS::time();
	tm* tm_local_time = ACE_OS::localtime(&seconds_since_1970);
	ACE_OS::strftime(tmpbufDT, 256, "%c", tm_local_time);
#endif
	if(pNDTCloneLOG){
#ifdef USE_GLOBAL_DIC
		::fprintf(pNDTCloneLOG, StartFormat, tmpbufDT);

		::fprintf(pNDTCloneLOG, CopyFormat, fileName, file_sName);
#endif
		if(file && file_s)
			IndexFilesCopy(outPutK, outPutS, file, file_s);
#ifdef USE_GLOBAL_DIC
		seconds_since_1970 = ACE_OS::time();
		tm_local_time = ACE_OS::localtime(&seconds_since_1970);
		ACE_OS::strftime(tmpbufDT, 256, "%c", tm_local_time);
		::fprintf(pNDTCloneLOG, EndFormat, tmpbufDT);
		::fflush(pNDTCloneLOG);
#endif
	}
}

void IndexInLog(PagedFile *file, StreamFile *s)
{
	IndexInLogEx(file->FileName, s->file->FileName, file, s->file);
}



FILE* copy_In_Pre(const char *fname, BackupedFileNameMap *pOutFiles, int skipSecond)
{
#ifdef WITH_LOG_FILE
	int fh= c_io_open(fname, ACE_OS_O_RDONLY | ACE_OS_O_BINARY);
	if(fh != -1){
		BackupedFileNameMap BackupedFileNameMapPre(0);
		int size= c_io_lseek(fh, 0, ACE_OS_SEEK_END), sizeFirst= size;
		c_io_lseek(fh, 0, ACE_OS_SEEK_SET);
		char tmp;
		while(sizeFirst-- && c_io_read(fh, &tmp, 1) && tmp != '&');
		if(sizeFirst > 0 && tmp == '&'){
			char *pBuff= (char *)alloca(size-sizeFirst + NDTC_MAX_PATH_SIZE + NDTC_MAX_PATH_SIZE),
					*pOut, *pOut2= 0;
			c_io_lseek(fh, 0, ACE_OS_SEEK_SET);
			sizeFirst= size;
			while(sizeFirst > 0){
				pOut= pBuff;
				while(sizeFirst-- && c_io_read(fh, &tmp, 1) && tmp != '&'){
					*pOut++= tmp;
				}
				if(sizeFirst > 0 && tmp == '&'){
					do{
						char *ptmpA= pOut - 1;
						int fndExt= 0;
						while(*ptmpA != 0x09){
							if(*ptmpA == '.')
								fndExt= 1;
							else if(*ptmpA == '\\')
								break;
							else if(*ptmpA == '/')
								break;
							ptmpA--;
						}
						if(fndExt)
							break;
						*pOut++= '&';
						while(sizeFirst-- && c_io_read(fh, &tmp, 1) && tmp != '&'){
							*pOut++= tmp;
						}
					}while(sizeFirst > 0);
					pOut--;
					*pOut= 0;
					while(*pOut-- != 0x09);
					while(*pOut++ != ' ');
					BackupedFileNameMapPre[BackupedFileName(pOut)]= 3;
					pOut= pBuff;
					do{
						while(sizeFirst-- && c_io_read(fh, &tmp, 1) && tmp != '.'){
							*pOut++= tmp;
						}
						if(sizeFirst > 0 && tmp == '.'){
							if(sizeFirst-- && c_io_read(fh, &tmp, 1) && tmp == '.'){
								if(sizeFirst > 0 && sizeFirst-- && c_io_read(fh, &tmp, 1) && tmp == '.'){
									break;
								}else{
									*pOut++= '.';
									*pOut++= tmp;
								}
							}else{
								*pOut++= '.';
								*pOut++= tmp;
							}
						}else
							break;
					}while(1);
					*(pOut-1)= 0;
					BackupedFileNameMapPre[BackupedFileName(pBuff+1)]= 3;
				}
			};
		}
		c_io_close(fh);
		char PreDir[NDTC_MAX_PATH_SIZE], outDir[NDTC_MAX_PATH_SIZE], outPutK[NDTC_MAX_PATH_SIZE]
				, *pFnd, ext_pre[]= ".old";
		strcpy(PreDir, pNDTCloneLOG_Dir);
		strcat(PreDir, ext_pre);
		const char *pName;
		int len;
		for(G_Point t= BackupedFileNameMapPre.first(); t; BackupedFileNameMapPre.next(t)){
			pName= BackupedFileNameMapPre.key(t).GetName();
			pFnd= (char*)strrchr(pName, '\\');
			len= pFnd - pName + 1;
			memcpy(outPutK, pName, len);
			memcpy(outDir, pName, len);
			if(!skipSecond){
				strcpy(outDir+len,PreDir);
				if(!pOutFiles)
					ace_os_mkdir(outDir); // GARANT_MSVCRT
				strcat(outDir+len, pFnd);
				strcpy(outPutK+len,pNDTCloneLOG_Dir);
				strcat(outPutK+len, pFnd);
			}else{
				strcpy(outDir+len-1, pFnd);
				unlink_rdonly(outDir);
				if(strrchr(pFnd+1, '(')){
					strcpy(outPutK+len-1, pFnd);
					unlink_rdonly(outDir);
				}else{
					strcpy(outPutK+len,pNDTCloneLOG_Dir);
					strcat(outPutK+len, pFnd);
					//int fhTst= c_io_open(outPutK, ACE_OS_O_RDONLY|ACE_OS_O_BINARY);
					//if(fhTst != -1){
						unlink_rdonly(outDir);
					//	c_io_close(fhTst);
					//}
				}
			}
			if(pOutFiles){
				(*pOutFiles)[BackupedFileName(outPutK)]= 1;
			}else
				rename_rdonly(outPutK, outDir);
		}
		strcpy(PreDir, fname);
		strcat(PreDir, ext_pre);
		unlink_rdonly(PreDir);
		if(pOutFiles){
			if(skipSecond)
				return 0;
			unlink_rdonly(fname);
		}else
			rename_rdonly(fname, PreDir);
	}
#endif
	return mpcxc_fopen(fname, "a+");
}

void Index::InitThis( PagedFile * tf, const char * name, StreamFile * s, IndexInfo *pOtherBuffer )
{
	/*if(*(tf->FileName+34) == '_' && *(tf->FileName+36) == 'v'){
		LOG_E (("Int key(%d, %d)... (%s,%d)", s, name, tf->FileName+31, KeyCount));
	}*/
	m_bAsNew= false;
	m_pCountOut= 0;
	StreamFile * Fs= 0;

	file=0; streams= 0;
	fileUpdt=0; streamsUpdt= 0; indexUpdt= 0;
    IndexInfo info;
	if(tf->pFirst == s)
		Fs= s;
	if(Fs && ((pOtherBuffer && (info= *pOtherBuffer).immdatasize != 0)
				|| (!pOtherBuffer && !tf->GetAttr ( name, &info, sizeof (info))))){
		if(Fs){
			char *fnd= strrchr(tf->FileName, '.');
			*fnd= 0;
			PagedFile *tmpS= GetCreatedPagedFile(tf->FileName, tf->database_version ());
			tmpS->Create(tf->PageSize, false);
			tf= tmpS;
			if(tf->IsOk()){
				StreamFile *stt = new StreamFile(0, s->file->PageSize);
				stt->Create();
				if(Fs){
		if(!Fs->pCreateOtherK){
			Fs->pCreateOtherK= (Index **)malloc(100 * sizeof(*Fs->pCreateOtherK));
			Fs->iCreateOther= 0;
		}
		stt->m_Fs= Fs;
		Fs->pCreateOtherK[Fs->iCreateOther++]= this;
				}
			s= stt;
			}else{
				LOG_E (("(%x)(%s)abort in Index::Index(!)", this, name));
				abort();
			}
			*fnd= '.';
		}
	}
	if(name)
		Init_Index ( tf, name, s );
	tf->pFirst= s;
}

Index::Index ( PagedFile * tf, const char * name, StreamFile * s)
	: BTree ()
{
	InitThis( tf, name, s);
	SkipFirstBackupIndex();
}

Index::Index ( ::PagedFile * tf, const char * name, StreamFile * s)
	: BTree ()
{
	InitThis( (NdtClone::PagedFile*)tf, name, s);
	SkipFirstBackupIndex();
}

void Index :: Init_Index ( PagedFile * tf, const char * name, StreamFile * s )
{
	if(s->Flags & SF_IN_OPERATION) {
		LOG_E (("(%x)(%s)abort in Index::Index(InOperation!)", this, name));
		abort();
	}
	if(s->Flags & SF_IN_TRANSCTN && (s->file->m_mode & (~0x3000))) {
		LOG_E (("(%x)(%s)abort in Index::Index(InTransaction!)", this, name));
		abort();
	}
#ifdef _DEBUG
	if(s && s->ostreams && s->ostreams->first()) {
		LOG_E (("(%x)(%s)abort in Index::Index(EndTransaction!)", this, name));
		abort();
	}
#endif
	if(Name != name) strcpy ( Name, name );
    IndexInfo info;
	int def_COPY= 0;

	file=tf;
	if(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT)) && !s->GetSysBuff() && file->getFHandle() != -2 && (def_COPY= IsGlobalTransaction(SF_IN_FIRST_COPY)) != -1){
		if(!s->file){
			char *pFndRpls= strrchr(file->FileName, '.');
			*(pFndRpls + 1)= 's';
			s->file= GetUpdatedPagedFile(file->FileName, file->database_version ());
			if(!(s->file->IsOk()))
				::abort();
			*(pFndRpls + 1)= 'k';
			if((tf->PageSize - s->file->PageSize) == 4 && (*(int*)(tf->SystemPageBuf+s->file->PageSize)) > 0)
				memcpy(s->file->SystemPageBuf, tf->SystemPageBuf,s->file->PageSize);
		}
		s->Flags |= SF_IN_OPERATION;
		char *pNameF= strdup(s->GetBackupName()), *Fnd= strrchr(pNameF, '.')+1;
		s->m_hBackup= c_io_open(s->GetBackupName(), ACE_OS_O_EXCL|ACE_OS_O_RDWR|ACE_OS_O_BINARY);
		int gpage= -1;
		if((s->m_hBackup != -1 || (memcpy(s->GetBackupName()+(Fnd-pNameF),"tmp", 3) && (gpage= c_io_open(s->GetBackupName(), ACE_OS_O_EXCL|ACE_OS_O_RDWR|ACE_OS_O_BINARY)) != -1))
				&& (gpage != -1 || (*Fnd= '~') && c_io_open(pNameF, ACE_OS_O_RDONLY|ACE_OS_O_BINARY) == -1)){
	if(s->m_hBackup == -1){
		if(s->Flags & SF_NOT_RENAME_OLD_BCKP)
			; // after maked Restore this files //
		else{
			s->m_hBackup= gpage;
			Fnd= s->file->SystemPageBuf+s->file->PageSize;
			while(c_io_read (s->m_hBackup, &gpage, 4) == 4 && gpage){
				if(c_io_lseek(s->m_hBackup, 0, ACE_OS_SEEK_CUR) == 4){
				  if((c_io_read (s->m_hBackup, Fnd, tf->PageSize - 4) == tf->PageSize - 4 || (gpage= 0)) && gpage == *(int*)tf->SystemPageBuf){
					  memcpy(tf->SystemPageBuf+4, Fnd, tf->PageSize - 4);
					  gpage= ((int*)(((PagedFileHeader*)tf->SystemPageBuf)->reserved))[1];
					  s->file->LastPage= ((PagedFileHeader*)s->file->SystemPageBuf)->LastPage= ((int*)(((PagedFileHeader*)tf->SystemPageBuf)->reserved))[2];
					  ((int*)(((PagedFileHeader*)tf->SystemPageBuf)->reserved))[1]= ((int*)(((PagedFileHeader*)tf->SystemPageBuf)->reserved))[2]= 0;
					  memcpy(tf->SystemPageBuf+tf->PageSize, tf->SystemPageBuf, tf->PageSize);
					  if(s->file->PutAttr( pFatSizeName, &gpage, sizeof ( short ))){
						  tf->Flags &= ~PF_MODIFIED;
						  s->file->Flags &= ~PF_MODIFIED;
					  }else{
						  LOG_E (("abort in Index :: Init_Index(Restore100)"));
						  ::abort();
					  }
				  }
				  if(gpage == 0 || c_io_read (s->m_hBackup, &gpage, 4) != 4 || gpage == 0)
					break;
				}
				if(gpage & FAT_CHAIN){
					if(c_io_read(s->m_hBackup, Fnd, tf->PageSize) != tf->PageSize){
						  LOG_E (("abort in Index :: Init_Index(Restore101)"));
						  ::abort();
					}
					if(tf->PutPage(gpage & (~FAT_CHAIN), Fnd))
						;
					else{
						  LOG_E (("abort in Index :: Init_Index(Restore102)"));
						  ::abort();
					}
				}else{
					if(c_io_read(s->m_hBackup, Fnd, s->file->PageSize) != s->file->PageSize){
						  LOG_E (("abort in Index :: Init_Index(Restore111)"));
						  ::abort();
					}
					if(tf->PutPage(gpage, Fnd))
						;
					else{
						  LOG_E (("abort in Index :: Init_Index(Restore112)"));
						  ::abort();
					}
				}
			}
			gpage= 0;
			if(c_io_lseek(s->m_hBackup, 0, ACE_OS_SEEK_SET) != 0){
			  LOG_E (("abort in Index :: Init_Index(Restore200)"));
			  abort();
			}
			s->clearTmp(&gpage);
			memcpy(Fnd, s->file->SystemPageBuf, s->file->PageSize);
		}
	}else{
			char *pBff= s->file->SystemPageBuf+s->file->PageSize;
			if(tf->PageSize > s->file->PageSize)
				pBff= tf->SystemPageBuf+tf->PageSize;
			if(c_io_read (s->m_hBackup, pBff, tf->PageSize) == tf->PageSize && *(int*)pBff){
				if(*(long*)pBff == *(long*)(tf->SystemPageBuf)){
					memcpy(tf->SystemPageBuf, pBff, tf->PageSize);
					((PagedFileHeader*)(s->file->SystemPageBuf))->LastPage= ((int*)(((PagedFileHeader*)(tf->SystemPageBuf))->reserved))[1];
					if(!s->file->PutAttr ( pFatSizeName, &(((PagedFileHeader*)(s->file->SystemPageBuf))->LastPage), sizeof ( short ))){
						LOG_E (("abort in Index :: Init_Index(Restore0)"));
						abort();
					}
					if((gpage= c_io_lseek(tf->GetFileHandle(), 0, ACE_OS_SEEK_CUR)) == -1
						|| c_io_lseek(tf->GetFileHandle(), 0, ACE_OS_SEEK_SET) != 0
						|| c_io_write(tf->GetFileHandle(), pBff, tf->PageSize) != tf->PageSize
						|| c_io_lseek(tf->GetFileHandle(), gpage, ACE_OS_SEEK_SET) != gpage){
						LOG_E (("abort in Index :: Init_Index(Rest1)"));
						abort();
					}
					s->file->LastPage
						= ((PagedFileHeader*)(s->file->SystemPageBuf))->LastPage= ((int*)(((PagedFileHeader*)(tf->SystemPageBuf))->reserved))[2];
					if((gpage= c_io_lseek(s->file->GetFileHandle(), 0, ACE_OS_SEEK_CUR)) == -1
						|| c_io_lseek(s->file->GetFileHandle(), 0, ACE_OS_SEEK_SET) != 0
						|| c_io_write(s->file->GetFileHandle(), pBff, s->file->PageSize) != s->file->PageSize
						|| c_io_lseek(s->file->GetFileHandle(), gpage, ACE_OS_SEEK_SET) != gpage){
						LOG_E (("abort in Index :: Init_Index(Rest1)"));
						abort();
					}
					tf->LastPage= ((PagedFileHeader*)(tf->SystemPageBuf))->LastPage;
				}else if(*(int*)pBff != -1){
					LOG_E (("abort in Index :: (Other version backup this file)"));
					abort();
				}
				while(c_io_read (s->m_hBackup, &gpage, 4) == 4 && gpage){
					if(gpage & FAT_CHAIN){
						if(c_io_read (s->m_hBackup, pBff, tf->PageSize) == tf->PageSize){
							if(!tf->PagedFile::PutPage((gpage & (~FAT_CHAIN)), pBff)){
								LOG_E (("abort in Index :: Init_Index(Rest3)"));
								abort();
							}
						}else
							break;
					}else if(c_io_read (s->m_hBackup, pBff, s->file->PageSize) == s->file->PageSize){
						if(!s->file->PagedFile::PutPage(gpage, pBff)){
							LOG_E (("abort in Index :: Init_Index(Rest4)"));
							abort();
						}
					}else
						break;
				}
			}
			*Fnd= 'b';
			tf->curr_last= 0;
			if( c_io_lseek(s->m_hBackup, 0, ACE_OS_SEEK_SET) != 0
					||  c_io_write(s->m_hBackup, &(tf->curr_last), sizeof(tf->curr_last)) != sizeof(tf->curr_last)
					|| c_io_lseek(s->m_hBackup, 0, ACE_OS_SEEK_SET) != 0)
			{
				LOG_E (("abort in Index :: Init_Index(Rest5)"));
				abort();
			}
			memcpy(s->file->SystemPageBuf+s->file->PageSize,s->file->SystemPageBuf,s->file->PageSize);
			s->file->Flags &= ~PF_MODIFIED;
			memcpy(tf->SystemPageBuf+tf->PageSize,tf->SystemPageBuf,tf->PageSize);
			tf->Flags &= ~PF_MODIFIED;
			s->file->curr_last= s->file->LastPage;
			tf->curr_last= tf->LastPage;
			s->not_actual_BKP();
	}
		}else{
			*Fnd= '~';
			int KeysBkp= c_io_open(pNameF, ACE_OS_O_RDONLY|ACE_OS_O_BINARY);
			if(KeysBkp != -1){
				void *pTmp= file->AllocBuf();
				if((int)(file->PageSize&0x7fff) == c_io_read(KeysBkp, pTmp, (size_t)(file->PageSize&0x7fff))){
					if(((PagedFileHeader*)pTmp)->Signature != BASE_DATA_VERSION){
						if(((PagedFileHeader*)pTmp)->TomPerPages){
							s->file->LastPage= ((int*)(((PagedFileHeader*)pTmp)->reserved))[-1];
						}else
							s->file->LastPage= ((int*)(((PagedFileHeader*)pTmp)->reserved))[0];
					}else
						s->file->LastPage= ((int*)(((PagedFileHeader*)pTmp)->reserved))[0];

					s->file->FreePage= -1;//((int*)(((PagedFileHeader*)pTmp)->reserved))[1];
					s->file->lastFreePage= -1;//((int*)(((PagedFileHeader*)pTmp)->reserved))[2];

					memcpy(file->SystemPageBuf, pTmp, (size_t)(file->PageSize&0x7fff));
					while(c_io_read(KeysBkp, &gpage, sizeof(gpage)) == sizeof(gpage)
							&& c_io_read(KeysBkp, pTmp, (size_t)(file->PageSize&0x7fff)) == (int)(file->PageSize&0x7fff)){
						file->PutPage(gpage, pTmp);
					}
					/*if(ace_os_ltrunc(file->getFHandle(),file->PageSize+((PagedFileHeader*)pTmp)->LastPage * file->PageSize)
						||
						ace_os_ltrunc(s->file->getFHandle(),s->file->PageSize+s->file->LastPage * s->file->PageSize)){
						LOG_E (("abort in Index::Index"));
						abort();
					}*/
					file->Delete();
					file->Connect(file->FileName, file->m_mode);
				}
				file->FreeBuf(pTmp);
                                c_io_close(KeysBkp);
                                ace_os_unlink(pNameF);
                                //unlink_rdonly(pNameF);
			}
			if(s->m_hBackup != -1){
				short tmpSize= 0;
				{
					void *pTmp= s->file->AllocBuf();
					while(c_io_read(s->m_hBackup, &gpage, sizeof(gpage)) == sizeof(gpage)){
						if(!(gpage & 0x80000000l)){
							if(c_io_read(s->m_hBackup, pTmp, (size_t)(s->file->PageSize&0x7fff))
											== (int)(file->PageSize&0x7fff)){
								s->file->PutPage(gpage, pTmp);
							}else
								break;
						}else{
#ifdef MIN_MEM_CONTEXT
			if(s->pOtherBackuped){
				int otherPage= gpage & 0x7fffffff;
				if(!otherPage){
					if(c_io_read(s->m_hBackup, pTmp, s->pOtherBackuped->AttrOffs)
									== s->pOtherBackuped->AttrOffs){
						c_io_lseek(s->pOtherBackuped->GetFileHandle(), 0, ACE_OS_SEEK_SET);
						c_io_write(	s->pOtherBackuped->GetFileHandle()
										, pTmp, (int)s->pOtherBackuped->AttrOffs);
					}else
						break;
				}else{
					if(c_io_read(s->m_hBackup, pTmp, (int)s->pOtherBackuped->PageSize)
									== (int)s->pOtherBackuped->PageSize){
						s->pOtherBackuped->PutPage(otherPage, pTmp);
					}else
						break;
				}
				char name__[2048];
				strcpy(name__, s->pOtherBackuped->FileName);
				int mode__= s->pOtherBackuped->m_mode;
				s->pOtherBackuped->Delete();
				s->pOtherBackuped->Connect(name__, mode__);
			}else{
				LOG_E (("abort in Index::Index 277"));
				abort();
				break;
			}
#else
							break;
#endif
						}
					}
					char *defCryproTagK= s->file->m_pCryptoTag;
					s->file->Delete();
					s->file->Connect(s->file->FileName, s->file->m_mode);
					s->file->curr_last= s->file->LastPage;
					s->file->m_pCryptoTag= defCryproTagK;
					free(pTmp);
				}
				tf->curr_last= 0;
				if( c_io_lseek(s->m_hBackup, 0, ACE_OS_SEEK_SET) != 0
						||  c_io_write(s->m_hBackup, &(tf->curr_last), sizeof(tf->curr_last)) != sizeof(tf->curr_last)
						|| c_io_lseek(s->m_hBackup, 0, ACE_OS_SEEK_SET) != 0)
				{
					LOG_E (("abort in Index :: Init_Index(Rest585)"));
					abort();
				}
				tf->curr_last= tf->LastPage;
			}else{
				s->m_hBackup= 0;
				s->file->curr_last= s->file->LastPage;
				if((tf->PageSize - s->file->PageSize) == 4)
					tf->curr_last= s->file->LastPage;
				else
					tf->curr_last= tf->LastPage;
			}
		}
		free(pNameF);
		s->Flags &= ~SF_IN_OPERATION;
	}else if(file->getFHandle() != -2 && s->file->getFHandle() == -2){
		file->Delete(1);
		sprintf(file->FileName+strlen(file->FileName), formftCreate, /*createIndexCount++*/(unsigned int)(((size_t)file) & 0xffffffff));
		short tempPageSize= file->PageSize;
		file->Connect(file->FileName, ACE_OS_O_RDWR);
		file->Create(tempPageSize);
	}
    if(file->Exist()&& (file->getFHandle() != -2 || streams)  && getRootNode( Name, &info, sizeof (info), s))
	{
		if(file->getFHandle() != -2 && s->pFirst ){
			if(!s->m_PagesCacheKeys && (file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT)))){
				// увеличиваем кэш страничного файла ключей до минимума чтоб обеспечить 100% залочку страниц для всех индексов из оного файла //
				int z= 0;
				for ( int Offs = file->AttrOffs; Offs < file->PageSize && file->SystemPageBuf [Offs] != '\0'; Offs += file->SystemPageBuf [Offs],z++);
				s->m_PagesCacheKeys= new CachePagesMap(0);
				if(s->file->SystemPageBuf == s->pFirst->file->SystemPageBuf){
					z -= 2; // For attribs not index //
					if(((NPagedFile*)(s->pFirst->file))->m_maxPageCountInCache >  -((z + 1) * GKDB::BT_MAXDEPTH)){
						((NPagedFile*)(s->file))->m_maxPageCountInCache= ((NPagedFile*)(s->pFirst->file))->m_maxPageCountInCache= -((z + 1) * GKDB::BT_MAXDEPTH);
					}
				}else if(((NPagedFile*)(s->pFirst->file))->m_maxPageCountInCache >  -((z + 1) * GKDB::BT_MAXDEPTH)){
					((NPagedFile*)(s->pFirst->file))->m_maxPageCountInCache= -((z + 1) * GKDB::BT_MAXDEPTH);
				}
				s->pCreateOtherK= (Index **)malloc(100 * sizeof(*s->pCreateOtherK));
			}
			if(s->pCreateOtherK)
				s->pCreateOtherK[s->iCreateOther++]= this;
		}
		BTree::init(tf, &info.btinit);
		ImmDataSize = info.immdatasize;
		roundv = info.rndv;
		nstreams = info.nstreams;
	}else{
		BTree::init(tf, 0 );
		ImmDataSize = sizeof(IndexRecordData::RecordData);
		roundv = 1;
		nstreams = 1;
	}
	if(!s->GetSysBuff()){
#ifndef SAVE_ALL_FAT_ON_BUCKUP
		s->InitFirstMaps();
#endif
		pResultFileKeyName= file->FileName;
		if(s->m_bLoadFat){
			if(tf->Exist()){
				if((tf->PageSize - s->file->PageSize) == 4)
				{
					s->m_hBackup= tf->getFHandle();
					s->m_PagedBackupSystemPage= tf->SystemPageBuf;
					if(tf->CloseAllHandles(1))
						s->abort();
					if(*(int*)(tf->SystemPageBuf+s->file->PageSize)){
						// по возможным страницам в бэкапе восстанавливаем FAT //
						char *buff= (char*)alloca(tf->PageSize);
						int ffat= 1, *pFat, keysP= 0, lstNext;
						file->FreePage= 1;
						s->AllocFAT();
						pFat= s->Fat;
						try{
							do{
								do{
									if(!tf->GetPage(file->FreePage++,buff)){
										// error backup file //
										throw Error ();
									}
									lstNext= *(int*)buff;
									if(FAT_CHAIN & lstNext)
										keysP++;
									else{
										s->bpages->get(lstNext)= file->FreePage-1;
									}
								}while(lstNext && lstNext != ffat);
								if(ffat != 0x7fffffff){
									do{
										s->lastFatPage= ffat;
										if(lstNext == ffat){
											s->rpages->get(ffat)= 0;
											memcpy(pFat, buff+4, s->file->PageSize);
										}else{
											if(!s->file->GetPage ( ffat, pFat ))
												throw Error ();
										}
										////////////
										if((ffat= (s->Fat[ffat] & (~FAT_CHAIN)))){
											G_Point q= s->bpages->seek(ffat);
											pFat +=  s->file->PageSize / 4;
											if(q){
												if(!tf->GetPage(s->bpages->contents(q),buff)){
													// error backup file //
													throw Error ();
												}
												lstNext= ffat;
											}
										}else if(lstNext){
											// test all backup file //
											ffat= 0x7fffffff;
											break;
										}
									}while(ffat);
								}else
									break;
							}while(1);
							if(((NPagedFile*)file)->m_maxPageCountInCache < 0){
								if((-(((NPagedFile*)file)->m_maxPageCountInCache)) < keysP){
									((NPagedFile*)file)->m_maxPageCountInCache= -(4*(keysP/4)+4);
								}
							}
							keysP= s->bpages->length() - 1;
							if(((NPagedFile*)(s->file))->m_maxPageCountInCache < 0){
								if((-(((NPagedFile*)(s->file))->m_maxPageCountInCache)) < keysP){
									((NPagedFile*)(s->file))->m_maxPageCountInCache= -(4*(keysP/4)+4);
								}
							}
						}catch(...){
							throw Error ();
						}
						s->Clone_IO_File(tf);
						s->LoadFatEx(-1);
						file->FreePage--;
						keysP= (file->FreePage * (file->PageSize+4))+4; 
						if(c_io_lseek(s->m_hBackup, keysP, SEEK_SET) != keysP)
							throw Error ();
						s->Flags &= ~SF_FIRST_POS_BCKP;
					}else{
						s->Clone_IO_File(tf);
						s->LoadFat();
					}
				}else
					s->LoadFat();
			}else
				s->LoadFat();
		}else
			s->AllocSysBuf();
	}
	streams     = s;
	if(def_COPY == -1 || NDTGlobaTransactionNotCopy)
		s->Flags |= SF_IN_NOT_COPY;
	if(Root != -1){
	  if(!s->pFirst /*&& !s->m_hBackup && !s->m_hBackupKeys*/){
		if((file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT)))
				&& !(s->Flags & SF_IN_TRANSCTN) && !(s->Flags & SF_IN_AUTOTRANSCTN) && !(s->Flags & SF_IN_PRE_ATRANSCTN)){
#ifdef USE_GLOBAL_DIC
			//GUARD (m_mutexNDTGlobaTransactionLog);
			if(pNDTGlobaTransactionLog)
#else
			if(s->Flags & SF_GLOBAL_CREATE)
#endif
			{
				s->Flags |= SF_IN_PRE_ATRANSCTN;
			}
		}
		if(!(s->Flags & SF_IN_NOT_COPY)){
			s->Flags |= SF_IN_FIRST_LOG;
			if(!(s->Flags & SF_IN_PRE_ATRANSCTN)){
				s->Flags |= SF_IN_NOT_COPY;
				InitBackupStatstcs();
			}else{
				int currHandle= file->getFHandle();
				file->setFHandle(-2);
				InitBackupStatstcs();
				file->setFHandle(currHandle);
				if(!(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT))))
					streams->Flags |= SF_IN_FILE_DIRECT;
				else{
#ifdef USE_GLOBAL_DIC
					//GUARD (m_mutexNDTGlobaTransactionLog);
					if(pNDTGlobaTransactionLog)
#else
			if(s->Flags & SF_GLOBAL_CREATE)
#endif
					{
						streams->Flags |= SF_IN_FILE_DIRECT;
						streams->LastCreatedBlockPage = ++streams->file->LastPage;
#ifdef MIN_MEM_CONTEXT
						if(!streams->Fat){
							streams->m_deletedFat= streams->Fat = (int*)calloc(streams->file->PageSize, (streams->lastFatPage= streams->fatPages= 1));
						}
#endif
						streams->AddFat(streams->LastCreatedBlockPage, (int)(streams->file->PageSize&0x7fff) - streams->Fat[streams->LastCreatedBlockPage]);
					}
				}
			}
		}else
			InitBackupStatstcs();
	  }else
		  InitBackupStatstcs();
	}
	if(file->SystemPageBuf){
		if(/*((PagedFileHeader*)file->SystemPageBuf)->Signature != BASE_DATA_VERSION && */Root != -1 && !KeyCount && (file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT)))){
			if(streams->Flags & SF_GLOBAL_CREATE){
				// единичный индекс на новом стриме
				Root= Root;
			}else if(streams->Flags & SF_IN_FILE_DIRECT){
				// последующий индекс на новом стриме
				Root= Root;
			}else{
				//пустые индексы перемываем в несозданные //
				preRoot= Root;
				Root= -1;
			}
		}else if(!(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT)))){
			s->StartTransaction();
			//cachedPage(Root); // жёсткая валидация существующего индекса, тянущая тяжёлый физический GetPage в конструкторе
			file->skip_c_rtl_handle();
		}
	}
}

void Index::InitBackupStatstcsFile()
{
	if(file->getFHandle() != -2 && (file->m_mode & (~0x3000)) /*&& !streams->m_hBackup && !streams->m_hBackupKeys*/){
		streams->FirstRecord();
		/*char *pNameF= streams->GetBackupName(), *Fnd= strrchr(pNameF, '.')+1;
		*Fnd= '~';
		if(-1 == (streams->m_hBackupKeys= c_io_open(	pNameF
														, ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_WRONLY
															|ACE_OS_O_BINARY))){
			*Fnd= 'b';
			LOG_E (("abort in Index::InitBackupStatstcs1"));
			abort();
		}
		*Fnd= 'b';*/
	}
}

NDTKPageMap *createWCM()
{
	return new NDTKPageMap(MapDeflt);
}

void Index::InitBackupStatstcs()
{
#ifdef BIG_CLONE_LOG
	LOG_D (("(%x)Index(%s,%s)::InitBackupStatstcs()", this, Name, strrchr(streams->file->FileName, '_')));
#endif
	if(!(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT))) && !Stack){
		int repeat= GKDB::BT_MAXDEPTH;
		Stack= (BTStack*)calloc(repeat, sizeof(BTStack));
		/*while(repeat--){
			if(!Stack[repeat].curKey)
				Stack[repeat].curKey= (char*)calloc(1, KeyLength+256);
			if(!Stack[repeat].prevKey)
				Stack[repeat].prevKey= (char*)calloc(1, KeyLength+256);
		}*/
	}
	if(!streams->pFirst){
		if(!Stack){
			int repeat= GKDB::BT_MAXDEPTH;
			while(repeat--){
				if(!streams->Stack[repeat].curKey)
					streams->Stack[repeat].curKey= (char*)calloc(1,KeyLength+256);
				if(!streams->Stack[repeat].prevKey)
					streams->Stack[repeat].prevKey= (char*)calloc(1,KeyLength+256);
				streams->Stack[repeat].Pos= streams->Stack[repeat].Count= streams->Stack[repeat].Page= 0;
			}
			Stack= streams->Stack;
		}
#ifndef WRITE_KEYS_PAGE_INBACKUP
	InitBackupStatstcsFile();
	if(!pWritedPages && !(pWritedPages= new NDTKPageMap(MapDeflt))) {
			LOG_E (("abort in Index::InitBackupStatstcs2"));
			streams->abort();
	}
#else
	if(pReadedPages)
		delete pReadedPages;
	if(!(pReadedPages= new NDTPageNMap(s->dfltII)) || !(pBuckupedPages= new NDTPageNMap(s->dfltII))) {
			LOG_E (("abort in Index::InitBackupStatstcs3"));
			abort();
	}
	if(pBuckupedPages)
		delete pBuckupedPages;
	pBuckupedPages= 0;
#endif
		streams->pFirst= this; streams->pKfile= file;
	}else{
#ifndef WRITE_KEYS_PAGE_INBACKUP
		if(pWritedPages && pWritedPages != streams->pFirst->pWritedPages)
			delete pWritedPages;
		pWritedPages= streams->pFirst->pWritedPages;
#else
		if(pReadedPages)
			delete pReadedPages;
		pReadedPages= streams->pFirst->pReadedPages;

		if(pBuckupedPages)
			delete pBuckupedPages;
		pBuckupedPages= streams->pFirst->pBuckupedPages;
#endif
		if(!Stack){
			int repeat= GKDB::BT_MAXDEPTH;
			Stack= (BTStack*)calloc(repeat, sizeof(BTStack));
			while(repeat--){
				if(!Stack[repeat].curKey)
					Stack[repeat].curKey= (char*)calloc(1,KeyLength+256);
				if(!Stack[repeat].prevKey)
					Stack[repeat].prevKey= (char*)calloc(1,KeyLength+256);
			}
		}
	}
#ifdef USE_GLOBAL_DIC
	if(!(streams->Flags & SF_IN_PRE_ATRANSCTN)
			&& !(streams->Flags & SF_IN_TRANSCTN) && !(streams->Flags & SF_IN_AUTOTRANSCTN)){
		//GUARD (m_mutexNDTGlobaTransactionLog);
		if(pNDTGlobaTransactionLog){
			streams->Flags |= SF_IN_PRE_ATRANSCTN;
		}
	}
#endif
}

void Index::check_abort(void){
	if(file->SystemPageBuf
		&& ((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION
		&& !(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT))))
	{
		// Валидация в деструкторе индекса для рид-онли индексов БД СПС НЕ критична как в старом Индексе GKDB ! //
		return;
	}
	abort();
}

size_t gettmpnumber(const char * name, NdtClone::PagedFile *tst)
{
	size_t len= strlen(name), ln= len;
	memcpy(tst->FileName, name, len+1);

	sprintf(tst->FileName+len, formftCreate, 0);

	sprintf(tst->FileName+len, formftCreate, /*createIndexCount++*/(unsigned int)(((size_t)1968/*tst*/) & 0xffffffff));
	return len;
}

void Index::Free_pFirstStackAttribs()
{
	int repeat= GKDB::BT_MAXDEPTH;
	while(repeat--){
		if(Stack[repeat].curKey)
			gk_free(Stack[repeat].curKey);
		Stack[repeat].curKey= 0;
		if(Stack[repeat].prevKey)
			gk_free(Stack[repeat].prevKey);
		Stack[repeat].prevKey= 0;
	}
}

void Index::unlinkBackupHanle(bool bCloseAsFile){
	if(streams->m_hBackup){
		if(streams->m_hBackup == -1){
			// Странно, что Бизнес логика открыла хранилище на запись,
			// НИЧЕГО в хранилище НЕ записав
		}else if(streams->pKfile){
			if(streams->pKfile->file != streams->m_hBackup){
				if(streams->pKfile->file == streams->file->file)
				{
					streams->pKfile->SetFileHandle(streams->m_hBackup);
				}else
					if(bCloseAsFile) c_io_close(streams->m_hBackup);
			}else
				if(bCloseAsFile) c_io_close(streams->m_hBackup);
		}else{
			if(bCloseAsFile) c_io_close(streams->m_hBackup);
		}
		streams->m_hBackup= 0;
	}
}


Index::~Index()
{
	if(global_IsBlock())
		return;
  if(streams){
	/*if(*(file->FileName+34) == '_' && *(file->FileName+36) == 'v'){
		LOG_E (("Int key(%d, %d)... (%s,%d)", streams, Name, file->FileName+31, KeyCount));
	}*/
	int RO_Index= 0;
	StreamFile*	del_streams= 0;
	PagedFile*	del_file= 0;
	if(!(streams->Flags & SF_CREATE) || !(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT)))){
		RO_Index++;
		streams->EndTransaction();
	}
	{
		if(streams->Flags & SF_IN_AUTOTRANSCTN){
			//GUARD (m_mutexNDTGlobaTransactionLog);
			streams->EndTransaction(0);
			/*{
				atlIndexes.del(streams->pFirst);
			}*/
		}else if(!((streams->Flags & SF_IN_PRE_ATRANSCTN) || (streams->Flags & SF_IN_AUTOTRANSCTN))
					&& !(streams->Flags & SF_IN_TRANSCTN)  && (streams->Flags & SF_IN_FILE_DIRECT))
		{
			/*void *buff= alloca(streams->pFirst->file->PageSize);
			if(!streams->pFirst->pWritedPages->first() && streams->pFirst->GetPage(streams->pFirst->Root,buff)){
				streams->pFirst->pWritedPages->get(streams->pFirst->Root) = NDTKPage(streams->pFirst->file, buff);
			}*/
			streams->Flags &= ~SF_IN_FILE_DIRECT;
			streams->file->Flags |= SF_UPDT_ACTUAL;
			streams->BackupTransaction();
		}

	}
	if(!streams->pFirstStr){
		streams->pFirstStr= (Stream*)-1;
		streams->InitFirstMaps();
	}
	if(streams->Flags & SF_IN_OPERATION) {
		LOG_E (("(%x)(%s)abort in Index::~Index(InOperation!)", this, Name));
		check_abort();
	}
	if(!RO_Index && (streams->Flags & SF_IN_TRANSCTN)) {
		LOG_E (("(%x,%d)(%s)abort in Index::~Index(InTransaction!)", this, Name));
		check_abort();
	}
#ifdef _DEBUG
	Point firstI;
	if(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT)) && streams->ostreams && (firstI= streams->ostreams->first())) {
		ACE_UINT64 streamID= streams->ostreams->key(firstI);
		LOG_E (("(%x,%x:%x)(%s)abort in Index::~Index(EndTransaction!)", this,
					((int*)&streamID)[1], ((int*)&streamID)[0], Name));
		check_abort();
	}
#endif
	if(streams->pFirst == this){
	  if(streams->m_Fs){
		if(streams->m_Fs->pCreateOtherK){
			int ii= streams->m_Fs->iCreateOther;
			while(ii--){
				streams->m_Fs->pCreateOtherK[ii]->Free_pFirstStackAttribs();
			}
			{	// костыль для "раздражительных"(http://mdp.garant.ru/pages/viewpage.action?pageId=386663296), для ccb и pdb файлы как в 7.7 - tmp-ные
				char *r= strrchr(streams->file->FileName, 's');
				if(r && (*(int*)(r-4) == 778200176 || *(int*)(r-4) == 778199907)){
					streams->m_Fs->pFirst->streams->Flags |= FAT_CHAIN | SF_POST_CREATE_AS_TMP;
				}
			}
			streams->m_Fs->pFirst->StartBackupEx();
			free(Stack);
		}else{
			LOG_E (("(%x)(%s,%s)abort in Index::OpenN(!!)",
						this, Name,strrchr(streams->file->FileName, '_')));
			abort();
		}
	  }else{
		int rmve= 0;
		if(!KeyCount){
			//GUARD (m_mutexNDTGlobaTransactionLog);
			//atlIndexes.del(streams->pFirst);
			rmve++;
		}
		//streams->pFirst= 0;
		file->m_mode |= ACE_OS_O_BINARY;
		char *pKN= 0, *pSN;
		if(streams->Flags & SF_NOT_FIRST_DUMP){
		  streams->Flags &= ~SF_NOT_FIRST_DUMP;
		  if(!(streams->Flags & SF_IN_AUTOTRANSCTN) && streams->pKfile){
			pSN= strdup(streams->file->FileName);
			if(rmve && streams->file->PageSize > *(int*)streams->file->m_pCryptoTag){
				char deleted_name[NDTC_MAX_PATH_SIZE];
				strcpy(deleted_name,streams->pKfile->FileName);
				gettmpnumber(deleted_name, streams->pKfile);
				streams->pKfile->get_protected_path_name(deleted_name);
				*(strrchr(streams->pKfile->FileName,'('))= 0;
				*(strrchr(streams->pKfile->FileName,'.'))= 0;
				pKN= strdup(deleted_name);
			}else
				pKN= strdup(streams->pKfile->FileName);
		  }
		}else
			unlinkBackupHanle(true);

		streams->Flags &= ~SF_IN_AUTOTRANSCTN;
		/*Point ii= pWritedPages->first();
		if(ii){
			file->PagedFile :: PutPage ( 0, file->SystemPageBuf );
			NDTKPage *pDta;
			int flushed;
			do{
				flushed= pWritedPages->key(ii);
				if(	!(pDta= &pWritedPages->contents(ii))
						||
						!file->PutPage(flushed, pDta->GetData())) {
						LOG_E (("abort in StreamFile::BackupTransaction4"));
						abort();
				}
				pWritedPages->next(ii);
			}while(ii);
		}*/
		if(streams->pOldCreate && streams->pOldCreate != streams){
			streams->pOldCreate= 0;
			char *pNameF= strdup(streams->GetBackupName()), *Fnd= strrchr(pNameF, '.')+1;
			streams->FlushIndexPagedFileAdaptiveCache();
			streams->pFirst= 0;
			delete streams;
			streams= 0;
                        *Fnd= '~';
                        ace_os_unlink(pNameF);
                        //unlink_rdonly(pNameF);
			free(pNameF);
		}else{
			if(streams->Stack == Stack){
				streams->FlushIndexPagedFileAdaptiveCache();
				if(rmve && !streams->pKfile && !streams->m_hBackup && streams->file->PageSize > *(int*)streams->file->m_pCryptoTag){
					if(streams->file->protected_path_handle == -3){
						// автоматом не создаём уникальные файлы ключей новых пустых индексов //
						*(int*)streams->m_PagedBackupSystemPage= BASE_DATA_VERSION;
						streams->file->PageSize= 512-4;
						streams->file->protected_path_handle= streams->file->file;
					}
					/*else if(*(ACE_UINT64*)Name == (ACE_UINT64)0x695f657571696e75){
// костыль для удаления индексов пустых, но созданных,
// привет примитивной логике в сервера Ф1, лабающей новые индексы не потребованию
						streams->pFirst->file->Delete(222);
						streams->pFirst->file->Delete(222);
					}*/
				}
				streams->pFirst= 0;
				if(RO_Index){
					if(streams->file->GetFileHandle() < 1)
						streams->file->setFHandle(-1);
					if(!streams->pKfile)
						;
					else if(streams->pKfile->GetFileHandle() < 1)
						streams->pKfile->setFHandle(-1);
				}
				if(!streams->pKfile && streams->file->SystemPageBuf == file->SystemPageBuf){
					file->setFHandle(streams->file->protected_path_handle);
					file->SystemPageBuf= streams->m_PagedBackupSystemPage;
					((PagedFileHeader*)file->SystemPageBuf)->PageSize= streams->file->PageSize+4;
					((PagedFileHeader*)file->SystemPageBuf)->LastPage= file->LastPage= 0;
					file->SystemPageBuf= (char*)realloc(file->SystemPageBuf, (streams->file->PageSize+4)*2);
					memset(file->SystemPageBuf+file->PageSize, 0, (streams->file->PageSize+4)*2 - file->PageSize);
					file->PageSize= streams->file->PageSize+4;
					file->Delete();
				}
				if(streams->file->PageSize > *(int*)streams->file->m_pCryptoTag)
					del_file= streams->file;
				unlinkBackupHanle(true);
				streams->Delete();
			}else{
				streams->FlushIndexPagedFileAdaptiveCache();
				if(streams->file->m_mode & ~0x3000){
					streams->Delete();
				}else{
					if(streams->file->m_pCryptoTag
						&& ((streams->file->SystemPageBuf && ((PagedFileHeader*)streams->file->SystemPageBuf)->Signature == BASE_DATA_VERSION)
								|| streams->file->SystemPageBuf == 0))
					{
						if(streams->file->PageSize < *(int*)streams->file->m_pCryptoTag){
							streams->Delete();
							if(streams->pKfile){
								*(long*)streams->pKfile->m_pCryptoTag= 1;
								*(long*)streams->file->m_pCryptoTag= 1;
							}
						}else{
							streams->Delete();
						}
					}
				}
				int repeat= GKDB::BT_MAXDEPTH;
				while(repeat--){
					if(Stack[repeat].curKey)
						gk_free(Stack[repeat].curKey);
					Stack[repeat].curKey= 0;
					if(Stack[repeat].prevKey)
						gk_free(Stack[repeat].prevKey);
					Stack[repeat].prevKey= 0;
				}
				gk_free(Stack);
				Stack= 0;
			}
		}
#ifndef WRITE_KEYS_PAGE_INBACKUP
		if(pWritedPages)
			delete pWritedPages;
#else
		if(pReadedPages)
			delete pReadedPages;
		if(pBuckupedPages)
			delete pBuckupedPages;
#endif
		if(pKN){
			if(rmve){
				if(del_file){
					gettmpnumber(pSN, del_file);
					char deleted_name[NDTC_MAX_PATH_SIZE];
					del_file->get_protected_path_name(deleted_name);
					ace_os_rename(pSN,deleted_name);
				}
				ace_os_rename(file->FileName,pKN);
			}
			free(pSN);free(pKN);
		}
	  }
	}else if(Stack){
		int repeat= GKDB::BT_MAXDEPTH;
		while(repeat--){
			if(Stack[repeat].curKey)
				gk_free(Stack[repeat].curKey);
			Stack[repeat].curKey= 0;
			if(Stack[repeat].prevKey)
				gk_free(Stack[repeat].prevKey);
			Stack[repeat].prevKey= 0;
		}
		gk_free(Stack);
		Stack= 0;
	}
	if(del_streams)
		delete del_streams;
	if(del_file)
		delete del_file;
  }
}

void Index :: PrepareRecord  ( BTKEY key, char * buf1 )
{
	/*if(*(file->FileName+34) == '_' && *(file->FileName+36) == 'v'){
		LOG_E (("Add key(%d, %d)... (%s)", ((long*)key)[0], ((long*)key)[1], file->FileName+31));
	}*/
	m_bAsNew= true;
	if(CollectionStream == 55)
		return;
	char *first= (char*)recordData(buf1, 0);
	*(int *)first= 0;
	memcpy ( buf1, key, first-(char*)buf1);
	int count= nstreams - 1;
	while(count){
/*#ifdef _DEBUG
		// для Пьюрифая иницилизируем весь рекорд //
		memset(recordData(buf1, count), 0, sizeof(IndexRecordData));
#else*/
		*(int *)recordData(buf1, count)= 0;
//#endif
		count--;
	}
}
void Index :: PrepareStackBuffWrite()
{
	int page= Stack [Sp].Page;
	Point Fnd= 0;
	if(streams->Flags & SF_IN_FILE_DIRECT || page > file->curr_last || !(Fnd= pWritedPages->seek(page))){
		if(Stack [Sp].buf == 0){
			CachedPage *pFnd;
			if(!cachedPage(page, &pFnd))
				abort();
			Stack [Sp].buf =(char*)(pFnd->m_Data);
		}
		if(streams->Flags & SF_IN_FILE_DIRECT || page > file->curr_last){
			if(streams->m_PagesCacheKeys && (Fnd= streams->m_PagesCacheKeys->seek(page))){
				streams->m_PagesCacheKeys->contents(Fnd)->m_changed= 1;
			}
			return;
		}
		PutPage(page,Stack [Sp].buf);
		Fnd= pWritedPages->GetRootG_SimpleSplayNode();
	}
	Stack [Sp].buf= pWritedPages->contents(Fnd).GetData();
	if(streams->m_PagesCacheKeys && (Fnd= streams->m_PagesCacheKeys->seek(page))){
		streams->UpActualLevel((streams->m_PagesCacheKeys->contents(Fnd)),streams->m_PagesCacheKeys);
	}
}

char *	Index :: PrepareStackBuff( int page, char *pret, void*)
{
	/*if(m_firstMap){
		Stack [Sp= 0].Page  = page;
		if(AddPtr){
			if(AddPtr= m_firstMap->seek((char*)m_key)){
				memcpy(pret, m_firstMap->key((G_Point)AddPtr), KeyLength );
			}else{
				m_firstMap->get((char*)m_key);
				memcpy(pret, m_firstMap->key(m_firstMap->GetRootG_SimpleSplayNode()), KeyLength );
				KeyCount++;
			}
			*(int*)(pret-4)= 0;
			pret -= 6;
			*(short*)(Stack->buf= pret)= 1;
		}else if(AddPtr= m_firstMap->seek((char*)m_key)){
			*(int*)(pret-4)= 0;
			memcpy(pret, m_firstMap->key((G_Point)AddPtr), KeyLength );
			pret -= 6;
			*(short*)(Stack->buf= pret)= 1;
		}else{
			*(int*)(pret-4)= 0;
			pret -= 6;
			*(short*)(Stack->buf= pret)= 0;
		}
	}else*/{
		if(page == -1){
			if(Sp >= 2){
				Sp -= 2;
				while(Sp > -1){
					if(	Stack [Sp].Pos < Stack [Sp].Count
						&& Stack [Sp].Pos > 0
						&& Compare (m_key, Stack [Sp].curKey) < 0
						&& Compare (m_key, Stack [Sp].prevKey) > 0 )
					{
						break;
					}else
						Sp--;
				}
				Sp++;
				page = Stack [Sp].Page;
			}else
					{
						Sp= 0;
						page= Root;
					}
		}
		Stack [Sp].Page  = page;
#ifndef WRITE_KEYS_PAGE_INBACKUP
		if(streams->Flags & SF_IN_FILE_DIRECT || page > file->curr_last)
			;
		else{
			Point Fnd= pWritedPages->seek(page);
			if(Fnd){
				NDTKPage *pDta= &pWritedPages->contents(Fnd);
				if(streams->m_PagesCacheKeys && (Fnd= streams->m_PagesCacheKeys->seek(page))){
					streams->UpActualLevel((streams->m_PagesCacheKeys->contents(Fnd)),streams->m_PagesCacheKeys);
				}
				return (char*)(Stack [Sp].buf= pDta->GetData());
			}
		}
#endif
		pret= (char*)(Stack [Sp].buf= readPage(page));
	}
	return pret;
}

int Index :: GetPage(int page, void *buff)
{
	Point Fnd= pWritedPages->seek(page);
	if(Fnd){
		NDTKPage *pDta= &pWritedPages->contents(Fnd);
		if(streams->m_PagesCacheKeys && (Fnd= streams->m_PagesCacheKeys->seek(page))){
			streams->UpActualLevel((streams->m_PagesCacheKeys->contents(Fnd)),streams->m_PagesCacheKeys);
		}
		if(memcpy(buff, pDta->GetData(), file->PageSize))
			return 1;
		return 0;
	}
	return streams->GetKeysPageFromCache( page, buff );
}

int Index :: PutPage(int page, void *buff, int onlyPut)
{
	StartBackupEx();
	/*if(page <= file->curr_last && ((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION){
		IndexRecordData tmpR;
		memset(&tmpR, 0, sizeof(tmpR));
		tmpR.data.handle= page;
		tmpR.header.realDataLength= streams->file->PageSize;
		tmpR.header.allocatedDataLength= FAT_CHAIN;
		NdtClone::NDTKPageMap *pWritedPagesStr= streams->pWritedPages;
		streams->pWritedPages= pWritedPages;
		char *SysBuf= streams->SysBuf;
		streams->SysBuf= (char*)buff;
		{
			Stream strR(streams,&tmpR,ImmDataSize,roundv);
		}
		streams->pWritedPages= pWritedPagesStr;
		streams->SysBuf= SysBuf;
	}else */if(page > file->curr_last || streams->Flags & SF_IN_FILE_DIRECT || onlyPut == 1){
		if(!streams->m_PagesCacheKeys){
			streams->m_PagesCacheKeys= new CachePagesMap(0);
		}
		CachedPage *pFnd;
		if((pFnd= (CachedPage *)streams->m_PagesCacheKeys->seek(page))){
			pFnd= streams->m_PagesCacheKeys->contents(pFnd);
			streams->UpActualLevel(pFnd,streams->m_PagesCacheKeys);
			if(!onlyPut){
				pFnd->m_changed= 1;
				if(pFnd->m_Data != buff && !memcpy(pFnd->m_Data, buff, streams->pFirst->file->PageSize))
					return 0;
			}
		}else{
#ifdef POST_MARK_SP_KEYS
			CachedPage *pFnd1[GKDB::BT_MAXDEPTH];pFnd1[0]= 0;
			unsigned int actualLevel[GKDB::BT_MAXDEPTH];
#endif
			if(!onlyPut){
				/*if(streams->pFirst->file->LastPage == page){
					GUARD (streams->pFirst->file->m_mtxThreadWrite);
					if(!streams->pFirst->file->PutPage(page, buff))
						return 0;
				}*/
#ifdef POST_MARK_SP_KEYS
				if(streams->m_pCacheKeysStackCount == ((NPagedFile*)(streams->pFirst->file))->m_maxPageCountInCache){
					int Sp_first= 0;
					while(Sp_first < Sp){
						if((pFnd1[Sp_first]= (CachedPage *)streams->m_PagesCacheKeys->seek(Stack[Sp_first].Page))){
							pFnd1[Sp_first]= streams->m_PagesCacheKeys->contents(pFnd1[Sp_first]);
							actualLevel[Sp_first]= pFnd1[Sp_first]->actualLevel;
							pFnd1[Sp_first]->actualLevel = 0xffffffff;
						}
						Sp_first++;
					}
				}
#endif
				streams->AddPageFromCache(page	, streams->m_PagesCacheKeys
												, streams->pFirst->file
												, buff
												, &streams->m_pCacheKeysStack
												, &streams->m_pCacheKeysStackCount
												, /*streams->pFirst->file->LastPage == page ? 0 : */1);
#ifdef POST_MARK_SP_KEYS
				if(pFnd1[0]){
					int Sp_first= 0;
					while(Sp_first < Sp){
						if(pFnd1[Sp_first])
							pFnd1[Sp_first]->actualLevel = actualLevel[Sp_first]+1;
						Sp_first++;
					}
				}
#endif
			}else
				streams->AddPageFromCache(page	, streams->m_PagesCacheKeys
												, streams->pFirst->file
												, buff
												, &streams->m_pCacheKeysStack
												, &streams->m_pCacheKeysStackCount
												, 1);
		}
		return 1;
	}
	Point  Fnd=
#ifndef WRITE_KEYS_PAGE_INBACKUP
			pWritedPages
#else
			pBuckupedPages
#endif
							->seek(page);
#ifndef WRITE_KEYS_PAGE_INBACKUP
	if(!Fnd){
		pWritedPages->get(page) = NDTKPage(file, buff);
		return 1;
	}else if(pWritedPages->contents(Fnd).GetData() == buff)
		return 1;
	if(memcpy(pWritedPages->contents(Fnd).GetData(), buff, file->PageSize))
		return 1;
	return 0;
#else
	if(!Fnd && (Fnd= pReadedPages->seek(page))){
		if(!streams->m_hBackupKeys){
			char *pNameF= streams->GetBackupName(), *Fnd= strrchr(pNameF, '.')+1;
			*Fnd= '~';
			if(-1 == (streams->m_hBackupKeys= c_io_open(pNameF, ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_WRONLY|ACE_OS_O_BINARY))
					|| BuckupRoot(streams->m_hBackupKeys)){
				*Fnd= 'b';
				LOG_E (("abort in Index :: PutPage"));
				abort();
			}
			*Fnd= 'b';
		}
		void *pBff= file->AllocBuf();
		if(!pBff
				||
			!file->GetPage(page, pBff)
				||
			c_io_write(streams->m_hBackupKeys, &page, sizeof(page)) != sizeof(page)
			||
			c_io_write(streams->m_hBackupKeys, pBff, file->PageSize) != file->PageSize) {
			LOG_E (("abort in Index :: PutPage"));
			abort();
		}
		(*pBuckupedPages) [page] = 0;
	}
	return file->PutPage(page, buff);
#endif
}
PagedFile *Index::GetCreatedPagedFile(const char * name, int database_version)
{
	size_t sStr= strlen(name);
	char *pDummy= (char*)alloca(sStr+1);
	memset(pDummy, '*', sStr-4);
	strcpy(pDummy+sStr-4, ".key");
	PagedFile *ret= GetUpdatedPagedFile(pDummy, database_version);
	if(ret)
		memcpy(ret->FileName, name, sStr);
	return ret;
}



void Index::Create (short key_len, short rndv, short ns, short immsize)
{
	if(!file->SystemPageBuf)
		return;
	else if(preRoot){
		Root= preRoot;
		preRoot= 0;
		return;
	}else if(Root != -1 && ((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION){
		return;
	}
	if((key_len + ns*((short)(sizeof(IndexRecordData::RecordDataHeader)+immsize))) > file->PageSize)
		abort();
#ifndef _NOT_CREATE_BUCKUPED_SUBDIR
	{
#ifdef USE_GLOBAL_DIC
		GUARD (m_mutexNDTGlobaTransactionLog);
			if(pNDTGlobaTransactionLog){
			char	nameKey[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE],
					nameStr[NDTC_MAX_PATH_SIZE+NDTC_MAX_PATH_SIZE],
					*fnd0= strrchr(file->FileName, '\\');

			*fnd0= 0;
			strcpy(nameKey, file->FileName);
			strcat(nameKey, "\\");
			ace_os_mkdir(strcat(nameKey, "Backup.dir")); // GARANT_MSVCRT

			*fnd0= '\\';
			strcat(nameKey, fnd0);

			strcpy(nameStr, nameKey);
			fnd0= strrchr(streams->file->FileName, '\\');
			strcpy(strrchr(nameStr, '\\')+1, fnd0+1);

			fprintf(pNDTGlobaTransactionLog, FormatNDTGlobaTransactionLog,
						nameKey, nameStr);
			fflush(pNDTGlobaTransactionLog);
		}
#else
		if(!streams->file){
			char *pFndRpls= strrchr(file->FileName, '(');
			if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION){
				if(*(pFndRpls - 8) == '0')
					*(pFndRpls - 8)= '9';
				else if(*(pFndRpls - 8) == '1')
					*(pFndRpls - 8)= '8';
				else if(*(pFndRpls - 8) == '2')
					*(pFndRpls - 8)= '7';
				else if(*(pFndRpls - 8) == '3')
					*(pFndRpls - 8)= '6';
				else if(*(pFndRpls - 8) == '5')
					*(pFndRpls - 8)= '4';
				else if(*(pFndRpls - 8) == 'k')
					*(pFndRpls - 8)= 's';
				*(pFndRpls - 7)= 't';
				*(pFndRpls - 6)= 'r';
			}else{
				*(pFndRpls - 6)= 's';
			}
			*(pFndRpls - 5)= 0;
			streams->file= GetCreatedPagedFile(file->FileName, file->database_version ());
			streams->file->Create(streams->m_bLoadFat);
			streams->Create();
			if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION){
				if(*(pFndRpls - 8) == '9')
					*(pFndRpls - 8)= '0';
				else if(*(pFndRpls - 8) == '8')
					*(pFndRpls - 8)= '1';
				else if(*(pFndRpls - 8) == '7')
					*(pFndRpls - 8)= '2';
				else if(*(pFndRpls - 8) == '6')
					*(pFndRpls - 8)= '3';
				else if(*(pFndRpls - 8) == '4')
					*(pFndRpls - 8)= '5';
				else if(*(pFndRpls - 8) == 's')
					*(pFndRpls - 8)= 'k';
				*(pFndRpls - 7)= 'e';
				*(pFndRpls - 6)= 'y';
			}else{
				*(pFndRpls - 6)= 'k';
			}
			*(pFndRpls - 5)= '.';
		}
		IndexInLogEx(file->FileName, streams->file->FileName);
#endif
	}
#endif
	if( rndv < 1 )
		rndv = 1;
	if( immsize < sizeof(IndexRecordData::RecordData) )
		immsize = sizeof(IndexRecordData::RecordData);
	if( ns < 1)
		ns=1;
	ImmDataSize = immsize;
	roundv = rndv;
	nstreams = ns;
	if(file->getFHandle() != -2){
		BTree::Create ( key_len + ns*(sizeof(IndexRecordData::RecordDataHeader)+immsize) );
	}else
		KeyLength= key_len + ns*(sizeof(IndexRecordData::RecordDataHeader)+immsize);
	InitBackupStatstcs();
}

void Index::PutRootPage(void  * buf)
{
    if(!file -> PutPage ( Root, buf )) {
		LOG_E (("abort in Index::PutRootPage"));
		abort();
	}
    file -> FreeBuf ( buf );
    if(file->PageSize > *(int*)file->m_pCryptoTag){
	int modeCurr= file->m_mode;
	char *defCryproTagK= file->m_pCryptoTag, *defCryproTagS= streams->file->m_pCryptoTag;
	StreamFile *pFirstF= (StreamFile *)file->pFirst;
	//file->m_mode |= ACE_OS_O_BINARY;
	file->Delete();
	file->Connect(file->FileName, modeCurr
	#ifdef COMPATIBILITY_FILE_SIZE
													, file->m_max_paged_file_per_bytes
	#endif
																		);
	file->m_pCryptoTag= defCryproTagK;
	modeCurr= streams->file->m_mode;
	//streams->file->m_mode |= ACE_OS_O_BINARY;
	streams->file->Delete();
	streams->file->Connect(streams->file->FileName, modeCurr
	#ifdef COMPATIBILITY_FILE_SIZE
													, streams->file->m_max_paged_file_per_bytes
	#endif
																		);
	streams->file->m_pCryptoTag= defCryproTagS;
	file->pFirst= pFirstF;
    }
}

//##ModelId=3BFE7DEA00BE
int	Index :: Rename ( BTKEY key1, BTKEY key2 )
{
	char	KeyBuf [256];

	assert ( KeyLength <= sizeof ( KeyBuf ) );

	if ( FindKey ( key1, KeyBuf ) != GKDB::BT_OK )
		return 0;

	if ( DelKey ( key1 ) != GKDB::BT_OK )
		return 0;

	memmove ( KeyBuf, key2, KeyLength - nstreams*(sizeof(IndexRecordData::RecordDataHeader)+ImmDataSize));
	return AddKey ( KeyBuf ) == GKDB::BT_OK;
}

Stream * Index :: Open ( BTKEY key, int AutoCreate, int *pCreated )
{
	return OpenN(key, 0, AutoCreate, pCreated);
}

Stream* Index::OpenN(IndexRecordData *pData)
{
	return Index::OpenN ( (BTKEY)pData, -22 );
}

void Index :: realMakeTempFiles()
{
	if(file->getFHandle() == -2){
		if(file->setFHandle(c_io_open(file->FileName, ACE_OS_O_EXCL| ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT))
			== -1){
			LOG_E (("(%x)(%s,%s)abort in Index::OpenN(!!!)",
						this, Name,strrchr(streams->file->FileName, '_')));
			abort();
		}
	}
	if(streams->file->getFHandle() == -2){
#ifdef MAKE_HDD
		if(streams->file->setFHandle(c_io_open(streams->file->FileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT))
			== -1){
			LOG_E (("(%x)(%s,%s)abort in Index::OpenN(!!!)",
						this, Name,strrchr(streams->file->FileName, '_')));
			abort();
		}
		if(!file->LastPage && file->m_pCryptoTag && (*(int*)file->m_pCryptoTag) > file->PageSize){
			// формируем зону записываемых страниц вне тёмного крипто тега,
			// чтоб запись значимых страниц была реальна на хард
			int kSZ= *(int*)file->m_pCryptoTag, sSZ= *(int*)streams->file->m_pCryptoTag;
			if(streams->Flags & SF_GLOBAL_CREATE){
				kSZ= /*MAX_CRYPTED_BLOCK_IN_WORK-file->PageSize*/(2048*3) + streams->file->PageSize;
				sSZ= /*MAX_CRYPTED_BLOCK_IN_WORK*/(4096*2) + streams->file->PageSize;
			}
			file->LastPage= (kSZ/file->PageSize)-1;
			streams->file->LastPage= sSZ/streams->file->PageSize;
			streams->Fat[1]= 0;
			streams->Fat[streams->file->LastPage]= FAT_CHAIN;
		}
#endif
		BTree::Create ( KeyLength );
	}
}

static void skip_backup_index( Index *pIndex )
{
		if(pIndex->file->getFHandle() != -2 && pIndex->file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT))){
	size_t p1= strlen(pIndex->file->FileName), s1= strlen(pIndex->streams->file->FileName);
/*	char	*pKey= (char*)alloca(p1+strlen(extBckK)+1),
			*pStr= (char*)alloca(s1+strlen(extBckS)+1);
	memcpy(pKey, pIndex->file->FileName, p1+1);
	memcpy(pStr, pIndex->streams->file->FileName, s1+1);
	strcat(pKey, extBckK);
	strcat(pStr, extBckS);
	{
		//GUARD (m_mutexBackupedFileNameMap);
		BackupedFileNameMapAll[BackupedFileName(pKey)]= 2;
		BackupedFileNameMapAll[BackupedFileName(pStr)]= 2;
	}*/
		}
}

void Index :: SkipFirstBackupIndex()
{
	skip_backup_index( this );
}

void Index :: PutInfo()
{
	IndexInfo info;
	BTree :: shutdown(&info.btinit);
	info.immdatasize = ImmDataSize;
	info.rndv = roundv;
	info.nstreams = nstreams;
	if( file->IsOk() ){
		if(((PagedFileHeader*)streams->file->SystemPageBuf)->Signature == BASE_DATA_VERSION)
			file->PutAttr(Name, &info, int(sizeof(info)));
		else
			streams->file->PutAttr(Name, &info, int(sizeof(info)));
	}
}

void Index :: StartBackupEx ( int AutoCreate )
{
	if(streams->pFirst == this && !(streams->Flags & SF_CREATE)){
		//int CopyHandBuckup= 0;
		//Index **pCreateOtherK= streams->pCreateOtherK;
		//IndexInfo info;
		int AllI= 0, oo= 0, AsDirect= 0;
		char *pFndNew= 0, *pPreFndNew= 0;
/*#ifndef USE_GLOBAL_DIC
		if(!KeyCount && (streams->Flags & SF_IN_TRANSCTN))
			streams->Flags |= SF_GLOBAL_CREATE;
#endif*/
		/*if(!pCreateOtherK)*/{
			if(streams->m_Fs){
				if(streams->m_Fs->pCreateOtherK){
					streams->m_Fs->pFirst->StartBackupEx();
				}else{
					LOG_E (("(%x)(%s,%s)abort in Index::OpenN(!!)",
								this, Name,strrchr(streams->file->FileName, '_')));
					abort();
				}
			}else if(!KeyCount &&
									(((pPreFndNew= strrchr(file->FileName, '.'))&&(pFndNew= strrchr(pPreFndNew, '(')))
										|| ((pPreFndNew= strrchr(streams->file->FileName, '.'))&&strrchr(pPreFndNew, '('))
																				)
																					)
			{
			if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION)
			{
				if(!pFndNew){
					strcpy(strrchr(file->FileName, 0),pPreFndNew);
					pFndNew= strrchr(pPreFndNew, '(');
					// В этой версии - рано размещать би-дерево в персонифицированных стримах
					//file->LastPage= streams->lastFatPage-1;
					//
					file->LastPage= (*(int*)file->m_pCryptoTag)/file->PageSize
													? (*(int*)file->m_pCryptoTag)/file->PageSize
														: 1;
					file->LastPage--;
				}else
					pPreFndNew= 0;

				file->FreeBuf(CreateInfo(KeyLength));
				//CopyHandBuckup++;
//if(CopyHandBuckup)
{
	PutInfo();
	char *pKey, *pStr, *defCryproTagK= file->m_pCryptoTag, *defCryproTagS= streams->file->m_pCryptoTag;

	int currFlags= strlen(streams->file->FileName), currTCount= 0;//streams->GetTransactionCounter();

	pStr= (char*)alloca(currFlags+16);
	memcpy(pStr, streams->file->FileName, currFlags+1);
	currFlags= strlen(file->FileName);
	pKey= (char*)alloca(currFlags+16);
	memcpy(pKey, file->FileName, currFlags+1);

	currFlags= streams->Flags;

	bool bOnlyAdd= false/*streams->onlyAdd()*/, bFastFAT= 0;
	int iInTrans= 0;

	StreamFile *pOldCreate= streams;
	PagedFile *strN= 0;
/*#ifndef BRDR32
	if(file->PageSize > *(int*)file->m_pCryptoTag)*/{
		/*if(currTCount){
			streams->Delete();
			strN= (PagedFile *)new NPagedFile(pStr, ACE_OS_O_RDWR, file->database_version ());
			strN->m_pCryptoTag= defCryproTagS;
			file->Connect(file->FileName, ACE_OS_O_RDWR);
			file->m_pCryptoTag= defCryproTagK;
			file->Delete();
		}
		else{
			streams->pKfile->m_mode |= ACE_OS_O_BINARY;
			streams->pKfile->Delete();*/streams->pKfile= 0;
		//}
		*strrchr(pKey, '.')= 0;
		if(strrchr((pPreFndNew ? pPreFndNew : strrchr(streams->file->FileName, '.')), '('))
			*strrchr(pStr, '.')= 0;
	}/*else
#endif
	{
		*strrchr(pKey, '.')= 0;
		*strrchr(pStr, '.')= 0;
		c_io_close(file->getFHandle());
		c_io_close(streams->file->getFHandle());
		strN->m_pCryptoTag= (char*)&DefValCryptoTag;
	}*/
	/*if(currTCount){
		strN->Delete();
		{
			IndexInLogEx(pKey, pStr);
		}
	}*/
	/*char tmpPreStr[NDTC_MAX_PATH_SIZE], *extPre= strrchr(strN->FileName, '(');
	if(currTCount) {
		//memcpy(tmpPreStr, strN->FileName, extPre-strN->FileName);
		//strcpy((char*)tmpPreStr+(extPre-strN->FileName), "(0)");
		//rename_rdonly(strN->FileName, tmpPreStr);
		rename_rdonly(tmpPreStr, pStr);
	}
	if(currTCount) rename_rdonly(file->FileName, pKey);*/
	//if(currTCount) rename_rdonly(tmpPreStr, pStr);
/*#ifndef BRDR32
	if(file->PageSize > *(int*)file->m_pCryptoTag)*/{
		//file->m_mode |= ACE_OS_O_BINARY;
		//file->Connect(pKey, ACE_OS_O_RDWR);
		//file->m_pCryptoTag= defCryproTagK;
		/*if(currTCount) {
			strN->Connect(pStr, ACE_OS_O_RDWR);
			strN->m_pCryptoTag= defCryproTagS;
		}*/
		if(bOnlyAdd)
			streams= new StreamFileFastAdd(strN);
		else{
			try{
				streams->m_bLoadFat= 0;
				memset(streams->aSysBuf, 0, streams->file->PageSize);
				/*if(((PagedFileHeader*)streams->file->SystemPageBuf)->Signature == BASE_DATA_VERSION)*/{
					((NPagedFile*)(streams->pFirst->file))->m_maxPageCountInCache *= 100;
					((NPagedFile*)(streams->file))->m_maxPageCountInCache *= 100;
				}
				streams->file->LastPage= streams->lastFatPage;
				streams->AddPageFromCache(	streams->LastCreatedBlockPage= (streams->lastFatPage+1)
											, streams->m_PagesCacheBlocks, streams->file, streams->SysBuf
											, &(streams->m_pCacheBlocksStack), &(streams->m_pCacheBlocksStackCount));
				streams->file->FreeBuf(streams->aSysBuf);
				streams->aSysBuf= streams->SysBuf= 0;
				streams->fpages= new STRPageNMap(streams->dfltII);
				streams->Fat[streams->LastCreatedBlockPage] = int(streams->file->PageSize & 0x7fff);
				streams->fpages->get(streams->file->LastPage)= 0;
				bFastFAT= true;
				if((iInTrans= streams->GetTransactionCounter()))
					streams->Flags &= ~SF_IN_TRANSCTN;
			}catch(...){
				abort();
			}
		}
	}/*else
#endif
	{
		file->setFHandle(c_io_open(pKey, ACE_OS_O_RDWR | ACE_OS_O_BINARY));strcpy(file->FileName, pKey);
		file->m_postFilePoss[0]= 0;
		streams->file->setFHandle(c_io_open(pStr, ACE_OS_O_RDWR | ACE_OS_O_BINARY));strcpy(streams->file->FileName, pStr);
		streams->file->m_postFilePoss[0]= 0;
		streams->Flags= 0;
		streams->SetTransactionCounter(0);
		streams->pFirst= 0;
		if(streams->file->m_pCryptoTag){
			streams->lastFatPage= (*(int*)streams->file->m_pCryptoTag)/streams->file->PageSize
											? (*(int*)streams->file->m_pCryptoTag)/streams->file->PageSize
												: 1;
#ifdef MAKE_HDD
			if(streams->lastFatPage > 1)
				streams->lastFatPage= 3;
#endif
		}
	}*/
	/*{
		char pNameF[NDTC_MAX_PATH_SIZE];
		strcpy(pNameF, streams->GetBackupName());
		char *FndNameF= strrchr(pNameF, '.')+1;
		ace_os_unlink(streams->GetBackupName());
		*FndNameF= '~';
		ace_os_unlink(pNameF);
	}*/
	if(pFndNew){
		strcat(pKey, extBckK);
		strcat(pStr, extBckS);
#ifdef USE_GLOBAL_DIC
		{
			//GUARD (m_mutexBackupedFileNameMap);
			BackupedFileNameMapAll[BackupedFileName(pKey)]= 2;
			BackupedFileNameMapAll[BackupedFileName(pStr)]= 2;
		}
#endif
	}
	/*if(currTCount > 0){
#ifndef USE_GLOBAL_DIC
		if(currFlags & SF_GLOBAL_CREATE){
			streams->Flags |= SF_GLOBAL_CREATE;
		}
#endif
		Init_Index ( file, Name, streams );
#ifndef USE_GLOBAL_DIC
		currFlags &= ~SF_GLOBAL_CREATE;
#endif
		if(currFlags & SF_IN_AUTOTRANSCTN){
			//GUARD (m_mutexBackupedFileNameMap);
			BackupedFileNameMapAll[BackupedFileName(file->FileName)]= 2;
			BackupedFileNameMapAll[BackupedFileName(strN->FileName)]= 2;
		}else if(streams->Flags & SF_IN_PRE_ATRANSCTN){
			InitBackupStatstcsFile();
			currFlags |= SF_IN_NOT_COPY;
		}
	}else*/{
		streams->Flags |= SF_IN_PRE_ATRANSCTN;
		Index *pCreate= this;
		int fileTempCreate= -1;
		if(streams->pCreateOtherK)
			AllI= streams->iCreateOther;oo= AllI;
		do{
			if(pCreate != this){
				if(pCreate->streams->pFirst->pWritedPages)
					delete pCreate->streams->pFirst->pWritedPages;
				pCreate->streams->pFirst->pWritedPages= 0;
				{
					int repeat= GKDB::BT_MAXDEPTH;
					pCreate->Stack= (BTStack*)calloc(repeat, sizeof(BTStack));
					while(repeat--){
						pCreate->Stack[repeat].curKey= pCreate->streams->Stack[repeat].curKey;
						pCreate->Stack[repeat].prevKey= pCreate->streams->Stack[repeat].prevKey;
						pCreate->streams->Stack[repeat].curKey= pCreate->streams->Stack[repeat].prevKey= 0;
					}
				}
				pCreate->streams->pFirst= 0;
				pCreate->streams->file->setFHandle(-1);
				pCreate->streams->pKfile->setFHandle(-1);
				pCreate->streams->Delete();
				{
					PagedFile *del_page= pCreate->streams->file;
					delete pCreate->streams;
					del_page->m_mode |= ACE_OS_O_BINARY;
					delete del_page;
				}
				pCreate->file->m_mode |= ACE_OS_O_BINARY;
				delete pCreate->file;
				pCreate->file= file;
				pCreate->streams= streams;
				file->FreeBuf(pCreate->CreateInfo(pCreate->KeyLength));
				pCreate->PutInfo();
			}
			pCreate->Init_Index ( file, pCreate->Name, streams );
			if(pCreate->preRoot){
				if(!streams->m_PagesCacheKeys){
					streams->m_PagesCacheKeys= new CachePagesMap(0);
					if(((NPagedFile*)(streams->pFirst->file))->m_maxPageCountInCache >  -((streams->iCreateOther + 1) * GKDB::BT_MAXDEPTH))
						((NPagedFile*)(streams->pFirst->file))->m_maxPageCountInCache= -((streams->iCreateOther + 1) * GKDB::BT_MAXDEPTH);
				}
				if(	fileTempCreate == -1 ){
					char *SplitTmpName= strrchr(file->FileName, '.');
					if(*(int*)(file->m_pCryptoTag) > 1){
						SplitTmpName -= 4;
					}
					if(SplitTmpName && strrchr(SplitTmpName, '(')){
						*SplitTmpName= 0;
						streams->file->FileName[SplitTmpName-file->FileName]= 0;
						if((fileTempCreate= c_io_open(streams->file->FileName, ACE_OS_O_EXCL| ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT)) == -1)
							abort();
						streams->file->setFHandle(fileTempCreate);
					}
					if((fileTempCreate= c_io_open(file->FileName, ACE_OS_O_EXCL| ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT)) == -1)
						abort();
				}
				file->setFHandle(fileTempCreate);
				if(!file->::PagedFile::PutPage(pCreate->preRoot, streams->SysBuf))
					abort();
				file->::PagedFile::SetFileHandle(-2);
				streams->AddPageFromCache(	pCreate->preRoot, streams->m_PagesCacheKeys, file, streams->SysBuf
											, &streams->m_pCacheKeysStack, &streams->m_pCacheKeysStackCount);
				pCreate->Root= pCreate->preRoot; pCreate->preRoot= 0;
			}
		}while(oo-- && (pCreate= streams->pCreateOtherK[oo]));
		{
			streams->file->PostCreate();
			if(streams->file->IsWithProtectedPath()){
				streams->file->tmp_as_worked();
				if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION && (*(int*)file->m_pCryptoTag) > file->PageSize){
					// Персонифицированные дистрибутивы //
					streams->Fat[1] = FAT_CHAIN;
				}
			}else/* if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION)*/{
#ifndef OLD_SHORT_STR
				strcpy(strrchr(streams->file->FileName, '.')+4,".ntmp(0)")
#endif
																			;
			}/*else
				strcpy(strrchr(streams->file->FileName, '.')+2,".ntmp(0)")*/;
			file->setFHandle(fileTempCreate);
		}
	}
	/*if(streams->Flags & SF_IN_FILE_DIRECT)
		streams->Flags= SF_IN_FILE_DIRECT | SF_IN_FIRST_LOG | (currFlags & ~(SF_DELETE | SF_IN_PRE_ATRANSCTN));
	else*/
		streams->Flags= SF_IN_FIRST_LOG | (currFlags & ~(SF_DELETE | SF_IN_PRE_ATRANSCTN));
	if(bFastFAT)
		streams->Flags |= SF_LOAD_FAT_ON_DEMAND;
	if(iInTrans){
		streams->Flags |= SF_IN_TRANSCTN;
		streams->SetTransactionCounter(iInTrans);
	}
	/*streams->SetTransactionCounter(currTCount);

	oo= AllI;
	while(oo--){
#ifndef WRITE_KEYS_PAGE_INBACKUP
		pCreateOtherK[oo]->pWritedPages= 0;
#else
		pCreateOtherK[oo]->pReadedPages)= 0;
		pCreateOtherK[oo]->pBuckupedPages= 0;
		pCreateOtherK[oo]->pBuckupedPages= 0;
#endif
		if(currTCount){
			streams->Flags &= ~SF_IN_TRANSCTN;
			pCreateOtherK[oo]->Init_Index ( file, pCreateOtherK[oo]->Name, streams );
			streams->Flags |= SF_IN_TRANSCTN;
		}else{
			pCreateOtherK[oo]->Init_Index ( file, pCreateOtherK[oo]->Name, streams );
			if(pCreateOtherK[oo]->preRoot)
			{
				//AsDirect++;
				pCreateOtherK[oo]->Root= pCreateOtherK[oo]->preRoot; pCreateOtherK[oo]->preRoot= 0; }
		}
	}*/
	streams->Flags |= SF_CREATE;
	streams->pOldCreate= pOldCreate;
	/*if(AsDirect == AllI + 1){
		void *bf= alloca( streams->file->PageSize > file->PageSize ? streams->file->PageSize : file->PageSize );
		streams->pFirst->InitBackupStatstcsFile();
		streams->PreBackupTransaction();
		streams->AddFat(1, 0);
		streams->Flags |= SF_IN_FILE_DIRECT;
	}*/
}
			}else{
				/*if(!pFndNew){
					strcpy(strrchr(file->FileName, 0),pPreFndNew);
					pFndNew= strrchr(pPreFndNew, '(');
					// В этой версии - рано размещать би-дерево в персонифицированных стримах
					file->LastPage= streams->lastFatPage-1;
					//
					//file->LastPage= (*(int*)file->m_pCryptoTag)/file->PageSize
					//								? (*(int*)file->m_pCryptoTag)/file->PageSize
					//									: 1;
				}else*/
					pPreFndNew= 0;

				/*if(((PagedFileHeader*)streams->file->SystemPageBuf)->Signature == BASE_DATA_VERSION){*/
					file->LastPage= streams->lastFatPage+1;
				//}
				file->FreeBuf(CreateInfo(KeyLength));
				//CopyHandBuckup++;
//if(CopyHandBuckup)
{
	PutInfo();
	char *pKey, *pStr, *defCryproTagK= file->m_pCryptoTag, *defCryproTagS= streams->file->m_pCryptoTag;

	int currFlags= strlen(streams->file->FileName), currTCount= 0;//streams->GetTransactionCounter();

	pStr= (char*)alloca(currFlags+16);
	memcpy(pStr, streams->file->FileName, currFlags+1);
	currFlags= strlen(file->FileName);
	pKey= (char*)alloca(currFlags+16);
	memcpy(pKey, file->FileName, currFlags+1);

	currFlags= streams->Flags;

	bool bOnlyAdd= false/*streams->onlyAdd()*/, bFastFAT= 0;
	int iInTrans= 0;

	StreamFile *pOldCreate= streams;
	PagedFile *strN= 0;
/*#ifndef BRDR32
	if(file->PageSize > *(int*)file->m_pCryptoTag)*/{
		/*if(currTCount){
			streams->Delete();
			strN= (PagedFile *)new NPagedFile(pStr, ACE_OS_O_RDWR, file->database_version ());
			strN->m_pCryptoTag= defCryproTagS;
			file->Connect(file->FileName, ACE_OS_O_RDWR);
			file->m_pCryptoTag= defCryproTagK;
			file->Delete();
		}
		else{
			streams->pKfile->m_mode |= ACE_OS_O_BINARY;
			streams->pKfile->Delete();*/streams->pKfile= 0;
		//}
		*strrchr(pKey, '.')= 0;
		if(strrchr((pPreFndNew ? pPreFndNew : strrchr(streams->file->FileName, '.')), '('))
			*strrchr(pStr, '.')= 0;
	}/*else
#endif
	{
		*strrchr(pKey, '.')= 0;
		*strrchr(pStr, '.')= 0;
		c_io_close(file->getFHandle());
		c_io_close(streams->file->getFHandle());
		strN->m_pCryptoTag= (char*)&DefValCryptoTag;
	}*/
	/*if(currTCount){
		strN->Delete();
		{
			IndexInLogEx(pKey, pStr);
		}
	}*/
	/*char tmpPreStr[NDTC_MAX_PATH_SIZE], *extPre= strrchr(strN->FileName, '(');
	if(currTCount) {
		//memcpy(tmpPreStr, strN->FileName, extPre-strN->FileName);
		//strcpy((char*)tmpPreStr+(extPre-strN->FileName), "(0)");
		//rename_rdonly(strN->FileName, tmpPreStr);
		rename_rdonly(tmpPreStr, pStr);
	}
	if(currTCount) rename_rdonly(file->FileName, pKey);*/
	//if(currTCount) rename_rdonly(tmpPreStr, pStr);
/*#ifndef BRDR32
	if(file->PageSize > *(int*)file->m_pCryptoTag)*/{
		//file->m_mode |= ACE_OS_O_BINARY;
		//file->Connect(pKey, ACE_OS_O_RDWR);
		//file->m_pCryptoTag= defCryproTagK;
		/*if(currTCount) {
			strN->Connect(pStr, ACE_OS_O_RDWR);
			strN->m_pCryptoTag= defCryproTagS;
		}*/
		if(bOnlyAdd)
			streams= new StreamFileFastAdd(strN);
		else{
			try{
				if(((NPagedFile*)(streams->file))->m_maxPageCountInCache >  -((streams->iCreateOther + 1) * GKDB::BT_MAXDEPTH)){
					((NPagedFile*)(streams->file))->m_maxPageCountInCache= -((streams->iCreateOther + 1) * GKDB::BT_MAXDEPTH);
				}
				streams->m_bLoadFat= 0;
				memset(streams->aSysBuf, 0, streams->file->PageSize);
				streams->file->LastPage= streams->lastFatPage;
				streams->AddPageFromCache(	streams->LastCreatedBlockPage= (streams->lastFatPage+1)
											, streams->m_PagesCacheBlocks, streams->file, streams->SysBuf
											, &(streams->m_pCacheBlocksStack), &(streams->m_pCacheBlocksStackCount));
				streams->file->FreeBuf(streams->aSysBuf);
				streams->aSysBuf= streams->SysBuf= 0;
				streams->fpages= new STRPageNMap(streams->dfltII);
				streams->Fat[streams->LastCreatedBlockPage] = int(streams->file->PageSize & 0x7fff);
				streams->fpages->get(streams->file->LastPage)= 0;
				bFastFAT= true;
				if((iInTrans= streams->GetTransactionCounter()))
					streams->Flags &= ~SF_IN_TRANSCTN;
			}catch(...){
				abort();
			}
		}
	}/*else
#endif
	{
		file->setFHandle(c_io_open(pKey, ACE_OS_O_RDWR | ACE_OS_O_BINARY));strcpy(file->FileName, pKey);
		file->m_postFilePoss[0]= 0;
		streams->file->setFHandle(c_io_open(pStr, ACE_OS_O_RDWR | ACE_OS_O_BINARY));strcpy(streams->file->FileName, pStr);
		streams->file->m_postFilePoss[0]= 0;
		streams->Flags= 0;
		streams->SetTransactionCounter(0);
		streams->pFirst= 0;
		if(streams->file->m_pCryptoTag){
			streams->lastFatPage= (*(int*)streams->file->m_pCryptoTag)/streams->file->PageSize
											? (*(int*)streams->file->m_pCryptoTag)/streams->file->PageSize
												: 1;
#ifdef MAKE_HDD
			if(streams->lastFatPage > 1)
				streams->lastFatPage= 3;
#endif
		}
	}*/
	/*{
		char pNameF[NDTC_MAX_PATH_SIZE];
		strcpy(pNameF, streams->GetBackupName());
		char *FndNameF= strrchr(pNameF, '.')+1;
		ace_os_unlink(streams->GetBackupName());
		*FndNameF= '~';
		ace_os_unlink(pNameF);
	}*/
	if(pFndNew){
		strcat(pKey, extBckK);
		strcat(pStr, extBckS);
#ifdef USE_GLOBAL_DIC
		{
			//GUARD (m_mutexBackupedFileNameMap);
			BackupedFileNameMapAll[BackupedFileName(pKey)]= 2;
			BackupedFileNameMapAll[BackupedFileName(pStr)]= 2;
		}
#endif
	}
	/*if(currTCount > 0){
#ifndef USE_GLOBAL_DIC
		if(currFlags & SF_GLOBAL_CREATE){
			streams->Flags |= SF_GLOBAL_CREATE;
		}
#endif
		Init_Index ( file, Name, streams );
#ifndef USE_GLOBAL_DIC
		currFlags &= ~SF_GLOBAL_CREATE;
#endif
		if(currFlags & SF_IN_AUTOTRANSCTN){
			//GUARD (m_mutexBackupedFileNameMap);
			BackupedFileNameMapAll[BackupedFileName(file->FileName)]= 2;
			BackupedFileNameMapAll[BackupedFileName(strN->FileName)]= 2;
		}else if(streams->Flags & SF_IN_PRE_ATRANSCTN){
			InitBackupStatstcsFile();
			currFlags |= SF_IN_NOT_COPY;
		}
	}else*/{
		streams->Flags |= SF_IN_PRE_ATRANSCTN;
		Index *pCreate= this;
		int fileTempCreate= -1/*, getKey= 1*/;
		char *SplitTmpName;

		if(streams->pCreateOtherK)
			AllI= streams->iCreateOther;oo= AllI;
		do{
			if(pCreate != this){
				if(pCreate->streams->pFirst->pWritedPages)
					delete pCreate->streams->pFirst->pWritedPages;
				pCreate->streams->pFirst->pWritedPages= 0;
				{
					int repeat= GKDB::BT_MAXDEPTH;
					pCreate->Stack= (BTStack*)calloc(repeat, sizeof(BTStack));
					while(repeat--){
						pCreate->Stack[repeat].curKey= pCreate->streams->Stack[repeat].curKey;
						pCreate->Stack[repeat].prevKey= pCreate->streams->Stack[repeat].prevKey;
						pCreate->streams->Stack[repeat].curKey= pCreate->streams->Stack[repeat].prevKey= 0;
					}
				}
				pCreate->streams->pFirst= 0;
				pCreate->streams->file->setFHandle(-1);
				pCreate->streams->pKfile->setFHandle(-1);
				pCreate->streams->Delete();
				{
					PagedFile *del_page= pCreate->streams->file;
					delete pCreate->streams;
					del_page->m_mode |= ACE_OS_O_BINARY;
					delete del_page;
				}
				pCreate->file->m_mode |= ACE_OS_O_BINARY;
				delete pCreate->file;
				pCreate->file= file;
				pCreate->streams= streams;
				file->FreeBuf(pCreate->CreateInfo(pCreate->KeyLength));
				pCreate->PutInfo();
			}
			pCreate->Init_Index ( file, pCreate->Name, streams );
			if(pCreate->preRoot){
				if(!streams->m_PagesCacheKeys){
					streams->m_PagesCacheKeys= new CachePagesMap(0);
					if(((NPagedFile*)(streams->pFirst->file))->m_maxPageCountInCache >  -((streams->iCreateOther + 1) * GKDB::BT_MAXDEPTH))
						((NPagedFile*)(streams->pFirst->file))->m_maxPageCountInCache= -((streams->iCreateOther + 1) * GKDB::BT_MAXDEPTH);
				}
				if(	fileTempCreate == -1 ){
					SplitTmpName= strrchr(file->FileName, '.');
					if(*(int*)(file->m_pCryptoTag) > 1){
						SplitTmpName -= 4;
					}
					if(SplitTmpName && strrchr(SplitTmpName, '(')){
						strcat(file->FileName, pBuckupFileExt);
						if( streams->Flags & FAT_CHAIN && streams->Flags & SF_POST_CREATE_AS_TMP){
							// для хранилищ без ключей str файл как старый темп //
							strcat(streams->file->FileName, pBuckupFileExt);
							streams->Flags &= ~FAT_CHAIN;
						}else
						{
							/*if((fileTempCreate= c_io_open(file->FileName, ACE_OS_O_EXCL|ACE_OS_O_RDWR | ACE_OS_O_BINARY)) != -1){
								pKey[SplitTmpName-file->FileName]= 0;
								c_io_close(fileTempCreate);
								ace_os_rename(file->FileName,pKey);
								getKey= 0;
							}*/
							strcat(streams->file->FileName, pBuckupFileExt);
							if((fileTempCreate= c_io_open(streams->file->FileName, ACE_OS_O_EXCL|ACE_OS_O_RDWR | ACE_OS_O_BINARY)) != -1){
								pStr[SplitTmpName-file->FileName]= 0;
								c_io_close(fileTempCreate);
								ace_os_rename(streams->file->FileName,pStr);
							}
							if(true){
								// key файл создаём со старым темп-именем //
								streams->Flags |= SF_POST_CREATE_AS_TMP;
							}else{
								// key файл создаём с реальным именем //
								*SplitTmpName= 0;
							}
							streams->file->FileName[SplitTmpName-file->FileName]= 0;
						}
						if((fileTempCreate= c_io_open(streams->file->FileName, ACE_OS_O_EXCL|ACE_OS_O_RDWR | ACE_OS_O_BINARY)) == -1){
							if((fileTempCreate= c_io_open(streams->file->FileName, ACE_OS_O_EXCL|ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT)) == -1){
								LOG_E (("abort in Index :: StartBackupEx 651 (%s)", streams->file->FileName));
								throw Error ();
							}
						}
						streams->file->setFHandle(fileTempCreate);
					}
				}
				file->setFHandle(fileTempCreate);
				if(	((PagedFileHeader*)file->SystemPageBuf)->Signature != BASE_DATA_VERSION){
					file->PageSize= ((PagedFileHeader*)file->SystemPageBuf)->PageSize= ((PagedFileHeader*)streams->file->SystemPageBuf)->PageSize;
					if(!file->::PagedFile::PutPage(pCreate->preRoot, streams->SysBuf))
						abort();
					*streams->file->m_readed.pFilePoss= *file->m_readed.pFilePoss;
				}else{
					if(!file->::PagedFile::PutPage(pCreate->preRoot, streams->SysBuf))
						abort();
				}
				file->::PagedFile::SetFileHandle(-2);
				streams->AddPageFromCache(	pCreate->preRoot, streams->m_PagesCacheKeys, file, streams->SysBuf
											, &streams->m_pCacheKeysStack, &streams->m_pCacheKeysStackCount);
				pCreate->Root= pCreate->preRoot; pCreate->preRoot= 0;
			}
		}while(oo-- && (pCreate= streams->pCreateOtherK[oo]));
		{
			char protected_path_name[1024];
			if(streams->Flags & SF_POST_CREATE_AS_TMP){
				streams->file->FileName[SplitTmpName-file->FileName]= 0;
			}
			streams->file->get_protected_path_name(protected_path_name);
			if(/*getKey && */(streams->file->protected_path_handle= c_io_open(protected_path_name, ACE_OS_O_EXCL|ACE_OS_O_RDWR|ACE_OS_O_BINARY)) != -1){
				c_io_close(streams->file->protected_path_handle);
				ace_os_rename(protected_path_name, file->FileName);
			}else
				ace_os_unlink(protected_path_name);
		{
			static const char msg_err[]= "Cannot open file %s for writing.\n";
	if(*(ACE_UINT64*)Name == (ACE_UINT64)0x695f657571696e75){
// костыль для удаления индексов пустых, но созданных,
// привет примитивной логике в сервера Ф1, лабающей новые индексы не потребованию
			streams->file->protected_path_handle= -3;
	}else
			if(	(streams->file->protected_path_handle= c_io_open(file->FileName, ACE_OS_O_EXCL | ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT )) == -1)
			{
				LOG_E((msg_err, file->FileName));
#ifdef PLAIN_GKDB
				::abort();
#else
				throw Error ();
#endif
				return;		// and cannot be opened for 
			}
			if(streams->Flags & SF_POST_CREATE_AS_TMP){
				//if(true){
					// key файл создаём со старым темп-именем //
					currFlags |= SF_POST_CREATE_AS_TMP;
				/*}else{
					// key файл создаём с реальным именем //
					streams->Flags &= ~SF_POST_CREATE_AS_TMP;
					*SplitTmpName= 0;
				}*/
			}
		}
			///
			/*if(streams->file->IsWithProtectedPath()){
				streams->file->tmp_as_worked();
				if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION && (*(int*)file->m_pCryptoTag) > file->PageSize){
					// Персонифицированные дистрибутивы //
					streams->Fat[1] = FAT_CHAIN;
				}
			}else if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION)*/{
//#ifndef OLD_SHORT_STR
				if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION)
					strcpy(strrchr(streams->file->FileName, '.')+4,".ntmp(0)");
				else
					strcpy(strrchr(streams->file->FileName, '.')+2,".ntmp(0)");
//#endif
				// новые руты индексов занимают полные страницы в FAT-е //
				for(streams->file->LastPage= streams->LastCreatedBlockPage+1;
						streams->file->LastPage <= pCreate->Root; streams->file->LastPage++){
					streams->Fat[streams->file->LastPage]= FAT_CHAIN;
				}
				streams->file->LastPage--;
				streams->m_PagedBackupSystemPage= file->SystemPageBuf;
				file->SystemPageBuf= streams->file->SystemPageBuf;
			}/*else
				strcpy(strrchr(streams->file->FileName, '.')+2,".ntmp(0)");
			file->setFHandle(fileTempCreate);*/
		}
	}
	/*if(streams->Flags & SF_IN_FILE_DIRECT)
		streams->Flags= SF_IN_FILE_DIRECT | SF_IN_FIRST_LOG | (currFlags & ~(SF_DELETE | SF_IN_PRE_ATRANSCTN));
	else*/
		streams->Flags= SF_IN_FIRST_LOG | (currFlags & ~(SF_DELETE | SF_IN_PRE_ATRANSCTN));
	if(bFastFAT)
		streams->Flags |= SF_LOAD_FAT_ON_DEMAND;
	if(iInTrans){
		streams->Flags |= SF_IN_TRANSCTN;
		streams->SetTransactionCounter(iInTrans);
	}
	/*streams->SetTransactionCounter(currTCount);

	oo= AllI;
	while(oo--){
#ifndef WRITE_KEYS_PAGE_INBACKUP
		pCreateOtherK[oo]->pWritedPages= 0;
#else
		pCreateOtherK[oo]->pReadedPages)= 0;
		pCreateOtherK[oo]->pBuckupedPages= 0;
		pCreateOtherK[oo]->pBuckupedPages= 0;
#endif
		if(currTCount){
			streams->Flags &= ~SF_IN_TRANSCTN;
			pCreateOtherK[oo]->Init_Index ( file, pCreateOtherK[oo]->Name, streams );
			streams->Flags |= SF_IN_TRANSCTN;
		}else{
			pCreateOtherK[oo]->Init_Index ( file, pCreateOtherK[oo]->Name, streams );
			if(pCreateOtherK[oo]->preRoot)
			{
				//AsDirect++;
				pCreateOtherK[oo]->Root= pCreateOtherK[oo]->preRoot; pCreateOtherK[oo]->preRoot= 0; }
		}
	}*/
	streams->Flags |= SF_CREATE;
	streams->pOldCreate= pOldCreate;
	/*if(AsDirect == AllI + 1){
		void *bf= alloca( streams->file->PageSize > file->PageSize ? streams->file->PageSize : file->PageSize );
		streams->pFirst->InitBackupStatstcsFile();
		streams->PreBackupTransaction();
		streams->AddFat(1, 0);
		streams->Flags |= SF_IN_FILE_DIRECT;
	}*/
}
			}
			}else{
				if(streams->Flags & SF_IN_TRANSCTN && !(streams->Flags & SF_IN_AUTOTRANSCTN)){
					InitBackupStatstcsFile();
				}
				if(streams->m_hBackup == -1)
					streams->modifyBKP();
				streams->Flags |= SF_CREATE;
			}
		}/*else{
			AllI= streams->iCreateOther;oo= AllI;
			streams->pCreateOtherK= 0;
			while(oo--){
				Index *ti= pCreateOtherK[oo];
				if(!ti->KeyCount && AutoCreate == 2){
					ti->streams->iDeleteFile= -1;
					delete ti->streams;
					delete ti->file;
					ti->file= file;
					ti->streams= streams;
					//ti->Stack= streams->Stack;
					{
						int repeat0= GKDB::BT_MAXDEPTH;
						ti->Stack= (BTStack*)calloc(repeat0, sizeof(BTStack));
						while(repeat0--){
							if(!ti->Stack[repeat0].curKey)
								ti->Stack[repeat0].curKey= (char*)calloc(1, ti->KeyLength+256);
							if(!ti->Stack[repeat0].prevKey)
								ti->Stack[repeat0].prevKey= (char*)calloc(1, ti->KeyLength+256);
						}
					}
				}else{
#ifndef USE_GLOBAL_DIC
					if((streams->Flags & SF_GLOBAL_CREATE) && ti->KeyCount)
						streams->Flags &= ~SF_GLOBAL_CREATE;
#endif
					ti->streams->iDeleteFile++;
					delete ti->streams;
					delete ti->file;
					realMakeTempFiles();
					ti->file= file;
					ti->streams= streams;
					ti->Index::Create(	ti->KeyLength - ti->nstreams*(int(STRSZSZ & 0x7fffffff)+ti->ImmDataSize),
								ti->roundv, ti->nstreams, ti->ImmDataSize );
					ti->BTree :: shutdown(&info.btinit);
					info.immdatasize = ti->ImmDataSize;
					info.rndv = ti->roundv;
					info.nstreams = ti->nstreams;
					if( file->IsOk() ){
						file->PutAttr(ti->Name, &info, int(sizeof(info)));
					}
					//ti->Stack= streams->Stack;
					{
						int repeat0= GKDB::BT_MAXDEPTH;
						ti->Stack= (BTStack*)calloc(repeat0, sizeof(BTStack));
						while(repeat0--){
							if(!ti->Stack[repeat0].curKey)
								ti->Stack[repeat0].curKey= (char*)calloc(1, ti->KeyLength+256);
							if(!ti->Stack[repeat0].prevKey)
								ti->Stack[repeat0].prevKey= (char*)calloc(1, ti->KeyLength+256);
						}
					}
				}
			}
			if(AutoCreate != 2){
				pFndNew= strrchr(file->FileName, '(');
				CopyHandBuckup++;
			}
		}*/
		//if(CopyHandBuckup)
	}
	if((streams->Flags & SF_IN_NOT_COPY)){
		if((streams->Flags & SF_IN_TRANSCTN)){
			streams->Flags |= SF_IN_NOT_COPY;
			if((streams->Flags & SF_IN_AUTOTRANSCTN)){
				streams->Flags |= SF_IN_NOT_COPY;
				if((streams->Flags & SF_IN_PRE_ATRANSCTN)){
					streams->Flags |= SF_IN_NOT_COPY;
				}else
					streams->Flags |= SF_IN_NOT_COPY;
			}else
				streams->Flags |= SF_IN_NOT_COPY;
		}
	}
	if(!(streams->Flags & SF_IN_TRANSCTN) && (streams->Flags & SF_IN_PRE_ATRANSCTN))
		StartAutoLocalTransaction();
#ifdef USE_GLOBAL_DIC
	else if(!(streams->Flags & SF_IN_TRANSCTN)){
		//GUARD (m_mutexNDTGlobaTransactionLog);
		if(pNDTGlobaTransactionLog){
			StartAutoLocalTransaction();
		}
	}
#endif
	if((streams->Flags & (SF_IN_FIRST_COPY | SF_IN_FIRST_LOG))){
		streams->Flags &= ~(SF_IN_FIRST_COPY | SF_IN_FIRST_LOG);
		if((streams->Flags & SF_IN_PRE_ATRANSCTN) || (streams->Flags & SF_IN_AUTOTRANSCTN))
			;
		else{
			streams->PreBackupTransaction();
		}
		IndexInLog( file, streams );
	}
}

Stream* Index :: ResultAsStream (StoredSortedCollection *ret)
{
	memcpy(ret->Buf, (ret->RecOffs ( ret->Stack[ret->Sp-1].buf, ret->Stack[ret->Sp-1].Pos )), ret->KeyLength);
	ret->Pos= 0;
	ret->realSize= ret->KeyLength;
	ret->ImmSize=  ret->KeyLength;
	ret->Handle= 0;
	return ret;
}

Stream * Index :: FindNodeOnStreamN(void *pNode, short BytesPerNode,  BTKEY key, int sn)
{
	if((file->m_mode & (~0x3000)))
		return 0;

	StoredSortedCollection* ret= (StoredSortedCollection*)OpenN ( key, sn+ (BytesPerNode == 4 ? 1111 : ( BytesPerNode == 7 ? 3333 : 2222)) );
	if(ret){
		ret->KeyLength= (BytesPerNode == 7 ? 8 : BytesPerNode);
		ret->KeyCount= ret->realSize/ret->KeyLength;

		BTStack tmp[GKDB::BT_MAXDEPTH];
		char *keys_buff= (char*)alloca(streams->file->PageSize);
		memset(tmp, 0, GKDB::BT_MAXDEPTH * sizeof(*tmp));
		ret->Stack= tmp;

		ret->pNextMemForStacksBuf= (char*)alloca(GKDB::BT_MAXDEPTH * streams->file->PageSize);
		ret->pNextMemForStacksBuf -= streams->file->PageSize;
		int no;
		int Page;
		if(!(*(int*)pNode)){
			if (ret->Length() > (int)((size_t)(streams->file->PageSize&0x7fff) - sizeof ( BlockDesc )) ) {
				void *first_page= alloca((size_t)(streams->file->PageSize&0x7fff));
				streams->GetPage(ret->blocks[0], first_page);
				*(int*)pNode = *(int*)first_page;
			}else
				*(int*)pNode = *(int*)ret->Buf;
		}
		if(ret->LocateKey(pNode, keys_buff, no, Page) == GKDB::BT_OK){
			ret= (StoredSortedCollection*)ResultAsStream(ret);
		}else{
			Close(ret);
			return 0;
		}
	}
	return ret;
}
Stream * Index :: DelNodeOnStreamN(void *pNode, short BytesPerNode,  BTKEY key, int sn)
{
	StoredSortedCollection* ret= (StoredSortedCollection*)OpenN ( key, sn+ (BytesPerNode == 4 ? 1111 : 2222) );
	if(ret){
		ret->KeyLength= BytesPerNode;
		ret->KeyCount= ret->realSize/ret->KeyLength;

		BTStack tmp[GKDB::BT_MAXDEPTH];
		char *keys_buff= (char*)alloca(streams->file->PageSize);
		memset(tmp, 0, GKDB::BT_MAXDEPTH * sizeof(*tmp));
		ret->Stack= tmp;
		int no;
		int Page;
		if(ret->LocateKey(pNode, keys_buff, no, Page) == GKDB::BT_OK){
			short count= (short)(ret->realSize % streams->file->PageSize);
			if(Page*streams->file->PageSize < ret->realSize){
				memcpy(keys_buff + no * ret->KeyLength, keys_buff + (no + 1) * ret->KeyLength, streams->file->PageSize - ((1 + no) * ret->KeyLength));
				memcpy(keys_buff + streams->file->PageSize - ret->KeyLength, ret->Buf, ret->KeyLength);
				streams->PutPage(ret->blocks[Page-1], keys_buff);
			}else if(!count){
				count= streams->file->PageSize - ((1 + no) * ret->KeyLength);
				if(count){
					memcpy(keys_buff + no * ret->KeyLength, keys_buff + (no + 1) * ret->KeyLength, count);
					streams->PutPage(ret->blocks[Page-1], keys_buff);
					count= 0;
				}
			}else if(count - ret->KeyLength){
				memcpy(ret->Buf + no * ret->KeyLength, ret->Buf + (no + 1) * ret->KeyLength, (count/ret->KeyLength - 1 - no) * ret->KeyLength);
				ret->Stream::Flags |= SF_BUFDIRTY;
			}
			ret->Stream::Flags |= SF_MODIFIED;
			if(ret->realSize > ret->Pos){
			  do{
				ret->Stream::Flags |= SF_BUFDIRTY;
				if(ret->realSize > ret->Pos + count){
					memcpy(ret->Buf, ret->Buf + ret->KeyLength, streams->file->PageSize - ret->KeyLength);
					ret->blocks[Page+1]= (ret->Stream::file->Fat[ret->blocks[Page++]] & ~FAT_CHAIN);
					if(!count && (ret->realSize - ret->Pos) == streams->file->PageSize){
						memset(ret->Buf + streams->file->PageSize - ret->KeyLength, 0, ret->KeyLength);
						ret->Seek(ret->Pos + streams->file->PageSize);
						break;
					}else{
						ret->Stream::file->GetPage(ret->blocks[Page], keys_buff);
						memcpy(ret->Buf + streams->file->PageSize - ret->KeyLength, keys_buff, ret->KeyLength);
						ret->Seek(ret->Pos + streams->file->PageSize);
						Page= ret->Pos / streams->file->PageSize;
					}
				}else{
					if(count - ret->KeyLength){
						memcpy(ret->Buf, ret->Buf + ret->KeyLength, count - ret->KeyLength);
					}else{
						ret->Stream::Flags &= ~SF_BUFDIRTY;
					}
					break;
				}
			  }while(ret->realSize > ret->Pos);
			}
			if(!count){
				// mark page as FREE
				streams->AddFatNext(ret->blocks[Page-1], -(streams->Fat[ret->blocks[Page-1]]));
				streams->file->DelPage ( ret->blocks[Page] );
				ret->Stream::Flags &= ~SF_BUFDIRTY;
			}
			Page= ret->realSize - ret->KeyLength;
			if( Page < ret->BufSize ){
				Page = (Page/ret->roundV)*ret->roundV;
				if( streams->IsNotBlock( Page ) ){
					ret->realSize= Page;
				}else{
					ret->Pos -= ret->KeyLength;
					ret->Trunc();
				}
			}else
				ret->realSize= Page;
		}
	}
	return ret;
}

Stream * Index :: AddNodeOnStreamN(void *pNode, short BytesPerNode,  BTKEY key, int sn, int iAutoCreate)
{
	int no= 0;

	StoredSortedCollection* ret;

	if(BytesPerNode > 0){
		ret= (StoredSortedCollection*)OpenN (	key
												, sn + (BytesPerNode == 4 ? 1111 : 2222)
												, iAutoCreate
												, &no);
	}else{
		// for Class, only
		ret= (StoredSortedCollection*)OpenN (	key
												, sn + 3333
												, iAutoCreate
												, &no);
		BytesPerNode *= -1;
	}
	if(ret){
		ret->KeyLength= BytesPerNode;
		ret->KeyCount= ret->realSize/ret->KeyLength;

		BTStack tmp[GKDB::BT_MAXDEPTH];
		char *keys_buff= (char*)alloca(streams->file->PageSize);
		memset(tmp, 0, GKDB::BT_MAXDEPTH * sizeof(*tmp));
		ret->Stack= tmp;
		int Page;
		if(!ret->KeyCount || ret->ChangeNode(pNode, keys_buff, no, Page) == GKDB::BT_NONE){
			int count= 0;
			if(!ret->KeyCount)
				no= 0;
			else{
				if(no == streams->file->PageSize / ret->KeyLength){
					ret->Stack[ret->Sp-1].Pos= no= 0;
					ret->Stack[ret->Sp-1].Page++;
					count= ret->Read(keys_buff, streams->file->PageSize) / ret->KeyLength;
				}else
					count= ret->GetCount(keys_buff);
			}
			if(count == streams->file->PageSize / ret->KeyLength){
				char *pTmpNode= (char *)alloca(BytesPerNode);
				Page= ret->Stack[ret->Sp-1].Page;
				memcpy(pTmpNode, keys_buff + count * BytesPerNode - BytesPerNode, BytesPerNode);
				memmove(keys_buff + no * BytesPerNode + BytesPerNode
							, keys_buff + no * BytesPerNode, (count- no - 1) * BytesPerNode );
				memcpy(keys_buff + no * BytesPerNode, pNode, BytesPerNode);
				streams->PutPage(ret->blocks[Page++ -1], keys_buff);
				count= count * BytesPerNode - BytesPerNode;
				do{
					ret->Stream::Flags |= SF_MODIFIED | SF_BUFDIRTY;
					if(ret->realSize >= ret->Pos + streams->file->PageSize){
						memcpy(keys_buff, ret->Buf + count, BytesPerNode);
						memmove(ret->Buf + BytesPerNode, ret->Buf, count );
						memcpy(ret->Buf, pTmpNode, BytesPerNode);
						ret->Seek(ret->Pos + streams->file->PageSize);
						memcpy(pTmpNode, keys_buff, BytesPerNode);
					}else{
						memmove(ret->Buf + BytesPerNode, ret->Buf, ret->realSize - ret->Pos );
						memcpy(ret->Buf, pTmpNode, BytesPerNode);
						ret->Pos +=  BytesPerNode;
						ret->realSize +=  BytesPerNode;
						break;
					}
				}while(1);
			}else{
				memmove(keys_buff + no * BytesPerNode + BytesPerNode
							, keys_buff + no * BytesPerNode, (count - no) * BytesPerNode );
				memcpy(keys_buff + no * BytesPerNode, pNode, BytesPerNode);
				if(ret->Sp > 0)
					ret->Seek((ret->Stack[ret->Sp-1].Page-1)*streams->file->PageSize);
				else
					ret->Seek(0);
				ret->Write(keys_buff, count * BytesPerNode + BytesPerNode);
			}
		}
	}
	return ret;
}

/*int	Index :: AddData ( BTKEY k, int sn, const void  * buf, int Count )
{
	if(!(Index::OpenN( k, sn + 555555, Count,  (int *)buf)))
		return 0;
	return Count;
}

int	Index :: AddData_MRGLIB( BTKEY k, int sn, char **buf, int Count )
{
	if(!(Index::OpenN( k, sn + 565555, Count,  (int *)buf)))
		return 0;
	return Count;
}

int	Index :: AddStream_MRGLIB( BTKEY k, char **buf, int Count )
{
	if(!(Index::OpenN( k, 575555, Count,  (int *)buf)))
		return 0;
	return Count;
}*/

int Index :: BuckupRoot(int hFile)
{
	if(!(streams->Flags & SF_IN_NOT_COPY)){
		if((streams->Flags & SF_IN_PRE_ATRANSCTN) || (streams->Flags & SF_IN_AUTOTRANSCTN))
			return 0;
		{
#ifdef USE_GLOBAL_DIC
			//GUARD (m_mutexNDTGlobaTransactionLog);
			if(pNDTGlobaTransactionLog && !NDTGlobaTransactionNotCopy){
				return 0;
			}
#endif
		}
	}
	((PagedFileHeader*)file->SystemPageBuf)->AttrOffs = file->AttrOffs;
	((PagedFileHeader*)file->SystemPageBuf)->LastPage = file->LastPage;
	((PagedFileHeader*)file->SystemPageBuf)->FreePage = file->FreePage;
	((PagedFileHeader*)file->SystemPageBuf)->lastFreePage = file->lastFreePage;

	((PagedFileHeader*)streams->file->SystemPageBuf)->AttrOffs = streams->file->AttrOffs;
	((PagedFileHeader*)streams->file->SystemPageBuf)->LastPage = streams->file->LastPage;
	((PagedFileHeader*)streams->file->SystemPageBuf)->FreePage = streams->file->FreePage;
	((PagedFileHeader*)streams->file->SystemPageBuf)->lastFreePage = streams->file->lastFreePage;

	((int*)(((PagedFileHeader*)file->SystemPageBuf)->reserved))[0]
		= streams->file->LastPage;
	((int*)(((PagedFileHeader*)file->SystemPageBuf)->reserved))[1]
		= streams->file->FreePage;
	((int*)(((PagedFileHeader*)file->SystemPageBuf)->reserved))[2]
		= streams->file->lastFreePage;
	if( memcmp(file->SystemPageBuf+file->PageSize,file->SystemPageBuf, file->PageSize) && c_io_write(hFile, file->SystemPageBuf, file->PageSize) != file->PageSize)
		return -1;
	return 0;
}

void Index :: update_SystemPage()
{
	if(!m_pCountOut){
		size_t	len = strlen( Name ), tmpLen;
		short Offs;
		for(Offs=file->AttrOffs; !m_pCountOut && Offs<file->PageSize && file->SystemPageBuf[Offs]!='\0'; Offs+=file->SystemPageBuf[Offs]){
			tmpLen= strlen(file->SystemPageBuf+Offs+1);
			if (tmpLen == len && !memcmp(file->SystemPageBuf+Offs+1, Name, len))	// attrs found
			{
				m_pCountOut= &(((IndexInfo*)(file->SystemPageBuf+Offs+2+len))->btinit.KeyCount);break;
			}
		}
		if(!m_pCountOut)
			abort();
	}
	m_pCountOut[-2]						= Root;
	*m_pCountOut						= KeyCount;
	((short*)m_pCountOut)[2]			= Height;
	*(int*)(((short*)m_pCountOut)+3)	= LastId;
}

void Index :: UpdateUpKey(int up_offs, char *old_key, char* new_key)
{
	if(up_offs == -1){
		up_offs= int((((char*)recordData(old_key,0)) - old_key)&0x7fffffff);

		if(m_bAsNew){
			m_bAsNew= false;
			memmove ( old_key+up_offs, new_key+up_offs, KeyLength-up_offs );
			if((up_offs= Stack [Sp].Page) > file->curr_last) UpKeyAsChanged(up_offs, -1); else UpKeyAsChanged(up_offs, Stack [Sp].Pos, new_key);
			memcpy ( Stack [Sp].curKey, new_key, KeyLength );
		}else if(memcmp ( (old_key+=up_offs), (new_key+=up_offs), KeyLength-up_offs)){
			m_bAsNew= false;
			memmove ( old_key, new_key, KeyLength-up_offs );
			memcpy ( Stack [Sp].curKey+up_offs, new_key, KeyLength-up_offs );
			if((up_offs= Stack [Sp].Page) > file->curr_last) UpKeyAsChanged(up_offs, -1); else UpKeyAsChanged(up_offs, Stack [Sp].Pos, new_key);
		}
	}else
		memcpy ( Stack [Sp].curKey, old_key, KeyLength );
	QuickPageBuf= 0;
	skipCritical();
}

void Index :: FlushOperation()
{
	if((++streams->CountAllFlush)){
		update_SystemPage();
		if(!(streams->Flags & SF_IN_TRANSCTN)){
			streams->BackupTransaction();
		}
	}
}

void Index :: Close ( Stream * str, int iRemoveKey )
{
	if( str) {
		AutoKillStr kill_mtx(str);
		int oPage=
#ifdef _DEBUG
					-1;
		if( ClosedID == str->streamID ){
			if(str->oPage)
				oPage= 0;
		}else{
			ClosedID= str->streamID;
			if(str->oPage)
				oPage= 0;
		}
#else
		0; if(!str->oPage)
					oPage= -1;
#endif
		if(streams->Flags & SF_IN_OPERATION) {
#ifdef	_DEBUG
			LOG_E (("(%x,%x:%x)abort in Index(%s,%s)::Close(InOperation!)", this,
						((int*)&ClosedID)[1], ((int*)&ClosedID)[0], Name,strrchr(streams->file->FileName, '_')));
#endif
			abort();
		}
#ifdef _DEBUG
		if(!streams->ostreams->seek(ClosedID)) {
			Point firstI= streams->ostreams->first();
			if(!firstI){
				LOG_E (("(%x,%x:%x)abort in Index(%s,%s)::Close(Bad Str!)", this,
							((int*)&ClosedID)[1], ((int*)&ClosedID)[0], Name,strrchr(streams->file->FileName, '_')));
				abort();
				return;
			}
			ACE_UINT64 streamID= streams->ostreams->key(firstI);
			LOG_E (("(%x,%x:%x)abort in Index(%s,%s)::Close(Bad Str(%x:%x)!)", this,
						((int*)&ClosedID)[1], ((int*)&ClosedID)[0], Name,strrchr(streams->file->FileName, '_'),
						((int*)&streamID)[1], ((int*)&streamID)[0]));
			abort();
		}
#endif
		streams->BeginOperation(this, streams->close_index);
		int	strModified = str -> Modified ();
		char  *	keyBuf      = str -> IndexBuf;
		int oPos= -1;
		bool bAsNew= str->m_bAsNew;
		if(!oPage){
			oPage= str->oPage;
			oPos= str->oPos;
		}
		delete str;
		if(iRemoveKey){
			strModified++;
		}else if ( strModified ){
			{
				if(oPos > -1){
					int up_offs;
					QuickPageBuf= 0;
					if(bAsNew || (!initCritical()
									&& --Sp > -2
									&& (up_offs= int((((char*)recordData(keyBuf,0)) - keyBuf)&0x7fffffff))
									&&  memcmp(QuickPageBuf= (((char*)RecOffs (PrepareStackBuff( oPage, 0, 0 ), oPos ))+up_offs), keyBuf+up_offs, KeyLength-up_offs))){
						if(oPage > file->curr_last){
							if(bAsNew){
								initCritical();
								if(!memmove ( RecOffs ( QuickPageBuf=PrepareStackBuff( oPage, 0, 0 ), oPos ), keyBuf, KeyLength))
								{
									oPos= -2;
								}else
									UpKeyAsChanged(oPage, -1);
							}else{
								if(!memmove ( QuickPageBuf, keyBuf+up_offs, KeyLength-up_offs )){
									oPos= -2;
								}else if(Stack [Sp].Page == oPage && Stack [Sp].Pos == oPos
										&& !memcpy ( Stack [Sp].curKey+up_offs, keyBuf+up_offs, KeyLength-up_offs ))
								{
									oPos= -2;
								}else
									UpKeyAsChanged(oPage, -1);
							}
 						}else
							oPos= UpKeyAsChanged(oPage, oPos, keyBuf);

						m_bAsNew= false;
					}
					if(QuickPageBuf){
						QuickPageBuf= 0;
						skipCritical();
					}
				}else{
					if(UpdateKey ( keyBuf ) != GKDB::BT_OK)
					{
						oPos= -2;
					}
				}
			}
			if(oPos == -2){
#ifdef	_DEBUG
				LOG_E (("(%x,%x:%x)abort in Index(%s,%s)::Close(Method on BTree)!)", this,
							((int*)&ClosedID)[1], ((int*)&ClosedID)[0], Name,strrchr(streams->file->FileName, '_')));
#endif
				abort();
			}
			//streams->new_fatPages= 0;
		}
		if(CollectionStream != 55 && (file->m_mode & (~0x3000)))
			free ( keyBuf );
		keyBuf= 0;
#ifdef _DEBUG
		streams->ostreams->del(ClosedID);
		if(!streams->ostreams->first())
#endif
		{
			if(strModified){
				if(streams->m_LastNewId > 0){
					reOptimizeShortPage(streams->LastCreatedBlockPage, &streams->m_LastNewId);
				}
				FlushOperation();
	#ifdef WRITE_KEYS_PAGE_INBACKUP
			}else if(!(streams->Flags & SF_IN_TRANSCTN) && streams->m_hBackupKeys){
				char *pNameF= streams->GetBackupName(), *Fnd= strrchr(pNameF, '.')+1;
				if(c_io_close(streams->m_hBackupKeys)) {
					LOG_E (("(%x)abort in Index(%s)::Close(c_io_close(streams->m_hBackupKeys)!)", this, Name));
					abort();
				}
				streams->m_hBackupKeys= 0;
				*Fnd= '~';unlink_rdonly(pNameF);
				*Fnd= 'b';
				pBuckupedPages->clear();
			}
	#else
			}else if(!(streams->Flags & SF_IN_TRANSCTN)){
				if(streams->rpages) streams->rpages->clear();
				else
					streams->rpages= streams->rpages;

#ifndef SAVE_ALL_FAT_ON_BUCKUP
				if(streams->fpages){
					if(streams->Flags & SF_RESTR_LONG_BKP)
						; // очистим в операции модификации //
					else
						streams->fpages->clear();
				}else
					streams->fpages= streams->rpages;
#endif
				if(streams->bpages){
					if(streams->Flags & SF_RESTR_LONG_BKP)
						; // очистим в операции модификации //
					else
						streams->bpages->clear();
				}else
					streams->bpages= streams->rpages;
				if(m_bAsNew/* && file->SystemPageBuf == streams->file->SystemPageBuf*/){
					// Оставляем неудалаяемым пустой одиночный индекс(ы) //
					if(streams->m_hBackup)
						abort();
					m_bAsNew= false;
					CachedPage *pFnd= streams->m_PagesCacheKeys->contents(streams->m_PagesCacheKeys->GetRootG_SimpleSplayNode());
					pFnd->m_changed= 0;
					*streams->file->m_postFilePoss= 0;
					if(	c_io_lseek(streams->file->GetFileHandle(), streams->file->PageSize*Root, ACE_OS_SEEK_SET) != streams->file->PageSize*Root
						||	c_io_write(streams->file->GetFileHandle(), &pFnd->m_changed, 2) != 2){
							abort();
					}
					streams->m_hBackup= -1;
					(*((PagedFileHeader*)streams->file->SystemPageBuf)).AttrOffs= file->AttrOffs;
					(*((PagedFileHeader*)streams->file->SystemPageBuf)).LastPage= Root;
					if(((PagedFileHeader*)file->SystemPageBuf)->Signature != BASE_DATA_VERSION){
						streams->SaveFat();
						if(	c_io_lseek(streams->file->GetFileHandle(), 0, ACE_OS_SEEK_SET) != 0
							||	c_io_write(streams->file->GetFileHandle(), file->SystemPageBuf, streams->file->PageSize) != streams->file->PageSize){
								abort();
						}
						streams->modifyBKP(false);
					}else{
						if(	c_io_lseek(file->GetFileHandle(), file->PageSize*Root-2, ACE_OS_SEEK_SET) != file->PageSize*Root-2
							||	c_io_write(file->GetFileHandle(), &pFnd->m_changed, 2) != 2){
								abort();
						}
						(*((PagedFileHeader*)file->SystemPageBuf)).AttrOffs= file->AttrOffs;
						(*((PagedFileHeader*)file->SystemPageBuf)).LastPage= Root;
						if(	c_io_lseek(file->GetFileHandle(), 0, ACE_OS_SEEK_SET) != 0
							||	c_io_write(file->GetFileHandle(), file->SystemPageBuf, file->PageSize) != file->PageSize){
								abort();
						}
						if(	c_io_lseek(streams->file->GetFileHandle(), 0, ACE_OS_SEEK_SET) != 0
							||	c_io_write(streams->file->GetFileHandle(), streams->file->SystemPageBuf, file->PageSize) != file->PageSize){
								abort();
						}
						char *f_f= (char*)alloca(file->PageSize);
						memset(f_f, 0, file->PageSize);
						((long*)f_f)[1]= FAT_CHAIN;
						if(	c_io_write(streams->file->GetFileHandle(), f_f, file->PageSize) != file->PageSize
							|| c_io_lseek(streams->file->GetFileHandle(), file->PageSize, ACE_OS_SEEK_SET) != file->PageSize){
								abort();
						}
					}
					file->Flags &= ~PF_MODIFIED;
					streams->file->Flags &= ~PF_MODIFIED;
					streams->Flags &= ~PF_MODIFIED;
				}
			}
	#endif
		}
#ifdef _DEBUG
		else if(!(streams->Flags & SF_IN_TRANSCTN)){
			ACE_UINT64 streamID= 0;
			Point firstI= streams->ostreams->first();
			if(firstI)
				streamID= streams->ostreams->key(firstI);
			LOG_E (("(%x,%x:%x)abort in Index(%s,%s)::Close(Not Close Operation(%x:%x)!)", this,
						((int*)&ClosedID)[1], ((int*)&ClosedID)[0],
						Name,strrchr(streams->file->FileName, '_'),
						((int*)&streamID)[1], ((int*)&streamID)[0]));
			abort();
		}
#endif
		streams->EndOperation();
	}
}

//##ModelId=3BFE7DEA0111
int	Index :: AddData ( BTKEY key, const void * buf, int size, int sn )
{
	Stream * str = OpenN ( key, sn, 1 );

	str -> SeekEx  ( str -> Length () );		// seek to end of stream
	size = str -> Write ( buf, size );	// append data to end

	Close ( str );

	return size;
}

//##ModelId=3BFE7DEA012C
int	Index :: SetData ( BTKEY key, const void * buf, int size, int sn )
{
	Stream * str = OpenN ( key, sn, 1 );

	str -> SeekEx  ( 0 );				// seek to begin of stream
	size = str -> Write ( buf, size );	// write to beginning

	Close ( str );

	return size;
}

//##ModelId=3BFE7DEA0141
int	Index :: FindDataEx ( BTKEY key, void * buf, int buf_size, int ns )
{
	Stream * str = OpenN ( key, ns );

	if ( str != 0 ){
		buf_size = str -> ReadEx ( buf, buf_size );
		Close ( str );
		return buf_size;
	}
	else
		return 0;
}

extern int compWriteID(const void *v1, const void *v2);

char *Index :: cachedPage(long Page, CachedPage **ppRet)
{
	if(!streams->m_PagesCacheKeys){
		streams->m_PagesCacheKeys= new CachePagesMap(0);
	}
	CachedPage *pFnd;
	if((pFnd= (CachedPage *)streams->m_PagesCacheKeys->seek(Page))){
		pFnd= streams->m_PagesCacheKeys->contents(pFnd);
	}else{
		char *buf1= (char*)alloca(streams->pFirst->file->PageSize);
		if(file->SystemPageBuf == streams->file->SystemPageBuf){
			if(!streams->file->GetPage(Page, buf1)){
				return 0;
			}
		}else if(!streams->pFirst->file->GetPage(Page, buf1)){
			return 0;
		}
		streams->AddPageFromCache(Page	, streams->m_PagesCacheKeys
										, streams->pFirst->file
										, buf1
										, &streams->m_pCacheKeysStack
										, &streams->m_pCacheKeysStackCount);
		pFnd= streams->m_PagesCacheKeys->contents(
				streams->m_PagesCacheKeys->GetRootG_SimpleSplayNode());
	}
	streams->UpActualLevel(pFnd,streams->m_PagesCacheKeys);

	if(ppRet)
		*ppRet= pFnd;

	return (char*)(pFnd->m_Data);
}

char *Index :: readPage(long Page)
{
#ifdef _DEBUG
	if(!m_CriticalCount){
		CachedPage *pFndZ;
		G_Point pFnd0;
		if(streams->m_PagesCacheKeys && (pFnd0= streams->m_PagesCacheKeys->first())){
			do{
				pFndZ= streams->m_PagesCacheKeys->contents(pFnd0);
				if(pFndZ->actualLevel >= (0x7fffffff - GKDB::BT_MAXDEPTH)){
					LOG_E (("(%x)Not unlocked page(%s)(%s)(%d)", this, Name, file->FileName,streams->m_PagesCacheKeys->key(pFnd0)));
					abort();
					break;
				}
				if(pFndZ->actualLevel >= 0x5ffffffd+100){
					LOG_E (("(%x)actual value this page is BAD(%s)(%s)(%d)", this, Name, file->FileName,streams->m_PagesCacheKeys->key(pFnd0)));
					abort();
					break;
				}
				streams->m_PagesCacheKeys->next(pFnd0);
			}while(pFnd0);
		}
	}
#endif
	CachedPage *pFnd;
	if(!cachedPage(Page, &pFnd))
		abort();

	if(pFnd->actualLevel < (0x7fffffff - GKDB::BT_MAXDEPTH)){
		m_CriticalPreActual[m_CriticalCount]= pFnd->actualLevel;
		pFnd->actualLevel= (0x7fffffff - GKDB::BT_MAXDEPTH);
		m_ppCritical[m_CriticalCount++]= pFnd;
	}
	return (char*)(pFnd->m_Data);
}

void Index::skipCritical()
{
	int ii;
	for ( ii= Sp; ii > -1; ii-- ){
		Stack [ii].buf= 0;
	}
	ii= m_CriticalCount;

	if(streams->m_uCountLockedPage){
		streams->m_uCountLockedPage= 0;
		while(ii--){
			m_ppCritical[ii]->actualLevel= m_CriticalPreActual[ii]/2;
		}
	}else
		while(ii--){
			m_ppCritical[ii]->actualLevel= m_CriticalPreActual[ii];
		}

	m_CriticalCount= 0;
}

#define USE_GARANT_PAGED_FILE_CACHE		// Оставил только для сохранения традиции
										// хотя дисковый кеш намного эфективней
void Index :: flush_files()
{
}

static void InitFileNameProfile(const char *name)
{
	//GUARD (m_mutexNDTGlobaTransactionLog);
	if(!m_setNameGlobalBuckupPath){
#ifndef WITH_LOG_FILE
		set_global_transaction_path(".\\");
#else
		char *fndZ= (char*)strrchr(name, '\\');
		*fndZ= 0;
		set_global_transaction_path(name);
		*fndZ= '\\';
#endif
	}
	{
		//GUARD (m_mutexBackupedFileNameMap);
		testLastGlobalTransactin(0, 0);
		set_start_global_transaction();
	}
}

/*NdtClone::PagedFile *CloneUpdatedPagedFile(LPPF_PARAM pFile, int database_version)
{
	InitFileNameProfile(pFile->FileName);
	return new NPagedFile(pFile, database_version);
}
*/
NdtClone::PagedFile *GetReadOnlyPagedFile(const char * name, int database_version)
{
	if(global_IsBlock())
		return 0;
	return new NPagedFile(name, ACE_OS_O_RDONLY, database_version);
}

int NdtClone::PagedFile::unlink_pre_tmp(const char * name)
{
	if(this->IsOk()){
		size_t len= gettmpnumber(name, this);
		char deleted_name[NDTC_MAX_PATH_SIZE];
		this->get_protected_path_name(deleted_name);
		int ret= ace_os_unlink(deleted_name);
		memcpy(this->FileName,name,len+1);
		return ret;
	}
	return -1;
}

NdtClone::PagedFile *GetUpdatedPagedFile(const char * name, int database_version)
{
	if(global_IsBlock())
		return 0;
#ifdef USE_GLOBAL_DIC
	InitFileNameProfile(name);
#endif
	PagedFile *tst= new NPagedFile(name, ACE_OS_O_RDWR, database_version);
	assert(tst);
	if(tst->IsOk()){
		// НЭ надо тормозить лишней перестраховкой, т.к. нет коробочной версии с такой версией темп-файла
		// tst->unlink_pre_tmp(name);
		return tst;
	}
	gettmpnumber(name, tst);
	//size_t len= strlen(tst->FileName);
	//strcpy(tst->FileName+len, ".~kp");
	//*(tst->FileName+len)= 0;
	return tst;
}

} // namespace NdtClone

extern "C" {
extern int DefValCryptoTag;
}

PagedFile *makePagedFile(const char * name, int mode)
{
	PagedFile *pret= 0;
	if((mode & ACE_OS_O_RDWR) || (mode & ACE_OS_O_WRONLY))
		pret= NdtClone::GetUpdatedPagedFile(name, BASE_DATA_VERSION);
	else
		pret= new NdtClone::NPagedFile(name, mode, BASE_DATA_VERSION);

	if(pret && !pret->m_pCryptoTag)
		pret->m_pCryptoTag= (char*)&DefValCryptoTag;

	return pret;
}

PagedFile *makePagedFile_afterGSplit(LPPF_PARAM pFile)
{
	return new NdtClone::NPagedFile(pFile);
}

#include "btiter.h"

	struct KeyUpdtIndexPage{
		int page;
		size_t off;
		int operator < ( KeyUpdtIndexPage &b ){
			if(off < b.off){
				return 1;
			}
			if(page < b.page){
				return 1;
			}
			return 0;
		}
		int operator > ( KeyUpdtIndexPage &b ){
			if(off > b.off){
				return 1;
			}
			if(page > b.page){
				return 1;
			}
			return 0;
		}
	};
	struct KeyUpdtIndexPage0{
		unsigned short page;
		int off;
		int operator < ( KeyUpdtIndexPage0 &b ){
			if(off < b.off){
				return 1;
			}
			if(page < b.page){
				return 1;
			}
			return 0;
		}
		int operator > ( KeyUpdtIndexPage0 &b ){
			if(off > b.off){
				return 1;
			}
			if(page > b.page){
				return 1;
			}
			return 0;
		}
	};

extern char pFatSizeName[];

void NdtClone:: Index :: reOptimizeShortPage(int Pg, unsigned short *pOutId)
{
	char nms[100];
	int z= 0, x= 0;
	IndexInfo info;

	int	dFlags		= Flags;
	short	dOrder		= Order;
	short	dKeyLength	= KeyLength;
	int	dKeyCount	= KeyCount;
	short	dHeight		= Height;
	int	dLastId		= LastId;
	int	droundv		= roundv;
	int	dnstreams	= nstreams;
	int	dImmDataSize=ImmDataSize;
	int Offs, dRoot= Root;

	QuickValSplayMapOnStackPerSize(KeyUpdtIndexPage,unsigned short,ActualPageMap,1+streams->file->PageSize/(5+sizeof(BlockDesc)),0);
	{
		unsigned short new_val = 1;
		IndexRecordData *pRec;
		for ( Offs = file->AttrOffs; Offs < file->PageSize && file->SystemPageBuf [Offs] != '\0'; Offs += file->SystemPageBuf [Offs]){
			strcpy(nms,file->SystemPageBuf + Offs + 1);
			if(file->SystemPageBuf == streams->file->SystemPageBuf){
				if(!strcmp(pFatSizeName, nms))
					continue;
				if(!strcmp(SF_FAT_OD, nms))
					continue;
			}
			file->GetAttr ( nms, &info, sizeof (info));
			BTree::init(file, &info.btinit);
			ImmDataSize = info.immdatasize;
			roundv = info.rndv;
			nstreams = info.nstreams;
			NdtClone::BTIterator ii(this);
			while(!ii.End()){
				for(int n_s= 0; n_s < nstreams; n_s++){
					pRec= (IndexRecordData*)recordData(ii.Key(),n_s);
					if(pRec->header.realDataLength > ImmDataSize){
						if( ((pRec->header.allocatedDataLength &  FAT_CHAIN) ? BIG_STREAM_HANDLE_TO_PAGE ( pRec->data.handle ) : OLD_STREAM_HANDLE_TO_PAGE ( pRec->data.handle ))
								== Pg){
							KeyUpdtIndexPage asnew;
							asnew.page= ii.Stack[ii.Sp].Page;
							asnew.off= (char*)pRec - (char*)ii.buf;
							ActualPageMap.get(asnew) = NEW_STREAM_HANDLE_TO_ID(pRec->data.handle,pRec->header.allocatedDataLength);
						}
					}
				}
				++ii;
			}
		}
		QuickValSplayMapOnStackPerSize(unsigned short,unsigned short,ActualIdMap,1+streams->file->PageSize/(5+sizeof(BlockDesc)),0);

		short rpt= -(*(short*)streams->SysBuf);
		unsigned short *pNxtVal= ((unsigned short*)streams->SysBuf) +1;
		while(rpt--){
			ActualIdMap.get(*pNxtVal)= new_val;
			*pNxtVal= new_val++;
			pNxtVal += 2;
		}
		int currP= 0, preP= 0;
		char *buffW= (char*)alloca(file->PageSize);
		for(G_Point t0= ActualPageMap.first(); t0 ; ActualPageMap.next(t0)){
			KeyUpdtIndexPage *pKey= &(ActualPageMap.key(t0));
			unsigned short val;
			/*{
				val= ActualPageMap.contents(t0);
				printf("\n(%d)(%d)(%d->%d)", pKey->page, pKey->off, val, ActualIdMap[val]);
			}*/
			if(preP && preP != pKey->page  && !PutPage(preP, buffW))
				abort();
			if(preP != pKey->page  && (preP= pKey->page) && !GetPage(preP, buffW))
				abort();

			pRec= (IndexRecordData*)(buffW+pKey->off);
			val= ActualIdMap[ActualPageMap.contents(t0)];
			pRec->data.handle= (streams->LastCreatedBlockPage << 5) | int(((val >> 11) & 0xffff));
			pRec->header.allocatedDataLength &= 0x800fffff;
			pRec->header.allocatedDataLength |= int((val & 0x7ff)) << 20;	// put new low bits in Stream::allocatedSize
		}
		if(!PutPage(preP, buffW))
			abort();
	}
	Flags		= dFlags;
	Order		= dOrder;
	KeyLength	= dKeyLength;
	KeyCount	= dKeyCount;
	Height		= dHeight;
	LastId		= dLastId;
	roundv		= droundv;
	nstreams	= dnstreams;
	ImmDataSize	= dImmDataSize;
	Root		= dRoot;
}

void NdtClone:: Index :: CloneAsCompact(Index *pOut)
{
	if(Root == -1)
		return;

	NdtClone::BTIterator ii(this);
	char bff[1024];
	while(!ii.End()){
		memset(bff,0,1024);
		for(int n_s= 0; n_s < nstreams; n_s++){
			Stream *pstr= OpenN	((IndexRecordData*)recordData(ii.Key(),n_s));
			if(pstr){
				char *b= new char[pstr->Length()];
				pstr->Read(b,pstr->Length());
				Stream *Str=new Stream(pOut->streams,recordData(bff,n_s),ImmDataSize,roundv);
				Str->Write(b,pstr->Length());
				delete Str;
				delete []b;
				Close(pstr);
			}else
				abort();
		}
		memmove ( bff, ii.Key(), KeyLength - nstreams*(STRSZSZ+ImmDataSize));

        int    Pagez;                           // page where the key is located
        int     noz;                             // no. of record with the key

		if ( pOut->LocateKey ( bff, bff, noz, Pagez, -1 ) != GKDB::BT_NONE )
			abort();

		pOut->streams->CountAllFlush++;
		++ii;
	}
#ifdef _DEBUG
	pOut->streams->ostreams->clear();
#endif
}

int	Index :: getRootNode(const char * name, void * buf, int size, StreamFile *sFF)
{
  	/*if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION)*/{
		if(((struct PagedFileHeader *)file->SystemPageBuf)->PageSize%PF_HD_SECTOR_SIZE== 4)
			return sFF->file->GetAttr(name, buf, size);
		if(!sFF)
			sFF= streams;
		if(sFF)
			if(sFF->file->GetAttr(name, buf, size))
				return 1;
	}
	return file->GetAttr(name, buf, size);
}

int	Index :: NewPage (void *bf)
{
	int tmp32;
	if(file->SystemPageBuf == streams->file->SystemPageBuf){
		int		Handle
				, i= FAT_CHAIN
				, m_maxPageCountInCache= ((NPagedFile*)(streams->file))->m_maxPageCountInCache;

		CachePagesMap *m_PagesCacheBlocks= streams->m_PagesCacheBlocks;
		char	 *m_pCacheBlocksStack= streams->m_pCacheBlocksStack
				,*cache_tmp_buf= streams->file->cache_tmp_buf
				, **ppCPages= streams->file->ppCPages;

		tmp32= streams->m_pCacheBlocksStackCount;

		streams->m_PagesCacheBlocks= streams->m_PagesCacheKeys;
		streams->m_pCacheBlocksStack= streams->m_pCacheKeysStack;
		streams->m_pCacheBlocksStackCount= streams->m_pCacheKeysStackCount;
		streams->file->cache_tmp_buf= streams->pFirst->file->cache_tmp_buf;
		streams->file->ppCPages= streams->pFirst->file->ppCPages;
		((NPagedFile*)(streams->file))->m_maxPageCountInCache= ((NPagedFile*)(streams->pFirst->file))->m_maxPageCountInCache;

		streams->NewHandle ( streams->file->PageSize, &i,  bf, &Handle);

		((NPagedFile*)(streams->file))->m_maxPageCountInCache= m_maxPageCountInCache;
		streams->m_PagesCacheBlocks= m_PagesCacheBlocks;
		streams->m_pCacheBlocksStack= m_pCacheBlocksStack;
		streams->m_pCacheKeysStackCount= streams->m_pCacheBlocksStackCount;
		streams->m_pCacheBlocksStackCount= tmp32;
		streams->file->cache_tmp_buf= cache_tmp_buf;
		streams->file->ppCPages= ppCPages;

		streams->Flags &= ~SF_NEW_HANDLE;
		return BIG_STREAM_HANDLE_TO_PAGE( Handle );
	}
	tmp32= file->NewPage();
	if(!PutPage ( tmp32, bf ))
		abort();
	return tmp32;
}

  #ifndef PLAIN_GKDB
NdtClone::MultuThreadStreams *connect_MT_streams(NdtClone::PagedFile * strFile, int DefaultPageSizeInStreams)
{
	if(DefaultPageSizeInStreams == -1)
		return new NdtClone::MultuThreadStreams(strFile);
	return new NdtClone::MultuThreadStreams(strFile, DefaultPageSizeInStreams);
}
namespace NdtClone {
static Core::Mutex m_mtx0;
typedef QuickSplayMap<ACE_thread_t,StreamFile_List*> Transaction_List;
Transaction_List TList(0);
}
  #endif


void StartThreadTransaction ( NdtClone::StreamFile_List *p_list )
{
	/*
// Отладчный вызов :
	m_keyFile = NdtClone::GetUpdatedPagedFile(buf, Defines::SI_SETTINGS_STORAGE_VERSION);
	// if opened database has invalid version next two calls will throw an exception
	if(!(m_keyFile->IsOk ())) {
		created = 1;
		m_keyFile->Create(2048);
		m_stream = connect_MT_streams(m_strFile, 4096);
		m_stream->Create();
	} else if(is_ok()) {
		m_stream = connect_MT_streams(m_strFile);
	} else {
		return;
	}
	m_index = new NodeInfoIndex (m_keyFile, "NodeInfo", m_stream, 1, 2);
	m_links = new LinksIndex (m_keyFile, "Links", m_stream, 1, 1);
	m_last_id = new LastIDIndex (m_keyFile, "LastId", m_stream, 1, 1);
	m_global_filters = new GlobalFiltersIndex (m_keyFile, "GlobalFilters", m_stream, 1, 1);

	if(rrpt--){
		int createdZ = 0;
		char nn[1024];
		sprintf(nn, "%s-new", fileName);
		NdtBase Zro(nn, true, createdZ);
		NdtClone::StreamFile_List TransactionStreams(0);
		TransactionStreams[m_stream];
		TransactionStreams[Zro.m_stream];
		StartThreadTransaction(&TransactionStreams);
	}
	*/
	NdtClone::StreamFile *pstr= 0;
	G_Point
		ii= p_list->first();
	int *lobjs= (int*)alloca(p_list->length() * sizeof(*lobjs)), inxt= 0;
	{
		while(ii){
			pstr= p_list->key(ii);
			pstr->is_next_write();
			p_list->next(ii);
		}
		/*for(inxt= 0, ii= p_list->first(); ii; p_list->next(ii)){
			pstr= p_list->key(ii);
			pstr->is_next_write();
			p_list->next(ii);
		}*/
		{
  #ifndef PLAIN_GKDB
			Core::Guard local(NdtClone::m_mtx0);
  #endif
			NdtClone::StreamFile_List *pTransactionStreams= new NdtClone::StreamFile_List(0), *pDel= pTransactionStreams;
			for(inxt= 0, ii= p_list->first(); ii; p_list->next(ii)){
				pstr= p_list->key(ii);
				lobjs[inxt++]= pstr->get_guard();
				if(pstr->GetTransactionCounter() == 0){
					// ещё хранилища в текущую ...
					pstr->StartTransaction();
					pTransactionStreams->get(pstr);
				}else
					pstr->StartTransaction();

				p_list->next(ii);
			}
			if(pTransactionStreams->length()){
  #ifndef PLAIN_GKDB
				ACE_thread_t local_id= ACE_OS::thr_self();
				G_Point ii= NdtClone::TList.seek(local_id);
				if(ii){
					for(G_Point jj= pTransactionStreams->first();jj;pTransactionStreams->next(jj)){
						(NdtClone::TList.contents(ii))->get(pTransactionStreams->key(jj));
					}
				}else{
					NdtClone::TList[local_id]= pTransactionStreams;
					pDel= 0;
				}
  #endif
			}
			if(pDel)
				delete pDel;
		}
		for(inxt= 0, ii= p_list->first(); ii; p_list->next(ii)){
			pstr= p_list->key(ii);
			pstr->kill_guard(lobjs[inxt++]);
		}
	}
}

void StartROTransaction ( NdtClone::StreamFile_List *p_list)
{
	NdtClone::StreamFile *pstr= 0;
	G_Point
		ii= p_list->first();
	int *lobjs= (int*)alloca(p_list->length() * sizeof(*lobjs)), inxt= 0;
	{
		while(ii){
			pstr= p_list->key(ii);
			lobjs[inxt++]= pstr->get_ro_guard();
			pstr->start_read_transaction();
			p_list->next(ii);
		}
		for(inxt= 0, ii= p_list->first(); ii; p_list->next(ii)){
			pstr= p_list->key(ii);
			pstr->kill_ro_guard(lobjs[inxt++]);
		}
	}
}

void EndROTransaction (NdtClone::StreamFile_List *p_list)
{
	NdtClone::StreamFile *pstr= 0;
	G_Point
		ii= p_list->first();
	int *lobjs= (int*)alloca(p_list->length() * sizeof(*lobjs)), inxt= 0;
	{
		while(ii){
			pstr= p_list->key(ii);
			lobjs[inxt++]= pstr->get_ro_guard();
			pstr->end_read_transaction();
			p_list->next(ii);
		}
		for(inxt= 0, ii= p_list->first(); ii; p_list->next(ii)){
			pstr= p_list->key(ii);
			pstr->kill_ro_guard(lobjs[inxt++]);
		}
	}
}
