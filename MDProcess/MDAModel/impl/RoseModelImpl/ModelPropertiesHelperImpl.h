////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ModelPropertiesHelperImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ModelPropertiesHelperImpl
// Заголовок реализации класса серванта для интерфеса ModelPropertiesHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELPROPERTIESHELPERIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELPROPERTIESHELPERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace RoseModelImpl {

class ModelPropertiesHelperImpl; // self forward Var
typedef ::Core::Var<ModelPropertiesHelperImpl> ModelPropertiesHelperImpl_var;
typedef ::Core::Var<const ModelPropertiesHelperImpl> ModelPropertiesHelperImpl_cvar;

class ModelPropertiesHelperImpl_factory;

class ModelPropertiesHelperImpl:
	virtual public ModelPropertiesHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ModelPropertiesHelperImpl)
	friend class ModelPropertiesHelperImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ModelPropertiesHelperImpl ();

	virtual ~ModelPropertiesHelperImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ModelPropertiesHelper
	// возвращает уровень видимости для элемента
	virtual int get_visibility_level (IRoseElementPtr elem) const;

	// implemented method from ModelPropertiesHelper
	virtual bool is_global_locally (IRoseElementPtr elem) const;

	// implemented method from ModelPropertiesHelper
	virtual void set_global_locally (IRoseElementPtr elem, bool value) const;

	// implemented method from ModelPropertiesHelper
	// устанавливает уровень видимости детей для элемента (при необходимсоти захватывает элемент)
	virtual void set_visibility_level (IRoseElementPtr elem, int level) const;
}; // class ModelPropertiesHelperImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELPROPERTIESHELPERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
