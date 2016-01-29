#ifndef __READY_H__
#define __READY_H__

#include "osdep.h"

u_int32_t get_ready(u_int32_t mask);
u_int32_t get_final_mask(u_int32_t mask);
char *missing_process_description(u_int32_t mask);

#endif  // __READY_H__
