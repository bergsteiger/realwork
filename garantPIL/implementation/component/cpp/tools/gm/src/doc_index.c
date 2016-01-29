#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "gm.h"
#include "../../../libs/mrglib/src/log.h"

typedef char *pchar;

static int mdipass;

#ifdef PTRS_IN_META
void store_it_key(iter_st *pit, void *pkey, streamfile_st *pdest, stream_st *pstr, stream_st *pdstr);
#endif

int merge_doc_index(index_st *ptarget, iter_st *spit, int count, int use_progress)
{
	char **pkeys;
	int mincount, i;
	int kpp, proceed_keys, done;
	int *xmin;
	stream_st *psstr, *pdstr, *prstr;
	set_st *pset;
	stref_st *pref;
#ifdef PTRS_IN_META
	use_progress= 0;
#endif
	flog("Making index \"%s\"\n", ptarget->name);
	mdipass = 0;
	pdstr = create_streams(count+1);
	psstr = pdstr + 1;
	//xmin = (int *)alloca(count*sizeof(int));
	xmin = (int *)calloc(count,sizeof(int));
	//pkeys = (char **)alloca(count*sizeof(pchar));
	pkeys = (char **)calloc(count,sizeof(pchar));
	for(i=0, proceed_keys=0; i<count; i++) {
		pkeys[i] = (char*)(first_key(spit+i));
		proceed_keys += spit[i].key_count;
	}
	pset = create_sets(count,
#ifndef PTRS_IN_META
								spit->reccmp
#else
								((index_st *)(spit->reccmp))->reccmp
#endif
																		, spit->reclen);
	if(use_progress) kpp = proceed_keys/use_progress;
	else kpp = proceed_keys+1;
	proceed_keys = 0;
	while(count) {
		mdipass++;
		mincount = minkeyx(pkeys, count, xmin, spit->keycmp);
		pref = get_stref_ex(pkeys[*xmin], spit->keylen, spit->strinfo.immds, spit->nstreams, 0);
		if(mincount == 1) {
			if(!load_stream(spit+*xmin, pdstr))
				if(gb_last_error()) {
					gb_log_error();
					return 0;
				}
			move_stream(pdstr, ptarget->str, pref);
			release_stream(pdstr);
			add_key(ptarget, pkeys[*xmin]);
		}else{
			for(i=0; i<mincount; i++) {
				prstr = load_stream(spit+xmin[i], psstr+i);
				if(!prstr && i<mincount) {
					if(gb_last_error()) {
						gb_log_error();
						release_streams(psstr, i);
						return 0;
					}
				}
				pset[i].set = prstr->data;
				pset[i].count = prstr->ref.size / pset[i].reclen;
			}
			create_stream(ptarget, pdstr);
			if(!stream_merge_sets(pdstr, pset, mincount)) {
				release_streams(psstr, mincount);
#ifndef PTRS_IN_META
				attach_stream(pdstr, pref);
				close_stream(pdstr);
#endif
				return 0;
			}
			release_streams(psstr, mincount);
#ifdef PTRS_IN_META
			store_it_key(spit, pkeys[*xmin], ptarget->str, psstr, pdstr);
			close_stream(pdstr);
#else
			attach_stream(pdstr, pref);
			close_stream(pdstr);
			if(gb_last_error()) {
				gb_log_error();
				return 0;
			}
			add_key(ptarget, pkeys[*xmin]);
#endif
		}
		for(i=0, done=0; i<mincount; i++) {
			xmin[i] -= done;
			if(!(pkeys[xmin[i]] = (char*)(next_key(spit+xmin[i])))) {
				if(gb_last_error()) { 
					gb_log_error();
					return 0;
				}
				done++; release_iter(spit+xmin[i]);
				if(xmin[i]<count-1) {
					memmove(spit+xmin[i], spit+xmin[i]+1, (count-1-xmin[i])*sizeof(iter_st));
					memmove(pkeys+xmin[i], pkeys+xmin[i]+1, (count-1-xmin[i])*sizeof(pchar));
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
	flog("Index \"%s\" done.\n", ptarget->name);
	return 1;
}
