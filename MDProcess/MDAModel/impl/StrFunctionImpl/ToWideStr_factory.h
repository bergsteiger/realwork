////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToWideStr
// Заголовк реализации фабрик интерфеса  для серванта ToWideStr
//
// реализация встроенной функции генератора "_to_wide_str"
// _to_wide_str (<строка>, <префикс>, <открывающий символ>, <закрывающий символ>) - трансформирует
// строку в wide-коды, если задан открывающий символ то английские символы сохраняются в ASCI-
// формате и обрамляются указанными символами.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for ToWideStr
class ToWideStr_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	ToWideStr_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<ToWideStr_factory> ToWideStr_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

