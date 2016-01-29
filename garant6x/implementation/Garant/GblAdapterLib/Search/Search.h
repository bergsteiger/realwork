////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Search
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"
#include "garantServer/src/Business/GblFilters/GblFiltersC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

enum QueryType {
	QT_KEYWORD
	, QT_ATTRIBUTE
	, QT_PUBLISHED_SOURCE
	, QT_COMMENTS
	, QT_REVIEW
	, QT_MAIL_LIST
	, QT_RUBRICATOR
	, QT_CONSULT
	, QT_HANDYCRAFT_CONSULT
	, QT_DETAIL // Детализация СКР
	, QT_BASE_SEARCH // Карточка базового поиска
	, QT_PHARM_SEARCH // Поиск в Инфарме
};

enum QueryTagType {
	QTT_CONTEXT
	, QTT_NODE
	, QTT_DATE
	, QTT_PHONE_NUMBER // номер телефона
};

class QueryAttribute;
typedef ::Core::Var<QueryAttribute> QueryAttribute_var;
typedef ::Core::Var<const QueryAttribute> QueryAttribute_cvar;
class QueryAttribute
	: virtual public ::Core::IObject
{
public:
	virtual QueryTagType get_type () const = 0;

	virtual void clear () = 0;

	virtual AttributeTag_const get_tag () const = 0;
};

// Возможные логические операции для объединения поисковых атрибутов и списков.
enum QueryLogicOperation {
	QLO_AND // Логическое И.
	, QLO_OR // Логическое ИЛИ.
	, QLO_AND_NOT // Кроме. Данная логическая операция используется только при получении список карточке запроса - Search::get_query_forms. Для установки этой операции на узлах запросов QueryNode, у них предусмотрен флаг negative.
};

class QueryPhoneNumberAttribute;
typedef ::Core::Var<QueryPhoneNumberAttribute> QueryPhoneNumberAttribute_var;
typedef ::Core::Var<const QueryPhoneNumberAttribute> QueryPhoneNumberAttribute_cvar;
// Телефон юзера
class QueryPhoneNumberAttribute
	: virtual public QueryAttribute
{
public:
	virtual const GCI::IO::String& get_phone_number () const = 0;
	virtual GCI::IO::String& get_phone_number () = 0;

	virtual void set_phone_number (GCI::IO::String* phone_number) = 0;

	virtual const GCI::IO::String& get_city_code () const = 0;
	virtual GCI::IO::String& get_city_code () = 0;

	virtual void set_city_code (GCI::IO::String* city_code) = 0;
};

/// factory interface for QueryPhoneNumberAttribute
class QueryPhoneNumberAttributeFactory {
public:
	static QueryPhoneNumberAttribute* make (AttributeTag_const attribute_tag)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

struct QueryNodeValue {
	NodeBase_var node;
	QueryLogicOperation operation;

	QueryNodeValue (NodeBase* node_, QueryLogicOperation operation_);

	// конструктор по умолчанию
	QueryNodeValue ();
};

#pragma pack (pop)

#pragma pack (push, 1)

struct ContextValue {
	GCI::IO::String_var context;
	QueryLogicOperation operation;

	ContextValue (GCI::IO::String* context_);

	// конструктор по умолчанию
	ContextValue ();
};

#pragma pack (pop)

typedef std::vector < ContextValue > ContextValueList;

#pragma pack (push, 1)

struct DateValue {
	Date from;
	Date to;
	QueryLogicOperation operation;

	DateValue (const Date& from_, const Date& to_, QueryLogicOperation operation_);

