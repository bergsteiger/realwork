#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h> 

//#include <sys/stat.h> // GARANT_NOTUSED

#include "gdbapi.h"

/* GARANT_NOTUSED
#ifdef BRDR32
	#include <windows.h>
	extern int _IsNT(void *pCurrent);
#endif
*/

void my_seek_end(pgfile_st *pf, u_int32_t page)
{
	if(pf->AddedPage < page + 1)
		pf->AddedPage = page + 1;
}


u_int16_t get_info(pgfile_st *pf, const char *name, void *buf)
{
	char *in;
	u_int16_t len;

	in = pf->attr_area;
	while (*in && strcmp(name, in+1)) in += *in;
	if(!(*in)) return 0;
	len = (u_int16_t)(strlen(in+1) + 2);
	if(buf && (*in)-len)
		memcpy(buf, in+len, (u_int16_t)(*in) - len);
	return (u_int16_t)(*in);
}

void set_info(pgfile_st *pf, const char *name, void *buf, u_int16_t size)
{
	u_int16_t exlen, len;
	char *in, *tail;

	len=0;
	in = pf->attr_area;
	exlen = get_info(pf, name, NULL);
	if(exlen) {
		while (*in && strcmp(name, in+1)) in += *in;
		exlen -= strlen(name)+2;
		if(exlen != size) { // change size
			tail = in + *in;
			for(in=tail; *in; in+=*in)
				len += *in;
			memmove(tail+((int)size-(int)exlen), tail, len);
		}
	}
	else {
		while(*in) in += *in;
	}
	*in = (unsigned char)(size+strlen(name)+2);
	strcpy(in+1, name);
	in = strchr(in+1, '\0')+1;
	if(size && buf) memcpy(in, buf, size);
}

int read_page(pgfile_st *pf, u_int32_t page, void *buf)
{
#ifdef BRDR32
	#ifndef _DEBUG
		//if(_IsNT(&pf->PrmExt.pScreenCntxt)) ace_os_sleep(2);
	#endif
#endif
	pf->PrmExt.processMode= ACE_OS_O_RDONLY;
	pf->PrmExt.buf= buf;
	pf->PrmExt.page= page;
	if(otherReadOrWrite(&pf->PrmExt) == -1){
		gb_set_last_error(0x411, pf->name);
		return 0;
	}
	my_seek_end(pf, page);
	return pf->pfhdr->page_size;
}

int read_pages(pgfile_st *pf, u_int32_t page, u_int32_t range, void *buf)
{
	u_int32_t pos
#ifndef BRDR32
		, StepByStep= range
#endif
		;
#ifdef BRDR32
	#ifndef _DEBUG
		//if(_IsNT(&pf->PrmExt.pScreenCntxt)) ace_os_sleep(2);
	#endif
#endif

#ifndef BRDR32
	do{
		if(StepByStep <= PF_OPTIMIZE_PAGES_COUNT || pf->PrmExt.accesMode & 0x2000
#ifdef INSTLL_CIB
			|| ((page << pf->pgpow) < *(u_int32_t*)pf->PrmExt.pCrptTag)
#endif
			){
#endif
			for(pos=0; pos < range; pos++, buf= (char*)buf + pf->pfhdr->page_size){
				if(read_page(pf, page+pos, buf) != pf->pfhdr->page_size)
					return 0;                 
			}
#ifndef BRDR32
			break;
		}else{
			int firstTomIndex, readCount;
			pf->PrmExt.processMode= ACE_OS_O_RDONLY;
			pf->PrmExt.page= page;
			pf->PrmExt.buf= buf;
			firstTomIndex= IsNextTom(&pf->PrmExt);
			pos= pf->PrmExt.page;
			pf->PrmExt.page= page+range;
			if(IsNextTom(&pf->PrmExt) == firstTomIndex){
				if(otherFileOpen(firstTomIndex, &pf->PrmExt))
					return -1;
				if(pf->postFilePoss[firstTomIndex] != pos
					&& c_io_lseek ( pf->postFileHandles[firstTomIndex],
								(StepByStep= pos << pf->pgpow), ACE_OS_SEEK_SET )
									!= (long)StepByStep){
					gb_set_last_error(0x411, pf->name);
					return 0;
				}
				readCount= (int)(range << pf->pgpow);

				if(c_io_read( pf->postFileHandles[firstTomIndex], buf, readCount ) != readCount){
					gb_set_last_error(0x411, pf->name);
					return 0;
				}
				pf->postFilePoss[firstTomIndex] = (long)pos+range;
				return readCount;
			}else
				StepByStep= PF_OPTIMIZE_PAGES_COUNT;
		}
	}while(1);
#endif
	return range << pf->pgpow;
}

