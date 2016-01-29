#include "shared/Core/fix/mpcxc.h"
#ifndef dbproc_mh_h
#define dbproc_mh_h
#include <ctype.h>

#include "gardefs.h"
#include "topic_t.h"

class DbProcMetaHolder
{
  public:
#pragma pack(1)
	struct DbProcMRecord {
		u_int32_t action;
		u_int32_t recSize;
	};
	struct CreateTopicData {
		u_int32_t docid;
		u_int32_t pk;
		u_int32_t title_len;	
		revision  rv;
	};
	struct SetTopicStatus {
		topic_t docid;
		u_int32_t status;
	};
	struct SetTopicStatus_ex {
		topic_t docid;
		u_int32_t sub;
		u_int32_t status;
	};
	struct SetTopicStatus_exex {
		topic_t docid;
		u_int32_t status;
	};
	struct SetTopicData {
		topic_t docid;
		u_int32_t datalen;
	};
	struct SetTopicAttribute {
		topic_t docid;
		u_int32_t tag;
		u_int32_t datalen;
	};
	struct SetRefData {
		topic_t docid;
		u_int32_t sub;
		u_int32_t datalen;
	};
	struct Set2StringsData {
		u_int32_t len1;
		u_int32_t len2;
	};
	struct SetUNodeData {
		u_int32_t pfx_l;
		u_int32_t uname_l;
		u_int32_t cls_l;
		char jtype;
	};
	struct WriteAux {
		u_int32_t dataLength;
		char key[5];
	};
	struct AddTopicPara {
		topic_t docid;
		u_int32_t style;
		u_int32_t datalen;
	};
	struct SetBaseData {
		u_int32_t bid;
		u_int32_t datalen;
	};

#pragma pack()

	enum DbProcAction {
		createTopic,
		setTopicName,
		setTopicCategory,
		setTopicTradeName,
		setTopicIntName,
		writeAuxAppend,
		writeAux,
		setBaseCore,
		setTopicSubDesc,
		setTopicSubDescEx,
		setTopicDocStruct,
		setTopicInfo,
		setTopicStatus,
		setTopicStatus_ex,
		setTopicStatus_exex,
		setTopicResps,
		setCorrs,
#ifdef	VERSION56
		setNewCorrs,
#endif
		setTopicBelongs,
		addTopicCalIn,
		addTopicCalAb,
		addTopicCalCh,
		addTopicVChanged,
		addTopicRcode,
		addTopicCode,
		addTopicAddCode,
		addTopicServiceInfo,
		addTopicInpharmFirm,
		addTopicInpharmCountry,
		addTopicAdword,
		addTopicType,
		addTopicKind,
		addTopicCasecode,
		addTopicAnnoUser,
		addTopicAnnoOrganization,
		addTopicAnnoTax,
		addTopicAnnoInterest,
		addTopicAnnoKind,
		addTopicSource,
		addTopicChange,
		addTopicPharmGroup,
		addTopicPharmEffect,
		addTopicMkb,
		addTopicChapter,
		addTopicAtc,
		addTopicRegStatus,
		addTopicLekForm,
		addTopicTerritory,
		addTopicPublishedIn,
		addTopicVIncluded,
		addTopicVAbolished,
		addTopicVAnonced,
		addTopicAnnoDate,
		addTopicVLControl,
		addTopicSortDate,
		addTopicRDate,
		addTopicDate,
		addTopicEvd,
		addTopicRegDate,
		addTopicAnnulDate,
		setRefName,
		addTopicPara,
		addTopicEmptyPara,
		endTopic,
		addKeyWord,
		add2ClassIndex,
		add2PrefixIndex,
		setClassAndPrefix,
		setSourceAndTerritory,
		addAttribute,
		setBlobData,
		setBlobBelongs,
		setBlobFormsBelongs,
		setUNode,
		addTopicParaHeights,
		addTopicActivity,
		addTopicPages,
		addTopicChDate,
		addTopicContents,
		addTopicCompareContents,
		addTopicNotSure,
		addTopicDivision,
		addTopicChDateEx		
	};
	virtual ~DbProcMetaHolder() { }
	virtual int write( const DbProcMRecord *) =0;
	virtual const DbProcMRecord *next(const DbProcMRecord *&) =0;
	virtual void  noteEOM() = 0;
	virtual int OK() =0;
};

#endif
