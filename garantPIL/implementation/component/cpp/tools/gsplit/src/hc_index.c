#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "../../../libs/mrglib/src/log.h"

#include "toys.h"

#include "hc_index.h"

#include "indhlp.h"
#include "progress.h"

static void filter_string_stream(stream_st *pdstr, stream_st *psstr, set_st *pmap, int j, set_st *primary);
extern void otherIncProgress(void *);

#ifdef PTRS_IN_META
	extern void attach_stream_only(stream_st *pstr, stref_st *pref);
	extern void move_stream_only(stream_st *pstr, streamfile_st *pdest, stref_st *pref);
#else
	#define attach_stream_only attach_stream
	#define move_stream_only move_stream
#endif

int make_base_hindex(void *pCntx, index_st *pdest, int count, index_st *psrc, set_st *doclist, set_st *indexes)
{
	iter_st *pit;
	char *pkey;
	set_st *pstrset, *pnum, *pids, *pnids, *pcids;
	char level;
	u_int32_t key_count, *lev_count;
	stream_st *pdstr, *psstr, *psstr2;
	int i, j;
	stref_st *pref, *pref2;
	hkeyref_st *pkeynum;
	int kpp, proceed;
	hkey_item *pitem;

	proceed = psrc->hdr.key_count;
	kpp = get_index_weight(psrc->name);
	kpp = (kpp) ? proceed / kpp : proceed+1;
	proceed = 0;
	flog("Processing index: \"%s\"...\t", psrc->name);
	pit = (iter_st *)alloca(sizeof(iter_st));
	init_iter(psrc, pit);
	key_count = psrc->hdr.key_count;
	psstr = (stream_st *)alloca(sizeof(stream_st)*3);
	bzero((caddr_t)psstr, sizeof(stream_st)*3);
	psstr2 = psstr+1;
	psstr->flags |= SF_USELOCAL;
	psstr2->flags |= SF_USELOCAL;
	pdstr = psstr+2;
	pdstr->flags |= SF_NOALLOC;
	pids = (set_st *)calloc(count*3, sizeof(set_st));
	pnids = pids + count;
	pnum = pnids + count;
	pstrset = (set_st *)alloca(sizeof(set_st));
	bzero((caddr_t)pstrset, sizeof(set_st));
	pstrset->reclen = pit->reclen;
	pstrset->rcmp = pit->reccmp;
	for(i=0; i<count; i++) {
		pnum[i].reclen = sizeof(hkeyref_st);
		//pnum[i].set = ml_malloc(key_count*sizeof(hkeyref_st)); ///!!!
		pnum[i].set = malloc(key_count*sizeof(hkeyref_st));
		memset(pnum[i].set, 0, key_count*sizeof(hkeyref_st));
		pids[i].reclen = pnids[i].reclen = sizeof(idc_st);
	}
	pkey=last_key(pit);
	level = *pkey;
	lev_count = (u_int32_t *)alloca((level+1)<<2);
	init_keys_map((set_st *)indexes, pit->key_count, pit->reclen, (u_int16_t)count);
	collect_string_keys(indexes, pit, lev_count);
	for(j=0; j<count; j++){
		//pnids[j].set = (char *)ml_malloc(lev_count[level]*sizeof(idc_st)); ///!!!
		pnids[j].set = (char *)malloc(lev_count[level]*sizeof(idc_st));
		memset(pnids[j].set, 0, lev_count[level]*sizeof(idc_st));
	}
	pkey=last_key(pit);
	for(i=0; (unsigned)i<key_count; i++, pkey=prev_key(pit)) {
		if(level != *pkey) {
			level = *pkey;
			pcids = pids;
			pids = pnids;
			pnids = pcids;
			for(j=0; j<count; j++) {
				if(pnids[j].set) free(pnids[j].set);
				pnids[j].count = 0;
				//pnids[j].set = (char *)ml_malloc(lev_count[level]*sizeof(idc_st)); ///!!!
				pnids[j].set = (char *)malloc(lev_count[level]*sizeof(idc_st));
				memset(pnids[j].set, 0, lev_count[level]*sizeof(idc_st));
				//qsort(pids[j].set, pids[j].count, sizeof(idc_st), longcmp);
			}
		}
		pref = pref2 = get_stref(pit, 0);
		if(!pref->size) continue;
		load_stream_ex(pit->str, pref, psstr, &(pit->strinfo));
		if(pdest->hdr.nstreams > 1){
			pref2 = get_stref(pit, 1);
			load_stream_ex(pit->str, pref2, psstr2, &(pit->strinfo));
		}
		pstrset->count = pref->size/pit->reclen;
		pstrset->set = psstr->data;
		pitem = (hkey_item *)bsearch(&(((hierkey_st *)pkey)->id), 
				indexes->set, indexes->count, indexes->reclen, longcmp);
		for(j=0; j<count; j++) {
			create_stream(pdest+j, pdstr);
			if(stream_isect_sets(pdstr, pstrset, doclist+j)) {
				pkeynum = (hkeyref_st *)(pnum[j].set + pnum[j].count*pnum[j].reclen);
				extract_stream_data(pitem->data+j, pdstr);
				attach_stream_only(pdstr, &(pkeynum->stref));
				close_stream(pdstr);
				if(pdest->hdr.nstreams > 1)
					move_stream_only(psstr2, pdest[j].str, &(pkeynum->stref2));
				pkeynum->num = key_count-i-1;
				reg_key((hierkey_st *)pkey, pkeynum, pnids+j, pids+j);
				pnum[j].count++;
			}
			else close_stream(pdstr);
		}
		release_stream(psstr);
		if(pit->nstreams > 1) release_stream(psstr2);
		proceed++;
		if(proceed == kpp) {
			otherIncProgress(pCntx);
			proceed = 0;
		}
	}

	fill_indexes(pit, pdest, pnum, count);
	for(i=0; i<count; i++) free(pnum[i].set);

	psstr->flags |= SF_FREELOCAL;
	release_stream(psstr);
	psstr2->flags |= SF_FREELOCAL;
	release_stream(psstr2);
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
	sort_string_keys_by_name(indexes);
	flog("Done.\n");
	hide_message();
	return 0;
}

