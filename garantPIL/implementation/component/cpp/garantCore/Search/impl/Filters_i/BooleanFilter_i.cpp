////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/BooleanFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Filters_i::BooleanFilter_i
//
// Реализация логического фильтра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Filters_i/BooleanFilter_i.h"

namespace Search {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool BooleanFilter_i::FiltersCompare::operator () (const SearchAdapterLib::Adapter::IFilter* first_param_, const SearchAdapterLib::Adapter::IFilter* second_param_) const {
	//#UC START# *5346C09A0155_IMPL*
	if (first_param_->get_op () == second_param_->get_op ()) {
		return first_param_->get_size () < second_param_->get_size (); 
	}
	return first_param_->get_op () < second_param_->get_op ();
	//#UC END# *5346C09A0155_IMPL*
}

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BooleanFilter_i::BooleanFilter_i (MergeOp op)
//#UC START# *530B3D2B035F_BASE_INIT*
	: m_op (op)
//#UC END# *530B3D2B035F_BASE_INIT*
{
	//#UC START# *530B3D2B035F_BODY*
	//#UC END# *530B3D2B035F_BODY*
}

BooleanFilter_i::~BooleanFilter_i () {
	//#UC START# *530B3CF1001E_DESTR_BODY*
	for (Filters::iterator it = m_filters.begin (); it != m_filters.end (); ++it) {
		(*it)->release ();
	}
	//#UC END# *530B3CF1001E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IBooleanFilter
// добавить
void BooleanFilter_i::add (SearchAdapterLib::Adapter::IFilter* in) {
	//#UC START# *530B3AEB028D_530B3CF1001E*
	if (in && in->get_size ()) {
		m_filters.push_back (ContextSearch::Defs::IFilter::_duplicate (in));
		std::sort (m_filters.begin (), m_filters.end (), FiltersCompare ());
	}
	//#UC END# *530B3AEB028D_530B3CF1001E*
}

// implemented method from ContextSearch::Defs::IFilter
// check
bool BooleanFilter_i::check (ContextSearch::Defs::DocId val) {
	//#UC START# *52F0DBCD0015_530B3CF1001E*
	for (Filters::iterator it = m_filters.begin (); it != m_filters.end (); ++it) {
		if ((*it)->check (val) == false) {
			return (m_op == so_NOT);
		}
	}
	return (m_op == so_AND);
	//#UC END# *52F0DBCD0015_530B3CF1001E*
}

// implemented method from ContextSearch::Defs::IFilter
// check
bool BooleanFilter_i::check () const {
	//#UC START# *54C79CD80220_530B3CF1001E*
	if (m_filters.front ()->get_op () == so_AND) {
		return m_filters.front ()->check ();
	}
	return true;
	//#UC END# *54C79CD80220_530B3CF1001E*
}

// implemented method from ContextSearch::Defs::IFilter
// создать дубликат
ContextSearch::Defs::IFilter* BooleanFilter_i::duplicate () {
	//#UC START# *55AE33BF00FA_530B3CF1001E*
	IBooleanFilter_var ret = new BooleanFilter_i (m_op);

	for (Filters::iterator it = m_filters.begin (); it != m_filters.end (); ++it) {
		SearchAdapterLib::Adapter::IFilter_var dup = (*it)->duplicate ();
		ret->add (dup.in ());
	}

	return ret._retn ();
	//#UC END# *55AE33BF00FA_530B3CF1001E*
}

// implemented method from ContextSearch::Defs::IFilter
// logic op
char BooleanFilter_i::get_op () const {
	//#UC START# *5346BB1D01FE_530B3CF1001E*
	return m_op;
	//#UC END# *5346BB1D01FE_530B3CF1001E*
}

// implemented method from ContextSearch::Defs::IFilter
// size
size_t BooleanFilter_i::get_size () const {
	//#UC START# *530C97AC02C4_530B3CF1001E*
	size_t ret = 0;
	for (Filters::const_iterator it = m_filters.begin (); it != m_filters.end (); ++it) {
		ret += (*it)->get_size ();
	}
	return ret;
	//#UC END# *530C97AC02C4_530B3CF1001E*
}

// implemented method from ContextSearch::Defs::IFilter
// reset
void BooleanFilter_i::reset () {
	//#UC START# *52FC982D009E_530B3CF1001E*
	for (Filters::iterator it = m_filters.begin (); it != m_filters.end (); ++it) {
		(*it)->reset ();
	}
	//#UC END# *52FC982D009E_530B3CF1001E*
}

// implemented method from ContextSearch::Defs::IFilter
// type
const char* BooleanFilter_i::type () const {
	//#UC START# *52FCA10A026E_530B3CF1001E*
	return "BooleanFilter";
	//#UC END# *52FCA10A026E_530B3CF1001E*
}
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

