#include "shared/Core/fix/mpcxc.h"

////////////////////////////// DEBUG DEFINES //////////////////////////////////

#define _EXIT(a) assert(0)

#define DEBUG_STRATRR
#define DEBUG_INDEXOP

//#define SKIP_TO_DOCID 1582120

/////////////////////////////// CONST DEFINES /////////////////////////////////

#define  MALLOC_ADDS 240

///////////////////////////////////////////////////////////////////////////////

#include "gu_ver.h"
#include "osdep.h"
#include <cstdio>
#include <ctime>
#include <algorithm> // GARANT_STL for std::max // tmp cvs link check
#include "unfull.h"
#include "SearchB.h"
#include "newdoc.h"
#include "garutils.h"
#include "refcol.h"
#include "stringz.h"
#include "deltadef.h"
#include "dltcomon.h"
#include "tempdoc.h"
#include "ctxwords.h"
#include "wordcol.h"
#include "hindex.h"
#include "btiter.h"
#include "clcache.h"
#include "adds.h"
#include "StorableSplaySet.h"
#include "SplayMap.h"
#include "Logger.h"
#include "timer.h"
#include "garutils.h"
#include "basemask.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "long.long.SplayMap.h"
#include "pack.h"
#include "Lzma86.h"

#include "shared\GCL\alg\set_operations.h"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

bool	b_use_lzma = true;

#ifdef max
#undef max
#endif

#ifdef min
#undef min
#endif

///////////////////////////////// externals ///////////////////////////////////

extern	Logger	logger;

extern	void	DocsProcCreate ( long lDocInDelta, bool b_english_face );
extern	void	AddDelta ( long lDeltaCount, bool b_english_face );
extern	void	AddSkip ( long lSkipCount );

//extern	char	*P_BUF;

extern	char	err_BaseDate[];
extern	char	err_UpDateFrom[];
extern	char	err_UpDateTo[];
extern	int		err_Segment;
extern	bool	b_show_extended_log;
extern	bool	b_flush_extended_log;
extern	bool	b_ovp;

extern	ProgressScreen* screen;

#ifdef	WINENCODE
extern	bool	gctxWinEncode;
#endif

//////////////////////////////// globals //////////////////////////////////////

char	pBUF [ BUF_SIZE ];

static logtype_t lt_updateInfo ( LTL_INFO - 1, "UPDATE INFO" );
static logtype_t lt_updateWarning ( LTL_WARNING - 1, "UPDATE WARNING" );
static char    g_pCtxBuf [MAX_PARA_LEN+1];

extern	char*	delta_buffer;
extern	char*	delta_buffer_ptr;

int		m_iGTextAlloc = 0x8000000;
void	**m_pGParaArray = 0;

///////////////////////////////////////////////////////////////////////////////
//				UnFull					     //
///////////////////////////////////////////////////////////////////////////////

UnFull::UnFull( Base* oldB, UpdatedSearchBase* newB, FILE* dF1, char* pSkipDir, bool english_face, bool b_load ) : m_mapBaseInfo ( oldB )
{
	b_cvarupdated = false;
	b_english_face = english_face;
#ifdef QUICK_NEW_DOC
	pTmpDoc= 0;
	#if defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
		ReplaceInfo= 0;
	#endif
#endif
	m_pOldBase = oldB;
	m_pNewBase = newB;
	m_DFile1   = dF1;

	m_pOldInfo  = 0;
	m_pNewInfo  = 0;

	m_pAttrMask = new char [ MAX_LEVEL ];
	assert ( m_pAttrMask );

	m_pDeltaSegments = 0;
	m_siDeltaSegmentsCount = 0;
	//m_pBaseInfoDelta = 0;

	//
	// READ LIST OF PRESENT SEGMENTS
	//
	Index	*pAuxInd = m_pOldBase -> FindIndex ( "Aux" );
	Stream	*pStr = pAuxInd -> Open ( "Here" );
	assert ( pStr );
	m_presentSegments.Get ( pStr );
	m_presentSegments._add (0);
	pAuxInd -> Close ( pStr );	

	m_iDeSync = 0;
#ifdef MULTI_INDEX_STREAM_FILE
	m_AllPatchedAndNewDocsTextSize= 0;
#endif
	docInd= (AttrIndex*)newB->FindIndex("Attrs");
	docInd2= (AttrIndex*)newB->FindIndex("Attribs");

	if (b_load) {
		Stream* str = m_pOldBase->FindIndex ("Aux")->Open (AUX_CLASS6_KEYS);
		if (str) {
			long length = str->Length (), i = 0;
			char *data = (char*) malloc (length), *ptr = data;
			str->Read (data, length);
			m_pOldBase->FindIndex ("Aux")->Close (str);
			while (i < length) {
				long len = strlen (ptr)+1;
				char *semipos = strchr (ptr, ':');
				*semipos++ = '\0';
				long id = atol (ptr);
				if (*semipos) {
					old_map_id_str.insert (std::map<long,std::string>::value_type (id, semipos));
					map_key_id.insert (std::map<std::string,long>::value_type (semipos, id));
				}
				i += len;
				ptr += len;
			}
			gk_free (data);
		}
	}

	m_pTempDocGlobalBuff = 0;
	pNewDocN = 0;

	respCache = new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );
}

///////////////////////////////////////////////////////////////////////////////

const short tags[] = {IDD_DATE, IDD_VCHANGED, IDD_INFO, IDD_KEY, IDD_SUBS, IDD_TYPE, IDD_TAG, IDD_KIND, IDD_SOURCE, IDD_TERRITORY, IDD_BASES, IDD_ID, IDD_ADDCODE, IDD_RCODE, IDD_DIV, IDD_DOCKIND, IDD_SORTDATE, IDD_ANNODATE,
	IDD_ANNOUSER, IDD_ANNOORGANIZATION, IDD_ANNOTAX, IDD_ANNOINTEREST, IDD_ANNOKIND, IDD_SERVICEINFO, IDD_CLASS6, IDD_RDATE, IDD_VLCONTROL, IDD_VANONCED, IDD_CATEGORY, IDD_PUBLISHEDIN, IDD_VABOLISHED, IDD_VINCLUDED, IDD_CALIN, IDD_CALAB, IDD_CALCH, 
	IDD_INPHARMFIRM, IDD_INPHARMCOUNTRY, IDD_REGDATE, IDD_ANNULDATE, IDD_ACTIVEEX, IDD_TRADENAME, IDD_INTNAME, IDD_PHARMGROUP, IDD_PHARMEFFECT, IDD_CHAPTER, IDD_ATC, IDD_REGSTATUS, IDD_LEKFORM, IDD_MKB, IDD_LIFE, IDD_NOTLIFE, IDD_RECIPE, IDD_UNRECIPE, IDD_ALLOWED, IDD_NOTALLOWED };

void	UnFull::delete_deleted_docs ()
{
	fill_setdeltasegs ();
	screen->SetMessage (b_english_face ? "Delete docs..." : "Удаление документов...");
	screen->SetProgress (0);
	int old_perc = 0, total_dels = m_mapDelDocs.length (), count = 0;

	struct	tm	*pNewTime;
	time_t		long_time;
	time (&long_time); pNewTime = localtime (&long_time);
	logger.printf (lt_updateInfo, "delete docs started at %s", asctime (pNewTime));
	Point p;

	std::set<long> docs_to_delete;

	for ( p = m_mapDelDocs.first(); p; m_mapDelDocs.next(p), count++) {
		/*
		int new_perc = (count * 100) / total_dels;
		if (new_perc != old_perc)
			screen->SetProgress (old_perc = new_perc);
		*/

		m_lDocId = m_mapDelDocs.key(p);
				
		long size;
		if ( m_pNewInfo )
			free ( m_pNewInfo );

		m_pNewInfo = (DocInfo *) docInd->Load ( m_lDocId, IDD_INFO, size );

		if ( !m_pNewInfo || size != sizeof ( DocInfo ) ) {
			logger.printf ( lt_updateWarning, "Doc (DocId:%ld) already deleted\n", m_lDocId );
			continue;
		}
		
		StorableSplaySet<short> docSegs;
		StorableSplaySet<short> docSegsOld;
				
		docInd->Load ( m_lDocId, IDD_BASES, docSegs );
		docSegsOld = docSegs;

		// Minus list of delta-segments from list of doc-segments
		SplaySet<short> minus = m_mapDelDocs.contents(p);
		if (minus.length () == 1 && minus.contents (minus.first ()) == 0)
			minus = setDeltaSegs;
		docSegs -= minus;
		
		if ( !(docSegs & m_presentSegments) ) {
			// DelDoc dos't exist in Base now - delete them
			docSegsOld._add (0);
			CollectBaseInfo ( m_pNewInfo, 0, docSegsOld );

			//logger.printf ( lt_updateInfo, "Remove Doc (DocId:%ld)\n", m_lDocId );
			//if (b_flush_extended_log) logger.flush (lt_always);

			s_DelDocs.insert (m_lDocId);
			if (s_UpdDocs.find (m_lDocId) != s_UpdDocs.end ())
				s_UpdDocs.erase (s_UpdDocs.find (m_lDocId));
			//FullDelDoc ();
			docs_to_delete.insert (m_lDocId);
		} else	{
			// DelDoc owned by another existing Segment - clean IDD_BASES
			logger.printf ( lt_updateWarning, "Doc (%ld) locked for another segment\n", m_lDocId );
			docSegsOld -=docSegs;
			CollectBaseInfo ( m_pNewInfo, 0, docSegsOld );

			docInd->Replace ( m_lDocId, IDD_BASES, docSegs );

			for ( Point p2 = m_mapDelDocs.contents(p).first(); p2; m_mapDelDocs.contents(p).next(p2) )
				DelSegmentDoc ( SelectIndex ( IDD_BASES ), &(m_mapDelDocs.contents(p).contents(p2)), m_lDocId );
		}		
	}

	extern short	docTags [93];

	double progress_step = 100.0 / ((sizeof (docTags) + sizeof (tags)) / sizeof (short) + 2), current_progress = 0;
	current_progress += progress_step; screen->SetProgress ((int) current_progress);

	short tag;
	for (tag = 0; tag < sizeof (tags) / sizeof (short); tag++) {
		short atag = tags [tag];
		m_dsm = m_dsm_inpharm = dsmChgToNodoc;
		logger.printf (lt_updateInfo, "remove docs from indexes, tag %ld\n", (long) atag);
		if (b_flush_extended_log) logger.flush (lt_always);
		for (std::set<long>::const_iterator doc_it = docs_to_delete.begin (); doc_it != docs_to_delete.end (); doc_it++) {
			m_lDocId = *doc_it;
			DelIndByAttr (atag, m_lDocId);
		}
		current_progress += progress_step; screen->SetProgress ((int) current_progress);
	}
	for (tag = 0; tag < sizeof (docTags) / sizeof (short); tag++) {
		AttrKey key = {0, docTags [tag]};
		logger.printf (lt_updateInfo, "remove tag %ld\n", (long) docTags [tag]);
		if (b_flush_extended_log) logger.flush (lt_always);
		for (std::set<long>::const_iterator doc_it = docs_to_delete.begin (); doc_it != docs_to_delete.end (); doc_it++) {
			key.DocId = *doc_it; 
			docInd->DelKey (&key);
		}
		current_progress += progress_step; screen->SetProgress ((int) current_progress);
	}

	std::set<long>::const_iterator doc_it;

	logger.printf (lt_updateInfo, "remove tag IDD_PARAIDS\n"); if (b_flush_extended_log) logger.flush (lt_always);
	for (doc_it = docs_to_delete.begin (); doc_it != docs_to_delete.end (); doc_it++) {
		AttrKey key = {*doc_it, IDD2_PARAIDS};
		docInd2->DelKey (&key);
	}
	current_progress += progress_step; screen->SetProgress ((int) current_progress);

	Index *resps = m_pOldBase->FindIndex ("Respondent");
	logger.printf (lt_updateInfo, "remove keys in index Respondent\n"); if (b_flush_extended_log) logger.flush (lt_always);
	for (doc_it = docs_to_delete.begin (); doc_it != docs_to_delete.end (); doc_it++) {
		m_lDocId = *doc_it;
		resps->DelKey (&m_lDocId);
	}
	current_progress += progress_step; screen->SetProgress ((int) current_progress);

	time (&long_time); pNewTime = localtime (&long_time);
	logger.printf (lt_updateInfo, "delete docs ended at %s", asctime (pNewTime));
	logger.flush (lt_always);
}

void	UnFull::read_corrs (long a_pos_of_correspondents)
{
	pos_of_correspondents = a_pos_of_correspondents;
	fseek (m_DFile1, pos_of_correspondents, ACE_OS_SEEK_SET);
	logger.printf ( lt_updateInfo, "\nRead correspondents for all documents\n", m_lDocId );

	long diffCount;
	DeltaRead ( &diffCount, sizeof (diffCount), 1 , m_DFile1 );
	logger.printf ( lt_debug, "Correspondent diff count = %ld\n", diffCount );

	long l;
	for ( l=0; l < diffCount; l++ ) {
		long docId;
		DeltaRead ( &docId, sizeof (docId), 1 , m_DFile1 );

		long count;
		Ref ref;

		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
			m_mapCorrs[docId].delCor.add(ref);
		}

		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
			m_mapCorrs[docId].addCor.add(ref);
		}				
	}
	
	//read NewCorr diff
	DeltaRead ( &diffCount, sizeof (diffCount), 1 , m_DFile1 );
	for ( l=0; l < diffCount; l++ ) {
		long docId;
		DeltaRead ( &docId, sizeof (docId), 1 , m_DFile1 );

		long count;
		CorrRef ref;

		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
			m_mapCorrs[docId].delNCor.add(ref);
		}

		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
			m_mapCorrs[docId].addNCor.add(ref);
		}				

		//проскиповали and секцию, которая для deltamergerа
		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
		}
	}
}

void	UnFull::restore_corrs ()
{
	struct	tm	*pNewTime;
	time_t		long_time;
	time (&long_time); pNewTime = localtime (&long_time);
	logger.printf (lt_updateInfo, "restore corrs started at %s", asctime (pNewTime));

	// RESTORE CORRESPONDENT FOR ALL DOCUMENTS
	//
	Index *ind = m_pNewBase->FindIndex ("Correspondent"), *resp = m_pNewBase->FindIndex ("Respondent");

	logger.printf (lt_updateInfo, "Restore index Correspondent");
	screen->SetMessage (b_english_face ? "Updating correspondents list..." : "Обновление индекса корреспондентов...");
	screen->SetProgress (0);

	long totalCorrs = m_mapCorrs.length(), acount = 0, oldPerc = 0;
	Point p;
	for (p = m_mapCorrs.first(); p; m_mapCorrs.next(p), acount++) {
		long docId = m_mapCorrs.key(p);

		{
			SplaySet<Ref>	refs;

			refs = m_mapCorrs.contents(p).delCor;
			refs &= m_mapCorrs.contents(p).addCor;
			m_mapCorrs.contents(p).delCor -= refs;
			m_mapCorrs.contents(p).addCor -= refs;
		}

		SplaySet<Ref> tmpSet = m_mapCorrs.contents(p).delCor;
		for (Point p2 = tmpSet.first(); p2; tmpSet.next(p2)) {
			bool delOK = false;

			SplaySet<Ref> *tmp = &m_mapCorrs.contents(p).addCor;
			for (Point p3 = tmp->first(); !delOK && p3; tmp->next(p3))
				delOK = tmp->contents(p3).DocId == tmpSet.contents(p2).DocId;
			
			if (!delOK) {
				long resp_id = tmpSet.contents(p2).DocId;
				StorableSplaySet<Ref>* nc = (StorableSplaySet<Ref>*)(*respCache)[resp_id];
				if (!nc) {
					nc = new StorableSplaySet<Ref>;
					Stream	*resp_str = resp->Open (&resp_id);
					if (resp_str) {
						nc->Get (resp_str);
						resp->Close (resp_str);
					}
					(*respCache)[resp_id] = (caddr_t) nc;
				}
				if (nc->length()) for (Point l = nc->first(); l; nc->next(l)) {
					Ref	chkRef = nc->contents(l);
					if (chkRef.DocId == docId) {
						m_mapCorrs.contents(p).delCor.del(tmpSet.contents(p2));
						break;
					}
				}
			}
		}
				
		StorableSplaySet<Ref> refs;
		Stream	*str = ind->Open (&docId, 1);
		if (str)
			refs.Get (str);
		else
			logger.printf ( lt_error, "Can't create stream in Correspondent by key %ld\n", docId );

		refs -= m_mapCorrs.contents(p).delCor;
		refs |= m_mapCorrs.contents(p).addCor;

		m_mapCorrs.contents(p).delCor.clear ();
		m_mapCorrs.contents(p).addCor.clear ();

		if (str) {
			if (!refs.length ()) {
				ind->Close (str);
				if (ind->Delete (&docId) != GKDB::BT_OK)
					logger.printf ( lt_error, "Can't delete key %ld from Correspondent\n", docId );
			} else {
				str->Seek (0);
				refs.Put (str);
				str->Trunc ();
				ind->Close (str);
			}
		}

		int newPerc = (acount * 100) / totalCorrs;
		if (newPerc != oldPerc) {
			oldPerc = newPerc;
			screen->SetProgress (newPerc);
		}
	}
	logger.printf ( lt_updateInfo, ", done\n", m_lDocId );
	logger.flush (lt_always);

	//Restore NewCorr index
	logger.printf (lt_updateInfo, "Restore index NewCorr");
	screen->SetMessage (b_english_face ? "Updating correspondents list..." : "Обновление индекса корреспондентов...");
	screen->SetProgress (0);

	ind = m_pNewBase->FindIndex ("NewCorr"), acount = 0, oldPerc = 0;
	for (p = m_mapCorrs.first(); p; m_mapCorrs.next(p), acount++) {
		long docId = m_mapCorrs.key(p);
		CorDelta *cordelta = &m_mapCorrs.contents(p);
		{
			SplaySet<CorrRef>	refs;
			refs  = cordelta->delNCor;
			refs &= cordelta->addNCor;
			cordelta->delNCor -= refs;
			cordelta->addNCor -= refs;
		}

		SplaySet<CorrRef> tmpSet = cordelta->addNCor;
		std::deque<long> addNCor_docs;
		for (Point l2 = tmpSet.first(); l2; tmpSet.next(l2)) {
			long id = tmpSet.contents(l2).DocId;
			addNCor_docs.push_back (id);
		}

		longlongSplayMap count_in_tmpSet(0);
		std::deque<long> delNCor_docs;
		tmpSet = cordelta->delNCor;
		for (Point l3 = tmpSet.first(); l3; tmpSet.next (l3)) {
			long id = tmpSet.contents(l3).DocId;
			count_in_tmpSet [id]++;
			delNCor_docs.push_back (id);
		}

		std::sort (addNCor_docs.begin (), addNCor_docs.end ());
		addNCor_docs.erase (std::unique (addNCor_docs.begin (), addNCor_docs.end ()), addNCor_docs.end ());

		std::sort (delNCor_docs.begin (), delNCor_docs.end ());
		delNCor_docs.erase (std::unique (delNCor_docs.begin (), delNCor_docs.end ()), delNCor_docs.end ());

		std::deque<long> resps;
		std::set_difference (delNCor_docs.begin (), delNCor_docs.end (), addNCor_docs.begin (), addNCor_docs.end (), std::back_inserter (resps));

		{
		std::deque<long> empty1, empty2;
		addNCor_docs.swap (empty1);;
		delNCor_docs.swap (empty2);;
		}

		longlongSplayMap count_in_refs(0);
		Stream *str = ind->Open (&docId, 1);
		bool b_largestream = str->Length () > 100 * 1024 * 1024;
		std::vector<CorrRef> refs_vector;
		std::deque<CorrRef> refs_deque;
		if (str) {
			long str_size = str->Length () / sizeof (CorrRef);
			if (!b_largestream)
				refs_vector.reserve (str_size + cordelta->addNCor.length ());
			for (; str_size; str_size--) {
				CorrRef cr;
				str->Read (&cr, sizeof (cr));
				count_in_refs [cr.DocId]++;
				if (b_largestream)
					refs_deque.push_back (cr);
				else
					refs_vector.push_back (cr);
			}
			str->Seek (0);
		} else {
			logger.printf (lt_error, "Can't create stream in NewCorr by key %ld\n", docId);
		}

		for (std::deque<long>::const_iterator resp_it = resps.begin (); resp_it != resps.end (); resp_it++) {
			long resp_id = *resp_it;
			StorableSplaySet<Ref>* nc = (StorableSplaySet<Ref>*)(*respCache)[resp_id];
			if (!nc) {
				nc = new StorableSplaySet<Ref>;
				Stream	*resp_str = resp->Open (&resp_id);
				if (resp_str) {
					nc->Get (resp_str);
					resp->Close (resp_str);
				}
				(*respCache)[resp_id] = (caddr_t) nc;
			}
		}

		for (Point p2 = tmpSet.first(); p2; tmpSet.next(p2) ) {
			CorrRef at_p2 = tmpSet.contents (p2);
			long at_p2_id = at_p2.DocId;
			if (std::binary_search (resps.begin (), resps.end (), at_p2_id)) {
				StorableSplaySet<Ref>* nc = (StorableSplaySet<Ref>*)(*respCache)[at_p2_id];
				if (nc && nc->length ()) {
					for (Point l = nc->first (); l; nc->next (l)) {
						Ref	chkRef = nc->contents (l);
						if (chkRef.DocId == docId) {
							if (count_in_refs [at_p2_id] == count_in_tmpSet [at_p2_id])
								cordelta->delNCor.del (at_p2);
							break;
						}
					}
				}
			}
		}

		std::vector<CorrRef> del_vector;
		del_vector.reserve (cordelta->delNCor.length ());
		for (Point delp = cordelta->delNCor.first (); delp; cordelta->delNCor.next (delp))
			del_vector.push_back (cordelta->delNCor.contents (delp));
		cordelta->delNCor.clear ();

		std::vector<CorrRef> add_vector;
		add_vector.reserve (cordelta->addNCor.length ());
		for (Point addp = cordelta->addNCor.first (); addp; cordelta->addNCor.next (addp))
			add_vector.push_back (cordelta->addNCor.contents (addp));
		cordelta->addNCor.clear ();

		if (b_largestream) {
			if (str) {
				std::vector<CorrRef>::const_iterator add_it = add_vector.begin (), del_it = del_vector.begin ();
				for (std::deque<CorrRef>::const_iterator str_it = refs_deque.begin (); str_it != refs_deque.end (); str_it++) {
					CorrRef cr = *str_it;
					bool b_add = true;
					if (del_it != del_vector.end ()) {
						CorrRef del_ref = *del_it;
						if (!memcmp (&del_ref, &cr, sizeof (CorrRef))) {
							del_it++;
							b_add = false;
						}
					}
					while (add_it != add_vector.end ()) {
						if (*add_it < cr) {
							CorrRef add_ref = *add_it;
							str->Write (&add_ref, sizeof (CorrRef));
							add_it++;
						} else {
							CorrRef add_ref = *add_it;
							if (!memcmp (&add_ref, &cr, sizeof (CorrRef)))
								add_it++;
							break;
						}
					}
					if (b_add)
						str->Write (&cr, sizeof (CorrRef));
				}
				while (add_it != add_vector.end ()) {
					CorrRef add_ref = *add_it;
					str->Write (&add_ref, sizeof (CorrRef));
					add_it++;
				}

				if (str->Tell ()) {
					str->Trunc ();
					ind->Close (str);
				} else {
					ind->Close (str);
					if (ind->Delete (&docId) != GKDB::BT_OK)
						logger.printf (lt_error, "Can't delete key %ld from NewCorr\n", docId);
				}
			}
		} else {
			GCL::set_difference (refs_vector, del_vector);
			GCL::set_union (refs_vector, add_vector);

			if (refs_vector.size ()) {
				str->Write (&refs_vector[0], sizeof (CorrRef) * refs_vector.size ());
				str->Trunc ();
				ind->Close (str);
			} else {
				ind->Close (str);
				if (ind->Delete (&docId) != GKDB::BT_OK)
					logger.printf (lt_error, "Can't delete key %ld from NewCorr\n", docId);
			}
		}

		int newPerc = (acount * 100) / totalCorrs;
		if (newPerc != oldPerc) {
			oldPerc = newPerc;
			screen->SetProgress (newPerc);
		}
	}

	for (p = respCache->first(); p; respCache->next(p)) {
		StorableSplaySet<Ref>* at = (StorableSplaySet<Ref>*) respCache->contents(p);
		if (at) {
			at->clear();
			delete at;
		}
	}
	delete respCache;

	logger.printf ( lt_updateInfo, ", done\n", m_lDocId );
	time (&long_time); pNewTime = localtime (&long_time);
	logger.printf (lt_updateInfo, "restore corrs ended at %s", asctime (pNewTime));
	logger.flush (lt_always);
}

void	UnFull::delete_all ()
{
	delete_deleted_docs ();

	//
	// SAVE BASEINFO CHANGES
	//
	if ( !m_mapBaseInfo.SaveInfo ( m_pNewBase ) )
		logger.printf ( lt_error, "ERROR: Not all BaseInfo updated\n" );

	if ( m_iDeSync == 1 ) {
		char	pBuff [8];
		char	pAttr [] = "HSTS";
		
		long	long_clock_t = (long) clock();
		memcpy ( pBuff, &long_clock_t, sizeof (long_clock_t) );
		if ( ! m_pOldBase->keyFile->PutAttr ( pAttr, pBuff, 8 ) )
			logger.printf ( lt_error, "Can't remove HSTS flag from Key-file\n" );
	}

	flush_caches (false);
	flush_caches (true);

	delete m_pAttrMask;
	if ( m_pDeltaSegments )
		free ( m_pDeltaSegments );
	//if ( m_pBaseInfoDelta ) free ( m_pBaseInfoDelta );
	if ( m_pOldInfo )
		free ( m_pOldInfo );
	if ( m_pNewInfo )
		free ( m_pNewInfo );

	/*
	if(m_ArrayUpdDocs)
		free (m_ArrayUpdDocs);
	m_ArrayUpdDocs= 0;
	if(m_ArrayDelDocs)
		free (m_ArrayDelDocs);
	m_ArrayDelDocs= 0;
	if(m_ArraySkpDocs)
		free (m_ArraySkpDocs);
	m_ArraySkpDocs= 0;
	*/
#ifdef QUICK_NEW_DOC
	if(pTmpDoc){
		pTmpDoc->FreeStructs();
		delete pTmpDoc;
		pTmpDoc= 0;
	}
#endif
}

UnFull:: ~UnFull ()
{
}

///////////////////////////////////////////////////////////////////////////////

void	UnFull::Reset ( FILE * pfDF1 )
{
	assert ( pfDF1 );
	m_DFile1 = pfDF1;

	if ( m_pDeltaSegments )
		free ( m_pDeltaSegments );
	//if ( m_pBaseInfoDelta ) free ( m_pBaseInfoDelta );

	m_pDeltaSegments = 0;
	m_siDeltaSegmentsCount = 0;
	//m_pBaseInfoDelta = 0;
}

///////////////////////////////////////////////////////////////////////////////