int make_linked_hindex(void *pCntx, index_st *pdest, int count, index_st *psrc, set_st *doclist, set_st *indexes)
{
	iter_st *pit, *plev;
	// set_st *pkeys;
	char *pkey, *plevkey;
	set_st *pstrset, *pnum, *pids, *pnids, *pcids;
	char level;
	u_int32_t key_count;
	stream_st *pdstr, *psstr, *psstr2;
	int i, j, lc;
	stref_st *pref, *pref2;
	hkeyref_st *pkeynum;
	hierkey_st *phk;
	int kpp, proceed;
	set_st primary;

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
	psstr = (stream_st *)alloca(sizeof(stream_st)*3);
	bzero((caddr_t)psstr, sizeof(stream_st)*3);
	psstr2 = psstr+1;
	psstr->flags |= SF_USELOCAL;
	psstr2->flags |= SF_USELOCAL;
	pdstr = psstr+2;
	pdstr->flags |= SF_NOALLOC;
	pids = (set_st *)calloc(count*3, sizeof(set_st));
	pnids = pids + count;
	pnum = pnids + count;
	pstrset = (set_st *)alloca(sizeof(set_st));
	bzero((caddr_t)pstrset, sizeof(set_st));
	pstrset->reclen = pit->reclen;
	pstrset->rcmp = psrc->reccmp;
	primary.reclen = pit->reclen;
	primary.rcmp = psrc->reccmp;
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
				//pnids[j].set = (char *)ml_malloc(lc*sizeof(idc_st)); ///!!!
				pnids[j].set = (char *)malloc(lc*sizeof(idc_st));
				memset(pnids[j].set, 0, lc*sizeof(idc_st));
				//qsort(pids[j].set, pids[j].count, sizeof(idc_st), longcmp);
			}
		}
		pref = pref2 = get_stref(pit, 0);
		if(!pref->size) continue;
		phk = (hierkey_st *)(pit->pkey);
		load_stream_ex(pit->str, pref, psstr, &(pit->strinfo));
		if(pdest->hdr.nstreams > 1){
			pref2 = get_stref(pit, 1);
			load_stream_ex(pit->str, pref2, psstr2, &(pit->strinfo));
		}
		pstrset->count = pref->size/pit->reclen;
		pstrset->set = psstr->data;
		for(j=0; j<count; j++) {
			create_stream(pdest+j, pdstr);
			if(stream_isect_sets(pdstr, pstrset, doclist+j)) {
				pkeynum = (hkeyref_st *)(pnum[j].set + pnum[j].count*pnum[j].reclen);
				extract_stream_data(&primary, pdstr);
				attach_stream_only(pdstr, &(pkeynum->stref));
				close_stream(pdstr);
				if(pdest->hdr.nstreams > 1){
					create_stream(pdest+j, pdstr);
					filter_string_stream(pdstr, psstr2, indexes, j, &primary);
					attach_stream_only(pdstr, &(pkeynum->stref2));
					close_stream(pdstr);
				}
				free(primary.set);
				pkeynum->num = key_count-i-1;
				reg_key((hierkey_st *)pkey, pkeynum, pnids+j, pids+j);
				pnum[j].count++;
			}
			else close_stream(pdstr);
		}
		release_stream(psstr);
		release_stream(psstr2);
		proceed++;
		if(proceed == kpp) {
			otherIncProgress(pCntx);
			proceed = 0;
		}
	}

	fill_indexes(pit, pdest, pnum, count);
	for(i=0; i<count; i++) free(pnum[i].set);

	psstr->flags |= SF_FREELOCAL;
	release_stream(psstr);
	psstr2->flags |= SF_FREELOCAL;
	release_stream(psstr2);
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
	free_keys_map((set_st *)indexes, (u_int16_t)count);
	flog("Done.\n");
	hide_message();
	return 0;
}

#ifdef	BLOCKSINHERIT
extern int supercompare;
#endif

static void filter_string_stream(stream_st *pdstr, stream_st *psstr, set_st *pmap, int j, set_st *primary)
{
	char *p;
	u_int32_t length, slen;
	hkey_item item, *pitem;
	set_st *pset;

#ifdef	BLOCKSINHERIT
	supercompare = 0;
#endif

	p = psstr->data;
	length = psstr->ref.size;
	for( ;length; length -= slen) {
		slen = (u_int32_t)(0x7fffffff & (strlen(p) + 1));
		item.key = p;
		pitem = (hkey_item *)bsearch(&item, pmap->set, pmap->count, pmap->reclen, hkeyitemstrcmp);
		if ( pitem ) {
			pset = pitem->data+j;
			if(pset->count && set_isect(pset, primary))
				write_stream(pdstr, p, slen);
		}
		p += slen;
	}

#ifdef	BLOCKSINHERIT
	supercompare = 1;
#endif
}
