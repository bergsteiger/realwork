#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include "gdbapi.h"

#define START_SIZE_BUFF_FOR_BLOC_PER_STEP 2048

#define OLD1_STREAM_HANDLE_TO_PAGE(_handle_) ((unsigned int)_handle_ >> 12)
#define OLD1_STREAM_HANDLE_TO_ID(_handle_) ((short)( _handle_ & 0x0FFF ))
#define BIG1_STREAM_HANDLE_TO_PAGE(_handle_) ((unsigned int)_handle_ >> 5)
#define BIG1_STREAM_HANDLE_TO_ID(_handle_,_alloc_) ((short)( ( (_handle_ & 0x1f) << 7) | ( (_alloc_ >> 24) & 0x7f) ))

#define IS1_SHORT_STR(_pref_) (0 != ((_pref_->alloc & 0x80000000) ? BIG1_STREAM_HANDLE_TO_ID(_pref_->data.pos, _pref_->alloc ) : OLD1_STREAM_HANDLE_TO_ID( _pref_->data.pos )))

void streamed_Blocks_Free( stream_st *pstr )
{
	if(pstr->ppBlock != 0){
		int jj;
		for(jj=0; jj < pstr->szBlockPointers; jj++){
			if(pstr->ppBlock[jj] != 0)
				free(pstr->ppBlock[jj]);
		}
		free(pstr->ppBlock);
	}
	pstr->ppBlock= 0;
}
int streamed_Blocks_IsOk(stream_st *pstr, int i)
{
	if(i == pstr->szBlockPointers){
		int jj;
		char **pNew=
			(char **)ml_calloc(sizeof(char*), (i+ALLOC_STEP_FOR_STREAM));

		if(pNew == 0){
			streamed_Blocks_Free( pstr );
			return 0;
		}
		if(pstr->ppBlock != 0){
			for(jj=0; jj < i; jj++){
				pNew[jj] = pstr->ppBlock[jj];
			}
			free(pstr->ppBlock);
		}
		pstr->ppBlock= pNew;
		pstr->szBlockPointers += ALLOC_STEP_FOR_STREAM;
	}
	if(	pstr->ppBlock[i] == 0
		&& (pstr->ppBlock[i]=
			(char *)ml_calloc(ALLOC_STEP_FOR_STREAM,START_SIZE_BUFF_FOR_BLOC_PER_STEP)) == 0){
		streamed_Blocks_Free( pstr );
		return 0;
	}
	return 1;
}

stref_st *get_stref(iter_st *pit, int nstr)
{
	int reflen;
	char *p;

	reflen = sizeof(stref_st) - 4 + pit->strinfo.immds;
	p = pit->pkey + pit->keylen - reflen*pit->nstreams;
	return (stref_st *)(p+nstr*reflen);
}

stref_st *get_stref_ex(char *key, u_int16_t keylen, u_int16_t immds, u_int16_t nstreams, int nstr)
{
	return (stref_st *)(key + keylen - (nstreams - nstr)*(sizeof(stref_st) - 4 + immds));
}

stream_st *load_stream_ex(streamfile_st *psf, stref_st *pref, stream_st *pstr, stream_info *strinfo)
{
	if(!pstr) {
		pstr = (stream_st *)ml_calloc(0, sizeof(stream_st));
		pstr->flags |= SF_DESTROY;
	}
	pstr->ref.size = pref->size;
	pstr->flags &= SF_USELOCAL;
	pstr->pos = 0;
	pstr->info.immds = strinfo->immds;
	pstr->info.rndv = strinfo->rndv;
	if(!pstr->local && (pstr->flags & SF_USELOCAL))
		pstr->local = (char *)ml_malloc((size_t)1 << (size_t)(0x7fff & psf->pgfile.pgpow));
	if(!(pref->size)) {
		pstr->data = pstr->buf;
		bzero(pstr->buf, 16);
		return pstr;
	}
	if(pref->size <= strinfo->immds) { // "Ultra short" data
		pstr->data = pstr->buf;
		memcpy(pstr->data, pref->data.bin, strinfo->immds);
	}
	else if(IS1_SHORT_STR(pref)) {
		pstr->data = (char*)read_short_stream(psf, pref);
		if(pstr->local) {
			memcpy(pstr->local, pstr->data, pref->size);
			pstr->data = pstr->local;
		}
		pstr->ref.alloc = pref->alloc;
	}
	else {
		pstr->data = (char*)read_long_stream(psf, pref);
		pstr->flags |= SF_FREEBUF;
	}
	pstr->rec = pstr->data;
	return pstr;
}

stream_st *load_stream(iter_st *pit, stream_st *pstr)
{
	stref_st *pref;
	
	pref = get_stref(pit, 0);
	return load_stream_ex(pit->str, pref, pstr, &(pit->strinfo));
}

stream_st *load_stream_n(iter_st *pit, stream_st *pstr, int n)
{
	stref_st *pref;
	
	pref = get_stref(pit, n);
	return load_stream_ex(pit->str, pref, pstr, &(pit->strinfo));
}

void release_stream(stream_st *pstr)
{
	if(pstr->flags & SF_FREEBUF) {
		free(pstr->data);
		pstr->flags &= ~SF_FREEBUF;
	}
	if(pstr->local && (pstr->flags & SF_FREELOCAL)) {
		free(pstr->local);
		pstr->local = 0;
	}

	if(pstr->flags & SF_DESTROY) {
		free(pstr);
	}
	else {
		pstr->ref.size = 0;
		pstr->pos = 0;
		pstr->data = 0;
		pstr->rec = 0;
		pstr->flags &= SF_USELOCAL;
	}
}

void *read_short_stream(streamfile_st *pfile, stref_st *pref)
{
	u_int32_t pos;
	char *rec;
	u_int16_t id, *rid;

	if(pref->alloc & 0x80000000){
		id = BIG1_STREAM_HANDLE_TO_ID( pref->data.pos, pref->alloc );
		pos = BIG1_STREAM_HANDLE_TO_PAGE( pref->data.pos );
	}else{
		id = OLD1_STREAM_HANDLE_TO_ID( pref->data.pos );
		pos = OLD1_STREAM_HANDLE_TO_PAGE( pref->data.pos );
	}
	rec = (char *)(*(pfile->cache_get_page))(pfile, pos);
	rid = (u_int16_t *)rec;
	while((0xfff & rid[0]) != id) {
		rec+=rid[1]+4;
		rid = (u_int16_t *)rec;
	}
	return rec+4;
}

void *read_long_stream(streamfile_st *pfile, stref_st *pref)
{
	char *stream, *spage;
	u_int32_t p, pos, size, i, pgcount;
	fat_rec_type page;
	
	pgcount = pref->size >> pfile->pgfile.pgpow;
	if(pref->size & ((1 << pfile->pgfile.pgpow)-1))
		pgcount++;
	if(pref->alloc & 0x80000000)
		page = (fat_rec_type)BIG1_STREAM_HANDLE_TO_PAGE( pref->data.pos );
	else
		page = (fat_rec_type)OLD1_STREAM_HANDLE_TO_PAGE( pref->data.pos );
	i = pgcount;
	spage = stream = pfile->str_header ? pfile->str_header : (char *)ml_malloc(pgcount<<pfile->pgfile.pgpow);
	do {
		size = 1;
		pos = (u_int32_t)page;
		i--;
		p=page;
		while(i && (pfile->fat[p] & ~CHAIN_FLAG) == p+1) {
			size++;
			p = pfile->fat[p] & ~CHAIN_FLAG;
			i--;
		}
		if(size>1)
			read_pages((pgfile_st *)pfile, pos, size, spage);
		else
			read_page((pgfile_st *)pfile, pos, spage);

		//for(p=0; p<size; p++)
		page = pfile->fat[page+size-1] & ~CHAIN_FLAG; 

		spage += size<<pfile->pgfile.pgpow;
	} while(i);
	return stream;
}

