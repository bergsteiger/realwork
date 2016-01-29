////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Tips_i::TipsManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsManager_i.h"

namespace GblAdapterLib {

TipsManager_i_factory::TipsManager_i_factory () {
}

void TipsManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TipsManagerFactoryManager::register_factory (this, priority);
}

const char* TipsManager_i_factory::key () const {
	return "TipsManager_i";
}

TipsManager* TipsManager_i_factory::make () {
	return Core::IObject::_duplicate (TipsManager_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

