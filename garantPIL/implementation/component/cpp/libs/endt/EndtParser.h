//
// EndtParser.h : header file
//

#ifndef __ENDT_PARSER_H
#define __ENDT_PARSER_H

#include "shared/Core/mng/Var.h"

#include "NsrcGenerator.h"
#include "EndtReader.h"
#include "Common.h"

namespace EndtTools {

	class NsrcData {
	public:
		NsrcData () : m_style_len (0), m_text_len (0) {
		}

		void add_text (const char* buffer, size_t len) {
			size_t size = ACE_OS::strlen (m_text.in ());

			m_text.inout () [m_text_len++] = '\t';
			ACE_OS::memcpy (m_text.ptr () + m_text_len, buffer, len);
			m_text_len += len;
			m_text.inout () [m_text_len] = '\0';
		}

		inline void set_text (char* buf, long len) {
			if (buf) {
				m_text = buf;
				m_text_len = len;
			}
		}

		inline void set_style (char* buf, long len) {
			if (buf) {
				m_style = buf;
				m_style_len = len;
			}
		}

		inline const char* get_style () const {
			return m_style.ptr (); 
		}

		inline const char* get_text () const {
			return m_text.ptr (); 
		}

		inline bool is_valid () const {
			return (m_text.ptr () != 0); 
		}

		inline size_t get_text_len () const {
			return m_text_len;
		}

	private:
		Buffer_aptr m_style;
		Buffer_aptr m_text;

		size_t m_style_len;
		size_t m_text_len;
	};

	/////////////////////////////////////////////////////////////////////////////////////////////

	class NsrcFileWriter
		: virtual public FileWriter {
	public:
		NsrcFileWriter (const char* file_path) : FileWriter (file_path) {
		}

		void write_nsrc (const NsrcData* data) {
			if (this->is_valid ()) { 
				ACE_OS::fprintf (this->get_handle (), "%s\n%s\n", data->get_style (), data->get_text ());
			}
		}
	};

	/////////////////////////////////////////////////////////////////////////////////////////////

	typedef std::map <long, std::string> TableInfo;

	class EndtParser {
	public:
		EndtParser (Base* base);

		NsrcData* get_nsrc_data (Document* doc, long para, const std::map<long,std::string>* map_blob_name);
		LongVector* get_resp_documents (Document* doc, bool is_sorted, long para = -1);

		void log_activate (const char* path);
		void remove_bad_ref (Base* out_base, const DocData& data, long doc_id = 0);
		void remove_bad_ref_2 (Base* out_base, const DocData& data, long doc_id = 0);
		void decompile_table (long doc_id, TableInfo& out);
		void get_norm_definitions (long doc_id, GCL::StrVector& out);

	public:
		void dump (Document* doc, NsrcFileWriter* file_writer, bool with_style);
		void dump_para (Document* doc, NsrcFileWriter* writer, long para);

	private:
		void remove_bad_ref (Document* doc);
		void remove_bad_ref_2 (Document* doc);
		void remove_bad_ref_for_doc (Base* out_base, long doc_id);
		void remove_bad_ref_for_doc_2 (Base* out_base, long doc_id);

		void get_resp_documents (LongVector* vect, Document* doc, long para);

		template <typename _ImplType, typename _DataType>
		evd::IeeGenerator* get_generator (_DataType* data, typename _ImplType::Writer writer, const EndtReader::ParaPart* part, const ParaInfo* info, const std::map<long,std::string>* map_blob_name) {
			evd::IeeGenerator_var ret = new _ImplType (writer, data, m_helper.in (), part->m_text, part->m_text_len, info, map_blob_name);
			return ret._retn ();
		}

		template <typename _ImplType, typename _DataType>
		void execute (_DataType* data, typename _ImplType::Writer writer, const EndtReader::ParaPart* part, const ParaInfo* info, const std::map<long,std::string>* map_blob_name) {
			evd::IeeGenerator_var generator = get_generator <_ImplType, _DataType> (data, writer, part, info, map_blob_name);

			if (generator.ptr ()) {
				this->execute (generator.in (), part);
			}
		}

		static void execute (evd::IeeGenerator* generator, const EndtReader::ParaPart* part, bool is_para = false);
		static void execute (evd::IeeGenerator* generator, const char* buf, long size);

	private:
		Core::Aptr <GeneratorHelper> m_helper;
	};

} // namespace 

#endif	// __ENDT_PARSER_H
