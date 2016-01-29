////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// интерфейсы для поддержки чата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces_tie.h"

namespace GblAdapterLib {
namespace ChatInterfaces {

void UserInfo_tie::make_cpp (const UserInfo_tie& obj, UserInfo& ret_) {
		GCI::IO::String_tie::make_cpp (obj.email, ret_.email.out (), true);
		GCI::IO::String_tie::make_cpp (obj.login, ret_.login.out (), true);
		GCI::IO::String_tie::make_cpp (obj.name, ret_.name.out (), true);
}

void UserInfo_tie::make_tie (const UserInfo& obj, UserInfo_tie& ret_) {
		ret_.email = 0;
		GCI::IO::String_tie::make_tie (obj.email.in (), ret_.email, true);
		ret_.login = 0;
		GCI::IO::String_tie::make_tie (obj.login.in (), ret_.login, true);
		ret_.name = 0;
		GCI::IO::String_tie::make_tie (obj.name.in (), ret_.name, true);
}


const ::Core::ComIID ChatManager_tie::s_com_iid = {0xF9DEFC6A, 0x0DF4, 0x4DC4, {0xB8, 0x63, 0x62, 0xE0, 0xA7, 0xD8, 0xE6, 0x8A}};

ChatManager_tie::IidRegistrator ChatManager_tie::s_iid_registrator;

ChatManager_tie::ChatManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall ChatManager_tie::query_interface (
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
unsigned long __stdcall ChatManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ChatManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ChatManager_tie* const>(this));
	}
	return counter;
}

void ChatManager_tie::init () {
		m_counter = 1;
	}

void ChatManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ChatManager_tie::cast (::Core::IObject* obj) {
	ChatManager* ret = dynamic_cast<ChatManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IChatManager_tie* ret_ = NULL;
	ChatManager_tie::make_tie (ret, ret_);
	return ret_;
}

