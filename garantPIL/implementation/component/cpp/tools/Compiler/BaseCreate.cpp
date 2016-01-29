//
// BaseCreate.cpp : implementation file
//

#include "ace/ACE.h"

#include "../../GPersn/src/PL_Proto.h"
#include "BaseCreate.h"

namespace Compiler {

extern "C" long lDefNdtCryptoTag;

BaseCreate::BaseCreate (
	const char* name
	, int mode
	, int key_cpages
	, int str_cpages
	, int ndt_cache
	, FILE* stat_file
)
	: YBase (name, mode, key_cpages, str_cpages, ndt_cache, stat_file)
{
	curr_mode = mode;
	max_runs = MAX_RUNS;
	max_blocks = MAX_BLOCKS;
	countDocsBlockBuffer = 0;
	currentBlockSize = ADD_BLOCK_SIZE;
	CreatedBigStream = 1;

	keyFile->m_pCryptoTag  = (char*) calloc (1, MAX_CRYPTED_BLOCK + SIZE_CRYPTO_HEADER + sizeof (long));
	strFile->m_pCryptoTag  = (char*) calloc (1, MAX_CRYPTED_BLOCK + SIZE_CRYPTO_HEADER + sizeof (long));
	textFile->m_pCryptoTag = (char*) &lDefNdtCryptoTag;

	*(long*) keyFile->m_pCryptoTag = dfKeyFileSize;
	*(long*) strFile->m_pCryptoTag = dfStrFileSize;

	if (!keyFile->Exist ()) {
		keyFile->Create (dfKeyFileSize);
	}

	if (!strFile->Exist ()) {
		strFile->Create (dfStrFileSize);
	}

	if (!textFile->Exist ()) {
		textFile->Create (dfNdtFileSize);
	}

	if (!keyFile->Exist () || !strFile->Exist () || !textFile->Exist ()) {
		return;
	}

	streamFile = new StreamFile  (strFile);
	streamFile->Create ();

	*(long*) keyFile->m_pCryptoTag = MAX_CRYPTED_BLOCK + Base::dfKeyFileSize;
	*(long*) strFile->m_pCryptoTag = MAX_CRYPTED_BLOCK + Base::dfStrFileSize;

	pDocsBlockBufferOut = pDocsBlockBuffer = new_docBuf + 2 * ADD_BLOCK_SIZE + 1024;

	new_docBuf = (char*) calloc (1, 2 * ADD_BLOCK_SIZE + 1024 + ADD_BLOCK_SIZE);
	new_runs = (PageRun*) calloc (sizeof (PageRun), MAX_RUNS);
	new_blocks = (BlockRec*) calloc (sizeof (BlockRec), MAX_BLOCKS);

	if (strrchr (keyFile->FileName, '(')) {
		FindIndex ("Attrs.str");
		FindIndex ("Aux.str");
	} 

	size_t long_size = sizeof (long), ref_size = sizeof (Ref);
	{
		FindIndex ("Context.str");
		(docInd = (AttrIndex*) FindIndex ("Attrs.str"))->Create (sizeof (AttrKey), 1, 1);
		FindIndex ("Aux.str")->Create (5, 1, 1);
		(subNames = FindIndex ("SubName"))->Create (ref_size, 1, 1);
		FindIndex ("Adopted")->Create (ADOPTED_KEY_SIZE, long_size * 3, 2);
		FindIndex ("PhGroup")->Create (INPHARM_PHARMGROUP_SIZE, long_size * 3, 1);
		FindIndex ("PhEffect")->Create (INPHARM_PHARMEFFECT_SIZE, long_size * 3, 1);
		FindIndex ("Mkb")->Create (INPHARM_MKB_SIZE, ref_size * 3, 1, ref_size);
		FindIndex ("Chapter")->Create (INPHARM_CHAPTER_SIZE, ref_size * 3, 1, ref_size);
		FindIndex ("Territory")->Create (ADOPTED_KEY_SIZE, long_size * 3, 2);
		FindIndex ("ServiceInfo")->Create (CLASS_KEY_SIZE, ref_size * 3, 1, ref_size);
		FindIndex ("Atc")->Create (INPHARM_ATC_SIZE, long_size * 3, 1, long_size);
		FindIndex ("RegStatus")->Create (INPHARM_REGSTATUS_SIZE, ref_size * 3, 1, ref_size);
		FindIndex ("LekForm")->Create (INPHARM_REGSTATUS_SIZE, ref_size * 3, 1, ref_size);
		FindIndex ("PhFirm")->Create (INPHARM_FIRM_SIZE, ref_size * 3, 1, ref_size);
		FindIndex ("PhCountry")->Create (INPHARM_COUNTRY_SIZE, ref_size * 3, 1, ref_size);
		FindIndex ("Type")->Create (TYPE_KEY_SIZE, ref_size * 3, 1, ref_size);
		FindIndex ("RegDate")->Create (sizeof (date), ref_size * 3, 1, ref_size);
		FindIndex ("AnnulDate")->Create (sizeof (date), ref_size * 3, 1, ref_size);
		FindIndex ("Date")->Create (sizeof (date), long_size * 3, 1);
		FindIndex ("Number")->Create (CODE_KEY_SIZE, long_size * 3, 1);
		FindIndex ("Status")->Create (2, long_size * 3, 1);
		FindIndex ("Status_ex")->Create (2, ref_size * 3, 1, ref_size);
		FindIndex ("KeyWord")->Create (SEC_KW_SIZE, ref_size * 3, 1, ref_size);
		FindIndex ("RCode")->Create (CODE_KEY_SIZE, long_size * 3, 1);
		FindIndex ("Respondent")->Create (4, long_size * 3, 1, ref_size);
		FindIndex ("Correspondent")->Create (4, long_size * 3, 1, ref_size);
		FindIndex ("RDate")->Create ( sizeof (date), long_size * 3, 1);
		FindIndex ("Context")->Create (CTX_WORD_SIZE, long_size * 3, 1);
		FindIndex ("VIncluded")->Create ( sizeof (date), long_size * 3, 1);
		FindIndex ("VChanged")->Create ( sizeof (date), long_size * 3, 1);
		FindIndex ("VAbolished")->Create ( sizeof (date), long_size * 3, 1);
		FindIndex ("Class")->Create (CLASS_KEY_SIZE, ref_size * 3, 2, ref_size);
		FindIndex ("DocKind")->Create (CLASS_KEY_SIZE, ref_size * 3, 2, ref_size);
		FindIndex ("SortDate")->Create (sizeof (date), long_size * 3, 1);
		FindIndex ("VAnonced")->Create ( sizeof (date), long_size * 3, 1);
		FindIndex ("VLControl")->Create ( sizeof (date), long_size * 3, 1);
		FindIndex ("Category")->Create (CATEGORY_KEY_SIZE, long_size * 3, 1);
		FindIndex ("TradeName")->Create (INPHARM_TRADENAME_SIZE, long_size * 3, 1);
		FindIndex ("IntName")->Create (INPHARM_INTNAME_SIZE, long_size * 3, 1);
		FindIndex ("PublishedIn")->Create (PUBLISHEDIN_KEY_SIZE, long_size * 3, 1);
		FindIndex ("Segment")->Create (2, long_size * 3, 1);
		FindIndex ("Blob")->Create ( sizeof (ObjKey), long_size * 3, 2);
		FindIndex ("Control")->Create ( sizeof (date), long_size * 3, 1, 2 * long_size);
		FindIndex ("Class6")->Create (CLASS_KEY_SIZE, ref_size * 3, 2, ref_size);
		FindIndex ("NewCorr")->Create (4, long_size * 3, 1, sizeof (CorrRef));
		FindIndex ("Attribs")->Create (sizeof (AttrKey), 1, 1);
		FindIndex ("AnnoUser")->Create (CLASS_KEY_SIZE, long_size * 3, 1);
		FindIndex ("AnnoOrganization")->Create (CLASS_KEY_SIZE, long_size * 3, 1);
		FindIndex ("AnnoTax")->Create (CLASS_KEY_SIZE, long_size * 3, 1);
		FindIndex ("AnnoInterest")->Create (CLASS_KEY_SIZE, long_size * 3, 1);
		FindIndex ("AnnoKind")->Create (CLASS_KEY_SIZE, long_size * 3, 1);
		FindIndex ("AnnoDate")->Create (sizeof (date), long_size * 3, 1);
		FindIndex ("KindCorr")->Create (ref_size, long_size * 3, 1);
	} 

	this->begin_transaction ();
}

BaseCreate::~BaseCreate () {
	if (new_docBuf) {
		free (new_docBuf);
	}

	if (new_runs) {
		free (new_runs);
	}

	if (new_blocks) {
		free (new_blocks);
	}
	this->end_transaction ();

	FreeIndices ();

	if (streamFile) {
		int handle = streamFile->file->GetFileHandle ();
		delete streamFile;
		ace_os_close (handle); 
	}

	if (textFile) {
		int handle = textFile->GetFileHandle ();
		delete textFile;
		ace_os_close (handle); 
	}

	if (keyFile) {
		int handle = keyFile->GetFileHandle ();
		delete keyFile;
		keyFile = 0;
		ace_os_close (handle); 
	}
}

void BaseCreate::begin_transaction () {
	streamFile->StartTransaction ();
	pOtherIndex [0].pStreamFile->StartTransaction ();
	pOtherIndex [1].pStreamFile->StartTransaction ();
}

void BaseCreate::end_transaction () {
	subNames->streams->EndTransaction ();
	pOtherIndex [0].pStreamFile->EndTransaction ();
	pOtherIndex [1].pStreamFile->EndTransaction ();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

Base* BaseFactory::make (const char* name) {
	try {
		Core::Aptr <Base> ret = new BaseCreate (
			name
			, ACE_OS_O_RDWR | ACE_OS_O_CREAT | ACE_OS_O_TRUNC
			, -1
			, -1
			, -1
			,  0
		);

		return ret._retn ();

	} catch (...) {
		throw BaseCreateError ();
	}

	return 0;
}

}