void flush_write_cache(streamfile_st *pdest)
{
	u_int16_t i, cpages;
	fat_rec_type *fatrec;
	cache_entry *pent;
	u_int32_t pos, pgsize;
	// static u_int32_t call_count=0;
		
	/*
	if(ml_streams_log) {
		call_count++;
		flog("flush_write_cache (%d):  %d pages", call_count, pdest->cused);
		if(pdest->flags & (SCF_HANGING | SCF_FPHANG)) m_log("  status:");
		if(pdest->flags & SCF_HANGING) m_log("  \"hanging pages\"");
		if(pdest->flags & SCF_FPHANG) m_log("  \"hanging FAT page\"");
		m_log("\n");
	}
	*/
	cpages = pdest->cused;
	if(!cpages)
		return;
	pgsize = 1 << pdest->pgfile.pgpow;
	pent = pdest->centries;
	pos = pent->pos;
	fatrec=pdest->fat+(fat_rec_type)(pos);
	for(i=0; i<cpages; i++, pent++) {
		//*fatrec++ = pgsize - pent->hits;
		memset(pent->page+pent->hits, 0, pgsize - pent->hits);
		pdest->fat[pent->pos] = (fat_rec_type)(pgsize - pent->hits);
		pent->pos = 0;
		pent->rec_count = 0;
		pent->hits = 0;
	}
	if(cpages == 1)
		write_page((pgfile_st *)pdest, pos, pdest->cache);
	else
		write_pages((pgfile_st *)pdest, pos, cpages, pdest->cache);

	pdest->flags &= ~SCF_HANGING;
	if(pdest->flags & SCF_FPHANG) {
		/* Note: not needed to flush FAT pages until closing...
		pos = (u_int32_t)(pdest->fat_size);
		pos -= 2;
		pos <<= FAT_PAGE_EP;
		fatrec = pdest->fat + pos;
		write_page((pgfile_st *)pdest, pdest->hfp, fatrec);
		*/
		pdest->flags &= ~SCF_FPHANG;
	}
	pdest->cused = 0;
}

void alloc_fat_page(streamfile_st *pdest)
{
	u_int32_t pos;
	//char *fat;

	pos = alloc_page((pgfile_st *)pdest);
	pdest->fat[pdest->lfp] = (fat_rec_type)pos | CHAIN_FLAG;
	//fat = ((char *)(pdest->fat));
	//fat += ((u_int32_t)(pdest->fat_size-1))<<pdest->pgfile.pgpow;

	//pdest->fat_chain[pdest->fat_size] = pos;
	pdest->fat_size++;
	if(pdest->fat_size > pdest->fat_alloc) {
		fat_rec_type *newfat;
		pdest->fat_alloc += 40;
		newfat = (fat_rec_type *)realloc(pdest->fat, ((u_int32_t)pdest->fat_alloc) << pdest->pgfile.pgpow);
/*#ifndef _AFXDLL
		if(_gb_log_state_) flog("Info: FAT grow %s\n", newfat ? "successfully" : "Failed!");
#endif*/
		// if (!newfat) ; // Do the error message...
		pdest->fat = newfat;
	}
	pdest->hfp = pdest->lfp;
	pdest->lfp = pos;
	// if(ml_streams_log) flog("alloc_fat_page:  page %d used, page %d hanging\n", pos, pdest->hfp);
}

u_int32_t str_alloc_page(streamfile_st *pdest)
{
	u_int32_t pos;
	cache_entry *pent;
	u_int32_t fl;

	if(pdest->cused == pdest->cmax || pdest->flags & SCF_HANGING) { // Cache full : flush it
		flush_write_cache(pdest);
		pent = pdest->centries;
	}
	else pent = pdest->centries + pdest->cused;
	pos = pent->pos = alloc_page((pgfile_st *)pdest);
	pdest->cused++;
	fl = (1+pos) - (((u_int32_t)(pdest->fat_size-1))<<FAT_PAGE_EP);
	if(fl > (1 << FAT_PAGE_EP)) {
		alloc_fat_page(pdest);
		if(pdest->cused)
			pdest->flags |= SCF_HANGING | SCF_FPHANG;
	}
	return pos;
}

void write_short_stream(streamfile_st *pdest, void *stream, stref_st *pref)
{
	u_int16_t *rec, size, utmp16;
	cache_entry *pent;
	u_int32_t pgsize;
	// static u_int32_t call_count = 0;
	
	// call_count++;
	pgsize = 1 << pdest->pgfile.pgpow;
	if(pdest->cused == 0) { // first write request : cache empty
		pent = pdest->centries;
		str_alloc_page(pdest);
	}
	else pent = pdest->centries + (pdest->cused-1);
	utmp16 = ((u_int16_t)(pref->alloc & 0xffffff));
	size = utmp16 + pent->hits + 4;
	if(size > pgsize) { // Can't be written on current page
		// memset(pent->page+pent->hits, 0, pgsize-pent->hits);
		str_alloc_page(pdest);
		pent = pdest->centries + (pdest->cused-1);
		pent->hits = pent->rec_count = 0;
	}
 	pent->rec_count++;
	rec = (u_int16_t *)(pent->page + pent->hits);
	*rec++ = pent->rec_count;
	*rec++ = utmp16;
	memcpy(rec, stream, utmp16);
	pent->hits += utmp16 + sizeof(*rec) + sizeof(*rec);

	pref->alloc |= 0x80000000;
	pref->data.pos = (pent->pos << 5) | (pent->rec_count >> 7);
	pref->alloc &= ~0x7f000000;
	pref->alloc |= (0x7f & pent->rec_count) << 24;
}

#ifdef MULTI_INDEX_STREAM_FILE
void write_Short_stream(streamfile_st *pdest, void *stream, stref_st *pref)
{
	u_int16_t *rec, size;
	cache_entry *pent;
	u_int32_t pgsize;
	// static u_int32_t call_count = 0;
	
	// call_count++;
	pgsize = 1 << pdest->pgfile.pgpow;
	if(pdest->cused == 0) { // first write request : cache empty
		pent = pdest->centries;
		str_alloc_page(pdest);
	}
	else pent = pdest->centries + (pdest->cused-1);
	size = ((u_int16_t)(pref->alloc));
	size += pent->hits + 4;
	if(size > pgsize) { // Can't be written on current page
		// memset(pent->page+pent->hits, 0, pgsize-pent->hits);
		str_alloc_page(pdest);
		pent = pdest->centries + (pdest->cused-1);
		pent->hits = pent->rec_count = 0;
	}
 	pent->rec_count++;
	rec = (u_int16_t *)(pent->page + pent->hits);
	*rec++ = pent->rec_count;
	*rec++ = (u_int16_t)(pref->alloc);
	memcpy(rec, stream, pref->alloc);
	pent->hits += ((u_int16_t)(pref->alloc)) + 4;
	pref->data.pos = (pent->pos << (pdest->pgfile.pgpow-2)) + pent->rec_count;
}
void write_Long_stream(stream_st *pstr, streamfile_st *pdest, stref_st *pref)
{

	u_int32_t i=0, allpgcount, pgcount, size, fl, pos;

	if(!pdest)
		pdest = pstr->str;

	allpgcount= pref->size >> pdest->pgfile.pgpow;
	if(pref->size & ((1 << pdest->pgfile.pgpow)-1))
		allpgcount++;

	pos = pgfile_size((pgfile_st *)pdest);
	pref->data.pos = pos << (pdest->pgfile.pgpow-2);
	fl = pos - (((u_int32_t)(pdest->fat_size-1))<<FAT_PAGE_EP);
	do{
		pgcount = allpgcount;
		if(fl + allpgcount >= (2<<FAT_PAGE_EP)){
			pgcount = 1<<FAT_PAGE_EP;
			if(fl >= (1<<FAT_PAGE_EP))
				pgcount -= 16;
		}
		if(pdest->cused)
			pdest->flags |= SCF_HANGING;

		if(pstr->flags & SF_WRALLOW) {
			size = pgcount;
			while(size > 16){
				write_pages((pgfile_st *)pdest, pgfile_size((pgfile_st *)pdest),
								16, pstr->ppBlock[i++]);
				size -= 16;
			}
			write_pages((pgfile_st *)pdest, pgfile_size((pgfile_st *)pdest),
							size, pstr->ppBlock[i++]);
		}else{
			write_pages((pgfile_st *)pdest, pos, pgcount, pstr->data + i);
			i += pgcount << pdest->pgfile.pgpow;
		}
		if(fl+pgcount >= (1<<FAT_PAGE_EP)){
			alloc_fat_page(pdest);
			if(pdest->cused)
				pdest->flags |= SCF_FPHANG;
		}
		for(size=0; size<pgcount-1; size++)
			pdest->fat[pos++] = (pos+1) | CHAIN_FLAG;

		if (fl+allpgcount >= (2<<FAT_PAGE_EP))
		{
			// следующ€ страница
			pdest->fat[pos] = (pos+2) | CHAIN_FLAG;
			pos += 2;
			fl++;
		}
		else
			// последн€€ страница
			pdest->fat[pos] = CHAIN_FLAG;

	}while((allpgcount -= pgcount));
}
#endif

