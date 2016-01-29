/*
 * $Id: reviser.h,v 2.14 2012/06/20 08:03:07 vlad Exp $
 */

#ifndef __REVISER_H__
#define __REVISER_H__

#include "dociter.h"
#include "StorableSplaySet.h"
#include "long.long.SplayMap.h"
#include "typecmp.h"

#define         SR_DOCEQU       0
#define         SR_DOCDIFF      1
#define         SR_DOCNEW       2

#define         RM_ONEBASESET   0
#define         RM_TWOBASESET   1

class Reviser
{
	class BaseInfoSet : public StorableSplaySet<BaseInfo>
	{
	public:
		BaseInfoSet ( Base* base ) {
			Stream * str = base->FindIndex ( "Aux" )->Open ( "Base" );
			if ( str ) {
				Get ( str );
				base->FindIndex ( "Aux" )->Close ( str );
			}
		}

		BaseInfoSet (const BaseInfoSet& a) : StorableSplaySet<BaseInfo>(a) {}

		void ReplaceRevision ( revision& rev ) {
			for ( Point p = first(); p; next(p) )
				contents (p).LastUpdate = rev;
		}

		void SaveInfo ( Base* base ) {
			Stream * str = base->FindIndex ( "Aux" )->Open ( "Base" );
			if ( str ) {
				Put ( str );
				str->Trunc();
				base->FindIndex ( "Aux" )->Close ( str );
			}
		}
	};

public:
	Reviser ( Base* oldBase, Base* newBase, int iBaseId );
	Reviser ( Base* newBase, revision * pDocSetRev, revision * pSegSetRev );         
	~Reviser ();

	int RunRevising ();
	int RunControlRevising ( revision, bool );
	int RunAnnoRevising ( revision );

protected:
	Base* m_pOldBase;
	Base* m_pNewBase;
	AttrIndex* m_pOlddocInd;
	AttrIndex* m_pNewdocInd;
	AttrIndex* m_pOlddocInd2;
	AttrIndex* m_pNewdocInd2;
	Index* m_pOldResp;
	Index* m_pNewResp;

	longlongSplayMap *controlStatus;

	int   m_iBaseId;
	int   m_iRunMode;	
	revision * m_pDocNewRevision;
	revision * m_pSegNewRevision;

	int   m_bRevsExtraTopic;

	DocIterator * m_pNewDocIter;
	DocIterator * m_pOldDocIter;
	DocInfo m_OldDocInfo;
	DocInfo m_NewDocInfo;

	long m_lDocId;

	int m_bDocAlradyDiff;

	int CompareDocs ( Document*, Document* );
	int TagAttrTest ( long lDocId, int iTag );

	void SetDocRevision ( long lDocId, revision aNewRev );
	void ReplaceDocRevision ( long lDocId );

	long GetNextDocId ( int iVersion );
	int IsDocFit ( long lDocId, int iVersion );
	int FindDoc ( long lDocId, int iVersion );
};

#endif
