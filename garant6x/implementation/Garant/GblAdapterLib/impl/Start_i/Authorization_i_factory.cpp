////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Authorization_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::Authorization_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Authorization_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Authorization_i.h"

namespace GblAdapterLib {

Authorization_i_factory::Authorization_i_factory () {
}

void Authorization_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	AuthorizationFactoryManager::register_factory (this, priority);
}

const char* Authorization_i_factory::key () const {
	return "Authorization_i";
}

Authorization* Authorization_i_factory::make () /*throw (XMLImportRunning)*/ {
	Authorization_i_var ret = new Authorization_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

