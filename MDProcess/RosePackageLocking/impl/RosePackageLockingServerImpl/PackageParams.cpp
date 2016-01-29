////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageParams.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::PackageParams
//
// параметры для сохранения информации о захваченных пакетах
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageParams.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

const std::string PackageParams::get_storage_file () {
	return Core::ParamManagerFactory::get ().get_string ("-StorageFile", "");
}

void PackageParams::set_storage_file (const std::string& value) {
	Core::ParamManagerFactory::get ().set_string ("-StorageFile", value.c_str());
}

const char* PackageParams::storage_file_param_name () {
	return "-StorageFile";
}

const CORBA::ULong PackageParams::get_flush_timeout () {
	return static_cast<const CORBA::ULong> (Core::ParamManagerFactory::get ().get_ulong ("-FlushTimeout", 300));
}

void PackageParams::set_flush_timeout (CORBA::ULong value) {
	Core::ParamManagerFactory::get ().set_ulong ("-FlushTimeout", value);
}

const char* PackageParams::flush_timeout_param_name () {
	return "-FlushTimeout";
}

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
