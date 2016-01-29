#ifndef _REV_H_
#define _REV_H_

#include "gardefs.h"

void rev_addweek(revision& theRev, const int weeks);
void rev_adddays(revision& theRev, const int days);
long rev_daysdiff(revision theRev1, revision theRev2);

#endif // _REV_H_
