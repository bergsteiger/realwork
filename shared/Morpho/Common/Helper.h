////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/Common/Helper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Morpho::Common::Helper
//
// Помощник
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_MORPHO_COMMON_HELPER_H__
#define __SHARED_MORPHO_COMMON_HELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace Morpho {

// Помощник
class Helper {
	SET_OBJECT_COUNTER (Helper)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Константы
	static const char* COMMON_CYR; // общие с латинскими, кириллические символы
	static const char* COMMON_LAT; // общие с кириллическими, латинские символы
	static const char* SPECIFIC_CYR; // специфические кириллические символы
	static const char* SPECIFIC_LAT; // специфические латинские символы

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// проверка на наличие кириллицы
	static bool has_cyr (const std::string& str);

	// проверка на наличие латиницы
	static bool has_lat (const std::string& str);

	// проверка на наличие специфических кириллических символов
	static bool is_cyr (const std::string& str);

	// проверка на наличие специфических латинских символов
	static bool is_lat (const std::string& str);

	// суррогатная киррилица
	static bool is_surrogate_cyr (const std::string& str);

	// суррогатная латиница
	static bool is_surrogate_lat (const std::string& str);

	// конвертация в кириллицу
	static const std::string& to_cyr (std::string& str);

	// конвертация в латиницу
	static const std::string& to_lat (std::string& str);

private:
	// проверка на наличие специфических символов
	static bool is_specific (const std::string& str, const char* buf);

	// суррогат
	static bool is_surrogate (const std::string& str, const char* buf);

	// трансформация
	static void transform (std::string& str, const char* from, const char* to);

}; // class Helper

} // namespace Morpho


#endif //__SHARED_MORPHO_COMMON_HELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

