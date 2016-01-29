#ifndef POSTGRES_HELPER_MIXINS_H_INCLUDED
#define POSTGRES_HELPER_MIXINS_H_INCLUDED

#include <string>
#include <vector>
#include <utility>

#include "shared/postgres/helpers/QuoteHelper.h"

namespace postgres {

typedef std::pair<std::string, std::string> NameValuePair;
typedef std::vector<NameValuePair> QueryData;

class DataMixin {
public:
	template<typename ValueType>
	void add_data (const std::string& name, const ValueType& value) {
		m_data.push_back (std::make_pair (name, postgres::quote (value)));
	}
	void add_win1251_data (const std::string& name, const std::string& value);
	void add_null_data (const std::string& name);

protected:
	const QueryData& get_data () const;

private:
	QueryData m_data;

protected:
	DataMixin ();
};

enum ConditionConnectionOperator {
	DEFAULT_OPERATOR
	, OR_OPERATOR
};

class WhereMixin {
public:
	template<typename ValueType>
	void add_condition (
		const std::string& name
		, const ValueType& value
		, ConditionConnectionOperator op = DEFAULT_OPERATOR
	) {
		this->make_condition_prefix (op);
		m_data += name + " = " + postgres::quote (value);
	}

	void add_win1251_condition (
		const std::string& name
		, const std::string& value
		, ConditionConnectionOperator op = DEFAULT_OPERATOR
	);

	void add_null_condition (const std::string& name, ConditionConnectionOperator op = DEFAULT_OPERATOR);
	void add_not_null_condition (const std::string& name, ConditionConnectionOperator op = DEFAULT_OPERATOR);

	void add_subquery_condition (
		const std::string& name
		, const std::string& subquery
		, ConditionConnectionOperator op = DEFAULT_OPERATOR
	);

	void add_raw_condition (const std::string& condition, ConditionConnectionOperator op = DEFAULT_OPERATOR);

	std::string get_where_clause () const;

private:
	const std::string& get_connection_operator (ConditionConnectionOperator op) const;
	void make_condition_prefix (ConditionConnectionOperator op);

private:
	std::string m_data;

protected:
	WhereMixin ();
};

}

#endif
