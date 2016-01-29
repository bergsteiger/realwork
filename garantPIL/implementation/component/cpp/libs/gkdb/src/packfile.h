#ifndef __gPACK_CLASS_H
#define __gPACK_CLASS_H

#include "shared/Core/fix/mpcxc.h"
#include "pagefile.h"
#include "pack.h"
#include "zlib.h"

class CompressedFile : public PagedFile
{
public:
	CompressedFile( const char *name ) : PagedFile ( name, ACE_OS_O_RDONLY, MAX_BYTE_FILE_SIZE)
	{
		m_lstPackedOffs= 0;
	}
	int PackBigFile(void *pObject, int count= 0)
	{
		PagedFile *pTarget= (PagedFile *)pObject;
		if(pTarget->isPacked || pTarget->m_lstPackedPage > LastPage)
			return 0;
		if(count == 0)
			count= LastPage;
		if(count > LastPage || count < 1l)
			return -1;
		if(pTarget->m_lstPackedPage == 0l){
			pTarget->m_lstPackedPage= 1l;
			*pTarget->m_ppreLogicalPage= 0l;
			pTarget->m_ppreLogicalPage[1]= 0l;
			if(pTarget->pBff != 0 || (pTarget->pBff = (char *)malloc(PageSize*3)) == 0 ||
				pTarget->pageOffs != 0
					|| ((pTarget->pageOffs= (unsigned int gk_huge *)gk_malloc(sizeof(ACE_UINT64) +
																				5 // GARANT_MSVC7: GARANT_XXX but seems to be more safe
																					* (int)( LastPage + 1l ))) == 0
																			))
				return -5;
			ACE_UINT64 posT= (ACE_UINT64)PageSize;
			memset(pTarget->pageOffs, 0, sizeof(ACE_UINT64) + 5 * (int)( LastPage + 1l ));
			memcpy(pTarget->pageOffs, &posT, 5);
			m_inOther= (ACE_UINT64)0;
		}
		unsigned szPack= (unsigned)(PageSize & 0x7fff);
		if(this == pTarget){
			if(!(m_mode & ACE_OS_O_WRONLY)){
				file = c_io_open(FileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY); 
				if (file == -1) {
					fprintf(stderr, "Cannot create file %s.\n", FileName);
					return -1;		// cannot be created
				}
				for(szPack=0; szPack < MAX_COUNT_FILE_HANDLES+1; szPack++)
					if(m_postFileHandles[szPack] != -1)
						c_io_close(m_postFileHandles[szPack]);

				memset(m_postFileHandles+1, -1, MAX_COUNT_FILE_HANDLES*sizeof(*m_postFileHandles));
				memset(m_postFilePoss, 0, (MAX_COUNT_FILE_HANDLES+1)*sizeof(*m_postFilePoss));
				*m_postFileHandles= file;
				m_mode= ACE_OS_O_RDWR | ACE_OS_O_CREAT;
			}
		}else if(pTarget->m_lstPackedPage == 1l
					&& ((pTarget->m_max_paged_file_per_bytes= m_max_paged_file_per_bytes) == 0l
							|| memcpy(pTarget->SystemPageBuf,SystemPageBuf,PageSize) == 0))
			return -1;

		PF_PARAM tmp;
		int percnt= 0;

	#ifndef NO_GSSCREEN
		if(pContext != 0){
			sprintf(pTarget->pBff, getCopyingFormat(), pTarget->FileName);
			pContext->OtherShowMessage(pTarget->pBff);
			pContext->SetProgress(0);
		}
	#endif
		while(count--){
			if(!GetPage(pTarget->m_lstPackedPage, pTarget->pBff))
				return -1;
			if( ((ACE_UINT64)pTarget->m_lstPackedPage)*PageSize <= (ACE_UINT64)(4096*2)
				|| !(szPack= G_ZIP(pTarget->pBff, (int)PageSize,
								pTarget->pBff+(int)PageSize+m_lstPackedOffs, (int)PageSize-1))){
				szPack= PageSize;
				memcpy(pTarget->pBff+(int)PageSize+m_lstPackedOffs,
						pTarget->pBff, szPack);
			}
			if((int)szPack >= PageSize){
				szPack= memcmp(	pTarget->pBff,
								pTarget->pBff+(int)PageSize+m_lstPackedOffs,
								PageSize);
				szPack= PageSize;
			}
			tmp.maxFile_per_bytes= pTarget->m_max_paged_file_per_bytes;
			tmp.pHeader= pTarget->SystemPageBuf;
			tmp.PackArraySize= 0l;
			int preTPage =(int)(*(ACE_UINT64*)(5 * (pTarget->m_lstPackedPage-1) + (char*)pTarget->pageOffs)
									/ (ACE_UINT64)PageSize);
			if(	*pTarget->m_ppreLogicalPage == 0l && (tmp.page= pTarget->m_lstPackedPage+1)
				&& IsLogicalTom(&tmp) && IsNextTom(&tmp)){
				// “екущий пакованный выравниваем до страницы /////////
				if(m_lstPackedOffs + (int)szPack > (int)PageSize){
					szPack= (unsigned)PageSize-m_lstPackedOffs;
					memcpy(	pTarget->pBff+(int)PageSize+m_lstPackedOffs,
							pTarget->pBff, (int)szPack);
					if(!pTarget->PutPage(preTPage, pTarget->pBff+(int)PageSize))
						return -1;
					memcpy(	pTarget->pBff+(int)PageSize, pTarget->pBff+(int)szPack,
															(int)PageSize-(int)szPack);
					szPack += (unsigned)PageSize;
					m_lstPackedOffs= 0;
					*pTarget->m_ppreLogicalPage=preTPage+2;
				}else{
					szPack= (int)PageSize - m_lstPackedOffs;
					*pTarget->m_ppreLogicalPage=preTPage+1;
				}
				pTarget->m_ppreLogicalPage[1]=
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1];
				if(pTarget != this){
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0]
						= pTarget->m_ppreLogicalPage[0];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1]
						= pTarget->m_ppreLogicalPage[1];
				}
			}else if(pTarget->m_lstPackedPage == pTarget->m_ppreLogicalPage[1]){
				// “екущий пакованный выравниваем до страницы /////////
				if(m_lstPackedOffs + (int)szPack > (int)PageSize){
					szPack= (unsigned)PageSize-m_lstPackedOffs;
					memcpy(	pTarget->pBff+(int)PageSize+m_lstPackedOffs,
							pTarget->pBff, (int)szPack);
					pTarget->m_ppreLogicalPage[1]=preTPage+1;
					if(!pTarget->PutPage(preTPage, pTarget->pBff+(int)PageSize))
						return -1;
					memcpy(	pTarget->pBff+(int)PageSize, pTarget->pBff+(int)szPack,
															(int)PageSize-(int)szPack);
					szPack += (unsigned)PageSize;
					m_lstPackedOffs= 0;
				}else{
					szPack= (int)PageSize - m_lstPackedOffs;
					pTarget->m_ppreLogicalPage[1]=preTPage;
				}
				if(pTarget != this){
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1]
						= pTarget->m_ppreLogicalPage[1];
				}
			}
			if((m_lstPackedOffs+=(int)szPack) >= (int)PageSize){
				if(szPack > (unsigned)PageSize){
					tmp.page= preTPage+1;
					m_lstPackedOffs= (int)PageSize;
				}else
					tmp.page= preTPage;
				if(*pTarget->m_ppreLogicalPage != 0l){
				  if(pTarget == this){
					int pTmp[2];
					pTmp[0]= ((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0];
					pTmp[1]= ((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0]
						= pTarget->m_ppreLogicalPage[0];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1]
						= pTarget->m_ppreLogicalPage[1];
					if(pTarget->m_ppreLogicalPage[1] == tmp.page)
						*pTarget->m_ppreLogicalPage= 0l;
					else{
						pTarget->m_ppreLogicalPage[0]= pTmp[0];
						pTarget->m_ppreLogicalPage[1]= pTmp[1];
					}
				  }else if(pTarget->m_ppreLogicalPage[1] == tmp.page)
						*pTarget->m_ppreLogicalPage= 0l;
				}else{
					tmp.PackArraySize=
						pTarget->m_PackArraySize = (LastPage + 1l) * 5;
				}
				if(IsNextTom(&tmp))
					m_inOther += (ACE_UINT64)PageSize;
				if(szPack > (unsigned)PageSize){
					if(!pTarget->PutPage(preTPage+1, pTarget->pBff+(int)PageSize))
						return -1;
					if(*pTarget->m_ppreLogicalPage == 0l)
						m_inOther += (ACE_UINT64)PageSize;
				}else if(!pTarget->PutPage(preTPage, pTarget->pBff+(int)PageSize))
						return -1;
				if(*pTarget->m_ppreLogicalPage != 0l){
				  if(pTarget == this){
					int pTmp[2];
					pTmp[0]= ((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0];
					pTmp[1]= ((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0]=
							pTarget->m_ppreLogicalPage[0];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1]=
							pTarget->m_ppreLogicalPage[1];
					pTarget->m_ppreLogicalPage[0]= pTmp[0];
					pTarget->m_ppreLogicalPage[1]= pTmp[1];
				  }
				}else
					pTarget->m_PackArraySize = 0l;

				if((m_lstPackedOffs -= (int)PageSize)){
					memcpy(	pTarget->pBff+(int)PageSize,
							pTarget->pBff+(int)PageSize*2, m_lstPackedOffs);
				}
			}
			ACE_UINT64 tmpNewPos= *(ACE_UINT64*)(5 * (pTarget->m_lstPackedPage-1) + (char*)pTarget->pageOffs)
								+ (ACE_UINT64)szPack;
			memcpy(5 * pTarget->m_lstPackedPage + (char*)pTarget->pageOffs, &tmpNewPos, 5);
	#ifndef NO_GSSCREEN
			if(pContext != 0){
				if((pTarget->m_lstPackedPage*100) / LastPage != percnt){
					percnt++;
					pContext->SetProgress(percnt);
				}
			}
	#endif
			if(pTarget->m_lstPackedPage == LastPage){
				tmp.PackArraySize=
					pTarget->m_PackArraySize = (LastPage + 1l) * 5;
				preTPage = (int)((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(5 * LastPage + (char*)pTarget->pageOffs))
							/ (ACE_UINT64)PageSize);
				if(m_lstPackedOffs){
					if(!pTarget->PutPage(preTPage, pTarget->pBff+(int)PageSize))
					return -1;

					tmp.page= preTPage;
					ACE_UINT64 tmp64= m_inOther + (ACE_UINT64)PageSize;
					int lstTom= IsNextTom(&tmp);
					if(lstTom){
						if((count= c_io_tell(pTarget->m_postFileHandles[lstTom]))
								< pTarget->m_max_paged_file_per_bytes)
							::chsize(pTarget->m_postFileHandles[lstTom], count);

						m_inOther += (ACE_UINT64)m_lstPackedOffs;

					}

				}
				// ѕозици€ дл€ сохранени€ массива pageOffs //
				count= (int)((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(5 * LastPage + (char*)pTarget->pageOffs))
								- m_inOther);

				if (	c_io_lseek(pTarget->file, count, ACE_OS_SEEK_SET) != count
						|| c_io_write( pTarget->file, pTarget->pageOffs,(int)pTarget->m_PackArraySize)
									!= (int)pTarget->m_PackArraySize
						|| c_io_lseek(pTarget->file, (int)PageSize, ACE_OS_SEEK_SET) != (int)PageSize
						|| (pTarget->rbuf= (char*)malloc((int)PageSize*2)) == 0
						|| c_io_read(pTarget->file, pTarget->rbuf+(int)PageSize, (int)PageSize)
																				!= (int)PageSize
						|| !pTarget->PutAttr( ID_PACKED_NEW, (void*)"", int(0) )
						|| ::chsize(pTarget->file, pTarget->m_PackArraySize + count))
					return -1;
				pTarget->LastPage= LastPage;
				pTarget->isPacked= 1;
				pTarget->m_mode |= 0x2000;
				*pTarget->m_postFilePoss= 2;
				return 0;
			}
			pTarget->m_lstPackedPage++;
		}
		return 0;
	}
	int PackOldFile(void *pObject, int count= 0){
		PagedFile *pTarget= (PagedFile *)pObject;
		if(pTarget->isPacked || pTarget->m_lstPackedPage > LastPage)
			return 0;
		if(count == 0)
			count= LastPage;
		if(count > LastPage || count < 1l)
			return -1;
		if(pTarget->m_lstPackedPage == 0l){
			pTarget->m_lstPackedPage= 1l;
			*pTarget->m_ppreLogicalPage= 0l;
			pTarget->m_ppreLogicalPage[1]= 0l;
			if(pTarget->pBff != 0 || (pTarget->pBff = (char *)malloc(PageSize*3)) == 0 ||
				pTarget->pageOffs != 0
					|| ((pTarget->pageOffs= (unsigned int gk_huge *)gk_malloc((int)sizeof(unsigned int) // GARANT_XXX but seems to be more safe
																			* (int)( LastPage + 1l ))) == 0
																			))
				return -5;
			*pTarget->pageOffs= (int)PageSize;
			m_inOther= (ACE_UINT64)0;
		}
		unsigned szPack;
		if(this == pTarget){
			if(!(m_mode & ACE_OS_O_WRONLY)){
				file = c_io_open(FileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY); 
				if (file == -1) {
					fprintf(stderr, "Cannot create file %s.\n", FileName);
					return -1;		// cannot be created
				}
				for(szPack=0; szPack < MAX_COUNT_FILE_HANDLES+1; szPack++)
					if(m_postFileHandles[szPack] != -1)
						c_io_close(m_postFileHandles[szPack]);

				memset(m_postFileHandles+1, -1, MAX_COUNT_FILE_HANDLES*sizeof(int));
				memset(m_postFilePoss+1, 0, MAX_COUNT_FILE_HANDLES*sizeof(int));
				*m_postFileHandles= file;
				*m_postFilePoss= 0;
				m_mode= ACE_OS_O_RDWR | ACE_OS_O_CREAT;
			}
		}else if(pTarget->m_lstPackedPage == 1l
					&& ((pTarget->m_max_paged_file_per_bytes= m_max_paged_file_per_bytes) == 0l
							|| memcpy(pTarget->SystemPageBuf,SystemPageBuf,PageSize) == 0))
			return -1;

		PF_PARAM tmp;
		int percnt= 0;

	#ifndef NO_GSSCREEN
		if(pContext != 0){
			sprintf(pTarget->pBff, getCopyingFormat(), pTarget->FileName);
			pContext->OtherShowMessage(pTarget->pBff);
			pContext->SetProgress(0);
		}
	#endif
		while(count--){
			if(!GetPage(pTarget->m_lstPackedPage, pTarget->pBff))
				return -1;
			if( pTarget->m_lstPackedPage*PageSize <= (4096*2)
				|| !(szPack= G_ZIP(pTarget->pBff, (int)PageSize,
								pTarget->pBff+(int)PageSize+m_lstPackedOffs,
																		(int)PageSize-1))){
				szPack= PageSize;
				memcpy(pTarget->pBff+(int)PageSize+m_lstPackedOffs,
						pTarget->pBff, szPack);
			}
			if((int)szPack >= PageSize){
				szPack= memcmp(	pTarget->pBff,
								pTarget->pBff+(int)PageSize+m_lstPackedOffs,
								PageSize);
				szPack= PageSize;
			}
			tmp.maxFile_per_bytes= pTarget->m_max_paged_file_per_bytes;
			tmp.pHeader= pTarget->SystemPageBuf;
			tmp.PackArraySize= 0l;
			int preTPage = pTarget->pageOffs[pTarget->m_lstPackedPage-1] / (int)PageSize;
			if(	*pTarget->m_ppreLogicalPage == 0l && (tmp.page= pTarget->m_lstPackedPage+1)
				&& IsLogicalTom(&tmp) && IsNextTom(&tmp)){
				// “екущий пакованный выравниваем до страницы /////////
				if(m_lstPackedOffs + (int)szPack > (int)PageSize){
					szPack= (unsigned)PageSize-m_lstPackedOffs;
					memcpy(	pTarget->pBff+(int)PageSize+m_lstPackedOffs,
							pTarget->pBff, (int)szPack);
					if(!pTarget->PutPage(preTPage, pTarget->pBff+(int)PageSize))
						return -1;
					memcpy(	pTarget->pBff+(int)PageSize, pTarget->pBff+(int)szPack,
															(int)PageSize-(int)szPack);
					szPack += (unsigned)PageSize;
					m_lstPackedOffs= 0;
					*pTarget->m_ppreLogicalPage=preTPage+2;
				}else{
					szPack= (int)PageSize - m_lstPackedOffs;
					*pTarget->m_ppreLogicalPage=preTPage+1;
				}
				pTarget->m_ppreLogicalPage[1]=
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1];
				if(pTarget != this){
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0]
						= pTarget->m_ppreLogicalPage[0];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1]
						= pTarget->m_ppreLogicalPage[1];
				}
			}else if(pTarget->m_lstPackedPage == pTarget->m_ppreLogicalPage[1]){
				// “екущий пакованный выравниваем до страницы /////////
				if(m_lstPackedOffs + (int)szPack > (int)PageSize){
					szPack= (unsigned)PageSize-m_lstPackedOffs;
					memcpy(	pTarget->pBff+(int)PageSize+m_lstPackedOffs,
							pTarget->pBff, (int)szPack);
					pTarget->m_ppreLogicalPage[1]=preTPage+1;
					if(!pTarget->PutPage(preTPage, pTarget->pBff+(int)PageSize))
						return -1;
					memcpy(	pTarget->pBff+(int)PageSize, pTarget->pBff+(int)szPack,
															(int)PageSize-(int)szPack);
					szPack += (unsigned)PageSize;
					m_lstPackedOffs= 0;
				}else{
					szPack= (int)PageSize - m_lstPackedOffs;
					pTarget->m_ppreLogicalPage[1]=preTPage;
				}
				if(pTarget != this){
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1]
						= pTarget->m_ppreLogicalPage[1];
				}
			}
			if((m_lstPackedOffs+=(int)szPack) >= (int)PageSize){
				if(szPack > (unsigned)PageSize){
					tmp.page= preTPage+1;
					m_lstPackedOffs= (int)PageSize;
				}else
					tmp.page= preTPage;
				if(*pTarget->m_ppreLogicalPage != 0l){
				  if(pTarget == this){
					int pTmp[2];
					pTmp[0]= ((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0];
					pTmp[1]= ((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0]
						= pTarget->m_ppreLogicalPage[0];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1]
						= pTarget->m_ppreLogicalPage[1];
					if(pTarget->m_ppreLogicalPage[1] == tmp.page)
						*pTarget->m_ppreLogicalPage= 0l;
					else{
						pTarget->m_ppreLogicalPage[0]= pTmp[0];
						pTarget->m_ppreLogicalPage[1]= pTmp[1];
					}
				  }else if(pTarget->m_ppreLogicalPage[1] == tmp.page)
						*pTarget->m_ppreLogicalPage= 0l;
				}else{
					tmp.PackArraySize=
						pTarget->m_PackArraySize = (LastPage + 1l) * sizeof(ACE_UINT32);
				}
				if(IsNextTom(&tmp))
					m_inOther += (ACE_UINT64)PageSize;
				if(szPack > (unsigned)PageSize){
					if(!pTarget->PutPage(preTPage+1, pTarget->pBff+(int)PageSize))
						return -1;
					if(*pTarget->m_ppreLogicalPage == 0l)
						m_inOther += (ACE_UINT64)PageSize;
				}else if(!pTarget->PutPage(preTPage, pTarget->pBff+(int)PageSize))
						return -1;
				if(*pTarget->m_ppreLogicalPage != 0l){
				  if(pTarget == this){
					int pTmp[2];
					pTmp[0]= ((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0];
					pTmp[1]= ((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[0]=
							pTarget->m_ppreLogicalPage[0];
					((int*)((PagedFileHeader*)pTarget->SystemPageBuf)->reserved)[1]=
							pTarget->m_ppreLogicalPage[1];
					pTarget->m_ppreLogicalPage[0]= pTmp[0];
					pTarget->m_ppreLogicalPage[1]= pTmp[1];
				  }
				}else
					pTarget->m_PackArraySize = 0l;

				if((m_lstPackedOffs -= (int)PageSize)){
					memcpy(	pTarget->pBff+(int)PageSize,
							pTarget->pBff+(int)PageSize*2, m_lstPackedOffs);
				}
			}
			pTarget->pageOffs[pTarget->m_lstPackedPage] = pTarget->pageOffs[pTarget->m_lstPackedPage-1]
								+ (int)szPack;
	#ifndef NO_GSSCREEN
			if(pContext != 0){
				if((pTarget->m_lstPackedPage*100) / LastPage != percnt){
					percnt++;
					pContext->SetProgress(percnt);
				}
			}
	#endif
			if(pTarget->m_lstPackedPage == LastPage){
				tmp.PackArraySize=
					pTarget->m_PackArraySize = (LastPage + 1l) * sizeof(ACE_UINT32);
				preTPage = pTarget->pageOffs[LastPage] / (int)PageSize;
				if(m_lstPackedOffs){
					if(!pTarget->PutPage(preTPage, pTarget->pBff+(int)PageSize))
					return -1;
					tmp.page= preTPage;
					ACE_UINT64 tmp64= m_inOther + (ACE_UINT64)PageSize;
					int lstTom= IsNextTom(&tmp), lstFileI= lstTom;
					if(lstTom){
						m_inOther += (ACE_UINT64)m_lstPackedOffs;
						while(lstTom > 1){
							tmp64 -= (ACE_UINT64)pTarget->m_max_paged_file_per_bytes;
							lstTom--;
						}
						count= (int)tmp64;
						::chsize(pTarget->m_postFileHandles[lstFileI], count);
					}
				}
				// ѕозици€ дл€ сохранени€ массива pageOffs //
				count= pTarget->pageOffs[LastPage] - (int)m_inOther;
				if(LastPage*4 <= (int)(PageSize & 0x7fff)){
					// дл€ столь маленьких файлов добавл€ем пустышку дл€ чтени€ пакованных блоков страницами //
					count += PageSize-(short)((count%PageSize)&0x7fff);
				}
				if (	c_io_lseek(pTarget->file, count, ACE_OS_SEEK_SET) != count
						|| c_io_write( pTarget->file, pTarget->pageOffs,(int)pTarget->m_PackArraySize)
									!= (int)pTarget->m_PackArraySize
						|| c_io_lseek(pTarget->file, (int)PageSize, ACE_OS_SEEK_SET) != (int)PageSize
						|| (pTarget->rbuf= (char*)malloc((int)PageSize*2)) == 0
						|| c_io_read(pTarget->file, pTarget->rbuf+(int)PageSize, (int)PageSize)
																				!= (int)PageSize
						|| !pTarget->PutAttr( ID_PACKED, (void*)"", int(0) )
						|| ::chsize(pTarget->file, pTarget->m_PackArraySize + count))
					return -1;
				pTarget->LastPage= LastPage;
				pTarget->isPacked= 1;
				pTarget->m_mode |= 0x2000;
				*pTarget->m_postFilePoss= 2;
				return 0;
			}
			pTarget->m_lstPackedPage++;
		}
		return 0;
	}

private:
	int		m_lstPackedOffs;
};
#endif
