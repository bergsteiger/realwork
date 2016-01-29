////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/SortOrderTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::SortOrderTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_SORTORDERTRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_SORTORDERTRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class SortOrderTranslator : 
	public Core::UnsortedTypeConverter<GCD::SortOrder, SortOrder> {
	protected:
		void fill_array () {
			//#UC START# *460BC2DB02AF_FILL_ARRAY_IMPLEMENTATION*
			this->add (GCD::so_ascending, SO_ASCENDING);
			this->add (GCD::so_descending, SO_DESCENDING);
			//#UC END# *460BC2DB02AF_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class SortOrderTranslator

typedef ACE_Singleton<SortOrderTranslator, ACE_SYNCH_NULL_MUTEX> SortOrderTranslatorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_SORTORDERTRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

