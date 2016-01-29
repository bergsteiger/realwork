////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::DateTranslator
//
// трансляция адаптерных и серверных дат
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_DATETRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_DATETRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Business/GblConsulting/GCDC.h"

namespace GblAdapterLib {
namespace DateTranslator {

void translate (const Date& date, GblPilotDef::DocDate& srv_date);

void translate (const GblPilotDef::DocDate& date, Date& adapter_date);

void translate_date (const Date& adapter_date, GCD::DateEx& server_date);

void translate_date (const GCD::DateEx& server_date, Date& adapter_date);

void translate_date (const Date& adapter_date, GCD::Date& server_date);

void translate_date (const GCD::Date& server_date, Date& adapter_date);


} // namespace DateTranslator
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_DATETRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
