#include "shared/Core/sys/std_inc.h"

#include "boost/foreach.hpp"
#include "boost/lexical_cast.hpp"

#include "shared/GCL/str/str_conv.h"

#include "shared/postgres/helpers/QueryHelper.h"

namespace postgres {

QueryHelperReturningID::QueryHelperReturningID (const std::string& table, const std::string& field_to_return)
	: BaseQueryHelper (table)
{
	GDS_ASSERT (!field_to_return.empty ());
	m_value_to_return = " RETURNING " + field_to_return;
}

void QueryHelperReturningID::post_execute (pqxx::result& result) {
	m_result_handler.result_handler (result);
}

const std::string& QueryHelperReturningID::value_to_return () const {
	return m_value_to_return;
}

bool QueryHelperReturningID::empty_result () const {
	return m_result_handler.empty_result ();
}

unsigned long QueryHelperReturningID::get_returned_id () const {
	return m_result_handler.get_result ();
}


InsertQueryHelper::InsertQueryHelper (const std::string& table) : BaseQueryHelper (table) {
}

std::string InsertQueryHelper::get_query () const {
	GDS_ASSERT (!this->get_data ().empty ());

	std::string header = "INSERT INTO " + this->get_table_name () + " ";
	std::string names = "(";
	std::string values = " VALUES (";

	BOOST_FOREACH (const NameValuePair& name_and_value, this->get_data ()) {
		names += name_and_value.first + ",";
		values += name_and_value.second + ",";
	}
	names[names.length () - 1] = ')';
	values[values.length () - 1] = ')';

	return header + names + values + ";";
}

InsertQueryHelperReturningID::InsertQueryHelperReturningID (const std::string& table, const std::string& field_to_return)
	: QueryHelperReturningID (table, field_to_return)
{
}

std::string InsertQueryHelperReturningID::get_query () const {
	GDS_ASSERT (!this->get_data ().empty ());

	std::string header = "INSERT INTO " + this->get_table_name () + " ";
	std::string names = "(";
	std::string values = " VALUES (";

	BOOST_FOREACH (const NameValuePair& name_and_value, this->get_data ()) {
		names += name_and_value.first + ",";
		values += name_and_value.second + ",";
	}
	names[names.length () - 1] = ')';
	values[values.length () - 1] = ')';

	return header + names + values + this->value_to_return () + ";";
}



DeleteQueryHelper::DeleteQueryHelper (const std::string& table) : BaseQueryHelper (table) {
}

std::string DeleteQueryHelper::get_query () const {
	return "DELETE FROM " + get_table_name () + this->get_where_clause () + ";";
}


UpdateQueryHelper::UpdateQueryHelper (const std::string& table) : BaseQueryHelper (table) {
}

std::string UpdateQueryHelper::get_query () const {
	std::string header = "UPDATE " + get_table_name () + " SET ";

	QueryData data = this->get_data ();
	GDS_ASSERT (!data.empty ());
	QueryData::const_iterator begin = data.begin ();
	QueryData::const_iterator end = data.end ();
	std::string set_part;
	for (QueryData::const_iterator it = begin; it != end; ++it) {
		set_part += it->first + " = " + it->second; 
		if (it != end - 1) {
			set_part += ", ";
		}
	}

	return header + set_part + this->get_where_clause () + ";";
}

UpdateQueryHelperReturningID::UpdateQueryHelperReturningID (const std::string& table, const std::string& field_to_return)
	: QueryHelperReturningID (table, field_to_return)
{
}

std::string UpdateQueryHelperReturningID::get_query () const {
	std::string header = "UPDATE " + get_table_name () + " SET ";

	QueryData data = this->get_data ();
	GDS_ASSERT (!data.empty ());
	QueryData::const_iterator begin = data.begin ();
	QueryData::const_iterator end = data.end ();
	std::string set_part;
	for (QueryData::const_iterator it = begin; it != end; ++it) {
		set_part += it->first + " = " + it->second; 
		if (it != end - 1) {
			set_part += ", ";
		}
	}

	return header + set_part + this->get_where_clause () + this->value_to_return () + ";";
}


BaseSelectQueryHelper::BaseSelectQueryHelper (const std::string& what) : m_what (what) {
}

void BaseSelectQueryHelper::add_order_clause (const std::string& sort_sequence) {
	m_sort_sequence = " ORDER BY " + sort_sequence;
}


void BaseSelectQueryHelper::add_limit_clause (size_t limit) {
	m_limit = " LIMIT " + boost::lexical_cast <std::string> (limit);
}

const std::string& BaseSelectQueryHelper::what () const {
	return m_what;
}

const std::string& BaseSelectQueryHelper::sort_sequence () const {
	return m_sort_sequence;
}

const std::string& BaseSelectQueryHelper::limit () const {
	return m_limit;
}

SelectSubQueryHelper::SelectSubQueryHelper (const std::string& table, const std::string& what)
  :  BaseQueryHelper (table), BaseSelectQueryHelper (what) 
{}

std::string SelectSubQueryHelper::get_query_without_ending_semi () const {
	return "SELECT " + this->what ()
		+ " FROM " + this->get_table_name () 
		+ this->get_where_clause () + this->sort_sequence () + this->limit ();
}

std::string SelectSubQueryHelper::get_query () const {
	return get_query_without_ending_semi () + ";";
}


UpsertQueryHelper::UpsertQueryHelper (const std::string& table, const std::string& field_to_return) 
	: BaseQueryHelper (table), m_update_part (table, field_to_return), m_insert_part (table) 
{
}

UpdateQueryHelperReturningID& UpsertQueryHelper::update_part () {
	return m_update_part;
}

InsertQueryHelper& UpsertQueryHelper::insert_part () {
	return m_insert_part;
}

}
