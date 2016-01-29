////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FiltersManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FiltersManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FiltersManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

//#UC START# *4CA9CBF3026F_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters_tie.h"
//#UC END# *4CA9CBF3026F_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4CA9CBF3026F*
// Класс-хак, который держит оболочечный инетрфейс, не увеличивая на нём счётчик ссылок.
// Нужен из-за циклической зависимости
class FilterNotifierHack : public FilterNotifier_callback_tie {
public:
	FilterNotifierHack (FilterNotifier_callback_tie* tie) {
		m_impl = tie->m_impl;
	}

	~FilterNotifierHack () {}

	unsigned long release () const {
		long const counter = --m_counter;

		if (counter == 0) {
			delete this;
		}
		return counter;
	}
};
//#UC END# *4CA9CBF3026F*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FiltersManager_i::FiltersManager_i ()
//#UC START# *4CA49C2A0318_4CA49E130064_4CA9CBF3026F_BASE_INIT*
: m_legal_filters (new GblFilters::FiltersList), m_pharm_filters (new GblFilters::FiltersList)
//#UC END# *4CA49C2A0318_4CA49E130064_4CA9CBF3026F_BASE_INIT*
{
	//#UC START# *4CA49C2A0318_4CA49E130064_4CA9CBF3026F_BODY*
	//#UC END# *4CA49C2A0318_4CA49E130064_4CA9CBF3026F_BODY*
}

