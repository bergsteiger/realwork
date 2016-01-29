////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/Other.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAAddinLib::Addin_i::Other
//
// набор вспомогательных настроек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_OTHER_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_OTHER_H__

#include "shared/CoreSrv/sys/std_inc.h"


// набор вспомогательных настроек
class Other {

// static member methods and data
public:
	static const bool get_can_association_relocate () /* throw (Core::ParameterIsMissing) */;
	static void set_can_association_relocate (bool value);
	static const char* can_association_relocate_param_name ();

	static const bool get_mda_save () /* throw (Core::ParameterIsMissing) */;
	static void set_mda_save (bool value);
	static const char* mda_save_param_name ();

}; // class Other



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_OTHER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

