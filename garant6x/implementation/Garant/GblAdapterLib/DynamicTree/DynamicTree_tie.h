////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"

namespace GblAdapterLib {

class IFilterForTree_tie: public ::Core::IIObject_tie {
public:

};

class __declspec (dllexport) FilterForTree_tie: public IFilterForTree_tie {
	SET_OBJECT_COUNTER (FilterForTree_tie)
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
	FilterForTree_tie ();

	typedef ::Core::PoolObjectManager<FilterForTree_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FilterForTree_tie> Pool;
	friend class ::Core::PoolObjectManager<FilterForTree_tie>;
	typedef ::Core::IidMapRegistrator<FilterForTree_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFilterForTree_tie* obj, FilterForTree*& ret_, bool interface_addref = false);

	static void make_tie (const FilterForTree* obj, IFilterForTree_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const FilterForTree& obj, IFilterForTree_tie*& ret_, const Core::TIEBase* owner);

	FilterForTree* m_impl;

protected:

};

class FilterList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (FilterList_tie)
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
	FilterList_tie ();

	typedef ::Core::PoolObjectManager<FilterList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FilterList_tie> Pool;
	friend class ::Core::PoolObjectManager<FilterList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const FilterList_tie* obj, FilterList*& ret_);

	static void make_tie (FilterList* obj, FilterList_tie*& ret_);
	
	static void make_tie (const FilterList& obj, FilterList_tie*& ret_);

	static void make_tie (const FilterList& obj, FilterList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (FilterList* obj, FilterList_tie*& ret_);

	FilterList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IFilterForTree_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IFilterForTree_tie* item);
	virtual size_t __stdcall add (const IFilterForTree_tie* item);
	virtual size_t __stdcall insert (size_t index, const IFilterForTree_tie* item);
};

class NodeIndexPath_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (NodeIndexPath_tie)
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
	NodeIndexPath_tie ();

	typedef ::Core::PoolObjectManager<NodeIndexPath_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NodeIndexPath_tie> Pool;
	friend class ::Core::PoolObjectManager<NodeIndexPath_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const NodeIndexPath_tie* obj, NodeIndexPath*& ret_);

	static void make_tie (NodeIndexPath* obj, NodeIndexPath_tie*& ret_);
	
	static void make_tie (const NodeIndexPath& obj, NodeIndexPath_tie*& ret_);

	static void make_tie (const NodeIndexPath& obj, NodeIndexPath_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (NodeIndexPath* obj, NodeIndexPath_tie*& ret_);

	NodeIndexPath* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual IndexInParent __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, IndexInParent item);
	virtual size_t __stdcall add (IndexInParent item);
	virtual size_t __stdcall insert (size_t index, IndexInParent item);
};

#pragma pack (push, 1)

struct FindPosition_tie {
	NodeIndexPath_tie* node;
	long begin;
	long end;
	
	static void make_cpp (const FindPosition_tie& obj, FindPosition& ret_);

	static void make_tie (const FindPosition& obj, FindPosition_tie& ret_);
};

#pragma pack (pop)

class FindPositionList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (FindPositionList_tie)
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
	FindPositionList_tie ();

	typedef ::Core::PoolObjectManager<FindPositionList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FindPositionList_tie> Pool;
	friend class ::Core::PoolObjectManager<FindPositionList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const FindPositionList_tie* obj, FindPositionList*& ret_);

	static void make_tie (FindPositionList* obj, FindPositionList_tie*& ret_);
	
	static void make_tie (const FindPositionList& obj, FindPositionList_tie*& ret_);

	static void make_tie (const FindPositionList& obj, FindPositionList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (FindPositionList* obj, FindPositionList_tie*& ret_);

	FindPositionList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, FindPosition_tie& ret_);
	virtual void __stdcall set_item (size_t index, const FindPosition_tie& item);
	virtual size_t __stdcall add (const FindPosition_tie& item);
	virtual size_t __stdcall insert (size_t index, const FindPosition_tie& item);
};

class LayerIdList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (LayerIdList_tie)
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
	LayerIdList_tie ();

	typedef ::Core::PoolObjectManager<LayerIdList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<LayerIdList_tie> Pool;
	friend class ::Core::PoolObjectManager<LayerIdList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const LayerIdList_tie* obj, LayerIdList*& ret_);

	static void make_tie (LayerIdList* obj, LayerIdList_tie*& ret_);
	
	static void make_tie (const LayerIdList& obj, LayerIdList_tie*& ret_);

	static void make_tie (const LayerIdList& obj, LayerIdList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (LayerIdList* obj, LayerIdList_tie*& ret_);

	LayerIdList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual LayerId __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, LayerId item);
	virtual size_t __stdcall add (LayerId item);
	virtual size_t __stdcall insert (size_t index, LayerId item);
};

class ISortFilter_tie: public IFilterForTree_tie {
public:

	virtual SortOrder __stdcall get_order () const = 0;
	virtual void __stdcall set_order (SortOrder order) = 0;


	virtual void __stdcall get_sub_filter (ISortFilter_tie*& ret_) = 0;
	virtual void __stdcall set_sub_filter (ISortFilter_tie* sub_filter) = 0;


	virtual SortType __stdcall get_type () const = 0;
	virtual void __stdcall set_type (SortType type) = 0;
};

class __declspec (dllexport) SortFilter_tie: public ISortFilter_tie {
	SET_OBJECT_COUNTER (SortFilter_tie)
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
	SortFilter_tie ();

	typedef ::Core::PoolObjectManager<SortFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SortFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<SortFilter_tie>;
	typedef ::Core::IidMapRegistrator<SortFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISortFilter_tie* obj, SortFilter*& ret_, bool interface_addref = false);

	static void make_tie (const SortFilter* obj, ISortFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const SortFilter& obj, ISortFilter_tie*& ret_, const Core::TIEBase* owner);

	SortFilter* m_impl;

