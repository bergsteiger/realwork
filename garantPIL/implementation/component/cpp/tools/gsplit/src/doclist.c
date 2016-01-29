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
#include "message.h"

// GARANT_MSVC7 obsolete definitions
#ifndef TRUE
#define TRUE 1
#endif
#ifndef FALSE
#define FALSE 0
#endif

extern set_st *segset;
extern char **segname;
#ifdef MULTI_INDEX_STREAM_FILE
extern int iAddSkipedDoc;
#endif

extern cmpfunc_ft get_cmpfunc(int);

#ifdef __GO32__
	#define STEP_ALLOC_FOR_DOC_LIST 4096
#else
	#define STEP_ALLOC_FOR_DOC_LIST 0xffff
#endif

extern void ShowMessageFromContext(void *pCurrent, char *CurrMsg);
extern void otherIncProgress(void *);
extern int CIB_AsUpdated(void *);
extern int CopyAsFromContext(void *, char *, char *, int);

extern int set_isect_belongs(set_st *ps1, set_st *ps2);

extern long* samedocs, samedocs_count;

set_st *create_set_doclists(void *pCntx, index_st *pin, int count)
{
	set_st *doclist;
	attrkey_st key, *pkey;
	iter_st it;
	stream_st stream;
	int i, retV;
	set_st belongs; 
	u_int32_t **doc;
#ifndef OLD_SECT
	unsigned short	*firstDiskSeg= (short*)calloc(count,sizeof(short)*0xffff),
					*secndDiskSeg= (short*)calloc(count,sizeof(short)*0xffff);
	char **pTmp0= (char**)alloca(count*sizeof(char*));
	int *firstDiskSegCnt= (int*)alloca(count*sizeof(int)),
		*secndDiskSegCnt= (int*)alloca(count*sizeof(int)),
		*pTmp1= (int*)alloca(count*sizeof(int)),
		*secndFind= (int*)alloca(count*sizeof(int));
#endif

	unsigned char **segZ;

	ShowMessageFromContext(pCntx, get_message(MSG_COLLECT));
	flog("Collecting target bases document lists...\t");
	otherIncProgress(pCntx);
	doc = (u_int32_t **)alloca(count*sizeof(u_int32_t *));
	segZ = (unsigned char **)alloca(count*sizeof(unsigned char *));
	doclist = (set_st *)calloc(count, sizeof(set_st));
	for(i=0; i<count; i++) {
		doclist[i].reclen = 4;
		doclist[i].dtype = DT_INT32;
		doclist[i].rcmp = get_cmpfunc(DT_INT32);
#ifndef OLD_SECT
		firstDiskSegCnt[i]= (unsigned short)0;
		secndFind[i]= secndDiskSegCnt[i]= 0;
#endif
	}
	bzero((caddr_t)&stream, sizeof(stream));
	belongs.dtype = DT_INT16;
	belongs.reclen = 2;
	belongs.rcmp = get_cmpfunc(DT_INT16);

	if (samedocs_count) {
		doclist[0].count = 0;
		doclist[0].alloc = 0;
		set_alloc(doclist, STEP_ALLOC_FOR_DOC_LIST * 4);
		doc[0] = (u_int32_t *)doclist[0].set;
		segZ[0] = doclist[0].seg_set;
	} else for(i=0; i<count; i++) {
		doclist[i].iMulti= segset[i].iMulti;
		doclist[i].put_first_disk= segset[i].put_first_disk;
		if(get_info(&pin->str->pgfile, ID_PACKED_NDT, 0))
			doclist[i].NDTCopy= 1;
		if((doclist[i].isDocsList= segset[i].isDocsList))
		{
			retV= segset[i].count_blob_docs;
			while(retV--){
				*((long*)segset[i].set_blob_docs + retV + 1)
							= *((long*)segset[i].set_blob_docs + retV);
			}
			segset[i].set_blob_docs += sizeof(long);
			retV= segset[i].count;
			while(retV--){
				*((long*)segset[i].set_docs + retV + 1)
							= *((long*)segset[i].set_docs + retV);
			}
			*(long*)segset[i].set_docs= (long)segset[i].count;
			doclist[i].sub_seg_set= segset[i].set_docs;
		}else{
#ifndef OLD_SECT
			if(segset[i].sub_seg_set){
				int jj= 0, Cnt0= (int)(((unsigned short*)segset[i].sub_seg_set)[0]-((unsigned short*)segset[i].sub_seg_set)[0xffff]),
							CntT= (int)(((unsigned short*)segset[i].sub_seg_set)[0xffff]),
							nxtPos= 1, nxtPosT= 1, NewCnt= 0;
				unsigned short Nxt= (short)*((unsigned short*)segset[i].sub_seg_set+nxtPos++),
								NxtT= (short)(((unsigned short*)segset[i].sub_seg_set)[0xffff+nxtPosT++]);
				while(jj < (int)segset[i].count){
					if(*((unsigned short*)segset[i].set+jj) < Nxt){
						if(!(((unsigned short*)segset[i].sub_seg_set)[0xffff]) || (unsigned short)*((unsigned short*)segset[i].set+jj) < NxtT){
							firstDiskSeg[(0xffff*i)+firstDiskSegCnt[i]++]= *((unsigned short*)segset[i].set+jj++);
						}else{
							if(nxtPosT < CntT){
								NxtT= (((unsigned short*)segset[i].sub_seg_set)[0xffff+nxtPosT++]);
							}else{
								NxtT= 0xffff;
								jj++;
							}
						}
					}else{
						secndDiskSeg[(0xffff*i)+secndDiskSegCnt[i]++]= Nxt;
						if(nxtPos < Cnt0){
							Nxt= *(((unsigned short*)segset[i].sub_seg_set)+nxtPos++);
						}else{
							Nxt= 0xffff;
							if(!segset[i].put_first_disk){
								// в НЕ демо, данный сегмент дублируется !
								jj++;
							}
						}
					}
				}
				pTmp0[i]= segset[i].set;
				pTmp1[i]= segset[i].count;
			}
#endif
			doclist[i].sub_seg_set= segset[i].sub_seg_set;
		}

		doclist[i].pSourceBase= segset[i].pSourceBase;
		set_alloc(doclist+i, STEP_ALLOC_FOR_DOC_LIST * 4);
		doc[i] = (u_int32_t *)doclist[i].set;
		segZ[i] = doclist[i].seg_set;
	}
	init_iter(pin, &it);
	key.doc_id = 100000;
	key.tag = IDD_BASES;
	locate_key(&it, &key);
	pkey = (attrkey_st *)(it.pkey);
	i = 0;
	for(;pkey->tag == IDD_BASES; pkey=next_key(&it)) {
		if(!load_stream(&it, &stream))
			continue;

		if (samedocs_count) {
			if (bsearch (&pkey->doc_id, samedocs, samedocs_count, sizeof (long), longcmp)) {
				if(doclist[i].count == doclist[i].alloc) {
					set_realloc(doclist+i, doclist[i].alloc+STEP_ALLOC_FOR_DOC_LIST);
					doc[i] = (u_int32_t *)doclist[i].set;
					doc[i] += doclist[i].count;
					if(doclist[i].sub_seg_set != 0){
						segZ[i] = doclist[i].seg_set;
						segZ[i] += doclist[i].count * doclist[i].reclen;
					}
				}
				doclist[i].count++;
				*(doc[i]) = pkey->doc_id;
				doc[i]++;
			}
			continue;
		}

		belongs.set = stream.data;
		belongs.count = stream.ref.size/sizeof(u_int16_t);
		for(i=0; i<count; i++) {
			retV= 0xffff;
			if(	(doclist[i].isDocsList
					&& (!doclist[i].pSourceBase
							|| bsearch(pkey, doclist[i].sub_seg_set+sizeof(long),
								*(long*)doclist[i].sub_seg_set, 4, longcmp)))
#ifndef OLD_SECT
				|| (!doclist[i].isDocsList &&
						((!segset[i].sub_seg_set && (retV= set_isect_belongs(segset+i, &belongs)))
							|| (segset[i].sub_seg_set
&& //(
	segset[i].put_first_disk //|| pkey->doc_id > BIG_INFO_DOC + BIG_INFO_COUNT && pkey->doc_id < BIG_INFO_DOC )
									&& (segset[i].set= (char*)(firstDiskSeg+(0xffff*i)))
									&& (segset[i].count= firstDiskSegCnt[i])
									&& (retV= set_isect_belongs(segset+i, &belongs)))))
				|| (*(u_int16_t*)(secndDiskSeg+(0xffff*i))!= full_text_segment &&
						((!doclist[i].isDocsList && segset[i].sub_seg_set
								//&& ( pkey->doc_id > BIG_INFO_DOC + BIG_INFO_COUNT || pkey->doc_id < BIG_INFO_DOC )
								&& (segset[i].set= (char*)(secndDiskSeg+(0xffff*i)))
								&& (segset[i].count= secndDiskSegCnt[i])
								&& (retV= set_isect_belongs(segset+i, &belongs)))
						|| (!doclist[i].isDocsList && segset[i].sub_seg_set
								//&& ( pkey->doc_id > BIG_INFO_DOC + BIG_INFO_COUNT || pkey->doc_id < BIG_INFO_DOC )
								&& ((unsigned short*)segset[i].sub_seg_set)[0xffff]
								&& (segset[i].set= pTmp0[i])
								&& (segset[i].count= pTmp1[i])
								&& (retV= set_isect_belongs(segset+i, &belongs)))))
#else
				|| (!doclist[i].isDocsList && (retV= set_isect_belongs(segset+i, &belongs)))
#endif
				) {
				if(doclist[i].count == doclist[i].alloc) {
					set_realloc(doclist+i, doclist[i].alloc+STEP_ALLOC_FOR_DOC_LIST);
					doc[i] = (u_int32_t *)doclist[i].set;
					doc[i] += doclist[i].count;
					if(doclist[i].sub_seg_set != 0){
						segZ[i] = doclist[i].seg_set;
						segZ[i] += doclist[i].count * doclist[i].reclen;
					}
				}
				doclist[i].count++;
				*(doc[i]) = pkey->doc_id;
				doc[i]++;
				if(doclist[i].sub_seg_set != 0){
					if(retV != 0xffff){
						if(segset[i].put_first_disk){
							set_st tmp_tst_demo;
							tmp_tst_demo.count= 1;
							tmp_tst_demo.set= segset[i].sub_seg_set+sizeof(u_int16_t);
							if(set_isect_belongs(&tmp_tst_demo, &belongs))
								*((unsigned short*)segZ[i]) = (unsigned short)0;
							else
								*((unsigned short*)segZ[i]) = ((u_int16_t *)segset[i].sub_seg_set)[1];
						}else
							*((unsigned short*)segZ[i]) = (unsigned short)retV;
					}else
						*(segZ[i]) = 0;
					segZ[i] += doclist[i].reclen;
				}
			}
#ifdef MULTI_INDEX_STREAM_FILE
			else if(iAddSkipedDoc){
				if(!(doclist[i].SkipDocCount % 4096)){
					doclist[i].pSkipDoc=
						(long*)realloc(doclist[i].pSkipDoc, (doclist[i].SkipDocCount+4096)*sizeof(long));
				}
				doclist[i].pSkipDoc[doclist[i].SkipDocCount++]= pkey->doc_id;

			}
#endif
		}
	}
#ifdef MULTI_INDEX_STREAM_FILE
	for(i=0; i<count; i++) {
		if(!(doclist[i].SkipDocCount % 4096)){
			doclist[i].pSkipDoc=
				(long*)realloc(doclist[i].pSkipDoc, (doclist[i].SkipDocCount+4096)*sizeof(long));
		}
		doclist[i].pSkipDoc[doclist[i].SkipDocCount++]= (long)0x7fffffff;
	}
#endif
	for(i=0; i<count; i++) {
		doclist[i].seg_32= (unsigned char *)calloc(sizeof(u_int32_t), doclist[i].count);
	}
#ifndef OLD_SECT
	for(i=0; i<count; i++) {
		if(segset[i].sub_seg_set && !doclist[i].isDocsList ){
			segset[i].set= pTmp0[i];
			segset[i].count= pTmp1[i];
		}
	}
	free(firstDiskSeg);
	free(secndDiskSeg);
#endif
	otherIncProgress(pCntx);
	release_iter(&it);
	flog("Done.\n");
	hide_message();
	return doclist;
}

