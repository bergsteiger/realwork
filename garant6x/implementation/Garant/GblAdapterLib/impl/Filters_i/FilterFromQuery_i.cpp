////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterFromQuery_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FilterFromQuery_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterFromQuery_i.h"
// by <<uses>> dependencies
#include "garantServer/src/Business/GblFilters/GblFiltersDefC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Business/GblFilters/GblFiltersC.h"

//#UC START# *4CA9CBD90227_CUSTOM_INCLUDES*
//#UC END# *4CA9CBD90227_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4CA9CBD90227*
//#UC END# *4CA9CBD90227*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FilterFromQuery_i::FilterFromQuery_i (const GblFilters::Filter& filter)
//#UC START# *4CA499CA03DD_4CA49BF7017B_4CA9CBD90227_BASE_INIT*
: m_filter (filter), m_checked (false), m_all_attributes_restored (false)
//#UC END# *4CA499CA03DD_4CA49BF7017B_4CA9CBD90227_BASE_INIT*
{
	//#UC START# *4CA499CA03DD_4CA49BF7017B_4CA9CBD90227_BODY*
	//#UC END# *4CA499CA03DD_4CA49BF7017B_4CA9CBD90227_BODY*
}

FilterFromQuery_i::~FilterFromQuery_i () {
	//#UC START# *4CA9CBD90227_DESTR_BODY*
	//#UC END# *4CA9CBD90227_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void FilterFromQuery_i::clear_cache () {
	//#UC START# *45702DA9037A_4CA9CBD90227*
	if (m_checked) {
		m_checked = false;
		m_all_attributes_restored = false;
		if (m_saved_query.attributes.length ()) {
			m_filter.query = m_saved_query;
			m_saved_query.attributes.length (0);
		}
	}
	//#UC END# *45702DA9037A_4CA9CBD90227*
}

// implemented method from FilterFromQuery
const bool FilterFromQuery_i::get_changeable () const {
	//#UC START# *4CA49B8F02A0_4CA9CBD90227_GET*
	if (m_filter.flags & (GblFiltersDef::FF_READONLY | GblFiltersDef::FF_SHARED)) {
		return false;
	}

	return true;
	//#UC END# *4CA49B8F02A0_4CA9CBD90227_GET*
}

// implemented method from FilterFromQuery
// проверить атрибуты в фильтре
bool FilterFromQuery_i::check () {
	//#UC START# *4CB4447C0057_4CA9CBD90227*
	this->check_update_and_clear_cache ();

	if (!m_checked) {
		try {
			GblPilotQueryDef::Query_var real_query = 
				ApplicationHelper::instance ()->get_cached_filters_manager ()->check_filter (
					this->get_server_query ()
					, m_all_attributes_restored
				);
			m_saved_query = m_filter.query;
			m_filter.query = real_query.in ();
		} catch (GCD::CanNotFindData&) {
		}		
		m_checked = true;
	}

	return m_all_attributes_restored;
	//#UC END# *4CB4447C0057_4CA9CBD90227*
}

// implemented method from FilterFromQuery
const unsigned long FilterFromQuery_i::get_flags () const {
	//#UC START# *4CB2DE9F0052_4CA9CBD90227_GET*
	return m_filter.flags;
	//#UC END# *4CB2DE9F0052_4CA9CBD90227_GET*
}

// implemented method from FilterFromQuery
const GblPilotQueryDef::Query& FilterFromQuery_i::get_server_query () const {
	//#UC START# *4CAD666103DC_4CA9CBD90227*
	return m_filter.query;
	//#UC END# *4CAD666103DC_4CA9CBD90227*
}

// implemented method from FilterFromQuery
// идентификатор нужен оболочке, чтобы идентифицировать установленные фильтры (К274848126)
const unsigned long FilterFromQuery_i::get_id () const {
	//#UC START# *4CAAC9C00309_4CA9CBD90227_GET*
	return m_filter.id;
	//#UC END# *4CAAC9C00309_4CA9CBD90227_GET*
}

// implemented method from FilterFromQuery
// возвращает true, если оригинальный и переданный фильтры совпадают
bool FilterFromQuery_i::is_same (const FilterFromQuery* other) const {
	//#UC START# *4CA9B8430333_4CA9CBD90227*
	return this->get_id () == other->get_id ();
	//#UC END# *4CA9B8430333_4CA9CBD90227*
}

// implemented method from FilterFromQuery
// наложен ли фильтр
bool FilterFromQuery_i::is_used () const {
	//#UC START# *4CB6E46C024F_4CA9CBD90227*
	FiltersUsageCounter_var usage_counter (FiltersUsageCounterFactory::make ());
	return usage_counter->is_used (this);
	//#UC END# *4CB6E46C024F_4CA9CBD90227*
}

