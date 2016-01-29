//
// IsVersionComment.h : header file
//

#ifndef __IS_VERSION_COMMENT_H
#define __IS_VERSION_COMMENT_H

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"

namespace EndtTools {

	class VersionInfoIsFound: public ::Core::Exception {
	private:
		const char* uid () const /*throw ()*/ {
			return 0;
		}
	};

	struct IsVersionCommentFactory {
		static evd::IeeGenerator* make (bool& value);
	};

} // namespace 

#endif	// __IS_VERSION_COMMENT_H
