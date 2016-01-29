////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/LinkedObjectTypeConvertor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Document_i::LinkedObjectTypeConvertor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINKEDOBJECTTYPECONVERTOR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINKEDOBJECTTYPECONVERTOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class LinkedObjectTypeConvertor : 
	public Core::UnsortedTypeConverter<GblPilot::LinkObjectType, LinkedObjectType> {
	protected:
		void fill_array () {
			//#UC START# *559F961D0114_FILL_ARRAY_IMPLEMENTATION*
			this->add (GblPilot::LOT_TOPIC_ID, LO_DOCUMENT);
			this->add (GblPilot::LOT_OBJECT, LO_EXTERNAL_OBJECT);
			this->add (GblPilot::LOT_LIST, LO_MULTILINK);
			this->add (GblPilot::LOT_STRING, LO_EXTERNAL_LINK);
			this->add (GblPilot::LOT_QUERY, LO_QUERY);
			this->add (GblPilot::LOT_BOOKMARK, LO_BOOKMARK);
			this->add (GblPilot::LOT_EXTERNAL_OPERATION, LO_EXTERNAL_OPERATION);
			this->add (GblPilot::LOT_ENO, LO_ENO);
			this->add (GblPilot::LOT_AUTOREFERAT, LO_AUTOREFERAT);
			this->add (GblPilot::LOT_SCRIPT, LO_SCRIPT);
			this->add (GblPilot::LOT_DELETED_CONTENT, LO_DELETED_FOLDERS_CONTENT);
			//#UC END# *559F961D0114_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class LinkedObjectTypeConvertor

typedef ACE_Singleton<LinkedObjectTypeConvertor, ACE_SYNCH_NULL_MUTEX> LinkedObjectTypeConvertorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINKEDOBJECTTYPECONVERTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

