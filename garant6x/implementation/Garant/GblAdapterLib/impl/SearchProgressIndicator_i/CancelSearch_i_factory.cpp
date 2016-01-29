////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/SearchProgressIndicator_i/CancelSearch_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::SearchProgressIndicator_i::CancelSearch_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/SearchProgressIndicator_i/CancelSearch_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/SearchProgressIndicator_i/CancelSearch_i.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator_i {

CancelSearch_i_factory::CancelSearch_i_factory () {
}

void CancelSearch_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SearchProgressIndicator::CancelSearchFactoryManager::register_factory (this, priority);
}

const char* CancelSearch_i_factory::key () const {
	return "CancelSearch_i";
}

SearchProgressIndicator::CancelSearch* CancelSearch_i_factory::make (GblPilot::SearchManager* search_manager) {
	CancelSearch_i_var ret = new CancelSearch_i (search_manager);
	return ret._retn ();
}

} // namespace SearchProgressIndicator_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

