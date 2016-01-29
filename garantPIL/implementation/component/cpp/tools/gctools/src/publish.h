#ifndef __loadPublishMap_h
#define __loadPublishMap_h

#include "garcomp.h"
char* new2old(const char* p_new);
int loadPublishMap(GFStringFStringMap *m, GFStringFStringMap *mconv, const char *fn, int maxKeyLength);

#endif
