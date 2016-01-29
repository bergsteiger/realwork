////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/str/str_op.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::str::str_op
//
// ��������� �������� �������������� �����, ������ � ������, ������ �������� ������� ���������� �
// �.�.
//
//
// ��� ����� ����������� ��� ��� "������-������".
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
	
	// �������� � ���������� ������ (str) ��������� ������ (from) �� ��������� (to), �� ���� ������ �����,
	// ��������� �������� d lheue. cnhjre (result)
	inline void replace_char (const std::string& str, std::string& result, char from, const std::string& to);
	
	// �������� � ���������� ������ (str) ��������� ������ (from) �� ��������� (to), �� ���� ������ �����
	inline std::string& replace_char (std::string& str, char from, char to);

	// ������� ��� ����������� ������ (in) ����-������
	inline std::string trim_ws (const char* in);

	// ������� ��� ����������� ������ (in) ����-������
	inline std::string trim_ws (const std::string& in);

	// ������� ��������� (in) �� ������ �� ����-����� ������
	inline const char* skip_whitespaces (const char* in);

	// �������� ��� ��������� ������� (chsrs) �� ���������� ������������������ (str)
	inline void kill_final_char (char* str, const char* chars);
	
	// �������� ��� ��������� ������� (chars) �� ���������� ������������������ (str)
	inline void kill_final_char (std::string& str, const char* chars);

	// ��������� ������ (input) �� ��������� ��������� ������ (len), � ������ \n � ��������� �� �����
	inline GCL::StrVector split_string_format (const char* input, unsigned len);
	
	
	// ��������� ������ (input)�� ��������� �� ��������� ������� (split_char)
	template <typename ResultT>
	inline ResultT& split_string_by (ResultT& res, const char* input, char split_char);

	inline GCL::StrVector split_string_by (const char* input, char split_char);
	
	// ��������� ������ ([it, it_end]) �� ��������� �� ��������� ������� (split_char),
	// c ������ ��������� ����������-���������� ([open, close]), � ������-�������� (exclude_symb)
	inline GCL::StrVector split_string_by (
		std::string::const_iterator it
		, const std::string::const_iterator& it_end
		, char split_char
		, char open = 0
		, char exclude_symb = 0
		, char close = 0
	);

	// ��������� ������ ([it, it_end]) �� ��������� �� ��������� ������� (split_char),
	// c ������ ��������� ����������-���������� ([open, close]) ���� ����������� ����������� ������
	// ������ �����, �� �� ������������
	// exclude_symb - ������-������
	// ������:
	// ��� ������: fff,zzzz,x{xx,xx}x\,X
	// split_string (..., ',',"{",'\',"}")
	// ����
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

	// ��������� ������ ([it, it_end]) �� ��������� �� ��������� ������� (split_char),
	// c ������ ��������� ����������-���������� ([open, close]) ���� ����������� ����������� ������
	// ������ �����, �� �� ������������
	// exclude_symb - ������-������
	// ������:
	// ��� ������: fff,zzzz,x{xx,xx}x\,X
	// split_string (..., ',',"{",'\',"}")
	// ����
	//   fff
	//   zzzz
	//   x{xx,xx}x,X 
	//
	// ������� ����� ����������� �� 64 ��������� ��������� ([open, close])
	inline void split_string_by (
		std::string::const_iterator it
		, const std::string::const_iterator& it_end
		, char split_char
		, const std::string& open_chars
		, char exclude_symb
		, const std::string& close_chars
		, GCL::StrVector& result
	);

	// ��������� ������ (str) �� ��������� �� �������� ��������� (split_str), ������������ �������� ����� ������
	template <typename ResultT>
	inline ResultT& split_string_by_sub_string (ResultT& result, const char* str, const char* split_str);

	inline GCL::StrVector split_string_by_sub_string (const char* str, const char* split_str);
	inline GCL::StrVector split_string_by_sub_string (const std::string& str, const std::string& split_str);

	// ��������� ������ (str) �� ���������� ��������� �� �������� ��������� (split_str),
	// ������������ �������� ����� ������
	inline GCL::StrSet split_string_by_sub_string_uniq (const char* str, const char* split_str);

	// ���������� ��������� (strs) � ������ ������, �������� �� ��������� ���������� (separator)
	// ������ boost::join, �� �������� ���� ������� (��� ������� :()
	template <typename InputT, typename SeparatorT>
	inline std::string join (const InputT& strs, const SeparatorT& separator);
	
	// ��������� ������� ���������� ������� (ch) � ������ (str)
	inline bool contains (char ch, const char* str);

	// ��������� ������ (input) �� ��������� �� �������ve ������� �������� (split_chars),
	// ������������ �������� ����� ������, � ����������� �� ����� (remove_empty) ������ ��������� ���������� ��� ���
	inline GCL::StrVector split_string_by_chars (const char* input, const char* split_chars, bool remove_empty = true);

	// ���������� �������� ������ ([it, it_end]) ������������ ��������� ��������� (close), 
	// � ������ ��������� ���������� ([open, close])  � ������������ ������� �������-���������� (exclude_symb)
	// ������:
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

	// ����� ����� ��������� � ������� [start, end], ���������� part(...)
	inline char* find_part_end (
		const char* start
		, const char* end
		, const char close
		, const char exclude_symb = 0
		, const char open = 0
	);

	// ��������� ������ (input) �� ��������� ������������ ����������� ��������� (fragment_begin, fragment_end)
	// ������:
	//		split_string_by_fragment ("{text1}, {text2}  {text3}{text4}", '{', '}')
	// ������ ������:
	//		text1
	//		text2
	//		text3
	//		text4
	inline GCL::StrVector split_string_by_fragment (const char* input, char fragment_begin, char fragment_end);

	// ����� ����� ��������, �� ���������� part(...)
	inline bool find_char_ex (
		std::string::const_iterator& it
		, const std::string::const_iterator& it_end
		, const char symb
		, const char open = 0
		, const char close = 0
		, const char exclude_symb = 0
	);

	// ��������� ������ ([it, it_end]) �� ��������� ������������ ��������� (open, close), c ������ ������-������� (exclude_symb)
	inline GCL::StrVector extract_fragments (
		std::string::const_iterator& it
		, const std::string::const_iterator& it_end
		, const char open
		, const char close = 0
		, const char exclude_symb = 0		
	);

	// ���������� ������ ������ �� ��������� ������ ([start, end]), � ������� ����������� ������� ��������� (at)
	inline std::string get_line (
		const std::string::const_iterator& at
		, const std::string::const_iterator& start
		, const std::string::const_iterator& end
	);


	// str ���������� � prefix
	//  ���� prefix = 0 �� ���������� true
	inline bool start_with (const char* str, const char* prefix);

	inline bool start_with (const std::string& str, const std::string& prefix);

	// str ���������� � prefix ��� ����� ��������
	//   ���� prefix = 0 �� ���������� true
	inline bool starti_with (const char* str, const char* prefix, const std::locale& loc);

	// str ������������� � sufix
	//   ���� sufix = 0 �� ���������� true
	inline bool end_with (const char* str, const char* sufix);

	// str ������������� � sufix ��� ����� ��������
	//   ���� sufix = 0 �� ���������� true
	inline bool endi_with (const char* str, const char* sufix, const std::locale& loc);

	// str ���������� � ������������� border
	//   ���� border = 0 �� ���������� true
	inline bool border_with (const char* str, const char* border);

	// str ���������� � ������������� border ��� ����� ��������
	//   ���� border = 0 �� ���������� true
	inline bool borderi_with (const char* str, const char* border, const std::locale& loc);

	// str ���������� � prefix_char
	inline bool start_with (const char* str, const char prefix_char);

	// str ������������� � sufix_char
	inline bool end_with (const char* str, const char sufix_char);
	
	// str ���������� � ������������� border_char
	inline bool border_with (const char* str, const char border_char);

	// ����� ��������� � �������������� �������� ���������, ��� ����� �������� c �������������� STL
	// (��������������� - s_ru_win, s_ru_dos, s_ru_koi, s_eng)
	// ������������ ��������� ��������� ���������, � ��������� ������ ������������ ��������� �� ����� ������
	inline const char* strstr (const char* str1, const char* str2, const std::locale& loc);

	inline int to_upper_win (int ch );

	inline int str_compare_strong (const char * s1, const char * s2);
	inline ssize_t str_compare_strong_with_len (const char * s1, const char * s2);

	// �������� ������� �� ��, ��� �� �������� ������
	inline bool is_alpha (const char chr, code_t code = cd_win);
	
	// �������� ������� �� ��, ��� �� �������� ������
	inline bool is_digit (const char chr, code_t code = cd_win);
	
	// �������� ������� �� ��, ��� �� �������� ������ ��� ������
	inline bool is_alnum (const char chr, code_t code = cd_win);
	
	// �������� ������� �� ��, ��� �� �������� �������� ������������
	inline bool is_delimiter (const char chr);

	// �������� ������� �� ��, ��� �� �������� �������� ������� (�������������)
	inline bool is_table (const char chr);
	
	// �������� ������� �� ������ ������� (��������� �����)
	inline bool is_lower (const char chr, code_t code = cd_win);
	
	// �������� ������� �� ������� ������� (������� �����)
	inline bool is_upper (const char chr, code_t code = cd_win);
	
	// ����� ��������� � ������ � ������ ��������
	// ������������ ��������� ��������� ���������, � ��������� ������ ������������ 0
	inline const char* find_sub_string (const char* string, const char* sub_string);

	// ����� ��������� � ������ ��� ������ ��������
	// ������������ ��������� ��������� ���������, � ��������� ������ ������������ 0
	inline const char* find_sub_string_nocase (const char* string, const char* sub_string, code_t code = cd_win);

	// ���������� ������� ������� ������� ��� ����� ���������� ����� ��������
	// ���� �� ����� ������ ����� ������� �� �����������, ���������� 0
	inline size_t find_end_of_word_after_position (const char* string, size_t position);
	
	template <typename ContainerT>
	struct ContainerTraits;
//#UC END# *4503E01500CB_USER_DEFINITION*

} // namespace GCL

#include "shared/GCL/str/str_op.i.h"

#endif //__SHARED_GCL_STR_STR_OP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
