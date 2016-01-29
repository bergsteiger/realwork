////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/CutPostfix_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::CutPostfix
// Заголовк реализации фабрик интерфеса  для серванта CutPostfix
//
// реализация встроенной функции генератора "_cut_postfix"
// _cut_postfix(<строка>,<постфикс>) - удаляет постфикс у строчки, если она на него заканчивается.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CUTPOSTFIX_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CUTPOSTFIX_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for CutPostfix
class CutPostfix_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	CutPostfix_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<CutPostfix_factory> CutPostfix_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CUTPOSTFIX_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

