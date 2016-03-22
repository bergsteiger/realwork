////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Document
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl_tie.h"

namespace GblAdapterLib {

class IMissingInfo_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_blocks_info (GCI::IO::IString_tie*& ret_) = 0;

	virtual bool __stdcall is_one_block_45EEB652030A () const = 0;


	virtual void __stdcall get_obj_name (GCI::IO::IString_tie*& ret_) = 0;
};

class __declspec (dllexport) MissingInfo_tie: public IMissingInfo_tie {
	SET_OBJECT_COUNTER (MissingInfo_tie)
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
	MissingInfo_tie ();

	typedef ::Core::PoolObjectManager<MissingInfo_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<MissingInfo_tie> Pool;
	friend class ::Core::PoolObjectManager<MissingInfo_tie>;
	typedef ::Core::IidMapRegistrator<MissingInfo_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IMissingInfo_tie* obj, MissingInfo*& ret_, bool interface_addref = false);

	static void make_tie (const MissingInfo* obj, IMissingInfo_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const MissingInfo& obj, IMissingInfo_tie*& ret_, const Core::TIEBase* owner);

	MissingInfo* m_impl;

protected:

	virtual void __stdcall get_blocks_info (GCI::IO::IString_tie*& ret_);

	virtual bool __stdcall is_one_block_45EEB652030A () const;


	virtual void __stdcall get_obj_name (GCI::IO::IString_tie*& ret_);
};

#pragma pack (push, 1)

struct TimeMachineWarning_tie {
	GCI::IO::IString_tie* warning;
	TimeMachineWarningType type;
	
	static void make_cpp (const TimeMachineWarning_tie& obj, TimeMachineWarning& ret_);

	static void make_tie (const TimeMachineWarning& obj, TimeMachineWarning_tie& ret_);
};

#pragma pack (pop)

class PositionList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (PositionList_tie)
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
	PositionList_tie ();

	typedef ::Core::PoolObjectManager<PositionList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<PositionList_tie> Pool;
	friend class ::Core::PoolObjectManager<PositionList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const PositionList_tie* obj, PositionList*& ret_);

	static void make_tie (PositionList* obj, PositionList_tie*& ret_);
	
	static void make_tie (const PositionList& obj, PositionList_tie*& ret_);

	static void make_tie (const PositionList& obj, PositionList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (PositionList* obj, PositionList_tie*& ret_);

	PositionList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, Position& ret_);
	virtual void __stdcall set_item (size_t index, const Position& item);
	virtual size_t __stdcall add (const Position& item);
	virtual size_t __stdcall insert (size_t index, const Position& item);
};

class ActiveIntervalList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (ActiveIntervalList_tie)
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
	ActiveIntervalList_tie ();

	typedef ::Core::PoolObjectManager<ActiveIntervalList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ActiveIntervalList_tie> Pool;
	friend class ::Core::PoolObjectManager<ActiveIntervalList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const ActiveIntervalList_tie* obj, ActiveIntervalList*& ret_);

	static void make_tie (ActiveIntervalList* obj, ActiveIntervalList_tie*& ret_);
	
	static void make_tie (const ActiveIntervalList& obj, ActiveIntervalList_tie*& ret_);

	static void make_tie (const ActiveIntervalList& obj, ActiveIntervalList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (ActiveIntervalList* obj, ActiveIntervalList_tie*& ret_);

	ActiveIntervalList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, DateInterval& ret_);
	virtual void __stdcall set_item (size_t index, const DateInterval& item);
	virtual size_t __stdcall add (const DateInterval& item);
	virtual size_t __stdcall insert (size_t index, const DateInterval& item);
};

#pragma pack (push, 1)

struct NotSureInfo_tie {
	GCI::IO::IString_tie* warning;
	DateInterval interval;
	
	static void make_cpp (const NotSureInfo_tie& obj, NotSureInfo& ret_);

	static void make_tie (const NotSureInfo& obj, NotSureInfo_tie& ret_);
};

#pragma pack (pop)

class NotSureIntervalList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (NotSureIntervalList_tie)
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
	NotSureIntervalList_tie ();

	typedef ::Core::PoolObjectManager<NotSureIntervalList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NotSureIntervalList_tie> Pool;
	friend class ::Core::PoolObjectManager<NotSureIntervalList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const NotSureIntervalList_tie* obj, NotSureIntervalList*& ret_);

	static void make_tie (NotSureIntervalList* obj, NotSureIntervalList_tie*& ret_);
	
	static void make_tie (const NotSureIntervalList& obj, NotSureIntervalList_tie*& ret_);

	static void make_tie (const NotSureIntervalList& obj, NotSureIntervalList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (NotSureIntervalList* obj, NotSureIntervalList_tie*& ret_);

	NotSureIntervalList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, NotSureInfo_tie& ret_);
	virtual void __stdcall set_item (size_t index, const NotSureInfo_tie& item);
	virtual size_t __stdcall add (const NotSureInfo_tie& item);
	virtual size_t __stdcall insert (size_t index, const NotSureInfo_tie& item);
};

#pragma pack (push, 1)

struct RedactionSourceDocumentInfo_tie {
	GCI::IO::IString_tie* display_name;
	Topic doc_topic;
	
	static void make_cpp (const RedactionSourceDocumentInfo_tie& obj, RedactionSourceDocumentInfo& ret_);

	static void make_tie (const RedactionSourceDocumentInfo& obj, RedactionSourceDocumentInfo_tie& ret_);
};

#pragma pack (pop)

class RedactionSourceDocumentInfoList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (RedactionSourceDocumentInfoList_tie)
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
	RedactionSourceDocumentInfoList_tie ();

	typedef ::Core::PoolObjectManager<RedactionSourceDocumentInfoList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<RedactionSourceDocumentInfoList_tie> Pool;
	friend class ::Core::PoolObjectManager<RedactionSourceDocumentInfoList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const RedactionSourceDocumentInfoList_tie* obj, RedactionSourceDocumentInfoList*& ret_);

	static void make_tie (RedactionSourceDocumentInfoList* obj, RedactionSourceDocumentInfoList_tie*& ret_);
	
	static void make_tie (const RedactionSourceDocumentInfoList& obj, RedactionSourceDocumentInfoList_tie*& ret_);

	static void make_tie (const RedactionSourceDocumentInfoList& obj, RedactionSourceDocumentInfoList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (RedactionSourceDocumentInfoList* obj, RedactionSourceDocumentInfoList_tie*& ret_);

	RedactionSourceDocumentInfoList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, RedactionSourceDocumentInfo_tie& ret_);
	virtual void __stdcall set_item (size_t index, const RedactionSourceDocumentInfo_tie& item);
	virtual size_t __stdcall add (const RedactionSourceDocumentInfo_tie& item);
	virtual size_t __stdcall insert (size_t index, const RedactionSourceDocumentInfo_tie& item);
};

#pragma pack (push, 1)

struct LinkInfo_tie {
	LinkKind kind;
	GCI::IO::IString_tie* hint;
	
	static void make_cpp (const LinkInfo_tie& obj, LinkInfo& ret_);

	static void make_tie (const LinkInfo& obj, LinkInfo_tie& ret_);
};

#pragma pack (pop)

class IDiffIterator_tie: public ::Core::IIObject_tie {
public:
	virtual ParaNum __stdcall acquire_next_4B601C0800C3 () const = 0;

	virtual ParaNum __stdcall acquire_prev_4B62D7640025 () const = 0;

	virtual bool __stdcall has_next_4B4EE0E000B0 () const = 0;

	virtual bool __stdcall has_prev_4B4EE1060152 () const = 0;

	virtual void __stdcall move_to_4B4EE16E00EC (
		ParaNum para
	) /*throw (CanNotFindData_tie)*/ = 0;

	virtual ParaNum __stdcall next_4B4EE1330087 () /*throw (CanNotFindData_tie)*/ = 0;

	virtual ParaNum __stdcall prev_4B4EE156033B () /*throw (CanNotFindData_tie)*/ = 0;
};

class __declspec (dllexport) DiffIterator_tie: public IDiffIterator_tie {
	SET_OBJECT_COUNTER (DiffIterator_tie)
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
	DiffIterator_tie ();

