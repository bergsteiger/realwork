#include "shared/Core/fix/mpcxc.h"
//BLOCKSINHERIT,STORE_FORM_N,ONLY_NORM_INDEX,QUICK_NEW_DOC
/*
 * cvs id was here
 */

#define _EXIT(a) assert(0)

//#define SKIP_TO_DOCID 0

#define PROGRESS_START_PARA_COUNT 50000
#define DETECTEQU_THROUGH 1

#include "gdlt_ver.h"

#include <cstdlib>
#include <cstdio>
#include <cstring>

#include "fulldiff.h"
#include "SearchB.h"
#include "dociter.h"
#include "refcol.h"
#include "elems.h"
#include "hendlers.h"
#include "wordcol.h"
#include "stringz.h"
#include "deltadef.h"
#include "dltcomon.h"
#include "adds.h"
#include "basemask.h"
#include "toys.h"
#include "StorableSplaySet.h"
#include "SharedData.h"
#include "Logger.h"
#include "hnode.h"
#include "pack.h"

extern	short DELTA_DATA_VERSION;
extern Logger logger;
static logtype_t lt_deltaInfo ( 399, "DELTA INFO" );

extern bool b_buildNewCorrDiff;
extern bool b_buildNewCorrDiff_hack;
extern long g_lDiffTimeLimit;
extern long checkOnlyDoc;
extern bool b_daily, b_sbrf, b_ovp;

extern void DiffProcCreate ( long lDocInDelta );
extern void AddDiff ( long lDeltaCount );
extern void ParaProcCreate ( long lParaCount );
extern void ParaProcDestroy ();
extern void AddPara ( long lCount );

char pNBUF [16][ BUF_SIZE ];
char pOBUF [16][ BUF_SIZE ];

extern	char	argDltPath [1024];

extern	char	m_AttrFile_name [MAX_PATH];
extern	char	pfTmp1_name [MAX_PATH];
extern	char	pfTmp2_name [MAX_PATH];

extern	bool	b_texts_only;
extern	bool	b_gctx_attrs_only;
extern	bool	b_pack_delta;
extern	bool	b_cache_ro;
extern	bool	b_single_cache;
extern	bool	b_extended_log;
extern	bool	b_flush_log;
extern	bool	b_ovp;
extern	bool	b_texts_only;
extern	bool	b_prepack;


Core::Mutex	cache_mutex;

/*
 * DiffHolder(filesName, bRDWR)
 *
 * filesName - the base for files key, str
 *             for instance, if you give "myDelts",
 *             files "myDelts.k" and "myDelts.s" will be created
 * bRDWR - open read/write or read-only
 *             1 - use for create and write to the idx1 and idx2
 *             0 - for read only.
 */

DiffHolder	*m_pDiffHolder [16];

///////////////////////////////////////////////////////////////////////////////
//									     //
// Функция для сравнения двух индексов					     //
//									     //
///////////////////////////////////////////////////////////////////////////////

int	checkIndex(Index* ind1, Index* ind2)
{
	//
	// Проверяем на правильность индексов
	//
	if ( !ind1 || !ind2 || !ind2->KeyCount )
		return 1;
	
	//
	// Буфер
	//
	char		buf[10000];
	//
	// Колекция для в которую ложим индекс
	//
	HNode		*root = new HNode;
	//
	// Итератор по первому индексу
	//
	BTIterator	it( ind1 );
	
	//
	// Бежим по первому индексу и добавляем каждый ключ в root
	//
	for ( ; !it.End ( ); )
	{
		HNode		*new_node = 0;

		char		*full_key = ((HIndex*)ind1)->FullName(it.Key( ), buf);
		HN_STATUS	st        = root->addNode(full_key, new_node);
		++it;
	}
	
	//
	// Итератор по второму индексу
	//
	BTIterator cit ( ind2 );
		
	//
	// Бежим по второму индексу и добавляем каждый ключ в root
	//   если не вставился, значит он уже есть тогда выходим с ошибкой
	//
	for ( ; !cit.End ( ); ) {
		HNode		*new_node = 0;

		char		*full_key = ((HIndex*)ind2)->FullName(it.Key ( ),buf);
		HN_STATUS	st        = root->addNode(full_key, new_node);

		if( (st & INS_CONT) || (st & INS_BRK) ) {
			fprintf(stdout, "Index '%s' is not the same in all bases\n", ind2->Name);
			delete root;
			return 0;
		}
		++cit;
	}
	delete root;
	return 1;
}

Full::Full( SearchBase* oldB, SearchBase* newB, StorableSplaySet<unsigned short>& ids, SplaySet<long> * deldocs, FILE* dF1, int aRemoveCache, bool createiterators, FILE* attrFile, FILE* tmp1, FILE* tmp2, short aseg, int thread )
{
	m_thread = thread;

	g_lDocInDelta = 0;
	g_lChgDocSize = 0;
	g_lNewDocSize = 0;
	g_lChgBlbCount = 0;
	g_lNewBlbCount = 0;
	g_lEquBlbCount = 0;
	g_lDelBlbCount = 0;
	g_lChgBlbSize = 0;
	g_lNewBlbSize = 0;

	m_pOldBase = oldB;
	m_pNewBase = newB;
 	m_ids      = ids;
 	m_DFile1   = dF1;
	seg        = aseg;
	removeCache = aRemoveCache;

	if ( attrFile ) {
		bclosefiles = false;
		m_AttrFile = attrFile;
		pfTmp1 = tmp1;
		pfTmp2 = tmp2;
	} else {
		/*
		bclosefiles = true;
		char tmp_filename [L_tmpnam_s];
		errno_t err;
		err = tmpnam_s (tmp_filename, L_tmpnam_s);

		err = tmpfile_s (&m_AttrFile);
		if (err) {
			strcat (strcpy (m_AttrFile_name, argDltPath), "m_attr.tmp");
			m_AttrFile = mpcxc_fopen (m_AttrFile_name, "w+b" );
			if (!m_AttrFile) {
				logger.printf ( lt_fatal, "tmpfile() : Can't create temporary file, %s\n", strerror ( errno ) );
				exit(0);
			}
		} else {
			m_AttrFile_name [0] = 0;
		}

		err = tmpfile_s (&pfTmp1);
		if (err) {
			strcat (strcpy (pfTmp1_name, argDltPath), "tmp1.tmp");
			pfTmp1 = mpcxc_fopen (pfTmp1_name, "w+b" );
			if (!pfTmp1) {
				logger.printf ( lt_fatal, "tmpfile() : Can't create temporary file, %s\n", strerror ( errno ) );
				//_EXIT ( EXIT_FAILURE );
				exit(0);
			}
		} else {
			pfTmp1_name [0] = 0;
		}

		err = tmpfile_s (&pfTmp2);
		if (err) {
			strcat (strcpy (pfTmp2_name, argDltPath), "tmp2.tmp");
			pfTmp2 = mpcxc_fopen (pfTmp2_name, "w+b");
			if (!pfTmp2) {
				logger.printf ( lt_fatal, "tmpfile() : Can't create temporary file, %s\n", strerror ( errno ) );
				//_EXIT ( EXIT_FAILURE );
				exit(0);
			}
		} else {
			pfTmp2_name [0] = 0;
		}
		*/
	}

	//m_pDiffHolder = 0;
	
	if ( !m_pOldBase ) {
		logger.printf ( lt_fatal, "FullDiff: Old Base was not specified\n" );
		_EXIT (EXIT_FAILURE);
	}
	if ( !m_pNewBase ) {
		logger.printf ( lt_fatal, "FullDiff: New Base was not specified\n" );
		_EXIT(EXIT_FAILURE);
	}

	if ( createiterators ) {
		for_all_segs = false;
		CreateOldIterator();
		m_pNewDocIter = new DocIterator ( m_pNewBase );
		assert ( m_pNewDocIter );
	} else {
		for_all_segs = true;
		m_pOldDocIter = 0;
		m_pNewDocIter = 0;
	}

	m_deldocs = 0;
	m_delblobs = 0;
	if ( deldocs ) {
		m_deldocs = new SplaySet<long>;
		m_delblobs = new SplaySet<ObjKey>;
		
		for ( Point p = deldocs->first (); p; deldocs->next(p) ) {
			long id = deldocs->contents(p);
			if ( FindDoc(id, VER_OLD) )
				m_deldocs->add (id);
			else {
				ObjKey key;
				bzero ( (void *)&key, sizeof (key) );
				key.id = deldocs->contents(p);
				if ( FindBlob (m_pOldBase, &key) )
					m_delblobs->add (key);
			}
		}
	}

	if (!b_sbrf) {
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
				if (*semipos) {
					old_map_id_str.insert (std::map<long,std::string>::value_type (atol (ptr), semipos));
					old_map_str_id.insert (std::map<std::string, long>::value_type (semipos, atol (ptr)));
				}
				i += len;
				ptr += len;
			}
			gk_free (data);
		}
		str = m_pNewBase->FindIndex ("Aux")->Open (AUX_CLASS6_KEYS);
		if (str) {
			long length = str->Length (), i = 0;
			char *data = (char*) malloc (length), *ptr = data;
			str->Read (data, length);
			m_pNewBase->FindIndex ("Aux")->Close (str);
			while (i < length) {
				long len = strlen (ptr)+1;
				char *semipos = strchr (ptr, ':');
				*semipos++ = '\0';
				if (*semipos) {
					new_map_id_str.insert (std::map<long,std::string>::value_type (atol (ptr), semipos));
					new_map_str_id.insert (std::map<std::string, long>::value_type (semipos, atol (ptr)));
				} else
					new_map_id_str.insert (std::map<long,std::string>::value_type (atol (ptr), ""));
				i += len;
				ptr += len;
			}
			gk_free (data);
		}
	}

	Stream *str = m_pNewBase->FindIndex ("Aux")->Open (AUX_SPLASH);
	if (str) {
		DocCollection docs;
		docs.Get (str);
		m_pNewBase->FindIndex ("Aux")->Close (str);
		for (int i = 0; i < docs.ItemCount; i++)
			splash_topics.insert (docs [i]);
	}

	str = m_pNewBase->FindIndex ("Aux")->Open (AUX_BANNERS);
	if (str) {
		DocCollection docs;
		docs.Get (str);
		m_pNewBase->FindIndex ("Aux")->Close (str);
		for (int i = 0; i < docs.ItemCount; i++)
			banner_topics.insert (docs [i]);
	}
}

void	Full::CreateOldIterator()
{
	m_pOldDocIter = new DocIterator ( m_pOldBase );
	assert ( m_pOldDocIter );
}

void	Full::RemoveCache()
{
	char buf[1024];
	sprintf (buf,"%s.k", HolderName);
	ace_os_unlink (buf);
	sprintf (buf,"%s.s", HolderName);
	ace_os_unlink (buf);
}

Full::~Full() {
	if ( m_pNewDocIter ) delete m_pNewDocIter;
	if ( m_pOldDocIter ) delete m_pOldDocIter;
	if ( m_deldocs ) delete m_deldocs;
	if ( m_delblobs ) delete m_delblobs;

	if ( bclosefiles ) {
		fclose( m_AttrFile );
		fclose( pfTmp1 );
		fclose( pfTmp2 );
	}
	/*
	if (m_AttrFile_name) unlink (m_AttrFile_name);
	if (pfTmp1_name) unlink (pfTmp1_name);
	if (pfTmp2_name) unlink (pfTmp2_name);
	*/
	if (removeCache) RemoveCache ();
}

///////////////////////////////////////////////////////////////////////////////
//
// Функция для поиска следующего документа				     
//
///////////////////////////////////////////////////////////////////////////////

long	Full :: GetNextDocId ( int iVersion )
{
    long		lDocId    = NEW_ID;
    DocIterator	*pDocIter = 0;

    switch ( iVersion ) {
	case VER_NEW :
		pDocIter = m_pNewDocIter;
		break;

	case VER_OLD :
		pDocIter = m_pOldDocIter;
		break;
    }

    if ( pDocIter ) {
		while ( !pDocIter->End () ) {
			if ( iVersion == VER_NEW )
				AddDiff (1);

			lDocId = pDocIter->Id ();
			++ (* pDocIter);

			if ( IsDocFit ( lDocId, iVersion ) )
				return lDocId;
		}
	}

    return NEW_ID;
}

int Full :: IsDocFit ( long lDocId, int iVersion )
{
#ifdef SKIP_TO_DOCID
	return lDocId == SKIP_TO_DOCID;
#endif
	Base* pBase = 0;
	switch ( iVersion ) {
	case VER_NEW :
		pBase = m_pNewBase;
		break;
	case VER_OLD :
		pBase = m_pOldBase;
		break;
	}

	if ( lDocId <= ID_BORDER ) return 0;

	StorableSplaySet<unsigned short> ids;
	pBase->LoadAttr( lDocId, IDD_BASES, ids );
			
	return ids & m_ids;
}

int Full :: FindDoc ( long lDocId, int iVersion )
{
	Base * pBase = 0;

	switch ( iVersion ) {
	case VER_NEW :
		pBase = m_pNewBase;
		break;

	    case VER_OLD :
		pBase = m_pOldBase;
		break;
	}
	DocInfo docinfo;
	if ( pBase->FindDocInfo( lDocId, docinfo ) != sizeof( DocInfo ))
		return 0;
	return IsDocFit ( lDocId, iVersion );
}

int Full::GetDocOrder ( long lDocId )
{
	if ( ! FindDoc ( lDocId, VER_OLD ) ) {
		m_pNewBase->FindDocInfo ( lDocId, m_NewDocInfo );
		g_newdocs.insert (lDocId);
		return O_DOC_NEW;
	}

	m_pOldBase->FindDocInfo ( lDocId, m_OldDocInfo );
	m_pNewBase->FindDocInfo ( lDocId, m_NewDocInfo );

	if (memcmp(&m_OldDocInfo.Revision,&m_NewDocInfo.Revision,sizeof(revision))){
		g_chgdocs.insert (lDocId);
		return O_DOC_CHG;
	}
	
	g_equdocs.insert (lDocId);
	return O_DOC_EQU;
}

void	Full::AddDelDoc(long lDelDocId)
{
	if ( for_all_segs )
		logger.printf ( lt_deltaInfo, "Doc %ld (%ld)- del\n", lDelDocId, seg );
	else
		logger.printf ( lt_deltaInfo, "Doc %ld - del\n", lDelDocId );
	g_deldocs.insert (lDelDocId);
	g_global_deldocs.insert (lDelDocId);
	FillCorrList ( lDelDocId );
	fwrite ( &lDelDocId, sizeof (long), 1, m_DFile1 );  // DOC ID			
}

void	Full::FinishDelDoc()
{
	long lDelDocId = NEW_ID;
	fwrite ( &lDelDocId, sizeof (long), 1, m_DFile1 );		
}

void Full::FindDelDoc ()
{
	long lDelDocId;
	if (!b_gctx_attrs_only) {
		if ( m_deldocs ) {
			for ( Point p = m_deldocs->first(); p; m_deldocs->next(p) ) {
				lDelDocId = m_deldocs->contents(p);

				if (b_sbrf && (lDelDocId < SBRF_LOW_ID || lDelDocId > SBRF_HI_ID))
					continue;

				if ( !FindDoc(lDelDocId, VER_OLD) ) {
					logger.printf ( lt_warning, "deleted doc (%ld) from del-file missed in old base\n", lDelDocId );
					continue;
				}
				/*
				if ( FindDoc(lDelDocId, VER_NEW) ) {
					if ( g_chgdocs.find (lDelDocId) != g_chgdocs.end ())
						logger.printf ( lt_warning, "deleted doc (%ld) from del-file is changed in new base\n", lDelDocId );
					else if ( g_newdocs.find (lDelDocId) != g_newdocs.end ())
						logger.printf ( lt_warning, "deleted doc (%ld) from del-file is added in new base\n", lDelDocId );
					else
						logger.printf ( lt_warning, "deleted doc (%ld) from del-file is present in new base\n", lDelDocId );
					continue;
				}
				*/
				AddDelDoc(lDelDocId);
			}
		} else {
			while ( ( lDelDocId = GetNextDocId ( VER_OLD ) ) != NEW_ID ) {
				if ( ! FindDoc ( lDelDocId, VER_NEW ) ) {
					AddDelDoc(lDelDocId);
				}
			}
		}
	}
	FinishDelDoc();
}

