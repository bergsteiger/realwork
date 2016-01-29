////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveRealized.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveRealized
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_remove_realized(<УИД элемента>) - функция удаления связи реализации между текущим элементом
// и элементом, заданным УИД'ом. Если не удалось найти элемент с заданным УИД'ом или с этим
// элементом нет связи реализации - генерируется исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEREALIZED_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEREALIZED_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class RemoveRealized; // self forward Var
typedef ::Core::Var<RemoveRealized> RemoveRealized_var;
typedef ::Core::Var<const RemoveRealized> RemoveRealized_cvar;

class RemoveRealized_factory;

// %S%f_remove_realized(<УИД элемента>) - функция удаления связи реализации между текущим элементом
// и элементом, заданным УИД'ом. Если не удалось найти элемент с заданным УИД'ом или с этим
// элементом нет связи реализации - генерируется исключение
class RemoveRealized:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (RemoveRealized)
	friend class RemoveRealized_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RemoveRealized ();

	virtual ~RemoveRealized ();

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
}; // class RemoveRealized

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEREALIZED_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
