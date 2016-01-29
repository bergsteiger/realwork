#ifndef _dbproc_m0f_to_gkdb_h
#define _dbproc_m0f_to_gkdb_h

#include "../../../libs/gc/src/dbproc.h"
#include "dbproc.m-reader.h"

typedef struct tag_IAdd {
	Index	*pIAdd;
	char	pIKey[300+12+12+12];
} IAdd_st;

class DbProcessorM0toGKDB : public DbProcessorMReader {
  protected:
  	Base *base;
	topic_t  c_topic;
	Index *idxAux, *idxStatus, *idxSegment, *idxStatus_ex;
	Index *idxClass, *idxPrefix, *idxResp, *idxCorr, *idxCategory;
	Index *idxTradeName, *idxIntName;
	Index *idxDate, *idxRDate, *idxSortDate, *idxActive;
	Index *idxVAbolished, *idxVChanged, *idxVIncluded;
	Index *idxServiceInfo, *idxType, *idxKeyword, *idxSource, *idxTerritory, *idxKind;
	Index *idxInpharmFirm, *idxInpharmCountry, *idxInpharmPharmGroup;
	Index *idxInpharmPharmEffect, *idxInpharmChapter, *idxAtc, *idxRegStatus;
	Index *idxInpharmMkb, *idxLekForm;
	Index *idxCalIn, *idxCalAb, *idxCalCh;

