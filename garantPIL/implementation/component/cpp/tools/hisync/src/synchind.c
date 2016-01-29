#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <stdlib.h>

#include <strings.h>
#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"

typedef void *pointer_type;
typedef struct {
	u_int32_t id;
	u_int32_t newid;
} hkmap_st;

static void collect_keys(set_st *plkeys, int count, int level, iter_st *pit, iter_st *ptmpit);
static int check_finish(iter_st *pit, int count, int *done);
static void store_keys(set_st *pset, int count, index_st **ppind);
static u_int32_t remap_keys(set_st *pkeyset, int count, set_st *cmap, u_int32_t lastid, cmpfunc_ft);
static int minkey(set_st *pset, int count, int *mins);

int sync_indexes(index_st *pind, int count, index_st *poutind)
{
	set_st *plevkeys, *cmap;
	iter_st *pit, *plcit;
	index_st **ppoind;
	int i, level, ndone, *done, cnt;
	u_int32_t lastid;

	plevkeys = (set_st *)malloc(count*sizeof(set_st));
	bzero((char *)plevkeys, count*sizeof(set_st));
	pit = (iter_st *)malloc((count<<1)*sizeof(iter_st));
	bzero((char *)pit, (count<<1)*sizeof(iter_st));
	plcit = pit + count;
	cmap = (set_st *)malloc(count*sizeof(set_st));
	bzero((char *)cmap, count*sizeof(set_st));
	ppoind = (index_st **)malloc(count*sizeof(pointer_type));
	bzero((char *)ppoind, count*sizeof(pointer_type));
	done = (int *)alloca(count*sizeof(int));
	for(i=0; i<count; i++) {
		init_iter(pind+i, pit+i);
		first_key(pit+i);
		init_iter(pind+i, plcit+i);
		if (poutind[i].hdr.nstreams == 2
				&&									(	!strcmp(poutind[i].name, "Territory")
															|| !strcmp(poutind[i].name, "DocKind") 
															|| !strcmp(poutind[i].name, "Adopted")
															|| !strcmp(poutind[i].name, "Class")))
		{
			poutind[i].hdr.keylen -= sizeof(stref_st) - 4 + poutind[i].hdr.strinfo.immds;
			poutind[i].hdr.nstreams= 1;
			poutind[i].kar.keylen= poutind[i].hdr.keylen;
		}
		ppoind[i] = poutind+i;
		plevkeys[i].reclen = pit[i].keylen;
		cmap[i].reclen = sizeof(hkmap_st);
	}
	cnt = count;
	ndone = check_finish(pit, count, done);
	for (i=0; i<ndone; i++) {
		done[i] -= i;
		release_iter(pit+done[i]);
		release_iter(plcit+done[i]);
		if(cmap[done[i]].set) {
			free(cmap[done[i]].set);
			cmap[done[i]].set = 0;
		}
		if(plevkeys[i].set) {
			free(plevkeys[i].set);
			plevkeys[i].set = 0;
		}
		if (done[i] < cnt-1) {
			memmove(ppoind+done[i], ppoind+done[i]+1, (cnt-1-done[i])*sizeof(pointer_type));
			memmove(pit+done[i], pit+done[i]+1, (cnt-1-done[i])*sizeof(iter_st));
			memmove(plcit+done[i], plcit+done[i]+1, (cnt-1-done[i])*sizeof(iter_st));
			memmove(cmap+done[i], cmap+done[i]+1, (cnt-1-done[i])*sizeof(set_st));
			memmove(plevkeys+done[i], plevkeys+done[i]+1, (cnt-1-done[i])*sizeof(set_st));
		}
		cnt--;
	}
	level = 0; lastid = 1; 
	while(cnt) {
		collect_keys(plevkeys, cnt, level, pit, plcit);
		lastid = remap_keys(plevkeys, cnt, cmap, lastid, pind->keycmp);
		if (!lastid) return 0;
		store_keys(plevkeys, cnt, ppoind);
		ndone = check_finish(pit, cnt, done);
		for (i=0; i<ndone; i++) {
			done[i] -= i;
			release_iter(pit+done[i]);
			release_iter(plcit+done[i]);
			if(cmap[done[i]].set) {
				free(cmap[done[i]].set);
				cmap[done[i]].set = 0;
			}
			if(plevkeys[i].set) {
				free(plevkeys[i].set);
				plevkeys[i].set = 0;
			}
			if (done[i] < cnt-1) {
				memmove(ppoind+done[i], ppoind+done[i]+1, (cnt-1-done[i])*sizeof(pointer_type));
				memmove(pit+done[i], pit+done[i]+1, (cnt-1-done[i])*sizeof(iter_st));
				memmove(plcit+done[i], plcit+done[i]+1, (cnt-1-done[i])*sizeof(iter_st));
				memmove(cmap+done[i], cmap+done[i]+1, (cnt-1-done[i])*sizeof(set_st));
				memmove(plevkeys+done[i], plevkeys+done[i]+1, (cnt-1-done[i])*sizeof(set_st));
			}
			else {
			}
			cnt--;
		}
		level++;
	}
	for (i=0; i<count; i++)
		poutind[i].hdr.last_id = lastid;
	free(cmap); free(plevkeys); free(ppoind);
	return 1;
}