int UnFull::Work (bool b_first_delta)
{
	DHReader theHeader ( m_DFile1, 0 );
	
	switch ( theHeader.IsOK () )
	{
		/*
		case DHRS_BADVER :
			return ERR_BADVERSION;
			break;
		*/

		case DHRS_BADSIZE :
			return ERR_BADSIZE;
			break;

		case DHRS_OK :
			break;

		default :
			logger.printf ( lt_error, "Unknown delta status by DHReader : %d.\n", theHeader.IsOK () );
			return ERR_UNKNOWN;
			break;
	}

	char	pClassKey[] = "Clas";

	//
	// READ SEGMENTS FOR DELTING
	//
	m_pDeltaSegments = theHeader.LoadSegs ( m_siDeltaSegmentsCount );
	assert ( m_pDeltaSegments );

	//
	// READ AND CONTROL BASE REVISION
	//
	revision	aNeededBaseRevision = theHeader.GetOldRev ();	
	//m_pBaseInfoDelta = (BaseInfo*)malloc(sizeof(BaseInfo)*m_siDeltaSegmentsCount);
	
	short si;
	for ( si = 0; si < m_siDeltaSegmentsCount; si++ ) {
		//if(m_pOldBase->FindBaseInfo(m_pDeltaSegments[si],m_pBaseInfoDelta[si])!=sizeof(BaseInfo)){
		if ( !m_mapBaseInfo.contains ( m_pDeltaSegments[si] ) ) {
			// This segment not present
			logger.printf ( lt_error, "Segment with Id=%d doesn't exist in base\n", m_pDeltaSegments [si] );
			err_Segment = m_pDeltaSegments[si];
			return ERR_NOSEGMENT;
		}

		int	iComp = CompRevs ( &m_mapBaseInfo [m_pDeltaSegments[si]].LastUpdate, &aNeededBaseRevision );

		if ( iComp < 0 ) {
			// Some Times ago we skiped any delta
			logger.printf ( lt_error, "Segment (Id=%d) has lower revision then delta\n", m_pDeltaSegments [si] );
			sprintf(err_UpDateFrom, "%02d.%02d.%04d", m_mapBaseInfo[m_pDeltaSegments[si]].LastUpdate.RevisionDate.da_day, m_mapBaseInfo[m_pDeltaSegments[si]].LastUpdate.RevisionDate.da_mon, m_mapBaseInfo[m_pDeltaSegments[si]].LastUpdate.RevisionDate.da_year);
			sprintf(err_UpDateTo, "%02d.%02d.%04d", aNeededBaseRevision.RevisionDate.da_day, aNeededBaseRevision.RevisionDate.da_mon, aNeededBaseRevision.RevisionDate.da_year);
			return ERR_SKIPDELTA;
		} else if ( iComp > 0 ) {
			logger.printf ( lt_error, "Segment (Id=%d) has higher revision then delta\n", m_pDeltaSegments [si] );
			sprintf(err_BaseDate, "%02d.%02d.%04d", m_mapBaseInfo[m_pDeltaSegments[si]].LastUpdate.RevisionDate.da_day, m_mapBaseInfo[m_pDeltaSegments[si]].LastUpdate.RevisionDate.da_mon, m_mapBaseInfo[m_pDeltaSegments[si]].LastUpdate.RevisionDate.da_year);
			return ERR_UPDATEDBASE;
		}
	}

	DocsProcCreate ( theHeader.GetDocCount (), b_english_face );

	//
	// READ SEGMENTS BASE INFO DIFF
	//
	char *pBaseInfoMask = (char*) malloc (sizeof (char) * m_siDeltaSegmentsCount);
	DeltaRead ( pBaseInfoMask, sizeof (char), m_siDeltaSegmentsCount, m_DFile1);

	for ( si = 0; si < m_siDeltaSegmentsCount; si++ ) {
		if ( pBaseInfoMask [si] == 1 ) {
			
			Point p = m_mapBaseInfo.seek ( m_pDeltaSegments[si] );
			
			if ( !m_mapBaseInfo.contents(p).UserName ) {
				fseek ( m_DFile1, BASE_NAME_SIZE * 2, ACE_OS_SEEK_CUR );
				//имена сегментов меняются "addsyns BaseInfo" + "gl"
				//DeltaRead ( m_mapBaseInfo.contents(p).Name, BASE_NAME_SIZE, 1, m_DFile1 );
				//DeltaRead ( m_mapBaseInfo.contents(p).NameEng, BASE_NAME_SIZE, 1, m_DFile1 );
			} else
				fseek ( m_DFile1, BASE_NAME_SIZE * 2, ACE_OS_SEEK_CUR );

 			DeltaRead ( m_mapBaseInfo.contents(p).AuthorName, NAME_SIZE, 1, m_DFile1 );
 			DeltaRead ( &m_mapBaseInfo.contents(p).Weight, sizeof (unsigned short), 1, m_DFile1 );

 			long id;
 			DeltaRead ( &id, sizeof (id), 1, m_DFile1 );
			if ( id )
				m_mapBaseInfo.contents(p).SplashTopic = id;

 			DeltaRead ( &id, sizeof (id), 1, m_DFile1 );
			if ( id )
				m_mapBaseInfo.contents(p).BannerTopic = id;
		}
	}

	free ( pBaseInfoMask );

	//
	// RESTORING VARIBLE PART DIFF
	//
	unsigned short	suVarCount;
	unsigned short	suVarId;
	long		lVarSize;
	void		*pVarData = 0;

	DeltaRead ( &suVarCount, sizeof (suVarCount), 1, m_DFile1 );

	std::set<std::string> segment_indexes;

	for ( unsigned short su=0; su < suVarCount; su++ ) {
		DeltaRead ( &suVarId, sizeof (suVarId), 1, m_DFile1 );
		DeltaRead ( &lVarSize, sizeof ( long ), 1, m_DFile1 );
		pVarData = (void*) malloc ( lVarSize );
		assert ( pVarData );
		DeltaRead ( pVarData, 1, lVarSize, m_DFile1 );

		switch ( suVarId ) {
			case DVAR_SYNCVER:
				if ( *((long*)pVarData) > GU_VERSION ) {
					logger.printf ( lt_error, "Unsynced version. Present %d; needs %ld\n", GU_VERSION, *((long*)pVarData) );
					return ERR_UNSYNCVER;
				}
				break;

			case DVAR_GLMAPP:
				{
					long	len, datalen;
					char	*key, *data;

					len = *((long*)pVarData);
					datalen = lVarSize - len - sizeof(len);
					key = (char*) malloc ( len + 1 );
					memcpy (key, ((char*)pVarData)+sizeof(len), len );
					key[len] = 0;
					data = ((char*)pVarData)+sizeof(len)+len;

					if (!strcmp (key, AUX_SEGMENT_INDEXES)) {
						char *changes_ptr = data;
						bool virt_index = false;
						while (changes_ptr - data < datalen) {
							if (virt_index) segment_indexes.insert (changes_ptr);
							changes_ptr += strlen (changes_ptr) + 1;
							virt_index = !virt_index;
						}
					} else if (!strcmp (key, AUX_INDEXES_SYNS) || segment_indexes.find (key) != segment_indexes.end ()) {
						bool b_sections = !strcmp (key, AUX_INDEXES_SYNS);
						std::string dummy_section ("dummy");
	
						char *changes_ptr = (char*) data;
						Stream *str = m_pNewBase->FindIndex ("Aux")->Open (key);
						if (str) {
							long length = str->Length (), i;
							char *olddata = new char [length], *ptr = olddata;
							str->Read (olddata, length);
							m_pNewBase->FindIndex("Aux")->Close (str);

							std::map<std::string, std::vector<std::string> > old_values, new_values;
							std::vector<std::string> *values;
							if (!b_sections) {
								old_values.insert (std::map<std::string, std::vector<std::string> >::value_type (dummy_section, std::vector<std::string> ()));
								values = &old_values.find (dummy_section)->second;
							}
							while (ptr - olddata < length) {
								if (*ptr == '[' && b_sections) {
									old_values.insert (std::map<std::string, std::vector<std::string> >::value_type (ptr, std::vector<std::string> ()));
									values = &old_values.find (ptr)->second;
									ptr += strlen (ptr) + 1;
								} else if (*ptr) {
									if (b_sections) {
										values->push_back (ptr);
										ptr += strlen (ptr) + 1;
									} else {
										std::string str (ptr);
										ptr += strlen (ptr) + 1;
										str += "|";
										short count = *(short*) ptr;
										ptr += sizeof (short);
										for (short seg = 0; seg < count; seg++, ptr += sizeof (short)) {
											char seg_str [16];
											if (seg) str += ",";
											sprintf (seg_str, "%ld", *(short*)ptr);
											str += seg_str;
										}
										values->push_back (str);
									}
								} else {
									ptr++;
								}
							}
							delete []olddata;

							long sections_count;
							if (b_sections) {
								memcpy (&sections_count, changes_ptr, sizeof (sections_count)); changes_ptr += sizeof (sections_count);
								for (i = 0; i < sections_count; i++) {
									long str_size;
									memcpy (&str_size, changes_ptr, sizeof (str_size)); changes_ptr += sizeof (str_size);
									char *str = new char [str_size + 1];
									memcpy (str, changes_ptr, str_size); changes_ptr += str_size;
									str [str_size] = 0;
									old_values.erase (old_values.find (str));
								}

								memcpy (&sections_count, changes_ptr, sizeof (sections_count)); changes_ptr += sizeof (sections_count);
								for (i = 0; i < sections_count; i++) {
									long str_size;
									memcpy (&str_size, changes_ptr, sizeof (str_size)); changes_ptr += sizeof (str_size);
									char *str = new char [str_size + 1];
									memcpy (str, changes_ptr, str_size); changes_ptr += str_size;
									str [str_size] = 0;
									new_values.insert (std::map<std::string, std::vector<std::string> >::value_type (str, std::vector<std::string> ()));
									values = &new_values.find (str)->second;

									long count;
									memcpy (&count, changes_ptr, sizeof (count)); changes_ptr += sizeof (count);
									for (long j = 0; j < count; j++) {
										long str_size;
										memcpy (&str_size, changes_ptr, sizeof (str_size)); changes_ptr += sizeof (str_size);
										char *str = new char [str_size + 1];
										memcpy (str, changes_ptr, str_size); changes_ptr += str_size;
										str [str_size] = 0;
										values->push_back (str);
									}
								}
								old_values.insert (new_values.begin (), new_values.end ());
							}

							for (;;) {
								if (changes_ptr - (char*) data == datalen)
									break;

								char *str;
								if (b_sections) {
									long str_size;
									memcpy (&str_size, changes_ptr, sizeof (str_size)); changes_ptr += sizeof (str_size);
									str = new char [str_size + 1];
									memcpy (str, changes_ptr, str_size); changes_ptr += str_size;
									str [str_size] = 0;
								} else {
									str = new char [dummy_section.size () + 1];
									strcpy (str, dummy_section.c_str ());
								}

								long del_count, add_count;
								memcpy (&del_count, changes_ptr, sizeof (del_count)); changes_ptr += sizeof (long);
								memcpy (&add_count, changes_ptr, sizeof (add_count)); changes_ptr += sizeof (long);

								std::vector<long> del_positions, add_positions;
								std::vector<std::string> add_strings, *old_vector = &old_values.find (str)->second;

								for (i = 0; i < del_count; i++) {
									long pos;
									memcpy (&pos, changes_ptr, sizeof (pos)); changes_ptr += sizeof (pos);
									del_positions.push_back (pos);
								}
								for (i = 0; i < add_count; i++) {
									long pos;
									memcpy (&pos, changes_ptr, sizeof (pos)); changes_ptr += sizeof (pos);
									add_positions.push_back (pos);
								}
								for (i = 0; i < add_count; i++) {
									long str_size;
									memcpy (&str_size, changes_ptr, sizeof (str_size)); changes_ptr += sizeof (str_size);
									char *str = new char [str_size + 1];
									memcpy (str, changes_ptr, str_size); changes_ptr += str_size;
									str [str_size] = 0;
									add_strings.push_back (str);
									delete []str;
								}
								for (std::vector<long>::reverse_iterator rit = del_positions.rbegin (); rit != del_positions.rend (); rit++) {
									long del_pos = *rit;
									old_vector->erase (old_vector->begin () + del_pos);
								}
								std::vector<std::string>::const_iterator sit = add_strings.begin ();
								for (std::vector<long>::const_iterator it = add_positions.begin (); it != add_positions.end (); it++, sit++) {
									old_vector->insert (old_vector->begin () + *it, *sit);
								}
								delete []str;
							}
							if (old_values.size ()) {
								str = m_pNewBase->FindIndex ("Aux")->Open (key, 1);
								if (str) {
									for (std::map<std::string,std::vector<std::string> >::const_iterator map_it = old_values.begin (); map_it != old_values.end (); map_it++) {
										if (b_sections)
											str->Write (map_it->first.c_str (), map_it->first.size () + 1);
										for (std::vector<std::string>::const_iterator str_it = map_it->second.begin (); str_it != map_it->second.end (); str_it++) {
											if (b_sections) {
												str->Write (str_it->c_str (), str_it->size () + 1);
											} else {
												char* copy = strdup (str_it->c_str ()), *deli = strchr (copy, '|');
												if (deli) {
													*deli++ = 0;
													GCL::StrVector parts;
													boost::split (parts, deli, boost::is_any_of (","));
													str->Write (copy, strlen (copy) + 1);
													short count = (short)(parts.size () & 0x7FFF);
													str->Write (&count, sizeof (count));
													for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); it++) {
														short at = (short) (atol (it->c_str ()) & 0x7FFF);
														str->Write (&at, sizeof (at));
													}

												}
												gk_free (copy);
											}
										}
										if (b_sections) {
											char zero = 0;
											str->Write (&zero, sizeof (zero));
										}
									}
									str->Trunc ();
									m_pNewBase->FindIndex ("Aux")->Close (str);
								}
							} else {
								m_pNewBase->FindIndex ("Aux")->Delete (key);
							}
						}
					} else {
						Stream	*str = m_pNewBase->FindIndex("Aux")->Open(key, 1);
						if( str ) {
							str->Write(data, datalen);	
							str->Trunc ();
							m_pNewBase->FindIndex("Aux")->Close(str);
							logger.printf ( lt_debug, "Chg Aux key for \"%s\"\n", data );
							if (datalen == 0)
								m_pNewBase->FindIndex("Aux")->Delete (key);

							if (!strcmp (key, AUX_KIND_GCTX) || !strcmp (key, AUX_KIND_BLOCK)) {
								kinds.clear ();
								m_pNewBase->fill_kindsset (m_pNewBase, kinds);
							}
						} else {
							logger.printf (lt_error, "Can't open/create key in Aux\n" );
						}
					}

					if ( key )
						free (key);

					break;
				}

			default :
				logger.printf ( lt_warning, "Unknown Varible part diff Id (Id:%ud, Size:%ld)\n",
				suVarId, lVarSize );	
				break;
		} // end switch
		free ( pVarData );
	}

	HIndex* kinds_index = (HIndex*) m_pNewBase->FindIndex ("Kind");
	for (long i = 0; i < 2; i++) {
		for (std::set<std::string>::const_iterator it = kinds.find (i)->second.begin (); it != kinds.find (i)->second.end (); it++) {
			new_kinds_set.insert (*it);
		}
	}

	//
	// CONTROL AND CHANGE CLASS VERSION
	//
	long	lNeededClassId = theHeader.GetClassId ();
	long	lExistClassId;

	Stream	*pStr = m_pNewBase->FindIndex("Aux")->Open ( pClassKey );
	assert ( pStr && pStr->Length() == sizeof(long) );
	pStr -> Read ( &lExistClassId, sizeof(lExistClassId) );

	pStr -> Seek ( 0 );
	pStr -> Write ( &lNeededClassId, sizeof ( lNeededClassId ) );
	m_pNewBase->FindIndex("Aux")->Close ( pStr );

	//key6
	long del_count, add_count, i;
	DeltaRead ( &del_count, sizeof (del_count), 1, m_DFile1 );
	for (i = 0; i < del_count; i++) {
		long to_del;
		DeltaRead ( &to_del, sizeof (to_del), 1, m_DFile1 );
		if (b_first_delta)
			to_delete_keys.insert (to_del);
	}
	DeltaRead ( &add_count, sizeof (add_count), 1, m_DFile1 );
	for (i = 0; i < add_count; i++) {
		long to_add, str_len;
		DeltaRead (&to_add, sizeof (to_add), 1, m_DFile1 );
		DeltaRead (&str_len, sizeof (str_len), 1, m_DFile1 );
		char* str = (char*) malloc (str_len);
		DeltaRead (str, str_len, 1, m_DFile1 );
		if (b_first_delta) {
			new_map_key_id.insert (std::map<std::string,long>::value_type (str, to_add));
			//http://mdp.garant.ru/pages/viewpage.action?pageId=535330828&focusedCommentId=537955296#comment-537955296
			//было map_key_id.insert (std::map<std::string,long>::value_type (str, to_add));
			old_map_id_str.insert (std::map<long,std::string>::value_type (to_add, str));
		}
		gk_free (str);
	}

	//
	// DOCS RESTORING CYCLE
	//
	struct	tm	*pNewTime;
	time_t		long_time;

	time (&long_time); pNewTime = localtime (&long_time);
	logger.printf (lt_updateInfo, "Docs restoring cycle started at %s", asctime (pNewTime));
	for ( long lDocNum = 0; lDocNum < theHeader.GetDocCount (); lDocNum++ ) {
		AddDelta ( 1, b_english_face );
		DocRestore ();
	}
	lastDocFlush();
	if (m_pGParaArray) {
		if (m_pGParaArray [0])
			free (m_pGParaArray [0]);
		free (m_pGParaArray);
		m_pGParaArray = 0;
		m_iGTextAlloc = 0x8000000;
	}

	time (&long_time); pNewTime = localtime (&long_time);
	logger.printf (lt_updateInfo, "Docs restoring cycle ended at %s", asctime (pNewTime));

	//
	// UPDATE DOCKIND'S SECOND STREAM (Main Menu structure)
	//
	long	lKeyCount = 0;

	//
	// chg key count dummy
	//
	DeltaRead ( &lKeyCount, sizeof ( lKeyCount ), 1, m_DFile1 );

	HIndex	*pind =  (HIndex*) m_pNewBase->FindIndex("DocKind");
	assert ( pind );

	while ( lKeyCount-- )
	{
		logger.printf ( lt_updateInfo, "Updating Main Menu structure (%ld - keys)\n", lKeyCount );

		long	keyLen = 0;

		DeltaRead ( &keyLen, sizeof(keyLen), 1, m_DFile1 );

		char	*keystr = (char*)malloc( (size_t)keyLen );
		assert ( keystr );

		//
		// Full string H-key with x0 terminator
		//
		DeltaRead ( keystr, keyLen, 1, m_DFile1 );

		long dataLen = 0;
		DeltaRead ( &dataLen, sizeof(dataLen), 1, m_DFile1 );
			
		Stream	*pstr = pind->OpenN ( keystr, 1 );
		if ( !pstr ) {
			//
			// All keys must exist, changed or added while restore docs.
			// If it is newly added key then second stream may be absent,
			//   but first stream must exist in any case,
			//   else this is key from other segment - skip it
			//
			pstr = pind->Open (keystr);
			if ( !pstr )
				fseek ( m_DFile1, dataLen, ACE_OS_SEEK_CUR );
			else {
				pind->Close ( pstr );
				pstr = pind->OpenN(keystr, 1, 1);
			}
		}
		free ( keystr );
		if ( pstr ) {
			if ( dataLen ) {
				void* data = malloc ( dataLen );
				assert ( data );

				DeltaRead ( data, 1, dataLen, m_DFile1 );
				pstr->Write (data, dataLen);
				free ( data );
			}
			pstr->Trunc ();
			pind->Close (pstr);
		}
	}	
		
	//
	// UPDATE BLOB INDEX
	//
	time (&long_time); pNewTime = localtime (&long_time);
	logger.printf (lt_updateInfo, "Blobs at %s", asctime (pNewTime));
	long	lBlobCount = 0;
	DeltaRead ( &lBlobCount, sizeof (lBlobCount), 1, m_DFile1 );

	Index	*ind = m_pNewBase->FindIndex("Blob");
	
	while ( lBlobCount-- ) {
		ObjKey objkey;
		short order;
		
		DeltaRead ( &objkey, sizeof ( ObjKey ), 1, m_DFile1 );
		DeltaRead ( &order, sizeof ( order ), 1, m_DFile1 );
		logger.printf ( lt_updateInfo, "Blob %ld - %s", objkey.id, ind->IsExist (&objkey) ? "chg" : "new");
				
		Stream * pstr = 0;
		ObjInfo oldinfo, newinfo;
		oldinfo.type = newinfo.type = 0;
		bool b_oldinfo_readed = false, b_newinfo_readed = false;
		if ( order & BO_INFCHG ) {
			if((pstr = ind->OpenN ( &objkey, 0, 0 ))) {
				if(pstr->Pos == MAX_BYTE_FILE_SIZE){
					long lll= pstr->Length(), llll;
					char *ppp= (char *)malloc(lll), *bbb= 0;
					pstr->Read(ppp, lll);
					ind->Close(pstr);
					pstr= ind->OpenN ( &objkey, 1, 0 );
					if(pstr){
						bbb= (char*)malloc((llll= pstr->Length()));
						pstr->Read(bbb, llll);
						ind->Close(pstr);
					}
					ind->DelKey(&objkey);
					if(bbb){
						pstr = ind->OpenN ( &objkey, 1, 1 );
						pstr->Write(bbb, llll);
						ind->Close(pstr);
						free(bbb);
					}
					pstr = ind->OpenN ( &objkey, 0, 1 );
					pstr->Write(ppp, lll);
					free(ppp);
					pstr->Seek(0);
				}
			}else
				pstr = ind->OpenN ( &objkey, 0, 1 );
			assert ( pstr );

			pstr->Read ( &oldinfo, sizeof(ObjInfo) );
			b_oldinfo_readed = true;
			pstr->Seek ( 0 );
			DeltaRead ( &newinfo, sizeof(ObjInfo), 1, m_DFile1 );
			b_newinfo_readed = true;

			if ( ! (order&BO_OBJCHG) ) {
				newinfo.crc32 = oldinfo.crc32;
				newinfo.size = oldinfo.size;
				newinfo.packed = oldinfo.packed;
			}

			pstr->Write (&newinfo, sizeof(ObjInfo));
		}

		{
		long type = newinfo.type ? newinfo.type : oldinfo.type;
		if (type) {
			char aType [5];
			memcpy (aType, &type, 4);
			for (int i = 0; i < 4; i++) 
				if (!aType [i])
					aType [i] = ' ';
			aType [4] = 0;
			while (aType [0] == ' ')
				memcpy (aType, aType + 1, 4);
			logger.printf (lt_updateInfo, ", %s", aType);
		}
		}

		if ( order & BO_OBJCHG ) {
			if ( !pstr ) {
				pstr = ind->OpenN ( &objkey, 0, 0 );
				if(pstr->Pos == MAX_BYTE_FILE_SIZE){
					long lll= pstr->Length(), llll;
					char *ppp= (char *)malloc(lll), *bbb= 0;
					pstr->Read(ppp, lll);
					ind->Close(pstr);
					pstr= ind->OpenN ( &objkey, 1, 0 );
					if(pstr){
						bbb= (char*)malloc((llll= pstr->Length()));
						pstr->Read(bbb, llll);
						ind->Close(pstr);
					}
					ind->DelKey(&objkey);
					if(bbb){
						pstr = ind->OpenN ( &objkey, 1, 1 );
						pstr->Write(bbb, llll);
						ind->Close(pstr);
						free(bbb);
					}
					pstr = ind->OpenN ( &objkey, 0, 1 );
					pstr->Write(ppp, lll);
					free(ppp);
					pstr->Seek(0);
				}
				assert ( pstr );
				pstr->Read ( &oldinfo, sizeof(ObjInfo) );
				b_oldinfo_readed = true;
			}
			long	dataLen;
			DeltaRead ( &dataLen, sizeof(dataLen), 1, m_DFile1 );
			logger.printf (lt_updateInfo, ", len=%ld", dataLen);
			
			void	*data = malloc ( dataLen );
			assert ( data );
			DeltaRead ( data, 1, dataLen, m_DFile1 );

			if ( !(order & BO_TALCHG) ) {
				long tailLen = pstr->Length() - sizeof(ObjInfo) - oldinfo.size;
				void* tail = malloc ( tailLen );
				assert ( tail );
				
				pstr->Seek ( pstr->Length() - tailLen );
				pstr->Read ( tail, tailLen );
				pstr->Seek ( sizeof(ObjInfo) );

				pstr->Write ( data, dataLen );
				pstr->Write ( tail, tailLen );
				pstr->Trunc();

				free ( tail );
			} else
				pstr->Write ( data, dataLen );

			free ( data );
		}
		if ( order & BO_TALCHG ) {
			if ( !pstr ) {
				pstr = ind->OpenN ( &objkey, 0, 0 );
				if(pstr->Pos == MAX_BYTE_FILE_SIZE){
					long lll= pstr->Length(), llll;
					char *ppp= (char *)malloc(lll), *bbb= 0;
					pstr->Read(ppp, lll);
					ind->Close(pstr);
					pstr= ind->OpenN ( &objkey, 1, 0 );
					if(pstr){
						bbb= (char*)malloc((llll= pstr->Length()));
						pstr->Read(bbb, llll);
						ind->Close(pstr);
					}
					ind->DelKey(&objkey);
					if(bbb){
						pstr = ind->OpenN ( &objkey, 1, 1 );
						pstr->Write(bbb, llll);
						ind->Close(pstr);
						free(bbb);
					}
					pstr = ind->OpenN ( &objkey, 0, 1 );
					pstr->Write(ppp, lll);
					free(ppp);
					pstr->Seek(0);
				}
				assert ( pstr );
				pstr->Read ( &oldinfo, sizeof(ObjInfo) );
				b_oldinfo_readed = true;
				pstr->SeekCur ( oldinfo.size );
			} else if ( !(order & BO_OBJCHG) ) {
				pstr->SeekCur ( oldinfo.size );
			}

			long	tailLen;
			DeltaRead ( &tailLen, sizeof(tailLen), 1, m_DFile1 );
			
			void	*tail = malloc ( tailLen );
			assert ( tail );
			DeltaRead ( tail, 1, tailLen, m_DFile1 );

			pstr->Write ( tail, tailLen );
			pstr->Trunc ();

			logger.printf (lt_updateInfo, ", taillen=%ld", tailLen);

			free ( tail );
		}

		if ( pstr ) {			
			ind->Close ( pstr );
		}
			
		if ( order & BO_BELCHG ) {
			if (!b_oldinfo_readed) {
				pstr = ind->OpenN ( &objkey, 0, 0 );
				if (pstr) {
					if(pstr->Pos == MAX_BYTE_FILE_SIZE){
						long lll= pstr->Length(), llll;
						char *ppp= (char *)malloc(lll), *bbb= 0;
						pstr->Read(ppp, lll);
						ind->Close(pstr);
						pstr= ind->OpenN ( &objkey, 1, 0 );
						if(pstr){
							bbb= (char*)malloc((llll= pstr->Length()));
							pstr->Read(bbb, llll);
							ind->Close(pstr);
						}
						ind->DelKey(&objkey);
						if(bbb){
							pstr = ind->OpenN ( &objkey, 1, 1 );
							pstr->Write(bbb, llll);
							ind->Close(pstr);
							free(bbb);
						}
						pstr = ind->OpenN ( &objkey, 0, 1 );
						pstr->Write(ppp, lll);
						free(ppp);
						pstr->Seek(0);
					}
					pstr->Read ( &oldinfo, sizeof(ObjInfo) );
					ind->Close ( pstr );

					if (!b_newinfo_readed) {
						b_newinfo_readed = true;
						newinfo = oldinfo;
					}
				}
			}
			if (oldinfo.type == EOT_XLS || oldinfo.type == EOT_RTF) {
				pstr = ind->OpenN (&objkey, 1);
				assert (pstr);
				short count = (short) pstr->Length ();
				short *belongs = (short*) malloc (count), *blob_belongs = belongs;
				pstr->Read (belongs, count);
				count /= sizeof (short);
				ind->Close (pstr);
				for (short i = 0; i < count; i++, blob_belongs++) {
					if (!*blob_belongs || !m_mapBaseInfo.contains (*blob_belongs))
						continue;
					BaseInfo *bi = &m_mapBaseInfo[*blob_belongs];
					bi->FormsCount--;
				}
				free (belongs);
			}

			pstr = ind->OpenN ( &objkey, 1, 1 );
			assert ( pstr );

			long	dataLen;
			DeltaRead ( &dataLen, sizeof(dataLen), 1, m_DFile1 );
			logger.printf (lt_updateInfo, ", belongslen=%ld", dataLen);

			void	*data = malloc ( dataLen );
			assert ( data );
			DeltaRead ( data, 1, dataLen, m_DFile1 );
			pstr->Write ( data, dataLen );

			if (newinfo.type == EOT_XLS || newinfo.type == EOT_RTF) {
				short count = short((dataLen >> 1)&0x7fff);
				short* blob_belongs = (short*) data;
				for (short i = 0; i < count; i++, blob_belongs++) {
					if (!*blob_belongs || !m_mapBaseInfo.contains (*blob_belongs))
						continue;
					BaseInfo *bi = &m_mapBaseInfo[*blob_belongs];
					bi->FormsCount++;
				}
			}

			free ( data );

			pstr->Trunc();
			ind->Close(pstr);
		}
		logger.printf (lt_updateInfo, "\n");
	}
	
	//
	// deleted Blobs
	//
	lBlobCount = 0;
	DeltaRead ( &lBlobCount, sizeof ( lBlobCount ), 1, m_DFile1 );
	
	while ( lBlobCount-- ) {
		ObjKey objkey;
		DeltaRead ( &objkey, sizeof ( ObjKey ), 1, m_DFile1 );
		logger.printf ( lt_updateInfo, "Blob %ld - del\n", objkey.id );
		
		Stream* pstr1 = ind->OpenN (&objkey,0);
		ObjInfo objinfo; objinfo.type = 0;
		if (pstr1) {
			pstr1->Read (&objinfo, sizeof (ObjInfo));
			ind->Close (pstr1);
		}
		Stream	*pstr = 0;

		if ( !pstr1 || !(pstr = ind->OpenN ( &objkey, 1 )))
			logger.printf ( lt_updateInfo, "Blob (%ld) already deleted from index\n", objkey.id );
		else{
			StorableSplaySet<short> blobSegs;
			blobSegs.Get ( pstr );
							
			for ( si = 0; si < m_siDeltaSegmentsCount; si++ )
				if ( blobSegs.contains ( m_pDeltaSegments [si] ) ) {
					short blob_belongs = m_pDeltaSegments [si];
					if (!blob_belongs || !m_mapBaseInfo.contains (blob_belongs))
						continue;
					blobSegs.del ( blob_belongs );
					if (objinfo.type == EOT_XLS || objinfo.type == EOT_RTF) {
						BaseInfo *bi = &m_mapBaseInfo[blob_belongs];
						bi->FormsCount--;
					}
				}
		
			if ( ! (blobSegs & m_presentSegments) ){
				ind->Close ( pstr );
				if ( ind->Delete ( &objkey ) != GKDB::BT_OK )
					logger.printf ( lt_error, "Can't delete Blob (%ld) from index\n", objkey.id );
			} else {
				logger.printf ( lt_updateInfo, "Blob (%ld) locked from another seg\n", objkey.id );
				pstr->Seek(0);
				blobSegs.Put ( pstr );
				pstr->Trunc();
				ind->Close ( pstr );
			}
		}
	}
	
	//
	// READ DELETED DOCS
	//
	DeltaRead( &m_lDocId, sizeof ( long ), 1, m_DFile1 );
	logger.printf ( lt_updateInfo, "Caching Deleted Doc ...\n" );

	fill_setdeltasegs ();
	SplaySet<short> zero_set; 
	short zero_seg = 0;
	zero_set.add (zero_seg);
	while ( m_lDocId != NEW_ID ) {		
		logger.printf ( lt_updateInfo, "Deleted Doc (DocId:%ld)\n", m_lDocId );
		
		m_mapDelDocs[m_lDocId] |= zero_set; //setDeltaSegs;
		
		if( !DeltaRead( &m_lDocId, sizeof ( long ), 1, m_DFile1 ) ) {
			logger.printf ( lt_error, "Unexpected end of file while reding deleted documents\n");
			return ERR_UNKNOWNEOF;
		}
	}
	std::set<long>::const_iterator it;
	for (it = s_SkpDocs.begin (); it != s_SkpDocs.end (); it++) {
		s_DelDocs.insert (*it);
		s_UpdDocs.erase (*it);
	}
	s_DelDocs.insert (0x7ffffffc);

	{
		std::set<std::string> diff_kinds_set;
		std::set<std::string>::const_iterator it;
		for (it = new_kinds_set.begin (); it != new_kinds_set.end (); it++) {
			std::string kind = *it;
			if (old_kinds_set.find (kind) == old_kinds_set.end ()) {
				diff_kinds_set.insert (kind);
			}
		}
		for (it = old_kinds_set.begin (); it != old_kinds_set.end (); it++) {
			std::string kind = *it;
			if (new_kinds_set.find (kind) == new_kinds_set.end ()) {
				diff_kinds_set.insert (kind);
			}
		}

		DocCollection docs_to_reindex;
		for (it = diff_kinds_set.begin (); it != diff_kinds_set.end (); it++) {
			std::string kind = *it;
			HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) kinds_index->FullKey (kind.c_str ());
			if (hkey) {
				Stream* str = kinds_index->Index::OpenN (hkey, 0);
				if (str) {
					RefCollection refs;
					refs.Get (str);
					kinds_index->Close (str);
					docs_to_reindex.Merge (refs);
				}
				free (hkey);
			}
		}
		for (int docs = 0; docs < docs_to_reindex.ItemCount; docs++) {
			long id = docs_to_reindex [docs];
			if (s_DelDocs.find (id) == s_DelDocs.end ())
				s_UpdDocs.insert (id);
		}
	}
	s_UpdDocs.insert (0x7ffffffc);
	s_SkpDocs.insert (0x7ffffffc);

	//
	// READ CORRESPONDENT FOR ALL DOCUMENTS
	//
	mpcxc_fgetpos (m_DFile1, &pos_of_correspondents);
	logger.printf ( lt_updateInfo, "Read correspondents for all documents\n", m_lDocId );

	long diffCount;
	DeltaRead ( &diffCount, sizeof (diffCount), 1 , m_DFile1 );
	logger.printf ( lt_debug, "Correspondent diff count = %ld\n", diffCount );

	long l;
	for ( l=0; l < diffCount; l++ ) {
		long docId;
		DeltaRead ( &docId, sizeof (docId), 1 , m_DFile1 );

		long count;
		Ref ref;

		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
			//m_mapCorrs[docId].delCor.add(ref);
		}

		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
			//m_mapCorrs[docId].addCor.add(ref);
		}				
	}
	
	//read NewCorr diff
	DeltaRead ( &diffCount, sizeof (diffCount), 1 , m_DFile1 );
	for ( l=0; l < diffCount; l++ ) {
		long docId;
		DeltaRead ( &docId, sizeof (docId), 1 , m_DFile1 );

		long count;
		CorrRef ref;

		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
			//m_mapCorrs[docId].delNCor.add(ref);
		}

		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
			//m_mapCorrs[docId].addNCor.add(ref);
		}				

		//проскиповали and секцию, которая для deltamergerа
		DeltaRead ( &count, sizeof (count), 1 , m_DFile1 );
		for ( ; count; count-- ) {
			DeltaRead ( &ref, sizeof (ref), 1 , m_DFile1 );
		}
	}

	//restore Control index
	DeltaRead ( &diffCount, sizeof (diffCount), 1 , m_DFile1 );
	logger.printf ( lt_debug, "Control diff count = %ld\n", diffCount );
	if ( diffCount ) {
		Index* controlIndex = m_pNewBase->FindIndex( "Control" );

		for ( l=0; l < diffCount; l++ ) {
			date aKey;
			DeltaRead( &aKey, sizeof( aKey ), 1, m_DFile1 );
			long aSize;
			DeltaRead( &aSize, sizeof( aSize ), 1, m_DFile1 );
			void gk_huge* aData = gk_malloc( aSize );
			DeltaRead( aData, aSize, 1, m_DFile1 );
			Stream* str = controlIndex->Open( &aKey,1 );
			if (str) {
				str->Write(aData,aSize);
				controlIndex->Close(str);
			}
			gk_free(aData);
		}
	}

	time (&long_time); pNewTime = localtime (&long_time);
	logger.printf (lt_updateInfo, "Restoring Syns/CVar/... at %s", asctime (pNewTime));
	RestoreSyns (AUX_SYN_MORPHO);
	RestoreCVar ();
	RestoreMorphoHashes ();
	RestoreReleFLaws ();
	RestoreTypingErrors ();
	RestoreGoodWords ();
	RestoreKindCorr (b_first_delta);
	RestoreSyns (AUX_SIMPLE_SYNS);
	RestoreSearchCache ();

	if (b_first_delta) {
		logger.printf ( lt_updateInfo, "Restore Aux.key6\n");
		logger.flush (lt_always);
		//key6
		Stream* str = m_pNewBase->FindIndex ("Aux")->Open (AUX_CLASS6_KEYS);
		if (str) {
			std::map<std::string,long>::const_iterator it;
			for (it = new_map_key_id.begin (); it != new_map_key_id.end (); it++) {
				if (to_delete_keys.find (it->second) == to_delete_keys.end ()) {
					char *buffer = (char*) malloc (it->first.size () + 32);
					sprintf (buffer, "%ld:%s", it->second, it->first.c_str ());
					str->Write (buffer, strlen (buffer)+1);
					gk_free (buffer);
				}
			}
			for (it = map_key_id.begin (); it != map_key_id.end (); it++) {
				if (to_delete_keys.find (it->second) == to_delete_keys.end () && new_map_key_id.find (it->first) == new_map_key_id.end ()) {
					char *buffer = (char*) malloc (it->first.size () + 32);
					sprintf (buffer, "%ld:%s", it->second, it->first.c_str ());
					str->Write (buffer, strlen (buffer)+1);
					gk_free (buffer);
				}
			}
			str->Trunc ();
			m_pNewBase->FindIndex ("Aux")->Close (str);
		}
	}

	//
	// SET NEW BASE-INFO FOR ALL SEGMENTS
	//
	for ( si = 0; si < m_siDeltaSegmentsCount; si++ )
	{
 		//
		// Needed Segment revision OK. Change Segment Revision
		//
 		logger.printf ( lt_debug, "Update OK. Set New Segment's (Id=%d) Revision date\n", m_pDeltaSegments [si] );
		m_mapBaseInfo [m_pDeltaSegments[si]].LastUpdate = theHeader.GetNewRev ();
	}

	logger.printf ( lt_debug, "Update OK. Set New Segment's (Id=0) Revision date\n" );
	m_mapBaseInfo [0].LastUpdate = theHeader.GetNewRev ();

	return 0;
}

void	UnFull::fill_setdeltasegs ()
{
	if (0 == setDeltaSegs.length ()) {
		for (short si = 0; si < m_siDeltaSegmentsCount; si++ )
			setDeltaSegs.add(m_pDeltaSegments [si]);
	}
}

void	UnFull::RestoreSearchCache ()
{
	logger.printf (lt_always, "Restore search cache\n");
	logger.flush (lt_always);
	long segs_count;
	DeltaRead (&segs_count, sizeof (long), 1, m_DFile1);
	for (long segs = 0; segs < segs_count; segs++) {
		long seg, size, delcount, addcount, chgcount, i;
		DeltaRead (&seg, sizeof (long), 1, m_DFile1);
		DeltaRead (&size, sizeof (long), 1, m_DFile1);

		char name [5];
		sprintf (name, "-%03d", seg);
		Stream* str = m_pNewBase->FindIndex ("Aux")->Open (name, 1);
		if (!str) {
			fseek (m_DFile1, size, ACE_OS_SEEK_CUR);
			return ;
		}
		std::map<std::string, long> map_request_offset, map_request_count;
		std::map<std::string, void*> map_request_data;
		char* request_str = 0;
		while (str->Tell () < str->Length ()) {
			long request_str_length;
			str->Read (&request_str_length, sizeof (long));
			request_str = (char*) realloc (request_str, request_str_length);
			str->Read (request_str, request_str_length);
			long offset;
			str->Read (&offset, sizeof (long));
			map_request_offset.insert (std::map<std::string, long>::value_type (request_str, offset));
		}
		if (request_str) gk_free (request_str);
		m_pNewBase->FindIndex ("Aux")->Close (str);

		name [0] = '|';
		str = m_pNewBase->FindIndex ("Aux")->Open (name, 1);
		if (!str) {
			fseek (m_DFile1, size, ACE_OS_SEEK_CUR);
			return ;
		}
		
		for (std::map<std::string, long>::const_iterator map_it = map_request_offset.begin (); map_it != map_request_offset.end (); map_it++) {
			str->Seek (map_it->second);
			long count;
			str->Read (&count, sizeof (long));
			RefwRele *data = new RefwRele [count];
			str->Read (data, sizeof (RefwRele) * count);
			map_request_data.insert (std::map<std::string, void*>::value_type (map_it->first, data));
			map_request_count.insert (std::map<std::string, long>::value_type (map_it->first, count));
		}
		m_pNewBase->FindIndex ("Aux")->Close (str);
		
		DeltaRead (&delcount, sizeof (long), 1, m_DFile1);
		DeltaRead (&addcount, sizeof (long), 1, m_DFile1);
		DeltaRead (&chgcount, sizeof (long), 1, m_DFile1);

		for (i = 0; i < delcount; i++) {
			unsigned char str_len;
			DeltaRead (&str_len, sizeof (str_len), 1, m_DFile1);
			char *str = new char [str_len];
			DeltaRead (str, str_len, 1, m_DFile1);
			std::map<std::string, void*>::iterator map_it = map_request_data.find (str);
			if (map_it != map_request_data.end ()) {
				RefwRele* ptr = (RefwRele*) map_it->second;
				delete ptr;
				map_request_data.erase (map_it);
			}
			delete []str;
		}

		for (i = 0; i < addcount; i++) {
			unsigned char str_len;
			DeltaRead (&str_len, sizeof (str_len), 1, m_DFile1);
			char *str = new char [str_len];
			DeltaRead (str, str_len, 1, m_DFile1);
			unsigned char count;
			DeltaRead (&count, sizeof (count), 1, m_DFile1);
			RefwRele *data = new RefwRele [count];
			DeltaRead (data, sizeof (RefwRele), (size_t) count, m_DFile1);
			map_request_data.insert (std::map<std::string,void*>::value_type (str, data));
			map_request_count.insert (std::map<std::string,long>::value_type (str, count));
		}

		for (i = 0; i < chgcount; i++) {
			unsigned char str_len;
			DeltaRead (&str_len, sizeof (str_len), 1, m_DFile1);
			char *str = new char [str_len];
			DeltaRead (str, str_len, 1, m_DFile1);

			std::map<std::string, void*>::iterator map_it = map_request_data.find (str);
			RefwRele *ptr = (RefwRele*) map_it->second;
			std::vector<RefwRele> rele;
			for (int j = 0; j < map_request_count.find (str)->second; j++, ptr++)
				rele.push_back (*ptr);
			ptr = (RefwRele*) map_it->second;
			delete ptr;

			std::vector<char> del_positions;
			char del_count;
			DeltaRead (&del_count, sizeof (del_count), 1, m_DFile1);
			if (del_count == (char) (rele.size () & 0xFF)) {
				rele.clear ();
				char add_count;
				DeltaRead (&add_count, sizeof (add_count), 1, m_DFile1);
				for (; add_count; add_count--) {
					RefwRele ref;
					DeltaRead (&ref, sizeof (RefwRele), 1, m_DFile1);
					rele.push_back (ref);
				}
			} else {
				for (; del_count; del_count--) {
					char del_pos;
					DeltaRead (&del_pos, sizeof (del_pos), 1, m_DFile1);
					del_positions.push_back (del_pos); //gdlt кладет удаляемые позиции "с конца"
				}
				for (std::vector<char>::const_iterator it = del_positions.begin (); it != del_positions.end (); it++)
					rele.erase (rele.begin () + *it);

				char add_count;
				DeltaRead (&add_count, sizeof (add_count), 1, m_DFile1);
				std::map<char,RefwRele> to_add;
				for (; add_count; add_count--) {
					RefwRele rele;
					char add_pos;
					DeltaRead (&add_pos, sizeof (add_pos), 1, m_DFile1);
					DeltaRead (&rele, sizeof (RefwRele), 1, m_DFile1);
					to_add.insert (std::map<char,RefwRele>::value_type (add_pos, rele));
				}
				for (std::map<char,RefwRele>::const_iterator add_it = to_add.begin (); add_it != to_add.end (); add_it++)
					rele.insert (rele.begin () + add_it->first, add_it->second);
			}

			RefwRele *data = new RefwRele [rele.size ()];
			ptr = data;
			map_request_count.find (str)->second = rele.size ();
			for (std::vector<RefwRele>::const_iterator it = rele.begin (); it != rele.end (); it++, ptr++)
				*ptr = *it;
			map_it->second = data;
		}

		if (map_request_data.size ()) {
			std::map<std::string,void*>::iterator map_it;
			str = m_pNewBase->FindIndex ("Aux")->Open (name, 1);
			for (map_it = map_request_data.begin (); map_it != map_request_data.end (); map_it++) {
				long count = map_request_count.find (map_it->first)->second;
				str->Write (&count, sizeof (count));
				RefwRele* data = (RefwRele*) map_it->second;
				str->Write (data, count * sizeof (RefwRele));
				delete data;
			}
			str->Trunc ();
			m_pNewBase->FindIndex ("Aux")->Close (str);

			name [0] = '-';
			Stream* str_offsets = m_pNewBase->FindIndex ("Aux")->Open (name, 1);
			long offset = 0;
			for (map_it = map_request_data.begin (); map_it != map_request_data.end (); map_it++) {
				long str_len = map_it->first.size () + 1;
				str_offsets->Write (&str_len, sizeof (long));
				str_offsets->Write (map_it->first.c_str (), str_len);
				str_offsets->Write (&offset, sizeof (long));
				long count = map_request_count.find (map_it->first)->second;
				offset += sizeof (count) + count * sizeof (RefwRele);
			}
			str_offsets->Trunc ();
			m_pNewBase->FindIndex ("Aux")->Close (str_offsets);
		} else {
			m_pNewBase->FindIndex ("Aux")->Delete (name);
			name [0] = '-';
			m_pNewBase->FindIndex ("Aux")->Delete (name);
		}
	}
}

void	UnFull::RestoreKindCorr (bool b_first_delta)
{
	screen->SetMessage (b_english_face ? "Updating correspondents list..." : "Обновление индекса корреспондентов...");
	screen->SetProgress (0);

	Index* index = m_pNewBase->FindIndex ("KindCorr");
	long total_diff, del_count, new_count, chg_count, i;	
	DeltaRead (&total_diff, sizeof (total_diff), 1, m_DFile1);

	if (total_diff == 12) {
		DeltaRead (&del_count, sizeof (del_count), 1, m_DFile1);
		DeltaRead (&new_count, sizeof (new_count), 1, m_DFile1);
		DeltaRead (&chg_count, sizeof (chg_count), 1, m_DFile1);
		return ;
	}

	char* packed_data = (char*) malloc (total_diff);
	DeltaRead (packed_data, total_diff, 1, m_DFile1);

	if (!b_first_delta) {
		gk_free (packed_data);
		return ;
	}

	logger.printf (lt_always, "Restore index KindCorr\n");
	logger.flush (lt_always);

	long unpacked_size = *(long*)packed_data;
	char *unpacked_data = (char*) malloc (unpacked_size), *ptr = unpacked_data;
	if (0 == G_UNZIP (packed_data + sizeof (unpacked_size), total_diff, unpacked_data, unpacked_size)) {
		memcpy (unpacked_data, packed_data + sizeof (unpacked_size), unpacked_size);
	}
	gk_free (packed_data);	

	del_count = *(long*) ptr; ptr += sizeof (del_count);
	for (i = 0; i < del_count; i++) {
		u_int64_t del_64;
		memcpy (&del_64, ptr, sizeof (del_64)); ptr += sizeof (del_64);
		Ref del_ref = {(long)(del_64 >> 32), (long)(del_64 & 0xffffffff)};
		index->Delete (&del_ref);
	}

	long old_perc = 0;
	new_count = *(long*) ptr; ptr += sizeof (new_count);
	for (i = 0; i < new_count; i++) {
		u_int64_t new_64;
		memcpy (&new_64, ptr, sizeof (new_64)); ptr += sizeof (new_64);
		Ref new_ref = {(long)(new_64 >> 32), (long)(new_64 & 0xffffffff)};
		long count = *(long*) ptr; ptr += sizeof (count);
		StorableSplaySet<KindCorrRef> to_add;
		for (int j = 0; j < count; j++) {
			KindCorrRef ref;
			memcpy (&ref, ptr, sizeof (ref)); ptr += sizeof (ref);
			to_add.add (ref);
		}
		Stream* str = index->Open (&new_ref, 1);
		if (str) {
			to_add.Put (str);
			index->Close (str);
		}
		long new_perc = (i * 50) / new_count;
		if (new_perc != old_perc) {
			old_perc = new_perc;
			screen->SetProgress (new_perc);
		}
	}

	chg_count = *(long*) ptr; ptr += sizeof (chg_count);
	for (i = 0; i < chg_count; i++) {
		u_int64_t chg_64;
		memcpy (&chg_64, ptr, sizeof (chg_64)); ptr += sizeof (chg_64);
		Ref chg_ref = {(long)(chg_64 >> 32), (long)(chg_64 & 0xffffffff)};
		StorableSplaySet<KindCorrRef> del_masks, add_masks;
		long del_count = *(long*) ptr; ptr += sizeof (del_count);
		for (long dels = 0; dels < del_count; dels++) {
			KindCorrRef mask;
			memcpy (&mask, ptr, sizeof (mask)); ptr += sizeof (mask);
			del_masks.add (mask);
		}
		long add_count = *(long*) ptr; ptr += sizeof (add_count);
		for (long adds = 0; adds < add_count; adds++) {
			KindCorrRef mask;
			memcpy (&mask, ptr, sizeof (mask)); ptr += sizeof (mask);
			add_masks.add (mask);
		}
		Stream* str = index->Open (&chg_ref);
		if (str) {
			StorableSplaySet<KindCorrRef> masks;
			masks.Get (str);
			masks.set_minus (&del_masks);
			masks.set_or (&add_masks);
			str->Seek (0);
			masks.Put (str);
			str->Trunc ();
			index->Close (str);
		}
		long new_perc = 50 + (i * 50) / chg_count;
		if (new_perc != old_perc) {
			old_perc = new_perc;
			screen->SetProgress (new_perc);
		}
	}

	gk_free (unpacked_data);
}

