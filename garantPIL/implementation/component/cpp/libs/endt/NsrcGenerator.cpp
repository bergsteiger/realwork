//
// NsrcGenerator.cpp : implementation file
//
#include "ace/ACE.h"

#include <algorithm>
#include <complex>

#include "boost/lexical_cast.hpp"

#include "shared/GCL/str/str_conv.h"
#include "shared/Core/GDS/StopWatch.h"

#include "common/components/rtl/Garant/EVD/evd.h"
#include "common/components/rtl/Garant/EVD/Types/Types.h"
#include "common/components/rtl/Garant/EVD/Styles/Styles.h"

#include "NsrcGenerator.h"

namespace EndtTools {

static const bool IS_DUMP = false;
static const unsigned BUFFER_SIZE = 64;

//////////////////////////////////////////////////////////////////////////////////////////

template <typename T>
struct destroy {
	static void vect (T& v) { // GARANT_VOID
		for (typename T::iterator it = v.begin (); it != v.end (); ++it) { // GARANT_TYPENAME
			if (*it) {
				delete *it;
				*it = 0;
			}
		}
	}
};

//////////////////////////////////////////////////////////////////////////////////////////

void dump (const Styles& styles) {
	for (Styles::const_iterator it = styles.begin (); it != styles.end (); ++it) {
		ACE_OS::printf ("%d, %d, %d\n", it->m_pos, it->m_style, it->m_id);
	}
	ACE_OS::printf ("\n");
}

//////////////////////////////////////////////////////////////////////////////////////////
// NsrcGenerator_i::StyleCommand implementation

const char* NsrcGenerator_i::StyleCommand::get_str_margins (const Margins& margins) {
	if (m_str_margin.empty ()) {
		char buffer [16];
		ACE_OS::sprintf (buffer, "%ld %ld %ld", margins.m_left, margins.m_right, margins.m_red_line);
		m_str_margin = buffer;
	} 
	return m_str_margin.c_str ();
}

//////////////////////////////////////////////////////////////////////////////////////////
// Data implementation

Data::Data (size_t len, size_t pos) : m_buffer (0), m_len (0), m_pos (pos) {
	size_t new_len = (len)? len : 2;
	m_buffer = new char [new_len];
	ACE_OS::memset (m_buffer, 0, new_len);
}

Data::~Data () {
	if (m_buffer) {
		delete m_buffer;
		m_buffer = 0;
	}
}

void Data::write_id (long id) {
	long object_id = id - 100000;

	if (object_id > 0) {
		char buffer [BUFFER_SIZE];
		mpcxc_ltoa (object_id, buffer, 10);
		this->write (buffer, ACE_OS::strlen (buffer));
	} else {
		LOG_W (("%s: invalid object id %d", GDS_CURRENT_FUNCTION, object_id));
	}
}

void Data::write_ref (long id, long sub, const ParaInfo* info) {
	long object_id = 0;

	if (id) {
		object_id = id - 100000;
	} else {
		object_id = static_cast<long> (info->m_doc_id) - 100000;
	}

	if (object_id > 0) {
		char buffer [BUFFER_SIZE];

		if (sub) {
			ACE_OS::sprintf (buffer, "%ld.%ld", object_id, sub);
		} else {
			ACE_OS::sprintf (buffer, "%ld", object_id);
		}

		this->write (buffer, ACE_OS::strlen (buffer));
	} else {
		LOG_W ((
			"%s: invalid object id %d, doc %d, para %d"
			, GDS_CURRENT_FUNCTION
			, object_id
			, info->m_doc_id
			, info->m_para
		));
	}
}

//////////////////////////////////////////////////////////////////////////////////////////
// NsrcGenerator_i implementation

NsrcGenerator_i::NsrcGenerator_i (
	NsrcGenerator_i::Writer writer
	, void* user_data
	, GeneratorHelper* helper
	, const char* text
	, long text_len
	, const ParaInfo* info
	, const std::map<long,std::string>* map_blob_name_ptr
)
	: GeneratorData (helper, text, text_len, info)
	, m_style (0)
	, m_length (0)
	, m_obj_pos (0)
	, m_counter (1)
	, m_is_visible (true)
	, m_is_tab_stops (false)
	, m_writer (writer)
	, m_user_data (user_data)
	, map_blob_name (map_blob_name_ptr) {
}

NsrcGenerator_i::~NsrcGenerator_i () { 
	destroy <DataVect>::vect (m_style_data);
}

//////////////////////////////////////////////////////////////////////////////////////////

void NsrcGenerator_i::open_style () {
	if (m_is_visible == false) {
		this->write <char> (AT_PRINT);
	}
	if (m_style) {
		this->write <char> (m_style);
	}
}

void NsrcGenerator_i::close_style () {
	if (m_style) {
		this->write <char> (m_style);
	}
	if (m_is_visible == false) {
		this->write <char> (AT_PRINT);
	}
}

void NsrcGenerator_i::restore_bitmap_link () {
	if (m_info && m_info->m_object_id > 0) {
		long object_id = static_cast<long> (m_info->m_object_id) - 100000;

		if (object_id > 0) {
			char buffer [2 * BUFFER_SIZE];
			ACE_OS::sprintf (buffer, "См. %cграфическое изображение%c%ld%c", AT_XREF, AT_XREF, object_id, AT_XREF);
			GCL::string_recoding (GCL::cd_win, GCL::cd_dos, buffer, 0);

			size_t len = ACE_OS::strlen (buffer);

			ACE_OS::memcpy (m_buffer.ptr () + m_length, buffer, len);
			m_length += len;
		} else {
			LOG_W (("%s: invalid object id %d", GDS_CURRENT_FUNCTION, object_id));
		}
	}
}

void NsrcGenerator_i::sort_identicals (bool is_close_style) {
	bool is_identical = false;

	Styles::iterator it = m_styles.begin (), it_end = m_styles.end (), next_it, s_it, safe_it = it_end;

	Styles tmp;
	tmp.reserve (4);

	for (; it != it_end; ++it) {
		next_it = it + 1;

		if (next_it != it_end) {
			if (is_close_style) {
				is_identical = (it->m_pos == next_it->m_pos && it->m_id < 0 && next_it->m_id < 0);
			} else {
				is_identical = (it->m_pos == next_it->m_pos && it->m_id > 0 && next_it->m_id > 0);
			}
		}

		if (next_it != it_end && is_identical) {
			tmp.push_back (Style (it->m_style, 0, -it->m_id));

			if (safe_it == it_end) {
				safe_it = it;
			}
		} else if (tmp.empty () == false) {
			tmp.push_back (Style (it->m_style, 0, -it->m_id));

			for (s_it = tmp.begin (); s_it != tmp.end (); ++s_it) {
				Styles::iterator find_it = std::find (m_styles.begin (), m_styles.end (), *s_it);

				if (find_it != tmp.end ()) {
					s_it->m_pos = std::distance (m_styles.begin (), find_it);
				}
			}

			std::sort (tmp.begin (), tmp.end (), compare_great);

			for (s_it = tmp.begin (); s_it != tmp.end (); ++s_it, ++safe_it) {
				safe_it->m_id = -s_it->m_id;
				safe_it->m_style = s_it->m_style;
			}

			safe_it = it_end;

			tmp.clear ();
		}
	}
}

void NsrcGenerator_i::sort_styles () {
	if (IS_DUMP) {
		dump (m_styles);
	}

	// Сортируем по позициям
	std::sort (m_styles.begin (), m_styles.end ());

	if (IS_DUMP) {
		dump (m_styles);
	}

	// Сортировка находящихся на одной позиции "открывающих скобок"
	this->sort_identicals (false);

	if (IS_DUMP) {
		dump (m_styles);
	}

	// Сортировка находящихся на одной позиции "закрывающих скобок"
	this->sort_identicals (true);

	if (IS_DUMP) {
		dump (m_styles);
	}

	// Поиск стилевого оформления внутри ссылки. Если найдено, то обнуляем элемент в векторе стилей.

	bool is_ref = false, is_bad = false;

	for (Styles::iterator it = m_styles.begin (); it != m_styles.end (); ++it) {
		if (it->m_style == AT_XREF) {
			is_ref = !is_ref;
		} else if (is_ref) {
			it->clear ();
			is_bad = true;
		}
	}

	// Если существуют оформления внутри ссылки, то удаляем их.
	if (is_bad) {
		Styles::iterator it = std::remove_if (m_styles.begin (), m_styles.end (), StyleCompare ());
		m_styles.erase (it, m_styles.end ());
	}

	if (IS_DUMP) {
		dump (m_styles);
	}
}

void NsrcGenerator_i::write_segments () {
	size_t offset = 0;

	this->sort_styles ();

	DataVect::const_iterator data_it = m_style_data.begin ();
	Styles::const_iterator it = m_styles.begin (), it_end = m_styles.end (), next_it;

	this->write_text (it->m_pos, offset); // add text before first style

	for (; it != it_end; ++it) {
		this->write <char> (it->m_pos + m_length, it->m_style);

		if (data_it != m_style_data.end () && (*data_it)->m_pos == it->m_pos) {
			this->write_data (it->m_pos + m_length, *data_it);
			++data_it;
		}

		next_it = it + 1;

		if (next_it != it_end) {
			if (next_it->m_pos >= it->m_pos) {
				this->write_text (next_it->m_pos - it->m_pos, offset); // add text between styles
			} else {
#ifdef _DEBUG
				LOG_W ((
					"%s: invalid segment's length: topic %d, para %d"
					, GDS_CURRENT_FUNCTION
					, m_info->m_doc_id
					, m_info->m_para
				));
#else
				m_helper->log ("Warning: invalid segment's length: topic %d, para %d", m_info);
#endif
			}
		}
	}

	if (m_text_len >= (long) offset) {
		this->write_text (m_text_len - offset, offset); // add text after last style
	} else {
#ifdef _DEBUG
		LOG_W ((
			"%s: invalid segment's length: topic %d, para %d"
			, GDS_CURRENT_FUNCTION
			, m_info->m_doc_id
			, m_info->m_para
		));
#else
		m_helper->log ("Warning: invalid segment's length: topic %d, para %d", m_info);
#endif
	}
}

// Запись текста в буфер (m_buffer) c nsr, где:
// count - количество записываемых символов
// offset - смещение на текущий фрагмент текста в буффере c текстом параграфа (m_text)

void NsrcGenerator_i::write_text (size_t count, size_t& offset) {
	if (count) {
		// смещение в буффере m_buffer, равное сумме текущей (!) длины и смещения в буффере с текстом
		size_t l_offset = m_length + offset; 

		ObjectSegments::iterator it = m_objects.begin () + m_obj_pos;

		for (size_t i = 0; i < count; ++i) {
			m_buffer.inout () [i + l_offset] = m_text ? m_text [i + offset] : m_buffer.inout () [i + l_offset - 1];

			if (m_text && m_text [i + offset] == '*') {
				it = std::find (it, m_objects.end (), offset + i + 1);

				if (it != m_objects.end ()) {
					it->pos.m_start += m_length;
					it->pos.m_finish = it->pos.m_start;
					m_obj_pos = std::distance (m_objects.begin (), it) + 1;
					++it;
				}
			}
		}

		offset += count;
	}
}

void NsrcGenerator_i::write_data (size_t pos, const Data* data) {
	if (data->m_len) {
		ACE_OS::memcpy (m_buffer.ptr () + pos, data->m_buffer, data->m_len);
		m_length += data->m_len;
	}
}

char* NsrcGenerator_i::get_style_buffer (size_t& len) {
	Buffer_aptr ret = new char [BUFFER_SIZE];

	if (m_style_command.m_style == PS_STYLENUM) {
		ACE_OS::sprintf (
			ret.inout ()
			, "!STYLE #%s"
			, m_style_command.get_str_margins (m_margins)
		);
	} else {
		ACE_OS::sprintf (
			ret.inout ()
			, "!STYLE %c %s"
			, m_style_command.get_str_style ()
			, m_style_command.get_str_margins (m_margins)
		);
	}

	if (m_style_command.print_font_size) {
		std::string str = " H";
		str += boost::lexical_cast <std::string> (m_style_command.print_font_size);
		ACE_OS::strcat (ret.inout (), str.c_str ());
	}

	len = ACE_OS::strlen (ret.in ());
	return ret._retn ();
}

void NsrcGenerator_i::write () {
	m_buffer = new char [MAX_PARA_LEN];

	if (m_info && m_info->m_object_id > 0) {
		m_style = AT_SEL3;
		m_is_visible = false;
	}

	this->open_style ();
	{
		if (m_info && m_info->m_object_id > 0) {
			this->restore_bitmap_link ();
		}

		if (m_styles.empty ()) {
			size_t offset = 0;
			this->write_text (m_text_len, offset); // add text without segments styles
		} else {
			this->write_segments (); // add text with segments styles
		}

		m_length += m_text_len;
	}
	this->close_style ();

	m_buffer.inout () [m_length] = '\0';

	size_t flags = (m_info)? m_info->m_flags : 0;

	if (flags & ENDT_SBS) {
		m_writer (m_user_data, 0, 0, m_buffer.in (), static_cast<long> (m_length), flags);
	} else {
		size_t style_len = 0;
		Buffer_aptr style (this->get_style_buffer (style_len));

		if (m_objects.empty () == false) {
			std::string res;

			ObjectSegments::const_iterator it = m_objects.begin ();

			size_t buf_size = ACE_OS::strlen (m_buffer.in ());

			for (size_t i = 0; i < buf_size; ++i) {
				char ch = m_buffer.ptr () [i];

				if (ch == '*' && it != m_objects.end () && it->pos.m_start - 1 <= i && i <= it->pos.m_start + 1) {
					res += AT_FORMULA;

					if (it->pic_info.is_nil ()) {
						res += it->text; // формула
					} else {
						const GeneratorData::PicInfo* info = it->pic_info.in ();
						std::string _res;

						if (info->topic > 0) {
							if (map_blob_name) {
								std::map<long,std::string>::const_iterator map_it = map_blob_name->find (info->topic);
								if (map_it != map_blob_name->end ()) {
									_res += "pic:";
									_res += map_it->second;
									_res += ";";
								}
							}
							char buffer [64];
							mpcxc_ltoa (info->topic - ID_BORDER, buffer, 10);
							_res += "topic:";
							_res += buffer;
						}
						if (info->res > 0) {
							if (_res.empty () == false) _res += ';';
							_res += "res:" + boost::lexical_cast <std::string> (info->res);
						}
						if (it->bloffs > 0) {
							if (_res.empty () == false) _res += ';';
							_res += "bloffs:" + boost::lexical_cast <std::string> (it->bloffs);
						}
						if (info->height > 0) {
							if (_res.empty () == false) _res += ';';
							_res += "height:" + boost::lexical_cast <std::string> (info->height);
						}
						if (info->width > 0) {
							if (_res.empty () == false) _res += ';';
							_res += "width:" + boost::lexical_cast <std::string> (info->width);
						}

						res += _res;
					}

					res += AT_FORMULA;
					++it;
				} else {
					res += ch;
				}
			}

			if (res.empty () == false) {
				ACE_OS::strcpy (m_buffer.inout (), res.c_str ());
				m_buffer.ptr () [res.size ()] = 0;
			}
		}

		m_writer (m_user_data, style._retn (), static_cast<long> (style_len), m_buffer._retn (), static_cast<long> (m_length), flags);
	}
}

void NsrcGenerator_i::add_segment (char style) {
	Style item;
	item.m_style = style;
	item.m_id = static_cast<long> (m_counter);

	if (m_position.m_start > 0) {
		item.m_pos = m_position.m_start - 1;
	} else {
		item.m_pos = 0;
	}

	m_styles.push_back (item);

	item.m_id = -item.m_id;
	item.m_pos = m_position.m_finish;

	m_styles.push_back (item);

	++m_counter;
}

void NsrcGenerator_i::add_object_segment () {
	m_object_segment->pos.m_start = m_position.m_start;
	m_object_segment->pos.m_finish = m_position.m_finish;
	m_objects.push_back (*(m_object_segment.in ()));
	m_object_segment = 0;
}

void NsrcGenerator_i::add_link () {
	size_t max_value = std::numeric_limits <long>::max ();

	if (m_position.m_start > m_position.m_finish 
		|| m_position.m_start >= max_value
		|| m_position.m_finish >= max_value
	) {
		m_helper->log ("Warning: invalid link: topic %d, para %d", m_info);
		delete m_link;
		m_link = 0;
		return;
	}

	this->add_segment (AT_XREF);

	long pos = 0, count = 1;

	if (m_link->m_type == CI_MULTI) {
		count = 0;

		if (m_helper) {
			count = m_helper->get_ref_count (m_info->m_para, m_link_offset, pos);
		}

		if (count == 0) {
#ifdef _DEBUG
			LOG_W ((
				"%s: data for multi link not found: topic %d, para %d"
				, GDS_CURRENT_FUNCTION
				, m_info->m_doc_id
				, m_info->m_para
			));
#else
			m_helper->log ("Warning: data for multi link not found: topic %d, para %d", m_info);
#endif
		}
	}

	Data_aptr item = new Data (count * BUFFER_SIZE, m_styles.back ().m_pos);

	if (item->is_valid ()) {
		if (count == 1) {
			char type = get_link_type (m_link->m_type);

			if (type == REFTYPE_BLOB) {
				item->write_id (m_link->m_id);
			} else {
				item->write_ref (m_link->m_id, m_link->m_sub, m_info);
			}
		} else if (count > 0 && m_helper) {
			const ParaId* ids = m_helper->get_ids ();
			const RespRef* resp_refs = m_helper->get_resp_refs ();

			long writed = 0;
			long para_id = ids [m_info->m_para];
			long ref_count = m_helper->get_refs_count ();

			for (long i = pos; i < ref_count; ++i) {
				if (resp_refs [i].ParaId == para_id) {
					if (resp_refs [i].Offset == m_link_offset) {
						item->write_ref (resp_refs [i].DocId, resp_refs [i].Sub, m_info);
						++writed;
						if (writed < count) {
							item->write <char> (' ');
						}
					}
				} else {
					break;
				}
			}
		}

		item->write <char> (AT_XREF);
		++m_link_offset;

		m_style_data.push_back (item._retn ());

	} else {
		GDS_ASSERT_MSG (0, ("%s: create link data", GDS_CURRENT_FUNCTION));
	}

	delete m_link;
	m_link = 0;
}

void NsrcGenerator_i::set_style (long value) {
	if (m_starts == 1) {
		if (m_style_command.set_style (value)) {
			if (m_style_command.m_style != PS_VERSION) {
				return;
			}
		}
		switch (value) {
			case EVD::sa_TxtHeader1:
				m_style = AT_SEL1;
				m_style_command.m_style = PS_CENTERED;
				break;
			case EVD::sa_TxtComment:
			case EVD::sa_VersionInfo:
				m_style = AT_SEL3;
				m_is_visible = false;
				break;
			case EVD::sa_Contents:
				m_style = AT_PRINT;
				break;
			case EVD::sa_TxtOutOfDate:
				m_style = AT_SEL6;
				break;
			case EVD::sa_NotApplied:
				m_style = AT_FUT;
				break;
			default:
				m_style_command.m_style = PS_STYLENUM;
				break;
		}
	} else {
		switch (value) {
			case EVD::sa_TxtHeader1:
			case EVD::sa_ColorSelection:
				this->add_segment (AT_SEL1);
				break;
			case EVD::sa_TxtComment:
				this->add_segment (AT_SEL3);
				break;
			case EVD::sa_Contents:
				this->add_segment (AT_PRINT);
				break;
			case EVD::sa_TxtOutOfDate:
				this->add_segment (AT_SEL6);
				break;
			case EVD::sa_NotApplied:
				this->add_segment (AT_FUT);
				break;
			case EVD::sa_HyperLinkCont:
				this->add_segment (AT_SEL2);
				break;
			default:
				GDS_ASSERT_MSG (0, ("%s: unknown segment style", GDS_CURRENT_FUNCTION));
				break;
		}
	}
}

void NsrcGenerator_i::set_visible (long value) {
	if (value == 0) {
		if (m_starts == 1) {
			m_is_visible = false;
		} else {
			this->add_segment (AT_PRINT);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

void NsrcGenerator_i::Start () {
	if (m_starts) {
		GDS_ASSERT_MSG (0, ("%s", GDS_CURRENT_FUNCTION));
	} 
	++m_starts;
}

void NsrcGenerator_i::Finish (bool is_need_undo) {
	if (--m_starts) {
		if (m_link) {
			this->add_link ();
		}
		if (m_object_segment.is_nil () == false) {
			this->add_object_segment ();
		}
		m_is_tab_stops = false;
	} else if (m_writer && m_user_data) {
		this->write ();
	}
}

void NsrcGenerator_i::StartTag (long tag_id) {
	++m_starts;

	switch (tag_id) {
		case evd::ti_TabStops:
			m_is_tab_stops = true;
			break;
		default:
			LOG_W (("%s: unknown tag %d, para: %d", GDS_CURRENT_FUNCTION, tag_id, m_info->m_para));
			break;
	}
}

void NsrcGenerator_i::StartChild (long tag_id) {
	if (tag_id != evd::id_TextPara) {
		++m_starts;

		switch (tag_id) {
			case evd::id_TextPara:
			case evd::id_Mark:
			case evd::id_Address:
			case evd::id_TextSegment: // ignored
				break;
			case evd::id_Formula:
				break;
			case evd::id_BitmapPara:
				if (m_object_segment.is_nil () == false) {
					m_object_segment->pic_info = new PicInfo;
				}
				break;
			case evd::id_ObjectSegment:
				m_object_segment = new GeneratorData::ObjectSegment;
				break;
			case evd::id_HyperLink:
				m_link = new GeneratorData::Link;
				break;
			default:
				break;
		}
	}
}

void NsrcGenerator_i::AddIntegerAtom (long tag_id, long value) {
	switch (tag_id) {
		case evd::ti_Type:
			if (m_link) {
				m_link->m_type = value;
			} 
			break;
		case evd::ti_SubID:
			if (m_link) {
				m_link->m_sub = value;
			}
			break;
		case evd::ti_DocID:
		case evd::ti_Revision:
			if (m_link) {
				m_link->m_id = value;
			}
			break;
		case evd::ti_Style:
			this->set_style (value);
			break;
		case evd::ti_Start:
			if (m_is_tab_stops) {
				m_style_command.set_style_d (static_cast<long> (inch2int (value)));
			} else {
				m_position.m_start = (value > 0)? value : 0;
			}
			break;
		case evd::ti_Finish:
			m_position.m_finish = (value > 0)? value : 0;
			break;
		case evd::ti_Visible:
			this->set_visible (value);
			break;
		case evd::ti_Flags: // comment handle (ignored)
			break;
		case evd::ti_Justification:
			m_style_command.set_style (value, true);
			break;
		case evd::ti_LeftIndent:
			m_margins.m_left = inch2int (value);
			break;
		case evd::ti_FirstIndent:
			m_margins.m_red_line = inch2int (value);
			break;
		case evd::ti_PrintFontSize:
			m_style_command.print_font_size = value;
			break;
		case evd::ti_BaseLine:
			GDS_ASSERT (m_object_segment.is_nil () == false);
			m_object_segment->bloffs = value;
			break;
		case evd::ti_DPI: 
			if (m_object_segment.is_nil () == false) {
				m_object_segment->pic_info->res = value;
			}
			break;
		case evd::ti_ExternalHandle:
			if (m_object_segment.is_nil () == false) {
				m_object_segment->pic_info->topic = value;
			}
			break;
		case evd::ti_Height:
			if (m_object_segment.is_nil () == false) {
				m_object_segment->pic_info->height = value;
			}
			break;
		case evd::ti_Width:
			if (m_object_segment.is_nil () == false) {
				m_object_segment->pic_info->width = value;
			}
			break;
		default:
			LOG_W (("%s: unknown tag %d, para: %d", GDS_CURRENT_FUNCTION, tag_id, m_info->m_para));
			break;
	}
}

void NsrcGenerator_i::StartDefaultChild (void) {
	++m_starts;
}

void NsrcGenerator_i::AddBoolAtom (long tag_id, bool value) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

void NsrcGenerator_i::AddStringAtom (long tag_id, const char* buf, long len, long code_page) {
	if (m_object_segment.is_nil () == false) {
		if (tag_id == evd::ti_Text) {
			m_object_segment->text = buf;
			GCL::string_recoding (GCL::cd_win, GCL::cd_dos, &(*m_object_segment->text.begin ()), 0);
		}
	} else if (tag_id != evd::ti_Name && tag_id != evd::ti_Text) {
		GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
	}
}

void NsrcGenerator_i::AddStreamAtom (long tag_id, GCI::IO::Stream* stream) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

void NsrcGenerator_i::AddMemAtom (long tag_id, const char* mem_buf, long len) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

void NsrcGenerator_i::AddRawData (const char* mem_buf, long len) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

void NsrcGenerator_i::AddTransparentAtom (unsigned short atom_index) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

///////////////////////////////////////////////////////////////////////////////////////

RespGenerator_i::RespGenerator_i (
	RespGenerator_i::Writer writer
	, LongVector* vect
	, GeneratorHelper* helper
	, const char* text
	, long text_len
	, const ParaInfo* info
	, const std::map<long,std::string>* map_blob_name
) 
	: GeneratorData (helper, text, text_len, info)
	, m_resp_vect (vect) {
}

RespGenerator_i::~RespGenerator_i () { 
	if (m_link) {
		delete m_link;
		m_link = 0;
	}
}

void RespGenerator_i::add () {
	if (m_link->m_type == CI_MULTI) {
		if (m_helper) {
			if (m_helper->is_valid ()) {
				m_helper->add_to_vector (*m_resp_vect, m_info->m_para, m_link_offset);
			}
		}
	} else if (m_link->m_id) {
		m_resp_vect->push_back (m_link->m_id);
	} 

	++m_link_offset;

	delete m_link;
	m_link = 0;
}

void RespGenerator_i::Start () {
	if (m_starts) {
		GDS_ASSERT_MSG (0, ("%s", GDS_CURRENT_FUNCTION));
	} 
	++m_starts;
}

void RespGenerator_i::Finish (bool is_need_undo) {
	if (--m_starts) {
		if (m_link) {
			this->add ();
		}
	}
}

void RespGenerator_i::StartTag (long tag_id) {
	++m_starts;
}

void RespGenerator_i::StartChild (long tag_id) {
	if (tag_id != evd::id_TextPara) {
		++m_starts;
		if (tag_id == evd::id_HyperLink) {
			m_link = new GeneratorData::Link;
		} if (tag_id == evd::id_BitmapPara) {
			m_link = new GeneratorData::Link;
		}
	}
}

void RespGenerator_i::AddIntegerAtom (long tag_id, long value) {
	if (m_link) {
		switch (tag_id) {
		case evd::ti_ExternalHandle:
			m_link->m_id = value;
			break;
		case evd::ti_Type:
			m_link->m_type = value;
			break;
		case evd::ti_SubID:
			m_link->m_sub = value;
			break;
		case evd::ti_DocID:
		case evd::ti_Revision:
			m_link->m_id = value;
			break;
		default:
			break;
		}
	}
}

void RespGenerator_i::StartDefaultChild (void) {
	++m_starts;
}

void RespGenerator_i::AddBoolAtom (long tag_id, bool value) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

void RespGenerator_i::AddStringAtom (long tag_id, const char* buf, long len, long code_page) {
	if (tag_id != evd::ti_Name && tag_id != evd::ti_Text) {
		GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
	}
}

void RespGenerator_i::AddStreamAtom (long tag_id, GCI::IO::Stream* stream) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

void RespGenerator_i::AddMemAtom (long tag_id, const char* mem_buf, long len) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

void RespGenerator_i::AddRawData (const char* mem_buf, long len) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

void RespGenerator_i::AddTransparentAtom (unsigned short atom_index) {
	GDS_ASSERT_MSG (0, ("%s: not supported", GDS_CURRENT_FUNCTION));
}

} // namespace