// implemented method from FilterFromQuery
// удалить фильтр после того, как он перестанет использоваться
void FilterFromQuery_i::mark_to_erase () {
	//#UC START# *4CA49BC000E5_4CA9CBD90227*
	FiltersUsageCounter_var usage_counter (FiltersUsageCounterFactory::make ());
	usage_counter->mark_to_erase (this);
	//#UC END# *4CA49BC000E5_4CA9CBD90227*
}

// implemented method from FilterFromQuery
bool FilterFromQuery_i::marked_to_erase () const {
	//#UC START# *4CB450AB03D8_4CA9CBD90227*
	FiltersUsageCounter_var usage_counter (FiltersUsageCounterFactory::make ());
	return usage_counter->marked_to_erase (this);
	//#UC END# *4CB450AB03D8_4CA9CBD90227*
}

// implemented method from FilterFromQuery
const GCI::IO::String* FilterFromQuery_i::get_name () const {
	//#UC START# *4CA499E100DA_4CA9CBD90227_GET*
	return GCI::IO::StringFactory::make (m_filter.name.in ());
	//#UC END# *4CA499E100DA_4CA9CBD90227_GET*
}

GCI::IO::String* FilterFromQuery_i::get_name () {
	return const_cast<GCI::IO::String*>(((const FilterFromQuery_i*)this)->get_name ());
}

void FilterFromQuery_i::set_name (GCI::IO::String* name) {
	//#UC START# *4CA499E100DA_4CA9CBD90227_SET*
	try {
		ApplicationHelper::instance ()->get_cached_filters_manager ()->change_filter_name (
			this->get_id (), name->get_data ()
		);
		m_filter.name = name->get_data ();
		FiltersManager_var filters_manager (FiltersManagerFactory::make ());
		filters_manager->filter_name_changed (m_filter.flags & GblFiltersDef::FF_PHARM);
	} catch (GCD::AccessDenied&) {
		GDS_ASSERT (false);
	} catch (GCD::CanNotFindData&) {
		GDS_ASSERT (false);
	}
	//#UC END# *4CA499E100DA_4CA9CBD90227_SET*
}

// implemented method from FilterFromQuery
const bool FilterFromQuery_i::get_permanent () const {
	//#UC START# *4CA49BAF0086_4CA9CBD90227_GET*
	return m_filter.flags & GblFiltersDef::FF_PERMANENT;
	//#UC END# *4CA49BAF0086_4CA9CBD90227_GET*
}

void FilterFromQuery_i::set_permanent (bool permanent) {
	//#UC START# *4CA49BAF0086_4CA9CBD90227_SET*
	try {
		if (permanent) {
			ApplicationHelper::instance ()->get_cached_filters_manager ()->set_permanent_flag (this->get_id ());
			m_filter.flags |= GblFiltersDef::FF_PERMANENT;
		} else {
			ApplicationHelper::instance ()->get_cached_filters_manager ()->clean_permanent_flag (this->get_id ());
			m_filter.flags &= ~GblFiltersDef::FF_PERMANENT;
		}
		FiltersManager_var filters_manager (FiltersManagerFactory::make ());
		filters_manager->filter_permanence_changed (m_filter.flags & GblFiltersDef::FF_PHARM);
	} catch (GCD::CanNotFindData&) {
		GDS_ASSERT (false);
	}
	//#UC END# *4CA49BAF0086_4CA9CBD90227_SET*
}

// implemented method from FilterFromQuery
// если делать query Search::Query, каковым он и является, на модели получается дофига циклических
// связей, которые небыстро будет развязать
const EntityBase* FilterFromQuery_i::get_query () const {
	//#UC START# *4CA49B390335_4CA9CBD90227_GET*
	return FiltersQueryFactory::make (const_cast<FilterFromQuery_i*> (this));
	//#UC END# *4CA49B390335_4CA9CBD90227_GET*
}

EntityBase* FilterFromQuery_i::get_query () {
	return const_cast<EntityBase*>(((const FilterFromQuery_i*)this)->get_query ());
}

// implemented method from FilterFromQuery
void FilterFromQuery_i::save_to_server (const GblPilotQueryDef::Query& query) {
	//#UC START# *4CAD861D0284_4CA9CBD90227*
	GblFilters::Filter to_save;
	to_save.flags = m_filter.flags;
	to_save.id = m_filter.id;
	to_save.name = m_filter.name;
	to_save.query = query;
	try {
		ApplicationHelper::instance ()->get_cached_filters_manager ()->change_filter (to_save);
		this->clear_cache ();
		m_filter.query = query;

		FiltersManager_var filters_manager (FiltersManagerFactory::make ());
		filters_manager->clear_cache (m_filter.flags & GblFiltersDef::FF_PHARM);
	} catch (GCD::AccessDenied&) {
		GDS_ASSERT (false);
	} catch (GCD::CanNotFindData&) {
		GDS_ASSERT (false);
	} 
	//#UC END# *4CAD861D0284_4CA9CBD90227*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

