////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Search/Search_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Search
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator_tie.h"

namespace GblAdapterLib {

class IQueryAttribute_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall clear_4663F1D20290 () = 0;

	virtual AttributeTag_const __stdcall get_tag_4767C8D803E1 () const = 0;


	virtual QueryTagType __stdcall get_type () const = 0;
};

class __declspec (dllexport) QueryAttribute_tie: public IQueryAttribute_tie {
	SET_OBJECT_COUNTER (QueryAttribute_tie)
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
	QueryAttribute_tie ();

	typedef ::Core::PoolObjectManager<QueryAttribute_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<QueryAttribute_tie> Pool;
	friend class ::Core::PoolObjectManager<QueryAttribute_tie>;
	typedef ::Core::IidMapRegistrator<QueryAttribute_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IQueryAttribute_tie* obj, QueryAttribute*& ret_, bool interface_addref = false);

	static void make_tie (const QueryAttribute* obj, IQueryAttribute_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const QueryAttribute& obj, IQueryAttribute_tie*& ret_, const Core::TIEBase* owner);

	QueryAttribute* m_impl;

protected:
	virtual void __stdcall clear_4663F1D20290 ();

	virtual AttributeTag_const __stdcall get_tag_4767C8D803E1 () const;


	virtual QueryTagType __stdcall get_type () const;
};

class IQueryPhoneNumberAttribute_tie: public IQueryAttribute_tie {
public:

	virtual void __stdcall get_city_code (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_city_code (GCI::IO::IString_tie* city_code) = 0;


	virtual void __stdcall get_phone_number (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_phone_number (GCI::IO::IString_tie* phone_number) = 0;
};

class __declspec (dllexport) QueryPhoneNumberAttribute_tie: public IQueryPhoneNumberAttribute_tie {
	SET_OBJECT_COUNTER (QueryPhoneNumberAttribute_tie)
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
	QueryPhoneNumberAttribute_tie ();

	typedef ::Core::PoolObjectManager<QueryPhoneNumberAttribute_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<QueryPhoneNumberAttribute_tie> Pool;
	friend class ::Core::PoolObjectManager<QueryPhoneNumberAttribute_tie>;
	typedef ::Core::IidMapRegistrator<QueryPhoneNumberAttribute_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IQueryPhoneNumberAttribute_tie* obj, QueryPhoneNumberAttribute*& ret_, bool interface_addref = false);

	static void make_tie (const QueryPhoneNumberAttribute* obj, IQueryPhoneNumberAttribute_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const QueryPhoneNumberAttribute& obj, IQueryPhoneNumberAttribute_tie*& ret_, const Core::TIEBase* owner);

	QueryPhoneNumberAttribute* m_impl;

protected:

	virtual QueryTagType __stdcall get_type () const;

	virtual void __stdcall clear_4663F1D20290 ();

	virtual AttributeTag_const __stdcall get_tag_4767C8D803E1 () const;

	virtual void __stdcall get_city_code (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_city_code (GCI::IO::IString_tie* city_code);


	virtual void __stdcall get_phone_number (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_phone_number (GCI::IO::IString_tie* phone_number);
};

#pragma pack (push, 1)

struct QueryNodeValue_tie {
	INodeBase_tie* node;
	QueryLogicOperation operation;
	
	static void make_cpp (const QueryNodeValue_tie& obj, QueryNodeValue& ret_);

	static void make_tie (const QueryNodeValue& obj, QueryNodeValue_tie& ret_);
};

#pragma pack (pop)

#pragma pack (push, 1)

struct ContextValue_tie {
	GCI::IO::IString_tie* context;
	QueryLogicOperation operation;
	
	static void make_cpp (const ContextValue_tie& obj, ContextValue& ret_);

	static void make_tie (const ContextValue& obj, ContextValue_tie& ret_);
};

#pragma pack (pop)

class ContextValueList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (ContextValueList_tie)
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
	ContextValueList_tie ();

	typedef ::Core::PoolObjectManager<ContextValueList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ContextValueList_tie> Pool;
	friend class ::Core::PoolObjectManager<ContextValueList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const ContextValueList_tie* obj, ContextValueList*& ret_);

	static void make_tie (ContextValueList* obj, ContextValueList_tie*& ret_);
	
	static void make_tie (const ContextValueList& obj, ContextValueList_tie*& ret_);

	static void make_tie (const ContextValueList& obj, ContextValueList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (ContextValueList* obj, ContextValueList_tie*& ret_);

	ContextValueList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, ContextValue_tie& ret_);
	virtual void __stdcall set_item (size_t index, const ContextValue_tie& item);
	virtual size_t __stdcall add (const ContextValue_tie& item);
	virtual size_t __stdcall insert (size_t index, const ContextValue_tie& item);
};

class DateValueList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (DateValueList_tie)
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
	DateValueList_tie ();

