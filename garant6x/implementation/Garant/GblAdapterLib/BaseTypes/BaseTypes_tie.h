////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypes
//
// Базовые типы, используемые в адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "shared/GCI/IO/IO_tie.h"

namespace GblAdapterLib {

class INamedElement_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_comment (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_comment (GCI::IO::IString_tie* comment) = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_name (GCI::IO::IString_tie* name) = 0;
};

class __declspec (dllexport) NamedElement_tie: public INamedElement_tie {
	SET_OBJECT_COUNTER (NamedElement_tie)
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
	NamedElement_tie ();

	typedef ::Core::PoolObjectManager<NamedElement_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NamedElement_tie> Pool;
	friend class ::Core::PoolObjectManager<NamedElement_tie>;
	typedef ::Core::IidMapRegistrator<NamedElement_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const INamedElement_tie* obj, NamedElement*& ret_, bool interface_addref = false);

	static void make_tie (const NamedElement* obj, INamedElement_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const NamedElement& obj, INamedElement_tie*& ret_, const Core::TIEBase* owner);

	NamedElement* m_impl;

protected:

	virtual void __stdcall get_comment (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_comment (GCI::IO::IString_tie* comment);


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_name (GCI::IO::IString_tie* name);
};

class IEntityStorage_tie: public ::Core::IIObject_tie {
public:

};

class __declspec (dllexport) EntityStorage_tie: public IEntityStorage_tie {
	SET_OBJECT_COUNTER (EntityStorage_tie)
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
	EntityStorage_tie ();

	typedef ::Core::PoolObjectManager<EntityStorage_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<EntityStorage_tie> Pool;
	friend class ::Core::PoolObjectManager<EntityStorage_tie>;
	typedef ::Core::IidMapRegistrator<EntityStorage_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IEntityStorage_tie* obj, EntityStorage*& ret_, bool interface_addref = false);

	static void make_tie (const EntityStorage* obj, IEntityStorage_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const EntityStorage& obj, IEntityStorage_tie*& ret_, const Core::TIEBase* owner);

	EntityStorage* m_impl;

protected:

};

class IEntityBase_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall append_to_456EB3E1017A (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/ = 0;


	virtual const unsigned long __stdcall get_eid () const /*throw (Unsupported_tie)*/ = 0;


	virtual bool __stdcall get_is_changed () const = 0;


	virtual bool __stdcall get_is_saved () const = 0;

	virtual void __stdcall save_to_456EB3E10178 (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/ = 0;
};

class __declspec (dllexport) EntityBase_tie: public IEntityBase_tie {
	SET_OBJECT_COUNTER (EntityBase_tie)
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
	EntityBase_tie ();

	typedef ::Core::PoolObjectManager<EntityBase_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<EntityBase_tie> Pool;
	friend class ::Core::PoolObjectManager<EntityBase_tie>;
	typedef ::Core::IidMapRegistrator<EntityBase_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IEntityBase_tie* obj, EntityBase*& ret_, bool interface_addref = false);

	static void make_tie (const EntityBase* obj, IEntityBase_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const EntityBase& obj, IEntityBase_tie*& ret_, const Core::TIEBase* owner);

	EntityBase* m_impl;

protected:
	virtual void __stdcall append_to_456EB3E1017A (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/;


	virtual const unsigned long __stdcall get_eid () const /*throw (Unsupported_tie)*/;


	virtual bool __stdcall get_is_changed () const;


	virtual bool __stdcall get_is_saved () const;

	virtual void __stdcall save_to_456EB3E10178 (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/;
};

class ISearchEntity_tie: public ::Core::IIObject_tie {
public:

	virtual size_t __stdcall get_document_count () const = 0;


	virtual size_t __stdcall get_edition_count () const = 0;


	virtual size_t __stdcall get_entry_count () const = 0;


	virtual SearchResultType __stdcall get_result_type () const = 0;
};

class __declspec (dllexport) SearchEntity_tie: public ISearchEntity_tie {
	SET_OBJECT_COUNTER (SearchEntity_tie)
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
	SearchEntity_tie ();

	typedef ::Core::PoolObjectManager<SearchEntity_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SearchEntity_tie> Pool;
	friend class ::Core::PoolObjectManager<SearchEntity_tie>;
	typedef ::Core::IidMapRegistrator<SearchEntity_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISearchEntity_tie* obj, SearchEntity*& ret_, bool interface_addref = false);

	static void make_tie (const SearchEntity* obj, ISearchEntity_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const SearchEntity& obj, ISearchEntity_tie*& ret_, const Core::TIEBase* owner);

	SearchEntity* m_impl;

protected:

	virtual size_t __stdcall get_document_count () const;


	virtual size_t __stdcall get_edition_count () const;


	virtual size_t __stdcall get_entry_count () const;


	virtual SearchResultType __stdcall get_result_type () const;
};

class IVariant_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall get_bool_456ED2D701D6 () const /*throw (InvalidType_tie)*/ = 0;

	virtual long __stdcall get_long_456ED2D701D5 () const /*throw (InvalidType_tie)*/ = 0;

	virtual void __stdcall get_object_456ED2D701D8 (
		Core::IIObject_tie*& ret_
	) /*throw (InvalidType_tie)*/ = 0;

	virtual void __stdcall get_string_456ED2D701D7 (
		GCI::IO::IString_tie*& ret_
	) /*throw (InvalidType_tie)*/ = 0;
};

