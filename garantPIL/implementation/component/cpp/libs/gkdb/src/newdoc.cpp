
#include "pack.h"
#include "newdoc.h"
#include <cstdlib>

NewDocument::NewDocument (Base* b, long id, const char* title, revision& revDate, int packing) 
	: base (b)
	, DocId (id)
	, docBufPos (0)
	, textPageCount (0)
	, blockParaCount (0)
	, runCount (0)
	, blockCount (0)
	, subCount (0)
	, prevPage (-1l)
	, lstRunPage (-1l)
	, ParaCount (0)
	, max_runs (MAX_RUNS)
	, max_blocks (MAX_BLOCKS)
	, blocks (0)
	, runs (0)
	, docBuf (0)
{
	if (b->currentBlockSize > (0xffff-512)) {
		abort (); // not support Block size with BlockHeader
	}

	usePacking = packing;
	pInfo = (DocInfo*) calloc (1, sizeof (*pInfo));
	strncpy (pInfo->Title, title, sizeof (pInfo->Title));

	pInfo->Title [sizeof (pInfo->Title)-1] = '\0';
	pInfo->Revision = revDate;
}

NewDocument::~NewDocument () {
	if (docBufPos > 0)
		FlushBlock ();

	if (pInfo && !(usePacking & PM_NOT_STORE_INFO)) {
		pInfo->ParaCount = ParaCount;
		base->ReplaceAttr (DocId, IDD_INFO, pInfo,  sizeof (*pInfo));
		free (pInfo);
	}
	if (runCount)
		base->ReplaceAttr (DocId, IDD_RUNS, runs, runCount * sizeof (PageRun));
	if (blockCount)
		base->ReplaceAttr (DocId, IDD_BLOCKS, blocks, blockCount * sizeof (BlockRec));
	if (docBuf)
		free (docBuf);
	if (runs)
		free (runs);
	if (blocks)
		free (blocks);
}

int     NewDocument :: IsOk ()
{
	if(!docBuf)
		docBuf	= (char *) malloc ( base->currentBlockSize + 1024 );
	if(!runs)
		runs   = (PageRun *)malloc(sizeof(PageRun)*MAX_RUNS);
	if(!blocks)
		blocks = (BlockRec *)malloc(sizeof(BlockRec)*MAX_BLOCKS);

    return docBuf != 0 && runs != 0 && blocks != 0 ;
}

int     NewDocument :: AddPara ( int style, int size, void * buf )
{
	if(!docBuf)
		docBuf	= (char *) malloc ( base->currentBlockSize + 1024 );

	if ( docBufPos + size + 3 >= base->currentBlockSize - (int)sizeof ( BlockHeader ) )
		FlushBlock (size);

	docBuf [docBufPos] = style;
	*(short *) &docBuf [docBufPos + 1] = size;

	memmove ( docBuf + docBufPos + 3, buf, size );

	docBufPos += 3 + size;

	pInfo->Size += size;
	ParaCount++;
	blockParaCount++;

	return 1;
}

NewDoc_GC_GU :: NewDoc_GC_GU ( long id, Base * b, int packing )
	: NewDocument( id, b, packing )
{
	pInfo= 0;
	usePacking     = packing;
	base= b;
	lstRunPage= 0;
	DocId= id;
	prevPage= -1l;

	m_pBlockCount= m_pRunCount= 0;
	if( !(packing & PM_NOT_STORE_PARAINFO) )
		pInfo= (DocInfo *)calloc(1, sizeof ( *pInfo ));

	docBufPos		= 0;
	textPageCount	= 0;
	blockParaCount	= 0;
	runCount		= 0;
	blockCount		= 0;
	subCount		= 0;
	lstRunPage		= -1l;
	ParaCount= 0;

	runs= 0;
	runsStr= blocksStr= 0;
	blocks= 0;
	if(!base->new_docBuf)
		base->new_docBuf= (char *) malloc ( 2 * base->currentBlockSize + 1024 );
	docBuf	= base->new_docBuf;
	PackBuf = base->new_docBuf+base->currentBlockSize + 1024;
}