	typedef ::Core::PoolObjectManager<DiffIterator_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DiffIterator_tie> Pool;
	friend class ::Core::PoolObjectManager<DiffIterator_tie>;
	typedef ::Core::IidMapRegistrator<DiffIterator_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDiffIterator_tie* obj, DiffIterator*& ret_, bool interface_addref = false);

	static void make_tie (const DiffIterator* obj, IDiffIterator_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DiffIterator& obj, IDiffIterator_tie*& ret_, const Core::TIEBase* owner);

	DiffIterator* m_impl;

protected:
	virtual ParaNum __stdcall acquire_next_4B601C0800C3 () const;

	virtual ParaNum __stdcall acquire_prev_4B62D7640025 () const;

	virtual bool __stdcall has_next_4B4EE0E000B0 () const;

	virtual bool __stdcall has_prev_4B4EE1060152 () const;

	virtual void __stdcall move_to_4B4EE16E00EC (
		ParaNum para
	) /*throw (CanNotFindData_tie)*/;

	virtual ParaNum __stdcall next_4B4EE1330087 () /*throw (CanNotFindData_tie)*/;

	virtual ParaNum __stdcall prev_4B4EE156033B () /*throw (CanNotFindData_tie)*/;
};

#pragma pack (push, 1)

struct Context_tie {
	NodeIndexPath_tie* path;
	long start;
	long finish;
	
	static void make_cpp (const Context_tie& obj, Context& ret_);

	static void make_tie (const Context& obj, Context_tie& ret_);
};

#pragma pack (pop)

typedef GCI::IO::IStream_tie IEVDStream_tie;
typedef GCI::IO::Stream_tie EVDStream_tie;

#pragma pack (push, 1)

struct Bookmark2_tie {
	ExternalID para_id;
	unsigned long eid;
	GCI::IO::IString_tie* name;
	
	static void make_cpp (const Bookmark2_tie& obj, Bookmark2& ret_);

	static void make_tie (const Bookmark2& obj, Bookmark2_tie& ret_);
};

#pragma pack (pop)

class BookmarkList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (BookmarkList_tie)
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
	BookmarkList_tie ();

	typedef ::Core::PoolObjectManager<BookmarkList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<BookmarkList_tie> Pool;
	friend class ::Core::PoolObjectManager<BookmarkList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const BookmarkList_tie* obj, BookmarkList*& ret_);

	static void make_tie (BookmarkList* obj, BookmarkList_tie*& ret_);
	
	static void make_tie (const BookmarkList& obj, BookmarkList_tie*& ret_);

	static void make_tie (const BookmarkList& obj, BookmarkList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (BookmarkList* obj, BookmarkList_tie*& ret_);

	BookmarkList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, Bookmark2_tie& ret_);
	virtual void __stdcall set_item (size_t index, const Bookmark2_tie& item);
	virtual size_t __stdcall add (const Bookmark2_tie& item);
	virtual size_t __stdcall insert (size_t index, const Bookmark2_tie& item);
};

class FragmentList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (FragmentList_tie)
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
	FragmentList_tie ();

	typedef ::Core::PoolObjectManager<FragmentList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FragmentList_tie> Pool;
	friend class ::Core::PoolObjectManager<FragmentList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const FragmentList_tie* obj, FragmentList*& ret_);

	static void make_tie (FragmentList* obj, FragmentList_tie*& ret_);
	
	static void make_tie (const FragmentList& obj, FragmentList_tie*& ret_);

	static void make_tie (const FragmentList& obj, FragmentList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (FragmentList* obj, FragmentList_tie*& ret_);

	FragmentList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, Context_tie& ret_);
	virtual void __stdcall set_item (size_t index, const Context_tie& item);
	virtual size_t __stdcall add (const Context_tie& item);
	virtual size_t __stdcall insert (size_t index, const Context_tie& item);
};

class SubList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (SubList_tie)
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
	SubList_tie ();

	typedef ::Core::PoolObjectManager<SubList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SubList_tie> Pool;
	friend class ::Core::PoolObjectManager<SubList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const SubList_tie* obj, SubList*& ret_);

	static void make_tie (SubList* obj, SubList_tie*& ret_);
	
	static void make_tie (const SubList& obj, SubList_tie*& ret_);

	static void make_tie (const SubList& obj, SubList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (SubList* obj, SubList_tie*& ret_);

	SubList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual unsigned long __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, unsigned long item);
	virtual size_t __stdcall add (unsigned long item);
	virtual size_t __stdcall insert (size_t index, unsigned long item);
};

class ContextList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (ContextList_tie)
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
	ContextList_tie ();

	typedef ::Core::PoolObjectManager<ContextList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ContextList_tie> Pool;
	friend class ::Core::PoolObjectManager<ContextList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const ContextList_tie* obj, ContextList*& ret_);

	static void make_tie (ContextList* obj, ContextList_tie*& ret_);
	
	static void make_tie (const ContextList& obj, ContextList_tie*& ret_);

	static void make_tie (const ContextList& obj, ContextList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (ContextList* obj, ContextList_tie*& ret_);

	ContextList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, FragmentList_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const FragmentList_tie* item);
	virtual size_t __stdcall add (const FragmentList_tie* item);
	virtual size_t __stdcall insert (size_t index, const FragmentList_tie* item);
};

class IFoundContext_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_list (ContextList_tie*& ret_) const = 0;
};

class __declspec (dllexport) FoundContext_tie: public IFoundContext_tie {
	SET_OBJECT_COUNTER (FoundContext_tie)
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
	FoundContext_tie ();

	typedef ::Core::PoolObjectManager<FoundContext_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FoundContext_tie> Pool;
	friend class ::Core::PoolObjectManager<FoundContext_tie>;
	typedef ::Core::IidMapRegistrator<FoundContext_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFoundContext_tie* obj, FoundContext*& ret_, bool interface_addref = false);

	static void make_tie (const FoundContext* obj, IFoundContext_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const FoundContext& obj, IFoundContext_tie*& ret_, const Core::TIEBase* owner);

	FoundContext* m_impl;

protected:

	virtual void __stdcall get_list (ContextList_tie*& ret_) const;
};

class IDocumentTextProvider_tie: public ::Core::IIObject_tie {
public:
	virtual unsigned long __stdcall all_leaf_para_count_4C5ABA2E0009 (
		LayerID layer_id
	) /*throw (InvalidLayerID_tie)*/ = 0;

	virtual unsigned long __stdcall children_count_4C5ABAED00E5 (
		LayerID layer_id
	) /*throw (InvalidLayerID_tie)*/ = 0;

	virtual void __stdcall find_block_or_sub_4C5ABB37029A (
		ExternalID id
		, NodeIndexPath_tie*& ret_
	) /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall find_context_4C5ABBC300BE (
		const GCI::IO::IString_tie* context
		, ExternalID from_id
		, IFoundContext_tie*& ret_
	) /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall find_para_4C5ABB88003B (
		ExternalID id
		, NodeIndexPath_tie*& ret_
	) /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_child_bookmarks_4C5AB8BF0144 (
		const EntryPoint& id
		, BookmarkList_tie*& ret_
	) /*throw (EmptyResult_tie, InvalidEntryPoint_tie)*/ = 0;

	virtual void __stdcall get_child_comment_4C5AB83001A2 (
		const EntryPoint& id
		, IEVDStream_tie*& ret_
	) /*throw (InvalidEntryPoint_tie)*/ = 0;

	virtual void __stdcall get_child_evd_style_4C5AB80A00E4 (
		const EntryPoint& id
		, IEVDStream_tie*& ret_
	) /*throw (InvalidEntryPoint_tie)*/ = 0;

	virtual ExternalID __stdcall get_child_external_id_4C5AB6D90193 (
		const EntryPoint& id
	) /*throw (InvalidEntryPoint_tie)*/ = 0;

	virtual LayerID __stdcall get_child_layer_id_4C5AB68E0235 (
		const EntryPoint& id
	) /*throw (InvalidEntryPoint_tie)*/ = 0;

	virtual void __stdcall get_child_tech_comment_4D09D82502D2 (
		const EntryPoint& id
		, GCI::IO::IString_tie*& ret_
	) /*throw (InvalidEntryPoint_tie)*/ = 0;

