////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/GenSupportImpl/DefaultLogManagerImpl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::DefaultLogManagerImpl
// �������� ���������� ������ ��������� LogManager ��� �������� DefaultLogManagerImpl
//
// ���������� ��������� ������������, ����� ��������� � ����. �������� � ���� � ��������� �� �
// �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_DEFAULTLOGMANAGERIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_DEFAULTLOGMANAGERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"

namespace GenSupportImpl {

/// Interface-factory implementation for DefaultLogManagerImpl
class DefaultLogManagerImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public GenSupport::LogManagerAbstractFactory
{
public:
	DefaultLogManagerImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	GenSupport::LogManager* get ();

};

typedef ::Core::Var<DefaultLogManagerImpl_factory> DefaultLogManagerImpl_factory_var;

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_DEFAULTLOGMANAGERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

