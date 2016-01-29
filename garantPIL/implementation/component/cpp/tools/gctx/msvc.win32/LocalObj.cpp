#include "LocalObj.h"

char *ppTexts[4]= {	"текст первого документа, первого параграфа",
					"текст первого документа, второго параграфа",
					"текст второго документа, первого параграфа",
					"текст второго документа, второго параграфа" };

PL_DOC_STRUCT docs[]= { {1000001,2,10,NULL}, {1000002,2,12,NULL} };

long LocalBase::GetDocCount ()
{ 
	return sizeof(docs) / sizeof(*docs);
}

int LocalBase::FindDocAttr  ( long Id, int Tag, void * buf, int size )
{
	((DocInfo*)buf)->Status |= DS_DOC;
	return sizeof(DocInfo);
}

LocalDocIterator::LocalDocIterator( YBase *base ):DocIterator(base)
{
	ParentBase= base;
	Rewind();
}

void LocalDocIterator::Rewind()
{
	CurrPos= 0;
}

long LocalDocIterator::Id()
{
	return docs[CurrPos].Id;
}

void LocalDocIterator::next()
{
	CurrPos++;
}

#include "recode.h"

char *LocalDoc::GetParaTextBytes(long ID_Para, int *pRetStyle, int *pRetSize)
{ 
	*pRetStyle= pDocBody->Style;
	*pRetSize= strlen(pDocBody->pText[ID_Para]);
	if(!IsDOS_RUS())
		Recoding( cd_win, cd_dos, pDocBody->pText[ID_Para] );
	return pDocBody->pText[ID_Para];
}

long LocalDoc::GetDocTextSize()
{
	long RetSize= 0;
	for(int i= 0; i < pDocBody->ParaCount; i++){
		RetSize += strlen(pDocBody->pText[i]);
	}
	return RetSize;
}

LocalDoc::LocalDoc(Base* base, long, long, DocInfo *):pDocBody(0),pBase(base)
{
}

void *LocalDoc::SetDocInfo(DocInfo *, long Id)
{
	LocalDoc *pNew= (LocalDoc *)pBase->GetGarDoc(Id);
	SetDocBody(pNew->GetDocBody());
	delete pNew;
	return NULL;
}

int LocalDoc::Load(long)
{
	return 1;
}

IGarDoc *LocalBase::GetGarDoc(long Id, long aOwnerDoc, DocInfo *local_docInfo)
{
	LocalDoc *pNew= new LocalDoc(this, Id, aOwnerDoc, local_docInfo);
	assert(pNew);
	int iCurrTextLine= 0;
	for(int j= 0; j < sizeof(docs)/ sizeof (*docs); j++)
		if(docs[j].Id == Id){
			pNew->SetDocBody(docs+j);
			break;
		}
	return pNew;
}

LocalBase::LocalBase(const char * name, int mode) : StdBase( name, mode )
{
	int iCurrTextLine= 0;
	LocalDoc *pNew= new LocalDoc(this, 0, 0, NULL);
	for(int j= 0; j < sizeof(docs)/ sizeof (*docs); j++){
		docs[j].pText= new char*[docs[j].ParaCount];
		for(int i= 0; i < docs[j].ParaCount; i++){
			if(iCurrTextLine + 1 > sizeof(ppTexts) / sizeof(*ppTexts))
				abort();
			if(pNew->IsDOS_RUS())
				docs[j].pText[i]= ppTexts[iCurrTextLine++];
			else{
				docs[j].pText[i]= strdup(ppTexts[iCurrTextLine++]);
			}
		}
	}
	delete pNew;
}