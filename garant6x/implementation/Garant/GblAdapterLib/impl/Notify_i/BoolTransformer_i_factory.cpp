////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/BoolTransformer_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::BoolTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/BoolTransformer_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/BoolTransformer_i.h"

namespace GblAdapterLib {

BoolTransformer_i_factory::BoolTransformer_i_factory () {
}

void BoolTransformer_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DataTransformerFactoryManager::register_factory (this, priority);
}

const char* BoolTransformer_i_factory::key () const {
	return "bool";
}

DataTransformer* BoolTransformer_i_factory::make () {
	BoolTransformer_i_var ret = new BoolTransformer_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

