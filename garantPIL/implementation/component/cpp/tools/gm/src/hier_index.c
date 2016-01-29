#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>

#include <string.h>
//#include <alloca.h>

#include "osdep.h"

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "gm.h"
#include "../../../libs/mrglib/src/log.h"

typedef char *pchar;

#ifdef __GO32__
#include <stdio.h>
#endif

#ifdef __CYGWIN32__
extern int mkstemp(char *);
#endif

//extern stream_st *create_streams(int);
//extern set_st *create_sets(int, int, int);

typedef struct tag_idc {
	u_int32_t id;
	int32_t cc;
	int32_t tc;
} idc_st;

int maxkeyx(char **pkeys, int count, int *xmax, cmpfunc_ft keycmp);
static set_st *init_sets(set_st *pset, int reclen);
static void store_key(set_st *pset, void *buf);
static void release_sets(set_st *pset);
static char *restore_key(set_st *pset, int ind);
static void stream_merge_string_sets(stream_st *pdstr, set_st *pset, int count);

static int idcrcmp(const void *i1, const void *i2)
{
	return longcmp(i2, i1);
}

static int htmpfile=-1;
static char *tmpname=0;
static char *tmptempl = "XXXXXXXX";

#ifdef PTRS_IN_META
void store_it_key(iter_st *pit, void *pkey, streamfile_st *pdest, stream_st *pstr, stream_st *pdstr);
#endif

