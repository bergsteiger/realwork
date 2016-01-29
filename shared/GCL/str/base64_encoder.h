////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/str/base64_encoder.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::str::base64_encoder
//
// реализация base64 кодирования, которая может выступать фильтром для потока. Стыбрена из ngi-
// central.org.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_STR_BASE64_ENCODER_H__
#define __SHARED_GCL_STR_BASE64_ENCODER_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *48FDB9CE0275_USER_INCLUDES*
#include <boost/iostreams/filter/aggregate.hpp>
//#UC END# *48FDB9CE0275_USER_INCLUDES*

namespace GCL {

//#UC START# *48FDB9CE0275_USER_DEFINITION*
template<
	/// The character base of the base64 encoder. Usually this is char or
	/// wchar_t.
	typename C,
	/// The allocator type of the base64 encoder. Usually this is
	/// std::allocator<C>.
	typename A = std::allocator<C> >
	/// A base64 encoder filter that can be used with boost::iostreams.
class base64_encoder_base : public boost::iostreams::aggregate_filter<C, A> {
private:
	/// Base class of this filter.
	typedef boost::iostreams::aggregate_filter<C, A> base_type;

public:
	/// The character type of this filter.
	typedef typename base_type::char_type char_type;
	/// The category of this filter.
	typedef typename base_type::category category;
	/// The vector type used by this filter.
	typedef typename base_type::vector_type vector_type;

private:
	/// Encode a block of three 8bit characters and return 4 base64 characters.
	void encode_base64_block(
		/// The block of three 8bit characters.
		std::vector<unsigned char> const& buf,
		/// Vector of 4 base64 characters to receive decoded result.
		std::vector<unsigned char> & encoded,
		/// The number of 8bit characters in the block.
		size_t character_count
	) {
		const char base64_code[] = {"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"};

		encoded[0] = base64_code [buf[0] >> 2];
		encoded[1] = base64_code [((buf[0] & 0x03) << 4) | ((buf[1] & 0xf0) >> 4)];
		encoded[2] = character_count > 1 ? base64_code [((buf[1] & 0x0f) << 2) | ((buf[2] & 0xc0) >> 6)] : '=';
		encoded[3] = character_count > 2 ? base64_code [buf[2] & 0x3f] : '=';
	}

	/// The function that performs the actual base64 encoding.
	virtual void do_filter (
		/// The source data.
		vector_type const& src,
		/// The destination data.
		vector_type & dest
	) {
		size_t nblocks = 0;
		for (typename vector_type::const_iterator si=src.begin (); si!=src.end ();) {
			std::vector<unsigned char> block(3, '\0');
			size_t i = 0;
			for ( i = 0; i < 3 && si != src.end (); ++i) {
				block[i] = (unsigned char)*si++;
			}

			std::vector<unsigned char> encoded(4, '\0');
			encode_base64_block (block, encoded, i);
			dest.insert(dest.end (), encoded.begin (), encoded.end ());
			++nblocks;

			if (nblocks >= 76/4 - 1) {
				dest.push_back('\n');
				nblocks = 0;
			}
		}
	}
};

BOOST_IOSTREAMS_PIPABLE (base64_encoder_base, 2)

/// A base64 encoder for a char type.
typedef base64_encoder_base<char> base64_encoder;

/// A base64 encoder for a wchar_t type.
typedef base64_encoder_base<wchar_t> wbase64_encoder;

std::string encode_base64_string (const std::string& to_encode);
std::string encode_base64_string (const std::vector<char>& to_encode);
//#UC END# *48FDB9CE0275_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_STR_BASE64_ENCODER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
