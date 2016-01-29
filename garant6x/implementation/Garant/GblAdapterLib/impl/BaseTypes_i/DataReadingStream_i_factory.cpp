////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/DataReadingStream_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::DataReadingStream_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/DataReadingStream_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/DataReadingStream_i.h"

namespace GblAdapterLib {

DataReadingStream_i_factory::DataReadingStream_i_factory () {
}

void DataReadingStream_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DataReadingStreamFactoryManager::register_factory (this, priority);
}

const char* DataReadingStream_i_factory::key () const {
	return "DataReadingStream_i";
}

DataReadingStream* DataReadingStream_i_factory::make (GslDataPipe::DataReading* data_reading) {
	DataReadingStream_i_var ret = new DataReadingStream_i (data_reading);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

