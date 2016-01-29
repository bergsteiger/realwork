////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/RelevancyCore/FragmentsOperations.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::RelevancyCore::FragmentsOperations
//
// Операции с фрагментами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/RelevancyCore/FragmentsOperations.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"
#include "shared/ContextSearch/RelevancyCore/RelevancyUtility.h"
#include "shared/ContextSearch/Common/Constants.h"
#include "boost/lambda/lambda.hpp"
#include <functional>

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
FragmentsOperations::SortProperties::SortProperties (
	unsigned long word_
	, unsigned long first_word_
)
//#UC START# *4D935BC401F6_INIT_CTOR_BASE_INIT*
	: word (word_)
	, first_word (first_word_)
//#UC END# *4D935BC401F6_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4D935BC401F6_INIT_CTOR*
	//#UC END# *4D935BC401F6_INIT_CTOR*
}


bool FragmentsOperations::PositionFinder::operator () (const Defs::Fragment& param_) const {
	//#UC START# *4D945AB6009E_IMPL*
	return param_.info.position > value;
	//#UC END# *4D945AB6009E_IMPL*
}


FragmentsOperations::PositionFinder::PositionFinder (unsigned long value_) : value(value_) {
	//#UC START# *4D945AB6009E_INIT_CTOR*
	//#UC END# *4D945AB6009E_INIT_CTOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// сравнение фрагментов
bool FragmentsOperations::compare_less (const Defs::Fragment& x, const Defs::Fragment& y) {
	//#UC START# *4D933DA70356*
	return x.info.position < y.info.position; 
	//#UC END# *4D933DA70356*
}

// удалить пересекающиеся фрагменты
void FragmentsOperations::filtration (Relevancy::Fragments& vect) {
	//#UC START# *4D933A8D0186*
	if (vect.size () < 2) {
		return;
	}

	std::sort (vect.begin (), vect.end (), compare_less);

	unsigned long x_len, y_len;

	RangeValues x, y;

	Relevancy::Fragments::iterator _it, it = vect.begin (), it_end = vect.end ();

	for (; it != it_end;) {
		if (it->info.relevancy_value && it + 1 != it_end) {
			_it = std::find_if (it + 1, it_end, boost::bind (&Defs::Fragment::info, _1) != 0);

			if (_it != it_end) {
				get_range_values (*it, x);
				get_range_values (*_it, y);

				if ((y._min <= x._min && x._min <= y._max) || (x._min <= y._min && y._min <= x._max)) {
					if (it->info.relevancy_value == _it->info.relevancy_value) {
						x_len = x._max - x._min;
						y_len = y._max - y._min;

						if (x_len == y_len) {
							if (it->info.position < _it->info.position) {
								_it->info.relevancy_value = 0;
							} else {
								it->info.relevancy_value = 0;
							}
						} else if (x_len < y_len) {
							_it->info.relevancy_value = 0;
						} else {
							it->info.relevancy_value = 0;
						}
					} else if (it->info.relevancy_value > _it->info.relevancy_value) {
						_it->info.relevancy_value = 0;
					} else {
						it->info.relevancy_value = 0;
					}

					continue;
				} 
			} 
		}

		++it;
	}

	it = std::remove_if (vect.begin (), vect.end (), boost::bind (&Defs::Fragment::info, _1) == 0);
	vect.erase (it, vect.end ());
	//#UC END# *4D933A8D0186*
}

// возвратить граничные значения фрагмента
void FragmentsOperations::get_range_values (const Defs::Fragment& in, RangeValues& out) {
	//#UC START# *4D933F3B0026*
	if (in.data.empty ()) {
		out._min = in.info.position;
		out._max = out._min;
	} else {
		out._min = (*std::min_element (
			in.data.begin (), in.data.end (), RelevancyUtility::compare_mask_less)) & POS_TEXT;
		out._max = (*std::max_element (
			in.data.begin (), in.data.end (), RelevancyUtility::compare_mask_less)) & POS_TEXT;
	}
	//#UC END# *4D933F3B0026*
}

// печать
void FragmentsOperations::print (const Relevancy::Fragments& vect) {
	//#UC START# *4D95BD9501B9*
	for (Relevancy::Fragments::const_iterator it = vect.begin (); it != vect.end () ; ++it) {
		std::cout << "r:" << it->info.relevancy_value << "  p:" << it->info.position << "  { ";
		std::copy (it->data.begin (), it->data.end (), std::ostream_iterator <Defs::Position> (std::cout, ", "));
		std::cout << "}\n";
	}
	//#UC END# *4D95BD9501B9*
}

// сортировка фрагментов
void FragmentsOperations::sort (Relevancy::Fragments& vect, const SortProperties& prop) {
	//#UC START# *4D933B7A0315*
	Relevancy::Fragments::iterator it;

	//
	// Среди найденных позиций может оказаться проиндексированное имя документа (!NAME), поэтому 
	// пропускаем те фрагменты, позиции которых меньше первого реального текста документа. [$155029238]
	//

	it = std::find_if (vect.begin (), vect.end (), PositionFinder (prop.first_word));

	if (it != vect.begin ()) {
		vect.erase (vect.begin (), it);
	}

	if (vect.size () > 1) {
		//
		// Сначала должны показываться фрагменты, в которых слова запроса находятся в
		// правильном порядке и друг за другом, а потом - все остальные.
		// Порядок - сверху вниз. [$96479463]
		//

		Defs::RelevancyType max_rel = Relevancy::BASE_FACTOR + 3;

		std::sort (vect.begin (), vect.end (), std::greater <Defs::Fragment> ());
		it = std::find_if (vect.begin (), vect.end (), boost::lambda::_1 < max_rel);
		std::sort (vect.begin (), it, compare_less);

		if (it != vect.end ()) {
			std::sort (it, vect.end (), compare_less);
		}

		std::rotate (vect.begin (), std::find_if (vect.begin (), it, PositionFinder (prop.word)), it);
		std::rotate (it, std::find_if (it, vect.end (), PositionFinder (prop.word)), vect.end ());
	}

	for (it = vect.begin (); it != vect.end (); ++it) {
		std::sort (it->data.begin (), it->data.end ()); // сортировка позиций
	}
	//#UC END# *4D933B7A0315*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

