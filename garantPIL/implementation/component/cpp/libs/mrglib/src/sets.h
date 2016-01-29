#ifndef __SETS_H
#define __SETS_H

#include <sys/types.h>

#include "stdindex.h"
#include "mrgdefs.h"
#include "base.h"

#ifdef __cplusplus
extern "C" {
#endif

#define SETF_ALLOC 0x4000

typedef struct SET_ST_TAG{
	u_int32_t alloc;
	u_int32_t count;
	char *set;
	cmpfunc_ft rcmp;
	u_int16_t dtype;
	u_int16_t reclen;
	u_int16_t flags;
	unsigned char *seg_set;
	u_int32_t iMulti;
	unsigned char *sub_seg_set;
	int isExtBlob;
	int isMenu;
	int isPacked;
	int isIgnoreHere;
	int isDocsList;
	unsigned char *set_docs;
	u_int32_t count_blob_docs;
	unsigned char *set_blob_docs;
	void *pSourceBase;
	u_int16_t *pSourceBaseHere;
	long *pSkipDoc, SkipDocCount;
	char *BSset;
	u_int32_t BScount;
	long NDTCopy;
	unsigned char *seg_32;
	u_int32_t put_first_disk;
	u_int32_t *all_demo;
	u_int32_t count_all_demo;
	u_int32_t iMultiDemo;
} set_st;

int set_alloc(set_st *ps, size_t size);
int set_realloc(set_st *ps, size_t size);
int set_isect(set_st *ps1, set_st *ps2);
int isect_sets(set_st *pis, set_st *ps1, set_st *ps2);
int merge_sets(set_st *ds, set_st *ps, int count);
int stream_isect_sets(stream_st *pdest, set_st *ps1, set_st *ps2);
int stream_merge_sets(stream_st *pstr, set_st *ps, int count);

#ifdef __cplusplus
}
#endif

#endif // __SETS_H
