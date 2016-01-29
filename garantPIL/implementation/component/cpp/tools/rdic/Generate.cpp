//
// Generate.cpp : implementation file
//

#include "ace/ACE.h"
#include "ace/Dirent.h"
#include "ace/Dirent_Selector.h"

#include <fstream>

#include "shared/GCL/str/str_conv.h"

#include "Generate.h"

namespace DictGenerator {

static const size_t LEMMA_BUF_LEN = 1024 * 8; // размер буффера

static const std::string LID_SIGN = "LID:";

/////////////////////////////////////////////////////////////////////////////////////////////////////

struct DicSelector {
	#define DIC_EXT ".dic"

	static int selector (const dirent* d) {
		if (!d->d_name) {
			return false;
		}

		size_t size = ACE_OS::strlen (d->d_name);

		if (size < 5) {
			return false;
		}

		return ACE_OS::strncmp (d->d_name + size - sizeof (DIC_EXT) + 1, DIC_EXT, sizeof (DIC_EXT) - 1) == 0 ? true : false;
	}

	#undef DIC_EXT
};

/////////////////////////////////////////////////////////////////////////////////////////////////////

Generator::Generator (const std::string& src, const std::string& dst, bool is_instrumentalis) 
	: m_is_instrumentalis (is_instrumentalis)
{
	m_src = platform_independent_path (src);
	m_src += "\\";
	m_dst = platform_independent_path (dst);
	m_dst += "\\";

	m_buf = new char [LEMMA_BUF_LEN];

	m_adapter = Adapters::MLMA32RUAdapterSingleton::instance ();
}

Generator::~Generator () {
}

void Generator::execute () {
	if (m_adapter == 0) {
		return;
	}

	ACE_Dirent_Selector selector;

	int status = selector.open (m_src.c_str (), DicSelector::selector);

	GDS_ASSERT (status != -1);

	size_t len = (size_t) selector.length ();

	for (size_t i = 0; i < len; ++i) {
		this->execute (selector [i]->d_name);
	}

	status = selector.close ();

	GDS_ASSERT (status != -1);
}

void Generator::execute (const char* name) {
	ACE_OS::printf ("%s\n", name);

	std::string in_name = name;

	size_t pos = in_name.rfind ("dic");

	if (pos != std::string::npos) {
		std::string out_name = in_name.substr (0, pos) + "rdic";

		std::ifstream ifs ((m_src + name).c_str ());

		if (ifs) {
			std::ofstream ofs ((m_dst + out_name).c_str (), std::ios_base::trunc);

			if (ofs) {
				std::string str;

				size_t i = 0;

				while (!ifs.eof ()) {
					if (i++) {
						ofs << std::endl;
					}

					std::getline (ifs, str);

					if (str.empty () == false) {
						if (str [0] != '/' && str [1] != '/') {
							this->modify_str (str);
						}
					}

					ofs << str;
				}

				ofs.close ();
			} else {
				LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, out_name.c_str ()));
			}

			ifs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, name));
		}
	} else {
		LOG_W (("%s: invalid file ext", GDS_CURRENT_FUNCTION));
	}
}

void Generator::modify_str (std::string& str) {
	size_t pos = str.find (' ');

	if (pos != std::string::npos) {
		std::string word = str.substr (0, pos);

		size_t pos = str.rfind (LID_SIGN.c_str ());

		if (pos != std::string::npos) {
			unsigned long lid = 0;

			if (pos + LID_SIGN.size () < str.size ()) {
				lid = (unsigned long) atol (str.substr (pos + LID_SIGN.size ()).c_str ());
			} else {
				LOG_W (("%s: invalid LID: str: %s", GDS_CURRENT_FUNCTION, str.c_str ()));
			}

			GCL::string_recoding (GCL::cd_dos, GCL::cd_win, &(*word.begin ()));

			GCL::StrSet forms;

			if (m_is_instrumentalis) {
				if (this->insert_forms (5, lid, forms) == 0) {
					forms.insert (word);
				}
			} else {
				for (size_t i = 0; i < 255; ++i) {
					if (this->insert_forms (i, lid, forms) == 0) {
						forms.insert (word);
					}
				}
			}

			std::string part;

			GCL::StrSet::const_iterator it_begin = forms.begin (), it_end = forms.end ();

			for (GCL::StrSet::const_iterator it = it_begin; it != it_end; ++it) {
				if (it != it_begin) {
					part += "; ";
				}
				part += *it;
			}

			GCL::string_recoding (GCL::cd_win, GCL::cd_dos, &(*part.begin ()));

			str += " : ";
			str += part;
		} else {
			LOG_W (("%s: LID not found: str: %s", GDS_CURRENT_FUNCTION, str.c_str ()));
		}
	} else {
		LOG_W (("%s: invalid string %s", GDS_CURRENT_FUNCTION, str.c_str ()));
	}
}

short Generator::insert_forms (unsigned char form_id, unsigned long lid, GCL::StrSet& forms) {
	short count = m_adapter->build_form (0, lid, 0, form_id, m_buf.inout (), LEMMA_BUF_LEN);

	if (count) {
		for (char* form = m_buf.ptr (); count > 0; --count, ++form) {
			forms.insert (form);
			form += ACE_OS::strlen (form);
		}
	} 

	return count;
}

//is_instrumentalis_for_naun

}
