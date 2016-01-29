////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/GenerationParams.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAModel::AbstractDumpers::GenerationParams
//
// настройки генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAModel/AbstractDumpers/GenerationParams.h"


const unsigned long GenerationParams::get_lock_strategy () {
	return Core::ParamManagerFactory::get ().get_ulong ("-lock_strategy", 0);
}

void GenerationParams::set_lock_strategy (unsigned long value) {
	Core::ParamManagerFactory::get ().set_ulong ("-lock_strategy", value);
}

const char* GenerationParams::lock_strategy_param_name () {
	return "-lock_strategy";
}

const bool GenerationParams::get_enable_spell_explicit_call_logging () {
	return Core::ParamManagerFactory::get ().get_ulong ("-enable_spell_explicit_call_logging", false) > 0 ? true : false;
}

void GenerationParams::set_enable_spell_explicit_call_logging (bool value) {
	Core::ParamManagerFactory::get ().set_ulong("-enable_spell_explicit_call_logging", value);
}

const char* GenerationParams::enable_spell_explicit_call_logging_param_name () {
	return "-enable_spell_explicit_call_logging";
}

const bool GenerationParams::get_scold_if_call_tpl_function_on_null () {
	return Core::ParamManagerFactory::get ().get_ulong ("-scold_if_call_tpl_function_on_null", false) > 0 ? true : false;
}

void GenerationParams::set_scold_if_call_tpl_function_on_null (bool value) {
	Core::ParamManagerFactory::get ().set_ulong("-scold_if_call_tpl_function_on_null", value);
}

const char* GenerationParams::scold_if_call_tpl_function_on_null_param_name () {
	return "-scold_if_call_tpl_function_on_null";
}

const bool GenerationParams::get_overwrite_creation_order_property () {
	return Core::ParamManagerFactory::get ().get_ulong ("-overwrite_creation_order_property", false) > 0 ? true : false;
}

void GenerationParams::set_overwrite_creation_order_property (bool value) {
	Core::ParamManagerFactory::get ().set_ulong("-overwrite_creation_order_property", value);
}

const char* GenerationParams::overwrite_creation_order_property_param_name () {
	return "-overwrite_creation_order_property";
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
