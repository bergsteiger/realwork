//
// DBComm.h : header file
//

#ifndef __GKDB_COMM_H
#define __GKDB_COMM_H

#include "shared/DB/DBCore/DBCore.h"
#include "base.h"

namespace DBCore {

	struct DBFactory {
		static IBase* make (Base* base);
	};
} // namespace DBCore

#endif // __GKDB_COMM_H