void write_long_stream(stream_st *pstr, streamfile_st *pdest, stref_st *pref)
{

	u_int32_t i=0, allpgcount, pgcount, size, fl, pos;

	if(!pdest)
		pdest = pstr->str;

	allpgcount= pref->size >> pdest->pgfile.pgpow;
	if(pref->size & ((1 << pdest->pgfile.pgpow)-1))
		allpgcount++;

	pos = pgfile_size((pgfile_st *)pdest);

	pref->alloc= 0x80000000;
	pref->data.pos = pos << 5;

	fl = pos - (((u_int32_t)(pdest->fat_size-1))<<FAT_PAGE_EP);
	do{
		pgcount = allpgcount;
		if(fl + allpgcount >= (2<<FAT_PAGE_EP)){
			pgcount = 1<<FAT_PAGE_EP;
			if(fl >= (1<<FAT_PAGE_EP))
				pgcount -= 16;
		}
		if(pdest->cused)
			pdest->flags |= SCF_HANGING;

		if(pstr->flags & SF_WRALLOW) {
			size = pgcount;
			while(size > 16){
				write_pages((pgfile_st *)pdest, pgfile_size((pgfile_st *)pdest),
								16, pstr->ppBlock[i++]);
				size -= 16;
			}
			write_pages((pgfile_st *)pdest, pgfile_size((pgfile_st *)pdest),
							size, pstr->ppBlock[i++]);
		}else{
			write_pages((pgfile_st *)pdest, pos, pgcount, pstr->data + i);
			i += pgcount << pdest->pgfile.pgpow;
		}
		if(fl+pgcount >= (1<<FAT_PAGE_EP)){
			alloc_fat_page(pdest);
			if(pdest->cused)
				pdest->flags |= SCF_FPHANG;
		}
		for(size=0; size<pgcount-1; size++)
			pdest->fat[pos++] = (pos+1) | CHAIN_FLAG;

		if (fl+allpgcount >= (2<<FAT_PAGE_EP))
		{
			// следующ€ страница
			pdest->fat[pos] = (pos+2) | CHAIN_FLAG;
			pos += 2;
		}
		else
			// последн€€ страница
			pdest->fat[pos] = CHAIN_FLAG;

	}while((allpgcount -= pgcount)
			&& (fl = pgfile_size((pgfile_st *)pdest) - (((u_int32_t)(pdest->fat_size-1))<<FAT_PAGE_EP))>0);
}

stream_st *create_stream(index_st *pin, stream_st *pstr)
{
	return create_stream_ex(pin->str, pstr, &(pin->hdr.strinfo));
}

stream_st *create_stream_ex(streamfile_st *psf, stream_st *pstr, stream_info *info)
{
	if(!pstr) {
		pstr = (stream_st *)ml_calloc(0, sizeof(stream_st));
		pstr->flags = SF_DESTROY;
	}
	if(!(pstr->flags & SF_NOALLOC) || !(pstr->bcount)) {
		pstr->szBlockPointers= 0;
		if(!streamed_Blocks_IsOk(pstr, 0))
			return 0;
		pstr->bcount = 1;
	}
	pstr->pos = 0;
	pstr->cblock = 0;
	pstr->cboffs = 0;
	pstr->ref.size = 0;
	pstr->data = pstr->rec = pstr->ppBlock[0];
	pstr->str = psf; // pin->str;
	pstr->info.immds = info->immds; // pin->immds;
	pstr->info.rndv = info->rndv;
	pstr->flags &= ~SF_WRLOCK;
	pstr->flags |= SF_WRALLOW;
#ifdef STORE_FORM_N
	pstr->ArrayIOffsCount= 0;
	pstr->pDeletedNorms= 0;
	pstr->iDeletedNorms= 0;
#endif
	return pstr;
}

int write_stream(stream_st *pstr, void *buf, u_int32_t sizeAll)
{
	u_int32_t cb, size= sizeAll;
	char *b, *bf;
	((size_t*)&(pstr->ref.size))[0] += sizeAll;
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N)
  #if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
	if(pstr->temp_flush_handle){
		u_int32_t valw= sizeAll;
		if(valw > 0x10000 || (((pstr+5)->rec + valw) - (pstr+5)->data) > 0x10000){
			c_io_write((int)pstr->temp_flush_handle, (pstr+5)->data, (pstr+5)->rec-(pstr+5)->data);
			while(valw > 0x10000){
				c_io_write((int)pstr->temp_flush_handle, buf, 0x10000);
				buf = (((char*)buf) + 0x10000);
				valw -= 0x10000;
			}
			(pstr+5)->rec= (pstr+5)->data;
		}
		memcpy((pstr+5)->rec, buf, valw); (pstr+5)->rec += valw;
		return sizeAll;
	}
  #endif
#endif
	if(!(pstr->flags & SF_WRALLOW)) return 0;
	if(pstr->flags & SF_WRLOCK) return 0;
	bf = (char *)buf;
	if(size + pstr->cboffs > 0x10000)
	  do{
		b = pstr->ppBlock[pstr->cblock] + pstr->cboffs;
		cb = size + pstr->cboffs - 0x10000;
		size -= 0x10000 - pstr->cboffs;
		memcpy(b, bf, 0x10000 - pstr->cboffs);
		bf += 0x10000 - pstr->cboffs;
		pstr->cblock++;
		if(pstr->cblock == pstr->bcount) {
			if(!streamed_Blocks_IsOk( pstr, pstr->cblock)){
				return 0;
			}
			pstr->bcount++;
		}
		pstr->cboffs = 0;
	  }while(size + pstr->cboffs > 0x10000);
	else
		cb = size;
	b = pstr->ppBlock[pstr->cblock] + pstr->cboffs;
	memcpy(b, bf, cb);
	pstr->cboffs += cb;
	return sizeAll;
}

#ifdef MULTI_INDEX_STREAM_FILE
extern void impModifyName(char *);
streamfile_st *create_stream_subFile(char *path, index_st *pin)
{
	fat_rec_type fp;
	cache_entry *pent;
	char *ext= strrchr(path, '.')+1;
	u_int16_t pagesize= pin->pbase->str.pgfile.pfhdr->page_size;
	int i;

	streamfile_st *pNew= calloc(1, sizeof(streamfile_st));
	strcpy(ext, pin->name);
	ext++;
	impModifyName(path);
	if(!create_pgfile(path, &pNew->pgfile, pagesize )) {
		strcpy(ext, ".str");
		free(pNew);
		return 0;
	}
	if(pin->pbase->str.pgfile.pfhdr->TomPerPages >= MAX_COUNT_FILE_HANDLES){
		pNew->pgfile.pfhdr->TomPerPages=
			pin->pbase->str.pgfile.pfhdr->TomPerPages;
		pNew->pgfile.PrmExt.maxFile_per_bytes
			= pNew->pgfile.pfhdr->TomPerPages * pNew->pgfile.pfhdr->page_size;
	}
	pNew->fat_size = 1; //(u_int16_t)((src_flen + (src_flen>>3)) >> FAT_PAGE_EP);
	/* Note : this was FAT-16, currently abandoned
		 fp = (FAT_PAGE_EP == 11) ? 15 : 80;
	*/
	fp = 80;
	fp <<= 12;
	pNew->fat = (fat_rec_type *)ml_malloc((u_int32_t)(fp));
	pNew->fat_alloc = 80;
	bzero((caddr_t)(pNew->fat), fp);
	pNew->lfp = 1;
	pNew->hfp = 0;
	pNew->fat_chain = (u_int32_t *)ml_malloc(4);//0x20000);
	//bzero((caddr_t)pNew->fat_chain, 0x20000);
	//pNew->fat_chain[0] = 1;
	alloc_page((pgfile_st *)pNew);
	pNew->cused = 0;
	pNew->cmax = 64;
	pent = pNew->centries = (cache_entry *)ml_calloc(64, sizeof(cache_entry));
	strcpy(ext, ".str");
	ext = pNew->cache = (char *)ml_calloc(1,(((u_int32_t)(pagesize)) << 6));
	for(i=0; i<64; i++, pent++, ext+=pagesize)
		pent->page = ext;
	return pNew;
}
#endif

