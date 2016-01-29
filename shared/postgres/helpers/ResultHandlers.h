#ifndef POSTGRES_HELPER_RESULT_HANDLERS_H_INCLUDED
#define POSTGRES_HELPER_RESULT_HANDLERS_H_INCLUDED

#include <string>

#include "shared/Core/GDS/ObjectCounter.h"

namespace pqxx {
	class result;
}

namespace postgres {

class QueryResultHandler {
	SET_OBJECT_COUNTER (QueryResultHandler);
public:
	virtual void result_handler (pqxx::result& result) = 0;
};

template<typename FieldType>
class FieldResultHandler : public QueryResultHandler {
public:
	FieldResultHandler () : m_empty_result (true) {
	}

	void result_handler (pqxx::result& result) {
		GDS_ASSERT (result.size () < 2);

		if (!result.empty ()) {
			m_empty_result = !result.at (0).at (0).to (m_result);
		}
	}

	const FieldType& get_result () const {
		GDS_ASSERT (!m_empty_result);

		return m_result;
	}

	bool empty_result () const {
		return m_empty_result;
	}

private:
	FieldType m_result;
	bool m_empty_result;
};

typedef FieldResultHandler<unsigned long> IDResultHandler;
typedef FieldResultHandler<unsigned long> UnsignedResultHandler;

}

#endif
