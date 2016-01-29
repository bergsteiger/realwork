////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Morpho/Common/Helper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Morpho::Common::Helper
//
// ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_COMMON_HELPER_H__
#define __SHARED_MORPHO_COMMON_HELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace Morpho {

// ��������
class Helper {
	SET_OBJECT_COUNTER (Helper)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ���������
	static const char* COMMON_CYR; // ����� � ����������, ������������� �������
	static const char* COMMON_LAT; // ����� � ��������������, ��������� �������
	static const char* SPECIFIC_CYR; // ������������� ������������� �������
	static const char* SPECIFIC_LAT; // ������������� ��������� �������

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� �� ������� ���������
	static bool has_cyr (const std::string& str);

	// �������� �� ������� ��������
	static bool has_lat (const std::string& str);

	// �������� �� ������� ������������� ������������� ��������
	static bool is_cyr (const std::string& str);

	// �������� �� ������� ������������� ��������� ��������
	static bool is_lat (const std::string& str);

	// ����������� ���������
	static bool is_surrogate_cyr (const std::string& str);

	// ����������� ��������
	static bool is_surrogate_lat (const std::string& str);

	// ����������� � ���������
	static const std::string& to_cyr (std::string& str);

	// ����������� � ��������
	static const std::string& to_lat (std::string& str);

private:
	// �������� �� ������� ������������� ��������
	static bool is_specific (const std::string& str, const char* buf);

	// ��������
	static bool is_surrogate (const std::string& str, const char* buf);

	// �������������
	static void transform (std::string& str, const char* from, const char* to);

}; // class Helper

} // namespace Morpho


#endif //__SHARED_MORPHO_COMMON_HELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

