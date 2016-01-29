////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewInterfaces/NewInterfaces_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NewInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NewInterfaces/NewInterfaces_tie.h"

namespace BasicTests {
namespace NewInterfaces {

const ::Core::ComIID NewFacet_tie::s_com_iid = {0x2CFA8895, 0x40F1, 0x4601, {0xB8, 0xE9, 0x52, 0x14, 0x7A, 0xDB, 0x59, 0xDC}};

NewFacet_tie::IidRegistrator NewFacet_tie::s_iid_registrator;

NewFacet_tie::NewFacet_tie () : m_impl(NULL) {
}

unsigned long __stdcall NewFacet_tie::query_interface (
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
unsigned long __stdcall NewFacet_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NewFacet_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NewFacet_tie* const>(this));
	}
	return counter;
}

void NewFacet_tie::init () {
		m_counter = 1;
	}

void NewFacet_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* NewFacet_tie::cast (::Core::IObject* obj) {
	NewFacet* ret = dynamic_cast<NewFacet*>(obj);
	if (ret) {
		ret->addref();
	}
	INewFacet_tie* ret_ = NULL;
	NewFacet_tie::make_tie (ret, ret_);
	return ret_;
}

void NewFacet_tie::make_cpp (const INewFacet_tie* obj, NewFacet*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<NewFacet*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void NewFacet_tie::make_tie (const NewFacet* obj, INewFacet_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		NewFacet_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<NewFacet*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void NewFacet_tie::make_tie (const NewFacet& obj, INewFacet_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	NewFacet_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<NewFacet*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* NewFacet_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID BaseInterface_tie::s_com_iid = {0x268B0A46, 0x3C2C, 0x4279, {0x91, 0x54, 0xEE, 0x5F, 0x93, 0xF5, 0x0C, 0xD1}};

BaseInterface_tie::IidRegistrator BaseInterface_tie::s_iid_registrator;

BaseInterface_tie::BaseInterface_tie () : m_impl(NULL) {
}

unsigned long __stdcall BaseInterface_tie::query_interface (
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
unsigned long __stdcall BaseInterface_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall BaseInterface_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<BaseInterface_tie* const>(this));
	}
	return counter;
}

void BaseInterface_tie::init () {
		m_counter = 1;
	}

void BaseInterface_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* BaseInterface_tie::cast (::Core::IObject* obj) {
	BaseInterface* ret = dynamic_cast<BaseInterface*>(obj);
	if (ret) {
		ret->addref();
	}
	IBaseInterface_tie* ret_ = NULL;
	BaseInterface_tie::make_tie (ret, ret_);
	return ret_;
}

void BaseInterface_tie::make_cpp (const IBaseInterface_tie* obj, BaseInterface*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<BaseInterface*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void BaseInterface_tie::make_tie (const BaseInterface* obj, IBaseInterface_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		BaseInterface_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<BaseInterface*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void BaseInterface_tie::make_tie (const BaseInterface& obj, IBaseInterface_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	BaseInterface_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<BaseInterface*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* BaseInterface_tie::get_impl () const {
	return m_impl;
}


long __stdcall BaseInterface_tie::get_agr_long_p () const {
_DLL_TRY
	return m_impl->get_agr_long_p();
_DLL_CATCH
}
void __stdcall BaseInterface_tie::set_agr_long_p (long agr_long_p) {
_DLL_TRY
	m_impl->set_agr_long_p(agr_long_p);
_DLL_CATCH
}


void __stdcall BaseInterface_tie::get_agr_struct_p (NewStruct& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_agr_struct_p();
_DLL_CATCH
}
void __stdcall BaseInterface_tie::set_agr_struct_p (const NewStruct agr_struct_p) {
_DLL_TRY
	m_impl->set_agr_struct_p(agr_struct_p);
_DLL_CATCH
}


const long __stdcall BaseInterface_tie::get_lnk_long_p () const {
_DLL_TRY
	return m_impl->get_lnk_long_p();
_DLL_CATCH
}
void __stdcall BaseInterface_tie::set_lnk_long_p (long lnk_long_p) {
_DLL_TRY
	m_impl->set_lnk_long_p(lnk_long_p);
_DLL_CATCH
}


void __stdcall BaseInterface_tie::get_lnk_struct_p (NewStruct& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_lnk_struct_p();
_DLL_CATCH
}
void __stdcall BaseInterface_tie::set_lnk_struct_p (const NewStruct lnk_struct_p) {
_DLL_TRY
	m_impl->set_lnk_struct_p(lnk_struct_p);
_DLL_CATCH
}



const ::Core::ComIID MySyperData_tie::s_com_iid = {0x535DCDCC, 0xE3CD, 0x4921, {0xAE, 0x63, 0x3E, 0x65, 0xF3, 0xAE, 0x5D, 0xA0}};

unsigned long __stdcall MySyperData_tie::query_interface (
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

unsigned long __stdcall MySyperData_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall MySyperData_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<MySyperData_tie* const>(this));
	}
	return counter;
}

void MySyperData_tie::init () {
	m_counter = 1;
}

void MySyperData_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

MySyperData_tie::MySyperData_tie () : m_impl(NULL), m_orphan(true) {
}

void MySyperData_tie::make_cpp (const MySyperData_tie* obj, MySyperData*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void MySyperData_tie::new_tie (MySyperData* obj, MySyperData_tie*& ret_) {
	Core::Aptr<MySyperData> obj_aptr (obj);
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

void MySyperData_tie::make_tie (MySyperData* obj, MySyperData_tie*& ret_) {
	Core::Aptr<MySyperData> obj_aptr (obj);
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
	
void MySyperData_tie::make_tie (const MySyperData& obj, MySyperData_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new MySyperData (obj);
	} else {
		ret_ = NULL;
	}
}

void MySyperData_tie::make_tie (const MySyperData& obj, MySyperData_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<MySyperData*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall MySyperData_tie::get_count () const {
	return m_impl->size();
}

void __stdcall MySyperData_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall MySyperData_tie::clear () {
	m_impl->clear();
}

void __stdcall MySyperData_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

long long __stdcall MySyperData_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall MySyperData_tie::set_item (size_t index, long long item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall MySyperData_tie::add (long long item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall MySyperData_tie::insert (size_t index, long long item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID DerivedInterface_tie::s_com_iid = {0x19342E98, 0xDAAF, 0x4338, {0x80, 0x6F, 0x19, 0xFA, 0x17, 0x80, 0x7B, 0xD7}};

DerivedInterface_tie::IidRegistrator DerivedInterface_tie::s_iid_registrator;

DerivedInterface_tie::DerivedInterface_tie () : m_impl(NULL) {
}

unsigned long __stdcall DerivedInterface_tie::query_interface (
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
unsigned long __stdcall DerivedInterface_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DerivedInterface_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DerivedInterface_tie* const>(this));
	}
	return counter;
}

void DerivedInterface_tie::init () {
		m_counter = 1;
	}

void DerivedInterface_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DerivedInterface_tie::cast (::Core::IObject* obj) {
	DerivedInterface* ret = dynamic_cast<DerivedInterface*>(obj);
	if (ret) {
		ret->addref();
	}
	IDerivedInterface_tie* ret_ = NULL;
	DerivedInterface_tie::make_tie (ret, ret_);
	return ret_;
}

void DerivedInterface_tie::make_cpp (const IDerivedInterface_tie* obj, DerivedInterface*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DerivedInterface*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DerivedInterface_tie::make_tie (const DerivedInterface* obj, IDerivedInterface_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DerivedInterface_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DerivedInterface*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DerivedInterface_tie::make_tie (const DerivedInterface& obj, IDerivedInterface_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DerivedInterface_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DerivedInterface*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DerivedInterface_tie::get_impl () const {
	return m_impl;
}


const long __stdcall DerivedInterface_tie::get_lnk_long_p () const {
_DLL_TRY
	return m_impl->get_lnk_long_p();
_DLL_CATCH
}
void __stdcall DerivedInterface_tie::set_lnk_long_p (long lnk_long_p) {
_DLL_TRY
	m_impl->set_lnk_long_p(lnk_long_p);
_DLL_CATCH
}


long __stdcall DerivedInterface_tie::get_agr_long_p () const {
_DLL_TRY
	return m_impl->get_agr_long_p();
_DLL_CATCH
}
void __stdcall DerivedInterface_tie::set_agr_long_p (long agr_long_p) {
_DLL_TRY
	m_impl->set_agr_long_p(agr_long_p);
_DLL_CATCH
}


void __stdcall DerivedInterface_tie::get_lnk_struct_p (NewStruct& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_lnk_struct_p();
_DLL_CATCH
}
void __stdcall DerivedInterface_tie::set_lnk_struct_p (const NewStruct lnk_struct_p) {
_DLL_TRY
	m_impl->set_lnk_struct_p(lnk_struct_p);
_DLL_CATCH
}


void __stdcall DerivedInterface_tie::get_agr_struct_p (NewStruct& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_agr_struct_p();
_DLL_CATCH
}
void __stdcall DerivedInterface_tie::set_agr_struct_p (const NewStruct agr_struct_p) {
_DLL_TRY
	m_impl->set_agr_struct_p(agr_struct_p);
_DLL_CATCH
}
void __stdcall DerivedInterface_tie::my_func_49BA60BC0263 (
	const MySyperData_tie* a
) const {
_DLL_TRY
	MySyperData* a_;
	MySyperData_tie::make_cpp(a, a_);

	m_impl->my_func(*a_);
_DLL_CATCH
}



const ::Core::ComIID AbstractInterface_tie::s_com_iid = {0x0B6686E6, 0xE9A2, 0x4B99, {0x9A, 0x3D, 0xD1, 0x47, 0xFD, 0xE8, 0x5A, 0x7D}};

AbstractInterface_tie::IidRegistrator AbstractInterface_tie::s_iid_registrator;

AbstractInterface_tie::AbstractInterface_tie () : m_impl(NULL) {
}

unsigned long __stdcall AbstractInterface_tie::query_interface (
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
unsigned long __stdcall AbstractInterface_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall AbstractInterface_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<AbstractInterface_tie* const>(this));
	}
	return counter;
}

void AbstractInterface_tie::init () {
		m_counter = 1;
	}

void AbstractInterface_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* AbstractInterface_tie::cast (::Core::IObject* obj) {
	AbstractInterface* ret = dynamic_cast<AbstractInterface*>(obj);
	if (ret) {
		ret->addref();
	}
	IAbstractInterface_tie* ret_ = NULL;
	AbstractInterface_tie::make_tie (ret, ret_);
	return ret_;
}

void AbstractInterface_tie::make_cpp (const IAbstractInterface_tie* obj, AbstractInterface*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<AbstractInterface*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void AbstractInterface_tie::make_tie (const AbstractInterface* obj, IAbstractInterface_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		AbstractInterface_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<AbstractInterface*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void AbstractInterface_tie::make_tie (const AbstractInterface& obj, IAbstractInterface_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	AbstractInterface_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<AbstractInterface*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* AbstractInterface_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID BaseInterface1_tie::s_com_iid = {0x1333AF92, 0x3BA9, 0x423A, {0x93, 0xFE, 0xCA, 0x55, 0xE8, 0x39, 0x08, 0xD6}};

BaseInterface1_tie::IidRegistrator BaseInterface1_tie::s_iid_registrator;

BaseInterface1_tie::BaseInterface1_tie () : m_impl(NULL) {
}

unsigned long __stdcall BaseInterface1_tie::query_interface (
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
unsigned long __stdcall BaseInterface1_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall BaseInterface1_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<BaseInterface1_tie* const>(this));
	}
	return counter;
}

void BaseInterface1_tie::init () {
		m_counter = 1;
	}

void BaseInterface1_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* BaseInterface1_tie::cast (::Core::IObject* obj) {
	BaseInterface1* ret = dynamic_cast<BaseInterface1*>(obj);
	if (ret) {
		ret->addref();
	}
	IBaseInterface1_tie* ret_ = NULL;
	BaseInterface1_tie::make_tie (ret, ret_);
	return ret_;
}

void BaseInterface1_tie::make_cpp (const IBaseInterface1_tie* obj, BaseInterface1*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<BaseInterface1*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void BaseInterface1_tie::make_tie (const BaseInterface1* obj, IBaseInterface1_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		BaseInterface1_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<BaseInterface1*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void BaseInterface1_tie::make_tie (const BaseInterface1& obj, IBaseInterface1_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	BaseInterface1_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<BaseInterface1*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* BaseInterface1_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID DerivedInterface1_tie::s_com_iid = {0x9DD46BE9, 0x04C5, 0x46C0, {0xAD, 0x6C, 0x42, 0x1D, 0x24, 0x71, 0x67, 0xD0}};

DerivedInterface1_tie::IidRegistrator DerivedInterface1_tie::s_iid_registrator;

DerivedInterface1_tie::DerivedInterface1_tie () : m_impl(NULL) {
}

unsigned long __stdcall DerivedInterface1_tie::query_interface (
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
unsigned long __stdcall DerivedInterface1_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DerivedInterface1_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DerivedInterface1_tie* const>(this));
	}
	return counter;
}

void DerivedInterface1_tie::init () {
		m_counter = 1;
	}

void DerivedInterface1_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DerivedInterface1_tie::cast (::Core::IObject* obj) {
	DerivedInterface1* ret = dynamic_cast<DerivedInterface1*>(obj);
	if (ret) {
		ret->addref();
	}
	IDerivedInterface1_tie* ret_ = NULL;
	DerivedInterface1_tie::make_tie (ret, ret_);
	return ret_;
}

void DerivedInterface1_tie::make_cpp (const IDerivedInterface1_tie* obj, DerivedInterface1*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DerivedInterface1*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DerivedInterface1_tie::make_tie (const DerivedInterface1* obj, IDerivedInterface1_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DerivedInterface1_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DerivedInterface1*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DerivedInterface1_tie::make_tie (const DerivedInterface1& obj, IDerivedInterface1_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DerivedInterface1_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DerivedInterface1*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DerivedInterface1_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID B_tie::s_com_iid = {0x9B54162D, 0xE9A3, 0x4E7A, {0xA1, 0xA3, 0x0E, 0x67, 0x29, 0x3E, 0xE5, 0x81}};

B_tie::IidRegistrator B_tie::s_iid_registrator;

B_tie::B_tie () : m_impl(NULL) {
}

unsigned long __stdcall B_tie::query_interface (
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
unsigned long __stdcall B_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall B_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<B_tie* const>(this));
	}
	return counter;
}

void B_tie::init () {
		m_counter = 1;
	}

void B_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* B_tie::cast (::Core::IObject* obj) {
	B* ret = dynamic_cast<B*>(obj);
	if (ret) {
		ret->addref();
	}
	IB_tie* ret_ = NULL;
	B_tie::make_tie (ret, ret_);
	return ret_;
}

void B_tie::make_cpp (const IB_tie* obj, B*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<B*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void B_tie::make_tie (const B* obj, IB_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		B_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<B*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void B_tie::make_tie (const B& obj, IB_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	B_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<B*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* B_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID A_tie::s_com_iid = {0x1820A425, 0xB86B, 0x4D50, {0x91, 0x36, 0xD9, 0x6B, 0x45, 0x0C, 0x4B, 0x8B}};

A_tie::IidRegistrator A_tie::s_iid_registrator;

A_tie::A_tie () : m_impl(NULL) {
}

unsigned long __stdcall A_tie::query_interface (
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
unsigned long __stdcall A_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall A_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<A_tie* const>(this));
	}
	return counter;
}

void A_tie::init () {
		m_counter = 1;
	}

void A_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* A_tie::cast (::Core::IObject* obj) {
	A* ret = dynamic_cast<A*>(obj);
	if (ret) {
		ret->addref();
	}
	IA_tie* ret_ = NULL;
	A_tie::make_tie (ret, ret_);
	return ret_;
}

void A_tie::make_cpp (const IA_tie* obj, A*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<A*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void A_tie::make_tie (const A* obj, IA_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		A_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<A*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void A_tie::make_tie (const A& obj, IA_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	A_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<A*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* A_tie::get_impl () const {
	return m_impl;
}

void __stdcall A_tie::op1_4C5BBE680333 (
	TieStruct& ret_
) const {
_DLL_TRY

	::Core::Aptr<TieStruct> ret = m_impl->op1();
	if (ret.ptr()) {
		*ret_ = *ret;
	}
_DLL_CATCH
}

void __stdcall A_tie::op2_4C5BBE9A0110 (
	const IMyB_tie* arg
) const {
_DLL_TRY
	MyB* arg_;
	MyB_tie::make_cpp(arg, arg_);

	m_impl->op2(arg_);
_DLL_CATCH
}



} // namespace NewInterfaces
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

