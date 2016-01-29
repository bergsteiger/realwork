////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/str/str_op.i.h"
// ��������� inline ������ ���������� C++ (.i.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::str::str_op
// ���� inline ���������� ���������� ������ str_op
//
// ��������� �������� �������������� �����, ������ � ������, ������ �������� ������� ���������� �
// �.�.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#UC START# *4503E01500CB_CUSTOM_INCLUDES*
#include "shared/Core/data/unsorted_containers.h"
//#UC END# *4503E01500CB_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *4503E01500CB*
// �������� � ���������� ������ (in) ��������� ��������� (what) ������ (to), �� ���� ������ �����
inline std::string& str_replace (std::string& in, const char* what, const char* to) {
	size_t what_size = strlen (what);
	size_t to_size = strlen (to);
	
	size_t offset = 0;
	size_t p;
	while ((p = in.find(what, offset)) != std::string::npos) {
		in.replace(p, what_size, to);
		offset = p + to_size;
	}	

	return in;
}

inline std::string& str_replace (std::string& in, const std::string& what, const std::string& to) {
	return str_replace (in, what.c_str (), to.c_str ());
}

// �������� � ���������� ������ (str) ��������� ������ (from) �� ��������� (to), �� ���� ������ �����,
// ��������� �������� � result
inline void replace_char (const std::string& str, std::string& result, char from, const std::string& to) {
	result.erase();
	for (std::string::const_iterator it = str.begin(); it != str.end(); it++) {
		if (*it == from) {
			result += to;
		} else {
			result += *it;
		}
	}		
}

// �������� � ���������� ������ (str) ��������� ������ (from) �� ������ (to), �� ���� ������ �����
inline std::string& replace_char (std::string& str, char from, char to) {
	for (std::string::iterator it = str.begin(); it != str.end(); it++) {
		if (*it == from) {
			*it = to;
		}
	}
	return str;
}

// ������� ��� ����������� ������ (in) ����-������
inline std::string trim_ws (const char* in) {
	while (*in && (*in > 0 && (isspace ((unsigned char)*in) || *in == 9))) {
		in++;
	}
	std::string ret = in;

	size_t i = ret.size ();
	while (i && (ret [i-1] > 0 && (isspace (ret [i-1]) || ret [i-1] == 9))) {
		i--;
	}
	ret.resize (i);
	return ret;
}

// ������� ��� ����������� ������ (in) ����-������
inline std::string trim_ws (const std::string& in) {
	return trim_ws (in.c_str ());
}

// ������� ��������� (in) �� ������ �� ����-����� ������
inline const char* skip_whitespaces (const char* in) {
	while (*in && (isspace ((unsigned char)*in) || *in == 9)) {
		in++;
	}
	return in;
}

// �������� ��� ��������� ������� (chsrs) �� ���������� ������������������ (str)
inline void kill_final_char (char* str, const char* chars) {
	size_t ch_len = strlen (chars);
	for (size_t i = strlen (str) - 1; i > 0; i--) {
		bool find = false;
		for (size_t ii = 0; ii < ch_len && !find; ii++) {
			find = (str[i] == chars[ii]);
		}

		if (find) {
			str[i] = 0;
		} else {
			return;
		}
	}
}

// �������� ��� ��������� ������� (chars) �� ���������� ������������������ (str)
inline void kill_final_char (std::string& str, const char* chars) {
	size_t ch_len = strlen (chars);
	for (size_t i = str.size () - 1; i > 0; i--) {
		bool find = false;
		for (size_t ii = 0; ii < ch_len && !find; ii++) {
			find = (str[i] == chars[ii]);
		}

		if (find) {
			str.erase (i);
		} else {
			return;
		}
	}
}

