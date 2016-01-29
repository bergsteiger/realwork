#ifndef _STREAM_PRIMITIVES_TAO_H_
#define _STREAM_PRIMITIVES_TAO_H_

#include <string>
#include "tao/corba.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/StreamOperatorsPrimitives.h"

namespace NdtClone {

inline void operator << (Stream& stream, const TAO_String_Manager& value) {
	std::string s_value (static_cast<const char*> (value));
	stream << s_value;	
}

inline void operator >> (Stream& stream, TAO_String_Manager& value) {
	std::string s_value;
	stream >> s_value;
	value = s_value.c_str ();
}



inline void operator << (Stream& stream, const TAO_SeqElem_String_Manager& value) {
	std::string s_value (static_cast<const char*> (value));
	stream << s_value;	
}

inline void operator >> (Stream& stream, TAO_SeqElem_String_Manager& value) {
	std::string s_value;
	stream >> s_value;
	value = s_value.c_str ();
}

} // namespace

#endif // _STREAM_PRIMITIVES_TAO_H_


