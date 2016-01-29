////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Security_i/Session_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Security_i::Session_i
// Заголовк реализации фабрик интерфеса Session для серванта Session_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITY_I_SESSION_I_FCTR_H__
#define __SHARED_CORESRV_SECURITY_I_SESSION_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Security/SecurityFactories.h"

namespace CoreSrv {
namespace Security_i {

/// Interface-factory implementation for Session_i
class Session_i_factory: virtual public ::Core::RefCountObjectBase, virtual public SessionAbstractFactory {
public:
	Session_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Session* get ();

};

typedef ::Core::Var<Session_i_factory> Session_i_factory_var;

} // namespace Security_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_SECURITY_I_SESSION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

