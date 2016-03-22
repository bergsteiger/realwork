/*
 * $Id: deltadef.h,v 2.73 2016/01/28 07:16:39 young Exp $
 */

#ifndef _FD_DEF_
#define _FD_DEF_

#define M_ORD_PAR   3      // 00000011
#define M_ORD_HDR   252    // 11111100

#define O_PAR_EQU       0      // .000
#define O_PAR_MOV       1      // .001
#define O_PAR_NEW       2      // .010
#define O_PAR_CHG       3      // .011
#define O_STL_CHG       4      // .100

#define O_HDR_STYLE     4       // 00000100
#define O_HDR_TSTART    8       // 00001000
#define O_HDR_LMARGIN   16      // 00010000
#define O_HDR_RMARGIN   32      // 00100000
#define O_HDR_REDLINE   64      // 01000000
#define	O_HDR_EVD	128

#define O_DOC_EQU       2
#define O_DOC_NEW       1
#define O_DOC_CHG       0

// ATTR mask

#define MAX_LEVEL       14

// first level header (x----xxx)

#define M_ATR_NLE       128  // next level enable
#define M_DOC_ORD       1    // doc's order (only in first level)
#define M_CWD_CHG       2    // context changed, больше не используем
#define M_TXT_CHG       4    // text changed
#define	M_TXT_INCACHE	2    // признак того, что в кэше только текст документа

#define M_CWD_EQU       0    // context equal
#define M_TXT_EQU       0    // text equal

// first level (maximum 4 bits -xxxx---)
#define M_ATR_DAT   8
#define M_ATR_VCH   16
#define M_ATR_INF   32
#define M_ATR_KEY   64

// second level (maximum 7 bits -xxxxxxx)
#define M_ATR_SUBSEX   1
#define M_ATR_TYP   2
#define M_ATR_SRC   4
#define M_ATR_TER   8
#define M_STAT_NODOC	16	// status changed DOC -> NODOC
#define M_STAT_DOC	32	// status changed NODOC -> DOC 
#define M_ATR_IND_RESP 64       // respondent index

// third level (maximum 7 bits -xxxxxxx)
#define M_ATR_BAS   1 
#define M_ATR_ID   2
#define M_ATR_RCD   4
#define M_ATR_DIV   8
#define M_ATR_KND   16
#define M_ATR_SRT   32
#define M_ATR_NAM   64

// forth level (maximum 7 bits -xxxxxxx)
#define M_ATR_RDT   1
#define M_ATR_WAR   2
#define M_ATR_VLC   4
#define M_ATR_VAN   8
#define M_ATR_CAT   16
#define M_ATR_PUB   32
#define M_ATR_VAB   64

// fith level (maximum 7 bits -xxxxxxx)
#define M_ATR_INC   1
#define M_ATR_SFL	2
#define M_ATR_ACT	4
#define	M_ATR_PBREAKS	8
#define	M_ATR_PARAIDS	16
#define	M_ATR_CHDATE	32
#define	M_ATR_CONTENTS	64

// 6th level
#define M_ATR_NOTSURE	1
#define	M_ATR_REFS	2
#define	M_ATR_BLOBS	4
#define	M_ATR_DIVIS	8
#define	M_ATR_PREANNO	16
#define	M_ATR_ANNODATE	32
#define	M_ATR_ANNOU	64

// 7th level
#define	M_ATR_ANNOO	1
#define	M_ATR_ANNOT	2
#define	M_ATR_ANNOI	4
#define	M_ATR_ANNOK	8
#define	M_ATR_PREANNOU	16
#define	M_ATR_PREANNOO	32
#define	M_ATR_PREANNOT	64

// 8th level
#define	M_ATR_PREANNOI	1
#define	M_ATR_PREANNOK	2
//образовалось место, поскольку удален IDD_PARAFLAGS
#define M_ATR_CHANGE	8
#define M_ATR_HANDMASK	16
#define M_ATR_SAMEDOCS	32
#define M_ATR_SERVICEINFO	64

