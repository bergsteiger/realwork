////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTranslator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::DateTranslator
// Файл реализации утилитного набора DateTranslator
//
// трансляция адаптерных и серверных дат
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTranslator.h"

namespace GblAdapterLib {
namespace DateTranslator {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

void translate (const Date& date, GblPilotDef::DocDate& srv_date) {
	//#UC START# *460CEEAD0128*
	srv_date.m_day = date.day;
	srv_date.m_mounth = date.month;
	srv_date.m_year = date.year;
	//#UC END# *460CEEAD0128*
}

void translate (const GblPilotDef::DocDate& date, Date& adapter_date) {
	//#UC START# *460CF2850251*
	adapter_date.day = date.m_day;
	adapter_date.month = date.m_mounth;
	adapter_date.year = date.m_year;
	//#UC END# *460CF2850251*
}

void translate_date (const Date& adapter_date, GCD::DateEx& server_date) {
	//#UC START# *4746E2ED0090*
	server_date.day = adapter_date.day;
	server_date.month = adapter_date.month;
	server_date.year = adapter_date.year;
	//#UC END# *4746E2ED0090*
}

void translate_date (const GCD::DateEx& server_date, Date& adapter_date) {
	//#UC START# *4746E32E0040*
	adapter_date.day = server_date.day;
	adapter_date.month = server_date.month;
	adapter_date.year = server_date.year;
	//#UC END# *4746E32E0040*
}

void translate_date (const Date& adapter_date, GCD::Date& server_date) {
	//#UC START# *4E0A05D90068*
	server_date.day = adapter_date.day;
	server_date.month = adapter_date.month;
	server_date.year = adapter_date.year;
	//#UC END# *4E0A05D90068*
}

void translate_date (const GCD::Date& server_date, Date& adapter_date) {
	//#UC START# *4E0A05DB036B*
	adapter_date.day = server_date.day;
	adapter_date.month = server_date.month;
	adapter_date.year = server_date.year;
	//#UC END# *4E0A05DB036B*
}

} // namespace DateTranslator
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

