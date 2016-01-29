////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::DefaultValuesChangesIndicator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DefaultValuesChangesIndicator_i::DefaultValuesChangesIndicator_i (
	DefaultValuesChangesState state
	, const Configuration* configuration
)
//#UC START# *45EEDCDC02EE_45F11E8A00FA_45F11BCC0261_BASE_INIT*
	: m_state (state)
//	, m_configuration (Configuration::_duplicate (configuration))
//#UC END# *45EEDCDC02EE_45F11E8A00FA_45F11BCC0261_BASE_INIT*
{
	//#UC START# *45EEDCDC02EE_45F11E8A00FA_45F11BCC0261_BODY*
	//#UC END# *45EEDCDC02EE_45F11E8A00FA_45F11BCC0261_BODY*
}

DefaultValuesChangesIndicator_i::~DefaultValuesChangesIndicator_i () {
	//#UC START# *45F11BCC0261_DESTR_BODY*
	//#UC END# *45F11BCC0261_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const Configuration* DefaultValuesChangesIndicator_i::get_configuration () const {
	//#UC START# *45F1513C00DA_GET_ACCESSOR*
	return m_configuration._sretn ();
	//#UC END# *45F1513C00DA_GET_ACCESSOR*
}

DefaultValuesChangesState DefaultValuesChangesIndicator_i::get_state () const {
	//#UC START# *45F11BCC0266_GET_ACCESSOR*
	return m_state;
	//#UC END# *45F11BCC0266_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DefaultValuesChangesIndicator
Configuration* DefaultValuesChangesIndicator_i::get_configuration () {
	return const_cast<Configuration*>(((const DefaultValuesChangesIndicator_i*)this)->get_configuration ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

