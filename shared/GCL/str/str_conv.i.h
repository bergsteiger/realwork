////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/str/str_conv.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::str::str_conv
// Файл inline реализации утилитного набора str_conv
//
// операции различной конвертации строк (кодировка, кейс, представление и т.д.)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#UC START# *4503DFAE006D_CUSTOM_INCLUDES*
//#UC END# *4503DFAE006D_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *4503DFAE006D*
// конвертация строки из одной кодировки в другую
inline char* string_recoding (code_t code_in, code_t code_out, char* dest, const char* src) {
	return GCL::buffer_recoding (code_in, code_out, (dest != 0) ? (strlen (dest)) : (0), dest, src);
}

// конвертит обычную струку в строку wide-кодов, с залданным префиксом 
// и возможностью сохранять english-сиволы

inline std::string multibyte_to_str (
	const std::string& in
	, char prefix
	, bool keep_eng
	, char open_quot
	, char close_quot
) {
	std::string ret;
#ifdef WIN32
	bool first_eng = true;
	for (std::string::const_iterator it = in.begin(); it != in.end(); it++) {			
		if (*it < 0 || !keep_eng) {
			if (!first_eng && close_quot) {
				ret += close_quot;
				first_eng = true;
			}
			WCHAR wch[2];
			MultiByteToWideChar(CP_ACP, 0, &(*it), 1, wch, 1);
			if (prefix) ret += prefix;
			char buf[8];
			itoa (wch[0], buf, 10);
			ret += buf;
		} else {
			if (first_eng && open_quot) {
				ret += open_quot;
				first_eng = false;
			}
			ret += *it;
		}
	}
	if (!first_eng && close_quot) {
		ret += close_quot;
		first_eng = true;
	}
#else
	GDS_ASSERT_MSG (false, ("need to implement"));
#endif
	return ret;
}

// преобразует строку с именем согласно стилю OMG IDL
inline std::string convert_to_omg_style (const std::string& str, CodeItem ci) {
	std::string ret;
	// need setlocale;
	
	std::string::const_iterator it_begin = str.begin();
	std::string::const_iterator it_end = str.end();
	for (std::string::const_iterator it = it_begin; it != it_end; it++) {
		switch (ci) {
			case CI_FUNCTION:
			case CI_PARAMTER:
			case CI_CLASS_MEMBER:
			case CI_VARIBLE: {
				if (it != it_begin) {
					std::string::const_iterator it_1 = it - 1;
					std::string::const_iterator it1 = it + 1;
					if (
						it1 != it_end
						&& std::isupper (*it)
						&& (
							(
								//предыдущий и следующий символы не должны быть
								//одновременно заглавными буквами
								std::isupper (*it_1) ^ std::isupper (*it1)
							)
							|| (
								//предыдущий и следующий символы должны быть
								//одновременно маленькими буквами
								!std::isupper (*it_1) && !std::isupper (*it1)
							)
						)
					) {
						ret += "_";
					}
				}
				ret += std::tolower (*it);
				break;
			} 
			case CI_CLASS:
			case CI_TYPEDEF:
			case CI_STRUCT:
			case CI_EXCEPTION: 
			case CI_ENUM: {
				ret += *it;
				break;
			}
			case CI_CONST:
			case CI_ENUM_ITEM: {
				ret += *it;
				break;
			}
		}
	}
	return ret;
}

// преобразует строку с именем согласно стилю Borland VCL
inline std::string convert_to_borland_style (const std::string& str, CodeItem ci ) {
	std::string ret;
	// need setlocale;

	for (std::string::const_iterator it = str.begin(); it != str.end(); it++) {
		switch (ci) {
			case CI_FUNCTION:
			case CI_CLASS:
			case CI_TYPEDEF:
			case CI_STRUCT:
			case CI_EXCEPTION: 
			case CI_ENUM: {
				if (*it == '_') {
					it++;
					ret += toupper(static_cast<unsigned char> (*it));
				} else if (it == str.begin()) {
					ret += toupper(static_cast<unsigned char> (*it));
				} else {
					ret += *it;
				}
				break;
			}	 			
			case CI_PARAMTER:
			case CI_CLASS_MEMBER:
			case CI_VARIBLE: {
				ret += *it;
				break;
			}
			case CI_CONST: {
				ret += *it;
				break;
			}
			case CI_ENUM_ITEM: {
				ret += *it;
				break;
			}
		}
	}
	
	return ret;
}

// преобразует строку с именем согласно стилю Java
inline std::string convert_to_java_style (const std::string& str, CodeItem ci ) {
	std::string ret;
	// need setlocale;
	std::string::const_iterator it_begin = str.begin ();
	std::string::const_iterator it_end = str.end ();
	for (std::string::const_iterator it = it_begin; it != it_end; it++) {
		switch (ci) {
			case CI_FUNCTION:
			case CI_CLASS:
			case CI_TYPEDEF:
			case CI_STRUCT:
			case CI_EXCEPTION: 
			case CI_ENUM: {
				if (*it == '_' && (it + 1) != it_end) {
					it++;
					ret += toupper(static_cast<unsigned char> (*it));
				} else {
					ret += *it;
				}
				break;
			}	 			
			case CI_PARAMTER:
			case CI_CLASS_MEMBER:
			case CI_VARIBLE: {
				ret += *it;
				break;
			}
			case CI_CONST: {
				ret += *it;
				break;
			}
			case CI_ENUM_ITEM: {
				ret += *it;
				break;
			}
		}
	}
	
	return ret;
}

