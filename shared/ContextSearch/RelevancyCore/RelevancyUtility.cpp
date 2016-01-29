////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/RelevancyCore/RelevancyUtility.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::ContextSearch::RelevancyCore::RelevancyUtility
// Файл реализации утилитного набора RelevancyUtility
//
// Утилитный пакет вспомогательных (для алгоритма вычисления релевантности) функций.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyUtility.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"

namespace ContextSearch {
namespace RelevancyUtility {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

bool CompareChains::operator () (const Relevancy::Positions& first_param_, const Relevancy::Positions& second_param_) const {
	//#UC START# *4D8C8A5603AD_IMPL*
	GDS_ASSERT (value < first_param_.size () && value < second_param_.size ());
	return compare_mask_less (first_param_ [value], second_param_ [value]);
	//#UC END# *4D8C8A5603AD_IMPL*
}


CompareChains::CompareChains (size_t value_) : value(value_) {
	//#UC START# *4D8C8A5603AD_INIT_CTOR*
	//#UC END# *4D8C8A5603AD_INIT_CTOR*
}


bool HasBadChain::operator () (const Relevancy::Positions& param_) const {
	//#UC START# *4DDA6B2401A6_IMPL*
	return (param_.front () == POS_TEXT || param_.back () == POS_TEXT);
	//#UC END# *4DDA6B2401A6_IMPL*
}

bool HasInvisibleBlock::operator () (Defs::Position param_) const {
	//#UC START# *4D9DD0E901B8_IMPL*
	return (param_ & POS_FLAGS) == POS_INVISIBLE_BLOCK;
	//#UC END# *4D9DD0E901B8_IMPL*
}

void ReceivePosition::operator () (Defs::Position& param_) const {
	//#UC START# *45534F79001F_IMPL*
	if ((param_ & POS_FLAGS) == POS_INVISIBLE_BLOCK || (param_ & POS_FLAGS) == POS_INVISIBLE) {
		param_ = 0;
	} else if (value) { // [$244191911]
		param_ &= POS_TEXT;
	}
	//#UC END# *45534F79001F_IMPL*
}


ReceivePosition::ReceivePosition (bool value_) : value(value_) {
	//#UC START# *45534F79001F_INIT_CTOR*
	//#UC END# *45534F79001F_INIT_CTOR*
}


bool RelevancyCompare::operator () (const Defs::Fragment& param_) const {
	//#UC START# *455340E1029F_IMPL*
	return param_.info.relevancy_value == value;
	//#UC END# *455340E1029F_IMPL*
}


RelevancyCompare::RelevancyCompare (Defs::RelevancyType value_) : value(value_) {
	//#UC START# *455340E1029F_INIT_CTOR*
	//#UC END# *455340E1029F_INIT_CTOR*
}


// сравнение векторов с позициями
bool compare_chain_less (const Relevancy::Positions& x, const Relevancy::Positions& y) {
	//#UC START# *4DA6EAF7004C*
	return x.size () < y.size (); 
	//#UC END# *4DA6EAF7004C*
}

// сравнение масок
bool compare_mask_less (unsigned long x, unsigned long y) {
	//#UC START# *453370EA00AB*
	return (x & POS_TEXT) < (y & POS_TEXT);
	//#UC END# *453370EA00AB*
}

// вычислить лучшую позицию в цепочке
Defs::Position get_position (const Relevancy::Positions& vect) {
	//#UC START# *4CEC00F402F9*
	Relevancy::Positions::const_iterator it = vect.begin (), it_end = vect.end ();

	Defs::Position ret = *(std::max_element (it, it_end, compare_mask_less));
	
	for (; it != it_end; ++it) {
		if ((*it & POS_FLAGS) != POS_INVISIBLE_BLOCK && (*it & POS_FLAGS) != POS_INVISIBLE) {
			if ((*it & POS_TEXT) < (ret & POS_TEXT)) {
				ret = *it;
			}
		}
	}

	return ret;
	//#UC END# *4CEC00F402F9*
}

} // namespace RelevancyUtility
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

