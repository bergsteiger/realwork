////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/DataReadingStream_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::DataReadingStream_i
// ��������� ���������� ������ �������� ��� ��������� DataReadingStream
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_DATAREADINGSTREAM_I_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_DATAREADINGSTREAM_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"
#include "garantServer/src/Services/GslDataPipe/GslDataPipeC.h"

namespace GblAdapterLib {

class DataReadingStream_i; // self forward Var
typedef ::Core::Var<DataReadingStream_i> DataReadingStream_i_var;
typedef ::Core::Var<const DataReadingStream_i> DataReadingStream_i_cvar;

class DataReadingStream_i_factory;

class DataReadingStream_i:
	virtual public DataReadingStream
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DataReadingStream_i)
	friend class DataReadingStream_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DataReadingStream_i (GslDataPipe::DataReading* data_reading);

	virtual ~DataReadingStream_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GslDataPipe::DataReading_var m_data_reading;

	unsigned long m_position;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GCI::IO::Stream
	// ���� ������������ true, ���������� ������ � ������� ����������
	virtual bool bad () const;

	// implemented method from GCI::IO::Stream
	// ������ ����� ������
	virtual void clear ();

	// implemented method from GCI::IO::Stream
	// �������� ������ �� ������ ������ � ������.
	virtual void copy_to (
		GCI::IO::Stream* dst
		, unsigned long size
		, unsigned long long& actually_read
		, unsigned long long& actually_written
	) /*throw (
		GCI::IO::OperationError
	)*/;

	// implemented method from GCI::IO::Stream
	// ������� ���������� true ���� ��������� ����� ������.
	virtual bool eof () const;

	// implemented method from GCI::IO::Stream
	// �������� ������ �� ������, ���������� ���������� ����������� ������.
	virtual unsigned long read (void* buffer, unsigned long size) /*throw (GCI::IO::OperationError)*/;

	// implemented method from GCI::IO::Stream
	// ����������� ������ ������. ���������� ����� ���� �� ������ ������.
	virtual unsigned long seek (
		long offset
		, unsigned long whence
	) /*throw (
		GCI::IO::OperationError
		, GCI::IO::NotImplemented
	)*/;

	// implemented method from GCI::IO::Stream
	// �������� ������ � �����. ���������� ���������� ���������� ������.
	virtual unsigned long write (const void* buffer, unsigned long size);
}; // class DataReadingStream_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_DATAREADINGSTREAM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
