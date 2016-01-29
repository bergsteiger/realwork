////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/IsEmpty.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::IsEmpty
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _is_empty.
// _is_empty(«идентификатор») - возвращает true, если список пуст
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ISEMPTY_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ISEMPTY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class IsEmpty; // self forward Var
typedef ::Core::Var<IsEmpty> IsEmpty_var;
typedef ::Core::Var<const IsEmpty> IsEmpty_cvar;

class IsEmpty_factory;

// реализация встроенной функции генератора _is_empty.
// _is_empty(«идентификатор») - возвращает true, если список пуст
class IsEmpty:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (IsEmpty)
	friend class IsEmpty_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	IsEmpty ();

	virtual ~IsEmpty ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class IsEmpty

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ISEMPTY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
