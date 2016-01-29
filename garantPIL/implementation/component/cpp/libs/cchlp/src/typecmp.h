/*
 * cvs id was here
 */

#ifndef _typecmp_h
#define _typecmp_h 1

#include "osdep.h"
#include "garutils.h"

inline int operator > (date& a, date& b) {
	return CompDates ( &a, &b ) > 0;
}

inline int operator < (date& a, date& b) {
	return CompDates ( &a, &b ) < 0;
}

inline  int	cchlp_Sign( long x ) { return ( x > 0 ? 1 : ( x < 0 ? -1 : 0 ) ); }

inline int operator	> (SubDesc& a, SubDesc& b ) {
	int s;
	s = cchlp_Sign ( a.Sub - b.Sub );
	if (s != 0) return s > 0;
	return a.Para > b.Para;
}

inline int operator	< (SubDesc& a, SubDesc& b ) {
	int s;
	s = cchlp_Sign ( a.Sub - b.Sub );
	if (s != 0) return s < 0;
	return a.Para < b.Para;
}

inline int operator	> (SubDescEx& a, SubDescEx& b ) {
	return memcmp ( &a, &b, sizeof(SubDescEx) ) > 0;
}

inline int operator	< (SubDescEx& a, SubDescEx& b ) {
	return memcmp ( &a, &b, sizeof(SubDescEx) ) < 0;
}

inline int operator	> (DocStruct& a, DocStruct& b ) {
	return a.m_id > b.m_id;
}

inline int operator	< (DocStruct& a, DocStruct& b ) {
	return a.m_id < b.m_id;
}

inline int operator	< (const Ref& a, const Ref& b ) {
	int s;
	s = cchlp_Sign ( a.DocId - b.DocId);
	if ( s != 0 ) return s < 0;
	return a.Sub < b.Sub;
}

inline int operator	> (Ref& a, Ref& b ) {
	return CompRefs ( &a, &b ) > 0;
}

inline int operator	< (Ref& a, Ref& b ) {
	return CompRefs ( &a, &b ) < 0;
}

inline int operator	> (CorrRef& a, CorrRef& b ) {
	int s;
	s = cchlp_Sign ( a.Sub - b.Sub );
	if ( s != 0 ) return s > 0;
	s = cchlp_Sign ( a.DocId - b.DocId );
	if ( s != 0 ) return s > 0;
	s = cchlp_Sign( a.Para - b.Para );
	if ( s != 0 ) return s > 0;
	s = cchlp_Sign( a.RealPara - b.RealPara );
	if ( s != 0 ) return s > 0;
	return a.Block > b.Block;
}

inline int operator	< (const CorrRef& a, const CorrRef& b ) {
	int s;
	s = cchlp_Sign ( a.Sub - b.Sub );
	if ( s != 0 ) return s < 0;
	s = cchlp_Sign ( a.DocId - b.DocId );
	if ( s != 0 ) return s < 0;
	s = cchlp_Sign( a.Para - b.Para );
	if ( s != 0 ) return s < 0;
	s = cchlp_Sign( a.RealPara - b.RealPara );
	if ( s != 0 ) return s < 0;
	return a.Block < b.Block;
}

inline int operator	> (RespRef& a, RespRef& b ) {
	int s;
	s = cchlp_Sign ( a.ParaId - b.ParaId );
	if ( s != 0 ) return s > 0;
	s = cchlp_Sign ( a.Offset - b.Offset );
	if ( s != 0 ) return s > 0;
	s = cchlp_Sign ( a.DocId - b.DocId );
	if ( s != 0 ) return s > 0;
	return a.Sub > b.Sub;
}

inline int operator	< (RespRef& a, RespRef& b ) {
	int s;
	s = cchlp_Sign ( a.ParaId - b.ParaId );
	if ( s != 0 ) return s < 0;
	s = cchlp_Sign ( a.Offset - b.Offset );
	if ( s != 0 ) return s < 0;
	s = cchlp_Sign ( a.DocId - b.DocId );
	if ( s != 0 ) return s < 0;
	return a.Sub < b.Sub;
}

inline int operator	> (DocRele& a, DocRele& b ) {
	int s;
	s = cchlp_Sign ( b.Rele - a.Rele );
	if ( s != 0 ) return s > 0;
	return a.DocId > b.DocId;
}

inline int operator	< (DocRele& a, DocRele& b ) {
	int s;
	s = cchlp_Sign ( b.Rele - a.Rele );
	if ( s != 0 ) return s < 0;
	return a.DocId < b.DocId;
}

inline int operator	> (ObjKey& a, ObjKey& b ) {
	return memcmp ( &a, &b, sizeof(ObjKey) ) > 0;
}

inline int operator	< (ObjKey& a, ObjKey& b ) {
	return memcmp ( &a, &b, sizeof(ObjKey) ) < 0;
}

inline int operator	> (BaseInfo& a, BaseInfo& b ) {
	return a.BaseId > b.BaseId;
}

inline int operator	< (BaseInfo& a, BaseInfo& b ) {
	return a.BaseId < b.BaseId;
}

inline	int operator < (ShortCommonAttribute& a, ShortCommonAttribute& b) {
	return a.m_id < b.m_id;
}

inline	int operator > (ShortCommonAttribute& a, ShortCommonAttribute& b) {
	return a.m_id > b.m_id;
}

inline	int operator < (KindCorr78Ref& a, KindCorr78Ref& b) {
	return *(u_int64_t*)&a < *(u_int64_t*)&b;
}

inline	int operator > (KindCorr78Ref& a, KindCorr78Ref& b) {
	return *(u_int64_t*)&a > *(u_int64_t*)&b;
}

inline	int operator < (KindCorrRef& a, KindCorrRef& b) {
	int s = cchlp_Sign (a.seg - b.seg);
	if (s != 0) return s < 0;
	return a.mask < b.mask;
}

inline	int operator > (KindCorrRef& a, KindCorrRef& b) {
	int s = cchlp_Sign (a.seg - b.seg);
	if (s != 0) return s > 0;
	return a.mask > b.mask;
}

inline	int operator < (const DSSAttribute & a, const DSSAttribute & b) {
	return a.m_id < b.m_id;
}

inline	int operator > (const DSSAttribute & a, const DSSAttribute & b) {
	return a.m_id > b.m_id;
}

inline	int operator == (const DSSAttribute & a, const DSSAttribute & b) {
	return a.m_id == b.m_id;
}

inline	int operator < (const ShortCommonAttribute& a, const ShortCommonAttribute& b) {
	return a.m_id < b.m_id;
}

inline	int operator > (const ShortCommonAttribute& a, const ShortCommonAttribute& b) {
	return a.m_id > b.m_id;
}

inline	int operator == (const ShortCommonAttribute& a, const ShortCommonAttribute& b) {
	return a.m_id == b.m_id;
}

#endif
