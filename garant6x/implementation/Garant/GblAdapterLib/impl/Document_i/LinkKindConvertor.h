////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/LinkKindConvertor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Document_i::LinkKindConvertor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINKKINDCONVERTOR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINKKINDCONVERTOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class LinkKindConvertor : 
	public Core::UnsortedTypeConverter<GblPilot::LinkKind, LinkKind> {
	protected:
		void fill_array () {
			//#UC START# *556F16F000B8_FILL_ARRAY_IMPLEMENTATION*
			this->add (GblPilot::LK_INTERNAL_INVALID, LK_INTERNAL_INVALID);
			this->add (GblPilot::LK_REGULAR, LK_REGULAR);
			this->add (GblPilot::LK_EXTERNAL, LK_EXTERNAL);
			this->add (GblPilot::LK_ABOLISHED, LK_ABOLISHED);
			this->add (GblPilot::LK_PREACTIVE, LK_PREACTIVE);
			this->add (GblPilot::LK_ENO, LK_ENO);
			this->add (GblPilot::LK_EDITION, LK_EDITION);
			this->add (GblPilot::LK_SCRIPT, LK_SCRIPT);
			//#UC END# *556F16F000B8_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class LinkKindConvertor

typedef ACE_Singleton<LinkKindConvertor, ACE_SYNCH_NULL_MUTEX> LinkKindConvertorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_LINKKINDCONVERTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

