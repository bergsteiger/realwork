#ifndef POSTGRES_HELPER_QUERY_HELPER_H_INCLUDED
#define POSTGRES_HELPER_QUERY_HELPER_H_INCLUDED

#include <string>
#include <vector>

#include "shared/Core/GDS/ObjectCounter.h"

#include "shared/postgres/helpers/Mixins.h"
#include "shared/postgres/helpers/ResultHandlers.h"
#include "shared/postgres/helpers/QuoteHelper.h"

namespace postgres {

class QueryHelperWithoutResult {
};

class QueryHelperWithResult {
};

class BaseQueryHelper {
protected:
	BaseQueryHelper (const std::string& table) : m_table (table) {
	}

	const std::string& get_table_name () const {
		return m_table;
	}

private:
	std::string m_table;

private:
	static void* operator new (size_t size);
	static void operator delete (void* ptr);
};

class InsertQueryHelper : public BaseQueryHelper, public QueryHelperWithoutResult, public DataMixin {
public:
	InsertQueryHelper (const std::string& table);

	std::string get_query () const;
};

class QueryHelperReturningID : public BaseQueryHelper, public QueryHelperWithResult {
public:
	QueryHelperReturningID (const std::string& table, const std::string& field_to_return);

	void post_execute (pqxx::result& result);

	unsigned long get_returned_id () const;
	bool empty_result () const;

protected:
	const std::string& value_to_return () const;

private:
	IDResultHandler m_result_handler;
	std::string m_value_to_return;
};

class InsertQueryHelperReturningID : public QueryHelperReturningID, public DataMixin {
public:
	InsertQueryHelperReturningID (const std::string& table, const std::string& field_to_return);

	std::string get_query () const;
};

class UpdateQueryHelper : public BaseQueryHelper, public QueryHelperWithoutResult, public DataMixin, public WhereMixin {
public:
	UpdateQueryHelper (const std::string& table);

	std::string get_query () const;
};

class UpdateQueryHelperReturningID : public QueryHelperReturningID, public DataMixin, public WhereMixin {
public:
	UpdateQueryHelperReturningID (const std::string& table, const std::string& field_to_return);

	std::string get_query () const;
};


class DeleteQueryHelper : public BaseQueryHelper, public QueryHelperWithoutResult, public WhereMixin {
public:
	DeleteQueryHelper (const std::string& table);

	std::string get_query () const;
};

class BaseSelectQueryHelper : public WhereMixin {
public:
	BaseSelectQueryHelper (const std::string& what);

	void add_order_clause (const std::string& sort_sequence);
	void add_limit_clause (size_t limit);

protected:
	const std::string& what () const;
	const std::string& sort_sequence () const;
	const std::string& limit () const;

private:
	std::string m_what;
	std::string m_sort_sequence;
	std::string m_limit;
};

class SelectSubQueryHelper : public BaseQueryHelper, public BaseSelectQueryHelper {
public:
	SelectSubQueryHelper (const std::string& table, const std::string& what);

	std::string get_query_without_ending_semi () const;

	std::string get_query () const;
};

template<class ResultHandler>
class SelectQueryHelper : public BaseQueryHelper, public QueryHelperWithResult, public BaseSelectQueryHelper {
public:
	SelectQueryHelper (const std::string& table, ResultHandler& handler, const std::string& what) 
		: BaseQueryHelper (table), BaseSelectQueryHelper (what), m_result_handler (handler)
	{
	}

	std::string get_query () const {
		return "SELECT " + this->what ()
			+ " FROM " + this->get_table_name () 
			+ this->get_where_clause () + this->sort_sequence () + this->limit () + ";";
	}

	void post_execute (pqxx::result& result) {
		m_result_handler.result_handler (result);
	}

private:
	ResultHandler& m_result_handler;
};

class UpsertQueryHelper : public BaseQueryHelper {
public:
	UpsertQueryHelper (const std::string& table, const std::string& field_to_return);

	UpdateQueryHelperReturningID& update_part ();
	InsertQueryHelper& insert_part ();

private:
	UpdateQueryHelperReturningID m_update_part;
	InsertQueryHelper m_insert_part;
};

}

#endif
