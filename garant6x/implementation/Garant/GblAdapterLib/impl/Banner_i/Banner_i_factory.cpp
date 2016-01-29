////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Banner_i/Banner_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Banner_i::Banner_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Banner_i/Banner_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Banner_i/Banner_i.h"

namespace GblAdapterLib {

Banner_i_factory::Banner_i_factory () {
}

void Banner_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	BannerFactoryManager::register_factory (this, priority);
}

const char* Banner_i_factory::key () const {
	return "Banner_i";
}

Banner* Banner_i_factory::make () /*throw (CanNotFindData)*/ {
	Banner_i_var ret = new Banner_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