void	UnFull::RestoreReleFLaws ()
{
	Index* auxInd = m_pNewBase->FindIndex( "Aux" );
	logger.printf (lt_updateInfo, "Restore ReleFLaws\n");
	Stream* str = auxInd->Open (AUX_RELEF_LAWS);
	DocCollection to_put, to_del, to_add;
	if (str) {
		to_put.Get (str);
		auxInd->Close (str);
	}

	long del_count, add_count, i;
	DeltaRead (&del_count, 1, sizeof (del_count), m_DFile1);
	for (i = 0; i < del_count; i++) {
		long id;
		DeltaRead (&id, 1, sizeof (id), m_DFile1);
		to_del.Insert (&id);
	}

	DeltaRead (&add_count, 1, sizeof (add_count), m_DFile1);
	for (i = 0; i < add_count; i++) {
		long id;
		DeltaRead (&id, 1, sizeof (id), m_DFile1);
		to_add.Insert (&id);
	}
	to_put.Minus (to_del);
	to_put.Merge (to_add);
	auxInd->Delete (AUX_RELEF_LAWS);
	if (to_put.ItemCount) {
		Stream* str = auxInd->Open (AUX_RELEF_LAWS, 1);
		if (str) {
			to_put.Put (str);
			str->Trunc ();
			auxInd->Close (str);
		}
	}	
}

void	UnFull::RestoreTypingErrors ()
{
	m_pNewBase->load_typing_errors ();
	long del_count, add_count, i, size = 0;
	logger.printf (lt_updateInfo, "Restore TypingErrors\n");
	DeltaRead (&del_count, sizeof (del_count), 1 , m_DFile1);
	for (i = 0; i < del_count; i++) {
		std::string str;
		char read;
		DeltaRead (&read, 1, sizeof (read), m_DFile1);
		while (read) {
			str += read;
			DeltaRead (&read, 1, sizeof (read), m_DFile1);
		}
		std::map<std::string,std::string>::iterator it = m_pNewBase->typing_errors_ptr->find (str);
		if (it != m_pNewBase->typing_errors_ptr->end ())
			m_pNewBase->typing_errors_ptr->erase (it);
	}
	DeltaRead (&add_count, sizeof (add_count), 1 , m_DFile1);
	for (i = 0; i < add_count; i++) {
		std::string key, value;
		char read;
		DeltaRead (&read, 1, sizeof (read), m_DFile1);
		while (read) {
			key += read;
			DeltaRead (&read, 1, sizeof (read), m_DFile1);
		}
		DeltaRead (&read, 1, sizeof (read), m_DFile1);
		while (read) {
			value += read;
			DeltaRead (&read, 1, sizeof (read), m_DFile1);
		}
		m_pNewBase->typing_errors_ptr->insert (std::map<std::string,std::string>::value_type (key, value));
	}

	Index* auxInd = m_pNewBase->FindIndex( "Aux" );
	auxInd->Delete (AUX_TYPING_ERRORS);
	std::map<std::string,std::string>::const_iterator it;
	for (it = m_pNewBase->typing_errors_ptr->begin (); it != m_pNewBase->typing_errors_ptr->end (); it++)
		size += it->first.size () + it->second.size () + 2;
	if (size) {
		char *data = (char*) malloc (size), *ptr = data;
		for (it = m_pNewBase->typing_errors_ptr->begin (); it != m_pNewBase->typing_errors_ptr->end (); it++) {
			strcpy (ptr, it->first.c_str ());
			ptr += it->first.size () + 1;
			strcpy (ptr, it->second.c_str ());
			ptr += it->second.size () + 1;
		}
		Stream* str = auxInd->Open (AUX_TYPING_ERRORS, 1);
		str->Write (data, size);
		auxInd->Close (str);
		free (data);
	}
}

void	UnFull::RestoreGoodWords ()
{
	long del_count, add_count, i, size = 0;
	logger.printf (lt_updateInfo, "Restore GoodWords\n");
	DeltaRead (&del_count, sizeof (del_count), 1 , m_DFile1);
	for (i = 0; i < del_count; i++) {
		std::string str;
		char read;
		DeltaRead (&read, 1, sizeof (read), m_DFile1);
		while (read) {
			str += read;
			DeltaRead (&read, 1, sizeof (read), m_DFile1);
		}
		std::set<std::string>::iterator it = m_pNewBase->good_words_ptr->find (str);
		if (it != m_pNewBase->good_words_ptr->end ())
			m_pNewBase->good_words_ptr->erase (it);
	}

	DeltaRead (&add_count, sizeof (add_count), 1 , m_DFile1);
	for (i = 0; i < add_count; i++) {
		std::string str;
		char read;
		DeltaRead (&read, 1, sizeof (read), m_DFile1);
		while (read) {
			str += read;
			DeltaRead (&read, 1, sizeof (read), m_DFile1);
		}
		m_pNewBase->good_words_ptr->insert (str);
	}

	Index* auxInd = m_pNewBase->FindIndex ("Aux");
	auxInd->Delete (AUX_ERRORS_GOODWORDS);
	std::set<std::string>::const_iterator it;
	for (it = m_pNewBase->good_words_ptr->begin (); it != m_pNewBase->good_words_ptr->end (); it++)
		size += it->size () + 1;
	if (size) {
		char *data = (char*) malloc (size), *ptr = data;
		for (it = m_pNewBase->good_words_ptr->begin (); it != m_pNewBase->good_words_ptr->end (); it++) {
			strcpy (ptr, it->c_str ());
			ptr += strlen (ptr) + 1;
		}
		Stream* str = auxInd->Open (AUX_ERRORS_GOODWORDS, 1);
		str->Write (data, size);
		auxInd->Close (str);
		free (data);
	}
}

void	UnFull::RestoreMorphoHashes ()
{
	Index* auxInd = m_pNewBase->FindIndex( "Aux" );

	long addCount;
	logger.printf ( lt_updateInfo, "Restore MorphoHashes\n");
	DeltaRead (&addCount, sizeof (addCount), 1 , m_DFile1);

	long size = 0;
	char *strings = 0, *ptr;
	Stream* str = auxInd->Open (AUX_MORPHO_HASHES);
	if (str) {
		size = str->Length ();
		strings = (char*) malloc (size);
		str->Read (strings, size);
		auxInd->Close (str);
	}

	std::map<std::string, unsigned long> map_string_hash;
	for (ptr = strings; ptr - strings < size; ) {
		map_string_hash.insert (std::map<std::string, unsigned long>::value_type (ptr, *(unsigned long*)(ptr + strlen (ptr) + 1)));
		ptr += strlen (ptr) + 1 + sizeof (unsigned long);
	}

	for (int i = 0; i < addCount; i++) {
		std::string str;
		char read;
		DeltaRead (&read, 1, sizeof (read), m_DFile1);
		while (read) {
			str += read;
			DeltaRead (&read, 1, sizeof (read), m_DFile1);
		}
		unsigned long hash;
		DeltaRead (&hash, 1, sizeof (hash), m_DFile1);
		map_string_hash.insert (std::map<std::string, unsigned long>::value_type (str, hash));
	}

	gk_free (strings);
	size = 0;
	std::map<std::string, unsigned long>::const_iterator it;
	for (it = map_string_hash.begin (); it != map_string_hash.end (); it++)
		size += it->first.size () + 1 + sizeof (unsigned long);
	auxInd->Delete (AUX_MORPHO_HASHES);

	if (size) {
		strings = (char*) malloc (size);
		for (it = map_string_hash.begin (), ptr = strings; it != map_string_hash.end (); it++) {
			strcpy (ptr, it->first.c_str ());
			ptr += strlen (ptr) + 1;
			*(unsigned long*)ptr = it->second;
			ptr += sizeof (unsigned long);
		}

		Stream* str = auxInd->Open (AUX_MORPHO_HASHES, 1);
		if (str) {
			str->Write (strings, size);
			auxInd->Close (str);
		}
		gk_free (strings);
	}
	map_string_hash.clear ();
}

void	UnFull::RestoreCVar ()
{
	Index* auxInd = m_pNewBase->FindIndex( "Aux" );

	long delCount, addCount;
	logger.printf ( lt_updateInfo, "Restore CVar\n");
	DeltaRead (&delCount, sizeof (delCount), 1 , m_DFile1);
	DeltaRead (&addCount, sizeof (addCount), 1 , m_DFile1);

	if ( addCount + delCount ) {
		std::vector<long> del_positions, add_positions;
		std::vector<std::string> add_strings, old_vector;
		long i, read;
		for (i = 0; i < delCount; i++) {
			DeltaRead (&read, 1, sizeof (read), m_DFile1);
			del_positions.push_back (read);
		}
		for (i = 0; i < addCount; i++) {
			DeltaRead (&read, 1, sizeof (read), m_DFile1);
			add_positions.push_back (read);
		}
		for (i = 0; i < addCount; i++) {
			std::string str;
			char read;
			DeltaRead (&read, 1, sizeof (read), m_DFile1);
			while (read) {
				str += read;
				DeltaRead (&read, 1, sizeof (read), m_DFile1);
			}
			add_strings.push_back (str);
		}

		if (!b_cvarupdated) {
			long old_size = 0;
			char *old_strings = 0;
			Stream* str = auxInd->Open (AUX_CONTEXT_VARIANTS);
			if (str) {
				old_size = str->Length ();
				old_strings = (char*) malloc (old_size);
				str->Read (old_strings, old_size);
				auxInd->Close (str);
			}
			char *ptr = old_strings;
			if (old_size) while (ptr - old_strings < old_size) {
				old_vector.push_back (ptr);
				ptr += strlen (ptr)+1;
			}

			for (std::vector<long>::reverse_iterator rit = del_positions.rbegin (); rit != del_positions.rend (); rit++) {
				long del_pos = *rit;
				old_vector.erase (old_vector.begin () + del_pos);
			}
			std::vector<std::string>::const_iterator sit = add_strings.begin ();
			for (std::vector<long>::const_iterator it = add_positions.begin (); it != add_positions.end (); it++, sit++) {
				old_vector.insert (old_vector.begin () + *it, *sit);
			}

			long size = 0;
			for (sit= old_vector.begin (); sit != old_vector.end (); sit++)
				size += sit->size () + 1;
			auxInd->Delete (AUX_CONTEXT_VARIANTS);
			if (size) {
				char *data = (char*) malloc (size), *ptr = data;
				for (sit= old_vector.begin (); sit != old_vector.end (); sit++) {
					strcpy (ptr, sit->c_str ());
					ptr += strlen (ptr) + 1;
				}
				Stream* str = auxInd->Open (AUX_CONTEXT_VARIANTS, 1);
				if (str) {
					str->Write (data, size);
					auxInd->Close (str);
				}
				gk_free (data);
			}
			gk_free (old_strings);
		}
	}
	b_cvarupdated = true;
}

void	UnFull::RestoreSyns( char* key )
{
	Index* auxInd = m_pNewBase->FindIndex( "Aux" );

	long delCount, addCount;
	logger.printf ( lt_updateInfo, "Restore %s\n", key );
	logger.flush (lt_always);
	DeltaRead ( &delCount, sizeof (delCount), 1 , m_DFile1 );
	DeltaRead ( &addCount, sizeof (addCount), 1 , m_DFile1 );

	if ( addCount + delCount ) {
		std::map< std::string,GCL::StrSet > inbase, dels, adds;
		std::map< std::string,GCL::StrSet >::iterator iter, inbaseiter;

		Stream* str = auxInd->Open( key );
		if ( str ) {
			long size = str->Length();
			char* data = (char*) malloc( size );
			str->Read( data, size );
			auxInd->Close( str );

			char* ptr = data;
			long pos = 0;
			while ( pos < size ) {
				int length = strlen( ptr ) + 1;
				iter = inbase.insert( std::map< std::string, GCL::StrSet >::value_type( ptr, GCL::StrSet() )).first;
				pos += length;
				ptr += length;
				long syns = *(long*)ptr;
				ptr += sizeof( long );
				pos += sizeof( long );
				for ( long i = 0; i < syns; i++ ) {
					length = strlen( ptr ) + 1;
					iter->second.insert( ptr );
					ptr += length;
					pos += length;
				}
			}
			free( data );
		}

		if ( delCount ) {
			char* data = (char*) malloc( delCount );
			DeltaRead( data, delCount, 1 , m_DFile1 );
			char* ptr = data;
			long pos = 0;
			while ( pos < delCount ) {
				int length = strlen( ptr ) + 1;
				iter = dels.insert( std::map< std::string, GCL::StrSet >::value_type( ptr, GCL::StrSet() )).first;
				pos += length;
				ptr += length;
				long syns = *(long*)ptr;
				ptr += sizeof( long );
				pos += sizeof( long );
				for ( long i = 0; i < syns; i++ ) {
					length = strlen( ptr ) + 1;
					iter->second.insert( ptr );
					ptr += length;
					pos += length;
				}
			}
			free( data );
		}

		if ( addCount ) {
			char* data = (char*) malloc( addCount );
			DeltaRead( data, addCount, 1 , m_DFile1 );
			char* ptr = data;
			long pos = 0;
			while ( pos < addCount ) {
				int length = strlen( ptr ) + 1;
				iter = adds.insert( std::map< std::string, GCL::StrSet >::value_type( ptr, GCL::StrSet() )).first;
				pos += length;
				ptr += length;
				long syns = *(long*)ptr;
				ptr += sizeof( long );
				pos += sizeof( long );
				for ( long i = 0; i < syns; i++ ) {
					length = strlen( ptr ) + 1;
					iter->second.insert( ptr );
					ptr += length;
					pos += length;
				}
			}
			free( data );
		}

		//теперь надо взять inbase, добавить в него все из adds и удалить dels
		for ( iter = dels.begin(); iter != dels.end(); iter++ ) {
			std::string delkey = iter->first;
			inbaseiter = inbase.find( delkey );
			if (inbaseiter != inbase.end ()) {
				for ( GCL::StrSet::iterator it2 = iter->second.begin(); it2 != iter->second.end(); it2++ ) {
					std::string delvalue = (*it2);
					if (inbaseiter->second.find (delvalue) != inbaseiter->second.end ())
						inbaseiter->second.erase (inbaseiter->second.find (delvalue));
				}
			}
		}

		for ( iter = adds.begin(); iter != adds.end(); iter++ ) {
			std::string addkey = iter->first;
			inbaseiter = inbase.insert( std::map< std::string, GCL::StrSet >::value_type( addkey, GCL::StrSet() )).first;
			for ( GCL::StrSet::iterator it2 = iter->second.begin(); it2 != iter->second.end(); it2++ ) {
				inbaseiter->second.insert( (*it2));
			}
		}

		long size = 0;
		for ( inbaseiter = inbase.begin(); inbaseiter != inbase.end(); inbaseiter++ ) {
			if ( !inbaseiter->second.size())
				continue;
			size += inbaseiter->first.size() + 1;
			size += sizeof( long );
			GCL::StrSet::iterator it2 = inbaseiter->second.begin();
			for ( ; it2 != inbaseiter->second.end(); it2++ ) {
				size += (*it2).size() + 1;
			}
		}

		auxInd->Delete( key );
		if ( size ) {
			char *data = (char*) malloc( size ), *ptr = data;
			for ( inbaseiter = inbase.begin(); inbaseiter != inbase.end(); inbaseiter++ ) {
				if ( !inbaseiter->second.size())
					continue;
				strcpy( ptr, inbaseiter->first.c_str());
				ptr += inbaseiter->first.size() + 1;
				*(long*)ptr = inbaseiter->second.size();
				GCL::StrSet::iterator it2 = inbaseiter->second.begin();
				ptr += sizeof( long );
				for ( ; it2 != inbaseiter->second.end(); it2++ ) {
					strcpy( ptr, (*it2).c_str());
					ptr += (*it2).size() + 1;
				}
			}
			str = auxInd->Open( key, 1 );
			str->Write( data, size );
			auxInd->Close( str );
			gk_free (data);
		}
	}
}


///////////////////////////////////////////////////////////////////////////////

int	UnFull :: DocRestore ()
{
	if (!PrepareDeltaRestoring ())
		return 0;

	m_iReIndexDocName= m_iFullReIndexDocName = 0;
	b_newdoc = false;
	
	switch ( m_pAttrMask [0] & M_DOC_ORD ) {
	case O_DOC_CHG :
		{
		long delta_pos = 0, new_delta_pos = 0;
		if (b_show_extended_log) {
			if (delta_buffer)
				delta_pos = delta_buffer_ptr - delta_buffer_ptr;
			else
				mpcxc_fgetpos (m_DFile1, &delta_pos);
		}
		logger.printf ( lt_updateInfo, "Doc ID %ld - CHG\n", m_lDocId);
		if (b_flush_extended_log) logger.flush (lt_always);
		if ( m_pAttrMask [1] & M_STAT_NODOC ) {
			s_SkpDocs.insert (m_lDocId);
		}
		if ( m_pAttrMask [0] & M_TXT_CHG ){
			RestoreChgDoc ();
		} else {
			assert ( !m_pNewInfo );
			m_pNewInfo = ( DocInfo* ) malloc ( sizeof ( DocInfo ) );
			memcpy ( m_pNewInfo, m_pOldInfo, sizeof ( DocInfo ) );
			m_pNewInfo -> Revision = m_aDocRevision;
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
			ReplaceInfo++;
#else
			docInd->Replace ( m_lDocId, IDD_INFO, m_pNewInfo, sizeof ( DocInfo ) );
#endif
		}
		RestoreAttr ();
#ifdef MULTI_INDEX_STREAM_FILE
		if (((!(m_pOldInfo->Status & (DS_DOC|DS_EDITION)) || m_pAttrMask [0] & M_TXT_CHG) && m_pNewInfo->Status & (DS_DOC|DS_EDITION)) ||
			((!(m_pOldInfo->Status_ex & DS_MEDTOPIC) || m_pAttrMask [0] & M_TXT_CHG) && m_pNewInfo->Status_ex & DS_MEDTOPIC)){
			s_UpdDocs.insert (m_lDocId);
			m_AllPatchedAndNewDocsTextSize += m_pNewInfo->Size;
		}
#endif
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
		if(pTmpDoc && pTmpDoc->runs == m_pNewBase->new_runs){
			pTmpDoc->runs= 0;
			pTmpDoc->blocks= 0;
		}
#endif
		if (b_show_extended_log) {
			if (delta_buffer)
				new_delta_pos = delta_buffer_ptr - delta_buffer;
			else
				mpcxc_fgetpos (m_DFile1, &new_delta_pos);
			logger.printf (lt_updateInfo, "total: %ld bytes\n", new_delta_pos - delta_pos);
			if (b_flush_extended_log) logger.flush (lt_always);
		}
		}
		break;

	case O_DOC_NEW :
		b_newdoc = true;
		{
		long delta_pos = 0, new_delta_pos = 0;
		if (b_show_extended_log) {
			if (delta_buffer)
				delta_pos = delta_buffer_ptr - delta_buffer;
			else
				mpcxc_fgetpos (m_DFile1, &delta_pos);
		}
		logger.printf ( lt_updateInfo, "Doc ID %ld - NEW\n", m_lDocId);
		RestoreNewDoc ();
		RestoreAttr ();
#ifdef MULTI_INDEX_STREAM_FILE
		if ((m_pNewInfo->Status & (DS_DOC|DS_EDITION)) || (m_pNewInfo->Status_ex & DS_MEDTOPIC)){
			s_NewDocs.insert (m_lDocId);
			s_UpdDocs.insert (m_lDocId);
			m_AllPatchedAndNewDocsTextSize += m_pNewInfo->Size;

			//для случая "first removing, then add"
			s_DelDocs.erase (m_lDocId);
		}
#endif
		if (b_show_extended_log) {
			if (delta_buffer)
				new_delta_pos = delta_buffer_ptr - delta_buffer;
			else
				mpcxc_fgetpos (m_DFile1, &new_delta_pos);
			logger.printf (lt_updateInfo, "total: %ld bytes\n", new_delta_pos - delta_pos);
			if (b_flush_extended_log) logger.flush (lt_always);
		}
		}
		break;

	default : 
		logger.printf ( lt_fatal, "Unknown document order (%d)\n", m_pAttrMask [0] & M_DOC_ORD );
		_EXIT ( EXIT_FAILURE );
	}
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
	if(ReplaceInfo){
		ReplaceInfo= 0;
		if ( docInd->Replace ( m_lDocId, IDD_INFO, m_pNewInfo, sizeof (DocInfo) ) != sizeof (DocInfo) )
			logger.printf ( lt_error, "AttrIndex->Replase ( %ld, IDD_INFO,...) failed\n", m_lDocId );
	}
#endif

	// collect base infos
	if ( m_pAttrMask [2] & M_ATR_BAS ) { // (always for new docs)
		m_oldbases._add(0);
		m_newbases._add(0);
		CollectBaseInfo ( m_pOldInfo, 0, m_oldbases );
		CollectBaseInfo ( 0, m_pNewInfo, m_newbases );
	} else if ( m_pAttrMask [0] & ( M_ATR_INF | M_TXT_CHG ) ) {
		if ( m_oldbases.empty() ){
			if(docInd->Name[1] != 'T')
				docInd->Load ( m_lDocId, IDD_BASES, m_oldbases );
			else
				m_oldbases._add(1);
		}
		m_oldbases._add(0);
		CollectBaseInfo ( m_pOldInfo, m_pNewInfo, m_oldbases );
	}
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT) && !defined(NOT_NAME_DOC)
	if(m_iReIndexDocName || m_iFullReIndexDocName){
		if (s_UpdDocs.find (m_lDocId) == s_UpdDocs.end ()) {
			s_UpdDocs.insert (m_lDocId);
			if(m_pNewInfo)
				m_AllPatchedAndNewDocsTextSize += m_pNewInfo->Size;
			else
				m_AllPatchedAndNewDocsTextSize += m_pOldInfo->Size;
		}
	}
#endif

	if (delta_buffer) {
		gk_free (delta_buffer);
		delta_buffer = delta_buffer_ptr = 0;
	}

	return 1;
}

#define RESTORE_TEXT_DATA(_DocID_) \
{ \
	pTmpDoc->runs   = (PageRun*)m_pOldBase->LoadExRuns(_DocID_, pTmpDoc->RunCount, &pTmpDoc->runsStr); \
	pTmpDoc->blocks = (BlockRec*)m_pOldBase->LoadExBlocks(_DocID_, pTmpDoc->BlockCount, &pTmpDoc->blocksStr); \
	pTmpDoc->RunCount   /= sizeof ( PageRun ); \
	pTmpDoc->BlockCount /= sizeof ( BlockRec ); \
}

int UnFull :: PrepareDeltaRestoring ( )
{
	DeltaRead ( &m_lDocId, sizeof ( long ), 1, m_DFile1 );

	long Size = 0;
	if ( m_pOldInfo ) free ( m_pOldInfo );
	m_pOldInfo = (DocInfo*) docInd->Load ( m_lDocId, IDD_INFO, Size );
	if ( !m_pOldInfo || Size != sizeof ( DocInfo ) ) {
#ifdef QUICK_NEW_DOC
		if (!pTmpDoc){
			AttrKey first_Topic= { 0, IDD_INFO };
			BTIterator tmp_topic(docInd, &first_Topic);
			m_pOldInfo = (DocInfo*) docInd->Load ( ((AttrKey*)(tmp_topic.Key()))->DocId, IDD_INFO, Size );
			pTmpDoc = new Document(m_pOldBase, ((AttrKey*)(tmp_topic.Key()))->DocId, m_pOldInfo);
  #if defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
			RESTORE_TEXT_DATA(pTmpDoc->DocId);
  #endif
		}
#endif
		if ( m_pOldInfo ) free( m_pOldInfo );
		m_pOldInfo = 0;
		Size = 0;
	}
	if ( m_pNewInfo ) {
		free ( m_pNewInfo );
		m_pNewInfo = 0;
	}

	m_oldbases.clear();
	m_newbases.clear();

	long ulDeltaSize;
	long fptDeltaStart = 0;
	mpcxc_fgetpos ( m_DFile1 , &fptDeltaStart );
	DeltaRead ( &ulDeltaSize, sizeof ( ulDeltaSize ), 1, m_DFile1 );
	if (ulDeltaSize < 0) {
		//packed
		ulDeltaSize = -ulDeltaSize;
		long unpacked_size;
		DeltaRead (&unpacked_size, sizeof (unpacked_size), 1, m_DFile1);
		char mask;
		DeltaRead (&mask, 1, 1, m_DFile1);

		long packed_size = ulDeltaSize - sizeof (long) - 1 - sizeof (long);
		char* packed_buffer = (char*) malloc (packed_size);
		DeltaRead (packed_buffer, packed_size, 1, m_DFile1);
		delta_buffer = delta_buffer_ptr = (char*) malloc (unpacked_size);
		if (b_use_lzma) {
			size_t unp_size = unpacked_size, p_size = packed_size;
			Lzma86_Decode ((Byte*) delta_buffer, &unp_size, (Byte*) packed_buffer, &p_size);
		} else {
			G_UNZIP (packed_buffer, packed_size, delta_buffer, unpacked_size);
		}
		gk_free (packed_buffer);
	}

	ReadMaskLevels ();

	DeltaRead (&m_aDocRevision, sizeof (revision), 1, m_DFile1);

	int iSkipDoc = 0;

	m_dsm = m_dsm_inpharm = dsmStayNodoc;

	switch ( m_pAttrMask [0] & M_DOC_ORD ) {
	case O_DOC_CHG :
		revision NeededOldRevision;
		DeltaRead ( &NeededOldRevision, sizeof ( revision ), 1, m_DFile1 );

		if (!m_pOldInfo) {
			char buf [256];
			logger.printf ( lt_updateWarning, "Chg Doc %ld not presented in base yet (skipping, another delta must update it)\n", m_lDocId );
			logger.printf ( lt_updateWarning, "\tExist rev: NOT PRESENT, needed rev: %s, new rev: %s\n", sprintRev ( buf, &NeededOldRevision ), sprintRev ( buf+64, &m_aDocRevision ) );
		} else {
			if ( m_pOldInfo->Status & DS_DOC )
				m_dsm = dsmStayDoc;
			else
				m_dsm = dsmStayNodoc;

			if ( m_pOldInfo->Status_ex & DS_MEDTOPIC )
				m_dsm_inpharm = dsmStayDoc;
			else
				m_dsm_inpharm = dsmStayNodoc;

			if ( CompRevs ( &NeededOldRevision, &m_pOldInfo->Revision ) ) {
				char buf [256];
				if ( CompRevs ( &m_aDocRevision, &m_pOldInfo->Revision ) <= 0 )
					logger.printf ( lt_updateWarning, "Chg Doc %ld already updated (skipping)\n", m_lDocId );
				else 
					logger.printf ( lt_updateWarning, "Chg Doc %ld has diferent revision then needed (skipping, another delta must update it)\n", m_lDocId );

				logger.printf ( lt_updateWarning, "\tExist rev: %s, needed rev: %s, new rev: %s\n",
					sprintRev ( buf, &m_pOldInfo->Revision ), 
					sprintRev ( buf+64, &NeededOldRevision ),
					sprintRev ( buf+128, &m_aDocRevision ) );
				
				iSkipDoc = 1;
			}
		}
		break;

	case O_DOC_NEW :
		if ( m_pOldInfo ) { 
			// Document alredy exist in old base
			char buf [256];

			if ( CompRevs ( &m_aDocRevision, &m_pOldInfo->Revision ) <= 0 ) {
				iSkipDoc = 1;
				logger.printf ( lt_updateWarning, "New Doc %ld already exist and it's same or newer (skipping)\n", m_lDocId );
				logger.printf ( lt_updateWarning, "\tExist rev: %s, needed rev: NEW DOC, new rev: %s\n", sprintRev ( buf, &m_pOldInfo->Revision ), sprintRev ( buf+128, &m_aDocRevision ) );
			} else {
				logger.printf ( lt_updateWarning, "New Doc %ld already exist and it's older (first removing, and then add)\n", m_lDocId );
				logger.printf ( lt_updateWarning, "\tExist rev: %s,  needed rev: NEW DOC, new rev: %s\n", sprintRev ( buf, &m_pOldInfo->Revision ), sprintRev ( buf+128, &m_aDocRevision ) );

				if (m_pOldInfo->Status & (DS_DOC|DS_EDITION))
					s_DelDocs.insert (m_lDocId);

				StorableSplaySet<short> segs;
				segs._add(0);
				docInd->Load ( m_lDocId, IDD_BASES, segs );
				CollectBaseInfo ( m_pOldInfo, 0, segs );

				{
				long SubCount;
				SubDesc* subs = (SubDesc*) docInd->Load (m_lDocId, IDD_SUBS, SubCount);
				for (int i = 0; i < SubCount / sizeof (SubDesc); i++) {
					char oldsubname [SUB_NAME_SIZE * 2];
					long sub = subs [i].Sub, length = m_pOldBase->FindSubName (m_lDocId, sub, oldsubname);
					if (length)
						addsubnames.insert (std::map<long,std::string>::value_type (sub, oldsubname));
				}
				}

				FullDelDoc ();
				
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
				m_pOldInfo->ParaCount= 0;
#endif
			}
		}
		break;
	}
#ifdef SKIP_TO_DOCID
	if ( m_lDocId != SKIP_TO_DOCID ) iSkipDoc = 1;
#endif

	if ( iSkipDoc ) {
		if (delta_buffer) {
			gk_free (delta_buffer);
			delta_buffer = delta_buffer_ptr = 0;
		} else {
			fseek ( m_DFile1, (long)fptDeltaStart, ACE_OS_SEEK_SET );
			fseek ( m_DFile1, ulDeltaSize, ACE_OS_SEEK_CUR );
		}
		return 0;
	}

	return 1;
}

int UnFull :: SetBaseRevision ( int n, revision aNewRev )
{
	BaseInfo aBaseInfo;

	if ( m_pNewBase -> FindBaseInfo ( n, aBaseInfo ) != sizeof ( BaseInfo ) ) {
		logger.printf ( lt_fatal, "Can't open BaseInfo for %d segment\n", n );
		return 0;
	}

	aBaseInfo.LastUpdate = aNewRev;

	if ( m_pNewBase -> ReplaceBaseInfo ( n, &aBaseInfo ) != sizeof ( BaseInfo ) ) {
		logger.printf ( lt_fatal, "Can't replase BaseInfo for %d segment\n", n );
		return 0;
	}

	return sizeof ( BaseInfo );
}

void UnFull::ReadMaskLevels ()
{
	int i = 0;
	gk_bzero ( m_pAttrMask, MAX_LEVEL );

	do
	{
		if ( i >= MAX_LEVEL ) {
			logger.printf ( lt_fatal, "Bad mask levels count (%d)\n", i );
			_EXIT ( EXIT_FAILURE );
		}
		DeltaRead ( &m_pAttrMask [i], 1, 1, m_DFile1 );
	}
	while ( m_pAttrMask [i++] & M_ATR_NLE );

	m_iLevelCount = i;
}

void UnFull :: RestoreNewDoc ()
{
	long lParaCount;
	DeltaRead ( &lParaCount, sizeof ( long ), 1, m_DFile1 );

	if(pNewDocN){
		delete pNewDocN;
		pNewDocN = make_GU_Doc ( "New Doc under Construction", PM_ZIP | PM_NOT_STORE_INFO, &s_UpdDocs );
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
		if(pTmpDoc) {
			pTmpDoc->runs= 0;
			pTmpDoc->blocks= 0;
		}
#endif
	}else
		pNewDocN = make_GU_Doc ( "New Doc under Construction", PM_ZIP | PM_NOT_STORE_INFO, &s_UpdDocs );
	pNewDocN->pDoc= pTmpDoc;
	if(pTmpDoc && pTmpDoc->DocId == m_lDocId){
		pNewDocN->m_pRunCount= &pTmpDoc->m_RunCount;
		pNewDocN->m_pBlockCount= &pTmpDoc->m_BlockCount;
	}
	assert ( pNewDocN );
	for ( long l = 0; l < lParaCount; l++ ) {
		short sParaSize;
		DeltaRead ( &sParaSize, sizeof ( short ), 1, m_DFile1 ); // para SIZE

		char* pParaBuff = (char*) malloc ( sParaSize + 1 );
		assert ( pParaBuff );

		if ( DeltaRead ( pParaBuff, 1, sParaSize, m_DFile1 ) != (size_t) sParaSize ) {
			logger.printf ( lt_fatal, "Ошибка чтения файла дельты\n" );
			_EXIT ( EXIT_FAILURE );
		}

		char cParaStyle = ParaStyle ( pParaBuff );

		assert ( sParaSize - 3 >= 5 );

		pNewDocN->AddPara ( cParaStyle, sParaSize - 3, & pParaBuff [3] );
		free ( pParaBuff );
	}
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
	m_pNewInfo= pNewDocN->pInfo;
	m_pNewInfo->ParaCount= pNewDocN->ParaCount;
	if(m_pOldInfo)
		m_pOldInfo->ParaCount= 0;
#endif
	//delete pNewDocN;
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
#else
	long size;
	m_pNewInfo = (DocInfo*) docInd->Load ( m_lDocId, IDD_INFO, size );
	if ( !m_pNewInfo || size != sizeof ( DocInfo ) ) {
		logger.printf ( lt_fatal, "Ошибка создания документа\n" );
		_EXIT ( EXIT_FAILURE );
	}
#endif
}

static unsigned char localDos2WinTable[ 256 ] = {
/*0-*/		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0xA4,
/*16-*/		0x10, 0x11, 0x12, 0x13, 0xB6, 0xA7, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
/*32-*/		0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
/*48-*/		0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
/*64-*/		0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
/*80-*/		0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
/*96-*/		0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
/*112-*/	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F,
/*128-*/	0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xCB, 0xCC, 0xCD, 0xCE, 0xCF,
/*144-*/	0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xDB, 0xDC, 0xDD, 0xDE, 0xDF,
/*160-*/	0xE0, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xEB, 0xEC, 0xED, 0xEE, 0xEF,
/*176-*/	0x5F, 0x5F, 0x5F, 0xA6, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F,
/*192-*/	0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F,
/*208-*/	0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0xA6, 0x5F, 0x5F,
/*224-*/	0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE, 0xFF,
/*240-*/	0xA8, 0xB8, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0xB0, 0xB7, 0xB7, 0x5F, 0xB9, 0xB1, 0xA8, 0xA0 
};

void	localDos2Win( char* aBuffer, long aLen )
{
	for ( long I = 0; I < aLen; I++, aBuffer++ ) {
		*aBuffer = localDos2WinTable[ (unsigned char)(*aBuffer) ];
	}
}

#include "shared/ContextSearch/Common/Constants.h"

class TmpUpdtDoc : public TempDoc
{
public :
	TmpUpdtDoc( Base* base= 0, long docId= 0, Document **ppDoc= 0, DocInfo* pDocINFO= 0):TempDoc()
	{
		assert(pDocINFO);
		m_stat= *pDocINFO;
		Document* pDoc;
		if(!(pDoc= *ppDoc)){
			pDoc = (*ppDoc= base->GetDoc(docId, pDocINFO));
			pDoc->FreeStructs ();
		}else{
			pDoc->Stat= *pDocINFO;
			pDoc->FreeStructs ();
			pDoc->Reset();
			pDoc->DocId = docId;
		}
		pDoc->runs   = (PageRun*)base ->LoadExRuns(docId, pDoc->RunCount, &pDoc->runsStr);
		pDoc->blocks = (BlockRec*)base ->LoadExBlocks(docId, pDoc->BlockCount, &pDoc->blocksStr);
		pDoc->RunCount   /= sizeof ( PageRun );
		pDoc->BlockCount /= sizeof ( BlockRec );

		InitStatus(pDoc);
		if(!m_pGParaArray){
			m_pGParaArray = (void**) malloc ( ContextSearch::POS_TEXT * sizeof ( void* ) );
			m_pGParaArray [0] = malloc ( m_iGTextAlloc );
		}
		CopyAllText(pDoc);
	}
	virtual ~TmpUpdtDoc(){
	}
	virtual void **getParaArray(){
		return m_pGParaArray;
	}
protected :
	virtual  int getLocalTextAlloc(){
		return m_iGTextAlloc;
	}
	virtual  int setLocalTextAlloc(int newV){
		return (m_iGTextAlloc= newV);
	}
};

