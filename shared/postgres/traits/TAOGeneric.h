#ifndef _POSTGRES_HELPERS_TRAITS_TAO_GENERIC_H_
#define _POSTGRES_HELPERS_TRAITS_TAO_GENERIC_H_

#include "boost/shared_array.hpp"

#include "pqxx/pqxx"

#include "ace/Codecs.h"
#include "tao/CDR.h"
#include "shared/GCL/str/base64_encoder.h"

// специализация записи/чтения для произвольных типов TAO
#define TAO_string_traits(TYPENAME) \
namespace pqxx { \
 \
template<> \
struct string_traits <TYPENAME> { \
	typedef TYPENAME subject_type; \
 \
	static const char* name () { \
		return #TYPENAME; \
	} \
 \
	static bool has_null () { \
		return false; \
	} \
 \
	static bool is_null (const TYPENAME&) { \
		return false; \
	} \
 \
	static TYPENAME null () { \
		internal::throw_null_conversion (name ()); \
		return subject_type (); \
	} \
 \
	static void from_string (const char str[], TYPENAME& obj) { \
		size_t decoded_length = 0; \
		boost::shared_array<ACE_Byte> buffer ( \
			ACE_Base64::decode (reinterpret_cast <const unsigned char*> (str), &decoded_length) \
		); \
 \
		TAO_InputCDR cdr (reinterpret_cast <const char*> (buffer.get ()), decoded_length); \
		bool deserialized = (cdr >> obj); \
		GDS_ASSERT (deserialized); \
	} \
 \
	static std::string to_string (const TYPENAME& obj) { \
		TAO_OutputCDR cdr; \
		bool serialized = cdr << obj; \
		GDS_ASSERT (serialized); \
 \
		/* TAO_OutputCDR message blocks склеиваются в один буфер */ \
		TAO_InputCDR flat_buffer (cdr); \
 \
		return GCL::encode_base64_string (std::string (flat_buffer.rd_ptr (), flat_buffer.length ())); \
	} \
}; \
 \
}

#endif
