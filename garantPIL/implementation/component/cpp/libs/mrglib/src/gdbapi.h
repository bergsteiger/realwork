#ifndef __GDBAPI_H
#define __GDBAPI_H

#ifdef _WINDOWS
#include <windows.h>
#endif

#if defined(WIN32) && !defined(__WIN32__)
	#define __WIN32__
#endif

#ifndef true
	#define true 1
#endif

#ifndef false
	#define false 0
#endif

#include "base.h"
#include "gardefs.h"
#include "osdep.h"
#include "iapi.h"
#include "platform.h"
#include "log.h"

#define IS_SHORT_STR(_pref_) (0 != ((_pref_->alloc & 0x80000000) ? BIG_STREAM_HANDLE_TO_ID(_pref_->data.pos, _pref_->alloc ) : OLD_STREAM_HANDLE_TO_ID( _pref_->data.pos )))

#ifdef __cplusplus
extern "C" {
#endif

int open_base(const char *path, base_st *pbase, u_int32_t mode);
void unlink_base(const char *path);
int create_base(const char *path, base_st *pbase);
void close_base(base_st * pbase);
void set_base_state(base_st *pbase, u_int32_t ready_state);

index_st *open_index(base_st *pbase, const char *name, index_st *pin, short init_cache);
index_st *create_index(base_st *pbase, const char *name, index_st *pin);
index_st *open_index_hack(pgfile_st *pf, const char *name, index_st *pin);
index_st *create_index_hack(pgfile_st *pf, const char *name, index_st *pin);
void close_index(index_st *pin);
#ifdef MULTI_INDEX_STREAM_FILE
index_st *create_indexEx(base_st *pbase, const char *name, index_st *pin, void *pOtherRootNodeOut);
void close_indexEx(index_st *pin, void *pOtherRootNodeOut);
#endif
void add_key(index_st *pin, void *pkey);

iter_st *init_iter(index_st *pin, iter_st *pit);
iter_st *init_iter_from(index_st *pin, iter_st *pit, void *key_from);
void release_iter(iter_st *pit);
void *next_key(iter_st *pit);
void *prev_key(iter_st *pit);
void *first_key(iter_st *pit);
void *last_key(iter_st *pit);
int locate_key(iter_st *pit, void *key_to);

stref_st *get_stref(iter_st *pit, int nstr);
stref_st *get_stref_ex(char *key, u_int16_t keylen, u_int16_t immds, u_int16_t nstreams, int nstr);
stream_st *load_stream(iter_st *pit, stream_st *pstr);
stream_st *load_stream_ex(streamfile_st *psf, stref_st *pref, stream_st *pstr, stream_info *info);
stream_st *load_stream_n(iter_st *pit, stream_st *pstr, int n);
void release_stream(stream_st *pstr);
stream_st *create_stream(index_st *pin, stream_st *pstr);
stream_st *create_stream_ex(streamfile_st *psf, stream_st *pstr, stream_info *info);
int write_stream(stream_st *pstr, void *buf, u_int32_t size);
void attach_stream(stream_st *pstr, stref_st *pref);
void move_stream(stream_st *pstr, streamfile_st *pdest, stref_st *pref);
void close_stream(stream_st *pstr);

u_int32_t alloc_page(pgfile_st *);
int read_page(pgfile_st *, u_int32_t, void *);
int write_page(pgfile_st *, u_int32_t, void *);
int read_pages(pgfile_st *, u_int32_t , u_int32_t , void *);
int write_pages(pgfile_st *, u_int32_t , u_int32_t , void *);
int open_pgfile(const char *, pgfile_st *);
int close_pgfile(pgfile_st *);
int create_pgfile(const char *, pgfile_st *, u_int16_t );
u_int32_t pgfile_size(pgfile_st *);
void pgfile_close_current_tom(pgfile_st *);
int pgfile_make_next_tom(pgfile_st *);

void *bfindge(void *key, void *array, int rcount, int size, cmpfunc_ft cmpf);
int bfindgex(void *key, void *array, int rcount, int size, cmpfunc_ft cmpf);

int gb_last_error(void);
void gb_log_error();
int gb_enable_log();
int gb_set_last_error(int err, ...);
char *gb_err_msg(int err, char *, int);

char *get_index_name(int);
int get_index_weight(const char *name);
u_int16_t get_immds(int ind);

u_int16_t get_info(pgfile_st *pgfile, const char *name, void *buf);
void set_info(pgfile_st *pgfile, const char *name, void *buf, u_int16_t size);

void makestamp(stamp_st *);

/* Wrappers for memory allocation functions to ease errors tracking */
cmpfunc_ft get_cmpfunc(int dtype);

#if defined(__GO32__)
	#define DIRECTORIES_TERM '/'
#elif defined(__WIN32__)
	#define DIRECTORIES_TERM '\\'
#else
	#define DIRECTORIES_TERM '/'
#endif

#define ml_malloc(X) malloc(X)
#define ml_calloc(X,Y) calloc(X,Y)

//extern unsigned UnZip ( void *, int, void *, int );
extern int gb_set_last_error(int, ...);

extern void * bfindge(void *, void *, int, int, cmpfunc_ft);
extern int bfindgex(void *, void *, int, int, cmpfunc_ft);

extern void *read_short_stream(streamfile_st *pfile, stref_st *pref);
extern void	*read_long_stream(streamfile_st *pfile, stref_st *pref);
extern int	_gb_log_state_;

static const int full_text_segment= 39;

typedef struct tag_index_info {
	char *name;
	u_int16_t  keylen;
	u_int16_t  immds;
	u_int16_t  reclen;
	u_int16_t  flags;
	cmpfunc_ft keycmp;
	cmpfunc_ft reccmp;
	u_int16_t  keydt;
	u_int16_t  recdt;
	u_int16_t  rndv;
	u_int16_t  nstreams;
	u_int16_t  weight;
} index_info_st;

#ifdef __cplusplus
}
#endif

#endif

