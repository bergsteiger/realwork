////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Search_i/Worker_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::Worker_i
// ��������� ���������� ������ �������� ��� ��������� IWorker
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_I_WORKER_I_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_I_WORKER_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

//#UC START# *506D86CE01E0_CUSTOM_INCLUDES*
#if !defined(__APPLE__)
#include <boost/thread.hpp>
#endif
//#UC END# *506D86CE01E0_CUSTOM_INCLUDES*

namespace ContextSearch {
namespace Search_i {

class Worker_i; // self forward Var
typedef ::Core::Var<Worker_i> Worker_i_var;
typedef ::Core::Var<const Worker_i> Worker_i_cvar;

class Worker_i_factory;

class Worker_i:
	virtual public Search::IWorker
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Worker_i)
	friend class Worker_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ������ �� ������ �������������
	struct Task {
		// ����� �����
		bool has_block;
		// ������������� ���������
		DBComm::DocId doc_id;
		// ������ ������� ������
		Relevancy::DataVector data;
	};

	// ��� �����
	typedef std::vector < Task > Pool;

	// ���������
	static const size_t POOL_SIZE; // ������ ����

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Worker_i ();

	virtual ~Worker_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������ �������������
	void execute (Task& task);

	// ������� ������
	void thr_func ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ��������
	Relevancy::IAlgorithm* m_algorithm;

	// ������� ��������� � ����������� ������� �����
	Core::AtomicOp<long> m_counter;

	// "������" ������������ �������
	size_t m_head;

	// ������� ������� ������
	Core::AtomicOp<long> m_lock;

	// ��� (����������� ������) �����
	Pool m_pool;

	// ������� ���������� ������
	bool m_shutdown;

	// �����" ������������ �������
	size_t m_tail;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Search::IWorker
	// ������� ���������
	virtual Search::RelevancyDocuments* _retn ();

	// implemented method from Search::IWorker
	// �������� ������ �� ������ ������������� ��������� ���������
	virtual void add (DBComm::DocId doc_id);

	// implemented method from Search::IWorker
	// �������������
	virtual void init (Relevancy::IAlgorithm* alg);

	// implemented method from Search::IWorker
	// ��������� �����
	virtual void shutdown ();

//#UC START# *506D86CE01E0*
#if !defined(__APPLE__)
    boost::mutex m_mutex;
	boost::condition_variable m_condition;
	boost::thread m_thread;
#endif

	Core::Aptr <Search::RelevancyDocuments> m_data;
//#UC END# *506D86CE01E0*
}; // class Worker_i

} // namespace Search_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_I_WORKER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
