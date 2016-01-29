////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterUsageCounter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FilterUsageCounter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterUsageCounter_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "boost/foreach.hpp"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FilterUsageCounter_i::FilterUsageCounter_i ()
//#UC START# *4CB2C236004C_4CB2D2A80251_4CB2CD1C0122_BASE_INIT*
//#UC END# *4CB2C236004C_4CB2D2A80251_4CB2CD1C0122_BASE_INIT*
{
	//#UC START# *4CB2C236004C_4CB2D2A80251_4CB2CD1C0122_BODY*
	//#UC END# *4CB2C236004C_4CB2D2A80251_4CB2CD1C0122_BODY*
}

FilterUsageCounter_i::~FilterUsageCounter_i () {
	//#UC START# *4CB2CD1C0122_DESTR_BODY*
	GDS_ASSERT (m_erased.empty ());
	try {
		for (Counter::iterator it = m_counter.begin (); it != m_counter.end (); ++it) {
			ApplicationHelper::instance ()->get_cached_filters_manager ()->delete_filter (it->first);
		}
	} catch (GCD::AccessDenied&) {
	} catch (GCD::CanNotFindData&) {
	}
	//#UC END# *4CB2CD1C0122_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void FilterUsageCounter_i::delete_filter (unsigned long id, bool is_pharm) const {
	//#UC START# *4CB2E3C0030E*
	try {
		ApplicationHelper::instance ()->get_cached_filters_manager ()->delete_filter (id);
		FiltersManager_var filters_manager (FiltersManagerFactory::make ());
		filters_manager->filter_removed (is_pharm);
	} catch (GCD::AccessDenied&) {
		GDS_ASSERT (false);
	} catch (GCD::CanNotFindData&) {
		GDS_ASSERT (false);
	}
	//#UC END# *4CB2E3C0030E*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from FiltersUsageCounter
void FilterUsageCounter_i::add (const FilterFromQuery* filter) {
	//#UC START# *4CB2C27100BE_4CB2CD1C0122*
	Counter::iterator it = m_counter.find (filter->get_id ());
	if (it == m_counter.end ()) {
		m_counter.insert (std::make_pair (filter->get_id (), FilterInfo (filter->get_flags ())));
	} else {
		++it->second.count;
	}
	//#UC END# *4CB2C27100BE_4CB2CD1C0122*
}

// implemented method from FiltersUsageCounter
bool FilterUsageCounter_i::is_used (const FilterFromQuery* filter) const {
	//#UC START# *4CB6FF61001D_4CB2CD1C0122*
	Counter::const_iterator it = m_counter.find (filter->get_id ());
	return it != m_counter.end ();
	//#UC END# *4CB6FF61001D_4CB2CD1C0122*
}

// implemented method from FiltersUsageCounter
void FilterUsageCounter_i::mark_to_erase (const FilterFromQuery* filter) {
	//#UC START# *4CB2C2A7021B_4CB2CD1C0122*
	if (std::find (m_erased.begin (), m_erased.end (), filter->get_id ()) == m_erased.end ()) {
		if (m_counter.find (filter->get_id ()) == m_counter.end ()) {
			this->delete_filter (filter->get_id (), filter->get_flags () & GblFiltersDef::FF_PHARM);
		} else {
			m_erased.push_back (filter->get_id ());
		}
	}
	//#UC END# *4CB2C2A7021B_4CB2CD1C0122*
}

// implemented method from FiltersUsageCounter
bool FilterUsageCounter_i::marked_to_erase (const FilterFromQuery* filter) const {
	//#UC START# *4CB4533501A0_4CB2CD1C0122*
	return std::find (m_erased.begin (), m_erased.end (), filter->get_id ()) != m_erased.end ();
	//#UC END# *4CB4533501A0_4CB2CD1C0122*
}

// implemented method from FiltersUsageCounter
void FilterUsageCounter_i::remove (const FilterFromQuery* filter) {
	//#UC START# *4CB2C28F03C4_4CB2CD1C0122*
	Counter::iterator it = m_counter.find (filter->get_id ());
	GDS_ASSERT (it != m_counter.end ());
	if (it != m_counter.end ()) {
		GDS_ASSERT (it->second.count);
		if (--it->second.count == 0) {
			bool is_pharm = it->second.flags & GblFiltersDef::FF_PHARM;
			m_counter.erase (it);
			if (std::find (m_erased.begin (), m_erased.end (), filter->get_id ()) != m_erased.end ()) {
				m_erased.erase (std::remove (m_erased.begin (), m_erased.end (), filter->get_id ()), m_erased.end ());
				this->delete_filter (filter->get_id (), is_pharm);
			}
		}
	}
	//#UC END# *4CB2C28F03C4_4CB2CD1C0122*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

