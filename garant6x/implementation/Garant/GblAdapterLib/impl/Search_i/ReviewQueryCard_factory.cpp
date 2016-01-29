////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ReviewQueryCard_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::ReviewQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ReviewQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ReviewQueryCard.h"

namespace GblAdapterLib {

ReviewQueryCard_factory::ReviewQueryCard_factory () {
}

void ReviewQueryCard_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryCardInfoFactoryManager::register_factory (this, priority);
}

const char* ReviewQueryCard_factory::key () const {
	return "QCT_REVIEW";
}

QueryCardInfo* ReviewQueryCard_factory::create () {
	ReviewQueryCard_var ret = new ReviewQueryCard ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

