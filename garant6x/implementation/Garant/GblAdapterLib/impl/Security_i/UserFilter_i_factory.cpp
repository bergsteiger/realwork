////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserFilter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserFilter_i.h"

namespace GblAdapterLib {

UserFilter_i_factory::UserFilter_i_factory () {
}

void UserFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	UserFilterFactoryManager::register_factory (this, priority);
}

const char* UserFilter_i_factory::key () const {
	return "UserFilter_i";
}

UserFilter* UserFilter_i_factory::make () {
	UserFilter_i_var ret = new UserFilter_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

