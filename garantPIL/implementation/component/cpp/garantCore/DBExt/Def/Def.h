////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Def/Def.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::DBExt::Def
//
// ����� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_DEF_H__
#define __GARANTCORE_DBEXT_DEF_H__

#include "shared/Core/sys/std_inc.h"

namespace DBExt {
namespace Def {

// ��� �������
enum Type {
	dt_None // ����������� ���
	, dt_Text // ������� �� ������ ���������
	, dt_Title // ������� �� ��������� ���������
	, dt_All // ��� �������
};

// ���������
static const unsigned long END_PORTION = 0x4000; // ����� ������ ������
static const unsigned long IS_3_BYTES = 0x8000; // ������� � ����� � ��� ������

} // namespace Def
} // namespace DBExt


#endif //__GARANTCORE_DBEXT_DEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
