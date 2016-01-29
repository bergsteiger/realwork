#include "shared/Core/fix/mpcxc.h"
#include "UpdtMorph.h"
#include "../../mrglib/src/sets.h"
#include "../../mrglib/src/stdindex.h"

#include "garantPIL/implementation/component/cpp/libs/endt/BlockDecompile.h"
#include "common/components/rtl/Garant/EVD/eeReader.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

int open_pgfile_from_PagedFile(PagedFile *pClass, pgfile_st *pFile)
{
	short PageSz= pClass->PageSize >> 1;

	pFile->PrmExt.cur_Seek= my_def_io_seek;
	pFile->PrmExt.cur_Read= my_def_io_read;
	pFile->PrmExt.pFileHandles= pFile->postFileHandles;
	memcpy(	pFile->PrmExt.pFileHandles, pClass->m_postFileHandles,
				MAX_COUNT_FILE_HANDLES*sizeof(int));
	pFile->PrmExt.pFilePoss= (int*)pFile->postFilePoss;
	memcpy(	pFile->postFilePoss, pClass->m_postFilePoss,
				MAX_COUNT_FILE_HANDLES*sizeof(u_int32_t));

	pFile->PrmExt.accesMode= pClass->m_mode;
	pFile->PrmExt.FileName= pClass->FileName;
	pFile->PrmExt.maxFile_per_bytes= pClass->m_max_paged_file_per_bytes;
	pFile->PrmExt.pHeader= pClass->SystemPageBuf;
	pFile->PrmExt.pUncompressBuffer= pClass->rbuf;
	pFile->PrmExt.pPackTable= (unsigned int*)pClass->pageOffs;
	pFile->PrmExt.PackArraySize= pClass->m_PackArraySize;
	if(pFile->PrmExt.PackArraySize)
		return 0;
	pFile->PrmExt.MessageForNextFunc= pClass->m_MessageForNextFunc;
	pFile->PrmExt.CloseProcessFunc= pClass->m_CloseProcessFunc;
#ifdef INSTLL_CIB
	pFile->PrmExt.pCrptTag= pClass->m_pCryptoTag;
#endif
	pFile->PrmExt.iPost= 1;

	pFile->pfhdr= (pfhdr_st *)pClass->SystemPageBuf;
	pFile->attr_area= pClass->SystemPageBuf + pClass->AttrOffs;
	pFile->hfile= pClass->GetFileHandle();
	for(pFile->pgpow= 0;PageSz; pFile->pgpow++, PageSz >>= 1);
	return 1;
}

extern "C" {
	int CompStringsZZZX(const void *l1, const void *l2){
		return CompStringsZZZ((void *)l1, (void *)l2);
	}
}

#define My_write_stream(aa, bb, cc) write_stream(aa, bb, cc)

/*
typedef struct PL_BLCK_TAG
{
	long DocID, sub, sPara, ePara, thisChld;
	PL_BLCK_TAG *pNxt, *pChld;
} PL_BLCK, *LPPL_BLCK;

long find_Para_In_Blocks_New(LPPL_BLCK *ppList, long Para)
{
	long ret= 0, w= 10000000;
	if(!Para)
		return 0x3fffffff;

	LPPL_BLCK pNxt= *ppList;
	do{
		if(pNxt->sPara <= Para && pNxt->ePara >= Para && w > pNxt->ePara - pNxt->sPara){
			w= pNxt->ePara - pNxt->sPara;
			ret= pNxt->sub;
		}
	}while(pNxt->pNxt && (pNxt= pNxt->pNxt));
	return (ret & 0x3fffffff);
}
*/

int attach_buff(stream_st *pdstr, stref_st *pref, index_st *pIndexOut)
{
	int	new_b= (pdstr->refs_count/0x10000)+1;
	char **ppOld= pdstr->ppBlock;

	pdstr->ppBlock= (char**)alloca(new_b*sizeof(*pdstr->ppBlock));
	while(new_b--){
		pdstr->ppBlock[new_b]= pdstr->pDeletedNorms + new_b*0x10000;
	}
	pdstr->data= pdstr->ppBlock[0];
	pdstr->ref.size= pdstr->refs_count;
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
	attach_stream(pdstr, pref);
#endif
	pdstr->ppBlock= ppOld;
	return pdstr->refs_count;
}

int write_DocNode(stream_st *pdstr, void *DocId= 0)
{
#ifndef WIN64
	if(pdstr->hDocsFile > 0){
		pdstr->refs_count += 4;

		if(DocId)
			return c_io_write( pdstr->hDocsFile, DocId, 4);

		return c_io_write( pdstr->hDocsFile, &(pdstr->ref.size), 4);
	}
#endif
	if(DocId){
		memcpy(pdstr->pDeletedNorms
#ifndef WIN64
										+pdstr[-1].hDocsFile
#endif
																+pdstr->refs_count, DocId, 4);
	}else{
		memcpy(pdstr->pDeletedNorms
#ifndef WIN64
										+pdstr[-1].hDocsFile
#endif
																+pdstr->refs_count, &(pdstr->ref.size), 4);
	}
	pdstr->refs_count += 4;
	return 4;
}

