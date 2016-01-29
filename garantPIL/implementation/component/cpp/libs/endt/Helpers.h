//
// Helpers.h : header file
//

#ifndef __ENDT_HELPERS_H
#define __ENDT_HELPERS_H

#include <algorithm>

#include "Common.h"
#include "stdbase.h"

namespace EndtTools {

	typedef long ParaId;

	typedef std::vector <long> LongVector;

	typedef Core::Aptr <Document> Document_aptr;

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	class TopicNotFound : public Core::Exception {
	public:
		virtual const char* what () const throw () {
			return "TopicNotFound";
		}
	private:
		virtual const char* uid () const /*throw ()*/ {
			return 0;
		};
	};

	class NotEvdFormat : public Core::Exception {
	public:
		virtual const char* what () const throw () {
			return "NotEvdFormat";
		}
	private:
		virtual const char* uid () const /*throw ()*/ {
			return 0;
		};
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	struct ParaInfo {
		size_t m_para;
		size_t m_flags;
		size_t m_doc_id; 
		size_t m_object_id;

		ParaInfo (size_t doc_id, size_t para, size_t flags = 0, size_t object_id = 0)
			: m_para (para)
			, m_flags (flags)
			, m_doc_id (doc_id)
			, m_object_id (object_id) {
		}
	};

	struct DocData {
		LongVector doc_ids;
		LongVector blob_ids;
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	class GeneratorHelper {
	public:
		GeneratorHelper (Base* base) 
			: m_base (base)
			, m_id_count (0)
			, m_refs_count (0)
			, m_para (0) 
			, m_doc_id (0)
			, m_is_reset (false)
			, m_is_comment (false) {
		}

	public:
		Document* open_document (long doc_id, const DocInfo* info = 0);

		void log_activate (const char* path);
		void log (const char* msg, const ParaInfo* info);

		void bad_ref_init ();
		void remove_bad_ref (Base* base, long doc_id);
		void remove_bad_ref_2 (Base* base, long doc_id);
		void add_to_vector (LongVector& vect, size_t para, size_t offset);

		long get_ref_count (size_t para, size_t offset, long& pos);

		bool load_data (long doc_id);
		bool is_ref_exist (size_t para, size_t offset);
		bool is_ref_exist_2 (size_t para, size_t offset);
		bool is_blob_exist (long id) const;
		bool is_doc_exist (long id) const;

		char* get_idd_evd (long doc_id, long& size);

		inline void set_para (long para) {
			m_para = para;
		}

		inline void set_reset (bool value) {
			m_is_reset = value;
		}

		inline void set_comment (bool value) {
			m_is_comment = value;
		}

		inline long get_para () const {
			return m_para;
		}

		inline long get_doc_id () const {
			return m_doc_id;
		}

		inline Base* get_base () const {
			return m_base;
		}

		inline const ParaId* get_ids () const { 
			return m_ids.ptr (); 
		}

		inline const RespRef* get_resp_refs () const { 
			return m_resp_refs.ptr (); 
		}

		inline long get_refs_count () const { 
			return m_refs_count; 
		}

		inline bool is_valid () const { 
			return (m_ids.ptr () != 0 && m_resp_refs.ptr () != 0); 
		}

		inline bool is_reset () const {
			return m_is_reset;
		}

		inline bool is_comment () const {
			return m_is_comment;
		}

		void set_doc_data (const DocData& data) {
			m_doc_data.doc_ids = data.doc_ids;
			m_doc_data.blob_ids = data.blob_ids;
		}

	private:
		Base* m_base;

		long m_para;
		long m_doc_id;
		long m_id_count;
		long m_refs_count;

		bool m_is_reset;
		bool m_is_comment;

		INDEX_DATA (ParaId) m_ids;
		INDEX_DATA (RespRef) m_resp_refs;

		DocData m_doc_data;

		Core::Aptr <Log> m_log;
		Core::Aptr <LongVector> m_bad_refs;
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	class GeneratorData {
	public:
		struct Position {
			size_t m_start;
			size_t m_finish;

			Position () : m_start (0), m_finish (0) {
			}
		};

		struct PicInfo {
			long topic;
			long res;
			long width;
			long height;

			PicInfo () : topic (-1), res (-1), width (-1), height (-1) {
			}
		};

		struct ObjectSegment {
			Position pos;
			std::string text;
			long bloffs;

			Core::Box <PicInfo> pic_info;

			ObjectSegment () : bloffs (-1) {
			}

			inline bool operator == (size_t val) const {
				return pos.m_start == val;
			}
		};

		struct Link {
			long m_id; 
			long m_revision_id;
			long m_sub; 
			long m_type;

			Position pos;
			std::string m_name;

			Link () : m_type (0), m_sub (0), m_id (0), m_revision_id (0) {
			}
		};

	public:
		GeneratorData (GeneratorHelper* helper, const char* text, long text_len, const ParaInfo* info);

		virtual ~GeneratorData ();

	public:
		virtual void reset (const ParaInfo* info = 0);

	protected:
		const long m_text_len;
		const char* m_text;
		const ParaInfo* m_info;

		size_t m_starts;
		size_t m_link_offset;

		Core::Aptr <ObjectSegment> m_object_segment;

		Link* m_link;
		GeneratorHelper* m_helper;
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	inline bool is_big_info (unsigned long doc_id) {
		return (doc_id >= BIG_INFO_DOC && doc_id < BIG_INFO_DOC + BIG_INFO_COUNT);
	}

	inline bool is_dict_document (unsigned long doc_id) {
		return (doc_id >= ID_DIC_LO && doc_id <= ID_DIC_HI);
	}

} // namespace 

#endif	// __ENDT_HELPERS_H
