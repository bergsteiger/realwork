////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynList_i
// Заголовок реализации класса серванта для интерфеса DynList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLIST_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLIST_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "shared/Core/data/UnsortedTypeConverter.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i_factory.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garantServer/src/Business/GblPilot/GblDocListC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListCatalogBase_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i.h"
#include "garantServer/src/Business/GblLogging/GblLoggingC.h"

//#UC START# *45741B97005D_CUSTOM_INCLUDES*
// todo работу с filters_counter нужно скрыть в m_filters.
//#UC END# *45741B97005D_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class DynList_i; // self forward Var
typedef ::Core::Var<DynList_i> DynList_i_var;
typedef ::Core::Var<const DynList_i> DynList_i_cvar;

class DynList_i_factory;

class DynList_i:
	virtual public DynList
	, virtual public ListCatalogBase_i<DynListNode_i>
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DynList_i)
	friend class DynList_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	class SortParamsWrapper {
		SET_OBJECT_COUNTER (SortParamsWrapper)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		explicit SortParamsWrapper (DynList_i* owner);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		SortParams& get ();

		void reset ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		DynList_i* m_owner;

		Core::Box<SortParams> m_sort_params;
	}; // class SortParamsWrapper

public:

	class DocListTypeConvertor : 
		public Core::UnsortedTypeConverter<GblDocList::DocListType, DynListContentImpl> {
		protected:
			void fill_array () {
				//#UC START# *47E24FE303A3_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblDocList::DLC_LEGAL_DOCUMENT, DLCI_LEGAL);
				this->add (GblDocList::DLC_MEDICAL_DOCUMENT, DLCI_MEDIC);
				//#UC END# *47E24FE303A3_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class DocListTypeConvertor

	typedef ACE_Singleton<DocListTypeConvertor, ACE_SYNCH_NULL_MUTEX> DocListTypeConvertorSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	static DynListTypeImpl type_to_impl_type (DynListType type);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DynList_i (GblDocList::DocListTree* server_list);

	DynList_i (GblPilot::LegalDocument* legal_document, const GblPilotQueryDef::Query& query, DynListType type);

	DynList_i (SpecialListKey key);

	virtual ~DynList_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void add_bookmark (const GblPilotDef::Bookmark& bookmark);

	virtual GTree::Tree* get_actual_server_tree () const;

	virtual GblDocList::DocListTree* get_cached_server_doc_list () const;

	virtual void make_name (DynListType type);

	virtual Containers::Content* save_to_folder (GblFolders::Folder* folder);

private:
	virtual bool check_filter (FilterFromQuery* filter) const;

	// Очистка закешированных данных
	virtual void clear_cache ();

	virtual void clone_filters (DynList_i* clone) const;

	virtual void do_delete_filter (const FilterFromQuery* filter);

	virtual void filtrate ();

	virtual NodeBase* get_root_i ();

	virtual NodeBase* real_root ();

	virtual void reset_by_server_tree (GTree::Tree* new_tree);

	virtual void truncate_view_by_context (ContextFilter* context, bool refresh);

	virtual void truncate_view_by_query ();

	virtual void truncate_view_by_sort ();

	virtual void truncate_view_i (const FilterList& list);

	virtual NodeBase* view ();

	virtual void write_to_log (GblLogging::LogEvent log_event, const DynList_i* dyn_list) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable bool m_build_server_list_on_demand;

	// тип содержимого списка
	mutable DynListContentImpl m_content_type;

	ContextFilter_var m_context_filter;

	FiltersFromQuery m_filters;

	mutable GCI::IO::String_var m_history;

	// Короткий список (сниппеты)
	mutable boost::tribool m_is_short_list;

	mutable boost::tribool m_is_snippet;

	mutable GblPilot::LegalDocument_var m_legal_document;

	mutable bool m_name_initialized;

	NodePointerMap m_node_pointer_2_block_position;

	mutable GblPilotQueryDef::Query m_query;

	mutable GblFolders::SavedList_var m_saved_list;

	mutable SortParamsWrapper m_sort_params;

	mutable DynListTypeImpl m_type;

	mutable NodeBase_var m_view;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CatalogBase
	virtual CatalogBase* clone () const;

	// implemented method from CatalogBase
	virtual CatalogBase* create (NodesClipboard* nodes) const;

	// implemented method from CatalogBase
	virtual void intersect_tree (const CatalogBase* tree);

	// implemented method from CatalogBase
	virtual void merge_tree (const CatalogBase* tree);

	// implemented method from CatalogBase
	virtual void minus_tree (const CatalogBase* tree);

	// implemented method from DynList
	virtual GCI::IO::Stream* as_evd (EVDGeneratorStyle style) const;

	// implemented method from DynList
	virtual const SortTypes& get_available_sort_types () const;

	// implemented method from DynList
	virtual const DynListContent get_content_type () const;

	// implemented method from DynList
	virtual const SortParams& get_current_sort_params () const;

	// implemented method from DynList
	// получить дерево анализа для списка
	virtual NodeBase* get_analysis_tree () const /*throw (CanNotFindData)*/;

	// implemented method from DynList
	// Получить полный список
	virtual void get_full_list (
		SearchProgressIndicator::ProgressIndicatorForSearch* progress
		, SearchProgressIndicator::CancelSearch*& cancel_process
	) /*throw (
		CanNotFindData
	)*/;

	// implemented method from DynList
	// Получить длину полного для базового списка
	virtual unsigned long get_full_list_size () const;

	// implemented method from DynList
	// получить "короткое" имя списка, используется при выводе на печать
	virtual GCI::IO::String* get_short_name () const;

	// implemented method from DynList
	virtual const GCI::IO::String& get_history () const;
	virtual GCI::IO::String& get_history ();

	// implemented method from DynList
	virtual bool get_is_filtered () const;

	// implemented method from DynList
	// Это короткий список (сниппеты)
	virtual const bool get_is_short () const;

	// implemented method from DynList
	// Признак, является ли список сниппетом
	virtual const bool get_is_snippet () const;

	// implemented method from DynList
	// Сохранить список или его выделенные элементы в файл.
	virtual void save_to_file (const char* path, const NodesClipboard* nodes) const;

	// implemented method from DynList
	virtual void set_context_filter (ContextFilter* context);

	// implemented method from DynList
	virtual void set_list_storage (GblFolders::SavedList* saved_list);

	// implemented method from DynList
	virtual void sort (const SortParams& params);

	// implemented method from EntityBase
	// Сохраняет в базе  измененное состояние объекта.
	// Объеденяя с с ранее сохраненными данными
	virtual EntityStorage* append_to (
		EntityStorage* storage
	) /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, CanNotSave
	)*/;

	// implemented method from EntityBase
	// идентификатор
	virtual const unsigned long get_eid () const
		/*throw (Unsupported)*/;

	// implemented method from EntityBase
	// свойство изменённости
	virtual bool get_is_changed () const;

	// implemented method from EntityBase
	// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
	// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
	// вернет исключение.
	virtual bool get_is_saved () const;

	// implemented method from EntityBase
	// Перезаписать сущность текущей сущностью.
	virtual EntityStorage* save_to (
		EntityStorage* storage
	) /*throw (
		AccessDenied
		, Unsupported
		, NotSaved
		, DuplicateNode
		, CanNotSave
	)*/;

	// implemented method from Filterable
	virtual const FiltersFromQuery& get_active_filters () const;

	// implemented method from Filterable
	// Добавляет INode (из дерева папок) как фильтр.
	// Если auto_refresh = true (значение по умолчанию), то
	// операция приводит к перефильтрации объекта.
	virtual void add_filter (
		FilterFromQuery* filter
		, bool auto_refresh
	) /*throw (
		AllContentIsFiltered
		, NotAllAttributesRestored
	)*/;

	// implemented method from Filterable
	// Добавляет пачку фильтров с одновременным их применением. При этом эта пачка либо целиком
	// применяется, либо (в случае, если все документы отфильтрованы) целиком отклоняется.
	// 
	// Если выясняется, что на сервере нет данных для построения списка, т.е. списка как такового нет
	// (см. К244711732), летит CanNotFindData.
	virtual void apply_filters (const FiltersFromQuery& filters) /*throw (CanNotFindData, AllContentIsFiltered)*/;

	// implemented method from Filterable
	// Удаляет все фильтры. В результате операции объект переходит в состояние, соответвующее
	// отсутствию фильтров
	virtual void clear_filters () /*throw (CanNotFindData)*/;

	// implemented method from Filterable
	// Удаляет фильтр из списка активных фильтров объекта. Если auto_refresh = true (значение по
	// умолчанию), то операция приводит к перефильтрации объекта.
	virtual void delete_filter (
		const FilterFromQuery* filter
		, bool auto_refresh
	) /*throw (
		CanNotFindData
		, AllContentIsFiltered
	)*/;

	// implemented method from Filterable
	virtual bool get_has_active_filters () const;

	// implemented method from Filterable
	virtual void refresh_filters () /*throw (CanNotFindData, AllContentIsFiltered)*/;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from CatalogBase
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	virtual void set_name (GCI::IO::String* name);

	// overloaded method from CatalogBase
	virtual const NodeBase* get_root () const;

	// overloaded method from CatalogBase_i
	virtual GTree::Tree* get_cached_server_tree () const;


//#UC START# *45741B97005D*
//#UC END# *45741B97005D*
}; // class DynList_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLIST_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
