////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/IntervalStruct.h"
// C++ header files (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::IntervalStruct
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_INTERVALSTRUCT_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_INTERVALSTRUCT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"

namespace GblAdapterLib {

// интервал дат
struct Interval {
	GblPilotDef::DocDate from;
	GblPilotDef::DocDate to;
	unsigned long redaction;
	unsigned long interval;

	Interval (unsigned long redaction);
};


} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_INTERVALSTRUCT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
