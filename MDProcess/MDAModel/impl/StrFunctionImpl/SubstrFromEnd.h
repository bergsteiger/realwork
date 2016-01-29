////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromEnd.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SubstrFromEnd
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_substr_from_end"
// _substr_from_end("<строка>",n) - возвращает n символов с конца строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMEND_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMEND_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class SubstrFromEnd; // self forward Var
typedef ::Core::Var<SubstrFromEnd> SubstrFromEnd_var;
typedef ::Core::Var<const SubstrFromEnd> SubstrFromEnd_cvar;

class SubstrFromEnd_factory;

// реализация встроенной функции генератора "_substr_from_end"
// _substr_from_end("<строка>",n) - возвращает n символов с конца строки
class SubstrFromEnd:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (SubstrFromEnd)
	friend class SubstrFromEnd_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SubstrFromEnd ();

	virtual ~SubstrFromEnd ();

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
}; // class SubstrFromEnd

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMEND_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