void UnFull::RestoreChgDoc ()
{
	long	lOldParaCount = m_pOldInfo -> ParaCount;
	NewDoc_GU	*pNewDoc= 0;

	if(pNewDocN){
		delete pNewDocN;
		pNewDoc= make_GU_Doc( m_pOldInfo->Title, PM_ZIP | PM_NOT_STORE_INFO | PM_NOT_STORE_PARAINFO, &s_UpdDocs);
		pNewDocN= 0;
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
		if(pTmpDoc) {
			pTmpDoc->runs= 0;
			pTmpDoc->blocks= 0;
		}
#endif
	}
	TempDoc *pTempDoc= new TmpUpdtDoc ( m_pOldBase, m_lDocId, &pTmpDoc, m_pOldInfo );
	assert ( pTempDoc );

	m_pOldBase->DelText( m_lDocId, pTmpDoc->runs, pTmpDoc->RunCount, pTmpDoc->blocks, pTmpDoc->BlockCount );
	if(!pNewDoc)
		pNewDoc= make_GU_Doc( m_pOldInfo->Title, PM_ZIP | PM_NOT_STORE_INFO | PM_NOT_STORE_PARAINFO, &s_UpdDocs);
	assert ( pNewDoc );

	long	lParaCount;
	DeltaRead ( &lParaCount, sizeof ( long ), 1, m_DFile1 );

	int bEvd = pTempDoc->m_Status & DS_EVD;		

	long	lOldParaPos = 0;
	for ( long lNewParaPos = 0; lNewParaPos < lParaCount; lNewParaPos++ ) {
		long	lEquNum;
		long	lMovOfs;

		short	sTextSize, sNewTextSize, sBuffSize;
		char	cParaOrder, cHeaderOrder;
		char	cParaStyle;
		char	*pPara, * pNewPara, * pParaText;
		char	*pParaBuff = 0;

		DeltaRead( &cParaOrder, sizeof ( char ), 1, m_DFile1 );

		cHeaderOrder = cParaOrder & M_ORD_HDR;
		cParaOrder   = cParaOrder & M_ORD_PAR;

		// READ NEW HEADER MEMBER

		ParaHeader	aHeader;
		gk_bzero ( (char*)(&aHeader), sizeof ( ParaHeader ) );

		if ( cHeaderOrder & O_HDR_STYLE   ) DeltaRead ( &aHeader.cStyle  , sizeof ( char  ), 1, m_DFile1 );
		if ( cHeaderOrder & O_HDR_TSTART  ) DeltaRead ( &aHeader.sTStart , sizeof ( short ), 1, m_DFile1 );
		if ( cHeaderOrder & O_HDR_LMARGIN ) DeltaRead ( &aHeader.cLMargin, sizeof ( char  ), 1, m_DFile1 );
		if ( cHeaderOrder & O_HDR_RMARGIN ) DeltaRead ( &aHeader.cRMargin, sizeof ( char  ), 1, m_DFile1 );
		if ( cHeaderOrder & O_HDR_REDLINE ) DeltaRead ( &aHeader.cRedLine, sizeof ( char  ), 1, m_DFile1 );

		short	headerSize = 0;
		char*	evdHeader = 0;
		if ( cHeaderOrder & O_HDR_EVD ) {
			DeltaRead( &headerSize, sizeof( short ), 1, m_DFile1 );
			evdHeader = (char*) malloc( headerSize );
			DeltaRead( evdHeader, headerSize, 1, m_DFile1 );
		}

		// RESTORE PARA BY DIF ORDER

		switch ( cParaOrder ) {
			case O_PAR_EQU : {
				//текст параграфа может не измениться, а вот evd-оформление может

				if ( cHeaderOrder )
					lEquNum = 1;
				else
					DeltaRead ( &lEquNum, sizeof( long ), 1, m_DFile1 );

				if ( headerSize ) {
					//прочитать старый текст параграфа, добавить его к новому header и записать в документ
					pPara = (char*) pTempDoc->GetPara( lOldParaPos );
					short oldsize = pTempDoc->EVDTextSize( pPara );
					char* oldtext = pTempDoc->EVDParaText( pPara );
					pNewPara = (char*) malloc( oldsize + 1 + headerSize + HEADER_SIZE );
					memcpy( pNewPara, pPara, HEADER_SIZE );

					if ( *(long*)evdHeader & ENDT_SBS ) {
						sNewTextSize = oldsize;
						char* text = oldtext;
						short part1Len = ENDT_FLAGS_LEN + ENDT_CP_LEN + ( *(long*)evdHeader & ENDT_HAS_BMP ? sizeof( long ) : 0 );
						part1Len += *(long*)(evdHeader + part1Len ) + sizeof( long ) + sizeof( long );
						memcpy( &pNewPara[ HEADER_SIZE ], evdHeader, headerSize );
						if ( *( short*)(evdHeader+ENDT_FLAGS_LEN) == CP_ANSI )
							localDos2Win( text, sNewTextSize );
						short text1Len = *(long*)(evdHeader+part1Len-sizeof(long));
						memcpy( pNewPara + HEADER_SIZE + part1Len, text, text1Len );
						short part2Len = headerSize - part1Len;
						char* evdHeader2 = evdHeader + part1Len;
						short text2Len   = *(long*)(evdHeader2 + *(long*)evdHeader2 + sizeof( long ));
						memcpy( pNewPara + HEADER_SIZE + part1Len + text1Len, evdHeader2, part2Len );
						memcpy( pNewPara + HEADER_SIZE + part1Len + text1Len + part2Len, text + sNewTextSize - text2Len, text2Len );
						*(pNewPara + HEADER_SIZE + headerSize + sNewTextSize-1)= '\0';
					} else {
						memcpy( pNewPara + HEADER_SIZE, evdHeader, headerSize );
						memcpy( pNewPara + HEADER_SIZE + headerSize, oldtext, oldsize );
						if ( *( short*)(evdHeader+ENDT_FLAGS_LEN) == CP_ANSI )
							localDos2Win( pNewPara + HEADER_SIZE + headerSize, oldsize );
						*(pNewPara + HEADER_SIZE + headerSize + oldsize) = '\0';
						headerSize++;
					}
					pParaBuff = RestoreParaHeader( pNewPara, aHeader, cHeaderOrder );
					SetTextSize( pNewPara, oldsize + headerSize );
					cParaStyle = ParaStyle( pNewPara );

					sBuffSize = ParaSize ( pNewPara );
					assert ( sBuffSize >= 5 );

					pNewDoc->AddPara ( cParaStyle, sBuffSize, pParaBuff );

					free( pNewPara );

					lOldParaPos++;
				} else {
					for ( long l = 0; l < lEquNum; l++ ) {
						assert ( lOldParaPos < lOldParaCount );
						pPara = (char*) pTempDoc->GetPara ( lOldParaPos );
						assert ( pPara );

						pParaBuff  = RestoreParaHeader ( pPara, aHeader, cHeaderOrder );
						sBuffSize  = ParaSize ( pPara );
						cParaStyle = ParaStyle ( pPara );

						assert( sBuffSize >= 5 );
						pNewDoc->AddPara( cParaStyle, sBuffSize, pParaBuff );

						lOldParaPos++;
					}
				}
				lNewParaPos += lEquNum - 1;
			}
			break;

			case O_PAR_MOV :

				DeltaRead ( &lMovOfs, sizeof ( long ), 1, m_DFile1 );

				lOldParaPos += lMovOfs - 1;

				assert ( lOldParaPos >= 0 );

				pPara = (char*) pTempDoc->GetPara ( lOldParaPos );
				assert ( pPara );

				if ( headerSize ) {
					//скопировать старый текст, записать новый evdHeader
					short oldsize = pTempDoc->EVDTextSize( pPara );
					char* oldtext = pTempDoc->EVDParaText( pPara );
					pNewPara = (char*) malloc( oldsize + 1 + headerSize + HEADER_SIZE );
					memcpy( pNewPara, pPara, HEADER_SIZE );

					if ( *(long*)evdHeader & ENDT_SBS ) {
						sNewTextSize = oldsize;
						char* text = oldtext;
						short part1Len = ENDT_FLAGS_LEN + ENDT_CP_LEN + ( *(long*)evdHeader & ENDT_HAS_BMP ? sizeof( long ) : 0 );
						part1Len += *(long*)(evdHeader + part1Len ) + sizeof( long ) + sizeof( long );
						memcpy( &pNewPara[ HEADER_SIZE ], evdHeader, headerSize );
						if ( *( short*)(evdHeader+ENDT_FLAGS_LEN) == CP_ANSI )
							localDos2Win( text, sNewTextSize );
						short text1Len = *(long*)(evdHeader+part1Len-sizeof(long));
						memcpy( pNewPara + HEADER_SIZE + part1Len, text, text1Len );
						short part2Len = headerSize - part1Len;
						char* evdHeader2 = evdHeader + part1Len;
						short text2Len   = *(long*)(evdHeader2 + *(long*)evdHeader2 + sizeof( long ));
						memcpy( pNewPara + HEADER_SIZE + part1Len + text1Len, evdHeader2, part2Len );
						memcpy( pNewPara + HEADER_SIZE + part1Len + text1Len + part2Len, text + sNewTextSize - text2Len, text2Len );
						*(pNewPara + HEADER_SIZE + headerSize + sNewTextSize-1)= '\0';
					} else {
						//скопировать старый текст, записать новый evdHeader
						memcpy( pNewPara + HEADER_SIZE, evdHeader, headerSize );
						memcpy( pNewPara + HEADER_SIZE + headerSize, oldtext, oldsize );
						if ( *( short*)(evdHeader+ENDT_FLAGS_LEN) == CP_ANSI )
							localDos2Win( pNewPara + HEADER_SIZE + headerSize, oldsize );
						*(pNewPara + HEADER_SIZE + headerSize + oldsize) = '\0';
						headerSize++;
					}
					pParaBuff = RestoreParaHeader( pNewPara, aHeader, cHeaderOrder );
					SetTextSize( pNewPara, oldsize + headerSize );
					cParaStyle = ParaStyle( pNewPara );

					sBuffSize = ParaSize ( pNewPara );
					assert ( sBuffSize >= 5 );

					pNewDoc->AddPara ( cParaStyle, sBuffSize, pParaBuff );

					free( pNewPara );
				} else {
					pParaBuff = RestoreParaHeader ( pPara, aHeader, cHeaderOrder );
					cParaStyle = ParaStyle ( pPara );
					sBuffSize = ParaSize ( pPara );

					assert ( sBuffSize >= 5 );
					pNewDoc->AddPara ( cParaStyle, sBuffSize, pParaBuff );
				}

				lOldParaPos ++;

				break;

			case O_PAR_CHG : {
				DeltaRead ( &lMovOfs, sizeof ( long ), 1, m_DFile1 );
				lOldParaPos += lMovOfs - 1;

				DeltaRead ( &sNewTextSize, sizeof ( short ), 1, m_DFile1 );

				pPara = (char*) pTempDoc->GetPara ( lOldParaPos );
				assert ( pPara );

				if ( bEvd && !headerSize ) {
					//изменился только текст, а оформление - не менялось. Прочитать старое оформление
					headerSize = pTempDoc->EVDHeaderSize( pPara );
					evdHeader = (char*)malloc( headerSize );
					memcpy( evdHeader, pTempDoc->EVDHeader( pPara ), headerSize );
				}

				pParaText = bEvd ? pTempDoc->EVDParaText( pPara ) : ParaText ( pPara );
				sTextSize = bEvd ? pTempDoc->EVDTextSize( pPara ) : TextSize ( pPara );

				Word* pOldWords = CreatWordFromMem ( pParaText, sTextSize, 0, pBUF);
				Word* pNewWords = 0;
				assert ( pOldWords );

				CCr [0] = 1;

				DiffHandler aTextDiff ( pOldWords, pNewWords, 0 );
				if (delta_buffer_ptr)
					pNewWords = aTextDiff.MakeUnDiff (delta_buffer_ptr);
				else
					pNewWords = aTextDiff.MakeUnDiff (m_DFile1, m_DFile1);

				CCr [0] = 0; // ????
				if ( pOldWords )
					delete [] pOldWords;

				pOldWords = 0;

				CCr [0] = 1; // ????

				pNewPara = (char*) malloc ( sNewTextSize + 1 + headerSize + HEADER_SIZE );
				assert ( pNewPara );

				memcpy ( pNewPara, pPara, HEADER_SIZE );

				if ( headerSize ) {
					if ( *(long*)evdHeader & ENDT_SBS ) {
						short part1Len = ENDT_FLAGS_LEN + ENDT_CP_LEN + ( *(long*)evdHeader & ENDT_HAS_BMP ? sizeof( long ) : 0 );
						part1Len += *(long*)(evdHeader + part1Len ) + sizeof( long ) + sizeof( long );
						memcpy( &pNewPara[ HEADER_SIZE ], evdHeader, headerSize );
						char* text = new char[ sNewTextSize ];
						CopyToMem( pNewWords, text, sNewTextSize );
						if ( *( short*)(evdHeader+ENDT_FLAGS_LEN) == CP_ANSI )
							localDos2Win( text, sNewTextSize );
						short text1Len = *(long*)(evdHeader+part1Len-sizeof(long));
						memcpy( pNewPara + HEADER_SIZE + part1Len, text, text1Len );
						short part2Len = headerSize - part1Len;
						char* evdHeader2 = evdHeader + part1Len;
						short text2Len   = *(long*)(evdHeader2 + *(long*)evdHeader2 + sizeof( long ));
						memcpy( pNewPara + HEADER_SIZE + part1Len + text1Len, evdHeader2, part2Len );
						memcpy( pNewPara + HEADER_SIZE + part1Len + text1Len + part2Len, text + sNewTextSize - text2Len, text2Len );
						*(pNewPara + HEADER_SIZE + headerSize + sNewTextSize-1)= '\0';
						delete text;
					} else {
						memcpy( &pNewPara[ HEADER_SIZE ], evdHeader, headerSize );
						CopyToMem( pNewWords, pNewPara + HEADER_SIZE + headerSize, sNewTextSize );
						if ( *( short*)(evdHeader+ENDT_FLAGS_LEN) == CP_ANSI )
							localDos2Win( pNewPara + HEADER_SIZE + headerSize, sNewTextSize );
						*(pNewPara + HEADER_SIZE + headerSize + sNewTextSize)= '\0';
						headerSize++;
					}
				} else {
					CopyToMem( pNewWords, &pNewPara[ HEADER_SIZE ], sNewTextSize );
				}

				pParaBuff = RestoreParaHeader( pNewPara, aHeader, cHeaderOrder );
				SetTextSize( pNewPara, sNewTextSize + headerSize );
				cParaStyle = ParaStyle( pNewPara );

				sBuffSize = ParaSize ( pNewPara );

				assert ( sBuffSize >= 5 );

				pNewDoc->AddPara ( cParaStyle, sBuffSize, pParaBuff );

				if ( pNewWords )
					delete [] pNewWords;

				pNewWords = 0;

				free ( pNewPara );

				CCr [0] = 0; // ????

				lOldParaPos ++;
			}
			break;

			case O_PAR_NEW :

				DeltaRead ( &sNewTextSize, sizeof ( short ), 1, m_DFile1 );

				pNewPara = (char*) malloc ( sNewTextSize + 1 + HEADER_SIZE );
				assert ( pNewPara );

				pParaBuff = RestoreParaHeader ( pNewPara, aHeader, cHeaderOrder );

				SetTextSize ( pNewPara, sNewTextSize );

				if ( DeltaRead ( & pNewPara [ HEADER_SIZE ], 1, sNewTextSize, m_DFile1 ) != (size_t)sNewTextSize ) {
					logger.printf ( lt_fatal, "Ошибка чтения файла дельты\n" );
					_EXIT (	EXIT_FAILURE );
				}

				cParaStyle = ParaStyle ( pNewPara );
				sBuffSize = ParaSize ( pNewPara );

				assert ( sBuffSize >= 5 );

				pNewDoc->AddPara( cParaStyle, sBuffSize, pParaBuff );

				free ( pNewPara );

				break;

			default :
				logger.printf ( lt_fatal, "Unknown paragraph order\n" );
				_EXIT ( EXIT_FAILURE );
		}

		if ( evdHeader )
			free( evdHeader );
	}
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
	m_pNewInfo= pNewDoc->pInfo;
	m_pNewInfo->ParaCount= pNewDoc->ParaCount;
	pNewDoc->runsStr= pTmpDoc->runsStr;pTmpDoc->runsStr= 0;
	pNewDoc->blocksStr= pTmpDoc->blocksStr;pTmpDoc->blocksStr= 0;
	pNewDoc->m_pRunCount= &pTmpDoc->m_RunCount;
	pNewDoc->m_pBlockCount= &pTmpDoc->m_BlockCount;
#endif
	delete pNewDoc;
	pNewDoc= 0;
	m_pTempDocGlobalBuff= pTempDoc->getParaArray();
	delete pTempDoc;
	pTempDoc= 0;

#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
#else
	// Replace IDD_INFO WITH CORRECT Status
	long iNewSize = 0;
	assert ( !m_pNewInfo );
	m_pNewInfo = (DocInfo*) docInd->Load ( m_lDocId, IDD_INFO, iNewSize );
	if ( iNewSize != sizeof ( DocInfo ) ) {
		logger.printf ( lt_fatal, "Can't read old IDD_INFO for doc %ld\n", m_lDocId );
		_EXIT ( EXIT_FAILURE );
	}
#endif
	m_pNewInfo->FirstDate = m_pOldInfo->FirstDate;
	m_pNewInfo->LastDate = m_pOldInfo->LastDate;
	m_pNewInfo->Force = m_pOldInfo->Force;
	m_pNewInfo->HyperRefs = m_pOldInfo->HyperRefs;
	m_pNewInfo->GreenComments = m_pOldInfo->GreenComments;
	m_pNewInfo->Status = m_pOldInfo->Status;
	m_pNewInfo->Status_ex = m_pOldInfo->Status_ex;
	SetDocStatusExEx (m_pNewInfo, GetDocStatusExEx (m_pOldInfo));
	m_pNewInfo->Related = m_pOldInfo->Related;
	m_pNewInfo->nextEdition = m_pOldInfo->nextEdition;
	m_pNewInfo->prevEdition = m_pOldInfo->prevEdition;
	m_pNewInfo->reserved_short = m_pOldInfo->reserved_short;
	m_pNewInfo->reserved_short2= m_pOldInfo->reserved_short2;
	m_pNewInfo->long_respondents = m_pOldInfo->long_respondents;
	m_pNewInfo->hi_long_respondents = m_pOldInfo->hi_long_respondents;
	m_pNewInfo->lastParaID = m_pOldInfo->lastParaID;
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
	ReplaceInfo++;
#else
	docInd->Replace ( m_lDocId, IDD_INFO, m_pNewInfo, sizeof ( DocInfo ) );
#endif
}

std::deque<Ref> add_subnames, del_subnames;
std::deque<char*> add_subnames_chars;
std::deque<long> add_subnames_sizes;

void	UnFull::add_subname (Ref ref, char* name, int length)
{
	add_subnames.push_back (ref);
	char* subname = new char [length];
	memcpy (subname, name, length);
	add_subnames_chars.push_back (subname);
	add_subnames_sizes.push_back (length);
}

void	UnFull::del_subname (Ref ref)
{
	del_subnames.push_back (ref);
}

int UnFull::RestoreAttr ()
{
	//ACE_hrtime_t m_start_count = Core::GDS::HiResCounterSingl::instance()->get_count ();

	// first level (maximum 5 bits -xxxxx--)
	if ( m_pAttrMask [0] & M_ATR_DAT ) TagAttrRestore ( m_lDocId, IDD_DATE, "IDD_DATE");
	if ( m_pAttrMask [0] & M_ATR_VCH ) TagAttrRestore ( m_lDocId, IDD_VCHANGED, "IDD_VCHANGED");
	if ( m_pAttrMask [0] & M_ATR_INF ) TagAttrRestore ( m_lDocId, IDD_INFO, "IDD_INFO");
	if ( m_pAttrMask [0] & M_ATR_KEY ) TagAttrRestore ( m_lDocId, IDD_KEY, "IDD_KEY");

	// second level (maximum 7 bits -xxxxxxx)
	if ( m_pAttrMask [1] & M_ATR_SUBSEX ) TagAttrRestore ( m_lDocId, IDD_SUBS_EX, "IDD_SUBS_EX");
	if ( m_pAttrMask [1] & M_ATR_TYP ) TagAttrRestore ( m_lDocId, IDD_TYPE, "IDD_TYPE");
	if ( m_pAttrMask [1] & M_ATR_SRC ) TagAttrRestore ( m_lDocId, IDD_SOURCE, "IDD_SOURCE"); // first pair (class)
	if ( m_pAttrMask [1] & M_ATR_TER ) TagAttrRestore ( m_lDocId, IDD_TERRITORY, "IDD_TERRITORY"); // first pair (prefix)
	/*
	else if ( m_pAttrMask [1] & M_ATR_SRC ) { // class pair changed only
		if ( !m_pOldClass || ! m_pNewClass ) {
			logger.printf ( lt_fatal, "Class pair not stored (tag %d)\n", IDD_TERRITORY );
			_EXIT ( EXIT_FAILURE );
		}
		CorrectPairIndex ( m_pOldClass, m_pNewClass, 0, 0, IDD_TERRITORY );
		delete m_pOldClass;
		m_pOldClass = 0;
		delete m_pNewClass;
		m_pNewClass = 0;
	}
	*/
	if ( m_pAttrMask [1] & M_ATR_IND_RESP ) RestoreRefInd (m_lDocId);
	
	// third level (maximum 7 bits -xxxxxxx)
	if ( m_pAttrMask [2] & M_ATR_BAS )
		TagAttrRestore ( m_lDocId, IDD_BASES, "IDD_BASES");
	else if ( m_dsm == dsmChgToNodoc || m_dsm == dsmChgToDoc ) {
		docInd->Load ( m_lDocId, IDD_BASES, m_oldbases );
			
		for ( Point p = m_oldbases.first (); p; m_oldbases.next (p) ) {
			if ( m_dsm == dsmChgToNodoc ) 
				DelSegmentDoc ( SelectIndex ( IDD_BASES ), &m_oldbases.contents(p), m_lDocId );
			else
				AddSegmentDoc ( SelectIndex ( IDD_BASES ), &m_oldbases.contents(p), m_lDocId );
		}
	}
	if ( m_pAttrMask [2] & M_ATR_ID )
		TagAttrRestore ( m_lDocId, IDD_ID, "IDD_ID");
	if ( m_pAttrMask [2] & M_ATR_RCD )
		TagAttrRestore ( m_lDocId, IDD_RCODE, "IDD_RCODE");
	if ( m_pAttrMask [2] & M_ATR_DIV )
		TagAttrRestore ( m_lDocId, IDD_DIV, "IDD_DIV"); // second pair (class)
	if ( m_pAttrMask [2] & M_ATR_KND )
		TagAttrRestore ( m_lDocId, IDD_DOCKIND, "IDD_DOCKIND"); // second pair (prefix)
	/*
	else
	if ( m_pAttrMask [2] & M_ATR_DIV ) { // class pair changed only
		if ( !m_pOldClass || ! m_pNewClass ) {
			logger.printf ( lt_fatal, "Class pair not stored (tag %d)\n", IDD_DOCKIND ); 
			_EXIT ( EXIT_FAILURE );
		}
		CorrectPairIndex ( m_pOldClass, m_pNewClass, 0, 0, IDD_DOCKIND );
		delete m_pOldClass;
		m_pOldClass = 0;
		delete m_pNewClass;
		m_pNewClass = 0;
	}
	*/
	if ( m_pAttrMask [2] & M_ATR_SRT )
		TagAttrRestore ( m_lDocId, IDD_SORTDATE, "IDD_SORTDATE");
	/*remember to change it in IDD_INFO.Status restoring*/
	if ( m_pAttrMask [2] & M_ATR_NAM ){
		long delCount, addCount;
		
		DeltaRead ( &delCount, sizeof ( delCount ), 1, m_DFile1 );
		DeltaRead ( &addCount, sizeof ( addCount ), 1, m_DFile1 );

		logger.printf ( lt_debug, "\trestoring Doc Long Name, del items: %ld, add items: %ld\n", delCount, addCount );
		long iNewSize;
		DeltaRead ( &iNewSize, 1, sizeof ( iNewSize ), m_DFile1);
		char* name = (char*) malloc ( iNewSize + MALLOC_ADDS );

		for ( ;delCount ; delCount-- ) {
			short pos;
			DeltaRead ( &pos, sizeof (pos), 1, m_DFile1 );
		}

		long length = 0;
		for ( ; addCount; addCount-- ) {
			DeltaRead ( &length, sizeof(length), 1, m_DFile1 );
			DeltaRead ( name, length, 1, m_DFile1 );
			name[length] = '\x0';
		}

		Ref	ref = {m_lDocId, 0};
		if (length) {
			add_subname (ref, name, ++length);
		} else {
			del_subname (ref);
		}

		if ( name ) free ( name );

		if (s_UpdDocs.find (m_lDocId) == s_UpdDocs.end () && ((m_pNewInfo->Status & (DS_DOC|DS_EDITION))|| (m_pNewInfo->Status_ex & DS_MEDTOPIC)))
			s_UpdDocs.insert (m_lDocId);
	}

	// forth level (maximum 7 bits -xxxxxxx)
	if ( m_pAttrMask [3] & M_ATR_RDT ) 
		TagAttrRestore ( m_lDocId, IDD_RDATE, "IDD_RDATE");
	if ( m_pAttrMask [3] & M_ATR_WAR ) 
		TagAttrRestore ( m_lDocId, IDD_WARNING, "IDD_WARNING");
	if ( m_pAttrMask [3] & M_ATR_VLC ) 
		TagAttrRestore ( m_lDocId, IDD_VLCONTROL, "IDD_VLCONTROL");
	if ( m_pAttrMask [3] & M_ATR_VAN ) 
		TagAttrRestore ( m_lDocId, IDD_VANONCED, "IDD_VANONCED");
	if ( m_pAttrMask [3] & M_ATR_CAT ) 
		TagAttrRestore ( m_lDocId, IDD_CATEGORY, "IDD_CATEGORY");
	if ( m_pAttrMask [3] & M_ATR_PUB ) 
		TagAttrRestore ( m_lDocId, IDD_PUBLISHEDIN, "IDD_PUBLISHEDIN");
	if ( m_pAttrMask [3] & M_ATR_VAB ) 
		TagAttrRestore ( m_lDocId, IDD_VABOLISHED, "IDD_VABOLISHED");
    
    	// fith level (maximum 7 bits -xxxxxxx)
	if ( m_pAttrMask [4] & M_ATR_INC ) 
		TagAttrRestore ( m_lDocId, IDD_VINCLUDED, "IDD_VINCLUDED");
	if ( m_pAttrMask [4] & M_ATR_SFL ) 
		TagAttrRestore ( m_lDocId, IDD_SOURCEFILE, "IDD_SOURCEFILE");
	if ( m_pAttrMask [4] & M_ATR_ACT    ) 
		TagAttrRestore ( m_lDocId, IDD_ACTIVE, "IDD_ACTIVE");
	if ( m_pAttrMask [4] & M_ATR_PBREAKS) 
		TagAttrRestore ( m_lDocId, IDD_PAGEBREAKS, "IDD_PAGEBREAKS");
	if ( m_pAttrMask [4] & M_ATR_PARAIDS) 
		TagAttrRestore ( m_lDocId, IDD2_PARAIDS, "IDD_PARAIDS");
	if ( m_pAttrMask [4] & M_ATR_CHDATE ) 
		TagAttrRestore ( m_lDocId, IDD_CHDATE, "IDD_CHDATE");
	if ( m_pAttrMask [4] & M_ATR_CONTENTS ) 
		TagAttrRestore ( m_lDocId, IDD_CONTENTS, "IDD_CONTENTS");

	if ( m_pAttrMask [5] & M_ATR_NOTSURE ) 
		TagAttrRestore ( m_lDocId, IDD_NOTSURE, "IDD_NOTSURE");
	if ( m_pAttrMask [5] & M_ATR_REFS ) 
		TagAttrRestore ( m_lDocId, IDD_REFS, "IDD_REFS");
	if ( m_pAttrMask [5] & M_ATR_BLOBS ) 
		TagAttrRestore ( m_lDocId, IDD_BLOBS, "IDD_BLOBS");
	if ( m_pAttrMask [5] & M_ATR_DIVIS ) 
		TagAttrRestore ( m_lDocId, IDD_DIVISION, "IDD_DIVISION");
	if ( m_pAttrMask [5] & M_ATR_PREANNO ) 
		TagAttrRestore ( m_lDocId, IDD_PREANNODATE);
	if ( m_pAttrMask [5] & M_ATR_ANNODATE ) 
		TagAttrRestore ( m_lDocId, IDD_ANNODATE, "IDD_ANNODATE");
	if ( m_pAttrMask [5] & M_ATR_ANNOU ) 
		TagAttrRestore ( m_lDocId, IDD_ANNOUSER, "IDD_ANNOUSER");

	if ( m_pAttrMask [6] & M_ATR_ANNOO ) 
		TagAttrRestore ( m_lDocId, IDD_ANNOORGANIZATION, "IDD_ANNOORGANIZATION");
	if ( m_pAttrMask [6] & M_ATR_ANNOT ) 
		TagAttrRestore ( m_lDocId, IDD_ANNOTAX, "IDD_ANNOTAX");
	if ( m_pAttrMask [6] & M_ATR_ANNOI ) 
		TagAttrRestore ( m_lDocId, IDD_ANNOINTEREST, "IDD_ANNOINTEREST");
	if ( m_pAttrMask [6] & M_ATR_ANNOK ) 
		TagAttrRestore ( m_lDocId, IDD_ANNOKIND, "IDD_ANNOKIND");
	if ( m_pAttrMask [6] & M_ATR_PREANNOU )
		TagAttrRestore ( m_lDocId, IDD_PREANNOUSER);
	if ( m_pAttrMask [6] & M_ATR_PREANNOO )
		TagAttrRestore ( m_lDocId, IDD_PREANNOORGANIZATION);
	if ( m_pAttrMask [6] & M_ATR_PREANNOT )
		TagAttrRestore ( m_lDocId, IDD_PREANNOTAX);

	if ( m_pAttrMask [7] & M_ATR_PREANNOI )
		TagAttrRestore ( m_lDocId, IDD_PREANNOINTEREST);
	if ( m_pAttrMask [7] & M_ATR_PREANNOK )
		TagAttrRestore ( m_lDocId, IDD_PREANNOKIND);
	if ( m_pAttrMask [7] & M_ATR_CHANGE )
		TagAttrRestore ( m_lDocId, IDD_CHANGE, "IDD_CHANGE");
	if ( m_pAttrMask [7] & M_ATR_HANDMASK )
		TagAttrRestore ( m_lDocId, IDD_HANDMASK, "IDD_HANDMASK");
	if ( m_pAttrMask [7] & M_ATR_SAMEDOCS )
		TagAttrRestore ( m_lDocId, IDD_SAMEDOCS, "IDD_SAMEDOCS");
	if ( m_pAttrMask [7] & M_ATR_SERVICEINFO )
		TagAttrRestore ( m_lDocId, IDD_SERVICEINFO, "IDD_SERVICEINFO");

	if ( m_pAttrMask [8] & M_ATR_HANDHANDMASK )
		TagAttrRestore ( m_lDocId, IDD_HANDHANDMASK, "IDD_HANDHANDMASK");
	if ( m_pAttrMask [8] & M_ATR_CLASS6 )
		TagAttrRestore ( m_lDocId, IDD_CLASS6, "IDD_CLASS6");
	if ( m_pAttrMask [8] & M_ATR_INPHARMFIRM )
		TagAttrRestore ( m_lDocId, IDD_INPHARMFIRM, "IDD_INPHARMFIRM");
	if ( m_pAttrMask [8] & M_ATR_INPHARMCOUNTRY )
		TagAttrRestore ( m_lDocId, IDD_INPHARMCOUNTRY, "IDD_INPHARMCOUNTRY");
	if ( m_pAttrMask [8] & M_ATR_ANNULDATE )
		TagAttrRestore ( m_lDocId, IDD_ANNULDATE, "IDD_ANNULDATE");
	if ( m_pAttrMask [8] & M_ATR_TRADENAME )
		TagAttrRestore ( m_lDocId, IDD_TRADENAME, "IDD_TRADENAME");
	if ( m_pAttrMask [8] & M_ATR_INTNAME )
		TagAttrRestore ( m_lDocId, IDD_INTNAME, "IDD_INTNAME");

	if ( m_pAttrMask [9] & M_ATR_PHARMGROUP )
		TagAttrRestore ( m_lDocId, IDD_PHARMGROUP, "IDD_PHARMGROUP");
	if ( m_pAttrMask [9] & M_ATR_PHARMEFFECT )
		TagAttrRestore ( m_lDocId, IDD_PHARMEFFECT, "IDD_PHARMEFFECT");
	if ( m_pAttrMask [9] & M_ATR_CHAPTER )
		TagAttrRestore ( m_lDocId, IDD_CHAPTER, "IDD_CHAPTER");
	if ( m_pAttrMask [9] & M_ATR_ATC )
		TagAttrRestore ( m_lDocId, IDD_ATC, "IDD_ATC");
	if ( m_pAttrMask [9] & M_ATR_REGSTATUS )
		TagAttrRestore ( m_lDocId, IDD_REGSTATUS, "IDD_REGSTATUS");
	if ( m_pAttrMask [9] & M_ATR_LEKFORM )
		TagAttrRestore ( m_lDocId, IDD_LEKFORM, "IDD_LEKFORM");
	if ( m_pAttrMask [9] & M_ATR_MKB )
		TagAttrRestore ( m_lDocId, IDD_MKB, "IDD_MKB");

	if ( m_pAttrMask [10] & M_ATR_REGDATE )
		TagAttrRestore ( m_lDocId, IDD_REGDATE, "IDD_REGDATE");
	if ( m_pAttrMask [10] & M_ATR_CASECODE)
		TagAttrRestore ( m_lDocId, IDD_CASECODE, "IDD_CASECODE");
	if ( m_pAttrMask [10] & M_ATR_LIFE )
		TagAttrRestore ( m_lDocId, IDD_LIFE, "IDD_LIFE");
	if ( m_pAttrMask [10] & M_ATR_UNRECIPE)
		TagAttrRestore ( m_lDocId, IDD_UNRECIPE, "IDD_UNRECIPE");
	if ( m_pAttrMask [10] & M_ATR_ALLOWED)
		TagAttrRestore ( m_lDocId, IDD_ALLOWED, "IDD_ALLOWED");
	if ( m_pAttrMask [10] & M_ATR_NOTALLOWED)
		TagAttrRestore ( m_lDocId, IDD_NOTALLOWED, "IDD_NOTALLOWED");
	if ( m_pAttrMask [10] & M_ATR_RECIPE)
		TagAttrRestore ( m_lDocId, IDD_RECIPE, "IDD_RECIPE");

	if ( m_pAttrMask [11] & M_ATR_NOTLIFE)
		TagAttrRestore ( m_lDocId, IDD_NOTLIFE, "IDD_NOTLIFE");
	if ( m_pAttrMask [11] & M_ATR_SUB)
		TagAttrRestore ( m_lDocId, IDD_SUBS, "IDD_SUBS");
	if ( m_pAttrMask [11] & M_ATR_EVD)
		TagAttrRestore ( m_lDocId, IDD_EVD, "IDD_EVD");
	if ( m_pAttrMask [11] & M_ATR_ACTIVEEX)
		TagAttrRestore ( m_lDocId, IDD_ACTIVEEX, "IDD_ACTIVEEX");
	if ( m_pAttrMask [11] & M_ATR_PARAGCTX)
		TagAttrRestore ( m_lDocId, IDD_PARAGCTXLENS, "IDD_PARAGCTXLENS");

	if ( m_pAttrMask [11] & M_ATR_CALIN) 
		TagAttrRestore ( m_lDocId, IDD_CALIN, "IDD_CALIN");
	if ( m_pAttrMask [11] & M_ATR_CALAB) 
		TagAttrRestore ( m_lDocId, IDD_CALAB, "IDD_CALAB");
	if ( m_pAttrMask [12] & M_ATR_CALCH) 
		TagAttrRestore ( m_lDocId, IDD_CALCH, "IDD_CALCH");
	if ( m_pAttrMask [12] & M_ATR_DOCSTRUCT) 
		TagAttrRestore ( m_lDocId, IDD_DOCSTRUCT, "IDD_DOCSTRUCT");
	if ( m_pAttrMask [12] & M_ATR_INVISIBLELENS) 
		TagAttrRestore ( m_lDocId, IDD_INVISIBLELENS, "IDD_INVISIBLELENS");
	if ( m_pAttrMask [12] & M_ATR_INVISIBLERELES) 
		TagAttrRestore ( m_lDocId, IDD_INVISIBLERELES, "IDD_INVISIBLERELES");
	if (m_pAttrMask [12] & M_ATR_KIND)
		TagAttrRestore (m_lDocId, IDD_KIND, "IDD_KIND");
	if ( m_pAttrMask [12] & M_ATR_COMPARECONTENTS ) 
		TagAttrRestore ( m_lDocId, IDD_COMPARECONTENTS, "IDD_COMPARECONTENTS");
	if ( m_pAttrMask [12] & M_ATR_CHDATE_EX ) 
		TagAttrRestore ( m_lDocId, IDD_CHDATE_EX, "IDD_CHDATE_EX");

	if ( m_pAttrMask [13] & M_ATR_ADDCODE )
		TagAttrRestore ( m_lDocId, IDD_ADDCODE, "IDD_ADDCODE");
	if ( m_pAttrMask [13] & M_ATR_CHDATE_EXEX )
		TagAttrRestore ( m_lDocId, IDD_CHDATE_EXEX, "IDD_CHDATEEXEX");
	if ( m_pAttrMask [13] & M_ATR_MARKEDTEXT )
		TagAttrRestore ( m_lDocId, IDD_MARKEDTEXT, "IDD_MARKEDTEXT");
	if ( m_pAttrMask [13] & M_ATR_SAMES )
		TagAttrRestore ( m_lDocId, IDD_SAMES, "IDD_SAMES");
	if ( m_pAttrMask [13] & M_ATR_TAG )
		TagAttrRestore ( m_lDocId, IDD_TAG, "IDD_TAG");
	if ( m_pAttrMask [13] & M_ATR_PROFDATE )
		TagAttrRestore ( m_lDocId, IDD_PROFDATE, "IDD_PROFDATE");

	if (addsubnames.size ()) {
		for (std::map<long,std::string>::const_iterator map_it = addsubnames.begin (); map_it != addsubnames.end (); map_it++) {
			Ref ref = {m_lDocId, map_it->first};
			add_subname (ref, (char*) map_it->second.c_str (), map_it->second.size () + 1);
		}
		addsubnames.clear ();
	}

	/*
	if (show_timelog) {
		unsigned sec, msec, usec;
		Core::GDS::HiResCounterSingl::instance()->tiks_to_time(Core::GDS::HiResCounterSingl::instance()->get_count () - m_start_count, sec, msec, usec);
		logger.printf (lt_updateInfo, "RestoreAttr: %ldsec.%ldmsec\n", sec, msec);
	}
	*/
	return 1;
}

