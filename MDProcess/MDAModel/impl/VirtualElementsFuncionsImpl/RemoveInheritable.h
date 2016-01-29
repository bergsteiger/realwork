////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveInheritable
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_remove_inheritable(<УИД элемента>) - функция удаления связи наследования между текущим
// элементом и элементом, заддным УИД'ом. Если не удалось найти элемент с заданным УИД'ом или с
// этим элементом нет связи наследования - генерируется исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEINHERITABLE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEINHERITABLE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class RemoveInheritable; // self forward Var
typedef ::Core::Var<RemoveInheritable> RemoveInheritable_var;
typedef ::Core::Var<const RemoveInheritable> RemoveInheritable_cvar;

class RemoveInheritable_factory;

// %S%f_remove_inheritable(<УИД элемента>) - функция удаления связи наследования между текущим
// элементом и элементом, заддным УИД'ом. Если не удалось найти элемент с заданным УИД'ом или с
// этим элементом нет связи наследования - генерируется исключение
class RemoveInheritable:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (RemoveInheritable)
	friend class RemoveInheritable_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RemoveInheritable ();

	virtual ~RemoveInheritable ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class RemoveInheritable

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEINHERITABLE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