	typedef ::Core::PoolObjectManager<DateValueList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DateValueList_tie> Pool;
	friend class ::Core::PoolObjectManager<DateValueList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const DateValueList_tie* obj, DateValueList*& ret_);

	static void make_tie (DateValueList* obj, DateValueList_tie*& ret_);
	
	static void make_tie (const DateValueList& obj, DateValueList_tie*& ret_);

	static void make_tie (const DateValueList& obj, DateValueList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (DateValueList* obj, DateValueList_tie*& ret_);

	DateValueList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, DateValue& ret_);
	virtual void __stdcall set_item (size_t index, const DateValue& item);
	virtual size_t __stdcall add (const DateValue& item);
	virtual size_t __stdcall insert (size_t index, const DateValue& item);
};

class IQueryDateAttribute_tie: public IQueryAttribute_tie {
public:
	virtual void __stdcall add_value_45EEE3790392 (
		QueryLogicOperation operation
		, const Date& from
		, const Date& to
	) = 0;


	virtual void __stdcall get_values (DateValueList_tie*& ret_) const = 0;
};

class __declspec (dllexport) QueryDateAttribute_tie: public IQueryDateAttribute_tie {
	SET_OBJECT_COUNTER (QueryDateAttribute_tie)
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
	QueryDateAttribute_tie ();

	typedef ::Core::PoolObjectManager<QueryDateAttribute_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<QueryDateAttribute_tie> Pool;
	friend class ::Core::PoolObjectManager<QueryDateAttribute_tie>;
	typedef ::Core::IidMapRegistrator<QueryDateAttribute_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IQueryDateAttribute_tie* obj, QueryDateAttribute*& ret_, bool interface_addref = false);

	static void make_tie (const QueryDateAttribute* obj, IQueryDateAttribute_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const QueryDateAttribute& obj, IQueryDateAttribute_tie*& ret_, const Core::TIEBase* owner);

	QueryDateAttribute* m_impl;

protected:

	virtual QueryTagType __stdcall get_type () const;

	virtual void __stdcall clear_4663F1D20290 ();

	virtual AttributeTag_const __stdcall get_tag_4767C8D803E1 () const;
	virtual void __stdcall add_value_45EEE3790392 (
		QueryLogicOperation operation
		, const Date& from
		, const Date& to
	);


	virtual void __stdcall get_values (DateValueList_tie*& ret_) const;
};

class NodeValueList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (NodeValueList_tie)
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
	NodeValueList_tie ();

	typedef ::Core::PoolObjectManager<NodeValueList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NodeValueList_tie> Pool;
	friend class ::Core::PoolObjectManager<NodeValueList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const NodeValueList_tie* obj, NodeValueList*& ret_);

	static void make_tie (NodeValueList* obj, NodeValueList_tie*& ret_);
	
	static void make_tie (const NodeValueList& obj, NodeValueList_tie*& ret_);

	static void make_tie (const NodeValueList& obj, NodeValueList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (NodeValueList* obj, NodeValueList_tie*& ret_);

	NodeValueList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, QueryNodeValue_tie& ret_);
	virtual void __stdcall set_item (size_t index, const QueryNodeValue_tie& item);
	virtual size_t __stdcall add (const QueryNodeValue_tie& item);
	virtual size_t __stdcall insert (size_t index, const QueryNodeValue_tie& item);
};

