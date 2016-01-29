//
// DocAnalyzer_i.h : header file
//

#ifndef __COMPILER__DOC_ANALYZER_I_H
#define __COMPILER__DOC_ANALYZER_I_H

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"

#include <deque>

namespace Compiler {

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// Анализатор документов в формате бинарного EVD

	class DocAnalyzer_i
		: virtual public evd::EeGenerator_i
		, virtual public Core::RefCountObjectBase {
	public:
		DocAnalyzer_i (void* endt_writer, size_t buf_size/*, IBaseWriter* base_writer*/);

		virtual ~DocAnalyzer_i ();

	public:
		// IeeGenerator implementation

		virtual void Finish (bool is_need_undo = false);

		virtual void StartChild (long type_id);

		virtual void StartDefaultChild ();

		virtual void StartTag (long tag_id);

		virtual void AddStringAtom (long tag_id, const char* buf, long len = 0xffffffff, long code_page = 0x0);

		virtual void AddIntegerAtom (long tag_id, long value);

		virtual void AddTransparentAtom (unsigned short index);

	private:
		struct TagInfo {
			bool flag;
			long type;
			long b_type;
			size_t id;

			TagInfo (bool flag_, long type_, long b_type_)
				: type (type_)
				, b_type (b_type_)
				, id (0)
				, flag (flag_) {
			}
		};

		/*
		typedef std::vector <SubInfo> SubsData;
		*/

	private:
		/*
		inline bool is_para () const {
			return (m_para_level && m_para_level <= m_stack.size () && m_skip_level == 0);
		}
		*/

		/*
		void reset ();
		void set_document (unsigned long doc_id);
		void write ();
		void add_sub (long type);
		void add_sub_id (long value);
		void add_ref_data (long tag_id, long value);
		*/

	private:
		/*
		void* m_writer;

		size_t m_id;
		size_t m_sub_id;
		size_t m_para_level;
		size_t m_skip_level;
		size_t m_ref_number;
		size_t m_para_counter;

		std::vector <SubInfo> m_subs;
		std::vector <RefInfo> m_refs;
		*/

		std::deque <TagInfo> m_stack;

		/*
		Core::Aptr <RefInfo> m_ref;
		*/
	};

} // namespace 

#endif // __COMPILER__DOC_ANALYZER_I_H
