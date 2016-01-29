////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeDefines/DynamicTreeDefines.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garantServer/src/Business/GblPilot/GblDocListC.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

typedef std::vector < SortType > SortTypes;

enum DynListType {
	T_RESPONDENT
	, T_CORRESPONDENT
	, T_RESPONDENT_TO_PART
	, T_CORRESPONDENT_TO_PART
	, T_SAME_DOCUMENTS // Похожие документы
};

// задаёт вид списка
enum DynListContent {
	DLC_LEGAL_DOCUMENTS // юридические документы
	, DLC_MEDICAL_DOCUMENTS // документы инфарма
};

class ListEntryInfo;
typedef ::Core::Var<ListEntryInfo> ListEntryInfo_var;
typedef ::Core::Var<const ListEntryInfo> ListEntryInfo_cvar;
class ListEntryInfo
	: virtual public EntityBase
{
public:
	virtual PositionType get_type () const = 0;

	virtual unsigned long get_position () const = 0;

	// Релевантность. Для списков без релевантности всегда 0.
	virtual const short get_relevance () const = 0;

	virtual const PId get_pid () const = 0;

	virtual const Document* get_doc () const = 0;
	virtual Document* get_doc () = 0;

	virtual const GblPilotDef::SubParaList& get_entry_list () const = 0;

	virtual const GblPilotDef::WordList& get_relevance_words_list () const = 0;
};

/// factory interface for ListEntryInfo
class ListEntryInfoFactory {
public:
	static ListEntryInfo* make (const GblPilot::ListEntryInfo& info, const NodeBase* root)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static ListEntryInfo* make (const GblPilot::ListEntryInfo& info)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

enum SpecialListKey {
	SLK_ALL_ALLOWED_DRUGS // Все неаннулированные препараты
};

class DynList;
typedef ::Core::Var<DynList> DynList_var;
typedef ::Core::Var<const DynList> DynList_cvar;
class DynList
	: virtual public EntityBase
	, virtual public Filterable
	, virtual public CatalogBase
{
public:
	virtual const GCI::IO::String& get_history () const = 0;
	virtual GCI::IO::String& get_history () = 0;

	virtual bool get_is_filtered () const = 0;

	virtual const DynListContent get_content_type () const = 0;

	// Это короткий список (сниппеты)
	virtual const bool get_is_short () const = 0;

	// Признак, является ли список сниппетом
	virtual const bool get_is_snippet () const = 0;

	virtual const SortParams& get_current_sort_params () const = 0;

	virtual const SortTypes& get_available_sort_types () const = 0;

	virtual void sort (const SortParams& params) = 0;

	virtual void set_context_filter (ContextFilter* context) = 0;

	// Сохранить список или его выделенные элементы в файл.
	virtual void save_to_file (const char* path, const NodesClipboard* nodes) const = 0;

	virtual GCI::IO::Stream* as_evd (EVDGeneratorStyle style) const = 0;

	// получить "короткое" имя списка, используется при выводе на печать
	virtual GCI::IO::String* get_short_name () const = 0;

	virtual void set_list_storage (GblFolders::SavedList* saved_list) = 0;

	// Получить полный список
	virtual void get_full_list (
		SearchProgressIndicator::ProgressIndicatorForSearch* progress
		, SearchProgressIndicator::CancelSearch*& cancel_process
	) /*throw (
		CanNotFindData
	)*/ = 0;

	// получить дерево анализа для списка
	virtual NodeBase* get_analysis_tree () const /*throw (CanNotFindData)*/ = 0;

	// Получить длину полного для базового списка
	virtual unsigned long get_full_list_size () const = 0;
};

/// factory interface for DynList
class DynListFactory {
public:
	static DynList* make (GblDocList::DocListTree* server_list)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static DynList* make (
		GblPilot::LegalDocument* legal_document
		, const GblPilotQueryDef::Query& query
		, DynListType type
	) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static DynList* make (SpecialListKey key)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class SearchDynList;
typedef ::Core::Var<SearchDynList> SearchDynList_var;
typedef ::Core::Var<const SearchDynList> SearchDynList_cvar;
// Список - результат поиска
class SearchDynList
	: virtual public SearchEntity
{
public:
	virtual DynList* get_dyn_list () const = 0;
};

/// factory interface for SearchDynList
class SearchDynListFactory {
public:
	static SearchDynList* make (GblPilot::SearchDocList* search_doc_list)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

enum DynListFlags {
	DLF_ANALYSIS_NODE_HAS_DATA // может быть построен список
	, DLF_ANALYSIS_NODE_EMPTY
};

class DocListFactory;
typedef ::Core::Var<DocListFactory> DocListFactory_var;
typedef ::Core::Var<const DocListFactory> DocListFactory_cvar;
// фабрика для создания списков
class DocListFactory
	: virtual public ::Core::IObject
{
public:
	// построить список по данным из файла file_name.
	// inner_numbers - флаг указывающий какие номера документов используются (если inner_numbers=true
	// - внутренние)
	// 
	// Формат файла (К195757811):
	// <номер топика>{.<номер саба/блока>}{<пробел или табуляция><любые символы>}
	// <номер топика>{.<номер саба/блока>}{<пробел или табуляция><любые символы>}
	// <номер топика>{.<номер саба/блока>}{<пробел или табуляция><любые символы>}
	// ...
	// 
	// Исключения:
	// AccessDenied - не смогли прочитать данные из файла
	// InvalidType - в файле некорректные данные
	virtual DynList* make_list (
		const char* file_name
		, bool inner_numbers
	) const /*throw (
		AccessDenied
		, InvalidType
	)*/ = 0;
};

/// factory interface for DocListFactory
class DocListFactoryFactory {
public:
	static DocListFactory* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DynListNode;
typedef ::Core::Var<DynListNode> DynListNode_var;
typedef ::Core::Var<const DynListNode> DynListNode_cvar;
class DynListNode
	: virtual public ::Core::IObject
{
public:
	// Получить идентифкатор документа из ноды списка
	virtual ObjectId get_document_id () const = 0;
};

/// factory interface for DynListNode
class DynListNodeFactory {
public:
	static DynListNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ListEntryInfo> {
	typedef GblAdapterLib::ListEntryInfoFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DynList> {
	typedef GblAdapterLib::DynListFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::SearchDynList> {
	typedef GblAdapterLib::SearchDynListFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DocListFactory> {
	typedef GblAdapterLib::DocListFactoryFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DynListNode> {
	typedef GblAdapterLib::DynListNodeFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
