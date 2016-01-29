////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::AbstractDumpers::SyntaxDef
//
// Описание всего синтаксиса шаблона, управляющих символов и зарезервированных функций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_SYNTAXDEF_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_SYNTAXDEF_H__

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *4571A3B70109_USER_INCLUDES*
//#UC END# *4571A3B70109_USER_INCLUDES*


//#UC START# *4571A3B70109_USER_DEFINITION*
#define SX_1_CODE_TPL              '\t'
#define SX_1_STEREOTYPE		       ':'
#define SX_1_STEREOTYPE_EQ	       '='
#define SX_1_MAIN_BASE_STEREOTYPE  '!'
#define SX_1_INTERNAL_STEREOTYPE_MARK  '*'
#define SX_1_EXCLUDED_STEREOTYPE_MARK  '~'

#define SX_1_STEREOTYPE_ADD	       '&'

#define SX_1_GENID			       '+'
#define SX_1_INCLUDE               '#'
#define SX_1_GEN_OR_ST_INFO        '?'

#define SX_1_OUTPUT_TPL		       'o'
#define SX_1_OUTPUT_TPL_CREATE     'O'
#define SX_1_OUTPUT_DIR_TPL_CREATE 'C'
#define SX_1_POST_COMMAND_TPL      'X'
#define SX_1_IS_FFD			       'D'  //forbiden forward declaration
#define SX_1_ALLOW_EMPTY_TARGET    'T'
#define SX_1_USER_PROPERTY         'p'
#define SX_1_IS_EXCEPTION          'E'
#define SX_1_HAS_EXCEPTION         'e'
#define SX_1_SKIPED_ITEM           'K'
#define SX_1_AVAILABLE_TARGET_STREOTYPES 'A'
#define SX_1_PARENT_VISABILITY     'w'
#define SX_1_IS_PLAIN		       'P'
#define SX_1_OPEN_SCOPE_TPL        'S'
#define SX_1_CLOSE_SCOPE_TPL       's'
#define SX_1_FORWARD_TPL           'F'
#define SX_1_FUNCTION_TPL	       'f'
#define SX_1_TRANSFORMER_TPL       't'
#define SX_1_TRANSFORMER_COLUMN    'c'
#define SX_1_TRANSFORMER_ROW       'r'
#define SX_1_USER_FILE             'U'
#define SX_1_MAIN_ST               'M'
#define SX_1_TAB_REPLACER          'R'
#define SX_1_NEWLINE_REPLACER      'N'
#define SX_1_LABELS		           'L'
#define SX_1_IS_HOME	           'H'
#define SX_1_LINK_GUID_TPL         'G'
#define SX_1_IMAGE_FILE_NAME       'Y'

#define SX_1_UC_OPEN_START_ID      'I'
#define SX_1_UC_CLOSE_START_ID     'i'

#define SX_1_UC_OPEN_END_ID        'J'
#define SX_1_UC_CLOSE_END_ID       'j'

#define SX_1_UC_UNIQUE             'u'
#define SX_1_COLORIZE_OPTION       '$'
#define SX_1_ABSTRACTION_TYPE      'a'
#define SX_1_VISABILTY_TYPE        'v'
#define SX_1_VISIBILITY_LEVEL_SETTABLE	'V'
#define SX_1_LINK_TYPE             'l'
#define SX_1_IMPLEMENTATION_TYPE   'm'
#define SX_1_HAS_DERIVED_IMPL      'd'
#define SX_1_INCLUDED_ST           '>'
#define SX_1_EXCLUDED_ST           '<'
#define SX_1_PARAMETERIZATION_TYPE 'W'
#define SX_1_ST_MEMBERS            '%'
#define SX_1_CODING			       'c'
#define SX_1_FWD_WEIGHT			   'B'
#define SX_1_FUN_CACHE_KEY_TPL	   '@'

#define SX_C_SUPPRES_OPERATION     'S'
#define SX_C_SUPPRES_ATTRIBUTE     's'
#define SX_C_ST_ICONIC_VIEW        'i'
#define SX_C_FILL_COLOR			   'C'
#define SX_C_LINE_COLOR			   'L'
#define SX_C_FORIEN_LINE_COLOR     'l'
#define SX_C_FONT_COLOR			   'F'
#define SX_C_FORIEN_FONT_COLOR     'f'

//#define SX_AT_SELECT               's'
//#define SX_AT_TRUE                 't'
//#define SX_AT_FALSE                'f'
#define SX_AT_ABSTRACT             'a'
#define SX_AT_REGULAR              'r'
#define SX_AT_FINAL                'f'
//#define SX_AT_INLINE               'i'
#define SX_AT_OPTION               'o'

#define SX_VT_PUBLIC               '+'
#define SX_VT_PROTECTED            '#'
#define SX_VT_PRIVATE              '-'
#define SX_VT_IMPL                 'i'

