#ifndef POSTGRES_QUOTE_HELPER_H_INCLUDED
#define POSTGRES_QUOTE_HELPER_H_INCLUDED

#include "pqxx/pqxx"
#include "libpq-fe.h"

namespace postgres {

// реализация quote взята из кишков libpqxx. Использует deprecated метод PQescapeString, 
// но новый PQescapeStringConn лезет в базу, кажется, что на данный момент это излишество
template<class Type>
std::string quote (const Type& data) {
	if (pqxx::string_traits<Type>::is_null (data)) return "NULL";
	
	std::string string_data = pqxx::string_traits<Type>::to_string (data);
	size_t maxlen = 2*string_data.size () + 1;
	pqxx::internal::scoped_array<char> buf (new char [maxlen]);
	const size_t bytes = PQescapeString (buf.get (), string_data.c_str (), maxlen); 
	std::string escaped;
	escaped.assign (buf.get (), bytes);

	return "'" + escaped + "'";
}

}

#endif