void UnFull :: TagAttrRestore ( long lDocId, int iTag, const char* log_str)
{
	long delta_pos = 0, new_delta_pos = 0;
	if (b_show_extended_log && log_str) {
		if (delta_buffer)
			delta_pos = delta_buffer_ptr - delta_buffer;
		else
			mpcxc_fgetpos (m_DFile1, &delta_pos);

		logger.printf (lt_updateInfo, "%s:", log_str);
		if (b_flush_extended_log) logger.flush (lt_always);
	}

	long delCount, addCount;
	
	DeltaRead ( &delCount, sizeof ( delCount ), 1, m_DFile1 );
	DeltaRead ( &addCount, sizeof ( addCount ), 1, m_DFile1 );

	//logger.printf ( lt_debug, "\trestoring attr with (TAG=%d), del items: %ld, add items: %ld\n", iTag, delCount, addCount );

	switch ( iTag ) {
	case IDD2_PARAIDS:
		{
			if (addCount) {
				DeltaRead ( &m_pNewInfo->lastParaID, 1, sizeof ( m_pNewInfo->lastParaID ), m_DFile1);
				long iNewSize;
				DeltaRead ( &iNewSize, 1, sizeof ( iNewSize ), m_DFile1);
				if (iNewSize) {
					void gk_huge* aBuff = malloc(iNewSize);
					DeltaRead ( aBuff, iNewSize, 1, m_DFile1 );
					docInd2->Replace( lDocId,iTag,aBuff,iNewSize );
					free(aBuff);
				}				
 				ReplaceInfo++;
			}else if (delCount) {
				//удалить старый ключ
				docInd2->Del(lDocId,iTag);
			}
		}
		break;
	case IDD_ACTIVE:
	case IDD_PAGEBREAKS:
	case IDD_CHDATE:
	case IDD_PROFDATE:
	case IDD_CHDATE_EX:
	case IDD_CHDATE_EXEX :
	case IDD_CONTENTS:
	case IDD_COMPARECONTENTS:
	case IDD_NOTSURE:
	case IDD_BLOBS:
	case IDD_DIVISION:
	case IDD_PREANNOUSER:
	case IDD_PREANNOORGANIZATION:
	case IDD_PREANNOTAX:
	case IDD_PREANNOINTEREST:
	case IDD_PREANNOKIND:
	case IDD_CASECODE:
	case IDD_EVD:
	case IDD_CHANGE:
	case IDD_PARAGCTXLENS:
	case IDD_INVISIBLELENS:
	case IDD_INVISIBLERELES:
	case IDD_MARKEDTEXT:
	case IDD_SAMES:
		{
			if ( addCount ) {
				long iNewSize;
				DeltaRead ( &iNewSize, 1, sizeof ( iNewSize ), m_DFile1);
				void gk_huge* aBuff = malloc(iNewSize);
				DeltaRead ( aBuff, iNewSize, 1, m_DFile1 );
				docInd->Replace( lDocId,iTag,aBuff,iNewSize );

				free(aBuff);
			} else if ( delCount ) {
				//удалить старый ключ
				docInd->Del(lDocId,iTag);
			}
			if (iTag == IDD_MARKEDTEXT || iTag == IDD_INVISIBLELENS || iTag == IDD_INVISIBLERELES) {
				if (s_UpdDocs.find (m_lDocId) == s_UpdDocs.end () && (m_pNewInfo->Status & (DS_DOC|DS_EDITION)))
					s_UpdDocs.insert (m_lDocId);
			}
		}
		break;

	case IDD_LIFE:
	case IDD_NOTLIFE:
	case IDD_UNRECIPE:
	case IDD_RECIPE:
	case IDD_ALLOWED:
	case IDD_NOTALLOWED:
		{
		Index* statusex_index = m_pNewBase->FindIndex ("Status_ex");
		StorableSplaySet<long> m_data;
		docInd->Load (lDocId, iTag, m_data);
		short ds_status = 0;
		switch (iTag) {
			case IDD_LIFE:
				ds_status = DS_LIFE;
				break;
			case IDD_NOTLIFE:
				ds_status = DS_NOTLIFE;
				break;
			case IDD_UNRECIPE:
				ds_status = DS_UNRECIPE;
				break;
			case IDD_RECIPE:
				ds_status = DS_RECIPE;
				break;
			case IDD_ALLOWED:
				ds_status = DS_ALLOWED;
				break;
			case IDD_NOTALLOWED:
				ds_status = DS_NOTALLOWED;
				break;
		}
		if (delCount) {
			long* todel = (long*) malloc (delCount * sizeof(long));
			DeltaRead (todel, sizeof(long), delCount, m_DFile1);
			
			while (delCount--) {
				long sub = todel [delCount];
				m_data.del (sub);
				Ref ref = {lDocId, sub};
				DelStatusExRef (statusex_index, &ds_status, ref, iTag);
			}
			free (todel);
		}

		if (addCount) {
			long *toadd = (long*) malloc (addCount * sizeof (long));
			DeltaRead (toadd, sizeof (long), addCount, m_DFile1);

			while (addCount--) {
				long sub = toadd [addCount];
				m_data.add (sub);
				Ref ref = {lDocId, sub};
				AddStatusExRef (statusex_index, &ds_status, ref);
			}
			free (toadd);
		}

		if (m_data.length() ) {
			docInd->Replace (lDocId, iTag, m_data);
		} else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from Attrs\n", aKey.DocId, aKey.AttrTag );
		}
		}
		break;

	case IDD_SAMEDOCS:
		{
		StorableSplaySet<DocRele> set;
		docInd->Load (lDocId, iTag, set);

		while (delCount--) {
			short delpos;
			DeltaRead (&delpos, sizeof (delpos), 1, m_DFile1);
			Point i = set.first ();
			for (;delpos;delpos--)
				set.next (i);
			DocRele ati = set.contents (i);
			set.del (ati);
		}

		DocRele *sames = (DocRele*) malloc (addCount * sizeof (DocRele));
		DeltaRead (sames, sizeof (DocRele), addCount, m_DFile1);
		while (addCount--)
			set.add (sames [addCount]);
		if (sames) free (sames);

		if (set.length ())
			docInd->Replace (lDocId, iTag, set);
		else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
		}
		break;

	case IDD_REFS:
		{
		StorableSplaySet<RespRef> set;
		docInd->Load ( lDocId, iTag, set );

		RespRef* refs = (RespRef*)malloc (delCount * sizeof(RespRef) );
		DeltaRead( refs, sizeof(RespRef), delCount, m_DFile1 );
		while ( delCount-- )
			set.del ( refs [delCount] );
		if ( refs ) free ( refs );

		refs = (RespRef*)malloc (addCount * sizeof(RespRef) );
		DeltaRead ( refs, sizeof(RespRef), addCount, m_DFile1 );
		while ( addCount-- )
			set.add ( refs [addCount] );
		if ( refs ) free ( refs );

		if ( set.length() )
			docInd->Replace( lDocId, iTag, set );
		else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
		}
		break;

	case IDD_HANDMASK:
	case IDD_HANDHANDMASK:
		if (addCount + delCount) {
			std::vector<long> del_positions, add_positions;
			std::vector<std::string> add_strings, old_vector;
			long i, read;
			for (i = 0; i < delCount; i++) {
				DeltaRead (&read, 1, sizeof (read), m_DFile1);
				del_positions.push_back (read);
			}
			for (i = 0; i < addCount; i++) {
				DeltaRead (&read, 1, sizeof (read), m_DFile1);
				add_positions.push_back (read);
			}
			for (i = 0; i < addCount; i++) {
				std::string str;
				char read;
				DeltaRead (&read, 1, sizeof (read), m_DFile1);
				while (read) {
					str += read;
					DeltaRead (&read, 1, sizeof (read), m_DFile1);
				}
				add_strings.push_back (str);
			}

			long old_size = 0;
			char *old_strings = (char*) m_pOldBase->LoadAttr (lDocId, iTag, old_size), *ptr = old_strings;
			if (old_size) while (ptr - old_strings < old_size) {
				old_vector.push_back (ptr);
				ptr += strlen (ptr)+1;
			}
			for (std::vector<long>::reverse_iterator rit = del_positions.rbegin (); rit != del_positions.rend (); rit++) {
				long del_pos = *rit;
				old_vector.erase (old_vector.begin () + del_pos);
			}
			std::vector<std::string>::const_iterator sit = add_strings.begin ();
			for (std::vector<long>::const_iterator it = add_positions.begin (); it != add_positions.end (); it++, sit++) {
				old_vector.insert (old_vector.begin () + *it, *sit);
			}

			long size = 0;
			for (sit= old_vector.begin (); sit != old_vector.end (); sit++)
				size += sit->size () + 1;
			if (size) {
				char *data = (char*) malloc (size), *ptr = data;
				for (sit= old_vector.begin (); sit != old_vector.end (); sit++) {
					strcpy (ptr, sit->c_str ());
					ptr += strlen (ptr) + 1;
				}
				docInd->Replace (lDocId, iTag, data, size);
				gk_free (data);
			} else {
				AttrKey aKey;
				aKey.DocId = lDocId;
				aKey.AttrTag = iTag;
				if (docInd -> Delete (&aKey) != GKDB::BT_OK)
					logger.printf ( lt_error, "Can't delete Key (%ld, %d) from Attrs index\n", aKey.DocId, aKey.AttrTag );
			}
			if (s_UpdDocs.find (m_lDocId) == s_UpdDocs.end () && (m_pNewInfo->Status & (DS_DOC|DS_EDITION)))
				s_UpdDocs.insert (m_lDocId);
			gk_free (old_strings);
		}
		break;

	case IDD_ACTIVEEX:
		{
		StorableSplaySet<u_int64_t> set;
		docInd->Load (lDocId, iTag, set);

		u_int64_t* dates = (u_int64_t*)malloc (delCount * sizeof (u_int64_t));
		DeltaRead (dates, sizeof (u_int64_t), delCount, m_DFile1 );
		
		while (delCount--) {
			set.del ( dates [delCount] );
			u_int64_t at = *(dates + delCount);
			Ref to_delete = {m_lDocId, (u_int32_t)(at >> 32)};
			u_int32_t a_date = (u_int32_t)(at & 0xFFFFFFFF);
			DelStreamRef (SelectIndex (iTag), &a_date, to_delete, iTag);
		}
		if (dates) free (dates);

		dates = (u_int64_t*) malloc (addCount * sizeof (u_int64_t));
		DeltaRead (dates, sizeof (u_int64_t), addCount, m_DFile1);

		while (addCount--) {
			u_int64_t at = *(dates + addCount);
			Ref to_add = {m_lDocId, (u_int32_t)(at >> 32)};
			set.add ( dates [addCount] );
			u_int32_t a_date = (u_int32_t)(at & 0xFFFFFFFF);
			AddStreamRef (SelectIndex (iTag), &a_date, to_add, iTag);
		}
		if (dates) free (dates);

		if (set.length ())
			docInd->Replace (lDocId, iTag, set);
		else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
		}
		break;

	case IDD_ANNULDATE:
	case IDD_REGDATE:
		{
		StorableSplaySet<u_int64_t> set;
		docInd->Load (lDocId, iTag, set);

		u_int64_t* dates = (u_int64_t*)malloc (delCount * sizeof (u_int64_t));
		DeltaRead (dates, sizeof (u_int64_t), delCount, m_DFile1 );
		
		while (delCount--) {
			set.del ( dates [delCount] );
			u_int64_t at = *(dates + delCount);
			Ref to_delete = {m_lDocId, (long)(at & 0xFFFFFFFF)};
			u_int32_t a_date = (u_int32_t)(at >> 32);
			DelStreamRef (SelectIndex (iTag), &a_date, to_delete, iTag);
		}
		if (dates) free (dates);

		dates = (u_int64_t*) malloc (addCount * sizeof (u_int64_t));
		DeltaRead (dates, sizeof (u_int64_t), addCount, m_DFile1);

		while (addCount--) {
			u_int64_t at = *(dates + addCount);
			Ref to_add = {m_lDocId, (long)(at & 0xFFFFFFFF)};
			set.add ( dates [addCount] );
			u_int32_t a_date = (u_int32_t)(at >> 32);
			AddStreamRef (SelectIndex (iTag), &a_date, to_add, iTag);
		}
		if (dates) free (dates);

		if (set.length ())
			docInd->Replace (lDocId, iTag, set);
		else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
		}
		break;

	case IDD_MKB:
	case IDD_CHAPTER:
		{
		long iOldSize, iNewSize;
		char *vOldBuff = (char*) docInd->Load (lDocId, iTag, iOldSize);
		if ( iOldSize == -1 ) iOldSize = 0, vOldBuff = 0;

		DeltaRead ( &iNewSize, 1, sizeof ( iNewSize ), m_DFile1);
		char* vNewBuff = (char*) malloc (iNewSize + MALLOC_ADDS);

		StringZ* pKeys = new StringZ (vOldBuff, iOldSize, 1, 0);
		pKeys->EnableHide ();

		short *dels = new short[ delCount ], aPos = 0, copyCount = delCount;
		for ( ;delCount ; delCount--) {
			short pos;
			DeltaRead (&pos, sizeof (pos), 1, m_DFile1);
			dels [aPos++] = pos;
		}

		char**	toDel = new char*[ aPos ];
		long	toDelSize = 0;
		for (aPos = 0; aPos < copyCount; aPos++) {
			toDel [aPos] = strdup (pKeys->Get(dels[aPos]));
			toDelSize += strlen (toDel [aPos]) + 1;
			pKeys->Hide( dels[aPos] );
		}
		char *toDelArray = new char [toDelSize], *savedTop = toDelArray;
		for (aPos = 0; aPos < copyCount; aPos++) {
			int lend = strlen(toDel[ aPos ]);
			memcpy (toDelArray, toDel [aPos], lend + 1);
			free (toDel [aPos]);
			toDelArray += lend + 1;
		}
		delete []toDel;
		StringZ *toDelete = new StringZ (savedTop, toDelSize, 1, 1);

		for (aPos = 0; aPos < copyCount; aPos++)
			pKeys->UnHide (dels [aPos]);

		for (aPos = 0; aPos < copyCount; aPos++) {
			DelStrIndex (iTag, pKeys->Get(dels[aPos]), lDocId, pKeys->FindUnEquelLevel(dels[aPos]), pKeys, toDelete);
			pKeys->Hide (dels [aPos]);
		}
		delete dels;
		delete toDelete;
		delete savedTop;

		char* pPrevKey = vNewBuff;
		for (; addCount; addCount--) {
			long length;
			DeltaRead (&length, sizeof(length), 1, m_DFile1);
			DeltaRead (pPrevKey, length, 1, m_DFile1);
			pPrevKey[length] = '\x0';

			AddStrIndex (iTag, pPrevKey, lDocId);
			pPrevKey += length + 1;	
		}

		pKeys->EnableHide ();
		while (!pKeys->End ()) {
			if ( !(pKeys->GetAttrib (pKeys->GetPos ()) & Z_ATTR_HIDE)) {
				strcpy (pPrevKey, pKeys->Get ());
				pPrevKey+= strlen (pPrevKey) + 1;
			}
			++(*pKeys);
		}
		*pPrevKey = '\x0';
		iNewSize = pPrevKey - vNewBuff;
		delete pKeys;

		if (iNewSize)
			docInd->Replace (lDocId, iTag, vNewBuff, iNewSize);
		else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if (docInd->Delete (&aKey) != GKDB::BT_OK)
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}

		if (vNewBuff) free (vNewBuff);
		if (vOldBuff) free (vOldBuff);
		}
		break;

	case IDD_INPHARMFIRM:
	case IDD_INPHARMCOUNTRY:
	case IDD_TRADENAME:
	case IDD_INTNAME:
	case IDD_PHARMGROUP:
	case IDD_PHARMEFFECT:
	case IDD_ATC:
	case IDD_REGSTATUS:
	case IDD_LEKFORM:
		{
		int withSub = iTag == IDD_INPHARMFIRM || iTag == IDD_INPHARMCOUNTRY || iTag == IDD_REGSTATUS || iTag == IDD_LEKFORM || iTag == IDD_MKB || iTag == IDD_CHAPTER;
		int hKey = iTag == IDD_INPHARMFIRM || iTag == IDD_INPHARMCOUNTRY || iTag == IDD_PHARMGROUP || iTag == IDD_PHARMEFFECT || iTag == IDD_CHAPTER || iTag == IDD_ATC || iTag == IDD_REGSTATUS || iTag == IDD_LEKFORM || iTag == IDD_MKB;

		long iOldSize;
		char *vOldBuff = (char*) docInd->Load ( lDocId, iTag, iOldSize );
		if ( iOldSize == -1 ) iOldSize = 0, vOldBuff = 0;

		long iNewSize;
		DeltaRead ( &iNewSize, 1, sizeof ( iNewSize ), m_DFile1);
		char* vNewBuff = (char*) malloc (iNewSize + MALLOC_ADDS);

		StringZ* pKeys = new StringZ ( vOldBuff, iOldSize, withSub, 0 );	
		pKeys->EnableHide ();
		
		for ( ;delCount ; delCount-- ) {
			short pos;
			DeltaRead ( &pos, sizeof (pos), 1, m_DFile1 );
			if ( hKey ) // H-keys
				DelStrIndex ( iTag, pKeys->Get(pos), lDocId, pKeys->FindUnEquelLevel(pos), pKeys );
			else
				DelStrIndex ( iTag, pKeys->Get(pos), lDocId, -1 );

			pKeys->Hide ( pos );
		}

		char* pPrevKey = vNewBuff;
		for ( ; addCount; addCount-- ) {
			long length;
			DeltaRead ( &length, sizeof(length), 1, m_DFile1 );
			DeltaRead ( pPrevKey, length, 1, m_DFile1 );
			pPrevKey[length] = '\x0';
			AddStrIndex ( iTag, pPrevKey, lDocId );
			pPrevKey += length + 1;	
		}

		// Adding not modifyed keys and replace Attr
		pKeys->EnableHide ();
		while ( !pKeys->End () ) {
			if ( ! ( pKeys->GetAttrib ( pKeys->GetPos () ) & Z_ATTR_HIDE ) ) {
				strcpy ( pPrevKey, pKeys->Get() );
				pPrevKey+= strlen (pPrevKey) + 1;
			}
			++(*pKeys);
		}
		*pPrevKey = '\x0';  // close ASCIIZ array
		iNewSize = pPrevKey - vNewBuff;
		delete pKeys;

		if ( iNewSize )
			docInd->Replace ( lDocId, iTag, vNewBuff, iNewSize );
		else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}

		if ( vNewBuff ) free ( vNewBuff );
		if ( vOldBuff ) free ( vOldBuff );

		}
		break;

	case IDD_DIV :
	case IDD_KEY :
	case IDD_ID :
	case IDD_ADDCODE :
	case IDD_SOURCE :
	case IDD_TYPE :
	case IDD_KIND :
	case IDD_RCODE :
	case IDD_WARNING :
	case IDD_PUBLISHEDIN :
	case IDD_CATEGORY :
	case IDD_DOCKIND :
	case IDD_TERRITORY :
	case IDD_SOURCEFILE :
	case IDD_ANNOUSER:
	case IDD_ANNOORGANIZATION:
	case IDD_ANNOTAX:
	case IDD_ANNOINTEREST:
	case IDD_ANNOKIND:
	case IDD_SERVICEINFO:
	case IDD_CLASS6:
	case IDD_TAG:
		{
		int withSub = iTag==IDD_KEY || iTag==IDD_DIV || iTag == IDD_DOCKIND || iTag == IDD_TYPE || iTag == IDD_SERVICEINFO || iTag == IDD_CLASS6 || iTag == IDD_KIND || iTag == IDD_TAG;
		int hKey = iTag == IDD_TAG ? false : (withSub || iTag == IDD_SOURCE || iTag == IDD_PUBLISHEDIN || iTag == IDD_TERRITORY || iTag == IDD_ANNOUSER || iTag == IDD_ANNOORGANIZATION || iTag == IDD_ANNOTAX || iTag == IDD_ANNOINTEREST || iTag == IDD_ANNOKIND || iTag == IDD_CLASS6);
		
		bool b_skip = (iTag == IDD_CLASS6) && b_ovp ? true : false;

		long iOldSize;
		char *vOldBuff = (char*) docInd->Load ( lDocId, iTag, iOldSize );
		if ( iOldSize == -1 ) iOldSize = 0, vOldBuff = 0;

		if (iTag == IDD_CLASS6 && !b_skip && iOldSize) {
			//!заменить то, что в индексе, на реальные 001=...\002=...
			char *ptr = (char*) vOldBuff;
			long i = 0, new_len = 0;
			std::vector<std::string> strings;	
			while (i < iOldSize) {
				int len = strlen (ptr)+1;
				char *semipos = strchr (ptr, ':');
				*semipos++ = '\0';
				std::string new_iddclass6 (ptr);
				new_iddclass6 += ':';
				new_iddclass6 += old_map_id_str.find (atol (semipos))->second;
				strings.push_back (new_iddclass6);
				new_len += new_iddclass6.size () + 1;
				ptr += len;
				i += len;
			}
			char* new_buff = (char*) malloc (new_len);
			ptr = new_buff;
			for (std::vector<std::string>::const_iterator it = strings.begin (); it != strings.end (); it++) {
				strcpy (ptr, it->c_str ());
				ptr += strlen (ptr)+1;
			}
			gk_free (vOldBuff);
			vOldBuff = new_buff;
			iOldSize = new_len;
		}

		long iNewSize;
		DeltaRead ( &iNewSize, 1, sizeof ( iNewSize ), m_DFile1);
		char* vNewBuff = (char*) malloc ( iNewSize + MALLOC_ADDS + ( iTag == IDD_KEY ? 32768 + iOldSize : 0 ));

		StringZ* pKeys = 0;
		if ( iTag == IDD_DIV || iTag == IDD_SOURCE ) { // first pair attr
			pKeys = new StringZ ( vOldBuff, iOldSize + ( iTag == IDD_KEY ? 32768 : 0 ), withSub, 1 );
		} else {
			pKeys = new StringZ ( vOldBuff, iOldSize, withSub, 0 );	
		}
		
		pKeys->EnableHide ();
		
		logger.printf ( lt_debug, "\n*********** DEBUG STRING ATTRS (TAG=%d) UPDATING FOR DOC %ld ********\n", iTag, lDocId );
		//pKeys->Print ( &logger, lt_debug );
		
#ifdef	BLOCKSINHERIT
		short*	dels = new short[ delCount ];
		short	aPos = 0;
		short	copyCount = delCount;
		for ( ;delCount ; delCount-- ) {
			short pos;
			DeltaRead ( &pos, sizeof (pos), 1, m_DFile1 );
			dels[ aPos++ ] = pos;
		}

		if (!b_skip) {
			char**	toDel = new char*[ aPos ];
			long	toDelSize = 0;
			for ( aPos = 0; aPos < copyCount; aPos++ ) {
				toDel[ aPos ] = strdup( pKeys->Get(dels[aPos]) );
				toDelSize += strlen( toDel[ aPos ] ) + 1;
				pKeys->Hide( dels[aPos] );
			}
			char*	toDelArray = new char[ toDelSize ];
			char*	savedTop = toDelArray;
			for ( aPos = 0; aPos < copyCount; aPos++ ) {
				int lend= strlen(toDel[ aPos ]);
				memcpy( toDelArray, toDel[ aPos ], lend + 1 );
				free(toDel[ aPos ]);
				toDelArray += lend + 1;
			}
			delete []toDel;
			StringZ *toDelete = new StringZ( savedTop, toDelSize, withSub, 1 );

			for ( aPos = 0; aPos < copyCount; aPos++ )
				pKeys->UnHide( dels[ aPos ] );

			for ( aPos = 0; aPos < copyCount; aPos++ ) {
				if (iTag == IDD_DOCKIND) {
					/*
					const char* _key = pKeys->Get(dels[aPos]);
					if (strstr (_key, forms_prefix) && s_UpdDocs.find (m_lDocId) == s_UpdDocs.end () && ((m_pNewInfo->Status & (DS_DOC|DS_EDITION)) || (m_pNewInfo->Status_ex & DS_MEDTOPIC)))
						s_UpdDocs.insert (m_lDocId);
					*/
				} else if (iTag == IDD_TYPE) {
					char* _key = (char*) pKeys->Get(dels[aPos]);
					if (strchr (_key, '\\')) {
						char type_part [TYPE_KEY_SIZE], *equal_pos = strchr (_key, '='), *slash_pos = strchr (equal_pos, '\\');
						strncpy (type_part, equal_pos+1, slash_pos - equal_pos);
						type_part [slash_pos - equal_pos - 1] = '\0';
						if (!strcmp (type_part, "Комментарии")) {
							equal_pos = strchr (slash_pos, '=') + 1;
							if (!strcmp (equal_pos, "Статья") ||!strcmp (equal_pos, "Энциклопедия") || !strcmp (equal_pos, "Книга") || !strcmp (equal_pos, "Вопрос-ответ") || !strcmp (equal_pos, "Бератор"))
								s_UpdDocs.insert (m_lDocId);
						}
					}
				} else if (iTag == IDD_SOURCE) {
					if (std::binary_search (docs_include_header_in_text.begin (), docs_include_header_in_text.end (), m_lDocId))
						s_UpdDocs.insert (m_lDocId);
				} else if (iTag == IDD_KIND) {
					std::set<std::string> kinds_to_gctx = kinds.find (0)->second;
					std::set<std::string> blocks_to_gctx = kinds.find (1)->second;
					const char* _key = pKeys->Get(dels[aPos]);
					if ((kinds_to_gctx.find (strchr (_key, ':')+1) != kinds_to_gctx.end ()) || (blocks_to_gctx.find (strchr (_key, ':')+1) != blocks_to_gctx.end ()))
						s_UpdDocs.insert (m_lDocId);
				}

				if ( hKey ) // H-keys
					DelStrIndex ( iTag, pKeys->Get(dels[aPos]), lDocId, pKeys->FindUnEquelLevel(dels[aPos]), pKeys, toDelete );
				else
					DelStrIndex ( iTag, pKeys->Get(dels[aPos]), lDocId, -1 );

				pKeys->Hide ( dels[aPos] );
			}
			delete toDelete;
			delete savedTop;
		}
		delete dels;
#else		
		for ( ;delCount ; delCount-- ) {
			short pos;
			DeltaRead ( &pos, sizeof (pos), 1, m_DFile1 );
			if ( hKey ) // H-keys
				DelStrIndex ( iTag, pKeys->Get(pos), lDocId, pKeys->FindUnEquelLevel(pos), pKeys );
			else
				DelStrIndex ( iTag, pKeys->Get(pos), lDocId, -1 );

			pKeys->Hide ( pos );
		}
#endif

		char* pPrevKey = vNewBuff;
		for ( ; addCount; addCount-- ) {
			long length;
			DeltaRead ( &length, sizeof(length), 1, m_DFile1 );
			DeltaRead ( pPrevKey, length, 1, m_DFile1 );
			pPrevKey[length] = '\x0';

			/*
			if (iTag == IDD_DOCKIND && strstr (pPrevKey, forms_prefix) && s_UpdDocs.find (m_lDocId) == s_UpdDocs.end ())
				s_UpdDocs.insert (m_lDocId);
			*/

			if (!b_skip) {
				AddStrIndex ( iTag, pPrevKey, lDocId );
				if ((m_pNewInfo->Status & (DS_DOC|DS_EDITION))) {
					if (iTag == IDD_TYPE) {
						if (std::binary_search (docs_include_header_in_text.begin (), docs_include_header_in_text.end (), m_lDocId))
							s_UpdDocs.insert (m_lDocId);
						else if (strchr (pPrevKey, '\\')) {
							char type_part [TYPE_KEY_SIZE], *equal_pos = strchr (pPrevKey, '='), *slash_pos = strchr (equal_pos, '\\');
							strncpy (type_part, equal_pos+1, slash_pos - equal_pos);
							type_part [slash_pos - equal_pos - 1] = '\0';
							if (!strcmp (type_part, "Комментарии")) {
								equal_pos = strchr (slash_pos, '=') + 1;
								if (!strcmp (equal_pos, "Статья") ||!strcmp (equal_pos, "Энциклопедия") || !strcmp (equal_pos, "Книга") || !strcmp (equal_pos, "Вопрос-ответ") || !strcmp (equal_pos, "Бератор"))
									s_UpdDocs.insert (m_lDocId);
							}
						}
					} else if (iTag == IDD_SOURCE) {
						char *equal_pos = strchr (pPrevKey, '='), *slash_pos = strchr (equal_pos, '\\');
						if (slash_pos) {
							char source_part [ADOPTED_KEY_SIZE];
							strncpy (source_part, equal_pos+1, slash_pos - equal_pos);
							source_part [slash_pos - equal_pos - 1] = '\0';
							if (!strcmp (source_part, "Федеральные министерства и ведомства") || !strcmp (source_part, "Органы судебной власти РФ и СССР")) {
								equal_pos = strchr (slash_pos, '=') + 1;
								if (!strcmp (equal_pos, "Минфин России (Министерство финансов РФ)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Волго-Вятского округа (ФАС Волго-Вятского округа)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Восточно-Сибирского округа (ФАС Восточно-Сибирского округа)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Дальневосточного округа (ФАС Дальневосточного округа)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Западно-Сибирского округа (ФАС Западно-Сибирского округа)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Московского округа (ФАС Московского округа)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Поволжского округа (ФАС Поволжского округа)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Северо-Западного округа (ФАС Северо-Западного округа)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Северо-Кавказского округа (ФАС Северо-Кавказского округа)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Уральского округа (ФАС Уральского округа)") ||
									!strcmp (equal_pos, "Федеральный арбитражный суд Центрального округа (ФАС Центрального округа)"))
									s_UpdDocs.insert (m_lDocId);
							}
						}
					} else if (iTag == IDD_KIND) {
						std::set<std::string> kinds_to_gctx = kinds.find (0)->second;
						std::set<std::string> blocks_to_gctx = kinds.find (1)->second;
						if ((kinds_to_gctx.find (strchr (pPrevKey, ':')+1) != kinds_to_gctx.end ()) || (blocks_to_gctx.find (strchr (pPrevKey, ':')+1) != blocks_to_gctx.end ()))
							s_UpdDocs.insert (m_lDocId);
					}
				} else if (iTag == IDD_KEY) {
					bool	aFound = false;
					char*	at = vNewBuff;
					while ( !aFound && at != pPrevKey ) {
						if ( !strcmp( at, pPrevKey ))
							aFound = true;
						else
							at += strlen( at ) + 1;
					}
					if ( aFound )
						continue;
				}

				pPrevKey += length + 1;	
			}
		}

		// Adding not modifyed keys and replace Attr
		if (!b_skip) {
			pKeys->EnableHide ();
			while ( !pKeys->End () ) {
				if ( ! ( pKeys->GetAttrib ( pKeys->GetPos () ) & Z_ATTR_HIDE ) ) {
					strcpy ( pPrevKey, pKeys->Get() );
					pPrevKey+= strlen (pPrevKey) + 1;
				}
				++(*pKeys);
			}
			*pPrevKey = '\x0';  // close ASCIIZ array
			iNewSize = pPrevKey - vNewBuff;
		}

		delete pKeys;

		if (iTag == IDD_CLASS6 && !b_skip && iNewSize) {
			//! конвертнуть данные обратно, из 001=\... в сокращенный
			char* ptr = vNewBuff, buffer [32];
			std::vector<std::string> strings;
			long new_size = 0;
			for (int i = 0; i < iNewSize; ) {
				int len = strlen (ptr)+1;
				char* semipos = strchr (ptr, ':');
				*semipos = '\0';
				if (new_map_key_id.find (semipos+1) != new_map_key_id.end ())
					sprintf (buffer, "%s:%ld", ptr, new_map_key_id.find (semipos+1)->second);
				else
					sprintf (buffer, "%s:%ld", ptr, map_key_id.find (semipos+1)->second);
				new_size += strlen (buffer)+1;
				strings.push_back (buffer);
				i += len;
				ptr += len;
			}
			iNewSize = new_size;
			char* new_buff = (char*) malloc (iNewSize);
			ptr = new_buff;
			for (std::vector<std::string>::const_iterator it = strings.begin (); it != strings.end (); it++) {
				strcpy (ptr, it->c_str ());
				ptr += strlen (ptr)+1;
			}
			gk_free (vNewBuff);
			vNewBuff = new_buff;

		}
		
		if ( iNewSize ) {
			if (!b_skip) {
				if (iTag == IDD_KEY && vNewBuff && iNewSize) {
					//удалить дубли
					std::vector<std::string> vector_keys;
					std::set<std::string> set_keys;
					char *ptr = vNewBuff;
					while (ptr - vNewBuff < iNewSize) {
						if (set_keys.find (ptr) == set_keys.end ()) {
							set_keys.insert (ptr);
							vector_keys.push_back (ptr);
						}
						ptr += strlen (ptr) + 1;
					}
					free (vNewBuff);
					iNewSize = 0;
					std::vector<std::string>::const_iterator it;
					for (it = vector_keys.begin (); it != vector_keys.end (); it++)
						iNewSize += it->size () + 1;
					vNewBuff = (char*) malloc (iNewSize), ptr = vNewBuff;
					for (it = vector_keys.begin (); it != vector_keys.end (); it++) {
						strcpy (ptr, it->c_str ());
						ptr += it->size () + 1;
					}
				}
				docInd->Replace ( lDocId, iTag, vNewBuff, iNewSize );
			}
		} else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				if (!b_skip)
					logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}

		if ( vNewBuff ) free ( vNewBuff );
		if ( vOldBuff ) free ( vOldBuff );
	}
		break;

	case IDD_INFO :
	{	
		Index* statusex_index = m_pNewBase->FindIndex ("Status_ex");
		Index* status_index = m_pNewBase->FindIndex ("Status");

		assert ( m_pNewInfo );
		DeltaRead ( m_pNewInfo->Title, 1, DOC_SHORT_NAME_SIZE, m_DFile1 );
		DeltaRead ( &m_pNewInfo->FirstDate, sizeof ( m_pNewInfo->FirstDate ), 1, m_DFile1 );
		DeltaRead ( &m_pNewInfo->LastDate, sizeof ( m_pNewInfo->LastDate ), 1, m_DFile1 );
		DeltaRead ( &m_pNewInfo->Force, sizeof ( m_pNewInfo->Force ), 1, m_DFile1 );
		DeltaRead ( &m_pNewInfo->HyperRefs, sizeof ( m_pNewInfo->HyperRefs ), 1, m_DFile1 );
		DeltaRead ( &m_pNewInfo->GreenComments, sizeof ( m_pNewInfo->GreenComments ), 1, m_DFile1 );
		DeltaRead ( &m_pNewInfo->Related, sizeof ( m_pNewInfo->Related ), 1, m_DFile1 );
		short bNewDoc = (m_pAttrMask[0]&M_DOC_ORD) == O_DOC_NEW;
		DeltaRead ( & m_pNewInfo->Status, sizeof ( m_pNewInfo->Status ), 1, m_DFile1 );
		DeltaRead ( & m_pNewInfo->Status_ex, sizeof ( m_pNewInfo->Status_ex ), 1, m_DFile1 );
		unsigned short status_exex;
		DeltaRead (&status_exex, sizeof (status_exex), 1, m_DFile1);
		SetDocStatusExEx (m_pNewInfo, status_exex);
		long oldPrevEdition = m_pNewInfo->prevEdition;
		DeltaRead ( &m_pNewInfo->prevEdition, sizeof ( m_pNewInfo->prevEdition ), 1, m_DFile1 );
		/*
		if ( oldPrevEdition != m_pNewInfo->prevEdition ) {
			//у топика появилась новая редакция, ее номер должен стать uniqueID текущего
			SetDocUniqueId(m_pNewInfo, m_pNewInfo->prevEdition);
		}
		*/
		long oldNextEdition = m_pNewInfo->nextEdition;
		DeltaRead ( &m_pNewInfo->nextEdition, sizeof ( m_pNewInfo->nextEdition ), 1, m_DFile1 );
		DeltaRead( &m_pNewInfo->reserved_short, sizeof( m_pNewInfo->reserved_short ), 1, m_DFile1 );
		DeltaRead( &m_pNewInfo->reserved_short2, sizeof( m_pNewInfo->reserved_short2 ), 1, m_DFile1 );
		DeltaRead( &m_pNewInfo->long_respondents, sizeof( m_pNewInfo->long_respondents), 1, m_DFile1 );
		DeltaRead( &m_pNewInfo->hi_long_respondents, sizeof( m_pNewInfo->hi_long_respondents), 1, m_DFile1 );
		
		if (bNewDoc || m_pOldInfo->Status_ex != m_pNewInfo->Status_ex) {
			short new_DS_NARCOTIC = m_pNewInfo->Status_ex & DS_NARCOTIC;
			short new_DS_NOTNARCOTIC = m_pNewInfo->Status_ex & DS_NOTNARCOTIC;
			short new_DS_FIRMTOPIC = m_pNewInfo->Status_ex & DS_FIRMTOPIC;
			short new_DS_MEDTOPIC = m_pNewInfo->Status_ex & DS_MEDTOPIC;
			short new_DS_MDICTTOPIC = m_pNewInfo->Status_ex & DS_MDICTTOPIC;
			short new_DS_IZM = m_pNewInfo->Status_ex & DS_IZM;
			short new_DS_DATE = m_pNewInfo->Status_ex & DS_DATE;
			short new_DS_FLASH = m_pNewInfo->Status_ex & DS_FLASH;
			short old_DS_NARCOTIC = 0, old_DS_NOTNARCOTIC = 0, old_DS_FIRMTOPIC = 0, old_DS_MEDTOPIC = 0, old_DS_MDICTTOPIC = 0, old_DS_IZM = 0, old_DS_DATE = 0, old_DS_FLASH = 0;
			if (!bNewDoc) {
				old_DS_NARCOTIC = m_pOldInfo->Status_ex & DS_NARCOTIC;
				old_DS_NOTNARCOTIC = m_pOldInfo->Status_ex & DS_NOTNARCOTIC;
				old_DS_FIRMTOPIC = m_pOldInfo->Status_ex & DS_FIRMTOPIC;
				old_DS_MEDTOPIC = m_pOldInfo->Status_ex & DS_MEDTOPIC;
				old_DS_MDICTTOPIC = m_pOldInfo->Status_ex & DS_MDICTTOPIC;
				old_DS_IZM = m_pOldInfo->Status_ex & DS_IZM;
				old_DS_DATE = m_pOldInfo->Status_ex & DS_DATE;
				old_DS_FLASH = m_pOldInfo->Status_ex & DS_FLASH;
			}

			Ref ref = {lDocId, 0};
			if (old_DS_NARCOTIC != new_DS_NARCOTIC) {
				if (old_DS_NARCOTIC == DS_NARCOTIC)
					DelStatusExRef (statusex_index, &old_DS_NARCOTIC, ref);
				if (new_DS_NARCOTIC == DS_NARCOTIC)
					AddStatusExRef (statusex_index, &new_DS_NARCOTIC, ref);
			}
			if (old_DS_NOTNARCOTIC != new_DS_NOTNARCOTIC) {
				if (old_DS_NOTNARCOTIC == DS_NOTNARCOTIC)
					DelStatusExRef (statusex_index, &old_DS_NOTNARCOTIC, ref);
				if (new_DS_NOTNARCOTIC == DS_NOTNARCOTIC)
					AddStatusExRef (statusex_index, &new_DS_NOTNARCOTIC, ref);
			}
			if (old_DS_MEDTOPIC != new_DS_MEDTOPIC) {
				if (old_DS_MEDTOPIC == DS_MEDTOPIC) {
					DelStatusExRef (statusex_index, &old_DS_MEDTOPIC, ref);
					m_dsm = m_dsm_inpharm = dsmChgToNodoc;
				}
				if (new_DS_MEDTOPIC == DS_MEDTOPIC) {
					AddStatusExRef (statusex_index, &new_DS_MEDTOPIC, ref);
					m_dsm = m_dsm_inpharm = dsmChgToDoc;
				}
			}
			if (old_DS_FIRMTOPIC != new_DS_FIRMTOPIC) {
				if (old_DS_FIRMTOPIC == DS_FIRMTOPIC)
					DelStatusExRef (statusex_index, &old_DS_FIRMTOPIC, ref);
				if (new_DS_FIRMTOPIC == DS_FIRMTOPIC)
					AddStatusExRef (statusex_index, &new_DS_FIRMTOPIC, ref);
			}
			if (old_DS_MDICTTOPIC != new_DS_MDICTTOPIC) {
				if (old_DS_MDICTTOPIC == DS_MDICTTOPIC)
					DelStatusExRef (statusex_index, &old_DS_MDICTTOPIC, ref);
				if (new_DS_MDICTTOPIC == DS_MDICTTOPIC)
					AddStatusExRef (statusex_index, &new_DS_MDICTTOPIC, ref);
			}
			if (old_DS_IZM != new_DS_IZM) {
				if (old_DS_IZM)
					DelStatusExRef (statusex_index, &old_DS_IZM, ref);
				if (new_DS_IZM)
					AddStatusExRef (statusex_index, &new_DS_IZM, ref);
			}
			if (old_DS_DATE != new_DS_DATE) {
				if (old_DS_DATE)
					DelStatusExRef (statusex_index, &old_DS_DATE, ref);
				if (new_DS_DATE)
					AddStatusExRef (statusex_index, &new_DS_DATE, ref);
			}
			if (old_DS_FLASH != new_DS_FLASH) {
				if (old_DS_FLASH == DS_FLASH)
					DelStatusExRef (statusex_index, &old_DS_FLASH, ref);
				if (new_DS_FLASH == DS_FLASH)
					AddStatusExRef (statusex_index, &new_DS_FLASH, ref);
			}
		}
		
		if ( bNewDoc || m_pOldInfo->Status != m_pNewInfo->Status ) {
			short newDSDoc = m_pNewInfo->Status & (DS_DOC | DS_NODOC | DS_EDITION | DS_ANNO );
			short newDSActive = m_pNewInfo->Status & (DS_ACTIVE | DS_ABOLISHED | DS_PREACTIVE );
			short newDSReg = m_pNewInfo->Status & (DS_MOJREG | DS_MOJNOTREG | DS_MOJOTHER);
			short newDSWarning = m_pNewInfo->Status & (DS_WARNING);

			short oldDSDoc = 0;//DS_NODOC;
			short oldDSActive = 0;
			short oldDSReg = 0;
			short oldDSWarning = 0;
			if ( !bNewDoc ) {
				oldDSDoc = m_pOldInfo->Status & ( DS_DOC | DS_NODOC | DS_EDITION );
				oldDSActive = m_pOldInfo->Status & ( DS_ACTIVE | DS_ABOLISHED | DS_PREACTIVE );
				oldDSReg = m_pOldInfo->Status & ( DS_MOJREG | DS_MOJNOTREG | DS_MOJOTHER );
				oldDSWarning = m_pOldInfo->Status & (DS_WARNING);
			}

			if ( oldDSDoc != newDSDoc ) {
				if ( oldDSDoc & (DS_DOC|DS_EDITION|DS_NODOC|DS_ANNO)) {
					short key = oldDSDoc & DS_DOC; if (key) DelStatusDoc (status_index, &key, lDocId );
					key = oldDSDoc & DS_NODOC; if (key) DelStatusDoc (status_index, &key, lDocId );
					key = oldDSDoc & DS_EDITION; if (key) DelStatusDoc (status_index, &key, lDocId );
					key = oldDSDoc & DS_ANNO; if (key) DelStatusDoc (status_index, &key, lDocId );
				}
				if ( newDSDoc & (DS_DOC|DS_EDITION|DS_NODOC|DS_ANNO)) {
					short key = newDSDoc & DS_DOC; if (key) AddStatusDoc (status_index, &key, lDocId );
					key = newDSDoc & DS_NODOC; if (key) AddStatusDoc (status_index, &key, lDocId );
					key = newDSDoc & DS_EDITION; if (key) AddStatusDoc (status_index, &key, lDocId );
					key = newDSDoc & DS_ANNO; if (key) AddStatusDoc (status_index, &key, lDocId );
				}
			}

			if ((!oldDSDoc || !newDSDoc) && !bNewDoc) {
				logger.printf ( lt_error, "Invalid topic's doc (%ld) status (old:0x%04X, new:0x%04X)\n", lDocId, oldDSDoc, newDSDoc );
				if ( !oldDSDoc ) oldDSDoc = DS_NODOC;
				if ( !newDSDoc ) newDSDoc = DS_NODOC;
			}
			if ( oldDSDoc == DS_DOC && (!oldDSActive || !oldDSReg) ) 
				logger.printf ( lt_error, "Invalid old doc's (%ld) active or reg status (active:0x%04X, reg:0x%04X)\n", lDocId, oldDSActive, oldDSReg );
			if ( newDSDoc == DS_DOC && (!newDSActive || !newDSReg) ) 
				logger.printf ( lt_error, "Invalid new doc's (%ld) active or reg status (active:0x%04X, reg:0x%04X)\n", lDocId, newDSActive, newDSReg );

			if ( oldDSDoc != newDSDoc ) {
				if ( newDSDoc & ( DS_DOC | DS_EDITION )) {
					if ( newDSDoc & DS_EDITION )
						m_dsm = dsmChgToNodoc;
					else if ( newDSDoc & DS_DOC )
						m_dsm = dsmChgToDoc;
				} else {
					m_dsm = dsmChgToNodoc;
				}
			}

			// Correct Status index if Needed // !HERE!
			if ( oldDSActive != newDSActive ) {
				if ( oldDSDoc == DS_DOC )
					DelStatusDoc (status_index, &oldDSActive, lDocId );
				if ( newDSDoc == DS_DOC )
					AddStatusDoc (status_index, &newDSActive, lDocId );
			}

			// Correct Status index Justice flag (registred or not registred status)
			if ( oldDSWarning != newDSWarning) {
				if (oldDSWarning)
					DelStatusDoc (status_index, &oldDSWarning, lDocId );
				if (newDSWarning)
					AddStatusDoc (status_index, &newDSWarning, lDocId );
			}

			if ( oldDSReg != newDSReg ) {
				if ( oldDSDoc & ( DS_DOC | DS_EDITION ))
					if ( oldDSReg )
						DelStatusDoc (status_index, &oldDSReg, lDocId );

				if ( newDSDoc & ( DS_DOC | DS_EDITION ))
					if ( newDSReg )
						AddStatusDoc (status_index, &newDSReg, lDocId );
			}
		}
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
		ReplaceInfo++;
#else
		if ( docInd->Replace ( lDocId, IDD_INFO, m_pNewInfo, sizeof (DocInfo) ) != sizeof (DocInfo) )
			logger.printf ( lt_error, "AttrIndex->Replase ( %ld, IDD_INFO,...) failed\n", lDocId );
#endif
	}
		break;

	case IDD_SUBS :
	{
		Ref ref;
		ref.DocId = lDocId;

		StorableSplaySet<SubDesc> set;
		docInd->Load ( lDocId, iTag, set );

		//Remove Deleted Subs from index
		SubDesc* delSub = (SubDesc*)malloc( delCount * sizeof(SubDesc) );
		DeltaRead ( delSub, sizeof(SubDesc), delCount, m_DFile1 );

		long kinds_length = -1;
		char *idd_kinds = 0;
		std::set<std::string> kinds_to_gctx = kinds.find (0)->second;
		std::set<std::string> blocks_to_gctx = kinds.find (1)->second;

		std::set<long> del_subs;
		while ( delCount-- ) {
			long lSub = delSub [delCount].Sub;
			set.del (delSub [delCount]);
			ref.Sub = lSub;
			del_subs.insert (lSub);

			/*
			if (addsubnames.size ()) {
				std::map<long,std::string>::iterator map_it = addsubnames.find (lSub);
				if (map_it != addsubnames.end ())
					addsubnames.erase (map_it);
			}
			*/

			if (kinds_length == -1) {
				AttrKey key = {lDocId, IDD_KIND};
				Stream *str = docInd->Open (&key);
				if (str) {
					kinds_length = str -> Length();
					idd_kinds = (char*) alloca (kinds_length);
					str->Read (idd_kinds, kinds_length);
					docInd->Close (str);
				} else {
					kinds_length = 0;
				}
			}
			if (kinds_length) {
				char* ptr = idd_kinds;
				while (ptr - idd_kinds < kinds_length) {
					if (atol (ptr) == ref.Sub && (kinds_to_gctx.find (strchr (ptr, ':')+1) != kinds_to_gctx.end ()) || (blocks_to_gctx.find (strchr (ptr, ':')+1) != blocks_to_gctx.end ())) {
						if (s_UpdDocs.find (m_lDocId) == s_UpdDocs.end ())
							s_UpdDocs.insert (m_lDocId);
						break;
					}
					ptr += strlen (ptr) + 1;
				}
			}
		}

		if ( delSub ) free ( delSub );
		std::set<long> added_subs;

		//Add new Subs
		SubDesc sub;
		long length;
		char name [SUB_NAME_SIZE+1];
		while ( addCount-- ) {
			DeltaRead ( &sub, sizeof (sub), 1, m_DFile1 );
			added_subs.insert (sub.Sub);
			DeltaRead ( &length, sizeof (length), 1, m_DFile1 );
			if (length == -1) {
				std::set<long>::iterator del_it = del_subs.find (sub.Sub);
				if (del_it != del_subs.end ()) {
					del_subs.erase (del_it);
					/*
					if (addsubnames.size ()) {
						std::map<long,std::string>::iterator map_it = addsubnames.find (sub.Sub);
						if (map_it != addsubnames.end ())
							addsubnames.erase (map_it);
						else
							del_subs.insert (sub.Sub);
					}
					*/
				}
				length = 0;
			}

			DeltaRead ( name, length, 1, m_DFile1 );
			name [length] = 0;
			long lSub = sub.Sub;

			set.add (sub);
			ref.Sub = lSub;
			if (length) {
				std::set<long>::iterator del_it = del_subs.find (lSub);
				if (del_it != del_subs.end ())
					del_subs.erase (del_it);
				add_subname (ref, name, length + 1);
				if (addsubnames.size ()) {
					std::map<long,std::string>::iterator map_it = addsubnames.find (ref.Sub);
					if (map_it != addsubnames.end ())
						addsubnames.erase (map_it);
				}

				if (kinds_length == -1) {
					AttrKey key = {lDocId, IDD_KIND};
					Stream *str = docInd->Open (&key);
					if (str) {
						kinds_length = str -> Length();
						idd_kinds = (char*) alloca (kinds_length);
						str->Read (idd_kinds, kinds_length);
						docInd->Close (str);
					} else {
						kinds_length = 0;
					}
				}
				if (kinds_length) {
					char* ptr = idd_kinds;
					while (ptr - idd_kinds < kinds_length) {
						if (atol (ptr) == ref.Sub && (kinds_to_gctx.find (strchr (ptr, ':')+1) != kinds_to_gctx.end ()) || (blocks_to_gctx.find (strchr (ptr, ':')+1) != blocks_to_gctx.end ())) {
							if (s_UpdDocs.find (m_lDocId) == s_UpdDocs.end ())
								s_UpdDocs.insert (m_lDocId);
							break;
						}
						ptr += strlen (ptr) + 1;
					}
				}
			}
		}

		if (addsubnames.size ()) {
			std::set<long> to_erase;
			for (std::map<long,std::string>::const_iterator map_it = addsubnames.begin (); map_it != addsubnames.end (); map_it++)
				if (added_subs.find (map_it->first) == added_subs.end ())
					to_erase.insert (map_it->first);
			for (std::set<long>::const_iterator erase_it = to_erase.begin (); erase_it != to_erase.end (); erase_it++)
				addsubnames.erase (*erase_it);
		}

		for (std::set<long>::const_iterator del_it = del_subs.begin (); del_it != del_subs.end (); del_it++) {
			ref.Sub = *del_it;
			del_subname (ref);
			/*
			if (addsubnames.size ()) {
				std::map<long,std::string>::iterator map_it = addsubnames.find (ref.Sub);
				if (map_it != addsubnames.end ())
					addsubnames.erase (map_it);
			}
			*/
		}

		if ( set.length() )
			docInd->Replace ( lDocId, iTag, set );		
		else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
	}
		break;

	case IDD_DOCSTRUCT:
	{
		if (addCount == -1 && delCount == -1)
			addCount = delCount = 0;
		long andCount, i;
		DeltaRead (&andCount, sizeof (long), 1, m_DFile1);

		std::map<long,DocStruct> old_map;
		{
		long size, i;
		DocStruct *data = (DocStruct*) docInd->Load (lDocId, IDD_DOCSTRUCT, size), *ptr = data;
		std::map<long,long> map_childid_mid;
		for (i = 0, size /= sizeof (DocStruct); i < size; i++, ptr++) {
			old_map.insert (std::map<long,DocStruct>::value_type (ptr->m_id, *ptr));
			map_childid_mid.insert (std::map<long,long>::value_type (i, ptr->m_id));
		}
		for (std::map<long,DocStruct>::iterator it = old_map.begin (); it != old_map.end (); it++) {
			DocStruct *at_it = &it->second;
			if (at_it->m_first_child) at_it->m_first_child = map_childid_mid.find (at_it->m_first_child)->second;
			if (at_it->m_last_child) at_it->m_last_child = map_childid_mid.find (at_it->m_last_child)->second;
		}
		gk_free (data);
		}

		while (delCount--) {
			long m_id;
			DeltaRead (&m_id, sizeof (m_id), 1, m_DFile1);
			old_map.erase (m_id);
		}

		while (addCount--) {
			DocStruct docstruct;
			gk_bzero (&docstruct, sizeof (docstruct));
			DeltaRead (&docstruct.m_id, sizeof (long), 1, m_DFile1);
			DeltaRead (&docstruct.m_para_list_id, sizeof (long), 1, m_DFile1);
			DeltaRead (&docstruct.m_para_list_type, sizeof (long), 1, m_DFile1);
			DeltaRead (&docstruct.m_start_para, sizeof (long), 1, m_DFile1);
			DeltaRead (&docstruct.m_end_para, sizeof (long), 1, m_DFile1);
			DeltaRead (&docstruct.m_first_child, sizeof (long), 1, m_DFile1);
			DeltaRead (&docstruct.m_last_child, sizeof (long), 1, m_DFile1);
			old_map.insert (std::map<long,DocStruct>::value_type (docstruct.m_id, docstruct));
		}

		while (andCount--) {
			char mask;
			DeltaRead (&mask, sizeof (char), 1, m_DFile1);
			if (mask) {
				long m_id;
				DeltaRead (&m_id, sizeof (m_id), 1, m_DFile1);
				std::map<long,DocStruct>::iterator map_it = old_map.find (m_id);
				if (mask & 1) DeltaRead (&map_it->second.m_para_list_id, sizeof (long), 1, m_DFile1);
				if (mask & 2) DeltaRead (&map_it->second.m_para_list_type, sizeof (long), 1, m_DFile1);
				if (mask & 4) DeltaRead (&map_it->second.m_start_para, sizeof (long), 1, m_DFile1);
				if (mask & 8) DeltaRead (&map_it->second.m_end_para, sizeof (long), 1, m_DFile1);
				if (mask & 16) DeltaRead (&map_it->second.m_first_child, sizeof (long), 1, m_DFile1);
				if (mask & 32) DeltaRead (&map_it->second.m_last_child, sizeof (long), 1, m_DFile1);
			}
		}

		if (old_map.size ()) {
			long map_size = old_map.size ();
			std::map<long,long> mid_position;
			std::map<long,DocStruct>::const_iterator it;
			for (i = 0, it = old_map.begin (); it != old_map.end (); it++, i++)
				mid_position.insert (std::map<long,long>::value_type (it->second.m_id, i));
			//теперь мапу кладем в линейный массив
			DocStruct *docstructs = new DocStruct [map_size], *ptr = docstructs;
			for (it = old_map.begin (); it != old_map.end (); it++, ptr++) {
				memcpy (ptr, &it->second, sizeof (DocStruct));
				if (ptr->m_first_child) ptr->m_first_child = mid_position.find (ptr->m_first_child)->second;
				if (ptr->m_last_child) ptr->m_last_child = mid_position.find (ptr->m_last_child)->second;
			}
			docInd->Replace (lDocId, iTag, docstructs, sizeof (DocStruct) * map_size);
			delete [] docstructs;
		} else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
	}
		break;
	
	case IDD_SUBS_EX :
	{
		//в принципе, этот tag уже не используется

		StorableSplaySet<SubDescEx> set;
		{
		long size, i;
		SubDescEx *data = (SubDescEx*) docInd->Load (lDocId, IDD_SUBS_EX, size), *ptr = data;
		for (i = 0, size /= sizeof (SubDescEx); i < size; i++, ptr++)
			set.add (*ptr);
		gk_free (data);
		}

		//Remove Deleted Subs from index
		SubDescEx* delSub = (SubDescEx*)malloc (delCount * sizeof (SubDescEx));
		DeltaRead ( delSub, sizeof(SubDescEx), delCount, m_DFile1 );
		while (delCount--)
			set.del ( delSub [delCount] );	
		if ( delSub ) free ( delSub );

		//Add new Subs
		SubDescEx sub;
		while (addCount--) {
			DeltaRead ( &sub, sizeof (sub), 1, m_DFile1 );
			set.add( sub );
		}

		if ( set.length() ) {
			long size = set.length () * sizeof (SubDescEx);
			SubDescEx *data = (SubDescEx*) malloc (size), *ptr = data;
			for (Point point = set.first(); point; set.next(point), ptr++)
				memcpy (ptr, set [point], sizeof (SubDescEx));
			qsort (data, set.length (), sizeof (SubDescEx), compare_subdescex);
			docInd->Replace (lDocId, iTag, data, size);
			gk_free (data);
		} else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
	}
		break;

	case IDD_PREANNODATE :
		{
		StorableSplaySet<date> set;
		docInd->Load ( lDocId, iTag, set );

		date* dates = (date*)malloc( delCount * sizeof(date) );
		DeltaRead ( dates, sizeof(date), delCount, m_DFile1 );
		
		while ( delCount-- ) {
			set.del ( dates [delCount] );
		}
		if ( dates ) free ( dates );

		dates = (date*)malloc( addCount * sizeof(date) );
		DeltaRead ( dates, sizeof(date), addCount, m_DFile1 );

		while ( addCount-- ) {
			set.add ( dates [addCount] );
		}
		if ( dates ) free ( dates );

		if ( set.length() )
			docInd->Replace ( lDocId, iTag, set );
		else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
		}
		break;

	// DATE key
	case IDD_CALIN:
	case IDD_CALAB:
	case IDD_CALCH:
	case IDD_DATE:
	case IDD_VINCLUDED:
	case IDD_VCHANGED:
	case IDD_VABOLISHED:
	case IDD_RDATE:
	case IDD_SORTDATE:
	case IDD_VANONCED:
	case IDD_VLCONTROL:
	case IDD_ANNODATE:
		{
		StorableSplaySet<date> set;
		docInd->Load ( lDocId, iTag, set );

		date* dates = (date*)malloc( delCount * sizeof(date) );
		DeltaRead ( dates, sizeof(date), delCount, m_DFile1 );
		
		while ( delCount-- ) {
			set.del ( dates [delCount] );
			DelStreamDoc ( SelectIndex ( iTag ), dates + delCount, lDocId, iTag);
		}
		if ( dates ) free ( dates );

		dates = (date*)malloc( addCount * sizeof(date) );
		DeltaRead ( dates, sizeof(date), addCount, m_DFile1 );

		while ( addCount-- ) {
			set.add ( dates [addCount] );
			AddStreamDoc ( SelectIndex ( iTag ), dates + addCount, lDocId, iTag);
		}
		if ( dates ) free ( dates );

		if ( set.length() ) docInd->Replace ( lDocId, iTag, set );
		else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
	}
		break;

	// SHORT key
	case IDD_BASES:
	{
		if(docInd->Name[1] != 'T')
			docInd->Load ( lDocId, iTag, m_oldbases );
		m_newbases = m_oldbases;

		if ( m_dsm == dsmChgToNodoc || m_dsm_inpharm == dsmChgToNodoc )
			for ( Point p = m_oldbases.first (); p; m_oldbases.next (p) )
				DelStreamDoc ( SelectIndex ( iTag ), &m_oldbases.contents(p), lDocId, iTag);

		short* shorts = (short*)malloc( delCount * sizeof(short) );
		DeltaRead ( shorts, sizeof(short), delCount, m_DFile1 );
		
		while ( delCount-- ) {
			m_newbases.del ( shorts [delCount] );
			if ( m_dsm == dsmStayDoc || m_dsm_inpharm == dsmStayDoc)
				DelStreamDoc ( SelectIndex ( iTag ), shorts + delCount, lDocId, iTag);
		}
		if ( shorts ) free ( shorts );

		if ( m_dsm == dsmChgToDoc || m_dsm_inpharm == dsmChgToDoc)
			for ( Point p = m_newbases.first (); p; m_newbases.next (p) )
				AddStreamDoc ( SelectIndex ( iTag ), &m_newbases.contents(p), lDocId, iTag );

		shorts = (short*)malloc( addCount * sizeof(short) );
		DeltaRead ( shorts, sizeof(short), addCount, m_DFile1 );

		while ( addCount-- ) {
			m_newbases.add ( shorts [addCount] );
			if ( m_dsm == dsmStayDoc || m_dsm == dsmChgToDoc || m_dsm_inpharm == dsmStayDoc || m_dsm_inpharm == dsmChgToDoc ) 
				AddSegmentDoc ( SelectIndex ( IDD_BASES ), shorts + addCount, lDocId );
		}
		if ( shorts ) free ( shorts );

		if ( m_newbases.length() ) {
			if(docInd->Name[1] != 'T')
				docInd->Replace ( lDocId, iTag, m_newbases );
		} else {
			AttrKey aKey;
			aKey.DocId = lDocId;
			aKey.AttrTag = iTag;
			if ( docInd -> Delete ( &aKey ) != GKDB::BT_OK )
				logger.printf ( lt_error, "Can't delete Key (%ld, %d) from AttrIndex\n", aKey.DocId, aKey.AttrTag );
		}
	}
		break;

	default :
		logger.printf ( lt_fatal, "Unknown tag %d (doc %ld)\n", iTag, lDocId );
		_EXIT ( EXIT_FAILURE );
	}

	if (b_show_extended_log && log_str) {
		if (delta_buffer)
			new_delta_pos = delta_buffer_ptr - delta_buffer;
		else
			mpcxc_fgetpos (m_DFile1, &new_delta_pos);
		logger.printf (lt_updateInfo, " %ld bytes\n", new_delta_pos - delta_pos);
		if (b_flush_extended_log) logger.flush (lt_always);
		/*
		unsigned sec, msec, usec;
		Core::GDS::HiResCounterSingl::instance()->tiks_to_time(Core::GDS::HiResCounterSingl::instance()->get_count () - m_start_count, sec, msec, usec);
		logger.printf (lt_updateInfo, "%s updated in %ldsec.%ldmsec\n", log_str, sec, msec);
		logger.flush (lt_always);
		*/
	}
}

