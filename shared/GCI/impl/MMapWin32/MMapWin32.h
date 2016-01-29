////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/MMapWin32/MMapWin32.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GCI::MMapWin32
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPWIN32_H__
#define __SHARED_GCI_MMAPWIN32_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/MMap/MMap.h"


#if defined(WIN32)
namespace GCI {
namespace MMapWin32 {

// ��� ������ ������� ���������� ������
typedef HANDLE MapObjectID;

// ��� ������ ��� ��������� ���-�����
typedef HANDLE FileHandle;

// ������ ��� CreateFileA
struct OpenFileInfo {
	// ���� � ��� �����
	std::string name;
	// ��������� �������� ������
	MMap::LongSize memory_offset;
	// �������� ������ ����� ��� �������
	MMap::LongSize desired_size;
	// ����� �������
	DWORD access;
	// ����� �������
	DWORD shared_mode;
	// ����� ��������
	DWORD creation;
	// �������������� �����
	DWORD flags;
	// ������������� ������ � �������
	DWORD granularity;
};

} //namespace MMapWin32
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPWIN32_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

