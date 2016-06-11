#include <_defs.h>
//#include <stdio.h>
#ifdef DEBUG_BACKPATCH
#include <windows.h>
#endif
#include <stdint.h>

/*
  backpatch data is like this:

 */

extern unsigned __embt_backpatch_data;
extern unsigned __embt_backpatch_data_end;

typedef struct {
    void **IATEntry;
    unsigned int count;
}  backpatch_header_t;

#ifdef DEBUG_BACKPATCH
static char print_buffer[2048];
#endif

void __backpatch_data_references() {
    char *cur = (char *)&__embt_backpatch_data;
    if (__embt_backpatch_data == 0xCAFEBACC)
        return;
    while (cur !=  (char *)&__embt_backpatch_data_end) {
	backpatch_header_t *bp = (backpatch_header_t *)cur;
	void ***loc = (void ***)(cur + sizeof(void *) + sizeof(int));
	void *p = *bp->IATEntry;
	int i;
#if defined(__WIN32__)
	if ((((uint32_t)p) & 0x000025FF) == 0x000025FF) {
	    p = *(void **)((uint32_t)bp->IATEntry + 2);
	    p = *(void **)p;
	}
#endif
	for (i = 0; i < bp->count; i++) {
#ifdef DEBUG_BACKPATCH
            void *save_loc = **loc;
#endif            
	    **loc = (void *)(((char *)**loc) + (uint64_t)p);
#ifdef DEBUG_BACKPATCH
	    wsprintf(print_buffer, "%p: %p -> %p, %p - > %p", *loc, bp->IATEntry, p, **loc, save_loc);
            MessageBox(0, print_buffer, "ilink debug", MB_OK);
#endif            
	    loc++;
	}
	cur = (char *)loc;
    }
}

#if defined(_WIN64)
#pragma startup __backpatch_data_references 0
#endif
