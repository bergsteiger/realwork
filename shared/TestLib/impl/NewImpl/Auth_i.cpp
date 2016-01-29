////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/TestLib/impl/NewImpl/Auth_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::TestLib::NewImpl::Auth_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/TestLib/LibHome.h"
#include "shared/TestLib/impl/NewImpl/Auth_i.h"

namespace TestLib {
namespace NewImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Auth_i::Auth_i ()
//#UC START# *45E85A0B0271_45E863D5032C_45E867F4031C_BASE_INIT*
//#UC END# *45E85A0B0271_45E863D5032C_45E867F4031C_BASE_INIT*
{
	//#UC START# *45E85A0B0271_45E863D5032C_45E867F4031C_BODY*
	//#UC END# *45E85A0B0271_45E863D5032C_45E867F4031C_BODY*
}

Auth_i::~Auth_i () {
	//#UC START# *45E867F4031C_DESTR_BODY*
	//#UC END# *45E867F4031C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from CoreSrv::Authenticator
// вторизация, в случае успеха должнга вернуть данные профайла с соотвествующими идентификатором
// пользователя и типом. Иначе исключение
CoreSrv::ProfileData* Auth_i::authentication (
	const char* login
	, const char* pswd
) const /*throw (
	CoreSrv::AccessDenied
)*/ {
	//#UC START# *45E85A8E0290_45E867F4031C*
	Core::Aptr<CoreSrv::ProfileData> ret = new CoreSrv::ProfileData;
	ret->uid = 1;
	ret->type = CoreSrv::PT_MULTIPLE;
	return ret._retn();
	//#UC END# *45E85A8E0290_45E867F4031C*
}
} // namespace NewImpl
} // namespace TestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

