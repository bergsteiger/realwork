#ifndef __COMPONENTS_RTL_GARANT_EVD_IMPL_EVDREADER_H__
#define __COMPONENTS_RTL_GARANT_EVD_IMPL_EVDREADER_H__
#include <vector>

#include "shared/Core/GDS/ObjectCounter.h"
#include "shared/GCL/str/str_conv.h"

#include "common/components/rtl/Garant/EVD/evd.h"
#include "common/components/rtl/Garant/EVD/evddata.h"

namespace evd {

// forward decls
class EvdReader; // self forward Var
typedef Core::Var<EvdReader> EvdReader_var;

class EvdReader : virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (EvdReader)

private:
	std::string look_text_token ();

protected:
	typedef std::vector< char* > Fonts;

public:
	EvdReader (const char* buffer, long length, eeGenerator* filter);
	virtual ~EvdReader ();

public:
	virtual void convert_binary_object ();
	virtual void convert ();
	virtual void convert_text_object ();

private:
	template <typename RET_TYPE, typename DATA_TYPE>
	RET_TYPE read (size_t& size) {
		size = 0;

		if (m_offset < m_length) {
			size = sizeof (DATA_TYPE);

			DATA_TYPE ret;

			if (size == 1) {
				ret = (DATA_TYPE) m_buffer [m_offset];
			} else {
				if (size > m_length - m_offset) {
					size = m_length - m_offset;
				}

				ACE_OS::memcpy (&ret, m_buffer + m_offset, size);
			}

			m_offset += size;

			return (RET_TYPE) ret;
		}

		return (RET_TYPE) 0;
	}

	void read_percent_data ();
	bool read_id (unsigned short& value);

	virtual const char* end_line (const char* str);
	virtual const char* header_end (const char* buffer);
	virtual long read (void* buf, unsigned long count);
	virtual long read_long ();
	virtual unsigned char read_byte ();
	virtual long read_word (ACE_UINT16& value);
	virtual unsigned short read_word ();
	virtual char* read_string (long type_id, long code_page, unsigned long& length);
	virtual void read_buffer (long tag_id);
	virtual void read_fontname (long tag_id);
	virtual void read_fontid (long tag_id);
	virtual void read_string_ex (long tag_id, long type_id, bool is_fontname = false);
	virtual long read_ord (long type_id);
	virtual bool read_text_type ();
	virtual bool read_text_content ();
	virtual bool read_text_item ();
	virtual bool read_text_tag ();
	virtual bool read_text_symbol ();
	virtual bool read_text_value (long tag_id);
	virtual bool read_text_token ();
	virtual void flush_text_token (long offset);
	virtual long translate_type_symbol (const char* symbol) const;
	virtual long translate_tag_symbol (const char* symbol) const;
	virtual long translate_evd_symbol (const char* symbol) const;

private:
	bool m_is_pbinary;
	size_t m_offset;
	size_t m_length;
	unsigned long m_lookup;
	eeGenerator* m_filter;
	Fonts m_fonts;
	const char* m_buffer;
};

class TagNamesMap
    : virtual public std::map <std::string, long>
    , Core::RefCountObjectBase
{
protected:
    typedef std::pair <std::string, long> Symbol;
    friend class ACE_Singleton <TagNamesMap, ACE_Recursive_Thread_Mutex>;
public:
    TagNamesMap () {
        for (long i = 0; evd::TagName[i]; i++) {
            (*this)[evd::TagName[i]] = i;
        }
    }
};

typedef ACE_Singleton <TagNamesMap, ACE_Recursive_Thread_Mutex> TagNames;

class TypeNamesMap
    : virtual public std::map <std::string, long>
    , Core::RefCountObjectBase
{
protected:
    typedef std::pair <std::string, long> Symbol;
    friend class ACE_Singleton <TypeNamesMap, ACE_Recursive_Thread_Mutex>;
public:
    TypeNamesMap () {
        for (long i = 0; evd::TypeName[i]; i++) {
            this->insert (Symbol (evd::TypeName[i], i));
        }
    }
};

typedef ACE_Singleton <TypeNamesMap, ACE_Recursive_Thread_Mutex> TypeNames;

} // namespace evd

#endif //__COMPONENTS_RTL_GARANT_EVD_IMPL_EVDREADER_H__

