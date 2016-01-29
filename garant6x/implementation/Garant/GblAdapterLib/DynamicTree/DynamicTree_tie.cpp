////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID FilterForTree_tie::s_com_iid = {0x2EE1EBDC, 0x4804, 0x47C2, {0x96, 0x4A, 0x89, 0xBA, 0xBD, 0x67, 0xA4, 0x57}};

FilterForTree_tie::IidRegistrator FilterForTree_tie::s_iid_registrator;

FilterForTree_tie::FilterForTree_tie () : m_impl(NULL) {
}

unsigned long __stdcall FilterForTree_tie::query_interface (
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
unsigned long __stdcall FilterForTree_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FilterForTree_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FilterForTree_tie* const>(this));
	}
	return counter;
}

void FilterForTree_tie::init () {
		m_counter = 1;
	}

void FilterForTree_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* FilterForTree_tie::cast (::Core::IObject* obj) {
	FilterForTree* ret = dynamic_cast<FilterForTree*>(obj);
	if (ret) {
		ret->addref();
	}
	IFilterForTree_tie* ret_ = NULL;
	FilterForTree_tie::make_tie (ret, ret_);
	return ret_;
}

void FilterForTree_tie::make_cpp (const IFilterForTree_tie* obj, FilterForTree*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<FilterForTree*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void FilterForTree_tie::make_tie (const FilterForTree* obj, IFilterForTree_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		FilterForTree_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<FilterForTree*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void FilterForTree_tie::make_tie (const FilterForTree& obj, IFilterForTree_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	FilterForTree_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<FilterForTree*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* FilterForTree_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID FilterList_tie::s_com_iid = {0xB0B31EED, 0xB9B1, 0x4C7F, {0x91, 0x77, 0xC0, 0x90, 0xC9, 0xFB, 0x6E, 0x95}};

unsigned long __stdcall FilterList_tie::query_interface (
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

unsigned long __stdcall FilterList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FilterList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FilterList_tie* const>(this));
	}
	return counter;
}

void FilterList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void FilterList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

FilterList_tie::FilterList_tie () : m_impl(NULL), m_orphan(true) {
}

void FilterList_tie::make_cpp (const FilterList_tie* obj, FilterList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void FilterList_tie::new_tie (FilterList* obj, FilterList_tie*& ret_) {
	Core::Aptr<FilterList> obj_aptr (obj);
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

void FilterList_tie::make_tie (FilterList* obj, FilterList_tie*& ret_) {
	Core::Aptr<FilterList> obj_aptr (obj);
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
	
void FilterList_tie::make_tie (const FilterList& obj, FilterList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new FilterList (obj);
	} else {
		ret_ = NULL;
	}
}

void FilterList_tie::make_tie (const FilterList& obj, FilterList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<FilterList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall FilterList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall FilterList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall FilterList_tie::clear () {
	m_impl->clear();
}

void __stdcall FilterList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall FilterList_tie::get_item (size_t index, IFilterForTree_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		FilterForTree_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall FilterList_tie::set_item (size_t index, const IFilterForTree_tie* item) {
	if ((size_t)index < m_impl->size()) {
		FilterForTree* item_;
		FilterForTree_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall FilterList_tie::add (const IFilterForTree_tie* item) {
	FilterForTree* item_;
	FilterForTree_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall FilterList_tie::insert (size_t index, const IFilterForTree_tie* item) {
	if ((size_t)index < m_impl->size()) {
		FilterForTree* item_;
		FilterForTree_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID NodeIndexPath_tie::s_com_iid = {0xE3DAF1B3, 0x4170, 0x4A80, {0x9C, 0x3E, 0xD3, 0x72, 0xF4, 0x67, 0x19, 0xCC}};

unsigned long __stdcall NodeIndexPath_tie::query_interface (
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

unsigned long __stdcall NodeIndexPath_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NodeIndexPath_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NodeIndexPath_tie* const>(this));
	}
	return counter;
}

void NodeIndexPath_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void NodeIndexPath_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

NodeIndexPath_tie::NodeIndexPath_tie () : m_impl(NULL), m_orphan(true) {
}

void NodeIndexPath_tie::make_cpp (const NodeIndexPath_tie* obj, NodeIndexPath*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void NodeIndexPath_tie::new_tie (NodeIndexPath* obj, NodeIndexPath_tie*& ret_) {
	Core::Aptr<NodeIndexPath> obj_aptr (obj);
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

void NodeIndexPath_tie::make_tie (NodeIndexPath* obj, NodeIndexPath_tie*& ret_) {
	Core::Aptr<NodeIndexPath> obj_aptr (obj);
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
	
void NodeIndexPath_tie::make_tie (const NodeIndexPath& obj, NodeIndexPath_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new NodeIndexPath (obj);
	} else {
		ret_ = NULL;
	}
}

void NodeIndexPath_tie::make_tie (const NodeIndexPath& obj, NodeIndexPath_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<NodeIndexPath*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall NodeIndexPath_tie::get_count () const {
	return m_impl->size();
}

void __stdcall NodeIndexPath_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall NodeIndexPath_tie::clear () {
	m_impl->clear();
}

void __stdcall NodeIndexPath_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

IndexInParent __stdcall NodeIndexPath_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall NodeIndexPath_tie::set_item (size_t index, IndexInParent item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall NodeIndexPath_tie::add (IndexInParent item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall NodeIndexPath_tie::insert (size_t index, IndexInParent item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void FindPosition_tie::make_cpp (const FindPosition_tie& obj, FindPosition& ret_) {
		NodeIndexPath* ret_node_;
		NodeIndexPath_tie::make_cpp (obj.node, ret_node_);
		ret_.node = *ret_node_;
		ret_.begin = obj.begin;
		ret_.end = obj.end;
}

void FindPosition_tie::make_tie (const FindPosition& obj, FindPosition_tie& ret_) {
		ret_.node = 0;
		NodeIndexPath_tie::make_tie (obj.node, ret_.node);
		ret_.begin = obj.begin;
		ret_.end = obj.end;
}


const ::Core::ComIID FindPositionList_tie::s_com_iid = {0xDDC91DC6, 0xF8F6, 0x4682, {0xAE, 0xB9, 0x77, 0xB7, 0xD5, 0x74, 0xE9, 0xA5}};

unsigned long __stdcall FindPositionList_tie::query_interface (
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

unsigned long __stdcall FindPositionList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FindPositionList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FindPositionList_tie* const>(this));
	}
	return counter;
}

void FindPositionList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void FindPositionList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

FindPositionList_tie::FindPositionList_tie () : m_impl(NULL), m_orphan(true) {
}

void FindPositionList_tie::make_cpp (const FindPositionList_tie* obj, FindPositionList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void FindPositionList_tie::new_tie (FindPositionList* obj, FindPositionList_tie*& ret_) {
	Core::Aptr<FindPositionList> obj_aptr (obj);
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

void FindPositionList_tie::make_tie (FindPositionList* obj, FindPositionList_tie*& ret_) {
	Core::Aptr<FindPositionList> obj_aptr (obj);
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
	
void FindPositionList_tie::make_tie (const FindPositionList& obj, FindPositionList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new FindPositionList (obj);
	} else {
		ret_ = NULL;
	}
}

void FindPositionList_tie::make_tie (const FindPositionList& obj, FindPositionList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<FindPositionList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall FindPositionList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall FindPositionList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall FindPositionList_tie::clear () {
	m_impl->clear();
}

void __stdcall FindPositionList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall FindPositionList_tie::get_item (size_t index, FindPosition_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		FindPosition_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall FindPositionList_tie::set_item (size_t index, const FindPosition_tie& item) {
	if ((size_t)index < m_impl->size()) {
		FindPosition item_;
		FindPosition_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall FindPositionList_tie::add (const FindPosition_tie& item) {
	FindPosition item_;
	FindPosition_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall FindPositionList_tie::insert (size_t index, const FindPosition_tie& item) {
	if ((size_t)index < m_impl->size()) {
		FindPosition item_;
		FindPosition_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID LayerIdList_tie::s_com_iid = {0x65349303, 0x26F4, 0x4D82, {0xA5, 0x88, 0x1C, 0x42, 0x5E, 0x80, 0x40, 0xD0}};

unsigned long __stdcall LayerIdList_tie::query_interface (
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

unsigned long __stdcall LayerIdList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall LayerIdList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<LayerIdList_tie* const>(this));
	}
	return counter;
}

void LayerIdList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void LayerIdList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

LayerIdList_tie::LayerIdList_tie () : m_impl(NULL), m_orphan(true) {
}

void LayerIdList_tie::make_cpp (const LayerIdList_tie* obj, LayerIdList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void LayerIdList_tie::new_tie (LayerIdList* obj, LayerIdList_tie*& ret_) {
	Core::Aptr<LayerIdList> obj_aptr (obj);
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

void LayerIdList_tie::make_tie (LayerIdList* obj, LayerIdList_tie*& ret_) {
	Core::Aptr<LayerIdList> obj_aptr (obj);
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
	
void LayerIdList_tie::make_tie (const LayerIdList& obj, LayerIdList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new LayerIdList (obj);
	} else {
		ret_ = NULL;
	}
}

void LayerIdList_tie::make_tie (const LayerIdList& obj, LayerIdList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<LayerIdList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall LayerIdList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall LayerIdList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall LayerIdList_tie::clear () {
	m_impl->clear();
}

void __stdcall LayerIdList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

LayerId __stdcall LayerIdList_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall LayerIdList_tie::set_item (size_t index, LayerId item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall LayerIdList_tie::add (LayerId item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall LayerIdList_tie::insert (size_t index, LayerId item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID SortFilter_tie::s_com_iid = {0xD0268B80, 0x08CD, 0x419D, {0xBD, 0xF5, 0xD3, 0xDA, 0x7A, 0x12, 0x19, 0x9D}};

SortFilter_tie::IidRegistrator SortFilter_tie::s_iid_registrator;

SortFilter_tie::SortFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall SortFilter_tie::query_interface (
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
unsigned long __stdcall SortFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SortFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SortFilter_tie* const>(this));
	}
	return counter;
}

void SortFilter_tie::init () {
		m_counter = 1;
	}

void SortFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* SortFilter_tie::cast (::Core::IObject* obj) {
	SortFilter* ret = dynamic_cast<SortFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	ISortFilter_tie* ret_ = NULL;
	SortFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void SortFilter_tie::make_cpp (const ISortFilter_tie* obj, SortFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<SortFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void SortFilter_tie::make_tie (const SortFilter* obj, ISortFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		SortFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<SortFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void SortFilter_tie::make_tie (const SortFilter& obj, ISortFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	SortFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<SortFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* SortFilter_tie::get_impl () const {
	return m_impl;
}


SortOrder __stdcall SortFilter_tie::get_order () const {
_DLL_TRY
	return m_impl->get_order();
_DLL_CATCH
}
void __stdcall SortFilter_tie::set_order (SortOrder order) {
_DLL_TRY
	m_impl->set_order(order);
_DLL_CATCH
}


void __stdcall SortFilter_tie::get_sub_filter (ISortFilter_tie*& ret_) {
_DLL_TRY
	SortFilter_tie::make_tie (m_impl->get_sub_filter(), ret_);
_DLL_CATCH
}
void __stdcall SortFilter_tie::set_sub_filter (ISortFilter_tie* sub_filter) {
_DLL_TRY
	SortFilter* sub_filter_;
	SortFilter_tie::make_cpp(sub_filter, sub_filter_);
	m_impl->set_sub_filter(sub_filter_);
_DLL_CATCH
}


SortType __stdcall SortFilter_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}
void __stdcall SortFilter_tie::set_type (SortType type) {
_DLL_TRY
	m_impl->set_type(type);
_DLL_CATCH
}



const ::Core::ComIID TrimFilter_tie::s_com_iid = {0x31549898, 0xCEF0, 0x46C3, {0x94, 0xD9, 0x1D, 0x6F, 0xA7, 0x1A, 0x2C, 0x65}};

TrimFilter_tie::IidRegistrator TrimFilter_tie::s_iid_registrator;

TrimFilter_tie::TrimFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall TrimFilter_tie::query_interface (
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
unsigned long __stdcall TrimFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall TrimFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<TrimFilter_tie* const>(this));
	}
	return counter;
}

void TrimFilter_tie::init () {
		m_counter = 1;
	}

void TrimFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* TrimFilter_tie::cast (::Core::IObject* obj) {
	TrimFilter* ret = dynamic_cast<TrimFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	ITrimFilter_tie* ret_ = NULL;
	TrimFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void TrimFilter_tie::make_cpp (const ITrimFilter_tie* obj, TrimFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<TrimFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void TrimFilter_tie::make_tie (const TrimFilter* obj, ITrimFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		TrimFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<TrimFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void TrimFilter_tie::make_tie (const TrimFilter& obj, ITrimFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	TrimFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<TrimFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* TrimFilter_tie::get_impl () const {
	return m_impl;
}


bool __stdcall TrimFilter_tie::get_is_trimmed () const {
_DLL_TRY
	return m_impl->get_is_trimmed();
_DLL_CATCH
}
void __stdcall TrimFilter_tie::set_is_trimmed (bool is_trimmed) {
_DLL_TRY
	m_impl->set_is_trimmed(is_trimmed);
_DLL_CATCH
}



const ::Core::ComIID LayerFilter_tie::s_com_iid = {0x217D0932, 0xBA42, 0x439D, {0x8C, 0xCC, 0x77, 0xAB, 0xAB, 0x9F, 0x12, 0xD6}};

LayerFilter_tie::IidRegistrator LayerFilter_tie::s_iid_registrator;

LayerFilter_tie::LayerFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall LayerFilter_tie::query_interface (
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
unsigned long __stdcall LayerFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall LayerFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<LayerFilter_tie* const>(this));
	}
	return counter;
}

void LayerFilter_tie::init () {
		m_counter = 1;
	}

void LayerFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* LayerFilter_tie::cast (::Core::IObject* obj) {
	LayerFilter* ret = dynamic_cast<LayerFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	ILayerFilter_tie* ret_ = NULL;
	LayerFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void LayerFilter_tie::make_cpp (const ILayerFilter_tie* obj, LayerFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<LayerFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void LayerFilter_tie::make_tie (const LayerFilter* obj, ILayerFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		LayerFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<LayerFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void LayerFilter_tie::make_tie (const LayerFilter& obj, ILayerFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	LayerFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<LayerFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* LayerFilter_tie::get_impl () const {
	return m_impl;
}


LayerId __stdcall LayerFilter_tie::get_layer () const {
_DLL_TRY
	return m_impl->get_layer();
_DLL_CATCH
}
void __stdcall LayerFilter_tie::set_layer (LayerId layer) {
_DLL_TRY
	m_impl->set_layer(layer);
_DLL_CATCH
}



const ::Core::ComIID FindIterator_tie::s_com_iid = {0x7C8B08E1, 0x3BA1, 0x4122, {0x9E, 0x2F, 0x4F, 0xDC, 0xC7, 0x93, 0x53, 0x60}};

FindIterator_tie::IidRegistrator FindIterator_tie::s_iid_registrator;

FindIterator_tie::FindIterator_tie () : m_impl(NULL) {
}

unsigned long __stdcall FindIterator_tie::query_interface (
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
unsigned long __stdcall FindIterator_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FindIterator_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FindIterator_tie* const>(this));
	}
	return counter;
}

void FindIterator_tie::init () {
		m_counter = 1;
	}

void FindIterator_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* FindIterator_tie::cast (::Core::IObject* obj) {
	FindIterator* ret = dynamic_cast<FindIterator*>(obj);
	if (ret) {
		ret->addref();
	}
	IFindIterator_tie* ret_ = NULL;
	FindIterator_tie::make_tie (ret, ret_);
	return ret_;
}

void FindIterator_tie::make_cpp (const IFindIterator_tie* obj, FindIterator*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<FindIterator*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void FindIterator_tie::make_tie (const FindIterator* obj, IFindIterator_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		FindIterator_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<FindIterator*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void FindIterator_tie::make_tie (const FindIterator& obj, IFindIterator_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	FindIterator_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<FindIterator*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* FindIterator_tie::get_impl () const {
	return m_impl;
}


const unsigned long __stdcall FindIterator_tie::get_count () const {
_DLL_TRY
	return m_impl->get_count();
_DLL_CATCH
}

void __stdcall FindIterator_tie::get_position_461D00B9005D (
	FindPositionList_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<FindPositionList> ret = m_impl->get_position();
	FindPositionList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

bool __stdcall FindIterator_tie::is_first_49FEC51501D8 () const {
_DLL_TRY
	return m_impl->is_first ();
_DLL_CATCH
}

bool __stdcall FindIterator_tie::is_good_45EEC28202A2 () const {
_DLL_TRY
	return m_impl->is_good ();
_DLL_CATCH
}

void __stdcall FindIterator_tie::next_45EEC28202A0 () {
_DLL_TRY

	m_impl->next();
_DLL_CATCH
}

void __stdcall FindIterator_tie::prev_45EEC28202A1 () {
_DLL_TRY

	m_impl->prev();
_DLL_CATCH
}



const ::Core::ComIID SettingEntity_tie::s_com_iid = {0x3790FA3D, 0xD4C9, 0x4A31, {0x98, 0x64, 0xF3, 0xD1, 0xCE, 0x9E, 0x97, 0xB1}};

SettingEntity_tie::IidRegistrator SettingEntity_tie::s_iid_registrator;

SettingEntity_tie::SettingEntity_tie () : m_impl(NULL) {
}

unsigned long __stdcall SettingEntity_tie::query_interface (
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
unsigned long __stdcall SettingEntity_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall SettingEntity_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<SettingEntity_tie* const>(this));
	}
	return counter;
}

void SettingEntity_tie::init () {
		m_counter = 1;
	}

void SettingEntity_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* SettingEntity_tie::cast (::Core::IObject* obj) {
	SettingEntity* ret = dynamic_cast<SettingEntity*>(obj);
	if (ret) {
		ret->addref();
	}
	ISettingEntity_tie* ret_ = NULL;
	SettingEntity_tie::make_tie (ret, ret_);
	return ret_;
}

void SettingEntity_tie::make_cpp (const ISettingEntity_tie* obj, SettingEntity*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<SettingEntity*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void SettingEntity_tie::make_tie (const SettingEntity* obj, ISettingEntity_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		SettingEntity_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<SettingEntity*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void SettingEntity_tie::make_tie (const SettingEntity& obj, ISettingEntity_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	SettingEntity_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<SettingEntity*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* SettingEntity_tie::get_impl () const {
	return m_impl;
}

void __stdcall SettingEntity_tie::load_from_setting_45EECD5D02F1 (
	const PropertyID id
	, ISettingEntity_tie*& ret_
) const {
_DLL_TRY

	SettingEntity* ret = m_impl->load_from_setting(id);
	SettingEntity_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall SettingEntity_tie::save_in_setting_45EECD5D02EF (
	const PropertyID id
) const {
_DLL_TRY

	m_impl->save_in_setting(id);
_DLL_CATCH
}



const ::Core::ComIID NodesClipboard_tie::s_com_iid = {0xB990C46B, 0x9FF3, 0x4C7C, {0x8C, 0x61, 0x2D, 0xD2, 0x26, 0xFE, 0x64, 0x4E}};

NodesClipboard_tie::IidRegistrator NodesClipboard_tie::s_iid_registrator;

NodesClipboard_tie::NodesClipboard_tie () : m_impl(NULL) {
}

unsigned long __stdcall NodesClipboard_tie::query_interface (
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
unsigned long __stdcall NodesClipboard_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NodesClipboard_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NodesClipboard_tie* const>(this));
	}
	return counter;
}

void NodesClipboard_tie::init () {
		m_counter = 1;
	}

void NodesClipboard_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* NodesClipboard_tie::cast (::Core::IObject* obj) {
	NodesClipboard* ret = dynamic_cast<NodesClipboard*>(obj);
	if (ret) {
		ret->addref();
	}
	INodesClipboard_tie* ret_ = NULL;
	NodesClipboard_tie::make_tie (ret, ret_);
	return ret_;
}

void NodesClipboard_tie::make_cpp (const INodesClipboard_tie* obj, NodesClipboard*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<NodesClipboard*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void NodesClipboard_tie::make_tie (const NodesClipboard* obj, INodesClipboard_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		NodesClipboard_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<NodesClipboard*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void NodesClipboard_tie::make_tie (const NodesClipboard& obj, INodesClipboard_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	NodesClipboard_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<NodesClipboard*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* NodesClipboard_tie::get_impl () const {
	return m_impl;
}

void __stdcall NodesClipboard_tie::as_evd_45EECAA0007E (
	EVDGeneratorStyle style
	, GCI::IO::IStream_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->as_evd(style);
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}


unsigned long __stdcall NodesClipboard_tie::get_count () const {
_DLL_TRY
	return m_impl->get_count();
_DLL_CATCH
}



const ::Core::ComIID FakeFacetForFactory_tie::s_com_iid = {0x6AFFD7FC, 0xCA48, 0x450D, {0x8E, 0xB7, 0xE7, 0xE4, 0x7E, 0x04, 0xF9, 0xBF}};

FakeFacetForFactory_tie::IidRegistrator FakeFacetForFactory_tie::s_iid_registrator;

FakeFacetForFactory_tie::FakeFacetForFactory_tie () : m_impl(NULL) {
}

unsigned long __stdcall FakeFacetForFactory_tie::query_interface (
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
unsigned long __stdcall FakeFacetForFactory_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FakeFacetForFactory_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FakeFacetForFactory_tie* const>(this));
	}
	return counter;
}

void FakeFacetForFactory_tie::init () {
		m_counter = 1;
	}

void FakeFacetForFactory_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* FakeFacetForFactory_tie::cast (::Core::IObject* obj) {
	FakeFacetForFactory* ret = dynamic_cast<FakeFacetForFactory*>(obj);
	if (ret) {
		ret->addref();
	}
	IFakeFacetForFactory_tie* ret_ = NULL;
	FakeFacetForFactory_tie::make_tie (ret, ret_);
	return ret_;
}

void FakeFacetForFactory_tie::make_cpp (const IFakeFacetForFactory_tie* obj, FakeFacetForFactory*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<FakeFacetForFactory*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void FakeFacetForFactory_tie::make_tie (const FakeFacetForFactory* obj, IFakeFacetForFactory_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		FakeFacetForFactory_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<FakeFacetForFactory*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void FakeFacetForFactory_tie::make_tie (const FakeFacetForFactory& obj, IFakeFacetForFactory_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	FakeFacetForFactory_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<FakeFacetForFactory*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* FakeFacetForFactory_tie::get_impl () const {
	return m_impl;
}



void NodeNotifier_callback_tie::change_children_count (
	VisibleIndex node_index
	, long delta
	, const NodeIndexPath& index_path
	, IndexInParent child_index
) const {
	::Core::Var<NodeIndexPath_tie> index_path_;
	NodeIndexPath_tie::make_tie(index_path, index_path_.out());

	m_impl->change_children_count_45EEC8E102FE(node_index, delta, index_path_.in(), child_index);


}

void NodeNotifier_callback_tie::changed () const {

	m_impl->changed_45EEC8E10309();


}

void NodeNotifier_callback_tie::changing () const {

	m_impl->changing_45EEC8E10308();


}

NotifierID NodeNotifier_callback_tie::get_id () const {
	return m_impl->get_id_475E4B020072 ();
}

void NodeNotifier_callback_tie::invalidate (const NodeIndexPath& index_path) const {
	::Core::Var<NodeIndexPath_tie> index_path_;
	NodeIndexPath_tie::make_tie(index_path, index_path_.out());

	m_impl->invalidate_45EEC8E10306(index_path_.in());


}

bool NodeNotifier_callback_tie::is_one_level () const {
	return m_impl->is_one_level_45EEC8E10305 ();
}

bool NodeNotifier_callback_tie::is_root_visible () const {
	return m_impl->is_root_visible_45EEC8E10304 ();
}

void NodeNotifier_callback_tie::reset_children_count () const {

	m_impl->reset_children_count_45EEC8E10303();


}



NodeNotifier_callback_tie::NodeNotifier_callback_tie () : m_impl(NULL), m_counter (1) {
}

unsigned long NodeNotifier_callback_tie::release () const {
	long const counter = --m_counter;

	if (counter == 0) {
		m_counter = 1;
		m_impl->release();
		m_impl = NULL;
		MyPool::instance()->release_obj(const_cast<NodeNotifier_callback_tie* const>(this));
	}
	return counter;
}

unsigned long NodeNotifier_callback_tie::addref () const {
		return ++m_counter;
	}

unsigned long NodeNotifier_callback_tie::ref_count () const {
	return m_counter.value ();
}

void NodeNotifier_callback_tie::init () {
}

void NodeNotifier_callback_tie::done () {
	m_impl = NULL;
}

void INodeNotifier_tie::make_cpp (const INodeNotifier_tie* obj, NodeNotifier*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		NodeNotifier_callback_tie* ret = NodeNotifier_callback_tie::MyPool::instance()->new_obj();
		ret->m_impl = const_cast<INodeNotifier_tie*>(obj);
		ret->m_impl->addref ();
		ret_ = ret;
	}
}

void INodeNotifier_tie::make_tie (INodeNotifier_tie* obj, NodeNotifier_callback_tie*& ret_) {
	if (!obj) {
		ret_ = NULL;
	} else {
		//ret_ = MyPool::instance()->new_obj();
		//ret_->m_impl = obj;
	}
}


const unsigned long ListForFiltering_callback_tie::get_count () const {
_DLL_TRY
	return m_impl->get_count();
_DLL_CATCH
}

GCI::IO::String* ListForFiltering_callback_tie::item (unsigned long index) const {
	::Core::Var<GCI::IO::IString_tie> ret_;

	m_impl->item_4D3D26DC0123(index, ret_.out());

	GCI::IO::String* ret = NULL;
	GCI::IO::String_tie::make_cpp(ret_.in (), ret, true);
	return ret;
}



ListForFiltering_callback_tie::ListForFiltering_callback_tie () : m_impl(NULL), m_counter (1) {
}

unsigned long ListForFiltering_callback_tie::release () const {
	long const counter = --m_counter;

	if (counter == 0) {
		m_counter = 1;
		m_impl->release();
		m_impl = NULL;
		MyPool::instance()->release_obj(const_cast<ListForFiltering_callback_tie* const>(this));
	}
	return counter;
}

unsigned long ListForFiltering_callback_tie::addref () const {
		return ++m_counter;
	}

unsigned long ListForFiltering_callback_tie::ref_count () const {
	return m_counter.value ();
}

void ListForFiltering_callback_tie::init () {
}

void ListForFiltering_callback_tie::done () {
	m_impl = NULL;
}

void IListForFiltering_tie::make_cpp (const IListForFiltering_tie* obj, ListForFiltering*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		ListForFiltering_callback_tie* ret = ListForFiltering_callback_tie::MyPool::instance()->new_obj();
		ret->m_impl = const_cast<IListForFiltering_tie*>(obj);
		ret->m_impl->addref ();
		ret_ = ret;
	}
}

void IListForFiltering_tie::make_tie (IListForFiltering_tie* obj, ListForFiltering_callback_tie*& ret_) {
	if (!obj) {
		ret_ = NULL;
	} else {
		//ret_ = MyPool::instance()->new_obj();
		//ret_->m_impl = obj;
	}
}

const ::Core::ComIID NodeBase_tie::s_com_iid = {0x954590CB, 0xD1B3, 0x44B3, {0x84, 0x92, 0x65, 0x0D, 0x28, 0xA0, 0xCD, 0x8F}};

NodeBase_tie::IidRegistrator NodeBase_tie::s_iid_registrator;

NodeBase_tie::NodeBase_tie () : m_impl(NULL) {
}

unsigned long __stdcall NodeBase_tie::query_interface (
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
unsigned long __stdcall NodeBase_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NodeBase_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NodeBase_tie* const>(this));
	}
	return counter;
}

void NodeBase_tie::init () {
		m_counter = 1;
	}

void NodeBase_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* NodeBase_tie::cast (::Core::IObject* obj) {
	NodeBase* ret = dynamic_cast<NodeBase*>(obj);
	if (ret) {
		ret->addref();
	}
	INodeBase_tie* ret_ = NULL;
	NodeBase_tie::make_tie (ret, ret_);
	return ret_;
}

void NodeBase_tie::make_cpp (const INodeBase_tie* obj, NodeBase*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<NodeBase*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void NodeBase_tie::make_tie (const NodeBase* obj, INodeBase_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		NodeBase_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<NodeBase*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void NodeBase_tie::make_tie (const NodeBase& obj, INodeBase_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	NodeBase_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<NodeBase*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* NodeBase_tie::get_impl () const {
	return m_impl;
}

void __stdcall NodeBase_tie::save_in_setting_45EECD5D02EF (
	const PropertyID id
) const {
_DLL_TRY

	m_impl->save_in_setting(id);
_DLL_CATCH
}

void __stdcall NodeBase_tie::load_from_setting_45EECD5D02F1 (
	const PropertyID id
	, ISettingEntity_tie*& ret_
) const {
_DLL_TRY

	SettingEntity* ret = m_impl->load_from_setting(id);
	SettingEntity_tie::make_tie(ret, ret_);
_DLL_CATCH
}
void __stdcall NodeBase_tie::add_last_child_45EEB9590211 (
	INodeBase_tie* node
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	m_impl->add_last_child(node_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::add_last_childs_45EEB959020F (
	INodesClipboard_tie* nodes
) {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->add_last_childs(nodes_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::add_notifier_45EEB95901C7 (
	INodeNotifier_tie* notifier
) {
_DLL_TRY
	NodeNotifier_var notifier_;
	INodeNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->add_notifier(notifier_.in ());
_DLL_CATCH
}

void __stdcall NodeBase_tie::add_prev_sibling_45EEB9590215 (
	INodeBase_tie* node
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	m_impl->add_prev_sibling(node_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::add_prev_siblings_45EEB9590213 (
	INodesClipboard_tie* nodes
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	m_impl->add_prev_siblings(nodes_);
_DLL_CATCH
}


void __stdcall NodeBase_tie::get_caption (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_caption(), ret_, this);
_DLL_CATCH
}


long __stdcall NodeBase_tie::get_child_count () const {
_DLL_TRY
	return m_impl->get_child_count();
_DLL_CATCH
}

void __stdcall NodeBase_tie::commit_change_transaction_45EEB9590219 () {
_DLL_TRY

	m_impl->commit_change_transaction();
_DLL_CATCH
}

void __stdcall NodeBase_tie::copy_nodes_45EEB959020C (
	FlagMask mask
	, INodesClipboard_tie*& ret_
) {
_DLL_TRY

	NodesClipboard* ret = m_impl->copy_nodes(mask);
	NodesClipboard_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::create_view_ex_45EEB95901C9 (
	const FilterList_tie* filter
	, FlagMask shared_flags
	, const INodeBase_tie* sync_node
	, VisibleIndex& sync_index
	, unsigned long levels
	, bool unfiltered
	, bool auto_open
	, bool truncate_this_view
	, INodeBase_tie*& ret_
) {
_DLL_TRY
	FilterList* filter_;
	FilterList_tie::make_cpp(filter, filter_);
	NodeBase* sync_node_;
	NodeBase_tie::make_cpp(sync_node, sync_node_);

	NodeBase* ret = m_impl->create_view_ex(*filter_, shared_flags, sync_node_, sync_index, levels, unfiltered, auto_open, truncate_this_view);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::delete_node_45EEB959020B () {
_DLL_TRY

	m_impl->delete_node();
_DLL_CATCH_RETURNED
}

void __stdcall NodeBase_tie::delete_nodes_45EEB9590209 (
	FlagMask mask
) /*throw (ConstantModify_tie)*/ {
_DLL_TRY

	m_impl->delete_nodes(mask);
_DLL_CATCH_RETURNED
}


void __stdcall NodeBase_tie::get_entity (IEntityBase_tie*& ret_) /*throw (NoEntity_tie)*/ {
_DLL_TRY
	EntityBase_tie::make_tie (m_impl->get_entity(), ret_);
_DLL_CATCH
}
void __stdcall NodeBase_tie::set_entity (IEntityBase_tie* entity) {
_DLL_TRY
	EntityBase* entity_;
	EntityBase_tie::make_cpp(entity, entity_);
	m_impl->set_entity(entity_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::expand_all_45EEB9590220 (
	bool expand
) {
_DLL_TRY

	m_impl->expand_all(expand);
_DLL_CATCH
}

void __stdcall NodeBase_tie::find_45EEB959021C (
	const FilterList_tie* filter
	, const NodePosition_tie& find_from
	, IFindIterator_tie*& ret_
) const {
_DLL_TRY
	FilterList* filter_;
	FilterList_tie::make_cpp(filter, filter_);
	NodePosition find_from_;
	NodePosition_tie::make_cpp(find_from, find_from_);

	FindIterator* ret = m_impl->find(*filter_, find_from_);
	FindIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::find_node_45EEB95901D2 (
	const INodeBase_tie* node_to_find
	, INodeBase_tie*& ret_
) const {
_DLL_TRY
	NodeBase* node_to_find_;
	NodeBase_tie::make_cpp(node_to_find, node_to_find_);

	NodeBase* ret = m_impl->find_node(node_to_find_);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::find_node_path_45EEB95901D4 (
	INodeBase_tie* node_to_find
	, NodeIndexPath_tie*& ret_
) const {
_DLL_TRY
	NodeBase* node_to_find_;
	NodeBase_tie::make_cpp(node_to_find, node_to_find_);

	::Core::Aptr<NodeIndexPath> ret = m_impl->find_node_path(node_to_find_);
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}


void __stdcall NodeBase_tie::get_first_child (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_first_child(), ret_);
_DLL_CATCH
}

VisibleIndex __stdcall NodeBase_tie::get_abs_index_45EEB95901E6 () const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY
	return m_impl->get_abs_index ();
_DLL_CATCH
}

void __stdcall NodeBase_tie::get_available_layers_46236D06007D (
	LayerIdList_tie*& ret_
) const {
_DLL_TRY

	::Core::Aptr<LayerIdList> ret = m_impl->get_available_layers();
	LayerIdList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::get_by_sibbling_index_45EEB95901D6 (
	VisibleIndex ind
	, INodeBase_tie*& ret_
) {
_DLL_TRY

	NodeBase* ret = m_impl->get_by_sibbling_index(ind);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::get_by_visible_index_45EEB95901D8 (
	VisibleIndex ind
	, INodeBase_tie*& ret_
) {
_DLL_TRY

	NodeBase* ret = m_impl->get_by_visible_index(ind);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::get_child_path_by_abs_index_45EEB95901E7 (
	VisibleIndex index
	, NodeIndexPath_tie*& ret_
) const /*throw (CanNotFindData_tie)*/ {
_DLL_TRY

	::Core::Aptr<NodeIndexPath> ret = m_impl->get_child_path_by_abs_index(index);
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::get_first_fit_45EEB95901DA (
	const FilterList_tie* filter
	, NodeIndexPath_tie*& ret_
) const {
_DLL_TRY
	FilterList* filter_;
	FilterList_tie::make_cpp(filter, filter_);

	::Core::Aptr<NodeIndexPath> ret = m_impl->get_first_fit(*filter_);
	NodeIndexPath_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

unsigned long __stdcall NodeBase_tie::get_first_level_children_flag_count_4677A5180213 (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->get_first_level_children_flag_count (flag);
_DLL_CATCH
}

unsigned long __stdcall NodeBase_tie::get_flag_count_45EEB95901DC (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->get_flag_count (flag);
_DLL_CATCH
}

void __stdcall NodeBase_tie::get_frozen_node_4624DEED008C (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_frozen_node();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

VisibleIndex __stdcall NodeBase_tie::get_index_from_parent_45EEB95901E5 () const {
_DLL_TRY
	return m_impl->get_index_from_parent ();
_DLL_CATCH
}

void __stdcall NodeBase_tie::get_node_by_path_45EEB959021A (
	const NodeIndexPath_tie* path
	, INodeBase_tie*& ret_
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	NodeIndexPath* path_;
	NodeIndexPath_tie::make_cpp(path, path_);

	NodeBase* ret = m_impl->get_node_by_path(*path_);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

NodeId __stdcall NodeBase_tie::get_node_id_45EEB95901DE () const {
_DLL_TRY
	return m_impl->get_node_id ();
_DLL_CATCH
}

void __stdcall NodeBase_tie::get_unfiltered_node_4625D15D0138 (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_unfiltered_node();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

VisibleIndex __stdcall NodeBase_tie::get_visible_delta_45EEB95901E1 (
	const INodeBase_tie* node
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	VisibleIndex ret = m_impl->get_visible_delta(node_);
	return ret;
_DLL_CATCH
}

VisibleIndex __stdcall NodeBase_tie::get_visible_delta_by_entity_45EEB95901E3 (
	const IEntityBase_tie* entity
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	EntityBase* entity_;
	EntityBase_tie::make_cpp(entity, entity_);

	VisibleIndex ret = m_impl->get_visible_delta_by_entity(entity_);
	return ret;
_DLL_CATCH
}

bool __stdcall NodeBase_tie::has_children_45EEB95901EA () const {
_DLL_TRY
	return m_impl->has_children ();
_DLL_CATCH
}

bool __stdcall NodeBase_tie::has_children_flag_45EEB95901EB (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_children_flag (flag);
_DLL_CATCH
}

bool __stdcall NodeBase_tie::has_filtered_children_45EEB95901ED () const {
_DLL_TRY
	return m_impl->has_filtered_children ();
_DLL_CATCH
}

bool __stdcall NodeBase_tie::has_flag_45EEB95901EE (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_flag (flag);
_DLL_CATCH
}

bool __stdcall NodeBase_tie::has_parent_flag_45EEB95901F0 (
	FlagMask flag
) const {
_DLL_TRY
	return m_impl->has_parent_flag (flag);
_DLL_CATCH
}


bool __stdcall NodeBase_tie::get_is_expanded () const {
_DLL_TRY
	return m_impl->get_is_expanded();
_DLL_CATCH
}

bool __stdcall NodeBase_tie::is_first_45EEB95901F2 () const {
_DLL_TRY
	return m_impl->is_first ();
_DLL_CATCH
}

bool __stdcall NodeBase_tie::is_it_higher_45EEB95901F3 (
	INodeBase_tie* it
) const {
_DLL_TRY
	NodeBase* it_;
	NodeBase_tie::make_cpp(it, it_);

	bool ret = m_impl->is_it_higher(it_);
	return ret;
_DLL_CATCH
}

bool __stdcall NodeBase_tie::is_last_45EEB95901F5 () const {
_DLL_TRY
	return m_impl->is_last ();
_DLL_CATCH
}

bool __stdcall NodeBase_tie::is_relevance_search_supported_45EEB959021F () const {
_DLL_TRY
	return m_impl->is_relevance_search_supported ();
_DLL_CATCH
}

bool __stdcall NodeBase_tie::is_same_node_45EEB95901F6 (
	INodeBase_tie* node
) const {
_DLL_TRY
	NodeBase* node_;
	NodeBase_tie::make_cpp(node, node_);

	bool ret = m_impl->is_same_node(node_);
	return ret;
_DLL_CATCH
}

void __stdcall NodeBase_tie::iterate_all_nodes_473D89660266 (
	FlagMask with_flag
	, INodeIterator_tie*& ret_
) {
_DLL_TRY

	NodeIterator* ret = m_impl->iterate_all_nodes(with_flag);
	NodeIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::iterate_nodes_45EEB95901F8 (
	FlagMask with_flag
	, INodeIterator_tie*& ret_
) {
_DLL_TRY

	NodeIterator* ret = m_impl->iterate_nodes(with_flag);
	NodeIterator_tie::make_tie(ret, ret_);
_DLL_CATCH
}


long __stdcall NodeBase_tie::get_level () const {
_DLL_TRY
	return m_impl->get_level();
_DLL_CATCH
}

void __stdcall NodeBase_tie::make_visible_45EEB95901FA () {
_DLL_TRY

	m_impl->make_visible();
_DLL_CATCH
}


void __stdcall NodeBase_tie::get_next (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_next(), ret_);
_DLL_CATCH
}


void __stdcall NodeBase_tie::get_parent (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_parent(), ret_);
_DLL_CATCH
}


void __stdcall NodeBase_tie::get_prev (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_prev(), ret_);
_DLL_CATCH
}

void __stdcall NodeBase_tie::remove_notifier_45EEB95901FB (
	INodeNotifier_tie* notifier
) {
_DLL_TRY
	NodeNotifier_var notifier_;
	INodeNotifier_tie::make_cpp(notifier, notifier_.out ());

	m_impl->remove_notifier(notifier_.in ());
_DLL_CATCH
}

void __stdcall NodeBase_tie::rollback_change_transaction_45EEB9590218 () {
_DLL_TRY

	m_impl->rollback_change_transaction();
_DLL_CATCH
}

void __stdcall NodeBase_tie::set_all_flag_45EEB95901FD (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_all_flag(flag, value);
_DLL_CATCH
}

void __stdcall NodeBase_tie::set_all_flag_except_first_children_of_root_children_51EFC4100162 (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_all_flag_except_first_children_of_root_children(flag, value);
_DLL_CATCH
}

void __stdcall NodeBase_tie::set_flag_45EEB9590200 (
	FlagMask flag
	, bool value
) {
_DLL_TRY

	m_impl->set_flag(flag, value);
_DLL_CATCH
}

void __stdcall NodeBase_tie::set_node_id_45EEB95901DF (
	NodeId id
) {
_DLL_TRY

	m_impl->set_node_id(id);
_DLL_CATCH
}

void __stdcall NodeBase_tie::set_range_flag_45EEB9590203 (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
_DLL_TRY

	m_impl->set_range_flag(offset_from, offset_to, flag, value, clean_other);
_DLL_CATCH
}

void __stdcall NodeBase_tie::set_range_flag_except_first_children_of_root_children_51EFD26E03DF (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
_DLL_TRY

	m_impl->set_range_flag_except_first_children_of_root_children(offset_from, offset_to, flag, value, clean_other);
_DLL_CATCH
}

void __stdcall NodeBase_tie::start_change_transaction_45EEB9590217 () {
_DLL_TRY

	m_impl->start_change_transaction();
_DLL_CATCH
}


NodeType __stdcall NodeBase_tie::get_type () const {
_DLL_TRY
	return m_impl->get_type();
_DLL_CATCH
}
void __stdcall NodeBase_tie::set_type (NodeType type) /*throw (ConstantModify_tie)*/ {
_DLL_TRY
	m_impl->set_type(type);
_DLL_CATCH
}



const ::Core::ComIID NodeIterator_tie::s_com_iid = {0x1F4887B9, 0x4FA9, 0x4B90, {0xBB, 0x5C, 0x0D, 0x3E, 0xAB, 0x6D, 0x07, 0x92}};

NodeIterator_tie::IidRegistrator NodeIterator_tie::s_iid_registrator;

NodeIterator_tie::NodeIterator_tie () : m_impl(NULL) {
}

unsigned long __stdcall NodeIterator_tie::query_interface (
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
unsigned long __stdcall NodeIterator_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NodeIterator_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NodeIterator_tie* const>(this));
	}
	return counter;
}

void NodeIterator_tie::init () {
		m_counter = 1;
	}

void NodeIterator_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* NodeIterator_tie::cast (::Core::IObject* obj) {
	NodeIterator* ret = dynamic_cast<NodeIterator*>(obj);
	if (ret) {
		ret->addref();
	}
	INodeIterator_tie* ret_ = NULL;
	NodeIterator_tie::make_tie (ret, ret_);
	return ret_;
}

void NodeIterator_tie::make_cpp (const INodeIterator_tie* obj, NodeIterator*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<NodeIterator*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void NodeIterator_tie::make_tie (const NodeIterator* obj, INodeIterator_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		NodeIterator_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<NodeIterator*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void NodeIterator_tie::make_tie (const NodeIterator& obj, INodeIterator_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	NodeIterator_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<NodeIterator*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* NodeIterator_tie::get_impl () const {
	return m_impl;
}


void __stdcall NodeIterator_tie::get_next (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_next(), ret_);
_DLL_CATCH
}



void NodePosition_tie::make_cpp (const NodePosition_tie& obj, NodePosition& ret_) {
		ret_.pos = obj.pos;
		NodeBase_tie::make_cpp (obj.node, ret_.node.out (), true);
}

void NodePosition_tie::make_tie (const NodePosition& obj, NodePosition_tie& ret_) {
		ret_.pos = obj.pos;
		ret_.node = 0;
		NodeBase_tie::make_tie (obj.node.in (), ret_.node, true);
}


const ::Core::ComIID CatalogBase_tie::s_com_iid = {0x59A590F8, 0xFB2D, 0x49E6, {0xA9, 0x54, 0x1B, 0x0C, 0xC9, 0xCC, 0xAD, 0x04}};

CatalogBase_tie::IidRegistrator CatalogBase_tie::s_iid_registrator;

CatalogBase_tie::CatalogBase_tie () : m_impl(NULL) {
}

unsigned long __stdcall CatalogBase_tie::query_interface (
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
unsigned long __stdcall CatalogBase_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall CatalogBase_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<CatalogBase_tie* const>(this));
	}
	return counter;
}

void CatalogBase_tie::init () {
		m_counter = 1;
	}

void CatalogBase_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* CatalogBase_tie::cast (::Core::IObject* obj) {
	CatalogBase* ret = dynamic_cast<CatalogBase*>(obj);
	if (ret) {
		ret->addref();
	}
	ICatalogBase_tie* ret_ = NULL;
	CatalogBase_tie::make_tie (ret, ret_);
	return ret_;
}

void CatalogBase_tie::make_cpp (const ICatalogBase_tie* obj, CatalogBase*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<CatalogBase*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void CatalogBase_tie::make_tie (const CatalogBase* obj, ICatalogBase_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		CatalogBase_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<CatalogBase*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void CatalogBase_tie::make_tie (const CatalogBase& obj, ICatalogBase_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	CatalogBase_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<CatalogBase*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* CatalogBase_tie::get_impl () const {
	return m_impl;
}

void __stdcall CatalogBase_tie::clone_45EEBA2C02C0 (
	ICatalogBase_tie*& ret_
) const {
_DLL_TRY

	CatalogBase* ret = m_impl->clone();
	CatalogBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall CatalogBase_tie::create_45EEBA2C02CB (
	INodesClipboard_tie* nodes
	, ICatalogBase_tie*& ret_
) const {
_DLL_TRY
	NodesClipboard* nodes_;
	NodesClipboard_tie::make_cpp(nodes, nodes_);

	CatalogBase* ret = m_impl->create(nodes_);
	CatalogBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall CatalogBase_tie::get_node_by_path_45EEBA2C02C1 (
	const NodeIndexPath_tie* path
	, INodeBase_tie*& ret_
) const /*throw (NotFound_tie)*/ {
_DLL_TRY
	NodeIndexPath* path_;
	NodeIndexPath_tie::make_cpp(path, path_);

	NodeBase* ret = m_impl->get_node_by_path(*path_);
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall CatalogBase_tie::intersect_tree_45EEBA2C02C5 (
	const ICatalogBase_tie* tree
) {
_DLL_TRY
	CatalogBase* tree_;
	CatalogBase_tie::make_cpp(tree, tree_);

	m_impl->intersect_tree(tree_);
_DLL_CATCH
}

void __stdcall CatalogBase_tie::merge_tree_45EEBA2C02C7 (
	const ICatalogBase_tie* tree
) {
_DLL_TRY
	CatalogBase* tree_;
	CatalogBase_tie::make_cpp(tree, tree_);

	m_impl->merge_tree(tree_);
_DLL_CATCH
}

void __stdcall CatalogBase_tie::minus_tree_45EEBA2C02C9 (
	const ICatalogBase_tie* tree
) {
_DLL_TRY
	CatalogBase* tree_;
	CatalogBase_tie::make_cpp(tree, tree_);

	m_impl->minus_tree(tree_);
_DLL_CATCH
}


void __stdcall CatalogBase_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}
void __stdcall CatalogBase_tie::set_name (GCI::IO::IString_tie* name) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	m_impl->set_name(name_);
_DLL_CATCH
}


void __stdcall CatalogBase_tie::get_root (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_root(), ret_);
_DLL_CATCH
}



const ::Core::ComIID TrimLeafFilter_tie::s_com_iid = {0x7AC01117, 0xFE4F, 0x4D1C, {0xAA, 0x39, 0x44, 0xB5, 0x5E, 0x57, 0xD5, 0xF7}};

TrimLeafFilter_tie::IidRegistrator TrimLeafFilter_tie::s_iid_registrator;

TrimLeafFilter_tie::TrimLeafFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall TrimLeafFilter_tie::query_interface (
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
unsigned long __stdcall TrimLeafFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall TrimLeafFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<TrimLeafFilter_tie* const>(this));
	}
	return counter;
}

void TrimLeafFilter_tie::init () {
		m_counter = 1;
	}

void TrimLeafFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* TrimLeafFilter_tie::cast (::Core::IObject* obj) {
	TrimLeafFilter* ret = dynamic_cast<TrimLeafFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	ITrimLeafFilter_tie* ret_ = NULL;
	TrimLeafFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void TrimLeafFilter_tie::make_cpp (const ITrimLeafFilter_tie* obj, TrimLeafFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<TrimLeafFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void TrimLeafFilter_tie::make_tie (const TrimLeafFilter* obj, ITrimLeafFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		TrimLeafFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<TrimLeafFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void TrimLeafFilter_tie::make_tie (const TrimLeafFilter& obj, ITrimLeafFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	TrimLeafFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<TrimLeafFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* TrimLeafFilter_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID CountryFilter_tie::s_com_iid = {0x88574AB6, 0x4C05, 0x455B, {0x8E, 0x61, 0xAC, 0xC1, 0x70, 0xD6, 0x8E, 0x31}};

CountryFilter_tie::IidRegistrator CountryFilter_tie::s_iid_registrator;

CountryFilter_tie::CountryFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall CountryFilter_tie::query_interface (
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
unsigned long __stdcall CountryFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall CountryFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<CountryFilter_tie* const>(this));
	}
	return counter;
}

void CountryFilter_tie::init () {
		m_counter = 1;
	}

void CountryFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* CountryFilter_tie::cast (::Core::IObject* obj) {
	CountryFilter* ret = dynamic_cast<CountryFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	ICountryFilter_tie* ret_ = NULL;
	CountryFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void CountryFilter_tie::make_cpp (const ICountryFilter_tie* obj, CountryFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<CountryFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void CountryFilter_tie::make_tie (const CountryFilter* obj, ICountryFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		CountryFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<CountryFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void CountryFilter_tie::make_tie (const CountryFilter& obj, ICountryFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	CountryFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<CountryFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* CountryFilter_tie::get_impl () const {
	return m_impl;
}


void __stdcall CountryFilter_tie::get_country (INodeBase_tie*& ret_) {
_DLL_TRY
	NodeBase_tie::make_tie (m_impl->get_country(), ret_);
_DLL_CATCH
}
void __stdcall CountryFilter_tie::set_country (INodeBase_tie* country) {
_DLL_TRY
	NodeBase* country_;
	NodeBase_tie::make_cpp(country, country_);
	m_impl->set_country(country_);
_DLL_CATCH
}



const ::Core::ComIID CutToLeafCountFilter_tie::s_com_iid = {0x080EAE7F, 0xD346, 0x4600, {0xAA, 0x65, 0x6C, 0xD2, 0x1B, 0x8C, 0x73, 0x70}};

CutToLeafCountFilter_tie::IidRegistrator CutToLeafCountFilter_tie::s_iid_registrator;

CutToLeafCountFilter_tie::CutToLeafCountFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall CutToLeafCountFilter_tie::query_interface (
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
unsigned long __stdcall CutToLeafCountFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall CutToLeafCountFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<CutToLeafCountFilter_tie* const>(this));
	}
	return counter;
}

void CutToLeafCountFilter_tie::init () {
		m_counter = 1;
	}

void CutToLeafCountFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* CutToLeafCountFilter_tie::cast (::Core::IObject* obj) {
	CutToLeafCountFilter* ret = dynamic_cast<CutToLeafCountFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	ICutToLeafCountFilter_tie* ret_ = NULL;
	CutToLeafCountFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void CutToLeafCountFilter_tie::make_cpp (const ICutToLeafCountFilter_tie* obj, CutToLeafCountFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<CutToLeafCountFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void CutToLeafCountFilter_tie::make_tie (const CutToLeafCountFilter* obj, ICutToLeafCountFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		CutToLeafCountFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<CutToLeafCountFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void CutToLeafCountFilter_tie::make_tie (const CutToLeafCountFilter& obj, ICutToLeafCountFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	CutToLeafCountFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<CutToLeafCountFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* CutToLeafCountFilter_tie::get_impl () const {
	return m_impl;
}


unsigned long __stdcall CutToLeafCountFilter_tie::get_leaf_count () const {
_DLL_TRY
	return m_impl->get_leaf_count();
_DLL_CATCH
}
void __stdcall CutToLeafCountFilter_tie::set_leaf_count (unsigned long leaf_count) {
_DLL_TRY
	m_impl->set_leaf_count(leaf_count);
_DLL_CATCH
}



const ::Core::ComIID NodeIdList_tie::s_com_iid = {0x645EE87E, 0x58A6, 0x4EFD, {0x9C, 0x27, 0xFF, 0x98, 0xDE, 0xF4, 0xAC, 0x9E}};

unsigned long __stdcall NodeIdList_tie::query_interface (
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

unsigned long __stdcall NodeIdList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall NodeIdList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<NodeIdList_tie* const>(this));
	}
	return counter;
}

void NodeIdList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void NodeIdList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

NodeIdList_tie::NodeIdList_tie () : m_impl(NULL), m_orphan(true) {
}

void NodeIdList_tie::make_cpp (const NodeIdList_tie* obj, NodeIdList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void NodeIdList_tie::new_tie (NodeIdList* obj, NodeIdList_tie*& ret_) {
	Core::Aptr<NodeIdList> obj_aptr (obj);
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

void NodeIdList_tie::make_tie (NodeIdList* obj, NodeIdList_tie*& ret_) {
	Core::Aptr<NodeIdList> obj_aptr (obj);
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
	
void NodeIdList_tie::make_tie (const NodeIdList& obj, NodeIdList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new NodeIdList (obj);
	} else {
		ret_ = NULL;
	}
}

void NodeIdList_tie::make_tie (const NodeIdList& obj, NodeIdList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<NodeIdList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall NodeIdList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall NodeIdList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall NodeIdList_tie::clear () {
	m_impl->clear();
}

void __stdcall NodeIdList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

NodeId __stdcall NodeIdList_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall NodeIdList_tie::set_item (size_t index, NodeId item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall NodeIdList_tie::add (NodeId item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall NodeIdList_tie::insert (size_t index, NodeId item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID BlocksFilter_tie::s_com_iid = {0x30D760A8, 0x3BA6, 0x47C7, {0xA2, 0xA7, 0x08, 0xF5, 0x04, 0x58, 0x5C, 0xB8}};

BlocksFilter_tie::IidRegistrator BlocksFilter_tie::s_iid_registrator;

BlocksFilter_tie::BlocksFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall BlocksFilter_tie::query_interface (
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
unsigned long __stdcall BlocksFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall BlocksFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<BlocksFilter_tie* const>(this));
	}
	return counter;
}

void BlocksFilter_tie::init () {
		m_counter = 1;
	}

void BlocksFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* BlocksFilter_tie::cast (::Core::IObject* obj) {
	BlocksFilter* ret = dynamic_cast<BlocksFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	IBlocksFilter_tie* ret_ = NULL;
	BlocksFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void BlocksFilter_tie::make_cpp (const IBlocksFilter_tie* obj, BlocksFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<BlocksFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void BlocksFilter_tie::make_tie (const BlocksFilter* obj, IBlocksFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		BlocksFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<BlocksFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void BlocksFilter_tie::make_tie (const BlocksFilter& obj, IBlocksFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	BlocksFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<BlocksFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* BlocksFilter_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID InpharmFilter_tie::s_com_iid = {0x9F35901C, 0xBCED, 0x426C, {0x9B, 0x29, 0x45, 0xF0, 0xEF, 0xCA, 0x68, 0x8C}};

InpharmFilter_tie::IidRegistrator InpharmFilter_tie::s_iid_registrator;

InpharmFilter_tie::InpharmFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall InpharmFilter_tie::query_interface (
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
unsigned long __stdcall InpharmFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall InpharmFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<InpharmFilter_tie* const>(this));
	}
	return counter;
}

void InpharmFilter_tie::init () {
		m_counter = 1;
	}

void InpharmFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* InpharmFilter_tie::cast (::Core::IObject* obj) {
	InpharmFilter* ret = dynamic_cast<InpharmFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	IInpharmFilter_tie* ret_ = NULL;
	InpharmFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void InpharmFilter_tie::make_cpp (const IInpharmFilter_tie* obj, InpharmFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<InpharmFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void InpharmFilter_tie::make_tie (const InpharmFilter* obj, IInpharmFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		InpharmFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<InpharmFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void InpharmFilter_tie::make_tie (const InpharmFilter& obj, IInpharmFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	InpharmFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<InpharmFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* InpharmFilter_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID VariantsForDocFilter_tie::s_com_iid = {0x7E6C4CC8, 0x5E83, 0x4074, {0xBC, 0x63, 0x93, 0x28, 0x60, 0x53, 0xA5, 0x32}};

VariantsForDocFilter_tie::IidRegistrator VariantsForDocFilter_tie::s_iid_registrator;

VariantsForDocFilter_tie::VariantsForDocFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall VariantsForDocFilter_tie::query_interface (
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
unsigned long __stdcall VariantsForDocFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall VariantsForDocFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<VariantsForDocFilter_tie* const>(this));
	}
	return counter;
}

void VariantsForDocFilter_tie::init () {
		m_counter = 1;
	}

void VariantsForDocFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* VariantsForDocFilter_tie::cast (::Core::IObject* obj) {
	VariantsForDocFilter* ret = dynamic_cast<VariantsForDocFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	IVariantsForDocFilter_tie* ret_ = NULL;
	VariantsForDocFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void VariantsForDocFilter_tie::make_cpp (const IVariantsForDocFilter_tie* obj, VariantsForDocFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<VariantsForDocFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void VariantsForDocFilter_tie::make_tie (const VariantsForDocFilter* obj, IVariantsForDocFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		VariantsForDocFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<VariantsForDocFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void VariantsForDocFilter_tie::make_tie (const VariantsForDocFilter& obj, IVariantsForDocFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	VariantsForDocFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<VariantsForDocFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* VariantsForDocFilter_tie::get_impl () const {
	return m_impl;
}



const ::Core::ComIID Filtered_tie::s_com_iid = {0xB8FD4E84, 0x685B, 0x4A65, {0xBA, 0x63, 0xC4, 0xE8, 0x3B, 0x8A, 0x50, 0xEE}};

unsigned long __stdcall Filtered_tie::query_interface (
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

unsigned long __stdcall Filtered_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Filtered_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Filtered_tie* const>(this));
	}
	return counter;
}

void Filtered_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void Filtered_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

Filtered_tie::Filtered_tie () : m_impl(NULL), m_orphan(true) {
}

void Filtered_tie::make_cpp (const Filtered_tie* obj, Filtered*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void Filtered_tie::new_tie (Filtered* obj, Filtered_tie*& ret_) {
	Core::Aptr<Filtered> obj_aptr (obj);
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

void Filtered_tie::make_tie (Filtered* obj, Filtered_tie*& ret_) {
	Core::Aptr<Filtered> obj_aptr (obj);
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
	
void Filtered_tie::make_tie (const Filtered& obj, Filtered_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new Filtered (obj);
	} else {
		ret_ = NULL;
	}
}

void Filtered_tie::make_tie (const Filtered& obj, Filtered_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<Filtered*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall Filtered_tie::get_count () const {
	return m_impl->size();
}

void __stdcall Filtered_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall Filtered_tie::clear () {
	m_impl->clear();
}

void __stdcall Filtered_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

unsigned long __stdcall Filtered_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall Filtered_tie::set_item (size_t index, unsigned long item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall Filtered_tie::add (unsigned long item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall Filtered_tie::insert (size_t index, unsigned long item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID ContextFilter_tie::s_com_iid = {0xFCB4593F, 0xFD35, 0x46E5, {0x87, 0xBB, 0x71, 0x12, 0xD6, 0x1F, 0xEC, 0x5A}};

ContextFilter_tie::IidRegistrator ContextFilter_tie::s_iid_registrator;

ContextFilter_tie::ContextFilter_tie () : m_impl(NULL) {
}

unsigned long __stdcall ContextFilter_tie::query_interface (
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
unsigned long __stdcall ContextFilter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ContextFilter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ContextFilter_tie* const>(this));
	}
	return counter;
}

void ContextFilter_tie::init () {
		m_counter = 1;
	}

void ContextFilter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ContextFilter_tie::cast (::Core::IObject* obj) {
	ContextFilter* ret = dynamic_cast<ContextFilter*>(obj);
	if (ret) {
		ret->addref();
	}
	IContextFilter_tie* ret_ = NULL;
	ContextFilter_tie::make_tie (ret, ret_);
	return ret_;
}

void ContextFilter_tie::make_cpp (const IContextFilter_tie* obj, ContextFilter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ContextFilter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ContextFilter_tie::make_tie (const ContextFilter* obj, IContextFilter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ContextFilter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ContextFilter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ContextFilter_tie::make_tie (const ContextFilter& obj, IContextFilter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ContextFilter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ContextFilter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ContextFilter_tie::get_impl () const {
	return m_impl;
}


SearchArea __stdcall ContextFilter_tie::get_area () const {
_DLL_TRY
	return m_impl->get_area();
_DLL_CATCH
}
void __stdcall ContextFilter_tie::set_area (SearchArea area) {
_DLL_TRY
	m_impl->set_area(area);
_DLL_CATCH
}

void __stdcall ContextFilter_tie::clone_46E662C8033B (
	IContextFilter_tie*& ret_
) const {
_DLL_TRY

	ContextFilter* ret = m_impl->clone();
	ContextFilter_tie::make_tie(ret, ret_);
_DLL_CATCH
}


void __stdcall ContextFilter_tie::get_context (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_context(), ret_, this);
_DLL_CATCH
}
void __stdcall ContextFilter_tie::set_context (GCI::IO::IString_tie* context) {
_DLL_TRY
	GCI::IO::String* context_;
	GCI::IO::String_tie::make_cpp(context, context_);
	m_impl->set_context(context_);
_DLL_CATCH
}

void __stdcall ContextFilter_tie::filtrate_4D3E9E7E01ED (
	const IListForFiltering_tie* list
	, Filtered_tie*& ret_
) const {
_DLL_TRY
	ListForFiltering_var list_;
	IListForFiltering_tie::make_cpp(list, list_.out ());

	::Core::Aptr<Filtered> ret = m_impl->filtrate(list_.in ());
	Filtered_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}


FindOrder __stdcall ContextFilter_tie::get_order () const {
_DLL_TRY
	return m_impl->get_order();
_DLL_CATCH
}
void __stdcall ContextFilter_tie::set_order (FindOrder order) {
_DLL_TRY
	m_impl->set_order(order);
_DLL_CATCH
}


ContextPlace __stdcall ContextFilter_tie::get_place () const {
_DLL_TRY
	return m_impl->get_place();
_DLL_CATCH
}
void __stdcall ContextFilter_tie::set_place (ContextPlace place) {
_DLL_TRY
	m_impl->set_place(place);
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

