////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeQueryCard_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AttributeQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeQueryCard.h"

namespace GblAdapterLib {

AttributeQueryCard_factory::AttributeQueryCard_factory () {
}

void AttributeQueryCard_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryCardInfoFactoryManager::register_factory (this, priority);
}

const char* AttributeQueryCard_factory::key () const {
	return "QCT_ATTRIBUTE";
}

QueryCardInfo* AttributeQueryCard_factory::create () {
	return Core::IObject::_duplicate (AttributeQueryCard::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

