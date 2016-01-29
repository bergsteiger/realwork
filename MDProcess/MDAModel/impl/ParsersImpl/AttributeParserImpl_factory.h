////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ParsersImpl/AttributeParserImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ParsersImpl::AttributeParserImpl
// Заголовк реализации фабрик интерфеса AttributeParser для серванта AttributeParserImpl
//
// реализация парсера атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_PARSERSIMPL_ATTRIBUTEPARSERIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_PARSERSIMPL_ATTRIBUTEPARSERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/Parsers/ParsersFactories.h"

namespace ParsersImpl {

/// Interface-factory implementation for AttributeParserImpl
class AttributeParserImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Parsers::AttributeParserAbstractFactory
{
public:
	AttributeParserImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Parsers::AttributeParser* get ();

};

typedef ::Core::Var<AttributeParserImpl_factory> AttributeParserImpl_factory_var;

} // namespace ParsersImpl


#endif //__MDPROCESS_MDAMODEL_PARSERSIMPL_ATTRIBUTEPARSERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