	virtual void __stdcall get_child_text_4C5AB9ED0306 (
		const EntryPoint& id
		, GCI::IO::IString_tie*& ret_
	) /*throw (InvalidEntryPoint_tie)*/ = 0;

	virtual EVDType __stdcall get_child_type_4C5AB62C02FC (
		const EntryPoint& id
	) /*throw (InvalidEntryPoint_tie)*/ = 0;

	virtual void __stdcall get_prefix_tree_4D0F9F6500F6 (
		ExternalID id
		, INodeBase_tie*& ret_
	) = 0;

	virtual void __stdcall get_sub_list_4C9B414301FB (
		const EntryPoint& id
		, SubList_tie*& ret_
	) = 0;

	virtual bool __stdcall has_same_5582C01300CB (
		ExternalID id
	) = 0;

	virtual void __stdcall remove_child_comment_4CC5505001CE (
		const EntryPoint& id
	) = 0;

	virtual void __stdcall set_child_comment_4C5AB859016E (
		const EntryPoint& id
		, const IEVDStream_tie* comment
	) /*throw (InvalidEntryPoint_tie)*/ = 0;

	virtual bool __stdcall show_sub_panel_icon_51E40487028B (
		ExternalID id
	) = 0;
};

class __declspec (dllexport) DocumentTextProvider_tie: public IDocumentTextProvider_tie {
	SET_OBJECT_COUNTER (DocumentTextProvider_tie)
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
	DocumentTextProvider_tie ();

	typedef ::Core::PoolObjectManager<DocumentTextProvider_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DocumentTextProvider_tie> Pool;
	friend class ::Core::PoolObjectManager<DocumentTextProvider_tie>;
	typedef ::Core::IidMapRegistrator<DocumentTextProvider_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDocumentTextProvider_tie* obj, DocumentTextProvider*& ret_, bool interface_addref = false);

	static void make_tie (const DocumentTextProvider* obj, IDocumentTextProvider_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DocumentTextProvider& obj, IDocumentTextProvider_tie*& ret_, const Core::TIEBase* owner);

	DocumentTextProvider* m_impl;

protected:
	virtual unsigned long __stdcall all_leaf_para_count_4C5ABA2E0009 (
		LayerID layer_id
	) /*throw (InvalidLayerID_tie)*/;

	virtual unsigned long __stdcall children_count_4C5ABAED00E5 (
		LayerID layer_id
	) /*throw (InvalidLayerID_tie)*/;

	virtual void __stdcall find_block_or_sub_4C5ABB37029A (
		ExternalID id
		, NodeIndexPath_tie*& ret_
	) /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall find_context_4C5ABBC300BE (
		const GCI::IO::IString_tie* context
		, ExternalID from_id
		, IFoundContext_tie*& ret_
	) /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall find_para_4C5ABB88003B (
		ExternalID id
		, NodeIndexPath_tie*& ret_
	) /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_child_bookmarks_4C5AB8BF0144 (
		const EntryPoint& id
		, BookmarkList_tie*& ret_
	) /*throw (EmptyResult_tie, InvalidEntryPoint_tie)*/;

	virtual void __stdcall get_child_comment_4C5AB83001A2 (
		const EntryPoint& id
		, IEVDStream_tie*& ret_
	) /*throw (InvalidEntryPoint_tie)*/;

	virtual void __stdcall get_child_evd_style_4C5AB80A00E4 (
		const EntryPoint& id
		, IEVDStream_tie*& ret_
	) /*throw (InvalidEntryPoint_tie)*/;

	virtual ExternalID __stdcall get_child_external_id_4C5AB6D90193 (
		const EntryPoint& id
	) /*throw (InvalidEntryPoint_tie)*/;

	virtual LayerID __stdcall get_child_layer_id_4C5AB68E0235 (
		const EntryPoint& id
	) /*throw (InvalidEntryPoint_tie)*/;

	virtual void __stdcall get_child_tech_comment_4D09D82502D2 (
		const EntryPoint& id
		, GCI::IO::IString_tie*& ret_
	) /*throw (InvalidEntryPoint_tie)*/;

	virtual void __stdcall get_child_text_4C5AB9ED0306 (
		const EntryPoint& id
		, GCI::IO::IString_tie*& ret_
	) /*throw (InvalidEntryPoint_tie)*/;

	virtual EVDType __stdcall get_child_type_4C5AB62C02FC (
		const EntryPoint& id
	) /*throw (InvalidEntryPoint_tie)*/;

	virtual void __stdcall get_prefix_tree_4D0F9F6500F6 (
		ExternalID id
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall get_sub_list_4C9B414301FB (
		const EntryPoint& id
		, SubList_tie*& ret_
	);

	virtual bool __stdcall has_same_5582C01300CB (
		ExternalID id
	);

	virtual void __stdcall remove_child_comment_4CC5505001CE (
		const EntryPoint& id
	);

	virtual void __stdcall set_child_comment_4C5AB859016E (
		const EntryPoint& id
		, const IEVDStream_tie* comment
	) /*throw (InvalidEntryPoint_tie)*/;

	virtual bool __stdcall show_sub_panel_icon_51E40487028B (
		ExternalID id
	);
};

class DocumentTextProviderList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (DocumentTextProviderList_tie)
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
	DocumentTextProviderList_tie ();

	typedef ::Core::PoolObjectManager<DocumentTextProviderList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DocumentTextProviderList_tie> Pool;
	friend class ::Core::PoolObjectManager<DocumentTextProviderList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const DocumentTextProviderList_tie* obj, DocumentTextProviderList*& ret_);

	static void make_tie (DocumentTextProviderList* obj, DocumentTextProviderList_tie*& ret_);
	
	static void make_tie (const DocumentTextProviderList& obj, DocumentTextProviderList_tie*& ret_);

	static void make_tie (const DocumentTextProviderList& obj, DocumentTextProviderList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (DocumentTextProviderList* obj, DocumentTextProviderList_tie*& ret_);

	DocumentTextProviderList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IDocumentTextProvider_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IDocumentTextProvider_tie* item);
	virtual size_t __stdcall add (const IDocumentTextProvider_tie* item);
	virtual size_t __stdcall insert (size_t index, const IDocumentTextProvider_tie* item);
};

class CommentsParaList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (CommentsParaList_tie)
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
	CommentsParaList_tie ();

	typedef ::Core::PoolObjectManager<CommentsParaList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<CommentsParaList_tie> Pool;
	friend class ::Core::PoolObjectManager<CommentsParaList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const CommentsParaList_tie* obj, CommentsParaList*& ret_);

	static void make_tie (CommentsParaList* obj, CommentsParaList_tie*& ret_);
	
	static void make_tie (const CommentsParaList& obj, CommentsParaList_tie*& ret_);

	static void make_tie (const CommentsParaList& obj, CommentsParaList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (CommentsParaList* obj, CommentsParaList_tie*& ret_);

	CommentsParaList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual ParaId __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, ParaId item);
	virtual size_t __stdcall add (ParaId item);
	virtual size_t __stdcall insert (size_t index, ParaId item);
};

#pragma pack (push, 1)

struct ExternalObjectData_tie {
	ExternalObjectType type;
	ParaId para_id;
	GCI::IO::IString_tie* name;
	
	static void make_cpp (const ExternalObjectData_tie& obj, ExternalObjectData& ret_);

	static void make_tie (const ExternalObjectData& obj, ExternalObjectData_tie& ret_);
};

#pragma pack (pop)

class ExternalObjectDataList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (ExternalObjectDataList_tie)
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
	ExternalObjectDataList_tie ();

	typedef ::Core::PoolObjectManager<ExternalObjectDataList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ExternalObjectDataList_tie> Pool;
	friend class ::Core::PoolObjectManager<ExternalObjectDataList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const ExternalObjectDataList_tie* obj, ExternalObjectDataList*& ret_);

	static void make_tie (ExternalObjectDataList* obj, ExternalObjectDataList_tie*& ret_);
	
	static void make_tie (const ExternalObjectDataList& obj, ExternalObjectDataList_tie*& ret_);

	static void make_tie (const ExternalObjectDataList& obj, ExternalObjectDataList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (ExternalObjectDataList* obj, ExternalObjectDataList_tie*& ret_);

	ExternalObjectDataList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, ExternalObjectData_tie& ret_);
	virtual void __stdcall set_item (size_t index, const ExternalObjectData_tie& item);
	virtual size_t __stdcall add (const ExternalObjectData_tie& item);
	virtual size_t __stdcall insert (size_t index, const ExternalObjectData_tie& item);
};