void ReParse_Stream(	u_int64_tCtxLongSetSplayMap *pIndxs,
						NContxtIndex *pNIndx, stream_st *pstr, u_intPointerV_tCtxLongSetSplayMap *ptmpA,
						int lookOlForms, long *pNewVal, u_intFrm_tCtxLongSetSplayMap *ptmpF, char **ppN,
						int WithOldNumbers, int CompOk)
{
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
	struct Ref tmpRf;
	Pix ii;u_int64_tCtxLongSetSplayNode *pRestoreNode;
	int MultiIndex= 1, PreWrite= 1;
	u_int32_t i=0, pgcount, size;
	streamfile_st *pdest= pstr->str;
	long *pNxt, *pEnd, count, startRead= 0, startProc= 0, remndr= 0, repeat= 0, notstop= 1, tstM;

	char pre_write[sizeof(long)*48], *pOutT= pre_write;
	stream_st *pdstr= pstr+1;

	if(WithOldNumbers != -1){
#ifndef WIN64
		if(!pdstr->temp_flush_handle && !pdstr->temp_flush_handle_GCTX)
#endif
			pstr->hDocsFile= 0;
#ifndef WIN64
		else{
			pstr->hDocsFile += pdstr->refs_count;
		}
#endif
		pdstr->refs_count= 0;
		pdstr->ppBlock= pstr->ppBlock;
		pdstr->szBlockPointers= pstr->szBlockPointers;
		pdstr->data= pdstr->rec= pstr->data;
		pdstr->bcount= pstr->bcount;
		if(lookOlForms){
			if(!WithOldNumbers && ptmpA->length() < 2
				&& (!ptmpF->length()
					|| (	ptmpF->length() == 1
							&& CompOk
							&& (!pNIndx->pp_ctxTextCacheArray[pNIndx->cacheI]
									->comp_items(
										(*ppN)+32*(*(unsigned char*)ptmpF->pkey(ptmpF->first()))
										, ((u_int64_tCtxLongSetSplayNode *)*(long*)ptmpA->pkey(ptmpA->first()))->curr_item)) )))
				MultiIndex= 0;
	#ifndef NOT_SCND_STR_IN_NORM
			u_int64_tCtxLongSetSplayNode* pNxtF;
			ii = ptmpA->first();
			if(!MultiIndex){
				ptmpA->SetItemInNode(&pNxtF, ptmpA->pkey(ii));
				memcpy(ppN[0], pNxtF->curr_item, 32);
				if(*pNewVal > 1){
					// forms stream corrected new size 
					*pNewVal= 1;
				}
			}else while( ii ){
				ptmpA->SetItemInNode(&pNxtF, ptmpA->pkey(ii));
				memcpy(ppN[0]+ptmpA->contents(ii).lastI*32,
						pNxtF->curr_item, 32);
				ptmpA->next(ii);
			}
	#endif
		}else
			MultiIndex= 0;
	}
	pgcount= (u_int32_t)((((size_t*)&(pstr->ref.size))[0] >> pdest->pgfile.pgpow) & 0xffffffff);
	if((remndr= (long)((((size_t*)&(pstr->ref.size))[0] & (size_t)((pdest->pgfile.pfhdr->page_size-1)&0xffff)) & 0x7fffffff)))
		pgcount++;

	long PreDocID= 0, prePos=0, bitsPos;
	for(size = pgcount+16; size > 16; size -= 16){
		pNxt= (long*)pstr->ppBlock[i++]+startRead;
		if(size-16 > 16)
			pEnd= pNxt + 16*(1 << pdest->pgfile.pgpow)/sizeof(long) - startRead;
		else{
			if(remndr){
pEnd= pNxt + ((size-1)%16)*(1 << pdest->pgfile.pgpow)/sizeof(long) - startRead
				+ remndr/sizeof(long);
			}else if(!(size%16))
pEnd= pNxt + 16*(1 << pdest->pgfile.pgpow)/sizeof(long) - startRead;
			else
pEnd= pNxt + (size%16)*(1 << pdest->pgfile.pgpow)/sizeof(long) - startRead;
		}
		for(startRead= 0;pNxt < pEnd;pNxt--){
			if(!startProc){
				if(PreDocID){
					tmpRf.DocId= PreDocID;
					pNxt--;
					if(pNIndx->IsStreamWithCount()){
						if(WithOldNumbers != -1 && MultiIndex && pNIndx->IsStreamWithCount())
							tmpRf.DocId |= 0x80000000;
						if(WithOldNumbers != -1)
							My_write_stream(pdstr, &tmpRf.DocId, sizeof(long));
					}
				}else{
					if(WithOldNumbers != -1){
						//if(MultiIndex && !pNIndx->IsDefNContextFiles())
						//	*pNxt |= 0x80000000;
						if(pNIndx->IsStreamWithCount())
							tmpRf.Sub= (long)(((unsigned long)pNxt[2]) >> 15);
					}
					tmpRf.DocId= *pNxt;
					prePos= 0;
				}
			}
/*if(*(long*)(*ppN) == -826030844){
	pNIndx->log->printf (lt_info, "\n(0){%d}", tmpRf.DocId);
	pNIndx->log->flush (lt_info);
}*/
		 do{
			if(!startProc){
				if(pNxt+1 < pEnd){
					if(WithOldNumbers != -1 && pdstr->refs_count) write_DocNode(pdstr);
					tstM= 3;
					if(pNxt[1] & 0x80000000){
						if(pNIndx->IsStreamWithCount())
							tstM= 2;
						else
							pNxt--;
						count= 1;
					}else{
						if(pNIndx->IsStreamWithCount())
							count= pNxt[1];
						else{
							count= 2;
							pNxt--;
						}
					}
					if(pNxt+tstM < pEnd){
						if(!pNIndx->IsStreamWithCount()){
							if(WithOldNumbers != -1){
								//if(!MultiIndex) { pNxt[2] |= 0x4000;}
								((char*)(pNxt+2))[2] |= ((char*)(pNxt+2))[3];
bitsPos= (0x3fffff & (((pNxt[2] >> 15) << 14) | pNxt[2] & 0x3fff)) - prePos;
prePos += bitsPos & 0xfffffc;
if(bitsPos > 0x3fff){
bitsPos= (((bitsPos & 0xffc000) << 2) | (bitsPos & 0x3fff)) | 0x8000;
if(pNxt[2]&0x800000) bitsPos |= 0x4000;
								if(tmpRf.DocId){
									write_DocNode(pdstr,&tmpRf.DocId);
									if(!PreWrite) write_stream(pdstr, &bitsPos, 3);
									else { memcpy(pOutT, &bitsPos, 3); pOutT += 3;}
								}
}else{
if(pNxt[2]&0x800000) bitsPos |= 0x4000;
								if(tmpRf.DocId){
									write_DocNode(pdstr,&tmpRf.DocId);
									if(!PreWrite) write_stream(pdstr, &bitsPos, 2);
									else { memcpy(pOutT, &bitsPos, 2); pOutT += 2;}
								}
}
							}
							pNxt += 3;
						}else{
							notstop= 2*sizeof(long)+1;
							if(tstM == 2){
								count= pNxt[2];
								if(WithOldNumbers != -1){
									if(PreDocID || tmpRf.DocId != *pNxt){
										notstop -= sizeof(long);
										if(!PreWrite) My_write_stream(pdstr, pNxt+1, notstop);
										else { memcpy(pOutT, pNxt+1, notstop); pOutT += notstop;}
									}else{
										if(!PreWrite) My_write_stream(pdstr, pNxt, notstop);
										else { memcpy(pOutT, pNxt, notstop); pOutT += notstop;}
									}
								}
								notstop= 0;
							}else if(!pNIndx->IsDefNContextFiles()){
								repeat= pNxt[2]-1;
								count= pNxt[3];
								if(WithOldNumbers != -1){
									if(PreDocID || tmpRf.DocId != *pNxt){
										if(!PreWrite) My_write_stream(pdstr, pNxt+1, notstop);
										else { memcpy(pOutT, pNxt+1, notstop); pOutT += notstop;}
									}else{
										notstop += sizeof(long);
										if(!PreWrite) My_write_stream(pdstr, pNxt, notstop);
										else { memcpy(pOutT, pNxt, notstop); pOutT += notstop;}
									}
								}
								pNxt++;
								notstop= 0;
							}else if(WithOldNumbers != -1){
								if(!MultiIndex) { pNxt[2] |= 0x4000;}
								notstop += sizeof(long) - 1;
								if(!PreWrite) write_stream(pdstr, pNxt, notstop);
								else { memcpy(pOutT, pNxt, notstop); pOutT += notstop;}
							}
							//curr_Para= pNxt[2] >> 15;
							//curr_WordPos= pNxt[2] & 0x3fff;
							pNxt += 3;
						}
					}else{
						{
							if(tstM == 2){
								if(pNxt+2 < pEnd){
									count= pNxt[2];
									if(WithOldNumbers != -1){
										My_write_stream(pdstr, pNxt, sizeof(long)*3);
									}
								}else{
									count= *(long*)pstr->ppBlock[i];
									if(WithOldNumbers != -1){
										My_write_stream(pdstr, pNxt, sizeof(long)*2);
										My_write_stream(pdstr, pstr->ppBlock[i], sizeof(char));
									}
									pNxt++;
								}
								notstop= 0;
							}else if(!pNIndx->IsDefNContextFiles()){
								if(pNxt+2 < pEnd){
									repeat= pNxt[2]-1;
									count= *(long*)pstr->ppBlock[i];
									if(WithOldNumbers != -1){
										My_write_stream(pdstr, pNxt, sizeof(long)*3);
										My_write_stream(pdstr, pstr->ppBlock[i], sizeof(char));
									}
								}else{
									repeat= *(long*)pstr->ppBlock[i]-1;
									count= ((long*)pstr->ppBlock[i])[1];
									if(WithOldNumbers != -1){
										notstop= sizeof(long)*2;
										My_write_stream(pdstr, pNxt, notstop);
										My_write_stream(pdstr, pstr->ppBlock[i], sizeof(long)+sizeof(char));
									}
								}
								pNxt++;
								notstop= 0;
							}else if(WithOldNumbers != -1){
								if(!pNIndx->IsStreamWithCount() ){
									//if(!MultiIndex) { pNxt[2] |= 0x4000;}
									((char*)(pNxt+2))[2] |= ((char*)(pNxt+2))[3];
bitsPos= (0x3fffff & (((pNxt[2] >> 15) << 14) | pNxt[2] & 0x3fff)) - prePos;
prePos += bitsPos & 0xfffffc;
if(bitsPos > 0x3fff){
bitsPos= (((bitsPos & 0xffc000) << 2) | (bitsPos & 0x3fff)) | 0x8000;
if(pNxt[2]&0x800000) bitsPos |= 0x4000;

									write_DocNode(pdstr,&tmpRf.DocId);
									write_stream(pdstr, &bitsPos, 3);
}else{
if(pNxt[2]&0x800000) bitsPos |= 0x4000;

									write_DocNode(pdstr,&tmpRf.DocId);
									write_stream(pdstr, &bitsPos, 2);
}
								}else{
									My_write_stream(pdstr, pNxt, sizeof(long)*2);
									if(!MultiIndex) *(long*)(pstr->ppBlock[i]) |= 0x4000;
									tmpRf.Sub= (long)((*(long*)pstr->ppBlock[i]) >> 15);
									My_write_stream(pdstr, pstr->ppBlock[i], sizeof(long));
								}
							}
						}
						startRead= tstM - (pEnd - pNxt);
						startProc= 3;
						pNxt= pEnd+1;
					}
				}else{
					pNxt= pEnd+1;
					startRead= 0;
					startProc= 1;
				}
			}else{
				startProc= 0;
			}
			PreDocID= 0;
			while(pNxt < pEnd && count--){
				if(lookOlForms){
				  if(WithOldNumbers != -1){
					if(MultiIndex){
						if(*pNxt < 256){
							if(!PreWrite) My_write_stream(pdstr, pNxt, sizeof(char));
							else { memcpy(pOutT, pNxt, sizeof(char)); pOutT += sizeof(char); }
						}else{
							pRestoreNode=
#if defined(MIN_MEM_CONTEXT) || defined(WIN64)
												pNIndx->pAllPre+(*pNxt & 0x3fffffff)
#else
												(u_int64_tCtxLongSetSplayNode *)(*pNxt & 0x3fffffff)
#endif
																										;
							*pNxt= ((*ptmpA)[&pRestoreNode]).lastI;
							if(!PreWrite) My_write_stream(pdstr, pNxt, sizeof(char));
							else { memcpy(pOutT, pNxt, sizeof(char)); pOutT += sizeof(char);}
							pNIndx->InBlockMap( pIndxs, &tmpRf, *pNxt);
						}
					}else
						pNIndx->InBlockMap( pIndxs, &tmpRf, -1);
				  }else if(*pNxt < 256){
						((*ptmpF)[(void*)pNxt]).e= 0;
						/*if(*(long*)(*ppN) == -826030844){
							pNIndx->log->printf (lt_info, "\n(%s)", (*ppN)+ 32*(*pNxt));
							pNIndx->log->flush (lt_info);
						}*/
					}else{
							pRestoreNode=
#if defined(MIN_MEM_CONTEXT) || defined(WIN64)
											pNIndx->pAllPre+(*pNxt & 0x3fffffff)
#else
											(u_int64_tCtxLongSetSplayNode *)(*pNxt & 0x3fffffff)
#endif
																									;
						(*ptmpA)[&pRestoreNode];
						/*if(*(long*)(*ppN) == -826030844){
							pNIndx->log->printf (lt_info, "\n[%s]", pRestoreNode->curr_item+1);
							pNIndx->log->flush (lt_info);
						}*/
					}
				}
				if(!notstop && count){
					pNxt++;
					if(pNxt == pEnd){
						startRead= 0;
						startProc= 1;
						pNxt= pEnd+1;
					}
				}else if(pNxt+2 < pEnd){
					if(count && WithOldNumbers != -1){
						notstop= sizeof(long);
						if(pNIndx->IsDefNContextFiles()){
							//if(!MultiIndex) pNxt[1] |= 0x4000;
							if(!pNIndx->IsStreamWithCount()){
								((char*)(pNxt+1))[2] |= ((char*)(pNxt+1))[3];
								notstop--;
							}
						}else
							tmpRf.Sub= (long)(((unsigned)pNxt[1]) >> 15);
bitsPos= (0x3fffff & (((pNxt[1] >> 15) << 14) | pNxt[1] & 0x3fff)) - prePos;
prePos += bitsPos & 0xfffffc;
if(bitsPos > 0x3fff){
bitsPos= (((bitsPos & 0xffc000) << 2) | (bitsPos & 0x3fff)) | 0x8000;
if(pNxt[1]&0x800000) bitsPos |= 0x4000;
						if(!PreWrite) My_write_stream(pdstr, &bitsPos, notstop);
						else { memcpy(pOutT, &bitsPos, notstop); pOutT += notstop;}
}else{
if(pNxt[1]&0x800000) bitsPos |= 0x4000;
						if(!PreWrite) My_write_stream(pdstr, &bitsPos, notstop-1);
						else { memcpy(pOutT, &bitsPos, notstop-1); pOutT += notstop-1;}
}
					}
					if(count && !pNIndx->IsStreamWithCount() && !(pNxt[1] & 0x80000000)){
						count++;
					}
					pNxt += 2;
				}else{
					if(size-16 > 16){
						if(!repeat && !count && pNxt+1 < pEnd){
							PreDocID= pNxt[1];prePos= 0;
							startProc= 0;
							pNxt= pEnd+1;
							break;
						}
						startRead= 2 - (pEnd - pNxt);
						if(count){
							notstop= sizeof(long);
							if(!pNIndx->IsStreamWithCount()){
								if(pNxt+1 < pEnd){
									if(!(pNxt[1] & 0x80000000)){
										count++;
									}else if(WithOldNumbers != -1)
										pNxt[1] |= 0x800000;
								}else if(!(((long*)pstr->ppBlock[i])[0] & 0x80000000)){
									count++;
								}else if(WithOldNumbers != -1)
									*(pstr->ppBlock[i]+2) |= 0x80;
								notstop--;
							}
							if(WithOldNumbers != -1){
								if(pNIndx->IsDefNContextFiles()){
									if(pNxt+1 < pEnd){
										//if(!MultiIndex) pNxt[1] |= 0x4000;
bitsPos= (0x3fffff & (((pNxt[1] >> 15) << 14) | pNxt[1] & 0x3fff)) - prePos;
prePos += bitsPos & 0xfffffc;
if(bitsPos > 0x3fff){
bitsPos= (((bitsPos & 0xffc000) << 2) | (bitsPos & 0x3fff)) | 0x8000;
if(pNxt[1]&0x800000) bitsPos |= 0x4000;
										write_stream(pdstr, &bitsPos, notstop);
}else{
if(pNxt[1]&0x800000) bitsPos |= 0x4000;
										write_stream(pdstr, &bitsPos, notstop-1);
}
									}else{
										//if(!MultiIndex) *(long*)pstr->ppBlock[i] |= 0x4000;
bitsPos= (0x3fffff & ((((*(long*)pstr->ppBlock[i]) >> 15) << 14) | (*(long*)pstr->ppBlock[i]) & 0x3fff)) - prePos;
prePos += bitsPos & 0xfffffc;
if(bitsPos > 0x3fff){
bitsPos= (((bitsPos & 0xffc000) << 2) | (bitsPos & 0x3fff)) | 0x8000;
if((*(long*)pstr->ppBlock[i])&0x800000) bitsPos |= 0x4000;
										write_stream(pdstr, &bitsPos, notstop);
}else{
if((*(long*)pstr->ppBlock[i])&0x800000) bitsPos |= 0x4000;
										write_stream(pdstr, &bitsPos, notstop-1);
}
									}
								}else{
									if(pNxt+1 < pEnd)
										My_write_stream(pdstr, pNxt+1, sizeof(long));
									My_write_stream(pdstr, pstr->ppBlock[i], startRead*sizeof(long));
								}
							}
						}else if(pNxt+1 < pEnd){
							if(WithOldNumbers != -1)
								My_write_stream(pdstr, pNxt+1, sizeof(long));
							pNxt= (long*)pstr->ppBlock[i];
							if(lookOlForms){
							  if(WithOldNumbers != -1){
								if(MultiIndex){
									if(*pNxt < 256){
										My_write_stream(pdstr, pNxt, sizeof(char));
									}else{
										pRestoreNode=
#if defined(MIN_MEM_CONTEXT) || defined(WIN64)
														pNIndx->pAllPre+(*pNxt & 0x3fffffff)
#else
														(u_int64_tCtxLongSetSplayNode *)(*pNxt & 0x3fffffff)
#endif
																											;
										*pNxt= ((*ptmpA)[&pRestoreNode]).lastI;
										My_write_stream(pdstr, pNxt, sizeof(char));
										pNIndx->InBlockMap( pIndxs, &tmpRf, *pNxt);
									}
								}
							  }else if(*pNxt < 256){
									((*ptmpF)[(void*)pNxt]).e= 0;
								}else{
										pRestoreNode=
#if defined(MIN_MEM_CONTEXT) || defined(WIN64)
														pNIndx->pAllPre+(*pNxt & 0x3fffffff)
#else
														(u_int64_tCtxLongSetSplayNode *)(*pNxt & 0x3fffffff)
#endif
																											;
										(*ptmpA)[&pRestoreNode];
								}
								repeat--;
								startRead= 2;
							}
						}
					}
					startProc= 1;
					pNxt= pEnd+1;
				}
				if(WithOldNumbers != -1 && PreWrite && (char*)pNxt-pstr->data >= (pOutT+sizeof(long)+sizeof(short))-pre_write){
					PreWrite= 0;
					if(pOutT-pre_write > 1)
						My_write_stream(pdstr, pre_write, pOutT-pre_write);
				}
			}
		 }while(pNxt < pEnd && repeat && repeat-- && (pNxt= pNxt - 2));
		}
		if(WithOldNumbers != -1 && PreWrite)
			My_write_stream(pdstr, pre_write, pOutT-pre_write);
	}
	if(WithOldNumbers == -1){
		for( ii = ptmpF->first();ii; ptmpF->next(ii) ){
			if(*pNewVal < *(unsigned char*)ptmpF->pkey(ii)+1){
				*pNewVal= *(unsigned char*)ptmpF->pkey(ii)+1;
			}
		}
	}else
		 write_DocNode(pdstr);
#endif
}

