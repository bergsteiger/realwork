////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ParsersImpl/AttributeParserImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ParsersImpl::AttributeParserImpl
//
// реализация парсера атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ParsersImpl/AttributeParserImpl_factory.h"
#include "MDProcess/MDAModel/impl/ParsersImpl/AttributeParserImpl.h"

namespace ParsersImpl {

AttributeParserImpl_factory::AttributeParserImpl_factory () {
}

void AttributeParserImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Parsers::AttributeParserFactoryManager::register_factory (this, priority);
}

const char* AttributeParserImpl_factory::key () const {
	return "AttributeParserImpl";
}

Parsers::AttributeParser* AttributeParserImpl_factory::get () {
	AttributeParserImpl_var ret = new AttributeParserImpl ();
	return ret._retn ();
}

} // namespace ParsersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