protected:

	virtual SortOrder __stdcall get_order () const;
	virtual void __stdcall set_order (SortOrder order);


	virtual void __stdcall get_sub_filter (ISortFilter_tie*& ret_);
	virtual void __stdcall set_sub_filter (ISortFilter_tie* sub_filter);


	virtual SortType __stdcall get_type () const;
	virtual void __stdcall set_type (SortType type);
};

class ITrimFilter_tie: public IFilterForTree_tie {
public:

	virtual bool __stdcall get_is_trimmed () const = 0;
	virtual void __stdcall set_is_trimmed (bool is_trimmed) = 0;
};

class __declspec (dllexport) TrimFilter_tie: public ITrimFilter_tie {
	SET_OBJECT_COUNTER (TrimFilter_tie)
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
	TrimFilter_tie ();

	typedef ::Core::PoolObjectManager<TrimFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<TrimFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<TrimFilter_tie>;
	typedef ::Core::IidMapRegistrator<TrimFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ITrimFilter_tie* obj, TrimFilter*& ret_, bool interface_addref = false);

	static void make_tie (const TrimFilter* obj, ITrimFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const TrimFilter& obj, ITrimFilter_tie*& ret_, const Core::TIEBase* owner);

	TrimFilter* m_impl;

protected:

	virtual bool __stdcall get_is_trimmed () const;
	virtual void __stdcall set_is_trimmed (bool is_trimmed);
};

class ILayerFilter_tie: public IFilterForTree_tie {
public:

	virtual LayerId __stdcall get_layer () const = 0;
	virtual void __stdcall set_layer (LayerId layer) = 0;
};

class __declspec (dllexport) LayerFilter_tie: public ILayerFilter_tie {
	SET_OBJECT_COUNTER (LayerFilter_tie)
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
	LayerFilter_tie ();

	typedef ::Core::PoolObjectManager<LayerFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<LayerFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<LayerFilter_tie>;
	typedef ::Core::IidMapRegistrator<LayerFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ILayerFilter_tie* obj, LayerFilter*& ret_, bool interface_addref = false);

	static void make_tie (const LayerFilter* obj, ILayerFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const LayerFilter& obj, ILayerFilter_tie*& ret_, const Core::TIEBase* owner);

	LayerFilter* m_impl;

protected:

	virtual LayerId __stdcall get_layer () const;
	virtual void __stdcall set_layer (LayerId layer);
};

class IFindIterator_tie: public ::Core::IIObject_tie {
public:

	virtual const unsigned long __stdcall get_count () const = 0;

	virtual void __stdcall get_position_461D00B9005D (
		FindPositionList_tie*& ret_
	) const = 0;

	virtual bool __stdcall is_first_49FEC51501D8 () const = 0;

	virtual bool __stdcall is_good_45EEC28202A2 () const = 0;

	virtual void __stdcall next_45EEC28202A0 () = 0;

	virtual void __stdcall prev_45EEC28202A1 () = 0;
};

class __declspec (dllexport) FindIterator_tie: public IFindIterator_tie {
	SET_OBJECT_COUNTER (FindIterator_tie)
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
	FindIterator_tie ();

	typedef ::Core::PoolObjectManager<FindIterator_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FindIterator_tie> Pool;
	friend class ::Core::PoolObjectManager<FindIterator_tie>;
	typedef ::Core::IidMapRegistrator<FindIterator_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFindIterator_tie* obj, FindIterator*& ret_, bool interface_addref = false);

	static void make_tie (const FindIterator* obj, IFindIterator_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const FindIterator& obj, IFindIterator_tie*& ret_, const Core::TIEBase* owner);

	FindIterator* m_impl;

protected:

	virtual const unsigned long __stdcall get_count () const;

	virtual void __stdcall get_position_461D00B9005D (
		FindPositionList_tie*& ret_
	) const;

	virtual bool __stdcall is_first_49FEC51501D8 () const;

	virtual bool __stdcall is_good_45EEC28202A2 () const;

	virtual void __stdcall next_45EEC28202A0 ();

	virtual void __stdcall prev_45EEC28202A1 ();
};

class ISettingEntity_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall load_from_setting_45EECD5D02F1 (
		const PropertyID id
		, ISettingEntity_tie*& ret_
	) const = 0;

	virtual void __stdcall save_in_setting_45EECD5D02EF (
		const PropertyID id
	) const = 0;
};

class __declspec (dllexport) SettingEntity_tie: public ISettingEntity_tie {
	SET_OBJECT_COUNTER (SettingEntity_tie)
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
	SettingEntity_tie ();

	typedef ::Core::PoolObjectManager<SettingEntity_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SettingEntity_tie> Pool;
	friend class ::Core::PoolObjectManager<SettingEntity_tie>;
	typedef ::Core::IidMapRegistrator<SettingEntity_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISettingEntity_tie* obj, SettingEntity*& ret_, bool interface_addref = false);

	static void make_tie (const SettingEntity* obj, ISettingEntity_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const SettingEntity& obj, ISettingEntity_tie*& ret_, const Core::TIEBase* owner);

	SettingEntity* m_impl;

protected:
	virtual void __stdcall load_from_setting_45EECD5D02F1 (
		const PropertyID id
		, ISettingEntity_tie*& ret_
	) const;

	virtual void __stdcall save_in_setting_45EECD5D02EF (
		const PropertyID id
	) const;
};

class INodesClipboard_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall as_evd_45EECAA0007E (
		EVDGeneratorStyle style
		, GCI::IO::IStream_tie*& ret_
	) const = 0;


	virtual unsigned long __stdcall get_count () const = 0;
};

class __declspec (dllexport) NodesClipboard_tie: public INodesClipboard_tie {
	SET_OBJECT_COUNTER (NodesClipboard_tie)
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
	NodesClipboard_tie ();

