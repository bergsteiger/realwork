////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileExtension_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileExtension
//
// %f_file_extension(путь к файлу) - извлекает расширение файла из пути к файлу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileExtension_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileExtension.h"

namespace SystemFunctionsImpl {

FileExtension_factory::FileExtension_factory () {
}

void FileExtension_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string FileExtension_factory::key () const {
	return "_file_extension";
}

TemplateFunctions::InternalFunction* FileExtension_factory::make () {
	FileExtension_var ret = new FileExtension ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

