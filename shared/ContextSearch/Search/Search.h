////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Search/Search.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Search
//
// Интерфейсы и типы для алгоритмов контекстного поиска.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_H__

#include "shared/Core/sys/std_inc.h"
#include <set>
#include <vector>
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/Morpho/Def/Def.h"

namespace ContextSearch {
namespace Search {

// Фраза (пословно)
typedef std::vector < std::string > Phrase;

#pragma pack (push, 1)

// Настройки алгоритма морфо-поиска
struct AlgorithmProperties {
	// поле флагов
	unsigned long flags;
	// фабрика стримов
	DBComm::IStreamsFactory* factory;
	// максимальная длина фрагмента
	size_t max_fragment;
	// нормализатор
	Morpho::Def::INormalizer* normalizer;
	// сборщик инфы о расчете релевантности
	Defs::IRelevancyInfo* collector;
	// коммуникатор
	DBComm::IDBCommunicator* comm;
	// генератор для wildcard
	DBComm::IWildCard* wild_mng;
	AlgorithmProperties ()
		: flags(0)
		, factory(0)
		, max_fragment(0)
		, normalizer(0)
		, collector(0)
		, comm(0)
		, wild_mng(0)
	{
		//#UC START# *49FEC0BB02CC_DEF_INIT_CTOR*
		//#UC END# *49FEC0BB02CC_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *49FEC0BB02CC*
	AlgorithmProperties (const AlgorithmProperties& copy) {
		flags = copy.flags;
		factory = copy.factory;
		max_fragment = copy.max_fragment;
		normalizer = copy.normalizer;
		collector = copy.collector;
		comm = copy.comm;
		wild_mng = copy.wild_mng;
	}
	//#UC END# *49FEC0BB02CC*
};

#pragma pack (pop)

// Константы алгоритма морфо-поиска
static const size_t RESERVE_SIZE = 1024; // размер резервирования
static const size_t WORDS_LIMIT = 10; // максимальное количество слов запроса
static const size_t PROGRESS_DOCS1000 = 2000; // количество итераций, через которое прогресс-индикатор пытается изменить свое состояние

#pragma pack (push, 1)

// Пара id
struct DocIdPair {
	// минимальный id документа
	DBComm::DocId min_id;
	// максимальный id документа
	DBComm::DocId max_id;
};

#pragma pack (pop)

// Значения битов-свойств
static const unsigned long SP_TITLES = 0x0001; // искать позиции в заголовках
static const unsigned long SP_IGNORE_CACHE = 0x0002; // отключение кэша стримов
static const unsigned long SP_STRONG_DEFLATE = 0x0004; // сокращение размерности для строгих фраз

// Селектор для фабрики поискового алгоритма
enum AlgorithmSelector {
	as_Partial // as_Partial
	, as_Default // as_Default
	, as_Simple // as_Simple
};

#pragma pack (push, 1)

// Фрагменты
struct FragmentsPair {
	// обычные фрагменты
	Core::Box<Relevancy::Fragments> data;
	// фрагменты приписанные к блокам
	Core::Box<Relevancy::Fragments> block_data;
};

#pragma pack (pop)

// Контейнер для найденных (удовлетворяющих запросу) документов
typedef Defs::RelevancyDocuments RelevancyDocuments;

// Сортированный список ключей-лексем
typedef std::set < std::string > StringSet;

// Расширенная фраза
typedef std::vector < StringSet > PhraseEx;

class IWorker;
typedef ::Core::Var<IWorker> IWorker_var;
typedef ::Core::Var<const IWorker> IWorker_cvar;
// Интерфейс для вычисление релевантности документа в параллельном потоке
class IWorker
	: virtual public ::Core::IObject
{
public:
	// инициализация
	virtual void init (Relevancy::IAlgorithm* alg) = 0;

	// вернуть результат
	virtual RelevancyDocuments* _retn () = 0;

	// добавить задачу на расчет релевантности заданного документа
	virtual void add (DBComm::DocId doc_id) = 0;

	// завершить поток
	virtual void shutdown () = 0;
};

/// factory interface for IWorker
class IWorkerFactory {
public:
	// фабрика
	static IWorker* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// Запрос по частям
struct SplitRequest {
	// данные поискового запроса
	Relevancy::Data data;
	// контекст
	Phrase context;