#pragma pack (push, 1)

struct DiffData_tie {
	IDiffIterator_tie* diff_iterator;
	IDocumentTextProvider_tie* cur;
	IDocumentTextProvider_tie* prev;
	
	static void make_cpp (const DiffData_tie& obj, DiffData& ret_);

	static void make_tie (const DiffData& obj, DiffData_tie& ret_);
};

#pragma pack (pop)

class DocumentTextProviderDescriptorList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (DocumentTextProviderDescriptorList_tie)
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
	DocumentTextProviderDescriptorList_tie ();

	typedef ::Core::PoolObjectManager<DocumentTextProviderDescriptorList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DocumentTextProviderDescriptorList_tie> Pool;
	friend class ::Core::PoolObjectManager<DocumentTextProviderDescriptorList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const DocumentTextProviderDescriptorList_tie* obj, DocumentTextProviderDescriptorList*& ret_);

	static void make_tie (DocumentTextProviderDescriptorList* obj, DocumentTextProviderDescriptorList_tie*& ret_);
	
	static void make_tie (const DocumentTextProviderDescriptorList& obj, DocumentTextProviderDescriptorList_tie*& ret_);

	static void make_tie (const DocumentTextProviderDescriptorList& obj, DocumentTextProviderDescriptorList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (DocumentTextProviderDescriptorList* obj, DocumentTextProviderDescriptorList_tie*& ret_);

	DocumentTextProviderDescriptorList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, DocumentTextProviderDescriptor& ret_);
	virtual void __stdcall set_item (size_t index, const DocumentTextProviderDescriptor& item);
	virtual size_t __stdcall add (const DocumentTextProviderDescriptor& item);
	virtual size_t __stdcall insert (size_t index, const DocumentTextProviderDescriptor& item);
};

class DocPointList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (DocPointList_tie)
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
	DocPointList_tie ();

	typedef ::Core::PoolObjectManager<DocPointList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DocPointList_tie> Pool;
	friend class ::Core::PoolObjectManager<DocPointList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const DocPointList_tie* obj, DocPointList*& ret_);

	static void make_tie (DocPointList* obj, DocPointList_tie*& ret_);
	
	static void make_tie (const DocPointList& obj, DocPointList_tie*& ret_);

	static void make_tie (const DocPointList& obj, DocPointList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (DocPointList* obj, DocPointList_tie*& ret_);

	DocPointList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, DocPoint& ret_);
	virtual void __stdcall set_item (size_t index, const DocPoint& item);
	virtual size_t __stdcall add (const DocPoint& item);
	virtual size_t __stdcall insert (size_t index, const DocPoint& item);
};

class ILikeable_tie: public ::Core::IIObject_tie {
public:

	virtual const bool __stdcall get_can_like () const = 0;

	virtual void __stdcall like_4FEAFD48024F () const = 0;

	virtual void __stdcall unlike_4FEAFD5D03D1 () const = 0;
};

class __declspec (dllexport) Likeable_tie: public ILikeable_tie {
	SET_OBJECT_COUNTER (Likeable_tie)
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
	Likeable_tie ();

	typedef ::Core::PoolObjectManager<Likeable_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Likeable_tie> Pool;
	friend class ::Core::PoolObjectManager<Likeable_tie>;
	typedef ::Core::IidMapRegistrator<Likeable_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ILikeable_tie* obj, Likeable*& ret_, bool interface_addref = false);

	static void make_tie (const Likeable* obj, ILikeable_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Likeable& obj, ILikeable_tie*& ret_, const Core::TIEBase* owner);

	Likeable* m_impl;

protected:

	virtual const bool __stdcall get_can_like () const;

	virtual void __stdcall like_4FEAFD48024F () const;

	virtual void __stdcall unlike_4FEAFD5D03D1 () const;
};

#pragma pack (push, 1)

struct RedactionInfo_tie {
	GCI::IO::IString_tie* name;
	Date time_machine_date;
	Date doc_date;
	bool is_comparable;
	RedactionType actual_type;
	NotSureIntervalList_tie* not_sure_intervals;
	ActiveIntervalList_tie* active_intervals;
	RedactionID id;
	RedactionSourceDocumentInfoList_tie* changing_documents;
	
	static void make_cpp (const RedactionInfo_tie& obj, RedactionInfo& ret_);

	static void make_tie (const RedactionInfo& obj, RedactionInfo_tie& ret_);
};

#pragma pack (pop)

#pragma pack (push, 1)

struct DiffDocPara_tie {
	GCI::IO::IString_tie* text;
	IEVDStream_tie* style;
	GCI::IO::IStream_tie* data;
	EVDType type;
	long id;
	
	static void make_cpp (const DiffDocPara_tie& obj, DiffDocPara& ret_);

	static void make_tie (const DiffDocPara& obj, DiffDocPara_tie& ret_);
};

#pragma pack (pop)

class DiffDocParaList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (DiffDocParaList_tie)
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
	DiffDocParaList_tie ();

	typedef ::Core::PoolObjectManager<DiffDocParaList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DiffDocParaList_tie> Pool;
	friend class ::Core::PoolObjectManager<DiffDocParaList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const DiffDocParaList_tie* obj, DiffDocParaList*& ret_);

	static void make_tie (DiffDocParaList* obj, DiffDocParaList_tie*& ret_);
	
	static void make_tie (const DiffDocParaList& obj, DiffDocParaList_tie*& ret_);

	static void make_tie (const DiffDocParaList& obj, DiffDocParaList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (DiffDocParaList* obj, DiffDocParaList_tie*& ret_);

	DiffDocParaList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, DiffDocPara_tie& ret_);
	virtual void __stdcall set_item (size_t index, const DiffDocPara_tie& item);
	virtual size_t __stdcall add (const DiffDocPara_tie& item);
	virtual size_t __stdcall insert (size_t index, const DiffDocPara_tie& item);
};

#pragma pack (push, 1)

struct ChangedBlock_tie {
	unsigned long id;
	DiffDocParaList_tie* header;
	DiffDocParaList_tie* right_text_para_list;
	DiffDocParaList_tie* left_text_para_list;
	
	static void make_cpp (const ChangedBlock_tie& obj, ChangedBlock& ret_);

	static void make_tie (const ChangedBlock& obj, ChangedBlock_tie& ret_);
};

#pragma pack (pop)

class RedactionInfoList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (RedactionInfoList_tie)
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
	RedactionInfoList_tie ();

	typedef ::Core::PoolObjectManager<RedactionInfoList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<RedactionInfoList_tie> Pool;
	friend class ::Core::PoolObjectManager<RedactionInfoList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const RedactionInfoList_tie* obj, RedactionInfoList*& ret_);

	static void make_tie (RedactionInfoList* obj, RedactionInfoList_tie*& ret_);
	
	static void make_tie (const RedactionInfoList& obj, RedactionInfoList_tie*& ret_);

	static void make_tie (const RedactionInfoList& obj, RedactionInfoList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (RedactionInfoList* obj, RedactionInfoList_tie*& ret_);

	RedactionInfoList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, RedactionInfo_tie& ret_);
	virtual void __stdcall set_item (size_t index, const RedactionInfo_tie& item);
	virtual size_t __stdcall add (const RedactionInfo_tie& item);
	virtual size_t __stdcall insert (size_t index, const RedactionInfo_tie& item);
};

class IBookmark_tie;
class Bookmark_tie;

class IDocumentState_tie;
class DocumentState_tie;

class IJournalBookmark_tie;
class JournalBookmark_tie;

class ILink_tie;
class Link_tie;

class IDocument_tie: public IEntityBase_tie {
public:

	virtual void __stdcall get_annotation (IDocument_tie*& ret_) = 0;


	virtual void __stdcall get_attributes_root (INodeBase_tie*& ret_) = 0;


