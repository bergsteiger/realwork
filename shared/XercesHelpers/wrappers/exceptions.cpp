#include "shared/XercesHelpers/wrappers/exceptions.h"

namespace XercesHelpers {

const char* InvalidXMLType::uid () const /*throw ()*/ {
	return "XercesHelpers::InvalidXMLType";
}

const char* InvalidXML::uid () const /*throw ()*/ {
	return "XercesHelpers::InvalidXML";
}

const char* XercesAdapterNotFound::uid () const /*throw ()*/ {
	return "XercesHelpers::XercesAdapterNotFound";
}

const char* XercesIOError::uid () const /*throw ()*/ {
	return "XercesHelpers::XercesIOError";
}

const char* XercesBadEncoding::uid () const /*throw ()*/ {
	return "XercesHelpers::XercesBadEncoding";
}

} // namespace XercesHelpers
