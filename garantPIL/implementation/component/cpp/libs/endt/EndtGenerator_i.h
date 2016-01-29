//
// EndtGenerator_i.h : header file
//

#ifndef __ENDT_GENERATOR_I_H
#define __ENDT_GENERATOR_I_H

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"
#include "Writers.h"

#include <deque>

namespace EndtTools {

	struct EndtWriteFunction;

	typedef std::map <long, GCL::StrVector> RequisiteData; // где ключ - id саба/блока

	typedef std::map <long, RequisiteData> Requisites;     // где ключ - id evd-тэга
	
	////////////////////////////////////////////////////////////////////////////////////////////////////
	// Генератор ENDT

	class EndtGenerator_i
		: virtual public evd::EeGenerator_i {
	public:
		EndtGenerator_i (EndtWriteFunction* endt_write_function, size_t buf_size, IBaseWriter* base_writer);

		virtual ~EndtGenerator_i ();

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

		struct CellInfo {
			unsigned long frame_flags;

			long id;
			long merge;
			long width;
			long vert_align;
			long left_indent;
			long right_indent;

			bool has_frame;
			bool is_visible;

			CellInfo (long id_)
				: frame_flags (0)
				, merge (-1)
				, width (-1)
				, vert_align (-1)
				, left_indent (-1)
				, right_indent (-1)
				, has_frame (false)
				, is_visible (false)
				, id (id_) {
			}
		};

		typedef std::vector <SubInfo> SubsData;

		typedef std::pair <long, GCL::StrVector> Requisite;

		//typedef std::pair <long, GCL::StrVector> RequisiteData;
		//typedef std::vector <RequisiteData> RequisiteDataVector;

	private:
		inline bool is_para () const {
			return (m_para_level && m_para_level <= m_stack.size () && m_skip_level == 0);
		}

		void dump_requisite ();
		void dump_requisites ();
		void dump_info ();

		void reset ();
		void set_document (unsigned long doc_id);
		void write ();
		void write_cell_data (long type);
		void add_sub (long type);
		void add_sub_id (long value);
		void add_ref_data (long tag_id, long value);
		void add_requisite (long type);

	private:
		size_t m_id;
		size_t m_sub_id;
		size_t m_para_level;
		size_t m_skip_level;
		size_t m_ref_number;
		size_t m_para_counter;

		std::vector <SubInfo> m_subs;
		std::vector <RefInfo> m_refs;

		std::deque <TagInfo> m_stack;

		Core::Aptr <RefInfo> m_ref;
		Core::Aptr <CellInfo> m_cell_info;
		Core::Aptr <Requisite> m_requisite;
		Core::Aptr <Requisites> m_requisites;

		//Core::Aptr <RequisiteData> m_requisite;
		//RequisiteDataVector m_sub_requisites;

		IBaseWriter_var m_base_writer;
		EndtWriteFunction* m_write_function;
	};

	struct EndtWriteFunction : public evd::UserWriter {
		EndtWriteFunction (IEndtWriter* writer);
		long write (unsigned char* buffer, long buffer_size);
		IEndtWriter* writer () const;

	private:
		IEndtWriter* m_writer;
	};

} // namespace 

#endif // __ENDT_GENERATOR_I_H
