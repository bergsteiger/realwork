#include "shared/Core/fix/mpcxc.h"

#include "base.h"
#include "stringz.h"
#include "reviser.h"
#include "dociter.h"
#include "deltadef.h"
#include "StorableSplaySet.h"
#include "garutils.h"
#include "adds.h"
#include "pack.h"

extern void DocsProcCreate ( long lDocInDelta, bool );
extern void AddDelta ( long lDeltaCount, bool );
extern Logger logger;
extern bool compareOnlyTexts;

int g_pAttrs [] = {
// string attrs	
	IDD2_NAME,
	IDD_ID, IDD_SOURCE, IDD_DIV, IDD_KEY, IDD_TYPE, IDD_KIND, IDD_CLASS6, 
	IDD_RCODE, IDD_WARNING, IDD_CATEGORY, IDD_PUBLISHEDIN, IDD_TERRITORY, IDD_DOCKIND, IDD_TAG, 
// date attrs	
	IDD_CALIN, IDD_CALCH, IDD_CALAB,
	IDD_DATE, IDD_VINCLUDED, IDD_VCHANGED, IDD_VABOLISHED,
	IDD_RDATE, IDD_SORTDATE, IDD_VANONCED, IDD_VLCONTROL, 
// special attrs
	IDD_SUBS, IDD_SUBS_EX, IDD_INFO,
// short attrs	
	IDD_BASES,  
	IDD_ACTIVE, IDD_PAGEBREAKS, IDD_CHDATE, IDD_COMPARECONTENTS, IDD_CONTENTS, IDD_NOTSURE, IDD_REFS, IDD_BLOBS, IDD_DIVISION, IDD2_PARAIDS,
	IDD_PREANNODATE, IDD_ANNODATE, IDD_PREANNOUSER, IDD_PREANNOORGANIZATION, IDD_PREANNOTAX, IDD_PREANNOINTEREST, IDD_PREANNOKIND, 
	IDD_ANNOUSER, IDD_ANNOORGANIZATION, IDD_ANNOTAX, IDD_ANNOINTEREST, IDD_ANNOKIND, IDD_SAMEDOCS, IDD_SERVICEINFO,
	IDD_HANDMASK, IDD_HANDHANDMASK, IDD_CASECODE, IDD_EVD, 

	IDD_INPHARMFIRM, IDD_INPHARMCOUNTRY, IDD_REGDATE, IDD_ANNULDATE,
	IDD_TRADENAME, IDD_INTNAME, IDD_PHARMGROUP, IDD_PHARMEFFECT,
	IDD_CHAPTER, IDD_ATC, IDD_REGSTATUS, IDD_LEKFORM, IDD_MKB,
	IDD_LIFE, IDD_UNRECIPE, IDD_ALLOWED, IDD_NOTLIFE, IDD_NOTALLOWED, IDD_RECIPE,
	IDD_ACTIVEEX, IDD_PARAGCTXLENS, IDD_INVISIBLELENS, IDD_INVISIBLERELES, IDD_DOCSTRUCT, 

	IDD_CHDATE_EX, IDD_ADDCODE, IDD_CHDATE_EXEX, IDD_MARKEDTEXT, IDD_PROFDATE,

	IDD_NONE 
};

Reviser :: Reviser ( Base* oldBase, Base* newBase, int iBaseId )
{
	m_bRevsExtraTopic = 0;

	m_pOldBase = oldBase;
	m_pNewBase = newBase;
	m_pOlddocInd = (AttrIndex*)m_pOldBase->FindIndex("Attrs");
	m_pNewdocInd = (AttrIndex*)m_pNewBase->FindIndex("Attrs");
	m_pOlddocInd2 = (AttrIndex*)m_pOldBase->FindIndex("Attribs");
	m_pNewdocInd2 = (AttrIndex*)m_pNewBase->FindIndex("Attribs");
	m_pOldResp = m_pOldBase->FindIndex("Respondent");
	m_pNewResp = m_pNewBase->FindIndex("Respondent");

	m_iBaseId = iBaseId;

	m_pNewDocIter = new DocIterator ( m_pNewBase );
	assert ( m_pNewDocIter );

	m_pOldDocIter = new DocIterator ( m_pOldBase );
	assert ( m_pOldDocIter );

	m_iRunMode = RM_TWOBASESET;
}

