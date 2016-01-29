#include "shared/Core/fix/mpcxc.h"
#include <fcntl.h>
#include <stdio.h>
#include <time.h>
#include <sys/stat.h>
#include <stdlib.h>

#include "gdbapi.h"

u_int32_t discards = 0;

#ifdef BRDR32
extern void otherCopyFat(void *, unsigned long *, int);
#ifdef MULTI_INDEX_STREAM_FILE
	extern void otherCopyIndexs(void *pCntx, base_st *pbase);
#endif
// Copy source FAT function. Returns address of loaded FAT
fat_rec_type *load_fat_Brdr32(streamfile_st *pfile)
{
	u_int32_t size;

	get_info(&pfile->pgfile, "FatSize", &pfile->fat_size);
	size = ((u_int32_t)(pfile->fat_size)) << pfile->pgfile.pgpow;
	pfile->fat = (fat_rec_type *)ml_malloc(size);
	if(!(pfile->fat)) return NULL;
	otherCopyFat(((pgfile_st*)pfile)->PrmExt.pScreenCntxt, pfile->fat, size);

	otherCopyIndexs(	pfile->pgfile.PrmExt.pScreenCntxt,
						pfile->pgfile.PrmExt.buf);

	return pfile->fat;
}
#endif
// Loading source FAT function. Returns address of loaded FAT
fat_rec_type *load_fat(streamfile_st *pfile)
{
	char *attr;
	fat_rec_type page;
	int i, pgsize;
	u_int32_t size;

	get_info((pgfile_st *)pfile, "FatSize", &(pfile->fat_size));
	size = ((u_int32_t)(pfile->fat_size)) << ((pgfile_st *)pfile)->pgpow;
	pfile->fat = (fat_rec_type *)ml_malloc(size);
	if(!(pfile->fat)) return NULL;
	bzero((caddr_t)(pfile->fat), size);
	memset(pfile->fat, 0, pfile->fat_size << ((pgfile_st *)pfile)->pgpow);
	attr = (char *)(pfile->fat);
	page = 1; pgsize = 1 << ((pgfile_st *)pfile)->pgpow;
	for(i=0; i<pfile->fat_size && page; i++) {
		read_page((pgfile_st *)pfile, page, attr);
		attr += pgsize;
		page = pfile->fat[page] & ~CHAIN_FLAG;
	}
	return pfile->fat;
}

void init_streams_cache(streamfile_st *pfile, u_int32_t mode)
{
	cache_entry *pent;
	u_int32_t flen, pgsize;
	fat_rec_type j, *hit, *fat;
	int cachepow;
	u_int32_t i;
	char *ext;

	flen = pfile->pgfile.pfhdr->last_page+1; // <<((pgfile_st *)pfile)->pgpow;
	pgsize = pfile->pgfile.pfhdr->page_size;
	hit = pfile->hits = (fat_rec_type *)ml_malloc(pfile->fat_size*pgsize);
	fat = pfile->fat;
	for(j=(u_int16_t)(flen>>12); j; j--, fat++)
		*hit++ = (*fat) & CHAIN_FLAG;
	cachepow = (mode & 0x000F0000) >> 16;
	if(mode & 0x00004000) {
		cachepow += 2;
		pfile->cache_get_page = rsp_get_page;
		for(pfile->cmax=256; flen >= (((u_int32_t)(pfile->cmax)) << cachepow); pfile->cmax += 256);
	}
	else if(mode & 0x00008000) {
		pfile->cmax = (4-cachepow) << 4;
		pfile->cache_get_page = ssp_get_page;
	}
	else {
		pfile->cache_get_page = none_get_page;
		pfile->spage = (char *)ml_malloc(pgsize);
		pfile->cache = pfile->spage;
		pfile->cmax = 1;
		return;
	}
	pfile->centries = (cache_entry *)ml_calloc(pfile->cmax,sizeof(cache_entry));
	cachepow = ((u_int32_t)(pfile->cmax)) << ((pgfile_st *)pfile)->pgpow;
	ext = pfile->cache = (char *)ml_malloc(cachepow);
	for (pent=pfile->centries, i=0; i < pfile->cmax; i++, pent++) {
		pent->page = ext;
		ext += pgsize;
		pent->pos = 0xFFFFFFFF;
		pent->hits = pent->rec_count = 0;
	}
	pfile->cused = 0;
}

