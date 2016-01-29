////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalObjectTypeTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::UserJournal_i::JournalObjectTypeTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALOBJECTTYPETRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALOBJECTTYPETRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalDefC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal.h"

namespace GblAdapterLib {

GblUserJournalDef::JournalObjectType translate (JournalObjectType adapter_type);

JournalObjectType translate (GblUserJournalDef::JournalObjectType server_type);


} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALOBJECTTYPETRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
