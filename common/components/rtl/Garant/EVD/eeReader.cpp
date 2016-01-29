#include "ace/ACE.h"
#include <string>
#include <cstdio>

#include "ace/OS.h"

#include "shared/GDS/Logs.h"
#include "shared/GDS/assert.h"
#include "common/components/rtl/Garant/EVD/eeReader.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/gardefs.h" // CP_XXX constants

namespace evd {

EvdReader::EvdReader (
	char *buffer
	, size_t length
	, evd::IeeGenerator *filter
) 
	: m_offset (0)
	, m_length (length)
	, m_filter (filter) 
{
	ptrdiff_t offset = this->header_end (buffer) - buffer;
	
	buffer += offset;
	length -= offset;

	m_buffer = new char [length];
	memcpy (m_buffer, buffer, length);
}

char* EvdReader::header_end (char* buffer) {
	if (*buffer == '%') {
		char* producer_end = strstr (buffer, "\r\n");
		GDS_ASSERT (producer_end);
		char* format_end = strstr (producer_end + 2, "\r\n");
		GDS_ASSERT (format_end);
		return format_end + 2;
	}
	return buffer;
}

long EvdReader::read (void *buf, const size_t count) {
	size_t size = 0;
	if (m_offset < m_length) {
		size = (count < m_length - m_offset)? count : m_length - m_offset;
		memcpy (buf, m_buffer + m_offset, size);
		m_offset += size;
	}
	return size;
}

long EvdReader::read_long () {
	long result = 0;
	this->read (&result, sizeof (long));
	return result;
}

unsigned char EvdReader::read_byte () {
	unsigned char result = 0;
	this->read (&result, sizeof (unsigned char));
	return result;
}

unsigned short EvdReader::read_word () {
	unsigned short result = 0;
	this->read (&result, sizeof (unsigned short));
	return result;
}

long EvdReader::read_word (unsigned short &value) {
	return this->read (&value, sizeof (unsigned short));
}

char* EvdReader::read_string (const evd::TevTypeID type_id) {
	long len = 0;
	switch (type_id) {
	case evd::ev_idString8:
		len = this->read_byte ();
		break;
	case evd::ev_idString16:
		len = this->read_word ();
		break;
	case evd::ev_idString32:
		len = this->read_long ();
		break;
	default:
		LOG_E (("EvdReader::read_string: invalid type id - %d", (unsigned)type_id));
		break;
	}
	char* buf = 0;
	if (len > 0) {
		buf = new char [len + 1];
		this->read (buf, len * sizeof (char));
		buf [len] = '\0';
	}
	return buf;
}

void EvdReader::read_buffer (const long tag_id) {
	long len = this->read_long ();
	if (len > 0) {
		long tmp_len = m_length - m_offset;
		long size = (len < tmp_len)? len : tmp_len;
		m_filter->AddMemAtom (tag_id, m_buffer + m_offset, size);
		m_offset += size;
	}
}

void EvdReader::read_string_ex (const long tag_id, evd::TevTypeID type_id, bool is_font_name) {
	long code_page = CP_ANSI;

	Core::Aptr <char> buf;

	if (type_id == evd::ev_idCodePage) {
		code_page = this->read_long ();
		type_id =  (evd::TevTypeID) this->read_byte ();
	}

	switch (type_id) {
	case evd::ev_idString32:
	case evd::ev_idString16: 
	case evd::ev_idString8:
		buf = this->read_string (type_id);
		break;
	default:
		LOG_E (("EvdReader::read_string_ex: invalid type id - %d", (unsigned)type_id));
		break;
	}

	if (buf.ptr ()) {
		m_filter->AddStringAtom (tag_id, buf.in (), 0xffffffff, code_page);
	}

	if (is_font_name) {
		m_font_names.push_back (std::string (buf));
	}
}

long EvdReader::read_ord (const evd::TevTypeID type_id) {
	long result = 0;
	char s_i8  = 0;
	unsigned char  u_i8  = 0;
	short s_i16 = 0;
	unsigned short u_i16 = 0;
	unsigned long u_i32 = 0;

	switch (type_id) {
	case evd::ev_idSInt8:
		this->read (&s_i8, sizeof (char));
		result = s_i8;
		break;
	case evd::ev_idUInt8:
		this->read (&u_i8, sizeof (unsigned char));
		result = u_i8;
		break;
	case evd::ev_idSInt16:
		this->read (&s_i16, sizeof (short));
		result = s_i16;
		break;
	case evd::ev_idUInt16:
		this->read (&u_i16, sizeof (unsigned short));
		result = u_i16;
		break;
	case evd::ev_idSInt32:
		this->read (&result, sizeof (long));
		break;
	case evd::ev_idUInt32:
		this->read (&u_i32, sizeof (unsigned long));
		result = u_i32;
		break;
	default: 
		LOG_E (("EvdReader::read_ord: invalid type id - %d", (unsigned)type_id));
		break;
	}
	return result;
}

void EvdReader::read_font_name (const long tag_id) {
	evd::TevTypeID type_id = (evd::TevTypeID)this->read_byte ();

	switch (type_id) {
		case ev_idString32:
		case ev_idString16:
		case ev_idString8:
		case ev_idCodePage:
			this->read_string_ex (tag_id, type_id, true);
			break;
		default:
			LOG_E (("EvdReader::read_font_name: invalid type's id - %d", (unsigned)type_id));
			break;
	}
}

void EvdReader::read_font_id (const long tag_id) {
	long font_id = -1;

	evd::TevTypeID type_id = (evd::TevTypeID)this->read_byte ();

	switch (type_id) {
		case evd::ev_idLong:
			font_id = this->read_long ();
			break;
		case evd::ev_idSInt8:
		case evd::ev_idUInt8:
		case evd::ev_idSInt16:
		case evd::ev_idUInt16:
		case evd::ev_idSInt32:
		case evd::ev_idUInt32:	
			font_id = this->read_ord (type_id);
			break;
		default:
			LOG_E (("EvdReader::read_font_id: invalid type id - %d", (unsigned)type_id));
			break;
	}

	if (font_id >= 0 && (size_t)font_id < m_font_names.size ()) {
		m_filter->AddStringAtom (tag_id, m_font_names [font_id].c_str ());
	} else {
		LOG_E (("EvdReader::read_font_id: invalid font id - %d", (unsigned)font_id));
	}
}

void EvdReader::convert_binary_object () {
	evd::TevTypeID cur_type;
	unsigned short cur_id = 0, mask_size = 0, mem_alloc = 0;

	while (read_word (cur_id) == sizeof (cur_id)) {
		switch (cur_id) {
		case evd::idKey1:
		case evd::idKey2: return;
		case evd::idKey3:
		case evd::idKey4:
		case evd::idMask: 
			GDS_ASSERT_MSG (false, ("EvdReader::convert_binary_object: not implemented for id -'%d'", cur_id));
			break;
		case evd::idMaskEx:
			mask_size = this->read_byte ();
			mem_alloc = this->read_byte ();
			m_offset += mask_size * sizeof (long);
			break;
		case evd::idRollback: 
			m_filter->Finish (true);
			break;
		case evd::idFinish: 
			m_filter->Finish ();
			break;
		case evd::idDefaultChild:
			m_filter->StartDefaultChild ();
			break;
		default:
			if (cur_id == evd::idChildren) { 
				cur_id = evd::ti_Children;
			}
			
			cur_type = (evd::TevTypeID) this->read_byte ();

			switch (cur_type) {
			case evd::ev_idChild: 
				m_filter->StartChild (cur_id);
				break;
			case evd::ev_idAtom:
				m_filter->StartTag (cur_id);
				break;
			case evd::ev_idLong:
				m_filter->AddIntegerAtom (cur_id, this->read_long ());
				break;
			case evd::ev_idString32:
			case evd::ev_idString16:
			case evd::ev_idString8:
			case evd::ev_idCodePage:
				this->read_string_ex (cur_id, cur_type);
				break;
			case evd::ev_idSInt8:
			case evd::ev_idUInt8:
			case evd::ev_idSInt16:
			case evd::ev_idUInt16:
			case evd::ev_idSInt32:
			case evd::ev_idUInt32:
				m_filter->AddIntegerAtom (cur_id, this->read_ord (cur_type));
				break;
			case evd::ev_idStream:
				this->read_buffer (cur_id);
				break;
			case evd::ev_idTransparent:
				m_filter->AddTransparentAtom (cur_id);
				break;
			case evd::ev_idFontName:
				this->read_font_name (cur_id);
				break;
			case evd::ev_idFontID:
				this->read_font_id (cur_id);
				break;
			default:
				GDS_ASSERT_MSG (false, ("EvdReader::convert_binary_object: invalid type's id"));
				break;
			}
		}
	}
}

} // namespace
