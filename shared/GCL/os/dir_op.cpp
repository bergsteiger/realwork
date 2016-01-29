////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/os/dir_op.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::os::dir_op
// Файл реализации утилитного набора dir_op
//
// расширенные операции над каталогами (создание дерева, ...)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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

// Создает дерево каталогов по заданному полному пути full_path. Путь можно задавать вместе с
// именем файла, тогда параметр is_path_with_filename  нужно установить в true.
// Возвращает true, если дерево каталогов успешно создано, или уже существует
bool create_tree_dirs (const char* full_path, bool is_path_with_filename) {
	//#UC START# *4503DD9C02EE*
	static const char* const path_breaks = "\\/";
	GCL::StrVector folders = GCL::split_string_by_chars(full_path, path_breaks, false);
	
	// Удаляем имя файла - только если передавали полный путь, включая имя файла
	if (!folders.empty () && is_path_with_filename) {
		folders.pop_back ();
	}
	
	// Теперь создаем каталоги
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

