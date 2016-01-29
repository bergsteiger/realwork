#ifndef _INC_BASEMASK_HEADER
#define _INC_BASEMASK_HEADER
/*
 * $Id: basemask.h,v 2.26 2006/08/10 17:22:51 cyberz Exp $
 *
 */

//#ifndef HAS_INT_TYPES
//#include "stdintd.h"
//#endif

#include "osdep.h"

////////////////////////////////////////////////////////
//  TOOLS ID DEFINITIONS & VERSION CONTROL PROTOTYPES //
////////////////////////////////////////////////////////

#if defined(unix)
	#define DIRECTORIES_TERM '/'
	#define IS_FULL_PATH(sx) ((sx[0] == '/') ? 1 : 0)
#elif defined(_MSC_VER)
	#define DIRECTORIES_TERM '\\'
	#define IS_FULL_PATH(sx) (( sx[0] == '\\' || sx[1] == ':') ? 1 : 0)
#else
	#define DIRECTORIES_TERM '/'
	#define IS_FULL_PATH(sx) ((sx[0] == '/') ? 1 : 0)
#endif

#define TID_MAX_VALUE		35l
#define TID_NAMES_LIST_ENGL	{ "UnNamed","MF2GARDB","GCTX","GL","GATTRCHK","Optimizer","GSETREV","GREV", "Spliter","Synchronizator","Merger","GU","GDLT","GKDBCMP","GKDUMPI", "Reserved", "BASEINFO","GWSHELL_PREV","GWSHELL_REL","GDSHELL_PREV", "GDSHELL_REL","BREEDER","GREGTST","GFINTST","GFINDLT","VersionMaker", "Packer", "DOC2HTML", "GC", "GC_CHECK", "GCUSTOM", "GREADY", "GKDUMPKW", "GSTATUS", "GSETNAME", "GKGETDOC" }

#define TID_NONE		0
#define TID_MF2GARDB	1
#define TID_GCTX		2
#define TID_GL			3
#define TID_GATTRCHK	4
#define TID_GOPT		5
#define TID_GREV_1		6
#define TID_GREV_2		7

#define TID_GSPLIT		8
#define TID_HISYNC		9
#define TID_GM			10
#define TID_GU			11

#define TID_GDLT		12
#define TID_GKDBCMP		13
#define TID_GKDUMPI		14

#define TID_BASEINFO	16

#define TID_GWSHELL_PREV	17
#define TID_GWSHELL_REL		18
#define TID_GDSHELL_PREV	19
#define TID_GDSHELL_REL		20
#define TID_BREEDER		21
#define TID_GREGTST		22
#define TID_GFINTST		23
#define TID_GFINDLT		24

#define TID_VMAKER		25
#define TID_GPACK		26
#define	TID_DOC2HTML	27

#define	TID_GC			28
#define	TID_GC_CHECK	29
#define	TID_GCUSTOM		30
#define	TID_GREADY		31
#define	TID_GKDUMPKW		32
#define	TID_GSTATUS		33
#define	TID_GSETNAME	34
#define	TID_GKGETDOC		35
#define	TID_GCHANGE		36
#define	TID_NEWCORR		37
#define	TID_ENUMPARAS		38

//  PROCESS FLAGS DEFINITIONS
#define TM_MF2GARDB		1L
#define TM_GCTX			2L
#define TM_GL			4L
#define TM_GATTRCHK		8L
#define TM_GOPT			16L
#define TM_GREV_1		32L
#define TM_GREV_2		64L
#define TM_HISYNC		128L
#define TM_GREGTST		256L
#define TM_GFINTST		512L
#define	TM_NEWCORR		1024L
#define	TM_ENUMPARAS		2048L

