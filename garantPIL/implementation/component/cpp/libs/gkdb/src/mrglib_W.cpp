#ifdef PTRS_IN_META
	#include "fbase.h"
	#include "../../../tools/gctools/src/MyPipe.h"
	#include <cstring>
	#include <deque>
	#include "../../../tools/gctools/src/dbproc.m0-to-gkdb.h"

#ifdef OLD_SHORT_STR
	namespace NdtClone {
		extern const char *pBuckupFileExt;
	}
#endif

	extern "C"
	{
#ifdef OLD_SHORT_STR
		extern void pl_OpenBase(	LPPF_PARAM pKey, LPPF_PARAM pStr,
									char **keyTag, char **strTag, char **ndtTag);
#endif
		void close_RObase(base_st *);

		int create_base(const char *path, base_st *pbase)
		{
			FirstBase *pBase;
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
		class FirstCloneBase : public FirstBase
		{
		  public:
			FirstCloneBase(	const char * name
						, int mode= (ACE_OS_O_RDWR | ACE_OS_O_CREAT | ACE_OS_O_TRUNC)
						, int key_cpages=-1
						, int str_cpages =-1
						, int ndt_cache = -1
						, FILE *stat_file =0 )
				: FirstBase(	name
								, mode
								, ndt_cache	)
			{
			}
			virtual	StreamFile *make_StreamsPool(PagedFile *pFile, int bLoadFat)
			{
				return new NdtClone::StreamFileFastAdd(strFile, bLoadFat);
			}
			// Форсированное добвление коротких стримов старого формата
			//	выигрышь по скорости в десятки раз 
			virtual	StreamFile* makeAttrs_StreamsPool(PagedFile* pFile, int bLoadFat) {
				return new NdtClone::StreamFileFastAdd(strFile, bLoadFat);
			}
		protected:
			class AttrIndexOnlySortAdd : public AttrIndex {
			public:
				AttrIndexOnlySortAdd(PagedFile* f, const char* n, StreamFile* s) : AttrIndex (f,n,s) {}
				virtual int	Put (long DocId, int tag, const void* data, int size)
				{
					return Replace(DocId, tag, (void*)data, size);
				}
				virtual int	Replace (long DocId, int tag, void* buf, int size)
				{
					AttrKey tt= {DocId, tag};
					Stream *pstr= OpenN(&tt,0,1);
					pstr->Write(buf, size);
					Close(pstr);
					return size;
				}
			};
			virtual AttrIndex* makeAttrsIndex(PagedFile* f, const char* n, StreamFile* s)
			{
				return new AttrIndexOnlySortAdd(f,n,s);
			}
			class HHindex : public HIndex {
			public:
				HHindex(PagedFile* f, const char* n, StreamFile* s) : HIndex (f,n,s) {
					f->m_mode &= ~GKDB::BT_GO_TO_ROOT;
				}
				virtual	Stream * OpenN(BTKEY kk, int sn, int ac=0, int *pCreated=0)
				{
					return Index::OpenN(kk, sn, ac, pCreated);
				}
			};
			virtual HIndex* makeHIndex(PagedFile* f, const char* n, StreamFile* s)
			{
				return new HHindex(f,n,s);
			}
			class KKWordIndex : public KeyWordIndex {
			public:
				KKWordIndex(PagedFile* f, const char* n, StreamFile* s) : KeyWordIndex (f,n,s) {
					f->m_mode &= ~GKDB::BT_GO_TO_ROOT;
				}
				virtual	Stream * OpenN(BTKEY kk, int sn, int ac=0, int *pCreated=0)
				{
					return Index::OpenN(kk, sn, ac, pCreated);
				}
			};
			virtual KeyWordIndex* makeKeyWordIndex(PagedFile* f, const char* n, StreamFile* s)
			{
				return new KKWordIndex(f,n,s);
			}
		};
			pBase= new FirstCloneBase(path);
#else
			pBase= new FirstBase(path);
#endif
			createIndexes(pBase);
			pbase->pSubToms= (SubTom_st*)pBase;

			short PageSz= pBase->textFile->PageSize >> 1;

			memcpy(pbase->ndt.postFileHandles, pBase->textFile->m_postFileHandles, MAX_COUNT_FILE_HANDLES+1);
			pbase->ndt.PrmExt.pFileHandles= pbase->ndt.postFileHandles;
			pbase->ndt.hfile= *pbase->ndt.PrmExt.pFileHandles;

			memcpy(pbase->ndt.postFilePoss, pBase->textFile->m_postFilePoss, MAX_COUNT_FILE_HANDLES+1);
			pbase->ndt.PrmExt.pFilePoss= (int*)(pbase->ndt.postFilePoss);

			pbase->ndt.PrmExt.accesMode= pBase->textFile->m_mode;
			pbase->ndt.PrmExt.FileName= pBase->textFile->FileName;
			pbase->ndt.PrmExt.maxFile_per_bytes= pBase->textFile->m_max_paged_file_per_bytes;
			pbase->ndt.PrmExt.pHeader= pBase->textFile->SystemPageBuf;
			pbase->ndt.PrmExt.pUncompressBuffer= pBase->textFile->rbuf;
			pbase->ndt.PrmExt.pPackTable= (unsigned int*)pBase->textFile->pageOffs;
			pbase->ndt.PrmExt.PackArraySize= pBase->textFile->m_PackArraySize;
			pbase->ndt.PrmExt.MessageForNextFunc= pBase->textFile->m_MessageForNextFunc;
			pbase->ndt.PrmExt.CloseProcessFunc= pBase->textFile->m_CloseProcessFunc;
			pbase->ndt.PrmExt.pCrptTag= pBase->textFile->m_pCryptoTag;
			pbase->ndt.PrmExt.iPost= 1;
			pbase->ndt.PrmExt.cur_Seek= pBase->textFile->m_readed.cur_Seek;

			pbase->ndt.pfhdr= (pfhdr_st *)pBase->textFile->SystemPageBuf;
			pbase->ndt.attr_area= pBase->textFile->SystemPageBuf + pBase->textFile->AttrOffs;
			for(pbase->ndt.pgpow= 0;PageSz; pbase->ndt.pgpow++, PageSz >>= 1);

			pbase->ndt.AddedPage= 1;

			pbase->key.attr_area= pBase->keyFile->SystemPageBuf + pBase->textFile->AttrOffs;

			return 1;
		}
		void set_key_attr_area(base_st *pbase)
		{
			// Last cterated index on key-file //
			Index *pI= (Index *)(pbase->str.cache);
			pbase->key.attr_area= pI->file->SystemPageBuf + pI->file->AttrOffs;
		}
		void clone_close_base(base_st *pbase)
		{
			delete (FirstBase*)(pbase->pSubToms);
		}
		index_st *create_indexEx(base_st *pbase, const char *name, index_st *pin, void *pOtherRootNodeOut)
		{
			pin->str= &(pbase->str);
			pin->str->str_header= (char*)(pbase->pSubToms);
			static int firstSwitch= 1920234561;
			{
				if(pin->str->cache && pin->str->fat && *(int*)(((Index*)(pin->str->cache))->Name) == firstSwitch){
					firstSwitch= 0;
					pin->str->cache= (char*)((Index*)(pin->str->cache));
				}else{
					pin->str->cache= (char*)(((FirstBase*)(pin->str->str_header))->FindIndex(name));
					if(*(int*)(name+2) == 0x2e737274)
						pin->pbase= pbase;
				}
				pin->name= ((Index*)pin->str->cache)->Name;
			}
#ifdef NOT_MRGLIB_OUT_IN_META
#else
			{
				static bool Sstr= true;
				if(!pin->str->hits){
					pin->str->hits= (fat_rec_type *)(((FirstBase*)(pbase->pSubToms))->indTable);
					LPTHREAD_CNTX pRead2= (LPTHREAD_CNTX)(((LPTHREAD_CNTX)(((LPTHREAD_CNTX)pOtherRootNodeOut)->pWriterCtxt))->pTxtCntxt);
					if(pRead2)
					{
						static int isRead2= 0, isWrite2= 0, _all_2= 0, _all_R2= 0;

						LPTHREAD_CNTX pWrite2= (LPTHREAD_CNTX)(pRead2->pTxtCntxt);

						pWrite2->p_Wr= pRead2->p_Wr= &isWrite2;
						pWrite2->p_Rd= pRead2->p_Rd= &isRead2;

						pWrite2->p_all_= pRead2->p_all_= &_all_2,
						pWrite2->p_all_R= pRead2->p_all_R= &_all_R2,

						pWrite2->PGCParameters= pRead2->PGCParameters= pbase+(pRead2->l_argc - 1);

						ACE_thread_t working_thread_id = 0;
						ACE_hthread_t working_thread_handle = 0;
						int res = ACE_OS::thr_create (
							(ACE_THR_FUNC)(((LPTHREAD_CNTX)pOtherRootNodeOut)->pWriterProc)
							, pRead2
							, THR_NEW_LWP | THR_JOINABLE
							, &working_thread_id
							, &working_thread_handle
							, ACE_DEFAULT_THREAD_PRIORITY
							, 0 //stack_ptr
							, 32*1024*1024
						);

						if(res == -1){
							pRead2->h_currPipe= 0;
							exit(-1);
						}
					}else{
						Sstr= false;
					}
					pin->str->centries= (cache_entry *)(pin->str->hits);
					((LPTHREAD_CNTX)pOtherRootNodeOut)->PGCParameters= pbase;
					((LPTHREAD_CNTX)pOtherRootNodeOut)->l_argv[1]= 0;
					{
						DbProcessorM0toGKDB reader(new DbProcMetaFile((char*)pOtherRootNodeOut,0), (Base*)(pin->str->str_header), 0);
						reader.run();
					}
					while(Sstr)
						ace_os_sleep(200);
  #ifdef OLD_SHORT_STR
					char	*pname= ((FirstBase*)(pin->str->str_header))->keyFile->FileName
							, *pfndname= strrchr(pname,'.')
							, *pnname= (char*)alloca(1+(pfndname-pname));

					memcpy(pnname,pname,pfndname-pname);
					pnname[pfndname-pname]= 0;
  #endif
					//::puts("\n\nTake DEBUG !");
					//::getch();
					delete ((FirstBase*)(pin->str->str_header));
  #ifdef OLD_SHORT_STR
					{
						class OldBase : public YBase
						{
							public:
								OldBase(const char * name)
									: YBase(	name
												, ACE_OS_O_RDWR|ACE_OS_O_CREAT
												, -1)
								{
									currentBlockSize= ADD_BLOCK_SIZE;
									reConnectKeyAndStr(name,ACE_OS_O_RDWR);
									if(strFile->IsOk()){
										int lenF= strlen(strFile->FileName), lenE= strlen(NdtClone::pBuckupFileExt)+1;
										char *nmDlt= (char*)alloca(lenF+lenE);
										memcpy(nmDlt,strFile->FileName,lenF);
										memcpy(nmDlt+lenF,NdtClone::pBuckupFileExt,lenE);
										ace_os_unlink(nmDlt);
										*(nmDlt+lenF-3)= '8';
										ace_os_unlink(nmDlt);
										*(nmDlt+lenF-3)= '9';
										ace_os_unlink(nmDlt);
									}
									pl_OpenBase(	&keyFile->m_readed, &strFile->m_readed,
													&keyFile->m_pCryptoTag, &strFile->m_pCryptoTag,
													&textFile->m_pCryptoTag);
								}
							protected:
								virtual PagedFile *makePagedFile(const char * name, int omode)
								{
									return NdtClone::GetUpdatedPagedFile(name, BASE_DATA_VERSION);
								}
						};
						OldBase tmp(pnname);
						long *FirstFAT= (long *)alloca(tmp.strFile->PageSize);
						if(tmp.strFile->GetPage(3,FirstFAT)){
							FirstFAT[1]= FirstFAT[3];
							FirstFAT[3]= tmp.strFile->PageSize;
							if(!tmp.strFile->PutPage(1,FirstFAT))
								return 0;
							void *nn= alloca(tmp.strFile->PageSize);
							memset(nn,0,tmp.strFile->PageSize);
							if(!tmp.strFile->PutPage(3,nn))
								return 0;
						}
					}
  #endif
				}else if(!pin->str->centries){
					pin->str->centries= (cache_entry *)(((FirstBase*)(pbase->pSubToms))->indTable);
					{
						DbProcessorM0toGKDB reader(new DbProcMetaFile((char*)pOtherRootNodeOut,0), (Base*)(pin->str->str_header), 0);
						reader.run();
					}
					Sstr= false;
				}
			}
#endif
			return pin;
		}
		stream_st *load_stream(iter_st *pit, stream_st *pstr)
		{
			stref_st *pref;
			
			pref = get_stref((iter_st *)(pstr->pAForms= (Form_Node*)pit), (pstr->curr_B= 0));
			return load_stream_ex(pit->str, pref, pstr, &(pit->strinfo));
		}
		stream_st *create_stream(index_st *pin, stream_st *pstr)
		{
			create_stream_ex(pin->str, pstr, &(pin->hdr.strinfo));
			return pstr;
		}
		void close_base(base_st *pbase)
		{
			close_RObase(pbase);
		}
	}