// ��������� ������ (input) �� ��������� ��������� ������ (n), � ������ \n � ��������� �� �����
inline GCL::StrVector split_string_format (const char* input, size_t n) {
	std::vector<std::string> strs;

	size_t str_len = strlen (input);
	size_t start_pos = 0; //��������� ������� � ������, � ������� ����� ���������� ���������	
	for (size_t pos = 0, delim_pos = std::string::npos; pos < str_len; ++pos) {
		const char ch = input[pos];
		if (pos >= (start_pos + n) || ch == '\n') {
			size_t count = ch == '\n' 
				? pos - start_pos 
				: delim_pos != std::string::npos 
					? delim_pos - start_pos + 1 
					: pos - start_pos + 1;
			strs.push_back (std::string (input + start_pos, count));
			start_pos += count + ((ch == '\n') ? 1 : 0);
			delim_pos = std::string::npos; //���������� ������� �����������
		} else if (ch == ' ' || ch == '-') {
			//���������� �����������
			delim_pos = pos;
		}
	}
	if (start_pos < str_len) {
		strs.push_back (std::string (input + start_pos, str_len - start_pos));
	}
	return strs;
}

template <typename ContainerT>
struct ContainerTraits {
	static void append (ContainerT& cont, const typename ContainerT::value_type& value) {
		cont.push_back (value);
	}
};

template <typename key, typename compare, typename allocator>
struct ContainerTraits<std::set<key, compare, allocator> > {
	typedef std::set<key, compare, allocator> ContainerT;
	static void append (ContainerT& cont, const typename ContainerT::value_type& value) {
		cont.insert (value);
	}
};

template <
	class Value
	, class Hash
	, class Pred
	, class Alloc
>
struct ContainerTraits<boost::unordered_set<Value, Hash, Pred, Alloc> > {
	typedef boost::unordered_set<Value, Hash, Pred, Alloc> ContainerT;
	static void append (ContainerT& cont, const typename ContainerT::value_type& value) {
		cont.insert (value);
	}
};

// ��������� ������ (input)�� ��������� �� ��������� ������� (split_char)
template <typename ResultT>
inline ResultT& split_string_by (ResultT& res, const char* input, char split_char) {
	const char* str = input;
	size_t total_count = 0; 

	// ���������� ������-�����������
	while (*str && *str == split_char) {
		total_count++;
		str++;
	}
	while (total_count < strlen (input)) {
		size_t pos = 0;
		// find split char
		while ( str[pos+1] && str[pos] != split_char ) pos++;

		if ( pos ) { 
			std::string s (str, str[pos] == split_char ? pos : pos+1);
			ContainerTraits<ResultT>::append (res, s);
		} else if ( str[0] ) {				
			//res.push_back(str);
			ContainerTraits<ResultT>::append (res, str);
		}
		total_count += pos + 1;
		str += pos + 1;
		// ���������� ��� �������-�����������, ���� �� ����� ���������
		while (*str && *str == split_char) {
			str++;
			total_count++;
		}
	}

	return res;
}

inline GCL::StrVector split_string_by (const char* input, char split_char) {
	GCL::StrVector strs;
	split_string_by (strs, input, split_char);
	return strs;
}