int merge_hindex(index_st *ptarget, iter_st *spit, int count, int progress)
{
	char **pkeys, level;
	// char *pkey; 
	hierkey_st *phk;
	int maxcount, i, npidc;
	int kpp, proceed_keys;
	int *xmax, *xcur, done;
	stream_st *psstr, *pdstr;
	set_st *pset, *pids, *ids, *ptmpset, *pkeyset, *internal_sets;
	stref_st *pref;
	idc_st *pidc;
#ifdef PTRS_IN_META
	progress= 0;
#endif
	level = 0;
	if(!strcmp(ptarget->name, "DocKind") || !strcmp(ptarget->name, "Territory")){
		ptarget->hdr.keylen -= sizeof(stref_st) - 4 + ptarget->hdr.strinfo.immds;
		ptarget->hdr.nstreams= 1;
		ptarget->kar.keylen= ptarget->hdr.keylen;
	}
	flog("Making index \"%s\"\n", ptarget->name);
	pdstr = create_streams(count+1);
	psstr = pdstr + 1;
	xmax = (int *)alloca(count*sizeof(int));
	pkeys = (char **)alloca(count*sizeof(pchar));
	for(i=0, proceed_keys=0; i<count; i++) {
#ifdef PTRS_IN_META
	  index_st *pI= (index_st *)(spit[i].reccmp);
	  if(pI->kar.cache){
		if(pI->hdr.key_count){
			pI->hdr.key_count--;
			spit[i].pkey= pkeys[i]= pI->kar.cache + pI->hdr.key_count * pI->hdr.keylen;
		}else
			pkeys[i]= 0;
	  }else{
#else
	  {
#endif
		pkeys[i] = (char*)(last_key(spit+i));
	  }
		if(!i)
			level = ((hierkey_st *)pkeys[i])->level;
		else if(level < ((hierkey_st *)pkeys[i])->level)
			level = ((hierkey_st *)pkeys[i])->level;
		proceed_keys += spit[i].key_count;
	}
	pset = create_sets(count,
#ifndef PTRS_IN_META
								spit->reccmp
#else
								((index_st *)(spit->reccmp))->reccmp
#endif
																		, spit->reclen);
	ids = internal_sets = (set_st *)alloca(sizeof(set_st)*3);
	bzero((caddr_t)internal_sets, sizeof(set_st)*3);
	init_sets(internal_sets, spit->keylen);
	pids = ids+1;
	pkeyset = ids + 2;
	if(progress) kpp = proceed_keys/progress;
	else kpp = proceed_keys+1;
	proceed_keys = 0;
	while(count) {
		maxcount = maxkeyx(pkeys, count, xmax, spit->keycmp);
		phk = (hierkey_st *)(pkeys[*xmax]);
		if(phk->level != level) {
			level = phk->level;
			ptmpset = pids;
			pids = ids;
			ids = ptmpset;
			pids->count = 0;
		}
		pref = get_stref_ex(pkeys[*xmax], spit->keylen, spit->strinfo.immds, spit->nstreams, 0);
		if(maxcount == 1) {
			load_stream(spit+*xmax, psstr);
#ifndef PTRS_IN_META
			move_stream(psstr, ptarget->str, pref);
#else
			create_stream_ex(ptarget->str, pdstr, &(spit->strinfo));
			write_stream(pdstr, psstr->data, pref->size);
#endif
			release_stream(psstr);
		}
		else {
			for(i=0, xcur=xmax; i<maxcount; i++, xcur++) {
				if(!load_stream(spit+*xcur, psstr+i)) {
					if(gb_last_error()) {
						gb_log_error();
						release_streams(psstr, i);
						return 0;
					}
				}
				pset[i].set = psstr[i].data;
				pset[i].count = psstr[i].ref.size / pset[i].reclen;
			}
			create_stream(ptarget, pdstr);
			stream_merge_sets(pdstr, pset, maxcount);
			release_streams(psstr, maxcount);
#ifndef PTRS_IN_META
			attach_stream(pdstr, pref);
			close_stream(pdstr);
			if(gb_last_error()) { 
				gb_log_error();
				return count;
			}
#endif
		}
		if(spit->nstreams == 2 && ptarget->hdr.nstreams == 2) {
#ifndef PTRS_IN_META
			pref = get_stref_ex(pkeys[*xmax], spit->keylen, spit->strinfo.immds, spit->nstreams, 1);
			load_stream_ex((spit+*xmax)->str, pref, psstr, &((spit+*xmax)->strinfo));
			move_stream(psstr, ptarget->str, pref);
			release_stream(psstr);
#else
			load_stream_n(spit+*xmax, psstr, 1);
#endif
		}
		if(ids->count) {
			pidc = (idc_st*)(bsearch(&(phk->id), ids->set, ids->count, sizeof(idc_st), idcrcmp));
			if(pidc) {
				phk->cc = pidc->cc;
				phk->tc = pidc->tc;
			}
			else {
				phk->cc = 0;
				phk->tc = 0;
			}
		}
		npidc = bfindgex(&(phk->pid), pids->set, pids->count, sizeof(idc_st), idcrcmp);
		pidc = (idc_st *)(pids->set + npidc*sizeof(idc_st));
		if((unsigned)npidc == pids->count || pidc->id != phk->pid) {
			if((unsigned)npidc < pids->count)
				memmove(pidc+1, pidc, (pids->count-npidc)*sizeof(idc_st));
			pids->count++;
			pidc->id = phk->pid;
			pidc->cc = 1;
			if(phk->cc == 0) pidc->tc = 1;
			else pidc->tc = phk->tc+1;
		}
		else {
			pidc->cc++;
			if(phk->cc == 0) pidc->tc++;
			else pidc->tc += phk->tc+1;
		}
#ifndef PTRS_IN_META
		store_key(pkeyset, phk);
#else
		store_it_key(spit, phk, ptarget->str, psstr, pdstr);
		close_stream(pdstr);
		release_stream(psstr);
#endif

		for(i=0, done=0; i<maxcount; i++) {
#ifdef PTRS_IN_META
	  index_st *pI= (index_st *)(spit[(xmax[i] -= done)].reccmp);
	  if(pI->kar.cache){
		if(pI->hdr.key_count){
			pI->hdr.key_count--;
			spit[xmax[i]].pkey= pkeys[xmax[i]]= pI->kar.cache + pI->hdr.key_count * pI->hdr.keylen;
		}else{
			spit[xmax[i]].pkey= pkeys[xmax[i]]= 0;
			pI->hdr.key_count= spit[xmax[i]].key_count;
			free(pI->kar.cache);
			pI->kar.cache= 0;
		}
	  }else{
#else
	  {
			xmax[i] -= done;
#endif
			pkeys[xmax[i]] = (char*)(prev_key(spit+xmax[i]));
	  }
			if(!pkeys[xmax[i]]) {
				if(gb_last_error())  { 
					gb_log_error();
					return 0;
				}
				done++; release_iter(spit+xmax[i]);
				if(xmax[i] < count-1) {
					memmove(spit+xmax[i], spit+xmax[i]+1, (count-xmax[i]-1)*sizeof(iter_st));
					memmove(pkeys+xmax[i], pkeys+xmax[i]+1, (count-xmax[i]-1)*sizeof(pchar));
				}
				count--;
			}
		}
		proceed_keys += maxcount;
		if(proceed_keys >= kpp) {
			if(progress) inc_progress();
			proceed_keys -= kpp;
		}
	}
	// pkey = pkeyset->set + pkeyset->reclen*(pkeyset->count-1);
	for(i=pkeyset->count; i; i--) // , pkey -= pkeyset->reclen)
		add_key(ptarget, restore_key(pkeyset, i-1)); // pkey);
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
	free(pdstr);
	free(pset);
	release_sets(internal_sets);
	//close_index(ptarget);
	return 0;
}

int merge_lhindex(index_st *ptarget, iter_st *spit, int count, int progress)
{
	char **pkeys, level;
	// char *pkey; 
	hierkey_st *phk;
	int maxcount, i, npidc, nstr;
	int kpp, proceed_keys;
	int *xmax, *xcur, done;
	stream_st *psstr, *pdstr;
	set_st *pset, *pids, *ids, *ptmpset, *pkeyset, *internal_sets;
	stref_st *pref;
	idc_st *pidc;
#ifdef PTRS_IN_META
	stream_st dstr;
	bzero(&dstr, sizeof(dstr));
	dstr.flags |= SF_NOALLOC;
	progress= 0;
#endif
	level = 0;
	if(!strcmp(ptarget->name, "Class") || !strcmp(ptarget->name, "Adopted")){
		ptarget->hdr.keylen -= sizeof(stref_st) - 4 + ptarget->hdr.strinfo.immds;
		ptarget->hdr.nstreams= 1;
		ptarget->kar.keylen= ptarget->hdr.keylen;
	}
	pdstr = create_streams(count+1);
	psstr = pdstr + 1;
	xmax = (int *)alloca(count*sizeof(int));
	pkeys = (char **)alloca(count*sizeof(pchar));
	for(i=0, proceed_keys=0; i<count; i++) {
#ifdef PTRS_IN_META
	  index_st *pI= (index_st *)(spit[i].reccmp);
	  if(pI->kar.cache){
		if(pI->hdr.key_count){
			pI->hdr.key_count--;
			spit[i].pkey= pkeys[i]= pI->kar.cache + pI->hdr.key_count * pI->hdr.keylen;
		}else
			pkeys[i]= 0;
	  }else{
#else
	  {
#endif
		pkeys[i] = (char*)(last_key(spit+i));
	  }
		if(!i)
			level = ((hierkey_st *)pkeys[i])->level;
		else if(level < ((hierkey_st *)pkeys[i])->level)
			level = ((hierkey_st *)pkeys[i])->level;
		proceed_keys += spit[i].key_count;
	}
	pset = create_sets(count,
#ifndef PTRS_IN_META
								spit->reccmp
#else
								((index_st *)(spit->reccmp))->reccmp
#endif
																		, spit->reclen);
	ids = internal_sets = (set_st *)alloca(sizeof(set_st)*3);
	bzero((caddr_t)internal_sets, sizeof(set_st)*3);
	init_sets(internal_sets, spit->keylen);
	pids = ids+1;
	pkeyset = ids + 2;
	if(progress) kpp = proceed_keys/progress;
	else kpp = proceed_keys+1;
	proceed_keys = 0;
	while(count) {
		maxcount = maxkeyx(pkeys, count, xmax, spit->keycmp);
		phk = (hierkey_st *)(pkeys[*xmax]);
		if(phk->level != level) {
			level = phk->level;
			ptmpset = pids;
			pids = ids;
			ids = ptmpset;
			pids->count = 0;
		}
		if(maxcount == 1) {
#ifndef PTRS_IN_META
			for(nstr=0; nstr<ptarget->hdr.nstreams; nstr++) {
				pref = get_stref(spit+*xmax, nstr);
				load_stream_n(spit+*xmax, psstr, nstr);
				move_stream(psstr, ptarget->str, pref);
				release_stream(psstr);
			}
#else
			load_stream(spit+*xmax, psstr);
			create_stream_ex(ptarget->str, pdstr, &(spit->strinfo));
			write_stream(pdstr, psstr->data, psstr->ref.size);
			release_stream(psstr);
#endif
		}
		else {
			pref = get_stref(spit+*xmax, 0);
			for(i=0, xcur=xmax; i<maxcount; i++, xcur++) {
				if(!load_stream(spit+*xcur, psstr+i)) {
					if(gb_last_error()) {
						gb_log_error();
						release_streams(psstr, i);
						return 0;
					}
				}
				pset[i].set = psstr[i].data;
				pset[i].count = psstr[i].ref.size / pset[i].reclen;
			}
			create_stream(ptarget, pdstr);
			stream_merge_sets(pdstr, pset, maxcount);
			release_streams(psstr, maxcount);
#ifndef PTRS_IN_META
			attach_stream(pdstr, pref);
			close_stream(pdstr);
			if(gb_last_error()) { 
				gb_log_error();
				return count;
			}
#endif
		if(ptarget->hdr.nstreams == 1)
			;//bzero(pref,sizeof(*pref));
		else{
			// Merge 2nd streams...
			pref = get_stref(spit+*xmax, 1);
			for(i=0, xcur=xmax; i<maxcount; i++, xcur++) {
				if(!load_stream_n(spit+*xcur, psstr+i, 1)) {
					if(gb_last_error()) {
						gb_log_error();
						release_streams(psstr, i);
						return 0;
					}
				}
				pset[i].set = psstr[i].data;
				pset[i].count = psstr[i].ref.size;
			}
#ifndef PTRS_IN_META
			create_stream(ptarget, pdstr);
			stream_merge_string_sets(pdstr, pset, maxcount);
			release_streams(psstr, maxcount);
			attach_stream(pdstr, pref);
			close_stream(pdstr);
			if(gb_last_error()) { 
				gb_log_error();
				return count;
			}
#else
			create_stream(ptarget, &dstr);
			stream_merge_string_sets(&dstr, pset, maxcount);
			release_streams(psstr, maxcount);
#endif
			//...
			}
		}
		if(ids->count) {
			pidc = (idc_st*)(bsearch(&(phk->id), ids->set, ids->count, sizeof(idc_st), idcrcmp));
			if(pidc) {
				phk->cc = pidc->cc;
				phk->tc = pidc->tc;
			}
			else {
				phk->cc = 0;
				phk->tc = 0;
			}
		}
		npidc = bfindgex(&(phk->pid), pids->set, pids->count, sizeof(idc_st), idcrcmp);
		pidc = (idc_st *)(pids->set + npidc*sizeof(idc_st));
		if(npidc == (int)pids->count || pidc->id != phk->pid) {
			if(npidc < (int)pids->count)
				memmove(pidc+1, pidc, (pids->count-npidc)*sizeof(idc_st));
			pids->count++;
			pidc->id = phk->pid;
			pidc->cc = 1;
			if(phk->cc == 0) pidc->tc = 1;
			else pidc->tc = phk->tc+1;
		}
		else {
			pidc->cc++;
			if(phk->cc == 0) pidc->tc++;
			else pidc->tc += phk->tc+1;
		}
#ifdef PTRS_IN_META
		if(psstr->ref.size < 1 && maxcount == 1){
			load_stream_n(spit+*xmax, psstr, 1);
			store_it_key(spit, phk, ptarget->str, psstr, pdstr);
		}else{
			store_it_key(spit, phk, ptarget->str, &dstr, pdstr);
			close_stream(&dstr);
		}
		release_stream(psstr);
		close_stream(pdstr);
#else
		store_key(pkeyset, phk);
#endif
		for(i=0, done=0; i<maxcount; i++) {
#ifdef PTRS_IN_META
	  index_st *pI= (index_st *)(spit[(xmax[i] -= done)].reccmp);
	  if(pI->kar.cache){
		if(pI->hdr.key_count){
			pI->hdr.key_count--;
			spit[xmax[i]].pkey= pkeys[xmax[i]]= pI->kar.cache + pI->hdr.key_count * pI->hdr.keylen;
		}else{
			spit[xmax[i]].pkey= pkeys[xmax[i]]= 0;
			pI->hdr.key_count= spit[xmax[i]].key_count;
			free(pI->kar.cache);
			pI->kar.cache= 0;
		}
	  }else{
#else
	  {
			xmax[i] -= done;
#endif
			pkeys[xmax[i]] = (char*)(prev_key(spit+xmax[i]));
	  }
			if(!pkeys[xmax[i]]) {
				if(gb_last_error())  { 
					gb_log_error();
					return 0;
				}
				done++; release_iter(spit+xmax[i]);
				if(xmax[i] < count-1) {
					memmove(spit+xmax[i], spit+xmax[i]+1, (count-xmax[i]-1)*sizeof(iter_st));
					memmove(pkeys+xmax[i], pkeys+xmax[i]+1, (count-xmax[i]-1)*sizeof(pchar));
				}
				count--;
			}
		}
		proceed_keys += maxcount;
		if(proceed_keys >= kpp) {
			if(progress) inc_progress();
			proceed_keys -= kpp;
		}
	}
	// pkey = pkeyset->set + pkeyset->reclen*(pkeyset->count-1);
	for(i=pkeyset->count; i; i--) // , pkey -= pkeyset->reclen)
		add_key(ptarget, restore_key(pkeyset, i-1)); // pkey);
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
#ifdef PTRS_IN_META
	dstr.flags &= ~SF_NOALLOC;
	close_stream(&dstr);
#endif
	free(pdstr);
	free(pset);
	release_sets(internal_sets);
	//close_index(ptarget);
	return 0;
}

int maxkeyx(char **pkeys, int count, int *xmax, cmpfunc_ft keycmp)
{
	int i, maxcount, unmatch;
	char *pmax;

	*xmax = 0;
	pmax = pkeys[0];
	maxcount = 1;
	for(i=1; i<count; i++) {
		unmatch = (*keycmp)(pkeys[i], pmax);
		if(unmatch > 0) {
			maxcount = 1;
			*xmax = i;
			pmax = pkeys[i];
		}
		else if (unmatch == 0) {
			xmax[maxcount] = i;
			maxcount++;
		}
	}
	return maxcount;
}

static set_st *init_sets(set_st *pset, int reclen)
{
	int i;

	for(i=0; i<2; i++) {
		pset[i].dtype = 0;
		pset[i].rcmp = idcrcmp;
		pset[i].reclen = sizeof(idc_st);
		pset[i].set = (char *)calloc(0x40000, sizeof(idc_st));
		pset[i].count = 0;
	}
	pset += 2;
	pset->reclen = reclen;
	pset->count = 0;
	pset->rcmp = 0;
	pset->dtype = 0xFFFF;
	pset->set = (char *)calloc(0xf000, reclen);
	if(tmpname) {
		htmpfile = c_io_open(tmpname, ACE_OS_O_RDWR | ACE_OS_O_CREAT | ACE_OS_O_TRUNC | ACE_OS_O_BINARY);
	}
	else {
		tmpname = strdup(tmptempl);
		htmpfile = mkstemp(tmpname);
	}
	return pset;
}

static void release_sets(set_st *pset)
{
	int i;

	for(i=0; i<3; i++) free(pset[i].set);
	c_io_close(htmpfile);
	ace_os_unlink(tmpname);
	htmpfile = -1;
}

static void store_key(set_st *pset, void *buf)
{
	char *set;

	set = pset->set + (pset->count & 0x3FFF)*pset->reclen;
	memcpy(set, buf, pset->reclen);
	pset->count++;
	if(!(pset->count & 0x3FFF)) {
		c_io_write(htmpfile, pset->set, 0x4000*pset->reclen);
	}
}

static char *restore_key(set_st *pset, int ind)
{
	int i;

	i = ind & 0x3FFF;
	if(i == 0x3FFF) {
		c_io_lseek(htmpfile, (ind & ~0x00003FFF)*pset->reclen, ACE_OS_SEEK_SET);
		c_io_read(htmpfile, pset->set, 0x4000*pset->reclen);
	}
	return pset->set + i*pset->reclen;
}

static int pstrcmp(const void *p1, const void *p2)
{
	return strcmp(*((char **)p1), *((char **)p2));
}

static void stream_merge_string_sets(stream_st *pdstr, set_st *pset, int count)
{
	int *xmin, minc, len, i, ix, del, acount;
	char **pstrings;
	set_st *pstringset;
	void **palloc;
	char *s;

	acount = count;
	xmin = (int *)alloca(count*sizeof(int));
	palloc = (void **)malloc(count * sizeof(void *));
	for(i=0, del=0; i<count; i++) {
		for(ix=xmin[i]=0; ix < (int)pset[i].count; xmin[i]++, ix+=strlen(pset[i].set+ix)+1);
		if(del < xmin[i]) del = xmin[i];
	}
	pstringset = (set_st *)alloca(count*sizeof(set_st));
	bzero((caddr_t)pstringset, count*sizeof(set_st));
	for(i=0; i<count; i++) {
		palloc[i] = ml_malloc(xmin[i]*sizeof(char *));
		pstrings = (char **)palloc[i];
		for(ix=0; ix < (int)pset[i].count; ix+=strlen(pset[i].set+ix)+1) {
			pstrings[pstringset[i].count] = pset[i].set+ix;
			pstringset[i].count++;
		}
		qsort(pstrings, xmin[i], sizeof(char *), (cmpfunc_ft)pstrcmp);
		pstringset[i].count = xmin[i];
		pstringset[i].set = (char *)palloc[i];
		xmin[i] = 0;
	}

	pstrings = (char **)alloca(count*sizeof(char *));
	for(i=0; i<count; i++)
		pstrings[i] = *((char **)pstringset[i].set);
	while(count > 1) {
		del = 0;
		minc = minkeyx(pstrings, count, xmin, (cmpfunc_ft)strcmp);
		len = strlen(pstrings[*xmin]) + 1;
		write_stream(pdstr, pstrings[*xmin], len);
		for(i=0; i<minc; i++) {
			ix = xmin[i] - del;
			pstringset[ix].count--;
			pstringset[ix].set += sizeof(char *);
			if(!pstringset[ix].count) {
				if(ix < count-1) {
					memmove(pstringset+ix, pstringset+ix+1, (count-1-ix)*sizeof(set_st));
					memmove(pstrings+ix, pstrings+ix+1, (count-1-ix)*sizeof(char *));
				}
				count--;
				del++;
			}
			else pstrings[ix] = *((char **)pstringset[ix].set);
		}
	}
	
	if (count) {
		while(pstringset[0].count) {
			s = *((char **)pstringset[0].set);
			write_stream(pdstr, s, strlen(s)+1);
			pstringset[0].count--;
			pstringset[0].set += sizeof(char *);
		}
	}
	for (i=0; i < acount; i++) free(palloc[i]);
}














