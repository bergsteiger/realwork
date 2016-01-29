//
// EndtInfo.h : header file
//

#ifndef __ENDT_INFO_H
#define __ENDT_INFO_H

#include "common/components/rtl/Garant/EVD/evddata.h"
#include "gardefs.h"

namespace EndtTools {

	class EndtInfo {
	public:
		EndtInfo ()
			: m_flags (0)
			, m_offset (0)
			, m_object_id (0)
			, m_code_page (CP_ANSI) {
		}

		virtual ~EndtInfo () {
		}

	public:
		inline short get_code_page () const {
			return m_code_page;
		}

		inline unsigned get_flags () const {
			return m_flags;
		}

		inline unsigned long get_object_id () const {
			return m_object_id;
		}

		inline bool is_sbs () const {
			return (m_flags & ENDT_SBS) != 0;
		}

		inline bool is_comment () const {
			return (m_flags & ENDT_COMMENTS) != 0;
		}

		// установить кодовую страницу
		inline void set_code_page (short value) {
			m_code_page = value;
		}

		// установить флаги
		inline void set_flags (unsigned value) {
			m_flags = value;
		}

		// установть флаг
		inline void set_flag (unsigned value) {
			m_flags |= value;
		}

		// снять флаг
		inline void clear_flag (unsigned value) {
			m_flags &= ~value;
		}

		// установить тип параграфа
		inline void set_type (evd::TypeID type) {
			GDS_ASSERT (!this->get_type ());
			m_flags |= type << 16;
		}

		// тип параграфа
		inline evd::TypeID get_type () const {
			return (evd::TypeID) ((m_flags >> 16) & 0xFF);
		}

		inline void set_object_id (unsigned long value) {
			m_object_id = value;
		}

		inline void clear () {
			m_flags = 0;
			m_offset = 0;
			m_object_id = 0;
			m_code_page = CP_ANSI;
		}

	protected:
		short m_code_page;
		unsigned m_flags;
		unsigned m_offset;
		unsigned long m_object_id;
	};

} // namespace 

#endif	// __ENDT_INFO_H