	SplitRequest (const SplitRequest& copy);

	SplitRequest& operator = (const SplitRequest& copy);
	//#UC START# *49CCFF74015A*
	SplitRequest () {
	}

	bool operator < (const SplitRequest& val) const {
		return (context.size () < val.context.size ());
	}

	bool operator == (const SplitRequest& val) const {
		return (context.size () == val.context.size () && data == val.data);
	}
	//#UC END# *49CCFF74015A*
};

#pragma pack (pop)

#pragma pack (push, 1)

// Расширенный поисковый запрос
struct RequestEx {
	// контест
	PhraseEx context;
	// данные поискового запроса
	Relevancy::Data data;
};

#pragma pack (pop)

// Прерывание поиска пользователем
class CanceledByUser : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Вектор поисковых запросов
typedef std::vector < SplitRequest > SplitRequests;

// Вектор расширенных поисковых запросов
typedef std::vector < RequestEx > RequestsEx;

// Фразы
typedef std::vector < Phrase > Phrases;

class IRequestView;
typedef ::Core::Var<IRequestView> IRequestView_var;
typedef ::Core::Var<const IRequestView> IRequestView_cvar;
// Представление контекстного запроса
class IRequestView
	: virtual public ::Core::IObject
{
public:
	// спаны
	virtual const Phrases& get_spans () const = 0;

	// список синонимичных
	virtual const SplitRequests& get_sequence () const = 0;

	// тип
	virtual AlgorithmSelector get_type () const = 0;

	// создать
	virtual bool build (const Phrase& in, const std::string& src) = 0;
};

/// factory interface for IRequestView
class IRequestViewFactory {
public:
	typedef std::vector<AlgorithmSelector> KeySet;
	
	static KeySet* keys ();
public:
	// фабрика
	static IRequestView* make (
		DBComm::IDBCommunicator* comm
		, Morpho::Def::INormalizer* normalizer
	, AlgorithmSelector key
	) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Длины блоков приписанных к позициям из невидимого текста
typedef Defs::InvisibleBlocks InvisibleBlocks;

class IAlgorithm;
typedef ::Core::Var<IAlgorithm> IAlgorithm_var;
typedef ::Core::Var<const IAlgorithm> IAlgorithm_cvar;
// Интерфейс алгоритма морфо-поиска
class IAlgorithm
	: virtual public ::Core::IObject
{
public:
	// список релевантных фрагментов
	virtual Defs::Fragments* get_fragments (DBComm::DocId doc_id, const Defs::InvisibleBlocks& blocks) = 0;

	// поиск
	virtual void search (Defs::IResCollector* collector, Defs::IFilter* filter) = 0;
};

/// factory interface for IAlgorithm
class IAlgorithmFactory {
public:
	typedef std::vector<AlgorithmSelector> KeySet;
	
	static KeySet* keys ();
public:
	// фабрика
	static IAlgorithm* make (
		IRequestView* view
		, DBComm::IProgress* progress
		, const AlgorithmProperties& properties
	, AlgorithmSelector key
	) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Фильтр
typedef Defs::IFilter IFilter;
typedef Defs::IFilter_var IFilter_var;
typedef Defs::IFilter_cvar IFilter_cvar;

// Коллектор для результата поиска
typedef Defs::IResCollector IResCollector;
typedef Defs::IResCollector_var IResCollector_var;
typedef Defs::IResCollector_cvar IResCollector_cvar;

// Не совпадает количество спанов
class InvalidSpans : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} // namespace Search
} // namespace ContextSearch

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <ContextSearch::Search::IWorker> {
	typedef ContextSearch::Search::IWorkerFactory Factory;
};
template <>
struct TypeTraits <ContextSearch::Search::IRequestView> {
	typedef ContextSearch::Search::IRequestViewFactory Factory;
};
template <>
struct TypeTraits <ContextSearch::Search::IAlgorithm> {
	typedef ContextSearch::Search::IAlgorithmFactory Factory;
};
} // namespace Core


#endif //__SHARED_CONTEXTSEARCH_SEARCH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