int UnFull::IsSkipDocName(long lDocId, int iDoIt)
{
	DocInfo    *pCurrent= 0;
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
	if(m_pNewInfo)
		pCurrent= m_pNewInfo;
	else
		pCurrent= m_pOldInfo;
#endif
	if (pCurrent->Status & (DS_DOC|DS_EDITION))
		return 0;
	else
		return 1;
}

int UnFull :: AddStrIndex ( int iTag, const char * pKeyStr, long lDocId )
{
	Index *pInd = SelectIndex ( iTag );
	if ( !pInd ) return 0;

	logger.printf ( lt_debug, cd_dos, "AddStrIndex: Ind=%s, Attr=%s\n", pInd->Name, pKeyStr );

	if (iTag == IDD_TAG) {
		char *pPureKey = strdup (strchr (pKeyStr, ':') + 1), *deli = strchr (pPureKey, ':');
		*deli++ = 0;
		RefwWeight aRef = {lDocId, atol (pKeyStr), atol (deli)};
		sscanf( pKeyStr, "%ld:", &aRef.Sub );
		AddStreamRef (pInd, pPureKey, aRef, iTag);
		free (pPureKey);
	} else
	if (iTag == IDD_SOURCE || iTag == IDD_KEY || iTag == IDD_DIV || iTag == IDD_PUBLISHEDIN ||
		iTag == IDD_TYPE || iTag == IDD_KIND || iTag == IDD_TERRITORY || iTag == IDD_DOCKIND ||
		iTag == IDD_ANNOUSER || iTag == IDD_ANNOORGANIZATION || iTag == IDD_ANNOTAX || iTag == IDD_ANNOINTEREST || iTag == IDD_ANNOKIND || iTag == IDD_SERVICEINFO || iTag == IDD_CLASS6 ||
		iTag == IDD_INPHARMFIRM || iTag == IDD_INPHARMCOUNTRY || iTag == IDD_ATC || iTag == IDD_REGSTATUS || iTag == IDD_LEKFORM || iTag == IDD_MKB ||
		iTag == IDD_PHARMGROUP || iTag == IDD_PHARMEFFECT || iTag == IDD_CHAPTER) 
	{
		Ref aRef = {lDocId, 0};
		char *pPureKey = 0, *pPrevLevel = 0;
		bool b_sub = (iTag==IDD_KEY || iTag==IDD_DIV || iTag==IDD_DOCKIND || iTag==IDD_TYPE || iTag == IDD_KIND || iTag == IDD_SERVICEINFO || iTag == IDD_CLASS6 || iTag == IDD_INPHARMFIRM || iTag == IDD_INPHARMCOUNTRY || iTag == IDD_REGSTATUS || iTag == IDD_LEKFORM || iTag == IDD_MKB || iTag == IDD_CHAPTER) ? true : false;
		if (b_sub) {
			// for key with sub
			sscanf( pKeyStr, "%ld:", &aRef.Sub );
			pPureKey = strdup ( strchr ( pKeyStr, ':' ) + 1 );
		} else {
			pPureKey = strdup ( pKeyStr );
		}

		do {
			int iRes;
			if (b_sub)
				iRes = AddStreamRef ( pInd, pPureKey, aRef, iTag);
			else
				iRes = AddStreamDoc ( pInd, pPureKey, lDocId, iTag);

			if ( !m_iDeSync ) m_iDeSync = iRes;

			// Moving from end of Source's branch to begin
			pPrevLevel = strrchr ( pPureKey, '\\' );
			if ( pPrevLevel ) *pPrevLevel = '\x0';
		} while ( pPrevLevel );

		free ( pPureKey );
	}
	else AddStreamDoc (pInd, pKeyStr, lDocId, iTag);

	return 1;
}

inline int CountLevels( const char* aKey )
{
	int aResult = 0;	
	for ( char* ptr = (char*) aKey; *ptr; ptr++ )
		if ( *ptr == '\\' ) aResult++;

	return aResult;
}

#ifdef	BLOCKSINHERIT
int UnFull :: DelStrIndex ( int iTag, const char * pKeyStr, long lDocId, int iDelLevel, StringZ* pKeys, StringZ* pDelKeys )
#else
int UnFull :: DelStrIndex ( int iTag, const char * pKeyStr, long lDocId, int iDelLevel, StringZ* pKeys )
#endif
{
	if ( !pKeyStr )
		return 1;

	Index *pInd = SelectIndex ( iTag );
	if ( !pInd ) return 0;

	logger.printf ( lt_debug, cd_dos, "DelStrIndex: Ind=%s, Attr=%s; iDelLevel=%d\n", pInd->Name, pKeyStr, iDelLevel );

	if (iTag == IDD_TAG) {
		char *pPureKey = strdup (strchr (pKeyStr, ':') + 1), *deli = strchr (pPureKey, ':');
		*deli++ = 0;
		RefwWeight aRef = {lDocId, atol (pKeyStr), atol (deli)};
		sscanf( pKeyStr, "%ld:", &aRef.Sub );
		DelStreamRef (pInd, pPureKey, aRef, iTag);
		free (pPureKey);
	} else
	if (iTag == IDD_ANNOUSER || iTag == IDD_ANNOORGANIZATION || iTag == IDD_ANNOTAX || iTag == IDD_ANNOINTEREST || iTag == IDD_ANNOKIND || iTag==IDD_SOURCE || iTag==IDD_KEY || iTag==IDD_DIV || iTag==IDD_PUBLISHEDIN || iTag == IDD_TYPE || iTag == IDD_KIND || iTag == IDD_TERRITORY || iTag == IDD_DOCKIND || iTag == IDD_SERVICEINFO || iTag == IDD_CLASS6 ||
		iTag == IDD_INPHARMFIRM || iTag == IDD_INPHARMCOUNTRY || iTag == IDD_ATC || iTag == IDD_REGSTATUS || iTag == IDD_LEKFORM || iTag == IDD_MKB ||
		iTag == IDD_TRADENAME || iTag == IDD_INTNAME || iTag == IDD_PHARMGROUP || iTag == IDD_PHARMEFFECT || iTag == IDD_CHAPTER) {
		Ref aRef = {lDocId, 0};
		char *pPureKey = 0, *pPrevLevel = 0;
		bool b_sub = (iTag==IDD_KEY || iTag==IDD_DIV || iTag==IDD_DOCKIND || iTag==IDD_TYPE || iTag == IDD_KIND || iTag == IDD_SERVICEINFO || iTag == IDD_CLASS6 || iTag == IDD_INPHARMFIRM || iTag == IDD_INPHARMCOUNTRY || iTag == IDD_REGSTATUS || iTag == IDD_LEKFORM || iTag == IDD_MKB || iTag == IDD_CHAPTER) ? true : false;

		if (b_sub) {
			// for key with sub
			sscanf( pKeyStr, "%ld:", &aRef.Sub );
			pPureKey = strdup ( strchr ( pKeyStr , ':' ) + 1 );
		} else {
			pPureKey = strdup ( pKeyStr );
		}

		int aMaxEquals = 0;
#ifdef	BLOCKSINHERIT
		if ( ( aRef.Sub & INHERITED_BLOCK ) && (iTag == IDD_DIV || iTag == IDD_TYPE /*|| iTag == IDD_MKB || iTag == IDD_CHAPTER*/) && pKeys ) {
			// если среди IDD_DIV есть !XXX, то надо добавить XXX взамен удаленного
			//делать это в случае, если этого XXX нет в удаляемых (pDelKeys)

			for ( int I = 0; I < pKeys -> GetCount(); I++ ) {
				const char* atI = pKeys->GetAt(I);
				long aSub; sscanf( atI, "%ld:", &aSub );
				if ( ( aSub != aRef.Sub ) && ( ( aRef.Sub & MINUS_INHERITED_BLOCK ) == aSub ) && pDelKeys->Find(atI)==-1 ) {
					char* pPureCopy = strdup( pPureKey ); char* spPureCopy = pPureCopy;
					char* ppPureKey = strdup( strchr( atI, ':' ) + 1 ); char* sppPureKey = ppPureKey;

					// подсчитать, сколько уровней совпадает
					int aEquals = 0;
					while ( 1 ) {
						char* pPurePos  = strchr( pPureCopy, '\\' ); if ( pPurePos  ) *pPurePos  = 0;
						char* ppPurePos = strchr( ppPureKey, '\\' ); if ( ppPurePos ) *ppPurePos = 0;
						if ( !strcmp( pPureCopy, ppPureKey )) {
							aEquals++;
							if ( !pPurePos || !ppPurePos )
								break;
							pPureCopy = pPurePos + 1;
							ppPureKey = ppPurePos + 1;
						} else
							break;
					}

					aMaxEquals = std::max( aMaxEquals, aEquals ); // GARANT_STL
					free( spPureCopy );
					free( sppPureKey );
				}
			}
		}
		if ( !( aRef.Sub & INHERITED_BLOCK ) && (iTag == IDD_DIV || iTag == IDD_TYPE /*|| iTag == IDD_MKB || iTag == IDD_CHAPTER*/) && pKeys ) {
			//вместо удаляемого XXX надо добавить !XXX
			//делать это в случае, если этого !XXX нет в удаляемых (pDelKeys)

			for ( int I = 0; I < pKeys -> GetCount(); I++ ) {
				//const char* atI = pKeys -> Get( I );
				pKeys->Seek(0);
				for ( int j = 0; j < I; j++ )
					++(*pKeys);
				const char* atI = pKeys->Get(pKeys->GetPos());
				pKeys->Seek(0);

				long aSub; sscanf( atI, "%ld:", &aSub );

				if ( ( aSub != aRef.Sub ) && ( ( aRef.Sub | INHERITED_BLOCK ) == aSub ) && pDelKeys->Find(atI)==-1 ) {
					char* pPureCopy = strdup( pPureKey ); char* spPureCopy = pPureCopy;
					char* ppPureKey = strdup( strchr( atI, ':' ) + 1 ); char* sppPureKey = ppPureKey;

					// подсчитать, сколько уровней совпадает
					int aEquals = 0;
					while ( 1 ) {
						char* pPurePos  = strchr( pPureCopy, '\\' ); if ( pPurePos  ) *pPurePos  = 0;
						char* ppPurePos = strchr( ppPureKey, '\\' ); if ( ppPurePos ) *ppPurePos = 0;
						if ( !strcmp( pPureCopy, ppPureKey )) {
							aEquals++;
							if ( !pPurePos || !ppPurePos )
								break;
							pPureCopy = pPurePos + 1;
							ppPureKey = ppPurePos + 1;
						} else
							break;
					}

					aMaxEquals = std::max( aMaxEquals, aEquals ); // GARANT_STL
					free( spPureCopy );
					free( sppPureKey );
				}
			}
		}
#endif

		int iDelKey = -1;
		int iPrevDelKey = -1;

		do {
			if (b_sub)
				iDelKey = DelStreamRef ( pInd, pPureKey, aRef, iTag, iTag==IDD_DIV, CountLevels( pPureKey ) < aMaxEquals );
			else
				iDelKey = DelStreamDoc ( pInd, pPureKey, lDocId, iTag, iTag==IDD_SOURCE /*prevent key deleting for pair index*/);

			if ( !iDelKey ) {
				logger.printf ( lt_error, "DelStrIndex: Can't delete key %s from %s (docId:%ld)\n", pPureKey, pInd->Name, lDocId );
				break;
			}

			if ( iDelKey < iPrevDelKey ) {
				logger.printf ( lt_error, "Delete parent key with live children (docId:%ld, key:%s)\n", lDocId, pPureKey );
				break;
			}
			iPrevDelKey = iDelKey;

			// Moving from the end of the hindex branche to begin
			pPrevLevel = strrchr ( pPureKey, '\\' );
			if ( pPrevLevel )
				*pPrevLevel = '\x0';

			iDelLevel--;
		} while ( pPrevLevel && iDelLevel );

		free ( pPureKey );
	}
	else DelStreamDoc ( pInd, pKeyStr, lDocId, iTag );

	return 1;
}