	typedef ::Core::PoolObjectManager<NodesClipboard_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NodesClipboard_tie> Pool;
	friend class ::Core::PoolObjectManager<NodesClipboard_tie>;
	typedef ::Core::IidMapRegistrator<NodesClipboard_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const INodesClipboard_tie* obj, NodesClipboard*& ret_, bool interface_addref = false);

	static void make_tie (const NodesClipboard* obj, INodesClipboard_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const NodesClipboard& obj, INodesClipboard_tie*& ret_, const Core::TIEBase* owner);

	NodesClipboard* m_impl;

protected:
	virtual void __stdcall as_evd_45EECAA0007E (
		EVDGeneratorStyle style
		, GCI::IO::IStream_tie*& ret_
	) const;


	virtual unsigned long __stdcall get_count () const;
};

class IFakeFacetForFactory_tie: public ::Core::IIObject_tie {
public:

};

class __declspec (dllexport) FakeFacetForFactory_tie: public IFakeFacetForFactory_tie {
	SET_OBJECT_COUNTER (FakeFacetForFactory_tie)
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
	FakeFacetForFactory_tie ();

	typedef ::Core::PoolObjectManager<FakeFacetForFactory_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<FakeFacetForFactory_tie> Pool;
	friend class ::Core::PoolObjectManager<FakeFacetForFactory_tie>;
	typedef ::Core::IidMapRegistrator<FakeFacetForFactory_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IFakeFacetForFactory_tie* obj, FakeFacetForFactory*& ret_, bool interface_addref = false);

	static void make_tie (const FakeFacetForFactory* obj, IFakeFacetForFactory_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const FakeFacetForFactory& obj, IFakeFacetForFactory_tie*& ret_, const Core::TIEBase* owner);

	FakeFacetForFactory* m_impl;

protected:

};


class INodeNotifier_tie;

// callback only cpp-wraper
class NodeNotifier_callback_tie : virtual public NodeNotifier, virtual public ::Core::IObject {
	SET_OBJECT_COUNTER (NodeNotifier_callback_tie)
	friend class INodeNotifier_tie;
protected:
	virtual unsigned long addref () const;

	virtual unsigned long ref_count () const;

public:
	virtual unsigned long release () const;
	// нотификация об изменении кол-ва видимых детей на ноде с указвнным индексом. В случае если
	// изменение нод внутри рута не последовательное и не от начала, индекс должен быть задан как -1.
	// parent_path - путь к УЗЛУ в котором произашли изменения (если delta < 0 - удаление, если delta
	// > 0 - вставка)
	// left_child_index - индекс ребенка в узле: если удаление, то начиная с которого
	// (включительно) мы удаляем delta элементорв; если вставка, то сразу после которого вы вставляем
	// delta элементов.
	// left_child_index, может принять "специальное" значение IIP_BEFORE_LEFT_CHILD (-1) -
	// означающее элемент "до первого" - например для вставки в начало детей.
	virtual void change_children_count (
		VisibleIndex node_index
		, long delta
		, const NodeIndexPath& index_path
		, IndexInParent child_index
	) const;

	// Конец итерации изменения дерева
	virtual void changed () const;

	// Начало итерации изменения дерева
	virtual void changing () const;

	// Возвращает уникальный идентификатор объекта
	virtual NotifierID get_id () const;

	// нотификация о необходимости перерисовки. Должна вызываться после change_children_count (которые
	// можно группирвать) или самостоятельно при изменении дерева не связанном с кол-вом детей.
	// parent_path - путь к НОДЕ в которой произашли изменения
	virtual void invalidate (const NodeIndexPath& index_path) const;

	// признак аутлайнера что он одноуровневый
	virtual bool is_one_level () const;

	// признак аутлайнера что он с видимым рутом
	virtual bool is_root_visible () const;

	// устанавливает кол-во детей = 0
	virtual void reset_children_count () const;

	NodeNotifier_callback_tie ();

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;
// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

protected:
	typedef ::Core::PoolObjectManager<NodeNotifier_callback_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NodeNotifier_callback_tie> Pool;
	friend class ::Core::PoolObjectManager<NodeNotifier_callback_tie>;
	
public:
	mutable INodeNotifier_tie* m_impl;
};

// callback only abstarct interface
class INodeNotifier_tie {
public:
	virtual unsigned long __stdcall query_interface (const ::Core::ComIID& iid, void*& object) = 0;	
	virtual unsigned long __stdcall addref () const = 0;
	virtual unsigned long __stdcall release () const = 0;

	virtual void __stdcall change_children_count_45EEC8E102FE (
		VisibleIndex node_index
		, long delta
		, const NodeIndexPath_tie* index_path
		, IndexInParent child_index
	) const = 0;

	virtual void __stdcall changed_45EEC8E10309 () const = 0;

	virtual void __stdcall changing_45EEC8E10308 () const = 0;

	virtual NotifierID __stdcall get_id_475E4B020072 () const = 0;

	virtual void __stdcall invalidate_45EEC8E10306 (
		const NodeIndexPath_tie* index_path
	) const = 0;

	virtual bool __stdcall is_one_level_45EEC8E10305 () const = 0;

	virtual bool __stdcall is_root_visible_45EEC8E10304 () const = 0;

	virtual void __stdcall reset_children_count_45EEC8E10303 () const = 0;

	static void make_cpp (const INodeNotifier_tie* obj, NodeNotifier*& ret_, bool interface_addref = false);

	static void make_tie (INodeNotifier_tie* obj, NodeNotifier_callback_tie*& ret_);
};



class IListForFiltering_tie;

// callback only cpp-wraper
class ListForFiltering_callback_tie : virtual public ListForFiltering, virtual public ::Core::IObject {
	SET_OBJECT_COUNTER (ListForFiltering_callback_tie)
	friend class IListForFiltering_tie;
protected:
	virtual unsigned long addref () const;

	virtual unsigned long ref_count () const;

public:
	virtual unsigned long release () const;
	virtual const unsigned long get_count () const;

	virtual GCI::IO::String* item (unsigned long index) const;

