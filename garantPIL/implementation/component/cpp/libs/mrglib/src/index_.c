#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "gdbapi.h"
#include "stdindex.h"

char *GetNameForTempFile(char *pCName, int hCFile)
{
	char *pTemplate= (char*)malloc(256);
	sprintf(pTemplate, "%s", pCName);
	sprintf(strrchr(pTemplate, '.'), ".%d", hCFile);
	return pTemplate;
}

#ifdef MULTI_INDEX_STREAM_FILE
	extern fat_rec_type *load_fat(streamfile_st *);
	extern void init_streams_cache(streamfile_st *, u_int32_t);
	extern void impModifyName(char *);
#ifdef INSTLL_CIB
	extern long DefValCryptoTag;
#endif
#endif

index_st *open_index(base_st *pbase,
					 const char *
#ifdef MULTI_INDEX_STREAM_FILE
					 nameEtl
#else
					 name
#endif
					 ,index_st *pin, short init_cache)
{
	index_st *pindex;
#ifdef MULTI_INDEX_STREAM_FILE
	char *name= strcpy((char*)malloc(1024), nameEtl), *pExt= strrchr(name, '.');
	SubTom_st	*pNxt= pbase->pSubToms;
#endif
	pindex = (pin) ? pin : (index_st *)ml_malloc(sizeof(index_st));
	pindex->pbase = pbase;
	if(!get_info(&(pbase->key), name, &(pindex->hdr))) {
#ifdef MULTI_INDEX_STREAM_FILE
		pindex->pf= NULL;
		if(pExt){
			*pExt= '\0';
			if(!get_info(&(pbase->key), name, &(pindex->hdr))) {
				*pExt= '.';
				strcpy(name, pbase->key.name);
				pExt= strrchr(name, '.');
				strcpy(pExt+1, nameEtl);
				strcpy(strrchr(pExt+1, '.'), ".key");
				impModifyName(name);
				while(pNxt->pKey){
					if(!strcmp(pNxt->pKey->PrmExt.FileName, name)){
						pindex->pf= pNxt->pKey;
						break;
					}
					pNxt++;
				}
				if(	(pindex->pf == NULL &&
						((pindex->pf= calloc(1, sizeof(pgfile_st))) == NULL
  #ifdef BRDR32
							||
		(pindex->pf->PrmExt.pCrptTag= (char*)calloc(1, sizeof(long))) == NULL
  #endif
							||
					!open_pgfile(name, pindex->pf))) ||
					!get_info(pindex->pf, nameEtl, &(pindex->hdr))) {
					if (!pin) free(pindex);
					free(name);
					return NULL;
				}
  #ifdef INSTLL_CIB
				pindex->pf->PrmExt.pCrptTag= (char*)&DefValCryptoTag;
  #endif
				name= strcpy(name, nameEtl);
				pExt= strrchr(name, '.');
			}else
				pExt= NULL;
		}else{
			if (!pin) free(pindex);
			free(name);
			return NULL;
		}
#else
		if (!pin) free(pindex);
		free(name);
		return NULL;
#endif
	}
	pindex->mode = 0;
	pindex->name = strdup(name);
	if(!get_index_info(name, pindex)) {
		pindex->hdr.strinfo.immds = 4;
		pindex->hdr.strinfo.rndv = 1;
		pindex->hdr.nstreams = 1;
		pindex->keycmp = (cmpfunc_ft)strcmp;
		pindex->hdr.keylen = 16;
		pindex->reclen = 4;
		pindex->reccmp = longcmp;
	}
#ifdef MULTI_INDEX_STREAM_FILE
	if(pExt){
		if(pNxt->pKey)
			pindex->str= pNxt->pStr;
		else{
			strcpy(name, pbase->key.PrmExt.FileName);
			pExt= strrchr(name, '.');
			strcpy(pExt+1, nameEtl);
			impModifyName(name);
			if((pindex->str= calloc(1, sizeof(streamfile_st))) == NULL
				|| !open_pgfile(name, (pgfile_st *)pindex->str)
				) {
				if (!pin) free(pindex);
				free(name);
				return NULL;
			}
		#ifdef BRDR32
			if(	(pindex->str->pgfile.PrmExt.pCrptTag=
					calloc(1, sizeof(long))) == NULL){
				return NULL;
			}
		#elif defined(INSTLL_CIB)
			pindex->str->pgfile.PrmExt.pCrptTag= (char*)&DefValCryptoTag;
		#endif
			pindex->pf->PrmExt.cur_Seek= pindex->str->pgfile.PrmExt.cur_Seek= my_def_io_seek;
			pindex->pf->PrmExt.cur_Read= pindex->str->pgfile.PrmExt.cur_Read= my_def_io_read;
			if(!load_fat(pindex->str)) {
				if (!pin) free(pindex);
				free(name);
				return NULL;
			}
			if ( init_cache ) init_streams_cache(pindex->str, pbase->openMode);
			pbase->pNextSubToms->pKey= pindex->pf;
			pbase->pNextSubToms->pStr= pindex->str;
			pbase->pNextSubToms->pName= strdup(nameEtl);
			pbase->pNextSubToms++;
		}
		pExt= NULL;
	}else{
#endif
		pindex->str = &(pbase->str);
		pindex->pf = &(pbase->key);
#ifdef MULTI_INDEX_STREAM_FILE
	}
	if(pExt) *pExt= '.';
	free(name);
#endif
	pindex->phdrpage = pbase->key_header;
	return pin;
}

