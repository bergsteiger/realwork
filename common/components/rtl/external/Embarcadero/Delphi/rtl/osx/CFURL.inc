{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFURL.h                                }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFURL__}

{$DEFINE __COREFOUNDATION_CFURL__}

{$I CFBase.inc}
{$I CFData.inc}
{$I CFError.inc}
{$I CFString.inc}

const
  kCFURLPOSIXPathStyle   = 0;
  {$EXTERNALSYM kCFURLPOSIXPathStyle}
  kCFURLHFSPathStyle     = 1;
  {$EXTERNALSYM kCFURLHFSPathStyle}
  kCFURLWindowsPathStyle = 2;
  {$EXTERNALSYM kCFURLWindowsPathStyle}
type
  CFURLPathStyle = CFIndex;
  {$EXTERNALSYM CFURLPathStyle}

  PCFURLRef = ^CFURLRef;
  CFURLRef = ^__CFURL;
  {$EXTERNALSYM CFURLRef}
  __CFURL = record
  end;
  {$EXTERNALSYM __CFURL}

{ CFURLs are composed of two fundamental pieces - their string, and a }
{ (possibly NULL) base URL.  A relative URL is one in which the string }
{ by itself does not fully specify the URL (for instance "myDir/image.tiff"); }
{ an absolute URL is one in which the string does fully specify the URL }
{ ("file://localhost/myDir/image.tiff").  Absolute URLs always have NULL }
{ base URLs; however, it is possible for a URL to have a NULL base, and still }
{ not be absolute.  Such a URL has only a relative string, and cannot be }
{ resolved.  Two CFURLs are considered equal if and only if their strings }
{ are equal and their bases are equal.  In other words, }
{ "file://localhost/myDir/image.tiff" is NOT equal to the URL with relative }
{ string "myDir/image.tiff" and base URL "file://localhost/".  Clients that }
{ need these less strict form of equality should convert all URLs to their }
{ absolute form via CFURLCopyAbsoluteURL(), then compare the absolute forms. }

function CFURLGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFURLGetTypeID';
{$EXTERNALSYM CFURLGetTypeID}