void attach_stream(stream_st *pstr, stref_st *pref)
{
	u_int32_t pgsize;
	u_int16_t miss;

	pgsize = 1 << pstr->str->pgfile.pgpow;
	pref->size = pstr->ref.size;
	if(pstr->ref.size <= pstr->info.immds)
		memcpy(pref->data.bin, pstr->data, pstr->info.immds);
	else if(pstr->ref.size < pgsize-4) {
		pref->alloc = pstr->ref.size;
		if(pstr->info.rndv > 1) {
			miss = (u_int16_t)(pstr->ref.size % pstr->info.rndv);
			if((pstr->ref.size + miss < pgsize) && miss)
				pref->alloc = pstr->ref.size + (pstr->info.rndv - miss);
		}
		write_short_stream(pstr->str, pstr->data, pref);
	}
	else
		write_long_stream(pstr, 0, pref);
	pstr->flags |= SF_WRLOCK;
}

void move_stream(stream_st *pstr, streamfile_st *pdest, stref_st *pref)
{
	u_int32_t pgsize;

	pgsize = 1 << pdest->pgfile.pgpow;
	pref->size = pstr->ref.size;
	if(pstr->ref.size <= pstr->info.immds)
		memcpy(pref->data.bin, pstr->data, pstr->info.immds);
	else if(pstr->ref.size < pgsize-4) {
		if(((pstr->ref.alloc & 0xffffff) < pstr->ref.size) || ((pstr->ref.alloc & 0xffffff) > pgsize-4)){
			pstr->ref.alloc = pstr->ref.size | 0x80000000;
		}
		pref->size = pstr->ref.size;
		pref->alloc = pstr->ref.alloc;
		write_short_stream(pdest, pstr->data, pref);
	}
	else
		write_long_stream(pstr, pdest, pref);
}

void close_stream(stream_st *pstr)
{
	if(!pstr) return;
	if(pstr->flags & SF_NOALLOC) {
		pstr->cblock = 0;
		pstr->cboffs = 0;
		pstr->ref.size = 0;
		pstr->flags &= ~(SF_WRLOCK);
		if(pstr->ppBlock){
			pstr->data
			= pstr->rec
			= pstr->ppBlock[0];
		}
		if(pstr->flags & SF_DESTROY) free(pstr); // Warning: can cause memory leaks!
		return;
	}
	if(pstr->flags & SF_FREEBUF) {
		free(pstr->data);
		pstr->flags &= ~SF_FREEBUF;
	}else{
		streamed_Blocks_Free(pstr);
#ifdef STORE_FORM_N
		if(pstr->pCurrKey)
			free(pstr->pCurrKey);
#endif
	}
	if(pstr->flags & SF_DESTROY) free(pstr);
}

extern void * bsearch_nxt(long key, long **ppBase, int *pNum);

#include "sets.h"

long lGetFIndxNC(long **ppNxt)
{
	(*ppNxt)++;
	return (long)((*(unsigned long*)((*ppNxt)-1)) >> 24);
}

long lGetFIndxWC(long **ppNxt)
{
	(*ppNxt)= (long*)((char*)(*ppNxt)+ 3);
	return (long)((*(unsigned long*)((*ppNxt)-1)) >> 24);
}

long lGetFIndxBC(long **ppNxt)
{
	return (long)(*(unsigned char*)(*ppNxt));
}

int CalcNodeSizeNC(char *pNext, int added, long *pDoc, int *fOffs, long *pcount, int *prepeat)
{
	*pDoc= *(long*)pNext;
	*pcount= ((long*)pNext)[1];
	//*prepeat= 0;
	//*fOffs= sizeof(long)+sizeof(long);
	return (*(long*)(pNext+4))*(sizeof(long)+added) +sizeof(long)+4;
}

int CalcNodeSizeWC(char *pNext, int added, long *pDoc, int *fOffs, long *pcount, int *prepeat)
{
	long count= 1;
	const char *d= pNext;
	char *pOutInxs= (char*)prepeat;
	*fOffs= sizeof(long);
	*pDoc= 0x7fffffff & *(long*)pNext;
	*pcount= 0;
	d += sizeof(long);
	while(count--){
		(*pcount)++;
		if(!(*(long*)d & 0x4000))
			count++;
		if(added){
			if(*(long*)d & 0x8000)
				d += 4;
			else
				d += 3;
			*(pOutInxs++)= *(d-1);
		}else{
			if(*(long*)d & 0x8000)
				d += 3;
			else
				d += 2;
		}
	}
	return (int)(0x7fffffff & (d - pNext));
}

int CalcNodeSizeBC(char *pNext, int added, long *pDoc, int *fOffs, long *pcount, int *prepeat)
{
	int nodes_size= sizeof(long) + sizeof(long), countFromChar= 0;
	*pDoc= 0x7fffffff & *(long*)pNext;

	if(0x80000000 & ((long*)pNext)[1]){
		if(0x40000000 & ((long*)pNext)[1]){
			*pcount= 1;
			if(added){
				*fOffs= nodes_size-1;
				nodes_size += sizeof(char);
			}
		}else
			countFromChar++;
	}else{
		*prepeat= *(long*)(pNext+ nodes_size) - 1;
		nodes_size += sizeof(long);
		if(0x40000000 & ((long*)pNext)[1]){
			*pcount= 1;
			if(added){
				*fOffs= nodes_size-1;
				nodes_size += sizeof(char);
			}
		}else
			countFromChar++;
	}
	if(countFromChar){
		*fOffs= nodes_size;
		*pcount= (long)*(pNext+nodes_size);
		if(added == 2)
			nodes_size += sizeof(long);
		else
			nodes_size += sizeof(char) + sizeof(char) * (*pcount);
	}
	return nodes_size;
}

#ifndef	GARANT_TOOLS

int IsMultiFormsNC(char *pDoc)
{
#ifdef STORE_FORM_N
	if(!(0x4000 & ((long*)(pDoc + sizeof(long)))[2]))
		return 1;
#endif
	return 0;
}

int IsMultiFormsBC(char *pDoc)
{
#ifdef STORE_FORM_N
	if((0x80000000 & (*(long*)pDoc)))
		return 1;
#endif
	return 0;
}

int IsMultiFormsWC(char *pDoc)
{
#ifdef STORE_FORM_N
	if(!(0x4000 & ((long*)pDoc)[1]))
		return 1;
#endif
	return 0;
}

int __cdecl truncation_NWCntxt_stream(struct SET_ST_TAG *p_stDelDocs, struct tag_index *pin, 
								struct tag_iterator *spit, struct tag_stream *psstr, struct tag_stream *pdstr);

int __cdecl truncation_NContxt_stream(struct SET_ST_TAG *p_stDelDocs, struct tag_index *pin, 
								struct tag_iterator *spit, struct tag_stream *psstr, struct tag_stream *pdstr);

int __cdecl truncation_NBCntxt_stream(struct SET_ST_TAG *p_stDelDocs, struct tag_index *pin, 
								struct tag_iterator *spit, struct tag_stream *psstr, struct tag_stream *pdstr);

extern int CompStringsZZZX(const void *l1, const void *l2);

#ifndef MIN_MEM_CONTEXT
  #ifndef _WIN64
	extern char pTmpBuff0[4096];
	extern stream_st psstr2;
  #endif
#endif

