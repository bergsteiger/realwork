////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Queries_i/Query_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Queries_i::Query_i
//
// Реализация интерфейса запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Queries_i/Query_i.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/classification.hpp"

namespace Search {
namespace Queries_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Query_i::Query_i (const std::string& type, const std::string& str)
//#UC START# *509D3C7D016D_BASE_INIT*
	: m_data (str)
	, m_type (type)
//#UC END# *509D3C7D016D_BASE_INIT*
{
	//#UC START# *509D3C7D016D_BODY*
	if (type == BODY_TYPE || type == TITLE_TYPE) {
		std::replace_if (m_data.begin (), m_data.end (), boost::is_any_of ("()"), ' ');
	}
	//#UC END# *509D3C7D016D_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IQuery
// данные
const std::string& Query_i::get_data () const {
	//#UC START# *50D4894A0101_509D3C1F029F*
	return m_data;
	//#UC END# *50D4894A0101_509D3C1F029F*
}

// implemented method from IQuery
// тип
const std::string& Query_i::get_type () const {
	//#UC START# *50A4D98F0266_509D3C1F029F*
	GDS_ASSERT (!m_type.empty ());
	return m_type;
	//#UC END# *50A4D98F0266_509D3C1F029F*
}
} // namespace Queries_i
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