#if defined(_MSC_VER) 
	#define	TMMES_MF2GARDB	"Ñîçäàíèå áàçû"
	#define TMMES_GCTX	"Êîíòåêñòíîå èíäåêñèðîâàíèå"
	#define TMMES_GL	"Ñîçäàíèå îñíîâíîãî ìåíþ"
	#define TMMES_GATTRCHK	"Êîððåêöèÿ àòðèáóòîâ"
	#define TMMES_GOPT	"Îïòèìèçèðîâàíèå"
	#define TMMES_GREV_1	"Ïîëíàÿ óñòàíîâêà ðåâèçèè"
	#define TMMES_GREV_2	"Îòíîñèòåëüíàÿ óñòàíîâêà ðåâèçèè"
	#define TMMES_HISYNC	"Ñèíõðîíèçàòîð"
	#define TMMES_GREGTST	"Ïðîâåðêà ñîâìåñòèìîñòè ðåãèîíàëüíîé áàçû" 
	#define TMMES_GFINTST	"Ïðîâåðêà áàç äëÿ ôèíàëüíîé äåëüòû" 
	#define	TMMES_NEWCORR	"Íîâûå êîððåñïîíäåíòû"
	#define	TMMES_ENUMPARAS	"Ïåðåíóìåðàöèÿ ïàðàãðàôîâ"
#elif defined(unix) && !defined(__GO32__) && !defined(__CYGWIN32__)
	#define	TMMES_MF2GARDB	"Base Creator"
	#define TMMES_GCTX		"Context Indexator"
	#define TMMES_GL		"Main Menu Maker"
	#define TMMES_GATTRCHK	"Attribute Fixer"
	#define TMMES_GOPT		"Optimizator"
	#define TMMES_GREV_1	"Full Reviser"
	#define TMMES_GREV_2	"Relative Revisor"
	#define TMMES_HISYNC	"Hi Syncer" 
	#define TMMES_GREGTST	"Compatability test for regional base" 
	#define TMMES_GFINTST	"Bases compatabilty test for final delta" 
	#define TMMES_NEWCORR	"New Correspondets" 
	#define	TMMES_ENUMPARAS	"Enum paras"
#else
	#define	TMMES_MF2GARDB	"‘®§¤ ­¨¥ ¡ §ë"
	#define TMMES_GCTX		"Š®­â¥ªáâ­®¥ ¨­¤¥ªá¨à®¢ ­¨¥"
	#define TMMES_GL		"‘®§¤ ­¨¥ ®á­®¢­®£® ¬¥­î"
	#define TMMES_GATTRCHK	"Š®àà¥ªæ¨ï  âà¨¡ãâ®¢"
	#define TMMES_GOPT		"Ž¯â¨¬¨§¨à®¢ ­¨¥"
	#define TMMES_GREV_1	"®«­ ï ãáâ ­®¢ª  à¥¢¨§¨¨"
	#define TMMES_GREV_2	"Žâ­®á¨â¥«ì­ ï ãáâ ­®¢ª  à¥¢¨§¨¨"
	#define TMMES_HISYNC	"‘¨­åà®­¨§ â®à"
	#define TMMES_GREGTST	"à®¢¥àª  á®¢¬¥áâ¨¬®áâ¨ à¥£¨®­ «ì­®© ¡ §ë" 
	#define TMMES_GFINTST	"à®¢¥àª  ¡ § ¤«ï ä¨­ «ì­®© ¤¥«ìâë" 
	#define	TMMES_NEWCORR	"®¢ë¥ ª®àà¥á¯®­¤¥­âë"
	#define	TMMES_ENUMPARAS	"¥à¥­ã¬¥à æ¨ï ¯ à £à ä®¢"
#endif

#define MAX_TOOL_NAME 64

// process mask(id) -> process name 
struct SProcName {
	int32_t		lProcMask;
	char		pProcName [MAX_TOOL_NAME];
};

// tools id -> check/add/substruct process masks
struct SDataMask {
	int16_t		sToolId;	
	int32_t		lCheckMask;
	int32_t		lAddMask;
	int32_t		lClearMask;
};

#ifdef  __cplusplus
int16_t GetProcRec ( int16_t sProcId );
struct SDataMask *GetUtilMasks(int16_t sToolId);
int16_t GetUtilRec ( int16_t sToolId );
char * GetProcessDescription ( int32_t nMask, int16_t& sProcCount, int16_t& sSize );

class GDataStatusMask 
{
public :
	GDataStatusMask () { m_sUtilRec = GetUtilRec ( TID_NONE ); };
	GDataStatusMask ( int16_t sUtilId );
	~GDataStatusMask () {};

	int32_t 	CheckMask ( int32_t lMask );
	int32_t		AddMask ( int32_t lMask );
	int32_t		ClearMask ( int32_t lMask );
	int32_t		SetMask ( int32_t lMask );

protected :
	int16_t		m_sUtilRec;
};

#endif

#endif
