////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Def/Def.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::DBExt::Def
//
// Общие типы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_DEF_H__
#define __GARANTCORE_DBEXT_DEF_H__

#include "shared/Core/sys/std_inc.h"

namespace DBExt {
namespace Def {

// Тип позиций
enum Type {
	dt_None // неизвестный тип
	, dt_Text // позиции из текста документа
	, dt_Title // позиции из заголовка документа
	, dt_All // все позиции
};

// Константы
static const unsigned long END_PORTION = 0x4000; // конец порции данных
static const unsigned long IS_3_BYTES = 0x8000; // позиция и флаги в трёх байтах

} // namespace Def
} // namespace DBExt


#endif //__GARANTCORE_DBEXT_DEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
