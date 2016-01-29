////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/Configuration_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::Configuration_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/LibHome.h"
#include "shared/Core/impl/Root_i/Configuration_i.h"

namespace Core {
namespace Root_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Configuration_i::Configuration_i ()
//#UC START# *458EBECE021C_458EBEEB0122_458EC0D20299_BASE_INIT*
//#UC END# *458EBECE021C_458EBEEB0122_458EC0D20299_BASE_INIT*
{
	//#UC START# *458EBECE021C_458EBEEB0122_458EC0D20299_BODY*
#ifdef _DEBUG
	m_info.debug = true;
#else
	m_info.debug = false;
#endif
	
	m_info.use_corba = false;
	m_info.server_side = false;
	//#UC END# *458EBECE021C_458EBEEB0122_458EC0D20299_BODY*
}

Configuration_i::~Configuration_i () {
	//#UC START# *458EC0D20299_DESTR_BODY*
	//#UC END# *458EC0D20299_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает информацию от текущей конфигурации
Root::Info& Configuration_i::info () {
	//#UC START# *47C4FA1601DA*
	return m_info;
	//#UC END# *47C4FA1601DA*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Root::Configuration
// данные конфигруации
const Root::Info& Configuration_i::get_info () const {
	//#UC START# *458EBF680354_458EC0D20299_GET*
	return m_info;
	//#UC END# *458EBF680354_458EC0D20299_GET*
}
} // namespace Root_i
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