class __declspec (dllexport) Variant_tie: public IVariant_tie {
	SET_OBJECT_COUNTER (Variant_tie)
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
	Variant_tie ();

	typedef ::Core::PoolObjectManager<Variant_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Variant_tie> Pool;
	friend class ::Core::PoolObjectManager<Variant_tie>;
	typedef ::Core::IidMapRegistrator<Variant_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IVariant_tie* obj, Variant*& ret_, bool interface_addref = false);

	static void make_tie (const Variant* obj, IVariant_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Variant& obj, IVariant_tie*& ret_, const Core::TIEBase* owner);

	Variant* m_impl;

protected:
	virtual bool __stdcall get_bool_456ED2D701D6 () const /*throw (InvalidType_tie)*/;

	virtual long __stdcall get_long_456ED2D701D5 () const /*throw (InvalidType_tie)*/;

	virtual void __stdcall get_object_456ED2D701D8 (
		Core::IIObject_tie*& ret_
	) /*throw (InvalidType_tie)*/;

	virtual void __stdcall get_string_456ED2D701D7 (
		GCI::IO::IString_tie*& ret_
	) /*throw (InvalidType_tie)*/;
};

class LanguagesList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (LanguagesList_tie)
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
	LanguagesList_tie ();

	typedef ::Core::PoolObjectManager<LanguagesList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<LanguagesList_tie> Pool;
	friend class ::Core::PoolObjectManager<LanguagesList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const LanguagesList_tie* obj, LanguagesList*& ret_);

	static void make_tie (LanguagesList* obj, LanguagesList_tie*& ret_);
	
	static void make_tie (const LanguagesList& obj, LanguagesList_tie*& ret_);

	static void make_tie (const LanguagesList& obj, LanguagesList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (LanguagesList* obj, LanguagesList_tie*& ret_);

	LanguagesList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual Languages __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, Languages item);
	virtual size_t __stdcall add (Languages item);
	virtual size_t __stdcall insert (size_t index, Languages item);
};

class StringList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (StringList_tie)
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
	StringList_tie ();

	typedef ::Core::PoolObjectManager<StringList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<StringList_tie> Pool;
	friend class ::Core::PoolObjectManager<StringList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const StringList_tie* obj, StringList*& ret_);

	static void make_tie (StringList* obj, StringList_tie*& ret_);
	
	static void make_tie (const StringList& obj, StringList_tie*& ret_);

	static void make_tie (const StringList& obj, StringList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (StringList* obj, StringList_tie*& ret_);

	StringList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const GCI::IO::IString_tie* item);
	virtual size_t __stdcall add (const GCI::IO::IString_tie* item);
	virtual size_t __stdcall insert (size_t index, const GCI::IO::IString_tie* item);
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

