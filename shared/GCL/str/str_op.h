////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/str/str_op.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::str::str_op
//
// различные операции преобразования строк, поиска в строке, замены подстрок слияние фрагментов и
// т.д.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_STR_STR_OP_H__
#define __SHARED_GCL_STR_STR_OP_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/str/str_conv.h"
#include "shared/GCL/data/std_defs.h"

//#UC START# *4503E01500CB_USER_INCLUDES*
#include <iterator>
#include <stack>
#include <ctype.h>
#include <algorithm>
#include <functional>
#include <locale>
#include <string.h>

//#UC END# *4503E01500CB_USER_INCLUDES*

namespace GCL {

//#UC START# *4503E01500CB_USER_DEFINITION*
	inline std::string& str_replace (std::string& in, const char* what, const char* to);

	inline std::string& str_replace (std::string& in, const std::string& what, const std::string& to);
	
	// заменяет в переданной строке (str) указанный символ (from) на подстроку (to), на ВСЕЙ длинне стрки,
	// результат пишеться d lheue. cnhjre (result)
	inline void replace_char (const std::string& str, std::string& result, char from, const std::string& to);
	
	// заменяет в переданной строке (str) указанный символ (from) на подстроку (to), на ВСЕЙ длинне стрки
	inline std::string& replace_char (std::string& str, char from, char to);

	// удаляет все обрамляющие строку (in) вайт-спейсы
	inline std::string trim_ws (const char* in);

	// удаляет все обрамляющие строку (in) вайт-спейсы
	inline std::string trim_ws (const std::string& in);

	// смещает указатель (in) на первый не вайт-спейс символ
	inline const char* skip_whitespaces (const char* in);

	// обнуляет все финальные символы (chsrs) из переданной последовательности (str)
	inline void kill_final_char (char* str, const char* chars);
	
	// обнуляет все финальные символы (chars) из переданной последовательности (str)
	inline void kill_final_char (std::string& str, const char* chars);

	// разбивает строку (input) на фрагменты указанной длинны (len), с учетом \n и разбиения на слова
	inline GCL::StrVector split_string_format (const char* input, unsigned len);
	
	
	// разбивает строку (input)на фрагменты по заданному символу (split_char)
	template <typename ResultT>
	inline ResultT& split_string_by (ResultT& res, const char* input, char split_char);

	inline GCL::StrVector split_string_by (const char* input, char split_char);
	
	// разбивает строку ([it, it_end]) на фрагменты по заданному символу (split_char),
	// c учетом вложенных фрагментов-исключений ([open, close]), и эскейп-символов (exclude_symb)
	inline GCL::StrVector split_string_by (
		std::string::const_iterator it
		, const std::string::const_iterator& it_end
		, char split_char
		, char open = 0
		, char exclude_symb = 0
		, char close = 0
	);

	// разбивает строку ([it, it_end]) на фрагменты по заданному символу (split_char),
	// c учетом вложенных фрагментов-исключений ([open, close]) если разделитель встречается внутри
	// такого блока, то он пропускается
	// exclude_symb - эскейп-символ
	// пример:
	// для строки: fff,zzzz,x{xx,xx}x\,X
	// split_string (..., ',',"{",'\',"}")
	// даст
	//   fff
	//   zzzz
	//   x{xx,xx}x,X 

	inline GCL::StrVector split_string_by (
		std::string::const_iterator it
		, const std::string::const_iterator& it_end
		, char split_char
		, const std::string& open_chars
		, char exclude_symb
		, const std::string& close_chars
	);

	// разбивает строку ([it, it_end]) на фрагменты по заданному символу (split_char),
	// c учетом вложенных фрагментов-исключений ([open, close]) если разделитель встречается внутри
	// такого блока, то он пропускается
	// exclude_symb - эскейп-символ
	// пример:
	// для строки: fff,zzzz,x{xx,xx}x\,X
	// split_string (..., ',',"{",'\',"}")
	// даст
	//   fff
	//   zzzz
	//   x{xx,xx}x,X 
	//
	// функция имеет ограничение на 64 вложенных фрагмента ([open, close])
	inline void split_string_by (
		std::string::const_iterator it
		, const std::string::const_iterator& it_end
		, char split_char
		, const std::string& open_chars
		, char exclude_symb
		, const std::string& close_chars
		, GCL::StrVector& result
	);

	// разбивает строку (str) на фрагменты по заданной подстроке (split_str), разделителем является целая строка
	template <typename ResultT>
	inline ResultT& split_string_by_sub_string (ResultT& result, const char* str, const char* split_str);

	inline GCL::StrVector split_string_by_sub_string (const char* str, const char* split_str);
	inline GCL::StrVector split_string_by_sub_string (const std::string& str, const std::string& split_str);

	// разбивает строку (str) на УНИКАЛЬНЫЕ фрагменты по заданной подстроке (split_str),
	// разделителем является целая строка
	inline GCL::StrSet split_string_by_sub_string_uniq (const char* str, const char* split_str);

	// объединяет фрагменты (strs) в единую строку, разделяя их указанной подстрокой (separator)
	// аналог boost::join, но работает чуть быстрее (что странно :()
	template <typename InputT, typename SeparatorT>
	inline std::string join (const InputT& strs, const SeparatorT& separator);
	
	// проверяет наличие указанного символа (ch) в строке (str)
	inline bool contains (char ch, const char* str);

	// разбивает строку (input) на фрагменты по заданноve массиву символов (split_chars),
	// разделителем является любой символ, в зависимости от флага (remove_empty) пустые фрагменты удаляються или нет
	inline GCL::StrVector split_string_by_chars (const char* input, const char* split_chars, bool remove_empty = true);

