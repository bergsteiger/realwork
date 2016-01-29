////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/DateToString.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::DateToString
// ���� ���������� ���������� ������ DateToString
//
// ������� ���� � ���������� �������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateToString.h"

namespace GblAdapterLib {
namespace DateToString {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// ������� ���� � ���������� �������������
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

