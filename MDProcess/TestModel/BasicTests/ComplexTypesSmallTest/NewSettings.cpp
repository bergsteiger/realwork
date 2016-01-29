////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/ComplexTypesSmallTest/NewSettings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> TestModel::BasicTests::ComplexTypesSmallTest::NewSettings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "TestModel/BasicTests/ComplexTypesSmallTest/NewSettings.h"

namespace BasicTests {

const long NewSettings::get_my_long () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-my_long")) {
		throw Core::ParameterIsMissing ("-my_long");
	}
	return Core::ParamManagerFactory::get ().get_long ("-my_long");
}

void NewSettings::set_my_long (long value) {
	Core::ParamManagerFactory::get ().set_long ("-my_long", value);
}

const char* NewSettings::my_long_param_name () {
	return "-my_long";
}

const bool NewSettings::get_my_bool () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-my_bool")) {
		throw Core::ParameterIsMissing ("-my_bool");
	}
	if (false == Core::ParamManagerFactory::get ().is_exist ("-my_bool")) {
		throw Core::ParameterIsMissing ("-my_bool");
	}
	return Core::ParamManagerFactory::get ().get_ulong ("-my_bool") > 0 ? true : false;
}

void NewSettings::set_my_bool (bool value) {
	Core::ParamManagerFactory::get ().set_ulong("-my_bool", value);
}

const char* NewSettings::my_bool_param_name () {
	return "-my_bool";
}

const NativeTypesSmallTest::NewEnum NewSettings::get_my_enum () {
	if (false == Core::ParamManagerFactory::get ().is_exist ("-my_enum")) {
		throw Core::ParameterIsMissing ("-my_enum");
	}
	std::string enum_val = Core::ParamManagerFactory::get ().get_string ("-my_enum");
	if (enum_val == "A") return NativeTypesSmallTest::A;
	if (enum_val == "B") return NativeTypesSmallTest::B;
	if (enum_val == "C") return NativeTypesSmallTest::C;
	
	throw Core::ParameterIsMissing ("-my_enum");
}

void NewSettings::set_my_enum (NativeTypesSmallTest::NewEnum value) {
	std::string enum_val;
	switch (value) {
		case NativeTypesSmallTest::A: enum_val = "A";
			break;
		case NativeTypesSmallTest::B: enum_val = "B";
			break;
		case NativeTypesSmallTest::C: enum_val = "C";
			break;
		default: break;
	}
	Core::ParamManagerFactory::get ().set_string("-my_enum", enum_val.c_str());
}

const char* NewSettings::my_enum_param_name () {
	return "-my_enum";
}

} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
