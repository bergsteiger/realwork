#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <stdlib.h>

#include "gdbapi.h"

#if defined(__DOS32__)
	#define KA_CACHE 0x10000
#elif defined(__WIN32__)
	#define KA_CACHE 0x40000
#else
	#define KA_CACHE 0x40000
#endif

void reset_key_array(keyarray_st *lpkf, u_int16_t keylen)
{
	//abort();//ace_os_ftruncate(lpkf->hkeys, 0);
	lpkf->keylen = keylen;
	if(!(lpkf->cache)) lpkf->cache = (char *)ml_malloc(KA_CACHE);
	lpkf->max_cached = (KA_CACHE / keylen) & 0xFF00;
	lpkf->cached = lpkf->max_cached;
	lpkf->pos = lpkf->count = 0;
	lpkf->mode = 1;
}

void write_key(keyarray_st *lpkf, void *key)
{
  void *cur;
	u_int32_t pos;

	if(!lpkf->mode) {
		c_io_lseek(lpkf->hkeys, 0, ACE_OS_SEEK_END);
		lpkf->mode = 1;
		pos = lpkf->last = 0;
		lpkf->cached = lpkf->max_cached;
	}
	else pos = lpkf->keylen*lpkf->last;
  cur = (char *)lpkf->cache + pos;
  memcpy(cur, key, lpkf->keylen);
	lpkf->count++;
  if(++lpkf->last == lpkf->cached) {
    c_io_write(lpkf->hkeys, lpkf->cache, lpkf->cached*lpkf->keylen);
    lpkf->last = 0;
  }
}

void rseek_key_array(keyarray_st *lpkf, u_int32_t pos)
{
	lpkf->pos = pos;
	if(lpkf->mode) return;
	c_io_lseek(lpkf->hkeys, pos*lpkf->keylen, ACE_OS_SEEK_SET);
	lpkf->cached = c_io_read(lpkf->hkeys, lpkf->cache, lpkf->max_cached*lpkf->keylen)/lpkf->keylen;
	lpkf->last = 0;
}

int read_key(keyarray_st *lpkf, void *key)
{
	void *cur;

	if (lpkf->mode) {
		if(lpkf->last) c_io_write(lpkf->hkeys, lpkf->cache, lpkf->last*lpkf->keylen);
		lpkf->mode = 0;
		c_io_lseek(lpkf->hkeys, lpkf->pos*lpkf->keylen, ACE_OS_SEEK_SET);
		lpkf->cached = c_io_read(lpkf->hkeys, lpkf->cache, lpkf->max_cached*lpkf->keylen)/lpkf->keylen;
		lpkf->last = 0;
	}
	if (lpkf->last == lpkf->cached) {
		lpkf->cached = c_io_read(lpkf->hkeys, lpkf->cache, lpkf->max_cached*lpkf->keylen)/lpkf->keylen;
		if(lpkf->cached == 0) return 0;
		lpkf->last = 0;
	}
	cur = (char *)lpkf->cache + lpkf->last*lpkf->keylen;
	memcpy(key, cur, lpkf->keylen);
	lpkf->last++;
	lpkf->pos++;
  return 1;
}

void sort_key_array(keyarray_st *lpkf, cmpfunc_ft keycmp)
{
  u_int32_t len;
  void *buf;

  len = lpkf->count*lpkf->keylen;
  c_io_lseek(lpkf->hkeys, 0L, ACE_OS_SEEK_SET);
  buf = ml_malloc(len);
  c_io_read(lpkf->hkeys, buf, len);
  qsort(buf, lpkf->count, lpkf->keylen, keycmp);
  c_io_lseek(lpkf->hkeys, 0L, ACE_OS_SEEK_SET);
  c_io_write(lpkf->hkeys, buf, len);
  c_io_lseek(lpkf->hkeys, 0L, ACE_OS_SEEK_SET);
  free(buf);
}

