////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/RelevancyCore/FragmentsOperations.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::RelevancyCore::FragmentsOperations
//
// Операции с фрагментами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCYCORE_FRAGMENTSOPERATIONS_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCYCORE_FRAGMENTSOPERATIONS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Defs/Defs.h"

namespace ContextSearch {

// Операции с фрагментами
class FragmentsOperations {
	SET_OBJECT_COUNTER (FragmentsOperations)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Значения диапазона
	struct RangeValues {
		// нижняя граница
		unsigned long _min;
		// верхняя граница
		unsigned long _max;
	};

	// Унарный функтор для поиска фрагмента по позиции
	struct PositionFinder : public std::unary_function<Defs::Fragment, bool> {
		bool operator () (const Defs::Fragment& param_) const;

		PositionFinder (unsigned long value_);

private:
		unsigned long value;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// удалить пересекающиеся фрагменты
	static void filtration (Defs::Fragments& vect);

	// сортировка фрагментов
	static void sort (Defs::Fragments& vect, const Defs::PosPair& pair);

private:
	// сравнение фрагментов
	static bool compare_less (const Defs::Fragment& x, const Defs::Fragment& y);

	// возвратить граничные значения фрагмента
	static void get_range_values (const Defs::Fragment& in, RangeValues& out);

	// печать
	static void print (const Defs::Fragments& vect);

}; // class FragmentsOperations

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCYCORE_FRAGMENTSOPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

