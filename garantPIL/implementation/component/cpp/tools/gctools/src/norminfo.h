/*
 * $Id: norminfo.h,v 2.3 2001/09/13 10:30:31 migel Exp $
 */
#ifndef _norminfo_h
#define _norminfo_h

class CaseStringSplaySet;
class FString;

struct NormInfo {
    CaseStringSplaySet *norms;
	FString *default_;
};

int readNormInfo(NormInfo *, const char *);

#endif
