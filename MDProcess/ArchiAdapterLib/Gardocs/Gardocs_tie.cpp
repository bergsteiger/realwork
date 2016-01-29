////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/Gardocs/Gardocs_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::ArchiAdapterLib::Gardocs
//
// Gardoc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs_tie.h"

namespace ArchiAdapterLib {
namespace Gardocs {

const ::Core::ComIID StringList_tie::s_com_iid = {0xF453A2F1, 0x0E0A, 0x4C01, {0xAB, 0x14, 0x60, 0x24, 0x6C, 0xDF, 0x74, 0xDB}};

unsigned long __stdcall StringList_tie::query_interface (
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

unsigned long __stdcall StringList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall StringList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<StringList_tie* const>(this));
	}
	return counter;
}

void StringList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void StringList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

StringList_tie::StringList_tie () : m_impl(NULL), m_orphan(true) {
}

void StringList_tie::make_cpp (const StringList_tie* obj, StringList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void StringList_tie::new_tie (StringList* obj, StringList_tie*& ret_) {
	Core::Aptr<StringList> obj_aptr (obj);
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

void StringList_tie::make_tie (StringList* obj, StringList_tie*& ret_) {
	Core::Aptr<StringList> obj_aptr (obj);
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
	
void StringList_tie::make_tie (const StringList& obj, StringList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new StringList (obj);
	} else {
		ret_ = NULL;
	}
}

void StringList_tie::make_tie (const StringList& obj, StringList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<StringList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall StringList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall StringList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall StringList_tie::clear () {
	m_impl->clear();
}

void __stdcall StringList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall StringList_tie::get_item (size_t index, GCI::IO::IString_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall StringList_tie::set_item (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall StringList_tie::add (const GCI::IO::IString_tie* item) {
	GCI::IO::String* item_;
	GCI::IO::String_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall StringList_tie::insert (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void Image_tie::make_cpp (const Image_tie& obj, Image& ret_) {
		GCI::IO::Stream_tie::make_cpp (obj.data, ret_.data.out (), true);
		ret_.type = obj.type;
		GCI::IO::String_tie::make_cpp (obj.src_title, ret_.src_title.out (), true);
		GCI::IO::String_tie::make_cpp (obj.src_page, ret_.src_page.out (), true);
		GCI::IO::String_tie::make_cpp (obj.src_number, ret_.src_number.out (), true);
		ret_.src_date_start = obj.src_date_start;
		ret_.src_date_end = obj.src_date_end;
		StringList* ret_labels_;
		StringList_tie::make_cpp (obj.labels, ret_labels_);
		ret_.labels = *ret_labels_;
}

void Image_tie::make_tie (const Image& obj, Image_tie& ret_) {
		ret_.data = 0;
		GCI::IO::Stream_tie::make_tie (obj.data.in (), ret_.data, true);
		ret_.type = obj.type;
		ret_.src_title = 0;
		GCI::IO::String_tie::make_tie (obj.src_title.in (), ret_.src_title, true);
		ret_.src_page = 0;
		GCI::IO::String_tie::make_tie (obj.src_page.in (), ret_.src_page, true);
		ret_.src_number = 0;
		GCI::IO::String_tie::make_tie (obj.src_number.in (), ret_.src_number, true);
		ret_.src_date_start = obj.src_date_start;
		ret_.src_date_end = obj.src_date_end;
		ret_.labels = 0;
		StringList_tie::make_tie (obj.labels, ret_.labels);
}


const ::Core::ComIID ImageList_tie::s_com_iid = {0x10205A4D, 0x9F0C, 0x48B1, {0xB8, 0x4E, 0xC1, 0x0E, 0xD6, 0xFA, 0x25, 0x19}};

unsigned long __stdcall ImageList_tie::query_interface (
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

unsigned long __stdcall ImageList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ImageList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ImageList_tie* const>(this));
	}
	return counter;
}

void ImageList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void ImageList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

ImageList_tie::ImageList_tie () : m_impl(NULL), m_orphan(true) {
}

void ImageList_tie::make_cpp (const ImageList_tie* obj, ImageList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void ImageList_tie::new_tie (ImageList* obj, ImageList_tie*& ret_) {
	Core::Aptr<ImageList> obj_aptr (obj);
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

void ImageList_tie::make_tie (ImageList* obj, ImageList_tie*& ret_) {
	Core::Aptr<ImageList> obj_aptr (obj);
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
	
void ImageList_tie::make_tie (const ImageList& obj, ImageList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new ImageList (obj);
	} else {
		ret_ = NULL;
	}
}

void ImageList_tie::make_tie (const ImageList& obj, ImageList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<ImageList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall ImageList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall ImageList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall ImageList_tie::clear () {
	m_impl->clear();
}

void __stdcall ImageList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ImageList_tie::get_item (size_t index, Image_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		Image_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ImageList_tie::set_item (size_t index, const Image_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Image item_;
		Image_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall ImageList_tie::add (const Image_tie& item) {
	Image item_;
	Image_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall ImageList_tie::insert (size_t index, const Image_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Image item_;
		Image_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void Gardoc_tie::make_cpp (const Gardoc_tie& obj, Gardoc& ret_) {
		GCI::IO::String_tie::make_cpp (obj.type, ret_.type.out (), true);
		GCI::IO::String_tie::make_cpp (obj.number, ret_.number.out (), true);
		ret_.date = obj.date;
		StringList* ret_ogv_list_;
		StringList_tie::make_cpp (obj.ogv_list, ret_ogv_list_);
		ret_.ogv_list = *ret_ogv_list_;
		GCI::IO::String_tie::make_cpp (obj.title, ret_.title.out (), true);
		GCI::IO::String_tie::make_cpp (obj.mu_number, ret_.mu_number.out (), true);
		ret_.mu_date = obj.mu_date;
		StringList* ret_blocks_;
		StringList_tie::make_cpp (obj.blocks, ret_blocks_);
		ret_.blocks = *ret_blocks_;
		ret_.topic = obj.topic;
		GCI::IO::String_tie::make_cpp (obj.comment, ret_.comment.out (), true);
		ImageList* ret_images_;
		ImageList_tie::make_cpp (obj.images, ret_images_);
		ret_.images = *ret_images_;
		ret_.confluence_id = obj.confluence_id;
		ret_.timestamp = obj.timestamp;
		ret_.state = obj.state;
		GCI::IO::String_tie::make_cpp (obj.text, ret_.text.out (), true);
		ret_.related = obj.related;
		ret_.gardoc_type = obj.gardoc_type;
		ret_.urgency = obj.urgency;
		ret_.is_internet = obj.is_internet;
}

void Gardoc_tie::make_tie (const Gardoc& obj, Gardoc_tie& ret_) {
		ret_.type = 0;
		GCI::IO::String_tie::make_tie (obj.type.in (), ret_.type, true);
		ret_.number = 0;
		GCI::IO::String_tie::make_tie (obj.number.in (), ret_.number, true);
		ret_.date = obj.date;
		ret_.ogv_list = 0;
		StringList_tie::make_tie (obj.ogv_list, ret_.ogv_list);
		ret_.title = 0;
		GCI::IO::String_tie::make_tie (obj.title.in (), ret_.title, true);
		ret_.mu_number = 0;
		GCI::IO::String_tie::make_tie (obj.mu_number.in (), ret_.mu_number, true);
		ret_.mu_date = obj.mu_date;
		ret_.blocks = 0;
		StringList_tie::make_tie (obj.blocks, ret_.blocks);
		ret_.topic = obj.topic;
		ret_.comment = 0;
		GCI::IO::String_tie::make_tie (obj.comment.in (), ret_.comment, true);
		ret_.images = 0;
		ImageList_tie::make_tie (obj.images, ret_.images);
		ret_.confluence_id = obj.confluence_id;
		ret_.timestamp = obj.timestamp;
		ret_.state = obj.state;
		ret_.text = 0;
		GCI::IO::String_tie::make_tie (obj.text.in (), ret_.text, true);
		ret_.related = obj.related;
		ret_.gardoc_type = obj.gardoc_type;
		ret_.urgency = obj.urgency;
		ret_.is_internet = obj.is_internet;
}


void ArchiEvent_tie::make_cpp (const ArchiEvent_tie& obj, ArchiEvent& ret_) {
		GCI::IO::String_tie::make_cpp (obj.type, ret_.type.out (), true);
		Gardoc_tie::make_cpp (obj.doc, ret_.doc);
}

void ArchiEvent_tie::make_tie (const ArchiEvent& obj, ArchiEvent_tie& ret_) {
		ret_.type = 0;
		GCI::IO::String_tie::make_tie (obj.type.in (), ret_.type, true);
		Gardoc_tie::make_tie (obj.doc, ret_.doc);
}


const ::Core::ComIID GardocList_tie::s_com_iid = {0xD491FCC6, 0xCA05, 0x4DC5, {0xA4, 0x00, 0xB7, 0x93, 0xF1, 0x96, 0xEA, 0x6E}};

unsigned long __stdcall GardocList_tie::query_interface (
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

unsigned long __stdcall GardocList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall GardocList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<GardocList_tie* const>(this));
	}
	return counter;
}

void GardocList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void GardocList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

GardocList_tie::GardocList_tie () : m_impl(NULL), m_orphan(true) {
}

void GardocList_tie::make_cpp (const GardocList_tie* obj, GardocList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void GardocList_tie::new_tie (GardocList* obj, GardocList_tie*& ret_) {
	Core::Aptr<GardocList> obj_aptr (obj);
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

void GardocList_tie::make_tie (GardocList* obj, GardocList_tie*& ret_) {
	Core::Aptr<GardocList> obj_aptr (obj);
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
	
void GardocList_tie::make_tie (const GardocList& obj, GardocList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new GardocList (obj);
	} else {
		ret_ = NULL;
	}
}

void GardocList_tie::make_tie (const GardocList& obj, GardocList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<GardocList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall GardocList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall GardocList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall GardocList_tie::clear () {
	m_impl->clear();
}

void __stdcall GardocList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall GardocList_tie::get_item (size_t index, Gardoc_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		Gardoc_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall GardocList_tie::set_item (size_t index, const Gardoc_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Gardoc item_;
		Gardoc_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall GardocList_tie::add (const Gardoc_tie& item) {
	Gardoc item_;
	Gardoc_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall GardocList_tie::insert (size_t index, const Gardoc_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Gardoc item_;
		Gardoc_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID Searcher_tie::s_com_iid = {0x7B55C61E, 0xE39E, 0x4BEC, {0x8B, 0xD2, 0xDD, 0xC6, 0x7D, 0xB1, 0x21, 0x8E}};

Searcher_tie::IidRegistrator Searcher_tie::s_iid_registrator;

Searcher_tie::Searcher_tie () : m_impl(NULL) {
}

unsigned long __stdcall Searcher_tie::query_interface (
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
unsigned long __stdcall Searcher_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Searcher_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Searcher_tie* const>(this));
	}
	return counter;
}

void Searcher_tie::init () {
		m_counter = 1;
	}

void Searcher_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Searcher_tie::cast (::Core::IObject* obj) {
	Searcher* ret = dynamic_cast<Searcher*>(obj);
	if (ret) {
		ret->addref();
	}
	ISearcher_tie* ret_ = NULL;
	Searcher_tie::make_tie (ret, ret_);
	return ret_;
}

void Searcher_tie::make_cpp (const ISearcher_tie* obj, Searcher*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Searcher*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Searcher_tie::make_tie (const Searcher* obj, ISearcher_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Searcher_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Searcher*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Searcher_tie::make_tie (const Searcher& obj, ISearcher_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Searcher_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Searcher*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Searcher_tie::get_impl () const {
	return m_impl;
}

void __stdcall Searcher_tie::get_notop_created_since_521C88540333 (
	const GCI::IO::DateTimeBox& date
	, long count
	, GardocList_tie*& ret_
) const /*throw (CommunicationFailure_tie)*/ {
_DLL_TRY

	::Core::Aptr<GardocList> ret = m_impl->get_notop_created_since(date, count);
	GardocList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall Searcher_tie::get_recently_created_since_4E14476B01C7 (
	const GCI::IO::DateTimeBox& date
	, const char* partnerId
	, GardocList_tie*& ret_
) const /*throw (CommunicationFailure_tie)*/ {
_DLL_TRY

	::Core::Aptr<GardocList> ret = m_impl->get_recently_created_since(date, partnerId);
	GardocList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall Searcher_tie::get_top_created_since_521C8837021D (
	const GCI::IO::DateTimeBox& date
	, long count
	, GardocList_tie*& ret_
) const /*throw (CommunicationFailure_tie)*/ {
_DLL_TRY

	::Core::Aptr<GardocList> ret = m_impl->get_top_created_since(date, count);
	GardocList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}



const ::Core::ComIID ArchiEventsListener_tie::s_com_iid = {0x2BA31725, 0xA2F3, 0x491E, {0xB6, 0xB9, 0x08, 0x82, 0x43, 0x57, 0x9D, 0x0F}};

ArchiEventsListener_tie::IidRegistrator ArchiEventsListener_tie::s_iid_registrator;

ArchiEventsListener_tie::ArchiEventsListener_tie () : m_impl(NULL) {
}

unsigned long __stdcall ArchiEventsListener_tie::query_interface (
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
unsigned long __stdcall ArchiEventsListener_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ArchiEventsListener_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ArchiEventsListener_tie* const>(this));
	}
	return counter;
}

void ArchiEventsListener_tie::init () {
		m_counter = 1;
	}

void ArchiEventsListener_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ArchiEventsListener_tie::cast (::Core::IObject* obj) {
	ArchiEventsListener* ret = dynamic_cast<ArchiEventsListener*>(obj);
	if (ret) {
		ret->addref();
	}
	IArchiEventsListener_tie* ret_ = NULL;
	ArchiEventsListener_tie::make_tie (ret, ret_);
	return ret_;
}

void ArchiEventsListener_tie::make_cpp (const IArchiEventsListener_tie* obj, ArchiEventsListener*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ArchiEventsListener*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ArchiEventsListener_tie::make_tie (const ArchiEventsListener* obj, IArchiEventsListener_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ArchiEventsListener_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ArchiEventsListener*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ArchiEventsListener_tie::make_tie (const ArchiEventsListener& obj, IArchiEventsListener_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ArchiEventsListener_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ArchiEventsListener*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ArchiEventsListener_tie::get_impl () const {
	return m_impl;
}

void __stdcall ArchiEventsListener_tie::on_event_4E8F2EDD0294 (
	const ArchiEvent_tie& event
) const /*throw (CommunicationFailure_tie)*/ {
_DLL_TRY
	ArchiEvent event_;
	ArchiEvent_tie::make_cpp(event, event_);

	m_impl->on_event(event_);
_DLL_CATCH
}



const ::Core::ComIID Searcher2_tie::s_com_iid = {0x64367610, 0x772E, 0x48B6, {0xA9, 0x5A, 0x69, 0x03, 0xB7, 0x7A, 0x11, 0xD8}};

Searcher2_tie::IidRegistrator Searcher2_tie::s_iid_registrator;

Searcher2_tie::Searcher2_tie () : m_impl(NULL) {
}

unsigned long __stdcall Searcher2_tie::query_interface (
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
unsigned long __stdcall Searcher2_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Searcher2_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Searcher2_tie* const>(this));
	}
	return counter;
}

void Searcher2_tie::init () {
		m_counter = 1;
	}

void Searcher2_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Searcher2_tie::cast (::Core::IObject* obj) {
	Searcher2* ret = dynamic_cast<Searcher2*>(obj);
	if (ret) {
		ret->addref();
	}
	ISearcher2_tie* ret_ = NULL;
	Searcher2_tie::make_tie (ret, ret_);
	return ret_;
}

void Searcher2_tie::make_cpp (const ISearcher2_tie* obj, Searcher2*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Searcher2*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Searcher2_tie::make_tie (const Searcher2* obj, ISearcher2_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Searcher2_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Searcher2*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Searcher2_tie::make_tie (const Searcher2& obj, ISearcher2_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Searcher2_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Searcher2*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Searcher2_tie::get_impl () const {
	return m_impl;
}

void __stdcall Searcher2_tie::get_notop_created_since_541AB396009A (
	const GCI::IO::DateTimeBox& date
	, long count
	, const char* partnerId
	, GardocList_tie*& ret_
) const /*throw (CommunicationFailure_tie)*/ {
_DLL_TRY

	::Core::Aptr<GardocList> ret = m_impl->get_notop_created_since(date, count, partnerId);
	GardocList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall Searcher2_tie::get_top_created_since_541AB38E025D (
	const GCI::IO::DateTimeBox& date
	, long count
	, const char* partnerId
	, GardocList_tie*& ret_
) const /*throw (CommunicationFailure_tie)*/ {
_DLL_TRY

	::Core::Aptr<GardocList> ret = m_impl->get_top_created_since(date, count, partnerId);
	GardocList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}



const ::Core::ComIID Utils_tie::s_com_iid = {0x731214F7, 0x3EF9, 0x463C, {0x89, 0xCF, 0x80, 0x27, 0xD4, 0xD8, 0x2C, 0x0B}};

Utils_tie::IidRegistrator Utils_tie::s_iid_registrator;

Utils_tie::Utils_tie () : m_impl(NULL) {
}

unsigned long __stdcall Utils_tie::query_interface (
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
unsigned long __stdcall Utils_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Utils_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Utils_tie* const>(this));
	}
	return counter;
}

void Utils_tie::init () {
		m_counter = 1;
	}

void Utils_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Utils_tie::cast (::Core::IObject* obj) {
	Utils* ret = dynamic_cast<Utils*>(obj);
	if (ret) {
		ret->addref();
	}
	IUtils_tie* ret_ = NULL;
	Utils_tie::make_tie (ret, ret_);
	return ret_;
}

void Utils_tie::make_cpp (const IUtils_tie* obj, Utils*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Utils*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Utils_tie::make_tie (const Utils* obj, IUtils_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Utils_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Utils*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Utils_tie::make_tie (const Utils& obj, IUtils_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Utils_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Utils*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Utils_tie::get_impl () const {
	return m_impl;
}

void __stdcall Utils_tie::update_old_last_created_time_54999FCF0337 (
	const GCI::IO::DateTimeBox& date
	, GCI::IO::DateTimeBox& ret_
) const /*throw (CommunicationFailure_tie)*/ {
_DLL_TRY

	::Core::Aptr<GCI::IO::DateTimeBox> ret = m_impl->update_old_last_created_time(date);
	if (ret.ptr()) {
		ret_ = *ret;
	}
_DLL_CATCH
}



const ::Core::ComIID LongList_tie::s_com_iid = {0xEF5A688C, 0x2615, 0x45FC, {0x96, 0xC8, 0x7E, 0x1B, 0xCB, 0x15, 0xC5, 0xEB}};

unsigned long __stdcall LongList_tie::query_interface (
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

unsigned long __stdcall LongList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall LongList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<LongList_tie* const>(this));
	}
	return counter;
}

void LongList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void LongList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

LongList_tie::LongList_tie () : m_impl(NULL), m_orphan(true) {
}

void LongList_tie::make_cpp (const LongList_tie* obj, LongList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void LongList_tie::new_tie (LongList* obj, LongList_tie*& ret_) {
	Core::Aptr<LongList> obj_aptr (obj);
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

void LongList_tie::make_tie (LongList* obj, LongList_tie*& ret_) {
	Core::Aptr<LongList> obj_aptr (obj);
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
	
void LongList_tie::make_tie (const LongList& obj, LongList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new LongList (obj);
	} else {
		ret_ = NULL;
	}
}

void LongList_tie::make_tie (const LongList& obj, LongList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<LongList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall LongList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall LongList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall LongList_tie::clear () {
	m_impl->clear();
}

void __stdcall LongList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

long long __stdcall LongList_tie::get_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		return (*m_impl)[index];
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall LongList_tie::set_item (size_t index, long long item) {
	if ((size_t)index < m_impl->size()) {
		(*m_impl)[index] = item;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall LongList_tie::add (long long item) {
	m_impl->push_back (item);
	return m_impl->size() - 1;
}

size_t __stdcall LongList_tie::insert (size_t index, long long item) {
	if ((size_t)index < m_impl->size()) {
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID GardocGetter_tie::s_com_iid = {0x1E68C7A1, 0xF6B8, 0x4A60, {0x8E, 0x20, 0xA8, 0x86, 0x0F, 0x1D, 0xBB, 0xB5}};

GardocGetter_tie::IidRegistrator GardocGetter_tie::s_iid_registrator;

GardocGetter_tie::GardocGetter_tie () : m_impl(NULL) {
}

unsigned long __stdcall GardocGetter_tie::query_interface (
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
unsigned long __stdcall GardocGetter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall GardocGetter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<GardocGetter_tie* const>(this));
	}
	return counter;
}

void GardocGetter_tie::init () {
		m_counter = 1;
	}

void GardocGetter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* GardocGetter_tie::cast (::Core::IObject* obj) {
	GardocGetter* ret = dynamic_cast<GardocGetter*>(obj);
	if (ret) {
		ret->addref();
	}
	IGardocGetter_tie* ret_ = NULL;
	GardocGetter_tie::make_tie (ret, ret_);
	return ret_;
}

void GardocGetter_tie::make_cpp (const IGardocGetter_tie* obj, GardocGetter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<GardocGetter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void GardocGetter_tie::make_tie (const GardocGetter* obj, IGardocGetter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		GardocGetter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<GardocGetter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void GardocGetter_tie::make_tie (const GardocGetter& obj, IGardocGetter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	GardocGetter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<GardocGetter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* GardocGetter_tie::get_impl () const {
	return m_impl;
}

void __stdcall GardocGetter_tie::gardocs_by_confluenceid_list_5499A01C011F (
	const LongList_tie* confluenceidList
	, GardocList_tie*& ret_
) const /*throw (CommunicationFailure_tie)*/ {
_DLL_TRY
	LongList* confluenceidList_;
	LongList_tie::make_cpp(confluenceidList, confluenceidList_);

	::Core::Aptr<GardocList> ret = m_impl->gardocs_by_confluenceid_list(*confluenceidList_);
	GardocList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall GardocGetter_tie::gardocs_by_topic_list_5499A01B0069 (
	const LongList_tie* topicList
	, GardocList_tie*& ret_
) const /*throw (CommunicationFailure_tie)*/ {
_DLL_TRY
	LongList* topicList_;
	LongList_tie::make_cpp(topicList, topicList_);

	::Core::Aptr<GardocList> ret = m_impl->gardocs_by_topic_list(*topicList_);
	GardocList_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}



} // namespace Gardocs
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