	ListForFiltering_callback_tie ();

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;
// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

protected:
	typedef ::Core::PoolObjectManager<ListForFiltering_callback_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ListForFiltering_callback_tie> Pool;
	friend class ::Core::PoolObjectManager<ListForFiltering_callback_tie>;
	
public:
	mutable IListForFiltering_tie* m_impl;
};

// callback only abstarct interface
class IListForFiltering_tie {
public:
	virtual unsigned long __stdcall query_interface (const ::Core::ComIID& iid, void*& object) = 0;	
	virtual unsigned long __stdcall addref () const = 0;
	virtual unsigned long __stdcall release () const = 0;


	virtual const unsigned long __stdcall get_count () const = 0;

	virtual void __stdcall item_4D3D26DC0123 (
		unsigned long index
		, GCI::IO::IString_tie*& ret_
	) const = 0;

	static void make_cpp (const IListForFiltering_tie* obj, ListForFiltering*& ret_, bool interface_addref = false);

	static void make_tie (IListForFiltering_tie* obj, ListForFiltering_callback_tie*& ret_);
};


class INodeIterator_tie;
class NodeIterator_tie;

struct NodePosition_tie;

class INodeBase_tie: public ISettingEntity_tie {
public:
	virtual void __stdcall add_last_child_45EEB9590211 (
		INodeBase_tie* node
	) /*throw (ConstantModify_tie)*/ = 0;

	virtual void __stdcall add_last_childs_45EEB959020F (
		INodesClipboard_tie* nodes
	) = 0;

	virtual void __stdcall add_notifier_45EEB95901C7 (
		INodeNotifier_tie* notifier
	) = 0;

	virtual void __stdcall add_prev_sibling_45EEB9590215 (
		INodeBase_tie* node
	) /*throw (ConstantModify_tie)*/ = 0;

	virtual void __stdcall add_prev_siblings_45EEB9590213 (
		INodesClipboard_tie* nodes
	) /*throw (ConstantModify_tie)*/ = 0;


	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_) = 0;


	virtual long __stdcall get_child_count () const = 0;

	virtual void __stdcall commit_change_transaction_45EEB9590219 () = 0;

	virtual void __stdcall copy_nodes_45EEB959020C (
		FlagMask mask
		, INodesClipboard_tie*& ret_
	) = 0;

	virtual void __stdcall create_view_ex_45EEB95901C9 (
		const FilterList_tie* filter
		, FlagMask shared_flags
		, const INodeBase_tie* sync_node
		, VisibleIndex& sync_index
		, unsigned long levels
		, bool unfiltered
		, bool auto_open
		, bool truncate_this_view
		, INodeBase_tie*& ret_
	) = 0;

	virtual void __stdcall delete_node_45EEB959020B () = 0;

	virtual void __stdcall delete_nodes_45EEB9590209 (
		FlagMask mask
	) /*throw (ConstantModify_tie)*/ = 0;


	virtual void __stdcall get_entity (IEntityBase_tie*& ret_) /*throw (NoEntity_tie)*/ = 0;
	virtual void __stdcall set_entity (IEntityBase_tie* entity) = 0;

	virtual void __stdcall expand_all_45EEB9590220 (
		bool expand
	) = 0;

	virtual void __stdcall find_45EEB959021C (
		const FilterList_tie* filter
		, const NodePosition_tie& find_from
		, IFindIterator_tie*& ret_
	) const = 0;

	virtual void __stdcall find_node_45EEB95901D2 (
		const INodeBase_tie* node_to_find
		, INodeBase_tie*& ret_
	) const = 0;

	virtual void __stdcall find_node_path_45EEB95901D4 (
		INodeBase_tie* node_to_find
		, NodeIndexPath_tie*& ret_
	) const = 0;


	virtual void __stdcall get_first_child (INodeBase_tie*& ret_) = 0;

	virtual VisibleIndex __stdcall get_abs_index_45EEB95901E6 () const /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_available_layers_46236D06007D (
		LayerIdList_tie*& ret_
	) const = 0;

	virtual void __stdcall get_by_sibbling_index_45EEB95901D6 (
		VisibleIndex ind
		, INodeBase_tie*& ret_
	) = 0;

	virtual void __stdcall get_by_visible_index_45EEB95901D8 (
		VisibleIndex ind
		, INodeBase_tie*& ret_
	) = 0;

	virtual void __stdcall get_child_path_by_abs_index_45EEB95901E7 (
		VisibleIndex index
		, NodeIndexPath_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual void __stdcall get_first_fit_45EEB95901DA (
		const FilterList_tie* filter
		, NodeIndexPath_tie*& ret_
	) const = 0;

	virtual unsigned long __stdcall get_first_level_children_flag_count_4677A5180213 (
		FlagMask flag
	) const = 0;

	virtual unsigned long __stdcall get_flag_count_45EEB95901DC (
		FlagMask flag
	) const = 0;

	virtual void __stdcall get_frozen_node_4624DEED008C (
		INodeBase_tie*& ret_
	) const = 0;

	virtual VisibleIndex __stdcall get_index_from_parent_45EEB95901E5 () const = 0;

	virtual void __stdcall get_node_by_path_45EEB959021A (
		const NodeIndexPath_tie* path
		, INodeBase_tie*& ret_
	) const /*throw (NotFound_tie)*/ = 0;

	virtual NodeId __stdcall get_node_id_45EEB95901DE () const = 0;

	virtual void __stdcall get_unfiltered_node_4625D15D0138 (
		INodeBase_tie*& ret_
	) const = 0;

	virtual VisibleIndex __stdcall get_visible_delta_45EEB95901E1 (
		const INodeBase_tie* node
	) const /*throw (NotFound_tie)*/ = 0;

	virtual VisibleIndex __stdcall get_visible_delta_by_entity_45EEB95901E3 (
		const IEntityBase_tie* entity
	) const /*throw (NotFound_tie)*/ = 0;

	virtual bool __stdcall has_children_45EEB95901EA () const = 0;

	virtual bool __stdcall has_children_flag_45EEB95901EB (
		FlagMask flag
	) const = 0;

	virtual bool __stdcall has_filtered_children_45EEB95901ED () const = 0;

	virtual bool __stdcall has_flag_45EEB95901EE (
		FlagMask flag
	) const = 0;

	virtual bool __stdcall has_parent_flag_45EEB95901F0 (
		FlagMask flag
	) const = 0;


	virtual bool __stdcall get_is_expanded () const = 0;

	virtual bool __stdcall is_first_45EEB95901F2 () const = 0;

	virtual bool __stdcall is_it_higher_45EEB95901F3 (
		INodeBase_tie* it
	) const = 0;

	virtual bool __stdcall is_last_45EEB95901F5 () const = 0;

	virtual bool __stdcall is_relevance_search_supported_45EEB959021F () const = 0;

	virtual bool __stdcall is_same_node_45EEB95901F6 (
		INodeBase_tie* node
	) const = 0;

	virtual void __stdcall iterate_all_nodes_473D89660266 (
		FlagMask with_flag
		, INodeIterator_tie*& ret_
	) = 0;

	virtual void __stdcall iterate_nodes_45EEB95901F8 (
		FlagMask with_flag
		, INodeIterator_tie*& ret_
	) = 0;


	virtual long __stdcall get_level () const = 0;

	virtual void __stdcall make_visible_45EEB95901FA () = 0;


	virtual void __stdcall get_next (INodeBase_tie*& ret_) = 0;


	virtual void __stdcall get_parent (INodeBase_tie*& ret_) = 0;


	virtual void __stdcall get_prev (INodeBase_tie*& ret_) = 0;

	virtual void __stdcall remove_notifier_45EEB95901FB (
		INodeNotifier_tie* notifier
	) = 0;

	virtual void __stdcall rollback_change_transaction_45EEB9590218 () = 0;

	virtual void __stdcall set_all_flag_45EEB95901FD (
		FlagMask flag
		, bool value
	) = 0;

	virtual void __stdcall set_all_flag_except_first_children_of_root_children_51EFC4100162 (
		FlagMask flag
		, bool value
	) = 0;

	virtual void __stdcall set_flag_45EEB9590200 (
		FlagMask flag
		, bool value
	) = 0;

	virtual void __stdcall set_node_id_45EEB95901DF (
		NodeId id
	) = 0;

	virtual void __stdcall set_range_flag_45EEB9590203 (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	) = 0;

	virtual void __stdcall set_range_flag_except_first_children_of_root_children_51EFD26E03DF (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	) = 0;

	virtual void __stdcall start_change_transaction_45EEB9590217 () = 0;


	virtual NodeType __stdcall get_type () const = 0;
	virtual void __stdcall set_type (NodeType type) /*throw (ConstantModify_tie)*/ = 0;
};

