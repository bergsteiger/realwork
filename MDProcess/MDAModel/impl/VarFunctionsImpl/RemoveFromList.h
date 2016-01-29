////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/RemoveFromList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::RemoveFromList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _remove_from_list.
// _remove_from_list (идентификатор», «значение») - удаляет из списка c заданным идентификатором
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_REMOVEFROMLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_REMOVEFROMLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class RemoveFromList; // self forward Var
typedef ::Core::Var<RemoveFromList> RemoveFromList_var;
typedef ::Core::Var<const RemoveFromList> RemoveFromList_cvar;

class RemoveFromList_factory;

// реализация встроенной функции генератора _remove_from_list.
// _remove_from_list (идентификатор», «значение») - удаляет из списка c заданным идентификатором
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
class RemoveFromList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (RemoveFromList)
	friend class RemoveFromList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RemoveFromList ();

	virtual ~RemoveFromList ();

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
}; // class RemoveFromList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_REMOVEFROMLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
