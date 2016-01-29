//
// EndtWriter.h : header file
//

#ifndef __ENDT_WRITER_H
#define __ENDT_WRITER_H

#include "shared/Core/sys/std_inc.h"

#include "newdoc.h"
#include "stdbase.h"
#include "EndtInfo.h"

namespace EndtTools {

static const unsigned long WP_GENERATE_EXCEPTIONS = 0x0001; // генерить исключения

////////////////////////////////////////////////////////////////////////////////////////////////////

class InvalidStyleSize : public Core::Exception {
public:
	virtual const char* what () const throw () {
		return "Invalid style size (> 16K)";
	}

private:
	virtual const char* uid () const /*throw ()*/ {
		return "EndtTools::InvalidStyleSize";
	};
};

class InvalidTextSize : public Core::Exception {
public:
	virtual const char* what () const throw () {
		return "Invalid text size (> 16K)";
	}

private:
	virtual const char* uid () const /*throw ()*/ {
		return "EndtTools::InvalidTextSize";
	};
};

class TopicNotCreated : public Core::Exception {
	virtual const char* uid () const /*throw ()*/ {
		return "EndtTools::TopicNotFound";
	};
};

////////////////////////////////////////////////////////////////////////////////////////////////////

class SafeBase {
public:
	SafeBase () {
	}

	void init (const std::string& path) {
		GUARD (m_mutex);

		if (m_base.is_nil ()) {
			try {
				m_base = new StdBigBase (path.c_str (), O_RDWR);
				m_base->not_del_attr ();
			} catch (...) {
				LOG_UEX ((GDS_CURRENT_FUNCTION));
				throw std::exception ();
			}
		}
	}


	NewDocument* make (long id, const char* title, revision& rev_date) {
		return new NewDocument (m_base.in (), id, title, rev_date, PM_ZIP);
	}

	void del_doc (NewDocument*& doc) {
		if (doc) {
			GUARD (m_mutex);
			delete doc;
			doc = 0;
		} 
	}

	void del_attr (long id) {
		GUARD (m_mutex);

		m_base->DelText (id);
		m_base->DelAttr (id, IDD_DIVISION);
		m_base->DelAttr (id, IDD_PARAHEIGHTS);
	}

	void replace_attr (long id, short tag, void* data, long size) {
		GUARD (m_mutex);
		m_base->ReplaceAttr (id, tag, data, size);
	}

	Base* ptr () {
		return m_base.in ();
	}

	void add_para (NewDocument* doc, int size, void* buffer) {
		GUARD (m_mutex);
		doc->AddPara (PS_EVD, size, buffer);
	}

public:
	typedef ACE_Singleton <SafeBase, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SafeBase, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	Core::Mutex m_mutex;
	Core::Aptr <StdBigBase> m_base;
};

////////////////////////////////////////////////////////////////////////////////////////////////////
// ENDT paragraph format:
// [header][flags][code page][blob_id][{len, style, len, text},..,{len, style, len, text}]

class EndtWriter 
	: virtual public EndtInfo
{
	SET_OBJECT_COUNTER (EndtWriter)

public:
	EndtWriter (unsigned flags);

	virtual ~EndtWriter ();

public:
	void set_text (const char* text, size_t count = 0);
	void set_code_page_ (char style, bool has_pseudo_graph);
	void create_new_document (long doc_id, DocInfo* info);
	void write_para (const char* style_buf, long buf_len);

public:
	std::string m_text;

private:
	void normalize ();
	void write (const void* src, size_t count);

	template <typename TYPE>
	void write (TYPE value) {
		ACE_OS::memcpy (m_buffer + m_offset, &value, sizeof (TYPE));
		m_offset += sizeof (TYPE);
	}

private:
	unsigned m_flags_ex;

	char* m_buffer;

	NewDocument* m_new_doc;
};

} // namespace

#endif // !defined(__ENDT_WRITER_H)
