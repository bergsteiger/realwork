//
// Writers.cpp : implementation file
//

#include "ace/ACE.h"

#include "Writers.h"

namespace EndtTools {

class BaseWriter_i
	: virtual public IBaseWriter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (BaseWriter_i)

	public:
		BaseWriter_i (Base* base);

		virtual ~BaseWriter_i ();

	private:

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	private:
		void write_attr (int tag, const void* data, int size);
		void write_sub_name (const std::string& name, long sub);

		void dump_sub (const SubDescEx& data, size_t level, const std::string& name);
		void dump_ref (const RespRef& data);

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	protected:
		virtual void set_document (unsigned long doc_id);

		virtual void write (const void* data, DataType type);

		virtual void write_sub (const SubInfo& info);

		virtual void write_ref (const RefInfo& info);

		virtual void write_table_info (const char* buffer, size_t size);

		virtual void set_table_id (unsigned long value);

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		Base* m_base;

		long m_doc_id;

		unsigned long m_table_id;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////

BaseWriter_i::BaseWriter_i (Base* base) : m_base (base), m_table_id (0) {
}

BaseWriter_i::~BaseWriter_i () {
}

void BaseWriter_i::set_document (unsigned long doc_id) {
	m_doc_id = doc_id;

	try {
		// Обработанные реквизиты
		m_base->DelAttr (m_doc_id, IDD_EVD);
		m_base->DelAttr (m_doc_id, IDD_SUBS_EX);
		m_base->DelAttr (m_doc_id, IDD_REFS);

		// Необработанные реквизиты
		m_base->DelAttr (m_doc_id, IDD_DIV);
		m_base->DelAttr (m_doc_id, IDD_KEY);
		m_base->DelAttr (m_doc_id, IDD_TYPE);
		m_base->DelAttr (m_doc_id, IDD_DOCKIND);

	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
	}
}

void BaseWriter_i::write (const void* data, DataType type) {
	switch (type) {
		case dt_Sub:
			this->write_sub (*(static_cast <const SubInfo*> (data)));
			break;
		case dt_Ref:
			this->write_ref (*(static_cast <const RefInfo*> (data)));
			break;
		case dt_Evd:
			break;
	}
}

void BaseWriter_i::write_sub (const SubInfo& info) {
//#ifdef _DEBUG
	this->dump_sub (info.data, info.level, info.name);
//#endif

	this->write_attr (IDD_SUBS_EX, &info.data, sizeof (info.data));
	this->write_sub_name (info.name, info.data.Sub);
}

void BaseWriter_i::write_ref (const RefInfo& info) {
//#ifdef _DEBUG
	this->dump_ref (info.data);
//#endif

	this->write_attr (IDD_REFS, &info.data, sizeof (info.data));
}

void BaseWriter_i::write_table_info (const char* buffer, size_t size) {
	size_t info_len = size + sizeof (unsigned long) + sizeof (char);

	char info [1024];

	ACE_OS::memcpy (info, &m_table_id, sizeof (unsigned long));
	info [4] = (char) (size & 0xFF);
	ACE_OS::memcpy (info + 5, buffer, size);

	this->write_attr (IDD_EVD, info, static_cast<int> (info_len));
}

void BaseWriter_i::set_table_id (unsigned long value) {
	m_table_id = value;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

void BaseWriter_i::write_attr (int tag, const void* data, int size) {
	GDS_ASSERT (m_doc_id > 0);

	m_base->PutAttr (m_doc_id, tag, data, size);
}

void BaseWriter_i::write_sub_name (const std::string& name, long sub) {
	if (name.empty () == false) {
		Ref ref;
		ref.DocId = m_doc_id;
		ref.Sub = sub;

		Index* index = m_base->subNames;

		if (index) {
			Stream* str = index->Open (&ref, 1);

			if (str) {
				str->Write (name.c_str (), static_cast<int> (name.size ()) + 1);
				index->Close (str);
			}
		}

		/**
		char buf [128];
		int res = m_base->FindSubName (m_doc_id, sub, buf);
		int test = 10;
		/**/
	}
}

void BaseWriter_i::dump_sub (const SubDescEx& data, size_t level, const std::string& name) {
	int handle = ace_os_open ("C:\\TEST\\test_subs.txt", O_RDWR | O_APPEND | O_CREAT);

	if (handle != -1) {
		char buf [1024];

		std::string str (level, ' ');

		if (data.Flags & 0x8000) {
			ACE_OS::sprintf (
				buf
				, "%s flags:%d (%d), level:%d, para:%d, sub:%d, id:%d\n"
				, str.c_str ()
				, data.Flags, data.Flags - 0x8000, level, data.Para, data.Sub, data.Id
			);
		} else {
			ACE_OS::sprintf (
				buf
				, "%s flags:%d, level:%d, para:%d, sub:%d, id:%d; %s\n"
				, str.c_str ()
				, data.Flags, level, data.Para, data.Sub, data.Id
				, name.c_str ()
			);
		}

		ace_os_lseek (handle, 0, ACE_OS_SEEK_END);
		ace_os_write (handle, buf, ACE_OS::strlen (buf));
		ace_os_close (handle);
	}
}

void BaseWriter_i::dump_ref (const RespRef& data) {
	int handle = ace_os_open ("C:\\TEST\\refs.txt", O_RDWR | O_APPEND | O_CREAT);

	if (handle != -1) {
		char buf [256];

		ACE_OS::sprintf (
			buf
			, "para_id:%d, offset:%d, doc_id:%d, sub:%d\n"
			, data.ParaId, data.Offset, data.DocId, data.Sub
		);

		ace_os_lseek (handle, 0, ACE_OS_SEEK_END);
		ace_os_write (handle, buf, ACE_OS::strlen (buf));
		ace_os_close (handle);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

IBaseWriter* BaseWriterFactory::make (Base* base) {
	return new BaseWriter_i (base);
}

} // namespace
