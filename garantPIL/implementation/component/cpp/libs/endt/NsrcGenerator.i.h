//
// NsrcGenerator.i.h : inline implementation file
//

#include "shared/Core/sys/assert.h"
#include "Defines.h"
#include "common/components/rtl/Garant/EVD/evddata.h"
#include "common/components/rtl/Garant/EVD/Types/Types.h"
#include "common/components/rtl/Garant/EVD/Styles/Styles.h"

namespace EndtTools {

	struct StyleCompare {
		inline bool operator () (const Style& val) const {
			return (val.m_id == 0 && val.m_pos == 0 && val.m_style == 0);
		}
	};

	inline char NsrcGenerator_i::StyleCommand::get_str_style () {
		char ret = '?';
		switch (m_style)	{
		case PS_STYLENUM:
			ret = '#';
			break;
		case PS_PREFORMATTED:
			ret = 'P';
			break;
		case PS_CENTERED:
			ret = 'C';
			break;
		case PS_JUSTIFIED:
			ret = 'J';
			break;
		case PS_RIGHT:
			ret = 'R';
			break;
		case PS_SIDEBYSIDE:
			ret = 'S';
			break;
		case PS_LEFT:
			ret = 'L';
			break;
		case PS_VERSION:
			ret = 'V';
			break;
		case PS_STYLED:
			ret = 'D';
			break;
		default:
			ret = 'J';
			break;
		}
		return ret;
	}

	inline void NsrcGenerator_i::StyleCommand::set_style_d (long start) {
		char buffer [64];
		ACE_OS::sprintf (buffer, "%ld 73 0", start);

		m_style = PS_STYLED;
		m_str_margin = buffer;
	}

	inline bool NsrcGenerator_i::StyleCommand::set_style (long value, bool is_justify) {
		if (m_style == 0) {
			if (is_justify) {
				switch (value) {
				case EVD::it_Center:
					m_style = PS_CENTERED;
					break;
				case EVD::it_Right:
					m_style = PS_RIGHT;
					break;
				}
			} else {
				switch (value) {
				case EVD::sa_NormalSBSLeft:
				case EVD::sa_NormalSBSRight:
					m_style = PS_SIDEBYSIDE;
					m_str_margin = "0 73 0";
					break;
				case EVD::sa_TxtNormalANSI:
					m_style = PS_JUSTIFIED;
					m_str_margin = "0 73 5";
					break;
				case EVD::sa_ArticleHeader:
					m_style = PS_JUSTIFIED;
					m_str_margin = "15 55 5";
					break;
				case EVD::sa_NormalNote:
					m_style = PS_JUSTIFIED;
					m_str_margin = "1 73 1";
					break;
				case EVD::sa_DictEntry:
					m_style = PS_JUSTIFIED;
					m_str_margin = "0 72 0";
					break;
				case EVD::sa_ToLeft:
					m_style = PS_LEFT;
					m_str_margin = "0 73 0";
					break;
				case EVD::sa_TxtNormalOEM:
					m_style = PS_PREFORMATTED;
					break;
				case EVD::sa_VersionInfo:
					m_style = PS_VERSION;
					m_str_margin = "1 72 1";
					break;
				default:
					m_style = PS_STYLENUM;
					char buffer [16];
					ACE_OS::sprintf (buffer, "%ld", abs (value));
					m_str_margin = buffer;
					break;
				}
			}
		}

		return m_style != 0;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	inline size_t inch2int (long value) { 
		size_t ret = 0;

		if (value) {
			float res = (float)(evd::eeCharsPerLine * value) / evd::eePaperWidth;
			ret = (size_t) (res + .5);
		}

		return ret;
	}

	inline char get_link_type (long type) {
		char ret = REFTYPE_UNKNOWN;

		switch (type) {
		case CI_REF:
		case CI_TOPIC:
		case CI_MULTI:
		case CI_EDITION:
		case CI_ENO:
		case CI_SCRIPT:
		case CI_PHARM_MULTI:
		case CI_SEARCH_QUERY:
			ret = REFTYPE_REFLIST;
			break;
		case CI_BLOB:
		case CI_PIC:
			ret = REFTYPE_BLOB;
			break;
		default:
			GDS_ASSERT_MSG (0, ("get_link_type: unknown type"));
			break;
		}

		return ret;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////

} // namespace 
