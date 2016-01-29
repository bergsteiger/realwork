#include "shared/Core/fix/mpcxc.h"
#include "zlib.h"
/*
 * $Id: dbproc.m-to-gkdb.cpp,v 2.321 2015/07/15 11:48:23 young Exp $
 */
#include <ctime>
#include <cstdlib>
#include <fcntl.h>
#include <cstdio>
#include <cerrno>
#include <cstring>
#include <deque>
#include <getopt.h>

#include "gar_defs.hpp"
#include "../../../libs/gchange/include/context.h"
#include "garver.h"
#include "basemask.h"

#include "garcomp.h"
#include "gcini.h"
#include "dbproc.m-to-gkdb.h"
#include "stdbase.h"
#include "newdoc.h"
#include "doccol.h"
#include "refcol.h"
#include "cacheIndex.h"
#include "basemask.h"
#include "zlib.h"
#include "pack.h"
#include "recode.h"

extern bool b_fastfakeattrs;

enum SetLicenceCode { 
	gc_PL_OK = 0, gc_PL_INVARG = -1, gc_PL_INVDB = -2, gc_PL_PUTATTR = -3, gc_PL_EXCPT = -4 
};

const unsigned long gc_SI_LEGACY_STORAGE = 1;
const unsigned long gc_SI_PROFILE_STORAGE = 2;

const unsigned long gc_CI_TOPIC = (gc_SI_LEGACY_STORAGE << 16) | 1;
const unsigned long gc_CI_BLOB = (gc_SI_LEGACY_STORAGE << 16) | 2;
const unsigned long gc_CI_GROUP = (gc_SI_PROFILE_STORAGE << 16) | 0;
const unsigned long gc_CI_USER = (gc_SI_PROFILE_STORAGE << 16) | 1;

const unsigned long gc_AI_GET_FULL_ATTRIBUTES = 102;
const unsigned long gc_AI_GET_PARAGRAPH_TEXT = 101;
const unsigned long gc_AI_GET_OBJECT_STREAM = 201;
const unsigned long gc_AI_ADMINISTRATOR = 500;
const unsigned long gc_AI_CHANGE_IDLE_TIMEOUT = 302;

const char* gc_ATTR_NAME_MAX_USERS			= "MU"; //"MaxUsers";
const char* gc_ATTR_NAME_PERM_USERS		= "PU"; //"PermUsers";
const char* gc_ATTR_NAME_MAX_PROFILES		= "MP"; //"MaxProfiles";
const char* gc_ATTR_NAME_BASE_ACL_COUNT	= "BRC";//"BaseRightsCount";
const char* gc_ATTR_NAME_BASE_ACL_ARRAY	= "BRA";//"BaseRightsArray";
const char* gc_ATTR_NAME_TOPIC_ACL_COUNT	= "TC";//"TopicCount";
const char* gc_ATTR_NAME_TOPIC_ACL_ARRAY	= "TA";//"TopicArray";
const char* gc_ATTR_NAME_BLOB_ACL_COUNT	= "OC";//"ObjectCount";
const char* gc_ATTR_NAME_BLOB_ACL_ARRAY	= "OA";//"ObjectArray";
const char* gc_ATTR_NAME_GROUP_ACL_COUNT	= "GC";//"GroupCount";
const char* gc_ATTR_NAME_GROUP_ACL_ARRAY	= "GA";//"GroupArray";
const char* gc_ATTR_NAME_USER_ACL_COUNT	= "UC";//"UserCount";
const char* gc_ATTR_NAME_USER_ACL_ARRAY	= "UA";//"UserArray";
const char* gc_ATTR_NAME_CRC				= "CIV"; //"CRC MU+PU+MP";
const char* gc_ATTR_NAME_GUEST_ENABLED		= "GE"; //"Guest Enabled";
const char* gc_ATTR_NAME_VERSION			= "VER"; //"Version";
const unsigned gc_SEED_FOR_ADLER32			= 0x31304947;//(unsigned)"GI01";

unsigned long gc_VERSION = 1;

typedef struct _acl_t {
	unsigned short m_aid;
	unsigned char m_right;
} acl_t;

int gc_PutAttributeArray(PagedFile* pNDT, const char* pCountName, const char* pArrayName, unsigned char nCount, acl_t* pAcl)
{
	if(!pNDT->PutAttr(pCountName, &nCount, sizeof(unsigned char)))
		return gc_PL_PUTATTR;

	if(nCount > 0)
		if(!pNDT->PutAttr(pArrayName, pAcl, sizeof(acl_t)*nCount))
			return gc_PL_PUTATTR;

	return 0;
}

void	gc_SetLicence( PagedFile* pNDT, int max_profiles, int max_num, int max_perm)
{
	int guest_enabled = 1;

	pNDT->PutAttr(gc_ATTR_NAME_VERSION, &gc_VERSION, sizeof(gc_VERSION));
	pNDT->PutAttr(gc_ATTR_NAME_MAX_USERS, &max_num, sizeof(int));
	pNDT->PutAttr(gc_ATTR_NAME_PERM_USERS, &max_perm, sizeof(int));
	pNDT->PutAttr(gc_ATTR_NAME_MAX_PROFILES, &max_profiles, sizeof(int));
	pNDT->PutAttr(gc_ATTR_NAME_GUEST_ENABLED, &guest_enabled, sizeof(int));

	int buf[4];
	buf[0] = max_num; buf[1] = max_perm; buf[2] = max_profiles; buf[3]=guest_enabled;
	unsigned crc = adler32 ( gc_SEED_FOR_ADLER32, (unsigned char*) buf, sizeof (buf) );
	pNDT->PutAttr(gc_ATTR_NAME_CRC, &crc, sizeof(int));

	unsigned char nTopic = 0, nBlob = 0, nUser = 0, nGroup = 0;
	acl_t aclTopic[] = { {gc_AI_GET_PARAGRAPH_TEXT, 0}, {gc_AI_GET_FULL_ATTRIBUTES, 0} };
	acl_t aclBlob[] = { {gc_AI_GET_OBJECT_STREAM, 0}};
	acl_t aclUser[] = { {gc_AI_ADMINISTRATOR, 0}, {gc_AI_CHANGE_IDLE_TIMEOUT, 0} };
	acl_t aclGroup[] = { {gc_AI_ADMINISTRATOR, 0}};

	//internal
	nTopic = sizeof(aclTopic) / sizeof(acl_t);
	aclTopic[0].m_right = 1;
	aclTopic[1].m_right = 1;
	nBlob = sizeof(aclBlob) / sizeof(acl_t);
	aclBlob[0].m_right = 1;

	gc_PutAttributeArray(pNDT, gc_ATTR_NAME_TOPIC_ACL_COUNT, gc_ATTR_NAME_TOPIC_ACL_ARRAY,nTopic, aclTopic);
	gc_PutAttributeArray(pNDT, gc_ATTR_NAME_BLOB_ACL_COUNT, gc_ATTR_NAME_BLOB_ACL_ARRAY, nBlob, aclBlob);
	gc_PutAttributeArray(pNDT, gc_ATTR_NAME_USER_ACL_COUNT, gc_ATTR_NAME_USER_ACL_ARRAY,	nUser, aclUser);
	gc_PutAttributeArray(pNDT, gc_ATTR_NAME_GROUP_ACL_COUNT, gc_ATTR_NAME_GROUP_ACL_ARRAY, nGroup, aclGroup);
}

#ifdef WITH_DBL_THREAD
  #ifdef MIN_MEM_CONTEXT
	extern unsigned getParaWord(char *, const char **, unsigned &, int *);
  #endif
	int bCTXTlast= 0;
#endif

extern	bool	b_recode;
extern	std::deque<std::string> errors;

void DbProcessorMtoGKDB :: InitTopic()
{
	idd_name.clear();
	idd_date.clear();
	idd_regdate.clear ();
	idd_regdatesubs.clear ();
	idd_annuldate.clear ();
	idd_lifesubs.clear ();
	idd_notlifesubs.clear ();
	idd_unrecipesubs.clear ();
	idd_recipesubs.clear ();
	idd_recipesubs.clear ();
	idd_allowedsubs.clear ();
	idd_notallowedsubs.clear ();
	idd_annuldatesubs.clear ();
	idd_id.clear();
	idd_addcode.clear ();
	idd_source.clear();
	idd_div.clear();
	idd_serviceinfo.clear();
	idd_inpharmfirm.clear ();
	idd_atc.clear ();
	idd_regstatus.clear ();
	idd_lekform.clear ();
	idd_inpharmcountry.clear ();
	idd_adword.clear();
	idd_type.clear();
	idd_kind.clear();
	idd_casecode.clear();
	idd_annouser.clear();
	idd_pharmgroup.clear ();
	idd_pharmeffect.clear ();
	idd_mkb.clear ();
	idd_chapter.clear ();
	idd_annoorganization.clear();
	idd_annotax.clear();
	idd_annointerest.clear();
	idd_annokind.clear();
	idd_rcode.clear();
	idd_calin.clear ();
	idd_calab.clear ();
	idd_calch.clear ();
	idd_vincluded.clear();
	idd_vchanged.clear();
	idd_vabolished.clear();
	idd_rdate.clear();
	idd_sortdate.clear();
	idd_vanonced.clear();
	idd_annodate.clear();
	idd_vlcontrol.clear();
	idd_warning.clear();
	idd_publishedin.clear();
	idd_sourcefile.clear();
	idd_territory.clear();
	idd_dockind.clear();
	idd_category.clear();
	idd_tradename.clear ();
	idd_intname.clear ();
#ifdef VERSION56
	for (Activity::iterator i=idd_activity.begin(); i!=idd_activity.end(); i++) {
		if (i->text) delete i->text;
	}
	idd_activity.clear();
	idd_chdate.clear();
	idd_chdateex.clear();
	idd_pages.clear();
	idd_contents.clear();
	idd_comparecontents.clear();
	idd_notsure.clear();
	idd_divisions.clear();
#endif
}

bool bEnglish = false;
extern bool bIgnoreFatal; // see libs/gc/src/glproc.cpp
extern bool bIgnoreTvsErrors;
extern bool b5Context;

void DbProcessorMtoGKDB :: FlushStr(unsigned long topic_id, unsigned short tag, FStringSplaySet& at)
{
	if (at.length() >= 1) {
		long len = 0;
		FString *pSrc= 0;
		for (Pix i = at.first(); i; at.next(i)) {
			pSrc= &(at(i));
			if (len+pSrc->length()+1 > attr_buf_len) {
				unsigned char * new_buf = new unsigned char[attr_buf_len*=2];
				memcpy(new_buf,attr_buf,len+1);
				delete[] attr_buf;
				attr_buf = new_buf;
			}
			memcpy((char*)(attr_buf+len),pSrc->chars(),pSrc->length()+1);
#ifdef	WINENCODE
			if (b_recode) Recoding(cd_dos,cd_win,(char*)(attr_buf+len));
#endif
			len += pSrc->length();
		}
		base->PutAttr(topic_id, tag, attr_buf, len);
	}
}

void DbProcessorMtoGKDB :: FlushInt(unsigned long topic_id, unsigned short tag, u_int32_tSplaySet& at)
{
	if (at.length() != 0)
	{
		if (at.length()*sizeof(u_int32_t) > attr_buf_len)
		{
			delete[] attr_buf;
			attr_buf = new unsigned char[attr_buf_len*=2];
		}
		u_int32_t * int_atr = (u_int32_t*)attr_buf;
		long len = 0;
		for (Pix i = at.first(); i; at.next(i))
		{
			(*(int_atr+len)) = at(i);
			len++;
		}
		base->PutAttr(topic_id, tag, attr_buf, len*sizeof(u_int32_t));
	}
}

#ifdef VERSION56
void DbProcessorMtoGKDB::FlushAct(unsigned long topic_id, unsigned short tag, Activity& at)
{
	size_t len=0;
	for (Activity::iterator i=at.begin(); i!=at.end(); i++) {
		if (!i->b_add_iddactive || i->block)
			continue;
		long curLen=sizeof(i->from)+sizeof(i->to)+1;
		if (i->text) curLen+=strlen(i->text);
		while (len+curLen>attr_buf_len) {
			unsigned char * new_buf = new unsigned char[attr_buf_len*=2];
			memcpy(new_buf,attr_buf,len+1);
			delete[] attr_buf;
			attr_buf = new_buf;
		}
		memcpy((char*)(attr_buf+len), &i->from, sizeof(i->from));
		len+=sizeof(i->from);
		memcpy((char*)(attr_buf+len), &i->to, sizeof(i->to));
		len+=sizeof(i->to);
		*(char*)(attr_buf+len)='\0';
		if (i->text) {
			strcpy((char*)(attr_buf+len), i->text);
#ifdef	WINENCODE
			if (b_recode) Recoding(cd_dos,cd_win,(char*)attr_buf+len);
#endif
			len+=strlen(i->text);
		}
		++len;
	}
	if (len>0) base->PutAttr(topic_id, tag, attr_buf, len);
}

void DbProcessorMtoGKDB::FlushActEx(unsigned long topic_id, unsigned short tag, Activity& at)
{
	size_t len=0;
	std::vector<date> processed_dates;
	std::vector<long> processed_blocks;
	for (Activity::iterator i=at.begin(); i!=at.end(); i++) {
		if (!i->from.da_year)
			continue;
		long curLen=sizeof(i->from)+sizeof(i->block);
		while (len+curLen>attr_buf_len) {
			unsigned char * new_buf = new unsigned char[attr_buf_len *= 2];
			memcpy(new_buf,attr_buf,len+1);
			delete[] attr_buf;
			attr_buf = new_buf;
		}
		bool found = false;
		std::vector<date>::const_iterator date_it = processed_dates.begin ();
		std::vector<long>::const_iterator block_it = processed_blocks.begin ();
		for (; date_it != processed_dates.end () && !found; date_it++, block_it++) {
			date at_date_it = *date_it;
			if (!memcmp (&at_date_it, &i->from, sizeof (date)) && *block_it == i->block)
				found = true;
		}
		if (!found) {
			memcpy((char*)(attr_buf+len), &i->from, sizeof(i->from));
			len+=sizeof(i->from);
			memcpy((char*)(attr_buf+len), &i->block, sizeof(i->block));
			len+=sizeof(i->block);
			processed_dates.push_back (i->from);
			processed_blocks.push_back (i->block);
		}
	}
	if (len>0) base->PutAttr(topic_id, tag, attr_buf, len);
}

void DbProcessorMtoGKDB::FlushNotSure(unsigned long topic_id, unsigned short tag, NotSure& at)
{
	size_t len=0;
	for (NotSure::iterator i=at.begin(); i!=at.end(); i++) {
		long curLen=sizeof(i->from)+sizeof(i->to);
		while (len+curLen>attr_buf_len) {
			unsigned char * new_buf = new unsigned char[attr_buf_len*=2];
			memcpy(new_buf,attr_buf,len+1);
			delete[] attr_buf;
			attr_buf = new_buf;
		}
		memcpy((char*)(attr_buf+len), &i->from, sizeof(i->from));
		len+=sizeof(i->from);
		memcpy((char*)(attr_buf+len), &i->to, sizeof(i->to));
		len+=sizeof(i->to);
#ifdef	VERSION61
		*(char*)(attr_buf+len)='\0';
		if (i->text) {
			strcpy((char*)(attr_buf+len), i->text);
#ifdef	WINENCODE
			if (b_recode) Recoding(cd_dos,cd_win,(char*)attr_buf+len);
#endif
			len+=strlen(i->text);
		}
		++len;
#endif
	}
	if (len>0) base->PutAttr(topic_id, tag, attr_buf, len);
}

void DbProcessorMtoGKDB::FlushChDate(unsigned long topic_id, unsigned short tag, ChDate& at)
{
	size_t len=0;
	for (ChDate::iterator i=at.begin(); i!=at.end(); i++) {
		long curLen=sizeof(i->anonce)+sizeof(i->active);
		while (len+curLen>attr_buf_len) {
			unsigned char * new_buf = new unsigned char[attr_buf_len*=2];
			memcpy(new_buf,attr_buf,len+1);
			delete[] attr_buf;
			attr_buf = new_buf;
		}
		memcpy((char*)(attr_buf+len), &i->anonce, sizeof(i->anonce));
		len+=sizeof(i->anonce);
		memcpy((char*)(attr_buf+len), &i->active, sizeof(i->active));
		len+=sizeof(i->active);
	}
	if (len>0) base->PutAttr(topic_id, tag, attr_buf, len);
}

void DbProcessorMtoGKDB::FlushChDateEx(unsigned long topic_id, unsigned short tag, ChDateExes& at)
{
	size_t len=0;
	for (ChDateExes::iterator i=at.begin(); i!=at.end(); i++) {
		long curLen=sizeof(i->anonce)+sizeof(i->ref);
		while (len+curLen>attr_buf_len) {
			unsigned char * new_buf = new unsigned char[attr_buf_len*=2];
			memcpy(new_buf,attr_buf,len+1);
			delete[] attr_buf;
			attr_buf = new_buf;
		}
		memcpy((char*)(attr_buf+len), &i->anonce, sizeof(i->anonce));
		len+=sizeof(i->anonce);
		memcpy((char*)(attr_buf+len), &i->ref, sizeof(i->ref));
		len+=sizeof(i->ref);
	}
	if (len>0) base->PutAttr(topic_id, tag, attr_buf, len);
}

void DbProcessorMtoGKDB::FlushDivisionInfo(unsigned long topic_id, unsigned short tag, Divisions& at)
{
	size_t len=0;
	for (Divisions::iterator i=at.begin(); i!=at.end(); i++) {
		long curLen=sizeof(i->Para)+sizeof(i->Symbol)+1;
		if (i->Params) curLen+=strlen(i->Params);
		while (len+curLen>attr_buf_len) {
			unsigned char * new_buf = new unsigned char[attr_buf_len*=2];
			memcpy(new_buf,attr_buf,len+1);
			delete[] attr_buf;
			attr_buf = new_buf;
		}
		memcpy((char*)(attr_buf+len), &i->Para, sizeof(i->Para));
		len+=sizeof(i->Para);
		memcpy((char*)(attr_buf+len), &i->Symbol, sizeof(i->Symbol));
		len+=sizeof(i->Symbol);
		*(char*)(attr_buf+len)='\0';
		if (i->Params) {
			strcpy((char*)(attr_buf+len), i->Params);
			len+=strlen(i->Params);
		}
		++len;
	}
	if (len>0) base->PutAttr(topic_id, tag, attr_buf, len);
}
#endif

