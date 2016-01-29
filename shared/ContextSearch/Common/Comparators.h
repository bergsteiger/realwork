////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Common/Comparators.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::ContextSearch::Common::Comparators
//
// Предикаты и функторы сравнения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_COMMON_COMPARATORS_H__
#define __SHARED_CONTEXTSEARCH_COMMON_COMPARATORS_H__

#include "shared/Core/sys/std_inc.h"

namespace ContextSearch {

// Функтор сравнения строк по количеству слов
struct CompareByWords : public std::binary_function<std::string, std::string, bool> {
	bool operator () (const std::string& first_param_, const std::string& second_param_) const;

	CompareByWords (bool is_less_);

private:
	bool is_less;
};


} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_COMMON_COMPARATORS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
