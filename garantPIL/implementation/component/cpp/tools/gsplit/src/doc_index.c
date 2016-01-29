#include "shared/Core/fix/mpcxc.h"
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

int make_doc_index(void *pCntx, index_st *pdest, int count, index_st *psrc, set_st *doclist)
{
	iter_st *pit;
	stream_st *pdstr;
	char *pkey;
	int kpp, proceed;

	proceed = psrc->hdr.key_count;
	kpp = get_index_weight(psrc->name);
	kpp = (kpp) ? proceed / kpp : proceed+1;
	proceed = 0;
	pit = (iter_st *)alloca(sizeof(iter_st));
	init_iter(psrc, pit);
	flog("Processing index: \"%s\"...\t", psrc->name);
	pdstr = (stream_st *)alloca(sizeof(stream_st));
	bzero((caddr_t)pdstr, sizeof(stream_st));
	pdstr->flags = SF_WRALLOW | SF_NOALLOC;
	for(pkey=first_key(pit); pkey; pkey=next_key(pit)) {
		filter_stream(pit, doclist, pdest, count, pdstr);
		proceed++;
		if(proceed == kpp) {
			otherIncProgress(pCntx);
			proceed = 0;
		}
	}
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
	release_iter(pit);
	flog("Done.\n");
	hide_message();
	return 0;
}

int make_ref_index(void *pCntx, index_st *pdest, int count, index_st *psrc, set_st *doclist)
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
	psrcset->rcmp = pit->reccmp;
	for(pkey=first_key(pit); pkey; pkey=next_key(pit)) {
		if(!load_stream(pit, psstr))
			continue;
		psrcset->set = psstr->data;
		psrcset->count = psstr->ref.size/pit->reclen;
		pstref = get_stref(pit, 0);
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

