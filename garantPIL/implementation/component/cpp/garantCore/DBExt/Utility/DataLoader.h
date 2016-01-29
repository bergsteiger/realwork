////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Utility/DataLoader.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::DBExt::Utility::DataLoader
//
// Загрузка данных из индексов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_UTILITY_DATALOADER_H__
#define __GARANTCORE_DBEXT_UTILITY_DATALOADER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/DB/DBCore/DBCore.h"

namespace DBExt {

// Загрузка данных из индексов
class DataLoader {
	SET_OBJECT_COUNTER (DataLoader)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// загрузка списка строк
	static void load (DBCore::IIndex* index, const void* key, GCL::StrVector& out);

	// загрузка списка документов
	static void load (DBCore::IIndex* index, const void* key, DBCore::DocVector& out);

	// загрузка списка документов
	static void load_ (DBCore::IIndex* index, const void* key, int sn, DBCore::DocVector& out);

	// загрузка списка документов
	static void load_refs (DBCore::IIndex* index, const void* key, DBCore::DocVector& out);

	// загрузка списка документов
	static void load_refs_ (DBCore::IIndex* index, const void* key, DBCore::DocVector& out);

	// загрузка списка документов
	static void read (DBCore::Store* store, DBCore::DocVector& out);

private:
	// загрузка списка документов
	static void load_refs (DBCore::Store* store, DBCore::DocVector& out);

}; // class DataLoader

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_UTILITY_DATALOADER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

