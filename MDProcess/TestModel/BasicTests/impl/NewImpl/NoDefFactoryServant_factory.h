////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NoDefFactoryServant_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::NewImpl::NoDefFactoryServant
// �������� ���������� ������ ��������� DerivedLocal ��� �������� NoDefFactoryServant
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWIMPL_NODEFFACTORYSERVANT_FCTR_H__
#define __TESTMODEL_BASICTESTS_NEWIMPL_NODEFFACTORYSERVANT_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImplFactories.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImpl.h"

namespace BasicTests {
namespace NewImpl {

/// Interface-factory implementation for NoDefFactoryServant
class NoDefFactoryServant_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DerivedLocalAbstractFactory
{
public:
	NoDefFactoryServant_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	NewInterfaces::DerivedInterface* factory ();

};

typedef ::Core::Var<NoDefFactoryServant_factory> NoDefFactoryServant_factory_var;

} // namespace NewImpl
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWIMPL_NODEFFACTORYSERVANT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

