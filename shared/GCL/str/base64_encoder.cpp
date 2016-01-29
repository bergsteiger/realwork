////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/str/base64_encoder.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::str::base64_encoder
// Файл реализации утилитного набора base64_encoder
//
// реализация base64 кодирования, которая может выступать фильтром для потока. Стыбрена из ngi-
// central.org.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/str/base64_encoder.h"

//#UC START# *48FDB9CE0275_CUSTOM_INCLUDES*
#include <boost/iostreams/filtering_stream.hpp>
#include <boost/iostreams/device/back_inserter.hpp>
//#UC END# *48FDB9CE0275_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *48FDB9CE0275*
template<class Container>
const char* get_buffer (const Container& container) {
	GDS_ASSERT (false);
	return 0;
}

template<>
const char* get_buffer<std::string> (const std::string& container) {
	return container.c_str ();
}

template<>
const char* get_buffer<std::vector<char> > (const std::vector<char>& container) {
	if (container.empty ()) {
		const static char* empty_string = "";

		return empty_string;
	}

	return &container[0];
}

template<class Container>
std::string encode_base64_string_i (const Container& to_encode) {	
	boost::iostreams::filtering_ostream encode;
	std::string encoded;

	encode.push (GCL::base64_encoder ());
	encode.push (boost::iostreams::back_inserter (encoded));

	encode.write (get_buffer (to_encode), to_encode.size ());

	encode.pop ();	// this makes the stream run to completion

	return encoded;
}

std::string encode_base64_string (const std::string& to_encode) {
	return encode_base64_string_i (to_encode);
}

std::string encode_base64_string (const std::vector<char>& to_encode) {	
	return encode_base64_string_i (to_encode);
}
//#UC END# *48FDB9CE0275*

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

