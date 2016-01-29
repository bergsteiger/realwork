////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/GenSupportImpl/EnvironmentImpl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::EnvironmentImpl
// �������� ���������� ������ ��������� Environment ��� �������� EnvironmentImpl
//
// ���������� ���������� ���������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ENVIRONMENTIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ENVIRONMENTIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"

namespace GenSupportImpl {

/// Interface-factory implementation for EnvironmentImpl
class EnvironmentImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public GenSupport::EnvironmentAbstractFactory
{
public:
	EnvironmentImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	GenSupport::Environment* get ();

};

typedef ::Core::Var<EnvironmentImpl_factory> EnvironmentImpl_factory_var;

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ENVIRONMENTIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

