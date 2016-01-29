#ifndef SHARED_GCL_META_STATIC_CHECK_H__
#define SHARED_GCL_META_STATIC_CHECK_H__

template<int> struct compile_time_error;
template<> struct compile_time_error<true> {};

#define STATIC_CHECK(expr, msg) \
    { compile_time_error<((expr) != 0)> ERROR_##msg; (void)ERROR_##msg; } 
#endif //SHARED_GCL_META_STATIC_CHECK_H__

