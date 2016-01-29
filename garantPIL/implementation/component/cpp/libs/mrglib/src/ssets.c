#include "shared/Core/fix/mpcxc.h"
#include <sys/types.h>
#include <stdlib.h>

#include "osdep.h"
#include "gdbapi.h"
#include "sets.h"

set_st *set_from_stream(stream_st *pstr, set_st *pset, u_int16_t reclen)
{
	if(!pset) pset = (set_st *)ml_malloc(sizeof(set_st));
	pset->reclen = reclen;
	pset->set = pstr->data;
	pset->count = pstr->ref.size / reclen;
	return pset;
}

static int pwr2(int n)
{
	int i;

	for(i=0; n; i++, n >>= 1);
	return i;
}

int stream_isect_sets(stream_st *pdest, set_st *ps1, set_st *ps2)
{
	u_int32_t c1, c2;
	char *r1, *r2;
	cmpfunc_ft rcmp;
	int i, j, match;

	//if(ps1->reclen != ps2->reclen) return 0;
	//if((void *)(ps1->rcmp) != (void *)(ps2->rcmp)) return 0;
	if(!(ps1->count && ps2->count)) return 0;
	rcmp = ps2->rcmp;
	r1 = ps1->set; r2 = ps2->set;
	c1 = c2 = 0;
	if(	ps2->count/ps1->count < (u_int32_t)pwr2(ps2->count)) {
		do {
			match = (*rcmp)(r1, r2);
			if(!match) {
				do {
					write_stream(pdest, r1, ps1->reclen);
					r1 += ps1->reclen;
					c1++;
				} while(c1<ps1->count && !(*rcmp)(r1, r2));
				r2 += ps2->reclen;
				c2++;
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
	}
	else {
		c2 = ps2->count;
		for(i=0; i < (int)ps1->count; i++) {
			j = bfindgex(r1, r2, c2, ps2->reclen, ps2->rcmp);
			if(j == (int)c2)
				return (int)(pdest->ref.size);
			if(!(*(ps2->rcmp))(r1, r2+j*ps2->reclen))
				write_stream(pdest, r1, ps1->reclen);
			r1 += ps1->reclen;
			r2 += j*ps2->reclen;
			c2 -= j;
		}
	}
	return (int)(pdest->ref.size);
}

int minrecx(set_st *pset, int count, int *xmin, cmpfunc_ft rcmp);

int stream_merge_sets(stream_st *pstr, set_st *ps, int count)
{
	int i, *xmin, del, reclen, mincount;
	int size;
	cmpfunc_ft rcmp;
	set_st *pset;

	rcmp = ps->rcmp;
	reclen = ps->reclen;

	for(i=1; i<count; i++)
		if(ps[i].rcmp != rcmp)
			return 0;

	xmin = (int *)alloca(count*sizeof(int));
	size = count*sizeof(set_st);
	pset = (set_st *)alloca(size);
	memcpy(pset, ps, size);
	for(i=0; i<count; ) {
		if(pset[i].count == 0) {
			if(i<count-1) memmove(pset+i, pset+i+1, (count-i-1)*sizeof(set_st));
			count--;
		}
		else i++;
	}
	while(count) {
		mincount = minrecx(pset, count, xmin, rcmp);
		write_stream(pstr, pset[*xmin].set, reclen);
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
	return pstr->ref.size;
}

int minrecx(set_st *pset, int count, int *xmin, cmpfunc_ft rcmp)
{
	char *rec;
	int i, mincount, unmatch;
	
	rec = pset->set;
	mincount = 1;
	*xmin = 0;
	for(i=1; i<count; i++) {
		unmatch = (*rcmp)(rec, pset[i].set);
		if(unmatch > 0) {
			rec = pset[i].set;
			mincount = 1;
			*xmin = i;
		}
		else if(!unmatch) {
			xmin[mincount] = i;
			mincount++;
		}
	}
	return mincount;
}

