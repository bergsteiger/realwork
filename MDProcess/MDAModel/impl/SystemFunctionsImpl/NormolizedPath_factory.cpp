////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NormolizedPath
//
// реализация встроенной функции генератора "_normolized_path".
// _normolized_path(«целевой генератор»,«элемент»), например:
// %f_normolized_path(dll.h,C)
// - выводит путь и имя файла генерации для целевого элемента, относительно пути к файлу генерации
// текущего элемента.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath.h"

namespace SystemFunctionsImpl {

NormolizedPath_factory::NormolizedPath_factory () {
}

void NormolizedPath_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string NormolizedPath_factory::key () const {
	return "_normolized_path";
}

TemplateFunctions::InternalFunction* NormolizedPath_factory::make () {
	NormolizedPath_var ret = new NormolizedPath ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

