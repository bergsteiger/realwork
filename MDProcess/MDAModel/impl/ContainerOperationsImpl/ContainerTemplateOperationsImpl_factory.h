////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerTemplateOperationsImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ContainerOperationsImpl::ContainerTemplateOperationsImpl
// Заголовк реализации фабрик интерфеса ContainerTemplateOperations для серванта ContainerTemplateOperationsImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_CONTAINERTEMPLATEOPERATIONSIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_CONTAINERTEMPLATEOPERATIONSIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperationsFactories.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerOperationsImpl.h"

namespace ContainerOperationsImpl {

/// Interface-factory implementation for ContainerTemplateOperationsImpl
class ContainerTemplateOperationsImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ContainerOperations::ContainerTemplateOperationsAbstractFactory
{
public:
	ContainerTemplateOperationsImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ContainerOperations::ContainerTemplateOperations* get ();

};

typedef ::Core::Var<ContainerTemplateOperationsImpl_factory> ContainerTemplateOperationsImpl_factory_var;

} // namespace ContainerOperationsImpl


#endif //__MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_CONTAINERTEMPLATEOPERATIONSIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