class IQueryNodeAttribute_tie: public IQueryAttribute_tie {
public:
	virtual void __stdcall add_value_45EEE3890354 (
		QueryLogicOperation operation
		, INodeBase_tie* node
	) = 0;


	virtual void __stdcall get_values (NodeValueList_tie*& ret_) const = 0;
};

class __declspec (dllexport) QueryNodeAttribute_tie: public IQueryNodeAttribute_tie {
	SET_OBJECT_COUNTER (QueryNodeAttribute_tie)
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
	QueryNodeAttribute_tie ();

	typedef ::Core::PoolObjectManager<QueryNodeAttribute_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<QueryNodeAttribute_tie> Pool;
	friend class ::Core::PoolObjectManager<QueryNodeAttribute_tie>;
	typedef ::Core::IidMapRegistrator<QueryNodeAttribute_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IQueryNodeAttribute_tie* obj, QueryNodeAttribute*& ret_, bool interface_addref = false);

	static void make_tie (const QueryNodeAttribute* obj, IQueryNodeAttribute_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const QueryNodeAttribute& obj, IQueryNodeAttribute_tie*& ret_, const Core::TIEBase* owner);

	QueryNodeAttribute* m_impl;

protected:

	virtual QueryTagType __stdcall get_type () const;

	virtual void __stdcall clear_4663F1D20290 ();

	virtual AttributeTag_const __stdcall get_tag_4767C8D803E1 () const;
	virtual void __stdcall add_value_45EEE3890354 (
		QueryLogicOperation operation
		, INodeBase_tie* node
	);


	virtual void __stdcall get_values (NodeValueList_tie*& ret_) const;
};

class QueryAttributeList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (QueryAttributeList_tie)
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
	QueryAttributeList_tie ();

	typedef ::Core::PoolObjectManager<QueryAttributeList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<QueryAttributeList_tie> Pool;
	friend class ::Core::PoolObjectManager<QueryAttributeList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const QueryAttributeList_tie* obj, QueryAttributeList*& ret_);

	static void make_tie (QueryAttributeList* obj, QueryAttributeList_tie*& ret_);
	
	static void make_tie (const QueryAttributeList& obj, QueryAttributeList_tie*& ret_);

	static void make_tie (const QueryAttributeList& obj, QueryAttributeList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (QueryAttributeList* obj, QueryAttributeList_tie*& ret_);

	QueryAttributeList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IQueryAttribute_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IQueryAttribute_tie* item);
	virtual size_t __stdcall add (const IQueryAttribute_tie* item);
	virtual size_t __stdcall insert (size_t index, const IQueryAttribute_tie* item);
};

class OperationList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (OperationList_tie)
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
	OperationList_tie ();

	typedef ::Core::PoolObjectManager<OperationList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<OperationList_tie> Pool;
	friend class ::Core::PoolObjectManager<OperationList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const OperationList_tie* obj, OperationList*& ret_);

	static void make_tie (OperationList* obj, OperationList_tie*& ret_);
	
	static void make_tie (const OperationList& obj, OperationList_tie*& ret_);

	static void make_tie (const OperationList& obj, OperationList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (OperationList* obj, OperationList_tie*& ret_);

	OperationList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual QueryLogicOperation __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, QueryLogicOperation item);
	virtual size_t __stdcall add (QueryLogicOperation item);
	virtual size_t __stdcall insert (size_t index, QueryLogicOperation item);
};

class IQueryContextAttribute_tie: public IQueryAttribute_tie {
public:
	virtual void __stdcall add_value_45EEE3740383 (
		QueryLogicOperation operation
		, GCI::IO::IString_tie* context
	) = 0;


	virtual void __stdcall get_values (ContextValueList_tie*& ret_) const = 0;
};

class __declspec (dllexport) QueryContextAttribute_tie: public IQueryContextAttribute_tie {
	SET_OBJECT_COUNTER (QueryContextAttribute_tie)
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
	QueryContextAttribute_tie ();

