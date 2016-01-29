//
// DBComm.cpp : implementation file
//

#include "ace/ACE.h"

#include "DBComm.h"

namespace DBCore {

////////////////////////////////////////////////////////////////////////////////////////////////////
// IBuffer implementation

class Buffer_i
	: virtual public IBuffer
	, virtual public Core::RefCountObjectBase {
public:
	Buffer_i (char* data) {
		this->set_data (data);
	}

	virtual ~Buffer_i () {
	}

	virtual const char* get_data () const {
		return m_data.in ();
	}

	virtual void set_data (char* data) {
		if (data) {
			m_data = data;
		}
	}

private:
	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > m_data;
};

////////////////////////////////////////////////////////////////////////////////////////////////////
// IIndex implementation

class Index_i
	: virtual public IIndex
	, virtual public Core::RefCountObjectBase {
public:
	Index_i (Index* data) : m_data (data) {
	}

public:
	virtual Store* open_stream (const void* key, unsigned short stream_no) {
		return m_data->OpenN (key, stream_no);
	}

	virtual void close_stream (Store* store) {
		m_data->Close (dynamic_cast <Stream*> (store));
	}

	virtual bool is_valid () const {
		return m_data && m_data->KeyCount > 0;
	}

	virtual IBuffer* read (const void* key, unsigned short stream_no, size_t& len) {
		Core::Aptr <char, Core::ArrayDeleteDestructor <char> > res;

		len = 0;

		try {
			Stream* stream = m_data->OpenN (key, stream_no);

			if (stream) {
				len = (size_t) stream->Length ();

				if (len) {
					res = new char [len + 4];
					stream->Read (res.inout (), len);
				}

				m_data->Close (stream);
			}
		} catch (...) {
			LOG_UEX (("%s: key %s", GDS_CURRENT_FUNCTION, (char*) key));
		}

		return new Buffer_i (res._retn ());
	}

	virtual bool is_valid_key (const void* key) {
		return m_data->IsExist (key);
	}

	virtual Store* key_open (const void* key, int stream_no) {
		return m_data->keyOpen (key, stream_no);
	};

	virtual IBTreeIterator* make_iterator () {
		return new BTIterator (m_data);
	}

	virtual size_t key_count () const {
		GDS_ASSERT (m_data->KeyCount > 0);
		return (size_t) m_data->KeyCount;
	}

private:
	Index* m_data;
};

////////////////////////////////////////////////////////////////////////////////////////////////////
// IProgress implementation

class Progress_i
	: virtual public IProgress
	, virtual public Core::RefCountObjectBase {
public:
	Progress_i (Base* base);

	virtual ~Progress_i ();

public:
	virtual void init (size_t div, size_t pos);

	virtual void set (size_t value);

	virtual void set_border (size_t value);

	virtual void plus ();

	virtual void pause (bool is_pause);

	virtual bool canceled_by_user ();

private:
	Base* m_base;

	int m_canceled;

	size_t m_max_val;
	size_t m_div;
	size_t m_plus;
	size_t m_saved_div;
	size_t m_offset;
	size_t m_prev_value;
};

////////////////////////////////////////////////////////////////////////////////////////////////////

Progress_i::Progress_i (Base* base) 
	: m_base (base)
	, m_canceled (0)
	, m_max_val (100)
	, m_div (1)
	, m_plus (0)
	, m_offset (0)
	, m_prev_value (0)
{
	try {
		m_base->InitProgress (m_max_val, &m_canceled);
	} catch (...) {
		LOG_E ((GDS_CURRENT_FUNCTION));
	}
}

Progress_i::~Progress_i () {
	try {
		m_base->DoneProgress ();
	} catch (...) {
		LOG_E ((GDS_CURRENT_FUNCTION));
	}
}

void Progress_i::init (size_t div, size_t pos) {
	m_div = div;
	m_plus = (size_t) (double (m_max_val * pos) / double (m_div));
}

void Progress_i::set (size_t value) {
	if (m_div) {
		long cur = (long) (m_offset + m_plus + (long)((value * m_max_val) / (100. * m_div)));

		try {
			if (cur != m_prev_value) {
				m_base->ShowCheckedProgress (cur);
			}
		} catch (...) {
			LOG_E ((GDS_CURRENT_FUNCTION));
		}

		m_prev_value = cur;
	}
}

bool Progress_i::canceled_by_user () {
	return m_canceled != 0;
}

void Progress_i::pause (bool pause) {
	if (pause) {
		m_saved_div = m_div;
		m_div = 0;
	} else {
		m_div = m_saved_div;
	}
}

void Progress_i::set_border (size_t value) {
	m_max_val = value;
}

void Progress_i::plus () {
	m_offset += m_max_val;
	m_prev_value = 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// IBase implementation

class Base_i
	: virtual public IBase
	, virtual public Core::RefCountObjectBase {
public:
	Base_i (Base* base) : m_base (base) {
	}

protected:
	virtual IIndex* make (const char* name) {
		try {
			Index* index = m_base->FindIndex (name);

			if (index) {
				if (index->streams->Fat == 0) {
					index->streams->LoadFat ();
				}
				return new Index_i (index);
			} 
		} catch (...) {
		}

		LOG_E (("%s: can't open index: %s", GDS_CURRENT_FUNCTION, name));
		throw std::exception ();
	}

	virtual IProgress* make_progress () {
		return new Progress_i (m_base);
	}

private:
	Base* m_base;
};

////////////////////////////////////////////////////////////////////////////////////////////////////
// Factories implementation

IBase* DBFactory::make (Base* base) {
	GDS_ASSERT (base);
	return new Base_i (base);
}

}
