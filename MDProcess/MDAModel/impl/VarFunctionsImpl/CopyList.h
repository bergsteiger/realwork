////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/CopyList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::CopyList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _copy_list
// _copy_list(«идентификатор списка1», «идентификатор списка2») - копирует список1 в список2.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COPYLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COPYLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class CopyList; // self forward Var
typedef ::Core::Var<CopyList> CopyList_var;
typedef ::Core::Var<const CopyList> CopyList_cvar;

class CopyList_factory;

// реализация встроенной функции генератора _copy_list
// _copy_list(«идентификатор списка1», «идентификатор списка2») - копирует список1 в список2.
class CopyList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (CopyList)
	friend class CopyList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CopyList ();

	virtual ~CopyList ();

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
}; // class CopyList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_COPYLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