#define SX_LT_AGR                 'a'
#define SX_LT_REF                 'r'
#define SX_LT_LNK                 'l'

#define SX_IT_TRUE                 't'
#define SX_IT_FALSE                'f'

#define SX_2_ARGUMENT		'%'
#define SX_2_NON_ERROR_FUNCTION		'#'
#define SX_2_INTEND			'#'
#define SX_2_SYMBOL			'\\'
#define SX_2_CYCLE_OPEN		'<'
#define SX_2_CYCLE_CLOSE	'>'
#define SX_2_IF_OPEN		'['
#define SX_2_IF_CLOSE		']'
#define SX_2_IFCYCLE_PARAMS_OPEN  '{'
#define SX_2_IFCYCLE_PARAMS_CLOSE '}'
#define SX_2_USER_PROP_OPEN		'{'
#define SX_2_USER_PROP_CLOSE	'}'

#define SX_3_ALL_CONTENTS				'A'
#define SX_3_ALL_CONSUMERS				'a'
#define SX_3_MAIN_SCOPE 				'B'
#define SX_3_NESTED_BOTOM_CONSUMERS		'b'
#define SX_3_CONTENTS					'C'
#define SX_3_REQURCIVE_ALL_CONSUMERS    'c'
#define SX_3_DEPENDENCES				'D'
#define SX_3_REQURSIVE_DEPENDENCES		'd'
#define SX_3_GET_EXCEPTIONS				'E'
#define SX_3_SET_EXCEPTIONS				'e'
#define SX_3_FORWARDED					'F'
#define SX_3_FUNCTION					'f'
#define SX_3_GENERALIZATION				'G'
#define SX_3_REQURSIVE_GENERALIZATION	'g'
#define SX_3_INCLUDES					'I'
#define SX_3_ALL_INCLUDES				'i'
#define SX_3_REALIZATOR					'L'
#define SX_3_REQURSIVE_REALIZATOR		'l'
#define SX_3_MAIN_ELEMENT				'M'
#define SX_3_DIAGRAMS					'm'
#define SX_3_SCOPES						'N'
#define SX_3_NESTED_TOP_SUPPLIERS		'n'
#define SX_3_DERIVED_OVER				'O'
#define SX_3_DERIVED_IMPL				'o'
#define SX_3_PARENTS					'P'
#define SX_3_NOT_IMPLEMENTED_DERIVED_ABSTRACT		'x'
#define SX_3_SEQUENCES					'Q'
#define SX_3_REALIZATION				'R'
#define SX_3_REQURSIVE_REALIZATION		'r'
#define SX_3_SELF						'S'
#define SX_3_SOURCE						's'
#define SX_3_TARGET						'T'
#define SX_3_TRANSFORMATOR				't'
#define SX_3_USER_CODE					'U'
#define SX_3_ALL_DUPLICATES_BY_NAME		'u'
#define SX_3_INITIAL_VALUE				'V'
#define SX_3_NO_SCOPE_FORWARDED			'W'
#define SX_3_WITHOUT_NSF_INCLUDES       'w'
#define SX_3_GENERATOR					'X'
#define SX_3_GENERALIZATOR				'Z'
#define SX_3_REQURSIVE_GENERALIZATOR	'z'
#define SX_3_BASE_STEREOTYPE_ID_OPEN		'['
#define SX_3_BASE_STEREOTYPE_ID_CLOSE		']'

#define SX_4_GEN_INFO		'+'
#define SX_4_ST_DESC		'?'
#define SX_4_AUTO_COUNTER	'A'
#define SX_4_IS_ABSTRACT    'a'
#define SX_4_LABLES          'b'
#define SX_4_MODEL_CLASS    'C'
#define SX_4_PERSISTENT_CREATION_ORDER	'c' //порядковый номер создания элемента
#define SX_4_DOCUMENTATION  'D'
#define SX_4_DIR_RELATIVE_PATH 'd'
#define SX_4_IS_EXTERNAL_NATIVE    'e'
#define SX_4_FORWARD        'F' 
#define SX_4_IS_FIXED       'f'
#define SX_4_OS_GUID        'G'
#define SX_4_LINK_GUID      'g'
#define SX_4_INITIAL_VALUE  'I' // for attr and ops::param
#define SX_4_CLASS_KIND     'K'
#define SX_4_FILE_RELATIVE_PATH 'L'
#define SX_4_LINK_TYPE      'l'
#define SX_4_MODEL_STEREOTYPE 'M'
#define SX_4_TREE_NUMBER    'm'
#define SX_4_NAME			'N'
#define SX_4_CYCLE_NUM      'n'
#define SX_4_FILE_NAME      'O'
#define SX_4_FILE_PATH      'o'
#define SX_4_OPEN_SCOPE     'P'
#define SX_4_CLOSE_SCOPE    'p'
#define SX_4_ROOT_DIR		'R'
#define SX_4_IS_REG			'r'
#define SX_4_STEREOTYPE     'S'
#define SX_4_TARGET_STEREOTYPE 's'
#define SX_4_IS_TOP_REG		't'
#define SX_4_VISABILITY     'V'
#define SX_4_MODEL_UNIQUE_ID  'U'
#define SX_4_FILE_RELATIVE_PATH_WITH_PARENT 'W'
#define SX_4_DUMPING		'X'
#define SX_4_IS_EXISTS      'x'
#define SX_4_IMAGE_FILE_NAME      'Y'

