////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Common/Constants.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::ContextSearch::Common::Constants
//
// Утилитный пакет с константами используемыми в алгоритме расчета релевантности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_COMMON_CONSTANTS_H__
#define __SHARED_CONTEXTSEARCH_COMMON_CONSTANTS_H__

#include "shared/Core/sys/std_inc.h"

namespace ContextSearch {

// Позиции слова
static const unsigned long DOC_BEGIN_WORD = 500; // позиция первого слова в тексте документа (на самом деле, реальная позиция первого слова в тексте 501)

// Биты используемые в битовой маске "флаги + позиция слова"
static const unsigned long POS_HEADER = 0x200000; // бит принадлежности слова к заголовку
static const unsigned long POS_INVISIBLE_BLOCK = 0x300000; // бит принадлежности слова к невидимому блоку
static const unsigned long POS_INVISIBLE = 0x100000; // бит принадлежности слова к невидимому диапазону
static const unsigned long POS_TEXT = 0x0FFFFF; // бит позиции слова
static const unsigned long POS_FLAGS = 0x300000; // бит флагов


} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_COMMON_CONSTANTS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
