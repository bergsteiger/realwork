////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionTypeConverter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::MainMenu_i::SectionTypeConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONTYPECONVERTER_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONTYPECONVERTER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class SectionTypeConverter : 
	public Core::UnsortedTypeConverter<GblPilot::SectionType, SectionType> {
	protected:
		void fill_array () {
			//#UC START# *4E313DB8007F_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblPilot::ST_FINANCE, ST_FINANCE);
				this->add (GblPilot::ST_HR, ST_HR);
				this->add (GblPilot::ST_LEGAL, ST_LEGAL);
				this->add (GblPilot::ST_BUDGET_ORGS, ST_BUDGET_ORGS);
				this->add (GblPilot::ST_BUSINESS_REFERENCES, ST_BUSINESS_REFERENCES);
				this->add (GblPilot::ST_CHANGES_IN_LEGISLATION, ST_CHANGES_IN_LEGISLATION);				
				this->add (GblPilot::ST_LAW_FOR_ALL, ST_LAW_FOR_ALL);				
				//#UC END# *4E313DB8007F_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class SectionTypeConverter

typedef ACE_Singleton<SectionTypeConverter, ACE_SYNCH_NULL_MUTEX> SectionTypeConverterSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONTYPECONVERTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

