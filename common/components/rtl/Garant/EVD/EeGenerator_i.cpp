#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "shared/Core/sys/assert.h" 
#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"
#include "common/components/rtl/Garant/EVD/Const/Const.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/gardefs.h" // CP_XXX constants

namespace evd {

// constructors and destructor
EeGenerator_i::EeGenerator_i (UserWriter* writer, long buf_size)
	: m_buffer (0)
	, m_buffer_size (buf_size)
	, m_offset (0)
	, m_starts (0)
	, m_fake_starts (0)
	, m_writer (writer) {
}

EeGenerator_i::~EeGenerator_i () {
	if (m_buffer) {
		delete [] m_buffer; 
		m_buffer = 0;
	}
}	



void EeGenerator_i::open_stream () {
	if (!m_buffer && m_buffer_size > 0) {
		m_buffer = new char [m_buffer_size];
	}
	m_offset = 0;
}

void EeGenerator_i::close_stream (bool is_undo) {
}

long EeGenerator_i::flush_buffer () {
	long ret = 0;
	if (m_writer) {
		ret = m_offset;
		m_offset = 0;
		m_writer->write ((unsigned char*) m_buffer, ret);
	}
	return ret;
}

long EeGenerator_i::write_header () {
	return 0;
}

long EeGenerator_i::write_buffer (const void* buf, long len) {
 	if (m_buffer) {
		long offset = 0, result = 0;
		while (m_offset + (len - offset) >= m_buffer_size) {
			long size = m_buffer_size - m_offset;
			ACE_OS::memcpy (m_buffer + m_offset, (unsigned char*) buf + offset, size);
			offset += size;
			m_offset = m_buffer_size;
			result += this->flush_buffer ();
		}
		ACE_OS::memcpy (m_buffer + m_offset, (unsigned char*) buf + offset, len - offset);
		m_offset += len - offset;
		return result + len - offset;
	} else if (m_writer) {
		return m_writer->write ((unsigned char*) buf, len);
	}
	return 0;
}

long EeGenerator_i::write_ord (long val) {
 	long ret = 0;
	if (val >= 0) {
		if (val <= 0XFF) {
			this->write_data (EVD::id_UInt8, &val, sizeof (unsigned char), ret);
		} else if (val <= 0XFFFF) {
			this->write_data (EVD::id_UInt16, &val, sizeof (ACE_UINT16), ret);
		} else {
			this->write_data (EVD::id_UInt32, &val, sizeof (ACE_UINT32), ret);
		}
	} else {
		unsigned long unsigned_val = -val;
		if (unsigned_val <= 0X80) {
			this->write_data (EVD::id_SInt8 , &val, sizeof (char), ret);
		} else if (unsigned_val <= 0X8000) {
			this->write_data (EVD::id_SInt16, &val, sizeof (ACE_INT16), ret);
		} else {
			this->write_data (EVD::id_SInt32, &val, sizeof (ACE_INT32), ret);
		}
	}
	return ret;
}

long EeGenerator_i::write_tag_id (const TeeTagID& tag_id) {
 	return this->write_buffer (&tag_id, sizeof (tag_id));
}

long EeGenerator_i::write_type_id (const TeeTypeID& type_id) {
 	return this->write_buffer (&type_id, sizeof (type_id));
}

long EeGenerator_i::write_memory (const void* buf, long len) {
 	long ret = 0 ;
	this->write_data (EVD::id_Stream, &len, sizeof (ACE_UINT32), ret);
	ret += this->write_buffer (buf, len);
	return ret;
}

long EeGenerator_i::write_string (const char* buf, long len, long code_page) {
 	long ret = 0, length = len, char_size;

	if (code_page != CP_ANSI) {
		this->write_data (EVD::id_CodePage, &code_page, sizeof (ACE_INT32), ret);
	}

	char_size = (code_page == CP_UNICODE)? sizeof (wchar_t) : sizeof (char);

	if (length < 0) {
		if (code_page == CP_UNICODE) {
			length = 0;
			while (buf [length]) {
				++length;
			}
		} else {
			length = static_cast<long> (ACE_OS::strlen (buf));
		}
	}

	if (length <= 0XFF && char_size == sizeof (char)) {
		this->write_data (EVD::id_String8 , &length, sizeof (unsigned char), ret);
	} else if (length <= 0XFFFF) {
		this->write_data (EVD::id_String16, &length, sizeof (ACE_UINT16), ret);
	} else {
		this->write_data (EVD::id_String32, &length, sizeof (ACE_UINT32), ret);
	}

	ret += this->write_buffer (buf, length * char_size);
	return ret;
}

void EeGenerator_i::write_data (const TeeTypeID& id, const void* buf, long len, long& size) {
	size += this->write_type_id (id);
	size += this->write_buffer (buf, len);
}

void EeGenerator_i::start_by_tag (long tag_id, const TeeTypeID& type_id) {
	++m_starts;
	if (m_starts != 2) {
		GDS_ASSERT ((tag_id >= std::numeric_limits<evd::TeeTagID>::min()) && (tag_id <= std::numeric_limits<evd::TeeTagID>::max ()));
		this->write_tag_id (static_cast<evd::TeeTagID> (tag_id));
		this->write_type_id ((evd::TeeTypeID)type_id);
	}	
}

void EeGenerator_i::AddBoolAtom (long tag_id, bool value) {
	this->write_tag_id ((evd::TeeTagID)tag_id);
	this->write_ord (value);	
}

void EeGenerator_i::AddIntegerAtom (long tag_id, long value) {
	evd::TeeTagID tee_tag_id = (evd::TeeTagID)((tag_id == evd::ti_Children)? EVD::unpack_id_Children : tag_id);
	this->write_tag_id (tee_tag_id);
	this->write_ord (value);	
}

void EeGenerator_i::AddMemAtom (long tag_id, const char* mem_buf, long len) {
	this->write_tag_id ((evd::TeeTagID)tag_id);
	this->write_memory (mem_buf, len);	
}

void EeGenerator_i::AddRawData (const char* mem_buf, long len) {
	if (mem_buf && len > 0) {
		this->write_buffer (mem_buf, len);
	}
}

void EeGenerator_i::AddStreamAtom (long tag_id, GCI::IO::Stream* stream) {
	GDS_ASSERT_MSG (false, ("EeGenerator_i::AddStreamAtom: not supported"));	
}

void EeGenerator_i::AddStringAtom (long tag_id, const char* value, long len, long code_page) {
	if (value && len) {
		this->write_tag_id ((evd::TeeTagID)tag_id);
		this->write_string (value, len, code_page);
	} else {
		LOG_E (("EeGenerator_i::AddStringAtom: can't add string"));
	}	
}

void EeGenerator_i::AddTransparentAtom (unsigned short index) {
	this->write_buffer (&index, sizeof (ACE_UINT16));
	this->write_type_id (EVD::id_Transparent);	
}

void EeGenerator_i::Finish (bool is_need_undo) {
	if (m_starts <= 0) {
		LOG_W (("EeGenerator_i::Finish: calls Finish more than calls Start"));
	} else if (--m_starts >= m_fake_starts) {
		if (m_starts > 1) {
			this->write_tag_id (is_need_undo ? EVD::unpack_id_Rollback : EVD::unpack_id_Finish);
		} else {
			this->flush_buffer ();
		}
	} else if (--m_fake_starts == 0) {
		this->close_stream (is_need_undo); // закрываем "поток"
	}	
}

void EeGenerator_i::Start () {
	++m_fake_starts;
	if (++m_starts == 1) {
		this->open_stream ();
		this->write_header ();
	}
}

void EeGenerator_i::StartChild (long type_id) {
	this->start_by_tag (type_id, EVD::id_Child);	
}

void EeGenerator_i::StartDefaultChild () {
	++m_starts;
	this->write_buffer (&EVD::unpack_id_DefaultChild, sizeof (ACE_UINT16));	
}

void EeGenerator_i::StartTag (long tag_id) {
	this->start_by_tag (tag_id, EVD::id_Atom);	
}

} // namespace evd

