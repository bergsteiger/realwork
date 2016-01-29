#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "../../../libs/mrglib/src/log.h"

#include "toys.h"

#include "indhlp.h"
#include "progress.h"

extern void otherIncProgress(void *);

#ifdef PTRS_IN_META
	extern void attach_stream_only(stream_st *pstr, stref_st *pref);
#else
	#define attach_stream_only attach_stream
#endif

int make_hindex(void *pCntx, index_st *pdest, int count, index_st *psrc, set_st *doclist)
{
	iter_st *pit, *plev;
	// set_st *pkeys;
	char *pkey, *plevkey;
	set_st *pstrset, *pnum, *pids, *pnids, *pcids;
	char level;
	u_int32_t key_count;
	stream_st *pdstr, *psstr;
	int i, j, lc;
	stref_st *pref;
	hkeyref_st *pkeynum;
	// hierkey_st *phk;
	int kpp, proceed;

	proceed = psrc->hdr.key_count;
	kpp = get_index_weight(psrc->name);
	kpp = (kpp) ? proceed / kpp : proceed+1;
	proceed = 0;
	flog("Processing index: \"%s\"...\t", psrc->name);
	pit = (iter_st *)alloca(sizeof(iter_st));
	plev = (iter_st *)alloca(sizeof(iter_st));
	init_iter(psrc, pit);
	init_iter(psrc, plev);
	key_count = psrc->hdr.key_count;
	psstr = (stream_st *)alloca(sizeof(stream_st)<<1);
	bzero((caddr_t)psstr, sizeof(stream_st)<<1);
	pdstr = psstr+1;
	pdstr->flags |= SF_NOALLOC;
	pids = (set_st *)calloc(count*3, sizeof(set_st));
	pnids = pids + count;
	pnum = pnids + count;
	pstrset = (set_st *)alloca(sizeof(set_st));
	bzero((caddr_t)pstrset, sizeof(set_st));
	pstrset->reclen = pit->reclen;
	pstrset->rcmp = psrc->reccmp;
	for(i=0; i<count; i++) {
		pnum[i].reclen = sizeof(hkeyref_st);
		//pnum[i].set = ml_malloc(key_count*sizeof(hkeyref_st)); ///!!!
		pnum[i].set = malloc(key_count*sizeof(hkeyref_st));
		memset(pnum[i].set, 0, key_count*sizeof(hkeyref_st));
		pids[i].reclen = pnids[i].reclen = sizeof(idc_st);
	}
	plevkey = last_key(plev);
	level = *plevkey;
	for(lc=0; (unsigned)lc<key_count && level == *plevkey; lc++, plevkey=prev_key(plev));
	for(j=0; j<count; j++){
		//pnids[j].set = (char *)ml_malloc(lc*sizeof(idc_st)); ///!!!
		pnids[j].set = (char *)malloc(lc*sizeof(idc_st));
		memset(pnids[j].set, 0, lc*sizeof(idc_st));
	}
	for(i=0, pkey=last_key(pit); (unsigned)i<key_count; i++, pkey=prev_key(pit)) {
		if(level != *pkey) {
			level = *pkey;
			// locate_key(plev, pkey); // Because of previous plev move during level counting
			for(lc=0; (unsigned)lc<key_count-i && level == *plevkey; lc++)
				plevkey = prev_key(plev);
			pcids = pids;
			pids = pnids;
			pnids = pcids;
			for(j=0; j<count; j++) {
				if(pnids[j].set) free(pnids[j].set);
				pnids[j].count = 0;
				//pnids[j].set = (char *)ml_malloc(lc*sizeof(idc_st));
				pnids[j].set = (char *)malloc(lc*sizeof(idc_st));
				memset(pnids[j].set, 0, lc*sizeof(idc_st));
		//qsort(pids[j].set, pids[j].count, sizeof(idc_st), longcmp);
			}
		}
		pref = get_stref(pit, 0); // (stref_st *)(pkey+pit->ref_offs);
		if(!pref->size) continue;
		load_stream_ex(pit->str, pref, psstr, &(pit->strinfo));
		pstrset->count = pref->size/pit->reclen;
		pstrset->set = psstr->data;
		for(j=0; j<count; j++) {
			create_stream(pdest+j, pdstr);
			if(stream_isect_sets(pdstr, pstrset, doclist+j)) {
				pkeynum = (hkeyref_st *)(pnum[j].set + pnum[j].count*pnum[j].reclen);
				attach_stream_only(pdstr, &(pkeynum->stref));
				close_stream(pdstr);
				pkeynum->num = key_count-i-1;
				reg_key((hierkey_st *)pkey, pkeynum, pnids+j, pids+j);
				pnum[j].count++;
			}
			else close_stream(pdstr);
		}
		release_stream(psstr);
		proceed++;
		if(proceed == kpp) {
			otherIncProgress(pCntx);
			proceed = 0;
		}
	}

	fill_indexes(pit, pdest, pnum, count);
	for(i=0; i<count; i++) free(pnum[i].set);

/*
	for(i=0; i<count; i++) {
		if(pnids[i].set) free(pnids[i].set);
		if(pids[i].set) free(pids[i].set);
		pkeynum = (hkeyref_st *)(pnum[i].set + (pnum[i].count-1)*pnum[i].reclen);
		for(j=pnum[i].count; j; j--, pkeynum--) {
			pkey = pkeys->set + pit->keylen*pkeynum->num;
			pref = get_stref(pit, 0); // (stref_st *)(pkey + pit->ref_offs);
			pref->size = pkeynum->stref.size;
			memcpy(&(pref->pos), &(pkeynum->stref.pos), pit->immds);
			//pref->pos = pkeynum->stref.pos;
			phk = (hierkey_st *)pkey;
			phk->cc = pkeynum->cc;
			phk->tc = pkeynum->tc;
			add_key(pdest+i, pkey);
		}
		free(pnum[i].set);
		//pdest[i].hdr.last_id = psrc->hdr.last_id;
	}
*/
	// free(pkeys->set);
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
	flog("Done.\n");
	hide_message();
	return 0;
}

