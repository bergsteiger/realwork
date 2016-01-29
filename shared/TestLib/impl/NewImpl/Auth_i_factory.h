////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/TestLib/impl/NewImpl/Auth_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::TestLib::NewImpl::Auth_i
// Заголовк реализации фабрик интерфеса Authenticator для серванта Auth_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_TESTLIB_NEWIMPL_AUTH_I_FCTR_H__
#define __SHARED_TESTLIB_NEWIMPL_AUTH_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecurityComm/SecurityCommFactories.h"

namespace TestLib {
namespace NewImpl {

/// Interface-factory implementation for Auth_i
class Auth_i_factory: virtual public ::Core::RefCountObjectBase, virtual public CoreSrv::AuthenticatorAbstractFactory {
public:
	Auth_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	CoreSrv::Authenticator* get ();

};

typedef ::Core::Var<Auth_i_factory> Auth_i_factory_var;

} // namespace NewImpl
} // namespace TestLib


#endif //__SHARED_TESTLIB_NEWIMPL_AUTH_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

