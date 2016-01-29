#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include "osdep.h"
#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "gm.h"
#include "../../../libs/mrglib/src/log.h"

typedef char *pchar;

static int make_baseinfo(set_st *heres, set_st *pbis, iter_st *pit, int count);
static int collect_heres(iter_st *pit, int count, set_st *lhs, set_st *mhs);
static int collect_baseinfo(iter_st *pit, set_st *lhs, int count, set_st *lbis, set_st *hbis);
static int exclude_equals(set_st *psrc, set_st *pexcls);

int make_aux(index_st *ptarget, iter_st *spit, int count, int use_progress)
{
	char **pkeys;
	int mincount, i, done;
	int kpp, proceed_keys;
	int *xmin;
	stream_st *psstr, *pdstr;
	set_st *pset, hset[2], *biset;
	int tomove;
	stref_st *pref;

	m_log("Making new \"Aux\" index.\n");
	pdstr = create_streams(count+1);
	psstr = pdstr + 1;
	xmin = (int *)alloca(count*sizeof(int));
	pkeys = (char **)alloca(count*sizeof(pchar));
	bzero((caddr_t)hset, sizeof(hset));
	biset = hset+1;
	make_baseinfo(hset, biset, spit, count);
	for(i=0, proceed_keys=0; i<count; i++) {
		pkeys[i] = (char*)(first_key(spit+i));
		proceed_keys += spit[i].key_count;
	}
	pset = create_sets(count, spit->reccmp, spit->reclen);
	if(use_progress) kpp = proceed_keys/use_progress;
	else kpp = proceed_keys+1;
	proceed_keys = 0;
	while(count) {
		mincount = minkeyx(pkeys, count, xmin, spit->keycmp);
		pref = get_stref_ex(pkeys[*xmin], spit->keylen, spit->strinfo.immds, spit->nstreams, 0);
		if(!strcmp(pkeys[*xmin], "Here")) {
#ifdef PTRS_IN_META
			pdstr->ref.size= pref->size= hset->count<<1;
			pdstr->flags &= SF_USELOCAL;
			pdstr->pos= 0;
			pdstr->info.immds= (spit+*xmin)->strinfo.immds;
			pdstr->info.rndv= (spit+*xmin)->strinfo.rndv;
			pdstr->rec= pdstr->data= hset->set;
#else
			create_stream(ptarget, pdstr);
			write_stream(pdstr, hset->set, hset->count<<1);
			attach_stream(pdstr, pref);
			close_stream(pdstr);
#endif
		}
		else if(!strcmp(pkeys[*xmin], "Base")) {
#ifdef PTRS_IN_META
			pdstr->ref.size= pref->size= biset->count*sizeof(baseinfo_st);
			pdstr->flags &= SF_USELOCAL;
			pdstr->pos= 0;
			pdstr->info.immds= (spit+*xmin)->strinfo.immds;
			pdstr->info.rndv= (spit+*xmin)->strinfo.rndv;
			pdstr->rec= pdstr->data= biset->set;
#else
			create_stream(ptarget, pdstr);
			write_stream(pdstr, biset->set, biset->count*sizeof(baseinfo_st));
			attach_stream(pdstr, pref);
			close_stream(pdstr);
#endif
		}
		else {
			load_stream(spit+*xmin, pdstr);
#ifdef PTRS_IN_META
		}
#endif
			move_stream(pdstr, ptarget->str, pref);
			release_stream(psstr);
#ifndef PTRS_IN_META
		}
#endif
		if(gb_last_error()) return 0;
		add_key(ptarget, pkeys[*xmin]);
		for(i=0, done=0; i<mincount; i++) {
			xmin[i] -= done;
			pkeys[xmin[i]]=(char*)(next_key(spit+xmin[i]));
			if(!pkeys[xmin[i]]) {
				if(gb_last_error()) {
					return 0;
				}
				done++; release_iter(spit+xmin[i]);
				if(xmin[i]<count-1) {
					tomove = (count-xmin[i]-1)*sizeof(iter_st);
					memmove(spit+xmin[i], spit+xmin[i]+1, tomove);
					tomove = (count-xmin[i]-1)*sizeof(pchar);
					memmove(pkeys+xmin[i], pkeys+xmin[i]+1, tomove);
				}
				count--;
			}
		}
		proceed_keys += mincount;
		if(proceed_keys >= kpp) {
			if(use_progress) inc_progress();
			proceed_keys -= kpp;
		}
	}
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
	free(pdstr);
	free(pset);
	m_log("New \"Aux\" index made successfully\n");
	return 1;
}