#if defined(BRDR32) && defined(MULTI_INDEX_STREAM_FILE)
	extern int _IsNotSplit(void *);
#endif
#ifdef INSTLL_CIB
	extern void pl_OpenBase(	LPPF_PARAM pKey, LPPF_PARAM pStr,
								char **keyTag, char **strTag, char **ndtTag);
	extern void pl_GetLoginFromBase(char **, char *, int);
#endif

int preInitBase(base_st *pbase, unsigned long mode
#ifndef BRDR32
				, char *path
#endif
				)
{
#if defined(BRDR32) || defined(INSTLL_CIB)
	((pgfile_st *)&pbase->str)->PrmExt.buf= pbase;
	pbase->str.pgfile.PrmExt.cur_Seek= pbase->key.PrmExt.cur_Seek= pbase->ndt.PrmExt.cur_Seek= my_def_io_seek;
	pbase->str.pgfile.PrmExt.cur_Read= pbase->key.PrmExt.cur_Read= pbase->ndt.PrmExt.cur_Read= my_def_io_read;
  #ifdef INSTLL_CIB
	pl_GetLoginFromBase( &((pgfile_st *)&pbase->ndt)->PrmExt.pCrptTag,
							((pgfile_st *)&pbase->ndt)->PrmExt.pHeader,
							1 << ((pgfile_st *)&pbase->ndt)->pgpow);
	pl_OpenBase(&((pgfile_st *)&pbase->key)->PrmExt, &((pgfile_st *)&pbase->str)->PrmExt,
				&((pgfile_st *)&pbase->key)->PrmExt.pCrptTag, &((pgfile_st *)&pbase->str)->PrmExt.pCrptTag,
				&((pgfile_st *)&pbase->ndt)->PrmExt.pCrptTag);
	if(!load_fat(&(pbase->str)))
  #else
	if(!load_fat_Brdr32(&(pbase->str)))
  #endif
#else
	if(!load_fat(&(pbase->str)))
#endif
	{
		if (pbase->ndt.hfile!= -1) close_pgfile(&(pbase->ndt));
		close_pgfile(&(pbase->key));
		close_pgfile((pgfile_st *)(&(pbase->str)));
		return 0;
	}
#if defined(BRDR32) && defined(MULTI_INDEX_STREAM_FILE)
	if(_IsNotSplit(pbase->key.PrmExt.pScreenCntxt))
	{
		free(pbase->str.cache);
		pbase->str.cache= 0;
		free(pbase->str.centries);
		pbase->str.centries= 0;
		free(pbase->str.hits);
		pbase->str.hits= 0;

		free(pbase->pSubToms->pStr->cache);
		pbase->pSubToms->pStr->cache= 0;
		free(pbase->pSubToms->pStr->centries);
		pbase->pSubToms->pStr->centries= 0;
		free(pbase->pSubToms->pStr->hits);
		pbase->pSubToms->pStr->hits= 0;
		free(pbase->pSubToms->pStr->fat);
		pbase->pSubToms->pStr->fat=0;
		free(pbase->pSubToms->pStr->pgfile.name);
		pbase->pSubToms->pStr->pgfile.name=0;
		free(pbase->pSubToms->pStr);
		pbase->pSubToms->pStr=0;
		free(pbase->pSubToms->pKey->name);
		pbase->pSubToms->pKey->name=0;
		free(pbase->pSubToms->pKey);
		pbase->pSubToms->pKey=0;
		free(pbase->pSubToms);
		pbase->pNextSubToms= pbase->pSubToms= 0;
	}else
#endif
		init_streams_cache(&(pbase->str), mode);
	pbase->flags = 1;
	if(!get_info(&(pbase->key), "Ready", &(pbase->ready_flags))) {
#ifndef BRDR32
		gb_set_last_error(0x404, path);
#endif
		if (pbase->ndt.hfile!= -1) close_pgfile(&(pbase->ndt));
		close_pgfile(&(pbase->key));
		close_pgfile((pgfile_st *)(&(pbase->str)));
		return 0;
	}
	return 1;
}

