////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/CutPostfix.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::CutPostfix
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_cut_postfix"
// _cut_postfix(<строка>,<постфикс>) - удаляет постфикс у строчки, если она на него заканчивается.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CUTPOSTFIX_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CUTPOSTFIX_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class CutPostfix; // self forward Var
typedef ::Core::Var<CutPostfix> CutPostfix_var;
typedef ::Core::Var<const CutPostfix> CutPostfix_cvar;

class CutPostfix_factory;

// реализация встроенной функции генератора "_cut_postfix"
// _cut_postfix(<строка>,<постфикс>) - удаляет постфикс у строчки, если она на него заканчивается.
class CutPostfix:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (CutPostfix)
	friend class CutPostfix_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CutPostfix ();

	virtual ~CutPostfix ();

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
}; // class CutPostfix

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CUTPOSTFIX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
