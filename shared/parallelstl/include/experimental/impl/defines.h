#pragma once
#ifndef _IMPL_DEFINES_H_
#define _IMPL_DEFINES_H_

// Export definitions
//#ifdef _PSTL_DLL
//#define _EXP_IMPL __declspec(dllexport)
//#else
//#define _EXP_IMPL __declspec(dllimport)
#define _EXP_IMPL 
//#endif

#if _MSC_VER  >= 1900
#define _PSTL_NS1_BEGIN namespace std { namespace experimental { namespace parallel { inline namespace v1 {
#define _PSTL_NS1_END }}}}
#else
#define _PSTL_NS1_BEGIN namespace std { namespace experimental { namespace parallel {
#define _PSTL_NS1_END }}}
#endif

#endif