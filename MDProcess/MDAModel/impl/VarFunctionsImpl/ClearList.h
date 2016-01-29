////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/ClearList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::ClearList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _clear_list.
// _clear_list (идентификатор») - очищает список с заданным идентификатором.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_CLEARLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_CLEARLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class ClearList; // self forward Var
typedef ::Core::Var<ClearList> ClearList_var;
typedef ::Core::Var<const ClearList> ClearList_cvar;

class ClearList_factory;

// реализация встроенной функции генератора _clear_list.
// _clear_list (идентификатор») - очищает список с заданным идентификатором.
class ClearList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (ClearList)
	friend class ClearList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ClearList ();

	virtual ~ClearList ();

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
}; // class ClearList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_CLEARLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
