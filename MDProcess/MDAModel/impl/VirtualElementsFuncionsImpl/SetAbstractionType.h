////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAbstractionType.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetAbstractionType
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_abstraction_type(abstract|regular|final) - устанавливает тип абтсрактности для
// элемента. Применима ТОЛЬКО для вирутальных элементов. Если тип абстрактности не указан в списке
// разрешенных шаблоном - выбрасывается исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETABSTRACTIONTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETABSTRACTIONTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetAbstractionType; // self forward Var
typedef ::Core::Var<SetAbstractionType> SetAbstractionType_var;
typedef ::Core::Var<const SetAbstractionType> SetAbstractionType_cvar;

class SetAbstractionType_factory;

// %S%f_set_abstraction_type(abstract|regular|final) - устанавливает тип абтсрактности для
// элемента. Применима ТОЛЬКО для вирутальных элементов. Если тип абстрактности не указан в списке
// разрешенных шаблоном - выбрасывается исключение
class SetAbstractionType:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetAbstractionType)
	friend class SetAbstractionType_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetAbstractionType ();

	virtual ~SetAbstractionType ();

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
}; // class SetAbstractionType

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETABSTRACTIONTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
