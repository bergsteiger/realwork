////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Prime/Prime_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Prime
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/Prime_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID Prime_tie::s_com_iid = {0x12FF4660, 0x2E81, 0x43B8, {0x96, 0x3E, 0x4F, 0x30, 0x99, 0xDB, 0x73, 0xF1}};

Prime_tie::IidRegistrator Prime_tie::s_iid_registrator;

Prime_tie::Prime_tie () : m_impl(NULL) {
}

unsigned long __stdcall Prime_tie::query_interface (
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
unsigned long __stdcall Prime_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Prime_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Prime_tie* const>(this));
	}
	return counter;
}

void Prime_tie::init () {
		m_counter = 1;
	}

void Prime_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Prime_tie::cast (::Core::IObject* obj) {
	Prime* ret = dynamic_cast<Prime*>(obj);
	if (ret) {
		ret->addref();
	}
	IPrime_tie* ret_ = NULL;
	Prime_tie::make_tie (ret, ret_);
	return ret_;
}

void Prime_tie::make_cpp (const IPrime_tie* obj, Prime*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Prime*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Prime_tie::make_tie (const Prime* obj, IPrime_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Prime_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Prime*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Prime_tie::make_tie (const Prime& obj, IPrime_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Prime_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Prime*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Prime_tie::get_impl () const {
	return m_impl;
}


PrimeKey __stdcall Prime_tie::get_id () const {
_DLL_TRY
	return m_impl->get_id();
_DLL_CATCH
}


void __stdcall Prime_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}
void __stdcall Prime_tie::set_name (GCI::IO::IString_tie* name) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	m_impl->set_name(name_);
_DLL_CATCH
}


void __stdcall Prime_tie::get_query (IQuery_tie*& ret_) {
_DLL_TRY
	Query_tie::make_tie (m_impl->get_query(), ret_);
_DLL_CATCH
}
void __stdcall Prime_tie::set_query (IQuery_tie* query) {
_DLL_TRY
	Query* query_;
	Query_tie::make_cpp(query, query_);
	m_impl->set_query(query_);
_DLL_CATCH
}



const ::Core::ComIID PrimeList_tie::s_com_iid = {0xC91FCFAD, 0x1774, 0x4E01, {0x9C, 0x3D, 0xED, 0xA6, 0x00, 0x46, 0x9D, 0x85}};

unsigned long __stdcall PrimeList_tie::query_interface (
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

unsigned long __stdcall PrimeList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall PrimeList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<PrimeList_tie* const>(this));
	}
	return counter;
}

void PrimeList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void PrimeList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

PrimeList_tie::PrimeList_tie () : m_impl(NULL), m_orphan(true) {
}