index_st *open_index_hack(pgfile_st *pf, const char *name, index_st *pin)
{
	index_st *pindex;
	
	pindex = (pin) ? pin : (index_st *)ml_malloc(sizeof(index_st));
	if(!get_info(pf, name, &(pindex->hdr))) {
		if (!pin) free(pindex);
		return NULL;
	}
	pindex->mode = 0;
	pindex->name = strdup(name);
	if(!get_index_info(name, pindex)) {
		pindex->hdr.strinfo.immds = 4;
		pindex->hdr.strinfo.rndv = 1;
		pindex->hdr.nstreams = 1;
		pindex->keycmp = (cmpfunc_ft)strcmp;
		pindex->hdr.keylen = 16;
		pindex->reclen = 4;
		pindex->reccmp = longcmp;
	}
	pindex->pf = pf;
	pin->phdrpage = NULL;
  pin->str = NULL;
	return pin;
}

#ifdef BRDR32
		extern int makedTmp;
#endif

#ifdef MULTI_INDEX_STREAM_FILE
extern streamfile_st *create_stream_subFile(char *path, index_st *pin);
#endif

index_st *create_indexEx(base_st *pbase, const char *name, index_st *pin, void *pOtherRootNodeOut)
{
#ifndef BRDR32
	int LastOther= 0;
	if(get_info(&(pbase->key), name, NULL)) return NULL;
	if(!pin) pin = (index_st *)ml_malloc(sizeof(index_st));
	bzero((caddr_t)pin, sizeof(index_st));
	pin->mode = 1;
	if(!get_index_info(name, pin)) {
		pin->hdr.strinfo.immds = 4;
		pin->hdr.strinfo.rndv = 1;
		pin->hdr.nstreams = 1;
		pin->keycmp = (cmpfunc_ft)strcmp;
		pin->hdr.keylen = 16;
		pin->reclen = 4;
		pin->reccmp = longcmp;
		pin->hdr.nstreams = 1;
	}
#ifdef MULTI_INDEX_STREAM_FILE
	if(!pbase->pNextSubToms){
		pbase->pNextSubToms=
			pbase->pSubToms= calloc(	100, // !!! Кривой вариант только для 100 индексов
											sizeof(SubTom_st));
	}
#endif
	pin->pbase = pbase;
#ifdef MULTI_INDEX_STREAM_FILE
	if(strrchr(name, '.')){
		char	*filename = (char *)ml_malloc(1024), *pExt;
		pin->pf= calloc(1, sizeof(pgfile_st));
		strcpy(filename, pbase->key.name);
		pExt= strrchr(filename, '.')+1;
		strcpy(pExt, name);
		pExt= strrchr(pExt, '.');
		strcpy(pExt, ".key");
		impModifyName(filename);
		if(pin->pbase->pSubToms != pin->pbase->pNextSubToms && !strcmp((pin->pbase->pNextSubToms-1)->pKey->name, filename)){
			pin->pf = (pin->pbase->pNextSubToms-1)->pKey;
			LastOther++;
		}else{
			if(strrchr(filename,'.') && strrchr(filename,'.')[1] == '1'){
				create_pgfile(filename, pin->pf, 4096);
			}else{
				create_pgfile(filename, pin->pf, 2048);
			}
	#ifdef BRDR32
			*(long*)pin->pf->PrmExt.pCrptTag= 0l;
	#elif defined(INSTLL_CIB)
			pin->pf->PrmExt.pCrptTag= (char*)&DefValCryptoTag;
	#endif
			pin->pbase->pNextSubToms->pKey= pin->pf;
			free(filename);
		}
	}else
#endif
		pin->pf = &(pbase->key);
	pin->name = strdup(name);
	pin->phdrpage = pbase->key_header;
	bzero((caddr_t) &(pin->kar), sizeof(keyarray_st));
//#if defined(__DOS32__) || defined(__WIN32__)	// !!!
	pin->kar.fname = GetNameForTempFile(pbase->key.name, pbase->key.hfile);
#ifdef BRDR32
	makedTmp=
#endif
		pin->kar.hkeys= c_io_open(pin->kar.fname, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY); // GARANT_GCC
/*#else
	pin->kar.fname = strdup("karXXXX");
	pin->kar.hkeys = mkstemp(pin->kar.fname);
#endif*/
	reset_key_array(&(pin->kar), pin->hdr.keylen);
#ifdef MULTI_INDEX_STREAM_FILE
	if(LastOther){
		pin->str = (pin->pbase->pNextSubToms-1)->pStr;
	}else if(strrchr(name, '.')){
		char *filename = (char *)ml_malloc(1024);
		strcpy(filename, pbase->key.name);
		pin->str= create_stream_subFile(filename, pin);
#ifdef BRDR32
		*(long*)pin->str->pgfile.PrmExt.pCrptTag= 0l;
#elif defined(INSTLL_CIB)
		pin->str->pgfile.PrmExt.pCrptTag= (char*)&DefValCryptoTag;
#endif
		pin->pbase->pNextSubToms->pStr= pin->str;
		pin->pbase->pNextSubToms->pName= strdup(name);
		pin->pbase->pNextSubToms++;
		free(filename);
	}else
#endif
	pin->str = &(pbase->str);

	pin->hdr.order = ((pin->pf->pfhdr->page_size-6)/(pin->hdr.keylen+4)) >> 1;
	pin->hdr.root = 0;
	pin->hdr.key_count = 0;
	pin->hdr.depth = 1;
#ifdef MULTI_INDEX_STREAM_FILE
	if(pOtherRootNodeOut){
		memcpy(pOtherRootNodeOut, &(pin->hdr), sizeof(bthdr_st));
	}else
#endif
	set_info(pin->pf, name, &(pin->hdr), sizeof(bthdr_st));
#endif
	return pin;
}