class __declspec (dllexport) NodeBase_tie: public INodeBase_tie {
	SET_OBJECT_COUNTER (NodeBase_tie)
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
	NodeBase_tie ();

	typedef ::Core::PoolObjectManager<NodeBase_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NodeBase_tie> Pool;
	friend class ::Core::PoolObjectManager<NodeBase_tie>;
	typedef ::Core::IidMapRegistrator<NodeBase_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const INodeBase_tie* obj, NodeBase*& ret_, bool interface_addref = false);

	static void make_tie (const NodeBase* obj, INodeBase_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const NodeBase& obj, INodeBase_tie*& ret_, const Core::TIEBase* owner);

	NodeBase* m_impl;

protected:
	virtual void __stdcall save_in_setting_45EECD5D02EF (
		const PropertyID id
	) const;

	virtual void __stdcall load_from_setting_45EECD5D02F1 (
		const PropertyID id
		, ISettingEntity_tie*& ret_
	) const;
	virtual void __stdcall add_last_child_45EEB9590211 (
		INodeBase_tie* node
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall add_last_childs_45EEB959020F (
		INodesClipboard_tie* nodes
	);

	virtual void __stdcall add_notifier_45EEB95901C7 (
		INodeNotifier_tie* notifier
	);

	virtual void __stdcall add_prev_sibling_45EEB9590215 (
		INodeBase_tie* node
	) /*throw (ConstantModify_tie)*/;

	virtual void __stdcall add_prev_siblings_45EEB9590213 (
		INodesClipboard_tie* nodes
	) /*throw (ConstantModify_tie)*/;


	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_);


	virtual long __stdcall get_child_count () const;

	virtual void __stdcall commit_change_transaction_45EEB9590219 ();

	virtual void __stdcall copy_nodes_45EEB959020C (
		FlagMask mask
		, INodesClipboard_tie*& ret_
	);

	virtual void __stdcall create_view_ex_45EEB95901C9 (
		const FilterList_tie* filter
		, FlagMask shared_flags
		, const INodeBase_tie* sync_node
		, VisibleIndex& sync_index
		, unsigned long levels
		, bool unfiltered
		, bool auto_open
		, bool truncate_this_view
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall delete_node_45EEB959020B ();

	virtual void __stdcall delete_nodes_45EEB9590209 (
		FlagMask mask
	) /*throw (ConstantModify_tie)*/;


	virtual void __stdcall get_entity (IEntityBase_tie*& ret_) /*throw (NoEntity_tie)*/;
	virtual void __stdcall set_entity (IEntityBase_tie* entity);

	virtual void __stdcall expand_all_45EEB9590220 (
		bool expand
	);

	virtual void __stdcall find_45EEB959021C (
		const FilterList_tie* filter
		, const NodePosition_tie& find_from
		, IFindIterator_tie*& ret_
	) const;

	virtual void __stdcall find_node_45EEB95901D2 (
		const INodeBase_tie* node_to_find
		, INodeBase_tie*& ret_
	) const;

	virtual void __stdcall find_node_path_45EEB95901D4 (
		INodeBase_tie* node_to_find
		, NodeIndexPath_tie*& ret_
	) const;


	virtual void __stdcall get_first_child (INodeBase_tie*& ret_);

	virtual VisibleIndex __stdcall get_abs_index_45EEB95901E6 () const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_available_layers_46236D06007D (
		LayerIdList_tie*& ret_
	) const;

	virtual void __stdcall get_by_sibbling_index_45EEB95901D6 (
		VisibleIndex ind
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall get_by_visible_index_45EEB95901D8 (
		VisibleIndex ind
		, INodeBase_tie*& ret_
	);

	virtual void __stdcall get_child_path_by_abs_index_45EEB95901E7 (
		VisibleIndex index
		, NodeIndexPath_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual void __stdcall get_first_fit_45EEB95901DA (
		const FilterList_tie* filter
		, NodeIndexPath_tie*& ret_
	) const;

	virtual unsigned long __stdcall get_first_level_children_flag_count_4677A5180213 (
		FlagMask flag
	) const;

	virtual unsigned long __stdcall get_flag_count_45EEB95901DC (
		FlagMask flag
	) const;

	virtual void __stdcall get_frozen_node_4624DEED008C (
		INodeBase_tie*& ret_
	) const;

	virtual VisibleIndex __stdcall get_index_from_parent_45EEB95901E5 () const;

	virtual void __stdcall get_node_by_path_45EEB959021A (
		const NodeIndexPath_tie* path
		, INodeBase_tie*& ret_
	) const /*throw (NotFound_tie)*/;

	virtual NodeId __stdcall get_node_id_45EEB95901DE () const;

	virtual void __stdcall get_unfiltered_node_4625D15D0138 (
		INodeBase_tie*& ret_
	) const;

	virtual VisibleIndex __stdcall get_visible_delta_45EEB95901E1 (
		const INodeBase_tie* node
	) const /*throw (NotFound_tie)*/;

	virtual VisibleIndex __stdcall get_visible_delta_by_entity_45EEB95901E3 (
		const IEntityBase_tie* entity
	) const /*throw (NotFound_tie)*/;

	virtual bool __stdcall has_children_45EEB95901EA () const;

	virtual bool __stdcall has_children_flag_45EEB95901EB (
		FlagMask flag
	) const;

	virtual bool __stdcall has_filtered_children_45EEB95901ED () const;

	virtual bool __stdcall has_flag_45EEB95901EE (
		FlagMask flag
	) const;

	virtual bool __stdcall has_parent_flag_45EEB95901F0 (
		FlagMask flag
	) const;


	virtual bool __stdcall get_is_expanded () const;

	virtual bool __stdcall is_first_45EEB95901F2 () const;

	virtual bool __stdcall is_it_higher_45EEB95901F3 (
		INodeBase_tie* it
	) const;

	virtual bool __stdcall is_last_45EEB95901F5 () const;

	virtual bool __stdcall is_relevance_search_supported_45EEB959021F () const;

	virtual bool __stdcall is_same_node_45EEB95901F6 (
		INodeBase_tie* node
	) const;

	virtual void __stdcall iterate_all_nodes_473D89660266 (
		FlagMask with_flag
		, INodeIterator_tie*& ret_
	);

	virtual void __stdcall iterate_nodes_45EEB95901F8 (
		FlagMask with_flag
		, INodeIterator_tie*& ret_
	);


	virtual long __stdcall get_level () const;

	virtual void __stdcall make_visible_45EEB95901FA ();


	virtual void __stdcall get_next (INodeBase_tie*& ret_);


	virtual void __stdcall get_parent (INodeBase_tie*& ret_);


	virtual void __stdcall get_prev (INodeBase_tie*& ret_);

	virtual void __stdcall remove_notifier_45EEB95901FB (
		INodeNotifier_tie* notifier
	);

	virtual void __stdcall rollback_change_transaction_45EEB9590218 ();

	virtual void __stdcall set_all_flag_45EEB95901FD (
		FlagMask flag
		, bool value
	);

	virtual void __stdcall set_all_flag_except_first_children_of_root_children_51EFC4100162 (
		FlagMask flag
		, bool value
	);

	virtual void __stdcall set_flag_45EEB9590200 (
		FlagMask flag
		, bool value
	);

	virtual void __stdcall set_node_id_45EEB95901DF (
		NodeId id
	);

	virtual void __stdcall set_range_flag_45EEB9590203 (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);

	virtual void __stdcall set_range_flag_except_first_children_of_root_children_51EFD26E03DF (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);

	virtual void __stdcall start_change_transaction_45EEB9590217 ();


	virtual NodeType __stdcall get_type () const;
	virtual void __stdcall set_type (NodeType type) /*throw (ConstantModify_tie)*/;
};

class INodeIterator_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_next (INodeBase_tie*& ret_) = 0;
};

class __declspec (dllexport) NodeIterator_tie: public INodeIterator_tie {
	SET_OBJECT_COUNTER (NodeIterator_tie)
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
	NodeIterator_tie ();

	typedef ::Core::PoolObjectManager<NodeIterator_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NodeIterator_tie> Pool;
	friend class ::Core::PoolObjectManager<NodeIterator_tie>;
	typedef ::Core::IidMapRegistrator<NodeIterator_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const INodeIterator_tie* obj, NodeIterator*& ret_, bool interface_addref = false);

	static void make_tie (const NodeIterator* obj, INodeIterator_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const NodeIterator& obj, INodeIterator_tie*& ret_, const Core::TIEBase* owner);

	NodeIterator* m_impl;

protected:

	virtual void __stdcall get_next (INodeBase_tie*& ret_);
};

