/*
 * cvs id was here
 */

#include "ace/ACE.h"
#include "ace/Dirent_Selector.h"

#include "basemask.h"
#include "recode.h"
#include "base.h"

#include <fstream>
#include <cctype>
#include "boost/regex.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/lambda/lambda.hpp"
#include <boost/assign/std/vector.hpp>

#include "shared/GCL/os/FileOp.h"

#define TOTAL_HEAPCHECK 1
#define DEALER_FILE "DEALER.INF"

const int Base::dfKeyFileSize = GD_KEYPAGESIZE;
const int Base::dfStrFileSize = GD_STRPAGESIZE;
const int Base::dfNdtFileSize = GD_TEXTPAGESIZE;

const char Base::m_NumberName[7]	= "Number";
const char Base::m_AuxName[8]	= "Aux.str";
const char Base::m_AttrsName[10]	= "Attrs.str";
const char Base::m_SubNamesName[12]	= "SubName.str";
const char Base::m_SWordsName[11]	= "SWords.str" ;
const char Base::m_TagName[8]	= "Tag.str" ;

const char Base::m_SubNamesExt[5]	= ".1ey";
const char Base::m_SWordsExt[5]		= ".3ey";

///////////////////////////////////////////////////////////////////////////////////////////

void AllDocsCache::load_status_ex (Base* base, DocCollection& data, short status) {
	Index* index = base->FindIndex ("Status_ex");

	if (index) {
		if (index->streams->Fat == 0) {
			index->streams->LoadFat ();
		}

		Stream* str = index->Open (&status);

		if (str) {
			data.FastLoadRefs (str);
			index->Close (str);
		}
	}
}

void AllDocsCache::load_all_docs (Base* base, DocCollection& data, short status) {
	AllDocsCache::load_status (base, data, DS_ACTIVE);

	using namespace boost::assign;

	std::vector <short> keys;
	keys += DS_ABOLISHED, DS_PREACTIVE;

	for (std::vector <short>::const_iterator it = keys.begin (); it != keys.end (); ++it) {
		DocCollection tmp;
		AllDocsCache::load_status (base, tmp, *it);
		data.Merge (tmp);
	}

	data.Deflate ();
}

void AllDocsCache::load_status (Base* base, DocCollection& data, short status) {
	Index* index = base->FindIndex ("Status");

	if (index) {
		if (index->streams->Fat == 0) {
			index->streams->LoadFat ();
		}

		Stream* str = index->Open (&status);

		if (str) {
			data.Get (str);
			index->Close (str);
		}
	}
}

DocCollection& AllDocsCache::get (Base* base, CachedData& data, const Loader& loader, short status) {
	GUARD (m_mutex);

	CachedData::iterator it = std::find_if (data.begin (), data.end (), boost::lambda::_1 == base->get_path ());

	if (it == data.end ()) {
		data.push_back (Data <DocCollection> ());
		Data <DocCollection>& item = data.back ();
		item.path = base->get_path ();
		loader (base, item.data, status);
		return item.data;
	}

	return it->data;
}

const DocCollection& AllDocsCache::get_editions (Base* base) {
	return this->get (base, m_editions, (Loader) &load_status, DS_EDITION);
}

const DocCollection& AllDocsCache::get_all_docs (Base* base) {
	return this->get (base, m_all_docs, (Loader) &load_all_docs, 0);
}

const DocCollection& AllDocsCache::get_med_docs (Base* base) {
	return this->get (base, m_med_docs, (Loader) &load_status_ex, DS_MEDTOPIC);
}

const DocCollection& AllDocsCache::get_firm_docs (Base* base) {
	return this->get (base, m_firm_docs, (Loader) &load_status_ex, DS_FIRMTOPIC);
}

void AllDocsCache::release () {
	GUARD (m_mutex);

	CachedData ().swap (m_editions);
	CachedData ().swap (m_all_docs);
	CachedData ().swap (m_med_docs);
	CachedData ().swap (m_firm_docs);
}

///////////////////////////////////////////////////////////////////////////////////////////

struct ind_info {
	char name [20];
	long dtype;
};

