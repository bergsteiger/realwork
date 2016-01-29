////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedDir_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NormolizedDir
//
// реализация встроенной функции генератора "_normolized_dir".
// _normolized_dir(«целевой генератор»,«элемент»), например:
// %f_normolized_dir(dll.h,C)
// - выводит путь генерации для целевого элемента, относительно пути к файлу генерации текущего
// элемента.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedDir_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedDir.h"

namespace SystemFunctionsImpl {

NormolizedDir_factory::NormolizedDir_factory () {
}

void NormolizedDir_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string NormolizedDir_factory::key () const {
	return "_normolized_dir";
}

TemplateFunctions::InternalFunction* NormolizedDir_factory::make () {
	NormolizedDir_var ret = new NormolizedDir ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

