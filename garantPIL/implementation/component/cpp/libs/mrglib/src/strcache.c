#include <sys/types.h>
#include <sys/stat.h>

#include "gdbapi.h"

int lcecmp(const void *l, const void *e)
{
	if(*((u_int32_t *)l) > ((cache_entry *)e)->pos) return 1;
	return (*((u_int32_t *)l) < ((cache_entry *)e)->pos) ? -1 : 0;
}

int cecmp(const void *l, const void *e)
{
	if(((cache_entry *)l)->pos > ((cache_entry *)e)->pos) return 1;
	return (((cache_entry *)l)->pos < ((cache_entry *)e)->pos) ? -1 : 0;
}

int get_most_used_entry(streamfile_st *pfile)
{
	u_int16_t diff, mdiff;
	cache_entry *pent;
	int i, xmin;

	xmin = 0;
	pent=pfile->centries;
	mdiff = pent->rec_count-pent->hits;
	for(i=1, pent++; i<pfile->cused; i++, pent++) {
		diff = pent->rec_count-pent->hits;
		if(diff < mdiff) {
			mdiff = diff;
			xmin = i;
		}
	}
	return xmin;
}

void *rsp_get_page(streamfile_st *pfile, u_int32_t pos)
{
	int xent, disent;
	cache_entry *pent, *pdisent;
	char *page, *rec;
	u_int32_t pgsize;
	
	pgsize = pfile->pgfile.pfhdr->page_size;
	xent = bfindgex(&pos, pfile->centries, pfile->cused, sizeof(cache_entry), lcecmp);
	if(xent == pfile->cused) pent = NULL;
	else pent = pfile->centries + xent;
	if (!pent || pent->pos != pos) {
		pent = pfile->centries + xent;
		if(pfile->cused == pfile->cmax) { // Cache full : discard one page
			disent = get_most_used_entry(pfile);
			pdisent = pfile->centries + disent;
			pfile->hits[pdisent->pos] = pdisent->hits;
			page = pdisent->page;
			if(xent > disent) {
				memmove(pdisent, pdisent+1, (xent-disent-1)*sizeof(cache_entry));
				pent--;
				xent--;
			}
			else
				memmove(pent+1, pent, (disent-xent)*sizeof(cache_entry));
			pent->page = page;
		}
		else {
			pdisent = pfile->centries + pfile->cused;
			page = pdisent->page;
			if(xent < pfile->cused)
				memmove(pent+1, pent, (pfile->cused - xent)*sizeof(cache_entry));
			pent->page = page;
			pfile->cused++;
		}
		if(!read_page((pgfile_st *)pfile, pos, pent->page)) return NULL;
		rec=pent->page;
		pent->rec_count=0;
		do {
			pent->rec_count++;
			rec+=*((u_int16_t *)(rec+2))+4;
		} while(((u_int32_t)rec-(u_int32_t)(pent->page)) < pgsize-4 && *((u_int16_t *)rec));
		pent->pos = pos;
		pent->hits = (u_int16_t)(pfile->hits[pos] & 0xffff);
	}
	pent->hits++;
	page = pent->page;
	if(pent->hits == pent->rec_count) {
		pent->pos = 0xFFFFFFFF;
		if(xent != pfile->cused-1)
			memmove(pent, pent+1, (pfile->cused-1-xent)*sizeof(cache_entry));
		pfile->cused--;
		pfile->centries[pfile->cused].page = page;
	}
	return page;
}

void *ssp_get_page(streamfile_st *pfile, u_int32_t pos)
{
	cache_entry *pent;
	u_int32_t range, p, pfsz;
	fat_rec_type *pfat;
	
	pent = pfile->centries;
	range = ((u_int32_t)(pfile->cused)) + pent->pos;
	if(pos < pent->pos || pos >= range) {
		pfile->cused=1;
		pfat = pfile->fat + pos + 1;
		pent->pos = pos;
		pent++;
		p = pos + 1;
		pfsz = pgfile_size((pgfile_st *)pfile);
		while(pfile->cused<pfile->cmax && !(*pfat & CHAIN_FLAG) && p<pfsz) {
			pfile->cused++;
			pfat++;
			pent->pos = p;
			p++;
			pent++;
		}
		read_pages((pgfile_st *)pfile, pos, p-pos, pfile->cache);
		pent = pfile->centries;
	}
	else
		pent = pfile->centries + (pos - pent->pos);
		//pent = (cache_entry *)bfindge(&pos, pfile->centries, pfile->cused, sizeof(cache_entry), lcecmp);
	return pent->page;
}

void *none_get_page(streamfile_st *pfile, u_int32_t pos)
{
	if(pos != pfile->stpos) {
		read_page((pgfile_st *)pfile, pos, pfile->spage);
		pfile->stpos = pos;
	}
	return pfile->spage;
}


