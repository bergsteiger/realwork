#ifndef _POSTGRES_HELPERS_TRAITS_CONTAINERS_H_
#define _POSTGRES_HELPERS_TRAITS_CONTAINERS_H_

#include <string>
#include <vector>

#include "boost/tokenizer.hpp"

#include "pqxx/pqxx"

namespace pqxx {

// специализация записи/чтения массивов 
template<typename T> struct string_traits<std::vector<T> > {
	typedef std::vector<T> subject_type;

	static const char* name () {
		return "std::vector<T>";
	}

	static bool has_null () {
		return false;
	}

	static bool is_null (const std::vector<T>&) {
		return false;
	}

	static std::vector<T> null () {
		internal::throw_null_conversion (name ());
		return subject_type ();
	}

	static void check_input (const char str[], size_t length) {
		if (length < 2) {
			throw pqxx::failure ("Bad array format: " + std::string (str));
		}
		if ((str[0] != '{') || (str[length - 1] != '}')) {
			throw pqxx::failure ("Bad array format: " + std::string (str));
		}
	}

	static void from_string (const char str[], std::vector<T>& obj) {
		if (!obj.empty ()) {
			throw pqxx::failure ("You should use empty array to get data");
		}
		size_t length = ACE_OS::strlen (str);
		check_input (str, length);

		typedef boost::char_separator<char> separator;
		typedef boost::tokenizer<separator, const char*> tokenizer;
		separator sep (",");
		tokenizer tok (
			str + 1
			, str + length - 1
			, sep
		);
		try {
			T next;
			for (tokenizer::iterator it = tok.begin (); it != tok.end (); ++it) {
				string_traits<T>::from_string (it->c_str (), next);
				obj.push_back (next);
			}
		}
		catch (pqxx::failure&) {
			obj.swap (std::vector<T> ());
			throw;
		}
	}

	static std::string to_string (const std::vector<T>& obj) {
		return postgres::container_to_string<T> (obj.begin (), obj.end ());
	}
};

}

namespace postgres {

template <typename ElementType, typename IteratorType>
std::string container_to_string (IteratorType begin, IteratorType end) {
	if (begin == end) {
		return "{}";
	}

	std::string result = "{";
	for (; begin != end; ++begin) {
		result += pqxx::string_traits<ElementType>::to_string (*begin) + ",";
	}
	result[result.size () - 1] = '}';

	return result;
}

}

#endif
