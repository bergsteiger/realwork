////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/LongTransformer_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::LongTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/LongTransformer_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/LongTransformer_i.h"

namespace GblAdapterLib {

LongTransformer_i_factory::LongTransformer_i_factory () {
}

void LongTransformer_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DataTransformerFactoryManager::register_factory (this, priority);
}

const char* LongTransformer_i_factory::key () const {
	return "long";
}

DataTransformer* LongTransformer_i_factory::make () {
	LongTransformer_i_var ret = new LongTransformer_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

