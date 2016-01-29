////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Session_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::Session_i
// Заголовк реализации фабрик интерфеса Session для серванта Session_i
//
// заглушка для получения идентификатора пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_SESSION_I_FCTR_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_SESSION_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

/// Interface-factory implementation for Session_i
class Session_i_factory: virtual public ::Core::RefCountObjectBase, virtual public CoreSrv::SessionAbstractFactory {
public:
	Session_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	CoreSrv::Session* get ();

};

typedef ::Core::Var<Session_i_factory> Session_i_factory_var;

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_SESSION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