Index * UnFull :: SelectIndex ( int iTag )
{
	switch ( iTag ) {
	case IDD_INPHARMFIRM:
		return m_pNewBase->FindIndex( "PhFirm" );
	case IDD_INPHARMCOUNTRY:
		return m_pNewBase->FindIndex( "PhCountry" );
	case IDD_REGDATE:
		return m_pNewBase->FindIndex( "RegDate" );
	case IDD_ANNULDATE:
		return m_pNewBase->FindIndex( "AnnulDate" );
	case IDD_ACTIVEEX:
		return m_pNewBase->FindIndex( "Active" );
	case IDD_TRADENAME:
		return m_pNewBase->FindIndex( "TradeName" );
	case IDD_INTNAME:
		return m_pNewBase->FindIndex( "IntName" );
	case IDD_PHARMGROUP:
		return m_pNewBase->FindIndex( "PhGroup" );
	case IDD_PHARMEFFECT:
		return m_pNewBase->FindIndex( "PhEffect" );
	case IDD_CHAPTER:
		return m_pNewBase->FindIndex( "Chapter" );
	case IDD_ATC:
		return m_pNewBase->FindIndex( "Atc" );
	case IDD_REGSTATUS:
		return m_pNewBase->FindIndex( "RegStatus" );
	case IDD_LEKFORM:
		return m_pNewBase->FindIndex( "LekForm" );
	case IDD_MKB:
		return m_pNewBase->FindIndex( "Mkb" );
	case IDD_CLASS6 :
		return m_pNewBase->FindIndex( "Class6" );
	case IDD_SERVICEINFO :
		return m_pNewBase->FindIndex( "ServiceInfo" );
	case IDD_KEY :
		return m_pNewBase->FindIndex( "KeyWord" );
	case IDD_DIV :
		return m_pNewBase->FindIndex( "Class" );
	case IDD_DATE :
		return m_pNewBase->FindIndex( "Date" );
	case IDD_ID :
		return m_pNewBase->FindIndex( "Number" );
	case IDD_ADDCODE :
		return m_pNewBase->FindIndex( "Number" );
	case IDD_SOURCE :
		return m_pNewBase->FindIndex( "Adopted" );
	case IDD_TYPE :
		return m_pNewBase->FindIndex( "Type" );
	case IDD_TAG :
		return m_pNewBase->FindIndex( "Tag.str" );
	case IDD_KIND :
		return m_pNewBase->FindIndex( "Kind" );
	case IDD_RCODE :
		return m_pNewBase->FindIndex( "RCode" );
	case IDD_RDATE :
		return m_pNewBase->FindIndex( "RDate" );
	case IDD_CALIN :
		return m_pNewBase->FindIndex( "CalIn" );
	case IDD_CALAB :
		return m_pNewBase->FindIndex( "CalAb" );
	case IDD_CALCH :
		return m_pNewBase->FindIndex( "CalCh" );
	case IDD_VINCLUDED :
		return m_pNewBase->FindIndex( "VIncluded" );
	case IDD_VCHANGED :
		return m_pNewBase->FindIndex( "VChanged" );
	case IDD_VABOLISHED :
		return m_pNewBase->FindIndex( "VAbolished" );
	case IDD_SORTDATE :
		return m_pNewBase->FindIndex( "SortDate" );
	case IDD_VLCONTROL :
		return m_pNewBase->FindIndex( "VLControl" );
	case IDD_VANONCED :
		return m_pNewBase->FindIndex( "VAnonced" );
	case IDD_CATEGORY :
		return m_pNewBase->FindIndex( "Category" );
	case IDD_PUBLISHEDIN :
		return m_pNewBase->FindIndex( "PublishedIn" );
	case IDD_BASES :
		return m_pNewBase->FindIndex( "Segment" );
	case IDD_DOCKIND :
		return m_pNewBase->FindIndex( "DocKind" );
	case IDD_TERRITORY :
		return m_pNewBase->FindIndex( "Territory" );
	case IDD_ANNODATE:
		return m_pNewBase->FindIndex( "AnnoDate" );
	case IDD_ANNOUSER:
		return m_pNewBase->FindIndex( "AnnoUser" );
	case IDD_ANNOORGANIZATION:
		return m_pNewBase->FindIndex( "AnnoOrganization" );
	case IDD_ANNOTAX:
		return m_pNewBase->FindIndex( "AnnoTax" );
	case IDD_ANNOINTEREST:
		return m_pNewBase->FindIndex( "AnnoInterest" );
	case IDD_ANNOKIND:
		return m_pNewBase->FindIndex( "AnnoKind" );
	case IDD_WARNING :
	case IDD_INFO :
	case IDD_SUBS :
	case IDD_SOURCEFILE :
		return 0;

	default :
		logger.printf ( lt_fatal, "Unknown attr Tag %d\n", iTag );
		_EXIT ( EXIT_FAILURE );
	}
	return 0;
}

std::map<short,DocCollection*> status_cache, segment_cache;
std::map<std::string,std::deque <Ref> > class_cache, type_cache, kw_cache, kind_cache, dockind_cache, class6_cache, serviceinfo_cache;
std::map<std::string,std::deque <RefwWeight> > tag_cache;
std::map<std::string,std::deque <Ref> > mkb_cache, chapter_cache, regstatus_cache, lekform_cache, phfirm_cache, phcountry_cache;
std::map<long,std::deque <Ref> > regdate_cache, annuldate_cache, statusex_cache, active_cache;
std::map<std::string,std::deque <long> > adopted_cache, territory_cache, publishedin_cache, category_cache, intname_cache, tradename_cache;
std::map<std::string,std::deque <long> > annokind_cache, annointerest_cache, annotax_cache, annoorganization_cache, annouser_cache;
std::map<std::string,std::deque <long> > phgroup_cache, pheffect_cache, atc_cache;
std::map<std::string,std::deque <long> > number_cache, rcode_cache;
std::map<long, std::deque<long> > date_cache, rdate_cache, sortdate_cache, calin_cache, calab_cache, calch_cache, vanonced_cache, vincluded_cache, vchanged_cache, vabolished_cache, annodate_cache;

int UnFull::add_segment_status_doc (Index* index, short key, long doc_id, std::map<short,DocCollection*>* cache_map)
{
	int i_created = 0;
	std::map<short,DocCollection*>::iterator it = cache_map->find (key);
	DocCollection* docs;
	if (it == cache_map->end ()) {
		Stream *str = index->Open (&key, 1, &i_created);
		docs = new DocCollection;
		docs->Get (str);
		index->Close (str);
		cache_map->insert (std::map<short,DocCollection*>::value_type (key, docs));
	} else {
		docs = it->second;
	}
	docs->Add (doc_id);
	return i_created;
}

int UnFull::AddSegmentDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_segment_status_doc (pInd, *(short*)vpKey, lDocId, &segment_cache);
}

int UnFull::AddStatusDoc ( Index* pInd, const void* vpKey, long lDocId )
{
	return add_segment_status_doc (pInd, *(short*)vpKey, lDocId, &status_cache);
}

int UnFull::del_segment_status_doc (Index* index, short key, long doc_id, std::map<short,DocCollection*>* cache_map)
{
	std::map<short,DocCollection*>::iterator it = cache_map->find (key);
	DocCollection* docs;
	if (it == cache_map->end ()) {
		Stream *str = index->Open (&key);
		docs = new DocCollection;
		if (str) {
			docs->Get (str);
			index->Close (str);
		}
		cache_map->insert (std::map<short,DocCollection*>::value_type (key, docs));
	} else {
		docs = it->second;
	}

	docs->Del (doc_id);
	return 0;
}

int UnFull::DelStatusDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey )
{
	return del_segment_status_doc (pInd, *(short*)vpKey, lDocId, &status_cache);
}

int UnFull::DelSegmentDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey )
{
	return del_segment_status_doc (pInd, *(short*)vpKey, lDocId, &segment_cache);
}

int UnFull::AddStreamDoc ( Index* pInd, const void* vpKey, long lDocId, short tag)
{
	int iCreated = 0;
	if ( pInd && vpKey ) {
		switch (tag) {
			case IDD_CALIN:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &calin_cache);
				break;
			case IDD_CALAB:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &calab_cache);
				break;
			case IDD_CALCH:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &calch_cache);
				break;
			case IDD_DATE:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &date_cache);
				break;
			case IDD_RDATE:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &rdate_cache);
				break;
			case IDD_SORTDATE:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &sortdate_cache);
				break;
			case IDD_VANONCED:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &vanonced_cache);
				break;
			case IDD_VINCLUDED:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &vincluded_cache);
				break;
			case IDD_VABOLISHED:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &vabolished_cache);
				break;
			case IDD_VCHANGED:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &vchanged_cache);
				break;
			case IDD_ANNODATE:
				return add_date_doc (pInd, *(date*)vpKey, lDocId, &annodate_cache);
				break;
			case IDD_ID:
			case IDD_ADDCODE:
				return AddNumberDoc (pInd, vpKey, lDocId);
				break;
			case IDD_RCODE:
				return AddRCodeDoc (pInd, vpKey, lDocId);
				break;
			case IDD_BASES:
				return AddSegmentDoc (pInd, vpKey, lDocId);
				break;
			case IDD_SOURCE:
				return AddAdoptedDoc (pInd, vpKey, lDocId);
				break;
			case IDD_TERRITORY:
				return AddTerritoryDoc (pInd, vpKey, lDocId);
				break;
			case IDD_PHARMGROUP:
				return AddPhGroupDoc (pInd, vpKey, lDocId);
				break;
			case IDD_PHARMEFFECT:
				return AddPhEffectDoc (pInd, vpKey, lDocId);
				break;
			case IDD_ATC:
				return AddAtcDoc (pInd, vpKey, lDocId);
				break;
			case IDD_PUBLISHEDIN:
				return AddPublishedInDoc (pInd, vpKey, lDocId);
				break;
			case IDD_CATEGORY:
				return AddCategoryDoc (pInd, vpKey, lDocId);
				break;
			case IDD_ANNOUSER:
				return AddAnnoUserDoc (pInd, vpKey, lDocId);
				break;
			case IDD_ANNOKIND:
				return AddAnnoKindDoc (pInd, vpKey, lDocId);
				break;
			case IDD_ANNOTAX:
				return AddAnnoTaxDoc (pInd, vpKey, lDocId);
				break;
			case IDD_ANNOINTEREST:
				return AddAnnoInterestDoc (pInd, vpKey, lDocId);
				break;
			case IDD_ANNOORGANIZATION:
				return AddAnnoOrganizationDoc (pInd, vpKey, lDocId);
				break;

			case IDD_TRADENAME:
				return AddTradeNameDoc (pInd, vpKey, lDocId);
				break;
			case IDD_INTNAME:
				return AddIntNameDoc (pInd, vpKey, lDocId);
				break;

			default:
				logger.printf (lt_updateInfo, "add doc in index %s\n", pInd->Name);
				Stream *pStr = pInd->Open ( vpKey, 1, &iCreated );
				if ( !pStr ) {
					logger.printf ( lt_error, "Can't create Stream in %s (%ld)\n", pInd->Name, lDocId );
					return -1;
				}

				DocCollection aDocs;
				if (pStr->Length ()) aDocs.Get ( pStr );

				aDocs.Add ( lDocId );
				if (pStr->Length ()) pStr -> Seek ( 0 );
				aDocs.Put ( pStr );
				pInd->Close ( pStr );
		}
	}
	return iCreated;
}

int UnFull::del_adopted_territory_doc (Index* index, char* key, long doc_id, std::map<std::string,std::deque<long> >* cache_map)
{
	std::map<std::string, std::deque<long> >::iterator it = cache_map->find (key);
	if (it == cache_map->end ()) {
		std::deque<long> to_insert;
		to_insert.push_back (-doc_id);
		cache_map->insert (std::map<std::string, std::deque<long> >::value_type (key, to_insert));
	} else {
		it->second.push_back (-doc_id);
	}
	return 1;
}

int UnFull::DelAnnoKindDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annokind_cache);
}

int UnFull::DelAnnoInterestDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annointerest_cache);
}

int UnFull::DelAnnoTaxDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annotax_cache);
}

int UnFull::DelAnnoOrganizationDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annoorganization_cache);
}

int UnFull::DelAnnoUserDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annouser_cache);
}

int UnFull::DelCategoryDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &category_cache);
}

int UnFull::DelIntNameDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &intname_cache);
}

int UnFull::DelTradeNameDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &tradename_cache);
}

int UnFull::DelPublishedInDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &publishedin_cache);
}

int UnFull::DelAdoptedDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &adopted_cache);
}

int UnFull::DelTerritoryDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &territory_cache);
}

int UnFull::DelNumberDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	std::map<std::string, std::deque<long> >::iterator it = number_cache.find ((char*)vpKey);
	if (it != number_cache.end ()) {
		long size = it->second.size ();
		if (size && it->second [size - 1] == lDocId)			
			return 0;
	}
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &number_cache);
}

int UnFull::DelRCodeDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &rcode_cache);
}

int UnFull::DelPhGroupDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &phgroup_cache);
}

int UnFull::DelPhEffectDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &pheffect_cache);
}

int UnFull::DelAtcDoc (Index* pInd, const void* vpKey, long lDocId, int keepKey)
{
	return del_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &atc_cache);
}

int	UnFull::add_adopted_territory_doc (Index* index, char* key, long doc_id, std::map<std::string,std::deque<long> >* cache_map)
{
	std::map<std::string, std::deque<long> >::iterator it = cache_map->find (key);
	if (it == cache_map->end ()) {
		std::deque<long> to_insert;
		to_insert.push_back (doc_id);
		cache_map->insert (std::map<std::string, std::deque <long> >::value_type (key, to_insert));
	} else {
		it->second.push_back (doc_id);
	}
	return 1;
}

int UnFull::AddAnnoKindDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annokind_cache);
}

int UnFull::AddAnnoInterestDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annointerest_cache);
}

int UnFull::AddAnnoTaxDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annotax_cache);
}

int UnFull::AddAnnoOrganizationDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annoorganization_cache);
}

int UnFull::AddAnnoUserDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &annouser_cache);
}

int UnFull::AddCategoryDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &category_cache);
}

int UnFull::AddIntNameDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &intname_cache);
}

int UnFull::AddTradeNameDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &tradename_cache);
}

int	UnFull::AddPublishedInDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &publishedin_cache);
}

int	UnFull::AddAdoptedDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &adopted_cache);
}

int	UnFull::AddTerritoryDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &territory_cache);
}

int	UnFull::AddNumberDoc (Index* pInd, const void* vpKey, long lDocId)
{
	std::map<std::string, std::deque<long> >::iterator it = number_cache.find ((char*)vpKey);
	if (it != number_cache.end ()) {
		long size = it->second.size ();
		if (size && it->second [size - 1] == -lDocId)
			it->second.erase (it->second.begin () + size - 1);
	}
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &number_cache);
}

int	UnFull::AddRCodeDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &rcode_cache);
}

int	UnFull::AddPhGroupDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &phgroup_cache);
}

int	UnFull::AddPhEffectDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &pheffect_cache);
}

int	UnFull::AddAtcDoc (Index* pInd, const void* vpKey, long lDocId)
{
	return add_adopted_territory_doc (pInd, (char*)vpKey, lDocId, &atc_cache);
}

int UnFull::DelStreamDoc ( Index* pInd, const void* vpKey, long lDocId, short iTag, int keepKey )
{
	if ( pInd && vpKey ) {
		switch (iTag) {
			case IDD_CALIN:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &calin_cache);
				break;
			case IDD_CALAB:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &calab_cache);
				break;
			case IDD_CALCH:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &calch_cache);
				break;
			case IDD_DATE:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &date_cache);
				break;
			case IDD_RDATE:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &rdate_cache);
				break;
			case IDD_SORTDATE:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &sortdate_cache);
				break;
			case IDD_VANONCED:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &vanonced_cache);
				break;
			case IDD_VINCLUDED:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &vincluded_cache);
				break;
			case IDD_VABOLISHED:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &vabolished_cache);
				break;
			case IDD_VCHANGED:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &vchanged_cache);
				break;
			case IDD_ANNODATE:
				return del_date_doc (pInd, *(date*)vpKey, lDocId, &annodate_cache);
				break;
			case IDD_ID:
			case IDD_ADDCODE:
				return DelNumberDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_RCODE:
				return DelRCodeDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_BASES:
				return DelSegmentDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_SOURCE:
				return DelAdoptedDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_TERRITORY:
				return DelTerritoryDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_PHARMGROUP:
				return DelPhGroupDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_PHARMEFFECT:
				return DelPhEffectDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_ATC:
				return DelAtcDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_PUBLISHEDIN:
				return DelPublishedInDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_CATEGORY:
				return DelCategoryDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_INTNAME:
				return DelIntNameDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_TRADENAME:
				return DelTradeNameDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_ANNOUSER:
				return DelAnnoUserDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_ANNOKIND:
				return DelAnnoKindDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_ANNOTAX:
				return DelAnnoTaxDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_ANNOINTEREST:
				return DelAnnoInterestDoc (pInd, vpKey, lDocId, keepKey);
				break;
			case IDD_ANNOORGANIZATION:
				return DelAnnoOrganizationDoc (pInd, vpKey, lDocId, keepKey);
				break;
			default:
				logger.printf (lt_updateInfo, "del doc from index %s\n", pInd->Name);
				Stream *pStr = pInd->Open ( vpKey );
				if ( ! pStr ) {
					logger.printf ( lt_error, "DelStreamDoc: Can't open Stream in %s by key (%ld)\n", pInd->Name, lDocId );
					return 0;
				}

				DocCollection aDocs;
				aDocs.Get ( pStr );
				aDocs.Del ( lDocId );

				if ( !aDocs.ItemCount ) {
					if ( keepKey ) {
						logger.printf ( lt_debug, "DelStreamDoc: Keep empty key in Index %s (DocId %ld)\n", pInd->Name, lDocId );
					} else {			
						pInd->Close ( pStr );
						if ( pInd->Delete ( vpKey ) != GKDB::BT_OK )
							logger.printf ( lt_error, "DelStreamDoc: Can't delete key from Index %s (DocId %ld)\n", pInd->Name, lDocId );
						else
							logger.printf ( lt_debug, "DelStreamDoc: Delete empty key from Index %s (DocId %ld)\n", pInd->Name, lDocId );
						return -1;
					}
				}

				pStr->Seek ( 0 );
				aDocs.Put ( pStr );
				pStr->Trunc ();
				pInd->Close ( pStr );
				return 1;
		}
	}
	return 0;
}

void	delete_keys_in_index (Index *pind, std::vector<std::string> &delete_keys)
{
	std::map<long,std::vector <std::string> > delete_map;
	for (std::vector<std::string>::const_iterator it = delete_keys.begin (); it != delete_keys.end (); it++) {
		std::string atit = *it;
		long level = 0;
		for (std::string::const_iterator i = atit.begin (); i != atit.end (); i++)
			if (*i == '\\')
				level++;
		std::map<long,std::vector <std::string> >::iterator map_it = delete_map.find (level);
		if (map_it == delete_map.end ()) {
			std::vector<std::string> vector_to_insert;
			vector_to_insert.push_back (atit);
			delete_map.insert (std::map<long,std::vector <std::string> >::value_type (level, vector_to_insert));
		} else {
			map_it->second.push_back (atit);
		}
	}
	for (std::map<long,std::vector <std::string> >::reverse_iterator delete_it = delete_map.rbegin (); delete_it != delete_map.rend (); delete_it++)
		for (std::vector<std::string>::const_iterator it = delete_it->second.begin (); it != delete_it->second.end (); it++)
			pind->Delete (it->c_str ());
	delete_keys.clear ();
}

void	delete_dates_in_index (Index *pind, std::vector<long> &delete_keys)
{
	for (std::vector<long>::const_iterator it = delete_keys.begin (); it != delete_keys.end (); it++) {
		long key = *it;
		pind->Delete (&key);
	}
	delete_keys.clear ();
}

void	delete_shorts_in_index (Index *pind, std::vector<long> &delete_keys)
{
	for (std::vector<long>::const_iterator it = delete_keys.begin (); it != delete_keys.end (); it++) {
		unsigned short key = (unsigned short)(*it & 0xFFFF);
		pind->Delete (&key);
	}
	delete_keys.clear ();
}

std::vector<std::string> delete_class_keys, delete_type_keys, delete_kw_keys, delete_kind_keys, delete_dockind_keys, delete_adopted_keys, delete_territory_keys, delete_class6_keys, delete_publishedin_keys, delete_category_keys, delete_number_keys, delete_rcode_keys, delete_tag_keys, delete_serviceinfo_keys, delete_intname_keys, delete_tradename_keys;
std::vector<std::string> delete_annointerest_keys, delete_annokind_keys, delete_annotax_keys, delete_annoorganization_keys, delete_annouser_keys;
std::vector<std::string> delete_mkb_keys, delete_chapter_keys, delete_regstatus_keys, delete_lekform_keys, delete_phfirm_keys, delete_phcountry_keys;
std::vector<long> delete_regdate_keys, delete_annuldate_keys, delete_statusex_keys, delete_active_keys;
std::vector<std::string> delete_phgroup_keys, delete_pheffect_keys, delete_atc_keys;
std::vector<long> delete_date_keys, delete_rdate_keys, delete_sortdate_keys, delete_calin_keys, delete_calab_keys, delete_calch_keys, delete_vanonced_keys, delete_vincluded_keys, delete_vabolished_keys, delete_vchanged_keys, delete_annodate_keys;

void	UnFull::flush_tag (Index* index, std::map<std::string, std::deque<RefwWeight> > *cache_map, bool b_class_merge, std::vector<std::string> *delete_keys)
{
	for (std::map<std::string,std::deque <RefwWeight> >::const_iterator it = cache_map->begin (); it != cache_map->end (); it++) {
	  char *key = strdup (it->first.c_str ());
	  Stream *str = index->Open (key, 1);
	  if(str){
		RefwWeightCollection *refs = new RefwWeightCollection;
		refs->Get (str);
		str->Seek (0);
		for (std::deque<RefwWeight>::const_iterator refit = it->second.begin (); refit != it->second.end (); refit++) {
			RefwWeight ref = *refit;
			bool aAddRef = 0;
			if (ref.DocId > 0) {
				refs->Insert (&ref);
			} else {
				ref.DocId = -ref.DocId;
				refs->Delete (&ref);
			}
		}
		refs->Put (str);
		str->Trunc ();
		index->Close (str);
		if (!refs->ItemCount)
			delete_keys->push_back (key);
		delete refs;
	  }
	  gk_free (key);
	}	
	cache_map->clear ();

}

void	UnFull::flush_class_type_dockind (Index* index, std::map<std::string, std::deque<Ref> > *cache_map, bool b_class_merge, std::vector<std::string> *delete_keys)
{
	for (std::map<std::string,std::deque <Ref> >::const_iterator it = cache_map->begin (); it != cache_map->end (); it++) {
	  char *key = strdup (it->first.c_str ());
	  Stream *str = index->Open (key, 1);
	  if(str){
		RefCollection *refs = new RefCollection;
		refs->Get (str);
		str->Seek (0);
		for (std::deque<Ref>::const_iterator refit = it->second.begin (); refit != it->second.end (); refit++) {
			Ref ref = *refit;
			bool aAddRef = 0;
			if (ref.DocId > 0) {
				bClassMerge = b_class_merge;
				refs->Add (ref);
				bClassMerge = false;
			} else {
				ref.DocId = -ref.DocId;
				if (ref.Sub < 0) {
					aAddRef = true;
					ref.Sub = -ref.Sub;
				}
				refs->Del (ref);
				if ((ref.Sub & INHERITED_BLOCK) && aAddRef) {
					Ref aaRef = { ref.DocId, ref.Sub & MINUS_INHERITED_BLOCK };
					refs->Add (aaRef);
				}
				if (aAddRef && !(ref.Sub & INHERITED_BLOCK)) {
					Ref aaRef = { ref.DocId, ref.Sub | INHERITED_BLOCK };
					refs->Add (aaRef);
				}
			}
		}
		refs->Put (str);
		str->Trunc ();
		index->Close (str);
		if (!refs->ItemCount)
			delete_keys->push_back (key);
		delete refs;
	  }
	  gk_free (key);
	}	
	cache_map->clear ();

	/*
	if (b_tune) {
		std::map<long,HIndex::HIndexKey*> id_keys;
		std::map<long,std::set<long> > child_ids;
		std::map<long,RefCollection*> index_data;
		std::map<long,long> own_id;
		HIndex *hindex = (HIndex*)index;
		for (BTIterator it (hindex); !it.End (); ++it) {
			HIndex::HIndexKey *key = (HIndex::HIndexKey*) malloc (hindex->KeyLength);
			memcpy (key, it.Key (), hindex->KeyLength);
			id_keys.insert (std::map<long,HIndex::HIndexKey*>::value_type (key->id, key));

			if (key->achCount + key->chCount) {
				own_id.insert (std::map<long,long>::value_type (key->id, key->parent));
				std::set<long> empty_childs;
				child_ids.insert (std::map<long,std::set<long> >::value_type (key->id, empty_childs));
			} else {
				long parent = key->parent;
				while (parent) {
					std::map<long,std::set<long> >::iterator map_iter = child_ids.find (parent);
					if (map_iter != child_ids.end ())
						map_iter->second.insert (key->id);
					parent = own_id.find (parent)->second;
				}
				Stream* str = hindex->Index::OpenN (key, 0);
				RefCollection* refs = new RefCollection;
				if (str) {
					refs->Get (str);
					hindex->Close (str);
				}
				index_data.insert (std::map<long,RefCollection*>::value_type (key->id, refs));
			}
		}

		for (std::map<long,std::set<long> >::const_iterator map_iter = child_ids.begin (); map_iter != child_ids.end (); map_iter++) {
			RefCollection *refs = new RefCollection;
			std::vector<u_int64_t> merged;

			Stream* str = hindex->Index::OpenN (id_keys.find (map_iter->first)->second, 0);
			if (str) {
				RefCollection to_merge;
				to_merge.Get (str);
				hindex->Close (str);
				for (int i = 0; i < to_merge.ItemCount; i++) {
					Ref at_i = to_merge.GetItem (i);
					u_int64_t ref = ((u_int64_t(at_i.DocId)) << 32) + at_i.Sub;
					merged.push_back (ref);
				}
			}
			for (std::set<long>::const_iterator it = map_iter->second.begin (); it != map_iter->second.end (); it++) {
				RefCollection* to_merge = index_data.find (*it)->second;
				for (int i = 0; i < to_merge->ItemCount; i++) {
					Ref at_i = to_merge->GetItem (i);
					u_int64_t ref = ((u_int64_t(at_i.DocId)) << 32) + at_i.Sub;
					merged.push_back (ref);
				}
			}
			std::sort (merged.begin (), merged.end ());
			merged.erase (std::unique (merged.begin (), merged.end ()), merged.end ());
			for (std::vector<u_int64_t>::const_iterator it2 = merged.begin (); it2 != merged.end (); it2++) {
				u_int64_t at_it2 = *it2;
				Ref ref = {at_it2 >> 32, at_it2 & 0xFFFFFFFF};
				refs->Collection::Add (&ref);
			}

			str = hindex->Index::OpenN (id_keys.find (map_iter->first)->second, 0);
			if (str) {
				refs->Put (str);
				str->Trunc ();
				hindex->Close (str);
			}
			delete refs;
		}
	}
	*/
}

void	UnFull::flush_reganunldate (Index* index, std::map<long, std::deque<Ref> > *cache_map, std::vector<long> *delete_keys)
{
	for (std::map<long,std::deque <Ref> >::const_iterator it = cache_map->begin (); it != cache_map->end (); it++) {
		long key = it->first;
		Stream *str = index->Open (&key, 1);
		RefCollection *refs = new RefCollection;
		refs->Get (str);
		str->Seek (0);
		for (std::deque<Ref>::const_iterator refit = it->second.begin (); refit != it->second.end (); refit++) {
			Ref ref = *refit;
			bool aAddRef = 0;
			if (ref.DocId > 0) {
				bClassMerge = false;
				refs->Add (ref);
			} else {
				ref.DocId = -ref.DocId;
				if (ref.Sub < 0) {
					aAddRef = true;
					ref.Sub = -ref.Sub;
				}
				refs->Del (ref);
				if ((ref.Sub & INHERITED_BLOCK) && aAddRef) {
					Ref aaRef = { ref.DocId, ref.Sub & MINUS_INHERITED_BLOCK };
					refs->Add (aaRef);
				}
				if (aAddRef && !(ref.Sub & INHERITED_BLOCK)) {
					Ref aaRef = { ref.DocId, ref.Sub | INHERITED_BLOCK };
					refs->Add (aaRef);
				}
			}
		}
		refs->Put (str);
		str->Trunc ();
		index->Close (str);
		if (!refs->ItemCount)
			delete_keys->push_back (key);
		delete refs;
	}	
	cache_map->clear ();
}

void	UnFull::flush_date (Index* index, std::map<long, std::deque<long> > *cache_map, std::vector<long> *delete_keys)
{
	for (std::map<long,std::deque <long> >::const_iterator it = cache_map->begin (); it != cache_map->end (); it++) {
		long key = it->first;
		Stream *str = index->Open (&key, 1);
		DocCollection *docs = new DocCollection;
		docs->Get (str);
		str->Seek (0);
		for (std::deque<long>::const_iterator docit = it->second.begin (); docit != it->second.end (); docit++) {
			long doc = *docit;
			if (doc > 0) {
				docs->Add (doc);
			} else {
				docs->Del (-doc);
			}
		}
		docs->Put (str);
		str->Trunc ();
		index->Close (str);
		if (!docs->ItemCount)
			delete_keys->push_back (key);
		delete docs;
	}	
	cache_map->clear ();
}

void	UnFull::flush_statusex (Index* index, std::map<long, std::deque<Ref> > *cache_map, std::vector<long> *delete_keys)
{
	for (std::map<long,std::deque <Ref> >::const_iterator it = cache_map->begin (); it != cache_map->end (); it++) {
		unsigned short key = (unsigned short)(it->first & 0xFFFF);
		Stream *str = index->Open (&key, 1);
		RefCollection *refs = new RefCollection;
		refs->Get (str);
		str->Seek (0);
		for (std::deque<Ref>::const_iterator refit = it->second.begin (); refit != it->second.end (); refit++) {
			Ref ref = *refit;
			bClassMerge = false;
			if (ref.DocId > 0) {
				refs->Add (ref);
			} else {
				ref.DocId = -ref.DocId;
				if (ref.Sub < 0) ref.Sub = -ref.Sub;
				refs->Del (ref);
			}
		}
		refs->Put (str);
		str->Trunc ();
		index->Close (str);
		if (!refs->ItemCount)
			delete_keys->push_back (key);
		delete refs;
	}	
	cache_map->clear ();
}

void	UnFull::flush_segment_status (Index* index, std::map<short, DocCollection*> *cache_map)
{
	for (std::map<short,DocCollection*>::const_iterator it = cache_map->begin (); it != cache_map->end (); it++) {
		short key = it->first;
		DocCollection *docs = it->second;
		if (docs->ItemCount) {
			int iCreated = 0;
			Stream *str = index->Open (&key, 1, &iCreated);
			docs->Put (str);
			str->Trunc ();
			index->Close (str);
		} else {
			index->Delete (&key);
		}
		delete docs;
	}
	cache_map->clear ();
}

void	UnFull::flush_adopted_territory (Index* index, std::map<std::string, std::deque<long> > *cache_map, std::vector<std::string> *delete_keys)
{
	bool b_codeindex = index == SelectIndex (IDD_ID) || index == SelectIndex (IDD_RCODE);
	bool b_categoryindex = index == SelectIndex (IDD_CATEGORY);
	for (std::map<std::string, std::deque<long> >::const_iterator it = cache_map->begin (); it != cache_map->end (); it++) {
		char* key;
		if (b_codeindex) {
			key = new char [std::max<long> (CODE_KEY_SIZE, it->first.size () + 1)];
		} else if (b_categoryindex) {
			key = new char [std::max<long> (CATEGORY_KEY_SIZE, it->first.size () + 1)];
		} else {
			key = new char [it->first.size () + 1];
		}
		strcpy (key, it->first.c_str ());
		DocCollection *docs = new DocCollection;
		Stream *str = index->Open (key, 1);
		if (str){
			docs->Get (str);
			str->Seek (0);
			for (std::deque<long>::const_iterator docit = it->second.begin (); docit != it->second.end (); docit++) {
				long doc_id = *docit;
				if (doc_id > 0)
					docs->Add (doc_id);
				else
					docs->Del (-doc_id);
			}
			docs->Put (str);
			str->Trunc ();
			index->Close (str);
			if (!docs->ItemCount)
				delete_keys->push_back (key);

			delete docs;
		}
		delete [] key;
	}
	cache_map->clear ();
}

void	UnFull::flush_caches (bool b_delete)
{
	if (b_delete) {
		delete_keys_in_index (SelectIndex (IDD_DIV), delete_class_keys);
		delete_keys_in_index (SelectIndex (IDD_TYPE), delete_type_keys);
		delete_keys_in_index (SelectIndex (IDD_KEY), delete_kw_keys);
		delete_keys_in_index (SelectIndex (IDD_KIND), delete_kind_keys);
		delete_keys_in_index (SelectIndex (IDD_DOCKIND), delete_dockind_keys);
		delete_keys_in_index (SelectIndex (IDD_SOURCE), delete_adopted_keys);
		delete_keys_in_index (SelectIndex (IDD_TERRITORY), delete_territory_keys);
		if (!b_ovp) delete_keys_in_index (SelectIndex (IDD_CLASS6), delete_class6_keys);
		delete_keys_in_index (SelectIndex (IDD_SERVICEINFO), delete_serviceinfo_keys);
		delete_keys_in_index (SelectIndex (IDD_PUBLISHEDIN), delete_publishedin_keys);
		delete_keys_in_index (SelectIndex (IDD_CATEGORY), delete_category_keys);
		delete_keys_in_index (SelectIndex (IDD_INTNAME), delete_intname_keys);
		delete_keys_in_index (SelectIndex (IDD_TRADENAME), delete_tradename_keys);
		delete_keys_in_index (SelectIndex (IDD_ID), delete_number_keys);
		delete_keys_in_index (SelectIndex (IDD_RCODE), delete_rcode_keys);
		delete_keys_in_index (SelectIndex (IDD_ANNOKIND), delete_annokind_keys);
		delete_keys_in_index (SelectIndex (IDD_ANNOTAX), delete_annotax_keys);
		delete_keys_in_index (SelectIndex (IDD_ANNOUSER), delete_annouser_keys);
		delete_keys_in_index (SelectIndex (IDD_ANNOORGANIZATION), delete_annoorganization_keys);
		delete_keys_in_index (SelectIndex (IDD_ANNOINTEREST), delete_annointerest_keys);
		delete_keys_in_index (SelectIndex (IDD_TAG), delete_tag_keys);

		delete_keys_in_index (SelectIndex (IDD_MKB), delete_mkb_keys);
		delete_keys_in_index (SelectIndex (IDD_CHAPTER), delete_chapter_keys);
		delete_keys_in_index (SelectIndex (IDD_REGSTATUS), delete_regstatus_keys);
		delete_keys_in_index (SelectIndex (IDD_LEKFORM), delete_lekform_keys);
		delete_keys_in_index (SelectIndex (IDD_INPHARMFIRM), delete_phfirm_keys);
		delete_keys_in_index (SelectIndex (IDD_INPHARMCOUNTRY), delete_phcountry_keys);

		delete_dates_in_index (SelectIndex (IDD_REGDATE), delete_regdate_keys);
		delete_dates_in_index (SelectIndex (IDD_ANNULDATE), delete_annuldate_keys);
		delete_shorts_in_index (m_pNewBase->FindIndex ("Status_ex"), delete_statusex_keys);

		delete_keys_in_index (SelectIndex (IDD_PHARMGROUP), delete_phgroup_keys);
		delete_keys_in_index (SelectIndex (IDD_PHARMEFFECT), delete_pheffect_keys);
		delete_keys_in_index (SelectIndex (IDD_ATC), delete_atc_keys);

		delete_dates_in_index (SelectIndex (IDD_ACTIVEEX), delete_active_keys);
		delete_dates_in_index (SelectIndex (IDD_DATE), delete_date_keys);
		delete_dates_in_index (SelectIndex (IDD_RDATE), delete_rdate_keys);
		delete_dates_in_index (SelectIndex (IDD_SORTDATE), delete_sortdate_keys);
		delete_dates_in_index (SelectIndex (IDD_VANONCED), delete_vanonced_keys);
		delete_dates_in_index (SelectIndex (IDD_VINCLUDED), delete_vincluded_keys);
		delete_dates_in_index (SelectIndex (IDD_VABOLISHED), delete_vabolished_keys);
		delete_dates_in_index (SelectIndex (IDD_VCHANGED), delete_vchanged_keys);
		delete_dates_in_index (SelectIndex (IDD_ANNODATE), delete_annodate_keys);
		delete_dates_in_index (SelectIndex (IDD_CALIN), delete_calin_keys);
		delete_dates_in_index (SelectIndex (IDD_CALAB), delete_calab_keys);
		delete_dates_in_index (SelectIndex (IDD_CALCH), delete_calch_keys);
	} else {
		struct	tm	*pNewTime;
		time_t		long_time;

		screen->SetMessage (b_english_face ? "Updating document's names..." : "Обновление имен документов...");
		screen->SetProgress (0);
		int old_perc = 0, total_count = del_subnames.size () + add_subnames.size (), count = 0;

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush SubName at %s", asctime (pNewTime));
		Index *subnames = m_pNewBase->subNames;

		std::deque<Ref>::const_iterator deq_it;
		for (deq_it = del_subnames.begin (); deq_it != del_subnames.end (); deq_it++, count++) {
			Ref ref = *deq_it;
			subnames->Delete (&ref);

			int new_perc = (count * 100) / total_count;
			if (new_perc != old_perc)
				screen->SetProgress (old_perc = new_perc);
		}
		del_subnames.clear ();

		for (int cycle = 0; cycle < 2; cycle++) {
			std::deque<char*>::iterator name_it = add_subnames_chars.begin ();
			std::deque<long>::const_iterator size_it = add_subnames_sizes.begin ();
			for (deq_it = add_subnames.begin (); deq_it != add_subnames.end (); deq_it++, name_it++, size_it++) {
				Ref ref = *deq_it;
				if ((ref.DocId && !cycle) || (cycle && !ref.DocId))
					continue;

				int new_perc = (++count * 100) / total_count;
				if (new_perc != old_perc)
					screen->SetProgress (old_perc = new_perc);

				char* name = *name_it;
				Stream* str = subnames->Open (&ref, 1);
				if (str) {
					str->Write (name, *size_it);
					str->Trunc ();
					subnames->Close (str);
				}
				delete [] name;
			}
		}
		add_subnames.clear ();
		add_subnames_sizes.clear ();
		add_subnames_chars.clear ();

		screen->SetMessage (b_english_face ? "Updating indexes..." : "Обновление поисковых индексов...");
		screen->SetProgress (0);
		float progress_step = 100.0 / 47.0, current_progress = 0;

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush CalIn at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_CALIN), &calin_cache, &delete_calin_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush CalAb at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_CALAB), &calab_cache, &delete_calab_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);
		
		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush CalCh at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_CALCH), &calch_cache, &delete_calch_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Class at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_DIV), &class_cache, true, &delete_class_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Type at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_TYPE), &type_cache, false, &delete_type_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Tag at %s", asctime (pNewTime));
		flush_tag (SelectIndex (IDD_TAG), &tag_cache, false, &delete_tag_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush KeyWord at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_KEY), &kw_cache, false, &delete_kw_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Kind at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_KIND), &kind_cache, false, &delete_kind_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);
		
		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush DocKind at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_DOCKIND), &dockind_cache, false, &delete_dockind_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Segment at %s", asctime (pNewTime));
		flush_segment_status (SelectIndex (IDD_BASES), &segment_cache);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Status at %s", asctime (pNewTime));
		flush_segment_status (m_pNewBase->FindIndex ("Status"), &status_cache);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Adopted at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_SOURCE), &adopted_cache, &delete_adopted_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Territory at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_TERRITORY), &territory_cache, &delete_territory_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Number at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_ID), &number_cache, &delete_number_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);
		
		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush RCode at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_RCODE), &rcode_cache, &delete_rcode_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Class6 at %s", asctime (pNewTime));
		if (!b_ovp) flush_class_type_dockind (SelectIndex (IDD_CLASS6), &class6_cache, false, &delete_class6_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush ServiceInfo at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_SERVICEINFO), &serviceinfo_cache, false, &delete_serviceinfo_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush PublishedIn at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_PUBLISHEDIN), &publishedin_cache, &delete_publishedin_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Category at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_CATEGORY), &category_cache, &delete_category_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush IntName at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_INTNAME), &intname_cache, &delete_intname_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush TradeName at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_TRADENAME), &tradename_cache, &delete_tradename_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush AnnoUser at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_ANNOUSER), &annouser_cache, &delete_annouser_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush AnnoTax at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_ANNOTAX), &annotax_cache, &delete_annotax_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush AnnoKind at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_ANNOKIND), &annokind_cache, &delete_annokind_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush AnnoInterest at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_ANNOINTEREST), &annointerest_cache, &delete_annointerest_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush AnnoOrganization at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_ANNOORGANIZATION), &annoorganization_cache, &delete_annoorganization_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Mkb at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_MKB), &mkb_cache, false, &delete_mkb_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Chapter at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_CHAPTER), &chapter_cache, false, &delete_chapter_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush RegStatus at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_REGSTATUS), &regstatus_cache, false, &delete_regstatus_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush LekForm at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_LEKFORM), &lekform_cache, false, &delete_lekform_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush PhFirm at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_INPHARMFIRM), &phfirm_cache, false, &delete_phfirm_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush PhCountry at %s", asctime (pNewTime));
		flush_class_type_dockind (SelectIndex (IDD_INPHARMCOUNTRY), &phcountry_cache, false, &delete_phcountry_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush RegDate at %s", asctime (pNewTime));
		flush_reganunldate (SelectIndex (IDD_REGDATE), &regdate_cache, &delete_regdate_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush AnnulDate at %s", asctime (pNewTime));
		flush_reganunldate (SelectIndex (IDD_ANNULDATE), &annuldate_cache, &delete_annuldate_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush ActiveEx at %s", asctime (pNewTime));
		flush_reganunldate (SelectIndex (IDD_ACTIVEEX), &active_cache, &delete_active_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Status_ex at %s", asctime (pNewTime));
		flush_statusex (m_pNewBase->FindIndex ("Status_ex"), &statusex_cache, &delete_statusex_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush PhGroup at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_PHARMGROUP), &phgroup_cache, &delete_phgroup_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush PhEffect at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_PHARMEFFECT), &pheffect_cache, &delete_pheffect_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Atc at %s", asctime (pNewTime));
		flush_adopted_territory (SelectIndex (IDD_ATC), &atc_cache, &delete_atc_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush Date at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_DATE), &date_cache, &delete_date_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush RDate at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_RDATE), &rdate_cache, &delete_rdate_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush SortDate at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_SORTDATE), &sortdate_cache, &delete_sortdate_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush VAnonced at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_VANONCED), &vanonced_cache, &delete_vanonced_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush VIncluded at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_VINCLUDED), &vincluded_cache, &delete_vincluded_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush VChanged at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_VCHANGED), &vchanged_cache, &delete_vchanged_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush VAbolished at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_VABOLISHED), &vabolished_cache, &delete_vabolished_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "flush AnnoDate at %s", asctime (pNewTime));
		flush_date (SelectIndex (IDD_ANNODATE), &annodate_cache, &delete_annodate_keys);
		current_progress += progress_step; screen->SetProgress ((int) current_progress);

		time (&long_time); pNewTime = localtime (&long_time);
		logger.printf (lt_updateInfo, "end flushes at %s", asctime (pNewTime));
		logger.flush (lt_always);
	}
}

