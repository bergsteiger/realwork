#ifndef _FBASE_H_
#define _FBASE_H_

#include "stdbase.h"
#include "PL_Defs.h"
extern "C"
{
	#include "../../../libs/mrglib/src/gdbapi.h"
}

class FirstBase : public YBase
{
  public:
	FirstBase(	const char * name
				, int mode= (ACE_OS_O_RDWR | ACE_OS_O_CREAT | ACE_OS_O_TRUNC)
				, int key_cpages=-1
				, int str_cpages =-1
				, int ndt_cache = -1
				, FILE *stat_file =0 )
		: YBase(	name
					, mode
					, ndt_cache)
	{
		currentBlockSize= ADD_BLOCK_SIZE;
#ifndef MIN_MEM_CONTEXT
		reConnectKeyAndStr(name,mode);
		keyFile->m_pCryptoTag= (char*)calloc(1,(Base::dfStrFileSize+Base::dfStrFileSize)+SIZE_CRYPTO_HEADER+sizeof(long));
		strFile->m_pCryptoTag= (char*)calloc(1,(Base::dfStrFileSize+Base::dfStrFileSize)+SIZE_CRYPTO_HEADER+sizeof(long));
		*(long*)keyFile->m_pCryptoTag=
	#ifdef OLD_SHORT_STR
										(Base::dfStrFileSize+Base::dfStrFileSize)+Base::dfKeyFileSize;
	#endif

										*(long*)strFile->m_pCryptoTag= (Base::dfStrFileSize+Base::dfStrFileSize)+Base::dfStrFileSize;
		if ( !keyFile -> Exist () ){
	#ifdef OLD_SHORT_STR
			keyFile -> Create ( dfKeyFileSize );
	#else
			keyFile -> Create ( Base::dfStrFileSize );
	#endif
		}
#else
		keyFile->m_pCryptoTag= (char*)calloc(1,MAX_CRYPTED_BLOCK+SIZE_CRYPTO_HEADER+sizeof(long));
		strFile->m_pCryptoTag= (char*)calloc(1,MAX_CRYPTED_BLOCK+SIZE_CRYPTO_HEADER+sizeof(long));
		textFile->m_pCryptoTag= (char*)&lDefNdtCryptoTag;
		*(long*)keyFile->m_pCryptoTag= dfKeyFileSize;
		*(long*)strFile->m_pCryptoTag= dfStrFileSize;
		if ( !keyFile -> Exist () ){
			keyFile -> Create ( Base::dfKeyFileSize );
		}
#endif
		if ( !strFile -> Exist () ){
			strFile -> Create (  Base::dfStrFileSize );
		}
		if ( !textFile -> Exist () )
			textFile -> Create ( Base::dfNdtFileSize );

		if ( !keyFile -> Exist () || !strFile -> Exist () || !textFile -> Exist () )
			return;

		curr_mode= mode;
	}
	virtual ~FirstBase(){
		if(new_docBuf != 0){
			free(new_docBuf);
		}
		if(new_runs != 0){
			free(new_runs);
		}
		if(new_blocks != 0){
			free(new_blocks);
		}
		FindIndex("Blob")->streams->EndTransaction();
		pOtherIndex[0].pStreamFile->EndTransaction();
		pOtherIndex[1].pStreamFile->EndTransaction();

		FreeIndices ();

		int f0= streamFile->file->GetFileHandle(), f1= textFile->GetFileHandle(), f2= keyFile->GetFileHandle();

		if ( streamFile != 0 )
			delete streamFile;

		if ( textFile != 0 )
			delete textFile;

		if ( keyFile != 0 )
			delete keyFile;

		c_io_close ( f0 ); c_io_close ( f1 );c_io_close ( f2 );
		keyFile= 0;
	}
	AttrIndex ** get_docInd()
	{
		return &docInd;
	}
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	/*	// Форсированное добвление коротких стримов старого формата в GC не поддерживается
		//	в самом конце, т.к. тама модификация оных, а о-очень жаль, а то выигрышь по скорости мог быть в десятки раз 
		virtual	StreamFile* makeAttrs_StreamsPool(PagedFile* pFile, int bLoadFat) {
			return new NdtClone::StreamFileFastAdd(strFile, bLoadFat);
		}
	*/
protected:
	virtual PagedFile *makePagedFile(const char * name, int omode)
	{
		Index tmp;
		return tmp.GetCreatedPagedFile(name, BASE_DATA_VERSION);
	}
#endif
};