Reviser :: Reviser ( Base* newBase, revision * pDocSetRev, revision * pSegSetRev )
{
	m_bRevsExtraTopic= 1;

	m_pOldBase = 0;
	m_pNewBase = newBase;
	m_pOlddocInd = 0;
	m_pNewdocInd = (AttrIndex*)m_pNewBase->FindIndex("Attrs");
	m_pOlddocInd2 = 0;
	m_pNewdocInd2 = (AttrIndex*)m_pNewBase->FindIndex("Attribs");

	m_iBaseId = 0;

	m_pNewDocIter = new DocIterator ( m_pNewBase );
	assert ( m_pNewDocIter );

	m_pOldDocIter = 0;

	m_pDocNewRevision = pDocSetRev;
	m_pSegNewRevision = pSegSetRev;

	m_iRunMode = RM_ONEBASESET;
}

Reviser :: ~Reviser ()
{
        if ( m_pOldDocIter ) delete m_pOldDocIter;
        if ( m_pNewDocIter ) delete m_pNewDocIter;
}

long Reviser :: GetNextDocId ( int iVersion )
{
        long lDocId             = NEW_ID;
        DocIterator * pDocIter  = 0;

        switch ( iVersion )
        {
        case VER_NEW :
                pDocIter = m_pNewDocIter;
                break;

        case VER_OLD :
                if ( m_iRunMode == RM_ONEBASESET ) return NEW_ID;

                pDocIter = m_pOldDocIter;
                break;

        default :
                logger.printf ( lt_fatal, "GetNextDocId : Unknown VERSION\n" );
				exit ( EXIT_FAILURE );
        }

        while ( ! pDocIter->End () )
        {
                if ( iVersion == VER_NEW ) AddDelta ( 1, false );

                lDocId = pDocIter->Id ();
                ++ (* pDocIter);

                if ( IsDocFit ( lDocId, iVersion ) ) return lDocId;
        }

        return NEW_ID;
}

int Reviser :: IsDocFit ( long lDocId, int iVersion )
{
        Base* pBase = 0;

        switch ( iVersion )
        {
        case VER_NEW :
                pBase = m_pNewBase;
                break;

        case VER_OLD :
                if ( m_iRunMode == RM_ONEBASESET ) return NEW_ID;

                pBase = m_pOldBase;
                break;

        default :
                logger.printf ( lt_fatal, "IsDocFit : Unknown VERSION\n" );
				exit ( EXIT_FAILURE );
        }

        if ( m_iBaseId )
        {
                long iSize = 0;

                void * vBuff = pBase->LoadAttr( lDocId, IDD_BASES, iSize );
                assert ( iSize != -1 );
                if ( !iSize ) vBuff = 0;

                int* pBaseId = (int*) vBuff;
                int iIdCount = iSize / sizeof ( int );

                while ( iIdCount > 0 && pBaseId [ iIdCount-1 ] != m_iBaseId ) iIdCount--;

                if ( vBuff ) free ( vBuff );
                vBuff = 0;

                if ( iIdCount && (  lDocId > ID_BORDER || m_bRevsExtraTopic ) )
                        return 1;
        }
        else if ( lDocId > ID_BORDER || m_bRevsExtraTopic )
                return 1;

        return 0;
}

int Reviser :: FindDoc ( long lDocId, int iVersion )
{
        Base * pBase = 0;

        switch ( iVersion )
        {
        case VER_NEW :
                pBase = m_pNewBase;
                break;

        case VER_OLD :
                if ( m_iRunMode == RM_ONEBASESET ) return NEW_ID;

                pBase = m_pOldBase;
                break;

        default :
                logger.printf ( lt_fatal, "FindDoc : Unknown VERSION\n" );
				exit ( EXIT_FAILURE );
        }

        if ( ! pBase->FindDoc ( lDocId ) ) return 0;

        return IsDocFit ( lDocId, iVersion );
}

