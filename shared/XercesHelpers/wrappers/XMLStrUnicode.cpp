////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/XercesHelpers/wrappers/XMLStrUnicode.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::XercesHelpers::wrappers::XMLStrUnicode
//
// обёртка для юникодной строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/XercesHelpers/wrappers/XMLStrUnicode.h"
// by <<uses>> dependencies
#include "shared/XercesHelpers/wrappers/XercesHelper.h"

//#UC START# *491C2FD2018D_CUSTOM_INCLUDES*
//#UC END# *491C2FD2018D_CUSTOM_INCLUDES*

namespace XercesHelpers {

//#UC START# *491C2FD2018D*
//#UC END# *491C2FD2018D*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

XMLStrUnicode::XMLStrUnicode ()
//#UC START# *49212E1700EA_BASE_INIT*
: m_data (0)
//#UC END# *49212E1700EA_BASE_INIT*
{
	//#UC START# *49212E1700EA_BODY*
	//#UC END# *49212E1700EA_BODY*
}

XMLStrUnicode::XMLStrUnicode (const char* data)
//#UC START# *49212E250083_BASE_INIT*
//#UC END# *49212E250083_BASE_INIT*
{
	//#UC START# *49212E250083_BODY*
	m_data = XercesHelper::instance ()->get_string (data);
	//#UC END# *49212E250083_BODY*
}

XMLStrUnicode::~XMLStrUnicode () {
	//#UC START# *491C2FD2018D_DESTR_BODY*
	delete[] m_data;
	//#UC END# *491C2FD2018D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// получить юникодное представление
const XMLCh* XMLStrUnicode::data () const {
	//#UC START# *49212E9C02A4*
	return m_data; 
	//#UC END# *49212E9C02A4*
}

// инициализация обёртки данными
void XMLStrUnicode::init (const char* data) {
	//#UC START# *49212E5A02F5*
	//GDS_ASSERT (!m_data);
	delete[] m_data;
	m_data = XercesHelper::instance ()->get_string (data);
	//#UC END# *49212E5A02F5*
}

// инициализирована ли строка данными
bool XMLStrUnicode::is_valid () const {
	//#UC START# *49212EC101A7*
	return m_data; 
	//#UC END# *49212EC101A7*
}

} // namespace XercesHelpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

