////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/IO_i/Stream_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::Stream_i
// �������� ���������� ������ ��������� Stream ��� �������� Stream_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_I_STREAM_I_FCTR_H__
#define __SHARED_GCI_IO_I_STREAM_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IOFactories.h"

namespace GCI {
namespace IO_i {

/// Interface-factory implementation for Stream_i
class Stream_i_factory: virtual public ::Core::RefCountObjectBase, virtual public IO::StreamAbstractFactory {
public:
	Stream_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IO::Stream* make ();

	IO::Stream* make (const char* path);

};

typedef ::Core::Var<Stream_i_factory> Stream_i_factory_var;

} // namespace IO_i
} // namespace GCI


#endif //__SHARED_GCI_IO_I_STREAM_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

