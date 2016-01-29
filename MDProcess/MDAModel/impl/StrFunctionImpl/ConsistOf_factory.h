////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ConsistOf_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ConsistOf
// Заголовк реализации фабрик интерфеса  для серванта ConsistOf
//
// реализация встроенной функции генератора:
// _consist_of(строка,список символов) - проверят, что исходная строка состоит только из
// определённых символов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CONSISTOF_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CONSISTOF_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for ConsistOf
class ConsistOf_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	ConsistOf_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<ConsistOf_factory> ConsistOf_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CONSISTOF_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