#pragma pack (push, 1)

struct NodePosition_tie {
	long pos;
	INodeBase_tie* node;
	
	static void make_cpp (const NodePosition_tie& obj, NodePosition& ret_);

	static void make_tie (const NodePosition& obj, NodePosition_tie& ret_);
};

#pragma pack (pop)

class ICatalogBase_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall clone_45EEBA2C02C0 (
		ICatalogBase_tie*& ret_
	) const = 0;

	virtual void __stdcall create_45EEBA2C02CB (
		INodesClipboard_tie* nodes
		, ICatalogBase_tie*& ret_
	) const = 0;

	virtual void __stdcall get_node_by_path_45EEBA2C02C1 (
		const NodeIndexPath_tie* path
		, INodeBase_tie*& ret_
	) const /*throw (NotFound_tie)*/ = 0;

	virtual void __stdcall intersect_tree_45EEBA2C02C5 (
		const ICatalogBase_tie* tree
	) = 0;

	virtual void __stdcall merge_tree_45EEBA2C02C7 (
		const ICatalogBase_tie* tree
	) = 0;

	virtual void __stdcall minus_tree_45EEBA2C02C9 (
		const ICatalogBase_tie* tree
	) = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_name (GCI::IO::IString_tie* name) = 0;


	virtual void __stdcall get_root (INodeBase_tie*& ret_) = 0;
};

