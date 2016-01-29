////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/SpanQuery.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Search_i::SpanQuery
//
// SpanQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_I_SPANQUERY_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_I_SPANQUERY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/MorphoBase/Searcher.h"

namespace ContextSearch {
namespace Search_i {

// SpanQuery
class SpanQuery {

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// Статус
	enum SpanStatus {
		st_None // Ничего
		, st_Load // Загружен
		, st_Bad // Плохой
		, st_PrevLoad // Частично загружен
	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// сравнение позиций
	static bool compare_mask_less (unsigned long x, unsigned long y);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	SpanQuery (const std::string& key, const Search::AlgorithmProperties& prop);

public:
	~SpanQuery ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// добавить ключ к контексту
	void add_to (std::string& context);

	// проверка на валидность
	bool check (DBComm::DocId doc_id) const;

	// очистить кэш
	void clear ();

	// данные
	const Relevancy::DataVector& get () const;

	// первые инициализированные
	const Relevancy::Positions& get_first () const;

	// ключ
	const std::string& get_key () const;

	// поиск
	DBComm::DocId get_next (DBComm::DocId border);

	// вычислить значение для прогресс-индикатора
	size_t get_prog_value ();

	// размер
	size_t get_size () const;

	// атрибут для сортировки
	size_t get_sort_attr (DBComm::DocId doc_id);

	// инкремент
	void inc ();

	// проверка на загруженность
	bool is_load () const;

	// загрузка позиций
	bool load (DBComm::DocId doc_id, DBComm::ExtrPair& extr, long offset, bool& has_block);

	// оператор
	bool operator == (DBComm::DocId doc_id) const;

	// оператор
	bool operator == (const std::string& key) const;

	// предварительная загрузка
	bool prev_load (DBComm::DocId doc_id, DBComm::ExtrPair& extr, long offset, bool& has_block);

	// поиск документа
	bool search_doc (DBComm::DocId id);

private:
	// сжатие строгой фразы
	bool deflate ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	unsigned short m_count;

	Relevancy::DataVector m_data;

	Relevancy::DataVector m_deflate_data;

	bool m_deflated;

	DBComm::ExtrPair m_extr;

	bool m_has_block;

	DBComm::DocId m_id;

	Relevancy::IndexChain m_index;

	std::string m_key;

	std::string m_new_key;

	size_t m_offset;

	size_t m_pos;

	Core::Box<Searcher> m_searcher;

	size_t m_size;

	SpanStatus m_status;
}; // class SpanQuery

} // namespace Search_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_I_SPANQUERY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

