#include <stdlib.h>
#include <typeinfo.h>

namespace __cxxabiv1
{

extern "C"
{

void * __cxa_allocate_exception (size_t thrown_size) throw() {
    return 0;
}

void __cxa_throw(void* thrown_object, std::type_info* tinfo, void (*dest)(void*))
{
}

}  // extern "C"

}  // __cxxabiv1
