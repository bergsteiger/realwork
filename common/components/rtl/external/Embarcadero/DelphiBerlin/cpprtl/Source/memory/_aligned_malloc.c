#include <alloc.h>
#include <stdint.h>

void * _EXPFUNC _aligned_malloc(size_t size, size_t alignment)
{
    size_t sz;
    void *ptr;
    void *aligned;

    if (!size)
        return NULL;

    sz = size + (alignment - 1) + sizeof(void *);
    ptr = malloc(sz);
    if (!ptr)
	return NULL;

    aligned = (void *)((uintptr_t)((char *)ptr + sizeof(void *) + (alignment - 1)) & ~(uintptr_t)(alignment - 1));
    *((void **) aligned-1) = ptr;

    return aligned;
}


void _EXPFUNC _aligned_free(void * block)
{
    free(*((void **) block-1));
}