void Base::flushShortBlocks()
{
	if(countDocsBlockBuffer){
		// flush short blocks //
		Stream *pStr= 0;
		PageRun *pFreeRun, newRun;
		BlockRec *pFreeBlock;
		long sizeOld;
		unsigned short *pNext;
		int ii= 0; 
		while(ii < countDocsBlockBuffer){
			if(!ii){
				int gmax_runs= max_runs;
				int gmax_blocks= max_blocks;

				NewDoc_GC_GU *pNewDoc = new NewDoc_GC_GU (m_docs_block [ii].DocID, this, PM_ZIP);
				if (m_docs_block [ii].runCount){
					pFreeRun = (PageRun *)LoadExRuns (m_docs_block [ii].DocID, sizeOld, &pStr);
					CloseAtrrStr(pStr);
					max_runs= (2+(m_docs_block [ii].runCount/MAX_RUNS)) * MAX_RUNS;
					pNewDoc->runCount= sizeOld / sizeof(PageRun);
					pNewDoc->runs= (PageRun *)realloc(pFreeRun, max_runs * sizeof(PageRun));
				}else{
					pNewDoc->runCount       = 0;
					pNewDoc->runs   = (PageRun *)malloc(sizeof(PageRun)*MAX_RUNS);
				}
				if (m_docs_block [ii].blockCount){
					pFreeBlock = (BlockRec *)LoadExBlocks (m_docs_block [ii].DocID, sizeOld, &pStr );
					CloseAtrrStr(pStr);
					max_blocks= (2+(m_docs_block [ii].blockCount/MAX_BLOCKS)) * MAX_BLOCKS;
					pNewDoc->blockCount= sizeOld / sizeof(BlockRec);
					pNewDoc->blocks= (BlockRec *)realloc(pFreeBlock, max_blocks * sizeof(BlockRec));
				}else{
					pNewDoc->blockCount     = 0;
					pNewDoc->blocks = (BlockRec *)malloc(sizeof(BlockRec)*MAX_BLOCKS);
				}
				// restore attributes for flush
				pNewDoc->PackBuf = new_docBuf+currentBlockSize + 1024;
				pNewDoc->textPageCount= m_docs_block [ii].textPageCount;
				pNewDoc->ParaCount= m_docs_block [ii].ParaCount;
				pNewDoc->blockParaCount= m_docs_block [ii++].blockParaCount;
				pNewDoc->docBuf= pDocsBlockBuffer;
				pNewDoc->docBufPos= (pDocsBlockBufferOut - pDocsBlockBuffer);
				if(countDocsBlockBuffer < 2){
					// Standart flush in destructor//
					pNewDoc->docBuf += sizeof(unsigned short) ;
					pNewDoc->docBufPos -= sizeof(unsigned short);
					pNewDoc->LastFlushBlock(pNewDoc->docBufPos);
				}else{
					pNewDoc->LastFlushBlock(pNewDoc->docBufPos);
					pNewDoc->blocks[pNewDoc->blockCount-1].Pos2= -ii;
					// store common run //
					newRun.StartPage= pNewDoc->lstRunPage;
					newRun.Count= (short)(pNewDoc->lstRunCount & 0x7fff);
					pNext= (unsigned short*)(	pDocsBlockBuffer
												+ *(unsigned short*)pDocsBlockBuffer
												+ sizeof(unsigned short));
				}
				// not flush in destructor //
				pNewDoc->docBufPos= 0;
				// store temp bufs //
				pFreeRun= pNewDoc->runs;
				pFreeBlock= pNewDoc->blocks;

				delete pNewDoc;
				free(pFreeBlock);
				free(pFreeRun);

				max_runs= gmax_runs;
				max_blocks= gmax_blocks;
			}else{
				pFreeRun = (PageRun *)LoadExRuns (m_docs_block [ii].DocID, sizeOld, &pStr);
				if(pFreeRun)
					free(pFreeRun);
				if(!m_docs_block [ii].runCount)
					pStr->Seek(0);
				pStr->Write(&newRun, sizeof(PageRun));
				CloseAtrrStr(pStr);

				pFreeBlock = (BlockRec *)LoadExBlocks (m_docs_block [ii].DocID, sizeOld, &pStr);
				if(pFreeBlock)
					free(pFreeBlock);
				if(!m_docs_block [ii].blockCount)
					pStr->Seek(0);

				pNext= (unsigned short*)((char*)pNext + *pNext + sizeof(unsigned short));

				BlockRec newBlock;
				newBlock.Pos1      = m_docs_block [ii].textPageCount;
				newBlock.FirstPara = m_docs_block [ii].ParaCount - m_docs_block [ii].blockParaCount;
				ii++;
				newBlock.Pos2 = -ii;

				pStr->Write(&newBlock, sizeof(BlockRec));
				CloseAtrrStr(pStr);
			}
		}
		countDocsBlockBuffer= 0;
		pDocsBlockBufferOut= pDocsBlockBuffer;
	}
}

void NewDocument :: ReAllocBlock()
{
	if(!blocks){
		runs	= (PageRun *)malloc(sizeof(PageRun)*MAX_RUNS);
		blocks	= (BlockRec *)malloc(sizeof(BlockRec)*MAX_BLOCKS);
	}else if((blockCount+1) == max_blocks) { // grow the blocks array
		blocks= (BlockRec *)realloc(blocks, 
						  (max_blocks + MAX_BLOCKS)*sizeof(BlockRec));;
		max_blocks += MAX_BLOCKS;
	}
}

