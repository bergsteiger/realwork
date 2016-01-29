#include "basemask.h"
#include "garantPIL/implementation/component/cpp/libs/mrglib/src/base.h"

extern "C" {

char pTmpBuff0[4096];
stream_st psstr2;

u_int32_t get_ready(u_int32_t mask)
{
	GDataStatusMask msk(TID_HISYNC);

	return msk.CheckMask(mask);
}

u_int32_t get_final_mask(u_int32_t mask)
{
	GDataStatusMask msk(TID_HISYNC);

	return msk.SetMask(mask);
}

char *missing_process_description(u_int32_t mask)
{
	int16_t x, y;

	return GetProcessDescription(mask, x, y);
}

}

extern "C" {
	extern int CompStringsZZZ(void *l1, void *l2);
	int CompStringsZZZX(const void *l1, const void *l2){
		return CompStringsZZZ((void *)l1, (void *)l2);
	}
}
