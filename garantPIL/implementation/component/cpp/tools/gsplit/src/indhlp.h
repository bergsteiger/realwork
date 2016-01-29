#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"

typedef struct {
	u_int32_t num;
	u_int32_t tc;
	u_int32_t cc;
	stref_st stref;
	u_int32_t reserved;
	stref_st stref2;
	u_int32_t reserved2;
} hkeyref_st;

typedef struct {
	u_int32_t id;
	u_int32_t tc;
	u_int32_t cc;
} idc_st;

#ifndef __INDHLP_C
extern int reg_key(hierkey_st *, hkeyref_st *, set_st *, set_st *);
extern int filter_stream(iter_st *, set_st *, index_st *, int , stream_st *);
extern int fill_indexes(iter_st *spit, index_st *tin, set_st * pkeyset, int count);
#endif

