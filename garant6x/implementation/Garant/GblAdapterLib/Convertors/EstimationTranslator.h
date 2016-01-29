////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/EstimationTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::EstimationTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_ESTIMATIONTRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_ESTIMATIONTRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class EstimationTranslator : 
	public Core::UnsortedTypeConverter<EstimationValue, GblConsultingDef::EstimationValue> {
	protected:
		void fill_array () {
			//#UC START# *460BC910005D_FILL_ARRAY_IMPLEMENTATION*
			this->add (EV_UNDEFINED, GblConsultingDef::EV_UNDEFINED);
			this->add (EV_VERY_GOOD, GblConsultingDef::EV_VERY_GOOD);
			this->add (EV_GOOD, GblConsultingDef::EV_GOOD);
			this->add (EV_NORMAL, GblConsultingDef::EV_NORMAL);
			this->add (EV_BAD, GblConsultingDef::EV_BAD);
			//#UC END# *460BC910005D_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class EstimationTranslator

typedef ACE_Singleton<EstimationTranslator, ACE_SYNCH_NULL_MUTEX> EstimationTranslatorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_ESTIMATIONTRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

