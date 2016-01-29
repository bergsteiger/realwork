////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/Searcher.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::Searcher
//
// Searcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_SEARCHER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_SEARCHER_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/MorphoBase/SearchStream.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/DB/DBCore/DBCore.h"

//#UC START# *4F313B660191_CUSTOM_INCLUDES*
//#UC END# *4F313B660191_CUSTOM_INCLUDES*

namespace ContextSearch {

// Searcher
class Searcher {
	SET_OBJECT_COUNTER (Searcher)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Контейнер для хранения открытых стримов всех искомых словоформ
	typedef std::vector < SearchStream* > StreamPointers;

	// Константы
	static const size_t GREAT_RESERVE_SIZE; // размер для резервирования

public:
	// Элемент кэша
	struct CacheNode {
		// ключ
		std::string key;
		// стрим
		SearchStream* stream;
	};

	// Кэш стримов
	typedef std::vector < CacheNode > StreamsCache;

	// StreamDestroy
	struct StreamDestroy : public std::unary_function<CacheNode, void> {
		void operator () (CacheNode& param_) const;
	};

private:
	// Вектор стримов
	typedef std::vector < StreamPointers > Streams;



//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// сравнение масок
	static bool compare_mask_equal (unsigned long x, unsigned long y);

	// получить пару (min и max) следующих после start_id и удовлетворяющий запросу документов, для
	// открытых по каждому ключу стримов
	static void get_next_pair (Search::DocIdPair& pair, StreamPointers& sp, DBComm::DocId start_id);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit Searcher (const Search::AlgorithmProperties& properties);

public:
	~Searcher ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// добавить
	bool add (const std::string& str, size_t i);

	// позиции слов фразы для заданного документа
	bool get_data (Relevancy::DataVector& result, DBComm::DocId doc_id, bool& has_block);

	// позиции слов фразы для заданного документа
	bool get_data (
		Relevancy::DataVector& result
		, DBComm::DocId doc_id
		, bool& has_block
		, size_t offset
		, DBCore::ExtrPair& extr
	);

	// количество минимальных вхождений
	size_t get_min_size (DBComm::DocId doc_id, size_t& pos);

	// искать следующий документ
	DBComm::DocId get_next (DBComm::DocId border);

	// значение для прогресс-индикатора
	size_t get_prog_value ();

	// предварительная загрузка
	bool prev_load (
		Relevancy::DataVector& result
		, DBComm::DocId doc_id
		, bool& has_block
		, size_t offset
		, DBCore::ExtrPair& extr
	);

	// поиск заданного документа
	bool search (DBComm::DocId id);

	// инициализация
	void set (const Search::PhraseEx& in);

	// инициализация
	bool set (const Search::Phrase& in);

private:
	// добавить стрим
	bool add_stream (const std::string& norma, const std::string& forma, StreamPointers& streams);

	// получить позиции для лексемы
	bool get_data (
		Relevancy::Positions& out
		, StreamPointers& streams
		, DBComm::DocId doc_id
		, bool& has_block
		, const DBCore::ExtrPair& extr
	);

	// сброс кэшей
	void reset ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	StreamsCache m_cache;

	size_t m_offset;

	Search::DocIdPair m_pair;

	size_t m_pos;

	Search::AlgorithmProperties m_properties;

	Streams m_streams;

//#UC START# *4F313B660191*
//#UC END# *4F313B660191*
}; // class Searcher

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_SEARCHER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