extern int curr_open_mode;
int makeDocListFromBase(set_st *pNew, const char* pBaseName, base_st *pLastBase)
{
	index_st indH;
	iter_st itH;
	stream_st strH;

	base_st *pbase;
	index_st ind;
	iter_st it;
	stream_st stream;
	attrkey_st key, *pkey;

	index_st ind_;
	iter_st it_;
	stream_st stream_;
	attrkey_st key_, *pkey_= 0;
	stamp_st *pSrc0, *pSrc1;

	int offset= BASE_NAME_SIZE+sizeof(long)+sizeof(long);
	u_int32_t alloced= 0, alloced1= 0, dwTmp;

	char *pEnd= strchr(pBaseName, '&'), *tmp;

	bzero((caddr_t)&ind, sizeof(ind));
	pbase= (base_st *)alloca(sizeof(base_st));
	if(pEnd == 0 && (tmp= strchr(pBaseName, '\0')) < pEnd){
		if(tmp)
			pEnd= tmp;
	}
	bzero((caddr_t)&indH, sizeof(indH));
	bzero((caddr_t)&itH, sizeof(itH));
	bzero((caddr_t)&strH, sizeof(strH));
	if(	pEnd == 0 || (*pEnd = '\0') != 0 || pbase == 0
			||
#ifndef BRDR32
		!open_base(pBaseName, pbase, curr_open_mode)
#else
		TRUE
#endif
			||
		!open_index(pbase, "Aux", &indH, 1)
			||
		!open_index(pbase, "Attrs", &ind, 1)){
		printf("\rError: Can't open Base(%s) !", pBaseName);
		return 0;
	}

	printf("\rCheck Base(%s) ...", pBaseName);

	init_iter(&indH, &itH);
	locate_key(&itH, "Base");
	load_stream(&itH, &strH);

	if(!(pNew->pSourceBaseHere= malloc(strH.ref.size + sizeof(long)
										+ 255*sizeof(u_int16_t)))
		||
		!memcpy((char*)pNew->pSourceBaseHere+sizeof(long),strH.data, strH.ref.size)){
		printf("\rError: Not memory !");
		return 0;
	}
	*(long*)pNew->pSourceBaseHere= strH.ref.size;
	pEnd= (char*)pNew->pSourceBaseHere+strH.ref.size+sizeof(long)
			+sizeof(*pNew->pSourceBaseHere);

	locate_key(&itH, "Here");
	load_stream(&itH, &strH);

	if(!memcpy(pEnd, strH.data, strH.ref.size)){
		printf("\rError: Not memory !");
		return 0;
	}
	*((u_int16_t*)pEnd-1)= (u_int16_t)strH.ref.size;

	release_stream(&strH);
	release_iter(&itH);
	close_index(&indH);

	init_iter(&ind, &it);
	key.doc_id = 100000;
	key.tag = IDD_INFO;
	locate_key(&it, &key);
	pkey = (attrkey_st *)(it.pkey);
	bzero((caddr_t)&stream, sizeof(stream));
	bzero((caddr_t)&stream_, sizeof(stream));
	if(pNew->count){
		pNew->isIgnoreHere= pNew->count;
		pNew->set_docs= pNew->set;
		pNew->count= 0;
		pNew->set= 0;
	}
	for(;pkey && pkey->tag == IDD_INFO; pkey=next_key(&it)) {
		if(!load_stream(&it, &stream))
			continue;
		pSrc1= (stamp_st*)((char *)stream.data+offset);
		if(pkey_ == 0){
			if(!open_index(pLastBase, "Attrs", &ind_, 1))
				return -3;
			init_iter(&ind_, &it_);
			key_.doc_id = 100000;
			key_.tag = IDD_INFO;
			locate_key(&it_, &key_);
			pkey_ = (attrkey_st *)(it_.pkey);
		}
		do{
			for(;pkey_ && pkey_->tag == IDD_INFO && pkey_->doc_id < pkey->doc_id; pkey_=next_key(&it_))
		if(pNew->isIgnoreHere && *(u_int32_t*)pkey_ == *(u_int32_t*)pNew->set_docs){
			// Новый документ //
			pNew->isIgnoreHere--;
			pNew->set_docs += sizeof(u_int32_t);
			// Документ изменён //
			if(pNew->count+1 > alloced){
				alloced += 4096;
				if(!(pNew->set= realloc(pNew->set, alloced*sizeof(u_int32_t))))
					return -5;
			}
			((u_int32_t*)pNew->set)[pNew->count]= pkey_->doc_id;
			pNew->count++;
		}
			if(pkey_){
				dwTmp= pkey_->doc_id;
				if(!load_stream(&it_, &stream_)){
					printf("Error !");
					return -4;
				}
			}else
				dwTmp= 0xFFFFFFFF;
			while(pkey && dwTmp > pkey->doc_id){
				// Документ есть только в исходной //
#ifdef CREATE_ETALON_DOCS
				if(pNew->countEtaln+1 > alloced1){
					alloced1 += 4096;
					if(!(pNew->setEtaln= realloc(pNew->setEtaln, alloced1*sizeof(u_int32_t)))){
						printf("Error !");
						return -5;
					}
				}
				((u_int32_t*)pNew->setEtaln)[pNew->countEtaln]= pkey_->doc_id;
				pNew->countEtaln++;
#endif
				for(pkey=next_key(&it); pkey && pkey->tag == IDD_INFO; pkey=next_key(&it)) {
					if(!load_stream(&it, &stream))
						continue;
					break;
				}
			}
		}while(pkey && pkey_->doc_id < pkey->doc_id);
		if(pkey == 0){
			// Последний уникальный документ в исходной //
			break;
		}
		pSrc0= (stamp_st*)((char *)stream_.data+offset);
		if(	1
			/*pSrc0->date.year > pSrc1->date.year
			||
			(pSrc0->date.year == pSrc1->date.year && pSrc0->date.month > pSrc1->date.month)
			||
			(pSrc0->date.year == pSrc1->date.year && pSrc0->date.month == pSrc1->date.month && pSrc0->date.day > (pSrc1->date.day))*/
			){
			// Документ изменён //
			if(pNew->count+1 > alloced){
				alloced += 4096;
				if(!(pNew->set= realloc(pNew->set, alloced*sizeof(u_int32_t))))
					return -5;
			}
			((u_int32_t*)pNew->set)[pNew->count]= dwTmp;
			pNew->count++;
		}
#ifdef CREATE_ETALON_DOCS
		else{
			// Документ из исходной - свежее //
			if(pNew->countEtaln+1 > alloced1){
				alloced1 += 4096;
				if(!(pNew->setEtaln= realloc(pNew->setEtaln, alloced1*sizeof(u_int32_t))))
					return -5;
			}
			((u_int32_t*)pNew->setEtaln)[pNew->countEtaln]= pkey_->doc_id;
			pNew->countEtaln++;
		}
#endif
	}
	close_index(&ind_);
	close_index(&ind);
	if(!pNew->count){
		close_base(pbase);
		return -736;
	}
	pNew->set_docs= 0;
#ifdef CREATE_ETALON_DOCS
	pNew->pSourceBase= pbase;
#else
	close_base(pbase);
	pNew->pSourceBase= (void*)-1;
#endif
	printf("Ok.");
	return 0;
}