int truncation_Contxt_stream(	int added, set_st* p_stDelDocs, index_st *pin, 
								iter_st *spit, stream_st *psstr, stream_st *pdstr,
								int (__cdecl *pPContxtNode)(char*,int,long*,int*,long*,int*),
								long (__cdecl *lGetFIndx)(long **))
{
	char pINX[1024*1024];
	u_int32_t writed = 0, nodes_size;
	int IsFlushKey = 0
				, writeStrIndex=
		#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
								6
		#else
								1
		#endif
				, newSZ= p_stDelDocs->SkipDocCount;
	void *pRt;
	long *p_DelDocs= p_stDelDocs->pSkipDoc, count, Doc, fOffs= 0, repeat= 0, tmpIndx= 0;

	char *pStart=psstr->data, *pNext= psstr->data + sizeof(psstr->ref.size), *pTmpCache= 0;
	typedef struct tag_SVector0 {
		char *pStart;
		int size;
	} SVector0_st;
	SVector0_st *pPreWrite= 0;
	int pPreWriteCountSize= 0, CheckIndexs= 0;
	stref_st *pspit_ref= get_stref(spit,0);
#ifdef _WIN64
	char *pre_data;
	u_int32_t pre_size;
#endif
	if(!psstr->pCurrKey)
		psstr->pCurrKey= (char*)malloc(pin->hdr.keylen+((pgfile_st*)psstr->str)->pfhdr->page_size);
	if(psstr->pNorml_Node != (Norml_Node*)-1){
		if(IS1_SHORT_STR(pspit_ref)){
			memcpy((pTmpCache= psstr->pCurrKey+pin->hdr.keylen), psstr->data, psstr->ref.size);
		}
	}
	if(psstr->curr_B)
		memcpy(psstr->pCurrKey, spit->pkey, pin->hdr.keylen);
	pStart=psstr->data;
	pNext= psstr->data + sizeof(psstr->ref.size);
	pNext -= sizeof(psstr->ref.size);

	CheckIndexs= added;
	pStart =  pNext;
	do{
		while((!(pRt= bsearch_nxt((Doc= 0x7fffffff & *(long*)pNext), &p_DelDocs, &newSZ)) && Doc < *p_DelDocs)
				&& (u_int32_t)(0xffffffff &(pNext - pStart)) <= psstr->ref.size){
			int Stop= 0;
		do{
			nodes_size = (u_int32_t)(0x7fffffff & pPContxtNode(pNext, added, &Doc, &fOffs, &count, (int*)pINX));
			if(CheckIndexs){
				char *pINXn= pINX;
				while(count--){
					int cc= psstr->ArrayIOffsCount;
					tmpIndx= 0x000000ff & *(long*)(pINXn++);
					while(cc--){
						if(psstr->ArrayIOffs[cc].i == (unsigned char)tmpIndx)
							break;
					}
					if(cc == -1){
						if(psstr->ArrayIOffsCount){
	if(pPreWriteCountSize){
		int ii= 0;
		while(ii < pPreWriteCountSize){
			if(write_stream(pdstr, pPreWrite[ii].pStart,
								pPreWrite[ii].size) != pPreWrite[ii].size)
				return -1;
			ii++;
		}
		free(pPreWrite);
	}
	if(psstr->pNorml_Node != (Norml_Node*)-1){
		psstr->ArrayIOffsCount= 0;
		CheckIndexs= 0;
		break;
	}else{
		pPreWriteCountSize= 0;
		pPreWrite= 0;
	}
						}
	psstr->ArrayIOffs[psstr->ArrayIOffsCount].i= (unsigned char)tmpIndx;
	psstr->ArrayIOffsCount++;
					}
				}
			}
			if (nodes_size + (u_int32_t)(0xffffffff & (pNext - pStart)) >= psstr->ref.size){
				if(!pRt && Doc < *p_DelDocs){
					Stop++;
					break;
				}else{
					psstr->ref.size -= nodes_size;
					break;
				}
			}
		}while(repeat-- && (nodes_size -= 4) && (pNext += nodes_size));repeat= 0;
			pNext += nodes_size;
			if(Stop)
				break;
			if(pin->hdr.nstreams != 1){
				if(write_stream(pdstr, pStart + writed, 4) != 4)
					return -1;
				if(write_stream(pdstr+writeStrIndex, pStart + writed + 4, nodes_size-4) != (nodes_size-4))
					return -1;
				if(write_stream(pdstr, &(pdstr[writeStrIndex].ref.size), 4) != 4)
					return -1;
				writed += nodes_size;
				IsFlushKey++;
			}
		}
		if((nodes_size= ((u_int32_t)(0xffffffff &(pNext - pStart)) - writed))){
			if(CheckIndexs){
				if(!(pPreWriteCountSize % 16)){
					if((pPreWrite= (SVector0_st*)realloc(pPreWrite,
								sizeof(*pPreWrite)*(pPreWriteCountSize+16))) == 0)
						return -1;
				}
				pPreWrite[pPreWriteCountSize].pStart= pStart + writed; 
				pPreWrite[pPreWriteCountSize++].size= nodes_size;
				IsFlushKey++;
			}else
			{
				if(pin->hdr.nstreams != 1){
					if(write_stream(pdstr, pStart + writed, 4) != 4)
						return -1;
					if(write_stream(pdstr+writeStrIndex, pStart + writed + 4, nodes_size-4) != (nodes_size-4))
						return -1;
					if(write_stream(pdstr, &(pdstr[writeStrIndex].ref.size), 4) != 4)
						return -1;
				}else{
					if(write_stream(pdstr, pStart + writed, nodes_size) != nodes_size)
						return -1;
				}
				IsFlushKey++;
			}
			writed += nodes_size;
		}
		if(writed < psstr->ref.size && pRt){
			do{
				nodes_size = (u_int32_t)(0x7fffffff & pPContxtNode(pNext, added, &Doc, &fOffs, &count, (int*)pINX));
			}while(repeat-- && (nodes_size -= 4) && (pNext += nodes_size));repeat= 0;
			pNext += nodes_size;
			writed += (u_int32_t)(0xffffffff & (pNext - pStart)) - writed;
		}
	}while(writed < psstr->ref.size);
#ifdef _WIN64
	pre_data= psstr->data;
	pre_size= psstr->ref.size;
	psstr->flags &= ~SF_FREEBUF;
#endif
	if(IsFlushKey){
	if(CheckIndexs){
		// ReFormat for One Index //
		int ii= 0;
		while(ii < pPreWriteCountSize){
			long	*pRead= (long*)pPreWrite[ii].pStart, *pWrite = pRead,
					*pEnd= (long*)((char*)pRead+ pPreWrite[ii].size), count= 0;
			if(pPContxtNode == CalcNodeSizeWC){
				if(psstr->pNorml_Node != (Norml_Node*)-1){
					count = 1;
					do{
						pWrite++;
						pRead++;
						while(count--){
							if(!(*pRead & 0x800000))
								count++;
							memcpy(pWrite, pRead, 3);
							(*(short*)pWrite) |= 0x4000;
							pWrite = (long*)((char*)pWrite+3);
							pRead++;
						}
					}while(pRead < pEnd && (count = 1) && (pWrite[0]=pRead[0]));
				}else
					pWrite= pEnd;
			}else if(pPContxtNode == CalcNodeSizeNC){
				count = pRead[1];
				do{
					pWrite += 2;
					pRead += 2;
					while(count--){
						*pWrite= *pRead | 0x4000;
						pWrite++;
						pRead= (long*)((char*)pRead + sizeof(*pRead) + sizeof(char));
					}
				}while(pRead < pEnd && (count = pRead[1])
						 && (pWrite[0]=pRead[0])&& (pWrite[1]=pRead[1]));
			}else if(pPContxtNode == CalcNodeSizeBC){
				count = pRead[1];
				pNext= pPreWrite[ii].pStart;
				do{
					*pWrite= pRead[0] & 0x7fffffff; pWrite++;
					do{
						nodes_size= 8;
						count= 0;
						if(0x80000000 & pRead[1]){
							if(0x40000000 & pRead[1]){
								*pWrite=pRead[1]; pWrite++;
								nodes_size ++;
							}else{
								*pWrite= pRead[1] | 0x40000000; pWrite++;
								count++;
							}
						}else{
							repeat= pRead[2] - 1;
							nodes_size += 4;
							if(0x40000000 & pRead[1]){
								*pWrite=pRead[1]; pWrite++;
								nodes_size ++;
							}else{
								*pWrite= pRead[1] | 0x40000000; pWrite++;
								count++;
							}
							*pWrite= pRead[2]; pWrite++;
						}
						if(count)
							nodes_size += 1 + (u_int32_t)*(pNext+nodes_size);
					}while(repeat-- && (nodes_size -= 4)
							&& (pNext += nodes_size) && (pRead= (long*)pNext));repeat= 0;
					pNext += nodes_size;
					pRead= (long*)pNext;
				}while(pRead < pEnd);
			}
			count = (long)(0x7fffffff & ((char*)pWrite - pPreWrite[ii].pStart));
			if(write_stream(pdstr, pPreWrite[ii].pStart, 4) != 4)
				return -1;
			if (write_stream(pdstr + writeStrIndex, pPreWrite[ii].pStart + 4, (u_int32_t)(0x7fffffff & ((char*)pWrite - pPreWrite[ii].pStart)) - 4) != (count - 4))
				return -1;
			if(write_stream(pdstr, &(pdstr[writeStrIndex].ref.size), 4) != 4)
				return -1;
			ii++;
		}
		free(pPreWrite);
	}
		{
			char *key_buff= (char*)calloc(1, 256);
			memcpy(key_buff, spit->pkey, 32);
			attach_stream(pdstr, get_stref_ex(	key_buff, pin->hdr.keylen,
												pin->hdr.strinfo.immds,
												pin->hdr.nstreams, 0));
			close_stream(pdstr);

			if(pin->hdr.nstreams != 1){
				attach_stream(pdstr+writeStrIndex, get_stref_ex(	key_buff, pin->hdr.keylen,
													pin->hdr.strinfo.immds,
													pin->hdr.nstreams, 2));
				close_stream(pdstr+writeStrIndex);
			}
			if(psstr->curr_B)
				memcpy(spit->pkey, psstr->pCurrKey, pin->hdr.keylen);
			if(pPContxtNode == CalcNodeSizeWC || pPContxtNode == CalcNodeSizeNC || pPContxtNode == CalcNodeSizeBC){
				release_stream(psstr);
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
				psstr->data= pdstr[1].data;
				psstr->ref.size= get_stref(spit, 1)->size;
#else
				load_stream_ex(spit->str, get_stref(spit, 1), psstr, &(spit->strinfo));
#endif
				move_stream(psstr, pdstr->str,	get_stref_ex(	key_buff, pin->hdr.keylen,
																pin->hdr.strinfo.immds,
																pin->hdr.nstreams, 1));
				if(psstr->pNorml_Node == (Norml_Node*)-1){
				  char errorMSG[]= "ERROR MRGLIB: Not find actual form '%s' for norm '%s' !!!";
				  Form_Node *pPut;
				  u_int64_t BasesMask= ((u_int64_t)1) << psstr->curr_B;
				  if(CheckIndexs){
					char *pFormC;
					psstr->ref.size = (u_int32_t)psstr->ArrayIOffsCount;
					while(psstr->ref.size--){
						if(*(pFormC= (psstr->data+psstr->ArrayIOffs[psstr->ref.size].i*32)) < 32){
							if(!(pPut= bsearch(	pFormC+1, psstr->pAForms , psstr->max_B, sizeof(*pPut), CompStringsZZZX))){
				printf(errorMSG, pFormC+1, spit->pkey+1);
				//__debugbreak();
							}
						}else{
							char tmpKey[32];
							memcpy(tmpKey, pFormC+1, 31);
							tmpKey[31]= 0;
			if(!(pPut= bsearch(	tmpKey, psstr->pAForms , psstr->max_B, sizeof(*pPut), CompStringsZZZX)))
				printf(errorMSG, tmpKey, spit->pkey+1);
						}
						if(pPut)
							pPut->BasesMask |= BasesMask;
					}
				  }else{
					if(*psstr->data < 32){
						if(!(pPut= bsearch(	psstr->data+1, psstr->pAForms, psstr->max_B, sizeof(*pPut), CompStringsZZZX))){
							printf(errorMSG, psstr->data+1, spit->pkey+1);
				//__debugbreak();
							}
					}else{
						char tmpKey[32];
						memcpy(tmpKey, psstr->data+1, 31);
						tmpKey[31]= 0;
						if(!(pPut= bsearch(	tmpKey, psstr->pAForms, psstr->max_B, sizeof(*pPut), CompStringsZZZX))){
							printf(errorMSG, tmpKey, spit->pkey+1);
				//__debugbreak();
							}
					}
					if(pPut)
						pPut->BasesMask |= BasesMask;
				  }
				}
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
				psstr->data= 0;
#else
				release_stream(psstr);
#endif
			}
			else
			release_stream(psstr);
			add_key(pin, key_buff);
			free(key_buff);
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
#elif !defined(MIN_MEM_CONTEXT)
			if(psstr->curr_B){
		#ifndef _WIN64
				stref_st *pref = 0;
				pref= get_stref(spit,0);
				release_stream(psstr);
				load_stream_ex(spit->str, pref, psstr, &(spit->strinfo));
		#else
				release_stream(psstr);
		#endif
				if(spit->nstreams == 3){
					char *new_data = 0, *new_write;
#ifndef _WIN64
					char *pTmpBuff = pTmpBuff0, *pR;
					u_int32_t nxt_sz= 0;
					if(spit->pkey[0] == 2 && (spit->pkey[1] == -62 || spit->pkey[1] == -56)){
						pdstr[0].flags &= ~SF_NOALLOC;
						close_stream(pdstr);
						pdstr[writeStrIndex].flags &= ~SF_NOALLOC;
						close_stream(pdstr+writeStrIndex);
						create_stream(pin, pdstr);
						create_stream(pin, pdstr+writeStrIndex);
						pdstr[0].flags |= SF_NOALLOC;
						pdstr[writeStrIndex].flags |= SF_NOALLOC;
					}
					if (psstr->flags & SF_FREEBUF)
						pTmpBuff = psstr->rec;
					else{
						memcpy(pTmpBuff, psstr->rec, pref->size);
					}
					if (!load_stream_ex(spit->str, get_stref(spit, 2), &psstr2, &(spit->strinfo))
						|| !(pR = psstr2.data)){
						printf("\nError ! (%s)(%d)", spit->pkey + 1, psstr2.ref.size);
						exit(-656);
					}
					if(spit->pkey[0] == 2 && (spit->pkey[1] == -62 || spit->pkey[1] == -56)){
						char tmpBaseName[1024], *fnd = strrchr(pdstr->str->pgfile.name, '.');
						int hFlush;
						*fnd = 0;
						sprintf(tmpBaseName, "%s.gsplit.tmp", pdstr->str->pgfile.name);
						*fnd = '.';
						if ((hFlush = c_io_open(tmpBaseName, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY)) == -1
							|| c_io_write(hFlush, pR, psstr2.ref.size) != psstr2.ref.size
							|| c_io_lseek(hFlush, 0, ACE_OS_SEEK_SET) != 0){
						}
						close_stream(&psstr2);
						if (!(new_write = (new_data = (char*)malloc(psstr->ref.size / 2 + psstr2.ref.size + psstr->str->pgfile.pfhdr->page_size)))){
							printf("\nError ! (%s)(%d)", spit->pkey + 1, psstr->ref.size / 2 + psstr2.ref.size + psstr->str->pgfile.pfhdr->page_size);
							exit(-656);
						}
						do{
							*(u_int32_t*)new_write = *(u_int32_t*)pTmpBuff;
							nxt_sz = ((ref_st*)pTmpBuff)->sub - nxt_sz;
							new_write += sizeof(u_int32_t);
							pR = (char*)malloc(nxt_sz + 16);
							c_io_read(hFlush, pR, nxt_sz);
							memcpy(new_write, pR, nxt_sz);
							free(pR);
							new_write += nxt_sz;
							nxt_sz = ((ref_st*)pTmpBuff)->sub;
							pTmpBuff += sizeof(ref_st);
							psstr->ref.size -= sizeof(ref_st);
						} while (psstr->ref.size);
						c_io_close(hFlush);
						ace_os_unlink(tmpBaseName);
					}else
					{
						if (!(new_write = (new_data = (char*)malloc(psstr->ref.size / 2 + psstr2.ref.size + psstr->str->pgfile.pfhdr->page_size)))){
							printf("\nError ! (%s)(%d)", spit->pkey + 1, psstr->ref.size / 2 + psstr2.ref.size + psstr->str->pgfile.pfhdr->page_size);
							exit(-656);
						}
						do{
							*(u_int32_t*)new_write = *(u_int32_t*)pTmpBuff;
							nxt_sz = ((ref_st*)pTmpBuff)->sub - nxt_sz;
							new_write += sizeof(u_int32_t);
							memcpy(new_write, pR, nxt_sz);
							pR += nxt_sz;
							new_write += nxt_sz;
							nxt_sz = ((ref_st*)pTmpBuff)->sub;
							pTmpBuff += sizeof(ref_st);
							psstr->ref.size -= sizeof(ref_st);
						} while (psstr->ref.size);
						close_stream(&psstr2);
					}
					if (psstr->flags & SF_FREEBUF){
						free(psstr->data);
					}else{
						psstr->flags |= SF_FREEBUF;
					}
#else
					new_write= (new_data= pre_data) + pre_size;
					psstr->flags |= SF_FREEBUF;
#endif
					psstr->rec= psstr->data= new_data;
					psstr->ref.size = (size_t)(0xffffffff & (new_write - new_data));
				}
				if(pTmpCache){
					memcpy(psstr->data, pTmpCache, psstr->ref.size);
				}
			}
  #ifdef _WIN64
			else
				psstr->data= pre_data;
  #endif

#endif
		}
  }else{
	  if(psstr->pNorml_Node){
		  if(psstr->pNorml_Node != (Norml_Node*)-1){
			  if(psstr->pNorml_Node->pBases){
				  psstr->pNorml_Node->pBases[psstr->curr_B]= 1;
			  }else{
				  memcpy(psstr->pNorml_Node->val, spit->pkey, 32);
				  psstr->pNorml_Node->pBases = (char*)malloc(psstr->max_B);
				  psstr->pNorml_Node->pBases[psstr->curr_B]= 1;
			  }
		  }
	  }else{
		  if(!(psstr->iDeletedNorms % 64))
			  psstr->pDeletedNorms= realloc(psstr->pDeletedNorms, (psstr->iDeletedNorms+64)*32);
		  memcpy(psstr->pDeletedNorms+psstr->iDeletedNorms*32, spit->pkey, 32);
		  psstr->iDeletedNorms++;
	  }
	  close_stream(pdstr);
	  if(pin->hdr.nstreams != 1){
		  close_stream(pdstr+writeStrIndex);
	  }
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
#elif !defined(MIN_MEM_CONTEXT)
	  if(psstr->curr_B){
#ifndef _WIN64
		stref_st *pref = 0;
		pref= get_stref(spit,0);
		release_stream(psstr);
		load_stream_ex(spit->str, pref, psstr, &(spit->strinfo));
#else
		release_stream(psstr);
#endif
		memcpy(spit->pkey, psstr->pCurrKey, pin->hdr.keylen);
		if (spit->nstreams == 3){
			char *new_data = 0, *new_write;
#ifndef _WIN64
			char *pTmpBuff = pTmpBuff0, *pR;
			u_int32_t nxt_sz= 0;
			if(spit->pkey[0] == 2 && (spit->pkey[1] == -62 || spit->pkey[1] == -56)){
				pdstr[0].flags &= ~SF_NOALLOC;
				close_stream(pdstr);
				pdstr[writeStrIndex].flags &= ~SF_NOALLOC;
				close_stream(pdstr+writeStrIndex);
				create_stream(pin, pdstr);
				create_stream(pin, pdstr+writeStrIndex);
				pdstr[0].flags |= SF_NOALLOC;
				pdstr[writeStrIndex].flags |= SF_NOALLOC;
			}
			if (psstr->flags & SF_FREEBUF)
				pTmpBuff = psstr->rec;
			else{
				memcpy(pTmpBuff, psstr->rec, pref->size);
			}
			if (!load_stream_ex(spit->str, get_stref(spit, 2), &psstr2, &(spit->strinfo))
				|| !(pR = psstr2.data)){
				printf("\nError ! (%s)(%d)", spit->pkey + 1, psstr2.ref.size);
				exit(-656);
			}
			if(spit->pkey[0] == 2 && (spit->pkey[1] == -62 || spit->pkey[1] == -56)){
				char tmpBaseName[1024], *fnd = strrchr(pdstr->str->pgfile.name, '.');
				int hFlush;
				*fnd = 0;
				sprintf(tmpBaseName, "%s.gsplit.tmp", pdstr->str->pgfile.name);
				*fnd = '.';
				if ((hFlush = c_io_open(tmpBaseName, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY)) == -1
					|| c_io_write(hFlush, pR, psstr2.ref.size) != psstr2.ref.size
					|| c_io_lseek(hFlush, 0, ACE_OS_SEEK_SET) != 0){
				}
				close_stream(&psstr2);
				if (!(new_write = (new_data = (char*)malloc(psstr->ref.size / 2 + psstr2.ref.size + psstr->str->pgfile.pfhdr->page_size)))){
					printf("\nError ! (%s)(%d)", spit->pkey + 1, psstr->ref.size / 2 + psstr2.ref.size + psstr->str->pgfile.pfhdr->page_size);
					exit(-656);
				}
				do{
					*(u_int32_t*)new_write = *(u_int32_t*)pTmpBuff;
					nxt_sz = ((ref_st*)pTmpBuff)->sub - nxt_sz;
					new_write += sizeof(u_int32_t);
					pR = (char*)malloc(nxt_sz + 16);
					c_io_read(hFlush, pR, nxt_sz);
					memcpy(new_write, pR, nxt_sz);
					free(pR);
					new_write += nxt_sz;
					nxt_sz = ((ref_st*)pTmpBuff)->sub;
					pTmpBuff += sizeof(ref_st);
					psstr->ref.size -= sizeof(ref_st);
				} while (psstr->ref.size);
				c_io_close(hFlush);
				ace_os_unlink(tmpBaseName);
			}else{
				if (!(new_write = (new_data = (char*)malloc(psstr->ref.size / 2 + psstr2.ref.size + psstr->str->pgfile.pfhdr->page_size)))){
					printf("\nError ! (%s)(%d)", spit->pkey + 1, psstr->ref.size / 2 + psstr2.ref.size + psstr->str->pgfile.pfhdr->page_size);
					exit(-656);
				}
				do{
					*(u_int32_t*)new_write = *(u_int32_t*)pTmpBuff;
					nxt_sz = ((ref_st*)pTmpBuff)->sub - nxt_sz;
					new_write += sizeof(u_int32_t);
					memcpy(new_write, pR, nxt_sz);
					pR += nxt_sz;
					new_write += nxt_sz;
					nxt_sz = ((ref_st*)pTmpBuff)->sub;
					pTmpBuff += sizeof(ref_st);
					psstr->ref.size -= sizeof(ref_st);
				} while (psstr->ref.size);
				close_stream(&psstr2);
			}
			if (psstr->flags & SF_FREEBUF){
				free(psstr->data);
			}else
				psstr->flags |= SF_FREEBUF;
#else
			new_write= (new_data= pre_data) + pre_size;
			psstr->flags |= SF_FREEBUF;
#endif
			psstr->rec= psstr->data= new_data;
			psstr->ref.size = (size_t)(0xffffffff & (new_write - new_data));
		}
		if(pTmpCache){
			memcpy(psstr->data, pTmpCache, psstr->ref.size);
		}
	  }
  #ifdef _WIN64
	  else
		  psstr->data= pre_data;
  #endif
#endif
  }
	return 0;
}

