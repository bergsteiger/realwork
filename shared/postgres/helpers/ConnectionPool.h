#ifndef POSTGRES_CONNECTION_POOL_H_INCLUDED
#define POSTGRES_CONNECTION_POOL_H_INCLUDED

#include <vector>

#include "boost/function.hpp"
#include "boost/ptr_container/ptr_vector.hpp"

#include "ace/Singleton.h"
#include "ace/Thread_Semaphore.h"
#include "ace/Synch_Traits.h"

#include "pqxx/pqxx"

#include "shared/Core/sys/synch.h"

namespace postgres {

struct PostgresInitParams {
	unsigned int pool_size;
	std::string connection_options;
};

typedef boost::function<PostgresInitParams ()> PostgresInitializer;
PostgresInitParams read_postgres_params_from_ini ();

class ConnectionPool {
	friend struct ConnectionPoolInit;
	friend class ConnectionGrabber;

public:
	static void init (PostgresInitializer = read_postgres_params_from_ini); // должен быть вызван 1 раз до первого обращения к пулу
	void reinit(const PostgresInitParams& params); //переинициализировать для тестовой базы

	static ConnectionPool& get ();

private:
	ConnectionPool ();
	~ConnectionPool ();
	ConnectionPool (const ConnectionPool&) = delete;
	ConnectionPool& operator= (const ConnectionPool&) = delete;

	void init (const PostgresInitParams& params);
	
	pqxx::connection* grab_connection ();
	void free_connection (pqxx::connection* connection);

private:
	boost::ptr_vector<pqxx::connection> m_connections;
	std::vector<pqxx::connection*> m_free_connections;

	std::unique_ptr<ACE_Thread_Semaphore> m_connections_semaphore;
	Core::Mutex m_vector_operations_mutex;
};

class ConnectionGrabber {
public:
	ConnectionGrabber () : m_connection (ConnectionPool::get ().grab_connection ()) {
	}

	pqxx::connection* operator-> () {
		return m_connection;
	}

	~ConnectionGrabber () {
		ConnectionPool::get ().free_connection (m_connection);
	}

private:
	pqxx::connection* m_connection;
};

}

#endif