#define SX_4_ST_BY_NAME      'n'
#define SX_4_ST_BY_GUID      'g'
#define SX_4_ST_BY_PARENT_AND_NAME 'p'
#define SX_4_ST_BY_POSITION  'u'
#define SX_4_ST_BY_ORDER	 'o'
#define SX_4_ST_BY_CREATION_ORDER	 'c'

#define SX_4_COND_NOT		'!'
#define SX_4_COND_EQU		'='
#define SX_4_COND_AND		'&'
#define SX_4_COND_OR		'|'

#define SX_3_NEW_STR		'n'
#define SX_3_TAB			't'
#define SX_3_WHILE_CYCLE     'W'
#define SX_3_SKIP_DUPLICATE  'D'
#define SX_3_REVERSE_CYCLE   'r'
#define SX_3_SEPARATOR_BEGIN '"'
#define SX_3_SEPARATOR_END   '"'
#define SX_3_SHIFT_BEGIN     '+'
#define SX_3_SHIFT_END       '-'
#define SX_3_CYCLE_COUNT_DUMP 'C'
#define SX_3_SORTING_TYPE    'S'

#include "usercode_def.i.h"

// standart function identificator
/*#define FID_DEBUG_POINT "_dbg_point"
#define FID_CONVERT_TO_OMG_STYLE "_to_omg"
#define FID_CONVERT_TO_BORLAND_STYLE "_to_borland"
#define FID_CONVERT_TO_JAVA_STYLE "_to_java"
#define FID_STRING_CONVERTER "_str_conv"
#define FID_STRING_SPLIT "_str_split"
#define FID_STRING_LOWER_CASE "_to_lower"
#define FID_STRING_UPPER_CASE "_to_upper"
#define FID_TO_WIDE_STR "_to_wide_code"
#define FID_STR_REPLACE "_str_replace"
#define FID_MODEL_ERROR "_error"
#define FID_MODEL_WARNING "_warning"
#define FID_CHANGE_GENID "_with_gen_id"
#define FID_SET_GENID "_set_gen_id"
#define FID_SET_GEN_PROP "_set_prop"
#define FID_SET_VAR_DUMPER "_set_var"
#define FID_ELEMENT_COUNTER "_elem_counter"
#define FID_SHIFT_INTEND "_shift_intend"
#define FID_DEC_TO_HEX "_dec_to_hex"
#define FID_NORMOLIZED_PATH "_normolized_path"
#define FID_NORMOLIZED_DIR "_normolized_dir"
#define FID_SUBSTRING_FROM_END "_substr_from_end"
#define FID_SUBSTRING_FROM_BEGIN "_substr_from_begin"
#define FID_DELSUBSTR_FROM_END "_delsubstr_from_end"
#define FID_DELSUBSTR_FROM_BEGIN "_delsubstr_from_begin"
#define FID_STRING_HASH "_string_hash"
#define FID_STRING_LENGTH "_string_length"
#define FID_STRING_CMP "_string_cmp"
#define FID_STRING_FIND "_string_find"
#define FID_NUMBER_CMP "_number_cmp"
#define FID_SHIFT_SCOPE "_shift_scope"
#define FID_DUMP_DIAGRAM "_dump_diagram"
#define FID_ADD_TO_LIST "_add_to_list"
#define FID_REMOVE_FROM_LIST "_remove_to_list"
#define FID_EXIST_IN_LIST "_exist_in_list"
#define FID_CLEAR_LIST "_clear_list"
#define FID_POP_BACK_TO_VAR "_pop_back_to_var"
#define FID_POP_FRONT_TO_VAR "_pop_front_to_var"
#define FID_IS_EMPTY "_is_empty"
#define FID_COUNT_IN_LIST "_count_in_list"
#define FID_SORT_LIST "_sort_list"
#define FID_COPY_LIST "_copy_list"
#define FID_UNIQUE_LIST "_unique_list"
#define FID_SPLIT_TO_LIST "_split_to_list"
#define FID_TO_RGB "_to_rgb"
#define FID_HAS_NON_EMPTY_GEN "_has_non_empty_gen"
#define FID_EVALUATE "_evaluate"*/

#define FILE_SIGNATURE "MDA GENERATOR TEMPLATE FILE"
#define STR_TEMP_GEN_EX ".tmpgen"
#define STR_CONF_FLAG "conf:"
//#UC END# *4571A3B70109_USER_DEFINITION*



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_SYNTAXDEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
