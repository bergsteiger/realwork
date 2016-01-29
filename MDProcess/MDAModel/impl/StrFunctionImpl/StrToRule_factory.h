////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrToRule_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrToRule
// Заголовк реализации фабрик интерфеса  для серванта StrToRule
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
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRTORULE_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRTORULE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for StrToRule
class StrToRule_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	StrToRule_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<StrToRule_factory> StrToRule_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRTORULE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