static int bicmp(const void *b1, const void *b2);

static int make_baseinfo(set_st *heres, set_st *pbis, iter_st *pit, int count)
{
	int i;
	set_st *lhs, *hbis;

	pbis->reclen = sizeof(baseinfo_st);
	pbis->rcmp = bicmp;
	pbis->set = 0; // determined in run: calloc(count<<7, sizeof(baseinfo_st));
	pbis->count = 0;
	pbis->dtype = -1;
	heres->reclen = 2;
	heres->rcmp = shrtcmp;
	heres->set = 0; // determined in run: malloc(count<<7);
	heres->count = 0;
	heres->dtype = DT_INT16;
	lhs = (set_st *)calloc(count<<1, sizeof(set_st));
	hbis = lhs+count;
	for(i=0; i<count; i++) {
		memcpy(hbis+i, pbis, sizeof(set_st));
		// hbis[i].set = 0; // determined in run: calloc(32, sizeof(baseinfo_st));
		memcpy(lhs+i, heres, sizeof(set_st));
		// lhs[i].set = 0; // determined in run: calloc(64, 2);
	}
	collect_heres(pit, count, lhs, heres);
	collect_baseinfo(pit, lhs, count, pbis, hbis);
	for(i=0; i<count; i++) {
		free(hbis[i].set);
		free(lhs[i].set);
	}
	free(lhs);
	return 1;
}

static int bicmp(const void *b1, const void *b2)
{
	if(((baseinfo_st *)b1)->BaseId < ((baseinfo_st *)b2)->BaseId) return -1;
	if(((baseinfo_st *)b1)->BaseId > ((baseinfo_st *)b2)->BaseId) return 1;
	if(((baseinfo_st *)b1)->BannerTopic < ((baseinfo_st *)b2)->BannerTopic) return -1;
	if(((baseinfo_st *)b1)->BannerTopic > ((baseinfo_st *)b2)->BannerTopic) return 1;
	if(((baseinfo_st *)b1)->SplashTopic < ((baseinfo_st *)b2)->SplashTopic) return -1;
	if(((baseinfo_st *)b1)->SplashTopic > ((baseinfo_st *)b2)->SplashTopic) return 1;
	return 0;
}

// Collect
static int collect_heres(iter_st *pit, int count, set_st *lhs, set_st *mhs)
{
	int i;
	stream_st *phstr;

	phstr = (stream_st *)alloca(sizeof(stream_st));
	bzero((caddr_t)phstr, sizeof(stream_st));
	for(i=0; i<count; i++) {
		if(locate_key(pit+i, "Here")) {
			gb_set_last_error(0x710);
			m_log("'Here' key was not found in index \"Aux\"\n");
			release_streams(phstr, i);
			return 0;
		}
		load_stream(pit+i, phstr);
		lhs[i].set = (char *)calloc(phstr->ref.size>>1, 2);
		memcpy(lhs[i].set, phstr->data, phstr->ref.size);
		lhs[i].count = phstr->ref.size>>1;
		lhs[i].dtype = DT_INT16;
		lhs[i].reclen = 2;
		lhs[i].rcmp = shrtcmp;
		release_stream(phstr);
		mhs->count += lhs[i].count;
	}
	mhs->set = (char *)calloc(mhs->count, 2);
	mhs->count = 0;
	merge_sets(mhs, lhs, count);
	return mhs->count;
}

