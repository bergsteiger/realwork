////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionItem_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::SectionItem_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionItem_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionItem_i.h"

namespace GblAdapterLib {

SectionItem_i_factory::SectionItem_i_factory () {
}

void SectionItem_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SectionItemFactoryManager::register_factory (this, priority);
}

const char* SectionItem_i_factory::key () const {
	return "SectionItem_i";
}

SectionItem* SectionItem_i_factory::make (const GblPilot::SectionItem& section_item) {
	SectionItem_i_var ret = new SectionItem_i (section_item);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

