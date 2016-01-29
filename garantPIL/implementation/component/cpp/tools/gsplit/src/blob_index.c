#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include <sys/stat.h>
#include <fcntl.h> // GARANT_MSVC7 for ACE_OS_O_RDONLY-like constants

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "../../../libs/mrglib/src/log.h"

#include "toys.h"

#include "progress.h"

extern set_st *segset;
extern void otherIncProgress(void *);

extern long* sameblobs, sameblobs_count;

long BlobTypesDouble[]= {	678, EOT_PIC,
							679, EOT_RTF,
							680, EOT_URL,
							681, EOT_MSG,
							682, EOT_XLS,
							683, EOT_MP3 };

int BlobTypesDoubleCount= sizeof(BlobTypesDouble)/sizeof(long);

int isBlobTypesTag(long Tst, int count)
{
	while(count)
	{
		count -= 2;
		if(BlobTypesDouble[count] == Tst)
			return count;
	}
	return -1;
}

int isSelectedType( long *pType, int count, void *pHeader )
{
	int ii;
	while(count--){
		if(	(ii= isBlobTypesTag(*pType, BlobTypesDoubleCount)) != -1
				&&
			((struct ObjInfo*)pHeader)->type
				== (unsigned long)BlobTypesDouble[ii+1])
			return 1;
		pType++;
	}
	return 0;
}

#ifdef PTRS_IN_META
	extern void add_key_as_buf(index_st *pin, void *pkey);
	extern void move_stream_only(stream_st *pstr, streamfile_st *pdest, stref_st *pref);
#else
	#define add_key_as_buf add_key
	#define move_stream_only move_stream
#endif

