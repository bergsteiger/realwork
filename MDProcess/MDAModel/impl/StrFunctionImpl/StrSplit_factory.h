////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrSplit_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrSplit
// Заголовк реализации фабрик интерфеса  для серванта StrSplit
//
// реализация встроенной функции генератора "_str_split".
// _str_split ("<строка>","<префикс>","<разделитель>") - разбивает строку на n-строк с заданным
// префиксом и разделителем (размер одной части пока что задан жестко в генераторе)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRSPLIT_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRSPLIT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for StrSplit
class StrSplit_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	StrSplit_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<StrSplit_factory> StrSplit_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRSPLIT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

