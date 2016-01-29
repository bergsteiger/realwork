////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::ExistsInList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _exists_in_list.
// _exists_in_list (идентификатор», «значение») - проверяет наличие в списке с заданным
// идентификатором элемента (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА), возвращает true или false
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_EXISTSINLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_EXISTSINLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class ExistsInList; // self forward Var
typedef ::Core::Var<ExistsInList> ExistsInList_var;
typedef ::Core::Var<const ExistsInList> ExistsInList_cvar;

class ExistsInList_factory;

// реализация встроенной функции генератора _exists_in_list.
// _exists_in_list (идентификатор», «значение») - проверяет наличие в списке с заданным
// идентификатором элемента (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА), возвращает true или false
class ExistsInList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (ExistsInList)
	friend class ExistsInList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExistsInList ();

	virtual ~ExistsInList ();

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
}; // class ExistsInList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_EXISTSINLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
