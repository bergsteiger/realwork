////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/ParamsHelper/ParamConvert.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Core::ParamsHelper::ParamConvert
//
// набор утилитных методов для конвертации списка параметров
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_PARAMSHELPER_PARAMCONVERT_H__
#define __SHARED_CORE_PARAMSHELPER_PARAMCONVERT_H__

#include "ace/ACE.h"
#include "ace/ARGV.h"
#include "shared/Core/ParamsCore/ParamsCore.h"

//#UC START# *4833E32102FC_CUSTOM_INCLUDES*
//#UC END# *4833E32102FC_CUSTOM_INCLUDES*

namespace Core {

// набор утилитных методов для конвертации списка параметров
class ParamConvert {
	SET_OBJECT_COUNTER (ParamConvert)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// из списка парамтеров типа ParamArgs формирует список в виде ACE_ARGV
	static ACE_ARGV* make_ace_argv (const ParamArgs& args);


//#UC START# *4833E32102FC*
	static ParamArgs make_arg_list (int argc, char** argv);
//#UC END# *4833E32102FC*
}; // class ParamConvert

} // namespace Core


#endif //__SHARED_CORE_PARAMSHELPER_PARAMCONVERT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

