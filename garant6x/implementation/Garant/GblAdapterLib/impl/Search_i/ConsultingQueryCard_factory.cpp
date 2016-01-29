////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ConsultingQueryCard_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::ConsultingQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ConsultingQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ConsultingQueryCard.h"

namespace GblAdapterLib {

ConsultingQueryCard_factory::ConsultingQueryCard_factory () {
}

void ConsultingQueryCard_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryCardInfoFactoryManager::register_factory (this, priority);
}

const char* ConsultingQueryCard_factory::key () const {
	return "QCT_CONSULTING";
}

QueryCardInfo* ConsultingQueryCard_factory::create () {
	ConsultingQueryCard_var ret = new ConsultingQueryCard ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

