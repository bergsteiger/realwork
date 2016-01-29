#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>

#include <unistd.h>
#include <sys/stat.h>

#include <string.h>

#include <basemask.h>
#include <garver.h>

#define SZ_STEP_ALLOC	32

int _imp_createVersionStatus(	LPVER_PARAM pParam,
								char *pModule,			// module file name
								char *pRV				// RV file name
							);

int _imp_checkVersionStatus(	LPVER_PARAM pParam,
								char *pModule,			// module file name
								char *pRV				// RV file name
							);

int _imp_GVersion(	int *argc, char *argv[], LPVER_PARAM pParam)
{
	int ii, retV;
	char pDefault[]= DEFAULT_RV_FILE_NAME, *pRV= pDefault;

	//fprintf(pParam->stdOut, EXE_MODULE_FORMAT_INFO, pRV);
	for(ii=1; ii < *argc; ii++){
		if(strchr(argv[ii], '-') != NULL && (argv[ii][1] == 'v' || argv[ii][1] == 'V')){
			if(argv[ii][2] == ':') {
				pRV= argv[ii]+3;
				if((retV=_imp_checkVersionStatus(	pParam,
													*argv, pRV))){
					if(retV == -33){
						fprintf(pParam->stdOut, DEFAULT_VSTATUS_FORMAT, "TIME");
					}else if(retV == -22){
						fprintf(pParam->stdOut, DEFAULT_VSTATUS_FORMAT, "DATE");
					}else{
						fprintf(pParam->stdOut, DEFAULT_VERROR_FORMAT, retV);
					}
				}
				(*argc)--;
				while(ii < *argc){
					argv[ii]= argv[ii+1];
					ii++;
				}
				return retV;
			}
		}else if(argv[ii][0] == '-' && (argv[ii][1] == 'z'||argv[ii][1] == 'Z')){
			if(argv[ii][2] == ':')
				pRV= argv[ii]+3;
			if((retV=_imp_createVersionStatus(	pParam,
												*argv, pRV))){
				fprintf(pParam->stdOut, DEFAULT_VERROR_FORMAT, retV);
				return retV;
			}
			return VC_ADD_OK;
		}
	}
	if((retV=_imp_checkVersionStatus(	pParam,
										*argv, pRV))){
		if(retV == -33){
			fprintf(pParam->stdOut, DEFAULT_VSTATUS_FORMAT, "TIME");
		}else if(retV == -22){
			fprintf(pParam->stdOut, DEFAULT_VSTATUS_FORMAT, "DATE");
		}else{
			fprintf(pParam->stdOut, DEFAULT_VERROR_FORMAT, retV);
		}
	}
	return retV;
}
/*
int _imp_strGVersion(	char *pAppPath, char *pStr, LPVER_PARAM pParam)
{
	int retV;
	char pDefault[]= DEFAULT_RV_FILE_NAME, *pRV= pDefault;

	while((pStr= strchr(pStr, '-')) != NULL){
		pStr++;
		if(*pStr == 'v' || *pStr == 'V'){
			if(pStr[1] == ':')
				pRV= pStr+2;
			if((retV=_imp_checkVersionStatus(	pParam,
												pAppPath, pRV))){
				if(retV == -33){
					fprintf(pParam->stdOut, DEFAULT_VSTATUS_FORMAT, "TIME");
				}else if(retV == -22){
					fprintf(pParam->stdOut, DEFAULT_VSTATUS_FORMAT, "DATE");
				}else{
					fprintf(pParam->stdOut, DEFAULT_VERROR_FORMAT, retV);
				}
			}
			return IS_NOT_CONTINUE;
		}else if(*pStr == 'z' || *pStr == 'Z'){
			if(pStr[1] == ':')
				pRV= pStr+2;
			if((retV=_imp_createVersionStatus(	pParam,
												pAppPath, pRV))){
				fprintf(pParam->stdOut, DEFAULT_VERROR_FORMAT, retV);
			}
			return IS_NOT_CONTINUE;
		}
	}
	if((retV=_imp_checkVersionStatus(	pParam,
										pAppPath, pRV))){
		if(retV == -33){
			fprintf(pParam->stdOut, DEFAULT_VSTATUS_FORMAT, "TIME");
		}else if(retV == -22){
			fprintf(pParam->stdOut, DEFAULT_VSTATUS_FORMAT, "DATE");
		}else{
			fprintf(pParam->stdOut, DEFAULT_VERROR_FORMAT, retV);
		}
		retV= IS_NOT_CONTINUE;
	}
	return retV;
}
*/
int _writeOffset(int fh, long currPos, long woffset)
{
	c_io_lseek(	fh, woffset, ACE_OS_SEEK_SET);
	c_io_write(fh, &currPos, sizeof(long));
	c_io_lseek(	fh, 0l, ACE_OS_SEEK_END);
	return sizeof(long);
}

