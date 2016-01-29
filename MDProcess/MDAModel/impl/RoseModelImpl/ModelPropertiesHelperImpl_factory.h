////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ModelPropertiesHelperImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ModelPropertiesHelperImpl
// Заголовк реализации фабрик интерфеса ModelPropertiesHelper для серванта ModelPropertiesHelperImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELPROPERTIESHELPERIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELPROPERTIESHELPERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"

namespace RoseModelImpl {

/// Interface-factory implementation for ModelPropertiesHelperImpl
class ModelPropertiesHelperImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ModelPropertiesHelperAbstractFactory
{
public:
	ModelPropertiesHelperImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ModelPropertiesHelper* get ();

};

typedef ::Core::Var<ModelPropertiesHelperImpl_factory> ModelPropertiesHelperImpl_factory_var;

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELPROPERTIESHELPERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