void PrimeList_tie::make_cpp (const PrimeList_tie* obj, PrimeList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void PrimeList_tie::new_tie (PrimeList* obj, PrimeList_tie*& ret_) {
	Core::Aptr<PrimeList> obj_aptr (obj);
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

void PrimeList_tie::make_tie (PrimeList* obj, PrimeList_tie*& ret_) {
	Core::Aptr<PrimeList> obj_aptr (obj);
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
	
void PrimeList_tie::make_tie (const PrimeList& obj, PrimeList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new PrimeList (obj);
	} else {
		ret_ = NULL;
	}
}

void PrimeList_tie::make_tie (const PrimeList& obj, PrimeList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<PrimeList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall PrimeList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall PrimeList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall PrimeList_tie::clear () {
	m_impl->clear();
}

void __stdcall PrimeList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall PrimeList_tie::get_item (size_t index, IPrime_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		Prime_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall PrimeList_tie::set_item (size_t index, const IPrime_tie* item) {
	if ((size_t)index < m_impl->size()) {
		Prime* item_;
		Prime_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall PrimeList_tie::add (const IPrime_tie* item) {
	Prime* item_;
	Prime_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall PrimeList_tie::insert (size_t index, const IPrime_tie* item) {
	if ((size_t)index < m_impl->size()) {
		Prime* item_;
		Prime_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID KeysList_tie::s_com_iid = {0x85ABCF6B, 0x01B9, 0x43B1, {0x8E, 0x1B, 0x35, 0x4D, 0xCF, 0xA4, 0xA4, 0x7C}};

unsigned long __stdcall KeysList_tie::query_interface (
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

unsigned long __stdcall KeysList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall KeysList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<KeysList_tie* const>(this));
	}
	return counter;
}

void KeysList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void KeysList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

KeysList_tie::KeysList_tie () : m_impl(NULL), m_orphan(true) {
}

void KeysList_tie::make_cpp (const KeysList_tie* obj, KeysList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void KeysList_tie::new_tie (KeysList* obj, KeysList_tie*& ret_) {
	Core::Aptr<KeysList> obj_aptr (obj);
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

void KeysList_tie::make_tie (KeysList* obj, KeysList_tie*& ret_) {
	Core::Aptr<KeysList> obj_aptr (obj);
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
	
void KeysList_tie::make_tie (const KeysList& obj, KeysList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new KeysList (obj);
	} else {
		ret_ = NULL;
	}
}

void KeysList_tie::make_tie (const KeysList& obj, KeysList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<KeysList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall KeysList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall KeysList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall KeysList_tie::clear () {
	m_impl->clear();
}

void __stdcall KeysList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

PrimeKey __stdcall KeysList_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall KeysList_tie::set_item (size_t index, PrimeKey item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall KeysList_tie::add (PrimeKey item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall KeysList_tie::insert (size_t index, PrimeKey item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID PrimeManager_tie::s_com_iid = {0xA47D57BE, 0x0B61, 0x4917, {0x99, 0x29, 0xF2, 0x09, 0x2A, 0x1C, 0x87, 0x2F}};

PrimeManager_tie::IidRegistrator PrimeManager_tie::s_iid_registrator;

PrimeManager_tie::PrimeManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall PrimeManager_tie::query_interface (
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
unsigned long __stdcall PrimeManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall PrimeManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<PrimeManager_tie* const>(this));
	}
	return counter;
}

void PrimeManager_tie::init () {
		m_counter = 1;
	}

void PrimeManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* PrimeManager_tie::cast (::Core::IObject* obj) {
	PrimeManager* ret = dynamic_cast<PrimeManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IPrimeManager_tie* ret_ = NULL;
	PrimeManager_tie::make_tie (ret, ret_);
	return ret_;
}

void PrimeManager_tie::make_cpp (const IPrimeManager_tie* obj, PrimeManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<PrimeManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void PrimeManager_tie::make_tie (const PrimeManager* obj, IPrimeManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		PrimeManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<PrimeManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void PrimeManager_tie::make_tie (const PrimeManager& obj, IPrimeManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	PrimeManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<PrimeManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* PrimeManager_tie::get_impl () const {
	return m_impl;
}

void __stdcall PrimeManager_tie::add_47C29A6A0154 (
	const GCI::IO::IString_tie* name
	, const IQuery_tie* query
	, IPrime_tie*& ret_
) /*throw (DuplicateName_tie)*/ {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	Query* query_;
	Query_tie::make_cpp(query, query_);

	Prime* ret = m_impl->add(name_, query_);
	Prime_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall PrimeManager_tie::check_connection_to_online_server_5416C35E015D () const {
_DLL_TRY
	return m_impl->check_connection_to_online_server ();
_DLL_CATCH
}


bool __stdcall PrimeManager_tie::get_has_online_access () const {
_DLL_TRY
	return m_impl->get_has_online_access();
_DLL_CATCH
}


void __stdcall PrimeManager_tie::get_list (PrimeList_tie*& ret_) const {
_DLL_TRY
	PrimeList_tie::make_tie (m_impl->get_list(), ret_, this);
_DLL_CATCH
}

void __stdcall PrimeManager_tie::remove_47C29C2001FA (
	PrimeKey id
) {
_DLL_TRY

	m_impl->remove(id);
_DLL_CATCH
}

void __stdcall PrimeManager_tie::save_and_send_to_online_server_5411BC740155 () const {
_DLL_TRY

	m_impl->save_and_send_to_online_server();
_DLL_CATCH
}

void __stdcall PrimeManager_tie::save_list_to_xml_4BE3CF5C02CB (
	const KeysList_tie* keys
	, const char* xml_file_path
) const /*throw (UnknownExportError_tie)*/ {
_DLL_TRY
	KeysList* keys_;
	KeysList_tie::make_cpp(keys, keys_);

	m_impl->save_list_to_xml(*keys_, xml_file_path);
_DLL_CATCH
}

void __stdcall PrimeManager_tie::save_mail_delivery_task_47C5860401E8 (
	const char* xml_file_path
) const /*throw (UnknownExportError_tie)*/ {
_DLL_TRY

	m_impl->save_mail_delivery_task(xml_file_path);
_DLL_CATCH
}

void __stdcall PrimeManager_tie::share_prime_for_file_server_47D4FEDA03DC () const /*throw (UnknownExportError_tie)*/ {
_DLL_TRY

	m_impl->share_prime_for_file_server();
_DLL_CATCH
}

void __stdcall PrimeManager_tie::update_4C88A58B02D8 () const {
_DLL_TRY

	m_impl->update();
_DLL_CATCH
}



const ::Core::ComIID PrimeSettingsManager_tie::s_com_iid = {0x418BE07D, 0x88DB, 0x419E, {0xA6, 0x25, 0x51, 0xBE, 0x86, 0x7D, 0xC2, 0x12}};

PrimeSettingsManager_tie::IidRegistrator PrimeSettingsManager_tie::s_iid_registrator;

PrimeSettingsManager_tie::PrimeSettingsManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall PrimeSettingsManager_tie::query_interface (
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
unsigned long __stdcall PrimeSettingsManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall PrimeSettingsManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<PrimeSettingsManager_tie* const>(this));
	}
	return counter;
}

void PrimeSettingsManager_tie::init () {
		m_counter = 1;
	}

void PrimeSettingsManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* PrimeSettingsManager_tie::cast (::Core::IObject* obj) {
	PrimeSettingsManager* ret = dynamic_cast<PrimeSettingsManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IPrimeSettingsManager_tie* ret_ = NULL;
	PrimeSettingsManager_tie::make_tie (ret, ret_);
	return ret_;
}

void PrimeSettingsManager_tie::make_cpp (const IPrimeSettingsManager_tie* obj, PrimeSettingsManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<PrimeSettingsManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void PrimeSettingsManager_tie::make_tie (const PrimeSettingsManager* obj, IPrimeSettingsManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		PrimeSettingsManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<PrimeSettingsManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void PrimeSettingsManager_tie::make_tie (const PrimeSettingsManager& obj, IPrimeSettingsManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	PrimeSettingsManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<PrimeSettingsManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* PrimeSettingsManager_tie::get_impl () const {
	return m_impl;
}

bool __stdcall PrimeSettingsManager_tie::get_bool_4AC4990B0238 (
	const PropertyStringID id
	, bool& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_bool (id, value);
_DLL_CATCH
}

bool __stdcall PrimeSettingsManager_tie::get_int64_4AC4990F037A (
	const PropertyStringID id
	, long long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_int64 (id, value);
_DLL_CATCH
}

bool __stdcall PrimeSettingsManager_tie::get_long_4AC49912024A (
	const PropertyStringID id
	, long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_long (id, value);
_DLL_CATCH
}

bool __stdcall PrimeSettingsManager_tie::get_string_4AC499150301 (
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

bool __stdcall PrimeSettingsManager_tie::get_ulong_4AC49919002B (
	const PropertyStringID id
	, unsigned long& value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY
	return m_impl->get_ulong (id, value);
_DLL_CATCH
}

void __stdcall PrimeSettingsManager_tie::set_bool_4AC4991C01E1 (
	const PropertyStringID id
	, bool value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_bool(id, value);
_DLL_CATCH
}

void __stdcall PrimeSettingsManager_tie::set_int64_4AC4991F02F1 (
	const PropertyStringID id
	, long long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_int64(id, value);
_DLL_CATCH
}

void __stdcall PrimeSettingsManager_tie::set_long_4AC499220301 (
	const PropertyStringID id
	, long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_long(id, value);
_DLL_CATCH
}

void __stdcall PrimeSettingsManager_tie::set_string_4AC4992601BC (
	const PropertyStringID id
	, const char* value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_string(id, value);
_DLL_CATCH
}

void __stdcall PrimeSettingsManager_tie::set_ulong_4AC499290308 (
	const PropertyStringID id
	, unsigned long value
) /*throw (InvalidValueType_tie)*/ {
_DLL_TRY

	m_impl->set_ulong(id, value);
_DLL_CATCH
}

bool __stdcall PrimeSettingsManager_tie::is_exist_4AC4993302A8 (
	const PropertyStringID id
) const {
_DLL_TRY
	return m_impl->is_exist (id);
_DLL_CATCH
}


const ::Core::ComIID PrimeContractData_tie::s_com_iid = {0xDF3E6A6C, 0x4229, 0x4DFB, {0x8E, 0xCB, 0xCF, 0x4D, 0x7F, 0xC1, 0xDE, 0x95}};

PrimeContractData_tie::IidRegistrator PrimeContractData_tie::s_iid_registrator;

PrimeContractData_tie::PrimeContractData_tie () : m_impl(NULL) {
}

unsigned long __stdcall PrimeContractData_tie::query_interface (
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
unsigned long __stdcall PrimeContractData_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall PrimeContractData_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<PrimeContractData_tie* const>(this));
	}
	return counter;
}

void PrimeContractData_tie::init () {
		m_counter = 1;
	}

void PrimeContractData_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* PrimeContractData_tie::cast (::Core::IObject* obj) {
	PrimeContractData* ret = dynamic_cast<PrimeContractData*>(obj);
	if (ret) {
		ret->addref();
	}
	IPrimeContractData_tie* ret_ = NULL;
	PrimeContractData_tie::make_tie (ret, ret_);
	return ret_;
}

void PrimeContractData_tie::make_cpp (const IPrimeContractData_tie* obj, PrimeContractData*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<PrimeContractData*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void PrimeContractData_tie::make_tie (const PrimeContractData* obj, IPrimeContractData_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		PrimeContractData_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<PrimeContractData*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void PrimeContractData_tie::make_tie (const PrimeContractData& obj, IPrimeContractData_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	PrimeContractData_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<PrimeContractData*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* PrimeContractData_tie::get_impl () const {
	return m_impl;
}


void __stdcall PrimeContractData_tie::get_area (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_area(), ret_, this);
_DLL_CATCH
}


void __stdcall PrimeContractData_tie::get_client_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_client_name(), ret_, this);
_DLL_CATCH
}


void __stdcall PrimeContractData_tie::get_email (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_email(), ret_, this);
_DLL_CATCH
}

void __stdcall PrimeContractData_tie::get_contract_evd_form_4D38192E0375 (
	GCI::IO::IStream_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_contract_evd_form();
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}


void __stdcall PrimeContractData_tie::get_info_kind (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_info_kind(), ret_, this);
_DLL_CATCH
}


void __stdcall PrimeContractData_tie::get_organisation_type (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_organisation_type(), ret_, this);
_DLL_CATCH
}


void __stdcall PrimeContractData_tie::get_profession (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_profession(), ret_, this);
_DLL_CATCH
}


void __stdcall PrimeContractData_tie::get_taxes (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_taxes(), ret_, this);
_DLL_CATCH
}


void __stdcall PrimeContractData_tie::get_themes_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_themes_name(), ret_, this);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