// ��������� ������ ([it, it_end]) �� ��������� �� ��������� ������� (split_char),
// c ������ ��������� ����������-���������� ([open, close]), � ������-�������� (exclude_symb)
inline GCL::StrVector split_string_by (
	std::string::const_iterator it
	, const std::string::const_iterator& it_end
	, char split_char
	, char open
	, char exclude_symb
	, char close
) {
	if (!close) {
		close = open;
	}
	GCL::StrVector strs;
	size_t sub_part_count = 0;

	while (it != it_end) {
		std::string::const_iterator it_begin = it;
		while (it != it_end) {				
			if (*it == open && (open != close || !sub_part_count)) {
				sub_part_count++;				
			} else if (*it == close) {
				sub_part_count--;				
			} else if (*it == split_char && !sub_part_count) {
				break;
			}
			if (*it == exclude_symb) {
				it++;
			} 				
			it++;
		}
		
		strs.push_back(std::string (it_begin, it));
		if (it != it_end) it++;
	}		
	return strs;
}

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
) {	
	std::string temp (it, it_end);
	if (GCL::contains (split_char, temp.c_str ())) {
		char fragment_close_stack[64] = {};
		long current_level = -1;
		while (it != it_end) {
			std::string::const_iterator it_begin = it;
			while (it != it_end) {				
				if (current_level >= 0 && *it == fragment_close_stack[current_level]) {					
					// close opened fragment
					--current_level;					
				} else {
					std::string::size_type open_fnd = open_chars.find (*it);
					if (open_fnd != std::string::npos) {
						// open new fragments
						fragment_close_stack[++current_level] = close_chars[open_fnd];
					} else if (*it == split_char && current_level < 0) {
						break;						
					}
				}												
				if (*it == exclude_symb) {
					it++;
				} 				
				it++;
			}
			
			result.push_back(std::string (it_begin, it));
			if (it != it_end) it++;
		}	
	} else {
		result.push_back (temp);
	}
}
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
) {
	GCL::StrVector strs;			
	std::string temp (it, it_end);
	if (GCL::contains (split_char, temp.c_str ())) {
		std::stack<char> fragment_close_stack;
		while (it != it_end) {
			std::string::const_iterator it_begin = it;
			while (it != it_end) {				
				if (fragment_close_stack.size() && *it == fragment_close_stack.top()) {					
					// close opened fragment
					fragment_close_stack.pop();					
				} else {
					std::string::size_type open_fnd = open_chars.find (*it);
					if (open_fnd != std::string::npos) {
						// open new fragments
						fragment_close_stack.push(close_chars[open_fnd]);
					} else if (*it == split_char && !fragment_close_stack.size()) {
						break;						
					}
				}												
				if (*it == exclude_symb) {
					it++;
				} 				
				it++;
			}
			
			strs.push_back(std::string (it_begin, it));
			if (it != it_end) it++;
		}	
	} else {
		strs.push_back(temp);
	}
	return strs;
}

// ��������� ������ (str) �� ��������� �� �������� ��������� (split_str), ������������ �������� ����� ������
template <class ResultT>
ResultT& split_string_by_sub_string (ResultT& result, const char* str, const char* split_str) {
	size_t split_size = strlen(split_str);
	while (str) {
		const char* pstr = ::strstr (str, split_str);

		std::string s (str, pstr ? pstr-str : strlen(str));
		if (!s.empty ()) {
			ContainerTraits<ResultT>::append (result, s);
		}
		
		str = pstr ? pstr + split_size: 0;
	}
	return result;
}

inline GCL::StrVector split_string_by_sub_string (const char* str, const char* split_str) {
	GCL::StrVector strs;	
	split_string_by_sub_string (strs, str, split_str);
	return strs;
}

inline GCL::StrVector split_string_by_sub_string (const std::string& str, const std::string& split_str) {
	return split_string_by_sub_string (str.c_str (), split_str.c_str ());
}
// ��������� ������ (str) �� ���������� ��������� �� �������� ��������� (split_str),
// ������������ �������� ����� ������
inline GCL::StrSet split_string_by_sub_string_uniq (const char* str, const char* split_str) {
	GCL::StrSet strs;	
	split_string_by_sub_string (strs, str, split_str);
	return strs;
}

// ���������� ��������� (strs) � ������ ������, �������� �� ��������� ���������� (merge_str)
template <typename InputT, typename SeparatorT>
inline std::string join (const InputT& strs, const SeparatorT& separator) {
	std::string ret;
	typedef typename InputT::const_iterator const_iterator;
	const_iterator it = strs.begin ();
	const_iterator it_end = strs.end ();

	for (; it != it_end; it++) {
		ret += *it;
		if (std::distance (it, it_end) > 1 ) {
			ret += separator;
		}
	}
	return ret;
}

// ��������� ������� ���������� ������� (ch) � ������ (str)
inline bool contains (char ch, const char* str) {
	while (*str) {
		if (*str == ch) {
			return true;
		}
		str++;
	}
	return false;
}

