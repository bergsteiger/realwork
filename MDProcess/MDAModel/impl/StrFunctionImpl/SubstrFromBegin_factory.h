////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromBegin_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SubstrFromBegin
// Заголовк реализации фабрик интерфеса  для серванта SubstrFromBegin
//
// реализация встроенной функции генератора "_substr_from_begin"
// _substr_from_begin("<строка>",n) - возвращает n символов с начала строки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMBEGIN_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMBEGIN_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for SubstrFromBegin
class SubstrFromBegin_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	SubstrFromBegin_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<SubstrFromBegin_factory> SubstrFromBegin_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMBEGIN_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