int write_page(pgfile_st *pf, u_int32_t page, void *buf)
{
	pf->PrmExt.processMode= ACE_OS_O_WRONLY;
	pf->PrmExt.buf= buf;
	pf->PrmExt.page= page;
	if(otherReadOrWrite(&pf->PrmExt) == -1){
		gb_set_last_error(0x412, pf->name);
		return 0;
	}
	my_seek_end(pf, page);
	return pf->pfhdr->page_size;
}

int write_pages(pgfile_st *pf, u_int32_t page, u_int32_t range, void *buf)
{
	u_int32_t pos, StepByStep= range
		;
	do{
		if(
#if defined(BRDR32) || defined(INSTLL_CIB)
			((page << pf->pgpow) < *(u_int32_t*)pf->PrmExt.pCrptTag) ||
#endif
			StepByStep <= PF_OPTIMIZE_PAGES_COUNT){
			for(pos=0; pos < range; pos++, buf= (char*)buf + pf->pfhdr->page_size){
				if(write_page(pf, page+pos, buf) != pf->pfhdr->page_size){
					gb_set_last_error(0x412, pf->name);
					return 0;                 
				}
			}
			break;
		}else{
			int firstTomIndex, readCount;
			pf->PrmExt.processMode= ACE_OS_O_WRONLY;
			pf->PrmExt.page= page;
			pf->PrmExt.buf= buf;
			firstTomIndex= IsNextTom(&pf->PrmExt);
			pos= pf->PrmExt.page;
			pf->PrmExt.page= page+range;
			if(IsNextTom(&pf->PrmExt) == firstTomIndex){
				if(otherFileOpen(firstTomIndex, &pf->PrmExt))
					return -1;
				if(pf->postFilePoss[firstTomIndex] != pos
					&& c_io_lseek ( pf->postFileHandles[firstTomIndex],
								(StepByStep= pos << pf->pgpow), ACE_OS_SEEK_SET )
									!= (long)StepByStep){
					gb_set_last_error(0x411, pf->name);
					return 0;
				}
				readCount= (int)(range << pf->pgpow);

				if(c_io_write( pf->postFileHandles[firstTomIndex], buf, readCount ) != readCount){
					gb_set_last_error(0x411, pf->name);
					return 0;
				}
				pf->postFilePoss[firstTomIndex] = (long)pos + range;
				pos= page+ range;
				if(pf->AddedPage < pos)
					pf->AddedPage = pos;
				return readCount;
			}else
				StepByStep= PF_OPTIMIZE_PAGES_COUNT;
		}
	}while(1);
	return range << pf->pgpow;
}

u_int32_t alloc_page(pgfile_st *pf)
{
	pf->AddedPage++;
	return pf->AddedPage-1;
}

u_int32_t alloc_pages(pgfile_st *pf, u_int32_t range)
{
	pf->AddedPage += range;
	return pf->AddedPage-1;
}

static u_int32_t gdb_signature=BASE_DATA_VERSION;