static int collect_baseinfo(iter_st *pit, set_st *lhs, int count, set_st *lbis, set_st *hbis)
{
	int i, size, j;
	stream_st *pbstr;
	stref_st *pstref;
	baseinfo_st *pbi, *phbi, *psbi;
	u_int16_t id;

	pbstr = (stream_st *)alloca(sizeof(stream_st));
	bzero((caddr_t)pbstr, sizeof(stream_st));
	for(i=0; i<count; i++) { // calc sizes of set's arrays for baseinfo sets
		if(locate_key(pit+i, "Base")) {
			gb_set_last_error(0x710);
			m_log("'Base' key was not found in index \"Aux\"\n");
			// release_streams(pbstr, i);
			return 0;
		}
		pstref = get_stref(pit+i, 0); //(stref_st *)(pit->pkey + pit->ref_offs);
		lbis->count += pstref->size / sizeof(baseinfo_st);
		hbis->count += lhs[i].count;
	}
	lbis->set = (char *)malloc(lbis->count*sizeof(baseinfo_st));
	hbis->set = (char *)malloc(hbis->count*sizeof(baseinfo_st));
	phbi = (baseinfo_st *)(hbis->set);
	psbi = (baseinfo_st *)(lbis->set);
	lbis->count = 0;
	hbis->count = 0;
	for(i=0; i<count; i++) {
		load_stream(pit+i, pbstr);
		pbi = (baseinfo_st *)(pbstr->data);
		size = pbstr->ref.size / sizeof(baseinfo_st);
		if(pbi->BaseId == 0) { // Skip 0 baseinfo
			pbi++;
			size--;
		}
		memcpy(psbi, pbi, size*sizeof(baseinfo_st)); // Add to all's set
		for(j=0; (unsigned)j<lhs[i].count; j++) { // get here's baseinfo to phbi
			id = *(u_int16_t *)(lhs[i].set + (j<<1));
			pbi = (baseinfo_st *)bsearch(&id, psbi, size, sizeof(baseinfo_st), shrtcmp);
			if(!pbi) {
				flog("Error: Missing \"declared here\" BaseInfo struct for BaseId %d in source %d", (int)id, i);
				continue;
			}
			memcpy(phbi, pbi, sizeof(baseinfo_st));
			phbi++; hbis->count++;
		}
		psbi += size;
		lbis->count += size;
	}
	qsort(hbis->set, hbis->count, sizeof(baseinfo_st), bicmp);

	phbi = (baseinfo_st *)(hbis->set);
	id = phbi->BaseId; i=1; pbi = phbi+1;
	while((unsigned)i<hbis->count) {
		if(pbi->BaseId == id) {
			if((unsigned)i<hbis->count-1)
				memmove(pbi-1, pbi, sizeof(baseinfo_st)*(hbis->count-i-1));
			hbis->count--;
		}
		else {
			id = pbi->BaseId;
			pbi++; i++;
		}
	}
	qsort(lbis->set, lbis->count, sizeof(baseinfo_st), bicmp);
	exclude_equals(lbis, hbis);
	return lbis->count;
}

static int exclude_equals(set_st *psrc, set_st *pexcls)
{
	baseinfo_st *pbi, *pfbi, *pbexcl;
	int exc, del, i;

	pbi = (baseinfo_st *)(psrc->set);
	pfbi = pbi+1;
	pbexcl = (baseinfo_st *)(pexcls->set);
	exc = pexcls->count; i=0;
	while((unsigned)i<psrc->count-1) {
		if(exc && pbi->BaseId == pbexcl->BaseId) { // not all of the "here" baseinfo excluded && 
			memcpy(pbi, pbexcl, sizeof(baseinfo_st));
			del=0; pbi++; i++;
			while((unsigned)(del+i)<psrc->count && pfbi->BaseId == pbexcl->BaseId) {
				pfbi++; del++;
			}
			if(del && (unsigned)(del+i)<psrc->count-1)
				memmove(pbi, pfbi, sizeof(baseinfo_st)*(psrc->count-i-del));
			psrc->count -= del;
			pfbi = pbi+1;
			pbexcl++; exc--;
		}
		else if(pfbi->BaseId == pbi->BaseId) {
			del=0;
			while((unsigned)(del+i)<psrc->count-1 && pfbi->BaseId == pbi->BaseId) {
				pfbi++; del++;
			}
			if(del) {
				pfbi--;
				memmove(pbi, pfbi, sizeof(baseinfo_st)*(psrc->count-i-del));
			}
			psrc->count -= del;
			i++; pbi++;
			pfbi = pbi+1;
		}
		else {
			i++; pbi++; pfbi++;
		}
	}
	return psrc->count;
}