long GetDataType ( const char*
#ifdef MULTI_INDEX_STREAM_FILE
				  nameQ
#else
				  name
#endif
				  ) {
 static const struct ind_info g_ind_info [] = {
	{ "Adopted", SDT_DOCS },
	{ "PhGroup", SDT_DOCS },
	{ "PhEffect", SDT_DOCS },
	{ "Mkb", SDT_REFS },
	{ "Chapter", SDT_REFS },
	{ "Atc", SDT_DOCS },
	{ "RegStatus", SDT_REFS },
	{ "LekForm", SDT_REFS },
	{ "Territory", SDT_DOCS },
	{ "Type", SDT_REFS },
	{ "Kind", SDT_REFS },
	{ "PhFirm", SDT_REFS },
	{ "PhCountry", SDT_REFS },
	{ "Date", SDT_DOCS },
	{ "RegDate", SDT_REFS },
	{ "AnnulDate", SDT_REFS },
	{ "Number", SDT_DOCS },
	{ "Status", SDT_DOCS },
	{ "Status_ex", SDT_REFS },
	{ "KeyWord", SDT_REFS },
	{ "RCode", SDT_DOCS },
	{ "Respondent", SDT_REFS },
	{ "Correspondent", SDT_REFS },
	{ "RDate", SDT_DOCS },
	{ "CalIn", SDT_DOCS },
	{ "CalAb", SDT_DOCS },
	{ "CalCh", SDT_DOCS },
	{ "CalAll", SDT_DOCS },
	{ "Context", SDT_DOCS },
	{ "VIncluded", SDT_DOCS },
	{ "VChanged", SDT_DOCS },
	{ "VAbolished", SDT_DOCS },
	{ "Class", SDT_REFS },
	{ "DocKind", SDT_REFS },
	{ "SortDate", SDT_DOCS },
	{ "VAnonced", SDT_DOCS },
	{ "VLControl", SDT_DOCS },
	{ "Category", SDT_DOCS },
	{ "TradeName", SDT_DOCS },
	{ "IntName", SDT_DOCS },
	{ "PublishedIn", SDT_DOCS },
	{ "Segment", SDT_DOCS },
	{ "Class6", SDT_REFS },
	{ "NContxt", SDT_DOCS }, 
	{ "NBCntxt", SDT_REFS },
	{ "AnnoUser", SDT_DOCS },
	{ "AnnoOrganization", SDT_DOCS },
	{ "AnnoTax", SDT_DOCS },
	{ "AnnoInterest", SDT_DOCS },
	{ "AnnoKind", SDT_DOCS },
	{ "AnnoDate", SDT_DOCS },
	{ "Active", SDT_REFS },
	{ "Morpho", SDT_REFRELES },
	{ "ServiceInfo", SDT_REFS },
	{ "NewCorr", SDT_CORRREFS },
	{ "Tag", SDT_REFWEIGHTS }
};

#ifdef MULTI_INDEX_STREAM_FILE
	char name[128], *fndDot;
	strcpy(name, nameQ);
	if((fndDot= strrchr(name, '.')))
		*fndDot= 0;
#endif
	if ( !name ) return SDT_UNKNOWN;
	for ( unsigned long l=0; l<sizeof(g_ind_info); l++ ) {
		if ( !strcmp ( g_ind_info[l].name, name ) )
			return g_ind_info[l].dtype;
	}
	return SDT_UNKNOWN;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

long GetDataType (Index* ind) {
	if (!ind || !ind->Name) return SDT_UNKNOWN;
	return GetDataType (ind->Name);
}

static const statusDesck baseError [] =
{
	{ BS_OK,                BSMES_OK },
	{ BS_FILESNULL,         BSMES_FILESNULL },
	{ BS_FILESLOCKED,       BSMES_FILESLOCKED },
	{ BS_CANNOTOPENFILES,   BSMES_CANNOTOPENFILES },
	{ BS_INVALIDSIGN,       BSMES_INVALIDSIGN },
	{ BS_NOTOK,             BSMES_NOTOK },
	{ BS_DOCINDERROR,       BSMES_DOCINDERROR },
	{ BS_STREAMERROR,       BSMES_STREAMERROR }
};

short	docTags [94] =
{
	IDD_INFO,       IDD_RUNS,  IDD_BLOCKS,    IDD_SUBS
	, IDD_DATE,       IDD_ID,    IDD_SOURCE,    IDD_DIV
	, IDD_KEY,        IDD_TYPE,  IDD_BASES,     IDD_RCODE
	, IDD_VINCLUDED,  IDD_VCHANGED,  IDD_VABOLISHED, IDD_RDATE
	, IDD_SORTDATE,   IDD_WARNING,   IDD_VANONCED,   IDD_VLCONTROL
	, IDD_CATEGORY,   IDD_PUBLISHEDIN, IDD_TERRITORY,  IDD_COMPARECONTENTS
	, IDD_DOCKIND,    IDD_SOURCEFILE, IDD_ACTIVE, IDD_PAGEBREAKS
	, IDD_CHDATE, IDD_CONTENTS, IDD_NOTSURE, IDD_REFS, IDD_BLOBS, IDD_DIVISION
	, IDD_PREANNODATE, IDD_ANNODATE, IDD_PREANNOUSER, IDD_PREANNOORGANIZATION 
	, IDD_PREANNOTAX, IDD_PREANNOINTEREST, IDD_PREANNOKIND, IDD_ANNOUSER
	, IDD_ANNOORGANIZATION, IDD_ANNOTAX, IDD_ANNOINTEREST, IDD_ANNOKIND, IDD_CHANGE
	, IDD_HANDMASK, IDD_TFIDF, IDD_SAMEDOCS, IDD_SERVICEINFO, IDD_HANDHANDMASK, IDD_CLASS6
	, IDD_INPHARMFIRM, IDD_INPHARMCOUNTRY, IDD_REGDATE, IDD_ANNULDATE
	, IDD_TRADENAME, IDD_INTNAME, IDD_PHARMGROUP, IDD_PHARMEFFECT
	, IDD_CHAPTER, IDD_ATC, IDD_REGSTATUS, IDD_LEKFORM, IDD_MKB
	, IDD_LIFE, IDD_CASECODE, IDD_NOTLIFE
	, IDD_NOTALLOWED, IDD_RECIPE, IDD_UNRECIPE, IDD_ALLOWED
	, IDD_SUBS_EX, IDD_EVD
	, IDD_FASTCORRS, IDD_FASTTCORRS, IDD_ACTIVEEX, IDD_PARAHEIGHTS, IDD_PARAGCTXLENS
	, IDD_CALIN, IDD_CALAB, IDD_CALCH, IDD_DOCSTRUCT, IDD_INVISIBLELENS, IDD_INVISIBLERELES
	, IDD_KIND, IDD_CHDATE_EX, IDD_ADDCODE, IDD_CHDATE_EXEX, IDD_MARKEDTEXT, IDD_SAMES, IDD_TAG, IDD_INVISIBLEBLOCKSLENS
};

void Base::createIndices () {
	(docInd= (AttrIndex*)FindIndex("Attrs.str"))->Create(sizeof ( AttrKey ),1,1);
	FindIndex("Adopted")->Create(ADOPTED_KEY_SIZE,sizeof(long)*3,2);
	FindIndex("PhGroup")->Create(INPHARM_PHARMGROUP_SIZE,sizeof(long)*3,1);
	FindIndex("PhEffect")->Create(INPHARM_PHARMEFFECT_SIZE,sizeof(long)*3,1);
	FindIndex("Mkb")->Create(INPHARM_MKB_SIZE,sizeof(Ref)*3,1,sizeof(Ref));
	FindIndex("Chapter")->Create(INPHARM_CHAPTER_SIZE,sizeof(Ref)*3,1,sizeof(Ref));
	FindIndex("Territory")->Create(ADOPTED_KEY_SIZE,sizeof(long)*3,2);
	FindIndex("ServiceInfo")->Create(CLASS_KEY_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
	FindIndex("Atc")->Create(INPHARM_ATC_SIZE,sizeof(long)*3,1, sizeof (long));
	FindIndex("RegStatus")->Create(INPHARM_REGSTATUS_SIZE,sizeof(Ref)*3,1, sizeof (Ref));
	FindIndex("LekForm")->Create(INPHARM_REGSTATUS_SIZE,sizeof(Ref)*3,1, sizeof (Ref));
	FindIndex("PhFirm")->Create(INPHARM_FIRM_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
	FindIndex("PhCountry")->Create(INPHARM_COUNTRY_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
	FindIndex("Type")->Create(TYPE_KEY_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
	if (curr_mode != ACE_OS_O_RDONLY) FindIndex("Kind")->Create(KIND_KEY_SIZE,sizeof(Ref)*3,1, sizeof(Ref));
	FindIndex("RegDate")->Create(sizeof ( date ),sizeof(Ref)*3,1, sizeof (Ref));
	FindIndex("AnnulDate")->Create(sizeof ( date ),sizeof(Ref)*3,1, sizeof (Ref));
	FindIndex("Active")->Create(sizeof ( date ),sizeof(Ref)*3,1,sizeof (Ref));
	FindIndex("Date")->Create(sizeof ( date ),sizeof(long)*3,1);
	FindIndex("Number")->Create(CODE_KEY_SIZE,sizeof(long)*3,1);
	FindIndex("Status")->Create(2,sizeof(long)*3,1);
	FindIndex("Status_ex")->Create(2,sizeof(Ref)*3,1,sizeof (Ref));
	FindIndex("KeyWord")->Create(SEC_KW_SIZE,sizeof(Ref)*3,1,sizeof(Ref));
	FindIndex("RCode")->Create(CODE_KEY_SIZE,sizeof(long)*3,1);
	FindIndex("Respondent")->Create(4,sizeof(long)*3,1,sizeof(Ref));
	FindIndex("Correspondent")->Create(4,sizeof(long)*3,1,sizeof(Ref));
	FindIndex("RDate")->Create(sizeof(date),sizeof(long)*3,1);
	FindIndex("Context")->Create(CTX_WORD_SIZE,sizeof(long)*3,1);
	FindIndex("VIncluded")->Create(sizeof(date ),sizeof(long)*3,1);
	FindIndex("VChanged")->Create(sizeof(date ),sizeof(long)*3,1);
	FindIndex("VAbolished")->Create(sizeof(date),sizeof(long)*3,1);
	FindIndex("Class")->Create(CLASS_KEY_SIZE,sizeof(Ref)*3,2,sizeof(Ref));
	FindIndex("DocKind")->Create(CLASS_KEY_SIZE,sizeof(Ref)*3,2,sizeof(Ref));
	(subNames= FindIndex(m_SubNamesName))->Create(sizeof(Ref),1,1);
	FindIndex("SortDate")->Create(sizeof ( date ),sizeof(long)*3,1);
	FindIndex("Aux.str")->Create(5,1,1);
	FindIndex("VAnonced")->Create(sizeof(date),sizeof(long)*3,1);
	FindIndex("VLControl")->Create(sizeof(date),sizeof(long)*3,1);
	FindIndex("Category")->Create(CATEGORY_KEY_SIZE,sizeof(long)*3,1);
	FindIndex("TradeName")->Create(INPHARM_TRADENAME_SIZE,sizeof(long)*3,1);
	FindIndex("IntName")->Create(INPHARM_INTNAME_SIZE,sizeof(long)*3,1);
	FindIndex("PublishedIn")->Create(PUBLISHEDIN_KEY_SIZE,sizeof(long)*3,1);
	FindIndex("Segment")->Create(2,sizeof(long)*3,1);
	FindIndex("Blob")->Create(sizeof(ObjKey),sizeof(long)*3,2);
	FindIndex("Control")->Create(sizeof(date),sizeof(long)*3,1,2*sizeof(long));
	FindIndex("Class6")->Create(CLASS_KEY_SIZE,sizeof(Ref)*3,2,sizeof(Ref));
	FindIndex("NewCorr")->Create(4,sizeof(long)*3,1,sizeof(CorrRef));
	(docInd2 = (AttrIndex*)FindIndex("Attribs"))->Create(sizeof ( AttrKey ),1,1);
	FindIndex("AnnoUser")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
	FindIndex("AnnoOrganization")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
	FindIndex("AnnoTax")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
	FindIndex("AnnoInterest")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
	FindIndex("AnnoKind")->Create(CLASS_KEY_SIZE,sizeof(long)*3,1);
	FindIndex("AnnoDate")->Create(sizeof(date),sizeof(long)*3,1);
	FindIndex("KindCorr")->Create(sizeof(Ref),sizeof(long)*3,1);
};

LPG_OTHER_INDEX Base::checkOtherFiles(const char *nameQ, LPG_OTHER_INDEX pOther)
{
	if(!pOther && (nameQ == m_SWordsName||nameQ == m_SubNamesName||nameQ == m_TagName)){
		LPG_OTHER_INDEX pOtherNextIndexTmp= pOtherIndex;
		const char *pCheck= m_SubNamesExt;
		if(nameQ == m_SWordsName)
			pCheck= m_SWordsExt;
		while(pOtherNextIndexTmp->pKey){
			if(!strcmp(strrchr(pOtherNextIndexTmp->pKey->FileName,'.'),pCheck)) {
				pOther= pOtherNextIndexTmp;
				break;
			}
			pOtherNextIndexTmp++;
		}
	}
	return pOther;
};


Base::Base () : m_docs_block (0), m_not_del_attr (false) {
	for (size_t i = 0; i < sizeof (indTable) / sizeof (Index*); ++i) {
		indTable [i] = 0;
	}

	utmp = 0;
	keyFile = 0;
	strFile = 0;
	textFile = 0;
	streamFile = 0;
	indCount = 0;
	new_docBuf = 0;
	new_runs = 0;
	new_blocks = 0;
	max_runs = 0;
	max_blocks = 0;
	pDocFromCurrentRD = 0;
	pDocsBlockBuffer = 0;

	currentBlockSize = ADD_BLOCK_SIZE;
	clearAllTexts = lastBlockPage = 0;

	pOtherNextIndex = pOtherIndex = 0;
	curr_mode = 0;
	bLoadFatInOpened = 1;

	m_not_dynamic_load_index = false;
}

Base::~Base () {
	if (!keyFile) {
		return;
	}

	FreeIndices ();

	if (streamFile) {
		delete streamFile;
	} else if (strFile) {
		delete strFile;
	}

	if (keyFile) {
		delete keyFile;
	}

	if (textFile) {
		delete textFile;
	}

	if (m_docs_block) {
		delete m_docs_block;
	}

	if (utmp) {
		free (utmp);
	}

	baseInfos.clear ();
}

int Base :: IsOkWithoutText ()
{
	if ( keyFile == 0 || strFile == 0 ) {
		baseStatus = BS_FILESNULL;
		return 0;
	}

	if ( !keyFile->IsOpened() || !strFile->IsOpened() ) {
		baseStatus = BS_CANNOTOPENFILES;
		return 0;
	}

	if ( !keyFile -> SignatureValid () || !strFile -> SignatureValid () ) {
		baseStatus = BS_INVALIDSIGN;
		return 0;
	}

	if ( !keyFile -> IsOk () || !strFile -> IsOk () ) {
		baseStatus = BS_NOTOK;
		return 0;
	}

	if ( !docInd -> IsOk () ){
		baseStatus = BS_DOCINDERROR;
		return 0;
	}

	baseStatus = BS_OK;
	return 1;
}

int Base :: IsOk ()
{
	if ( keyFile == 0 || strFile == 0 || textFile == 0 ){
		baseStatus = BS_FILESNULL;
		return 0;
	}

	if (keyFile->IsOpened() && strFile->IsOpened() && !textFile->IsOpened()){
		baseStatus = BS_FILESLOCKED;
		return 0;
	}

	if (!keyFile->IsOpened() || !strFile->IsOpened() || !textFile->IsOpened()){
		baseStatus = BS_CANNOTOPENFILES;
		return 0;
	}

	if ( !keyFile -> SignatureValid () || !strFile -> SignatureValid ()
#ifndef _DEBUG
		|| !textFile -> SignatureValid ()
#endif
	) {
		baseStatus = BS_INVALIDSIGN;
		return 0;
	}

	if ( !keyFile -> IsOk () || !strFile -> IsOk ()
#ifndef _DEBUG
		|| !textFile -> IsOk ()
#endif
	) {
		baseStatus = BS_NOTOK;
		return 0;
	}
	baseStatus = BS_OK;
	return 1;
}

int Base :: IsPacked()
{
	if (!IsOk()) return -1;
	return (keyFile->IsPacked() || strFile->IsPacked() || textFile->IsPacked());
}

RevInfo* Base :: LoadRevInfo ( int &iCount )
{
	ContextIndex * pAuxInd = (ContextIndex *) FindIndex ( "Aux" );
	Stream * pStr = pAuxInd -> Open ( "Here" );

	if ( !pStr ) return 0;

	iCount = pStr->Length () / sizeof ( short );

	RevInfo * pRevs = (RevInfo*) malloc ( sizeof (struct RevInfo) * iCount );
	if ( !pRevs ) return 0;

	for ( int i=0; i < iCount; i ++ ) {
		short siSeg;
		pStr -> Read ( &siSeg, sizeof ( short ) );

		BaseInfo aInfo;
		FindBaseInfo ( siSeg, aInfo );
		memcpy ( pRevs[i].Name, aInfo.Name, BASE_NAME_SIZE );
		pRevs[i].LastUpdate = aInfo.LastUpdate;
	}
	pAuxInd -> Close ( pStr );

	return pRevs;
}

long Base :: GetDocCount ()
{
	IntIndex * pInd = (IntIndex*) FindIndex ( "Status" );
	assert ( pInd );

	long lCount = 0;

	int iStatus = DS_ACTIVE;
	Stream * pStr = pInd -> Open ( &iStatus );
	if ( pStr ) {
		lCount += pStr->Length () / sizeof ( long );
		pInd -> Close ( pStr );
	}

	iStatus = DS_ABOLISHED;
	pStr = pInd -> Open ( &iStatus );
	if ( pStr ) {
		lCount += pStr->Length () / sizeof ( long );
		pInd -> Close ( pStr );
	}

	iStatus = DS_PREACTIVE;
	pStr = pInd -> Open ( &iStatus );
	if ( pStr ) {
		lCount += pStr->Length () / sizeof ( long );
		pInd -> Close ( pStr );
	}

	return lCount;
}

long Base :: FindBaseInfo ( int id, BaseInfo& baseInfo )
{
	ContextIndex * baseInd  = (ContextIndex *) FindIndex ( "Aux" );
	Stream       * str      = baseInd -> Open ( "Base" );
	long           Size     = 0;

	if ( str == 0 )
		return 0;

	if ( str -> Length () < sizeof ( baseInfo ) ) {
		baseInd -> Close ( str );
		return 0;
	}

	while ( ( Size = str -> Read ( &baseInfo, sizeof ( baseInfo ) ) ) == sizeof ( baseInfo ) ){
		if ( baseInfo.BaseId == id )
			break;
	}
	baseInd -> Close ( str );
	if ( baseInfo.BaseId != id ) return 0;
	if ( !id ) return Size; // 0 baseinfo not present in Here

	// test for present in Here
	str = baseInd -> Open ( "Here" );
	if ( !str ) return 0;

	short siSeg;
	int iCount = str->Length () / sizeof ( short );
	for ( int i=0; i < iCount; i ++ ) {
		str -> Read ( &siSeg, sizeof ( short ) );
		if ( siSeg == id ) break;
	}
	baseInd -> Close ( str );
	return siSeg==id ? Size : 0;
}

long Base :: ReplaceBaseInfo ( int id, BaseInfo* pNewBaseInfo )  // by max
{
	ContextIndex * baseInd  = (ContextIndex *) FindIndex ( "Aux" );
	Stream       * str      = baseInd -> Open ( "Base" );
	long           Size     = 0;

	BaseInfo baseInfo;

	if ( str == 0 )
		return 0;

	if ( str -> Length () < sizeof ( baseInfo ) ){
		baseInd -> Close ( str );
		return 0;
	}

	while ( ( Size = str -> Read ( &baseInfo, sizeof ( baseInfo ) ) ) == sizeof ( baseInfo ) ){
		if ( baseInfo.BaseId == id ) {
			long lPos = str -> Tell () - sizeof ( baseInfo );
			str -> Seek ( lPos );
			Size = str -> Write ( pNewBaseInfo, sizeof ( BaseInfo ) );
			assert ( Size == sizeof ( BaseInfo ) );

			break;
		}
	}

	baseInd -> Close ( str );

	return Size;
}

int Base::FindDocInfo (long docId, DocInfo& info) {
	int res = FindDocAttr (docId, IDD_INFO, &info, sizeof (info));
#ifdef	_GCD_SERVER
	if (res == sizeof (info) && (docId == PROTECTED_DOCID /*|| docId == PROTECTED_DOCID_2*/))
		info.ParaCount++;
#endif
	return res;
}

int	Base :: IsCreateBase() // whether file is OK
{
	return ( curr_mode & ACE_OS_O_CREAT ) == ACE_OS_O_CREAT &&
		(( curr_mode & ACE_OS_O_RDWR ) == ACE_OS_O_RDWR
		|| ( curr_mode & ACE_OS_O_WRONLY ) == ACE_OS_O_WRONLY);
}

StreamFile* Base::make_StreamsPool (PagedFile* pFile, int bLoadFat) {
	return new StreamFile (strFile, bLoadFat);
}

Index* Base :: FindIndexOther ( const char * nameQ, LPG_OTHER_INDEX pOther )
{
	char name[MAX_LEN_FOR_INDEX_NAME+32], *pExt, namecmp [MAX_LEN_FOR_INDEX_NAME+32], *dot_pos;

	int i= 0;
	unsigned len= (unsigned)strlen(nameQ);

	if(len > MAX_LEN_FOR_INDEX_NAME)
		return 0;

	memcpy(name, nameQ, len + 1);

	pExt= strrchr(name, '.');

	if(pExt)
		*pExt= '\0';

	StrLwr(name);
	len= (unsigned)strlen(name);

	while(i < indCount && indTable [i]) {
		strcpy (namecmp, indTable [i] -> Name);
		dot_pos = strrchr (namecmp, '.');
		if (dot_pos)
			*dot_pos = '\0';
		StrLwr (namecmp);
		if (!strcmp (namecmp, name))
			return indTable [i];
		i++;
	}
	if(m_not_dynamic_load_index){
		return 0;
	}
	if(i < sizeof(indTable)/sizeof(*indTable)){
		if(pExt == 0){
			IndexInfo info;
			if(IsCreateBase() || keyFile->GetAttr ( nameQ, &info, sizeof (info))){
				if(	streamFile == 0
					&& (!(streamFile= make_StreamsPool( strFile, 0 )) || !streamFile->file)){
							if(streamFile)
								delete streamFile;
							streamFile= 0;
							return 0;
				}
				if(			!strcmp(name, "vincluded") ||
							!strcmp(name, "vchanged") ||
							!strcmp(name, "vabolished") ||
							!strcmp(name, "vanonced") ||
							!strcmp(name, "date") ||
							!strcmp(name, "annodate") ||
							!strcmp(name, "control") ||
							!strcmp(name, "rdate") ||
							!strcmp(name, "sortdate") ||
							!strcmp(name, "vlcontrol")){
					indTable[i] = new DateIndex( keyFile, nameQ, streamFile );
				}else if (	!strcmp (name, "regdate") || !strcmp (name, "annuldate") || !strcmp (name, "active")) {
					indTable[i] = new DateRefIndex( keyFile, nameQ, streamFile );
				}else if(	!strcmp(name, "blob")){
					indTable[i] = new BlobIndex( keyFile, nameQ, streamFile );
				}else if(	!strcmp(name, "keyword")){
					indTable[i] = new KeyWordIndex( keyFile, nameQ, streamFile );
				}else if(	!strcmp(name, "status") ||
							!strcmp(name, "status_ex") ||
							!strcmp(name, "segment")){
					indTable[i] = new IntIndex( keyFile, nameQ, streamFile );
				}else if(	!strcmp(name, "respondent") ||
							!strcmp(name, "correspondent") ||
							!strcmp(name, "newcorr")){
					indTable[i] = new LongIndex( keyFile, nameQ, streamFile );
				}else if(	!strcmp(name, "number") ||
							!strcmp(name, "rcode") ||
							!strcmp(name, "intname") ||
							!strcmp(name, "tradename") ||
							!strcmp(name, "category")){
					indTable[i] = new Index( keyFile, nameQ, streamFile );
				}else if(	!strcmp(name, "adopted") ||
							!strcmp(name, "phgroup") ||
							!strcmp(name, "pheffect") ||
							!strcmp(name, "mkb") ||
							!strcmp(name, "chapter") ||
							!strcmp(name, "atc") ||
							!strcmp(name, "regstatus") ||
							!strcmp(name, "lekform") ||
							!strcmp(name, "serviceinfo") ||
							!strcmp(name, "phfirm") ||
							!strcmp(name, "phcountry") ||
							!strcmp(name, "type") ||
							!strcmp(name, "kind") ||
							!strcmp(name, "annouser") ||
							!strcmp(name, "annoorganization") ||
							!strcmp(name, "annotax") ||
							!strcmp(name, "annointerest") ||
							!strcmp(name, "annokind") ||
							!strcmp(name, "class") ||
							!strcmp(name, "class6") ||
							!strcmp(name, "publishedin") ||
							!strcmp(name, "territory") ||
							!strcmp(name, "dockind")){
					indTable[i] = new HIndex( keyFile, nameQ, streamFile );
				}else if(!strcmp(name, "aux")) {
					indTable[i] = new ContextIndex( keyFile, nameQ, streamFile );
				}else if(!strcmp(name, "context")){
					indTable[i] = new ContextStrIndex( keyFile, nameQ, streamFile );
				}else if(!strcmp(name, "attrs") || !strcmp(name, "attribs")) {
					indTable[i]= new AttrIndex(	keyFile, nameQ, streamFile );
					if(!strcmp(name, "attrs"))
						docInd= (AttrIndex*)indTable[i]; 
				}else if(!strcmp(name, "kindcorr")) {
					indTable[i]= new RealRefIndex( keyFile, nameQ, streamFile );
				}else
					indTable[i] = subNames= new RefIndex( keyFile, nameQ, streamFile );
			}else{
				return FindIndex(strcat(strcpy(namecmp, nameQ), ".str"));
			}
		}else{
			*pExt= '.';
			pOther= OpenStreams(nameQ, pOther);

			if(!strcmp(name, "attrs.str") || !strcmp(name, "attribs.str")){
				indTable[i]= new AttrIndex(	pOtherNextIndex->pKey, nameQ,
													pOtherNextIndex->pStreamFile);
				if(!strcmp(nameQ, m_AttrsName))
					docInd= (AttrIndex*)indTable[i];
			}else if(	!strcmp(name, "keyword.str")){
				indTable[i] = new KeyWordIndex( pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile );
			}else if(	!strcmp(name, "status.str") ||
						!strcmp(name, "segment.str")){
				indTable[i] = new IntIndex( pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile );
			}else if(	!strcmp(name, "respondent.str") ||
						!strcmp(name, "correspondent.str") ||
						!strcmp(name, "swords.str")){
				indTable[i] = new LongIndex( pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile );
			}else if(	!strcmp(name, "number.str") ||
						!strcmp(name, "rcode.str") ||
						!strcmp(name, "category.str")){
				indTable[i] = new Index( pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile );
			}else if(	!strcmp(name, "vincluded.str") ||
						!strcmp(name, "vchanged.str") ||
						!strcmp(name, "vabolished.str") ||
						!strcmp(name, "vanonced.str") ||
						!strcmp(name, "date.str") ||
						!strcmp(name, "rdate.str") ||
						!strcmp(name, "sortdate.str") ||
						!strcmp(name, "calin.str") ||
						!strcmp(name, "calab.str") ||
						!strcmp(name, "calch.str") ||
						!strcmp(name, "vlcontrol.str")){
				indTable[i]= new DateIndex(	pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile);
			}
			else if(!strcmp(name, "nwcntxt.str")){
				indTable[i]= makeMorphoIndex(pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile);
				((NContxtIndex*)(indTable[i]))->base = this;
			}else if(!strcmp(name, "nfcontxt.str")){
				indTable[i]= new FContxtIndex(	pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile);
			}else if(!strcmp(name, "subname.str")){
				indTable[i]= subNames= new RefIndex( pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile);
			}else if(	!strcmp(name, "adopted.str") ||
						!strcmp(name, "type.str") ||
						!strcmp(name, "kind.str") ||
						!strcmp(name, "class.str") ||
						!strcmp(name, "class6.str") ||
						!strcmp(name, "publishedin.str") ||
						!strcmp(name, "territory.str") ||
						!strcmp(name, "dockind.str")){
				indTable[i]= new HIndex			(pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile);
			}else  if(!strcmp(name, "tag.str")){
				indTable[i]= new Index (pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile);
			}else if (!strcmp (name, "context.str")) {
				indTable[i]= new ContextStrIndex	(pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile);
			} else {
				indTable[i]= new ContextIndex	(pOtherNextIndex->pKey, nameQ, pOtherNextIndex->pStreamFile);
			}

			if(pOther){
				pOtherNextIndex->pKey= 0;
				pOtherNextIndex->pStreamFile= 0;
			}else
				pOtherNextIndex++;
		}
		indCount++;
		return indTable[i];
	}

	return 0;
}

Index* Base :: FindIndex ( const char * name )
{
	if(textFile->m_readed.currentDisk){
		char *buff= new char[textFile->PageSize];
		textFile->PagedFile::GetPage(1, buff);
		delete []buff;
	}
	return FindIndexOther(name);
}

void Base :: FreeIndices ()
{
	if(indCount){
		while( indCount-- )
			if ( indTable[ indCount ] ) {
				delete indTable [indCount];
				indTable [indCount] = 0;
			}
			indCount = 0;
	}
}

int Base :: FindSubName ( long DocId, long Sub, char * buf )
{
	Ref ref = {DocId, Sub};
	buf [0]   = 0;

	Index *subnames_idx = subNames;
	Stream *str = 0;
	if (bases_ptrs.size ()) {
		std::map<long,char>::const_iterator base_it = map_doc_basechar.find (DocId);
		if (base_it != map_doc_basechar.end ())
			subnames_idx = bases_ptrs [base_it->second]->subNames;
	}

	str = subnames_idx->Open (&ref);	

	if (str == 0)
		return 0;

	int res = (int) str -> Read (buf, str->Length ());

	subnames_idx->Close (str);

	return res;
}

int Base :: SetSubName ( long DocId, long Sub, char * buf, long size )
{
	Ref ref = {DocId, Sub};

	Index *subnames_idx = subNames;
	if (bases_ptrs.size ()) {
		std::map<long,char>::const_iterator base_it = map_doc_basechar.find (DocId);
		if (base_it != map_doc_basechar.end ())
			subnames_idx = bases_ptrs [base_it->second]->subNames;
	}

	return subnames_idx->SetData (&ref, buf, size);
}

int Base::FindDocName (long DocId, char * buf) {
	return FindSubName (DocId, 0, buf);
}

#include "../../GPersn/src/PL_Types.h"

extern "C" int __stdcall pl_GetFileList(char *InputedBaseFileName, LPPL_BASE_FILE_LIST *ppList);
extern "C" int __stdcall pl_FreeFileList(LPPL_BASE_FILE_LIST pList);

const char *pTempFileFormat0= "%s_0tmp%d.tmp";
const char *pTempFileListFormat0= "%s_0list.tmp";
const char *pTempFileFormat1= "%s_1tmp%d.tmp";
const char *pTempFileListFormat1= "%s_1list.tmp";
const char *pTempFileFormat2= "%s_2tmp%d.tmp";
const char *pTempFileListFormat2= "%s_2list.tmp";

void *Base::getDefList(char *, void *)
{
	return 0;
}

void Base::freeDefList(void *pList)
{
	pl_FreeFileList((LPPL_BASE_FILE_LIST)pList);
}

StrList	*Base :: GetFileList()
{
	LPPL_BASE_FILE_LIST pList, pNxt;
	char baseName[1024], *fnd1;

	if(!(fnd1= strrchr(strcpy(baseName, keyFile->FileName), '.'))){
		return 0;
	}
	if((pNxt= (LPPL_BASE_FILE_LIST)(getDefList(baseName,&pList)))){
		*fnd1= 0;
		StrList* names = new StrList;
		do{
			names->insert(pNxt->pFileName);
		}while((pNxt=(LPPL_BASE_FILE_LIST)pNxt->pNext));
		freeDefList(pList);
		char context_file [1024];
		sprintf (context_file, pTempFileListFormat0, baseName);
		int handle = c_io_open (context_file, ACE_OS_O_RDONLY|ACE_OS_O_BINARY);
		if (handle != -1) {
			names->insert (context_file);
			c_io_close (handle);
		}
		int flash_count = 0;
		while (true) {
			sprintf (context_file, pTempFileFormat0, baseName, flash_count);
			handle = c_io_open (context_file, ACE_OS_O_RDONLY|ACE_OS_O_BINARY);
			if (handle == -1)
				break;
			names->insert (context_file);
			c_io_close (handle);
			flash_count++;    
		}

		return names;
	}
	*fnd1= 0;
	return 0;
}

int Base::FindDoc (long DocId) {
	DocInfo info;
	return FindDocAttr (DocId, IDD_INFO, &info, sizeof (info)) == sizeof (info);
}

int Base::FindDocAttr (long DocId, int tag, void* buf, int size) {
#ifdef MULTI_INDEX_STREAM_FILE
	if(docInd == 0 && (docInd= (AttrIndex*)FindIndex("Attrs")) == 0){
		baseStatus = BS_DOCINDERROR;
		return 0;
	}
#endif
	if (bases_ptrs.size ()) {
		std::map<long,char>::const_iterator base_it = map_doc_basechar.find (DocId);
		if (base_it != map_doc_basechar.end ())
			return bases_ptrs [base_it->second]->docInd->Get (DocId, tag, buf, size);
	}
	return docInd->Get (DocId, tag, buf, size);
}

extern "C" char *GetBasedExtFileName( char *, int );

int Base :: GetObjTmNumber ()
{
	int number, fh;
	char *pFnd= strrchr(textFile->FileName, '.') + 1;

	number= (int)((PagedFileHeader *)textFile->SystemPageBuf)->TomPerPages;

	if( number < 0 || number > MAX_COUNT_FILE_HANDLES)
		return 0;

	memcpy(pFnd, GB_NDT_EXT, 3);
	if(GetBasedExtFileName(textFile->FileName, number) == 0){
		memcpy(pFnd, GB_NDT_EXT, 3);
		return -1;
	}
	if((fh= c_io_open(textFile->FileName, textFile->m_mode | ACE_OS_O_BINARY)) != -1){
		char *pFnd0;
		c_io_close(fh);
		textFile->m_readed.currentDisk= m_iFirstCD= number;
		*(pFnd0= strrchr(textFile->FileName, '.'))= 0;
		reConnectKeyAndStr(textFile->FileName, textFile->m_mode);
		*pFnd0= '.';
		number= m_iFirstCD+1;
	}else
		number++;

	memcpy(pFnd, GB_NDT_EXT, 3);
	return number;
}

int Base :: GetDocTmNumber (long Id)
{
	if( ((PagedFileHeader *)textFile->SystemPageBuf)->TomPerPages < 1
		|| ((PagedFileHeader *)textFile->SystemPageBuf)->TomPerPages > MAX_COUNT_FILE_HANDLES)
		return 0;

	int j= (int)((PagedFileHeader *)textFile->SystemPageBuf)->TomPerPages;  

	char *pFnd= strrchr(textFile->FileName, '.') + 1;
	Document* docum1= 
#ifdef MULTI_INDEX_STREAM_FILE
		0;
	if( pDocFromCurrentRD && pDocFromCurrentRD->DocId != Id ){
		delete pDocFromCurrentRD;
		pDocFromCurrentRD= 0;
	}
	if(pDocFromCurrentRD)
		docum1= pDocFromCurrentRD;
	else
		docum1= pDocFromCurrentRD=
#endif
		new Document ( this, Id );

	if(docum1 == 0 || docum1->DocId == -1L)
		return -1;

	int fh, run = 0, i = docum1->blocks [0].Pos1;
	for ( ; i >= docum1->runs [run].Count; run++ )
		i -= docum1->runs [run].Count;

	PF_PARAM tmp;
	tmp.pHeader= textFile->SystemPageBuf;
	tmp.page = docum1->runs [run].StartPage + i;
	i= IsNextTom(&tmp);

#ifndef MULTI_INDEX_STREAM_FILE
	delete docum1;
#endif
	memcpy(pFnd, GB_NDT_EXT, 3);
	if(GetBasedExtFileName(textFile->FileName, i)== 0){
		memcpy(pFnd, GB_NDT_EXT, 3);
		return -1;
	}
	if((fh= c_io_open(textFile->FileName, textFile->m_mode | ACE_OS_O_BINARY)) != -1){
		if(textFile->m_postFileHandles[i] == -1){
			textFile->m_postFileHandles[i]= fh;
			textFile->m_postFilePoss[i] = 0l;
		}else
			c_io_close(fh);
		if(m_iFirstCD != i){
			memcpy(pFnd, GB_NDT_EXT, 3);
			if(GetBasedExtFileName( textFile->FileName,m_iFirstCD)== 0){
				memcpy(pFnd, GB_NDT_EXT, 3);
				return -1;
			}
			if((run= c_io_open(textFile->FileName, textFile->m_mode | ACE_OS_O_BINARY)) == -1){
				char *pFnd0;
				textFile->m_readed.currentDisk= i;
				*(pFnd0= strrchr(textFile->FileName, '.'))= 0;
				reConnectKeyAndStr(textFile->FileName, textFile->m_mode);
				*pFnd0= '.';
			}else
				c_io_close(run); 
			m_iFirstCD= i;
		}
		memcpy(pFnd, GB_NDT_EXT, 3);
		return i;
	}
	do{
		if(i != j){
			memcpy(pFnd, GB_NDT_EXT, 3);
			if(GetBasedExtFileName((char*)textFile->FileName, j) == 0){
				memcpy(pFnd, GB_NDT_EXT, 3);
				return -1;
			}
			if((fh= c_io_open(textFile->FileName, textFile->m_mode | ACE_OS_O_BINARY)) != -1){
				if(textFile->m_postFileHandles[j] == -1){
					textFile->m_postFileHandles[j]= fh;
					textFile->m_postFilePoss[j] = 0l;
				}else
					c_io_close(fh);
				if(m_iFirstCD != j){
					memcpy(pFnd, GB_NDT_EXT, 3);
					if(GetBasedExtFileName( textFile->FileName,
						m_iFirstCD)== 0){
							memcpy(pFnd, GB_NDT_EXT, 3);
							return -1;
					}
					if((run= c_io_open(textFile->FileName, textFile->m_mode | ACE_OS_O_BINARY)) == -1){
						char *pFnd0;
						textFile->m_readed.currentDisk= j;
						*(pFnd0= strrchr(textFile->FileName, '.'))= 0;
						reConnectKeyAndStr(textFile->FileName, textFile->m_mode);
						*pFnd0= '.';
					}else
						c_io_close(run); 
					m_iFirstCD= j;
				}
				memcpy(pFnd, GB_NDT_EXT, 3);
				return i;
			}
		}
	}while(j--);
	memcpy(pFnd, GB_NDT_EXT, 3);
	return i;
}

Document* Base::GetDoc (long DocId, const DocInfo* p_DocInfo) {
	if (bases_ptrs.size ()) {
		std::map<long,char>::const_iterator base_it = map_doc_basechar.find (DocId);
		if (base_it != map_doc_basechar.end ())
			return new Document (bases_ptrs [base_it->second], DocId, p_DocInfo);
	}
	return new Document (this, DocId, p_DocInfo);
}

int Base::DelDoc (long DocId, bool b_removetext, bool b_removesubnames) {
	if (b_removetext) {
		long RunCount = 0, BlockCount = 0;

		PageRun *runs = (PageRun*) docInd->Load (DocId, IDD_RUNS, RunCount);
		BlockRec *blocks = (BlockRec*) docInd->Load (DocId, IDD_BLOCKS, BlockCount);

		RunCount   /= (int) sizeof (PageRun);
		BlockCount /= (int) sizeof (BlockRec);
		DelText (DocId, runs, RunCount, blocks, BlockCount);
		gk_free (blocks);
		gk_free (runs);
	}

	for (long i = 0; i < sizeof (docTags) / sizeof (short); i++ )
		docInd -> Del ( DocId, docTags [i] );
	docInd2->Del (DocId, IDD2_PARAIDS);

	if (b_removesubnames) {
		long SubCount = 0;
		SubDesc* subs = (SubDesc*) docInd->Load (DocId, IDD_SUBS, SubCount);
		SubCount /= (int) sizeof (SubDesc);

		Ref ref = {DocId, 0};
		subNames->Delete (&ref);

		for (long i = 0; i < SubCount; i++) {
			ref.Sub = subs [i].Sub;
			subNames->Delete (&ref);
		}
		gk_free (subs);
	}

	return 1;
}

int Base::DelText (long DocId, PageRun* runs, long RunCount, BlockRec* blocks, long BlockCount)
{
	PageRun* runsL= 0;                        // pointer to an array of PageRuns

	if(!runs){
		runsL= runs= (PageRun  *) docInd -> Load ( DocId, IDD_RUNS,   RunCount );
		RunCount   /= sizeof ( PageRun );
	}
	if(strFile->GetAttr( ID_PACKED_NDT, (void*)"", 0 )){
		BlockRec * blocksL= 0;
		if(!blocks){
			blocksL= blocks= (BlockRec *) docInd -> Load ( DocId, IDD_BLOCKS, BlockCount );
			BlockCount /= (int) sizeof ( BlockRec );
		}
		int i, no= 0, run, pos;
		for(no= 0; no < BlockCount; no++){
			if(currentBlockSize == ADD_BLOCK_SIZE && blocks [no].Pos2 < 0)
				continue;

			for ( i = blocks [no].Pos1, run = 0; i >= runs [run].Count; run++ )
				i -= runs [run].Count;

			for ( pos = blocks [no].Pos1; pos < blocks [no].Pos2; pos++ ){
				textFile -> DelPage ( runs [run].StartPage + i );
				if ( ++i >= runs [run].Count ){
					i = 0;			// switch to next ruh
					run++;
				}
			}
		}
		if(blocksL)
			gk_free ( blocksL );
	}
	/*#if (defined(_WIN64) || defined(__LP64__))
	#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
	// Для GU, где индекс всегда с боку и новые тексты в Context.str
	#else
	else for ( long i = 0; i < RunCount; i++ )
	for ( long j = 0; j < runs [i].Count; j++ )
	textFile -> DelPage ( runs [i].StartPage + j );
	#endif
	#else*/
	else for ( long i = 0; i < RunCount; i++ )
		for ( long j = 0; j < runs [i].Count; j++ )
			textFile -> DelPage ( runs [i].StartPage + j );
	//#endif
	if(runsL){
		if (m_not_del_attr == false) {
			docInd->Del(DocId, IDD_INFO);
			docInd->Del(DocId, IDD_RUNS);
			docInd->Del(DocId, IDD_BLOCKS);
		}
		gk_free ( runsL );
	}
	return 1;
}

int Base :: RenameDoc ( long fromId, long toId )
{
	AttrKey from, to;

	from.DocId = fromId;
	to.DocId   = toId;

	for ( int i = 0; i < sizeof (docTags) / sizeof (short); i++ ){
		from.AttrTag = docTags [i];
		to.AttrTag   = docTags [i];

		if ( !docInd -> Rename ( &from, &to ) )
			return 0;
	}

	return 1;
}

DocCollection* Base::AllDocs () {
	return new DocCollection (AllDocsCache::instance ()->get_all_docs (this));
}

DocCollection* Base::inpharm_medtopics () {
	return new DocCollection (AllDocsCache::instance ()->get_med_docs (this));
}

DocCollection* Base::inpharm_firmtopics () {
	return new DocCollection (AllDocsCache::instance ()->get_firm_docs (this));
}

RefCollection* Base::get_all_drugs_with_forms () {
	RefCollection *data = new RefCollection();
	Index* index = FindIndex ("Status_ex");
	short key = DS_ALLOWED;
	Stream* str;
	if (str = index->Open (&key)) {
		data->Get (str);
		index->Close (str);
	}
	key = DS_NOTALLOWED;
	if (str = index->Open (&key)) {
		RefCollection na;
		na.Get (str);
		index->Close (str);
		data->Merge (na);
	}
	return data;
}

DocCollection* Base :: AllMDocs ()
{
	Index* ind = FindIndex( "Status_ex" );
	if ( !ind ) return 0;

	DocCollection *result = new DocCollection();

	short keys [2];
	keys [0] = DS_MEDTOPIC;
	keys [1] = DS_FIRMTOPIC;

	for ( int i = 0; i < 2; i++) {
		Stream * str = ind->Open( keys+i );
		if ( str ) {
			if ( !result->ItemCount )
				result->FastLoadRefs (str);
			else {
				DocCollection tmp;
				tmp.FastLoadRefs (str);
				result->Merge (tmp);
			}
			ind->Close(str);
		}
	}

	return result;
}

DocCollection* Base :: AllTopics (long borderId)
{
	DocCollection * col = new DocCollection;

	if (bases_ptrs.size ()) {
		std::vector<long> ids;
		for (std::vector<Base*>::const_iterator base_it = bases_ptrs.begin (); base_it != bases_ptrs.end (); base_it++) {
			static const AttrKey key = { borderId, IDD_INFO };
			for ( BTIterator it ( (*base_it)->docInd, &key ); !it.End (); ++it ) {
				AttrKey * ptr = (AttrKey *) it.Key ();

				if (ptr -> AttrTag == IDD_INFO)
					ids.push_back (ptr->DocId);					
				else
					break;
			}
		}
		std::sort (ids.begin (), ids.end ());
		ids.erase (std::unique (ids.begin (), ids.end ()), ids.end ());
		for (std::vector<long>::const_iterator it = ids.begin (); it != ids.end (); it++) {
			long id = *it;
			col->Collection::Add (&id);
		}
	} else {
		static const AttrKey key = { borderId, IDD_INFO };
		for ( BTIterator it ( docInd, &key ); !it.End (); ++it ) {
			AttrKey * ptr = (AttrKey *) it.Key ();

			if ( ptr -> AttrTag == IDD_INFO )
				col -> Collection::Add ( &ptr -> DocId );
			else
				break;
		}
	}

    return col;
}

bool	Base :: isAnnoPresent()
{
    Index* auxInd = FindIndex( "Aux" );
    Stream *str = auxInd->Open( "Here" );
    if ( !str )
		return false;

    bool result = false;	
	int count = str->Length() / sizeof( short );
    for ( int i = 0; i < count && !result; i ++ ) {
        short siSeg;
        str->Read( &siSeg, sizeof( short ));
		if ( siSeg == ANNO_SEGMENT )
			result = true;
	}

	auxInd->Close(str);
	return result;
}

bool	Base :: is_consulting_present()
{
	Index* auxInd = FindIndex( "Aux" );
	Stream *str = auxInd->Open( "Here" );
	if ( !str )
		return false;

	bool result = false;	
	int count = str->Length() / sizeof( short );
	for ( int i = 0; i < count && !result; i ++ ) {
		short siSeg;
		str->Read( &siSeg, sizeof( short ));
		if ( siSeg == CONSULTING_SEGMENT )
			result = true;
	}

	auxInd->Close(str);
	return result;
}

char*	Base :: GetPersInfo(u_int32_t sid)
{
	char pswd [sizePswdAttr]; gk_bzero (pswd, sizeof (pswd));
	if (!textFile->GetAttr (tagPswdAttr, pswd, sizePswdAttr))
		return 0;

	if (sid) {
		char s_sid [6], s_sid_pswd [6 + sizePswdAttr];
		sprintf (s_sid, "%05d", sid);
		strcat (strcpy (s_sid_pswd, s_sid), pswd);
		u_int16_t hash = (u_int16_t) (gkdb_HashRot13 (s_sid_pswd) & 0xFFFF);
		u_int32_t hash_sid = (((u_int32_t)hash) << 16) + sid;
		char s_hash_sid [16];
		sprintf (s_hash_sid, "%010u", hash_sid);

		char *result = (char*) malloc (strlen (pswd) + 11);
		strcat (strcpy (result, s_hash_sid), pswd);
		return result;
	} else {
		return strdup (pswd);
	}

}

long	Base :: GetClientInfo()
{
	long ci = 0;
	if ( !textFile->GetAttr( tagKIAttr, &ci, sizeof( ci )))
		return 0;

	return ci;
}

long Base :: SubToPara ( Ref& ref )
{
    if (!ref.Sub)
		return 0;

	long lSubCount, sub = ref.Sub, para = 0;
    SubDesc *subs = (SubDesc*) docInd->Load (ref.DocId, IDD_SUBS, lSubCount), *ptr = subs;
    lSubCount = lSubCount / sizeof (SubDesc);

    if (!subs)
		return para;

    for (long l = 0; l < lSubCount; l++, ptr++) {
		if (ptr->Sub == sub) {
            para = ptr->Para;
			break;
        }
    }

    gk_free (subs);
    return para;
}

void Base::InitProgress (long, int* pComplete) {
    *pComplete = 0;
}

void Base::ShowCheckedProgress (long checked) {
}

void Base::DoneProgress () {
}

const char * Base::strBaseStatus ()
{
	for ( short s=0; s < sizeof ( baseError ); s++ ) {
		if ( baseError[s].status == baseStatus )
			return baseError [s].desck;
	}
	return 0;
}

int32_t Base::CheckReady ( int16_t sUtilId )
{
	GDataStatusMask aMask ( sUtilId );
	int32_t lReady;
	if ( ! keyFile->GetAttr ( "Ready", &lReady, sizeof ( lReady ) ) )
		return -1;

	return aMask.CheckMask ( lReady );
}

int32_t Base::SetReady ( int16_t sUtilId )
{
	GDataStatusMask aMask ( sUtilId );
	int32_t lReady;
	if ( ! keyFile->GetAttr ( "Ready", &lReady, sizeof ( lReady ) ) )
		return -1;
	lReady = aMask.SetMask ( lReady );
	keyFile->PutAttr ( "Ready", &lReady, sizeof ( lReady ) );
	return lReady;
}

int32_t Base::GetReady ()
{
	int32_t lReady;
	if ( !keyFile->GetAttr ( "Ready", &lReady, sizeof ( lReady ) ) )
		return -1;

	return lReady;
}

char*   Base :: GetDealerInfo( long& lSize )
{
	char* pPath = (char*) malloc ( strlen (textFile->FileName) + 16 );
	assert ( pPath );

	strcpy ( pPath, textFile->FileName );

	char * pSlash = strrchr (pPath, '\\' );
	if ( !pSlash ) pSlash = strrchr (pPath, '/' );
	if ( !pSlash ) pSlash = pPath; else pSlash++;

	strcpy ( pSlash, DEALER_FILE );

	FILE* pMessFile = mpcxc_fopen ( pPath, "rt" );
	free ( pPath );

	if ( !pMessFile ) {
		lSize = 0;
		return 0;
	}

	fseek ( pMessFile, 0, ACE_OS_SEEK_END );
	lSize = ftell ( pMessFile );

	rewind ( pMessFile );
	char * pNewMess = (char*) malloc ( lSize + 1 );
	assert (pNewMess);

	lSize = fread ( pNewMess, 1, lSize, pMessFile );
	pNewMess[lSize] = 0;

	fclose ( pMessFile );
	Recoding (cd_dos, cd_win, pNewMess);
	return pNewMess;
}

IGarDoc *Base::GetGarDoc( long id, DocInfo *local_docInfo)
{
	return GetDoc (id, 0);
}

long	Base::translation_topic (long docid)
{
	return (docid+ID_TRANSPLUS);
}

bool	Base::is_translation_present (long docid)
{
	return FindDoc (translation_topic (docid));
}

bool	Base::is_samedocs_presents (long docid)
{
	AttrKey aKey = {docid, IDD_SAMEDOCS};
	return (FindIndex("Attrs")->IsExist(&aKey));
}

DocCollection*	Base::docs_wo_class ()
{
	DocCollection *result = AllDocs ();

	Index* class_index = FindIndex ("Class");
	for (BTIterator it (class_index); !it.End (); ++it) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*)it.Key();
		if (!key->level) {
			Stream* str = class_index->Index::OpenN (key, 0);
			if (str) {
				DocCollection docs;
				docs.FastLoadRefs (str);
				class_index->Close (str);
				result->Minus (docs);
			}
		}
	}

	return result;
}

char* Base::get_swords_data (const std::string& src, long id, long& sz) {
	char key [64];
	::memset (key, 0, sizeof (key));
	::memcpy ((src != SIDE_INDEX_NAME)? key : key + 1, &id, sizeof (long));

	sz = 0;

	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > ret;

	Index* index = FindIndex (src.c_str ());

	Stream* stream = index->OpenN (key, 0);

	if (stream) {
		sz = stream->Length ();

		if (sz) {
			ret = new char [sz + 4];
			stream->Read (ret.inout (), sz);
		}

		index->Close (stream);
	}

	return ret._retn ();
}

DocCollection*	Base::docs_wo_key ()
{
	DocCollection *result = AllDocs ();

	Index* key_index = FindIndex ("KeyWord");
	for (BTIterator it (key_index); !it.End (); ++it) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*)it.Key();
		if (!key->level) {
			Stream* str = key_index->Index::OpenN (key, 0);
			if (str) {
				DocCollection docs;
				docs.FastLoadRefs (str);
				key_index->Close (str);
				result->Minus (docs);
			}
		}
	}

	return result;
}

DocCollection*	Base::anonced_wo_included ()
{
	DocCollection *result = new DocCollection ();

	{
	Index* index = FindIndex ("VAnonced");
	for (BTIterator it (index); !it.End (); ++it) {
		Stream* str = index->Open (it.Key ());
		if (str) {
			DocCollection docs;
			docs.Get (str);
			index->Close (str);
			result->Merge (docs);
		}
	}
	}

	{
	Index* index = FindIndex ("VIncluded");
	for (BTIterator it (index); !it.End (); ++it) {
		Stream* str = index->Open (it.Key ());
		if (str) {
			DocCollection docs;
			docs.Get (str);
			index->Close (str);
			result->Minus (docs);
		}
	}
	}

	return result;
}

long	Base::find_firm (const char* firm)
{
	long result = 0;
	char afirm [INPHARM_FIRM_SIZE];
	strcat (strcpy (afirm, "001="), firm);
	Stream* str = FindIndex ("PhFirm")->Open (afirm);
	if (str) {
		DocCollection *docs = new DocCollection;
		docs->FastLoadRefs (str);
		FindIndex ("PhFirm")->Close (str);
		DocCollection* firm_topics = inpharm_firmtopics ();
		docs->Intersect (*firm_topics);
		delete firm_topics;
		if (docs->ItemCount)
			result = (*docs) [0];
		delete docs;
	}
	return result;
}

RefCollection*	Base::find_drugs (const char* firm)
{
	Stream* str = FindIndex ("PhFirm")->Open (firm);
	if (str) {
		RefCollection *refs = new RefCollection;
		refs->Get (str);
		FindIndex ("PhFirm")->Close (str);
		DocCollection *med_topics = inpharm_medtopics ();
		refs->Intersect (*med_topics);
		delete med_topics;
		return refs;
	}
	return 0;
}

Stream* Base::AttrKeyOpen (BTKEY k, int sn)
{
	return new Stream (docInd->streams, docInd->recordData (k,sn), docInd->ImmDataSize, docInd->roundv);
}

#ifndef OLD_SHORT_STR
	extern "C" long DefValCryptoTag;
#endif
LPG_OTHER_INDEX Base :: OpenStreams ( const char * nameQ, LPG_OTHER_INDEX pOther )
{
	char *pExt= 0;

	if((pExt= strrchr(keyFile->FileName, '.')) == 0)
		return 0;

	if(pOtherIndex == 0){
		if((pOtherIndex= (LPG_OTHER_INDEX)calloc(
		(sizeof(indTable)/sizeof(*indTable)), sizeof(*pOtherIndex))) == 0)
			return 0;
		pOtherNextIndex= pOtherIndex;
	}
	PagedFile   *pTmpKey= keyFile, *pTmpStr= strFile;
	int iTempKey= this->m_iFirstKeyHandleOnCD[textFile->m_readed.currentDisk],
		iTempStr= this->m_iFirstStrHandleOnCD[textFile->m_readed.currentDisk];
/*
#ifdef _DEBUG
  if(nameQ != m_SubNamesName && !pOther && !strcmp(nameQ, "SubName.str")){
	  // конструирование индекса из вне НЕ допустимо //
	  assert(0);
  }else
#endif
*/
	if(!pOther && (!strcmp(nameQ, "NWCntxt.str") || !strcmp(nameQ, "NCCntxt.str") || !strcmp(nameQ, "NPContxt.str"))){
		strcpy(pExt+1, "NContxt.str");
	}else{
		pOther= checkOtherFiles(nameQ, pOther);
		strcpy(pExt+1, nameQ);
	}

	*strrchr(pExt+1, '.')= '\0';
	if(pOther){
		keyFile= pOther->pKey;
		strFile= pOther->pStreamFile->file;
		pOtherNextIndex->pStreamFile= pOther->pStreamFile;
	}else{
		pOtherNextIndex->pStreamFile= 0;
		for(int ii= 0; ii < MAX_NDT_DISK_COUNT; ii++){
			pOtherNextIndex->m_iFirstKeyHandleOnCD[ii]= -1;
			pOtherNextIndex->m_iFirstStrHandleOnCD[ii]= -1;
		}
		this->m_iFirstKeyHandleOnCD[textFile->m_readed.currentDisk]= -1;
		this->m_iFirstStrHandleOnCD[textFile->m_readed.currentDisk]= -1;

		reConnectKeyAndStr(	keyFile->FileName, curr_mode);

#ifndef BRDR32
		if(IsCreateBase()){
#ifdef MIN_MEM_CONTEXT
			keyFile->Create(pTmpKey->PageSize);
#else
			keyFile->Create(pTmpStr->PageSize);
#endif
			strFile->Create(pTmpStr->PageSize);
		}
		keyFile->m_pCryptoTag= (char*)&DefValCryptoTag;
		strFile->m_pCryptoTag= (char*)&DefValCryptoTag;
#endif
	}
	pOtherNextIndex->m_iFirstKeyHandleOnCD[textFile->m_readed.currentDisk]= keyFile->GetFileHandle();
	pOtherNextIndex->m_iFirstStrHandleOnCD[textFile->m_readed.currentDisk]= strFile->GetFileHandle();
	pOtherNextIndex->pKey = keyFile;
	keyFile= pTmpKey;	pTmpKey= 0;

	strcpy (pExt + 1, "key");

	if (pOtherNextIndex->pStreamFile == 0
			&& !(pOtherNextIndex->pStreamFile= make_StreamsPool(strFile, bLoadFatInOpened))) {
		this->m_iFirstKeyHandleOnCD [textFile->m_readed.currentDisk] = iTempKey;
		this->m_iFirstStrHandleOnCD [textFile->m_readed.currentDisk] = iTempStr;
		strFile = pTmpStr;
		pTmpStr = 0;
		return 0;
	}

	if(!pOther && IsCreateBase())
		pOtherNextIndex->pStreamFile->Create();
	strFile= pTmpStr;	pTmpStr= 0;
	this->m_iFirstKeyHandleOnCD[textFile->m_readed.currentDisk]= iTempKey;
	this->m_iFirstStrHandleOnCD[textFile->m_readed.currentDisk]= iTempStr;
	return pOther;
}

Index *Base::makeMorphoIndex (::PagedFile* tf, const char* name, StreamFile* s) 
{
	return new NWContxtIndex (tf, name, s);
}

extern "C" void impModifyName(char *);

extern PagedFile *makePagedFile(const char *name, int omode);
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	PagedFile *Base::makePagedFile(const char *name, int om){
  #ifdef OLD_SHORT_STR
		if(om & ACE_OS_O_RDWR)
			return 0;
  #endif
		return ::makePagedFile(name,om);
	}
#endif


void Base::reConnectKeyAndStr (const char* n, int m) {
	char buf [1024];
	strcpy (buf, n);

	PagedFile *kF= keyFile, *sF= strFile;
	int *pKH= (int*)m_iFirstKeyHandleOnCD, *pSH= (int*)m_iFirstStrHandleOnCD;

	if( pDocFromCurrentRD ){
		delete pDocFromCurrentRD;
		pDocFromCurrentRD= 0;
	}
	if(m_iFirstKeyHandleOnCD[textFile->m_readed.currentDisk] == -1){
		if(textFile->m_readed.currentDisk){
			kF->PagedFile::SetFileHandle (c_io_open (kF->FileName, (m & ~(ACE_OS_O_CREAT)) | ACE_OS_O_BINARY));
		} else {
			ForceExt (buf, GB_KEY_EXT);
			impModifyName(buf);
			keyFile = makePagedFile(buf, m & ~(ACE_OS_O_CREAT));
		}
		if(keyFile)
			m_iFirstKeyHandleOnCD [textFile->m_readed.currentDisk] = keyFile->PagedFile::GetFileHandle ();
		if(textFile->m_readed.currentDisk && pOtherIndex){
			pOtherNextIndex= pOtherIndex;
			while(pOtherNextIndex->pKey){
				kF= pOtherNextIndex->pKey;
				pKH= (int*)pOtherNextIndex->m_iFirstKeyHandleOnCD;
				sF= pOtherNextIndex->pStreamFile->file;
				pSH= (int*)pOtherNextIndex->m_iFirstStrHandleOnCD;
				if(pKH[textFile->m_readed.currentDisk] == -1){
					kF->PagedFile::SetFileHandle(	c_io_open(	kF->FileName, (m & ~(ACE_OS_O_CREAT)) | ACE_OS_O_BINARY
															));
					pKH[textFile->m_readed.currentDisk]
						= kF->PagedFile::GetFileHandle();
				}else
					kF->PagedFile::SetFileHandle(pKH[textFile->m_readed.currentDisk]);

				if(pSH[textFile->m_readed.currentDisk] == -1){
					sF->PagedFile::SetFileHandle(	c_io_open(	sF->FileName, (m & ~(ACE_OS_O_CREAT)) | ACE_OS_O_BINARY
															));
					pSH[textFile->m_readed.currentDisk]
						= sF->PagedFile::GetFileHandle();
				}else
					sF->PagedFile::SetFileHandle(pSH[textFile->m_readed.currentDisk]);
				pOtherNextIndex++;
			}
		}
	} else {
		kF->PagedFile::SetFileHandle (pKH [textFile->m_readed.currentDisk]);
		if(pOtherIndex){
			pOtherNextIndex= pOtherIndex;
			while(pOtherNextIndex->pKey){
				kF= pOtherNextIndex->pKey;
				pKH= (int*)pOtherNextIndex->m_iFirstKeyHandleOnCD;
				sF= pOtherNextIndex->pStreamFile->file;
				pSH= (int*)pOtherNextIndex->m_iFirstStrHandleOnCD;

				kF->PagedFile::SetFileHandle(
								pKH[textFile->m_readed.currentDisk]);
				sF->PagedFile::SetFileHandle(
								pSH[textFile->m_readed.currentDisk]);
				pOtherNextIndex++;
			}
		}
	}
	if(m_iFirstStrHandleOnCD[textFile->m_readed.currentDisk] == -1){
		strcpy(buf, n);
		ForceExt (buf, GB_STR_EXT);
		impModifyName(buf);
		if(textFile->m_readed.currentDisk){
			strFile->PagedFile::SetFileHandle(	c_io_open(	buf, (m & ~(ACE_OS_O_CREAT)) | ACE_OS_O_BINARY
														));
		}else{
			strFile = makePagedFile(buf, m & ~(ACE_OS_O_CREAT));
		}
		if(strFile)
			m_iFirstStrHandleOnCD[textFile->m_readed.currentDisk]= strFile->PagedFile::GetFileHandle();
	}else{
		strFile->PagedFile::SetFileHandle(
						m_iFirstStrHandleOnCD[textFile->m_readed.currentDisk]);
	}
}

long Base::GetSizeInKbytes(int AsUnPacked) {
	long lSize= this->keyFile->GetFileSizeInKbytes(AsUnPacked)
					+ this->strFile->GetFileSizeInKbytes(AsUnPacked)
						+ this->textFile->GetFileSizeInKbytes(AsUnPacked);
	if(this->pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp= this->pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pStreamFile)
				lSize += pOtherNextIndexTmp->pStreamFile->file->GetFileSizeInKbytes(AsUnPacked);
			lSize += pOtherNextIndexTmp->pKey->GetFileSizeInKbytes(AsUnPacked);
			pOtherNextIndexTmp++;
		}
	}
	return lSize;
}