inline void to_upper (std::string& str) {
	for (std::string::iterator it = str.begin(); it != str.end(); it++) {
#if !defined(__APPLE__)
		*it = toupper(static_cast<unsigned char> (*it));
#else
        *it = char_upper(static_cast<unsigned char> (*it), cd_win);
#endif
	}
}

inline void to_lower (std::string& str) {
	for (std::string::iterator it = str.begin(); it != str.end(); it++) {
#if !defined(__APPLE__)
		*it = tolower(static_cast<unsigned char> (*it));
#else
        *it = char_lower(static_cast<unsigned char> (*it), cd_win);
#endif
	}
}

// пересобирает строку из входного  формата в выходной 
// (в качестве составных элементов поддерживаются только подстроки, общим кол-вом не более 32)
inline std::string string_converter (
	const std::string& str
	, const std::string& in_format
	, const std::string& out_format
	, unsigned out_size_multiplicator
) {
	std::string ret;
	if (!str.empty ()) {
		ret.resize(str.size()*out_size_multiplicator);
		char s1[1024]; 
		char s2[1024]; 
		char s3[1024]; 
		char s4[64];
		char s5[64];
		char s6[64];
		char s7[64];
		char s8[64];
		char s9[64];
		char s10[64];
		char s11[64];
		char s12[64];
		char s13[64];
		char s14[64];
		char s15[64];
		char s16[64];
		char s17[64];
		char s18[64];
		char s19[64];
		char s20[64];
		char s21[64];
		char s22[64];
		char s23[64];
		char s24[64];
		char s25[64];
		char s26[64];
		char s27[64];
		char s28[64];
		char s29[64];
		char s30[64];
		char s31[64];
		char s32[64];
		
		s1[0] 
			= s2[0] 
			= s3[0] 
			= s4[0] 
			= s5[0] 
			= s6[0] 
			= s7[0] 
			= s8[0] 
			= s9[0] 
			= s10[0] 
			= s11[0] 
			= s12[0]
			= s13[0]
			= s14[0]
			= s15[0]
			= s16[0] 
			= s17[0] 
			= s18[0]
			= s19[0]
			= s20[0]
			= s21[0] 
			= s22[0]
			= s23[0]
			= s24[0]
			= s25[0]
			= s26[0] 
			= s27[0] 
			= s28[0]
			= s29[0]
			= s30[0]
			= s31[0]
			= s32[0]
			= 0;

		sscanf (str.data()
			, in_format.data()
			, s1
			, s2
			, s3
			, s4
			, s5
			, s6
			, s7
			, s8
			, s9
			, s10
			, s11
			, s12
			, s13
			, s14
			, s15
			, s16
			, s17
			, s18
			, s19
			, s20
			, s21
			, s22
			, s23
			, s24
			, s25
			, s26
			, s27
			, s28
			, s29
			, s30
			, s31
			, s32
		);
		sprintf (const_cast<char*>(ret.c_str())
			, out_format.data()
			, s1
			, s2
			, s3
			, s4
			, s5
			, s6
			, s7
			, s8
			, s9
			, s10
			, s11
			, s12
			, s13
			, s14
			, s15
			, s16
			, s17
			, s18
			, s19
			, s20
			, s21
			, s22
			, s23
			, s24
			, s25
			, s26
			, s27
			, s28
			, s29
			, s30
			, s31
			, s32
		);
		ret.resize(strlen(ret.data()));
	}
	return ret;
}

inline void convert_to_scanf_format (std::string& str) {
	std::string res;
	for (std::string::iterator it = str.begin(); it != str.end(); it++) {
		if (*it == '\\') {
			it++;
			switch (*it) {
			case 'n':
				res += '\n';
				break;
			case 't':
				res += '\t';
				break;
			case '0':
				res += '\0';
				break;
			case '\\':
				res += '\\';
				break;
			default:
				res += *it;
			}
		} else {
			res += *it;
		}
	}
	str = res;
}

// конвертация символа в нижний регистр (маленькие буквы)
inline char char_lower (const char chr, code_t code) {
	char result;

	switch (code) {
		case cd_win_pseudo:
		case cd_win: {
			if (
				((chr >= 'A') && (chr <= 'Z')) 
				|| ((chr >= 'А') && (chr <= 'Я'))
			) {
				result = chr+0x20;
			} else {
				if (chr == 'Ё') {
					result = 'ё';
				} else {
					result = chr;
				}
			}
			break;
		}

		default: {
			GDS_ASSERT (false); // неподдерживаямая кодировка
			result = chr;
		}
	}

	return result;
}

// конвертация символа в верхний регистр (большие буквы)
inline char char_upper (const char chr, code_t code) {
	char result;

	switch (code) {
		case cd_win_pseudo:
		case cd_win: {
			if (
				((chr >= 'a') && (chr <= 'z'))
				|| ((chr >= 'а') && (chr <= 'я'))
			) {
				result = chr-0x20;
			} else {
				if (chr == 'ё') {
					result = 'Ё';
				} else {
					result = chr;
				}
			}
			break;
		}

		default: {
			assert (false); // неподдерживаямая кодировка
			result = chr;
		}
	}

	return result;
}

// конвертация строки в нижний регистр (маленькие буквы)
inline void string_lower (char* src, code_t code) {
	if (src != 0) {
		for (; *src != '\0'; ++src) {
			*src = char_lower (*src, code);
		}
	}
}

// конвертация строки в верхний регистр (большие буквы)
inline void string_upper (char* src, code_t code) {
	if (src != 0) {
		for (; *src != '\0'; ++src) {
			*src = char_upper (*src, code);
		}
	}
}
//#UC END# *4503DFAE006D*

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

