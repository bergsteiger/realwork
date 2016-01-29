////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::InheritedItemHelperImpl
// Заголовк реализации фабрик интерфеса InheritedItemHelper для серванта InheritedItemHelperImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMHELPERIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMHELPERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"

namespace RoseModelImpl {

/// Interface-factory implementation for InheritedItemHelperImpl
class InheritedItemHelperImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public InheritedItemHelperAbstractFactory
{
public:
	InheritedItemHelperImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	InheritedItemHelper* get ();

};

typedef ::Core::Var<InheritedItemHelperImpl_factory> InheritedItemHelperImpl_factory_var;

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMHELPERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

