////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTarget.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetTarget
// Заголовок реализации класса серванта для интерфеса 
//
// Установить элементу (операции, параметру, атрибуту)  новый тип
// %S%f_set_target(<УИД/имя элемента или пусто (в случае void)>)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGET_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGET_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetTarget; // self forward Var
typedef ::Core::Var<SetTarget> SetTarget_var;
typedef ::Core::Var<const SetTarget> SetTarget_cvar;

class SetTarget_factory;

// Установить элементу (операции, параметру, атрибуту)  новый тип
// %S%f_set_target(<УИД/имя элемента или пусто (в случае void)>)
class SetTarget:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetTarget)
	friend class SetTarget_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetTarget ();

	virtual ~SetTarget ();

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
}; // class SetTarget

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETTARGET_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
