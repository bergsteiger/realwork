////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypesLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPESLOCAL_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPESLOCAL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Services/GslDataPipe/GslDataPipeC.h"
#include "shared/GCI/IO/IO.h"
#include "tao/ORB_Core.h"
#include "tao/Sequence_T.h"

namespace GblAdapterLib {

class DataReadingStream;
typedef ::Core::Var<DataReadingStream> DataReadingStream_var;
typedef ::Core::Var<const DataReadingStream> DataReadingStream_cvar;
// Поток для отдачи evd
class DataReadingStream
	: virtual public GCI::IO::Stream
{
};

/// factory interface for DataReadingStream
class DataReadingStreamFactory {
public:
	// фабрика
	static DataReadingStream* make (GslDataPipe::DataReading* data_reading)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// интервал дат
struct Interval {
	GblPilotDef::DocDate from;
	GblPilotDef::DocDate to;
	unsigned long redaction;
	unsigned long interval;

	Interval (unsigned long redaction);
};

#pragma pack (pop)

typedef TAO_Unbounded_Sequence< CORBA::Octet > OctetSeq;

class MemoryStream;
typedef ::Core::Var<MemoryStream> MemoryStream_var;
typedef ::Core::Var<const MemoryStream> MemoryStream_cvar;
// Позволяет получить интерфейс стрима, заточенный под правильное выделение памяти для документа
class MemoryStream
	: virtual public GCI::IO::Stream
{
};

/// factory interface for MemoryStream
class MemoryStreamFactory {
public:
	// фабрика
	static MemoryStream* make (const OctetSeq& data, bool with_copy)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DataReadingStream> {
	typedef GblAdapterLib::DataReadingStreamFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::MemoryStream> {
	typedef GblAdapterLib::MemoryStreamFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPESLOCAL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
