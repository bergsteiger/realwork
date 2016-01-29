#include "osdep.h"
#include "../../../libs/mrglib/src/gdbapi.h"
#include "basemask.h"
#include "indices.h"

#include "garantPIL/implementation/component/cpp/libs/mrglib/src/base.h"

extern "C" {

extern void close_bases (base_st *, int);
extern char *gs_result_file;

char pTmpBuff0 [4096];
stream_st psstr2;

int CompStringsZZZX(const void *l1, const void *l2){
	return CompStringsZZZ((void *)l1, (void *)l2);
}

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

void set_base_State(base_st *pbase, int count)
{
	//char *pNames= (char*)alloca(count * 256), *pName= pNames;
#ifndef PTRS_IN_META
	set_base_state(pbase, get_final_mask(pbase[1].ready_flags));
#endif
	int ii= 0, len;
	for(
#ifdef PTRS_IN_META
		++ii, count += count - 2
#endif
								; ii < count; ii++/*, pName += 256*/)
	{
		len= strlen(pbase[ii].key.name);
		pbase[ii].key.name[len-4]= 0;
		//memcpy(pName, pbase[ii].key.name, len-3);
		pbase[ii].key.name[len-4]= '.';
	}
	close_bases(
#ifdef PTRS_IN_META
				++pbase
#else
				pbase
#endif
				, count
								);
	free(pbase);
}

char *missing_process_description(u_int32_t mask)
{
	int16_t x, y;

	return GetProcessDescription(mask, x, y);
}

}







