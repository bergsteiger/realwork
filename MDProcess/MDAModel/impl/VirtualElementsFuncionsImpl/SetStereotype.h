////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetStereotype.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetStereotype
// Заголовок реализации класса серванта для интерфеса 
//
// %f_set_stereotype(<стереотип>) - устанавливает стереотип элементу. Применима только к
// виртуальным элементам, для реальных элементов будет выброшено исключение. Если элемент не может
// иметь заданный стереотип - выбрасывается исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETSTEREOTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETSTEREOTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetStereotype; // self forward Var
typedef ::Core::Var<SetStereotype> SetStereotype_var;
typedef ::Core::Var<const SetStereotype> SetStereotype_cvar;

class SetStereotype_factory;

// %f_set_stereotype(<стереотип>) - устанавливает стереотип элементу. Применима только к
// виртуальным элементам, для реальных элементов будет выброшено исключение. Если элемент не может
// иметь заданный стереотип - выбрасывается исключение
class SetStereotype:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetStereotype)
	friend class SetStereotype_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetStereotype ();

	virtual ~SetStereotype ();

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
}; // class SetStereotype

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETSTEREOTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
