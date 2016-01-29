////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTargetStereotype.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetTargetStereotype
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_target_stereotype(agr|lnk|ref) - устанавливает target_stereotyp для атрибута или
// операции. Применима ТОЛЬКО для вирутальных элементов. Если устанавливаемый target_stereotyp не
// указан как разрешенный в шаблоне - бросает исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGETSTEREOTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGETSTEREOTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetTargetStereotype; // self forward Var
typedef ::Core::Var<SetTargetStereotype> SetTargetStereotype_var;
typedef ::Core::Var<const SetTargetStereotype> SetTargetStereotype_cvar;

class SetTargetStereotype_factory;

// %S%f_set_target_stereotype(agr|lnk|ref) - устанавливает target_stereotyp для атрибута или
// операции. Применима ТОЛЬКО для вирутальных элементов. Если устанавливаемый target_stereotyp не
// указан как разрешенный в шаблоне - бросает исключение
class SetTargetStereotype:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetTargetStereotype)
	friend class SetTargetStereotype_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetTargetStereotype ();

	virtual ~SetTargetStereotype ();

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
}; // class SetTargetStereotype

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGETSTEREOTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
