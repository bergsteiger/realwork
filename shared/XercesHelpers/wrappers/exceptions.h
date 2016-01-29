#ifndef __XERCES_ADAPTER_EXCEPTIONS_H
#define __XERCES_ADAPTER_EXCEPTIONS_H

#include "shared/Core/sys/std_inc.h"

namespace XercesHelpers {

class InvalidXMLType : public Core::Exception {
	virtual const char* uid () const /*throw ()*/;
};

class InvalidXML : public Core::Exception {
	virtual const char* uid () const /*throw ()*/;
};

class XercesAdapterNotFound : public Core::Exception {
	virtual const char* uid () const /*throw ()*/;
};

class XercesIOError  : public Core::Exception {
	virtual const char* uid () const /*throw ()*/;
};

class XercesBadEncoding  : public Core::Exception {
	virtual const char* uid () const /*throw ()*/;
};

} // namespace XercesHelpers

#endif // __XERCES_ADAPTER_EXCEPTIONS_H
