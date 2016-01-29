#include "shared/Core/fix/mpcxc.h"
#include <time.h>
#include <string.h>

#include "gdbapi.h"
#include "base.h"
#include "stdindex.h"

#define HK_EXTRA_ID			HSTR_ID+17
#define HK_EXTRA_REF		HK_EXTRA_ID+4
#define HK_EXTRA_2ID		(HSTR_ID*2)+17
#define HK_EXTRA_2REF		HK_EXTRA_2ID+8
#define HSTR_ID				sizeof(stref_st)
#define HSTR_2ID			sizeof(stref_st)*2
#define HSTR_REF			HSTR_ID+4

u_int32_t debug_flags=0;
u_int32_t debug_level=0;

cmpfunc_ft known_comparisons[] = {
	(cmpfunc_ft)strcmp, // DT_STRING
	longcmp,            // DT_INT32
	shrtcmp,            // DT_INT16
	datecmp,            // DT_DATE 
	attrcmp,            // DT_ATTRKEY
	attrcmp_new,            // DT_ATTRKEY
	refcmp,             // DT_REF
	ctxcmp,             // DT_STRING8 : compares 1st 8 characters in the strings
#ifdef MULTI_INDEX_STREAM_FILE
	ctxcmp64,           // DT_UINT64 : compares 1st 8 characters in the strings
#endif
	0,               // DT_HIER
	hindcmp,            // DT_DIVKEY
	hkwcmp,            // DT_KWDKEY
	hindcmp,            // DT_CLSKEY
	0
};

