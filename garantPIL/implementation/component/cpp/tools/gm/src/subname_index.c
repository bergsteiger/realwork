#include "shared/Core/fix/mpcxc.h"

#include <string.h>
//#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "gm.h"

typedef char *pchar;

extern	int	b_sawbase;

int merge_subname_index(index_st *ptarget, iter_st *spit, int count, int use_progress)
{
	stream_st dstr;
	char **pkeys;
	int *xmin, i, mincount, proceed, kpp, done;
	stref_st *pref;
#ifdef PTRS_IN_META
	use_progress= 0;
#endif
	bzero((caddr_t)&dstr, sizeof(dstr));
	pkeys = (pchar*)(alloca(count*sizeof(pchar)));
	xmin = (int*)alloca(count*sizeof(int));
	for(i=0, proceed=0; i<count; i++) {
		pkeys[i] = (char*)(first_key(spit+i));
		proceed += spit[i].key_count;
	}
	if (use_progress)
		kpp = proceed/use_progress;
	else
		kpp = proceed + 1;
	proceed = 0;
	if (!b_sawbase) while(count) {
		mincount = minkeyx(pkeys, count, xmin, spit->keycmp);
		pref = get_stref_ex(pkeys[*xmin], spit->keylen, spit->strinfo.immds, spit->nstreams, 0);
		if(load_stream(spit+*xmin, &dstr))
			move_stream(&dstr, ptarget->str, pref);
		release_stream(&dstr);
		if(gb_last_error()) {
			gb_log_error();
			return count;
		}
		add_key(ptarget, pkeys[*xmin]);
		for(i=0, done=0; i<mincount; i++) {
			xmin[i] -= done;
			pkeys[xmin[i]] = (char*)(next_key(spit+xmin[i]));
			if(!(pkeys[xmin[i]])) {
				if(gb_last_error()) {
					gb_log_error();
					return 0;
				}
				done++; release_iter(spit+xmin[i]);
				if(xmin[i] < count-1) {
					memmove(spit+xmin[i], spit+xmin[i]+1, (count-1-xmin[i])*sizeof(iter_st));
					memmove(pkeys+xmin[i], pkeys+xmin[i]+1, (count-1-xmin[i])*sizeof(pchar));
				}
				count--;
			}
		}
		proceed += mincount;
		if(proceed >= kpp) {
			if(use_progress) inc_progress();
			proceed -= kpp;
		}
	}
	return 1;
}