	typedef ::Core::PoolObjectManager<QueryContextAttribute_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<QueryContextAttribute_tie> Pool;
	friend class ::Core::PoolObjectManager<QueryContextAttribute_tie>;
	typedef ::Core::IidMapRegistrator<QueryContextAttribute_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IQueryContextAttribute_tie* obj, QueryContextAttribute*& ret_, bool interface_addref = false);

	static void make_tie (const QueryContextAttribute* obj, IQueryContextAttribute_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const QueryContextAttribute& obj, IQueryContextAttribute_tie*& ret_, const Core::TIEBase* owner);

	QueryContextAttribute* m_impl;

protected:

	virtual QueryTagType __stdcall get_type () const;

	virtual void __stdcall clear_4663F1D20290 ();

	virtual AttributeTag_const __stdcall get_tag_4767C8D803E1 () const;
	virtual void __stdcall add_value_45EEE3740383 (
		QueryLogicOperation operation
		, GCI::IO::IString_tie* context
	);


	virtual void __stdcall get_values (ContextValueList_tie*& ret_) const;
};

class IAttributeInfo_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_available_operations (OperationList_tie*& ret_) const = 0;

	virtual void __stdcall get_default_value_45F115DD01E2 (
		IQueryAttribute_tie*& ret_
	) const = 0;


	virtual bool __stdcall get_is_exist () const = 0;
};

class __declspec (dllexport) AttributeInfo_tie: public IAttributeInfo_tie {
	SET_OBJECT_COUNTER (AttributeInfo_tie)
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
	AttributeInfo_tie ();

	typedef ::Core::PoolObjectManager<AttributeInfo_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<AttributeInfo_tie> Pool;
	friend class ::Core::PoolObjectManager<AttributeInfo_tie>;
	typedef ::Core::IidMapRegistrator<AttributeInfo_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IAttributeInfo_tie* obj, AttributeInfo*& ret_, bool interface_addref = false);

	static void make_tie (const AttributeInfo* obj, IAttributeInfo_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const AttributeInfo& obj, IAttributeInfo_tie*& ret_, const Core::TIEBase* owner);

	AttributeInfo* m_impl;

protected:

	virtual void __stdcall get_available_operations (OperationList_tie*& ret_) const;

	virtual void __stdcall get_default_value_45F115DD01E2 (
		IQueryAttribute_tie*& ret_
	) const;


	virtual bool __stdcall get_is_exist () const;
};

