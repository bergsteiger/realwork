//
// EndtReader.cpp
//

#include "ace/ACE.h"

#include "shared/GCL/str/str_conv.h"
#include "shared/Core/sys/assert.h"

#include "document.h"
#include "EndtReader.h"

// [header][flags][code page][blob_id][{len, style, len, text},..,{len, style, len, text}]

namespace EndtTools {

EndtReader::EndtReader (const char* src, bool is_recode) : m_is_recode (is_recode) {
	GDS_ASSERT (src);
	this->init (const_cast <char*> (ParaText (src)));
}

void EndtReader::set_part (ParaPart*& part, char* src) {
	long style_len = 0, text_len = 0;

	part->m_style = read (src, part->m_style_len);
	part->m_text = read (src, part->m_text_len);

	if (m_is_recode && m_code_page == CP_ANSI) {
		GCL::string_recoding (GCL::cd_win, GCL::cd_dos, part->m_text, 0);
	}
}

void EndtReader::init (char* src) {
	m_flags = this->read <long> (src);
	m_code_page = this->read <short> (src);

	if (m_flags & ENDT_HAS_BMP) {
		m_object_id = read <long> (src);
	} 

	m_data = new ParaPart;
	this->set_part (m_data.inout (), src);
}

char* EndtReader::read (char* src, long& len) {
	char* ret = 0;
	len = this->read <long> (src);
	if (len > 0) {
		ret = src + m_offset;
		m_offset += len;
	} 
	return ret;
}

} // namespace