	// конструктор по умолчанию
	DateValue ();
};

#pragma pack (pop)

typedef std::vector < DateValue > DateValueList;

class QueryDateAttribute;
typedef ::Core::Var<QueryDateAttribute> QueryDateAttribute_var;
typedef ::Core::Var<const QueryDateAttribute> QueryDateAttribute_cvar;
class QueryDateAttribute
	: virtual public QueryAttribute
{
public:
	virtual const DateValueList& get_values () const = 0;

	virtual void add_value (QueryLogicOperation operation, const Date& from, const Date& to) = 0;
};

/// factory interface for QueryDateAttribute
class QueryDateAttributeFactory {
public:
	static QueryDateAttribute* make (AttributeTag_const attribute_tag)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < QueryNodeValue > NodeValueList;

class QueryNodeAttribute;
typedef ::Core::Var<QueryNodeAttribute> QueryNodeAttribute_var;
typedef ::Core::Var<const QueryNodeAttribute> QueryNodeAttribute_cvar;
class QueryNodeAttribute
	: virtual public QueryAttribute
{
public:
	virtual const NodeValueList& get_values () const = 0;

	virtual void add_value (QueryLogicOperation operation, NodeBase* node) = 0;
};

/// factory interface for QueryNodeAttribute
class QueryNodeAttributeFactory {
public:
	static QueryNodeAttribute* make (AttributeTag_const attribute_tag)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < QueryAttribute_var > QueryAttributeList;

typedef std::vector < QueryLogicOperation > OperationList;

class QueryContextAttribute;
typedef ::Core::Var<QueryContextAttribute> QueryContextAttribute_var;
typedef ::Core::Var<const QueryContextAttribute> QueryContextAttribute_cvar;
class QueryContextAttribute
	: virtual public QueryAttribute
{
public:
	virtual const ContextValueList& get_values () const = 0;

	virtual void add_value (QueryLogicOperation operation, GCI::IO::String* context) = 0;
};

/// factory interface for QueryContextAttribute
class QueryContextAttributeFactory {
public:
	static QueryContextAttribute* make (AttributeTag_const attribute_tag)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class AttributeInfo;
typedef ::Core::Var<AttributeInfo> AttributeInfo_var;
typedef ::Core::Var<const AttributeInfo> AttributeInfo_cvar;
class AttributeInfo
	: virtual public ::Core::IObject
{
public:
	virtual bool get_is_exist () const = 0;

	virtual const OperationList& get_available_operations () const = 0;

	// Получить дефолтное значение атрибута
	virtual QueryAttribute* get_default_value () const = 0;
};

/// factory interface for AttributeInfo
class AttributeInfoFactory {
public:
	static AttributeInfo* make (AttributeTag_const tag)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Список слов
typedef std::vector < GCI::IO::String_var > ContextWordList;

// Для атрибута нет значения по умолчанию
class NoDefaultValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Query;
typedef ::Core::Var<Query> Query_var;
typedef ::Core::Var<const Query> Query_cvar;
// Интерфейс обеспечивающий работу с запросом. Объекты этого интерфейса расположены в узлах
// навигатора.
// Поисковый запрос формируется при помощи узлов QueryOperationNode и QueryAttributeNode,
// сгруппированных в виде нисходящего бинарного дерева.
class Query
	: virtual public EntityBase
{
public:
	// Количество найденных документов при последнем поиске.
	virtual unsigned long get_count () const = 0;

	virtual QueryType get_type () const = 0;

	virtual const Date& get_date () const = 0;

	virtual const QueryAttributeList& get_attributes () const = 0;

	virtual void execute (
		DynList* filtrate_list
		, SearchProgressIndicator::ProgressIndicatorForSearch* progress
		, SearchProgressIndicator::CancelSearch*& cancel_process
	) = 0;

	virtual QueryContextAttribute* get_context_attribute (AttributeTag_const tag) = 0;

	virtual QueryNodeAttribute* get_node_attribute (AttributeTag_const tag) = 0;

	virtual QueryDateAttribute* get_date_attribute (AttributeTag_const tag) = 0;

	virtual void clear () = 0;

	virtual QueryAttributeList* attributes_by_tag (AttributeTag_const tag) = 0;

	virtual Query* clone () = 0;

	// Отправить запрос на консультацию
	virtual void send_query () = 0;

	virtual QueryPhoneNumberAttribute* get_phone_number_attribute (AttributeTag_const tag) = 0;

	virtual GblPilotQueryDef::Query* build_query () = 0;

	virtual void set_name (GCI::IO::String* name) = 0;

	virtual const GCI::IO::String* get_name () const = 0;

	virtual GCI::IO::String* get_comment () const = 0;

	virtual void set_comment (GCI::IO::String* comment) = 0;

	// получен ли запрос с фильтра
	virtual bool is_filter_query () const = 0;
};

/// factory interface for Query
class QueryFactory {
public:
	static Query* make (QueryType type)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Список запросов.
typedef std::vector < Query_var > QueryList;

enum AttributeFilterType {
	AFT_NONE
	, AFT_TRIM
};

class Search;
typedef ::Core::Var<Search> Search_var;
typedef ::Core::Var<const Search> Search_cvar;
// Поиск.
class Search
	: virtual public ::Core::IObject
{
public:
	virtual bool get_is_morpho_exist () const = 0;

	// Создать новый поисковый запрос. В созданном поисковом запросе по умолчанию создаеться корневой
	// QueryOperationNode с опреацией LO_AND.
	virtual Query* create_query (QueryType type) const = 0;

	virtual AttributeInfo* get_attribute_info (AttributeTag_const tag) const = 0;

	// Получить количество примеров
	virtual unsigned long get_example_text_count () const = 0;

	// получить текст примера по заданной позиции pos
	virtual GCI::IO::String* get_example_text (unsigned long pos) const /*throw (CanNotFindData)*/ = 0;

	// Список документов без команды CLASS
	virtual DynList* get_documents_without_class () const = 0;

	// Cписок документов с командой vanonced и без команды vincluded
	virtual DynList* get_documents_without_included () const = 0;

	// Cписок документов без команды key
	virtual DynList* get_documents_without_key () const = 0;

	// Возвращает список слов, которые не смогли скорректировать и скорректированную строку
	virtual ContextWordList* correct_context (
		const ContextWordList& context_for_check
		, bool for_inpharm
		, ContextWordList*& corrected_context
	) const = 0;
};

/// factory interface for Search
class SearchFactory {
public:
	static Search* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class QueryNotExecuted : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// константы для оболочки - К121160631
static const char* AT_CONSULTATION_TEXT = "AT_CONSULTATION_TEXT";
static const char* AT_LAW_SUPPORT_TEXT = "AT_LAW_SUPPORT_TEXT";
static const char* AT_TEXT = "AT_TEXT";
static const char* AT_TEXT_NAME = "AT_TEXT_NAME";
static const char* AT_TEXT_BODY = "AT_TEXT_BODY";
static const char* AT_THEMES_NAME = "AT_THEMES_NAME";
static const char* AT_CONSULTATION_DESCRIPTION = "AT_CONSULTATION_DESCRIPTION";
static const char* AT_USER_NAME = "AT_USER_NAME";
static const char* AT_EMAIL = "AT_EMAIL";
static const char* AT_PHARM_NAME = "AT_PHARM_NAME";
static const char* AT_PHARM_TEXT = "AT_PHARM_TEXT";
static const char* AT_SHORT_LIST = "AT_SHORT_LIST";
static const char* AT_USER_PHONE = "AT_USER_PHONE";

class FoldersQuery;
typedef ::Core::Var<FoldersQuery> FoldersQuery_var;
typedef ::Core::Var<const FoldersQuery> FoldersQuery_cvar;
class FoldersQuery
	: virtual public ::Core::IObject
{
public:
	virtual GblFolders::SavedQuery* get_saved_query () = 0;

	virtual void reset_saved_query () = 0;
};

class QueryCreator;
typedef ::Core::Var<QueryCreator> QueryCreator_var;
typedef ::Core::Var<const QueryCreator> QueryCreator_cvar;
class QueryCreator
	: virtual public ::Core::IObject
{
public:
	virtual Query* make_query (const GblPilotQueryDef::Query& query) const = 0;

	virtual Query* make_query (
		GblFolders::SavedQuery* saved_query
		, bool load_on_demand
		, FoldersNode* folders_node
	) const = 0;

	virtual Query* make_query (GblUserJournal::JournalQuery* journal_query) const = 0;
};

/// factory interface for QueryCreator
class QueryCreatorFactory {
public:
	static QueryCreator* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class FiltersQuery;
typedef ::Core::Var<FiltersQuery> FiltersQuery_var;
typedef ::Core::Var<const FiltersQuery> FiltersQuery_cvar;
class FiltersQuery
	: virtual public Query
{
};

/// factory interface for FiltersQuery
class FiltersQueryFactory {
public:
	static FiltersQuery* make (FilterFromQuery* filter)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class AdapterFiltersQuery;
typedef ::Core::Var<AdapterFiltersQuery> AdapterFiltersQuery_var;
typedef ::Core::Var<const AdapterFiltersQuery> AdapterFiltersQuery_cvar;
class AdapterFiltersQuery
	: virtual public Query
{
};

/// factory interface for AdapterFiltersQuery
class AdapterFiltersQueryFactory {
public:
	static AdapterFiltersQuery* make (QueryType type)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class FullAttributeInfo;
typedef ::Core::Var<FullAttributeInfo> FullAttributeInfo_var;
typedef ::Core::Var<const FullAttributeInfo> FullAttributeInfo_cvar;
// информация об атрибуте для КЗ
class FullAttributeInfo
	: virtual public AttributeInfo
{
public:
	virtual const GCI::IO::String* get_tag () const = 0;
	virtual GCI::IO::String* get_tag () = 0;
};

/// factory interface for FullAttributeInfo
class FullAttributeInfoFactory {
public:
	static FullAttributeInfo* make (const GblPilotQueryDef::FullAttributeInfo& full_info)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < FullAttributeInfo_var > AttributeList;

static const char* QCT_PRIME = "QCT_PRIME"; // карточка прайма
static const char* QCT_ATTRIBUTE = "QCT_ATTRIBUTE"; // карточка ППР
static const char* QCT_REVIEW = "QCT_REVIEW"; // карточка поиска по изменениям законодательства
static const char* QCT_CONSULTING = "QCT_CONSULTING"; // карточка запроса к консалтингу
static const char* QCT_PHARM = "QCT_PHARM"; // карточка инфарма

class QueryCardInfo;
typedef ::Core::Var<QueryCardInfo> QueryCardInfo_var;
typedef ::Core::Var<const QueryCardInfo> QueryCardInfo_cvar;
// информация, связанная с карточкой запроса
class QueryCardInfo
	: virtual public ::Core::IObject
{
public:
	virtual const GCI::IO::Stream* get_evd_card () const
		/*throw (CanNotFindData)*/ = 0;

	// получить список существующих атрибутов для КЗ
	virtual AttributeList* get_exist_attrs () const = 0;
};

/// factory interface for QueryCardInfo
class QueryCardInfoFactory {
public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
public:
	static QueryCardInfo* create (const char* key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

class AttributesHelper;
typedef ::Core::Var<AttributesHelper> AttributesHelper_var;
typedef ::Core::Var<const AttributesHelper> AttributesHelper_cvar;
// информация об атрибутах, которая напрямую не касается карточек
class AttributesHelper
	: virtual public ::Core::IObject
{
public:
	virtual bool attribute_KW_exists () const = 0;

	virtual bool attribute_publish_source_exists () const = 0;
};

/// factory interface for AttributesHelper
class AttributesHelperFactory {
public:
	static AttributesHelper* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::QueryPhoneNumberAttribute> {
	typedef GblAdapterLib::QueryPhoneNumberAttributeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::QueryDateAttribute> {
	typedef GblAdapterLib::QueryDateAttributeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::QueryNodeAttribute> {
	typedef GblAdapterLib::QueryNodeAttributeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::QueryContextAttribute> {
	typedef GblAdapterLib::QueryContextAttributeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::AttributeInfo> {
	typedef GblAdapterLib::AttributeInfoFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Query> {
	typedef GblAdapterLib::QueryFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Search> {
	typedef GblAdapterLib::SearchFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::QueryCreator> {
	typedef GblAdapterLib::QueryCreatorFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::FiltersQuery> {
	typedef GblAdapterLib::FiltersQueryFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::AdapterFiltersQuery> {
	typedef GblAdapterLib::AdapterFiltersQueryFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::FullAttributeInfo> {
	typedef GblAdapterLib::FullAttributeInfoFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::QueryCardInfo> {
	typedef GblAdapterLib::QueryCardInfoFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::AttributesHelper> {
	typedef GblAdapterLib::AttributesHelperFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