class __declspec (dllexport) CatalogBase_tie: public ICatalogBase_tie {
	SET_OBJECT_COUNTER (CatalogBase_tie)
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
	CatalogBase_tie ();

	typedef ::Core::PoolObjectManager<CatalogBase_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<CatalogBase_tie> Pool;
	friend class ::Core::PoolObjectManager<CatalogBase_tie>;
	typedef ::Core::IidMapRegistrator<CatalogBase_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ICatalogBase_tie* obj, CatalogBase*& ret_, bool interface_addref = false);

	static void make_tie (const CatalogBase* obj, ICatalogBase_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const CatalogBase& obj, ICatalogBase_tie*& ret_, const Core::TIEBase* owner);

	CatalogBase* m_impl;

protected:
	virtual void __stdcall clone_45EEBA2C02C0 (
		ICatalogBase_tie*& ret_
	) const;

	virtual void __stdcall create_45EEBA2C02CB (
		INodesClipboard_tie* nodes
		, ICatalogBase_tie*& ret_
	) const;

	virtual void __stdcall get_node_by_path_45EEBA2C02C1 (
		const NodeIndexPath_tie* path
		, INodeBase_tie*& ret_
	) const /*throw (NotFound_tie)*/;

	virtual void __stdcall intersect_tree_45EEBA2C02C5 (
		const ICatalogBase_tie* tree
	);

	virtual void __stdcall merge_tree_45EEBA2C02C7 (
		const ICatalogBase_tie* tree
	);

	virtual void __stdcall minus_tree_45EEBA2C02C9 (
		const ICatalogBase_tie* tree
	);


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_name (GCI::IO::IString_tie* name);


	virtual void __stdcall get_root (INodeBase_tie*& ret_);
};

class ITrimLeafFilter_tie: public IFilterForTree_tie {
public:

};

class __declspec (dllexport) TrimLeafFilter_tie: public ITrimLeafFilter_tie {
	SET_OBJECT_COUNTER (TrimLeafFilter_tie)
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
	TrimLeafFilter_tie ();

	typedef ::Core::PoolObjectManager<TrimLeafFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<TrimLeafFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<TrimLeafFilter_tie>;
	typedef ::Core::IidMapRegistrator<TrimLeafFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ITrimLeafFilter_tie* obj, TrimLeafFilter*& ret_, bool interface_addref = false);

	static void make_tie (const TrimLeafFilter* obj, ITrimLeafFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const TrimLeafFilter& obj, ITrimLeafFilter_tie*& ret_, const Core::TIEBase* owner);

	TrimLeafFilter* m_impl;

protected:

};

class ICountryFilter_tie: public IFilterForTree_tie {
public:

	virtual void __stdcall get_country (INodeBase_tie*& ret_) = 0;
	virtual void __stdcall set_country (INodeBase_tie* country) = 0;
};

class __declspec (dllexport) CountryFilter_tie: public ICountryFilter_tie {
	SET_OBJECT_COUNTER (CountryFilter_tie)
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
	CountryFilter_tie ();

	typedef ::Core::PoolObjectManager<CountryFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<CountryFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<CountryFilter_tie>;
	typedef ::Core::IidMapRegistrator<CountryFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ICountryFilter_tie* obj, CountryFilter*& ret_, bool interface_addref = false);

	static void make_tie (const CountryFilter* obj, ICountryFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const CountryFilter& obj, ICountryFilter_tie*& ret_, const Core::TIEBase* owner);

	CountryFilter* m_impl;

protected:

	virtual void __stdcall get_country (INodeBase_tie*& ret_);
	virtual void __stdcall set_country (INodeBase_tie* country);
};

class ICutToLeafCountFilter_tie: public IFilterForTree_tie {
public:

	virtual unsigned long __stdcall get_leaf_count () const = 0;
	virtual void __stdcall set_leaf_count (unsigned long leaf_count) = 0;
};

class __declspec (dllexport) CutToLeafCountFilter_tie: public ICutToLeafCountFilter_tie {
	SET_OBJECT_COUNTER (CutToLeafCountFilter_tie)
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
	CutToLeafCountFilter_tie ();

	typedef ::Core::PoolObjectManager<CutToLeafCountFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<CutToLeafCountFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<CutToLeafCountFilter_tie>;
	typedef ::Core::IidMapRegistrator<CutToLeafCountFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ICutToLeafCountFilter_tie* obj, CutToLeafCountFilter*& ret_, bool interface_addref = false);

	static void make_tie (const CutToLeafCountFilter* obj, ICutToLeafCountFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const CutToLeafCountFilter& obj, ICutToLeafCountFilter_tie*& ret_, const Core::TIEBase* owner);

	CutToLeafCountFilter* m_impl;

protected:

	virtual unsigned long __stdcall get_leaf_count () const;
	virtual void __stdcall set_leaf_count (unsigned long leaf_count);
};

