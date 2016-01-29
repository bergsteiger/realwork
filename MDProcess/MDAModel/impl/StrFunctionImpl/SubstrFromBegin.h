////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromBegin.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SubstrFromBegin
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_substr_from_begin"
// _substr_from_begin("<строка>",n) - возвращает n символов с начала строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMBEGIN_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMBEGIN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class SubstrFromBegin; // self forward Var
typedef ::Core::Var<SubstrFromBegin> SubstrFromBegin_var;
typedef ::Core::Var<const SubstrFromBegin> SubstrFromBegin_cvar;

class SubstrFromBegin_factory;

// реализация встроенной функции генератора "_substr_from_begin"
// _substr_from_begin("<строка>",n) - возвращает n символов с начала строки
class SubstrFromBegin:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (SubstrFromBegin)
	friend class SubstrFromBegin_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SubstrFromBegin ();

	virtual ~SubstrFromBegin ();

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
}; // class SubstrFromBegin

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMBEGIN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
