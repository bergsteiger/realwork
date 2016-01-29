////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// Основное меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for SectionItem
SectionItem* SectionItemFactory::make (
	const GblPilot::SectionItem& section_item
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SectionItemFactoryManager::Singleton::instance ()->make (section_item);
}

// factory interface wrapper for Section
const Section& SectionFactory::make (SectionType key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SectionFactoryManager::Singleton::instance ()->make (key);
}


SectionFactory::KeySet* SectionFactory::keys () {
	return SectionFactoryManager::keys ();
}

// factory interface wrapper for MainMenu
MainMenu& MainMenuFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MainMenuFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

