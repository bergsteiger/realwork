////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SubstractList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SubstractList
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_substract_list(элемент являющийся списком) - вычитание из списка другого списка:
// {code}
// %f_clear_list(LIST1)
// %f_clear_list(LIST2)
// ...
// %{LIST1}%f_substract_list({LIST2})
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SUBSTRACTLIST_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SUBSTRACTLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/StereotypeListOperationBase.h"

namespace StereotypeFunctionsImpl {

class SubstractList; // self forward Var
typedef ::Core::Var<SubstractList> SubstractList_var;
typedef ::Core::Var<const SubstractList> SubstractList_cvar;

class SubstractList_factory;

// %S%f_substract_list(элемент являющийся списком) - вычитание из списка другого списка:
// {code}
// %f_clear_list(LIST1)
// %f_clear_list(LIST2)
// ...
// %{LIST1}%f_substract_list({LIST2})
// {code}
class SubstractList:
	virtual public ContainerOperationsImpl::StereotypeListOperationBase
{
	SET_OBJECT_COUNTER (SubstractList)
	friend class SubstractList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SubstractList ();

	virtual ~SubstractList ();

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
}; // class SubstractList

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SUBSTRACTLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
