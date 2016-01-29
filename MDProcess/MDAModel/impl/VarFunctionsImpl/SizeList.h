////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SizeList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SizeList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _size_list
// _size_list(«идентификатор») - возвращаеьт количество элементов в списке
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SIZELIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SIZELIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class SizeList; // self forward Var
typedef ::Core::Var<SizeList> SizeList_var;
typedef ::Core::Var<const SizeList> SizeList_cvar;

class SizeList_factory;

// реализация встроенной функции генератора _size_list
// _size_list(«идентификатор») - возвращаеьт количество элементов в списке
class SizeList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (SizeList)
	friend class SizeList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SizeList ();

	virtual ~SizeList ();

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
}; // class SizeList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SIZELIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