void Base :: DeletePagedFiles(int Full)
{
	if(keyFile->PageSize)
		keyFile->Delete(Full);
	if(strFile->PageSize)
		strFile->Delete(Full);
	if(textFile->PageSize)
		textFile->Delete(Full);

	if(pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp= pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pStreamFile
				&& pOtherNextIndexTmp->pStreamFile->file->PageSize)
				pOtherNextIndexTmp->pStreamFile->file->Delete(Full);
			if(pOtherNextIndexTmp->pKey->PageSize)
				pOtherNextIndexTmp->pKey->Delete(Full);
			pOtherNextIndexTmp++;
		}
	}
}

int Base :: IsPagedFilesOk()
{
	int iIsPacked= keyFile->PageSize | strFile->PageSize | textFile->PageSize;
	if(pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp= pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pStreamFile)
				iIsPacked |= pOtherNextIndexTmp->pStreamFile->file->PageSize;
			iIsPacked |= pOtherNextIndexTmp->pKey->PageSize;
			pOtherNextIndexTmp++;
		}
	}
	return iIsPacked;
}

#include "ncpf.h"
extern "C" void pl_OpenBase (LPPF_PARAM pKey, LPPF_PARAM pStr, char** keyTag, char** strTag, char** ndtTag);

void Base::initMultiIndex (const char* n, int m, int nc) {
	m_path = n;

	pOtherNextIndex = pOtherIndex = 0;
	curr_mode = 0;
	bLoadFatInOpened = 1;
	bool notPrsn= false;
	if(!(m & ~0x20000000) && (m & 0x20000000)){
		notPrsn= true;
	}
	m &= ~0x20000000;
	{
		m_iFirstCD= 0;
		for(int ii= 0; ii < MAX_NDT_DISK_COUNT; ii++){
			m_iFirstKeyHandleOnCD[ii]= -1;
			m_iFirstStrHandleOnCD[ii]= -1;
		}
		if (nc == -1)
			nc = DEFAULT_NDT_CACHE;
		else if(!nc) {
			if(m & O_NOT_FAT)
				bLoadFatInOpened= 0;
		}

	#ifdef RESTORE_HDD
		m |= ACE_OS_O_RDWR;
	#endif
			
		docInd= 0;
		subNames= 0;
		m_iFirstCD= 0;

		if(!m && notPrsn){
		}else{
			char	buf [1024];
			strcpy(buf, n);
			if(!nc || (m & ACE_OS_O_CREAT))
				textFile  = new PagedFile (ForceExt (buf, GB_NDT_EXT), m & ~(ACE_OS_O_CREAT));
			else
			textFile  = new NCPagedFile (ForceExt (buf, GB_NDT_EXT), m & ~(ACE_OS_O_CREAT), nc);
			textFile->m_readed.currentDisk= 0;
			reConnectKeyAndStr (n, m);
		}
		if(m & ACE_OS_O_CREAT){
		}else if( notPrsn || (textFile->IsOk() && keyFile->IsOk() && strFile->IsOk()) )
		{
			if(!notPrsn){
				pl_OpenBase(	&keyFile->m_readed, &strFile->m_readed,
								&keyFile->m_pCryptoTag, &strFile->m_pCryptoTag,
								&textFile->m_pCryptoTag);
				long *FirstFAT= (long *)alloca(strFile->PageSize);
				if(strFile->GetPage(3,FirstFAT)&&(FirstFAT[3] & FAT_CHAIN)&&(!(FirstFAT[3] & (~FAT_CHAIN)) || (FirstFAT[3] & (~FAT_CHAIN)) == 1+strFile->PageSize/sizeof(int))){
	#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
					// NDTClone индексный движёк не оперирует первыми двумя страницами Base::strFile //
					memset(FirstFAT,0x80,strFile->PageSize);
					strFile->PutPage(1,FirstFAT);
					strFile->PutPage(2,FirstFAT);
	#else
					FirstFAT[1]= FirstFAT[3];
					FirstFAT[3]= strFile->PageSize;
					strFile->PutPage(1,FirstFAT);
					if(m){
						memset(FirstFAT,0,strFile->PageSize);
						if(!strFile->PutPage(3,FirstFAT)){
							// модификация базы из-за ошибки записи в данные //
							abort();
						}
					}
	#endif
				}
			}
		}else{
			keyFile->m_pCryptoTag= (char*)malloc(sizeof(long));
			strFile->m_pCryptoTag= (char*)malloc(sizeof(long));
			*(long*)keyFile->m_pCryptoTag= 0L;
			*(long*)strFile->m_pCryptoTag= 0L;
		}
		docInd2 = 0;
	}
}