static void createIndexes(FirstBase *pBg)
{
	pBg->streamFile = pBg->make_StreamsPool( pBg->strFile, 0 );
	pBg->streamFile -> Create ();
#ifdef MIN_MEM_CONTEXT
	*(long*)pBg->keyFile->m_pCryptoTag= MAX_CRYPTED_BLOCK + Base::dfKeyFileSize;
	*(long*)pBg->strFile->m_pCryptoTag= MAX_CRYPTED_BLOCK + Base::dfStrFileSize;
#endif
	CreatedBigStream= 1;

	pBg->new_docBuf = (char *) calloc ( 1, 2*ADD_BLOCK_SIZE + 1024 + ADD_BLOCK_SIZE );
	pBg->pDocsBlockBufferOut= pBg->pDocsBlockBuffer= pBg->new_docBuf + 2*ADD_BLOCK_SIZE + 1024;
	pBg->countDocsBlockBuffer= 0;
	pBg->new_runs	= (PageRun *)calloc(sizeof(PageRun),MAX_RUNS);
	pBg->new_blocks	= (BlockRec *)calloc(sizeof(BlockRec),MAX_BLOCKS);

	pBg->max_runs = MAX_RUNS;
	pBg->max_blocks = MAX_BLOCKS;
	{
		LPG_OTHER_INDEX pAttrsStruct= 0;
		char nmOldA[]= "Attrs.str", nmOldX[]= "Aux.str", nmOldCntxt[]= "Context.str";

		if(strrchr(pBg->keyFile->FileName, '(')){
			// Для клона иной подход в создании индексов			//
			// в NdtClone::Index::Create через Base::createIndices()	//
			char *pExt= strrchr(pBg->keyFile->FileName, '.'), temp_created_ext[1024];
			strcpy(temp_created_ext,pExt);
			*pExt= 0;
			(*(pBg->get_docInd())= (AttrIndex*)pBg->FindIndex(nmOldA))->Create(sizeof ( AttrKey ),1,1);
			pBg->FindIndex(nmOldX)->Create(5,1,1);
			//
			(*(pBg->get_docInd()))= (AttrIndex*)pBg->FindIndex(nmOldCntxt);
			(*(pBg->get_docInd()))->Create(CTX_WORD_SIZE,sizeof(long)*3,1);
			Stream *pLabel= (*(pBg->get_docInd()))->OpenN(nmOldCntxt+strlen(nmOldCntxt),0,1);
			(*(pBg->get_docInd()))->Close(pLabel);
			*(pBg->get_docInd())= (AttrIndex*)(*(pBg->indTable));
			unsigned char prsnph[]= {	0x20, 0xF9, 0x0A, 0x7A, 0xFA, 0xFA, 0x20, 0x3A, 0xD7, 0x4F, 0xCF, 0x1A, 0x06, 0x6A, 0x61, 0x4C,
										0xD7, 0xD8, 0xBA, 0x1B, 0xF9, 0xF7, 0x0C, 0xA8, 0xCD, 0x0D, 0x60, 0xD5, 0x15, 0xF7, 0x94, 0x32,
										0xC0, 0x01, 0xDE, 0x9B, 0xA5, 0x09, 0xD5, 0xA8, 0x3C, 0x52, 0x0B, 0x8A, 0xCB, 0x58, 0xC9, 0x48,
										0x4C, 0x0E, 0xB2, 0xFF, 0x62, 0x99, 0xB3, 0xB3, 0xCC, 0x54, 0x3A, 0xD8, 0x98, 0x91, 0xFA, 0x4E,
										0xE2, 0xC5, 0x6D, 0x00, 0x05, 0x2D, 0x41, 0xF9, 0x6F, 0xA3, 0x53, 0x8A, 0x9C, 0x58, 0xE6, 0x6C,
										0x93, 0x9E, 0x2E, 0x6D, 0x36, 0x16, 0x47, 0x6A, 0x1B, 0x43, 0x65, 0xA2, 0x31, 0x42, 0xD1, 0xAC,
										0x98, 0x4C, 0x26, 0xED, 0x1C, 0x47, 0x6C, 0x4D, 0xF0, 0x46, 0x9A, 0x00, 0x30, 0xDA, 0x21, 0x55,
										0x59, 0x5A, 0x07, 0x26, 0x8E, 0x36, 0x78, 0x2B, 0xBA, 0xB0, 0xDF, 0xB6, 0x94, 0x0B, 0x13, 0x43,
										0xAF, 0x7C, 0x99, 0x31, 0x9F, 0x95, 0xC0, 0xCF, 0x2F, 0x40, 0x16, 0x53, 0xF8, 0x14, 0x5B, 0x35,
										0x40, 0x61, 0xF8, 0xC1, 0xE5, 0x9F, 0x4E, 0x23, 0x76, 0x7D, 0x15, 0x62, 0xEE, 0x01, 0x77, 0x90,
										0x75, 0x35, 0x70, 0xF1, 0xBD, 0x2E, 0x79, 0x5E, 0x22, 0xAA, 0x8C, 0x16, 0xB4, 0x58, 0xDD, 0xF5,
										0xEA, 0x62, 0x29, 0x31, 0x17, 0xBB, 0x60, 0x98, 0xD5, 0x56, 0x85, 0xD8, 0xA3, 0xCA, 0xE1, 0x5A,
										0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x61,
										0x39, 0x62, 0x35, 0x37, 0x38, 0x35, 0x39, 0x33, 0x35, 0x38, 0x39, 0x64, 0x32, 0x31, 0x36, 0x00,
										0x08, 0x68, 0x41, 0x82, 0x8F, 0x04, 0x09, 0x12, 0x30, 0xF7, 0xFB, 0x9C, 0x9D, 0xE3, 0x71, 0xDA,
										0x39, 0xE7, 0xD9, 0x05, 0x4C, 0xE2, 0xAD, 0x98, 0x81, 0x0C, 0x76, 0xD9, 0x50, 0xCC, 0x72, 0x1C};
			c_io_lseek(pBg->textFile->GetFileHandle(), pBg->textFile->AttrOffs, ACE_OS_SEEK_SET);
			c_io_write(pBg->textFile->GetFileHandle(), prsnph, (unsigned int)(sizeof(prsnph) & 0xfff));
			c_io_lseek(pBg->textFile->GetFileHandle(), 0, ACE_OS_SEEK_SET);
			//
			strcpy(pExt, temp_created_ext);
			pAttrsStruct= pBg->pOtherIndex;
		}else{
			pBg->FindIndex(nmOldCntxt);
			(*(pBg->get_docInd())= (AttrIndex*)(pBg->FindIndex(nmOldA)))->Create(sizeof ( AttrKey ),1,1);
			pAttrsStruct= pBg->pOtherNextIndex-1;
			pBg->FindIndex(nmOldX)->Create(5,1,1);
		}
		{
			// Direct create on the 1ey & 8tr
			pBg->FindIndexOther("CalIn.str",pAttrsStruct)			->Create( sizeof(date),	sizeof (long)*3, 1);
			pBg->FindIndexOther("CalAb.str",pAttrsStruct)			->Create( sizeof(date),	sizeof (long)*3, 1);
			pBg->FindIndexOther("CalCh.str",pAttrsStruct)			->Create( sizeof(date),	sizeof (long)*3, 1);

			pBg->FindIndexOther(pBg->m_SubNamesName,pAttrsStruct)	->Create( sizeof(Ref),	sizeof (long)*3,1);
			pBg->FindIndexOther(pBg->m_TagName,pAttrsStruct)		->Create(TAG_KEY_SIZE,	sizeof (long)*3, 1, sizeof(RefwWeight));

			pBg->FindIndex("Adopted")->Create(	ADOPTED_KEY_SIZE,	sizeof(long)*3,	1);
			pBg->FindIndex("Territory")->Create(	ADOPTED_KEY_SIZE,	sizeof(long)*3,	1);

			pBg->FindIndex("DocKind")->Create(	CLASS_KEY_SIZE,		sizeof(Ref)*3,	1,	sizeof(Ref));
			pBg->FindIndex("Class")->Create(		CLASS_KEY_SIZE,		sizeof(Ref)*3,	1,	sizeof(Ref));

			pBg->FindIndex("PhGroup")->Create(INPHARM_PHARMGROUP_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("PhEffect")->Create(INPHARM_PHARMEFFECT_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("Mkb")->Create(INPHARM_MKB_SIZE,sizeof(Ref)*3,1,sizeof(Ref));
			pBg->FindIndex("Chapter")->Create(INPHARM_CHAPTER_SIZE,sizeof(Ref)*3,1,sizeof(Ref));
			pBg->FindIndex("ServiceInfo")->Create(CLASS_KEY_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
			pBg->FindIndex("Atc")->Create(INPHARM_ATC_SIZE,sizeof(long)*3,1, sizeof (long));
			pBg->FindIndex("RegStatus")->Create(INPHARM_REGSTATUS_SIZE,sizeof(Ref)*3,1, sizeof (Ref));
			pBg->FindIndex("LekForm")->Create(INPHARM_REGSTATUS_SIZE,sizeof(Ref)*3,1, sizeof (Ref));
			pBg->FindIndex("PhFirm")->Create(INPHARM_FIRM_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
			pBg->FindIndex("PhCountry")->Create(INPHARM_COUNTRY_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
			pBg->FindIndex("Type")->Create(TYPE_KEY_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
			pBg->FindIndex("Kind")->Create(KIND_KEY_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
			pBg->FindIndex("RegDate")->Create(sizeof ( date ),sizeof(Ref)*3,1, sizeof (Ref));
			pBg->FindIndex("Date")->Create(sizeof ( date ),sizeof(long)*3,1);
			pBg->FindIndex("AnnulDate")->Create(sizeof ( date ),sizeof(Ref)*3,1, sizeof (Ref));
			pBg->FindIndex("Active")->Create(sizeof ( date ),sizeof(Ref)*3,1, sizeof (Ref));
			pBg->FindIndex("Number")->Create(CODE_KEY_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("Status")->Create(2,sizeof(long)*3,1);
			pBg->FindIndex("Status_ex")->Create(2,sizeof(Ref)*3,1,sizeof (Ref));
			pBg->FindIndex("KeyWord")->Create(SEC_KW_SIZE,sizeof(Ref)*3,1,sizeof(Ref));
			pBg->FindIndex("RCode")->Create(CODE_KEY_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("Respondent")->Create(4,sizeof(long)*3,1,sizeof(Ref));
			pBg->FindIndex("Correspondent")->Create(4,sizeof(long)*3,1,sizeof(Ref));
			pBg->FindIndex("RDate")->Create(sizeof(date),sizeof(long)*3,1);
			pBg->FindIndex("Context")->Create(CTX_WORD_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("VIncluded")->Create(sizeof(date ),sizeof(long)*3,1);
			pBg->FindIndex("VChanged")->Create(sizeof(date ),sizeof(long)*3,1);
			pBg->FindIndex("VAbolished")->Create(sizeof(date),sizeof(long)*3,1);
			pBg->FindIndex("SortDate")->Create(sizeof ( date ),sizeof(long)*3,1);
			pBg->FindIndex("VAnonced")->Create(sizeof(date),sizeof(long)*3,1);
			pBg->FindIndex("VLControl")->Create(sizeof(date),sizeof(long)*3,1);
			pBg->FindIndex("Category")->Create(CATEGORY_KEY_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("TradeName")->Create(INPHARM_TRADENAME_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("IntName")->Create(INPHARM_INTNAME_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("PublishedIn")->Create(PUBLISHEDIN_KEY_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("Segment")->Create(2,sizeof(long)*3,1);
			pBg->FindIndex("Blob")->Create(sizeof(ObjKey),sizeof(long)*3,2);
			pBg->FindIndex("Control")->Create(sizeof(date),sizeof(long)*3,1,2*sizeof(long));
			pBg->FindIndex("Class6")->Create(CLASS_KEY_SIZE,sizeof(Ref)*3,2,sizeof(Ref));
			pBg->FindIndex("NewCorr")->Create(4,sizeof(long)*3,1,sizeof(CorrRef));
			pBg->FindIndex("Attribs")->Create(sizeof ( AttrKey ),1,1);
			pBg->FindIndex("AnnoUser")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("AnnoOrganization")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("AnnoTax")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("AnnoInterest")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("AnnoKind")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
			pBg->FindIndex("AnnoDate")->Create(sizeof(date),sizeof(long)*3,1);
			pBg->FindIndex("KindCorr")->Create(sizeof(Ref),sizeof(long)*3,1);
		}
	}
	(pBg->streamFile)->StartTransaction();
	(pBg->pOtherIndex[0].pStreamFile)->StartTransaction();
	(pBg->pOtherIndex[1].pStreamFile)->StartTransaction();
}
#endif