// 9th level
#define M_ATR_HANDHANDMASK	1
#define	M_ATR_CLASS6		2
#define	M_ATR_INPHARMFIRM	4
#define	M_ATR_INPHARMCOUNTRY	8
#define	M_ATR_ANNULDATE		16
#define	M_ATR_TRADENAME		32
#define	M_ATR_INTNAME		64

// 10th level
#define	M_ATR_PHARMGROUP	1
#define	M_ATR_PHARMEFFECT	2
#define	M_ATR_CHAPTER		4
#define	M_ATR_ATC		8
#define	M_ATR_REGSTATUS		16
#define	M_ATR_LEKFORM		32
#define	M_ATR_MKB		64

// 11th level
#define	M_ATR_REGDATE		1
#define	M_ATR_CASECODE		2
#define	M_ATR_LIFE		4
#define	M_ATR_UNRECIPE		8
#define	M_ATR_ALLOWED		16
#define	M_ATR_NOTALLOWED	32
#define	M_ATR_RECIPE		64

// 12th level
#define	M_ATR_NOTLIFE		1
#define	M_ATR_SUB		2
#define	M_ATR_EVD		4
#define	M_ATR_ACTIVEEX		8
#define	M_ATR_PARAGCTX		16
#define	M_ATR_CALIN		32
#define	M_ATR_CALAB		64

// 13th level
#define	M_ATR_CALCH		1
#define	M_ATR_DOCSTRUCT		2
#define	M_ATR_INVISIBLELENS	4
#define	M_ATR_INVISIBLERELES	8
#define	M_ATR_KIND		16
#define	M_ATR_COMPARECONTENTS	32
#define	M_ATR_CHDATE_EX		64

// 14th level
#define	M_ATR_ADDCODE		1
#define	M_ATR_CHDATE_EXEX	2
#define	M_ATR_MARKEDTEXT	4
#define M_ATR_SAMES		8
#define M_ATR_TAG		16
#define M_ATR_PROFDATE		32
#define M_ATR_INVISIBLEBLOCKSLENS	64


/* INFO mask
#define M_INF_TITLE     1
#define M_INF_FDATE     2
#define M_INF_LDATE     4
#define M_INF_FORCE     8
#define M_INF_HYPREF    16
#define M_INF_GRCOM     32
#define M_INF_STATUS    64
#define M_INF_RELAT     128
*/

const long NEW_ID = 0;
const long LONG_FALSE = -2147483647;
const int g_ciMinusOne  = -1;
const int g_ciZerro     = 0;
const char g_ccZerro    = 0;
const long g_clZerro    = 0;

#define IND_STD         0
#define IND_SUBNAME     1
#define IND_AUX         2
#define IND_KEYWORD     3
#define IND_CLASS       4
#define IND_REF         5

#define KEY_BYINDEX     0
#define KEY_DATE        1
#define KEY_BOOL        2
#define KEY_LONG        3
#define KEY_CHAR5       4
#define KEY_STRZ        5
#define KEY_REF         6
#define KEY_HSTRZ       5 // 7 !!!

/*#define SKIP_HEADER     "It is delta skip file, DONT EDIT ANY RECORDS!"
#define SKIPHEADER_SIZE 45
*/

#define VER_OLD         1
#define VER_NEW         2

/* divisin suffex order in delta ( must be negative )
#define DELTA_USESUFFIX		-2
#define DELTA_NOSUFFIX		-1
*/

// update errors
#define	ERR_NONE		0
#define ERR_UPDATEDBASE	1
#define ERR_SKIPDELTA	2
#define ERR_NOSEGMENT	3
#define ERR_BADVERSION	4
#define ERR_DPMINOMEM	5
#define ERR_UNKNOWNPART 6
#define ERR_UNSYNCVER	7
#define ERR_UNKNOWN	8
#define ERR_BADSIZE	9
#define ERR_NOPARTS	10
#define ERR_UNKNOWNEOF	11
#define	ERR_BADBASE	12

// Varible part Id defines
#define DVAR_BUSINES	1
#define DVAR_SYNCVER	2
#define DVAR_GLMAPP		3

#ifdef	VERSION56
#define BUF_SIZE BLOCK_SIZE
#else
#define BUF_SIZE 1024
#endif

#endif
