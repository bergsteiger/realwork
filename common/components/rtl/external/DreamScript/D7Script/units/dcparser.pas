{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcparser;

interface
{$I dc.inc}
uses
  dcdreamlib, dcsystem, consts, classes, sysutils, dcapi, dcconsts
  {$IFDEF D6}, rtlconsts{$ENDIF}
  {$IFNDEF CLX}, windows{$ELSE}, types{$ENDIF};
{-------------------------------------------------------------}

//BeginSkipConst

const
  SErrCharSetDef = 'Invalid charset definition';
  SErrStringsNotSet = 'Strings are not specified';

  MaxIfDefLevel = 32; // but in Delphi only 16 are allowed :)

  cMaxDelphiResWords = 100 + 5;
  SDelphiResWords: array[0..cMaxDelphiResWords - 1] of string = (
    'absolute', 'abstract', 'and', 'array', 'as', 'asm', 'assembler', 'automated',
    'begin', 'break', 'case', 'cdecl', 'class', 'const', 'constructor',
    'continue', 'default', 'deprecated', 'destructor',
    'dispid', 'dispinterface', 'div', 'do', 'downto', 'dynamic', 'else', 'end', 'except',
    'exit',
    'export', 'exports', 'external', 'far', 'file', 'finalization', 'finally', 'for',
    'forward', 'function', 'goto', 'if', 'implementation', 'in', 'index', 'inherited',
    'initialization', 'inline', 'interface', 'is', 'label', 'library', 'message', 'mod',
    {'name',}'near', 'nil', 'nodefault', 'not', 'object', 'of', 'or', 'out',
    'overload',
    'override',
    'packed', 'pascal', 'platform', 'private', 'procedure', 'program', 'property',
    'protected', 'public', 'published', 'raise', 'read', 'readonly', 'record', 'register',
    'reintroduce',
    'repeat', 'resident', 'resourcestring', 'safecall', 'set', 'shl', 'shr', 'stdcall',
    'stored', 'string', 'stringresource', 'then', 'threadvar', 'to', 'try', 'type',
    'unit', 'until', 'uses', 'var', 'virtual', 'while', 'with', 'write', 'writeonly',
    'xor');

  cMaxDFMResWords = 5;
  SDFMResWords: array[0..cMaxDFMResWords - 1] of string = (
    'end', 'inherited', 'inline', 'item', 'object');

  cMaxVBScrResWords = 56;
  SVBScrResWords: array[0..cMaxVBScrResWords - 1] of string = (
    'And', 'As', 'Call', 'Const', 'Date', 'Dim', 'Do', 'Empty', 'Exit', 'False', 'For',
    'Each', 'Elseif', 'Function', 'If', 'Then', 'Else', 'Is', 'Loop', 'Mod', 'Next', 'Not',
    'Nothing', 'Null', 'On', 'Error', 'Option', 'Explicit', 'Base', 'Compare', 'Or', 'Private',
    'Public', 'ReDim', 'Select', 'Case', 'Set', 'String', 'Sub', 'True', 'While', 'Wend',
    'Xor', 'Rem', 'end', 'ByVal', 'Attribute', 'Declare', 'To', 'Type', 'property',
    'get', 'let', 'friend', 'With', 'Class');

  cMaxJScrResWords = 58;
  SJScrResWords: array[0..cMaxJScrResWords - 1] of string = (
    'abstract', 'boolean', 'break', 'byte', 'case', 'catch', 'char', 'class', 'const', 'continue',
    'debugger', 'default', 'delete', 'do', 'double', 'else', 'enum', 'export', 'extends', 'false',
    'final', 'finally', 'float', 'for', 'function', 'goto', 'if', 'implements', 'import', 'in',
    'instanceof', 'int', 'interface', 'long', 'native', 'new', 'null', 'package', 'private', 'protected',
    'public', 'return', 'short', 'static', 'super', 'switch', 'synchronized', 'this', 'throw',
    'throws', 'transient', 'true', 'try', 'typeof', 'var', 'void', 'while', 'with');

  SqlWordsNum = 152;
  SqlResWords: array[0..SqlWordsNum - 1] of string = (
    'ACTIVE', 'ALL', 'AFTER', 'ALTER ', 'AND', 'ANY', 'AS', 'ASC', 'ASCENDING', 'AT',
    'AUTO', 'AUTOINC', 'BASE_NAME', 'BEFORE', 'BEGIN', 'BETWEEN', 'BLOB', 'BOOLEAN', 'BOTH',
    'BY', 'BYTES', 'CACHE', 'CAST', 'CHARACTER', 'CHECK', 'COLUMN', 'COMMIT', 'COMMITTED',
    'COMPUTED', 'CONDITIONAL', 'CONNECT', 'CONSTRAINT', 'CONTAINING', 'COUNT', 'CREATE',
    'CURRENT', 'CURSOR', 'DATABASE', 'DATE', 'DEBUG', 'DECIMAL', 'DECLARE', 'DEFAULT', 'DELETE',
    'DESC', 'DESCENDING', 'DISTINCT', 'DOMAIN', 'DO', 'DROP', 'ELSE', 'END', 'ENTRY_POINT',
    'ESCAPE', 'EXCEPTION', 'EXECUTE', 'EXISTS', 'EXIT', 'EXTERNAL', 'EXTRACT', 'FILTER', 'FLOAT',
    'FOR', 'FOREIGN', 'FROM', 'FULL', 'FUNCTION', 'GENERATOR', 'GO', 'GRANT', 'GROUP', 'HAVING',
    'IF', 'IN', 'INACTIVE', 'INDEX', 'INNER', 'INSERT', 'INTEGER', 'INTO', 'IS', 'ISOLATION',
    'JOIN', 'KEY', 'NULL', 'LEADING', 'LEFT', 'LEVEL', 'LIKE', 'MERGE', 'MONEY', 'NAMES', 'NO',
    'NOT', 'NUMERIC', 'OF', 'ON', 'ONLY', 'OR', 'ORDER', 'OUTER', 'PARAMETER', 'PASSWORD', 'PIVOT',
    'PLAN', 'POSITION', 'PROCEDURE', 'PROTECTED', 'PRIMARY', 'PRIVILEGES', 'READ', 'REFERENCES',
    'RETAIN', 'RETURNING_VALUES', 'RETURNS', 'REVOKE', 'RIGHT', 'ROLLBACK', 'SCHEMA', 'SELECT',
    'SET', 'SHARED', 'SHADOW', 'SMALLINT', 'SNAPSHOT', 'SOME', 'SUSPEND', 'TABLE', 'THEN', 'TIME',
    'TIMESTAMP', 'TO', 'TRAILING', 'TRANSFORM', 'TRANSACTION', 'TRIGGER', 'UNCOMMITTED', 'UNION',
    'UNIQUE', 'UPDATE', 'USER', 'USING', 'VALUES', 'VARCHAR', 'VARIABLE', 'VIEW', 'WAIT', 'WHEN',
    'WHERE', 'WHILE', 'WITH', 'WORK');

  cMaxPerlScrResWords = 33;
// SPerlScrResWords should always be sorted in other case "Perl parser reserved words" will
// not coincide with real keywords.
  SPerlScrResWords: array[0..cMaxPerlScrResWords - 1] of string = (
    'and', 'cmp', 'continue', 'do', 'else', 'elsif', 'eq', 'for', 'foreach', 'ge', 'goto',
    'gt', 'if', 'last', 'le', 'local', 'lt', 'my', 'ne', 'next', 'not', 'or', 'package',
    'require', 'return', 'strict', 'sub', 'switch', 'unless', 'until', 'use', 'while', 'xor' );

  {  cMaxHTMLResWords = 89;
    SHTMLResWords:Array[0..cMaxHTMLResWords - 1] of string=(
    'A' ,'ADDRESS' ,'APPLET' ,'B' ,'BIG' ,'BLINK' ,'BLOCKQUOTE' ,'BODY' ,'CAPTION',
    'CENTER', 'CITE' ,'CODE' ,'COL' ,'COLGROUP', 'COMMENT' ,'DIV' ,'DL', 'DFN',
    'DIR' ,'EM' ,'FONT' ,'FORM' ,'FRAMESET' ,'NOFRAMES' ,'H1', 'H2' ,'H3' ,'H4',
    'H5', 'H6' ,'HEAD' ,'HTML' ,'I', 'IFRAME' ,'KBD' ,'LISTING' ,'MAP', 'MARQUEE',
    'MENU', 'OBJECT' ,'OL' ,'P' ,'PLAINTEXT', 'PRE' ,'S' ,'SAMP' ,'SCRIPT', 'NOSCRIPT',
    'SELECT' ,'SMALL' ,'STRIKE' ,'STRONG' ,'STYLE' ,'SPAN' ,'SUB' ,'SUP' ,'TABLE',
    'TD' ,'TH' ,'TR' ,'TEXTAREA' ,'TITLE' ,'TT' ,'U' ,'UL', 'VAR', 'XMP','AREA',
    'PARAM' ,'BASE','BASEFONT' ,'BGSOUND' ,'SOUND' ,'BR' ,'DD' ,'DT' ,'EMBED',
    'FRAME', 'HR' ,'INPUT' ,'IMG' ,'ISINDEX' ,'LI' ,'LINK' ,'META' ,'NEXTID' ,'NOBR',
    'OPTION','WBR');
   }

  cMaxCppResWords = 94;
  SCPPResWords: array[0..cMaxCppResWords - 1] of string = ('__asm', '_asm',
    'asm', 'auto', '__automated', 'break', 'bool', 'case', 'catch', '__cdecl',
    '_cdecl', 'cdecl', 'char', 'class', '__classid', '__closure', 'const',
    'const_cast', 'continue', '__declspec', 'default', 'delete', '__dispid',
    'do', 'double', 'dynamic_cast', 'else', 'enum', '__except', 'explicit', '_export',
    '__export', 'extern', 'false', '__fastcall', '_fastcall', '__finally', 'float',
    'for', 'friend', 'goto', 'if', '__import', '_import', 'inline', 'int', '__int8',
    '__int16', '__int32', '__int64', 'long', 'mutable', 'namespace', 'new', 'operator',
    '__pascal', '_pascal', 'pascal', 'private', 'protected', '__property', 'public',
    '__published', 'register', 'reinterpret_cast', 'return', '__rtti', 'short', 'signed',
    'sizeof', 'static', 'static_cast', '__stdcall', '_stdcall', 'struct', 'switch',
    'template', 'this', '__thread', 'throw', 'true', '__try', 'try', 'typedef', 'typename',
    'typeid', 'union', 'using', 'unsigned', 'virtual', 'void', 'volatile', 'wchar_t', 'while');

  cMaxCResWords = 31;
  SCResWords: array[0..cMaxCResWords - 1] of string = ('auto', 'break', 'case',
    'char', 'continue', 'default', 'do', 'double', 'else', 'enum', 'extern', 'float',
    'for', 'goto', 'if', 'int', 'long', 'register', 'return', 'short', 'signed', 'sizeof',
    'static', 'struct', 'switch', 'typedef', 'union', 'unsigned', 'void', 'volatile', 'while');

  cMaxPythonResWords = 28;
  sPythonResWords: array[0..cMaxPythonResWords - 1] of string =
    ('and', 'assert', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else',
    'except', 'exec', 'finally', 'for', 'from', 'global', 'if', 'import', 'in',
    'is', 'lambda', 'not', 'or', 'pass', 'print', 'raise', 'return', 'try', 'while');

  cDirectivesNum = 13;
  cDirectives: array[0..cDirectivesNum - 1] of string = (
    'DEFINE', 'ELSE', 'ENDIF', 'I', 'IF', 'IFDEF',  'IFEND', 'IFNDEF', 'IFOPT',
    'INCLUDE', 'R', 'RESOURCE', 'UNDEF');

  cCppSuffixesSize = 17;
  cCppSuffixes: array[0..cCppSuffixesSize - 1] of string = ('ui64', 'i64', 'i32', 'i16', 'i8',
    'ul', 'lu', 'Ul', 'lU', 'uL', 'Lu', 'LU', 'UL', 'U', 'u', 'L', 'l');

  //EndSkipConst

  IDD_DEFINE   = 0;
  IDD_ELSE     = IDD_DEFINE   + 1;
  IDD_ENDIF    = IDD_ELSE     + 1;
  IDD_I        = IDD_ENDIF    + 1;
  IDD_IF       = IDD_I        + 1;
  IDD_IFDEF    = IDD_IF       + 1;
  IDD_IFEND    = IDD_IFDEF    + 1;
  IDD_IFNDEF   = IDD_IFEND    + 1;
  IDD_IFOPT    = IDD_IFNDEF   + 1;
  IDD_INCLUDE  = IDD_IFOPT    + 1;
  IDD_R        = IDD_INCLUDE  + 1;
  IDD_RESOURCE = IDD_R        + 1;
  IDD_UNDEF    = IDD_RESOURCE + 1;

type
  TDCPlatformKind=(pkWindows,pkLinux);

const
  SDCConditionalExpressions='ConditionalExpressions';
  SDCDefined='Defined';
  SDCDeclared='Declared';
  SDCMSWINDOWS='MSWINDOWS';
  SDCWIN32='WIN32';
  SDCLINUX='LINUX';

  SDCPlatformDefine:Array[TDCPlatformKind] of String=(SDCMSWINDOWS,SDCLINUX);
  SDCPlatformDefine2:Array[TDCPlatformKind] of String=(SDCWIN32,SDCLINUX);

  // ------------------------ Delphi parser reserved words ------------------

  ID_absolute = 0;
  ID_abstract = ID_absolute + 1;
  ID_and = ID_abstract + 1;
  ID_array = ID_and + 1;
  ID_as = ID_array + 1;
  ID_asm = ID_as + 1;
  ID_assembler = ID_asm + 1;
  ID_automated = ID_assembler + 1;
  ID_begin = ID_automated + 1;
  ID_break = ID_begin + 1;
  ID_case = ID_break + 1;
  ID_cdecl = ID_case + 1;
  ID_class = ID_cdecl + 1;
  ID_const = ID_class + 1;
  ID_constructor = ID_const + 1;
  ID_continue = ID_constructor + 1;
  ID_default = ID_continue + 1;
  ID_deprecated = ID_default + 1;
  ID_destructor = ID_deprecated + 1;
  ID_dispid = ID_destructor + 1;
  ID_dispinterface = ID_dispid + 1;
  ID_div = ID_dispinterface + 1;
  ID_do = ID_div + 1;
  ID_downto = ID_do + 1;
  ID_dynamic = ID_downto + 1;
  ID_else = ID_dynamic + 1;
  ID_end = ID_else + 1;
  ID_except = ID_end + 1;
  ID_exit = ID_except + 1;
  ID_export = ID_exit + 1;
  ID_exports = ID_export + 1;
  ID_external = ID_exports + 1;
  ID_far = ID_external + 1;
  ID_file = ID_far + 1;
  ID_finalization = ID_file + 1;
  ID_finally = ID_finalization + 1;
  ID_for = ID_finally + 1;
  ID_forward = ID_for + 1;
  ID_function = ID_forward + 1;
  ID_goto = ID_function + 1;
  ID_if = ID_goto + 1;
  ID_implementation = ID_if + 1;
  ID_in = ID_implementation + 1;
  ID_index = ID_in + 1;
  ID_inherited = ID_index + 1;
  ID_initialization = ID_inherited + 1;
  ID_inline = ID_initialization + 1;
  ID_interface = ID_inline + 1;
  ID_is = ID_interface + 1;
  ID_label = ID_is + 1;
  ID_library = ID_label + 1;
  ID_message = ID_library + 1;
  ID_mod = ID_message + 1;
  ID_near = ID_mod + 1;
  ID_nil = ID_near + 1;
  ID_nodefault = ID_nil + 1;
  ID_not = ID_nodefault + 1;
  ID_object = ID_not + 1;
  ID_of = ID_object + 1;
  ID_or = ID_of + 1;
  ID_out = ID_or + 1;
  ID_overload = ID_out + 1;
  ID_override = ID_overload + 1;
  ID_packed = ID_override + 1;
  ID_pascal = ID_packed + 1;
  ID_platform = ID_pascal + 1;
  ID_private = ID_platform + 1;
  ID_procedure = ID_private + 1;
  ID_program = ID_procedure + 1;
  ID_property = ID_program + 1;
  ID_protected = ID_property + 1;
  ID_public = ID_protected + 1;
  ID_published = ID_public + 1;
  ID_raise = ID_published + 1;
  ID_read = ID_raise + 1;
  ID_readonly = ID_read + 1;
  ID_record = ID_readonly + 1;
  ID_register = ID_record + 1;
  ID_reintroduce = ID_register + 1;
  ID_repeat = ID_reintroduce + 1;
  ID_resident = ID_repeat + 1;
  ID_resourcestring = ID_resident + 1;
  ID_safecall = ID_resourcestring + 1;
  ID_set = ID_safecall + 1;
  ID_shl = ID_set + 1;
  ID_shr = ID_shl + 1;
  ID_stdcall = ID_shr + 1;
  ID_stored = ID_stdcall + 1;
  ID_string = ID_stored + 1;
  ID_stringresource = ID_string + 1;
  ID_then = ID_stringresource + 1;
  ID_threadvar = ID_then + 1;
  ID_to = ID_threadvar + 1;
  ID_try = ID_to + 1;
  ID_type = ID_try + 1;
  ID_unit = ID_type + 1;
  ID_until = ID_unit + 1;
  ID_uses = ID_until + 1;
  ID_var = ID_uses + 1;
  ID_virtual = ID_var + 1;
  ID_while = ID_virtual + 1;
  ID_with = ID_while + 1;
  ID_write = ID_with + 1;
  ID_writeonly = ID_write + 1;
  ID_xor = ID_writeonly + 1;

  // ------------------------ Java parser reserved words ------------------

  IDJ_abstract = 0;
  IDJ_boolean = IDJ_abstract + 1;
  IDJ_break = IDJ_boolean + 1;
  IDJ_byte = IDJ_break + 1;
  IDJ_case = IDJ_byte + 1;
  IDJ_catch = IDJ_case + 1;
  IDJ_char = IDJ_catch + 1;
  IDJ_class = IDJ_char + 1;
  IDJ_const = IDJ_class + 1;
  IDJ_continue = IDJ_const + 1;
  IDJ_debugger = IDJ_continue + 1;
  IDJ_default = IDJ_debugger + 1;
  IDJ_delete = IDJ_default + 1;
  IDJ_do = IDJ_delete + 1;
  IDJ_double = IDJ_do + 1;
  IDJ_else = IDJ_double + 1;
  IDJ_enum = IDJ_else + 1;
  IDJ_export = IDJ_enum + 1;
  IDJ_extends = IDJ_export + 1;
  IDJ_false = IDJ_extends + 1;
  IDJ_final = IDJ_false + 1;
  IDJ_finally = IDJ_final + 1;
  IDJ_float = IDJ_finally + 1;
  IDJ_for = IDJ_float + 1;
  IDJ_function = IDJ_for + 1;
  IDJ_goto = IDJ_function + 1;
  IDJ_if = IDJ_goto + 1;
  IDJ_implements = IDJ_if + 1;
  IDJ_import = IDJ_implements + 1;
  IDJ_in = IDJ_import + 1;
  IDJ_instanceof = IDJ_in + 1;
  IDJ_int = IDJ_instanceof + 1;
  IDJ_interface = IDJ_int + 1;
  IDJ_long = IDJ_interface + 1;
  IDJ_native = IDJ_long + 1;
  IDJ_new = IDJ_native + 1;
  IDJ_null = IDJ_new + 1;
  IDJ_package = IDJ_null + 1;
  IDJ_private = IDJ_package + 1;
  IDJ_protected = IDJ_private + 1;
  IDJ_public = IDJ_protected + 1;
  IDJ_return = IDJ_public + 1;
  IDJ_short = IDJ_return + 1;
  IDJ_static = IDJ_short + 1;
  IDJ_super = IDJ_static + 1;
  IDJ_switch = IDJ_super + 1;
  IDJ_synchronized = IDJ_switch + 1;
  IDJ_this = IDJ_synchronized + 1;
  IDJ_throw = IDJ_this + 1;
  IDJ_throws = IDJ_throw + 1;
  IDJ_transient = IDJ_throws + 1;
  IDJ_true = IDJ_transient + 1;
  IDJ_try = IDJ_true + 1;
  IDJ_typeof = IDJ_try + 1;
  IDJ_var = IDJ_typeof + 1;
  IDJ_void = IDJ_var + 1;
  IDJ_while = IDJ_void + 1;
  IDJ_with = IDJ_while + 1;

  // ------------------------ Perl parser reserved words ------------------

  IDPerl_and      = 0;
  IDPerl_cmp      = IDPerl_and + 1;
  IDPerl_continue = IDPerl_cmp + 1;
  IDPerl_do       = IDPerl_continue + 1;
  IDPerl_else     = IDPerl_do + 1;
  IDPerl_elsif    = IDPerl_else + 1;
  IDPerl_eq       = IDPerl_elsif + 1;
  IDPerl_for      = IDPerl_eq + 1;
  IDPerl_foreach  = IDPerl_for + 1;
  IDPerl_ge       = IDPerl_foreach + 1;
  IDPerl_goto     = IDPerl_ge + 1;
  IDPerl_gt       = IDPerl_goto + 1;
  IDPerl_if       = IDPerl_gt + 1;
  IDPerl_last     = IDPerl_if + 1;
  IDPerl_le       = IDPerl_last + 1;
  IDPerl_local    = IDPerl_le + 1;
  IDPerl_lt       = IDPerl_local + 1;
  IDPerl_my       = IDPerl_lt + 1;
  IDPerl_ne       = IDPerl_my + 1;
  IDPerl_next     = IDPerl_ne + 1;
  IDPerl_not      = IDPerl_next + 1;
  IDPerl_or       = IDPerl_not + 1;
  IDPerl_package  = IDPerl_or + 1;
  IDPerl_require  = IDPerl_package + 1;
  IDPerl_return   = IDPerl_require + 1;
  IDPerl_strict   = IDPerl_return + 1;
  IDPerl_sub      = IDPerl_strict + 1;
  IDPerl_switch   = IDPerl_sub + 1;
  IDPerl_unless   = IDPerl_switch + 1;
  IDPerl_until    = IDPerl_unless + 1;
  IDPerl_use      = IDPerl_until + 1;
  IDPerl_while    = IDPerl_use + 1;
  IDPerl_xor      = IDPerl_while + 1;

  // ------------------------ character sets ------------------

  {$IFDEF D4}
  cAnyChar = [#0..#255];
  cFirstIdentChar = ['A'..'Z', 'a'..'z', '_'];
  cOtherIdentChars = ['A'..'Z', 'a'..'z', '_', '0'..'9'];
  cHexDigit = ['0'..'9', 'A'..'F', 'a'..'f'];
  cDigit = ['0'..'9'];
  cFloatDigit = ['0'..'9', '.', 'e', 'E', '+', '-'];
  cWhiteChar = [#33..#255];
  cOtherWhiteChar = [#34..#255];
  cFirstAsmIdentChar = ['A'..'Z', 'a'..'z', '_', '@', '$'];
  cValidChar = [#9, #32..#255];
  {$ELSE}
  cAnyChar: TCharSet = [#0..#255];
  cFirstIdentChar: TCharSet = ['A'..'Z', 'a'..'z', '_'];
  cOtherIdentChars: TCharSet = ['A'..'Z', 'a'..'z', '_', '0'..'9'];
  cHexDigit: TCharSet = ['0'..'9', 'A'..'F', 'a'..'f'];
  cDigit = ['0'..'9'];
  cFloatDigit: TCharSet = ['0'..'9', '.', 'e', 'E', '+', '-'];
  cWhiteChar: TCharSet = [#33..#255];
  cOtherWhiteChar: TCharSet = [#34..#255];
  cFirstAsmIdentChar: TCharSet = ['A'..'Z', 'a'..'z', '_', '@', '$'];
  cValidChar: TCharSet = [#9, #32..#255];
  {$ENDIF}
  //------------------- token codes ---------------------

  tokNone = -1; { empty token. Doesn't mean anything }
  tokEOF = 0; { end of file token }
  tokString = 1;
  tokComment = 2;
  tokSymbol = 3;
  tokInteger = 4;
  tokFloat = 5;
  tokResWord = 6;
  tokWhiteChar = 7;
  tokPreProcessor = 8;
  tokAssembler = 9;
  tokHtmlTag = 10;
  tokHtmlParam = 11;
  tokEOL = 12;

  // ----------- parser state codes ---------------------

  psNormal = 0; { parser in normal state }
  psComment = 1; { parser in comment state }
  psComment2 = 2; { parser in (* comment state }
  psHtmlTag = 3; // for html praser;
  psAsm = 4;
  psAsmComment = 5;
  psAsmCComment = 6;
  psAsmComment2 = 7;
  psString = 8;
  psCString = 9;
  psDefine = 10;
  psPerlLongString = 11;

type
  {$IFDEF D5}
  TDCErrorStatus=integer;
  {$ELSE}
  TDCErrorStatus=DWORD;
  {$ENDIF}

  TParserState = array[0..255] of TMethod;
  PParserState = ^TParserState;

  TParseProc = function: Integer of object;
  TCustomDCParser = class;

  TTokenData = class(TCollectionItem)
  public
    Token: integer;
    ParserState: integer;
    LinePos: integer;
    CharPos: integer;
    TokenCharPos: integer;
    SkipTokens: integer;
    IfDefLevel: integer;
    ResWordID: integer;
    LinePtr: PChar;
    SoftPush : Boolean;

    Procedure ProcessSinglePop( AParser : TCustomDCParser ); virtual;
  end;

  TTokenDataClass = class of TTokenData;

  TCustomDCParser = class(TSimpleParser)
  private
    FOnGetTextStyle: TGetColorDataEvent;
    FSpecialResWordID: Integer;
    FIntWords: TStringList;
    FSkipTokens: Integer;
    FResWords: TStrings;
    FIfDefLevel: Integer;
    FParserStates: TList; // list of parser states
    FParserState: Integer; // current parser state
    FTokenList: TCollection; // list of tokens (PushToken adds item to this list)

    fHashList: TList;

    FVersion: TDCVersion;
    fUnterminated: boolean;
    FCaseSensitive: boolean;
    procedure SetLinePtr(V: PChar);
    procedure CheckEnoughStates(MaxState: Integer);
    procedure SetResWords(V: TStrings);
    procedure OnChange(Sender: TObject);
    function GetInternalState: Integer;
    procedure SetInternalState(Value: Integer);
    function GetCharPos: Integer;
    function GetTokenCharPos: Integer;
    procedure SetTokenCharPos(Value: Integer);
    procedure SetCharPos(Value: Integer);
    procedure ParseCSuffixes;
    procedure SetCaseSensitive(Value: boolean);
    function NextWordIsEnd: boolean;
    function _checksensitiveresword(const s: string): boolean;

    procedure _Fill2(const StrData: string; AColorData: pchar);

    Function SinglePop : Boolean;
  protected
    FTokenPtr: PChar; // pointer to beginning of the token
    FSourcePtr: PChar; // current position in source
    FToken: Integer; // current token
    FLinePtr: PChar; // pointer to the beginning of the line
    FResWordID: Integer;
    function GetErrorDesc: string; virtual;
    procedure DoGetColorData(AToken: Integer; const ATokenStr: string; var AColorData: string); virtual;
    procedure SetLinePos(Value: Integer); virtual;
    procedure InitCommon; virtual;
    function Parse1310Eol: Integer;
    function Parse1013Eol: Integer;
    function ParseEol(C: Char): Integer;
    function SkipToCharOrEol(C: Char): boolean;
    procedure UpdateLinePtr; virtual;
    procedure TokenDataToState( T : TTokenData ); virtual;
    procedure StateToTokenData( T : TTokenData ); virtual;
    function GetTokenDataClass: TCollectionItemClass; virtual;

    function ParseUniComplexCommentEnd(C: Char): Integer;
    function ParseJscrComment: Integer;
    function ParseJScrCommentEnd: Integer;
    function ParseUniStrConst(C: Char): Integer;
    procedure UpdateSettings; virtual;
    function ParseCComment: Integer;
    function ParseVBIdentifier: Integer;
    function ParseCharConst: Integer;
    function ParseComplexCommentEnd: Integer;
    function ParseHexConst: Integer;
    function ParseJHexConst: Integer;
    function ParseStrConst: Integer;
    function ParseVBStrConst: Integer;
    function ParseCStrConst: Integer;
    function ParseComment: Integer; virtual;
    function ParseComplexComment: Integer;
    function ParseIdentifier: Integer;
    function ParseIdentifierEx(const Charset: TCharSet): Integer;
    function ParseNumConst: Integer;
    function ParseCNumConst: integer;
    function ParseCHexConst: integer;
    function ParseWhiteChar: Integer;
    function ParseDefines: integer;
    procedure Loaded; override;
    function ParseVBHexConst: Integer;
    procedure SkipDigits;
    procedure SkipHexDigits;
    function RestIsComment: Integer;
    property SpecialResWordID: Integer read FSpecialResWordID write FSpecialResWordID;
    function GetErrorPoint: TPoint; virtual;
    procedure InitEolState(State: Integer);
    procedure ClearParserStates;
    function ParseAsm: integer;
    function ParseAsmComment: Integer;
    function ParseAsmComplexComment: Integer;
    function ParseAsmComplexCommentEnd: Integer;
    function ParseDelphiIdentifier: Integer;
    function ParseAsmCComment: Integer;
    function FindResWord(const s: string): boolean;

    Property TokenList: TCollection Read FTokenList;
  public

    procedure ErrorFmt(const ErrorStr: string; const Args: array of const);
    procedure Error(const ErrorStr: string);
    procedure CheckChar(C: Char);
    procedure CheckNextChar(C: Char);
    procedure CheckResWord(AResWordID: Integer);
    procedure CheckNextResWord(AResWordID: Integer);

    { Skips tokens until finds reserved word with specific ID. Return true
      if such resword was found or false if eof was reached}
    function SkipToResWord(ResWordID: Integer): boolean;

    function SkipToChar(C: Char): boolean;

    function NextValidTokenStr: string;
    function PeekValidTokenStr: string;
    function ParserEOF: boolean;
    function NextTokenStr: string;
    function PeekTokenStr: string;
    function PeekToken: Integer;
    function SkipTokens(Number: Integer): Integer;
    Function IsTokenResWord( ResWord : Integer ) : Boolean;
    Function IsPeekTokenResWord( ResWord : Integer ) : Boolean;
    function IsTokenChar(C: Char): boolean;
    function IsPeekTokenChar(C: Char): boolean;
    function IsNextTokenChar(C: Char): boolean;
    function IsNextTokenResWord(ResWord: Integer): boolean;
    function TokenString: string; virtual;
    procedure InitJScrSyntax;
    procedure InitCSyntax;
    procedure InitCppSyntax;
    procedure InitJSSyntax;
    procedure InitVBSyntax;
    procedure InitDelphiSyntax;
    procedure InitDFMSyntax;

    function NextValidToken: Integer;
    function ColorString(const StrData: string; InitState: Integer; var AColorData: string): Integer; override;
    procedure RegisterProc(const ActiveInStates: array of Integer; const ACharSet: TCharSet; AProc: TParseProc);
    procedure RegisterNormalProc(const ACharSet: TCharSet; AProc: TParseProc);
    function NextToken: Integer; virtual;
    function SimpleNextToken: Integer;

    { Returns index of state in the stack of states}
    function PushState: Integer;

    { Returns new token }
    function PopState: Integer;

    Function SoftPushState : Integer;
    Function SoftPopState : Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property TokenPtr: PChar read FTokenPtr;
    property SourcePtr: PChar read FSourcePtr;
    property LinePtr: PChar read FLinePtr write SetLinePtr;

    { Parser state for external purposes. Don't mix with InternalState }
    property ParserState: Integer read FParserState write FParserState;
    property Token: Integer read FToken;
    property ResWordID: Integer read FResWordID;

    { Same as ResWords but sorted }
    property SortedResWords: TStringList read FIntWords;
    property InternalState: Integer read GetInternalState write SetInternalState;
    property CharPos: Integer read GetCharPos write SetCharPos;
    property TokenCharPos: Integer read GetTokenCharPos write SetTokenCharPos;
    property LinePos: Integer read FLinePos write SetLinePos;
    property ResWords: TStrings read FResWords write SetResWords;

    property UnterminatedString: boolean read fUnterminated;
    property CaseSensitive: boolean read FCaseSensitive write SetCaseSensitive default false;

  published
    property Version: TDCVersion read FVersion write FVersion stored false;
    property OnGetColorData: TGetColorDataEvent read FOnGetTextStyle write FOnGetTextStyle;
  end;

  TModuleParser = class(TCustomDCParser)
  private
    FPlatformKind:TDCPlatformKind;
    FDefines: TStrings;
    FDirectives: TStrings;
    FIgnoreDefines: TStrings;
    function GetDelphiVer:TDelphiVer;
    procedure SetSkipFlag(Level: Integer; Value: boolean);
    function GetSkipFlag(Level: Integer): boolean;
    procedure SetIgnoreDefines(V: TStrings);
  protected
    function DefineIsDefined(const ADefine:String):boolean;virtual;
    procedure ParseIncludeFile(const AFileName: string; IncludeInText: Boolean); virtual;
    function IgnoreDefinesAsLine:String;
  public
    function TokenString: string; override;
    function NextToken: Integer; override;
    function ParseComment: Integer; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Defines: TStrings read FDefines;
    property Directives: TStrings read FDirectives;
    property SkipFlag[Level: Integer]: boolean read GetSkipFlag write SetSkipFlag;
    property IgnoreDefines: TStrings read FIgnoreDefines write SetIgnoreDefines;
    property PlatformKind:TDCPlatformKind Read FPlatformKind Write FPlatformKind;
    property DelphiVer:TDelphiVer Read GetDelphiVer;
  end;

  TDCFileConfirm = procedure(var AFileName: string; var AConsiderEmpty: Boolean) of object;
  TDCStoreOperation = ( soAdd, soRelease );

{-------------------------------------------------------------}

  pDCOperationStorage = ^TDCOperationStorage;
  TDCOperationStorage = Record
    Data      : Pointer;
    Operation : TDCStoreOperation;
  end;

{-------------------------------------------------------------}

  TDCIncludeTokenData = class( TTokenData )
  private
    FOperations : TList;
  public
    Property Operations : TList Read FOperations;
    Procedure AddOperation( AData : Pointer; AOperation : TDCStoreOperation );

    Procedure ProcessSinglePop( AParser : TCustomDCParser ); override;

    Constructor Create( ACollection : TCollection ); override;
    Destructor Destroy; override;
  end;

{-------------------------------------------------------------}

  TDCIncludeParser = class(TModuleParser)
  private
    FParsedFileName: string;
    fUnitList: TStrings;
    fBuffers: TList;
    FInclFiles: TStrings;
    FFileConfirm: TDCFileConfirm;
  protected
    function PopIncludeStream: boolean;
    function GetParsedFileName: string; virtual;
    procedure ParseIncludeFile(const AFileName: string; AIncludeInText: Boolean); override;
    procedure DoFileConfirm(var AFileName: string; var AConsiderEmpty: Boolean); virtual;
    Function GetTokenDataClass : TCollectionItemClass; override;

    Function StoreOperation( AData : Pointer; AOperation : TDCStoreOperation ) : Boolean;
  public
    procedure AddIncludeFile(const FileName: string; IncludeInText: boolean);
    procedure AddIncludeStream(S: TStream);
    procedure LoadUnitPaths(const UnitS: string);
    function NextToken: Integer; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ParsedFileName: string read FParsedFileName write FParsedFileName;
    property UnitPaths: TStrings read FUnitList;
    property InclFiles: TStrings read FInclFiles;
  end;

  TStringsParser = class(TCustomDCParser)
  private
    FStrings: TStrings;
    FStr: string;
    FEOLIsSignificant : Boolean;

    Procedure SetStrings( AValue : TStrings );
  protected
    procedure ValidateStrings;

    procedure UpdateLinePtr; override;
    procedure SetLinePos(Value: Integer); override;
  public
    procedure ResetParser;
    function NextToken: Integer; override;
    property Strings: TStrings read FStrings write SetStrings;
    Property EOLIsSignificant : Boolean Read FEOLIsSignificant Write FEOLIsSignificant;
  end;

  TDelphiParser = class(TStringsParser)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CaseSensitive;
  end;

  TDFMParser = class(TStringsParser)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CaseSensitive;
  end;

  TVBScriptParser = class(TStringsParser)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CaseSensitive;
  end;

  TPythonParser = class(TStringsParser)
  public
    constructor Create(AOwner: TComponent); override;
    procedure InitPythonSyntax;

    function ParseUniPythonStrConstEnd(Achar: char): integer;
    function ParsePythonStrConstEnd: integer;
    function ParsePythonCStrConstEnd: integer;
    function ParsePythonStrConst: integer;
    function ParsePythonCStrConst: integer;
  end;

  TJavaScriptParser = class(TStringsParser)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CaseSensitive;
  end;

  TPerlParser = class(TStringsParser)
  private
    FStringFinalWord  : String;
    FMultiLineCharSet : TCharSet;

    Procedure WaitForToken;
    Procedure ParserToken;
    Procedure AppendCharSet( Var ACharSet : TCharSet; Const AText : String );

    Function ParsePerlConst : Integer;
    Function ParsePerlConst1 : Integer;
    Function ParsePerlComment : Integer;
    Function ParsePerlIdentifier : Integer;
    Function ParsePerlStrConst(const Ch: char): integer;
    Function ParseMultiLineStringEnd : Integer;
    Function ParseMultiLineString : Integer;
  public
    Procedure InitPerlSyntax;
    Constructor Create(AOwner: TComponent); override;
  published
    property CaseSensitive;
  end;

  TSqlParser = class(TStringsParser)
  private
    function ParseOracleComment: Integer;
  public
    procedure InitSqlSyntax;
    constructor Create(AOwner: TComponent); override;
  published
    property CaseSensitive;
  end;

  THTMLParser = class(TStringsParser)
  protected
    function ParseHTMLTag: Integer;
    function ParseHTMLComment: Integer;
    function ParseHTMLCommentEnd: Integer;
    function ParseHtmlParam: integer;
    function ParseHTMLTagEnd: integer;
  public
    procedure InitHTMLSyntax;
    constructor Create(AOwner: TComponent); override;
  published
    property CaseSensitive;
  end;

  TCParser = class(TStringsParser)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CaseSensitive;
  end;

  TCPPParser = class(TCParser)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CaseSensitive;
  end;

  TDCIDStringConvert = class
  private
    FStrings: TStringList;
    FIDS: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    function IDToString(ID: Integer): string;
    function StringToID(const Str: string): Integer;
  end;

  {-------------------------------------------------------------}

procedure Register;
function ParseCharSetDef(const S: string): TCharSet;
procedure CreateINTsForDir(const APath: string);
procedure CreateIntFile(const FName: string);
function SearchNotResourcedStrings(const Path, ResultFile, ABadFiles: string;
  ASubFolders: boolean): boolean;
function LoadAndParseIfDefs(const FileName, ADefines, AIgnoreDefines, InclFolders: string): string;
function GetFloatFromString(const s: string): extended;

function DCRemoveIfDefs(const InputString, ADefines, AIgnoreDefines, InclFolders: string;
  InputStrIsFileName: boolean): string;
function DCRemoveIfDefsEx(const InputString, ADefines, AIgnoreDefines, InclFolders: string;
  InputStrIsFileName: boolean; AFileConfirm: TDCFileConfirm): string;

const
  HASHSIZE = 256;

{-------------------------------------------------------------}

Procedure DCIncPtr( Var P : PChar );

{-------------------------------------------------------------}

implementation

{-------------------------------------------------------------}

procedure DCIncPtr(var P: PChar);
begin
  {$IFDEF DCMBCS}
  if (SysLocale.FarEast) and (P^ in LeadBytes) then
    inc(P, 2)
  else
    inc(P);
  {$ELSE}
  inc(P);
  {$ENDIF}
end;

{-------------------------------------------------------------}

function ResWordHash(const s: string): integer;
var
  p: pchar;
  c: integer;
  slen: integer;
begin
  slen := length(s) - 1;
  result := slen;
  p := pointer(s);
  while slen >= 0 do
  begin
    c := integer(p^);
    if c in [ord('a')..ord('z')] then
      c := c - (ord('a') - ord('A')); // uppercase

    result := (result xor c) shl 1;
    dec(slen);
    DCIncPtr(p);
  end;
  result := cardinal(result shr 1) mod HASHSIZE;
end;

{-------------------------------------------------------------}

function GetFloatFromString(const s: string): extended;
var
  SaveSeparator: char;
begin
  SaveSeparator := DecimalSeparator;
  try
    DecimalSeparator := '.';
    result := StrToFloat(s);
  finally
    DecimalSeparator := SaveSeparator;
  end;
end;

{-------------------------------------------------------------}

//  cValidChar = [#9, #32..#255];

function IsValidChar(const c: char): boolean;
begin
  result := (c >= #32) or (c = #9);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.DoGetColorData(AToken: Integer; const ATokenStr: string;
  var AColorData: string);
var
  Delta: Integer;
begin
  if Assigned(FOnGetTextStyle) then
  begin
    FOnGetTextStyle(Self, AToken, ATokenStr, AColorData);
    Delta := Length(AColorData) - Length(ATokenStr);
    if Delta < 0 then
      SetLength(AColorData, Length(ATokenStr))
    else if Delta > 0 then
    begin
      SetLength(AColorData, Length(ATokenStr));
      FillChar(AColorData[Length(AColorData) + 1], Delta, AToken);
    end;
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.GetErrorDesc: string;
begin
  Result := '';
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.ErrorFmt(const ErrorStr: string; const Args: array of const);
begin
  with GetErrorPoint do
    dcdreamLib.ErrorFmt(ErrorStr + Format(SErrCharPos, [Y, X]) + GetErrorDesc, Args);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.Error(const ErrorStr: string);
begin
  ErrorFmt(ErrorStr, ['']);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.CheckNextChar(C: Char);
begin
  NextValidToken;
  CheckChar(C);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.CheckChar(C: Char);
begin
  if not IsTokenChar(C) then
    ErrorFmt(ResStr(SCharExpected), [C]);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.CheckNextResWord(AResWordID: Integer);
begin
  if (NextValidToken <> tokResWord) or (ResWordID <> AResWordID) then
    ErrorFmt(ResStr(SSymbolExpected), [SortedResWords[AResWordID]]);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.CheckResWord(AResWordID: Integer);
begin
  if (Token <> tokResWord) or (ResWordID <> AResWordID) then
    ErrorFmt(ResStr(SSymbolExpected), [SortedResWords[AResWordID]]);
end;

{-------------------------------------------------------------}

function TCustomDCParser.GetInternalState: Integer;
begin
  Result := FTokenList.Count - 1;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.SetInternalState(Value: Integer);
var
  i: Integer;
begin
  with FTokenList do
  begin
    if Value >= Count then
      Error(SErrFutureState);
    TokenDataToState( TTokenData( Items[Value] ) );
    for i := Count - 1 downto Value do
      Items[i].Free;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.SetCaseSensitive(Value: boolean);
begin
  if FCaseSensitive <> Value then
  begin
    FCaseSensitive := Value;
    OnChange(self);
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.SkipToResWord(ResWordID: Integer): boolean;
begin
  while not (ParserEof or IsTokenResWord(ResWordID)) do
    NextToken;
  Result := Token <> tokEof;
end;

{-------------------------------------------------------------}

function TCustomDCParser.SkipToChar(C: Char): boolean;
begin
  while not (ParserEof or IsTokenChar(C)) do
    NextToken;
  Result := Token <> tokEof;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParserEOF: boolean;
begin
  result := token = tokEof;
end;

{-------------------------------------------------------------}

function TCustomDCParser.IsTokenResWord(ResWord: Integer): boolean;
begin
  Result := (Token = tokResWord) and (ResWordID = ResWord);
end;

{-------------------------------------------------------------}

Function TCustomDCParser.IsPeekTokenResWord( ResWord : Integer ) : Boolean;
begin
  PushState;
  NextToken;
  Result := IsTokenResWord( ResWord );
  PopState;
end;

{-------------------------------------------------------------}

function TCustomDCParser.IsNextTokenChar(C: Char): boolean;
begin
  NextToken;
  Result := IsTokenChar(C);
end;

{-------------------------------------------------------------}

function TCustomDCParser.IsNextTokenResWord(ResWord: Integer): boolean;
begin
  NextToken;
  Result := IsTokenResWord(ResWord);
end;

{-------------------------------------------------------------}

Function TCustomDCParser.IsTokenChar( C : Char ) : Boolean;
begin
  Result := ( Token = tokWhiteChar ) And ( FTokenPtr^ = C );
end;

{-------------------------------------------------------------}

Function TCustomDCParser.IsPeekTokenChar( C : Char ) : Boolean;
begin
  PushState;
  NextToken;
  Result := IsTokenChar( C );
  PopState;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.SetLinePtr(V: PChar);
begin
  if V <> FSourcePtr then
  begin
    //    FNeedTokenStr:=True;
    FSourcePtr := V;
    FLinePtr := V;
    FTokenPtr := V;
    FToken := -1;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.ClearParserStates;
var
  i: Integer;
begin
  for I := 0 to FParserStates.Count - 1 do
    Dispose(PParserState(FParserStates[i]));
  FParserStates.Clear;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.CheckEnoughStates(MaxState: Integer);
var
  ParserState: PParserState;
begin
  while MaxState >= FParserStates.Count do
  begin
    New(ParserState);
    FillChar(ParserState^, SizeOf(TParserState), 0);
    FParserStates.Add(ParserState);
  end;
end;

{-------------------------------------------------------------}

const
  NormalState : array[0..0] of integer = (psNormal);

procedure TCustomDCParser.RegisterNormalProc(const ACharSet: TCharSet; AProc: TParseProc);
begin
  RegisterProc(NormalState {[psNormal]}, ACharSet, AProc);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.RegisterProc(const ActiveInStates: array of Integer;
  const ACharSet: TCharSet; AProc: TParseProc);
var
  i, j: Integer;
begin
  CheckEnoughStates(MaxIntValue(ActiveInStates));
  for j := 0 to 255 do
    if Char(j) in ACharSet then
      for i := Low(ActiveInStates) to High(ActiveInStates) do
        PParserState(FParserStates[ActiveInStates[i]])[j] := TMethod(AProc);
end;

{-------------------------------------------------------------}

function TCustomDCParser.SkipToCharOrEol(c: char): boolean;
var
  sptr: pchar;
  spc: integer;
  _c: integer;
begin
  sptr := FSourcePtr;
  spc := integer(sptr^);
  _c := integer(c);

  while (spc <> _c) and IsValidChar(char(spc)) do
  begin
    DCIncPtr(sPtr);
    spc := integer(sptr^);
  end;

  FSourcePtr := sPtr;
  Result := spc = _c;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseComment: integer;
var
  _state: integer;
begin
  _state := psComment;

  if SkipToCharOrEol('}') then
  begin
    DCIncPtr(FSourcePtr);
    _state := psNormal;
  end;

  fParserState := _state;
  result := tokComment;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.SkipHexDigits;
var
  sptr: pchar;
begin
  sptr := fSourcePtr;
  while sptr^ in cHexDigit do
    DCIncPtr(sPtr);

  fSourcePtr := sptr;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseDefines: integer;
begin
  result := tokPreProcessor;
  DCIncPtr(fSourcePtr);
  fParserState := psNormal;

  while IsValidChar(FSourcePtr^) do
  begin
    if (FSourcePtr^ = '/') and ((FSourcePtr + 1)^ in ['/', '*']) then
      break
    else if (fSourcePtr^ = '\') and ((fSourcePtr + 1)^ = #0) then
    begin
      fParserState := psDefine;
      DCIncPtr(FSourcePtr);
      break;
    end;
    DCIncPtr(FSourcePtr);
  end;

end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseHexConst: Integer;
begin
  DCIncPtr(FSourcePtr);
  SkipHexDigits;
  Result := tokInteger;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseJHexConst: Integer;
begin
  if (FSourcePtr + 1)^ = 'x' then
  begin
    DCIncPtr(FSourcePtr);
    if (FSourcePtr + 1)^ in cHexDigit then
      Result := ParseHexConst
    else
      result := tokWhiteChar;
  end
  else
    result := ParseNumConst;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseCHexConst: Integer;
begin
  result := ParseJHexConst;
  if result = tokInteger then
    ParseCSuffixes;
end;

{-------------------------------------------------------------}

function SkipDigitsEx(sptr: pchar): pchar;
begin
  while sptr^ in cDigit do
    DCIncPtr(sPtr);

  result := sptr;
end;

{-------------------------------------------------------------}

function ParseScaleFactor(sptr: pchar): pchar;
begin
  if sptr^ in ['E', 'e'] then
  begin
    DCIncPtr(sptr);
    if sptr^ in ['+', '-'] then
      DCIncPtr(sptr);
    sptr := SkipDigitsEx(sptr);
  end;
  result := sptr;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseNumConst: integer;
var
  sptr: pchar;
begin
  sptr := fSourcePtr;
  DCIncPtr(sptr);
  sptr := SkipDigitsEx(sptr);
  result := tokFloat;
  if (sptr^ = '.') and ((sptr + 1)^ in cDigit) then
  begin
    DCIncPtr(sptr);
    sptr := SkipDigitsEx(sptr);
    sptr := ParseScaleFactor(sptr);
  end
  else if sptr^ in ['E', 'e'] then
    sptr := ParseScaleFactor(sptr)
  else
    result := tokInteger;

  fSourcePtr := sptr;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.SkipDigits;
begin
  fSourcePtr := SkipDigitsEx(fSourcePtr);
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseWhiteChar: integer;
begin
  DCIncPtr(FSourcePtr);
  result := tokWhiteChar;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseIdentifier: integer;
var
  sptr: pchar;
begin
  sptr := fSourcePtr;
  repeat
    DCIncPtr(sptr);
  until not (sptr^ in ['0'..'9', 'A'..'Z', '_', 'a'..'z']);

  fSourcePtr := sptr;
  result := tokResWord;
  if not FindResWord(TokenString) then
    result := tokSymbol;
  //  result := ParseIdentifierEx(COtherIdentChars);
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseIdentifierEx(const Charset: TCharSet): integer;
var
  sptr: pchar;
begin
  sptr := fSourcePtr;
  repeat
    DCIncPtr(sptr);
  until not (sptr^ in Charset);

  fSourcePtr := sptr;
  result := tokResWord;
  if not FindResWord(TokenString) then
    result := tokSymbol;
end;

{-------------------------------------------------------------}

function TCustomDCParser._checksensitiveresword(const s: string): boolean;
begin
  result := fIntWords[fResWordID] = s;
end;

{-------------------------------------------------------------}

function TCustomDCParser.FindResWord(const s: string): boolean;
var
  i: integer;
begin
  result := false;

  with TStringList(fHashList.List[ResWordHash(s)]) do
    if Count > 0 then
    begin
      i := IndexOf(s);
      if i >= 0 then
      begin
        fResWordID := integer(Objects[i]);
        result := true;
        if fCaseSensitive then
          result := _checksensitiveresword(s);
      end;
    end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.NextWordIsEnd: boolean;
var
  StrTmp: string[3];
  _Len: integer;
begin
  _Len := StrLen(FSourcePtr);
  Result := _Len > 2;
  if Result then
  begin
    SetString(StrTmp, FSourcePtr, 3);
    Result := CompareText(StrTmp, 'end') = 0; //don't resource
    if Result then
    begin
      if CaseSensitive then
        Result := StrTmp = 'end'; //don't resource
      Result := Result and not ((FSourcePtr - 1)^ in cFirstAsmIdentChar);
      if _Len > 3 then
        Result := Result and (not ((FSourcePtr + 3)^ in cOtherIdentChars));
    end;
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseAsm: integer;

  function isBeginComment: boolean;
  begin
    case FSourcePtr^ of
      '(':
        begin
          Result := (FSourcePtr + 1)^ = '*';
          if Result then
            FParserState := psAsmComment2;
        end;
      '/':
        begin
          Result := (FSourcePtr + 1)^ = '/';
          if Result then
            FParserState := psAsmCComment;
        end;
      '{':
        begin
          Result := true;
          FParserState := psAsmComment;
        end;
      else
        Result := false;
    end;
  end;

begin
  Result := tokAssembler;
  while (FSourcePtr^ in cWhiteChar) do
  begin
    if NextWordIsEnd then
    begin
      FParserState := psNormal;
      break;
    end
    else if isBeginComment then
      break;
    DCIncPtr(FSourcePtr);
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseAsmComment: Integer;
begin
  Result := ParseComment;
  if FParserState = psNormal then
    FParserState := psAsm
  else if FParserState = psComment then
    FParserState := psAsmComment;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseAsmCComment: Integer;
begin
  Result := ParseCComment;
  if Result = tokWhiteChar then
    Result := tokAssembler;
  FParserState := psAsm;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseAsmComplexComment: Integer;
begin
  Result := ParseComplexComment;
  if Result = tokWhiteChar then
    Result := tokAssembler
  else
  begin
    if FParserState = psNormal then
      FParserState := psAsm
    else if FParserState = psComment2 then
      FParserState := psAsmComment2
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseAsmComplexCommentEnd: Integer;
begin
  Result := ParseComplexCommentEnd;
  if FParserState = psNormal then
    FParserState := psAsm
  else if FParserState = psComment2 then
    FParserState := psAsmComment2
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseDelphiIdentifier: Integer;
begin
  Result := ParseIdentifier;
  if Result = tokResWord then
    if FParserState = psNormal then
      if CompareText(TokenString, 'asm') = 0 then //don't resource
        FParserState := psAsm;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseVBIdentifier: Integer;
begin
  Result := ParseIdentifier;
  if (Result = tokResWord) and (FResWordID = FSpecialResWordID) then
    Result := RestIsComment;
end;

{-------------------------------------------------------------}

function TModuleParser.IgnoreDefinesAsLine:String;
begin
  Result:=DCUnparseStringEx(IgnoreDefines,';',False);
end;

{-------------------------------------------------------------}

procedure TModuleParser.SetIgnoreDefines(V: TStrings);
begin
  FIgnoreDefines.Assign(V);
end;

{-------------------------------------------------------------}

function TModuleParser.TokenString: string;
var
  P: PChar;
  i: integer;
  j: integer;
  s: string;
  Skip: boolean;
begin
  result := inherited TokenString;
  if Token = tokString then
  begin
    s := result;
    Result := '';
    skip := false;
    i := 1;
    while i <= length(s) do
    begin
      case s[i] of
        '''':
          begin
            if skip and (i < length(s)) and (s[i + 1] = '''') then
              Result := Result + s[i];
            skip := not skip;
          end;
        '#':
          if not skip then
          begin
            P := FTokenPtr + i;
            j := 0;
            while P^ in ['0'..'9'] do
            begin
              j := j * 10 + Ord(P^) - Ord('0');
              inc(P);
              inc(i);
            end;
            Result := Result + Chr(j);
          end
          else
            Result := Result + s[i];
        else
          Result := Result + s[i];
      end;
      inc(i);
    end;
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.TokenString: string; // upgrade for the string constant case
begin
  {  If FNeedTokenStr then
    begin
      FNeedTokenStr:=False;}
  SetString(Result, FTokenPtr, FSourcePtr - FTokenPtr);
  {  end;
    Result:=FTokenStr;}
end;

{-------------------------------------------------------------}

function TCustomDCParser.RestIsComment: integer;
var
  sptr: pchar;
begin
  sptr := FSourcePtr;
  while IsValidChar(sptr^) do
    DCIncPtr(sptr);
  fSourcePtr := sptr;
  Result := tokComment;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseEol(C: Char): Integer;
var
  sptr: pchar;
begin
  {  SendDebug('L:'+IntToStr(FLinePos)+' C:'+IntToStr(CharPos)+
      ' LinePtr:'+IntToStr(Integer(FLinePtr))+' SourcePtr:'+IntToStr(Integer(FSourcePtr)));}
  inc(FLinePos);
  sptr := FSourcePtr;
  DCIncPtr(sptr);
  if sptr^ = C then
    DCIncPtr(sptr);
  FLinePtr := sptr;
  fSourcePtr := sptr;
  Result := -1;
end;

{-------------------------------------------------------------}

function TCustomDCParser.Parse1013Eol: Integer;
begin
  Result := ParseEol(#13);
end;

{-------------------------------------------------------------}

function TCustomDCParser.Parse1310Eol: Integer;
begin
  Result := ParseEol(#10);
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseCComment: Integer;
begin
  DCIncPtr(FSourcePtr);
  Result := tokWhiteChar;
  if FSourcePtr^ = '/' then
    Result := RestIsComment;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseVBHexConst: Integer;
begin
  DCIncPtr(FSourcePtr);
  result := tokWhiteChar;
  if FSourcePtr^ in ['H', 'h'] then
  begin
    DCIncPtr(FSourcePtr);
    SkipHexDigits;
    Result := tokInteger;
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseComplexComment: Integer;
begin
  DCIncPtr(FSourcePtr);
  Result := tokWhiteChar;
  if FSourcePtr^ = '*' then
  begin
    DCIncPtr(FSourcePtr);
    Result := ParseComplexCommentEnd;
  end
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseJscrComment: Integer;
begin
  DCIncPtr(FSourcePtr);
  case FSourcePtr^ of
    '*':
      begin
        DCIncPtr(FSourcePtr);
        Result := ParseJScrCommentEnd;
      end;
    '/':
      Result := RestIsComment
    else
      Result := tokWhiteChar;
  end;
  if FParserState = psDefine then
    FParserState := psNormal;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.InitEolState(State: Integer);
begin
  RegisterProc([State], [#13], Parse1310Eol);
  RegisterProc([State], [#10], Parse1013Eol);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.InitCommon;
begin
  RegisterNormalProc( cWhiteChar, ParseWhiteChar);
  InitEolState(psNormal);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.InitJScrSyntax;
begin
  //Options:=[poParseResWords{,poCaseSens}];
  StrArrayToStrings(ResWords, SJScrResWords);
  InitJSSyntax;
  //RegisterNormalProc([''''],ParseStrConst);
  RegisterNormalProc( cDigit, ParseNumConst);
  RegisterNormalProc( ['0'], ParseJHexConst);
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseCStrConst: Integer;
var
  i: integer;
  ch: char;
begin
  ch := FSourcePtr^;
  Result := tokString;
  DCIncPtr(FSourcePtr);
  while SkipToCharOrEol(ch) do
  begin
    i := 0;
    while (FSourcePtr - i - 1)^ = '\' do
      inc(i);
    if i mod 2 = 0 then
    begin
      DCIncPtr(FSourcePtr);
      break;
    end
    else
      DCIncPtr(FSourcePtr);
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseCNumConst: integer;
begin
  result := ParseNumConst;
  if result = tokInteger then
    ParseCSuffixes;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.ParseCSuffixes;
var
  i: integer;
  len: integer;
begin
  for i := 0 to cCppSuffixesSize - 1 do
  begin
    len := length(cCppSuffixes[i]);
    if Copy(FSourcePtr, 1, len) = cCppSuffixes[i] then
    begin
      inc(FSourcePtr, len);
      break;
    end;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.InitJSSyntax;
begin
  InitCommon;
  RegisterNormalProc( ['"'], ParseCStrConst);
  RegisterNormalProc( [''''], ParseCStrConst);
  RegisterNormalProc( cFirstIdentChar, ParseIdentifier);
  RegisterNormalProc( ['/'], ParseJScrComment);
  RegisterProc([psDefine], cValidChar - ['/'], ParseDefines);
  RegisterProc([psDefine], ['/'], ParseJScrComment);
  RegisterProc([psComment2], cWhiteChar, ParseJscrCommentEnd);
  InitEolState(psComment2);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.InitCSyntax;
begin
  StrArrayToStrings(ResWords, SCResWords);
  InitJSSyntax;
  RegisterNormalProc( ['#'], ParseDefines);
  RegisterNormalProc( cDigit, ParseCNumConst);
  RegisterNormalProc( ['0'], ParseCHexConst);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.InitCppSyntax;
begin
  InitCSyntax;
  StrArrayToStrings(ResWords, SCppResWords);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.InitDelphiSyntax;
begin
  //  Options:=[poParseResWords];
  StrArrayToStrings(ResWords, SDelphiResWords);
  InitCommon;
  RegisterNormalProc( [''''], ParseStrConst);
  RegisterNormalProc( ['{'], ParseComment);
  RegisterProc([psComment], cWhiteChar, ParseComment);
  RegisterNormalProc( cFirstIdentChar, ParseDelphiIdentifier);
  RegisterNormalProc( ['$'], ParseHexConst);
  RegisterNormalProc( cDigit, ParseNumConst);
  RegisterNormalProc( ['/'], ParseCComment);
  RegisterNormalProc( ['('], ParseComplexComment);
  RegisterNormalProc( ['#'], ParseCharConst);
  RegisterProc([psComment2], cWhiteChar, ParseComplexCommentEnd);
  RegisterProc([psAsm], cWhiteChar, ParseAsm);
  RegisterProc([psAsm, psAsmCComment], ['/'], ParseAsmCComment);
  RegisterProc([psAsm], ['{'], ParseAsmComment);
  RegisterProc([psAsmComment], cWhiteChar, ParseAsmComment);
  RegisterProc([psAsm], ['('], ParseAsmComplexComment);
  RegisterProc([psAsmComment2], cWhiteChar, ParseAsmComplexCommentEnd);
  InitEolState(psComment2);
  InitEolState(psComment);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.InitDFMSyntax;
begin
  StrArrayToStrings(ResWords, SDFMResWords);
  InitCommon;
  RegisterNormalProc( [''''], ParseStrConst);
  RegisterNormalProc( ['{'], ParseComment);
  RegisterProc([psComment], cWhiteChar, ParseComment);
  RegisterNormalProc( cFirstIdentChar, ParseDelphiIdentifier);
  RegisterNormalProc( cDigit, ParseNumConst);
  RegisterNormalProc( ['/'], ParseCComment);
  RegisterNormalProc( ['('], ParseComplexComment);
  RegisterNormalProc( ['#'], ParseCharConst);
  RegisterProc([psComment2], cWhiteChar, ParseComplexCommentEnd);
  InitEolState(psComment2);
  InitEolState(psComment);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.InitVBSyntax;
begin
  //  Options:=[poParseResWords];
  StrArrayToStrings(ResWords, SVBScrResWords);
  SortedResWords.Find('REM', FSpecialResWordID); //don't resource
  InitCommon;
  RegisterNormalProc( cDigit, ParseNumConst);
  RegisterNormalProc( cFirstIdentChar, ParseVBIdentifier);
  RegisterNormalProc( ['"'], ParseVBStrConst);
  RegisterNormalProc( [''''], RestIsComment);
  RegisterNormalProc( ['&'], ParseVBHexConst);
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseComplexCommentEnd: Integer;
begin
  Result := ParseUniComplexCommentEnd(')');
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseJScrCommentEnd: Integer;
begin
  Result := ParseUniComplexCommentEnd('/');
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseUniComplexCommentEnd(C: Char): Integer;
begin
  while true do
    if SkipToCharOrEol('*') then
    begin
      DCIncPtr(FSourcePtr);
      if FSourcePtr^ = C then
      begin
        FParserState := psNormal;
        DCIncPtr(FSourcePtr);
        break;
      end;
    end
    else
    begin
      FParserState := psComment2;
      break;
    end;
  Result := tokComment;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseCharConst: Integer;
begin
  DCIncPtr(FSourcePtr);
  if FSourcePtr^ = '$' then
  begin
    DCIncPtr(FSourcePtr);
    SkipHexDigits;
  end
  else
    SkipDigits;

  case FSourcePtr^ of
    '#': ParseCharConst;
    '''': ParseStrConst;
  end;
  Result := tokString;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseStrConst: Integer;
begin
  Result := ParseUniStrConst('''');
  if FSourcePtr^ = '#' then
    ParseCharConst;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseUniStrConst(C: Char): Integer;
var
  cfound: boolean;
begin
  Result := tokString;
  repeat
    DCIncPtr(FSourcePtr);
    cfound := SkipToCharOrEol(C);
    if cfound then
      DCIncPtr(FSourcePtr);
  until not cfound or (FSourcePtr^ <> C);
  fUnterminated := not cfound;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ParseVBStrConst: Integer;
begin
  Result := ParseUniStrConst('"');
end;

{-------------------------------------------------------------}

function TCustomDCParser.PeekTokenStr: string;
begin
  PushState;
  Result := NextTokenStr;
  PopState;
end;

{-------------------------------------------------------------}

function TCustomDCParser.PeekToken: Integer;
begin
  PushState;
  Result := NextToken;
  PopState;
end;

{-------------------------------------------------------------}

function TCustomDCParser.NextTokenStr: string;
begin
  NextToken;
  Result := TokenString;
end;

{-------------------------------------------------------------}

function TCustomDCParser.SkipTokens(Number: Integer): Integer;
var
  i: Integer;
begin
  Result := Token;
  for I := 1 to Number do
    Result := NextToken;
end;

{-------------------------------------------------------------}

function TCustomDCParser.NextToken: integer;
begin
  result := SimpleNextToken;
end;

{-------------------------------------------------------------}

function TCustomDCParser.NextValidToken: Integer;
begin
  repeat
    Result := NextToken;
  until Token <> tokComment;
end;

{-------------------------------------------------------------}

function TCustomDCParser.NextValidTokenStr: string;
begin
  NextValidToken;
  Result := TokenString;
end;

{-------------------------------------------------------------}

function TCustomDCParser.PeekValidTokenStr: string;
begin
  PushState;
  Result := NextValidTokenStr;
  PopState;
end;

{-------------------------------------------------------------}

function TCustomDCParser.SimpleNextToken: Integer;
var
  sptr: pchar;
  spc: integer;
begin
  Result := -1;
  repeat
    sptr := fSourcePtr;
    FTokenPtr := sptr;
    spc := integer(sptr^);
    if spc = 0 then
    begin
      Result := 0;
      break;
    end;

    with PParserState(FParserStates.Items[FParserState])[spc] do
      if Code <> nil then
        Result := CallMethod(Data, Code)
      else
        DCIncPtr(fSourcePtr);
  until Result <> -1;

  FToken := Result;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser._Fill2(const StrData: string; AColorData: pchar);
var
  TokenStr: string;
  ColorDataStr: string;
  tstart: integer;
  tslen: integer;
begin
  while SimpleNextToken <> tokEOF do
  begin
    tstart := TokenPtr - pchar(pointer(StrData)) + 1;
    tslen := SourcePtr - TokenPtr;

    TokenStr := Copy(StrData, tstart, tslen);
    SetLength(ColorDataStr, tslen);
    FillChar(pointer(ColorDataStr)^, tslen, Token);
    DoGetColorData(Token, TokenStr, ColorDataStr);

    Move(pointer(ColorDataStr)^, (AColorData + tstart - 1)^, tslen);
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.ColorString(const StrData: string;
  InitState: Integer; var AColorData: string): Integer;
var
  slen: integer;
  pColorData: integer;
begin
  if (StrData = '') or (AColorData = '') then
    Result := InitState
  else
  begin
    ParserState := InitState;
    LinePtr := pchar(pointer(StrData));
    slen := length(StrData);
    if length(AColorData) <> slen then
      SetLength(AColorData, slen);

    if Assigned(fOnGetTextStyle) then
      _fill2(StrData, pchar(pointer(AColorData)))
    else
    begin
      pColorData := integer(pointer(AColorData)) - integer(pointer(StrData));
      while SimpleNextToken <> tokEOF do
        FillChar((TokenPtr + pColorData)^, SourcePtr - TokenPtr, Token);
    end;
    Result := ParserState;
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.GetErrorPoint: TPoint;
begin
  Result := Point(TokenCharPos + 1, FLinePos + 1);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.StateToTokenData( T : TTokenData );
begin
  With T Do
  begin
    IfDefLevel := FIfDefLevel;
    SkipTokens := FSkipTokens;
    Token := FToken;
    ParserState := FParserState;
    LinePos := FLinePos;
    CharPos := Self.CharPos;
    TokenCharPos := Self.TokenCharPos;
    LinePtr := FLinePtr;
    ResWordID := fResWordID;
  end;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.UpdateLinePtr;
begin
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.TokenDataToState( T : TTokenData );
begin
  With T Do
  begin
    FIfDefLevel := IfDefLevel;
    FSkipTokens := SkipTokens;
    FLinePos := LinePos;
    Self.LinePtr := LinePtr;
    UpdateLinePtr;
    FSourcePtr := FLinePtr + CharPos;
    FTokenPtr := FLinePtr + TokenCharPos;
    FToken := Token;
    FParserState := ParserState;
    fResWordID := ResWordID;
  end;
end;

{-------------------------------------------------------------}

Function TCustomDCParser.PushState: Integer;
begin
  With FTokenList Do
  begin
    StateToTokenData( TTokenData( Add ) );
    Result := Count - 1;
  end;
end;

{-------------------------------------------------------------}

Function TCustomDCParser.PopState : Integer;
begin
  While SinglePop Do ;
  Result := FToken;
end;

{-------------------------------------------------------------}

Function TCustomDCParser.SoftPushState : Integer;
Var
  NewItem : TTokenData;
begin
  with FTokenList do
  begin
    NewItem := TTokenData( Add );
    NewItem.SoftPush := True;
    StateToTokenData( NewItem );
    Result := Count - 1;
  end;
end;

{-------------------------------------------------------------}

Function TCustomDCParser.SoftPopState : Boolean;
Var
  I : Integer;
begin
  With TokenList Do
  begin
    I := Count - 1;

    If I < 0 Then
      Error( STokenListEmpty );
    Result := TTokenData( Items[I] ).SoftPush;
    If Result Then
    begin
      SinglePop;
      Exit;
    end;
    For I := I DownTo 0 Do
      If TTokenData( Items[I] ).SoftPush Then
      begin
        TokenDataToState( TTokenData( Items[I] ) );
        Exit;
      end;
    Error( STokenListEmpty );
  end;
end;

{-------------------------------------------------------------}

Function TCustomDCParser.SinglePop : Boolean;
Var
  Item : TTokenData;
begin
  With TokenList Do
  begin
    If Count = 0 Then
      Error( STokenListEmpty );
    Item := TTokenData( Items[ Count - 1 ] );
  end;
  Item.ProcessSinglePop( Self );
  TokenDataToState( Item );
  Result := Item.SoftPush;
  Item.Free;
end;

{-------------------------------------------------------------}

Procedure TCustomDCParser.OnChange(Sender: TObject);
begin
  UpdateSettings;
  Notifiers.NotifyEvents(Self, 0, 0);
end;

{-------------------------------------------------------------}

function TCustomDCParser.GetTokenDataClass: TCollectionItemClass;
begin
  Result := TTokenData;
end;

{-------------------------------------------------------------}

constructor TCustomDCParser.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited;
  FToken := -1;
  //  FNeedTokenStr:=True;
  FParserStates := TList.Create;
  FTokenList := TCollection.Create( GetTokenDataClass );
  FResWords := TStringList.Create;
  TStringList(FResWords).OnChange := OnChange;
  FIntWords := TStringList.Create;
  with TStringList(FIntWords) do
  begin
    Sorted := True;
    Duplicates := dupIgnore;
  end;

  fHashList := TList.Create;
  for i := 0 to HASHSIZE - 1 do
    fHashList.Add(CreateSortedStringList);
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.SetResWords(V: TStrings);
begin
  FResWords.Assign(V);
end;

{-------------------------------------------------------------}

{procedure TCustomDCParser.SetOptions(V:TParserOptions);
begin
  If FOptions<>V then
  begin
    FOptions:=V;
    UpdateSettings;
  end;
end;}

{-------------------------------------------------------------}

procedure TCustomDCParser.Loaded;
begin
  inherited;
  UpdateSettings;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.UpdateSettings;
var
  i: Integer;
  TempStr: string;
begin
  if ([csReading, csLoading] * ComponentState) <> [] then
    exit;

  FIntWords.Clear;
  for i := FResWords.Count - 1 downto 0 do
  begin
    TempStr := Trim(FResWords[i]);
    if TempStr <> '' then
      fIntWords.Add(TempStr);
  end;

  for i := 0 to HASHSIZE - 1 do
    TStringList(fHashList[i]).Clear;

  for i := fIntWords.Count - 1 downto 0 do
  begin
    TempStr := fIntWords[i];
    TStringList(fHashList[ResWordHash(TempStr)]).AddObject(TempStr, pointer(i));
  end;
end;

{-------------------------------------------------------------}

destructor TCustomDCParser.Destroy;
begin
  FResWords.Free;
  FIntWords.Free;
  ClearParserStates;
  FParserStates.Free;
  FTokenList.Free;
  FreeList(fHashList,fHashList);
  inherited;
end;

{-------------------------------------------------------------}

constructor TJavaScriptParser.Create(AOwner: TComponent);
begin
  inherited;
  CaseSensitive := true;
  InitJScrSyntax;
end;

{-------------------------------------------------------------}

constructor TVBScriptParser.Create(AOwner: TComponent);
begin
  inherited;
  InitVBSyntax;
end;

{-------------------------------------------------------------}

constructor TPythonParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitPythonSyntax;
end;

{-------------------------------------------------------------}

function TPythonParser.ParseUniPythonStrConstEnd(Achar: char): integer;
begin
  while true do
    if SkipToCharOrEol(Achar) then
    begin
      DCIncPtr(FSourcePtr);
      if (FSourcePtr^ = Achar) and ((FSourcePtr + 1)^ = Achar) then
      begin
        FParserState := psNormal;
        inc(FSourcePtr, 2);
        break;
      end;
    end
    else
    begin
      if Achar = '''' then
        FParserState := psString
      else
        FParserState := psCString;
      break;
    end;
  Result := tokString;
end;

{-------------------------------------------------------------}

function TPythonParser.ParsePythonStrConstEnd: integer;
begin
  result := ParseUniPythonStrConstEnd('''');
end;

{-------------------------------------------------------------}

function TPythonParser.ParsePythonCStrConstEnd: integer;
begin
  result := ParseUniPythonStrConstEnd('"');
end;

{-------------------------------------------------------------}

function TPythonParser.ParsePythonStrConst: integer;
begin
  if ((FSourcePtr + 1)^ = '''') and ((FSourcePtr + 2)^ = '''') then
  begin
    inc(FSourcePtr, 2);
    result := ParsePythonStrConstEnd
  end
  else
    result := ParseStrConst;
end;

{-------------------------------------------------------------}

function TPythonParser.ParsePythonCStrConst: integer;
begin
  if ((FSourcePtr + 1)^ = '"') and ((FSourcePtr + 2)^ = '"') then
  begin
    inc(FSourcePtr, 2);
    result := ParsePythonCStrConstEnd
  end
  else
    result := ParseCStrConst;
end;

{-------------------------------------------------------------}

procedure TPythonParser.InitPythonSyntax;
begin
  StrArrayToStrings(ResWords, SPythonResWords);
  InitCommon;
  RegisterNormalProc( cDigit, ParseNumConst);
  RegisterNormalProc( cFirstIdentChar, ParseIdentifier);
  RegisterNormalProc( ['"'], ParsePythonCStrConst);
  RegisterNormalProc( [''''], ParsePythonStrConst);
  RegisterNormalProc( ['#'], RestIsComment);
  RegisterProc([psString], cWhiteChar, ParsePythonStrConstEnd);
  RegisterProc([psCString], cWhiteChar, ParsePythonCStrConstEnd);
  InitEolState(psString);
  InitEolState(pscString);
end;

{-------------------------------------------------------------}

constructor TDelphiParser.Create(AOwner: TComponent);
begin
  inherited;
  InitDelphiSyntax;
end;

{-------------------------------------------------------------}

constructor TDFMParser.Create(AOwner: TComponent);
begin
  inherited;
  InitDFMSyntax;
end;

{-------------------------------------------------------------}

constructor TCParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CaseSensitive := true;
  InitCSyntax;
end;

{-------------------------------------------------------------}

constructor TCPPParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CaseSensitive := true;
  InitCppSyntax;
end;

{******************************************************************}

procedure TStringsParser.ValidateStrings;
begin
  if fStrings = nil then
    Error(SErrStringsNotSet);
end;

{-------------------------------------------------------------}

function TStringsParser.NextToken: Integer;
begin
  ValidateStrings;

  Result := SimpleNextToken;
  if Result = tokEof then
    if FLinePos < fStrings.Count then
    begin
      inc(FLinePos);
      UpdateLinePtr;
      If EOLIsSignificant And ( ParserState = psNormal ) Then
      begin
        Result := tokEOL;
        FToken := tokEOL;
      end
      Else
        Result := NextToken;
    end;
end;

{-------------------------------------------------------------}

procedure TStringsParser.SetLinePos(Value: Integer);
begin
  ValidateStrings;

  if (FLinePos <> Value) or (FStr <> FStrings[Value]) then
  begin
    FLinePos := Value;
    UpdateLinePtr;
  end;
end;

{-------------------------------------------------------------}

procedure TStringsParser.UpdateLinePtr;
begin
  ValidateStrings;

  if FLinePos >= FStrings.Count then
    FStr := ''
  else
    FStr := FStrings[FLinePos];
  LinePtr := PChar(FStr);
end;

{-------------------------------------------------------------}

procedure TStringsParser.ResetParser;
begin
  FLinePos := 0;
  UpdateLinePtr;
  ParserState := psNormal;
  FToken := -1;
end;

{-------------------------------------------------------------}

Procedure TStringsParser.SetStrings( AValue : TStrings );
begin
  if FStrings <> AValue then
  begin
    FStrings := AValue;
    ResetParser;
  end;
end;

{-------------------------------------------------------------}

function TCustomDCParser.GetTokenCharPos: Integer;
begin
  Result := FTokenPtr - FLinePtr;
end;

{-------------------------------------------------------------}

function TCustomDCParser.GetCharPos: Integer;
begin
  Result := FSourcePtr - FLinePtr;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.SetCharPos(Value: Integer);
begin
  FSourcePtr := PChar(FLinePtr) + Value;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.SetTokenCharPos(Value: Integer);
begin
  FTokenPtr := PChar(FLinePtr) + Value;
end;

{-------------------------------------------------------------}

procedure _Register;
begin
end;

{-------------------------------------------------------------}

procedure TModuleParser.ParseIncludeFile(const AFileName: string;
  IncludeInText: boolean);
begin
end;

{-------------------------------------------------------------}

function TModuleParser.GetSkipFlag(Level: Integer): boolean;
begin
  Result := FSkipTokens and (1 shl Level) <> 0;
end;

{-------------------------------------------------------------}

procedure TModuleParser.SetSkipFlag(Level: Integer; Value: boolean);
begin
  Level := 1 shl Level;
  if Value then
    FSkipTokens := FSkipTokens or Level
  else
    FSkipTokens := FSkipTokens and (not Level);
end;

{-------------------------------------------------------------}

function TModuleParser.NextToken: Integer;
begin
  repeat
    Result := inherited NextToken;
    if Result = tokEof then
      break;
  until (FIfDefLevel < 0) or (not SkipFlag[FIfDefLevel]);
  // maybe check if eof and FIfDefLevel>=0 then raise
end;


{-------------------------------------------------------------}

function TModuleParser.DefineIsDefined(const ADefine:String):boolean;
var
  Index:Integer;

  function DEFINEDLINUXANDVER140:boolean;
  begin
    Result:=DefineIsDefined('LINUX') AND DefineIsDefined('VER140');
  end;

begin
  If DCIsStrInStrArray(ADefine,
       [
        SDCPlatformDefine[FPlatformKind],
        SDCPlatformDefine2[FPlatformKind],
        SDCConditionalExpressions
       ]
     )
  then
    begin
      Result:=True;
      exit;
    end;

  {WriteToLog(ADefine);}

  if AnsiCompareText(ADefine,'NOT (DEFINED(LINUX) AND DEFINED(VER140))')=0 then
    Result:=not DEFINEDLINUXANDVER140
  else
  if AnsiCompareText(ADefine,'DEFINED(LINUX) AND DEFINED(VER140)')=0 then
    Result:=DEFINEDLINUXANDVER140
  else
    Result:=TStringList(FDefines).Find(ADefine, Index);
end;

{-------------------------------------------------------------}

function TModuleParser.ParseComment: Integer;
var
  index: Integer;
  NewSkipTokens: Integer;
  NewIfDefLevel: Integer;
  TempInt: Integer;

  function CompilerDirective(var Directive: Integer): boolean;
  begin
    Result := (Token in [tokSymbol, tokResword]) and
      (TStringList(FDirectives).Find(TokenString, Directive));
  end;

  procedure _ParseIncludeFile(IncludeInText: Boolean);
  var
    FileName: string;
    i: Integer;
  begin
    if SkipFlag[FIfDefLevel] or (TokenPtr^ in ['+', '-']) then //don't resource
    begin
      PopState;
      Result := inherited ParseComment;
      exit;
    end;

    SkipToCharOrEol('}');
    FileName := RemoveCharSet([''''], Trim(TokenString));
    i := Pos(' ', FileName);
    if i > 0 then
      FileName := copy(FileName, 1, i - 1);

    PopState;
    Result := inherited ParseComment;
    ParseIncludeFile(FileName, IncludeInText);
  end;

  procedure _ParseIfDef(IsIf, IsIfOpt: boolean);
    //IsIf=True if ifdef, false ifndef
    //IsIfOpt=True if ifopt

  var
    IsDefined: boolean;
    PrevSourcePtr:PChar;
    S:String;
  begin
    inc(FIfDefLevel);
    if FIfDefLevel >= MaxIfDefLevel then
      ErrorFmt(SErrMaxIfDefReached, [MaxIFDefLevel]);

    if (FIfDefLevel > 0) and (SkipFlag[FIfDefLevel - 1]) then
      SkipFlag[FIfDefLevel] := True
    else
    begin
      if IsIfOpt then
        IsDefined := True // not correctly
      else
        begin
          {---------}
          while not (FSourcePtr^ in [#0,'}']) do
          begin
            If FSourcePtr^='*' then
              begin
                PrevSourcePtr:=FSourcePtr;
                DCIncPtr(FSourcePtr);
                If FSourcePtr^=')' then
                begin
                  FSourcePtr:=PrevSourcePtr;
                  break;
                end;
              end
            else
              DCIncPtr(FSourcePtr);
          end;
          SetString(S, FTokenPtr, FSourcePtr - FTokenPtr);
          {---------}

          IsDefined := DefineIsDefined(AnsiUpperCase(Trim(S)));
        end;
      if not IsIf then
        IsDefined := not IsDefined;
      SkipFlag[FIfDefLevel] := not IsDefined;
    end;
  end;

  //SendDebug('E '+IntToStr(FIfDefLevel)+' '+IntToStr(LinePos));
  //SendDebug('I '+IntToStr(FIfDefLevel)+' '+IntToStr(LinePos));

  procedure CheckValid(const ErrorStr: string);
  begin
    if fIfDefLevel < 0 then
      ErrorFmt(SErrCompilerDirective, [ErrorStr]);
  end;

  function _SimpleNextToken: Integer;
  begin
    while FSourcePtr^ = #32 do
      DCIncPtr(FSourcePtr);
    Result := SimpleNextToken;
  end;

{var
  S:String;}

begin
  if (FSourcePtr + 1)^ = '$' then
  begin
    PushState;
    DCIncPtr(FSourcePtr);
    LinePtr := FSourcePtr + 1;
    ParserState := psNormal;
    _SimpleNextToken;
    {S:=TokenString;}
    if CompilerDirective(Index) then
    begin
      _SimpleNextToken;

      case Index of
        IDD_DEFINE:
          if (not SkipFlag[FIfDefLevel]) and
            (not TStringList(FIgnoreDefines).Find(TokenString, TempInt)) then
          begin
            FDefines.Add(TokenString);
          end;

        IDD_ELSE:
          begin
            CheckValid('$ELSE'); // don't resource
            if (FIfDefLevel <= 0) or (not SkipFlag[FIfDefLevel - 1]) then
              SkipFlag[FIfDefLevel] := not SkipFlag[FIfDefLevel];
          end;

        IDD_ENDIF:
          begin
            CheckValid('$ENDIF'); // don't resource
            dec(FIfDefLevel)
          end;

        IDD_IFEND:
          begin
            CheckValid('$IFEND'); // don't resource
            dec(FIfDefLevel)
          end;

        IDD_I:
          begin
            _ParseIncludeFile(True);
            exit;
          end;

        IDD_IFDEF,IDD_IF:
          _ParseIfDef(True, False);

        IDD_IFNDEF:
          _ParseIfDef(False, False);

        IDD_IFOPT:
          _ParseIfDef(True, True);

        IDD_INCLUDE:
          begin
            _ParseIncludeFile(True);
            exit;
          end;

        IDD_R, IDD_RESOURCE:
          begin
            _ParseIncludeFile(False);
            exit;
          end;

        IDD_UNDEF:
          begin
            if not SkipFlag[FIfDefLevel] then
              with TStringList(FDefines) do
                if Find(TokenString, Index) then
                  Delete(Index);
          end;
      end;
    end;

    NewSkipTokens := FSkipTokens;
    NewIfDefLevel := FIfDefLevel;
    PopState;
    FSkipTokens := NewSkipTokens;
    FIfDefLevel := NewIfDefLevel;
  end;

  Result := inherited ParseComment;
  //  SendDebug(Defines.CommaText);
end;

{-------------------------------------------------------------}

constructor TModuleParser.Create(AOwner: TComponent);
begin
  inherited;
  FIfDefLevel := -1;
  FDefines := CreateSortedStringList;
  FIgnoreDefines := CreateSortedStringList;
  FDirectives := CreateSortedStringList;
  StrArrayToStrings(FDirectives, cDirectives);
  with FDefines do
  begin
    {$IFDEF WIN32}
    Add('WIN32'); //don't resource
    {$ENDIF}
    {$IFDEF LINUX}
    Add('LINUX');
    {$ENDIF}
    {$IFDEF VER80}
    Add('VER80'); //don't resource
    {$ENDIF}
    {$IFDEF VER90}
    Add('VER90'); //don't resource
    {$ENDIF}
    {$IFDEF VER93}
    Add('VER93'); //don't resource
    {$ENDIF}
    {$IFDEF VER100}
    Add('VER100'); //don't resource
    {$ENDIF}
    {$IFDEF VER110}
    Add('VER110'); //don't resource
    {$ENDIF}
    {$IFDEF VER120}
    Add('VER120'); //don't resource
    {$ENDIF}
    {$IFDEF VER125}
    Add('VER125'); //don't resource
    {$ENDIF}
    {$IFDEF VER130}
    Add('VER130'); //don't resource
    {$ENDIF}
    {$IFDEF VER140}
    Add('VER140'); //don't resource
    {$ENDIF}
    {$IFDEF MSWINDOWS}
    Add('MSWINDOWS');
    {$ENDIF}
  end;
  InitDelphiSyntax;
end;

{-------------------------------------------------------------}

procedure TCustomDCParser.SetLinePos(Value: Integer);
begin
  FLinePos := Value;
end;

{-------------------------------------------------------------}

destructor TModuleParser.Destroy;
begin
  FDefines.Free;
  FDirectives.Free;
  FIgnoreDefines.Free;
  inherited;
end;

{---------TPerlParser-----------------------------------------}

constructor TPerlParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CaseSensitive := true;
  InitPerlSyntax;
end;

{-------------------------------------------------------------}

procedure TPerlParser.InitPerlSyntax;
begin
  StrArrayToStrings(ResWords, SPerlScrResWords);
  InitCommon;
  RegisterNormalProc( [''''], ParsePerlConst1 );
  RegisterNormalProc( ['"'], ParsePerlConst );
  RegisterNormalProc( ['#'], ParsePerlComment );//RestIsComment );
  RegisterNormalProc( cFirstIdentChar, ParsePerlIdentifier );
  RegisterNormalProc( cDigit, ParseNumConst );

  RegisterNormalProc( ['<'], ParseMultiLineString );
  RegisterProc( [psPerlLongString], cWhiteChar, ParseMultiLineStringEnd );
  InitEolState( psPerlLongString );
  //  RegisterNormalProc(['('],ParseComplexComment);
   // RegisterProc([psComment2],cWhiteChar,ParseComplexCommentEnd);
  //  InitEolState(psComment2);
end;

{-----------------------------------------------------------}

Function TPerlParser.ParsePerlComment : Integer;
begin
  If ( FLinePtr < FSourcePtr ) And ( ( FSourcePtr - 1 )^ = '$' ) Then
  begin
    DCIncPtr( FSourcePtr );
    Result := ParseIdentifier;
  end
  Else
    Result := RestIsComment;
end;

{-----------------------------------------------------------}

Function TPerlParser.ParsePerlIdentifier : Integer;
begin
//  IdentCharSet := [ '0'..'9', 'A'..'Z', '_', 'a'..'z' ];
//  If ( FLinePtr < FSourcePtr ) And ( ( FSourcePtr - 1 )^ In [ '@', '$', '%' ] ) Then
//    Include( IdentCharSet, '''' );
  Repeat
    DCIncPtr( FSourcePtr );
  Until Not ( FSourcePtr^ In [ '0'..'9', 'A'..'Z', '_', 'a'..'z', '''' ] );

  Result := tokResWord;
  If Not FindResWord( TokenString ) Then
    Result := tokSymbol;
end;

{-----------------------------------------------------------}

Function TPerlParser.ParsePerlStrConst( Const Ch : Char ) : Integer;
begin
  If ( FLinePtr < FSourcePtr ) And ( ( FSourcePtr - 1 )^ In [ '@', '$', '%', '&' ] ) Then
  begin
    Result := tokWhiteChar;
    DCIncPtr(FSourcePtr);
    Exit;
  end;
  Result := tokString;
  DCIncPtr(FSourcePtr);
  while SkipToCharOrEol(Ch) do
  begin
    if (FSourcePtr - 1)^ <> '\' then
    begin
      DCIncPtr(FSourcePtr);
      break;
    end;
    DCIncPtr(FSourcePtr);
  end;
end;

{-----------------------------------------------------------}

Procedure TPerlParser.WaitForToken;
begin
  While Not ( fSourcePtr^ In FMultiLineCharSet ) Do
  begin
    If fSourcePtr^ = #0 Then
      break;
    DCIncPtr( fSourcePtr );
  end;
end;

{-----------------------------------------------------------}

Procedure TPerlParser.ParserToken;
begin
  While fSourcePtr^ In FMultiLineCharSet Do
    DCIncPtr( fSourcePtr );
end;

{-----------------------------------------------------------}

Procedure TPerlParser.AppendCharSet( Var ACharSet : TCharSet; Const AText : String );
Var
  I : Integer;
begin
  For I := Length( AText ) DownTo 1 Do
    Include( ACharSet, AText[I] );
end;

{-----------------------------------------------------------}

Function TPerlParser.ParseMultiLineStringEnd : Integer;
Var
  WordStarted : PChar;
  CurStr      : String;
begin
  Repeat
    WaitForToken;
    If FSourcePtr^= #0 Then
      break;
    WordStarted := FSourcePtr;
    ParserToken;
    CurStr := Copy( WordStarted, 1, FSourcePtr - WordStarted );
    If FSourcePtr^= #0 Then
      break;
  Until CurStr = FStringFinalWord;

  If CurStr <> FStringFinalWord Then
    FParserState := psPerlLongString
  Else
  begin
    FStringFinalWord := '';
    FParserState := psNormal;
  end;
  Result := tokString;
end;

{-----------------------------------------------------------}

Function TPerlParser.ParseMultiLineString: Integer;
Var
  WrapChar                : Char;
  FinalSymbolStart, Start : PChar;
begin
  DCIncPtr( FSourcePtr );
  If FSourcePtr^ <> '<' Then
  begin
    Result := tokWhiteChar;
    Exit;
  end;

  Start := FSourcePtr;
  DCIncPtr( FSourcePtr );
  WrapChar := FSourcePtr^;

  FMultiLineCharSet := [ '0'..'9', 'A'..'Z', '_', 'a'..'z' ];
  If WrapChar In [ '"', '''' ] Then
    DCIncPtr( FSourcePtr );
  FinalSymbolStart := FSourcePtr;
  If WrapChar In [ '"', '''' ] Then
    SkipToCharOrEol( WrapChar )
  Else
    ParserToken;

  FStringFinalWord := Copy( FinalSymbolStart, 1, FSourcePtr - FinalSymbolStart );
  If FStringFinalWord = '' Then
  begin
    FSourcePtr := Start;
    Result := tokWhiteChar;
    Exit;
  end;

  If WrapChar In [ '"', '''' ] Then
    AppendCharSet( FMultiLineCharSet, FStringFinalWord );

  If ( WrapChar In [ '"', '''' ] ) And ( FSourcePtr^ = WrapChar ) Then
      DCIncPtr( FSourcePtr );

  Result := ParseMultiLineStringEnd;
end;

{-----------------------------------------------------------}

function TPerlParser.ParsePerlConst: integer;
begin
  result := ParsePerlStrConst('"');
end;

{-----------------------------------------------------------}

function TPerlParser.ParsePerlConst1: integer;
begin
  result := ParsePerlStrConst('''');
end;

{-----------TSqlParser----------------------------------------------}

constructor TSqlParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitSQLSyntax;
end;

{-----------------------------------------------------------}

procedure TSqlParser.InitSqlSyntax;
begin
  StrArrayToStrings(ResWords, SqlResWords);
  InitCommon;
  RegisterNormalProc( ['"'], ParseVBStrConst);
  RegisterNormalProc( [''''], ParseStrConst);
  RegisterNormalProc( cFirstIdentChar, ParseIdentifier);
  RegisterNormalProc( cDigit, ParseNumConst);
  RegisterNormalProc( ['/'], ParseJScrComment);
  RegisterProc([psComment2], cWhiteChar, ParseJscrCommentEnd);
  RegisterNormalProc( ['-'], ParseOracleComment);
  InitEolState(psComment2);
end;

{-------------------------------------------------------------}

function TSqlParser.ParseOracleComment: Integer;
begin
  DCIncPtr(FSourcePtr);
  if FSourcePtr^ = '-' then
    Result := RestIsComment
  else
    Result := tokWhiteChar;
end;

{--------------THTMLParser-------------------------------------}

constructor THTMLParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitHTMLSyntax;
end;

{-----------------------------------------------------------}

procedure THTMLParser.InitHTMLSyntax;
begin
  //StrArrayToStrings(ResWords,SHTMLResWords);
  InitCommon;
  RegisterNormalProc( ['"'], ParseVBStrConst);
  RegisterProc([psHtmlTag], ['"'], ParseVBStrConst);
  RegisterNormalProc( cFirstIdentChar, ParseIdentifier);
  RegisterProc([psHtmlTag], cFirstIdentChar, ParseHtmlParam);
  RegisterNormalProc( cDigit, ParseNumConst);
  RegisterProc([psHtmlTag], cDigit, ParseNumConst);
  RegisterNormalProc( ['<'], ParseHTMLTag);
  RegisterProc([psHtmlTag], ['>'], ParseHTMLTagEnd);
  RegisterProc([psComment2], cWhiteChar, ParseHTMLCommentEnd);
  InitEolState(psComment2);
  InitEolState(psHtmlTag);
end;

{-----------------------------------------------------------}

function THTMLParser.ParseHtmlParam: integer;
begin
  repeat
    DCIncPtr(FSourcePtr);
  until not (FSourcePtr^ in COtherIdentChars);
  result := tokHtmlParam;
end;

{-----------------------------------------------------------}

function THTMLParser.ParseHTMLTag: Integer;
begin
  DCIncPtr(FSourcePtr);
  if (FSourcePtr^ = '!') and ((FSourcePtr + 1)^ = '-') and ((FSourcePtr + 2)^ = '-') then
    result := ParseHTMLComment
  else
  begin
    while FSourcePtr^ in COtherIdentChars + ['/'] do
      DCIncPtr(FSourcePtr);
    result := tokHtmlTag;
    ParserState := psHtmlTag;
  end;
end;

{-----------------------------------------------------------}

function THTMLParser.ParseHTMLTagEnd: integer;
begin
  DCIncPtr(FSourcePtr);
  result := tokHtmlTag;
  ParserState := psNormal;
end;

{-----------------------------------------------------------}

function THTMLParser.ParseHTMLComment: Integer;
begin
  if FSourcePtr^ = '!' then
  begin
    DCIncPtr(FSourcePtr);
    Result := ParseHTMLCommentEnd;
  end
  else
    Result := tokWhiteChar;
end;

{-----------------------------------------------------------}

function THTMLParser.ParseHTMLCommentEnd: Integer;
begin
  if SkipToCharOrEol('-') then
  begin
    if ((FSourcePtr + 1)^ = '-') and ((FSourcePtr + 2)^ = '>') then
    begin
      inc(FSourcePtr, 3);
      ParserState := psNormal;
    end
    else
    begin
      DCIncPtr(FSourcePtr);
      ParserState := psComment2;
    end;
  end
  else
    ParserState := psComment2;
  Result := tokComment;
end;

{-------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDreamMemo, [THTMLParser, TSqlParser, TPerlParser,
    TDelphiParser, TDFMParser, TVBScriptParser, {TModuleParser,}
    TJavaScriptParser, TCParser, TCPPParser, TPythonParser]);
end;

{-------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-------------------------------------------------------------}

constructor TDCIDStringConvert.Create;
begin
  inherited;
  FStrings := TStringList.Create;
  FStrings.Add(#0);
  FIDs := TStringList.Create;
  FIDs.Sorted := True;
  FIDs.Duplicates := dupIgnore;
  FIDs.AddObject(#0, Pointer(0));
end;

{---------------------------------------------------------}

destructor TDCIDStringConvert.Destroy;
begin
  FreeObject(FIDs,FIDs);
  FreeObject(FStrings,FStrings);
  inherited;
end;

{---------------------------------------------------------}

function TDCIDStringConvert.IDToString(ID: Integer): string;
begin
  Result := FStrings[ID];
end;

{---------------------------------------------------------}

function TDCIDStringConvert.StringToID(const Str: string): Integer;
var
  SaveCount: Integer;
begin
  SaveCount := FIDs.Count;
  Result := FIDs.AddObject(Str, Pointer(FStrings.Count));
  if FIDs.Count <> SaveCount then
    Result := FStrings.Add(Str);
end;

{-------------------------------------------------------------}

function ParseCharSetDef(const S: string): TCharSet;
var
  Parser: TModuleParser;
  i, FArg, SArg: Char;
begin
  Result := [];
  Parser := TModuleParser.Create(nil);
  Parser.LinePtr := PChar(S);
  with Parser do
  try
    while NextToken <> tokEof do
    begin
      if Token <> tokString then
        Error(SErrCharSetDef);
      FArg := TokenString[1];
      Result := StringToCharSet(Result, TokenString, True);
      case NextToken of
        tokEof:
          break;
        tokWhiteChar:
          case TokenPtr^ of
            ',':
              begin
              end;
            '.':
              begin
                CheckNextChar('.');
                if NextToken <> tokString then
                  Error(SErrCharSetDef);
                SArg := TokenString[1];
                for i := char(integer(FArg) + 1) to SArg do
                  Include(Result, i);
                NextToken;
                if not ParserEof then
                  CheckChar(',');
              end;
            else
              break;
          end;
        else
          break;
      end;

    end;
  finally
    Parser.Free;
  end;
end;

{-----------------------------------------}

procedure CreateIntFile(const FName: string);
var
  FOut: TFileStream;
  FMem: TMemoryStream;
  H: TModuleParser;
begin
  FMem := TMemoryStream.Create;
  try
    FOut := TFileStream.Create(ChangeFileExt(FName, '.INT'), fmcreate); //don't resource
    try
      FMem.LoadFromFile(FName);
      FMem.Seek(0, soFromEnd);
      FMem.Write(nullint, 1);
      FMem.Seek(0, soFromBeginning);
      H := TModuleParser.Create(nil);
      with H do
      begin
        LinePos := 0;
        LinePtr := FMem.Memory;
        while not ParserEof do
        begin
          NextValidToken;
          if IsTokenResWord(ID_IMPLEMENTATION) then
          begin
            FOut.CopyFrom(FMem, SourcePtr - fMem.Memory);
            break;
          end;
        end;
      end;
    finally
      FOut.Free;
    end;
  finally
    FMem.Free;
  end;
end;

{-----------------------------------------}

procedure CreateINTsForDir(const APath: string);
var
  SearchRec: TSearchRec;
  Re: Integer;
  FileName: string;
begin
  Re := FindFirst(AddSlash(APath) + '*.pas', faAnyFile, SearchRec); //don't resource
  try
    while Re = 0 do
    begin
      FileName := AddSlash(APath) + Searchrec.Name;
      CreateIntFile(FileName);
      Writeln(FileName);
      Re := FindNext(SearchRec);
    end;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

{-----------------------------------------------------------}

function TDCIncludeParser.GetParsedFileName: string;
begin
  Result := FParsedFileName;
end;

{-----------------------------------------------------------}

procedure TDCIncludeParser.AddIncludeFile(const FileName: string;
  IncludeInText: boolean);
var
  S: TFileStream;
begin
  if CompareText(GetParsedFileName, FileName) <> 0 then
    FInclFiles.AddObject(AnsiUpperCase(FileName), Pointer(IncludeInText));

  if not IncludeInText then
    exit;
  S := TFileStream.Create(FileName, DefaultOpenMode);
  try
    AddIncludeStream(S);
  finally
    S.Free;
  end;
end;

{-----------------------------------------------------------}

procedure TDCIncludeParser.AddIncludeStream(S: TStream);
var
  pp: PChar;
begin
  SoftPushState;
  GetMem(pp, S.Size + 1);
  with S do
  try
    Read(pp^, Size);
    (pp + Size)^ := #0;
    LinePos := 0;
    LinePtr := pp;
    FBuffers.Add(pp);
    StoreOperation( Nil, soAdd );
  except
    SoftPopState;
    raise;
  end;
end;

{-------------------------------------------------------------}

function TDCIncludeParser.NextToken: Integer;
begin
  Result := inherited NextToken;
  if (Result = tokEof) then
  begin
    if PopIncludeStream then
      Result := NextToken;
  end;
end;

{-----------------------------------------------------------}

Function TDCIncludeParser.PopIncludeStream : Boolean;
begin
  with FBuffers do
  begin
    Result := Count > 0;
    If Result Then
    begin
      If Not SoftPopState Then
      begin
        StoreOperation( Items[ Count - 1 ], soRelease );
        Delete( Count - 1 );
      end;
{      Else
        FreeMem( Items[ Count - 1 ] );
      Delete( Count - 1 );}
    end;
  end;
end;

{-------------------------------------------------------------------------}

Function TDCIncludeParser.GetTokenDataClass : TCollectionItemClass;
begin
  Result := TDCIncludeTokenData;      
end;

{-------------------------------------------------------------------------}

Function TDCIncludeParser.StoreOperation( AData : Pointer; AOperation : TDCStoreOperation ) : Boolean;
begin
  Result := ( TokenList.Count > 0 ) {And
            Not TDCIncludeTokenData( TokenList.Items[ TokenList.Count - 1 ] ).SoftPush};
  If Result Then
    TDCIncludeTokenData( TokenList.Items[ TokenList.Count - 1 ] ).AddOperation( AData, AOperation );
end;

{-------------------------------------------------------------------------}

procedure TDCIncludeParser.DoFileConfirm(var AFileName: string; var AConsiderEmpty: Boolean);
begin
  if Assigned(FFileConfirm) then
  begin
    AConsiderEmpty := False;
    FFileConfirm(AFileName, AConsiderEmpty);
  end
  else
    ErrorFmt(SErrFileNotFound, [AFileName]);
end;

{-----------------------------------------------------------}

procedure TDCIncludeParser.ParseIncludeFile(const AFileName: string; AIncludeInText: Boolean);
var
  FName, _FName: string;
  I: Integer;
  ConsiderEmpty: Boolean;

  //------------

  function _AddIncludeFile(const FileName: string): boolean;
  var
    fname: string;
    SmartExt: string;
  begin
    result := false;

    if pos('*', FileName) > 0 then
      fname := ChangeFileExt(GetParsedFileName, ExtractFileExt(FileName))
    else
      fname := FileName;

    if not FileExists(fname) then
      if (ExtractFileExt(FileName) = '') then
      begin
        if AIncludeInText then
          SmartExt := '.pas' //don't resource
        else
          SmartExt := '.res'; //don't resource

        fname := ChangeFileExt(FileName, SmartExt);
        if not FileExists(fname) then
          exit;
      end
      else
        exit;

    result := true;

    AddIncludeFile(fName, AIncludeInText);

  end;

  //------------

begin

  _FName := AFileName;

  repeat // Dm.
    ConsiderEmpty := True;
    FName := ExtractFilePath(GetParsedFileName) + _FName;

    if _AddIncludeFile(fname) then
      exit;

    if pos('\', _FName) = 0 then
      with fUnitList do
        for i := 0 to Count - 1 do
          if _AddIncludeFile(Strings[i] + _FName) then
            exit;

    if AIncludeInText then
    begin
      ConsiderEmpty := False; // Dm.
      DoFileConfirm(_FName, ConsiderEmpty); // Dm.
    end;
  until ConsiderEmpty; // Dm.
end;

{-------------------------------------------------------------}

constructor TDCIncludeParser.Create(AOwner: TComponent);
begin
  inherited;
  fUnitList := TStringList.Create;
  fBuffers := TList.Create;
  FInclFiles := CreateSortedStringList;
end;

{-------------------------------------------------------------}

destructor TDCIncludeParser.Destroy;
begin
  fUnitList.Free;
  FBuffers.Free;
  FInclFiles.Free;
  inherited;
end;

{-------------------------------------------------------------}

procedure TDCIncludeParser.LoadUnitPaths(const UnitS: string);
var
  i: Integer;
begin
  ParseString(UnitS, ';', UnitPaths);

  with UnitPaths do
    for i := 0 to Count - 1 do
      Strings[i] := AddSlash(Strings[i]);
end;

{-------------------------------------------------------------------------}

type
  TConstantSearcher = class(TObject)
  private
    FHaveBadStrings: boolean;
    OutputStrings: TStrings;
    ModuleStrings: TStrings;
    BadFilesStrings: TStrings;
    Parser: TStringsParser;
    CurrentFile: string;
    oldpos: integer;
    procedure CallBack(const Path: string; const SearchRec: TSearchRec; var ct: boolean);
  public
    Directory: string;
    OutputFile: string;
    Comment: string;
    SubFolders: boolean;
    BadFiles: string;
    function Process: boolean;
    constructor Create;
    destructor Destroy; override;
  end;

type
  TSParser = class(TStringsParser);

  {------------------------------------------------------------------}

constructor TConstantSearcher.Create;
begin
  inherited Create;
  OutputStrings := TStringList.Create;
  ModuleStrings := TStringList.Create;
  BadFilesStrings := TStringList.Create;
  Parser := TDelphiParser.Create(nil);
  TSParser(Parser).Strings := ModuleStrings;
end;

{------------------------------------------------------------------}

destructor TConstantSearcher.Destroy;
begin
  Parser.Free;
  OutputStrings.Free;
  ModuleStrings.Free;
  BadFilesStrings.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function TConstantSearcher.Process: boolean;
var
  i: integer;
begin
  BadFilesStrings.Clear;
  if FileExists(BadFiles) then
    BadFilesStrings.LoadFromFile(BadFiles);

  with OutputStrings do
  begin
    Clear;
    Add('');
    Add(SDirectory + Directory);
    if BadFilesStrings.Count > 0 then
    begin
      Add(SNotprocessedfiles);
      for i := 0 to BadFilesStrings.Count - 1 do
        Add('                    ' + BadFilesStrings.Strings[i]);
    end;
    Add('');
  end;

  ForEachFile(Directory + sPasExt, faAnyFile, SubFolders, CallBack);
  if ExtractFilePath(OutputFile) = '' then
    OutputStrings.SaveToFile(AppFolder + OutputFile)
  else
    OutputStrings.SaveToFile(OutputFile);

  Result := FHaveBadStrings;
end;

{------------------------------------------------------------------}

function SymbolPresent(const s: string): boolean;
var
  i: integer;
  len: integer;
begin
  result := false;
  len := length(s);
  for i := 1 to len do
    if s[i] in ['A'..'Z', 'a'..'z'] then
    begin
      result := true;
      break;
    end;
end;

{------------------------------------------------------------------}

procedure TConstantSearcher.CallBack(const Path: string; const SearchRec: TSearchRec; var ct: boolean);
var
  skipflag: integer;
  found: boolean;
begin
  if BadFilesStrings.IndexOf(SearchRec.Name) >= 0 then
    exit;
  WriteToLog(SearchRec.Name);
  ModuleStrings.LoadFromFile(Path + SearchRec.Name);
  CurrentFile := AddSlash(Path) + SearchRec.Name;
  oldpos := -1;
  skipflag := 0;
  found := false;
  with Parser do
  begin
    ResetParser;
    while not (ParserEof) do
    begin
      case NextToken of
        tokString:
          if (skipflag <= 0) and (length(TokenString) > 3) and (oldpos <> LinePos)
            and SymbolPresent(TokenString) and (Pos(Comment, sourceptr) = 0) then
            if (TokenString[2] <> '{') or (TokenString[Length(TokenString) - 1] <> '}') then
            begin
              OutputStrings.Add(CurrentFile + '  Line ' + IntToStr(LinePos + 1) + ' ' + TokenString); //don't resource
              FHaveBadStrings := True;
              Oldpos := LinePos;
              found := true;
            end;
        tokComment:
          begin
            if CompareText(TokenString, SBeginSkip) = 0 then
              inc(skipflag);
            if CompareText(TokenString, SEndSkip) = 0 then
              dec(skipflag);
          end;
      end;
    end;
  end;
  if found then
    OutputStrings.Add(' ');
end;

{------------------------------------------------------------------}

function SearchNotResourcedStrings(const Path, ResultFile, ABadFiles: string;
  ASubFolders: boolean): boolean;
begin
  with TConstantSearcher.Create do
  try
    Directory := AddSlash(Path);
    OutputFile := ResultFile;
    BadFiles := ABadFiles;
    Comment := sResourcedComment;
    SubFolders := ASubFolders;
    Result := Process;
  finally
    Free;
  end;
end;

{-------------------------------------------------------------------------}

type
  TMParser = class(TDCIncludeParser)
  end;

function CreateInstallParser: TDCIncludeParser;
begin
  Result := TDCIncludeParser.Create(nil);
  with TMParser(Result) do
  begin
    ClearParserStates;
    InitCommon;
    RegisterNormalProc( [' '], ParseWhiteChar);
    RegisterNormalProc( ['{'], ParseComment);
    RegisterProc([psComment], cWhiteChar, ParseComment);

    RegisterNormalProc( cFirstIdentChar, ParseIdentifier);
    RegisterNormalProc( ['('], ParseComplexComment);
    RegisterNormalProc( ['/'], ParseCComment);
    RegisterProc([psComment2], cWhiteChar, ParseComplexCommentEnd);
    InitEolState(psComment2);
    InitEolState(psComment);
  end;
end;

{-------------------------------------------------------------------------}

function LoadAndParseIfDefs(const FileName, ADefines, AIgnoreDefines, InclFolders: string): string;
begin
  Result := DCRemoveIfDefs(FileName, ADefines, AIgnoreDefines, InclFolders, True);
end;

{-------------------------------------------------------------}

function DCRemoveIfDefs(const InputString, ADefines, AIgnoreDefines, InclFolders: string;
  InputStrIsFileName: boolean): string;
begin
  Result := DCRemoveIfDefsEx(InputString, ADefines, AIgnoreDefines, InclFolders,
    InputStrIsFileName, nil);
end;

{-------------------------------------------------------------------------}

function DCRemoveIfDefsEx(const InputString, ADefines, AIgnoreDefines, InclFolders: string;
  InputStrIsFileName: boolean; AFileConfirm: TDCFileConfirm): string;
var
  P: TDCIncludeParser;
  DataStr: string;
  _LinePos: Integer;
begin
  P := CreateInstallParser;

  with P do
  begin
    FFileConfirm := AFileConfirm;

    Defines.Clear; // Dm.
    IgnoreDefines.Clear; // Dm.
    if InputStrIsFileName then // Dm.
      ParsedFileName := InputString;
    ParseString(ADefines, ';', Defines);
    ParseString(AIgnoreDefines, ';', IgnoreDefines);
    LoadUnitPaths(InclFolders);

    LinePos := 0;
    DataStr := '';
    if InputStrIsFileName then // Dm.
    begin
      LinePtr := PChar(DataStr);
      AddIncludeFile(InputString, True);
    end
    else // Dm.
      LinePtr := PChar(InputString); // Dm.

    try
      _LinePos := 0;
      Result := '';
      while Token <> tokEof do
      begin
        if LinePos <> _LinePos then
        begin
          Result := Result + #13#10;
          _LinePos := LinePos;
        end;

        Result := Result + TokenString;

        NextValidToken;
      end;
    finally
      P.Free;
    end;
  end;
end;

{-------------------------------------------------------------------------}

{ TTokenData }

Procedure TTokenData.ProcessSinglePop( AParser : TCustomDCParser );
begin
end;

{-------------------------------------------------------------------------}

{ TDCIncludeTokenData }

Procedure TDCIncludeTokenData.AddOperation( AData : Pointer; AOperation : TDCStoreOperation );
Var
  Op : pDCOperationStorage;
begin
  GetMem( Op, SizeOf( TDCOperationStorage ) );
  With Op^ Do
  begin
    Data := AData;
    Operation := AOperation;
  end;
  Operations.Add( Op );
end;

{-------------------------------------------------------------------------}

Constructor TDCIncludeTokenData.Create( ACollection : TCollection );
begin
  Inherited;
  FOperations := TList.Create;
end;

{-------------------------------------------------------------------------}

Destructor TDCIncludeTokenData.Destroy;
Var
  I : Integer;
begin
  With Operations Do
    For I := Count - 1 DownTo 0 Do
    begin
      With pDCOperationStorage( Items[I] )^ Do
        If Operation = soAdd Then
          FreeMem( Data ); 
      FreeMem( Items[I] );
    end;
  FreeObject( FOperations , FOperations );
  Inherited;
end;

{-------------------------------------------------------------------------}

Procedure TDCIncludeTokenData.ProcessSinglePop( AParser : TCustomDCParser );
Var
  I, LastIndex : Integer;
begin
  Inherited;
  With TDCIncludeParser( AParser ) Do
  begin
    With Operations Do
      For I := Count - 1 DownTo 0 Do
        With pDCOperationStorage( Items[I] )^ Do
          If Operation = soRelease Then
            FBuffers.Add( Data )
          Else
            With FBuffers Do
            begin
              LastIndex := Count - 1;
              FreeMem( Items[ LastIndex ] );
              Delete( LastIndex );
            end;
  end;
end;

{-------------------------------------------------------------------------}

function TModuleParser.GetDelphiVer:TDelphiVer;
begin
  DCGetDelphiVerFromDefines(FDefines,Result);
end;

{-------------------------------------------------------------------------}

initialization
  Runregister;
end.
