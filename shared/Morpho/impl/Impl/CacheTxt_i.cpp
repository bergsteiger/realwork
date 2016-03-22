////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/impl/Impl/CacheTxt_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::CacheTxt_i
//
// Реализация кэша словарей с загрузкой словарей из текстовых файлов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/impl/Impl/CacheTxt_i.h"
// by <<uses>> dependencies
#include <fstream>
#include "shared/GCL/str/str_conv.h"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/trim.hpp"

namespace Morpho {
namespace Impl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
CacheTxt_i::CacheTxt_i (const std::string& path)
//#UC START# *52DFE2E9029E_BASE_INIT*
	: m_path (path)
//#UC END# *52DFE2E9029E_BASE_INIT*
{
	//#UC START# *52DFE2E9029E_BODY*
	if (*(path.rbegin ()) != '\\') {
		m_path += "\\";
	}
	//#UC END# *52DFE2E9029E_BODY*
}

CacheTxt_i::~CacheTxt_i () {
	//#UC START# *52DFC25F02DE_DESTR_BODY*
	//#UC END# *52DFC25F02DE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// загрузка списка строк
void CacheTxt_i::load (const char* name, GCL::StrVector& out) {
	//#UC START# *52DFCDEB01CD*
	std::string full_path = m_path + name;

	std::ifstream ifs (full_path.c_str ());

	if (ifs) {
		std::string str;

		char buffer [128];

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false) {
				strcpy (buffer, str.c_str ());
				GCL::string_recoding (GCL::cd_dos, GCL::cd_win, buffer, 0);
				str = buffer;
				GCL::to_upper (str);
				out.push_back (str);
			}
		}

		std::sort (out.begin (), out.end ());

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, full_path.c_str ()));
	}
	//#UC END# *52DFCDEB01CD*
}

// загрузка постфиксов
void CacheTxt_i::load_postfixes (const char* name) {
	//#UC START# *52DFC6040396*
	std::string full_path = m_path + name;

	std::ifstream ifs (full_path.c_str ());

	if (ifs) {
		std::string str;

		char buffer [1024];

		Def::MorphoData& data = m_data->data;

		Def::StrStrMap tmp;

		GCL::StrVector parts;

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false) {
				strcpy (buffer, str.c_str ());
				GCL::string_recoding (GCL::cd_dos, GCL::cd_win, buffer, 0);

				boost::split (parts, buffer, boost::is_any_of (":"));

				GDS_ASSERT (parts.size () == 2);

				boost::trim (parts [0]);

				GCL::to_upper (parts [0]);
				GCL::to_upper (parts [1]);

				tmp [parts [0]] = parts [1];
			}
		}

		for (Def::StrStrMap::iterator it = tmp.begin (); it != tmp.end (); ++it) {
			data.postfixes.push_back ("");
			data.postfixes.push_back (it->first);

			boost::split (parts, it->second, boost::is_any_of (":;"));

			GDS_ASSERT (parts.empty () == false);

			for (GCL::StrVector::iterator _it = parts.begin (); _it != parts.end (); ++_it) {
				if (_it->empty () == false) {
					boost::trim (*_it);
					data.postfixes.push_back (*_it);
				}
			}
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, full_path.c_str ()));
	}
	//#UC END# *52DFC6040396*
}

// загрузка данных для псевдоморфологии
void CacheTxt_i::load_pseudo (const char* name) {
	//#UC START# *52DFC5DC012D*
	std::string full_path = m_path + name;

	std::ifstream ifs (full_path.c_str ());

	if (ifs) {
		std::string str;

		char buffer [128];

		Def::MorphoData& data = m_data->data;

		GCL::StrVector parts;

		while (!ifs.eof ()) {
			std::getline (ifs, str);

			if (str.empty () == false) {
				strcpy (buffer, str.c_str ());
				GCL::string_recoding (GCL::cd_dos, GCL::cd_win, buffer, 0);
				
				boost::split (parts, buffer, boost::is_punct ());

				GDS_ASSERT (parts.size () == 2);

				boost::trim (parts [0]);
				boost::trim (parts [1]);

				GCL::to_upper (parts [0]);
				GCL::to_upper (parts [1]);

				data.pseudo [parts [0]] = parts [1];
			}
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, full_path.c_str ()));
	}
	//#UC END# *52DFC5DC012D*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Def::ICache
// очистить кэш
void CacheTxt_i::clear () {
	//#UC START# *4E11F18F00AD_52DFC25F02DE*
	GUARD (m_mutex);
	m_data.release ();
	//#UC END# *4E11F18F00AD_52DFC25F02DE*
}

// implemented method from Def::ICache
// исключаемые
const Def::Exclude& CacheTxt_i::get_exclude () const {
	//#UC START# *531893830396_52DFC25F02DE*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *531893830396_52DFC25F02DE*
}

// implemented method from Def::ICache
// вектор опечаток и их исправлений
const Def::FixedPairs& CacheTxt_i::get_fixed_pairs () const {
	//#UC START# *549996DE0286_52DFC25F02DE*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *549996DE0286_52DFC25F02DE*
}

// implemented method from Def::ICache
// данные для морфоанализа
const Def::MorphoData& CacheTxt_i::get_morpho_data () const {
	//#UC START# *4E035CC30254_52DFC25F02DE*
	GDS_ASSERT (m_data.is_nil () == false);
	return m_data->data;
	//#UC END# *4E035CC30254_52DFC25F02DE*
}

// implemented method from Def::ICache
// ненормализуемые
const GCL::StrVector& CacheTxt_i::get_not_normalized () const {
	//#UC START# *53188CFC0357_52DFC25F02DE*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *53188CFC0357_52DFC25F02DE*
}

// implemented method from Def::ICache
// вектор синонимичных пар
const Def::FixedPairs& CacheTxt_i::get_syn_pairs () const {
	//#UC START# *54F5A6E800E1_52DFC25F02DE*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *54F5A6E800E1_52DFC25F02DE*
}

// implemented method from Def::ICache
// загрузка
void CacheTxt_i::load (DBCore::IBase* base) {
	//#UC START# *5151CA3C01F0_52DFC25F02DE*
	GUARD (m_mutex);

	if (m_data.is_nil ()) {
		m_data = new Def::CacheData ();
	} else {
		return;
	}

#ifdef _DEBUG
	Core::GDS::StopWatch sw ("%s: load morpho cache", GDS_CURRENT_FUNCTION);
#endif

	try {
		// Загрузка данных для псевдоморфологии
		this->load_pseudo ("endings.txt");
		// Загрузка словаря постфиксов
		this->load_postfixes ("support_words.txt");
		// Загрузка словаря префиксов
		this->load ("prefixes.txt", m_data->data.prefixes);
		// Загрузка словаря стоп-лемм
		this->load ("stop_lemms.txt", m_data->data.stop_lemmas);
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
	//#UC END# *5151CA3C01F0_52DFC25F02DE*
}
} // namespace Impl
} // namespace Morpho

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

