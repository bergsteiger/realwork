////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Utility/DataLoader.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::DBExt::Utility::DataLoader
//
// �������� ������ �� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_UTILITY_DATALOADER_H__
#define __GARANTCORE_DBEXT_UTILITY_DATALOADER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/DB/DBCore/DBCore.h"

namespace DBExt {

// �������� ������ �� ��������
class DataLoader {
	SET_OBJECT_COUNTER (DataLoader)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� ������ �����
	static void load (DBCore::IIndex* index, const void* key, GCL::StrVector& out);

	// �������� ������ ����������
	static void load (DBCore::IIndex* index, const void* key, DBCore::DocVector& out);

	// �������� ������ ����������
	static void load_ (DBCore::IIndex* index, const void* key, int sn, DBCore::DocVector& out);

	// �������� ������ ����������
	static void load_refs (DBCore::IIndex* index, const void* key, DBCore::DocVector& out);

	// �������� ������ ����������
	static void load_refs_ (DBCore::IIndex* index, const void* key, DBCore::DocVector& out);

	// �������� ������ ����������
	static void read (DBCore::Store* store, DBCore::DocVector& out);

private:
	// �������� ������ ����������
	static void load_refs (DBCore::Store* store, DBCore::DocVector& out);

}; // class DataLoader

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_UTILITY_DATALOADER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

