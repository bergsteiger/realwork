////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/RoseModelImpl/OverloadedItemImpl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::OverloadedItemImpl
// �������� ���������� ������ ��������� OverloadedItem ��� �������� OverloadedItemImpl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_OVERLOADEDITEMIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_OVERLOADEDITEMIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"

namespace RoseModelImpl {

/// Interface-factory implementation for OverloadedItemImpl
class OverloadedItemImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public OverloadedItemAbstractFactory
{
public:
	OverloadedItemImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	OverloadedItem* make (const std::string& uid, bool need_collect_child);

};

typedef ::Core::Var<OverloadedItemImpl_factory> OverloadedItemImpl_factory_var;

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_OVERLOADEDITEMIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

