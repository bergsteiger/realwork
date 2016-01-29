////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromEnd.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::DelSubstrFromEnd
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_delsubstr_from_end"
// _delsubstr_from_end("<строка>",n) - удаляет n символов с конца строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMEND_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMEND_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class DelSubstrFromEnd; // self forward Var
typedef ::Core::Var<DelSubstrFromEnd> DelSubstrFromEnd_var;
typedef ::Core::Var<const DelSubstrFromEnd> DelSubstrFromEnd_cvar;

class DelSubstrFromEnd_factory;

// реализация встроенной функции генератора "_delsubstr_from_end"
// _delsubstr_from_end("<строка>",n) - удаляет n символов с конца строки
class DelSubstrFromEnd:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (DelSubstrFromEnd)
	friend class DelSubstrFromEnd_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DelSubstrFromEnd ();

	virtual ~DelSubstrFromEnd ();

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
}; // class DelSubstrFromEnd

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMEND_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