void DbProcessorMtoGKDB :: Flush(unsigned long topic_id, unsigned char bIsNoDoc)
{
	FlushStr(topic_id, IDD_WARNING, idd_warning);
#ifndef	VERSION61
	FlushStr(topic_id, IDD_NAME, idd_name);
#endif
	FlushStr(topic_id, IDD_SOURCEFILE, idd_sourcefile);
#ifdef FLUSH56
	FlushAct(topic_id, IDD_ACTIVE, idd_activity);
	FlushActEx(topic_id, IDD_ACTIVEEX, idd_activity);
	for (Activity::iterator idd_activity_iter = idd_activity.begin(); idd_activity_iter != idd_activity.end(); idd_activity_iter++)
		if (idd_activity_iter->from.da_year)
			cidxActive->add(&idd_activity_iter->from,topic_id,idd_activity_iter->block);

	FlushChDate(topic_id, IDD_CHDATE, idd_chdate);
	FlushChDateEx(topic_id, IDD_CHDATE_EX, idd_chdateex);
	FlushNotSure(topic_id, IDD_NOTSURE, idd_notsure);
	FlushDivisionInfo(topic_id, IDD_DIVISION, idd_divisions);
	if (idd_pages.size()>0) {
		while (idd_pages.size()*sizeof(Pages::value_type)>attr_buf_len) {
			delete[] attr_buf;
			attr_buf = new unsigned char[attr_buf_len*=2];
		}
		PageBreak* page_atr=(PageBreak*)attr_buf;
		long len = 0;
		for (Pages::iterator pi=idd_pages.begin(); pi!=idd_pages.end(); pi++) {
			page_atr[len++] = *pi;
		}
		base->PutAttr(topic_id, IDD_PAGEBREAKS, attr_buf, len*sizeof(Pages::value_type));
	}
	if (idd_contents.size()>0) {
		while (idd_contents.size()*sizeof(Contents::value_type)>attr_buf_len) {
			delete[] attr_buf;
			attr_buf = new unsigned char[attr_buf_len*=2];
		}
		ContentsStruct* page_atr=(ContentsStruct*)attr_buf;
		long len = 0;
		for (ContentsToGKDF::iterator pi=idd_contents.begin(); pi!=idd_contents.end(); pi++) {
			page_atr[len++] = *pi;
		}
		base->PutAttr(topic_id, IDD_CONTENTS, attr_buf, len*sizeof(Contents::value_type));
	}
	if (idd_comparecontents.size()>0) {
		while (idd_comparecontents.size()*sizeof(CompareContents::value_type)>attr_buf_len) {
			delete[] attr_buf;
			attr_buf = new unsigned char[attr_buf_len*=2];
		}
		CompareContentsStruct* page_atr=(CompareContentsStruct*)attr_buf;
		long len = 0;
		for (CompareContentsToGKDF::iterator pi=idd_comparecontents.begin(); pi!=idd_comparecontents.end(); pi++) {
			page_atr[len++] = *pi;
		}
		base->PutAttr(topic_id, IDD_COMPARECONTENTS, attr_buf, len*sizeof(CompareContents::value_type));
	}
#endif

#ifdef	VERSION62
	FlushStr(topic_id, IDD_PREANNOUSER, idd_annouser);
	FlushStr(topic_id, IDD_PREANNOORGANIZATION, idd_annoorganization);
	FlushStr(topic_id, IDD_PREANNOTAX, idd_annotax);
	FlushStr(topic_id, IDD_PREANNOINTEREST, idd_annointerest);
	FlushStr(topic_id, IDD_PREANNOKIND, idd_annokind);
	FlushInt(topic_id, IDD_PREANNODATE, idd_annodate);
#endif

	Pix i;

	FlushStr(topic_id, IDD_PHARMGROUP, idd_pharmgroup);
	for (i = idd_pharmgroup.first(); i; idd_pharmgroup.next(i))
		cidxInpharmPharmGroup->add(idd_pharmgroup(i).chars (),idd_pharmgroup (i).length (), topic_id);

	FlushStr(topic_id, IDD_PHARMEFFECT, idd_pharmeffect);
	for (i = idd_pharmeffect.first(); i; idd_pharmeffect.next(i))
		cidxInpharmPharmEffect->add(idd_pharmeffect(i).chars (),idd_pharmeffect(i).length (), topic_id);

	FlushStr(topic_id, IDD_MKB, idd_mkb);
	for (i = idd_mkb.first(); i; idd_mkb.next(i)) {
		const char *p = idd_mkb(i).chars();
		char *q = (char*)strchr(idd_mkb(i).chars(),':')+1; *(q-1)=0;
		cidxInpharmMkb->add(q,idd_mkb(i).length()-(q-p)-1,topic_id,atoi(p));
	}

	FlushStr(topic_id, IDD_CHAPTER, idd_chapter);
	for (i = idd_chapter.first(); i; idd_chapter.next(i)) {
		const char *p = idd_chapter(i).chars();
		char *q = (char*)strchr(idd_chapter(i).chars(),':')+1; *(q-1)=0;
		cidxInpharmChapter->add(q,idd_chapter(i).length()-(q-p)-1,topic_id,atoi(p));
	}

	FlushStr(topic_id, IDD_SERVICEINFO, idd_serviceinfo);
	for (i = idd_serviceinfo.first(); i; idd_serviceinfo.next(i)) {
		const char *p = idd_serviceinfo(i).chars();
		char *q = (char*)strchr(idd_serviceinfo(i).chars(),':')+1; *(q-1)=0;
		cidxServiceInfo->add(q,idd_serviceinfo(i).length()-(q-p)-1,topic_id,atoi(p));
	}

	FlushStr(topic_id, IDD_INPHARMFIRM, idd_inpharmfirm);
	for (i = idd_inpharmfirm.first(); i; idd_inpharmfirm.next(i)) {
		const char *p = idd_inpharmfirm(i).chars();
		char *q = (char*)strchr(idd_inpharmfirm(i).chars(),':')+1; *(q-1)=0;
		cidxInpharmFirm->add(q,idd_inpharmfirm(i).length()-(q-p)-1,topic_id,atoi(p));
	}

	FlushStr(topic_id, IDD_ATC, idd_atc);
	for (i = idd_atc.first(); i; idd_atc.next(i))
		cidxAtc->add(idd_atc(i).chars (),idd_atc(i).length (), topic_id);

	FlushStr(topic_id, IDD_REGSTATUS, idd_regstatus);
	for (i = idd_regstatus.first(); i; idd_regstatus.next(i)) {
		const char *p = idd_regstatus(i).chars();
		char *q = (char*)strchr(p,':')+1; *(q-1)=0;
		cidxRegStatus->add(q,idd_regstatus(i).length()-(q-p)-1,topic_id,atoi(p));
	}

	FlushStr(topic_id, IDD_LEKFORM, idd_lekform);
	for (i = idd_lekform.first(); i; idd_lekform.next(i)) {
		const char *p = idd_lekform(i).chars();
		char *q = (char*)strchr(p,':')+1; *(q-1)=0;
		cidxLekForm->add(q,idd_lekform(i).length()-(q-p)-1,topic_id,atoi(p));
	}

	FlushStr(topic_id, IDD_INPHARMCOUNTRY, idd_inpharmcountry);
	for (i = idd_inpharmcountry.first(); i; idd_inpharmcountry.next(i)) {
		const char *p = idd_inpharmcountry(i).chars ();
		char *q = (char*)strchr(idd_inpharmcountry (i).chars (),':')+1; *(q-1)=0;
		cidxInpharmCountry->add(q,idd_inpharmcountry (i).length ()-(q-p)-1, topic_id, atoi (p));
	}

	FlushStr(topic_id, IDD_HANDHANDMASK, idd_adword);
	if (idd_casecode.length () == 1)
		FlushStr(topic_id, IDD_CASECODE, idd_casecode);

	if (idd_regdate.size ()){
		long size = idd_regdate.size () * sizeof (date) + idd_regdatesubs.size () * sizeof (long), *to_write = (long*) malloc (size), *ptr = to_write;
		std::vector<date>::const_iterator date_it = idd_regdate.begin ();
		std::vector<long>::const_iterator subs_it = idd_regdatesubs.begin ();
		for (; date_it != idd_regdate.end (); date_it++, subs_it++) {
			*ptr++ = *subs_it;
			date at_date = *date_it;
			memcpy (ptr, &at_date, sizeof (long));
			ptr++;
			cidxRegDate->add (at_date, topic_id, *subs_it);
		}
		base->PutAttr (topic_id, IDD_REGDATE, to_write, size);
		gk_free (to_write);
	}

	if (idd_lifesubs.size ()) {
		long size = idd_lifesubs.size () * sizeof (long), *to_write = (long*) malloc (size), *ptr = to_write;
		std::vector<long>::const_iterator subs_it = idd_lifesubs.begin ();
		for (; subs_it != idd_lifesubs.end (); subs_it++, ptr++) {
			*ptr = *subs_it;
			cidxStatus_ex->add (DS_LIFE, topic_id, *subs_it);
		}
		base->PutAttr (topic_id, IDD_LIFE, to_write, size);
		gk_free (to_write);
	}
	if (idd_notlifesubs.size ()) {
		long size = idd_notlifesubs.size () * sizeof (long), *to_write = (long*) malloc (size), *ptr = to_write;
		std::vector<long>::const_iterator subs_it = idd_notlifesubs.begin ();
		for (; subs_it != idd_notlifesubs.end (); subs_it++, ptr++) {
			*ptr = *subs_it;
			cidxStatus_ex->add (DS_NOTLIFE, topic_id, *subs_it);
		}
		base->PutAttr (topic_id, IDD_NOTLIFE, to_write, size);
		gk_free (to_write);
	}

	if (idd_unrecipesubs.size ()) {
		long size = idd_unrecipesubs.size () * sizeof (long), *to_write = (long*) malloc (size), *ptr = to_write;
		std::vector<long>::const_iterator subs_it = idd_unrecipesubs.begin ();
		for (; subs_it != idd_unrecipesubs.end (); subs_it++, ptr++) {
			*ptr = *subs_it;
			cidxStatus_ex->add (DS_UNRECIPE, topic_id, *subs_it);
		}
		base->PutAttr (topic_id, IDD_UNRECIPE, to_write, size);
		gk_free (to_write);
	}
	if (idd_recipesubs.size ()) {
		long size = idd_recipesubs.size () * sizeof (long), *to_write = (long*) malloc (size), *ptr = to_write;
		std::vector<long>::const_iterator subs_it = idd_recipesubs.begin ();
		for (; subs_it != idd_recipesubs.end (); subs_it++, ptr++) {
			*ptr = *subs_it;
			cidxStatus_ex->add (DS_RECIPE, topic_id, *subs_it);
		}
		base->PutAttr (topic_id, IDD_RECIPE, to_write, size);
		gk_free (to_write);
	}

	if (idd_allowedsubs.size ()) {
		long size = idd_allowedsubs.size () * sizeof (long), *to_write = (long*) malloc (size), *ptr = to_write;
		std::vector<long>::const_iterator subs_it = idd_allowedsubs.begin ();
		for (; subs_it != idd_allowedsubs.end (); subs_it++, ptr++) {
			*ptr = *subs_it;
			cidxStatus_ex->add (DS_ALLOWED, topic_id, *subs_it);
		}
		base->PutAttr (topic_id, IDD_ALLOWED, to_write, size);
		gk_free (to_write);
	}
	if (idd_notallowedsubs.size ()) {
		long size = idd_notallowedsubs.size () * sizeof (long), *to_write = (long*) malloc (size), *ptr = to_write;
		std::vector<long>::const_iterator subs_it = idd_notallowedsubs.begin ();
		for (; subs_it != idd_notallowedsubs.end (); subs_it++, ptr++) {
			*ptr = *subs_it;
			cidxStatus_ex->add (DS_NOTALLOWED, topic_id, *subs_it);
		}
		base->PutAttr (topic_id, IDD_NOTALLOWED, to_write, size);
		gk_free (to_write);
	}

	if (idd_annuldate.size ()){
		long size = idd_annuldate.size () * sizeof (date) + idd_annuldatesubs.size () * sizeof (long), *to_write = (long*) malloc (size), *ptr = to_write;
		std::vector<date>::const_iterator date_it = idd_annuldate.begin ();
		std::vector<long>::const_iterator subs_it = idd_annuldatesubs.begin ();
		for (; date_it != idd_annuldate.end (); date_it++, subs_it++) {
			*ptr++ = *subs_it;
			date at_date = *date_it;
			memcpy (ptr, &at_date, sizeof (long));
			ptr++;
			cidxAnnulDate->add (at_date, topic_id, *subs_it);
		}
		base->PutAttr (topic_id, IDD_ANNULDATE, to_write, size);
		gk_free (to_write);
	}

#ifdef	NEWNODOC
	if ( bIsNoDoc ) {
		FlushStr(topic_id, IDD_PUBLISHEDIN, idd_publishedin);
		for (i = idd_publishedin.first(); i; idd_publishedin.next(i))
			cidxPublishedIn->add(idd_publishedin(i).chars(),idd_publishedin(i).length()-1,topic_id);
		/*
		for (i = idd_publishedin.first(); i; idd_publishedin.next(i)) {
			char *lptr = (char*)idd_publishedin(i).chars()+idd_publishedin(i).length();
			do {
#ifdef	WINENCODE
				char* recode = strdup( idd_publishedin(i).chars() );
				if (b_recode) Recoding( cd_dos, cd_win, recode );
				add2index( idxPublishedIn, topic_id, recode );
				free( recode );
#else
				add2index( idxPublishedIn, topic_id, idd_publishedin(i).chars() );
#endif
				while( lptr > idd_publishedin(i).chars() && *lptr != '\\' ) lptr--;
				*lptr=0;
			}
			while( lptr > idd_publishedin(i).chars() );
		}
		*/
	}
#endif

	FlushStr(topic_id, IDD_TRADENAME, idd_tradename);
	for (i = idd_tradename.first(); i; idd_tradename.next(i))
		cidxTradeName->add(idd_tradename(i).chars(),idd_tradename(i).length()-1,topic_id);

	FlushStr(topic_id, IDD_INTNAME, idd_intname);
	for (i = idd_intname.first(); i; idd_intname.next(i))
		cidxIntName->add(idd_intname(i).chars(),idd_intname(i).length()-1,topic_id);

	if (!bIsNoDoc) {
		FlushStr(topic_id, IDD_SOURCE, idd_source);
		for (i = idd_source.first(); i; idd_source.next(i))
			cidxSource->add(idd_source(i).chars(),idd_source(i).length()-1,topic_id);
		
		FlushStr(topic_id, IDD_DIV, idd_div);
		for (i = idd_div.first(); i; idd_div.next(i)) {
			const char *p = idd_div(i).chars();
			char *q = (char*)strchr(idd_div(i).chars(),':')+1; *(q-1)=0;
			cidxClass->add(q,idd_div(i).length()-(q-p)-1,topic_id,atoi(p));
		}
		
		FlushStr(topic_id, IDD_TYPE, idd_type);
		for (i = idd_type.first(); i; idd_type.next(i)) {
			const char *p = idd_type(i).chars();
			char *q = (char*)strchr(idd_type(i).chars(),':')+1; *(q-1)=0;
			cidxType->add(q,idd_type(i).length()-(q-p)-1,topic_id,atoi(p));
		}

		FlushStr(topic_id, IDD_KIND, idd_kind);
		for (i = idd_kind.first(); i; idd_kind.next(i)) {
			const char *p = idd_kind(i).chars();
			char *q = (char*)strchr(idd_kind(i).chars(),':')+1; *(q-1)=0;
			cidxKind->add(q,idd_kind(i).length()-(q-p)-1,topic_id,atoi(p));
		}

		FlushStr(topic_id, IDD_RCODE, idd_rcode);
		for (i = idd_rcode.first(); i; idd_rcode.next(i))
			cidxRCode->add(idd_rcode(i).chars(),idd_rcode(i).length()-1,topic_id);
		
		
		FlushStr(topic_id, IDD_PUBLISHEDIN, idd_publishedin);
		for (i = idd_publishedin.first(); i; idd_publishedin.next(i))
			cidxPublishedIn->add(idd_publishedin(i).chars(),idd_publishedin(i).length()-1,topic_id);
		/*
		for (i = idd_publishedin.first(); i; idd_publishedin.next(i)) {
			char *lptr = (char*)idd_publishedin(i).chars()+idd_publishedin(i).length();
			do {
#ifdef	WINENCODE
				char* recode = strdup( idd_publishedin(i).chars() );
				if (b_recode) Recoding( cd_dos, cd_win, recode );
				add2index( idxPublishedIn, topic_id, recode );
				free( recode );
#else
				add2index( idxPublishedIn, topic_id, idd_publishedin(i).chars() );
#endif
				while( lptr > idd_publishedin(i).chars() && *lptr != '\\' ) lptr--;
				*lptr=0;
			}
			while( lptr > idd_publishedin(i).chars() );
		}
		*/
		
		FlushStr(topic_id, IDD_TERRITORY, idd_territory);
		for (i = idd_territory.first(); i; idd_territory.next(i))
			cidxTerritory->add(idd_territory(i).chars(),idd_territory(i).length()-1,topic_id);
		
		FlushStr(topic_id, IDD_DOCKIND, idd_dockind);
		for (i = idd_dockind.first(); i; idd_dockind.next(i)) {
			const char *p = idd_dockind(i).chars();
			char *q = (char*)strchr(idd_dockind(i).chars(),':')+1; *(q-1)=0;
			cidxPrefix->add(q,idd_dockind(i).length()-(q-p)-1,topic_id,atoi(p));
		}
		
		FlushStr(topic_id, IDD_CATEGORY, idd_category);
		for (i = idd_category.first(); i; idd_category.next(i))
			cidxCategory->add(idd_category(i).chars(),idd_category(i).length()-1,topic_id);
		
		FlushStr(topic_id, IDD_ID, idd_id);
		for (i = idd_id.first(); i; idd_id.next(i))
			cidxCode->add(idd_id(i).chars(),idd_id(i).length()-1,topic_id);
		
		FlushStr(topic_id, IDD_ADDCODE, idd_addcode);
		for (i = idd_addcode.first(); i; idd_addcode.next(i))
			cidxCode->add(idd_addcode(i).chars(),idd_addcode(i).length()-1,topic_id);
		
		FlushInt(topic_id, IDD_DATE, idd_date);
		for (i = idd_date.first(); i; idd_date.next(i)) {
			u_int32_t ld = idd_date(i);
			cidxDate->add((const struct date*)&ld,topic_id);
		}
		
		FlushInt(topic_id, IDD_CALIN, idd_calin);
		for (i = idd_calin.first(); i; idd_calin.next(i)) {
			u_int32_t ld = idd_calin(i);
			cidxCalIn->add((const struct date*)&ld,topic_id);
		}
		FlushInt(topic_id, IDD_CALAB, idd_calab);
		for (i = idd_calab.first(); i; idd_calab.next(i)) {
			u_int32_t ld = idd_calab(i);
			cidxCalAb->add((const struct date*)&ld,topic_id);
		}
		FlushInt(topic_id, IDD_CALCH, idd_calch);
		for (i = idd_calch.first(); i; idd_calch.next(i)) {
			u_int32_t ld = idd_calch(i);
			cidxCalCh->add((const struct date*)&ld,topic_id);
		}

		FlushInt(topic_id, IDD_VINCLUDED, idd_vincluded);
		for (i = idd_vincluded.first(); i; idd_vincluded.next(i)) {
			u_int32_t ld = idd_vincluded(i);
			cidxVIncluded->add((const struct date*)&ld,topic_id);
		}
		
		FlushInt(topic_id, IDD_VCHANGED, idd_vchanged);
		for (i = idd_vchanged.first(); i; idd_vchanged.next(i)) {
			u_int32_t ld = idd_vchanged(i);
			cidxVChanged->add((const struct date*)&ld,topic_id);
		}
		
		FlushInt(topic_id, IDD_VABOLISHED, idd_vabolished);
		for (i = idd_vabolished.first(); i; idd_vabolished.next(i)) {
			u_int32_t ld = idd_vabolished(i);
			cidxVAbolished->add((const struct date*)&ld,topic_id);
		}
		
		FlushInt(topic_id, IDD_RDATE, idd_rdate);
		for (i = idd_rdate.first(); i; idd_rdate.next(i)) {
			u_int32_t ld = idd_rdate(i);
			cidxRDate->add((const struct date*)&ld,topic_id);
		}
		
		FlushInt(topic_id, IDD_SORTDATE, idd_sortdate);
		for (i = idd_sortdate.first(); i; idd_sortdate.next(i)) {
			u_int32_t ld = idd_sortdate(i);
			cidxSortDate->add((const struct date*)&ld,topic_id);
		}
		
		FlushInt(topic_id, IDD_VANONCED, idd_vanonced);
		for (i = idd_vanonced.first(); i; idd_vanonced.next(i)) {
			u_int32_t ld = idd_vanonced(i);
			cidxVAnonced->add((const struct date*)&ld,topic_id);
		}
		
		FlushInt(topic_id, IDD_VLCONTROL, idd_vlcontrol);
		for (i = idd_vlcontrol.first(); i; idd_vlcontrol.next(i)) {
			u_int32_t ld = idd_vlcontrol(i);
			cidxVLControl->add((const struct date*)&ld,topic_id);
		}
	}
}

