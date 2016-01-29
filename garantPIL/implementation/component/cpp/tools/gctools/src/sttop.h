/*
 * $Id: sttop.h,v 2.7 2005/08/09 11:49:43 grigorio Exp $
 */
#ifndef _sttop_h
#define _sttop_h

#include "garcomp.h"
#include "sources.h"
#include "CaseString.defs.h"

//class FStringSplaySet;
//class FStringlongSplayMap;
#include <cstdio>

class STtoP
{
	public:
		STtoP(const char *,ThreadCompileInfo*);
		int getp( CaseStringSplaySet * srcs, CaseStringSplaySet * tps);
		~STtoP();
		int Ok(){ return status == 0; };
		int **matrix;
		int nSources;
	protected:
		int status;
		CaseStringlongSplayMap *types;
		CaseStringlongSplayMap *sources;
		int nTypes;
		int maxSources;
		ThreadCompileInfo* inf;
		int endTypes();
		int beginSource();
		void readST2P(FILE *f );
		friend int st2p_lex();
		int lex();
		int backTo;
};

#endif 

