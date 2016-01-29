////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ParsersImpl/AttributeParserImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ParsersImpl::AttributeParserImpl
// Заголовок реализации класса серванта для интерфеса AttributeParser
//
// реализация парсера атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_PARSERSIMPL_ATTRIBUTEPARSERIMPL_H__
#define __MDPROCESS_MDAMODEL_PARSERSIMPL_ATTRIBUTEPARSERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/Parsers/Parsers.h"

namespace ParsersImpl {

class AttributeParserImpl; // self forward Var
typedef ::Core::Var<AttributeParserImpl> AttributeParserImpl_var;
typedef ::Core::Var<const AttributeParserImpl> AttributeParserImpl_cvar;

class AttributeParserImpl_factory;

// реализация парсера атрибутов
class AttributeParserImpl:
	virtual public Parsers::AttributeParser
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AttributeParserImpl)
	friend class AttributeParserImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AttributeParserImpl ();

	virtual ~AttributeParserImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Parsers::AttributeParser
	// парсит строку, в случае успеха возвращает true
	virtual Parsers::AttributeData* parse (const std::string& source) /*throw (Parsers::ParseError)*/;
}; // class AttributeParserImpl

} // namespace ParsersImpl


#endif //__MDPROCESS_MDAMODEL_PARSERSIMPL_ATTRIBUTEPARSERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
