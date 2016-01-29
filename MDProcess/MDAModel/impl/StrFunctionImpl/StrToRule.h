////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrToRule.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrToRule
// Заголовок реализации класса серванта для интерфеса 
//
// конвертирует переданную строчку в грамматическое правило, например строчка "pack|package"
// сконвертируется в ("pack"|"package")
// 
// Использование:
// %f_str_to_rule(pack|package)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRTORULE_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRTORULE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StrToRule; // self forward Var
typedef ::Core::Var<StrToRule> StrToRule_var;
typedef ::Core::Var<const StrToRule> StrToRule_cvar;

class StrToRule_factory;

// конвертирует переданную строчку в грамматическое правило, например строчка "pack|package"
// сконвертируется в ("pack"|"package")
// 
// Использование:
// %f_str_to_rule(pack|package)
class StrToRule:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StrToRule)
	friend class StrToRule_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StrToRule ();

	virtual ~StrToRule ();

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
}; // class StrToRule

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRTORULE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
