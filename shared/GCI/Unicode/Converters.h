////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/Unicode/Converters.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCI::Unicode::Converters
//
// ������ ����������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_UNICODE_CONVERTERS_H__
#define __SHARED_GCI_UNICODE_CONVERTERS_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {

// ��������� ������ � UTF-16, ��������� ������� ������
const std::wstring cp_to_utf16 (const std::string& in);

// ��������� ������ � ������������ ���������, ��������� ������� ������
const std::string utf16_to_cp (const std::wstring& in);


} // namespace GCI


#endif //__SHARED_GCI_UNICODE_CONVERTERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
