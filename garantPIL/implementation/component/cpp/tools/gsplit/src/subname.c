#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "../../../libs/mrglib/src/log.h"

#include "toys.h"
#include "progress.h"

extern void otherIncProgress(void *);

int make_subname_index(void *pCntx, index_st *pdest, int count, index_st *psrc, set_st *doclist)
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
			if(bsearch(pkey, doclist[i].set, doclist[i].count, 4, longcmp)) {
				move_stream(pstr, pdest[i].str, pstref);
				add_key(pdest+i, pkey);
			}
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

int make_kindcorr_index(void *pCntx, index_st *pdest, int count, index_st *psrc, set_st *doclist)
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