int Full::TagAttrDiff ( long lDocId, int iTag, int bNewDoc, char* s_tag )
{
	long	delCount = 0, addCount = 0;
	u_int64_t fptDelAdd, fptCurrent;

	fptDelAdd = _ftelli64 (m_AttrFile);
	fwrite (&delCount, sizeof (delCount), 1, m_AttrFile);
	fwrite (&addCount, sizeof (addCount), 1, m_AttrFile);
	
	switch ( iTag ) {
	case IDD_INFO :
	{
		long iOldSize = 0;
		long iNewSize = 0;

		DocInfo* vOldBuff = bNewDoc?0:(DocInfo*) m_pOldBase->LoadAttr( lDocId, iTag, iOldSize );
		if ( iOldSize == -1 ) {
			iOldSize = 0;
			vOldBuff = 0;
		}

		DocInfo* vNewBuff = (DocInfo*) m_pNewBase->LoadAttr( lDocId, iTag, iNewSize );
		if ( iNewSize == - 1 ) {
			iNewSize = 0;
			vNewBuff = 0;
		}
		
		// constraint
		{
			short newDSDoc = vNewBuff->Status & (DS_DOC | DS_NODOC );
			short newDSActive = vNewBuff->Status & (DS_ACTIVE | DS_ABOLISHED | DS_PREACTIVE );
			short newDSReg = vNewBuff->Status & (DS_MOJREG | DS_MOJNOTREG | DS_MOJOTHER);

			short oldDSDoc;
			short oldDSActive;
			short oldDSReg;
			if ( vOldBuff ) {
				oldDSDoc = vOldBuff->Status & (DS_DOC | DS_NODOC );
				oldDSActive = vOldBuff->Status & (DS_ACTIVE | DS_ABOLISHED | DS_PREACTIVE);
				oldDSReg = vOldBuff->Status & (DS_MOJREG | DS_MOJNOTREG | DS_MOJOTHER);
			} else {
				oldDSDoc = DS_NODOC;
				oldDSActive = 0;
				oldDSReg = 0;
			}

			if ( !oldDSDoc || !newDSDoc ) {
				logger.printf ( lt_error, "Invalid topic's doc (%ld) status (old:0x%04X, new:0x%04X)\n",
					lDocId, oldDSDoc, newDSDoc );
				if ( !oldDSDoc ) oldDSDoc = DS_NODOC;
				if ( !newDSDoc ) newDSDoc = DS_NODOC;
			}
			if ( oldDSDoc == DS_DOC && (!oldDSActive || !oldDSReg) ) 
				logger.printf ( lt_error, "Invalid old doc's (%ld) active or reg status (active:0x%04X, reg:0x%04X)\n",
					lDocId, oldDSActive, oldDSReg );
			if ( newDSDoc == DS_DOC && (!newDSActive || !newDSReg) ) 
				logger.printf ( lt_error, "Invalid new doc's (%ld) active or reg status (active:0x%04X, reg:0x%04X)\n",
					lDocId, newDSActive, newDSReg );
		}
		/////////////
	
		if (!vOldBuff || ((b_gctx_attrs_only && ((vOldBuff->Status & (DS_NODOC|DS_DOC|DS_EDITION)) != (vNewBuff->Status & (DS_NODOC|DS_DOC|DS_EDITION)))) || DocInfoCmp (*vOldBuff, *vNewBuff, false))) {
			delCount = 0;
			addCount = 1;

			fwrite ( vNewBuff->Title, 1, DOC_SHORT_NAME_SIZE,m_AttrFile );
			fwrite ( & vNewBuff->FirstDate, sizeof ( vNewBuff->FirstDate ), 1, m_AttrFile );
			fwrite ( & vNewBuff->LastDate, sizeof ( vNewBuff->LastDate ), 1, m_AttrFile );
			fwrite ( & vNewBuff->Force, sizeof ( vNewBuff->Force ), 1, m_AttrFile );
			fwrite ( & vNewBuff->HyperRefs, sizeof ( vNewBuff->HyperRefs ), 1, m_AttrFile );
			fwrite ( & vNewBuff->GreenComments, sizeof ( vNewBuff->GreenComments ), 1, m_AttrFile );
			fwrite ( & vNewBuff->Related, sizeof ( vNewBuff->Related ), 1, m_AttrFile );
			fwrite ( & vNewBuff->Status, sizeof ( vNewBuff->Status ), 1, m_AttrFile );
			fwrite ( & vNewBuff->Status_ex, sizeof ( vNewBuff->Status_ex ), 1, m_AttrFile );
			unsigned short status_exex = GetDocStatusExEx (vNewBuff);
			fwrite ( &status_exex , sizeof (status_exex), 1, m_AttrFile );
			fwrite ( & vNewBuff->prevEdition, sizeof ( vNewBuff->prevEdition ), 1, m_AttrFile );
			fwrite ( & vNewBuff->nextEdition, sizeof ( vNewBuff->nextEdition ), 1, m_AttrFile );
			fwrite ( & vNewBuff->reserved_short,  sizeof ( vNewBuff->reserved_short ), 1, m_AttrFile );
			fwrite ( & vNewBuff->reserved_short2, sizeof ( vNewBuff->reserved_short2), 1, m_AttrFile );
			if (bNewDoc || !b_daily) {
				fwrite ( & vNewBuff->long_respondents,  sizeof ( vNewBuff->long_respondents), 1, m_AttrFile );
				fwrite ( & vNewBuff->hi_long_respondents,  sizeof ( vNewBuff->hi_long_respondents), 1, m_AttrFile );
			} else {
				fwrite ( & vOldBuff->long_respondents,  sizeof ( vOldBuff->long_respondents), 1, m_AttrFile );
				fwrite ( & vOldBuff->hi_long_respondents,  sizeof ( vOldBuff->hi_long_respondents), 1, m_AttrFile );
			}
		} else {
			delCount = 0;
			addCount = 0;
		}

		if ( vOldBuff ) free ( vOldBuff );
		if ( vNewBuff ) free ( vNewBuff );
	}
		break;

	case IDD_SUBS :
	{
		StorableSplaySet<SubDesc> oldSubs;
		StorableSplaySet<SubDesc> newSubs;
		StorableSplaySet<SubDesc> andSubs;
                        
		m_pNewBase->LoadAttr( lDocId, iTag, newSubs );
		if (!bNewDoc) m_pOldBase->LoadAttr( lDocId, iTag, oldSubs );
			
		(andSubs = newSubs) &= oldSubs;
		oldSubs -= andSubs;
		newSubs -= andSubs;

		char pOldName [SUB_NAME_SIZE * 16];
		char pNewName [SUB_NAME_SIZE * 16];

		Point p;
		for ( p = andSubs.first(); p; andSubs.next(p) ) {
			m_pOldBase->FindSubName ( lDocId, andSubs(p).Sub, pOldName );
			m_pNewBase->FindSubName ( lDocId, andSubs(p).Sub, pNewName );
				
			int modify;
			if ( pOldName && pNewName )
				modify = strncmp ( pOldName, pNewName, SUB_NAME_SIZE );
			else
				modify = pOldName == pNewName;
			if ( modify ) {
				oldSubs.add ( andSubs(p) );
				newSubs.add ( andSubs(p) );
			}
		}

		delCount = oldSubs.length();
		addCount = newSubs.length();

		for ( p = oldSubs.first(); p; oldSubs.next(p) ) {
			SubDesc sub = oldSubs(p);
			fwrite ( &sub, sizeof ( sub ), 1, m_AttrFile );
		}

		for ( p = newSubs.first(); p; newSubs.next(p) ) {			
			SubDesc sub = newSubs(p);
			fwrite ( &sub, sizeof ( SubDesc ), 1, m_AttrFile );

			m_pNewBase->FindSubName ( lDocId, sub.Sub, pNewName );
			long length = pNewName ? strlen (pNewName) : 0;
			if (length > SUB_NAME_SIZE) length = SUB_NAME_SIZE;
			m_pOldBase->FindSubName (lDocId, sub.Sub, pOldName);
			long oldlength = pOldName ? strlen (pOldName) : 0;
			if (oldlength > SUB_NAME_SIZE) oldlength = SUB_NAME_SIZE;

			if (length == oldlength && !memcmp (pNewName, pOldName, length) && !bNewDoc)
				length = -1;
			
			fwrite ( &length, sizeof ( length ), 1, m_AttrFile );
			if (length == -1)
				length = 0;
			fwrite ( pNewName, length, 1, m_AttrFile );
		}
	}
		break;

	case IDD_DOCSTRUCT:
	{
		StorableSplaySet<DocStruct> oldStruct, newStruct, andStruct;
		std::map<long,DocStruct> old_map;
		Point p;
		{
			std::map<long,long> map_childid_mid;
			long size, i;
			DocStruct *data = (DocStruct*) m_pNewBase->LoadAttr (lDocId, IDD_DOCSTRUCT, size), *ptr = data;
			for (i = 0, size /= sizeof (DocStruct); i < size; i++, ptr++) {
				newStruct.add (*ptr);
				map_childid_mid.insert (std::map<long,long>::value_type (i, ptr->m_id));
			}
			for (p = newStruct.first (); p; newStruct.next (p)) {
				DocStruct *atp = &newStruct.contents(p);
				if (atp->m_first_child) atp->m_first_child = map_childid_mid.find (atp->m_first_child)->second;
				if (atp->m_last_child) atp->m_last_child = map_childid_mid.find (atp->m_last_child)->second;
			}
			if (size) gk_free (data);
		}
		if (!bNewDoc) {
			long size, i;
			DocStruct *data = (DocStruct*) m_pOldBase->LoadAttr (lDocId, IDD_DOCSTRUCT, size), *ptr = data;
			std::map<long,long> map_childid_mid;
			for (i = 0, size /= sizeof (DocStruct); i < size; i++, ptr++) {
				oldStruct.add (*ptr);
				map_childid_mid.insert (std::map<long,long>::value_type (i, ptr->m_id));
			}
			for (p = oldStruct.first (); p; oldStruct.next (p)) {
				DocStruct *atp = &oldStruct.contents(p);
				if (atp->m_first_child) atp->m_first_child = map_childid_mid.find (atp->m_first_child)->second;
				if (atp->m_last_child) atp->m_last_child = map_childid_mid.find (atp->m_last_child)->second;
				old_map.insert (std::map<long,DocStruct>::value_type (atp->m_id, *atp));
			}
			if (size) gk_free (data);
		}
		//во всех данных - m_first/last_child - это id, а не позиция; или 0
			
		(andStruct = newStruct) &= oldStruct;
		oldStruct -= andStruct;
		newStruct -= andStruct;

		delCount = oldStruct.length();
		addCount = newStruct.length();

		bool b_changed = false;
		for ( p = andStruct.first(); p; andStruct.next(p) ) {
			DocStruct new_value = andStruct (p);
			DocStruct old_value = old_map.find (new_value.m_id)->second;
			char mask = 0;
			if (old_value.m_para_list_id != new_value.m_para_list_id) mask |= 1;
			if (old_value.m_para_list_type != new_value.m_para_list_type) mask |= 2;
			if (old_value.m_start_para != new_value.m_start_para) mask |= 4;
			if (old_value.m_end_para != new_value.m_end_para) mask |= 8;
			if (old_value.m_first_child != new_value.m_first_child) mask |= 16;
			if (old_value.m_last_child != new_value.m_last_child) mask |= 32;
			if (mask) {
				b_changed = true;
				break;
			}
		}

		long andCount = b_changed ? andStruct.length () : 0;
		fwrite (&andCount, sizeof (long), 1, m_AttrFile);
		if (andCount && !(addCount + delCount))
			addCount = delCount = -1;

		//сначала запишем удаляемые (только m_id)
		for ( p = oldStruct.first(); p; oldStruct.next(p) ) {
			DocStruct sub = oldStruct(p);
			fwrite (&sub.m_id, sizeof (sub.m_id), 1, m_AttrFile);
		}

		//у новых пишем 5 полей: m_id, m_para_list_id, m_para_list_type, m_start_para, m_end_para;
		//а в качестве first_child/last_child пишем idшники first_childa/last_childa

		for ( p = newStruct.first(); p; newStruct.next(p) ) {
			DocStruct sub = newStruct(p);
			fwrite (&sub.m_id, sizeof (sub.m_id), 1, m_AttrFile);
			fwrite (&sub.m_para_list_id, sizeof (sub.m_para_list_id), 1, m_AttrFile);
			fwrite (&sub.m_para_list_type, sizeof (sub.m_para_list_type), 1, m_AttrFile);
			fwrite (&sub.m_start_para, sizeof (sub.m_start_para), 1, m_AttrFile);
			fwrite (&sub.m_end_para, sizeof (sub.m_end_para), 1, m_AttrFile);
			fwrite (&sub.m_first_child, sizeof (sub.m_first_child), 1, m_AttrFile);
			fwrite (&sub.m_last_child, sizeof (sub.m_last_child), 1, m_AttrFile);
		}

		//у старых могут измениться 4 поля. поэтому пишем маску изменений, потом m_id (если маска не 0), потом собственно изменения
		for ( p = andStruct.first(); p; andStruct.next(p) ) {
			DocStruct new_value = andStruct (p);
			DocStruct old_value = old_map.find (new_value.m_id)->second;
			char mask = 0;
			if (old_value.m_para_list_id != new_value.m_para_list_id) mask |= 1;
			if (old_value.m_para_list_type != new_value.m_para_list_type) mask |= 2;
			if (old_value.m_start_para != new_value.m_start_para) mask |= 4;
			if (old_value.m_end_para != new_value.m_end_para) mask |= 8;
			if (old_value.m_first_child != new_value.m_first_child) mask |= 16;
			if (old_value.m_last_child != new_value.m_last_child) mask |= 32;
			fwrite (&mask, sizeof (mask), 1, m_AttrFile);
			if (mask) {
				fwrite (&new_value.m_id, sizeof (new_value.m_id), 1, m_AttrFile);
				if (mask & 1) fwrite (&new_value.m_para_list_id, sizeof (new_value.m_para_list_id), 1, m_AttrFile);
				if (mask & 2) fwrite (&new_value.m_para_list_type, sizeof (new_value.m_para_list_type), 1, m_AttrFile);
				if (mask & 4) fwrite (&new_value.m_start_para, sizeof (new_value.m_start_para), 1, m_AttrFile);
				if (mask & 8) fwrite (&new_value.m_end_para, sizeof (new_value.m_end_para), 1, m_AttrFile);
				if (mask & 16) fwrite (&new_value.m_first_child, sizeof (new_value.m_first_child), 1, m_AttrFile);
				if (mask & 32) fwrite (&new_value.m_last_child, sizeof (new_value.m_last_child), 1, m_AttrFile);
			}
		}
	}
		break;
	
	case IDD_SUBS_EX :
	{
		StorableSplaySet<SubDescEx> oldSubs, newSubs, andSubs;
		Point p;
		{
			long size, i;
			SubDescEx *data = (SubDescEx*) m_pNewBase->LoadAttr (lDocId, IDD_SUBS_EX, size), *ptr = data;
			for (i = 0, size /= sizeof (SubDescEx); i < size; i++, ptr++)
				newSubs.add (*ptr);
			if (size) gk_free (data);
		}
		if (!bNewDoc) {
			long size, i;
			SubDescEx *data = (SubDescEx*) m_pOldBase->LoadAttr (lDocId, IDD_SUBS_EX, size), *ptr = data;
			for (i = 0, size /= sizeof (SubDescEx); i < size; i++, ptr++)
				oldSubs.add (*ptr);
			if (size) gk_free (data);
		}
			
		(andSubs = newSubs) &= oldSubs;
		oldSubs -= andSubs;		
		newSubs -= andSubs;

		delCount = oldSubs.length();
		addCount = newSubs.length();

		for ( p = oldSubs.first(); p; oldSubs.next(p) ) {
			SubDescEx sub = oldSubs(p);
			fwrite ( &sub, sizeof ( sub ), 1, m_AttrFile );
		}

		for ( p = newSubs.first(); p; newSubs.next(p) ) {
			SubDescEx atp = newSubs(p);
			fwrite ( newSubs[p], sizeof ( SubDescEx ), 1, m_AttrFile );
		}
	}
		break;

	case IDD2_NAME:
		{
			char	pOldName [DOC_NAME_SIZE+1]; pOldName [0] = 0; pOldName [DOC_NAME_SIZE] = 0;
			char	pNewName [DOC_NAME_SIZE+1]; pNewName [0] = 0; pNewName [DOC_NAME_SIZE] = 0;
			Stream *str= 0;
			Ref ref = {lDocId, 0};

			if (!bNewDoc && (str= m_pOldBase->subNames->Open(&ref))){
				if(str->Length() > DOC_NAME_SIZE){
					logger.printf ( lt_error, "Invalid topic's doc (%ld) annoname in Old base\n",lDocId);
					str->Read(pOldName, DOC_NAME_SIZE);
				}else{
					str->Read(pOldName, str->Length());
				}
				m_pOldBase->subNames->Close(str);
			}
			if ((str= m_pNewBase->subNames->Open(&ref))){
				if(str->Length() > DOC_NAME_SIZE){
					logger.printf ( lt_error, "Invalid topic's doc (%ld) annoname in New base\n",lDocId);
					str->Read(pNewName, DOC_NAME_SIZE);
				}else{
					str->Read(pNewName, str->Length());
				}
				m_pNewBase->subNames->Close(str);
			}
			if ( !strcmp( pOldName, pNewName )) {
				delCount = 0;
				addCount = 0;
			} else {
				long newLength = strlen( pNewName );
				fwrite ( &newLength, sizeof( newLength ), 1, m_AttrFile );

				short	dummy = 0;
				fwrite ( &dummy, sizeof( dummy ), 1, m_AttrFile );
				
				fwrite ( &newLength, sizeof( newLength ), 1, m_AttrFile );
				fwrite ( pNewName, 1, newLength, m_AttrFile );

				delCount = 1;
				addCount = 1;
			}
		}
		break;

	case IDD_REGDATE:
	case IDD_ANNULDATE:
	case IDD_ACTIVEEX:
		{
		StorableSplaySet<u_int64_t> oldSet;
		StorableSplaySet<u_int64_t> newSet;
		StorableSplaySet<u_int64_t> andSet;
			
		m_pNewBase->LoadAttr (lDocId, iTag, newSet);
		if (!bNewDoc) m_pOldBase->LoadAttr (lDocId, iTag, oldSet);
			
		(andSet = newSet) &= oldSet;
		oldSet -= andSet;
		newSet -= andSet;

		delCount = oldSet.length();
		addCount = newSet.length();
		
		Point p;
		for ( p = oldSet.first(); p; oldSet.next(p) )
			fwrite ( oldSet[p], sizeof (u_int64_t), 1, m_AttrFile );

		for ( p = newSet.first(); p; newSet.next(p) )
			fwrite ( newSet[p], sizeof (u_int64_t), 1, m_AttrFile );
		}
		break;

	case IDD_DIV :
	case IDD_KEY :
	case IDD_ID :
	case IDD_ADDCODE :
	case IDD_SOURCE:
	case IDD_TYPE :
	case IDD_KIND :
	case IDD_RCODE :
	case IDD_WARNING :
	case IDD_PUBLISHEDIN :
	case IDD_CATEGORY :
	case IDD_DOCKIND :
	case IDD_TERRITORY :	
	case IDD_ANNOUSER:
	case IDD_ANNOORGANIZATION:
	case IDD_ANNOTAX:
	case IDD_ANNOINTEREST:
	case IDD_ANNOKIND:
	case IDD_SERVICEINFO:
	case IDD_INPHARMFIRM:
	case IDD_INPHARMCOUNTRY:
	case IDD_TRADENAME:
	case IDD_INTNAME:
	case IDD_PHARMGROUP:
	case IDD_PHARMEFFECT:
	case IDD_CHAPTER:
	case IDD_ATC:
	case IDD_REGSTATUS:
	case IDD_LEKFORM:
	case IDD_MKB:
	case IDD_TAG:
	{
		long iOldSize = 0;
		long iNewSize = 0;
		int  withSub = (iTag==IDD_KEY || iTag==IDD_DIV || iTag==IDD_DOCKIND || iTag==IDD_TYPE || iTag == IDD_SERVICEINFO || iTag == IDD_INPHARMFIRM || iTag == IDD_INPHARMCOUNTRY || iTag == IDD_MKB || iTag == IDD_CHAPTER || iTag == IDD_REGSTATUS || iTag == IDD_LEKFORM || iTag == IDD_MKB || iTag == IDD_KIND || iTag == IDD_TAG) ? 1:0;

		void* vOldBuff = bNewDoc?0:m_pOldBase->LoadAttr( lDocId, iTag, iOldSize );
		if ( iOldSize == -1 ) iOldSize = 0, vOldBuff = 0;
		void* vNewBuff = m_pNewBase->LoadAttr( lDocId, iTag, iNewSize );
		if ( iNewSize == - 1 ) iNewSize = 0, vNewBuff = 0;

		StringZ aNewKey ( (char*) vNewBuff, iNewSize, withSub );
		StringZ aOldKey ( (char*) vOldBuff, iOldSize, withSub );

		if ( aNewKey.Equal ( &aOldKey ) ) {
			delCount = 0;
			addCount = 0;
		} else {
			fwrite ( &iNewSize, sizeof ( iNewSize ), 1, m_AttrFile );
			while ( ! aOldKey.End () ) {
				if ( aNewKey.Find ( aOldKey() ) == -1 ) {
					short iDelPos = (short) aOldKey.GetPos ();
					fwrite ( &iDelPos, sizeof ( iDelPos ), 1, m_AttrFile );
					delCount++;
				}
				++aOldKey;
			}

			while ( ! aNewKey.End () ) {
				if ( aOldKey.Find ( aNewKey() ) == -1 ) {
					long iKeySize = strlen ( aNewKey() );
					fwrite ( &iKeySize, sizeof ( iKeySize ), 1, m_AttrFile );
					fwrite ( aNewKey(), 1, iKeySize, m_AttrFile );
					addCount++;
				}
				++ aNewKey;
			}
		}
			
		if ( vOldBuff ) free ( vOldBuff );
		if ( vNewBuff ) free ( vNewBuff );
	}
		break;

	case IDD_CLASS6:
	{
		long iOldSize = 0, iNewSize = 0;

		if (!b_ovp) {
			bool b_537955657 = false; //http://mdp.garant.ru/pages/viewpage.action?pageId=537955657&focusedCommentId=537968023#comment-537968023
			void* vOldBuff = bNewDoc?0:m_pOldBase->LoadAttr( lDocId, iTag, iOldSize );
			if ( iOldSize == -1 )  {
				iOldSize = 0;
				vOldBuff = 0;
			} else if (iOldSize) {
				//!конвертнуть в "прямые" данные, вида 001=...\002=...
				char *ptr = (char*) vOldBuff;
				long i = 0, new_len = 0;
				std::vector<std::string> strings;			
				while (i < iOldSize) {
					int len = strlen (ptr)+1;
					char *semipos = strchr (ptr, ':');
					*semipos++ = '\0';
					std::string new_iddclass6 (ptr);
					new_iddclass6 += ':';
					long old_id = atol (semipos);
					std::string old_str = old_map_id_str.find (old_id)->second;
					new_iddclass6 += old_str;
					if (new_map_str_id.find (old_str) != new_map_str_id.end ()) {
						long new_id = new_map_str_id.find (old_str)->second;
						if (new_id != old_id)
							b_537955657 = true;
					}
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
			void* vNewBuff = m_pNewBase->LoadAttr (lDocId, iTag, iNewSize);
			if ( iNewSize == - 1 ) {
				iNewSize = 0;
				vNewBuff = 0;
			} else if (iNewSize) {
				//конвертнуть в "прямые" данные, вида 001=...\002=...
				//новые данные в дельту попадут в "прямом" формате
				char *ptr = (char*) vNewBuff;
				long i = 0, new_len = 0;
				std::vector<std::string> strings;			
				while (i < iNewSize) {
					int len = strlen (ptr)+1;
					char *semipos = strchr (ptr, ':');
					*semipos++ = '\0';
					std::string new_iddclass6 (ptr);
					new_iddclass6 += ':';

					long new_id = atol (semipos);
					std::string new_str = new_map_id_str.find (new_id)->second;
					new_iddclass6 += new_str;
					if (old_map_str_id.find (new_str) != old_map_str_id.end ()) {
						long old_id = old_map_str_id.find (new_str)->second;
						if (old_id != new_id)
							b_537955657 = true;
					}

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
				gk_free (vNewBuff);
				vNewBuff = new_buff;
				iNewSize = new_len;
			}

			StringZ aNewKey ( (char*) vNewBuff, iNewSize, 1);
			StringZ aOldKey ( (char*) vOldBuff, iOldSize, 1);

			if ( aNewKey.Equal ( &aOldKey ) ) {
				if (b_537955657) {
					fwrite ( &iNewSize, sizeof ( iNewSize ), 1, m_AttrFile );

					while ( ! aOldKey.End () ) {
						short iDelPos = (short) aOldKey.GetPos ();
						fwrite ( &iDelPos, sizeof ( iDelPos ), 1, m_AttrFile );
						delCount++;
						++aOldKey;
					}

					while ( ! aNewKey.End () ) {
						long iKeySize = strlen ( aNewKey() );
						fwrite ( &iKeySize, sizeof ( iKeySize ), 1, m_AttrFile );
						fwrite ( aNewKey(), 1, iKeySize, m_AttrFile );
						addCount++;
						++aNewKey;
					}
				} else {
					delCount = 0;
					addCount = 0;
				}
			} else {
				fwrite ( &iNewSize, sizeof ( iNewSize ), 1, m_AttrFile );
				while ( ! aOldKey.End () ) {
					if ( aNewKey.Find ( aOldKey() ) == -1 ) {
						short iDelPos = (short) aOldKey.GetPos ();
						fwrite ( &iDelPos, sizeof ( iDelPos ), 1, m_AttrFile );
						delCount++;
					}
					++aOldKey;
				}

				while ( ! aNewKey.End () ) {
					if ( aOldKey.Find ( aNewKey() ) == -1 ) {
						long iKeySize = strlen ( aNewKey() );
						fwrite ( &iKeySize, sizeof ( iKeySize ), 1, m_AttrFile );
						fwrite ( aNewKey(), 1, iKeySize, m_AttrFile );
						addCount++;
					}
					++ aNewKey;
				}
			}
				
			if ( vOldBuff ) free ( vOldBuff );
			if ( vNewBuff ) free ( vNewBuff );
		}
	}
		break;

	case IDD_HANDMASK:
	case IDD_HANDHANDMASK:
		{
		long old_size = 0, new_size = 0;
		char *old_strings = bNewDoc ? 0 : (char*) m_pOldBase->LoadAttr (lDocId, iTag, old_size), *new_strings = (char*) m_pNewBase->LoadAttr (lDocId, iTag, new_size);

		if (old_size + new_size) {
			std::vector<std::string> old_vector, new_vector;
			char* ptr = old_strings;
			while (ptr - old_strings < old_size) {
				old_vector.push_back (ptr);
				ptr += strlen (ptr)+1;
			}
			ptr = new_strings;
			while (ptr - new_strings < new_size) {
				new_vector.push_back (ptr);
				ptr += strlen (ptr)+1;
			}

			//найти те, которые удалили (в старых есть, в новых - нет)
			std::vector<std::string>::const_iterator it_old, it_new;
			std::vector<long> del_positions, add_positions;
			long del_pos = 0, add_pos = 0;
			for (it_old = old_vector.begin (), it_new = new_vector.begin (); it_old != old_vector.end () && it_new != new_vector.end (); it_old++, del_pos++) {
				if (*it_old == *it_new) {
					it_new++;
				} else {
					del_positions.push_back (del_pos);
					delCount++;
				}
			}
			for (; it_old != old_vector.end (); it_old++, del_pos++, delCount++)
				del_positions.push_back (del_pos);

			//теперь из старых надо удалить те, которые удаляются
			for (std::vector<long>::reverse_iterator rit = del_positions.rbegin (); rit != del_positions.rend (); rit++) {
				long del_pos = *rit;
				old_vector.erase (old_vector.begin () + del_pos);
			}

			//теперь надо найти те, которые добавляются
			std::vector<std::string> add_strings;
			if (old_vector.size ()) {
				for (it_old = old_vector.begin (), it_new = new_vector.begin (); it_old != old_vector.end () && it_new != new_vector.end (); it_new++, add_pos++) {
					if (*it_old == *it_new) {
						it_old++;
					} else {
						add_positions.push_back (add_pos);
						add_strings.push_back (*it_new);
						addCount++;
					}
				}
				for (; it_new != new_vector.end (); it_new++, add_pos++, addCount++) {
					add_positions.push_back (add_pos);
					add_strings.push_back (*it_new);
				}
			} else {
				for (it_new = new_vector.begin (); it_new != new_vector.end (); it_new++, add_pos++, addCount++) {
					add_positions.push_back (add_pos);
					add_strings.push_back (*it_new);
				}
			}

			std::vector<long>::const_iterator pit;
			for (pit = del_positions.begin (); pit != del_positions.end (); pit++) {
				long at_pit = *pit;
				fwrite (&at_pit, sizeof (long), 1, m_AttrFile);
			}
			for (pit = add_positions.begin (); pit != add_positions.end (); pit++) {
				long at_pit = *pit;
				fwrite (&at_pit, sizeof (long), 1, m_AttrFile);
			}
			for (it_new = add_strings.begin (); it_new != add_strings.end (); it_new++) {
				fwrite (it_new->c_str (), strlen (it_new->c_str ())+1, 1, m_AttrFile);
			}

			if (old_strings) gk_free (old_strings);
			if (new_strings) gk_free (new_strings);
		}
		}
		break;

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
	case IDD_PREANNODATE:
	case IDD_ANNODATE:
	{
		StorableSplaySet<date> oldSet;
		StorableSplaySet<date> newSet;
		StorableSplaySet<date> andSet;
			
		m_pNewBase->LoadAttr( lDocId, iTag, newSet );
		if (!bNewDoc) m_pOldBase->LoadAttr( lDocId, iTag, oldSet );
			
		(andSet = newSet) &= oldSet;
		oldSet -= andSet;
		newSet -= andSet;

		delCount = oldSet.length();
		addCount = newSet.length();
		
		Point p;
		for ( p = oldSet.first(); p; oldSet.next(p) )
			fwrite ( oldSet[p], sizeof ( date ), 1, m_AttrFile );

		for ( p = newSet.first(); p; newSet.next(p) )
			fwrite ( newSet[p], sizeof ( date ), 1, m_AttrFile );
	}
		break;
		
	case IDD_LIFE:
	case IDD_NOTLIFE:
	case IDD_UNRECIPE:
	case IDD_RECIPE:
	case IDD_ALLOWED:
	case IDD_NOTALLOWED:
		{
		StorableSplaySet<long> oldSet, newSet, andSet;
		m_pNewBase->LoadAttr (lDocId, iTag, newSet);
		if (!bNewDoc) m_pOldBase->LoadAttr (lDocId, iTag, oldSet);
			
		(andSet = newSet) &= oldSet;
		oldSet -= andSet;
		newSet -= andSet;

		delCount = oldSet.length();
		addCount = newSet.length();
		
		Point p;
		for ( p = oldSet.first(); p; oldSet.next(p) )
			fwrite ( oldSet[p], sizeof ( long ), 1, m_AttrFile );

		for ( p = newSet.first(); p; newSet.next(p) )
			fwrite ( newSet[p], sizeof ( long ), 1, m_AttrFile );
		}
		break;

	case IDD_BASES:
	{
		StorableSplaySet<short> oldSet;
		StorableSplaySet<short> newSet;
		StorableSplaySet<short> andSet;
		m_pNewBase->LoadAttr( lDocId, iTag, newSet );
		if (!bNewDoc) m_pOldBase->LoadAttr( lDocId, iTag, oldSet );
			
		(andSet = newSet) &= oldSet;
		oldSet -= andSet;
		newSet -= andSet;

		delCount = oldSet.length();
		addCount = newSet.length();
		
		Point p;
		for ( p = oldSet.first(); p; oldSet.next(p) )
			fwrite ( oldSet[p], sizeof ( short ), 1, m_AttrFile );

		for ( p = newSet.first(); p; newSet.next(p) )
			fwrite ( newSet[p], sizeof ( short ), 1, m_AttrFile );
	}
		break;

	case IDD_SOURCEFILE :
		// ignore
		break; 

	case IDD2_PARAIDS:
		{
		long iOldSize = -1;
		long iNewSize = 0;

		void gk_huge* vOldBuff = 0;
		if (!bNewDoc) vOldBuff = m_pOldBase->LoadAttrEx( lDocId, iTag, iOldSize );
		void gk_huge* vNewBuff = m_pNewBase->LoadAttrEx( lDocId, iTag, iNewSize );

		if ( iOldSize == -1 ) {
			iOldSize = 0;
			vOldBuff = 0;
		}
		if ( iNewSize == -1 ) {
			iNewSize = 0;
			vNewBuff = 0;
		}

		if ( !iNewSize && !iOldSize ) {
		}
		else
		if ( !iNewSize ) {
			delCount = 1;
			addCount = 0;
		}
		else
		if ( !iOldSize ) {
			delCount = 0;
			addCount = 1;
		}
		else {
			if (iOldSize != iNewSize) {
				delCount = 1;
				addCount = 1;
			} else {
				if (memcmp( vOldBuff, vNewBuff, iOldSize )) {
					delCount = 1;
					addCount = 1;
				} else {
					iNewSize = 0;
					DocInfo old_docinfo, new_docinfo;
					m_pOldBase->FindDocInfo( lDocId, old_docinfo );
					m_pNewBase->FindDocInfo( lDocId, new_docinfo );
					if (old_docinfo.lastParaID != new_docinfo.lastParaID)
						addCount = 1;
				}
			}
		}

		if ( addCount ) {
			DocInfo docInfo;
			m_pNewBase->FindDocInfo( lDocId, docInfo );
			fwrite( &docInfo.lastParaID, 1, sizeof( docInfo.lastParaID ), m_AttrFile );

			fwrite( &iNewSize, 1, sizeof( iNewSize ), m_AttrFile );
			if (iNewSize) fwrite( vNewBuff, 1, iNewSize, m_AttrFile );
		}

		if ( vOldBuff ) gk_free( vOldBuff );
		if ( vNewBuff ) gk_free( vNewBuff );
		}
		break;

	case IDD_ACTIVE:
	case IDD_PAGEBREAKS:
	case IDD_CHDATE:
	case IDD_PROFDATE:
	case IDD_CHDATE_EX:
	case IDD_CHDATE_EXEX :
	case IDD_NOTSURE:
	case IDD_CONTENTS:
	case IDD_COMPARECONTENTS:
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
		long iOldSize = -1;
		long iNewSize = 0;

		void gk_huge* vOldBuff = 0;
		if (!bNewDoc) vOldBuff = m_pOldBase->LoadAttr( lDocId, iTag, iOldSize );
		void gk_huge* vNewBuff = m_pNewBase->LoadAttr( lDocId, iTag, iNewSize );

		if ( iOldSize == -1 ) {
			iOldSize = 0;
			vOldBuff = 0;
		}
		if ( iNewSize == -1 ) {
			iNewSize = 0;
			vNewBuff = 0;
		}

		if ( !iNewSize && !iOldSize ) {
		}
		else
		if ( !iNewSize ) {
			delCount = 1;
			addCount = 0;
		}
		else
		if ( !iOldSize ) {
			delCount = 0;
			addCount = 1;
		}
		else
		if ( iOldSize != iNewSize || memcmp( vOldBuff, vNewBuff, iOldSize )) {
			delCount = 1;
			addCount = 1;
		}

		if ( addCount ) {
			fwrite( &iNewSize, 1, sizeof( iNewSize ), m_AttrFile );
			fwrite( vNewBuff, 1, iNewSize, m_AttrFile );
		}

		if ( vOldBuff ) gk_free( vOldBuff );
		if ( vNewBuff ) gk_free( vNewBuff );
		}
		// если delCount == 1 старый ключ надо удалить
		// если addCount == 1 новый ключ надо записать
		break;

	case IDD_SAMEDOCS:
		{
		StorableSplaySet<DocRele> *oldSet = new StorableSplaySet<DocRele>;
		StorableSplaySet<DocRele> *newSet = new StorableSplaySet<DocRele>;
		StorableSplaySet<DocRele> *andSet = new StorableSplaySet<DocRele>;
		StorableSplaySet<DocRele> *savedoldset = new StorableSplaySet <DocRele>;
			
		m_pNewBase->LoadAttr (lDocId, iTag, *newSet);
		andSet->set_copy (newSet);

		if (!bNewDoc) {
			m_pOldBase->LoadAttr (lDocId, iTag, *oldSet);
			savedoldset->set_copy (oldSet);
		}

		andSet->set_and (oldSet);
		oldSet->set_minus (andSet);
		newSet->set_minus (andSet);

		delCount = oldSet->length();
		addCount = newSet->length();

		Point atold = oldSet->first (), p;
		if (delCount) {
			short *positions = new short [delCount], *ptr = positions + delCount - 1, position = 0;
			DocRele contentsatold = oldSet->contents (atold);
			for (p = savedoldset->first(); p; savedoldset->next(p), position++) {
				const DocRele *todelete = (*savedoldset)[p];
				if (!memcmp (todelete, &contentsatold, sizeof (DocRele))) {
					*ptr-- = position;
					oldSet->next (atold);
					if (!atold)
						break;
					contentsatold = oldSet->contents (atold);
				}
			}
			fwrite (positions, delCount, sizeof (short), m_AttrFile);
			delete []positions;
		}

		for ( p = newSet->first(); p; newSet->next(p) )
			fwrite ( (*newSet)[p], sizeof (DocRele), 1, m_AttrFile );

		delete savedoldset;
		delete andSet;
		delete newSet;
		delete oldSet;
		}

		break;

	case IDD_REFS:
		{
		StorableSplaySet<RespRef> *oldSet = new StorableSplaySet<RespRef>;
		StorableSplaySet<RespRef> *newSet = new StorableSplaySet<RespRef>;
		StorableSplaySet<RespRef> *andSet = new StorableSplaySet<RespRef>;
			
		m_pNewBase->LoadAttr( lDocId, iTag, *newSet );
		if (!bNewDoc) m_pOldBase->LoadAttr (lDocId, iTag, *oldSet);
			
		andSet->set_copy (newSet);
		andSet->set_and (oldSet);
		oldSet->set_minus (andSet);
		newSet->set_minus (andSet);

		delCount = oldSet->length();
		addCount = newSet->length();

		Point p;
		for ( p = oldSet->first(); p; oldSet->next(p) )
			fwrite ( (*oldSet)[p], sizeof ( RespRef ), 1, m_AttrFile );

		for ( p = newSet->first(); p; newSet->next(p) )
			fwrite ( (*newSet)[p], sizeof ( RespRef ), 1, m_AttrFile );

		delete andSet;
		delete oldSet;
		delete newSet;
		}

		break;
	
	default :
		logger.printf ( lt_fatal, "Unknown delting tag %X\n", iTag );
		exit ( EXIT_FAILURE );
	}

	if ( delCount || addCount ) {
		fptCurrent = _ftelli64 (m_AttrFile);
		if (b_extended_log) {
			if (s_tag)
				logger.printf (lt_deltaInfo, "\ntag %s changed, size: %ld", s_tag, fptCurrent - fptDelAdd);
			else
				logger.printf (lt_deltaInfo, "\ntag %X changed, size: %ld", iTag, fptCurrent - fptDelAdd);
			if (b_flush_log) logger.flush (lt_always);
		}
		_fseeki64 ( m_AttrFile, fptDelAdd, ACE_OS_SEEK_SET );
		fwrite ( &delCount, sizeof (delCount), 1, m_AttrFile );
		fwrite ( &addCount, sizeof (addCount), 1, m_AttrFile );
		_fseeki64 ( m_AttrFile, fptCurrent, ACE_OS_SEEK_SET );

		fflush ( m_AttrFile );
		return 1;
	} else {
		_fseeki64 ( m_AttrFile, fptDelAdd, ACE_OS_SEEK_SET );
		return 0;
	}
}

int Full::CreateAttrDiff ( long lDocId, char* pLevelMask, int bNewDoc )
{
	gk_bzero ( pLevelMask, MAX_LEVEL );

	int iLevelCount = 1;

	if (!b_texts_only) {
// first level (maximum 4 bits -xxxx---)
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_DATE, bNewDoc, "IDD_DATE" ) )                pLevelMask [0] |= M_ATR_DAT;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_VCHANGED, bNewDoc, "IDD_VCHANGED" ) )            pLevelMask [0] |= M_ATR_VCH;
	if ( TagAttrDiff ( lDocId, IDD_INFO, bNewDoc, "IDD_INFO" ) )                pLevelMask [0] |= M_ATR_INF;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_KEY, bNewDoc, "IDD_KEY" ) )                 pLevelMask [0] |= M_ATR_KEY;

// second level (maximum 7 bits -xxxxxxx)
	if ( TagAttrDiff ( lDocId, IDD_SUBS_EX, bNewDoc, "IDD_SUBS_EX"))            		pLevelMask [1] |= M_ATR_SUBSEX;
	if ( TagAttrDiff ( lDocId, IDD_TYPE, bNewDoc, "IDD_TYPE" ) )                pLevelMask [1] |= M_ATR_TYP;
	if ( TagAttrDiff ( lDocId, IDD_SOURCE, bNewDoc, "IDD_SOURCE" ) )              pLevelMask [1] |= M_ATR_SRC; // pair one
	if ( TagAttrDiff ( lDocId, IDD_TERRITORY, bNewDoc, "IDD_TERRITORY" ) )           pLevelMask [1] |= M_ATR_TER; // pair one
	if ( !bNewDoc ) pLevelMask [1] |= ChgStatus (); // sets two bits
	if (!b_gctx_attrs_only) if ( SaveRefIndDiff ( "Respondent", lDocId, bNewDoc) )         pLevelMask [1] |=M_ATR_IND_RESP;