index_info_st known_indexes_table[] = {
	// Name            KeyLen                        ImmSize DataLen Flags   Key cmp              Data cmp Key type    Data type Round StrN Size (%)
	{ "Attrs",         0x0006+HSTR_ID,               0x0004, 0xFFFF, 0x0020, attrcmp,             0,    DT_ATTRKEY, 0,           1,   1,   42 },
	{ "Territory",     ADOPTED_KEY_SIZE+HK_EXTRA_2ID,0x0004, 0x0004, 0x0070, hindcmp,             longcmp, DT_STRING,  DT_INT32,  12,   2,   1  },
	{ "Adopted",       ADOPTED_KEY_SIZE+HK_EXTRA_2ID,0x0004, 0x0004, 0x0070, hindcmp,             longcmp, DT_STRING,  DT_INT32,  12,   2,   1  },
	{ "PublishedIn",   PUBLISHEDIN_KEY_SIZE+HK_EXTRA_ID, 0x0004, 0x0004, 0x0070, hindcmp,         longcmp, DT_STRING,  DT_INT32,  12,   1,   3  },
	{ "Type",          TYPE_KEY_SIZE+HK_EXTRA_REF,   0x0008, 0x0004, 0x0070, hindcmp,             refcmp,  DT_STRING,  DT_REF,    24,   1,   1  },
	{ "Kind",          KIND_KEY_SIZE+HK_EXTRA_REF,   0x0008, 0x0004, 0x0070, hindcmp,             refcmp,  DT_STRING,  DT_REF,    24,   1,   1  },
	{ "Date",          0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
	{ "Number",        CODE_KEY_SIZE+HSTR_ID,        0x0004, 0x0004, 0x0030, (cmpfunc_ft)strcmp,  longcmp, DT_STRING,  DT_INT32,  12,   1,   1  },
	{ "Status",        0x0002+HSTR_ID,               0x0004, 0x0004, 0x0030, shrtcmp,             longcmp, DT_INT16,   DT_INT32,  12,   1,   1  },
	{ "KeyWord",       SEC_KW_SIZE+HK_EXTRA_REF,     0x0008, 0x0008, 0x0070, hkwcmp,             refcmp,  DT_KWDKEY,  DT_REF,    24,   1,   4  },
	{ "RCode",         CODE_KEY_SIZE+HSTR_ID,        0x0004, 0x0004, 0x0030, (cmpfunc_ft)strcmp,  longcmp, DT_STRING,  DT_INT32,  12,   1,   1  },
	{ "Respondent",    0x0004+HSTR_REF,              0x0008, 0x0008, 0x0030, longcmp,             refcmp,  DT_INT32,   DT_REF,    12,   1,   1  },
	{ "Correspondent", 0x0004+HSTR_REF,              0x0008, 0x0008, 0x0030, longcmp,             refcmp,  DT_INT32,   DT_REF,    12,   1,   2  },
#ifdef VERSION56
	{ "Control",       0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },

#ifdef	VERSION61
#ifdef	VERSION63
	{ "NewCorr",	   20+HSTR_ID,					 20,     20,     0x0030, longcmp,				  0,    DT_INT32,   DT_REF,    20,   1,   2  },
#else
	{ "NewCorr",	   16+HSTR_ID,					 16,     16,     0x0030, 0,				  0,    DT_INT32,   DT_REF,    16,   1,   2  },
#endif
#else
	{ "NewCorr",	   12+HSTR_ID,					 0x000c, 0x000c, 0x0030, 0,				  0,    DT_INT32,   DT_REF,    12,   1,   2  },
#endif

	{ "Class6",	   CLASS_KEY_SIZE+HK_EXTRA_2REF, 0x0008, 0x0008, 0x0070, hindcmp,             refcmp,  DT_CLSKEY,  DT_REF,    24,   2,   2  },
#endif

#ifdef VERSION61
	{ "Attribs",       0x0006+HSTR_ID,               0x0004, 0xFFFF, 0x0020, attrcmp,             0,    DT_ATTRKEY, 0,          1,   1,   42 },
#endif
#ifdef	VERSION62
	{ "AnnoDate",		0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
	{ "AnnoUser",		CLASS_KEY_SIZE+HK_EXTRA_ID,  0x0004, 0x0004, 0x0070, hindcmp,             longcmp,  DT_STRING,  DT_INT32,    12,   1,   3  },
	{ "AnnoOrganization",CLASS_KEY_SIZE+HK_EXTRA_ID, 0x0004, 0x0004, 0x0070, hindcmp,             longcmp,  DT_STRING,  DT_INT32,    12,   1,   3  },
	{ "AnnoTax",    	CLASS_KEY_SIZE+HK_EXTRA_ID,  0x0004, 0x0004, 0x0070, hindcmp,             longcmp,  DT_STRING,  DT_INT32,    12,   1,   3  },
	{ "AnnoInterest",	CLASS_KEY_SIZE+HK_EXTRA_ID,  0x0004, 0x0004, 0x0070, hindcmp,             longcmp,  DT_STRING,  DT_INT32,    12,   1,   3  },
	{ "AnnoKind",		CLASS_KEY_SIZE+HK_EXTRA_ID,  0x0004, 0x0004, 0x0070, hindcmp,             longcmp,  DT_STRING,  DT_INT32,    12,   1,   3  },
	{ "ServiceInfo",	CLASS_KEY_SIZE+HK_EXTRA_REF,  0x0008, 0x0004, 0x0070, hindcmp,             refcmp,  DT_STRING,  DT_REF,    24,   1,   1  },
#endif
	{ "RDate",         0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
	{ "Context",       CTX_WORD_SIZE+HSTR_ID,        0x0004, 0x0004, 0x0030, ctxcmp,              longcmp, DT_STRING8, DT_INT32,  12,   1,   20 },
	/*{ "NameContext",   CTX_WORD_SIZE+HSTR_ID,        0x0004, 0x0004, 0x0030, ctxcmp,              longcmp, DT_STRING8, DT_INT32,  12,   1,   4  },*/
	{ "VAnonced",      0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   0  },
	{ "VIncluded",     0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
	{ "VChanged",      0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
	{ "VAbolished",    0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
	{ "VLControl",     0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   0  },
	{ "DocKind",       CLASS_KEY_SIZE+HK_EXTRA_2REF, 0x0008, 0x0008, 0x0070, hindcmp,             refcmp,  DT_CLSKEY,  DT_REF,    24,   2,   1  },
	{ "Class",         CLASS_KEY_SIZE+HK_EXTRA_2REF, 0x0008, 0x0008, 0x0070, hindcmp,             refcmp,  DT_CLSKEY,  DT_REF,    24,   2,   2  },
	{ "Segment",       0x0002+HSTR_ID,               0x0004, 0x0004, 0x0030, shrtcmp,             longcmp, DT_INT16,   DT_INT32,  12,   1,   1  },
#ifdef	VERSION63
	{ "SubName",       0x0008+HSTR_ID,               0x0004, 0x0000, 0x0030, ref2cmp,  (cmpfunc_ft)strcmp,  DT_REF,     DT_STRING,  1,   1,   1  },
#else
	{ "SubName",       0x0008+HSTR_ID,               0x0004, 0x0000, 0x0030, refcmp,   (cmpfunc_ft)strcmp,  DT_REF,     DT_STRING,  1,   1,   1  },
#endif
	{ "SortDate",      0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
	{ "Category",      CATEGORY_KEY_SIZE+HSTR_ID,    0x0004, 0x0004, 0x0030, (cmpfunc_ft)strcmp,  longcmp, DT_STRING,  DT_INT32,  12,   1,   1  },
	{ "Blob",          0x0008+HSTR_2ID,              0x0004, 0x0000, 0x0030, refcmp,  (cmpfunc_ft)strcmp,  DT_REF,     DT_STRING, 12,   2,   1  },
	{ "Aux",           0x0005+HSTR_ID,               0x0004, 0x0004, 0x0020, (cmpfunc_ft)strcmp,  0,    DT_STRING,  0,          1,   1,   1  }
#ifdef MULTI_INDEX_STREAM_FILE
	,{ "Attrs.str",         0x0006+HSTR_ID,               0x0004, 0xFFFF, 0x0020, attrcmp,             0,    DT_ATTRKEY, 0,          1,   1,   42 },
	{ "SubName.str",       0x0008+HSTR_ID,               0x0004, 0x0000, 0x0030, ref2cmp,  (cmpfunc_ft)strcmp,  DT_REF,     DT_STRING,  1,   1,   1  },
	{ "KindCorr",	       0x0008+HSTR_ID,               0x0004, 0x0008, 0x0030, refcmp,              refcmp,  DT_REF,     DT_INT32,  DT_INT32,   1,   2  },
	{ "CalIn.str",         0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
	{ "CalAb.str",         0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
	{ "CalCh.str",         0x0004+HSTR_ID,               0x0004, 0x0004, 0x0030, datecmp,             longcmp, DT_DATE,    DT_INT32,  12,   1,   1  },
//	{ "CorrNew.str",       0x0008+HSTR_ID,               0x0004, 0x0008, 0x0030, refcmp,              refcmp,  DT_REF,     DT_INT32,  DT_INT32,   1,   2  },

	{ "Tag.str",         TAG_KEY_SIZE+HSTR_ID+8/* HK_EXTRA_2RefwWeight*/,	   0x000C, 0x000C, 0x0030, (cmpfunc_ft)strcmp,  refcmp,  DT_STRING,   DT_REF,  12,   1,   1  },

  #ifndef MIN_MEM_CONTEXT
	{ "Context.str",       CTX_WORD_SIZE+HSTR_ID,        0x0004, 0x0004, 0x0030, ctxcmp, longcmp, DT_STRING8, DT_INT32,  12,   1,   20 },
  #else
	{ "Context.str",       (CTX_WORD_SIZE*4)
											+
    #ifdef NOT_SCND_STR_IN_NORM
												HSTR_ID
    #else
												HSTR_2ID + HSTR_ID
    #endif
														,        0x0004, 0x0004, 0x0030, ctxcmp64, longcmp, DT_UINT64, DT_INT32,  12,
    #ifdef NOT_SCND_STR_IN_NORM
																																	1
    #else
																																	3
    #endif
																																	,   20 },
  #endif
	{ "NContxt.str",       (CTX_WORD_SIZE*4)
											+
#ifdef NOT_SCND_STR_IN_NORM
												HSTR_ID
#else
												HSTR_2ID
#endif
														,        0x0004, 0x0004, 0x0030, ctxcmp64, longcmp, DT_UINT64, DT_INT32,  12,
#ifdef NOT_SCND_STR_IN_NORM
																																	1
#else
																																	2
#endif
																																	,   20 },
	{ "SWords.str",   0x0004+HSTR_ID,               0x0004, 0x0004, 0x0020, shrtcmp,             longcmp, DT_INT16,   DT_INT32,   1,   1,   0  },
	{ "NWCntxt.str",       (CTX_WORD_SIZE*4)
											+
#ifdef NOT_SCND_STR_IN_NORM
												HSTR_ID
#else
												HSTR_2ID + HSTR_ID
#endif
														,        0x0004, 0x0004, 0x0030, ctxcmp64, longcmp, DT_UINT64, DT_INT32,  12,
#ifdef NOT_SCND_STR_IN_NORM
																																	1
#else
																																	3
#endif
																																	,   20 },
#ifdef STORE_FORM_N
	{ "NBCntxt.str",       (CTX_WORD_SIZE*4)
											+
#ifdef NOT_SCND_STR_IN_NORM
												HSTR_ID
#else
												HSTR_2ID
#endif
														,        0x0004, 0x0004, 0x0030, ctxcmp64, longcmp, DT_UINT64, DT_INT32,  12,
#ifdef NOT_SCND_STR_IN_NORM
																																	1
#else
																																	2
#endif
																																	,   20 },
	{ "NFContxt.str",       (CTX_WORD_SIZE*4)+HSTR_ID,	0x0004, 0x0004, 0x0030, ctxcmp64,longcmp, DT_UINT64,DT_INT32,  12,   1,   20 },
	{ "NPContxt.str",       4+HSTR_ID,				0x0004, 0x0004, 0x0030, longcmp, longcmp, DT_INT32, DT_INT32,  12,   1,   20 },
#endif
	{ "NCntxts.str",       CTX_WORD_SIZE+HSTR_ID,        0x0004, 0x0004, 0x0030, ctxcmp64, longcmp, DT_UINT64, DT_INT32,  12,   1,   20 },
	{ "NTCntxt",		(CTX_WORD_SIZE*4)+HSTR_ID,        0x0004, 0x0004, 0x0030, ctxcmp64, longcmp, DT_UINT64, DT_INT32,  12,   1,   20 },
	{ "Aux.str",           0x0005+HSTR_ID,               0x0004, 0x0004, 0x0020, (cmpfunc_ft)strcmp,  0,    DT_STRING,  0,          1,   1,   1  }
#endif
	// Name                 KeyLen								    ImmSize DataLen Flags   Key cmp  Data cmp Key type   Data type Round StrN Size (%)
	, { "PhFirm",           INPHARM_FIRM_SIZE+HK_EXTRA_REF,		    0x0008, 0x0004, 0x0070, hindcmp, refcmp,  DT_STRING, DT_REF,   24,   1,   1 }
	, { "PhCountry",        INPHARM_COUNTRY_SIZE+HK_EXTRA_REF,	    0x0008, 0x0004, 0x0070, hindcmp, refcmp,  DT_STRING, DT_REF,   24,   1,   1 }
	, { "RegDate",          0x0004+HSTR_REF,					    0x0008, 0x0004, 0x0030, datecmp, refcmp,  DT_DATE,   DT_REF,   24,   1,   1 }
	, { "AnnulDate",        0x0004+HSTR_REF,					    0x0008, 0x0004, 0x0030, datecmp, refcmp,  DT_DATE,   DT_REF,   24,   1,   1 }
	, { "TradeName",        INPHARM_TRADENAME_SIZE+HSTR_ID,		    0x0004, 0x0004, 0x0030, (cmpfunc_ft)strcmp,  longcmp, DT_STRING,  DT_INT32,  12,   1,   1 }
	, { "IntName",          INPHARM_INTNAME_SIZE+HSTR_ID,		    0x0004, 0x0004, 0x0030, (cmpfunc_ft)strcmp,  longcmp, DT_STRING,  DT_INT32,  12,   1,   1 }
	, { "PhGroup",          INPHARM_PHARMGROUP_SIZE+HK_EXTRA_ID,    0x0004, 0x0004, 0x0070, hindcmp,             longcmp, DT_STRING,  DT_INT32,  12,   1,   1 }
	, { "PhEffect",         INPHARM_PHARMEFFECT_SIZE+HK_EXTRA_ID,   0x0004, 0x0004, 0x0070, hindcmp,             longcmp, DT_STRING,  DT_INT32,  12,   1,   1 }
	, { "Atc",              INPHARM_ATC_SIZE+HK_EXTRA_ID,		    0x0004, 0x0004, 0x0070, hindcmp,             longcmp, DT_STRING,  DT_INT32, 12,   1,   1 }
	, { "RegStatus",        INPHARM_REGSTATUS_SIZE+HK_EXTRA_REF,	0x0008, 0x0004, 0x0070, hindcmp,             refcmp,  DT_STRING,  DT_REF,    24,   1,   1 }
	, { "LekForm",          INPHARM_LEKFORM_SIZE+HK_EXTRA_REF,	 0x0008, 0x0004, 0x0070, hindcmp,             refcmp,  DT_STRING,  DT_REF,    24,   1,   1 }
	, { "Mkb",              INPHARM_MKB_SIZE+HK_EXTRA_REF,           0x0008, 0x0004, 0x0070, hindcmp,             refcmp, DT_STRING,  DT_REF,  24,   1,   1 }
	, { "Chapter",          INPHARM_CHAPTER_SIZE+HK_EXTRA_REF,       0x0008, 0x0004, 0x0070, hindcmp,             refcmp, DT_STRING,  DT_REF,  24,   1,   1 }
	, { "Status_ex",       	0x0002+HSTR_REF,               		 0x0008, 0x0004, 0x0070, shrtcmp,             refcmp, DT_INT16,   DT_REF,  24,   1,   1 }
	, { "Active",           0x0004+HSTR_REF,			0x0008, 0x0004, 0x0030, datecmp, refcmp,  DT_DATE,   DT_REF,   24,   1,   1 }
	};

int known_index(const char *name)
{
	int i, max= sizeof(known_indexes_table)/sizeof(*known_indexes_table);

	for(i=0; i < max; i++)
		if(!strcmp(known_indexes_table[i].name, name)) return i;
	return -1;
}

int get_index_info(const char *name, index_st *pind)
{
	index_info_st *pinfo;
	int num, max= sizeof(known_indexes_table)/sizeof(*known_indexes_table);

	num = known_index(name);
	if(num<0 || num>=max) return 0;
	pinfo = known_indexes_table+num;
	if(!pind->hdr.keylen)
		pind->hdr.keylen = pinfo->keylen;
	if(pind->mode) {
		pind->hdr.strinfo.immds = pinfo->immds;
		pind->hdr.nstreams = pinfo->nstreams;
		pind->hdr.strinfo.rndv = pinfo->rndv;
	}
	pind->reclen = pind->hdr.strinfo.immds;
	pind->keycmp = pinfo->keycmp;
	pind->reccmp = pinfo->reccmp;
	pind->flags = pinfo->flags;
	return 1;
}

int get_index_weight(const char *name)
{
	int n;
	index_info_st *pinfo;

	n = known_index(name);
	if(n != -1) {
		pinfo = known_indexes_table+n;
		return pinfo->weight;
	}
	return 0;
}

cmpfunc_ft get_cmpfunc(int dtype)
{
	if(dtype <= 0 || dtype > 11) return (cmpfunc_ft)0;
	return known_comparisons[dtype-1];
}

char *get_index_name(int num)
{
	int max= sizeof(known_indexes_table)/sizeof(*known_indexes_table);
	if(num < 0 || num >= max) return 0;
	return known_indexes_table[num].name;
}

u_int16_t get_immds(int ind)
{
	int max= sizeof(known_indexes_table)/sizeof(*known_indexes_table);
	if(ind < 0 || ind >= max) return 0;
	return known_indexes_table[ind].immds;
}

void makestamp(stamp_st *pts)
{
	time_t ts;
	struct tm *ptm;

	tzset();
	ts = time(0);
	ptm = localtime(&ts);
	pts->date.year = (u_int16_t)(ptm->tm_year + 1900);
	pts->date.month = (unsigned char)(ptm->tm_mon+1);
	pts->date.day = (unsigned char)(ptm->tm_mday);
	pts->time.hour = (unsigned char)(ptm->tm_hour);
	pts->time.min = (unsigned char)(ptm->tm_min);
	pts->time.sec = (unsigned char)(ptm->tm_sec);

//	#ifdef GARANT_TOOLS
		pts->time.tzone = (signed char)(mpcxc_timezone()/3600);
//	#else
//		pts->time.tzone = 0;
//	#endif
}

void * bsearch_nxt(long key, long **ppBase, int *pNum)
{
        long	*lo = *ppBase,
				*hi = *ppBase + (*pNum - 1),
				*mid;

        unsigned int half;
        int num= *pNum;

		if((**ppBase) > key)
			return 0;

        while (lo <= hi){
            if (half = num / 2){
                mid = lo + (num & 1 ? half : (half - 1));
                if (key == *mid){
					*pNum= ((*ppBase) + (*pNum)) - (mid+1);
					*ppBase = mid+1;
					return mid;
                }else if (key < *mid){
					hi = mid - 1;
					if(key > *hi)
						break;
					num = num & 1 ? half : half-1;
                }else{
                    lo = mid + 1;
					if(key < *lo){
						mid= lo;
						break;
					}
                    num = half;
                }
            }
            else if (num){
				if(key == *lo){
					*pNum= ((*ppBase) + (*pNum)) - mid;
					*ppBase= mid;
					return lo;
				}
				break;
            }else
				break;
		}
		*pNum= ((*ppBase) + (*pNum)) - mid;
		*ppBase = mid;
        return 0;
}

