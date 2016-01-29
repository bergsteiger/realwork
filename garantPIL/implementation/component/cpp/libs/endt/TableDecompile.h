//
// TableDecompile.h : header file
//

#ifndef __TABLE_DECOMPILE_H
#define __TABLE_DECOMPILE_H

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"

namespace EndtTools {

	struct TableDecompileFactory {
		static evd::IeeGenerator* make (std::string& value);
	};

} // namespace 

#endif	// __TABLE_DECOMPILE_H