int __cdecl truncation_NWCntxt_stream(struct SET_ST_TAG *p_stDelDocs, struct tag_index *pin, 
								struct tag_iterator *spit, struct tag_stream *psstr, struct tag_stream *pdstr)
{
	return truncation_Contxt_stream(get_stref(spit,1)->size > 32, p_stDelDocs, pin, spit, psstr, pdstr, CalcNodeSizeWC, 0);
}

int __cdecl truncation_NContxt_stream(struct SET_ST_TAG *p_stDelDocs, struct tag_index *pin, 
								struct tag_iterator *spit, struct tag_stream *psstr, struct tag_stream *pdstr)
{
	return truncation_Contxt_stream(IsMultiFormsNC(psstr->data), p_stDelDocs, pin, spit, psstr, pdstr, CalcNodeSizeNC, lGetFIndxNC);
}

int __cdecl truncation_NBCntxt_stream(struct SET_ST_TAG *p_stDelDocs, struct tag_index *pin, 
								struct tag_iterator *spit, struct tag_stream *psstr, struct tag_stream *pdstr)
{
	return truncation_Contxt_stream(IsMultiFormsBC(psstr->data+sizeof(long)), p_stDelDocs, pin, spit, psstr, pdstr, CalcNodeSizeBC, lGetFIndxBC);
}

