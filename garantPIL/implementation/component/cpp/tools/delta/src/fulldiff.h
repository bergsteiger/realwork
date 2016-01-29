/*
 * $Id: fulldiff.h,v 2.78 2015/05/12 10:54:08 young Exp $
 */

// FullDiff.h   : header file of class Full
// Created              : 12.03.1997
// Autor                : Krylov Maxim

#ifndef FULLDIFF_H
#define FULLDIFF_H

#ifdef unix
	#include <unistd.h>
#endif

#include "diffhldr.h"
#include "hendlers.h"
#ifndef _MSC_VER
	#include "toys.h"
#endif
#include "StorableSplaySet.h"
#include "SplayMap.h"
class SearchBase;
class DummyDoc;

class Full
{
protected:
	struct DeltaParams
	{
		long oldpos, newpos, offset;
		DummyDoc *olddoc, *newdoc;
	};
	class TextAnalizer
	{
	protected:
		int m_thread;
		DummyDoc *m_old, *m_new;
		SplayMap<long,long> m_mapEqu;
		SplaySet<long> m_setNewUnknown;
		SplaySet<long> m_setOldUnknown;
		int m_isEqual;
	public:
		TextAnalizer ( DummyDoc *olddoc, DummyDoc *newdoc, int thread );		
		int isEqual () const;
		float getParaOrder ( long, long&);
		float getEquPara ( long, long&);
	protected:
		void detectEqu_Through();
		void detectEqu_Overlapping();
	};

public:
	Full ( SearchBase* oldB, SearchBase* newB, StorableSplaySet<unsigned short>& ids, SplaySet<long> * deldocs, FILE* dF1, int aRemoveCache, bool createiterators, FILE* attrFile = NULL, FILE* tmp1 = NULL, FILE* tmp2 = NULL, short aseg = 0, int thread = 0 );
	~Full ();
	int Work ();

	int IsDocFit ( long lDocId, int iVersion );
	void	WorkDoc(long, int docorder = -1);
	int PreWork();
	int PostWork();
	void	PostWork1();
	void	PostWork2 (SearchBase*, SearchBase*, long);

	int	FindDoc ( long lDocId, int iVersion );
	void	FindDelDoc ();
	void	CreateOldIterator();
	void	DeltaBlobs();
	void	AddDelDoc(long);
	void	FinishDelDoc();
	void	RemoveCache();

	u_int64_t	fpSizeDummyPos, fptCurrentPos, m_DocCntFilePos;
	StorableSplaySet<unsigned short> m_ids;

protected:
	BaseInfo aBaseInfo;

	std::map<long,std::string> old_map_id_str, new_map_id_str;
	std::map<std::string, long> old_map_str_id, new_map_str_id;
	DocIterator * m_pOldDocIter;
	DocIterator * m_pNewDocIter;
	DocInfo m_OldDocInfo;
	DocInfo m_NewDocInfo;

	long m_lDocId;	

	SplaySet<long> * m_deldocs;
	SplaySet<ObjKey> * m_delblobs;

	int	removeCache;
	char	HolderName [MAX_PATH], etaHolderName [MAX_PATH];

	FILE	*m_AttrFile;
	FILE	*pfTmp1;
	FILE	*pfTmp2;
	bool	bclosefiles;

public:
	FILE	*m_DFile1;
	SearchBase* m_pOldBase;
	SearchBase* m_pNewBase;

	int m_thread;

	int GetDocOrder ( long lDocId );
	inline char* GetHolderName () {return etaHolderName; }
	
protected:	
	bool DeltaChgDoc ();
	bool DeltaNewDoc ();
	void DeltaEquPara ( long &eqParaCount );
	int DiffCorrespondent (Base*, Base*, long);
	int DiffNewCorr (Base*, Base*, long);
	int DiffSearchCache (Base*, Base*, long);
	int DiffControl(Base*, Base*, long);
	int DiffSyns(char*, Base*, Base*, long);
	int DiffCVar (Base*, Base*, long);
	int DiffMorphoHashes (Base*, Base*, long);
	void DiffReleFLaws (Base*, Base*, long);
	void DiffTypingErrors (SearchBase*, SearchBase*, long);
	void DiffGoodWords (SearchBase*, SearchBase*, long);
	int DiffKindCorr (Base*, Base*, long);

	//char SaveContextWord (TempDoc& olddoc, TempDoc& newdoc);
	void DiffDocKindData();
	
	int CreateAttrDiff ( long lDocId, char* pLevelMask, int bNewDoc );
	int TagAttrDiff ( long lDocId, int iTag, int bNewDoc, char* s_tag = 0);	
	void DeltaChgStyle ( DeltaParams& param );
	void DeltaMovPara ( DeltaParams& param );
	void DeltaChgPara ( DeltaParams& param );
	void DeltaNewPara ( DeltaParams& param );
	void SaveParaHeader ( const char * pPara, char cSaveMask, DummyDoc* newdoc = NULL );
	int SaveRefIndDiff ( char* pIndName, long lDocId, int bNewDoc );
		
	short BlobOrder ( ObjKey * pkey );
	char  GetStyleOrder ( DeltaParams& param );
	char ChgStatus ();

	long GetNextDocId ( int iVersion );
	short FindBlob( Base * base, ObjKey* pkey );
	void FillCorrList ( long docId );

	char* CreateHolderName ( char * pNameBuff, int );
public:
	std::set<long> g_global_deldocs;
	std::set<long> g_cordocs;  // collection of docs whose Correspondents may be changed
private:
	std::set<long> g_newdocs;  // collection of new docs
	std::set<long> g_chgdocs;  // collection of changed docs
	std::set<long> g_deldocs;  // collection of deleted docs
	std::set<long> g_equdocs;  // collection of equals docs

	unsigned long g_lDocInDelta;
	unsigned long g_lChgDocSize;
	unsigned long g_lNewDocSize;
	unsigned long g_lChgBlbCount;
	unsigned long g_lNewBlbCount;
	unsigned long g_lEquBlbCount;
	unsigned long g_lDelBlbCount;
	unsigned long g_lChgBlbSize;
	unsigned long g_lNewBlbSize;

	bool	for_all_segs;
	short	seg;

	std::set<long> splash_topics;
	std::set<long> banner_topics;
};

char DigitToChar ( int );

#endif
