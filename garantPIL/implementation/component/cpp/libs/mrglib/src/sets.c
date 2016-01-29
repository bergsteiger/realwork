#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <stdlib.h>

#include "osdep.h"
#include "gdbapi.h"
#include "sets.h"

int set_alloc(set_st *pset, size_t count)
{
	char *pnew;
	size_t len;

	if(!pset->reclen) return 0;
	len = count*pset->reclen;

	pnew= (char*)ml_malloc(len);
	if(!pnew) return 0;
	pset->set = pnew;

	if(pset->sub_seg_set != NULL){
		pnew= (char*)ml_malloc(len);
		if(!pnew) return 0;
		pset->seg_set= (unsigned char *)pnew;
	}
	bzero(pset->set, len);
	pset->alloc = count;
	pset->flags |= SETF_ALLOC;

	return 1;
}

int set_realloc(set_st *pset, size_t count)
{
	char *pnew;
	size_t len;

	if (!count) return pset->alloc;
	if(!pset->reclen || !pset->set || !(pset->flags & SETF_ALLOC)) return 0;
	len = pset->alloc*pset->reclen;

	pnew = (char *)realloc(pset->set, count*pset->reclen);
	if(!pnew) return 0;
	pset->set = pnew;

	if(pset->sub_seg_set != NULL){
		pnew = (char *)realloc(pset->seg_set, count*pset->reclen);
		if(!pnew) return 0;
		pset->seg_set = (unsigned char *)pnew;
	}

	if(count > pset->alloc)
		bzero(pset->set+len, (count-pset->alloc)*pset->reclen);

	pset->alloc = count;

	return count;
}

int set_isect(set_st *ps1, set_st *ps2)
{
	u_int32_t c1, c2;
	char *r1, *r2;
	cmpfunc_ft rcmp;
	int match;

	if(!(ps1->count && ps2->count)) return 0;
	rcmp = ps2->rcmp;
	r1 = ps1->set; r2 = ps2->set;
	c1 = c2 = 0;
	do {
		match = (*rcmp)(r1, r2);
		if(!match){
			if(*r1 == 0)
				return 0xffff;
			return (int)(*r1);
		}
		if(match < 0) {
			r1 += ps1->reclen; //esize;
			c1++;
		}
		else {
			r2 += ps2->reclen;//esize;
			c2++;
		}
	} while ((c1 < ps1->count) && (c2 < ps2->count));
	return 0;
}

int set_isect_belongs(set_st *ps1, set_st *ps2)
{
	u_int32_t c1, c2;
	char *r1, *r2;
	cmpfunc_ft rcmp;
	int match;

	if(!(ps1->count && ps2->count)) return 0;
	rcmp = ps2->rcmp;
	r1 = ps1->set; r2 = ps2->set;
	c1 = c2 = 0;
	do {
		match = (*rcmp)(r1, r2);
		if(!match){
			if(*(unsigned short*)r1 == 0)
				return 0xffff;
			return (int)(*(unsigned short*)r1);
		}
		if(match < 0) {
			r1 += ps1->reclen; //esize;
			c1++;
		}
		else {
			r2 += ps2->reclen;//esize;
			c2++;
		}
	} while ((c1 < ps1->count) && (c2 < ps2->count));
	return 0;
}

int isect_sets(set_st *pis, set_st *ps1, set_st *ps2)
{
	u_int32_t c1, c2;
	char *r1, *r2, *r;
	cmpfunc_ft rcmp;
	int match;

	if(!(ps1->count && ps2->count)) return 0;
	rcmp = ps2->rcmp;
	r1 = ps1->set; r2 = ps2->set;
	c1 = c2 = 0;
	pis->count = 0;
	pis->set = (char *)ml_malloc(ps1->reclen*
		((ps1->count>ps2->count) ? ps2->count : ps1->count));
	r = pis->set;
	pis->reclen = ps1->reclen;
	pis->rcmp = ps1->rcmp;
	pis->dtype = ps1->dtype;
	do {
		match = (*rcmp)(r1, r2);
		if(!match) {
			memcpy(r, r1, ps1->reclen);
			r += ps1->reclen;
			r1 += ps1->reclen;
			r2 += ps2->reclen;
			c1++;
			c2++;
			pis->count++;
		}
		else if(match < 0) {
			r1 += ps1->reclen;
			c1++;
		}
		else {
			r2 += ps2->reclen;
			c2++;
		}
	} while ((c1 < ps1->count) && (c2 < ps2->count));
	return (int)(pis->count);
}

extern int minrecx(set_st *, int, int*, cmpfunc_ft);

int merge_sets(set_st *ds, set_st *ps, int count)
{
	set_st *pset;
	int i, reclen, mincount, *xmin, del;
	char *rec;
	cmpfunc_ft rcmp;

	pset = (set_st *)ml_malloc(count*sizeof(set_st));
	memcpy(pset, ps, count*sizeof(set_st));
	rcmp = pset->rcmp;
	reclen = pset->reclen;
	for(i=1; i<count; i++) {
		if(pset[i].reclen != reclen || pset[i].rcmp != rcmp) {
			free(pset);
			return 0;
		}
	}
	for(i=0; i<count; ) {
		if(pset[i].count == 0) {
			if(i<count-1) memmove(pset+i, pset+i+1, (count-i-1)*sizeof(set_st));
			count--;
		}
		else i++;
	}
	xmin = (int *)alloca(count*sizeof(int));
	rec = ds->set;
	while(count) {
		mincount = minrecx(pset, count, xmin, rcmp);
		memcpy(rec, pset[*xmin].set, reclen);
		rec += reclen;
		ds->count++;
		for(i=0, del=0; i<mincount; i++) {
			xmin[i] -= del;
			pset[xmin[i]].count--;
			if(!pset[xmin[i]].count) {
				if(xmin[i] < count-1)
					memmove(pset+xmin[i], pset+xmin[i]+1, (count-xmin[i]-1)*sizeof(set_st));
				count--;
				del++;
			}
			else pset[xmin[i]].set += reclen;
		}
	}
	free(pset);
	return ds->count;
}

