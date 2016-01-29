#include "shared/Core/fix/mpcxc.h"
#include <cstdio>

#include <cstring>
//#include <alloca.h>

#include <sys/stat.h>

#include "log.h"
#include "osdep.h"
#include "gopt.h"

static pgfile_st *pskf, *pdkf;
static streamfile_st *pssf, *pdsf;

#if defined(WIN32) || defined(__GO32__) || defined(__CYGWIN32__) || defined(__WIN32__)
	static char process_msg[]="\\|/-";
	static int process_tick=0;
#endif

int BlbHandles= -1, pBlbHandles= -1;
char *pPreBuff= 0;
long szPreBuff= 0;
long RsrcPosd[2]= { 0, 0}, *RsrcPos= RsrcPosd;

static u_int32_t opt_node(u_int32_t root, bthdr_st *phdr)
{
	u_int32_t *pchild, page, rcount;
	stref_st *pref;
	docrun_st run, *prun;
	char *key, *pPreData= 0;
	int i, nstr;
	long pgcount;
	stream_st *pstr;

	if(pskf->pfhdr->page_size == 4096){
	node_st_x2 node;

	pstr = (stream_st *)alloca(sizeof(stream_st));
	bzero((caddr_t)pstr, sizeof(stream_st));
	pstr->flags |= SF_NOALLOC;
	read_page(pskf, root, &node);
	key=node.keys;
	page = alloc_page(pdkf);
	if(node.ref0) node.ref0 = opt_node(node.ref0, phdr);
	for(i=0; i<node.count; i++, key += phdr->keylen+4) {
		for(nstr=0; nstr<phdr->nstreams; nstr++) {
			pref = get_stref_ex(key, phdr->keylen, phdr->strinfo.immds, phdr->nstreams, nstr);
			load_stream_ex(pssf, pref, pstr, &(phdr->strinfo));
			if(nstr==0 && opt_ndt && ((attrkey_st *)key)->tag == IDD_RUNS) {
				// flog("Moving doc %d\n", ((attrkey_st *)key)->doc_id);
				rcount = pstr->ref.size / sizeof(docrun_st);
				prun = (docrun_st *)(pstr->data);
				run.page = move_ndt_pages(prun->page, prun->count);
				run.count = prun->count;
				for(prun++, rcount--; rcount; rcount--, prun++) {
					move_ndt_pages(prun->page, prun->count);
					run.count += prun->count;
				}
				release_stream(pstr);
				create_stream_ex(pdsf, pstr, &(phdr->strinfo));
				write_stream(pstr, &run, sizeof(docrun_st));
				attach_stream(pstr, pref);
				close_stream(pstr);
			}
			else {
				if(nstr == 0 && phdr->keylen == 32 && phdr->nstreams == 2 && pref->size == 8){
					pPreData= pstr->data;
					// Blob //
				#ifndef	VERSION63
					if(BlbHandles == -1){
						char* preB= strrchr(pssf->pgfile.name, '.') + 1;
						memcpy(preB,"blb", 3);
						BlbHandles= c_io_open(pssf->pgfile.name, ACE_OS_O_RDONLY |ACE_OS_O_BINARY);
						memcpy(preB,"str", 3);
					}
				#endif
					c_io_lseek(BlbHandles, *(long*)pstr->data, ACE_OS_SEEK_SET);
					pref->size= *((long*)pstr->data + 1);
					// читаем страницами //
					pgcount= pref->size >> pssf->pgfile.pgpow;
					if(pref->size & ((1 << pssf->pgfile.pgpow)-1))
						pgcount++;
					pgcount <<= pssf->pgfile.pgpow;
					if(szPreBuff < pgcount){
						if(pPreBuff != 0)
							free(pPreBuff);
						szPreBuff= pgcount;
						pPreBuff= (char*)malloc(szPreBuff);
					}
					c_io_read(BlbHandles, pPreBuff, pgcount);
					/////////////////////////////////////////
					pstr->data= pPreBuff;
					pstr->ref.size= pref->size;
					/////////////////////////////////////////
				#ifndef	VERSION63
					if(pBlbHandles == -1){
						char *preB= strrchr(pdsf->pgfile.name, '.') + 1;
						memcpy(preB,"blb", 3);
						pBlbHandles= c_io_open(pdsf->pgfile.name,ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_BINARY | ACE_OS_O_WRONLY);
						memcpy(preB,"str", 3);
					}
				#endif
					if(pBlbHandles != -1){
						// сохраняем страницами //
						char *preB;
						long pgcount= pstr->ref.size >> pdsf->pgfile.pgpow;
						if(pstr->ref.size & ((1 << pdsf->pgfile.pgpow)-1))
							pgcount++;
						pgcount <<= pdsf->pgfile.pgpow;
						c_io_write(pBlbHandles, pstr->data, pgcount);
						*(RsrcPos+1)= pstr->ref.size;
						pstr->ref.size= 8;
						preB= pstr->data;
						pstr->data= (char*)RsrcPos;
						move_stream(pstr, pdsf, pref);
						*RsrcPos += pgcount;
						pstr->data= preB;
						pstr->ref.size= *(RsrcPos+1);
						//////////////////////////
					}else
						move_stream(pstr, pdsf, pref);
					if(pPreData != 0){
						pstr->data= pPreData;
						pref->size= pstr->ref.size= 8;
						pPreData= 0;
					}
				}else if(nstr == 0 && phdr->keylen == 32 && phdr->nstreams == 2){
					// Blob //
				#ifndef	VERSION63
					if(pBlbHandles == -1){
						char *preB= strrchr(pdsf->pgfile.name, '.') + 1;
						memcpy(preB,"blb", 3);
						pBlbHandles= c_io_open(pdsf->pgfile.name,ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_BINARY | ACE_OS_O_WRONLY);
						memcpy(preB,"str", 3);
					}
				#endif
					if(pBlbHandles != -1){
						// сохраняем страницами //
						char *preB;
						long pgcount= pstr->ref.size >> pdsf->pgfile.pgpow;
						if(pstr->ref.size & ((1 << pdsf->pgfile.pgpow)-1))
							pgcount++;
						pgcount <<= pdsf->pgfile.pgpow;
						c_io_write(pBlbHandles, pstr->data, pgcount);
						*(RsrcPos+1)= pstr->ref.size;
						pstr->ref.size= 8;
						preB= pstr->data;
						pstr->data= (char*)RsrcPos;
						move_stream(pstr, pdsf, pref);
						*RsrcPos += pgcount;
						pstr->data= preB;
						pstr->ref.size= *(RsrcPos+1);
						//////////////////////////
					}else
						move_stream(pstr, pdsf, pref);
				}else
					move_stream(pstr, pdsf, pref);
				release_stream(pstr);
			}
		}
		pchild = ((u_int32_t *)(key + phdr->keylen));
		if(*pchild) *pchild = opt_node(*pchild, phdr);
	}
	write_page(pdkf, page, &node);
#if defined(WIN32) || defined(__GO32__) || defined(__CYGWIN32__) || defined(__WIN32__)
	printf("\r%c",*(process_msg+(process_tick%4)));
	process_tick++;
#endif
	}else{
	node_st node;

	pstr = (stream_st *)alloca(sizeof(stream_st));
	bzero((caddr_t)pstr, sizeof(stream_st));
	pstr->flags |= SF_NOALLOC;
	read_page(pskf, root, &node);
	key=node.keys;
	page = alloc_page(pdkf);
	if(node.ref0) node.ref0 = opt_node(node.ref0, phdr);
	for(i=0; i<node.count; i++, key += phdr->keylen+4) {
		for(nstr=0; nstr<phdr->nstreams; nstr++) {
			pref = get_stref_ex(key, phdr->keylen, phdr->strinfo.immds, phdr->nstreams, nstr);
			load_stream_ex(pssf, pref, pstr, &(phdr->strinfo));
			if(nstr==0 && opt_ndt && ((attrkey_st *)key)->tag == IDD_RUNS) {
				// flog("Moving doc %d\n", ((attrkey_st *)key)->doc_id);
				rcount = pstr->ref.size / sizeof(docrun_st);
				prun = (docrun_st *)(pstr->data);
				run.page = move_ndt_pages(prun->page, prun->count);
				run.count = prun->count;
				for(prun++, rcount--; rcount; rcount--, prun++) {
					move_ndt_pages(prun->page, prun->count);
					run.count += prun->count;
				}
				release_stream(pstr);
				create_stream_ex(pdsf, pstr, &(phdr->strinfo));
				write_stream(pstr, &run, sizeof(docrun_st));
				attach_stream(pstr, pref);
				close_stream(pstr);
			}
			else {
				if(nstr == 0 && phdr->keylen == 32 && phdr->nstreams == 2 && pref->size == 8){
					pPreData= pstr->data;
					// Blob //
				#ifndef	VERSION63
					if(BlbHandles == -1){
						char* preB= strrchr(pssf->pgfile.name, '.') + 1;
						memcpy(preB,"blb", 3);
						BlbHandles= c_io_open(pssf->pgfile.name, ACE_OS_O_RDONLY |ACE_OS_O_BINARY);
						memcpy(preB,"str", 3);
					}
				#endif
					c_io_lseek(BlbHandles, *(long*)pstr->data, ACE_OS_SEEK_SET);
					pref->size= *((long*)pstr->data + 1);
					// читаем страницами //
					pgcount= pref->size >> pssf->pgfile.pgpow;
					if(pref->size & ((1 << pssf->pgfile.pgpow)-1))
						pgcount++;
					pgcount <<= pssf->pgfile.pgpow;
					if(szPreBuff < pgcount){
						if(pPreBuff != 0)
							free(pPreBuff);
						szPreBuff= pgcount;
						pPreBuff= (char*)malloc(szPreBuff);
					}
					c_io_read(BlbHandles, pPreBuff, pgcount);
					/////////////////////////////////////////
					pstr->data= pPreBuff;
					pstr->ref.size= pref->size;
					/////////////////////////////////////////
				#ifndef	VERSION63
					if(pBlbHandles == -1){
						char *preB= strrchr(pdsf->pgfile.name, '.') + 1;
						memcpy(preB,"blb", 3);
						pBlbHandles= c_io_open(pdsf->pgfile.name,ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_BINARY | ACE_OS_O_WRONLY);
						memcpy(preB,"str", 3);
					}
				#endif
					if(pBlbHandles != -1){
						// сохраняем страницами //
						char *preB;
						long pgcount= pstr->ref.size >> pdsf->pgfile.pgpow;
						if(pstr->ref.size & ((1 << pdsf->pgfile.pgpow)-1))
							pgcount++;
						pgcount <<= pdsf->pgfile.pgpow;
						c_io_write(pBlbHandles, pstr->data, pgcount);
						*(RsrcPos+1)= pstr->ref.size;
						pstr->ref.size= 8;
						preB= pstr->data;
						pstr->data= (char*)RsrcPos;
						move_stream(pstr, pdsf, pref);
						*RsrcPos += pgcount;
						pstr->data= preB;
						pstr->ref.size= *(RsrcPos+1);
						//////////////////////////
					}else
						move_stream(pstr, pdsf, pref);
					if(pPreData != 0){
						pstr->data= pPreData;
						pref->size= pstr->ref.size= 8;
						pPreData= 0;
					}
				}else if(nstr == 0 && phdr->keylen == 32 && phdr->nstreams == 2){
					// Blob //
				#ifndef	VERSION63
					if(pBlbHandles == -1){
						char *preB= strrchr(pdsf->pgfile.name, '.') + 1;
						memcpy(preB,"blb", 3);
						pBlbHandles= c_io_open(pdsf->pgfile.name,ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_BINARY | ACE_OS_O_WRONLY);
						memcpy(preB,"str", 3);
					}
				#endif
					if(pBlbHandles != -1){
						// сохраняем страницами //
						char *preB;
						long pgcount= pstr->ref.size >> pdsf->pgfile.pgpow;
						if(pstr->ref.size & ((1 << pdsf->pgfile.pgpow)-1))
							pgcount++;
						pgcount <<= pdsf->pgfile.pgpow;
						c_io_write(pBlbHandles, pstr->data, pgcount);
						*(RsrcPos+1)= pstr->ref.size;
						pstr->ref.size= 8;
						preB= pstr->data;
						pstr->data= (char*)RsrcPos;
						move_stream(pstr, pdsf, pref);
						*RsrcPos += pgcount;
						pstr->data= preB;
						pstr->ref.size= *(RsrcPos+1);
						//////////////////////////
					}else
						move_stream(pstr, pdsf, pref);
				}else
					move_stream(pstr, pdsf, pref);
				release_stream(pstr);
			}
		}
		pchild = ((u_int32_t *)(key + phdr->keylen));
		if(*pchild) *pchild = opt_node(*pchild, phdr);
	}
	write_page(pdkf, page, &node);
#if defined(WIN32) || defined(__GO32__) || defined(__CYGWIN32__) || defined(__WIN32__)
	printf("\r%c",*(process_msg+(process_tick%4)));
	process_tick++;
#endif
	}
	return page;
}