FiltersManager_i::~FiltersManager_i () {
	//#UC START# *4CA9CBF3026F_DESTR_BODY*
	//#UC END# *4CA9CBF3026F_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

FiltersFromQuery* FiltersManager_i::get_adapter_list (const GblFilters::FiltersList& server_filters) const {
	//#UC START# *4CA9D62E0075*
	Core::Aptr<FiltersFromQuery> result = new FiltersFromQuery ();
	for (size_t i = 0; i < server_filters.length (); ++i) {
		result->push_back (FilterFromQueryFactory::make (server_filters[i]));
	}

	return result.forget ();
	//#UC END# *4CA9D62E0075*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from FiltersManager
void FiltersManager_i::clear_cache (bool pharm) {
	//#UC START# *508FB354014E_4CA9CBF3026F*
	if (pharm) {
		m_pharm_filters->length (0);
	} else {
		m_legal_filters->length (0);
	}
	//#UC END# *508FB354014E_4CA9CBF3026F*
}

// implemented method from FiltersManager
// создать новый фильтр
void FiltersManager_i::create_filter (const EntityBase* query, const GCI::IO::String* name) {
	//#UC START# *4CA49DE2023F_4CA9CBF3026F*
	const Query* adapter_query = dynamic_cast<const Query*> (query);
	if (adapter_query) {
		GblPilotQueryDef::Query_var to_save (const_cast<Query*> (adapter_query)->build_query ());
		ApplicationHelper::instance ()->get_cached_filters_manager ()->add_filter (to_save.in (), name->get_data ());
		if (
			((to_save->type == GblPilotQueryDef::QT_PHARM_SEARCH) 
			|| (to_save->type == GblPilotQueryDef::QT_PHARM_RUBRICATOR))
		) {
			m_pharm_filters->length (0);
			if (m_pharm_notifier.ptr ()) {
				m_pharm_notifier->filters_changed ();
			}
		} else {
			m_legal_filters->length (0);
			if (m_legal_notifier.ptr ()) {
				m_legal_notifier->filters_changed ();
			}
		}
	}
	//#UC END# *4CA49DE2023F_4CA9CBF3026F*
}

// implemented method from FiltersManager
void FiltersManager_i::filter_name_changed (bool pharm) const {
	//#UC START# *4CB2BAAC02FF_4CA9CBF3026F*
	if (pharm && m_pharm_notifier.ptr ()) {
		m_pharm_notifier->filter_name_changed ();
	} else if (m_legal_notifier.ptr ()) {
		m_legal_notifier->filter_name_changed ();
	}
	//#UC END# *4CB2BAAC02FF_4CA9CBF3026F*
}

// implemented method from FiltersManager
void FiltersManager_i::filter_permanence_changed (bool pharm) const {
	//#UC START# *4CB2BAC200E6_4CA9CBF3026F*
	if (pharm) {
		m_pharm_filters->length (0);
		if (m_pharm_notifier.ptr ()) {
			m_pharm_notifier->filter_permanence_changed ();
		}
	} else {
		m_legal_filters->length (0);
		if (m_legal_notifier.ptr ()) {
			m_legal_notifier->filter_permanence_changed ();	
		}
	}
	//#UC END# *4CB2BAC200E6_4CA9CBF3026F*
}

// implemented method from FiltersManager
void FiltersManager_i::filter_removed (bool pharm) const {
	//#UC START# *4CB2BAD9015D_4CA9CBF3026F*
	if (pharm) {
		m_pharm_filters->length (0);
		if (m_pharm_notifier.ptr ()) {
			m_pharm_notifier->filters_changed ();
		}
	} else {
		m_legal_filters->length (0);
		if (m_legal_notifier.ptr ()) {
			m_legal_notifier->filters_changed ();
		}
	}
	//#UC END# *4CB2BAD9015D_4CA9CBF3026F*
}

// implemented method from FiltersManager
// получить список фильтров для правовых документов
FiltersFromQuery* FiltersManager_i::get_legal_filters () const {
	//#UC START# *4CA49C380277_4CA9CBF3026F*
	if (!m_legal_filters->length ()) {
		m_legal_filters = 
			ApplicationHelper::instance ()->get_cached_filters_manager ()->get_user_legal_filters ();
	}
	return this->get_adapter_list (m_legal_filters.in ());
	//#UC END# *4CA49C380277_4CA9CBF3026F*
}

// implemented method from FiltersManager
FiltersFromQuery* FiltersManager_i::get_pharm_filters () const {
	//#UC START# *4CA49DB202D1_4CA9CBF3026F*
	if (!m_pharm_filters->length ()) {
		m_pharm_filters = 
			ApplicationHelper::instance ()->get_cached_filters_manager ()->get_user_pharm_filters ();
	}
	return this->get_adapter_list (m_pharm_filters.in ());
	//#UC END# *4CA49DB202D1_4CA9CBF3026F*
}

// implemented method from FiltersManager
void FiltersManager_i::set_legal_notifier (FilterNotifier* notifier) {
	//#UC START# *4CB2B31D02D1_4CA9CBF3026F*
	if (notifier) {
		m_legal_notifier = new FilterNotifierHack (dynamic_cast<FilterNotifier_callback_tie*> (notifier));
	} else {
		m_legal_notifier = 0;
	}
	//#UC END# *4CB2B31D02D1_4CA9CBF3026F*
}

// implemented method from FiltersManager
void FiltersManager_i::set_pharm_notifier (FilterNotifier* notifier) {
	//#UC START# *4CB2B344018E_4CA9CBF3026F*
	if (notifier) {
		m_pharm_notifier = new FilterNotifierHack (dynamic_cast<FilterNotifier_callback_tie*> (notifier));
	} else {
		m_pharm_notifier = 0;
	}
	//#UC END# *4CB2B344018E_4CA9CBF3026F*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from GSI::NotifyService::Consumer
// Для получения сообщений реализация перекрывает этот метод.
void FiltersManager_i::fire_event (const CORBA::Any& event) {
	//#UC START# *44A119280119_4CA9CBF3026F*
	GblPilotDef::UserNotify* user_notify = 0;
	
	if (!(event >>= user_notify)) {
		GDS_ASSERT (false);
	}

	if (user_notify->m_type == GblPilotDef::unt_shared_filters_changed) {
		GCD::Uid uid = 0;
		if (!(user_notify->m_data >>= uid)) {
			GDS_ASSERT (false);
		} else if (uid != ApplicationHelper::instance()->get_cached_current_user_id ()) {
			m_pharm_filters->length (0);
			m_legal_filters->length (0);
			if (m_pharm_notifier.ptr ()) {
				m_pharm_notifier->filters_changed ();
			}
			if (m_legal_notifier.ptr ()) {
				m_legal_notifier->filters_changed ();
			}
		}
	}
	//#UC END# *44A119280119_4CA9CBF3026F*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

