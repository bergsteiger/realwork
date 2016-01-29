////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromEnd_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::DelSubstrFromEnd
// Заголовк реализации фабрик интерфеса  для серванта DelSubstrFromEnd
//
// реализация встроенной функции генератора "_delsubstr_from_end"
// _delsubstr_from_end("<строка>",n) - удаляет n символов с конца строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMEND_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMEND_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for DelSubstrFromEnd
class DelSubstrFromEnd_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	DelSubstrFromEnd_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<DelSubstrFromEnd_factory> DelSubstrFromEnd_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMEND_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

