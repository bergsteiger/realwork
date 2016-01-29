/*
 *
 * cvs id was here
 * Generic Garant defines & structures
 *
 */

#ifdef __cplusplus
#ifndef	__GARANT_DEFINES_CPP__
#define	__GARANT_DEFINES_CPP__

#include <deque>
#include "garantPIL/implementation/component/cpp/include/osdep.h"
#include "../../../libs/gkdb/src/gardefs.h"

#pragma warning (disable: 4503) // 'identifier': decorated name length exceeded, name was truncated
#pragma warning (disable: 4786) // 'identifier': identifier was truncated to 'number' characters in the debug information

#include "common/components/rtl/Garant/EVD/evddata.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Common/Constants.h"

#pragma pack(1)

typedef GCL::StrSet StrList;

struct	SubDesc {
	long	Sub;	/* sub no */
	long	Para;	/* para   */
	bool operator == (const SubDesc& y) const {
		return (Sub == y.Sub);
	}
	bool operator < (const SubDesc& y) const {
		return (Sub < y.Sub);
	}
}__PACKED__;

#define	SUBDESCEX_DOCUMENT	evd::id_Document
#define	SUBDESCEX_BLOCK		evd::id_Block
#define	SUBDESCEX_BLOCKEND	(SUBDESCEX_BLOCK | SUBDESCEX_END)
#define	SUBDESCEX_SBS		evd::id_SBS
#define	SUBDESCEX_SBSEND	(SUBDESCEX_SBS | SUBDESCEX_END)
#define	SUBDESCEX_TABLE		evd::id_Table
#define	SUBDESCEX_TABLEEND	(SUBDESCEX_TABLE | SUBDESCEX_END)
#define	SUBDESCEX_STRING	evd::id_TableRow
#define	SUBDESCEX_STRINGEND	(SUBDESCEX_STRING | SUBDESCEX_END)
#define	SUBDESCEX_CELL		evd::id_TableCell
#define	SUBDESCEX_CELLEND	(SUBDESCEX_CELL | SUBDESCEX_END)
#define	SUBDESCEX_SUB		evd::id_Sub
#define	SUBDESCEX_SBSSTRING	evd::id_SBSRow
#define	SUBDESCEX_SBSSTRINGEND	(SUBDESCEX_SBSSTRING | SUBDESCEX_END)
#define	SUBDESCEX_SBSCELL	evd::id_SBSCell
#define	SUBDESCEX_SBSCELLEND	(SUBDESCEX_SBSCELL | SUBDESCEX_END)

inline bool operator == (const SubDescEx& x, const SubDescEx& y) {
	return x.Sub == y.Sub && ((x.Flags & SUBDESCEX_END) == (y.Flags & SUBDESCEX_END));
}

inline bool operator < (const SubDescEx& x, const SubDescEx& y) {
	if (x.Para < y.Para) return true;
	if (x.Para > y.Para) return false;
	return x.Sub > y.Sub;
}
///
struct DocActivityEx {
	long	block;
	struct	date from;
	struct	date to;
	bool	b_add_iddactive;
	char*	text;	
	bool operator < (const DocActivityEx& a) const;
}__PACKED__;

struct DocChDate {
	struct date anonce; // дата изменяющего документа
	struct date active; // когда вступил в силу
	bool operator < (const DocChDate& a) const;
}__PACKED__;

struct	ChDateEx {
	struct date anonce;	// дата изменяющего документа
	Ref	ref;		// номер документа.саба изменяющего документа
	bool operator < (const ChDateEx& a) const;
}__PACKED__;

struct	ContentsStruct {
	long	Sub;
	short	Size;		// количество уровней оглавления, которые надо показывать для этого блока
	short	Extended;
	bool operator < (const ContentsStruct& a) const {
		return Sub < a.Sub;
	}
}__PACKED__;

struct	CompareContentsStruct {
	long	Sub;
	short	Levels;		// количество уровней оглавления, которые надо сравнивать для этого блока
	bool operator < (const CompareContentsStruct& a) const {
		return Sub < a.Sub;
	}
}__PACKED__;

struct	DocNotSure {
	struct date from;
	struct date to;
	char* text;
	bool operator < (const DocNotSure& a) const;
}__PACKED__;

struct	TreeNodeLevel {
	long	id;
	short	level;
	TreeNodeLevel () : id(0), level(0) {		
	}
	TreeNodeLevel (long	_id) : id(_id), level(0) {		
	}
	inline bool operator < (const TreeNodeLevel& a) const {
		return id < a.id;
	}
}__PACKED__;

struct	DivisionInfo {
	long	Para;
	char	Symbol;
	char*	Params;
	bool operator < (const DivisionInfo& a) const;
}__PACKED__;

#pragma pack()

#endif
#endif
