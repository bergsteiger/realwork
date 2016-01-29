////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalObjectTypeTranslator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::UserJournal_i::JournalObjectTypeTranslator
// Файл реализации утилитного набора JournalObjectTypeTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalObjectTypeTranslator.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

GblUserJournalDef::JournalObjectType translate (JournalObjectType adapter_type) {
	//#UC START# *4A9434510206*
	switch (adapter_type) {
		case JOT_BOOKMARK:
			return GblUserJournalDef::JOT_BOOKMARK;
		case JOT_QUERY:
			return GblUserJournalDef::JOT_QUERY;
		case JOT_FOLDER:
			return GblUserJournalDef::JOT_FOLDER;
		default:
			GDS_ASSERT (false);
	}
	return GblUserJournalDef::JOT_UNSUPPORTED;
	//#UC END# *4A9434510206*
}

JournalObjectType translate (GblUserJournalDef::JournalObjectType server_type) {
	//#UC START# *4A94348F01E6*
	if (server_type & GblUserJournalDef::JOT_FOLDER) {
		return JOT_FOLDER;
	} else if (server_type & GblUserJournalDef::JOT_QUERY) {
		return JOT_QUERY;
	} else if (server_type & GblUserJournalDef::JOT_BOOKMARK) {
		return JOT_BOOKMARK;	
	} else {
		GDS_ASSERT (false);
	}
	return JOT_FOLDER;
	//#UC END# *4A94348F01E6*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

