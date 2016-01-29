#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "../../../libs/mrglib/src/log.h"

#define __INDHLP_C
#include "indhlp.h"

int reg_key(hierkey_st *phk, hkeyref_st *phref, set_st *pset, set_st *pids)
{
	idc_st *pidc, *sidc;
	int npidc;

	if(pids->set && pids->count)
		sidc = bsearch(&(phk->id), pids->set, pids->count, sizeof(idc_st), longcmp);
	else sidc = 0;
	if(!sidc) {
		phref->cc = 0;
		phref->tc = 0;
	}
	else {
		phref->cc = sidc->cc;
		phref->tc = sidc->tc;
	}
	//pidc = bsearch(&(phk->pid), pset->set, pset->count, sizeof(idc_st), longcmp);
	npidc = bfindgex(&(phk->pid), pset->set, pset->count, sizeof(idc_st), longcmp);
	pidc = (idc_st *)(pset->set);
	pidc += npidc;
	if((unsigned)npidc<pset->count && pidc->id == phk->pid) {
		pidc->cc++;
		if(sidc && sidc->tc) pidc->tc += sidc->tc+1;
		else pidc->tc++;
	}
	else {
		if((unsigned)npidc < pset->count)
			memmove(pidc+1, pidc, (pset->count-npidc)*sizeof(idc_st));
		pidc->id = phk->pid;
		pidc->cc = 1;
		if(sidc && sidc->tc) pidc->tc = sidc->tc+1;
		else pidc->tc = 1;
		pset->count++;
	}
	return 1;
}

int filter_stream(iter_st *pit, set_st *fset, index_st *pin, int count, stream_st *pstr)
{
	stream_st *psstr;
	set_st sset;
	int goodc;
	stref_st *pref;
	int i;

	psstr = (stream_st *)alloca(sizeof(stream_st));
	bzero((caddr_t)psstr, sizeof(stream_st));
	load_stream(pit, psstr);
	sset.set = psstr->data;
	sset.count = psstr->ref.size/pit->reclen;
	sset.reclen = pit->reclen;
	sset.rcmp = pit->reccmp;
	goodc = 0;
	for(i=0; i<count; i++) {
		create_stream(pin+i, pstr);
		if(stream_isect_sets(pstr, &sset, fset+i)) {
			pref = get_stref(pit, 0);
			attach_stream(pstr, pref);
			close_stream(pstr);
			add_key(pin+i, pit->pkey);
			goodc++;
		}
		else close_stream(pstr);
	}
	release_stream(psstr);
	return goodc;
}

// Put necessary keys into target indexes...

static int minx(set_st *pkeyset, int count, int *mins);
static int rebuild_alive(set_st *pkeyset, int count, int *alive);
static int reverse_set(set_st *pset);

#ifdef PTRS_IN_META
	extern void add_key_as_buf(index_st *pin, void *pkey);
#else
	#define add_key_as_buf add_key
#endif

int fill_indexes(iter_st *spit, index_st *tin, set_st * pkeyset, int count)
{
	char *pkey;
	set_st *pkeynums;
	int *mins, minc, keynum, *alive, i, j, imin;
	stref_st *pref, *pref2;
	hierkey_st *phk;

	//pkeynums = (set_st *)ml_malloc(count * sizeof(set_st)); ///!!!
	pkeynums = (set_st *)malloc(count * sizeof(set_st));
	memcpy(pkeynums, pkeyset, count * sizeof(set_st));
	alive = (int *)alloca(count * sizeof(int));
	for (i=0; i<count; i++) alive[i] = i;
	count = rebuild_alive(pkeynums, count, alive);
	for (i=0; i<count; i++) reverse_set(pkeyset + alive[i]);
	mins = (int *)alloca(count * sizeof(int));
	pkey = first_key(spit); i=0;
	while(count && pkey) {
		minc = minx(pkeynums, count, mins);
		keynum = ((hkeyref_st *)(pkeynums[*mins].set))->num;
		for( ; i<keynum; i++, pkey = next_key(spit));
		pref = get_stref_ex(pkey, spit->keylen, spit->strinfo.immds, spit->nstreams, 0);
		pref2 = get_stref_ex(pkey, spit->keylen, spit->strinfo.immds, spit->nstreams, 1);
		for(j=0; j<minc; j++) {
			imin = mins[j];
			memcpy(pref, &(((hkeyref_st *)(pkeynums[imin].set))->stref), sizeof(stref_st)+spit->strinfo.immds-4);
			if(tin->hdr.nstreams > 1)
				memcpy(pref2, &(((hkeyref_st *)(pkeynums[imin].set))->stref2), sizeof(stref_st)+spit->strinfo.immds-4);
			phk = (hierkey_st *)pkey;
			phk->cc = ((hkeyref_st *)(pkeynums[imin].set))->cc;
			phk->tc = ((hkeyref_st *)(pkeynums[imin].set))->tc;
			add_key_as_buf(tin+alive[imin], pkey);
			pkeynums[imin].set += pkeynums[imin].reclen;
			pkeynums[imin].count--;
		}
		count = rebuild_alive(pkeynums, count, alive);
	}
	return 1;
}

static int rebuild_alive(set_st *pkeyset, int count, int *alive)
{
	int i;

	for(i=0; i<count; ) {
		if(!pkeyset[i].count) {
			if(i<count-1) {
				memmove(pkeyset+i, pkeyset+i+1, sizeof(set_st)*(count-i-1));
				memmove(alive+i, alive+i+1, sizeof(int)*(count-i-1));
			}
			count--;
		}
		else i++;
	}
	return count;
}

static int minx(set_st *pkeyset, int count, int *mins)
{
	int i, mincount;
	u_int32_t min;

	min = ((hkeyref_st *)pkeyset[0].set)->num;
	mincount = 1;
	*mins = 0;
	for(i=1; i<count; i++) {
		if(((hkeyref_st *)pkeyset[i].set)->num < min) {
			min = ((hkeyref_st *)pkeyset[i].set)->num;
			mincount = 1;
			*mins = i;
		}
		else if(((hkeyref_st *)pkeyset[i].set)->num == min) {
			mins[mincount] = i;
			mincount++;
		}
	}
	return mincount;
}

static int reverse_set(set_st *pset)
{
	int i, half;
	char *head, *tail, *tmp;

	head = pset->set;
	tail = pset->set + ((pset->count-1)*pset->reclen);
	half = pset->count >> 1;
	tmp = (char *)alloca(pset->reclen);
	for(i=0; i<half; i++) {
		memcpy(tmp, head, pset->reclen);
		memcpy(head, tail, pset->reclen);
		memcpy(tail, tmp, pset->reclen);
		head += pset->reclen;
		tail -= pset->reclen;
	}
	return 1;
}


