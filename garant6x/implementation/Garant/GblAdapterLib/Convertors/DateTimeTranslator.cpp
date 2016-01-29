////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTimeTranslator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::DateTimeTranslator
// Файл реализации утилитного набора DateTimeTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTimeTranslator.h"

namespace GblAdapterLib {
namespace DateTimeTranslator {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

void translate (const GCD::DateTimeEx& value, DateTime& ret) {
	//#UC START# *460BC98400AB*
	ret.date.day = value.date_value.day;
	ret.date.month = value.date_value.month;
	ret.date.year = value.date_value.year;
	ret.time.hour = value.time_value.hour;
	ret.time.min = value.time_value.min;
	ret.time.sec = value.time_value.sec;
	//#UC END# *460BC98400AB*
}

void translate (const GCD::DateTime& value, DateTime& ret) {
	//#UC START# *4E0A0654030F*
	ret.date.day = value.date_value.day;
	ret.date.month = value.date_value.month;
	ret.date.year = value.date_value.year;
	ret.time.hour = value.time_value.hour;
	ret.time.min = value.time_value.min;
	ret.time.sec = value.time_value.sec;
	//#UC END# *4E0A0654030F*
}

} // namespace DateTimeTranslator
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

