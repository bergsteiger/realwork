////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveChild
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_remove_child(<УИД элемента>) - функция удаления элемента из дерева генерации - ищет элемент
// с заданным УИД'ом среди детей текущего элемента (%S) если находит - удаляет элемент из дерева,
// если не находит - генерируется исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVECHILD_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVECHILD_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class RemoveChild; // self forward Var
typedef ::Core::Var<RemoveChild> RemoveChild_var;
typedef ::Core::Var<const RemoveChild> RemoveChild_cvar;

class RemoveChild_factory;

// %S%f_remove_child(<УИД элемента>) - функция удаления элемента из дерева генерации - ищет элемент
// с заданным УИД'ом среди детей текущего элемента (%S) если находит - удаляет элемент из дерева,
// если не находит - генерируется исключение
class RemoveChild:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (RemoveChild)
	friend class RemoveChild_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RemoveChild ();

	virtual ~RemoveChild ();

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
}; // class RemoveChild

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVECHILD_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