class ContextWordList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (ContextWordList_tie)
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
	ContextWordList_tie ();

	typedef ::Core::PoolObjectManager<ContextWordList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ContextWordList_tie> Pool;
	friend class ::Core::PoolObjectManager<ContextWordList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const ContextWordList_tie* obj, ContextWordList*& ret_);

	static void make_tie (ContextWordList* obj, ContextWordList_tie*& ret_);
	
	static void make_tie (const ContextWordList& obj, ContextWordList_tie*& ret_);

	static void make_tie (const ContextWordList& obj, ContextWordList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (ContextWordList* obj, ContextWordList_tie*& ret_);

	ContextWordList* m_impl;
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

class IQuery_tie: public IEntityBase_tie {
public:

	virtual void __stdcall get_attributes (QueryAttributeList_tie*& ret_) const = 0;

	virtual void __stdcall attributes_by_tag_45EEE1450286 (
		const AttributeTag tag
		, QueryAttributeList_tie*& ret_
	) = 0;

	virtual void __stdcall clear_45EEE1450285 () = 0;

	virtual void __stdcall clone_45EEE1450288 (
		IQuery_tie*& ret_
	) = 0;


	virtual unsigned long __stdcall get_count () const = 0;


	virtual void __stdcall get_date (Date& ret_) const = 0;

	virtual void __stdcall execute_45FF9F9D01F5 (
		IDynList_tie* filtrate_list
		, SearchProgressIndicator::IProgressIndicatorForSearch_tie* progress
		, SearchProgressIndicator::ICancelSearch_tie*& cancel_process
	) = 0;

	virtual void __stdcall get_comment_4762B73103AB (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual void __stdcall get_context_attribute_45EEE145027F (
		const AttributeTag tag
		, IQueryContextAttribute_tie*& ret_
	) = 0;

	virtual void __stdcall get_date_attribute_45EEE1450283 (
		const AttributeTag tag
		, IQueryDateAttribute_tie*& ret_
	) = 0;

	virtual void __stdcall get_name_4762B6E401CD (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual void __stdcall get_node_attribute_45EEE1450281 (
		const AttributeTag tag
		, IQueryNodeAttribute_tie*& ret_
	) = 0;

	virtual void __stdcall get_phone_number_attribute_45EEE145028A (
		const AttributeTag tag
		, IQueryPhoneNumberAttribute_tie*& ret_
	) = 0;

	virtual bool __stdcall is_filter_query_4CB6EAED0168 () const = 0;

	virtual void __stdcall send_query_45EEE1450289 () = 0;

	virtual void __stdcall set_comment_4762B7150252 (
		GCI::IO::IString_tie* comment
	) = 0;

	virtual void __stdcall set_name_4762B6A10258 (
		GCI::IO::IString_tie* name
	) = 0;


	virtual QueryType __stdcall get_type () const = 0;
};

class __declspec (dllexport) Query_tie: public IQuery_tie {
	SET_OBJECT_COUNTER (Query_tie)
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
	Query_tie ();

	typedef ::Core::PoolObjectManager<Query_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Query_tie> Pool;
	friend class ::Core::PoolObjectManager<Query_tie>;
	typedef ::Core::IidMapRegistrator<Query_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IQuery_tie* obj, Query*& ret_, bool interface_addref = false);

	static void make_tie (const Query* obj, IQuery_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Query& obj, IQuery_tie*& ret_, const Core::TIEBase* owner);

	Query* m_impl;

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

	virtual void __stdcall get_attributes (QueryAttributeList_tie*& ret_) const;

	virtual void __stdcall attributes_by_tag_45EEE1450286 (
		const AttributeTag tag
		, QueryAttributeList_tie*& ret_
	);

	virtual void __stdcall clear_45EEE1450285 ();

	virtual void __stdcall clone_45EEE1450288 (
		IQuery_tie*& ret_
	);


	virtual unsigned long __stdcall get_count () const;


	virtual void __stdcall get_date (Date& ret_) const;

	virtual void __stdcall execute_45FF9F9D01F5 (
		IDynList_tie* filtrate_list
		, SearchProgressIndicator::IProgressIndicatorForSearch_tie* progress
		, SearchProgressIndicator::ICancelSearch_tie*& cancel_process
	);

	virtual void __stdcall get_comment_4762B73103AB (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual void __stdcall get_context_attribute_45EEE145027F (
		const AttributeTag tag
		, IQueryContextAttribute_tie*& ret_
	);

	virtual void __stdcall get_date_attribute_45EEE1450283 (
		const AttributeTag tag
		, IQueryDateAttribute_tie*& ret_
	);

	virtual void __stdcall get_name_4762B6E401CD (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual void __stdcall get_node_attribute_45EEE1450281 (
		const AttributeTag tag
		, IQueryNodeAttribute_tie*& ret_
	);

	virtual void __stdcall get_phone_number_attribute_45EEE145028A (
		const AttributeTag tag
		, IQueryPhoneNumberAttribute_tie*& ret_
	);

	virtual bool __stdcall is_filter_query_4CB6EAED0168 () const;

	virtual void __stdcall send_query_45EEE1450289 ();

	virtual void __stdcall set_comment_4762B7150252 (
		GCI::IO::IString_tie* comment
	);

	virtual void __stdcall set_name_4762B6A10258 (
		GCI::IO::IString_tie* name
	);


	virtual QueryType __stdcall get_type () const;
};

class QueryList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (QueryList_tie)
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
	QueryList_tie ();

	typedef ::Core::PoolObjectManager<QueryList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<QueryList_tie> Pool;
	friend class ::Core::PoolObjectManager<QueryList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const QueryList_tie* obj, QueryList*& ret_);

	static void make_tie (QueryList* obj, QueryList_tie*& ret_);
	
	static void make_tie (const QueryList& obj, QueryList_tie*& ret_);

	static void make_tie (const QueryList& obj, QueryList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (QueryList* obj, QueryList_tie*& ret_);

	QueryList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IQuery_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IQuery_tie* item);
	virtual size_t __stdcall add (const IQuery_tie* item);
	virtual size_t __stdcall insert (size_t index, const IQuery_tie* item);
};

class ISearch_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall correct_context_48284BC700D9 (
		const ContextWordList_tie* context_for_check
		, bool for_inpharm
		, ContextWordList_tie*& corrected_context
		, ContextWordList_tie*& ret_
	) const = 0;

	virtual void __stdcall create_query_45EEE0A40202 (
		QueryType type
		, IQuery_tie*& ret_
	) const = 0;

	virtual void __stdcall get_attribute_info_45EEE0A40204 (
		const AttributeTag tag
		, IAttributeInfo_tie*& ret_
	) const = 0;

	virtual void __stdcall get_documents_without_class_4746F7020272 (
		IDynList_tie*& ret_
	) const = 0;

	virtual void __stdcall get_documents_without_included_4746F7450002 (
		IDynList_tie*& ret_
	) const = 0;

	virtual void __stdcall get_documents_without_key_4746F76A0308 (
		IDynList_tie*& ret_
	) const = 0;

	virtual void __stdcall get_example_text_467790F3005D (
		unsigned long pos
		, GCI::IO::IString_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual unsigned long __stdcall get_example_text_count_467790D2006D () const = 0;


	virtual bool __stdcall get_is_morpho_exist () const = 0;
};

class __declspec (dllexport) Search_tie: public ISearch_tie {
	SET_OBJECT_COUNTER (Search_tie)
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
	Search_tie ();

	typedef ::Core::PoolObjectManager<Search_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Search_tie> Pool;
	friend class ::Core::PoolObjectManager<Search_tie>;
	typedef ::Core::IidMapRegistrator<Search_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISearch_tie* obj, Search*& ret_, bool interface_addref = false);

	static void make_tie (const Search* obj, ISearch_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Search& obj, ISearch_tie*& ret_, const Core::TIEBase* owner);

	Search* m_impl;

protected:
	virtual void __stdcall correct_context_48284BC700D9 (
		const ContextWordList_tie* context_for_check
		, bool for_inpharm
		, ContextWordList_tie*& corrected_context
		, ContextWordList_tie*& ret_
	) const;

	virtual void __stdcall create_query_45EEE0A40202 (
		QueryType type
		, IQuery_tie*& ret_
	) const;

	virtual void __stdcall get_attribute_info_45EEE0A40204 (
		const AttributeTag tag
		, IAttributeInfo_tie*& ret_
	) const;

	virtual void __stdcall get_documents_without_class_4746F7020272 (
		IDynList_tie*& ret_
	) const;

	virtual void __stdcall get_documents_without_included_4746F7450002 (
		IDynList_tie*& ret_
	) const;

	virtual void __stdcall get_documents_without_key_4746F76A0308 (
		IDynList_tie*& ret_
	) const;

	virtual void __stdcall get_example_text_467790F3005D (
		unsigned long pos
		, GCI::IO::IString_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual unsigned long __stdcall get_example_text_count_467790D2006D () const;


	virtual bool __stdcall get_is_morpho_exist () const;
};

class IFullAttributeInfo_tie: public IAttributeInfo_tie {
public:

	virtual void __stdcall get_tag (GCI::IO::IString_tie*& ret_) = 0;
};

class __declspec (dllexport) FullAttributeInfo_tie: public IFullAttributeInfo_tie {
	SET_OBJECT_COUNTER (FullAttributeInfo_tie)
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
	FullAttributeInfo_tie ();

	typedef ::Core::PoolObjectManager<FullAttributeInfo_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FullAttributeInfo_tie> Pool;
	friend class ::Core::PoolObjectManager<FullAttributeInfo_tie>;
	typedef ::Core::IidMapRegistrator<FullAttributeInfo_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFullAttributeInfo_tie* obj, FullAttributeInfo*& ret_, bool interface_addref = false);

	static void make_tie (const FullAttributeInfo* obj, IFullAttributeInfo_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const FullAttributeInfo& obj, IFullAttributeInfo_tie*& ret_, const Core::TIEBase* owner);

	FullAttributeInfo* m_impl;

protected:

	virtual bool __stdcall get_is_exist () const;


	virtual void __stdcall get_available_operations (OperationList_tie*& ret_) const;

	virtual void __stdcall get_default_value_45F115DD01E2 (
		IQueryAttribute_tie*& ret_
	) const;

	virtual void __stdcall get_tag (GCI::IO::IString_tie*& ret_);
};

class AttributeList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (AttributeList_tie)
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
	AttributeList_tie ();

	typedef ::Core::PoolObjectManager<AttributeList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<AttributeList_tie> Pool;
	friend class ::Core::PoolObjectManager<AttributeList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const AttributeList_tie* obj, AttributeList*& ret_);

	static void make_tie (AttributeList* obj, AttributeList_tie*& ret_);
	
	static void make_tie (const AttributeList& obj, AttributeList_tie*& ret_);

	static void make_tie (const AttributeList& obj, AttributeList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (AttributeList* obj, AttributeList_tie*& ret_);

	AttributeList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IFullAttributeInfo_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IFullAttributeInfo_tie* item);
	virtual size_t __stdcall add (const IFullAttributeInfo_tie* item);
	virtual size_t __stdcall insert (size_t index, const IFullAttributeInfo_tie* item);
};

