////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/MainMenu_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::MainMenu_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/MainMenu_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/MainMenu_i.h"

namespace GblAdapterLib {

MainMenu_i_factory::MainMenu_i_factory () {
}

void MainMenu_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MainMenuFactoryManager::register_factory (this, priority);
}

const char* MainMenu_i_factory::key () const {
	return "MainMenu_i";
}

MainMenu* MainMenu_i_factory::make () {
	MainMenu_i_var ret = new MainMenu_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

