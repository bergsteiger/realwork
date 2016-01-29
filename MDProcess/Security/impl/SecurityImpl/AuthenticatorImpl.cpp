////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/Security/impl/SecurityImpl/AuthenticatorImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::Security::SecurityImpl::AuthenticatorImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/Security/LibHome.h"
#include "MDProcess/Security/impl/SecurityImpl/AuthenticatorImpl.h"
// by <<uses>> dependencies
#include "MDProcess/ServerGate/Users/Users.h"

namespace Security {
namespace SecurityImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AuthenticatorImpl::AuthenticatorImpl ()
//#UC START# *45E85A0B0271_45E863D5032C_4614E35702DE_BASE_INIT*
//#UC END# *45E85A0B0271_45E863D5032C_4614E35702DE_BASE_INIT*
{
	//#UC START# *45E85A0B0271_45E863D5032C_4614E35702DE_BODY*
	//#UC END# *45E85A0B0271_45E863D5032C_4614E35702DE_BODY*
}

AuthenticatorImpl::~AuthenticatorImpl () {
	//#UC START# *4614E35702DE_DESTR_BODY*
	//#UC END# *4614E35702DE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from CoreSrv::Authenticator
// вторизация, в случае успеха должнга вернуть данные профайла с соотвествующими идентификатором
// пользователя и типом. Иначе исключение
CoreSrv::ProfileData* AuthenticatorImpl::authentication (
	const char* login
	, const char* pswd
) const /*throw (
	CoreSrv::AccessDenied
)*/ {
	//#UC START# *45E85A8E0290_4614E35702DE*
	CoreSrv::UserID uid = 0;
	try {
		ServerGate::Users::Accessor_var a = ServerGate::Users::AccessorFactory::make ();
		uid = a->authenticate (login, pswd);
	} CATCH_AND_LOG ("in AuthenticatorSrv::authentication")

	if (0 == uid) {
		throw CoreSrv::AccessDenied ();
	}

	CoreSrv::ProfileData* ret = new CoreSrv::ProfileData ();
	ret->uid = uid;
	ret->type = CoreSrv::PT_REGULAR;
	return ret;
	//#UC END# *45E85A8E0290_4614E35702DE*
}
} // namespace SecurityImpl
} // namespace Security

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

