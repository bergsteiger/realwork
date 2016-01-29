////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// интерфейсы для поддержки чата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CHATINTERFACES_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_CHATINTERFACES_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security_tie.h"

namespace GblAdapterLib {
namespace ChatInterfaces {

#pragma pack (push, 1)

struct UserInfo_tie {
	GCI::IO::IString_tie* email;
	GCI::IO::IString_tie* login;
	GCI::IO::IString_tie* name;
	
	static void make_cpp (const UserInfo_tie& obj, UserInfo& ret_);

	static void make_tie (const UserInfo& obj, UserInfo_tie& ret_);
};

#pragma pack (pop)

class IChatManager_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall add_user_4A409CB202AF (
		Uid uid
	) /*throw (UnknownUser_tie)*/ = 0;

	virtual void __stdcall delete_user_4A409CFB026A (
		Uid uid
	) /*throw (UnknownUser_tie)*/ = 0;

	virtual void __stdcall get_contacts_tree_4A409AAF0399 (
		INodeBase_tie*& ret_
	) const = 0;

	virtual void __stdcall get_user_info_4A409B2D01EC (
		Uid uid
		, UserInfo_tie& ret_
	) const /*throw (UnknownUser_tie)*/ = 0;

	virtual bool __stdcall is_embed_chat_enabled_4A4099E902D0 () const = 0;

	virtual void __stdcall register_listener_for_notify_4A43633E02A4 (
		IListener_tie* listener
	) = 0;
};

class __declspec (dllexport) ChatManager_tie: public IChatManager_tie {
	SET_OBJECT_COUNTER (ChatManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	ChatManager_tie ();

	typedef ::Core::PoolObjectManager<ChatManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ChatManager_tie> Pool;
	friend class ::Core::PoolObjectManager<ChatManager_tie>;
	typedef ::Core::IidMapRegistrator<ChatManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IChatManager_tie* obj, ChatManager*& ret_, bool interface_addref = false);

	static void make_tie (const ChatManager* obj, IChatManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ChatManager& obj, IChatManager_tie*& ret_, const Core::TIEBase* owner);

	ChatManager* m_impl;

protected:
	virtual void __stdcall add_user_4A409CB202AF (
		Uid uid
	) /*throw (UnknownUser_tie)*/;

	virtual void __stdcall delete_user_4A409CFB026A (
		Uid uid
	) /*throw (UnknownUser_tie)*/;

	virtual void __stdcall get_contacts_tree_4A409AAF0399 (
		INodeBase_tie*& ret_
	) const;

	virtual void __stdcall get_user_info_4A409B2D01EC (
		Uid uid
		, UserInfo_tie& ret_
	) const /*throw (UnknownUser_tie)*/;

	virtual bool __stdcall is_embed_chat_enabled_4A4099E902D0 () const;

	virtual void __stdcall register_listener_for_notify_4A43633E02A4 (
		IListener_tie* listener
	);
};

#pragma pack (push, 1)

struct Message_tie {
	GCI::IO::IStream_tie* text;
	DateTime time;
	bool my;
	
	static void make_cpp (const Message_tie& obj, Message& ret_);

	static void make_tie (const Message& obj, Message_tie& ret_);
};

#pragma pack (pop)

class Messages_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (Messages_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Messages_tie ();

	typedef ::Core::PoolObjectManager<Messages_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Messages_tie> Pool;
	friend class ::Core::PoolObjectManager<Messages_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const Messages_tie* obj, Messages*& ret_);

	static void make_tie (Messages* obj, Messages_tie*& ret_);
	
	static void make_tie (const Messages& obj, Messages_tie*& ret_);

	static void make_tie (const Messages& obj, Messages_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (Messages* obj, Messages_tie*& ret_);

	Messages* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, Message_tie& ret_);
	virtual void __stdcall set_item (size_t index, const Message_tie& item);
	virtual size_t __stdcall add (const Message_tie& item);
	virtual size_t __stdcall insert (size_t index, const Message_tie& item);
};

class IMessagesManager_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall clean_history_4A40A93400D7 (
		Uid uid
	) /*throw (UnknownUser_tie)*/ = 0;

	virtual void __stdcall get_history_for_user_4A40A84A02FE (
		unsigned long count
		, bool all_new
		, Uid uid
		, Messages_tie*& ret_
	) const /*throw (UnknownUser_tie)*/ = 0;

	virtual void __stdcall get_unreaded_messages_4A40A5D7025F (
		Uid uid
		, Messages_tie*& ret_
	) const /*throw (UnknownUser_tie)*/ = 0;

	virtual void __stdcall send_message_4A40A73102AC (
		GCI::IO::IStream_tie* message
		, Uid uid
	) const /*throw (UnknownUser_tie)*/ = 0;
};

class __declspec (dllexport) MessagesManager_tie: public IMessagesManager_tie {
	SET_OBJECT_COUNTER (MessagesManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	MessagesManager_tie ();

	typedef ::Core::PoolObjectManager<MessagesManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<MessagesManager_tie> Pool;
	friend class ::Core::PoolObjectManager<MessagesManager_tie>;
	typedef ::Core::IidMapRegistrator<MessagesManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IMessagesManager_tie* obj, MessagesManager*& ret_, bool interface_addref = false);

	static void make_tie (const MessagesManager* obj, IMessagesManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const MessagesManager& obj, IMessagesManager_tie*& ret_, const Core::TIEBase* owner);

	MessagesManager* m_impl;

protected:
	virtual void __stdcall clean_history_4A40A93400D7 (
		Uid uid
	) /*throw (UnknownUser_tie)*/;

	virtual void __stdcall get_history_for_user_4A40A84A02FE (
		unsigned long count
		, bool all_new
		, Uid uid
		, Messages_tie*& ret_
	) const /*throw (UnknownUser_tie)*/;

	virtual void __stdcall get_unreaded_messages_4A40A5D7025F (
		Uid uid
		, Messages_tie*& ret_
	) const /*throw (UnknownUser_tie)*/;

	virtual void __stdcall send_message_4A40A73102AC (
		GCI::IO::IStream_tie* message
		, Uid uid
	) const /*throw (UnknownUser_tie)*/;
};

} // namespace ChatInterfaces
} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_CHATINTERFACES_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