DbProcessorMtoGKDB :: ~DbProcessorMtoGKDB ()
{
#pragma pack(1)
	struct SigBuf {
		unsigned char hour;
		unsigned char min;
		unsigned char sec;
		signed char tzone;
		u_int16_t year;
		char      day;
		char      month;
	};
#pragma pack()

	if( binfo ) {
		time_t tm_now = time(0);
		struct tm *ltime = localtime( &tm_now);
		for( unsigned int i=1; i< MAX_BASES; i++ ){
			BaseInfo *bi= &(binfo[i]);
			if( !bi->RecCount && !bi->Name[0] )
				continue;
			bi->LastUpdate.RevisionDate.da_year = ltime->tm_year + 1900;
			bi->LastUpdate.RevisionDate.da_day = ltime->tm_mday ;
			bi->LastUpdate.RevisionDate.da_mon = ltime->tm_mon +1;
			bi->LastUpdate.RevisionTime.ti_hour = ltime-> tm_hour;
			bi->LastUpdate.RevisionTime.ti_min = ltime-> tm_min;
			bi->LastUpdate.RevisionTime.ti_sec = ltime-> tm_sec;
			bi->LastUpdate.RevisionTime.ti_hund = 0;

#ifdef	WINENCODE
			if (b_recode) Recoding( cd_dos, cd_win, bi->Name ); 
			if (b_recode) Recoding( cd_dos, cd_win, bi->NameEng ); 
#endif
			writeAuxAppend("Base", bi, sizeof( BaseInfo) );
		}
		delete binfo;
	}

	//put unique signature to maximum
	time_t ts;
	struct tm *ptm;
	struct SigBuf pts;

	ts = time(0);
	ptm = localtime(&ts);
	pts.year = (u_int16_t)(ptm->tm_year + 1900);
	pts.month = (unsigned char)(ptm->tm_mon+1);
	pts.day = (unsigned char)(ptm->tm_mday);
	pts.hour = (unsigned char)(ptm->tm_hour);
	pts.min = (unsigned char)(ptm->tm_min);
	pts.sec = (unsigned char)(ptm->tm_sec);

	base->keyFile->PutAttr("HSTS", &pts, 8);

	char buf[8];
	memset(buf, 0, 8);
	base->keyFile->PutAttr("Version", &buf, 4);
	base->keyFile->PutAttr("Ready", &buf, 8);
#undef CSHKDEL
#define CSHKDEL(xxx) if(xxx) { delete xxx; xxx= 0; }
	CSHKDEL(cidxSource);
	CSHKDEL(cidxStatus);
	CSHKDEL(cidxStatus_ex);
	CSHKDEL(cidxSegment);
	CSHKDEL(cidxCategory);
	CSHKDEL(cidxTradeName);
	CSHKDEL(cidxIntName);
	CSHKDEL(cidxServiceInfo);
	CSHKDEL(cidxInpharmFirm);
	CSHKDEL(cidxAtc);
	CSHKDEL(cidxRegStatus);
	CSHKDEL(cidxLekForm);
	CSHKDEL(cidxInpharmCountry);
	CSHKDEL(cidxInpharmPharmGroup);
	CSHKDEL(cidxInpharmPharmEffect);
	CSHKDEL(cidxInpharmMkb);
	CSHKDEL(cidxInpharmChapter);
	CSHKDEL(cidxType);
	CSHKDEL(cidxKind);
	CSHKDEL(cidxCode);
	CSHKDEL(cidxRCode);
	CSHKDEL(cidxDate);
	CSHKDEL(cidxActive);
	CSHKDEL(cidxRegDate);
	CSHKDEL(cidxAnnulDate);
	CSHKDEL(cidxRDate);
	CSHKDEL(cidxSortDate);
	CSHKDEL(cidxVAbolished);
	CSHKDEL(cidxVChanged);
	CSHKDEL(cidxVIncluded);
	CSHKDEL(cidxVAnonced);
	CSHKDEL(cidxVLControl);
	CSHKDEL(cidxClass);
	CSHKDEL(cidxPrefix);
	CSHKDEL(cdoc_belongs);
	CSHKDEL(cidxTerritory);
	CSHKDEL(cidxCalIn);
	CSHKDEL(cidxCalAb);
	CSHKDEL(cidxCalCh);
	CSHKDEL(cidxPublishedIn);
	CSHKDEL(cidxKeyword);
#undef CSHKDEL

	pTopKeyRefs->FreeAll();
	delete pTopKeyRefs;
	delete sTopKeyName;

	if (base) {
		base->SetReady(TID_MF2GARDB);
	}
}
int DbProcessorMtoGKDB :: OK()
{
	return DbProcessorMReader::OK() && base && base->IsOk();
}
void DbProcessorMtoGKDB::setAllCached()
{
	cidxStatus = new CIdxShortInt(idxStatus);
	cidxStatus_ex = new CIdxShortRef(idxStatus_ex);
	cidxSegment = new CIdxShortInt(idxSegment);
	cidxServiceInfo = new CIdxHRefsEx((HIndex*)idxServiceInfo);
	cidxInpharmFirm = new CIdxHRefsEx((HIndex*)idxInpharmFirm);
	cidxAtc = new CIdxHDocsEx((HIndex*)idxAtc);
	cidxRegStatus = new CIdxHRefsEx((HIndex*)idxRegStatus);
	cidxLekForm = new CIdxHRefsEx((HIndex*)idxLekForm);
	cidxInpharmCountry = new CIdxHRefsEx((HIndex*)idxInpharmCountry);
	cidxInpharmPharmGroup = new CIdxHDocsEx((HIndex*)idxInpharmPharmGroup);
	cidxInpharmPharmEffect = new CIdxHDocsEx((HIndex*)idxInpharmPharmEffect);
	cidxInpharmMkb = new CIdxHRefsEx((HIndex*)idxInpharmMkb);
	cidxInpharmChapter = new CIdxHRefsEx((HIndex*)idxInpharmChapter);
	cidxType = new CIdxHRefsEx((HIndex*)idxType);
	cidxKeyword = new CIdxHRefsEx((HIndex*)idxKeyword);
	cidxPublishedIn = new CIdxHDocsEx((HIndex*)idxPublishedIn);
	cidxKind = new CIdxHRefsEx((HIndex*)idxKind);
	cidxCode = new CIdxString(idxCode);
	cidxRCode = new CIdxString(idxRCode);
	cidxCategory = new CIdxString( idxCategory );
	cidxTradeName = new CIdxString (idxTradeName);
	cidxIntName = new CIdxString (idxIntName);
	cidxDate = new CIdxDate(idxDate);
	cidxActive = new CIdxRefDate(idxActive);
	cidxRegDate = new CIdxRefDate(idxRegDate);
	cidxAnnulDate = new CIdxRefDate(idxAnnulDate);
	cidxRDate = new CIdxDate(idxRDate);
	cidxSortDate = new CIdxDate(idxSortDate);
	cidxVAbolished = new CIdxDate(idxVAbolished);
	cidxVChanged = new CIdxDate(idxVChanged);
	cidxVIncluded = new CIdxDate(idxVIncluded);
	cidxVAnonced = new CIdxDate(idxVAnonced);
	cidxVLControl = new CIdxDate(idxVLControl);
	cidxClass = new CIdxClass( (HIndex*) idxClass );
	cidxPrefix = new CIdxPrefix( (HIndex*) idxPrefix );
	cidxSource = new CIdxAdopted( (HIndex*) idxSource );
	cidxTerritory = new CIdxAdopted( (HIndex*) idxTerritory );
	cidxCalIn= new CIdxDate (idxCalIn);
	cidxCalAb= new CIdxDate (idxCalAb);
	cidxCalCh= new CIdxDate (idxCalCh);
}

DbProcessorMtoGKDB::DbProcessorMtoGKDB(DbProcMetaHolder *m,Base *b, int d):
	DbProcessorM0toGKDB(m,b,d),
	cdoc(0),
	cidxStatus(0), cidxSegment(0),cidxCategory(0), cidxStatus_ex(0),
	cidxTradeName (0), cidxIntName (0),
	cidxServiceInfo(0), cidxType(0), cidxKeyword(0), cidxPublishedIn(0), cidxKind(0), cidxCode(0), cidxRCode(0),
	cidxInpharmFirm (0), cidxInpharmCountry (0), cidxInpharmPharmGroup (0),
	cidxAtc (0), cidxRegStatus (0), cidxLekForm (0),
	cidxInpharmPharmEffect (0), cidxInpharmChapter (0), cidxInpharmMkb (0),
	cidxDate(0), cidxRegDate(0), cidxAnnulDate (0), cidxActive (0),
	cidxRDate(0), cidxSortDate(0),
	cidxVAbolished(0), cidxVChanged(0), cidxVIncluded(0),
	cidxVAnonced(0), cidxVLControl(0), cidxClass(0),
	cidxPrefix(0),cidxSource(0),cidxTerritory(0),
	binfo(0),
	cdoc_belongs(0),
	cidxCalIn(0), cidxCalAb(0), cidxCalCh(0)
{
	pTopKeyRefs = new RefCollection;
	sTopKeyName = new FString("");

	attr_buf = new unsigned char[65536];
	attr_buf_len = 65536;

    binfo = new BaseInfo[MAX_BASES];
    bzero((caddr_t)binfo, sizeof(BaseInfo)*MAX_BASES);
    for( unsigned i=0; i < MAX_BASES ; i++ ) binfo[i].BaseId = i;

    cdoc_belongs = new int16_t[MAX_BASES];
#ifdef WITH_DBL_THREAD
	skipBlob= 0;
#endif
}
int DbProcessorMtoGKDB::addref2index(Index *idx,const void *key,
							long id,long s )
{
	Stream *str = idx->Open((void *)key, 1 );
	if( str ){
		RefCollection refs;
		if( refs.Get(str) ){
			Ref rf;
			rf.DocId = id;
			rf.Sub = s;
			refs.Add( rf );
			str->Seek(0 );
			if( !refs.Put( str ) ){
				printf("Can't put ref collection.\n");
				idx->Close(str);
				return 1;
			}
		}else{
			printf("Can't get ref collection.\n");
			idx->Close(str);
			return 1;
		}
		idx->Close(str);
	}else{
		printf("Can't open stream on an index.\n");
		return 1;
	}
	return 0;
}

int DbProcessorMtoGKDB :: add2index( Index *idx, long docid, const void *key )
{
	Stream *str = idx->Open((void *)key, 1 );
	if( str ){
		DocCollection docs;
		if( docs.Get(str) ){
			docs.Add( docid );
			str->Seek(0 );
			if( !docs.Put( str ) ){
				printf("Can't put doc collection.\n");
				idx->Close(str);
				return 1;
			}
		}else{
			printf("Can't get doc collection.\n");
			idx->Close(str);
			return 1;
		}
		idx->Close(str);
	}else{
		printf("Can't open stream on aux.\n");
		return 1;
	}
	return 0;
}
#ifdef PTRS_IN_META
	extern revision today_rev;
	class MetaDoc_GC : public NewDoc_GC_GU {
		public:
			MetaDoc_GC (long id, Base* b, int packing) : NewDoc_GC_GU(id,b,packing){
			}
			virtual int	AddPara (int style, int size, void* buf){
  #ifdef PTRS_ONLY
				if(ParaCount)
					blockParaCount= *(int*)buf - ParaCount;
				else
					blockParaCount= *(int*)buf;

				ParaCount= *(int*)buf;
				docBufPos= style;

				FlushBlock(0);

				free(docBuf);
				docBuf= base->new_docBuf= (char*)*(size_t*)((int*)buf+1);
  #else
				if(ParaCount)
					blockParaCount= style - ParaCount;
				else
					blockParaCount= style;

				ParaCount= style;
				docBufPos= *(int*)buf;
				*(int*)buf= size-23;
				docBuf= (char*)buf - (base->currentBlockSize + 1020);
				FlushBlock(0);
  #endif
				return 1;
			}
			virtual ~MetaDoc_GC(){
				if ( docBufPos > 0 )
					FlushBlock ();

				if(runCount)
					base->ReplaceAttr(DocId,IDD_RUNS,runs,runCount*sizeof(PageRun));
				if(blockCount)
					base->ReplaceAttr(DocId,IDD_BLOCKS,blocks,blockCount*sizeof(BlockRec));

				runCount= 0;
				blockCount= 0;

				docBuf= 0;
				runs= 0;
				blocks= 0;
			}
		protected:
			virtual char *InitPackBuff(int sizeNext= 0){
				if ( usePacking & PM_ZIP )
					return (PackBuf = docBuf);
				return (PackBuf= docBuf+base->currentBlockSize + 1024);
			}
	};
#endif
topic_t DbProcessorMtoGKDB ::  createTopic(long id,const char *title,int tl,
										const revision *r,int pk)
{
	(void)tl;
	if( debug ){
		printf( "createTopic: id: %ld\n", id);
	}
	if( cdoc ){
		printf( "Warning: concurrent new documents not now supported.\n");
		delete cdoc;
		cdoc = 0;
		c_topic= 0;
	}
	cdoc = new 
#ifdef PTRS_IN_META
	MetaDoc_GC(id,base,pk);
  #ifdef PTRS_ONLY
	if(base->new_docBuf){
		free(base->new_docBuf);
	}
	cdoc->docBuf= base->new_docBuf= (char*)*(size_t*)r;
  #endif
	*(revision*)r= today_rev;
#else
	NewDoc_GC_GU(id,base,pk);
#endif
	InitTopic();
	if( (unsigned) tl > DOC_SHORT_NAME_SIZE ){
		printf( "\nCreate topic: title length too long for topic %ld\n",
			id - 100000);
		tl = DOC_SHORT_NAME_SIZE;
	}
	strncpy (cdoc->pInfo->Title,title,tl );
	cdoc->pInfo->Title[DOC_SHORT_NAME_SIZE-1] = 0;
#ifdef	WINENCODE
	if (b_recode) Recoding( cd_dos, cd_win, cdoc->pInfo->Title );
#endif
	if( !cdoc ){
		printf("Can't new NewDocument?!.\n");
		return 0;
	}
	c_topic = id;
	cdoc_nbelongs = 0;
#ifdef WITH_DBL_THREAD
	lastParaStyle= 0;
#endif
	return c_topic;
}

int DbProcessorMtoGKDB :: setTopicName(topic_t tpic,const char *d,
			u_int32_t size)
{
#ifdef WITH_DBL_THREAD
  #ifdef MIN_MEM_CONTEXT
	if( b5Context && lastParaStyle & 0x2000 ){
		at_f = 0;
		src= d;
		len0 = size;
		while ( *(u_int64_t*)buf128=0, getParaWord(buf128, &src, len0, &at_f) ){
			sp = &(*p_ctxNameMap)[*(u_int64_t*)buf128];
			if( (topic_t)sp->lastElemV != tpic ){
				if( sp->lastI >= sp->capacity ){
					sp->capacity += GROW_BY;
					sp->e=(long*)realloc(sp->e,sizeof(long)*sp->capacity);
					if( !sp->e ){
						printf("\nNo memory!\n");
						exit(1);
					}
					itemsDone++;
				}
				sp->e[sp->lastI++] = tpic;
				sp->lastElemV = tpic;
			}
		}
	}
  #endif
#endif
	if( debug ){
		printf( "setTopicName: id: %ld\n", tpic);
	}

#ifdef	VERSION61
	setRefName( tpic, d, size, 0 );
#else
	if( size > DOC_NAME_SIZE ){
		printf("Name for topic too long.\n");
		size = DOC_NAME_SIZE;
	}
	FString s(d,size);s.bDoFree= 1;
	if(!idd_name.seek(s)){
		idd_name.add(s);
		s.bDoFree= 0;
	}
#endif
	return 0;
}

int DbProcessorMtoGKDB::writeAuxAppend(const void *key,const void *d,int l)
{
	Stream *str = idxAux->Open((void *)key, 1 );
	if( str ){
		str->Seek( str->Length() );
		if( l != str->Write((void *)d,l) ){
			printf("Warning: partial write on aux.\n");
		}
		idxAux->Close(str);
	}else{
		printf("Can't open stream on aux.\n");
		return 1;
	}
	return 0;
}

int DbProcessorMtoGKDB :: setTopicSubDesc(topic_t t, SubDesc  *d, long l)
{
	if( debug ){
		printf( "setTopicSubDesc: id: %ld\n", t);
	}
	l *= sizeof(SubDesc);

	base->PutAttr(t, IDD_SUBS,d, l);
	return 0;
}

int DbProcessorMtoGKDB :: setTopicSubDescEx (topic_t t, SubDescEx *d, long l)
{
	l *= sizeof(SubDescEx);
	base->ReplaceAttr(t, IDD_SUBS_EX,d, l);
	return 0;
}