void ChatManager_tie::make_cpp (const IChatManager_tie* obj, ChatManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ChatManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ChatManager_tie::make_tie (const ChatManager* obj, IChatManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ChatManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ChatManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ChatManager_tie::make_tie (const ChatManager& obj, IChatManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ChatManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ChatManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ChatManager_tie::get_impl () const {
	return m_impl;
}

void __stdcall ChatManager_tie::add_user_4A409CB202AF (
	Uid uid
) /*throw (UnknownUser_tie)*/ {
_DLL_TRY

	m_impl->add_user(uid);
_DLL_CATCH
}

void __stdcall ChatManager_tie::delete_user_4A409CFB026A (
	Uid uid
) /*throw (UnknownUser_tie)*/ {
_DLL_TRY

	m_impl->delete_user(uid);
_DLL_CATCH
}

void __stdcall ChatManager_tie::get_contacts_tree_4A409AAF0399 (
	INodeBase_tie*& ret_
) const {
_DLL_TRY

	NodeBase* ret = m_impl->get_contacts_tree();
	NodeBase_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ChatManager_tie::get_user_info_4A409B2D01EC (
	Uid uid
	, UserInfo_tie& ret_
) const /*throw (UnknownUser_tie)*/ {
_DLL_TRY

	::Core::Aptr<UserInfo> ret = m_impl->get_user_info(uid);
	UserInfo_tie::make_tie(*ret, ret_);
_DLL_CATCH
}

bool __stdcall ChatManager_tie::is_embed_chat_enabled_4A4099E902D0 () const {
_DLL_TRY
	return m_impl->is_embed_chat_enabled ();
_DLL_CATCH
}

void __stdcall ChatManager_tie::register_listener_for_notify_4A43633E02A4 (
	IListener_tie* listener
) {
_DLL_TRY
	Listener_var listener_;
	IListener_tie::make_cpp(listener, listener_.out ());

	m_impl->register_listener_for_notify(listener_.in ());
_DLL_CATCH
}



void Message_tie::make_cpp (const Message_tie& obj, Message& ret_) {
		GCI::IO::Stream_tie::make_cpp (obj.text, ret_.text.out (), true);
		ret_.time = obj.time;
		ret_.my = obj.my;
}

void Message_tie::make_tie (const Message& obj, Message_tie& ret_) {
		ret_.text = 0;
		GCI::IO::Stream_tie::make_tie (obj.text.in (), ret_.text, true);
		ret_.time = obj.time;
		ret_.my = obj.my;
}


const ::Core::ComIID Messages_tie::s_com_iid = {0xAE30875B, 0xB8F9, 0x4132, {0x98, 0xBC, 0xED, 0x5E, 0xD0, 0xD0, 0x61, 0xFF}};

unsigned long __stdcall Messages_tie::query_interface (
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

unsigned long __stdcall Messages_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Messages_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Messages_tie* const>(this));
	}
	return counter;
}

void Messages_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void Messages_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

Messages_tie::Messages_tie () : m_impl(NULL), m_orphan(true) {
}

void Messages_tie::make_cpp (const Messages_tie* obj, Messages*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void Messages_tie::new_tie (Messages* obj, Messages_tie*& ret_) {
	Core::Aptr<Messages> obj_aptr (obj);
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

void Messages_tie::make_tie (Messages* obj, Messages_tie*& ret_) {
	Core::Aptr<Messages> obj_aptr (obj);
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
	
void Messages_tie::make_tie (const Messages& obj, Messages_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new Messages (obj);
	} else {
		ret_ = NULL;
	}
}

void Messages_tie::make_tie (const Messages& obj, Messages_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<Messages*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall Messages_tie::get_count () const {
	return m_impl->size();
}

void __stdcall Messages_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall Messages_tie::clear () {
	m_impl->clear();
}

void __stdcall Messages_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall Messages_tie::get_item (size_t index, Message_tie& ret_) {
	if ((size_t)index < m_impl->size()) {
		Message_tie::make_tie ((*m_impl)[index], ret_);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall Messages_tie::set_item (size_t index, const Message_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Message item_;
		Message_tie::make_cpp (item, item_);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall Messages_tie::add (const Message_tie& item) {
	Message item_;
	Message_tie::make_cpp (item, item_);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall Messages_tie::insert (size_t index, const Message_tie& item) {
	if ((size_t)index < m_impl->size()) {
		Message item_;
		Message_tie::make_cpp (item, item_);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID MessagesManager_tie::s_com_iid = {0x7D3435F1, 0x68A4, 0x4CBE, {0xA5, 0x47, 0x24, 0x0E, 0x45, 0xD9, 0xFA, 0xE4}};

MessagesManager_tie::IidRegistrator MessagesManager_tie::s_iid_registrator;

MessagesManager_tie::MessagesManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall MessagesManager_tie::query_interface (
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
unsigned long __stdcall MessagesManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall MessagesManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<MessagesManager_tie* const>(this));
	}
	return counter;
}

void MessagesManager_tie::init () {
		m_counter = 1;
	}

void MessagesManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* MessagesManager_tie::cast (::Core::IObject* obj) {
	MessagesManager* ret = dynamic_cast<MessagesManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IMessagesManager_tie* ret_ = NULL;
	MessagesManager_tie::make_tie (ret, ret_);
	return ret_;
}

void MessagesManager_tie::make_cpp (const IMessagesManager_tie* obj, MessagesManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<MessagesManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void MessagesManager_tie::make_tie (const MessagesManager* obj, IMessagesManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		MessagesManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<MessagesManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void MessagesManager_tie::make_tie (const MessagesManager& obj, IMessagesManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	MessagesManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<MessagesManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* MessagesManager_tie::get_impl () const {
	return m_impl;
}

void __stdcall MessagesManager_tie::clean_history_4A40A93400D7 (
	Uid uid
) /*throw (UnknownUser_tie)*/ {
_DLL_TRY

	m_impl->clean_history(uid);
_DLL_CATCH
}

void __stdcall MessagesManager_tie::get_history_for_user_4A40A84A02FE (
	unsigned long count
	, bool all_new
	, Uid uid
	, Messages_tie*& ret_
) const /*throw (UnknownUser_tie)*/ {
_DLL_TRY

	::Core::Aptr<Messages> ret = m_impl->get_history_for_user(count, all_new, uid);
	Messages_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall MessagesManager_tie::get_unreaded_messages_4A40A5D7025F (
	Uid uid
	, Messages_tie*& ret_
) const /*throw (UnknownUser_tie)*/ {
_DLL_TRY

	::Core::Aptr<Messages> ret = m_impl->get_unreaded_messages(uid);
	Messages_tie::make_tie(ret._retn(), ret_);
_DLL_CATCH
}

void __stdcall MessagesManager_tie::send_message_4A40A73102AC (
	GCI::IO::IStream_tie* message
	, Uid uid
) const /*throw (UnknownUser_tie)*/ {
_DLL_TRY
	GCI::IO::Stream* message_;
	GCI::IO::Stream_tie::make_cpp(message, message_);

	m_impl->send_message(message_, uid);
_DLL_CATCH
}



} // namespace ChatInterfaces
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

