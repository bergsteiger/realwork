////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/UpsToList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::UpsToList
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _ups_to_list.
// _ups_to_list («элемент», «идентификатор») - заполняет в список c заданным идентификатором
// ползовательскими свойствами в формате: «имя свойства» = «значение»
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_UPSTOLIST_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_UPSTOLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class UpsToList; // self forward Var
typedef ::Core::Var<UpsToList> UpsToList_var;
typedef ::Core::Var<const UpsToList> UpsToList_cvar;

class UpsToList_factory;

// реализация встроенной функции генератора _ups_to_list.
// _ups_to_list («элемент», «идентификатор») - заполняет в список c заданным идентификатором
// ползовательскими свойствами в формате: «имя свойства» = «значение»
class UpsToList:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (UpsToList)
	friend class UpsToList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UpsToList ();

	virtual ~UpsToList ();

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
}; // class UpsToList

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_UPSTOLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
