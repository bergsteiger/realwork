//
// Interfaces.h : header file
//

#ifndef __INTERFACES_H__
#define __INTERFACES_H__

#include "shared/Core/mng/Var.h"

namespace EndtConvertor {

	enum ConvertType { 
		ct_None
		, ct_All
		, ct_Docs
		, ct_Doc 
		, ct_From
	};

	struct Properties {
		Properties () : thr_count (2) {
		}

		std::string path_src;
		std::string path_dst;
		std::string path_editions;
		std::string path_pics;

		size_t thr_count;
	};

	class IConvertor 
		: virtual public Core::IObject {
	public:
		virtual void convert (unsigned long doc_id) = 0;
		virtual void convert (ConvertType type) = 0;
		virtual void convert_from (unsigned long doc_id) = 0;
	};

	typedef Core::Var <IConvertor> IConvertor_var;

	struct IConvertorFactory {
		static IConvertor* make (const Properties& prop);
	};

} // namespace

#endif // !defined(__INTERFACES_H__)