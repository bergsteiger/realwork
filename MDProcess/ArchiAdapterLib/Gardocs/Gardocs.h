////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::ArchiAdapterLib::Gardocs
//
// Gardoc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCS_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "shared/GCI/IO/IO.h"

namespace ArchiAdapterLib {
namespace Gardocs {

// список строк
typedef std::vector < GCI::IO::String_var > StringList;

// тип образа
enum ImageType {
	giZIP
	, giTIF
	, giDOC
	, giRTF
	, giNSR
};

#pragma pack (push, 1)

// образ
struct Image {
	// данные
	GCI::IO::Stream_var data;
	// тип образа
	ImageType type;
	// название исчточника публикования
	GCI::IO::String_var src_title;
	// номер страницы в источнике публикования
	GCI::IO::String_var src_page;
	// номер исчтоника публикования
	GCI::IO::String_var src_number;
	// дата источника публикования (период)
	GCI::IO::DateTimeBox src_date_start;
	// дата источника публикования (период)
	GCI::IO::DateTimeBox src_date_end;
	// список пользовательских меток, проставленных юристами, метки могут означать что архивариусу
	// нужно поделать что-то дополнительно. Или не означать.
	StringList labels;
};

#pragma pack (pop)

// сетевая ошибка, попробуйте повторить минут через десять
class CommunicationFailure : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// имиджи
typedef std::vector < Image > ImageList;

enum GardocStatus {
	gsNEW
	, gsUPDATED
};

enum GarDocType {
	gtDoc
	, gtRelated
};

enum GarDocUrgency {
	guInVersion // в версию
	, guQuickly // срочный
	, guOrdinary // обычный
	, guUnknown // неизвестно
};

#pragma pack (push, 1)

// карточка документ
struct Gardoc {
	// тип (приказ, распоряжение и т.д)
	GCI::IO::String_var type;
	// номер
	GCI::IO::String_var number;
	// дата документа
	GCI::IO::DateTimeBox date;
	// список Органов Государственной Власти, принимавших документ
	StringList ogv_list;
	// название
	GCI::IO::String_var title;
	// номер регистрации в МЮ
	GCI::IO::String_var mu_number;
	// дата регистрации в МЮ
	GCI::IO::DateTimeBox mu_date;
	// блоки (белонгсы), перечесляются в сокращенном виде, например: GAR, LAN т.д.
	StringList blocks;
	// номер топика
	long long topic;
	// комментарий, юристы здесь пишут много разного для себя полезного, должно где-то показываться в
	// Архивариусе
	GCI::IO::String_var comment;
	// образ в zip-е, содержит ВСЕ файлы-образы данного документа, которые есть в К
	ImageList images;
	// номер запроса в К, который после префикса DPOUVS-
	long long confluence_id;
	GCI::IO::DateTimeBox timestamp;
	GardocStatus state;
	// если документ справка, то здесь передается текст справки, если нет, то пусто
	GCI::IO::String_var text;
	// топик справки
	long long related;
	// тип документа
	GarDocType gardoc_type;
	// срочность
	GarDocUrgency urgency;
	// флажок, что надо выложить на сайт, нужен для оперативной обработки таких документов
	bool is_internet;
};

#pragma pack (pop)

#pragma pack (push, 1)

// ArchiEvent
struct ArchiEvent {
	// тип
	GCI::IO::String_var type;
	Gardoc doc;
};

#pragma pack (pop)

// GardocList
typedef std::vector < Gardoc > GardocList;

class Searcher;
typedef ::Core::Var<Searcher> Searcher_var;
typedef ::Core::Var<const Searcher> Searcher_cvar;
// Searcher
class Searcher
	: virtual public ::Core::IObject
{
public:
	// возвращает список новых документов, зарегистрированных в К после date (date - время в
	// миллисекундах после 1 января 1970 года, т.е. стандартное)
	virtual GardocList* get_recently_created_since (
		const GCI::IO::DateTimeBox& date
		, const char* partnerId
	) const /*throw (
		CommunicationFailure
	)*/ = 0;

	virtual GardocList* get_top_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
	) const /*throw (
		CommunicationFailure
	)*/ = 0;

