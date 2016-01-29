////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/HasNonEmptyGen_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::HasNonEmptyGen
//
// реализация встроенной функции генератора _has_non_empty_gen
// _has_non_empty_gen(«дампер»,«генератор») - возвращает true, если дампер имеет не пустой
// генератор, иначе возвращает false
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/HasNonEmptyGen_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/HasNonEmptyGen.h"

namespace SystemFunctionsImpl {

HasNonEmptyGen_factory::HasNonEmptyGen_factory () {
}

void HasNonEmptyGen_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string HasNonEmptyGen_factory::key () const {
	return "_has_non_empty_gen";
}

TemplateFunctions::InternalFunction* HasNonEmptyGen_factory::make () {
	HasNonEmptyGen_var ret = new HasNonEmptyGen ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

