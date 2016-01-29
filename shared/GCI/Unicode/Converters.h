////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/Unicode/Converters.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCI::Unicode::Converters
//
// методы конвертации строк
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_UNICODE_CONVERTERS_H__
#define __SHARED_GCI_UNICODE_CONVERTERS_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {

// переводит строку в UTF-16, используя текущую локаль
const std::wstring cp_to_utf16 (const std::string& in);

// переводит строку в однобайтовую кодировку, используя текущую локаль
const std::string utf16_to_cp (const std::wstring& in);


} // namespace GCI


#endif //__SHARED_GCI_UNICODE_CONVERTERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
