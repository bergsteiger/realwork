/*
 * $Header: /cvs/garantPIL/implementation/component/cpp/tools/delta/src/diffhldr.h,v 2.11 2014/04/14 12:12:55 young Exp $
 * $Id: diffhldr.h,v 2.11 2014/04/14 12:12:55 young Exp $
 */
#ifndef __diffhldr_h_
#define __diffhldr_h_

#include "base.h"
#ifdef MIN_MEM_CONTEXT
	#include "ncpf.h"
#else
	#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/SimpleBase.h"
#endif
/*
 * DiffHolder(filesName, bRDWR)
 *
 * filesName - the base for files key, str
 *             for instance, if you give "myDelts",
 *             files "myDelts.k" and "myDelts.s" will be created
 * bRDWR - open read/write or read-only
 *             1 - use for create and write to the idx1 and idx2
 *             0 - for read only.
 */

class DiffHolder
{
public:
#ifdef MIN_MEM_CONTEXT
	LongIndex *idx1;
	LongIndex *idx2;
#endif
	DiffHolder(const char *filesName, int bRDWR, int& created);
	~DiffHolder();
protected:
#ifdef MIN_MEM_CONTEXT
	NCPagedFile *kf, *sf;
	StreamFile  *strF;
#else
	NdtClone::SimpleBase<4096, 2013> m_base;
public:
	LongIndex* idx1;
	LongIndex* idx2;
#endif
public:
	static const char m_idx1_Name[5];
	static const char m_idx2_Name[5];
};

#endif
