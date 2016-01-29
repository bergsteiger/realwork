////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromBegin_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::DelSubstrFromBegin
// Заголовк реализации фабрик интерфеса  для серванта DelSubstrFromBegin
//
// реализация встроенной функции генератора "_delsubstr_from_begin"
// _delsubstr_from_begin("<строка>",n) - удаляет n символов с начала строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMBEGIN_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMBEGIN_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for DelSubstrFromBegin
class DelSubstrFromBegin_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	DelSubstrFromBegin_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<DelSubstrFromBegin_factory> DelSubstrFromBegin_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMBEGIN_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

