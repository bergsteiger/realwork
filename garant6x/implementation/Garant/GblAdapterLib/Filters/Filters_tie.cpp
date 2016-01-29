////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Filters/Filters_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Filters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID FilterFromQuery_tie::s_com_iid = {0xA81EFF04, 0xFAB6, 0x4D1B, {0x84, 0x6B, 0x66, 0xC3, 0x01, 0x59, 0x44, 0x70}};

FilterFromQuery_tie::IidRegistrator FilterFromQuery_tie::s_iid_registrator;

FilterFromQuery_tie::FilterFromQuery_tie () : m_impl(NULL) {
}

unsigned long __stdcall FilterFromQuery_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall FilterFromQuery_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FilterFromQuery_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FilterFromQuery_tie* const>(this));
	}
	return counter;
}

void FilterFromQuery_tie::init () {
		m_counter = 1;
	}

void FilterFromQuery_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* FilterFromQuery_tie::cast (::Core::IObject* obj) {
	FilterFromQuery* ret = dynamic_cast<FilterFromQuery*>(obj);
	if (ret) {
		ret->addref();
	}
	IFilterFromQuery_tie* ret_ = NULL;
	FilterFromQuery_tie::make_tie (ret, ret_);
	return ret_;
}

void FilterFromQuery_tie::make_cpp (const IFilterFromQuery_tie* obj, FilterFromQuery*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<FilterFromQuery*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void FilterFromQuery_tie::make_tie (const FilterFromQuery* obj, IFilterFromQuery_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		FilterFromQuery_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<FilterFromQuery*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void FilterFromQuery_tie::make_tie (const FilterFromQuery& obj, IFilterFromQuery_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	FilterFromQuery_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<FilterFromQuery*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* FilterFromQuery_tie::get_impl () const {
	return m_impl;
}


const bool __stdcall FilterFromQuery_tie::get_changeable () const {
_DLL_TRY
	return m_impl->get_changeable();
_DLL_CATCH
}


const unsigned long __stdcall FilterFromQuery_tie::get_id () const {
_DLL_TRY
	return m_impl->get_id();
_DLL_CATCH
}

bool __stdcall FilterFromQuery_tie::is_same_4CA9B8430333 (
	const IFilterFromQuery_tie* other
) const {
_DLL_TRY
	FilterFromQuery* other_;
	FilterFromQuery_tie::make_cpp(other, other_);

	bool ret = m_impl->is_same(other_);
	return ret;
_DLL_CATCH
}

bool __stdcall FilterFromQuery_tie::is_used_4CB6E46C024F () const {
_DLL_TRY
	return m_impl->is_used ();
_DLL_CATCH
}

void __stdcall FilterFromQuery_tie::mark_to_erase_4CA49BC000E5 () {
_DLL_TRY

	m_impl->mark_to_erase();
_DLL_CATCH
}

bool __stdcall FilterFromQuery_tie::marked_to_erase_4CB450AB03D8 () const {
_DLL_TRY
	return m_impl->marked_to_erase ();
_DLL_CATCH
}


void __stdcall FilterFromQuery_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_);
_DLL_CATCH
}
void __stdcall FilterFromQuery_tie::set_name (GCI::IO::IString_tie* name) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	m_impl->set_name(name_);
_DLL_CATCH
}


const bool __stdcall FilterFromQuery_tie::get_permanent () const {
_DLL_TRY
	return m_impl->get_permanent();
_DLL_CATCH
}
void __stdcall FilterFromQuery_tie::set_permanent (bool permanent) {
_DLL_TRY
	m_impl->set_permanent(permanent);
_DLL_CATCH
}


void __stdcall FilterFromQuery_tie::get_query (IEntityBase_tie*& ret_) {
_DLL_TRY
	EntityBase_tie::make_tie (m_impl->get_query(), ret_);
_DLL_CATCH
}



const ::Core::ComIID FiltersFromQuery_tie::s_com_iid = {0x85F5B5FA, 0x3FFE, 0x470E, {0x9F, 0x0B, 0x15, 0x77, 0x65, 0x26, 0x4E, 0x5D}};

unsigned long __stdcall FiltersFromQuery_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return 0x80004002UL;
	}
}

unsigned long __stdcall FiltersFromQuery_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FiltersFromQuery_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FiltersFromQuery_tie* const>(this));
	}
	return counter;
}

void FiltersFromQuery_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void FiltersFromQuery_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

FiltersFromQuery_tie::FiltersFromQuery_tie () : m_impl(NULL), m_orphan(true) {
}

void FiltersFromQuery_tie::make_cpp (const FiltersFromQuery_tie* obj, FiltersFromQuery*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void FiltersFromQuery_tie::new_tie (FiltersFromQuery* obj, FiltersFromQuery_tie*& ret_) {
	Core::Aptr<FiltersFromQuery> obj_aptr (obj);
	if (obj_aptr.is_nil ()) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = obj_aptr.forget ();
	}
}

