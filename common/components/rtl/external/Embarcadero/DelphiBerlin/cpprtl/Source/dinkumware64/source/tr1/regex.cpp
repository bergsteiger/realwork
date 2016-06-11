// regex: debugging tables needed by basic_regex
#include <new>

 #if _HAS_TR1
 #include <regex>

 #if _REGEX_DEBUGGING
_STD_BEGIN
unsigned _Nfa_show_base::_Indent = 0;

char _Nfa_show_base::_Flag_names[] = "dbebeancpadscf";

const char *_Nfa_show_base::_Node_names[] = {
	"none",
	"nop",
	"bol",
	"eol",
	"wbound",
	"dot",
	"str",
	"class",
	"group",
	"end_group",
	"assert",
	"neg_assert",
	"end_assert",
	"capture",
	"end_capture",
	"back",
	"if",
	"endif",
	"rep",
	"end_rep",
	"begin",
	"end",
	};
_STD_END
 #endif /* _REGEX_DEBUGGING */
 #else /* _HAS_TR1 */
 #endif /* _HAS_TR1 */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