static int _writeFromPostWriteBuff(int fh, long endPos, char** ppPWBuff, int szPWBuff)
{
	int retV= szPWBuff, ii;
	long *pTmp;

	while(--szPWBuff != -1){
		if(*((long*)(ppPWBuff[szPWBuff]+sizeof(long)*2)) < endPos){
			szPWBuff++;
			retV -= szPWBuff;
			break;
		}
	}
	while(szPWBuff > 0){
		pTmp= (long*)(*ppPWBuff);
		c_io_lseek( fh, pTmp[2] - *pTmp, ACE_OS_SEEK_SET);
		c_io_write( fh, pTmp+2, *pTmp);
		for(ii= 1; ii < szPWBuff; ii++)
			ppPWBuff[ii-1] = ppPWBuff[ii];
		szPWBuff--;
		ppPWBuff[szPWBuff]= (char*)pTmp;
	}
	return retV;
}

static int _boolFree(void *pMem, int sz)
{
	int ii= 0;
	while(ii < sz && *((void **)pMem + ii)){
		free(*((void **)pMem + ii));
		ii++;
	}
	free(pMem);
	return 1;
}

static int _addLineInRV(	LPVER_PARAM pParam,
							long lCompiler,			// Compiler type
							char *pRV				// RV file name
												)
{
	int fh;
	long fSz, ltmp, ii, offsetPos;

	if((fh= c_io_open( pRV, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY)) == -1){ // GARANT_GCC
		return -3;
	}
	fSz= c_io_lseek(	fh, 0l, ACE_OS_SEEK_END);	// seek to eof
	c_io_lseek(	fh, 0l, ACE_OS_SEEK_SET);	// seek to beginning
	if(fSz == 0){
#ifdef _DEBUG
		char *pENGL_NAMES_LIST_DISTRIB[]= ENGL_NAMES_LIST_DISTRIB;
		char *pTID_NAMES_LIST_ENGL[]= TID_NAMES_LIST_ENGL;
		if(c_io_write(fh, (long*)(RV_SIGNATURE+sizeof(long)), sizeof(long)) != sizeof(long)){
			c_io_close(fh);
			ace_os_unlink(pRV);
			return -5;
		}
		if(c_io_write(fh, (long*)RV_SIGNATURE, sizeof(long)) != sizeof(long)){
			c_io_close(fh);
			ace_os_unlink(pRV);
			return -5;
		}
		pParam->lTID_Max=  TID_MAX_VALUE;
		if(c_io_write(fh, &pParam->lTID_Max, sizeof(long)) != sizeof(long)){
			c_io_close(fh);
			ace_os_unlink(pRV);
			return -5;
		}
		offsetPos= sizeof(long)+sizeof(long)+sizeof(long);
		if(c_io_write(fh, &ltmp, sizeof(long)) != sizeof(long)){
			c_io_close(fh);
			ace_os_unlink(pRV);
			return -5;
		}
		ltmp= TID_NAMES_LNGG_SIZE;
		if(c_io_write(fh, &ltmp, sizeof(long)) != sizeof(long)){
			c_io_close(fh);
			ace_os_unlink(pRV);
			return -5;
		}
		ltmp= ENGL_NAMES_LIST_SIZE/2;
		if(c_io_write(fh, &ltmp, sizeof(long)) != sizeof(long)){
			c_io_close(fh);
			ace_os_unlink(pRV);
			return -5;
		}
		for(fSz= 0; fSz < ENGL_NAMES_LIST_SIZE; fSz++){
			ii= strlen(pENGL_NAMES_LIST_DISTRIB[(int)fSz]);
			if(fSz%2){
				if(c_io_write(fh, pENGL_NAMES_LIST_DISTRIB[(int)fSz], ++ii) != ii){
					c_io_close(fh);
					ace_os_unlink(pRV);
					return -5;
				}
			}else if(c_io_write(fh, pENGL_NAMES_LIST_DISTRIB[(int)fSz], ii) != ii){
					c_io_close(fh);
					ace_os_unlink(pRV);
					return -5;
				}
		}
		ltmp= TID_MAX_VALUE+1;
		if(c_io_write(fh, &ltmp, sizeof(long)) != sizeof(long)){
			c_io_close(fh);
			ace_os_unlink(pRV);
			return -5;
		}
		for(fSz= 0; fSz < ltmp; fSz++){
			ii= strlen(pTID_NAMES_LIST_ENGL[(int)fSz]);
			if(c_io_write(fh, pTID_NAMES_LIST_ENGL[(int)fSz], ++ii) != ii){
				c_io_close(fh);
				ace_os_unlink(pRV);
				return -5;
			}
		}
		ltmp=0;
		_writeOffset(fh, c_io_tell(fh), offsetPos );
#else
		c_io_close(fh);
		ace_os_unlink(pRV);
		return -5;
#endif
	}else{
		c_io_read( fh, &ltmp, sizeof(long));
#ifdef _DEBUG
		if(ltmp != *((long*)(RV_SIGNATURE+sizeof(long))))
#else
		if(ltmp != *((long*)RV_SIGNATURE))
#endif
		{
			c_io_close(fh);
			return -7;
		}
		c_io_read( fh, &ltmp, sizeof(long));
#ifdef _DEBUG
		if(ltmp != *((long*)RV_SIGNATURE))
#else
		if(ltmp != *((long*)(RV_SIGNATURE+sizeof(long))))
#endif
		{
			c_io_close(fh);
			return -7;
		}
		c_io_read( fh, &pParam->lTID_Max, sizeof(long));
		if((long)pParam->exeId > pParam->lTID_Max){
			c_io_close(fh);
			return -6;
		}
		offsetPos= sizeof(long)+sizeof(long)+sizeof(long);
		c_io_read( fh, &ii, sizeof(long));
		while(ii){
			offsetPos= ii;
			if(c_io_lseek( fh, offsetPos, ACE_OS_SEEK_SET) != fSz){
				c_io_read( fh, &ii, sizeof(long));
				c_io_read( fh, &ltmp, sizeof(long));
				if( ltmp == (long)pParam->exeId){
					c_io_read( fh, &ltmp, sizeof(long));
					if( ltmp == pParam->lDstrbtd){
						c_io_read( fh, &ltmp, sizeof(long));
						if( ltmp == lCompiler)
							break;
					}
				}
				if(!ii){
					c_io_lseek( fh, offsetPos, ACE_OS_SEEK_SET);
					c_io_write( fh, &fSz, sizeof(long));
					offsetPos= fSz;
				}
			}else{
				ii= 0l;
			}
		}
		if(ii){
			int	delta= ii- offsetPos,
				tmp=	sizeof(long)+sizeof(long)+sizeof(long)+sizeof(long)
							+strlen(__DATE__)+strlen(__TIME__)+2;
			if(tmp > delta){
				int	preBuffSz= 0, offPos, allSz= 0, currSz= 0;
				char *pBuff= NULL, **ppPostWriteBuff= NULL;

				// Remove next to current //
				do{
					c_io_lseek( fh, ii, ACE_OS_SEEK_SET);
					offPos= ii;
					c_io_read( fh, &ii, sizeof(long));
					if(!ii){
						ltmp= fSz - offPos;
						tmp= fSz- delta;
					}else{
						ltmp= ii - offPos;
						tmp= ii- delta;
					}
					if(ltmp > preBuffSz){
						if(pBuff != NULL) free(pBuff);
						preBuffSz= ltmp*2;
						if((pBuff= (char*)malloc(preBuffSz)) == NULL){
							c_io_close(fh);
							ace_os_unlink(pRV);
							return -5;
						}
					}
					c_io_read( fh, pBuff, ltmp-sizeof(long));
					currSz= _writeFromPostWriteBuff(fh, ii, ppPostWriteBuff, currSz);
					if(tmp > offPos){
						if(allSz == currSz){
							char** ppTmp;
							allSz+= SZ_STEP_ALLOC;
							if((ppTmp= (char**)malloc(allSz*sizeof(char*))) == NULL){
								if(pBuff != NULL)
									free(pBuff);
								if(ppPostWriteBuff != NULL)
									_boolFree(ppPostWriteBuff, allSz);
								c_io_close(fh);
								ace_os_unlink(pRV);
								return -5;
							}
							memset(ppTmp, 0, allSz*sizeof(char*));
							if(ppPostWriteBuff != NULL){
								memcpy(ppTmp, ppPostWriteBuff, currSz*sizeof(char*));
								free(ppPostWriteBuff);
							}
							ppPostWriteBuff= ppTmp;
						}
						// new size for malloc //
						offPos= ltmp + (long)sizeof(long)*3;
						if( (ppPostWriteBuff[currSz] == NULL ||
				// it is ignore new malloc //
												// prev malloc size//
				((	offPos > *((long*)(ppPostWriteBuff[currSz] + sizeof(long)))
					// free prev malloc //
					&& _boolFree(ppPostWriteBuff[currSz],0))
									)
							// yes. ignore.
						|| ((offPos= *((long*)(ppPostWriteBuff[currSz] + sizeof(long)))) && 0))
								// new malloc //
							&& (offPos *= 2)
							&& (ppPostWriteBuff[currSz]
									= (char*)malloc(offPos)) == NULL){
							if(pBuff != NULL) free(pBuff);
							if(ppPostWriteBuff != NULL) _boolFree(ppPostWriteBuff, allSz);
							c_io_close(fh);
							ace_os_unlink(pRV);
							return -5;
						}
						// Put in PostWrite buffer //
						*((long*)ppPostWriteBuff[currSz]) = ltmp;
						*((long*)(ppPostWriteBuff[currSz] + sizeof(long)))
							= offPos;

						*((long*)(ppPostWriteBuff[currSz] + sizeof(long)*2))
							= tmp;
						memcpy(ppPostWriteBuff[currSz] + sizeof(long)*3,
								pBuff, ltmp);
						currSz++;
						/////////////////////////////
					}else{
						c_io_lseek( fh, offsetPos, ACE_OS_SEEK_SET);
						c_io_write(fh, &tmp, sizeof(long));
						c_io_write( fh, pBuff, ltmp-sizeof(long));
						/////////////////////////////////////
					}
					offsetPos= tmp;
				}while(ii);
				if(pBuff != NULL) free(pBuff);
				_writeFromPostWriteBuff(fh, fSz, ppPostWriteBuff, currSz);
				if(ppPostWriteBuff != NULL) _boolFree(ppPostWriteBuff, allSz);
				ltmp=0;
			}else
				ltmp=ii;
		}else
			ltmp=0;

		c_io_lseek( fh, offsetPos, ACE_OS_SEEK_SET);
		
	}
	// Update as Last //
	c_io_write(fh, &ltmp, sizeof(long));
	c_io_write(fh, &pParam->exeId, sizeof(long));
	c_io_write(fh, &pParam->lDstrbtd, sizeof(long));
	c_io_write(fh, &lCompiler, sizeof(long));
	c_io_write(fh, pParam->pDate, strlen(pParam->pDate)+1);
	c_io_write(fh, pParam->pTime, strlen(pParam->pTime)+1);

	c_io_close(fh);
	return 0;
}

