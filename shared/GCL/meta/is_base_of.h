#ifndef SHARED_GCL_META_IS_BASE_OF_H__
#define SHARED_GCL_META_IS_BASE_OF_H__
                                              

#if defined (_MSC_VER) && (_MSC_VER >= 1800) //MSVC++ 12.0 _MSC_VER == 1800 (Visual Studio 2013)
#   include <type_traits>
#   define IS_BASE_OF(parrent, child) std::is_base_of<parrent, child>::value 
#else
#   include "loki/TypeManip.h"
#   include "loki/static_check.h"
#   define IS_BASE_OF(parrent, child)  Loki::SuperSubclass<parrent, child>::value 
#endif

#endif //SHARED_GCL_META_IS_BASE_OF_H__
                
