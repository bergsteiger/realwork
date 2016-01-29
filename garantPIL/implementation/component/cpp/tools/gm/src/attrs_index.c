#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include "osdep.h"
#include "../../../libs/mrglib/src/gdbapi.h"
#include "gm.h"
#include "../../../libs/mrglib/src/sets.h"
#include "../../../libs/mrglib/src/log.h"

static int init_indexes(index_st *pin, int count, base_st *psrc, base_st *ptarget, char *pName);
// static int build_ndt(base_st *ptarget, index_st *pin, base_st *psrc, int count, int proceed, int kpp);

typedef char *pchar;

extern int minkeyx(char **, int, int *, cmpfunc_ft);

/*
#if defined(__GO32__) || defined(__CYGWIN32__)
#endif
*/
extern char ErrorFormat1[];

extern	int	b_sawbase;

#ifdef PTRS_IN_META
	#define OLD11_STREAM_HANDLE_TO_ID(_handle_) ((short)( _handle_ & 0x0FFF ))
	#define BIG11_STREAM_HANDLE_TO_ID(_handle_,_alloc_) ((short)( ( (_handle_ & 0x1f) << 7) | ( (_alloc_ >> 24) & 0x7f) ))

	#define IS11_SHORT_STR(_pref_) (0 != ((_pref_->alloc & 0x80000000) ? BIG11_STREAM_HANDLE_TO_ID(_pref_->data.pos, _pref_->alloc ) : OLD11_STREAM_HANDLE_TO_ID( _pref_->data.pos )))
	void move_stream_doc_struct(stream_st *pstr, streamfile_st *pdest, stref_st *pref);