IndexReq* build_morpho_req (std::vector<std::string>& keys, short search_op)
{
	long size = sizeof (IndexReq);
	std::vector<std::string>::const_iterator it;
	for (it = keys.begin (); it != keys.end (); it++)
		size += it->size () + 1;

	IndexReq *req = (IndexReq*) malloc (size);
	strcpy (req->Name, "Morpho");
	req->ItemCount = keys.size ();
	req->ItemSize  = 0;
	req->SearchOp = SO_AND | SO_KEYS_AND | search_op;

	char* toput = (char*)(req+1);
	for (it = keys.begin (); it != keys.end (); it++) {
		strcpy (toput, it->c_str ());
		toput += strlen (toput);
	}

	return req;
}

IndexReq* build_req (Base *base, const char* index_name, std::vector<std::string>& keys, bool &b_inpharm)
{
	Index* index = base->FindIndex (index_name);
	IndexReq *req = (IndexReq*) malloc (sizeof (IndexReq) + keys.size () * index->KeyLength);
	req->ItemCount = 0;
	req->ItemSize  = index->KeyLength;
	req->SearchOp  = SO_AND;
	strcpy (req->Name, index_name);
	char* toput = (char*)(req+1);

	bool is_hindex = !strcmp (index_name, "LekForm") || !strcmp (index_name, "PhGroup") || !strcmp (index_name, "PhEffect") || !strcmp (index_name, "Mkb") || !strcmp (index_name, "Chapter") || !strcmp (index_name, "Atc") || !strcmp (index_name, "PhFirm") || !strcmp (index_name, "PhCountry");
	is_hindex |= !strcmp (index_name, "Type") || !strcmp (index_name, "Kind") || !strcmp (index_name, "Territory")  || !strcmp (index_name, "Adopted") || !strcmp (index_name, "Class");
	bool is_strindex = !strcmp (index_name, "TradeName") || !strcmp (index_name, "IntName") || !strcmp (index_name, "Category") || !strcmp (index_name, "Tag");
	bool is_shortindex = !strcmp (index_name, "Status") || !strcmp (index_name, "Status_ex") || !strcmp (index_name, "Segment");
	bool is_dateindex = !strcmp (index_name, "Date") || !strcmp (index_name, "RDate") || !strcmp (index_name, "AnnulDate") || !strcmp (index_name, "RegDate") || !strcmp (index_name, "VAnonced") || !strcmp (index_name, "VIncluded") || !strcmp (index_name, "VChanged") || !strcmp (index_name, "VAbolished");
	if (is_hindex) {
		HIndex *hindex = (HIndex*) base->FindIndex (index_name);

		std::map<long,std::string> map_id_name;
		std::map<long,long> map_id_parentid;
		std::set<std::string> full_names;

		for (BTIterator btit (hindex); !btit.End () && req->ItemCount < (short) (keys.size () & 0xFFFF); ++btit) {
			HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
			map_id_parentid.insert (std::map<long,long>::value_type (key->id, key->parent));
			if (key->level) {
				std::string name = map_id_name.find (key->parent)->second;
				name += "\\";
				name += key->text+4;
				map_id_name.insert (std::map<long,std::string>::value_type (key->id, name));
				full_names.insert (name);
			} else {
				map_id_name.insert (std::map<long,std::string>::value_type (key->id, key->text+4));
				full_names.insert (key->text+4);
			}
		}

		long max_count = 0;
		for (std::vector<std::string>::const_iterator keys_it = keys.begin (); keys_it != keys.end (); keys_it++) {
			if (full_names.find (*keys_it) != full_names.end ())
				max_count++;
		}
		for (BTIterator btit (hindex); !btit.End () && req->ItemCount < max_count; ++btit) {
			HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
			std::string name = map_id_name.find (key->id)->second;
			for (std::vector<std::string>::const_iterator keys_it = keys.begin (); keys_it != keys.end (); keys_it++) {
				if (!strcmp (name.c_str (), keys_it->c_str ())) {
					req->ItemCount++;
					memcpy (toput, key, req->ItemSize);
					toput += req->ItemSize;
					break;
				}
			}
		}

		/*
		char full_key [2048];
		for (BTIterator btit (hindex); !btit.End () && req->ItemCount < keys.size (); ++btit) {
			HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
			hindex->FullName (key, full_key);
			for (std::vector<std::string>::const_iterator keys_it = keys.begin (); keys_it != keys.end (); keys_it++) {
				if (compare_hstr (full_key, keys_it->c_str ())) {
					req->ItemCount++;
					memcpy (toput, key, req->ItemSize);
					toput += req->ItemSize;
					break;
				}
			}
		}
		*/
		if (!strcmp (index_name, "LekForm") || !strcmp (index_name, "PhGroup") || !strcmp (index_name, "PhEffect") || !strcmp (index_name, "Mkb") || !strcmp (index_name, "Chapter") || !strcmp (index_name, "Atc") || !strcmp (index_name, "PhFirm") || !strcmp (index_name, "PhCountry"))
			b_inpharm = true;
	} else if (is_strindex) {
		for (BTIterator btit (index); !btit.End () && req->ItemCount < (short) (keys.size () & 0xFFFF); ++btit) {
			for (std::vector<std::string>::const_iterator keys_it = keys.begin (); keys_it != keys.end (); keys_it++) {
				char* key = (char*) btit.Key();
				if (!strcmp (key, keys_it->c_str ())) {
					req->ItemCount++;
					memcpy (toput, key, req->ItemSize);
					toput += req->ItemSize;
					break;
				}
			}
		}
		if (!strcmp (index_name, "TradeName") || !strcmp (index_name, "IntName"))
			b_inpharm = true;
	} else if (is_shortindex) {
		req->ItemSize = sizeof (short);
		for (BTIterator btit (index); !btit.End () && req->ItemCount < (short) (keys.size () & 0xFFFF); ++btit) {
			for (std::vector<std::string>::const_iterator keys_it = keys.begin (); keys_it != keys.end (); keys_it++) {
				short key = *(short*) btit.Key();
				if (key == atol (keys_it->c_str ())) {
					req->ItemCount++;
					memcpy (toput, &key, req->ItemSize);
					toput += req->ItemSize;

					if (!strcmp (index_name, "Status_ex") && (key == DS_MEDTOPIC || key == DS_FIRMTOPIC || key == DS_NARCOTIC || key == DS_LIFE || key == DS_UNRECIPE || key == DS_MDICTTOPIC || key == DS_ALLOWED || key == DS_RECIPE || key == DS_NOTNARCOTIC || key == DS_NOTLIFE || key == DS_NOTALLOWED))
						b_inpharm = true;
					break;
				}
			}
		}
	} else if (is_dateindex) {
		req->ItemSize = sizeof (date);
		req->SearchOp |= SV_RANGE;
		if (keys.size () == 1)
			keys.push_back (*keys.begin ());
		for (std::vector<std::string>::const_iterator keys_it = keys.begin (); keys_it != keys.end (); keys_it++) {
			long day, month, year;
			sscanf (keys_it->c_str (), "%ld/%ld/%ld", &day, &month, &year);
			date adate;
			adate.da_day = (unsigned char) (day & 0xFF);
			adate.da_mon = (unsigned char) (month & 0xFF);
			adate.da_year = (u_int16_t) year;

			memcpy (toput, &adate, req->ItemSize);
			req->ItemCount++;
			toput += req->ItemSize;
		}

		if (!strcmp (index_name, "AnnulDate") || !strcmp (index_name, "RegDate"))
			b_inpharm = true;
	}

	if (!req->ItemCount) {
		gk_free (req);
		req = 0;
	}
	return req;
}

