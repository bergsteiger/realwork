#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "../../../libs/mrglib/src/log.h"
#include "progress.h"
#include "toys.h"

extern cmpfunc_ft get_cmpfunc(int);

int make_cr_index(index_st *pdest, int count, index_st *psrc, set_st *doclist)
{
	iter_st *pit;
	stream_st *pdstr, psstr[2];
	int i;
	stref_st *pstref;
	set_st *psrcset;
	char *pkey;

	pit = (iter_st *)alloca(sizeof(iter_st));
	flog("Processing index: \"%s\"...\t", psrc->name);
	init_iter(psrc, pit);
	pdstr = psstr + 1;
	bzero(psstr, sizeof(psstr));
	pdstr->flags = SF_WRALLOW | SF_NOALLOC;
	psrcset = (set_st *)alloca(sizeof(set_st));
	psrcset->reclen = pit->reclen;
	psrcset->rcmp = get_cmpfunc(DT_INT32);
	for(pkey=first_key(pit); pkey; pkey=next_key(pit)) {
		if(!load_stream(pit, psstr)) {
			// TODO : print warning message
			continue;
		}
		psrcset->set = psstr->data;
		psrcset->count = psstr->ref.size/pit->reclen;
		pstref = get_stref(pit, 0); // (stref_st *)(pkey + pit->ref_offs);
		for(i=0; i<count; i++) {
			create_stream(pdest+i, pdstr);
			if(stream_isect_sets(pdstr, psrcset, doclist+i)) {
				attach_stream(pdstr, pstref);
				add_key(pdest+i, pkey);
			}
			close_stream(pdstr);
		}
		release_stream(psstr);
	}
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
	release_iter(pit);
	flog("Done.\n");
	return 0;
}

#ifdef VERSION56
int make_Newcr_index(index_st *pdest, int count, index_st *psrc, set_st *doclist)
{
	iter_st *pit;
	stream_st *pdstr, psstr[2];
	int i, step;
	stref_st *pstref;
	char *pkey;

	pit = (iter_st *)alloca(sizeof(iter_st));
	flog("Processing index: \"%s\"...\t", psrc->name);
	init_iter(psrc, pit);
	pdstr = psstr + 1;
	bzero(psstr, sizeof(psstr));
	pdstr->flags = SF_WRALLOW | SF_NOALLOC;
	for(pkey=first_key(pit); pkey; pkey=next_key(pit)) {
		if(!load_stream(pit, psstr)) {
			// TODO : print warning message
			continue;
		}
		pstref = get_stref(pit, 0);
		for(i=0, step= pit->reclen/sizeof(long); i<count; i++) {
			long *pRead= (long *)psstr->data+1, Read= psstr->ref.size/pit->reclen, lastFind= 0;
			int writed= 0;
			create_stream(pdest+i, pdstr);
			while(Read && (pRead += step) && (Read -= 1) > -1)
				if((lastFind == *(pRead - step)
							|| (bsearch(	pRead-step, doclist[i].set, doclist[i].count,
												sizeof(long), longcmp)
								 && (lastFind= *(pRead-step)))))
					writed += write_stream(pdstr, pRead-step-1, pit->reclen);
			if(writed){
				attach_stream(pdstr, pstref);
				add_key(pdest+i, pkey);
			}
			close_stream(pdstr);
		}
		release_stream(psstr);
	}
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
	release_iter(pit);
	flog("Done.\n");
	return 0;
}

extern void otherIncProgress(void *);

int make_control_index(void *pCntx, index_st *pdest, int count, index_st *psrc)
{
	iter_st *pit;
	stream_st *pstr;
	int i;
	char *pkey;
	stref_st *pstref;
	int kpp, proceed;

	proceed = psrc->hdr.key_count;
	kpp = get_index_weight(psrc->name);
	kpp = (kpp) ? proceed / kpp : proceed+1;
	proceed = 0;
	flog("Processing index: \"%s\"...\t", psrc->name);
	pit = (iter_st *)alloca(sizeof(iter_st));
	init_iter(psrc, pit);
	pstr = (stream_st *)alloca(sizeof(stream_st));
	bzero((caddr_t)pstr, sizeof(stream_st));
	for(pkey=first_key(pit); pkey; pkey=next_key(pit)) {
		pstref = get_stref(pit, 0); // (stref_st *)(pkey + pit->ref_offs);
		load_stream(pit, pstr);
		for(i=0; i<count; i++) {
			move_stream(pstr, pdest[i].str, pstref);
			add_key(pdest+i, pkey);
		}
		release_stream(pstr);
		proceed++;
		if(proceed == kpp) {
			otherIncProgress(pCntx);
			proceed = 0;
		}
	}
	release_iter(pit);
	flog("Done.\n");
	hide_message();
	return 0;
}
#endif