#endif
int merge_bases(base_st *ptarget, base_st *psrc, int count, int use_progress)
{
	stream_st dstr, nstr;
	char qqq[128];
	char *body, *buf;
	char **pkeys;
	int *xmin, i, mincount, proceed, kpp, done, err, rcount, bodysize,
#ifdef VERSION61
					countExt= count,
#endif
										bndt, curNDT= 1;
	index_st *pin, *spin;
	iter_st *pit;
	u_int16_t tag;
	//	attrkey_st key;
	docrun_st *prun, run;
	//streamfile_st *pstr;
	pgfile_st *sndt, *pndt;
#ifdef PTRS_IN_META
	stref_st *prf;
#endif

	m_log("Processing index \"Attrs\"\n");
	bzero((caddr_t)&dstr, sizeof(dstr));
	bzero((caddr_t)&nstr, sizeof(dstr));
	nstr.flags |= SF_NOALLOC;
	pin = (index_st*)alloca((count+1)*sizeof(index_st));
	pit = (iter_st *)alloca(count*sizeof(iter_st));
	bzero((caddr_t)pin, (count+1)*sizeof(index_st));
	bzero((caddr_t)pit, count*sizeof(iter_st));

	init_indexes(pin, count, psrc, ptarget, "Attrs.str" );

	do{
		for(i=1; i<=count; i++){
			if(!(pin+i)->hdr.key_count){
				if(countExt){
					flog(ErrorFormat1, gs_source_name[i-1]);
					flog("\nError: not find documents in base.");
					return 0;
				}else{
					if(count-- > 1){
						index_st temp_= pin[count+1];
						pin[count+1]= pin[i];
						pin[i--]= temp_;
					}
				}
			}
		}
		spin = pin+1;
		//pstr = pin->str; // Debug
		pkeys = (pchar*)alloca(count*sizeof(pchar));
		xmin = (int*)alloca(count*sizeof(int));
		bodysize = 1<<19;
		body = (char *)malloc(bodysize);
	#ifdef PTRS_IN_META
		if(ptarget != psrc-1 && ptarget->str.fat == 0){
			for(i=0, proceed=0; i<count; i++) {
				attrkey_st key= { 1, IDD_RUNS };
				init_iter(spin+i, pit+i);
				locate_key(pit+i,&key);
				pkeys[i] = pit[i].pkey;
			}
		}else
	#endif
		for(i=0, proceed=0; i<count; i++) {
			init_iter(spin+i, pit+i);
			pkeys[i] = (char*)(first_key(pit+i));
			proceed += pit[i].key_count;
		}
		if(use_progress)
			kpp = proceed/use_progress;
		else
			kpp = proceed + 1;
		bndt = 0;
		proceed = 0;
		pndt = &(ptarget->ndt);

		if (!b_sawbase) {
			while(count) {
				mincount = minkeyx(pkeys, count, xmin, pit->keycmp);
				tag = ((attrkey_st *)(pkeys[*xmin]))->tag;
				if(tag == IDD_RUNS) {
					if(!bndt) {
		#ifndef PTRS_IN_META
						m_log("Building .ndt files\n");
		#endif
						bndt=1;
					}
					load_stream(pit+*xmin, &dstr);
				}
				else if (bndt) {
					// Here we must build the ndt file...
					bndt=0;
		#ifndef PTRS_IN_META
					m_log(".ndt files build finished.\n");
		#endif
		#ifdef PTRS_IN_META
					if(ptarget != psrc-1){
						break;
					}
				}
				if(!bndt)
		#else
					free(body);
					m_log(".ndt files build finished.\n");
					load_stream(pit+*xmin, &dstr);
				}else
		#endif
				{
		#ifdef PTRS_IN_META
				  if(tag == IDD_DOCSTRUCT){
						prf= get_stref((iter_st *)(dstr.pAForms= (Form_Node*)(pit+*xmin)), (dstr.curr_B= 0));
						if(prf->size <= ((iter_st *)(dstr.pAForms))->strinfo.immds) {
							load_stream_ex(((iter_st *)(dstr.pAForms))->str, prf, &dstr, &(((iter_st *)(dstr.pAForms))->strinfo));
						}else if(IS11_SHORT_STR(prf)){
							load_stream_ex(((iter_st *)(dstr.pAForms))->str, prf, &dstr, &(((iter_st *)(dstr.pAForms))->strinfo));
						}else{
							move_stream_doc_struct(&dstr, pin->str, prf);
							tag= 0;
						}
				  }else{
						prf= get_stref((iter_st *)(dstr.pAForms= (Form_Node*)(pit+*xmin)), (dstr.curr_B= 0));
						if(prf->size <= ((iter_st *)(dstr.pAForms))->strinfo.immds) {
							load_stream_ex(((iter_st *)(dstr.pAForms))->str, prf, &dstr, &(((iter_st *)(dstr.pAForms))->strinfo));
						}else if(IS11_SHORT_STR(prf)){
							load_stream_ex(((iter_st *)(dstr.pAForms))->str, prf, &dstr, &(((iter_st *)(dstr.pAForms))->strinfo));
						}else{
							dstr.refs_count= prf->size >> ((iter_st *)(dstr.pAForms))->str->pgfile.pgpow;
							if(prf->size & ((1 << ((iter_st *)(dstr.pAForms))->str->pgfile.pgpow)-1))
								dstr.refs_count++;
							dstr.refs_count <<= ((iter_st *)(dstr.pAForms))->str->pgfile.pgpow;
							if(bodysize < dstr.refs_count) {
								free(body);
								bodysize = dstr.refs_count;
								body = (char *)malloc(bodysize);
							}
							dstr.refs_count= 0;
							(((iter_st *)(dstr.pAForms))->str)->str_header= body;
							load_stream_ex(((iter_st *)(dstr.pAForms))->str, prf, &dstr, &(((iter_st *)(dstr.pAForms))->strinfo));
							(((iter_st *)(dstr.pAForms))->str)->str_header= 0;
							dstr.flags &= ~SF_FREEBUF;
						}
				  }
		#else
						load_stream(pit+*xmin, &dstr);
		#endif
				}
				{
					if(bndt) {
						sndt = &(psrc[*xmin].ndt);
						rcount = dstr.ref.size / sizeof(docrun_st);
						prun = (docrun_st *)dstr.data;
						run.count = 0;
						for(i=0; i<rcount; i++)
							run.count += prun[i].count;
		#ifdef PTRS_IN_META
						if(ptarget != psrc-1)
						{
		#endif
							if((unsigned)bodysize < (((u_int32_t)(run.count))<<sndt->pgpow)) {
								free(body);
								bodysize = ((u_int32_t)(run.count))<<sndt->pgpow;
								body = (char *)malloc(bodysize);
							}
		#ifndef PTRS_IN_META
						{
		#endif
							for(buf = body; rcount; rcount--, prun++) {
								read_pages(sndt, prun->page, prun->count, buf);
								buf += ((u_int32_t)(prun->count)) << sndt->pgpow;
							}
						}
						run.page = curNDT;
						memcpy(dstr.data, &run, dstr.ref.size= sizeof(run));
		#ifdef PTRS_IN_META
						if(ptarget != psrc-1)
						{
							tag= 0;
		#else
						{
		#endif
							write_pages(pndt, run.page, run.count, body);
						}
						curNDT += run.count;
					}
					if(tag){
					  move_stream(&dstr, pin->str
		#ifdef PTRS_IN_META
												, prf
		#else
												, get_stref(pit+*xmin, 0)
		#endif
												);
					}
				}
				release_stream(&dstr);
				if((err=gb_last_error()) != 0) {
					gb_log_error();
					//flog("Unsuccessful : %s\n", gb_err_msg(err));
					return 0;
				}
				add_key(pin, pkeys[*xmin]);
				for(i=0, done=0; i<mincount; i++) {
					xmin[i] -= done;
					if(!(pkeys[xmin[i]]=(char*)(next_key(pit+xmin[i])))) {
						if((err=gb_last_error()) != 0) {
							gb_log_error();
							// printf("Unsuccessful : %s\n", gb_err_msg(err));
							return 0;
						}
						done++; release_iter(pit+xmin[i]);
						close_index(spin + xmin[i]);
						if(xmin[i]<count-1) {
							memmove(spin+xmin[i], spin+xmin[i]+1, (count-1-xmin[i])*sizeof(index_st));
							memmove(pit+xmin[i], pit+xmin[i]+1, (count-1-xmin[i])*sizeof(iter_st));
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
		}

	#ifdef PTRS_IN_META
		free(body);
		body= 0;
		if(ptarget == psrc-1)
		{
			countExt= 0;
	#else
		close_index(pin);
		{
	#endif
			sprintf(qqq, "Index \"%s\" done.\n", pin[1].name);
			m_log(qqq);
		}
	#ifdef PTRS_IN_META
		else
			countExt= 0;
	#endif
	}while(countExt && init_indexes(pin, count= countExt, psrc, ptarget, "Attribs") && !(countExt= 0) && !(use_progress= 0));
	return 1;
}

/*
static int build_ndt(base_st *ptarget, index_st *pin, base_st *psrc, int count, int proceed, int kpp)
{
	set_st runset;
	iter_st *pit;
	int i, rcount, nkey, bodysize, j;
	attrkey_st key, *pkey;
	char *pskey, *body, *buf;
	runrec_st *prrec;
	docrun_st *prun;
	stref_st *pref;
	stream_st sstr, dstr;
	pgfile_st *sndt, *pndt;
	index_st *spin;

	m_log("Building .ndt files\n");
	pit = (iter_st *)alloca(sizeof(iter_st));
	bzero((caddr_t)pit, sizeof(iter_st));
	bzero((caddr_t)&runset, sizeof(set_st));
	runset.reclen = sizeof(runrec_st);
	runset.rcmp = longcmp;
	set_alloc(&runset, 32768);
	runset.count = 0;
	bodysize = 1<<19;
	body = (char *)malloc(bodysize);
	pndt = &(ptarget->ndt);
	spin = pin+1;
	key.tag = IDD_RUNS;
	key.doc_id = 100000;
	bzero((caddr_t)&dstr, sizeof(dstr));
	bzero((caddr_t)&sstr, sizeof(sstr));
	dstr.flags |= SF_NOALLOC;
	for(i=0; i<count; i++, spin++) {
		init_iter(spin, pit);
		locate_key(pit, &key);
		pkey = (attrkey_st *)(pit->pkey);
		sndt = &(psrc[i].ndt);
		while(pkey->tag == IDD_RUNS) {
			nkey = bfindgex(pkey, runset.set, runset.count, sizeof(runrec_st), longcmp);
			prrec = (runrec_st *)(runset.set + nkey*sizeof(runrec_st));
			if((unsigned)nkey == runset.count || prrec->doc_id != pkey->doc_id) {
				if((unsigned)nkey < runset.count)
					memmove(prrec+1, prrec, sizeof(runrec_st)*(runset.count-nkey));
				load_stream(pit, &sstr);
				rcount = sstr.ref.size / sizeof(docrun_st);
				prun = (docrun_st *)sstr.data;
				prrec->run.count = 0;
				for(j=0; j<rcount; j++)
					prrec->run.count += prun[j].count;
				if((unsigned)bodysize < (((u_int32_t)(prrec->run.count))<<sndt->pgpow)) {
					free(body);
					bodysize = ((u_int32_t)(prrec->run.count))<<sndt->pgpow;
					body = (char *)malloc(bodysize);
				}
				for(buf = body; rcount; rcount--, prun++) {
					read_pages(sndt, prun->page, prun->count, buf);
					buf += ((u_int32_t)(prun->count)) << sndt->pgpow;
				}
				prrec->doc_id = pkey->doc_id;
				prrec->run.page = pgfile_size(pndt);
				write_pages(pndt, prrec->run.page, prrec->run.count, body);
				runset.count++;
				if(runset.count == runset.alloc) {
					flog("set_realloc called (%d).\n", runset.alloc+32768);
					set_realloc(&runset, runset.alloc+32768);
				}
			}
			proceed++;
			if(proceed >= kpp) {
				inc_progress();
				proceed -= kpp;
			}
			pkey = (attrkey_st *)next_key(pit);
		}
		release_iter(pit);
	}
	free(body);
	pskey = (char *)alloca(pin->hdr.keylen);
	pkey = (attrkey_st *)pskey;
	pref = get_stref_ex(pskey, pin->hdr.keylen, pin->hdr.strinfo.immds, pin->hdr.nstreams, 0);
	prrec = (runrec_st *)(runset.set);
	for(i=0; (unsigned)i<runset.count; i++, prrec++) {
		pkey->doc_id = prrec->doc_id;
		pkey->tag = IDD_RUNS;
		create_stream(pin, &dstr);
		write_stream(&dstr, &(prrec->run), sizeof(docrun_st));
		attach_stream(&dstr, pref);
		close_stream(&dstr);
		add_key(pin, pkey);
	}
	free(runset.set);
	m_log(".ndt files build finished.\n");
	return proceed;
}

*/

static int init_indexes(index_st *pin, int count, base_st *psrc, base_st *ptarget, char *pName)
{
	int i, j;
	index_st *ptrgt= pin;
#ifdef PTRS_IN_META
	if(ptarget != psrc-1){
		if(ptarget->str.fat){
			if(!create_index(ptarget, pName, ptrgt)) return 0;
		}
	}else
#endif
	if(!create_index(ptarget, pName, ptrgt)) return 0;
	for(i=0, pin++; i<count; i++) {
		if(!open_index(psrc+i, ptrgt->name ? ptrgt->name : pName, pin+i, 1)) {
			for(j=0; j<i; j++) close_index(pin+j);
			close_index(--pin);
			return 0;
		}
	}
	return 1;
}

