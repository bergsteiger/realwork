#pragma once

#include "shared/postgres/helpers/ConnectionPool.h"

namespace postgres {

template<class Transactor>
void execute (const Transactor& tr) {
	ConnectionGrabber connection;
	connection->perform (tr);
}

}
