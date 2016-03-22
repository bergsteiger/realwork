////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/Common/ContextUtility.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::Common::ContextUtility
//
// ������� ��� ������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_COMMON_CONTEXTUTILITY_H__
#define __SHARED_CONTEXTSEARCH_COMMON_CONTEXTUTILITY_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "shared/GCL/data/std_defs.h"

namespace ContextSearch {

// ������� ��� ������� ���������
class ContextUtility {
	SET_OBJECT_COUNTER (ContextUtility)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ������ �������� ������� � ����������� ������
	static const std::string MONTHS_GEN [];

	// ������ �������� �������
	static const std::string MONTHS [];

public:
	// StrStrMap
	typedef std::map < std::string, std::string > StrStrMap;

	// ��������� ��� ���
	static const short MIN_DATE; // ����������� ����
	static const short MAX_DATE; // ������������ ����

	// ��������
	struct MarkupCounters {
		// �������
		size_t space;
		// ���������
		size_t strong;
		// �����
		size_t frame;
		MarkupCounters () : space(0), strong(0), frame(0) {
			//#UC START# *56D818E70165_DEF_INIT_CTOR*
			//#UC END# *56D818E70165_DEF_INIT_CTOR**cpp*
		}
	};

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� ������ ����� � �������� �� ������  � �������� ������
	static size_t get_first_word (std::string& out, const char* src);

	// �������� ��������
	static void get_markup_counters (const std::string& in, MarkupCounters& out);

	// ����� ��� ������
	static const char* get_month (size_t num);

	// ����� ������
	static size_t get_month_num (const std::string& str);

	// �������� ���������� ���� �� �����
	static size_t get_words_count (const std::string& str);

	// �������� �� ������� � ������ ������������� ��������
	static bool has_cyrillic (const std::string& str);

	// �������� �� ������� � ������ ����
	static bool has_digit (const std::string& str);

	// �������� �� ����������
	static bool is_alnum (const std::string& str);

	// �������� �� ����
	static bool is_date (const std::string& str);

	// �������� �� ����
	static bool is_date (const GCL::StrVector& in);

	// �������� �� ����
	static bool is_date (const std::string& d, const std::string& m, const std::string& y);

	// �������� �� ��, ��� ������ ������� ������ �� ����
	static bool is_digit (const std::string& str);

	// ��������� ���
	static bool is_equal_date (const GCL::StrVector& x, const GCL::StrVector& y);

	// �������� ������ �� �������� ������
	static bool is_month (const std::string& str);

	// �������� ������� �� ����������
	static bool is_valid_char (char ch);

	// ������ ������ �� �� ������������
	static void replace (std::string& out, const StrStrMap& in);

	// ������ ������ �� ��������� ����� � ���������� ���������
	static void split (GCL::StrVector& out, const std::string& str, bool is_ext);

private:
	// �������� �� ������� �������� � �������� ���������
	static bool in_range (short value, short first, short last);

	// �������� �������� ��� �� ����������
	static bool is_day_valid (short day, short month);

	// �������� �� ����������� ������
	static bool is_special_char (char ch);

}; // class ContextUtility

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_COMMON_CONTEXTUTILITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

