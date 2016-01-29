//
// EndtReader.h : header file
//
 	
#ifndef __ENDT_READER_H
#define __ENDT_READER_H

#include "shared/Core/mng/Aptr.h"

#include "EndtInfo.h"

namespace EndtTools {

	const bool RECODE = true;
	const bool NO_RECODE = false;

	class EndtReader
		: virtual public EndtInfo {
	public:
		EndtReader (const char* src, bool is_recode);

	public:
		struct ParaPart {
			char* m_text;
			char* m_style;

			long m_text_len;
			long m_style_len;

			ParaPart () : m_text (0), m_style (0), m_text_len (0), m_style_len (0) {
			}

			inline bool has_text () const { 
				return (m_text != 0); 
			}
		};

	public:
		inline const ParaPart* get_para () const {
			return m_data.ptr ();
		}

		inline const EndtInfo* get_info () {
			return static_cast <EndtInfo*> (this);
		}

	protected:
		void init (char* src);
		void set_part (ParaPart*& part, char* src);

		char* read (char* src, long &len);

		template <typename TYPE>
		TYPE read (const char* src) {
			TYPE ret = 0;
			ACE_OS::memcpy (&ret, src + m_offset, sizeof (TYPE));
			m_offset += sizeof (TYPE);
			return ret;
		}

	private:
		bool m_is_recode;

		Core::Aptr <ParaPart> m_data;
	};

} // namespace 

#endif	// __ENDT_READER_H
