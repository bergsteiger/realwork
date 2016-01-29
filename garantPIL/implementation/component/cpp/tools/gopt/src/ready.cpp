#include "shared/Core/fix/mpcxc.h"
#include <sys/types.h>
#include "osdep.h"

#include "gardefs.h"
#include "basemask.h"
#include "gdbapi.h"

//extern "C" {

u_int32_t get_ready(base_st *pbase)
{
	GDataStatusMask msk(TID_GOPT);

	return msk.CheckMask(pbase->ready_flags);
}

u_int32_t get_final_mask(u_int32_t mask)
{
	GDataStatusMask msk(TID_GOPT);

	return msk.SetMask(mask);
}

char *missing_process_description(u_int32_t mask)
{
	int16_t x, y;

	return GetProcessDescription(mask, x, y);
}

extern "C" {
	char pTmpBuff0[4096];
	stream_st psstr2;
	extern int CompStringsZZZ(void *l1, void *l2);
	int CompStringsZZZX(const void *l1, const void *l2){
		return CompStringsZZZ((void *)l1, (void *)l2);
	}
}
//}
