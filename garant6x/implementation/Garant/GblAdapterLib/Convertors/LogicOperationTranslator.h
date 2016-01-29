////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/LogicOperationTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::LogicOperationTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_LOGICOPERATIONTRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_LOGICOPERATIONTRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class LogicOperationTranslator : 
	public Core::UnsortedTypeConverter<GblPilotQueryDef::LogicOperation, QueryLogicOperation> {
	protected:
		void fill_array () {
			//#UC START# *460BBD5800EA_FILL_ARRAY_IMPLEMENTATION*
			this->add (QLO_OR, GblPilotQueryDef::LO_OR);
			this->add (QLO_AND, GblPilotQueryDef::LO_AND);
			this->add (QLO_AND_NOT, GblPilotQueryDef::LO_NOT);
			//#UC END# *460BBD5800EA_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class LogicOperationTranslator

typedef ACE_Singleton<LogicOperationTranslator, ACE_SYNCH_NULL_MUTEX> LogicOperationTranslatorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_LOGICOPERATIONTRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