set_st *create_doclists(void *pCntx, base_st *pbase, int count)
{
	index_st ind;
	set_st *plists;

	bzero((caddr_t)&ind, sizeof(ind));
	if(!open_index(pbase,
#ifdef MULTI_INDEX_STREAM_FILE
		"Attrs.str"
#else
		"Attrs"
#endif
		, &ind, 1)) return 0;
	plists = create_set_doclists(pCntx, &ind, count);
	close_index(&ind);
	return plists;
}

int check_segsets(base_st *pbase, int *count, void *pCntx)
{
	index_st ind;
	int i, hcount, seg, h, ret= 0;
	iter_st it;
	stream_st str;
	u_int16_t *heres, *seglist, countS= 1;
	char msge[]= "Segment with id %d required for base # %d does not exist in source base\n";

	bzero((caddr_t)&ind, sizeof(ind));
	bzero((caddr_t)&it, sizeof(it));
	bzero((caddr_t)&str, sizeof(str));
	if(!open_index(pbase,
#ifdef MULTI_INDEX_STREAM_FILE
		"Aux.str"
#else
		"Aux"
#endif
		, &ind, 1))
		return 0;
	init_iter(&ind, &it);
	locate_key(&it, "Here");
	load_stream(&it, &str);
	hcount = str.ref.size/sizeof(u_int16_t);
	heres = (u_int16_t *)str.data;
	for(i=0; i< *count; i++) {
		if(segset[i].isDocsList){
			segset[i].set_docs= segset[i].set;
			seg= hcount * sizeof(*heres);
			segset[i].set= (unsigned char*)malloc(seg+sizeof(hcount));
			*(int*)segset[i].set= hcount;
			memcpy(segset[i].set+sizeof(hcount), heres, seg);
			continue;
		}
		if( segset[i].sub_seg_set && segset[i].count == 1 && ((u_int16_t *)segset[i].sub_seg_set)[0] == 1
				&& ((u_int16_t *)segset[i].sub_seg_set)[1] == *(u_int16_t *)segset[i].set
				&& full_text_segment == *(u_int16_t *)segset[i].set){
			segset[i].set= (char*)malloc(0xffff * sizeof(*seglist));
			for(h=0, segset[i].count= 0; h<hcount;h++) {
				if(heres[h] != full_text_segment)
					((u_int16_t *)segset[i].set)[segset[i].count++]= heres[h];
			}
		}else{
			seglist = (u_int16_t *)segset[i].set;
			for(seg=0, h=0; seg < (int)segset[i].count && h<hcount;) {
				if(heres[h] > seglist[seg]) break;
				else if (heres[h] == seglist[seg]) seg++;
				h++;
			}
			if(seg < (int)segset[i].count && !segset[i].isIgnoreHere) { // Failed to find selected segment in "Here"s
				flog( msge, (int)seglist[seg], i+1);
				break;
			}
		}
#ifdef BRDR32_OLD
		if(!segset[i].isIgnoreHere && hcount == (int)segset[i].count){
			int status= 0;
			if(!segset[i].isPacked){
				if(pbase->key.PrmExt.accesMode & 0x2000)
					status |= 1;
				if(((pgfile_st *)(&pbase->str))->PrmExt.accesMode & 0x2000)
					status |= 2;
				if(pbase->ndt.PrmExt.accesMode & 0x2000)
					status |= 4;
			}
			if(status && CIB_AsUpdated(pCntx))
				status= 0;
			ret= CopyAsFromContext(pCntx, pbase->ndt.PrmExt.FileName, segname[i], status);
			for(h=i+1; h< *count; h++){
				segset[h-1]= segset[h];
				segname[h-1]= segname[h];
			}
			(*count)--;
			i--;
		}
#endif
	}
	release_stream(&str);
	release_iter(&it);
	close_index(&ind);
#ifdef BRDR32
	if((ret == 55 || ret == -65) && (i== *count))
		return ret;
#endif
	return (!ret && (i== *count));
}