#if !defined(BRDR32) || defined(MULTI_INDEX_STREAM_FILE)
	int open_pgfile(const char *name, pgfile_st *pf)
	{
		pfhdr_st hdr;
		u_int32_t pos, pgcount;
		char TempName[4096];

		pf->name = strdup(name);
		pf->hfile = c_io_open(name, ACE_OS_O_BINARY | ACE_OS_O_RDONLY); // GARANT_GCC
		if(pf->hfile == -1) {
			gb_set_last_error(0x401, pf->name);
			return 0;
		}
		if(sizeof(pfhdr_st) != c_io_read(pf->hfile, &hdr, sizeof(pfhdr_st))) {
			gb_set_last_error(0x402, pf->name);
			return 0;
		}
		if(hdr.signature != gdb_signature
#if defined(BRDR32) && defined(MULTI_INDEX_STREAM_FILE)
			&&
		   hdr.signature != BASE_DATA_VERSION_OUT
#endif
			) {
			gb_set_last_error(0x403, pf->name);
			return 0;
		}
		pf->attr_area = (char *)ml_malloc(hdr.page_size);
		pf->pfhdr = (pfhdr_st *)(pf->attr_area);
		c_io_lseek(pf->hfile, 0, ACE_OS_SEEK_SET);
		c_io_read(pf->hfile, pf->attr_area, hdr.page_size);
		pf->attr_area += hdr.attr_offs;
		//pf->PrmExt.szRead= hdr.page_size;
		hdr.page_size>>=1;
		pgcount = hdr.last_page+1;
		for(pf->pgpow=0; hdr.page_size; pf->pgpow++, hdr.page_size>>=1);
		pf->mode = 0;
		hdr.page_size = pf->pfhdr->page_size;
		if (
#ifdef INSTLL_CIB
				512 != hdr.page_size &&
#endif
				((get_info(pf, ID_PACKED, NULL) && (pf->mode= pf->mode | 0x2000))
					||
				(get_info(pf, ID_PACKED_NEW, NULL) && (pf->mode= pf->mode | 0x1000 | 0x2000)))
			) {
			if(pf->mode & 0x1000)
				pgcount *= 5;
			else
				pgcount *= sizeof(u_int32_t);
			pf->packtbl = (u_int32_t *)ml_malloc(pgcount
				+pf->pfhdr->page_size
				+pf->pfhdr->page_size * MAX_COUNT_FILE_HANDLES);
			pf->PrmExt.pUncompressBuffer= (char*)pf->packtbl + pgcount;
			pos = c_io_lseek(pf->hfile, 0, ACE_OS_SEEK_END) - pgcount;
			c_io_lseek(pf->hfile, pos, ACE_OS_SEEK_SET);
			c_io_read(pf->hfile, pf->packtbl, pgcount);
			pf->PrmExt.pPackTable= (long*)pf->packtbl;
			pf->PrmExt.PackArraySize= pgcount;
			pgcount /= sizeof(u_int32_t);
			c_io_lseek(pf->hfile, pf->pfhdr->page_size, ACE_OS_SEEK_SET);
			c_io_read(pf->hfile, pf->PrmExt.pUncompressBuffer+pf->pfhdr->page_size, pf->pfhdr->page_size);
			*pf->postFilePoss= 2;
		}
		else{
			pf->packtbl = NULL;
			*pf->postFilePoss= 1;
			pf->PrmExt.PackArraySize= 0l;
		}

		pf->AddedPage= pf->pfhdr->last_page + 1;

		memset(pf->postFileHandles+1, -1, MAX_COUNT_FILE_HANDLES * sizeof(int));
		memset(pf->postFilePoss+1, 0, MAX_COUNT_FILE_HANDLES * sizeof(u_int32_t));

		if(pf->pfhdr->TomPerPages != 0l){
			if(pf->pfhdr->TomPerPages >= MAX_COUNT_FILE_HANDLES)
				pf->PrmExt.maxFile_per_bytes= pf->pfhdr->TomPerPages * pf->pfhdr->page_size;
			else
				pf->PrmExt.maxFile_per_bytes= MAX_BYTE_FILE_SIZE;
		}else
			pf->PrmExt.maxFile_per_bytes= MAX_BYTE_FILE_SIZE;

		pf->PrmExt.FileName= pf->name;
		pf->PrmExt.accesMode= pf->mode | ACE_OS_O_RDONLY;
		pf->PrmExt.pFileHandles= pf->postFileHandles;
		pf->PrmExt.pFilePoss= (long*)pf->postFilePoss;
		pf->PrmExt.pHeader= pf->pfhdr;
		pf->PrmExt.iPost= 1;

		*pf->PrmExt.pFileHandles= pf->hfile;

		pf->PrmExt.MessageForNextFunc= DefaultMessageForNextFunc;
		pf->PrmExt.CloseProcessFunc= DefaultCloseProcessFunc;

		if(pf->pfhdr->TomPerPages == 0 || pf->pfhdr->TomPerPages >= MAX_COUNT_FILE_HANDLES){
			int repeat;
			char pBuff[4096];
			pf->PrmExt.buf= pBuff;
			if(pf->PrmExt.accesMode & 0x1000)
				pf->PrmExt.page=
	(long)((((((u_int64_t)0xffffffff) << 8)|(u_int64_t)0xff) & *(u_int64_t*)(5 * (pf->pfhdr->last_page-1) + (char*)pf->PrmExt.pPackTable))
			/ (u_int64_t)((struct PagedFileHeader *)pf->PrmExt.pHeader)->PageSize);
			else if(pf->PrmExt.accesMode & 0x2000)
				pf->PrmExt.page= pf->PrmExt.pPackTable[pf->pfhdr->last_page - 1]
										/ pf->pfhdr->page_size;
			else
				pf->PrmExt.page= pf->pfhdr->last_page;

			repeat= IsNextTom(&pf->PrmExt);

			pf->PrmExt.buf= TempName;

			while(repeat){
				int len;
				  if(	(len=strlen(pf->PrmExt.FileName)+1) < 2 ||
					GetBasedExtFileName((char*)memcpy(pf->PrmExt.buf,pf->PrmExt.FileName,len), repeat) == 0)
				  {
					close_pgfile(pf);
					gb_set_last_error(0x401, pf->name);
				  }
				  pf->postFileHandles[repeat]= c_io_open((char*)(pf->PrmExt.buf), ACE_OS_O_BINARY | ACE_OS_O_RDONLY);
				  if(pf->postFileHandles[repeat] == -1){
					  close_pgfile(pf);
					  gb_set_last_error(0x401, pf->name);
				  }
				repeat--;
			}
		}
	#if defined(__Solaris__) || defined(__GO32__)
		if(pf->pfhdr->TomPerPages == 1l && otherFileOpen(1, &pf->PrmExt)){
			close_pgfile(pf);
			gb_set_last_error(0x401, pf->name);
			return 0;
		}
	#endif
		//pf->PrmExt.pCrptTag= NULL;
		return pf->hfile;
	}
