////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SortList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SortList
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_sort_list(«тип сортировки») - то же, что и глобальная функция сортировки _sort_lsit
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SORTLIST_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SORTLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/StereotypeListOperationBase.h"

namespace StereotypeFunctionsImpl {

class SortList; // self forward Var
typedef ::Core::Var<SortList> SortList_var;
typedef ::Core::Var<const SortList> SortList_cvar;

class SortList_factory;

// %S%f_sort_list(«тип сортировки») - то же, что и глобальная функция сортировки _sort_lsit
class SortList:
	virtual public ContainerOperationsImpl::StereotypeListOperationBase
{
	SET_OBJECT_COUNTER (SortList)
	friend class SortList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SortList ();

	virtual ~SortList ();

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
}; // class SortList

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SORTLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