#endif
	#include "../../../tools/gctools/src/dbproc.m-writer.h"
	extern "C"
	{
		int init_MetaFile(int threadMode, void *ThreadCntxt, base_st *psrc, int count)
		{
			// ((LPTHREAD_CNTX)ThreadCntxt)
			switch(threadMode)
			{
				case 0:
				case 2:
					{
						DbProcMetaFile *pmh= new DbProcMetaFile((const char*)ThreadCntxt,1,1);
						DbProcessorMWritter *pret= new DbProcessorMWritter( pmh );
						psrc->str.fat_chain= (u_int32_t*)pmh;
						int rpt= count;
						while(rpt--){
							psrc[rpt].str.spage= (char*)pret;
						}
					}
					break;
				default:
					return 0;
			}
			return count;
		}
		int done_MetaFile(base_st *psrc, int count)
		{
			DbProcessorMWritter *pret= (DbProcessorMWritter *)(psrc->str.spage);
			psrc->str.spage= 0;
			delete pret;
			DbProcMetaFile *pmh= (DbProcMetaFile *)(psrc->str.fat_chain);
			psrc->str.fat_chain= 0;
			delete pmh;
			return 0;
		}
		void attach_stream_only(stream_st *pstr, stref_st *pref)
		{
			int pk= int(pstr->cblock&0xffff), tl= 0;
			pref->size= 0;
			Stream tmpS(	((Index *)(pstr->str->cache))->streams
							, (IndexRecordData *)pref
							,((Index *)(pstr->str->cache))->ImmDataSize,((Index *)(pstr->str->cache))->roundv);
			while(tl < pk){
				if(tmpS.Write(pstr->ppBlock[tl++], 0x10000) != 0x10000){
					((Index *)(pstr->str->cache))->streams->abort();
				}
			}
			pk= int(pstr->cboffs&0xffff);
			if(tmpS.Write(pstr->ppBlock[tl], pk) != pk){
				((Index *)(pstr->str->cache))->streams->abort();
			}
			tmpS.closeAttrs ();
			tmpS.IndexFreeBuf= 0;
			if(tmpS.blocks)
				free( tmpS.blocks );
			tmpS.blocks= 0;
		}
		void move_stream_only(stream_st *pstr, streamfile_st *pdest, stref_st *pref)
		{
			int sz= pstr->ref.size/0x10000 + 1;
			char **pBlcks= (char**)alloca(sizeof(*pBlcks)*sz), **pB= pBlcks, *pR= pstr->data;
			stream_st tstr;
			memset(&tstr, 0, sizeof(tstr));
			tstr.ppBlock= pBlcks;
			tstr.cboffs= pstr->ref.size;
			tstr.str= pdest;
			do{
				*pB= pR;
				sz--;
			}while(sz && ++tstr.cblock && pB++ && (pR += 0x10000) && (tstr.cboffs -= 0x10000));
			attach_stream_only( &tstr, pref );
		}
		void attach_stream(stream_st *pstr, stref_st *pref)
		{
			int tl, pk; 
			attach_stream_only( pstr, pref );
			char *pkey= ((char*)(pref+1)) - ((Index *)(pstr->str->cache))->KeyLength + ((Index *)(pstr->str->cache))->ImmDataSize - 4;
			if(((Index *)(pstr->str->cache))->LocateKey(pkey, pkey, tl, pk, 1 ) != GKDB::BT_NONE)
			{
				((Index *)(pstr->str->cache))->streams->abort();
			}
		}
		void add_key_as_buf(index_st *pin, void *pkey)
		{
			int tl, pk; 
			if(((Index *)(pin->str->cache))->LocateKey(pkey, pkey, tl, pk, 1 ) != GKDB::BT_NONE)
			{
				((Index *)(pin->str->cache))->streams->abort();
			}
		}
		void move_stream_doc_struct(stream_st *pstr, streamfile_st *pdest, stref_st *prf)
		{
			iter_st *pit= (iter_st *)(pstr->pAForms);
			pit->str->str_header= new char[prf->size];
			pstr->ref.size= prf->size;
			pstr->flags &= SF_USELOCAL;
			pstr->pos= 0;
			pstr->info.immds= pit->strinfo.immds;
			pstr->info.rndv= pit->strinfo.rndv;
			pit->str->str_header= 0;
			((DbProcessorMWritter *)(pit->str->spage))->setTopicDocStruct(*(topic_t*)(pit->pkey), (DocStruct *)(read_long_stream(pit->str, prf)), pstr->ref.size/sizeof (DocStruct)) ;
			delete [](pit->str->str_header);
			pit->str->str_header= 0;
		}
		void move_stream(stream_st *pstr, streamfile_st *pdest, stref_st *pref)
		{
			iter_st *pit= (iter_st *)(pstr->pAForms);
			Index *pDest=  (Index *)(pdest->cache);
			if(pit->str->spage){
				switch(*(int*)(pDest->Name))
				{
					case 1920234561:
						{
							((DbProcessorMWritter *)(pit->str->spage))->addAttribute(*(topic_t*)(pit->pkey), 0x00007fff & (*(u_int32_t*)(((topic_t*)(pit->pkey)) + 1)), pstr->data, pstr->ref.size) ;
						}
						return;
					case 1315075411:
						{
							((DbProcessorMWritter *)(pit->str->spage))->setRefName(*(topic_t*)(pit->pkey), pstr->data, pstr->ref.size, *(gdocsub_t*)(((topic_t*)(pit->pkey)) + 1)) ;
						}
						return;
					case 779646273:
						{
							((DbProcessorMWritter *)(pit->str->spage))->writeAux(pit->pkey, pstr->data, pstr->ref.size);
						}
						return;
					default:
						{
							IAdd_st *pExp= new IAdd_st;
							pExp->pIAdd= pDest;
							memcpy(pExp->pIKey, pit->pkey,((char*)(pDest->recordData(pit->pkey,0))) - pit->pkey);
							((DbProcessorMWritter *)(pit->str->spage))->createTopic(0,pstr->data, pstr->ref.size,(const revision*)(&pExp),1);
						}
						return;
				}
			}
			if(pDest){
				Stream *pW= 0;
				/*if(pdest->hits == (fat_rec_type *)-1){
					// без значащего значения pit, но только для нулевого стрима //
					pW= pDest->Index::OpenN(((char*)(pref+1)) - pDest->KeyLength + pDest->ImmDataSize - 4, 0, 1);
				}else*/
					pW= pDest->Index::OpenN(pit->pkey,(((char*)pref) - (char*)get_stref(pit,0)) / (sizeof(stref_st) - 4 + pit->strinfo.immds),1);

				if(pW)
				{
					if(pW->Write(pstr->data,pstr->ref.size) != pstr->ref.size)
						throw NdtClone::Error();
					try{
						pDest->Close(pW);
					}catch(...)
					{
						throw NdtClone::Error();
					}
				}else
					throw NdtClone::Error();
			}
		}
		void store_it_key(iter_st *pit, void *pkey, streamfile_st *pdest, stream_st *pstr, stream_st *pdstr)
		{
			IAdd_st *pExp= new IAdd_st;
			pExp->pIAdd= (Index *)(pdest->cache);
			long dd= 0;
			if(pit->nstreams == 2 && pstr->ref.size > 1){
				if(pstr->ppBlock){
					dd= long(pstr->ref.size & 0x7fffffff);
				}else{
					dd= long(pstr->ref.size & 0x7fffffff);
				}
			}
			u_int16_t rpt= 0;
			char *bff= (char *)alloca(pdstr->ref.size+dd), *pW= bff;
			if(pstr->ppBlock){
				while(rpt < pstr->cblock){
					memcpy(pW,pstr->ppBlock[rpt++],0x10000);
					pW += 0x10000;
				}
				memcpy(pW,pstr->ppBlock[rpt],pstr->cboffs); pW += pstr->cboffs;
				rpt= 0;
			}else{
				memcpy(pW, pstr->data, dd); pW += dd;
			}
			while(rpt < pdstr->cblock){
				memcpy(pW,pdstr->ppBlock[rpt++],0x10000);
				pW += 0x10000;
			}
			memcpy(pW,pdstr->ppBlock[rpt],pdstr->cboffs);
			memcpy(pExp->pIKey, pkey,((char*)get_stref_ex((char*)pkey, pit->keylen, pit->strinfo.immds, pit->nstreams, 0)) - (char*)pkey);
			((DbProcessorMWritter *)(pit->str->spage))->createTopic(dd,bff, pdstr->ref.size + dd,(const revision*)(&pExp),1);
		}
	}
