////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ParsersImpl/OperationParserImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ParsersImpl::OperationParserImpl
// Заголовк реализации фабрик интерфеса OperationParser для серванта OperationParserImpl
//
// реализация парсера сигнатуры функции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_PARSERSIMPL_OPERATIONPARSERIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_PARSERSIMPL_OPERATIONPARSERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/Parsers/ParsersFactories.h"

namespace ParsersImpl {

/// Interface-factory implementation for OperationParserImpl
class OperationParserImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Parsers::OperationParserAbstractFactory
{
public:
	OperationParserImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Parsers::OperationParser* get ();

};

typedef ::Core::Var<OperationParserImpl_factory> OperationParserImpl_factory_var;

} // namespace ParsersImpl


#endif //__MDPROCESS_MDAMODEL_PARSERSIMPL_OPERATIONPARSERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

