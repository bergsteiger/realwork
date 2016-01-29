////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/TestLib/impl/NewImpl/Auth_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::TestLib::NewImpl::Auth_i
// Заголовок реализации класса серванта для интерфеса Authenticator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_TESTLIB_NEWIMPL_AUTH_I_H__
#define __SHARED_TESTLIB_NEWIMPL_AUTH_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecurityComm/SecurityComm.h"

namespace TestLib {
namespace NewImpl {

class Auth_i; // self forward Var
typedef ::Core::Var<Auth_i> Auth_i_var;
typedef ::Core::Var<const Auth_i> Auth_i_cvar;

class Auth_i_factory;

class Auth_i:
	virtual public CoreSrv::Authenticator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Auth_i)
	friend class Auth_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Auth_i ();

	virtual ~Auth_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CoreSrv::Authenticator
	// вторизация, в случае успеха должнга вернуть данные профайла с соотвествующими идентификатором
	// пользователя и типом. Иначе исключение
	virtual CoreSrv::ProfileData* authentication (
		const char* login
		, const char* pswd
	) const /*throw (
		CoreSrv::AccessDenied
	)*/;
}; // class Auth_i

} // namespace NewImpl
} // namespace TestLib


#endif //__SHARED_TESTLIB_NEWIMPL_AUTH_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
