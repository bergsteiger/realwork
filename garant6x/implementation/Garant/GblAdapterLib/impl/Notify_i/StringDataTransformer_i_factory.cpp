////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/StringDataTransformer_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::StringDataTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/StringDataTransformer_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/StringDataTransformer_i.h"

namespace GblAdapterLib {

StringDataTransformer_i_factory::StringDataTransformer_i_factory () {
}

void StringDataTransformer_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DataTransformerFactoryManager::register_factory (this, priority);
}

const char* StringDataTransformer_i_factory::key () const {
	return "string";
}

DataTransformer* StringDataTransformer_i_factory::make () {
	StringDataTransformer_i_var ret = new StringDataTransformer_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

