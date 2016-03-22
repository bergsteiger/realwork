////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/SearchStream.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::SearchStream
//
// Класс для поиска данных в открытом стриме
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_SEARCHSTREAM_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_SEARCHSTREAM_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/DB/DBCore/DBCore.h"

namespace ContextSearch {

// Класс для поиска данных в открытом стриме
class SearchStream {
	SET_OBJECT_COUNTER (SearchStream)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Кэш
	struct DataCache {
		// id
		DBCore::DocId id;
		// has_block
		bool has_block;
		// data
		Relevancy::Positions data;
		DataCache () : id(0) {
			//#UC START# *5413012C012B_DEF_INIT_CTOR*
			//#UC END# *5413012C012B_DEF_INIT_CTOR**cpp*
		}
	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// сравнение позиций
	static bool compare_mask_less (unsigned long x, unsigned long y);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	SearchStream (const std::string& key, DBComm::IStreamsFactory* factory, unsigned long flags);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// счетчик ссылок
	void add_ref ();

	// добавить данные в вектор позиций
	void fill_positions (
		Relevancy::Positions& data
		, DBComm::DocId doc_id
		, bool& has_block
		, const DBCore::ExtrPair& extr
	);

	// длина порции данных с позициями
	size_t get_data_len (DBComm::DocId doc_id) const;

	// поиск документа
	DBComm::DocId get_next (DBComm::DocId start_id);

	// проверка на валидность открытия стрима
	const bool is_valid () const;

	// оператор
	bool operator == (DBComm::DocId doc_id) const;

	// получить позицию прогресс-индикатора
	unsigned long progress_tell () const;

	// поиск документа
	bool search (DBComm::DocId doc_id);

	// получить длину стрима
	const unsigned long stream_length () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBCore::Ref_ m_cache;

	size_t m_count;

	DataCache m_data;

	bool m_is_bad;

	Core::Box<DBCore::StreamsPair> m_pair;
}; // class SearchStream

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_SEARCHSTREAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

