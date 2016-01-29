////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CountInList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CountInList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _count_in_list.
// _count_in_list(«идентификатор», «значение») - возвращает сколько раз встречается в списке
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COUNTINLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COUNTINLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class CountInList; // self forward Var
typedef ::Core::Var<CountInList> CountInList_var;
typedef ::Core::Var<const CountInList> CountInList_cvar;

class CountInList_factory;

// реализация встроенной функции генератора _count_in_list.
// _count_in_list(«идентификатор», «значение») - возвращает сколько раз встречается в списке
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
class CountInList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (CountInList)
	friend class CountInList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CountInList ();

	virtual ~CountInList ();

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
}; // class CountInList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COUNTINLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
