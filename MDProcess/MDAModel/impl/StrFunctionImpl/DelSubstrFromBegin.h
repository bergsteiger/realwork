////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromBegin.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::DelSubstrFromBegin
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_delsubstr_from_begin"
// _delsubstr_from_begin("<строка>",n) - удаляет n символов с начала строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMBEGIN_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMBEGIN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class DelSubstrFromBegin; // self forward Var
typedef ::Core::Var<DelSubstrFromBegin> DelSubstrFromBegin_var;
typedef ::Core::Var<const DelSubstrFromBegin> DelSubstrFromBegin_cvar;

class DelSubstrFromBegin_factory;

// реализация встроенной функции генератора "_delsubstr_from_begin"
// _delsubstr_from_begin("<строка>",n) - удаляет n символов с начала строки
class DelSubstrFromBegin:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (DelSubstrFromBegin)
	friend class DelSubstrFromBegin_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DelSubstrFromBegin ();

	virtual ~DelSubstrFromBegin ();

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
}; // class DelSubstrFromBegin

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMBEGIN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