{ encoding will be used both to interpret the bytes of URLBytes, and to }
{ interpret any percent-escapes within the bytes. }
function CFURLCreateWithBytes(allocator: CFAllocatorRef; URLBytes: PUInt8;
  length: CFIndex; encoding: CFStringEncoding;
  baseURL: CFURLRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateWithBytes';
{$EXTERNALSYM CFURLCreateWithBytes}

{ Escapes any character that is not 7-bit ASCII with the byte-code }
{ for the given encoding.  If escapeWhitespace is true, whitespace }
{ characters (' ', '\t', '\r', '\n') will be escaped also (desirable }
{ if embedding the URL into a larger text stream like HTML) }
function CFURLCreateData(allocator: CFAllocatorRef; url: CFURLRef;
  encoding: CFStringEncoding; escapeWhitespace: Boolean): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateData';
{$EXTERNALSYM CFURLCreateData}

{ Any escape sequences in URLString will be interpreted via UTF-8. }
function CFURLCreateWithString(allocator: CFAllocatorRef;
  URLString: CFStringRef; baseURL: CFURLRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateWithString';
{$EXTERNALSYM CFURLCreateWithString}


{ Create an absolute URL directly, without requiring the extra step }
{ of calling CFURLCopyAbsoluteURL().  If useCompatibilityMode is  }
{ true, the rules historically used on the web are used to resolve }
{ relativeString against baseURL - these rules are generally listed }
{ in the RFC as optional or alternate interpretations.  Otherwise, }
{ the strict rules from the RFC are used.  The major differences are }
{ that in compatibility mode, we are lenient of the scheme appearing }
{ in relative portion, leading "../" components are removed from the }
{ final URL's path, and if the relative portion contains only }
{ resource specifier pieces (query, parameters, and fragment), then }
{ the last path component of the base URL will not be deleted  }
function CFURLCreateAbsoluteURLWithBytes(alloc: CFAllocatorRef;
  relativeURLBytes: PUInt8; length: CFIndex; encoding: CFStringEncoding;
  baseURL: CFURLRef; useCompatibilityMode: Boolean): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateAbsoluteURLWithBytes';
{$EXTERNALSYM CFURLCreateAbsoluteURLWithBytes}

{ filePath should be the URL's path expressed as a path of the type }
{ fsType.  If filePath is not absolute, the resulting URL will be }
{ considered relative to the current working directory (evaluated }
{ at creation time).  isDirectory determines whether filePath is }
{ treated as a directory path when resolving against relative path }
{ components }
function CFURLCreateWithFileSystemPath(allocator: CFAllocatorRef;
  filePath: CFStringRef; pathStyle: CFURLPathStyle;
  isDirectory: Boolean): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateWithFileSystemPath';
{$EXTERNALSYM CFURLCreateWithFileSystemPath}

function CFURLCreateFromFileSystemRepresentation(allocator: CFAllocatorRef;
  buffer: PUInt8; bufLen: CFIndex;
  isDirectory: Boolean): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateFromFileSystemRepresentation';
{$EXTERNALSYM CFURLCreateFromFileSystemRepresentation}

{ The path style of the baseURL must match the path style of the relative }
{ url or the results are undefined.  If the provided filePath looks like an }
{ absolute path ( starting with '/' if pathStyle is kCFURLPosixPathStyle, }
{ not starting with ':' for kCFURLHFSPathStyle, or starting with what looks }
{ like a drive letter and colon for kCFURLWindowsPathStyle ) then the baseURL }
{ is ignored. }
function CFURLCreateWithFileSystemPathRelativeToBase(allocator: CFAllocatorRef;
  filePath: CFStringRef; pathStyle: CFURLPathStyle; isDirectory: Boolean;
  baseURL: CFURLRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateWithFileSystemPathRelativeToBase';
{$EXTERNALSYM CFURLCreateWithFileSystemPathRelativeToBase}

function CFURLCreateFromFileSystemRepresentationRelativeToBase(
  allocator: CFAllocatorRef; buffer: PUInt8; bufLen: CFIndex;
  isDirectory: Boolean; baseURL: CFURLRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateFromFileSystemRepresentationRelativeToBase';
{$EXTERNALSYM CFURLCreateFromFileSystemRepresentationRelativeToBase}

{ Fills buffer with the file system's native representation of }
{ url's path. No more than maxBufLen bytes are written to buffer. }
{ The buffer should be at least the maximum path length for }
{ the file system in question to avoid failures for insufficiently }
{ large buffers.  If resolveAgainstBase is true, the url's relative }
{ portion is resolved against its base before the path is computed. }
{ Returns success or failure. }
function CFURLGetFileSystemRepresentation(url: CFURLRef;
  resolveAgainstBase: Boolean; buffer: PUInt8;
  maxBufLen: CFIndex): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLGetFileSystemRepresentation';
{$EXTERNALSYM CFURLGetFileSystemRepresentation}

{ Creates a new URL by resolving the relative portion of relativeURL against its base. }
function CFURLCopyAbsoluteURL(relativeURL: CFURLRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyAbsoluteURL';
{$EXTERNALSYM CFURLCopyAbsoluteURL}

{ Returns the URL's string. }
function CFURLGetString(anURL: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLGetString';
{$EXTERNALSYM CFURLGetString}

{ Returns the base URL if it exists }
function CFURLGetBaseURL(anURL: CFURLRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLGetBaseURL';
{$EXTERNALSYM CFURLGetBaseURL}

{ 
All URLs can be broken into two pieces - the scheme (preceding the
first colon) and the resource specifier (following the first colon).
Most URLs are also "standard" URLs conforming to RFC 1808 (available
from www.w3c.org).  This category includes URLs of the file, http,
https, and ftp schemes, to name a few.  Standard URLs start the
resource specifier with two slashes ("//"), and can be broken into
four distinct pieces - the scheme, the net location, the path, and
further resource specifiers (typically an optional parameter, query,
and/or fragment).  The net location appears immediately following
the two slashes and goes up to the next slash; it's format is
scheme-specific, but is usually composed of some or all of a username,
password, host name, and port.  The path is a series of path components
separated by slashes; if the net location is present, the path always
begins with a slash.  Standard URLs can be relative to another URL,
in which case at least the scheme and possibly other pieces as well
come from the base URL (see RFC 1808 for precise details when resolving
a relative URL against its base).  The full URL is therefore

<scheme> "://" <net location> <path, always starting with slash> <add'l resource specifiers>

If a given CFURL can be decomposed (that is, conforms to RFC 1808), you
can ask for each of the four basic pieces (scheme, net location, path,
and resource specifer) separately, as well as for its base URL.  The
basic pieces are returned with any percent escape sequences still in
place (although note that the scheme may not legally include any
percent escapes); this is to allow the caller to distinguish between
percent sequences that may have syntactic meaning if replaced by the
character being escaped (for instance, a '/' in a path component).
Since only the individual schemes know which characters are
syntactically significant, CFURL cannot safely replace any percent
escape sequences.  However, you can use
CFURLCreateStringByReplacingPercentEscapes() to create a new string with
the percent escapes removed; see below.

If a given CFURL can not be decomposed, you can ask for its scheme and its
resource specifier; asking it for its net location or path will return NULL.

To get more refined information about the components of a decomposable
CFURL, you may ask for more specific pieces of the URL, expressed with
the percent escapes removed.  The available functions are CFURLCopyHostName(),
CFURLGetPortNumber() (returns an Int32), CFURLCopyUserName(),
CFURLCopyPassword(), CFURLCopyQuery(), CFURLCopyParameters(), and
CFURLCopyFragment().  Because the parameters, query, and fragment of an
URL may contain scheme-specific syntaxes, these methods take a second
argument, giving a list of characters which should NOT be replaced if
percent escaped.  For instance, the ftp parameter syntax gives simple
key-value pairs as "<key>=<value>;"  Clearly if a key or value includes
either '=' or ';', it must be escaped to avoid corrupting the meaning of
the parameters, so the caller may request the parameter string as

CFStringRef myParams = CFURLCopyParameters(ftpURL, CFSTR("=;%"));

requesting that all percent escape sequences be replaced by the represented
characters, except for escaped '=', '%' or ';' characters.  Pass the empty
string (CFSTR("")) to request that all percent escapes be replaced, or NULL
to request that none be.
 }

{ Returns true if anURL conforms to RFC 1808 }
function CFURLCanBeDecomposed(anURL: CFURLRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCanBeDecomposed';
{$EXTERNALSYM CFURLCanBeDecomposed}

{ The next several methods leave any percent escape sequences intact }

function CFURLCopyScheme(anURL: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyScheme';
{$EXTERNALSYM CFURLCopyScheme}

{ NULL if CFURLCanBeDecomposed(anURL) is false }
function CFURLCopyNetLocation(anURL: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyNetLocation';
{$EXTERNALSYM CFURLCopyNetLocation}

{ NULL if CFURLCanBeDecomposed(anURL) is false; also does not resolve the URL }
{ against its base.  See also CFURLCopyAbsoluteURL().  Note that, strictly }
{ speaking, any leading '/' is not considered part of the URL's path, although }
{ its presence or absence determines whether the path is absolute. }
{ CFURLCopyPath()'s return value includes any leading slash (giving the path }
{ the normal POSIX appearance); CFURLCopyStrictPath()'s return value omits any }
{ leading slash, and uses isAbsolute to report whether the URL's path is absolute. }

{ CFURLCopyFileSystemPath() returns the URL's path as a file system path for the }
{ given path style.  All percent escape sequences are replaced.  The URL is not }
{ resolved against its base before computing the path. }
function CFURLCopyPath(anURL: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyPath';
{$EXTERNALSYM CFURLCopyPath}

function CFURLCopyStrictPath(anURL: CFURLRef;
  isAbsolute: PBoolean): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyStrictPath';
{$EXTERNALSYM CFURLCopyStrictPath}

function CFURLCopyFileSystemPath(anURL: CFURLRef;
  pathStyle: CFURLPathStyle): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyFileSystemPath';
{$EXTERNALSYM CFURLCopyFileSystemPath}

{ Returns whether anURL's path represents a directory }
{ (true returned) or a simple file (false returned) }
function CFURLHasDirectoryPath(anURL: CFURLRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLHasDirectoryPath';
{$EXTERNALSYM CFURLHasDirectoryPath}

{ Any additional resource specifiers after the path.  For URLs }
{ that cannot be decomposed, this is everything except the scheme itself. }
function CFURLCopyResourceSpecifier(anURL: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyResourceSpecifier';
{$EXTERNALSYM CFURLCopyResourceSpecifier}

function CFURLCopyHostName(anURL: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyHostName';
{$EXTERNALSYM CFURLCopyHostName}

function CFURLGetPortNumber(anURL: CFURLRef): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFURLGetPortNumber';
{$EXTERNALSYM CFURLGetPortNumber}

function CFURLCopyUserName(anURL: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyUserName';
{$EXTERNALSYM CFURLCopyUserName}

function CFURLCopyPassword(anURL: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyPassword';
{$EXTERNALSYM CFURLCopyPassword}

{ These remove all percent escape sequences except those for }
{ characters in charactersToLeaveEscaped.  If charactersToLeaveEscaped }
{ is empty (""), all percent escape sequences are replaced by their }
{ corresponding characters.  If charactersToLeaveEscaped is NULL, }
{ then no escape sequences are removed at all }
function CFURLCopyParameterString(anURL: CFURLRef;
  charactersToLeaveEscaped: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyParameterString';
{$EXTERNALSYM CFURLCopyParameterString}

function CFURLCopyQueryString(anURL: CFURLRef;
  charactersToLeaveEscaped: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyQueryString';
{$EXTERNALSYM CFURLCopyQueryString}

function CFURLCopyFragment(anURL: CFURLRef;
  charactersToLeaveEscaped: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyFragment';
{$EXTERNALSYM CFURLCopyFragment}

function CFURLCopyLastPathComponent(url: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyLastPathComponent';
{$EXTERNALSYM CFURLCopyLastPathComponent}

function CFURLCopyPathExtension(url: CFURLRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyPathExtension';
{$EXTERNALSYM CFURLCopyPathExtension}

{ These functions all treat the base URL of the supplied url as }
{ invariant.  In other words, the URL returned will always have }
{ the same base as the URL supplied as an argument. }

function CFURLCreateCopyAppendingPathComponent(allocator: CFAllocatorRef;
  url: CFURLRef; pathComponent: CFStringRef;
  isDirectory: Boolean): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateCopyAppendingPathComponent';
{$EXTERNALSYM CFURLCreateCopyAppendingPathComponent}

function CFURLCreateCopyDeletingLastPathComponent(allocator: CFAllocatorRef;
  url: CFURLRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateCopyDeletingLastPathComponent';
{$EXTERNALSYM CFURLCreateCopyDeletingLastPathComponent}

function CFURLCreateCopyAppendingPathExtension(allocator: CFAllocatorRef;
  url: CFURLRef; extension: CFStringRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateCopyAppendingPathExtension';
{$EXTERNALSYM CFURLCreateCopyAppendingPathExtension}

function CFURLCreateCopyDeletingPathExtension(allocator: CFAllocatorRef;
  url: CFURLRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateCopyDeletingPathExtension';
{$EXTERNALSYM CFURLCreateCopyDeletingPathExtension}

{ Fills buffer with the bytes for url, returning the number of bytes }
{ filled.  If buffer is of insufficient size, returns -1 and no bytes }
{ are placed in buffer.  If buffer is NULL, the needed length is }
{ computed and returned.  The returned bytes are the original bytes }
{ from which the URL was created; if the URL was created from a }
{ string, the bytes will be the bytes of the string encoded via UTF-8  }
function CFURLGetBytes(url: CFURLRef; buffer: PUInt8;
  bufferLength: CFIndex): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFURLGetBytes';
{$EXTERNALSYM CFURLGetBytes}

const
  kCFURLComponentScheme            = 1;
  {$EXTERNALSYM kCFURLComponentScheme}
  kCFURLComponentNetLocation       = 2;
  {$EXTERNALSYM kCFURLComponentNetLocation}
  kCFURLComponentPath              = 3;
  {$EXTERNALSYM kCFURLComponentPath}
  kCFURLComponentResourceSpecifier = 4;
  {$EXTERNALSYM kCFURLComponentResourceSpecifier}

  kCFURLComponentUser              = 5;
  {$EXTERNALSYM kCFURLComponentUser}
  kCFURLComponentPassword          = 6;
  {$EXTERNALSYM kCFURLComponentPassword}
  kCFURLComponentUserInfo          = 7;
  {$EXTERNALSYM kCFURLComponentUserInfo}
  kCFURLComponentHost              = 8;
  {$EXTERNALSYM kCFURLComponentHost}
  kCFURLComponentPort              = 9;
  {$EXTERNALSYM kCFURLComponentPort}
  kCFURLComponentParameterString   = 10;
  {$EXTERNALSYM kCFURLComponentParameterString}
  kCFURLComponentQuery             = 11;
  {$EXTERNALSYM kCFURLComponentQuery}
  kCFURLComponentFragment          = 12;
  {$EXTERNALSYM kCFURLComponentFragment}
type
  CFURLComponentType = CFIndex;
  {$EXTERNALSYM CFURLComponentType}

{ 
Gets the  range of the requested component in the bytes of url, as
returned by CFURLGetBytes().  This range is only good for use in the
bytes returned by CFURLGetBytes!

If non-NULL, rangeIncludingSeparators gives the range of component
including the sequences that separate component from the previous and
next components.  If there is no previous or next component, that end of
rangeIncludingSeparators will match the range of the component itself.
If url does not contain the given component type, (kCFNotFound, 0) is
returned, and rangeIncludingSeparators is set to the location where the
component would be inserted.  Some examples -

For the URL http://www.apple.com/hotnews/

Component           returned range      rangeIncludingSeparators
scheme              (0, 4)              (0, 7)
net location        (7, 13)             (4, 16)
path                (20, 9)             (20, 9)    
resource specifier  (kCFNotFound, 0)    (29, 0)
user                (kCFNotFound, 0)    (7, 0)
password            (kCFNotFound, 0)    (7, 0)
user info           (kCFNotFound, 0)    (7, 0)
host                (7, 13)             (4, 16)
port                (kCFNotFound, 0)    (20, 0)
parameter           (kCFNotFound, 0)    (29, 0)
query               (kCFNotFound, 0)    (29, 0)
fragment            (kCFNotFound, 0)    (29, 0)


For the URL ./relPath/file.html#fragment

Component           returned range      rangeIncludingSeparators
scheme              (kCFNotFound, 0)    (0, 0)
net location        (kCFNotFound, 0)    (0, 0)
path                (0, 19)             (0, 20)
resource specifier  (20, 8)             (19, 9)
user                (kCFNotFound, 0)    (0, 0)
password            (kCFNotFound, 0)    (0, 0)
user info           (kCFNotFound, 0)    (0, 0)
host                (kCFNotFound, 0)    (0, 0)
port                (kCFNotFound, 0)    (0, 0)
parameter           (kCFNotFound, 0)    (19, 0)
query               (kCFNotFound, 0)    (19, 0)
fragment            (20, 8)             (19, 9)


For the URL scheme://user:pass@host:1/path/path2/file.html;params?query#fragment

Component           returned range      rangeIncludingSeparators
scheme              (0, 6)              (0, 9)
net location        (9, 16)             (6, 19)
path                (25, 21)            (25, 22) 
resource specifier  (47, 21)            (46, 22)
user                (9, 4)              (6, 8)
password            (14, 4)             (13, 6)
user info           (9, 9)              (6, 13)
host                (19, 4)             (18, 6)
port                (24, 1)             (23, 2)
parameter           (47, 6)             (46, 8)
query               (54, 5)             (53, 7)
fragment            (60, 8)             (59, 9)
 }
function CFURLGetByteRangeForComponent(url: CFURLRef;
  component: CFURLComponentType;
  rangeIncludingSeparators: PCFRange): CFRange; cdecl;
  external CoreFoundationLib name _PU + 'CFURLGetByteRangeForComponent';
{$EXTERNALSYM CFURLGetByteRangeForComponent}

{ Returns a string with any percent escape sequences that do NOT }
{ correspond to characters in charactersToLeaveEscaped with their }
{ equivalent.  Returns NULL on failure (if an invalid percent sequence }
{ is encountered), or the original string (retained) if no characters }
{ need to be replaced. Pass NULL to request that no percent escapes be }
{ replaced, or the empty string (CFSTR("")) to request that all percent }
{ escapes be replaced.  Uses UTF8 to interpret percent escapes. }
function CFURLCreateStringByReplacingPercentEscapes(allocator: CFAllocatorRef;
  originalString: CFStringRef;
  charactersToLeaveEscaped: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateStringByReplacingPercentEscapes';
{$EXTERNALSYM CFURLCreateStringByReplacingPercentEscapes}

{ As above, but allows you to specify the encoding to use when interpreting percent escapes }
function CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
  allocator: CFAllocatorRef; origString: CFStringRef;
  charsToLeaveEscaped: CFStringRef;
  encoding: CFStringEncoding): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateStringByReplacingPercentEscapesUsingEncoding';
{$EXTERNALSYM CFURLCreateStringByReplacingPercentEscapesUsingEncoding}

{ Creates a copy or originalString, replacing certain characters with }
{ the equivalent percent escape sequence based on the encoding specified. }
{ If the originalString does not need to be modified (no percent escape }
{ sequences are missing), may retain and return originalString. }
{ If you are uncertain of the correct encoding, you should use UTF-8, }
{ which is the encoding designated by RFC 2396 as the correct encoding }
{ for use in URLs.  The characters so escaped are all characters that }
{ are not legal URL characters (based on RFC 2396), plus any characters }
{ in legalURLCharactersToBeEscaped, less any characters in }
{ charactersToLeaveUnescaped.  To simply correct any non-URL characters }
{ in an otherwise correct URL string, do: }

{ newString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, origString, NULL, NULL, kCFStringEncodingUTF8); }
function CFURLCreateStringByAddingPercentEscapes(allocator: CFAllocatorRef;
  originalString: CFStringRef; charactersToLeaveUnescaped: CFStringRef;
  legalURLCharactersToBeEscaped: CFStringRef;
  encoding: CFStringEncoding): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateStringByAddingPercentEscapes';
{$EXTERNALSYM CFURLCreateStringByAddingPercentEscapes}


{ Returns a file reference URL, a path-idependent form of file URL. }
{ Converts a file path URL if necessary. For non-file URLs, returns NULL. }
{ Also returns NULL when the conversion fails because the target resource doesn't exist. }
{ Optional output error: The error is set to a valid CFErrorRef when the function }
{ result is NULL. A valid output error must be released by the caller. }
function CFURLCreateFileReferenceURL(allocator: CFAllocatorRef; url: CFURLRef;
  error: PCFErrorRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateFileReferenceURL';
{$EXTERNALSYM CFURLCreateFileReferenceURL}


{ Returns a file path URL, converting a file reference URL if necessary. }
{ For non-file URLs, returns NULL. Also returns NULL when the conversion fails }
{ because the target resource doesn't exist. }
{ Optional output error: The error is set to a valid CFErrorRef when the function }
{ result is NULL. A valid output error must be released by the caller. }
function CFURLCreateFilePathURL(allocator: CFAllocatorRef; url: CFURLRef;
  error: PCFErrorRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateFilePathURL';
{$EXTERNALSYM CFURLCreateFilePathURL}




function CFURLCreateFromFSRef(allocator: CFAllocatorRef;
  fsRef: PFSRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateFromFSRef';
{$EXTERNALSYM CFURLCreateFromFSRef}

function CFURLGetFSRef(url: CFURLRef; fsRef: PFSRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLGetFSRef';
{$EXTERNALSYM CFURLGetFSRef}


{ The following APIs provide efficient access to resource properties. Properties
are identified by keys, and values are represented as Core Foundation objects. The 
type of each value is fixed for each property, e.g. the modification date is a CFDateRef, 
the file size is a CFNumberRef.

Values are fetched on-demand, synchronously, from the resource's backing store. They
are cached and reused when fetched again through the same URL instance, until the 
client clears the value. The client has complete control over the cache lifetime.

Some resource property values can be changed, given sufficient access permission to the resource. 
When a resource property value is set, the change is written to backing store synchronously.
 }

{ Assigns the requested resource property value to the typeRefValuePtr output }
{ argument. Returns true if the output value was set. Note that NULL is a valid output value. }
{ The value is fetched synchronously from the resource backing store only if a value is not }
{ already cached. The type of the output value type varies by property (see property key }
{ definitions). Returns false if an error occurs. Optional output error: the error is set to }
{ a valid CFErrorRef when the function returns false. A valid output error must be }
{ released by the caller. }
function CFURLCopyResourcePropertyForKey(url: CFURLRef; key: CFStringRef;
  propertyValueTypeRefPtr: Pointer; error: PCFErrorRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyResourcePropertyForKey';
{$EXTERNALSYM CFURLCopyResourcePropertyForKey}


{ Returns any number of resource property values as a dictionary of keyed values. }
{ The requested values are specified as an array of keys to appear in }
{ the result dictionary. Values are fetched synchronously from the resource backing store unless }
{ already cached. The type of each value type varies (see key definitions, below). }
{ Returns an empty dictionary if no values are found. Returns NULL when an error occurs. }
{ Optional output error: the error is set to a valid CFErrorRef when the }
{ function returns NULL. A valid output error must be released by the caller. }
function CFURLCopyResourcePropertiesForKeys(url: CFURLRef; keys: CFArrayRef;
  error: PCFErrorRef): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyResourcePropertiesForKeys';
{$EXTERNALSYM CFURLCopyResourcePropertiesForKeys}


{ Changes a resource property value. Synchronously writes the value to the resource backing }
{ store. The input value type must be a valid CFTypeRef, of the type required for the specified }
{ key (see key definitions). Returns true upon success, false when an error occurs. }
{ Optional output error: the error is set to a valid CFErrorRef when the function }
{ returns false. A valid output error must be released by the caller. }
{ Note that some values are read-only. Attempting to set a read-only property }
{ results in an error. }
function CFURLSetResourcePropertyForKey(url: CFURLRef; key: CFStringRef;
  propertValue: CFTypeRef; error: PCFErrorRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLSetResourcePropertyForKey';
{$EXTERNALSYM CFURLSetResourcePropertyForKey}


{ Changes any number of resource property values, specified as a dictionary of keyed values. }
{ Synchronously writes values to the resource backing store. The input dictionary's value types must conform }
{ to the type required for its key (see key definitions). Returns true when all values are set successfully, }
{ and false if an error occurs. Optional output error: the error is set to a valid CFErrorRef when the function returns }
{ false. A valid output error must be released by the caller. When an error occurs after some properties have been }
{ successfully changed, the user dictionary in the error contains an array of keys that }
{ were not set. Note that some values are read-only. Attempting to set a read-only value }
{ results in an error. }
function CFURLSetResourcePropertiesForKeys(url: CFURLRef;
  keyedPropertyValues: CFDictionaryRef; error: PCFErrorRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLSetResourcePropertiesForKeys';
{$EXTERNALSYM CFURLSetResourcePropertiesForKeys}


{ Discards a cached property value for a specific key }
procedure CFURLClearResourcePropertyCacheForKey(url: CFURLRef;
  key: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFURLClearResourcePropertyCacheForKey';
{$EXTERNALSYM CFURLClearResourcePropertyCacheForKey}


{ Discards all cached property values }
procedure CFURLClearResourcePropertyCache(url: CFURLRef); cdecl;
  external CoreFoundationLib name _PU + 'CFURLClearResourcePropertyCache';
{$EXTERNALSYM CFURLClearResourcePropertyCache}


{ Sets a temporary property value. Temporary properties exist only in memory and are never }
{ written to resource backing store. Once set, a temporary property value can be fetched }
{ with CFURLCopyResourcePropertyForKey and CFURLCopyResourcePropertiesForKeys. Temporary property }
{ values are for client use. Values must be valid Core Foundation types, and will be retained. }
{ To remove a temporary property value, use CFURLClearResourcePropertyCacheForKey. }
procedure CFURLSetTemporaryResourcePropertyForKey(url: CFURLRef;
  key: CFStringRef; propertyValue: CFTypeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFURLSetTemporaryResourcePropertyForKey';
{$EXTERNALSYM CFURLSetTemporaryResourcePropertyForKey}


{ Synchronously checks if the resource's backing store is reachable and the resource exists, }
{ returning true if so. The optional output error can be used to determine the type of reachability }
{ failure (e.g., file not found, network error, etc.). The error is set to a valid CFErrorRef if }
{ and only if the function returns false. A valid output error must be released by }
{ the caller. Checking for resource existence and reachability is appropriate when making decisions }
{ that do not require other immediate operations on the resource. An example would be }
{ periodic maintenance of UI state that depends on the existence of a particular document. }
{ When performing an operation such as opening a file, it is more efficient to }
{ simply try the operation and handle failures than to check first for reachability. }
function CFURLResourceIsReachable(url: CFURLRef;
  error: PCFErrorRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLResourceIsReachable';
{$EXTERNALSYM CFURLResourceIsReachable}


{ Properties of File System Resources }

function kCFURLNameKey: CFStringRef;
{$EXTERNALSYM kCFURLNameKey}
{ The resource name provided by the file system (value type CFString) }

function kCFURLLocalizedNameKey: CFStringRef;
{$EXTERNALSYM kCFURLLocalizedNameKey}
{ Localized or extension-hidden name as displayed to users (Read-only, value type CFString) }

function kCFURLIsRegularFileKey: CFStringRef;
{$EXTERNALSYM kCFURLIsRegularFileKey}
{ True for regular files (Read-only, value type CFBoolean) }

function kCFURLIsDirectoryKey: CFStringRef;
{$EXTERNALSYM kCFURLIsDirectoryKey}
{ True for directories (Read-only, CFBoolean) }

function kCFURLIsSymbolicLinkKey: CFStringRef;
{$EXTERNALSYM kCFURLIsSymbolicLinkKey}
{ True for symlinks (Read-only, value type CFBoolean) }

function kCFURLIsVolumeKey: CFStringRef;
{$EXTERNALSYM kCFURLIsVolumeKey}
{ True for the root directory of a volume (Read-only, value type CFBoolean) }

function kCFURLIsPackageKey: CFStringRef;
{$EXTERNALSYM kCFURLIsPackageKey}
{ True for packaged directories (value type CFBoolean) }

function kCFURLIsSystemImmutableKey: CFStringRef;
{$EXTERNALSYM kCFURLIsSystemImmutableKey}
{ True for system-immutable resources (value type CFBoolean) }

function kCFURLIsUserImmutableKey: CFStringRef;
{$EXTERNALSYM kCFURLIsUserImmutableKey}
{ True for user-immutable resources (value type CFBoolean) }

function kCFURLIsHiddenKey: CFStringRef;
{$EXTERNALSYM kCFURLIsHiddenKey}
{ True for resources normally hidden from users (value type CFBoolean) }

function kCFURLHasHiddenExtensionKey: CFStringRef;
{$EXTERNALSYM kCFURLHasHiddenExtensionKey}
{ True for resources whose filename extension is hiden (value type CFBoolean) }

function kCFURLCreationDateKey: CFStringRef;
{$EXTERNALSYM kCFURLCreationDateKey}
{ Value type CFDate }

function kCFURLContentAccessDateKey: CFStringRef;
{$EXTERNALSYM kCFURLContentAccessDateKey}
{ Value type CFDate }

function kCFURLContentModificationDateKey: CFStringRef;
{$EXTERNALSYM kCFURLContentModificationDateKey}
{ Value type CFDate }

function kCFURLAttributeModificationDateKey: CFStringRef;
{$EXTERNALSYM kCFURLAttributeModificationDateKey}
{ Value type CFDate }

function kCFURLLinkCountKey: CFStringRef;
{$EXTERNALSYM kCFURLLinkCountKey}
{ Number of hard links to the resource (Read-only, CFNumber) }

function kCFURLParentDirectoryURLKey: CFStringRef;
{$EXTERNALSYM kCFURLParentDirectoryURLKey}
{ URL of the parent directory, if any (Read-only, value type CFURL) }

function kCFURLVolumeURLKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeURLKey}
{ URL of the volume on which the resource is stored (Read-only, value type CFURL) }

function kCFURLTypeIdentifierKey: CFStringRef;
{$EXTERNALSYM kCFURLTypeIdentifierKey}
{ Uniform type identifier for the resource (Read-only, value type CFString) }

function kCFURLLocalizedTypeDescriptionKey: CFStringRef;
{$EXTERNALSYM kCFURLLocalizedTypeDescriptionKey}
{ User-visible type or "kind" descriptiopn (Read-only, value type CFString) }

function kCFURLLabelNumberKey: CFStringRef;
{$EXTERNALSYM kCFURLLabelNumberKey}
{ The label number assigned to the resource (value type CFNumber) }

function kCFURLLabelColorKey: CFStringRef;
{$EXTERNALSYM kCFURLLabelColorKey}
{ The color of the assigned label (Read-only, value type CGColorRef, must link with Application Services) }

function kCFURLLocalizedLabelKey: CFStringRef;
{$EXTERNALSYM kCFURLLocalizedLabelKey}
{ The user-visible label text (Read-only, value type CFString) }

function kCFURLEffectiveIconKey: CFStringRef;
{$EXTERNALSYM kCFURLEffectiveIconKey}
{ The icon normally displayed for the resource (Read-only, value type CGImageRef, must link with Application Services) }

function kCFURLCustomIconKey: CFStringRef;
{$EXTERNALSYM kCFURLCustomIconKey}
{ The custom icon assigned to the resource, if any (value type CGImageRef, must link with Application Services) }


{ File Properties }

function kCFURLFileSizeKey: CFStringRef;
{$EXTERNALSYM kCFURLFileSizeKey}
{ Total file size, in bytes (Read-only, value type CFNumber) }

function kCFURLFileAllocatedSizeKey: CFStringRef;
{$EXTERNALSYM kCFURLFileAllocatedSizeKey}
{ Total size of blocks allocated (Read-only, value type CFNumber) }

function kCFURLIsAliasFileKey: CFStringRef;
{$EXTERNALSYM kCFURLIsAliasFileKey}
{  true if the url is a Finder alias file, false otherwise ( Read-only, value type CFBooleanRef) }


{ Volume Properties }

{ For convenience, volume properties may be requested from any resource on a volume. }

function kCFURLVolumeLocalizedFormatDescriptionKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeLocalizedFormatDescriptionKey}
{ The user-visible volume format (Read-only, value type CFString) }

function kCFURLVolumeTotalCapacityKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeTotalCapacityKey}
{ Total volume capacity in bytes (Read-only, value type CFNumber) }

function kCFURLVolumeAvailableCapacityKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeAvailableCapacityKey}
{ Total free space, in bytes (Read-only, value type CFNumber) }

function kCFURLVolumeResourceCountKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeResourceCountKey}
{ Total number of resources on the volume (Read-only, value type CFNumber) }

function kCFURLVolumeSupportsPersistentIDsKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeSupportsPersistentIDsKey}
{ Read-only, value type CFBoolean }

function kCFURLVolumeSupportsSymbolicLinksKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeSupportsSymbolicLinksKey}
{ Read-only, value type CFBoolean }

function kCFURLVolumeSupportsHardLinksKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeSupportsHardLinksKey}
{ Read-only, value type CFBoolean }

function kCFURLVolumeSupportsJournalingKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeSupportsJournalingKey}
{ Read-only, value type CFBoolean }

function kCFURLVolumeIsJournalingKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeIsJournalingKey}
{ Read-only, value type CFBoolean }

function kCFURLVolumeSupportsSparseFilesKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeSupportsSparseFilesKey}
{ Read-only, value type CFBoolean }

function kCFURLVolumeSupportsZeroRunsKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeSupportsZeroRunsKey}
{ Read-only, value type CFBoolean }

function kCFURLVolumeSupportsCaseSensitiveNamesKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeSupportsCaseSensitiveNamesKey}
{ Read-only, value type CFBoolean }

function kCFURLVolumeSupportsCasePreservedNamesKey: CFStringRef;
{$EXTERNALSYM kCFURLVolumeSupportsCasePreservedNamesKey}
{ Read-only, value type CFBoolean }

const
  kCFURLBookmarkCreationPreferFileIDResolutionMask = 1 shl 8;         // At resolution time, this alias will prefer resolving by the embedded fileID to the path
  {$EXTERNALSYM kCFURLBookmarkCreationPreferFileIDResolutionMask}
  kCFURLBookmarkCreationMinimalBookmarkMask        = 1 shl 9; // Creates a bookmark with "less" information, which may be smaller but still be able to resolve in certain ways
  {$EXTERNALSYM kCFURLBookmarkCreationMinimalBookmarkMask}
  kCFURLBookmarkCreationSuitableForBookmarkFile    = 1 shl 10;     // includes in the created bookmark those properties which are needed for a bookmark/alias file
  {$EXTERNALSYM kCFURLBookmarkCreationSuitableForBookmarkFile}
type
  CFURLBookmarkCreationOptions = CFOptionFlags;
  {$EXTERNALSYM CFURLBookmarkCreationOptions}

const
  kCFBookmarkResolutionWithoutUIMask       = 1 shl 8;   // don't perform any UI during bookmark resolution
  {$EXTERNALSYM kCFBookmarkResolutionWithoutUIMask}
  kCFBookmarkResolutionWithoutMountingMask = 1 shl 9;        // don't mount a volume during bookmark resolution
  {$EXTERNALSYM kCFBookmarkResolutionWithoutMountingMask}
type
  CFURLBookmarkResolutionOptions = CFOptionFlags;
  {$EXTERNALSYM CFURLBookmarkResolutionOptions}

  CFURLBookmarkFileCreationOptions = CFOptionFlags;
  {$EXTERNALSYM CFURLBookmarkFileCreationOptions}

{ 	@function CFURLCreateBookmarkData
	@discussion	Create a CFDataRef containing an externalizable representation from a CFURLRef, modified with the given options, including ( at the minimum ) any
		properties in the propertiesToInclude array which are retrievable from the given url.
	@param	allocator		the CFAllocator to use to create this object
	@param	url	the CFURLRef to create a bookmark data from.
	@param	options	a set of options which control creation of the bookmark data
	@param resourcePropertiesToInclude	If non-NULL, an CFArrayRef of additional properties copied from the url to include in the created bookmark data.
	@param relativeToURL If non-NULL, the created bookmark will be relative to the given url
	@param error	If non-NULL, on exit will be filled in with a CFErrorRef representing any error which occured during creation of the bookmark data
	@result	A CFDataRef containing an data, which can be later be passed to CFURLCreateByResolvingBookmarkData() or to CFURLCopyPropertiesForKeysFromBookmarkData() / CFURLCopyPropertyForKeyFromBookmarkData() }
function CFURLCreateBookmarkData(allocator: CFAllocatorRef; url: CFURLRef;
  options: CFURLBookmarkCreationOptions;
  resourcePropertiesToInclude: CFArrayRef; relativeToURL: CFURLRef;
  error: PCFErrorRef): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateBookmarkData';
{$EXTERNALSYM CFURLCreateBookmarkData}

{ 	@function CFURLCreateByResolvingBookmarkData
	@discussion Given a CFDataRef created with CFURLCreateBookmarkRepresentation(), return a CFURLRef of the item it was a bookmark to, and
		attempt to pre-cache those properties in propertiesToInclude in the resulting url.  If in the process of resolving the bookmark into the CFURLRef
	 	it points to this determines that  some properties in the bookmark are out of date or not correct for the item it resolves to, set *isStale to YES,
		which the client may want to use to decide to make a new bookmark from the returned item and replace the saved bookmark it has.  If the bookmarked
		item cannot be found, return NULL.  If an error ( other than "original item can not be found" ) occurs during the process, return NULL and fill in error )
	@param	allocator	 the CFAllocator to use to create this object
	@param	 bookmark a CFDataRef containing a bookmark data, created with CFURLCreateBookmarkData
	@param	options options which affect the resolution
	@param relativeToURL If non-NULL, and if the bookmark was created relative to another url, then resolve it relative to this url
	@param resourcePropertiesToInclude If non-NULL, a CFArray containing those properties which the caller would like to already be cached on the given url
	@param isStale If non-NULL, on exit will be set to true if during resolution any of the properties in the bookmark no longer seemed to match the
		corresponding properties on the returned file.  Clients, upon seeing a stale representation, may want to replace whatever stored bookmark data they
		have saved and create a new one.
	@param error	If non-NULL, on exit will be filled in with a CFErrorRef representing any error which occured during resolution of the bookmark data
	@result A CFURLRef of a file which is the closest match to the file the bookmark data }
function CFURLCreateByResolvingBookmarkData(allocator: CFAllocatorRef;
  bookmark: CFDataRef; options: CFURLBookmarkResolutionOptions;
  relativeToURL: CFURLRef; resourcePropertiesToInclude: CFArrayRef;
  isStale: PBoolean; error: PCFErrorRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateByResolvingBookmarkData';
{$EXTERNALSYM CFURLCreateByResolvingBookmarkData}

{ 	@function	CFURLCreatePropertiesForKeysFromBookmarkData
	@discussion	Given a bookmark, return a dictionary of properties ( all properties if propertiesToReturn == NULL ).
				This returns only the properties stored within the bookmark and will not attempt to resolve the bookmark or do i/o.
	@param	allocator	 the CFAllocator to use to create this object
	@param	 bookmark a CFDataRef containing a bookmark data, created with CFURLCreateBookmarkData
	@param	propertiesToReturn a CFArrayRef of the properties of the bookmark data which the client would like returned.
	@result	a CFDictionaryRef containing the values for the properties passed in obtained from the bookmark data ( not by attempting to resolve it or do i/o in any way ) }
function CFURLCreateResourcePropertiesForKeysFromBookmarkData(
  allocator: CFAllocatorRef; resourcePropertiesToReturn: CFArrayRef;
  bookmark: CFDataRef): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateResourcePropertiesForKeysFromBookmarkData';
{$EXTERNALSYM CFURLCreateResourcePropertiesForKeysFromBookmarkData}

{ 	@function	CFURLCreatePropertyForKeyFromBookmarkData
	@discussion	Given a bookmark, return the value for a given property from the bookmark data
				This returns only the properties stored within the bookmark and will not attempt to resolve the bookmark or do i/o.
	@param	allocator	 the CFAllocator to use to create this object
	@param	 bookmark a CFDataRef containing a bookmark data, created with CFURLCreateBookmarkData
	@param	propertyKey the property key to return.
	@result	a CFTypeRef value for the property passed in obtained from the bookmark data ( not by attempting to resolve it or do i/o in any way ) }
function CFURLCreateResourcePropertyForKeyFromBookmarkData(
  allocator: CFAllocatorRef; resourcePropertyKey: CFStringRef;
  bookmark: CFDataRef): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateResourcePropertyForKeyFromBookmarkData';
{$EXTERNALSYM CFURLCreateResourcePropertyForKeyFromBookmarkData}

{ !	@function 	CFURLCreateBookmarkDataFromFile
	@description	Given a fileURL of a file which is a Finder "alias" file, return a CFDataRef with the bookmark data from the file.  If urlRef points to an alias file
			created before SnowLeopard which contains Alias Manager information and no bookmark data, then a CFDataRef will be synthesized which contains
			a approximation of the alias information in a format which can be used to resolve the bookmark.  If an error prevents reading the data or
			if it is corrupt, NULL will be returned and error will be filled in if errorRef is non-NULL.
	@param	allocator the CFAllocator to use to create this object
	@param	fileURL a CFURLRef to to the alias file to create the bookmark data from
	@param	errorRef    if non-NULL, on exit will be filled in with a CFErrorRef representing any error which occurred during the creation of the bookmark data from the file
	@result	A CFDataRef containing bookmark data, or NULL if there was an error creating bookmark data from the file, such as if the file is not an alias file.
 }
function CFURLCreateBookmarkDataFromFile(allocator: CFAllocatorRef;
  fileURL: CFURLRef; errorRef: PCFErrorRef): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateBookmarkDataFromFile';
{$EXTERNALSYM CFURLCreateBookmarkDataFromFile}

{ !	@function	CFURLWriteBookmarkDataToFile
	@description	Given a created bookmarkData object, create a new Finder "alias" file at fileURL which contains the bookmark data.  If fileURL is a url to a directory, an alias file
			will be created with the same name as the bookmarked item and a ".alias" extension.  If fileURL is a url for a file and it exists it will be overwritten.  If a
			.alias extension is not present it will be added.  In addition to the bookmark data, sufficient pre-SnowLeopard alias data will added to the file to allow
			systems running something before SnowLeopard to resolve this file using Alias Manager routines and get back the same file as the bookmark routines.
			The bookmark data must have been created with the kCFURLBookmarkCreationSuitableForBookmarkFile option and an error will be returned if not.
	@param	allocator	 the CFAllocator to use to create this object
	@param	 bookmark a CFDataRef containing a bookmark data, created with CFURLCreateBookmarkData
	@param	options	options flags 
	@param	errorRef    if non-NULL, on exit will be filled in with a CFErrorRef representing any error which occurred during the creation of the alias file
 }
function CFURLWriteBookmarkDataToFile(bookmarkRef: CFDataRef; fileURL: CFURLRef;
  options: CFURLBookmarkFileCreationOptions;
  errorRef: PCFErrorRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLWriteBookmarkDataToFile';
{$EXTERNALSYM CFURLWriteBookmarkDataToFile}

{ !	@function	CFURLCreateBookmarkDataFromAliasRecord
	@discussion	Create a CFDataRef containing bookmarkdata by converting the alias data in aliasRecordDataRef, which should be the contents of an AliasRecord copied into a CFDataRef object.
		The created bookmarkdata can be passed into CFURLCreateByResolvingBookmarkData() to resolve the item into a CFURLRef, or a small set of information can be returned from
		CFURLCreateResourcePropertiesForKeysFromBookmarkData() / CFURLCreateResourcePropertyForKeyFromBookmarkData().
		@param	allocator		the CFAllocator to use to create this object
		@param	aliasRecordDataRef	the contents of an AliasRecord to create bookmark data for
		@result	A CFDataRef containing an data, which can be later be passed to CFURLCreateByResolvingBookmarkData() or to CFURLCopyPropertiesForKeysFromBookmarkData() / CFURLCopyPropertyForKeyFromBookmarkData()
 }
function CFURLCreateBookmarkDataFromAliasRecord(allocatorRef: CFAllocatorRef;
  aliasRecordDataRef: CFDataRef): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateBookmarkDataFromAliasRecord';
{$EXTERNALSYM CFURLCreateBookmarkDataFromAliasRecord}

{$ENDIF !__COREFOUNDATION_CFURL__}

