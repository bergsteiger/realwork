#include "shared/Core/fix/mpcxc.h"
#include "gdbapi.h"

#ifndef __OPTMAIN_C
extern char *indx_file_name;
extern int gopt_options; 
extern int opt_ndt; 
#endif

#define GOO_NDT		0x00010000

u_int32_t opt_tree(base_st *, bthdr_st *, base_st *, char*);
#ifdef MULTI_INDEX_STREAM_FILE
	u_int32_t opt_treeIndex(index_st*, bthdr_st *, index_st*, char*);
#endif
u_int32_t move_ndt_pages(u_int32_t, u_int16_t);
void set_ndt_files(pgfile_st *_psrc, pgfile_st *_pdest);
void free_ndt_files(void);
int goptmain(char **, int, char *);

