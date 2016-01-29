////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/Common/Constants.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::ContextSearch::Common::Constants
//
// ��������� ����� � ����������� ������������� � ��������� ������� �������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_COMMON_CONSTANTS_H__
#define __SHARED_CONTEXTSEARCH_COMMON_CONSTANTS_H__

#include "shared/Core/sys/std_inc.h"

namespace ContextSearch {

// ������� �����
static const unsigned long DOC_BEGIN_WORD = 500; // ������� ������� ����� � ������ ��������� (�� ����� ����, �������� ������� ������� ����� � ������ 501)

// ���� ������������ � ������� ����� "����� + ������� �����"
static const unsigned long POS_HEADER = 0x200000; // ��� �������������� ����� � ���������
static const unsigned long POS_INVISIBLE_BLOCK = 0x300000; // ��� �������������� ����� � ���������� �����
static const unsigned long POS_INVISIBLE = 0x100000; // ��� �������������� ����� � ���������� ���������
static const unsigned long POS_TEXT = 0x0FFFFF; // ��� ������� �����
static const unsigned long POS_FLAGS = 0x300000; // ��� ������


} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_COMMON_CONSTANTS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