#ifndef BRDR32
	int open_base(const char *path, base_st *pbase, u_int32_t mode)
	{
		char *filename, *ext;
		//int old_mode;
		int tst;

		if(!pbase){
			pbase = (base_st *)ml_malloc(sizeof(base_st));
		}
		//if(mode & OB_RWHACK) old_mode = pf_set_open_mode(ACE_OS_O_RDWR);
		filename = (char *)ml_malloc(1024);
		strcpy(filename, path);
		tst = c_io_open(filename, ACE_OS_O_BINARY | ACE_OS_O_RDONLY); // GARANT_GCC
		if(tst != -1){
			c_io_close(tst);
			ext= strrchr(filename, '.');
			if(ext != NULL)
				((char*)path)[(int)ext-(int)filename]=  *ext= '\0';
		}
		ext = strchr(filename, '\0');
		if (!(mode & OB_NONDT)) {
			strcpy(ext, ".ndt");
			if(!open_pgfile(filename, &(pbase->ndt))){
				if(pbase->ndt.attr_area != NULL)
					free(pbase->ndt.attr_area);
				free(filename);
				return 0;
			}
		}
		else pbase->ndt.hfile = -1;
		strcpy(ext, ".key");
		if(!open_pgfile(filename, &(pbase->key))) {
			if (pbase->ndt.hfile!= -1) close_pgfile(&(pbase->ndt));
			free(filename);
			if(pbase->ndt.attr_area != NULL)
				free(pbase->ndt.attr_area);
			free(filename);
			return 0;
		}
		strcpy(ext, ".str");
		if(!open_pgfile(filename, (pgfile_st *)(&(pbase->str)))) {
			if (pbase->ndt.hfile!= -1) close_pgfile(&(pbase->ndt));
			close_pgfile(&(pbase->key));
			free(filename);
			return 0;
		}
		if(!preInitBase(pbase, mode
#ifndef BRDR32
			, (char*)path
#endif
			)){
			free(filename);
			return 0;
		}
		//if (mode & OB_RWHACK) pf_set_open_mode(old_mode);
#ifdef MULTI_INDEX_STREAM_FILE
		pbase->openMode= mode;
#endif
		free(filename);
		return 1;
	}
#endif

void unlink_base(const char *path)
{
	char *filename, *ext;
	filename = (char *)ml_malloc(1024);
	strcpy(filename, path);
	ext = strchr(filename, '\0');
	strcpy(ext, ".ndt");
	ace_os_unlink(filename);
	strcpy(ext, ".str");
	ace_os_unlink(filename);
	strcpy(ext, ".key");
	ace_os_unlink(filename);
	free(filename);
}

#ifdef INSTLL_CIB
	#include "../../GPersn/src/PL_Proto.h"
	extern long lDefNdtCryptoTag;
