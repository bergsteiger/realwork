////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewSettings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> TestModel::BasicTests::NewLibSupport::NewSettings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "TestModel/BasicTests/NewSettings.h"

namespace BasicTests {

const unsigned long NewSettings::get_my_unsigned_long () {
	return Core::ParamManagerFactory::get ().get_ulong ("-my_unsigned_long", 10);
}

void NewSettings::set_my_unsigned_long (unsigned long value) {
	Core::ParamManagerFactory::get ().set_ulong ("-my_unsigned_long", value);
}

const char* NewSettings::my_unsigned_long_param_name () {
	return "-my_unsigned_long";
}

} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