int write_stream_FromReaded(int (__cdecl *pPNode)(char*,int,long*,int*,long*,int*),
								stream_st *pstr, void *buf, u_int32_t sizeAll, int Added, int inMap)
{
#ifdef STORE_FORM_N
	char *pNxt= (char*)buf, *pWrite, *pEnd= (char*)buf+ sizeAll, *iOut= 0;
	long lcount, tmpIndx, lDoc, nodes_size, repeat= 0, pre, wV;
	int fOffs= 0, skipWrite= 0, wrt;
	if(Added)
		iOut= (char*)alloca(1024*1024);
	while(pNxt < pEnd){ pWrite= pNxt; wrt= 0;
	  do{
		  if(pstr && pPNode == CalcNodeSizeWC){
			  lDoc= 0x7fffffff & *(long*)pNxt;
			  nodes_size= 4;
			  lcount= 1;
		  }else
			nodes_size= pPNode(pNxt, Added, &lDoc, &fOffs, &lcount, (int*)iOut);
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
#elif !defined(MIN_MEM_CONTEXT)
		if(inMap && pNxt < pEnd && !Added && !pstr->ArrayIOffsCount){
	pstr->ArrayIOffs[pstr->ArrayIOffsCount].i= (unsigned char)0;
#ifdef ALL_Index_Offset
	pstr->ArrayIOffs[pstr->ArrayIOffsCount].Doc= lDoc;
	pstr->ArrayIOffs[pstr->ArrayIOffsCount].Para= pNxt[2] >> 15;
	pstr->ArrayIOffs[pstr->ArrayIOffsCount].Word= pNxt[2] & 0x3fff;
#endif
	pstr->ArrayIOffsCount++;
		}
#endif
		if(pstr){
			int PutCount= 0;
			if(!wrt){
				if(write_stream(pstr, &lDoc, sizeof(long)) != sizeof(long))
					return -1;
				if(Added && pPNode != CalcNodeSizeWC){
					/*if(0x40000000 & ((long*)pWrite)[1])
						wrt= nodes_size -  lcount - sizeof(long);
					else{
						wrt= nodes_size -  sizeof(char) - lcount - sizeof(long);
						PutCount++;
					}*/;
				}else
					wrt= nodes_size - sizeof(long);
				if(write_stream(pstr, pWrite + sizeof(long), wrt) != wrt)
					return -1;
			}else{
				if(Added){
					if(0x40000000 & *((long*)(pWrite + skipWrite)))
						wrt= nodes_size -  lcount - skipWrite;
					else{
						wrt= nodes_size -  sizeof(char) - lcount - sizeof(long);
						PutCount++;
					}
				}else
					wrt= nodes_size - skipWrite;
				if(write_stream(pstr, pWrite + skipWrite, wrt) != wrt)
					return -1;
			}
			if(PutCount && write_stream(pstr, &lcount, sizeof(long)) != sizeof(long))
				return -1;
		}
		pWrite += nodes_size - skipWrite;
		pre= 0;
		while(lcount--){
			tmpIndx= 0;
			if(Added){
				if(pPNode == CalcNodeSizeWC){
					if(pstr){
						/*lDoc= 0;
						memcpy(&lDoc, pWrite, 3);
						if(lDoc & 0x800000){
							lDoc &= ~0x800000;
							lDoc |= 0x80000000;
						}else
							lcount++;
						if(write_stream(pstr, &lDoc, sizeof(long)) != sizeof(long))
							return -1;
						tmpIndx= *(pWrite+3);
						nodes_size += 4;
						pWrite= pNxt + nodes_size;*/
						if((*(short*)pWrite) & 0x8000){
							memcpy(&lDoc, pWrite, 3);
							if((*(long*)pWrite) & 0x4000)
								lDoc= (((lDoc & 0xff0000) >> 2) | (lDoc & 0x3fff))|0x80000000;
							else{
								lDoc= ((lDoc & 0xff0000) >> 2) | (lDoc & 0x3fff);
								lcount++;
							}
							nodes_size += 4;
							tmpIndx= ((unsigned char*)pWrite)[3];
						}else{
							memcpy(&lDoc, pWrite, 2);
							if((*(long*)pWrite) & 0x4000)
								lDoc= (lDoc & 0x3fff)|0x80000000;
							else{
								lDoc= lDoc & 0x3fff;
								lcount++;
							}
							nodes_size += 3;
							tmpIndx= ((unsigned char*)pWrite)[2];
						}
						pWrite= pNxt + nodes_size;
						wV= lDoc+pre;
						if(lDoc&0x80000000)
							wV= ((wV >> 14) << 15) | (wV & 0x3fff) | 0x80000000;
						else
							wV= ((wV >> 14) << 15) | (wV & 0x3fff);
						pre += lDoc & 0xfffffc;
						if(write_stream(pstr, &wV, sizeof(long)) != sizeof(long))
							return -1;
					}
				}else if(pPNode == CalcNodeSizeNC){
					tmpIndx= (*(unsigned long*)(pWrite+1)) >> 24;
					pWrite += fOffs;
				}else
					tmpIndx= (int)*(pWrite+skipWrite-1-lcount);
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
#elif !defined(MIN_MEM_CONTEXT)
				if(inMap){
					int cc= pstr->ArrayIOffsCount;
					while(cc--){
						if(pstr->ArrayIOffs[cc].i == (unsigned char)tmpIndx)
							break;
					}
					if(cc == -1){
	pstr->ArrayIOffs[pstr->ArrayIOffsCount].i= (unsigned char)tmpIndx;
	#ifdef ALL_Index_Offset
	pstr->ArrayIOffs[pstr->ArrayIOffsCount].Doc= lDoc;
	pstr->ArrayIOffs[pstr->ArrayIOffsCount].Para= ((long*)((char*)pNxt-1))[0] >> 15;
	pstr->ArrayIOffs[pstr->ArrayIOffsCount].Word= ((long*)((char*)pNxt-1))[0] & 0x3fff;
	#endif
	pstr->ArrayIOffsCount++;
					}
				}
#endif
				if(pstr){
					if(!pstr->str)
						tmpIndx= ((long*)pstr->pDeletedNorms)[tmpIndx];
					if(write_stream(pstr, &tmpIndx, sizeof(long)) != sizeof(long))
						return -1;
				}
			}else if(pstr){
				if(pPNode == CalcNodeSizeWC){
					if((*(short*)pWrite) & 0x8000){
						memcpy(&lDoc, pWrite, 3);
						if((*(long*)pWrite) & 0x4000)
							lDoc= (((lDoc & 0xff0000) >> 2) | (lDoc & 0x3fff))|0x80000000;
						else{
							lDoc= ((lDoc & 0xff0000) >> 2) | (lDoc & 0x3fff);
							lcount++;
						}
						nodes_size += 3;
					}else{
						memcpy(&lDoc, pWrite, 2);
						if((*(long*)pWrite) & 0x4000)
							lDoc= (lDoc & 0x3fff)|0x80000000;
						else{
							lDoc= lDoc & 0x3fff;
							lcount++;
						}
						nodes_size += 2;
					}
					pWrite= pNxt + nodes_size;
					wV= lDoc+pre;
					if(lDoc&0x80000000)
						wV= ((wV >> 14) << 15) | (wV & 0x3fff) | 0x80000000;
					else
						wV= ((wV >> 14) << 15) | (wV & 0x3fff);
					pre += lDoc & 0xfffffc;
					if(write_stream(pstr, &wV, sizeof(long)) != sizeof(long))
						return -1;
					if(write_stream(pstr, &tmpIndx, sizeof(long)) != sizeof(long))
						return -1;
				}else if(pPNode == CalcNodeSizeNC){
					(*(long*)pWrite) &= ~0x4000;
					if(write_stream(pstr, pWrite, sizeof(long)) != sizeof(long))
						return -1;
				}else{
					if(!pstr->str)
						tmpIndx= ((long*)pstr->pDeletedNorms)[tmpIndx];
					if(write_stream(pstr, &tmpIndx, sizeof(long)) != sizeof(long))
						return -1;
				}
			}
		}
	  }while(repeat-- && (nodes_size -= sizeof(long)) && (pNxt += nodes_size) && (pWrite= pNxt) && (skipWrite= sizeof(long)));repeat= 0;skipWrite= 0;
	  pNxt += nodes_size;
	  if(!pstr)
		  return (int)(0x7fffffff & (pNxt - (char*)buf));
	}
	return sizeAll;
#else
	if(pstr && write_stream(pstr, buf, sizeAll) != (int)sizeAll)
		return -1;
	return sizeAll;
#endif
}
//#endif
extern int CompStringsZZZ(const void *pFirst, const void*pSecond);

#endif
