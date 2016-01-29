////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/os/dir_op.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::os::dir_op
// ���� ���������� ���������� ������ dir_op
//
// ����������� �������� ��� ���������� (�������� ������, ...)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/os/dir_op.h"
// by <<uses>> dependencies
#include "shared/GCL/data/std_defs.h"
#include "shared/GCL/str/str_op.h"

namespace GCL {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// ������� ������ ��������� �� ��������� ������� ���� full_path. ���� ����� �������� ������ �
// ������ �����, ����� �������� is_path_with_filename  ����� ���������� � true.
// ���������� true, ���� ������ ��������� ������� �������, ��� ��� ����������
bool create_tree_dirs (const char* full_path, bool is_path_with_filename) {
	//#UC START# *4503DD9C02EE*
	static const char* const path_breaks = "\\/";
	GCL::StrVector folders = GCL::split_string_by_chars(full_path, path_breaks, false);
	
	// ������� ��� ����� - ������ ���� ���������� ������ ����, ������� ��� �����
	if (!folders.empty () && is_path_with_filename) {
		folders.pop_back ();
	}
	
	// ������ ������� ��������
	bool may_be_host = true;
	std::string path;
	for (size_t i = 0; i < folders.size (); ++i) {
		path += folders [i];
		path += ACE_DIRECTORY_SEPARATOR_CHAR;
		
		if (path.find_first_not_of (path_breaks) == std::string::npos) { // do not try to make root directory
			continue;
		}
	
 		if (ACE_OS::mkdir (path.c_str ()) == -1 && errno == ENOENT)  {
 			if (may_be_host && (i + 1 < folders.size ())) {								 // skip shared resource host name
 				may_be_host = false;
 				continue;
 			}
			return false;
 		}
	}
	return true;
	//#UC END# *4503DD9C02EE*
}

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