CtxLongSet lsdef00;
u_intPointerV_tCtxLongSetSplayMap tmpA(lsdef00);

void UpdtContextIndex::SetFormsData(u_int64_tCtxLongSetSplayMap *ptmpA, char *key_buff, void*pIN, void*pDSTR)
{
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
	index_st *pin= (index_st *)pIN;
	stream_st *pdstr= (stream_st *)pDSTR;

	close_stream(pdstr);

	u_int32_t szData= ptmpA->length()*32;
	if(m_pNIdList && pdstr[1].ArrayIOffsCount)
		szData= (pdstr[1].ArrayIOffsCount*32);
	AddKeyBlockMap(key_buff, (pin+4), (pdstr+7), pdstr[1].data, szData);
	write_stream(pdstr, pdstr[1].data, szData);
	pdstr[1].ArrayIOffsCount= 0;
	attach_stream(pdstr, get_stref_ex(	key_buff, pin->hdr.keylen, pin->hdr.strinfo.immds,
							pin->hdr.nstreams, 1));

	int ii= 0, jj;
	char *pNxtN;
	u_int64_tCtxLongSetSplayNode* pNxt;
	for( Pix i = ptmpA->first(); i; ii++, ptmpA->next(i) ){
		ptmpA->SetItemInNode(&pNxt, ptmpA->pkey(i));
		if(!pNxt->cont.capacity && pNxt->cont.lastI){
			short xt=1;
			if(NormalFromPointer)
				GetKeyBuff((long**)&pNxtN, pNxt);
			for(jj = pNxt->cont.lastI; jj--; xt++)
			{
				if(!NormalFromPointer)
					pNxtN= (char*)pNxt->cont.e[xt-1];
				if(!CompStringsZZZ(pNxtN, key_buff)){
						((short*)&pNxt->cont.capacity)[0] = (short)pNxt->cont.lastI;
						((short*)&pNxt->cont.capacity)[1]
							=  (xt << 8) | (short)ptmpA->contents(i).lastI;
						break;
				}
				if(NormalFromPointer)
					SetNextKeyBuff((long**)&pNxtN);
			}
		}
	}
#endif
}