	virtual void __stdcall get_bookmark_list (BookmarkList_tie*& ret_) const = 0;


	virtual const unsigned long __stdcall get_change_status () const = 0;


	virtual void __stdcall get_comments_para_list (CommentsParaList_tie*& ret_) const = 0;


	virtual void __stdcall get_contents_root (INodeBase_tie*& ret_) /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall create_bookmark_45EEB6520194 (
		ParaId para
		, bool is_para
		, IBookmark_tie*& ret_
	) const = 0;

	virtual void __stdcall create_journal_bookmark_4A8A9AD600BC (
		ParaId para
		, IJournalBookmark_tie*& ret_
	) const = 0;

	virtual void __stdcall create_view_45EEB6520197 (
		IDocumentState_tie* filters
		, IDocument_tie*& ret_
	) = 0;


	virtual void __stdcall get_current_state (IDocumentState_tie*& ret_) = 0;


	virtual DocumentType __stdcall get_doc_type () const = 0;

	virtual void __stdcall dont_show_document_status_changes_warning_4F1E5DE102BE () const = 0;


	virtual void __stdcall get_external_object_data_list (ExternalObjectDataList_tie*& ret_) const = 0;


	virtual void __stdcall get_file_position (GCI::IO::IString_tie*& ret_) /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_annotation_header_evd_4D023D3B02B4 (
		unsigned long handle
		, GCI::IO::IStream_tie*& ret_
	) const /*throw (Unsupported_tie)*/ = 0;

	virtual size_t __stdcall get_auto_referat_doc_count_4A9F9CF3006A () const /*throw (Unsupported_tie)*/ = 0;

	virtual void __stdcall get_autoreferat_header_evd_4D023C95027A (
		GCI::IO::IStream_tie*& ret_
	) const /*throw (Unsupported_tie)*/ = 0;

	virtual void __stdcall get_correspondents_45EEB65201D7 (
		const INodeBase_tie* category
		, ICatalogBase_tie*& out_list
	) const = 0;

	virtual void __stdcall get_correspondents_to_part_45EEB6520199 (
		const PositionList_tie* pos_list
		, const INodeBase_tie* category
		, ICatalogBase_tie*& out_list
	) const = 0;

	virtual void __stdcall get_drug_list_47EBB17D009B (
		ICatalogBase_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_evd_stream_4CE3E9DF02B0 (
		GCI::IO::IStream_tie*& ret_
	) const = 0;

	virtual void __stdcall get_flash_4857C59403C6 (
		IExternalObject_tie*& ret_
	) const = 0;

	virtual void __stdcall get_internet_image_url_45EEB652019D (
		long block_id
		, IExternalLink_tie*& ret_
	) const = 0;

	virtual void __stdcall get_link_53E9F3420066 (
		unsigned long doc_id
		, const Topic& id
		, RedactionID rid
		, ILink_tie*& ret_
	) const = 0;

	virtual void __stdcall get_link_info_47AB2FC90361 (
		unsigned long doc_id
		, const Topic& id
		, RedactionID rid
		, LinkInfo_tie& ret_
	) const = 0;

	virtual void __stdcall get_linked_object_45EEB65201A3 (
		unsigned long doc_id
		, const Topic& id
		, RedactionID rid
		, LinkedObjectType& obj_type
		, Core::IIObject_tie*& obj
	) const /*throw (InvalidTopicId_tie, FolderLinkNotFound_tie)*/ = 0;

	virtual void __stdcall get_missing_info_for_object_47C6AA260009 (
		const PId& pid
		, IMissingInfo_tie*& missing_info
	) const = 0;

	virtual void __stdcall get_multi_link_info_4DCBB65D028F (
		unsigned long doc_id
		, const Topic& id
		, DocPointList_tie*& ret_
	) const /*throw (CanNotFindData_tie, InternalDatabaseError_tie)*/ = 0;

	virtual void __stdcall get_not_sure_info_45EEB65201AA (
		const Date& date
		, Date& start
		, Date& finish
		, IDocument_tie*& info
		, GCI::IO::IString_tie*& warning
	) const = 0;

	virtual void __stdcall get_respondents_45EEB65201DA (
		const INodeBase_tie* category
		, ICatalogBase_tie*& out_list
	) const = 0;

	virtual void __stdcall get_respondents_to_part_45EEB65201B0 (
		const PositionList_tie* pos_list
		, const INodeBase_tie* category
		, ICatalogBase_tie*& out_list
	) const = 0;

	virtual void __stdcall get_same_documents_45EEB65201E1 (
		ICatalogBase_tie*& out_list
	) const = 0;

	virtual void __stdcall get_same_to_point_5582DAA202AD (
		ExternalID id
		, ICatalogBase_tie*& out_list
	) const = 0;

	virtual void __stdcall get_self_missing_info_4D3D6F030110 (
		IMissingInfo_tie*& missing_info
	) const = 0;

	virtual void __stdcall get_text_provider_4CAF1A4B0096 (
		bool all_at_once
		, IDocumentTextProvider_tie*& ret_
	) const /*throw (Unsupported_tie, CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_text_provider_by_desc_4D6291D500E7 (
		unsigned long handle
		, IDocumentTextProvider_tie*& ret_
	) /*throw (Unsupported_tie)*/ = 0;

	virtual void __stdcall get_text_provider_desc_list_4D6289D601A0 (
		DocumentTextProviderDescriptorList_tie*& ret_
	) /*throw (Unsupported_tie)*/ = 0;

	virtual void __stdcall get_text_provider_list_4CED4A090217 (
		bool all_at_once
		, DocumentTextProviderList_tie*& ret_
	) /*throw (Unsupported_tie)*/ = 0;

	virtual void __stdcall get_time_machine_warning_45EEB65201BE (
		const Date& date
		, TimeMachineWarning_tie& ret_
	) = 0;

	virtual bool __stdcall has_annotation_45EEB65201C8 () const = 0;

	virtual bool __stdcall has_attributes_45EEB65201C9 () const = 0;

	virtual bool __stdcall has_chronology_53C3BD6F0050 () const = 0;

	virtual bool __stdcall has_correspondents_45EEB65201C0 (
		const INodeBase_tie* category
	) const = 0;

	virtual bool __stdcall has_internet_image_45EEB65201C2 () const = 0;

	virtual bool __stdcall has_next_redaction_45EEB65201C3 () const = 0;

	virtual bool __stdcall has_prev_redaction_45EEB65201C4 () const = 0;

	virtual bool __stdcall has_related_doc_45EEB65201C5 () const = 0;

	virtual bool __stdcall has_respondents_45EEB65201C6 (
		const INodeBase_tie* category
	) const = 0;

	virtual bool __stdcall has_same_documents_45EEB65201E0 () const = 0;

	virtual bool __stdcall has_translation_45EEB65201DF () const = 0;

	virtual bool __stdcall has_warning_45EEB65201CA () const = 0;


	virtual unsigned long __stdcall get_internal_id () const = 0;

	virtual bool __stdcall is_alive_45EEB65201CB () const = 0;

	virtual bool __stdcall is_date_in_not_sure_interval_45EEB65201CC (
		const Date& date
	) const = 0;

	virtual bool __stdcall is_morpho_search_supported_46CD4B9D030D () const = 0;

	virtual bool __stdcall is_my_bookmark_45EEB65201CE (
		const IBookmark_tie* bookmark
	) const = 0;

	virtual bool __stdcall is_same_document_45EEB65201D0 (
		const IDocument_tie* doc
	) const = 0;

	virtual bool __stdcall is_same_redaction_45EEB65201D2 (
		const IDocument_tie* view
	) const = 0;

	virtual bool __stdcall is_same_view_45EEB65201D4 (
		const IDocument_tie* view
	) const = 0;

	virtual bool __stdcall may_show_attributes_45EEB65201D6 () const = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;


	virtual const bool __stdcall get_new_revision_available () const = 0;


	virtual const bool __stdcall get_not_tm () const = 0;


	virtual void __stdcall get_redactions_list (RedactionInfoList_tie*& ret_) const = 0;


	virtual void __stdcall get_related_doc (IDocument_tie*& ret_) = 0;


	virtual void __stdcall get_short_name (GCI::IO::IString_tie*& ret_) = 0;


	virtual unsigned long __stdcall get_size () const = 0;


	virtual const ItemStatus __stdcall get_status () const = 0;


	virtual void __stdcall get_text_languages (LanguagesList_tie*& ret_) const = 0;


	virtual void __stdcall get_translation (IDocument_tie*& ret_) = 0;


	virtual void __stdcall get_warning (GCI::IO::IString_tie*& ret_) = 0;
};

class __declspec (dllexport) Document_tie: public IDocument_tie {
	SET_OBJECT_COUNTER (Document_tie)
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
	Document_tie ();

