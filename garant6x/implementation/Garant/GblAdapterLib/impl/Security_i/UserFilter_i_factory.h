////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserFilter_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserFilter_i
// Заголовк реализации фабрик интерфеса UserFilter для серванта UserFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/Security_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for UserFilter_i
class UserFilter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public UserFilterAbstractFactory {
public:
	UserFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	UserFilter* make ();

};

typedef ::Core::Var<UserFilter_i_factory> UserFilter_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

