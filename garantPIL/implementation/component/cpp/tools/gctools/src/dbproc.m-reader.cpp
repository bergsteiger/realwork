#include <cctype>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <cerrno>
#include <cstdlib>
#include <cstring>

#include "dbproc.m-reader.h"
#include "../../../libs/gc/src/dbproc.mh.h"

#undef MAKEDATAPTR
#define MAKEDATAPTR(t,p,o) DbProcMetaFile::t *p=(DbProcMetaFile::t*)((o)+1)

#undef MAKEDATAPTR2
#define MAKEDATAPTR2(t,p,o) t *p=(t*)((o)+1)

#undef MAKECHARDATAPTR
#define MAKECHARDATAPTR(po) ((char*)((po)+1))

#ifdef WITH_DBL_THREAD
	#include "../../../libs/gc/src/gclog.h"
	extern AdvLogger gclog;
#endif
extern	std::deque<std::string> errors;

DbProcessorMReader :: ~DbProcessorMReader () 
{
}
DbProcessorMReader :: DbProcessorMReader (DbProcMetaHolder *m):
  mh(m),
  status(0)
{
}
void DbProcessorMReader :: run()
{
	if( !mh->OK() ){
		status = 1;
		return;
	}
	const DbProcMetaFile::DbProcMRecord*r = 0;
	//DbProcMetaFile::DbProcMRecord actionttt;

	for( mh->next(r);r;mh->next(r)){
		switch( r->action ){
			case DbProcMetaFile::createTopic: {
					MAKEDATAPTR( CreateTopicData, dptr, r );
					createTopic( dptr->docid, 
								MAKECHARDATAPTR(dptr), 
								dptr->title_len,
								&(dptr->rv), dptr->pk );
#ifdef _MSC_VC
					dptr->rv= today_rev;
#endif
				}
				break;
			case DbProcMetaFile::setTopicName: {
					MAKEDATAPTR( SetTopicData, dptr, r );
						setTopicName(dptr->docid, 
								MAKECHARDATAPTR(dptr), dptr->datalen);
				}
				break;
			case DbProcMetaFile::writeAuxAppend: {
					MAKEDATAPTR( WriteAux, dptr, r );
					writeAuxAppend(dptr->key, MAKECHARDATAPTR(dptr), 
							dptr->dataLength);
				}
				break;
			case DbProcMetaFile::writeAux: {
					MAKEDATAPTR( WriteAux, dptr, r );
					writeAux(dptr->key, MAKECHARDATAPTR(dptr), 
						dptr->dataLength);
				}
				break;
			case DbProcMetaFile::setTopicSubDesc: {
				MAKEDATAPTR( SetTopicData, dptr, r );
				try {
					setTopicSubDesc(dptr->docid, (SubDesc*)MAKECHARDATAPTR(dptr), dptr->datalen/sizeof(SubDesc) );
				} catch (...) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "setTopicSubDesc for %ld is not OK.\n", dptr->docid);
					printf("setTopicSubDesc for %ld is not OK.\n", dptr->docid);
				}
				}								  
				break;
			case DbProcMetaFile::addTopicEvd: {
					MAKEDATAPTR (SetTopicData, dptr, r);
					addTopicEvd(dptr->docid, MAKECHARDATAPTR(dptr), dptr->datalen);
				}
				break;

			case DbProcMetaFile::addTopicParaHeights: {
					MAKEDATAPTR (SetTopicData, dptr, r);
					addTopicParaHeights(dptr->docid, MAKECHARDATAPTR(dptr), dptr->datalen);
				}
				break;

			case DbProcMetaFile::addTopicChange: {
					MAKEDATAPTR (SetTopicData, dptr, r);
					addTopicChange (dptr->docid, (IddChangeStruct*)MAKECHARDATAPTR(dptr));
				}
				break;

			case DbProcMetaFile::setTopicSubDescEx: {
				MAKEDATAPTR( SetTopicData, dptr, r );
				try {
					setTopicSubDescEx(dptr->docid, (SubDescEx*)MAKECHARDATAPTR(dptr), dptr->datalen/sizeof(SubDescEx) );
				} catch (...) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "setTopicSubDescEx for %ld is not OK.\n", dptr->docid);
					printf("setTopicSubDescEx for %ld is not OK.\n", dptr->docid);
				}
				}
				break;
			case DbProcMetaFile::setTopicDocStruct:
				{
					MAKEDATAPTR( SetTopicData, dptr, r );
					try {
						setTopicDocStruct (dptr->docid, (DocStruct*)MAKECHARDATAPTR(dptr), dptr->datalen );
					} catch (...) {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "setTopicDocStruct for %ld is not OK.\n", dptr->docid);
						printf("setTopicDocStruct for %ld is not OK.\n", dptr->docid);
					}
				}
				break;
			case DbProcMetaFile::setTopicInfo: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					setTopicInfo(dptr->docid, 
					(DocInfo *)MAKECHARDATAPTR(dptr));
				}
				break;
			case DbProcMetaFile::setTopicStatus: {
					MAKEDATAPTR( SetTopicStatus, dptr, r );
					setTopicStatus(dptr->docid, dptr->status);
				}
				break;
			case DbProcMetaFile::setTopicStatus_ex: {
					MAKEDATAPTR( SetTopicStatus_ex, dptr, r );
					setTopicStatus_ex(dptr->docid, dptr->status, dptr->sub);
				}
				break;
			case DbProcMetaFile::setTopicStatus_exex: {
					MAKEDATAPTR( SetTopicStatus_exex, dptr, r );
					setTopicStatus_exex(dptr->docid, dptr->status);
				}
				break;
			case DbProcMetaFile::setTopicResps: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					setTopicResps(dptr->docid,
						(u_int64_t*)MAKECHARDATAPTR(dptr), 
						dptr->datalen/sizeof(u_int64_t) );
				}
				break;
			case DbProcMetaFile::setCorrs: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					setCorrs(dptr->docid,(u_int64_t*)MAKECHARDATAPTR(dptr), 
						dptr->datalen/sizeof(u_int64_t) );
				}
				break;
			case DbProcMetaFile::setTopicBelongs: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					setTopicBelongs(dptr->docid,
					(int16_t*)MAKECHARDATAPTR(dptr), 
						dptr->datalen/sizeof(int16_t) );
				}
				break;
			case DbProcMetaFile::add2PrefixIndex: {
					MAKEDATAPTR( SetRefData, dptr, r );
					add2PrefixIndex(MAKECHARDATAPTR(dptr), 
							dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::setClassAndPrefix:
				try {
					MAKEDATAPTR( Set2StringsData, dptr, r );
					setClassAndPrefix(MAKECHARDATAPTR(dptr), dptr->len1, 
									  MAKECHARDATAPTR(dptr)+dptr->len1,
									  dptr->len2);
				} catch (...) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "setClassAndPrefix is not OK.\n");
					printf("setClassAndPrefix is not OK.\n");
				}
				break;
			case DbProcMetaFile::add2ClassIndex: {
					MAKEDATAPTR( SetRefData, dptr, r );
					add2ClassIndex(	MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicDate: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicDate(dptr->docid, (*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicRegDate: {
					MAKEDATAPTR (SetRefData, dptr, r);
					addTopicRegDate(dptr->docid, (*(date*)MAKECHARDATAPTR(dptr)), dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicAnnulDate: {
					MAKEDATAPTR (SetRefData, dptr, r);
					addTopicAnnulDate(dptr->docid, (*(date*)MAKECHARDATAPTR(dptr)), dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicRDate: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicRDate(dptr->docid,
							(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicSortDate: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicSortDate(dptr->docid,
									(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicVAbolished: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicVAbolished(dptr->docid, 
						(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicVIncluded: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicVIncluded(dptr->docid, 
						(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicCalIn: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicCalIn(dptr->docid, 
						(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicCalAb: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicCalAb(dptr->docid, 
						(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicCalCh: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicCalCh(dptr->docid, 
						(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicVChanged: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicVChanged(dptr->docid, 
						(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
#ifdef VERSION56
			case DbProcMetaFile::addTopicActivity: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					DocActivityEx docActivity={0};
					DocActivityEx* pDocActivity=(DocActivityEx*)MAKECHARDATAPTR(dptr);
					docActivity.from=pDocActivity->from;
					docActivity.to=pDocActivity->to;
					docActivity.b_add_iddactive = pDocActivity->b_add_iddactive;
					docActivity.block = pDocActivity->block;
					char* text=(char*)&(pDocActivity->text);
					if (text) {
						docActivity.text=new char[strlen(text)+1];
						strcpy(docActivity.text, text);
					}
					addTopicActivity(dptr->docid, docActivity);
				}
				break;
			case DbProcMetaFile::addTopicNotSure: {
#ifdef	VERSION61
					MAKEDATAPTR( SetTopicData, dptr, r );
					DocNotSure docNotSure={0};
					DocNotSure* pDocNotSure=(DocNotSure*)MAKECHARDATAPTR(dptr);
					docNotSure.from=pDocNotSure->from;
					docNotSure.to=pDocNotSure->to;
					char* text=(char*)&(pDocNotSure->text);
					if (text) {
						docNotSure.text=new char[strlen(text)+1];
						strcpy(docNotSure.text, text);
					}
					addTopicNotSure(dptr->docid, docNotSure);
#else
					MAKEDATAPTR( SetTopicData, dptr, r );
					DocNotSure docNotSure={0};
					DocNotSure* pDocNotSure=(DocNotSure*)MAKECHARDATAPTR(dptr);
					docNotSure.from=pDocNotSure->from;
					docNotSure.to=pDocNotSure->to;
					addTopicNotSure(dptr->docid, docNotSure);
#endif
				}
				break;
			case DbProcMetaFile::addTopicChDate: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					DocChDate docChDate={0};
					DocChDate* pDocChDate=(DocChDate*)MAKECHARDATAPTR(dptr);
					docChDate.anonce=pDocChDate->anonce;
					docChDate.active=pDocChDate->active;
					addTopicChDate(dptr->docid, docChDate);
				}
				break;
			case DbProcMetaFile::addTopicChDateEx: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					ChDateEx docChDateEx={0};
					ChDateEx* pDocChDateEx = (ChDateEx*)MAKECHARDATAPTR(dptr);
					docChDateEx.anonce = pDocChDateEx->anonce;
					docChDateEx.ref = pDocChDateEx->ref;
					addTopicChDateEx(dptr->docid, docChDateEx);
				}
				break;
			case DbProcMetaFile::addTopicDivision: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					DivisionInfo divisionInfo={0};
					DivisionInfo* pDivisionInfo=(DivisionInfo*)MAKECHARDATAPTR(dptr);
					divisionInfo.Para=pDivisionInfo->Para;
					divisionInfo.Symbol=pDivisionInfo->Symbol;
					char* params=(char*)&(pDivisionInfo->Params);
					if (params) {
						divisionInfo.Params=new char[strlen(params)+1];
						strcpy(divisionInfo.Params, params);
					}
					addTopicDivision(dptr->docid, divisionInfo);
				}
				break;
			case DbProcMetaFile::addTopicPages: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicPages(dptr->docid, (*(PageBreak*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicContents: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicContents(dptr->docid, (*(ContentsStruct*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicCompareContents: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicCompareContents(dptr->docid, (*(CompareContentsStruct*)MAKECHARDATAPTR(dptr)));
				}
				break;
#endif
			case DbProcMetaFile::addTopicVAnonced: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicVAnonced(dptr->docid, 
						(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicAnnoDate: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicAnnoDate(dptr->docid, 
						(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicVLControl: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicVLControl(dptr->docid, 
						(*(date*)MAKECHARDATAPTR(dptr)));
				}
				break;
			case DbProcMetaFile::addTopicRcode: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicRcode(dptr->docid, 
								MAKECHARDATAPTR(dptr),
								dptr->datalen);
				}
				break;
			case DbProcMetaFile::addTopicCode: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicCode(dptr->docid, 
						MAKECHARDATAPTR(dptr),
						dptr->datalen);
				}
				break;
			case DbProcMetaFile::addTopicAddCode: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicAddCode(dptr->docid,  MAKECHARDATAPTR(dptr),
						dptr->datalen);
				}
				break;
			case DbProcMetaFile::setTopicCategory: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					setTopicCategory(dptr->docid, MAKECHARDATAPTR(dptr),
								dptr->datalen);
				}
				break;
			case DbProcMetaFile::setTopicTradeName: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					setTopicTradeName (dptr->docid, MAKECHARDATAPTR(dptr), dptr->datalen);
				}
				break;
			case DbProcMetaFile::setTopicIntName: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					setTopicIntName (dptr->docid, MAKECHARDATAPTR(dptr), dptr->datalen);
				}
				break;
			case DbProcMetaFile::addTopicServiceInfo: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicServiceInfo(MAKECHARDATAPTR(dptr),	dptr->datalen,
								 dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicInpharmFirm: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicInpharmFirm (MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicAtc: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicAtc (MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicRegStatus: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicRegStatus (MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicLekForm: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicLekForm (MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicInpharmCountry: {
					MAKEDATAPTR (SetRefData, dptr, r);
					addTopicInpharmCountry (MAKECHARDATAPTR (dptr), dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicAdword: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicAdword(MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicCasecode: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicCasecode(MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicType: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicType(MAKECHARDATAPTR(dptr),	dptr->datalen,
								 dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicKind: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicKind(MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicAnnoUser: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicAnnoUser(MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicPharmGroup: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicPharmGroup (MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicPharmEffect: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicPharmEffect (MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicMkb: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicMkb (MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicChapter: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicChapter (MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicAnnoOrganization: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicAnnoOrganization(MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicAnnoTax: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicAnnoTax(MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicAnnoInterest: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicAnnoInterest(MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicAnnoKind: {
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicAnnoKind(MAKECHARDATAPTR(dptr), dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicSource: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicSource(MAKECHARDATAPTR(dptr), 
										dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::addTopicTerritory: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicTerritory(MAKECHARDATAPTR(dptr), 
										dptr->datalen, dptr->docid);
				}
				break;
			case DbProcMetaFile::setSourceAndTerritory: {
					MAKEDATAPTR( Set2StringsData, dptr, r );
					setSourceAndTerritory(MAKECHARDATAPTR(dptr),dptr->len1, 
									  MAKECHARDATAPTR(dptr)+dptr->len1,
									  dptr->len2);
				}
				break;
			case DbProcMetaFile::addTopicPublishedIn: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					addTopicPublishedIn(dptr->docid, MAKECHARDATAPTR(dptr), 
										dptr->datalen);
				}
				break;
			case DbProcMetaFile::setRefName: {
					MAKEDATAPTR( SetRefData, dptr, r );
					setRefName(dptr->docid, MAKECHARDATAPTR(dptr), 
						dptr->datalen, dptr->sub);
				}
				break;
			case DbProcMetaFile::addTopicPara: {
  #ifdef PTRS_ONLY
					MAKEDATAPTR( AddTopicPara, dptr, r );
					addTopicPara(dptr->docid, dptr->style, 
  #else
					MAKEDATAPTR( SetRefData, dptr, r );
					addTopicPara(dptr->docid,dptr->sub,
  #endif
						MAKECHARDATAPTR(dptr), dptr->datalen);
				}
				break;
			case DbProcMetaFile::addTopicEmptyPara: {
					MAKEDATAPTR2( topic_t, dptr, r );
					addTopicEmptyPara(*dptr);
				}
				break;
			case DbProcMetaFile::addKeyWord:
				{
					MAKEDATAPTR( Set2StringsData, dptr, r );
					addKeyWord(MAKECHARDATAPTR(dptr), dptr->len1, 
									  MAKECHARDATAPTR(dptr)+dptr->len1,
									  dptr->len2);
				}
				break;
			case DbProcMetaFile::endTopic: {
#ifdef PTRS_IN_META
	MAKEDATAPTR( SetRefData, dptr, r );
  #ifdef PTRS_ONLY
	endTopic(dptr->docid,dptr->sub,(size_t)dptr->datalen);
  #else
	endTopic(dptr->docid,dptr->sub,(size_t)dptr);
  #endif
#else
	MAKEDATAPTR2( topic_t, dptr, r );
	topic_t t = *dptr;
	endTopic(t);
#endif
				}
				break;
			case DbProcMetaFile::addAttribute:
				{
				MAKEDATAPTR( SetTopicAttribute, dptr, r );
				try {
					addAttribute(dptr->docid, dptr->tag, MAKECHARDATAPTR(dptr),dptr->datalen);
				} catch (...) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "addAttribute %ld.%ld is not OK.\n", dptr->docid, dptr->tag);
					printf("addAttribute %ld.%ld is not OK.\n", dptr->docid, dptr->tag);
				}
				}
				break;
			case DbProcMetaFile::setBaseCore: {
					MAKEDATAPTR( SetBaseData, dptr, r );
					setBaseCore(dptr->bid,
									(BaseCore*)MAKECHARDATAPTR(dptr));

				}
				break;
			case DbProcMetaFile::setBlobData:
				{
   				MAKEDATAPTR( SetTopicData, dptr, r );
				try {
                    if (dptr) {
		    			setBlobData(dptr->docid,MAKECHARDATAPTR(dptr),dptr->datalen);
                    }
				} catch (...) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "setBlobData for %ld is not OK.\n", dptr->docid);
					printf("setBlobData for %ld is not OK.\n", dptr ? dptr->docid : 0);
				}
				}
			    break;
			case DbProcMetaFile::setBlobBelongs: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					setBlobBelongs(dptr->docid,
					(int16_t*)MAKECHARDATAPTR(dptr), 
						dptr->datalen/sizeof(int16_t) );
				}
				break;
			case DbProcMetaFile::setBlobFormsBelongs: {
					MAKEDATAPTR( SetTopicData, dptr, r );
					setBlobFormsBelongs(dptr->docid,
					(int16_t*)MAKECHARDATAPTR(dptr), 
						dptr->datalen/sizeof(int16_t) );
				}
				break;
			case DbProcMetaFile::setUNode: {
					MAKEDATAPTR( SetUNodeData, dptr, r );
					setUNode(MAKECHARDATAPTR(dptr),dptr->pfx_l,
										  dptr->jtype,
									  MAKECHARDATAPTR(dptr)+dptr->pfx_l,
									  dptr->uname_l,
									  MAKECHARDATAPTR(dptr)
										  +dptr->pfx_l + dptr->uname_l,
									  dptr->cls_l);
				}
				break;

			default:
				printf("Don't know how to handle request!.\n");
		}
		//actionttt= *r;
	}
}

int DbProcessorMReader :: OK()
{
	if( mh ) return mh->OK();
	return 0;
}
