////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Common/Comparators.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::ContextSearch::Common::Comparators
// Файл реализации утилитного набора Comparators
//
// Предикаты и функторы сравнения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Common/Comparators.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/ContextUtility.h"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

bool CompareByWords::operator () (const std::string& first_param_, const std::string& second_param_) const {
	//#UC START# *4EBD1892011E_IMPL*
	size_t first_count = ContextUtility::get_words_count (first_param_);
	size_t second_count = ContextUtility::get_words_count (second_param_);

	if (first_count == second_count) {
		return (is_less)? (first_param_.size () > second_param_.size ()) : (first_param_.size () > second_param_.size ());
	} 

	return (is_less)? (first_count < second_count) : (first_count > second_count);
	//#UC END# *4EBD1892011E_IMPL*
}


CompareByWords::CompareByWords (bool is_less_) : is_less(is_less_) {
	//#UC START# *4EBD1892011E_INIT_CTOR*
	//#UC END# *4EBD1892011E_INIT_CTOR*
}


} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

