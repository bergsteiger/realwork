#ifndef __IAPI_H
#define __IAPI_H

#include "base.h"

#ifdef __cplusplus
extern "C" {
#endif

void flush_write_cache(streamfile_st *);

void reset_key_array(keyarray_st *lpkf, u_int16_t keylen);
void write_key(keyarray_st *lpkf, void *key);
void rseek_key_array(keyarray_st *lpkf, u_int32_t pos);
int read_key(keyarray_st *lpkf, void *key);
void sort_key_array(keyarray_st *lpkf, cmpfunc_ft keycmp);
u_int32_t build_btree(index_st *pin);

void *rsp_get_page(streamfile_st *pfile, u_int32_t pos);
void *ssp_get_page(streamfile_st *pfile, u_int32_t pos);
void *none_get_page(streamfile_st *pfile, u_int32_t pos);

int get_index_info(const char *name, index_st *pind);

#ifdef __cplusplus
}
#endif

#endif

