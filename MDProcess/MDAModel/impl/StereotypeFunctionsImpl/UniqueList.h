////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/UniqueList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::UniqueList
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_unique_list() - удаляет дубликаты из списка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_UNIQUELIST_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_UNIQUELIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/StereotypeListOperationBase.h"

namespace StereotypeFunctionsImpl {

class UniqueList; // self forward Var
typedef ::Core::Var<UniqueList> UniqueList_var;
typedef ::Core::Var<const UniqueList> UniqueList_cvar;

class UniqueList_factory;

// %S%f_unique_list() - удаляет дубликаты из списка.
class UniqueList:
	virtual public ContainerOperationsImpl::StereotypeListOperationBase
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

	// implemented method from ContainerOperationsImpl::StereotypeListOperationBase
	virtual const std::string execute_impl2 (
		TemplatePainter::ContainerDumper* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class UniqueList

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_UNIQUELIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
