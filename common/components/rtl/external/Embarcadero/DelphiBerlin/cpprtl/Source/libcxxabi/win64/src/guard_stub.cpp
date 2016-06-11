#include "cxxabi.h"
#include "abort_message.h"
#include <_thread.h>

namespace __cxxabiv1
{
typedef uint64_t guard_type;

bool is_initialized(guard_type* guard_object) {
    char* initialized = (char*)guard_object;
    return *initialized;
}

void set_initialized(guard_type* guard_object) {
    char* initialized = (char*)guard_object;
    *initialized = 1;
}

typedef uint32_t lock_type;

lock_type
get_lock(uint64_t x)
{
    return static_cast<lock_type>(x >> 32);
}

inline
void
set_lock(uint64_t& x, lock_type y)
{
    x = static_cast<uint64_t>(y) << 32;
}

static lock_t guard_lock;    /* semaphore for THREAD_DATA pointer */

_EXPFUNC int __cxa_guard_acquire(guard_type* guard_object)
{
    char* initialized = (char*)guard_object;
    _lock(guard_lock, "locking guard lock");
    int result = *initialized == 0;
    // CHECKME
    if (result)
        set_lock(*guard_object, true);
    _unlock(guard_lock, "unlocking guard lock");
    return result;
}

_EXPFUNC void __cxa_guard_release(guard_type* guard_object)
{
    _lock(guard_lock, "locking guard lock");
    *guard_object = 0;
    set_initialized(guard_object);
    _unlock(guard_lock, "unlocking guard lock");
}

_EXPFUNC void __cxa_guard_abort(guard_type* guard_object)
{
    _lock(guard_lock, "locking guard lock");
    *guard_object = 0;
    _unlock(guard_lock, "unlocking guard lock");
}

_STATIC void _guard_init(void)
{
#pragma startup _guard_init 1 /* Initialize the guard MT lock */

    _create_lock(&guard_lock,"creating guard lock");
}

}
