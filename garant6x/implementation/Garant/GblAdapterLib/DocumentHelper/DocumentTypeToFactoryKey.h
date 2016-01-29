////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentTypeToFactoryKey.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::DocumentHelper::DocumentTypeToFactoryKey
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENTHELPER_DOCUMENTTYPETOFACTORYKEY_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENTHELPER_DOCUMENTTYPETOFACTORYKEY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class DocumentTypeToFactoryKey : 
	public Core::UnsortedTypeConverter<GblPilotDef::DocumentType, FactoryKey> {
	protected:
		void fill_array () {
			//#UC START# *4FE870160102_FILL_ARRAY_IMPLEMENTATION*
			this->add (GblPilotDef::DT_DICTIONARY,                FK_DICT_DOCUMENT);
			this->add (GblPilotDef::DT_TIP,                       FK_TIP_DOCUMENT);
			this->add (GblPilotDef::DT_PHARM_FIRM,                FK_PHARM_FIRM_DOCUMENT);
			this->add (GblPilotDef::DT_PHARM_DICTIONARY,          FK_PHARM_DICT_DOCUMENT);
			this->add (GblPilotDef::DT_PHARM,                     FK_PHARM_DOCUMENT);
			this->add (GblPilotDef::DT_FLASH,                     FK_FLASH_DOCUMENT);
			this->add (GblPilotDef::DT_ACTUAL_ANALYTICS_CONTENTS, FK_ACTUAL_ANALYTICS_CONTENTS_DOCUMENT);
			this->add (GblPilotDef::DT_ACTUAL_ANALYTICS,          FK_ACTUAL_ANALYTICS_DOCUMENT);
			this->add (GblPilotDef::DT_LEGAL,                     FK_DOCUMENT_MASTER);
			this->add (GblPilotDef::DT_AUTOREFERAT,               FK_AUTOREFERAT_DOCUMENT);
			this->add (GblPilotDef::DT_REF,                       FK_REF);
			this->add (GblPilotDef::DT_BOOK,                      FK_BOOK);
			//#UC END# *4FE870160102_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class DocumentTypeToFactoryKey

typedef ACE_Singleton<DocumentTypeToFactoryKey, ACE_SYNCH_NULL_MUTEX> DocumentTypeToFactoryKeySingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENTHELPER_DOCUMENTTYPETOFACTORYKEY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

