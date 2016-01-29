////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringCmp
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _string_cmp
// _string_cmp("<строка1>","<строка2>","<операция сравнения>") - сравнивает строку1 со строкой2
// применяя заданную операцию (>,<,==, !=, >=, <=)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGCMP_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGCMP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StringCmp; // self forward Var
typedef ::Core::Var<StringCmp> StringCmp_var;
typedef ::Core::Var<const StringCmp> StringCmp_cvar;

class StringCmp_factory;

// реализация встроенной функции генератора _string_cmp
// _string_cmp("<строка1>","<строка2>","<операция сравнения>") - сравнивает строку1 со строкой2
// применяя заданную операцию (>,<,==, !=, >=, <=)
class StringCmp:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StringCmp)
	friend class StringCmp_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StringCmp ();

	virtual ~StringCmp ();

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
}; // class StringCmp

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGCMP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
