////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/data/std_defs.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::data::std_defs
//
// ��������� �������� ��� ����� ��������������� ����������� �����: ��������� stl-����������; ����-
// �������� ��������� �� ���� (��� ���������� ��������� ���� ������� �������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_STD_DEFS_H__
#define __SHARED_GCL_DATA_STD_DEFS_H__

#include "shared/Core/sys/std_inc.h"
#include <set>
#include <vector>

namespace GCL {

// set-��������� ��������� �����
typedef std::set < std::string > StrSet;

// vector-��������� ��������� �����
typedef std::vector < std::string > StrVector;

// ���� ��� ��������� ������ - � ����������� ��������� ����
struct File_boxDeallocator {
	static void destroy (FILE* content) {
	//#UC START# *44FEBE6E005F*
		fclose(content);
	//#UC END# *44FEBE6E005F*
	}
};
typedef ::Core::Box<FILE, File_boxDeallocator> File_box;



} // namespace GCL


#endif //__SHARED_GCL_DATA_STD_DEFS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
