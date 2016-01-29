////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Folders/Folders_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Folders
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl_tie.h"

namespace GblAdapterLib {

class IFolders_tie;
class Folders_tie;

class IFoldersNode_tie: public INode_tie {
public:
	virtual bool __stdcall can_load_from_xml_469757F10138 () const = 0;

	virtual bool __stdcall can_save_consultation_to_xml_45EED5F00094 () const = 0;

	virtual bool __stdcall can_save_to_integration_xml_46433578001F () const = 0;

	virtual bool __stdcall can_save_to_xml_469755970138 () const = 0;


	virtual void __stdcall get_creation_date (Date& ret_) const = 0;


	virtual const FolderId __stdcall get_id () const = 0;

	virtual void __stdcall load_from_xml_469755D1008C (
		const char* xml_file_path
	) const /*throw (AccessDenied_tie, InvalidEntityType_tie)*/ = 0;

	virtual void __stdcall save_consultation_to_xml_45EED5F00092 (
		const char* xml_file_path
	) const = 0;

	virtual void __stdcall save_to_integration_xml_4643355B029F (
		GCI::IO::IString_tie*& ret_
	) const /*throw (InvalidEntityType_tie)*/ = 0;

	virtual void __stdcall save_to_xml_46974935032C (
		const char* xml_file_path
	) const /*throw (AccessDenied_tie, InvalidEntityType_tie)*/ = 0;
};

class __declspec (dllexport) FoldersNode_tie: public IFoldersNode_tie {
	SET_OBJECT_COUNTER (FoldersNode_tie)
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
	FoldersNode_tie ();

	typedef ::Core::PoolObjectManager<FoldersNode_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FoldersNode_tie> Pool;
	friend class ::Core::PoolObjectManager<FoldersNode_tie>;
	typedef ::Core::IidMapRegistrator<FoldersNode_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFoldersNode_tie* obj, FoldersNode*& ret_, bool interface_addref = false);

	static void make_tie (const FoldersNode* obj, IFoldersNode_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const FoldersNode& obj, IFoldersNode_tie*& ret_, const Core::TIEBase* owner);

	FoldersNode* m_impl;

protected:

	virtual long __stdcall get_level () const;


	virtual long __stdcall get_child_count () const;


	virtual long __stdcall get_all_child_count () const;


	virtual long __stdcall get_flags () const;


	virtual long __stdcall get_index () const;


	virtual long __stdcall get_through_index () const;


	virtual void __stdcall get_parent (INode_tie*& ret_);


	virtual void __stdcall get_previous_node (INode_tie*& ret_);


	virtual void __stdcall get_next_node (INode_tie*& ret_);


	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_caption (GCI::IO::IString_tie* caption) /*throw (ConstantModify_tie, AccessDenied_tie)*/;


