////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/str/str_conv.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::str::str_conv
//
// операции различной конвертации строк (кодировка, кейс, представление и т.д.)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_STR_STR_CONV_H__
#define __SHARED_GCL_STR_STR_CONV_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4503DFAE006D_USER_INCLUDES*
#include <iterator>
#include <cctype>
#include "boost/utility/string_ref_fwd.hpp"

namespace GCL {
	const std::string utf8_to_win1251 (const std::string& src);
	const std::string win1251_to_utf8 (const boost::string_ref& src);
}
//#UC END# *4503DFAE006D_USER_INCLUDES*

namespace GCL {

// идентификаторы кодировок
enum code_t {
	cd_win // кодировка cp1251
	, cd_dos // кодировка cp866
	, cd_koi // кодировка KOI8-R
	, cd_mac // кодировка используемая в MacOS
	, cd_win_pseudo // ????
	, cd_utf // кодировка UTF8
};

// конвертирует переданную строку из кодировки code_in в строку с кодировкой code_out
const std::string convert (const char* src, code_t code_in, code_t code_out);

// конвертирует строку из UTF8 в win1251
const std::string utf8_to_win1251 (const char* src);

// конвертирует строку из win1251 в UTF8
const std::string win1251_to_utf8 (const char* src);

// конвертирует строку из win1251 в UTF8
const std::string win1251_to_utf8 (const std::string& src);

//#UC START# *4503DFAE006D_USER_DEFINITION*	
	// определение по умолчанию системной кодировки
	#if defined (CODETYPE_DOS)
		static const code_t cd_sys = cd_dos;
	#elif defined (CODETYPE_WIN)
		static const code_t cd_sys = cd_win;
	#elif defined (CODETYPE_KOI)
		static const code_t cd_sys = cd_koi;
	#elif defined (_WIN32) && !defined (_CONSOLE)
		static const code_t cd_sys = cd_win;
	#elif defined (unix) && !defined (__GO32__) && !defined (__CYGWIN32__)
		static const code_t cd_sys = cd_koi;
	#elif defined (__GO32__) || defined (__CYGWIN32__) || (defined (_WIN32) && defined (_CONSOLE))
		static const code_t cd_sys = cd_dos;
	#else
		static const code_t cd_sys = cd_mac;
	#endif
	
	// конвертация буфера из одной кодировки в другую
	char* buffer_recoding (code_t code_in, code_t code_out, size_t len, char* dest, const char* src = 0);
	
	// конвертация строки из одной кодировки в другую
	inline char* string_recoding (code_t code_in, code_t code_out, char* dest, const char* src = 0);
		
	// конвертит обычную струку в строку wide-кодов, с залданным префиксом 
	// и возможностью сохранять english-сиволы
	inline std::string multibyte_to_str (
		const std::string& in
		, char prefix = 0
		, bool keep_eng = false
		, char open_quot = 0
		, char close_quot = 0
	);

	// преобразует строку с именем согласно стилю OMG IDL
	enum CodeItem {
		 CI_FUNCTION
		, CI_PARAMTER
		, CI_CLASS_MEMBER
		, CI_VARIBLE
		, CI_CONST
		, CI_ENUM
		, CI_CLASS
		, CI_TYPEDEF
		, CI_STRUCT
		, CI_EXCEPTION
		, CI_ENUM_ITEM
	};
	
	inline std::string convert_to_omg_style (const std::string& str, CodeItem ci);

	// преобразует строку с именем согласно стилю Borland VCL
	inline std::string convert_to_borland_style (const std::string& str, CodeItem ci );
	
	// преобразует строку с именем согласно стилю Java
	inline std::string convert_to_java_style (const std::string& str, CodeItem ci );
	
	inline void to_upper (std::string& str);

	inline void to_lower (std::string& str);

	// пересобирает строку из входного  формата в выходной 
	// (в качестве составных элементов поддерживаются только подстроки, общим кол-вом не более 32)
	inline std::string string_converter (
		const std::string& str
		, const std::string& in_format
		, const std::string& out_format
		, unsigned out_size_multiplicator = 10
	);
	
	inline void convert_to_scanf_format (std::string& str);

	// конвертация символа в нижний регистр (маленькие буквы)
	inline char char_lower (const char chr, code_t code = cd_win);
	
	// конвертация символа в верхний регистр (большие буквы)
	inline char char_upper (const char chr, code_t code = cd_win);
	
	// конвертация строки в нижний регистр (маленькие буквы)
	inline void string_lower (char* src, code_t code = cd_win);
	
	// конвертация строки в верхний регистр (большие буквы)
	inline void string_upper (char* src, code_t code = cd_win);
//#UC END# *4503DFAE006D_USER_DEFINITION*

} // namespace GCL

#include "shared/GCL/str/str_conv.i.h"

#endif //__SHARED_GCL_STR_STR_CONV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