index_st *create_index(base_st *pbase, const char *name, index_st *pin)
{
	return create_indexEx(pbase, name, pin, NULL);
}


index_st *create_index_hack(pgfile_st *pf, const char *name, index_st *pin)
{
	if(get_info(pf, name, NULL))
		return NULL;
	if(!pin){
		pin = (index_st *)ml_malloc(sizeof(index_st));
	}
	bzero((caddr_t)pin, sizeof(index_st));
	pin->mode = 1;

	if(!get_index_info(name, pin)) {
		pin->hdr.strinfo.immds = 4;
		pin->hdr.strinfo.rndv = 1;
		pin->hdr.nstreams = 1;
		pin->keycmp = (cmpfunc_ft)strcmp;
		pin->hdr.keylen = 16;
		pin->reclen = 4;
		pin->reccmp = longcmp;
	}
	pin->pf = pf;
	pin->name = strdup(name);
	pin->phdrpage = NULL;
//#ifdef WIN32 // !!!
	pin->kar.fname = GetNameForTempFile(pin->pf->name, pin->pf->hfile);
	pin->kar.hkeys= c_io_open(pin->kar.fname, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY); // GARANT_GCC
/*#else
	pin->kar.fname = strdup("karXXXX");
	pin->kar.hkeys = mkstemp(pin->kar.fname);
#endif*/
	reset_key_array(&(pin->kar), pin->hdr.keylen);
	pin->str = NULL;
	pin->hdr.order = ((pf->pfhdr->page_size-6)/(pin->hdr.keylen+4)) >> 1;
	pin->hdr.root = 0;
	pin->hdr.key_count = 0;
	pin->hdr.depth = 1;
	set_info(pf, name, &(pin->hdr), sizeof(bthdr_st));
	return pin;
}
void close_indexEx(index_st *pin, void *pOtherRootNodeOut)
{
	if(pin->mode) {
		// close created index
		build_btree(pin);
		flog("Writing index info [%s]...", pin->name);
		if(pOtherRootNodeOut)
			memcpy(pOtherRootNodeOut, &(pin->hdr), sizeof(bthdr_st));
		else
			set_info(pin->pf, pin->name, &(pin->hdr), sizeof(bthdr_st));
		c_io_close(pin->kar.hkeys);
		pin->kar.hkeys= 0;
		ace_os_unlink(pin->kar.fname);
		free(pin->kar.fname);
		pin->kar.fname= NULL;
		flog("Deleting cache\n");
		free(pin->kar.cache);
	}
	else { // Nothing to do ?
	}
}
void close_index(index_st *pin)
{
	close_indexEx(pin, NULL);
}
void add_key(index_st *pin, void *pkey)
{
	pin->hdr.key_count++;
	if(pin->flags & 0x0040) {
		if(pin->hdr.last_id < ((hierkey_st *)pkey)->id)
			pin->hdr.last_id = ((hierkey_st *)pkey)->id;
	}
	write_key(&(pin->kar), pkey);
}

