////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::ExternalObject_i
// �������� ���������� ������ ��������� ExternalObject ��� �������� ExternalObject_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALOBJECT_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALOBJECT_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObjectFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ExternalObject_i
class ExternalObject_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ExternalObjectAbstractFactory
{
public:
	ExternalObject_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ExternalObject* make ();

	ExternalObject* make (GblPilot::InternalObj* obj);

};

typedef ::Core::Var<ExternalObject_i_factory> ExternalObject_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALOBJECT_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