/*
ACE_Recursive_Thread_Mutex aux_mutex;

long	aux_doco_size = -1;
char*	aux_doco_data = 0;

void	Base::LoadRunsBlocksCache ()
{
	index_aux = FindIndex ("Aux");
	RWRITE_GUARD (aux_mutex) {
		if (aux_doco_size == -1) {
			aux_doco_size = 0;
			Stream *str = index_aux->Open ("DOCO");
			if (str) {
				aux_doco_size = str->Length ();
				aux_doco_data = new char [aux_doco_size];
				str->Read (aux_doco_data, aux_doco_size);
				index_aux->Close (str);
			}
		}
	}
}

void	Base::FreeRunsBlocksCache ()
{
	RWRITE_GUARD (aux_mutex) {
		if (aux_doco_size != -1) {
			if (aux_doco_data) {
				delete []aux_doco_data;
				aux_doco_data = 0;
			}
			aux_doco_size = -1;
		}
	}
}
*/

/*
void Base::LoadRunsBlocks (long DocId, long& size_runs, long& size_blocks, std::pair <void gk_huge*, void gk_huge*> &data)
{
	if (aux_doco_size > 0 && aux_doco_data) {
		long *find = (long*) bsearch (&DocId, aux_doco_data, aux_doco_size >> 3, sizeof (u_int64_t), longcmp);
		if (find) {
			find++;
			long offset = *find;
			Stream* str = index_aux->Open ("DOCD");
			if (str) {
				str->Seek (offset);
				short count;
				str->Read (&count, sizeof (count));
				size_blocks = count * sizeof (BlockRec);
				void gk_huge* data1 = malloc (size_blocks);
				str->Read (data1, size_blocks);

				str->Read (&count, sizeof (count));
				size_runs = count * sizeof (PageRun);
				void gk_huge* data2 = malloc (size_runs);
				str->Read (data2, size_runs);

				data.first = data2;
				data.second = data1;

				index_aux->Close (str);
				return ;
			}
		}
	}
	data.first = docInd->Load (DocId, IDD_RUNS, size_runs);
	data.second = docInd->Load (DocId, IDD_BLOCKS, size_blocks);
}
*/

