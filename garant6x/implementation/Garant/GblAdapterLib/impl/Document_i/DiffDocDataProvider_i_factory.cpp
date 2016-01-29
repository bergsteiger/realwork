////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffDocDataProvider_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DiffDocDataProvider_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffDocDataProvider_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffDocDataProvider_i.h"

namespace GblAdapterLib {

DiffDocDataProvider_i_factory::DiffDocDataProvider_i_factory () {
}

void DiffDocDataProvider_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DiffDocDataProviderFactoryManager::register_factory (this, priority);
}

const char* DiffDocDataProvider_i_factory::key () const {
	return "DiffDocDataProvider_i";
}

DiffDocDataProvider* DiffDocDataProvider_i_factory::make (
	const Document* left
	, const Document* right
) /*throw (
	AllChangesInTables
)*/ {
	DiffDocDataProvider_i_var ret = new DiffDocDataProvider_i (left, right);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