void FiltersFromQuery_tie::make_tie (FiltersFromQuery* obj, FiltersFromQuery_tie*& ret_) {
	Core::Aptr<FiltersFromQuery> obj_aptr (obj);
	if (obj_aptr.is_nil () || obj_aptr->empty ()) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = obj_aptr.forget ();
	}
}
	
void FiltersFromQuery_tie::make_tie (const FiltersFromQuery& obj, FiltersFromQuery_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new FiltersFromQuery (obj);
	} else {
		ret_ = NULL;
	}
}

void FiltersFromQuery_tie::make_tie (const FiltersFromQuery& obj, FiltersFromQuery_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<FiltersFromQuery*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall FiltersFromQuery_tie::get_count () const {
	return m_impl->size();
}

void __stdcall FiltersFromQuery_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall FiltersFromQuery_tie::clear () {
	m_impl->clear();
}

void __stdcall FiltersFromQuery_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall FiltersFromQuery_tie::get_item (size_t index, IFilterFromQuery_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		FilterFromQuery_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall FiltersFromQuery_tie::set_item (size_t index, const IFilterFromQuery_tie* item) {
	if ((size_t)index < m_impl->size()) {
		FilterFromQuery* item_;
		FilterFromQuery_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall FiltersFromQuery_tie::add (const IFilterFromQuery_tie* item) {
	FilterFromQuery* item_;
	FilterFromQuery_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall FiltersFromQuery_tie::insert (size_t index, const IFilterFromQuery_tie* item) {
	if ((size_t)index < m_impl->size()) {
		FilterFromQuery* item_;
		FilterFromQuery_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID Filterable_tie::s_com_iid = {0x4C08EC41, 0x3957, 0x462B, {0xB9, 0xC1, 0xFB, 0x91, 0xB8, 0x64, 0x69, 0xBA}};

Filterable_tie::IidRegistrator Filterable_tie::s_iid_registrator;

Filterable_tie::Filterable_tie () : m_impl(NULL) {
}

unsigned long __stdcall Filterable_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall Filterable_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Filterable_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Filterable_tie* const>(this));
	}
	return counter;
}

void Filterable_tie::init () {
		m_counter = 1;
	}

void Filterable_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Filterable_tie::cast (::Core::IObject* obj) {
	Filterable* ret = dynamic_cast<Filterable*>(obj);
	if (ret) {
		ret->addref();
	}
	IFilterable_tie* ret_ = NULL;
	Filterable_tie::make_tie (ret, ret_);
	return ret_;
}

void Filterable_tie::make_cpp (const IFilterable_tie* obj, Filterable*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Filterable*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Filterable_tie::make_tie (const Filterable* obj, IFilterable_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Filterable_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Filterable*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Filterable_tie::make_tie (const Filterable& obj, IFilterable_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Filterable_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Filterable*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Filterable_tie::get_impl () const {
	return m_impl;
}


void __stdcall Filterable_tie::get_active_filters (FiltersFromQuery_tie*& ret_) const {
_DLL_TRY
	FiltersFromQuery_tie::make_tie (m_impl->get_active_filters(), ret_, this);
_DLL_CATCH
}

void __stdcall Filterable_tie::add_filter_45EEB02C03AA (
	IFilterFromQuery_tie* filter
	, bool auto_refresh
) /*throw (AllContentIsFiltered_tie, NotAllAttributesRestored_tie)*/ {
_DLL_TRY
	FilterFromQuery* filter_;
	FilterFromQuery_tie::make_cpp(filter, filter_);

	m_impl->add_filter(filter_, auto_refresh);
_DLL_CATCH
}

void __stdcall Filterable_tie::apply_filters_45EEB02C03B2 (
	const FiltersFromQuery_tie* filters
) /*throw (CanNotFindData_tie, AllContentIsFiltered_tie)*/ {
_DLL_TRY
	FiltersFromQuery* filters_;
	FiltersFromQuery_tie::make_cpp(filters, filters_);

	m_impl->apply_filters(*filters_);
_DLL_CATCH
}

void __stdcall Filterable_tie::clear_filters_45EEB02C03B0 () /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	m_impl->clear_filters();
_DLL_CATCH
}

void __stdcall Filterable_tie::delete_filter_45EEB02C03AD (
	const IFilterFromQuery_tie* filter
	, bool auto_refresh
) /*throw (CanNotFindData_tie, AllContentIsFiltered_tie)*/ {
_DLL_TRY
	FilterFromQuery* filter_;
	FilterFromQuery_tie::make_cpp(filter, filter_);

	m_impl->delete_filter(filter_, auto_refresh);
_DLL_CATCH
}


bool __stdcall Filterable_tie::get_has_active_filters () const {
_DLL_TRY
	return m_impl->get_has_active_filters();
_DLL_CATCH
}

void __stdcall Filterable_tie::refresh_filters_45EEB02C03B1 () /*throw (CanNotFindData_tie, AllContentIsFiltered_tie)*/ {
_DLL_TRY

	m_impl->refresh_filters();
_DLL_CATCH
}



void FilterNotifier_callback_tie::filter_name_changed () const {

	m_impl->filter_name_changed_4CB2B27F03C3();


}

void FilterNotifier_callback_tie::filter_permanence_changed () const {

	m_impl->filter_permanence_changed_4CB2B2910052();


}

void FilterNotifier_callback_tie::filters_changed () const {

	m_impl->filters_changed_4CB2B26B0365();


}



FilterNotifier_callback_tie::FilterNotifier_callback_tie () : m_impl(NULL), m_counter (1) {
}

unsigned long FilterNotifier_callback_tie::release () const {
	long const counter = --m_counter;

	if (counter == 0) {
		m_counter = 1;
		m_impl->release();
		m_impl = NULL;
		MyPool::instance()->release_obj(const_cast<FilterNotifier_callback_tie* const>(this));
	}
	return counter;
}

unsigned long FilterNotifier_callback_tie::addref () const {
		return ++m_counter;
	}

unsigned long FilterNotifier_callback_tie::ref_count () const {
	return m_counter.value ();
}

void FilterNotifier_callback_tie::init () {
}

void FilterNotifier_callback_tie::done () {
	m_impl = NULL;
}

void IFilterNotifier_tie::make_cpp (const IFilterNotifier_tie* obj, FilterNotifier*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		FilterNotifier_callback_tie* ret = FilterNotifier_callback_tie::MyPool::instance()->new_obj();
		ret->m_impl = const_cast<IFilterNotifier_tie*>(obj);
		ret->m_impl->addref ();
		ret_ = ret;
	}
}

void IFilterNotifier_tie::make_tie (IFilterNotifier_tie* obj, FilterNotifier_callback_tie*& ret_) {
	if (!obj) {
		ret_ = NULL;
	} else {
		//ret_ = MyPool::instance()->new_obj();
		//ret_->m_impl = obj;
	}
}

const ::Core::ComIID FiltersManager_tie::s_com_iid = {0x854B1550, 0xA048, 0x4551, {0xAB, 0x1C, 0x6F, 0xD0, 0x8F, 0xDA, 0xF7, 0x23}};

FiltersManager_tie::IidRegistrator FiltersManager_tie::s_iid_registrator;

FiltersManager_tie::FiltersManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall FiltersManager_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall FiltersManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FiltersManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FiltersManager_tie* const>(this));
	}
	return counter;
}

void FiltersManager_tie::init () {
		m_counter = 1;
	}

void FiltersManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* FiltersManager_tie::cast (::Core::IObject* obj) {
	FiltersManager* ret = dynamic_cast<FiltersManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IFiltersManager_tie* ret_ = NULL;
	FiltersManager_tie::make_tie (ret, ret_);
	return ret_;
}

void FiltersManager_tie::make_cpp (const IFiltersManager_tie* obj, FiltersManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<FiltersManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void FiltersManager_tie::make_tie (const FiltersManager* obj, IFiltersManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		FiltersManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<FiltersManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void FiltersManager_tie::make_tie (const FiltersManager& obj, IFiltersManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	FiltersManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<FiltersManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* FiltersManager_tie::get_impl () const {
	return m_impl;
}

void __stdcall FiltersManager_tie::create_filter_4CA49DE2023F (
	const IEntityBase_tie* query
	, const GCI::IO::IString_tie* name
) {
_DLL_TRY
	EntityBase* query_;
	EntityBase_tie::make_cpp(query, query_);
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);

	m_impl->create_filter(query_, name_);
_DLL_CATCH
}

void __stdcall FiltersManager_tie::get_legal_filters_4CA49C380277 (
	FiltersFromQuery_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<FiltersFromQuery> ret = m_impl->get_legal_filters();
	FiltersFromQuery_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall FiltersManager_tie::get_pharm_filters_4CA49DB202D1 (
	FiltersFromQuery_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<FiltersFromQuery> ret = m_impl->get_pharm_filters();
	FiltersFromQuery_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall FiltersManager_tie::set_legal_notifier_4CB2B31D02D1 (
	IFilterNotifier_tie* notifier
) {
_DLL_TRY
	FilterNotifier_var notifier_;
	IFilterNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->set_legal_notifier(notifier_.in ());
_DLL_CATCH
}

void __stdcall FiltersManager_tie::set_pharm_notifier_4CB2B344018E (
	IFilterNotifier_tie* notifier
) {
_DLL_TRY
	FilterNotifier_var notifier_;
	IFilterNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->set_pharm_notifier(notifier_.in ());
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