void NewDoc_GC_GU :: ReAllocBlock()
{
	if(!blocks){
		runs	= base->new_runs;
		blocks	= base->new_blocks;
	}else if((blockCount+1) == base->max_blocks) { // grow the blocks array
		base->new_blocks = (BlockRec *)realloc(base->new_blocks, 
						  (base->max_blocks + MAX_BLOCKS)*sizeof(BlockRec));
		blocks= base->new_blocks;
		base->max_blocks += MAX_BLOCKS;
	}
}

char *NewDoc_GC_GU::InitPackBuff(int sizeNext)
{
	if(base->clearAllTexts != 1){
		if(PackBuf) memset(PackBuf, 0, base->currentBlockSize);
	}else if(base->pDocsBlockBuffer && !sizeNext){
		if ( ((base->pDocsBlockBufferOut - base->pDocsBlockBuffer) + docBufPos + (int)sizeof(unsigned short))
				>= base->currentBlockSize - (int)sizeof ( BlockHeader ) )
			base->flushShortBlocks();

		if (base->m_docs_block == 0) {
			base->m_docs_block = new EndedBlockHeader [11111];
		}

		EndedBlockHeader* docs_block = base->m_docs_block;

		docs_block [base->countDocsBlockBuffer].DocID		   = DocId;
		docs_block [base->countDocsBlockBuffer].runCount	   = runCount;
		docs_block [base->countDocsBlockBuffer].blockCount	   = blockCount;
		docs_block [base->countDocsBlockBuffer].textPageCount  = textPageCount;
		docs_block [base->countDocsBlockBuffer].ParaCount      = ParaCount;
		docs_block [base->countDocsBlockBuffer].blockParaCount = blockParaCount;
		docs_block [base->countDocsBlockBuffer++].pos		   = docBufPos;

		*(unsigned short*)(base->pDocsBlockBufferOut)= docBufPos;
		base->pDocsBlockBufferOut += sizeof(unsigned short);
		memcpy(base->pDocsBlockBufferOut, docBuf, docBufPos);
		base->pDocsBlockBufferOut += docBufPos;
		*(unsigned short*)(base->pDocsBlockBufferOut)= 0;
		return (char*)-1;
	}
	return PackBuf;
}

void NewDocument::ReAllocRuns()
{
	if(runCount == max_runs) { // grow the runs array
		PageRun *newRuns = (PageRun *)realloc(runs, 
						 (max_runs + MAX_RUNS)*sizeof(PageRun));
		assert(newRuns != 0);
		runs = newRuns;
		max_runs += MAX_RUNS;
	}
}

void NewDoc_GC_GU::ReAllocRuns()
{
	if(runCount == base->max_runs) { // grow the runs array
		base->new_runs = (PageRun *)realloc(base->new_runs, 
						 (base->max_runs + MAX_RUNS)*sizeof(PageRun));
		assert(base->new_runs != 0);
		runs= base->new_runs;
		base->max_runs += MAX_RUNS;
	}
}

NewDoc_GC_GU::~NewDoc_GC_GU()
{
	if ( docBufPos > 0 )
		FlushBlock ();

	if(runCount)
		base->ReplaceAttr(DocId,IDD_RUNS,runs,runCount*sizeof(PageRun));
	if(blockCount)
		base->ReplaceAttr(DocId,IDD_BLOCKS,blocks,blockCount*sizeof(BlockRec));

	runCount= 0;
	blockCount= 0;

	docBuf= 0;
	runs= 0;
	blocks= 0;
}

