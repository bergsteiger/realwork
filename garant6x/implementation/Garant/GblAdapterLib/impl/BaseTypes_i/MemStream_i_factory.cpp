////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/MemStream_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::MemStream_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/MemStream_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/MemStream_i.h"

namespace GblAdapterLib {

MemStream_i_factory::MemStream_i_factory () {
}

void MemStream_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MemoryStreamFactoryManager::register_factory (this, priority);
}

const char* MemStream_i_factory::key () const {
	return "MemStream_i";
}

MemoryStream* MemStream_i_factory::make (const OctetSeq& data, bool with_copy) {
	MemStream_i_var ret = new MemStream_i (data, with_copy);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

