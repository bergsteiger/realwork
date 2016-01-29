////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ImplementedItemImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ImplementedItemImpl
// Заголовк реализации фабрик интерфеса ImplementedItem для серванта ImplementedItemImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_IMPLEMENTEDITEMIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_IMPLEMENTEDITEMIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"

namespace RoseModelImpl {

/// Interface-factory implementation for ImplementedItemImpl
class ImplementedItemImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ImplementedItemAbstractFactory
{
public:
	ImplementedItemImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ImplementedItem* make (const std::string& uid, bool need_collect_child);

};

typedef ::Core::Var<ImplementedItemImpl_factory> ImplementedItemImpl_factory_var;

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_IMPLEMENTEDITEMIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