	virtual void __stdcall get_hint (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_hint (GCI::IO::IString_tie* hint) /*throw (ConstantModify_tie, AccessDenied_tie)*/;


	virtual EntityType __stdcall get_object_type () const /*throw (Unsupported_tie)*/;

	virtual void __stdcall get_child_456FE63B01D6 (
		long index
		, INode_tie*& ret_
	) /*throw (InvalidIndex_tie)*/;

	virtual bool __stdcall is_same_node_456FE63B01D9 (
		const INode_tie* node
	) const;

	virtual void __stdcall open_456FE63B01DB (
		Core::IIObject_tie*& ret_
	) /*throw (CanNotFindData_tie, NotEntityElement_tie)*/;

	virtual void __stdcall delete_node_456FE63B01DD () /*throw (ConstantModify_tie, AccessDenied_tie, EmptyResult_tie)*/;

	virtual void __stdcall add_child_node_456FE63B01DE (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/;

	virtual void __stdcall add_sibling_node_456FE63B01E0 (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const /*throw (ConstantModify_tie, Unsupported_tie, DuplicateNode_tie)*/;

	virtual void __stdcall move_to_location_456FE63B01E2 (
		INode_tie* destination
	) /*throw (InvalidContainer_tie, MoveDisabled_tie)*/;

	virtual void __stdcall copy_to_location_456FE63B01E4 (
		INode_tie* destination
	) /*throw (CopyDisabled_tie, InvalidContainer_tie)*/;

	virtual bool __stdcall can_move_456FE63B01E6 () const;

	virtual bool __stdcall can_copy_456FE63B01E7 () const;

	virtual bool __stdcall can_insert_456FE63B01E8 (
		INode_tie* source
	) const;

	virtual bool __stdcall is_last_456FE63B01EA () const;

	virtual bool __stdcall is_first_456FE63B01EB () const;

	virtual bool __stdcall has_child_456FE63B01EC () const;

	virtual void __stdcall override_child_node_456FE63B01ED (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/;

	virtual bool __stdcall can_modify_4AA55863036D () const;
	virtual bool __stdcall can_load_from_xml_469757F10138 () const;

	virtual bool __stdcall can_save_consultation_to_xml_45EED5F00094 () const;

	virtual bool __stdcall can_save_to_integration_xml_46433578001F () const;

	virtual bool __stdcall can_save_to_xml_469755970138 () const;


	virtual void __stdcall get_creation_date (Date& ret_) const;


	virtual const FolderId __stdcall get_id () const;

	virtual void __stdcall load_from_xml_469755D1008C (
		const char* xml_file_path
	) const /*throw (AccessDenied_tie, InvalidEntityType_tie)*/;

	virtual void __stdcall save_consultation_to_xml_45EED5F00092 (
		const char* xml_file_path
	) const;

	virtual void __stdcall save_to_integration_xml_4643355B029F (
		GCI::IO::IString_tie*& ret_
	) const /*throw (InvalidEntityType_tie)*/;

	virtual void __stdcall save_to_xml_46974935032C (
		const char* xml_file_path
	) const /*throw (AccessDenied_tie, InvalidEntityType_tie)*/;
};

class IFolder_tie;
class Folder_tie;

class IFolders_tie: public IBaseCatalog_tie {
public:
	virtual void __stdcall create_folder_45EED7A20295 (
		IFolder_tie*& ret_
	) const = 0;

	virtual void __stdcall find_folder_node_45EED7A20296 (
		FolderId id
		, IFoldersNode_tie*& ret_
	) const = 0;
};

class __declspec (dllexport) Folders_tie: public IFolders_tie {
	SET_OBJECT_COUNTER (Folders_tie)
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
	Folders_tie ();

	typedef ::Core::PoolObjectManager<Folders_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Folders_tie> Pool;
	friend class ::Core::PoolObjectManager<Folders_tie>;
	typedef ::Core::IidMapRegistrator<Folders_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFolders_tie* obj, Folders*& ret_, bool interface_addref = false);

	static void make_tie (const Folders* obj, IFolders_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Folders& obj, IFolders_tie*& ret_, const Core::TIEBase* owner);

	Folders* m_impl;

protected:

	virtual void __stdcall get_root (INode_tie*& ret_);


	virtual const EntityType __stdcall get_filter () const;
	virtual void __stdcall set_filter (EntityType filter);

	virtual void __stdcall find_456FEA67007E (
		const Core::IIObject_tie* entity
		, INode_tie*& ret_
	) const;

	virtual void __stdcall find_context_456FEA670080 (
		const char* mask
		, const SearchMode& mode
		, const INode_tie* cur_item
		, ContextSearchResult_tie& result
		, INode_tie*& ret_
	) const;

	virtual void __stdcall reset_type_filter_456FEA670085 () const;
	virtual void __stdcall create_folder_45EED7A20295 (
		IFolder_tie*& ret_
	) const;

	virtual void __stdcall find_folder_node_45EED7A20296 (
		FolderId id
		, IFoldersNode_tie*& ret_
	) const;
};

class IDoneNotifier_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall done_45EEDB8B032F () = 0;
};

class __declspec (dllexport) DoneNotifier_tie: public IDoneNotifier_tie {
	SET_OBJECT_COUNTER (DoneNotifier_tie)
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
	DoneNotifier_tie ();

	typedef ::Core::PoolObjectManager<DoneNotifier_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DoneNotifier_tie> Pool;
	friend class ::Core::PoolObjectManager<DoneNotifier_tie>;
	typedef ::Core::IidMapRegistrator<DoneNotifier_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDoneNotifier_tie* obj, DoneNotifier*& ret_, bool interface_addref = false);

	static void make_tie (const DoneNotifier* obj, IDoneNotifier_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DoneNotifier& obj, IDoneNotifier_tie*& ret_, const Core::TIEBase* owner);

	DoneNotifier* m_impl;

protected:
	virtual bool __stdcall done_45EEDB8B032F ();
};

class IFolder_tie: public INamedElement_tie {
public:
	virtual bool __stdcall can_share_4AA5591A025F () const = 0;


