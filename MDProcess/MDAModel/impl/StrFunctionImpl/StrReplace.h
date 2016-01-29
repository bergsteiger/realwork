////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrReplace.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrReplace
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_str_replace".
// _str_replace (<строка>,<исходная подстрока>,<новая подстрока>) - заменяет в строку все исходные
// подстроки на новые
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRREPLACE_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRREPLACE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StrReplace; // self forward Var
typedef ::Core::Var<StrReplace> StrReplace_var;
typedef ::Core::Var<const StrReplace> StrReplace_cvar;

class StrReplace_factory;

// реализация встроенной функции генератора "_str_replace".
// _str_replace (<строка>,<исходная подстрока>,<новая подстрока>) - заменяет в строку все исходные
// подстроки на новые
class StrReplace:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StrReplace)
	friend class StrReplace_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StrReplace ();

	virtual ~StrReplace ();

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
}; // class StrReplace

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRREPLACE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
