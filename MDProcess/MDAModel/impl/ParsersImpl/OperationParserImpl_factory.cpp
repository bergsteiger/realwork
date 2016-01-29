////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ParsersImpl/OperationParserImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ParsersImpl::OperationParserImpl
//
// реализация парсера сигнатуры функции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ParsersImpl/OperationParserImpl_factory.h"
#include "MDProcess/MDAModel/impl/ParsersImpl/OperationParserImpl.h"

namespace ParsersImpl {

OperationParserImpl_factory::OperationParserImpl_factory () {
}

void OperationParserImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Parsers::OperationParserFactoryManager::register_factory (this, priority);
}

const char* OperationParserImpl_factory::key () const {
	return "OperationParserImpl";
}

Parsers::OperationParser* OperationParserImpl_factory::get () {
	OperationParserImpl_var ret = new OperationParserImpl ();
	return ret._retn ();
}

} // namespace ParsersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

