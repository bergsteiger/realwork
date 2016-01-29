////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/AsVector_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Filters_i::AsVector_i
//
// Реализация интерфейса IFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Filters_i/AsVector_i.h"
// by <<uses>> dependencies
#include "boost/lambda/lambda.hpp"

namespace Search {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AsVector_i::AsVector_i (const SearchAdapterLib::Adapter::LongVector& in, MergeOp op)
//#UC START# *53D7AC1401DC_BASE_INIT*
	: m_pos (0)
	, m_data (in)
	, m_op (op)
//#UC END# *53D7AC1401DC_BASE_INIT*
{
	//#UC START# *53D7AC1401DC_BODY*
	//#UC END# *53D7AC1401DC_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContextSearch::Defs::IFilter
// check
bool AsVector_i::check (ContextSearch::Defs::DocId val) {
	//#UC START# *52F0DBCD0015_53D7AB8B02F0*
	if (m_pos < m_data.size ()) {
		SearchAdapterLib::Adapter::LongVector::const_iterator it, beg = m_data.begin () + m_pos;
		it = std::find_if (beg, m_data.end (), boost::lambda::_1 >= (long) val);
		m_pos += std::distance (beg, it);

		if (m_op == so_AND) {
			return (it != m_data.end () && *it == val);
		} else if (m_op == so_NOT) {
			return (it == m_data.end () || *it != val);
		}
	}

	return (m_op == so_NOT);
	//#UC END# *52F0DBCD0015_53D7AB8B02F0*
}

// implemented method from ContextSearch::Defs::IFilter
// check
bool AsVector_i::check () const {
	//#UC START# *54C79CD80220_53D7AB8B02F0*
	if (m_op == so_AND) {
		return m_pos < m_data.size ();
	} 
	return true;
	//#UC END# *54C79CD80220_53D7AB8B02F0*
}

// implemented method from ContextSearch::Defs::IFilter
// создать дубликат
ContextSearch::Defs::IFilter* AsVector_i::duplicate () {
	//#UC START# *55AE33BF00FA_53D7AB8B02F0*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *55AE33BF00FA_53D7AB8B02F0*
}

// implemented method from ContextSearch::Defs::IFilter
// logic op
char AsVector_i::get_op () const {
	//#UC START# *5346BB1D01FE_53D7AB8B02F0*
	return m_op;
	//#UC END# *5346BB1D01FE_53D7AB8B02F0*
}

// implemented method from ContextSearch::Defs::IFilter
// size
size_t AsVector_i::get_size () const {
	//#UC START# *530C97AC02C4_53D7AB8B02F0*
	return m_data.size ();
	//#UC END# *530C97AC02C4_53D7AB8B02F0*
}

// implemented method from ContextSearch::Defs::IFilter
// reset
void AsVector_i::reset () {
	//#UC START# *52FC982D009E_53D7AB8B02F0*
	m_pos = 0;
	//#UC END# *52FC982D009E_53D7AB8B02F0*
}

// implemented method from ContextSearch::Defs::IFilter
// type
const char* AsVector_i::type () const {
	//#UC START# *52FCA10A026E_53D7AB8B02F0*
	return "AsVector";
	//#UC END# *52FCA10A026E_53D7AB8B02F0*
}
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

