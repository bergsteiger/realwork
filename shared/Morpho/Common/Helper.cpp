////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/Common/Helper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Morpho::Common::Helper
//
// Помощник
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/Common/Helper.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/classification.hpp"

namespace Morpho {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const char* Helper::COMMON_CYR = "ЕТУОРАНКХСВМ0"; // общие с латинскими, кириллические символы
const char* Helper::COMMON_LAT = "ETYOPAHKXCBM0"; // общие с кириллическими, латинские символы
const char* Helper::SPECIFIC_CYR = "ЙЦГШЩЗЪФЫПЛДЖЭЯЧИЬБЮ0"; // специфические кириллические символы
const char* Helper::SPECIFIC_LAT = "QWRUISDFGJLZVN0"; // специфические латинские символы

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// проверка на наличие кириллицы
bool Helper::has_cyr (const std::string& str) {
	//#UC START# *53B6A8B00142*
	return std::find_if (str.begin (), str.end (), boost::is_from_range ('А', 'Я')) != str.end ();
	//#UC END# *53B6A8B00142*
}

// проверка на наличие латиницы
bool Helper::has_lat (const std::string& str) {
	//#UC START# *53B6A8F200E1*
	return std::find_if (str.begin (), str.end (), boost::is_from_range ('A', 'Z')) != str.end ();
	//#UC END# *53B6A8F200E1*
}

// проверка на наличие специфических кириллических символов
bool Helper::is_cyr (const std::string& str) {
	//#UC START# *53B6A968022F*
	return Helper::is_specific (str, Helper::SPECIFIC_CYR);
	//#UC END# *53B6A968022F*
}

// проверка на наличие специфических латинских символов
bool Helper::is_lat (const std::string& str) {
	//#UC START# *53B6A9BE0138*
	return Helper::is_specific (str, Helper::SPECIFIC_LAT);
	//#UC END# *53B6A9BE0138*
}

// проверка на наличие специфических символов
bool Helper::is_specific (const std::string& str, const char* buf) {
	//#UC START# *53B6A62903B8*
	for (const char* ptr = buf; *ptr; ++ptr) {
		if (str.find (*ptr) != std::string::npos) {
			return true;
		}
	}
	return false;
	//#UC END# *53B6A62903B8*
}

// суррогат
bool Helper::is_surrogate (const std::string& str, const char* buf) {
	//#UC START# *53B6CE850279*
	const char* buf_end = buf + strlen (buf) - 1;

	unsigned count = 0;

	for (std::string::const_iterator it = str.begin (); it != str.end (); ++it) {
		if (*it < '0' || *it > '9') {
			if (std::find (buf, buf_end, *it) == buf_end) {
				return false;
			}
		} else {
			++count;
		}
	}

	return count != str.size ();
	//#UC END# *53B6CE850279*
}

// суррогатная киррилица
bool Helper::is_surrogate_cyr (const std::string& str) {
	//#UC START# *53B6CCC40391*
	return Helper::is_surrogate (str, Helper::COMMON_LAT);
	//#UC END# *53B6CCC40391*
}

// суррогатная латиница
bool Helper::is_surrogate_lat (const std::string& str) {
	//#UC START# *53B6CCF60141*
	return Helper::is_surrogate (str, Helper::COMMON_CYR);
	//#UC END# *53B6CCF60141*
}

// конвертация в кириллицу
const std::string& Helper::to_cyr (std::string& str) {
	//#UC START# *53B6A9E60071*
	Helper::transform (str, Helper::COMMON_LAT, Helper::COMMON_CYR);
	return str;
	//#UC END# *53B6A9E60071*
}

// конвертация в латиницу
const std::string& Helper::to_lat (std::string& str) {
	//#UC START# *53B6AA1E01B9*
	Helper::transform (str, Helper::COMMON_CYR, Helper::COMMON_LAT);
	return str;
	//#UC END# *53B6AA1E01B9*
}

// трансформация
void Helper::transform (std::string& str, const char* from, const char* to) {
	//#UC START# *53B6A5DC00D1*
	const char* from_end = from + strlen (from) - 1;

	for (std::string::iterator it = str.begin (); it != str.end (); ++it) {
		const char* loc = std::find (from, from_end, *it);

		if (loc != from_end) {
			*it = *(to + std::distance (from, loc));
		}
	}
	//#UC END# *53B6A5DC00D1*
}

} // namespace Morpho

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