	// возвращает фрагмент строки ([it, it_end]) ограниченный заданными символами (close), 
	// с учетом вложенных фрагментов ([open, close])  с возможностью задания символа-исключения (exclude_symb)
	// пример:
	//		std::string str "text1 text2 {sub fragment} text3 \} text4} text5";
	//		cout << part (str.begin(), str.end(), '}', '\\', '{');
	// out:
	//		text1 text2 {sub fragment} text3 \} text4
	template <typename Iterator>
	inline std::string part (
		Iterator& it
		, const Iterator& it_end
		, const char close
		, const char exclude_symb = 0
		, const char open = 0
	);

	// поиск конца фрагмента в массиве [start, end], аналогично part(...)
	inline char* find_part_end (
		const char* start
		, const char* end
		, const char close
		, const char exclude_symb = 0
		, const char open = 0
	);

	// разбивает строку (input) на фрагменты ограниченные переданными символами (fragment_begin, fragment_end)
	// пример:
	//		split_string_by_fragment ("{text1}, {text2}  {text3}{text4}", '{', '}')
	// вернет массив:
	//		text1
	//		text2
	//		text3
	//		text4
	inline GCL::StrVector split_string_by_fragment (const char* input, char fragment_begin, char fragment_end);

	// поиск конца сегмента, НЕ аналогично part(...)
	inline bool find_char_ex (
		std::string::const_iterator& it
		, const std::string::const_iterator& it_end
		, const char symb
		, const char open = 0
		, const char close = 0
		, const char exclude_symb = 0
	);

	// разбивает строку ([it, it_end]) на фрагменты ограниченные символами (open, close), c учетом эскейп-символа (exclude_symb)
	inline GCL::StrVector extract_fragments (
		std::string::const_iterator& it
		, const std::string::const_iterator& it_end
		, const char open
		, const char close = 0
		, const char exclude_symb = 0		
	);

	// возвращает полную строку из тестового потока ([start, end]), к которой пренадлежит позиция указателя (at)
	inline std::string get_line (
		const std::string::const_iterator& at
		, const std::string::const_iterator& start
		, const std::string::const_iterator& end
	);


	// str начинается с prefix
	//  Если prefix = 0 то возвращает true
	inline bool start_with (const char* str, const char* prefix);

	inline bool start_with (const std::string& str, const std::string& prefix);

	// str начинается с prefix без учета регистра
	//   Если prefix = 0 то возвращает true
	inline bool starti_with (const char* str, const char* prefix, const std::locale& loc);

	// str заканчивается с sufix
	//   Если sufix = 0 то возвращает true
	inline bool end_with (const char* str, const char* sufix);

	// str заканчивается с sufix юез учета регистра
	//   Если sufix = 0 то возвращает true
	inline bool endi_with (const char* str, const char* sufix, const std::locale& loc);

	// str начинается и заканчивается border
	//   Если border = 0 то возвращает true
	inline bool border_with (const char* str, const char* border);

	// str начинается и заканчивается border без учета регистра
	//   Если border = 0 то возвращает true
	inline bool borderi_with (const char* str, const char* border, const std::locale& loc);

	// str начинается с prefix_char
	inline bool start_with (const char* str, const char prefix_char);

	// str заканчивается с sufix_char
	inline bool end_with (const char* str, const char sufix_char);
	
	// str начинается и заканчивается border_char
	inline bool border_with (const char* str, const char border_char);

	// поиск подстроки с использованием языковой кодировки, без учета регистра c использованием STL
	// (порддерживаются - s_ru_win, s_ru_dos, s_ru_koi, s_eng)
	// возвращается указатель найденной подстроки, в противном случае возвращается указатель на конец строки
	inline const char* strstr (const char* str1, const char* str2, const std::locale& loc);

	inline int to_upper_win (int ch );

	inline int str_compare_strong (const char * s1, const char * s2);
	inline ssize_t str_compare_strong_with_len (const char * s1, const char * s2);

	// проверка символа на то, что он является буквой
	inline bool is_alpha (const char chr, code_t code = cd_win);
	
	// проверка символа на то, что он является цифрой
	inline bool is_digit (const char chr, code_t code = cd_win);
	
	// проверка символа на то, что он является цифрой или буквой
	inline bool is_alnum (const char chr, code_t code = cd_win);
	
	// проверка символа на то, что он является символом разделителем
	inline bool is_delimiter (const char chr);

	// проверка символа на то, что он является символом таблицы (псевдографика)
	inline bool is_table (const char chr);
	
	// проверка символа на нижний регистр (маленькие буквы)
	inline bool is_lower (const char chr, code_t code = cd_win);
	
	// проверка символа на верхний регистр (большие буквы)
	inline bool is_upper (const char chr, code_t code = cd_win);
	
	// поиск подстроки в строке с учетом регистра
	// возвращается указатель найденной подстроки, в противном случае возвращается 0
	inline const char* find_sub_string (const char* string, const char* sub_string);

	// поиск подстроки в строке без учетом регистра
	// возвращается указатель найденной подстроки, в противном случае возвращается 0
	inline const char* find_sub_string_nocase (const char* string, const char* sub_string, code_t code = cd_win);

	// возвращает позицию первого пробела или знака препинания после заданной
	// если до конца строки такой позиции не встретилось, возвращает 0
	inline size_t find_end_of_word_after_position (const char* string, size_t position);
	
	template <typename ContainerT>
	struct ContainerTraits;
//#UC END# *4503E01500CB_USER_DEFINITION*

} // namespace GCL

#include "shared/GCL/str/str_op.i.h"

#endif //__SHARED_GCL_STR_STR_OP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