int make_blob_index(void *pCntx, index_st *pdest, int count, index_st *psrc, set_st *doclist)
{
	iter_st *pit;
	stream_st *pstr, *pstr2;
	int i, kpp, proceed, repeat= 0, *pBlbHandles, BlbHandles= -1;
	char *pkey, **ppDocFlags, *preB, *pPreBuff= 0, *pPreData= 0;
	stref_st *pstref, *pstref2, *pdemo_ref;
	set_st belongs, demo_tst;

	long *pDocAlloc, *pDocCount, *pRsrcPos, pgcount, szPreBuff= 0;

	pdemo_ref= (stref_st *)alloca(count*sizeof(*pdemo_ref));
	for(i= 0; i < count;i++){
		pdemo_ref[i].size= 0;
	}
	proceed = psrc->hdr.key_count;
	kpp = get_index_weight(psrc->name);
	kpp = (kpp) ? proceed / kpp : proceed+1;
	proceed = 0;
	flog("Processing index: \"%s\"...\t", psrc->name);
	pit = (iter_st *)alloca(sizeof(iter_st));

	i= sizeof(stream_st)*2 + sizeof(char*)*count + sizeof(long)*count*2;
	pstr = (stream_st *)alloca(i);
	bzero((caddr_t)pstr, i);

	ppDocFlags= (char**)((char*)pstr + sizeof(stream_st)*2);
	pDocAlloc= (long*)((char*)ppDocFlags + sizeof(long)*count);
	pDocCount = pDocAlloc + count;

	pBlbHandles= (int*)alloca(sizeof(int)*count);
	i= sizeof(long)*(count+count);
	pRsrcPos= (long*)alloca(i);
	bzero(pRsrcPos, i);

	pstr2 = pstr+1;
	pstr->flags |= SF_USELOCAL;
	pstr2->flags |= SF_USELOCAL;
	belongs.reclen = 2;
	belongs.rcmp = shrtcmp;

   do{
	for(init_iter(psrc, pit), pkey=first_key(pit); pkey; pkey=next_key(pit)) {
		pstref2 = get_stref(pit, 1);
		load_stream_ex(pit->str, pstref2, pstr2, &(pit->strinfo));
		belongs.set = pstr2->data;
		belongs.count = pstr2->ref.size >> 1;
		for(i=0, pstref= 0; i<count; i++) {
			if(	(sameblobs_count && bsearch (pkey, sameblobs, sameblobs_count, sizeof (long), longcmp)) || 
				((segset[i].count_blob_docs == 0l && !segset[i].isDocsList
						&& set_isect(segset+i, &belongs))
					||
				(segset[i].count_blob_docs > 0l &&
					((segset[i].isDocsList &&
						( (*(long*)(segset[i].set_blob_docs)
							<= BlobTypesDouble[BlobTypesDoubleCount-2] &&
						isSelectedType(	(long*)segset[i].set_blob_docs,
											segset[i].count_blob_docs,
											pstr->data))
							||
					(*(long*)(segset[i].set_blob_docs)
							> BlobTypesDouble[BlobTypesDoubleCount-2] &&
						bsearch(	pkey, segset[i].set_blob_docs,
									segset[i].count_blob_docs, 4, longcmp)))))
						|| (!segset[i].isDocsList && set_isect(segset+i, &belongs)))))
			{
			  if(pstref == 0){
				pstref = get_stref(pit, 0);
				load_stream_ex(pit->str, pstref, pstr, &(pit->strinfo));
				if(pstref->size == 8){
					if(BlbHandles == -1){
						preB= strrchr(pit->pf->name, '.') + 1;
						memcpy(preB,"blb", 3);
						BlbHandles= c_io_open(pit->pf->name, ACE_OS_O_RDONLY |ACE_OS_O_BINARY);
						memcpy(preB,"str", 3);
					}
					c_io_lseek(BlbHandles, *(long*)pstr->data, ACE_OS_SEEK_SET);
					pstref->size= *((long*)pstr->data + 1);
					pPreData= pstr->data;
					// читаем страницами //
					pgcount= pstref->size >> pdest[i].str->pgfile.pgpow;
					if(pstref->size & ((1 << pdest[i].str->pgfile.pgpow)-1))
						pgcount++;
					pgcount <<= pdest[i].str->pgfile.pgpow;
					if(szPreBuff < pgcount){
						if(pPreBuff != 0)
							free(pPreBuff);
						szPreBuff= pgcount;
						pPreBuff= (char*)malloc(szPreBuff);
					}
					c_io_read(BlbHandles, pPreBuff, pgcount);
					/////////////////////////////////////////
					pstr->data= pPreBuff;
					pstr->ref.size= pstref->size;

				}
			  }
			  if(pDocAlloc[i] != -1
								&& !segset[i].isDocsList
													&& segset[i].count_blob_docs != 0l){
				if(pDocCount[i] == pDocAlloc[i]){
					char *pNew= (char*)malloc((pDocAlloc[i] += 10000));
					if(ppDocFlags[i] != 0){
						memcpy(pNew, ppDocFlags[i], pDocCount[i]);
						free(ppDocFlags[i]);
					}
					ppDocFlags[i]= pNew;
				}
				if( (*(long*)(segset[i].set_blob_docs)
							<= BlobTypesDouble[BlobTypesDoubleCount-2] &&
						!isSelectedType(	(long*)segset[i].set_blob_docs,
											segset[i].count_blob_docs,
											pstr->data))
							||
					(*(long*)(segset[i].set_blob_docs)
							> BlobTypesDouble[BlobTypesDoubleCount-2] &&
						bsearch(	pkey, segset[i].set_blob_docs,
									segset[i].count_blob_docs, 4, longcmp) == 0)){
					// Не входит в подмножество выделенных //
					*(ppDocFlags[i] + pDocCount[i])= 1;
				}else
					// Входит в подмножество выделенных //
					*(ppDocFlags[i] + pDocCount[i])= 0;
				pDocCount[i]++;
			  }else if(ppDocFlags[i] == 0 || *(ppDocFlags[i]+(pDocCount[i]++))){
				if(segset[i].isExtBlob == 1){
					segset[i].isExtBlob++;
					preB= strrchr(pdest[i].str->pgfile.name, '.') + 1;
					memcpy(preB,"blb", 3);
					pBlbHandles[i]= c_io_open(pdest[i].str->pgfile.name,
											ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_BINARY | ACE_OS_O_WRONLY
											);
					memcpy(preB,"str", 3);
				}
				if(segset[i].isExtBlob){
					// сохраняем страницами //
					pgcount= pstr->ref.size >> pdest[i].str->pgfile.pgpow;
					if(pstr->ref.size & ((1 << pdest[i].str->pgfile.pgpow)-1))
						pgcount++;
					pgcount <<= pdest[i].str->pgfile.pgpow;
					c_io_write(pBlbHandles[i], pstr->data, pgcount);
					//////////////////////////
					pRsrcPos[i*2+1]= pstr->ref.size;
					pstr->ref.size= 8;
					preB= pstr->data;
					pstr->data= (char*)(pRsrcPos+i*2);
					//memcpy(pstr->data, pRsrcPos+i*2, sizeof(long)+sizeof(long));
					move_stream_only(pstr, pdest[i].str, pstref);
					pRsrcPos[i*2] += pgcount;
					pstr->data= preB;
					pstr->ref.size= pRsrcPos[i*2+1];
					//////////////////////////
					move_stream_only(pstr2, pdest[i].str, pstref2);
					add_key_as_buf(pdest+i, pkey);
				}else if(!repeat){
					if(pdemo_ref[i].size && (ID_FLASH_LO) <= (*(int*)pkey) && (ID_FLASH_HI) >= (*(int*)pkey)){
						int tst_seg= 39;
						demo_tst.set= (char*)&tst_seg;
						demo_tst.count= 1;
						if(!set_isect(&demo_tst, &belongs))
							*pstref= pdemo_ref[i];
						else
							move_stream_only(pstr, pdest[i].str, pstref);
					}else
						move_stream_only(pstr, pdest[i].str, pstref);
					move_stream_only(pstr2, pdest[i].str, pstref2);
					if((*(int*)pkey) == 100011 && doclist[i].put_first_disk == 2){
						pdemo_ref[i] = *pstref;
					}
					add_key_as_buf(pdest+i, pkey);
				}
			  }else if(repeat && pDocAlloc[i] == -1){
				move_stream_only(pstr, pdest[i].str, pstref);
				move_stream_only(pstr2, pdest[i].str, pstref2);
				add_key_as_buf(pdest+i, pkey);
			  }
			}
		}
		if(pPreData != 0){
			pstr->data= pPreData;
			pstref->size= pstr->ref.size= 8;
			pPreData= 0;
		}
		pstref= 0;
		release_stream(pstr2);
		release_stream(pstr);
		proceed++;
		if(proceed == kpp) {
			if(pDocAlloc[i] != -1)
				otherIncProgress(pCntx);
			proceed = 0;
		}
	}
	for(i=0, repeat= 0;i<count; i++){
		if(pDocAlloc[i] != -1){
			if(pDocCount[i]){
				repeat+=2;
				pDocAlloc[i]= -1;
			}else{
				if(segset[i].isExtBlob == 2){
					unsigned long size= c_io_lseek(pBlbHandles[i], 0, ACE_OS_SEEK_END);
					c_io_close(pBlbHandles[i]);
					set_info(&pdest[i].str->pgfile, "BLB", &size, sizeof(size));
				}
				segset[i].isExtBlob= 0;
			}
		}else if(pDocCount[i])
			free(ppDocFlags[i]);
		pDocCount[i]= 0;
	}
   }while(++repeat > 2);

	pstr->flags |= SF_FREELOCAL;
	release_stream(pstr);
	pstr2->flags |= SF_FREELOCAL;
	release_stream(pstr);
	release_iter(pit);
	flog("Done.\n");
	hide_message();
	for(i=0; i<count; i++){
		segset[i].count_blob_docs= pRsrcPos[i*2];
	}
	if(BlbHandles != -1){
		c_io_close(BlbHandles);
		free(pPreBuff);
	}
	return 0;
}














