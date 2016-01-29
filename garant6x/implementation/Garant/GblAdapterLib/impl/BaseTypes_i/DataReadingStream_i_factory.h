////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/DataReadingStream_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::DataReadingStream_i
// �������� ���������� ������ ��������� DataReadingStream ��� �������� DataReadingStream_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_DATAREADINGSTREAM_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_DATAREADINGSTREAM_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocalFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseTypes_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for DataReadingStream_i
class DataReadingStream_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DataReadingStreamAbstractFactory
{
public:
	DataReadingStream_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DataReadingStream* make (GslDataPipe::DataReading* data_reading);

};

typedef ::Core::Var<DataReadingStream_i_factory> DataReadingStream_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_DATAREADINGSTREAM_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

