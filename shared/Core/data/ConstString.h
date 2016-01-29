////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/ConstString.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::data::ConstString
//
// заглушка для подключения boost::const_string (константной строки) и соответствующий дефайн
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_CONSTSTRING_H__
#define __SHARED_CORE_DATA_CONSTSTRING_H__

#include "ace/ACE.h"

//#UC START# *45632A4A0090_USER_INCLUDES*
#include "shared/Core/data/boost_const_string/const_string_fwd.hpp"
#include "shared/Core/data/boost_const_string/const_string.hpp"
//#UC END# *45632A4A0090_USER_INCLUDES*

namespace Core {

//#UC START# *45632A4A0090_USER_DEFINITION*
typedef boost::const_string<char> ConstString;
//#UC END# *45632A4A0090_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_DATA_CONSTSTRING_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
