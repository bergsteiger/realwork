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
	Buffer_i (char* data) : m_data (data) {
	}

	virtual const char* get () const {
		return m_data.in ();
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