int	Reviser :: RunAnnoRevising( revision annoRevision )
{
	DocCollection *annos = m_pNewBase->AllTopics(ID_ANNOPLUS+ID_BORDER);
	DocCollection* docs = new DocCollection();
	if ( !annos->ItemCount )
		return 0;

	for ( int i = 0; i < annos->ItemCount; i++ ) {
		DocInfo docInfo;
		if ( m_pNewBase->FindDocInfo( (*annos)[i], docInfo ) == sizeof( DocInfo )) {
			docs->Add( (*annos)[i] );
			docs->Add( GetDocMonitoring( &docInfo ));
		}
	}

	for ( int j = 0; j < docs->ItemCount; j++ ) {
		m_lDocId = (*docs)[j];
		DocInfo docInfo;
		if ( m_pOldBase->FindDocInfo( m_lDocId, docInfo ) == sizeof( DocInfo )) {
			//документ есть в старой базе
			Document* pOldDoc = m_pOldBase->GetDoc( m_lDocId );
			Document* pNewDoc = m_pNewBase->GetDoc( m_lDocId );

			assert( pNewDoc );
			assert( pOldDoc );

			if ( CompareDocs( pNewDoc, pOldDoc ) == SR_DOCDIFF ) {
				logger.printf( lt_info, "Doc ID %ld - Chg\n", m_lDocId );
				SetDocRevision( m_lDocId, annoRevision );
			}
			else {
				logger.printf( lt_info, "Doc ID %ld - Equ\n", m_lDocId );
				ReplaceDocRevision( m_lDocId );
			}

			delete pNewDoc;
			delete pOldDoc;
		} else {
			//новый документ
			logger.printf( lt_info, "Doc ID %ld - New\n", m_lDocId );
		}


	}

	return 0;
}

int	Reviser :: RunControlRevising( revision controlRevision, bool b_daily )
{
    BaseInfo aBaseInfo;
    m_pNewBase -> FindBaseInfo ( m_iBaseId, aBaseInfo );
    if ( !aBaseInfo.RecCount ) aBaseInfo.RecCount = 10000;
    DocsProcCreate ( aBaseInfo.RecCount, false );

	controlStatus = new longlongSplayMap(-1);

	while (( m_lDocId = GetNextDocId( VER_NEW )) != NEW_ID ) {
		/*
		if ( !FindDoc( m_lDocId, VER_OLD ) ) {
			(*controlStatus)[ m_lDocId ] = CS_DELETED;
			continue;
		}
		*/

		DocInfo oldInfo;
		if (m_pOldBase->FindDocInfo( m_lDocId, oldInfo ) != sizeof (oldInfo))
			continue;

		DocInfo newInfo; m_pNewBase->FindDocInfo( m_lDocId, newInfo );

		long aStatus = 0L;

		if ( TagAttrTest( m_lDocId, IDD_VCHANGED ))
			aStatus |= CS_CHANGED;
		/*
		if ( TagAttrTest( m_lDocId, IDD_VLCONTROL ))
			aStatus |= CS_ONCONTROLED;
		*/
		if (( oldInfo.Status & DS_ACTIVE ) && ( newInfo.Status & DS_ABOLISHED ))
			aStatus |= CS_ABOLISHED; //утратил силу
		if ( ( newInfo.Status & DS_ACTIVE ) && !(oldInfo.Status & DS_ACTIVE ))
			aStatus |= CS_ACTIVE; //вступил в силу
		if ( ( newInfo.Status & DS_MOJREG ) && !( oldInfo.Status & DS_MOJREG ))
			aStatus |= CS_REGISTERED; //зарегистрировали в МЮ
		if ( ( newInfo.Status & DS_MOJNOTREG ) && !( oldInfo.Status & DS_MOJNOTREG ))
			aStatus |= CS_NOT_REGISTERED; //отказали в регистрации

		if ( aStatus != 0 )
			(*controlStatus)[ m_lDocId ] = aStatus;
	}

	while ( ( m_lDocId = GetNextDocId( VER_OLD ) ) != NEW_ID ) {
		if ( !FindDoc( m_lDocId, VER_NEW ) ) {
			(*controlStatus)[ m_lDocId ] = CS_DELETED;
		}
	}

	long	aLength = controlStatus->length(), *aData = 0;
	if (aLength) {
		aData = new long[ aLength * 2 ];
		long*	atPut = aData;
		for ( Pix pix = controlStatus->first(); pix; controlStatus->next(pix) ) {
			*atPut = controlStatus->key(pix);
			atPut++;
			*atPut = controlStatus->contents(pix);
			atPut++;
		}
	}

	DateIndex *controlIndex = (DateIndex*)m_pNewBase->FindIndex("Control");

	//перенести из старой базы все данные
	if (!b_daily) {
		DateIndex *oldControlIndex = (DateIndex*)m_pOldBase->FindIndex("Control");
		for ( BTIterator it( oldControlIndex ); !it.End(); ++it ) {
			date adate = *(date*)it.Key ();
			if (adate.da_year<2010)
				continue;
			Stream *str = oldControlIndex -> Index::OpenN( it.Key(), 0 );
			if ( str ) {
				void gk_huge* oldData = gk_malloc( str->Length() );
				str->Read( oldData, str->Length() );
				Stream* newStr = controlIndex->Open( it.Key(),1 );
				if ( newStr ) {
					newStr->Write( oldData, str->Length() );
					newStr->Trunc();
					controlIndex->Close(newStr);
				}
				gk_free(oldData);
				oldControlIndex->Close(str);
			}
		}
	}

	if (aLength) {
		Stream* str = controlIndex->Open( &controlRevision.RevisionDate,1 );
		str->Write( aData, aLength * sizeof( long ) * 2 );
		str->Trunc ();
		controlIndex->Close(str);
	}

	if (aData)
		delete aData;

	return 0;
}