// ��������� ������ (input) �� ��������� �� �������ve ������� �������� (split_chars),
// ������������ �������� ����� ������, � ����������� �� ����� (remove_empty) ������ ��������� ���������� ��� ���
inline GCL::StrVector split_string_by_chars (const char* input, const char* split_chars, bool remove_empty) {
	GCL::StrVector strs;
	
	const char* str = input;
	while (*str) {
		size_t f_pos = strcspn (str, split_chars);			

		if (f_pos) {				
			strs.push_back(std::string (str, str + f_pos));
		} else {
			if (!remove_empty) {
				strs.push_back ("");
			}
		}
		
		str += f_pos;			
		if (*str) {
			str++;
		}
	}
	return strs;
}

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
	, const char exclude_symb
	, const char open
) {
	if (it == it_end) {
		return std::string ();
	}

	Iterator it_begin = it;
	it_begin++;
	size_t sub_part_count = 1;
	
	while (it != it_end && sub_part_count) {
		it++;
		if (it == it_end) {
			break;
		}

		if (*it == open) {
			sub_part_count++;
		}

		if (*it == close) {
			sub_part_count--;
		}

		if (*it == exclude_symb) {
			it++;
		}
	}
	
	std::string ret (it_begin, it);
	return ret;
}

// ����� ����� ��������� � ������� [start, end], ���������� part(...)
inline char* find_part_end (
	const char* start
	, const char* end
	, const char close
	, const char exclude_symb
	, const char open
) {
	size_t sub_part_count = 1;
	
	while (start != end && sub_part_count) {
		start++;
		if (*start == open) sub_part_count++;
		if (*start == close) sub_part_count--;
		if (*start == exclude_symb) start++;
	}
	
	return const_cast<char*>(start);
}

// ��������� ������ (input) �� ��������� ������������ ����������� ��������� (fragment_begin, fragment_end)
// ������:
//		split_string_by_fragment ("{text1}, {text2}  {text3}{text4}", '{', '}')
// ������ ������:
//		text1
//		text2
//		text3
//		text4
inline GCL::StrVector split_string_by_fragment (const char* input, char fragment_begin, char fragment_end) {
	GCL::StrVector strs;

	const char* str = input;
	size_t begin_pos = 0; 
	size_t end_pos = 0; 

	do {			
		// find begin char
		while (str[begin_pos] && str[begin_pos] != fragment_begin) begin_pos++;
		
		if (str[begin_pos]) {
			if (fragment_begin == fragment_end) {
				begin_pos++;
				end_pos = begin_pos;
				while (str[end_pos] && str[end_pos] != fragment_end) end_pos++;
			} else {
				end_pos = find_part_end (str + begin_pos, 0, fragment_end, '\\', fragment_begin) - input;
				begin_pos++;
			}				
			
			if ( str[end_pos] ) { 
				std::string s (str+begin_pos, end_pos - begin_pos);
				strs.push_back(s);
				end_pos++;
				begin_pos = end_pos;
			}
		}
	} while (str[begin_pos] && str[end_pos]);
	
	return strs;
}


// ����� ����� ��������, �� ���������� part(...)
inline bool find_char_ex (
	std::string::const_iterator& it
	, const std::string::const_iterator& it_end
	, const char symb
	, const char open
	, const char close
	, const char exclude_symb
) {
	bool ret = false;
	size_t sub_part_count = 0;
	bool is_open = false;

	for ( ; it != it_end; it++) {			
		if (*it == open) {
			if (open == close) {
				if (!is_open) {
					is_open = true;
					sub_part_count++;
				} else {
					is_open = false;
					sub_part_count--;
				}
			} else {
				sub_part_count++;
			}
		} else if (*it == close) {
			sub_part_count--;
		} else if (*it == exclude_symb) {
			it++;
		} else if (!sub_part_count && *it == symb) {
			ret = true;
			break;
		}
	}
	
	return ret;
}