int UnFull::add_class_type_dockind_ref (Index* index, char* key, Ref ref, std::map<std::string, std::deque<Ref> >* cache_map)
{
	std::map<std::string, std::deque<Ref> >::iterator it = cache_map->find (key);
	if (it == cache_map->end ()) {
		std::deque<Ref> to_insert;
		to_insert.push_back (ref);
		cache_map->insert (std::map<std::string, std::deque <Ref> >::value_type (key, to_insert));
	} else {
		it->second.push_back (ref);
	}
	return 1;
}

int UnFull::add_regannuldate_ref (Index* index, date key, Ref ref, std::map<long, std::deque<Ref> >* cache_map)
{
	std::map<long, std::deque<Ref> >::iterator it = cache_map->find (*(long*)&key);
	if (it == cache_map->end ()) {
		std::deque<Ref> to_insert;
		to_insert.push_back (ref);
		cache_map->insert (std::map<long, std::deque <Ref> >::value_type (*(long*)&key, to_insert));
	} else {
		it->second.push_back (ref);
	}
	return 1;
}

int UnFull::add_date_doc (Index* index, date key, long docid, std::map<long, std::deque<long> >* cache_map)
{
	std::map<long, std::deque<long> >::iterator it = cache_map->find (*(long*)&key);
	if (it == cache_map->end ()) {
		std::deque<long> to_insert;
		to_insert.push_back (docid);
		cache_map->insert (std::map<long, std::deque <long> >::value_type (*(long*)&key, to_insert));
	} else {
		it->second.push_back (docid);
	}
	return 1;
}

int UnFull::del_statusex_ref (Index* index, long key, Ref ref, std::map<long, std::deque<Ref> >* cache_map, bool add_ref)
{
	ref.DocId = -ref.DocId;
	if (add_ref) ref.Sub = -ref.Sub;
	std::map<long, std::deque<Ref> >::iterator it = cache_map->find (*(long*)&key);
	if (it == cache_map->end ()) {
		std::deque<Ref> to_insert;
		to_insert.push_back (ref);
		cache_map->insert (std::map<long, std::deque <Ref> >::value_type (*(long*)&key, to_insert));
	} else {
		it->second.push_back (ref);
	}
	return 1;
}

int UnFull::DelStatusExRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_statusex_ref (pInd, *(long*)vpKey, aRef, &statusex_cache, aAddRef);
}

int UnFull::add_statusex_ref (Index* index, long key, Ref ref, std::map<long, std::deque<Ref> >* cache_map)
{
	int i_created = 0;
	std::map<long, std::deque<Ref> >::iterator it = cache_map->find (key);
	if (it == cache_map->end ()) {
		std::deque<Ref> to_insert;
		to_insert.push_back (ref);
		cache_map->insert (std::map<long, std::deque <Ref> >::value_type (key, to_insert));
	} else {
		it->second.push_back (ref);
	}
	return i_created;
}

int	UnFull::AddStatusExRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_statusex_ref (pInd, *(long*)vpKey, aRef, &statusex_cache);
}

int	UnFull::AddClassRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &class_cache);
}

int	UnFull::AddTypeRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &type_cache);
}

int	UnFull::AddTagRef (Index* pInd, const void* vpKey, RefwWeight ref)
{
	char *key = (char*) vpKey;
	std::map<std::string, std::deque<RefwWeight> >::iterator it = tag_cache.find (key);
	if (it == tag_cache.end ()) {
		std::deque<RefwWeight> to_insert;
		to_insert.push_back (ref);
		tag_cache.insert (std::map<std::string, std::deque <RefwWeight> >::value_type (key, to_insert));
	} else {
		it->second.push_back (ref);
	}
	return 1;
}

int	UnFull::DelTagRef (Index* pInd, const void* vpKey, RefwWeight ref)
{
	ref.DocId = -ref.DocId;
	char *key = (char*) vpKey;
	std::map<std::string, std::deque<RefwWeight> >::iterator it = tag_cache.find (key);
	if (it == tag_cache.end ()) {
		std::deque<RefwWeight> to_insert;
		to_insert.push_back (ref);
		tag_cache.insert (std::map<std::string, std::deque <RefwWeight> >::value_type (key, to_insert));
	} else {
		it->second.push_back (ref);
	}
	return 1;
}

int	UnFull::AddKWRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &kw_cache);
}

int	UnFull::AddActiveRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_regannuldate_ref (pInd, *(date*)vpKey, aRef, &active_cache);
}

int	UnFull::AddKindRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &kind_cache);
}

int	UnFull::AddClass6Ref (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &class6_cache);
}

int	UnFull::AddServiceInfoRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &serviceinfo_cache);
}

int	UnFull::AddDocKindRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &dockind_cache);
}

int	UnFull::AddMkbRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &mkb_cache);
}

int	UnFull::AddChapterRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &chapter_cache);
}

int	UnFull::AddRegStatusRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &regstatus_cache);
}

int	UnFull::AddLekFormRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &lekform_cache);
}

int	UnFull::AddPhFirmRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &phfirm_cache);
}

int	UnFull::AddPhCountryRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &phcountry_cache);
}

int	UnFull::AddRegDateRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_regannuldate_ref (pInd, *(date*)vpKey, aRef, &regdate_cache);
}

int	UnFull::AddAnnulDateRef (Index* pInd, const void* vpKey, Ref aRef)
{
	return add_regannuldate_ref (pInd, *(date*)vpKey, aRef, &annuldate_cache);
}

int UnFull::del_class_type_dockind_ref (Index* index, char* key, Ref ref, std::map<std::string, std::deque<Ref> >* cache_map, bool add_ref)
{
	ref.DocId = -ref.DocId;
	if (add_ref) ref.Sub = -ref.Sub;
	std::map<std::string, std::deque<Ref> >::iterator it = cache_map->find (key);
	if (it == cache_map->end ()) {
		std::deque<Ref> to_insert;
		to_insert.push_back (ref);
		cache_map->insert (std::map<std::string, std::deque <Ref> >::value_type (key, to_insert));
	} else {
		it->second.push_back (ref);
	}
	return 1;
}

int UnFull::del_regannuldate_ref (Index* index, date key, Ref ref, std::map<long, std::deque<Ref> >* cache_map, bool add_ref)
{
	ref.DocId = -ref.DocId;
	if (add_ref) ref.Sub = -ref.Sub;
	std::map<long, std::deque<Ref> >::iterator it = cache_map->find (*(long*)&key);
	if (it == cache_map->end ()) {
		std::deque<Ref> to_insert;
		to_insert.push_back (ref);
		cache_map->insert (std::map<long, std::deque <Ref> >::value_type (*(long*)&key, to_insert));
	} else {
		it->second.push_back (ref);
	}
	return 1;
}

int UnFull::del_date_doc (Index* index, date key, long doc_id, std::map<long, std::deque<long> >* cache_map)
{
	std::map<long, std::deque<long> >::iterator it = cache_map->find (*(long*)&key);
	if (it == cache_map->end ()) {
		std::deque<long> to_insert;
		to_insert.push_back (-doc_id);
		cache_map->insert (std::map<long, std::deque<long> >::value_type (*(long*)&key, to_insert));
	} else {
		it->second.push_back (-doc_id);
	}
	return 1;
}

int UnFull::DelClassRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &class_cache, aAddRef);
}

int UnFull::DelTypeRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &type_cache, aAddRef);
}

int UnFull::DelKWRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &kw_cache, aAddRef);
}

int UnFull::DelActiveRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_regannuldate_ref (pInd, *(date*)vpKey, aRef, &active_cache, aAddRef);
}

int UnFull::DelKindRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &kind_cache, aAddRef);
}

int UnFull::DelClass6Ref (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &class6_cache, aAddRef);
}

int UnFull::DelServiceInfoRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &serviceinfo_cache, aAddRef);
}

int UnFull::DelDocKindRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &dockind_cache, aAddRef);
}

int UnFull::DelMkbRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &mkb_cache, aAddRef);
}

int UnFull::DelChapterRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &chapter_cache, aAddRef);
}

int UnFull::DelRegStatusRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &regstatus_cache, aAddRef);
}

int UnFull::DelLekFormRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &lekform_cache, aAddRef);
}

int UnFull::DelPhFirmRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &phfirm_cache, aAddRef);
}

int UnFull::DelPhCountryRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_class_type_dockind_ref (pInd, (char*)vpKey, aRef, &phcountry_cache, aAddRef);
}

int UnFull::DelRegDateRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_regannuldate_ref (pInd, *(date*)vpKey, aRef, &regdate_cache, aAddRef);
}

int UnFull::DelAnnulDateRef (Index* pInd, const void* vpKey, Ref aRef, int keepKey, bool aAddRef)
{
	return del_regannuldate_ref (pInd, *(date*)vpKey, aRef, &annuldate_cache, aAddRef);
}

int UnFull::AddStreamRef ( Index* pInd, const void* vpKey, RefwWeight aRef, short tag)
{
	if (tag == IDD_TAG)
		return AddTagRef (pInd, vpKey, aRef);
	return 0;
}

int UnFull::AddStreamRef ( Index* pInd, const void* vpKey, Ref aRef, short tag)
{
	int iCreated;

	switch (tag) {
		case IDD_ACTIVEEX:
			return AddActiveRef (pInd, vpKey, aRef);
			break;
		case IDD_KEY:
			return AddKWRef (pInd, vpKey, aRef);
			break;
		case IDD_DIV:
			return AddClassRef (pInd, vpKey, aRef);
			break;
		case IDD_TYPE:
			return AddTypeRef (pInd, vpKey, aRef);
			break;
		case IDD_KIND:
			return AddKindRef (pInd, vpKey, aRef);
			break;
		case IDD_CLASS6:
			return AddClass6Ref (pInd, vpKey, aRef);
			break;
		case IDD_DOCKIND:
			if (AddDocKindRef (pInd, vpKey, aRef)) {
				SString key ((const char*) vpKey);
				if (m_mapSavedDocKind.contains (key)) {
					Stream *pStr = pInd->OpenN (vpKey,1,1);
					pStr->Write (m_mapSavedDocKind [key], m_mapSavedDocKind [key].Length ());
					pInd->Close (pStr);
				}
				return 1;
			}
			return 0;
			break;
		case IDD_MKB:
			return AddMkbRef (pInd, vpKey, aRef);
			break;
		case IDD_CHAPTER:
			return AddChapterRef (pInd, vpKey, aRef);
			break;
		case IDD_REGSTATUS:
			return AddRegStatusRef (pInd, vpKey, aRef);
			break;
		case IDD_LEKFORM:
			return AddLekFormRef (pInd, vpKey, aRef);
			break;
		case IDD_INPHARMFIRM:
			return AddPhFirmRef (pInd, vpKey, aRef);
			break;
		case IDD_INPHARMCOUNTRY:
			return AddPhCountryRef (pInd, vpKey, aRef);
			break;
		case IDD_REGDATE:
			return AddRegDateRef (pInd, vpKey, aRef);
			break;
		case IDD_ANNULDATE:
			return AddAnnulDateRef (pInd, vpKey, aRef);
			break;
		case IDD_SERVICEINFO:
			return AddServiceInfoRef (pInd, vpKey, aRef);
			break;

		default:
			logger.printf (lt_updateInfo, "add ref in index %s\n", pInd->Name);
			Stream *pStr = pInd->Open (vpKey, 1, &iCreated);
			if (!pStr) {
				logger.printf (lt_error, "AddStreamRef:Can't create Stream in %s (%ld)\n", pInd->Name, aRef.DocId);
				return -1;
			}

			RefCollection aRefs;
			aRefs.Get (pStr);
			aRefs.Add (aRef);
			pStr -> Seek (0);
			aRefs.Put (pStr);
			pInd->Close (pStr);

			if (iCreated && (pInd == SelectIndex (IDD_DOCKIND))) {
				SString key ((const char*) vpKey);
				if (m_mapSavedDocKind.contains (key)) {
					pStr = pInd->OpenN (vpKey,1,1);
					pStr->Write (m_mapSavedDocKind [key], m_mapSavedDocKind [key].Length ());
					pInd->Close (pStr);
				}
			}
	}

	return iCreated;
}

int UnFull::DelStreamRef ( Index* pInd, const void* vpKey, RefwWeight aRef, short tag)
{
	if (tag == IDD_TAG) {
		return DelTagRef (pInd, vpKey, aRef);
	}
	return 1;
}

int UnFull::DelStreamRef ( Index* pInd, const void* vpKey, Ref aRef, short tag, int keepKey, bool aAddRef )
{
	switch (tag) {
		case IDD_ACTIVEEX:
			return DelActiveRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_KEY:
			return DelKWRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_DIV:
			return DelClassRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_TYPE:
			return DelTypeRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_KIND:
			return DelKindRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_SERVICEINFO:
			return DelServiceInfoRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_CLASS6:
			return DelClass6Ref (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_DOCKIND:
			{
			DelDocKindRef (pInd, vpKey, aRef, keepKey, aAddRef);
			/*
			Stream *pStr = pInd->OpenN (vpKey, 1);
			if(pStr){
				SString key ((const char*) vpKey);
				SMem data (pStr->Length ());
				pStr->Read (data, pStr->Length ());
				m_mapSavedDocKind [key] = data;
				pInd->Close (pStr);
			}else{
				logger.printf (lt_error, "DelStreamRef: Can't create Stream in %s (%ld)\n", pInd->Name, aRef.DocId);
			}
			*/
			return 1;
			}
			break;
		case IDD_MKB:
			return DelMkbRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_CHAPTER:
			return DelChapterRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_REGSTATUS:
			return DelRegStatusRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_LEKFORM:
			return DelLekFormRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_INPHARMFIRM:
			return DelPhFirmRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_INPHARMCOUNTRY:
			return DelPhCountryRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_REGDATE:
			return DelRegDateRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		case IDD_ANNULDATE:
			return DelAnnulDateRef (pInd, vpKey, aRef, keepKey, aAddRef);
			break;
		default:
			logger.printf (lt_updateInfo, "del ref from index %s\n", pInd->Name);

			Stream *pStr = pInd->Open (vpKey);
			if (!pStr) {
				logger.printf (lt_error, "DelStreamRef: Can't create Stream in %s (%ld)\n", pInd->Name, aRef.DocId);
				return 0;
			}

			RefCollection aRefs;
			aRefs.Get (pStr);
			aRefs.Del (aRef);
		#ifdef	BLOCKSINHERIT
			if ((aRef.Sub & INHERITED_BLOCK ) && aAddRef) {
				Ref aaRef = { aRef.DocId, aRef.Sub & MINUS_INHERITED_BLOCK };
				aRefs.Add (aaRef);
			}
			if (aAddRef && !(aRef.Sub & INHERITED_BLOCK)) {
				Ref aaRef = { aRef.DocId, aRef.Sub | INHERITED_BLOCK };
				aRefs.Add (aaRef);
			}
		#endif

			if (!aRefs.ItemCount) {
				if (keepKey) {
					logger.printf (lt_debug, "DelStreamRef: Keep empty key in Index %s (DocId %ld)\n", pInd->Name, aRef.DocId);
				} else {			
					pInd->Close (pStr);
					if (pInd == SelectIndex (IDD_DOCKIND)) {
						pStr = pInd->OpenN (vpKey, 1);

						SString key ((const char*) vpKey);
						SMem data (pStr->Length ());
						pStr->Read (data, pStr->Length ());
						m_mapSavedDocKind [key] = data;
						pInd->Close (pStr);
					}

					if (pInd->Delete (vpKey) != GKDB::BT_OK)
						logger.printf (lt_error, "DelStreamRef: Can't delete key from Index %s (DocId %ld)\n", pInd->Name, aRef.DocId);
					else
						logger.printf (lt_debug, cd_dos, "DelStreamRef: Delete empty key \"%s\" from Index %s\n", (char*)vpKey, pInd->Name);

					return -1;
				}
			}
			pStr->Seek (0);
			aRefs.Put (pStr);
			pStr->Trunc ();
			pInd->Close (pStr);
	}

	return 1;
}

int UnFull :: RestoreRefInd (long lDocId)
{
	RefCollection aRefs;

	Index *pInd = m_pNewBase->FindIndex ("Respondent");
	Stream *pStr = pInd->Open (&lDocId, 1);
	if (pStr)
		aRefs.Get (pStr);
	else
		logger.printf ( lt_error, "Can't create stream in index Respondent by key %ld\n", lDocId);

	long lDelRefCount = 0, lAddRefCount = 0;
	DeltaRead ( &lDelRefCount, sizeof ( long ), 1, m_DFile1 );

	Ref aRef;
	for ( ; lDelRefCount; lDelRefCount-- ) {
		DeltaRead ( &aRef, sizeof ( struct  Ref ), 1, m_DFile1 );
		aRefs.Del ( aRef );
	}

	DeltaRead ( &lAddRefCount, sizeof ( long ), 1, m_DFile1 );
	for ( ; lAddRefCount; lAddRefCount-- ) {
		DeltaRead ( &aRef, sizeof ( struct Ref ), 1, m_DFile1 );
		aRefs.Add ( aRef );
	}

	if (!aRefs.ItemCount) {
		if (pStr)
			pInd->Close (pStr);
		if (pInd->Delete (&lDocId) != GKDB::BT_OK)
			logger.printf ( lt_error, "Can't delete key %ld from %s\n", lDocId, pInd->Name );

		return -1;
	} else {
		if (pStr) {
			pStr->Seek (0);
			aRefs.Put (pStr);
			pStr->Trunc ();
			pInd -> Close (pStr);

			StorableSplaySet<Ref> *nc = new StorableSplaySet<Ref>;
			for (int i = 0; i < aRefs.ItemCount; i++)
				nc->add (aRefs [i]);
			(*respCache)[lDocId] = (caddr_t) nc;
		}
	}

	return 1;
}

char* RestoreParaHeader ( char* pPara, ParaHeader aHeader, char cRestoreMask )
{
	if ( cRestoreMask & O_HDR_STYLE )  pPara [0] = aHeader.cStyle;
	if ( cRestoreMask & O_HDR_TSTART ) * (short *) (pPara + 3) = aHeader.sTStart;
	if ( cRestoreMask & O_HDR_LMARGIN ) pPara[5] = aHeader.cLMargin;
	if ( cRestoreMask & O_HDR_RMARGIN ) pPara[6] = aHeader.cRMargin;
	if ( cRestoreMask & O_HDR_REDLINE ) pPara[7] = aHeader.cRedLine;

	return & pPara[3];
}

int UnFull :: FullDelDoc ()
{
	for (int tag = 0; tag < sizeof (tags) / sizeof (short); tag++)
		DelIndByAttr (tags [tag], m_lDocId);

	m_pOldBase->FindIndex ("Respondent")-> Delete (&m_lDocId);

#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
  #ifndef INCLUDE_OLD_CONTXT
	long Size = 0;
	if ( m_pOldInfo ) free ( m_pOldInfo );
	m_pOldInfo = (DocInfo*) docInd->Load ( m_lDocId, IDD_INFO, Size );
	if(!IsSkipDocName( m_lDocId, 0 )){
		if(!pTmpDoc){
			pTmpDoc = new Document(m_pNewBase, m_lDocId, m_pOldInfo);
		}else{
			pTmpDoc->Stat= *m_pOldInfo;
			pTmpDoc->FreeStructs ();
			pTmpDoc->Reset();
			pTmpDoc->DocId = m_lDocId;
		}
		RESTORE_TEXT_DATA(m_lDocId);
		m_pOldBase ->DelText( m_lDocId, pTmpDoc->runs, pTmpDoc->RunCount, pTmpDoc->blocks, pTmpDoc->BlockCount );
		docInd -> Del ( m_lDocId, IDD_RUNS );
		docInd -> Del ( m_lDocId, IDD_BLOCKS );
		docInd -> Close( pTmpDoc->runsStr );
		docInd -> Close( pTmpDoc->blocksStr );
		if(pTmpDoc->runs)
			free ( pTmpDoc->runs );
		pTmpDoc->runs= 0;
		if(pTmpDoc->blocks)
			free ( pTmpDoc->blocks);
		pTmpDoc->blocks= 0;
	}
  #endif
#endif

	m_pOldBase -> DelDoc (m_lDocId, false, false);

	return 1;
}

int UnFull :: DelIndByAttr ( int iTag, long lDocId )
{
	long iOldSize = 0;
	void * vOldBuff;

	vOldBuff = docInd->Load ( lDocId, iTag, iOldSize );

	if ( iOldSize == -1 || !iOldSize ) {
		if (iTag == IDD_SUBS) {
			Ref ref = {lDocId, 0};
			del_subname (ref);
		}

		return 0;
	}

	switch ( iTag ) {
	case IDD_DIV :
	case IDD_KEY :
	case IDD_ID :
	case IDD_ADDCODE :
	case IDD_SOURCE :
	case IDD_TYPE :
	case IDD_TAG :
	case IDD_KIND :
	case IDD_RCODE :
	case IDD_CATEGORY :
	case IDD_PUBLISHEDIN :
	case IDD_TERRITORY :
	case IDD_DOCKIND :
	case IDD_SOURCEFILE :
	case IDD_ANNOUSER :
	case IDD_ANNOORGANIZATION :
	case IDD_ANNOTAX :
	case IDD_ANNOINTEREST :
	case IDD_ANNOKIND :
	case IDD_SERVICEINFO :
	case IDD_CLASS6 :
	case IDD_INPHARMFIRM:
	case IDD_INPHARMCOUNTRY:
	case IDD_ATC:
	case IDD_REGSTATUS:
	case IDD_LEKFORM:
	case IDD_PHARMGROUP:
	case IDD_PHARMEFFECT:
	case IDD_CHAPTER:
	case IDD_MKB:
	case IDD_INTNAME:
	case IDD_TRADENAME:
	{
		if (iOldSize && iTag == IDD_CLASS6 && !b_ovp) {
			char *ptr = (char*) vOldBuff;
			long i = 0, new_len = 0;
			std::vector<std::string> strings;	
			while (i < iOldSize) {
				int len = strlen (ptr)+1;
				char *semipos = strchr (ptr, ':');
				*semipos++ = '\0';
				std::string new_iddclass6 (ptr);
				new_iddclass6 += ':';
				new_iddclass6 += old_map_id_str.find (atol (semipos))->second;
				strings.push_back (new_iddclass6);
				new_len += new_iddclass6.size () + 1;
				ptr += len;
				i += len;
			}
			char* new_buff = (char*) malloc (new_len);
			ptr = new_buff;
			for (std::vector<std::string>::const_iterator it = strings.begin (); it != strings.end (); it++) {
				strcpy (ptr, it->c_str ());
				ptr += strlen (ptr)+1;
			}
			gk_free (vOldBuff);
			vOldBuff = new_buff;
			iOldSize = new_len;
		}
		int withSub = iTag==IDD_KEY || iTag==IDD_DIV || iTag == IDD_DOCKIND || iTag == IDD_TYPE || iTag == IDD_KIND || iTag == IDD_SERVICEINFO || iTag == IDD_CLASS6 || iTag == IDD_INPHARMCOUNTRY || iTag == IDD_INPHARMFIRM || iTag == IDD_CHAPTER || iTag == IDD_REGSTATUS || iTag == IDD_LEKFORM || iTag == IDD_MKB || iTag == IDD_TAG;
		int hKey = iTag == IDD_TAG ? false : (withSub || iTag == IDD_ANNOUSER || iTag == IDD_ANNOORGANIZATION || iTag == IDD_ANNOTAX || iTag == IDD_ANNOINTEREST || iTag == IDD_ANNOKIND || iTag == IDD_SOURCE || iTag == IDD_PUBLISHEDIN || iTag == IDD_TERRITORY || iTag == IDD_CLASS6 || iTag == IDD_INPHARMCOUNTRY || iTag == IDD_INPHARMFIRM || iTag == IDD_PHARMGROUP || iTag == IDD_PHARMEFFECT || iTag == IDD_CHAPTER || iTag == IDD_ATC || iTag == IDD_REGSTATUS || iTag == IDD_LEKFORM || iTag == IDD_MKB);
		
		StringZ aKeys((char*)vOldBuff,iOldSize,withSub);
		aKeys.EnableHide ();
		while ( !aKeys.End () ) {
			if (hKey)
				DelStrIndex ( iTag, aKeys (), lDocId, aKeys.FindUnEquelLevel(aKeys.GetPos()) );
			else
				DelStrIndex ( iTag, aKeys (), lDocId, -1 );
			aKeys.Hide ();
			++ aKeys;
		}
	}
		break;

	case IDD_INFO :
	{
		Index *statusex_index = m_pNewBase->FindIndex ("Status_ex"), *status_index = m_pNewBase->FindIndex ("Status");
		short oldDSDoc = ((DocInfo*) vOldBuff)->Status & ( DS_DOC | DS_EDITION | DS_ANNO | DS_NODOC );
		short oldDSActive = ((DocInfo*) vOldBuff)->Status & ( DS_ACTIVE | DS_ABOLISHED | DS_PREACTIVE );
		short oldDSReg = ((DocInfo*) vOldBuff)->Status & ( DS_MOJREG | DS_MOJNOTREG | DS_MOJOTHER );
		short oldDSWarning = ((DocInfo*) vOldBuff)->Status & (DS_WARNING);

		if (oldDSDoc & (DS_DOC|DS_EDITION|DS_ANNO|DS_NODOC)) {
			short key = oldDSDoc & DS_DOC; if (key) DelStatusDoc (status_index, &key, lDocId);
			key = oldDSDoc & DS_NODOC; if (key) DelStatusDoc (status_index, &key, lDocId);
			key = oldDSDoc & DS_EDITION; if (key) DelStatusDoc (status_index, &key, lDocId);
			key = oldDSDoc & DS_ANNO; if (key) DelStatusDoc (status_index, &key, lDocId);
		}

		if (oldDSDoc & (DS_DOC | DS_EDITION)) {
			m_dsm = dsmChgToNodoc;
			if ( oldDSActive ) DelStatusDoc (status_index, &oldDSActive, lDocId);
			if ( oldDSReg ) DelStatusDoc (status_index, &oldDSReg, lDocId);
			if (oldDSWarning) DelStatusDoc (status_index, &oldDSWarning, lDocId);
		} else m_dsm = dsmStayNodoc;

		Ref ref = {lDocId, 0};
		if (((DocInfo*) vOldBuff)->Status_ex & DS_LIFE) {
			short status_ex = DS_LIFE;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_NOTLIFE) {
			short status_ex = DS_NOTLIFE;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_RECIPE) {
			short status_ex = DS_RECIPE;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_UNRECIPE) {
			short status_ex = DS_UNRECIPE;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_ALLOWED) {
			short status_ex = DS_ALLOWED;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_NOTALLOWED) {
			short status_ex = DS_NOTALLOWED;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_MEDTOPIC) {
			short status_ex = DS_MEDTOPIC;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_FIRMTOPIC) {
			short status_ex = DS_FIRMTOPIC;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_MDICTTOPIC) {
			short status_ex = DS_MDICTTOPIC;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_NARCOTIC) {
			short status_ex = DS_NARCOTIC;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_NOTNARCOTIC) {
			short status_ex = DS_NOTNARCOTIC;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_IZM) {
			short status_ex = DS_IZM;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_DATE) {
			short status_ex = DS_DATE;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
		if (((DocInfo*) vOldBuff)->Status_ex & DS_FLASH) {
			short status_ex = DS_FLASH;
			DelStatusExRef (statusex_index, &status_ex, ref, iTag);
		}
	}
		break;

	case IDD_LIFE:
	case IDD_NOTLIFE:
	case IDD_ALLOWED:
	case IDD_NOTALLOWED:
	case IDD_RECIPE:
	case IDD_UNRECIPE:
		{
		long *subs = (long*) vOldBuff;
		for (long i = 0; i < iOldSize / sizeof (long); i++, subs++) {
			Ref ref = {lDocId, *subs};
			short status_ex = iTag == IDD_LIFE ? DS_LIFE : (iTag == IDD_NOTLIFE ? DS_NOTLIFE : (iTag == IDD_ALLOWED ? DS_ALLOWED: (iTag == IDD_NOTALLOWED ? DS_NOTALLOWED : (iTag == IDD_RECIPE ? DS_RECIPE : DS_UNRECIPE))));
			DelStatusExRef (m_pNewBase->FindIndex ("Status_ex"), &status_ex, ref);
		}
		}
		break;
	
	case IDD_ACTIVEEX:
		{
		u_int64_t *ptr = (u_int64_t*) vOldBuff;
		for (unsigned int i = 0; i < iOldSize / sizeof (u_int64_t); i++, ptr++) {
			u_int64_t at = *ptr;
			Ref to_delete = {lDocId, (u_int32_t)(at >> 32)};
			u_int32_t a_date = (u_int32_t)(at & 0xFFFFFFFF);
			DelStreamRef (SelectIndex (iTag), &a_date, to_delete, iTag);
		}
		}
		break;

	case IDD_REGDATE:
	case IDD_ANNULDATE:
		{
		u_int64_t *ptr = (u_int64_t*) vOldBuff;
		for (unsigned int i = 0; i < iOldSize / sizeof (u_int64_t); i++, ptr++) {
			u_int64_t at = *ptr;
			Ref to_delete = {lDocId, (long)(at & 0xFFFFFFFF)};
			u_int32_t a_date = (u_int32_t)(at >> 32);
			DelStreamRef (SelectIndex (iTag), &a_date, to_delete, iTag);
		}
		}
		break;

	case IDD_SUBS :
	{
		SubDesc* subs = (SubDesc*) vOldBuff;
		int SubCount = iOldSize / sizeof ( SubDesc );

		Ref ref = {lDocId, 0};
		del_subname (ref);
		for ( int i = 0; i < SubCount; i++ ) {
			ref.Sub = subs [i].Sub;
			del_subname (ref);
		}
	}
		break;

	case IDD_CALIN:
	case IDD_CALAB:
	case IDD_CALCH:
	case IDD_DATE :
	case IDD_RDATE :
	case IDD_VINCLUDED :
	case IDD_VCHANGED :
	case IDD_VABOLISHED :
	case IDD_VLCONTROL :
	case IDD_VANONCED :
	case IDD_SORTDATE :
	case IDD_ANNODATE :
		{
		for ( unsigned int i = 0; i < iOldSize / sizeof ( date ); i++ )
			DelStreamDoc ( SelectIndex (iTag), (date*)vOldBuff + i, lDocId, iTag);
	}
		break;

	case IDD_BASES :
	{
		if ( m_dsm == dsmChgToNodoc )
			for ( unsigned int i = 0; i < iOldSize / sizeof (short); i++ )
				DelSegmentDoc ( SelectIndex (IDD_BASES), (short*)vOldBuff + i, lDocId );
	}
		break;

	default :
		logger.printf ( lt_fatal, "Unknown Tag %d\n", iTag );
		_EXIT ( EXIT_FAILURE );
	}

	if ( vOldBuff ) free( vOldBuff );
	return 1;
}

void UnFull :: CollectBaseInfo ( DocInfo* olddi, DocInfo* newdi, SplaySet<short> segs )
{	
	segs &= m_presentSegments;
	
	for ( Point p = segs.first(); p; segs.next(p) ) 
		UpdateBaseInfo ( m_mapBaseInfo[segs.contents(p)], olddi, newdi );
}

void UpdateBaseInfo ( BaseInfo& info, DocInfo* olddi, DocInfo* newdi )
{
	if ( olddi ) {		
		info.RecCount--;
		info.RecSize       -= olddi->Size;
		info.GreenComments -= olddi->GreenComments;
		info.HyperRefs     -= olddi->HyperRefs;
		if ((olddi->Status & DS_DOC) || (olddi->Status_ex & DS_MEDTOPIC)) {
			info.CommonDocCount--;
			info.CommonDocSize -= olddi->Size;
		}
	}
	
	if ( newdi ) {		
		info.RecCount++;
		info.RecSize       += newdi->Size;
		info.GreenComments += newdi->GreenComments;
		info.HyperRefs     += newdi->HyperRefs;
		if ((newdi->Status & DS_DOC) || (newdi->Status_ex & DS_MEDTOPIC)) {
			info.CommonDocCount++;
			info.CommonDocSize += newdi->Size;
		}
	}	
}

#undef SKIP_TO_DOCID

size_t DeltaRead (void *buffer, size_t size, size_t count, FILE *stream)
{
	if (delta_buffer_ptr) {
		size_t result = count * size;
		memcpy (buffer, delta_buffer_ptr, result);
		delta_buffer_ptr += result;
		return result;
	} else {
		return fread (buffer, size, count, stream);
	}
}

///////////////////////////////////////////////////////////////////////////////
//			End of file "unfull.cpp"			     //
///////////////////////////////////////////////////////////////////////////////

