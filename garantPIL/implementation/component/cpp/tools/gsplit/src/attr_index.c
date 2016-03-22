#include "shared/Core/fix/mpcxc.h"
// test
#include <stdlib.h>
#include <stdio.h>

//#include <unistd.h>
#include <string.h>
//#include <alloca.h>
#include <fcntl.h> // GARANT_MSVC7 for ACE_OS_O_RDONLY-like constants

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "../../../libs/mrglib/src/log.h"

#include "toys.h"

#include "progress.h"
#include "message.h"

extern u_int32_t debug_level;

extern int NDT_SubFilesCount;

int isNextNDT_SubFile(unsigned char *pTst, set_st *sgset)
{
	if(sgset->isDocsList){
		if(bsearch(&sgset->isIgnoreHere, sgset->sub_seg_set + sizeof(long),
				*(long*)sgset->sub_seg_set, sizeof(long), longcmp) == 0)
			return 1;
	}else{
		unsigned short	*pUC= ((unsigned short *)sgset->sub_seg_set)+1, 
						i=*((unsigned short *)sgset->sub_seg_set);
		while(i--){
			if(*(pUC++) == *((unsigned short *)pTst))
				return 1;
		}
	}
	return 0;
}

extern void ShowMessageFromContext(void *pCurrent, char *CurrMsg);
extern void otherIncProgress(void *);

extern int IsNextTom(	LPPF_PARAM pPrm );

#define DEMO_DOC_ID 100001
#define DEMO_DOCW_ID 100002
#define DEMO_DOCA_ID 100003
#define DEMO_DOCD_ID 100004

#define	DEMO_DOC_MEDD_ID	100008	//§ Ј«гиЄ  ¤«п MedDrugTopic®ў
#define	DEMO_DOC_MEDF_ID	100009  //§ Ј«гиЄ  ¤«п MedFirmTopic®ў
#define	DEMO_DOC_MEDT_ID	100010	//§ Ј«гиЄ  ¤«п MedDictTopic®ў

#define	START_INPHARM_ID	51500001
#define	END_INPHARM_ID		52490000

#define	FirstMedDrugTopic	51500001
#define	LastMedDrugTopic	52100000
  
#define	FirstMedFirmTopic	52100001
#define	LastMedFirmTopic	52200000
  
#define	FirstMedDictTopic	52200001
#define	LastMedDictTopic	52490000

extern int add_reference_id(long Id);

extern int is_reference_id(u_int32_t Id);

