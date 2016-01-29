////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UserJournal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search_tie.h"

namespace GblAdapterLib {

class IUserJournal_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall clear_4A7FFA7B03B3 () const = 0;

	virtual void __stdcall get_bookmark_history_4A8000BD0335 (
		BookmarkJournalType type
		, long max_count
		, JournalBookmarkList_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_query_history_4A8000D00269 (
		QueryType query_type
		, long max_count
		, QueryList_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_user_jornal_tree_4A7FFAB30168 (
		INodeBase_tie*& ret_
	) const = 0;

	virtual void __stdcall remove_4A7FF9CA0176 (
		const INodeBase_tie* obj
	) const = 0;

	virtual void __stdcall save_4A7FF7B40013 (
		const Core::IIObject_tie* obj
		, JournalObjectType object_type
	) const = 0;
};

class __declspec (dllexport) UserJournal_tie: public IUserJournal_tie {
	SET_OBJECT_COUNTER (UserJournal_tie)
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
	UserJournal_tie ();

	typedef ::Core::PoolObjectManager<UserJournal_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<UserJournal_tie> Pool;
	friend class ::Core::PoolObjectManager<UserJournal_tie>;
	typedef ::Core::IidMapRegistrator<UserJournal_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IUserJournal_tie* obj, UserJournal*& ret_, bool interface_addref = false);

	static void make_tie (const UserJournal* obj, IUserJournal_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const UserJournal& obj, IUserJournal_tie*& ret_, const Core::TIEBase* owner);

	UserJournal* m_impl;

protected:
	virtual void __stdcall clear_4A7FFA7B03B3 () const;

	virtual void __stdcall get_bookmark_history_4A8000BD0335 (
		BookmarkJournalType type
		, long max_count
		, JournalBookmarkList_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_query_history_4A8000D00269 (
		QueryType query_type
		, long max_count
		, QueryList_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_user_jornal_tree_4A7FFAB30168 (
		INodeBase_tie*& ret_
	) const;

	virtual void __stdcall remove_4A7FF9CA0176 (
		const INodeBase_tie* obj
	) const;

	virtual void __stdcall save_4A7FF7B40013 (
		const Core::IIObject_tie* obj
		, JournalObjectType object_type
	) const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

