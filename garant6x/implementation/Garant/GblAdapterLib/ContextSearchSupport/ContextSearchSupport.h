////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ContextSearchSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONTEXTSEARCHSUPPORT_H__
#define __GARANT6X_GBLADAPTERLIB_CONTEXTSEARCHSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>

namespace GblAdapterLib {

#pragma pack (push, 1)

// Позиции для подсветки найденных слов.
struct HighlightPosition {
	// начало выделения
	unsigned long start;
	// конец выделения
	unsigned long finish;
};

#pragma pack (pop)

// Список позиций для подсветки.
typedef std::vector < Core::Box<HighlightPosition> > HighlightPositionList;

#pragma pack (push, 1)

// Результат поиска по контексту.
struct ContextSearchResult {
	// Индекс найденного элемента.
	unsigned long item_index;
	// позиции, найденные в результате поиска
	HighlightPositionList positions;
};

#pragma pack (pop)

// Зона поиска.
enum SearchStatus {
	SS_GLOBAL // Поиск по всему объекту.
	, SS_CURENT // Поиск от текущего элемента.
};

// Направление поиска.
enum SearchDirection {
	SD_UP // Поис вверх.
	, SD_DOWN // Поиск вниз.
};

#pragma pack (push, 1)

// Перечислимый тип, определяющий способ поиска в линейных структурах (списках, текстах и т.п.).
// Сочетание ss_Global + sd_Up - поиск с конца вверх.
// Сочетание ss_Global + sd_Down - поиск сначала вниз.
// Сочетание c ss_Current - поиск от текущего элемента вверх или вниз.
struct SearchMode {
	// результат поиска
	SearchStatus status;
	// направление поиска
	SearchDirection direction;
};

#pragma pack (pop)

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONTEXTSEARCHSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
