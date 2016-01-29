#ifndef __GDB_STDINDEX_H
#define __GDB_STDINDEX_H

/*-----------------29.10.97 18:06-------------------
 * Known data & key types used in gdb
 * --------------------------------------------------*/
#ifndef _GDB_DT_
#define _GDB_DT_
#define DT_STRING  1
#define DT_INT32   2
#define DT_INT16   3
#define DT_DATE    4
#define DT_ATTRKEY 5
#define DT_REF     6
#define DT_STRING8 7
#define DT_HIER    8
#define DT_DIVKEY  9
#define DT_KWDKEY  10
#define DT_CLSKEY  11
#ifdef MULTI_INDEX_STREAM_FILE
	#define DT_UINT64 12
#endif
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*-----------------29.10.97 18:06-------------------
 * Known data & key comparison functions
 *--------------------------------------------------*/
int attrcmp(const void *a1, const void *a2);
int attrcmp_new(const void *a1, const void *a2);
int longcmp(const void *l1, const void *l2);
int shrtcmp(const void *l1, const void *l2);
int refcmp(const void *a1, const void *a2);
int ref2cmp(const void *a1, const void *a2);
int datecmp(const void *a1, const void *a2);
int ctxcmp(const void *ctx1, const void *ctx2);
#ifdef MULTI_INDEX_STREAM_FILE
	int ctxcmp64(const void *ctx1, const void *ctx2);
#endif
int hkcmp(const void *phk1, const void *phk2);
int hindcmp(const void *phk1, const void *phk2);
int hkwcmp(const void *phk1, const void *phk2);

#ifdef __cplusplus
}
#endif

#endif // __GDB_STDINDEX_H	
	
