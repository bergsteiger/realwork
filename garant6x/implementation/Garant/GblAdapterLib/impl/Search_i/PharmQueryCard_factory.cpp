////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PharmQueryCard_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::PharmQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PharmQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PharmQueryCard.h"

namespace GblAdapterLib {

PharmQueryCard_factory::PharmQueryCard_factory () {
}

void PharmQueryCard_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryCardInfoFactoryManager::register_factory (this, priority);
}

const char* PharmQueryCard_factory::key () const {
	return "QCT_PHARM";
}

QueryCardInfo* PharmQueryCard_factory::create () {
	PharmQueryCard_var ret = new PharmQueryCard ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

