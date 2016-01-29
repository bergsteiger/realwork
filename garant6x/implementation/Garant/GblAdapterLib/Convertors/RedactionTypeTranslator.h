////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/RedactionTypeTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::RedactionTypeTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_REDACTIONTYPETRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_REDACTIONTYPETRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class RedactionTypeTranslator : 
	public Core::UnsortedTypeConverter<RedactionType, GblPilotDef::RedactionStatus> {
	protected:
		void fill_array () {
			//#UC START# *460BA9120138_FILL_ARRAY_IMPLEMENTATION*
			this->add (GblPilotDef::rs_Actual, RT_ACTUAL);
			this->add (GblPilotDef::rs_ActualAbolished, RT_ACTUAL_ABOLISHED);
			this->add (GblPilotDef::rs_ActualPreactive, RT_ACTUAL_PREACTIVE);
			this->add (GblPilotDef::rs_Old, RT_OLD);
			this->add (GblPilotDef::rs_New, RT_NEW);
			this->add (GblPilotDef::rs_NewAbolished, RT_NEW_ABOLISHED);
			this->add (GblPilotDef::rs_NewPreactive, RT_NEW_PREACTIVE);
			//#UC END# *460BA9120138_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class RedactionTypeTranslator

typedef ACE_Singleton<RedactionTypeTranslator, ACE_SYNCH_NULL_MUTEX> RedactionTypeTranslatorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_REDACTIONTYPETRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

