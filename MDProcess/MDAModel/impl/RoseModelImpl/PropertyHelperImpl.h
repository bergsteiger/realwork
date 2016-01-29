////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/PropertyHelperImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::PropertyHelperImpl
// Заголовок реализации класса серванта для интерфеса PropertyHelper
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_PROPERTYHELPERIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_PROPERTYHELPERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace RoseModelImpl {

class PropertyHelperImpl; // self forward Var
typedef ::Core::Var<PropertyHelperImpl> PropertyHelperImpl_var;
typedef ::Core::Var<const PropertyHelperImpl> PropertyHelperImpl_cvar;

class PropertyHelperImpl_factory;

// реализация
class PropertyHelperImpl:
	virtual public PropertyHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PropertyHelperImpl)
	friend class PropertyHelperImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PropertyHelperImpl ();

	virtual ~PropertyHelperImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from PropertyHelper
	// возвращает true, если свойство может быть удалено из модели
	virtual bool can_be_deleted (IRosePropertyPtr property) const;

	// implemented method from PropertyHelper
	// возвращает true, если свойство определяет сгенерированный артефакт
	virtual bool is_self_generated_source (const std::string& prop_id) const;

	// implemented method from PropertyHelper
	// возвращает true, если свойство нужно обязательно сохранить в модель
	virtual bool need_persist (const std::string& prop_id) const;
}; // class PropertyHelperImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_PROPERTYHELPERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
