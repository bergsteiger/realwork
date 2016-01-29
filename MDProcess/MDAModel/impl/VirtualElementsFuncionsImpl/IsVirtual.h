////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/IsVirtual.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::IsVirtual
// Заголовок реализации класса серванта для интерфеса 
//
// является ли элемент виртуальным:
// %S%f_is_virtual()
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ISVIRTUAL_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ISVIRTUAL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class IsVirtual; // self forward Var
typedef ::Core::Var<IsVirtual> IsVirtual_var;
typedef ::Core::Var<const IsVirtual> IsVirtual_cvar;

class IsVirtual_factory;

// является ли элемент виртуальным:
// %S%f_is_virtual()
class IsVirtual:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (IsVirtual)
	friend class IsVirtual_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	IsVirtual ();

	virtual ~IsVirtual ();

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
}; // class IsVirtual

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ISVIRTUAL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
