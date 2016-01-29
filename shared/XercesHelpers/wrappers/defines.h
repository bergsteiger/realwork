#if !defined __XERCES_ADAPTER_DEFINES_H
#define __XERCES_ADAPTER_DEFINES_H

#include "shared/Core/mng/Aptr.h"
#include "shared/Core/mng/TypeDestructors.h"

namespace XercesHelpers {
	typedef Core::Aptr<char, Core::ArrayDeleteDestructor<char> > XMLStr;
}

#endif // !defined(__XERCES_ADAPTER_DEFINES_H)

