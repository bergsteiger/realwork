////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/IsEqual.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::IsEqual
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_is_equal (дампер списка) - сравниваем списки, возвращает true или false
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_ISEQUAL_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_ISEQUAL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/StereotypeListOperationBase.h"

namespace StereotypeFunctionsImpl {

class IsEqual; // self forward Var
typedef ::Core::Var<IsEqual> IsEqual_var;
typedef ::Core::Var<const IsEqual> IsEqual_cvar;

class IsEqual_factory;

// %S%f_is_equal (дампер списка) - сравниваем списки, возвращает true или false
class IsEqual:
	virtual public ContainerOperationsImpl::StereotypeListOperationBase
{
	SET_OBJECT_COUNTER (IsEqual)
	friend class IsEqual_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	IsEqual ();

	virtual ~IsEqual ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ContainerOperationsImpl::StereotypeListOperationBase
	virtual const std::string execute_impl2 (
		TemplatePainter::ContainerDumper* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class IsEqual

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_ISEQUAL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
