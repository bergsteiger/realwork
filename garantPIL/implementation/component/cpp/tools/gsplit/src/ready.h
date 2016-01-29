#ifndef __READY_H__
#define __READY_H__
#include "../../../libs/mrglib/src/gdbapi.h"

#include "toys.h"

u_int32_t get_ready(base_st *pbase);
u_int32_t get_final_mask(u_int32_t mask);
char *missing_process_description(u_int32_t mask);

#endif

