//
// RefFilter.h : header file
//

#ifndef __REF_FILTER_H
#define __REF_FILTER_H

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"
#include "Helpers.h"

namespace EndtTools {

	class RefFilter_i
		: virtual public GeneratorData
		, virtual public evd::EeGenerator_i {
	public:
		RefFilter_i (
			evd::UserWriter* writer
			, GeneratorHelper* helper
			, const ParaInfo* info
			, bool is_no_doc
		);

		virtual ~RefFilter_i ();

		void add ();

		// IeeGenerator implementation

		virtual void Finish (bool is_need_undo = false);
		virtual void StartChild (long tag_id);
		virtual void AddIntegerAtom (long tag_id, long value);
		virtual void AddStringAtom (long tag_id, const char* buf, long len = 0xffffffff, long code_page = 0x0);

	private:
		bool m_is_no_doc;

		size_t m_skip_finish;
	};

	class RefFilter2_i
		: virtual public GeneratorData
		, virtual public evd::EeGenerator_i {
	public:
		RefFilter2_i (
			evd::UserWriter* writer
			, GeneratorHelper* helper
			, const ParaInfo* info
			, bool is_no_doc
		);

		virtual ~RefFilter2_i ();

		void add ();

		// IeeGenerator implementation

		virtual void Finish (bool is_need_undo = false);
		virtual void StartChild (long tag_id);
		virtual void AddIntegerAtom (long tag_id, long value);
		virtual void AddStringAtom (long tag_id, const char* buf, long len = 0xffffffff, long code_page = 0x0);

	private:
		bool m_is_no_doc;

		size_t m_skip_finish;
	};

} // namespace 

#endif	// __REF_FILTER_H