int make_attrs_index(void *pCntx, index_st *pdest, int count, index_st *psrc, set_st *doclist)
{
	iter_st *pit;
	docrun_st *prun, run;
	stream_st *pdstr, pstr[2];
	int i, j, *belongs, bcount, rcount, kpp, proceed, perc, iweight, repeat
		,run_DemoParaCount, run_DemoWParaCount, run_DemoAParaCount, run_DemoDParaCount
		,run_DemoMedDParaCount, run_DemoMedFParaCount, run_DemoMedTParaCount;
	attrkey_st *pkey, key;

	stref_st *pref, *rb_Demo, *rb_DemoW, *rb_DemoA, *rb_DemoD,
					*rb_DemoMedD, *rb_DemoMedF, *rb_DemoMedT, 
					*rr_Demo, *rr_DemoW, *rr_DemoA, *rr_DemoD,
					*rr_DemoMedD, *rr_DemoMedF, *rr_DemoMedT,
					*rf_Demo, *rf_DemoW, *rf_DemoA, *rf_DemoD,
					*rs_Demo, *rs_DemoW, *rs_DemoA, *rs_DemoD, *rs_DemoMedD, *rs_DemoMedF, *rs_DemoMedT, //для IDD_DOCSTRUCT
					*rf_DemoMedD, *rf_DemoMedF, *rf_DemoMedT;

	u_int32_t size, bufsize, pgcount, *offset, *offset2, *offset1_2, tmp_doc;
	char *buffer, *doc_body, *pFind;
	unsigned char **segZ;
	pgfile_st *sndt, *dndt;
	char *msg, *msg1;
	u_int16_t first_tag, tmp_tag= IDD_REFS;
	void *pCurrUp, **ppLastUp;

	ppLastUp= (void**)alloca(count*sizeof(*ppLastUp));
	proceed = psrc->hdr.key_count;
	kpp = get_index_weight(psrc->name);
	kpp = (kpp) ? proceed / kpp : proceed+1;
	proceed = 0;
	perc = 0;
	pit = (iter_st *)alloca(sizeof(iter_st));
	init_iter(psrc, pit);
	belongs = (int *)alloca(count*sizeof(int));

	segZ= (unsigned char **)alloca((count+count)*sizeof(unsigned char*));
	offset= (u_int32_t *)alloca(3*count*sizeof(u_int32_t));
	memset(offset, 0, 3*count*sizeof(u_int32_t));
	offset2= offset+count;
	offset1_2= offset2+count;

	pdstr = pstr+1;
	bzero((caddr_t)pstr, sizeof(pstr));
	pdstr->flags = SF_NOALLOC;
	pkey=(attrkey_st *)first_key(pit);
	flog("Processing index: %s...\t", psrc->name);
	rb_Demo= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rb_DemoW= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rb_DemoA= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rb_DemoD= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rb_DemoMedD= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rb_DemoMedF= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rb_DemoMedT= (stref_st *)alloca(sizeof(*rr_Demo)*count);

	rr_Demo= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rr_DemoW= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rr_DemoA= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rr_DemoD= (stref_st *)alloca(sizeof(*rr_Demo)*count);

	rr_DemoMedD= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rr_DemoMedF= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rr_DemoMedT= (stref_st *)alloca(sizeof(*rr_Demo)*count);

	rf_Demo= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rf_DemoW= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rf_DemoA= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rf_DemoD= (stref_st *)alloca(sizeof(*rr_Demo)*count);

	rf_DemoMedD= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rf_DemoMedF= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rf_DemoMedT= (stref_st *)alloca(sizeof(*rr_Demo)*count);

	rs_Demo= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rs_DemoW= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rs_DemoA= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rs_DemoD= (stref_st *)alloca(sizeof(*rr_DemoD)*count);
	rs_DemoMedD= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rs_DemoMedF= (stref_st *)alloca(sizeof(*rr_Demo)*count);
	rs_DemoMedT= (stref_st *)alloca(sizeof(*rr_Demo)*count);

	if(pdest->name[4] != 'i'){
		msg = (char *)alloca(128);
		strcpy(msg, get_message(MSG_ATTRS));
		msg1 = msg + strlen(msg);
		strcpy(msg1, get_message(MSG_STEP1_3));
		ShowMessageFromContext(pCntx, msg);
	}
	first_tag = pkey->tag;
	for(i=0; i<count; i++) {
		if(doclist[i].put_first_disk){
			rf_Demo[i].size= 0;
			rf_DemoW[i].size= 0;
			rf_DemoA[i].size= 0;
			rf_DemoD[i].size= 0;
			rs_Demo[i].size= 0;
			rs_DemoW[i].size= 0;
			rs_DemoA[i].size= 0;
			rs_DemoD[i].size= 0;
			rs_DemoMedD[i].size= 0;
			rs_DemoMedF[i].size= 0;
			rs_DemoMedT[i].size= 0;
			rf_DemoMedD[i].size= 0;
			rf_DemoMedF[i].size= 0;
			rf_DemoMedT[i].size= 0;
		}
	}
	if(pdest->name[4] != 'i'){
		flog("Building target .NDT files...\t");
		strcpy(msg1, get_message(MSG_STEP2_3));
		ShowMessageFromContext(pCntx, msg);

		// Init //
		repeat= NDT_SubFilesCount;
		////////////////////////
		while(repeat--){
  		//flog("\n start step 2 (%d)", repeat);
		////////////////////////
		if(!repeat){
			bufsize = 0x40000;
			doc_body = (char *)malloc(bufsize);
			memset(doc_body, 0, bufsize);
			key.tag = first_tag;
			key.doc_id = 100000;
			locate_key(pit, &key);
			pkey = (attrkey_st *)pit->pkey;
//////////////////////////////////////////
	for(i=0; i<count; i++) {
		if(doclist[i].put_first_disk){
			if( doclist[i].iMultiDemo >= 1024){
				pdest[i].pbase->ndt.pfhdr->TomPerPages
					= (doclist[i].iMultiDemo * 1024) / pdest[i].pbase->ndt.pfhdr->page_size;
				pdest[i].pbase->ndt.PrmExt.maxFile_per_bytes
						= pdest[i].pbase->ndt.pfhdr->TomPerPages
							* pdest[i].pbase->ndt.pfhdr->page_size;
			}
		}
	}
	while(pkey->tag<IDD_RUNS) {
		for(i=0; i<count; i++) {
			doclist[i].BSset= doclist[i].set;
			doclist[i].BScount= doclist[i].count;
		}
		for(;pkey->tag==key.tag; pkey=next_key(pit)) {
			bcount=0;
			for(i=0; i<count; i++) {
				if(	
#ifdef MULTI_INDEX_STREAM_FILE
					(pFind= bsearch(pkey, doclist[i].BSset, doclist[i].BScount, sizeof(long), longcmp))
#else
					bsearch(pkey, doclist[i].set, doclist[i].count, sizeof(long), longcmp)
#endif
					)
				{
#ifdef MULTI_INDEX_STREAM_FILE
					doclist[i].BScount
						-= ((u_int32_t)pFind - (u_int32_t)doclist[i].BSset)/sizeof(long) + 1;
					doclist[i].BSset= pFind + sizeof(long);
#endif
					belongs[bcount++] = i;
				}
			}	
			if(!bcount) continue;
			load_stream(pit, pstr);
			pref = get_stref(pit, 0); // (stref_st *)((char *)pkey+pit->ref_offs);
			for(i=0; i<bcount; i++) {
			  j = belongs[i];
			  if(bsearch(pkey, doclist[j].all_demo, doclist[j].count_all_demo, sizeof(long), longcmp)){
				if(pkey->tag== IDD_INFO){
					long ParaCountTmp= ((docinfo_st*)pstr->data)->ParaCount;
					if(((docinfo_st*)pstr->data)->Related){
						add_reference_id(((docinfo_st*)pstr->data)->Related);
					}
					if(pkey->doc_id > ID_ANNOPLUS){
						((docinfo_st*)pstr->data)->ParaCount= run_DemoAParaCount;
					//}else if(((docinfo_st*)pstr->data)->Related) {
					}else if(is_reference_id(pkey->doc_id)){
						//ранее получалось (закомментаренная строка выше), что у документов со справкой кол-во параграфов бралось из заглушки_справки
						//и, посколько там она такое же, как у заглушки-документа, то это не замечали. А для Правовеста (вместо 100001 используем 100005) - проявилось
						((docinfo_st*)pstr->data)->ParaCount= run_DemoWParaCount;
					}else if(pkey->doc_id >= ID_DIC_LO && pkey->doc_id <= ID_DIC_HI){
						((docinfo_st*)pstr->data)->ParaCount= run_DemoDParaCount;
					} else if(pkey->doc_id >= FirstMedDrugTopic && pkey->doc_id <= LastMedDrugTopic){
						((docinfo_st*)pstr->data)->ParaCount= run_DemoMedDParaCount;
					} else if(pkey->doc_id >= FirstMedFirmTopic && pkey->doc_id <= LastMedFirmTopic){
						((docinfo_st*)pstr->data)->ParaCount= run_DemoMedFParaCount;
					} else if(pkey->doc_id >= FirstMedDictTopic && pkey->doc_id <= LastMedDictTopic){
						((docinfo_st*)pstr->data)->ParaCount= run_DemoMedTParaCount;
					} else {
						((docinfo_st*)pstr->data)->ParaCount= run_DemoParaCount;
						//((docinfo_st*)pstr->data)->Status_ex &= ~DS_FLASH;
					}
					move_stream(pstr, pdest[j].str, pref);
					add_key(pdest+j, pkey);
					((docinfo_st*)pstr->data)->ParaCount= ParaCountTmp;
				}else{
					move_stream(pstr, pdest[j].str, pref);
					add_key(pdest+j, pkey);
				}
			  }else if(doclist[j].put_first_disk){
				move_stream(pstr, pdest[j].str, pref);
				if(pkey->tag== IDD_INFO){
					if(pkey->doc_id == DEMO_DOC_ID){
						run_DemoParaCount= ((docinfo_st*)pstr->data)->ParaCount;
					}else if(pkey->doc_id == DEMO_DOCW_ID){
						run_DemoWParaCount= ((docinfo_st*)pstr->data)->ParaCount;
					}else if(pkey->doc_id == DEMO_DOCA_ID){
						run_DemoAParaCount= ((docinfo_st*)pstr->data)->ParaCount;
					}else if(pkey->doc_id == DEMO_DOCD_ID){
						run_DemoDParaCount= ((docinfo_st*)pstr->data)->ParaCount;
					}else if(pkey->doc_id == DEMO_DOC_MEDD_ID){
						run_DemoMedDParaCount= ((docinfo_st*)pstr->data)->ParaCount;
					}else if(pkey->doc_id == DEMO_DOC_MEDF_ID){
						run_DemoMedFParaCount= ((docinfo_st*)pstr->data)->ParaCount;
					}else if(pkey->doc_id == DEMO_DOC_MEDT_ID){
						run_DemoMedTParaCount= ((docinfo_st*)pstr->data)->ParaCount;
					}
				}
				add_key(pdest+j, pkey);
			  }else{
				move_stream(pstr, pdest[j].str, pref);
				add_key(pdest+j, pkey);
			  }
			}
			close_stream(pstr);
			proceed ++;
			if(proceed == kpp) {
				otherIncProgress(pCntx);
				perc++;
				proceed = 0;
			}
		}
		key.tag = pkey->tag;
		key.doc_id = 100000;
		locate_key(pit, &key);
		pkey = (attrkey_st *)pit->pkey;
	}
	///////////////////////////////////////////
		}else{
			key.tag = IDD_RUNS;
			key.doc_id = 100000;
			locate_key(pit, &key);
			pkey = (attrkey_st *)pit->pkey;
#ifdef MULTI_INDEX_STREAM_FILE
			for(i=0; i<count; i++) {
				if(doclist[i].put_first_disk){
					doclist[i].all_demo= (u_int32_t*)malloc(doclist[i].count*sizeof(*doclist->all_demo));
					doclist[i].all_demo[doclist[i].count_all_demo]= 0x7fffffff;
					ppLastUp[i]= (((u_int32_t*)doclist[i].all_demo)-1);
				}
			}
#endif
		}
		sndt = &(psrc->pbase->ndt);
	#ifdef MULTI_INDEX_STREAM_FILE
		for(i=0; i<count; i++) {
			doclist[i].BSset= doclist[i].set;
			doclist[i].BScount= doclist[i].count;
		}
	#endif
		while(pkey->tag==IDD_RUNS) {
			if(debug_level)
				flog("Reviewed key : (%d, IDD_RUNS). ", pkey->doc_id);
			bcount=0;
			for(i=0; i<count; i++) {
				if(
	#ifdef MULTI_INDEX_STREAM_FILE
					(pFind=bsearch(pkey, doclist[i].BSset, doclist[i].BScount, sizeof(long), longcmp))
	#else
					(pFind=bsearch(pkey, doclist[i].set, doclist[i].count, sizeof(long), longcmp))
	#endif
						)
				{
	#ifdef MULTI_INDEX_STREAM_FILE
					doclist[i].BScount
						-= ((u_int32_t)pFind - (u_int32_t)doclist[i].BSset)/sizeof(long) + 1;
					//////////////////////////////////
					//	only first doc ! for debug	//
					//	doclist[i].BScount= 0;		//
					//////////////////////////////////
					doclist[i].BSset= pFind + sizeof(long);
	#endif
					belongs[bcount++] = i;
					if(doclist[i].sub_seg_set != 0){
						int posO= ((int)pFind- (int)doclist[i].set);
						segZ[i]= doclist[i].seg_set+posO;
						segZ[i+count]= doclist[i].seg_32+posO;
						doclist[i].isIgnoreHere= pkey->doc_id;
					}
				}
			}	
			if(bcount) {
				if(debug_level) {
					flog("Targeted to %d sources:", bcount);
					for(i=0; i<bcount; i++) flog(" %d", belongs[i]);
					flog("\n");
				}
				pref = get_stref(pit, 0);
				load_stream_ex(pit->str, pref, pstr, &(pit->strinfo));
				rcount = pstr->ref.size / sizeof(docrun_st);
				pgcount = 0;
				for(prun=(docrun_st *)(pstr->data), i=0; i<rcount; i++)
					pgcount += prun[i].count;
				for(i=0; i<bcount; i++) {
					j = belongs[i];
					if(!repeat){
					  dndt = &(pdest[j].pbase->ndt);
					  if(doclist[j].NDTCopy){
						create_stream(pdest+j, pdstr);
						write_stream(pdstr, pstr->data, pstr->ref.size);
						if(doclist[j].NDTCopy == 1){
							char *buffP= alloca(sndt->pfhdr->page_size);
							u_int32_t currPage= 1;
							int y= 0;
							while(currPage <= sndt->pfhdr->last_page){
								read_page(sndt, currPage, buffP);
								for(y =0; y < bcount; y++){
									if(doclist[y].NDTCopy)
										write_page(&pdest[y].pbase->ndt, currPage, buffP);
								}
								currPage++;
							}
							for(y =0; y < bcount; y++){
								if(doclist[y].NDTCopy)
									doclist[y].NDTCopy++;
							}
						}
					  }else{
						if(!i){
							if((pgcount << sndt->pgpow) > bufsize) {
								bufsize = pgcount<<sndt->pgpow;
								free(doc_body);
								doc_body = (char *)malloc(bufsize);
								memset(doc_body, 0, bufsize);
								if (!doc_body) {
									gb_log_error();
									flog("Buffer size requested: %d KB\n", bufsize >> 10);
									return -1;
								}
								if (debug_level > 1)
									flog("Buffer size grown to %d KB\n", bufsize >> 10);
							}
							buffer = doc_body;
							for(prun=(docrun_st *)pstr->data; rcount; rcount--, prun++) {
								size = ((u_int32_t)(prun->count))<<sndt->pgpow;
								read_pages(sndt, prun->page, prun->count, buffer);
								buffer += size;
							}
						}
						if(doclist[j].sub_seg_set == 0){
							run.page = pgfile_size(dndt);
						}else{
							run.page = *(u_int32_t*)segZ[j+count];
							if(	offset[j] == 0l &&
								(doclist[j].isIgnoreHere= pkey->doc_id) &&
								isNextNDT_SubFile(segZ[j],doclist+j))
							{
								offset[j]++;
		/////////////////////////
		if(offset2[j]){
			dndt->pfhdr->TomPerPages= 2;
			*((u_int32_t*)dndt->pfhdr->reserved)= offset1_2[j];
			((u_int32_t*)dndt->pfhdr->reserved)[1]= offset2[j]-1;
			((u_int32_t*)dndt->pfhdr->reserved)[2]= offset2[j];
			((u_int32_t*)dndt->pfhdr->reserved)[3]= 0x7fffffff;
		}else{
			if(!doclist[j].put_first_disk){
				dndt->pfhdr->TomPerPages= 1;
			}
			*((u_int32_t*)dndt->pfhdr->reserved)= run.page;
			((u_int32_t*)dndt->pfhdr->reserved)[1]= 0x7fffffff;
		}
		/////////////////////////
							}
						}
						run.count = (u_int16_t)pgcount;
						//if(dndt->pgpow > sndt->pgpow) run.count >>= dndt->pgpow - sndt->pgpow;
						//else if(dndt->pgpow < sndt->pgpow) run.count <<= sndt->pgpow - dndt->pgpow;
						if(doclist[j].isDocsList && (doclist[j].isIgnoreHere= pkey->doc_id)
														&& isNextNDT_SubFile(segZ[j],doclist+j)){
							if(offset[j] == 1){
								offset[j]++;
								write_pages(dndt, run.page, ((u_int32_t)(run.count)), doc_body);
							}else{
								dndt->PrmExt.processMode= ACE_OS_O_WRONLY;
								dndt->PrmExt.page= run.page;
								dndt->postFilePoss[IsNextTom(&dndt->PrmExt)]
									= dndt->PrmExt.page + run.count;
								if(dndt->AddedPage < run.page + run.count)
									dndt->AddedPage= run.page + run.count;
							}
						}else{
							if(!offset[j]){
								write_pages(dndt, run.page, ((u_int32_t)(run.count)), doc_body);
								create_stream(pdest+j, pdstr);
								write_stream(pdstr, &run, sizeof(docrun_st));
								attach_stream(pdstr, pref);
								if(pkey->doc_id == DEMO_DOC_ID)
									rr_Demo[j]= *pref;
								else if(pkey->doc_id == DEMO_DOCW_ID)
									rr_DemoW[j]= *pref;
								else if(pkey->doc_id == DEMO_DOCA_ID)
									rr_DemoA[j]= *pref;
								else if(pkey->doc_id == DEMO_DOCD_ID)
									rr_DemoD[j]= *pref;
								else if (pkey->doc_id == DEMO_DOC_MEDD_ID)
									rr_DemoMedD[j]= *pref;
								else if (pkey->doc_id == DEMO_DOC_MEDF_ID)
									rr_DemoMedF[j]= *pref;
								else if (pkey->doc_id == DEMO_DOC_MEDT_ID)
									rr_DemoMedT[j]= *pref;
								close_stream(pdstr);
							}else if(run.page < *((u_int32_t*)dndt->pfhdr->reserved)){
								write_pages(dndt, run.page, ((u_int32_t)(run.count)), doc_body);
								create_stream(pdest+j, pdstr);
								write_stream(pdstr, &run, sizeof(docrun_st));
								attach_stream(pdstr, pref);
								close_stream(pdstr);
							}else{
								if(pkey->doc_id >= ID_DIC_LO && pkey->doc_id <= ID_DIC_HI){
									*pref= rr_DemoD[j];
								}else if (pkey->doc_id >= FirstMedDrugTopic && pkey->doc_id <= LastMedDrugTopic) {
									*pref= rr_DemoMedD[j];
								}else if (pkey->doc_id >= FirstMedFirmTopic && pkey->doc_id <= LastMedFirmTopic) {
									*pref= rr_DemoMedF[j];
								}else if (pkey->doc_id >= FirstMedDictTopic && pkey->doc_id <= LastMedDictTopic) {
									*pref= rr_DemoMedT[j];
								}else if(pkey->doc_id > ID_ANNOPLUS){
									*pref= rr_DemoA[j];
								}else if(is_reference_id(pkey->doc_id)){
									*pref= rr_DemoW[j];
								}else{
									*pref= rr_Demo[j];
								}
							}
						}
					  }
					  add_key(pdest+j, pkey);
					}else if(doclist[j].sub_seg_set != 0){
						*(u_int32_t*)segZ[j+count] = (u_int32_t)pgcount;
						if(!isNextNDT_SubFile(segZ[j],doclist+j)){
							//flog("\n select demo doc (%d)", *(long*)pkey);
							offset[j] += pgcount;
						}else if(doclist[j].put_first_disk){
							doclist[j].all_demo[doclist[j].count_all_demo++]= pkey->doc_id;
						}else if(!doclist[j].isDocsList
									&& ((unsigned short*)doclist[j].sub_seg_set)[0xffff]){
							doclist[j].sub_seg_set+=0xffff*2;
							if(!isNextNDT_SubFile(segZ[j],doclist+j)){
								offset2[j] += pgcount;
							}
							doclist[j].sub_seg_set-=0xffff*2;
						}
					}
				}
				release_stream(pstr);
			}
			else if(debug_level) flog("No targets found.\n");
			pkey = (attrkey_st *)next_key(pit);
			if(!repeat){
				proceed++;
				if(proceed == kpp) {
					otherIncProgress(pCntx);
					perc++;
					proceed = 0;
				}
			}
		}
		/////
		if(repeat){
			for(i=0; i<count; i++)
				if(doclist[i].sub_seg_set != 0){
					pgcount= 1l;
					offset[i]++;
					if(offset2[i]){
						offset2[i] += offset[i];
					}
					segZ[i]= doclist[i].seg_set;
					segZ[i+count]= doclist[i].seg_32;
					for(size=0; size < doclist[i].count;
							size++, segZ[i]+=doclist[i].reclen, segZ[i+count]+=doclist[i].reclen){
						doclist[i].isIgnoreHere= (long)*((long*)doclist[i].set+size);
						if(isNextNDT_SubFile(segZ[i],doclist+i)){
		/////////////////
		if(offset2[i]){
			doclist[i].sub_seg_set+=0xffff*2;
			if(isNextNDT_SubFile(segZ[i],doclist+i)){
				bufsize= offset2[i];
				offset2[i] += *(u_int32_t*)segZ[i+count];
			}else{
				if(!offset1_2[i])
					offset1_2[i]= offset[i];
				bufsize= offset[i];
				offset[i] += *(u_int32_t*)segZ[i+count];
			}
			doclist[i].sub_seg_set-=0xffff*2;
		}else{
			bufsize= offset[i];
			offset[i] += *(u_int32_t*)segZ[i+count];
		}
		*(u_int32_t*)segZ[i+count]= bufsize;
		/////////////////
						}else{
							bufsize= *(u_int32_t*)segZ[i+count];
							*(u_int32_t*)segZ[i+count]= pgcount;
							pgcount += bufsize;
						}
					}
					if(offset2[i])
						offset2[i]= offset[i];
					offset[i]= 0l;
				}
		}else if(NDT_SubFilesCount > 1){
			for(i=0; i<count; i++){
				if(offset2[i]){
					((long*)pdest[i].pbase->ndt.pfhdr->reserved)[3]
														= pdest[i].pbase->ndt.AddedPage - 1;
				}else if(offset[i] != 0l){
					if(!doclist[i].put_first_disk){
						((long*)pdest[i].pbase->ndt.pfhdr->reserved)[1]
														= pdest[i].pbase->ndt.AddedPage - 1;
						((long*)pdest[i].pbase->ndt.pfhdr->TomPerPages)[0]= 0;
					}
					((long*)pdest[i].pbase->ndt.pfhdr->reserved)[0]= 0;
					((long*)pdest[i].pbase->ndt.pfhdr->reserved)[1]= 0;
				}
			}
		}
		/////
  		//flog("\n end step 2 (%d)", repeat);
		}
		free(doc_body);
#if defined(MULTI_INDEX_STREAM_FILE) && defined(_WIN64)
		for (i = 1; i < MAX_COUNT_FILE_HANDLES + 1; i++){
			if (psrc->pbase->ndt.postFileHandles[i] != -1 && c_io_close(psrc->pbase->ndt.postFileHandles[i]))
				return 1;
			psrc->pbase->ndt.postFileHandles[i] = -1;
		}
		for (i = 0; i<count; i++) {
			int startN = 1;
			for (; startN < MAX_COUNT_FILE_HANDLES + 1; startN++){
				if (pdest[i].pbase->ndt.postFileHandles[startN] != -1 && c_io_close(pdest[i].pbase->ndt.postFileHandles[startN]))
					return 1;
				pdest[i].pbase->ndt.postFileHandles[startN] = -1;
			}
		}
#endif
		strcpy(msg1, get_message(MSG_STEP3_3));
		ShowMessageFromContext(pCntx, msg);
		flog("Done,\t");
	}else
		tmp_tag= IDD2_PARAIDS;

	key.tag = pkey->tag;
	key.doc_id = 100000;
	locate_key(pit, &key);
	while(pkey) {
#ifdef MULTI_INDEX_STREAM_FILE
		for(i=0; i<count; i++) {
			doclist[i].BSset= doclist[i].set;
			doclist[i].BScount= doclist[i].count;
		}
#endif
		key.tag = pkey->tag;
		key.doc_id = 100000;
		locate_key(pit, &key);
		pkey = (attrkey_st *)pit->pkey;
		for(; pkey && pkey->tag==key.tag; pkey=next_key(pit)) {
			for(i=0, bcount=0; i<count; i++) {
				if(
#ifdef MULTI_INDEX_STREAM_FILE
					(pFind= bsearch(pkey, doclist[i].BSset, doclist[i].BScount, sizeof(long), longcmp))
#else
					bsearch(pkey, doclist[i].set, doclist[i].count, sizeof(long), longcmp)
#endif
					) {
#ifdef MULTI_INDEX_STREAM_FILE
					doclist[i].BScount
						-= ((u_int32_t)pFind - (u_int32_t)doclist[i].BSset)/sizeof(long) + 1;
					doclist[i].BSset= pFind + sizeof(long);
#endif
					belongs[bcount++] = i;
				}
			}	
			if(!bcount) continue;
			load_stream(pit, pstr);
			pref = get_stref(pit, 0);
			for(i=0; i<bcount; i++) {
			  j = belongs[i];
			  if((pCurrUp= bsearch(pkey, doclist[j].all_demo, doclist[j].count_all_demo, sizeof(long), longcmp))){
			    if(pkey->tag == IDD_DOCSTRUCT) {
					/*if(pkey->doc_id >= START_INPHARM_ID && pkey->doc_id <= END_INPHARM_ID){
						move_stream(pstr, pdest[j].str, pref);
						add_key(pdest+j, pkey);
					} else*/
					if(pkey->doc_id >= ID_DIC_LO && pkey->doc_id <= ID_DIC_HI){
						// заменям только словарным топикам с IDD_DOCSTRUCT, значением IDD_DOCSTRUCT из заглушки
						if(rs_DemoD[j].size){
							*pref= rs_DemoD[j];
							add_key(pdest+j, pkey);
						}
					} else if(pkey->doc_id >= FirstMedDrugTopic && pkey->doc_id <= LastMedDrugTopic){
						if(rs_DemoMedD[j].size){
							*pref= rs_DemoMedD[j];
							add_key(pdest+j, pkey);
						}
					}else if(pkey->doc_id >= FirstMedFirmTopic && pkey->doc_id <= LastMedFirmTopic){
						if(rs_DemoMedF[j].size){
							*pref= rs_DemoMedF[j];
							add_key(pdest+j, pkey);
						}
					}else if(pkey->doc_id >= FirstMedDictTopic && pkey->doc_id <= LastMedDictTopic){
						if(rs_DemoMedT[j].size){
							*pref= rs_DemoMedT[j];
							add_key(pdest+j, pkey);
						}
					}else if(pkey->doc_id > ID_ANNOPLUS){
						if(rs_DemoA[j].size){
							*pref= rs_DemoA[j];
							add_key(pdest+j, pkey);
						}
					}else if(is_reference_id(pkey->doc_id)){
						if(rs_DemoW[j].size){
							*pref= rs_DemoW[j];
							add_key(pdest+j, pkey);
						}
					}else{
						if(rs_Demo[j].size){
							*pref= rs_Demo[j];
							add_key(pdest+j, pkey);
						}
					}
				}else if(pkey->tag== IDD_CONTENTS){
					;// не добавляем...
				}else if(pkey->tag== IDD2_PARAIDS){
					if(pkey->doc_id >= ID_DIC_LO && pkey->doc_id <= ID_DIC_HI){
						if(rf_DemoD[j].size){
							*pref= rf_DemoD[j];
							add_key(pdest+j, pkey);
						}
					}else if(pkey->doc_id >= FirstMedDrugTopic && pkey->doc_id <= LastMedDrugTopic){
						if(rf_DemoMedD[j].size){
							*pref= rf_DemoMedD[j];
							add_key(pdest+j, pkey);
						}
					}else if(pkey->doc_id >= FirstMedFirmTopic && pkey->doc_id <= LastMedFirmTopic){
						if(rf_DemoMedF[j].size){
							*pref= rf_DemoMedF[j];
							add_key(pdest+j, pkey);
						}
					}else if(pkey->doc_id >= FirstMedDictTopic && pkey->doc_id <= LastMedDictTopic){
						if(rf_DemoMedT[j].size){
							*pref= rf_DemoMedT[j];
							add_key(pdest+j, pkey);
						}
					}else if(pkey->doc_id > ID_ANNOPLUS){
						if(rf_DemoA[j].size){
							*pref= rf_DemoA[j];
							add_key(pdest+j, pkey);
						}
					}else if(is_reference_id(pkey->doc_id)){
						if(rf_DemoW[j].size){
							*pref= rf_DemoW[j];
							add_key(pdest+j, pkey);
						}
					}else{
						if(rf_Demo[j].size){
							*pref= rf_Demo[j];
							add_key(pdest+j, pkey);
						}
					}
				}else if(pkey->tag== IDD_BLOCKS){
					if(pkey->doc_id >= ID_DIC_LO && pkey->doc_id <= ID_DIC_HI){
						*pref= rb_DemoD[j];
						add_key(pdest+j, pkey);
					}else if(pkey->doc_id >= FirstMedDrugTopic && pkey->doc_id <= LastMedDrugTopic){
						*pref= rb_DemoMedD[j];
						add_key(pdest+j, pkey);
					}else if(pkey->doc_id >= FirstMedFirmTopic && pkey->doc_id <= LastMedFirmTopic){
						*pref= rb_DemoMedF[j];
						add_key(pdest+j, pkey);
					}else if(pkey->doc_id >= FirstMedDictTopic && pkey->doc_id <= LastMedDictTopic){
						*pref= rb_DemoMedT[j];
						add_key(pdest+j, pkey);
					}else if(pkey->doc_id > ID_ANNOPLUS){
						*pref= rb_DemoA[j];
						add_key(pdest+j, pkey);
					}else if(is_reference_id(pkey->doc_id)){
						*pref= rb_DemoW[j];
						add_key(pdest+j, pkey);
					}else{
						*pref= rb_Demo[j];
						add_key(pdest+j, pkey);
					}
				}else if(pkey->tag > IDD_NOTSURE){
					// ВСЕМ демо-топикам значение IDD_REFS из заглушки
					if (pkey->tag == IDD_REFS) {
						if(pkey->doc_id >= ID_DIC_LO && pkey->doc_id <= ID_DIC_HI){
							if(rf_DemoD[j].size){
								*pref= rf_DemoD[j];
								add_key(pdest+j, pkey);
							}
						} else if(pkey->doc_id >= FirstMedDrugTopic && pkey->doc_id <= LastMedDrugTopic){
							if(rf_DemoMedD[j].size){
								*pref= rf_DemoMedD[j];
								add_key(pdest+j, pkey);
							}
						}/* else if(pkey->doc_id >= FirstMedFirmTopic && pkey->doc_id <= LastMedFirmTopic){
							if(rf_DemoMedF[j].size){
								*pref= rf_DemoMedF[j];
								add_key(pdest+j, pkey);
							}
						} else if(pkey->doc_id >= FirstMedDictTopic && pkey->doc_id <= LastMedDictTopic){
							if(rf_DemoMedT[j].size){
								*pref= rf_DemoMedT[j];
								add_key(pdest+j, pkey);
							}
						}*/else if(pkey->doc_id > ID_ANNOPLUS){
							if(rf_DemoA[j].size){
								*pref= rf_DemoA[j];
								add_key(pdest+j, pkey);
							}
						}else if(is_reference_id(pkey->doc_id)){
							if(rf_DemoW[j].size){
								*pref= rf_DemoW[j];
								add_key(pdest+j, pkey);
							}
						}else{
							if(rf_Demo[j].size){
								*pref= rf_Demo[j];
								add_key(pdest+j, pkey);
							}
						}
					} else {
						move_stream(pstr, pdest[j].str, pref);
						add_key(pdest+j, pkey);
					}
					/*
					if(tmp_tag == IDD_REFS && pkey->tag != IDD_REFS){
						tmp_tag= pkey->tag;tmp_doc1= pkey->doc_id;
						pkey->tag= IDD_REFS;
						pCurrUp= (doclist[j].all_demo+doclist[j].count_all_demo-1);
					}
					
					while(pCurrUp > ppLastUp[j]){
						pkey->doc_id= *(++((u_int32_t*)ppLastUp[j]));
						if(pkey->doc_id >= START_DIC_ID && pkey->doc_id <= END_DIC_ID){
							if(rf_DemoD[j].size){
								*pref= rf_DemoD[j];
								add_key(pdest+j, pkey);
							}
						}else if(pkey->doc_id > ID_ANNOPLUS){
							if(rf_DemoA[j].size){
								*pref= rf_DemoA[j];
								add_key(pdest+j, pkey);
							}
						}else if(is_reference_id(pkey->doc_id)){
							if(rf_DemoW[j].size){
								*pref= rf_DemoW[j];
								add_key(pdest+j, pkey);
							}
						}else{
							if(rf_Demo[j].size){
								*pref= rf_Demo[j];
								add_key(pdest+j, pkey);
							}
						}
					}
					if(tmp_tag != IDD_REFS){
						pkey->tag= tmp_tag;pkey->doc_id= tmp_doc1;
						move_stream(pstr, pdest[j].str, pref);
						add_key(pdest+j, pkey);
					}
					*/
				}else{
					move_stream(pstr, pdest[j].str, pref);
					add_key(pdest+j, pkey);
				}
			  }else if(doclist[j].put_first_disk){
				if(pkey->tag == IDD_REFS && pkey->doc_id > *(u_int32_t*)doclist[j].all_demo){
					// ВСЕМ демо-топикам значение IDD_REFS из заглушки
					tmp_doc= pkey->doc_id;
#ifdef	__FreeBSD__
					printf ("gspliting of demo complects not supported\n");
					exit (-1);
					//на самом деле надо изменить код типа --((u_int32_t*)ppLastUp[j]) и *(++((u_int32_t*)ppLastUp[j])).
					//gcc на нег ругается 'lvalue required'
#else
					while(tmp_doc > (pkey->doc_id= *(++((u_int32_t*)ppLastUp[j])))){
						if(pkey->doc_id >= ID_DIC_LO && pkey->doc_id <= ID_DIC_HI){
							if(rf_DemoD[j].size){
								*pref= rf_DemoD[j];
								add_key(pdest+j, pkey);
							}
						}else if(pkey->doc_id > ID_ANNOPLUS){
							if(rf_DemoA[j].size){
								*pref= rf_DemoA[j];
								add_key(pdest+j, pkey);
							}
						}else if(is_reference_id(pkey->doc_id)){
							if(rf_DemoW[j].size){
								*pref= rf_DemoW[j];
								add_key(pdest+j, pkey);
							}
						}else if (pkey->doc_id >= FirstMedDrugTopic && pkey->doc_id <= LastMedDrugTopic){
							if(rf_DemoMedD[j].size){
								*pref= rf_DemoMedD[j];
								add_key(pdest+j, pkey);
							}
						} else {
							if(rf_Demo[j].size){
								*pref= rf_Demo[j];
								add_key(pdest+j, pkey);
							}
						}
						if(((u_int32_t*)ppLastUp[j])==(doclist[j].all_demo+ doclist[j].count_all_demo)){
							++((u_int32_t*)ppLastUp[j]);
							break;
						}
					}
					--((u_int32_t*)ppLastUp[j]);
#endif
					pkey->doc_id= tmp_doc;
				}
				move_stream(pstr, pdest[j].str, pref);
				if(pkey->tag == IDD_DOCSTRUCT) {
					if(pkey->doc_id == DEMO_DOC_ID){
						rs_Demo[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCW_ID){
						rs_DemoW[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCA_ID){
						rs_DemoA[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCD_ID){
						rs_DemoD[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDD_ID){
						rs_DemoMedD[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDF_ID){
						rs_DemoMedF[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDT_ID){
						rs_DemoMedT[j]= pref[0];
					}
				}else if(pkey->tag== IDD2_PARAIDS){
					if(pkey->doc_id == DEMO_DOC_ID){
						rf_Demo[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCW_ID){
						rf_DemoW[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCA_ID){
						rf_DemoA[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCD_ID){
						rf_DemoD[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDD_ID){
						rf_DemoMedD[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDF_ID){
						rf_DemoMedF[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDT_ID){
						rf_DemoMedT[j]= pref[0];
					}
				}else if(pkey->tag== IDD_BLOCKS){
					if(pkey->doc_id == DEMO_DOC_ID){
						rb_Demo[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCW_ID){
						rb_DemoW[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCA_ID){
						rb_DemoA[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCD_ID){
						rb_DemoD[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDD_ID){
						rb_DemoMedD[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDF_ID){
						rb_DemoMedF[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDT_ID){
						rb_DemoMedT[j]= pref[0];
					}
				}else if(pkey->tag== IDD_REFS){
					if(pkey->doc_id == DEMO_DOC_ID){
						rf_Demo[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCW_ID){
						rf_DemoW[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCA_ID){
						rf_DemoA[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOCD_ID){
						rf_DemoD[j]= pref[0];
					}else if(pkey->doc_id == DEMO_DOC_MEDD_ID){
						rf_DemoMedD[j]= pref[0];
					}
				}
				add_key(pdest+j, pkey);
			  }else{
				move_stream(pstr, pdest[j].str, pref);
				add_key(pdest+j, pkey);
			  }
			}
			close_stream(pstr);
			if(pdest->name[4] != 'i'){
				proceed ++;
				if(proceed == kpp) {
					otherIncProgress(pCntx);
					perc++;
					proceed = 0;
				}
			}
		}
	}
	release_iter(pit);
	flog("Done.\n");
	if(pdest->name[4] != 'i'){
		for(iweight=get_index_weight(psrc->name); perc<iweight; perc++)
			otherIncProgress(pCntx);
		hide_message();
	}
	pdstr->flags &= ~SF_NOALLOC;
	close_stream(pdstr);
	return 0;
}