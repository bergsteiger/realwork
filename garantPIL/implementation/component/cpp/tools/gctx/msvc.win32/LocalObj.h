#ifdef MULTI_INDEX_STREAM_FILE
#include "stdbase.h"
#include "dociter.h"

typedef struct PL_DOC_TAG
{
	long Id, ParaCount;
	int Style;
	char **pText;
} PL_DOC_STRUCT, *LPPL_DOC_STRUCT;

class LocalBase : public StdBase
{
public:
	LocalBase(const char * name, int mode);
	IGarDoc*	GetGarDoc(long Id, long aOwnerDoc, DocInfo *local_docInfo);
	long		GetDocCount ();
	int			FindDocAttr  ( long Id, int Tag, void * buf, int size );
};

class	LocalDocIterator : public DocIterator
{
protected:
	YBase *ParentBase;
public:
	long CountDocs, CurrPos;
	LocalDocIterator( YBase *pBase= NULL );
	void Rewind();
	void next();
	long Id();
	int	End () const
	{
		return CurrPos >= ParentBase->GetDocCount();
	}
};

class LocalDoc : public IGarDoc
{
protected:
	LPPL_DOC_STRUCT pDocBody;
	Base *pBase;
public:
	LocalDoc(Base*, long, long, DocInfo *);
	char *GetParaTextBytes(long ID_Para, int *pRetStyle, int *pRetSize);
	long GetParaCount() { return pDocBody->ParaCount; }
	int IsDOS_RUS() {return 0;}
	long GetDocTextSize();
	void *SetDocInfo( DocInfo *, long Id= 0);
	int Load(long);

	LPPL_DOC_STRUCT GetDocBody() { return pDocBody;}
	void SetDocBody(LPPL_DOC_STRUCT pNew) { assert(pNew); pDocBody= pNew;}
};

#else
#error Please, set define 'MULTI_INDEX_STREAM_FILE' !!!
#endif
