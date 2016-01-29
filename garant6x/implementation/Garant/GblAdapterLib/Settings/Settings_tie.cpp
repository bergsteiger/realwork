////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Settings/Settings_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID PropertyStringIDList_tie::s_com_iid = {0xDCCE2630, 0x0409, 0x48AF, {0xA7, 0xB9, 0x56, 0x7B, 0x08, 0x1C, 0xB9, 0xDE}};

unsigned long __stdcall PropertyStringIDList_tie::query_interface (
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

unsigned long __stdcall PropertyStringIDList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall PropertyStringIDList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<PropertyStringIDList_tie* const>(this));
	}
	return counter;
}

void PropertyStringIDList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void PropertyStringIDList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

PropertyStringIDList_tie::PropertyStringIDList_tie () : m_impl(NULL), m_orphan(true) {
}

void PropertyStringIDList_tie::make_cpp (const PropertyStringIDList_tie* obj, PropertyStringIDList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void PropertyStringIDList_tie::new_tie (PropertyStringIDList* obj, PropertyStringIDList_tie*& ret_) {
	Core::Aptr<PropertyStringIDList> obj_aptr (obj);
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

void PropertyStringIDList_tie::make_tie (PropertyStringIDList* obj, PropertyStringIDList_tie*& ret_) {
	Core::Aptr<PropertyStringIDList> obj_aptr (obj);
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
	
void PropertyStringIDList_tie::make_tie (const PropertyStringIDList& obj, PropertyStringIDList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new PropertyStringIDList (obj);
	} else {
		ret_ = NULL;
	}
}

void PropertyStringIDList_tie::make_tie (const PropertyStringIDList& obj, PropertyStringIDList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<PropertyStringIDList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall PropertyStringIDList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall PropertyStringIDList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall PropertyStringIDList_tie::clear () {
	m_impl->clear();
}

void __stdcall PropertyStringIDList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall PropertyStringIDList_tie::get_item (size_t index, GCI::IO::IString_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall PropertyStringIDList_tie::set_item (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall PropertyStringIDList_tie::add (const GCI::IO::IString_tie* item) {
	GCI::IO::String* item_;
	GCI::IO::String_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall PropertyStringIDList_tie::insert (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID BaseSettingsManager_tie::s_com_iid = {0x6BC8FA39, 0x42F0, 0x45D2, {0x82, 0x11, 0xD1, 0x40, 0x43, 0xAD, 0x16, 0xDD}};

BaseSettingsManager_tie::IidRegistrator BaseSettingsManager_tie::s_iid_registrator;

BaseSettingsManager_tie::BaseSettingsManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall BaseSettingsManager_tie::query_interface (
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
unsigned long __stdcall BaseSettingsManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall BaseSettingsManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<BaseSettingsManager_tie* const>(this));
	}
	return counter;
}

void BaseSettingsManager_tie::init () {
		m_counter = 1;
	}

void BaseSettingsManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* BaseSettingsManager_tie::cast (::Core::IObject* obj) {
	BaseSettingsManager* ret = dynamic_cast<BaseSettingsManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IBaseSettingsManager_tie* ret_ = NULL;
	BaseSettingsManager_tie::make_tie (ret, ret_);
	return ret_;
}

void BaseSettingsManager_tie::make_cpp (const IBaseSettingsManager_tie* obj, BaseSettingsManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<BaseSettingsManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void BaseSettingsManager_tie::make_tie (const BaseSettingsManager* obj, IBaseSettingsManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		BaseSettingsManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<BaseSettingsManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void BaseSettingsManager_tie::make_tie (const BaseSettingsManager& obj, IBaseSettingsManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	BaseSettingsManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<BaseSettingsManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* BaseSettingsManager_tie::get_impl () const {
	return m_impl;
}

bool __stdcall BaseSettingsManager_tie::get_bool_4AC4990B0238 (
	const PropertyStringID id
	, bool& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_bool (id, value);
_DLL_CATCH
}

bool __stdcall BaseSettingsManager_tie::get_int64_4AC4990F037A (
	const PropertyStringID id
	, long long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_int64 (id, value);
_DLL_CATCH
}

bool __stdcall BaseSettingsManager_tie::get_long_4AC49912024A (
	const PropertyStringID id
	, long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_long (id, value);
_DLL_CATCH
}

bool __stdcall BaseSettingsManager_tie::get_string_4AC499150301 (
	const PropertyStringID id
	, GCI::IO::IString_tie*& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	GCI::IO::String* value_ = 0;

	bool ret = m_impl->get_string(id, value_);
	GCI::IO::String_tie::make_tie(value_, value);
	return ret;
_DLL_CATCH
}

bool __stdcall BaseSettingsManager_tie::get_ulong_4AC49919002B (
	const PropertyStringID id
	, unsigned long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_ulong (id, value);
_DLL_CATCH
}

bool __stdcall BaseSettingsManager_tie::is_exist_4AC4993302A8 (
	const PropertyStringID id
) const {
_DLL_TRY
	return m_impl->is_exist (id);
_DLL_CATCH
}

void __stdcall BaseSettingsManager_tie::set_bool_4AC4991C01E1 (
	const PropertyStringID id
	, bool value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_bool(id, value);
_DLL_CATCH
}

void __stdcall BaseSettingsManager_tie::set_int64_4AC4991F02F1 (
	const PropertyStringID id
	, long long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_int64(id, value);
_DLL_CATCH
}

void __stdcall BaseSettingsManager_tie::set_long_4AC499220301 (
	const PropertyStringID id
	, long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_long(id, value);
_DLL_CATCH
}

void __stdcall BaseSettingsManager_tie::set_string_4AC4992601BC (
	const PropertyStringID id
	, const char* value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_string(id, value);
_DLL_CATCH
}

void __stdcall BaseSettingsManager_tie::set_ulong_4AC499290308 (
	const PropertyStringID id
	, unsigned long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_ulong(id, value);
_DLL_CATCH
}



const ::Core::ComIID SettingsManager_tie::s_com_iid = {0xC2012FB8, 0xDEC6, 0x408A, {0x89, 0x37, 0x3D, 0x7E, 0x13, 0xCB, 0xC8, 0x30}};

SettingsManager_tie::IidRegistrator SettingsManager_tie::s_iid_registrator;

SettingsManager_tie::SettingsManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall SettingsManager_tie::query_interface (
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
unsigned long __stdcall SettingsManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SettingsManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SettingsManager_tie* const>(this));
	}
	return counter;
}

void SettingsManager_tie::init () {
		m_counter = 1;
	}

void SettingsManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* SettingsManager_tie::cast (::Core::IObject* obj) {
	SettingsManager* ret = dynamic_cast<SettingsManager*>(obj);
	if (ret) {
		ret->addref();
	}
	ISettingsManager_tie* ret_ = NULL;
	SettingsManager_tie::make_tie (ret, ret_);
	return ret_;
}

void SettingsManager_tie::make_cpp (const ISettingsManager_tie* obj, SettingsManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<SettingsManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void SettingsManager_tie::make_tie (const SettingsManager* obj, ISettingsManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		SettingsManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<SettingsManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void SettingsManager_tie::make_tie (const SettingsManager& obj, ISettingsManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	SettingsManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<SettingsManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* SettingsManager_tie::get_impl () const {
	return m_impl;
}

bool __stdcall SettingsManager_tie::get_bool_4AC4990B0238 (
	const PropertyStringID id
	, bool& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_bool (id, value);
_DLL_CATCH
}

bool __stdcall SettingsManager_tie::get_int64_4AC4990F037A (
	const PropertyStringID id
	, long long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_int64 (id, value);
_DLL_CATCH
}

bool __stdcall SettingsManager_tie::get_long_4AC49912024A (
	const PropertyStringID id
	, long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_long (id, value);
_DLL_CATCH
}

bool __stdcall SettingsManager_tie::get_string_4AC499150301 (
	const PropertyStringID id
	, GCI::IO::IString_tie*& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	GCI::IO::String* value_ = 0;

	bool ret = m_impl->get_string(id, value_);
	GCI::IO::String_tie::make_tie(value_, value);
	return ret;
_DLL_CATCH
}

bool __stdcall SettingsManager_tie::get_ulong_4AC49919002B (
	const PropertyStringID id
	, unsigned long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_ulong (id, value);
_DLL_CATCH
}

void __stdcall SettingsManager_tie::set_bool_4AC4991C01E1 (
	const PropertyStringID id
	, bool value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_bool(id, value);
_DLL_CATCH
}

void __stdcall SettingsManager_tie::set_int64_4AC4991F02F1 (
	const PropertyStringID id
	, long long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_int64(id, value);
_DLL_CATCH
}

void __stdcall SettingsManager_tie::set_long_4AC499220301 (
	const PropertyStringID id
	, long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_long(id, value);
_DLL_CATCH
}

void __stdcall SettingsManager_tie::set_string_4AC4992601BC (
	const PropertyStringID id
	, const char* value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_string(id, value);
_DLL_CATCH
}

void __stdcall SettingsManager_tie::set_ulong_4AC499290308 (
	const PropertyStringID id
	, unsigned long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_ulong(id, value);
_DLL_CATCH
}

bool __stdcall SettingsManager_tie::is_exist_4AC4993302A8 (
	const PropertyStringID id
) const {
_DLL_TRY
	return m_impl->is_exist (id);
_DLL_CATCH
}
bool __stdcall SettingsManager_tie::get_definition_45EEDBE3011E (
	const PropertyStringID id
	, PropertyDefinition& definition
) const {
_DLL_TRY
	return m_impl->get_definition (id, definition);
_DLL_CATCH
}

bool __stdcall SettingsManager_tie::is_changed_45EEDBE3013F (
	const PropertyStringID id
) const {
_DLL_TRY
	return m_impl->is_changed (id);
_DLL_CATCH
}

bool __stdcall SettingsManager_tie::is_changed_set_4979D8CA0243 (
	const PropertyStringIDList_tie* id_list
) const {
_DLL_TRY
	PropertyStringIDList* id_list_;
	PropertyStringIDList_tie::make_cpp(id_list, id_list_);

	bool ret = m_impl->is_changed_set(*id_list_);
	return ret;
_DLL_CATCH
}

void __stdcall SettingsManager_tie::restore_default_45EEDBE3011A (
	const PropertyStringID id
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	m_impl->restore_default(id);
_DLL_CATCH
}

void __stdcall SettingsManager_tie::save_as_default_45EEDBE3011C (
	const PropertyStringID id
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	m_impl->save_as_default(id);
_DLL_CATCH
}



const ::Core::ComIID Configuration_tie::s_com_iid = {0xCB09ACB5, 0xD582, 0x477A, {0x8D, 0x4F, 0x98, 0xFC, 0x37, 0x66, 0xA1, 0xF9}};

Configuration_tie::IidRegistrator Configuration_tie::s_iid_registrator;

Configuration_tie::Configuration_tie () : m_impl(NULL) {
}

unsigned long __stdcall Configuration_tie::query_interface (
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
unsigned long __stdcall Configuration_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Configuration_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Configuration_tie* const>(this));
	}
	return counter;
}

void Configuration_tie::init () {
		m_counter = 1;
	}

void Configuration_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Configuration_tie::cast (::Core::IObject* obj) {
	Configuration* ret = dynamic_cast<Configuration*>(obj);
	if (ret) {
		ret->addref();
	}
	IConfiguration_tie* ret_ = NULL;
	Configuration_tie::make_tie (ret, ret_);
	return ret_;
}

void Configuration_tie::make_cpp (const IConfiguration_tie* obj, Configuration*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Configuration*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Configuration_tie::make_tie (const Configuration* obj, IConfiguration_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Configuration_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Configuration*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Configuration_tie::make_tie (const Configuration& obj, IConfiguration_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Configuration_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Configuration*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Configuration_tie::get_impl () const {
	return m_impl;
}

void __stdcall Configuration_tie::copy_45EEDBE3014F (
	IConfiguration_tie*& ret_
) const {
_DLL_TRY

	Configuration* ret = m_impl->copy();
	Configuration_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Configuration_tie::get_settings_45EEDBE30150 (
	ISettingsManager_tie*& ret_
) const {
_DLL_TRY

	SettingsManager* ret = m_impl->get_settings();
	SettingsManager_tie::make_tie(ret, ret_);
_DLL_CATCH
}


void __stdcall Configuration_tie::get_hint (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_hint(), ret_);
_DLL_CATCH
}
void __stdcall Configuration_tie::set_hint (GCI::IO::IString_tie* hint) {
_DLL_TRY
	GCI::IO::String* hint_;
	GCI::IO::String_tie::make_cpp(hint, hint_);
	m_impl->set_hint(hint_);
_DLL_CATCH
}


unsigned long __stdcall Configuration_tie::get_id () const {
_DLL_TRY
	return m_impl->get_id();
_DLL_CATCH
}


bool __stdcall Configuration_tie::get_is_readonly () const {
_DLL_TRY
	return m_impl->get_is_readonly();
_DLL_CATCH
}


void __stdcall Configuration_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_);
_DLL_CATCH
}
void __stdcall Configuration_tie::set_name (GCI::IO::IString_tie* name) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	m_impl->set_name(name_);
_DLL_CATCH
}

void __stdcall Configuration_tie::restore_default_values_45EEDBE3014D () const {
_DLL_TRY

	m_impl->restore_default_values();
_DLL_CATCH
}

void __stdcall Configuration_tie::save_values_as_default_45EEDBE3014E () const {
_DLL_TRY

	m_impl->save_values_as_default();
_DLL_CATCH
}


ConfigurationType __stdcall Configuration_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}



const ::Core::ComIID DefaultValuesChangesIndicator_tie::s_com_iid = {0x168D579E, 0x071E, 0x4626, {0x93, 0xBD, 0x75, 0x66, 0xFC, 0xAB, 0x78, 0x0E}};

DefaultValuesChangesIndicator_tie::IidRegistrator DefaultValuesChangesIndicator_tie::s_iid_registrator;

DefaultValuesChangesIndicator_tie::DefaultValuesChangesIndicator_tie () : m_impl(NULL) {
}

unsigned long __stdcall DefaultValuesChangesIndicator_tie::query_interface (
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
unsigned long __stdcall DefaultValuesChangesIndicator_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DefaultValuesChangesIndicator_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DefaultValuesChangesIndicator_tie* const>(this));
	}
	return counter;
}

void DefaultValuesChangesIndicator_tie::init () {
		m_counter = 1;
	}

void DefaultValuesChangesIndicator_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DefaultValuesChangesIndicator_tie::cast (::Core::IObject* obj) {
	DefaultValuesChangesIndicator* ret = dynamic_cast<DefaultValuesChangesIndicator*>(obj);
	if (ret) {
		ret->addref();
	}
	IDefaultValuesChangesIndicator_tie* ret_ = NULL;
	DefaultValuesChangesIndicator_tie::make_tie (ret, ret_);
	return ret_;
}

void DefaultValuesChangesIndicator_tie::make_cpp (const IDefaultValuesChangesIndicator_tie* obj, DefaultValuesChangesIndicator*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DefaultValuesChangesIndicator*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DefaultValuesChangesIndicator_tie::make_tie (const DefaultValuesChangesIndicator* obj, IDefaultValuesChangesIndicator_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DefaultValuesChangesIndicator_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DefaultValuesChangesIndicator*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DefaultValuesChangesIndicator_tie::make_tie (const DefaultValuesChangesIndicator& obj, IDefaultValuesChangesIndicator_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DefaultValuesChangesIndicator_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DefaultValuesChangesIndicator*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DefaultValuesChangesIndicator_tie::get_impl () const {
	return m_impl;
}


void __stdcall DefaultValuesChangesIndicator_tie::get_configuration (IConfiguration_tie*& ret_) {
_DLL_TRY
	Configuration_tie::make_tie (m_impl->get_configuration(), ret_);
_DLL_CATCH
}


DefaultValuesChangesState __stdcall DefaultValuesChangesIndicator_tie::get_state () const {
_DLL_TRY
	return m_impl->get_state();
_DLL_CATCH
}



const ::Core::ComIID Configurations_tie::s_com_iid = {0xCD0617AF, 0x269F, 0x4D25, {0x9A, 0x15, 0x52, 0x65, 0x9D, 0x32, 0x92, 0x72}};

unsigned long __stdcall Configurations_tie::query_interface (
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

unsigned long __stdcall Configurations_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Configurations_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Configurations_tie* const>(this));
	}
	return counter;
}

void Configurations_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void Configurations_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

Configurations_tie::Configurations_tie () : m_impl(NULL), m_orphan(true) {
}

void Configurations_tie::make_cpp (const Configurations_tie* obj, Configurations*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void Configurations_tie::new_tie (Configurations* obj, Configurations_tie*& ret_) {
	Core::Aptr<Configurations> obj_aptr (obj);
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

void Configurations_tie::make_tie (Configurations* obj, Configurations_tie*& ret_) {
	Core::Aptr<Configurations> obj_aptr (obj);
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
	
void Configurations_tie::make_tie (const Configurations& obj, Configurations_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new Configurations (obj);
	} else {
		ret_ = NULL;
	}
}

void Configurations_tie::make_tie (const Configurations& obj, Configurations_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<Configurations*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall Configurations_tie::get_count () const {
	return m_impl->size();
}

void __stdcall Configurations_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall Configurations_tie::clear () {
	m_impl->clear();
}

void __stdcall Configurations_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall Configurations_tie::get_item (size_t index, IConfiguration_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		Configuration_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall Configurations_tie::set_item (size_t index, const IConfiguration_tie* item) {
	if ((size_t)index < m_impl->size()) {
		Configuration* item_;
		Configuration_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall Configurations_tie::add (const IConfiguration_tie* item) {
	Configuration* item_;
	Configuration_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall Configurations_tie::insert (size_t index, const IConfiguration_tie* item) {
	if ((size_t)index < m_impl->size()) {
		Configuration* item_;
		Configuration_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID ConfigurationManager_tie::s_com_iid = {0xC0C7A25C, 0x7378, 0x40EA, {0x95, 0x93, 0x32, 0xB5, 0x90, 0xCC, 0x6D, 0x8E}};

ConfigurationManager_tie::IidRegistrator ConfigurationManager_tie::s_iid_registrator;

ConfigurationManager_tie::ConfigurationManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall ConfigurationManager_tie::query_interface (
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
unsigned long __stdcall ConfigurationManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ConfigurationManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ConfigurationManager_tie* const>(this));
	}
	return counter;
}

void ConfigurationManager_tie::init () {
		m_counter = 1;
	}

void ConfigurationManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ConfigurationManager_tie::cast (::Core::IObject* obj) {
	ConfigurationManager* ret = dynamic_cast<ConfigurationManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IConfigurationManager_tie* ret_ = NULL;
	ConfigurationManager_tie::make_tie (ret, ret_);
	return ret_;
}

void ConfigurationManager_tie::make_cpp (const IConfigurationManager_tie* obj, ConfigurationManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ConfigurationManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ConfigurationManager_tie::make_tie (const ConfigurationManager* obj, IConfigurationManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ConfigurationManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ConfigurationManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ConfigurationManager_tie::make_tie (const ConfigurationManager& obj, IConfigurationManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ConfigurationManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ConfigurationManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ConfigurationManager_tie::get_impl () const {
	return m_impl;
}


void __stdcall ConfigurationManager_tie::get_configurations (Configurations_tie*& ret_) const {
_DLL_TRY
	Configurations_tie::make_tie (m_impl->get_configurations(), ret_, this);
_DLL_CATCH
}

void __stdcall ConfigurationManager_tie::default_values_update_check_45EEDBE3014A (
	IDefaultValuesChangesIndicator_tie*& ret_
) {
_DLL_TRY

	DefaultValuesChangesIndicator* ret = m_impl->default_values_update_check();
	DefaultValuesChangesIndicator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ConfigurationManager_tie::get_active_45EEDBE30149 (
	IConfiguration_tie*& ret_
) {
_DLL_TRY

	Configuration* ret = m_impl->get_active();
	Configuration_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ConfigurationManager_tie::remove_45EEDBE30147 (
	const IConfiguration_tie* configuration
) /*throw (ConstantModify_tie, ConfigurationIsActiveNow_tie)*/ {
_DLL_TRY
	Configuration* configuration_;
	Configuration_tie::make_cpp(configuration, configuration_);

	m_impl->remove(configuration_);
_DLL_CATCH
}

void __stdcall ConfigurationManager_tie::set_active_45EEDBE30145 (
	const IConfiguration_tie* configuration
) {
_DLL_TRY
	Configuration* configuration_;
	Configuration_tie::make_cpp(configuration, configuration_);

	m_impl->set_active(configuration_);
_DLL_CATCH
}



const ::Core::ComIID PermanentSettingsManager_tie::s_com_iid = {0x4983A1B9, 0x5021, 0x4CE1, {0x8C, 0x13, 0x91, 0x28, 0x31, 0x39, 0x5F, 0xB8}};

PermanentSettingsManager_tie::IidRegistrator PermanentSettingsManager_tie::s_iid_registrator;

PermanentSettingsManager_tie::PermanentSettingsManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall PermanentSettingsManager_tie::query_interface (
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
unsigned long __stdcall PermanentSettingsManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall PermanentSettingsManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<PermanentSettingsManager_tie* const>(this));
	}
	return counter;
}

void PermanentSettingsManager_tie::init () {
		m_counter = 1;
	}

void PermanentSettingsManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* PermanentSettingsManager_tie::cast (::Core::IObject* obj) {
	PermanentSettingsManager* ret = dynamic_cast<PermanentSettingsManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IPermanentSettingsManager_tie* ret_ = NULL;
	PermanentSettingsManager_tie::make_tie (ret, ret_);
	return ret_;
}

void PermanentSettingsManager_tie::make_cpp (const IPermanentSettingsManager_tie* obj, PermanentSettingsManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<PermanentSettingsManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void PermanentSettingsManager_tie::make_tie (const PermanentSettingsManager* obj, IPermanentSettingsManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		PermanentSettingsManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<PermanentSettingsManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void PermanentSettingsManager_tie::make_tie (const PermanentSettingsManager& obj, IPermanentSettingsManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	PermanentSettingsManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<PermanentSettingsManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* PermanentSettingsManager_tie::get_impl () const {
	return m_impl;
}

bool __stdcall PermanentSettingsManager_tie::get_bool_4AC4990B0238 (
	const PropertyStringID id
	, bool& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_bool (id, value);
_DLL_CATCH
}

bool __stdcall PermanentSettingsManager_tie::get_int64_4AC4990F037A (
	const PropertyStringID id
	, long long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_int64 (id, value);
_DLL_CATCH
}

bool __stdcall PermanentSettingsManager_tie::get_long_4AC49912024A (
	const PropertyStringID id
	, long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_long (id, value);
_DLL_CATCH
}

bool __stdcall PermanentSettingsManager_tie::get_string_4AC499150301 (
	const PropertyStringID id
	, GCI::IO::IString_tie*& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	GCI::IO::String* value_ = 0;

	bool ret = m_impl->get_string(id, value_);
	GCI::IO::String_tie::make_tie(value_, value);
	return ret;
_DLL_CATCH
}

bool __stdcall PermanentSettingsManager_tie::get_ulong_4AC49919002B (
	const PropertyStringID id
	, unsigned long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_ulong (id, value);
_DLL_CATCH
}

void __stdcall PermanentSettingsManager_tie::set_bool_4AC4991C01E1 (
	const PropertyStringID id
	, bool value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_bool(id, value);
_DLL_CATCH
}

void __stdcall PermanentSettingsManager_tie::set_int64_4AC4991F02F1 (
	const PropertyStringID id
	, long long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_int64(id, value);
_DLL_CATCH
}

void __stdcall PermanentSettingsManager_tie::set_long_4AC499220301 (
	const PropertyStringID id
	, long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_long(id, value);
_DLL_CATCH
}

void __stdcall PermanentSettingsManager_tie::set_string_4AC4992601BC (
	const PropertyStringID id
	, const char* value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_string(id, value);
_DLL_CATCH
}

void __stdcall PermanentSettingsManager_tie::set_ulong_4AC499290308 (
	const PropertyStringID id
	, unsigned long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_ulong(id, value);
_DLL_CATCH
}

bool __stdcall PermanentSettingsManager_tie::is_exist_4AC4993302A8 (
	const PropertyStringID id
) const {
_DLL_TRY
	return m_impl->is_exist (id);
_DLL_CATCH
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