#endif

int close_pgfile(pgfile_st *pf)
{
	int			*pFiles= pf->postFileHandles;

	if(pf->mode & ~0x2000) {
		if (pf->mode & 0x2000){
			set_info(pf, "*PACKED*", NULL, 0);
		}
		pf->pfhdr->last_page = pf->AddedPage - 1;
#ifdef BRDR32
		*pf->postFilePoss= 1;
#else
		c_io_lseek(pf->hfile, 0, ACE_OS_SEEK_SET);
  #ifdef INSTLL_CIB
	if(pf->pfhdr->page_size == 512)
		c_io_write(pf->hfile, pf->pfhdr, pf->pfhdr->attr_offs);
	else
 #endif
		c_io_write(pf->hfile, pf->pfhdr, pf->pfhdr->page_size);
#endif
	}
#ifndef BRDR32
	while(*pFiles != -1){
  #ifdef INSTLL_CIB
		if(	pFiles != pf->postFileHandles ||
			*(long*)pf->PrmExt.pCrptTag < (long)pf->pfhdr->page_size )
  #endif
		c_io_close(*pFiles);
		pFiles++;
	}
#ifdef INSTLL_CIB
	if(pf->pfhdr->page_size != 512)
#endif
	{
		free(pf->pfhdr);
		free(pf->name);
		pf->pfhdr= NULL;
		if ((pf->mode & 0x2000) && pf->packtbl != NULL)
			free(pf->packtbl);
		pf->packtbl= NULL;
	}
#endif
	return 1;
}

static char *gdb_copyright = "Garant Database file. Copyright (C) 1990,99 Garant-Service";

static void create_pgfile_header(char *header, u_int16_t page_size)
{
	pfhdr_st *phdr;

	phdr = (pfhdr_st *)header;
	phdr->page_size = page_size;
	phdr->signature = gdb_signature;
	strcpy(phdr->copyright, gdb_copyright);
	phdr->attr_offs = sizeof(pfhdr_st);
	phdr->free_page = 0xFFFFFFFF;
	phdr->last_free_page = 0xFFFFFFFF;
}