class IQueryCardInfo_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_evd_card (GCI::IO::IStream_tie*& ret_) /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_exist_attrs_4CC973C702EE (
		AttributeList_tie*& ret_
	) const = 0;
};

class __declspec (dllexport) QueryCardInfo_tie: public IQueryCardInfo_tie {
	SET_OBJECT_COUNTER (QueryCardInfo_tie)
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
	QueryCardInfo_tie ();

	typedef ::Core::PoolObjectManager<QueryCardInfo_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<QueryCardInfo_tie> Pool;
	friend class ::Core::PoolObjectManager<QueryCardInfo_tie>;
	typedef ::Core::IidMapRegistrator<QueryCardInfo_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IQueryCardInfo_tie* obj, QueryCardInfo*& ret_, bool interface_addref = false);

	static void make_tie (const QueryCardInfo* obj, IQueryCardInfo_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const QueryCardInfo& obj, IQueryCardInfo_tie*& ret_, const Core::TIEBase* owner);

	QueryCardInfo* m_impl;

protected:

	virtual void __stdcall get_evd_card (GCI::IO::IStream_tie*& ret_) /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_exist_attrs_4CC973C702EE (
		AttributeList_tie*& ret_
	) const;
};

class IAttributesHelper_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall attribute_KW_exists_4CEA4D0702FD () const = 0;

	virtual bool __stdcall attribute_publish_source_exists_4CEA4D5D002C () const = 0;
};

class __declspec (dllexport) AttributesHelper_tie: public IAttributesHelper_tie {
	SET_OBJECT_COUNTER (AttributesHelper_tie)
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
	AttributesHelper_tie ();

	typedef ::Core::PoolObjectManager<AttributesHelper_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<AttributesHelper_tie> Pool;
	friend class ::Core::PoolObjectManager<AttributesHelper_tie>;
	typedef ::Core::IidMapRegistrator<AttributesHelper_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IAttributesHelper_tie* obj, AttributesHelper*& ret_, bool interface_addref = false);

	static void make_tie (const AttributesHelper* obj, IAttributesHelper_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const AttributesHelper& obj, IAttributesHelper_tie*& ret_, const Core::TIEBase* owner);

	AttributesHelper* m_impl;

protected:
	virtual bool __stdcall attribute_KW_exists_4CEA4D0702FD () const;

	virtual bool __stdcall attribute_publish_source_exists_4CEA4D5D002C () const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

