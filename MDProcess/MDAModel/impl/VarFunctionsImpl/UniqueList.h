////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/UniqueList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::UniqueList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _unique_list.
// _unique_list(«идентификатор») - удаляет дубликаты из списка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_UNIQUELIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_UNIQUELIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class UniqueList; // self forward Var
typedef ::Core::Var<UniqueList> UniqueList_var;
typedef ::Core::Var<const UniqueList> UniqueList_cvar;

class UniqueList_factory;

// реализация встроенной функции генератора _unique_list.
// _unique_list(«идентификатор») - удаляет дубликаты из списка.
class UniqueList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (UniqueList)
	friend class UniqueList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UniqueList ();

	virtual ~UniqueList ();

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
}; // class UniqueList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_UNIQUELIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
