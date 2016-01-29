#include "shared/Core/sys/std_inc.h"

#include "shared/GCL/str/str_conv.h"

#include "shared/postgres/helpers/Mixins.h"

namespace postgres {

DataMixin::DataMixin () {
}

void DataMixin::add_win1251_data (const std::string& name, const std::string& value) {
	this->add_data (name, GCL::win1251_to_utf8 (value));
}

const QueryData& DataMixin::get_data () const {
	return m_data;
}

void DataMixin::add_null_data (const std::string& name) {
	m_data.push_back (std::make_pair (name, "NULL"));
}


WhereMixin::WhereMixin () {
}

void WhereMixin::add_win1251_condition (
	const std::string& name
	, const std::string& value
	, ConditionConnectionOperator op
) {
	this->add_condition (name, GCL::win1251_to_utf8 (value), op);
}

void WhereMixin::add_null_condition (const std::string& name, ConditionConnectionOperator op) {
	this->make_condition_prefix (op);
	m_data += name + " IS NULL";
}

void WhereMixin::add_not_null_condition (const std::string& name, ConditionConnectionOperator op) {
	this->make_condition_prefix (op);
	m_data += name + " IS NOT NULL";
}

void WhereMixin::make_condition_prefix (ConditionConnectionOperator op) {
	if (m_data.empty ()) {
		m_data = " WHERE ";
	} else {
		m_data += this->get_connection_operator (op);
	}
}

void WhereMixin::add_subquery_condition (
	const std::string& name
	, const std::string& subquery
	, ConditionConnectionOperator op
) {
	this->make_condition_prefix (op);
	m_data += name + " IN ("  + subquery + ")";
}

void WhereMixin::add_raw_condition (const std::string& condition, ConditionConnectionOperator op) {
	this->make_condition_prefix (op);
	m_data += condition;
}

std::string WhereMixin::get_where_clause () const {
	return m_data;
}

const std::string& WhereMixin::get_connection_operator (ConditionConnectionOperator op) const {
	const static std::string default_operator (" AND ");
	const static std::string or_operator (" OR ");

	return (op == OR_OPERATOR) ? or_operator : default_operator;
}


}
