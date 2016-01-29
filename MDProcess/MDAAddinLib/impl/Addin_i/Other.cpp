////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/Other.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::Addin_i::Other
//
// набор вспомогательных настроек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/Other.h"


const bool Other::get_can_association_relocate () {
	return Core::ParamManagerFactory::get ().get_ulong ("-CanAssociationRelocate", false) > 0 ? true : false;
}

void Other::set_can_association_relocate (bool value) {
	Core::ParamManagerFactory::get ().set_ulong("-CanAssociationRelocate", value);
}

const char* Other::can_association_relocate_param_name () {
	return "-CanAssociationRelocate";
}

const bool Other::get_mda_save () {
	return Core::ParamManagerFactory::get ().get_ulong ("-MDASave", false) > 0 ? true : false;
}

void Other::set_mda_save (bool value) {
	Core::ParamManagerFactory::get ().set_ulong("-MDASave", value);
}

const char* Other::mda_save_param_name () {
	return "-MDASave";
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