#endif
int create_base(const char *path, base_st *pbase)
{
	char *filename, *ext;
	fat_rec_type fp;
	cache_entry *pent;
	int i;
	u_int16_t pagesize;

	filename = (char *)ml_malloc(1024);
	strcpy(filename, path);
	ext = strchr(filename, '\0');
	strcpy(ext, ".ndt");
	if(!create_pgfile(filename, &(pbase->ndt), 512)
#ifdef INSTLL_CIB
		|| pl_InitCrypto(0)
#endif
		) return 0;
	strcpy(ext, ".key");
	if(!create_pgfile(filename, &(pbase->key), 2048)) {
		close_pgfile(&(pbase->ndt));
		free(filename);
		return 0;
	}
	strcpy(ext, ".str");
	if(!create_pgfile(filename, (pgfile_st *)(&(pbase->str)), 4096)) {
		close_pgfile(&(pbase->ndt));
		close_pgfile(&(pbase->key));
		free(filename);
		return 0;
	}
	else pbase->runs = -1;
	pbase->str.fat_size = 1; //(u_int16_t)((src_flen + (src_flen>>3)) >> FAT_PAGE_EP);
	/* Note : this was FAT-16, currently abandoned
		 fp = (FAT_PAGE_EP == 11) ? 15 : 80;
	*/
	fp = 80;
	fp <<= 12;
	pbase->str.fat = (fat_rec_type *)ml_malloc((u_int32_t)(fp));
	pbase->str.fat_alloc = 80;
	bzero((caddr_t)(pbase->str.fat), fp);
	pbase->str.lfp = 1;
	pbase->str.hfp = 0;
	pbase->str.fat_chain = (u_int32_t *)ml_malloc(0x20000);
	bzero((caddr_t)pbase->str.fat_chain, 0x20000);
	pbase->str.fat_chain[0] = 1;
	pagesize = pbase->str.pgfile.pfhdr->page_size;
	alloc_page((pgfile_st *)(&(pbase->str)));
	pbase->str.cused = 0;
	pbase->str.cmax = 64;
	pent = pbase->str.centries = (cache_entry *)ml_calloc(64, sizeof(cache_entry));
	ext = pbase->str.cache = (char *)ml_malloc(((u_int32_t)(pagesize)) << 6);
	for(i=0; i<64; i++, pent++, ext+=pagesize)
		pent->page = ext;
	pbase->flags = 0;
#ifdef INSTLL_CIB
	((pgfile_st *)&pbase->key)->PrmExt.pCrptTag= (char*)malloc(MAX_CRYPTED_BLOCK+SIZE_CRYPTO_HEADER+sizeof(long));
	((pgfile_st *)&pbase->str.pgfile)->PrmExt.pCrptTag= (char*)malloc(MAX_CRYPTED_BLOCK+SIZE_CRYPTO_HEADER+sizeof(long));
	((pgfile_st *)&pbase->ndt)->PrmExt.pCrptTag= (char*)&lDefNdtCryptoTag;
	*(long*)((pgfile_st *)&pbase->key)->PrmExt.pCrptTag=
		MAX_CRYPTED_BLOCK + (long)pbase->key.pfhdr->page_size;
	*(long*)((pgfile_st *)&pbase->str)->PrmExt.pCrptTag=
		MAX_CRYPTED_BLOCK + (long)pbase->str.pgfile.pfhdr->page_size;
#endif
	free(filename);
	return 1;
}

void set_base_state(base_st *pbase, u_int32_t ready_state)
{
	if(pbase->flags & 1) return;
	pbase->ready_flags = ready_state;
	pbase->flags |= BF_READY;
}

void flush_streams_file(base_st *pbase, streamfile_st *psf)
{
	u_int16_t i;
	u_int32_t putFATpage= 1;
	if(psf->fat_chain != (u_int32_t*)-1){
		if(psf->cused) {
			flush_write_cache(psf);
		}
		psf->fat[psf->lfp] = CHAIN_FLAG;
	#ifndef BRDR32
		for (i=0; i<psf->fat_size; i++) {
			write_page((pgfile_st *)psf, putFATpage, psf->fat + (i << FAT_PAGE_EP));
			putFATpage= psf->fat[putFATpage] & ~CHAIN_FLAG;
		}
	#endif
		set_info((pgfile_st *)psf, "FatSize", &(psf->fat_size), 2);
		if(i = (pbase->flags & BF_OPTIMAL) ? 1 : 0) 
			set_info((pgfile_st *)psf, "Optimized", &i, 2);
		free(psf->fat_chain);
		if(psf->cmax) {
			if(psf->centries)
				free(psf->centries);
			free(psf->cache);
		}
		close_pgfile((pgfile_st *)psf);
		psf->fat_chain= (u_int32_t*)-1;
#ifndef BRDR32
		if(psf->fat)
			free(psf->fat);
#endif
	}
}

