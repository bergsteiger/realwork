////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTimeTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::DateTimeTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_DATETIMETRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_DATETIMETRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garantServer/src/Business/GblConsulting/GCDC.h"

namespace GblAdapterLib {
namespace DateTimeTranslator {

void translate (const GCD::DateTimeEx& value, DateTime& ret);

void translate (const GCD::DateTime& value, DateTime& ret);


} // namespace DateTimeTranslator
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_DATETIMETRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