	virtual GardocList* get_notop_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
	) const /*throw (
		CommunicationFailure
	)*/ = 0;
};

/// factory interface for Searcher
class SearcherFactory {
public:
	// всегда возвращает один и тот же экземпляр
	static Searcher& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ArchiEventsListener;
typedef ::Core::Var<ArchiEventsListener> ArchiEventsListener_var;
typedef ::Core::Var<const ArchiEventsListener> ArchiEventsListener_cvar;
// ArchiEventsListener
class ArchiEventsListener
	: virtual public ::Core::IObject
{
public:
	// проинформировать К о наступлении события
	virtual void on_event (const ArchiEvent& event) const /*throw (CommunicationFailure)*/ = 0;
};

/// factory interface for ArchiEventsListener
class ArchiEventsListenerFactory {
public:
	static ArchiEventsListener& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Searcher2;
typedef ::Core::Var<Searcher2> Searcher2_var;
typedef ::Core::Var<const Searcher2> Searcher2_cvar;
class Searcher2
	: virtual public ::Core::IObject
{
public:
	virtual GardocList* get_top_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
	) const /*throw (
		CommunicationFailure
	)*/ = 0;

	virtual GardocList* get_notop_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
	) const /*throw (
		CommunicationFailure
	)*/ = 0;
};

/// factory interface for Searcher2
class Searcher2Factory {
public:
	static Searcher2* get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Utils;
typedef ::Core::Var<Utils> Utils_var;
typedef ::Core::Var<const Utils> Utils_cvar;
class Utils
	: virtual public ::Core::IObject
{
public:
	// Особенность работы сервера заключается в том что он сначало получает все документы с указанной
	// даты в реализации Searcher2::get_xxxx, а потом выкидывает лишнее (например фильтрует по
	// партнеру). Если время, которое подает клиент слишком старое, то фильрация может занимать
	// несколько десятков минут. Поэтому клиенту предлагается в случае, если ему на
	// Searcher2::get_xxxx не вернулся ни один документ, дернуть update_old_last_created_time и
	// результат запомнить у себя.
	// Сервер будет отнимать от текущего времени 30-ть минут и результат возвращать клиенту. Если
	// получившееся время старше входного параметра, то просто отдается time.
	virtual GCI::IO::DateTimeBox* update_old_last_created_time (
		const GCI::IO::DateTimeBox& date
	) const /*throw (
		CommunicationFailure
	)*/ = 0;
};

/// factory interface for Utils
class UtilsFactory {
public:
	static Utils* get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < long long > LongList;

class GardocGetter;
typedef ::Core::Var<GardocGetter> GardocGetter_var;
typedef ::Core::Var<const GardocGetter> GardocGetter_cvar;
class GardocGetter
	: virtual public ::Core::IObject
{
public:
	virtual GardocList* gardocs_by_topic_list (const LongList& topicList) const /*throw (CommunicationFailure)*/ = 0;

	virtual GardocList* gardocs_by_confluenceid_list (
		const LongList& confluenceidList
	) const /*throw (
		CommunicationFailure
	)*/ = 0;
};

/// factory interface for GardocGetter
class GardocGetterFactory {
public:
	static GardocGetter* get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Gardocs
} // namespace ArchiAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::Searcher> {
	typedef ArchiAdapterLib::Gardocs::SearcherFactory Factory;
};
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::ArchiEventsListener> {
	typedef ArchiAdapterLib::Gardocs::ArchiEventsListenerFactory Factory;
};
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::Searcher2> {
	typedef ArchiAdapterLib::Gardocs::Searcher2Factory Factory;
};
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::Utils> {
	typedef ArchiAdapterLib::Gardocs::UtilsFactory Factory;
};
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::GardocGetter> {
	typedef ArchiAdapterLib::Gardocs::GardocGetterFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
