////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/ListSortTypeTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::ListSortTypeTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_LISTSORTTYPETRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_LISTSORTTYPETRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class ListSortTypeTranslator : 
	public Core::UnsortedTypeConverter<GblPilotDef::SortType, SortType> {
	protected:
		void fill_array () {
			//#UC START# *460BC2790196_FILL_ARRAY_IMPLEMENTATION*
			this->add (GblPilotDef::st_Priority, ST_PRIORITY);
			this->add (GblPilotDef::st_CreateDate, ST_CREATE_DATE);
			this->add (GblPilotDef::st_LastEditDate, ST_LAST_EDIT_DATE);
			this->add (GblPilotDef::st_NotSorted, ST_NOT_SORTED);
			this->add (GblPilotDef::st_Relevance, ST_RELEVANCE);
			//#UC END# *460BC2790196_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class ListSortTypeTranslator

typedef ACE_Singleton<ListSortTypeTranslator, ACE_SYNCH_NULL_MUTEX> ListSortTypeTranslatorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_LISTSORTTYPETRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

