////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypesLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocalFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for DataReadingStream
DataReadingStream* DataReadingStreamFactory::make (
	GslDataPipe::DataReading* data_reading
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DataReadingStreamFactoryManager::Singleton::instance ()->make (data_reading);
}


Interval::Interval (unsigned long redaction)
//#UC START# *4610C4970138_INIT_CTOR_BASE_INIT*
: redaction (redaction), interval (0)
//#UC END# *4610C4970138_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4610C4970138_CTOR_BODY*
	//#UC END# *4610C4970138_CTOR_BODY*
}
// factory interface wrapper for MemoryStream
MemoryStream* MemoryStreamFactory::make (
	const OctetSeq& data
	, bool with_copy
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MemoryStreamFactoryManager::Singleton::instance ()->make (data, with_copy);
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

