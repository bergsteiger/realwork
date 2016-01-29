////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/AddToList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::AddToList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _add_to_list.
// _add_to_list («идентификатор», «значение») - добавляет в список c заданным идентификатором
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
// %f_add_to_list (LIST, S)
// %f_add_to_list (LIST, "test str")
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ADDTOLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ADDTOLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class AddToList; // self forward Var
typedef ::Core::Var<AddToList> AddToList_var;
typedef ::Core::Var<const AddToList> AddToList_cvar;

class AddToList_factory;

// реализация встроенной функции генератора _add_to_list.
// _add_to_list («идентификатор», «значение») - добавляет в список c заданным идентификатором
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
// %f_add_to_list (LIST, S)
// %f_add_to_list (LIST, "test str")
class AddToList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (AddToList)
	friend class AddToList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddToList ();

	virtual ~AddToList ();

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
}; // class AddToList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ADDTOLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
