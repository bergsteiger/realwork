
#ifndef	__NEW_DOCUMENT__
#define	__NEW_DOCUMENT__

#include "base.h"

#define	MAX_BLOCKS	64
#define	MAX_RUNS	64

class NewDocument {
private:
	int max_runs;
	int max_blocks;
public:
	Stream *runsStr, *blocksStr;
	long *m_pRunCount, *m_pBlockCount;

	Base* base;
	DocInfo* pInfo;
	long DocId, lstRunPage, lstRunCount, blockParaCount, ParaCount;
	int	textPageCount;
	int	runCount;
	int blockCount;
	int	subCount;
	int	usePacking;
	long prevPage;
	char* docBuf;
	int	docBufPos;
	char DocName [DOC_NAME_SIZE];
	PageRun* runs;			// pointer to an array of PageRuns
	BlockRec* blocks;			// pointer to an array of BlockDescs

	NewDocument (Base* b, long id, const char* title, revision& revDate, int packing);
	NewDocument (long id, Base* b, int packing) {
	}

	virtual ~NewDocument ();

	int	IsOk ();
	virtual int	AddPara (int style, int size, void* buf);
	int	AddName (char*);
	int	AddAttr (int tag, void * value, int size);

	virtual void ReAllocBlock();
	virtual void ReAllocRuns();

	virtual void WriteCurrentPageFromCurrentBlock(int page, void*buff){
		if(!base->textFile->PutPage(page,buff)){
			abort();
		}
	}
protected:
	int	FlushBlock (int sizeNext= 0);
	virtual char* InitPackBuff(int sizeNext = 0) { return 0; }
};

class NewDoc_GC_GU : public NewDocument {
public:
	NewDoc_GC_GU (long id, Base* b, int packing);
	int LastFlushBlock(int sizeNext){
		return FlushBlock(sizeNext);
	}
	char* PackBuf;
	virtual void ReAllocBlock();
	virtual void ReAllocRuns();
	virtual ~NewDoc_GC_GU();
protected:
	virtual char *InitPackBuff(int sizeNext= 0);
};


#endif
