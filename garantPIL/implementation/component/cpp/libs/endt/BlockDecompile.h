//
// BlockDecompile.h : header file
//

#ifndef __BLOCK_DECOMPILE_H
#define __BLOCK_DECOMPILE_H

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"

namespace EndtTools {

	struct BlockDecompileFactory {
		static evd::IeeGenerator* make (std::string& value);
	};

} // namespace 

#endif	// __BLOCK_DECOMPILE_H
