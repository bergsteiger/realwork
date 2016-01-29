////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/DateToString.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::DateToString
// Файл реализации утилитного набора DateToString
//
// перевод даты в символьное представление
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateToString.h"

namespace GblAdapterLib {
namespace DateToString {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// перевод даты в символьное представление
const std::string to_string (const Date& date) {
	//#UC START# *460B93EB0290*
	char str[16];
	sprintf (str, "%02d.%02d.%04d", date.day, date.month, date.year);
	return std::string (str);
	//#UC END# *460B93EB0290*
}

} // namespace DateToString
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

