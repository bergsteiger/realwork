#ifndef __GDB_STRUCTURES_H
#define __GDB_STRUCTURES_H

#include "gardefs.h"

#ifdef __cplusplus
extern "C" {
#endif

#define GAR_COPYRIGHT_LEN 76
#define GDB_ATTR_OFFS (GAR_COPYRIGHT_LEN + 6)
#define MAX_INDEX_NAME 32

#define KF_PAGE_SIZE  0x0800
#define KF_PGPOW      0x000B
#define SF_PAGE_SIZE  0x1000
#define SF_PGPOW      0x000C
#define SF_SIDMASK    0x0FFF

/*-----------------29.10.97 16:11-------------------
 * General types used in GDB
 * --------------------------------------------------*/
// Structures for keys & stream records

typedef int (*cmpfunc_ft)(const void *, const void *);

typedef struct tag_attrkey attrkey_st;
typedef struct tag_docrun docrun_st;
typedef struct tag_runrec runrec_st;
typedef struct tag_ref ref_st;
typedef struct tag_hierkey hierkey_st;
typedef struct tag_date date_st;
typedef struct tag_paged_file_header pfhdr_st;
typedef struct tag_stream_ref stref_st;
typedef struct tag_bthdr_st bthdr_st;
typedef struct tag_time_ time_st;
typedef struct tag_stime stime_st;
typedef struct tag_stream_info stream_info;
typedef struct BaseInfo baseinfo_st;
typedef struct DocInfo docinfo_st;

#pragma pack(1)
struct tag_attrkey {
	u_int32_t doc_id;
	u_int16_t tag;
} __PACKED__;

struct tag_docrun {
	u_int32_t page;
	u_int16_t count;
} __PACKED__;

struct tag_runrec {
	u_int32_t doc_id;
	docrun_st run;
	u_int16_t reserved16;
	u_int32_t reserved32;
} __PACKED__;

struct tag_ref {
	u_int32_t id;
	u_int32_t sub;
} __PACKED__;

struct tag_hierkey {
	char      level;
	u_int32_t pid;
	u_int32_t id;
	int32_t   tc;
	int32_t   cc;
	char      key[1];
} __PACKED__;

struct tag_date {
	u_int16_t year;
	char      day;
	char      month;
} __PACKED__;

struct tag_paged_file_header {
	u_int32_t signature;
	char copyright[GAR_COPYRIGHT_LEN];
	u_int16_t page_size;
	u_int16_t attr_offs;
	u_int32_t last_page;
	u_int32_t free_page;
	u_int32_t last_free_page;
	u_int32_t CRC;
	u_int16_t isCrypted;
	long TomPerPages;
	char reserved[150];
} __PACKED__;

struct tag_stream_ref {
	u_int32_t size;
	u_int32_t alloc;
	union {
		u_int32_t pos;
		char bin[4];
	} data;
} __PACKED__;

struct tag_stream_info {
	u_int16_t immds;
	u_int16_t rndv;
} __PACKED__;

struct tag_bthdr_st {
	u_int32_t root;
	u_int16_t order;
	u_int16_t keylen;
	u_int32_t key_count;
	u_int16_t depth;
	u_int32_t last_id;
	stream_info strinfo;
	u_int16_t nstreams;
} __PACKED__;

struct tag_time_ {
	unsigned char  ti_min;   // minutes
	unsigned char  ti_hour;  // hours
	unsigned char  ti_hund;  // hundredths of seconds
	unsigned char  ti_sec;   // seconds
} __PACKED__;

struct tag_stime {
	unsigned char hour;
	unsigned char min;
	unsigned char sec;
	signed char tzone;
} __PACKED__;
#pragma pack()

typedef struct tag_stamp {
	date_st date;
	stime_st time;
} stamp_st;

#ifdef __cplusplus
}
#endif

#endif // __GDB_STRUCTURES_H