char FormtMsg[]= "\r%d B-trees processed.\t%d\t\tkeys moved from (%s).";
u_int32_t root;
int treecnt = 0;
u_int32_t opt_tree(base_st *psrc, bthdr_st *phdr, base_st *pdest, char *pname)
{
	pskf = &(psrc->key);
	pdkf = &(pdest->key);
	pssf = &(psrc->str);
	pdsf = &(pdest->str);
#ifndef MULTI_INDEX_STREAM_FILE
	if(opt_ndt)
		set_ndt_files(&(psrc->ndt), &(pdest->ndt));
#endif
	if(phdr->key_count)
		root = opt_node(phdr->root, phdr);
	else root = alloc_page(pdkf);
#ifndef MULTI_INDEX_STREAM_FILE
	if(opt_ndt) {
		free_ndt_files();
		opt_ndt = 0;
	}
#endif
	treecnt++;
	printf(FormtMsg, treecnt, phdr->key_count, pname);
	return root;
}

u_int32_t opt_treeIndex(index_st *psrc, bthdr_st *phdr, index_st *pdest, char *pname)
{
	pskf = psrc->pf;
	pdkf = pdest->pf;
	pssf = psrc->str;
	pdsf = pdest->str;
	if(opt_ndt)
		set_ndt_files(&(psrc->pbase->ndt), &(pdest->pbase->ndt));
	if(phdr->key_count && pskf->pfhdr->page_size == pdkf->pfhdr->page_size)
		root = opt_node(phdr->root, phdr);
	else
		root = alloc_page(pdkf);
	if(opt_ndt) {
		free_ndt_files();
		opt_ndt = 0;
	}
	treecnt++;
	printf(FormtMsg, treecnt, phdr->key_count, pname);
	return root;
}