int Reviser :: RunRevising ()
{
    BaseInfo aBaseInfo;

    m_pNewBase -> FindBaseInfo ( m_iBaseId, aBaseInfo );
    if ( !aBaseInfo.RecCount ) aBaseInfo.RecCount = 10000;
    DocsProcCreate ( aBaseInfo.RecCount, false );

	if ( m_iRunMode == RM_ONEBASESET && !m_pDocNewRevision );
    else while ((m_lDocId=GetNextDocId(VER_NEW))!=NEW_ID)
    {
            if ( m_iRunMode == RM_ONEBASESET ) {
				SetDocRevision ( m_lDocId, *m_pDocNewRevision );
				continue;
            }

            m_bDocAlradyDiff = 0;

            if ( ! FindDoc ( m_lDocId, VER_OLD ) ) {
                    logger.printf ( lt_info, "Doc ID %ld - New\n", m_lDocId );
                    continue;
            }

            Document* pNewDoc = m_pNewBase -> GetDoc ( m_lDocId );
            Document* pOldDoc = m_pOldBase -> GetDoc ( m_lDocId );

            assert ( pNewDoc );
            assert ( pOldDoc );

            if ( CompareDocs ( pNewDoc, pOldDoc ) == SR_DOCDIFF ) {
				logger.printf( lt_info, "Doc ID %ld - Chg\n", m_lDocId );
            }
            else {
				logger.printf ( lt_info, "Doc ID %ld - Equ\n", m_lDocId );
				ReplaceDocRevision ( m_lDocId );
            }

            delete pNewDoc;
            delete pOldDoc;
    }

	if ( m_iRunMode == RM_ONEBASESET && m_pSegNewRevision ) {
		BaseInfoSet bis ( m_pNewBase );
		bis.ReplaceRevision ( *m_pSegNewRevision );
		bis.SaveInfo ( m_pNewBase );
	}

    return 0;
}

int Reviser :: CompareDocs ( Document* pNewDoc, Document* pOldDoc )
{
	{
		int bodyDiff = 0;

		bodyDiff = pNewDoc->Stat.ParaCount != pOldDoc->Stat.ParaCount;
		
		for ( long l = 0; !bodyDiff && l<pNewDoc->Stat.ParaCount; l++ ) {
			char* pNewPara = pNewDoc -> GetPara ( l );
			char* pOldPara = pOldDoc -> GetPara ( l );
			assert ( pNewPara );
			assert ( pOldPara );

			bodyDiff = ParaSize ( pOldPara ) != ParaSize ( pNewPara );
			if ( !bodyDiff ) bodyDiff = memcmp ( pNewPara, pOldPara, ParaSize ( pNewPara ) + 3 );
		}
		
		if ( bodyDiff ) {			
			logger.printf ( lt_debug, "Text body of document %ld, is not equal\n", m_lDocId );
			return SR_DOCDIFF;
		}
	}

	if ( compareOnlyTexts )
		return SR_DOCEQU;
	        
	for ( int i = 0; g_pAttrs [i] != IDD_NONE; i++ ) {     
		if ( TagAttrTest ( m_lDocId, g_pAttrs [i] ) ) {
			logger.printf ( lt_debug, "Attributes with tag %ld of document %ld, is not equal\n", g_pAttrs [i], m_lDocId );
			return SR_DOCDIFF;
		}
	}
        
	StorableSplaySet<Ref> oldRef;
	StorableSplaySet<Ref> newRef;

	Stream * pOldStr = m_pOldResp -> Open ( &m_lDocId );
	Stream * pNewStr = m_pNewResp -> Open ( &m_lDocId );
	oldRef.Get(pOldStr);
	newRef.Get(pNewStr);
	if ( pOldStr ) m_pOldResp -> Close ( pOldStr );
	if ( pNewStr ) m_pNewResp -> Close ( pNewStr );

	if ( oldRef != newRef ) {
		logger.printf ( lt_debug, "Respondent list of document %ld, is not equal\n", m_lDocId );
		return SR_DOCDIFF;
	}
	
	/*pOldStr = m_pOldBase -> FindIndex ( "Correspondent" ) -> Open ( &m_lDocId );
	pNewStr = m_pNewBase -> FindIndex ( "Correspondent" ) -> Open ( &m_lDocId );
	oldRef.Get(pOldStr);
	newRef.Get(pNewStr);
	if ( pOldStr ) m_pOldBase -> FindIndex ( "Correspondent" ) -> Close ( pOldStr );
	if ( pNewStr ) m_pNewBase -> FindIndex ( "Correspondent" ) -> Close ( pNewStr );
        
	if ( oldRef != newRef ) {
		logger.printf ( lt_debug, "Correspondent list of document %ld, is not equal\n", m_lDocId );
		return SR_DOCDIFF;
	}*/
	
	return SR_DOCEQU;
}

