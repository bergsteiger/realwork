////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrConv.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrConv
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_str_conv".
// _str_conv ("<шаблон>","<строка входного формата>","<строка выходного формата>") - пересобирает
// строку из одного формата в другой
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRCONV_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRCONV_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StrConv; // self forward Var
typedef ::Core::Var<StrConv> StrConv_var;
typedef ::Core::Var<const StrConv> StrConv_cvar;

class StrConv_factory;

// реализация встроенной функции генератора "_str_conv".
// _str_conv ("<шаблон>","<строка входного формата>","<строка выходного формата>") - пересобирает
// строку из одного формата в другой
class StrConv:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StrConv)
	friend class StrConv_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StrConv ();

	virtual ~StrConv ();

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
}; // class StrConv

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRCONV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
