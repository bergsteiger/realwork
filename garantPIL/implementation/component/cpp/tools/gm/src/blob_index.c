#include "shared/Core/fix/mpcxc.h"
#include <sys/stat.h>

#include <string.h>
//#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "gm.h"

typedef char *pchar;

#ifdef PTRS_IN_META
void store_it_key(iter_st *pit, void *pkey, streamfile_st *pdest, stream_st *pstr, stream_st *pdstr);
#endif

extern	int	b_sawbase;

int merge_blob_index(index_st *ptarget, iter_st *spit, int count, int use_progress)
{
	stream_st dstr
#ifdef PTRS_IN_META
					, sstr
#endif
							;
	char **pkeys, *pPreBuff= 0, *preB, *pPreData= 0;
	int *xmin, i, mincount, proceed, kpp, done, pBlbHandles= -1, *BlbHandles;
	long RsrcPosd[2], *RsrcPos= RsrcPosd, pgcount, szPreBuff= 0;
	stref_st *pref;

	RsrcPosd[0]= RsrcPosd[1]= 0;

	BlbHandles = (int*)alloca(count*sizeof(int));

	pkeys = (pchar*)alloca(count*sizeof(pchar));
	xmin = (int*)alloca(count*sizeof(int));
	bzero((caddr_t)&dstr, sizeof(dstr));
#ifdef PTRS_IN_META
	use_progress= 0;
	dstr.flags |= SF_NOALLOC;
	bzero((caddr_t)&sstr, sizeof(dstr));
#endif
	for(i=0, proceed=0; i<count; i++) {
		BlbHandles[i]= -1;
		pkeys[i] = (char*)(first_key(spit+i));
		proceed += spit[i].key_count;
	}
	if (use_progress)
		kpp = proceed/use_progress;
	else
		kpp = proceed + 1;
	proceed = 0;

	//if(pgfile_make_next_tom((pgfile_st *)ptarget->str)) 
	//	return 0;
	if (!b_sawbase) while(count) {
		mincount = minkeyx(pkeys, count, xmin, spit->keycmp);
#ifndef PTRS_IN_META
		pref = get_stref_ex(pkeys[*xmin], spit->keylen, spit->strinfo.immds, spit->nstreams, 0);
		if(load_stream(spit+*xmin, &dstr)){
			if(pref->size == 8){
				if(BlbHandles[*xmin] == -1){
					preB= strrchr((spit+*xmin)->str->pgfile.name, '.') + 1;
					memcpy(preB,"blb", 3);
					BlbHandles[*xmin]= c_io_open((spit+*xmin)->str->pgfile.name, ACE_OS_O_RDONLY |ACE_OS_O_BINARY);
					memcpy(preB,"str", 3);
				}
				pPreData= dstr.data;
				c_io_lseek(BlbHandles[*xmin], *(long*)dstr.data, ACE_OS_SEEK_SET);
				pref->size= *((long*)dstr.data + 1);
				// читаем страницами //
				pgcount= pref->size >> (spit+*xmin)->str->pgfile.pgpow;
				if(pref->size & ((1 << (spit+*xmin)->str->pgfile.pgpow)-1))
					pgcount++;
				pgcount <<= (spit+*xmin)->str->pgfile.pgpow;
				if(szPreBuff < pgcount){
					if(pPreBuff != 0)
						free(pPreBuff);
					szPreBuff= pgcount;
					pPreBuff= (char*)malloc(szPreBuff);
				}
				c_io_read(BlbHandles[*xmin], pPreBuff, pgcount);
				/////////////////////////////////////////
				dstr.data= pPreBuff;
				dstr.ref.size= pref->size;
			}
			move_stream(&dstr, ptarget->str, pref);
		}
		if(pPreData != 0){
			dstr.data= pPreData;
			pref->size= dstr.ref.size= 8;
			pPreData= 0;
		}
		release_stream(&dstr);
		pref = get_stref_ex(pkeys[*xmin], spit->keylen, spit->strinfo.immds, spit->nstreams, 1);
		if(load_stream_n(spit+*xmin, &dstr, 1))
			move_stream(&dstr, ptarget->str, pref);
		release_stream(&dstr);
		if(gb_last_error()) {
			gb_log_error();
			return count;
		}
		add_key(ptarget, pkeys[*xmin]);
#else
		load_stream(spit+*xmin, &sstr);
		create_stream_ex(ptarget->str, &dstr, &(spit->strinfo));
		write_stream(&dstr, sstr.data, sstr.ref.size);
		release_stream(&sstr);
		load_stream_n(spit+*xmin, &sstr, 1);
		store_it_key(spit, pkeys[*xmin], ptarget->str, &sstr, &dstr);
		close_stream(&dstr);
		release_stream(&sstr);
#endif
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
#ifdef PTRS_IN_META
	dstr.flags &= ~SF_NOALLOC;
	close_stream(&dstr);
#else
	for(i=0, proceed=0; i<count; i++) {
		if(BlbHandles[i] != -1)
			c_io_close(BlbHandles[i]);
	}
	//pgfile_close_current_tom((pgfile_st *)ptarget->str);
#endif
	return 1;
}









