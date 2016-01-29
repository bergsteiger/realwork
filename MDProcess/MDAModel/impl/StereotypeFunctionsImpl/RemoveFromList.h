////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/RemoveFromList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::RemoveFromList
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_remove_from_list («значение») - добавляет в список c заданным идентификатором элемент
// (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_REMOVEFROMLIST_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_REMOVEFROMLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/StereotypeListOperationBase.h"

namespace StereotypeFunctionsImpl {

class RemoveFromList; // self forward Var
typedef ::Core::Var<RemoveFromList> RemoveFromList_var;
typedef ::Core::Var<const RemoveFromList> RemoveFromList_cvar;

class RemoveFromList_factory;

// %S%f_remove_from_list («значение») - добавляет в список c заданным идентификатором элемент
// (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
class RemoveFromList:
	virtual public ContainerOperationsImpl::StereotypeListOperationBase
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

	// implemented method from ContainerOperationsImpl::StereotypeListOperationBase
	virtual const std::string execute_impl2 (
		TemplatePainter::ContainerDumper* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class RemoveFromList

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_REMOVEFROMLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
