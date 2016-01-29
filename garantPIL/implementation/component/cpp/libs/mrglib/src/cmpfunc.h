#ifndef __CMPFUNC_H
#define __CMPFUNC_H

#ifdef __cplusplus
extern "C" {
#endif

int attrcmp(const void *a1, const void *a2);
int longcmp(const void *l1, const void *l2);
int shrtcmp(const void *l1, const void *l2);
int refcmp(const void *a1, const void *a2);
int ref2cmp(const void *a1, const void *a2);
int datecmp(const void *a1, const void *a2);
int ctxcmp(const void *ctx1, const void *ctx2);
int hkcmp(const void *phk1, const void *phk2);
int hindcmp(const void *phk1, const void *phk2);
int hkwcmp(const void *phk1, const void *phk2);

#ifdef __cplusplus
}
#endif

#endif