	typedef ::Core::PoolObjectManager<Document_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Document_tie> Pool;
	friend class ::Core::PoolObjectManager<Document_tie>;
	typedef ::Core::IidMapRegistrator<Document_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDocument_tie* obj, Document*& ret_, bool interface_addref = false);

	static void make_tie (const Document* obj, IDocument_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Document& obj, IDocument_tie*& ret_, const Core::TIEBase* owner);

	Document* m_impl;

protected:

	virtual bool __stdcall get_is_saved () const;


	virtual bool __stdcall get_is_changed () const;


	virtual const unsigned long __stdcall get_eid () const /*throw (Unsupported_tie)*/;

	virtual void __stdcall save_to_456EB3E10178 (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/;

	virtual void __stdcall append_to_456EB3E1017A (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/;

	virtual void __stdcall get_annotation (IDocument_tie*& ret_);


	virtual void __stdcall get_attributes_root (INodeBase_tie*& ret_);


	virtual void __stdcall get_bookmark_list (BookmarkList_tie*& ret_) const;


	virtual const unsigned long __stdcall get_change_status () const;


	virtual void __stdcall get_comments_para_list (CommentsParaList_tie*& ret_) const;


	virtual void __stdcall get_contents_root (INodeBase_tie*& ret_) /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall create_bookmark_45EEB6520194 (
		ParaId para
		, bool is_para
		, IBookmark_tie*& ret_
	) const;

	virtual void __stdcall create_journal_bookmark_4A8A9AD600BC (
		ParaId para
		, IJournalBookmark_tie*& ret_
	) const;

	virtual void __stdcall create_view_45EEB6520197 (
		IDocumentState_tie* filters
		, IDocument_tie*& ret_
	);


	virtual void __stdcall get_current_state (IDocumentState_tie*& ret_);


	virtual DocumentType __stdcall get_doc_type () const;

	virtual void __stdcall dont_show_document_status_changes_warning_4F1E5DE102BE () const;


	virtual void __stdcall get_external_object_data_list (ExternalObjectDataList_tie*& ret_) const;


	virtual void __stdcall get_file_position (GCI::IO::IString_tie*& ret_) /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_annotation_header_evd_4D023D3B02B4 (
		unsigned long handle
		, GCI::IO::IStream_tie*& ret_
	) const /*throw (Unsupported_tie)*/;

	virtual size_t __stdcall get_auto_referat_doc_count_4A9F9CF3006A () const /*throw (Unsupported_tie)*/;

	virtual void __stdcall get_autoreferat_header_evd_4D023C95027A (
		GCI::IO::IStream_tie*& ret_
	) const /*throw (Unsupported_tie)*/;

	virtual void __stdcall get_correspondents_45EEB65201D7 (
		const INodeBase_tie* category
		, ICatalogBase_tie*& out_list
	) const;

	virtual void __stdcall get_correspondents_to_part_45EEB6520199 (
		const PositionList_tie* pos_list
		, const INodeBase_tie* category
		, ICatalogBase_tie*& out_list
	) const;

	virtual void __stdcall get_drug_list_47EBB17D009B (
		ICatalogBase_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_evd_stream_4CE3E9DF02B0 (
		GCI::IO::IStream_tie*& ret_
	) const;

	virtual void __stdcall get_flash_4857C59403C6 (
		IExternalObject_tie*& ret_
	) const;

	virtual void __stdcall get_internet_image_url_45EEB652019D (
		long block_id
		, IExternalLink_tie*& ret_
	) const;

	virtual void __stdcall get_link_53E9F3420066 (
		unsigned long doc_id
		, const Topic& id
		, RedactionID rid
		, ILink_tie*& ret_
	) const;

	virtual void __stdcall get_link_info_47AB2FC90361 (
		unsigned long doc_id
		, const Topic& id
		, RedactionID rid
		, LinkInfo_tie& ret_
	) const;

	virtual void __stdcall get_linked_object_45EEB65201A3 (
		unsigned long doc_id
		, const Topic& id
		, RedactionID rid
		, LinkedObjectType& obj_type
		, Core::IIObject_tie*& obj
	) const /*throw (InvalidTopicId_tie, FolderLinkNotFound_tie)*/;

	virtual void __stdcall get_missing_info_for_object_47C6AA260009 (
		const PId& pid
		, IMissingInfo_tie*& missing_info
	) const;

	virtual void __stdcall get_multi_link_info_4DCBB65D028F (
		unsigned long doc_id
		, const Topic& id
		, DocPointList_tie*& ret_
	) const /*throw (CanNotFindData_tie, InternalDatabaseError_tie)*/;

	virtual void __stdcall get_not_sure_info_45EEB65201AA (
		const Date& date
		, Date& start
		, Date& finish
		, IDocument_tie*& info
		, GCI::IO::IString_tie*& warning
	) const;

	virtual void __stdcall get_respondents_45EEB65201DA (
		const INodeBase_tie* category
		, ICatalogBase_tie*& out_list
	) const;

	virtual void __stdcall get_respondents_to_part_45EEB65201B0 (
		const PositionList_tie* pos_list
		, const INodeBase_tie* category
		, ICatalogBase_tie*& out_list
	) const;

	virtual void __stdcall get_same_documents_45EEB65201E1 (
		ICatalogBase_tie*& out_list
	) const;

	virtual void __stdcall get_same_to_point_5582DAA202AD (
		ExternalID id
		, ICatalogBase_tie*& out_list
	) const;

	virtual void __stdcall get_self_missing_info_4D3D6F030110 (
		IMissingInfo_tie*& missing_info
	) const;

	virtual void __stdcall get_text_provider_4CAF1A4B0096 (
		bool all_at_once
		, IDocumentTextProvider_tie*& ret_
	) const /*throw (Unsupported_tie, CanNotFindData_tie)*/;

	virtual void __stdcall get_text_provider_by_desc_4D6291D500E7 (
		unsigned long handle
		, IDocumentTextProvider_tie*& ret_
	) /*throw (Unsupported_tie)*/;

	virtual void __stdcall get_text_provider_desc_list_4D6289D601A0 (
		DocumentTextProviderDescriptorList_tie*& ret_
	) /*throw (Unsupported_tie)*/;

	virtual void __stdcall get_text_provider_list_4CED4A090217 (
		bool all_at_once
		, DocumentTextProviderList_tie*& ret_
	) /*throw (Unsupported_tie)*/;

	virtual void __stdcall get_time_machine_warning_45EEB65201BE (
		const Date& date
		, TimeMachineWarning_tie& ret_
	);

	virtual bool __stdcall has_annotation_45EEB65201C8 () const;

	virtual bool __stdcall has_attributes_45EEB65201C9 () const;

	virtual bool __stdcall has_chronology_53C3BD6F0050 () const;

	virtual bool __stdcall has_correspondents_45EEB65201C0 (
		const INodeBase_tie* category
	) const;

	virtual bool __stdcall has_internet_image_45EEB65201C2 () const;

	virtual bool __stdcall has_next_redaction_45EEB65201C3 () const;

	virtual bool __stdcall has_prev_redaction_45EEB65201C4 () const;

	virtual bool __stdcall has_related_doc_45EEB65201C5 () const;

	virtual bool __stdcall has_respondents_45EEB65201C6 (
		const INodeBase_tie* category
	) const;

	virtual bool __stdcall has_same_documents_45EEB65201E0 () const;

	virtual bool __stdcall has_translation_45EEB65201DF () const;

	virtual bool __stdcall has_warning_45EEB65201CA () const;


	virtual unsigned long __stdcall get_internal_id () const;

	virtual bool __stdcall is_alive_45EEB65201CB () const;

	virtual bool __stdcall is_date_in_not_sure_interval_45EEB65201CC (
		const Date& date
	) const;

	virtual bool __stdcall is_morpho_search_supported_46CD4B9D030D () const;

	virtual bool __stdcall is_my_bookmark_45EEB65201CE (
		const IBookmark_tie* bookmark
	) const;

	virtual bool __stdcall is_same_document_45EEB65201D0 (
		const IDocument_tie* doc
	) const;

	virtual bool __stdcall is_same_redaction_45EEB65201D2 (
		const IDocument_tie* view
	) const;

	virtual bool __stdcall is_same_view_45EEB65201D4 (
		const IDocument_tie* view
	) const;

	virtual bool __stdcall may_show_attributes_45EEB65201D6 () const;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);


	virtual const bool __stdcall get_new_revision_available () const;


	virtual const bool __stdcall get_not_tm () const;


	virtual void __stdcall get_redactions_list (RedactionInfoList_tie*& ret_) const;


	virtual void __stdcall get_related_doc (IDocument_tie*& ret_);


	virtual void __stdcall get_short_name (GCI::IO::IString_tie*& ret_);


	virtual unsigned long __stdcall get_size () const;


	virtual const ItemStatus __stdcall get_status () const;


	virtual void __stdcall get_text_languages (LanguagesList_tie*& ret_) const;


	virtual void __stdcall get_translation (IDocument_tie*& ret_);


	virtual void __stdcall get_warning (GCI::IO::IString_tie*& ret_);
};

class IBookmark_tie: public IEntityBase_tie {
public:

	virtual void __stdcall get_comment (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_comment (GCI::IO::IString_tie* comment) = 0;


	virtual void __stdcall get_document (IDocument_tie*& ret_) = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_name (GCI::IO::IString_tie* name) = 0;


	virtual ParaId __stdcall get_paragraph () const = 0;


	virtual void __stdcall get_pid (PId& ret_) const = 0;
};

class __declspec (dllexport) Bookmark_tie: public IBookmark_tie {
	SET_OBJECT_COUNTER (Bookmark_tie)
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
	Bookmark_tie ();

	typedef ::Core::PoolObjectManager<Bookmark_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Bookmark_tie> Pool;
	friend class ::Core::PoolObjectManager<Bookmark_tie>;
	typedef ::Core::IidMapRegistrator<Bookmark_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IBookmark_tie* obj, Bookmark*& ret_, bool interface_addref = false);

	static void make_tie (const Bookmark* obj, IBookmark_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Bookmark& obj, IBookmark_tie*& ret_, const Core::TIEBase* owner);

	Bookmark* m_impl;

protected:

	virtual bool __stdcall get_is_saved () const;


	virtual bool __stdcall get_is_changed () const;


	virtual const unsigned long __stdcall get_eid () const /*throw (Unsupported_tie)*/;

	virtual void __stdcall save_to_456EB3E10178 (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/;

	virtual void __stdcall append_to_456EB3E1017A (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/;

	virtual void __stdcall get_comment (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_comment (GCI::IO::IString_tie* comment);


	virtual void __stdcall get_document (IDocument_tie*& ret_);


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_name (GCI::IO::IString_tie* name);


	virtual ParaId __stdcall get_paragraph () const;


	virtual void __stdcall get_pid (PId& ret_) const;
};

class IDocumentState_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall can_compare_with_any_other_redaction_4B54571C028B () const = 0;

	virtual void __stdcall clone_4A8130CE0320 (
		IDocumentState_tie*& ret_
	) const = 0;


	virtual void __stdcall get_cur_and_next_redactions_list (RedactionInfoList_tie*& ret_) const = 0;

	virtual void __stdcall diff_with_redaction_by_id_4CC972C00194 (
		RedactionID id
		, DiffData_tie& ret_
	) const = 0;

	virtual void __stdcall get_current_redaction_46320AD6033A (
		RedactionInfo_tie& ret_
	) const = 0;

	virtual bool __stdcall is_actual_4EE7512C0058 () const = 0;

	virtual bool __stdcall is_same_redactions_4628CAEB0169 (
		const IDocumentState_tie* other
	) const = 0;


	virtual Languages __stdcall get_language () const = 0;
	virtual void __stdcall set_language (Languages language) = 0;


	virtual void __stdcall get_prev_redactions_list (RedactionInfoList_tie*& ret_) const = 0;

	virtual RedactionID __stdcall redaction_46289947018D () const = 0;

	virtual void __stdcall set_actual_redaction_45EED80E008D () const /*throw (RedactionNotFound_tie)*/ = 0;

	virtual void __stdcall set_next_redaction_45EED80E0088 () const /*throw (RedactionNotFound_tie)*/ = 0;

	virtual void __stdcall set_prev_active_redaction_4B545717011B () const /*throw (RedactionNotFound_tie)*/ = 0;

	virtual void __stdcall set_prev_redaction_45EED80E0087 () const /*throw (RedactionNotFound_tie)*/ = 0;

	virtual void __stdcall set_redaction_on_date_45EED80E0089 (
		const Date& date
	) const /*throw (RedactionNotFound_tie)*/ = 0;

	virtual void __stdcall set_redaction_on_id_45EED80E008B (
		RedactionID id
	) const /*throw (RedactionNotFound_tie)*/ = 0;
};

class __declspec (dllexport) DocumentState_tie: public IDocumentState_tie {
	SET_OBJECT_COUNTER (DocumentState_tie)
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
	DocumentState_tie ();

	typedef ::Core::PoolObjectManager<DocumentState_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DocumentState_tie> Pool;
	friend class ::Core::PoolObjectManager<DocumentState_tie>;
	typedef ::Core::IidMapRegistrator<DocumentState_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDocumentState_tie* obj, DocumentState*& ret_, bool interface_addref = false);

	static void make_tie (const DocumentState* obj, IDocumentState_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DocumentState& obj, IDocumentState_tie*& ret_, const Core::TIEBase* owner);

	DocumentState* m_impl;

protected:
	virtual bool __stdcall can_compare_with_any_other_redaction_4B54571C028B () const;

	virtual void __stdcall clone_4A8130CE0320 (
		IDocumentState_tie*& ret_
	) const;


	virtual void __stdcall get_cur_and_next_redactions_list (RedactionInfoList_tie*& ret_) const;

	virtual void __stdcall diff_with_redaction_by_id_4CC972C00194 (
		RedactionID id
		, DiffData_tie& ret_
	) const;

	virtual void __stdcall get_current_redaction_46320AD6033A (
		RedactionInfo_tie& ret_
	) const;

	virtual bool __stdcall is_actual_4EE7512C0058 () const;

	virtual bool __stdcall is_same_redactions_4628CAEB0169 (
		const IDocumentState_tie* other
	) const;


	virtual Languages __stdcall get_language () const;
	virtual void __stdcall set_language (Languages language);


	virtual void __stdcall get_prev_redactions_list (RedactionInfoList_tie*& ret_) const;

	virtual RedactionID __stdcall redaction_46289947018D () const;

	virtual void __stdcall set_actual_redaction_45EED80E008D () const /*throw (RedactionNotFound_tie)*/;

	virtual void __stdcall set_next_redaction_45EED80E0088 () const /*throw (RedactionNotFound_tie)*/;

	virtual void __stdcall set_prev_active_redaction_4B545717011B () const /*throw (RedactionNotFound_tie)*/;

	virtual void __stdcall set_prev_redaction_45EED80E0087 () const /*throw (RedactionNotFound_tie)*/;

	virtual void __stdcall set_redaction_on_date_45EED80E0089 (
		const Date& date
	) const /*throw (RedactionNotFound_tie)*/;

	virtual void __stdcall set_redaction_on_id_45EED80E008B (
		RedactionID id
	) const /*throw (RedactionNotFound_tie)*/;
};

class IJournalBookmark_tie: public IEntityBase_tie {
public:

	virtual void __stdcall get_document (IDocument_tie*& ret_) = 0;


	virtual void __stdcall get_full_name (GCI::IO::IString_tie*& ret_) = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;


	virtual const unsigned long __stdcall get_para_id () const = 0;
};

class __declspec (dllexport) JournalBookmark_tie: public IJournalBookmark_tie {
	SET_OBJECT_COUNTER (JournalBookmark_tie)
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
	JournalBookmark_tie ();

	typedef ::Core::PoolObjectManager<JournalBookmark_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<JournalBookmark_tie> Pool;
	friend class ::Core::PoolObjectManager<JournalBookmark_tie>;
	typedef ::Core::IidMapRegistrator<JournalBookmark_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IJournalBookmark_tie* obj, JournalBookmark*& ret_, bool interface_addref = false);

	static void make_tie (const JournalBookmark* obj, IJournalBookmark_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const JournalBookmark& obj, IJournalBookmark_tie*& ret_, const Core::TIEBase* owner);

	JournalBookmark* m_impl;

protected:

	virtual bool __stdcall get_is_saved () const;


	virtual bool __stdcall get_is_changed () const;


	virtual const unsigned long __stdcall get_eid () const /*throw (Unsupported_tie)*/;

	virtual void __stdcall save_to_456EB3E10178 (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/;

	virtual void __stdcall append_to_456EB3E1017A (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/;

	virtual void __stdcall get_document (IDocument_tie*& ret_);


	virtual void __stdcall get_full_name (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);


	virtual const unsigned long __stdcall get_para_id () const;
};

class ILink_tie: public ::Core::IIObject_tie {
public:
	virtual LinkKind __stdcall get_kind_53E9EF9A03AB () const = 0;

	virtual void __stdcall get_link_info_51A745CE0034 (
		LinkInfo_tie& ret_
	) const = 0;

	virtual void __stdcall get_linked_hint_51AC814F0388 (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual void __stdcall get_object_51A61EF0013E (
		Core::IIObject_tie*& ret_
	) const /*throw (InvalidTopicId_tie, FolderLinkNotFound_tie)*/ = 0;

	virtual LinkedObjectType __stdcall get_object_type_51A61ED6005B () const = 0;
};

class __declspec (dllexport) Link_tie: public ILink_tie {
	SET_OBJECT_COUNTER (Link_tie)
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
	Link_tie ();

	typedef ::Core::PoolObjectManager<Link_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Link_tie> Pool;
	friend class ::Core::PoolObjectManager<Link_tie>;
	typedef ::Core::IidMapRegistrator<Link_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ILink_tie* obj, Link*& ret_, bool interface_addref = false);

	static void make_tie (const Link* obj, ILink_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Link& obj, ILink_tie*& ret_, const Core::TIEBase* owner);

	Link* m_impl;

protected:
	virtual LinkKind __stdcall get_kind_53E9EF9A03AB () const;

	virtual void __stdcall get_link_info_51A745CE0034 (
		LinkInfo_tie& ret_
	) const;

	virtual void __stdcall get_linked_hint_51AC814F0388 (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual void __stdcall get_object_51A61EF0013E (
		Core::IIObject_tie*& ret_
	) const /*throw (InvalidTopicId_tie, FolderLinkNotFound_tie)*/;

	virtual LinkedObjectType __stdcall get_object_type_51A61ED6005B () const;
};

class JournalBookmarkList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (JournalBookmarkList_tie)
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
	JournalBookmarkList_tie ();

	typedef ::Core::PoolObjectManager<JournalBookmarkList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<JournalBookmarkList_tie> Pool;
	friend class ::Core::PoolObjectManager<JournalBookmarkList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const JournalBookmarkList_tie* obj, JournalBookmarkList*& ret_);

	static void make_tie (JournalBookmarkList* obj, JournalBookmarkList_tie*& ret_);
	
	static void make_tie (const JournalBookmarkList& obj, JournalBookmarkList_tie*& ret_);

	static void make_tie (const JournalBookmarkList& obj, JournalBookmarkList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (JournalBookmarkList* obj, JournalBookmarkList_tie*& ret_);

	JournalBookmarkList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IJournalBookmark_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IJournalBookmark_tie* item);
	virtual size_t __stdcall add (const IJournalBookmark_tie* item);
	virtual size_t __stdcall insert (size_t index, const IJournalBookmark_tie* item);
};

class IDiffDocDataProvider_tie: public ::Core::IIObject_tie {
public:
	virtual unsigned long __stdcall get_all_leaf_para_count_4D78D86C0070 () const = 0;

	virtual void __stdcall get_changed_block_4D78DBB90348 (
		unsigned long i
		, ChangedBlock_tie& ret_
	) const = 0;

	virtual unsigned long __stdcall get_changed_block_count_4D78DB960024 () const = 0;

	virtual bool __stdcall get_date_para_left_4D78DB34007D (
		DiffDocPara_tie& para
	) const = 0;

	virtual bool __stdcall get_date_para_right_4D78DB060332 (
		DiffDocPara_tie& para
	) const = 0;

	virtual void __stdcall get_header_para_list_4D78D893019F (
		DiffDocParaList_tie*& ret_
	) const = 0;

	virtual void __stdcall get_redaction_name_left_4D78DB6C025D (
		DiffDocPara_tie& ret_
	) const = 0;

	virtual void __stdcall get_redaction_name_right_4D78DB3B00AF (
		DiffDocPara_tie& ret_
	) const = 0;
};

class __declspec (dllexport) DiffDocDataProvider_tie: public IDiffDocDataProvider_tie {
	SET_OBJECT_COUNTER (DiffDocDataProvider_tie)
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
	DiffDocDataProvider_tie ();

	typedef ::Core::PoolObjectManager<DiffDocDataProvider_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DiffDocDataProvider_tie> Pool;
	friend class ::Core::PoolObjectManager<DiffDocDataProvider_tie>;
	typedef ::Core::IidMapRegistrator<DiffDocDataProvider_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDiffDocDataProvider_tie* obj, DiffDocDataProvider*& ret_, bool interface_addref = false);

	static void make_tie (const DiffDocDataProvider* obj, IDiffDocDataProvider_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DiffDocDataProvider& obj, IDiffDocDataProvider_tie*& ret_, const Core::TIEBase* owner);

	DiffDocDataProvider* m_impl;

protected:
	virtual unsigned long __stdcall get_all_leaf_para_count_4D78D86C0070 () const;

	virtual void __stdcall get_changed_block_4D78DBB90348 (
		unsigned long i
		, ChangedBlock_tie& ret_
	) const;

	virtual unsigned long __stdcall get_changed_block_count_4D78DB960024 () const;

	virtual bool __stdcall get_date_para_left_4D78DB34007D (
		DiffDocPara_tie& para
	) const;

	virtual bool __stdcall get_date_para_right_4D78DB060332 (
		DiffDocPara_tie& para
	) const;

	virtual void __stdcall get_header_para_list_4D78D893019F (
		DiffDocParaList_tie*& ret_
	) const;

	virtual void __stdcall get_redaction_name_left_4D78DB6C025D (
		DiffDocPara_tie& ret_
	) const;

	virtual void __stdcall get_redaction_name_right_4D78DB3B00AF (
		DiffDocPara_tie& ret_
	) const;
};

class IObjectFromLink_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall get_object_559EA0D2028B (
		Core::IIObject_tie*& ret_
	) const = 0;

	virtual LinkedObjectType __stdcall get_object_type_559EA0DE038A () const = 0;
};

class __declspec (dllexport) ObjectFromLink_tie: public IObjectFromLink_tie {
	SET_OBJECT_COUNTER (ObjectFromLink_tie)
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
	ObjectFromLink_tie ();

	typedef ::Core::PoolObjectManager<ObjectFromLink_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ObjectFromLink_tie> Pool;
	friend class ::Core::PoolObjectManager<ObjectFromLink_tie>;
	typedef ::Core::IidMapRegistrator<ObjectFromLink_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IObjectFromLink_tie* obj, ObjectFromLink*& ret_, bool interface_addref = false);

	static void make_tie (const ObjectFromLink* obj, IObjectFromLink_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ObjectFromLink& obj, IObjectFromLink_tie*& ret_, const Core::TIEBase* owner);

	ObjectFromLink* m_impl;

protected:
	virtual void __stdcall get_object_559EA0D2028B (
		Core::IIObject_tie*& ret_
	) const;

	virtual LinkedObjectType __stdcall get_object_type_559EA0DE038A () const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

