#include <stdlib.h>
#include <stdint.h>

#if defined(__cplusplus)
extern "C" {
#endif

void _RTLENTRY _EXPFUNC __invoke_constraint_handler_s(const char * _RESTRICT __msg,
						      void * _RESTRICT __ptr,
						      errno_t __error);

#if !defined(_WIN64)
void * __fastcall _EXPFUNC _internal_memmove(const void *src, void *dest, size_t n);
#else
#define _internal_memmove(__src, __dest, __n) memmove(__dest, __src, __n)
#endif

_INLINE int __blocks_overlap(const void *p1, size_t len1, const void *p2, size_t len2)
{
    if (p2 > p1)
	return ((char *)p2 < (char *)p1+len1);
    else
	return ((char *)p1 < (char *)p2+len2);
}

#if defined(__cplusplus)
}
#endif
