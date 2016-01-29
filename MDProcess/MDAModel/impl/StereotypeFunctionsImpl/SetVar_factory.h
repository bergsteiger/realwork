////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SetVar_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SetVar
// Заголовк реализации фабрик интерфеса  для серванта SetVar
//
// %S%f_set_var(имя переменной,элемент|"строка") - установка переменной, связанной с элементом:
// {code}
// %S%f_set_var(TYPE,T)
// %S%f_set_var(NAME,"%SN")
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SETVAR_FCTR_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SETVAR_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StereotypeFunctionsImpl {

/// Interface-factory implementation for SetVar
class SetVar_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	SetVar_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<SetVar_factory> SetVar_factory_var;

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SETVAR_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

