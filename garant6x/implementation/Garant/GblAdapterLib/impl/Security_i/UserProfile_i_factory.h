////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserProfile_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserProfile_i
// Заголовк реализации фабрик интерфеса UserProfile для серванта UserProfile_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERPROFILE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERPROFILE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/Security_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for UserProfile_i
class UserProfile_i_factory: virtual public ::Core::RefCountObjectBase, virtual public UserProfileAbstractFactory {
public:
	UserProfile_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	UserProfile* make (
		Uid uid
		, const char* login
		, const char* name
		, const char* mail
		, bool is_system
		, bool has_password
		, bool can_buy_consulting
		, bool is_permanent
	);

	UserProfile* make ();

};

typedef ::Core::Var<UserProfile_i_factory> UserProfile_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERPROFILE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