int     NewDocument :: FlushBlock (int sizeNext)
{
	int pageSize= base -> textFile -> PageSize, notNewPage= 0, pageCount;
	char *PackBufc= InitPackBuff(sizeNext);
	if(!PackBufc){
		PackBufc= (char*)alloca(base->currentBlockSize);
		memset(PackBufc, 0, base->currentBlockSize);
	}else if(PackBufc == (char*)-1)
		return 1;

	int       packMethod   = usePacking;
	int packedLength = docBufPos;

	if ( packMethod & PM_ZIP ) {
		if(PackBufc == docBuf){
			pInfo->Size += docBufPos - blockParaCount * 3;
			PackBufc= docBuf+base->currentBlockSize + 1024;
			packedLength = ((int*)PackBufc)[-1];
			if(docBufPos == packedLength){
				docBuf= PackBufc;
				packMethod &= ~PM_ZIP;
			}
		}else{
			packedLength = (int)G_ZIP(docBuf, docBufPos, 
								PackBufc+sizeof(BlockHeader), docBufPos);
		}
		if( !packedLength ){
			memmove(PackBufc+sizeof( BlockHeader), docBuf, (packedLength= docBufPos) );
			packMethod &= ~PM_ZIP;
		}
	}else
		memmove(PackBufc+sizeof( BlockHeader), docBuf, docBufPos );

	BlockHeader * Hdr = (BlockHeader *) PackBufc;
	char *oldBuff=(char*)alloca(pageSize);
	if(base->lastBlockPage){
		base->textFile->GetPage(base->lastBlockPage,oldBuff);
		if(packedLength + (int)sizeof( BlockHeader) <= base->lastBlockPageFree){
			Hdr = (BlockHeader *)(oldBuff+(pageSize - base->lastBlockPageFree));
			memcpy(Hdr + 1,PackBufc+sizeof( BlockHeader), packedLength);
			Hdr -> InPrePage = -base->lastBlockPageFree;
			base->lastBlockPageFree -= packedLength + sizeof( BlockHeader);
			notNewPage++;
		}else{
			if(packedLength < base->lastBlockPageFree){
				memcpy(oldBuff+(pageSize - base->lastBlockPageFree), PackBufc+sizeof( BlockHeader)
						, packedLength);
				base->textFile->PutPage(base->lastBlockPage,oldBuff);
				base->lastBlockPageFree= pageSize-(sizeof(BlockHeader)%pageSize);
			}else{
				memcpy(oldBuff+(pageSize - base->lastBlockPageFree), PackBufc+sizeof( BlockHeader)
						, base->lastBlockPageFree);
				base->textFile->PutPage(base->lastBlockPage,oldBuff);
				packedLength -= base->lastBlockPageFree;
				Hdr = (BlockHeader *) (PackBufc+base->lastBlockPageFree);
				Hdr -> InPrePage = base->lastBlockPageFree;
				base->lastBlockPageFree= pageSize-((packedLength+sizeof(BlockHeader))%pageSize);
				if(base->lastBlockPageFree == pageSize)
					base->lastBlockPage= -1;
			}
		}
	}else{
		base->lastBlockPageFree= pageSize-((packedLength+sizeof(BlockHeader))%pageSize);
		Hdr -> InPrePage = 0;
	}

	pageCount=(packedLength+sizeof(BlockHeader)+pageSize-1)/pageSize;

	assert ( docBufPos < base->currentBlockSize );

	Hdr -> Method  = (packMethod & 0x01);    //PM_STORED or PM_ZIP;
	Hdr -> SrcSize = docBufPos;
	Hdr -> ArcSize = packedLength;

	ReAllocBlock();
	// update blocks
	blocks [blockCount].Pos1      = textPageCount;
	blocks [blockCount].Pos2      = textPageCount + pageCount - 1;
	blocks [blockCount].FirstPara = ParaCount - blockParaCount;
	blockCount++;

	// update runs
	long    newPage;
	for ( lstRunCount = 0; lstRunCount < pageCount; lstRunCount++ ) {
		if(notNewPage){ notNewPage= 0;
			newPage= base->lastBlockPage;
			Hdr = (BlockHeader *)oldBuff;
		}else
			newPage = base->NewPageOnText();

		if(!lstRunPage)
			lstRunPage= newPage;

		if ( newPage == prevPage + 1 ){  // continueation of current run
			runs [runCount - 1].Count++;
		}else{                            // start of next page run
			runs [runCount].StartPage = newPage;
			runs [runCount].Count     = 1;
			runCount++;
		}
		ReAllocRuns();
		WriteCurrentPageFromCurrentBlock(prevPage=newPage,((char*)Hdr)+ lstRunCount*pageSize);
		if(base->clearAllTexts == 1 && base->lastBlockPage != -1){
			base->lastBlockPage= prevPage;
		}
	}
	if(base->lastBlockPage == -1){
		base->lastBlockPage= 0;
	}
	blockParaCount = 0;
	docBufPos      = 0;
	textPageCount += pageCount;

	return 1;
}

int NewDocument::AddAttr (int tag, void* value, int size) {
	base->PutAttr (DocId, tag, value, size);

	Index* ind = 0;

	switch (tag) {
	case IDD_DATE:
		ind = base->FindIndex ("Date");
		break;
	case IDD_ID:
		ind = base->FindIndex ("Number");
		break;
	case IDD_SOURCE:
		ind = base->FindIndex ("Adopted");
		break;
	case IDD_DIV:
		ind = base->FindIndex ("Division");
		break;
	case IDD_KEY:
		break;
	case IDD_TYPE:
		ind = base->FindIndex ("Type");
		break;

#ifdef VERSION62
	case IDD_ANNODATE:
		ind = base->FindIndex ("AnnoDate");
		break;
#endif

	default:
		break;
	}

	if (ind != 0)	{
		Stream* str = ind->Open (value, 1);

		if (str != 0) {
			DocCollection docs;
			docs.Get (str);
			docs.Add (DocId);
			str -> Seek (0);
			docs.Put (str);
			ind->Close (str);
		}
	}

	return 1;
}