#include "shared/ContextSearch/Common/Constants.h"
#include "Normalize.h"

int GetNormalesFromStrings(	NContxtIndex *pind, char *buf, LPPL_RET_NORMLS spRet, unsigned wordLen,
						   u_int64_tCtxLongSetSplayMap	*p_ctxTextArray,
						   int *pwordPos, long Id, long j, IGarDoc *pdoc)
{
	if(!pind->GetNormalesFromString (buf, spRet, Lemmatize::execute, wordLen)) {
		CtxLongSet *sp;
		if(spRet->lastI){
			u_int64_t *pNxt_normales;
			pind->pindPut->GetKeyBuff((long**)&pNxt_normales, pind->pp_ctxTextCacheArray[pind->cacheI]->root);
			for(; spRet->lastI--;){
#ifndef Not_USE_LongSetSplayNode
				/*
				if(pind->pIOuter){
					pind->pIOuter->PutKey((void*)&pNxt_normales, Id, j, *pwordPos);
				}else*/	
				{
					sp = pind->pindPut->GetSpNorm(p_ctxTextArray, pNxt_normales);
					if( pind->pindPut->IsRealloc(sp) ){
#ifndef STD_REALLOC
#else
						sp->e=(long*)realloc(sp->e,sizeof(long)*(sp->lastI+(GROW_BY*4
#ifndef NOT_OPTIMIZE_REALLOC
							* pind->pindPut->m_CurrReallocFactor
#endif
							)));
						if( !sp->e )
							abort();
						pind->itemsDone += 5
#ifndef NOT_OPTIMIZE_REALLOC
							* pind->m_CurrReallocFactor
#endif
							;
#endif
					}
					pind->pindPut->PutOffset(sp, Id, j, *pwordPos);
#ifdef NORMLS_AND_FORMS
					if(!spRet->lastI
						&& pNxt_normales != (u_int64_t *)pp_ctxTextCacheArray[cacheI]->root->curr_item){
							spRet->lastI++;
							pNxt_normales= (u_int64_t *)pp_ctxTextCacheArray[cacheI]->root->curr_item;
							*(char*)pNxt_normales |= 0x80;
					}else
#endif
						pind->pindPut->SetNextKeyBuff((long**)&pNxt_normales);
				}
			}
#ifdef NORMLS_AND_FORMS
			*(char*)(pNxt_normales-4) &= ~0x80;
#endif
		}
#endif
		return 0;
	}
	return 1;
}

char	shrinked_str [1024];
char*	shrink_str (char* index_str)
{
	char* toput = shrinked_str;
	*toput = 0;
	char *token = strtok (index_str, "\\");
	while (token) {
		if (toput != shrinked_str) {
			toput++;
			*toput = '\\';
			toput++;
		}
		int length = strlen (token)-4;
		memcpy (toput, token+4, length+1);
		toput += length - 1;
		token = strtok (0, "\\");
	}
	return shrinked_str;
}

std::map <std::string,std::vector<std::string> > upd_bigrams;
std::set<std::string> upd_bigrams_words;