	Index *idxPublishedIn, *idxRCode, *idxCode;
	Index *idxVAnonced, *idxVLControl;
	Index *idxBlob, *idxSawa;
	Index *idxRegDate, *idxAnnulDate;
  public:
  	int debug;
	DbProcessorM0toGKDB(DbProcMetaHolder *m, Base *b, int d=0 ): DbProcessorMReader(m)
		, base(b)
		, c_topic(0)
		, debug(d)
	{
		if( ! DbProcessorMReader::OK() ){
			printf("DbProcessorMFReader is not OK.\n");
			return;
		}
		idxAux = base->FindIndex( "Aux" );
		idxStatus = base->FindIndex( "Status" );
		idxStatus_ex = base->FindIndex( "Status_ex" );
		idxSegment = base->FindIndex( "Segment" );
		idxCategory = base->FindIndex( "Category" );
		idxTradeName = base->FindIndex ("TradeName");
		idxIntName = base->FindIndex ("IntName");
		idxResp = base->FindIndex("Respondent" );
		idxCorr = base->FindIndex("Correspondent" );
		idxClass = base->FindIndex("Class" );
		idxPrefix = base->FindIndex("DocKind" );
		idxDate = base->FindIndex("Date" );
		idxActive = base->FindIndex("Active" );
		idxRegDate = base->FindIndex("RegDate" );
		idxAnnulDate = base->FindIndex("AnnulDate" );
		idxRDate = base->FindIndex("RDate" );
		idxSortDate = base->FindIndex("SortDate" );
		idxVAbolished = base->FindIndex("VAbolished" );
		idxVChanged = base->FindIndex("VChanged" );
		idxVIncluded = base->FindIndex("VIncluded" );
		idxVAnonced = base->FindIndex("VAnonced" );
		idxVLControl = base->FindIndex("VLControl" );
		idxServiceInfo = base->FindIndex("ServiceInfo" );
		idxInpharmFirm = base->FindIndex ("PhFirm");
		idxAtc = base->FindIndex ("Atc");
		idxRegStatus = base->FindIndex ("RegStatus");
		idxLekForm = base->FindIndex ("LekForm");
		idxInpharmCountry = base->FindIndex ("PhCountry");
		idxInpharmPharmGroup = base->FindIndex ("PhGroup");
		idxInpharmPharmEffect = base->FindIndex ("PhEffect");
		idxInpharmMkb = base->FindIndex ("Mkb");
		idxInpharmChapter = base->FindIndex ("Chapter");
		idxType = base->FindIndex("Type");
		idxKeyword = base->FindIndex("KeyWord");
		idxKind = base->FindIndex("Kind");
		idxSource = base->FindIndex("Adopted");
		idxTerritory = base->FindIndex("Territory");
		idxPublishedIn = base->FindIndex("PublishedIn" );
		idxRCode = base->FindIndex("RCode" );
		idxCode = base->FindIndex("Number" );
		idxBlob = base->FindIndex("Blob" );
		idxCalIn = base->FindIndex ("CalIn.str" );
		idxCalAb = base->FindIndex ("CalAb.str" );
		idxCalCh = base->FindIndex ("CalCh.str" );
		base->FindIndex ("Tag.str" );
	}
	virtual int addAttribute(topic_t t,u_int32_t tg,
					const void *d,size_t l )
	{
		if( debug ){
			printf( "addAttribute: id: %ld tag: %ld\n", t, tg);
		}
		if(tg == IDD2_PARAIDS){
			base->ReplaceAttrEx(t, tg, (void *)d, l);
		}else
			base->PutAttr(t, tg, (void *)d, l);
		return 0;
	}
	virtual int setTopicDocStruct (topic_t t, DocStruct *d, long l)
	{
	  #ifndef PTRS_IN_META
		base->ReplaceAttr(t, IDD_DOCSTRUCT, d, l);
	  #else
  #ifdef PTRS_ONLY
		DocStruct *pdata= (DocStruct *)*(size_t*)(1+(int*)d);
		base->ReplaceAttr(t, IDD_DOCSTRUCT, pdata, *(int*)d);
		delete []pdata;
  #else
		base->ReplaceAttr(t, IDD_DOCSTRUCT, d, l);
  #endif
	  #endif
		return 0;
	}
	int setRefName(topic_t t,const char *n, size_t l,gdocsub_t s)
	{
		if( debug ){
			printf( "setRefName: id: %ld\n", t);
		}
		Ref rf;
		rf.DocId = t;
		rf.Sub = s;
		Stream *str = base -> subNames -> Open ( &rf, 1 );
		if( str ){
			str->Write((void*)n,l);
			base->subNames->Close(str);
		}else{
			printf("Can't open stream.\n");
			return 1;
		}
		return 0;
	}
  protected:
	int write2index(Index *idx, const void *k, const void *d, size_t len )
	{
		Stream *str = idx->Open((void *)k, 1 );
		if( str ){
			if( len != (unsigned) (str->Write((void *)d,len)) ){
				printf("Warning: partial write on an index.\n");
				idx->Close(str);
				return 1;
			}
			idx->Close(str);
		}else{
			printf("Can't open stream on an index.");
			return 1;
		}
		return 0;
	}
  public:
	int writeAux(const void *key,const void *d,int l)
	{
		return write2index(idxAux, key, d, l );
	}
	virtual topic_t createTopic(long id,const char *title,int tl, const revision *r, int pk)
	{
#ifdef PTRS_IN_META
		IAdd_st *pImprt= (IAdd_st*)*(size_t*)r;
		//
		//  огда pImprt->pIKey хранит только значение ключа, то пользуем:
		//	pImprt->pIAdd->AddData(pImprt->pIKey, 0, title, tl);
		//  огда pImprt->pIKey хранит значение ключа в рекорде(после mrglib-ского write_stream со ссылкой в таргете
		// на указатель указателей), то пользуем: 
		//	pImprt->pIAdd->AddData_MRGLIB(pImprt->pIKey, 0, (char**)&title, tl);
		//
		if( debug ){
			printf( "UnPack Struct Data for Index(%)\n", pImprt->pIAdd->Name);
		}
		IndexRecordData *pOne= pImprt->pIAdd->recordData(pImprt->pIKey,0);
		pImprt->pIAdd->skipInitRecord();
		pOne->header.realDataLength= 0;
		if(pImprt->pIAdd->nstreams > 0)
			pOne[1].header.realDataLength= 0;
		if(id){
			Stream tmpS1(pImprt->pIAdd->streams,pOne+1,pImprt->pIAdd->ImmDataSize,pImprt->pIAdd->roundv);
			if(tmpS1.Write(title, id) != id){
				pImprt->pIAdd->streams->abort();
			}
			tmpS1.closeAttrs ();
			tmpS1.IndexFreeBuf= 0;
			if(tmpS1.blocks)
				free( tmpS1.blocks );
			tmpS1.blocks= 0;
		}
		Stream tmpS(pImprt->pIAdd->streams,pOne,pImprt->pIAdd->ImmDataSize,pImprt->pIAdd->roundv);
		if(tmpS.Write((title+id), tl-id) != tl-id){
			pImprt->pIAdd->streams->abort();
		}
		tmpS.closeAttrs ();
		tmpS.IndexFreeBuf= 0;
		if(tmpS.blocks)
			free( tmpS.blocks );
		tmpS.blocks= 0;
		if(pImprt->pIAdd->LocateKey( pImprt->pIKey, pImprt->pIKey, tl, pk, 1 ) != GKDB::BT_NONE)
			pImprt->pIAdd->streams->abort();
		delete pImprt;
#endif
		return 2;
	}
};


#endif