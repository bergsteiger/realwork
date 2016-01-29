#include "shared/Core/fix/mpcxc.h"
#ifndef _INDEX_H_
#define _INDEX_H_

#include "mrgdefs.h"
#include "pagefile.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Switching to FAT32: 
 *	replace u_int16_t to u_int32_t in fat_rec_type typedef;
 *	change CHAIN_FLAG definiition to 0x80000000
 *	change FAT_PAGE_EP definiition to 10
**/
typedef u_int32_t fat_rec_type;
#define CHAIN_FLAG 0x80000000
#define FAT_PAGE_EP 10

#define SCF_HANGING 0x1000
#define SCF_FPHANG 0x2000
#define MIF_ATTRS 0x0100

// Stream modes & flags
#define SF_WRALLOW 0x8000
#define SF_NOALLOC 0x0800
#define SF_DESTROY 0x0400
#define SF_WRLOCK  0x0200
#define SF_FREEBUF 0x0010
#define SF_USELOCAL 0x0020
#define SF_FREELOCAL 0x0040

#define OB_NONDT    0x00000080
#define OB_RWHACK   0x00000100

#define OBSC_SEQSP  0x00008000
#define OBSC_RNDSP  0x00004000
#define OBSC_SMALL  0x00030000
#define OBSC_MEDIUM 0x00020000
#define OBSC_LARGE  0x00010000

#define BF_OPTIMAL  0x00010000
#define BF_READY    0x00008000

#define PF_OPTIMIZE_PAGES_COUNT 4

// End of stream modes & flags
typedef struct tag_cache_entry {
	u_int32_t pos;       // page position (now page number)
	u_int16_t rec_count; // records count in cached page
	u_int16_t hits;      // page hits count (read)/ free space (write)
	char *    page;      // cached page buffer
} cache_entry;

typedef struct tag_keyarray {
	char *    fname;          // file name
	int       hkeys;          // file handle
  u_int16_t keylen;         // key length
	u_int16_t max_cached;     // number of keys allowed to be in memory cache
	u_int16_t cached;         // number of keys currently in memory cache
	u_int16_t last;           // 
	u_int32_t count;          // total keys count 
	u_int32_t pos;            // position of mem cache in array
	char *    cache;          // cache memory pointer
	char *    free;           // cache free memory pointer
	u_int32_t mode;           // current usage : key addition (write) or index build (read)
} keyarray_st;

#ifdef WIN32_
	typedef struct tag_TempPagePack {
		u_int32_t	PGNumber;
		u_int32_t	prePGNumber;
		int			packedSize;
		char		*pBuff;
		void		*pNext;
	} TempPagePack;
#endif

typedef struct tag_pgfile {
	int hfile;                // file handle
	pfhdr_st *pfhdr;          // paged file header pointer
	char *attr_area;          // paged file "attributes" area pointer
	int pgpow;                // power of 2 of page size in bytes (page size = 1 << pgpow)
	int mode;                 // access mode : read or ace_os_write
	char *name;               // file name
	u_int32_t *packtbl;       // packing table
	////////////////////////////////////////////////////
	PF_PARAM	PrmExt;
	int			postFileHandles[MAX_COUNT_FILE_HANDLES+1];
	u_int32_t	postFilePoss[MAX_COUNT_FILE_HANDLES+1];
	long		max_paged_file_per_bytes;
	u_int32_t	AddedPage;
	////////////////////////////////////////////////////
} pgfile_st;

typedef struct tag_streamfile {
	pgfile_st     pgfile;     // parent structure
	char *        str_header; // unused now
	fat_rec_type *fat;        // FAT pointer - loaded or created
	u_int16_t     fat_size;   // FAT size in pages
	u_int16_t     fat_alloc;  // FAT pages allocated (write mode only)
	u_int32_t     hfp;        // "hanging" FAT page number (write mode only)
	u_int32_t     lfp;        // currently written FAT page number (write mode only)
	u_int32_t    *fat_chain;  // FAT pages chain (write mode only)
	u_int32_t     stpos;      // page number currently in buffer (non-cached reading only)
	char *        spage;      // page buffer (non-cached reading only)
	void *(*cache_get_page)(struct tag_streamfile *, u_int32_t); // cache control function pointer
	char *        cache;      // cache buffer
	u_int16_t     flags;      // 
	u_int16_t     cused;
	cache_entry * centries;
	fat_rec_type *hits;
	u_int32_t     cmax;
} streamfile_st;