void UpdtContextIndex::getParaWordFromDoc (u_int64_tCtxLongSetSplayMap	*p_ctxTextArray, long Id, long LastPara, long LastWordPos, std::map< long,std::set<std::string> >& kinds, IGarDoc *pdoc, bool include_name_in_text)
{
	this->InitMorpho ();

	PL_RET_NORMLS retrn;
	char	bufT [256], *buf = (char*)bufT+1, bufN [DOC_NAME_SIZE], *new_src = 0;
	long	j, style, flags;
	unsigned len, wordLen;
	const char *src = 0;
	int	win_encode, wordPos = 0, RetVal, textpos_add = 0;

	Document *pDeleted= 0;

#if !defined(STD_REALLOC)
	if(!pdoc){
		pdoc= (IGarDoc *)OS_GetDocument(Id);
		if(!pdoc)
			return;
		pDeleted= (Document *)pdoc;
	}
#else
	assert(pdoc);
#endif

	IGarDoc *doc= pdoc;
	if(!LastPara)
		LastPara= doc->GetParaCount();
	else
		LastPara++;

	AttrIndex* attrs = (AttrIndex*) ((Document*)doc)->base->FindIndex ("Attrs");
	long subs_count = -1;
	SubDesc* subs = 0;

	bool is_aaktext = GetDocStatusExEx (&((Document*)doc)->Stat) & DS_AAKTEXT;
	long last_aakpara = 0x7FFFFFFF;
	if (is_aaktext) {
		if (subs_count == -1) {
			subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
			subs_count /= sizeof (SubDesc);
		}

		long length = 0;
		char *data = (char*) ((Document*)doc)->base->LoadAttr (Id, IDD_EVD, length), *ptr = data;
		if (length) {
			while (ptr - data < length) {
				long block_id = *(long*)ptr;
				ptr += sizeof (long);
				long size = (long) ptr [0];
				if (block_id < 0) {
					std::string info;
					evd::IeeGenerator_var generator = EndtTools::BlockDecompileFactory::make (info);
					evd::EvdReader_var evd_reader = new evd::EvdReader (ptr+1, size, generator.in ());
					evd_reader->convert_binary_object ();
					if (info == "RIGHT") {
						block_id = -block_id;
						SubDesc* subpos = (SubDesc*)bsearch (&block_id, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
						if (subpos)
							last_aakpara = subpos->Para;
					}
				}
				ptr += size + 1;
			}
			gk_free (data);
		}
	}	

	if (upd_bigrams.size () == 0) {
		Stream *str = ((Document*)doc)->base->FindIndex ("Aux")->Open (AUX_BIGRAMS);
		if (str) {
			long size = str->Length ();
			char *data = new char [size], *ptr = data;
			str->Read (data, size);
			((Document*)doc)->base->FindIndex ("Aux")->Close (str);
			while (ptr - data < size) {
				char *new_ptr = ptr + strlen (ptr) + 1;
				long count;
				memcpy (&count, new_ptr, sizeof (long));
				new_ptr += sizeof (long);

				for (int i = 0; i < count; i++) {
					std::map<std::string,std::vector<std::string> >::iterator map_it = upd_bigrams.find (new_ptr);
					if (map_it == upd_bigrams.end ()) {
						std::vector<std::string> toinsert;
						toinsert.push_back (ptr);
						upd_bigrams.insert (std::map<std::string,std::vector<std::string> >::value_type (new_ptr, toinsert));
					} else {
						map_it->second.push_back (ptr);
					}

					GCL::StrVector parts;
					boost::split (parts, new_ptr, boost::is_any_of ("|"));
					for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); it++)
						upd_bigrams_words.insert (*it);

					new_ptr += strlen (new_ptr) + 1;
				}
				ptr = new_ptr;
			}
			delete []data;
		} else {
			std::vector<std::string> empty;
			empty.push_back ("DEADFOOD");
			upd_bigrams.insert (std::map<std::string,std::vector<std::string> >::value_type ("DEADFOOD", empty));
		}
	}

	std::map<long, std::vector<std::string> > map_para_invisibletexts;
	std::map<long, std::vector<long> > map_para_invisiblereles;
	{
		char sub_name [SUB_NAME_SIZE+4];
		AttrKey key = {Id, IDD_KIND};
		Stream *str = attrs->Open (&key);
		if (str) {
			int length = str -> Length();
			char *prefixes = (char*) alloca (length+4), *ptr = prefixes;
			if (str->Read (prefixes, length) == length) {
				attrs -> Close (str);
				std::set<std::string> prefixes_set;
				while (ptr - prefixes < length) {
					prefixes_set.insert (ptr);
					ptr += strlen (ptr) + 1;
				}
				ptr = prefixes;
				for (std::set<std::string>::const_iterator it = prefixes_set.begin (); it != prefixes_set.end (); it++) {
					strcpy (ptr, it->c_str ());
					ptr += strlen (ptr) + 1;
				}
				ptr = prefixes;				
				while (ptr - prefixes < length) {
					long size = strlen (ptr);
					char* prefix = strrchr (ptr, ':') + 1;
					if (kinds.find (0)->second.find (prefix) != kinds.find (0)->second.end ()) {
						if (subs_count == -1) {
							subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
							subs_count /= sizeof (SubDesc);
						}
						long sub = atol (ptr), para = 0;
						if (sub) {
							SubDesc* subpos = (SubDesc*)bsearch (&sub, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
							if (subpos)
								para = subpos->Para;
						} else {
							para = 0;
						}
						((Document*)doc)->base->FindSubName (Id, sub, sub_name);
						if (sub_name [0]) {
							std::vector<std::string> texts; texts.push_back (sub_name);
							map_para_invisibletexts.insert (std::map<long,std::vector<std::string> >::value_type (para, texts));
							std::vector<long> reles; reles.push_back (-1);
							map_para_invisiblereles.insert (std::map<long,std::vector<long> >::value_type (para, reles));
						}
					}
					if (kinds.find (1)->second.find (prefix) != kinds.find (1)->second.end ()) {
						if (subs_count == -1) {
							subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
							subs_count /= sizeof (SubDesc);
						}
						long sub = atol (ptr), para = 0;
						if (sub) {
							SubDesc* subpos = (SubDesc*)bsearch (&sub, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
							if (subpos)
								para = subpos->Para;
						} else {
							para = 0;
						}
						std::map<long,std::vector<std::string> >::iterator it = map_para_invisibletexts.find (para);
						char* shrinked_prefix = shrink_str (prefix);
						if (it == map_para_invisibletexts.end ()) {
							std::vector<std::string> texts; texts.push_back (shrinked_prefix);
							map_para_invisibletexts.insert (std::map<long,std::vector<std::string> >::value_type (para, texts));
							std::vector<long> reles; reles.push_back (-1);
							map_para_invisiblereles.insert (std::map<long,std::vector<long> >::value_type (para, reles));
						} else {
							it->second.push_back (shrinked_prefix);
							map_para_invisiblereles.find (para)->second.push_back (-1);
						}
					}
					ptr += size + 1;
				}
			} else {
				attrs -> Close (str);
			}
		}
	}

	{
		AttrKey key = {Id, IDD_HANDMASK};
		Stream *str = attrs->Open (&key);
		if (str) {
			int length = str->Length();
			char* handmasks = (char*) alloca (length), *ptr = handmasks;
			str->Read (handmasks, length);
			attrs->Close (str);
			while (ptr - handmasks < length) {
				if (subs_count == -1) {
					subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
					subs_count /= sizeof (SubDesc);
				}
				long size = strlen (ptr), sub = atol (ptr), para = 0;
				if (sub) {
					SubDesc *subpos = (SubDesc*)bsearch (&sub, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
					if (subpos)
						para = subpos->Para;
				}
				char* hm = strchr (ptr, ':') + 1;
				std::map<long,std::vector<std::string> >::iterator map_it = map_para_invisibletexts.find (para);
				if (map_it == map_para_invisibletexts.end ()) {
					char* semi = strchr (hm, ':');
					*semi = '\0';
					long rele = atol (semi+1);
					std::vector<std::string> texts; texts.push_back (hm);
					map_para_invisibletexts.insert (std::map<long,std::vector<std::string> >::value_type (para, texts));
					std::vector<long> reles; reles.push_back (rele);
					map_para_invisiblereles.insert (std::map<long,std::vector<long> >::value_type (para, reles));
				} else {
					char* semi = strchr (hm, ':');
					*semi = '\0';
					long rele = atol (semi+1);
					map_it->second.push_back (hm);
					map_para_invisiblereles.find (para)->second.push_back (rele);
				}
				ptr += size + 1;
			}
		}
	}

	std::map<long,std::vector<long> > map_para_blocks; //какие блоки на параграфе начинаются
	std::map<long,std::vector<std::string> > map_para_invisibleblocktexts; //для каждого из этих блоков есть строка (невидимый текст)
	std::map<long,std::vector<long> > map_para_invisibleblockreles; //для каждого из этих блоков есть вектор дополнительных баллов за релевантность
	//соответственно, если на параграф есть map_para_blocks - то по одной начинаем доставать строки, и индексировать
	{
		AttrKey key = {Id, IDD_HANDHANDMASK};
		Stream *str = attrs->Open (&key);
		if (str) {
			int length = str->Length();
			char* handmasks = (char*) alloca (length), *ptr = handmasks;
			str->Read (handmasks, length);
			attrs->Close (str);
			while (ptr - handmasks < length) {
				if (subs_count == -1) {
					subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
					subs_count /= sizeof (SubDesc);
				}
				long size = strlen (ptr), sub = atol (ptr), para = 0;
				if (sub) {
					SubDesc* subpos = (SubDesc*) bsearch (&sub, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
					if (subpos)
						para = subpos->Para;
				}
				char* hm = strchr (ptr, ':') + 1;
				std::map<long,std::vector<long> >::iterator blocks_it = map_para_blocks.find (para);
				char* semi = strchr (hm, ':');
				*semi = 0;
				long rele = atol (semi+1);
				if (blocks_it == map_para_blocks.end ()) {
					std::vector<long> blocks; blocks.push_back (sub);
					map_para_blocks.insert (std::map<long,std::vector<long> >::value_type (para, blocks));
					std::vector<std::string> texts; texts.push_back (hm);
					std::vector<long> reles; reles.push_back (rele);
					map_para_invisibleblocktexts.insert (std::map<long,std::vector<std::string> >::value_type (para, texts));
					map_para_invisibleblockreles.insert (std::map<long,std::vector<long> >::value_type (para, reles));
				} else {
					blocks_it->second.push_back (sub);
					map_para_invisibleblocktexts.find (para)->second.push_back (hm);
					map_para_invisibleblockreles.find (para)->second.push_back (rele);
				}
				ptr += size + 1;
			}
		}
	}
	gk_free (subs);

	std::map<long,std::vector<long> > map_para_markedpositions;
	{
		AttrKey key = {Id, IDD_MARKEDTEXT};
		Stream *str = attrs->Open (&key);
		if (str) {
			int length = str->Length ();
			char *data = new char [length];
			str->Read (data, length);
			attrs->Close (str);
			long *ptr = (long*) data;
			length /= sizeof (long);
			while (length) {
				long para = *ptr++; length--;
				long count = *ptr++; length--;
				std::vector<long> positions;
				for (; count; count--, length--)
					positions.push_back (*ptr++);
				map_para_markedpositions.insert (std::map<long,std::vector<long> >::value_type (para, positions));
			}
		}
	}

	std::set<long> wordposcontrol;
	bool b_docname = true;
	for (j = 0, style, flags = 0; j < LastPara; ) {
		std::vector<long> marked_positions;
		long saved_len = 0, block = -1, rele = -1;
		bool b_inpara = false, b_invisible_text = false, b_invisible_block = false;
		if (b_docname) {
			//индексируется !NAME документа
			b_docname = false;
			if (!base->FindDocName (Id, bufN))
				continue;
			win_encode = 1, style = 0, src = bufN, len = strlen (src);
		} else if (include_name_in_text) {
			include_name_in_text = false;
			wordPos = ContextSearch::DOC_BEGIN_WORD;
			b_invisible_text = true; //ранее было flags = ENDT_HEADER, и потом срабатывало corr_wordPos |= GKDB_POS_HEADER;
			strcpy (bufN, "");
			base->FindDocName (Id, bufN);
			style = 0, win_encode = 1, src = bufN, len = strlen (src);
		} else if (map_para_invisibleblocktexts.find (j) != map_para_invisibleblocktexts.end ()) {
			if (wordPos < ContextSearch::DOC_BEGIN_WORD) wordPos = ContextSearch::DOC_BEGIN_WORD;

			std::map<long,std::vector<std::string> >::iterator texts_it = map_para_invisibleblocktexts.find (j);
			new_src = strdup (texts_it->second.begin ()->c_str ());
			texts_it->second.erase (texts_it->second.begin ());
			if (!texts_it->second.size ())
				map_para_invisibleblocktexts.erase (j);

			std::map<long,std::vector<long> >::iterator reles_it = map_para_invisibleblockreles.find (j);
			rele = *reles_it->second.begin ();
			reles_it->second.erase (reles_it->second.begin ());
			if (!reles_it->second.size ())
				map_para_invisibleblockreles.erase (j);

			std::map<long,std::vector<long> >::iterator blocks_it = map_para_blocks.find (j);
			block = *blocks_it->second.begin ();
			blocks_it->second.erase (blocks_it->second.begin ());
			b_invisible_block = true;
			src = new_src, len = strlen (src), win_encode = 1;
		} else if (map_para_invisibletexts.find (j) != map_para_invisibletexts.end ()) {
			if (wordPos < ContextSearch::DOC_BEGIN_WORD) wordPos = ContextSearch::DOC_BEGIN_WORD;

			std::map<long, std::vector<std::string> >::iterator texts_it = map_para_invisibletexts.find (j);
			new_src = strdup (texts_it->second.begin ()->c_str ());
			texts_it->second.erase (texts_it->second.begin ());
			if (!texts_it->second.size ())
				map_para_invisibletexts.erase (j);

			std::map<long,std::vector<long> >::iterator reles_it = map_para_invisiblereles.find (j);
			rele = *reles_it->second.begin ();
			reles_it->second.erase (reles_it->second.begin ());
			if (!reles_it->second.size ())
				map_para_invisiblereles.erase (j);

			src = new_src, len = strlen (src), win_encode = 1;
		} else {
			b_inpara = true;
			src = doc -> GetParaTextBytes (j, (int*)&style, &flags, (int*)&len);
			if (map_para_markedpositions.find (j) != map_para_markedpositions.end ())
				marked_positions = map_para_markedpositions.find (j)->second;
			win_encode = (style == PS_EVD) ? 1 : 0;
			j++;
		}

		if (wordposcontrol.find (j) == wordposcontrol.end ()) {
			wordposcontrol.insert (j);
			if(j == 1){
				if(wordPos > ContextSearch::DOC_BEGIN_WORD)
					WordPosControl(Id, j, &wordPos, wordPos - ContextSearch::DOC_BEGIN_WORD);
				else
					WordPosControl(Id, j, &wordPos, 0);
			}else
				WordPosControl(Id, j, &wordPos, 0);
		}

		if (is_aaktext && j > last_aakpara)
			break;

		long from_mark = 0x7FFF, to_mark = 0x7FFF;
		std::vector<long>::const_iterator marked_it = marked_positions.begin ();
		if (marked_positions.size ()) {
			from_mark = *marked_it;
			marked_it++;
			to_mark = *marked_it;
			marked_it++;
		}

		long processed_words = 0;
		const char* saved_src = src;
		std::string prev_word_1, prev_word_2, prev_word_3;

		while ( (wordLen= getParaWord((char*)buf, &src, len, &win_encode)) && wordLen > 0 && wordPos < ContextSearch::POS_TEXT){
			long marked_pos = src - saved_src;
			bool b_marked = false;
			if (marked_pos > from_mark && marked_pos <= to_mark)
				b_marked = true;
			if (marked_pos >= to_mark && marked_it != marked_positions.end ()) {
				from_mark = *marked_it;
				marked_it++;
				to_mark = *marked_it;
				marked_it++;
			}

			wordPos++, processed_words++;
			int corr_wordPos = wordPos << 2, pos_flag = 0;
			if (wordPos > ContextSearch::DOC_BEGIN_WORD) {
				if (b_invisible_block)
					corr_wordPos |= (pos_flag = GKDB_POS_INVISIBLE_BLOCK);
				else if (b_invisible_text || (new_src && src - new_src > saved_len))
					corr_wordPos |= (pos_flag = GKDB_POS_INVISIBLE);
				else if ((flags & ENDT_HEADER) || (flags & ENDT_ARTICLE_HEADER))
					corr_wordPos |= (pos_flag = GKDB_POS_HEADER);
				else if (b_marked)
					corr_wordPos |= (pos_flag = GKDB_POS_HEADER);
			} else if (wordPos < ContextSearch::DOC_BEGIN_WORD) {
				corr_wordPos |= (pos_flag = GKDB_POS_HEADER);
			}
			retrn.lastI= 0;
			if((RetVal= GetNormalesFromStrings (this, buf, &retrn, wordLen, p_ctxTextArray, &corr_wordPos, Id, j, pdoc)))
				abort();

			if (upd_bigrams_words.size () > 1) {
				if (upd_bigrams_words.find (buf) == upd_bigrams_words.end ()) {
					prev_word_1.clear ();
					prev_word_2.clear ();
					prev_word_3.clear ();
				} else {
					char prev_buf [256];
					memcpy (prev_buf, buf, wordLen + 1);

					if (prev_word_3.size ()) {
						prev_word_3 += "|";
						prev_word_3 += prev_buf;

						std::map<std::string,std::vector<std::string> >::const_iterator bigr_it = upd_bigrams.find (prev_word_3);
						if (bigr_it != upd_bigrams.end ()) for (std::vector<std::string>::const_iterator lemma_it = bigr_it->second.begin (); lemma_it != bigr_it->second.end (); lemma_it++) {
							unsigned lemma_len = lemma_it->size ();
							memcpy (buf, lemma_it->c_str (), lemma_len);
							int prev_pos = ((wordPos - 3) << 2) | pos_flag;

							GetNormalesFromStrings (this, buf, &retrn, lemma_len, p_ctxTextArray, &prev_pos, Id, j, pdoc);
						}
					}
					if (prev_word_2.size ()) {
						prev_word_2 += "|";
						prev_word_2 += prev_buf;

						std::map<std::string,std::vector<std::string> >::const_iterator bigr_it = upd_bigrams.find (prev_word_2);
						if (bigr_it != upd_bigrams.end ()) for (std::vector<std::string>::const_iterator lemma_it = bigr_it->second.begin (); lemma_it != bigr_it->second.end (); lemma_it++) {
							unsigned lemma_len = lemma_it->size ();
							memcpy (buf, lemma_it->c_str (), lemma_len);
							int prev_pos = ((wordPos - 2) << 2) | pos_flag;

							GetNormalesFromStrings (this, buf, &retrn, lemma_len, p_ctxTextArray, &prev_pos, Id, j, pdoc);
						}

						prev_word_3.swap (prev_word_2);
					}
					if (prev_word_1.size ()) {
						prev_word_1 += "|";
						prev_word_1 += prev_buf;

						std::map<std::string,std::vector<std::string> >::const_iterator bigr_it = upd_bigrams.find (prev_word_1);
						if (bigr_it != upd_bigrams.end ()) for (std::vector<std::string>::const_iterator lemma_it = bigr_it->second.begin (); lemma_it != bigr_it->second.end (); lemma_it++) {
							unsigned lemma_len = lemma_it->size ();
							memcpy (buf, lemma_it->c_str (), lemma_len);
							int prev_pos = ((wordPos - 1) << 2) | pos_flag;

							GetNormalesFromStrings (this, buf, &retrn, lemma_len, p_ctxTextArray, &prev_pos, Id, j, pdoc);
						}

						prev_word_2.swap (prev_word_1);
					}
					prev_word_1 = prev_buf;
				}
			}
		}
		if (new_src) {
			gk_free (new_src);
			new_src = 0;
		}
	}

	if(pDeleted)
		delete pDeleted;
}

extern void open_pgfiles_from_Base(base_st& thisBase, PagedFile *file, StreamFile * streams);

#ifdef DLT_IN_OLD_CONTEXT
extern "C" {
extern index_info_st known_indexes_table[];
extern int known_index(const char *name);

index_st *open_index_hack_Cntxt(pgfile_st *pf, const char *name, index_st *pin)
  {
	index_st *pindex;
	
	pindex = (pin) ? pin : (index_st *)ml_malloc(sizeof(index_st));
	if(!get_info(pf, name, &(pindex->hdr))) {
		if (!pin) free(pindex);
		return NULL;
	}
	pindex->mode = 0;
	pindex->name = strdup(name);
	if(!get_index_info(name, pindex)) {
		pindex->hdr.strinfo.immds = 4;
		pindex->hdr.strinfo.rndv = 1;
		pindex->hdr.nstreams = 1;
		pindex->keycmp = (cmpfunc_ft)strcmp;
		pindex->hdr.keylen = 16;
		pindex->reclen = 4;
		pindex->reccmp = longcmp;
	}
	pindex->pf = pf;
	pin->phdrpage = NULL;
	pin->str = NULL;

	index_info_st *pIi;
	pIi = known_indexes_table+known_index("NWCntxt.str");

	pin->hdr.strinfo.immds = pIi->immds;
	pin->hdr.nstreams = pIi->nstreams;
	pin->hdr.strinfo.rndv = pIi->rndv;
	pin->hdr.keylen = pIi->keylen;

	pin->reclen = pin->hdr.strinfo.immds;
	pin->keycmp = pIi->keycmp;
	pin->reccmp = pIi->reccmp;
	pin->flags = pIi->flags;

	return pin;
  }

extern void impModifyName(char *);
extern streamfile_st *create_stream_subFile(char *path, index_st *pin);
extern long DefValCryptoTag;
extern char *GetNameForTempFile(char *pCName, int hCFile);

index_st *create_morpho_index(base_st *pbase, const char *name, index_st *pin, const char *f_name)
  {
	int LastOther= 0;
	bzero((caddr_t)pin, sizeof(index_st));
	pin->mode = 1;
	get_index_info(name, pin);
	if(!pbase->pNextSubToms){
		pbase->pNextSubToms= pbase->pSubToms= (SubTom_st*)calloc(100, sizeof(SubTom_st));
	}
	pin->pbase = pbase;
	pin->name = strdup(f_name);
	{
		char	*filename = (char *)alloca(1024), *pExt;
		pin->pf= (pgfile_st*)calloc(1, sizeof(pgfile_st));
		strcpy(filename, pbase->key.name);
		pExt= strrchr(filename, '.')+1;
		strcpy(pExt, f_name);
		pExt= strrchr(pExt, '.');
		strcpy(pExt, ".key");
		impModifyName(filename);
		create_pgfile(filename, pin->pf, 4096);
		pin->pf->PrmExt.pCrptTag= (char*)&DefValCryptoTag;
		pin->pbase->pNextSubToms->pKey= pin->pf;
	}
	pin->phdrpage = pbase->key_header;
	bzero((caddr_t) &(pin->kar), sizeof(keyarray_st));
	pin->kar.fname = GetNameForTempFile(pbase->key.name, pbase->key.hfile);
	pin->kar.hkeys= c_io_open(pin->kar.fname, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY); // GARANT_GCC
	reset_key_array(&(pin->kar), pin->hdr.keylen);
	{
		char *filename = (char *)alloca(1024);
		strcpy(filename, pbase->key.name);
		pin->str= create_stream_subFile(filename, pin);
		pin->str->pgfile.PrmExt.pCrptTag= (char*)&DefValCryptoTag;
		pin->pbase->pNextSubToms->pStr= pin->str;
		pin->pbase->pNextSubToms->pName= strdup(name);
		pin->pbase->pNextSubToms++;
	}
	pin->hdr.order = ((pin->pf->pfhdr->page_size-6)/(pin->hdr.keylen+4)) >> 1;
	pin->hdr.root = 0;
	pin->hdr.key_count = 0;
	pin->hdr.depth = 1;
	return pin;
  }
}
int first_read6tr;
#endif

base_st *makeBaseForCopy(Base *base, base_st& thisBase, PagedFile *file, StreamFile * streams,
						 long *m_pNIdList, long Root, char *Name, char* pName, void **pp_UpdThdr,
	char **p_gs_target_name, index_st **p_pin, iter_st **p_spit, stream_st **p_pdstr)
{
		base_st *ptarget= 0;
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
		memset(&thisBase, 0, sizeof(base_st));
		char *gs_target_name= strdup(file->FileName);
		index_st *pin= (index_st *)calloc(
  #ifdef STORE_FORM_N
											5
  #else
											2
  #endif
												, sizeof(index_st)), *prin= pin + 1;
		stream_st *pdstr= (stream_st *)calloc(
  #ifdef STORE_FORM_N
												10
  #else
												2
  #endif
												, sizeof(stream_st)),
					*psstr= pdstr +
  #ifdef STORE_FORM_N
												2
  #else
												1
  #endif
												;
		iter_st *spit= 0;
		strcpy(strrchr(gs_target_name, '.'), ".tmp");
		ptarget = (base_st *)calloc(1, sizeof(base_st));
#ifdef DLT_IN_OLD_CONTEXT
		Index *iiU= 0;
		if(m_pNIdList){
			iiU= base->FindIndex(Name);
			open_pgfiles_from_Base(thisBase, iiU->file, iiU->streams);
			int rpt;
			first_read6tr= streams->file->GetFileHandle();
			for(rpt= 1; rpt < MAX_COUNT_FILE_HANDLES+1 && streams->file->m_postFileHandles[rpt] != -1; rpt++){
				if(c_io_close(streams->file->m_postFileHandles[rpt]))
					exit(-111);
				streams->file->m_postFileHandles[rpt]= -1;
			}
			streams->file->SetFileHandle(*(iiU->streams->file->m_postFileHandles));
			for(rpt= 1; rpt < MAX_COUNT_FILE_HANDLES+1 && (iiU->streams->file->m_postFileHandles)[rpt] != -1; rpt++){
				(streams->file->m_postFileHandles)[rpt]= (iiU->streams->file->m_postFileHandles)[rpt];
			}
			memcpy(	streams->file->m_postFilePoss, thisBase.str.pgfile.PrmExt.pFilePoss, MAX_COUNT_FILE_HANDLES*sizeof(u_int32_t));
		}else
#endif
		open_pgfiles_from_Base(thisBase, file, streams);
		init_streams_cache(&thisBase.str, OBSC_SEQSP | OBSC_LARGE);
		if(thisBase.str.hits)
			free(thisBase.str.hits);
		thisBase.str.hits= 0;
		thisBase.flags = 1;

		create_base(gs_target_name, ptarget);
		if(!m_pNIdList){
		  if(Root != -1){
			free(gs_target_name);
			gs_target_name= strdup(ptarget->key.name);
			close_pgfile(&ptarget->key);
			ace_os_unlink(gs_target_name);
			free(gs_target_name);
			gs_target_name= strdup(ptarget->str.pgfile.name);
			close_pgfile(&ptarget->str.pgfile);
			ace_os_unlink(gs_target_name);
			free(gs_target_name);

			ptarget->str.pgfile= thisBase.str.pgfile;
			ptarget->str.pgfile.PrmExt.pFileHandles= (int*)ptarget->str.pgfile.postFileHandles;
			ptarget->str.pgfile.PrmExt.pFilePoss= (int*)ptarget->str.pgfile.postFilePoss;
			free(ptarget->str.fat);
			ptarget->str.fat_alloc= thisBase.str.fat_size * 2;
			if((ptarget->str.fat=
				(fat_rec_type *)realloc(thisBase.str.fat,
					 ((u_int32_t)ptarget->str.fat_alloc) << ptarget->str.pgfile.pgpow))
											== 0)
				exit(-18);
			thisBase.str.fat= 0;
			ptarget->str.fat_chain[0]= 1;
			for(ptarget->str.fat_size= 0;
					ptarget->str.fat_size<thisBase.str.fat_size;
						ptarget->str.fat_size++) {
				ptarget->str.fat_chain[ptarget->str.fat_size+1]
					= ptarget->str.fat[ptarget->str.fat_chain[ptarget->str.fat_size]]
						& ~CHAIN_FLAG;
			}
			ptarget->str.lfp= ptarget->str.fat_chain[ptarget->str.fat_size-1];
			ptarget->str.pgfile.AddedPage= thisBase.str.pgfile.pfhdr->last_page + 1;
			int curr_sub_file= 0;
			ptarget->str.pgfile.mode = ptarget->str.pgfile.PrmExt.accesMode=
				ptarget->str.pgfile.PrmExt.processMode= ACE_OS_O_WRONLY;
			memset(ptarget->str.pgfile.postFileHandles, -1,
					sizeof(*ptarget->str.pgfile.postFileHandles)*MAX_COUNT_FILE_HANDLES);
			while(thisBase.str.pgfile.PrmExt.pFileHandles[curr_sub_file] != -1){
		#ifdef INSTLL_CIB
				if(	*(long*)ptarget->str.pgfile.PrmExt.pCrptTag
							< (long)ptarget->str.pgfile.pfhdr->page_size )
		#endif
				{
					c_io_close(thisBase.str.pgfile.PrmExt.pFileHandles[curr_sub_file]);
					thisBase.str.pgfile.postFileHandles[curr_sub_file]=
						thisBase.str.pgfile.PrmExt.pFileHandles[curr_sub_file]=
						ptarget->str.pgfile.postFileHandles[curr_sub_file]= -1;
					if(!curr_sub_file){
						ptarget->str.pgfile.hfile=
							ptarget->str.pgfile.postFileHandles[curr_sub_file]
						= c_io_open(ptarget->str.pgfile.PrmExt.FileName,
									ptarget->str.pgfile.mode | ACE_OS_O_BINARY);
						if(ptarget->str.pgfile.hfile == -1
							|| c_io_lseek(ptarget->str.pgfile.hfile,
		ptarget->str.pgfile.postFilePoss[curr_sub_file] << ptarget->str.pgfile.pgpow,
											ACE_OS_SEEK_SET) < 1)
							exit(-17);
					}else if(otherFileOpen(curr_sub_file,
										&ptarget->str.pgfile.PrmExt)
						|| c_io_lseek(ptarget->str.pgfile.postFileHandles[curr_sub_file],
		ptarget->str.pgfile.postFilePoss[curr_sub_file] << ptarget->str.pgfile.pgpow,
											ACE_OS_SEEK_SET) < 1)
						exit(-17);
				}
				curr_sub_file++;
			}
			ptarget->str.pgfile.PrmExt.pFileHandles= ptarget->str.pgfile.postFileHandles;
			ptarget->str.pgfile.PrmExt.pFilePoss= (int*)ptarget->str.pgfile.postFilePoss;
			ptarget->str.pgfile.mode = ptarget->str.pgfile.PrmExt.accesMode= ACE_OS_O_RDWR;

			ptarget->key= thisBase.key;
			ptarget->key.mode = 1;
			ptarget->key.AddedPage= thisBase.key.pfhdr->last_page + 1;
			ptarget->key.hfile= file->GetFileHandle();
			ptarget->key.name= strdup(file->FileName);
			ptarget->key.PrmExt.pFileHandles= (int*)ptarget->key.postFileHandles;
			ptarget->key.PrmExt.pFilePoss= (int*)ptarget->key.postFilePoss;
#ifdef MULTI_INDEX_STREAM_FILE
			create_indexEx(ptarget, pName, pin, *pp_UpdThdr);
#else
			create_index(ptarget, pName, pin);
#endif
			pin->pf->pfhdr->TomPerPages= ptarget->key.pfhdr->TomPerPages;
			if(ptarget->key.pfhdr->TomPerPages)
				pin->pf->PrmExt.maxFile_per_bytes
					= ptarget->key.pfhdr->TomPerPages * ptarget->key.pfhdr->page_size;

			pin->str->pgfile.pfhdr->TomPerPages= ptarget->str.pgfile.pfhdr->TomPerPages;
			if(ptarget->str.pgfile.pfhdr->TomPerPages)
				pin->str->pgfile.PrmExt.maxFile_per_bytes
					= ptarget->str.pgfile.pfhdr->TomPerPages * ptarget->str.pgfile.pfhdr->page_size;
		  }
		}else if(!m_pNIdList){
			exit(-19);
		}else{	free(thisBase.ndt.name);thisBase.ndt.name= 0;
			if(
				!(spit= (iter_st *)calloc(1,
												sizeof(iter_st)
#ifdef STORE_FORM_N
																* 3
#endif
																	))
					||
#ifdef DLT_IN_OLD_CONTEXT
				open_index_hack_Cntxt
#else
				open_index_hack
#endif
								(&thisBase.key, Name, prin) == 0
	#ifdef STORE_FORM_N
					||
				!(thisBase.pNextSubToms= thisBase.pSubToms= (struct tag_SubTom *)calloc(100, sizeof(SubTom_st)))
					||
				!(thisBase.key.name= strdup(base->keyFile->FileName))
					||
	#endif
				!(prin->str = &(thisBase.str))
					||
#ifdef DLT_IN_OLD_CONTEXT
				!create_morpho_index(	ptarget, pName, pin, Name)
					||
				!(pin->str->fat_alloc= streams->fatPages + 8887)
					||
				(iiU->streams->m_deletedFat= 0)
#else
				!create_index(		ptarget, pName, pin)
					||
				!(pin->str->fat_alloc= thisBase.str.fat_size + 8887)
#endif
					|| !(pin->pf->PrmExt.cur_Seek= my_def_io_seek) ||
				!(prin->pf->PrmExt.cur_Seek= my_def_io_seek) || !(prin->pf->PrmExt.cur_Read= my_def_io_read)
					||
				!init_iter(prin, spit)
					||
				!(prin->str->pgfile.PrmExt.cur_Seek= my_def_io_seek) || !(prin->str->pgfile.PrmExt.cur_Read= my_def_io_read)
					||
				!create_stream(prin, psstr))
			{
				exit(-29);
			}
			first_key(spit);
			free(pin->str->fat);
			pin->str->fat= (fat_rec_type *)streams->m_deletedFat; streams->m_deletedFat= 0;
			free(ptarget->str.fat_chain);
			free(ptarget->str.centries);
			free(ptarget->str.cache);
			ptarget->str.fat_chain= 0;
			free(ptarget->str.fat);
			ptarget->str.fat= 0;
			pin->pf->pfhdr->TomPerPages= prin->pf->pfhdr->TomPerPages;
			if(prin->pf->pfhdr->TomPerPages)
				pin->pf->PrmExt.maxFile_per_bytes
					= prin->pf->pfhdr->TomPerPages * prin->pf->pfhdr->page_size;

			pin->str->pgfile.pfhdr->TomPerPages= prin->str->pgfile.pfhdr->TomPerPages;
			if(prin->str->pgfile.pfhdr->TomPerPages)
				pin->str->pgfile.PrmExt.maxFile_per_bytes
					= prin->str->pgfile.pfhdr->TomPerPages * prin->str->pgfile.pfhdr->page_size;
		}
		*p_gs_target_name= gs_target_name;
		*p_pin= pin;
		*p_spit= spit;
		*p_pdstr= pdstr;
#endif
		return ptarget;
}

NContxtIndex * UpdtContextIndex::FindContextIndexForFlash()
{
	//InitTempFiles();
	CloseLastTemp();
	char tmpBaseName[256], *fnd= strrchr(file->FileName, '.');
	*fnd= 0;
	if(!FlashCount && m_pNIdList){
		sprintf(tmpBaseName, pTempFileListFormat, //"j:\\"
														file->FileName);
		if(m_pNIdList != (long*)-1){
			int fhl= c_io_open(tmpBaseName, ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_BINARY|ACE_OS_O_WRONLY);
			if(fhl != -1){
				c_io_write(fhl, &m_AllPatchedAndNewDocsTextSize, sizeof(m_AllPatchedAndNewDocsTextSize));
				long *pNxt= m_pNIdList, curr_pos= c_io_lseek(fhl, 0, ACE_OS_SEEK_CUR), count= 0;
				c_io_write(fhl, &curr_pos, sizeof(curr_pos));
				while(*pNxt != 0x7ffffffc){
					c_io_write(fhl, pNxt++, sizeof(*pNxt));
					count++;
				}
				c_io_lseek(fhl, curr_pos, ACE_OS_SEEK_SET);
				c_io_write(fhl, &count, sizeof(count));

				pNxt= m_pNIdDelList;
				curr_pos= c_io_lseek(fhl, 0, ACE_OS_SEEK_END); count= 0;
				c_io_write(fhl, &curr_pos, sizeof(curr_pos));
				while(*pNxt != 0x7ffffffc){
					c_io_write(fhl, pNxt++, sizeof(*pNxt));
					count++;
				}
				c_io_lseek(fhl, curr_pos, ACE_OS_SEEK_SET);
				c_io_write(fhl, &count, sizeof(count));

				c_io_close(fhl);
			}else{
				exit(-737,tmpBaseName);
			}
		}
		pTempFileListName= strdup(tmpBaseName);
	}
	sprintf(tmpBaseName, pTempFileFormat, //"j:\\"
													file->FileName, FlashCount);
	*fnd= '.';
	countNewKeys= pre_size= 0;
	alloc_size= GROW_BY * (pNxtNPut ? 10 : 1);
	if((indxs[FlashCount].pInd
		= (LPPL_YYY)malloc(sizeof(PL_YYY)*alloc_size)) == 0)
	{
		exit(-636,tmpBaseName);
	}
	if((indxs[FlashCount].file= ::ACE_OS::open(tmpBaseName, ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_BINARY|
#ifdef MIN_MEM_CONTEXT
																											ACE_OS_O_WRONLY
#else
																											ACE_OS_O_RDWR
#endif
																											)) == ACE_INVALID_HANDLE){
		exit(-434,tmpBaseName);
	}
#ifndef MIN_MEM_CONTEXT
	ace_os_unlink(tmpBaseName);
#endif
	if(::ACE_OS::write(indxs[FlashCount].file, &countNewKeys, sizeof(countNewKeys)) != sizeof(countNewKeys)){
		exit(-535,tmpBaseName);
	}
	indxs[FlashCount].file_len= 0;
#ifdef MIN_MEM_CONTEXT
	indxs[FlashCount].FileName= strdup(tmpBaseName);
#endif
	indxs[FlashCount].max_size_saved_Node= 0;
    return this;
}

bool UpdtContextIndex::IsReparsingAllTexts(DocIterator *it, IGarDoc *doc, u_int64_tCtxLongSetSplayMap *pMap)
{
	if(IsReaderFlush()){
		//InitFlushStat();
		nflushIt( pMap, FindContextIndexForFlash() );
	}
	Index *attrI = base->FindIndex("Attrs");
	free(attrI->streams->m_deletedFat);
	attrI->streams->m_deletedFat= 0;
	CopyAsFlush(it);

	return false;
}

char name_temp_flush_handle[1024];
NContxtIndex *pNIndexReRead= 0;
//#ifndef WIN64 // раскоментарили для сборки фейковой х64 версии
	u_int32_t max_size00= (134*1024*1024);
//#endif
stref_st *pref00;

int compare_iter_st_long( const void *arg1, const void *arg2 )
{
	return *(long*)(((iter_st *)arg1)->pkey) - *(long*)(((iter_st *)arg2)->pkey);
}

int compZZZ( const void *arg1, const void *arg2 )
{
	return CompStringsZZZ((*(LPPL_ZZZ*)arg1)->pInd->k, (*(LPPL_ZZZ*)arg2)->pInd->k);
}

int compZZZ1( const void *arg1, const void *arg2 )
{
   long	l1= 0x7fffffff & (*(long*)(*(LPPL_ZZZ*)arg1)->readBuff),
		l2= 0x7fffffff & (*(long*)(*(LPPL_ZZZ*)arg2)->readBuff);
   if( l1 < l2 )
	   return -1;
   if( l1 == l2 )
	   return 0;
   return 1;
}

void UpdtContextIndex::InitTempFiles()
{
	/////////////////////////////////////////
	if(!pTempFileFormat){
	   InitFileNameTempFiles();
	   int tmpFileHandle= -1;
	   char tmpBaseName[256], *fnd= strrchr(file->FileName, '.');
	   *fnd= 0;
	   sprintf(tmpBaseName, pTempFileListFormat, /*"j:\\"*/file->FileName);
	   if((tmpFileHandle= c_io_open(tmpBaseName, ACE_OS_O_RDONLY|ACE_OS_O_BINARY)) != -1){
		   long sz;
		   if(	c_io_read(tmpFileHandle, &m_AllPatchedAndNewDocsTextSize,
						sizeof(m_AllPatchedAndNewDocsTextSize))
							!= sizeof(m_AllPatchedAndNewDocsTextSize)
					||
				c_io_read(tmpFileHandle, &sz, sizeof(sz)) != sizeof(sz)
					||
				(m_pNIdList= (long*)malloc(sz*sizeof(*m_pNIdList)+sizeof(*m_pNIdList))) == 0
					||
				c_io_read(tmpFileHandle, m_pNIdList, sz*sizeof(*m_pNIdList))
							!= sz*(long)sizeof(*m_pNIdList)
					||
				(m_pNIdList[sz]= 0x7ffffffc) != 0x7ffffffc
					||
				c_io_read(tmpFileHandle, &sz, sizeof(sz)) != sizeof(sz)
					||
				(m_pNIdDelList= (long*)malloc(sz*sizeof(*m_pNIdDelList)+sizeof(*m_pNIdDelList))) == 0
					||
				(c_io_read(tmpFileHandle, m_pNIdDelList, sz*sizeof(*m_pNIdDelList)))
							!= sz*(long)sizeof(*m_pNIdDelList)
					||
				(m_pNIdDelList[sz]= 0x7ffffffc) != 0x7ffffffc){
			   c_io_close(tmpFileHandle);
			   exit(-2,tmpBaseName);
		   }
		   m_sNIdDelList= sz + 1;
		   c_io_close(tmpFileHandle);
		   pTempFileListName= strdup(tmpBaseName);
	   }else
		   exit(-2222,tmpBaseName);
	   if((allocIndxs += 1000)
				&&(indxs=
						(LPPL_ZZZ)malloc(sizeof(PL_ZZZ)*allocIndxs))
								== 0)
				exit(-636,tmpBaseName);
		sprintf(tmpBaseName, pTempFileFormat, file->FileName, 0);
		*fnd= '.';
	}
}