// ��������� ������ ([it, it_end]) �� ��������� ������������ ��������� (open, close), c ������ ������-������� (exclude_symb)
inline GCL::StrVector extract_fragments (
	std::string::const_iterator& it
	, const std::string::const_iterator& it_end
	, const char open
	, const char close
	, const char exclude_symb
) {
	GCL::StrVector strs;
	while ( it != it_end && *it == open) {
		strs.push_back(part(it, it_end, close, exclude_symb, open));
		it++;
	}
	return strs;
}

// ���������� ������ ������ �� ��������� ������ ([start, end]), � ������� ����������� ������� ��������� (at)
inline std::string get_line (
	const std::string::const_iterator& at
	, const std::string::const_iterator& start
	, const std::string::const_iterator& end
) {
	std::string::const_iterator str_start = at;
	std::string::const_iterator str_end = at;
	for (; str_start != start; str_start--) {
		if (*str_start == '\n') break;
	}
	for (; str_end != end; str_end++) {
		if (*str_end == '\n') break;
	}

	return std::string (str_start, str_end);
}

// ��������������� ����� ��� ��������� �������� ��� ����� ��������
struct no_case : std::binary_function <char, char, bool> {
	std::locale m_locale;

	no_case (const std::locale loc = std::locale::classic ())
		: m_locale (loc) {
	};
	
	bool operator () (char c1, char c2) const {
		return std::toupper (c1, m_locale) == std::toupper (c2, m_locale);
	};
};

// str ���������� � prefix
//   ���� prefix = 0 �� ���������� true
inline bool start_with (const char* str, const char* prefix) {
	bool retv;

	retv = false;

	if (prefix == 0) {
		retv = true;
	} else if (str) {
		size_t str_len = strlen (str);
		size_t prefix_len = strlen (prefix);

		if (str_len >= prefix_len) {
			retv = memcmp (str, prefix, prefix_len) == 0;
		}
	}

	return retv;
}

inline bool start_with (const std::string& str, const std::string& prefix) {
	return start_with (str.c_str (), prefix.c_str ());
}

// str ������������� � sufix
//   ���� sufix = 0 �� ���������� true
inline bool end_with (const char* str, const char* sufix) {
	bool retv;

	retv = false;

	if (sufix == 0) {
		retv = true;
	} else if (str) {
		size_t str_len = strlen (str);
		size_t sufix_len = strlen (sufix);

		if (str_len >= sufix_len) {
			retv = memcmp (str + (str_len - sufix_len), sufix, sufix_len) == 0;
		}
	}

	return retv;
}

// str ���������� � ������������� border
//   ���� border = 0 �� ���������� true
inline bool border_with (const char* str, const char* border) {
	bool retv;

	retv = false;

	if (border == 0) {
		retv = true;
	} else if (str) {
		size_t str_len = strlen (str);
		size_t border_len = strlen (border);

		if (str_len >= border_len) {
			retv = (memcmp (str, border, border_len) == 0)
					&& (memcmp (str + (str_len - border_len), border, border_len) == 0);
		}
	}

	return retv;
}

// str ���������� � prefix_char
inline bool start_with (const char* str, const char prefix_char) {
	bool retv = false;

	if (str) {
		retv = str [0] == prefix_char;
	}

	return retv;
}

// str ���������� � prefix_char ��� ����� ��������
inline bool starti_with (const char* str, const char prefix_char, const std::locale& loc) {
	bool retv = false;

	if (str) {
		retv = std::toupper (str [0], loc) == std::toupper (prefix_char, loc);
	}

	return retv;
}

// str ������������� � sufix_char
inline bool end_with (const char* str, const char sufix_char) {
	bool retv = false;

	if (str) {
		size_t str_len = strlen (str);

		retv = str [str_len - 1] == sufix_char;
	}

	return retv;
}

// str ������������� � sufix_char ��� ����� ��������
inline bool endi_with (const char* str, const char sufix_char, const std::locale& loc) {
	bool retv = false;

	if (str) {
		size_t str_len = strlen (str);

		retv = std::toupper (str [str_len - 1], loc) == std::toupper (sufix_char, loc);
	}

	return retv;
}

