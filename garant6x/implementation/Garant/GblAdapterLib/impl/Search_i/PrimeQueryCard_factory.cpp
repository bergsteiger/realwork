////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PrimeQueryCard_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::PrimeQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PrimeQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PrimeQueryCard.h"

namespace GblAdapterLib {

PrimeQueryCard_factory::PrimeQueryCard_factory () {
}

void PrimeQueryCard_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryCardInfoFactoryManager::register_factory (this, priority);
}

const char* PrimeQueryCard_factory::key () const {
	return "QCT_PRIME";
}

QueryCardInfo* PrimeQueryCard_factory::create () {
	return Core::IObject::_duplicate (PrimeQueryCard::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

