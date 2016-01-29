////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/std_defs.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::data::std_defs
//
// несколько макросов для часто употребительных стандартных типов: некоторые stl-контейнеры; авто-
// менеджер указателя на файл (при разрушении закрывает файл которым владеет)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_STD_DEFS_H__
#define __SHARED_GCL_DATA_STD_DEFS_H__

#include "shared/Core/sys/std_inc.h"
#include <set>
#include <vector>

namespace GCL {

// set-контейнер атомарных строк
typedef std::set < std::string > StrSet;

// vector-контейнер атомарных строк
typedef std::vector < std::string > StrVector;

// Бокс для файлового хендла - в деструкторе закрывает файл
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
