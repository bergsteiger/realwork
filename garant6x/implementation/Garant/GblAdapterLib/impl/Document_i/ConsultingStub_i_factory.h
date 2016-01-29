////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStub_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ConsultingStub_i
// �������� ���������� ������ ��������� ConsultingStub ��� �������� ConsultingStub_i
//
// �������� ��� ���������-������������ �259180433
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTUB_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTUB_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ConsultingStub_i
class ConsultingStub_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ConsultingStubAbstractFactory
{
public:
	ConsultingStub_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ConsultingStub* make_consulting_stub ();

};

typedef ::Core::Var<ConsultingStub_i_factory> ConsultingStub_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTUB_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