class NodeIdList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (NodeIdList_tie)
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
	NodeIdList_tie ();

	typedef ::Core::PoolObjectManager<NodeIdList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NodeIdList_tie> Pool;
	friend class ::Core::PoolObjectManager<NodeIdList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const NodeIdList_tie* obj, NodeIdList*& ret_);

	static void make_tie (NodeIdList* obj, NodeIdList_tie*& ret_);
	
	static void make_tie (const NodeIdList& obj, NodeIdList_tie*& ret_);

	static void make_tie (const NodeIdList& obj, NodeIdList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (NodeIdList* obj, NodeIdList_tie*& ret_);

	NodeIdList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual NodeId __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, NodeId item);
	virtual size_t __stdcall add (NodeId item);
	virtual size_t __stdcall insert (size_t index, NodeId item);
};

class IBlocksFilter_tie: public IFilterForTree_tie {
public:

};

class __declspec (dllexport) BlocksFilter_tie: public IBlocksFilter_tie {
	SET_OBJECT_COUNTER (BlocksFilter_tie)
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
	BlocksFilter_tie ();

	typedef ::Core::PoolObjectManager<BlocksFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<BlocksFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<BlocksFilter_tie>;
	typedef ::Core::IidMapRegistrator<BlocksFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IBlocksFilter_tie* obj, BlocksFilter*& ret_, bool interface_addref = false);

	static void make_tie (const BlocksFilter* obj, IBlocksFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const BlocksFilter& obj, IBlocksFilter_tie*& ret_, const Core::TIEBase* owner);

	BlocksFilter* m_impl;

protected:

};

class IInpharmFilter_tie: public IFilterForTree_tie {
public:

};

class __declspec (dllexport) InpharmFilter_tie: public IInpharmFilter_tie {
	SET_OBJECT_COUNTER (InpharmFilter_tie)
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
	InpharmFilter_tie ();

	typedef ::Core::PoolObjectManager<InpharmFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<InpharmFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<InpharmFilter_tie>;
	typedef ::Core::IidMapRegistrator<InpharmFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IInpharmFilter_tie* obj, InpharmFilter*& ret_, bool interface_addref = false);

	static void make_tie (const InpharmFilter* obj, IInpharmFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const InpharmFilter& obj, IInpharmFilter_tie*& ret_, const Core::TIEBase* owner);

	InpharmFilter* m_impl;

protected:

};

class IVariantsForDocFilter_tie: public IFilterForTree_tie {
public:

};

class __declspec (dllexport) VariantsForDocFilter_tie: public IVariantsForDocFilter_tie {
	SET_OBJECT_COUNTER (VariantsForDocFilter_tie)
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
	VariantsForDocFilter_tie ();

	typedef ::Core::PoolObjectManager<VariantsForDocFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<VariantsForDocFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<VariantsForDocFilter_tie>;
	typedef ::Core::IidMapRegistrator<VariantsForDocFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IVariantsForDocFilter_tie* obj, VariantsForDocFilter*& ret_, bool interface_addref = false);

	static void make_tie (const VariantsForDocFilter* obj, IVariantsForDocFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const VariantsForDocFilter& obj, IVariantsForDocFilter_tie*& ret_, const Core::TIEBase* owner);

	VariantsForDocFilter* m_impl;

protected:

};

class Filtered_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (Filtered_tie)
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
	Filtered_tie ();

	typedef ::Core::PoolObjectManager<Filtered_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Filtered_tie> Pool;
	friend class ::Core::PoolObjectManager<Filtered_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const Filtered_tie* obj, Filtered*& ret_);

	static void make_tie (Filtered* obj, Filtered_tie*& ret_);
	
	static void make_tie (const Filtered& obj, Filtered_tie*& ret_);

	static void make_tie (const Filtered& obj, Filtered_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (Filtered* obj, Filtered_tie*& ret_);

	Filtered* m_impl;
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

class IContextFilter_tie: public IFilterForTree_tie {
public:

	virtual SearchArea __stdcall get_area () const = 0;
	virtual void __stdcall set_area (SearchArea area) = 0;

	virtual void __stdcall clone_46E662C8033B (
		IContextFilter_tie*& ret_
	) const = 0;


	virtual void __stdcall get_context (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_context (GCI::IO::IString_tie* context) = 0;

	virtual void __stdcall filtrate_4D3E9E7E01ED (
		const IListForFiltering_tie* list
		, Filtered_tie*& ret_
	) const = 0;


	virtual FindOrder __stdcall get_order () const = 0;
	virtual void __stdcall set_order (FindOrder order) = 0;


	virtual ContextPlace __stdcall get_place () const = 0;
	virtual void __stdcall set_place (ContextPlace place) = 0;
};

class __declspec (dllexport) ContextFilter_tie: public IContextFilter_tie {
	SET_OBJECT_COUNTER (ContextFilter_tie)
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
	ContextFilter_tie ();

	typedef ::Core::PoolObjectManager<ContextFilter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ContextFilter_tie> Pool;
	friend class ::Core::PoolObjectManager<ContextFilter_tie>;
	typedef ::Core::IidMapRegistrator<ContextFilter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IContextFilter_tie* obj, ContextFilter*& ret_, bool interface_addref = false);

	static void make_tie (const ContextFilter* obj, IContextFilter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ContextFilter& obj, IContextFilter_tie*& ret_, const Core::TIEBase* owner);

	ContextFilter* m_impl;

protected:

	virtual SearchArea __stdcall get_area () const;
	virtual void __stdcall set_area (SearchArea area);

	virtual void __stdcall clone_46E662C8033B (
		IContextFilter_tie*& ret_
	) const;


	virtual void __stdcall get_context (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_context (GCI::IO::IString_tie* context);

	virtual void __stdcall filtrate_4D3E9E7E01ED (
		const IListForFiltering_tie* list
		, Filtered_tie*& ret_
	) const;


	virtual FindOrder __stdcall get_order () const;
	virtual void __stdcall set_order (FindOrder order);


	virtual ContextPlace __stdcall get_place () const;
	virtual void __stdcall set_place (ContextPlace place);
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

