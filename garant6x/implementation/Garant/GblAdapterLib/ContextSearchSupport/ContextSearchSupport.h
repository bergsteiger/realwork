////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ContextSearchSupport
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONTEXTSEARCHSUPPORT_H__
#define __GARANT6X_GBLADAPTERLIB_CONTEXTSEARCHSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>

namespace GblAdapterLib {

#pragma pack (push, 1)

// ������� ��� ��������� ��������� ����.
struct HighlightPosition {
	// ������ ���������
	unsigned long start;
	// ����� ���������
	unsigned long finish;
};

#pragma pack (pop)

// ������ ������� ��� ���������.
typedef std::vector < Core::Box<HighlightPosition> > HighlightPositionList;

#pragma pack (push, 1)

// ��������� ������ �� ���������.
struct ContextSearchResult {
	// ������ ���������� ��������.
	unsigned long item_index;
	// �������, ��������� � ���������� ������
	HighlightPositionList positions;
};

#pragma pack (pop)

// ���� ������.
enum SearchStatus {
	SS_GLOBAL // ����� �� ����� �������.
	, SS_CURENT // ����� �� �������� ��������.
};

// ����������� ������.
enum SearchDirection {
	SD_UP // ���� �����.
	, SD_DOWN // ����� ����.
};

#pragma pack (push, 1)

// ������������ ���, ������������ ������ ������ � �������� ���������� (�������, ������� � �.�.).
// ��������� ss_Global + sd_Up - ����� � ����� �����.
// ��������� ss_Global + sd_Down - ����� ������� ����.
// ��������� c ss_Current - ����� �� �������� �������� ����� ��� ����.
struct SearchMode {
	// ��������� ������
	SearchStatus status;
	// ����������� ������
	SearchDirection direction;
};

#pragma pack (pop)

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONTEXTSEARCHSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