extern	bool	compatMode;

int Reviser :: TagAttrTest ( long lDocId, int iTag )
{
	//logger.printf( lt_info, "Doc ID %ld, Tag %ld\n", m_lDocId, iTag ); logger.flush (lt_always);
	int iRetVal = 0;

	switch ( iTag ) {
	case IDD_ACTIVE:
	case IDD_PAGEBREAKS:
	case IDD_CHDATE:
	case IDD_PROFDATE:
	case IDD_CHDATE_EX:
	case IDD_NOTSURE:
	case IDD_CONTENTS:
	case IDD_COMPARECONTENTS:
	case IDD_REFS:
	case IDD_BLOBS:
	case IDD_DIVISION:
	case IDD_PREANNOUSER:
	case IDD_PREANNOORGANIZATION:
	case IDD_PREANNOTAX:
	case IDD_PREANNOINTEREST:
	case IDD_PREANNOKIND:
	case IDD_SAMEDOCS:
	case IDD_HANDMASK:
	case IDD_HANDHANDMASK:
	case IDD_CASECODE:
	case IDD_EVD:
	case IDD_PARAGCTXLENS:
	case IDD_INVISIBLELENS:
	case IDD_INVISIBLERELES:
	case IDD_DOCSTRUCT:
	case IDD_MARKEDTEXT:
	case IDD_SAMES:
		{
		long iOldSize = 0;
		long iNewSize = 0;

		void gk_huge* vOldBuff = m_pOldBase->LoadAttr( lDocId, iTag, iOldSize );
		if ( iOldSize == -1 ) {
			iOldSize = 0;
			vOldBuff = 0;
		}

		void gk_huge* vNewBuff = m_pNewBase->LoadAttr( lDocId, iTag, iNewSize );
		if ( iNewSize == - 1 ) {
			iNewSize = 0;
			vNewBuff = 0;
		}
			
		iRetVal = ( iNewSize != iOldSize ) || memcmp( vOldBuff, vNewBuff, iNewSize );

		if ( vOldBuff ) free ( vOldBuff );
		if ( vNewBuff ) free ( vNewBuff );
		}
		break;

	case IDD2_PARAIDS:
		{
			long iOldSize = 0;
			long iNewSize = 0;

			void gk_huge* vOldBuff = compatMode ? m_pOldBase->LoadAttr( lDocId, iTag, iOldSize ) : m_pOldBase->LoadAttrEx( lDocId, iTag, iOldSize );
			if ( iOldSize == -1 ) {
				iOldSize = 0;
				vOldBuff = 0;
			}

			void gk_huge* vNewBuff = m_pNewBase->LoadAttrEx( lDocId, iTag, iNewSize );
			if ( iNewSize == - 1 ) {
				iNewSize = 0;
				vNewBuff = 0;
			}
				
			iRetVal = ( iNewSize != iOldSize ) || memcmp( vOldBuff, vNewBuff, iNewSize );

			if ( vOldBuff ) free ( vOldBuff );
			if ( vNewBuff ) free ( vNewBuff );
		}
		break;
	
	case IDD_INFO :	{
		long iOldSize = 0;
		long iNewSize = 0;

		DocInfo* vOldBuff = (DocInfo*) m_pOldBase->LoadAttr( lDocId, iTag, iOldSize );
		if ( iOldSize == -1 ) {
			iOldSize = 0;
			vOldBuff = 0;
		}

		DocInfo* vNewBuff = (DocInfo*)m_pNewBase->LoadAttr( lDocId, iTag, iNewSize );
		if ( iNewSize == - 1 ) {
			iNewSize = 0;
			vNewBuff = 0;
		}
			
		//iRetVal = memcmp ( vOldBuff, vNewBuff, sizeof ( DocInfo ) - DOCINFO_RESERVED_SIZE );
		iRetVal = DocInfoCmp ( *vOldBuff, *vNewBuff, true );

		if ( vOldBuff ) free ( vOldBuff );
		if ( vNewBuff ) free ( vNewBuff );
	}
		break;

	case IDD_SUBS :
	{
		AttrKey aKey;
		aKey.DocId   = lDocId;
		aKey.AttrTag = iTag;
		Stream* oldStr = m_pOlddocInd->Open( &aKey );
		Stream* newStr = m_pNewdocInd->Open( &aKey );

		long	oldSize = 0;
		long 	newSize = 0;
		if ( oldStr ) oldSize = oldStr->Length();
		if ( newStr ) newSize = newStr->Length();

		iRetVal = oldSize != newSize;

		if ( !iRetVal ) {
			StorableSplaySet<SubDesc> oldSubs;
			StorableSplaySet<SubDesc> newSubs;
                        
			m_pNewdocInd->Load ( newStr, newSubs );
			m_pOlddocInd->Load ( oldStr, oldSubs );
			
			iRetVal = newSubs != oldSubs;
			
			if ( !iRetVal ) { // check sub's name
				char * pOldName = (char*) malloc ( SUB_NAME_SIZE + 1 );
				char * pNewName = (char*) malloc ( SUB_NAME_SIZE + 1 );
				
				for ( Point p = newSubs.first(); !iRetVal && p; newSubs.next(p) ) {
					m_pOldBase->FindSubName ( lDocId, oldSubs(p).Sub, pOldName );
					m_pNewBase->FindSubName ( lDocId, newSubs(p).Sub, pNewName );
					
					iRetVal = strncmp ( pOldName, pNewName, SUB_NAME_SIZE );
				}
				
				free ( pOldName );
				free ( pNewName );
			}
		} else {
			if ( oldStr ) m_pOlddocInd->Close( oldStr );
			if ( newStr ) m_pNewdocInd->Close( newStr );
		}
	}
		break;

	case IDD_SUBS_EX :
	{
		AttrKey aKey;
		aKey.DocId   = lDocId;
		aKey.AttrTag = iTag;

		Stream* oldStr = m_pOlddocInd->Open( &aKey );
		Stream* newStr = m_pNewdocInd->Open( &aKey );

		long	oldSize = 0;
		long 	newSize = 0;
		if ( oldStr ) oldSize = oldStr->Length();
		if ( newStr ) newSize = newStr->Length();

		iRetVal = oldSize != newSize;

		if (!iRetVal && (oldSize + newSize)) {
			StorableSplaySet<SubDescEx> oldSubs;
			StorableSplaySet<SubDescEx> newSubs;

			void *old_data = malloc (oldSize), *new_data = malloc (newSize);
			oldStr->Read (old_data, oldSize); newStr->Read (new_data, newSize);
			long *old_ptr = (long*) old_data, *new_ptr = (long*) new_data;
			if (*old_ptr == 0) {
				old_ptr++;
				long old_usize = *old_ptr;
				old_ptr++;
				void* old_udata = malloc (old_usize);
				G_UNZIP (old_ptr, oldSize - 2 * sizeof (long), old_udata, old_usize);
				SubDescEx *ptr = (SubDescEx*) old_udata;
				for (int i = 0; i < old_usize / sizeof (SubDescEx); i++, ptr++)
					oldSubs.add (*ptr);
				free (old_udata);
			} else {
				oldStr->Seek (0);
				m_pOlddocInd->Load ( oldStr, oldSubs );
				oldStr = 0;
			}

			if (*new_ptr == 0) {
				new_ptr++;
				long new_usize = *new_ptr;
				new_ptr++;
				void* new_udata = malloc (new_usize);
				G_UNZIP (new_ptr, newSize - 2 * sizeof (long), new_udata, new_usize);
				SubDescEx *ptr = (SubDescEx*) new_udata;
				for (int i = 0; i < new_usize / sizeof (SubDescEx); i++, ptr++)
					newSubs.add (*ptr);
				free (new_udata);
			} else {
				newStr->Seek (0);
				m_pNewdocInd->Load ( newStr, newSubs );
				newStr = 0;
			}
			free (new_data);
			free (old_data);
			
			iRetVal = newSubs != oldSubs;
		}

		if ( oldStr ) m_pOlddocInd->Close( oldStr );
		if ( newStr ) m_pNewdocInd->Close( newStr );
	}
		break;

	case IDD2_NAME:
		{
			char	pOldName[ DOC_NAME_SIZE+1 ]; pOldName[0] = 0;pOldName[DOC_NAME_SIZE] = 0;
			char	pNewName[ DOC_NAME_SIZE+1 ]; pNewName[0] = 0;pNewName[DOC_NAME_SIZE] = 0;
			Stream *str= 0;
			Ref ref;
			ref.DocId = lDocId;
			ref.Sub   = 0;

			if ((str= m_pOldBase->subNames->Open(&ref))){
				if(str->Length() > DOC_NAME_SIZE){
					str->Read(pOldName, DOC_NAME_SIZE);
				}else{
					str->Read(pOldName, str->Length());
				}
				m_pOldBase->subNames->Close(str);
			}
			if ((str= m_pNewBase->subNames->Open(&ref))){
				if(str->Length() > DOC_NAME_SIZE){
					str->Read(pNewName, DOC_NAME_SIZE);
				}else{
					str->Read(pNewName, str->Length());
				}
				m_pNewBase->subNames->Close(str);
			}
			if ( !(iRetVal = (strlen( pOldName ) != strlen( pNewName ))) ){
				iRetVal = strcmp( pOldName, pNewName );
			}
		}
		break;
	case IDD_DIV :
	case IDD_KEY :
	case IDD_ID :
	case IDD_CHDATE_EXEX :
	case IDD_ADDCODE :
	case IDD_SOURCE :
	case IDD_TYPE :
	case IDD_TAG :
	case IDD_KIND :
	case IDD_CLASS6 :
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
	{
		long iOldSize = 0;
		long iNewSize = 0;

		AttrKey aKey;
		aKey.DocId   = lDocId;
		aKey.AttrTag = iTag;
		Stream* oldStr = m_pOlddocInd->Open( &aKey );
		Stream* newStr = m_pNewdocInd->Open( &aKey );

		if ( oldStr ) iOldSize = oldStr->Length();
		if ( newStr ) iNewSize = newStr->Length();
		
		iRetVal = iOldSize != iNewSize;
		if ( !iRetVal ) {
			void* vOldBuff = m_pOlddocInd->Load ( oldStr, iOldSize );
			if ( iOldSize == -1 ) iOldSize = 0, vOldBuff = 0;
			void* vNewBuff = m_pNewdocInd->Load ( newStr, iNewSize );
			if ( iNewSize == - 1 ) iNewSize = 0, vNewBuff = 0;

			StringZ aNewKey ( (char*) vNewBuff, iNewSize, 0 );
			StringZ aOldKey ( (char*) vOldBuff, iOldSize, 0 );

			iRetVal = aNewKey.Equal ( &aOldKey ) == 0;
				
			if ( vOldBuff ) free ( vOldBuff );
			if ( vNewBuff ) free ( vNewBuff );
		} else {
			if ( oldStr ) m_pOlddocInd->Close( oldStr );
			if ( newStr ) m_pNewdocInd->Close( newStr );
		}
	}
		break;

	case IDD_REGDATE:
	case IDD_ANNULDATE:
	case IDD_ACTIVEEX:
		{
		long iOldSize = 0;
		long iNewSize = 0;

		AttrKey aKey;
		aKey.DocId   = lDocId;
		aKey.AttrTag = iTag;
		Stream* oldStr = m_pOlddocInd->Open( &aKey );
		Stream* newStr = m_pNewdocInd->Open( &aKey );

		if ( oldStr ) iOldSize = oldStr->Length();
		if ( newStr ) iNewSize = newStr->Length();
		
		iRetVal = iOldSize != iNewSize;
		if ( !iRetVal ) {
			StorableSplaySet<u_int64_t> oldSet;
			StorableSplaySet<u_int64_t> newSet;
				
			m_pNewdocInd->Load ( newStr, newSet );
			m_pOlddocInd->Load ( oldStr, oldSet );
				
			iRetVal = newSet != oldSet;
		} else {
			if ( oldStr ) m_pOlddocInd->Close( oldStr );
			if ( newStr ) m_pNewdocInd->Close( newStr );
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
		long iOldSize = 0;
		long iNewSize = 0;

		AttrKey aKey;
		aKey.DocId   = lDocId;
		aKey.AttrTag = iTag;
		Stream* oldStr = m_pOlddocInd->Open( &aKey );
		Stream* newStr = m_pNewdocInd->Open( &aKey );

		if ( oldStr ) iOldSize = oldStr->Length();
		if ( newStr ) iNewSize = newStr->Length();
		
		iRetVal = iOldSize != iNewSize;
		if ( !iRetVal ) {
			StorableSplaySet<date> oldSet;
			StorableSplaySet<date> newSet;
				
			m_pNewdocInd->Load ( newStr, newSet );
			m_pOlddocInd->Load ( oldStr, oldSet );
				
			iRetVal = newSet != oldSet;
		} else {
			if ( oldStr ) m_pOlddocInd->Close( oldStr );
			if ( newStr ) m_pNewdocInd->Close( newStr );
		}
	}
		break;
		
	case IDD_BASES:
	{
		long iOldSize = 0;
		long iNewSize = 0;

		AttrKey aKey;
		aKey.DocId   = lDocId;
		aKey.AttrTag = iTag;
		Stream* oldStr = m_pOlddocInd->Open( &aKey );
		Stream* newStr = m_pNewdocInd->Open( &aKey );

		if ( oldStr ) iOldSize = oldStr->Length();
		if ( newStr ) iNewSize = newStr->Length();
		
		iRetVal = iOldSize != iNewSize;
		if ( !iRetVal ) {
			StorableSplaySet<short> oldSet;
			StorableSplaySet<short> newSet;
				
			m_pNewdocInd->Load ( newStr, newSet );
			m_pOlddocInd->Load ( oldStr, oldSet );
				
			iRetVal = newSet != oldSet;
		} else {
			if ( oldStr ) m_pOlddocInd->Close( oldStr );
			if ( newStr ) m_pNewdocInd->Close( newStr );
		}

	}
		break;

	case IDD_LIFE:
	case IDD_UNRECIPE:
	case IDD_ALLOWED:
	case IDD_NOTLIFE:
	case IDD_NOTALLOWED:
	case IDD_RECIPE:
	{
		long iOldSize = 0;
		long iNewSize = 0;

		AttrKey aKey;
		aKey.DocId   = lDocId;
		aKey.AttrTag = iTag;
		Stream* oldStr = m_pOlddocInd->Open( &aKey );
		Stream* newStr = m_pNewdocInd->Open( &aKey );

		if ( oldStr ) iOldSize = oldStr->Length();
		if ( newStr ) iNewSize = newStr->Length();
		
		iRetVal = iOldSize != iNewSize;
		if ( !iRetVal ) {
			StorableSplaySet<long> oldSet;
			StorableSplaySet<long> newSet;
				
			m_pNewdocInd->Load ( newStr, newSet );
			m_pOlddocInd->Load ( oldStr, oldSet );
				
			iRetVal = newSet != oldSet;
		} else {
			if ( oldStr ) m_pOlddocInd->Close( oldStr );
			if ( newStr ) m_pNewdocInd->Close( newStr );
		}

	}
		break;

	default :
		logger.printf ( lt_fatal, "Unknown revising tag %ld\n", iTag );
		exit ( EXIT_FAILURE );
	}

	return iRetVal;
}

void Reviser :: SetDocRevision ( long lDocId, revision aNewRev )
{
        long iSize = 0;
		char buf [256];

        DocInfo* pInfo = (DocInfo*) m_pNewdocInd->Load ( lDocId, IDD_INFO, iSize );
		logger.printf ( lt_info, "%ld: %s -> %s\n", lDocId, sprintRev ( buf, &pInfo->Revision ), sprintRev ( buf+128, &aNewRev ) );
		pInfo->Revision = aNewRev;

        AttrKey key;
        key.DocId   = lDocId;
        key.AttrTag = IDD_INFO;

        Stream * pStr = m_pNewdocInd->Open ( &key, 0 );
        assert ( pStr );

        pStr->Write ( pInfo, iSize );

        m_pNewdocInd->Close ( pStr );

        if ( pInfo ) free ( pInfo );
}

void Reviser :: ReplaceDocRevision ( long lDocId )
{
        long iSize = 0;

        DocInfo* pOldInfo = (DocInfo*) m_pOlddocInd->Load ( lDocId, IDD_INFO, iSize );
        SetDocRevision ( lDocId, pOldInfo->Revision );

        if ( pOldInfo ) free ( pOldInfo );
}

