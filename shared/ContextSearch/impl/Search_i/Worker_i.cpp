////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/Worker_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::Worker_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Search_i/Worker_i.h"

//#UC START# *506D86CE01E0_CUSTOM_INCLUDES*
#include "shared/ContextSearch/RelevancyCore/DebugInfo.h"
//#UC END# *506D86CE01E0_CUSTOM_INCLUDES*

namespace ContextSearch {
namespace Search_i {

//#UC START# *506D86CE01E0*
//#UC END# *506D86CE01E0*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const size_t Worker_i::POOL_SIZE = 64; // размер пула

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Worker_i::Worker_i ()
//#UC START# *506D833C002E_506D84540001_506D86CE01E0_BASE_INIT*
	: m_shutdown (false)
	, m_head (0)
	, m_tail (0)
	, m_lock (0)
	, m_counter (0)
#if !defined (__Linux__) && !defined (__FreeBSD__) && !defined(__APPLE__)
	, m_thread (boost::thread (boost::bind (&Worker_i::thr_func, this)))
#endif
//#UC END# *506D833C002E_506D84540001_506D86CE01E0_BASE_INIT*
{
	//#UC START# *506D833C002E_506D84540001_506D86CE01E0_BODY*
	//#UC END# *506D833C002E_506D84540001_506D86CE01E0_BODY*
}

Worker_i::~Worker_i () {
	//#UC START# *506D86CE01E0_DESTR_BODY*
	this->shutdown ();
	//#UC END# *506D86CE01E0_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// расчет релевантности
void Worker_i::execute (Task& task) {
	//#UC START# *506D9AB803D5*
	/*
	DBComm::IDBCommunicator* comm = DBComm::ICacheFactory::instance ().get_ptr ();

	const Defs::InvisibleBlocks& blocks = comm->get_invisible_blocks ();
	const Defs::InvisibleRel& rel_data = comm->get_invisible_rel ();

	static const Defs::InvisibleBlocks blocks;
	static const Defs::InvisibleRel rel_data;

	static const Defs::InvisibleData def;
	static const Defs::PositionsRel rel_def;

	//Core::Aptr <DebugInfo> di = (DebugInfo*) DebugInfo::make (task.doc_id == 135841, m_algorithm);

	Defs::RelevancyDocInfo at;
	Defs::InvisibleBlocks::const_iterator it = blocks.find (task.doc_id);
	Defs::InvisibleRel::const_iterator rel_it = rel_data.find (task.doc_id);

	m_algorithm->get_relevancy_info (
		at.info
		, task.data
		, m_searcher->get_identical ()
		, (it != blocks.end ())? it->second : def
		, (rel_it != rel_data.end ())? rel_it->second : rel_def
		, task.has_block
	);

	if (at.info.relevancy_value > 0) {
		at.doc_id = task.doc_id;
		m_data->push_back (at);
	}
	*/
	//#UC END# *506D9AB803D5*
}

// функция потока
void Worker_i::thr_func () {
	//#UC START# *506D99970203*
	while (true) {
		if (m_counter == 0) {
#if !defined(__APPLE__)
			boost::mutex::scoped_lock lock (m_mutex);
#endif
			if (m_shutdown) {
				return;
			}

			if (m_counter == 0) {
				m_lock = 1;
#if !defined(__APPLE__)
				m_condition.wait (lock);
#endif
				m_lock = 0;
			}
		} else {
			this->execute (m_pool [m_head]);
			if (m_head == POOL_SIZE - 1) {
				m_head = 0;
			} else {
				++m_head;
			}
			--m_counter;
		}
	}
	//#UC END# *506D99970203*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Search::IWorker
// вернуть результат
Search::RelevancyDocuments* Worker_i::_retn () {
	//#UC START# *506D84ED016B_506D86CE01E0*
#if !defined(__APPLE__)
	{
		boost::mutex::scoped_lock lock (m_mutex);
		if (m_lock == 1) {
			m_condition.notify_one ();
		}
	}

	while (m_counter != 0) {
		ACE_OS::sleep (0);
	}
#endif
	return m_data._retn ();
	//#UC END# *506D84ED016B_506D86CE01E0*
}

// implemented method from Search::IWorker
// добавить задачу на расчет релевантности заданного документа
void Worker_i::add (DBComm::DocId doc_id) {
	//#UC START# *506D858202CC_506D86CE01E0*
#if !defined(__APPLE__)
	{
		boost::mutex::scoped_lock lock (m_mutex);
		if (m_lock == 1 && m_counter.value () > 8) {
			m_condition.notify_one ();
		}
	}
#endif

	while (true) {
		if (m_counter.value () < (unsigned long) (POOL_SIZE - 4)) {
			Task& item = m_pool [m_tail];

			item.has_block = false;
			item.doc_id = doc_id;

			/*
			if (m_searcher->get_data (item.data, doc_id, item.has_block)) {
				if (m_tail == POOL_SIZE - 1) {
					m_tail = 0;
				} else {
					++m_tail;
				}

				++m_counter;
			}
			*/

			break;
		} else {
			ACE_OS::sleep (0);
		}
	}
	//#UC END# *506D858202CC_506D86CE01E0*
}

// implemented method from Search::IWorker
// инициализация
void Worker_i::init (Relevancy::IAlgorithm* alg) {
	//#UC START# *506D84BF02E3_506D86CE01E0*
	GDS_ASSERT (m_counter == 0 && m_head == m_tail && m_data.is_nil ());

	m_algorithm = alg;
	//m_searcher = searcher;

	m_data = new Search::RelevancyDocuments ();
	m_data->reserve (Search::RESERVE_SIZE);

	Pool pool;
	pool.resize (POOL_SIZE);
	pool.swap (m_pool);

	m_head = 0;
	m_tail = 0;
	//#UC END# *506D84BF02E3_506D86CE01E0*
}

// implemented method from Search::IWorker
// завершить поток
void Worker_i::shutdown () {
	//#UC START# *506D85C602E6_506D86CE01E0*
#if !defined(__APPLE__)
	{
		boost::mutex::scoped_lock lock (m_mutex);
		m_shutdown = true;
		m_condition.notify_one ();
	}

	m_thread.join ();
#endif
	//#UC END# *506D85C602E6_506D86CE01E0*
}
} // namespace Search_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