static int _chkLineInRV(	LPVER_PARAM pParam,
							long lCompiler,			// Compiler type
							char *pRV				// RV file name
												)
{
	int fh, preRetV= 0;
	long fSz, ltmp, offsetPos, ii;

	//fprintf(pParam->stdOut, EXE_MODULE_FORMAT_INFO, pRV);

	if((fh= c_io_open( pRV, ACE_OS_O_RDONLY | ACE_OS_O_BINARY)) == -1){ // GARANT_GCC
		return -4;
	}
//#ifdef	GARANT_TOOLS
	fSz=c_io_lseek( fh, 0l, ACE_OS_SEEK_END);	// seek to eof
//#else
//	c_io_lseek(	fh, 0l, ACE_OS_SEEK_END);	// seek to eof
//	fSz= c_io_tell(fh);			// get file length
//#endif
	c_io_lseek(	fh, 0l, ACE_OS_SEEK_SET);	// seek to beginning
	if(fSz != 0){
		c_io_read( fh, &ltmp, sizeof(long));
#ifdef _DEBUG
		if(ltmp != *((long*)(RV_SIGNATURE+sizeof(long))))
#else
		if(ltmp != *((long*)RV_SIGNATURE))
#endif
		{
			c_io_close(fh);
			return -7;
		}
		c_io_read( fh, &ltmp, sizeof(long));
#ifdef _DEBUG
		if(ltmp != *((long*)RV_SIGNATURE))
#else
		if(ltmp != *((long*)(RV_SIGNATURE+sizeof(long))))
#endif
		{
			c_io_close(fh);
			return -7;
		}
		c_io_read( fh, &pParam->lTID_Max, sizeof(long));
		if((long)pParam->exeId > pParam->lTID_Max){
			c_io_close(fh);
			return -6;
		}
		offsetPos= sizeof(long)+sizeof(long)+sizeof(long);
		c_io_read( fh, &ii, sizeof(long));
		while(ii){
			offsetPos= ii;
			c_io_lseek( fh, offsetPos, ACE_OS_SEEK_SET);
			c_io_read( fh, &ii, sizeof(long));
			c_io_read( fh, &ltmp, sizeof(long));
			if( ltmp == (long)pParam->exeId){
				c_io_read( fh, &ltmp, sizeof(long));
				if( ltmp == pParam->lDstrbtd){
					c_io_read( fh, &ltmp, sizeof(long));
					if( ltmp == lCompiler){
	////////////////
	char *pBuff;
	int retV= -5;
	if(!ii){
		ltmp= fSz - offsetPos;
	}else{
		ltmp= ii - offsetPos;
	}
	if((pBuff= (char*)malloc(ltmp)) == NULL){
		c_io_close(fh);
		ace_os_unlink(pRV);
		return -5;
	}
	c_io_read( fh, pBuff, ltmp-sizeof(long));
	if(strcmp(pBuff, pParam->pDate) != 0)
		preRetV= -22;
	else if(strcmp(pBuff+strlen(pBuff)+1, pParam->pTime) != 0)
		preRetV= -33;

	{
		int jj, qq=0, szRead, find= (int)pParam->lDstrbtd;
		long tt0, tt1;
		char *pOut= pBuff;
		// Output Version information //
		c_io_lseek(	fh, sizeof(long)+sizeof(long)+sizeof(long)+sizeof(long), ACE_OS_SEEK_SET);
		c_io_read( fh, &offsetPos, sizeof(long)); // TID_NAMES_LNGG_SIZE
		tt0 = offsetPos * pParam->lDstrbtd;
		tt1 = offsetPos * pParam->exeId;

		c_io_read( fh, &ii, sizeof(long)); // ENGL_NAMES_LIST_SIZE
		ii *= offsetPos;

		if(tt0 > ii){
			c_io_close(fh);
			free(pBuff);
			return -2;
		}
		szRead= (int)c_io_read( fh, pBuff, ltmp);
		while(szRead){
			jj=0;
			while(szRead){
				for(; jj < (int)ii && qq < szRead; qq++){
					if(pBuff[qq] == 0){
						if(jj == find){
							if(ii > pParam->lTID_Max){
								fprintf(pParam->stdOut, EXE_MODULE_FORMAT_INFO, pOut);
								jj= (int)ii;
								szRead= 0;
								retV= 0;
							}else
								fprintf(pParam->stdOut, DISTRIB_FORMAT_INFO, pOut);
						}
						jj++;
						pOut= pBuff + qq + 1;
					}
				}
				if(jj < (int)ii){
					char *pTmp;
					ltmp += ltmp;
					if((pTmp= (char*)malloc(ltmp*sizeof(char))) == NULL){
						retV= -5;
						szRead= 0;
						break;
					}
					qq= szRead - (int)(pOut - pBuff);
					memcpy(pTmp, pOut, qq);
					free(pBuff);
					pOut= pBuff= pTmp;
					if((szRead= (int)c_io_read( fh, pBuff+qq, ltmp-qq)) != 0)
						szRead += qq;
				}else
					break;
			}
			find= (int)tt1;
			ii= *((long*)pOut);
			ii *= offsetPos;
			qq += sizeof(long);
			pOut += sizeof(long);
		}
	}
	c_io_close(fh);
	free(pBuff);
	if(!retV)
		retV= preRetV;
	return retV;
	////////////////
					}
				}
			}
			offsetPos= fSz;
		}
	}
	c_io_close(fh);
	return -2;
}

