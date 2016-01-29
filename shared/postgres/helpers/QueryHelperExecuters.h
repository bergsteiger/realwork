#ifndef POSTGRES_HELPER_QUERY_HELPER_EXECUTERS_H
#define POSTGRES_HELPER_QUERY_HELPER_EXECUTERS_H

#include "boost/utility/enable_if.hpp"
#include "boost/type_traits.hpp"

#include "shared/postgres/helpers/Transactor.h"
#include "shared/postgres/helpers/QueryHelper.h"

namespace postgres {

template<class QueryHelperType>
struct TransactorWithQueryHelper : public pqxx::transactor<> {
public:
	TransactorWithQueryHelper (QueryHelperType& query, bool& success) : m_query (query), m_success (success) {
		m_success = false;
	}

	void operator () (argument_type& T) {
		execute<QueryHelperType> (T);
	}

	template<class QueryHelperType>
	void execute (argument_type& T, typename boost::enable_if<boost::is_base_of<QueryHelperWithoutResult, QueryHelperType> >::type* = 0) {
		try {
			pqxx::result result = T.exec (m_query.get_query ());
			m_success = true;
		} catch (pqxx::failure& ex) {
			LOG_E (("Can't execute %s. %s", m_query.get_query ().c_str (), ex.what ()));
		}
	}

	template<class QueryHelperType>
	void execute (argument_type& T, typename boost::enable_if<boost::is_base_of<QueryHelperWithResult, QueryHelperType> >::type* = 0) {
		try {
			pqxx::result result = T.exec (m_query.get_query ());
			m_success = true;
			m_query.post_execute (result);
		} catch (pqxx::failure& ex) {
			LOG_E (("Can't execute %s. %s", m_query.get_query ().c_str (), ex.what ()));
		}
	}

	template<class QueryHelperType>
	void execute (argument_type& T, typename boost::enable_if<boost::is_same<UpsertQueryHelper, QueryHelperType> >::type* = 0) {
		try {
			pqxx::result result = T.exec (m_query.update_part ().get_query ());
			if (result.empty ()) {
				T.exec (m_query.insert_part ().get_query ());
			}
			m_success = true;
		} catch (pqxx::failure& ex) {
			LOG_E ((
				"Can't execute upsert query (update: %s, insert %s). %s"
				, m_query.update_part ().get_query ().c_str (), m_query.insert_part ().get_query ().c_str (), ex.what ())
			);
		}
	}

private:
	QueryHelperType& m_query;
	bool& m_success;
};

template<class QueryHelperType>
bool execute_query_helper (QueryHelperType& query) {
	bool success;
	TransactorWithQueryHelper<QueryHelperType> transactor (query, success);
	try {
		postgres::execute (transactor);
	} catch (std::logic_error& ex) {
		GDS_ASSERT (!success);
		LOG_E (("%s: %s", GDS_CURRENT_FUNCTION, ex.what ()));
	}

	return success;
}

template<class QueryHelperType>
struct ThrowingTransactorWithQueryHelper : public pqxx::transactor<> {
public:
	ThrowingTransactorWithQueryHelper (QueryHelperType& query) : m_query (query) {
	}

	void operator () (argument_type& T) {
		execute<QueryHelperType> (T);
	}

	template<class QueryHelperType>
	void execute (argument_type& T, typename boost::enable_if<boost::is_base_of<QueryHelperWithoutResult, QueryHelperType> >::type* = 0) {
		pqxx::result result = T.exec (m_query.get_query ());
	}

	template<class QueryHelperType>
	void execute (argument_type& T, typename boost::enable_if<boost::is_base_of<QueryHelperWithResult, QueryHelperType> >::type* = 0) {
		pqxx::result result = T.exec (m_query.get_query ());
		m_query.post_execute (result);
	}

	template<class QueryHelperType>
	void execute (argument_type& T, typename boost::enable_if<boost::is_same<UpsertQueryHelper, QueryHelperType> >::type* = 0) {
		pqxx::result result = T.exec (m_query.update_part ().get_query ());
		if (result.empty ()) {
			T.exec (m_query.insert_part ().get_query ());
		}
	}

private:
	QueryHelperType& m_query;
};

template<class QueryHelperType>
void execute_query_helper_without_catching_exceptions (QueryHelperType& query) {
	postgres::execute (ThrowingTransactorWithQueryHelper<QueryHelperType> (query));
}

}

#endif
