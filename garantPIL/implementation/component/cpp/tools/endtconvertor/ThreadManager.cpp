//
// ThreadManager.cpp : implementation file
//

#include "ace/ACE.h"

#include "ThreadManager.h"

namespace EndtConvertor {

ThreadManager::ThreadManager () : m_pos (0), m_count (0), m_progress (0) {
}

void ThreadManager::init (const std::string& path, size_t thr_count) {
	m_path = path;
	m_count = thr_count;
}

void ThreadManager::execute (ACE_THR_FUNC thr_func, void* arg, size_t from, EndtTools::ProcessIndicator* progress) {
	if (progress) {
		m_progress = progress;
	}

	m_pos = from;

	ACE_Thread_Manager* manager = ACE_Thread_Manager::instance ();

	std::vector <ACE_thread_t> thr_ids (m_count);

	for (size_t i = 0; i < m_count; ++i) {
		if (manager->spawn (thr_func, arg, THR_NEW_LWP | THR_JOINABLE, &thr_ids [i]) < 0) {
			throw std::exception ();
		}
	}

	for (size_t i = 0; i < m_count; ++i) {
		manager->join (thr_ids [i]);
	}
}

Base* ThreadManager::make () {
	GUARD (m_mutex);
	Core::Aptr <Base> ret = new YBase (m_path.c_str (), O_RDONLY);
	ret->IsOk ();
	return ret._retn ();
}

size_t ThreadManager::get_pos () {
	GUARD (m_mutex);
	if (m_progress) {
		m_progress->update_ (m_pos);
	}
	size_t ret = m_pos;
	++m_pos;
	return ret;
}

} // namespace