static int _processVrsnStatus(	LPVER_PARAM pParam,
								char *pModule,			// module file name
								char *pRV,				// RV file name
								long lProcess			// RV process
													)
{
	int ii, jj;
	char	*pFName= NULL;

	long	lCompiler=
#if   defined (__FreeBSD__)                       /* FreeBSD/GCC */ // GARANT_FREEBSD
								1l
#elif defined (__Linux__)                         /* Linux/GCC */
								2l
#elif defined (__Solaris__)                       /* Solaris/{GCC, Sun cc} */
								3l
#elif defined (__DOS16__)                         /* DOS/Borland C++ 4.5 */
								4l
#elif defined (__DOS32__)                         /* DOS/{Borland C 4.5, GCC} */
	#ifdef __GNUC__
								5l
	#else
								6l
	#endif
#elif defined (__WIN16__)                         /* Win16/MSVC 1.52 */
								7l
#elif defined (__WIN32__)                         /* Win32/{Cygwin, GNU Win32, MSVC 4+} */
	#ifdef __GNUC__
		#ifdef __CYGWIN32__                          /* Assume we use Cygwin b18 */
			#ifndef __CYGWIN_EGCS__
								8l
			#else
								9l
			#endif
		#else
			#ifndef __CYGWIN_EGCS__
								10l
			#else
								11l
			#endif
		#endif
	#else
		#ifndef __CYGWIN_EGCS__
								13l
		#else
								14l
		#endif
	#endif
#else
	#error Unknown target platform
#endif
				;

	if( pParam == NULL
		|| pRV == NULL
		|| pModule == NULL){
		return -6;
	}
	ii= strlen(pRV);
	if(IS_FULL_PATH(pRV)){
		if((pFName= (char*)malloc(	sizeof(char)
										* (ii + 1)))
				== NULL)
			return -5;
		memcpy(pFName, pRV, ii+1);
		if(lProcess != 2l)
			lProcess = 3l;
	}else{
		char	*stmp;
		jj= strlen(pModule) + 1;
		if((pFName= (char*)malloc(	sizeof(char)
										* (ii + jj)))
				== NULL)
			return -5;

		memcpy(pFName, pModule, jj);
		if((stmp= strrchr(pFName, DIRECTORIES_TERM))
						!= NULL){
			if(pRV[0] == '.' && pRV[1] == DIRECTORIES_TERM){
				memcpy(pFName+(stmp- pFName+ 1), pRV+2, ii-1);
			}else{
				char *pFirst= NULL, *sTmp;
				pFirst= pRV;
				while((sTmp= strchr(pFirst, '.')) != NULL &&
						sTmp[1] == '.' && stmp != NULL){
					stmp[0]= '\0';
					pFirst += 3;
					stmp= strrchr(pFName, DIRECTORIES_TERM);
				}
				if((sTmp != NULL && sTmp[0] == '.' && sTmp[1] == '.'
									&& sTmp[3] == DIRECTORIES_TERM) || stmp == NULL){
					free(pFName);
					return -2;
				}
				memcpy(pFName+(stmp- pFName+ 1), pFirst, strlen(pFirst)+1);
			}
		}else
			memcpy(pFName, pRV, ii+1);

	}
	if(lProcess == 2l && (ii= _addLineInRV(	pParam, lCompiler, pFName ))){
		free(pFName);
		return ii;
	}else if((jj= _chkLineInRV(	pParam, lCompiler, pFName ))){
		if(lProcess == 1l){
			char	*stmp= strrchr(pRV, DIRECTORIES_TERM);
			free(pFName);
			if(stmp != NULL){
				ii= _processVrsnStatus(pParam, pModule, stmp+1, 3l);
				if(ii == 0)
					return 0;
			}
		}else
			free(pFName);
		return jj;
	}
	free(pFName);
	return 0l;
}

int _imp_createVersionStatus(	LPVER_PARAM pParam,
								char *pModule,			// module file name
								char *pRV				// RV file name
							)
{
	return _processVrsnStatus(	pParam, pModule, pRV, 2l );
}

int _imp_checkVersionStatus(	LPVER_PARAM pParam,
								char *pModule,			// module file name
								char *pRV				// RV file name
							)
{
	return _processVrsnStatus(	pParam, pModule, pRV, 1l );
}

