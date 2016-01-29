#ifndef __COMPONENTS_RTL_GARANT_EVD_IMPL_EEGENERATOR_I_H__
#define __COMPONENTS_RTL_GARANT_EVD_IMPL_EEGENERATOR_I_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "common/components/rtl/Garant/EVD/evd.h"

namespace evd {

struct UserWriter {
public:
	virtual long write (unsigned char* data, long data_size) = 0;

protected:
	virtual ~UserWriter () {
	}
};

class EeGenerator_i : virtual public IeeGenerator, virtual public Core::RefCountObjectBase {
	SET_OBJECT_COUNTER (EeGenerator_i)

public:
	EeGenerator_i (UserWriter* writer, long buf_size);

protected:
	virtual ~EeGenerator_i ();

// implemented interface's methods
public:
	virtual void AddBoolAtom (long tag_id, bool value);
	virtual void AddIntegerAtom (long tag_id, long value);
	virtual void AddMemAtom (long tag_id, const char* mem_buf, long len);
	virtual void AddRawData (const char* mem_buf, long len);
	virtual void AddStreamAtom (long tag_id, GCI::IO::Stream* stream);
	virtual void AddStringAtom (long tag_id, const char* value, long len = -1, long code_page = 0);
	virtual void AddTransparentAtom (unsigned short index);
	virtual void Finish (bool is_need_undo = false);
	virtual void Start ();
	virtual void StartChild (long type_id);
	virtual void StartDefaultChild ();
	virtual void StartTag (long tag_id);

// self methods
protected:
	virtual void open_stream ();
	virtual void close_stream (bool is_undo);
	virtual long flush_buffer ();
	virtual long write_header ();
	virtual long write_buffer (const void* buf, long len);
	virtual long write_ord (long val);
	virtual long write_tag_id (const TeeTagID& tag_id);
	virtual long write_type_id (const TeeTypeID& type_id);
	virtual long write_memory (const void* buf, long len);
	virtual long write_string (const char* buf, long len, long code_page);
	virtual void write_data (const TeeTypeID& id, const void* buf, long len, long& size);
	virtual void start_by_tag (long tag_id, const TeeTypeID& type_id);

// self data
protected:
	long m_starts;
	long m_buffer_size;
	long m_fake_starts;
	long m_offset;
	bool m_is_reallocate;
	char* m_buffer;
	void* m_user_data;

private:
	UserWriter* m_writer;
}; 

} // namespace evd

#endif //__COMPONENTS_RTL_GARANT_EVD_IMPL_EEGENERATOR_I_H__