	virtual bool __stdcall get_external () const = 0;


	virtual bool __stdcall get_shared () const = 0;
	virtual void __stdcall set_shared (bool shared) = 0;
};

class __declspec (dllexport) Folder_tie: public IFolder_tie {
	SET_OBJECT_COUNTER (Folder_tie)
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
	Folder_tie ();

	typedef ::Core::PoolObjectManager<Folder_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Folder_tie> Pool;
	friend class ::Core::PoolObjectManager<Folder_tie>;
	typedef ::Core::IidMapRegistrator<Folder_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFolder_tie* obj, Folder*& ret_, bool interface_addref = false);

	static void make_tie (const Folder* obj, IFolder_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Folder& obj, IFolder_tie*& ret_, const Core::TIEBase* owner);

	Folder* m_impl;

protected:

	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_name (GCI::IO::IString_tie* name);


	virtual void __stdcall get_comment (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_comment (GCI::IO::IString_tie* comment);
	virtual bool __stdcall can_share_4AA5591A025F () const;


	virtual bool __stdcall get_external () const;


	virtual bool __stdcall get_shared () const;
	virtual void __stdcall set_shared (bool shared);
};

#pragma pack (push, 1)

struct NotifyData_tie {
	NotifyStatus status;
	IDoneNotifier_tie* done_notifier;
	IFoldersNode_tie* folder;
	
	static void make_cpp (const NotifyData_tie& obj, NotifyData& ret_);

	static void make_tie (const NotifyData& obj, NotifyData_tie& ret_);
};

struct NotifyData_tie_for_callback {
	NotifyStatus status;
	IDoneNotifier_tie* done_notifier;
	IFoldersNode_tie* folder;
	
	~NotifyData_tie_for_callback ();
	
	static void make_cpp (const NotifyData_tie_for_callback& obj, NotifyData& ret_);

	static void make_tie (const NotifyData& obj, NotifyData_tie_for_callback& ret_);
};

#pragma pack (pop)


class IExternalFoldersChangeNotifier_tie;

// callback only cpp-wraper
class ExternalFoldersChangeNotifier_callback_tie : virtual public ExternalFoldersChangeNotifier, virtual public ::Core::IObject {
	SET_OBJECT_COUNTER (ExternalFoldersChangeNotifier_callback_tie)
	friend class IExternalFoldersChangeNotifier_tie;
protected:
	virtual unsigned long addref () const;

	virtual unsigned long ref_count () const;

public:
	virtual unsigned long release () const;
	// Произошло изменение папки. При этом необходимо перечитать только непосредственное содержимое
	// папки, исключая рекурсивную прогрузку дочерних папок.
	virtual void fire (const NotifyData& data) const;

	ExternalFoldersChangeNotifier_callback_tie ();

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;
// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

protected:
	typedef ::Core::PoolObjectManager<ExternalFoldersChangeNotifier_callback_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ExternalFoldersChangeNotifier_callback_tie> Pool;
	friend class ::Core::PoolObjectManager<ExternalFoldersChangeNotifier_callback_tie>;
	
public:
	mutable IExternalFoldersChangeNotifier_tie* m_impl;
};

// callback only abstarct interface
class IExternalFoldersChangeNotifier_tie {
public:
	virtual unsigned long __stdcall query_interface (const ::Core::ComIID& iid, void*& object) = 0;	
	virtual unsigned long __stdcall addref () const = 0;
	virtual unsigned long __stdcall release () const = 0;

	virtual void __stdcall fire_45EEDD7A017A (
		const NotifyData_tie_for_callback& data
	) const = 0;

	static void make_cpp (const IExternalFoldersChangeNotifier_tie* obj, ExternalFoldersChangeNotifier*& ret_, bool interface_addref = false);

	static void make_tie (IExternalFoldersChangeNotifier_tie* obj, ExternalFoldersChangeNotifier_callback_tie*& ret_);
};


} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

