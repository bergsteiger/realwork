////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/LanguagesTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::LanguagesTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_LANGUAGESTRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_LANGUAGESTRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class LanguagesTranslator : 
	public Core::UnsortedTypeConverter<GblPilotDef::DictLanguage, Languages> {
	protected:
		void fill_array () {
			//#UC START# *460BB097038A_FILL_ARRAY_IMPLEMENTATION*
			this->add (GblPilotDef::dl_Russian, LG_RUSSIAN);
			this->add (GblPilotDef::dl_English, LG_ENGLISH);
			this->add (GblPilotDef::dl_French, LG_FRENCH);
			this->add (GblPilotDef::dl_German, LG_GERMAN);
			this->add (GblPilotDef::dl_Spanish, LG_SPANISH);
			this->add (GblPilotDef::dl_Italian, LG_ITALIAN);
			//#UC END# *460BB097038A_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class LanguagesTranslator

typedef ACE_Singleton<LanguagesTranslator, ACE_SYNCH_NULL_MUTEX> LanguagesTranslatorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_LANGUAGESTRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

