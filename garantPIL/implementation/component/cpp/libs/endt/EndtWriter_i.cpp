//
// EndtWriter_i.cpp : implementation file
//

#include "ace/ACE.h"

#include "newdoc.h"
#include "EndtInfo.h"
#include "Writers.h"

namespace EndtTools {

class EndtWriter_i
	: virtual public IEndtWriter
	, virtual public ::Core::RefCountObjectBase
	, virtual public EndtInfo 
{
	SET_OBJECT_COUNTER (EndtWriter_i)

	public:
		EndtWriter_i (Base* base);

		virtual ~EndtWriter_i ();

	private:

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	private:
		void write (const void* src, size_t count) {
			if (count) {
				ACE_OS::memcpy (m_buffer + m_offset, src, count);
				m_offset += static_cast<unsigned> (count);
			}
		}

		void reset () {
			EndtInfo::clear ();
			m_parts = 0;
			m_text.clear ();
		}

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	protected:
		virtual void set_document (unsigned long doc_id);
		virtual void create_para ();
		virtual void add_text (const char* text, short code_page);
		virtual void add_style (const char* style, size_t style_len);
		virtual void flush ();

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		char* m_buffer;

		size_t m_parts;

		unsigned long m_doc_id;

		bool m_is_valid_size;

		std::string m_text;

		Base* m_base;

		Core::Aptr <NewDocument> m_doc;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////

EndtWriter_i::EndtWriter_i (Base* base) 
	: m_base (base)
	, m_parts (0)
	, m_doc_id (0) 
{
	m_buffer = new char [MAX_PARA_LEN];
}

EndtWriter_i::~EndtWriter_i () {
}

void EndtWriter_i::set_document (unsigned long doc_id) {
	long info_size = 0;

	m_doc_id = doc_id;

	try {
		INDEX_DATA (DocInfo) info = IndexLoader (m_base).load <DocInfo> (doc_id, IDD_INFO, info_size, false);

		m_base->DelText (doc_id);

		m_doc = new NewDocument (m_base, doc_id, info->Title, info->Revision, PM_ZIP);

		ACE_OS::memcpy (m_doc->pInfo, info.in (), sizeof (DocInfo));

		m_doc->pInfo->Size = 0;
		m_doc->pInfo->ParaCount = 0;
		m_doc->pInfo->Status |= DS_EVD;

	} catch (...) {
		LOG_W (("%s: doc info for topic %d was not received", GDS_CURRENT_FUNCTION, doc_id));
		//throw EndtTools::TopicNotCreated ();
	}
}

void EndtWriter_i::create_para () {
	m_is_valid_size = true;

	m_offset = ENDT_HEADER_LEN;

	*m_buffer = 8;
	*(long*)(m_buffer + 1) = 0;

	this->write (&m_flags, sizeof (long));       // flags
	this->write (&m_code_page, sizeof (short));  // code page

	if (m_flags & ENDT_HAS_BMP) {
		/*
		this->normalize ();
		this->write <long> (m_object_id);
		*/
	}
}

void EndtWriter_i::add_text (const char* text, short code_page) {
	GDS_ASSERT (text);

	m_text = text;

	this->set_code_page (code_page);
}

void EndtWriter_i::add_style (const char* style, size_t style_len) {
	++m_parts;

	GDS_ASSERT (m_parts < 3);
	
	this->write (&style_len, sizeof (long)); // style length
	this->write (style, style_len);          // style

	m_is_valid_size = (m_offset + m_text.size () + sizeof (long) < MAX_PARA_LEN);

	size_t text_len = (m_is_valid_size)? m_text.size () : 0;

	this->write (&text_len, sizeof (long));  // text length
	this->write (m_text.c_str (), text_len); // text
}

void EndtWriter_i::flush () {
	bool is_write = true;
	
	if (m_flags & ENDT_SBS) {
		is_write = (m_parts == 2);
	}

	if (is_write) {
		m_buffer [m_offset] = '\0';

		m_doc->AddPara (PS_EVD, m_offset /*+ 1*/, m_buffer);

		this->reset ();

		if (m_is_valid_size == false) {
			LOG_W (("%s: invalid para size (> 16K)", GDS_CURRENT_FUNCTION));
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

IEndtWriter* EndtWriterFactory::make (Base* base) {
	return new EndtWriter_i (base);
}

} // namespace
