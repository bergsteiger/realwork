////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypes
//
// Базовые типы, используемые в адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "shared/GCI/IO/IO.h"
//#UC START# *456EA56002BF_CUSTOM_INCLUDE*
#include "shared/Core/sys/IObject.h"
//#UC END# *456EA56002BF_CUSTOM_INCLUDE*

namespace GblAdapterLib {

// Идентификатор класса объекта
typedef unsigned long ClassId;

// Идентификатор объекта внутри класса
typedef unsigned long ObjectId;

#pragma pack (push, 1)

// Persistent ID, тип для идентификации хранимых объектов.
struct PId {
	// идентификатор класса
	ClassId class_id;
	// идентификатор объекта
	ObjectId object_id;
};

#pragma pack (pop)

#pragma pack (push, 1)

// Дата.
struct Date {
	// Число
	unsigned short day;
	// Месяц
	unsigned short month;
	// Год.
	unsigned short year;

	// создать нулевую дату
	Date ();

	// создать заданную дату
	Date (unsigned short y, unsigned short m, unsigned short d);
	//#UC START# *456EA6F00109*
	inline bool operator > (const Date date) const
	{
		if (year > date.year) return true;
		if (year < date.year) return false;
		if (month > date.month) return true;
		if (month < date.month) return false;
		if (day > date.day) return true;
		if (day < date.day) return false;
		return false;
	}

	inline bool operator < (const Date date) const
	{
		if (year < date.year) return true;
		if (year > date.year) return false;
		if (month < date.month) return true;
		if (month > date.month) return false;
		if (day < date.day) return true;
		if (day > date.day) return false;
		return false;
	}

	inline bool operator == (const Date date) const 
	{
		if (day == date.day && month == date.month && year == date.year) {
			return true;
		}
		return false;
	}

	inline bool operator != (const Date date) const
	{
		if (day != date.day || month != date.month || year != date.year) {
			return true;
		}
		return false;
	}

	inline bool operator >= (const Date date) const
	{
		if (*this > date || *this == date) return true;
		return false;
	}