#ifdef MULTI_INDEX_STREAM_FILE
	typedef struct tag_SubTom {
		pgfile_st     *pKey;
		streamfile_st *pStr;
		char	*pName;
	} SubTom_st;
#endif
typedef struct tag_base {
	pgfile_st     key;
	pgfile_st     ndt;
	int           runs;
	streamfile_st str;
	char *        ndt_header;
	char *        key_header;
	u_int16_t     keylen;
	u_int16_t     immds;
	u_int32_t     flags;
	u_int32_t     ready_flags;
	u_int32_t     ready_flags2;
#ifdef MULTI_INDEX_STREAM_FILE
	u_int32_t	openMode, iNContxt;
	SubTom_st	*pSubToms;
	SubTom_st	*pNextSubToms;
#endif
} base_st;

#pragma pack(1)
struct tag_btree_node {
	u_int16_t count;
	u_int32_t ref0;
	char      keys[2042];
	u_int16_t key;
	u_int16_t child_ref;
} __PACKED__;

struct tag_btree_node4096 {
	u_int16_t count;
	u_int32_t ref0;
	char      keys[2042+2048];
	u_int16_t key;
	u_int16_t child_ref;
} __PACKED__;
#pragma pack()

typedef struct tag_btree_node node_st;
typedef struct tag_btree_node4096 node_st_x2;

typedef struct tag_iterator {
	pgfile_st *    pf;
	cmpfunc_ft     keycmp;
	u_int16_t      keylen;
	stream_info    strinfo;
	u_int16_t      nstreams;
	u_int16_t      ref_offs;
	u_int16_t      depth;
	u_int32_t      key_count;
	node_st *      cnode;
	node_st *      stack;
	u_int16_t      sp;
	u_int16_t      key;
	char *         pkey;
	streamfile_st *str;
	cmpfunc_ft     reccmp;
	u_int16_t      reclen;
} iter_st;

#define ALLOC_STEP_FOR_STREAM 32

typedef struct tag_Index_Offset {
	unsigned char i;
#ifdef ALL_Index_Offset
	long Doc, Para, Word;
#endif
} Index_Offset_st;
typedef struct tag_Norml_Node {
	char val[32], *pBases;
} Norml_Node;
typedef struct tag_Form_Node {
	char val[32];
	u_int64_t BasesMask;
} Form_Node;

typedef struct tag_stream {
	streamfile_st *str;
	char *data;
	char *rec;
	char *local;
	u_int32_t pos;
	stref_st ref;
	char buf[20];
	char **ppBlock;
	int	szBlockPointers;
	u_int32_t	cboffs
				, bcount
				, cblock;
	u_int16_t flags;
	stream_info info;
#ifdef STORE_FORM_N
	Index_Offset_st ArrayIOffs[256];
	int ArrayIOffsCount;
	char *pDeletedNorms;
	int iDeletedNorms, curr_B, max_B;
	Norml_Node *pNorml_Node;
	char *pCurrKey;
	Form_Node *pAForms;
	int temp_flush_handle, hDocsFile, refs_count, temp_flush_handle_GCTX;
#endif
} stream_st;

#ifdef MULTI_INDEX_STREAM_FILE
	#include "sets.h"
#endif

typedef struct tag_index {
	char *         name;
	base_st *      pbase;
	pgfile_st *    pf;
	char *         phdrpage;
	bthdr_st       hdr;
	u_int16_t      reclen;
	cmpfunc_ft     keycmp;
	cmpfunc_ft     reccmp;
	keyarray_st    kar;
	streamfile_st *str;
	u_int16_t      mode;
	u_int16_t      flags;
	int (__cdecl *trunc_NContxt_str)(struct SET_ST_TAG*,struct tag_index*,struct tag_iterator*,struct tag_stream*,struct tag_stream*);
} index_st;

#ifdef __cplusplus
}
#endif

#if defined(__GO32__) || defined (__CYGWIN32__)
	#ifndef __GLOBALS_C
		extern u_int32_t debug_flags;
		extern u_int32_t debug_level;

		// Debug levels
		#define DL_LOW 0x0001
		#define DL_MED 0x0002
		#define DL_HIGH 0x0004
		// Debug flags
		#define DF_STREAMS 0x0001
		#define DF_BTREE 0x0002
		#define DF_INDEX 0x0004
		#define DF_SETS 0x0008
	#endif
#endif

#endif
