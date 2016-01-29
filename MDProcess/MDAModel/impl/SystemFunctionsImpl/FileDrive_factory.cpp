////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDrive_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileDrive
//
// %f_file_drive(путь к файлу) - извлекает имя диска из пути к файлу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDrive_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDrive.h"

namespace SystemFunctionsImpl {

FileDrive_factory::FileDrive_factory () {
}

void FileDrive_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string FileDrive_factory::key () const {
	return "_file_drive";
}

TemplateFunctions::InternalFunction* FileDrive_factory::make () {
	FileDrive_var ret = new FileDrive ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