#if defined(BRDR) || defined(BRDR32)
	#include "../../GPersn/src/pl_defs.h" // GARANT_GCC slashes
#endif

#ifdef BRDR32
	extern void add_crypto_tag(char **, int);
#endif

int create_pgfile(const char *name, pgfile_st *pf, u_int16_t pgsize)
{
	size_t size;

	pf->name = strdup(name);
	pf->hfile = c_io_open(name, 
#if defined(BRDR32) || defined(_DEBUG)
		ACE_OS_O_RDWR |
#else
		ACE_OS_O_WRONLY |
#endif
		ACE_OS_O_TRUNC | ACE_OS_O_CREAT |
		ACE_OS_O_BINARY); // GARANT_GCC
	if(pf->hfile == -1) {
		gb_set_last_error(0x403, pf->name);
		return 0;
	}
	//pf->PrmExt.szRead= (int)pgsize;

	size = (size_t)pgsize;
	pgsize >>= 1;
	for(pf->pgpow=0; pgsize; pf->pgpow++, pgsize >>= 1);
	pgsize = 1<<pf->pgpow;
	pf->pfhdr = (pfhdr_st *)ml_malloc(size);
	bzero((caddr_t)(pf->pfhdr), size);
	create_pgfile_header((char *)(pf->pfhdr), pgsize);
	pf->attr_area = (char *)(pf->pfhdr) + pf->pfhdr->attr_offs;
	pf->mode = ACE_OS_O_WRONLY;
	//ace_os_ftruncate(pf->hfile, pgsize);

	///////////////////////////////////////////////////////////////////////////////
	pf->AddedPage= 1;
	pf->pfhdr->TomPerPages= 0l;

	memset(pf->postFileHandles+1, -1, MAX_COUNT_FILE_HANDLES * sizeof(int));
	memset(pf->postFilePoss+1, 0, MAX_COUNT_FILE_HANDLES * sizeof(u_int32_t));

	pf->PrmExt.maxFile_per_bytes= MAX_BYTE_FILE_SIZE;
	pf->PrmExt.FileName= pf->name;
	pf->PrmExt.accesMode= ACE_OS_O_CREAT
#if defined(BRDR32)
		| ACE_OS_O_RDWR 
#else
		| pf->mode | ACE_OS_O_TRUNC
#endif
		;
	pf->PrmExt.pFileHandles= pf->postFileHandles;
	pf->PrmExt.pFilePoss= (long*)pf->postFilePoss;
	pf->PrmExt.pHeader= pf->pfhdr;

	*pf->PrmExt.pFilePoss= 0;
	*pf->PrmExt.pFileHandles= pf->hfile;
	pf->PrmExt.PackArraySize= 0;

	pf->PrmExt.MessageForNextFunc= DefaultMessageForNextFunc;
	pf->PrmExt.CloseProcessFunc= DefaultCloseProcessFunc;
	pf->PrmExt.iPost= 1;

	pf->PrmExt.cur_Seek= my_def_io_seek;
	pf->PrmExt.cur_Read= my_def_io_read;

#if defined(BRDR) || defined(BRDR32)
	add_crypto_tag(&pf->PrmExt.pCrptTag, size);
#endif
	return pf->hfile;
}

void pgfile_close_current_tom(pgfile_st *pf)
{
	if(pf->pfhdr->TomPerPages < MAX_COUNT_FILE_HANDLES)
		((long*)pf->pfhdr->reserved)[((int)pf->pfhdr->TomPerPages-1)*2+1]
				= pf->AddedPage - 1;
}

int pgfile_make_next_tom(pgfile_st *pf)
{
	if(pf->pfhdr->TomPerPages == 0l && pf->pfhdr->TomPerPages < MAX_COUNT_FILE_HANDLES){
		((long*)pf->pfhdr->reserved)[(int)pf->pfhdr->TomPerPages*2]= -1;
		((long*)pf->pfhdr->reserved)[(int)pf->pfhdr->TomPerPages*2+1]= 0x7fffffff;
		pf->pfhdr->TomPerPages++;
		return 0;
	}
	return -1;
}

u_int32_t pgfile_size(pgfile_st *pf)
{
	return pf->AddedPage;
}

