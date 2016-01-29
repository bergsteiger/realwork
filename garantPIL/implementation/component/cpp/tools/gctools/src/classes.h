/*
 * $Id: classes.h,v 2.14 2011/01/31 11:45:04 vlad Exp $
 */
#ifndef _classes_h_
#define _classes_h_

#include <cstdio>
#include <sys/types.h>
//#include <CaseString.defs.h>

class CaseStringlongSplayMap;
class FString;
class CaseStringSplaySet;
class CaseStringcaddr_tSplayMap;

class ClassesInfo {
public:
	ClassesInfo :: ClassesInfo() :
		cm(0), classCount(0), clInfo(0), pfxInfo(0), pm(0),
		v(0), docPrefixes(0), commPrefixes(0), allPrefixes(0),
	    	formPrefixes(0), projPrefixes(0), prakPrefixes(0),
    		intePrefixes(0), quesPrefixes(0), brefPrefixes(0) {} ;

	CaseStringlongSplayMap *cm;	// map: raw class -> index in clInfo array
								// returns -1 in class not found
	long classCount;			// number of classes in clInfo

	struct ClassInfo {
		int nEquals;		// lengths of equals
		int *equals;		// array of ids of EQ
		size_t nameLength;	// length of name classes
		char *className;	// full class name
	} *clInfo;

	long prefixCount;
	struct PrefixInfo {
		size_t nameLength;
		char *prefixName;
		short prefixType;
	} *pfxInfo;

	CaseStringlongSplayMap *pm; // map prefix-> index in pfxInfo array
                             // -1 if not found
	
	struct UnodeInfo {
		int nIn;
		int maxIn;
		struct NI {
			int jtype;
			char *uname;
			char *cls;
		} *node;
	};

	CaseStringcaddr_tSplayMap *unodes;
	
    u_int32_t v;
    CaseStringSplaySet
		*allPrefixes,
		*docPrefixes,
		*commPrefixes,
		*formPrefixes,
		*projPrefixes,
		*prakPrefixes,
		*intePrefixes,
		*quesPrefixes,
		*brefPrefixes;

	enum TranslateWhat {
		TRANSCLASS,
		TRANSPREFIX
	};

	FString *pTranslate(FString &key, TranslateWhat, int last = 0);
};

int readClassInfo(ClassesInfo & ci, const char *fn, int print_pfx_ex);

#endif