int DbProcessorMtoGKDB::setBaseCore(u_int32_t bid, BaseCore *bi)
{
	if( debug ){
		printf( "setTopicCore: id: %ld\n", bid);
	}
    if( bid < MAX_BASES ){
		/*
		if( bi->accountTopic ){
			if( binfo[bid].AccountTopic ){
				printf("Account topic already set for base %ld\n", bid);
			}else{
				binfo[bid].AccountTopic = bi->accountTopic;
			}
		}
		if( bi->businessTopic ){
			if( binfo[bid].BusinessTopic ){
				printf("Business topic already set for base %ld\n", bid);
			}else{
				binfo[bid].BusinessTopic = bi->businessTopic;
			}
		}
		if( bi->userInfoTopic ){
			if( binfo[bid].UserInfoTopic ){
				printf("userInfo topic already set for base %ld\n", bid);
			}else{
				binfo[bid].UserInfoTopic = bi->userInfoTopic;
			}
		}
		*/
		if( bi->splashTopic ){
			if( binfo[bid].SplashTopic ){
				printf("Splash topic already set for base %ld\n", bid);
			}else{
				binfo[bid].SplashTopic = bi->splashTopic;
			}
		}
		if( bi->bannerTopic ){
			if( binfo[bid].BannerTopic ){
				printf("Banner topic already set for base %ld\n", bid);
			}else{
				binfo[bid].BannerTopic = bi->bannerTopic;
			}
		}
		strncpy(binfo[bid].AuthorName, bi->copyright,NAME_SIZE);
		strncpy(binfo[bid].Name, bi->name, BASE_NAME_SIZE);
		strncpy(binfo[bid].NameEng, bi->nameEng, BASE_NAME_SIZE);
		binfo[bid].Weight = (u_int16_t)(bi->weight & 0xffff);
	}else{
		printf("Base id too hi.\n");
		return 1;
	}
	return 0;
}
int DbProcessorMtoGKDB :: setTopicInfo(topic_t t, DocInfo *di )
{
	if( debug ){
		printf( "setTopicInfo: id: %ld\n", t);
	}
	if( t == c_topic ){
		if( cdoc ){
			DocInfo *cdi = cdoc->pInfo;
			cdi->Revision = di->Revision;
			cdi->FirstDate = di->FirstDate;
			cdi->LastDate = di->LastDate;
			cdi->Force = di->Force;
			cdi->HyperRefs = di->HyperRefs;
			cdi->GreenComments = di->GreenComments;
			cdi->Status = di->Status;
			cdi->Status_ex = di->Status_ex;
			cdi->Related = di->Related;
			SetDocStatusExEx (cdi, GetDocStatusExEx (di));
#ifdef	FLUSH56
			cdi->prevEdition = di->prevEdition;
			cdi->nextEdition = di->nextEdition;
#endif
			SetDocMonitoring(cdi,GetDocMonitoring(di));
		}else{
			printf("NewDoc loosed...\n");
			return 1;
		}
	} else{
		printf("NewDoc loosed...\n");
		return 1;
	}
	return 0;
}
int DbProcessorMtoGKDB :: setTopicStatus(topic_t t, int s)
{
  static short value;
  if( debug )
      printf( "setTopicStatus: id: %ld, value: 0x%x\n", t, s);

  if( s & DS_WARNING )
      cidxStatus->add(t,DS_WARNING);

  if( s & DS_MOJREG )
      cidxStatus->add(t,DS_MOJREG);

  if( s & DS_MOJNOTREG )
      cidxStatus->add(t,DS_MOJNOTREG);

  if( s & DS_MOJOTHER )
      cidxStatus->add(t,DS_MOJOTHER);
  
  if( s & DS_EDITION )
	  cidxStatus->add(t,DS_EDITION);

  if( s & DS_NODOC )
	  cidxStatus->add(t,DS_NODOC);

  if( s & DS_DOC )
	  cidxStatus->add(t,DS_DOC);

  if( s & DS_ANNO )
	  cidxStatus->add(t,DS_ANNO);

  if ( !(s & (DS_EDITION | DS_NODOC) )) {
	  if( s & DS_ACTIVE )
		  cidxStatus->add(t,DS_ACTIVE);

	  if( s & DS_ABOLISHED )
		  cidxStatus->add(t,DS_ABOLISHED);

	  if( s & DS_PREACTIVE )
		  cidxStatus->add(t,DS_PREACTIVE);

	  if( t == c_topic ) {
		  if( cdoc )
			  cdoc->pInfo->Status |= DS_DOC;
	  }
  }

  return 0;
}

int DbProcessorMtoGKDB :: setTopicStatus_exex(topic_t t, int s)
{
	return 0;
}

int DbProcessorMtoGKDB :: setTopicStatus_ex(topic_t t, int s,gdocsub_t sub)
{
	if (s & DS_MEDTOPIC) {
		if (t == c_topic && cdoc)
			cdoc->pInfo->Status_ex |= DS_MEDTOPIC;
		cidxStatus_ex->add (DS_MEDTOPIC,t,0);
	} else if (s & DS_FLASH)
		cidxStatus_ex->add (DS_FLASH,t,0);
	else if (s & DS_FIRMTOPIC)
		cidxStatus_ex->add (DS_FIRMTOPIC,t,0);
	else if (s & DS_MDICTTOPIC)
		cidxStatus_ex->add (DS_MDICTTOPIC,t,0);
	else if (s & DS_NARCOTIC)
		cidxStatus_ex->add (DS_NARCOTIC,t,0);
	else if (s & DS_NOTNARCOTIC)
		cidxStatus_ex->add (DS_NOTNARCOTIC,t,0);
	else if (s & DS_LIFE)
		idd_lifesubs.push_back (sub);
	else if (s & DS_NOTLIFE)
		idd_notlifesubs.push_back (sub);
	else if (s & DS_UNRECIPE)
		idd_unrecipesubs.push_back (sub);
	else if (s & DS_RECIPE)
		idd_recipesubs.push_back (sub);
	else if (s & DS_ALLOWED)
		idd_allowedsubs.push_back (sub);
	else if (s & DS_NOTALLOWED)
		idd_notallowedsubs.push_back (sub);
	else if (s & DS_IZM)
		cidxStatus_ex->add (DS_IZM,t,0);
	else if (s & DS_DATE)
		cidxStatus_ex->add (DS_DATE,t,0);

	return 0;
}

int DbProcessorMtoGKDB :: setCorrs(u_int32_t t,u_int64_t *d,u_int32_t c)
{
	if( debug ){
		printf( "setCorrs: id: %ld\n.", t);
	}
	c *= sizeof(u_int64_t);
	return write2index(idxCorr,&t,d, c );
}

int DbProcessorMtoGKDB :: setTopicResps(topic_t t,u_int64_t *d,u_int32_t c)
{
	if( debug ){
		printf( "setTopicResps: id: %ld\n", t);
	}
	c *= sizeof(u_int64_t);
	return write2index(idxResp,&t,d, c );
}

int DbProcessorMtoGKDB :: setTopicBelongs(topic_t t,int16_t *d,int c)
{
	if( debug )
		printf( "setTopicBelongs: id: %ld\n", t);

	if( t == c_topic ) {
		if( cdoc ) {
			if ( (cdoc->pInfo->Status & DS_DOC) || (cdoc->pInfo->Status_ex & DS_MEDTOPIC) ) {
				for( int i=0; i<c; i++ )
					cidxSegment->add(t,d[i]);
			}
		} else {
			printf("NewDoc loosed...\n");
			return 1;
		}
	} else {
		printf("NewDoc loosed...\n");
		return 1;
    }
	
	cdoc_nbelongs = c;
	c *= sizeof(int16_t);
	memcpy(cdoc_belongs,d,c);
	base->PutAttr(t, IDD_BASES,d, c);
	return 0;
}
int DbProcessorMtoGKDB :: setTopicCategory(topic_t t, const char *d, size_t l)
{
	FString s(d,l);s.bDoFree= 1;
	if(!idd_category.seek(s)){
		idd_category.add(s);
		s.bDoFree= 0;
	}
	return 0;
}

int DbProcessorMtoGKDB :: setTopicTradeName (topic_t t, const char *d, size_t l)
{
	FString s(d,l);
	idd_tradename.add(s);
	return 0;
}

int DbProcessorMtoGKDB :: setTopicIntName (topic_t t, const char *d, size_t l)
{
	FString s(d,l);
	idd_intname.add(s);
	return 0;
}

