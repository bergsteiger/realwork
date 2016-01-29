////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/PropertyHelperImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::PropertyHelperImpl
// Заголовк реализации фабрик интерфеса PropertyHelper для серванта PropertyHelperImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_PROPERTYHELPERIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_PROPERTYHELPERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"

namespace RoseModelImpl {

/// Interface-factory implementation for PropertyHelperImpl
class PropertyHelperImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public PropertyHelperAbstractFactory
{
public:
	PropertyHelperImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	PropertyHelper* get ();

};

typedef ::Core::Var<PropertyHelperImpl_factory> PropertyHelperImpl_factory_var;

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_PROPERTYHELPERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