#ifdef INSTLL_CIB
extern int pl_ModifyBaseEx(int iKey, int iStr, int iNdt,
							char **ppBuff, char **ppBuff0, char *pKeyUP, int CryptoCount);
#endif
void close_base(base_st *pbase)
{
	streamfile_st *psf;
	pgfile_st		*pkeys;
#if defined(MULTI_INDEX_STREAM_FILE) && !defined(BRDR32)
	char *pOtherName= NULL;
#endif
	
	if(pbase->flags & 1) {
		if(pbase->str.cache) free(pbase->str.cache);
		if (pbase->str.centries) free(pbase->str.centries);
		if (pbase->str.fat) free(pbase->str.fat);
		close_pgfile((pgfile_st *)(&(pbase->str)));
		close_pgfile(&(pbase->key));
		close_pgfile(&(pbase->ndt));
	}
	else {
		psf = &(pbase->str);
		pkeys= &(pbase->key);
#ifdef MULTI_INDEX_STREAM_FILE
	#ifndef BRDR32
		pbase->openMode= pbase->iNContxt= 0;
		pbase->pNextSubToms= pbase->pSubToms;
	#endif
	  do{
#endif
		if(psf->fat_chain){
			flush_streams_file(pbase,psf);
		}else{
			close_pgfile((pgfile_st *)psf);
#ifndef BRDR32
			if(psf->fat)
				free(psf->fat);
#endif
		}
		if(pbase->flags & BF_READY)
			set_info(pkeys, "Ready", &(pbase->ready_flags), 4);
		close_pgfile(pkeys);
 #ifndef BRDR32
		pbase->openMode += pkeys->AddedPage * 2;
		pbase->iNContxt += ((pgfile_st *)psf)->AddedPage * 4;
		if(pOtherName)
			free(pOtherName);
 #endif
	  }while(	pbase->pNextSubToms &&
				(psf= pbase->pNextSubToms->pStr) &&
				(pkeys= pbase->pNextSubToms->pKey) &&
#ifndef BRDR32
				(pOtherName= pbase->pNextSubToms->pName) &&
#endif
				pbase->pNextSubToms++);
#ifndef BRDR32
	  if(pbase->pSubToms){
		  free(pbase->pSubToms);
		  pbase->pNextSubToms= pbase->pSubToms= NULL;
	  }
#else
	  pbase->pNextSubToms= pbase->pSubToms;
#endif
		close_pgfile(&(pbase->ndt));
	}
#ifdef INSTLL_CIB
	if(pbase->key.mode & ~0x2000){
		pbase->key.PrmExt.pCrptTag += sizeof(long);
		pbase->str.pgfile.PrmExt.pCrptTag += sizeof(long);
		if(!pl_ModifyBaseEx(	*pbase->key.postFileHandles,
								*pbase->str.pgfile.postFileHandles,
								*pbase->ndt.postFileHandles,
								&pbase->key.PrmExt.pCrptTag,
								&pbase->str.pgfile.PrmExt.pCrptTag,
								(char*)pbase->ndt.pfhdr, MAX_CRYPTED_BLOCK))
		{
		}
#ifdef BRDR32
		free((pbase->key.PrmExt.pCrptTag - sizeof(long)));
		free((pbase->str.pgfile.PrmExt.pCrptTag - sizeof(long)));
#endif
	}
	free(pbase->ndt.pfhdr);
	c_io_close(*pbase->key.postFileHandles);
	c_io_close(*pbase->str.pgfile.postFileHandles);
	c_io_close(*pbase->ndt.postFileHandles);
#endif
}

Form_Node *FormsInSortedArray(stream_st *psstr, iter_st *spit, int *pRetSize)
{
	Form_Node *pPut;
	if(!(psstr->pAForms= (Form_Node*)calloc((*pRetSize= spit->key_count),sizeof(Form_Node))))
		exit(-29);
	pPut= psstr->pAForms;
	while(spit->pkey){
		memcpy(&pPut->val, spit->pkey, 32);
		if(next_key(spit))
			pPut++;
	}
	release_iter(spit);
	return psstr->pAForms;
}


