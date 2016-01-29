////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/shared/GCI/impl/I18N_i/Messages_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::Messages_i
//
// –еализаци€ работы с локализованными строками
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/I18N_i/Messages_i.h"
#include "shared/GCI/impl/I18N_i/Environment.h"
// by <<uses>> dependencies
#include "shared/GCI/Unicode/Converters.h"
#include "shared/GCI/impl/I18N_i/Params.h"
#include "shared/GCI/I18N/I18N.h"

//#UC START# *452CCF1602FD_CUSTOM_INCLUDES*
#include <fstream>
#include <vector>
#include <locale.h>

#include "utf8/include/utf8.h"
//#UC END# *452CCF1602FD_CUSTOM_INCLUDES*

namespace GCI {
namespace I18N_i {

//#UC START# *452CCF1602FD*
void Messages_i::dump () const {
	for	(I18NStrings::const_iterator it = m_string_table.begin (); it != m_string_table.end (); ++it) {
		std::cout << "строка: " << it->first << std::endl;
		for	(L10NStrings::const_iterator it1 = it->second.begin (); it1 != it->second.end (); ++it1) {
			std::wcout << "\tперевод дл€: " << it1->first << "строка: " << it1->second << std::endl;
		}
		std::cout << "----------------" << it->first << std::endl;
	}
}
//#UC END# *452CCF1602FD*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// перевод строки utf в заданную локаль
const std::string Messages_i::utf_to_locale (const char* utf_string, I18N::SupportedLocales locale) {
	//#UC START# *455867B100FA*
	static const std::basic_string<unsigned char> utf (reinterpret_cast<const unsigned char*> ("\xD0\xB0\xD0\xB1\xD0\xB2\xD0\xB3\xD0\xB4\xD0\xB5\xD1\x91\xD0\xB6\xD0\xB7\xD0\xB8\xD0\xB9\xD0\xBA\xD0\xBB\xD0\xBC\xD0\xBD\xD0\xBE\xD0\xBF\xD1\x80\xD1\x81\xD1\x82\xD1\x83\xD1\x84\xD1\x85\xD1\x86\xD1\x87\xD1\x88\xD1\x89\xD1\x8A\xD1\x8B\xD1\x8C\xD1\x8D\xD1\x8E\xD1\x8F\xD0\x90\xD0\x91\xD0\x92\xD0\x93\xD0\x94\xD0\x95\xD0\x81\xD0\x96\xD0\x97\xD0\x98\xD0\x99\xD0\x9A\xD0\x9B\xD0\x9C\xD0\x9D\xD0\x9E\xD0\x9F\xD0\xA0\xD0\xA1\xD0\xA2\xD0\xA3\xD0\xA4\xD0\xA5\xD0\xA6\xD0\xA7\xD0\xA8\xD0\xA9\xD0\xAA\xD0\xAB\xD0\xAC\xD0\xAD\xD0\xAE\xD0\xAF"));
	static const std::string win ("абвгдеЄжзийклмнопрстуфхцчшщъыьэю€јЅ¬√ƒ≈®∆«»… ЋћЌќѕ–—“”‘’÷„ЎўЏџ№Ёёя");

	const unsigned char* src = reinterpret_cast<const unsigned char*>(utf_string);

	std::string result;
	switch (locale) {
		case I18N::SL_ENGLISH:
			return utf_string;
			break;
		case I18N::SL_RU_CP1251:
			for (size_t i = 0; i < ACE_OS::strlen (utf_string); ++i) {
				if (src[i] < '\x7F') {
					result += src [i];
					continue;
				}
				for (size_t j = 0, k = 0; j < 132; j += 2, ++k) {
					GDS_ASSERT ((i + 1) < (ACE_OS::strlen (utf_string)));
					if (src[i] == utf[j] && src[i+1] == utf[j+1]) {
						result += win [k];
						break;
					}
				}
				++i;
			}
			return result;
			break;
		case I18N::SL_TATAR:
			GDS_ASSERT (false && "not released for tatar locale");
			break;
		default:
			GDS_ASSERT (false && "unknown locale type");
			break;
	}

	return std::string ();
	//#UC END# *455867B100FA*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Messages_i::~Messages_i () {
	//#UC START# *452CCF1602FD_DESTR_BODY*
	//#UC END# *452CCF1602FD_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// вернуть текущую локаль
I18N::SupportedLocales Messages_i::get_current_locale () const {
	//#UC START# *452F62F60128*
	const char* locale = ::setlocale (LC_ALL, 0);

	return I18N::LocaleOperationsFactory::make ().string_to_locale (locale);
	//#UC END# *452F62F60128*
}

// вычитать из буфера строку
const char* Messages_i::get_string (const CharBuffer& buffer, size_t offset, size_t& length) const {
	//#UC START# *455861E901C5*
	unsigned long string_length = this->get_uint32 (buffer, offset);
	unsigned long string_offset = this->get_uint32 (buffer, offset + 4);

	if (string_offset + string_length + 1 > buffer.size ()) {
		LOG_E (("%s: i18n file is truncated", GDS_CURRENT_FUNCTION));
		throw I18N::BadFileFormat ();
	}
	if (buffer[string_offset + string_length] != '\0') {
		LOG_E (("%s: i18n file contains not null terminated string", GDS_CURRENT_FUNCTION));
		throw I18N::BadFileFormat ();
	}

	length = string_length + 1;  
	return (&buffer[string_offset]);
	//#UC END# *455861E901C5*
}

// вычитать из буфера 4-Єх байтовое бесзнаковое целое
unsigned long Messages_i::get_uint32 (const CharBuffer& buffer, size_t offset) const {
	//#UC START# *45585FE3001F*
	unsigned long b0, b1, b2, b3;

	const unsigned char* src = reinterpret_cast<const unsigned char*> (&buffer[0]);

	if ((offset + 4) > buffer.size ()) {
		// error
		return 0;
	}

	b0 = src[offset];
	b1 = src[offset + 1];
	b2 = src[offset + 2];
	b3 = src[offset + 3];

	unsigned long result;
	if (m_endian == ET_LITTLE_ENDIAN) {
		result = b0 | (b1 << 8) | (b2 << 16) | (b3 << 24);
	} else {
		result = (b0 << 24) | (b1 << 16) | (b2 << 8) | b3;
	}

	return result;
	//#UC END# *45585FE3001F*
}

// поиск пути дл€ перевода по установленной локали
const char* Messages_i::locale_to_path (I18N::SupportedLocales locale) const {
	//#UC START# *452CF20A0399*
	switch (locale) {
		case I18N::SL_RU_CP1251:
			return "ru_RU.CP1251";
			break;
		case I18N::SL_ENGLISH:
			return "en";
			break;
		case I18N::SL_TATAR:
			return "tt";
			break;
	}
	GDS_ASSERT (false && "unknown locale type");
	return ""; // NOT REACHED
	//#UC END# *452CF20A0399*
}

// разобрать файл с переводами
void Messages_i::read_file (const CharBuffer& buffer, I18N::SupportedLocales locale) {
	//#UC START# *455865F00138*
	const unsigned int MAGIC = 0x950412de;

	m_endian = ET_BIG_ENDIAN;
	unsigned long magic = this->get_uint32 (buffer, 0);
	if (magic != MAGIC) {
		m_endian = ET_LITTLE_ENDIAN;
		magic = this->get_uint32 (buffer, 0);
		if (magic != MAGIC) {
			LOG_E (("%s: i18n file has bad magic value", GDS_CURRENT_FUNCTION));
			throw I18N::BadFileFormat ();
		}
	}

	unsigned long revision = this->get_uint32 (buffer, sizeof (magic));

	switch (revision >> 16) {
		case 0:
			this->read_messages (buffer, locale);
			switch (revision & 0xffff) {
				case 0:
					break;
				case 1:
				default:
					LOG_W (("%s: i18n file has big minor number, part of translated strings can be lost", GDS_CURRENT_FUNCTION));
					break;
			}
			break;
		default:
			LOG_E (("%s: i18n file has big major number", GDS_CURRENT_FUNCTION));
			throw I18N::BadFileFormat ();
			break;
	}
	//#UC END# *455865F00138*
}

// разобрать таблицу сообщений
void Messages_i::read_messages (const CharBuffer& buffer, I18N::SupportedLocales locale) {
	//#UC START# *455866E103B9*
	unsigned long strings_number = this->get_uint32 (buffer, 2*sizeof (unsigned long));
	unsigned long orig_tab_offset = this->get_uint32 (buffer, 3*sizeof (unsigned long));
	unsigned long trans_tab_offset = this->get_uint32 (buffer, 4*sizeof (unsigned long));
	unsigned long hash_tab_size = this->get_uint32 (buffer, 5*sizeof (unsigned long));
	unsigned long hash_tab_offset = this->get_uint32 (buffer, 6*sizeof (unsigned long));

	for (size_t i = 0; i < strings_number; ++i) {
		size_t msgid_size;
		size_t msgstr_size;

		// ѕеред записью ключ надо перевести в кодировку ключей,
		// а значение - в utf16 (из utf8)
		const char* msgid = this->get_string (buffer, orig_tab_offset + i * 8, msgid_size);
		std::string key_string = Messages_i::utf_to_locale (msgid, m_default_locale);
		std::string msgstr (this->get_string (buffer, trans_tab_offset + i * 8, msgstr_size));
		std::wstring value_string;
		if (!utf8::is_valid (msgstr.begin (), msgstr.end ())) {
			GDS_ASSERT (false && "bad string encoding");
			continue;
		}
		utf8::utf8to16 (msgstr.begin (), msgstr.end (), std::back_inserter (value_string));
		I18NStrings::iterator it = m_string_table.find (key_string);
		if (it == m_string_table.end ()) {
			std::pair<I18NStrings::iterator, bool> result = 
				m_string_table.insert (I18NStrings::value_type (key_string, L10NStrings ()));
			if (!result.second) {
				LOG_D (("%s: can't add string for key %s (locale: %d)"
					, GDS_CURRENT_FUNCTION
					, key_string.c_str ()
					, locale
				));
			} else {
				std::pair<L10NStrings::iterator, bool> insertion = 
					result.first->second.insert (L10NStrings::value_type (locale, value_string));
				if (!insertion.second) {
					LOG_D (("%s: can't add string for key %s (locale: %d)"
						, GDS_CURRENT_FUNCTION
						, key_string.c_str ()
						, locale
					));
				}
			}
		} else {
			std::pair<L10NStrings::iterator, bool> insertion = 
				it->second.insert (L10NStrings::value_type (locale, value_string));
			if (!insertion.second) {
				LOG_D (("%s: can't add string for key %s (locale: %d)"
					, GDS_CURRENT_FUNCTION
					, key_string.c_str ()
					, locale
				));
			}
		}
	}  
	//#UC END# *455866E103B9*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from I18N::Messages
// очистить все строки дл€ заданного €зыка
void Messages_i::close (I18N::SupportedLocales locale) {
	//#UC START# *452CC0D401D4_452CCF1602FD*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *452CC0D401D4_452CCF1602FD*
}

// implemented method from I18N::Messages
// получить локализованную строку не в unicode
const std::string Messages_i::get (const char* key, I18N::SupportedLocales locale) const {
	//#UC START# *486B88150196_452CCF1602FD*
	// если запрошенна€ кодировка совпадает с кодировкой ключа, сразу возвращали ключ
	if (locale == m_default_locale) {
		return std::string (key);
	}
	const std::wstring utf16_message = this->getw (key, locale);
	I18N::SupportedLocales current_locale = I18N::LocaleOperationsFactory::make ().get_locale ();
	if (locale == current_locale) {
		return GCI::utf16_to_cp (utf16_message.c_str ());
	} else {
		class LocaleHelper {
		public:
			LocaleHelper (I18N::SupportedLocales from, I18N::SupportedLocales to) : m_from (from) {
				I18N::LocaleOperationsFactory::make ().set_locale (to);
			}
			~LocaleHelper () {
				I18N::LocaleOperationsFactory::make ().set_locale (m_from);
			}
		private:
			I18N::SupportedLocales m_from;
		} locale_helper (current_locale, locale);

		return GCI::utf16_to_cp (utf16_message.c_str ());;
	}

	GDS_ASSERT (false && "not reached");
	return std::string ();
	//#UC END# *486B88150196_452CCF1602FD*
}

// implemented method from I18N::Messages
// получить локализованную строку  не в unicode дл€ текущей системной локали (используетс€ значение
// LC_ALL!!!)
const std::string Messages_i::get (const char* key) const {
	//#UC START# *486B889B0078_452CCF1602FD*
	return this->get (key, I18N::LocaleOperationsFactory::make ().get_locale ());
	//#UC END# *486B889B0078_452CCF1602FD*
}

// implemented method from I18N::Messages
// получить локализованную шаблонную строку с подставленными параметрами не в unicode дл€ текущей
// системной локали (используетс€ значение LC_ALL!!!)
const std::string Messages_i::get (const char* key, const I18N::TemplateParamsList& template_params) const {
	//#UC START# *492D3F2200CF_452CCF1602FD*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *492D3F2200CF_452CCF1602FD*
}

// implemented method from I18N::Messages
// получить локализованную строку в utf16
const std::wstring Messages_i::getw (const char* key, I18N::SupportedLocales locale) const {
	//#UC START# *452CC100002E_452CCF1602FD*
	I18NStrings::const_iterator it = m_string_table.find (key);
	if (it == m_string_table.end ()) {
		// строки вообще нет в таблице
		return std::wstring (L"Key for localized string not found");
	}

	L10NStrings::const_iterator result = it->second.find (locale);
	if (
		(result == it->second.end ())
		&& (locale != I18N::SL_ENGLISH)
		&& (m_default_locale != I18N::SL_ENGLISH)
	   ) {
		result = it->second.find (I18N::SL_ENGLISH);
	}

	if (result == it->second.end ()) {
		return std::wstring (L"Localized string not found");
	} else {
		return result->second;
	}
	//#UC END# *452CC100002E_452CCF1602FD*
}

// implemented method from I18N::Messages
// получить локализованную строку дл€ текущей системной локали (используетс€ значение LC_ALL!!!)
const std::wstring Messages_i::getw (const char* key) const {
	//#UC START# *452F616F03A9_452CCF1602FD*
	return this->getw (key, I18N::LocaleOperationsFactory::make ().get_locale ());
	//#UC END# *452F616F03A9_452CCF1602FD*
}

// implemented method from I18N::Messages
// вычитать строки из файла
void Messages_i::open (
	const char* file
	, I18N::SupportedLocales locale
) /*throw (
	I18N::BadFileFormat
	, I18N::CantFindFile
)*/ {
	//#UC START# *452CC00003C8_452CCF1602FD*
	// {{{ http://mdp.garant.ru/x/hgDqBQ
  // удалить эту секцию, когда будет закрыт запрос
	if (locale == Environment::get_default_locale ()) {
		return;
	}
	// }}}

	const char* result = ACE_OS::strnchr (file, ACE_DIRECTORY_SEPARATOR_CHAR, ACE_OS::strlen (file));

	std::string path;
	if (!result) {
		try {
			path = Params::get_locale_path();
		} catch (Core::ParameterIsMissing& ) {
			// если путь не задан ищем от текущего каталога (не очень €сно что это такое дл€ сервиса :))
			LOG_W (("%s: %s option not found (using \".\")", GDS_CURRENT_FUNCTION, Params::locale_path_param_name()));
			path=".";
		}
		path += std::string (ACE_DIRECTORY_SEPARATOR_STR);
		path += "messages";
		path += std::string (ACE_DIRECTORY_SEPARATOR_STR);
		path += this->locale_to_path (locale);
		path += std::string (ACE_DIRECTORY_SEPARATOR_STR);
		path += file;
	} else {
		path = file;
	}

	std::ifstream stream (path.c_str (), std::ios_base::in | std::ios_base::binary);
	if (!stream) {
		LOG_E (("%s: can't open file %s", GDS_CURRENT_FUNCTION, path.c_str ()));
		throw I18N::CantFindFile ();
	}

	std::vector<char> buffer ((std::istreambuf_iterator<char> (stream)), std::istreambuf_iterator<char> ());
    // todo - more correct check:
	if (!buffer.size ()) {
		LOG_E (("%s: zero length file %s", GDS_CURRENT_FUNCTION, path.c_str ()));
		throw I18N::BadFileFormat ();
	}
	this->read_file (buffer, locale);
	//this->dump ();
	//#UC END# *452CC00003C8_452CCF1602FD*
}
} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