// third level (maximum 7 bits -xxxxxxx)
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_BASES, bNewDoc, "IDD_BASES" ) )               pLevelMask [2] |= M_ATR_BAS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_ID, bNewDoc, "IDD_ID" ) )                  pLevelMask [2] |= M_ATR_ID;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_RCODE, bNewDoc, "IDD_RCODE" ) )               pLevelMask [2] |= M_ATR_RCD;
	if ( TagAttrDiff ( lDocId, IDD_DIV, bNewDoc, "IDD_DIV" ) )                 pLevelMask [2] |= M_ATR_DIV; // pair two
	if ( TagAttrDiff ( lDocId, IDD_DOCKIND, bNewDoc, "IDD_DOCKIND" ) )             pLevelMask [2] |= M_ATR_KND; // pair two
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_SORTDATE, bNewDoc, "IDD_SORTDATE" ) )            pLevelMask [2] |= M_ATR_SRT;
	if ( TagAttrDiff ( lDocId, IDD2_NAME, bNewDoc, "NAME" ) )               pLevelMask [2] |= M_ATR_NAM;

// forth level (maximum 7 bits -xxxxxxx)
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_RDATE, bNewDoc, "IDD_RDATE" ) )               pLevelMask [3] |= M_ATR_RDT;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_WARNING, bNewDoc, "IDD_WARNING" ) )             pLevelMask [3] |= M_ATR_WAR;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_VLCONTROL, bNewDoc, "IDD_VLCONTROL" ) )           pLevelMask [3] |= M_ATR_VLC;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_VANONCED, bNewDoc, "IDD_VANONCED" ) )            pLevelMask [3] |= M_ATR_VAN;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CATEGORY, bNewDoc, "IDD_CATEGORY" ) )            pLevelMask [3] |= M_ATR_CAT;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_PUBLISHEDIN, bNewDoc, "IDD_PUBLISHEDIN" ) )         pLevelMask [3] |= M_ATR_PUB; 
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_VABOLISHED, bNewDoc, "IDD_VABOLISHED" ) )          pLevelMask [3] |= M_ATR_VAB;

// fith level (....)
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_VINCLUDED, bNewDoc, "IDD_VINCLUDED" ) )		pLevelMask [4] |= M_ATR_INC;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_SOURCEFILE, bNewDoc, "IDD_SOURCEFILE" ) )		pLevelMask [4] |= M_ATR_SFL;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_ACTIVE,    bNewDoc, "IDD_ACTIVE" ) )		pLevelMask [4] |= M_ATR_ACT;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_PAGEBREAKS,bNewDoc, "IDD_PAGEBREAKS" ) )		pLevelMask [4] |= M_ATR_PBREAKS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD2_PARAIDS, bNewDoc, "IDD2_PARAIDS" ) )  		pLevelMask [4] |= M_ATR_PARAIDS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CHDATE, bNewDoc, "IDD_CHDATE" ) )   		pLevelMask [4] |= M_ATR_CHDATE;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CONTENTS, bNewDoc, "IDD_CONTENTS" ) ) 		pLevelMask [4] |= M_ATR_CONTENTS;

// sixlevel (....)
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_NOTSURE, bNewDoc, "IDD_NOTSURE" ) )  		pLevelMask [5] |= M_ATR_NOTSURE;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_REFS,    bNewDoc, "IDD_REFS" ) )  		pLevelMask [5] |= M_ATR_REFS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_BLOBS,   bNewDoc, "IDD_BLOBS" ) )  		pLevelMask [5] |= M_ATR_BLOBS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_DIVISION,bNewDoc, "IDD_DIVISION" ) )  		pLevelMask [5] |= M_ATR_DIVIS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_PREANNODATE,bNewDoc, "IDD_PREANNODATE" ) ) 		pLevelMask [5] |= M_ATR_PREANNO;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_ANNODATE,bNewDoc, "IDD_ANNODATE" ) ) 		pLevelMask [5] |= M_ATR_ANNODATE;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_ANNOUSER,bNewDoc, "IDD_ANNOUSER" ) ) 		pLevelMask [5] |= M_ATR_ANNOU;

// seventhlevel (....)
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_ANNOORGANIZATION,bNewDoc, "IDD_ANNOORGANIZATION" ) ) pLevelMask [6] |= M_ATR_ANNOO;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_ANNOTAX,bNewDoc, "IDD_ANNOTAX" ) ) 			pLevelMask [6] |= M_ATR_ANNOT;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_ANNOINTEREST,bNewDoc, "IDD_ANNOINTEREST" ) ) 	pLevelMask [6] |= M_ATR_ANNOI;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_ANNOKIND,bNewDoc, "IDD_ANNOKIND" ) ) 		pLevelMask [6] |= M_ATR_ANNOK;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_PREANNOUSER,bNewDoc, "IDD_PREANNOUSER" ) ) 		pLevelMask [6] |= M_ATR_PREANNOU;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_PREANNOORGANIZATION,bNewDoc, "IDD_PREANNOORGANIZATION"))pLevelMask [6] |= M_ATR_PREANNOO;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_PREANNOTAX,bNewDoc, "IDD_PREANNOTAX" ) ) 		pLevelMask [6] |= M_ATR_PREANNOT;

	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_PREANNOINTEREST,bNewDoc, "IDD_PREANNOINTEREST" ) )	pLevelMask [7] |= M_ATR_PREANNOI;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_PREANNOKIND,bNewDoc, "IDD_PREANNOKIND" ) ) 		pLevelMask [7] |= M_ATR_PREANNOK;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CHANGE,bNewDoc, "IDD_CHANGE" ) ) 		    pLevelMask [7] |= M_ATR_CHANGE;
 	if ( TagAttrDiff ( lDocId, IDD_HANDMASK,bNewDoc, "IDD_HANDMASK" ) )			pLevelMask [7] |= M_ATR_HANDMASK;
 	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_SAMEDOCS,bNewDoc, "IDD_SAMEDOCS" ) )			pLevelMask [7] |= M_ATR_SAMEDOCS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_SERVICEINFO, bNewDoc, "IDD_SERVICEINFO" ) )		pLevelMask [7] |= M_ATR_SERVICEINFO;

	if ( TagAttrDiff ( lDocId, IDD_HANDHANDMASK,bNewDoc, "IDD_HANDHANDMASK" ) )		pLevelMask [8] |= M_ATR_HANDHANDMASK;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CLASS6,bNewDoc, "IDD_CLASS6" ) )			pLevelMask [8] |= M_ATR_CLASS6;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_INPHARMFIRM, bNewDoc, "IDD_INPHARMFIRM"))		pLevelMask [8] |= M_ATR_INPHARMFIRM;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_INPHARMCOUNTRY, bNewDoc, "IDD_INPHARMCOUNTRY"))		pLevelMask [8] |= M_ATR_INPHARMCOUNTRY;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_ANNULDATE, bNewDoc, "IDD_ANNULDATE"))			pLevelMask [8] |= M_ATR_ANNULDATE;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_TRADENAME, bNewDoc, "IDD_TRADENAME"))			pLevelMask [8] |= M_ATR_TRADENAME;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_INTNAME, bNewDoc, "IDD_INTNAME"))			pLevelMask [8] |= M_ATR_INTNAME;

	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_PHARMGROUP, bNewDoc, "IDD_PHARMGROUP"))			pLevelMask [9] |= M_ATR_PHARMGROUP;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_PHARMEFFECT, bNewDoc, "IDD_PHARMEFFECT"))		pLevelMask [9] |= M_ATR_PHARMEFFECT;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_CHAPTER, bNewDoc, "IDD_CHAPTER"))			pLevelMask [9] |= M_ATR_CHAPTER;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_ATC, bNewDoc, "IDD_ATC"))				pLevelMask [9] |= M_ATR_ATC;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_REGSTATUS, bNewDoc, "IDD_REGSTATUS"))			pLevelMask [9] |= M_ATR_REGSTATUS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_LEKFORM, bNewDoc, "IDD_LEKFORM"))			pLevelMask [9] |= M_ATR_LEKFORM;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_MKB, bNewDoc, "IDD_MKB"))				pLevelMask [9] |= M_ATR_MKB;

	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_REGDATE, bNewDoc, "IDD_REGDATE"))			pLevelMask [10] |= M_ATR_REGDATE;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_CASECODE, bNewDoc, "IDD_CASECODE"))			pLevelMask [10] |= M_ATR_CASECODE;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_LIFE, bNewDoc, "IDD_LIFE"))				pLevelMask [10] |= M_ATR_LIFE;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_UNRECIPE, bNewDoc, "IDD_UNRECIPE"))			pLevelMask [10] |= M_ATR_UNRECIPE;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_ALLOWED, bNewDoc, "IDD_ALLOWED"))			pLevelMask [10] |= M_ATR_ALLOWED;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_NOTALLOWED, bNewDoc, "IDD_NOTALLOWED"))			pLevelMask [10] |= M_ATR_NOTALLOWED;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_RECIPE, bNewDoc, "IDD_RECIPE"))				pLevelMask [10] |= M_ATR_RECIPE;

	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_NOTLIFE, bNewDoc, "IDD_NOTLIFE"))			pLevelMask [11] |= M_ATR_NOTLIFE;
	if ( TagAttrDiff (lDocId, IDD_SUBS, bNewDoc, "IDD_SUBS"))            		pLevelMask [11] |= M_ATR_SUB;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_EVD,     bNewDoc, "IDD_EVD"))            		pLevelMask [11] |= M_ATR_EVD;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_ACTIVEEX,bNewDoc, "IDD_ACTIVEEX"))			pLevelMask [11] |= M_ATR_ACTIVEEX;
	if (!b_gctx_attrs_only) if ( TagAttrDiff (lDocId, IDD_PARAGCTXLENS,bNewDoc, "IDD_PARAGCTXLENS"))	pLevelMask [11] |= M_ATR_PARAGCTX;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CALIN, bNewDoc, "IDD_CALIN" ) )		pLevelMask [11] |= M_ATR_CALIN;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CALAB, bNewDoc, "IDD_CALAB" ) )		pLevelMask [11] |= M_ATR_CALAB;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CALCH, bNewDoc, "IDD_CALCH" ) )		pLevelMask [12] |= M_ATR_CALCH;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_DOCSTRUCT, bNewDoc, "IDD_DOCSTRUCT" ) )		pLevelMask [12] |= M_ATR_DOCSTRUCT;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_INVISIBLELENS,bNewDoc, "IDD_INVISIBLELENS"))	pLevelMask [12] |= M_ATR_INVISIBLELENS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_INVISIBLERELES,bNewDoc, "IDD_INVISIBLERELES"))	pLevelMask [12] |= M_ATR_INVISIBLERELES;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_KIND, bNewDoc, "IDD_KIND"))	pLevelMask [12] |= M_ATR_KIND;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_COMPARECONTENTS, bNewDoc, "IDD_COMPARECONTENTS" ) ) 		pLevelMask [12] |= M_ATR_COMPARECONTENTS;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CHDATE_EX, bNewDoc, "IDD_CHDATE_EX" ) )   		pLevelMask [12] |= M_ATR_CHDATE_EX;

	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_ADDCODE, bNewDoc, "IDD_ADDCODE" ) )                  pLevelMask [13] |= M_ATR_ADDCODE;
	if (!b_gctx_attrs_only) if ( TagAttrDiff ( lDocId, IDD_CHDATE_EXEX, bNewDoc, "IDD_CHDATE_EXEX" ) )                  pLevelMask [13] |= M_ATR_CHDATE_EXEX;
	if ( TagAttrDiff ( lDocId, IDD_MARKEDTEXT, bNewDoc, "IDD_MARKEDTEXT" ) )                  pLevelMask [13] |= M_ATR_MARKEDTEXT;
	if ( TagAttrDiff ( lDocId, IDD_SAMES, bNewDoc, "IDD_SAMES" ) )                  pLevelMask [13] |= M_ATR_SAMES;
	if ( TagAttrDiff ( lDocId, IDD_TAG, bNewDoc, "IDD_TAG" ) )                pLevelMask [13] |= M_ATR_TAG;
	if ( TagAttrDiff ( lDocId, IDD_PROFDATE, bNewDoc, "IDD_PROFDATE" ) )                pLevelMask [13] |= M_ATR_PROFDATE;

	} //if (!b_texts_only)

	// set mask NLE bits
	for ( int i = MAX_LEVEL - 1; i > 0; i -- ) {
		if ( pLevelMask [i] ) {
			if ( iLevelCount == 1 )
				iLevelCount = i + 1;
			pLevelMask [i - 1] |= M_ATR_NLE;
		}
	}

	if (b_extended_log) {
		logger.printf (lt_deltaInfo, "\nlevels: %ld, ", iLevelCount);
		if (b_flush_log) logger.flush (lt_always);
	}

	return iLevelCount;
}

