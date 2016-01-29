////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/fix/PragmaWarningDisable.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::fix::PragmaWarningDisable
//
// хак для подавления назойливых STL варнингов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_FIX_PRAGMAWARNINGDISABLE_H__
#define __SHARED_CORE_FIX_PRAGMAWARNINGDISABLE_H__


//#UC START# *45011FA90157_USER_INCLUDES*
//#UC END# *45011FA90157_USER_INCLUDES*


//#UC START# *45011FA90157_USER_DEFINITION*
#if defined(_MSC_VER)
#pragma warning (disable: 4290) //  c++ exception specification ignored
#pragma warning (disable: 4503) // 'identifier': decorated name length exceeded, name was truncated
#pragma warning (disable: 4786) // 'identifier': identifier was truncated to 'number' characters in the debug information
#pragma warning (disable: 4284) // return type for 'identifier::operator –>' is not a UDT or reference to a UDT. Will produce errors if applied using infix notation
#endif
//#UC END# *45011FA90157_USER_DEFINITION*



#endif //__SHARED_CORE_FIX_PRAGMAWARNINGDISABLE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