// str ���������� � ������������� border_char
inline bool border_with (const char* str, const char border_char) {
	bool retv;

	retv = false;

	if (str) {
		size_t str_len = strlen (str);

		retv = (str [0] == border_char) && (str [str_len - 1] == border_char);
	}

	return retv;
}

// str ���������� � ������������� border_char ��� ����� ��������
inline bool borderi_with (const char* str, const char border_char, const std::locale& loc) {
	bool retv = false;

	if (str) {
		size_t str_len = strlen (str);

		retv = (std::toupper (str [0], loc) == std::toupper (border_char, loc))
				&& (std::toupper (str [str_len - 1], loc) == std::toupper (border_char, loc));
	}

	return retv;
}

// ����� ��������� � �������������� �������� ���������, ��� ����� ��������
//  c �������������� STL
//  (��������������� - s_ru_win, s_ru_dos, s_ru_koi, s_eng)
//  ������������ ��������� ��������� ���������, � ��������� ������ ������������ ���������
//  �� ����� ������
inline const char* strstr (const char* str1, const char* str2, const std::locale& loc) {
	if (str1 != 0 && str2 != 0) {
		return std::search (str1, str1 + strlen (str1), str2, str2 + strlen (str2), no_case (loc));
	} else {
		return str1;
	}
};

inline int to_upper_win ( int ch ) {
	if ( ch >= 'a' && ch <= 'z' )
		return ch + 'A' - 'a';
	if ( ch >= '�' && ch <= '�' )
		return ch + '�' - '�';
	else
		return ch;
}

inline int str_compare_strong ( const char * s1, const char * s2) {
	unsigned char c1 = 0, c2 = 0;
	//	int	c1, c2;

	if (s1==0 || s2==0) {
		return 0;
	}
	if ( * s1 == '\"' )
		s1++;

	if ( * s2 == '\"' )
		s2++;

	for (register int i = 0; (s1 [i] != 0) && (s2 [i] != 0); i++) {
		c1 = to_upper_win(s1 [i]);
		c2 = to_upper_win(s2 [i]);
		// skip masked characters
		if ( c1 == '?' || c2 == '?' )
			continue;

		if ( c1 != c2 )
			return c1 - c2;			
	}

	if ( c1 == 0 || c2 == 0 )
		return c1 - c2;

	return 0;		// strings matches in first n positions
}

inline ssize_t str_compare_strong_with_len (const char * s1, const char * s2) {
	if (s1==0 || s2==0) {
		return 0;
	}
	int result = str_compare_strong (s1, s2);
	return result ? result : ACE_OS::strlen (s1) - ACE_OS::strlen (s2);
}

// �������� ������� �� ��, ��� �� �������� ������
inline bool is_alpha (const char chr, code_t code) {
	bool result;

	switch (code) {
		case cd_win_pseudo:
		case cd_win: {
			if (
				((chr >= 'A') && (chr <= 'Z'))
				|| ((chr >= 'a') && (chr <= 'z'))
				|| ((chr >= '�') && (chr <= '�'))
				|| ((chr >= '�') && (chr <= '�'))
				|| ((chr == '�') || (chr == '�'))
			) {
				result = true;
			} else {
				result = false;
			}
			break;
		}

		default: {
			assert (false); // ���������������� ���������
			result = false;
		}
	}

	return result;
}

// �������� ������� �� ��, ��� �� �������� ������
inline bool is_digit (const char chr, code_t code) {
	bool result;

	switch (code) {
		case cd_win:
		case cd_win_pseudo:
		case cd_dos:
		case cd_koi:
		case cd_mac: {
			if ((chr >= '0') && (chr <= '9')) {
				result = true;
			} else {
				result = false;
			}
			break;
		}

		default: {
			assert (false); // ���������������� ���������
			result = false;
		}
	}

	return result;
}

