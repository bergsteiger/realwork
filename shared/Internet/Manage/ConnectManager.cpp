////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/Manage/ConnectManager.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Internet::Manage::ConnectManager
//
// Менеджер для создания и управления соединением
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/Manage/ConnectManager.h"

namespace Internet {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConnectManager::ConnectManager ()
//#UC START# *4AC5E9C401DE_BASE_INIT*
//#UC END# *4AC5E9C401DE_BASE_INIT*
{
	//#UC START# *4AC5E9C401DE_BODY*
	m_connect = 0;
	//#UC END# *4AC5E9C401DE_BODY*
}

ConnectManager::~ConnectManager () {
	//#UC START# *4AC23EBC015E_DESTR_BODY*
	//#UC END# *4AC23EBC015E_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// вернуть интерфейс коннекта
IConnect* ConnectManager::get_connect () {
	//#UC START# *4AC24009030D*
	return (m_connect.is_nil ())? 0 : IConnect::_duplicate (m_connect.in ());
	//#UC END# *4AC24009030D*
}

// инициализация
void ConnectManager::init (const InternetAccessInfo& info, bool is_reconnect) {
	//#UC START# *4AC23F8301D2*
	if (m_connect.is_nil ()) {
		m_connect = IConnectFactory::make (info);
	} else if (is_reconnect) {
		m_connect->reset (info);
	}
	//#UC END# *4AC23F8301D2*
}

} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

