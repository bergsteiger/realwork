#include "shared/Core/sys/std_inc.h"

#include "shared/Core/sys/assert.h"
#include "shared/Core/sys/Logs.h"
#include "shared/Core/Params/Params.h"

#include "shared/postgres/helpers/ConnectionPool.h"

namespace postgres {

PostgresInitParams read_postgres_params_from_ini () {
	const size_t default_pool_size = 10;

	PostgresInitParams result;
	result.pool_size = Core::ParamManagerFactory::get ().get_long ("-PostgresConnectionCount", default_pool_size);
	result.connection_options = Core::ParamManagerFactory::get ().get_string ("-PostgresInitParams");

	return result;
}


ConnectionPool::ConnectionPool () {
}

ConnectionPool& ConnectionPool::get () {
	static ConnectionPool pool;
	return pool;
}


void ConnectionPool::init (PostgresInitializer init) {
	ConnectionPool::get ().init (init ());
}

void ConnectionPool::init (const PostgresInitParams& params) {
	if (m_connections.size ()) {
		throw std::logic_error ("postgres connection pool has been already inited");
	}
	GDS_ASSERT (m_free_connections.empty ());
	m_connections_semaphore.reset (new ACE_Thread_Semaphore {params.pool_size});

	m_connections.reserve (params.pool_size);
	m_free_connections.reserve (params.pool_size);

	try {
		for (size_t i = 0; i < params.pool_size; ++i) {
			m_connections.push_back (new pqxx::connection {params.connection_options});
			m_free_connections.push_back (&m_connections.back ());
		} 
	} catch (std::exception& ex) {
		LOG_E (("%s: %s", GDS_CURRENT_FUNCTION, ex.what ()));
		throw;
	}
}


void ConnectionPool::reinit (const PostgresInitParams& params) {
	// ждём освобождения соединений
	while (m_connections.size() > m_free_connections.size()) {
		LOG_D(("%s: waiting for database", GDS_CURRENT_FUNCTION));
		ACE_OS::sleep(1);
	}
	// разрываем соединения со старой базой
	m_connections.clear ();
	m_free_connections.clear ();
	//открываем новые соединения
	init (params);
}

ConnectionPool::~ConnectionPool () {
	// по-хорошему при завершении приложения вся работа с базой должна быть закончена
	GDS_ASSERT (m_connections.size () == m_free_connections.size ());

	// ждём освобождения соединений
	while (m_connections.size () > m_free_connections.size ()) {
		LOG_D (("%s: waiting for database", GDS_CURRENT_FUNCTION));
		ACE_OS::sleep (1);
	}
}

pqxx::connection* ConnectionPool::grab_connection () {
	GDS_ASSERT (m_connections_semaphore.get ());
	
	m_connections_semaphore->acquire ();
	GUARD (m_vector_operations_mutex);

	GDS_ASSERT (m_free_connections.size ());
	pqxx::connection* connection = m_free_connections.back ();
	m_free_connections.pop_back ();
	return connection;
}

void ConnectionPool::free_connection (pqxx::connection* connection) {
	GUARD (m_vector_operations_mutex);

	m_free_connections.push_back (connection);
	m_connections_semaphore->release ();
}

}
