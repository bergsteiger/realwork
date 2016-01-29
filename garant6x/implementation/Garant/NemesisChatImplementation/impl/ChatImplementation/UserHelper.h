////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UserHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garant6x::NemesisChatImplementation::ChatImplementation::UserHelper
//
// определение идентификатора пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_USERHELPER_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_USERHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"

//#UC START# *4A364A4E009C_CUSTOM_INCLUDES*
//#UC END# *4A364A4E009C_CUSTOM_INCLUDES*

namespace NemesisChatImplementation {
namespace ChatImplementation {

// определение идентификатора пользователя
class UserHelper {
	SET_OBJECT_COUNTER (UserHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// получить идентификатор пользователя
	static CoreSrv::UserID get_user_id ();

	// плучить информацию о пользователе
	static ChatLibrary::ChatService::UserInfo* get_user_info (CoreSrv::UserID user);

	// возвращает true, если пользователь есть в системе
	static CORBA::Boolean is_user_exists (CoreSrv::UserID user);


//#UC START# *4A364A4E009C*
//#UC END# *4A364A4E009C*
}; // class UserHelper

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_USERHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

