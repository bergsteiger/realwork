////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/QueryTypeTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::QueryTypeTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_QUERYTYPETRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_QUERYTYPETRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class QueryTypeTranslator : 
	public Core::UnsortedTypeConverter<QueryType, GblPilotQueryDef::QueryType> {
	protected:
		void fill_array () {
			//#UC START# *460BBB4601A5_FILL_ARRAY_IMPLEMENTATION*
			this->add (QT_ATTRIBUTE, GblPilotQueryDef::QT_ATTRIBUTE);
			this->add (QT_KEYWORD, GblPilotQueryDef::QT_KW);
			this->add (QT_PUBLISHED_SOURCE, GblPilotQueryDef::QT_PUBLISHED_SOURCE);
			this->add (QT_COMMENTS, GblPilotQueryDef::QT_COMMENTS);
			this->add (QT_REVIEW, GblPilotQueryDef::QT_REVIEW);
			this->add (QT_MAIL_LIST, GblPilotQueryDef::QT_MAIL_LIST);
			this->add (QT_RUBRICATOR, GblPilotQueryDef::QT_RUBRICATOR);
			this->add (QT_CONSULT, GblPilotQueryDef::QT_CONSULT);
			this->add (QT_HANDYCRAFT_CONSULT, GblPilotQueryDef::QT_HANDYCRAFT_CONSULT);
			this->add (QT_DETAIL, GblPilotQueryDef::QT_DETAIL);
			this->add (QT_BASE_SEARCH, GblPilotQueryDef::QT_BASE_SEARCH);
			this->add (QT_PHARM_SEARCH, GblPilotQueryDef::QT_PHARM_SEARCH);
			//#UC END# *460BBB4601A5_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class QueryTypeTranslator

typedef ACE_Singleton<QueryTypeTranslator, ACE_SYNCH_NULL_MUTEX> QueryTypeTranslatorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_QUERYTYPETRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