void	diff_aux (const char *key, Index* old_aux, Index* new_aux, FILE *m_DFile1)
{
	u_int64_t ftpSize, fptCurrent;
	bool b_sections = !strcmp (key, AUX_INDEXES_SYNS);
	std::string dummy_section ("dummy");

	std::map<std::string, std::vector<std::string> > old_values, new_values;

	unsigned short suVarId = DVAR_GLMAPP;
	fwrite (&suVarId, sizeof (unsigned short), 1, m_DFile1);

	long len = strlen (key);
	ftpSize = _ftelli64 (m_DFile1);
	fwrite (&len, sizeof (long), 1, m_DFile1);
	fwrite (&len, sizeof (long), 1, m_DFile1);
	fwrite (key, len, 1, m_DFile1);
	len += sizeof (long);

	Stream *str = old_aux->Open (key);
	if (str) {
		long length = str->Length ();
		char *data = new char [length], *ptr = data;
		str->Read (data, length);
		old_aux->Close (str);
		std::vector<std::string> *values;
		if (!b_sections) {
			old_values.insert (std::map<std::string, std::vector<std::string> >::value_type (dummy_section, std::vector<std::string> ()));
			values = &old_values.find (dummy_section)->second;
		}
		while (ptr - data < length) {
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
	}
	str = new_aux->Open (key);
	if (str) {
		long length = str->Length ();
		char *data = new char [length], *ptr = data;
		str->Read (data, length);
		new_aux->Close (str);
		std::vector<std::string> *values;
		if (!b_sections) {
			new_values.insert (std::map<std::string, std::vector<std::string> >::value_type (dummy_section, std::vector<std::string> ()));
			values = &new_values.find (dummy_section)->second;
		}
		while (ptr - data < length) {
			if (*ptr == '[' && b_sections) {
				new_values.insert (std::map<std::string, std::vector<std::string> >::value_type (ptr, std::vector<std::string> ()));
				values = &new_values.find (ptr)->second;
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
	}

	std::map<std::string,std::vector<std::string> >::iterator map_it;
	if (b_sections) {
		//сначала удаленные секции
		std::vector<std::string> delete_sections;
		for (map_it = old_values.begin (); map_it != old_values.end (); map_it++)
			if (new_values.find (map_it->first) == new_values.end ())
				delete_sections.push_back (map_it->first);
		long sections_count = delete_sections.size ();
		fwrite (&sections_count, sizeof (sections_count),1, m_DFile1); len += sizeof (sections_count);
		for (std::vector<std::string>::const_iterator str_it = delete_sections.begin (); str_it != delete_sections.end (); str_it++) {
			long str_size = str_it->size ();
			fwrite (&str_size, sizeof (str_size), 1, m_DFile1); len += sizeof (str_size);
			fwrite (str_it->c_str (), str_size, 1, m_DFile1); len += str_size;
		}

		//потом новые секции
		std::map<std::string, std::vector<std::string> > new_sections;
		for (map_it = new_values.begin (); map_it != new_values.end (); map_it++)
			if (old_values.find (map_it->first) == old_values.end ())
				new_sections.insert (*map_it);
		sections_count = new_sections.size ();
		fwrite (&sections_count, sizeof (sections_count),1, m_DFile1); len += sizeof (sections_count);
		for (map_it = new_sections.begin (); map_it != new_sections.end (); map_it++) {
			long str_size = map_it->first.size ();
			fwrite (&str_size, sizeof (str_size), 1, m_DFile1); len += sizeof (str_size);
			fwrite (map_it->first.c_str (), str_size, 1, m_DFile1); len += str_size;
			long count = map_it->second.size ();
			fwrite (&count, sizeof (count), 1, m_DFile1); len += sizeof (count);
			for (std::vector<std::string>::const_iterator str_it = map_it->second.begin (); str_it != map_it->second.end (); str_it++) {
				str_size = str_it->size ();
				fwrite (&str_size, sizeof (str_size), 1, m_DFile1); len += sizeof (str_size);
				fwrite (str_it->c_str (), str_size, 1, m_DFile1); len += str_size;
			}
		}
	}

	//потом изменения в секциях
	for (map_it = old_values.begin (); map_it != old_values.end (); map_it++) {
		std::map<std::string,std::vector<std::string> >::iterator newmap_it = new_values.find (map_it->first);
		if (newmap_it != new_values.end ()) {
			if (b_sections) {
				long str_size = map_it->first.size ();
				fwrite (&str_size, sizeof (str_size), 1, m_DFile1); len += sizeof (str_size);
				fwrite (map_it->first.c_str (), str_size, 1, m_DFile1); len += str_size;
			}

			std::set<std::string> old_set, new_set, to_delete_set, to_insert_set;
			old_set.insert (map_it->second.begin (), map_it->second.end ());
			new_set.insert (newmap_it->second.begin (), newmap_it->second.end ());
			std::vector<std::string> to_delete, to_insert;
			std::set_difference (old_set.begin (), old_set.end (), new_set.begin (), new_set.end (), std::back_inserter (to_delete));
			std::set_difference (new_set.begin (), new_set.end (), old_set.begin (), old_set.end (), std::back_inserter (to_insert));
			to_delete_set.insert (to_delete.begin (), to_delete.end ());
			to_insert_set.insert (to_insert.begin (), to_insert.end ());

			std::vector<std::string>::const_iterator old_it, new_it;
			std::vector<long> del_positions, add_positions;
			long del_pos = 0, add_pos = 0, del_count = to_delete.size (), add_count = to_insert.size ();
			for (old_it = map_it->second.begin (); old_it != map_it->second.end (); old_it++, del_pos++)
				if (to_delete_set.find (*old_it) != to_delete_set.end ())
					del_positions.push_back (del_pos);

			//теперь из старых надо удалить те, которые удаляются
			for (std::vector<long>::reverse_iterator rit = del_positions.rbegin (); rit != del_positions.rend (); rit++)
				map_it->second.erase (map_it->second.begin () + *rit);

			//теперь надо найти те, которые добавляются			
			std::vector<std::string> add_strings;
			if (to_insert.size ()) {
				for (new_it = newmap_it->second.begin (); new_it != newmap_it->second.end (); new_it++, add_pos++)
					if (to_insert_set.find (*new_it) != to_insert_set.end ()) {
						add_positions.push_back (add_pos);
						add_strings.push_back (*new_it);
					}
			}

			fwrite (&del_count, sizeof (del_count), 1, m_DFile1); len += sizeof (del_count);
			fwrite (&add_count, sizeof (add_count), 1, m_DFile1); len += sizeof (add_count);
			
			std::vector<long>::const_iterator pit;
			for (pit = del_positions.begin (); pit != del_positions.end (); pit++) {
				long at_pit = *pit;
				fwrite (&at_pit, sizeof (long), 1, m_DFile1); len += sizeof (at_pit);
			}
			for (pit = add_positions.begin (); pit != add_positions.end (); pit++) {
				long at_pit = *pit;
				fwrite (&at_pit, sizeof (long), 1, m_DFile1); len += sizeof (at_pit);
			}
			for (new_it = add_strings.begin (); new_it != add_strings.end (); new_it++) {
				long str_size = new_it->size ();
				fwrite (&str_size, sizeof (str_size), 1, m_DFile1); len += sizeof (str_size);
				fwrite (new_it->c_str (), str_size, 1, m_DFile1); len += str_size;
			}
		}
	}

	fptCurrent = _ftelli64 (m_DFile1);
	_fseeki64 (m_DFile1, ftpSize, ACE_OS_SEEK_SET);
	fwrite (&len, sizeof (len), 1, m_DFile1);
	_fseeki64 (m_DFile1, fptCurrent, ACE_OS_SEEK_SET);
}

int	Full::PreWork()
{
	//
	// Записываем версию формата дельты в дельту
	//
	fwrite (&DELTA_DATA_VERSION, sizeof (short), 1, m_DFile1);
	
	//
	// Записываем проверочные байты в дельту
	//
	{
		long	crc     = 0;
		short	isCrypt = 0;

		fwrite( &crc,     sizeof     (crc), 1, m_DFile1 );
		fwrite( &isCrypt, sizeof (isCrypt), 1, m_DFile1 );
	}	
	
	//
	// Количество сегментов для обработки
	//
	short	len = (short) m_ids.length();

	//
	// Записываем в дельту количество сегментов
	//
	fwrite( &len, sizeof ( len ), 1, m_DFile1 );

	//
	// Далее записываем в дельту все номера сегментов
	//
	Point p;
	for ( p = m_ids.first(); p; m_ids.next(p) )
		fwrite ( m_ids[p], sizeof (short), 1, m_DFile1 );

	//
	// Имя DiffHoldera, используется для хранения дельт (кэш)
	//
	char	pHolderName [1024];

	//
	// Генерируем имя DiffHoldera
	//
	CreateHolderName (pHolderName, m_ids(m_ids.first()));
	strcat (strcpy (etaHolderName, argDltPath), pHolderName);
	strcpy (HolderName, etaHolderName);
	if (b_prepack && !b_single_cache) {
		char suffix [16];
		sprintf (suffix, "_thr%ld", m_thread);
		strcat (HolderName, suffix);
	}
	
	int	created = 0;

	//
	// Создаем DiffHolder
	//
	if ((m_thread == 0 || !b_single_cache) && !m_pDiffHolder [m_thread])
		m_pDiffHolder [m_thread] = new DiffHolder (HolderName, b_cache_ro ? 0 : 1, created);
	
	//
	// Если файл с разницей уже существует то используем его
	//   иначе создаем новый
	//
	if ( !created ) {
		logger.printf ( lt_warning, "Use DiffHolder file \"%s\"\n", pHolderName );
		removeCache = 0;
	} else {
		logger.printf ( lt_info, "Create DiffHolder file \"%s\"\n", pHolderName );
		
		if (0 == m_thread) {
			if ((m_deldocs || m_delblobs) && !b_sbrf && !b_daily && !b_gctx_attrs_only) {
				logger.printf( lt_info, "Checking HIndices structure in new-part base...\n" );
				if ( !checkIndex(m_pOldBase->FindIndex("Class"),       m_pNewBase->FindIndex("Class")) )
					return 1;
				logger.printf( lt_info, "\tClass is ok\n" );
				if ( !checkIndex(m_pOldBase->FindIndex("DocKind"),     m_pNewBase->FindIndex("DocKind")) )
					return 1;
				logger.printf( lt_info, "\tDocKind is ok\n" );
				if ( !checkIndex(m_pOldBase->FindIndex("Territory"),   m_pNewBase->FindIndex("Territory")) )
					return 1;
				logger.printf( lt_info, "\tTerritory is ok\n" );
				if ( !checkIndex(m_pOldBase->FindIndex("Adopted"),     m_pNewBase->FindIndex("Adopted")) )
					return 1;
				logger.printf( lt_info, "\tAdopted is ok\n" );
				if ( !checkIndex(m_pOldBase->FindIndex("PublishedIn"), m_pNewBase->FindIndex("PublishedIn")) )
					return 1;
				logger.printf( lt_info, "\tPublishedIn is ok\n" );
			}
		}
	}

	//
	// 'Aux' индексы для старой и новой баз
	//
	Index	*pNewAuxInd = m_pNewBase -> FindIndex ( "Aux" );
	Index	*pOldAuxInd = m_pOldBase -> FindIndex ( "Aux" );

	//
	// Имя индекса версии базы
	//
	char	pClassKey[] = "Clas";
	//
	// Переменные для хранения версий баз
	//
	long	lOldClassId;
	long	lNewClassId;

	//
	// Читаем версию новой базы
	//
	Stream	*pStr = pNewAuxInd -> Open ( pClassKey );
	assert( pStr && pStr->Length() == sizeof(long) );
	pStr->Read( &lNewClassId, sizeof(lNewClassId) );
	pNewAuxInd->Close(pStr);

	//
	// Читаем версию старой базы
	//
	pStr = pOldAuxInd -> Open ( pClassKey );
	assert ( pStr && pStr->Length() == sizeof(long) );
	pStr -> Read( &lOldClassId, sizeof(lOldClassId) );
	pOldAuxInd->Close(pStr);
	
	//
	// Записываем в дельту версию новой базы
	//
	fwrite( &lNewClassId, sizeof ( lNewClassId ), 1, m_DFile1);
		
	//
	// Записываем в дельту ревизию старой базы, беря ее из первого сегмента
	//   предпологаем что ревизии всех сегментов равны
	//
	m_pOldBase -> FindBaseInfo ( m_ids(m_ids.first()), aBaseInfo );
	fwrite ( &aBaseInfo.LastUpdate, sizeof ( revision ), 1, m_DFile1 );
	//
	// Записываем в дельту ревизию новой базы, беря ее из первого сегмента
	//
	m_pNewBase -> FindBaseInfo ( m_ids(m_ids.first()), aBaseInfo );
	fwrite ( &aBaseInfo.LastUpdate, sizeof ( revision ), 1, m_DFile1 );
	
	//
	// Запоминаем позицию в файле дельты, чтобы потом сюда записать количество документов
	//
	m_DocCntFilePos = _ftelli64 (m_DFile1);
	
	//
	// Сейчас в дельту надо записать количество документов, но мы его пока не знаем
	//   поэтому пока пишем ноль
	//
	fwrite ( &g_clZerro, sizeof ( long ), 1, m_DFile1 );
	fpSizeDummyPos = _ftelli64 (m_DFile1);

	//
	// Размер дельты
	//
	long	ulDeltaSize = 0;
	//
	// Записываем в дельты пока нулевой размер дельты, позже мы его выясним
	//
	fwrite( &ulDeltaSize, sizeof ( ulDeltaSize ), 1, m_DFile1 );

	//
	// Этот массив используется для определения разницы сегментов в базах
	//
	char	*pSegMask = (char*) malloc ( sizeof (char) * m_ids.length() );
	int	si;

	//
	// Цикл по всем сегментам и сравнение их в обеих базах
	//
	for ( p = m_ids.first(), si = 0; p; m_ids.next(p), si++ ) {
		pSegMask[si] = 0;
		
		BaseInfo aOldBaseInfo;
		BaseInfo aNewBaseInfo;
		m_pOldBase -> FindBaseInfo ( m_ids(p), aOldBaseInfo );
		m_pNewBase -> FindBaseInfo ( m_ids(p), aNewBaseInfo );

		//
		// Сравниваем сегменты
		//
		if (!b_sbrf && !b_daily && !b_gctx_attrs_only) {
			if( bicmp ( aOldBaseInfo, aNewBaseInfo ) )
				pSegMask[si] = 1;
		}
	}

	//
	// Записываем массив разниц сегментов в дельту
	//
	fwrite ( pSegMask, sizeof (char), m_ids.length(), m_DFile1 );
	
	//
	// Цинкл по всем сегментам и запись их дельту в виде структуры BaseInfo
	//
	for ( p = m_ids.first(), si = 0; p; m_ids.next(p), si ++ ) {
		if ( pSegMask[si] == 1 ) {
			BaseInfo aNewBaseInfo;
			m_pNewBase -> FindBaseInfo ( m_ids(p), aNewBaseInfo );

			fwrite ( aNewBaseInfo.Name,       BASE_NAME_SIZE, 1, m_DFile1 );
			fwrite ( aNewBaseInfo.NameEng,    BASE_NAME_SIZE, 1, m_DFile1 );
			fwrite ( aNewBaseInfo.AuthorName, NAME_SIZE, 1, m_DFile1 );
			fwrite ( &aNewBaseInfo.Weight,        sizeof (aNewBaseInfo.Weight),        1, m_DFile1 );
			fwrite ( &aNewBaseInfo.SplashTopic,   sizeof (aNewBaseInfo.SplashTopic),   1, m_DFile1 );
			fwrite ( &aNewBaseInfo.BannerTopic,   sizeof (aNewBaseInfo.BannerTopic),   1, m_DFile1 );
		}
	}

	free ( pSegMask );

	//
	// Дальше дельта пишеться в следующем формате:
	//
	//	Количество объектов (short)
	//	Объект 0
	//	{
	//		ID данных (short)
	//		Размер данных (long)
	//		Сами данные (*)
	//	}
	//	...
	//

	unsigned short	suVarCount = 0;	// Количество объектов
	unsigned short	suVarId    = 0;	// ID объекта
	long		lVarSize   = 0;	// Размер объекта
	u_int64_t	fpVarCntFilePos; // позиция в файле дельты где пишеться количество объектов

	fpVarCntFilePos = _ftelli64 (m_DFile1);
	fwrite( &suVarCount, sizeof ( suVarCount ), 1, m_DFile1 );	

	//
	// Здесь мы записываем все разные ключи из индекса 'Aux'
	//
	if (0 == m_thread) {
		std::set<std::string> segment_indexes;
		std::vector<std::string> to_diff;
		to_diff.push_back (PR_ALL);
		to_diff.push_back (PR_DOCS);
		to_diff.push_back (PR_COMMENTS);
		to_diff.push_back (PR_FORMS);
		to_diff.push_back (PR_ACCOUNTING_TRANSACTION);
		to_diff.push_back (PR_PROJECTS);
		to_diff.push_back (PR_PRACTICE);
		to_diff.push_back (PR_INTERS);
		to_diff.push_back (PR_QUES);
		to_diff.push_back (PR_BREF);
		to_diff.push_back (AUX_SEGMENT_INDEXES);
		to_diff.push_back (AUX_INDEXES_SYNS);
		to_diff.push_back (AUX_CORR_WEIGHT);
		to_diff.push_back (AUX_CORR_PAIR_WEIGHT);
		to_diff.push_back (AUX_CORR_PAIR_DOC_WEIGHT);
		to_diff.push_back (AUX_CORR_PAIR_SUB_WEIGHT);
		to_diff.push_back (AUX_LARGE_DOCS);
		to_diff.push_back (AUX_NAME_SEARCH);
		to_diff.push_back (AUX_MAIN_PAGES);
		if (!b_daily && !b_sbrf) {
			to_diff.push_back (AUX_BELONGS_DECISIONSARCHIVE);
			to_diff.push_back (AUX_KIND_CORRESPONDENTS);
			to_diff.push_back (AUX_SERV);
			to_diff.push_back (AUX_SYN_DATES);
			to_diff.push_back (AUX_SYN_EXAMPLE);
			to_diff.push_back (AUX_SYN_CODEXES);
			to_diff.push_back (AUX_SYN_TYPE);
			to_diff.push_back (AUX_SYN_TYPES);
			to_diff.push_back (AUX_SYN_ADOPTED);
			to_diff.push_back (AUX_BELONGS);
			to_diff.push_back (AUX_RELE_PLUS);
			to_diff.push_back (AUX_IGNORE_BELONGS);
			to_diff.push_back (AUX_IGNORE_K3_BELONGS);
			to_diff.push_back (AUX_IGNORE_GL_BELONGS);
			to_diff.push_back (AUX_EXCLUDE_WORDS);
			to_diff.push_back (AUX_EXCLUDE_WORDS_3);
			to_diff.push_back (AUX_EXCLUDE_WORDS_8);
			to_diff.push_back (AUX_EXCLUDE_RF);
			to_diff.push_back (AUX_ANNO_UIDS);
			to_diff.push_back (AUX_KIND_UIDS);
			to_diff.push_back (AUX_KIND_BASESEARCH);
			to_diff.push_back (AUX_SHORTLISTSIZE);
			to_diff.push_back (AUX_CONTEXT_EVARIANTS);
			to_diff.push_back (AUX_CONTEXT_MVARIANTS);
			to_diff.push_back (AUX_BASENAMES);
			to_diff.push_back (AUX_fAdo);
			to_diff.push_back (AUX_fCla);
			to_diff.push_back (AUX_fPre);
			to_diff.push_back (AUX_fKnd);
			to_diff.push_back (AUX_fPub);
			to_diff.push_back (AUX_fPJU);
			to_diff.push_back (AUX_fPHR);
			to_diff.push_back (AUX_fPBO);
			to_diff.push_back (AUX_fPPH);
			to_diff.push_back (AUX_fILF);
			to_diff.push_back (AUX_RELE_IZM);
			to_diff.push_back (AUX_RELE_PLUS8);
			to_diff.push_back (AUX_RELE_PLUS4);
			to_diff.push_back (AUX_RELE_Y);
			to_diff.push_back (AUX_PartsSpeechAnalyzer);
			to_diff.push_back (AUX_KIND_BITS);
			to_diff.push_back (AUX_KIND_GCTX);
			to_diff.push_back (AUX_KIND_BLOCK);
			to_diff.push_back (AUX_TIME_ONLINECHECKING);
			to_diff.push_back (AUX_KIND_ANALYSEMASK);
			to_diff.push_back (AUX_RELEVANCY_CHANGES);
			to_diff.push_back (AUX_fCor);
			to_diff.push_back (AUX_GC);
			to_diff.push_back (AUX_INFORMERS);
			to_diff.push_back (AUX_INFORMERS_EX);
			to_diff.push_back (AUX_SYNS);
			to_diff.push_back (AUX_HARD);
			to_diff.push_back ("TMWM");
			to_diff.push_back (AUX_FILTER_JSONS);
			to_diff.push_back (AUX_LIST_KINDS);
			to_diff.push_back (AUX_IMPORTANT_ANNOS);
			to_diff.push_back (AUX_IMPORTANT_ANNOS_1);
			to_diff.push_back (AUX_IMPORTANT_ANNOS_2);
			to_diff.push_back (AUX_BELONGS_ENCYCLOPEDIA);
			to_diff.push_back (AUX_SYN_MORPHO_PATTERN);
			to_diff.push_back (AUX_PERC);
			to_diff.push_back (AUX_PHRASAL_NORMALIZER);
			/*
			if ((m_ids.length () == 1) && (m_ids.contents (m_ids.first ()) == DEMO_SEGMENT)) {
				to_diff.push_back ("%%%0");
				to_diff.push_back ("%%%1");
				to_diff.push_back ("%%%2");
				to_diff.push_back ("%%%3");
				to_diff.push_back ("%%%4");
				to_diff.push_back ("%%%5");
				to_diff.push_back ("%%%6");
				to_diff.push_back ("%%%7");
				to_diff.push_back ("%%%8");
				to_diff.push_back ("%%%9");
			}
			*/
		}

		//
		// Цикл по ключам
		//
		for (std::vector<std::string>::const_iterator key_it = to_diff.begin (); key_it != to_diff.end (); key_it++) {
			std::string key = *key_it;
			if (!strcmp (key.c_str (), AUX_INDEXES_SYNS) || segment_indexes.find (key.c_str ()) != segment_indexes.end ()) {
				suVarCount++;
				diff_aux (key.c_str (), pOldAuxInd, pNewAuxInd, m_DFile1);
				continue;
			}

			Stream	*str;
			char	*oldData = 0, *newData = 0;
			long	oldLen = 0, newLen = 0;
			
			//
			// Открываем и считываем ключ из старой базы
			//
			
			str = pOldAuxInd->Open(key.c_str());
			if( str ) {
				oldLen  = str->Length();
				oldData = (char*) malloc (oldLen);				
				str->Read(oldData, oldLen);			
				pOldAuxInd->Close(str);			
			}

			//
			// Открываем и считываем ключ из новой базы
			//
			str = pNewAuxInd->Open (key.c_str());
			if( str ) {
				newLen = str->Length();
				newData = (char*) malloc (newLen);
				str->Read(newData, newLen);			
				pNewAuxInd->Close(str);

				if (!strcmp (key.c_str (), AUX_SEGMENT_INDEXES)) {
					bool virt_index = false;
					char *ptr = newData;
					while (ptr - newData < newLen) {
						if (virt_index) {
							to_diff.push_back (ptr);
							segment_indexes.insert (ptr);
						}
						ptr += strlen (ptr) + 1;
						virt_index = !virt_index;
					}
				}
			}

			//
			// Сравниваем ключи баз
			//
			int saveData = 1;
			if ( newLen == oldLen ) {
				if ( !newLen ) {
					if (!strcmp (key.c_str(), AUX_SHORTLISTSIZE))
						saveData = 1;
					else
						saveData = 0;
				}
				else
					saveData = memcmp ( oldData, newData, newLen );
			}
			if (!strcmp (key.c_str(), AUX_SEGMENT_INDEXES))
				saveData = 1;


			//
			// Если ключи разные то в дельту записываем данные из ключа новой базы
			//
			if ( saveData ) {
				suVarCount ++;
				suVarId = DVAR_GLMAPP;
				long len = key.size();

				lVarSize = len + newLen + sizeof(len);

				fwrite ( &suVarId, sizeof ( unsigned short ), 1, m_DFile1 );
				fwrite ( &lVarSize, sizeof ( long ), 1, m_DFile1 );

				fwrite ( &len, 1, sizeof(len), m_DFile1 );
				fwrite ( key.c_str (), len, 1, m_DFile1 );
				fwrite ( newData, newLen, 1, m_DFile1 );		
			}

			if( oldData )
				free ( oldData );
			if( newData )
				free ( newData );
		}
	}

	//
	// Теперь мы знаем количество объектов, записываем его в запомненную позицию
	//
	u_int64_t fpCurrentFilePos = _ftelli64 (m_DFile1);
	_fseeki64 (m_DFile1, fpVarCntFilePos, ACE_OS_SEEK_SET);
	fwrite ( &suVarCount, sizeof ( suVarCount ), 1, m_DFile1 );
	_fseeki64 (m_DFile1, fpCurrentFilePos, ACE_OS_SEEK_SET);

	if (0 == m_thread) {
		//key6
		//std::map<long,std::string> old_map_id_str, new_map_id_str;
		long del_count = 0, add_count = 0;
		std::vector<long> to_delete_keys, to_add_keys;
		std::vector<std::string> to_add_strkeys;
		if (!b_sbrf) {
			std::map<long,std::string>::const_iterator it;
			for (it = old_map_id_str.begin (); it != old_map_id_str.end (); it++) {
				long id = it->first;
				if (new_map_id_str.find (id) == new_map_id_str.end ())
					to_delete_keys.push_back (id);
			}

			for (it = new_map_id_str.begin (); it != new_map_id_str.end (); it++) {
				long id = it->first;
				if (old_map_id_str.find (id) == old_map_id_str.end ()) {
					to_add_keys.push_back (id);
					to_add_strkeys.push_back (it->second);
				}
			}
			del_count = to_delete_keys.size ();
			add_count = to_add_keys.size ();
		}

		fwrite (&del_count, sizeof (del_count), 1, m_DFile1);
		std::vector<long>::const_iterator long_it;
		std::vector<std::string>::const_iterator str_it;
		for (long_it = to_delete_keys.begin (); long_it != to_delete_keys.end (); long_it++) {
			long to_delete = *long_it;
			fwrite (&to_delete, sizeof (to_delete), 1, m_DFile1);
		}

		fwrite (&add_count, sizeof (add_count), 1, m_DFile1);
		for (long_it = to_add_keys.begin (), str_it = to_add_strkeys.begin (); long_it != to_add_keys.end (); long_it++, str_it++) {
			long to_add = *long_it, str_len = str_it->size () + 1;
			fwrite (&to_add, sizeof (to_add), 1, m_DFile1);
			fwrite (&str_len, sizeof (str_len), 1, m_DFile1);
			fwrite (str_it->c_str (), str_len, 1, m_DFile1);
		}
	}

	//
	// Кончился блок для записи разницы индексов 'Aux'
	//
	return 0;
}

void	Full::WorkDoc( long id, int docorder )
{
	m_lDocId = id;
	if ( checkOnlyDoc && checkOnlyDoc != m_lDocId )
		return ;

	u_int64_t	fptDeltaStartPos, fptDeltaEndPos;
	unsigned	long	ulDeltaSize = 0;
	char	log_str [256], add_str [256];

	//
    // Проверка ревизий(DocInfo.Revision) документов
    //
	if (docorder == -1)
		docorder = GetDocOrder ( m_lDocId );
		switch (docorder) {
		case O_DOC_CHG :
			{
			long c_id = m_lDocId;
			if (c_id > ID_ANNOPLUS) c_id -= ID_ANNOPLUS;
			if (b_sbrf && (c_id < SBRF_LOW_ID || c_id > SBRF_HI_ID)) {
				logger.printf ( lt_fatal, "Doc %ld - не входит в диапазон документов СберБанка\n", m_lDocId );
				exit (1);
			}

			if ( ( m_NewDocInfo.Status & DS_EVD ) != ( m_OldDocInfo.Status & DS_EVD )) {
				logger.printf ( lt_fatal, "Doc %ld - разные форматы документов (EVD/неEVD)\n", m_lDocId );
				exit( 1 );					
			}

			if (for_all_segs)
				sprintf (log_str, "Doc %ld (%ld) - chg ", m_lDocId, seg);
			else
				sprintf (log_str, "Doc %ld - chg ", m_lDocId );

			g_lDocInDelta++;

			fwrite ( &m_lDocId, sizeof ( long ), 1, m_DFile1 );
			fptDeltaStartPos = _ftelli64 (m_DFile1);
			fwrite ( &ulDeltaSize, sizeof ( ulDeltaSize ), 1, m_DFile1 );

			bool b_was_packed = DeltaChgDoc ();

			fptDeltaEndPos = _ftelli64 (m_DFile1);
			ulDeltaSize = (unsigned long)((fptDeltaEndPos - fptDeltaStartPos) & 0xFFFFFFFF);
			g_lChgDocSize += ulDeltaSize;
			_fseeki64 (m_DFile1, fptDeltaStartPos, ACE_OS_SEEK_SET);
			if (b_was_packed) ulDeltaSize = -ulDeltaSize;
			fwrite ( &ulDeltaSize, sizeof ( ulDeltaSize ), 1, m_DFile1 );
			if (b_was_packed) ulDeltaSize = -ulDeltaSize;
			_fseeki64 ( m_DFile1, fptDeltaEndPos, ACE_OS_SEEK_SET);

			if (b_prepack || b_texts_only)
				_fseeki64 (m_DFile1, fptDeltaStartPos, ACE_OS_SEEK_SET); //чтобы дельта не пухла, а она все равно промежуточная, никому не нужная
			
			sprintf (add_str, "(%lu bytes)", ulDeltaSize );
			strcat (log_str, add_str);
			logger.printf (lt_deltaInfo, "%s\n", log_str);
			if (b_flush_log) logger.flush (lt_always);
			}
			break;

		case O_DOC_EQU :			
			if ( for_all_segs )
				logger.printf ( lt_deltaInfo, "Doc %ld (%ld) - equ\n", m_lDocId, seg );
			else
				logger.printf ( lt_deltaInfo, "Doc %ld - equ\n", m_lDocId );
			break;

		case O_DOC_NEW :
			{
			long c_id = m_lDocId;
			if (c_id > ID_ANNOPLUS) c_id -= ID_ANNOPLUS;
			if (b_sbrf && (c_id < SBRF_LOW_ID || c_id > SBRF_HI_ID)) {
				logger.printf ( lt_fatal, "Doc %ld - не входит в диапазон документов СберБанка\n", m_lDocId );
				exit (1);
			}

			int bskipDoc = ( m_lDocId >= BIG_INFO_DOC && m_lDocId < BIG_INFO_DOC + BIG_INFO_COUNT ) || m_lDocId == ID_WWWDOC || (splash_topics.find (m_lDocId) != splash_topics.end ()) || (banner_topics.find (m_lDocId) != banner_topics.end ());
			if ( !bskipDoc && !(m_NewDocInfo.Status & DS_EVD)) {
				logger.printf ( lt_fatal, "Doc %ld - не в формате EVD\n", m_lDocId );
				exit( 1 );
			}

			if ( for_all_segs )
				sprintf (log_str, "Doc %ld (%ld) - new ", m_lDocId, seg);
			else
				sprintf (log_str, "Doc %ld - new ", m_lDocId );

			g_lDocInDelta ++;
			fwrite ( &m_lDocId, sizeof ( long ), 1, m_DFile1 );   // DOC ID

			fptDeltaStartPos = _ftelli64 (m_DFile1);
			fwrite ( &ulDeltaSize, sizeof ( ulDeltaSize ), 1, m_DFile1 );// DELTA SIZE

			bool b_was_packed = DeltaNewDoc ();

			fptDeltaEndPos = _ftelli64 (m_DFile1);
			ulDeltaSize = (unsigned long)((fptDeltaEndPos - fptDeltaStartPos) & 0xFFFFFFFF);
			g_lNewDocSize += ulDeltaSize;
			_fseeki64 (m_DFile1, fptDeltaStartPos, ACE_OS_SEEK_SET);
			if (b_was_packed) ulDeltaSize = -ulDeltaSize;
			fwrite ( &ulDeltaSize, sizeof ( ulDeltaSize ), 1, m_DFile1 );// DELTA SIZE
			if (b_was_packed) ulDeltaSize = -ulDeltaSize;
			_fseeki64 (m_DFile1, fptDeltaEndPos, ACE_OS_SEEK_SET);

			sprintf (add_str, "(%lu bytes)", ulDeltaSize);
			strcat (log_str, add_str);
			logger.printf (lt_deltaInfo, "%s\n", log_str);
			if (b_flush_log) logger.flush (lt_always);

			if (b_prepack || b_texts_only)
				_fseeki64 (m_DFile1, fptDeltaStartPos, ACE_OS_SEEK_SET); //чтобы дельта не пухла, а она все равно промежуточная, никому не нужная

			}
			break;

		default :
			logger.printf ( lt_fatal, "Unknown Doc's order (doc %ld)\n", m_lDocId );
			_EXIT (EXIT_FAILURE);
	}
}

int	Full::DiffSearchCache (Base* old_base, Base* new_base, long thread_id)
{
	//заголовок: количество сегментов, если 0 - то больше ничего
	//сегмент
	//количество байт изменений для этого сегмента
	//количество удаленных
	//количество новых
	//количество измененных

	//для удаленных: длина строки (char)|строка ... длина строки|строка
	//для новых: длина строки (char)|строка|количество элементов (char)|элементы RefwRele ...
	//для измененных: длина строки (char)|строка|количество удаленных (char)|позиции удаленных (char)...|количестводобавленных (char)|позиция добавленного 1(char)|RefwRele|позиция добавленного 2(char)|RefwRele|...

	long delCount = 0, addCount = 0, chgCount = 0, i, seg = *m_ids[m_ids.first()], seg_count = m_ids.length (), zero = 0, size = 0;
	u_int64_t fpSizePos;
	if (seg_count > 1) {
		fwrite (&zero, sizeof (long), 1, m_DFile1);
		return 0;
	} else {
		fwrite (&seg_count, sizeof (long), 1, m_DFile1);
	}

	char name [5];
	sprintf (name, "-%03d", seg);

	char message [128];
	sprintf (message, "Построение дельты %s, поток %ld", name, thread_id);
	GetProgressScreen()->SetMessage (message);

	fwrite (&seg, sizeof (long), 1, m_DFile1);
	fpSizePos = _ftelli64 (m_DFile1);
	fwrite (&zero, sizeof (long), 1, m_DFile1); //здесь будет записан размер всех данных	
	fwrite (&delCount, sizeof (delCount), 1, m_DFile1);
	fwrite (&addCount, sizeof (addCount), 1, m_DFile1);
	fwrite (&chgCount, sizeof (chgCount), 1, m_DFile1);

	if (!b_daily) {
		Index* auxInd = old_base->FindIndex ("Aux");
		Stream* str = auxInd->Open (name);

		std::map<std::string, long> old_requests, new_requests;
		if (str) {
			while (str->Tell () < str->Length ()) {
				long request_str_length;
				str->Read (&request_str_length, sizeof (long));
				char* request_str = (char*) malloc (request_str_length);
				str->Read (request_str, request_str_length);
				long offset;
				str->Read (&offset, sizeof (long));
				old_requests.insert (std::map<std::string, long>::value_type (request_str, offset));
			}
			auxInd->Close (str);
		}

		auxInd = new_base->FindIndex ("Aux");
		str = auxInd->Open (name);
		if (str) {
			while (str->Tell () < str->Length ()) {
				long request_str_length;
				str->Read (&request_str_length, sizeof (long));
				char* request_str = (char*) malloc (request_str_length);
				str->Read (request_str, request_str_length);
				long offset;
				str->Read (&offset, sizeof (long));
				new_requests.insert (std::map<std::string, long>::value_type (request_str, offset));
			}
			auxInd->Close (str);
		}

		name [0] = '|';
		Stream* old_str = old_base->FindIndex ("Aux")->Open (name);
		Stream* new_str = new_base->FindIndex ("Aux")->Open (name);

		std::vector<std::string> delete_requests;
		std::map<std::string,long>::const_iterator it;
		for (it = old_requests.begin (); it != old_requests.end (); it++) {
			std::string request = it->first;
			if (new_requests.find (request) == new_requests.end ())
				delete_requests.push_back (request);
		}
		delCount = delete_requests.size ();

		{
		//для удаленных пишем: длина запроса/запрос с терминирующим нулем
		for (std::vector<std::string>::const_iterator it = delete_requests.begin (); it != delete_requests.end (); it++) {
			unsigned char str_len = (unsigned char) ((it->size () + 1) & 0xFF);
			fwrite (&str_len, sizeof (str_len), 1, m_DFile1);
			fwrite (it->c_str (), str_len, 1, m_DFile1);
		}
		}

		std::vector<std::string> add_requests;
		for (it = new_requests.begin (); it != new_requests.end (); it++) {
			std::string request = it->first;
			if (old_requests.find (request) == old_requests.end ())
				add_requests.push_back (request);
		}
		addCount = add_requests.size ();

		{
		//для новых пишем: длина запрос/запрос с терминирующим нулем/количество RefwRele/массив RefwRele
		for (std::vector<std::string>::const_iterator it = add_requests.begin (); it != add_requests.end (); it++) {
			unsigned char str_len = (unsigned char) ((it->size () + 1) & 0xFF);
			fwrite (&str_len, sizeof (str_len), 1, m_DFile1);
			fwrite (it->c_str (), str_len, 1, m_DFile1);
			new_str->Seek (new_requests.find (*it)->second);
			long count;
			new_str->Read (&count, sizeof (long));
			unsigned char char_count = (unsigned char)(count & 0xFF);
			fwrite (&char_count, sizeof (char_count), 1, m_DFile1);
			for (long i = 0; i < count; i++) {
				RefwRele rele;
				new_str->Read (&rele, sizeof (RefwRele));
				fwrite (&rele, sizeof (RefwRele), 1, m_DFile1);
			}
		}
		}

		for (it = new_requests.begin (); it != new_requests.end (); it++) {
			std::string request = it->first;
			if (old_requests.find (request) != old_requests.end ()) {
				long new_offset = it->second, old_offset = old_requests.find (request)->second;
				old_str->Seek (old_offset);
				new_str->Seek (new_offset);
				long old_size, new_size;
				old_str->Read (&old_size, sizeof (old_size));
				new_str->Read (&new_size, sizeof (new_size));
				RefwRele *old_data = new RefwRele [old_size], *new_data = new RefwRele [new_size], *ptr;
				old_str->Read (old_data, old_size * sizeof (RefwRele));
				new_str->Read (new_data, new_size * sizeof (RefwRele));
				if (old_size != new_size || memcmp (old_data, new_data, old_size * sizeof (RefwRele))) {
					chgCount++;
					std::vector<RefwRele> old_rele, new_rele;
					for (ptr = old_data, i = 0; i < old_size; i++, ptr++)
						old_rele.push_back (*ptr);
					for (ptr = new_data, i = 0; i < new_size; i++, ptr++)
						new_rele.push_back (*ptr);
					std::vector<RefwRele>::iterator old_it, new_it;

					//шаг 1. Надо найти в старом массиве тех, которых заведомо нет в новом. Их удаляем (с конца), и эти позиции пишем в дельту
					std::vector<char> del_positions;
					char del_position = 0;
					for (old_it = old_rele.begin (); old_it != old_rele.end (); old_it++, del_position++) {
						RefwRele at_old_rele = *old_it;
						bool found = false;
						for (new_it = new_rele.begin (); new_it != new_rele.end () && !found; new_it++) {
							RefwRele at_new_it = *new_it;
							if (!memcmp (&at_old_rele, &at_new_it, sizeof (RefwRele)))
								found = true;
						}
						if (!found)
							del_positions.push_back (del_position);
					}
					char del_count = (char) (del_positions.size () & 0xFF), add_count;
					std::map<char, RefwRele> add_positions;
					bool b_moved = false;
					if (del_count != old_rele.size ()) {
						if (del_count)
							for (std::vector<char>::reverse_iterator del_it = del_positions.rbegin (); del_it != del_positions.rend (); del_it++)
								old_rele.erase (old_rele.begin () + *del_it);

						//шаг2. В новом массиве находим те, которых нет в старом. Пишем их позиции+данные в дельту
						char add_position = 0;
						for (new_it = new_rele.begin (); new_it != new_rele.end (); new_it++, add_position++) {
							RefwRele at_new_rele = *new_it;
							bool found = false;
							for (old_it = old_rele.begin (); old_it != old_rele.end () && !found; old_it++) {
								RefwRele at_old_it = *old_it;
								if (!memcmp (&at_new_rele, &at_old_it, sizeof (RefwRele)))
									found = true;
							}
							if (!found)
								add_positions.insert (std::map<char, RefwRele>::value_type (add_position, at_new_rele));
						}
						add_count = (char) (add_positions.size () & 0xFF);
						if (add_count) {
							for (std::map<char,RefwRele>::const_iterator map_it = add_positions.begin (); map_it != add_positions.end (); map_it++) {
								char add_pos = map_it->first;
								RefwRele add_rele = map_it->second;
								old_rele.insert (old_rele.begin () + add_pos, add_rele);
							}
						}
						if (old_rele.size () == new_rele.size ()) {
							for (old_it = old_rele.begin (), new_it = new_rele.begin (); old_it != old_rele.end () && !b_moved; old_it++, new_it++) {
								RefwRele at_old_it = *old_it, at_new_it = *new_it;
								if (memcmp (&at_old_it, &at_new_it, sizeof (RefwRele)))
									b_moved = true;
							}
						}
					} else {
						b_moved = true;
					}

					//пишем в дельту
					unsigned char str_len = (unsigned char)((it->first.size () + 1) & 0xFF);
					fwrite (&str_len, sizeof (str_len), 1, m_DFile1);
					fwrite (it->first.c_str (), str_len, 1, m_DFile1);
					if (b_moved) {
						//были перенесенные элементы. Удаляем старые, добавляем новые
						del_count = (char) (old_size & 0xFF);
						fwrite (&del_count, sizeof (del_count), 1, m_DFile1);
						char add_count = (char) (new_size & 0xFF);
						fwrite (&add_count, sizeof (add_count), 1, m_DFile1);
						for (new_it = new_rele.begin (); new_it != new_rele.end (); new_it++) {
							RefwRele add_rele = *new_it;
							fwrite (&add_rele, sizeof (RefwRele), 1, m_DFile1);
						}
					} else {
						fwrite (&del_count, sizeof (del_count), 1, m_DFile1);
						for (std::vector<char>::reverse_iterator del_it = del_positions.rbegin (); del_it != del_positions.rend (); del_it++) {
							char del_pos = *del_it;
							fwrite (&del_pos, sizeof (del_pos), 1, m_DFile1);
						}
						fwrite (&add_count, sizeof (add_count), 1, m_DFile1);
						for (std::map<char,RefwRele>::const_iterator map_it = add_positions.begin (); map_it != add_positions.end (); map_it++) {
							char add_pos = map_it->first;
							fwrite (&add_pos, sizeof (add_pos), 1, m_DFile1);
							RefwRele add_rele = map_it->second;
							fwrite (&add_rele, sizeof (RefwRele), 1, m_DFile1);
						}
					}
				}
				delete old_data;
				delete new_data;
			}
		}

		if (old_str) old_base->FindIndex ("Aux")->Close (old_str);
		if (new_str) new_base->FindIndex ("Aux")->Close (new_str);
	}

	u_int64_t fpCurrentPos = _ftelli64 (m_DFile1);
	_fseeki64 (m_DFile1, fpSizePos, ACE_OS_SEEK_SET);
	size = (long)((fpCurrentPos - fpSizePos - sizeof (long)) & 0xFFFFFFFF);
	fwrite (&size,     sizeof (size),     1, m_DFile1);
	fwrite (&delCount, sizeof (delCount), 1, m_DFile1);
	fwrite (&addCount, sizeof (addCount), 1, m_DFile1);
	fwrite (&chgCount, sizeof (chgCount), 1, m_DFile1);
	_fseeki64 (m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET);

	logger.printf ( lt_deltaInfo, "%s diff size = %ld\n", name, size);
	logger.flush (lt_always);

	return 0;
}

int	Full::Work()
{
	//
	// Позиция в файле дальты где записывается размер дельты
	//
	int res = PreWork();
	if ( !res )
		return res;

	//
    // Обработка документов
    //
	m_pNewBase -> FindBaseInfo ( 0, aBaseInfo );
	if ( !aBaseInfo.RecCount )
		aBaseInfo.RecCount = 10000;

	// Начинаем работу, устанавливаем начальные счетчики
    DiffProcCreate ( aBaseInfo.RecCount );

	// Цикл по документам в новой базе
    while( ( m_lDocId = GetNextDocId ( VER_NEW ) ) != NEW_ID ) {
		WorkDoc( m_lDocId );
	}
	return PostWork();
}

void	Full::PostWork1()
{
	fptCurrentPos = _ftelli64 (m_DFile1);

	_fseeki64 (m_DFile1, m_DocCntFilePos, ACE_OS_SEEK_SET);
	fwrite ( &g_lDocInDelta, sizeof ( long ), 1, m_DFile1 );
	_fseeki64 ( m_DFile1, fptCurrentPos, ACE_OS_SEEK_SET);

	logger.printf ( lt_info, "Building Main Menu structure's and Blob's delta\n" );
	DiffDocKindData(); 
}

void	Full::PostWork2 (SearchBase* old_base, SearchBase* new_base, long thread_id)
{
	if (!b_texts_only) {
		DiffCorrespondent (old_base, new_base, thread_id);
		DiffNewCorr (old_base, new_base, thread_id);
#ifndef	_DEBUG
		DiffControl (old_base, new_base, thread_id);
		DiffSyns (AUX_SYN_MORPHO, old_base, new_base, thread_id);
		DiffCVar (old_base, new_base, thread_id);
		DiffMorphoHashes (old_base, new_base, thread_id);
		DiffReleFLaws (old_base, new_base, thread_id);
		DiffTypingErrors (old_base, new_base, thread_id);
		DiffGoodWords (old_base, new_base, thread_id);
		DiffKindCorr (old_base, new_base, thread_id);
		DiffSyns (AUX_SIMPLE_SYNS, old_base, new_base, thread_id);
		DiffSearchCache (old_base, new_base, thread_id);
#endif
	}

	// Save control delta size
	fptCurrentPos = _ftelli64 ( m_DFile1);
	unsigned long ulOffset = (unsigned long) (fptCurrentPos & 0xFFFFFFFF);
	fwrite (&ulOffset, sizeof (ulOffset), 1, m_DFile1);
	fptCurrentPos = _ftelli64 (m_DFile1);
	_fseeki64 (m_DFile1, fpSizeDummyPos, ACE_OS_SEEK_SET);
	fwrite (&ulOffset, sizeof ( ulOffset ), 1, m_DFile1);
	_fseeki64 (m_DFile1, fptCurrentPos, ACE_OS_SEEK_SET);
	fflush (m_DFile1);
	fclose (m_DFile1);

	if ( for_all_segs ) {
		logger.printf ( lt_info, "\nDelta statistics (%ld):\n", seg );
		logger.printf ( lt_info, "\ttotal documents processed (%ld): %ld\n", seg, g_newdocs.size () + g_chgdocs.size () + g_equdocs.size () + g_deldocs.size () );
		logger.printf ( lt_info, "\t\tnew documents count (%ld): %ld\n", seg, g_newdocs.size () );
		logger.printf ( lt_info, "\t\tnew documents delta size (%ld): %ld\n", seg, g_lNewDocSize );
		logger.printf ( lt_info, "\t\tchanged documents count (%ld): %ld\n", seg, g_chgdocs.size () );
		logger.printf ( lt_info, "\t\tchanged documents delta size (%ld): %ld\n", seg, g_lChgDocSize );
		logger.printf ( lt_info, "\t\tdeleted documents count (%ld): %ld\n", seg, g_deldocs.size () );
		logger.printf ( lt_info, "\t\tequal documents count (%ld): %ld\n", seg, g_equdocs.size () );
		logger.printf ( lt_info, "\ttotal BLOBs processed (%ld): %ld\n", seg, g_lNewBlbCount + g_lChgBlbCount + g_lEquBlbCount + g_lDelBlbCount );
		logger.printf ( lt_info, "\t\tnew BLOBs count (%ld): %ld\n", seg, g_lNewBlbCount );
		logger.printf ( lt_info, "\t\tnew BLOBs delta size (%ld): %ld\n", seg, g_lNewBlbSize );
		logger.printf ( lt_info, "\t\tchanged BLOBs count (%ld): %ld\n", seg, g_lChgBlbCount );
		logger.printf ( lt_info, "\t\tchanged BLOBs delta size (%ld): %ld\n", seg, g_lChgBlbSize );
		logger.printf ( lt_info, "\t\tdeleted BLOBs count (%ld): %ld\n", seg, g_lDelBlbCount );
		logger.printf ( lt_info, "\t\tequal BLOBs count (%ld): %ld\n", seg, g_lEquBlbCount );
	}
	else {
		logger.printf ( lt_info, "\nDelta statistics:\n" );
		logger.printf ( lt_info, "\ttotal documents processed: %ld\n", g_newdocs.size () + g_chgdocs.size () + g_equdocs.size () + g_deldocs.size () );
		logger.printf ( lt_info, "\t\tnew documents count: %ld\n", g_newdocs.size () );
		logger.printf ( lt_info, "\t\tnew documents delta size: %ld\n", g_lNewDocSize );
		logger.printf ( lt_info, "\t\tchanged documents count: %ld\n", g_chgdocs.size () );
		logger.printf ( lt_info, "\t\tchanged documents delta size: %ld\n", g_lChgDocSize );
		logger.printf ( lt_info, "\t\tdeleted documents count: %ld\n", g_deldocs.size () );
		logger.printf ( lt_info, "\t\tequal documents count: %ld\n", g_equdocs.size () );
		logger.printf ( lt_info, "\ttotal BLOBs processed: %ld\n", g_lNewBlbCount + g_lChgBlbCount + g_lEquBlbCount + g_lDelBlbCount );
		logger.printf ( lt_info, "\t\tnew BLOBs count: %ld\n", g_lNewBlbCount );
		logger.printf ( lt_info, "\t\tnew BLOBs delta size: %ld\n", g_lNewBlbSize );
		logger.printf ( lt_info, "\t\tchanged BLOBs count: %ld\n", g_lChgBlbCount );
		logger.printf ( lt_info, "\t\tchanged BLOBs delta size: %ld\n", g_lChgBlbSize );
		logger.printf ( lt_info, "\t\tdeleted BLOBs count: %ld\n", g_lDelBlbCount );
		logger.printf ( lt_info, "\t\tequal BLOBs count: %ld\n", g_lEquBlbCount );
	}
}

int	Full::PostWork()
{
	PostWork1();
	DeltaBlobs();
	
	logger.printf ( lt_info, "Finding deleted documents\n" );
	FindDelDoc ();

	PostWork2 (m_pOldBase, m_pNewBase, 0);

	return 0;
}

Full::TextAnalizer::TextAnalizer ( DummyDoc *olddoc, DummyDoc *newdoc, int thread )
	: m_old(olddoc), m_new(newdoc), m_thread (thread) 
{
	logger.printf ( lt_debug, "Start Docs analize...\n" );
	long begin,end,oldend;
	// detect equals from begin
	logger.printf ( lt_debug, "\tdetect equals from begin..." );
	for (begin=0; begin<m_new->paracount && begin<m_old->paracount; begin++) {
		if ( ParaSize(m_new->GetPara(begin)) != ParaSize(m_old->GetPara(begin)) || memcmp (m_new->GetPara(begin), m_old->GetPara(begin), ParaSize(m_new->GetPara(begin))+3 ) )
			break;
		else
			m_mapEqu.add (begin,begin);
	}
	logger.printf ( lt_debug, " %ld detects\n", begin );

	// if not all para is equal then text is changed
	if ( m_mapEqu.length()==m_new->paracount && m_mapEqu.length()==m_old->paracount ) {
		m_isEqual = 1;
		return;
	} else {
		m_isEqual = 0;
	}

	// detect equals from end
	logger.printf ( lt_debug, "\tdetect equals from end..." );
	for (oldend=m_old->paracount-1,end=m_new->paracount-1; end>begin && oldend>=begin; end--,oldend--) {
		if ( ParaSize(m_new->GetPara(end)) != ParaSize(m_old->GetPara(oldend)) ||
			memcmp (m_new->GetPara(end), m_old->GetPara(oldend), ParaSize(m_new->GetPara(end))+3 ) )
			break;
		else
			m_mapEqu.add (end,oldend);
	}
	logger.printf ( lt_debug, " %ld detects\n", m_new->paracount-1-end );

	// check
	if (m_mapEqu.length()==m_new->paracount) return;
	// fill unprocessed id sets
	{ 
		long l;
		for (l=begin; l<=end; l++)
			m_setNewUnknown.add(l);
		for (l=begin; l<=oldend; l++)
			m_setOldUnknown.add(l);
	}

	long equcount = m_mapEqu.length();

#ifdef DETECTEQU_THROUGH
	logger.printf ( lt_debug, "\tdetect equals full serching..." );
	detectEqu_Through();
#else
	logger.printf ( lt_debug, "\tdetect equals by overlapping with equal sizes..." );
	detectEqu_Overlapping();
#endif
	
	logger.printf ( lt_debug, " %ld detects\n", m_mapEqu.length() - equcount );
}

void Full::TextAnalizer::detectEqu_Through()
{
	long _time = time (0), _count = 0;
	// detect equals full serching		
	for ( Point np=m_setNewUnknown.first(); np; ) {
		long npos = m_setNewUnknown(np); // para position in new doc
		m_setNewUnknown.next(np); // safly forward
		
		for ( Point op=m_setOldUnknown.first(); op; m_setOldUnknown.next(op) ) {
			long opos = m_setOldUnknown(op); // para position in olddoc
		
			if ( ParaSize(m_new->GetPara(npos)) == ParaSize(m_old->GetPara(opos)) && !memcmp (m_new->GetPara(npos), m_old->GetPara(opos), ParaSize(m_new->GetPara(npos))+3 ) )  {
				m_mapEqu.add (npos,opos);
				m_setOldUnknown.del(opos); // old was processed
				m_setNewUnknown.del(npos); // new was processed
				break;			
			}
			_count++;
		}
		if (_count > 10000) {
			_count = 0;
			if (time (0) - _time > 10)
				break;
		}
	}
}

void Full::TextAnalizer::detectEqu_Overlapping()
{
	// detect equals by overlapping with equal sizes	
	Point np, op;
	for ( np=m_setNewUnknown.first(),op=m_setOldUnknown.first();
		np && op;) 
	{
		long npos = m_setNewUnknown(np); // para position in new doc
		long opos = m_setOldUnknown(op); // para position in old doc

		m_setNewUnknown.next(np); // safly forward new sets

		long nsize = ParaSize(m_new->GetPara(npos));

		if ( nsize != ParaSize(m_old->GetPara(opos)) ) {
			Point fwd = op;
			Point bwd = op;
				
			while (fwd || bwd) {
				long bopos = -1;                 // backward para position in old doc
				long fopos = -1;                 // forward para position in old doc
			
				m_setOldUnknown.next(fwd);				
				m_setOldUnknown.prev(bwd);				
				if ( fwd && (nsize == ParaSize(m_old->GetPara(m_setOldUnknown(fwd)))) ) {
					//forward find equal sized
					op = fwd;
					m_setOldUnknown.next(op);
					fopos = m_setOldUnknown(fwd);
					if (!memcmp (m_new->GetPara(npos), m_old->GetPara(fopos), nsize+3 ) ) {
						m_mapEqu.add (npos,fopos);
						m_setOldUnknown.del(fopos); // old was processed
						m_setNewUnknown.del(npos); // new was processed
						break;
					}
				}
				if ( bwd && (nsize == ParaSize(m_old->GetPara(m_setOldUnknown(bwd)))) ) {
					//backward find equal sized
					op = bwd;
					m_setOldUnknown.next(op);
					bopos = m_setOldUnknown(bwd);
					if (!memcmp (m_new->GetPara(npos), m_old->GetPara(bopos), nsize+3 ) ) {
						m_mapEqu.add (npos,bopos);
						m_setOldUnknown.del(bopos);	// old was procesed
						m_setNewUnknown.del(npos); // new was processed
						break;
					}
				}
				if (fopos>=0||bopos>=0) break;
			}
		} else {
			// find overlapped equal sized
			m_setOldUnknown.next(op);
			if (!memcmp (m_new->GetPara(npos), m_old->GetPara(opos), nsize+3 ) ) {
				m_mapEqu.add (npos,opos);					
				m_setOldUnknown.del(opos); // old was procesed
				m_setNewUnknown.del(npos); // new was processed
			}
		}

		if (!op) op = m_setOldUnknown.first();
	}
}

int Full::TextAnalizer::isEqual () const
{
	return m_isEqual;
}

float Full::TextAnalizer::getEquPara ( long npos, long& opos )
{
	if ( m_mapEqu.contains ( npos ) ) {
		opos = m_mapEqu[npos];
		return 0.0;
	}
	return 1.0;
}

float Full::TextAnalizer::getParaOrder ( long npos, long& opos )
{
	if ( m_mapEqu.contains ( npos ) ) {
		opos = m_mapEqu[npos];
		return 0.0;
	} 
	if ( !m_setNewUnknown.contains ( npos ) ) {
		logger.printf ( lt_error, "Something wrong with TextAnalizer: unknown new para %ld\n", npos );
		return 1.0;
	}

	m_setNewUnknown.del (npos);
	
	bool bEvd = m_new->stat.Status & DS_EVD ? true : false;
	
	const char* npara = m_new->GetPara ( npos );
	const char* ntext = bEvd ? m_new->EVDParaText( npara ) : ParaText ( npara );
	int nsize = bEvd ? m_new->EVDTextSize( npara ) : TextSize ( npara );

	Word* nwords = CreatWordFromMem( ntext, nsize, m_thread, pNBUF [m_thread]);

	logger.printf ( lt_debug, "Start serching..." );
	
	bEvd = m_old->stat.Status & DS_EVD ? true : false;

	for ( Point op = m_setOldUnknown.first(); op; m_setOldUnknown.next(op) ) {
		opos = m_setOldUnknown.contents(op);

		const char* opara = m_old->GetPara (opos);
		const char* otext = bEvd ? m_old->EVDParaText( opara ) : ParaText (opara);
		int osize = bEvd ? m_old->EVDTextSize( opara ) : TextSize (opara);

		if ( m_new->DocId >= BIG_INFO_DOC && m_new->DocId < BIG_INFO_DOC + BIG_INFO_COUNT ) {
			if ( atol( ntext ) != atol( otext ))
				continue;
			if ( nsize == osize )
				continue;
		}

		Word* owords = CreatWordFromMem( otext, osize, m_thread, pOBUF [m_thread]);

		float dP;
		
		if ( osize == nsize && nsize == 0 ) {
			dP = 0.0;
		} else {
			DiffHandler DH ( owords, nwords, m_thread );
			dP = DH.MakeDP ();
		}

		if ( dP < 0.5 ) {
			if ( dP ) logger.printf ( lt_debug, " return as CHG\n" );
			else logger.printf ( lt_debug, " return as NEW\n" );

			m_setOldUnknown.del (opos);

			if ( nwords ) delete [] nwords;
			return dP;
		}

		if ( owords ) delete [] owords;
	}

	if ( nwords ) delete [] nwords;
	logger.printf ( lt_debug, " return as NEW\n" );
	return 1.0;
}

extern	std::map<long,long> map_newdoc_unpackedsize, map_newdoc_packedsize;
extern	std::map<long,char*> map_newdoc_packeddata, map_newdoc_unpackeddata;
extern	std::map<long,long> map_chgdoc_unpackedsize, map_chgdoc_packedsize;
extern	std::map<long,char*> map_chgdoc_packeddata, map_chgdoc_unpackeddata;

bool	Full :: DeltaChgDoc ()
{
	bool	result = false; //была ли упакована дельта

	std::map<long,char*>::const_iterator map_doc_packeddata_it = map_chgdoc_packeddata.find (m_lDocId);
	std::map<long,char*>::const_iterator map_doc_unpackeddata_it = map_chgdoc_unpackeddata.find (m_lDocId);
	std::map<long,long>::const_iterator packedsize_it = map_chgdoc_packedsize.find (m_lDocId);
	std::map<long,long>::const_iterator unpackedsize_it = map_chgdoc_unpackedsize.find (m_lDocId);
	long packed_size = packedsize_it == map_chgdoc_packedsize.end () ? 0 : packedsize_it->second;
	long unpacked_size = unpackedsize_it == map_chgdoc_unpackedsize.end () ? 0 : unpackedsize_it->second;

	if (b_prepack || b_daily || (!b_prepack && !b_pack_delta)) { // We have no entry in DiffHolder - Make and Save ChgDoc Diff
		Stream	*pStr1 = m_pDiffHolder[m_thread]->idx1->Open (&m_lDocId, 1);
		if (b_pack_delta) {
			logger.printf (lt_fatal, "No entry in m_pDiffHolder[%ld] for doc %ld\n", m_thread, m_lDocId);
			exit (EXIT_FAILURE);
		}
		long	g_iDiffAlarm = 0;
		u_int64_t fptDF1StartPos, fptDF1EndPos;
		fptDF1StartPos = _ftelli64 (m_DFile1);

		u_int64_t fptAttrStartPos, fptAttrEndPos;
		fptAttrStartPos = _ftelli64 (m_AttrFile);

		// Saving Block for DF1 and Attrs starts here !
		char	*pAttrMask = new char [ MAX_LEVEL ];

		// here we fill Attrs-tmp file
		int	iMaskLevelCount = CreateAttrDiff ( m_lDocId, pAttrMask, 0 ); 

		if (b_gctx_attrs_only) {
			pAttrMask[0] |= O_DOC_CHG;

			for ( int i = 0; i < iMaskLevelCount; i++ )
				fwrite ( &pAttrMask [i], sizeof ( char ), 1, m_DFile1 );

			fwrite ( &m_NewDocInfo.Revision, sizeof ( revision ), 1, m_DFile1 ); // New Revision
			fwrite ( &m_OldDocInfo.Revision, sizeof ( revision ), 1, m_DFile1 ); // Old Revision
		} else {
			pAttrMask[0] |= O_DOC_CHG;
			
			// Loading both docs into memory
			DummyDoc olddoc ( m_pOldBase, m_lDocId );
			DummyDoc newdoc ( m_pNewBase, m_lDocId );

			///////// is doc's text changed ////////////
			TextAnalizer analizer (&olddoc, &newdoc, m_thread);
			if ( analizer.isEqual() ) {
				if (b_texts_only) {
					iMaskLevelCount = 0;
					delete pAttrMask;
					if (pStr1)
						m_pDiffHolder[m_thread]->idx1->Close (pStr1);
					return result;
				}
				pAttrMask[0] |= M_TXT_EQU; // FIRST BYTE IN DH-FILE!!!
			} else {
				pAttrMask[0] |= M_TXT_CHG;
				if (b_texts_only)
					pAttrMask[0] |= M_TXT_INCACHE;
			}
			if (
					(iMaskLevelCount > 1 && ( pAttrMask[1] & ( M_STAT_DOC | M_STAT_NODOC | M_ATR_IND_RESP )))
					|| (iMaskLevelCount > 12 && ( pAttrMask[12] & M_ATR_KIND ))
					|| (iMaskLevelCount > 5 && ( pAttrMask[5] & M_ATR_REFS ))
					|| (iMaskLevelCount > 4 && (pAttrMask [4] & M_ATR_PARAIDS))
					|| (iMaskLevelCount > 11 && (pAttrMask [11] & M_ATR_SUBSEX))
				)
			{
				FillCorrList ( m_lDocId );
				g_cordocs.insert ( m_lDocId );
			} else if ((pAttrMask[0] & M_TXT_CHG) && !b_texts_only) {
				FillCorrList ( m_lDocId );
			}

			///////// save doc's changes mask ///////////
			for ( int i = 0; i < iMaskLevelCount; i++ )
				fwrite ( &pAttrMask [i], sizeof ( char ), 1, m_DFile1 );

			fwrite ( &m_NewDocInfo.Revision, sizeof ( revision ), 1, m_DFile1 ); // New Revision
			fwrite ( &m_OldDocInfo.Revision, sizeof ( revision ), 1, m_DFile1 ); // Old Revision

			// Quit if text not changed
			if (pAttrMask[0] & M_TXT_CHG ) {
				if (b_extended_log) {
					logger.printf (lt_deltaInfo, "\ntext changed ");
					if (b_flush_log) logger.flush (lt_always);
				}

				// START TEXT DIFF CREATION
				fwrite ( &m_NewDocInfo.ParaCount, sizeof ( long ), 1, m_DFile1 );   // para COUNT

				long eqParaCount=0;
				long lPrevOldPos = -1;

				DeltaParams params;
				params.olddoc = &olddoc;
				params.newdoc = &newdoc;
				params.offset = 0;
				params.newpos = 0;

				float dP;
				time_t start_time = time (0);
				while ( params.newpos < m_NewDocInfo.ParaCount ) {
					if ( g_iDiffAlarm )
						dP = analizer.getEquPara (params.newpos, params.oldpos);
					else
						dP = analizer.getParaOrder (params.newpos, params.oldpos);

					if (dP != 1) {
						// Para NOT New
						params.offset = params.oldpos - lPrevOldPos;
						lPrevOldPos = params.oldpos;
					}

					int iParaOrder;

					if (!dP) {
						if ( params.offset == 1 ) {
							iParaOrder = O_PAR_EQU;
							if (GetStyleOrder (params))
								iParaOrder |= O_STL_CHG;
						} else {
							iParaOrder = O_PAR_MOV;
						}
					} else if ( dP < 1 ) {
						iParaOrder = O_PAR_CHG;
					} else {
						iParaOrder = O_PAR_NEW;
					}

					switch ( iParaOrder ) {
						case O_PAR_EQU :                        // Para Equal
							eqParaCount++;
							break;

						case O_STL_CHG :
							if ( eqParaCount )
								DeltaEquPara ( eqParaCount );
							DeltaChgStyle ( params );
							break;

						case O_PAR_MOV :
							if ( eqParaCount )
								DeltaEquPara ( eqParaCount );
							DeltaMovPara ( params );
							break;

						case O_PAR_CHG : // Para Changed
							if ( eqParaCount )
								DeltaEquPara ( eqParaCount );
							DeltaChgPara ( params );
							break;

						case O_PAR_NEW :        // New Para
							if ( eqParaCount )
								DeltaEquPara ( eqParaCount );
							DeltaNewPara ( params );
							break;

						default :
							logger.printf ( lt_fatal, "Unknown Para order %ld\n", iParaOrder );
							_EXIT (EXIT_FAILURE);
					}
					params.newpos++;

					if (0 == g_iDiffAlarm && (time (0) - start_time > g_lDiffTimeLimit)) {
						g_iDiffAlarm = 1;
						logger.printf (lt_warning, "Creating cool text diff for this doc stoped by timer\n");
						if (b_flush_log) logger.flush (lt_always);
					}
				}

				if (eqParaCount) {
					DeltaEquPara ( eqParaCount );
				}
			}
		}

		delete pAttrMask;

		// Moving Diff-Block from Attr-tmp file into DF1 file
		fflush ( m_DFile1 );
		fflush ( m_AttrFile );

		fptAttrEndPos = _ftelli64 (m_AttrFile);

		unsigned long buffSize = (unsigned long)((fptAttrEndPos - fptAttrStartPos) & 0xFFFFFFFF);
		if ( buffSize ) {
			void * pBuffAttr = malloc (buffSize);
			assert ( pBuffAttr );
			_fseeki64 ( m_AttrFile, fptAttrStartPos, ACE_OS_SEEK_SET);
			fread ( pBuffAttr, 1, buffSize, m_AttrFile );
			_fseeki64 ( m_AttrFile, fptAttrEndPos, ACE_OS_SEEK_SET);

			fwrite ( pBuffAttr, 1, (size_t)(fptAttrEndPos - fptAttrStartPos), m_DFile1 );
			free ( pBuffAttr );
		}

		// Saving Block for DF1 ends here !
		fptDF1EndPos = _ftelli64 (m_DFile1);

		// Save DF1 blocks into DiffHolder
		void * pBuff1 = malloc ( (fptDF1EndPos - fptDF1StartPos) & 0xFFFFFFFF);
		assert ( pBuff1 );
		_fseeki64 ( m_DFile1, fptDF1StartPos, ACE_OS_SEEK_SET);
		fread ( pBuff1, 1, (fptDF1EndPos - fptDF1StartPos) & 0xFFFFFFFF, m_DFile1);
		_fseeki64 ( m_DFile1, fptDF1EndPos, ACE_OS_SEEK_SET );

		if (b_prepack) {
			if (b_single_cache) {
				GUARD (cache_mutex);
				pStr1 = m_pDiffHolder[0]->idx1->Open (&m_lDocId, 1);
				pStr1 -> Write ( pBuff1, (size_t)(fptDF1EndPos - fptDF1StartPos) );
				m_pDiffHolder[0]->idx1->Close (pStr1);
			} else {
				pStr1 = m_pDiffHolder[m_thread]->idx1->Open (&m_lDocId, 1);
				pStr1 -> Write ( pBuff1, (size_t)(fptDF1EndPos - fptDF1StartPos) );
			m_pDiffHolder[m_thread]->idx1->Close (pStr1);
			}
			free ( pBuff1 );
		}
	} else {
		// TxtDiff exist in DiffHolder - Read it
		/*
		void * pBuff1 = malloc ( lSize1 );
		assert ( pBuff1 );
		pStr1 -> Read ( pBuff1, lSize1 );
		*/
		long lSize1 = unpacked_size;
		void *pBuff1 = map_doc_unpackeddata_it->second;

		char *pb = (char*)pBuff1;

		/*if ((pb[0] & M_TXT_INCACHE) && (pb[0] & M_TXT_CHG)) {
			//в кэше есть только текст документа, надо сравнить реквизиты, а ранее посчитанный текст записать из кэша
			pStr1->Seek (0);

			// remember DF1 and Attr-tmp file pos before saving delta
			u_int64_t fptDF1StartPos, fptDF1EndPos;
			fptDF1StartPos = _ftelli64 (m_DFile1);

			u_int64_t fptAttrStartPos, fptAttrEndPos;
			fptAttrStartPos = _ftelli64 (m_AttrFile);

			char	*pAttrMask = new char [ MAX_LEVEL ];
			int	iMaskLevelCount = CreateAttrDiff ( m_lDocId, pAttrMask, 0 ); 
			pAttrMask[0] |= O_DOC_CHG;
			pAttrMask[0] |= M_TXT_CHG;
			
			if (!b_gctx_attrs_only) {
				if (
						(iMaskLevelCount > 1 && (pAttrMask[1] & (M_STAT_DOC | M_STAT_NODOC | M_ATR_IND_RESP)))
						|| (iMaskLevelCount > 12 && (pAttrMask[12] & M_ATR_KIND ))
						|| (iMaskLevelCount > 5 && (pAttrMask[5] & M_ATR_REFS ))
						|| (iMaskLevelCount > 2 && (pAttrMask [4] & M_ATR_PARAIDS))
						|| (iMaskLevelCount > 11 && (pAttrMask [11] & M_ATR_SUBSEX))
					)
				{
					FillCorrList ( m_lDocId );
					g_cordocs.insert ( m_lDocId );
				} else if ((pAttrMask[0] & M_TXT_CHG))
					FillCorrList ( m_lDocId );
			}
			
			for ( int i = 0; i < iMaskLevelCount; i++ )
				fwrite ( &pAttrMask [i], sizeof ( char ), 1, m_DFile1 );

			fwrite ( &m_NewDocInfo.Revision, sizeof ( revision ), 1, m_DFile1 ); // New Revision
			fwrite ( &m_OldDocInfo.Revision, sizeof ( revision ), 1, m_DFile1 ); // Old Revision

			delete pAttrMask;
			fwrite (pb + 1 + sizeof (revision) * 2, 1, lSize1 - 1 - sizeof (revision) * 2, m_DFile1); //кэш текстов

			fflush (m_DFile1);
			fflush (m_AttrFile);

			fptAttrEndPos = _ftelli64 (m_AttrFile);
			unsigned long buffSize = (unsigned long)((fptAttrEndPos - fptAttrStartPos) & 0xFFFFFFFF);
			if ( buffSize ) {	
				void * pBuffAttr = malloc (buffSize);
				assert ( pBuffAttr );
				_fseeki64 ( m_AttrFile, fptAttrStartPos, ACE_OS_SEEK_SET );
				fread ( pBuffAttr, 1, buffSize, m_AttrFile );
				_fseeki64 ( m_AttrFile, fptAttrEndPos, ACE_OS_SEEK_SET );

				fwrite ( pBuffAttr, 1, (size_t)(fptAttrEndPos - fptAttrStartPos), m_DFile1 );
				free ( pBuffAttr );
			}

			fptDF1EndPos = _ftelli64 (m_DFile1);
			buffSize = (fptDF1EndPos - fptDF1StartPos) & 0xFFFFFFFF;
			void * pBuff1 = malloc (buffSize);
			assert ( pBuff1 );
			_fseeki64 (m_DFile1, fptDF1StartPos, ACE_OS_SEEK_SET);
			fread ( pBuff1, 1, (size_t)(fptDF1EndPos - fptDF1StartPos), m_DFile1 );
			_fseeki64 (m_DFile1, fptDF1EndPos, ACE_OS_SEEK_SET);

			pStr1 -> Write ( pBuff1, (fptDF1EndPos - fptDF1StartPos) & 0xFFFFFFFF);
			free ( pBuff1 );
		} else*/ {
			long chg_packed_size = 0;
			char* chg_packed_buf = 0;
			if (b_pack_delta && unpacked_size && packed_size) {
				chg_packed_buf = map_doc_packeddata_it->second;
				chg_packed_size = packed_size;
			}

			if (chg_packed_size == 0)
				fwrite (pBuff1, 1, lSize1, m_DFile1);
			else {
				//записать размер распакованной части
				fwrite (&lSize1, sizeof (long), 1, m_DFile1);
				//записать первый байт маски, нужен gdm
				fwrite (pBuff1, 1, 1, m_DFile1);
				fwrite (chg_packed_buf, 1, chg_packed_size, m_DFile1);
				result = true;
			}
			if (chg_packed_buf && 0 == packed_size)
				gk_free (chg_packed_buf);

			if (   ( pb[0] & M_ATR_NLE && pb[1] & (M_STAT_DOC | M_STAT_NODOC | M_ATR_IND_RESP ))
				|| ( pb[0] & M_ATR_NLE && pb[1] && M_ATR_NLE && pb[2] & M_ATR_NLE && pb[3] & M_ATR_NLE && pb[4] & M_ATR_NLE && pb[5] & M_ATR_REFS )
				|| ( pb[0] & M_ATR_NLE && pb[1] && M_ATR_NLE && pb[2] & M_ATR_NLE && pb[3] & M_ATR_NLE && pb[4] & M_ATR_PARAIDS)
				|| ( pb[0] & M_ATR_NLE && pb[1] && M_ATR_NLE && pb[2] & M_ATR_NLE && pb[3] & M_ATR_NLE && pb[4] & M_ATR_NLE && pb[5] & M_ATR_NLE && pb[6] & M_ATR_NLE && pb[7] & M_ATR_NLE && pb[8] & M_ATR_NLE && pb[9] & M_ATR_NLE && pb[10] & M_ATR_NLE && pb[11] & M_ATR_SUBSEX)
				|| ( pb[0] & M_ATR_NLE && pb[1] && M_ATR_NLE && pb[2] & M_ATR_NLE && pb[3] & M_ATR_NLE && pb[4] & M_ATR_NLE && pb[5] & M_ATR_NLE && pb[6] & M_ATR_NLE && pb[7] & M_ATR_NLE && pb[8] & M_ATR_NLE && pb[9] & M_ATR_NLE && pb[10] & M_ATR_NLE && pb[11] & M_ATR_NLE && pb[12] & M_ATR_KIND)
			 ) {
				FillCorrList ( m_lDocId );
				g_cordocs.insert ( m_lDocId );
			}
			else if ( pb[0] & M_TXT_CHG )
				FillCorrList ( m_lDocId );
			
			//free ( pBuff1 );
		}
	}

	return result;
}

void Full::DeltaEquPara ( long &eqParaCount )
{
	char cSaveOrder = O_PAR_EQU;
	fwrite ( &cSaveOrder, sizeof (char), 1, m_DFile1 );      // EQU para
	fwrite ( &eqParaCount, sizeof (long), 1, m_DFile1 );    // equal COUNT
	eqParaCount=0;
}

void Full::DeltaChgStyle ( DeltaParams& param )
{
	const char *  pPara = param.newdoc->GetPara( param.newpos );
	assert ( pPara );

	char cSaveOrder = GetStyleOrder ( param ) | O_PAR_EQU;

	fwrite ( &cSaveOrder, sizeof (char), 1, m_DFile1 );    //  EQU para
	SaveParaHeader ( pPara, cSaveOrder, param.newdoc );
}

void Full::DeltaMovPara ( DeltaParams& param )
{
	const char *  pPara = param.newdoc->GetPara( param.newpos );
	assert ( pPara );

	char cSaveOrder = GetStyleOrder ( param ) | O_PAR_MOV;

	fwrite ( &cSaveOrder, sizeof (char), 1, m_DFile1 );        // MOV para
	SaveParaHeader ( pPara, cSaveOrder, param.newdoc );
	fwrite ( &param.offset, sizeof (long), 1, m_DFile1 );           // mov OFS
}

void Full::DeltaChgPara ( DeltaParams& param )
{
	bool bEvd = param.newdoc->stat.Status & DS_EVD ? true : false;

	const char *  pPara = param.newdoc->GetPara( param.newpos );
    assert ( pPara );
    short   siTextSize = bEvd ? param.newdoc->EVDTextSize( pPara ) : TextSize ( pPara );

    char cSaveOrder = GetStyleOrder ( param ) | O_PAR_CHG;

    fwrite ( &cSaveOrder, sizeof (char), 1, m_DFile1 );       // CHG para

    SaveParaHeader ( pPara, cSaveOrder, param.newdoc );

    fwrite ( &param.offset, sizeof (long), 1, m_DFile1 );     // chg para OFS
    fwrite ( &siTextSize, sizeof (short), 1, m_DFile1 );      // chg para SIZE

    Word	*pNewWords = CreatWordFromMem(bEvd ? param.newdoc->EVDParaText(pPara):ParaText(pPara), bEvd ? param.newdoc->EVDTextSize( pPara ) : TextSize(pPara), m_thread, pNBUF[m_thread]);

	pPara = param.olddoc->GetPara( param.oldpos );
	bEvd = param.olddoc->stat.Status & DS_EVD ? true : false;
	Word	*pOldWords = CreatWordFromMem( bEvd ? param.olddoc->EVDParaText( pPara ) : ParaText(pPara), bEvd ? param.olddoc->EVDTextSize( pPara ) : TextSize(pPara), m_thread, pOBUF[m_thread]);

	DiffHandler	DH( pOldWords, pNewWords, m_thread );
	DH.MakeDiff( pfTmp1, pfTmp2 );

	delete [] pOldWords;
	delete [] pNewWords;

	fwrite(" ", 1, 1, pfTmp1);
	fwrite(" ", 1, 1, pfTmp2);

	fflush ( pfTmp1 );
	fflush ( pfTmp2 );
		
	rewind ( pfTmp1 );
	rewind ( pfTmp2 );

	// redirect TextDiff into DF1
	SkipUnDiff ( pfTmp1, pfTmp2, m_DFile1, 1, m_thread );

	// Идем на начало файлов
	rewind ( pfTmp1 );
	rewind ( pfTmp2 );
}

void Full::DeltaNewPara ( DeltaParams& param )
{
	const char *  pPara = param.newdoc->GetPara( param.newpos );
	assert ( pPara );

	const char *  pParaText = ParaText ( pPara );
	short   sTextSize = TextSize ( pPara );
	char    cSaveOrder = O_PAR_NEW | O_HDR_STYLE | O_HDR_TSTART | O_HDR_LMARGIN | O_HDR_RMARGIN | O_HDR_REDLINE;

	fwrite ( &cSaveOrder, sizeof (char), 1, m_DFile1 );    // NEW para
	SaveParaHeader ( pPara , cSaveOrder );
	fwrite ( &sTextSize, sizeof (short), 1, m_DFile1 );    // new SIZE
	fwrite ( pParaText, 1, sTextSize, m_DFile1 );        // new TEXT
}

char Full::GetStyleOrder ( DeltaParams& param )
{
	char cMaskOrder = 0;

	const char* pOldPara = param.olddoc->GetPara( param.oldpos );
	assert ( pOldPara );

	const char* pNewPara = param.newdoc->GetPara( param.newpos );
	assert ( pNewPara );

	if ( ParaStyle ( pOldPara ) != ParaStyle ( pNewPara ) ) cMaskOrder |= O_HDR_STYLE;
	if ( HeaderSize ( pOldPara ) != HeaderSize ( pNewPara ) ) cMaskOrder |= O_HDR_TSTART;
	if ( LeftMargin ( pOldPara ) != LeftMargin ( pNewPara ) ) cMaskOrder |= O_HDR_LMARGIN;
	if ( RightMargin ( pOldPara ) != RightMargin ( pNewPara ) ) cMaskOrder |= O_HDR_RMARGIN;
	if ( RedLine ( pOldPara ) != RedLine ( pNewPara ) ) cMaskOrder |= O_HDR_REDLINE;

	bool bOldEvd = param.olddoc->stat.Status & DS_EVD ? true : false;
	bool bNewEvd = param.newdoc->stat.Status & DS_EVD ? true : false;

	if ( bOldEvd != bNewEvd )
		cMaskOrder |= O_HDR_EVD;
	else {
		if ( bOldEvd && bNewEvd ) {
			short oldSize = param.olddoc->EVDHeaderSize( pOldPara );
			short newSize = param.newdoc->EVDHeaderSize( pNewPara );
			if ( oldSize != newSize )
				cMaskOrder |= O_HDR_EVD;
			else {
				char* oldHeader = param.olddoc->EVDHeader( pOldPara );
				char* newHeader = param.newdoc->EVDHeader( pNewPara );
				if ( memcmp( oldHeader, newHeader, oldSize ))
					cMaskOrder |= O_HDR_EVD;
			}
		}
	}

	return cMaskOrder;
}

void Full::SaveParaHeader ( const char* pPara, char cSaveMask, DummyDoc* newdoc )
{
	assert ( pPara );

	char cStyle = ParaStyle ( pPara );
	short sTStart = HeaderSize ( pPara );
	char cLMargin = LeftMargin ( pPara );
	char cRMargin = RightMargin ( pPara );
	char cRedLine = RedLine ( pPara );

	if ( cSaveMask & O_HDR_STYLE ) fwrite ( &cStyle, sizeof ( char ), 1, m_DFile1 );
	if ( cSaveMask & O_HDR_TSTART ) fwrite ( &sTStart, sizeof ( short ), 1, m_DFile1 );
	if ( cSaveMask & O_HDR_LMARGIN ) fwrite ( &cLMargin, sizeof ( char ), 1, m_DFile1 );
	if ( cSaveMask & O_HDR_RMARGIN ) fwrite ( &cRMargin, sizeof ( char ), 1, m_DFile1 );
	if ( cSaveMask & O_HDR_REDLINE ) fwrite ( &cRedLine, sizeof ( char ), 1, m_DFile1 );
	if ( (unsigned char)cSaveMask & O_HDR_EVD ) {
		short size = newdoc->EVDHeaderSize( pPara );
		fwrite( &size, sizeof( short ), 1, m_DFile1 );
		char* header = newdoc->EVDHeader( pPara );
		fwrite( header, size, 1, m_DFile1 );
	}
}

bool Full::DeltaNewDoc ()
{
	bool result = false;
	if (b_texts_only)
		return result;

	if (!b_gctx_attrs_only) {
		FillCorrList ( m_lDocId );
		g_cordocs.insert (m_lDocId);
	}

	std::map<long,char*>::const_iterator map_doc_packeddata_it = map_newdoc_packeddata.find (m_lDocId);
	std::map<long,char*>::const_iterator map_doc_unpackeddata_it = map_newdoc_unpackeddata.find (m_lDocId);
	std::map<long,long>::const_iterator packedsize_it = map_newdoc_packedsize.find (m_lDocId);
	std::map<long,long>::const_iterator unpackedsize_it = map_newdoc_unpackedsize.find (m_lDocId);
	long packed_size = packedsize_it == map_newdoc_packedsize.end () ? 0 : packedsize_it->second;
	long unpacked_size = unpackedsize_it == map_newdoc_unpackedsize.end () ? 0 : unpackedsize_it->second;

	if (b_prepack || b_daily || (!b_prepack && !b_pack_delta)) {// We have no entry in DiffHolder - Make and Save ChgDoc Diff
		// Open DiffHolder for this DocId
		Stream *pStr2 = m_pDiffHolder[m_thread]->idx2->Open (&m_lDocId, 1);
		if (b_pack_delta) {
			logger.printf (lt_fatal, "No entry in m_pDiffHolder[%ld] for doc %ld\n", m_thread, m_lDocId);
			exit (EXIT_FAILURE);
		}
		// remember DF1 and Attr-tmp file pos before saving delta
		u_int64_t fptDF1StartPos, fptDF1EndPos;
		fptDF1StartPos = _ftelli64 (m_DFile1);

		u_int64_t	fptAttrStartPos, fptAttrEndPos;
		fptAttrStartPos = _ftelli64 (m_AttrFile);

		// Saving Block for DF1 and Attrs starts here !
		char	*pAttrMask = new char [ MAX_LEVEL ];
		// here we fill Attrs-tmp file
		int iMaskLevelCount = CreateAttrDiff ( m_lDocId, pAttrMask, 1 );
		pAttrMask[0] |= O_DOC_NEW;

		for ( int i = 0; i < iMaskLevelCount; i++ )
			fwrite ( &pAttrMask [i], sizeof ( char ), 1, m_DFile1 );

		delete pAttrMask;

		fwrite ( &m_NewDocInfo.Revision, sizeof ( revision ), 1, m_DFile1 ); // New Revision
		fwrite ( &m_NewDocInfo.ParaCount, sizeof ( long ), 1, m_DFile1 );   // para COUNT

		Document	*newdoc = m_pNewBase->GetDoc (m_lDocId);
		assert (newdoc);

		for ( long j = 0; j < newdoc->Stat.ParaCount; j++ ) {
			char *  pNewPara = newdoc->GetPara ( j );
			short   siNewParaSize = ParaSize ( pNewPara ) + 3;

			fwrite ( &siNewParaSize, sizeof ( short ), 1, m_DFile1 );               // para SIZE
			fwrite ( pNewPara, 1, siNewParaSize, m_DFile1 );   // para BODY
		}

		delete newdoc;

		// Moving Diff-Block from Attr-tmp file into DF1 file
		fptAttrEndPos = _ftelli64 (m_AttrFile);

		void * pBuffAttr = malloc ( (fptAttrEndPos - fptAttrStartPos) & 0xFFFFFFFF);
		assert ( pBuffAttr );
		_fseeki64 ( m_AttrFile, fptAttrStartPos, ACE_OS_SEEK_SET );
		fread ( pBuffAttr, 1, (fptAttrEndPos - fptAttrStartPos) & 0xFFFFFFFF, m_AttrFile );
		_fseeki64 ( m_AttrFile, fptAttrEndPos, ACE_OS_SEEK_SET );

		fwrite ( pBuffAttr, 1, (fptAttrEndPos - fptAttrStartPos) & 0xFFFFFFFF, m_DFile1 );
		free ( pBuffAttr );

		// Save DF1 blocks into DiffHolder
		fptDF1EndPos = _ftelli64 (m_DFile1); // Saving Block for DF1 ends here !

		void * pBuff2 = malloc ( (fptDF1EndPos - fptDF1StartPos) & 0xFFFFFFFF );
		assert ( pBuff2 );
		_fseeki64 ( m_DFile1, fptDF1StartPos, ACE_OS_SEEK_SET );
		fread ( pBuff2, 1, (fptDF1EndPos - fptDF1StartPos) & 0xFFFFFFFF, m_DFile1 );
		_fseeki64 ( m_DFile1, fptDF1EndPos, ACE_OS_SEEK_SET );

		if (b_prepack) {
			if (b_single_cache) {
				GUARD (cache_mutex);
				pStr2 = m_pDiffHolder[0]->idx2->Open (&m_lDocId, 1);
				pStr2 -> Write (pBuff2, (size_t)(fptDF1EndPos - fptDF1StartPos));
				m_pDiffHolder[0]->idx2->Close (pStr2);
			} else {
				pStr2 = m_pDiffHolder[m_thread]->idx2->Open (&m_lDocId, 1);
				pStr2 -> Write (pBuff2, (size_t)(fptDF1EndPos - fptDF1StartPos));
				m_pDiffHolder[m_thread]->idx2->Close (pStr2);
			}
		}

		free ( pBuff2 );
	} else {
		// TxtDiff exist in DiffHolder - Read it
		void * pBuff2 = map_doc_unpackeddata_it->second;
		long lSize2 = unpacked_size;

		char *new_packed_buf = 0;
		long new_packed_size = 0;
		if (b_pack_delta && unpacked_size && packed_size) {
			new_packed_buf = map_doc_packeddata_it->second;
			new_packed_size = packed_size;
		}
		if (new_packed_size == 0)
			fwrite (pBuff2, 1, lSize2, m_DFile1);
		else {
			//записать размер распакованной части
			fwrite (&lSize2, sizeof (long), 1, m_DFile1);
			//записать первый байт маски, нужен gdm
			fwrite (pBuff2, 1, 1, m_DFile1);
			fwrite (new_packed_buf, 1, new_packed_size, m_DFile1);
			result = true;
		}
	}

	return result;
}

char Full::ChgStatus ()
{
	DocInfo docInfo;

	if (m_pNewBase->FindDocAttr(m_lDocId,IDD_INFO,(char*)&docInfo,sizeof(docInfo)) != sizeof(docInfo) ) 
		return 0;
	short newDSDoc = docInfo.Status & (DS_DOC|DS_NODOC|DS_EDITION);

	if (m_pOldBase->FindDocAttr(m_lDocId,IDD_INFO,(char*)&docInfo,sizeof(docInfo)) != sizeof(docInfo) )
		return 0;
	short oldDSDoc = docInfo.Status & (DS_DOC|DS_NODOC|DS_EDITION);

	if ( oldDSDoc == newDSDoc ) return 0;
	if ( ( oldDSDoc & DS_NODOC ) && !( oldDSDoc & DS_EDITION )) return M_STAT_DOC;
	else if ( ( oldDSDoc & DS_EDITION ) && ( newDSDoc & DS_DOC )) return 0;
	else if ( ( oldDSDoc & DS_DOC ) && ( newDSDoc & DS_EDITION )) return 0;
	else return M_STAT_NODOC;
}

int Full :: SaveRefIndDiff ( char* pIndName, long lDocId, int bNewDoc )
{
	StorableSplaySet<Ref> oldref;
	StorableSplaySet<Ref> newref;
		
	Stream * str = bNewDoc?0:m_pOldBase->FindIndex(pIndName)->Open(&lDocId);
	if (str) {
		oldref.Get (str);
		m_pOldBase->FindIndex(pIndName)->Close(str);
	}

	str = m_pNewBase->FindIndex(pIndName)->Open(&lDocId);
	if (str) {
		newref.Get (str);
		m_pNewBase->FindIndex(pIndName)->Close(str);
	}

	if ( newref != oldref ) {
		StorableSplaySet<Ref> andref;

		(andref = newref) &= oldref;
		oldref -= andref;
		newref -= andref;

		long count = oldref.length();			
		fwrite ( &count, sizeof ( count ), 1, m_AttrFile );			
		
		Point p;
		for ( p = oldref.first(); p; oldref.next(p) )
			fwrite ( oldref[p], sizeof ( Ref ), 1, m_AttrFile );
		
		count = newref.length();			
		fwrite ( &count, sizeof ( count ), 1, m_AttrFile );			
		for ( p = newref.first(); p; newref.next(p) )
			fwrite ( newref[p], sizeof ( Ref ), 1, m_AttrFile );
		
		return 1;
	}
	return 0;
}

Core::Mutex control_mutex;
std::vector<date> control_dates;
std::vector<void*> control_diff;
std::vector<long> control_diff_size;
long	control_diffCount;

int	Full::DiffControl (Base* old_base, Base* new_base, long thread_id)
{
	GUARD (control_mutex);
	if (control_dates.size () == 0) {
		char message [128];
		sprintf (message, "Построение дельты Control, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		Index* oldind = old_base->FindIndex( "Control" );
		Index* newind = new_base->FindIndex( "Control" );

		long diffCount = 0;
		u_int64_t fpCountPos = _ftelli64 (m_DFile1);
		fwrite (&diffCount, sizeof ( diffCount ), 1, m_DFile1 ); //count dummy

		long aCommonLength = 0;
		if (!b_gctx_attrs_only) {
		for (BTIterator it(newind); ! it.End(); ++it) {
			const void *k = it.Key();
			Stream* str = oldind->Index::OpenN( k, 0 );
			if ( str ) {
				oldind->Close(str);
				continue;
			}
			str = newind->Index::OpenN( k, 0 );
			if (str) {
				//новый ключ, его в дельту
				diffCount++;
				fwrite ( k, sizeof (date), 1, m_DFile1 );
				control_dates.push_back (*(date*)k);
				long aLength = str->Length();
				aCommonLength += aLength;
				fwrite ( &aLength, sizeof( aLength ), 1, m_DFile1 );
				void gk_huge* aData = gk_malloc (aLength);
				str->Read( aData, aLength );
				control_diff.push_back (aData);
				control_diff_size.push_back (aLength);
				newind->Close(str);
				fwrite( aData, aLength, 1, m_DFile1 );
			}
		}
		}

		u_int64_t fpCurrentPos = _ftelli64 (m_DFile1);
		_fseeki64 (m_DFile1, fpCountPos, ACE_OS_SEEK_SET);
		fwrite ( &diffCount, sizeof ( diffCount ), 1, m_DFile1 );
		_fseeki64 (m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET);
		control_diffCount = diffCount;

		logger.printf ( lt_deltaInfo, "Control diff count = %ld, Length = %ld\n", diffCount, aCommonLength );
	} else {
		char message [128];
		sprintf (message, "Запись дельты Control, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		fwrite (&control_diffCount, sizeof (control_diffCount), 1, m_DFile1);
		std::vector<date>::const_iterator date_it = control_dates.begin ();
		std::vector<void*>::const_iterator diff_it = control_diff.begin ();
		std::vector<long>::const_iterator size_it = control_diff_size.begin ();
		for (; date_it != control_dates.end (); date_it++, diff_it++, size_it++) {
			fwrite (&(*date_it), sizeof (date), 1, m_DFile1);
			fwrite (&(*size_it), sizeof (long), 1, m_DFile1);
			fwrite (*diff_it, *size_it, 1, m_DFile1);
		}
	}

	return 1;
}

Core::Mutex kindCorr_mutex;
long	kindCorr_size = -1;
char*	kindCorr_diff = 0;

int	Full::DiffKindCorr (Base* old_base, Base* new_base, long thread_id)
{
	GUARD (kindCorr_mutex);
	long diffCount = 0;
	if (kindCorr_size == -1) {
		char message [128];
		sprintf (message, "Построение дельты KindCorr, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		Index* oldind = old_base->FindIndex ("KindCorr");
		Index* newind = new_base->FindIndex ("KindCorr");
		u_int64_t fpCountPos = _ftelli64 (m_DFile1);
		fwrite ( &diffCount, sizeof ( diffCount ), 1, m_DFile1 );

		std::vector<u_int64_t> del_refs;
		std::map<u_int64_t, std::vector<KindCorrRef> > chg_refs_del, chg_refs_add, new_refs;
		if (!b_gctx_attrs_only) {
			BTIterator oldit (oldind), newit (newind);
			while (!oldit.End () && !newit.End ()) {
				Ref oldref = *(Ref*)oldit.Key ();
				Ref newref = *(Ref*)newit.Key ();
				if (oldref.DocId < newref.DocId) {
					//удаленный
					if ((m_deldocs && g_deldocs.find (oldref.DocId) != g_deldocs.end ()) || !m_deldocs) {
						u_int64_t del_ref = (((u_int64_t)oldref.DocId) << 32) + oldref.Sub;
						del_refs.push_back (del_ref);
					}
					++oldit;
				} else
				if (oldref.DocId == newref.DocId) {
					if (oldref.Sub < newref.Sub) {
						if ((m_deldocs && g_deldocs.find (oldref.DocId) != g_deldocs.end ()) || !m_deldocs) {
							u_int64_t del_ref = (((u_int64_t)oldref.DocId) << 32) + oldref.Sub;
							del_refs.push_back (del_ref);
						}
						++oldit;
					} else
					if (oldref.Sub > newref.Sub) {
						Stream* new_str = newind->Open (newit.Key ());
						if (new_str) {
							std::vector<KindCorrRef> masks;
							for (unsigned int i = 0; i < new_str->Length () / sizeof (KindCorrRef); i++) {
								KindCorrRef mask;
								new_str->Read (&mask, sizeof (mask));
								masks.push_back (mask);
							}
							newind->Close (new_str);
							u_int64_t new_ref = (((u_int64_t)newref.DocId) << 32) + newref.Sub;
							new_refs.insert (std::map<u_int64_t, std::vector<KindCorrRef> >::value_type (new_ref, masks));
						}

						++newit;
					} else {
						StorableSplaySet<KindCorrRef> *old_set = new StorableSplaySet<KindCorrRef>;
						StorableSplaySet<KindCorrRef> *new_set = new StorableSplaySet<KindCorrRef>;
						Stream* old_str = oldind->Open (oldit.Key ());
						if (old_str) {
							old_set->Get (old_str);
							oldind->Close (old_str);
						}
						Stream* new_str = newind->Open (newit.Key ());
						if (new_str) {
							new_set->Get (new_str);
							newind->Close (new_str);
						}

						StorableSplaySet<KindCorrRef> *and_set = new StorableSplaySet<KindCorrRef>;
					
						and_set->set_copy (new_set);
						and_set->set_and (old_set);
						old_set->set_minus (and_set);
						new_set->set_minus (and_set);

						if (old_set->length () || new_set->length ()) {
							std::vector<KindCorrRef> del_masks, add_masks;
							for ( Point dels = old_set->first (); dels; old_set->next (dels)) {
								const KindCorrRef *at_dels = (*old_set)[dels];
								del_masks.push_back (*at_dels);
							}
							for ( Point adds = new_set->first (); adds; new_set->next (adds)) {
								const KindCorrRef *at_adds = (*new_set)[adds];
								add_masks.push_back (*at_adds);
							}

							u_int64_t chg_ref = (((u_int64_t)newref.DocId) << 32) + newref.Sub;
							if (del_masks.size ())
								chg_refs_del.insert (std::map<u_int64_t, std::vector<KindCorrRef> >::value_type (chg_ref, del_masks));
							if (add_masks.size ())
								chg_refs_add.insert (std::map<u_int64_t, std::vector<KindCorrRef> >::value_type (chg_ref, add_masks));
						}

						delete old_set;
						delete new_set;
						delete and_set;

						++oldit;
						++newit;
					}
				} else {
					//новый
					Stream* new_str = newind->Open (newit.Key ());
					if (new_str) {
						std::vector<KindCorrRef> masks;
						for (unsigned int i = 0; i < new_str->Length () / sizeof (KindCorrRef); i++) {
							KindCorrRef mask;
							new_str->Read (&mask, sizeof (mask));
							masks.push_back (mask);
						}
						newind->Close (new_str);
						u_int64_t new_ref = (((u_int64_t)newref.DocId) << 32) + newref.Sub;
						new_refs.insert (std::map<u_int64_t, std::vector<KindCorrRef> >::value_type (new_ref, masks));
					}
					++newit;
				}
			}
			while (!oldit.End ()) {
				Ref oldref = *(Ref*)oldit.Key ();
				//удаленный
				if ((m_deldocs && g_deldocs.find (oldref.DocId) != g_deldocs.end ()) || !m_deldocs) {
					u_int64_t del_ref = (((u_int64_t)oldref.DocId) << 32) + oldref.Sub;
					del_refs.push_back (del_ref);
				}
				++oldit;
			}
			while (!newit.End ()) {
				Ref newref = *(Ref*)newit.Key ();
				Stream* new_str = newind->Open (newit.Key ());
				if (new_str) {
					std::vector<KindCorrRef> masks;
					for (unsigned int i = 0; i < new_str->Length () / sizeof (KindCorrRef); i++) {
						KindCorrRef mask;
						new_str->Read (&mask, sizeof (mask));
						masks.push_back (mask);
					}
					newind->Close (new_str);
					u_int64_t new_ref = (((u_int64_t)newref.DocId) << 32) + newref.Sub;
					new_refs.insert (std::map<u_int64_t, std::vector<KindCorrRef> >::value_type (new_ref, masks));
				}
				++newit;
			}
		}

		//сначала пишем удаленные
		long count = del_refs.size ();
		fwrite (&count, sizeof (count), 1, m_DFile1);
		diffCount += sizeof (count);
		for (std::vector<u_int64_t>::const_iterator it = del_refs.begin (); it != del_refs.end (); it++) {
			u_int64_t del = *it;
			fwrite (&del, sizeof (del), 1, m_DFile1);
			diffCount += sizeof (del);
		}
		// пимем новые
		count = new_refs.size ();
		fwrite (&count, sizeof (count), 1, m_DFile1);
		diffCount += sizeof (count);
		for (std::map<u_int64_t, std::vector<KindCorrRef> >::const_iterator new_it = new_refs.begin (); new_it != new_refs.end (); new_it++) {
			u_int64_t new_ref = new_it->first;
			fwrite (&new_ref, sizeof (new_ref), 1, m_DFile1);
			diffCount += sizeof (new_ref);
			long count = new_it->second.size ();
			fwrite (&count, sizeof (count), 1, m_DFile1);
			diffCount += sizeof (count);
			for (std::vector<KindCorrRef>::const_iterator it = new_it->second.begin (); it != new_it->second.end (); it++) {
				KindCorrRef to_write = *it;
				fwrite (&to_write, sizeof (to_write), 1, m_DFile1);
				diffCount += sizeof (to_write);
			}
		}
		// пишем измененные
		std::map<u_int64_t,std::vector<KindCorrRef> >::const_iterator map_it;
		std::set<u_int64_t> ids;
		for (map_it = chg_refs_del.begin (); map_it != chg_refs_del.end (); map_it++)
			ids.insert (map_it->first);
		for (map_it = chg_refs_add.begin (); map_it != chg_refs_add.end (); map_it++)
			ids.insert (map_it->first);
		count = ids.size ();
		fwrite (&count, sizeof (count), 1, m_DFile1);
		diffCount += sizeof (count);
		for (std::set<u_int64_t>::const_iterator ids_it = ids.begin (); ids_it != ids.end (); ids_it++) {
			u_int64_t id = *ids_it;
			fwrite (&id, sizeof (id), 1, m_DFile1);
			diffCount += sizeof (id);
			map_it = chg_refs_del.find (id);
			if (map_it == chg_refs_del.end ()) {
				long del_count = 0;
				fwrite (&del_count, sizeof (del_count), 1, m_DFile1);
				diffCount += sizeof (del_count);
			} else {
				long del_count = map_it->second.size ();
				fwrite (&del_count, sizeof (del_count), 1, m_DFile1);
				diffCount += sizeof (del_count);
				for (std::vector<KindCorrRef>::const_iterator del_it = map_it->second.begin (); del_it != map_it->second.end (); del_it++) {
					KindCorrRef to_del = *del_it;
					fwrite (&to_del, sizeof (to_del), 1, m_DFile1);
					diffCount += sizeof (to_del);
				}
			}
			map_it = chg_refs_add.find (id);
			if (map_it == chg_refs_add.end ()) {
				long add_count = 0;
				fwrite (&add_count, sizeof (add_count), 1, m_DFile1);
				diffCount += sizeof (add_count);
			} else {
				long add_count = map_it->second.size ();
				fwrite (&add_count, sizeof (add_count), 1, m_DFile1);
				diffCount += sizeof (add_count);
				for (std::vector<KindCorrRef>::const_iterator add_it = map_it->second.begin (); add_it != map_it->second.end (); add_it++) {
					KindCorrRef to_add = *add_it;
					fwrite (&to_add, sizeof (to_add), 1, m_DFile1);
					diffCount += sizeof (to_add);
				}
			}
		}

		u_int64_t fpCurrentPos = _ftelli64 (m_DFile1);
		_fseeki64 (m_DFile1, fpCountPos, ACE_OS_SEEK_SET);
		fwrite (&diffCount, sizeof (diffCount), 1, m_DFile1);
		fflush (m_DFile1);

		if (diffCount > 12) {
			kindCorr_size = diffCount;
			kindCorr_diff = (char*) malloc (kindCorr_size);
			fread (kindCorr_diff, kindCorr_size, 1, m_DFile1);

			char* kindCorr_packed = (char*) malloc (kindCorr_size + sizeof (long) + 100);
			long unpacked_size = kindCorr_size, packed_size = G_ZIP (kindCorr_diff, unpacked_size, kindCorr_packed + sizeof (long), kindCorr_size + 100);
			if (0 == packed_size) {
				packed_size = unpacked_size;
				memcpy (kindCorr_packed + sizeof (long), kindCorr_diff, unpacked_size);
			}
			*(long*) kindCorr_packed = kindCorr_size;

			diffCount = packed_size + sizeof (long);
			free (kindCorr_diff);
			kindCorr_diff = kindCorr_packed;

			logger.printf ( lt_deltaInfo, "KindCorr diff packed size = %ld, unpacked_size = %ld\n", packed_size, unpacked_size);
			_fseeki64 ( m_DFile1, fpCountPos, ACE_OS_SEEK_SET);
			fwrite (&diffCount, sizeof (diffCount), 1, m_DFile1);
			fwrite (kindCorr_diff, diffCount, 1, m_DFile1);
			fflush (m_DFile1);
		} else {
			kindCorr_diff = (char*) malloc (diffCount);
			fread (kindCorr_diff, diffCount, 1, m_DFile1);
			_fseeki64 (m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET);
		}

		kindCorr_size = diffCount;
	} else {
		char message [128];
		sprintf (message, "Запись дельты KindCorr, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);
		diffCount = kindCorr_size;
		fwrite ( &diffCount, sizeof (diffCount), 1, m_DFile1);
		if (kindCorr_diff)
			fwrite (kindCorr_diff, kindCorr_size, 1, m_DFile1);
	}

	logger.flush (lt_always);
	return 1;
}

extern	std::map<long, std::vector<CorrRef> > map_old_newcorr, map_new_newcorr;
extern	std::map<long, std::vector<Ref> > map_old_corr, map_new_corr;

inline int operator	== (CorrRef& a, CorrRef& b ) {
	return !memcmp (&a, &b, sizeof (CorrRef));
}

int Full::DiffNewCorr (Base* old_base, Base* new_base, long thread_id)
{
	long diffCount = 0;
	u_int64_t fpCountPos = _ftelli64 (m_DFile1), fpCurrentPos;
	fwrite ( &diffCount, sizeof ( diffCount ), 1, m_DFile1 );

	if (b_buildNewCorrDiff && !b_gctx_attrs_only) {
		Index* oldind = old_base->FindIndex ( "NewCorr" );
		Index* newind = new_base->FindIndex ( "NewCorr" );
		ProgressScreen* screen = GetProgressScreen();
		screen->SetProgress(0);

		char message [128];
		sprintf (message, "Построение дельты индекса NewCorr, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		long count = g_cordocs.size (), pos = 1, old_perc = -1;
		for (std::set<long>::const_iterator cor_it = g_cordocs.begin (); cor_it != g_cordocs.end (); cor_it++, pos++ ) {
			long docId = *cor_it, new_perc = ( pos * 100 ) / count, b_empty_oldcorr = 1;
			if (new_perc != old_perc) screen->SetProgress (old_perc = new_perc);
			std::deque<CorrRef> oldcorr, newcorr;
			if (map_old_newcorr.size ()) {
				std::map<long, std::vector<CorrRef> >::const_iterator map_it = map_old_newcorr.find (docId);
				if (map_it != map_old_newcorr.end ()) {
					b_empty_oldcorr = 0;
					for (std::vector<CorrRef>::const_iterator corr_it = map_it->second.begin (); corr_it != map_it->second.end (); corr_it++) {
						CorrRef ref = *corr_it;
						if ( g_equdocs.find (ref.DocId) != g_equdocs.end () || g_chgdocs.find (ref.DocId) != g_chgdocs.end () || g_deldocs.find (ref.DocId) != g_deldocs.end ())
							oldcorr.push_back (ref);
					}
				}
			} else {
				Stream * str = oldind->Open ( &docId );
				if (str) {
					b_empty_oldcorr = 0;
					long count = str->Length() / sizeof ( CorrRef );
					for ( long l=0; l<count; l++ ) {
						CorrRef ref;
						str->Read ( &ref, sizeof(ref) );
						if ( g_equdocs.find (ref.DocId) != g_equdocs.end () || g_chgdocs.find (ref.DocId) != g_chgdocs.end () || g_deldocs.find (ref.DocId) != g_deldocs.end ())
							oldcorr.push_back (ref);
					}
					oldind->Close ( str );
				}
			}

			if (map_new_newcorr.size ()) {
				std::map<long, std::vector<CorrRef> >::const_iterator map_it = map_new_newcorr.find (docId);
				if (map_it != map_new_newcorr.end ()) {
					for (std::vector<CorrRef>::const_iterator corr_it = map_it->second.begin (); corr_it != map_it->second.end (); corr_it++) {
						CorrRef ref = *corr_it;
						if (b_empty_oldcorr || (g_equdocs.find (ref.DocId) != g_equdocs.end ()) || (g_chgdocs.find (ref.DocId) != g_chgdocs.end ()) || (g_newdocs.find (ref.DocId) != g_newdocs.end ()))
							newcorr.push_back (ref);
					}
				}
			} else {
				Stream *str = newind->Open ( &docId );
				if ( str ) {
					long count = str->Length() / sizeof ( CorrRef );
					for ( long l=0; l<count; l++) {
						CorrRef ref;
						str->Read (&ref, sizeof (ref));
						if (b_empty_oldcorr || g_equdocs.find (ref.DocId) != g_equdocs.end () || g_chgdocs.find (ref.DocId) != g_chgdocs.end () || g_newdocs.find (ref.DocId) != g_newdocs.end ())
							newcorr.push_back (ref);
					}
					newind->Close ( str );
				}
			}
			
			if (oldcorr.size () != newcorr.size () || !std::equal (oldcorr.begin (), oldcorr.end (), newcorr.begin ())) {
				std::vector<CorrRef> andset;
				std::set_intersection (oldcorr.begin (), oldcorr.end (), newcorr.begin (), newcorr.end (), std::back_inserter (andset));

				diffCount++;
				fwrite ( &docId, sizeof ( docId ), 1, m_DFile1 );

				std::vector<CorrRef> oldcorrd, newcorrd;
				std::set_difference (oldcorr.begin (), oldcorr.end (), andset.begin (), andset.end (), std::back_inserter (oldcorrd));
				std::set_difference (newcorr.begin (), newcorr.end (), andset.begin (), andset.end (), std::back_inserter (newcorrd));

				std::vector<CorrRef> andcorr;
				if ( m_ids.length() == 1 && m_ids.contents(m_ids.first()) != 0 ) {
					std::set<long> deleted_ids;
					std::vector<CorrRef>::const_iterator corr_it;
					for (corr_it = oldcorrd.begin (); corr_it != oldcorrd.end (); corr_it++)
						deleted_ids.insert (corr_it->DocId);
					for (corr_it = newcorrd.begin (); corr_it != newcorrd.end (); corr_it++)
						deleted_ids.insert (corr_it->DocId);
					for (corr_it = andset.begin (); corr_it != andset.end (); corr_it++) {
						CorrRef at = *corr_it;
						if (deleted_ids.find (at.DocId) != deleted_ids.end ())
							andcorr.push_back (at);
					}
				}

				std::vector<CorrRef>::const_iterator corr_it;
				long count = oldcorrd.size ();
				fwrite ( &count, sizeof (count), 1, m_DFile1);
				for (corr_it = oldcorrd.begin (); corr_it != oldcorrd.end (); corr_it++) {
					const CorrRef at = *corr_it;
					fwrite (&at, sizeof (CorrRef), 1, m_DFile1);
				}

				count = newcorrd.size ();
				fwrite (&count, sizeof (count), 1, m_DFile1);
				for (corr_it = newcorrd.begin (); corr_it != newcorrd.end (); corr_it++) {
					const CorrRef at = *corr_it;
					fwrite (&at, sizeof (CorrRef), 1, m_DFile1);
				}

				if (b_buildNewCorrDiff_hack) {
					std::vector<CorrRef> andcorr2;
					for (corr_it = andcorr.begin (); corr_it != andcorr.end (); corr_it++) {
						const CorrRef at = *corr_it;
						long doc_id = at.DocId;
						if (g_global_deldocs.find (doc_id) != g_global_deldocs.end ())
							andcorr2.push_back (at);
					}
					andcorr.swap (andcorr2);
				}

				count = andcorr.size ();
				fwrite (&count, sizeof (count), 1, m_DFile1);
				for (corr_it = andcorr.begin (); corr_it != andcorr.end (); corr_it++) {
					const CorrRef at = *corr_it;
					fwrite (&at, sizeof (CorrRef), 1, m_DFile1);
				}
			}
		}
	}

	fpCurrentPos = _ftelli64 (m_DFile1);
	_fseeki64 (m_DFile1, fpCountPos, ACE_OS_SEEK_SET);
	fwrite ( &diffCount, sizeof ( diffCount ), 1, m_DFile1 );
	_fseeki64 (m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET );

	logger.printf ( lt_deltaInfo, "Un-exist NewCorr diff count = %ld, size = %ld\n", diffCount, (fpCurrentPos - fpCountPos) & 0xFFFFFFFF);
	logger.flush (lt_always);
	return 1;
}

int Full::DiffCorrespondent (Base* old_base, Base* new_base, long thread_id)
{
	Index* oldind = old_base->FindIndex ( "Correspondent" );
	Index* newind = new_base->FindIndex ( "Correspondent" );

	char message [128];
	sprintf (message, "Построение дельты Correspondent, поток %ld", thread_id);
	GetProgressScreen()->SetMessage (message);

	long diffCount = 0;
	u_int64_t fpCountPos = _ftelli64 (m_DFile1);
	fwrite ( &diffCount, sizeof ( diffCount ), 1, m_DFile1 ); //count dummy

	if (!b_gctx_attrs_only) for (std::set<long>::const_iterator cor_it = g_cordocs.begin (); cor_it != g_cordocs.end (); cor_it++) {
		StorableSplaySet<Ref> *oldcorr = new StorableSplaySet<Ref>;
		StorableSplaySet<Ref> *newcorr = new StorableSplaySet<Ref>;

		long docId = *cor_it;
		if (map_old_corr.size ()) {
			std::map<long, std::vector<Ref> >::const_iterator map_it = map_old_corr.find (docId);
			if (map_it != map_old_corr.end ()) {
				for (std::vector<Ref>::const_iterator corr_it = map_it->second.begin (); corr_it != map_it->second.end (); corr_it++) {
					Ref ref = *corr_it;
					if ( g_equdocs.find (ref.DocId) != g_equdocs.end ())
						oldcorr->add ( ref );
					else if ( g_chgdocs.find (ref.DocId) != g_chgdocs.end ())
						oldcorr->add ( ref );
					else if ( g_deldocs.find (ref.DocId) != g_deldocs.end ())
						oldcorr->add ( ref );
				}
			}
		} else {
			Stream * str = oldind->Open ( &docId );
			if ( str ) {
				long count = str->Length() / sizeof ( Ref );

				for ( long l=0; l<count; l++ ) {
					Ref ref;
					str->Read ( &ref, sizeof(Ref) );
					
					if ( g_equdocs.find (ref.DocId) != g_equdocs.end ())
						oldcorr->add ( ref );
					else if ( g_chgdocs.find (ref.DocId) != g_chgdocs.end ())
						oldcorr->add ( ref );
					else if ( g_deldocs.find (ref.DocId) != g_deldocs.end ())
						oldcorr->add ( ref );
				}
				oldind->Close ( str );
			}
		}

		if (map_new_corr.size ()) {
			std::map<long, std::vector<Ref> >::const_iterator map_it = map_new_corr.find (docId);
			if (map_it != map_new_corr.end ()) {
				for (std::vector<Ref>::const_iterator corr_it = map_it->second.begin (); corr_it != map_it->second.end (); corr_it++) {
					Ref ref = *corr_it;
					if ( g_equdocs.find (ref.DocId) != g_equdocs.end ())
						newcorr->add ( ref );
					else if ( g_chgdocs.find (ref.DocId) != g_chgdocs.end ())
						newcorr->add ( ref );
					else if ( g_newdocs.find (ref.DocId) != g_newdocs.end ())
						newcorr->add ( ref );
				}
			}
		} else {
			Stream *str = newind->Open ( &docId );
			if ( str ) {
				long count = str->Length() / sizeof ( Ref );

				for ( long l=0; l<count; l++ ) {
					Ref ref;
					str->Read ( &ref, sizeof(Ref) );
					
					if ( g_equdocs.find (ref.DocId) != g_equdocs.end ())
						newcorr->add ( ref );
					else if ( g_chgdocs.find (ref.DocId) != g_chgdocs.end ())
						newcorr->add ( ref );
					else if ( g_newdocs.find (ref.DocId) != g_newdocs.end ())
						newcorr->add ( ref );
				}
				newind->Close ( str );
			}
		}

		if (newcorr != oldcorr) {
			diffCount++;
			fwrite ( &docId, sizeof ( docId ), 1, m_DFile1 );

			StorableSplaySet<Ref> *andSet = new StorableSplaySet<Ref>;
			andSet->set_copy (newcorr);
			andSet->set_and (oldcorr);
			oldcorr->set_minus (andSet);
			newcorr->set_minus (andSet);
						
			Point p;
			long count = oldcorr->length();			
			fwrite ( &count, sizeof ( count ), 1, m_DFile1 );
			
			for ( p = oldcorr->first(); p; oldcorr->next(p) )
				fwrite ( (*oldcorr)[p], sizeof ( Ref ), 1, m_DFile1 );

			count = newcorr->length();
			fwrite ( &count, sizeof ( count ), 1, m_DFile1 );
			
			for ( p = newcorr->first(); p; newcorr->next(p) )
				fwrite ( (*newcorr)[p], sizeof ( Ref ), 1, m_DFile1 );
		}
	}

	u_int64_t fpCurrentPos = _ftelli64 (m_DFile1);
	_fseeki64 (m_DFile1, fpCountPos, ACE_OS_SEEK_SET);
	fwrite ( &diffCount, sizeof ( diffCount ), 1, m_DFile1 );
	_fseeki64 (m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET);

	logger.printf ( lt_deltaInfo, "Un-exist Correspondent diff count = %ld, size = %ld\n", diffCount, (fpCurrentPos - fpCountPos) & 0xFFFFFFFF);
	return 1;
}

Core::Mutex typingerrors_mutex;
std::map<std::string,std::string> old_typing_errors;
std::set<std::string> old_good_words;
long	te_del_count = -1, te_add_count = -1;
std::vector<std::string> te_dels;
std::vector<std::string> te_add_1, te_add_2;

void	Full::DiffTypingErrors (SearchBase* old_base, SearchBase* new_base, long thread_id)
{
	GUARD (typingerrors_mutex);
	if (te_del_count == -1 && te_add_count == -1) {
		char message [128];
		sprintf (message, "Построение дельты TypingErrors, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		old_base->load_typing_errors ();
		old_typing_errors = *old_base->typing_errors_ptr;
		old_good_words = *old_base->good_words_ptr;
		old_base->typing_errors_ptr->clear ();
		old_base->good_words_ptr->clear ();
		old_base->typing_errors_ptr = &old_typing_errors;
		old_base->good_words_ptr = &old_good_words;

		new_base->load_typing_errors ();
		std::map<std::string,std::string>::const_iterator it, it2;
		std::vector<std::string> to_del;
		for (it = old_base->typing_errors_ptr->begin (); it != old_base->typing_errors_ptr->end (); it++) {
			it2 = new_base->typing_errors_ptr->find (it->first);
			if ((it2 == new_base->typing_errors_ptr->end ()) || (it2->second != it->second))
				to_del.push_back (it->first);
		}
		std::map<std::string,std::string> to_add;
		for (it = new_base->typing_errors_ptr->begin (); it != new_base->typing_errors_ptr->end (); it++) {
			it2 = old_base->typing_errors_ptr->find (it->first);
			if ((it2 == old_base->typing_errors_ptr->end ()) || (it2->second != it->second))
				to_add.insert (std::map<std::string,std::string>::value_type (it->first, it->second));
		}

		if (b_sbrf || b_daily || b_gctx_attrs_only) {
			to_del.clear ();
			to_add.clear ();
		}

		long del_count = to_del.size (), add_count = to_add.size ();
		fwrite (&del_count, sizeof (del_count), 1, m_DFile1);
		te_del_count = del_count;
		std::vector<std::string>::const_iterator i;
		for (i = to_del.begin (); i != to_del.end (); i++) {
			char *del_key = strdup (i->c_str ());
			fwrite (del_key, strlen (del_key) + 1, 1, m_DFile1);
			te_dels.push_back (del_key);
			gk_free (del_key);
		}

		fwrite (&add_count, sizeof (add_count), 1, m_DFile1);
		te_add_count = add_count;
		for (it = to_add.begin (); it != to_add.end (); it++) {
			char *add_key = strdup (it->first.c_str ());
			fwrite (add_key, strlen (add_key) + 1, 1, m_DFile1);
			te_add_1.push_back (add_key);
			gk_free (add_key);
			add_key = strdup (it->second.c_str ());
			fwrite (add_key, strlen (add_key) + 1, 1, m_DFile1);
			te_add_2.push_back (add_key);
			gk_free (add_key);
		}
	} else {
		char message [128];
		sprintf (message, "Запись дельты TypingErrors, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		fwrite (&te_del_count, sizeof (te_del_count), 1, m_DFile1);
		std::vector<std::string>::const_iterator it = te_dels.begin (), it2;
		for (; it != te_dels.end (); it++)
			fwrite (it->c_str (), it->size () + 1, 1, m_DFile1);

		fwrite (&te_add_count, sizeof (te_add_count), 1, m_DFile1);
		it = te_add_1.begin (), it2 = te_add_2.begin ();
		for (; it != te_add_1.end (); it++, it2++) {
			fwrite (it->c_str (), it->size () + 1, 1, m_DFile1);
			fwrite (it2->c_str (), it2->size () + 1, 1, m_DFile1);
		}
	}
}

void	Full::DiffReleFLaws (Base* old_base, Base* new_base, long thread_id)
{
	char message [128];
	sprintf (message, "Построение дельты ReleFLaws, поток %ld", thread_id);
	GetProgressScreen()->SetMessage (message);

	//список документов, которые добавляются к "нормативным актам" для слагаемого f формулы релевантности
	DocCollection old_laws, new_laws;
	Stream* str = old_base->FindIndex ("Aux")->Open (AUX_RELEF_LAWS);
	if ( str ) {
		old_laws.Get (str);
		old_base->FindIndex ("Aux")->Close (str);
	}

	str = new_base->FindIndex ("Aux")->Open (AUX_RELEF_LAWS);
	if ( str ) {
		new_laws.Get (str);
		new_base->FindIndex ("Aux")->Close (str);
	}

	DocCollection copy_old_laws; copy_old_laws.Merge (old_laws);
	old_laws.Minus (new_laws);
	new_laws.Minus (copy_old_laws);

	if (b_sbrf || b_daily || b_gctx_attrs_only) {
		old_laws.FreeAll ();
		new_laws.FreeAll ();
	}

	fwrite (&old_laws.ItemCount, sizeof (old_laws.ItemCount), 1, m_DFile1);
	long i;
	for (i = 0; i < old_laws.ItemCount; i++) {
		long id = old_laws [i];
		fwrite (&id, sizeof (id), 1, m_DFile1);
	}

	fwrite (&new_laws.ItemCount, sizeof (new_laws.ItemCount), 1, m_DFile1);
	for (i = 0; i < new_laws.ItemCount; i++) {
		long id = new_laws [i];
		fwrite (&id, sizeof (id), 1, m_DFile1);
	}
}

Core::Mutex goodwords_mutex;
long	gw_del_count = -1, gw_add_count = -1;
std::vector<std::string> gw_del_keys, gw_add_keys;

void	Full::DiffGoodWords (SearchBase* old_base, SearchBase* new_base, long thread_id)
{
	GUARD (goodwords_mutex);
	if (gw_del_count == -1 && gw_add_count == -1) {
		char message [128];
		sprintf (message, "Построение дельты GoodWords, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		std::set<std::string>::const_iterator it, it2;
		std::vector<std::string> to_del, to_add;
		for (it = old_base->good_words_ptr->begin (); it != old_base->good_words_ptr->end (); it++) {
			it2 = new_base->good_words_ptr->find (*it);
			if ((it2 == new_base->good_words_ptr->end ()) || (*it2 != *it))
				to_del.push_back (*it);
		}
		for (it = new_base->good_words_ptr->begin (); it != new_base->good_words_ptr->end (); it++) {
			it2 = old_base->good_words_ptr->find (*it);
			if ((it2 == old_base->good_words_ptr->end ()) || (*it2 != *it))
				to_add.push_back (*it);
		}

		if (b_sbrf || b_daily || b_gctx_attrs_only) {
			to_del.clear ();
			to_add.clear ();
		}

		long del_count = to_del.size (), add_count = to_add.size ();
		gw_del_count = del_count; gw_add_count = add_count;
		fwrite (&del_count, sizeof (del_count), 1, m_DFile1);
		std::vector<std::string>::const_iterator i;
		for (i = to_del.begin (); i != to_del.end (); i++) {
			char *del_key = strdup (i->c_str ());
			gw_del_keys.push_back (del_key);
			fwrite (del_key, strlen (del_key) + 1, 1, m_DFile1);
			gk_free (del_key);
		}
		fwrite (&add_count, sizeof (add_count), 1, m_DFile1);
		for (i = to_add.begin (); i != to_add.end (); i++) {
			char *add_key = strdup (i->c_str ());
			gw_add_keys.push_back (add_key);
			fwrite (add_key, strlen (add_key) + 1, 1, m_DFile1);
			gk_free (add_key);
		}
		new_base->typing_errors_ptr->clear ();
		new_base->good_words_ptr->clear ();
	} else {
		char message [128];
		sprintf (message, "Запись дельты GoodWords, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		std::vector<std::string>::const_iterator i;

		fwrite (&gw_del_count, sizeof (gw_del_count), 1, m_DFile1);
		for (i = gw_del_keys.begin (); i != gw_del_keys.end (); i++)
			fwrite (i->c_str (), i->size () + 1, 1, m_DFile1);

		fwrite (&gw_add_count, sizeof (gw_add_count), 1, m_DFile1);
		for (i = gw_add_keys.begin (); i != gw_add_keys.end (); i++)
			fwrite (i->c_str (), i->size () + 1, 1, m_DFile1);
	}
}

Core::Mutex morphohashes_mutex;
long	mh_addCount = -1;
std::vector<std::string> mh_first;
std::vector<unsigned long> mh_second;

int	Full::DiffMorphoHashes (Base* old_base, Base* new_base, long thread_id)
{
	GUARD (morphohashes_mutex);
	if (mh_addCount == -1) {
		char message [128];
		sprintf (message, "Построение дельты MorphoHashes, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		long old_size = 0, new_size = 0;
		char *old_strings = 0, *new_strings = 0;
		Stream* str = old_base->FindIndex ("Aux")->Open (AUX_MORPHO_HASHES);
		if ( str ) {
			old_size = str->Length ();
			old_strings = (char*) malloc (old_size);
			str->Read (old_strings, old_size);
			old_base->FindIndex ("Aux")->Close (str);
		}
		str = new_base->FindIndex ("Aux")->Open (AUX_MORPHO_HASHES);
		if ( str ) {
			new_size = str->Length ();
			new_strings = (char*) malloc (new_size);
			str->Read (new_strings, new_size);
			new_base->FindIndex ("Aux")->Close (str);
		}
		std::map<std::string,unsigned long> old_map_string_hash, new_map_string_hash;
		char *ptr = old_strings;
		while (ptr - old_strings < old_size) {
			old_map_string_hash.insert (std::map<std::string, unsigned long>::value_type (ptr, *(unsigned long*) (ptr + strlen (ptr) + 1)));
			ptr += strlen (ptr) + sizeof (unsigned long) + 1;
		}
		ptr = new_strings;
		while (ptr - new_strings < new_size) {
			new_map_string_hash.insert (std::map<std::string, unsigned long>::value_type (ptr, *(unsigned long*) (ptr + strlen (ptr) + 1)));
			ptr += strlen (ptr) + sizeof (unsigned long) + 1;
		}
		gk_free (old_strings);
		gk_free (new_strings);

		if (b_sbrf || b_daily || b_gctx_attrs_only) {
			new_map_string_hash.clear ();
		}

		int addCount = 0;
		std::map<std::string, unsigned long>::const_iterator it;
		for (it = new_map_string_hash.begin (); it != new_map_string_hash.end (); it++)
			if (old_map_string_hash.find (it->first) == old_map_string_hash.end ())
				addCount++;
		mh_addCount = addCount;

		fwrite (&addCount, sizeof (addCount), 1, m_DFile1);
		for (it = new_map_string_hash.begin (); it != new_map_string_hash.end (); it++)
			if (old_map_string_hash.find (it->first) == old_map_string_hash.end ()) {
				fwrite (it->first.c_str (), it->first.size ()+1, 1, m_DFile1);
				mh_first.push_back (it->first);
				fwrite (&it->second, sizeof (unsigned long), 1, m_DFile1);
				mh_second.push_back (it->second);
			}
	} else {
		char message [128];
		sprintf (message, "Запись дельты MorphoHashes, поток %ld", thread_id);
		GetProgressScreen()->SetMessage (message);

		fwrite (&mh_addCount, sizeof (mh_addCount), 1, m_DFile1);
		std::vector<std::string>::const_iterator str_it = mh_first.begin ();
		std::vector<unsigned long>::const_iterator long_it = mh_second.begin ();
		for (; str_it != mh_first.end (); str_it++, long_it++) {
			fwrite (str_it->c_str (), str_it->size ()+1, 1, m_DFile1);
			fwrite (&(*long_it), sizeof (unsigned long), 1, m_DFile1);
		}
	}

	return 1;
}

int	Full::DiffCVar(Base *old_base, Base* new_base, long thread_id)
{
	char message [128];
	sprintf (message, "Построение дельты CVar, поток %ld", thread_id);
	GetProgressScreen()->SetMessage (message);

	long old_size = 0, new_size = 0;
	char *old_strings = 0, *new_strings = 0;
	Stream* str = old_base->FindIndex ("Aux")->Open (AUX_CONTEXT_VARIANTS);
	if ( str ) {
		old_size = str->Length ();
		old_strings = (char*) malloc (old_size);
		str->Read (old_strings, old_size);
		old_base->FindIndex ("Aux")->Close (str);
	}
	str = new_base->FindIndex ("Aux")->Open (AUX_CONTEXT_VARIANTS);
	if ( str ) {
		new_size = str->Length ();
		new_strings = (char*) malloc (new_size);
		str->Read (new_strings, new_size);
		new_base->FindIndex ("Aux")->Close (str);
	}

	if (b_sbrf || b_daily || b_gctx_attrs_only)
		old_size = 0, new_size = 0;

	if (old_size + new_size) {
		int addCount = 0, delCount = 0;
		std::vector<std::string> old_vector, new_vector;
		char* ptr = old_strings;
		while (ptr - old_strings < old_size) {
			old_vector.push_back (ptr);
			ptr += strlen (ptr)+1;
		}
		ptr = new_strings;
		while (ptr - new_strings < new_size) {
			new_vector.push_back (ptr);
			ptr += strlen (ptr)+1;
		}

		//найти те, которые удалили (в старых есть, в новых - нет)
		std::vector<std::string>::const_iterator it_old, it_new;
		std::vector<long> del_positions, add_positions;
		long del_pos = 0, add_pos = 0;
		for (it_old = old_vector.begin (), it_new = new_vector.begin (); it_old != old_vector.end () && it_new != new_vector.end (); it_old++, del_pos++) {
			if (*it_old == *it_new) {
				it_new++;
			} else {
				del_positions.push_back (del_pos);
				delCount++;
			}
		}
		for (; it_old != old_vector.end (); it_old++, del_pos++, delCount++)
			del_positions.push_back (del_pos);

		//теперь из старых надо удалить те, которые удаляются
		for (std::vector<long>::reverse_iterator rit = del_positions.rbegin (); rit != del_positions.rend (); rit++) {
			long del_pos = *rit;
			old_vector.erase (old_vector.begin () + del_pos);
		}

		//теперь надо найти те, которые добавляются
		std::vector<std::string> add_strings;
		if (old_vector.size ()) {
			for (it_old = old_vector.begin (), it_new = new_vector.begin (); it_old != old_vector.end () && it_new != new_vector.end (); it_new++, add_pos++) {
				if (*it_old == *it_new) {
					it_old++;
				} else {
					add_positions.push_back (add_pos);
					add_strings.push_back (*it_new);
					addCount++;
				}
			}
			for (; it_new != new_vector.end (); it_new++, add_pos++, addCount++) {
				add_positions.push_back (add_pos);
				add_strings.push_back (*it_new);
			}
		} else {
			for (it_new = new_vector.begin (); it_new != new_vector.end (); it_new++, add_pos++, addCount++) {
				add_positions.push_back (add_pos);
				add_strings.push_back (*it_new);
			}
		}

		fwrite (&delCount, sizeof (delCount), 1, m_DFile1);
		fwrite (&addCount, sizeof (addCount), 1, m_DFile1);

		std::vector<long>::const_iterator pit;
		for (pit = del_positions.begin (); pit != del_positions.end (); pit++) {
			long at_pit = *pit;
			fwrite (&at_pit, sizeof (long), 1, m_DFile1);
		}
		for (pit = add_positions.begin (); pit != add_positions.end (); pit++) {
			long at_pit = *pit;
			fwrite (&at_pit, sizeof (long), 1, m_DFile1);
		}
		for (it_new = add_strings.begin (); it_new != add_strings.end (); it_new++) {
			fwrite (it_new->c_str (), strlen (it_new->c_str ())+1, 1, m_DFile1);
		}

		if (old_strings) gk_free (old_strings);
		if (new_strings) gk_free (new_strings);
	} else {
		long zero = 0;
		fwrite (&zero, sizeof (zero), 1, m_DFile1);
		fwrite (&zero, sizeof (zero), 1, m_DFile1);
	}

	return 1;
}

int	Full::DiffSyns(char* key, Base* old_base, Base* new_base, long thread_id)
{
	char message [128];
	sprintf (message, "Построение дельты Syns, поток %ld", thread_id);
	GetProgressScreen()->SetMessage (message);

	long delCount = 0;
	u_int64_t fpDelCountPos = _ftelli64 (m_DFile1);
	fwrite ( &delCount, sizeof ( delCount ), 1, m_DFile1 );

	long addCount = 0;
	u_int64_t fpAddCountPos = _ftelli64 (m_DFile1);
	fwrite ( &addCount, sizeof ( addCount ), 1, m_DFile1 );

	std::map< std::string,GCL::StrSet > oldsyns, newsyns;
	std::map< std::string,GCL::StrSet >::iterator iter;

	Index* auxInd = old_base->FindIndex( "Aux" );
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
			iter = oldsyns.insert( std::map< std::string, GCL::StrSet >::value_type( ptr, GCL::StrSet() )).first;
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

	auxInd = new_base->FindIndex( "Aux" );
	str = auxInd->Open( key );
	if ( str ) {
		long size = str->Length();
		char* data = (char*) malloc( size );
		str->Read( data, size );
		auxInd->Close( str );

		char* ptr = data;
		long pos = 0;
		while ( pos < size ) {
			int length = strlen( ptr ) + 1;
			iter = newsyns.insert( std::map< std::string, GCL::StrSet >::value_type( ptr, GCL::StrSet() )).first;
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

	std::map< std::string,GCL::StrSet > adds, dels;
	std::map< std::string,GCL::StrSet >::iterator olds, news;
	olds = oldsyns.begin();
	news = newsyns.begin();
	while ( olds != oldsyns.end() && news != newsyns.end()) {
		std::string atolds = olds->first;
		std::string atnews = news->first;
		if ( atolds == atnews ) {
			GCL::StrSet::iterator itold = olds->second.begin();
			GCL::StrSet::iterator itnew = news->second.begin();
			while ( itold != olds->second.end() && itnew != news->second.end()) {
				std::string atold = (*itold);
				std::string atnew = (*itnew);
				if ( atold == atnew ) {
					itold++;
					itnew++;
				} else
				if ( atold < atnew ) {
					//это то, что удалили, надо записать в удаляемые...
					iter = dels.insert( std::map< std::string, GCL::StrSet >::value_type( atolds, GCL::StrSet() )).first;
					iter->second.insert( atold );
					itold++;
				} else {
					//это то, что новое, надо записать...
					iter = adds.insert( std::map< std::string, GCL::StrSet >::value_type( atolds, GCL::StrSet() )).first;
					iter->second.insert( atnew );
					itnew++;
				}
			}
			if ( itold != olds->second.end() ) {
				//это удаляемые
				iter = dels.insert( std::map< std::string, GCL::StrSet >::value_type( atolds, GCL::StrSet() )).first;
				while ( itold != olds->second.end() ) {
					iter->second.insert( (*itold) );
					itold++;
				}
			}
			if ( itnew != news->second.end() ) {
				//это добавляемые
				iter = adds.insert( std::map< std::string, GCL::StrSet >::value_type( atolds, GCL::StrSet() )).first;
				while ( itnew != news->second.end() ) {
					iter->second.insert( (*itnew) );
					itnew++;
				}
			}
			olds++;
			news++;
		} else
		if ( atolds < atnews ) {
			//это то, что удалили
			iter = dels.insert( std::map< std::string, GCL::StrSet >::value_type( atolds, GCL::StrSet() )).first;
			GCL::StrSet::iterator iter2 = olds->second.begin();
			while ( iter2 != olds->second.end()) {
				iter->second.insert( *iter2 );
				iter2++;
			}
			olds++;
		} else {
			//это то, что добавили
			iter = adds.insert( std::map< std::string, GCL::StrSet >::value_type( atnews, GCL::StrSet() )).first;
			GCL::StrSet::iterator iter2 = news->second.begin();
			while ( iter2 != news->second.end()) {
				iter->second.insert( *iter2 );
				iter2++;
			}
			news++;
		}
	}
	while ( olds != oldsyns.end() ) {
		//это удаляемые
		iter = dels.insert( std::map< std::string, GCL::StrSet >::value_type( olds->first, GCL::StrSet() )).first;
		GCL::StrSet::iterator iter2 = olds->second.begin();
		while ( iter2 != olds->second.end()) {
			iter->second.insert( *iter2 );
			iter2++;
		}
		olds++;
	}
	while ( news != newsyns.end() ) {
		//это добавляемые
		iter = adds.insert( std::map< std::string, GCL::StrSet >::value_type( news->first, GCL::StrSet() )).first;
		GCL::StrSet::iterator iter2 = news->second.begin();
		while ( iter2 != news->second.end()) {
			iter->second.insert( *iter2 );
			iter2++;
		}
		news++;
	}

	{
	for ( iter = dels.begin(); iter != dels.end(); iter++ ) {
		delCount += iter->first.size() + 1;
		delCount += sizeof( long );
		GCL::StrSet::iterator it2 = iter->second.begin();		
		for ( ; it2 != iter->second.end(); it2++ ) {
			delCount += (*it2).size() + 1;
		}
	}

	if (b_sbrf || b_daily || b_gctx_attrs_only)
		delCount = 0;

	if (delCount) {
		char* data = (char*) malloc( delCount );
		char* ptr = data;
		for ( iter = dels.begin(); iter != dels.end(); iter++ ) {
			strcpy( ptr, iter->first.c_str());
			ptr += iter->first.size() + 1;
			*(long*)ptr = iter->second.size();
			GCL::StrSet::iterator it2 = iter->second.begin();
			ptr += sizeof( long );
			for ( ; it2 != iter->second.end(); it2++ ) {
				strcpy( ptr, (*it2).c_str());
				ptr += (*it2).size() + 1;
			}
		}
		fwrite( data, delCount, 1, m_DFile1 );
		free( data );
	}

	u_int64_t fpCurrentPos = _ftelli64 (m_DFile1);
	_fseeki64 ( m_DFile1, fpDelCountPos, ACE_OS_SEEK_SET);
	fwrite ( &delCount, sizeof ( delCount ), 1, m_DFile1 );
	_fseeki64 (m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET);
	}

	{
	for ( iter = adds.begin(); iter != adds.end(); iter++ ) {
		addCount += iter->first.size() + 1;
		addCount += sizeof( long );
		GCL::StrSet::iterator it2 = iter->second.begin();		
		for ( ; it2 != iter->second.end(); it2++ )
			addCount += (*it2).size() + 1;
	}

	if (b_sbrf || b_daily || b_gctx_attrs_only)
		addCount = 0;

	if (addCount) {
		char* data = (char*) malloc( addCount );
		char* ptr = data;
		for ( iter = adds.begin(); iter != adds.end(); iter++ ) {
			strcpy( ptr, iter->first.c_str());
			ptr += iter->first.size() + 1;
			*(long*)ptr = iter->second.size();
			GCL::StrSet::iterator it2 = iter->second.begin();
			ptr += sizeof( long );
			for ( ; it2 != iter->second.end(); it2++ ) {
				strcpy( ptr, (*it2).c_str());
				ptr += (*it2).size() + 1;
			}
		}

		fwrite( data, addCount, 1, m_DFile1 );
		free( data );
	}
	
	u_int64_t fpCurrentPos = _ftelli64 (m_DFile1);
	_fseeki64 ( m_DFile1, fpAddCountPos, ACE_OS_SEEK_SET);
	fwrite ( &addCount, sizeof ( addCount ), 1, m_DFile1 );
	_fseeki64 (m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET);
	}

	return 1;
}

char	*Full :: CreateHolderName ( char * pNameBuff, int iBaseId )
{
	assert( pNameBuff );

	BaseInfo	aNewBaseInfo;
	BaseInfo	aOldBaseInfo;

	m_pNewBase->FindBaseInfo( iBaseId, aNewBaseInfo );

	m_pOldBase->FindBaseInfo( iBaseId, aOldBaseInfo );
	
	pNameBuff [0] = 'D';
	pNameBuff [1] = '-';
	pNameBuff [2] = DigitToChar ( aOldBaseInfo.LastUpdate.RevisionDate.da_year - 1990 );
	pNameBuff [3] = DigitToChar ( aOldBaseInfo.LastUpdate.RevisionDate.da_mon );
	pNameBuff [4] = DigitToChar ( aOldBaseInfo.LastUpdate.RevisionDate.da_day );
	pNameBuff [5] = DigitToChar ( aNewBaseInfo.LastUpdate.RevisionDate.da_year - 1990 );
	pNameBuff [6] = DigitToChar ( aNewBaseInfo.LastUpdate.RevisionDate.da_mon );
	pNameBuff [7] = DigitToChar ( aNewBaseInfo.LastUpdate.RevisionDate.da_day );
	pNameBuff [8] = 0;

	return pNameBuff;
}

void Full :: DiffDocKindData()
{
	long lKeyCount = 0;
	u_int64_t fpKeyCountPos = _ftelli64 (m_DFile1);
	fwrite ( &lKeyCount, sizeof ( lKeyCount ), 1, m_DFile1 );           //chg key count dummy
	/*
	в 7.11 нет второго стрима у DocKind
	if (!b_gctx_attrs_only) {
		char keybuff [4096]; // I hope it's enough
		HIndex* pOldInd =  (HIndex*) m_pOldBase->FindIndex("DocKind");
		HIndex* pNewInd =  (HIndex*) m_pNewBase->FindIndex("DocKind");
		assert ( pOldInd );
		assert ( pNewInd );

		for( BTIterator it(pNewInd); ! it.End(); ++it ){
			const void * k = it.Key() ;
			pNewInd->FullName ( k, keybuff );

			int savedata=0;
			long oldlen, newlen;
			char* pNewData = 0;
			char* pOldData = 0;

			Stream *pNewStr = pNewInd->Index::OpenN(k, 1);
			if ( !pNewStr )	newlen = 0;
			else {
				newlen = pNewStr->Length();
				if ( newlen > 0 ) {
					pNewData = (char*) malloc ( newlen );
					assert ( pNewData );
					pNewStr->Read ( pNewData, newlen );
				}
				pNewInd->Close ( pNewStr );
			}
			
			Stream *pOldStr = pOldInd->OpenN (keybuff, 1);
			if ( !pOldStr )	oldlen = 0;
			else {
				oldlen = pOldStr->Length();
				
				if ( newlen != oldlen ) savedata = 1;
				else if ( oldlen > 0 ) {
					pOldData = (char*) malloc ( oldlen );
					assert ( pOldData);				
					pOldStr->Read ( pOldData, oldlen );				
				}			
				pOldInd->Close ( pOldStr );
			}

			if ( newlen != oldlen ) savedata = 1;
			else if ( !oldlen ) savedata = 0;
			else savedata = memcmp ( pNewData, pOldData, oldlen );

			if ( savedata ) {
				long keyLen = strlen (keybuff)+1;
				fwrite ( &keyLen, sizeof(keyLen), 1, m_DFile1 );  // length of key
				fwrite ( keybuff, 1, keyLen, m_DFile1 );  // full key
				fwrite ( &newlen, sizeof(newlen), 1, m_DFile1 );  // length of data
				if ( newlen ) fwrite ( pNewData, 1, newlen, m_DFile1 );  // data

				lKeyCount++;
			}

			if ( newlen ) free ( pNewData );
			if ( oldlen ) free ( pOldData );
		}
	}
	*/

	u_int64_t fpCurrentPos = _ftelli64 (m_DFile1);
	_fseeki64 (m_DFile1, fpKeyCountPos, ACE_OS_SEEK_SET);
	fwrite ( &lKeyCount, sizeof ( lKeyCount ), 1, m_DFile1 );
	_fseeki64 (m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET);
}

extern std::map<u_int64_t, StorableSplaySet<short> > map_old_blobbelongs, map_new_blobbelongs;
extern std::map<u_int64_t,short> map_blob_order;
extern std::map<u_int64_t,long> map_blob_osize, map_blob_tsize;
extern std::map<u_int64_t,void*> map_blob_odata, map_blob_tdata;
extern std::map<u_int64_t, ObjInfo> map_blob_objinfo;

void Full :: DeltaBlobs()
{
	// FIND NEW OR CHANGED BLOBS
	long lBlobCount = 0;
	u_int64_t fpBlobCountPos = _ftelli64 (m_DFile1);
	fwrite ( &lBlobCount, sizeof ( lBlobCount ), 1, m_DFile1 ); //chg blobs count dummy

	if (b_pack_delta) {
		for (std::map<u_int64_t, StorableSplaySet<short> >::const_iterator new_belongs_it = map_new_blobbelongs.begin (); new_belongs_it != map_new_blobbelongs.end (); new_belongs_it++) {
			long id = ((ObjKey*)&new_belongs_it->first)->id;
			StorableSplaySet<short> new_belongs = new_belongs_it->second;
			if (!new_belongs.contains (seg))
				continue;

			short order = map_blob_order.find (new_belongs_it->first)->second;

			if (map_old_blobbelongs.find (new_belongs_it->first) != map_old_blobbelongs.end ()) {
				StorableSplaySet<short> old_belongs = map_old_blobbelongs.find (new_belongs_it->first)->second;
				StorableSplaySet<short> diff = new_belongs;
				diff -= old_belongs;
				if (diff.contains (seg))
					order |= BO_BLBNEW;
			}

			if (order == BO_BLBEQU) {
				logger.printf (lt_deltaInfo, "Blob %ld (%ld)- equ\n", id, seg);
			} else {
				logger.printf (lt_deltaInfo, "Blob %ld (%ld) - chg (", id, seg);

				u_int64_t fpEndPos, fpStartPos = _ftelli64 (m_DFile1);

				lBlobCount++;

				ObjKey *key = (ObjKey*)&new_belongs_it->first;
				fwrite (key, sizeof (ObjKey), 1, m_DFile1);

				fwrite (&order, sizeof (order), 1, m_DFile1);

				ObjInfo info = map_blob_objinfo.find (new_belongs_it->first)->second;

				if (order & BO_BLBNEW) {
					logger.printf (lt_deltaInfo, "n");
				}
				if (order & BO_INFCHG) {
					logger.printf (lt_deltaInfo, "i");
					fwrite (&info, sizeof(ObjInfo), 1, m_DFile1);
				}
				if (order & BO_OBJCHG) {
					logger.printf (lt_deltaInfo, "o");
					long size = map_blob_osize.find (new_belongs_it->first)->second;
					void *data = map_blob_odata.find (new_belongs_it->first)->second;
					fwrite (&size, sizeof (size), 1, m_DFile1);
					fwrite (data, 1, size, m_DFile1);
				}
				if (order & BO_TALCHG) {
					logger.printf (lt_deltaInfo, "t");
					long size = map_blob_tsize.find (new_belongs_it->first)->second;
					void *data = map_blob_tdata.find (new_belongs_it->first)->second;
					fwrite (&size, sizeof (size), 1, m_DFile1);
					fwrite (data, 1, size, m_DFile1);
				}
				if (order & BO_BELCHG) {
					logger.printf (lt_deltaInfo, "b");
					long count = new_belongs.length () * sizeof (short);
					fwrite (&count, sizeof (count), 1, m_DFile1);
					for (Point p = new_belongs.first (); p; new_belongs.next (p)) {
						short at = new_belongs.contents (p);
						fwrite (&at, sizeof (at), 1, m_DFile1);
					}
				}
				
				logger.printf (lt_deltaInfo, ")\n");

				fpEndPos = _ftelli64 (m_DFile1);
				if ((order & BO_ORDER_MASK) == BO_BLBNEW) {
					g_lNewBlbCount++;
					g_lNewBlbSize += (unsigned long)(fpEndPos - fpStartPos);
				} else {
					g_lChgBlbCount++;
					g_lChgBlbSize += (unsigned long)(fpEndPos - fpStartPos);
				}
			}
		}
	} else {
		if (!b_gctx_attrs_only) {
			short seg = m_ids.length () == 1 ? *m_ids[m_ids.first ()] : 0;
			Index *blobs = m_pNewBase->FindIndex ("Blob");
			for (BTIterator bi (blobs); !bi.End (); ++bi) {
				ObjKey* pkey = (ObjKey*) bi.Key();
				if (seg) {
					Stream* str = blobs->OpenN (pkey, 1);
					if (str) {
						short length = short((str->Length () / 2)&0x7fff), *data = new short [length], *ptr = data;
						str->Read (data, length * 2);
						blobs->Close (str);				
						bool found = false;
						for (short i = 0; i < length && !found; ptr++, i++)
							if (*ptr == seg)
								found = true;
						delete data;
						if (!found)
							continue;
					} else {
						continue;
					}
				}
				short order = BlobOrder ( pkey );

				if (((b_sbrf || b_daily) && ((pkey->id >= 100106 && pkey->id <= 100115) || (pkey->id == 100050))) && !b_ovp)
					order = BO_BLBEQU;

				if (order != BO_BLBEQU && b_sbrf && (pkey->id < SBRF_LOW_ID || pkey->id > SBRF_HI_ID)) {
					logger.printf ( lt_fatal, "Blob %ld - не входит в диапазон документов СберБанка\n", pkey->id );
					exit (1);
				}

				if ( order != BO_BLBEQU ) {
					if ( for_all_segs )
						logger.printf ( lt_deltaInfo, "Blob %ld (%ld) - chg (", pkey->id, seg );
					else
						logger.printf ( lt_deltaInfo, "Blob %ld - chg (", pkey->id );

					u_int64_t fpEndPos, fpStartPos = _ftelli64 (m_DFile1);

					// make difference			
					lBlobCount++;
					fwrite ( pkey, sizeof ( ObjKey ), 1, m_DFile1 );
								
					ObjInfo info;
					Stream * pstr = ((Index*)bi.tree)->OpenN ( pkey, 0 );
					assert ( pstr );			
					pstr->Read ( &info, sizeof ( ObjInfo ) );

					if ( info.type == EOT_PIC ) order |= BO_TYPPIC;
					else if ( info.type == EOT_RTF ) order |= BO_TYPRTF;
					else order |= BO_TYPOTH;
						
					fwrite ( &order, sizeof ( order ), 1, m_DFile1 );

					if ( order & BO_BLBNEW ) {
						logger.printf ( lt_deltaInfo, "n" );
					}
					if ( order & BO_INFCHG ) {
						logger.printf ( lt_deltaInfo, "i" );
						fwrite ( &info, sizeof(ObjInfo), 1, m_DFile1 );
					}
					if ( order & BO_OBJCHG ) {
						logger.printf ( lt_deltaInfo, "o" );
						SaveStream ( pstr, m_DFile1, -1, info.size );
					}
					if ( order & BO_TALCHG ) {
						logger.printf ( lt_deltaInfo, "t" );
						SaveStream ( pstr, m_DFile1, info.size + sizeof(ObjInfo), -1 );
					}
					if ( order & BO_BELCHG ) {
						logger.printf ( lt_deltaInfo, "b" );
						Stream * pstr2 = ((Index*)bi.tree)->OpenN ( pkey, 1 );
						assert ( pstr2 );
						SaveStream ( pstr2, m_DFile1 );
						((Index*)bi.tree)->Close ( pstr2 );
					}
					
					logger.printf ( lt_deltaInfo, ")\n" );
					((Index*)bi.tree)->Close ( pstr );

					// collect statistics
					fpEndPos = _ftelli64 (m_DFile1);
						
					if ( (order & BO_ORDER_MASK) == BO_BLBNEW ) {
						g_lNewBlbCount++;
						g_lNewBlbSize += (unsigned long)(fpEndPos - fpStartPos);
					}
					else {
						g_lChgBlbCount++;
						g_lChgBlbSize += (unsigned long)(fpEndPos - fpStartPos);
					}
				} else {
					if ( for_all_segs )
						logger.printf ( lt_deltaInfo, "Blob %ld (%ld)- equ\n", pkey->id, seg );
					else
						logger.printf ( lt_deltaInfo, "Blob %ld - equ\n", pkey->id );
					g_lEquBlbCount++;
				}
			}
		}
	}

	u_int64_t fpCurrentPos = _ftelli64 (m_DFile1);
	_fseeki64 (m_DFile1, fpBlobCountPos, ACE_OS_SEEK_SET);
	fwrite ( &lBlobCount, sizeof ( lBlobCount ), 1, m_DFile1 );
	_fseeki64 (m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET);

	// FIND DELETED BLOBS
	lBlobCount = 0;
	fpBlobCountPos = _ftelli64 (m_DFile1);
	fwrite (&lBlobCount, sizeof ( lBlobCount ), 1, m_DFile1 ); //del blobs count dummy

	if (!b_gctx_attrs_only) {
		if ( m_delblobs ) {
			for ( Point p = m_delblobs->first(); p; m_delblobs->next(p) ) {
				ObjKey key = m_delblobs->contents(p);
				if (b_sbrf && (key.id < SBRF_LOW_ID || key.id > SBRF_HI_ID))
					continue;
				if ( FindBlob (m_pOldBase, &key) ) {
					if ( !FindBlob (m_pNewBase, &key) ) {
						if ( for_all_segs )
							logger.printf ( lt_deltaInfo, "Blob %ld (%ld) - del\n", key.id, seg );
						else
							logger.printf ( lt_deltaInfo, "Blob %ld - del\n", key.id );
						lBlobCount++;
						fwrite ( &key, sizeof ( ObjKey ), 1, m_DFile1 );
					} else 
						logger.printf ( lt_warning, "deleted blob (%ld) from del-file is present in new base\n", key.id );
				} else 
					logger.printf ( lt_warning, "deleted blob (%ld) from del-file is missed in old base\n", key.id );
			}
		} else {
			short seg_local = m_ids.length () == 1 ? *m_ids[m_ids.first ()] : 0;
			if (b_pack_delta) {
				for (std::map<u_int64_t, StorableSplaySet<short> >::const_iterator old_belongs_it = map_old_blobbelongs.begin (); old_belongs_it != map_old_blobbelongs.end (); old_belongs_it++) {
					long id = ((ObjKey*)&old_belongs_it->first)->id;
					StorableSplaySet<short> old_belongs = old_belongs_it->second;
					if (!old_belongs.contains (seg_local))
						continue;

					bool b_del = false;
					if (map_new_blobbelongs.find (old_belongs_it->first) == map_new_blobbelongs.end ())
						b_del = true;
					else {
						StorableSplaySet<short> new_belongs = map_new_blobbelongs.find (old_belongs_it->first)->second;
						StorableSplaySet<short> diff = old_belongs;
						diff -= new_belongs;
						if (diff.contains (seg_local))
							b_del = true;
					}

					if (b_del) {
						ObjKey *key = (ObjKey*)&old_belongs_it->first;
						logger.printf ( lt_deltaInfo, "Blob %ld (%ld) - del\n", key->id, seg_local);
						lBlobCount++;
						fwrite (key, sizeof (ObjKey), 1, m_DFile1);
					}
				}
			} else {
				Index *blobs = m_pOldBase->FindIndex ("Blob");
				for (BTIterator dbi (blobs); !dbi.End(); ++dbi ) {
					ObjKey* pkey = (ObjKey*) dbi.Key();
		
					if (seg_local) {
						Stream* str = blobs->OpenN (pkey, 1);
						if (str) {
							short length = short((str->Length () / 2)&0x7fff), *data = new short [length], *ptr = data;
							str->Read (data, length * 2);
							blobs->Close (str);				
							bool found = false;
							for (short i = 0; i < length && !found; ptr++, i++)
								if (*ptr == seg_local)
									found = true;
							delete data;
							if (!found)
								continue;
						} else {
							continue;
						}
					}

					if ( !FindBlob (m_pNewBase, pkey) ) {
						if ( for_all_segs )
							logger.printf ( lt_deltaInfo, "Blob %ld (%ld) - del\n", pkey->id, seg_local );
						else
							logger.printf ( lt_deltaInfo, "Blob %ld - del\n", pkey->id );
						lBlobCount++;
						fwrite ( pkey, sizeof ( ObjKey ), 1, m_DFile1 );			
					}
				}
			}
		}
	}

	fpCurrentPos = _ftelli64 (m_DFile1);
	_fseeki64 (m_DFile1, fpBlobCountPos, ACE_OS_SEEK_SET);
	fwrite ( &lBlobCount, sizeof ( lBlobCount ), 1, m_DFile1 );
	_fseeki64 ( m_DFile1, fpCurrentPos, ACE_OS_SEEK_SET );	
	g_lDelBlbCount = lBlobCount;

	logger.flush (lt_always);
}

short Full :: FindBlob( Base * base, ObjKey* pkey )
{
	if (m_ids.length () == 1) {
		short id = *m_ids [m_ids.first()], result = 0;
		Stream * pstr = base->FindIndex("Blob")->OpenN ( pkey, 1 );
		if (pstr) {
			short length = short((pstr->Length () / int((sizeof (short)&0x7fffffff)))&0x7fff);
			short *data = new short [length], *ptr = data;
			pstr->Read (data, pstr->Length ());
			base->FindIndex("Blob")->Close(pstr);
			for (; ptr - data < length && !result; ptr++) {
				if (*ptr == id)
					result = id;
			}
			delete data;
		}
		return result;
	} else {
		Stream * pstr = base->FindIndex("Blob")->OpenN ( pkey, 1 );
		if (pstr) {
			StorableSplaySet<unsigned short> ids;
			ids.Get(pstr);
			base->FindIndex("Blob")->Close(pstr);
			return ids & m_ids;
		} else {
			return 0;
		}
	}
}

short Full::BlobOrder ( ObjKey * pkey )
{
	short order = BO_BLBEQU;
	if ( !FindBlob (m_pOldBase, pkey) ) 
		order |= BO_BLBNEW;
	else {
		// first stream
		{
			Stream * postr = m_pOldBase->FindIndex("Blob")->OpenN ( pkey, 0 );
			assert ( postr );
			Stream * pnstr = m_pNewBase->FindIndex("Blob")->OpenN ( pkey, 0 );
			assert ( pnstr );
			
			order = objcmp( postr, pnstr );

			m_pOldBase->FindIndex("Blob")->Close ( postr );
			m_pNewBase->FindIndex("Blob")->Close ( pnstr );
		}
		// second stream
		{
			Stream * postr = m_pOldBase->FindIndex("Blob")->OpenN ( pkey, 1 );
			assert ( postr );
			Stream * pnstr = m_pNewBase->FindIndex("Blob")->OpenN ( pkey, 1 );
			assert ( pnstr );
			
			StorableSplaySet<short> oldset;
			StorableSplaySet<short> newset;
				
			oldset.Get ( postr );
			newset.Get ( pnstr );
			if ( oldset != newset ) order |= BO_BELCHG;
			
			m_pNewBase->FindIndex("Blob")->Close ( pnstr );
			m_pOldBase->FindIndex("Blob")->Close ( postr );
		}		
	}

	return order;
}

void Full::FillCorrList ( long docId )
{
	long lRefs, l;
	RespRef* iddrefs = (RespRef*) m_pOldBase->LoadAttr( docId, IDD_REFS, lRefs );
	RespRef* atl = iddrefs;
	lRefs /= sizeof( RespRef );
	for ( l = 0; l < lRefs; l++, atl++ )
		g_cordocs.insert (atl->DocId);
	gk_free( iddrefs );

	iddrefs = (RespRef*) m_pNewBase->LoadAttr( docId, IDD_REFS, lRefs );
	atl = iddrefs;
	lRefs /= sizeof( RespRef );
	for ( l = 0; l < lRefs; l++, atl++ )
		g_cordocs.insert (atl->DocId);
	gk_free( iddrefs );
}

char DigitToChar ( int iDigit )
{
	assert ( iDigit >= 0 && iDigit < 36 );

	char cChar;

	if ( iDigit < 10 ) {
		cChar = '0';
		cChar += iDigit;
	}
	else {
		cChar = 'a';
		cChar += iDigit - 10;
	}

	return cChar;
}

#undef SKIP_TO_DOCID

