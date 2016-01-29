{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{
  System.pas and SysInit.pas cannot use the CoreFoundation unit,
  so we manually include the definitions here.
}

const
  CoreFoundationLib = '/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation';

{$IF NOT DECLARED(_PU)}
const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
{$ENDIF}

const
  kCFCompareCaseInsensitive      = 1;
  kCFCompareBackwards            = 4; { Starting from the end of the string }
  kCFCompareAnchored             = 8; { Only at the specified starting point }
  kCFCompareNonliteral           = 16; { If specified, loose equivalence is performed (o-umlaut == o, umlaut) }
  kCFCompareLocalized            = 32; { User's default locale is used for the comparisons }
  kCFCompareNumerically          = 64; { Numeric comparison is used; that is, Foo2.txt < Foo7.txt < Foo25.txt }
  kCFCompareDiacriticInsensitive = 128;   { If specified, ignores diacritics (o-umlaut == o) }
  kCFCompareWidthInsensitive     = 256; { If specified, ignores width differences ('a' == UFF41) }
  kCFCompareForcedOrdering       = 512; { If specified, comparisons are forced to return either kCFCompareLessThan or kCFCompareGreaterThan if the strings are equivalent but not strictly equal, for stability when sorting (e.g. "aaa" > "AAA" with kCFCompareCaseInsensitive specified) }

type
  CFArrayRef = Pointer;
  CFIndex = Integer;
  CFLocaleRef = Pointer;
  CFStringRef = Pointer;
  CFTypeRef = Pointer;
  CFBundleRef = Pointer;
  CFURLRef = Pointer;
  CFAllocatorRef = Pointer;
  CFComparisonResult = CFIndex;
  CFOptionFlags = LongWord;
  CFStringCompareFlags = CFOptionFlags;
  PUniChar = PWideChar;
  CFTypeID = LongWord;

  PCFRange = ^CFRange;
  CFRange = record
    location: CFIndex;
    length: CFIndex;
  end;

var
  _kCFAllocatorNull: Pointer = nil;
  _CFModule: THandle = 0;

function CFNullGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFNullGetTypeID';

procedure CFRelease(cf: CFTypeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFRelease';

function CFLocaleCopyCurrent: CFLocaleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyCurrent';

function CFLocaleGetIdentifier(locale: CFLocaleRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleGetIdentifier';

function CFStringGetLength(theString: CFStringRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetLength';

procedure CFStringGetCharacters(theString: CFStringRef; range: CFRange;
  buffer: MarshaledString); cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetCharacters';

function CFLocaleCopyPreferredLanguages: CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCopyPreferredLanguages';

function CFArrayGetCount(theArray: CFArrayRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFArrayGetCount';

function CFArrayGetValueAtIndex(theArray: CFArrayRef; idx: CFIndex): Pointer; cdecl;
  external CoreFoundationLib name _PU + 'CFArrayGetValueAtIndex';

function CFStringConvertEncodingToWindowsCodepage(
  encoding: UInt32): UInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFStringConvertEncodingToWindowsCodepage';

function CFStringGetSystemEncoding: UInt32; cdecl; 
  external CoreFoundationLib name _PU + 'CFStringGetSystemEncoding';

function CFBundleGetMainBundle: CFBundleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetMainBundle';

function CFBundleCopyResourceURL(bundle: CFBundleRef; resourceName: CFStringRef;
  resourceType: CFStringRef;   subDirName: CFStringRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyResourceURL';

function CFURLCopyFileSystemPath(anURL: CFURLRef; pathStyle: UInt32): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCopyFileSystemPath';

function CFStringCreateWithCharacters(alloc: CFAllocatorRef;
  chars: MarshaledString; numChars: CFIndex): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithCharacters';

function __CFStringMakeConstantString(cStr: MarshaledAString): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + '__CFStringMakeConstantString';

function CFSTR(const cStr: string): CFStringRef;
begin
  Result := __CFStringMakeConstantString(MarshaledAString(UTF8Encode(cStr)));
end;

function CFLocaleCreateCanonicalLocaleIdentifierFromString(
  allocator: CFAllocatorRef; localeIdentifier: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreateCanonicalLocaleIdentifierFromString';

function CFLocaleCreate(allocator: CFAllocatorRef;
  localeIdentifier: CFStringRef): CFLocaleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFLocaleCreate';

function CFStringCompareWithOptionsAndLocale(theString1: CFStringRef;
  theString2: CFStringRef; rangeToCompare: CFRange;
  compareOptions: CFStringCompareFlags; locale: CFLocaleRef): CFComparisonResult; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCompareWithOptionsAndLocale';

function CFStringCreateWithCharactersNoCopy(alloc: CFAllocatorRef;
  chars: PUniChar; numChars: CFIndex; contentsDeallocator: CFAllocatorRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithCharactersNoCopy';

function CFModule: THandle;
begin
  if _CFModule = 0 then
  begin
    CFNullGetTypeID;
    _CFModule := dlopen(MarshaledAString(CoreFoundationLib), RTLD_LAZY);
    dlclose(_CFModule);
  end;
  Result := _CFModule;
end;

function kCFAllocatorNull: CFAllocatorRef;
begin
  if _kCFAllocatorNull = nil then
    _kCFAllocatorNull := dlsym(CFModule, MarshaledAString('kCFAllocatorNull'));
  Result := CFAllocatorRef(_kCFAllocatorNull^);
end;

