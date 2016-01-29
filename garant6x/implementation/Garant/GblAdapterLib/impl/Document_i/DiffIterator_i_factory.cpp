////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffIterator_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DiffIterator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffIterator_i.h"

namespace GblAdapterLib {

DiffIterator_i_factory::DiffIterator_i_factory () {
}

void DiffIterator_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DiffIteratorFactoryManager::register_factory (this, priority);
}

const char* DiffIterator_i_factory::key () const {
	return "DiffIterator_i";
}

DiffIterator* DiffIterator_i_factory::make (const GblPilot::DiffData& diff_data) {
	DiffIterator_i_var ret = new DiffIterator_i (diff_data);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

