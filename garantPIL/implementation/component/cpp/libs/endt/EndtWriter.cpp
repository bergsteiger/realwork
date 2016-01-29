//
// EndtWriter.cpp : implementation file
//

#include "ace/ACE.h"

#include "shared/GCL/str/str_conv.h"
#include "EndtWriter.h"

namespace EndtTools {

EndtWriter::EndtWriter (unsigned flags) : m_flags_ex (flags) {
	m_buffer = new char [MAX_PARA_LEN];
}

EndtWriter::~EndtWriter () {
	if (m_buffer) {
		delete [] m_buffer;
		m_buffer = 0;
	}

	SafeBase::Singleton::instance ()->del_doc (m_new_doc);
}

void EndtWriter::set_text (const char* text, size_t count) {
	if (text) {
		if (count) {
			m_text.assign (text, count);
		} else {
			m_text = text;
		}
	} else {
		m_text = "";
	}
}

void EndtWriter::set_code_page_ (char style, bool has_pseudo_graph) {
	if (style == PS_PREFORMATTED || (has_pseudo_graph && style != PS_SIDEBYSIDE)) {
		m_code_page = CP_OEM;
	} else if (!m_text.empty ()) {
		GCL::string_recoding (GCL::cd_dos, GCL::cd_win, &(*m_text.begin ()), 0);
	}
}

void EndtWriter::normalize () {
	size_t pos = 0;

	for (size_t i = 0; i < m_text.size (); ++i) {
		if (m_text [i] == ' ') {
			++pos;
		} else {
			break;
		}
	}

	if (pos > 0) {
		m_text = m_text.substr (pos, m_text.size () - pos);
	}
}

void EndtWriter::create_new_document (long doc_id, DocInfo* info) {
	GDS_ASSERT (info);

	try {
		SafeBase* base = SafeBase::Singleton::instance ();

		base->del_attr (doc_id);
		m_new_doc = base->make (doc_id, info->Title, info->Revision);

		ACE_OS::memcpy (m_new_doc->pInfo, info, sizeof (DocInfo));

		m_new_doc->pInfo->Size = 0;
		m_new_doc->pInfo->ParaCount = 0;
		m_new_doc->pInfo->Status |= DS_EVD;

	} catch (...) {
		LOG_W (("%s: doc info for topic %d was not received", GDS_CURRENT_FUNCTION, doc_id));
		throw EndtTools::TopicNotCreated ();
	}
}

void EndtWriter::write (const void* src, size_t count) {
	if (count) {
		ACE_OS::memcpy (m_buffer + m_offset, src, count);
		m_offset += static_cast<unsigned> (count);
	}
}

void EndtWriter::write_para (const char* style_buf, long buf_len) {
	if (m_offset == 0) {
		m_offset = ENDT_HEADER_LEN;
	}

	*m_buffer = 8;
	*(long*)(m_buffer + 1) = 0;

	this->write <long> (m_flags);       // flags
	this->write <short> (m_code_page);  // code page

	if (m_flags & ENDT_HAS_BMP) {
		this->normalize ();
		this->write <long> (m_object_id);
	}

	bool is_style_valid = (m_offset + buf_len + sizeof (long) < MAX_PARA_LEN);
	long style_len = (is_style_valid)? buf_len : 0;

	this->write <long> (style_len);          // style length
	this->write (style_buf, style_len);      // style

	bool is_text_valid = (m_offset + m_text.size () + sizeof (long) < MAX_PARA_LEN);
	long text_len = (is_text_valid)? static_cast <long> (m_text.size ()) : 0;

	this->write <long> (text_len);           // text length
	this->write (m_text.c_str (), text_len); // text

	m_buffer [m_offset] = 0;
	SafeBase::Singleton::instance ()->add_para (m_new_doc, m_offset + 1, m_buffer);

	EndtInfo::clear ();

	if (m_flags_ex & WP_GENERATE_EXCEPTIONS) {
		if (is_style_valid == false) {
			throw EndtTools::InvalidStyleSize ();
		}
		if (is_text_valid == false) {
			throw EndtTools::InvalidTextSize ();
		}
	} else if (is_style_valid == false || is_text_valid == false) {
		LOG_W (("%s: invalid para size (> 16K)", GDS_CURRENT_FUNCTION));
	}
}

} // namespace
