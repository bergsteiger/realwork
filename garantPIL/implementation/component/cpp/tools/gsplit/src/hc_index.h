#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"

typedef struct {
	u_int32_t id;
	char *key;
	set_st *data;
} hkey_item;

int collect_string_keys(set_st *map, iter_st *pit, u_int32_t *levcounts);
void sort_string_keys_by_name(set_st *map);
void free_keys_map(set_st *map, u_int16_t count);
void init_keys_map(set_st *map, u_int32_t key_count, u_int16_t reclen, u_int16_t count);
void extract_stream_data(set_st *set, stream_st *pstr);
int hkeyitemstrcmp(const void *p1, const void *p2);