int DbProcessorMtoGKDB :: add2ClassIndex(const char *c,
						size_t l,topic_t t, gdocsub_t ss)
{
	if( debug ){
		printf( "add2ClassIndex: id: %ld '%s'\n", t, c);
	}
	char *buf = (char*)malloc(l+20);
	int bl = sprintf(buf,"%ld:%s", ss, c );

	FString s(buf,bl+1);s.bDoFree= 1;
	if(!idd_div.seek(s)){
		idd_div.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: add2PrefixIndex(const char *c,
						size_t l,topic_t t, gdocsub_t ss)
{
	(void) l;
	if( debug ){
		printf( "add2PrefixIndex: id: %ld '%s'\n", t, c);
	}
	char *buf = (char*)malloc(l+20);
	int bl = sprintf(buf,"%ld:%s", ss, c );

	FString s(buf,bl+1);s.bDoFree= 1;
	if(!idd_dockind.seek(s)){
		idd_dockind.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: setClassAndPrefix(const char *c, size_t cl,
											const char *p, size_t pl)
{
	if( debug ){
		printf( "setClassAndIndex '%s' -- '%s'\n", c,p);
	}
	cl--;
	pl--;
	cidxClass->add(c,cl,p,pl);
	return 0;
}

#ifdef __WIN32__
	#ifdef __MSVC__
		#define SNPRINTF _snprintf
	#else
#include <cstdarg>

static int SNPRINTF(char *buf, int len, const char *format, ...)
{
	va_list arglist;
	va_start(arglist, format);
	vsprintf(buf, format, arglist);
	va_end(arglist);
}
	#endif
#else
	#define SNPRINTF snprintf
#endif


int DbProcessorMtoGKDB::setUNode(const char *pfx, size_t pfxLen,
						 int jtype, 
						 const char *uname, size_t ul,
						 const char *cls, size_t clsl )
{
	int n = 1 + 1 + ul+1+clsl;
	char *bf = (char *)malloc( n +10 );
	n = SNPRINTF( bf, n, "%d:%s:%s", jtype, uname, cls );
	cidxPrefix->add(pfx, pfxLen, bf, n +1);
	free(bf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicDate(topic_t t,date &d)
{
	u_int32_t * _d = (u_int32_t *)&d;
	idd_date.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicRegDate(topic_t t,date &d, gdocsub_t sub)
{
	idd_regdate.push_back (d);
	idd_regdatesubs.push_back (sub);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicEvd(topic_t t, const char* data, size_t len)
{
#ifndef PTRS_IN_META
	base->ReplaceAttr(t, IDD_EVD, (void*)data, len);
#else
  #ifdef PTRS_ONLY
	void *pdata= (void*)*(size_t*)(1+(int*)data);
	base->ReplaceAttr(t, IDD_EVD, pdata, *(int*)data);
	free(pdata);
  #else
	base->ReplaceAttr(t, IDD_EVD, (void*)data, len);
  #endif
#endif
	return 0;
}

int DbProcessorMtoGKDB :: addTopicParaHeights(topic_t t, const char* data, size_t len)
{
	base->PutAttr(t, IDD_PARAHEIGHTS, data, len);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAnnulDate(topic_t t,date &d, gdocsub_t sub)
{
	idd_annuldate.push_back (d);
	idd_annuldatesubs.push_back (sub);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicRDate(topic_t t,date &d)
{
	if( debug ){
		printf( "addTopicRDate: id: %ld\n", t);
	}
	u_int32_t * _d = (u_int32_t *)&d;
	idd_rdate.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicSortDate(topic_t t,date &d)
{
	if( debug ){
		printf( "addTopicSortDate: id: %ld\n", t);
	}
	u_int32_t * _d = (u_int32_t *)&d;
	idd_sortdate.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicVAbolished(topic_t t,date &d)
{
	if( debug ){
		printf( "addTopicVAbolished: id: %ld\n", t);
	}
	u_int32_t * _d = (u_int32_t *)&d;
	idd_vabolished.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicCalIn (topic_t t,date &d)
{
	u_int32_t * _d = (u_int32_t *)&d;
	idd_calin.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicCalAb (topic_t t,date &d)
{
	u_int32_t * _d = (u_int32_t *)&d;
	idd_calab.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicCalCh (topic_t t,date &d)
{
	u_int32_t * _d = (u_int32_t *)&d;
	idd_calch.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicVIncluded(topic_t t,date &d)
{
	if( debug ){
		printf( "addTopicVIncluded: id: %ld\n", t);
	}
	u_int32_t * _d = (u_int32_t *)&d;
	idd_vincluded.add(*_d);
	return 0;
}
int DbProcessorMtoGKDB :: addTopicVAnonced(topic_t t,date &d)
{
	if( debug ){
		printf( "addTopicVAnonced: id: %ld\n", t);
	}
	u_int32_t * _d = (u_int32_t *)&d;
	idd_vanonced.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAnnoDate(topic_t t,date &d)
{
	if( debug ){
		printf( "addTopicAnnoDate: id: %ld\n", t);
	}
	u_int32_t * _d = (u_int32_t *)&d;
	idd_annodate.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicVLControl(topic_t t,date &d)
{
	if( debug ){
		printf( "addTopicVLControl: id: %ld\n", t);
	}
	u_int32_t * _d = (u_int32_t *)&d;
	idd_vlcontrol.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicVChanged(topic_t t,date &d)
{
	if( debug ){
		printf( "addTopicVChanged: id: %ld\n", t);
	}
	u_int32_t * _d = (u_int32_t *)&d;
	idd_vchanged.add(*_d);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicChange(topic_t t, IddChangeStruct* i)
{
	base->PutAttr (t, IDD_CHANGE, i, sizeof (IddChangeStruct));
	return 0;
}


#ifdef VERSION56
int DbProcessorMtoGKDB :: addTopicActivity(topic_t t, const DocActivityEx& i)
{
	if( debug ){
		printf( "addTopicActivity: id: %ld\n", t);
	}
	idd_activity.insert(i);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicNotSure(topic_t t, const DocNotSure& i)
{
	if( debug ){
		printf( "addTopicNotSure: id: %ld\n", t);
	}
	idd_notsure.insert(i);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicChDate(topic_t t, const DocChDate& i)
{
	if( debug ){
		printf( "addTopicChDate: id: %ld\n", t);
	}
	idd_chdate.insert(i);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicChDateEx(topic_t t, const ChDateEx& i)
{
	if( debug ){
		printf( "addTopicChDateEx: id: %ld\n", t);
	}
	idd_chdateex.insert(i);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicDivision(topic_t t, const DivisionInfo& i)
{
	if( debug ){
		printf( "addTopicDivision: id: %ld\n", t);
	}
	idd_divisions.insert(i);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicPages(topic_t t, const PageBreak& i)
{
	if( debug ){
		printf( "addTopicPages: id: %ld\n", t);
	}
	idd_pages.push_back(i);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicContents(topic_t t, const ContentsStruct& i)
{
	if( debug ){
		printf( "addTopicContents: id: %ld\n", t);
	}
	idd_contents.push_back(i);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicCompareContents(topic_t t, const CompareContentsStruct& i)
{
	if( debug ){
		printf( "addTopicCompareContents: id: %ld\n", t);
	}
	idd_comparecontents.push_back(i);
	return 0;
}
#endif

int DbProcessorMtoGKDB :: addTopicRcode(topic_t t,const char *d, size_t l)
{
	if( debug ){
		printf( "addTopicRcode: id: %ld\n", t);
	}
	FString s(d,l);s.bDoFree= 1;
	if(!idd_rcode.seek(s)){
		idd_rcode.add(s);
		s.bDoFree= 0;
	}
	return 0;
}

int DbProcessorMtoGKDB :: addTopicCode(topic_t t,const char *d, size_t l)
{
	if( debug ){
		printf( "addTopicCode: id: %ld\n", t);
	}
	FString s(d,l);s.bDoFree= 1;
	if(!idd_id.seek(s)){
		idd_id.add(s);
		s.bDoFree= 0;
	}
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAddCode(topic_t t,const char *d, size_t l)
{
	if( debug ){
		printf( "addTopicAddCode: id: %ld\n", t);
	}
	FString s(d,l);s.bDoFree= 1;
	if(!idd_addcode.seek(s)){
		idd_addcode.add(s);
		s.bDoFree= 0;
	}
	return 0;
}

int DbProcessorMtoGKDB :: addTopicServiceInfo(const char *d, size_t l,
									   topic_t t, gdocsub_t sub)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_serviceinfo.seek(s)){
		idd_serviceinfo.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicInpharmFirm (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_inpharmfirm.seek(s)){
		idd_inpharmfirm.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAtc (const char *d, size_t l, topic_t t)
{
	FString s(d,l);
	if (!idd_atc.seek (s))
		idd_atc.add(s);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicRegStatus (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_regstatus.seek(s)){
		idd_regstatus.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicLekForm (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_lekform.seek(s)){
		idd_lekform.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicInpharmCountry (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_inpharmcountry.seek(s)){
		idd_inpharmcountry.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAdword(const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_adword.seek(s)){
		idd_adword.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicCasecode(const char *d, size_t l, topic_t t)
{
	FString s (d,l);
	idd_casecode.add(s);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicType(const char *d, size_t l,
									   topic_t t, gdocsub_t sub)
{
	if( debug ){
		printf( "addTopicType: id: %ld\n", t);
	}
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_type.seek(s)){
		idd_type.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicKind(const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	if (!strcmp (d, "$DUMMY$"))
		return 0;

	if( debug ){
		printf( "addTopicKind: id: %ld\n", t);
	}
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_kind.seek(s)){
		idd_kind.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAnnoUser(const char *d, size_t l, topic_t t)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%s", d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_annouser.seek(s)){
		idd_annouser.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicPharmGroup (const char *d, size_t l, topic_t t)
{
	FString s(d,l);
	if (!idd_pharmgroup.seek (s))
		idd_pharmgroup.add(s);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicPharmEffect (const char *d, size_t l, topic_t t)
{
	FString s(d,l);
	if (!idd_pharmeffect.seek (s))
		idd_pharmeffect.add(s);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicMkb (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_mkb.seek(s)){
		idd_mkb.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicChapter (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%ld:%s", sub, d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_chapter.seek(s)){
		idd_chapter.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAnnoOrganization(const char *d, size_t l, topic_t t)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%s", d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_annoorganization.seek(s)){
		idd_annoorganization.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAnnoTax(const char *d, size_t l, topic_t t)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%s", d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_annotax.seek(s)){
		idd_annotax.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAnnoInterest(const char *d, size_t l, topic_t t)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%s", d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_annointerest.seek(s)){
		idd_annointerest.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicAnnoKind(const char *d, size_t l, topic_t t)
{
	char *buf = (char*)malloc(l+16);
	int bfLen = sprintf(buf, "%s", d);

	FString s(buf,bfLen+1);s.bDoFree= 1;
	if(!idd_annokind.seek(s)){
		idd_annokind.add(s);
		s.bDoFree= 0;
	}
	free(buf);
	return 0;
}

int DbProcessorMtoGKDB :: addTopicSource(const char *d, size_t l, topic_t t)
{
	if( debug ){
		printf( "addTopicSource: id: %ld\n", t);
		printf( "addTopicSource: source: %s (%d)\n", d, l);
	}
	FString s(d,l);s.bDoFree= 1;
	if(!idd_source.seek(s)){
		idd_source.add(s);
		s.bDoFree= 0;
	}
	return 0;
}

int DbProcessorMtoGKDB::addTopicTerritory(const char *d, size_t l,topic_t t)
{
	if( debug ){
		printf( "addTopicTerritory: id: %ld\n", t);
		printf( "addTopicTerritory: territory: %s\n", d);
	}
	FString s(d,l);s.bDoFree= 1;
	if(!idd_territory.seek(s)){
		idd_territory.add(s);
		s.bDoFree= 0;
	}
	return 0;
}

int DbProcessorMtoGKDB :: setSourceAndTerritory(const char *s, size_t sl,
											const char *t, size_t tl)
{
	if( debug ){
		printf( "setSourceAndTerritory '%s' -- '%s'\n", s,t);
	}
	sl--;
	tl--;
	cidxSource->add(s,sl,t,tl);
//	cidxTerritory->add(t,tl,s,sl);
	return 0;
}


int DbProcessorMtoGKDB :: addTopicPublishedIn(topic_t t,const char *d, size_t l)
{
	if( debug ){
		printf( "addPublishedIn: id: %ld\n", t);
		printf( "addPublishedIn: published in: %s\n", d);
	}
	FString s(d,l);s.bDoFree= 1;
	if(!idd_publishedin.seek(s)){
		idd_publishedin.add(s);
		s.bDoFree= 0;
	}
	return 0;
}

int DbProcessorMtoGKDB::setRefName(topic_t t,const char *n,
						size_t l,gdocsub_t s)
{
	if( debug ){
		printf( "setRefName: id: %ld\n", t);
	}
	Ref rf;
	rf.DocId = t;
	rf.Sub = s;
	Stream *str = base -> subNames -> Open ( &rf, 1 );
	if( str ){
#ifdef	WINENCODE
		if ( t >= ID_DIC_LO && t < ID_DIC_HI && s > 2 && s < 7 )
			str->Write((void*)n,l);
		else {
			char *recode = (char*)alloca( l + 1 );
			strncpy( recode, n, l );
			recode[ l ] = 0;
			if (b_recode) Recoding( cd_dos, cd_win, recode );
			str->Write(recode,l);
		}
#else
		str->Write((void*)n,l);
#endif
		base->subNames->Close(str);
	}else{
		printf("Can't open stream.\n");
		return 1;
	}
	return 0;
}

int DbProcessorMtoGKDB :: addTopicPara(topic_t t, int s,
						const void *p, int len)
{
	if( debug ){
		printf( "addTopicPara: id: %ld length: %d\n", t, len);
	}
	if( t == c_topic ){
#ifndef PTRS_IN_META
		if( (unsigned int)len < BLOCK_SIZE - sizeof ( BlockHeader ) -3 )
#endif
		{
	#ifdef WITH_DBL_THREAD
	  #ifdef MIN_MEM_CONTEXT
		if( b5Context && ( s & 0x2000)) {
			s &= ~0x2000;
			cdoc->AddPara(s,len, (void *)p);
			if(p_ctxTextMap){
				lastParaStyle |= 0x2000;
				// in Context //
				at_f = 0;
				src= (const char*)(cdoc->docBuf + (cdoc->docBufPos-len-3));
				len0=	TextSize ( src );
				src=	ParaText ( src );
				while ( *(u_int64_t*)buf128=0, getParaWord(buf128, &src, len0, &at_f) ){
				#if CTX_WORD_SIZE == 5 && BYTEORDER == 1234
					*(u_int64_t*)buf128 &= 0x000000ffffffffffULL;
				#elif CTX_WORD_SIZE ==8
					// no mask
				#else
					#error dont know how to handle (specify mask) :)
				#endif
					sp = &(*p_ctxTextMap)[*(u_int64_t*)buf128];
					if( (u_int32_t)sp->lastElemV != t ){
						if( sp->lastI >= sp->capacity ){
							sp->capacity += GROW_BY;
							sp->e=(long*)realloc(sp->e,sizeof(long)*sp->capacity);
							if( !sp->e ){
								printf("\nNo memory!\n");
								exit(1);
							}
							itemsDone++;
						}
						sp->e[sp->lastI++] = t;
						sp->lastElemV = t;
					}
				}
			}
  		} else
	  #endif
	#endif
			cdoc->AddPara(s,len, (void *)p);
		}
#ifndef PTRS_IN_META
		else {
			printf("\nParagraph for docid %ld too long for %ld database.\n", t);
			printf("Paragraph ignored.\n");
		}
#endif
	} else {
		printf("\n=================\n");
		printf("Concurrent newdocs not now supported.\n");
		printf("Current: %ld  requested: %ld\n", c_topic, t);
		return 1;
	}
	return 0;
}

int DbProcessorMtoGKDB :: addTopicEmptyPara(topic_t t )
{
	static char emptyPara[6] = { 8,0,0,0,0,0 };
	if( debug ){
		printf( "addTopicEmptyPara: id: %ld\n", t);
	}
	if( t == c_topic ){
		cdoc->AddPara(PS_PREFORMATTED,5, emptyPara);
	}else{
		printf("\n=================\n");
		printf("Concurrent newdocs not now supported.\n");
		printf("Current: %ld  requested: %ld\n", c_topic, t);
		return 1;
	}
	return 0;
}

#ifdef WITH_DBL_THREAD
	//extern "C" unsigned Pack(char *, int, char *, int);
	#include "../../../libs/gc/src/gclog.h"
	extern AdvLogger gclog;
#endif

unsigned char dummy_bmp[] ="\
\x42\x4D\x0A\x29\x00\x00\x00\x00\x00\x00\x76\x00\x00\x00\x28\x00\x00\x00\x85\x01\x00\x00\x35\x00\x00\x00\x01\x00\x04\x00\x00\x00\
\x00\x00\x94\x28\x00\x00\xC4\x0E\x00\x00\xC4\x0E\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x00\x00\x80\
\x00\x00\x00\x80\x80\x00\x80\x00\x00\x00\x80\x00\x80\x00\x80\x80\x00\x00\x80\x80\x80\x00\xC0\xC0\xC0\x00\x00\x00\xFF\x00\x00\xFF\
\x00\x00\x00\xFF\xFF\x00\xFF\x00\x00\x00\xFF\x00\xFF\x00\xFF\xFF\x00\x00\xFF\xFF\xFF\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\
\x11\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x00\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x10\x99\x99\x99\x99\x99\x99\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x00\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x00\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x10\x19\x99\x99\x99\x99\x99\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x90\x09\x99\x00\x99\x00\x91\
\x19\x99\x99\x91\x01\x99\x99\x00\x99\x90\x09\x99\x00\x09\x99\x00\x00\x00\x00\x00\x09\x99\x10\x11\x99\x90\x09\x99\x00\x99\x91\x01\
\x90\x19\x99\x99\x00\x99\x10\x19\x99\x10\x19\x99\x90\x09\x90\x99\x00\x99\x00\x99\x90\x09\x90\x09\x99\x00\x99\x11\x99\x99\x00\x91\
\x01\x99\x90\x09\x99\x00\x99\x99\x91\x01\x99\x99\x00\x91\x19\x99\x99\x91\x01\x99\x99\x00\x99\x09\x90\x09\x90\x09\x99\x99\x99\x91\
\x10\x01\x99\x99\x00\x99\x09\x90\x09\x90\x09\x99\x99\x91\x19\x99\x90\x09\x99\x91\x01\x99\x99\x00\x99\x99\x99\x99\x00\x99\x10\x19\
\x99\x10\x19\x99\x90\x09\x90\x99\x00\x99\x00\x99\x90\x09\x90\x09\x99\x00\x99\x11\x99\x99\x00\x91\x01\x99\x90\x09\x99\x00\x99\x99\
\x91\x01\x99\x99\x00\x91\x19\x99\x99\x10\x19\x01\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x90\x09\x99\
\x00\x99\x00\x00\x00\x99\x99\x00\x00\x09\x99\x00\x99\x90\x09\x99\x00\x09\x99\x00\x00\x00\x00\x00\x09\x90\x00\x00\x19\x90\x09\x99\
\x00\x99\x10\x00\x10\x99\x99\x99\x00\x99\x00\x99\x90\x00\x00\x99\x90\x09\x10\x19\x00\x99\x00\x99\x90\x09\x90\x01\x99\x00\x99\x00\
\x19\x99\x00\x99\x00\x99\x90\x09\x99\x00\x99\x99\x00\x00\x09\x99\x00\x00\x00\x99\x99\x00\x00\x09\x99\x00\x91\x01\x90\x09\x90\x09\
\x99\x99\x99\x10\x00\x00\x09\x99\x00\x91\x01\x90\x09\x90\x09\x99\x99\x90\x01\x99\x90\x09\x99\x00\x00\x09\x99\x00\x99\x99\x99\x99\
\x00\x99\x00\x99\x90\x00\x00\x99\x90\x09\x10\x19\x00\x99\x00\x99\x90\x09\x90\x01\x99\x00\x99\x00\x19\x99\x00\x99\x00\x99\x90\x09\
\x99\x00\x99\x99\x00\x00\x09\x99\x00\x00\x00\x99\x91\x00\x01\x09\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\
\x99\x90\x09\x99\x00\x99\x00\x19\x10\x19\x91\x01\x91\x01\x99\x00\x99\x90\x09\x91\x01\x01\x99\x00\x99\x00\x99\x00\x99\x10\x99\x99\
\x99\x90\x09\x99\x00\x99\x00\x99\x00\x99\x99\x99\x00\x91\x01\x99\x10\x19\x10\x19\x90\x09\x01\x09\x00\x99\x00\x99\x90\x09\x90\x00\
\x19\x00\x99\x90\x09\x99\x00\x99\x10\x09\x90\x09\x99\x00\x99\x91\x01\x91\x01\x99\x00\x19\x10\x19\x91\x01\x91\x01\x99\x00\x90\x10\
\x90\x09\x99\x99\x99\x99\x99\x01\x99\x91\x01\x99\x00\x90\x10\x90\x09\x99\x99\x99\x99\x99\x00\x99\x90\x09\x91\x01\x91\x01\x99\x00\
\x99\x99\x99\x99\x00\x91\x01\x99\x10\x19\x10\x19\x90\x09\x01\x09\x00\x99\x00\x99\x90\x09\x90\x00\x19\x00\x99\x90\x09\x99\x00\x99\
\x10\x09\x90\x09\x99\x00\x99\x91\x01\x91\x01\x99\x00\x19\x10\x19\x90\x09\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x90\x00\x99\x99\x99\x90\x09\x99\x00\x99\x00\x99\x90\x09\x90\x09\x99\x00\x99\x00\x99\x90\x09\x91\x09\x01\x99\x00\x99\x00\x99\x00\
\x99\x00\x00\x00\x09\x90\x00\x00\x00\x99\x90\x19\x00\x99\x99\x99\x00\x00\x19\x99\x00\x99\x90\x09\x90\x09\x09\x09\x00\x99\x00\x99\
\x90\x09\x90\x01\x09\x00\x99\x90\x09\x99\x00\x99\x91\x00\x00\x09\x99\x00\x99\x90\x09\x99\x00\x99\x00\x99\x90\x09\x90\x09\x99\x00\
\x99\x00\x90\x90\x90\x09\x99\x99\x99\x99\x91\x09\x99\x99\x19\x99\x00\x90\x90\x90\x09\x99\x99\x99\x99\x99\x00\x99\x90\x09\x90\x09\
\x99\x00\x99\x00\x99\x99\x99\x99\x00\x00\x19\x99\x00\x99\x90\x09\x90\x09\x09\x09\x00\x99\x00\x99\x90\x09\x90\x01\x09\x00\x99\x90\
\x09\x99\x00\x99\x91\x00\x00\x09\x99\x00\x99\x90\x09\x99\x00\x99\x00\x99\x90\x09\x99\x01\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x90\x00\x99\x99\x99\x90\x09\x99\x00\x99\x00\x99\x90\x09\x90\x09\x99\x00\x99\x00\x99\x90\x09\x90\x19\x10\x99\x00\
\x99\x00\x99\x00\x99\x00\x00\x00\x19\x90\x00\x00\x00\x99\x99\x11\x00\x99\x99\x99\x00\x01\x99\x99\x00\x99\x90\x09\x90\x01\x19\x11\
\x00\x99\x00\x99\x90\x09\x90\x09\x01\x00\x99\x90\x09\x99\x00\x99\x10\x00\x00\x09\x99\x00\x99\x90\x09\x99\x00\x99\x00\x99\x90\x09\
\x90\x09\x99\x00\x99\x00\x11\x91\x10\x09\x99\x99\x99\x99\x90\x09\x99\x99\x99\x99\x00\x11\x91\x10\x09\x99\x99\x99\x99\x99\x00\x99\
\x90\x09\x90\x09\x99\x00\x99\x00\x99\x99\x99\x99\x00\x01\x99\x99\x00\x99\x90\x09\x90\x01\x19\x11\x00\x99\x00\x99\x90\x09\x90\x09\
\x01\x00\x99\x90\x09\x99\x00\x99\x10\x00\x00\x09\x99\x00\x99\x90\x09\x99\x00\x99\x00\x99\x90\x09\x99\x91\x10\x09\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x90\x09\x99\x00\x99\x00\x19\x10\x19\x91\x01\x91\x01\x99\x00\x99\x90\x09\x90\
\x19\x10\x99\x00\x99\x00\x99\x00\x99\x10\x99\x90\x19\x90\x09\x99\x00\x99\x99\x99\x00\x99\x99\x99\x00\x91\x09\x99\x10\x19\x10\x19\
\x90\x00\x19\x10\x00\x99\x00\x99\x90\x09\x90\x09\x10\x00\x99\x90\x09\x99\x00\x99\x00\x99\x90\x09\x99\x00\x99\x91\x01\x91\x01\x99\
\x00\x19\x10\x19\x91\x01\x91\x01\x99\x00\x01\x91\x00\x09\x99\x99\x99\x99\x90\x09\x99\x99\x99\x99\x00\x01\x91\x00\x09\x99\x99\x99\
\x99\x99\x00\x99\x90\x09\x91\x01\x91\x01\x99\x00\x99\x99\x99\x99\x00\x91\x09\x99\x10\x19\x10\x19\x90\x00\x19\x10\x00\x99\x00\x99\
\x90\x09\x90\x09\x10\x00\x99\x90\x09\x99\x00\x99\x00\x99\x90\x09\x99\x00\x99\x91\x01\x91\x01\x99\x00\x19\x10\x19\x99\x99\x90\x09\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x90\x00\x00\x00\x99\x00\x00\x00\x99\x99\x00\x00\x09\x99\x00\
\x00\x00\x09\x10\x99\x90\x19\x00\x99\x00\x99\x00\x99\x90\x00\x00\x99\x90\x09\x99\x00\x99\x10\x00\x01\x99\x99\x99\x00\x91\x00\x09\
\x90\x00\x00\x99\x90\x00\x99\x90\x00\x99\x00\x00\x00\x09\x90\x09\x91\x00\x99\x90\x00\x00\x00\x99\x10\x00\x00\x09\x00\x00\x00\x99\
\x00\x00\x09\x99\x00\x00\x00\x99\x99\x00\x00\x09\x99\x00\x09\x99\x00\x09\x99\x99\x99\x99\x90\x09\x99\x99\x99\x99\x00\x09\x99\x00\
\x09\x99\x99\x99\x99\x99\x00\x00\x00\x09\x99\x00\x00\x09\x99\x00\x00\x09\x99\x99\x00\x91\x00\x09\x90\x00\x00\x99\x90\x00\x99\x90\
\x00\x99\x00\x00\x00\x09\x90\x09\x91\x00\x99\x90\x00\x00\x00\x99\x10\x00\x00\x09\x00\x00\x00\x99\x00\x00\x09\x99\x00\x00\x00\x99\
\x91\x00\x00\x19\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x90\x00\x00\x00\x99\x00\x91\x19\x99\x99\x91\
\x01\x99\x99\x00\x00\x00\x09\x10\x99\x90\x19\x00\x99\x00\x99\x00\x99\x99\x10\x19\x99\x90\x09\x99\x00\x99\x91\x00\x19\x99\x99\x99\
\x00\x99\x10\x09\x99\x10\x19\x99\x90\x00\x99\x90\x00\x99\x00\x00\x00\x09\x90\x09\x99\x00\x99\x90\x00\x00\x00\x99\x91\x00\x00\x09\
\x00\x00\x00\x99\x91\x01\x99\x99\x00\x91\x19\x99\x99\x91\x01\x99\x99\x00\x09\x99\x00\x09\x99\x99\x99\x99\x91\x09\x99\x99\x19\x99\
\x00\x09\x99\x00\x09\x99\x99\x99\x99\x99\x00\x00\x00\x09\x99\x91\x01\x99\x99\x00\x00\x09\x99\x99\x00\x99\x10\x09\x99\x10\x19\x99\
\x90\x00\x99\x90\x00\x99\x00\x00\x00\x09\x90\x09\x99\x00\x99\x90\x00\x00\x00\x99\x91\x00\x00\x09\x00\x00\x00\x99\x91\x01\x99\x99\
\x00\x91\x19\x99\x99\x10\x01\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x01\
\x99\x91\x01\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x10\x00\x00\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x91\x10\x01\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x01\x19\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x01\x19\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x91\x09\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x91\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x00\x99\x99\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x91\x01\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x91\x01\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x00\x99\x99\x90\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\
\x99\x99\x91\x00\x19\x99\x99\x90\x09\x99\x91\x01\x90\x19\x99\x99\x00\x99\x10\x19\x91\x01\x90\x19\x00\x91\x19\x99\x99\x00\x99\x90\
\x09\x99\x00\x99\x00\x99\x90\x09\x90\x09\x91\x01\x99\x10\x19\x01\x99\x99\x99\x91\x01\x99\x99\x90\x09\x99\x99\x10\x19\x99\x90\x00\
\x99\x99\x00\x99\x99\x91\x01\x99\x99\x00\x99\x90\x00\x00\x19\x99\x90\x00\x99\x99\x91\x01\x19\x99\x90\x09\x99\x99\x99\x00\x99\x90\
\x09\x91\x19\x99\x90\x09\x90\x09\x99\x00\x99\x99\x99\x00\x99\x90\x09\x99\x91\x01\x99\x99\x00\x00\x01\x99\x90\x09\x11\x99\x99\x99\
\x10\x11\x99\x10\x99\x00\x99\x01\x00\x00\x00\x00\x09\x99\x91\x01\x19\x99\x00\x99\x90\x09\x99\x10\x19\x01\x99\x99\x90\x09\x99\x00\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x90\x00\x99\x99\x99\x99\x00\x00\x00\x19\x99\x90\x09\x99\x10\x00\x10\x99\x99\x99\x00\x99\x00\x99\x10\x00\x10\x99\x00\x00\x00\x99\
\x99\x00\x99\x90\x01\x99\x00\x99\x00\x99\x90\x09\x90\x09\x90\x09\x91\x00\x01\x09\x99\x99\x99\x00\x00\x09\x99\x90\x09\x99\x90\x00\
\x01\x99\x90\x00\x99\x99\x00\x99\x99\x00\x00\x19\x99\x00\x99\x90\x00\x00\x01\x99\x90\x00\x99\x99\x00\x00\x01\x99\x90\x09\x99\x99\
\x99\x00\x19\x90\x09\x90\x01\x99\x90\x09\x90\x01\x99\x00\x99\x99\x99\x00\x99\x90\x09\x99\x00\x00\x09\x99\x00\x00\x00\x19\x90\x00\
\x00\x09\x99\x90\x00\x00\x19\x90\x19\x00\x91\x09\x00\x00\x00\x00\x09\x99\x00\x00\x01\x99\x00\x99\x90\x09\x91\x00\x01\x09\x99\x99\
\x90\x01\x99\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x90\x00\x99\x99\x99\x91\x01\x99\x91\x09\x99\x90\x09\x99\x00\x99\x00\x99\x99\x99\x00\x91\x01\x99\x00\x99\x00\x99\
\x00\x19\x10\x19\x99\x00\x99\x90\x00\x19\x00\x99\x00\x99\x90\x09\x90\x09\x10\x19\x90\x09\x90\x09\x99\x99\x91\x01\x91\x01\x99\x90\
\x09\x99\x10\x99\x01\x99\x10\x10\x19\x99\x00\x99\x91\x09\x90\x19\x99\x00\x99\x90\x09\x99\x00\x99\x10\x10\x19\x91\x09\x99\x99\x99\
\x90\x09\x99\x99\x99\x00\x01\x90\x09\x99\x00\x99\x90\x09\x90\x00\x19\x00\x99\x99\x99\x00\x99\x90\x09\x91\x01\x91\x01\x99\x00\x99\
\x90\x09\x90\x01\x91\x01\x99\x10\x99\x99\x99\x91\x09\x00\x90\x19\x91\x09\x99\x00\x99\x91\x09\x99\x99\x99\x00\x99\x90\x09\x90\x09\
\x90\x09\x99\x99\x90\x00\x19\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x19\x99\x99\x01\x99\x90\x09\x99\x90\x19\x00\x99\x99\x99\x00\x00\x19\x99\
\x90\x19\x00\x99\x00\x99\x90\x09\x99\x00\x99\x90\x01\x09\x00\x99\x00\x00\x00\x09\x90\x00\x01\x99\x99\x01\x90\x09\x99\x99\x90\x09\
\x99\x00\x99\x90\x09\x99\x00\x99\x99\x99\x10\x90\x19\x99\x00\x99\x90\x09\x99\x99\x99\x00\x99\x90\x00\x00\x01\x99\x10\x90\x19\x90\
\x00\x00\x00\x99\x90\x09\x99\x99\x99\x00\x10\x90\x09\x99\x00\x99\x90\x09\x90\x01\x09\x00\x99\x99\x99\x00\x99\x90\x09\x90\x09\x99\
\x00\x99\x00\x00\x00\x19\x90\x09\x99\x00\x99\x00\x00\x00\x09\x99\x10\x00\x01\x99\x99\x01\x99\x00\x99\x90\x00\x00\x00\x99\x00\x00\
\x00\x09\x99\x01\x90\x09\x99\x99\x90\x01\x09\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x00\x99\x90\x09\x99\x99\x11\x00\x99\x99\x99\
\x00\x01\x99\x99\x99\x11\x00\x99\x00\x99\x90\x09\x99\x00\x99\x90\x09\x01\x00\x99\x00\x00\x00\x09\x90\x00\x19\x99\x99\x91\x10\x09\
\x99\x99\x90\x09\x99\x00\x99\x90\x09\x99\x00\x99\x99\x99\x01\x91\x09\x99\x00\x99\x90\x09\x99\x99\x99\x00\x99\x90\x00\x00\x19\x99\
\x01\x91\x09\x90\x00\x00\x01\x99\x90\x09\x99\x99\x99\x00\x90\x10\x09\x99\x00\x99\x90\x09\x90\x09\x01\x00\x99\x99\x99\x00\x99\x90\
\x09\x90\x09\x99\x00\x99\x00\x00\x01\x99\x90\x09\x99\x00\x99\x00\x00\x00\x19\x99\x10\x00\x01\x99\x99\x01\x99\x00\x99\x90\x00\x00\
\x01\x99\x00\x00\x00\x09\x99\x91\x10\x09\x99\x99\x90\x09\x01\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x90\x00\x00\x99\x90\x09\x99\x99\x99\
\x00\x99\x99\x99\x00\x91\x09\x99\x99\x99\x00\x99\x00\x19\x10\x19\x99\x00\x99\x90\x09\x10\x00\x99\x00\x99\x90\x09\x90\x09\x10\x99\
\x99\x99\x90\x09\x99\x99\x91\x01\x91\x01\x99\x90\x09\x99\x10\x99\x01\x99\x01\x91\x09\x99\x00\x99\x91\x09\x90\x19\x99\x00\x99\x90\
\x09\x99\x01\x99\x01\x91\x09\x91\x09\x99\x01\x99\x90\x09\x99\x99\x99\x00\x91\x00\x09\x99\x00\x99\x90\x09\x90\x09\x10\x00\x99\x99\
\x99\x00\x99\x90\x09\x91\x01\x91\x01\x99\x00\x99\x90\x19\x90\x01\x91\x01\x99\x10\x99\x90\x19\x91\x09\x00\x90\x19\x99\x00\x99\x00\
\x99\x91\x09\x99\x01\x99\x00\x99\x90\x09\x99\x99\x90\x09\x99\x99\x90\x09\x10\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x90\x00\x00\x90\x00\
\x00\x09\x10\x00\x01\x99\x99\x99\x00\x91\x00\x09\x10\x00\x01\x99\x00\x00\x00\x99\x00\x00\x00\x90\x09\x91\x00\x99\x00\x99\x90\x09\
\x90\x09\x10\x00\x91\x00\x00\x19\x99\x99\x99\x00\x00\x09\x90\x00\x00\x09\x90\x00\x01\x91\x09\x99\x01\x00\x00\x00\x99\x00\x00\x19\
\x00\x00\x00\x90\x00\x00\x01\x91\x09\x99\x01\x99\x00\x00\x09\x90\x00\x00\x09\x99\x99\x00\x99\x10\x09\x99\x00\x00\x00\x09\x90\x09\
\x91\x00\x99\x99\x99\x00\x00\x00\x09\x99\x00\x00\x09\x99\x00\x00\x00\x19\x90\x00\x00\x09\x99\x90\x00\x00\x99\x00\x19\x00\x91\x00\
\x99\x00\x00\x00\x99\x99\x00\x00\x09\x99\x00\x99\x90\x09\x91\x00\x00\x19\x99\x99\x90\x09\x91\x00\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x19\x99\
\x99\x01\x90\x00\x00\x09\x91\x00\x19\x99\x99\x99\x00\x99\x10\x09\x91\x00\x19\x99\x00\x91\x19\x99\x00\x00\x00\x90\x09\x99\x00\x99\
\x00\x99\x90\x09\x90\x09\x91\x00\x99\x10\x01\x99\x99\x99\x99\x91\x01\x99\x90\x00\x00\x09\x99\x10\x19\x91\x09\x99\x01\x00\x00\x00\
\x99\x91\x01\x99\x00\x00\x00\x90\x00\x00\x19\x91\x09\x99\x01\x99\x91\x01\x99\x90\x00\x00\x09\x99\x99\x00\x99\x90\x09\x99\x00\x00\
\x00\x09\x90\x09\x99\x00\x99\x99\x99\x00\x00\x00\x09\x99\x91\x01\x99\x99\x00\x00\x01\x99\x90\x09\x11\x99\x99\x99\x10\x19\x99\x01\
\x99\x00\x99\x10\x99\x00\x00\x00\x99\x99\x91\x01\x99\x99\x00\x99\x90\x09\x99\x10\x01\x99\x99\x99\x90\x09\x99\x00\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\
\x99\x91\x01\x99\x91\x09\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x90\x00\x99\x99\x99\x99\x00\x00\x00\x19\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x91\x00\x11\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x90\x00\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\
\x99\x99\x99\x99\x99\x99\x99\x99\x90\x00";

//__int64 skipMeta;

int DbProcessorMtoGKDB::setBlobData(u_int32_t blob, const void *ddd,size_t l)
{
	void *d= alloca(l);
	memcpy(d,ddd,l);
#ifdef WITH_DBL_THREAD
	char *objRoot;
#ifdef __MINGW32__
        long long
#else
        u_int64_t /*__int64*/
#endif
            szFile, dataSize;
	int fd = 0, szPk;

	skipBlob= 0;
#endif
	if( debug ){
		printf( "setBlobData: id: %d\n", blob);
	}
	ObjKey k;
	k.id = blob;
	*((long*)k.reserved) = 0;

	{
		//t2.start_incr();
#ifdef WITH_DBL_THREAD
		char pParsedObj[]="meta-file", *q;
		objRoot= (char*)d + sizeof(ObjInfo);
		if( debug )
			printf("\rPacking from '%s'...", objRoot);

		int objRoot_length = strlen (objRoot);
		bool use_template = false;
#ifdef	unix
		use_template = (objRoot_length > 11) && (!strcmp (objRoot + objRoot_length - 11, "$DUMMY$.BMP"));
#endif
		if (use_template) {
			szFile = sizeof (dummy_bmp)-1;
		} else {
			fd = ace_os_open(objRoot, ACE_OS_O_RDONLY | ACE_OS_O_BINARY );
			if(fd == -1){
				if (gclog.flName)
					free(gclog.flName);
				gclog.lineno= 0;
				gclog.flName= strdup(pParsedObj);
				gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Ó≈ Õœ«’ œ‘À“Ÿ‘ÿ ∆¡ Ã '%s'\n", objRoot);
				skipBlob= 1;
				return -1;
			}
            szFile = ace_os_lseek(fd, 0, ACE_OS_SEEK_END);
			ace_os_lseek(fd, 0, ACE_OS_SEEK_SET);
		}
		if( szFile * 2 + sizeof(ObjInfo) + l + 3 > ((DbProcMetaFile*)mh)->rdbsz ){
			((DbProcMetaFile*)mh)->rdbsz= RDBFSZ*((szFile * 2 + sizeof(ObjInfo) + l + 3)/RDBFSZ)+RDBFSZ;
			((DbProcMetaFile*)mh)->rdbuf = (char *)realloc(((DbProcMetaFile*)mh)->rdbuf,((DbProcMetaFile*)mh)->rdbsz);
		}
		q= ((DbProcMetaFile*)mh)->rdbuf+sizeof(ObjInfo)+szFile;
		if (use_template) {
			memcpy (q, dummy_bmp, szFile);
		} else {
			dataSize= szFile= ace_os_read(fd, q, szFile);
			ace_os_close(fd);
		}
		if(((ObjInfo*)d)->type == EOT_PIC){
			if(*(short*)(((DbProcMetaFile*)mh)->rdbuf+sizeof(ObjInfo)+szFile) != 0x4d42){
				//Í‡ÚËÌÍ‡ ÌÂ ‚ bmp - ÔÓ‰ÎÓÊËÏ Á‡„ÎÛ¯ÍÛ
			#ifdef	unix
				szFile = sizeof (dummy_bmp)-1;
				if(szFile * 2 + sizeof(ObjInfo) + l > rdbsz){
					rdbsz += szFile * 2 + sizeof(ObjInfo) + l;
					((DbProcMetaFile*)mh)->rdbuf= (char*)realloc(((DbProcMetaFile*)mh)->rdbuf, rdbsz);
				}
				q= ((DbProcMetaFile*)mh)->rdbuf+sizeof(ObjInfo)+szFile;
				memcpy (q, dummy_bmp, szFile);
			#endif
				if (gclog.flName)
					free(gclog.flName);
				gclog.lineno= 0;
				gclog.flName= strdup(pParsedObj);
				gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "√‡ÙË˜ÂÒÍËÈ Ù‡ÈÎ (%s) ÌÂ ‚ ÙÓÏ‡ÚÂ BMP.\n", objRoot);
			#ifndef	unix
				skipBlob= 1;
				return -1;
			#endif
			}
			PBITMAPINFOHEADER bih = (PBITMAPINFOHEADER)(((DbProcMetaFile*)mh)->rdbuf+sizeof(ObjInfo)+szFile + sizeof(BITMAPFILEHEADER));
			dataSize = (int)BitmapSize(bih->biWidth,bih->biHeight,bih->biBitCount);
			if (szFile < dataSize) {
				if (gclog.flName)
					free(gclog.flName);
				gclog.lineno= 0;
				gclog.flName= strdup(pParsedObj);
				gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "√‡ÙË˜ÂÒÍËÈ Ù‡ÈÎ (%s) ÏÂÌ¸¯Â, ˜ÂÏ ‰ÎËÌ‡, ÛÍ‡Á‡ÌÌ‡ˇ ‚ Á‡„ÓÎÓ‚ÍÂ.\n", objRoot);
#ifdef	unix
				szFile = dataSize = sizeof (dummy_bmp)-1;
				if(szFile * 2 + sizeof(ObjInfo) + l > rdbsz){
					rdbsz = (szFile * 2 + sizeof(ObjInfo))*2 + l;
					((DbProcMetaFile*)mh)->rdbuf= (char*)realloc(((DbProcMetaFile*)mh)->rdbuf, rdbsz);
				}
				q= ((DbProcMetaFile*)mh)->rdbuf+sizeof(ObjInfo)+szFile;
				memcpy (q, dummy_bmp, szFile);
#else
				skipBlob= 1;
				return -1;
#endif
			}
			if (szFile > dataSize) {
				if (gclog.flName)
					free(gclog.flName);
				gclog.lineno= 0;
				gclog.flName= strdup(pParsedObj);
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "√‡ÙË˜ÂÒÍËÈ Ù‡ÈÎ (%s) ÛÂÁ‡Ì Ì‡ %d ·‡ÈÚ.\n", objRoot, szFile-dataSize);

				//Í‡ÚËÌÍ‡ ÌÂ‚ÂÌÓ„Ó ‡ÁÏÂ‡ - ÔÓ‰ÎÓÊËÏ Á‡„ÎÛ¯ÍÛ
			#ifdef	unix
				szFile = dataSize = sizeof (dummy_bmp)-1;
				if(szFile * 2 + sizeof(ObjInfo) + l > rdbsz){
					rdbsz += (szFile * 2 + sizeof(ObjInfo))*2 + l;
					((DbProcMetaFile*)mh)->rdbuf= (char*)realloc(((DbProcMetaFile*)mh)->rdbuf, rdbsz);
				}
				q= ((DbProcMetaFile*)mh)->rdbuf+sizeof(ObjInfo)+szFile;
				memcpy (q, dummy_bmp, szFile);
			#endif
			}
		}

		((ObjInfo*)d)->crc32= crc32(0, (const Bytef *)q, dataSize);
		objRoot= ((DbProcMetaFile*)mh)->rdbuf;
		unsigned long type = ((ObjInfo*)d)->type;
		if( (type != EOT_PNG && type != EOT_JPG && type != EOT_GIF && type != EOT_PDF) && (szPk= G_ZIP( q, dataSize, ((DbProcMetaFile*)mh)->rdbuf+sizeof(ObjInfo), dataSize-1))){
			((ObjInfo*)d)->packed++;
		}else{
			memcpy(((DbProcMetaFile*)mh)->rdbuf+sizeof(ObjInfo), q, dataSize);
			szPk= dataSize;
		}
		*(ObjInfo*)objRoot= *(ObjInfo*)d;
		((ObjInfo*)objRoot)->size = szPk;
		memcpy (objRoot + sizeof(ObjInfo) + szPk, (char*)d + sizeof(ObjInfo) + ((ObjInfo*)d)->size, l - sizeof(ObjInfo) - ((ObjInfo*)d)->size);
		l -= ((ObjInfo*)d)->size - szPk;
		d= objRoot;
#endif
		//skipMeta -= l;
		//t2.stop_incr();
		{
			Stream *str = idxBlob->OpenN(&k, 0, 1 );
			if(!str){
				fprintf(stderr, "\n *** Can not open stream for blob %d ** \n", blob);
				return 1;
			}
			str->Write(d,l);
			str->Trunc();
			idxBlob->Close(str);
		}
	}
	return 0;
}

int DbProcessorMtoGKDB::setBlobFormsBelongs(u_int32_t blob,int16_t *d,int c)
{
#ifdef WITH_DBL_THREAD
	if(skipBlob)
		return 1;
#endif
	for (int i = 0; i < c; i++) {
		BaseInfo *bi = &(binfo[d[i]]);
		bi->FormsCount++;
	}
	return 0;
}

int DbProcessorMtoGKDB::setBlobBelongs(u_int32_t blob,int16_t *d,int c)
{
#ifdef WITH_DBL_THREAD
	if(skipBlob)
		return 1;
#endif
	if( debug ){
		printf( "setBlobBelongs: id: %d\n", blob);
	}
	c *= sizeof(int16_t);
	ObjKey k;
	k.id = blob;
	*((long*)k.reserved) = 0;
	Stream *str = idxBlob->OpenN(&k, 1, 1 );
	if( str ){
		str->Write(d,c);
		str->Trunc();
		idxBlob->Close(str);
	}else{
		fprintf(stderr, "\n*** Can not open stream#1 for blob %d **\n", blob);
		return 1;
	}

	return 0;
}

int DbProcessorMtoGKDB::addKeyWord (const char *k, size_t l, const void * refs, size_t lr)
{
#ifdef	WINENCODE
	char* kk = strdup (k);
	if (b_recode) Recoding (cd_dos, cd_win, kk);
#else
	const char* kk = k;
#endif
	char buf [512];

	Ref* ref_buf = (Ref*)refs;
	unsigned long refs_count = lr / sizeof (Ref);

	int i;
	for (i = 0; i < (int)refs_count; i++, ref_buf++) {
		long bfLen = sprintf (buf, "%ld:%s", ref_buf->Sub, kk), aFound = 0, aKeySize = 0, doc_id = ref_buf->DocId;
		DocInfo docInfo;
		bool present = ( base->FindDocInfo (doc_id, docInfo) == sizeof( DocInfo ));
		if ( present && ( docInfo.Status & ( DS_EDITION | DS_ANNO ))) {
			gclog.noHdr();
			gclog.printfC(errors,AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ÕÂ‚ÂÌ‡ˇ ÒÒ˚ÎÍ‡: ÍÎ˛˜Â‚ÓÂ ÒÎÓ‚Ó \"%s\" ÌÂ ÏÓÊÂÚ ÒÒ˚Î‡Ú¸Òˇ Ì‡ ÓÚÒÛÚÒÚ‚Û˛˘ËÈ ‰ÓÍÛÏÂÌÚ, Â‰‡ÍˆË˛ ËÎË ‡ÌÌÓÚ‡ˆË˛ %ld.\n", strchr( buf, ':' )+1, doc_id);
		} else {
			char *aKeys = (char*) base->LoadAttr (doc_id, IDD_KEY, aKeySize), *aKey = (char*)aKeys;
			if (aKeySize) {
				while (aKey - (char*)aKeys < aKeySize && !aFound) {
					if (!strncmp (aKey, buf, bfLen+1)) {
						gclog.noHdr();
	#ifdef	WINENCODE
						gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Œ·Ì‡ÛÊÂÌ‡ ‰Û·ÎËÛ˛˘‡ˇÒˇ ÒËÚÛ‡ˆËˇ: %s\n", aKey);
	#else
						gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "é°≠†‡„¶•≠† §„°´®‡„ÓÈ†Ô·Ô ·®‚„†Ê®Ô: %s\n", aKey);
	#endif
						aFound = 1;
					}
					aKey += strlen (aKey) + 1;
				}
				gk_free (aKeys);
			}
			if (!aFound) {
				base->PutAttr (doc_id, IDD_KEY, buf, bfLen + 1);
				cidxKeyword->add (k, strlen (k), doc_id, ref_buf->Sub);
			}
		}
	}

#ifdef	WINENCODE
	free(kk);
#endif
	return 0;
}

int DbProcessorMtoGKDB :: endTopic(topic_t &t
#ifdef PTRS_IN_META
											, u_int32_t a0, size_t a1
#endif
							)
{
	if( debug ){
		printf( "endTopic: id: %ld\n", t);
	}
	if( t == c_topic ){
		if( cdoc ){
#ifdef PTRS_IN_META
			if(cdoc->ParaCount)
				cdoc->blockParaCount= long(a0 & 0x7fffffff) - cdoc->ParaCount;
			else
				cdoc->blockParaCount= long(a0 & 0x7fffffff);
			cdoc->ParaCount= long(a0 & 0x7fffffff);
  #ifdef PTRS_ONLY
			cdoc->docBufPos= int(a1 & 0x7fffffff);
			((NewDoc_GC_GU*)cdoc)->PackBuf = cdoc->docBuf+cdoc->base->currentBlockSize + 1024;
  #else
			cdoc->docBuf= ((char*)a1) - (cdoc->base->currentBlockSize + 1008);
			cdoc->docBufPos= (1+(DbProcMetaHolder::SetRefData*)a1)->docid;
			(1+(DbProcMetaHolder::SetRefData*)a1)->docid= ((DbProcMetaHolder::SetRefData*)a1)->datalen-23;
  #endif
#endif
			int i;
			if ( cdoc->pInfo->Status & ( DS_EDITION | DS_DOC ))
				Flush(t,0);
			else
				Flush(t,DS_NODOC);

			for(i = 0; i< cdoc_nbelongs; i++ ){
				BaseInfo *bi = &( binfo[cdoc_belongs[i]] );
				int st = cdoc->pInfo->Status;
				int st_ex = cdoc->pInfo->Status_ex;
				int sz = cdoc->pInfo->Size;

				bi-> RecCount ++;
				bi-> RecSize += sz;
				bi-> HyperRefs += cdoc->pInfo->HyperRefs;
				bi-> GreenComments += cdoc->pInfo->GreenComments;

				if ((st & DS_DOC) || (st_ex & DS_MEDTOPIC)) {
					bi -> CommonDocCount ++;
					bi -> CommonDocSize += sz;
				}
			}

			if (b_fastfakeattrs) {
				RespRef *dummy_refs = new RespRef [cdoc->pInfo->HyperRefs];
				base->PutAttr (t, IDD_REFS, dummy_refs, cdoc->pInfo->HyperRefs * sizeof (RespRef));
				delete [] dummy_refs;

				long *dummy_paraids = new long [cdoc->ParaCount];
				base->ReplaceAttrEx (t, IDD2_PARAIDS, dummy_paraids, sizeof (long) * cdoc->ParaCount);
				delete [] dummy_paraids;

				u_int64_t *dummy_refs_blocks = new u_int64_t [cdoc->pInfo->HyperRefs];
				base->PutAttr (t, IDD_REFS_BLOCKS, dummy_refs_blocks, cdoc->pInfo->HyperRefs * sizeof (u_int64_t));
				delete [] dummy_refs_blocks;

				long *dummy_blob = new long [cdoc->pInfo->HyperRefs];
				base->PutAttr (t, IDD_BLOB, dummy_blob, cdoc->pInfo->HyperRefs * sizeof (long));
				delete [] dummy_blob;
			}

			delete cdoc;
			cdoc = 0;
			t = 0;
		}else{
			printf("NewDoc loosed...\n");
			return 1;
		}
	} else{
		printf("NewDoc loosed...\n");
		return 1;
	}
	return 0;
}

#ifdef WITH_DBL_THREAD
  #ifdef MIN_MEM_CONTEXT
	#include        "u_int64_t.CtxLongSet.SplayMap.h"
	extern void flushIt(	Base *, u_int64_tCtxLongSetSplayMap &, char *);
	extern int gctx_main(	Base *, int32_t,
							u_int64_tCtxLongSetSplayMap *,
							u_int64_tCtxLongSetSplayMap *);
  #endif
#endif

void usage_mf2(const char *m)
{
#ifdef WITH_DBL_THREAD
#if !defined(GARANT_TOOLS) || (defined(GARANT_TOOLS) && !defined(__FreeBSD_SingleThread__))
	printf("GARANT Base multi-threads compiler v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
#else
	printf("GARANT Base compiler v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
#endif

	printf("Usage is:\n%s [options] ini-file basename\n",m );
	printf("Options:\n\n\t-h help\n");

#if !defined(GARANT_TOOLS) || (defined(GARANT_TOOLS) && !defined(__FreeBSD_SingleThread__))
/*	printf("\n\t-l multithread:  GC, MF2GARDB; then GCTX\n\n" );
	printf("\n\t-m multithread:  GC, MF2GARDB+GCTX\n\n" );
	printf("\n\t-q step by step: GC, then MF2GARDB+GCTX\n\n" );*/
	printf("\n\t-o step by step: GC, then MF2GARDB, then GCTX\n\n" );
#else
	printf("\n\t-l step by step: GC, then MF2GARDB, then GCTX\n\n");
#endif

#else
    printf("GARANT Metafile translator v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
	printf("Usage is:\n%s [options] metafile basename\n",m );
	printf("Options:\n\t-d debug\n\t-h help\n");
#endif
}

#if defined (OPT_PACK)
	extern "C" int deflateExit();
#endif

#if defined(GARANT_TOOLS) && defined(__FreeBSD_SingleThread__) && defined(WITH_DBL_THREAD)
extern int local_main( LPTHREAD_CNTX pCntxt);
#endif

#if defined(PL_REPLCTR_FUNC) && defined(MAKE_HDD) && defined(MULTI_INDEX_STREAM_FILE)
	#include "../../GPersn/src/PL_Proto.h"
extern "C" {
	extern char *preCryptoKeyTag, *preCryptoStrTag;
	extern long iRetSynchro;
}
// static char RealFileFZName[]= "O:\\NSRC\\test.fz";//

// —Ú‡ÚË˜ÂÒÍËÈ Ó·‡Á Á‡¯ËÙÓ‚‡ÌÌÓ„Ó ‘«, ÔÓÎÛ˜ÂÌÌ˚È ËÁ Ù‡ÈÎ‡ RealFileFZName, c long ‚ÔÂÂ‰Ë,
// „‰Â ÓÌ˚È ‡ÁÏÂ Ù‡ÈÎ‡, ÔÓÒÚ‡Ì‡‚ÎË‚‡ÌÏ˚È ‡‚ÚÓÏ‡ÚË˜ÂÒÍË.

static unsigned char FZ_Body[]={ 0,0,0,0,
0xAF,0xF3,0x40,0xA3,0x6A,0x71,0x13,0x62,0x6,0x79,0x4C,0x6C,0x78,0xEA,0xC9,0xA3,0x80,0x42,0x52,0x57,0xAF,0xF5,0xA3,0xE6,0xEA,0xEF,
0x35,0x2E,0x52,0xA2,0x61,0xC4,0x13,0xD6,0x8B,0xB7,0x6,0xD8,0xAC,0x5,0x4F,0x1F,0x53,0x9E,0xCC,0xBB,0x47,0x5E,0xB4,0xC4,0x7,0x10,
0xCE,0x45,0x64,0x78,0x8E,0x10,0x56,0xAC,0x53,0xC5,0x7F,0x62,0xE5,0x6B,0xA1,0xEA,0x3B,0x74,0x5E,0x5C,0xB7,0x6A,0x8B,0x4,0x19,0x19,
0x2F,0xB4,0x69,0x5,0xEF,0x0,0x61,0x3E,0x83,0xB8,0x17,0x7B,0xB6,0xD3,0x5C,0x1F,0x84,0xE3,0x3D,0x9D,0xF4,0x9F,0x25,0x9B,0xFD,0x7B,
0xBD,0xDE,0x57,0x3C,0xCC,0x58,0x66,0xA,0x5C,0xCD,0x9D,0x36,0xE9,0x3A,0x33,0x5E,0xAF,0x72,0x50,0x41,0x32,0xA6,0x77,0x85,0x50,0x2D,
0x73,0x9E,0xDB,0xB8,0xF7,0xBE,0x36,0xAE,0x30,0x2B,0x3A,0xFE,0x2B,0x41,0xF6,0x45,0xEC,0xB7,0xB2,0x5E,0xD0,0x63,0x1C,0xF4,0x9A,
0x53,0x76,0x5B,0x6B,0xCE,0xDA,0x48,0xFC,0x3E,0x27,0x33,0x22,0x41,0xBB,0x7D,0x60,0x93,0x87,0x91,0x9A,0xC2,0xAF,0x60,0x10,0x5C,
0x53,0x9,0x4E,0xA4,0x52,0xFA,0xFA,0xB9,0x61,0x8,0xDB,0x74,0xE6,0x9C,0xB4,0xA1,0x18,0x38,0x6C,0x47,0xA3,0x44,0x8F,0x24,0x44,0x1F,
0xC,0xF5,0x60,0x5D,0xBB,0x3,0x4E,0xD4,0xD5,0x85,0xFC,0x51,0x75,0xE2,0x76,0x39,0x91,0x7B,0x91,0xCF,0x24,0x83,0xD3,0xA2,0x7B,0x43,
0xF4,0xE,0xE7,0xC4,0xFC,0xD4,0x9D,0xF8,0x8,0xE6,0x16,0x83,0xD4,0xEE,0xEE,0x3D,0x0,0x65,0x7E,0x26,0x46,0x62,0x9C,0xB,0xE6,0x2,
0xAB,0x71,0xEA,0xC5,0xDB,0xC,0x10,0x2,0x3C,0xA5,0x84,0xAD,0x66,0xEA,0x3C,0xB6,0x61,0x63,0x67,0xB8,0xE8,0x3F,0xB0,0x50,0x27,0x44,
0x8C,0x32,0xE5,0xA,0xB,0xA8,0x71,0xC6,0x1A,0x54,0xE7,0x98,0xA4,0xB6,0x32,0x2,0xF5,0xD0,0xB,0x47,0x98,0x7A,0x52,0x91,0x65,0x26,
0xCF,0x2B,0xBE,0xCA,0x4F,0x7B,0xF0,0x37,0xD1,0x2B,0x8E,0x5C,0xD0,0x8B,0x2A,0x42,0x58,0x8E,0x6A,0x7E,0x5E,0xC0,0xE4,0xDD,0x9A,
0x73,0xF9,0xCA,0x35,0xEE,0x51,0x8F,0xB6,0x6D,0xBD,0x52,0x8B,0xCF,0xF0,0xB6,0xBB,0xE3,0x2F,0x55,0x47,0x1F,0xE3,0x5D,0x69,0x8F,0x2B,
0xBB,0x48,0x61,0x8F,0x99,0x85,0x5B,0x13,0xCC,0x30,0x68,0x68,0x6B,0x63,0x4,0xB2,0xA7,0xFD,0xC,0xC0,0xDF,0xFC,0xE0,0x17,0xF0,0x2,
0x76,0x1B,0x50,0x59,0xFF,0x39,0x99,0x77,0x3,0x64,0x80,0x1C,0xDF,0xAD,0x4C,0xD9,0xA0,0x16,0x85,0x8B,0x4,0xD0,0x8,0x78,0x85,0xDF,
0x2A,0x84,0xBD,0x80,0xDE,0xD1,0xE7,0x5D,0x32,0x3B,0x1F,0x58,0xEE,0x80,0x9C,0xD3,0x2F,0xC4,0x48,0x79,0xE8,0x23,0x48,0x6A,0xE2,0xBC,
0x4,0x84,0x2E,0xD4,0x60,0xE,0x71,0xAA,0xCF,0x13,0x68,0x37,0xD7,0xF3,0x6E,0x8F,0xC3,0xF8,0x9B,0xFC,0xF5,0xAB,0x7D,0x2C,0xB2,0xD4,
0x78,0x74,0xE9,0x1B,0x58,0x5F,0xFB,0x24,0x3E,0x19,0x2A,0xD,0xC8,0x38,0x37,0xA2,0xB0,0x1E,0x7,0x79,0x82,0xD7,0xF8,0x9A,0xF5,0x79,
0x3F,0xE2,0x22,0x3A,0xFC,0x53,0x2C,0x6E,0x99,0x25,0x4A,0x4B,0x3E,0x13,0x4F,0xC8,0x8E,0xE4,0xDF,0x10,0x17,0x9B,0x6B,0x2C,0xF9,0x85,
0x38,0x5B,0x26,0x78,0x83,0xBE,0x4E,0x66,0x46,0x71,0x22,0x34,0xB2,0xDD,0xFC,0xFE,0x56,0x9C,0x92,0x4E,0xF5,0x67,0x57,0x61,0x8B,0xEE,
0x78,0x45,0x6,0x31,0xDF,0x89,0x6,0x81,0x77,0x3C,0xC,0x55,0x8,0x2B,0xB,0x2A,0xA8,0x8C,0x2A,0x47,0x4,0x8B,0xC3,0x65,0x7D,0x4A,0xD6,
0xAE,0xAB,0x1,0xDD,0x1B,0x12,0x1D,0x7,0x9F,0xC6,0x7F,0x4D,0xF3,0x43,0x77,0x89,0x7,0x54,0x7A,0x3C,0x2E,0x31,0xD4,0x14,0xA5,0x5C,
0xCD,0x83,0xE4,0x52,0xAE,0x33,0xF5,0xE,0x62,0x9C,0x68,0x3,0x42,0x7F,0xDF,0xDE,0x60,0xC6,0x24,0xAD,0xD9,0xAB,0xDA,0x82,0x2F,0x47,
0x38,0xFF,0xDF,0xC2,0x60,0x75,0x14,0xC2,0x2F,0x5E,0xFA,0x97,0x71,0x8F,0x2E,0x61,0x66,0xD7,0x27,0x5,0xD4,0x71,0x14,0x52,0xAA,0x7,
0x73,0xD8,0x1B,0x51,0x2,0xCE,0x28,0xBA,0xA9,0x9D,0xC9,0xF7,0x45,0x65,0x61,0xFF,0x39,0x1C,0x9,0x32,0x56,0x79,0xD1,0xFB,0x7D,0x70,
0xBB,0xDD,0x68,0x69,0xD8,0x20,0x8F,0xC5,0xC5,0x70,0x0,0x5E,0x63,0xC7,0x8D,0x9D,0x6E,0x24,0x27,0x5,0x32,0x55,0x27,0x70,0xA,0x0,0x49,
0x21,0xEE,0xA7,0x98,0xD7,0xA2,0xA1,0xA3,0x19,0x37,0xAE,0x72,0x13,0x4C,0x5,0x6E,0x2E,0xA9,0xA4,0xA7,0x61,0x66,0x97,0xC5,0x26,0xDA,
0x29,0xB8,0x4E,0xF0,0x34,0xE4,0xC4,0xDB,0x69,0xF8,0x5E,0x3D,0x46,0x29,0xC7,0xBE,0x1C,0xD0,0xF5,0x96,0x4D,0x23,0xAE,0x5C,0xAF,0x2C,
0x1,0x94,0x2E,0x81,0x38,0x79,0xF,0x74,0xF3,0x4,0x87,0x2F,0xC6,0xC3,0xB5,0x22,0xA4,0x8D,0x8E,0x3B,0xB5,0x38,0xBD,0x93,0x3B,0xAF,0x5,
0x5E,0xEF,0xF9,0x3F,0xA5,0xB,0x9B,0x80,0xBF,0x96,0xDD,0x50,0xC4,0x54,0xB4,0xC5,0x86,0xB6};
#endif

extern "C" long lDefNdtCryptoTag;
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	extern PagedFile *makePagedFile(const char *name, int omode);
#endif

#include "fbase.h"

#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	// makePagedFile in NdtClone
#else
	//#include "ncpf.h"
	PagedFile *makePagedFile(const char *name, int omode)
	{
		/*const char *fntExt= ::strrchr(name, '.');
		if(fntExt){
			if(fntExt[1] == '1' || fntExt[1] == '0'){
				return new NCPagedFile(name, omode, 1000);
			}else if(fntExt[1] == '8' || fntExt[1] == '9'){
				return new NCPagedFile(name, omode, 2000);
			}
		}*/
		return new PagedFile(name, omode);
	}
#endif

int local_mf2_main(
#ifdef WITH_DBL_THREAD
			   LPTHREAD_CNTX pCntxt
#else
			   int argc, char **argv
#endif
			   )
{
	/*
	// √ÂÌÂ‡ˆËˇ ÚÂÍÒÚÓ‚Ó„Ó Ù‡ÈÎ‡ Ò Ó·‡ÁÓÏ Á‡¯ËÙÓ‚‡ÌÌÓ„Ó ‘« //
	int wF= ace_os_open("tst_FZ1.txt", ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_BINARY|ACE_OS_O_RDWR, 0664),
		rf=	ace_os_open(RealFileFZName, ACE_OS_O_BINARY|ACE_OS_O_RDONLY, 0664);

	if(rf != -1){
		int szBf= (int)ace_os_lseek(	rf, 0l, ACE_OS_SEEK_END);	// seek to eof
		ace_os_lseek(	rf, 0l, ACE_OS_SEEK_SET);	// seek to beginning
		char ttt[8];
		unsigned char chR;
		while(szBf--){
			ace_os_read(rf, &chR, 1);
			sprintf(ttt, ",0x%1X", chR);
			ace_os_write(wF, ttt, strlen(ttt));
		}
		ace_os_close(rf);
		ace_os_close(wF);
	}
	return -1;
	*/
#ifdef WITH_DBL_THREAD
 int argc= pCntxt->l_argc, 
	 bGCTX_in_MF2GARDB= 0,
	 bStepByStep= 0;

    char **argv= pCntxt->l_argv;
  #if defined(GARANT_TOOLS) && defined(__FreeBSD_SingleThread__)
	bGCTX_in_MF2GARDB++;
	bStepByStep++;
  #endif
#endif
	int debug = 0;
	char *my_path = argv[0];
	if (argc < 2) {
		usage_mf2(my_path);
		return 1;
	}
	int option_char;
	opterr = 0;
	while ((option_char = getopt (argc, argv,
#ifdef WITH_DBL_THREAD
  #if !defined(GARANT_TOOLS) || (defined(GARANT_TOOLS) && !defined(__FreeBSD_SingleThread__))
		"fthlmoqe65ir"
  #else
		"fthle65ir"
  #endif
#else
		"ftdhe6ir"
#endif
		)) != -1){
		switch (option_char){
			case 'h':
				usage_mf2(my_path);
				return 0;
			case 'd':
				debug ++;
				break;
#ifdef WITH_DBL_THREAD
			case 'l':
				bGCTX_in_MF2GARDB++;
				bCTXTlast++;
				break;
  #if !defined(GARANT_TOOLS) || (defined(GARANT_TOOLS) && !defined(__FreeBSD_SingleThread__))
			case 'm':
				bGCTX_in_MF2GARDB++;
				break;
			case 'q':
				//bGCTX_in_MF2GARDB++;
				bStepByStep++;
				break;
			case 'o':
				bGCTX_in_MF2GARDB++;
				bStepByStep++;
				bCTXTlast++;
				break;
			case 'e':
				bEnglish = 1;
				break;
			case '5':
				b5Context = false;
				break;
			case 'i':
				bIgnoreFatal = true;
				break;
			case 't':
				bIgnoreTvsErrors = true;
				break;
			case 'r':
				b_recode = false;
				break;
			case 'f':
				b_fastfakeattrs = true;
				break;
  #endif
#endif
			case '?':
			default:
				usage_mf2(my_path);
				return 1;
		}
	}
	argc -= optind;
	argv += optind;
	if( argc != 2 ){
		usage_mf2(my_path);
		return 1;
	}
#ifdef WITH_DBL_THREAD
	if(bStepByStep){
		pCntxt->bStepByStep=
			((LPTHREAD_CNTX)pCntxt->pTxtCntxt)->bStepByStep= 1;
	}
 #ifdef MIN_MEM_CONTEXT
	CtxLongSet lsdef; bzero(&lsdef,sizeof(lsdef));
	u_int64_tCtxLongSetSplayMap ctxTextMap(lsdef);
	u_int64_tCtxLongSetSplayMap ctxNameMap(lsdef);
	((LPTHREAD_CNTX)pCntxt->pTxtCntxt)->pTxtCntxt= &ctxTextMap;
	((LPTHREAD_CNTX)pCntxt->pTxtCntxt)->pNmeCntxt= &ctxNameMap;

	pCntxt->bGCTX_in_MF2GARDB=
		((LPTHREAD_CNTX)pCntxt->pTxtCntxt)->bGCTX_in_MF2GARDB= bGCTX_in_MF2GARDB;
  #else
	((LPTHREAD_CNTX)pCntxt->pTxtCntxt)->pTxtCntxt= 0;
	((LPTHREAD_CNTX)pCntxt->pTxtCntxt)->pNmeCntxt= 0;
	pCntxt->bGCTX_in_MF2GARDB=
		((LPTHREAD_CNTX)pCntxt->pTxtCntxt)->bGCTX_in_MF2GARDB= 0;
  #endif
  #if defined(GARANT_TOOLS) && defined(__FreeBSD_SingleThread__)
	if(local_main((LPTHREAD_CNTX)pCntxt->pTxtCntxt)){
#if defined (OPT_PACK)
		deflateExit();
#endif
		return -1;
	}
  #endif
#endif

	FirstBase *b = new FirstBase(argv[1]);
	createIndexes(b);

	ThreadCompileInfo Ltcinfo;
	GCParameters Lparams;

	pCntxt->PThreadCompileInfo= &Ltcinfo;
	pCntxt->PGCParameters= &Lparams;

	DbProcessorMtoGKDB *mfr = new DbProcessorMtoGKDB( new DbProcMetaFile( 
#ifdef WITH_DBL_THREAD
	(char*)pCntxt
#else
	argv[0]
#endif
	, 0 ), b, debug );
	mfr->setAllCached();
	mfr->run();
	delete mfr;
#ifdef WITH_DBL_THREAD
  #ifdef MIN_MEM_CONTEXT
	//fprintf(stderr,"\nTake DEBUG !\n");
	//getchar();
	if( bCTXTlast && b5Context && gctx_main(b, 1835373/*222 Mbytes*/, &ctxTextMap, &ctxNameMap)) {
		delete b;
  #if defined (OPT_PACK)
		deflateExit();
  #endif
		return -1;
	}
	flushIt( b, ctxTextMap, "Context" );
	flushIt( b, ctxNameMap, "NameContext" );
  #endif
	b->SetReady(TID_GCTX);
#endif

	b->FindIndex ("Aux")->Delete (AUX_VERSION);
	long version = GKDB_BASE_VERSION;
	Stream* str = b->FindIndex ("Aux")->Open (AUX_VERSION, 1);
	if (str) {
		str->Write (&version, sizeof (version));
		b->FindIndex ("Aux")->Close (str);
	}

#if	defined(VERSION56) && defined(FLUSH56)
	int	lastP = -1;

	printf( "\nPlease wait for EDITION.RELATED and ANNO checking\n" );
	DocCollection *allTopics = b->AllTopics();
	for ( long I = 0; I < allTopics->ItemCount; I++ ) {
		long	aDocId = (*allTopics)[ I ];
		DocInfo docInfo;
		if ( b->FindDocInfo( aDocId, docInfo )) {
			if (docInfo.Status & DS_ANNO) {
				long own_topic = GetDocMonitoring(&docInfo);
				DocInfo own_docinfo;
				if (b->FindDocInfo (own_topic, own_docinfo)) {
					SetDocMonitoring (&own_docinfo, aDocId);
					b->ReplaceAttr (own_topic, IDD_INFO, &own_docinfo, sizeof (own_docinfo));
				}
				continue;
			}
			if (docInfo.Status & DS_EDITION) {
				if (!docInfo.Related) {
					DocCollection	procTopics;
					long aRelated = 0;
					bool b_nocompare = false;
					long checkTopic = docInfo.nextEdition;
					while ( checkTopic && !aRelated && procTopics.IndexOf( &checkTopic ) == -1 ) {
						procTopics.Add( checkTopic );
						DocInfo nextDocInfo;
						if ( b->FindDocInfo( checkTopic, nextDocInfo )) {
							if ( ( nextDocInfo.Status & DS_DOC ) && nextDocInfo.Related )
								aRelated = nextDocInfo.Related;
							else
								checkTopic = nextDocInfo.nextEdition;

							if ( nextDocInfo.Status & DS_DOC )
								b_nocompare = nextDocInfo.Status_ex & DS_NOCOMPARE;
						} else {
							checkTopic = 0;
						}
					}
					checkTopic = docInfo.prevEdition;
					while ( checkTopic && !aRelated && procTopics.IndexOf( &checkTopic ) == -1 ) {
						procTopics.Add( checkTopic );
						DocInfo prevDocInfo;
						if ( b->FindDocInfo( checkTopic, prevDocInfo )) {
							if ( ( prevDocInfo.Status & DS_DOC ) && prevDocInfo.Related )
								aRelated = prevDocInfo.Related;
							else
								checkTopic = prevDocInfo.prevEdition;

							if ( prevDocInfo.Status & DS_DOC )
								b_nocompare = prevDocInfo.Status_ex & DS_NOCOMPARE;
						} else {
							checkTopic = 0;
						}
					}
					if ( aRelated || b_nocompare) {
						if (aRelated) docInfo.Related = aRelated;
						if (b_nocompare) docInfo.Status_ex |= DS_NOCOMPARE;
						b->ReplaceAttr( aDocId, IDD_INFO, &docInfo, sizeof( DocInfo ));
						DocCollection procTopics;
						long checkTopic = docInfo.nextEdition;
						while ( checkTopic && allTopics->IndexOf( &checkTopic ) != -1 && procTopics.IndexOf( &checkTopic ) != -1 ) {
							procTopics.Add( checkTopic );
							DocInfo nextDocInfo;
							if ( b->FindDocInfo( checkTopic, nextDocInfo )) {
								bool b_replace = false;
								if (!nextDocInfo.Related && aRelated) {
									allTopics->Delete( &checkTopic );
									nextDocInfo.Related = aRelated;
									b_replace = true;
								}
								if (b_nocompare) {
									nextDocInfo.Status_ex |= DS_NOCOMPARE;
									b_replace = true;
								}
								if (b_replace)
									b->ReplaceAttr( aDocId, IDD_INFO, &nextDocInfo, sizeof( DocInfo ));
								checkTopic = nextDocInfo.nextEdition;
							} else {
								checkTopic = 0;
							}
						}
						checkTopic = docInfo.prevEdition;
						while ( checkTopic && allTopics->IndexOf( &checkTopic ) != -1 && procTopics.IndexOf( &checkTopic ) != -1 ) {
							procTopics.Add( checkTopic );
							DocInfo prevDocInfo;
							if ( b->FindDocInfo( checkTopic, prevDocInfo )) {
								bool b_replace = false;
								if ( !prevDocInfo.Related && aRelated) {
									allTopics->Delete( &checkTopic );
									prevDocInfo.Related = aRelated;
								}
								if (b_nocompare) {
									prevDocInfo.Status_ex |= DS_NOCOMPARE;
									b_replace = true;
								}
								if (b_replace)
									b->ReplaceAttr( aDocId, IDD_INFO, &prevDocInfo, sizeof( DocInfo ));
								checkTopic = prevDocInfo.prevEdition;
							} else {
								checkTopic = 0;
							}
						}
					}
				} else {
					DocCollection	procTopics;
					bool b_nocompare = false;
					long checkTopic = docInfo.nextEdition;
					while (checkTopic && procTopics.IndexOf (&checkTopic) == -1 && !b_nocompare) {
						procTopics.Add (checkTopic);
						DocInfo nextDocInfo;
						if ( b->FindDocInfo (checkTopic, nextDocInfo)) {
							checkTopic = nextDocInfo.nextEdition;
							if (nextDocInfo.Status & DS_DOC) {
								b_nocompare = nextDocInfo.Status_ex & DS_NOCOMPARE;
								checkTopic = 0;
							}
						} else {
							checkTopic = 0;
						}
					}
					checkTopic = docInfo.prevEdition;
					while (checkTopic && procTopics.IndexOf( &checkTopic ) == -1 && !b_nocompare) {
						procTopics.Add (checkTopic);
						DocInfo prevDocInfo;
						if ( b->FindDocInfo (checkTopic, prevDocInfo)) {
							checkTopic = prevDocInfo.prevEdition;
							if (prevDocInfo.Status & DS_DOC) {
								b_nocompare = prevDocInfo.Status_ex & DS_NOCOMPARE;
								checkTopic = 0;
							}
						} else {
							checkTopic = 0;
						}
					}
					if (b_nocompare) {
						docInfo.Status_ex |= DS_NOCOMPARE;
						b->ReplaceAttr( aDocId, IDD_INFO, &docInfo, sizeof( DocInfo ));
						DocCollection procTopics;
						long checkTopic = docInfo.nextEdition;
						while ( checkTopic && allTopics->IndexOf( &checkTopic ) != -1 && procTopics.IndexOf( &checkTopic ) != -1 ) {
							procTopics.Add( checkTopic );
							DocInfo nextDocInfo;
							if ( b->FindDocInfo( checkTopic, nextDocInfo )) {
								nextDocInfo.Status_ex |= DS_NOCOMPARE;
								b->ReplaceAttr( aDocId, IDD_INFO, &nextDocInfo, sizeof( DocInfo ));
								checkTopic = nextDocInfo.nextEdition;
							} else {
								checkTopic = 0;
							}
						}
						checkTopic = docInfo.prevEdition;
						while ( checkTopic && allTopics->IndexOf( &checkTopic ) != -1 && procTopics.IndexOf( &checkTopic ) != -1 ) {
							procTopics.Add( checkTopic );
							DocInfo prevDocInfo;
							if ( b->FindDocInfo( checkTopic, prevDocInfo )) {
								prevDocInfo.Status_ex |= DS_NOCOMPARE;
								b->ReplaceAttr( aDocId, IDD_INFO, &prevDocInfo, sizeof( DocInfo ));
								checkTopic = prevDocInfo.prevEdition;
							} else {
								checkTopic = 0;
							}
						}
					}
				}
			}
		}

		/*
		int tmpP = ( ( I + 1 ) * 100 ) / allTopics->ItemCount;
		if ( tmpP > lastP ) {
			lastP = tmpP;
			printf( "%d%%\r",  lastP );
			fflush(stdout);
		}
		*/
	}
	delete allTopics;
#endif

	/*
	printf("\nPlease wait for additional IDD_EVD packing\n");
	AttrIndex* attrs = (AttrIndex*) b->FindIndex ("Attrs");
	AttrKey key = {ID_BORDER, IDD_EVD};
	BTIterator it (attrs); it.Set (&key);
	for ( ; ; it.next ()) {
		key = *(AttrKey*) it.Key ();
		if (key.AttrTag != IDD_EVD)
			break;
		long doc_id = key.DocId, size = 0;
		char *data = (char*) b->LoadAttr (doc_id, IDD_EVD, size);
		b->ReplaceAttr (doc_id, IDD_EVD, data, size);
		gk_free (data);
		printf ("%ld\r", doc_id);
	}
	printf ("\n");
	*/

	//printf("\nPlease wait for setting additional info (gchange operation)\n");
	{
          static char rules[] = "if                                                                       \n"\
                                "    Belongs==13;                                                         \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(13);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(13);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(13);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==19;                                                         \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(19);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(19);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(19);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==72;                                                         \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(72);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(72);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(72);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==73;                                                         \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(73);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(73);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(73);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==74;                                                         \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(74);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(74);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(74);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==100;                                                        \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(100);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(100);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(100);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==102;                                                        \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(102);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(102);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(102);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==124;                                                        \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(124);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(124);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(124);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==130;                                                        \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(130);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(130);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(130);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==134;                                                        \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(134);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(134);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(134);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==140;                                                        \n"\
                                "    Class==\":003=ç†´Æ£® ® ·°Æ‡Î\";                          \n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(140);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(140);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(140);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==13;                                                         \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(13);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(13);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(13);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==19;                                                         \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(19);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(19);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(19);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==72;                                                         \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(72);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(72);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(72);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==73;                                                         \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(73);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(73);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(73);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==74;                                                         \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(74);                                               \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(74);                                             \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(74);                                                \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==100;                                                        \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(100);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(100);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(100);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==102;                                                        \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(102);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(102);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(102);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==124;                                                        \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(124);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(124);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(124);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==130;                                                        \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(130);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(130);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(130);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==134;                                                        \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(134);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(134);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(134);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n"\
                                "if                                                                       \n"\
                                "    Belongs==140;                                                        \n"\
                                "    Class==\":004=Å„Â£†´‚•‡·™®© „Á•‚, †„§®‚, ·‚†‚®·‚®Á•·™†Ô Æ‚Á•‚≠Æ·‚Ï\";\n"\
                                "then                                                                     \n"\
                                "    Belongs.add(239);                                                    \n"\
                                "    NoDoc.Belongs.add(140);                                              \n"\
                                "    NoDoc.Belongs.add(239);                                              \n"\
                                "    Related.Belongs.add(140);                                            \n"\
                                "    Related.Belongs.add(239);                                            \n"\
                                "    Blob.Belongs.add(140);                                               \n"\
                                "    Blob.Belongs.add(239);                                               \n"\
                                "end                                                                      \n";
                                
#ifdef	WINENCODE
	if (b_recode) Recoding(cd_dos,cd_win,rules);	
#endif                   
	char gc_info [256];
	sprintf (gc_info, "ŒÚ‡·ÓÚ‡Î gc ÓÚ %s : %s", __DATE__, __TIME__);
	Stream *str = b->FindIndex ("Aux")->Open (AUX_GC, 1);
	if (str) {
		str->Write (gc_info, strlen (gc_info) + 1);
		char outstr [1024];
		errors.push_back ("------------------------------------------------------------");
		for (std::deque<std::string>::const_iterator it = errors.begin (); it != errors.end (); it++) {
			strcpy (outstr, it->c_str ());
			long len = it->size ();
			if (outstr [len-1] == 10) {
				outstr [len-1] = 0;
				len--;
			}
			str->Write (outstr, len+1);
		}
		b->FindIndex ("Aux")->Close (str);
	}

#if defined(PL_REPLCTR_FUNC) && defined(MAKE_HDD) && defined(MULTI_INDEX_STREAM_FILE)
 #ifdef MIN_MEM_CONTEXT
	preCryptoKeyTag= b->keyFile->m_pCryptoTag;
	preCryptoStrTag= b->strFile->m_pCryptoTag;
	if(!pl_InitCrypto(0)){
		char	*pName= (char*)malloc(2048+256)/*strdup(b->keyFile->FileName)*/, *pRetMem, *pNxt,
				// «‡¯ËÙÓ‚‡ÌÌ˚È ÀÓ„ËÌ “” //
				p_RplctLogin[]= {0xfb, 0xa6, 0x1f, 0x91, 0}, errTxt[]= "\n !!! PERSONIFICATION ERROR !!! \n";
		strcpy(pName,b->keyFile->FileName);
		*(long*)FZ_Body= sizeof(FZ_Body) / sizeof(*FZ_Body) - 4;
		// –‡ÁÏÂ ‘‡ÈÎÓ‚ ‰Îˇ ¯ËÙÓ‚‡ÌËˇ ÌÂ ÏÓÊÂÚ ·˚Ú¸ ÏÂÌ¸¯Â ‡ÁÏÂ‡  ËÔÚÓ “Â„‡ œœƒ !
		if(b->keyFile->LastPage < 1000 && *(long*)b->keyFile->m_pCryptoTag > b->keyFile->LastPage*b->keyFile->PageSize){
			c_io_lseek(b->keyFile->GetFileHandle(), *(long*)b->keyFile->m_pCryptoTag, ACE_OS_SEEK_SET);
			c_io_write(b->keyFile->GetFileHandle(), b->strFile->SystemPageBuf, b->strFile->PageSize);
		}
		if(b->strFile->LastPage < 1000 &&  *(long*)b->strFile->m_pCryptoTag > b->strFile->LastPage*b->strFile->PageSize){
			c_io_lseek(b->strFile->GetFileHandle(), *(long*)b->strFile->m_pCryptoTag, ACE_OS_SEEK_SET);
			c_io_write(b->strFile->GetFileHandle(), b->strFile->SystemPageBuf, b->strFile->PageSize);
		}
		gc_SetLicence(b->textFile);
		memcpy(	pName+strlen(pName)+1
				,b->textFile->SystemPageBuf+sizeof(struct PagedFileHeader), 256);
		delete b;
		// –‡Ò¯ËÙÓ‚Í‡ ÀÓ„ËÌ‡ “” //
		*(long*)p_RplctLogin ^= ((long*)FZ_Body)[1];
		/////////////////////////////////////
		if(!gUnCryptoFileOrder_32(	//RealFileFZName,
									(char*)FZ_Body,
									p_RplctLogin, p_RplctLogin, &pRetMem)){
			pNxt= pRetMem;
			// Õ‡ıÓ‰ËÏ ÔÂ‚˚È ÔÓÔ‡‚¯ËÈÒˇ ÀÓ„ËÌ   , ÔÂ‰ÔÓÎ‡„‡ˇ, ˜ÚÓ ‰Îˇ –ƒ //
			while(*(long*)pNxt++ != FZ1_CIB_SIGN);
			pNxt += sizeof(long) + sizeof(long) - 1;
			pNxt += *(short*)pNxt + sizeof(short) + sizeof(long) + sizeof(short);
			pNxt[16]= 0;
			//
			*strrchr(pName, '.')= 0;
			if(!gPerson_32( pName, p_RplctLogin, p_RplctLogin, pNxt,
							//RealFileFZName,
							(char*)FZ_Body,
							&iRetSynchro)){
				if(gBreeder_32( pName, p_RplctLogin, p_RplctLogin, pNxt )){
					strcpy(strrchr(pName, 0), ".ndt");
					ace_os_unlink(pName);
					printf(errTxt);
				}else{
					strcpy(strrchr(pName, 0), ".uid");
					ace_os_unlink(pName);
				}
			}else{
				strcpy(strrchr(pName, 0), ".str");
				ace_os_unlink(pName);
				printf(errTxt);
			}
		}
		free(pName);
		pl_DoneCrypto(0);
	}
 #else
//fprintf(stderr,"\nTake DEBUG !\n");
//getchar();
	((long*)b->keyFile->m_pCryptoTag)[1]= c_io_tell(b->keyFile->GetFileHandle());
	c_io_lseek(b->keyFile->GetFileHandle(),b->keyFile->PageSize+b->keyFile->PageSize+sizeof(long),ACE_OS_SEEK_SET);
	((long*)b->keyFile->m_pCryptoTag)[2]= -950612971;
	c_io_write(b->keyFile->GetFileHandle(),((long*)b->keyFile->m_pCryptoTag)+2,sizeof(long));
	c_io_lseek(b->keyFile->GetFileHandle(),((long*)b->keyFile->m_pCryptoTag)[1],ACE_OS_SEEK_SET);
	delete b;
 #endif
#endif
	}

#ifdef WITH_DBL_THREAD
	if (gclog.flName)
		free(gclog.flName);
	gclog.lineno= 0;
	gclog.noHdr();
	gclog.flName= strdup(argv[0]);
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_WIN, "\n\n ÓÏÔËÎˇˆËˇ ‰‡ÌÌ˚ı - ÛÒÔÂ¯ÌÓ Á‡‚Â¯ÂÌ‡.\n\n¡‡Á‡ ‰‡ÌÌ˚ı '%s' - ÛÒÔÂ¯ÌÓ ÒÓÁ‰‡Ì‡.\n", argv[1]);
	free(gclog.flName);gclog.flName= 0;
#endif

#if defined (OPT_PACK)
	deflateExit();
#endif

	return 0;               
}
