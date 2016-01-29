////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/DocStatusConverter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::DocStatusConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_DOCSTATUSCONVERTER_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_DOCSTATUSCONVERTER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class DocStatusConverter : 
	public Core::UnsortedTypeConverter<GblPilotDef::DocStatus, ItemStatus> {
	protected:
		void fill_array () {
			//#UC START# *460BAB4B0290_FILL_ARRAY_IMPLEMENTATION*
			this->add (GblPilotDef::ds_Abolished, IS_ABOLISHED);
			this->add (GblPilotDef::ds_Active, IS_ACTIVE);
			this->add (GblPilotDef::ds_Preactive, IS_PREACTIVE);
			this->add (GblPilotDef::ds_Unknown, IS_UNKNOWN);
			//#UC END# *460BAB4B0290_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class DocStatusConverter

typedef ACE_Singleton<DocStatusConverter, ACE_SYNCH_NULL_MUTEX> DocStatusConverterSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_DOCSTATUSCONVERTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

