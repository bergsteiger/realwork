//
// Convertor.h : header file
//

#ifndef __CONVERTOR_H__
#define __CONVERTOR_H__

#include "shared/Core/sys/RefCountObjectBase.h"

#include "Interfaces.h"

namespace EndtConvertor {

	class Convertor_i
		: virtual public IConvertor 
		, virtual public Core::RefCountObjectBase {
	public:
		Convertor_i (const Properties& prop);

	public:
		// implemented method from IConvertor
		virtual void convert (unsigned long doc_id);

		// implemented method from IConvertor
		virtual void convert (ConvertType type);

		// implemented method from IConvertor
		virtual void convert_from (unsigned long doc_id);

	private:
		void convert (DocCollection* topics, size_t from);
	};

} // namespace

#endif // #ifndef __CONVERTOR_H__
