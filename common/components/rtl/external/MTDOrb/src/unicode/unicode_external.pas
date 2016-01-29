unit unicode_external;

interface
function uni_fromUTF8(dest : PAnsiChar; const utf8: PAnsiChar; chars: Cardinal; utf_read: Cardinal; string_type: Cardinal; line_type: AnsiChar; written: Cardinal) : LongInt; cdecl;
function uni_toUTF8(utf8: PAnsiChar; const src: PAnsiChar; chars: Cardinal; string_type: Cardinal; line_type: Byte; written: Cardinal) : LongInt; cdecl;

implementation
type
    uni_slong = Longint;
    uni_ulong = Cardinal;
    uni_uword = Cardinal;
    uni_ubyte = Byte;
    uni_ushort = Word;
    size_t = Cardinal;

    Puni_uword = ^uni_uword;
    puni_ulong = ^uni_ulong;
    puni_ushort = ^uni_ushort;
    puni_ubyte = ^uni_ubyte;

{$LINK 'uni_base64.obj'}
{$LINK 'uni_fromuni.obj'}
{$LINK 'uni_touni.obj'}
{$LINK 'uni_unicode.obj'}

function strlen(const Str: PAnsiChar): Cardinal; cdecl; external 'msvcrt.dll' name 'strlen';
function sprintf(S: PAnsiChar; const Format: PChar): Integer; cdecl; varargs; external 'msvcrt.dll' name 'sprintf';
function strcpy(dest : PAnsiChar; const src : PAnsiChar) : PAnsiChar; cdecl; external 'msvcrt.dll' name 'strcpy';
function isdigit(c : Integer) : Integer; cdecl; external 'msvcrt.dll' name 'isdigit';
function memcpy(dest : Pointer; const src : Pointer; n : size_t ) : Pointer; cdecl; external 'msvcrt.dll' name 'memcpy';
function sscanf(const buffer : PAnsiChar; const format: PAnsiChar) : Integer; cdecl; varargs; external 'msvcrt.dll' name 'sscanf';
function _ltoupper(c: Integer): Integer; cdecl; external 'msvcrt.dll' name '_toupper';

function uni_isbase64char(c : AnsiChar; padding : Integer): Integer; cdecl; external;
//function _uni_base64delen(datasize: uni_uword) : uni_uword; cdecl; external;
function uni_base64decode(data : Pointer; carry : Smallint; const src : PChar; bytes_written : puni_uword) : uni_uword; cdecl; external;
function uni_base64encode(dest : PAnsiChar; const data: Pointer; datasize: uni_uword; padding : Integer; funct : Pointer): uni_slong; cdecl; external;

function uni_fromUTF8(dest : PAnsiChar; const utf8: PAnsiChar; chars: Cardinal; utf_read: Cardinal; string_type: Cardinal; line_type: AnsiChar; written: Cardinal) : LongInt; cdecl; external;
function uni_toUTF8(utf8: PAnsiChar; const src: PAnsiChar; chars: Cardinal; string_type: Cardinal; line_type: Byte; written: Cardinal) : LongInt; cdecl; external;
//function _uni_ucs4arraytoutf7(utf7 : PChar; ucs4 : puni_ulong; length : uni_ubyte) : uni_slong; cdecl; external;
//function _uni_utf16toutf8(utf8 : PChar; const utf16: puni_ushort; s_read : puni_ubyte) : uni_slong; cdecl; external;
end.