std::vector<std::string> get_base_files (Base *base)
{
	struct local_DataFileSelector {
		static int selector (const dirent* d) {
			std::string name (d->d_name);
			for (size_t i = 0; i < name.size (); ++i) {
				name [i] = std::tolower (name [i]);
			}
			boost::match_results<const char*> what;
			boost::match_flag_type flags = boost::match_default;
			boost::regex expression 
				("(data[.]tmp[.].{3})"
				, boost::regex::normal | boost::regex::icase
				);	
			return boost::regex_search (name.c_str (), what, expression, flags);
		}
	};

	std::vector<std::string> names;
	StrList *base_files = base->GetFileList ();
	if (base_files) {
		names.insert (names.begin (), base_files->begin (), base_files->end ());
		delete base_files;
	}

	char path [MPCXC_MAX_PATH];
	strcpy (path, base->textFile->FileName);
	if (strrchr (path, '\\')) {
		*strrchr (path, '\\') = 0;
		std::string scan_directory (path);
		ACE_Dirent_Selector selector;
		std::string pip_scan_directory = platform_independent_path (scan_directory);
		selector.open (pip_scan_directory.c_str(), local_DataFileSelector::selector);
		for (int i = 0; i < selector.length (); ++i) {
			std::string name (path);
			name += "\\";
			name += selector[i]->d_name;
			names.push_back (name);
		}
		selector.close ();
	}

	return names;
}