	inline bool operator <= (const Date date) const
	{
		if (*this < date || *this == date) return true;
		return false;
	}
	//#UC END# *456EA6F00109*
};

#pragma pack (pop)

#pragma pack (push, 1)

// Интервал дат (включающий).
struct DateInterval {
	// начальная дата
	Date start;
	// завершающая дата
	Date finish;
};

#pragma pack (pop)

#pragma pack (push, 1)

// Время
struct Time {
	// часы
	unsigned short hour;
	// минуты
	unsigned short min;
	// секунды
	unsigned short sec;
};

#pragma pack (pop)

#pragma pack (push, 1)

// Дата и время
struct DateTime {
	// Дата
	Date date;
	// время
	Time time;
};

#pragma pack (pop)

// Языки
enum Languages {
	LG_RUSSIAN // Русский
	, LG_ENGLISH // Английский
	, LG_FRENCH // Французский
	, LG_GERMAN // Немецкий
	, LG_SPANISH // Испанский
	, LG_ITALIAN // Итальянский
};

class NamedElement;
typedef ::Core::Var<NamedElement> NamedElement_var;
typedef ::Core::Var<const NamedElement> NamedElement_cvar;
// Именованный элемент.
class NamedElement
	: virtual public ::Core::IObject
{
public:
	// имя
	virtual const GCI::IO::String& get_name () const = 0;
	virtual GCI::IO::String& get_name () = 0;

	virtual void set_name (GCI::IO::String* name) = 0;

	// комментарий
	virtual const GCI::IO::String& get_comment () const = 0;
	virtual GCI::IO::String& get_comment () = 0;

	virtual void set_comment (GCI::IO::String* comment) = 0;
};

// Исключение возникает при попытке изменить константный параметер.
class ConstantModify : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возбуждается в случае нарушения прав доступа.
class AccessDenied : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Исключение возбуждается в случае если запрошенная операция не может быть выполнена на сервер, по
// причине неверной метки синхронизации. Возможно необходимо повторить вызов.
class InvalidTimeStamp : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// База блокирована
class StorageLocked : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возвращается в случае если вызванная опреация не поддеоживается объектом.
class Unsupported : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возвращается при попытке сохранить/восстановить изменения в несохраненном (т.е не привязанном к
// месту хранения, например к папкам) объекте
class NotSaved : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Папки недоступны.
// Возвращается в случае, если у пользователя нет доступа к папкам.
class FoldersNotAvailable : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Запрошенные данные не найдены.
// Возвращается в случае, если данные запрошенные по операции get_<something> отсутствуют.
class CanNotFindData : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возникает в случае добавления узла в дерево, где уже есть такой же узел. При этом уникальность
// определяется самим узлом.
class DuplicateNode : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Плохой тип данных
class InvalidType : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// объект не может быть сохранён
class CanNotSave : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Ошибка при разборе XML
class InvalidXMLType : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Общие константы, используемые в GblAdapter
static const long NODE_FLAG_STORABLE_ENTITY = 1; // маска, применяемая к Node::flags. Если BaseEntity::storable == true, то (Node::flags AND NODE_FLAG_STORABLE_ENTITY) возвращает true
static const char* PROPERTY_PATH_DELIMITER = "/"; // символ - разделитель частей пути
static const unsigned long DEFAULT_PRELOAD_CACHE = 50; // Размер по умолчанию при подгрузке фильтрованных эелментов дерева атрибутов.
static const char* LIBRARY_NAME = "GblAdapter.dll"; // Название библиотеки

// Всё сожержимое отфильтровано, что противоречит бизнес-логике
class AllContentIsFiltered : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// номер кодовой страницы
typedef short CodePage;

class EntityStorage;
typedef ::Core::Var<EntityStorage> EntityStorage_var;
typedef ::Core::Var<const EntityStorage> EntityStorage_cvar;
// Хранилище сущностей
class EntityStorage
	: virtual public ::Core::IObject
{
public:
	// получить тип содержимого
	virtual Containers::ContentType get_content_type () const = 0;

	// получить содежимое
	virtual Containers::Content* get_cached_content () const = 0;
};

class EntityBase;
typedef ::Core::Var<EntityBase> EntityBase_var;
typedef ::Core::Var<const EntityBase> EntityBase_cvar;
// Базовый абстрактный интерфейс для сущностей. Данный интерфейс должен заменить устаревыший
// BaseTreeSupport::BaseEntity .
class EntityBase
	: virtual public ::Core::IObject
{
public:
	// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
	// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
	// вернет исключение.
	virtual bool get_is_saved () const = 0;

	// свойство изменённости
	virtual bool get_is_changed () const = 0;

	// идентификатор
	virtual const unsigned long get_eid () const
		/*throw (Unsupported)*/ = 0;

	// Перезаписать сущность текущей сущностью.
	virtual EntityStorage* save_to (
		EntityStorage* storage
	) /*throw (
		AccessDenied
		, Unsupported
		, NotSaved
		, DuplicateNode
		, CanNotSave
	)*/ = 0;

	// Сохраняет в базе  измененное состояние объекта.
	// Объеденяя с с ранее сохраненными данными
	virtual EntityStorage* append_to (
		EntityStorage* storage
	) /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, CanNotSave
	)*/ = 0;
};

// Возвращается при операции по изменению дерева в случае, если результат получается пустой, и это
// запрещенно логикой конкретеного дерева.
class EmptyResult : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Статус элемента.
enum ItemStatus {
	IS_ABOLISHED // Утратил силу
	, IS_ACTIVE // Действующий
	, IS_PREACTIVE // Не вступил в силу
	, IS_UNKNOWN // Неопределен
};

// Возможные типы элементов основного меню.
enum NavigatorMenuItemType {
	NM_FOLDER // Псевдоэлемент - папка.
	, NM_RUBRICATOR // Навигатор по классификатору.
	, NM_ATTRIBUTE_SEARCH // Поиск по атрибутам.
	, NM_SITUATION_SEARCH // Поиск по ситуации.
	, NM_PUBLISH_SOURCE_SEARCH // Поиск по источнику опубликования.
	, NM_SINGLE_CONTEXT_SEARCH // Атомарный (простой) поиск по контексту.
	, NM_SINGLE_ATTRIBUTE_SEARCH // Атомарный (простой) поиск по древовидному атрибуту.
	, NM_SINGLE_DATE_NUMBER_SEARCH // Атомарный (простой) поиск по дате и номеру.
	, NM_FILTER_5X // Карточка фильтра а-ля Гарант 5.х.
	, NM_ATTRIBUTE_SEARCH_5X // Карточка поиска по атрибутам а-ля Гарант 5.х.
	, NM_SITUATION_SEARCH_5X // Карточка поиска по ситуациям а-ля Гарант 5.х.
	, NM_UPDATE // Обновление.
	, NM_CONFIGURATION_LIST // Список конфигураций.
	, NM_LIST // Список.
	, NM_COMPLECT_INFO // Информация о комплекте.
	, NM_DOCUMENT // Документ
	, NM_LAW_NAVIGATOR_FOLDER // Папка "Правовой навигатор"
	, NM_BUSINESS_INFO_FOLDER // Папка "Справочная информация"
	, NM_SEARCH_FOLDER // Папка "Поиск"
	, NM_UPDATE_FOLDER // Папка "Обновление"
	, NM_RECENTLY_DOCUMENTS_FOLDER // Папка "Последние открытые документы"
	, NM_EXPLANATORY_DICTIONARY // Толковый словарь
	, NM_NEW_DOCS // Новые документы
	, NM_PRIME_FOLDER // пункт меню ПРАЙМ
	, NM_REVIEW // пункт меню ОБЗОРЫ ЗАКОНОДАТЕЛЬСТВА
	, NM_NEWS_LINE // мониторинги
	, NM_SEARCH_WITH_LAW_SUPPORT // Пункт меню: Поиск с правовой поддержкой
	, NM_LAW_SUPPORT // пункт меню: правовая поддержка
	, NM_CALENDAR
	, NM_BUSINESS_REFERENCES
	, NM_HOT_INFORMATION
	, NM_CODEX // Кодексы
	, NM_FORMS // Формы документа
	, NM_MONITORINGS // Мониторинги
	, NM_PHARM_SEARCH // поиск в инфарме
	, NM_INPHARM // Инфарм
	, NM_PHARM_LEK // Лекарственные препараты
	, NM_PHARM_FIRMS // Фирмы производители
	, NM_PHARM_DICT // Словарь медицинских терминов
	, NM_PHARM_BASIC_SECTION // Основные разделы справочника
	, NM_TAXES_AND_FINANCE // Налоги и финансы
	, NM_BUSINESS_REFERENCES_FOLDER // Папка Бизнес-справки
	, NM_LEGAL_ISSUES // Юридические вопросы
	, NM_HR // Зарплата и кадры
	, NM_BUDGET_ORGS // Гос. и муниципальные учреждения
	, NM_LAW_FOR_ALL // Право для всех
	, NM_GOS_ZAKUPKI
};

// Тип результата поиска
enum SearchResultType {
	SRT_DOCUMENT_LIST // найден список документов
	, SRT_AUTOREFERAT // найден автореферат
	, SRT_CONSULTATION // найдена консультация
};

class SearchEntity;
typedef ::Core::Var<SearchEntity> SearchEntity_var;
typedef ::Core::Var<const SearchEntity> SearchEntity_cvar;
// Сущность, передаваемая в метод finish_process на прогресс индикаторе, как результат поиска
class SearchEntity
	: virtual public ::Core::IObject
{
public:
	// Тип результата поиска (список, автореферат, консультация)
	virtual SearchResultType get_result_type () const = 0;

	// Количество найденных документов
	virtual size_t get_document_count () const = 0;

	// Количество вхождений
	virtual size_t get_entry_count () const = 0;

	// количество редакций
	virtual size_t get_edition_count () const = 0;
};

/// factory interface for SearchEntity
class SearchEntityFactory {
public:
	// фабрика
	static SearchEntity* make (
		SearchResultType result_type
		, size_t document_count
		, size_t entry_count
		, size_t edition_count
	) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// фабрика
	static SearchEntity* make (GblPilotQueryDef::SearchEntity* search_entity)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Направление сортировки.
enum SortOrder {
	SO_ASCENDING // По возрастанию значений.
	, SO_DESCENDING // По убыванию значений.
};

// Тип сортировки.
enum SortType {
	ST_PRIORITY // Сортировка по юридической силе
	, ST_CREATE_DATE // Сортировка по дате создания
	, ST_LAST_EDIT_DATE // Сортировка по дате последнего изменения
	, ST_NOT_SORTED // Не отсортирован
	, ST_RELEVANCE // сортировка по релевантности
};

#pragma pack (push, 1)

// Параметры сортировки.
struct SortParams {
	// порядок сортировки
	SortOrder sort_order;
	// тип сортивровки
	SortType sort_type;
};

#pragma pack (pop)

// Типы поиска по контексту
enum TextSearchOptionType {
	TSO_TEXT // поиск по тексту
	, TSO_NAME // поиск по заголовку
	, TSO_PARA // поиск по параграфу
	, TSO_SENTENCE // поиск по предложению
};

class Variant;
typedef ::Core::Var<Variant> Variant_var;
typedef ::Core::Var<const Variant> Variant_cvar;
// тип данных для нотификации
class Variant
	: virtual public ::Core::IObject
{
public:
	// вернуть целое
	virtual long get_long () const /*throw (InvalidType)*/ = 0;

	// вернуть булево значение
	virtual bool get_bool () const /*throw (InvalidType)*/ = 0;

	// вернуть строку
	virtual GCI::IO::String* get_string () /*throw (InvalidType)*/ = 0;

	// вернуть объект
	virtual Core::IObject* get_object () /*throw (InvalidType)*/ = 0;
};

/// factory interface for Variant
class VariantFactory {
public:
	// фабрика
	static Variant* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// создать обёртку вокруг лонг
	static Variant* make_long (long value)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// создать обёртку вокруг bool
	static Variant* make_bool (bool value)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// создать обёртку вокруг IString
	static Variant* make_string (GCI::IO::String* value)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// создать обёртку вокруг объекта
	static Variant* make_object (Core::IObject* value)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Список языков
typedef std::vector < Core::Box<Languages> > LanguagesList;

// контейнер строк
typedef std::vector < GCI::IO::String_var > StringList;

// Произошла внутреняя ошибка при обращении к базе
class InternalDatabaseError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// выбрасывается из методов, которые могут дергаться только в контексте сессии, т.е. после логина
class NoSession : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Элемент с таким именем уже существует, а два и более созадвать нельзя
class DuplicateName : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// идентификатор пользователя или группы
typedef long Uid;

enum ListNodeType {
	LNT_SUB // Саб
	, LNT_PARA // Параграф
	, LNT_EXTERNAL_OBJECT // Объект, открываемый во внешнем приложении
	, LNT_EXTERNAL_LINK
	, LNT_DOCUMENT_ABOLISHED // Утративший силу документ
	, LNT_DOCUMENT_ACTIVE // Документ
	, LNT_DOCUMENT_PREACTIVE // Не вступивший в силу документ
	, LNT_DOCUMENT_UNKNOWN // Неизвестный тип
	, LNT_EDITION_ABOLISHED // Утратившая силу редакция
	, LNT_EDITION_ACTIVE // Актуальная редакция
	, LNT_EDITION_PREACTIVE // Редакция, которая еще не действует
	, LNT_EDITION_UNKNOWN // Неизвестный тип редакции
	, LNT_EDITIONS_GROUP // Узел Редакции
	, LNT_BLOCK // Блок
	, LNT_DRUG_ANNULED // препарат аннулирован
	, LNT_DRUG_NARCOTIC // наркотический препарат
	, LNT_DRUG_NONANNULED_NONNARCOTIC // разрешённый ненаркотический препарат
	, LNT_FORM_ANNULED // аннулированная форма препарата
	, LNT_FORM_RUSSIAN_IMPORTANT // жизненноважный российский препарат
	, LNT_FORM_NONRUSSIAN_IMPORTANT // жизненноважный иностранный препарат
	, LNT_FORM_RUSSIAN_NONIMPORTANT // российский препарат
	, LNT_FORM_NONRUSSIAN_NONIMPORTANT // иностранный препарат
	, LNT_FIRM // Фирма
	, LNT_AAK // Документ ААК
};

// Это создал Шура, т.к. были коллизии с модулем ActiveX и его ObjectId в модуле Document
typedef ObjectId BaseTypesObjectId;

static const unsigned long long ALL_DOCUMENTS_KIND = -1;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::SearchEntity> {
	typedef GblAdapterLib::SearchEntityFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Variant> {
	typedef GblAdapterLib::VariantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
