{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Internal.ICU;
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
  System.SysUtils;

{*********************************************************}
{ Delphi ICU port.                                        }
{ Documentation: http://www.icu-project.org/apiref/icu4c/ }
{*********************************************************}

{ Basic definitions for ICU }
{ http://www.icu-project.org/apiref/icu4c/utypes_8h.html }
type
  UErrorCode = (
    U_USING_FALLBACK_WARNING = -128, U_ERROR_WARNING_START = -128, U_USING_DEFAULT_WARNING = -127,
    U_SAFECLONE_ALLOCATED_WARNING = -126, U_STATE_OLD_WARNING = -125, U_STRING_NOT_TERMINATED_WARNING = -124,
    U_SORT_KEY_TOO_SHORT_WARNING = -123, U_AMBIGUOUS_ALIAS_WARNING = -122, U_DIFFERENT_UCA_VERSION = -121,
    U_PLUGIN_CHANGED_LEVEL_WARNING = -120, U_ERROR_WARNING_LIMIT, U_ZERO_ERROR = 0, U_ILLEGAL_ARGUMENT_ERROR = 1,
    U_MISSING_RESOURCE_ERROR = 2, U_INVALID_FORMAT_ERROR = 3, U_FILE_ACCESS_ERROR = 4, U_INTERNAL_PROGRAM_ERROR = 5,
    U_MESSAGE_PARSE_ERROR = 6, U_MEMORY_ALLOCATION_ERROR = 7, U_INDEX_OUTOFBOUNDS_ERROR = 8, U_PARSE_ERROR = 9,
    U_INVALID_CHAR_FOUND = 10, U_TRUNCATED_CHAR_FOUND = 11, U_ILLEGAL_CHAR_FOUND = 12, U_INVALID_TABLE_FORMAT = 13,
    U_INVALID_TABLE_FILE = 14, U_BUFFER_OVERFLOW_ERROR = 15, U_UNSUPPORTED_ERROR = 16, U_RESOURCE_TYPE_MISMATCH = 17,
    U_ILLEGAL_ESCAPE_SEQUENCE = 18, U_UNSUPPORTED_ESCAPE_SEQUENCE = 19, U_NO_SPACE_AVAILABLE = 20,
    U_CE_NOT_FOUND_ERROR = 21, U_PRIMARY_TOO_LONG_ERROR = 22, U_STATE_TOO_OLD_ERROR = 23, U_TOO_MANY_ALIASES_ERROR = 24,
    U_ENUM_OUT_OF_SYNC_ERROR = 25, U_INVARIANT_CONVERSION_ERROR = 26, U_INVALID_STATE_ERROR = 27,
    U_COLLATOR_VERSION_MISMATCH = 28, U_USELESS_COLLATOR_ERROR = 29, U_NO_WRITE_PERMISSION = 30, U_STANDARD_ERROR_LIMIT,
    U_BAD_VARIABLE_DEFINITION = $10000, U_PARSE_ERROR_START = $10000, U_MALFORMED_RULE, U_MALFORMED_SET,
    U_MALFORMED_SYMBOL_REFERENCE, U_MALFORMED_UNICODE_ESCAPE, U_MALFORMED_VARIABLE_DEFINITION,
    U_MALFORMED_VARIABLE_REFERENCE, U_MISMATCHED_SEGMENT_DELIMITERS, U_MISPLACED_ANCHOR_START,
    U_MISPLACED_CURSOR_OFFSET, U_MISPLACED_QUANTIFIER, U_MISSING_OPERATOR, U_MISSING_SEGMENT_CLOSE,
    U_MULTIPLE_ANTE_CONTEXTS, U_MULTIPLE_CURSORS, U_MULTIPLE_POST_CONTEXTS, U_TRAILING_BACKSLASH,
    U_UNDEFINED_SEGMENT_REFERENCE, U_UNDEFINED_VARIABLE, U_UNQUOTED_SPECIAL, U_UNTERMINATED_QUOTE, U_RULE_MASK_ERROR,
    U_MISPLACED_COMPOUND_FILTER, U_MULTIPLE_COMPOUND_FILTERS, U_INVALID_RBT_SYNTAX, U_INVALID_PROPERTY_PATTERN,
    U_MALFORMED_PRAGMA, U_UNCLOSED_SEGMENT, U_ILLEGAL_CHAR_IN_SEGMENT, U_VARIABLE_RANGE_EXHAUSTED,
    U_VARIABLE_RANGE_OVERLAP, U_ILLEGAL_CHARACTER, U_INTERNAL_TRANSLITERATOR_ERROR, U_INVALID_ID, U_INVALID_FUNCTION,
    U_PARSE_ERROR_LIMIT, U_UNEXPECTED_TOKEN = $10100, U_FMT_PARSE_ERROR_START = $10100, U_MULTIPLE_DECIMAL_SEPARATORS,
    U_MULTIPLE_DECIMAL_SEPERATORS = U_MULTIPLE_DECIMAL_SEPARATORS, U_MULTIPLE_EXPONENTIAL_SYMBOLS,
    U_MALFORMED_EXPONENTIAL_PATTERN, U_MULTIPLE_PERCENT_SYMBOLS, U_MULTIPLE_PERMILL_SYMBOLS, U_MULTIPLE_PAD_SPECIFIERS,
    U_PATTERN_SYNTAX_ERROR, U_ILLEGAL_PAD_POSITION, U_UNMATCHED_BRACES, U_UNSUPPORTED_PROPERTY, U_UNSUPPORTED_ATTRIBUTE,
    U_ARGUMENT_TYPE_MISMATCH, U_DUPLICATE_KEYWORD, U_UNDEFINED_KEYWORD, U_DEFAULT_KEYWORD_MISSING,
    U_DECIMAL_NUMBER_SYNTAX_ERROR, U_FORMAT_INEXACT_ERROR, U_FMT_PARSE_ERROR_LIMIT, U_BRK_INTERNAL_ERROR = $10200,
    U_BRK_ERROR_START = $10200, U_BRK_HEX_DIGITS_EXPECTED, U_BRK_SEMICOLON_EXPECTED, U_BRK_RULE_SYNTAX,
    U_BRK_UNCLOSED_SET, U_BRK_ASSIGN_ERROR, U_BRK_VARIABLE_REDFINITION, U_BRK_MISMATCHED_PAREN,
    U_BRK_NEW_LINE_IN_QUOTED_STRING, U_BRK_UNDEFINED_VARIABLE, U_BRK_INIT_ERROR, U_BRK_RULE_EMPTY_SET,
    U_BRK_UNRECOGNIZED_OPTION, U_BRK_MALFORMED_RULE_TAG, U_BRK_ERROR_LIMIT, U_REGEX_INTERNAL_ERROR = $10300,
    U_REGEX_ERROR_START = $10300, U_REGEX_RULE_SYNTAX, U_REGEX_INVALID_STATE, U_REGEX_BAD_ESCAPE_SEQUENCE,
    U_REGEX_PROPERTY_SYNTAX, U_REGEX_UNIMPLEMENTED, U_REGEX_MISMATCHED_PAREN, U_REGEX_NUMBER_TOO_BIG,
    U_REGEX_BAD_INTERVAL, U_REGEX_MAX_LT_MIN, U_REGEX_INVALID_BACK_REF, U_REGEX_INVALID_FLAG, U_REGEX_LOOK_BEHIND_LIMIT,
    U_REGEX_SET_CONTAINS_STRING, U_REGEX_OCTAL_TOO_BIG, U_REGEX_MISSING_CLOSE_BRACKET, U_REGEX_INVALID_RANGE,
    U_REGEX_STACK_OVERFLOW, U_REGEX_TIME_OUT, U_REGEX_STOPPED_BY_CALLER, U_REGEX_ERROR_LIMIT,
    U_IDNA_PROHIBITED_ERROR = $10400, U_IDNA_ERROR_START = $10400, U_IDNA_UNASSIGNED_ERROR, U_IDNA_CHECK_BIDI_ERROR,
    U_IDNA_STD3_ASCII_RULES_ERROR, U_IDNA_ACE_PREFIX_ERROR, U_IDNA_VERIFICATION_ERROR, U_IDNA_LABEL_TOO_LONG_ERROR,
    U_IDNA_ZERO_LENGTH_LABEL_ERROR, U_IDNA_DOMAIN_NAME_TOO_LONG_ERROR, U_IDNA_ERROR_LIMIT,
    U_STRINGPREP_PROHIBITED_ERROR = U_IDNA_PROHIBITED_ERROR, U_STRINGPREP_UNASSIGNED_ERROR = U_IDNA_UNASSIGNED_ERROR,
    U_STRINGPREP_CHECK_BIDI_ERROR = U_IDNA_CHECK_BIDI_ERROR, U_PLUGIN_ERROR_START = $10500, U_PLUGIN_TOO_HIGH = $10500,
    U_PLUGIN_DIDNT_SET_LEVEL, U_PLUGIN_ERROR_LIMIT, U_ERROR_LIMIT = U_PLUGIN_ERROR_LIMIT
  );

type
  UBool = ShortInt;
  UDate = Double;
  UChar = Char;
  PUChar = PChar;
  PPUChar = ^PChar;
  UChar32 = Int32;
  PUErrorCode = ^UErrorCode;
  TByteArray = array of Byte;

  UInt16 = Word;

  PInt32 = ^Int32;

  { ICU ucnv.h File Reference }
  { http://icu-project.org/apiref/icu4c/ucnv_8h.html }

const
  // Maximum length of a converter name including the terminating NULL.
  UCNV_MAX_CONVERTER_NAME_LENGTH = 60;
  // Maximum length of a converter name including path and terminating NULL.
  UCNV_MAX_FULL_FILE_NAME_LENGTH = (600+UCNV_MAX_CONVERTER_NAME_LENGTH);
  // Shift in for EBDCDIC_STATEFUL and iso2022 states.
  UCNV_SI = $0F;
  // Shift out for EBDCDIC_STATEFUL and iso2022 states.
  UCNV_SO = $0E;
  // Character that separates converter names from options and options from each other.
  UCNV_OPTION_SEP_CHAR: char = ',';
  // String version of UCNV_OPTION_SEP_CHAR.
  UCNV_OPTION_SEP_STRING: string = ',';
  // Character that separates a converter option from its value.
  UCNV_VALUE_SEP_CHAR: char = '=';
  // String version of UCNV_VALUE_SEP_CHAR.
  UCNV_VALUE_SEP_STRING: string = '=';
  // Converter option for specifying a locale.
  UCNV_LOCALE_OPTION_STRING = ',locale=';
  // Converter option for specifying a version selector (0..9) for some converters.
  UCNV_VERSION_OPTION_STRING = ',version=';
  // Converter option for EBCDIC SBCS or mixed-SBCS/DBCS (stateful) codepages.
  UCNV_SWAP_LFNL_OPTION_STRING = ',swaplfnl';
  // Definition of a buffer size that is designed to be large enough for converters to be cloned with ucnv_safeClone().
  U_CNV_SAFECLONE_BUFFERSIZE = 1024;
  //Calculates the size of a buffer for conversion from Unicode to a charset.
  //UCNV_GET_MAX_BYTES_FOR_STRING(length, maxCharSize)   (((int32_t)(length)+10)*(int32_t)(maxCharSize))

const
  UCNV_PRV_ESCAPE_ICU      = 0;
  UCNV_PRV_ESCAPE_C        = Ord('C');
  UCNV_PRV_ESCAPE_XML_DEC  = Ord('D');
  UCNV_PRV_ESCAPE_XML_HEX  = Ord('X');
  UCNV_PRV_ESCAPE_JAVA     = Ord('J');
  UCNV_PRV_ESCAPE_UNICODE  = Ord('U');
  UCNV_PRV_ESCAPE_CSS2     = Ord('S');
  UCNV_PRV_STOP_ON_ILLEGAL = Ord('i');



type
  PUSet = ^USet;
  USet = record end;

  //  Enum for specifying basic types of converters.
  UConverterType = (
    UCNV_UNSUPPORTED_CONVERTER = -1, UCNV_SBCS = 0, UCNV_DBCS = 1, UCNV_MBCS = 2, UCNV_LATIN_1 = 3, UCNV_UTF8 = 4,
    UCNV_UTF16_BigEndian = 5, UCNV_UTF16_LittleEndian = 6, UCNV_UTF32_BigEndian = 7, UCNV_UTF32_LittleEndian = 8,
    UCNV_EBCDIC_STATEFUL = 9, UCNV_ISO_2022 = 10, UCNV_LMBCS_1 = 11, UCNV_LMBCS_2, UCNV_LMBCS_3, UCNV_LMBCS_4,
    UCNV_LMBCS_5, UCNV_LMBCS_6, UCNV_LMBCS_8, UCNV_LMBCS_11, UCNV_LMBCS_16, UCNV_LMBCS_17, UCNV_LMBCS_18, UCNV_LMBCS_19,
    UCNV_LMBCS_LAST = UCNV_LMBCS_19, UCNV_HZ, UCNV_SCSU, UCNV_ISCII, UCNV_US_ASCII, UCNV_UTF7, UCNV_BOCU1, UCNV_UTF16,
    UCNV_UTF32, UCNV_CESU8, UCNV_IMAP_MAILBOX, UCNV_COMPOUND_TEXT, UCNV_NUMBER_OF_SUPPORTED_CONVERTER_TYPES
  );

  //  Enum for specifying which platform a converter ID refers to.
  UConverterPlatform = (UCNV_UNKNOWN = -1, UCNV_IBM = 0);

  //  Selectors for Unicode sets that can be returned by ucnv_getUnicodeSet().
  UConverterUnicodeSet = (UCNV_ROUNDTRIP_SET, UCNV_ROUNDTRIP_AND_FALLBACK_SET, UCNV_SET_COUNT);

  //  Selectors for Unicode sets that can be returned by ucnv_getUnicodeSet().
  UConverterCallbackReason = (
    UCNV_CB_UNASSIGNED = 0,  // The code point is unassigned. The error code U_INVALID_CHAR_FOUND will be set.
    UCNV_CB_ILLEGAL = 1,     // The code point is illegal. The error code U_ILLEGAL_CHAR_FOUND will be set.
    UCNV_CB_IRREGULAR = 2,   // The codepoint is not a regular sequence in the encoding. The error code U_INVALID_CHAR_FOUND will be set.
    UCNV_CB_RESET = 3,       // The callback is called with this reason when a 'reset' has occured. Callback should reset all state.
    UCNV_CB_CLOSE = 4,       // Called when the converter is closed. The callback should release any allocated memory.
    UCNV_CB_CLONE = 5        // Called when ucnv_safeClone() is called on the converter. the pointer available as the
                             // 'context' is an alias to the original converters' context pointer. If the context must be owned
                             // by the new converter, the callback must clone the data and call ucnv_setFromUCallback
                             // (or setToUCallback) with the correct pointer.
  );

  PUConverter = ^UConverter;
  UConverter = record end;

  PUConverterToUnicodeArgs = ^UConverterToUnicodeArgs;
  UConverterToUnicodeArgs = record     // http://icu-project.org/apiref/icu4c/structUConverterToUnicodeArgs.html
    size: UInt16;                      // The size of this struct
    flush: UBool;                      // The internal state of converter will be reset and data flushed if set to TRUE.
    converter: PUConverter;            // Pointer to the converter that is opened and to which this struct is passed as an argument.
    source: MarshaledAString;          // Pointer to the source source buffer.
    sourceLimit: MarshaledAString;     // Pointer to the limit (end + 1) of source buffer.
    target: PUChar;                    // Pointer to the target buffer.
    targetLimit: PUChar;               // Pointer to the limit (end + 1) of target buffer.
    offsets: PInt32;                   // Pointer to the buffer that recieves the offsets.
  end;

  PUConverterFromUnicodeArgs = ^UConverterFromUnicodeArgs;
  UConverterFromUnicodeArgs = record     // http://icu-project.org/apiref/icu4c/structUConverterToUnicodeArgs.html
    size: UInt16;                      // The size of this struct
    flush: UBool;                      // The internal state of converter will be reset and data flushed if set to TRUE.
    converter: PUConverter;            // Pointer to the converter that is opened and to which this struct is passed as an argument.
    source: MarshaledAString;          // Pointer to the source source buffer.
    sourceLimit: MarshaledAString;     // Pointer to the limit (end + 1) of source buffer.
    target: PUChar;                    // Pointer to the target buffer.
    targetLimit: PUChar;               // Pointer to the limit (end + 1) of target buffer.
    offsets: PInt32;                   // Pointer to the buffer that recieves the offsets.
  end;

  //typedef void(* 	UConverterToUCallback )(const void *context, UConverterToUnicodeArgs *args, const char *codeUnits, int32_t length, UConverterCallbackReason reason, UErrorCode *pErrorCode)
  //  Function pointer for error callback in the codepage to unicode direction.
  UConverterToUCallback = procedure(const context: Pointer; args: PUConverterToUnicodeArgs;
      const codeUnits: MarshaledAString; aLength: Int32; reason: UConverterCallbackReason;
      var ErrorCode: UErrorCode); cdecl;

  //typedef void(* 	UConverterFromUCallback )(const void *context, UConverterFromUnicodeArgs *args, const UChar *codeUnits, int32_t length, UChar32 codePoint, UConverterCallbackReason reason, UErrorCode *pErrorCode)
  //  Function pointer for error callback in the unicode to codepage direction.
  UConverterFromUCallBack = procedure(const context: Pointer; args: PUConverterFromUnicodeArgs;
      const codeUnits: PUChar; aLength: Int32; codePoint: UChar32; reason: UConverterCallbackReason;
      var ErrorCode: UErrorCode); cdecl;


  { ICU ucol.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/ucol_8h.html }

const
  USCRIPT_UNKNOWN = 103; // From "uscript.h"

type
  UCollationResult = (UCOL_LESS = -1, UCOL_EQUAL = 0, UCOL_GREATER = 1);
  PUCollator = ^UCollator;
  UCollator = record end;

  // Enum containing attribute values for controling collation behavior.
  UColAttributeValue = (
    UCOL_DEFAULT = -1, UCOL_PRIMARY = 0, UCOL_SECONDARY = 1, UCOL_TERTIARY = 2, UCOL_DEFAULT_STRENGTH = UCOL_TERTIARY,
    UCOL_CE_STRENGTH_LIMIT, UCOL_QUATERNARY = 3, UCOL_IDENTICAL = 15, UCOL_STRENGTH_LIMIT, UCOL_OFF = 16, UCOL_ON = 17,
    UCOL_SHIFTED = 20, UCOL_NON_IGNORABLE = 21, UCOL_LOWER_FIRST = 24, UCOL_UPPER_FIRST = 25, UCOL_ATTRIBUTE_VALUE_COUNT
  );

  UCollationStrength = UColAttributeValue;

  // Enum containing the codes for reordering segments of the collation table that are not script codes.
  UColReorderCode = (
    UCOL_REORDER_CODE_DEFAULT = -1, UCOL_REORDER_CODE_NONE = USCRIPT_UNKNOWN,
    UCOL_REORDER_CODE_OTHERS = USCRIPT_UNKNOWN, UCOL_REORDER_CODE_SPACE = $1000,
    UCOL_REORDER_CODE_FIRST = UCOL_REORDER_CODE_SPACE, UCOL_REORDER_CODE_PUNCTUATION = $1001,
    UCOL_REORDER_CODE_SYMBOL = $1002, UCOL_REORDER_CODE_CURRENCY = $1003, UCOL_REORDER_CODE_DIGIT = $1004,
    UCOL_REORDER_CODE_LIMIT = $1005
  );

  // Attributes that collation service understands.
  UColAttribute = (
    UCOL_FRENCH_COLLATION, UCOL_ALTERNATE_HANDLING, UCOL_CASE_FIRST, UCOL_CASE_LEVEL, UCOL_NORMALIZATION_MODE,
    UCOL_DECOMPOSITION_MODE = UCOL_NORMALIZATION_MODE, UCOL_STRENGTH, UCOL_HIRAGANA_QUATERNARY_MODE = UCOL_STRENGTH + 1,
    UCOL_NUMERIC_COLLATION = UCOL_STRENGTH + 2, UCOL_ATTRIBUTE_COUNT
  );

  //Options for retrieving the rule string.
  UColRuleOption = (UCOL_TAILORING_ONLY, UCOL_FULL_RULES);

  // enum that is taken by ucol_getBound API See below for explanation do not change
  // the values assigned to the members of this enum.
  UColBoundMode = (UCOL_BOUND_LOWER = 0, UCOL_BOUND_UPPER = 1, UCOL_BOUND_UPPER_LONG = 2, UCOL_BOUND_VALUE_COUNT);


  { ICU uloc.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/uloc_8h.html }
  // Constants for *_getLocale() Allow user to select whether she wants information on requested, valid or actual locale.
  ULocDataLocaleType = (
    ULOC_ACTUAL_LOCALE = 0, ULOC_VALID_LOCALE = 1, ULOC_REQUESTED_LOCALE = 2, ULOC_DATA_LOCALE_TYPE_LIMIT = 3
  );

  // enums for the 'outResult' parameter return value
  UAcceptResult = (ULOC_ACCEPT_FAILED = 0, ULOC_ACCEPT_VALID = 1, ULOC_ACCEPT_FALLBACK = 2);


const
  //  Useful constant for the maximum size of the language part of a locale ID.
  ULOC_LANG_CAPACITY = 12;
  //  Useful constant for the maximum size of the country part of a locale ID (including the terminating NULL).
  ULOC_COUNTRY_CAPACITY =  4;
  //  Useful constant for the maximum size of the whole locale ID (including the terminating NULL and all keywords).
  ULOC_FULLNAME_CAPACITY = 157;
  //  Useful constant for the maximum size of the script part of a locale ID (including the terminating NULL).
  ULOC_SCRIPT_CAPACITY = 6;
  //  Useful constant for the maximum size of keywords in a locale.
  ULOC_KEYWORDS_CAPACITY = 50;
  //  Useful constant for the maximum total size of keywords and their values in a locale.
  ULOC_KEYWORD_AND_VALUES_CAPACITY = 100;
  //  Invariant character separating keywords from the locale string.
  ULOC_KEYWORD_SEPARATOR = '@';
  //  Unicode code point for '@' separating keywords from the locale string.
  ULOC_KEYWORD_SEPARATOR_UNICODE = $40;
  //  Invariant character for assigning value to a keyword.
  ULOC_KEYWORD_ASSIGN = '=';
  //  Unicode code point for '=' for assigning value to a keyword.
  ULOC_KEYWORD_ASSIGN_UNICODE = $3D;
  //  Invariant character separating keywords.
  ULOC_KEYWORD_ITEM_SEPARATOR = ';';
  //  Unicode code point for ';' separating keywords.
  ULOC_KEYWORD_ITEM_SEPARATOR_UNICODE = $3B;

  { ICU uloc.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/uloc_8h.html }
type
  //  A locale data object.
  PULocaleData = ^ULocaleData;
  ULocaleData = record end;

  //  The possible types of exemplar character sets.
  ULocaleDataExemplarSetType = (
    ULOCDATA_ES_STANDARD = 0, ULOCDATA_ES_AUXILIARY = 1, ULOCDATA_ES_INDEX = 2, ULOCDATA_ES_PUNCTUATION = 3,
    ULOCDATA_ES_COUNT = 4
  );

  //  The possible types of delimiters.
  ULocaleDataDelimiterType = (
    ULOCDATA_QUOTATION_START = 0, ULOCDATA_QUOTATION_END = 1, ULOCDATA_ALT_QUOTATION_START = 2,
    ULOCDATA_ALT_QUOTATION_END = 3, ULOCDATA_DELIMITER_COUNT = 4
  );

  //  Enumeration for representing the measurement systems.
  UMeasurementSystem = (UMS_SI, UMS_US, UMS_LIMIT);


type
  PUFieldPosition = ^UFieldPosition;
  UFieldPosition = record
    field: Int32;
    beginIndex: Int32;
    endIndex: Int32;
  end;

const
  U_PARSE_CONTEXT_LEN = 16;

type
  PUParseError = ^UParseError;
  UParseError = record
    line: Int32;    //  The line on which the error occured.
    offset: Int32;  //  The character offset to the error.
    preContext : array [0..U_PARSE_CONTEXT_LEN-1] of UChar; //  Textual context before the error.
    postContext: array [0..U_PARSE_CONTEXT_LEN-1] of UChar; //  The error itself and/or textual context after the error.
  end;

  { unum.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/unum_8h.html }

  // A number formatter. Dummy structure.
  PUNumberFormat = ^UNumberFormat;
  UNumberFormat = record end;

  //  The possible number format styles.
  UNumberFormatStyle = (
    UNUM_PATTERN_DECIMAL = 0, UNUM_DECIMAL = 1, UNUM_CURRENCY, UNUM_PERCENT, UNUM_SCIENTIFIC, UNUM_SPELLOUT,
    UNUM_ORDINAL, UNUM_DURATION, UNUM_NUMBERING_SYSTEM, UNUM_PATTERN_RULEBASED, UNUM_CURRENCY_ISO, UNUM_CURRENCY_PLURAL,
    UNUM_FORMAT_STYLE_COUNT, UNUM_DEFAULT = UNUM_DECIMAL, UNUM_IGNORE = UNUM_PATTERN_DECIMAL
  );

  //  The possible number format rounding modes.
  UNumberFormatRoundingMode = (
    UNUM_ROUND_CEILING, UNUM_ROUND_FLOOR, UNUM_ROUND_DOWN, UNUM_ROUND_UP, UNUM_ROUND_HALFEVEN,
    UNUM_FOUND_HALFEVEN = UNUM_ROUND_HALFEVEN, UNUM_ROUND_HALFDOWN, UNUM_ROUND_HALFUP, UNUM_ROUND_UNNECESSARY
  );

  //  The possible number format pad positions. More...
  UNumberFormatPadPosition = (
    UNUM_PAD_BEFORE_PREFIX, UNUM_PAD_AFTER_PREFIX, UNUM_PAD_BEFORE_SUFFIX, UNUM_PAD_AFTER_SUFFIX
  );

  //  Constants for specifying short or long format. More...
  UNumberCompactStyle = ( UNUM_SHORT, UNUM_LONG );

  //  Constants for specifying currency spacing. More...
  UCurrencySpacing = (
    UNUM_CURRENCY_MATCH, UNUM_CURRENCY_SURROUNDING_MATCH, UNUM_CURRENCY_INSERT, UNUM_CURRENCY_SPACING_COUNT
  );

  //  FieldPosition and UFieldPosition selectors for format fields defined by NumberFormat and UNumberFormat. More...
  UNumberFormatFields = (
    UNUM_INTEGER_FIELD, UNUM_FRACTION_FIELD, UNUM_DECIMAL_SEPARATOR_FIELD, UNUM_EXPONENT_SYMBOL_FIELD,
    UNUM_EXPONENT_SIGN_FIELD, UNUM_EXPONENT_FIELD, UNUM_GROUPING_SEPARATOR_FIELD, UNUM_CURRENCY_FIELD,
    UNUM_PERCENT_FIELD, UNUM_PERMILL_FIELD, UNUM_SIGN_FIELD, UNUM_FIELD_COUNT
  );

  //  The possible UNumberFormat numeric attributes. More...
  UNumberFormatAttribute = (
    UNUM_PARSE_INT_ONLY, UNUM_GROUPING_USED, UNUM_DECIMAL_ALWAYS_SHOWN, UNUM_MAX_INTEGER_DIGITS,
    UNUM_MIN_INTEGER_DIGITS, UNUM_INTEGER_DIGITS, UNUM_MAX_FRACTION_DIGITS, UNUM_MIN_FRACTION_DIGITS,
    UNUM_FRACTION_DIGITS, UNUM_MULTIPLIER, UNUM_GROUPING_SIZE, UNUM_ROUNDING_MODE, UNUM_ROUNDING_INCREMENT,
    UNUM_FORMAT_WIDTH, UNUM_PADDING_POSITION, UNUM_SECONDARY_GROUPING_SIZE, UNUM_SIGNIFICANT_DIGITS_USED,
    UNUM_MIN_SIGNIFICANT_DIGITS, UNUM_MAX_SIGNIFICANT_DIGITS, UNUM_LENIENT_PARSE, UNUM_SCALE = UNUM_LENIENT_PARSE + 2,
    UNUM_NUMERIC_ATTRIBUTE_COUNT, UNUM_MAX_NONBOOLEAN_ATTRIBUTE = $0FFF,
    UNUM_FORMAT_FAIL_IF_MORE_THAN_MAX_DIGITS = $1000, UNUM_PARSE_NO_EXPONENT, UNUM_LIMIT_BOOLEAN_ATTRIBUTE
  );

  //  The possible UNumberFormat text attributes. More...
  UNumberFormatTextAttribute = (
    UNUM_POSITIVE_PREFIX, UNUM_POSITIVE_SUFFIX, UNUM_NEGATIVE_PREFIX, UNUM_NEGATIVE_SUFFIX,
    UNUM_PADDING_CHARACTER, UNUM_CURRENCY_CODE, UNUM_DEFAULT_RULESET, UNUM_PUBLIC_RULESETS
  );

  //  Constants for specifying a number format symbol. More...
  UNumberFormatSymbol = (
    UNUM_DECIMAL_SEPARATOR_SYMBOL = 0, UNUM_GROUPING_SEPARATOR_SYMBOL = 1, UNUM_PATTERN_SEPARATOR_SYMBOL = 2,
    UNUM_PERCENT_SYMBOL = 3, UNUM_ZERO_DIGIT_SYMBOL = 4, UNUM_DIGIT_SYMBOL = 5, UNUM_MINUS_SIGN_SYMBOL = 6,
    UNUM_PLUS_SIGN_SYMBOL = 7, UNUM_CURRENCY_SYMBOL = 8, UNUM_INTL_CURRENCY_SYMBOL = 9,
    UNUM_MONETARY_SEPARATOR_SYMBOL = 10, UNUM_EXPONENTIAL_SYMBOL = 11, UNUM_PERMILL_SYMBOL = 12,
    UNUM_PAD_ESCAPE_SYMBOL = 13, UNUM_INFINITY_SYMBOL = 14, UNUM_NAN_SYMBOL = 15, UNUM_SIGNIFICANT_DIGIT_SYMBOL = 16,
    UNUM_MONETARY_GROUPING_SEPARATOR_SYMBOL = 17, UNUM_ONE_DIGIT_SYMBOL = 18, UNUM_TWO_DIGIT_SYMBOL = 19,
    UNUM_THREE_DIGIT_SYMBOL = 20, UNUM_FOUR_DIGIT_SYMBOL = 21, UNUM_FIVE_DIGIT_SYMBOL = 22, UNUM_SIX_DIGIT_SYMBOL = 23,
    UNUM_SEVEN_DIGIT_SYMBOL = 24, UNUM_EIGHT_DIGIT_SYMBOL = 25, UNUM_NINE_DIGIT_SYMBOL = 26, UNUM_FORMAT_SYMBOL_COUNT = 27
  );

  { C API: DateFormat. Types and Enumerations}
  { http://www.icu-project.org/apiref/icu4c/udat_8h.html }

  PUDateFormat = ^UDateFormat;
  UDateFormat = record end;

  //The possible date/time format styles.
  UDateFormatStyle = (
    UDAT_FULL, UDAT_LONG, UDAT_MEDIUM, UDAT_SHORT, UDAT_DEFAULT = UDAT_MEDIUM, UDAT_RELATIVE = 128,
    UDAT_FULL_RELATIVE = UDAT_FULL + UDAT_RELATIVE, UDAT_LONG_RELATIVE = UDAT_LONG + UDAT_RELATIVE,
    UDAT_MEDIUM_RELATIVE = UDAT_MEDIUM + UDAT_RELATIVE, UDAT_SHORT_RELATIVE = UDAT_SHORT + UDAT_RELATIVE,
    UDAT_NONE = -1, UDAT_PATTERN = -2, UDAT_IGNORE = UDAT_PATTERN
  );

  // FieldPosition and UFieldPosition selectors for format fields defined by DateFormat and UDateFormat.
  UDateFormatField = (
    UDAT_ERA_FIELD = 0, UDAT_YEAR_FIELD = 1, UDAT_MONTH_FIELD = 2, UDAT_DATE_FIELD = 3, UDAT_HOUR_OF_DAY1_FIELD = 4,
    UDAT_HOUR_OF_DAY0_FIELD = 5, UDAT_MINUTE_FIELD = 6, UDAT_SECOND_FIELD = 7, UDAT_FRACTIONAL_SECOND_FIELD = 8,
    UDAT_DAY_OF_WEEK_FIELD = 9, UDAT_DAY_OF_YEAR_FIELD = 10, UDAT_DAY_OF_WEEK_IN_MONTH_FIELD = 11,
    UDAT_WEEK_OF_YEAR_FIELD = 12, UDAT_WEEK_OF_MONTH_FIELD = 13, UDAT_AM_PM_FIELD = 14, UDAT_HOUR1_FIELD = 15,
    UDAT_HOUR0_FIELD = 16, UDAT_TIMEZONE_FIELD = 17, UDAT_YEAR_WOY_FIELD = 18, UDAT_DOW_LOCAL_FIELD = 19,
    UDAT_EXTENDED_YEAR_FIELD = 20, UDAT_JULIAN_DAY_FIELD = 21, UDAT_MILLISECONDS_IN_DAY_FIELD = 22,
    UDAT_TIMEZONE_RFC_FIELD = 23, UDAT_TIMEZONE_GENERIC_FIELD = 24, UDAT_STANDALONE_DAY_FIELD = 25,
    UDAT_STANDALONE_MONTH_FIELD = 26, UDAT_QUARTER_FIELD = 27, UDAT_STANDALONE_QUARTER_FIELD = 28,
    UDAT_TIMEZONE_SPECIAL_FIELD = 29, UDAT_YEAR_NAME_FIELD = 30, UDAT_TIMEZONE_LOCALIZED_GMT_OFFSET_FIELD = 31,
    UDAT_TIMEZONE_ISO_FIELD = 32, UDAT_TIMEZONE_ISO_LOCAL_FIELD = 33, UDAT_FIELD_COUNT = 34
  );

  // The possible types of date format symbols.
  UDateFormatSymbolType = (
    UDAT_ERAS, UDAT_MONTHS, UDAT_SHORT_MONTHS, UDAT_WEEKDAYS, UDAT_SHORT_WEEKDAYS, UDAT_AM_PMS, UDAT_LOCALIZED_CHARS,
    UDAT_ERA_NAMES, UDAT_NARROW_MONTHS, UDAT_NARROW_WEEKDAYS, UDAT_STANDALONE_MONTHS, UDAT_STANDALONE_SHORT_MONTHS,
    UDAT_STANDALONE_NARROW_MONTHS, UDAT_STANDALONE_WEEKDAYS, UDAT_STANDALONE_SHORT_WEEKDAYS,
    UDAT_STANDALONE_NARROW_WEEKDAYS, UDAT_QUARTERS, UDAT_SHORT_QUARTERS, UDAT_STANDALONE_QUARTERS,
    UDAT_STANDALONE_SHORT_QUARTERS, UDAT_SHORTER_WEEKDAYS, UDAT_STANDALONE_SHORTER_WEEKDAYS
  );


  { ucal.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/ucal_8h.html }


  // A calendar. Dummy record.
  PUCalendar = ^UCalendar;
  UCalendar = record end;

  //  Possible types of UCalendars.
  UCalendarType = (UCAL_TRADITIONAL, UCAL_DEFAULT = UCAL_TRADITIONAL, UCAL_GREGORIAN);

  //  Possible fields in a UCalendar.
  UCalendarDateFields = (
    UCAL_ERA, UCAL_YEAR, UCAL_MONTH, UCAL_WEEK_OF_YEAR, UCAL_WEEK_OF_MONTH, UCAL_DATE, UCAL_DAY_OF_YEAR,
    UCAL_DAY_OF_WEEK, UCAL_DAY_OF_WEEK_IN_MONTH, UCAL_AM_PM, UCAL_HOUR, UCAL_HOUR_OF_DAY, UCAL_MINUTE, UCAL_SECOND,
    UCAL_MILLISECOND, UCAL_ZONE_OFFSET, UCAL_DST_OFFSET, UCAL_YEAR_WOY, UCAL_DOW_LOCAL, UCAL_EXTENDED_YEAR,
    UCAL_JULIAN_DAY, UCAL_MILLISECONDS_IN_DAY, UCAL_IS_LEAP_MONTH, UCAL_FIELD_COUNT, UCAL_DAY_OF_MONTH = UCAL_DATE
  );

  //  Useful constant for days of week.
  UCalendarDaysOfWeek = (
    UCAL_SUNDAY = 1, UCAL_MONDAY, UCAL_TUESDAY, UCAL_WEDNESDAY, UCAL_THURSDAY, UCAL_FRIDAY, UCAL_SATURDAY
  );

  //  Possible months in a UCalendar.
  UCalendarMonths = (
    UCAL_JANUARY, UCAL_FEBRUARY, UCAL_MARCH, UCAL_APRIL, UCAL_MAY, UCAL_JUNE, UCAL_JULY, UCAL_AUGUST, UCAL_SEPTEMBER,
    UCAL_OCTOBER, UCAL_NOVEMBER, UCAL_DECEMBER, UCAL_UNDECIMBER
  );

  //  Possible AM/PM values in a UCalendar.
  UCalendarAMPMs = (UCAL_AM, UCAL_PM);

  //  System time zone type constants used by filtering zones in ucal_openTimeZoneIDEnumeration.
  USystemTimeZoneType = (UCAL_ZONE_TYPE_ANY, UCAL_ZONE_TYPE_CANONICAL, UCAL_ZONE_TYPE_CANONICAL_LOCATION);

  //  Possible formats for a UCalendar's display name.
  UCalendarDisplayNameType = (UCAL_STANDARD, UCAL_SHORT_STANDARD, UCAL_DST, UCAL_SHORT_DST);

  //  Types of UCalendar attributes.
  UCalendarAttribute = (
    UCAL_LENIENT, UCAL_FIRST_DAY_OF_WEEK, UCAL_MINIMAL_DAYS_IN_FIRST_WEEK, UCAL_REPEATED_WALL_TIME, UCAL_SKIPPED_WALL_TIME
  );

  //  Options for handling ambiguous wall time at time zone offset transitions.
  UCalendarWallTimeOption = (UCAL_WALLTIME_LAST, UCAL_WALLTIME_FIRST, UCAL_WALLTIME_NEXT_VALID);

  //  Possible limit values for a UCalendar.
  UCalendarLimitType = (
    UCAL_MINIMUM, UCAL_MAXIMUM, UCAL_GREATEST_MINIMUM, UCAL_LEAST_MAXIMUM, UCAL_ACTUAL_MINIMUM, UCAL_ACTUAL_MAXIMUM
  );

  //  Time zone transition types for ucal_getTimeZoneTransitionDate.
  UCalendarWeekdayType = (UCAL_WEEKDAY, UCAL_WEEKEND, UCAL_WEEKEND_ONSET, UCAL_WEEKEND_CEASE);

  //  Weekday types, as returned by ucal_getDayOfWeekType().
  UTimeZoneTransitionType = (
    UCAL_TZ_TRANSITION_NEXT, UCAL_TZ_TRANSITION_NEXT_INCLUSIVE,
    UCAL_TZ_TRANSITION_PREVIOUS, UCAL_TZ_TRANSITION_PREVIOUS_INCLUSIVE
  );


  { C API: String Enumeration. Definition in file uenum.h. }
  { http://www.icu-project.org/apiref/icu4c/uenum_8h.html }

  // structure representing an enumeration object instance
  PUEnumeration = ^UEnumeration;
  UEnumeration = record end;


var
{ Basic definitions for ICU }

  //const char *  u_getDataDirectory (void)
  u_getDataDirectory: function: MarshaledAString; cdecl;

{ http://www.icu-project.org/apiref/icu4c/utypes_8h.html }
  //  Return a string for a UErrorCode value.
  u_errorName: function(code: UErrorCode): MarshaledAString; cdecl;


{ ICU ustring.h File Reference }
{ http://www.icu-project.org/apiref/icu4c/ustring_8h.html }

  //int32_t  u_strlen (const UChar *s)
  //  Determine the length of an array of UChar.

  //int32_t  u_countChar32 (const UChar *s, int32_t length)
  //  Count Unicode code points in the length UChar code units of the string.

  //UBool  u_strHasMoreChar32Than (const UChar *s, int32_t length, int32_t number)
  //  Check if the string contains more Unicode code points than a certain number.

  //UChar *  u_strcat (UChar *dst, const UChar *src)
  //  Concatenate two ustrings.

  //UChar *  u_strncat (UChar *dst, const UChar *src, int32_t n)
  //  Concatenate two ustrings.

  //UChar *  u_strstr (const UChar *s, const UChar *substring)
  //  Find the first occurrence of a substring in a string.

  //UChar *  u_strFindFirst (const UChar *s, int32_t length, const UChar *substring, int32_t subLength)
  //  Find the first occurrence of a substring in a string.

  //UChar *  u_strchr (const UChar *s, UChar c)
  //  Find the first occurrence of a BMP code point in a string.

  //UChar *  u_strchr32 (const UChar *s, UChar32 c)
  //  Find the first occurrence of a code point in a string.

  //UChar *  u_strrstr (const UChar *s, const UChar *substring)
  //  Find the last occurrence of a substring in a string.

  //UChar *  u_strFindLast (const UChar *s, int32_t length, const UChar *substring, int32_t subLength)
  //  Find the last occurrence of a substring in a string.

  //UChar *  u_strrchr (const UChar *s, UChar c)
  //  Find the last occurrence of a BMP code point in a string.

  //UChar *  u_strrchr32 (const UChar *s, UChar32 c)
  //  Find the last occurrence of a code point in a string.

  //UChar *  u_strpbrk (const UChar *string, const UChar *matchSet)
  //  Locates the first occurrence in the string string of any of the characters in the string matchSet.

  //int32_t  u_strcspn (const UChar *string, const UChar *matchSet)
  //  Returns the number of consecutive characters in string, beginning with the first, that do not occur somewhere in matchSet.

  //int32_t  u_strspn (const UChar *string, const UChar *matchSet)
  //  Returns the number of consecutive characters in string, beginning with the first, that occur somewhere in matchSet.

  //UChar *  u_strtok_r (UChar *src, const UChar *delim, UChar **saveState)
  //  The string tokenizer API allows an application to break a string into tokens.

  //  Compare two Unicode strings for bitwise equality (code unit order).
  u_strcmp: function(const s1: PUChar; const s2: PUChar): Int32; cdecl;

  //  Compare two Unicode strings for CodePoint Order equality (code point order).
  u_strcmpCodePointOrder: function(const s1: PUChar; const s2: PUChar): Int32; cdecl;

  //int32_t  u_strCompare (const UChar *s1, int32_t length1, const UChar *s2, int32_t length2, UBool codePointOrder)
  //  Compare two Unicode strings (binary order).

  //int32_t  u_strCompareIter (UCharIterator *iter1, UCharIterator *iter2, UBool codePointOrder)
  //  Compare two Unicode strings (binary order) as presented by UCharIterator objects.

  //  Compare two strings case-insensitively using full case folding.
  u_strCaseCompare: function(const s1:PUChar; length1: Int32; const s2:PUChar; length2: Int32; options: UInt32;
    var ErrorCode: UErrorCode): Int32; cdecl;

  //  Compare two Unicode strings for bitwise equality (code unit order).
  u_strncmp: function(const s1: PUChar; const s2: PUChar; n: Int32): Int32; cdecl;

  //int32_t  u_strncmpCodePointOrder (const UChar *s1, const UChar *s2, int32_t n)
  //  Compare two Unicode strings in code point order.
  u_strncmpCodePointOrder: function(const s1: PUChar; const s2: PUChar; n: Int32): Int32; cdecl;

  //  Compare two strings case-insensitively using full case folding.
  u_strcasecmp: function(const s1:PUChar; const s2:PUChar; options: Int32): Int32; cdecl;

  //  Compare two strings case-insensitively using full case folding.
  u_strncasecmp: function(const s1:PUChar; const s2:PUChar; aLength, options: Int32): Int32; cdecl;

  //  Compare two strings case-insensitively using full case folding.
  u_memcasecmp: function(const s1:PUChar; const s2:PUChar; aLength, options: Int32): Int32; cdecl;

  //  Copy a ustring.
  u_strcpy: function(dst:PUChar; const src: PUChar): PUChar; cdecl;

  //  Copy a ustring.
  u_strncpy: function(dst:PUChar; const src: PUChar; n: Int32): PUChar; cdecl;

  //  Copy a byte string encoded in the default codepage to a ustring.
  u_uastrcpy: function(dst:PUChar; const src: MarshaledAString): PUChar; cdecl;

  //  Copy a byte string encoded in the default codepage to a ustring.
  u_uastrncpy: function(dst:PUChar; const src: MarshaledAString; n: Int32): PUChar; cdecl;

  //  Copy ustring to a byte string encoded in the default codepage.
  u_austrcpy: function(dst:MarshaledAString; const src: PUChar): MarshaledAString; cdecl;

  //  Copy ustring to a byte string encoded in the default codepage.
  u_austrncpy: function(dst:MarshaledAString; const src: PUChar; n: Int32): MarshaledAString; cdecl;

  //UChar *  u_memcpy (UChar *dest, const UChar *src, int32_t count)
  //  Synonym for memcpy(), but with UChars only.

  //UChar *  u_memmove (UChar *dest, const UChar *src, int32_t count)
  //  Synonym for memmove(), but with UChars only.

  //UChar *  u_memset (UChar *dest, UChar c, int32_t count)
  //  Initialize count characters of dest to c.

  //int32_t  u_memcmp (const UChar *buf1, const UChar *buf2, int32_t count)
  //  Compare the first count UChars of each buffer.

  //int32_t  u_memcmpCodePointOrder (const UChar *s1, const UChar *s2, int32_t count)
  //  Compare two Unicode strings in code point order.

  //UChar *  u_memchr (const UChar *s, UChar c, int32_t count)
  //  Find the first occurrence of a BMP code point in a string.

  //UChar *  u_memchr32 (const UChar *s, UChar32 c, int32_t count)
  //  Find the first occurrence of a code point in a string.

  //UChar *  u_memrchr (const UChar *s, UChar c, int32_t count)
  //  Find the last occurrence of a BMP code point in a string.

  //UChar *  u_memrchr32 (const UChar *s, UChar32 c, int32_t count)
  //  Find the last occurrence of a code point in a string.

  //int32_t  u_unescape (const char *src, UChar *dest, int32_t destCapacity)
  //  Unescape a string of characters and write the resulting Unicode characters to the destination buffer.

  //UChar32  u_unescapeAt (UNESCAPE_CHAR_AT charAt, int32_t *offset, int32_t length, void *context)
  //  Unescape a single sequence.

  // Uppercase the characters in a string.
  u_strToUpper: function(dest: PUChar; destCapaciy: Int32; const src: PUChar;
      srcLength: Int32; const locale: MarshaledAString; var ErrorCode:UErrorCode): Int32; cdecl;

  // Lowercase the characters in a string.
  u_strToLower: function(dest: PUChar; destCapaciy: Int32; const src: PUChar;
    srcLength: Int32; const locale: MarshaledAString; var ErrorCode:UErrorCode): Int32; cdecl;

  //int32_t  u_strToTitle (UChar *dest, int32_t destCapacity, const UChar *src, int32_t srcLength, UBreakIterator *titleIter, const char *locale, UErrorCode *pErrorCode)
  //  Titlecase a string.

  //int32_t  u_strFoldCase (UChar *dest, int32_t destCapacity, const UChar *src, int32_t srcLength, uint32_t options, UErrorCode *pErrorCode)
  //  Case-folds the characters in a string.

  //wchar_t *  u_strToWCS (wchar_t *dest, int32_t destCapacity, int32_t *pDestLength, const UChar *src, int32_t srcLength, UErrorCode *pErrorCode)
  //  Convert a UTF-16 string to a wchar_t string.

  //UChar *  u_strFromWCS (UChar *dest, int32_t destCapacity, int32_t *pDestLength, const wchar_t *src, int32_t srcLength, UErrorCode *pErrorCode)
  //  Convert a wchar_t string to UTF-16.

  // Convert a UTF-16 string to UTF-8.
  u_strToUTF8: function(dest: MarshaledAString; destCapacity: Int32; var DestLength: Int32;
    const src: PUChar; srcLength: Int32; var ErrorCode: UErrorCode): MarshaledAString; cdecl;

  //Convert a UTF-8 string to UTF-16.
  u_strFromUTF8: function(dest: PUChar; destCapacity: Int32; var DestLength: Int32;
    const src: MarshaledAString; srcLength: Int32; var ErrorCode: UErrorCode): PUChar; cdecl;

  //char *  u_strToUTF8WithSub (char *dest, int32_t destCapacity, int32_t *pDestLength, const UChar *src, int32_t srcLength, UChar32 subchar, int32_t *pNumSubstitutions, UErrorCode *pErrorCode)
  //  Convert a UTF-16 string to UTF-8.

  //Convert a UTF-8 string to UTF-16 with Sub.
  u_strFromUTF8WithSub: function(dest: PUChar; destCapacity: Int32; var DestLength: Int32;
    const src: MarshaledAString; srcLength: Int32; subchar: UChar32; var NumSubstitutions: Int32;
    var ErrorCode: UErrorCode): PUChar; cdecl;

  //UChar *  u_strFromUTF8Lenient (UChar *dest, int32_t destCapacity, int32_t *pDestLength, const char *src, int32_t srcLength, UErrorCode *pErrorCode)
  //  Convert a UTF-8 string to UTF-16.

  //UChar32 *  u_strToUTF32 (UChar32 *dest, int32_t destCapacity, int32_t *pDestLength, const UChar *src, int32_t srcLength, UErrorCode *pErrorCode)
  //  Convert a UTF-16 string to UTF-32.

  //UChar *  u_strFromUTF32 (UChar *dest, int32_t destCapacity, int32_t *pDestLength, const UChar32 *src, int32_t srcLength, UErrorCode *pErrorCode)
  //  Convert a UTF-32 string to UTF-16.

  //UChar32 *  u_strToUTF32WithSub (UChar32 *dest, int32_t destCapacity, int32_t *pDestLength, const UChar *src, int32_t srcLength, UChar32 subchar, int32_t *pNumSubstitutions, UErrorCode *pErrorCode)
  //  Convert a UTF-16 string to UTF-32.

  //UChar *  u_strFromUTF32WithSub (UChar *dest, int32_t destCapacity, int32_t *pDestLength, const UChar32 *src, int32_t srcLength, UChar32 subchar, int32_t *pNumSubstitutions, UErrorCode *pErrorCode)
  //  Convert a UTF-32 string to UTF-16.

  //char *  u_strToJavaModifiedUTF8 (char *dest, int32_t destCapacity, int32_t *pDestLength, const UChar *src, int32_t srcLength, UErrorCode *pErrorCode)
  //  Convert a 16-bit Unicode string to Java Modified UTF-8.

  //UChar *  u_strFromJavaModifiedUTF8WithSub (UChar *dest, int32_t destCapacity, int32_t *pDestLength, const char *src, int32_t srcLength, UChar32 subchar, int32_t *pNumSubstitutions, UErrorCode *pErrorCode)
  //  Convert a Java Modified UTF-8 string to a 16-bit Unicode string.



  { ICU ucnv.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/ucnv_8h.html }

  //  Do a fuzzy compare of two converter/alias names.
  //  int  ucnv_compareNames (const char *name1, const char *name2)
  ucnv_compareNames: function(const name1, name2: MarshaledAString): Integer; cdecl;

  //  Creates a UConverter object with the name of a coded character set specified as a C string.
  ucnv_open: function(converterName: MarshaledAString; var err: UErrorCode): PUConverter; cdecl;

  //  Creates a Unicode converter with the names specified as unicode string.
  ucnv_openU: function(name: MarshaledAString; var err: UErrorCode): PUConverter; cdecl;

  //  Creates a UConverter object from a CCSID number and platform pair.
  ucnv_openCCSID: function(codePage: Int32; aPlatform: UConverterPlatform; var err: UErrorCode): PUConverter; cdecl;

  // UConverter *  ucnv_openPackage (const char *packageName, const char *converterName, UErrorCode *err)
  //  Creates a UConverter object specified from a packageName and a converterName.
  ucnv_openPackage: function(const packageName, converterName: MarshaledAString; var err: UErrorCode): PUConverter; cdecl;

  //UConverter *  ucnv_safeClone (const UConverter *cnv, void *stackBuffer, int32_t *pBufferSize, UErrorCode *status)
  //  Thread safe converter cloning operation.
  ucnv_safeClone: function(const cnv: PUConverter; stackBuffer: Pointer; pBufferSize: PInt32;
    var status: UErrorCode): PUConverter; cdecl;

  //  Deletes the unicode converter and releases resources associated with just this instance.
  ucnv_close: procedure(converter: PUConverter); cdecl;

  //void  ucnv_getSubstChars (const UConverter *converter, char *subChars, int8_t *len, UErrorCode *err)
  //  Fills in the output parameter, subChars, with the substitution characters as multiple bytes.

  //  Sets the substitution chars when converting from unicode to a codepage.
  ucnv_setSubstChars: procedure(converter: PUConverter; subChars: MarshaledAString;
    len: word; var err: UErrorCode); cdecl;

  //Fills in the output parameter, errBytes, with the error characters from the last failing conversion.
 ucnv_getInvalidChars: function(cnv: PUConverter; errBytes: MarshaledAString;
    var len: ShortInt; var ErrorCode: UErrorCode): Int32; cdecl;

  //Fills in the output parameter, errChars, with the error characters from the last failing conversion.
 ucnv_getInvalidUChars: function(cnv: PUConverter; errUChars: PUChar; var len: ShortInt;
    var ErrorCode: UErrorCode): Int32; cdecl;

  //Resets the state of a converter to the default state.
  ucnv_reset: procedure(converter: PUConverter); cdecl;

  //void  ucnv_resetToUnicode (UConverter *converter)
  //  Resets the to-Unicode part of a converter state to the default state.
  //void  ucnv_resetFromUnicode (UConverter *converter)
  //  Resets the from-Unicode part of a converter state to the default state.

  //  Returns the maximum number of bytes that are output per UChar in conversion
  // from Unicode using this converter.
  ucnv_getMaxCharSize: function (const converter: PUConverter): Int8; cdecl;

  //  Returns the minimum byte length for characters in this codepage.
  ucnv_getMinCharSize: function (const converter: PUConverter): Int8; cdecl;

  //  Returns the display name of the converter passed in based on the Locale passed in.
  ucnv_getDisplayName: function (const converter: PUConverter;  displayLocale: MarshaledAString;
      displayName: PUChar;displayNameCapacity: Int32; var err: UErrorCode ): Int32; cdecl;

  //  Gets the internal, canonical name of the converter (zero-terminated).
  ucnv_getName: function (const converter:PUConverter; var err: UErrorCode ): MarshaledAString; cdecl;

  //  Gets a codepage number associated with the converter.
  ucnv_getCCSID: function (const converter: PUConverter; var err: UErrorCode ): Int32; cdecl;

  //UConverterPlatform  ucnv_getPlatform (const UConverter *converter, UErrorCode *err)
  //  Gets a codepage platform associated with the converter.
  //UConverterType  ucnv_getType (const UConverter *converter)
  //  Gets the type of the converter e.g.
  //void  ucnv_getStarters (const UConverter *converter, UBool starters[256], UErrorCode *err)
  //  Gets the "starter" (lead) bytes for converters of type MBCS.
  //void  ucnv_getUnicodeSet (const UConverter *cnv, USet *setFillIn, UConverterUnicodeSet whichSet, UErrorCode *pErrorCode)
  //  Returns the set of Unicode code points that can be converted by an ICU converter.
  //void  ucnv_getToUCallBack (const UConverter *converter, UConverterToUCallback *action, const void **context)
  //  Gets the current calback function used by the converter when an illegal or invalid codepage sequence is found.
  //void  ucnv_getFromUCallBack (const UConverter *converter, UConverterFromUCallback *action, const void **context)
  //  Gets the current callback function used by the converter when illegal or invalid Unicode sequence is found.

  //Changes the callback function used by the converter when an illegal or invalid sequence is found.
  ucnv_setToUCallBack: procedure(cnv: PUConverter; newAction: UConverterFromUCallback; newContext: Pointer;
    oldAction: UConverterFromUCallback; oldContext: PPointer; var ErrorCode: UErrorCode); cdecl;

  //Changes the current callback function used by the converter when an illegal or invalid sequence is found.
  ucnv_setFromUCallBack: procedure(cnv: PUConverter; newAction: UConverterFromUCallback; newContext: Pointer;
    oldAction: UConverterFromUCallback; oldContext: PPointer; var ErrorCode: UErrorCode); cdecl;

  //void  ucnv_fromUnicode (UConverter *converter, char **target, const char *targetLimit, const UChar **source, const UChar *sourceLimit, int32_t *offsets, UBool flush, UErrorCode *err)
  //  Converts an array of unicode characters to an array of codepage characters.

  //  Converts a buffer of codepage bytes into an array of unicode UChars characters.
  ucnv_toUnicode: procedure(Converter: PUConverter; var Target: PUChar; TargetLimit: PUChar;
    var Source: MarshaledAString; sourceLimit: MarshaledAString; var offsets: Int32;
    flush: UBool; var err: UErrorcode); cdecl;

  //Convert the Unicode string into a codepage string using an existing UConverter.
  ucnv_fromUChars: function(cnv: PUConverter; dest: MarshaledAString; destCapacity: Int32;
    const src: PUChar; srcLength: Int32; var ErrorCode: UErrorCode): Int32; cdecl;

  //Convert the codepage string into a Unicode string using an existing UConverter.
 ucnv_toUChars: function(cnv: PUConverter; dest: PUChar; destCapacity: Int32; const src: MarshaledAString;
    srcLength: Int32; var ErrorCode: UErrorCode): Int32; cdecl;

  //UChar32  ucnv_getNextUChar (UConverter *converter, const char **source, const char *sourceLimit, UErrorCode *err)
  //  Convert a codepage buffer into Unicode one character at a time.
  //void  ucnv_convertEx (UConverter *targetCnv, UConverter *sourceCnv, char **target, const char *targetLimit, const char **source, const char *sourceLimit, UChar *pivotStart, UChar **pivotSource, UChar **pivotTarget, const UChar *pivotLimit, UBool reset, UBool flush, UErrorCode *pErrorCode)
  //  Convert from one external charset to another using two existing UConverters.
  //int32_t  ucnv_convert (const char *toConverterName, const char *fromConverterName, char *target, int32_t targetCapacity, const char *source, int32_t sourceLength, UErrorCode *pErrorCode)
  //  Convert from one external charset to another.
  //int32_t  ucnv_toAlgorithmic (UConverterType algorithmicType, UConverter *cnv, char *target, int32_t targetCapacity, const char *source, int32_t sourceLength, UErrorCode *pErrorCode)
  //  Convert from one external charset to another.
  //int32_t  ucnv_fromAlgorithmic (UConverter *cnv, UConverterType algorithmicType, char *target, int32_t targetCapacity, const char *source, int32_t sourceLength, UErrorCode *pErrorCode)
  //  Convert from one external charset to another.
  //int32_t  ucnv_flushCache (void)
  //  Frees up memory occupied by unused, cached converter shared data.

  //  Returns the number of available converters, as per the alias file.
  ucnv_countAvailable: function: Int32; cdecl;

  //  Gets the canonical converter name of the specified converter from a list
  // of all available converters contaied in the alias file.
  // All converters in this list can be opened.
  ucnv_getAvailableName: function(index: Int32): MarshaledAString; cdecl;

  //UEnumeration *  ucnv_openAllNames (UErrorCode *pErrorCode)
  //  Returns a UEnumeration to enumerate all of the canonical converter names, as per the alias file, regardless of the ability to open each converter.

  //uint16_t  ucnv_countAliases (const char *alias, UErrorCode *pErrorCode)
  //  Gives the number of aliases for a given converter or alias name.
  ucnv_countAliases: function(const alias: MarshaledAString; var ErrorCode: UErrorCode): UInt16; cdecl;

  //const char *  ucnv_getAlias (const char *alias, uint16_t n, UErrorCode *pErrorCode)
  //  Gives the name of the alias at given index of alias list.
  ucnv_getAlias: function(const alias: MarshaledAString; n: UInt16; var ErrorCode: UErrorCode): MarshaledAString; cdecl;

  //void  ucnv_getAliases (const char *alias, const char **aliases, UErrorCode *pErrorCode)
  //  Fill-up the list of alias names for the given alias.
  ucnv_getAliases: procedure(const alias: MarshaledAString; const aliases: PMarshaledAString; var ErrorCode: UErrorCode); cdecl;


  //UEnumeration *  ucnv_openStandardNames (const char *convName, const char *standard, UErrorCode *pErrorCode)
  //  Return a new UEnumeration object for enumerating all the alias names for a given converter that are recognized by a standard.
  //uint16_t  ucnv_countStandards (void)
  //  Gives the number of standards associated to converter names.
  //const char *  ucnv_getStandard (uint16_t n, UErrorCode *pErrorCode)
  //  Gives the name of the standard at given index of standard list.
  //const char *  ucnv_getStandardName (const char *name, const char *standard, UErrorCode *pErrorCode)
  //  Returns a standard name for a given converter name.
  //const char *  ucnv_getCanonicalName (const char *alias, const char *standard, UErrorCode *pErrorCode)
  //  This function will return the internal canonical converter name of the tagged alias.
  //const char *  ucnv_getDefaultName (void)
  //  Returns the current default converter name.
  //void  ucnv_setDefaultName (const char *name)
  //  This function is not thread safe.
  //void  ucnv_fixFileSeparator (const UConverter *cnv, UChar *source, int32_t sourceLen)
  //  Fixes the backslash character mismapping.
  //UBool  ucnv_isAmbiguous (const UConverter *cnv)
  //  Determines if the converter contains ambiguous mappings of the same character or not.
  //void  ucnv_setFallback (UConverter *cnv, UBool usesFallback)
  //  Sets the converter to use fallback mappings or not.
  //UBool  ucnv_usesFallback (const UConverter *cnv)
  //  Determines if the converter uses fallback mappings or not.
  //const char *  ucnv_detectUnicodeSignature (const char *source, int32_t sourceLength, int32_t *signatureLength, UErrorCode *pErrorCode)
  //  Detects Unicode signature byte sequences at the start of the byte stream and returns the charset name of the indicated Unicode charset.
  //int32_t  ucnv_fromUCountPending (const UConverter *cnv, UErrorCode *status)
  //  Returns the number of UChars held in the converter's internal state because more input is needed for completing the conversion.
  //int32_t  ucnv_toUCountPending (const UConverter *cnv, UErrorCode *status)
  //  Returns the number of chars held in the converter's internal state because more input is needed for completing the conversion.
  //UBool  ucnv_isFixedWidth (UConverter *cnv, UErrorCode *status)
  //  Returns whether or not the charset of the converter has a fixed number of bytes per charset character.

  //Fills in the output parameter, errBytes, with the error characters from the last failing conversion.
 ucnv_cbToUWriteUChars: procedure(args: PUConverterToUnicodeArgs; const source: PUChar;
      length: Int32; offsetIndex: Int32; var ErrorCode: UErrorCode); cdecl;


  { ICU uchar.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/uchar_8h.html }

  //  UBool  u_hasBinaryProperty (UChar32 c, UProperty which)
  //  Check a binary Unicode property for a code point.
  //UBool  u_isUAlphabetic (UChar32 c)
  //  Check if a code point has the Alphabetic Unicode property.
  //UBool  u_isULowercase (UChar32 c)
  //  Check if a code point has the Lowercase Unicode property.
  //UBool  u_isUUppercase (UChar32 c)
  //  Check if a code point has the Uppercase Unicode property.
  //UBool  u_isUWhiteSpace (UChar32 c)
  //  Check if a code point has the White_Space Unicode property.
  //int32_t  u_getIntPropertyValue (UChar32 c, UProperty which)
  //  Get the property value for an enumerated or integer Unicode property for a code point.
  //int32_t  u_getIntPropertyMinValue (UProperty which)
  //  Get the minimum value for an enumerated/integer/binary Unicode property.
  //int32_t  u_getIntPropertyMaxValue (UProperty which)
  //  Get the maximum value for an enumerated/integer/binary Unicode property.
  //double  u_getNumericValue (UChar32 c)
  //  Get the numeric value for a Unicode code point as defined in the Unicode Character Database.
  //UBool  u_islower (UChar32 c)
  //  Determines whether the specified code point has the general category "Ll" (lowercase letter).
  //UBool  u_isupper (UChar32 c)
  //  Determines whether the specified code point has the general category "Lu" (uppercase letter).
  //UBool  u_istitle (UChar32 c)
  //  Determines whether the specified code point is a titlecase letter.
  //UBool  u_isdigit (UChar32 c)
  //  Determines whether the specified code point is a digit character according to Java.
  //UBool  u_isalpha (UChar32 c)
  //  Determines whether the specified code point is a letter character.
  //UBool  u_isalnum (UChar32 c)
  //  Determines whether the specified code point is an alphanumeric character (letter or digit) according to Java.
  //UBool  u_isxdigit (UChar32 c)
  //  Determines whether the specified code point is a hexadecimal digit.
  //UBool  u_ispunct (UChar32 c)
  //  Determines whether the specified code point is a punctuation character.
  //UBool  u_isgraph (UChar32 c)
  //  Determines whether the specified code point is a "graphic" character (printable, excluding spaces).
  //UBool  u_isblank (UChar32 c)
  //  Determines whether the specified code point is a "blank" or "horizontal space", a character that visibly separates words on a line.
  //UBool  u_isdefined (UChar32 c)
  //  Determines whether the specified code point is "defined", which usually means that it is assigned a character.
  //UBool  u_isspace (UChar32 c)
  //  Determines if the specified character is a space character or not.
  //UBool  u_isJavaSpaceChar (UChar32 c)
  //  Determine if the specified code point is a space character according to Java.
  //UBool  u_isWhitespace (UChar32 c)
  //  Determines if the specified code point is a whitespace character according to Java/ICU.
  //UBool  u_iscntrl (UChar32 c)
  //  Determines whether the specified code point is a control character (as defined by this function).
  //UBool  u_isISOControl (UChar32 c)
  //  Determines whether the specified code point is an ISO control code.
  //UBool  u_isprint (UChar32 c)
  //  Determines whether the specified code point is a printable character.
  //UBool  u_isbase (UChar32 c)
  //  Determines whether the specified code point is a base character.
  //UCharDirection  u_charDirection (UChar32 c)
  //  Returns the bidirectional category value for the code point, which is used in the Unicode bidirectional algorithm (UAX #9 http://www.unicode.org/reports/tr9/).
  //UBool  u_isMirrored (UChar32 c)
  //  Determines whether the code point has the Bidi_Mirrored property.
  //UChar32  u_charMirror (UChar32 c)
  //  Maps the specified character to a "mirror-image" character.
  //UChar32  u_getBidiPairedBracket (UChar32 c)
  //  Maps the specified character to its paired bracket character.
  //int8_t  u_charType (UChar32 c)
  //  Returns the general category value for the code point.
  //void  u_enumCharTypes (UCharEnumTypeRange *enumRange, const void *context)
  //  Enumerate efficiently all code points with their Unicode general categories.
  //uint8_t  u_getCombiningClass (UChar32 c)
  //  Returns the combining class of the code point as specified in UnicodeData.txt.
  //int32_t  u_charDigitValue (UChar32 c)
  //  Returns the decimal digit value of a decimal digit character.
  //UBlockCode  ublock_getCode (UChar32 c)
  //  Returns the Unicode allocation block that contains the character.
  //int32_t  u_charName (UChar32 code, UCharNameChoice nameChoice, char *buffer, int32_t bufferLength, UErrorCode *pErrorCode)
  //  Retrieve the name of a Unicode character.
  //int32_t  u_getISOComment (UChar32 c, char *dest, int32_t destCapacity, UErrorCode *pErrorCode)
  //  Returns an empty string.
  //UChar32  u_charFromName (UCharNameChoice nameChoice, const char *name, UErrorCode *pErrorCode)
  //  Find a Unicode character by its name and return its code point value.
  //void  u_enumCharNames (UChar32 start, UChar32 limit, UEnumCharNamesFn *fn, void *context, UCharNameChoice nameChoice, UErrorCode *pErrorCode)
  //  Enumerate all assigned Unicode characters between the start and limit code points (start inclusive, limit exclusive) and call a function for each, passing the code point value and the character name.
  //const char *  u_getPropertyName (UProperty property, UPropertyNameChoice nameChoice)
  //  Return the Unicode name for a given property, as given in the Unicode database file PropertyAliases.txt.
  //UProperty  u_getPropertyEnum (const char *alias)
  //  Return the UProperty enum for a given property name, as specified in the Unicode database file PropertyAliases.txt.
  //const char *  u_getPropertyValueName (UProperty property, int32_t value, UPropertyNameChoice nameChoice)
  //  Return the Unicode name for a given property value, as given in the Unicode database file PropertyValueAliases.txt.
  //int32_t  u_getPropertyValueEnum (UProperty property, const char *alias)
  //  Return the property value integer for a given value name, as specified in the Unicode database file PropertyValueAliases.txt.
  //UBool  u_isIDStart (UChar32 c)
  //  Determines if the specified character is permissible as the first character in an identifier according to Unicode (The Unicode Standard, Version 3.0, chapter 5.16 Identifiers).
  //UBool  u_isIDPart (UChar32 c)
  //  Determines if the specified character is permissible in an identifier according to Java.
  //UBool  u_isIDIgnorable (UChar32 c)
  //  Determines if the specified character should be regarded as an ignorable character in an identifier, according to Java.
  //UBool  u_isJavaIDStart (UChar32 c)
  //  Determines if the specified character is permissible as the first character in a Java identifier.
  //UBool  u_isJavaIDPart (UChar32 c)
  //  Determines if the specified character is permissible in a Java identifier.

  //  The given character is mapped to its lowercase equivalent according to UnicodeData.txt;
  // if the character has no lowercase equivalent, the character itself is returned.
  u_tolower: function(c: UChar32): UChar32; cdecl;
  //  The given character is mapped to its uppercase equivalent according to UnicodeData.txt;
  // if the character has no uppercase equivalent, the character itself is returned.
  u_toupper: function(c: UChar32): UChar32; cdecl;

  //UChar32  u_totitle (UChar32 c)
  //  The given character is mapped to its titlecase equivalent according to UnicodeData.txt; if none is defined, the character itself is returned.
  //UChar32  u_foldCase (UChar32 c, uint32_t options)
  //  The given character is mapped to its case folding equivalent according to UnicodeData.txt and CaseFolding.txt; if the character has no case folding equivalent, the character itself is returned.
  //int32_t  u_digit (UChar32 ch, int8_t radix)
  //  Returns the decimal digit value of the code point in the specified radix.
  //UChar32  u_forDigit (int32_t digit, int8_t radix)
  //  Determines the character representation for a specific digit in the specified radix.
  //void  u_charAge (UChar32 c, UVersionInfo versionArray)
  //  Get the "age" of the code point.
  //void  u_getUnicodeVersion (UVersionInfo versionArray)
  //  Gets the Unicode version information.
  //int32_t  u_getFC_NFKC_Closure (UChar32 c, UChar *dest, int32_t destCapacity, UErrorCode *pErrorCode)
  //  Get the FC_NFKC_Closure property string for a character.


  { ICU uloc.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/uloc_8h.html }

  //  Gets ICU's default locale.
  uloc_getDefault: function: MarshaledAString; cdecl;

  //  Sets ICU's default locale.
  uloc_setDefault: procedure(const localeID: MarshaledAString; var status: UErrorCode); cdecl;

  //  Gets the language code for the specified locale.
  uloc_getLanguage: function(const localeID: MarshaledAString; language: MarshaledAString;
      languageCapacity: Int32; var errCode: UErrorCode): Int32; cdecl;

  //  Gets the script code for the specified locale.
  uloc_getScript: function(const localeID: MarshaledAString; script: MarshaledAString;
    scriptCapacity: Int32; var err: UErrorCode): Int32; cdecl;

  //  Gets the country code for the specified locale.
  uloc_getCountry: function(const localeID: MarshaledAString; country: MarshaledAString;
    countryCapacity: Int32; var err: UErrorCode): Int32; cdecl;

  //  Gets the variant code for the specified locale.
  uloc_getVariant: function(const localeID: MarshaledAString; variant: MarshaledAString;
    variantCapacity: Int32; var err: UErrorCode): Int32; cdecl;

  //  Gets the full name for the specified locale.
  uloc_getName: function(const localeID: MarshaledAString; name: MarshaledAString;
    nameCapacity: Int32; var err: UErrorCode): Int32; cdecl;

  //  Gets the full name for the specified locale.
  uloc_canonicalize: function(const localeID: MarshaledAString; name: MarshaledAString;
    nameCapacity: Int32; var err: UErrorCode): Int32; cdecl;

  //  Gets the ISO language code for the specified locale.
  uloc_getISO3Language: function(const localeID: MarshaledAString): MarshaledAString; cdecl;

  //  Gets the ISO country code for the specified locale.
  uloc_getISO3Country: function(const localeID: MarshaledAString): MarshaledAString; cdecl;

  //uint32_t  uloc_getLCID (const char *localeID)
  //  Gets the Win32 LCID value for the specified locale.
  uloc_getLCID: function(const localeID: MarshaledAString): UInt32; cdecl;

  //int32_t  uloc_getDisplayLanguage (const char *locale, const char *displayLocale, UChar *language, int32_t languageCapacity, UErrorCode *status)
  //  Gets the language name suitable for display for the specified locale.
  //int32_t  uloc_getDisplayScript (const char *locale, const char *displayLocale, UChar *script, int32_t scriptCapacity, UErrorCode *status)
  //  Gets the script name suitable for display for the specified locale.
  //int32_t  uloc_getDisplayCountry (const char *locale, const char *displayLocale, UChar *country, int32_t countryCapacity, UErrorCode *status)
  //  Gets the country name suitable for display for the specified locale.
  //int32_t  uloc_getDisplayVariant (const char *locale, const char *displayLocale, UChar *variant, int32_t variantCapacity, UErrorCode *status)
  //  Gets the variant name suitable for display for the specified locale.
  //int32_t  uloc_getDisplayKeyword (const char *keyword, const char *displayLocale, UChar *dest, int32_t destCapacity, UErrorCode *status)
  //  Gets the keyword name suitable for display for the specified locale.
  //int32_t  uloc_getDisplayKeywordValue (const char *locale, const char *keyword, const char *displayLocale, UChar *dest, int32_t destCapacity, UErrorCode *status)
  //  Gets the value of the keyword suitable for display for the specified locale.
  //int32_t  uloc_getDisplayName (const char *localeID, const char *inLocaleID, UChar *result, int32_t maxResultSize, UErrorCode *err)
  //  Gets the full name suitable for display for the specified locale.

  //  Gets the specified locale from a list of all available locales.
  uloc_getAvailable: function(n: Int32): MarshaledAString; cdecl;

  //  Gets the size of the all available locale list.
  uloc_countAvailable: function: Int32; cdecl;

  //const char *const *  uloc_getISOLanguages (void)
  //  Gets a list of all available 2-letter language codes defined in ISO 639, plus additional 3-letter codes determined to be useful for locale generation as defined by Unicode CLDR.
  //const char *const *  uloc_getISOCountries (void)
  //  Gets a list of all available 2-letter country codes defined in ISO 639.
  //int32_t  uloc_getParent (const char *localeID, char *parent, int32_t parentCapacity, UErrorCode *err)
  //  Truncate the locale ID string to get the parent locale ID.

  //int32_t  uloc_getBaseName (const char *localeID, char *name, int32_t nameCapacity, UErrorCode *err)
  //  Gets the full name for the specified locale.
  uloc_getBaseName: function(const localeID: MarshaledAString; name: MarshaledAString;
    nameCapacity: Int32; var err: UErrorCode): Int32; cdecl;

  //UEnumeration *  uloc_openKeywords (const char *localeID, UErrorCode *status)
  //  Gets an enumeration of keywords for the specified locale.
  //int32_t  uloc_getKeywordValue (const char *localeID, const char *keywordName, char *buffer, int32_t bufferCapacity, UErrorCode *status)
  //  Get the value for a keyword.
  //int32_t  uloc_setKeywordValue (const char *keywordName, const char *keywordValue, char *buffer, int32_t bufferCapacity, UErrorCode *status)
  //  Set the value of the specified keyword.
  //ULayoutType  uloc_getCharacterOrientation (const char *localeId, UErrorCode *status)
  //  Get the layout character orientation for the specified locale.
  //ULayoutType  uloc_getLineOrientation (const char *localeId, UErrorCode *status)
  //  Get the layout line orientation for the specified locale.
  //int32_t  uloc_acceptLanguageFromHTTP (char *result, int32_t resultAvailable, UAcceptResult *outResult, const char *httpAcceptLanguage, UEnumeration *availableLocales, UErrorCode *status)
  //  Based on a HTTP header from a web browser and a list of available locales, determine an acceptable locale for the user.

  //int32_t  uloc_acceptLanguage (char *result, int32_t resultAvailable, UAcceptResult *outResult,
  // const char **acceptList, int32_t acceptListCount, UEnumeration *availableLocales, UErrorCode *status)
  //  Based on a list of available locales, determine an acceptable locale for the user.
  uloc_acceptLanguage: function(aResult: MarshaledAString; resultAvailable: Int32; var outResult: UAcceptResult;
    const acceptList: PMarshaledAString; acceptListCount: Int32; availableLocals: PUEnumeration;
    var status: UErrorCode): Int32; cdecl;

  //int32_t  uloc_getLocaleForLCID (uint32_t hostID, char *locale, int32_t localeCapacity, UErrorCode *status)
  //  Gets the ICU locale ID for the specified Win32 LCID value.
  //int32_t  uloc_addLikelySubtags (const char *localeID, char *maximizedLocaleID, int32_t maximizedLocaleIDCapacity, UErrorCode *err)
  //  Add the likely subtags for a provided locale ID, per the algorithm described in the following CLDR technical report:
  //int32_t  uloc_minimizeSubtags (const char *localeID, char *minimizedLocaleID, int32_t minimizedLocaleIDCapacity, UErrorCode *err)
  //  Minimize the subtags for a provided locale ID, per the algorithm described in the following CLDR technical report:
  //int32_t  uloc_forLanguageTag (const char *langtag, char *localeID, int32_t localeIDCapacity, int32_t *parsedLength, UErrorCode *err)
  //  Returns a locale ID for the specified BCP47 language tag string.
  //int32_t  uloc_toLanguageTag (const char *localeID, char *langtag, int32_t langtagCapacity, UBool strict, UErrorCode *err)
  //  Returns a well-formed language tag for this locale ID.
  uloc_toLanguageTag: function(const localeID: MarshaledAString; langtag: MarshaledAString;
    langtagCapacity: Int32; strictCheck: UBool; var err: UErrorCode): Int32; cdecl;


  { ICU ulocdata.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/ulocdata_8h.html }

  //ULocaleData *  ulocdata_open (const char *localeID, UErrorCode *status)
  //  Opens a locale data object for the given locale.
  //void  ulocdata_close (ULocaleData *uld)
  //  Closes a locale data object.
  //void  ulocdata_setNoSubstitute (ULocaleData *uld, UBool setting)
  //  Sets the "no Substitute" attribute of the locale data object.
  //UBool  ulocdata_getNoSubstitute (ULocaleData *uld)
  //  Retrieves the current "no Substitute" value of the locale data object.
  //USet *  ulocdata_getExemplarSet (ULocaleData *uld, USet *fillIn, uint32_t options, ULocaleDataExemplarSetType extype, UErrorCode *status)
  //  Returns the set of exemplar characters for a locale.
  //int32_t  ulocdata_getDelimiter (ULocaleData *uld, ULocaleDataDelimiterType type, UChar *result, int32_t resultLength, UErrorCode *status)
  //  Returns one of the delimiter strings associated with a locale.
  //UMeasurementSystem  ulocdata_getMeasurementSystem (const char *localeID, UErrorCode *status)
  //  Returns the measurement system used in the locale specified by the localeID.
  //void  ulocdata_getPaperSize (const char *localeID, int32_t *height, int32_t *width, UErrorCode *status)
  //  Returns the element gives the normal business letter size, and customary units.
  //void  ulocdata_getCLDRVersion (UVersionInfo versionArray, UErrorCode *status)
  //  Return the current CLDR version used by the library.
  //int32_t  ulocdata_getLocaleDisplayPattern (ULocaleData *uld, UChar *pattern, int32_t patternCapacity, UErrorCode *status)
  //  Returns locale display pattern associated with a locale.
  //int32_t  ulocdata_getLocaleSeparator (ULocaleData *uld, UChar *separator, int32_t separatorCapacity, UErrorCode *status)
  //  Returns locale separator associated with a locale.


  { ICU ucol.h File Reference}
  { http://www.icu-project.org/apiref/icu4c/ucol_8h.html }

  // Open a UCollator for comparing strings.
  ucol_open: function(const loc: MarshaledAString; var status: UErrorCode): PUCollator; cdecl;

  //UCollator *  ucol_openRules (const UChar *rules, int32_t rulesLength, UColAttributeValue normalizationMode, UCollationStrength strength, UParseError *parseError, UErrorCode *status)
  //  Produce an UCollator instance according to the rules supplied.
  //UCollator *  ucol_openFromShortString (const char *definition, UBool forceDefaults, UParseError *parseError, UErrorCode *status)
  //  Open a collator defined by a short form string.
  //int32_t  ucol_getContractions (const UCollator *coll, USet *conts, UErrorCode *status)
  //  Get a set containing the contractions defined by the collator.
  //void  ucol_getContractionsAndExpansions (const UCollator *coll, USet *contractions, USet *expansions, UBool addPrefixes, UErrorCode *status)
  //  Get a set containing the expansions defined by the collator.

  // Close a UCollator.
  ucol_close: procedure(coll: PUCollator); cdecl;

  // Compare two strings.
  ucol_strcoll: function(const coll: PUCollator; const source: PUChar; sourceLength: Int32;
    const target: PUChar; targetLength: Int32): UCollationResult; cdecl;

  //  Compare two strings in UTF-8.
  ucol_strcollUTF8: function(const coll: PUCollator; const source: PUChar; sourceLength: Int32;
    const target: PUChar; targetLength: Int32; var status: UErrorCode): UCollationResult; cdecl;

  //UBool  ucol_greater (const UCollator *coll, const UChar *source, int32_t sourceLength, const UChar *target, int32_t targetLength)
  //  Determine if one string is greater than another.
  //UBool  ucol_greaterOrEqual (const UCollator *coll, const UChar *source, int32_t sourceLength, const UChar *target, int32_t targetLength)
  //  Determine if one string is greater than or equal to another.
  //UBool  ucol_equal (const UCollator *coll, const UChar *source, int32_t sourceLength, const UChar *target, int32_t targetLength)
  //  Compare two strings for equality.
  //UCollationResult  ucol_strcollIter (const UCollator *coll, UCharIterator *sIter, UCharIterator *tIter, UErrorCode *status)
  //  Compare two UTF-8 encoded trings.

  //  Get the collation strength used in a UCollator.
  ucol_getStrength: function(const coll: PUCollator): UCollationStrength; cdecl;

  //  Set the collation strength used in a UCollator.
  ucol_setStrength: procedure(const coll: PUCollator; strength: UCollationStrength); cdecl;

  //int32_t  ucol_getReorderCodes (const UCollator *coll, int32_t *dest, int32_t destCapacity, UErrorCode *pErrorCode)
  //  Retrieves the reordering codes for this collator.
  ucol_getReorderCodes: function(const coll: PUCollator; dest: PInt32; destCapacity: Int32;
    var ErrorCode: UErrorCode): Int32; cdecl;

  //void  ucol_setReorderCodes (UCollator *coll, const int32_t *reorderCodes, int32_t reorderCodesLength, UErrorCode *pErrorCode)
  //  Sets the reordering codes for this collator.
  ucol_setReorderCodes: procedure(const coll: PUCollator; const reorderCodes: PInt32;
    reorderCodesLength: Int32; var ErrorCode: UErrorCode); cdecl;

  //int32_t  ucol_getEquivalentReorderCodes (int32_t reorderCode, int32_t *dest, int32_t destCapacity, UErrorCode *pErrorCode)
  //  Retrieves the reorder codes that are grouped with the given reorder code.
  ucol_getEquivalentReorderCodes: function(reorderCode: Int32; const dest: PInt32;
    destCapacity: Int32; var ErrorCode: UErrorCode): Int32; cdecl;

  //int32_t  ucol_getDisplayName (const char *objLoc, const char *dispLoc, UChar *result, int32_t resultLength, UErrorCode *status)
  //  Get the display name for a UCollator.
  ucol_getDisplayName: function(const objLoc, dispLoc: MarshaledAString; aResult:PUChar; resultLength: Int32; var status: UErrorCode): Int32; cdecl;

  //  Get a locale for which collation rules are available.
  ucol_getAvailable: function(localeIndex: Int32): MarshaledAString; cdecl;

  //  Determine how many locales have collation rules available.
  ucol_countAvailable: function: Int32; cdecl;

  //UEnumeration *  ucol_openAvailableLocales (UErrorCode *status)
  //  Create a string enumerator of all locales for which a valid collator may be opened.
  //UEnumeration *  ucol_getKeywords (UErrorCode *status)
  //  Create a string enumerator of all possible keywords that are relevant to collation.
  //UEnumeration *  ucol_getKeywordValues (const char *keyword, UErrorCode *status)
  //  Given a keyword, create a string enumeration of all values for that keyword that are currently in use.
  //UEnumeration *  ucol_getKeywordValuesForLocale (const char *key, const char *locale, UBool commonlyUsed, UErrorCode *status)
  //  Given a key and a locale, returns an array of string values in a preferred order that would make a difference.
  //int32_t  ucol_getFunctionalEquivalent (char *result, int32_t resultCapacity, const char *keyword, const char *locale, UBool *isAvailable, UErrorCode *status)
  //  Return the functionally equivalent locale for the given requested locale, with respect to given keyword, for the collation service.

  //const UChar *  ucol_getRules (const UCollator *coll, int32_t *length)
  //  Get the collation tailoring rules from a UCollator.
  ucol_getRules: function(const coll: PUCollator; var length: Int32): PUChar; cdecl;

  //int32_t  ucol_getShortDefinitionString (const UCollator *coll, const char *locale, char *buffer, int32_t capacity, UErrorCode *status)
  //  Get the short definition string for a collator.
  //int32_t  ucol_normalizeShortDefinitionString (const char *source, char *destination, int32_t capacity, UParseError *parseError, UErrorCode *status)
  //  Verifies and normalizes short definition string.
  //int32_t  ucol_getSortKey (const UCollator *coll, const UChar *source, int32_t sourceLength, uint8_t *result, int32_t resultLength)
  //  Get a sort key for a string from a UCollator.
  //int32_t  ucol_nextSortKeyPart (const UCollator *coll, UCharIterator *iter, uint32_t state[2], uint8_t *dest, int32_t count, UErrorCode *status)
  //  Gets the next count bytes of a sort key.
  //int32_t  ucol_getBound (const uint8_t *source, int32_t sourceLength, UColBoundMode boundType, uint32_t noOfLevels, uint8_t *result, int32_t resultLength, UErrorCode *status)
  //  Produce a bound for a given sortkey and a number of levels.
  //void  ucol_getVersion (const UCollator *coll, UVersionInfo info)
  //  Gets the version information for a Collator.
  //void  ucol_getUCAVersion (const UCollator *coll, UVersionInfo info)
  //  Gets the UCA version information for a Collator.
  //int32_t  ucol_mergeSortkeys (const uint8_t *src1, int32_t src1Length, const uint8_t *src2, int32_t src2Length, uint8_t *dest, int32_t destCapacity)
  //  Merges two sort keys.

  //  Universal attribute setter.
  ucol_setAttribute: procedure(const coll: PUCollator; attr: UColAttribute;
    value: UColAttributeValue; var status: UErrorCode); cdecl;

  //  Universal attribute getter.
  ucol_getAttribute: function(const coll: PUCollator; attr: UColAttribute;
    var status: UErrorCode): UColAttributeValue; cdecl;

  //uint32_t  ucol_setVariableTop (UCollator *coll, const UChar *varTop, int32_t len, UErrorCode *status)
  //  Variable top is a two byte primary value which causes all the codepoints with primary values that are less or equal than the variable top to be shifted when alternate handling is set to UCOL_SHIFTED.
  //uint32_t  ucol_getVariableTop (const UCollator *coll, UErrorCode *status)
  //  Gets the variable top value of a Collator.
  //void  ucol_restoreVariableTop (UCollator *coll, const uint32_t varTop, UErrorCode *status)
  //  Sets the variable top to a collation element value supplied.

  // Thread safe cloning operation.
  ucol_safeClone: function(const coll: PUCollator; stackBuffer: Pointer;
    pBufferSize: PInt32; var status: UErrorCode): PUCollator; cdecl;

  //int32_t  ucol_getRulesEx (const UCollator *coll, UColRuleOption delta, UChar *buffer, int32_t bufferLen)
  //  Returns current rules.

  //  gets the locale name of the collator.
  ucol_getLocale: function(const coll: PUCollator; aType: ULocDataLocaleType;
    var status: UErrorCode): MarshaledAString; cdecl;

  //  gets the locale name of the collator.
  ucol_getLocaleByType: function(const coll: PUCollator; aType: ULocDataLocaleType;
    var status: UErrorCode): MarshaledAString; cdecl;

  //USet *  ucol_getTailoredSet (const UCollator *coll, UErrorCode *status)
  //  Get an Unicode set that contains all the characters and sequences tailored in this collator.
  //UColAttributeValue  ucol_getAttributeOrDefault (const UCollator *coll, UColAttribute attr, UErrorCode *status)
  //  Universal attribute getter that returns UCOL_DEFAULT if the value is default.
  //UBool  ucol_equals (const UCollator *source, const UCollator *target)
  //  Check whether two collators are equal.
  //int32_t  ucol_getUnsafeSet (const UCollator *coll, USet *unsafe, UErrorCode *status)
  //  Calculates the set of unsafe code points, given a collator.
  //void  ucol_forgetUCA (void)
  //  Reset UCA's static pointers.
  //void  ucol_prepareShortStringOpen (const char *definition, UBool forceDefaults, UParseError *parseError, UErrorCode *status)
  //  Touches all resources needed for instantiating a collator from a short string definition, thus filling up the cache.

  //Creates a binary image of a collator.
  ucol_cloneBinary: function(const coll: PUCollator; buffer: PByte; capacity: Int32;
    var status: UErrorCode): Int32; cdecl;

  // Opens a collator from a collator binary image created using ucol_cloneBinary.
  ucol_openBinary: function(const bin: PByte; length: UInt32; const base: PUCollator;
    var status: UErrorCode): PUCollator; cdecl;


  { C API: String Enumeration. Definition in file uenum.h. }
  { http://www.icu-project.org/apiref/icu4c/uenum_8h.html }

  //  Disposes of resources in use by the iterator.
  uenum_close: procedure(en: PUEnumeration); cdecl;

  //  Returns the number of elements that the iterator traverses.
  uenum_count: function(en: PUEnumeration; var status: UErrorCode): Int32; cdecl;

  //  Returns the next element in the iterator's list.
  uenum_unext: function(en: PUEnumeration; var resultLength: Int32; var status: UErrorCode): PUChar; cdecl;

  //  Returns the next element in the iterator's list.
  uenum_next: function(en: PUEnumeration; var resultLength: Int32; var status: UErrorCode): MarshaledAString; cdecl;

  //  Resets the iterator to the current list of service IDs.
  uenum_reset: procedure(en: PUEnumeration; var status: UErrorCode); cdecl;

  //  Given an array of const UChar* strings, return a UEnumeration.
  uenum_openUCharStringsEnumeration: function(const strings: PPUChar; count: Int32; var ec: UErrorCode):PUEnumeration; cdecl;

  //  Given an array of const char* strings (invariant chars only), return a UEnumeration.
  uenum_openCharStringsEnumeration: function(const strings: PMarshaledAString; count: Int32; var ec: UErrorCode): PUEnumeration; cdecl;


  { C API: DateFormat. }
  { http://www.icu-project.org/apiref/icu4c/udat_8h.html }

  //  Maps from a UDateFormatField to the corresponding UCalendarDateFields.
  udat_toCalendarDateField: function(field: UDateFormatField): UCalendarDateFields; cdecl;

  //  Open a new UDateFormat for formatting and parsing dates and times.
  udat_open: function(timeStyle: UDateFormatStyle; dateStyle: UDateFormatStyle;
    const locale: MarshaledAString; const tzID: PUChar; tzIDLenght: Int32;
    const pattern: PUChar; patternLenght: Int32; var status: UErrorCode): PUDateFormat; cdecl;

  //  Close a UDateFormat.
  udat_close: procedure(format: PUDateFormat); cdecl;

  //  Open a copy of a UDateFormat.
  udat_clone: function(const fmt: PUDateFormat; var status: UErrorCode): PUDateFormat; cdecl;

  //  Format a date using an UDateFormat.
  udat_format: function(const format: PUDateFormat; dateToFormat: UDate;
    aResult: PUChar; aResultLength: Int32; position: PUFieldPosition; var status: UErrorCode): Int32; cdecl;

  //  Parse a string into an date/time using a UDateFormat.
  udat_parse: function(const format: PUDateFormat; const text: PUChar; textLength: Int32;
    var parsePos: Int32; var status: UErrorCode): UDate; cdecl;

  //  Parse a string into an date/time using a UDateFormat.
  udat_parseCalendar:procedure(const format: PUDateFormat; calendar: PUCalendar;
    const text: PUChar; textLength: Int32; var parsePos: Int32; var status: UErrorCode); cdecl;

  //  Determine if an UDateFormat will perform lenient parsing.
  udat_isLenient: function(const fmt: PUDateFormat): UBool; cdecl;

  //  Specify whether an UDateFormat will perform lenient parsing.
  udat_setLenient: procedure(fmt: PUDateFormat; isLenient: UBool); cdecl;

  //  Get the UCalendar associated with an UDateFormat.
  udat_getCalendar: function(const fmt: PUDateFormat): PUCalendar; cdecl;

  //void  udat_setCalendar (UDateFormat *fmt, const UCalendar *calendarToSet)
  //  Set the UCalendar associated with an UDateFormat.
  udat_setCalendar: procedure(fmt: PUDateFormat; const calendarToSet: PUCalendar); cdecl;

  //  Get the UNumberFormat associated with an UDateFormat.
  udat_getNumberFormat: function(const fmt: PUDateFormat): PUNumberFormat; cdecl;

  //  Set the UNumberFormat associated with an UDateFormat.
  udat_setNumberFormat: procedure(fmt: PUDateFormat; const numberFormatToSet: PUNumberFormat); cdecl;

  //  Get a locale for which date/time formatting patterns are available.
  udat_getAvailable: function(localeIndex: Int32): MarshaledAString; cdecl;

  //  Determine how many locales have date/time formatting patterns available.
  udat_countAvailable: function: Int32; cdecl;

  //  Get the year relative to which all 2-digit years are interpreted.
  udat_get2DigitYearStart: function(const fmt: PUDateFormat; var status: UErrorCode): UDate; cdecl;

  //  Set the year relative to which all 2-digit years will be interpreted.
  udat_set2DigitYearStart: procedure(fmt: PUDateFormat; d: UDate; var status: UErrorCode); cdecl;

  //  Extract the pattern from a UDateFormat.
  udat_toPattern: function(const fmt: PUDateFormat; localized: UBool; aResult: PUChar;
    aResultLength: Int32; var status: UErrorCode): Int32; cdecl;

  //  Set the pattern used by an UDateFormat.
  udat_applyPattern: procedure (const format: PUDateFormat; localized: UBool;
    pattern: PUChar; patternLength: Int32); cdecl;

  //  Get the symbols associated with an UDateFormat.
  udat_getSymbols: function(const fmt: PUDateFormat; aType: UDateFormatSymbolType;
    symbolIndex: Int32; aResult: PUChar; aResultLen: Int32; var status: UErrorCode): Int32; cdecl;

  //  Count the number of particular symbols for an UDateFormat.
  udat_countSymbols: function(const fmt: PUDateFormat; aType: UDateFormatSymbolType): Int32;

  //void  udat_setSymbols (UDateFormat *format, UDateFormatSymbolType type, int32_t symbolIndex, UChar *value, int32_t valueLength, UErrorCode *status)
  //  Set the symbols associated with an UDateFormat.

  //const char *  udat_getLocaleByType (const UDateFormat *fmt, ULocDataLocaleType type, UErrorCode *status)
  //  Get the locale for this date format object.

  //void  udat_setContext (UDateFormat *fmt, UDisplayContext value, UErrorCode *status)
  //  Set a particular UDisplayContext value in the formatter, such as UDISPCTX_CAPITALIZATION_FOR_STANDALONE.

  //UDisplayContext  udat_getContext (UDateFormat *fmt, UDisplayContextType type, UErrorCode *status)
  //  Get the formatter's UDisplayContext value for the specified UDisplayContextType, such as UDISPCTX_TYPE_CAPITALIZATION.

  //  Extract the date pattern from a UDateFormat set for relative date formatting.
  udat_toPatternRelativeDate: function(const fmt: PUDateFormat; aResult: PUChar;
    aResultLen: Int32; var status: UErrorCode): Int32; cdecl;

  //  Extract the time pattern from a UDateFormat set for relative date formatting.
  udat_toPatternRelativeTime: function(const fmt: PUDateFormat; aResult: PUChar;
    aResultLen: Int32; var status: UErrorCode): Int32; cdecl;

  //void  udat_applyPatternRelative (UDateFormat *format, const UChar *datePattern, int32_t datePatternLength, const UChar *timePattern, int32_t timePatternLength, UErrorCode *status)
  //  Set the date & time patterns used by a UDateFormat set for relative date formatting.

  //void  udat_registerOpener (UDateFormatOpener opener, UErrorCode *status)
  //  Register a provider factory.

  //UDateFormatOpener  udat_unregisterOpener (UDateFormatOpener opener, UErrorCode *status)
  //  Un-Register a provider factory.


  { C API: NumberFormat. }
  { http://www.icu-project.org/apiref/icu4c/unum_8h.html }

  //  Create and return a new UNumberFormat for formatting and parsing numbers.
  unum_open: function(style: UNumberFormatStyle; const pattern: PUChar; patternLength: Int32;
    const locale: MarshaledAString; parseErr: PUParseError; var status: UErrorCode): PUNumberFormat; cdecl;

  //  Close a UNumberFormat.
  unum_close: procedure(fmt: PUNumberFormat); cdecl;

  //  Open a copy of a UNumberFormat.
  unum_clone: function(const fmt: PUNumberFormat; var status: UErrorCode): PUNumberFormat; cdecl;

  //  Format an integer using a UNumberFormat.
  unum_format: function(const fmt: PUNumberFormat; number: Int32; aResult: PUChar; aResultLength: Int32;
    pos: PUFieldPosition; var status: UErrorCode): Int32; cdecl;

  //  Format an int64 using a UNumberFormat.
  unum_formatInt64: function(const fmt: PUNumberFormat; number: Int64; aResult: PUChar; aResultLength: Int32;
    pos: PUFieldPosition; var status: UErrorCode): Int32; cdecl;

  //  Format a double using a UNumberFormat.
  unum_formatDouble: function(const fmt: PUNumberFormat; number: Double; aResult: PUChar; aResultLength: Int32;
    pos: PUFieldPosition; var status: UErrorCode): Int32; cdecl;

  //  Format a decimal number using a UNumberFormat.
  unum_formatDecimal: function(const fmt: PUNumberFormat; const number: MarshaledAString; numberLength: Int32;
    aResult: PUChar; aResultLength: Int32; pos: PUFieldPosition; var status: UErrorCode): Int32; cdecl;

  //  Format a double currency amount using a UNumberFormat.
  unum_formatDoubleCurrency: function(const fmt: PUNumberFormat; number: Double; currency: PUChar;
    aResult: PUChar; aResultLength: Int32; pos: PUFieldPosition; var status: UErrorCode): Int32; cdecl;

  //  Parse a string into an integer using a UNumberFormat.
  unum_parse: function(const fmt: PUNumberFormat; const text: PUChar; textLength: Int32;
    parsePos: PInt32; var status: UErrorCode): Int32; cdecl;

  //  Parse a string into an int64 using a UNumberFormat.
  unum_parseInt64: function(const fmt: PUNumberFormat; const text: PUChar; textLength: Int32;
    parsePos: PInt32; var status: UErrorCode): Int64; cdecl;

  //  Parse a string into a double using a UNumberFormat.
  unum_parseDouble: function(const fmt: PUNumberFormat; const text: PUChar; textLength: Int32;
    parsePos: PInt32; var status: UErrorCode): Double; cdecl;

  //  Parse a number from a string into an unformatted numeric string using a UNumberFormat.
  unum_parseDecimal: function(const fmt: PUNumberFormat; const text: PUChar; textLength: Int32;
    parsePos: PInt32; outBuf: PUChar; outBufLength: Int32; var status: UErrorCode): Int32; cdecl;

  //  Parse a string into a double and a currency using a UNumberFormat.
  unum_parseDoubleCurrency: function(const fmt: PUNumberFormat; const text: PUChar; textLength: Int32;
    parsePos: PInt32; currency: PUChar; var status: UErrorCode): Double; cdecl;

  //  Set the pattern used by a UNumberFormat.
  unum_applyPattern: procedure(format: PUNumberFormat; localized: UBool; const pattern: PUChar;
    patternLength: Int32; parseError: PUParseError; var status: UErrorCode); cdecl;

  //  Get a locale for which decimal formatting patterns are available.
  unum_getAvailable: function(localeIndex: Int32): MarshaledAString; cdecl;

  //  Determine how many locales have decimal formatting patterns available.
  unum_countAvailable: function: Int32; cdecl;

  //  Get a numeric attribute associated with a UNumberFormat.
  unum_getAttribute: function(const fmt: PUNumberFormat; attr: UNumberFormatAttribute): Int32; cdecl;

  //void  unum_setAttribute (UNumberFormat *fmt, UNumberFormatAttribute attr, int32_t newValue)
  //  Set a numeric attribute associated with a UNumberFormat.
  unum_setAttribute: procedure(const fmt: PUNumberFormat; attr: UNumberFormatAttribute; newValue: Int32); cdecl;

  //double  unum_getDoubleAttribute (const UNumberFormat *fmt, UNumberFormatAttribute attr)
  //  Get a numeric attribute associated with a UNumberFormat.
  unum_getDoubleAttribute: function(const fmt: PUNumberFormat; attr: UNumberFormatAttribute): Double; cdecl;

  //void  unum_setDoubleAttribute (UNumberFormat *fmt, UNumberFormatAttribute attr, double newValue)
  //  Set a numeric attribute associated with a UNumberFormat.
  unum_setDoubleAttribute: procedure(const fmt: PUNumberFormat; attr: UNumberFormatAttribute; newValue: Double); cdecl;

  //  Get a text attribute associated with a UNumberFormat.
  unum_getTextAttribute: function(const fmt: PUNumberFormat; tag: UNumberFormatTextAttribute;
    aResult: PUChar; aResultLength: Int32; var status: UErrorCode): Int32; cdecl;

  //void  unum_setTextAttribute (UNumberFormat *fmt, UNumberFormatTextAttribute tag, const UChar *newValue, int32_t newValueLength, UErrorCode *status)
  //  Set a text attribute associated with a UNumberFormat.
  unum_setTextAttribute: procedure(const fmt: PUNumberFormat; tag: UNumberFormatTextAttribute;
    const newValue: PUChar; newValueLength: Int32; var status: UErrorCode); cdecl;

  //int32_t  unum_toPattern (const UNumberFormat *fmt, UBool isPatternLocalized, UChar *result, int32_t resultLength, UErrorCode *status)
  //  Extract the pattern from a UNumberFormat.
  unum_toPattern: function(const fmt: PUNumberFormat; isPatternLocalized: UBool;
    aResult: PUChar; aResultLength: Int32; var status: UErrorCode): Int32; cdecl;

  //int32_t  unum_getSymbol (const UNumberFormat *fmt, UNumberFormatSymbol symbol, UChar *buffer, int32_t size, UErrorCode *status)
  //  Get a symbol associated with a UNumberFormat.
  unum_getSymbol: function(const fmt: PUNumberFormat; symbol: UNumberFormatSymbol;
    buffer: PUChar; bufferLength: Int32; var status: UErrorCode): Int32; cdecl;

  //void  unum_setSymbol (UNumberFormat *fmt, UNumberFormatSymbol symbol, const UChar *value, int32_t length, UErrorCode *status)
  //  Set a symbol associated with a UNumberFormat.
  unum_setSymbol: procedure(const fmt: PUNumberFormat; symbol: UNumberFormatSymbol;
    const value: PUChar; length: Int32; var status: UErrorCode); cdecl;

  //const char *  unum_getLocaleByType (const UNumberFormat *fmt, ULocDataLocaleType type, UErrorCode *status)
  //  Get the locale for this number format object.
  unum_getLocaleByType: function(const fmt: PUNumberFormat; aType: ULocDataLocaleType;
    var status: UErrorCode): MarshaledAString; cdecl;


  { ucal.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/ucal_8h.html }

  //  Create an enumeration over system time zone IDs with the given filter conditions.
  ucal_openTimeZoneIDEnumeration: function(zoneType: USystemTimeZoneType; const region: MarshaledAString;
    const rawOffset: PInt32; var ec: UErrorCode): PUEnumeration; cdecl;

  //  Create an enumeration over all time zones.
  ucal_openTimeZones: function(var ec: UErrorCode): PUEnumeration; cdecl;

  //  Create an enumeration over all time zones associated with the given country.
  ucal_openCountryTimeZones: function(const country: MarshaledAString; var ec: UErrorCode): PUEnumeration; cdecl;

  //  Return the default time zone.
  ucal_getDefaultTimeZone: function(aResult: PUChar; aResultCapacity: Int32; var ec: UErrorCode): Int32; cdecl;

  //  Set the default time zone.
  ucal_setDefaultTimeZone: procedure(const zoneID: PUChar; var ec: UErrorCode); cdecl;

  //  Return the amount of time in milliseconds that the clock is advanced during
  // daylight savings time for the given time zone, or zero if the time zone does not observe daylight savings time.
  ucal_getDSTSavings: function(const zoneID: PUChar; var ec: UErrorCode): Int32; cdecl;

  //  Get the current date and time.
  ucal_getNow: function: UDate; cdecl;

  //  Open a UCalendar.
  ucal_open: function(const zoneID: PUChar; len: Int32; const locale: MarshaledAString;
    aType: UCalendarType; var status: UErrorCode): PUCalendar; cdecl;

  //  Close a UCalendar.
  ucal_close: procedure(car: PUCalendar); cdecl;

  //  Open a copy of a UCalendar.
  ucal_clone: function(car: PUCalendar; var status: UErrorCode): PUCalendar; cdecl;

  //  Set the TimeZone used by a UCalendar.
  ucal_setTimeZone: procedure(cal: PUCalendar; const zoneID: PUChar; len: Int32; var status: UErrorCode); cdecl;

  //  Get the ID of the UCalendar's time zone.
  ucal_getTimeZoneID: function(const cal: PUCalendar; aResult: PUChar; aResultLength: Int32;
    var status: UErrorCode): Int32; cdecl;

  //  Get the display name for a UCalendar's TimeZone.
  ucal_getTimeZoneDisplayName: function(const cal: PUCalendar; aType: UCalendarDisplayNameType;
    const locale: MarshaledAString; aResult: PUChar; aResultLength: Int32; var status: UErrorCode): Int32; cdecl;

  //  Determine if a UCalendar is currently in daylight savings time.
  ucal_inDaylightTime: function(cal: PUCalendar; var status: UErrorCode): UBool; cdecl;

  //  Sets the GregorianCalendar change date.
  ucal_setGregorianChange: procedure(cal: PUCalendar; aDate: UDate; var status: UErrorCode); cdecl;

  //  Gets the Gregorian Calendar change date.
  ucal_getGregorianChange: function(cal: PUCalendar; var status: UErrorCode): UBool; cdecl;

  //  Get a numeric attribute associated with a UCalendar.
  ucal_getAttribute: function(cal: PUCalendar; attr: UCalendarAttribute): Int32; cdecl;

  //  Set a numeric attribute associated with a UCalendar.
  ucal_setAttribute: procedure(cal: PUCalendar; attr: UCalendarAttribute; newValue: Int32); cdecl;

  //  Get a locale for which calendars are available.
  ucal_getAvailable: function(localeIndex: Int32): MarshaledAString; cdecl;

  //  Determine how many locales have calendars available.
  ucal_countAvailable: function: Int32; cdecl;

  //  Get a UCalendar's current time in millis.
  ucal_getMillis: function(const cal: PUCalendar; var status: UErrorCode): UDate; cdecl;

  //  Set a UCalendar's current time in millis.
  ucal_setMillis: function(cal: PUCalendar; dateTime: UDate; var status: UErrorCode): UDate; cdecl;

  //  Set a UCalendar's current date.
  ucal_setDate: procedure(cal: PUCalendar; year, month, date: Int32; var status: UErrorCode); cdecl;

  //  Set a UCalendar's current date.
  ucal_setDateTime: procedure(cal: PUCalendar; year, month, date, hour, minute, second: Int32;
    var status: UErrorCode); cdecl;

  //UBool  ucal_equivalentTo (const UCalendar *cal1, const UCalendar *cal2)
  //  Returns TRUE if two UCalendars are equivalent.

  //void  ucal_add (UCalendar *cal, UCalendarDateFields field, int32_t amount, UErrorCode *status)
  //  Add a specified signed amount to a particular field in a UCalendar.

  //void  ucal_roll (UCalendar *cal, UCalendarDateFields field, int32_t amount, UErrorCode *status)
  //  Add a specified signed amount to a particular field in a UCalendar.

  //int32_t  ucal_get (const UCalendar *cal, UCalendarDateFields field, UErrorCode *status)
  //  Get the current value of a field from a UCalendar.
  ucal_get: function(const cal: PUCalendar; field: UCalendarDateFields; var status: UErrorCode): Int32; cdecl;

  //void  ucal_set (UCalendar *cal, UCalendarDateFields field, int32_t value)
  //  Set the value of a field in a UCalendar.
  ucal_set: procedure(cal: PUCalendar; field: UCalendarDateFields; value: Int32); cdecl;

  //UBool  ucal_isSet (const UCalendar *cal, UCalendarDateFields field)
  //  Determine if a field in a UCalendar is set.
  ucal_isSet: function(cal: PUCalendar; field: UCalendarDateFields): Boolean; cdecl;

  //void  ucal_clearField (UCalendar *cal, UCalendarDateFields field)
  //  Clear a field in a UCalendar.
  ucal_clearField: procedure(cal: PUCalendar; field: UCalendarDateFields); cdecl;

  //void  ucal_clear (UCalendar *calendar)
  //  Clear all fields in a UCalendar.
  ucal_clear: procedure(cal: PUCalendar); cdecl;

  //int32_t  ucal_getLimit (const UCalendar *cal, UCalendarDateFields field, UCalendarLimitType type, UErrorCode *status)
  //  Determine a limit for a field in a UCalendar.
  ucal_getLimit: function(const cal: PUCalendar; field: UCalendarDateFields; aType: UCalendarLimitType;
    var status: UErrorCode): Int32; cdecl;

  //const char *  ucal_getLocaleByType (const UCalendar *cal, ULocDataLocaleType type, UErrorCode *status)
  //  Get the locale for this calendar object.
  ucal_getLocaleByType: function(const cal: PUCalendar; aType: ULocDataLocaleType; var status: UErrorCode): Int32; cdecl;

  //const char *  ucal_getTZDataVersion (UErrorCode *status)
  //  Returns the timezone data version currently used by ICU.
  ucal_getTZDataVersion: function(var status: UErrorCode): MarshaledAString; cdecl;

  //int32_t  ucal_getCanonicalTimeZoneID (const UChar *id, int32_t len, UChar *result, int32_t resultCapacity, UBool *isSystemID, UErrorCode *status)
  //  Returns the canonical system timezone ID or the normalized custom time zone ID for the given time zone ID.
  ucal_getCanonicalTimeZoneID: function(const id: PUChar; len: Int32; result: PUChar;
    resultCapacity: Int32; var isSystemID: UBool; var status: UErrorCode): Int32; cdecl;

  //const char *  ucal_getType (const UCalendar *cal, UErrorCode *status)
  //  Get the resource keyword value string designating the calendar type for the UCalendar.

  //UEnumeration *  ucal_getKeywordValuesForLocale (const char *key, const char *locale, UBool commonlyUsed, UErrorCode *status)
  //  Given a key and a locale, returns an array of string values in a preferred order that would make a difference.

  //UCalendarWeekdayType  ucal_getDayOfWeekType (const UCalendar *cal, UCalendarDaysOfWeek dayOfWeek, UErrorCode *status)
  //  Returns whether the given day of the week is a weekday, a weekend day, or a day
  // that transitions from one to the other, in this calendar system.

  //int32_t  ucal_getWeekendTransition (const UCalendar *cal, UCalendarDaysOfWeek dayOfWeek, UErrorCode *status)
  //  Returns the time during the day at which the weekend begins or ends in this calendar system.

  //UBool  ucal_isWeekend (const UCalendar *cal, UDate date, UErrorCode *status)
  //  Returns TRUE if the given UDate is in the weekend in this calendar system.

  //int32_t  ucal_getFieldDifference (UCalendar *cal, UDate target, UCalendarDateFields field, UErrorCode *status)
  //  Return the difference between the target time and the time this calendar object is currently set to.
  ucal_getFieldDifference: function(cal: PUCalendar; target: UDate; field: UCalendarDateFields;
    var status: UErrorCode): Int32; cdecl;

  //UBool  ucal_getTimeZoneTransitionDate (const UCalendar *cal, UTimeZoneTransitionType type, UDate *transition, UErrorCode *status)
  //  Get the UDate for the next/previous time zone transition relative to the calendar's
  // current date, in the time zone to which the calendar is currently set.
  ucal_getTimeZoneTransitionDate: function(const cal: PUCalendar; aType: UTimeZoneTransitionType; var transition: UDate;
    var status: UErrorCode): UBool; cdecl;


type
  TCacheCollator = record
  const
    MaxCollatorCacheSize: Integer = 10;
  private
  type
    TCollatorItem = record
      LocaleStr: MarshaledAString;
      UsageCounter: UInt32;
      Options: TCompareOptions;
      Collator: PUCollator;
      constructor Create(const ALocaleStr: MarshaledAString; AOptions: TCompareOptions);
      procedure Destroy;
    end;
    function AddCollator(const ALocaleStr: MarshaledAString; AOptions: TCompareOptions): PUCollator;
    function FindCollator(const ALocaleStr: MarshaledAString; AOptions: TCompareOptions): PUCollator;
    function GetUnusedIndex: Integer;
    procedure AdjustUsageStatistics;
    class procedure MapOptionsToCollator(AOptions: TCompareOptions; const collator: PUCollator); static; inline;
  var
    LangCollators: array of TCollatorItem;
  public
    function GetCollator(const ALocaleStr: MarshaledAString; AOptions: TCompareOptions): PUCollator;
    procedure Destroy;
  end;

// This procedure needs to be called upon thread destruction if the user code
// is not using a TThread descendant to do the thread management.
// This frees the collator cache.
procedure ClearCollatorCache;

// The collators cannot be shared between threads, therefore we duplicate the cache for every thread.
threadvar
  CollatorCache: TCacheCollator;

procedure InitHIC;


implementation

uses
  System.SysConst,
  Posix.String_,
  Posix.Dlfcn;

function InitICU: Boolean;

begin
   InitHIC;
   Result := False;
end;

  function GetFncAddress(Handle: NativeUInt; FunctionName: string): Pointer;
  var
    Ptr: TPtrWrapper;
  begin
    Ptr := TMarshal.AllocStringAsUtf8(FunctionName + System.LibICUSuffix);
    Result := dlsym(Handle, Ptr.ToPointer);
    TMarshal.FreeMem(Ptr);
  end;
  
  function InitHICUUC: Boolean;
    begin
    @u_getDataDirectory := GetFncAddress(System.HICUUC, 'u_getDataDirectory');

    @u_errorName := GetFncAddress(System.HICUUC, 'u_errorName');


  { ICU ucnv.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/ucnv_8h.html }
    @ucnv_compareNames := GetFncAddress(System.HICUUC, 'ucnv_compareNames');
    @ucnv_open := GetFncAddress(System.HICUUC,'ucnv_open');
    @ucnv_openU := GetFncAddress(System.HICUUC,'ucnv_openU');
    @ucnv_openCCSID := GetFncAddress(System.HICUUC,'ucnv_openCCSID');
    @ucnv_openPackage := GetFncAddress(System.HICUUC, 'ucnv_openPackage');
    @ucnv_safeClone := GetFncAddress(System.HICUUC, 'ucnv_safeClone');
    @ucnv_close := GetFncAddress(System.HICUUC,'ucnv_close');
//    @ := GetFncAddress(System.HICUUC, '');
    @ucnv_setSubstChars := GetFncAddress(System.HICUUC, 'ucnv_setSubstChars');
    @ucnv_getInvalidChars := GetFncAddress(System.HICUUC, 'ucnv_getInvalidChars');
    @ucnv_getInvalidUChars := GetFncAddress(System.HICUUC, 'ucnv_getInvalidUChars');
    @ucnv_reset := GetFncAddress(System.HICUUC, 'ucnv_reset');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @ucnv_getMaxCharSize := GetFncAddress(System.HICUUC, 'ucnv_getMaxCharSize');
    @ucnv_getMinCharSize := GetFncAddress(System.HICUUC, 'ucnv_getMinCharSize');
    @ucnv_getDisplayName := GetFncAddress(System.HICUUC, 'ucnv_getDisplayName');
    @ucnv_getName := GetFncAddress(System.HICUUC, 'ucnv_getName');
    @ucnv_getCCSID := GetFncAddress(System.HICUUC, 'ucnv_getCCSID');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @ucnv_setToUCallBack := GetFncAddress(System.HICUUC, 'ucnv_setToUCallBack');
    @ucnv_setFromUCallBack := GetFncAddress(System.HICUUC, 'ucnv_setFromUCallBack');
//    @ := GetFncAddress(System.HICUUC, '');
    @ucnv_toUnicode := GetFncAddress(System.HICUUC, 'ucnv_toUnicode');
    @ucnv_fromUChars := GetFncAddress(System.HICUUC, 'ucnv_fromUChars');
    @ucnv_toUChars := GetFncAddress(System.HICUUC, 'ucnv_toUChars');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @ucnv_countAvailable := GetFncAddress(System.HICUUC, 'ucnv_countAvailable');
    @ucnv_getAvailableName := GetFncAddress(System.HICUUC, 'ucnv_getAvailableName');
//    @ := GetFncAddress(System.HICUUC, '');
    @ucnv_countAliases := GetFncAddress(System.HICUUC, 'ucnv_countAliases');
    @ucnv_getAlias := GetFncAddress(System.HICUUC, 'ucnv_getAlias');
    @ucnv_getAliases := GetFncAddress(System.HICUUC, 'ucnv_getAliases');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @ucnv_cbToUWriteUChars := GetFncAddress(System.HICUUC, 'ucnv_cbToUWriteUChars');


{ ICU ustring.h File Reference }
{ http://www.icu-project.org/apiref/icu4c/ustring_8h.html }

//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @u_strcmp := GetFncAddress(System.HICUUC, 'u_strcmp');
    @u_strcmpCodePointOrder := GetFncAddress(System.HICUUC, 'u_strcmpCodePointOrder');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @u_strCaseCompare := GetFncAddress(System.HICUUC, 'u_strCaseCompare');
    @u_strncmp := GetFncAddress(System.HICUUC, 'u_strncmp');
    @u_strncmpCodePointOrder := GetFncAddress(System.HICUUC, 'u_strncmpCodePointOrder');
    @u_strcasecmp := GetFncAddress(System.HICUUC, 'u_strcasecmp');
    @u_strncasecmp := GetFncAddress(System.HICUUC, 'u_strncasecmp');
    @u_memcasecmp := GetFncAddress(System.HICUUC, 'u_memcasecmp');
    @u_strcpy := GetFncAddress(System.HICUUC, 'u_strcpy');
    @u_strncpy := GetFncAddress(System.HICUUC, 'u_strncpy');
    @u_uastrcpy := GetFncAddress(System.HICUUC, 'u_uastrcpy');
    @u_uastrncpy := GetFncAddress(System.HICUUC, 'u_uastrncpy');
    @u_austrcpy := GetFncAddress(System.HICUUC, 'u_austrcpy');
    @u_austrncpy := GetFncAddress(System.HICUUC, 'u_austrncpy');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');

    @u_strToLower := GetFncAddress(System.HICUUC, 'u_strToLower');
    @u_strToUpper := GetFncAddress(System.HICUUC, 'u_strToUpper');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @u_strToUTF8 := GetFncAddress(System.HICUUC, 'u_strToUTF8');
    @u_strFromUTF8 := GetFncAddress(System.HICUUC, 'u_strFromUTF8');
//    @ := GetFncAddress(System.HICUUC, '');
    @u_strFromUTF8WithSub := GetFncAddress(System.HICUUC, 'u_strFromUTF8WithSub');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');


  { ICU uchar.h File Reference }
  { http://icu-project.org/apiref/icu4c/uchar_8h.html }

//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @u_tolower := GetFncAddress(System.HICUUC, 'u_tolower');
    @u_toupper := GetFncAddress(System.HICUUC, 'u_toupper');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');

  { ICU uloc.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/uloc_8h.html }
    @uloc_getDefault := GetFncAddress(System.HICUUC, 'uloc_getDefault');
    @uloc_setDefault := GetFncAddress(System.HICUUC, 'uloc_setDefault');
    @uloc_getLanguage := GetFncAddress(System.HICUUC, 'uloc_getLanguage');
    @uloc_getScript := GetFncAddress(System.HICUUC, 'uloc_getScript');
    @uloc_getCountry := GetFncAddress(System.HICUUC, 'uloc_getCountry');
    @uloc_getVariant := GetFncAddress(System.HICUUC, 'uloc_getVariant');
    @uloc_getName := GetFncAddress(System.HICUUC, 'uloc_getName');
    @uloc_canonicalize := GetFncAddress(System.HICUUC, 'uloc_canonicalize');
    @uloc_getISO3Language := GetFncAddress(System.HICUUC, 'uloc_getISO3Language');
    @uloc_getISO3Country := GetFncAddress(System.HICUUC, 'uloc_getISO3Country');
    @uloc_getLCID := GetFncAddress(System.HICUUC, 'uloc_getLCID');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @uloc_getAvailable := GetFncAddress(System.HICUUC, 'uloc_getAvailable');
    @uloc_countAvailable := GetFncAddress(System.HICUUC, 'uloc_countAvailable');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @uloc_getBaseName := GetFncAddress(System.HICUUC, 'uloc_getBaseName');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @uloc_acceptLanguage := GetFncAddress(System.HICUUC, 'uloc_acceptLanguage');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    @uloc_toLanguageTag := GetFncAddress(System.HICUUC, 'uloc_toLanguageTag');


  { ICU ulocdata.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/ulocdata_8h.html }

//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');


  { C API: String Enumeration. Definition in file uenum.h. }
  { http://www.icu-project.org/apiref/icu4c/uenum_8h.html }
    @uenum_close := GetFncAddress(System.HICUUC, 'uenum_close');
    @uenum_count := GetFncAddress(System.HICUUC, 'uenum_count');
    @uenum_unext := GetFncAddress(System.HICUUC, 'uenum_unext');
    @uenum_next := GetFncAddress(System.HICUUC, 'uenum_next');
    @uenum_reset := GetFncAddress(System.HICUUC, 'uenum_reset');
//    @ := GetFncAddress(System.HICUUC, '');
    @uenum_openUCharStringsEnumeration := GetFncAddress(System.HICUUC, 'uenum_openUCharStringsEnumeration');
    @uenum_openCharStringsEnumeration := GetFncAddress(System.HICUUC, 'uenum_openCharStringsEnumeration');


//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
//    @ := GetFncAddress(System.HICUUC, '');
    Result := True;
  end;
    
  function InitHICUI18N: Boolean;
  begin
    // Collation related functions...
    @ucol_open := GetFncAddress(System.HICUI18N, 'ucol_open');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    @ucol_close := GetFncAddress(System.HICUI18N, 'ucol_close');
    @ucol_strcoll := GetFncAddress(System.HICUI18N, 'ucol_strcoll');
    @ucol_strcollUTF8 := GetFncAddress(System.HICUI18N, 'ucol_strcollUTF8');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    @ucol_getStrength := GetFncAddress(System.HICUI18N, 'ucol_getStrength');
    @ucol_setStrength := GetFncAddress(System.HICUI18N, 'ucol_setStrength');
    @ucol_getReorderCodes := GetFncAddress(System.HICUI18N, 'ucol_getReorderCodes');
    @ucol_setReorderCodes := GetFncAddress(System.HICUI18N, 'ucol_setReorderCodes');
    @ucol_getEquivalentReorderCodes := GetFncAddress(System.HICUI18N, 'ucol_getEquivalentReorderCodes');
    @ucol_getDisplayName := GetFncAddress(System.HICUI18N, 'ucol_getDisplayName');
    @ucol_getAvailable := GetFncAddress(System.HICUI18N, 'ucol_getAvailable');
    @ucol_countAvailable := GetFncAddress(System.HICUI18N, 'ucol_countAvailable');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    @ucol_getRules := GetFncAddress(System.HICUI18N, 'ucol_getRules');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    @ucol_setAttribute := GetFncAddress(System.HICUI18N, 'ucol_setAttribute');
    @ucol_getAttribute := GetFncAddress(System.HICUI18N, 'ucol_getAttribute');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    @ucol_safeClone := GetFncAddress(System.HICUI18N, 'ucol_safeClone');
//    @ := GetFncAddress(System.HICUI18N, '');
    @ucol_getLocale := GetFncAddress(System.HICUI18N, 'ucol_getLocale');
    @ucol_getLocaleByType := GetFncAddress(System.HICUI18N, 'ucol_getLocaleByType');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    @ucol_cloneBinary := GetFncAddress(System.HICUI18N, 'ucol_cloneBinary');
    @ucol_openBinary := GetFncAddress(System.HICUI18N, 'ucol_openBinary');

    // Date Format functions...
    @udat_toCalendarDateField := GetFncAddress(System.HICUI18N, 'udat_toCalendarDateField');
    @udat_open := GetFncAddress(System.HICUI18N, 'udat_open');
    @udat_close := GetFncAddress(System.HICUI18N, 'udat_close');
    @udat_clone := GetFncAddress(System.HICUI18N, 'udat_clone');
    @udat_format := GetFncAddress(System.HICUI18N, 'udat_format');
    @udat_parse := GetFncAddress(System.HICUI18N, 'udat_parse');
    @udat_parseCalendar := GetFncAddress(System.HICUI18N, 'udat_parseCalendar');
    @udat_isLenient := GetFncAddress(System.HICUI18N, 'udat_isLenient');
    @udat_setLenient := GetFncAddress(System.HICUI18N, 'udat_setLenient');
    @udat_getCalendar := GetFncAddress(System.HICUI18N, 'udat_getCalendar');
    @udat_setCalendar := GetFncAddress(System.HICUI18N, 'udat_setCalendar');
    @udat_getNumberFormat := GetFncAddress(System.HICUI18N, 'udat_getNumberFormat');
    @udat_setNumberFormat := GetFncAddress(System.HICUI18N, 'udat_setNumberFormat');
    @udat_getAvailable := GetFncAddress(System.HICUI18N, 'udat_getAvailable');
    @udat_countAvailable := GetFncAddress(System.HICUI18N, 'udat_countAvailable');
    @udat_get2DigitYearStart := GetFncAddress(System.HICUI18N, 'udat_get2DigitYearStart');
    @udat_set2DigitYearStart := GetFncAddress(System.HICUI18N, 'udat_set2DigitYearStart');
    @udat_toPattern := GetFncAddress(System.HICUI18N, 'udat_toPattern');
    @udat_applyPattern := GetFncAddress(System.HICUI18N, 'udat_applyPattern');
    @udat_getSymbols := GetFncAddress(System.HICUI18N, 'udat_getSymbols');
    @udat_countSymbols := GetFncAddress(System.HICUI18N, 'udat_countSymbols');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    @udat_toPatternRelativeDate := GetFncAddress(System.HICUI18N, 'udat_toPatternRelativeDate');
    @udat_toPatternRelativeTime := GetFncAddress(System.HICUI18N, 'udat_toPatternRelativeTime');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');


  { C API: NumberFormat. }
  { http://www.icu-project.org/apiref/icu4c/unum_8h.html }
    // Number Format functions...
    @unum_open := GetFncAddress(System.HICUI18N, 'unum_open');
    @unum_close := GetFncAddress(System.HICUI18N, 'unum_close');
    @unum_clone := GetFncAddress(System.HICUI18N, 'unum_clone');
    @unum_format := GetFncAddress(System.HICUI18N, 'unum_format');
    @unum_formatInt64 := GetFncAddress(System.HICUI18N, 'unum_formatInt64');
    @unum_formatDouble := GetFncAddress(System.HICUI18N, 'unum_formatDouble');
    @unum_formatDecimal := GetFncAddress(System.HICUI18N, 'unum_formatDecimal');
    @unum_formatDoubleCurrency := GetFncAddress(System.HICUI18N, 'unum_formatDoubleCurrency');
    @unum_parse := GetFncAddress(System.HICUI18N, 'unum_parse');
    @unum_parseInt64 := GetFncAddress(System.HICUI18N, 'unum_parseInt64');
    @unum_parseDouble := GetFncAddress(System.HICUI18N, 'unum_parseDouble');
    @unum_parseDecimal := GetFncAddress(System.HICUI18N, 'unum_parseDecimal');
    @unum_parseDoubleCurrency := GetFncAddress(System.HICUI18N, 'unum_parseDoubleCurrency');
    @unum_applyPattern := GetFncAddress(System.HICUI18N, 'unum_applyPattern');
    @unum_getAvailable := GetFncAddress(System.HICUI18N, 'unum_getAvailable');
    @unum_countAvailable := GetFncAddress(System.HICUI18N, 'unum_countAvailable');
    @unum_getAttribute := GetFncAddress(System.HICUI18N, 'unum_getAttribute');
    @unum_setAttribute := GetFncAddress(System.HICUI18N, 'unum_setAttribute');
    @unum_getDoubleAttribute := GetFncAddress(System.HICUI18N, 'unum_getDoubleAttribute');
    @unum_setDoubleAttribute := GetFncAddress(System.HICUI18N, 'unum_setDoubleAttribute');
    @unum_getTextAttribute := GetFncAddress(System.HICUI18N, 'unum_getTextAttribute');
    @unum_setTextAttribute := GetFncAddress(System.HICUI18N, 'unum_setTextAttribute');
    @unum_toPattern := GetFncAddress(System.HICUI18N, 'unum_toPattern');
    @unum_getSymbol := GetFncAddress(System.HICUI18N, 'unum_getSymbol');
    @unum_setSymbol := GetFncAddress(System.HICUI18N, 'unum_setSymbol');
    @unum_getLocaleByType := GetFncAddress(System.HICUI18N, 'unum_getLocaleByType');


  { ucal.h File Reference }
  { http://www.icu-project.org/apiref/icu4c/ucal_8h.html }
    @ucal_openTimeZoneIDEnumeration := GetFncAddress(System.HICUI18N, 'ucal_openTimeZoneIDEnumeration');
    @ucal_openTimeZones := GetFncAddress(System.HICUI18N, 'ucal_openTimeZones');
    @ucal_openCountryTimeZones := GetFncAddress(System.HICUI18N, 'ucal_openCountryTimeZones');
    @ucal_getDefaultTimeZone := GetFncAddress(System.HICUI18N, 'ucal_getDefaultTimeZone');
    @ucal_setDefaultTimeZone := GetFncAddress(System.HICUI18N, 'ucal_setDefaultTimeZone');
    @ucal_getDSTSavings := GetFncAddress(System.HICUI18N, 'ucal_getDSTSavings');
    @ucal_getNow := GetFncAddress(System.HICUI18N, 'ucal_getNow');
    @ucal_open := GetFncAddress(System.HICUI18N, 'ucal_open');
    @ucal_close := GetFncAddress(System.HICUI18N, 'ucal_close');
    @ucal_clone := GetFncAddress(System.HICUI18N, 'ucal_clone');
    @ucal_setTimeZone := GetFncAddress(System.HICUI18N, 'ucal_setTimeZone');
    @ucal_getTimeZoneID := GetFncAddress(System.HICUI18N, 'ucal_getTimeZoneID');
    @ucal_getTimeZoneDisplayName := GetFncAddress(System.HICUI18N, 'ucal_getTimeZoneDisplayName');
    @ucal_inDaylightTime := GetFncAddress(System.HICUI18N, 'ucal_inDaylightTime');
    @ucal_setGregorianChange := GetFncAddress(System.HICUI18N, 'ucal_setGregorianChange');
    @ucal_getGregorianChange := GetFncAddress(System.HICUI18N, 'ucal_getGregorianChange');
    @ucal_getAttribute := GetFncAddress(System.HICUI18N, 'ucal_getAttribute');
    @ucal_setAttribute := GetFncAddress(System.HICUI18N, 'ucal_setAttribute');
    @ucal_getAvailable := GetFncAddress(System.HICUI18N, 'ucal_getAvailable');
    @ucal_countAvailable := GetFncAddress(System.HICUI18N, 'ucal_countAvailable');
    @ucal_getMillis := GetFncAddress(System.HICUI18N, 'ucal_getMillis');
    @ucal_setMillis := GetFncAddress(System.HICUI18N, 'ucal_setMillis');
    @ucal_setDate := GetFncAddress(System.HICUI18N, 'ucal_setDate');
    @ucal_setDateTime := GetFncAddress(System.HICUI18N, 'ucal_setDateTime');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    @ucal_get := GetFncAddress(System.HICUI18N, 'ucal_get');
    @ucal_set := GetFncAddress(System.HICUI18N, 'ucal_set');
    @ucal_isSet := GetFncAddress(System.HICUI18N, 'ucal_isSet');
    @ucal_clearField := GetFncAddress(System.HICUI18N, 'ucal_clearField');
    @ucal_clear := GetFncAddress(System.HICUI18N, 'ucal_clear');
    @ucal_getLimit := GetFncAddress(System.HICUI18N, 'ucal_getLimit');
    @ucal_getLocaleByType := GetFncAddress(System.HICUI18N, 'ucal_getLocaleByType');
    @ucal_getTZDataVersion := GetFncAddress(System.HICUI18N, 'ucal_getTZDataVersion');
    @ucal_getCanonicalTimeZoneID := GetFncAddress(System.HICUI18N, 'ucal_getCanonicalTimeZoneID');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    @ucal_getFieldDifference := GetFncAddress(System.HICUI18N, 'ucal_getFieldDifference');
    @ucal_getTimeZoneTransitionDate := GetFncAddress(System.HICUI18N, 'ucal_getTimeZoneTransitionDate');


//    @ := GetFncAddress(System.HICUI18N, '');
//    @ := GetFncAddress(System.HICUI18N, '');
    Result := True;
  end;
  
procedure InitHIC;
begin
  if System.HICUUC > 0 then
     InitHICUUC;
  if System.HICUI18N > 0 then
     InitHICUI18N;
end;

procedure ClearCollatorCache;
begin
  CollatorCache.Destroy;
end;

{ TCacheCollator }

procedure TCacheCollator.TCollatorItem.Destroy;
begin
  System.FreeMem(LocaleStr);
  ucol_close(Collator);
end;

procedure TCacheCollator.Destroy;
var
  I: Integer;
begin
  for I := Low(LangCollators) to High(LangCollators) do
    LangCollators[I].Destroy;
  Finalize(LangCollators);
end;

constructor TCacheCollator.TCollatorItem.Create(const ALocaleStr: MarshaledAString; AOptions: TCompareOptions);
var
  ErrorCode: UErrorCode;
  LLength: Integer;
begin
  UsageCounter := 0;
  LLength := Length(ALocaleStr) + 1;
  LocaleStr := System.AllocMem(LLength);
  System.Move(ALocaleStr^, LocaleStr^, LLength);

  Options := AOptions;
  ErrorCode := U_ZERO_ERROR;
  Collator := ucol_open(ALocaleStr, ErrorCode);
  if ErrorCode > U_ZERO_ERROR then
    raise Exception.CreateFmt(SICUError, [Int32(ErrorCode), UTF8ToString(u_errorName(ErrorCode))]);

  MapOptionsToCollator(AOptions, Collator);
end;

function TCacheCollator.GetUnusedIndex: Integer;
var
  I: Integer;
  MinValue: UInt32;
  MinIndex: Integer;
begin
  MinIndex := 0;
  MinValue := MAXINT;
  Result := -1;
  for I := Low(LangCollators) to High(LangCollators) do
  begin
    // If there is one unused collator, first use this.
    if LangCollators[I].UsageCounter = 0 then
    begin
      Result := I;
      break;
    end;
    if LangCollators[I].UsageCounter < MinValue then
    begin
      MinValue := LangCollators[I].UsageCounter;
      MinIndex := I;
    end;
  end;
  if Result = -1 then
  begin
    // If all the collators were used, reset the usage statistics, and choose the least used.
    Result := MinIndex;
    for I := Low(LangCollators) to High(LangCollators) do
      LangCollators[I].UsageCounter := 0;
  end;
end;

function TCacheCollator.AddCollator(const ALocaleStr: MarshaledAString; AOptions: TCompareOptions): PUCollator;
var
  I: Integer;
  LLength: Integer;
begin
  LLength := Length(LangCollators);
  // If the collator is not found we add the collator or clean an old one.
  if LLength < MaxCollatorCacheSize then
  begin
    SetLength(LangCollators, LLength + 1);
    I := High(LangCollators);
  end
  else begin
    I := GetUnusedIndex;
    LangCollators[I].Destroy;
  end;

  LangCollators[I] := TCollatorItem.Create(ALocaleStr, AOptions);
  Result := LangCollators[I].Collator;
end;

procedure TCacheCollator.AdjustUsageStatistics;
var
  I: Integer;
begin
  // Change in the same proportion all counters. Divide by 65536
  for I := Low(LangCollators) to High(LangCollators) do
    LangCollators[I].UsageCounter := LangCollators[I].UsageCounter shr 16;
end;

function TCacheCollator.FindCollator(const ALocaleStr: MarshaledAString; AOptions: TCompareOptions): PUCollator;
var
  I: Integer;
begin
  Result := nil;
  for I := Low(LangCollators) to High(LangCollators) do
  begin
    if (LangCollators[I].Options = AOptions) and (strcmp(LangCollators[I].LocaleStr, ALocaleStr) = 0) then
    begin
      // If we get past the signed MAXINT value then we need to adjust the counters
      // This likely will happen on servers that do a lot of string comparisions.
      if LangCollators[I].UsageCounter > UInt32(MAXINT) then
        AdjustUsageStatistics;

      // Increment the use counter and return the Collator.
      Inc(LangCollators[I].UsageCounter);
      Result := LangCollators[I].Collator;
      break;
    end;
  end;
end;

function TCacheCollator.GetCollator(const ALocaleStr: MarshaledAString; AOptions: TCompareOptions): PUCollator;
begin
  Result := FindCollator(ALocaleStr, AOptions);
  if Result = nil then
    Result := AddCollator(ALocaleStr, AOptions);
end;

class procedure TCacheCollator.MapOptionsToCollator(AOptions: TCompareOptions; const collator: PUCollator);
begin
  string.InternalMapOptionsToFlags(AOptions, Collator);
end;

initialization
  InitICU;
finalization
  ClearCollatorCache;
end.
