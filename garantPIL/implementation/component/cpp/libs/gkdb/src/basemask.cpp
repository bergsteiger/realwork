/*
 * $Id: basemask.cpp,v 2.12 2005/06/03 05:35:53 grigorio Exp $
 *
 */

#include "basemask.h"
#include "bmsk_ver.h"

#ifndef HAS_INT_TYPES
#include "osdep.h"
#endif

#include <cstdlib>
#include <cstring>
#include <cassert>
#include <cstdio>

static const struct SProcName cProcName [] = {
	{ TM_MF2GARDB,	TMMES_MF2GARDB },
	{ TM_GCTX,	TMMES_GCTX },
	{ TM_GL,	TMMES_GL },
	{ TM_GATTRCHK,	TMMES_GATTRCHK },
	{ TM_GOPT,	TMMES_GOPT },
	{ TM_GREV_1,	TMMES_GREV_1 },
	{ TM_GREV_2,	TMMES_GREV_2 },
	{ TM_HISYNC,	TMMES_HISYNC },
	{ TM_GREGTST,	TMMES_GREGTST },
	{ TM_GFINTST,	TMMES_GFINTST }
#ifdef	VERSION56
	,{ TM_NEWCORR,	TMMES_NEWCORR }
	,{ TM_ENUMPARAS,TMMES_ENUMPARAS }
#endif
};

static const struct SDataMask cToolsMask [] = {
	{ TID_NONE,		0,									0,				0 },
	{ TID_MF2GARDB,	0,	TM_GATTRCHK|TM_MF2GARDB,	0 },
	{ TID_GCTX,		TM_MF2GARDB,						TM_GCTX,		TM_GOPT },
	{ TID_GL,		TM_MF2GARDB,						TM_GL,			TM_GOPT }, 
	{ TID_GATTRCHK, TM_MF2GARDB,						TM_GATTRCHK,	0 },
	{ TID_GOPT,		TM_MF2GARDB,						TM_GOPT,		0 },
	{ TID_GREV_1,	TM_MF2GARDB|TM_GATTRCHK,			TM_GREV_1,		0 }, 
	{ TID_GREV_2,	TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1,	TM_GREV_2,		0 },
	{ TID_GSPLIT,	TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX, TM_HISYNC, TM_GL },
	{ TID_HISYNC,	TM_MF2GARDB,						TM_HISYNC,		0 },
	{ TID_GM,		TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX|TM_HISYNC, 0, TM_GL },
	{ TID_GU,		TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX, 0, TM_GL|TM_HISYNC|TM_GOPT },
	{ TID_GDLT,		TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX|TM_GL, 0, 0 },
	{ TID_GKDBCMP,	TM_MF2GARDB,						0,				0 },
	{ TID_GKDUMPI,	TM_MF2GARDB,						0,				0 },
	{ TID_BASEINFO,	TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX|TM_GL, 0, 0 },	
	{ TID_GWSHELL_PREV, TM_MF2GARDB|TM_GL, 0, 0 },
	{ TID_GWSHELL_REL, TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX|TM_GL, 0, 0 },
	{ TID_GDSHELL_PREV,	TM_MF2GARDB|TM_GL, 0, 0 },
#ifdef	VERSION56
	{ TID_GDSHELL_REL, TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX|TM_GL, 0, 0 },
#else
	{ TID_GDSHELL_REL, TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX|TM_GL, 0, 0 },
#endif
	{ TID_BREEDER, TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX|TM_GL, 0, 0 },
	{ TID_GREGTST,	TM_MF2GARDB|TM_GATTRCHK, TM_GREGTST, 0 },
	{ TID_GFINTST, TM_MF2GARDB, TM_GFINTST, 0 },
	{ TID_GFINDLT, TM_MF2GARDB|TM_GATTRCHK|TM_GREV_1|TM_GREV_2|TM_GCTX|TM_GL|TM_GFINTST, 0, 0 },
	{ TID_GCHANGE, TM_MF2GARDB|TM_GCTX, 0, TM_GREV_1|TM_GREV_2|TM_GL }
#ifdef	VERSION56
	,{ TID_NEWCORR,		TM_MF2GARDB,						TM_NEWCORR,			0 }
	,{ TID_ENUMPARAS,	TM_MF2GARDB,						TM_ENUMPARAS,			0 }
#endif
};

int16_t GetUtilRec ( int16_t sToolId )
{
	for ( u_int16_t s=0; s < sizeof ( cToolsMask ); s++ ) 
		if ( cToolsMask[s].sToolId == sToolId ) return s;
	return -1;
}

struct SDataMask *GetUtilMasks(int16_t sToolId)
{
	int16_t index;

	index = GetUtilRec(sToolId);
	return (struct SDataMask*)&(cToolsMask[index]);
}

int16_t GetProcRec ( int32_t sProcId )
{
	for ( u_int16_t s=0; s < sizeof ( cProcName ); s++ ) 
		if ( cProcName[s].lProcMask == sProcId ) return s;
	return -1;
}


char * GetProcessDescription ( int32_t lMask, int16_t& sProcCount, int16_t& sSize )
{
	sSize = 0;
	sProcCount = 0;
	int32_t lTmpMask = 1;

	int16_t s = 0;
	for ( s = 0; s < 32; s++ ) {
		if ( lMask & lTmpMask ) {
			int16_t sProcRec = GetProcRec(lTmpMask);
			if ( sProcRec == -1 ) return 0;
			sSize += strlen ( cProcName[sProcRec].pProcName ) + 1;
			sProcCount ++;
		}
		lTmpMask <<= 1;
	}
	sSize ++;

	char* pBuf = (char*) malloc ( sSize );
	assert ( pBuf );
	
	char* pTmpBuf = pBuf;
	lTmpMask = 1;

	for ( s = 0; s < 32; s++ ) {
		if ( lMask & lTmpMask ) {
			int16_t sProcRec =  GetProcRec(lTmpMask);
			if ( sProcRec == -1 ) {
				free ( pBuf );
				return 0;
			}
			strcpy ( pTmpBuf, cProcName[sProcRec].pProcName );
			pTmpBuf += strlen ( pTmpBuf ) + 1;
		}
		lTmpMask <<= 1;
	}
	*pTmpBuf = 0;

	return pBuf;
}

GDataStatusMask::GDataStatusMask ( int16_t sUtilId )
{	
	m_sUtilRec = GetUtilRec ( sUtilId );
	assert ( m_sUtilRec != -1 );
}

int32_t	GDataStatusMask::CheckMask ( int32_t lMask )
{
	return ( lMask^cToolsMask[m_sUtilRec].lCheckMask ) & cToolsMask[m_sUtilRec].lCheckMask;
}

int32_t GDataStatusMask::AddMask ( int32_t lMask )
{	
	return  lMask | cToolsMask[m_sUtilRec].lAddMask ;
}

int32_t GDataStatusMask::ClearMask ( int32_t lMask )
{
	return lMask & ~cToolsMask[m_sUtilRec].lClearMask;
}

int32_t GDataStatusMask::SetMask ( int32_t lMask )
{
	return ClearMask ( AddMask ( lMask ) );
}