// �������� ������� �� ��, ��� �� �������� ������ ��� ������
inline bool is_alnum (const char chr, code_t code) {
	return is_alpha (chr, code) || is_digit (chr, code);
}

static const char* WORDS_DELIMETERS = " ,.\"\'(){}=-\\|/:;[]\r\n\t";

// �������� ������� �� ��, ��� �� �������� �������� ������������
inline bool is_delimiter (const char chr) {
	return strchr (WORDS_DELIMETERS, chr) != 0;
}

static const char* TABLE_SYMBOL = "\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a";
// �������� ������� �� ��, ��� �� �������� �������� ������� (�������������)
inline bool is_table (const char chr) {
	return strchr (TABLE_SYMBOL, chr) != 0;
}

// �������� ������� �� ������ ������� (��������� �����)
inline bool is_lower (const char chr, code_t code) {
	bool result;

	switch (code) {
		case cd_win_pseudo:
		case cd_win: {
			if (
				((chr >= 'a') && (chr <= 'z'))
				|| ((chr >= '�') && (chr <= '�'))
				|| (chr == '�')
			) {
				result = true;
			} else {
				result = false;
			}
			break;
		}

		default: {
			assert (false); // ���������������� ���������
			result = false;
		}
	}

	return result;
}

// �������� ������� �� ������� ������� (������� �����)
inline bool is_upper (const char chr, code_t code) {
	bool result;

	switch (code) {
		case cd_win_pseudo:
		case cd_win: {
			if (
				((chr >= 'A') && (chr <= 'Z'))
				|| ((chr >= '�') && (chr <= '�'))
				|| (chr == '�')
			) {
				result = true;
			} else {
				result = false;
			}
			break;
		}

		default: {
			assert (false); // ���������������� ���������
			result = false;
		}
	}

	return result;
}

// ����� ��������� � ������ � ������ ��������
// ������������ ��������� ��������� ���������, � ��������� ������ ������������ 0
inline const char* find_sub_string (const char* string, const char* sub_string) {
	if ((string == 0) || (sub_string == 0) || (*sub_string == '\0')) {
		return string;
	}

	char* string_head = (char*)string;
	while (*string_head != '\0') {
		char* s1 = string_head;
		char* s2 = (char*)sub_string;

		while ((*s1 != '\0') && (*s2 != '\0') && !(*s1-*s2)) {
			++s1;
			++s2;
		}

		if (*s2 == '\0') {
			break;
		}

		++string_head;
	}

	return *string_head != 0 ? string_head : 0;
}

// ����� ��������� � ������ ��� ������ ��������
// ������������ ��������� ��������� ���������, � ��������� ������ ������������ 0
inline const char* find_sub_string_nocase (const char* string, const char* sub_string, code_t code) {
	if ((string == 0) || (sub_string == 0) || (*sub_string == '\0')) {
		return string;
	}

	char* string_head = (char*)string;
	while (*string_head != '\0') {
		char* s1 = string_head;
		char* s2 = (char*)sub_string;

		while ((*s1 != '\0') && (*s2 != '\0') && !(char_upper (*s1, code)-char_upper (*s2, code))) {
			++s1;
			++s2;
		}

		if (*s2 == '\0') {
			break;
		}

		++string_head;
	}

	return *string_head != 0 ? string_head : 0;
}

// ���������� ������� ������� ������� ��� ����� ���������� ����� ��������
// ���� �� ����� ������ ����� ������� �� �����������, ���������� 0
inline size_t find_end_of_word_after_position (const char* line, size_t position) {
	if (!line || (ACE_OS::strlen (line) <= position - 1)) {
		return 0; 
	}

	for (size_t i = position - 1; i < ACE_OS::strlen (line); ++i) {
		if (ACE_OS::ace_isspace (line[i]) || ACE_OS::ace_ispunct (line[i])) {
			return i + 1;
		}
	}

	return 0;
}
//#UC END# *4503E01500CB*

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

