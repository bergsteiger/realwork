/*
 * $Id: sources.h,v 2.7 2005/08/09 11:49:43 grigorio Exp $
 */
#ifndef _sources_h
#define _sources_h

#include <cstdio>
#include "u_int32_t.SplaySet.h"
#include <sys/types.h>

class CaseStringlongSplayMap;

struct SourcesInfo {
    CaseStringlongSplayMap *sm;
    CaseStringlongSplayMap *tm;

    long sourceCount;
	long territoryCount;

	struct SourceInfo{
		char *sourceName;
		u_int32_tSplaySet * territoryN;
    	size_t nameLength; // including trailing 0
	} *sinfo;

	struct TerritoryInfo{
		char *territoryName;
    	size_t nameLength; // including trailing 0
	} *tinfo;

};

int readSourcesInfo(SourcesInfo *, const char *);

#endif

