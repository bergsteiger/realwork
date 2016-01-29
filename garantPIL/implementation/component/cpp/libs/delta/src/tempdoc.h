/*
 * $Id: tempdoc.h,v 2.19 2014/04/09 14:58:34 young Exp $
 */

#ifndef __TEMPDOC_H__
#define __TEMPDOC_H__

#include "base.h"

class TempDoc
{
public :
    TempDoc( Base* base= 0, long docId= 0, Document **ppDoc= 0, DocInfo* pDocINFO= 0);
    virtual ~TempDoc();
	long	DocId;
    int             TextFree ();
    const char * GetPara ( long );
	virtual void **getParaArray(){
		return m_pLocalParaArray;
	}
protected :
	int	m_iLocalTextAlloc;
	void	**m_pLocalParaArray;
	virtual  int getLocalTextAlloc(){
		return m_iLocalTextAlloc;
	}
	virtual  int setLocalTextAlloc(int newV){
		return (m_iLocalTextAlloc= newV);
	}
	char	EVDPara[ BLOCK_SIZE ];
	DocInfo         m_stat;
	void InitStatus(Document *pDoc){
		m_Status= pDoc->Stat.Status;
		m_Status_ex= pDoc->Stat.Status_ex;
	}
	void CopyAllText(Document *pDoc){
		if (pDoc->Stat.ParaCount) {
			char *pCurrPos = (char*) (getParaArray()[0]), *pPara;
			short siParaSize;
			long l=0;

			 do{
				(getParaArray()[l]) = pCurrPos;
				pPara = pDoc->GetPara ( l );
				assert ( pPara );
				siParaSize = ParaSize ( pPara ) + 3;
				memcpy ( (getParaArray()[l]), pPara, siParaSize );
				pCurrPos += siParaSize;
			}while((++l) < pDoc->Stat.ParaCount);
			setLocalTextAlloc(1);
		}
	}
public:
	long	 m_ParaCount;
	short	 m_Status;
	short	 m_Status_ex;
	char*	EVDParaText( const char* );
	short	EVDTextSize( const char* );
	short	EVDHeaderSize( const char* );
	char*	EVDHeader( const char* );
	inline const DocInfo&   GetStat () const {
		return m_stat;
	}
};

class DummyDoc
{
public:
	DummyDoc (Base* base, long docId);
	~DummyDoc ();

    const	char*	GetPara (long);
	char*	EVDParaText( const char* );
	short	EVDTextSize( const char* );
	short	EVDHeaderSize( const char* );
	char*	EVDHeader( const char* );

public:
	long	DocId;
	long	paracount;
	DocInfo	stat;

private:
	char**	paras;
	char	EVDPara [MAX_PARA_LEN];
	char	EVDHeaderPara [MAX_PARA_LEN];
};

#endif
