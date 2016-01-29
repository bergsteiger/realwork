////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringCmp
// Заголовк реализации фабрик интерфеса  для серванта StringCmp
//
// реализация встроенной функции генератора _string_cmp
// _string_cmp("<строка1>","<строка2>","<операция сравнения>") - сравнивает строку1 со строкой2
// применяя заданную операцию (>,<,==, !=, >=, <=)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGCMP_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGCMP_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for StringCmp
class StringCmp_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	StringCmp_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<StringCmp_factory> StringCmp_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGCMP_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

