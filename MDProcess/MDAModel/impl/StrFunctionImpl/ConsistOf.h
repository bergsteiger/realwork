////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ConsistOf.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ConsistOf
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора:
// _consist_of(строка,список символов) - проверят, что исходная строка состоит только из
// определённых символов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CONSISTOF_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CONSISTOF_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class ConsistOf; // self forward Var
typedef ::Core::Var<ConsistOf> ConsistOf_var;
typedef ::Core::Var<const ConsistOf> ConsistOf_cvar;

class ConsistOf_factory;

// реализация встроенной функции генератора:
// _consist_of(строка,список символов) - проверят, что исходная строка состоит только из
// определённых символов
class ConsistOf:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ConsistOf)
	friend class ConsistOf_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConsistOf ();

	virtual ~ConsistOf ();

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
}; // class ConsistOf

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CONSISTOF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