static void collect_keys(set_st *plkeys, int count, int level, iter_st *pit, iter_st *ptmpit)
{
	int i, j, lc;
	hierkey_st hk, *phk;
	char *pkey;

	bzero((char *)&hk, sizeof(hierkey_st));
	hk.level = level;
	for(i=0; i<count; i++) {
		// flog("Collecting keys for source %d\n", i);
		locate_key(ptmpit+i, &hk);
		phk=(hierkey_st *)(ptmpit[i].pkey); lc=0;
		while (phk && phk->level==level) {
			lc++;
			phk = (hierkey_st *)next_key(ptmpit+i);
		}
		if(plkeys[i].set) {
			free(plkeys[i].set);
			plkeys[i].set = 0;
		}
		plkeys[i].count = lc;
		plkeys[i].set = (char *)malloc(lc*pit->keylen);
		locate_key(pit+i, &hk);
		pkey = plkeys[i].set;
		for (phk=(hierkey_st *)(pit[i].pkey), j=0; j<lc; j++) {
			memcpy(pkey, phk, pit[i].keylen);
			pkey += pit[i].keylen;
			phk=(hierkey_st *)next_key(pit+i);
		}
		// flog("Collected %d keys on level %d\n", lc, level);
	}
}

static u_int32_t remap_keys(set_st *pkeyset, int count, set_st *cmap, u_int32_t lastid, cmpfunc_ft key_cmp)
{
	u_int32_t oldpid, newpid;
	int i, j, minc, *minind;
	set_st *tmpkeys, *pset, *map;
	hkmap_st *mapent;
	char *pkey;
	hierkey_st *phk;

	minind = (int *)alloca(count*sizeof(int));
	for (i=0; i<count; i++) {
		oldpid = 0;
		pkey = pkeyset[i].set;
		for(j=0; j < (int)pkeyset[i].count; j++, pkey+=pkeyset->reclen) {
			phk = (hierkey_st *)pkey;
			if (phk->level == 0) continue;
			if (phk->pid != oldpid) {
				oldpid = phk->pid;
				mapent = bsearch(&oldpid, cmap[i].set, cmap[i].count, sizeof(hkmap_st), longcmp);
				if(mapent) newpid = mapent->newid;
				else {
					flog("\nError: no mapping for key in source %d at level %d!\n", i, (int)phk->level);
					flog("(%d, id=%d, pid=%d, text=\"%s\")\n", (int )(phk->level), phk->id, phk->pid, (char *)(phk->key));
					return 0;
				}
			}
			phk->pid = newpid;
		}
		qsort(pkeyset[i].set, pkeyset[i].count, pkeyset[i].reclen, key_cmp);
	}
	for(i=0; i<count; i++) {
		if(cmap[i].set) {
			free(cmap[i].set);
			cmap[i].set = 0;
		}
		cmap[i].count = 0; 
		cmap[i].set = malloc(pkeyset[i].count*sizeof(hkmap_st));
	}
	tmpkeys = (set_st *)malloc(count*sizeof(set_st));
	memcpy(tmpkeys, pkeyset, count*sizeof(set_st));
	for(minc=minkey(tmpkeys, count, minind); minc; minc=minkey(tmpkeys, count, minind)) {
		for(j=0; j<minc; j++) {
			pset = tmpkeys + minind[j];
			map = cmap + minind[j];
			mapent = (hkmap_st *)(map->set + map->count*sizeof(hkmap_st));
			phk = (hierkey_st *)(pset->set);
			mapent->id = phk->id;
			mapent->newid = lastid;
			phk->id = lastid;
			pset->count--;
			pset->set += pset->reclen;
			map->count++;
		}
		lastid++;
	}
	for(i=0; i<count; i++)
		qsort(cmap[i].set, cmap[i].count, sizeof(hkmap_st), longcmp);
	return lastid;
}

static void store_keys(set_st *pset, int count, index_st **ppind)
{
	int i, j;
	char *pkey;

	for(i=0; i<count; i++) {
		for(j=0, pkey=pset[i].set; j < (int)pset[i].count; j++, pkey+=pset[i].reclen) {
#ifndef PTRS_IN_META
			add_key(ppind[i], pkey);
#else
			memcpy(ppind[i]->kar.cache + (ppind[i]->kar.count * (*ppind)->hdr.keylen), pkey, (*ppind)->hdr.keylen);
			ppind[i]->kar.count++;
#endif
		}
		if (pset[i].set) {
			free(pset[i].set);
			pset[i].set = 0;
		}
	}
}

static int check_finish(iter_st *pit, int count, int *done)
{
	int i, ndone;

	ndone = 0;
	for(i=0; i<count; i++) {
		if (!(pit[i].pkey)) {
			done[ndone] = i;
			ndone++;
		}
	}
	return ndone;
}

static int minkey(set_st *pset, int count, int *mins)
{
	int i, minc, cmp;
	char *minkey;

	for(i=0; i<count && !pset[i].count; i++);
	if (i == count) return 0;
	minc = 1; *mins = i;
	minkey = pset[i].set;
	for(i++; i<count; i++) {
		while(i<count && !pset[i].count) i++;
		if (i == count) break;
		cmp = hindcmp(minkey, pset[i].set);
		if (cmp > 0) {
			minkey = pset[i].set;
			minc = 1;
			*mins = i;
		}
		else if (cmp == 0) {
			mins[minc] = i;
			minc++;
		}
	}
	return minc;
}


