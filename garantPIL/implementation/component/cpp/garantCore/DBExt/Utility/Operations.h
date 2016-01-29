////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Utility/Operations.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::DBExt::Utility::Operations
//
// ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_UTILITY_OPERATIONS_H__
#define __GARANTCORE_DBEXT_UTILITY_OPERATIONS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"

namespace DBExt {

// ��������
class Operations {
	SET_OBJECT_COUNTER (Operations)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ����������� ���� �������� ����������
	static DBCore::DocVector* intersect (const DBCore::DocVector& x, const DBCore::DocVector& y);

	// ����� ���� �������� ����������
	static DBCore::DocVector* merge (const DBCore::DocVector& x, const DBCore::DocVector& y);

	// ����� ���� �������� ���������� � ��������� �������������
	static DBCore::DocVector* merge_unique (const DBCore::DocVector& x, const DBCore::DocVector& y);

	// ������� ����� ����� ��������� ����������
	static void set_difference (DBCore::DocVector& x, const DBCore::DocVector& y);

}; // class Operations

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_UTILITY_OPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

