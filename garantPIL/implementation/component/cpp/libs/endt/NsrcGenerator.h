//
// NsrcGenerator.h : header file
//

#ifndef __NSRC_GENERATOR_H
#define __NSRC_GENERATOR_H

#include <algorithm>

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"
#include "Helpers.h"

namespace EndtTools {

	typedef Core::Aptr <char> Buffer_aptr;

	struct Data {
		char* m_buffer;
		size_t m_len;
		size_t m_pos;

		Data (size_t len, size_t pos);

		~Data ();

		void write_id (long id);
		void write_ref (long id, long sub, const ParaInfo* info);

		template <typename TYPE>
		void write (const TYPE val) {
			ACE_OS::memcpy (m_buffer + m_len, &val, sizeof (TYPE));
			m_len += sizeof (TYPE);
		}

		void write (const char* buffer, size_t count) {
			if (count) {
				ACE_OS::memcpy (m_buffer + m_len, buffer, count);
				m_len += count;
			}
		}

		inline bool is_valid () const { 
			return (m_buffer != 0); 
		}
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	struct Style {
		char m_style;
		size_t m_pos;
		long m_id;

		Style () : m_style (0), m_pos (0), m_id (0) {
		}

		Style (char style, size_t pos, long id) : m_style (style), m_pos (pos), m_id (id) {
		}

		inline bool operator == (const Style& val) const {
			return m_id == val.m_id;
		}

		inline bool operator < (const Style& val) const {
			return m_pos < val.m_pos;
		}

		inline void clear () {
			m_style = 0; 
			m_pos = 0;
			m_id = 0;
		}
	};

	typedef std::vector <EndtTools::Style> Styles;


	inline bool compare_great (const Style& x, const Style& y) {
		return x.m_pos > y.m_pos;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	
	class NsrcGenerator_i 
		: virtual public GeneratorData
		, virtual public evd::IeeGenerator 
		, virtual public Core::RefCountObjectBase {
	public:
		typedef void (__stdcall *Writer) (
			void* user_data
			, char* style
			, long style_len
			, char* text
			, long text_len
			, size_t flags
		);

	public:
		NsrcGenerator_i (
			NsrcGenerator_i::Writer writer
			, void* user_data
			, GeneratorHelper* helper
			, const char* text
			, long text_len
			, const ParaInfo* info
			, const std::map<long,std::string>* map_blob_name_ptr
		);

		virtual ~NsrcGenerator_i ();

		// IeeGenerator implementation
	protected:
		virtual void Start ();
		virtual void Finish (bool is_need_undo = false);
		virtual void StartTag (long tag_id);
		virtual void StartChild (long tag_id);
		virtual void AddIntegerAtom (long tag_id, long value);
		virtual void AddBoolAtom (long tag_id, bool value);
		virtual void AddStringAtom (long tag_id, const char* buf, long len = 0xffffffff, long code_page = 0x0);
		virtual void AddStreamAtom (long tag_id, GCI::IO::Stream* stream);
		virtual void AddMemAtom (long tag_id, const char* mem_buf, long len);
		virtual void AddRawData (const char* mem_buf, long len);
		virtual void StartDefaultChild (void);
		virtual void AddTransparentAtom (unsigned short atom_index);

	protected:
		struct Margins {
			size_t m_left;
			size_t m_right;
			size_t m_red_line;

			Margins () : m_left (0), m_red_line (0), m_right (73) {
			}
		};

		struct StyleCommand {
			char m_style;
			long print_font_size; 
			std::string m_str_margin;

			StyleCommand () : m_style (0), print_font_size (0) {
			}

			char get_str_style ();
			const char* get_str_margins (const Margins& margins);

			void set_style_d (long start);
			bool set_style (long value, bool is_justify = false);
		};

	protected:
		void open_style ();
		void close_style ();
		void restore_bitmap_link ();

		void sort_styles ();
		void sort_identicals (bool is_close_style);

		void add_link ();
		void add_object_segment ();
		void add_segment (char style);

		char* get_style_buffer (size_t& len);

		void write_text (size_t count, size_t& offset);
		void write_data (size_t pos, const Data* data);
		void write_segments ();
		void write ();

		void set_style (long value);
		void set_visible (long value);

	private:
		template <typename TYPE>
		void write (size_t pos, const TYPE val) {
			ACE_OS::memcpy (m_buffer.inout () + pos, &val, sizeof (TYPE));
			m_length += sizeof (TYPE);
		}

		template <typename TYPE>
		void write (const TYPE val) {
			ACE_OS::memcpy (m_buffer.inout () + m_length, &val, sizeof (TYPE));
			m_length += sizeof (TYPE);
		}

	private:
		const std::map<long,std::string>* map_blob_name;

		typedef Core::Aptr <Data> Data_aptr;

		typedef std::vector <Data*> DataVect;

		typedef std::vector <ObjectSegment> ObjectSegments;

	private:
		char m_style;
		bool m_is_visible;
		bool m_is_tab_stops;

		void* m_user_data;

		size_t m_length;
		size_t m_counter;
		size_t m_obj_pos;

		Styles m_styles;
		Margins m_margins;
		Position m_position;
		DataVect m_style_data;
		StyleCommand m_style_command;

		ObjectSegments m_objects;

		NsrcGenerator_i::Writer m_writer;
		Buffer_aptr m_buffer;
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	class RespGenerator_i
		: virtual public GeneratorData
		, virtual public evd::IeeGenerator 
		, virtual public Core::RefCountObjectBase {
	public:
		typedef void (__stdcall *Writer) ();

	public:
		RespGenerator_i (
			RespGenerator_i::Writer writer
			, LongVector* vect
			, GeneratorHelper* helper
			, const char* text
			, long text_len
			, const ParaInfo* info
			, const std::map<long,std::string>* map_blob_name
		);

		virtual ~RespGenerator_i ();

		// IeeGenerator implementation

		virtual void Start ();
		virtual void Finish (bool is_need_undo = false);
		virtual void StartTag (long tag_id);
		virtual void StartChild (long tag_id);
		virtual void AddIntegerAtom (long tag_id, long value);
		virtual void AddBoolAtom (long tag_id, bool value);
		virtual void AddStringAtom (long tag_id, const char* buf, long len = 0xffffffff, long code_page = 0x0);
		virtual void AddStreamAtom (long tag_id, GCI::IO::Stream* stream);
		virtual void AddMemAtom (long tag_id, const char* mem_buf, long len);
		virtual void AddRawData (const char* mem_buf, long len);
		virtual void StartDefaultChild (void);
		virtual void AddTransparentAtom (unsigned short atom_index);

	protected:
		void add ();

	private:
		LongVector* m_resp_vect;
	};

} // namespace 

#include "NsrcGenerator.i.h"

#endif	// __NSRC_GENERATOR_H
