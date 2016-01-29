#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "shared/Core/mng/Aptr.h"
#include "common/components/rtl/Garant/EVD/EvdReader.h"

#include "shared/Core/sys/assert.h"
#include "ace/Singleton.h"
#include <map>
#include "common/components/rtl/Garant/EVD/Types/Types.h"
#include "common/components/rtl/Garant/EVD/Const/Const.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/gardefs.h" // CP_XXX constants

namespace evd {

struct EvdSymbol {
    const char* symbol;
    long value;
};

EvdSymbol EvdSymbolSet [] = {
     {"ev_itLeft", EVD::it_Left}
    ,{"ev_itRight", EVD::it_Right}
    ,{"ev_itCenter", EVD::it_Center}
    ,{"ev_itWidth", EVD::it_Width}
    ,{"ev_itPreformatted", EVD::it_Preformatted}
    ,{"ev_itNone", EVD::it_None}
    ,{NULL, -1}
};

class EvdSymbolsMap
    : virtual public std::map <std::string, long>
    , Core::RefCountObjectBase
{
protected:
    typedef std::pair <std::string, long> Symbol;
    friend class ACE_Singleton <EvdSymbolsMap, ACE_Recursive_Thread_Mutex>;
public:
    EvdSymbolsMap () {
        for (long i = 0; evd::EvdSymbolSet[i].symbol; i++) {
            (*this)[evd::EvdSymbolSet[i].symbol] = EvdSymbolSet[i].value;
        }
    }
};

typedef ACE_Singleton <EvdSymbolsMap, ACE_Recursive_Thread_Mutex> EvdSymbols;

std::string EvdReader::look_text_token () {
	static const char white[] = " \t\n\r";
	static const char special[] = "'=:{} \t\n\r";
	static const char strin[] = "'";
	m_lookup = 0;

	if (m_lookup != 0) {
		LOG_D (("m_lookup = %d\n", m_lookup));
		Core::Aptr <char> str = new char [m_lookup + 1];
		ACE_OS::strncpy (str.out (), m_buffer/*.ptr ()*/ + m_offset, m_lookup);
		LOG_D (("Looked token: %s\n", str.in ()));
		std::string retval (str.in ());
		LOG_D (("Returning: %s\n", retval.c_str ()));
		return retval;
	}
	// first skip all whitespaces, i.e. spaces, tabs, carriage returns
	while (m_offset+m_lookup < m_length && ACE_OS::strchr (white, m_buffer[m_offset+m_lookup])) {
		m_lookup++;
	}
	// check, whether an end of buffer occured
	if (m_offset + m_lookup >= m_length) {
		return "";
	}
	const char* ptr = m_buffer/*.ptr ()*/ + m_offset + m_lookup;
	const char* fmt = special;
	std::string retval = "";
	// If we are parsing string 'My own text string', than all symbols except ' are good
	switch (*ptr) {
		case ':': 
		case '{':
		case '}':
		case '=':
			{
				m_lookup++;
				char buf[2];
				buf[0] = *ptr;
				buf[1] = 0;
				retval = buf;
				break;
			}
		case '\'':
			fmt = strin;
			retval += "'";
			m_lookup++;
		default:
			while (m_offset + m_lookup < m_length && !ACE_OS::strchr (fmt, m_buffer[m_offset + m_lookup])) {
				retval += m_buffer [m_offset + m_lookup];
				m_lookup++;
			}
			if (*ptr == '\'') {
				retval += "'";
				m_lookup++;
				// string can be encoded: 'My own string value',3 - codepage
				while (m_offset + m_lookup < m_length && 
					!ACE_OS::strchr (white, m_buffer[m_offset + m_lookup])) {
						retval += m_buffer [m_offset + m_lookup];
						m_lookup++;
						// need to read codepage, if has some
					}
			}
	}
	// now going forward, looking for end of token.
	//  ptr = const_cast <char *> (retval.c_str ());
	return retval;
}



//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

EvdReader::EvdReader (const char* buffer, long length, eeGenerator* filter)
	: m_filter (filter) 
	, m_is_pbinary (false)
	, m_lookup (0)

{
	if (buffer && length > 0) {
		m_buffer = buffer;
		m_length = length;
		m_offset = this->header_end (m_buffer) - m_buffer;
	} else {
		m_buffer = "";
		m_length = 0;
		m_offset = 0;
	}
}

EvdReader::~EvdReader () {
	for (Fonts::const_iterator it = m_fonts.begin (); it != m_fonts.end (); ++it) {
		delete [] (*it);
	}
}	

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

const char* EvdReader::end_line (const char* str) {
	ptrdiff_t offset = str - m_buffer;

	if (offset >= (ptrdiff_t) m_length || offset < 0) {
		return 0;
	}

	if (!str || !*str) {
		return 0;
	}

	const char* ptr = ACE_OS::strnchr (str, '\n', m_length - offset);

	if (ptr == 0) {
		ptr = ACE_OS::strnchr (str, '\r', m_length - offset);
	}

	return ptr;
}

const char* EvdReader::header_end (const char* buffer) {
	if (*buffer == '%') {
		const char* producer_end = this->end_line (buffer);
		GDS_ASSERT (producer_end);

		if (producer_end [1] != '%') {
			m_is_pbinary = (std::string (buffer).find ("pbinary") != std::string::npos);
			return producer_end + 1;
		}

		const char* format_end = this->end_line (producer_end + 1);
		GDS_ASSERT (format_end);

		// Выясним какого формата evd данные
		std::string format_str (producer_end, (format_end - producer_end) - 1);
		m_is_pbinary = (format_str.rfind ("pbinary") != std::string::npos);

		if (format_end) {
			return format_end + 1;
		} else {
			return producer_end + 1;
		}
	}

	return buffer;
}

long EvdReader::read (void* buf, unsigned long count) {
	size_t size = 0;

	if (m_offset < m_length) {
		size = (count < m_length - m_offset)? count : m_length - m_offset;
		ACE_OS::memcpy (buf, m_buffer + m_offset, size);
		m_offset += size;
	}

	return static_cast<long> (size);
}

long EvdReader::read_long () {
	ACE_INT32 result = 0;
	this->read (&result, sizeof (result));
	return result;
}

unsigned char EvdReader::read_byte () {
	ACE_Byte result = 0;
	this->read (&result, sizeof (result));
	return result;
	
}

long EvdReader::read_word (ACE_UINT16& value) {
	return this->read (&value, sizeof (value));
}

unsigned short EvdReader::read_word () {
	ACE_UINT16 result = 0;
	this->read (&result, sizeof (result));
	return result;
}

bool EvdReader::read_id (unsigned short& value) {
	size_t size = 0;

	if (m_is_pbinary) {
		value = this->read <unsigned char, unsigned char> (size);
	} else {
		value = this->read <unsigned short, unsigned short> (size);
	}

	return size != 0;
}

char* EvdReader::read_string (long type_id, long code_page, unsigned long& length) {
	length = 0;

	switch (type_id) {
		case EVD::id_String8:
			length = (unsigned long) this->read_byte ();
			break;
		case EVD::id_String16:
			length = (unsigned long) this->read_word ();
			break;
		case EVD::id_String32:
			length = (unsigned long) this->read_long ();
			break;
		default:
			LOG_W (("%s: invalid type's id: %d", GDS_CURRENT_FUNCTION, type_id));
			break;
	}

	char* buf = 0;

	if (length > 0) {
		unsigned long char_size = (code_page == CP_UNICODE)? sizeof (wchar_t) : sizeof (char);

		buf = new char [char_size*length + 1];
		this->read (buf, char_size*length*sizeof (char));
		buf [length] = '\0';
	}

	return buf;
}

void EvdReader::read_buffer (long tag_id) {
	long len = this->read_long ();

	if (len > 0) {
		long tmp_len = static_cast<long> (m_length) - static_cast<long> (m_offset);
		long size = (len < tmp_len)? len : tmp_len;
		m_filter->AddMemAtom (tag_id, m_buffer + m_offset, size);
		m_offset += size;
	}
}

void EvdReader::read_fontname (long tag_id) {
	EVD::TevTypeID type_id = (EVD::TevTypeID)this->read_byte ();

	switch (type_id) {
		case EVD::id_String32:
		case EVD::id_String16: 
		case EVD::id_String8:
		case EVD::id_CodePage:
			this->read_string_ex (tag_id, type_id, true);
			break;
		default:
			LOG_W (("EvdReader::read_fontname: invalid type's id: %d", (unsigned)type_id));
			break;
	}
}

void EvdReader::read_fontid (long tag_id) {
	EVD::TevTypeID type_id = (EVD::TevTypeID)this->read_byte();

	long font_id = -1;

	switch(type_id) {
		case EVD::id_Long:
			font_id = this->read_long();
			break;
		case EVD::id_SInt8:
		case EVD::id_UInt8:
		case EVD::id_SInt16:
		case EVD::id_UInt16:
		case EVD::id_SInt32:
		case EVD::id_UInt32:	
			font_id = this->read_ord (type_id);
			break;
		default:
			LOG_W (("%s: invalid type id: %d", GDS_CURRENT_FUNCTION, (unsigned)type_id));
			break;
	}

	if (font_id >= 0 && (size_t)font_id < m_fonts.size ()) {
		m_filter->AddStringAtom (tag_id, m_fonts [font_id]);
	} else {
		LOG_W (("%s: invalid font id: %d", GDS_CURRENT_FUNCTION, (unsigned)font_id));
	}
}

void EvdReader::read_string_ex (long tag_id, long type_id, bool is_fontname) {
	long code_page = CP_ANSI;
	unsigned long length = 0;

	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > buf;

	size_t size = 0;

	switch (type_id) {
		case EVD::id_CodePage:
			code_page = this->read <long, ACE_INT32> (size);
			type_id = this->read <long, unsigned char> (size);
			break;
		case EVD::id_ShortCodePage:
			code_page = this->read <long, unsigned char> (size);
			type_id = this->read <long, unsigned char> (size);
			break;
	}

	switch (type_id) {
		case EVD::id_String32:
		case EVD::id_String16:
		case EVD::id_String8:
			buf = this->read_string (type_id, code_page, length);
			break;
		default:
			LOG_W (("%s: invalid type id: %d", GDS_CURRENT_FUNCTION, type_id));
			break;
	}

	if (buf.ptr ()) {
		m_filter->AddStringAtom (tag_id, buf.in (), length, code_page);
	}

	if (is_fontname) {
		char* fn = new char [length + 1];
		ACE_OS::strcpy (fn, buf.in ());
		m_fonts.push_back (fn);
	}
}

void EvdReader::read_percent_data () {
	size_t size = 0;

	unsigned short type = this->read <unsigned short, unsigned char> (size);

	switch (type) {
		case EVD::pack_id_SmallE:
		case EVD::pack_id_CapitalE:
			m_offset += ACE_OS::strlen ("endbinary");
			break;
		case EVD::pack_id_SmallB:
		case EVD::pack_id_CapitalB:
		case EVD::pack_id_SmallP:
		case EVD::pack_id_CapitalP:
			GDS_ASSERT_MSG (false, ("%s: not implemented for %d", GDS_CURRENT_FUNCTION, type));
			break;
	}
}

long EvdReader::read_ord (long type_id) {
	long ret = 0;

	size_t size = 0;

	switch (type_id) {
		case EVD::id_SInt8:
			ret = this->read <long, char> (size);
			break;
		case EVD::id_UInt8:
			ret = this->read <long, unsigned char> (size);
			break;
		case EVD::id_SInt16:
			ret = this->read <long, ACE_INT16> (size);
			break;
		case EVD::id_UInt16:
			ret = this->read <long, ACE_UINT16> (size);
			break;
		case EVD::id_SInt32:
			ret = this->read <long, ACE_INT32> (size);
			break;
		case EVD::id_UInt32:
			ret = this->read <long, ACE_UINT32> (size);
			break;
		default: 
			GDS_ASSERT_MSG (false, ("%s: not implemented for id: %d", GDS_CURRENT_FUNCTION, type_id));
			break;
	}

	return ret;
	
}

void EvdReader::convert_binary_object () {
	EVD::TevTypeID cur_type;
	unsigned short cur_id = 0, mask_size = 0, mem_alloc = 0;

	while (read_word (cur_id) == sizeof (cur_id)) {
		switch (cur_id) {
			case EVD::unpack_id_Key1:
			case EVD::unpack_id_Key2: return;
			case EVD::unpack_id_Key3:
			case EVD::unpack_id_Key4:
			case EVD::unpack_id_Mask: 
				GDS_ASSERT_MSG (false, ("%s: not implemented for id: %d", GDS_CURRENT_FUNCTION, cur_id));
				break;
			case EVD::unpack_id_MaskEx:
				mask_size = this->read_byte ();
				mem_alloc = this->read_byte ();
				m_offset += mask_size * sizeof (long);
				break;
			case EVD::unpack_id_Rollback: 
				m_filter->Finish (true);
				break;
			case EVD::unpack_id_Finish: 
				m_filter->Finish ();
				break;
			case EVD::unpack_id_DefaultChild:
				m_filter->StartDefaultChild ();
				break;
			default:
				if (cur_id == EVD::unpack_id_Children) { 
					cur_id = evd::ti_Children;
				}

				cur_type = (EVD::TevTypeID) this->read_byte ();

				switch (cur_type) {
					case EVD::id_Child:
						m_filter->StartChild (cur_id);
						break;
					case EVD::id_Atom:
						m_filter->StartTag (cur_id);
						break;
					case EVD::id_Long:
						m_filter->AddIntegerAtom (cur_id, this->read_long ());
						break;
					case EVD::id_String32:
					case EVD::id_String16:
					case EVD::id_String8:
					case EVD::id_CodePage:
						this->read_string_ex (cur_id, cur_type);
						break;
					case EVD::id_SInt8:
					case EVD::id_UInt8:
					case EVD::id_SInt16:
					case EVD::id_UInt16:
					case EVD::id_SInt32:
					case EVD::id_UInt32:
						m_filter->AddIntegerAtom (cur_id, this->read_ord (cur_type));
						break;
					case EVD::id_Stream:
						this->read_buffer (cur_id);
						break;
					case EVD::id_Transparent:
						m_filter->AddTransparentAtom (cur_id);
						break;
					case EVD::id_FontName:
						this->read_fontname(cur_id); 
						break;
					case EVD::id_FontID:
						this->read_fontid(cur_id);
						break;
					default:
						GDS_ASSERT_MSG (false, ("%s: not implemented for id: %d", GDS_CURRENT_FUNCTION, cur_type));
						break;
				}
		}
	}
}

void EvdReader::convert () {
	if (m_is_pbinary == false) {
		convert_binary_object ();
		return;
	}

	unsigned short id = 0;
	size_t size = 0;

	while (read_id (id)) {
		switch (id) {
			case EVD::pack_id_Percent:
				this->read_percent_data ();
				break;
			case EVD::pack_id_Rollback:
				m_filter->Finish (true);
				break;
			case EVD::pack_id_Finish:
				m_filter->Finish ();
				break;
			case EVD::pack_id_DefaultChild:
				m_filter->StartDefaultChild ();
				break;
			default:
				if (id == EVD::pack_id_Children) {
					id = evd::ti_Children;
				}

				EVD::TevTypeID type = this->read <EVD::TevTypeID, unsigned char> (size);

				switch (type) {
					case EVD::id_Child:
						m_filter->StartChild (id);
						break;
					case EVD::id_Atom:
						m_filter->StartTag (id);
						break;
					case EVD::id_Long:
						m_filter->AddIntegerAtom (id, this->read_long ());
						break;
					case EVD::id_String32:
					case EVD::id_String16:
					case EVD::id_String8:
					case EVD::id_CodePage:
					case EVD::id_ShortCodePage:
						this->read_string_ex (id, type);
						break;
					case EVD::id_SInt8:
					case EVD::id_UInt8:
					case EVD::id_SInt16:
					case EVD::id_UInt16:
					case EVD::id_SInt32:
					case EVD::id_UInt32:
						m_filter->AddIntegerAtom (id, this->read_ord (type));
						break;
					case EVD::id_SInt64:
					case EVD::id_UInt64:
						GDS_ASSERT_MSG (false, ("%s: not implemented for id: %d", GDS_CURRENT_FUNCTION, type));
						break;
					case EVD::id_Stream:
						this->read_buffer (id);
						break;
					case EVD::id_FontName:
						this->read_fontname(id); 
						break;
					case EVD::id_Transparent:
						m_filter->AddTransparentAtom (id);
						break;
					case EVD::id_FontID:
						this->read_fontid (id);
						break;
					default:
						GDS_ASSERT_MSG (false, ("%s: invalid type for id: %d", GDS_CURRENT_FUNCTION, type));
						break;
				}
		}
	}
}

void EvdReader::convert_text_object () {
	while (this->read_text_type()) {
		;
	}
}

bool EvdReader::read_text_type () {
	long offset = static_cast<long> (m_offset);
	long type_id = -1;
	std::string token;
	token = this->look_text_token ();
	if (token != ":") {
		return false;
	}
	this->read_text_token ();
	token = this->look_text_token ();
	if (token == "=") {
		this->read_text_token ();
		m_filter->StartDefaultChild ();
	} else {
		long type_id = this->translate_type_symbol (token.c_str ());
		this->read_text_token ();
		m_filter->StartChild (type_id); // Here type_id may be -1 !!
		token = this->look_text_token ();
		this->read_text_token ();
	}
	token = this->look_text_token ();
	this->read_text_token ();
	this->read_text_content ();
	token = this->look_text_token ();
	this->read_text_token ();
	m_filter->Finish ();
	return true;
}

bool EvdReader::read_text_content () {
	while (read_text_item ()) {
		;
	}
	return true;
}

bool EvdReader::read_text_item () {
	return read_text_tag () ? true : read_text_type ();
}

bool EvdReader::read_text_tag () {
	long offset = static_cast<long> (m_offset);
	std::string key = this->look_text_token ();
	long tag_id = this->translate_tag_symbol (key.c_str ());
	// we do NO check, if symbol is known! tag_id may be -1 !!!
	this->read_text_token ();
	std::string token = this->look_text_token ();
	if (token != "=") {
		this->flush_text_token (offset);
		return false;
	}
	this->read_text_token ();
	if (!this->read_text_value (tag_id)) {
		this->flush_text_token (offset);
		return false;
	}
	return true;
}

bool EvdReader::read_text_symbol () {
	return true;    
}

bool EvdReader::read_text_value (long tag_id) {
	std::string token = this->look_text_token ();
	if (token.size () <= 0) {
		return false;
	}
	switch (token.c_str()[0]) {
		case '\'' :
			{
				const char *start = token.c_str()+1;
				char *end;
				if (!(end = const_cast <char *> (ACE_OS::strchr (start, '\'')))) {
					return false;
				}
				*end = 0;
				long codepage = 0;
				if (end[1] == ',') {
					codepage = atol (end+2);
				}
				if (codepage < 0) {
					codepage = 0;
				}
				this->read_text_token ();
				m_filter->AddStringAtom (tag_id, start, static_cast<long> (end-start), codepage);
				return true;
			}
			break;
		case '-':
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			m_filter->AddIntegerAtom (tag_id, atol (token.c_str ()));
			this->read_text_token ();
			return true;
			break;
		case '{':
			this->read_text_token ();
			m_filter->StartTag (tag_id);
			this->read_text_content ();
			m_filter->Finish ();
			token = this->look_text_token ();
			this->read_text_token (); // must be '}'
			return true;
			break;
		default:
			{
				long value = this->translate_evd_symbol (token.c_str ());
				if (value != -1) {
					m_filter->AddIntegerAtom (tag_id, value);

				} else if (!ACE_OS::strcmp (token.c_str (), "True") ) {
					m_filter->AddBoolAtom (tag_id, true);
				} else if (!ACE_OS::strcmp (token.c_str (), "False") ) {
					m_filter->AddBoolAtom (tag_id, false);
				} else {
					m_filter->AddStringAtom (tag_id, token.c_str (), static_cast<long> (token.size ()), 0);
				}
				this->read_text_token ();
				return true;
			}
	}
	return false;
}

bool EvdReader::read_text_token () {
	m_offset += m_lookup;
	m_lookup = 0;
	return true;
}

void EvdReader::flush_text_token (long offset) {
	m_offset = offset;
	m_lookup = 0;
}

long EvdReader::translate_type_symbol (const char* symbol) const {
	if (!ACE_OS::strcmp (symbol, "}")) {
		return -1;
	}
	TypeNamesMap::iterator i = TypeNames::instance ()->find (symbol);
	if (i == TypeNames::instance ()->end ()) {
		return -1;
	}
	return i->second;
}

long EvdReader::translate_tag_symbol (const char* symbol) const {
	if (!ACE_OS::strcmp (symbol, "}")) {
		return -1;
	}
	TagNamesMap::iterator i = TagNames::instance ()->find (symbol);
	if (i == TagNames::instance ()->end ()) {
		return -1;
	}
	return i->second;
}

long EvdReader::translate_evd_symbol (const char* symbol) const {
	EvdSymbolsMap::iterator i = EvdSymbols::instance ()->find (symbol);
	if (i == EvdSymbols::instance ()->end ()) {
		return -1;
	}
	return i->second;
}

} // namespace evd

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
