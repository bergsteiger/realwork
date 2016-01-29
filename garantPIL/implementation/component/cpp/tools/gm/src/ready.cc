#include "gdbapi.h"
#include "basemask.h"

extern "C" {

u_int32_t get_ready(base_st *pbase)
{
	GDataStatusMask msk(TID_GM);

	return msk.CheckMask(pbase->ready_flags);
}

u_int32_t get_final_mask(u_int32_t mask)
{
	GDataStatusMask msk(TID_GM);

	return msk.SetMask(mask);
}

char *missing_process_description(u_int32_t mask)
{
	int16_t x, y;

	return GetProcessDescription(mask, x, y);
}

}
