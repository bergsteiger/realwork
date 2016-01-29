{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

{*******************************************************}
{               System Utilities Unit                   }
{*******************************************************}

unit System.SysUtils;

{$H+,B-,R-}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN WIDECHAR_REDUCED OFF}
{$WARN UNSAFE_TYPE OFF}

interface
{$IFDEF CPUX86}
  {$DEFINE X86ASM}
{$ELSE !CPUX86}
  {$DEFINE PUREPASCAL}
  {$DEFINE PUREPASCAL_X64ONLY}
{$ENDIF !CPUX86}

{$IF SizeOf(Extended) = 10}
  {$DEFINE EXTENDEDIS10BYTES}
{$ENDIF}

{ !!!NOTE: PLEASE READ BEFORE CONSIDERING MODIFICATIONS TO THIS USES LIST!!!

  The only units allowed in this uses list are units that contain only low-level types, Operating System API imports,
  and resource strings. By ensuring that this uses list only containes units that fit the above categories, we can
  maintain a better level of modularity of the RTL and reduce unintended size expansion. }

uses
  System.Types,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Posix.Dlfcn, Posix.Fcntl, Posix.SysStat, Posix.SysTime, Posix.SysTypes,
{$ENDIF POSIX}
{$IF defined(POSIX) and not defined(IOS)}
  System.Internal.Unwinder,
{$ENDIF POSIX and !IOS}
{$IFDEF MACOS}
  Macapi.Mach, Macapi.CoreServices, Macapi.CoreFoundation,
{$ENDIF MACOS}
  System.SysConst;


const
{$IFDEF MSWINDOWS}
  INVALID_HANDLE_VALUE = Winapi.Windows.INVALID_HANDLE_VALUE;
  {$EXTERNALSYM INVALID_HANDLE_VALUE}
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  INVALID_HANDLE_VALUE = DWORD(-1);
{$ENDIF POSIX}

{ File open modes }

{$IFDEF MSWINDOWS}
  fmOpenRead       = $0000;
  fmOpenWrite      = $0001;
  fmOpenReadWrite  = $0002;
  fmExclusive      = $0004; // when used with FileCreate, atomically creates the file only if it doesn't exist, fails otherwise

  fmShareCompat    = $0000 platform; // DOS compatibility mode is not portable
  fmShareExclusive = $0010;
  fmShareDenyWrite = $0020;
  fmShareDenyRead  = $0030 platform; // write-only not supported on all platforms
  fmShareDenyNone  = $0040;
{$ENDIF}
{$IFDEF POSIX}
  fmOpenRead       = O_RDONLY;
  fmOpenWrite      = O_WRONLY;
  fmOpenReadWrite  = O_RDWR;
  fmExclusive      = $0004; // when used with FileCreate, atomically creates the file only if it doesn't exist, fails otherwise
//  fmShareCompat not supported
                                                                     
  fmShareExclusive = $0010;
  fmShareDenyWrite = $0020;
//  fmShareDenyRead  not supported
  fmShareDenyNone  = $0030;
{$ENDIF}

{ File attribute constants }

  faInvalid     = -1;
  faReadOnly    = $00000001;
  faHidden      = $00000002 platform; // only a convention on POSIX
  faSysFile     = $00000004 platform; // on POSIX system files are not regular files and not directories
  faVolumeID    = $00000008 platform deprecated;  // not used in Win32
  faDirectory   = $00000010;
  faArchive     = $00000020 platform;
  faNormal      = $00000080;
  faTemporary   = $00000100 platform;
  faSymLink     = $00000400 platform; // Available on POSIX and Vista and above
  faCompressed  = $00000800 platform;
  faEncrypted   = $00004000 platform;
  faVirtual     = $00010000 platform;
  faAnyFile     = $000001FF;

{ Units of time }

  HoursPerDay   = 24;
  MinsPerHour   = 60;
  SecsPerMin    = 60;
  MSecsPerSec   = 1000;
  MinsPerDay    = HoursPerDay * MinsPerHour;
  SecsPerDay    = MinsPerDay * SecsPerMin;
  SecsPerHour   = SecsPerMin * MinsPerHour;
  MSecsPerDay   = SecsPerDay * MSecsPerSec;

{ Days between 1/1/0001 and 12/31/1899 }

  DateDelta = 693594;

{ Days between TDateTime basis (12/31/1899) and Unix time_t basis (1/1/1970) }

  UnixDateDelta = 25569;

type

  TBytes = TArray<Byte>;

{ Standard Character set type }
{$IFNDEF NEXTGEN}
  TSysCharSet = set of AnsiChar;
{$ELSE}
  TSysCharSet = set of Char deprecated; // Holds Char values in the ordinal range of 0..255 only.
{$ENDIF}
{ Set access to an integer }

  TIntegerSet = set of 0..SizeOf(Integer) * 8 - 1;

{ Type conversion records }

  WordRec = packed record
    case Integer of
      0: (Lo, Hi: Byte);
      1: (Bytes: array [0..1] of Byte);
  end;

  LongRec = packed record
    case Integer of
      0: (Lo, Hi: Word);
      1: (Words: array [0..1] of Word);
      2: (Bytes: array [0..3] of Byte);
  end;

  Int64Rec = packed record
    case Integer of
      0: (Lo, Hi: Cardinal);
      1: (Cardinals: array [0..1] of Cardinal);
      2: (Words: array [0..3] of Word);
      3: (Bytes: array [0..7] of Byte);
  end;

{ General arrays }

  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;

  PWordArray = ^TWordArray;
  TWordArray = array[0..16383] of Word;

{ Generic procedure pointer }

  TProcedure = procedure;

{ Generic filename type }

  TFileName = type string;

{ Search record used by FindFirst, FindNext, and FindClose }

  TSearchRec = record
  private
    function GetTimeStamp: TDateTime;
  public
{$IFDEF MSWINDOWS}
    Time: Integer platform deprecated;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    Time: time_t platform;
{$ENDIF POSIX}
    Size: Int64;
    Attr: Integer;
    Name: TFileName;
    ExcludeAttr: Integer;
{$IFDEF MSWINDOWS}
    FindHandle: THandle platform;
    FindData: TWin32FindData platform;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    Mode: mode_t platform;
    FindHandle: Pointer platform;
    PathOnly: string platform;
    Pattern: string platform;
{$ENDIF POSIX}
    property TimeStamp: TDateTime read GetTimeStamp;
  end;

  TSymLinkRec = record
  private
    function GetTimeStamp: TDateTime;
  public
    TargetName: TFileName;
    Attr: Integer;
    Size: Int64;
{$IFDEF MSWINDOWS}
    FindData: TWin32FindData platform;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    Time: time_t platform;
    Mode: mode_t platform;
    PathOnly: string platform;
{$ENDIF POSIX}
    property TimeStamp: TDateTime read GetTimeStamp;
  end;

  TDateTimeInfoRec = record
  private
{$IFDEF MSWINDOWS}
    Data: TWin32FindData platform;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    st: _stat platform;
{$ENDIF POSIX}

    function GetCreationTime: TDateTime;
    function GetLastAccessTime: TDateTime;
    function GetTimeStamp: TDateTime;
  public
    property CreationTime: TDateTime read GetCreationTime;
    property LastAccessTime: TDateTime read GetLastAccessTime;
    property TimeStamp: TDateTime read GetTimeStamp;
  end;

{ FloatToText, FloatToTextFmt, TextToFloat, and FloatToDecimal type codes }

  TFloatValue = (fvExtended, fvCurrency);

{ FloatToText format codes }

  TFloatFormat = (ffGeneral, ffExponent, ffFixed, ffNumber, ffCurrency);

{ FloatToDecimal result record }

  TFloatRec = packed record
    Exponent: Smallint;
    Negative: Boolean;
    Digits: array[0..20] of Byte;
  end;

{ Date and time record }

  TTimeStamp = record
    Time: Integer;      { Number of milliseconds since midnight }
    Date: Integer;      { One plus number of days since 1/1/0001 }
  end;

{ MultiByte Character Set (MBCS) byte type }
  TMbcsByteType = (mbSingleByte, mbLeadByte, mbTrailByte);

type
{$IFDEF MSWINDOWS}
  TLocaleID = LCID;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
  TLocaleID = CFLocaleRef;
{$ENDIF MACOS}
{$IFDEF LINUX}
  TLocaleID = locale_t;
{$ENDIF LINUX}

{ System Locale information record }
  TSysLocale = packed record
    DefaultLCID: TLocaleID;
    PriLangID: Integer;
    SubLangID: Integer;
    FarEast: Boolean;
    MiddleEast: Boolean;
  end;

{ This is used by TLanguages }
  TLangRec = packed record
    FName: string;
    FLCID: TLocaleID;
    FExt: string;
    FLocaleName: string;
  end;

type
{ This stores the languages that the system supports }
  TLanguages = class
  private
{$IFDEF POSIX}
    class var FDefaultLocale: TLocaleID;
{$ENDIF}
    FSysLangs: TArray<TLangRec>;
    class destructor Destroy;
{$IFDEF MSWINDOWS}
    function LocalesCallback(LocaleID: PChar): Integer;
{$ENDIF}
{$IFDEF LINUX}
    procedure LoadAvailablePOSIXLocales(); stdcall;
{$ENDIF}
    function GetExt(Index: Integer): string;
    function GetID(Index: Integer): string;
    function GetLocaleID(Index: Integer): TLocaleID;
    function GetLocaleName(Index: Integer): string;
    function GetName(Index: Integer): string;
    function GetNameFromLocaleID(ID: TLocaleID): string;
    function GetNameFromLCID(const ID: string): string;
    function GetLocaleIDFromName(const LocaleName: string): TLocaleID;
    function GetCount: Integer;
    class function GetUserDefaultLocale: TLocaleID; static;
  public
    constructor Create;
    destructor Destroy; override;

    class function GetLocaleIDFromLocaleName(const LocaleName: string): TLocaleID; static;
    function IndexOf(ID: TLocaleID): Integer; overload;
    function IndexOf(const LocaleName: string): Integer; overload;
    property Count: Integer read GetCount;
    property Name[Index: Integer]: string read GetName;
    property NameFromLocaleID[ID: TLocaleID]: string read GetNameFromLocaleID;
    property NameFromLCID[const ID: string]: string read GetNameFromLCID;
    property ID[Index: Integer]: string read GetID;
    property LocaleName[Index: Integer]: string read GetLocaleName;
    property LocaleID[Index: Integer]: TLocaleID read GetLocaleID;
    property LocaleIDFromName[const LocaleName: string]: TLocaleID read GetLocaleIDFromName;
    property Ext[Index: Integer]: string read GetExt;
    class property UserDefaultLocale: TLocaleID read GetUserDefaultLocale;
  end;

{$IFDEF POSIX}
  TEraRange = record
    StartDate : Integer;         // whole days since 12/31/1899 (TDateTime basis)
    EndDate   : Integer;         // whole days since 12/31/1899 (TDateTime basis)
  end;
{$ENDIF}

{ Exceptions }

  PExceptionRecord = System.PExceptionRecord;

  Exception = class(TObject)
  private
    FMessage: string;
    FHelpContext: Integer;
    FInnerException: Exception;
    FStackInfo: Pointer;
    FAcquireInnerException: Boolean;
    class constructor Create;
    class destructor Destroy;
  protected
    procedure SetInnerException;
    procedure SetStackInfo(AStackInfo: Pointer);
    function GetStackTrace: string;
    // This virtual function will be called right before this exception is about to be
    // raised. In the case of an external non-Delphi exception, this is called soon after
    // the object is created since the "raise" condition is already in progress.
    procedure RaisingException(P: PExceptionRecord); virtual;
  public
    constructor Create(const Msg: string);
    constructor CreateFmt(const Msg: string; const Args: array of const);
{$IFNDEF NEXTGEN}
    constructor CreateRes(Ident: NativeUInt); overload;
{$ENDIF !NEXTGEN}
    constructor CreateRes(ResStringRec: PResStringRec); {$IFNDEF NEXTGEN} overload; {$ENDIF !NEXTGEN}
{$IFNDEF NEXTGEN}
    constructor CreateResFmt(Ident: NativeUInt; const Args: array of const); overload;
{$ENDIF !NEXTGEN}
    constructor CreateResFmt(ResStringRec: PResStringRec; const Args: array of const); {$IFNDEF NEXTGEN} overload; {$ENDIF !NEXTGEN}
    constructor CreateHelp(const Msg: string; AHelpContext: Integer);
    constructor CreateFmtHelp(const Msg: string; const Args: array of const;
      AHelpContext: Integer);
{$IFNDEF NEXTGEN}
    constructor CreateResHelp(Ident: NativeUInt; AHelpContext: Integer); overload;
{$ENDIF !NEXTGEN}
    constructor CreateResHelp(ResStringRec: PResStringRec; AHelpContext: Integer); {$IFNDEF NEXTGEN} overload; {$ENDIF !NEXTGEN}
    constructor CreateResFmtHelp(ResStringRec: PResStringRec; const Args: array of const;
      AHelpContext: Integer); {$IFNDEF NEXTGEN} overload; {$ENDIF !NEXTGEN}
{$IFNDEF NEXTGEN}
    constructor CreateResFmtHelp(Ident: NativeUInt; const Args: array of const;
      AHelpContext: Integer); overload;
{$ENDIF !NEXTGEN}
    destructor Destroy; override;
    function GetBaseException: Exception; virtual;
    function ToString: string; override;
    property BaseException: Exception read GetBaseException;
    property HelpContext: Integer read FHelpContext write FHelpContext;
    property InnerException: Exception read FInnerException;
    property Message: string read FMessage write FMessage;
    property StackTrace: string read GetStackTrace;
    property StackInfo: Pointer read FStackInfo;
  class var
    // Hook this function to return an opaque data structure that contains stack information
    // for the given exception information record. This function will be called when the
    // exception is about to be raised or if this is an external exception such as an
    // Access Violation, called soon after the object is created.
    GetExceptionStackInfoProc: function (P: PExceptionRecord): Pointer;
    // This function is called to return a string representation of the above opaque
    // data structure
    GetStackInfoStringProc: function (Info: Pointer): string;
    // This function is called when the destructor is called to clean up any data associated
    // with the given opaque data structure.
    CleanUpStackInfoProc: procedure (Info: Pointer);
    // Use this function to raise an exception instance from within an exception handler and
    // you want to "acquire" the active exception and chain it to the new exception and preserve
    // the context. This will cause the FInnerException field to get set with the exception
    // in currently in play.
    // You should only call this procedure from within an except block where the this new
    // exception is expected to be handled elsewhere.
    class procedure RaiseOuterException(E: Exception); static;
    // Provide another method that does the same thing as RaiseOuterException, but uses the
    // C++ vernacular of "throw"
    class procedure ThrowOuterException(E: Exception); static;
  end;

  EArgumentException = class(Exception);
  EArgumentOutOfRangeException = class(EArgumentException);
  EArgumentNilException = class(EArgumentException);

  EPathTooLongException = class(Exception);
  ENotSupportedException = class(Exception);
  EDirectoryNotFoundException = class(Exception);
  EFileNotFoundException = class(Exception);

  EListError = class(Exception);

  EInvalidOpException = class(Exception);

  ENoConstructException = class(Exception);

  ExceptClass = class of Exception;

  EAbort = class(Exception);

  EHeapException = class(Exception)
{$IFNDEF AUTOREFCOUNT}
  private
    AllowFree: Boolean;
{$ENDIF}
  protected
    procedure RaisingException(P: PExceptionRecord); override;
  public
{$IFNDEF AUTOREFCOUNT}
    procedure FreeInstance; override;
{$ENDIF}
  end;

  EOutOfMemory = class(EHeapException);

  EInOutError = class(Exception)
  public
    ErrorCode: Integer;
  end;

  EExternal = class(Exception)
  public
{$IFDEF MSWINDOWS}
    ExceptionRecord: PExceptionRecord platform;
{$ENDIF}
{$IF defined(LINUX) or defined(MACOS)}
    ExceptionAddress: LongWord platform;
    AccessAddress: LongWord platform;
    SignalNumber: Integer platform;
{$ENDIF LINUX or MACOS}
  end;

  EExternalException = class(EExternal);

  EIntError = class(EExternal);
  EDivByZero = class(EIntError);
  ERangeError = class(EIntError);
  EIntOverflow = class(EIntError);

  EMathError = class(EExternal);
  EInvalidOp = class(EMathError);
  EZeroDivide = class(EMathError);
  EOverflow = class(EMathError);
  EUnderflow = class(EMathError);

  EInvalidPointer = class(EHeapException);

  EInvalidCast = class(Exception);

  EConvertError = class(Exception);

  EAccessViolation = class(EExternal);
  EPrivilege = class(EExternal);
  EStackOverflow = class(EExternal)
    end deprecated;
  EControlC = class(EExternal);
{$IF defined(LINUX) or defined(MACOS)}
  EQuit = class(EExternal) end platform;
{$ENDIF}

{$IFDEF POSIX}
  ECodesetConversion = class(Exception) end platform;
{$ENDIF POSIX}

  EVariantError = class(Exception);
  EPropReadOnly = class(Exception);
  EPropWriteOnly = class(Exception);
  EAssertionFailed = class(Exception);
  EAbstractError = class(Exception);
  EIntfCastError = class(Exception);
  EInvalidContainer = class(Exception);
  EInvalidInsert = class(Exception);
  EPackageError = class(Exception);
  ECFError = class(Exception);

  EOSError = class(Exception)
  public
    ErrorCode: DWORD;
  end;

{$IFDEF MSWINDOWS}
  EWin32Error = class(EOSError)
  end deprecated;
{$ENDIF}

  ESafecallException = class(Exception);

  EMonitor = class(Exception);
  EMonitorLockException = class(EMonitor);
  ENoMonitorSupportException = class(EMonitor);

  EProgrammerNotFound = class(Exception);

  ENotImplemented = class(Exception);

  EObjectDisposed = class(Exception);

{$IF defined(LINUX) or defined(MACOS)}

{
        Signals

    External exceptions, or signals, are, by default, converted to language
    exceptions by the Delphi RTL.  Under Linux, a Delphi application installs
    signal handlers to trap the raw signals, and convert them.  Delphi libraries
    do not install handlers by default.  So if you are implementing a standalone
    library, such as an Apache DSO, and you want to have signals converted to
    language exceptions that you can catch, you must install signal hooks
    manually, using the interfaces that the Delphi RTL provides.

    For most libraries, installing signal handlers is pretty
    straightforward.  Call HookSignal(RTL_SIGDEFAULT) at initialization time,
    and UnhookSignal(RTL_SIGNALDEFAULT) at shutdown.  This will install handlers
    for a set of signals that the RTL normally hooks for Delphi applications.

    There are some cases where the above initialization will not work properly:
    The proper behaviour for setting up signal handlers is to set
    a signal handler, and then later restore the signal handler to its previous
    state when you clean up.  If you have two libraries lib1 and lib2, and lib1
    installs a signal handler, and then lib2 installs a signal handler, those
    libraries have to uninstall in the proper order if they restore signal
    handlers, or the signal handlers can be left in an inconsistent and
    potentially fatal state.  Not all libraries behave well with respect to
    installing signal handlers.  To hedge against this possibility, and allow
    you to manage signal handlers better in the face of whatever behaviour
    you may find in external libraries, we provide a set of four interfaces to
    allow you to tailor the Delphi signal handler hooking/unhooking in the
    event of an emergency.  These are:
        InquireSignal
        AbandonSignalHandler
        HookSignal
        UnhookSignal

    InquireSignal allows you to look at the state of a signal handler, so
    that you can find out if someone grabbed it out from under you.

    AbandonSignalHandler tells the RTL never to unhook a particular
    signal handler.  This can be used if you find a case where it would
    be unsafe to return to the previous state of signal handling.  For
    example, if the previous signal handler was installed by a library
    which has since been unloaded.

    HookSignal/UnhookSignal setup signal handlers that map certain signals
    into language exceptions.

    See additional notes at InquireSignal, et al, below.
}

const
    RTL_SIGINT          = 0;    // User interrupt (SIGINT)
{$IFDEF MACOS}
    RTL_SIGQUIT         = 1;    // User interrupt (SIGQUIT)
{$ENDIF MACOS}
{$IFDEF LINUX}
    RTL_SIGFPE          = 1;    // Floating point exception (SIGFPE)
    RTL_SIGSEGV         = 2;    // Segmentation violation (SIGSEGV)
    RTL_SIGILL          = 3;    // Illegal instruction (SIGILL)
    RTL_SIGBUS          = 4;    // Bus error (SIGBUS)
    RTL_SIGQUIT         = 5;    // User interrupt (SIGQUIT)
{$ENDIF LINUX}
    RTL_SIGLAST         = RTL_SIGQUIT; // Used internally.  Don't use this.
    RTL_SIGDEFAULT      = -1;   // Means all of a set of signals that the we capture
                                // normally.  This is currently all of the preceding
                                // signals.  You cannot pass this to InquireSignal.

type
    { TSignalState is the state of a given signal handler, as returned by
      InquireSignal.  See InquireSignal, below.
    }
    TSignalState = (ssNotHooked, ssHooked, ssOverridden);

var

  {
    If DeferUserInterrupts is set, we do not raise either SIGINT or SIGQUIT as
    an exception, instead, we set SIGINTIssued or SIGQUITIssued when the
    signal arrives, and swallow the signal where the OS issued it.  This gives
    GUI applications the chance to defer the actual handling of the signal
    until a time when it is safe to do so.
  }

  DeferUserInterrupts: Boolean;
  SIGINTIssued: Boolean;
  SIGQUITIssued: Boolean;
{$ENDIF LINUX or MACOS}

{$IFNDEF MSWINDOWS}
const
  MAX_PATH =
{$IFDEF LINUX}
     4095;  // From /usr/include/linux/limits.h PATH_MAX
{$ENDIF LINUX}
{$IFDEF MACOS}
     1024;
{$ENDIF MACOS}
{$ENDIF !MSWINDOWS}

var

{ Empty string and null string pointer. These constants are provided for
  backwards compatibility only.  }

  EmptyStr: string = '';
{$IFNDEF NEXTGEN}
  NullStr: PString = @EmptyStr;

  EmptyWideStr: WideString = '';
  NullWideStr: PWideString = @EmptyWideStr;

  EmptyAnsiStr: AnsiString = '';
  NullAnsiStr: PAnsiString = @EmptyAnsiStr;
{$ENDIF !NEXTGEN}
{$IFDEF MSWINDOWS}
{ Win32 platform identifier.  This will be one of the following values:

    VER_PLATFORM_WIN32s
    VER_PLATFORM_WIN32_WINDOWS
    VER_PLATFORM_WIN32_NT

  See WINDOWS.PAS for the numerical values. }

  Win32Platform: Integer = 0;

{ Win32 OS version information -

  see TOSVersionInfo.dwMajorVersion/dwMinorVersion/dwBuildNumber }

  Win32MajorVersion: Integer = 0;
  Win32MinorVersion: Integer = 0;
  Win32BuildNumber: Integer = 0;

{ Win32 OS extra version info string -

  see TOSVersionInfo.szCSDVersion }

  Win32CSDVersion: string = '';

{ Win32 OS version tester }

function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;

{ GetFileVersion returns the most significant 32 bits of a file's binary
  version number. Typically, this includes the major and minor version placed
  together in one 32-bit integer. It generally does not include the release
  or build numbers. It returns Cardinal(-1) if it failed. }
function GetFileVersion(const AFileName: string): Cardinal;

{$ENDIF MSWINDOWS}

{ Currency and date/time formatting options

  The initial values of these variables are fetched from the system registry
  using the GetLocaleInfo function in the Win32 API. The description of each
  variable specifies the LOCALE_XXXX constant used to fetch the initial
  value.

  CurrencyString - Defines the currency symbol used in floating-point to
  decimal conversions. The initial value is fetched from LOCALE_SCURRENCY.

  CurrencyFormat - Defines the currency symbol placement and separation
  used in floating-point to decimal conversions. Possible values are:

    0 = '$1'
    1 = '1$'
    2 = '$ 1'
    3 = '1 $'

  The initial value is fetched from LOCALE_ICURRENCY.

  NegCurrFormat - Defines the currency format for used in floating-point to
  decimal conversions of negative numbers. Possible values are:

    0 = '($1)'      4 = '(1$)'      8 = '-1 $'      12 = '$ -1'
    1 = '-$1'       5 = '-1$'       9 = '-$ 1'      13 = '1- $'
    2 = '$-1'       6 = '1-$'      10 = '1 $-'      14 = '($ 1)'
    3 = '$1-'       7 = '1$-'      11 = '$ 1-'      15 = '(1 $)'

  The initial value is fetched from LOCALE_INEGCURR.

  ThousandSeparator - The character used to separate thousands in numbers
  with more than three digits to the left of the decimal separator. The
  initial value is fetched from LOCALE_STHOUSAND.  A value of #0 indicates
  no thousand separator character should be output even if the format string
  specifies thousand separators.

  DecimalSeparator - The character used to separate the integer part from
  the fractional part of a number. The initial value is fetched from
  LOCALE_SDECIMAL.  DecimalSeparator must be a non-zero value.

  CurrencyDecimals - The number of digits to the right of the decimal point
  in a currency amount. The initial value is fetched from LOCALE_ICURRDIGITS.

  DateSeparator - The character used to separate the year, month, and day
  parts of a date value. The initial value is fetched from LOCATE_SDATE.

  ShortDateFormat - The format string used to convert a date value to a
  short string suitable for editing. For a complete description of date and
  time format strings, refer to the documentation for the FormatDate
  function. The short date format should only use the date separator
  character and the  m, mm, d, dd, yy, and yyyy format specifiers. The
  initial value is fetched from LOCALE_SSHORTDATE.

  LongDateFormat - The format string used to convert a date value to a long
  string suitable for display but not for editing. For a complete description
  of date and time format strings, refer to the documentation for the
  FormatDate function. The initial value is fetched from LOCALE_SLONGDATE.

  TimeSeparator - The character used to separate the hour, minute, and
  second parts of a time value. The initial value is fetched from
  LOCALE_STIME.

  TimeAMString - The suffix string used for time values between 00:00 and
  11:59 in 12-hour clock format. The initial value is fetched from
  LOCALE_S1159.

  TimePMString - The suffix string used for time values between 12:00 and
  23:59 in 12-hour clock format. The initial value is fetched from
  LOCALE_S2359.

  ShortTimeFormat - The format string used to convert a time value to a
  short string with only hours and minutes. The default value is computed
  from LOCALE_ITIME and LOCALE_ITLZERO.

  LongTimeFormat - The format string used to convert a time value to a long
  string with hours, minutes, and seconds. The default value is computed
  from LOCALE_ITIME and LOCALE_ITLZERO.

  ShortMonthNames - Array of strings containing short month names. The mmm
  format specifier in a format string passed to FormatDate causes a short
  month name to be substituted. The default values are fecthed from the
  LOCALE_SABBREVMONTHNAME system locale entries.

  LongMonthNames - Array of strings containing long month names. The mmmm
  format specifier in a format string passed to FormatDate causes a long
  month name to be substituted. The default values are fecthed from the
  LOCALE_SMONTHNAME system locale entries.

  ShortDayNames - Array of strings containing short day names. The ddd
  format specifier in a format string passed to FormatDate causes a short
  day name to be substituted. The default values are fecthed from the
  LOCALE_SABBREVDAYNAME system locale entries.

  LongDayNames - Array of strings containing long day names. The dddd
  format specifier in a format string passed to FormatDate causes a long
  day name to be substituted. The default values are fecthed from the
  LOCALE_SDAYNAME system locale entries.

  ListSeparator - The character used to separate items in a list.  The
  initial value is fetched from LOCALE_SLIST.

  TwoDigitYearCenturyWindow - Determines what century is added to two
  digit years when converting string dates to numeric dates.  This value
  is subtracted from the current year before extracting the century.
  This can be used to extend the lifetime of existing applications that
  are inextricably tied to 2 digit year data entry.  The best solution
  to Year 2000 (Y2k) issues is not to accept 2 digit years at all - require
  4 digit years in data entry to eliminate century ambiguities.

  Examples:

  Current TwoDigitCenturyWindow  Century  StrToDate() of:
  Year    Value                  Pivot    '01/01/03' '01/01/68' '01/01/50'
  -------------------------------------------------------------------------
  1998    0                      1900     1903       1968       1950
  2002    0                      2000     2003       2068       2050
  1998    50 (default)           1948     2003       1968       1950
  2002    50 (default)           1952     2003       1968       2050
  2020    50 (default)           1970     2003       2068       2050
 }

const
  { Specifies the default value of the TwoDigitCenturyWindow }
  CDefaultTwoDigitYearCenturyWindow = 50;

var
  SysLocale: TSysLocale;


{ Thread safe currency and date/time formatting

  The TFormatSettings record is designed to allow thread safe formatting,
  equivalent to the gloabal variables described above. Each of the
  formatting routines that use the gloabal variables have overloaded
  equivalents, requiring an additional parameter of type TFormatSettings.

  A TFormatSettings record must be populated before use. This can be done
  by calling TFormatSettings.Create and specifying the desired locale. To
  create a TFormatSettings record with the current default call the
  parameterless function Create or pass an empty string as the LocaleName.
  Note that some format specifiers still require specific thread locale
  settings (such as period/era names). }

type
  TFormatSettings = record
  strict private
{$IF DEFINED(MSWINDOWS) OR DEFINED(LINUX)}
    class function AdjustLocaleName(const LocaleName: string): string; static;
    class procedure GetDayNames(Locale: TLocaleID; var AFormatSettings: TFormatSettings); static;
    class procedure GetMonthNames(Locale: TLocaleID; var AFormatSettings: TFormatSettings); static;
    class function GetString(Locale: TLocaleID; LocaleItem, DefaultIndex: Integer;
      const DefaultValues: array of Pointer): string; static;
{$ENDIF}
{$IF DEFINED(MACOS)}
    class procedure GetDayNames(Formatter: CFDateFormatterRef; var AFormatSettings: TFormatSettings); static;
    class procedure GetMonthNames(Formatter: CFDateFormatterRef; var AFormatSettings: TFormatSettings); static;
{$ENDIF}
    class function TranslateDateFormat(Locale: TLocaleID; LocaleType: Integer;
      const Default: string; const Separator: Char): string; static;
  public
    CurrencyString: string;
    CurrencyFormat: Byte;
    CurrencyDecimals: Byte;
    DateSeparator: Char;
    TimeSeparator: Char;
    ListSeparator: Char;
    ShortDateFormat: string;
    LongDateFormat: string;
    TimeAMString: string;
    TimePMString: string;
    ShortTimeFormat: string;
    LongTimeFormat: string;
    ShortMonthNames: array[1..12] of string;
    LongMonthNames: array[1..12] of string;
    ShortDayNames: array[1..7] of string;
    LongDayNames: array[1..7] of string;
    ThousandSeparator: Char;
    DecimalSeparator: Char;
    TwoDigitYearCenturyWindow: Word;
    NegCurrFormat: Byte;
    // Creates a TFormatSettings record with current default values provided
    // by the operating system.
    class function Create: TFormatSettings; overload; static; inline;
    // Creates a TFormatSettings record with values provided by the operating
    // system for the specified locale. The locale is an LCID on Windows
    // platforms, or a locale_t on Posix platforms.
    class function Create(Locale: TLocaleID): TFormatSettings; overload; platform; static;
    // Creates a TFormatSettings record with values provided by the operating
    // system for the specified locale name in the "Language-Country" format.
    // Example: 'en-US' for U.S. English settings or 'en-GB' for UK English settings.
    class function Create(const LocaleName: string): TFormatSettings; overload; static;
  end;

  TLocaleOptions = (loInvariantLocale, loUserLocale);

var
  // Note: Using the global FormatSettings formatting variables is not thread-safe.
  FormatSettings: TFormatSettings;

const
{$IFDEF MACOS}
  MaxEraCount = 238;
{$ELSE !MACOS}
  MaxEraCount = 7;
{$ENDIF MACOS}

var
  EraNames: array [1..MaxEraCount] of string;
  EraYearOffsets: array [1..MaxEraCount] of Integer;
{$IFDEF POSIX}
  EraRanges : array [1..MaxEraCount] of TEraRange platform;
  EraYearFormats: array [1..MaxEraCount] of string platform;
  EraCount: Byte platform;
{$ENDIF POSIX}

const
  PathDelim  = {$IFDEF MSWINDOWS} '\'; {$ELSE} '/'; {$ENDIF}
  DriveDelim = {$IFDEF MSWINDOWS} ':'; {$ELSE} '';  {$ENDIF}
  PathSep    = {$IFDEF MSWINDOWS} ';'; {$ELSE} ':'; {$ENDIF}

function Languages: TLanguages;

{ Exit procedure handling }

{ AddExitProc adds the given procedure to the run-time library's exit
  procedure list. When an application terminates, its exit procedures are
  executed in reverse order of definition, i.e. the last procedure passed
  to AddExitProc is the first one to get executed upon termination. }

procedure AddExitProc(Proc: TProcedure);

{ String handling routines }

{$IFNDEF NEXTGEN}
{ NewStr allocates a string on the heap. NewStr is provided for backwards
  compatibility only. }

function NewStr(const S: AnsiString): PAnsiString; deprecated;

{ DisposeStr disposes a string pointer that was previously allocated using
  NewStr. DisposeStr is provided for backwards compatibility only. }

procedure DisposeStr(P: PAnsiString); deprecated;

{ AssignStr assigns a new dynamically allocated string to the given string
  pointer. AssignStr is provided for backwards compatibility only. }

procedure AssignStr(var P: PAnsiString; const S: AnsiString); deprecated;

{ AppendStr appends S to the end of Dest. AppendStr is provided for
  backwards compatibility only. Use "Dest := Dest + S" instead. }

procedure AppendStr(var Dest: AnsiString; const S: AnsiString); deprecated;
{$ENDIF !NEXTGEN}

{ UpperCase converts all ASCII characters in the given string to upper case.
  The conversion affects only 7-bit ASCII characters between 'a' and 'z'. To
  convert 8-bit international characters, use AnsiUpperCase. }

function UpperCase(const S: string): string; overload;
function UpperCase(const S: string; LocaleOptions: TLocaleOptions): string; overload; inline;

{ LowerCase converts all ASCII characters in the given string to lower case.
  The conversion affects only 7-bit ASCII characters between 'A' and 'Z'. To
  convert 8-bit international characters, use AnsiLowerCase. }

function LowerCase(const S: string): string; overload;
function LowerCase(const S: string; LocaleOptions: TLocaleOptions): string; overload; inline;

{ CompareStr compares S1 to S2, with case-sensitivity. The return value is
  less than 0 if S1 < S2, 0 if S1 = S2, or greater than 0 if S1 > S2. The
  compare operation is based on the 8-bit ordinal value of each character
  and is not affected by the current user locale. }

function CompareStr(const S1, S2: string): Integer; overload;
function CompareStr(const S1, S2: string; LocaleOptions: TLocaleOptions): Integer; overload;

{ SameStr compares S1 to S2, with case-sensitivity. Returns true if
  S1 and S2 are the equal, that is, if CompareStr would return 0. }

function SameStr(const S1, S2: string): Boolean; overload; inline;
function SameStr(const S1, S2: string; LocaleOptions: TLocaleOptions): Boolean; overload;

{ CompareMem performs a binary compare of Length bytes of memory referenced
  by P1 to that of P2.  CompareMem returns True if the memory referenced by
  P1 is identical to that of P2. }

function CompareMem(P1, P2: Pointer; Length: Integer): Boolean;

{ CompareText compares S1 to S2, without case-sensitivity. The return value
  is the same as for CompareStr. The compare operation is based on the 8-bit
  ordinal value of each character, after converting 'a'..'z' to 'A'..'Z',
  and is not affected by the current user locale. }

function CompareText(const S1, S2: string): Integer; overload;
function CompareText(const S1, S2: string; LocaleOptions: TLocaleOptions): Integer; overload;

{ SameText compares S1 to S2, without case-sensitivity. Returns true if
  S1 and S2 are the equal, that is, if CompareText would return 0. SameText
  has the same 8-bit limitations as CompareText }

function SameText(const S1, S2: string): Boolean; overload; inline;
function SameText(const S1, S2: string; LocaleOptions: TLocaleOptions): Boolean; overload;

{ AnsiUpperCase converts all characters in the given string to upper case.
  The conversion uses the current user locale. }

function AnsiUpperCase(const S: string): string; overload;

{ AnsiLowerCase converts all characters in the given string to lower case.
  The conversion uses the current user locale. }

function AnsiLowerCase(const S: string): string; overload;

{ AnsiCompareStr compares S1 to S2, with case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is the same as for CompareStr. }

function AnsiCompareStr(const S1, S2: string): Integer; overload;

{ AnsiSameStr compares S1 to S2, with case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is True if AnsiCompareStr would have returned 0. }

function AnsiSameStr(const S1, S2: string): Boolean; inline; overload;

{ AnsiCompareText compares S1 to S2, without case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is the same as for CompareStr. }

function AnsiCompareText(const S1, S2: string): Integer; overload;

{ AnsiSameText compares S1 to S2, without case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is True if AnsiCompareText would have returned 0. }

function AnsiSameText(const S1, S2: string): Boolean; inline; overload;

{ AnsiStrComp compares S1 to S2, with case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is the same as for CompareStr. }

{$IFNDEF NEXTGEN}
function AnsiStrComp(S1, S2: PAnsiChar): Integer; inline; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrComp(S1, S2: PWideChar): Integer; {$IFDEF MSWINDOWS} inline; {$ENDIF} overload;

{ AnsiStrIComp compares S1 to S2, without case-sensitivity. The compare
  operation is controlled by the current user locale. The return value
  is the same as for CompareStr. }

{$IFNDEF NEXTGEN}
function AnsiStrIComp(S1, S2: PAnsiChar): Integer; inline; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrIComp(S1, S2: PWideChar): Integer; {$IFDEF MSWINDOWS} inline; {$ENDIF} overload;

{ AnsiStrLComp compares S1 to S2, with case-sensitivity, up to a maximum
  length of MaxLen bytes. The compare operation is controlled by the
  current user locale. The return value is the same as for CompareStr. }

{$IFNDEF NEXTGEN}
function AnsiStrLComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrLComp(S1, S2: PWideChar; MaxLen: Cardinal): Integer; overload;

{ AnsiStrLIComp compares S1 to S2, without case-sensitivity, up to a maximum
  length of MaxLen bytes. The compare operation is controlled by the
  current user locale. The return value is the same as for CompareStr. }

{$IFNDEF NEXTGEN}
function AnsiStrLIComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrLIComp(S1, S2: PWideChar; MaxLen: Cardinal): Integer; overload;

{ AnsiStrLower converts all characters in the given string to lower case.
  The conversion uses the current user locale. }

{$IFNDEF NEXTGEN}
function AnsiStrLower(Str: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrLower(Str: PWideChar): PWideChar; {$IFDEF MSWINDOWS}inline;{$ENDIF} overload;

{ AnsiStrUpper converts all characters in the given string to upper case.
  The conversion uses the current user locale. }

{$IFNDEF NEXTGEN}
function AnsiStrUpper(Str: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrUpper(Str: PWideChar): PWideChar; {$IFDEF MSWINDOWS}inline;{$ENDIF} overload;

{ AnsiLastChar returns a pointer to the last full character in the string.
  This function supports multibyte characters  }
{ AnsiStrLastChar returns a pointer to the last full character in the string.
  This function supports multibyte characters.  }

{$IFNDEF NEXTGEN}
function AnsiStrLastChar(P: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrLastChar(P: PWideChar): PWideChar; overload;

function AnsiLastChar(const S: UnicodeString): PWideChar; overload;
{$IFNDEF NEXTGEN}
{ WideUpperCase converts all characters in the given string to upper case. }

function WideUpperCase(const S: WideString): WideString;

{ WideLowerCase converts all characters in the given string to lower case. }

function WideLowerCase(const S: WideString): WideString;

{ WideCompareStr compares S1 to S2, with case-sensitivity. The return value
  is the same as for CompareStr. }

function WideCompareStr(const S1, S2: WideString): Integer;

{ WideSameStr compares S1 to S2, with case-sensitivity. The return value
  is True if WideCompareStr would have returned 0. }

function WideSameStr(const S1, S2: WideString): Boolean; inline;

{ WideCompareText compares S1 to S2, without case-sensitivity. The return value
  is the same as for CompareStr. }

function WideCompareText(const S1, S2: WideString): Integer;

{ WideSameText compares S1 to S2, without case-sensitivity. The return value
  is True if WideCompareText would have returned 0. }

function WideSameText(const S1, S2: WideString): Boolean; inline;
{$ENDIF !NEXTGEN}

{ Trim trims leading and trailing spaces and control characters from the
  given string. }

function Trim(const S: string): string; overload;

{ TrimLeft trims leading spaces and control characters from the given
  string. }

function TrimLeft(const S: string): string; overload;

{ TrimRight trims trailing spaces and control characters from the given
  string. }

function TrimRight(const S: string): string; overload;

{ QuotedStr returns the given string as a quoted string. A single quote
  character is inserted at the beginning and the end of the string, and
  for each single quote character in the string, another one is added. }

function QuotedStr(const S: string): string; overload;

{ AnsiQuotedStr returns the given string as a quoted string, using the
  provided Quote character.  A Quote character is inserted at the beginning
  and end of the string, and each Quote character in the string is doubled.
  This function supports multibyte character strings (MBCS). }

function AnsiQuotedStr(const S: string; Quote: Char): string; overload;

{ AnsiExtractQuotedStr removes the Quote characters from the beginning and end
  of a quoted string, and reduces pairs of Quote characters within the quoted
  string to a single character. If the first character in Src is not the Quote
  character, the function returns an empty string.  The function copies
  characters from the Src to the result string until the second solitary
  Quote character or the first null character in Src. The Src parameter is
  updated to point to the first character following the quoted string.  If
  the Src string does not contain a matching end Quote character, the Src
  parameter is updated to point to the terminating null character in Src.
  This function supports multibyte character strings (MBCS).  }

{$IFNDEF NEXTGEN}
function AnsiExtractQuotedStr(var Src: PAnsiChar; Quote: AnsiChar): AnsiString; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiExtractQuotedStr(var Src: PWideChar; Quote: WideChar): UnicodeString; overload;

{ AnsiDequotedStr is a simplified version of AnsiExtractQuotedStr }

function AnsiDequotedStr(const S: string; AQuote: Char): string; overload;

{ AdjustLineBreaks adjusts all line breaks in the given string to the
  indicated style.
  When Style is tlbsCRLF, the function changes all
  CR characters not followed by LF and all LF characters not preceded
  by a CR into CR/LF pairs.
  When Style is tlbsLF, the function changes all CR/LF pairs and CR characters
  not followed by LF to LF characters. }

function AdjustLineBreaks(const S: string; Style: TTextLineBreakStyle =
        {$IFDEF LINUX} tlbsLF {$ENDIF}
        {$IFDEF MACOS} tlbsLF {$ENDIF}
        {$IFDEF MSWINDOWS} tlbsCRLF {$ENDIF}): string; overload;

{ IsValidIdent returns true if the given string is a valid identifier. An
  identifier is defined as an alphabetic letter or '_' followed by zero or
  more alphabetic letters, digits or '_'. In some cases identifiers may
  contain dots, for example with nested types.
  For more information see: http://msdn.microsoft.com/en-us/library/aa664670(VS.71).aspx }

function IsValidIdent(const Ident: string; AllowDots: Boolean = False): Boolean;

{ IntToStr converts the given value to its decimal string representation. }

function IntToStr(Value: Integer): string; overload;
function IntToStr(Value: Int64): string; overload;

{ UIntToStr converts the given unsigned value to its decimal string representation. }

function UIntToStr(Value: Cardinal): string; overload;
function UIntToStr(Value: UInt64): string; overload;

{ IntToHex converts the given value to a hexadecimal string representation
  with the minimum number of digits specified. }

function IntToHex(Value: Integer; Digits: Integer): string; overload;
function IntToHex(Value: Int64; Digits: Integer): string; overload;
function IntToHex(Value: UInt64; Digits: Integer): string; overload;

{ StrToInt converts the given string to an integer value. If the string
  doesn't contain a valid value, an EConvertError exception is raised. }

function StrToInt(const S: string): Integer; overload;
function StrToIntDef(const S: string; Default: Integer): Integer; overload;
function TryStrToInt(const S: string; out Value: Integer): Boolean; overload;

{ Similar to the above functions but for Int64 instead }

function StrToInt64(const S: string): Int64; overload;
function StrToInt64Def(const S: string; const Default: Int64): Int64; overload;
function TryStrToInt64(const S: string; out Value: Int64): Boolean; overload;

{$IFDEF MACOS}

{ Converts a UnicodeString to the representation of the file system. }
function FileSystemStringToString(const Source: MarshaledAString; var Dest: string): Boolean;

function StringToFileSystemString(const Source: string; var Dest: TBytes): Boolean;

{$ENDIF MACOS}

{ StrToBool converts the given string to a boolean value.  If the string
  doesn't contain a valid value, an EConvertError exception is raised.
  BoolToStr converts boolean to a string value that in turn can be converted
  back into a boolean.  BoolToStr will always pick the first element of
  the TrueStrs/FalseStrs arrays. }

var
  TrueBoolStrs: array of String;
  FalseBoolStrs: array of String;

const
  DefaultTrueBoolStr = 'True';   // DO NOT LOCALIZE
  DefaultFalseBoolStr = 'False'; // DO NOT LOCALIZE

function StrToBool(const S: string): Boolean; overload;
function StrToBoolDef(const S: string; const Default: Boolean): Boolean; overload;
function TryStrToBool(const S: string; out Value: Boolean): Boolean; overload;

function BoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;


{ LoadStr loads the string resource given by Ident from the application's
  executable file or associated resource module. If the string resource
  does not exist, LoadStr returns an empty string. }

{$IFNDEF NEXTGEN}
function LoadStr(Ident: NativeUInt): string;
{$ENDIF !NEXTGEN}

{ FmtLoadStr loads the string resource given by Ident from the application's
  executable file or associated resource module, and uses it as the format
  string in a call to the Format function with the given arguments. }

{$IFNDEF NEXTGEN}
function FmtLoadStr(Ident: NativeUInt; const Args: array of const): string;
{$ENDIF !NEXTGEN}

{ File management routines }

{ FileOpen opens the specified file using the specified access mode. The
  access mode value is constructed by OR-ing one of the fmOpenXXXX constants
  with one of the fmShareXXXX constants. If the return value is positive,
  the function was successful and the value is the file handle of the opened
  file. A return value of -1 indicates that an error occurred. }

function FileOpen(const FileName: string; Mode: LongWord): THandle;

{ FileCreate creates a new file by the specified name. If the return value
  is positive, the function was successful and the value is the file handle
  of the new file. A return value of -1 indicates that an error occurred.
  On Linux, this calls FileCreate(FileName, DEFFILEMODE) to create
  the file with read and write access for the current user only.  }

function FileCreate(const FileName: string): THandle; overload;

{ This second version of FileCreate lets you specify the access rights to put on the newly
  created file.  The access rights parameter is ignored on Win32 }

function FileCreate(const FileName: string; Rights: Integer): THandle; overload;

{ This third version of FileCreate lets you specify the share mode for the newly
  created file. }

function FileCreate(const FileName: string; Mode: LongWord; Rights: Integer): THandle; overload;

{ FileCreateSymLink creates a symbolic link. The parameter Link is the name of
  the symbolic link created and Target is the string contained in the symbolic
  link. }

function FileCreateSymLink(const Link, Target: string): Boolean;

{ FileGetSymLinkTarget reads the target of a symbolic link. The result is
  returned in the symbolic link record given by SymLinkRec. }

function FileGetSymLinkTarget(const FileName: string; var SymLinkRec: TSymLinkRec): Boolean; overload;

{ FileGetSymLinkTarget returns the target of a symbolic link. }

function FileGetSymLinkTarget(const FileName: string; var TargetName: string): Boolean; overload;

{ FileSystemAttributes returns the file system attributes of the path\file given
  by Path. The attributes can contain any of the following:

  fsCaseSensitive - The file system is case sensitive.
  fsCasePreserving - The file system is case preserving but not necessarily case
                     sensitive.
  fsLocal - The drive is a local drive to the computer.
  fsNetwork - The drive is a networked drive.
  fsRemovable - The drive is removable. This could be a USB drive, CD ROM or a
                mounted volume.
  fsSymLink - The file system supports symbolic links.

  If the specified path does not exist then the exception
  EDirectoryNotFoundException is raised. If an OS error occurs then the
  exception EOSError is raised. }

type
  TFileSystemAttribute = (fsCaseSensitive, fsCasePreserving, fsLocal,
    fsNetwork, fsRemovable, fsSymLink);
  TFileSystemAttributes = set of TFileSystemAttribute;

function FileSystemAttributes(const Path: string): TFileSystemAttributes;

{ FileRead reads Count bytes from the file given by Handle into the buffer
  specified by Buffer. The return value is the number of bytes actually
  read; it is less than Count if the end of the file was reached. The return
  value is -1 if an error occurred. }

function FileRead(Handle: THandle; var Buffer; Count: LongWord): Integer; overload;

{ FileWrite writes Count bytes to the file given by Handle from the buffer
  specified by Buffer. The return value is the number of bytes actually
  written, or -1 if an error occurred. }

function FileWrite(Handle: THandle; const Buffer; Count: LongWord): Integer; overload;

{ FileRead reads Count bytes from the file given by Handle into the buffer
  specified by Buffer, at offset in the buffer specified by Offset. The return
  value is the number of bytes actually read; it is less than Count if the end
  of the file was reached. The return value is -1 if an error occurred. }

function FileRead(Handle: THandle; var Buffer: TBytes; Offset, Count: LongWord): Integer; overload;

{ FileWrite writes Count bytes to the file given by Handle from the buffer
  specified by Buffer, at offset in the buffer specified by Offset.
  The return value is the number of bytes actually written, or -1 if an error occurred. }

function FileWrite(Handle: THandle; const Buffer:TBytes; Offset, Count: LongWord): Integer; overload;

{ FileSeek changes the current position of the file given by Handle to be
  Offset bytes relative to the point given by Origin. Origin = 0 means that
  Offset is relative to the beginning of the file, Origin = 1 means that
  Offset is relative to the current position, and Origin = 2 means that
  Offset is relative to the end of the file. The return value is the new
  current position, relative to the beginning of the file, or -1 if an error
  occurred. }

function FileSeek(Handle: THandle; Offset, Origin: Integer): Integer; overload;
function FileSeek(Handle: THandle; const Offset: Int64; Origin: Integer): Int64; overload;

{ FileClose closes the specified file. }

procedure FileClose(Handle: THandle); inline;

{ FileAge returns the date-and-time stamp of the specified file. The return
  value can be converted to a TDateTime value using the FileDateToDateTime
  function. The return value is -1 if the file does not exist. This version
  does not support date-and-time stamps prior to 1980 and after 2107. If the
  specified file is a symlink then the function is performed on the target
  file. }

function FileAge(const FileName: string): Integer; overload; deprecated;

{ FileAge retrieves the date-and-time stamp of the specified file as a
  TDateTime. This version supports all valid NTFS date-and-time stamps
  and returns a boolean value that indicates whether the specified file
  exists. If the specified file is a symlink the function is performed on
  the target file. If FollowLink is false then the date-and-time of the
  symlink file is returned. }

function FileAge(const FileName: string; out FileDateTime: TDateTime;
  FollowLink: Boolean = True): Boolean; overload;

{ FileExists returns a boolean value that indicates whether the specified
  file exists. If the specified file is a symlink the function is performed on
  the target file. If FollowLink is false then the symlink file is used
  regardless if the link is broken or is a link to a directory. }

function FileExists(const FileName: string; FollowLink: Boolean = True): Boolean;

{ DirectoryExists returns a boolean value that indicates whether the
  specified directory exists (and is actually a directory). If the specified
  directory is a symlink the function is performed on the target directory. If
  FollowLink is false then the symlink file is used. If the link is broken
  DirectoryExists will always return false. }

function DirectoryExists(const Directory: string; FollowLink: Boolean = True): Boolean;

{ ForceDirectories ensures that all the directories in a specific path exist.
  Any portion that does not already exist will be created.  Function result
  indicates success of the operation.  The function can fail if the current
  user does not have sufficient file access rights to create directories in
  the given path.  }

function ForceDirectories(Dir: string): Boolean;

{ FindFirst searches the directory given by Path for the first entry that
  matches the filename given by Path and the attributes given by Attr. The
  result is returned in the search record given by SearchRec. The return
  value is zero if the function was successful. Otherwise the return value
  is a system error code. After calling FindFirst, always call FindClose.
  FindFirst is typically used with FindNext and FindClose as follows:

    Result := FindFirst(Path, Attr, SearchRec);
    while Result = 0 do
    begin
      ProcessSearchRec(SearchRec);
      Result := FindNext(SearchRec);
    end;
    FindClose(SearchRec);

  where ProcessSearchRec represents user-defined code that processes the
  information in a search record. }

function FindFirst(const Path: string; Attr: Integer;
  var F: TSearchRec): Integer;

{ FindNext returs the next entry that matches the name and attributes
  specified in a previous call to FindFirst. The search record must be one
  that was passed to FindFirst. The return value is zero if the function was
  successful. Otherwise the return value is a system error code. }

function FindNext(var F: TSearchRec): Integer;

{ FindClose terminates a FindFirst/FindNext sequence and frees memory and system
  resources allocated by FindFirst.
  Every FindFirst/FindNext must end with a call to FindClose. }

procedure FindClose(var F: TSearchRec);

{ FileGetDate returns the OS date-and-time stamp of the file given by
  Handle. The return value is -1 if the handle is invalid. The
  FileDateToDateTime function can be used to convert the returned value to
  a TDateTime value. }

function FileGetDate(Handle: THandle): Integer;

{ FileGetDateTimeInfo returns the date-and-time stamp of the specified file
  and supports all valid NTFS date-and-time stamps. A boolena value is returned
  indicating whether the specified file exists. If the specified file is a
  symlink the function is performed on the target file. If FollowLink is false
  then the date-and-time of the symlink file is returned. }

function FileGetDateTimeInfo(const FileName: string;
  out DateTime: TDateTimeInfoRec; FollowLink: Boolean = True): Boolean;

{ FileSetDate sets the OS date-and-time stamp of the file given by FileName
  to the value given by Age. The DateTimeToFileDate function can be used to
  convert a TDateTime value to an OS date-and-time stamp. The return value
  is zero if the function was successful. Otherwise the return value is a
  system error code. If the specified file is a symlink then the function is
  performed on the target file. }

function FileSetDate(const FileName: string; Age: Integer): Integer; overload;

{$IFDEF MSWINDOWS}
{ FileSetDate by handle is not available on Unix platforms because there
  is no standard way to set a file's modification time using only a file
  handle, and no standard way to obtain the file name of an open
  file handle. }

function FileSetDate(Handle: THandle; Age: Integer): Integer; overload; platform;
{$ENDIF MSWINDOWS}

{ FileGetAttr returns the file attributes of the file given by FileName. The
  attributes can be examined by AND-ing with the faXXXX constants defined
  above. A return value of -1 indicates that an error occurred. If the
  specified file is a symlink then the function is performed on the target file.
  If FollowLink is false then the symlink file is used. }

function FileGetAttr(const FileName: string; FollowLink: Boolean = True): Integer; platform;

{$IFDEF MSWINDOWS}
{ FileGetAttr returns the file attributes of the file given by FileName. The
  attributes can be examined by AND-ing with the faXXXX constants defined
  above. A return value of -1 indicates that an error occurred. If the
  specified file is a symlink then the function is performed on the target file.
  If FollowLink is false then the symlink file is used. }

function FileSetAttr(const FileName: string; Attr: Integer; FollowLink: Boolean = True): Integer; platform;
{$ENDIF MSWINDOWS}

{ FileIsReadOnly tests whether a given file is read-only for the current
  process and effective user id.  If the file does not exist, the
  function returns False.  (Check FileExists before calling FileIsReadOnly)
  This function is platform portable.  If the specified file is a symlink
  then the function is performed on the target file. }

function FileIsReadOnly(const FileName: string): Boolean;

{ FileSetReadOnly sets the read only state of a file.  The file must
  exist and the current effective user id must be the owner of the file.
  On Unix systems, FileSetReadOnly attempts to set or remove
  all three (user, group, and other) write permissions on the file.
  If you want to grant partial permissions (writeable for owner but not
  for others), use platform specific functions such as chmod.
  The function returns True if the file was successfully modified,
  False if there was an error.  This function is platform portable. If the
  specified file is a symlink then the function is performed on the target
  file. }

function FileSetReadOnly(const FileName: string; ReadOnly: Boolean): Boolean;

{ DeleteFile deletes the file given by FileName. The return value is True if
  the file was successfully deleted, or False if an error occurred. DeleteFile
  can delete a symlink to a file or directory. }

function DeleteFile(const FileName: string): Boolean; {$IFDEF POSIX}inline;{$ENDIF}

{ RenameFile renames the file given by OldName to the name given by NewName.
  The return value is True if the file was successfully renamed, or False if
  an error occurred. If the file specified is a symlink then the function is
  performed on the symlink. }

function RenameFile(const OldName, NewName: string): Boolean; inline;

{ IsAssembly returns a boolean value that indicates whether the specified
  file is a .NET assembly. }
{$IFDEF MSWINDOWS}
function IsAssembly(const FileName: string): Boolean; platform;
{$ENDIF MSWINDOWS}

{ ChangeFileExt changes the extension of a filename. FileName specifies a
  filename with or without an extension, and Extension specifies the new
  extension for the filename. The new extension can be a an empty string or
  a period followed by up to three characters. }

function ChangeFileExt(const FileName, Extension: string): string; overload;

{ ChangeFilePath changes the path of a filename. FileName specifies a
  filename with or without an extension, and Path specifies the new
  path for the filename. The new path is not required to contain the trailing
  path delimiter. }

function ChangeFilePath(const FileName, Path: string): string; overload;

{ ExtractFilePath extracts the drive and directory parts of the given
  filename. The resulting string is the leftmost characters of FileName,
  up to and including the colon or backslash that separates the path
  information from the name and extension. The resulting string is empty
  if FileName contains no drive and directory parts. }

function ExtractFilePath(const FileName: string): string; overload;

{ ExtractFileDir extracts the drive and directory parts of the given
  filename. The resulting string is a directory name suitable for passing
  to SetCurrentDir, CreateDir, etc. The resulting string is empty if
  FileName contains no drive and directory parts. }

function ExtractFileDir(const FileName: string): string; overload;

{ ExtractFileDrive extracts the drive part of the given filename.  For
  filenames with drive letters, the resulting string is '<drive>:'.
  For filenames with a UNC path, the resulting string is in the form
  '\\<servername>\<sharename>'.  If the given path contains neither
  style of filename, the result is an empty string. }

function ExtractFileDrive(const FileName: string): string; overload;

{ ExtractFileName extracts the name and extension parts of the given
  filename. The resulting string is the leftmost characters of FileName,
  starting with the first character after the colon or backslash that
  separates the path information from the name and extension. The resulting
  string is equal to FileName if FileName contains no drive and directory
  parts. }

function ExtractFileName(const FileName: string): string; overload;

{ ExtractFileExt extracts the extension part of the given filename. The
  resulting string includes the period character that separates the name
  and extension parts. The resulting string is empty if the given filename
  has no extension. }

function ExtractFileExt(const FileName: string): string; overload;

{ GetHomePath returns the path to the current user's home directory on MacOSX and
  Linux. On Windows it returns the path to the current user's AppData folder. GetHomePath
  is useful when an application requires storing user-specific files. }

function GetHomePath: string; overload;

{ ExpandFileName expands the given filename to a fully qualified filename.
  The resulting string consists of a drive letter, a colon, a root relative
  directory path, and a filename. Embedded '.' and '..' directory references
  are removed. }

function ExpandFileName(const FileName: string): string; overload;

{ ExpandFilenameCase returns a fully qualified filename like ExpandFilename,
  but performs a case-insensitive filename search looking for a close match
  in the actual file system, differing only in uppercase versus lowercase of
  the letters.  This is useful to convert lazy user input into useable file
  names, or to convert filename data created on a case-insensitive file
  system (Win32) to something useable on a case-sensitive file system (Linux).

  The MatchFound out parameter indicates what kind of match was found in the
  file system, and what the function result is based upon:

  ( in order of increasing difficulty or complexity )
  mkExactMatch:  Case-sensitive match.  Result := ExpandFileName(FileName).
  mkSingleMatch: Exactly one file in the given directory path matches the
        given filename on a case-insensitive basis.
        Result := ExpandFileName(FileName as found in file system).
  mkAmbiguous: More than one file in the given directory path matches the
        given filename case-insensitively.
        In many cases, this should be considered an error.
        Result := ExpandFileName(First matching filename found).
  mkNone:  File not found at all.  Result := ExpandFileName(FileName).

  Note that because this function has to search the file system it may be
  much slower than ExpandFileName, particularly when the given filename is
  ambiguous or does not exist.  Use ExpandFilenameCase only when you have
  a filename of dubious orgin - such as from user input - and you want
  to make a best guess before failing.  }

type
  TFilenameCaseMatch = (mkNone, mkExactMatch, mkSingleMatch, mkAmbiguous);

function ExpandFileNameCase(const FileName: string;
  out MatchFound: TFilenameCaseMatch): string; overload;

{ ExpandUNCFileName expands the given filename to a fully qualified filename.
  This function is the same as ExpandFileName except that it will return the
  drive portion of the filename in the format '\\<servername>\<sharename> if
  that drive is actually a network resource instead of a local resource.
  Like ExpandFileName, embedded '.' and '..' directory references are
  removed. }

function ExpandUNCFileName(const FileName: string): string; overload;

{ ExtractRelativePath will return a file path name relative to the given
  BaseName.  It strips the common path dirs and adds '..\' on Windows,
  and '../' on Linux for each level up from the BaseName path. Note: Directories
  passed in should include trailing backslashes}

function ExtractRelativePath(const BaseName, DestName: string): string; overload;

{ IsRelativePath returns a boolean value that indicates whether the specified
  path is a relative path. }

function IsRelativePath(const Path: string): Boolean;

{$IFDEF MSWINDOWS}
{ ExtractShortPathName will convert the given filename to the short form
  by calling the GetShortPathName API.  Will return an empty string if
  the file or directory specified does not exist }

function ExtractShortPathName(const FileName: string): string; overload;
{$ENDIF}

{ FileSearch searches for the file given by Name in the list of directories
  given by DirList. The directory paths in DirList must be separated by
  PathSep chars. The search always starts with the current directory of the
  current drive. The returned value is a concatenation of one of the
  directory paths and the filename, or an empty string if the file could not
  be located. }

function FileSearch(const Name, DirList: string): string;

{$IFDEF MSWINDOWS}
{ DiskFree returns the number of free bytes on the specified drive number,
  where 0 = Current, 1 = A, 2 = B, etc. DiskFree returns -1 if the drive
  number is invalid. }

function DiskFree(Drive: Byte): Int64;

{ DiskSize returns the size in bytes of the specified drive number, where
  0 = Current, 1 = A, 2 = B, etc. DiskSize returns -1 if the drive number
  is invalid. }

function DiskSize(Drive: Byte): Int64;
{$ENDIF}

{ FileDateToDateTime converts an OS date-and-time value to a TDateTime
  value. The FileAge, FileGetDate, and FileSetDate routines operate on OS
  date-and-time values, and the Time field of a TSearchRec used by the
  FindFirst and FindNext functions contains an OS date-and-time value. }

function FileDateToDateTime(FileDate: Integer): TDateTime;

{ DateTimeToFileDate converts a TDateTime value to an OS date-and-time
  value. The FileAge, FileGetDate, and FileSetDate routines operate on OS
  date-and-time values, and the Time field of a TSearchRec used by the
  FindFirst and FindNext functions contains an OS date-and-time value. }

function DateTimeToFileDate(DateTime: TDateTime): Integer;

{ GetCurrentDir returns the current directory. }

function GetCurrentDir: string;

{ SetCurrentDir sets the current directory. The return value is True if
  the current directory was successfully changed, or False if an error
  occurred. }

function SetCurrentDir(const Dir: string): Boolean;

{ CreateDir creates a new directory. The return value is True if a new
  directory was successfully created, or False if an error occurred. }

function CreateDir(const Dir: string): Boolean;

{ RemoveDir deletes an existing empty directory. The return value is
  True if the directory was successfully deleted, or False if an error
  occurred. If the given directory is a symlink to a directory then the
  symlink is deleted. On Windows the link can be broken and the symlink
  can still be verified to be a symlink. }

function RemoveDir(const Dir: string): Boolean;

{ PChar routines }
{ const params help simplify C++ code.  No effect on pascal code }

{ StrLen returns the number of characters in Str, not counting the null
  terminator. }

{$IFNDEF NEXTGEN}
function StrLen(const Str: PAnsiChar): Cardinal; overload; inline; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrLen(const Str: PWideChar): Cardinal; overload; inline;

{ StrEnd returns a pointer to the null character that terminates Str. }

{$IFNDEF NEXTGEN}
function StrEnd(const Str: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrEnd(const Str: PWideChar): PWideChar; overload;

{ StrMove copies exactly Count characters from Source to Dest and returns
  Dest. Source and Dest may overlap. }

{$IFNDEF NEXTGEN}
function StrMove(Dest: PAnsiChar; const Source: PAnsiChar; Count: Cardinal): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrMove(Dest: PWideChar; const Source: PWideChar; Count: Cardinal): PWideChar; overload;

{ StrCopy copies Source to Dest and returns Dest. }

{$IFNDEF NEXTGEN}
function StrCopy(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar; overload;

{ StrECopy copies Source to Dest and returns StrEnd(Dest). }

{$IFNDEF NEXTGEN}
function StrECopy(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrECopy(Dest: PWideChar; const Source: PWideChar): PWideChar; overload;

{ StrLCopy copies at most MaxLen characters from Source to Dest and
  returns Dest. }

{$IFNDEF NEXTGEN}
function StrLCopy(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrLCopy(Dest: PWideChar; const Source: PWideChar; MaxLen: Cardinal): PWideChar; overload;

{ StrPCopy copies the Pascal style string Source into Dest and
  returns Dest. }

{$IFNDEF NEXTGEN}
function StrPCopy(Dest: PAnsiChar; const Source: AnsiString): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrPCopy(Dest: PWideChar; const Source: UnicodeString): PWideChar; overload;

{ StrPLCopy copies at most MaxLen characters from the Pascal style string
  Source into Dest and returns Dest. }

{$IFNDEF NEXTGEN}
function StrPLCopy(Dest: PAnsiChar; const Source: AnsiString; MaxLen: Cardinal): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrPLCopy(Dest: PWideChar; const Source: UnicodeString; MaxLen: Cardinal): PWideChar; overload;

{ StrCat appends a copy of Source to the end of Dest and returns Dest. }

{$IFNDEF NEXTGEN}
function StrCat(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrCat(Dest: PWideChar; const Source: PWideChar): PWideChar; overload;

{ StrLCat appends at most MaxLen - StrLen(Dest) characters from Source to
  the end of Dest, and returns Dest. }

{$IFNDEF NEXTGEN}
function StrLCat(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrLCat(Dest: PWideChar; const Source: PWideChar; MaxLen: Cardinal): PWideChar; overload;

{ StrComp compares Str1 to Str2. The return value is less than 0 if
  Str1 < Str2, 0 if Str1 = Str2, or greater than 0 if Str1 > Str2. }

{$IFNDEF NEXTGEN}
function StrComp(const Str1, Str2: PAnsiChar): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrComp(const Str1, Str2: PWideChar): Integer; overload;

{ StrIComp compares Str1 to Str2, without case sensitivity. The return
  value is the same as StrComp. }

{$IFNDEF NEXTGEN}
function StrIComp(const Str1, Str2: PAnsiChar): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrIComp(const Str1, Str2: PWideChar): Integer; overload;

{ StrLComp compares Str1 to Str2, for a maximum length of MaxLen
  characters. The return value is the same as StrComp. }

{$IFNDEF NEXTGEN}
function StrLComp(const Str1, Str2: PAnsiChar; MaxLen: Cardinal): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrLComp(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer; overload;

{ StrLIComp compares Str1 to Str2, for a maximum length of MaxLen
  characters, without case sensitivity. The return value is the same
  as StrComp. }

{$IFNDEF NEXTGEN}
function StrLIComp(const Str1, Str2: PAnsiChar; MaxLen: Cardinal): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrLIComp(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer; overload;

{ StrScan returns a pointer to the first occurrence of Chr in Str. If Chr
  does not occur in Str, StrScan returns NIL. The null terminator is
  considered to be part of the string. }

{$IFNDEF NEXTGEN}
function StrScan(const Str: PAnsiChar; Chr: AnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrScan(const Str: PWideChar; Chr: WideChar): PWideChar; overload;

{ StrRScan returns a pointer to the last occurrence of Chr in Str. If Chr
  does not occur in Str, StrRScan returns NIL. The null terminator is
  considered to be part of the string. }

{$IFNDEF NEXTGEN}
function StrRScan(const Str: PAnsiChar; Chr: AnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrRScan(const Str: PWideChar; Chr: WideChar): PWideChar; overload;

{ TextPos: Same as StrPos but is case insensitive }

{$IFNDEF NEXTGEN}
function TextPos(Str, SubStr: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function TextPos(Str, SubStr: PWideChar): PWideChar; overload;

{ StrPos returns a pointer to the first occurrence of Str2 in Str1. If
  Str2 does not occur in Str1, StrPos returns NIL. }

{$IFNDEF NEXTGEN}
function StrPos(const Str1, Str2: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrPos(const Str1, Str2: PWideChar): PWideChar; overload;

{ StrUpper converts Str to upper case and returns Str. }

{$IFNDEF NEXTGEN}
function StrUpper(Str: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrUpper(Str: PWideChar): PWideChar; overload;

{ StrLower converts Str to lower case and returns Str. }

{$IFNDEF NEXTGEN}
function StrLower(Str: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrLower(Str: PWideChar): PWideChar; overload;

{ StrPas converts Str to a Pascal style string. This function is provided
  for backwards compatibility only. To convert a null terminated string to
  a Pascal style string, use a string type cast or an assignment. }

{$IFNDEF NEXTGEN}
function StrPas(const Str: PAnsiChar): AnsiString; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrPas(const Str: PWideChar): UnicodeString; overload;

{ StrAlloc allocates a buffer of the given size on the heap. The size of
  the allocated buffer is encoded in a four byte header that immediately
  preceeds the buffer. To dispose the buffer, use StrDispose. }

{$IFNDEF NEXTGEN}
function AnsiStrAlloc(Size: Cardinal): PAnsiChar; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function WideStrAlloc(Size: Cardinal): PWideChar;
function StrAlloc(Size: Cardinal): PChar;

{ StrBufSize returns the allocated size of the given buffer, not including
  the two byte header. }

{$IFNDEF NEXTGEN}
function StrBufSize(const Str: PAnsiChar): Cardinal; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrBufSize(const Str: PWideChar): Cardinal; overload;

{ StrNew allocates a copy of Str on the heap. If Str is NIL, StrNew returns
  NIL and doesn't allocate any heap space. Otherwise, StrNew makes a
  duplicate of Str, obtaining space with a call to the StrAlloc function,
  and returns a pointer to the duplicated string. To dispose the string,
  use StrDispose. }

{$IFNDEF NEXTGEN}
function StrNew(const Str: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrNew(const Str: PWideChar): PWideChar; overload;

{ StrDispose disposes a string that was previously allocated with StrAlloc
  or StrNew. If Str is NIL, StrDispose does nothing. }

{$IFNDEF NEXTGEN}
procedure StrDispose(Str: PAnsiChar); overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
procedure StrDispose(Str: PWideChar); overload;

{ String formatting routines }

{ The Format routine formats the argument list given by the Args parameter
  using the format string given by the Format parameter.

  Format strings contain two types of objects--plain characters and format
  specifiers. Plain characters are copied verbatim to the resulting string.
  Format specifiers fetch arguments from the argument list and apply
  formatting to them.

  Format specifiers have the following form:

    "%" [index ":"] ["-"] [width] ["." prec] type

  A format specifier begins with a % character. After the % come the
  following, in this order:

  -  an optional argument index specifier, [index ":"]
  -  an optional left-justification indicator, ["-"]
  -  an optional width specifier, [width]
  -  an optional precision specifier, ["." prec]
  -  the conversion type character, type

  The following conversion characters are supported:

  d  Decimal. The argument must be an integer value. The value is converted
     to a string of decimal digits. If the format string contains a precision
     specifier, it indicates that the resulting string must contain at least
     the specified number of digits; if the value has less digits, the
     resulting string is left-padded with zeros.

  u  Unsigned decimal.  Similar to 'd' but no sign is output.

  e  Scientific. The argument must be a floating-point value. The value is
     converted to a string of the form "-d.ddd...E+ddd". The resulting
     string starts with a minus sign if the number is negative, and one digit
     always precedes the decimal point. The total number of digits in the
     resulting string (including the one before the decimal point) is given
     by the precision specifer in the format string--a default precision of
     15 is assumed if no precision specifer is present. The "E" exponent
     character in the resulting string is always followed by a plus or minus
     sign and at least three digits.

  f  Fixed. The argument must be a floating-point value. The value is
     converted to a string of the form "-ddd.ddd...". The resulting string
     starts with a minus sign if the number is negative. The number of digits
     after the decimal point is given by the precision specifier in the
     format string--a default of 2 decimal digits is assumed if no precision
     specifier is present.

  g  General. The argument must be a floating-point value. The value is
     converted to the shortest possible decimal string using fixed or
     scientific format. The number of significant digits in the resulting
     string is given by the precision specifier in the format string--a
     default precision of 15 is assumed if no precision specifier is present.
     Trailing zeros are removed from the resulting string, and a decimal
     point appears only if necessary. The resulting string uses fixed point
     format if the number of digits to the left of the decimal point in the
     value is less than or equal to the specified precision, and if the
     value is greater than or equal to 0.00001. Otherwise the resulting
     string uses scientific format.

  n  Number. The argument must be a floating-point value. The value is
     converted to a string of the form "-d,ddd,ddd.ddd...". The "n" format
     corresponds to the "f" format, except that the resulting string
     contains thousand separators.

  m  Money. The argument must be a floating-point value. The value is
     converted to a string that represents a currency amount. The conversion
     is controlled by the CurrencyString, CurrencyFormat, NegCurrFormat,
     ThousandSeparator, DecimalSeparator, and CurrencyDecimals global
     variables, all of which are initialized from locale settings provided
     by the operating system.  For example, Currency Format preferences can be
     set in the International section of the Windows Control Panel. If the format
     string contains a precision specifier, it overrides the value given
     by the CurrencyDecimals global variable.

  p  Pointer. The argument must be a pointer value. The value is converted
     to a string of the form "XXXX:YYYY" where XXXX and YYYY are the
     segment and offset parts of the pointer expressed as four hexadecimal
     digits.

  s  String. The argument must be a character, a string, or a PChar value.
     The string or character is inserted in place of the format specifier.
     The precision specifier, if present in the format string, specifies the
     maximum length of the resulting string. If the argument is a string
     that is longer than this maximum, the string is truncated.

  x  Hexadecimal. The argument must be an integer value. The value is
     converted to a string of hexadecimal digits. If the format string
     contains a precision specifier, it indicates that the resulting string
     must contain at least the specified number of digits; if the value has
     less digits, the resulting string is left-padded with zeros.

  Conversion characters may be specified in upper case as well as in lower
  case--both produce the same results.

  For all floating-point formats, the actual characters used as decimal and
  thousand separators are obtained from the DecimalSeparator and
  ThousandSeparator global variables.

  Index, width, and precision specifiers can be specified directly using
  decimal digit string (for example "%10d"), or indirectly using an asterisk
  charcater (for example "%*.*f"). When using an asterisk, the next argument
  in the argument list (which must be an integer value) becomes the value
  that is actually used. For example "Format('%*.*f', [8, 2, 123.456])" is
  the same as "Format('%8.2f', [123.456])".

  A width specifier sets the minimum field width for a conversion. If the
  resulting string is shorter than the minimum field width, it is padded
  with blanks to increase the field width. The default is to right-justify
  the result by adding blanks in front of the value, but if the format
  specifier contains a left-justification indicator (a "-" character
  preceding the width specifier), the result is left-justified by adding
  blanks after the value.

  An index specifier sets the current argument list index to the specified
  value. The index of the first argument in the argument list is 0. Using
  index specifiers, it is possible to format the same argument multiple
  times. For example "Format('%d %d %0:d %d', [10, 20])" produces the string
  '10 20 10 20'.

  The Format function can be combined with other formatting functions. For
  example

    S := Format('Your total was %s on %s', [
      FormatFloat('$#,##0.00;;zero', Total),
      FormatDateTime('mm/dd/yy', Date)]);

  which uses the FormatFloat and FormatDateTime functions to customize the
  format beyond what is possible with Format.

  Each of the string formatting routines that uses global variables for
  formatting (separators, decimals, date/time formats etc.), has an
  overloaded equivalent requiring a parameter of type TFormatSettings. This
  additional parameter provides the formatting information rather than the
  global variables. For more information see the notes at TFormatSettings.  }

function Format(const Format: string;
  const Args: array of const): string; overload;
function Format(const Format: string; const Args: array of const;
  const AFormatSettings: TFormatSettings): string; overload;

{ FmtStr formats the argument list given by Args using the format string
  given by Format into the string variable given by Result. For further
  details, see the description of the Format function. }

procedure FmtStr(var Result: string; const Format: string;
  const Args: array of const); overload;
procedure FmtStr(var Result: string; const Format: string;
  const Args: array of const; const AFormatSettings: TFormatSettings); overload;

{ StrFmt formats the argument list given by Args using the format string
  given by Format into the buffer given by Buffer. It is up to the caller to
  ensure that Buffer is large enough for the resulting string. The returned
  value is Buffer. For further details, see the description of the Format
  function. }

{$IFNDEF NEXTGEN}
function StrFmt(Buffer, Format: PAnsiChar; const Args: array of const): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
function StrFmt(Buffer, Format: PAnsiChar; const Args: array of const;
  const AFormatSettings: TFormatSettings): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}

function StrFmt(Buffer, Format: PWideChar;
  const Args: array of const): PWideChar; overload;
function StrFmt(Buffer, Format: PWideChar; const Args: array of const;
  const AFormatSettings: TFormatSettings): PWideChar; overload;

{ StrLFmt formats the argument list given by Args using the format string
  given by Format into the buffer given by Buffer. The resulting string will
  contain no more than MaxBufLen characters, not including the null terminator.
  The returned value is Buffer. For further details, see the description of
  the Format function. }

{$IFNDEF NEXTGEN}
function StrLFmt(Buffer: PAnsiChar; MaxBufLen: Cardinal; Format: PAnsiChar;
  const Args: array of const): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
function StrLFmt(Buffer: PAnsiChar; MaxBufLen: Cardinal; Format: PAnsiChar;
  const Args: array of const;
  const AFormatSettings: TFormatSettings): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}

function StrLFmt(Buffer: PWideChar; MaxBufLen: Cardinal; Format: PWideChar;
  const Args: array of const): PWideChar; overload;
function StrLFmt(Buffer: PWideChar; MaxBufLen: Cardinal; Format: PWideChar;
  const Args: array of const;
  const AFormatSettings: TFormatSettings): PWideChar; overload;

{ FormatBuf formats the argument list given by Args using the format string
  given by Format and FmtLen into the buffer given by Buffer and BufLen.
  The Format parameter is a reference to a buffer containing FmtLen
  characters, and the Buffer parameter is a reference to a buffer of BufLen
  characters. The returned value is the number of characters actually stored
  in Buffer. The returned value is always less than or equal to BufLen. For
  further details, see the description of the Format function. }

{$IFNDEF NEXTGEN}
function FormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal; overload; deprecated 'Moved to the AnsiStrings unit';
function FormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}

function FormatBuf(Buffer: PWideChar; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal; overload;
function FormatBuf(Buffer: PWideChar; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal; overload;

function FormatBuf(var Buffer: UnicodeString; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal; overload;
function FormatBuf(var Buffer: UnicodeString; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal; overload;

{$IFNDEF NEXTGEN}
{ The WideFormat routine formats the argument list given by the Args parameter
  using the format WideString given by the Format parameter. This routine is
  the WideString equivalent of Format. For further details, see the description
  of the Format function. }
function WideFormat(const Format: WideString; const Args: array of const): WideString; overload;
function WideFormat(const Format: WideString; const Args: array of const;
  const AFormatSettings: TFormatSettings): WideString; overload;

{ WideFmtStr formats the argument list given by Args using the format WideString
  given by Format into the WideString variable given by Result. For further
  details, see the description of the Format function. }
procedure WideFmtStr(var Result: WideString; const Format: WideString;
  const Args: array of const); overload;
procedure WideFmtStr(var Result: WideString; const Format: WideString;
  const Args: array of const; const AFormatSettings: TFormatSettings); overload;
{$ENDIF !NEXTGEN}

{ WideFormatBuf formats the argument list given by Args using the format string
  given by Format and FmtLen into the buffer given by Buffer and BufLen.
  The Format parameter is a reference to a buffer containing FmtLen
  UNICODE characters (WideChar), and the Buffer parameter is a reference to a
  buffer of BufLen UNICODE characters (WideChar). The return value is the number
  of UNICODE characters actually stored in Buffer. The return value is always
  less than or equal to BufLen. For further details, see the description of the
  Format function.

  Important: BufLen, FmtLen and the return result are always the number of
  UNICODE characters, *not* the number of bytes. To calculate the number of bytes
  multiply them by SizeOf(WideChar). }
function WideFormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal; overload;
function WideFormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal; overload;

{ Floating point conversion routines }

{ Each of the floating point conversion routines that uses global variables
  for formatting (separators, decimals, etc.), has an overloaded equivalent
  requiring a parameter of type TFormatSettings. This additional parameter
  provides the formatting information rather than the global variables. For
  more information see the notes at TFormatSettings.  }

{ FloatToStr converts the floating-point value given by Value to its string
  representation. The conversion uses general number format with 15
  significant digits. For further details, see the description of the
  FloatToStrF function. }

function FloatToStr(Value: Extended): string; overload; inline;
function FloatToStr(Value: Extended;
  const AFormatSettings: TFormatSettings): string; overload;

{ CurrToStr converts the currency value given by Value to its string
  representation. The conversion uses general number format. For further
  details, see the description of the CurrToStrF function. }

function CurrToStr(Value: Currency): string; overload; inline;
function CurrToStr(Value: Currency;
  const AFormatSettings: TFormatSettings): string; overload;

{ FloatToCurr will range validate a value to make sure it falls
  within the acceptable currency range }

const
  MinCurrency: Currency = -922337203685477.5807 {$IFDEF LINUX} + 1 {$ENDIF};  //!! overflow?
  MaxCurrency: Currency =  922337203685477.5807 {$IFDEF LINUX} - 1 {$ENDIF};  //!! overflow?

function FloatToCurr(const Value: Extended): Currency;
function TryFloatToCurr(const Value: Extended; out AResult: Currency): Boolean;

{ FloatToStrF converts the floating-point value given by Value to its string
  representation. The Format parameter controls the format of the resulting
  string. The Precision parameter specifies the precision of the given value.
  It should be 7 or less for values of type Single, 15 or less for values of
  type Double, and 18 or less for values of type Extended. The meaning of the
  Digits parameter depends on the particular format selected.

  The possible values of the Format parameter, and the meaning of each, are
  described below.

  ffGeneral - General number format. The value is converted to the shortest
  possible decimal string using fixed or scientific format. Trailing zeros
  are removed from the resulting string, and a decimal point appears only
  if necessary. The resulting string uses fixed point format if the number
  of digits to the left of the decimal point in the value is less than or
  equal to the specified precision, and if the value is greater than or
  equal to 0.00001. Otherwise the resulting string uses scientific format,
  and the Digits parameter specifies the minimum number of digits in the
  exponent (between 0 and 4).

  ffExponent - Scientific format. The value is converted to a string of the
  form "-d.ddd...E+dddd". The resulting string starts with a minus sign if
  the number is negative, and one digit always precedes the decimal point.
  The total number of digits in the resulting string (including the one
  before the decimal point) is given by the Precision parameter. The "E"
  exponent character in the resulting string is always followed by a plus
  or minus sign and up to four digits. The Digits parameter specifies the
  minimum number of digits in the exponent (between 0 and 4).

  ffFixed - Fixed point format. The value is converted to a string of the
  form "-ddd.ddd...". The resulting string starts with a minus sign if the
  number is negative, and at least one digit always precedes the decimal
  point. The number of digits after the decimal point is given by the Digits
  parameter--it must be between 0 and 18. If the number of digits to the
  left of the decimal point is greater than the specified precision, the
  resulting value will use scientific format.

  ffNumber - Number format. The value is converted to a string of the form
  "-d,ddd,ddd.ddd...". The ffNumber format corresponds to the ffFixed format,
  except that the resulting string contains thousand separators.

  ffCurrency - Currency format. The value is converted to a string that
  represents a currency amount. The conversion is controlled by the
  CurrencyString, CurrencyFormat, NegCurrFormat, ThousandSeparator, and
  DecimalSeparator global variables, all of which are initialized from
  locale settings provided by the operating system.  For example,
  Currency Format preferences can be set in the International section
  of the Windows Control Panel.
  The number of digits after the decimal point is given by the Digits
  parameter--it must be between 0 and 18.

  For all formats, the actual characters used as decimal and thousand
  separators are obtained from the DecimalSeparator and ThousandSeparator
  global variables.

  If the given value is a NAN (not-a-number), the resulting string is 'NAN'.
  If the given value is positive infinity, the resulting string is 'INF'. If
  the given value is negative infinity, the resulting string is '-INF'. }

function FloatToStrF(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer): string; overload; inline;
function FloatToStrF(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): string; overload;

{ CurrToStrF converts the currency value given by Value to its string
  representation. A call to CurrToStrF corresponds to a call to
  FloatToStrF with an implied precision of 19 digits. }

function CurrToStrF(Value: Currency; Format: TFloatFormat;
  Digits: Integer): string; overload; inline;
function CurrToStrF(Value: Currency; Format: TFloatFormat;
  Digits: Integer; const AFormatSettings: TFormatSettings): string; overload;

{ FloatToText converts the given floating-point value to its decimal
  representation using the specified format, precision, and digits. The
  Value parameter must be a variable of type Extended or Currency, as
  indicated by the ValueType parameter. The resulting string of characters
  is stored in the given buffer, and the returned value is the number of
  characters stored. The resulting string is not null-terminated. For
  further details, see the description of the FloatToStrF function. }

{$IFNDEF NEXTGEN}
function FloatToText(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer): Integer; overload; inline; deprecated 'Moved to the AnsiStrings unit';
function FloatToText(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}

function FloatToText(BufferArg: PWideChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer): Integer; overload; inline;
function FloatToText(BufferArg: PWideChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): Integer; overload;

{ FormatFloat formats the floating-point value given by Value using the
  format string given by Format. The following format specifiers are
  supported in the format string:

  0     Digit placeholder. If the value being formatted has a digit in the
        position where the '0' appears in the format string, then that digit
        is copied to the output string. Otherwise, a '0' is stored in that
        position in the output string.

  #     Digit placeholder. If the value being formatted has a digit in the
        position where the '#' appears in the format string, then that digit
        is copied to the output string. Otherwise, nothing is stored in that
        position in the output string.

  .     Decimal point. The first '.' character in the format string
        determines the location of the decimal separator in the formatted
        value; any additional '.' characters are ignored. The actual
        character used as a the decimal separator in the output string is
        determined by the DecimalSeparator global variable, which is initialized
        from locale settings obtained from the operating system.

  ,     Thousand separator. If the format string contains one or more ','
        characters, the output will have thousand separators inserted between
        each group of three digits to the left of the decimal point. The
        placement and number of ',' characters in the format string does not
        affect the output, except to indicate that thousand separators are
        wanted. The actual character used as a the thousand separator in the
        output is determined by the ThousandSeparator global variable, which
        is initialized from locale settings obtained from the operating system.

  E+    Scientific notation. If any of the strings 'E+', 'E-', 'e+', or 'e-'
  E-    are contained in the format string, the number is formatted using
  e+    scientific notation. A group of up to four '0' characters can
  e-    immediately follow the 'E+', 'E-', 'e+', or 'e-' to determine the
        minimum number of digits in the exponent. The 'E+' and 'e+' formats
        cause a plus sign to be output for positive exponents and a minus
        sign to be output for negative exponents. The 'E-' and 'e-' formats
        output a sign character only for negative exponents.

  'xx'  Characters enclosed in single or double quotes are output as-is, and
  "xx"  do not affect formatting.

  ;     Separates sections for positive, negative, and zero numbers in the
        format string.

  The locations of the leftmost '0' before the decimal point in the format
  string and the rightmost '0' after the decimal point in the format string
  determine the range of digits that are always present in the output string.

  The number being formatted is always rounded to as many decimal places as
  there are digit placeholders ('0' or '#') to the right of the decimal
  point. If the format string contains no decimal point, the value being
  formatted is rounded to the nearest whole number.

  If the number being formatted has more digits to the left of the decimal
  separator than there are digit placeholders to the left of the '.'
  character in the format string, the extra digits are output before the
  first digit placeholder.

  To allow different formats for positive, negative, and zero values, the
  format string can contain between one and three sections separated by
  semicolons.

  One section - The format string applies to all values.

  Two sections - The first section applies to positive values and zeros, and
  the second section applies to negative values.

  Three sections - The first section applies to positive values, the second
  applies to negative values, and the third applies to zeros.

  If the section for negative values or the section for zero values is empty,
  that is if there is nothing between the semicolons that delimit the
  section, the section for positive values is used instead.

  If the section for positive values is empty, or if the entire format string
  is empty, the value is formatted using general floating-point formatting
  with 15 significant digits, corresponding to a call to FloatToStrF with
  the ffGeneral format. General floating-point formatting is also used if
  the value has more than 18 digits to the left of the decimal point and
  the format string does not specify scientific notation.

  The table below shows some sample formats and the results produced when
  the formats are applied to different values:

  Format string          1234        -1234       0.5         0
  -----------------------------------------------------------------------
                         1234        -1234       0.5         0
  0                      1234        -1234       1           0
  0.00                   1234.00     -1234.00    0.50        0.00
  #.##                   1234        -1234       .5
  #,##0.00               1,234.00    -1,234.00   0.50        0.00
  #,##0.00;(#,##0.00)    1,234.00    (1,234.00)  0.50        0.00
  #,##0.00;;Zero         1,234.00    -1,234.00   0.50        Zero
  0.000E+00              1.234E+03   -1.234E+03  5.000E-01   0.000E+00
  #.###E-0               1.234E3     -1.234E3    5E-1        0E0
  ----------------------------------------------------------------------- }

function FormatFloat(const Format: string; Value: Extended): string; overload; inline;
function FormatFloat(const Format: string; Value: Extended;
  const AFormatSettings: TFormatSettings): string; overload;

{ FormatCurr formats the currency value given by Value using the format
  string given by Format. For further details, see the description of the
  FormatFloat function. }

function FormatCurr(const Format: string; Value: Currency): string; overload; inline;
function FormatCurr(const Format: string; Value: Currency;
  const AFormatSettings: TFormatSettings): string; overload;

{ FloatToTextFmt converts the given floating-point value to its decimal
  representation using the specified format. The Value parameter must be a
  variable of type Extended or Currency, as indicated by the ValueType
  parameter. The resulting string of characters is stored in the given
  buffer, and the returned value is the number of characters stored. The
  resulting string is not null-terminated. For further details, see the
  description of the FormatFloat function. }

{$IFNDEF NEXTGEN}
function FloatToTextFmt(Buf: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: PAnsiChar): Integer; overload; inline; deprecated 'Moved to the AnsiStrings unit';
function FloatToTextFmt(Buf: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: PAnsiChar; const AFormatSettings: TFormatSettings): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}

function FloatToTextFmt(Buf: PWideChar; const Value; ValueType: TFloatValue;
  Format: PWideChar): Integer; overload; inline;
function FloatToTextFmt(Buf: PWideChar; const Value; ValueType: TFloatValue;
  Format: PWideChar; const AFormatSettings: TFormatSettings): Integer; overload;

{ StrToFloat converts the given string to a floating-point value. The string
  must consist of an optional sign (+ or -), a string of digits with an
  optional decimal point, and an optional 'E' or 'e' followed by a signed
  integer. Leading and trailing blanks in the string are ignored. The
  DecimalSeparator global variable defines the character that must be used
  as a decimal point. Thousand separators and currency symbols are not
  allowed in the string. If the string doesn't contain a valid value, an
  EConvertError exception is raised. }

function StrToFloat(const S: string): Extended; overload; inline;
function StrToFloat(const S: string;
  const AFormatSettings: TFormatSettings): Extended; overload;

function StrToFloatDef(const S: string;
  const Default: Extended): Extended; overload; inline;
function StrToFloatDef(const S: string; const Default: Extended;
  const AFormatSettings: TFormatSettings): Extended; overload;

function TryStrToFloat(const S: string; out Value: Extended): Boolean; overload; inline;
function TryStrToFloat(const S: string; out Value: Extended;
  const AFormatSettings: TFormatSettings): Boolean; overload;

function TryStrToFloat(const S: string; out Value: Double): Boolean; overload; inline;
function TryStrToFloat(const S: string; out Value: Double;
  const AFormatSettings: TFormatSettings): Boolean; overload;

function TryStrToFloat(const S: string; out Value: Single): Boolean; overload; inline;
function TryStrToFloat(const S: string; out Value: Single;
  const AFormatSettings: TFormatSettings): Boolean; overload;

{ StrToCurr converts the given string to a currency value. For further
  details, see the description of the StrToFloat function. }

function StrToCurr(const S: string): Currency; overload; inline;
function StrToCurr(const S: string;
  const AFormatSettings: TFormatSettings): Currency; overload;

function StrToCurrDef(const S: string;
  const Default: Currency): Currency; overload; inline;
function StrToCurrDef(const S: string; const Default: Currency;
  const AFormatSettings: TFormatSettings): Currency; overload;

function TryStrToCurr(const S: string; out Value: Currency): Boolean; overload; inline;
function TryStrToCurr(const S: string; out Value: Currency;
  const AFormatSettings: TFormatSettings): Boolean; overload;

{ TextToFloat converts the null-terminated string given by Buffer to a
  floating-point value which is returned in the variable given by Value.
  The Value parameter must be a variable of type Extended or Currency, as
  indicated by the ValueType parameter. The return value is True if the
  conversion was successful, or False if the string is not a valid
  floating-point value. For further details, see the description of the
  StrToFloat function. }

{$IFNDEF NEXTGEN}
function TextToFloat(Buffer: PAnsiChar; var Value;
  ValueType: TFloatValue): Boolean; overload; inline; deprecated 'Moved to the AnsiStrings unit';
function TextToFloat(Buffer: PAnsiChar; var Value; ValueType: TFloatValue;
  const AFormatSettings: TFormatSettings): Boolean; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}

function TextToFloat(Buffer: PWideChar; var Value;
  ValueType: TFloatValue): Boolean; overload; inline
  {$IFDEF NEXTGEN} deprecated 'use other version' {$ENDIF};
function TextToFloat(Buffer: PWideChar; var Value; ValueType: TFloatValue;
  const AFormatSettings: TFormatSettings): Boolean; overload
  {$IFDEF NEXTGEN} deprecated 'use other version' {$ENDIF};

function TextToFloat(const S: string; var Value: Extended): Boolean; overload;
function TextToFloat(const S: string; var Value: Extended;
  const AFormatSettings: TFormatSettings): Boolean; overload;
function TextToFloat(const S: string; var Value: Double): Boolean; overload;
function TextToFloat(const S: string; var Value: Double;
  const AFormatSettings: TFormatSettings): Boolean; overload;
function TextToFloat(const S: string; var Value: Currency): Boolean; overload;
function TextToFloat(const S: string; var Value: Currency;
  const AFormatSettings: TFormatSettings): Boolean; overload;

{$IFNDEF NEXTGEN}
function HashName(Name: PAnsiChar): Cardinal;
{$ENDIF !NEXTGEN}

{ FloatToDecimal converts a floating-point value to a decimal representation
  that is suited for further formatting. The Value parameter must be a
  variable of type Extended or Currency, as indicated by the ValueType
  parameter. For values of type Extended, the Precision parameter specifies
  the requested number of significant digits in the result--the allowed range
  is 1..18. For values of type Currency, the Precision parameter is ignored,
  and the implied precision of the conversion is 19 digits. The Decimals
  parameter specifies the requested maximum number of digits to the left of
  the decimal point in the result. Precision and Decimals together control
  how the result is rounded. To produce a result that always has a given
  number of significant digits regardless of the magnitude of the number,
  specify 9999 for the Decimals parameter. The result of the conversion is
  stored in the specified TFloatRec record as follows:

  Exponent - Contains the magnitude of the number, i.e. the number of
  significant digits to the right of the decimal point. The Exponent field
  is negative if the absolute value of the number is less than one. If the
  number is a NAN (not-a-number), Exponent is set to -32768. If the number
  is INF or -INF (positive or negative infinity), Exponent is set to 32767.

  Negative - True if the number is negative, False if the number is zero
  or positive.

  Digits - Contains up to 18 (for type Extended) or 19 (for type Currency)
  significant digits followed by a null terminator. The implied decimal
  point (if any) is not stored in Digits. Trailing zeros are removed, and
  if the resulting number is zero, NAN, or INF, Digits contains nothing but
  the null terminator. }

procedure FloatToDecimal(var Result: TFloatRec; const Value;
  ValueType: TFloatValue; Precision, Decimals: Integer);

{ Date/time support routines }

function DateTimeToTimeStamp(DateTime: TDateTime): TTimeStamp;

function TimeStampToDateTime(const TimeStamp: TTimeStamp): TDateTime;
function MSecsToTimeStamp(MSecs: Comp): TTimeStamp;
function TimeStampToMSecs(const TimeStamp: TTimeStamp): Comp;

{ EncodeDate encodes the given year, month, and day into a TDateTime value.
  The year must be between 1 and 9999, the month must be between 1 and 12,
  and the day must be between 1 and N, where N is the number of days in the
  specified month. If the specified values are not within range, an
  EConvertError exception is raised. The resulting value is the number of
  days between 12/30/1899 and the given date. }

function EncodeDate(Year, Month, Day: Word): TDateTime;

{ EncodeTime encodes the given hour, minute, second, and millisecond into a
  TDateTime value. The hour must be between 0 and 23, the minute must be
  between 0 and 59, the second must be between 0 and 59, and the millisecond
  must be between 0 and 999. If the specified values are not within range, an
  EConvertError exception is raised. The resulting value is a number between
  0 (inclusive) and 1 (not inclusive) that indicates the fractional part of
  a day given by the specified time. The value 0 corresponds to midnight,
  0.5 corresponds to noon, 0.75 corresponds to 6:00 pm, etc. }

function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime;

{ Instead of generating errors the following variations of EncodeDate and
  EncodeTime simply return False if the parameters given are not valid.
  Other than that, these functions are functionally the same as the above
  functions. }

function TryEncodeDate(Year, Month, Day: Word; out Date: TDateTime): Boolean;
function TryEncodeTime(Hour, Min, Sec, MSec: Word; out Time: TDateTime): Boolean;

{ DecodeDate decodes the integral (date) part of the given TDateTime value
  into its corresponding year, month, and day. If the given TDateTime value
  is less than or equal to zero, the year, month, and day return parameters
  are all set to zero. }

procedure DecodeDate(const DateTime: TDateTime; var Year, Month, Day: Word);

{ This variation of DecodeDate works similarly to the above function but
  returns more information.  The result value of this function indicates
  whether the year decoded is a leap year or not.  }

function DecodeDateFully(const DateTime: TDateTime; var Year, Month, Day,
  DOW: Word): Boolean;

{ DecodeTime decodes the fractional (time) part of the given TDateTime value
  into its corresponding hour, minute, second, and millisecond. }

procedure DecodeTime(const DateTime: TDateTime; var Hour, Min, Sec, MSec: Word);

{$IFDEF MSWINDOWS}
{ DateTimeToSystemTime converts a date and time from Delphi's TDateTime
  format into the Win32 API's TSystemTime format. }

procedure DateTimeToSystemTime(const DateTime: TDateTime; var SystemTime: TSystemTime);

{ SystemTimeToDateTime converts a date and time from the Win32 API's
  TSystemTime format into Delphi's TDateTime format. }

function SystemTimeToDateTime(const SystemTime: TSystemTime): TDateTime;

{ TrySystemTimeToDateTime converts a date and time from the Win32 API's
  TSystemTime format into Delphi's TDateTime format without raising an
  EConvertError exception. }

function TrySystemTimeToDateTime(const SystemTime: TSystemTime; out DateTime: TDateTime): Boolean;
{$ENDIF}

{ DayOfWeek returns the day of the week of the given date. The result is an
  integer between 1 and 7, corresponding to Sunday through Saturday.
  This function is not ISO 8601 compliant, for that see the DateUtils unit. }

function DayOfWeek(const DateTime: TDateTime): Word;

{ Date returns the current date. }

function Date: TDateTime;

{ Time returns the current time. }

function Time: TDateTime;
{$IFDEF LINUX}
  { clashes with Time in <X11/Xlib.h>, use GetTime instead }
  {$EXTERNALSYM Time}
{$ENDIF}
function GetTime: TDateTime;

{ Now returns the current date and time, corresponding to Date + Time. }

function Now: TDateTime;

{ Current year returns the year portion of the date returned by Now }

function CurrentYear: Word;

{ IncMonth returns Date shifted by the specified number of months.
  NumberOfMonths parameter can be negative, to return a date N months ago.
  If the input day of month is greater than the last day of the resulting
  month, the day is set to the last day of the resulting month.
  Input time of day is copied to the DateTime result.  }

function IncMonth(const DateTime: TDateTime; NumberOfMonths: Integer = 1): TDateTime;

{ Optimized version of IncMonth that works with years, months and days
  directly.  See above comments for more detail as to what happens to the day
  when incrementing months }

procedure IncAMonth(var Year, Month, Day: Word; NumberOfMonths: Integer = 1);

{ ReplaceTime replaces the time portion of the DateTime parameter with the given
  time value, adjusting the signs as needed if the date is prior to 1900
  (Date value less than zero)  }

procedure ReplaceTime(var DateTime: TDateTime; const NewTime: TDateTime);

{ ReplaceDate replaces the date portion of the DateTime parameter with the given
  date value, adjusting as needed for negative dates }

procedure ReplaceDate(var DateTime: TDateTime; const NewDate: TDateTime);

{ IsLeapYear determines whether the given year is a leap year. }

function IsLeapYear(Year: Word): Boolean;

type
  PDayTable = ^TDayTable;
  TDayTable = array[1..12] of Word;

{ The MonthDays array can be used to quickly find the number of
  days in a month:  MonthDays[IsLeapYear(Y), M]      }

const
  MonthDays: array [Boolean] of TDayTable =
    ((31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
     (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31));

{ Each of the date/time formatting routines that uses global variables
  for formatting (separators, decimals, etc.), has an overloaded equivalent
  requiring a parameter of type TFormatSettings. This additional parameter
  provides the formatting information rather than the global variables. For
  more information see the note at TFormatSettings.  }

{ DateToStr converts the date part of the given TDateTime value to a string.
  The conversion uses the format specified by the ShortDateFormat global
  variable. }

function DateToStr(const DateTime: TDateTime): string; overload; inline;
function DateToStr(const DateTime: TDateTime;
  const AFormatSettings: TFormatSettings): string; overload; inline;

{ TimeToStr converts the time part of the given TDateTime value to a string.
  The conversion uses the format specified by the LongTimeFormat global
  variable. }

function TimeToStr(const DateTime: TDateTime): string; overload; inline;
function TimeToStr(const DateTime: TDateTime;
  const AFormatSettings: TFormatSettings): string; overload; inline;

{ DateTimeToStr converts the given date and time to a string. The resulting
  string consists of a date and time formatted using the ShortDateFormat and
  LongTimeFormat global variables. Time information is included in the
  resulting string only if the fractional part of the given date and time
  value is non-zero. }

function DateTimeToStr(const DateTime: TDateTime): string; overload; inline;
function DateTimeToStr(const DateTime: TDateTime;
  const AFormatSettings: TFormatSettings): string; overload; inline;

{ StrToDate converts the given string to a date value. The string must
  consist of two or three numbers, separated by the character defined by
  the DateSeparator global variable. The order for month, day, and year is
  determined by the ShortDateFormat global variable--possible combinations
  are m/d/y, d/m/y, and y/m/d. If the string contains only two numbers, it
  is interpreted as a date (m/d or d/m) in the current year. Year values
  between 0 and 99 are assumed to be in the current century. If the given
  string does not contain a valid date, an EConvertError exception is
  raised. }

function StrToDate(const S: string): TDateTime; overload; inline;
function StrToDate(const S: string;
  const AFormatSettings: TFormatSettings): TDateTime; overload;

function StrToDateDef(const S: string;
  const Default: TDateTime): TDateTime; overload; inline;
function StrToDateDef(const S: string; const Default: TDateTime;
  const AFormatSettings: TFormatSettings): TDateTime; overload;

function TryStrToDate(const S: string; out Value: TDateTime): Boolean; overload; inline;
function TryStrToDate(const S: string; out Value: TDateTime;
  const AFormatSettings: TFormatSettings): Boolean; overload;

{ StrToTime converts the given string to a time value. The string must
  consist of two or three numbers, separated by the character defined by
  the TimeSeparator global variable, optionally followed by an AM or PM
  indicator. The numbers represent hour, minute, and (optionally) second,
  in that order. If the time is followed by AM or PM, it is assumed to be
  in 12-hour clock format. If no AM or PM indicator is included, the time
  is assumed to be in 24-hour clock format. If the given string does not
  contain a valid time, an EConvertError exception is raised. }

function StrToTime(const S: string): TDateTime; overload; inline;
function StrToTime(const S: string;
  const AFormatSettings: TFormatSettings): TDateTime; overload;

function StrToTimeDef(const S: string;
  const Default: TDateTime): TDateTime; overload; inline;
function StrToTimeDef(const S: string; const Default: TDateTime;
  const AFormatSettings: TFormatSettings): TDateTime; overload;

function TryStrToTime(const S: string; out Value: TDateTime): Boolean; overload; inline;
function TryStrToTime(const S: string; out Value: TDateTime;
  const AFormatSettings: TFormatSettings): Boolean; overload;

{ StrToDateTime converts the given string to a date and time value. The
  string must contain a date optionally followed by a time. The date and
  time parts of the string must follow the formats described for the
  StrToDate and StrToTime functions. }

function StrToDateTime(const S: string): TDateTime; overload; inline;
function StrToDateTime(const S: string;
  const AFormatSettings: TFormatSettings): TDateTime; overload;

function StrToDateTimeDef(const S: string;
  const Default: TDateTime): TDateTime; overload; inline;
function StrToDateTimeDef(const S: string; const Default: TDateTime;
  const AFormatSettings: TFormatSettings): TDateTime; overload;

function TryStrToDateTime(const S: string;
  out Value: TDateTime): Boolean; overload; inline;
function TryStrToDateTime(const S: string; out Value: TDateTime;
  const AFormatSettings: TFormatSettings): Boolean; overload;

{ FormatDateTime formats the date-and-time value given by DateTime using the
  format given by Format. The following format specifiers are supported:

  c       Displays the date using the format given by the ShortDateFormat
          global variable, followed by the time using the format given by
          the LongTimeFormat global variable. The time is not displayed if
          the fractional part of the DateTime value is zero.

  d       Displays the day as a number without a leading zero (1-31).

  dd      Displays the day as a number with a leading zero (01-31).

  ddd     Displays the day as an abbreviation (Sun-Sat) using the strings
          given by the ShortDayNames global variable.

  dddd    Displays the day as a full name (Sunday-Saturday) using the strings
          given by the LongDayNames global variable.

  ddddd   Displays the date using the format given by the ShortDateFormat
          global variable.

  dddddd  Displays the date using the format given by the LongDateFormat
          global variable.

  g       Displays the period/era as an abbreviation (Japanese and
          Taiwanese locales only).

  gg      Displays the period/era as a full name.

  e       Displays the year in the current period/era as a number without
          a leading zero (Japanese, Korean and Taiwanese locales only).

  ee      Displays the year in the current period/era as a number with
          a leading zero (Japanese, Korean and Taiwanese locales only).

  m       Displays the month as a number without a leading zero (1-12). If
          the m specifier immediately follows an h or hh specifier, the
          minute rather than the month is displayed.

  mm      Displays the month as a number with a leading zero (01-12). If
          the mm specifier immediately follows an h or hh specifier, the
          minute rather than the month is displayed.

  mmm     Displays the month as an abbreviation (Jan-Dec) using the strings
          given by the ShortMonthNames global variable.

  mmmm    Displays the month as a full name (January-December) using the
          strings given by the LongMonthNames global variable.

  yy      Displays the year as a two-digit number (00-99).

  yyyy    Displays the year as a four-digit number (0000-9999).

  h       Displays the hour without a leading zero (0-23).

  hh      Displays the hour with a leading zero (00-23).

  n       Displays the minute without a leading zero (0-59).

  nn      Displays the minute with a leading zero (00-59).

  s       Displays the second without a leading zero (0-59).

  ss      Displays the second with a leading zero (00-59).

  z       Displays the millisecond without a leading zero (0-999).

  zzz     Displays the millisecond with a leading zero (000-999).

  t       Displays the time using the format given by the ShortTimeFormat
          global variable.

  tt      Displays the time using the format given by the LongTimeFormat
          global variable.

  am/pm   Uses the 12-hour clock for the preceding h or hh specifier, and
          displays 'am' for any hour before noon, and 'pm' for any hour
          after noon. The am/pm specifier can use lower, upper, or mixed
          case, and the result is displayed accordingly.

  a/p     Uses the 12-hour clock for the preceding h or hh specifier, and
          displays 'a' for any hour before noon, and 'p' for any hour after
          noon. The a/p specifier can use lower, upper, or mixed case, and
          the result is displayed accordingly.

  ampm    Uses the 12-hour clock for the preceding h or hh specifier, and
          displays the contents of the TimeAMString global variable for any
          hour before noon, and the contents of the TimePMString global
          variable for any hour after noon.

  /       Displays the date separator character given by the DateSeparator
          global variable.

  :       Displays the time separator character given by the TimeSeparator
          global variable.

  'xx'    Characters enclosed in single or double quotes are displayed as-is,
  "xx"    and do not affect formatting.

  Format specifiers may be written in upper case as well as in lower case
  letters--both produce the same result.

  If the string given by the Format parameter is empty, the date and time
  value is formatted as if a 'c' format specifier had been given.

  The following example:

    S := FormatDateTime('"The meeting is on" dddd, mmmm d, yyyy, ' +
      '"at" hh:mm AM/PM', StrToDateTime('2/15/95 10:30am'));

  assigns 'The meeting is on Wednesday, February 15, 1995 at 10:30 AM' to
  the string variable S. }

function FormatDateTime(const Format: string;
  DateTime: TDateTime): string; overload; inline;
function FormatDateTime(const Format: string; DateTime: TDateTime;
  const AFormatSettings: TFormatSettings): string; overload;

{ DateTimeToString converts the date and time value given by DateTime using
  the format string given by Format into the string variable given by Result.
  For further details, see the description of the FormatDateTime function. }

procedure DateTimeToString(var Result: string; const Format: string;
  DateTime: TDateTime); overload; inline;
procedure DateTimeToString(var Result: string; const Format: string;
  DateTime: TDateTime; const AFormatSettings: TFormatSettings); overload;

{ FloatToDateTime will range validate a value to make sure it falls
  within the acceptable date range }

const
  MinDateTime: TDateTime = -657434.0;      { 01/01/0100 12:00:00.000 AM }
  MaxDateTime: TDateTime =  2958465.99999; { 12/31/9999 11:59:59.999 PM }

function FloatToDateTime(const Value: Extended): TDateTime;
function TryFloatToDateTime(const Value: Extended; out AResult: TDateTime): Boolean;

{ System error messages }

function SysErrorMessage(ErrorCode: Cardinal): string;

{ Initialization file support }

function GetLocaleStr(Locale, LocaleType: Integer; const Default: string): string; platform;
function GetLocaleChar(Locale, LocaleType: Integer; Default: Char): Char; platform;

{ GetFormatSettings resets all locale-specific variables (date, time, number,
  currency formats, system locale) to the values provided by the operating system. }

procedure GetFormatSettings;

{ GetLocaleFormatSettings loads locale-specific variables (date, time, number,
  currency formats) with values provided by the operating system for the
  specified locale. The values are stored in the FormatSettings record.

  Note: This function is deprecated, TFormatSettings.Create(Locale)
  should be used instead. }

procedure GetLocaleFormatSettings(Locale: TLocaleID;
  var AFormatSettings: TFormatSettings); inline; platform; deprecated 'Use TFormatSettings.Create(Locale)';

{$IFDEF MSWINDOWS}
{
  LCIDToCodePage retrieves the ANSI codepage associated with a given
  locale identifier.
}
function LCIDToCodePage(const ALCID: LCID): Integer;
{$ENDIF MSWINDOWS}

{ Exception handling routines }

{$IFDEF POSIX}
{
    See the comment at the threadvar declarations for these below.  The access
    to these has been implemented through getter/setter functions because you
    cannot use threadvars across packages.
}
procedure SetSafeCallExceptionMsg(const Msg: String);
procedure SetSafeCallExceptionAddr(Addr: Pointer);
function GetSafeCallExceptionMsg: String;
function GetSafeCallExceptionAddr: Pointer;

{ HookOSExceptionsProc is used internally and cannot be used in a conventional
  manner.  DON'T ever set this variable. }
var
  HookOSExceptionsProc: procedure = nil platform deprecated;

{ LoadLibrary / FreeLibrary are defined here only for convenience.  On Linux,
  they map directly to dlopen / dlclose.  Note that module loading semantics
  on Linux are not identical to Winapi.Windows.  }

function LoadLibrary(ModuleName: PChar): HMODULE;

function FreeLibrary(Module: HMODULE): LongBool;

{ GetProcAddress does what it implies.  It performs the same function as the like
  named function under Winapi.Windows.  dlsym does not quite have the same sematics as
  GetProcAddress as it will return the address of a symbol in another module if
  it was not found in the given HMODULE.  This function will verify that the 'Proc'
  is actually found within the 'Module', and if not returns nil }
function GetProcAddress(Module: HMODULE; Proc: PChar): Pointer;

{ Given a module name, this function will return the module handle.  There is no
  direct equivalent in Linux so this function provides that capability.  Also
  note, this function is specific to glibc. }
function GetModuleHandle(ModuleName: PChar): HMODULE;

{ This function works just like GetModuleHandle, except it will look for a module
  that matches the given base package name.  For example, given the base package
  name 'package', the actual module name is, by default, 'bplpackage.so'.  This
  function will search for the string 'package' within the module name. }
function GetPackageModuleHandle(PackageName: PChar): HMODULE;

{$ENDIF POSIX}

{ In Linux, the parameter to sleep() is in whole seconds.  In Windows, the
  parameter is in milliseconds.  To ease headaches, we implement a version
  of sleep here for Linux that takes milliseconds and calls a Linux system
  function with sub-second resolution.  This maps directly to the Windows
  API on Winapi.Windows. }

procedure Sleep(milliseconds: Cardinal);{$IFDEF MSWINDOWS} stdcall; {$ENDIF}
{$IFDEF MSWINDOWS}
(*$EXTERNALSYM Sleep*)
{$ENDIF}

function GetModuleName(Module: HMODULE): string;

function ExceptionErrorMessage(ExceptObject: TObject; ExceptAddr: Pointer;
  Buffer: PChar; Size: Integer): Integer;

procedure ShowException(ExceptObject: TObject; ExceptAddr: Pointer);

procedure Abort;

procedure OutOfMemoryError;

procedure Beep; inline;

{ MBCS functions }

{ LeadBytes is a char set that indicates which char values are lead bytes
  in multibyte character sets (Japanese, Chinese, etc).
  This set is always empty for western locales. }
var
{$IFNDEF NEXTGEN}
  LeadBytes: set of AnsiChar = [];
{$ELSE NEXTGEN}
  LeadBytes: set of Byte = [];
{$ENDIF !NEXTGEN}

(*$EXTERNALSYM LeadBytes*)
(*$HPPEMIT 'namespace System {'*)
(*$HPPEMIT 'namespace Sysutils {'*)
(*$HPPEMIT 'extern PACKAGE System::Set<System::Byte, 0, 255>  LeadBytes;'*)
(*$HPPEMIT '} // namespace Sysutils'*)
(*$HPPEMIT '} // namespace System'*)

{ ByteType indicates what kind of byte exists at the Index'th byte in S.
  Western locales always return mbSingleByte.  Far East multibyte locales
  may also return mbLeadByte, indicating the byte is the first in a multibyte
  character sequence, and mbTrailByte, indicating that the byte is one of
  a sequence of bytes following a lead byte.  One or more trail bytes can
  follow a lead byte, depending on locale charset encoding and OS platform.
  Parameters are assumed to be valid. }

{$IFNDEF NEXTGEN}
function ByteType(const S: AnsiString; Index: Integer): TMbcsByteType; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function ByteType(const S: UnicodeString; Index: Integer): TMbcsByteType; overload;

{ StrByteType works the same as ByteType, but on null-terminated PChar strings }

{$IFNDEF NEXTGEN}
function StrByteType(Str: PAnsiChar; Index: Cardinal): TMbcsByteType; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrByteType(Str: PWideChar; Index: Cardinal): TMbcsByteType; overload;

{ ByteToCharLen returns the character length of a MBCS string, scanning the
  string for up to MaxLen bytes.  In multibyte character sets, the number of
  characters in a string may be less than the number of bytes.  }

{$IFNDEF NEXTGEN}
function ByteToCharLen(const S: AnsiString; MaxLen: Integer): Integer; overload; inline; deprecated 'Use ElementToCharLen';
{$ENDIF !NEXTGEN}
function ByteToCharLen(const S: UnicodeString; MaxLen: Integer): Integer; overload; inline; deprecated 'Use ElementToCharLen.';

{$IFNDEF NEXTGEN}
function ElementToCharLen(const S: AnsiString; MaxLen: Integer): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function ElementToCharLen(const S: UnicodeString; MaxLen: Integer): Integer; overload;

{ CharToByteLen returns the byte length of a MBCS string, scanning the string
  for up to MaxLen characters. }

{$IFNDEF NEXTGEN}
function CharToByteLen(const S: AnsiString; MaxLen: Integer): Integer; overload; inline; deprecated 'Use CharToElementLen.';
{$ENDIF !NEXTGEN}
function CharToByteLen(const S: UnicodeString; MaxLen: Integer): Integer; overload; inline; deprecated 'Use CharToElementLen.';

{$IFNDEF NEXTGEN}
function CharToElementLen(const S: AnsiString; MaxLen: Integer): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function CharToElementLen(const S: UnicodeString; MaxLen: Integer): Integer; overload;

{ ByteToCharIndex returns the 1-based character index of the Index'th byte in
  a MBCS string.  Returns zero if Index is out of range:
  (Index <= 0) or (Index > Length(S)) }

{$IFNDEF NEXTGEN}
function ByteToCharIndex(const S: AnsiString; Index: Integer): Integer; overload; inline; deprecated 'Use ElementToCharIndex.';
{$ENDIF !NEXTGEN}
function ByteToCharIndex(const S: UnicodeString; Index: Integer): Integer; overload; inline; deprecated 'Use ElementToCharIndex.';

{$IFNDEF NEXTGEN}
function ElementToCharIndex(const S: AnsiString; Index: Integer): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function ElementToCharIndex(const S: UnicodeString; Index: Integer): Integer; overload;

{ CharToByteIndex returns the 1-based byte index of the Index'th character
  in a MBCS string.  Returns zero if Index or Result are out of range:
  (Index <= 0) or (Index > Length(S)) or (Result would be > Length(S)) }

{$IFNDEF NEXTGEN}
function CharToByteIndex(const S: AnsiString; Index: Integer): Integer; overload; inline; deprecated 'Use CharToElementIndex.';
{$ENDIF !NEXTGEN}
function CharToByteIndex(const S: UnicodeString; Index: Integer): Integer; overload; inline; deprecated 'Use CharToElementIndex.';

{$IFNDEF NEXTGEN}
function CharToElementIndex(const S: AnsiString; Index: Integer): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function CharToElementIndex(const S: UnicodeString; Index: Integer): Integer; overload;

{ StrCharLength returns the number of bytes required by the first character
  in Str.  In Windows, multibyte characters can be up to two bytes in length.
  In Linux, multibyte characters can be up to six bytes in length (UTF-8). }

{$IFNDEF NEXTGEN}
function StrCharLength(const Str: PAnsiChar): Integer; overload; deprecated 'Moved to the AnsiStrings unit';
{$ELSE}
function StrCharLength(const Str: PByte): Integer; overload;
{$ENDIF !NEXTGEN}
function StrCharLength(const Str: PWideChar): Integer; overload;

{ StrNextChar returns a pointer to the first byte of the character following
  the character pointed to by Str.  }

{$IFNDEF NEXTGEN}
function StrNextChar(const Str: PAnsiChar): PAnsiChar; inline; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function StrNextChar(const Str: PWideChar): PWideChar; overload;

{ CharLength returns the number of bytes required by the character starting
  at bytes S[Index].  }

function CharLength(const S: UnicodeString; Index: Integer): Integer; overload;

{ NextCharIndex returns the byte index of the first byte of the character
  following the character starting at S[Index].  }

function NextCharIndex(const S: UnicodeString; Index: Integer): Integer; overload;

{ IsLeadChar returns whether or not the Char is part of a multi-character sequence }

{$IFNDEF NEXTGEN}
function IsLeadChar(C: AnsiChar): Boolean; overload; inline;
{$ENDIF !NEXTGEN}
function IsLeadChar(C: Byte): Boolean; overload; inline;
function IsLeadChar(C: WideChar): Boolean; overload; inline;

{ CharInSet tests whether or not the given character is in the given set of lower
  characters }

{$IFNDEF NEXTGEN}
function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean; overload; inline;
function CharInSet(C: WideChar; const CharSet: TSysCharSet): Boolean; overload; inline;
{$ELSE}
function CharInSet(C: Byte; const CharSet: TSysCharSet): Boolean; overload; inline; deprecated 'Use TCharHelper functionality';
function CharInSet(C: Char; const CharSet: TSysCharSet): Boolean; overload; inline; deprecated 'Use TCharHelper functionality';
{$ENDIF}

{ IsPathDelimiter returns True if the character at byte S[Index]
  is a PathDelimiter ('\' or '/'), and it is not a MBCS lead or trail byte. }

function IsPathDelimiter(const S: string; Index: Integer): Boolean; overload;

{ IsDelimiter returns True if the character at byte S[Index] matches any
  character in the Delimiters string, and the character is not a MBCS lead or
  trail byte.  S may contain multibyte characters; Delimiters must contain
  only single byte characters. }

function IsDelimiter(const Delimiters, S: string; Index: Integer): Boolean; overload;

{ IncludeTrailingPathDelimiter returns the path with a PathDelimiter
  ('/' or '\') at the end.  This function is MBCS enabled. }

function IncludeTrailingPathDelimiter(const S: string): string; overload;

{ IncludeTrailingBackslash is the old name for IncludeTrailingPathDelimiter. }

function IncludeTrailingBackslash(const S: string): string; platform; overload; inline;

{ ExcludeTrailingPathDelimiter returns the path without a PathDelimiter
  ('\' or '/') at the end.  This function is MBCS enabled. }

function ExcludeTrailingPathDelimiter(const S: string): string; overload;

{ ExcludeTrailingBackslash is the old name for ExcludeTrailingPathDelimiter. }

function ExcludeTrailingBackslash(const S: string): string; platform; overload; inline;

{ LastDelimiter returns the byte index in S of the rightmost whole
  character that matches any character in Delimiters (except null (#0)).
  S may contain multibyte characters; Delimiters must contain only single
  byte non-null characters.
  Example: LastDelimiter('\.:', 'c:\filename.ext') returns 12. }

function LastDelimiter(const Delimiters, S: string): Integer; overload;

{ FindDelimiter returns the index in S of the character that matches any of
  the characters in Delimiters (except null (#)). StartIdx specifies the
  index in S at which the search for delimiters will start. }

function FindDelimiter(const Delimiters, S: string; StartIdx: Integer = 1): Integer;

{ AnsiCompareFileName supports DOS file name comparison idiosyncracies
  in Far East locales (Zenkaku) on Winapi.Windows.
  In non-MBCS locales on Windows, AnsiCompareFileName is identical to
  AnsiCompareText (case insensitive).
  On Linux, AnsiCompareFileName is identical to AnsiCompareStr (case sensitive).
  For general purpose file name comparisions, you should use this function
  instead of AnsiCompareText. }

function AnsiCompareFileName(const S1, S2: string; CheckVolumeCase: Boolean=False): Integer; overload;

function SameFileName(const S1, S2: string): Boolean; inline; overload;

{ AnsiLowerCaseFileName is identical to AnsiLowerCase. }

function AnsiLowerCaseFileName(const S: string): string; overload; deprecated 'Use AnsiLowerCase instead';

{ AnsiUpperCaseFileName is identical to AnsiUpperCase. }

function AnsiUpperCaseFileName(const S: string): string; overload; deprecated 'Use AnsiUpperCase instead';

{ AnsiPos:  Same as Pos but supports MBCS strings }

function AnsiPos(const Substr, S: string): Integer; overload;

{ AnsiStrPos: Same as StrPos but supports MBCS strings }

{$IFNDEF NEXTGEN}
function AnsiStrPos(Str, SubStr: PAnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrPos(Str, SubStr: PWideChar): PWideChar; overload;

{ AnsiStrRScan: Same as StrRScan but supports MBCS strings }

{$IFNDEF NEXTGEN}
function AnsiStrRScan(Str: PAnsiChar; Chr: AnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrRScan(Str: PWideChar; Chr: WideChar): PWideChar; inline; overload;

{ AnsiStrScan: Same as StrScan but supports MBCS strings }

{$IFNDEF NEXTGEN}
function AnsiStrScan(Str: PAnsiChar; Chr: AnsiChar): PAnsiChar; overload; deprecated 'Moved to the AnsiStrings unit';
{$ENDIF !NEXTGEN}
function AnsiStrScan(Str: PWideChar; Chr: WideChar): PWideChar; overload; inline;

{ StringReplace replaces occurances of <oldpattern> with <newpattern> in a
  given string.  Assumes the string may contain Multibyte characters }

type
  TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);

function StringReplace(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string; overload;

{ WrapText will scan a string for BreakChars and insert the BreakStr at the
  last BreakChar position before MaxCol.  Will not insert a break into an
  embedded quoted string (both ''' and '"' supported) }

function WrapText(const Line, BreakStr: string; const BreakChars: TSysCharSet;
  MaxCol: Integer): string; overload;
function WrapText(const Line: string; MaxCol: Integer = 45): string; overload;

{ FindCmdLineSwitch determines whether the string in the Switch parameter
  was passed as a command line argument to the application.  SwitchChars
  identifies valid argument-delimiter characters (i.e., "-" and "/" are
  common delimiters). The IgnoreCase paramter controls whether a
  case-sensistive or case-insensitive search is performed. }

const
  SwitchChars = {$IFDEF MSWINDOWS} ['/','-']; {$ENDIF}
                {$IFDEF LINUX}  ['-'];  {$ENDIF}
                {$IFDEF MACOS}  ['-'];  {$ENDIF}

function FindCmdLineSwitch(const Switch: string; const Chars: TSysCharSet;
  IgnoreCase: Boolean): Boolean; overload;

{ These versions of FindCmdLineSwitch are convenient for writing portable
  code.  The characters that are valid to indicate command line switches vary
  on different platforms.  For example, '/' cannot be used as a switch char
  on Linux because '/' is the path delimiter. }

{ This version uses SwitchChars defined above, and IgnoreCase False. }
function FindCmdLineSwitch(const Switch: string): Boolean; overload;

{ This version uses SwitchChars defined above. }
function FindCmdLineSwitch(const Switch: string; IgnoreCase: Boolean): Boolean; overload;

type
  TCmdLineSwitchType = (clstValueNextParam, clstValueAppended);
  TCmdLineSwitchTypes = set of TCmdLineSwitchType;

{ This version is used to return values.
  Switch values may be specified in the following ways on the command line:
    -p Value                - clstValueNextParam
    -pValue or -p:Value     - clstValueAppended

  Pass the SwitchTypes parameter to exclude either of these switch types.
  Switch may be 1 or more characters in length. }
function FindCmdLineSwitch(const Switch: string; var Value: string; IgnoreCase: Boolean = True;
  const SwitchTypes: TCmdLineSwitchTypes = [clstValueNextParam, clstValueAppended]): Boolean; overload;

{ FreeAndNil frees the given TObject instance and sets the variable reference
  to nil.  Be careful to only pass TObjects to this routine. }

procedure FreeAndNil(var Obj); inline;

{ Interface support routines }

function Supports(const Instance: IInterface; const IID: TGUID; out Intf): Boolean; overload;
function Supports(const Instance: TObject; const IID: TGUID; out Intf): Boolean; overload;
function Supports(const Instance: IInterface; const IID: TGUID): Boolean; overload;
function Supports(const Instance: TObject; const IID: TGUID): Boolean; overload; // Unsafe
function Supports(const AClass: TClass; const IID: TGUID): Boolean; overload;

function CreateGUID(out Guid: TGUID): HResult;
function StringToGUID(const S: string): TGUID;
function GUIDToString(const Guid: TGUID): string;
function IsEqualGUID(const Guid1, Guid2: TGUID): Boolean;

type
  TGuidHelper = record helper for TGUID
    class function Create(const B: TBytes): TGUID; overload; static;
    class function Create(const S: string): TGUID; overload; static;
    class function Create(A: Integer; B: SmallInt; C: SmallInt; const D: TBytes): TGUID; overload; static;
    class function Create(A: Integer; B: SmallInt; C: SmallInt; D, E, F, G, H, I, J, K: Byte): TGUID; overload; static;
    class function Create(A: Cardinal; B: Word; C: Word; D, E, F, G, H, I, J, K: Byte): TGUID; overload; static;
    class function NewGuid: TGUID; static;
    function ToByteArray: TBytes;
    function ToString: string;
  end;

{$IFDEF MSWINDOWS}
  {$EXTERNALSYM IsEqualGUID}
{$ENDIF}

{$IFNDEF NEXTGEN}
{ Package support routines }

{ Package Info flags }

const
  pfNeverBuild = $00000001;
  pfDesignOnly = $00000002;
  pfRunOnly = $00000004;
  pfIgnoreDupUnits = $00000008;
  pfModuleTypeMask = $C0000000;
  pfExeModule = $00000000;
  pfPackageModule = $40000000;
  pfProducerMask = $0C000000;
  pfV3Produced =  $00000000;
  pfProducerUndefined = $04000000;
  pfBCB4Produced = $08000000;
  pfDelphi4Produced = $0C000000;
  pfLibraryModule = $80000000;
  pfConsumerMask = $00F00000;
  pfConsumerCompat = $00000000;
  pfConsumerDelphi = $00100000;
  pfConsumerBCB = $00200000;

{ Unit info flags }

const
  ufMainUnit = $01;
  ufPackageUnit = $02;
  ufWeakUnit = $04;
  ufOrgWeakUnit = $08;
  ufImplicitUnit = $10;

  ufWeakPackageUnit = ufPackageUnit or ufWeakUnit;

{$IFDEF POSIX}
var
  PkgLoadingMode: Integer = RTLD_LAZY;
{$ENDIF POSIX}

{ Procedure type of the callback given to GetPackageInfo.  Name is the actual
  name of the package element.  If IsUnit is True then Name is the name of
  a contained unit; a required package if False.  Param is the value passed
  to GetPackageInfo }

type
  TNameType = (ntContainsUnit, ntRequiresPackage, ntDcpBpiName);

  TPackageInfoProc = procedure (const Name: string; NameType: TNameType; Flags: Byte; Param: Pointer);
  TValidatePackageProc = function (Module: HMODULE): Boolean;

{ LoadPackage loads a given package DLL, checks for duplicate units and
  calls the initialization blocks of all the contained units.  Duplicate unit checks are
  bypassed if the AValidatePackage function returns "True."  Be warned that this may cause
  strange and unpredictable behaviour if two packages are loaded that contain the same
  units and types. }

function LoadPackage(const Name: string): HMODULE; overload;
function LoadPackage(const Name: string; AValidatePackage: TValidatePackageProc): HMODULE; overload;

{ UnloadPackage does the opposite of LoadPackage by calling the finalization
  blocks of all contained units, then unloading the package DLL }

procedure UnloadPackage(Module: HMODULE);

{ GetPackageInfo accesses the given package's info table and enumerates
  all the contained units and required packages }

procedure GetPackageInfo(Module: HMODULE; Param: Pointer; var Flags: Integer;
  InfoProc: TPackageInfoProc);

{ GetPackageDescription loads the description resource from the package
  library. If the description resource does not exist,
  an empty string is returned. }
function GetPackageDescription(ModuleName: PChar): string;

{ GetPackageTargets loads a Word value from the package library which
  identifies on which platforms package is assumed to be available. If
  the resource does not exist, a value of 0 is returned which implies
  Win32 only. }
function GetPackageTargets(Module: HMODULE): Word;

{ InitializePackage validates and initializes the given package DLL }

procedure InitializePackage(Module: HMODULE); overload;
procedure InitializePackage(Module: HMODULE; AValidatePackage: TValidatePackageProc); overload;

{ FinalizePackage finalizes the given package DLL }

procedure FinalizePackage(Module: HMODULE);

{ RaiseLastOSError calls GetLastError to retrieve the code for
  the last occuring error in a call to an OS or system library function.
  If GetLastError returns an error code,  RaiseLastOSError raises
  an EOSError exception with the error code and a system-provided
  message associated with with error. }
{$ENDIF !NEXTGEN}

procedure RaiseLastOSError; overload;
procedure RaiseLastOSError(LastError: Integer); overload;
procedure RaiseLastOSError(LastError: Integer; const AdditionalInfo: string); overload;
procedure CheckOSError(LastError: Integer); inline;

{$IFDEF MSWINDOWS}
procedure RaiseLastWin32Error; deprecated 'Use RaiseLastOSError';

{ Win32Check is used to check the return value of a Win32 API function     }
{ which returns a BOOL to indicate success.  If the Win32 API function     }
{ returns False (indicating failure), Win32Check calls RaiseLastOSError }
{ to raise an exception.  If the Win32 API function returns True,          }
{ Win32Check returns True. }

function Win32Check(RetVal: BOOL): BOOL; platform;
{$ENDIF MSWINDOWS}

{ Termination procedure support }

type
  TTerminateProc = function: Boolean;

{ Call AddTerminateProc to add a terminate procedure to the system list of }
{ termination procedures.  Delphi will call all of the function in the     }
{ termination procedure list before an application terminates.  The user-  }
{ defined TermProc function should return True if the application can      }
{ safely terminate or False if the application cannot safely terminate.    }
{ If one of the functions in the termination procedure list returns False, }
{ the application will not terminate. }

procedure AddTerminateProc(TermProc: TTerminateProc);

{ CallTerminateProcs is called by VCL when an application is about to }
{ terminate.  It returns True only if all of the functions in the     }
{ system's terminate procedure list return True.  This function is    }
{ intended only to be called by Delphi, and it should not be called   }
{ directly. }

function CallTerminateProcs: Boolean;

function GDAL: LongWord;
procedure RCS;
procedure RPR;


{ HexDisplayPrefix contains the prefix to display on hexadecimal
  values - '$' for Pascal syntax, '0x' for C++ syntax.  This is
  for display only - this does not affect the string-to-integer
  conversion routines. }
var
  HexDisplayPrefix: string = '$';

{$IFDEF MSWINDOWS}
{ The GetDiskFreeSpace Win32 API does not support partitions larger than 2GB
  under Win95.  A new Win32 function, GetDiskFreeSpaceEx, supports partitions
  larger than 2GB but only exists on Win NT 4.0 and Win95 OSR2.
  The GetDiskFreeSpaceEx function pointer variable below will be initialized
  at startup to point to either the actual OS API function if it exists on
  the system, or to an internal Delphi function if it does not.  When running
  on Win95 pre-OSR2, the output of this function will still be limited to
  the 2GB range reported by Win95, but at least you don't have to worry
  about which API function to call in code you write.  }

var
  GetDiskFreeSpaceEx: function (Directory: PChar; var FreeAvailable,
    TotalSpace: TLargeInteger; TotalFree: PLargeInteger): Bool stdcall = nil;

{ SafeLoadLibrary calls LoadLibrary, disabling normal Win32 error message
  popup dialogs if the requested file can't be loaded.  SafeLoadLibrary also
  preserves the current FPU control word (precision, exception masks) across
  the LoadLibrary call (in case the DLL you're loading hammers the FPU control
  word in its initialization, as many MS DLLs do)}

function SafeLoadLibrary(const FileName: string;
  ErrorMode: UINT = SEM_NOOPENFILEERRORBOX): HMODULE;

{$ENDIF MSWINDOWS}

{$IFDEF POSIX}
{ SafeLoadLibrary calls LoadLibrary preserves the current FPU control
  word (precision, exception masks) across the LoadLibrary call (in
  case the shared object you're loading hammers the FPU control
  word in its initialization, as many MS DLLs do) }

function SafeLoadLibrary(const FileName: string;
  Dummy: LongWord = 0): HMODULE;
{$ENDIF POSIX}

{ Thread synchronization }

{ IReadWriteSync is an abstract interface for general read/write synchronization.
  Some implementations may allow simultaneous readers, but writers always have
  exclusive locks.

  Worst case is that this class behaves identical to a TRTLCriticalSection -
  that is, read and write locks block all other threads. }

type
  IReadWriteSync = interface
    ['{7B108C52-1D8F-4CDB-9CDF-57E071193D3F}']
    procedure BeginRead;
    procedure EndRead;
    function BeginWrite: Boolean;
    procedure EndWrite;
  end;

  TSimpleRWSync = class(TInterfacedObject, IReadWriteSync)
  private
    FLock: TObject;
  public
    constructor Create;
    destructor Destroy; override;
    procedure BeginRead;
    procedure EndRead;
    function BeginWrite: Boolean;
    procedure EndWrite;
  end;

{ TThreadLocalCounter

  This class implements a lightweight non-blocking thread local storage
  mechanism specifically built for tracking per-thread recursion counts
  in TMultiReadExclusiveWriteSynchronizer.  This class is intended for
  Delphi RTL internal use only.  In the future it may be generalized
  and "hardened" for general application use, but until then leave it alone.

  Rules of Use:
  The tls object must be opened to gain access to the thread-specific data
  structure.  If a threadinfo block does not exist for the current thread,
  Open will allocate one.  Every call to Open must be matched with a call
  to Close.  The pointer returned by Open is invalid after the matching call
  to Close (or Delete).

  The thread info structure is unique to each thread.  Once you have it, it's
  yours.  You don't need to guard against concurrent access to the thread
  data by multiple threads - your thread is the only thread that will ever
  have access to the structure that Open returns.  The thread info structure
  is allocated and owned by the tls object.  If you put allocated pointers
  in the thread info make sure you free them before you delete the threadinfo
  node.

  When thread data is no longer needed, call the Delete method on the pointer.
  This must be done between calls to Open and Close.  You should not use the
  thread data after calling Delete.

  Important:  Do not keep the tls object open for long periods of time.
  In particular, be careful not to wait on a thread synchronization event or
  critical section while you have the tls object open.  It's much better to
  open and close the tls object before and after the blocking event than to
  leave the tls object open while waiting.

  Implementation Notes:
  The main purpose of this storage class is to provide thread-local storage
  without using limited / problematic OS tls slots and without requiring
  expensive blocking thread synchronization.  This class performs no
  blocking waits or spin loops!  (except for memory allocation)

  Thread info is kept in linked lists to facilitate non-blocking threading
  techniques.  A hash table indexed by a hash of the current thread ID
  reduces linear search times.

  When a node is deleted, its thread ID is stripped and its Active field is
  set to zero, meaning it is available to be recycled for other threads.
  Nodes are never removed from the live list or freed while the class is in
  use.  All nodes are freed when the class is destroyed.

  Nodes are only inserted at the front of the list (each list in the hash table).

  The linked list management relies heavily on InterlockedExchange to perform
  atomic node pointer replacements.  There are brief windows of time where
  the linked list may be circular while a two-step insertion takes place.
  During that brief window, other threads traversing the lists may see
  the same node more than once more than once. (pun!) This is fine for what this
  implementation needs.  Don't do anything silly like try to count the
  nodes during a traversal.
}

type
  PThreadInfo = ^TThreadInfo;
  TThreadInfo = record
    Next: PThreadInfo;
    ThreadID: TThreadID;
    Active: Integer;
    RecursionCount: Cardinal;
  end;

  TThreadLocalCounter = class
  private
    FHashTable: array [0..15] of PThreadInfo;
    function HashIndex: Byte;
    function Recycle: PThreadInfo;
  public
    destructor Destroy; override;
    procedure Open(var Thread: PThreadInfo);
    procedure Delete(var Thread: PThreadInfo);
    procedure Close(var Thread: PThreadInfo);
  end;


{ TMultiReadExclusiveWriteSynchronizer minimizes thread serialization to gain
  read access to a resource shared among threads while still providing complete
  exclusivity to callers needing write access to the shared resource.
  (multithread shared reads, single thread exclusive write)
  Read locks are allowed while owning a write lock.
  Read locks can be promoted to write locks within the same thread.
  (BeginRead, BeginWrite, EndWrite, EndRead)

  Note: Other threads have an opportunity to modify the protected resource
  when you call BeginWrite before you are granted the write lock, even
  if you already have a read lock open.  Best policy is not to retain
  any info about the protected resource (such as count or size) across a
  write lock.  Always reacquire samples of the protected resource after
  acquiring or releasing a write lock.

  The function result of BeginWrite indicates whether another thread got
  the write lock while the current thread was waiting for the write lock.
  Return value of True means that the write lock was acquired without
  any intervening modifications by other threads.  Return value of False
  means another thread got the write lock while you were waiting, so the
  resource protected by the MREWS object should be considered modified.
  Any samples of the protected resource should be discarded.

  In general, it's better to just always reacquire samples of the protected
  resource after obtaining a write lock.  The boolean result of BeginWrite
  and the RevisionLevel property help cases where reacquiring the samples
  is computationally expensive or time consuming.

  RevisionLevel changes each time a write lock is granted.  You can test
  RevisionLevel for equality with a previously sampled value of the property
  to determine if a write lock has been granted, implying that the protected
  resource may be changed from its state when the original RevisionLevel
  value was sampled.  Do not rely on the sequentiality of the current
  RevisionLevel implementation (it will wrap around to zero when it tops out).
  Do not perform greater than / less than comparisons on RevisionLevel values.
  RevisionLevel indicates only the stability of the protected resource since
  your original sample.  It should not be used to calculate how many
  revisions have been made.
}

{$IFDEF MSWINDOWS}
type
  TMultiReadExclusiveWriteSynchronizer = class(TInterfacedObject, IReadWriteSync)
  private
    FSentinel: Integer;
    FReadSignal: THandle;
    FWriteSignal: THandle;
    FWaitRecycle: Cardinal;
    FWriteRecursionCount: Cardinal;
    tls: TThreadLocalCounter;
    FWriterID: Cardinal;
    FRevisionLevel: Cardinal;
    procedure BlockReaders;
    procedure UnblockReaders;
    procedure UnblockOneWriter;
    procedure WaitForReadSignal;
    procedure WaitForWriteSignal;
{$IFDEF DEBUG_MREWS}
    procedure Debug(const Msg: string);
{$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure BeginRead;
    procedure EndRead;
    function BeginWrite: Boolean;
    procedure EndWrite;
    property RevisionLevel: Cardinal read FRevisionLevel;
  end;
{$ELSE}
type
  TMultiReadExclusiveWriteSynchronizer = TSimpleRWSync;
{$ENDIF}

type
  TMREWSync = TMultiReadExclusiveWriteSynchronizer;  // short form

function GetEnvironmentVariable(const Name: string): string; overload;

// Utility function for .NET source compatibility

function DelegatesEqual(A, B: Pointer): Boolean; inline;

// Utility functions for Unicode support

function ByteLength(const S: string): Integer; inline;

type
  TCharArray = TArray<Char>;

// Record and Class for Delphi Native Stringbuilder
type
  TCharSearch = record
    ArrayPtr: PChar;
    MatchPtr: PChar;
  end;

  TStringBuilder = class
  private const
    DefaultCapacity = $10;
  private
    function GetCapacity: Integer;
    procedure SetCapacity(Value: Integer);
    function GetChars(Index: Integer): Char;
    procedure SetChars(Index: Integer; Value: Char);
    function GetLength: Integer; inline;
    procedure SetLength(Value: Integer);
    function GetMaxCapacity: Integer;
    procedure ExpandCapacity;
    procedure ReduceCapacity;
    procedure CheckBounds(Index: Integer);
    function _Replace(Index: Integer; const Old, New: string): Boolean;
  protected
    FData: TCharArray;
    FLength: Integer;
    FMaxCapacity: Integer;
  public
    constructor Create; overload;
    constructor Create(aCapacity: Integer); overload;
    constructor Create(const Value: string); overload;
    constructor Create(aCapacity: Integer; aMaxCapacity: Integer); overload;
    constructor Create(const Value: string; aCapacity: Integer); overload;
    constructor Create(const Value: string; StartIndex: Integer; Length: Integer; aCapacity: Integer); overload;

    function Append(const Value: Boolean): TStringBuilder; overload;
    function Append(const Value: Byte): TStringBuilder; overload;
    function Append(const Value: Char): TStringBuilder; overload;
    function Append(const Value: Currency): TStringBuilder; overload;
    function Append(const Value: Double): TStringBuilder; overload;
    function Append(const Value: Smallint): TStringBuilder; overload;
    function Append(const Value: Integer): TStringBuilder; overload;
    function Append(const Value: Int64): TStringBuilder; overload;
    function Append(const Value: TObject): TStringBuilder; overload;
    function Append(const Value: Shortint): TStringBuilder; overload;
    function Append(const Value: Single): TStringBuilder; overload;
    function Append(const Value: string): TStringBuilder; overload;
    function Append(const Value: UInt64): TStringBuilder; overload;
    function Append(const Value: TCharArray): TStringBuilder; overload;
    function Append(const Value: Word): TStringBuilder; overload;
    function Append(const Value: Cardinal): TStringBuilder; overload;
{$IFNDEF NEXTGEN}
    function Append(const Value: PAnsiChar): TStringBuilder; overload;
    function Append(const Value: RawByteString): TStringBuilder; overload;
{$ENDIF !NEXTGEN}
    function Append(const Value: Char; RepeatCount: Integer): TStringBuilder; overload;
    function Append(const Value: TCharArray; StartIndex: Integer; CharCount: Integer): TStringBuilder; overload;
    function Append(const Value: string; StartIndex: Integer; Count: Integer): TStringBuilder; overload;

    function AppendFormat(const Format: string; const Args: array of const): TStringBuilder; overload;
    function AppendLine: TStringBuilder; overload;
    function AppendLine(const Value: string): TStringBuilder; overload;
    procedure Clear;
    procedure CopyTo(SourceIndex: Integer; const Destination: TCharArray; DestinationIndex: Integer; Count: Integer);
    function EnsureCapacity(aCapacity: Integer): Integer;
    function Equals(StringBuilder: TStringBuilder): Boolean; reintroduce;

    function Insert(Index: Integer; const Value: Boolean): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Byte): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Char): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Currency): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Double): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Smallint): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Integer): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: TCharArray): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Int64): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: TObject): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Shortint): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Single): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: string): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Word): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Cardinal): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: UInt64): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: string; count: Integer): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: TCharArray; startIndex: Integer; charCount: Integer): TStringBuilder; overload;

    function Remove(StartIndex: Integer; RemLength: Integer): TStringBuilder;

    function Replace(const OldChar: Char; const NewChar: Char): TStringBuilder; overload;
    function Replace(const OldValue: string; const NewValue: string): TStringBuilder; overload;
    function Replace(const OldChar: Char; const NewChar: Char; StartIndex: Integer; Count: Integer): TStringBuilder; overload;
    function Replace(const OldValue: string; const NewValue: string; StartIndex: Integer; Count: Integer): TStringBuilder; overload;

    function ToString: string; overload; override;
    function ToString(StartIndex: Integer; StrLength: Integer): string; reintroduce; overload;

    property Capacity: Integer read GetCapacity write SetCapacity;
    property Chars[index: Integer]: Char read GetChars write SetChars; default;
    property Length: Integer read GetLength write SetLength;
    property MaxCapacity: Integer read GetMaxCapacity;
  end;

  TStringSplitOptions = (None, ExcludeEmpty);
  TStringHelper = record helper for string
  private
    function GetChars(Index: Integer): Char; inline;
    function GetLength: Integer; inline;
    class function CharInArray(const C: Char; const InArray: array of Char): Boolean; static;
    function IndexOfAny(const Values: array of string; var Index: Integer): Integer; overload;
    class function InternalCompare(const StrA: string; IndexA: Integer; const StrB: string;
      IndexB, LengthA, LengthB: Integer; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer; static;
  public
    const Empty = '';
    // Methods
    class function Create(C: Char; Count: Integer): string; overload; inline; static;
    class function Create(const Value: array of Char; StartIndex: Integer; Length: Integer): string; overload; static;
    class function Create(const Value: array of Char): string; overload; static;
    class function Compare(const StrA: string; const StrB: string): Integer; overload; static; inline;
    class function Compare(const StrA: string; const StrB: string; LocaleID: TLocaleID): Integer; overload; static; inline;
    class function Compare(const StrA: string; const StrB: string; IgnoreCase: Boolean): Integer; overload; static; inline;
    class function Compare(const StrA: string; const StrB: string; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer; overload; static; inline;
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer): Integer; overload; static; inline;
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; LocaleID: TLocaleID): Integer; overload; static; inline;
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean): Integer; overload; static; inline;
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer; overload; static; inline;
    class function CompareOrdinal(const StrA: string; const StrB: string): Integer; overload; static;
    class function CompareOrdinal(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer): Integer; overload; static;
    class function CompareText(const StrA: string; const StrB: string): Integer; static; inline;
    class function Parse(const Value: Integer): string; overload; static; inline;
    class function Parse(const Value: Int64): string; overload; static; inline;
    class function Parse(const Value: Boolean): string; overload; static; inline;
    class function Parse(const Value: Extended): string; overload; static;inline;
    class function ToBoolean(const S: string): Boolean; overload; static; inline;
    class function ToInteger(const S: string): Integer; overload; static; inline;
    class function ToSingle(const S: string): Single; overload; static; inline;
    class function ToDouble(const S: string): Double; overload; static; inline;
    class function ToExtended(const S: string): Extended; overload; static; inline;
    class function LowerCase(const S: string): string; overload; static; inline;
    class function LowerCase(const S: string; LocaleOptions: TLocaleOptions): string; overload; static; inline;
    class function UpperCase(const S: string): string; overload; static; inline;
    class function UpperCase(const S: string; LocaleOptions: TLocaleOptions): string; overload; static; inline;
    function CompareTo(const strB: string): Integer;
    function Contains(const Value: string): Boolean;
    class function Copy(const Str: string): string; inline; static;
    procedure CopyTo(SourceIndex: Integer; var destination: array of Char; DestinationIndex: Integer; Count: Integer);
    function CountChar(const C: Char): Integer;
    function DeQuotedString: string; overload;
    function DeQuotedString(const QuoteChar: Char): string; overload;
    class function EndsText(const ASubText, AText: string): Boolean; static;
    function EndsWith(const Value: string): Boolean; overload;
    function EndsWith(const Value: string; IgnoreCase: Boolean): Boolean; overload;
    function Equals(const Value: string): Boolean; overload;
    class function Equals(const a: string; const b: string): Boolean; overload; static;
    class function Format(const Format: string; const args: array of const): string; overload; static;
    function GetHashCode: Integer;
    function IndexOf(value: Char): Integer; overload; inline;
    function IndexOf(const Value: string): Integer; overload; inline;
    function IndexOf(Value: Char; StartIndex: Integer): Integer; overload;
    function IndexOf(const Value: string; StartIndex: Integer): Integer; overload;
    function IndexOf(Value: Char; StartIndex: Integer; Count: Integer): Integer; overload;
    function IndexOf(const Value: string; StartIndex: Integer; Count: Integer): Integer; overload;
    function IndexOfAny(const AnyOf: array of Char): Integer; overload;
    function IndexOfAny(const AnyOf: array of Char; StartIndex: Integer): Integer; overload;
    function IndexOfAny(const AnyOf: array of Char; StartIndex: Integer; Count: Integer): Integer; overload;
    function Insert(StartIndex: Integer; const Value: string): string;
    function IsDelimiter(const Delimiters: string; Index: Integer): Boolean;
    function IsEmpty: Boolean;
    class function IsNullOrEmpty(const Value: string): Boolean; static;
    class function IsNullOrWhiteSpace(const Value: string): Boolean; static;
    class function Join(const Separator: string; const values: array of const): string; overload; static;
    class function Join(const Separator: string; const Values: array of string): string; overload; static;
    class function Join(const Separator: string; const Values: IEnumerator<string>): string; overload; static;
    class function Join(const Separator: string; const Values: IEnumerable<string>): string; overload; static;
    class function Join(const Separator: string; const value: array of string; StartIndex: Integer; Count: Integer): string; overload; static;
    function LastDelimiter(const Delims: string): Integer;
    function LastIndexOf(Value: Char): Integer; overload;
    function LastIndexOf(const Value: string): Integer; overload;
    function LastIndexOf(Value: Char; StartIndex: Integer): Integer; overload;
    function LastIndexOf(const Value: string; StartIndex: Integer): Integer; overload;
    function LastIndexOf(Value: Char; StartIndex: Integer; Count: Integer): Integer; overload;
    function LastIndexOf(const Value: string; StartIndex: Integer; Count: Integer): Integer; overload;
    function LastIndexOfAny(const AnyOf: array of Char): Integer; overload;
    function LastIndexOfAny(const AnyOf: array of Char; StartIndex: Integer): Integer; overload;
    function LastIndexOfAny(const AnyOf: array of Char; StartIndex: Integer; Count: Integer): Integer; overload;
    function PadLeft(TotalWidth: Integer): string; overload; inline;
    function PadLeft(TotalWidth: Integer; PaddingChar: Char): string; overload; inline;
    function PadRight(TotalWidth: Integer): string; overload; inline;
    function PadRight(TotalWidth: Integer; PaddingChar: Char): string; overload; inline;
    function QuotedString: string; overload;
    function QuotedString(const QuoteChar: Char): string; overload;
    function Remove(StartIndex: Integer): string; overload; inline;
    function Remove(StartIndex: Integer; Count: Integer): string; overload; inline;
    function Replace(OldChar: Char; NewChar: Char): string; overload;
    function Replace(OldChar: Char; NewChar: Char; ReplaceFlags: TReplaceFlags): string; overload;
    function Replace(const OldValue: string; const NewValue: string): string; overload;
    function Replace(const OldValue: string; const NewValue: string; ReplaceFlags: TReplaceFlags): string; overload;
    function Split(const Separator: array of Char): TArray<string>; overload;
    function Split(const Separator: array of Char; Count: Integer): TArray<string>; overload;
    function Split(const Separator: array of Char; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of string; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of string; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
    function StartsWith(const Value: string): Boolean; overload;
    function StartsWith(const Value: string; IgnoreCase: Boolean): Boolean; overload;
    function Substring(StartIndex: Integer): string; overload;
    function Substring(StartIndex: Integer; Length: Integer): string; overload;
    function ToBoolean: Boolean; overload; inline;
    function ToInteger: Integer; overload; inline;
    function ToSingle: Single; overload; inline;
    function ToDouble: Double; overload; inline;
    function ToExtended: Extended; overload; inline;
    function ToCharArray: TArray<Char>; overload;
    function ToCharArray(StartIndex: Integer; Length: Integer): TArray<Char>; overload;
    function ToLower: string; overload; inline;
    function ToLower(LocaleID: TLocaleID): string; overload;
    function ToLowerInvariant: string;
    function ToUpper: string; overload; inline;
    function ToUpper(LocaleID: TLocaleID): string; overload;
    function ToUpperInvariant: string;
    function Trim: string; overload;
    function TrimLeft: string; overload;
    function TrimRight: string; overload;
    function Trim(const TrimChars: array of Char): string; overload;
    function TrimLeft(const TrimChars: array of Char): string; overload;
    function TrimRight(const TrimChars: array of Char): string; overload;
    function TrimEnd(const TrimChars: array of Char): string; deprecated 'Use TrimRight';
    function TrimStart(const TrimChars: array of Char): string; deprecated 'Use TrimLeft';
    property Chars[Index: Integer]: Char read GetChars;
    property Length: Integer read GetLength;
  end;

  TSingleHelper = record helper for Single
  private
    function InternalGetBytes(Index: Cardinal): UInt8; inline;
    function InternalGetWords(Index: Cardinal): UInt16; inline;
    procedure InternalSetBytes(Index: Cardinal; const Value: UInt8); inline;
    procedure InternalSetWords(Index: Cardinal; const Value: UInt16); inline;
    function GetBytes(Index: Cardinal): UInt8;
    function GetWords(Index: Cardinal): UInt16;
    function GetExp: UInt64; inline;
    function GetFrac: UInt64; inline;
    function GetSign: Boolean; inline;
    procedure SetBytes(Index: Cardinal; const Value: UInt8);
    procedure SetWords(Index: Cardinal; const Value: UInt16);
    procedure SetExp(NewExp: UInt64);
    procedure SetFrac(NewFrac: UInt64);
    procedure SetSign(NewSign: Boolean);
  public
    const
      Epsilon:Single = 1.4012984643248170709e-45;
      MaxValue:Single =  340282346638528859811704183484516925440.0;
      MinValue:Single = -340282346638528859811704183484516925440.0;
      PositiveInfinity:Single =  1.0 / 0.0;
      NegativeInfinity:Single = -1.0 / 0.0;
      NaN:Single = 0.0 / 0.0;

    class function ToString(const Value: Single): string; overload; inline; static;
    class function ToString(const Value: Single; const AFormatSettings: TFormatSettings): string; overload; inline; static;
    class function ToString(const Value: Single; const Format: TFloatFormat; const Precision, Digits: Integer): string; overload; inline; static;
    class function ToString(const Value: Single; const Format: TFloatFormat; const Precision, Digits: Integer;
                               const AFormatSettings: TFormatSettings): string; overload; inline; static;
    class function Parse(const S: string): Single; overload; inline; static;
    class function Parse(const S: string; const AFormatSettings: TFormatSettings): Single; overload; inline; static;
    class function TryParse(const S: string; out Value: Single): Boolean; overload; inline; static;
    class function TryParse(const S: string; out Value: Single; const AFormatSettings: TFormatSettings): Boolean; overload; inline; static;
    class function IsNan(const Value: Single): Boolean; overload; inline; static;
    class function IsInfinity(const Value: Single): Boolean; overload; inline; static;
    class function IsNegativeInfinity(const Value: Single): Boolean; overload; inline; static;
    class function IsPositiveInfinity(const Value: Single): Boolean; overload; inline; static;
    class function Size: Integer; inline; static;

    function Exponent: Integer;
    function Fraction: Extended;
    function Mantissa: UInt64;

    property Sign: Boolean read GetSign write SetSign;
    property Exp: UInt64 read GetExp write SetExp;
    property Frac: UInt64 read GetFrac write SetFrac;

    function SpecialType: TFloatSpecial;
    procedure BuildUp(const SignFlag: Boolean; const Mantissa: UInt64; const Exponent: Integer);
    function ToString: string; overload; inline;
    function ToString(const AFormatSettings: TFormatSettings): string; overload; inline;
    function ToString(const Format: TFloatFormat; const Precision, Digits: Integer): string; overload; inline;
    function ToString(const Format: TFloatFormat; const Precision, Digits: Integer;
                         const AFormatSettings: TFormatSettings): string; overload; inline;
    function IsNan: Boolean; overload; inline;
    function IsInfinity: Boolean; overload; inline;
    function IsNegativeInfinity: Boolean; overload; inline;
    function IsPositiveInfinity: Boolean; overload; inline;

    property Bytes[Index: Cardinal]: UInt8 read GetBytes write SetBytes;  // 0..3
    property Words[Index: Cardinal]: UInt16 read GetWords write SetWords; // 0..1
  end;

  TDoubleHelper = record helper for Double
  private
    function InternalGetBytes(Index: Cardinal): UInt8; inline;
    function InternalGetWords(Index: Cardinal): UInt16; inline;
    procedure InternalSetBytes(Index: Cardinal; const Value: UInt8); inline;
    procedure InternalSetWords(Index: Cardinal; const Value: UInt16); inline;
    function GetBytes(Index: Cardinal): UInt8;
    function GetWords(Index: Cardinal): UInt16;
    function GetExp: UInt64; inline;
    function GetFrac: UInt64; inline;
    function GetSign: Boolean; inline;
    procedure SetBytes(Index: Cardinal; const Value: UInt8);
    procedure SetWords(Index: Cardinal; const Value: UInt16);
    procedure SetExp(NewExp: UInt64);
    procedure SetFrac(NewFrac: UInt64);
    procedure SetSign(NewSign: Boolean);
  public
    const
      Epsilon:Double = 4.9406564584124654418e-324;
      MaxValue:Double =  1.7976931348623157081e+308;
      MinValue:Double = -1.7976931348623157081e+308;
      PositiveInfinity:Double =  1.0 / 0.0;
      NegativeInfinity:Double = -1.0 / 0.0;
      NaN:Double = 0.0 / 0.0;

    class function ToString(const Value: Double): string; overload; inline; static;
    class function ToString(const Value: Double; const AFormatSettings: TFormatSettings): string; overload; inline; static;
    class function ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer): string; overload; inline; static;
    class function ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer;
                               const AFormatSettings: TFormatSettings): string; overload; inline; static;
    class function Parse(const S: string): Double; overload; inline; static;
    class function Parse(const S: string; const AFormatSettings: TFormatSettings): Double; overload; inline; static;
    class function TryParse(const S: string; out Value: Double): Boolean; overload; inline; static;
    class function TryParse(const S: string; out Value: Double; const AFormatSettings: TFormatSettings): Boolean; overload; inline; static;
    class function IsNan(const Value: Double): Boolean; overload; inline; static;
    class function IsInfinity(const Value: Double): Boolean; overload; inline; static;
    class function IsNegativeInfinity(const Value: Double): Boolean; overload; inline; static;
    class function IsPositiveInfinity(const Value: Double): Boolean; overload; inline; static;
    class function Size: Integer; inline; static;

    function Exponent: Integer;
    function Fraction: Extended;
    function Mantissa: UInt64;

    property Sign: Boolean read GetSign write SetSign;
    property Exp: UInt64 read GetExp write SetExp;
    property Frac: UInt64 read GetFrac write SetFrac;

    function SpecialType: TFloatSpecial;
    procedure BuildUp(const SignFlag: Boolean; const Mantissa: UInt64; const Exponent: Integer);
    function ToString: string; overload; inline;
    function ToString(const AFormatSettings: TFormatSettings): string; overload; inline;
    function ToString(const Format: TFloatFormat; const Precision, Digits: Integer): string; overload; inline;
    function ToString(const Format: TFloatFormat; const Precision, Digits: Integer;
                         const AFormatSettings: TFormatSettings): string; overload; inline;
    function IsNan: Boolean; overload; inline;
    function IsInfinity: Boolean; overload; inline;
    function IsNegativeInfinity: Boolean; overload; inline;
    function IsPositiveInfinity: Boolean; overload; inline;

    property Bytes[Index: Cardinal]: UInt8 read GetBytes write SetBytes;  // 0..7
    property Words[Index: Cardinal]: UInt16 read GetWords write SetWords; // 0..3
  end;

  TExtendedHelper = record helper for Extended
  private
    function InternalGetBytes(Index: Cardinal): UInt8; inline;
    function InternalGetWords(Index: Cardinal): UInt16; inline;
    procedure InternalSetBytes(Index: Cardinal; const Value: UInt8); inline;
    procedure InternalSetWords(Index: Cardinal; const Value: UInt16); inline;
    function GetBytes(Index: Cardinal): UInt8;
    function GetWords(Index: Cardinal): UInt16;
    function GetExp: UInt64; inline;
    function GetFrac: UInt64; inline;
    function GetSign: Boolean; inline;
    procedure SetBytes(Index: Cardinal; const Value: UInt8);
    procedure SetWords(Index: Cardinal; const Value: UInt16);
    procedure SetExp(NewExp: UInt64);
    procedure SetFrac(NewFrac: UInt64);
    procedure SetSign(NewSign: Boolean);
  public
    const
      Epsilon:Extended = {$IFDEF EXTENDEDIS10BYTES} 3.64519953188247460253e-4951 {$ELSE} 4.9406564584124654418e-324 {$ENDIF};
      MaxValue:Extended =  {$IFDEF EXTENDEDIS10BYTES} 1.18973149535723176505e+4932 {$ELSE} 1.7976931348623157081e+308 {$ENDIF};
      MinValue:Extended = -{$IFDEF EXTENDEDIS10BYTES} 1.18973149535723176505e+4932 {$ELSE} 1.7976931348623157081e+308 {$ENDIF};
      PositiveInfinity:Extended =  1.0 / 0.0;
      NegativeInfinity:Extended = -1.0 / 0.0;
      NaN:Extended = 0.0 / 0.0;

    class function ToString(const Value: Extended): string; overload; inline; static;
    class function ToString(const Value: Extended; const AFormatSettings: TFormatSettings): string; overload; inline; static;
    class function ToString(const Value: Extended; const Format: TFloatFormat; const Precision, Digits: Integer): string; overload; inline; static;
    class function ToString(const Value: Extended; const Format: TFloatFormat; const Precision, Digits: Integer;
                               const AFormatSettings: TFormatSettings): string; overload; inline; static;
    class function Parse(const S: string): Extended; overload; inline; static;
    class function Parse(const S: string; const AFormatSettings: TFormatSettings): Extended; overload; inline; static;
    class function TryParse(const S: string; out Value: Extended): Boolean; overload; inline; static;
    class function TryParse(const S: string; out Value: Extended; const AFormatSettings: TFormatSettings): Boolean; overload; inline; static;
    class function IsNan(const Value: Extended): Boolean; overload; inline; static;
    class function IsInfinity(const Value: Extended): Boolean; overload; inline; static;
    class function IsNegativeInfinity(const Value: Extended): Boolean; overload; inline; static;
    class function IsPositiveInfinity(const Value: Extended): Boolean; overload; inline; static;
    class function Size: Integer; inline; static;

    function Exponent: Integer;
    function Fraction: Extended;
    function Mantissa: UInt64;

    property Sign: Boolean read GetSign write SetSign;
    property Exp: UInt64 read GetExp write SetExp;
    property Frac: UInt64 read GetFrac write SetFrac;

    function SpecialType: TFloatSpecial;
    procedure BuildUp(const SignFlag: Boolean; const Mantissa: UInt64; const Exponent: Integer);
    function ToString: string; overload; inline;
    function ToString(const AFormatSettings: TFormatSettings): string; overload; inline;
    function ToString(const Format: TFloatFormat; const Precision, Digits: Integer): string; overload; inline;
    function ToString(const Format: TFloatFormat; const Precision, Digits: Integer;
                         const AFormatSettings: TFormatSettings): string; overload; inline;
    function IsNan: Boolean; overload; inline;
    function IsInfinity: Boolean; overload; inline;
    function IsNegativeInfinity: Boolean; overload; inline;
    function IsPositiveInfinity: Boolean; overload; inline;

    property Bytes[Index: Cardinal]: UInt8 read GetBytes write SetBytes;  // 0..7 or 0..9
    property Words[Index: Cardinal]: UInt16 read GetWords write SetWords; // 0..3 or 0..4
  end;

  TByteHelper = record helper for Byte
  public
    const
      MaxValue = 255;
      MinValue = 0;

    class function Size: Integer; inline; static;
    class function ToString(const Value: Byte): string; overload; inline; static;
    class function ToHexString(const Value: Byte): string; overload; inline; static;
    class function ToHexString(const Value: Byte; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): Byte; inline; static;
    class function TryParse(const S: string; out Value: Byte): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TShortIntHelper = record helper for ShortInt
  public
    const
      MaxValue = 127;
      MinValue = -128;

    class function Size: Integer; inline; static;
    class function ToString(const Value: ShortInt): string; overload; inline; static;
    class function ToHexString(const Value: ShortInt): string; overload; inline; static;
    class function ToHexString(const Value: ShortInt; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): ShortInt; inline; static;
    class function TryParse(const S: string; out Value: ShortInt): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TSmallIntHelper = record helper for SmallInt
  public
    const
      MaxValue = 32767;
      MinValue = -32768;

    class function Size: Integer; inline; static;
    class function ToString(const Value: SmallInt): string; overload; inline; static;
    class function ToHexString(const Value: SmallInt): string; overload; inline; static;
    class function ToHexString(const Value: SmallInt; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): SmallInt; inline; static;
    class function TryParse(const S: string; out Value: SmallInt): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TWordHelper = record helper for Word
  public
    const
      MaxValue = 65535;
      MinValue = 0;

    class function Size: Integer; inline; static;
    class function ToString(const Value: Word): string; overload; inline; static;
    class function ToHexString(const Value: Word): string; overload; inline; static;
    class function ToHexString(const Value: Word; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): Word; inline; static;
    class function TryParse(const S: string; out Value: Word): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TCardinalHelper = record helper for Cardinal { for LongWord type too }
  public
    const
      MaxValue = 4294967295;
      MinValue = 0;

    class function Size: Integer; inline; static;
    class function ToString(const Value: Cardinal): string; overload; inline; static;
    class function ToHexString(const Value: Cardinal): string; overload; inline; static;
    class function ToHexString(const Value: Cardinal; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): Cardinal; inline; static;
    class function TryParse(const S: string; out Value: Cardinal): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TIntegerHelper = record helper for Integer { for LongInt type too }
  public
    const
      MaxValue = 2147483647;
      MinValue = -2147483648;

    class function Size: Integer; inline; static;
    class function ToString(const Value: Integer): string; overload; inline; static;
    class function ToHexString(const Value: Integer): string; overload; inline; static;
    class function ToHexString(const Value: Integer; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): Integer; inline; static;
    class function TryParse(const S: string; out Value: Integer): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Word): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TInt64Helper = record helper for Int64
  public
    const
      MaxValue = 9223372036854775807;
      MinValue = -9223372036854775808;

    class function Size: Integer; inline; static;
    class function ToString(const Value: Int64): string; overload; inline; static;
    class function ToHexString(const Value: Int64): string; overload; inline; static;
    class function ToHexString(const Value: Int64; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): Int64; inline; static;
    class function TryParse(const S: string; out Value: Int64): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TUInt64Helper = record helper for UInt64
  public
    const
      MaxValue = 18446744073709551615;
      MinValue = 0;

    class function Size: Integer; inline; static;
    class function ToString(const Value: UInt64): string; overload; inline; static;
    class function ToHexString(const Value: UInt64): string; overload; inline; static;
    class function ToHexString(const Value: UInt64; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): UInt64; inline; static;
    class function TryParse(const S: string; out Value: UInt64): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TNativeIntHelper = record helper for NativeInt
  public
    const
{$IFDEF CPUX64}
      MaxValue = 9223372036854775807;
      MinValue = -9223372036854775808;
{$ELSE !CPUX64}
      MaxValue = 2147483647;
      MinValue = -2147483648;
{$ENDIF CPUX64}

    class function Size: Integer; inline; static;
    class function ToString(const Value: NativeInt): string; overload; inline; static;
    class function ToHexString(const Value: NativeInt): string; overload; inline; static;
    class function ToHexString(const Value: NativeInt; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): NativeInt; inline; static;
    class function TryParse(const S: string; out Value: NativeInt): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TNativeUIntHelper = record helper for NativeUInt
  public
    const
{$IFDEF CPUX64}
      MaxValue = 18446744073709551615;
{$ELSE !CPUX64}
      MaxValue = 4294967295;
{$ENDIF CPUX64}
      MinValue = 0;

    class function Size: Integer; inline; static;
    class function ToString(const Value: NativeUInt): string; overload; inline; static;
    class function ToHexString(const Value: NativeUInt): string; overload; inline; static;
    class function ToHexString(const Value: NativeUInt; const MinDigits: Integer): string; overload; inline; static;
    class function Parse(const S: string): NativeUInt; inline; static;
    class function TryParse(const S: string; out Value: NativeUInt): Boolean; inline; static;

    function ToString: string; overload; inline;
    function ToBoolean: Boolean; inline;
    function ToHexString: string; overload; inline;
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    function ToSingle: Single; inline;
    function ToDouble: Double; inline;
    function ToExtended: Extended; inline;
  end;

  TBooleanHelper = record helper for Boolean
  public
    class function Size: Integer; inline; static;
    class function ToString(const Value: Boolean): string; overload; inline; static;
    class function Parse(const S: string): Boolean; inline; static;
    class function TryToParse(const S: string; out Value: Boolean): Boolean; inline; static;

    function ToInteger: Integer; inline;
    function ToString: string; overload; inline;
  end;

  TByteBoolHelper = record helper for ByteBool
  public
    class function Size: Integer; inline; static;
    class function ToString(const Value: Boolean): string; overload; inline; static;
    class function Parse(const S: string): Boolean; inline; static;
    class function TryToParse(const S: string; out Value: Boolean): Boolean; inline; static;

    function ToInteger: Integer; inline;
    function ToString: string; overload; inline;
  end;

  TWordBoolHelper = record helper for WordBool
  public
    class function Size: Integer; inline; static;
    class function ToString(const Value: Boolean): string; overload; inline; static;
    class function Parse(const S: string): Boolean; inline; static;
    class function TryToParse(const S: string; out Value: Boolean): Boolean; inline; static;

    function ToInteger: Integer; inline;
    function ToString: string; overload; inline;
  end;

  TLongBoolHelper = record helper for LongBool
  public
    class function Size: Integer; inline; static;
    class function ToString(const Value: Boolean): string; overload; inline; static;
    class function Parse(const S: string): Boolean; inline; static;
    class function TryToParse(const S: string; out Value: Boolean): Boolean; inline; static;

    function ToInteger: Integer; inline;
    function ToString: string; overload; inline;
  end;

  EEncodingError = class(Exception);

{$IFDEF POSIX}
const
  CP_UTF7 = 65000;
  CP_UTF8 = 65001;
  MB_ERR_INVALID_CHARS = 8;
{$ENDIF}

type
  TEncoding = class
  strict private
    class var
      FANSIEncoding: TEncoding;
      FASCIIEncoding: TEncoding;
      FBigEndianUnicodeEncoding: TEncoding;
      FUnicodeEncoding: TEncoding;
      FUTF7Encoding: TEncoding;
      FUTF8Encoding: TEncoding;
    class destructor Destroy;
    class function GetANSI: TEncoding; static;
    class function GetASCII: TEncoding; static;
    class function GetBigEndianUnicode: TEncoding; static;
    class function GetDefault: TEncoding; static; inline;
    class function GetUnicode: TEncoding; static;
    class function GetUTF7: TEncoding; static;
    class function GetUTF8: TEncoding; static;
  strict protected
    FIsSingleByte: Boolean;
    FMaxCharSize: Integer;
    function GetByteCount(Chars: PChar; CharCount: Integer): Integer; overload; virtual; abstract;
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; virtual; abstract;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; virtual; abstract;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; virtual; abstract;
    function GetCodePage: Cardinal; virtual;
    function GetEncodingName: string; virtual;
  public
    function Clone: TEncoding; virtual;
    class function Convert(const Source, Destination: TEncoding; const Bytes: array of Byte): TBytes; overload;
    class function Convert(const Source, Destination: TEncoding; const Bytes: TBytes): TBytes; overload;
    class function Convert(const Source, Destination: TEncoding; const Bytes: array of Byte; StartIndex, Count: Integer): TBytes; overload;
    class function Convert(const Source, Destination: TEncoding; const Bytes: TBytes; StartIndex, Count: Integer): TBytes; overload;
    class procedure FreeEncodings;
    class function IsStandardEncoding(AEncoding: TEncoding): Boolean; static;
    class function GetBufferEncoding(const Buffer: TBytes; var AEncoding: TEncoding): Integer; overload; static;
    class function GetBufferEncoding(const Buffer: TBytes; var AEncoding: TEncoding;
      ADefaultEncoding: TEncoding): Integer; overload; static;
    function GetByteCount(const Chars: Char): Integer; overload; inline;
    function GetByteCount(const Chars: array of Char): Integer; overload;
    function GetByteCount(const Chars: TCharArray): Integer; overload;
    function GetByteCount(const Chars: array of Char; CharIndex, CharCount: Integer): Integer; overload;
    function GetByteCount(const Chars: TCharArray; CharIndex, CharCount: Integer): Integer; overload;
    function GetByteCount(const S: string): Integer; overload;
    function GetByteCount(const S: string; CharIndex, CharCount: Integer): Integer; overload;
    function GetBytes(const Chars: Char): TBytes; overload; inline;
    function GetBytes(const Chars: array of Char): TBytes; overload;
    function GetBytes(const Chars: TCharArray): TBytes; overload;
    function GetBytes(const Chars: array of Char; CharIndex, CharCount: Integer): TBytes; overload;
    function GetBytes(const Chars: TCharArray; CharIndex, CharCount: Integer): TBytes; overload;
    function GetBytes(const Chars: array of Char; CharIndex, CharCount: Integer;
      const Bytes: TBytes; ByteIndex: Integer): Integer; overload;
    function GetBytes(const Chars: TCharArray; CharIndex, CharCount: Integer;
      const Bytes: TBytes; ByteIndex: Integer): Integer; overload;
    function GetBytes(const S: string): TBytes; overload;
    function GetBytes(const S: string; CharIndex, CharCount: Integer;
      const Bytes: TBytes; ByteIndex: Integer): Integer; overload;
    function GetCharCount(const Bytes: array of Byte): Integer; overload;
    function GetCharCount(const Bytes: TBytes): Integer; overload; inline;
    function GetCharCount(const Bytes: array of Byte; ByteIndex, ByteCount: Integer): Integer; overload;
    function GetCharCount(const Bytes: TBytes; ByteIndex, ByteCount: Integer): Integer; overload;
    function GetChars(const Bytes: array of Byte): TCharArray; overload;
    function GetChars(const Bytes: TBytes): TCharArray; overload; inline;
    function GetChars(const Bytes: array of Byte; ByteIndex, ByteCount: Integer): TCharArray; overload;
    function GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer): TCharArray; overload;
    function GetChars(const Bytes: array of Byte; ByteIndex, ByteCount: Integer;
      const Chars: array of Char; CharIndex: Integer): Integer; overload;
    function GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer;
      const Chars: TCharArray; CharIndex: Integer): Integer; overload;
    class function GetEncoding(CodePage: Integer): TEncoding; overload; static;
    class function GetEncoding(const EncodingName: string): TEncoding; overload; static;
    function GetMaxByteCount(CharCount: Integer): Integer; virtual; abstract;
    function GetMaxCharCount(ByteCount: Integer): Integer; virtual; abstract;
    function GetPreamble: TBytes; virtual; abstract;
    function GetString(const Bytes: TBytes): string; overload; inline;
    function GetString(const Bytes: TBytes; ByteIndex, ByteCount: Integer): string; overload;
    class property ANSI: TEncoding read GetANSI;
    class property ASCII: TEncoding read GetASCII;
    class property BigEndianUnicode: TEncoding read GetBigEndianUnicode;
    property CodePage: Cardinal read GetCodePage;
    class property Default: TEncoding read GetDefault;
    property EncodingName: string read GetEncodingName;
    property IsSingleByte: Boolean read FIsSingleByte;
    class property Unicode: TEncoding read GetUnicode;
    class property UTF7: TEncoding read GetUTF7;
    class property UTF8: TEncoding read GetUTF8;
  end;

  TMBCSEncoding = class(TEncoding)
  private
    FCodePage: Cardinal;
    FMBToWCharFlags: Cardinal;
    FWCharToMBFlags: Cardinal;
  strict protected
    function GetByteCount(Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetCodePage: Cardinal; override;
    function GetEncodingName: string; override;
  public
    constructor Create; overload; virtual;
    constructor Create(CodePage: Integer); overload; virtual;
    constructor Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer); overload; virtual;
    function Clone: TEncoding; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TBytes; override;
  end;

  TUTF7Encoding = class(TMBCSEncoding)
  public
    constructor Create; override;
    function Clone: TEncoding; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
  end;

  TUTF8Encoding = class(TUTF7Encoding)
  public
    constructor Create; override;
    function Clone: TEncoding; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TBytes; override;
  end;

  TUnicodeEncoding = class(TEncoding)
  strict protected
    function GetByteCount(Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetCodePage: Cardinal; override;
    function GetEncodingName: string; override;
  public
    constructor Create; virtual;
    function Clone: TEncoding; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TBytes; override;
  end;

  TBigEndianUnicodeEncoding = class(TUnicodeEncoding)
  strict protected
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetCodePage: Cardinal; override;
    function GetEncodingName: string; override;
  public
    function Clone: TEncoding; override;
    function GetPreamble: TBytes; override;
  end;

{$IFDEF POSIX}
  TCharSetEncoding = class(TEncoding)
  private
    FCodePage: Cardinal;
    FEncodingName: string;
{$IFDEF MACOS}
    FCFEncoding: CFStringEncoding;
{$ENDIF MACOS}
  strict protected
    function GetByteCount(Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetCodePage: Cardinal; override;
    function GetEncodingName: string; override;
  public
    constructor Create(const EncodingName: string); overload; virtual;
    function Clone: TEncoding; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TBytes; override;
  end;
{$ENDIF POSIX}

// TBytes/string conversion routines
{$IFNDEF NEXTGEN}
function BytesOf(const Val: RawByteString): TBytes; overload;
function BytesOf(const Val: WideChar): TBytes; overload;
function BytesOf(const Val: AnsiChar): TBytes; overload;
{$ENDIF !NEXTGEN}
function BytesOf(const Val: UnicodeString): TBytes; overload;
function StringOf(const Bytes: TBytes): UnicodeString;
function PlatformBytesOf(const Value: string): TBytes;
function PlatformStringOf(const Value: TBytes): UnicodeString;
function WideStringOf(const Value: TBytes): UnicodeString;
function WideBytesOf(const Value: UnicodeString): TBytes;

function BytesOf(const Val: Pointer; const Len: integer): TBytes; overload;

type
  // High-level aid for marshalling arguments to and from OS / native API invocation.
  // Auto-destruction to ease use.
  TMarshaller = record
  private type
    PDisposeRec = ^TDisposeRec;
    TDisposeProc = procedure(Args: PDisposeRec);
    TDisposeRec = record
      Proc: TDisposeProc;
      Obj: TObject;
      Arg1: NativeInt;
      Arg2: NativeInt;
    end;
    IDisposer = interface
      procedure AddDispose(Rec: TDisposeRec);
      procedure RemoveDispose(Rec: TDisposeRec);
      procedure Flush;
    end;
    TDisposer = class(TInterfacedObject, IDisposer)
    private
      // Use inline storage to avoid more allocation and indirection for few items.
      FInline: array[0..3] of TDisposeRec;
      FOverflow: TArray<TDisposeRec>;
      FCount: Integer;
      procedure AddDispose(Rec: TDisposeRec);
      procedure RemoveDispose(Rec: TDisposeRec);
      procedure Flush;
    public
      destructor Destroy; override;
    end;
  private
    FDisposer: IDisposer;
    procedure AddDispose(Rec: TDisposeRec);
    class procedure DoUnfixArray<T>(Rec: PDisposeRec); static;
    class function MakeUnfixArray<T>(Ptr: TPtrWrapper): TDisposeRec; static;
  public
    function InString(SB: TStringBuilder; MaxLen: Integer): TPtrWrapper;
    function OutString(const S: string): TPtrWrapper;
    function InOutString(SB: TStringBuilder; MaxLen: Integer): TPtrWrapper;
    function AsAnsi(const S: string): TPtrWrapper; overload;
    function AsAnsi(S: PWideChar): TPtrWrapper; overload;
    function AsAnsi(const S: string; CodePage: Word): TPtrWrapper; overload;
    function AsAnsi(S: PWideChar; CodePage: Word): TPtrWrapper; overload;
    function AsUtf8(const S: string): TPtrWrapper; overload;
    function AsUtf8(S: PWideChar): TPtrWrapper; overload;

    // Complete all pending operations. This:
    // * un-fixes any fixed arrays or strings
    // * copies back any out or in/out paramaters
    // * frees any memory allocated for copied data
    // When the marshaller record goes out of scope, Flush is called automatically.
    procedure Flush;

    // Memory allocation
    function AllocMem(Size: NativeInt): TPtrWrapper;
    function ReallocMem(OldPtr: TPtrWrapper; NewSize: NativeInt): TPtrWrapper;

    // Direct referencing of array data
    function FixArray<T>(Arr: TArray<T>): TPtrWrapper;

    // Direct referencing of Unicode string data
    function FixString(var Str: string): TPtrWrapper;
    function UnsafeFixString(const Str: string): TPtrWrapper;

    // Copy string to newly allocated buffer (needs to be freed with .FreeMem)
    function AllocStringAsAnsi(const Str: string): TPtrWrapper; overload;
    function AllocStringAsAnsi(const Str: string; CodePage: Word): TPtrWrapper; overload;
    function AllocStringAsUtf8(const Str: string): TPtrWrapper; overload;
    function AllocStringAsUnicode(const Str: string): TPtrWrapper;
  end;
  {$NODEFINE TMarshaller}

// Generic Anonymous method declarations
type
  TProc = reference to procedure;
  TProc<T> = reference to procedure (Arg1: T);
  TProc<T1,T2> = reference to procedure (Arg1: T1; Arg2: T2);
  TProc<T1,T2,T3> = reference to procedure (Arg1: T1; Arg2: T2; Arg3: T3);
  TProc<T1,T2,T3,T4> = reference to procedure (Arg1: T1; Arg2: T2; Arg3: T3; Arg4: T4);

  TFunc<TResult> = reference to function: TResult;
  TFunc<T,TResult> = reference to function (Arg1: T): TResult;
  TFunc<T1,T2,TResult> = reference to function (Arg1: T1; Arg2: T2): TResult;
  TFunc<T1,T2,T3,TResult> = reference to function (Arg1: T1; Arg2: T2; Arg3: T3): TResult;
  TFunc<T1,T2,T3,T4,TResult> = reference to function (Arg1: T1; Arg2: T2; Arg3: T3; Arg4: T4): TResult;

  TPredicate<T> = reference to function (Arg1: T): Boolean;

{$IFDEF MSWINDOWS}
{ GetDefaultFallbackLanguages retrieves the current DefaultFallbackLanguages string. }
function GetDefaultFallbackLanguages: string;

{ SetDefaultFallbackLanguages set new default fallback languages. }
procedure SetDefaultFallbackLanguages(const Languages: string);

{ PreferredUILanguages retrieves the preferred UI languages for the user's
  default UI langauges at runtime. This function uses System.GetUILanguages
  with GetUserDefaultUILanguage Windows API and DefaultFallbackLanguages setting. }
function PreferredUILanguages: string;

type
  ILanguageEnumerator = interface
    function MoveNext: Boolean;
    function GetCurrent: string;
    property Current: string read GetCurrent;
  end;

  ILanguageEnumerable = interface
    function GetEnumerator: ILanguageEnumerator;
  end;

{ PreferredUILanguageList retrieves a ILanguageEnumerable interface
  to use for-in loop statement. For example:

    for Language in PreferredUILanguageList do  }
function PreferredUILanguageList: ILanguageEnumerable;

{ LocaleFileExists returns a boolean value that indicates whether the specified
  file existes with preferred UI language subdirectories.  }
function LocaleFileExists(const FileName: string): Boolean;

{ GetLocaleFile returns a string value that indicate a file path whether
  the specified file exists with preferred UI language subdirectories.  }
function GetLocaleFile(const FileName: string): string;

{ LocaleDirectoryExists returns a boolean value that indicates whether the
  specified directory exists with preferred UI language subdirectories.  }
function LocaleDirectoryExists(const Directory: string): Boolean;

{ GetLocaleDirectory retuens a string value that indicate a file path whether
  the specified directory exists with preferred UI language subdirectories.  }
function GetLocaleDirectory(const Directory: string): String;
{$ENDIF}

{$SCOPEDENUMS ON}
type
  TUncertainState = (Maybe, Yes, No);
{$SCOPEDENUMS OFF}

type
  TOSVersion = record
  public type
    TArchitecture = (arIntelX86, arIntelX64, arARM32);
    TPlatform = (pfWindows, pfMacOS, pfiOS, pfAndroid, pfWinRT, pfLinux);
  public const
    AllArchitectures = [arIntelX86, arIntelX64, arARM32];
    AllPlatforms = [pfWindows, pfMacOS, pfiOS, pfAndroid, pfWinRT, pfLinux];
  private
    class var FArchitecture: TArchitecture;
    class var FBuild: Integer;
    class var FMajor: Integer;
    class var FMinor: Integer;
    class var FName: string;
    class var FPlatform: TPlatform;
    class var FServicePackMajor: Integer;
    class var FServicePackMinor: Integer;
    class constructor Create;
  public
    class function Check(AMajor: Integer): Boolean; overload; static; inline;
    class function Check(AMajor, AMinor: Integer): Boolean; overload; static; inline;
    class function Check(AMajor, AMinor, AServicePackMajor: Integer): Boolean; overload; static; inline;
    class function ToString: string; static;
    class property Architecture: TArchitecture read FArchitecture;
    class property Build: Integer read FBuild;
    class property Major: Integer read FMajor;
    class property Minor: Integer read FMinor;
    class property Name: string read FName;
    class property Platform: TPlatform read FPlatform;
    class property ServicePackMajor: Integer read FServicePackMajor;
    class property ServicePackMinor: Integer read FServicePackMinor;
  end;

  /// <summary>
  ///   This type can be used to determine the list of architectures that are available or not available a few steps
  /// </summary>
  TArchitectures = set of TOSVersion.TArchitecture;
  /// <summary>
  ///   This type can be used to determine the list of platforms that are available or not available a few steps
  /// </summary>
  TPlatforms = set of TOSVersion.TPlatform;

{$IFDEF WIN32}{$DEFINE PLATFORMIMPLEMENTED}{$ENDIF}
{$IFDEF WIN64}{$DEFINE PLATFORMIMPLEMENTED}{$ENDIF}
{$IFDEF MACOS}{$DEFINE PLATFORMIMPLEMENTED}{$ENDIF}
{$IFNDEF PLATFORMIMPLEMENTED}
procedure PlatformNotImplemented;
{$ENDIF PLATFORMIMPLEMENTED}

implementation

{ !!!NOTE: PLEASE READ BEFORE CONSIDERING MODIFICATIONS TO THIS USES LIST!!!

  Please do not add units to this uses list without discussing it with the senior members of the team. We should keep
  this list to the smallest number of units as possible. Even if that sometimes means that some functionality available
  in another unit needs to be duplicated here. SysUtils.pas is intended to be one level above System.pas. Polluting
  this uses list inserts too many circular dependencies that can have a detrimental effect on building the RTL and
  on keeping the RTL as modular as possible. }

uses
{$IFDEF MSWINDOWS}
  Winapi.ImageHlp, Winapi.SHFolder, Winapi.PsAPI,
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Posix.Base, Posix.Dirent, Posix.Errno, Posix.Fnmatch, Posix.Iconv,
  Posix.Langinfo, Posix.Locale, Posix.Pthread, Posix.Stdio, Posix.Stdlib,
  Posix.String_, Posix.SysSysctl, Posix.Time, Posix.Unistd, Posix.Utime,
  Posix.Wordexp,
  {$IFNDEF IOS}
  Posix.Pwd,
  {$ENDIF !POSIX}
{$ENDIF POSIX}
{$IFDEF IOS}
  Macapi.ObjCRuntime,
{$ENDIF IOS}
  System.RTLConsts, System.Character, System.Internal.ExcUtils;

{$IFDEF MSWINDOWS}
{$INCLUDE EncodingData.inc}
{$ENDIF MSWINDOWS}


const
  MaxSingle   =  3.4e+38;
  MaxDouble   =  1.7e+308;

{$IFDEF MACOS}
type
  TCFString = record
    Value: CFStringRef;

    constructor Create(const Val: string);
    function AsString(Release: Boolean = False): string;
    function AsChar(Release: Boolean = False): Char;
    class operator Implicit(const Ref: CFStringRef): TCFString;
    class operator Implicit(const Ref: CFMutableStringRef): TCFString;
  end;

constructor TCFString.Create(const Val: string);
begin
  Value := CFStringCreateWithCharacters(kCFAllocatorDefault,
    PChar(Val), Length(Val));
end;

function TCFString.AsString(Release: Boolean = False): string;
var
  Range: CFRange;
  Tmp: TCharArray;
begin
  if Value = nil then Exit('');
  try
    Range := CFRangeMake(0, CFStringGetLength(Value));
    if Range.Length > 0 then
    begin
      SetLength(Tmp, Range.Length);
      CFStringGetCharacters(Value, Range, MarshaledString(Tmp));
      Result := string.Create(Tmp);
    end
    else
      Result := EmptyStr;
  finally
    if Release then
      CFRelease(Value);
  end;
end;

function TCFString.AsChar(Release: Boolean = False): Char;
begin
  if Value = nil then Exit(#0);
  try
    if CFStringGetLength(Value) > 0 then
      Result := CFStringGetCharacterAtIndex(Value, 0)
  else
      Result := #0;
  finally
    if Release then
      CFRelease(Value);
  end;
end;

class operator TCFString.Implicit(const Ref: CFStringRef): TCFString;
begin
  Result.Value := Ref;
end;

class operator TCFString.Implicit(const Ref: CFMutableStringRef): TCFString;
begin
  Result.Value := CFStringRef(Ref);
end;
{$ENDIF MACOS}

{$IFNDEF PLATFORMIMPLEMENTED}
procedure PlatformNotImplemented;
begin
   System.Error(rePlatformNotImplemented);
end;
{$ENDIF PLATFORMIMPLEMENTED}

{$IFDEF POSIX}
{
        Exceptions raised in methods that are safecall will be filtered
        through the virtual method SafeCallException on the class.  The
        implementation of this method under Linux has the option of setting
        the following thread vars:  SafeCallExceptionMsg, SafeCallExceptionAddr.
        If these are set, then the implementation of SafeCallError here will
        reraise a generic exception based on these.  One might consider actually
        having the SafeCallException implementation store off the exception
        object itself, but this raises the issue that the exception object
        might have to live a long time (if an external application calls a
        Delphi safecall method).  Since an arbitrary exception object could
        be holding large resources hostage, we hold only the string and
        address as a hedge.
}
threadvar
    SafeCallExceptionMsg: string;
    SafeCallExceptionAddr: Pointer;

procedure SetSafeCallExceptionMsg(const Msg: string);
begin
  SafeCallExceptionMsg := Msg;
end;

procedure SetSafeCallExceptionAddr(Addr: Pointer);
begin
  SafeCallExceptionAddr := Addr;
end;

function GetSafeCallExceptionMsg: string;
begin
  Result := SafeCallExceptionMsg;
end;

function GetSafeCallExceptionAddr: Pointer;
begin
  Result := SafeCallExceptionAddr;
end;
{$ENDIF POSIX}

{ Utility routines }

procedure DivMod(Dividend: Integer; Divisor: Word;
  var Result, Remainder: Word);
{$IFDEF PUREPASCAL}
begin
  Result    := Dividend div Divisor;
  Remainder := Dividend mod Divisor;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
        PUSH    EBX
        MOV     EBX,EDX
        MOV     EDX,EAX
        SHR     EDX,16
        DIV     BX
        MOV     EBX,Remainder
        MOV     [ECX],AX
        MOV     [EBX],DX
        POP     EBX
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

{$IFDEF PIC}
{ Do not remove export or the begin block. }
function GetGOT: Pointer; export;
begin
  asm
        MOV     Result,EBX
  end;
end;
{$ENDIF}

procedure ConvertError(ResString: PResStringRec); local;
begin
  raise EConvertError.CreateRes(ResString);
end;

{$IFDEF MSWINDOWS}
function InternalFileTimeToDateTime(Time: TFileTime): TDateTime;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
function InternalFileTimeToDateTime(Time: time_t): TDateTime;
{$ENDIF POSIX}

  function InternalEncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
    AMilliSecond: Word): TDateTime;
  var
    LTime: TDateTime;
    Success: Boolean;
  begin
    Result := 0;
    Success := TryEncodeDate(AYear, AMonth, ADay, Result);
    if Success then
    begin
      Success := TryEncodeTime(AHour, AMinute, ASecond, AMilliSecond, LTime);
      if Success then
        if Result >= 0 then
          Result := Result + LTime
        else
          Result := Result - LTime
    end;
  end;

{$IFDEF MSWINDOWS}
var
  LFileTime: TFileTime;
  SysTime: TSystemTime;
begin
  Result := 0;
  FileTimeToLocalFileTime(Time, LFileTime);

  if FileTimeToSystemTime(LFileTime, SysTime) then
    Result := InternalEncodeDateTime(SysTime.wYear, SysTime.wMonth, SysTime.wDay,
      SysTime.wHour, SysTime.wMinute, SysTime.wSecond, SysTime.wMilliseconds);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  LDecTime: tm;
begin
  Result := 0;

  if localtime_r(Time, LDecTime) <> nil then
    Result := InternalEncodeDateTime(LDecTime.tm_year + 1900, LDecTime.tm_mon + 1,
      LDecTime.tm_mday, LDecTime.tm_hour, LDecTime.tm_min, LDecTime.tm_sec, 0);
end;
{$ENDIF POSIX}

{$IFDEF MSWINDOWS}
type
  OBJECT_INFORMATION_CLASS = (ObjectBasicInformation, ObjectNameInformation,
    ObjectTypeInformation, ObjectAllTypesInformation, ObjectHandleInformation);

  UNICODE_STRING = packed record
    Length: Word;
    MaximumLength: Word;
    Buffer:PWideChar;
  end;

  OBJECT_NAME_INFORMATION = record
    TypeName: UNICODE_STRING;
    Reserved: array[0..21] of ULONG; // reserved for internal use
  end;

  TNtQueryObject = function (ObjectHandle: THandle;
    ObjectInformationClass: OBJECT_INFORMATION_CLASS; ObjectInformation: Pointer;
    Length: ULONG; ResultLength: PDWORD): THandle; stdcall;

var
  NTQueryObject: TNtQueryObject;

function InternalGetFileNameFromSymLink(const FileName: string; var TargetName: string): Boolean;

  // Use this function to get the final target file name of a symbolic link.
  // It is the same as GetFinalPathNameByHandle but GetFinalPathNameByHandle
  // has some problems.
  function InternalGetFileNameFromHandle(Handle: THandle; var FileName: string; Flags: DWORD): Boolean;

    function ExpandVolumeName(const AFileName: string): string;
    var
      Drives, Temp: array[0..MAX_PATH + 1] of Char;
      P: PChar;
      Len: Integer;
      VolumeName: string;
    begin
      Len := GetLogicalDriveStrings(MAX_PATH, Drives);

      if Len > 0 then
      begin
        P := @Drives[0];

        repeat
          (P + 2)^ := #0;
          Len := Integer(QueryDosDevice(P, Temp, MAX_PATH));

          if Len > 0 then
          begin
            VolumeName := Temp;
            if Pos(VolumeName, AFileName) > 0 then
            begin
              Len := Length(VolumeName);
              Result := P + Copy(AFileName, Len + 1, Length(AFileName) - Len);
              Break;
            end;
          end;

          while P^ <> #0 do
            Inc(P);
          Inc(P, 2);

        until P = '';
      end;
    end;

    function GetObjectInfoName(Handle: THandle): string;
    const
      STATUS_SUCCESS = $00000000;
    var
      Info: ^OBJECT_NAME_INFORMATION;
      Status: THandle;
      Size: DWORD;
    begin
      Result := '';
      if not Assigned(NTQueryObject) then
        NTQueryObject := GetProcAddress(GetModuleHandle('NTDLL.DLL'), 'NtQueryObject'); // Do not localize

      if not Assigned(NTQUeryObject) then
        Exit;

      NtQueryObject(Handle, ObjectNameInformation, nil, 0, @Size);
      GetMem(Info, size);
      try
        Status := NTQueryObject(Handle, ObjectNameInformation, Info, Size, @Size);

        if Status = STATUS_SUCCESS then
          Result := Info.TypeName.Buffer;
      finally
        FreeMem(Info);
      end;
    end;

  var
    FileMapHandle: THandle;
    FileSizeHigh, FileSizeLow: DWORD;
    Memory: Pointer;
    Buffer: array[0..MAX_PATH + 1] of Char;
  begin
    Result := False;
    FileName := '';
    FileSizeHigh := 0;
    FileSizeLow := GetFileSize(Handle, @FileSizeHigh);

    // GetFinalPathNameByHandle is broken so use other techniques to retrieve
    // the file's name.
    if (FileSizeLow = 0) and (FileSizeHigh = 0) and CheckWin32Version(6, 0) then
    begin
      if GetFinalPathNameByHandle(Handle, Buffer, MAX_PATH, VOLUME_NAME_NT) > 0 then
      begin
        FileName := ExpandVolumeName(Buffer);
        Exit(True);
      end;
    end;

    if (FileSizeLow <> 0) or (FileSizeHigh <> 0) then
    begin
      FileMapHandle := CreateFileMapping(Handle, nil, PAGE_READONLY, 0, 1, nil);

      if FileMapHandle <> ERROR_FILE_INVALID then
      begin
        try
          Memory := MapViewOfFile(FileMapHandle, FILE_MAP_READ, 0, 0, 1);

          if (Memory <> nil) then
          begin
            try
              if (GetMappedFileName(GetCurrentProcess(), Memory, Buffer, MAX_PATH) > 0) then
              begin
                FileName := ExpandVolumeName(Buffer);
                Result := True;
              end;
            finally
              UnmapViewOfFile(Memory);
            end;
          end;
        finally
          CloseHandle(FileMapHandle);
        end;
      end;
    end;

    if not Result then
    begin
      // If the file is zero size or is a directory then CreateFileMapping will
      // fail. Try using ZwQuerySystemInformation and ZwQueryObject.
      FileName := GetObjectInfoName(Handle);
      if FileName <> '' then
      begin
        FileName := ExpandVolumeName(FileName);
        Result := True;
      end;
    end;
  end;

var
  Handle: THandle;
  Flags: DWORD;
  Code: Cardinal;
begin
  Result := False;

  if CheckWin32Version(6, 0) and FileExists(FileName, False) and (fsSymLink in FileSystemAttributes(FileName)) then
  begin
    Code := GetFileAttributes(PChar(FileName));
    if (Code <> INVALID_FILE_ATTRIBUTES) and ((faSymLink and Code) <> 0) then
    begin
      if faDirectory and Code <> 0 then
        Flags := FILE_FLAG_BACKUP_SEMANTICS
      else
        Flags := 0;

      Handle := CreateFile(PChar(FileName), GENERIC_READ, FILE_SHARE_READ, nil,
        OPEN_EXISTING, Flags, 0);

      if Handle <> INVALID_HANDLE_VALUE then
      begin
        try
          Result := InternalGetFileNameFromHandle(Handle, TargetName, Flags);
        finally
          CloseHandle(Handle);
        end;
      end;
    end;
  end;
end;
{$ENDIF MSWINDOWS}

{ TSearchRec }

function TSearchRec.GetTimeStamp: TDateTime;
begin
{$IFDEF MSWINDOWS}
  Result := InternalFileTimeToDateTime(FindData.ftLastWriteTime);
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalFileTimeToDateTime(Time);
{$ENDIF POSIX}
end;

{ TDateTimeRec }

function TDateTimeInfoRec.GetCreationTime: TDateTime;
begin
{$IFDEF MSWINDOWS}
  Result := InternalFileTimeToDateTime(Data.ftCreationTime);
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalFileTimeToDateTime(st.st_ctime);
{$ENDIF POSIX}
end;

function TDateTimeInfoRec.GetLastAccessTime: TDateTime;
begin
{$IFDEF MSWINDOWS}
  Result := InternalFileTimeToDateTime(Data.ftLastAccessTime);
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalFileTimeToDateTime(st.st_atime);
{$ENDIF POSIX}
end;

function TDateTimeInfoRec.GetTimeStamp: TDateTime;
begin
{$IFDEF MSWINDOWS}
  Result := InternalFileTimeToDateTime(Data.ftLastWriteTime);
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalFileTimeToDateTime(st.st_mtime);
{$ENDIF POSIX}
end;

{ TSymLinkRec }

function TSymLinkRec.GetTimeStamp: TDateTime;
begin
{$IFDEF MSWINDOWS}
  Result := InternalFileTimeToDateTime(FindData.ftLastWriteTime);
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalFileTimeToDateTime(Time);
{$ENDIF POSIX}
end;

procedure ConvertErrorFmt(ResString: PResStringRec; const Args: array of const); local;
begin
  raise EConvertError.CreateResFmt(ResString, Args);
end;

{$IFDEF MSWINDOWS}
{$EXTERNALSYM CoCreateGuid}
function CoCreateGuid(out guid: TGUID): HResult; stdcall; external 'ole32.dll' name 'CoCreateGuid';

function CreateGUID(out Guid: TGUID): HResult;
begin
  Result := CoCreateGuid(Guid);
end;
{$ENDIF}

{$IFDEF POSIX}

{ CreateGUID }

{ libuuid.so implements the tricky code to create GUIDs using the
  MAC address of the network adapter plus other flavor bits.
  libuuid.so is currently distributed with the ext2 file system
  package, but does not depend upon the ext2 file system libraries.
  Ideally, libuuid.so should be distributed separately.

  If you do not have libuuid.so.1 on your Linux distribution, you
  can extract the library from the e2fsprogs RPM.

  Note:  Do not use the generic uuid_generate function in libuuid.so.
  In the current implementation (e2fsprogs-1.19), uuid_generate
  gives preference to generating guids entirely from random number
  streams over generating guids based on the NIC MAC address.
  No matter how "random" a random number generator is, it will
  never produce guids that can be guaranteed unique across all
  systems on the planet.  MAC-address based guids are guaranteed
  unique because the MAC address of the NIC is guaranteed unique
  by the manufacturer.

  For this reason, we call uuid_generate_time instead of the
  generic uuid_generate.  uuid_generate_time constructs the guid
  using the MAC address, and falls back to randomness if no NIC
  can be found.  }

var
  libuuidHandle: NativeUInt;
  uuid_generate_time: procedure (out Guid: TGUID) cdecl;

function CreateGUID(out Guid: TGUID): HResult;
const
  E_NOTIMPL = HRESULT($80004001);
begin
  Result := E_NOTIMPL;
  if libuuidHandle = 0 then
  begin
    // uuid_generate_time lives in libuuid.so.1 on Linux and libc on Mac OSX
    libuuidHandle := dlopen({$IFDEF MACOS}libc{$ENDIF}{$IFDEF LINUX}'libuuid.so.1'{$ENDIF}, RTLD_LAZY);
    if libuuidHandle = 0 then Exit;
    uuid_generate_time := dlsym(libuuidHandle, 'uuid_generate_time');
    if @uuid_generate_time = nil then Exit;
  end;
  if Assigned(uuid_generate_time) then
  begin
    uuid_generate_time(Guid);
    Result := 0;
  end;
end;
{$ENDIF POSIX}

function StringToGUID(const S: string): TGUID;

  procedure InvalidGUID;
  begin
    ConvertErrorFmt(@SInvalidGUID, [s]);
  end;

  function HexChar(c: Char): Byte;
  begin
    case c of
      '0'..'9':  Result := Byte(c) - Byte('0');
      'a'..'f':  Result := (Byte(c) - Byte('a')) + 10;
      'A'..'F':  Result := (Byte(c) - Byte('A')) + 10;
    else
      InvalidGUID;
      Result := 0;
    end;
  end;

  function HexByte(p: PChar): Byte;
  begin
    Result := Byte((HexChar(p[0]) shl 4) + HexChar(p[1]));
  end;

var
  i: Integer;
  src: PChar;
  dest: PByte;
begin
  if ((Length(S) <> 38) or (S[Low(string)] <> '{')) then InvalidGUID;
  dest := @Result;
  src := PChar(s);
  Inc(src);
  for i := 0 to 3 do
    dest[i] := HexByte(src+(3-i)*2);
  Inc(src, 8);
  Inc(dest, 4);
  if src[0] <> '-' then InvalidGUID;
  Inc(src);
  for i := 0 to 1 do
  begin
    dest^ := HexByte(src+2);
    Inc(dest);
    dest^ := HexByte(src);
    Inc(dest);
    Inc(src, 4);
    if src[0] <> '-' then InvalidGUID;
    inc(src);
  end;
  dest^ := HexByte(src);
  Inc(dest);
  Inc(src, 2);
  dest^ := HexByte(src);
  Inc(dest);
  Inc(src, 2);
  if src[0] <> '-' then InvalidGUID;
  Inc(src);
  for i := 0 to 5 do
  begin
    dest^ := HexByte(src);
    Inc(dest);
    Inc(src, 2);
  end;
end;

function GUIDToString(const Guid: TGUID): string;
begin
  SetLength(Result, 38);
  StrLFmt(PChar(Result), 38,'{%.8x-%.4x-%.4x-%.2x%.2x-%.2x%.2x%.2x%.2x%.2x%.2x}',   // do not localize
    [Guid.D1, Guid.D2, Guid.D3, Guid.D4[0], Guid.D4[1], Guid.D4[2], Guid.D4[3],
    Guid.D4[4], Guid.D4[5], Guid.D4[6], Guid.D4[7]]);
end;

function IsEqualGUID(const Guid1, Guid2: TGUID): Boolean;
var
  a, b: PIntegerArray;
begin
  a := PIntegerArray(@Guid1);
  b := PIntegerArray(@Guid2);
  Result := (a^[0] = b^[0]) and (a^[1] = b^[1]) and (a^[2] = b^[2]) and (a^[3] = b^[3]);
end;

{ TGuidHelper }

class function TGuidHelper.Create(const S: string): TGUID;
begin
  Result := StringToGUID(S);
end;

class function TGuidHelper.Create(const B: TBytes): TGUID;
begin
  if Length(B) <> 16 then
    raise EArgumentException.CreateResFmt(@SInvalidGuidArray, [16]);
  Move(B[0], Result, SizeOf(Result));
end;

class function TGuidHelper.Create(A: Integer; B, C: SmallInt; const D: TBytes): TGUID;
begin
  if Length(D) <> 16 then
    raise EArgumentException.CreateResFmt(@SInvalidGuidArray, [8]);
  Result.D1 := LongWord(A);
  Result.D2 := Word(B);
  Result.D3 := Word(C);
  Move(D[0], Result.D4, SizeOf(Result.D4));
end;

class function TGuidHelper.Create(A: Cardinal; B, C: Word; D, E, F, G, H, I, J, K: Byte): TGUID;
begin
  Result.D1 := LongWord(A);
  Result.D2 := Word(B);
  Result.D3 := Word(C);
  Result.D4[0] := D;
  Result.D4[1] := E;
  Result.D4[2] := F;
  Result.D4[3] := G;
  Result.D4[4] := H;
  Result.D4[5] := I;
  Result.D4[6] := J;
  Result.D4[7] := K;
end;

class function TGuidHelper.Create(A: Integer; B, C: SmallInt; D, E, F, G, H, I, J, K: Byte): TGUID;
begin
  Result.D1 := LongWord(A);
  Result.D2 := Word(B);
  Result.D3 := Word(C);
  Result.D4[0] := D;
  Result.D4[1] := E;
  Result.D4[2] := F;
  Result.D4[3] := G;
  Result.D4[4] := H;
  Result.D4[5] := I;
  Result.D4[6] := J;
  Result.D4[7] := K;
end;

class function TGuidHelper.NewGuid: TGUID;
begin
  if CreateGUID(Result) <> S_OK then
    RaiseLastOSError;
end;

function TGuidHelper.ToByteArray: TBytes;
begin
  SetLength(Result, 16);
  Move(D1, Result[0], SizeOf(Self));
end;

function TGuidHelper.ToString: string;
begin
  Result := GuidToString(Self);
end;

{ Exit procedure handling }

type
  PExitProcInfo = ^TExitProcInfo;
  TExitProcInfo = record
    Next: PExitProcInfo;
    SaveExit: Pointer;
    Proc: TProcedure;
  end;

var
  ExitProcList: PExitProcInfo = nil;

procedure DoExitProc;
var
  P: PExitProcInfo;
  Proc: TProcedure;
begin
  P := ExitProcList;
  ExitProcList := P^.Next;
  ExitProc := P^.SaveExit;
  Proc := P^.Proc;
  Dispose(P);
  Proc;
end;

procedure AddExitProc(Proc: TProcedure);
var
  P: PExitProcInfo;
begin
  New(P);
  P^.Next := ExitProcList;
  P^.SaveExit := ExitProc;
  P^.Proc := Proc;
  ExitProcList := P;
  ExitProc := @DoExitProc;
end;

{ String handling routines }

{ Put these (IsLeadChar, CharInSet) here so that they're compiled before being used so they're properly
  inlined }

{$IFNDEF NEXTGEN}
function IsLeadChar(C: AnsiChar): Boolean;
begin
  Result := C in LeadBytes;
end;

function IsLeadChar(C: Byte): Boolean;
begin
  Result := AnsiChar(C) in LeadBytes;
end;
{$ELSE NEXTGEN}
function IsLeadChar(C: Byte): Boolean;
begin
  Result := C in LeadBytes;
end;
{$ENDIF !NEXTGEN}

function IsLeadChar(C: WideChar): Boolean;
begin
  Result := (C >= #$D800) and (C <= #$DFFF);
end;

{$IFNDEF NEXTGEN}
function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean;
begin
  Result := C in CharSet;
end;

function CharInSet(C: WideChar; const CharSet: TSysCharSet): Boolean;
begin
  Result := C in CharSet;
end;
{$ELSE}
function CharInSet(C: Byte; const CharSet: TSysCharSet): Boolean;
begin
  Result := Char(C) in CharSet;
end;

function CharInSet(C: Char; const CharSet: TSysCharSet): Boolean;
begin
  Result := C in CharSet;
end;
{$ENDIF}

{$IFNDEF NEXTGEN}
function NewStr(const S: AnsiString): PAnsiString;
begin
  if S = '' then Result := NullAnsiStr else
  begin
    New(Result);
    Result^ := S;
  end;
end;

procedure DisposeStr(P: PAnsiString);
begin
  if (P <> nil) and (P^ <> '') then Dispose(P);
end;

procedure AssignStr(var P: PAnsiString; const S: AnsiString);
var
  Temp: PAnsiString;
begin
  Temp := P;
  P := NewStr(S);
  DisposeStr(Temp);
end;

procedure AppendStr(var Dest: AnsiString; const S: AnsiString);
begin
  Dest := Dest + S;
end;
{$ENDIF !NEXTGEN}

(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function UpperCase is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 * Code was modified to to ensure the string payload is ansi
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow, Allen Bauer
 *
 * ***** END LICENSE BLOCK ***** *)
function UpperCase(const S: string): string;
var
  I, Len: Integer;
  DstP, SrcP: PChar;
  Ch: Char;
begin
  Len := Length(S);
  SetLength(Result, Len);
  if Len > 0 then
  begin
    DstP := PChar(Pointer(Result));
    SrcP := PChar(Pointer(S));
    for I := Len downto 1 do
    begin
      Ch := SrcP^;
      case Ch of
        'a'..'z':
          Ch := Char(Word(Ch) xor $0020);
      end;
      DstP^ := Ch;
      Inc(DstP);
      Inc(SrcP);
    end;
  end;
end;

function UpperCase(const S: string; LocaleOptions: TLocaleOptions): string;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiUpperCase(S)
  else
    Result := UpperCase(S);
end;

(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function LowerCase is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 * Code was modified to to ensure the string payload is ansi
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow, Allen Bauer
 *
 * ***** END LICENSE BLOCK ***** *)
function LowerCase(const S: string): string;
var
  I, Len: Integer;
  DstP, SrcP: PChar;
  Ch: Char;
begin
  Len := Length(S);
  SetLength(Result, Len);
  if Len > 0 then
  begin
    DstP := PChar(Pointer(Result));
    SrcP := PChar(Pointer(S));
    for I := Len downto 1 do
    begin
      Ch := SrcP^;
      case Ch of
        'A'..'Z':
          Ch := Char(Word(Ch) or $0020);
      end;
      DstP^ := Ch;
      Inc(DstP);
      Inc(SrcP);
    end;
  end;
end;

function LowerCase(const S: string; LocaleOptions: TLocaleOptions): string;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiLowerCase(S)
  else
    Result := LowerCase(S);
end;

(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function CompareStr is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 * Code was modified to support word-sized Unicode strings and to ensure
 * the string payload is unicode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2007
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Pierre le Riche, Allen Bauer
 *
 * ***** END LICENSE BLOCK ***** *)
function CompareStr(const S1, S2: string): Integer;
{$IFDEF PUREPASCAL}
var
  I, Last, L1, L2, C1, C2, Ch1, Ch2: Integer;
begin
  L1 := Length(S1);
  L2 := Length(S2);
  result := L1 - L2;
  if (L1 > 0) and (L2 > 0) then
  begin
    if result < 0 then Last := L1 shl 1
    else Last := L2 shl 1;

    I := 0;
    while I < Last do
    begin
      C1 := PInteger(PByte(S1) + I)^;
      C2 := PInteger(PByte(S2) + I)^;
      if C1 <> C2 then
      begin
        { Compare first character }
        Ch1 := C1 and $0000FFFF;
        Ch2 := C2 and $0000FFFF;
        if Ch1 <> Ch2 then
          Exit(Ch1 - Ch2);

        { Compare second }
        Ch1 := (C1 and $FFFF0000) shr 16;
        Ch2 := (C2 and $FFFF0000) shr 16;
        if Ch1 <> Ch2 then
          Exit(Ch1 - Ch2);
      end;
      inc(I, 4);
    end;
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAligned
  {On entry:
     eax = @S1[1]
     edx = @S2[1]
   On exit:
     Result in eax:
       0 if S1 = S2,
       > 0 if S1 > S2,
       < 0 if S1 < S2
   Code size:
     101 bytes}
        CMP EAX, EDX
        JE @SameString
        {Is either of the strings perhaps nil?}
        TEST EAX, EDX
        JZ @PossibleNilString
        {Compare the first four characters (there has to be a trailing #0). In random
         string compares this can save a lot of CPU time.}
@BothNonNil:
        {Compare the first character}
        MOVZX ECX, WORD PTR [EDX]
        CMP CX, [EAX]
        JE @FirstCharacterSame
        {First character differs}
        MOVZX EAX, WORD PTR [EAX]
        SUB EAX, ECX
        JMP @Done
@FirstCharacterSame:
        {Save ebx}
        PUSH EBX
        {Set ebx = length(S1)}
        MOV EBX, [EAX - 4]
        XOR ECX, ECX
        {Set ebx = length(S1) - length(S2)}
        SUB EBX, [EDX - 4]
        {Save the length difference on the stack}
        PUSH EBX
        {Set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
        ADC ECX, -1
        {Set ecx = - min(length(S1), length(S2))}
        AND ECX, EBX
        SUB ECX, [EAX - 4]
        SAL ECX, 1
        {Adjust the pointers to be negative based}
        SUB EAX, ECX
        SUB EDX, ECX
@CompareLoop:
        MOV EBX, [EAX + ECX]
        XOR EBX, [EDX + ECX]
        JNZ @Mismatch
        ADD ECX, 4
        JS @CompareLoop
        {All characters match - return the difference in length}
@MatchUpToLength:
        POP EAX
        POP EBX
@Done:
        RET
@Mismatch:
        BSF EBX, EBX
        SHR EBX, 4
        ADD EBX, EBX
        ADD ECX, EBX
        JNS @MatchUpToLength
        MOVZX EAX, WORD PTR [EAX + ECX]
        MOVZX EDX, WORD PTR [EDX + ECX]
        SUB EAX, EDX
        POP EBX
        POP EBX
        JMP @Done
        {It is the same string}
@SameString:
        XOR EAX, EAX
        RET
        {Good possibility that at least one of the strings are nil}
@PossibleNilString:
        TEST EAX, EAX
        JZ @FirstStringNil
        TEST EDX, EDX
        JNZ @BothNonNil
        {Return first string length: second string is nil}
        MOV EAX, [EAX - 4]
        RET
@FirstStringNil:
        {Return 0 - length(S2): first string is nil}
        SUB EAX, [EDX - 4]
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function CompareStr(const S1, S2: string; LocaleOptions: TLocaleOptions): Integer;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiCompareStr(S1, S2)
  else
    Result := CompareStr(S1, S2);
end;

function SameStr(const S1, S2: string): Boolean;
{$IFNDEF LEGACYSAMESTR}
begin
  if Pointer(S1) = Pointer(S2) then
    Exit(True)
  else if (Pointer(S1) = nil) or (Pointer(S2) = nil) then
    Exit(False)
  else
    Result := CompareStr(S1, S2) = 0;
end;
{$ELSE !LEGACYSAMESTR}
asm //StackAligned
        CMP     EAX,EDX
        JZ      @1
        OR      EAX,EAX
        JZ      @2
        OR      EDX,EDX
        JZ      @3
        MOV     ECX,[EAX-4]
        CMP     ECX,[EDX-4]
        JNE     @3

{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        CALL    CompareStr
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        TEST    EAX,EAX
        JNZ     @3
@1:     MOV     AL,1
@2:     RET
@3:     XOR     EAX,EAX
end;
{$ENDIF !LEGACYSAMESTR}

function SameStr(const S1, S2: string; LocaleOptions: TLocaleOptions): Boolean;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiSameStr(S1, S2)
  else
    Result := SameStr(S1, S2);
end;

                                                                                                   
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function CompareMem is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Aleksandr Sharahov
 *
 * ***** END LICENSE BLOCK ***** *)
function CompareMem(P1, P2: Pointer; Length: Integer): Boolean;
{$IF defined(POSIX)}
begin
  if Length <= 0 then
    Result := True
  else
    Result := memcmp(P1^, P2^, Length) = 0;
end;
{$ELSEIF defined(PUREPASCAL)}
{$IFOPT Q+}
  {$DEFINE __OVERFLOWCHECKS}
  {$OVERFLOWCHECKS OFF}
{$ENDIF}
{$IFOPT R+}
  {$DEFINE __RANGECHECKS}
  {$RANGECHECKS OFF}
{$ENDIF}
{$POINTERMATH ON}
var
  Q1, Q2: PInt64;
  C: NativeUInt;
begin;
  if Length <= 0 then Exit(True);
  Result := False;
  Q1 := P1;
  Q2 := P2;
  C := NativeUInt(Length) + UIntPtr(P1) - 16;
  if C >= UIntPtr(Q1) then
  begin;
    if Q1[0] <> Q2[0] then
      Exit;
    Inc(Q1);
    Inc(Q2);
    Dec(PByte(Q2), UIntPtr(Q1));
    UIntPtr(Q1) := UIntPtr(Q1) and -8;
    Inc(PByte(Q2), UIntPtr(Q1));
    if C >= UIntPtr(Q1) then
    repeat
      if Q1[0] <> Q2[0] then
        Exit;
      if Q1[1] <> Q2[1] then
        Exit;
      Inc(Q1, 2);
      Inc(Q2, 2);
      if C < UIntPtr(Q1) then
        Break;
      if Q1[0] <> Q2[0] then
        Exit;
      if Q1[1] <> Q2[1] then
        Exit;
      Inc(Q1, 2);
      Inc(Q2, 2);
    until C < UIntPtr(Q1);
  end;
  C := C - UIntPtr(Q1) + 16;
  if Integer(C) >= 8 then
  begin
    if Q1[0] <> Q2[0] then
      Exit;
    Inc(Q1);
    Inc(Q2);
    C := C - 8;
  end;
  if Integer(C) >= 6 then
  begin;
    if PInteger(Q1)[0] <> PInteger(Q2)[0] then
      Exit;
    Inc(PInteger(Q1));
    Inc(PInteger(Q2));
    if PWord(Q1)[0] <> PWord(Q2)[0] then
      Exit;
    Inc(PWord(Q1));
    Inc(PWord(Q2));
    C := C - 6;
  end;
  if Integer(C) >= 5 then
  begin
    if PInteger(Q1)[0] <> PInteger(Q2)[0] then
      Exit;
    Inc(PInteger(Q1));
    Inc(PInteger(Q2));
    if PByte(Q1)[0] <> PByte(Q2)[0] then
      Exit;
    Inc(PByte(Q1));
    Inc(PByte(Q2));
    C := C - 5;
  end;
  if Integer(C) >= 4 then
  begin
    if PInteger(Q1)[0] <> PInteger(Q2)[0] then
      Exit;
    Inc(PInteger(Q1));
    Inc(PInteger(Q2));
    C := C - 4;
  end;
  if Integer(C) >= 2 then
  begin;
    if PWord(Q1)[0] <> PWord(Q2)[0] then
      Exit;
    Inc(PWord(Q1));
    Inc(PWord(Q2));
    C := C - 2;
  end;
  if Integer(C) >= 1 then
    if PByte(Q1)[0] <> PByte(Q2)[0] then
      Exit;
  Result := True;
end;
{$POINTERMATH OFF}
{$IFDEF __OVERFLOWCHECKS}
  {$UNDEF __OVERFLOWCHECKS}
  {$OVERFLOWCHECKS ON}
{$ENDIF}
{$IFDEF __RANGECHECKS}
  {$UNDEF __RANGECHECKS}
  {$RANGECHECKS ON}
{$ENDIF}
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
   add   eax, ecx
   add   edx, ecx
   xor   ecx, -1
   add   eax, -8
   add   edx, -8
   add   ecx, 9
   push  ebx
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   lea   ebx, [eax+ecx]
   add   ecx, 4
   and   ebx, 3
   sub   ecx, ebx
   jg    @Dword
@DwordLoop:
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jle   @DwordLoop
@Dword:
   cmp   ecx, 4
   jg    @Word
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   add   ecx, 4
@Word:
   cmp   ecx, 6
   jg    @Byte
   movzx ebx, word ptr [eax+ecx]
   cmp   bx, [edx+ecx]
   jne   @Ret0
   add   ecx, 2
@Byte:
   cmp   ecx, 7
   jg    @Ret1
   movzx ebx, byte ptr [eax+7]
   cmp   bl, [edx+7]
   jne   @Ret0
@Ret1:
   mov   eax, 1
   pop   ebx
   ret
@Ret0:
   xor   eax, eax
   pop   ebx
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function CompareText is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow
 *
 * ***** END LICENSE BLOCK ***** *)
function CompareText(const S1, S2: string): Integer;
{$IFDEF PUREPASCAL}
var
  I, Last, L1, L2, C1, C2, Ch1, Ch2: Integer;
begin
  L1 := Length(S1);
  L2 := Length(S2);
  result := L1 - L2;
  if (L1 > 0) and (L2 > 0) then
  begin
    if result < 0 then Last := L1 shl 1
    else Last := L2 shl 1;

    I := 0;
    while I < Last do
    begin
      C1 := PInteger(PByte(S1) + I)^;
      C2 := PInteger(PByte(S2) + I)^;
      if C1 <> C2 then
      begin
        { Compare first char}
        Ch1 := C1 and $0000FFFF;
        Ch2 := C2 and $0000FFFF;
        if Ch1 <> Ch2 then
        begin
          if (Ch1 >= ord('a')) and (Ch1 <= ord('z')) then
            Ch1 := Ch1 xor $20;

          if (Ch2 >= ord('a')) and (Ch2 <= ord('z')) then
            Ch2 := Ch2 xor $20;

          if Ch1 <> Ch2 then
            Exit(Ch1 - Ch2);
        end;

        { Compare second }
        Ch1 := (C1 and $FFFF0000) shr 16;
        Ch2 := (C2 and $FFFF0000) shr 16;
        if Ch1 <> Ch2 then
        begin
          if (Ch1 >= ord('a')) and (Ch1 <= ord('z')) then
            Ch1 := Ch1 xor $20;

          if (Ch2 >= ord('a')) and (Ch2 <= ord('z')) then
            Ch2 := Ch2 xor $20;

          if Ch1 <> Ch2 then
            Exit(Ch1 - Ch2);
        end;
      end;
      inc(I, 4);
    end;
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        TEST   EAX, EAX
        JNZ    @@CheckS2
        TEST   EDX, EDX
        JZ     @@Ret
        MOV    EAX, [EDX-4]
        NEG    EAX
@@Ret:
        RET
@@CheckS2:
        TEST   EDX, EDX
        JNZ    @@Compare
        MOV    EAX, [EAX-4]
        RET
@@Compare:
        PUSH   EBX
        PUSH   EBP
        PUSH   ESI

        MOV    EBP, [EAX-4]     // length(S1)
        MOV    EBX, [EDX-4]     // length(S2)
        SUB    EBP, EBX         // Result if All Compared Characters Match
        SBB    ECX, ECX
        AND    ECX, EBP
        ADD    ECX, EBX         // min(length(S1),length(S2)) = Compare Length
        LEA    ESI, [EAX+ECX*2] // Last Compare Position in S1
        ADD    EDX, ECX         // Last Compare Position in S2
        ADD    EDX, ECX         // Last Compare Position in S2
        NEG    ECX
        JZ     @@SetResult      // Exit if Smallest Length = 0
@@Loop:                         // Load Next 2 Chars from S1 and S2
                                // May Include Null Terminator}
        MOV    EAX, [ESI+ECX*2]
        MOV    EBX, [EDX+ECX*2]
        CMP    EAX,EBX
        JE     @@Next           // Next 2 Chars Match
        CMP    AX,BX
        JE     @@SecondPair     // First Char Matches
        AND    EAX,$0000FFFF
        AND    EBX,$0000FFFF
        CMP    EAX, 'a'
        JL     @@UC1
        CMP    EAX, 'z'
        JG     @@UC1
        SUB    EAX, 'a'-'A'
@@UC1:
        CMP    EBX, 'a'
        JL     @@UC2
        CMP    EBX, 'z'
        JG     @@UC2
        SUB    EBX, 'a'-'A'
@@UC2:
        SUB    EAX,EBX          // Compare Both Uppercase Chars
        JNE    @@Done           // Exit with Result in EAX if Not Equal
        MOV    EAX, [ESI+ECX*2] // Reload Same 2 Chars from S1
        MOV    EBX, [EDX+ECX*2] // Reload Same 2 Chars from S2
        AND    EAX,$FFFF0000
        AND    EBX,$FFFF0000
        CMP    EAX,EBX
        JE     @@Next           // Second Char Matches
@@SecondPair:
        SHR    EAX, 16
        SHR    EBX, 16
        CMP    EAX, 'a'
        JL     @@UC3
        CMP    EAX, 'z'
        JG     @@UC3
        SUB    EAX, 'a'-'A'
@@UC3:
        CMP    EBX, 'a'
        JL     @@UC4
        CMP    EBX, 'z'
        JG     @@UC4
        SUB    EBX, 'a'-'A'
@@UC4:
        SUB    EAX,EBX          // Compare Both Uppercase Chars
        JNE    @@Done           // Exit with Result in EAX if Not Equal
@@Next:
        ADD    ECX, 2
        JL     @@Loop           // Loop until All required Chars Compared
@@SetResult:
        MOV    EAX,EBP          // All Matched, Set Result from Lengths
@@Done:
        POP    ESI
        POP    EBP
        POP    EBX
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function CompareText(const S1, S2: string; LocaleOptions: TLocaleOptions): Integer;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiCompareText(S1, S2)
  else
    Result := CompareText(S1, S2);
end;

function SameText(const S1, S2: string): Boolean;
{$IFNDEF LEGACYSAMETEXT}
begin
  if Pointer(S1) = Pointer(S2) then
    Exit(True)
  else if (Pointer(S1) = nil) or (Pointer(S2) = nil) then
    Exit(False)
  else
    Result := CompareText(S1, S2) = 0;
end;
{$ELSE !LEGACYSAMETEXT}
asm
        CMP     EAX,EDX
        JZ      @1
        OR      EAX,EAX
        JZ      @2
        OR      EDX,EDX
        JZ      @3
        MOV     ECX,[EAX-4]
        CMP     ECX,[EDX-4]
        JNE     @3
{$IFDEF ALIGN_STACK}
        SUB    ESP, 12
{$ENDIF ALIGN_STACK}
        CALL    CompareText
{$IFDEF ALIGN_STACK}
        ADD    ESP, 12
{$ENDIF ALIGN_STACK}
        TEST    EAX,EAX
        JNZ     @3
@1:     MOV     AL,1
@2:     RET
@3:     XOR     EAX,EAX
end;
{$ENDIF !LEGACYSAMETEXT}

function SameText(const S1, S2: string; LocaleOptions: TLocaleOptions): Boolean;
begin
  if LocaleOptions = loUserLocale then
    Result := AnsiSameText(S1, S2)
  else
    Result := SameText(S1, S2);
end;

{$IF defined(POSIX) and not defined(MACOS)}
function UCS4UpperCase(const S: UCS4String; Locale: locale_t = nil): UCS4String;
var
  I: Integer;
begin
  if Locale = nil then
    Locale := UTF8CompareLocale;
  Result := S;
  for I := 0 to Length(Result) - 1 do
    Result[I] := UCS4Char(towupper_l(wint_t(Result[I]), Locale));
end;

function UCS4LowerCase(const S: UCS4String; Locale: locale_t = nil): UCS4String;
var
  I: Integer;
begin
  if Locale = nil then
    Locale := UTF8CompareLocale;
  Result := S;
  for I := 0 to Length(Result) - 1 do
    Result[I] := UCS4Char(towlower_l(wint_t(Result[I]), Locale));
end;

function UCS4CompareStr(const S1, S2: UCS4String; Locale: locale_t = nil): Integer;
begin
  if Locale = nil then
    Locale := UTF8CompareLocale;
  SetLastError(0);
  Result := wcscoll_l(Pwchar_t(S1), Pwchar_t(S2), Locale);
  if GetLastError <> 0 then
    RaiseLastOSError;
end;

function UCS4CompareText(const S1, S2: UCS4String): Integer;
var
  Locale: locale_t;
begin
  Locale := UTF8CompareLocale;
  Result := UCS4CompareStr(UCS4UpperCase(S1, Locale), UCS4UpperCase(S2, Locale), Locale);
end;
{$ENDIF POSIX}

function AnsiUpperCase(const S: string): string;
{$IFDEF MSWINDOWS}
begin
  Result := S;
  if Result <> '' then
  begin
    UniqueString(Result);
    CharUpperBuff(PChar(Result), Result.Length);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
var
  MutableStringRef: CFMutableStringRef;
begin
  Result := S;
  if Result <> '' then
  begin
    UniqueString(Result);
    MutableStringRef := CFStringCreateMutableWithExternalCharactersNoCopy(kCFAllocatorDefault,
      PChar(Result), Result.Length, Result.Length, kCFAllocatorNull);
    if MutableStringRef <> nil then
    try
      CFStringUppercase(MutableStringRef, UTF8CompareLocale);
    finally
      CFRelease(MutableStringRef);
    end else
      raise ECFError.Create(SCFStringFailed);
  end;
end;
{$ELSEIF defined(POSIX)}
begin
  Result := UCS4StringToUnicodeString(UCS4UpperCase(UnicodeStringToUCS4String(S)));
end;
{$ENDIF POSIX}

function AnsiLowerCase(const S: string): string;
{$IFDEF MSWINDOWS}
var
  Len: Integer;
begin
  Len := Length(S);
  SetString(Result, PChar(S), Len);
  if Len > 0 then
    CharLowerBuff(PChar(Result), Len);
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
var
  MutableStringRef: CFMutableStringRef;
begin
  Result := S;
  if Result <> '' then
  begin
    UniqueString(Result);
    MutableStringRef := CFStringCreateMutableWithExternalCharactersNoCopy(kCFAllocatorDefault,
      PChar(Result), Result.Length, Result.Length, kCFAllocatorNull);
    if MutableStringRef <> nil then
    try
      CFStringLowercase(MutableStringRef, UTF8CompareLocale);
    finally
      CFRelease(MutableStringRef);
    end else
      raise ECFError.Create(SCFStringFailed);
  end;
end;
{$ELSEIF defined(POSIX)}
begin
  Result := UCS4StringToUnicodeString(UCS4LowerCase(UnicodeStringToUCS4String(S)));
end;
{$ENDIF POSIX}

function AnsiCompareStr(const S1, S2: string): Integer;
{$IFDEF MSWINDOWS}
begin
  Result := CompareString(LOCALE_USER_DEFAULT, 0, PChar(S1), Length(S1),
      PChar(S2), Length(S2)) - CSTR_EQUAL;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
{$IFDEF MACOS}
var
  StringRef1: CFStringRef;
  StringRef2: CFStringRef;
begin
  Result := -1;
  StringRef1 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, @S1[Low(string)],
    S1.Length, kCFAllocatorNull);
  if StringRef1 <> nil then
  try
    StringRef2 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, @S2[Low(string)],
      S2.Length, kCFAllocatorNull);
    if StringRef2 <> nil then
    try
      Result := CFStringCompareWithOptionsAndLocale(StringRef1, StringRef2,
        CFRangeMake(0, S1.Length), 0, UTF8CompareLocale);
    finally
      CFRelease(StringRef2);
    end else
      raise ECFError.Create(SCFStringFailed);
  finally
    CFRelease(StringRef1);
  end else
    raise ECFError.Create(SCFStringFailed);
end;
{$ELSE}
begin
  Result := UCS4CompareStr(UnicodeStringToUCS4String(S1),
    UnicodeStringToUCS4String(S2));
end;
{$ENDIF MACOS}
{$ENDIF POSIX}

function AnsiSameStr(const S1, S2: string): Boolean;
begin
  Result := AnsiCompareStr(S1, S2) = 0;
end;

function AnsiCompareText(const S1, S2: string): Integer;
{$IFDEF MSWINDOWS}
begin
  Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, PChar(S1),
    Length(S1), PChar(S2), Length(S2)) - CSTR_EQUAL;
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
var
  StringRef1: CFStringRef;
  StringRef2: CFStringRef;
begin
  Result := -1;
  StringRef1 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, @S1[Low(string)],
    S1.Length, kCFAllocatorNull);
  if StringRef1 <> nil then
  try
    StringRef2 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, @S2[Low(string)],
      S2.Length, kCFAllocatorNull);
    if StringRef2 <> nil then
    try
      Result := CFStringCompareWithOptionsAndLocale(StringRef1, StringRef2,
        CFRangeMake(0, S1.Length), kCFCompareCaseInsensitive, UTF8CompareLocale);
    finally
      CFRelease(StringRef2);
    end else
      raise ECFError.Create(SCFStringFailed);
  finally
    CFRelease(StringRef1);
  end else
    raise ECFError.Create(SCFStringFailed);
end;
{$ELSEIF defined(POSIX)}
begin
  Result := UCS4CompareText(UnicodeStringToUCS4String(S1),
    UnicodeStringToUCS4String(S2));
end;
{$ENDIF}

function AnsiSameText(const S1, S2: string): Boolean;
begin
  Result := AnsiCompareText(S1, S2) = 0;
end;

{$IFNDEF NEXTGEN}
function AnsiStrComp(S1, S2: PAnsiChar): Integer;
{$IFDEF MSWINDOWS}
begin
  Result := CompareStringA(LOCALE_USER_DEFAULT, 0, S1, -1, S2, -1) - CSTR_EQUAL;
end;
{$ENDIF}
{$IFDEF POSIX}
{$IFDEF MACOS}
begin
  Result := AnsiCompareStr(string(S1), string(S2));
end;
{$ELSE}
begin
  Result := strcoll_l(PAnsiChar(UTF8String(S1)), PAnsiChar(UTF8String(S2)), UTF8CompareLocale);
end;
{$ENDIF MACOS}
{$ENDIF POSIX}
{$ENDIF !NEXTGEN}

function AnsiStrComp(S1, S2: PWideChar): Integer;
{$IFDEF MSWINDOWS}
begin
  Result := CompareStringW(LOCALE_USER_DEFAULT, 0, S1, -1, S2, -1) - CSTR_EQUAL;
end;
{$ENDIF}
{$IFDEF MACOS}
var
  StringRef1: CFStringRef;
  StringRef2: CFStringRef;
begin
  Result := -1;
  StringRef1 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, S1,
    StrLen(S1), kCFAllocatorNull);
  if StringRef1 <> nil then
  try
    StringRef2 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, S2,
      StrLen(S2), kCFAllocatorNull);
    if StringRef2 <> nil then
    try
      Result := CFStringCompareWithOptionsAndLocale(StringRef1, StringRef2,
        CFRangeMake(0, StrLen(S1)), 0, UTF8CompareLocale);
    finally
      CFRelease(StringRef2);
    end else
      raise ECFError.Create(SCFStringFailed);
  finally
    CFRelease(StringRef1);
  end else
    raise ECFError.Create(SCFStringFailed);
end;
{$ELSEIF defined(POSIX)}
begin
  Result := UCS4CompareStr(WideCharToUCS4String(S1), WideCharToUCS4String(S2));
end;
{$ENDIF POSIX}

{$IFNDEF NEXTGEN}
function AnsiStrIComp(S1, S2: PAnsiChar): Integer;
{$IFDEF MSWINDOWS}
begin
  Result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE, S1, -1,
    S2, -1) - CSTR_EQUAL;
end;
{$ENDIF}
{$IFDEF POSIX}
begin
  Result := AnsiCompareText(string(S1), string(S2));
end;
{$ENDIF POSIX}
{$ENDIF !NEXTGEN}

function AnsiStrIComp(S1, S2: PWideChar): Integer;
{$IFDEF MSWINDOWS}
begin
  Result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE, S1, -1,
    S2, -1) - CSTR_EQUAL;
end;
{$ENDIF}
{$IFDEF MACOS}
var
  StringRef1: CFStringRef;
  StringRef2: CFStringRef;
begin
  Result := -1;
  StringRef1 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, S1,
    StrLen(S1), kCFAllocatorNull);
  if StringRef1 <> nil then
  try
    StringRef2 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, S2,
      StrLen(S2), kCFAllocatorNull);
    if StringRef2 <> nil then
    try
      Result := CFStringCompareWithOptionsAndLocale(StringRef1, StringRef2,
        CFRangeMake(0, StrLen(S1)), kCFCompareCaseInsensitive, UTF8CompareLocale);
    finally
      CFRelease(StringRef2);
    end else
      raise ECFError.Create(SCFStringFailed);
  finally
    CFRelease(StringRef1);
  end else
    raise ECFError.Create(SCFStringFailed);
end;
{$ELSEIF defined(POSIX)}
begin
  Result := UCS4CompareText(WideCharToUCS4String(S1), WideCharToUCS4String(S2));
end;
{$ENDIF}

{$IFDEF POSIX}
{$IFNDEF NEXTGEN}
// StrLenLimit:  Scan Src for a null terminator up to MaxLen bytes
function StrLenLimit(Src: PAnsiChar; MaxLen: Cardinal): Cardinal; overload;
begin
  if Src = nil then
  begin
    Result := 0;
    Exit;
  end;
  Result := MaxLen;
  while (Src^ <> #0) and (Result > 0) do
  begin
    Inc(Src);
    Dec(Result);
  end;
  Result := MaxLen - Result;
end;
{$ENDIF !NEXTGEN}

// mhowe - duplicated code with PWideChar - would prefer to use Generics (ie one set of code) will investigate
// StrLenLimit:  Scan Src for a null terminator up to MaxLen bytes
function StrLenLimit(Src: PWideChar; MaxLen: Cardinal): Cardinal; overload;
begin
  if Src = nil then
  begin
    Result := 0;
    Exit;
  end;
  Result := MaxLen;
  while (Src^ <> #0) and (Result > 0) do
  begin
    Inc(Src);
    Dec(Result);
  end;
  Result := MaxLen - Result;
end;

{ StrBufLimit: Return a pointer to a buffer that contains no more than MaxLen
  bytes of Src, avoiding heap allocation if possible.
  If clipped Src length is less than MaxLen, return Src.  Allocated = False.
  If clipped Src length is less than StaticBufLen, return StaticBuf with a
    copy of Src.  Allocated = False.
  Otherwise, return a heap allocated buffer with a copy of Src.  Allocated = True.
}
{$IFNDEF NEXTGEN}
function StrBufLimit(Src: PAnsiChar; MaxLen: Cardinal; StaticBuf: PAnsiChar;
  StaticBufLen: Cardinal): PAnsiChar; overload;
var
  Len: Cardinal;
begin
  Len := StrLenLimit(Src, MaxLen);
  if Len < MaxLen then
    Result := Src
  else
  begin
    if Len < StaticBufLen then
      Result := StaticBuf
    else
    begin
      GetMem(Result, Len+1);
    end;
    Move(Src^, Result^, Len);
    Result[Len] := #0;
  end;
end;
{$ENDIF !NEXTGEN}

// mhowe - duplicated code with PWideChar - would prefer to use Generics (ie one set of code) will investigate
function StrBufLimit(Src: PWideChar; MaxLen: Cardinal; StaticBuf: PWideChar;
  StaticBufLen: Cardinal): PWideChar; overload;
var
  Len: Cardinal;
begin
  Len := StrLenLimit(Src, MaxLen);
  if Len < MaxLen then
    Result := Src
  else
  begin
    if Len < StaticBufLen then
      Result := StaticBuf
    else
    begin
      GetMem(Result, Len*SizeOf(WideChar) + SizeOf(WideChar));
    end;
    Move(Src^, Result^, Len*SizeOf(WideChar));
    Result[Len] := #0;
  end;
end;

{$IFNDEF NEXTGEN}
function InternalAnsiStrLComp(S1, S2: PAnsiChar; MaxLen: Cardinal; CaseSensitive: Boolean): Integer; overload;
var
  Buf1, Buf2: array [0..4095] of AnsiChar;
  P1, P2: PAnsiChar;
begin
  // glibc has no length-limited strcoll!
  P1 := nil;
  P2 := nil;
  try
    P1 := StrBufLimit(S1, MaxLen, Buf1, High(Buf1));
    P2 := StrBufLimit(S2, MaxLen, Buf2, High(Buf2));
    if CaseSensitive then
      Result := AnsiStrComp(P1, P2)
    else
      Result := AnsiStrIComp(P1, P2);
  finally
    if P1 <> @Buf1 then
      FreeMem(P1);
    if P2 <> @Buf2 then
      FreeMem(P2);
  end;
end;
{$ENDIF !NEXTGEN}

// mhowe - duplicated code with PWideChar - would prefer to use Generics (ie one set of code) will investigate
function InternalAnsiStrLComp(S1, S2: PWideChar; MaxLen: Cardinal; CaseSensitive: Boolean): Integer; overload;
var
  Buf1, Buf2: array [0..4095] of WideChar;
  P1, P2: PWideChar;
begin
  // glibc has no length-limited strcoll!
  P1 := nil;
  P2 := nil;
  try
    P1 := StrBufLimit(S1, MaxLen, Buf1, High(Buf1));
    P2 := StrBufLimit(S2, MaxLen, Buf2, High(Buf2));
    if CaseSensitive then
      Result := AnsiStrComp(P1, P2)
    else
      Result := AnsiStrIComp(P1, P2);
  finally
    if P1 <> @Buf1 then
      FreeMem(P1);
    if P2 <> @Buf2 then
      FreeMem(P2);
  end;
end;
{$ENDIF POSIX}

{$IFNDEF NEXTGEN}
function AnsiStrLComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := CompareStringA(LOCALE_USER_DEFAULT, 0,
    S1, MaxLen, S2, MaxLen) - CSTR_EQUAL;
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalAnsiStrLComp(S1, S2, MaxLen, True);
{$ENDIF}
end;
{$ENDIF !NEXTGEN}

function AnsiStrLComp(S1, S2: PWideChar; MaxLen: Cardinal): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := CompareStringW(LOCALE_USER_DEFAULT, 0,
    S1, MaxLen, S2, MaxLen) - CSTR_EQUAL;
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalAnsiStrLComp(S1, S2, MaxLen, True);
{$ENDIF}
end;

{$IFNDEF NEXTGEN}
function AnsiStrLIComp(S1, S2: PAnsiChar; MaxLen: Cardinal): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
    S1, MaxLen, S2, MaxLen) - CSTR_EQUAL;
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalAnsiStrLComp(S1, S2, MaxLen, False);
{$ENDIF}
end;
{$ENDIF !NEXTGEN}

function AnsiStrLIComp(S1, S2: PWideChar; MaxLen: Cardinal): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
    S1, MaxLen, S2, MaxLen) - CSTR_EQUAL;
{$ENDIF}
{$IFDEF POSIX}
  Result := InternalAnsiStrLComp(S1, S2, MaxLen, False);
{$ENDIF}
end;

{$IFNDEF NEXTGEN}
function AnsiStrLower(Str: PAnsiChar): PAnsiChar;
{$IFDEF MSWINDOWS}
begin
  Result := CharLowerA(Str);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  Temp: PAnsiChar;
  M: TMarshaller;
begin
  Temp := M.AsAnsi(AnsiLowerCase(string(Str))).ToPointer;
  Move(Temp^, Str^, Length(Temp));
  Result := Str;
end;
{$ENDIF POSIX}
{$ENDIF !NEXTGEN}

function AnsiStrLower(Str: PWideChar): PWideChar;
{$IFDEF MSWINDOWS}
begin
  Result := CharLowerW(Str);
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
var
  MutableStringRef: CFMutableStringRef;
begin
  Result := Str;
  MutableStringRef := CFStringCreateMutableWithExternalCharactersNoCopy(kCFAllocatorDefault,
    Result, StrLen(Result), StrLen(Result), kCFAllocatorNull);
  if MutableStringRef <> nil then
  try
    CFStringLowercase(MutableStringRef, UTF8CompareLocale);
  finally
    CFRelease(MutableStringRef);
  end else
      raise ECFError.Create(SCFStringFailed);
end;
{$ELSEIF defined(POSIX)}
var
  Temp: UCS4String;
  Squish: string;
  I: Integer;
begin
  Temp := WideCharToUCS4String(Str);

  for I := 0 to Length(Temp) - 1 do
    Temp[I] := UCS4Char(towlower(wint_t(Temp[I])));
  Squish := UCS4StringToUnicodeString(Temp);

  if Cardinal(Squish.Length) > StrLen(Str) then
    raise ERangeError.CreateRes(@SRangeError);

  Move(PChar(Squish)^, Str^, Squish.Length*SizeOf(WideChar));
  Result := Str;
end;
{$ENDIF !POSIX}

{$IFNDEF NEXTGEN}
function AnsiStrUpper(Str: PAnsiChar): PAnsiChar;
{$IFDEF MSWINDOWS}
begin
  Result := CharUpperA(Str);
end;
{$ENDIF}
{$IFDEF POSIX}
var
  Temp: PAnsiChar;
  M: TMarshaller;
begin
  Temp := M.AsAnsi(AnsiUpperCase(string(Str))).ToPointer;
  Move(Temp^, Str^, Length(Temp));
  Result := Str;
end;
{$ENDIF POSIX}
{$ENDIF !NEXTGEN}

function AnsiStrUpper(Str: PWideChar): PWideChar;
{$IFDEF MSWINDOWS}
begin
  Result := CharUpperW(Str);
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
var
  MutableStringRef: CFMutableStringRef;
begin
  Result := Str;
  MutableStringRef := CFStringCreateMutableWithExternalCharactersNoCopy(kCFAllocatorDefault,
    Result, StrLen(Result), StrLen(Result), kCFAllocatorNull);
  if MutableStringRef <> nil then
  try
    CFStringUppercase(MutableStringRef, UTF8CompareLocale);
  finally
    CFRelease(MutableStringRef);
  end else
      raise ECFError.Create(SCFStringFailed);
end;
{$ELSEIF defined(POSIX)}
var
  Temp: UCS4String;
  Squish: string;
  I: Integer;
begin
  Temp := WideCharToUCS4String(Str);

  for I := 0 to Length(Temp) - 1 do
    Temp[I] := UCS4Char(towupper(wint_t(Temp[I])));
  Squish := UCS4StringToUnicodeString(Temp);

  if Cardinal(Squish.Length) > StrLen(Str) then
    raise ERangeError.CreateRes(@SRangeError);

  Move(PChar(Squish)^, Str^, Squish.Length*SizeOf(WideChar));
  Result := Str;
end;
{$ENDIF !POSIX}

{$IFNDEF NEXTGEN}
function WideUpperCase(const S: WideString): WideString;
{$IFDEF MSWINDOWS}
var
  Len: Integer;
begin
  Len := Length(S);
  SetString(Result, PWideChar(S), Len);
  if Len > 0 then CharUpperBuffW(Pointer(Result), Len);
end;
{$ENDIF}
{$IFDEF POSIX}
{$IFDEF MACOS}
begin
  Result := WideString(AnsiUpperCase(string(S)));
end;
{$ELSE}
begin
  Result := UCS4StringToWideString(UCS4UpperCase(WideStringToUCS4String(S)));
end;
{$ENDIF MACOS}
{$ENDIF POSIX}

function WideLowerCase(const S: WideString): WideString;
{$IFDEF MSWINDOWS}
var
  Len: Integer;
begin
  Len := Length(S);
  SetString(Result, PWideChar(S), Len);
  if Len > 0 then CharLowerBuffW(Pointer(Result), Len);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
{$IFDEF MACOS}
begin
  Result := WideString(AnsiLowerCase(string(S)));
end;
{$ELSE}
begin
  Result := UCS4StringToWideString(UCS4LowerCase(WideStringToUCS4String(S)));
end;
{$ENDIF MACOS}
{$ENDIF POSIX}

function WideCompareStr(const S1, S2: WideString): Integer;
{$IFDEF MSWINDOWS}
begin
  SetLastError(0);
  Result := CompareStringW(LOCALE_USER_DEFAULT, 0, PWideChar(S1), Length(S1),
    PWideChar(S2), Length(S2)) - CSTR_EQUAL;
  if GetLastError <> 0 then
    RaiseLastOSError;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
{$IFDEF MACOS}
begin
  Result := AnsiCompareStr(string(S1), string(S2));
end;
{$ELSE}
begin
  Result := UCS4CompareStr(WideStringToUCS4String(S1),
    WideStringToUCS4String(S2));
end;
{$ENDIF MACOS}
{$ENDIF POSIX}

function WideSameStr(const S1, S2: WideString): Boolean;
begin
  Result := WideCompareStr(S1, S2) = 0;
end;

function WideCompareText(const S1, S2: WideString): Integer;
{$IFDEF MSWINDOWS}
begin
  SetLastError(0);
  Result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE, PWideChar(S1),
    Length(S1), PWideChar(S2), Length(S2)) - CSTR_EQUAL;
  if GetLastError <> 0 then
    RaiseLastOSError;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
{$IFDEF MACOS}
begin
  Result := AnsiCompareText(string(S1), string(S2));
end;
{$ELSE}
begin
  Result := UCS4CompareText(WideStringToUCS4String(S1),
    WideStringToUCS4String(S2));
end;
{$ENDIF MACOS}
{$ENDIF POSIX}

function WideSameText(const S1, S2: WideString): Boolean;
begin
  Result := WideCompareText(S1, S2) = 0;
end;
{$ENDIF !NEXTGEN}

function Trim(const S: string): string;
var
  I, L: Integer;
begin
  L := S.Length - 1;
  I := 0;
  if (L > -1) and (S.Chars[I] > ' ') and (S.Chars[L] > ' ') then Exit(S);
  while (I <= L) and (S.Chars[I] <= ' ') do Inc(I);
  if I > L then Exit('');
  while S.Chars[L] <= ' ' do Dec(L);
  Result := S.SubString(I, L - I + 1);
end;

function TrimLeft(const S: string): string;
begin
  Result := S.TrimLeft;
end;

function TrimRight(const S: string): string;
begin
  Result := S.TrimRight;
end;

function QuotedStr(const S: string): string;
var
  I: Integer;
begin
  Result := S;
  for I := Result.Length - 1 downto 0 do
    if Result.Chars[I] = '''' then Result := Result.Insert(I, '''');
  Result := '''' + Result + '''';
end;

function AnsiQuotedStr(const S: string; Quote: Char): string;
var
  P, Src, Dest: PChar;
  AddCount: Integer;
begin
  AddCount := 0;
  P := AnsiStrScan(PChar(S), Quote);
  while P <> nil do
  begin
    Inc(P);
    Inc(AddCount);
    P := AnsiStrScan(P, Quote);
  end;
  if AddCount = 0 then
  begin
    Result := Quote + S + Quote;
    Exit;
  end;
  SetLength(Result, Length(S) + AddCount + 2);
  Dest := PChar(Result);
  Dest^ := Quote;
  Inc(Dest);
  Src := PChar(S);
  P := AnsiStrScan(Src, Quote);
  repeat
    Inc(P);
    Move(Src^, Dest^, (P - Src) * SizeOf(Char));
    Inc(Dest, P - Src);
    Dest^ := Quote;
    Inc(Dest);
    Src := P;
    P := AnsiStrScan(Src, Quote);
  until P = nil;
  P := StrEnd(Src);
  Move(Src^, Dest^, (P - Src) * SizeOf(Char));
  Inc(Dest, P - Src);
  Dest^ := Quote;
end;

{$IFNDEF NEXTGEN}
function AnsiExtractQuotedStr(var Src: PAnsiChar; Quote: AnsiChar): AnsiString;
var
  P, Dest: PAnsiChar;
  DropCount: Integer;
  EndSuffix: Integer;
begin
  Result := '';
  if (Src = nil) or (Src^ <> Quote) then Exit;
  Inc(Src);
  DropCount := 1;
  P := Src;
  Src := AnsiStrScan(Src, Quote);
  while Src <> nil do   // count adjacent pairs of quote chars
  begin
    Inc(Src);
    if Src^ <> Quote then Break;
    Inc(Src);
    Inc(DropCount);
    Src := AnsiStrScan(Src, Quote);
  end;
  EndSuffix := Ord(Src = nil); // Has an ending quoatation mark?
  if Src = nil then Src := StrEnd(P);
  if ((Src - P) <= 1 - EndSuffix) or ((Src - P - DropCount) = EndSuffix) then Exit;
  if DropCount = 1 then
    SetString(Result, P, Src - P - 1 + EndSuffix)
  else
  begin
    SetLength(Result, Src - P - DropCount + EndSuffix);
    Dest := PAnsiChar(Result);
    Src := AnsiStrScan(P, Quote);
    while Src <> nil do
    begin
      Inc(Src);
      if Src^ <> Quote then Break;
      Move(P^, Dest^, Src - P);
      Inc(Dest, Src - P);
      Inc(Src);
      P := Src;
      Src := AnsiStrScan(Src, Quote);
    end;
    if Src = nil then Src := StrEnd(P);
    Move(P^, Dest^, Src - P - 1 + EndSuffix);
  end;
end;
{$ENDIF !NEXTGEN}

function AnsiExtractQuotedStr(var Src: PWideChar; Quote: WideChar): UnicodeString;
var
  P, Dest: PWideChar;
  DropCount: Integer;
  EndSuffix: Integer;
begin
  Result := '';
  if (Src = nil) or (Src^ <> Quote) then Exit;
  Inc(Src);
  DropCount := 1;
  P := Src;
  Src := AnsiStrScan(Src, Quote);
  while Src <> nil do   // count adjacent pairs of quote chars
  begin
    Inc(Src);
    if Src^ <> Quote then Break;
    Inc(Src);
    Inc(DropCount);
    Src := AnsiStrScan(Src, Quote);
  end;
  EndSuffix := Ord(Src = nil); // Has an ending quoatation mark?
  if Src = nil then Src := StrEnd(P);
  if ((Src - P) <= 1 - EndSuffix) or ((Src - P - DropCount) = EndSuffix) then Exit;
  if DropCount = 1 then
    SetString(Result, P, Src - P - 1 + EndSuffix)
  else
  begin
    SetLength(Result, Src - P - DropCount + EndSuffix);
    Dest := PWideChar(Result);
    Src := AnsiStrScan(P, Quote);
    while Src <> nil do
    begin
      Inc(Src);
      if Src^ <> Quote then Break;
      Move(P^, Dest^, (Src - P) * SizeOf(Char));
      Inc(Dest, Src - P);
      Inc(Src);
      P := Src;
      Src := AnsiStrScan(Src, Quote);
    end;
    if Src = nil then Src := StrEnd(P);
    Move(P^, Dest^, (Src - P - 1 + EndSuffix) * SizeOf(Char));
  end;
end;

function AnsiDequotedStr(const S: string; AQuote: Char): string;
var
  LText: PChar;
begin
  LText := PChar(S);
  Result := AnsiExtractQuotedStr(LText, AQuote);
  if ((Result = '') or (LText^ = #0)) and
     (S.Length > 0) and ((S[Low(S)] <> AQuote) or (S[High(S)] <> AQuote)) then
    Result := S;
end;

function AdjustLineBreaks(const S: string; Style: TTextLineBreakStyle): string;
var
  Source, SourceEnd, Dest: PChar;
  DestLen: Integer;
begin
  Source := Pointer(S);
  SourceEnd := Source + Length(S);
  DestLen := Length(S);
  while Source < SourceEnd do
  begin
    case Source^ of
      #10:
        if Style = tlbsCRLF then
          Inc(DestLen);
      #13:
        if Style = tlbsCRLF then
          if Source[1] = #10 then
            Inc(Source)
          else
            Inc(DestLen)
        else
          if Source[1] = #10 then
            Dec(DestLen);
    end;
    Inc(Source);
  end;
  if DestLen = Length(Source) then
    Result := S
  else
  begin
    Source := Pointer(S);
    SetString(Result, nil, DestLen);
    Dest := Pointer(Result);
    while Source < SourceEnd do
      case Source^ of
        #10:
          begin
            if Style = tlbsCRLF then
            begin
              Dest^ := #13;
              Inc(Dest);
            end;
            Dest^ := #10;
            Inc(Dest);
            Inc(Source);
          end;
        #13:
          begin
            if Style = tlbsCRLF then
            begin
              Dest^ := #13;
              Inc(Dest);
            end;
            Dest^ := #10;
            Inc(Dest);
            Inc(Source);
            if Source^ = #10 then Inc(Source);
          end;
      else
        Dest^ := Source^;
        Inc(Dest);
        Inc(Source);
      end;
  end;
end;

function IsValidIdent(const Ident: string; AllowDots: Boolean): Boolean;
{$IFNDEF UNICODE}
const
  Alpha = ['A'..'Z', 'a'..'z', '_'];
  AlphaNumeric = Alpha + ['0'..'9'];
  AlphaNumericDot = AlphaNumeric + ['.'];
var
  I: Integer;
begin
  Result := False;
  if (Ident.Length = 0) or not (Ident[Low(string)] in Alpha) then Exit;
  if AllowDots then
    for I := Low(string) + 1 to High(Ident) do
      begin
        if not (Ident[I] in AlphaNumericDot) then Exit
      end
  else
    for I := Low(string) + 1 to High(Ident) do if not (Ident[I] in AlphaNumeric) then Exit;
  Result := True;
end;
{$ELSE UNICODE}
  function Alpha(C: Char): Boolean; inline;
  begin
    Result := C.IsLetter or (C = '_');
  end;

  function AlphaNumeric(C: Char): Boolean; inline;
  begin
    Result := C.IsLetterOrDigit or (C = '_');
  end;

  function AlphaNumericDot(C: Char): Boolean; inline;
  begin
    Result := C.IsLetterOrDigit or (C = '_') or (C = '.');
  end;

var
  I: Integer;
begin
  Result := False;
  if (Ident.Length = 0) or not Alpha(Ident[Low(Ident)]) then
    Exit;
  if AllowDots then
    for I := (Low(string) + 1) to High(Ident) do
      begin
        if not AlphaNumericDot(Ident[I]) then
          Exit
      end
  else
    for I := Low(string) + 1 to High(Ident) do
      if not AlphaNumeric(Ident[I]) then
        Exit;
  Result := True;
end;
{$ENDIF UNICODE}

{$IFDEF X86ASM}
procedure CvtInt;
{ IN:
    EAX:  The integer value to be converted to text
    ESI:  Ptr to the right-hand side of the output buffer:  LEA ESI, StrBuf[16]
    ECX:  Base for conversion: 0 for signed decimal, 10 or 16 for unsigned
    EDX:  Precision: zero padded minimum field width
  OUT:
    ESI:  Ptr to start of converted text (not start of buffer)
    ECX:  Length of converted text
}
asm // StackAlignSafe
        OR      CL,CL
        JNZ     @CvtLoop
@C1:    OR      EAX,EAX
        JNS     @C2
        NEG     EAX
        CALL    @C2
        MOV     AL,'-'
        INC     ECX
        DEC     ESI
        MOV     [ESI],AL
        RET
@C2:    MOV     ECX,10

@CvtLoop:
        PUSH    EDX
        PUSH    ESI
@D1:    XOR     EDX,EDX
        DIV     ECX
        DEC     ESI
        ADD     DL,'0'
        CMP     DL,'0'+10
        JB      @D2
        ADD     DL,('A'-'0')-10
@D2:    MOV     [ESI],DL
        OR      EAX,EAX
        JNE     @D1
        POP     ECX
        POP     EDX
        SUB     ECX,ESI
        SUB     EDX,ECX
        JBE     @D5
        ADD     ECX,EDX
        MOV     AL,'0'
        SUB     ESI,EDX
        JMP     @z
@zloop: MOV     [ESI+EDX],AL
@z:     DEC     EDX
        JNZ     @zloop
        MOV     [ESI],AL
@D5:
end;
{$ENDIF X86ASM}

{$IFDEF X86ASM}
procedure CvtIntW;
{ IN:
    EAX:  The integer value to be converted to text
    ESI:  Ptr to the right-hand side of the widechar output buffer:  LEA ESI, WStrBuf[32]
    ECX:  Base for conversion: 0 for signed decimal, 10 or 16 for unsigned
    EDX:  Precision: zero padded minimum field width
  OUT:
    ESI:  Ptr to start of converted widechar text (not start of buffer)
    ECX:  Character length of converted text
}
asm  // StackAlignSafe
        OR      CL,CL
        JNZ     @CvtLoop
@C1:    OR      EAX,EAX
        JNS     @C2
        NEG     EAX
        CALL    @C2
        MOV     AX,'-'
        MOV     [ESI-2],AX
        SUB     ESI, 2
        INC     ECX
        RET
@C2:    MOV     ECX,10

@CvtLoop:
        PUSH    EDX
        PUSH    ESI
@D1:    XOR     EDX,EDX
        DIV     ECX
        ADD     DX,'0'
        SUB     ESI,2
        CMP     DX,'0'+10
        JB      @D2
        ADD     DX,('A'-'0')-10
@D2:    MOV     [ESI],DX
        OR      EAX,EAX
        JNE     @D1
        POP     ECX
        POP     EDX
        SUB     ECX,ESI
        SHR     ECX, 1
        SUB     EDX,ECX
        JBE     @D5
        ADD     ECX,EDX
        SUB     ESI,EDX
        MOV     AX,'0'
        SUB     ESI,EDX
        JMP     @z
@zloop: MOV     [ESI+EDX*2],AX
@z:     DEC     EDX
        JNZ     @zloop
        MOV     [ESI],AX
@D5:
end;
{$ENDIF X86ASM}

                                                              
const
  TwoDigitLookup : packed array[0..99] of array[1..2] of Char =
    ('00','01','02','03','04','05','06','07','08','09',
     '10','11','12','13','14','15','16','17','18','19',
     '20','21','22','23','24','25','26','27','28','29',
     '30','31','32','33','34','35','36','37','38','39',
     '40','41','42','43','44','45','46','47','48','49',
     '50','51','52','53','54','55','56','57','58','59',
     '60','61','62','63','64','65','66','67','68','69',
     '70','71','72','73','74','75','76','77','78','79',
     '80','81','82','83','84','85','86','87','88','89',
     '90','91','92','93','94','95','96','97','98','99');
const
  TwoHexLookup : packed array[0..255] of array[1..2] of Char =
  ('00','01','02','03','04','05','06','07','08','09','0A','0B','0C','0D','0E','0F',
   '10','11','12','13','14','15','16','17','18','19','1A','1B','1C','1D','1E','1F',
   '20','21','22','23','24','25','26','27','28','29','2A','2B','2C','2D','2E','2F',
   '30','31','32','33','34','35','36','37','38','39','3A','3B','3C','3D','3E','3F',
   '40','41','42','43','44','45','46','47','48','49','4A','4B','4C','4D','4E','4F',
   '50','51','52','53','54','55','56','57','58','59','5A','5B','5C','5D','5E','5F',
   '60','61','62','63','64','65','66','67','68','69','6A','6B','6C','6D','6E','6F',
   '70','71','72','73','74','75','76','77','78','79','7A','7B','7C','7D','7E','7F',
   '80','81','82','83','84','85','86','87','88','89','8A','8B','8C','8D','8E','8F',
   '90','91','92','93','94','95','96','97','98','99','9A','9B','9C','9D','9E','9F',
   'A0','A1','A2','A3','A4','A5','A6','A7','A8','A9','AA','AB','AC','AD','AE','AF',
   'B0','B1','B2','B3','B4','B5','B6','B7','B8','B9','BA','BB','BC','BD','BE','BF',
   'C0','C1','C2','C3','C4','C5','C6','C7','C8','C9','CA','CB','CC','CD','CE','CF',
   'D0','D1','D2','D3','D4','D5','D6','D7','D8','D9','DA','DB','DC','DD','DE','DF',
   'E0','E1','E2','E3','E4','E5','E6','E7','E8','E9','EA','EB','EC','ED','EE','EF',
   'F0','F1','F2','F3','F4','F5','F6','F7','F8','F9','FA','FB','FC','FD','FE','FF');

function _IntToStr32(Value: Cardinal; Negative: Boolean): string;
var
  I, J, K : Cardinal;
  Digits  : Integer;
  P       : PChar;
  NewLen  : Integer;
begin
  I := Value;
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  SetLength(Result, NewLen);
  P := PChar(Result);
  P^ := '-';
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      J  := I div 100;           {Dividend div 100}
      K  := J * 100;
      K  := I - K;               {Dividend mod 100}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PDWord(P + Digits)^ := DWord(TwoDigitLookup[K]);
    until Digits <= 2;
  if Digits = 2 then
    PDWord(P+ Digits-2)^ := DWord(TwoDigitLookup[I])
  else
    PChar(P)^ := Char(I or ord('0'));
end;

function _IntToStr64(Value: UInt64; Negative: Boolean): string;
var
  I64, J64, K64      : UInt64;
  I32, J32, K32, L32 : Cardinal;
  Digits             : Byte;
  P                  : PChar;
  NewLen             : Integer;
begin
  {Within Integer Range - Use Faster Integer Version}
  if (Negative and (Value <= High(Integer))) or
     (not Negative and (Value <= High(Cardinal))) then
    Exit(_IntToStr32(Value, Negative));

  I64 := Value;
  if I64 >= 100000000000000 then
    if I64 >= 10000000000000000 then
      if I64 >= 1000000000000000000 then
        if I64 >= 10000000000000000000 then
          Digits := 20
        else
          Digits := 19
      else
        Digits := 17 + Ord(I64 >= 100000000000000000)
    else
      Digits := 15 + Ord(I64 >= 1000000000000000)
  else
    if I64 >= 1000000000000 then
      Digits := 13 + Ord(I64 >= 10000000000000)
    else
      if I64 >= 10000000000 then
        Digits := 11 + Ord(I64 >= 100000000000)
      else
        Digits := 10;
  NewLen  := Digits + Ord(Negative);
  SetLength(Result, NewLen);
  P := PChar(Result);
  P^ := '-';
  Inc(P, Ord(Negative));
  if Digits = 20 then
  begin
    P^ := '1';
    Inc(P);
    Dec(I64, 10000000000000000000);
    Dec(Digits);
  end;
  if Digits > 17 then
  begin {18 or 19 Digits}
    if Digits = 19 then
    begin
      P^ := '0';
      while I64 >= 1000000000000000000 do
      begin
        Dec(I64, 1000000000000000000);
        Inc(P^);
      end;
      Inc(P);
    end;
    P^ := '0';
    while I64 >= 100000000000000000 do
    begin
      Dec(I64, 100000000000000000);
      Inc(P^);
    end;
    Inc(P);
    Digits := 17;
  end;
  J64 := I64 div 100000000;
  K64 := I64 - (J64 * 100000000); {Remainder = 0..99999999}
  I32 := K64;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  PDWord(P + Digits - 2)^ := DWord(TwoDigitLookup[K32]);
  I32 := J32 div 100;
  L32 := I32 * 100;
  L32 := J32 - L32;
  PDWord(P + Digits - 4)^ := DWord(TwoDigitLookup[L32]);
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  PDWord(P + Digits - 6)^ := DWord(TwoDigitLookup[K32]);
  PDWord(P + Digits - 8)^ := DWord(TwoDigitLookup[J32]);
  Dec(Digits, 8);
  I32 := J64; {Dividend now Fits within Integer - Use Faster Version}
  if Digits > 2 then
    repeat
      J32 := I32 div 100;
      K32 := J32 * 100;
      K32 := I32 - K32;
      I32 := J32;
      Dec(Digits, 2);
      PDWord(P + Digits)^ := DWord(TwoDigitLookup[K32]);
    until Digits <= 2;
  if Digits = 2 then
    PDWord(P + Digits-2)^ := DWord(TwoDigitLookup[I32])
  else
    P^ := Char(I32 or ord('0'));
end;

function IntToStr(Value: Integer): string;
begin
  if Value < 0 then
    Result := _IntToStr32(-Value, True)
  else
    Result := _IntToStr32(Value, False);
end;

function IntToStr(Value: Int64): string;
begin
  if Value < 0 then
    Result := _IntToStr64(-Value, True)
  else
    Result := _IntToStr64(Value, False);
end;

function UIntToStr(Value: Cardinal): string;
begin
  Result := _IntToStr32(Value, False);
end;

function UIntToStr(Value: UInt64): string;
begin
  Result := _IntToStr64(Value, False);
end;

function _IntToHex(Value: UInt64; Digits: Integer): string;
var
  I32    : Integer;
  I, J   : UInt64;
  P      : Integer;
  NewLen : Integer;
  Sb     : TCharArray;
begin
  NewLen := 1;
  I := Value shr 4;
  while I > 0 do
  begin
    Inc(NewLen);
    I := I shr 4;
  end;
  if Digits > NewLen then
  begin
    SetLength(Sb, Digits);
    for I32 := 0 to (Digits - NewLen) - 1 do
      Sb[I32] := '0';
    P := Digits - NewLen;
  end
  else
  begin
    SetLength(Sb, NewLen);
    P := 0;
  end;
  I := Value;
  while NewLen > 2 do
  begin
    J := I and $FF;
    I := I shr 8;
    Dec(NewLen, 2);
    Sb[P + NewLen] := TwoHexLookup[J][1];
    Sb[P + NewLen + 1] := TwoHexLookup[J][2];

  end;
  if NewLen = 2 then
  begin
    Sb[P] := TwoHexLookup[I][1];
    Sb[P+1] := TwoHexLookup[I][2];
  end
  else
    Sb[P] := TwoHexLookup[I][2];

  Result := String.Create(Sb);
end;

function IntToHex(Value: Integer; Digits: Integer): string;
begin
  Result := _IntToHex(Cardinal(Value), Digits);
end;

function IntToHex(Value: Int64; Digits: Integer): string;
begin
  Result := _IntToHex(Value, digits);
end;

function IntToHex(Value: UInt64; Digits: Integer): string;
begin
  Result := _IntToHex(Value, digits);
end;

{$IFDEF X86ASM}
procedure CvtInt64W;
{ IN:
    EAX:  Address of the int64 value to be converted to text
    ESI:  Ptr to the right-hand side of the widechar output buffer:  LEA ESI, WStrBuf[32]
    ECX:  Base for conversion: 10 or 16
    EDX:  Precision: zero padded minimum field width
  OUT:
    ESI:  Ptr to start of converted widechar text (not start of buffer)
    ECX:  Character length of converted text
}
asm  // StackAlignSafe
        OR      CL, CL
        JNZ     @start
        MOV     ECX, 10
        TEST    [EAX + 4], $80000000
        JZ      @start
        PUSH    [EAX + 4]
        PUSH    [EAX]
        MOV     EAX, ESP
        NEG     [ESP]              // negate the value
        ADC     [ESP + 4],0
        NEG     [ESP + 4]
        CALL    @start
        INC     ECX
        MOV     [ESI-2].Word, '-'
        SUB     ESI, 2
        ADD     ESP, 8
        JMP     @done

@start:
        PUSH    ESI
        SUB     ESP, 4
        FNSTCW  [ESP+2].Word       // save
        FNSTCW  [ESP].Word         // scratch
        OR      [ESP].Word, $0F00  // trunc toward zero, full precision
        FLDCW   [ESP].Word

        MOV     [ESP].Word, CX
        FLD1
        TEST    [EAX + 4], $80000000 // test for negative
        JZ      @ld1                 // FPU doesn't understand unsigned ints
        PUSH    [EAX + 4]            // copy value before modifying
        PUSH    [EAX]
        AND     [ESP + 4], $7FFFFFFF // clear the sign bit
        PUSH    $7FFFFFFF
        PUSH    $FFFFFFFF
        FILD    [ESP + 8].QWord     // load value
        FILD    [ESP].QWord
        FADD    ST(0), ST(2)        // Add 1.  Produces unsigned $80000000 in ST(0)
        FADDP   ST(1), ST(0)        // Add $80000000 to value to replace the sign bit
        ADD     ESP, 16
        JMP     @ld2
@ld1:
        FILD    [EAX].QWord         // value
@ld2:
        FILD    [ESP].Word          // base
        FLD     ST(1)
@loop:
        SUB     ESI, 2
        FPREM                       // accumulator mod base
        FISTP   [ESI].Word
        FDIV    ST(1), ST(0)        // accumulator := acumulator / base
        MOV     AX, [ESI].Word      // overlap long division op with int ops
        ADD     AX, '0'
        CMP     AX, '0'+10
        JB      @store
        ADD     AX, ('A'-'0')-10
@store:
        MOV     [ESI].Word, AX
        FLD     ST(1)           // copy accumulator
        FCOM    ST(3)           // if accumulator >= 1.0 then loop
        FSTSW   AX
        SAHF
        JAE @loop

        FLDCW   [ESP+2].Word
        ADD     ESP,4

        FFREE   ST(3)
        FFREE   ST(2)
        FFREE   ST(1);
        FFREE   ST(0);

@zeropad:
        POP     ECX             // original ESI
        SUB     ECX,ESI
        SHR     ECX, 1          // ECX = char length of converted string
        OR      EDX,EDX
        JS      @done
        SUB     EDX,ECX
        JBE     @done           // output longer than field width = no pad
        SUB     ESI,EDX
        MOV     AX,'0'
        SUB     ESI,EDX
        ADD     ECX,EDX
        JMP     @z
@zloop: MOV     [ESI+EDX*2].Word,AX
@z:     DEC     EDX
        JNZ     @zloop
        MOV     [ESI].Word,AX
@done:
end;
{$ENDIF X86ASM}

{$IFDEF X86ASM}
procedure CvtInt64;
{ IN:
    EAX:  Address of the int64 value to be converted to text
    ESI:  Ptr to the right-hand side of the output buffer:  LEA ESI, StrBuf[32]
    ECX:  Base for conversion: 0 for signed decimal, or 10 or 16 for unsigned
    EDX:  Precision: zero padded minimum field width
  OUT:
    ESI:  Ptr to start of converted text (not start of buffer)
    ECX:  Byte length of converted text
}
asm //StackAlignSafe
        OR      CL, CL
        JNZ     @start             // CL = 0  => signed integer conversion
        MOV     ECX, 10
        TEST    [EAX + 4], $80000000
        JZ      @start
        PUSH    [EAX + 4]
        PUSH    [EAX]
        MOV     EAX, ESP
        NEG     [ESP]              // negate the value
        ADC     [ESP + 4],0
        NEG     [ESP + 4]
        CALL    @start             // perform unsigned conversion
        MOV     [ESI-1].Byte, '-'  // tack on the negative sign
        DEC     ESI
        INC     ECX
        ADD     ESP, 8
        RET

@start:   // perform unsigned conversion
        PUSH    ESI
        SUB     ESP, 4
        FNSTCW  [ESP+2].Word     // save
        FNSTCW  [ESP].Word       // scratch
        OR      [ESP].Word, $0F00  // trunc toward zero, full precision
        FLDCW   [ESP].Word

        MOV     [ESP].Word, CX
        FLD1
        TEST    [EAX + 4], $80000000 // test for negative
        JZ      @ld1                 // FPU doesn't understand unsigned ints
        PUSH    [EAX + 4]            // copy value before modifying
        PUSH    [EAX]
        AND     [ESP + 4], $7FFFFFFF // clear the sign bit
        PUSH    $7FFFFFFF
        PUSH    $FFFFFFFF
        FILD    [ESP + 8].QWord     // load value
        FILD    [ESP].QWord
        FADD    ST(0), ST(2)        // Add 1.  Produces unsigned $80000000 in ST(0)
        FADDP   ST(1), ST(0)        // Add $80000000 to value to replace the sign bit
        ADD     ESP, 16
        JMP     @ld2
@ld1:
        FILD    [EAX].QWord         // value
@ld2:
        FILD    [ESP].Word          // base
        FLD     ST(1)
@loop:
        DEC     ESI
        FPREM                       // accumulator mod base
        FISTP   [ESP].Word
        FDIV    ST(1), ST(0)        // accumulator := acumulator / base
        MOV     AL, [ESP].Byte      // overlap long FPU division op with int ops
        ADD     AL, '0'
        CMP     AL, '0'+10
        JB      @store
        ADD     AL, ('A'-'0')-10
@store:
        MOV     [ESI].Byte, AL
        FLD     ST(1)           // copy accumulator
        FCOM    ST(3)           // if accumulator >= 1.0 then loop
        FSTSW   AX
        SAHF
        JAE @loop

        FLDCW   [ESP+2].Word
        ADD     ESP,4

        FFREE   ST(3)
        FFREE   ST(2)
        FFREE   ST(1);
        FFREE   ST(0);

        POP     ECX             // original ESI
        SUB     ECX, ESI        // ECX = length of converted string
        SUB     EDX,ECX
        JBE     @done           // output longer than field width = no pad
        SUB     ESI,EDX
        MOV     AL,'0'
        ADD     ECX,EDX
        JMP     @z
@zloop: MOV     [ESI+EDX].Byte,AL
@z:     DEC     EDX
        JNZ     @zloop
        MOV     [ESI].Byte,AL
@done:
end;
{$ENDIF X86ASM}

function StrToInt(const S: string): Integer;
var
  E: Integer;
begin
  Val(S, Result, E);
  if E <> 0 then ConvertErrorFmt(@System.SysConst.SInvalidInteger, [S]);
end;

function StrToIntDef(const S: string; Default: Integer): Integer;
var
  E: Integer;
begin
  Val(S, Result, E);
  if E <> 0 then Result := Default;
end;

function TryStrToInt(const S: string; out Value: Integer): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function StrToInt64(const S: string): Int64;
var
  E: Integer;
begin
  Val(S, Result, E);
  if E <> 0 then ConvertErrorFmt(@System.SysConst.SInvalidInteger, [S]);
end;

function StrToInt64Def(const S: string; const Default: Int64): Int64;
var
  E: Integer;
begin
  Val(S, Result, E);
  if E <> 0 then Result := Default;
end;

function TryStrToInt64(const S: string; out Value: Int64): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

{$IFDEF MACOS}
function StringToFileSystemString(const Source: string; var Dest: TBytes): Boolean;
var
  StringRef: CFStringRef;
begin
  StringRef := TCFString.Create(Source).Value;
  if StringRef = nil then
    Exit(False);
  try
    Result := CFStringGetFileSystemRepresentation(StringRef, @Dest[0], Length(Dest));
  finally
    CFRelease(StringRef);
  end;
end;

function FileSystemStringToString(const Source: MarshaledAString;
  var Dest: string): Boolean;
var
  StringRef: CFStringRef;
  MutableStringRef: CFMutableStringRef;
begin
  Result := False;
  StringRef := CFStringCreateWithFileSystemRepresentation(kCFAllocatorDefault, Source);
  if StringRef = nil then
    Exit;
  try
    MutableStringRef := CFStringCreateMutableCopy(kCFAllocatorDefault,
      CFStringGetLength(StringRef), StringRef);
  finally
    CFRelease(StringRef);
  end;
  if MutableStringRef = nil then
    Exit;
  try
    CFStringNormalize(MutableStringRef, kCFStringNormalizationFormKC);
    CFStringFold(MutableStringRef, kCFCompareLocalized, nil);
    Dest := TCFString(MutableStringRef).AsString;
    Result := True;
  finally
    CFRelease(MutableStringRef);
  end;
end;

{$ENDIF MACOS}

procedure VerifyBoolStrArray;
begin
  if Length(TrueBoolStrs) = 0 then
  begin
    SetLength(TrueBoolStrs, 1);
    TrueBoolStrs[0] := DefaultTrueBoolStr;
  end;
  if Length(FalseBoolStrs) = 0 then
  begin
    SetLength(FalseBoolStrs, 1);
    FalseBoolStrs[0] := DefaultFalseBoolStr;
  end;
end;

function StrToBool(const S: string): Boolean;
begin
  if not TryStrToBool(S, Result) then
    ConvertErrorFmt(@SInvalidBoolean, [S]);
end;

function StrToBoolDef(const S: string; const Default: Boolean): Boolean;
begin
  if not TryStrToBool(S, Result) then
    Result := Default;
end;

function TryStrToBool(const S: string; out Value: Boolean): Boolean;
  function CompareWith(const aArray: array of string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := Low(aArray) to High(aArray) do
      if AnsiSameText(S, aArray[I]) then
      begin
        Result := True;
        Break;
      end;
  end;
var
  LResult: Extended;
begin
  Result := TryStrToFloat(S, LResult);
  if Result then
    Value := LResult <> 0
  else
  begin
    VerifyBoolStrArray;
    Result := CompareWith(TrueBoolStrs);
    if Result then
      Value := True
    else
    begin
      Result := CompareWith(FalseBoolStrs);
      if Result then
        Value := False;
    end;
  end;
end;

function BoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;
const
  cSimpleBoolStrs: array [boolean] of String = ('0', '-1');
begin
  if UseBoolStrs then
  begin
    VerifyBoolStrArray;
    if B then
      Result := TrueBoolStrs[0]
    else
      Result := FalseBoolStrs[0];
  end
  else
    Result := cSimpleBoolStrs[B];
end;

type
  PStrData = ^TStrData;
  TStrData = record
    Ident: Integer;
    Str: string;
  end;

function EnumStringModules(Instance: HINST; Data: Pointer): Boolean;
{$IFDEF MSWINDOWS}
var
  Buffer: array [0..1023] of char;
begin
  SetString(PStrData(Data)^.Str, Buffer,
    LoadString(Instance, PStrData(Data)^.Ident, Buffer, Length(Buffer)));
  Result := PStrData(Data)^.Str = '';
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
{$IF defined(IOS) and defined(CPUARM)}
begin
                                                         
  Result := False;
end;
{$ELSE}
var
  rs: TResStringRec;
  Module: HModule;
begin
  Module := Instance;
  rs.Module := @Module;
  rs.Identifier := PStrData(Data)^.Ident;
  PStrData(Data)^.Str := LoadResString(@rs);
  Result := PStrData(Data)^.Str = '';
end;
{$ENDIF}
{$ENDIF POSIX}

function FindStringResource(Ident: NativeUInt): string;
var
  StrData: TStrData;
begin
  StrData.Ident := Ident;
  StrData.Str := '';
  EnumResourceModules(EnumStringModules, @StrData);
  Result := StrData.Str;
end;

{$IFNDEF NEXTGEN}
function LoadStr(Ident: NativeUInt): string;
begin
  Result := FindStringResource(Ident);
end;
{$ENDIF !NEXTGEN}

{$IFNDEF NEXTGEN}
function FmtLoadStr(Ident: NativeUInt; const Args: array of const): string;
begin
  FmtStr(Result, FindStringResource(Ident), Args);
end;
{$ENDIF !NEXTGEN}

{ File management routines }

function FileOpen(const FileName: string; Mode: LongWord): THandle;
{$IFDEF MSWINDOWS}
const
  AccessMode: array[0..2] of LongWord = (
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE);
  ShareMode: array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
begin
  Result := INVALID_HANDLE_VALUE;
  if ((Mode and 3) <= fmOpenReadWrite) and
    ((Mode and $F0) <= fmShareDenyNone) then
    Result := CreateFile(PChar(FileName), AccessMode[Mode and 3],
      ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING,
      FILE_ATTRIBUTE_NORMAL, 0);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
const
  ShareMode: array[0..fmShareDenyNone shr 4] of Byte = (
    0,        //No share mode specified
    F_WRLCK,  //fmShareExclusive
    F_RDLCK,  //fmShareDenyWrite
    0);       //fmShareDenyNone
var
  FileHandle, Tvar: Integer;
  LockVar: flock;
  smode: Byte;
  Code: Integer;
  M:TMarshaller;
begin
  Result := INVALID_HANDLE_VALUE;
  if FileExists(FileName) and
     ((Mode and 3) <= fmOpenReadWrite) and
     ((Mode and $F0) <= fmShareDenyNone) then
  begin
    FileHandle := __open(M.AsAnsi(FileName, CP_UTF8).ToPointer, (Mode and 3), FileAccessRights);
    if FileHandle = -1 then  Exit;

    smode := Mode and $F0 shr 4;
    if ShareMode[smode] <> 0 then
    begin
      LockVar.l_whence := SEEK_SET;
      LockVar.l_start := 0;
      LockVar.l_len := 0;
      LockVar.l_type := ShareMode[smode];
      Tvar := fcntl(FileHandle, F_SETLK, LockVar);
      Code := errno;
      if (Tvar = -1) and (Code <> EINVAL) and (Code <> ENOTSUP) then
      // EINVAL/ENOTSUP - file doesn't support locking!
      begin
        __close(FileHandle);
        Exit;
      end;
    end;
    Result := FileHandle;
  end;
end;
{$ENDIF POSIX}

function FileCreate(const FileName: string): THandle;
{$IFDEF MSWINDOWS}
begin
  Result := FileCreate(FileName, fmShareExclusive, 0);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := FileCreate(FileName, FileAccessRights);
end;
{$ENDIF POSIX}

function FileCreate(const FileName: string; Rights: Integer): THandle;
begin
  Result := FileCreate(FileName, fmShareExclusive, Rights);
end;

function FileCreate(const FileName: string; Mode: LongWord; Rights: Integer): THandle;
{$IFDEF MSWINDOWS}
const
  Exclusive: array[0..1] of LongWord = (
    CREATE_ALWAYS,
    CREATE_NEW);
  ShareMode: array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
begin
  Result := INVALID_HANDLE_VALUE;
  if (Mode and $F0) <= fmShareDenyNone then
    Result := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE,
      ShareMode[(Mode and $F0) shr 4], nil, Exclusive[(Mode and $0004) shr 2], FILE_ATTRIBUTE_NORMAL, 0);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
const
  Exclusive: array[0..1] of LongWord = (
    0,
    O_EXCL);
  ShareMode: array[0..fmShareDenyNone shr 4] of Byte = (
    0,        //No share mode specified
    F_WRLCK,  //fmShareExclusive
    F_RDLCK,  //fmShareDenyWrite
    0);       //fmShareDenyNone
var
  FileHandle, Tvar: Integer;
  LockVar: flock;
  smode: Byte;
  Code: Integer;
  M:TMarshaller;
begin
  Result := INVALID_HANDLE_VALUE;
  if (Mode and $F0) <= fmShareDenyNone then
  begin
    FileHandle := Integer(__open(M.AsAnsi(FileName, CP_UTF8).ToPointer,
      O_RDWR or O_CREAT or O_TRUNC or Exclusive[(Mode and $0004) shr 2], Rights));
    if FileHandle = -1 then
      Exit;

    smode := Mode and $F0 shr 4;
    if ShareMode[smode] <> 0 then
    begin
      LockVar.l_whence := SEEK_SET;
      LockVar.l_start := 0;
      LockVar.l_len := 0;
      LockVar.l_type := ShareMode[smode];
      Tvar :=  fcntl(FileHandle, F_SETLK, LockVar);
      Code := errno;
      if (Tvar = -1) and (Code <> EINVAL) and (Code <> ENOTSUP) then
      // EINVAL/ENOTSUP - file doesn't support locking
      begin
        __close(FileHandle);
        Exit;
      end;
    end;
    Result := FileHandle;
  end;
end;
{$ENDIF POSIX}

// The access rights of symlinks are unpredictable over network drives. It is
// therefore not recommended to create symlinks over a network drive. To enable
// remote access of symlinks under Windows Vista and Windows 7 use the command:
//   "fsutil behavior set SymlinkEvaluation R2R:1 R2L:1"
function FileCreateSymLink(const Link, Target: string): Boolean;
{$IFDEF MSWINDOWS}
var
  Flags: DWORD;
  Path: string;
begin
  Result := False;

  if (Target = '') or (Link = '') or not CheckWin32Version(6, 0) then
    Exit;

  Path := ExtractFilePath(Link);

  if fsSymLink in FileSystemAttributes(Path) then
  begin
    if IsRelativePath(Target) then
      Flags := GetFileAttributes(PChar(IncludeTrailingPathDelimiter(Path) + Target))
    else
      Flags := GetFileAttributes(PChar(Target));

    if (Flags <> INVALID_FILE_ATTRIBUTES) and (faDirectory and Flags <> 0) then
      Flags := SYMBOLIC_LINK_FLAG_DIRECTORY
    else
      Flags := 0;

    Result := CreateSymbolicLink(PChar(Link), PChar(Target), Flags);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  M1, M2:TMarshaller;
begin
  if (Target = '') or (Link = '') or not (fsSymLink in FileSystemAttributes(ExtractFilePath(Link))) then
    Exit(False);

  Result := symlink(M1.AsAnsi(Target, CP_UTF8).ToPointer, M2.AsAnsi(Link, CP_UTF8).ToPointer) = 0;
end;
{$ENDIF POSIX}

function FileGetSymLinkTarget(const FileName: string; var SymLinkRec: TSymLinkRec): Boolean;
{$IFDEF MSWINDOWS}
var
  TargetName, SearchName: string;
  SearchRec: TSearchRec;
begin
  Result := False;

  if CheckWin32Version(6, 0) and (fsSymLink in FileSystemAttributes(FileName)) then
  begin
    if InternalGetFileNameFromSymLink(FileName, TargetName) then
    begin
      if IsRelativePath(TargetName) then
        SearchName := IncludeTrailingPathDelimiter(ExtractFilePath(FileName)) + TargetName
      else
        SearchName := TargetName;

      if FindFirst(SearchName, faAnyFile, SearchRec) = 0 then
      begin
        SymLinkRec.TargetName := TargetName;
        SymLinkRec.Attr := SearchRec.Attr;
        SymLinkRec.Size := SearchRec.Size;
        SymLinkRec.FindData := SearchRec.FindData;
        FindClose(SearchRec);
        Result := True;
      end;
    end;
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  Buffer: TBytes;
  BufferLen, Size: Integer;
  SearchRec: TSearchRec;
  TargetName, SearchName: string;
  M: TMarshaller;
begin
  Result := False;

  if (FileName = '') or not (fsSymLink in FileSystemAttributes(FileName)) then
    Exit;

  BufferLen := MAX_PATH;

  while True do
  begin
    try
      SetLength(Buffer, BufferLen + 1);
      Size := readlink(M.AsAnsi(FileName, CP_UTF8).ToPointer, @Buffer[0], BufferLen);

      if (Size = -1) or (Size = 0) then
        Exit
      else if Size = BufferLen then
        Inc(BufferLen, BufferLen)
      else if Size < BufferLen then
      begin
        Buffer[Size] := Ord(#0);
{$IFDEF LINUX}
        TargetName := Buffer;
{$ENDIF LINUX}
{$IFDEF MACOS}
        if not FileSystemStringToString(@Buffer[0], TargetName) then
          Exit;
{$ENDIF MACOS}

        if IsRelativePath(TargetName) and ((TargetName.Length > 0) and (TargetName.Chars[0] <> '~')) then
          SearchName := IncludeTrailingPathDelimiter(ExtractFilePath(FileName)) + TargetName
        else
          SearchName := TargetName;

        if FindFirst(SearchName, faAnyFile, SearchRec) = 0 then
        begin
          SymLinkRec.TargetName := TargetName;
          SymLinkRec.Attr := SearchRec.Attr;
          SymLinkRec.Size := SearchRec.Size;
          SymLinkRec.PathOnly := SearchRec.PathOnly;
          SymLinkRec.Mode := SearchRec.Mode;
          SymLinkRec.Time := SearchRec.Time;
          FindClose(SearchRec);
          Result := True;
        end;

        Break;
      end;
    finally
    end;
  end;
end;
{$ENDIF POSIX}

function FileGetSymLinkTarget(const FileName: string; var TargetName: string): Boolean; overload;
var
  SymLinkRec: TSymLinkRec;
begin
  Result := FileGetSymLinkTarget(FileName, SymLinkRec);

  if Result then
    TargetName := SymLinkRec.TargetName;
end;

function FileSystemAttributes(const Path: string): TFileSystemAttributes;
{$IFDEF MSWINDOWS}
var
  Drive: string;
  SerialNumber, FileSystemFlags, ComponentLength: DWORD;
  VolumeName: array of Char;
  FileSystemBuffer: array of Char;
begin
  SetLength(VolumeName, MAX_PATH);
  SetLength(FileSystemBuffer, MAX_PATH);
  Result := [];

  if DirectoryExists(Path) or FileExists(Path) then
  begin
    Drive := IncludeTrailingPathDelimiter(ExtractFileDrive(Path));

    if GetVolumeInformation(PChar(Drive), @VolumeName[0], MAX_PATH, @SerialNumber,
      ComponentLength, FileSystemFlags, @FileSystemBuffer[0], MAX_PATH) then
    begin
      if FileSystemFlags and FILE_CASE_SENSITIVE_SEARCH <> 0 then
        Include(Result, fsCaseSensitive);
      if FileSystemFlags and FILE_CASE_PRESERVED_NAMES <> 0 then
        Include(Result, fsCasePreserving);
      if FileSystemFlags and FILE_SUPPORTS_REPARSE_POINTS <> 0 then
        Include(Result, fsSymLink);

      case GetDriveType(PChar(Drive)) of
        DRIVE_REMOVABLE, DRIVE_CDROM: Include(Result, fsRemovable);
        DRIVE_FIXED: Include(Result, fsLocal);
        DRIVE_REMOTE: Include(Result, fsNetwork);
      end;

      Exit;
    end;

    RaiseLastOSError;
  end;

  raise EDirectoryNotFoundException.Create(SDriveNotFound);
end;
{$ENDIF !MSWINDOWS}
{$IFDEF IOS}
var
  LPath: string;
  FileSystemPath: TBytes;
begin
  Result := [];

  if FileExists(Path) then
    LPath := ExtractFilePath(Path)
  else
    LPath := Path;

  if DirectoryExists(LPath) then
  begin
    SetLength(FileSystemPath, MAX_PATH);
    if StringToFileSystemString(LPath, FileSystemPath) then
    begin
      if PathConf(MarshaledAString(@FileSystemPath[0]), _PC_CASE_SENSITIVE) = 1 then
        Include(Result, fsCaseSensitive);
      if PathConf(MarshaledAString(@FileSystemPath[0]), _PC_CASE_PRESERVING) = 1 then
        Include(Result, fsCasePreserving);
      if PathConf(MarshaledAString(@FileSystemPath[0]), _PC_2_SYMLINKS) = 1 then
        Include(Result, fsSymLink);
      Exit;
    end;
    RaiseLastOSError;
  end;
  raise EDirectoryNotFoundException.Create(SDriveNotFound);
end;
{$ENDIF IOS}
{$IF DEFINED(MACOS) AND NOT DEFINED(IOS)}
var
  Buffer: GetVolParmsInfoBuffer;
  CatalogInfo: FSCatalogInfo;
  PathRef: FSRef;
  LPath: string;
  FileSystemPath: TBytes;
begin
  Result := [];

  if FileExists(Path) then
    LPath := ExtractFilePath(Path)
  else
    LPath := Path;

  if DirectoryExists(LPath) then
  begin
    SetLength(FileSystemPath, MAX_PATH);
    if StringToFileSystemString(LPath, FileSystemPath) and
      (FSPathMakeRef(Macapi.CoreServices.PUInt8(@FileSystemPath[0]), @PathRef, nil) = noErr) then
    begin
      if (FSGetCatalogInfo(@PathRef, kFSCatInfoVolume, @CatalogInfo, nil, nil, nil) = noErr) and
        (FSGetVolumeParms(CatalogInfo.volume, @Buffer, SizeOf(Buffer)) = noErr) and
        (Buffer.vMVersion > 2) then
      begin
        if (Buffer.vMExtendedAttributes and (1 shl bIsCaseSensitive)) <> 0 then
          Include(Result, fsCaseSensitive);
        if (Buffer.vMExtendedAttributes and (1 shl bIsCasePreserving)) <> 0 then
          Include(Result, fsCasePreserving);
        if (Buffer.vMExtendedAttributes and (1 shl bSupportsSymbolicLinks)) <> 0 then
          Include(Result, fsSymLink);
        if (Buffer.vMExtendedAttributes and (1 shl bIsOnExternalBus)) <> 0 then
          Include(Result, fsNetwork);
        if (Buffer.vMExtendedAttributes and (1 shl bIsOnInternalBus)) <> 0 then
          Include(Result, fsLocal);
        if (Buffer.vMExtendedAttributes and (1 shl bIsRemovable)) <> 0 then
          Include(Result, fsRemovable);

        Exit;
      end;
    end;

    RaiseLastOSError;
  end;

  raise EDirectoryNotFoundException.Create(SDriveNotFound);
end;
{$ENDIF MACOS}

function FileRead(Handle: THandle; var Buffer; Count: LongWord): Integer;
begin
{$IFDEF MSWINDOWS}
  if not ReadFile(Handle, Buffer, Count, LongWord(Result), nil) then
    Result := -1;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Result := __read(Handle, @Buffer, Count);
{$ENDIF POSIX}
end;

function FileWrite(Handle: THandle; const Buffer; Count: LongWord): Integer;
begin
{$IFDEF MSWINDOWS}
  if not WriteFile(Handle, Buffer, Count, LongWord(Result), nil) then
    Result := -1;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Result := __write(Handle, @Buffer, Count);
{$ENDIF POSIX}
end;

function FileRead(Handle: THandle; var Buffer: TBytes; Offset, Count: LongWord): Integer;
begin
{$IFDEF MSWINDOWS}
  if not ReadFile(Handle, (@Buffer[Offset])^, Count, LongWord(Result), nil) then
    Result := -1;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  if Integer(Count + Offset) > Length(Buffer) then
    Result := -1
  else
    Result := __read(Handle, @Buffer[Offset], Count);
{$ENDIF POSIX}
end;

function FileWrite(Handle: THandle; const Buffer:TBytes; Offset, Count: LongWord): Integer; overload;
begin
{$IFDEF MSWINDOWS}
  if not WriteFile(Handle, (@Buffer[Offset])^, Count, LongWord(Result), nil) then
    Result := -1;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  if Integer(Count + Offset) > Length(Buffer) then
    Result := -1
  else
    Result := __write(Handle, @Buffer[Offset], Count);
{$ENDIF POSIX}
end;

function FileSeek(Handle: THandle; Offset, Origin: Integer): Integer;
begin
{$IFDEF MSWINDOWS}
  Result := SetFilePointer(Handle, Offset, nil, Origin);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Result := lseek(Handle, Offset, Origin);
{$ENDIF POSIX}
end;

function FileSeek(Handle: THandle; const Offset: Int64; Origin: Integer): Int64;
{$IFDEF MSWINDOWS}
begin
  Result := Offset;
  Int64Rec(Result).Lo := SetFilePointer(Handle, Int64Rec(Result).Lo,
    @Int64Rec(Result).Hi, Origin);
  if (Int64Rec(Result).Lo = $FFFFFFFF) and (GetLastError <> 0) then
    Int64Rec(Result).Hi := $FFFFFFFF;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := lseek(Handle, Offset, Origin);
end;
{$ENDIF POSIX}

procedure FileClose(Handle: THandle);
begin
{$IFDEF MSWINDOWS}
  CloseHandle(Handle);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  __close(Handle); // No need to unlock since all locks are released on close.
{$ENDIF POSIX}
end;

{$IFDEF MSWINDOWS}
function GetFileAttributesExEmulated(lpFileName: PChar; fInfoLevelId: TGetFileExInfoLevels;
  lpFileInformation: Pointer): BOOL; stdcall;
var
  Handle: THandle;
  FindData: TWin32FindData;
begin
  Handle := FindFirstFile(lpFileName, FindData);
  if Handle <> INVALID_HANDLE_VALUE then
  begin
    Winapi.Windows.FindClose(Handle);
    if lpFileInformation <> nil then
    begin
      Move(FindData, lpFileInformation^, SizeOf(TWin32FileAttributeData));
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function FileAgeInternal(const FileName: string; out FileTime: TFileTime;
  FollowLink: Boolean = True): Boolean;
var
  FindData: TWin32FileAttributeData;
  ErrorCode: Cardinal;
  TargetName: string;
  Success: Boolean;
begin
  // try to get the file attributes the easy way;
  // if something goes wrong, ErrorCode is set to a value other then ERROR_SUCCESS;
  // the chosen value is ERROR_SHARING_VIOLATION
  ErrorCode := ERROR_SUCCESS;
  Success := GetFileAttributesEx(PChar(FileName), GetFileExInfoStandard, @FindData);

  if (FindData.dwFileAttributes and faSymLink <> 0) and FollowLink then
  begin
    if InternalGetFileNameFromSymLink(FileName, TargetName) then
    begin
      if IsRelativePath(TargetName) then
        TargetName := IncludeTrailingPathDelimiter(ExtractFilePath(FileName)) + TargetName;

      Success := GetFileAttributesEx(PChar(TargetName), GetFileExInfoStandard, @FindData);
    end;
  end;

  if not Success then
  begin
    // check if the file is locked or in share-exclusive mode;
    // if it is so, use FindFirstFile to get its age
    ErrorCode := GetLastError;

    case ErrorCode of
      ERROR_SHARING_VIOLATION,
      ERROR_LOCK_VIOLATION:
       if not GetFileAttributesExEmulated(PChar(FileName), GetFileExInfoStandard, @FindData) then
         ErrorCode := ERROR_SHARING_VIOLATION
       else
         ErrorCode := ERROR_SUCCESS;
    end;
  end;

  // if there was no error in getting the file attributes, obtain the file age
  if ErrorCode = ERROR_SUCCESS then
    if FindData.dwFileAttributes and faDirectory = 0 then
    begin
      if not FileTimeToLocalFileTime(FindData.ftLastWriteTime, FileTime) then
        ErrorCode := ERROR_SHARING_VIOLATION;
    end else
      ErrorCode := ERROR_SHARING_VIOLATION;

  { Result depends on the error code }
  Result := (ErrorCode = ERROR_SUCCESS);
end;
{$ENDIF}

function FileAge(const FileName: string): Integer; overload;
{$IFDEF MSWINDOWS}
var
  LFileTime: TFileTime;
begin
  { Use the internal helper routine }
  if (not FileAgeInternal(FileName, LFileTime)) or
     (not FileTimeToDosDateTime(LFileTime, LongRec(Result).Hi, LongRec(Result).Lo))
  then
    Result := -1; // Failure
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  st: _stat;
  M: TMarshaller;
begin
  if stat(M.AsAnsi(FileName, CP_UTF8).ToPointer, st) = 0 then
    Result := st.st_mtime
  else
    Result := -1;
end;
{$ENDIF POSIX}

function FileAge(const FileName: string; out FileDateTime: TDateTime;
  FollowLink: Boolean = True): Boolean;
{$IFDEF MSWINDOWS}
var
  LFileTime: TFileTime;
  LSystemTime: TSystemTime;
begin
  { Use the internal helper routine }
  Result := FileAgeInternal(FileName, LFileTime, FollowLink) and
    FileTimeToSystemTime(LFileTime, LSystemTime);

  { If the date/time was obtained OK, transform it into Delphi time }
  if Result then
    Result := TrySystemTimeToDateTime(LSystemTime, FileDateTime);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  st: _stat;
  M: TMarshaller;
  P: Pointer;
begin
  P := M.AsAnsi(Filename, CP_UTF8).ToPointer;
  if (FollowLink and (stat(P, st) = 0)) or
    (not FollowLink and (lstat(P, st) = 0)) then
  begin
    try
      FileDateTime := FileDateToDateTime(st.st_mtime);
    finally
      Result := True;
    end;
  end
  else
    Result := False;
end;
{$ENDIF POSIX}

function FileExists(const FileName: string; FollowLink: Boolean = True): Boolean;
{$IFDEF MSWINDOWS}

  function ExistsLockedOrShared(const Filename: string): Boolean;
  var
    FindData: TWin32FindData;
    LHandle: THandle;
  begin
    { Either the file is locked/share_exclusive or we got an access denied }
    LHandle := FindFirstFile(PChar(Filename), FindData);
    if LHandle <> INVALID_HANDLE_VALUE then
    begin
      Winapi.Windows.FindClose(LHandle);
      Result := FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY = 0;
    end
    else
      Result := False;
  end;

var
  Flags: Cardinal;
  Handle: THandle;
  LastError: Cardinal;
begin
  Flags := GetFileAttributes(PChar(FileName));

  if Flags <> INVALID_FILE_ATTRIBUTES then
  begin
    if faSymLink and Flags <> 0 then
    begin
      if not FollowLink then
        Exit(True)
      else
      begin
        if faDirectory and Flags <> 0 then
          Exit(False)
        else
        begin
          Handle := CreateFile(PChar(FileName), GENERIC_READ, FILE_SHARE_READ, nil,
            OPEN_EXISTING, 0, 0);
          if Handle <> INVALID_HANDLE_VALUE then
          begin
            CloseHandle(Handle);
            Exit(True);
          end;
          LastError := GetLastError;
          Exit(LastError = ERROR_SHARING_VIOLATION);
        end;
      end;
    end;

    Exit(faDirectory and Flags = 0);
  end;

  LastError := GetLastError;
  Result := (LastError <> ERROR_FILE_NOT_FOUND) and
    (LastError <> ERROR_PATH_NOT_FOUND) and
    (LastError <> ERROR_INVALID_NAME) and ExistsLockedOrShared(Filename);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  StatBuf: _stat;
  M: TMarshaller;
begin
  if lstat(M.AsAnsi(FileName, CP_UTF8).ToPointer, StatBuf) = 0 then
  begin
    if S_ISLNK(StatBuf.st_mode) then
    begin
      if not FollowLink then
        Exit(True)
      else
      begin
        if stat(M.AsAnsi(FileName, CP_UTF8).ToPointer, StatBuf) = 0 then
          Exit(not S_ISDIR(StatBuf.st_mode));
        Exit(False);
      end;
    end;

    Exit(not S_ISDIR(StatBuf.st_mode));
  end;

  Result := False;
end;
{$ENDIF POSIX}

function DirectoryExists(const Directory: string; FollowLink: Boolean = True): Boolean;
{$IFDEF MSWINDOWS}
var
  Code: Cardinal;
  Handle: THandle;
  LastError: Cardinal;
begin
  Result := False;
  Code := GetFileAttributes(PChar(Directory));

  if Code <> INVALID_FILE_ATTRIBUTES then
  begin
    if faSymLink and Code = 0 then
      Result := faDirectory and Code <> 0
    else
    begin
      if FollowLink then
      begin
        Handle := CreateFile(PChar(Directory), GENERIC_READ, FILE_SHARE_READ, nil,
          OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0);
        if Handle <> INVALID_HANDLE_VALUE then
        begin
          CloseHandle(Handle);
          Result := faDirectory and Code <> 0;
        end;
      end
      else if faDirectory and Code <> 0 then
        Result := True
      else
      begin
        Handle := CreateFile(PChar(Directory), GENERIC_READ, FILE_SHARE_READ, nil,
          OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0);
        if Handle <> INVALID_HANDLE_VALUE then
        begin
          CloseHandle(Handle);
          Result := False;
        end
        else
          Result := True;
      end;
    end;
  end
  else
  begin
    LastError := GetLastError;
    Result := (LastError <> ERROR_FILE_NOT_FOUND) and
      (LastError <> ERROR_PATH_NOT_FOUND) and
      (LastError <> ERROR_BAD_PATHNAME) and
      (LastError <> ERROR_INVALID_NAME) and
      (LastError <> ERROR_BAD_NETPATH) and
      (LastError <> ERROR_NOT_READY) and
      (LastError <> ERROR_BAD_NET_NAME);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  StatBuf, LStatBuf: _stat;
  Success: Boolean;
  M: TMarshaller;
begin
  Success := stat(M.AsAnsi(Directory, CP_UTF8).ToPointer, StatBuf) = 0;
  Result := Success and S_ISDIR(StatBuf.st_mode);

  if not Result and (lstat(M.AsAnsi(Directory, CP_UTF8).ToPointer, LStatBuf) = 0) and
    S_ISLNK(LStatBuf.st_mode) then
  begin
    if Success then
      Result := S_ISDIR(StatBuf.st_mode)
    else if not FollowLink then
      Result := True;
  end;
end;
{$ENDIF POSIX}

function ForceDirectories(Dir: string): Boolean;
var
  E: EInOutError;
begin
  Result := True;
  if Dir = '' then
  begin
    E := EInOutError.CreateRes(@SCannotCreateDir);
    E.ErrorCode := 3;
    raise E;
  end;

  Dir := ExcludeTrailingPathDelimiter(Dir);
  if DirectoryExists(Dir) then
    Exit;

{$IFDEF MSWINDOWS}
  if (Length(Dir) < 3) or (ExtractFilePath(Dir) = Dir) then
    Result := CreateDir(Dir)
  else
{$ENDIF}
{$IFDEF POSIX}
  Dir := ExpandFileName(Dir);
  if (Dir = '') then
    Exit
  else
{$ENDIF POSIX}
    Result := ForceDirectories(ExtractFilePath(Dir)) and CreateDir(Dir);
end;

function FileGetDate(Handle: THandle): Integer;
{$IFDEF MSWINDOWS}
var
  FileTime, LocalFileTime: TFileTime;
begin
  if GetFileTime(Handle, nil, nil, @FileTime) and
    FileTimeToLocalFileTime(FileTime, LocalFileTime) and
    FileTimeToDosDateTime(LocalFileTime, LongRec(Result).Hi,
      LongRec(Result).Lo) then Exit;
  Result := -1;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  st: _stat;
begin
  if fstat(Handle, st) = 0 then
    Result := st.st_mtime
  else
    Result := -1;
end;
{$ENDIF POSIX}

function FileGetDateTimeInfo(const FileName: string;
  out DateTime: TDateTimeInfoRec; FollowLink: Boolean = True): Boolean;
{$IFDEF MSWINDOWS}
var
  Data: TWin32FindData;
  LFileName: string;
begin
  Result := False;
  SetLastError(ERROR_SUCCESS);

  if GetFileAttributesEx(PChar(FileName), GetFileExInfoStandard, @Data) then
  begin
    if (faSymLink and Data.dwFileAttributes) <> 0 then
    begin
      if FollowLink then
      begin
        if not (InternalGetFileNameFromSymLink(FileName, LFileName) and
          GetFileAttributesEx(PChar(LFileName), GetFileExInfoStandard, @Data)) then
        begin
          Exit;
        end;
      end
      else
        Exit;
    end;

    DateTime.Data := Data;
    Result := True;
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  st: _stat;
  M: TMarshaller;
  P: Pointer;
begin
  Result := False;
  P := M.AsAnsi(FileName, CP_UTF8).ToPointer;
  if (FollowLink and (stat(P, st) = 0)) or
    (not FollowLink and (lstat(P, st) = 0)) then
  begin
    DateTime.st := st;
    Result := True;
  end;
end;
{$ENDIF POSIX}

function FileSetDate(const FileName: string; Age: Integer): Integer;
{$IFDEF MSWINDOWS}
var
  f: THandle;
begin
  f := FileOpen(FileName, fmOpenWrite);
  if f = THandle(-1) then
    Result := GetLastError
  else
  begin
    Result := FileSetDate(f, Age);
    FileClose(f);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  ut: utimbuf;
  M: TMarshaller;
begin
  Result := 0;
  ut.actime := Age;
  ut.modtime := Age;
  if utime(M.AsAnsi(FileName, CP_UTF8).ToPointer, ut) = -1 then
    Result := GetLastError;
end;
{$ENDIF POSIX}

{$IFDEF MSWINDOWS}
function FileSetDate(Handle: THandle; Age: Integer): Integer;
var
  LocalFileTime, FileTime: TFileTime;
begin
  Result := 0;
  if DosDateTimeToFileTime(LongRec(Age).Hi, LongRec(Age).Lo, LocalFileTime) and
    LocalFileTimeToFileTime(LocalFileTime, FileTime) and
    SetFileTime(Handle, nil, nil, @FileTime) then Exit;
  Result := GetLastError;
end;
{$ENDIF MSWINDOWS}

{$IFDEF POSIX}
function InternalPosixFileGetAttr(const FileName: string; FollowLink: Boolean;
  var StatBuf: _stat): Integer;
var
  LinkStatBuf: _stat;
  OnlyName: string;
  L: Integer;
  M: TMarshaller;
  P: Pointer;
begin
  Result := faInvalid;
  P := M.AsAnsi(FileName, CP_UTF8).ToPointer;

  if (FollowLink and (stat(P, StatBuf) = 0)) or
    (not FollowLink and (lstat(P, StatBuf) = 0)) then
  begin
    Result := 0;
                                                                          
    if S_ISDIR(StatBuf.st_mode) then
      Result := faDirectory
    else if not S_ISREG(StatBuf.st_mode) and S_ISLNK(StatBuf.st_mode) then
    begin
      Result := Result or faSymLink;

      if (stat(P, LinkStatBuf) = 0) and
        S_ISDIR(LinkStatBuf.st_mode) then
      begin
        Result := Result or faDirectory;
      end;
    end;
    if euidaccess(P, W_OK) <> 0 then
      Result := Result or faReadOnly;

    OnlyName := ExtractFilename(FileName);
    L := OnlyName.Length;

                                                                                                   
    if (L > 1) and (OnlyName.Chars[0] = '.') and (OnlyName.Chars[1] <> #0) then
    begin
      if (L > 3) and not ((OnlyName.Chars[1] = '.') and (OnlyName.Chars[2] = #0)) then
        Result := Result or faHidden;
    end;
  end;
end;
{$ENDIF POSIX}

function FileGetAttr(const FileName: string; FollowLink: Boolean = True): Integer;
{$IFDEF MSWINDOWS}
var
  TargetName: string;
begin
  Result := GetFileAttributes(PChar(FileName));

  if ((faSymLink and Result) <> 0) and FollowLink then
  begin
    Result := faInvalid;

    if InternalGetFileNameFromSymLink(FileName, TargetName) then
    begin
      if IsRelativePath(TargetName) then
        TargetName := IncludeTrailingPathDelimiter(ExtractFilePath(FileName)) + TargetName;

      Result := GetFileAttributes(PChar(TargetName));
    end;
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  StatBuf: _stat;
begin
  Result := InternalPosixFileGetAttr(FileName, FollowLink, StatBuf);
end;
{$ENDIF POSIX}

{$IFDEF MSWINDOWS}
function FileSetAttr(const FileName: string; Attr: Integer; FollowLink: Boolean = True): Integer;
var
  LFileName, TargetName: string;
begin
  Result := 0;
  LFileName := FileName;

  if FollowLink then
  begin
    if ((faSymLink and GetFileAttributes(PChar(FileName))) <> 0) and
      InternalGetFileNameFromSymLink(FileName, TargetName) then
    begin
      if IsRelativePath(TargetName) then
        TargetName := IncludeTrailingPathDelimiter(ExtractFilePath(FileName)) + TargetName;
      LFileName := TargetName;
    end;
  end;

  if not SetFileAttributes(PChar(LFileName), Attr) then
    Result := GetLastError;
end;
{$ENDIF MSWINDOWS}

function FileIsReadOnly(const FileName: string): Boolean;
{$IFDEF MSWINDOWS}
var
  Flags: DWORD;
  TargetName: string;
begin
  Result := False;
  Flags := GetFileAttributes(PChar(FileName));

  if Flags <> INVALID_FILE_ATTRIBUTES then
  begin
    if (faSymLink and Flags <> 0) and
      InternalGetFileNameFromSymLink(FileName, TargetName) then
    begin
      if IsRelativePath(TargetName) then
        TargetName := IncludeTrailingPathDelimiter(ExtractFilePath(FileName)) + TargetName;

      Flags := GetFileAttributes(PChar(TargetName));
    end;

    Result := Flags and faReadOnly <> 0;
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  M: TMarshaller;
  P: Pointer;
begin
  // 'euidaccess' is not available in POSIX or on the Mac. So we are using 'access'
  // but it it doesn't check the the effective user's permissions.
  P := M.AsAnsi(FileName, CP_UTF8).ToPointer;
  Result := (euidaccess(P, R_OK) = 0) and
    (euidaccess(P, W_OK) <> 0);
end;
{$ENDIF POSIX}

function FileSetReadOnly(const FileName: string; ReadOnly: Boolean): Boolean;
{$IFDEF MSWINDOWS}
var
  Flags: Cardinal;
  LFileName: string;
begin
  Result := False;
  Flags := GetFileAttributes(PChar(FileName));

  if Flags <> INVALID_FILE_ATTRIBUTES then
  begin
    if (faSymLink and Flags <> 0) and
      InternalGetFileNameFromSymLink(FileName, LFileName) then
    begin
      Flags := GetFileAttributes(PChar(LFileName));

      if Flags = INVALID_FILE_ATTRIBUTES then
        Exit;
    end
    else
      LFileName := FileName;

    if ReadOnly then
      Flags := Flags or faReadOnly
    else
      Flags := Flags and not faReadOnly;

    Result := SetFileAttributes(PChar(LFileName), Flags);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  st: _stat;
  Flags: Integer;
  M: TMarshaller;
  P: Pointer;
begin
  Result := False;
  P := M.AsAnsi(FileName, CP_UTF8).ToPointer;

  if stat(P, st) = 0 then
  begin
    if ReadOnly then
      Flags := st.st_mode and not (S_IWUSR or S_IWGRP or S_IWOTH)
    else
      Flags := st.st_mode or (S_IWUSR or S_IWGRP or S_IWOTH);

    Result := chmod(P, Flags) = 0;
  end;
end;
{$ENDIF POSIX}

function FindMatchingFile(var F: TSearchRec): Integer;
{$IFDEF MSWINDOWS}
var
  LocalFileTime: TFileTime;
begin
  while F.FindData.dwFileAttributes and F.ExcludeAttr <> 0 do
    if not FindNextFile(F.FindHandle, F.FindData) then
    begin
      Result := GetLastError;
      Exit;
    end;
  FileTimeToLocalFileTime(F.FindData.ftLastWriteTime, LocalFileTime);
  FileTimeToDosDateTime(LocalFileTime, LongRec(F.Time).Hi,
    LongRec(F.Time).Lo);
  F.Size := F.FindData.nFileSizeLow or Int64(F.FindData.nFileSizeHigh) shl 32;
  F.Attr := F.FindData.dwFileAttributes;
  F.Name := F.FindData.cFileName;
  Result := 0;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  PtrDirEnt: PDirEnt;
  Scratch: dirent;
  StatBuf: _stat;
  Attr: Integer;
  d_name: string;
{$IFDEF MACOS}
  Pattern: TBytes;
{$ENDIF MACOS}
begin
  Result := -1;
  PtrDirEnt := nil;
  if F.FindHandle = nil then Exit;
  if readdir_r(F.FindHandle, @Scratch, PtrDirEnt) <> 0 then
    Exit;
{$IFDEF MACOS}
  F.Pattern := F.Pattern.Replace('[','\[').Replace(']','\]');
  SetLength(Pattern, NAME_MAX+1);
  if StringToFileSystemString(F.Pattern, Pattern) then
  begin
{$ENDIF MACOS}
    while PtrDirEnt <> nil do
    begin
{$IFDEF LINUX}
      if fnmatch(PAnsiChar(F.Pattern[Low(string)]), @PtrDirEnt.d_name[0], 0) = 0 then
      begin
        d_name := PtrDirEnt.d_name;
{$ENDIF LINUX}
{$IFDEF MACOS}
      if fnmatch(MarshaledAString(@Pattern[0]), @PtrDirEnt.d_name[0], 0) = 0 then
      begin
        if FileSystemStringToString(@PtrDirEnt.d_name[0], d_name) then
{$ENDIF MACOS}
        begin
          // F.PathOnly must include trailing backslash
          Attr := InternalPosixFileGetAttr(F.PathOnly + d_name, False, StatBuf);

          if Attr and F.ExcludeAttr = 0 then
          begin
            F.Size := StatBuf.st_size;
            F.Attr := Attr;
            F.Mode := StatBuf.st_mode;
            F.Name := d_name;
            F.Time := StatBuf.st_mtime;
            Result := 0;
            Break;
          end;
        end;
      end;
      Result := -1;
      if readdir_r(F.FindHandle, @Scratch, PtrDirEnt) <> 0 then
        Break;
    end; // End of While
{$IFDEF MACOS}
  end;
{$ENDIF MACOS}
end;
{$ENDIF POSIX}

function FindFirst(const Path: string; Attr: Integer;
  var F: TSearchRec): Integer;
const
  faSpecial = faHidden or faSysFile or faDirectory;
{$IFDEF MSWINDOWS}
begin
  F.ExcludeAttr := not Attr and faSpecial;
  F.FindHandle := FindFirstFile(PChar(Path), F.FindData);
  if F.FindHandle <> INVALID_HANDLE_VALUE then
  begin
    Result := FindMatchingFile(F);
    if Result <> 0 then FindClose(F);
  end
  else
    Result := GetLastError;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  M: TMarshaller;
begin
  F.ExcludeAttr := not Attr and faSpecial;
  F.PathOnly := ExtractFilePath(Path);
  F.Pattern := ExtractFileName(Path);
  if F.PathOnly = '' then
    F.PathOnly := IncludeTrailingPathDelimiter(GetCurrentDir);

  F.FindHandle := opendir(M.AsAnsi(F.PathOnly, CP_UTF8).ToPointer);
  if F.FindHandle <> nil then
  begin
    Result := FindMatchingFile(F);
    if Result <> 0 then
      FindClose(F);
  end
  else
    Result:= GetLastError;
end;
{$ENDIF POSIX}

function FindNext(var F: TSearchRec): Integer;
begin
{$IFDEF MSWINDOWS}
  if FindNextFile(F.FindHandle, F.FindData) then
    Result := FindMatchingFile(F)
  else
    Result := GetLastError;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Result := FindMatchingFile(F);
{$ENDIF POSIX}
end;

procedure FindClose(var F: TSearchRec);
begin
{$IFDEF MSWINDOWS}
  if F.FindHandle <> INVALID_HANDLE_VALUE then
  begin
    Winapi.Windows.FindClose(F.FindHandle);
    F.FindHandle := INVALID_HANDLE_VALUE;
  end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  if F.FindHandle <> nil then
  begin
    closedir(F.FindHandle);
    F.FindHandle := nil;
  end;
{$ENDIF POSIX}
end;

function DeleteFile(const FileName: string): Boolean;
{$IFDEF MSWINDOWS}
var
  Flags, LastError: Cardinal;
begin
  Result := Winapi.Windows.DeleteFile(PChar(FileName));

  if not Result then
  begin
    LastError := GetLastError;
    Flags := GetFileAttributes(PChar(FileName));

    if (Flags <> INVALID_FILE_ATTRIBUTES) and (faSymLink and Flags <> 0) and
      (faDirectory and Flags <> 0) then
    begin
      Result := RemoveDirectory(PChar(FileName));
      Exit;
    end;

    SetLastError(LastError);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  M: TMarshaller;
begin
  Result := unlink(M.AsAnsi(FileName, CP_UTF8).ToPointer) <> -1;
end;
{$ENDIF POSIX}

function RenameFile(const OldName, NewName: string): Boolean;
{$IFDEF MSWINDOWS}
begin
  Result := MoveFile(PChar(OldName), PChar(NewName));
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  M1, M2: TMarshaller;
begin
  Result := __rename(M1.AsAnsi(OldName, CP_UTF8).ToPointer, M2.AsAnsi(NewName, CP_UTF8).ToPointer) = 0;
end;
{$ENDIF POSIX}

{$IFDEF MSWINDOWS}
function IsAssembly(const FileName: string): Boolean;
var
  Base: ^Byte;
  Handle, Map: HWND;
  DosHeader: PImageDosHeader;
  Size: LongWord;
begin
  Result := False;
  Handle := CreateFile(PChar(FileName), GENERIC_READ, FILE_SHARE_READ,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  Map := CreateFileMapping(Handle, nil, PAGE_READONLY, 0, 0, nil);
  Base := MapViewOfFile(Map, FILE_MAP_READ, 0, 0, 0);
  DosHeader := PImageDosHeader(Base);

  try
    if (DosHeader = nil) or (ImageDirectoryEntryToData(Base, False,
      IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR, Size) = nil) then
    begin
      Exit;
    end;

    Result := True;
  finally
    if Handle <> 0 then
    begin
     UnmapViewOfFile(Base);
     CloseHandle(Map);
     CloseHandle(Handle);
    end;
  end;
end;
{$ENDIF MSWINDOWS}

{$IFNDEF NEXTGEN}
function AnsiStrLastChar(P: PAnsiChar): PAnsiChar;
var
  LastByte: Integer;
begin
  LastByte := StrLen(P) - 1;
  Result := @P[LastByte];
{$IFDEF MSWINDOWS}
  if StrByteType(P, LastByte) = mbTrailByte then Dec(Result);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  while StrByteType(P, Result - P) = mbTrailByte do Dec(Result);
{$ENDIF POSIX}
end;
{$ENDIF !NEXTGEN}

function AnsiStrLastChar(P: PWideChar): PWideChar;
var
  Len: Integer;
begin
  Len := StrLen(P);
  Result := @P[Len - 1];
  if (Len > 1) and (Result^ >= #$DC00) and (Result^ <= #$DFFF) and
     (Result[-1] >= #$D800) and (Result[-1] <= #$DBFF) then
    Dec(Result, 1);
end;

function AnsiLastChar(const S: UnicodeString): PWideChar;
const
  Offset = 1 - Low(UnicodeString);
var
  Len: Integer;
begin
  if S = '' then
    Result := nil
  else
  begin
    Len := Length(S);
    Result := @S[Len - Offset];
    if (Len > 1) and (Result^ >= #$DC00) and (Result^ <= #$DFFF) and
       (Result[-1] >= #$D800) and (Result[-1] <= #$DBFF) then
      Dec(Result, 1);
  end;
end;

function LastDelimiter(const Delimiters, S: string): Integer;
var
  P: PChar;
begin
  Result := S.Length;
  P := PChar(Delimiters);
  while Result > 0 do
  begin
    if (S.Chars[Result-1] <> #0) and (StrScan(P, S.Chars[Result-1]) <> nil) then
      Exit;
    Dec(Result);
  end;
end;

function FindDelimiter(const Delimiters, S: string; StartIdx: Integer = 1): Integer;
var
  Stop: Boolean;
  Len: Integer;
begin
  Result := 0;

  Len := S.Length;
  Stop := False;
  while (not Stop) and (StartIdx <= Len) do
    if IsDelimiter(Delimiters, S, StartIdx) then
    begin
      Result := StartIdx;
      Stop := True;
    end
    else
      Inc(StartIdx);
end;

function ChangeFileExt(const FileName, Extension: string): string;
var
  I: Integer;
begin
  I := FileName.LastDelimiter('.' + PathDelim + DriveDelim);
  if (I < 0) or (FileName.Chars[I] <> '.') then I := MaxInt;
  Result := FileName.SubString(0, I) + Extension;
end;

function ChangeFilePath(const FileName, Path: string): string;
begin
  Result := IncludeTrailingPathDelimiter(Path) + ExtractFileName(FileName);
end;

function ExtractFilePath(const FileName: string): string;
var
  I: Integer;
begin
  I := FileName.LastDelimiter(PathDelim + DriveDelim);
  Result := FileName.SubString(0, I + 1);
end;

function ExtractFileDir(const FileName: string): string;
var
  I: Integer;
begin
  I := FileName.LastDelimiter(PathDelim + DriveDelim);
  if (I > 0) and (FileName.Chars[I] = PathDelim) and
    (not FileName.IsDelimiter(PathDelim + DriveDelim, I-1)) then Dec(I);
  Result := FileName.SubString(0, I + 1);
end;

function ExtractFileDrive(const FileName: string): string;
{$IFDEF MSWINDOWS}
var
  I, J: Integer;
begin
  if (FileName.Length >= 2) and (FileName.Chars[1] = DriveDelim) then
    Result := Copy(FileName, 1, 2)
  else if (FileName.Length >= 2) and (FileName.Chars[0] = PathDelim) and
    (FileName.Chars[1] = PathDelim) then
  begin
    J := 0;
    I := 3;
    While (I < FileName.Length) and (J < 2) do
    begin
      if FileName.Chars[I-1] = PathDelim then Inc(J);
      if J < 2 then Inc(I);
    end;
    if FileName.Chars[I-1] = PathDelim then Dec(I);
    Result := Copy(FileName, 1, I);
  end else Result := '';
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := '';  // Linux doesn't support drive letters
end;
{$ENDIF POSIX}

function ExtractFileName(const FileName: string): string;
var
  I: Integer;
begin
  I := FileName.LastDelimiter(PathDelim + DriveDelim);
  Result := FileName.SubString(I + 1);
end;

function ExtractFileExt(const FileName: string): string;
var
  I: Integer;
begin
  I := FileName.LastDelimiter('.' + PathDelim + DriveDelim);
  if (I >= 0) and (FileName.Chars[I] = '.') then
    Result := FileName.SubString(I)
  else
    Result := '';
end;

function GetHomePath: string;
{$IFDEF MSWINDOWS}
const
  CSIDL_APPDATA = $001A;
var
  LStr: array[0 .. MAX_PATH] of Char;
begin
  SetLastError(ERROR_SUCCESS);

  if SHGetFolderPath(0, CSIDL_APPDATA, 0, 0, @LStr) = S_OK then
    Result := LStr;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := GetEnvironmentVariable('HOME'); // DO NOT LOCALIZE
end;
{$ENDIF POSIX}

function ExpandFileName(const FileName: string): string;
{$IFDEF MSWINDOWS}
var
  FName: PChar;
  Buffer: array[0..MAX_PATH - 1] of Char;
  Len: Integer;
begin
  Len := GetFullPathName(PChar(FileName), Length(Buffer), Buffer, FName);
  if Len <= Length(Buffer) then
    SetString(Result, Buffer, Len)
  else if Len > 0 then
  begin
    SetLength(Result, Len);
    Len := GetFullPathName(PChar(FileName), Len, PChar(Result), FName);
    if Len < Length(Result) then
      SetLength(Result, Len);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
{$IFNDEF IOS}
  function ExpandHomes(const User: string): string;
  var
    M: TMarshaller;
    pwd: passwd;
    res: Ppasswd;
    buffer: TBytes;
    bufsize: Longint;
  begin
    bufsize := sysconf(_SC_GETPW_R_SIZE_MAX);
    if bufsize = -1 then bufsize := 4096;
    SetLength(buffer, bufsize);
    if (getpwnam_r(M.AsUTF8(User).ToPointer, pwd, MarshaledAString(@buffer[0]), bufsize, res) = 0) and (res <> nil) then
      Result := UTF8ToString(pwd.pw_dir)
    else
      Result := '~' + User;
  end;
{$ENDIF !IOS}
  function ExpandTilde(const InString: string): string;
{$IFDEF IOS}
  begin
    if InString.Length = 1 then
      Result := GetHomePath
    else if InString.IndexOf(PathDelim) = 1 then  // We need always ~/something
      Result := GetHomePath + InString.Substring(1)
    else
      Result := InString;
  end;
{$ELSE}
  var
    posDelim: integer;
  begin
    if InString.Length = 1 then
      Result := GetHomePath
    else
    begin
      //  ~user  expand to /home/user
      //  ~/user expand to /home/actualuser/user
      posDelim := InString.IndexOf(PathDelim);
      if posDelim = 1 then
        Result := GetHomePath + InString.Substring(1)
      else
      begin
        if posDelim < 0 then
          Result := ExpandHomes(InString.Substring(1))
        else
          Result := ExpandHomes(InString.Substring(1, posDelim - 1)) + InString.Substring(posDelim);
      end;
    end;
  end;
{$ENDIF IOS}

var
  I, J: Integer;
  LastWasPathDelim: Boolean;
  TempName: string;
begin
  { Special case for root path. '/', '/.' and '/..' refer to the same directory - '/' }
  if (Filename = PathDelim) or (Filename = PathDelim + '.') or (Filename = PathDelim + '..') then
    Exit(PathDelim)
  else
    Result := '';

  if Length(Filename) = 0 then Exit;

  if FileName[Low(string)] = PathDelim then
    TempName := FileName
  else
  begin
    TempName := FileName;
    if FileName[Low(string)] = '~' then
      TempName := ExpandTilde(TempName)
    else
      TempName := IncludeTrailingPathDelimiter(GetCurrentDir) + TempName;
  end;

  I := Low(string);
  J := Low(string);

  LastWasPathDelim := False;

  while I <= High(TempName) do
  begin
    case TempName[I] of
      PathDelim:
        if J < I then
        begin
          // Check for consecutive 'PathDelim' characters and skip them if present
          if (I = Low(string)) or (TempName[I - 1] <> PathDelim) then
            Result := Result + TempName.SubString(J-Low(string), I - J);
          J := I;
          // Set a flag indicating that we just processed a path delimiter
          LastWasPathDelim := True;
        end;
      '.':
        begin
          // If the last character was a path delimiter then this '.' is
          // possibly a relative path modifier
          if LastWasPathDelim then
          begin
            // Check if the path ends in a '.'
            if I < High(TempName) then
            begin
              // If the next characters are './' then this is a relative path
              // Otherwise simply treat this as just another filename.
              if (TempName[I + 1] = '.') and
                ((I + 1 = High(TempName)) or (TempName[I + 2] = PathDelim)) then
              begin
                // Don't attempt to backup past the Root dir
                if High(Result) > 1 then
                  // For the purpose of this excercise, treat the last dir as a
                  // filename so we can use this function to remove it
                  Result := ExtractFilePath(ExcludeTrailingPathDelimiter(Result));
                J := I;
              end
              // Simply skip over and ignore any 'current dir' constrcucts, './'
              // or the remaining './' from a ../ constrcut.
              else if TempName[I + 1] = PathDelim then
              begin
                Result := IncludeTrailingPathDelimiter(Result);
                if IsLeadChar(TempName[I]) then
                  Inc(I, StrCharLength(PWideChar(TempName.SubString(I - 1))) div SizeOf(Char))
                else
                  Inc(I);
                J := I + 1;
              end else
                // If any of the above tests fail, then this is not a 'current dir' or
                // 'parent dir' construct so just clear the state and continue.
                LastWasPathDelim := False;
            end else
            begin
              // Don't let the expanded path end in a 'PathDelim' character
              Result := ExcludeTrailingPathDelimiter(Result);
              J := I + 1;
            end;
          end;
        end;
    else
      LastWasPathDelim := False;
    end;
    if IsLeadChar(TempName[I]) then
      Inc(I, StrCharLength(PWideChar(TempName.SubString(I))) div SizeOf(Char))
    else
      Inc(I);
  end;
  // This will finally append what is left
  if (I - J > 1) then
    Result := Result + TempName.SubString(J - Low(string), I - J);
end;
{$ENDIF POSIX}

function ExpandFileNameCase(const FileName: string; out MatchFound: TFilenameCaseMatch): string;
var
  SR: TSearchRec;
  FullPath, Name: string;
  Status: Integer;
{$IFDEF POSIX}
  FoundOne: Boolean;
  Scans: Byte;
  FirstLetter, TestLetter: string;
{$ENDIF POSIX}
begin
  Result := ExpandFileName(FileName);
  MatchFound := mkNone;

  if FileName = '' then // Stop for empty strings, otherwise we risk to get info infinite loop.
    Exit;

  FullPath := ExtractFilePath(Result);
  Name := ExtractFileName(Result);

  // if FullPath is not the root directory  (portable)
  if not SameFileName(FullPath, IncludeTrailingPathDelimiter(ExtractFileDrive(FullPath))) then
  begin  // Does the path need case-sensitive work?
    Status := FindFirst(ExcludeTrailingPathDelimiter(FullPath), faAnyFile, SR);
    FindClose(SR);   // close search before going recursive
    if Status <> 0 then
    begin
      FullPath := ExcludeTrailingPathDelimiter(FullPath);
      FullPath := ExpandFileNameCase(FullPath, MatchFound);
      if MatchFound = mkNone then
        Exit;    // if we can't find the path, we certainly can't find the file!
      FullPath := IncludeTrailingPathDelimiter(FullPath);
    end;
  end;

  // Path is validated / adjusted.  Now for the file itself
  try
    if FindFirst(FullPath + Name, faAnyFile, SR)= 0 then    // exact match on filename
    begin
      if not (MatchFound in [mkSingleMatch, mkAmbiguous]) then  // path might have been inexact
      begin
        if Name = SR.Name then
          MatchFound := mkExactMatch
        else
          MatchFound := mkSingleMatch;
      end;
      Exit(FullPath + SR.Name);
    end;
  finally
    FindClose(SR);
  end;

{$IFDEF POSIX}
{ Scan the directory.
  To minimize the number of filenames tested, scan the directory
  using upper/lowercase first letter + wildcard.
  This results in two scans of the directory (particularly on Linux) but
  vastly reduces the number of times we have to perform an expensive
  locale-charset case-insensitive string compare.  }

  FoundOne := False;

  if (fsCaseSensitive in FileSystemAttributes(FullPath)) or
     (fsCasePreserving in FileSystemAttributes(FullPath)) then
  begin
    // First, scan for lowercase first letter
    FirstLetter := AnsiLowerCase(Name[Low(string)]);
    for Scans := 0 to 1 do
    begin
      Status := FindFirst(FullPath + FirstLetter + '*', faAnyFile, SR);
      while Status = 0 do
      begin
        if AnsiSameText(SR.Name, Name) then
        begin
          if FoundOne then
          begin  // this is the second match
            MatchFound := mkAmbiguous;
            Exit;
          end
          else
          begin
            FoundOne := True;
            Result := FullPath + SR.Name;
          end;
        end;
        Status := FindNext(SR);
      end;
      FindClose(SR);
      TestLetter := AnsiUpperCase(Name[Low(string)]);
      if TestLetter = FirstLetter then
        Break;
      FirstLetter := TestLetter;
    end;

    if MatchFound <> mkAmbiguous then
    begin
      if FoundOne then
        MatchFound := mkSingleMatch
      else
        MatchFound := mkNone;
    end;
  end;
{$ENDIF POSIX}
end;

{$IFDEF MSWINDOWS}
function GetUniversalName(const FileName: string): string;
type
  PNetResourceArray = ^TNetResourceArray;
  TNetResourceArray = array[0..MaxInt div SizeOf(TNetResource) - 1] of TNetResource;
var
  I, BufSize, NetResult: Integer;
  Count, Size: LongWord;
  Drive: Char;
  NetHandle: THandle;
  NetResources: PNetResourceArray;
  RemoteNameInfo: array[0..1023] of Byte;
begin
  Result := FileName;
  if (Win32Platform <> VER_PLATFORM_WIN32_WINDOWS) or (Win32MajorVersion > 4) then
  begin
    Size := SizeOf(RemoteNameInfo);
    if WNetGetUniversalName(PChar(FileName), UNIVERSAL_NAME_INFO_LEVEL,
      @RemoteNameInfo, Size) <> NO_ERROR then Exit;
    Result := PRemoteNameInfo(@RemoteNameInfo).lpUniversalName;
  end else
  begin
  { The following works around a bug in WNetGetUniversalName under Windows 95 }
    Drive := UpCase(FileName[1]);
    if (Drive < 'A') or (Drive > 'Z') or (Length(FileName) < 3) or
      (FileName[2] <> ':') or (FileName[3] <> '\') then
      Exit;
    if WNetOpenEnum(RESOURCE_CONNECTED, RESOURCETYPE_DISK, 0, nil,
      NetHandle) <> NO_ERROR then Exit;
    try
      BufSize := 50 * SizeOf(TNetResource);
      GetMem(NetResources, BufSize);
      try
        while True do
        begin
          Count := $FFFFFFFF;
          Size := BufSize;
          NetResult := WNetEnumResource(NetHandle, Count, NetResources, Size);
          if NetResult = ERROR_MORE_DATA then
          begin
            BufSize := Size;
            ReallocMem(NetResources, BufSize);
            Continue;
          end;
          if NetResult <> NO_ERROR then Exit;
          for I := 0 to Count - 1 do
            if (NetResources^[I].lpLocalName <> nil) and
               (Drive = UpCase(NetResources^[I].lpLocalName[0])) then
            begin
              Result := NetResources^[I].lpRemoteName + Copy(FileName, 3, Length(FileName) - 2);
              Exit;
            end;
        end;
      finally
        FreeMem(NetResources, BufSize);
      end;
    finally
      WNetCloseEnum(NetHandle);
    end;
  end;
end;

function ExpandUNCFileName(const FileName: string): string;
begin
  { First get the local resource version of the file name }
  Result := ExpandFileName(FileName);
  if (Length(Result) >= 3) and (Result[2] = ':') and (Upcase(Result[1]) >= 'A')
    and (Upcase(Result[1]) <= 'Z') then
    Result := GetUniversalName(Result);
end;
{$ENDIF MSWINDOWS}

{$IFDEF POSIX}
function ExpandUNCFileName(const FileName: string): string;
begin
  Result := ExpandFileName(FileName);
end;
{$ENDIF POSIX}

function ExtractRelativePath(const BaseName, DestName: string): string;
var
  BasePath, DestPath: string;
  BaseLead, DestLead: PChar;
  BasePtr, DestPtr: PChar;

  function ExtractFilePathNoDrive(const FileName: string): string;
  begin
    Result := ExtractFilePath(FileName);
    Delete(Result, 1, Length(ExtractFileDrive(FileName)));
  end;

  function Next(var Lead: PChar): PChar;
  begin
    Result := Lead;
    if Result = nil then Exit;
    Lead := AnsiStrScan(Lead, PathDelim);
    if Lead <> nil then
    begin
      Lead^ := #0;
      Inc(Lead);
    end;
  end;

begin
  if SameFilename(ExtractFileDrive(BaseName), ExtractFileDrive(DestName)) then
  begin
    BasePath := ExtractFilePathNoDrive(BaseName);
    UniqueString(BasePath);
    DestPath := ExtractFilePathNoDrive(DestName);
    UniqueString(DestPath);
    BaseLead := Pointer(BasePath);
    BasePtr := Next(BaseLead);
    DestLead := Pointer(DestPath);
    DestPtr := Next(DestLead);
    while (BasePtr <> nil) and (DestPtr <> nil) and SameFilename(BasePtr, DestPtr) do
    begin
      BasePtr := Next(BaseLead);
      DestPtr := Next(DestLead);
    end;
    Result := '';
    while BaseLead <> nil do
    begin
      Result := Result + '..' + PathDelim;             { Do not localize }
      Next(BaseLead);
    end;
    if (DestPtr <> nil) and (DestPtr^ <> #0) then
      Result := Result + DestPtr + PathDelim;
    if DestLead <> nil then
      Result := Result + DestLead;     // destlead already has a trailing backslash
    Result := Result + ExtractFileName(DestName);
  end
  else
    Result := DestName;
end;

function IsRelativePath(const Path: string): Boolean;
var
  L: Integer;
begin
  L := Length(Path);
  Result := ((L = 0) or ((L > 0) and (Path[Low(string)] <> PathDelim)))
    {$IFDEF MSWINDOWS} and ( (L <= 1) or (Path[Low(string) + 1] <> ':') ); {$ENDIF MSWINDOWS};
end;

{$IFDEF MSWINDOWS}
function ExtractShortPathName(const FileName: string): string;
var
  Buffer: array[0..MAX_PATH - 1] of Char;
  Len: Integer;
begin
  Len := GetShortPathName(PChar(FileName), Buffer, Length(Buffer));
  if Len <= Length(Buffer) then
    SetString(Result, Buffer, Len)
  else
    if Len > 0 then
    begin
      SetLength(Result, Len);
      Len := GetShortPathName(PChar(FileName), PChar(Result), Len);
      if Len < Length(Result) then
        SetLength(Result, Len);
    end;
end;
{$ENDIF}

function FileSearch(const Name, DirList: string): string;
var
  I, P, L: Integer;
  C: Char;
begin
  Result := Name;
  if Result = '' then // nothing to do
    Exit;
  P := 1;
  L := Length(DirList);
  while True do
  begin
    if FileExists(Result) then Exit;
    while (P <= L) and (DirList[P] = PathSep) do Inc(P);
    if P > L then Break;
    I := P;
    while (P <= L) and (DirList[P] <> PathSep) do
    begin
      if IsLeadChar(DirList[P]) then
        P := NextCharIndex(DirList, P)
      else
        Inc(P);
    end;
    Result := Copy(DirList, I, P - I);
    C := AnsiLastChar(Result)^;
    if (C <> DriveDelim) and (C <> PathDelim) then
      Result := Result + PathDelim;
    Result := Result + Name;
  end;
  Result := '';
end;

{$IFDEF MSWINDOWS}
// This function is used if the OS doesn't support GetDiskFreeSpaceEx
function BackfillGetDiskFreeSpaceEx(Directory: PChar; var FreeAvailable,
    TotalSpace: TLargeInteger; TotalFree: PLargeInteger): Bool; stdcall;
var
  SectorsPerCluster, BytesPerSector, FreeClusters, TotalClusters: LongWord;
  Temp: Int64;
  Dir: PChar;
begin
  if Directory <> nil then
    Dir := Directory
  else
    Dir := nil;
  Result := GetDiskFreeSpace(Dir, SectorsPerCluster, BytesPerSector,
    FreeClusters, TotalClusters);
  Temp := SectorsPerCluster * BytesPerSector;
  FreeAvailable := Temp * FreeClusters;
  TotalSpace := Temp * TotalClusters;
end;

function InternalGetDiskSpace(Drive: Byte;
  var TotalSpace, FreeSpaceAvailable: Int64): Bool;
var
  RootPath: array[0..4] of Char;
  RootPtr: PChar;
begin
  RootPtr := nil;
  if Drive > 0 then
  begin
    RootPath[0] := Char(Drive + $40);
    RootPath[1] := ':';
    RootPath[2] := '\';
    RootPath[3] := #0;
    RootPtr := RootPath;
  end;
  Result := GetDiskFreeSpaceEx(RootPtr, FreeSpaceAvailable, TotalSpace, nil);
end;

function DiskFree(Drive: Byte): Int64;
var
  TotalSpace: Int64;
begin
  if not InternalGetDiskSpace(Drive, TotalSpace, Result) then
    Result := -1;
end;

function DiskSize(Drive: Byte): Int64;
var
  FreeSpace: Int64;
begin
  if not InternalGetDiskSpace(Drive, Result, FreeSpace) then
    Result := -1;
end;
{$ENDIF MSWINDOWS}

function FileDateToDateTime(FileDate: Integer): TDateTime;
{$IFDEF MSWINDOWS}
begin
  Result :=
    EncodeDate(
      LongRec(FileDate).Hi shr 9 + 1980,
      LongRec(FileDate).Hi shr 5 and 15,
      LongRec(FileDate).Hi and 31) +
    EncodeTime(
      LongRec(FileDate).Lo shr 11,
      LongRec(FileDate).Lo shr 5 and 63,
      LongRec(FileDate).Lo and 31 shl 1, 0);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  UT: tm;
begin
  localtime_r(FileDate, UT);
  Result := EncodeDate(UT.tm_year + 1900, UT.tm_mon + 1, UT.tm_mday) +
              EncodeTime(UT.tm_hour, UT.tm_min, UT.tm_sec, 0);
end;
{$ENDIF POSIX}

function DateTimeToFileDate(DateTime: TDateTime): Integer;
{$IFDEF MSWINDOWS}
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  DecodeDate(DateTime, Year, Month, Day);
  if (Year < 1980) or (Year > 2107) then Result := 0 else
  begin
    DecodeTime(DateTime, Hour, Min, Sec, MSec);
    LongRec(Result).Lo := (Sec shr 1) or (Min shl 5) or (Hour shl 11);
    LongRec(Result).Hi := Day or (Month shl 5) or ((Year - 1980) shl 9);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  UnixTime: tm;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  DecodeDate(DateTime, Year, Month, Day);
  { Valid range for 32 bit Unix time_t:  1970 through 2038  }
  if (Year < 1970) or (Year > 2038) then
    Result := 0
  else
  begin
    DecodeTime(DateTime, Hour, Min, Sec, MSec);
    FillChar(UnixTime, sizeof(UnixTime), 0);
    UnixTime.tm_sec := Sec;
    UnixTime.tm_min := Min;
    UnixTime.tm_hour := Hour;
    UnixTime.tm_mday := Day;
    UnixTime.tm_mon  := Month - 1;
    UnixTime.tm_year := Year - 1900;
    UnixTime.tm_isdst := -1;
    Result := mktime(UnixTime);
  end;
end;
{$ENDIF POSIX}

function GetCurrentDir: string;
begin
  GetDir(0, Result);
end;

function SetCurrentDir(const Dir: string): Boolean;
{$IFDEF MSWINDOWS}
begin
  Result := SetCurrentDirectory(PChar(Dir));
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  M: TMarshaller;
begin
  Result := __chdir(M.AsAnsi(Dir, CP_UTF8).ToPointer) = 0;
end;
{$ENDIF POSIX}

function CreateDir(const Dir: string): Boolean;
{$IFDEF MSWINDOWS}
begin
  Result := CreateDirectory(PChar(Dir), nil);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  M: TMarshaller;
begin
  Result := __mkdir(M.AsAnsi(Dir, CP_UTF8).ToPointer, mode_t(-1)) = 0;
end;
{$ENDIF POSIX}

function RemoveDir(const Dir: string): Boolean;
{$IFDEF MSWINDOWS}
begin
  Result := RemoveDirectory(PChar(Dir));
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  StatBuf: _stat;
  M: TMarshaller;
  P: Pointer;
begin
  P := M.AsAnsi(Dir, CP_UTF8).ToPointer;
  if (lstat(P, StatBuf) = 0) and S_ISDIR(StatBuf.st_mode) and
    S_ISLNK(StatBuf.st_mode) then
  begin
    Result := unlink(P) <> -1;
  end
  else
    Result := __rmdir(P) = 0;
end;
{$ENDIF POSIX}

{ PChar routines }

{$IFNDEF NEXTGEN}
function StrLen(const Str: PAnsiChar): Cardinal;
{$IFNDEF LEGACYSTRLEN}
begin
  Result := Length(Str);
end;
{$ELSE !LEGACYSTRLEN}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function StrLen is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2007
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Pierre le Riche
 *
 * ***** END LICENSE BLOCK ***** *)
asm //StackAlignSafe
        {Check the first byte}
        CMP BYTE PTR [EAX], 0
        JE @ZeroLength
        {Get the negative of the string start in edx}
        MOV EDX, EAX
        NEG EDX
        {Word align}
        ADD EAX, 1
        AND EAX, -2
@ScanLoop:
        MOV CX, [EAX]
        ADD EAX, 2
        TEST CL, CH
        JNZ @ScanLoop
        TEST CL, CL
        JZ @ReturnLess2
        TEST CH, CH
        JNZ @ScanLoop
        LEA EAX, [EAX + EDX - 1]
        RET
@ReturnLess2:
        LEA EAX, [EAX + EDX - 2]
        RET
@ZeroLength:
        XOR EAX, EAX
end;
{$ENDIF X86ASM}
{$ENDIF !LEGACYSTRLEN}
{$ENDIF !NEXTGEN}

function StrLen(const Str: PWideChar): Cardinal;
{$IFNDEF LEGACYSTRLEN}
begin
  Result := Length(Str);
end;
{$ELSE !LEGACYSTRLEN}
{$IFDEF X86ASM}
asm
        {Check the first byte}
        CMP WORD PTR [EAX], 0
        JE @ZeroLength
        {Get the negative of the string start in edx}
        MOV EDX, EAX
        NEG EDX
@ScanLoop:
        MOV CX, WORD PTR [EAX]
        ADD EAX, 2
        TEST CX, CX
        JNZ @ScanLoop
        LEA EAX, [EAX + EDX - 2]
        SHR EAX, 1
        RET
@ZeroLength:
        XOR EAX, EAX
end;
{$ENDIF X86ASM}
{$ENDIF !LEGACYSTRLEN}

{$IFNDEF NEXTGEN}
function StrEnd(const Str: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
begin
  Result := Str;
  while Result^ <> #0 do
    Inc(Result);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        {Check the first byte}
        CMP BYTE PTR [EAX], 0
        JE @ZeroLength
        INC EAX
@ScanLoop:
        MOV CL, BYTE PTR [EAX]
        INC EAX
        TEST CL, CL
        JNZ @ScanLoop
        DEC EAX
        RET
@ZeroLength:
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrEnd(const Str: PWideChar): PWideChar;
{$IFDEF PUREPASCAL}
begin
  Result := Str;
  while Result^ <> #0 do
    Inc(Result);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAligneSafe
        {Check the first byte}
        CMP WORD PTR [EAX], 0
        JE @ZeroLength
        ADD EAX, 2
@ScanLoop:
        MOV CX, WORD PTR [EAX]
        ADD EAX, 2
        TEST CX, CX
        JNZ @ScanLoop
        SUB EAX, 2
        RET
@ZeroLength:
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

{$IFNDEF NEXTGEN}
function StrMove(Dest: PAnsiChar; const Source: PAnsiChar; Count: Cardinal): PAnsiChar;
begin
  Result := Dest;
  Move(Source^, Dest^, Count * SizeOf(AnsiChar));
end;
{$ENDIF !NEXTGEN}

function StrMove(Dest: PWideChar; const Source: PWideChar; Count: Cardinal): PWideChar;
begin
  Result := Dest;
  Move(Source^, Dest^, Count * SizeOf(WideChar));
end;

{$IFNDEF NEXTGEN}
function StrCopy(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
begin
  Move(Source^, Dest^, (StrLen(Source) + 1) * SizeOf(AnsiChar));
  Result := Dest;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function StrCopy is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Aleksandr Sharahov
 *
 * ***** END LICENSE BLOCK ***** *)
asm //StackAlignSafe
        SUB   EDX, EAX
        TEST  EAX, 1
        PUSH  EAX
        JZ    @loop
        MOVZX ECX, BYTE PTR[EAX+EDX]
        MOV   [EAX], CL
        TEST  ECX, ECX
        JZ    @RET
        INC   EAX
@loop:
        MOVZX ECX, BYTE PTR[EAX+EDX]
        TEST  ECX, ECX
        JZ    @move0
        MOVZX ECX, WORD PTR[EAX+EDX]
        MOV   [EAX], CX
        ADD   EAX, 2
        CMP   ECX, 255
        JA    @loop
@ret:
        POP   EAX
        RET
@move0:
        MOV   [EAX], CL
        POP   EAX
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar;
{$IFDEF PUREPASCAL}
begin
  Move(Source^, Dest^, (StrLen(Source) + 1) * SizeOf(WideChar));
  Result := Dest;
end;
{$ELSE}
asm //StackAlignSafe
        SUB   EDX, EAX
        TEST  EAX, 3
        PUSH  EAX
        JZ    @loop
        MOVZX ECX, WORD PTR[EAX+EDX]
        MOV   [EAX], CX
        TEST  ECX, ECX
        JZ    @ret
        ADD   EAX, 2
@loop:
        MOVZX ECX, WORD PTR[EAX+EDX]
        TEST  ECX, ECX
        JZ    @move0
        MOV   ECX, [EAX+EDX]
        MOV   [EAX], ECX
        ADD   EAX, 4
        CMP   ECX, $FFFF
        JA    @loop
@ret:
        POP   EAX
        RET
@move0:
        MOV   [EAX], CX
        POP   EAX
end;
{$ENDIF}

{$IFNDEF NEXTGEN}
function StrECopy(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
var
  Len: Integer;
begin
  Len := StrLen(Source);
  Move(Source^, Dest^, (Len + 1) * SizeOf(AnsiChar));
  Result := Dest + Len;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        MOV     ESI, EAX
        MOV     EDI, EDX
        MOV     ECX, 0FFFFFFFFH
        XOR     AL, AL
        REPNE   SCASB
        NOT     ECX
        MOV     EDI, ESI
        MOV     ESI, EDX
        MOV     EDX, ECX
        SHR     ECX, 2
        REP     MOVSD
        MOV     ECX, EDX
        AND     ECX, 3
        REP     MOVSB
        LEA     EAX, [EDI-1]
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrECopy(Dest: PWideChar; const Source: PWideChar): PWideChar;
var
  Len: Integer;
begin
  Len := StrLen(Source);
  Move(Source^, Dest^, (Len + 1) * SizeOf(WideChar));
  Result := Dest + Len;
end;

{$IFNDEF NEXTGEN}
function StrLCopy(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar;
{$IFDEF PUREPASCAL}
var
  Len: Cardinal;
begin
  Result := Dest;
  Len := StrLen(Source);
  if Len > MaxLen then
    Len := MaxLen;
  Move(Source^, Dest^, Len * SizeOf(AnsiChar));
  Dest[Len] := #0;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     ESI, EAX
        MOV     EDI, EDX
        MOV     EBX, ECX
        XOR     AL, AL
        TEST    ECX, ECX
        JZ      @@1
        REPNE   SCASB
        JNE     @@1
        INC     ECX
@@1:    SUB     EBX, ECX
        MOV     EDI, ESI
        MOV     ESI, EDX
        MOV     EDX, EDI
        MOV     ECX, EBX
        SHR     ECX, 2
        REP     MOVSD
        MOV     ECX, EBX
        AND     ECX, 3
        REP     MOVSB
        STOSB
        MOV     EAX, EDX
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrLCopy(Dest: PWideChar; const Source: PWideChar; MaxLen: Cardinal): PWideChar;
var
  Len: Cardinal;
begin
  Result := Dest;
  Len := StrLen(Source);
  if Len > MaxLen then
    Len := MaxLen;
  Move(Source^, Dest^, Len * SizeOf(WideChar));
  Dest[Len] := #0;
end;

{$IFNDEF NEXTGEN}
function StrPCopy(Dest: PAnsiChar; const Source: AnsiString): PAnsiChar;
begin
  Result := StrLCopy(Dest, PAnsiChar(Source), Length(Source));
end;
{$ENDIF !NEXTGEN}

function StrPCopy(Dest: PWideChar; const Source: UnicodeString): PWideChar;
begin
  Result := StrLCopy(Dest, PWideChar(Source), Length(Source));
end;

{$IFNDEF NEXTGEN}
function StrPLCopy(Dest: PAnsiChar; const Source: AnsiString; MaxLen: Cardinal): PAnsiChar;
begin
  Result := StrLCopy(Dest, PAnsiChar(Source), MaxLen);
end;
{$ENDIF !NEXTGEN}

function StrPLCopy(Dest: PWideChar; const Source: UnicodeString; MaxLen: Cardinal): PWideChar;
begin
  Result := StrLCopy(Dest, PWideChar(Source), MaxLen);
end;

{$IFNDEF NEXTGEN}
function StrCat(Dest: PAnsiChar; const Source: PAnsiChar): PAnsiChar;
begin
  StrCopy(StrEnd(Dest), Source);
  Result := Dest;
end;
{$ENDIF !NEXTGEN}

function StrCat(Dest: PWideChar; const Source: PWideChar): PWideChar;
begin
  StrCopy(StrEnd(Dest), Source);
  Result := Dest;
end;

{$IFNDEF NEXTGEN}
function StrLCat(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar;
{$IFDEF PUREPASCAL}
var
  DestLen: Cardinal;
begin
  Result := Dest;
  DestLen := StrLen(Dest);
  if DestLen < MaxLen then
    StrLCopy(PAnsiChar(@Dest[DestLen]), Source, MaxLen - DestLen);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAligned
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI,Dest
        MOV     ESI,Source
        MOV     EBX,MaxLen
        CALL    StrEnd
        MOV     ECX,EDI
        ADD     ECX,EBX
        SUB     ECX,EAX
        JBE     @@1
        MOV     EDX,ESI
        CALL    StrLCopy
@@1:    MOV     EAX,EDI
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrLCat(Dest: PWideChar; const Source: PWideChar; MaxLen: Cardinal): PWideChar;
var
  DestLen: Cardinal;
begin
  Result := Dest;
  DestLen := StrLen(Dest);
  if DestLen < MaxLen then
    StrLCopy(PWideChar(@Dest[DestLen]), Source, MaxLen - DestLen);
end;

{$IFNDEF NEXTGEN}
function StrComp(const Str1, Str2: PAnsiChar): Integer;
{$IFDEF PUREPASCAL}
var
  P1, P2: PAnsiChar;
begin
  P1 := Str1;
  P2 := Str2;
  while True do
  begin
    if (P1^ <> P2^) or (P1^ = #0) then
      Exit(Ord(P1^) - Ord(P2^));
    Inc(P1);
    Inc(P2);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
(* ***** BEGIN LICENSE BLOCK *****
 *
 * The function StrComp is licensed under the CodeGear license terms.
 *
 * The initial developer of the original code is Fastcode
 *
 * Portions created by the initial developer are Copyright (C) 2002-2004
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Aleksandr Sharahov
 *
 * ***** END LICENSE BLOCK ***** *)
asm //StackAlignSafe
        SUB   EDX, EAX
        JNZ   @next
        XOR   EAX, EAX
        JMP   @ret
@next:
        MOVZX ECX, [EAX+EDX]
        CMP   CL, [EAX]
        JNE   @stop
        TEST  CL, CL
        JZ    @stop
        MOVZX ECX, [EAX+EDX+1]
        CMP   CL, [EAX+1]
        JNE   @stop1
        TEST  CL, CL
        JZ    @stop1
        MOVZX ECX, [EAX+EDX+2]
        CMP   CL, [EAX+2]
        JNE   @stop2
        TEST  CL, CL
        JZ    @stop2
        MOVZX ECX, [EAX+EDX+3]
        CMP   CL, [EAX+3]
        JNE   @stop3
        ADD   EAX, 4
        TEST  CL, CL
        JZ    @stop4
        MOVZX ECX, [EAX+EDX]
        CMP   CL, [EAX]
        JNE   @stop
        TEST  CL, CL
        JZ    @stop
        MOVZX ECX, [EAX+EDX+1]
        CMP   CL, [EAX+1]
        JNE   @stop1
        TEST  CL, CL
        JZ    @stop1
        MOVZX ECX, [EAX+EDX+2]
        CMP   CL, [EAX+2]
        JNE   @stop2
        TEST  CL, CL
        JZ    @stop2
        MOVZX ECX, [EAX+EDX+3]
        CMP   CL, [EAX+3]
        JNE   @stop3
        ADD   EAX, 4
        TEST  CL, CL
        JNZ   @next
@stop4:
        SUB   EAX, 4
@stop3:
        ADD   EAX, 1
@stop2:
        ADD   EAX, 1
@stop1:
        ADD   EAX, 1
@stop:
        MOVZX EAX, [EAX]
        SUB   EAX, ECX
@ret:
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrComp(const Str1, Str2: PWideChar): Integer;
var
  P1, P2: PWideChar;
begin
  P1 := Str1;
  P2 := Str2;
  while True do
  begin
    if (P1^ <> P2^) or (P1^ = #0) then
      Exit(Ord(P1^) - Ord(P2^));
    Inc(P1);
    Inc(P2);
  end;
end;

{$IFNDEF NEXTGEN}
function StrIComp(const Str1, Str2: PAnsiChar): Integer;
{$IFDEF PUREPASCAL}
var
  P1, P2: PAnsiChar;
  C1, C2: AnsiChar;
begin
  P1 := Str1;
  P2 := Str2;
  while True do
  begin
    if P1^ in ['a'..'z'] then
      C1 := AnsiChar(Byte(P1^) xor $20)
    else
      C1 := P1^;

    if P2^ in ['a'..'z'] then
      C2 := AnsiChar(Byte(P2^) xor $20)
    else
      C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then
      Exit(Ord(C1) - Ord(C2));
    Inc(P1);
    Inc(P2);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     EAX,EAX
        REPNE   SCASB
        NOT     ECX
        MOV     EDI,EDX
        XOR     EDX,EDX
@@1:    REPE    CMPSB
        JE      @@4
        MOV     AL,[ESI-1]
        CMP     AL,'a'
        JB      @@2
        CMP     AL,'z'
        JA      @@2
        SUB     AL,20H
@@2:    MOV     DL,[EDI-1]
        CMP     DL,'a'
        JB      @@3
        CMP     DL,'z'
        JA      @@3
        SUB     DL,20H
@@3:    SUB     EAX,EDX
        JE      @@1
@@4:    POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrIComp(const Str1, Str2: PWideChar): Integer;
var
  P1, P2: PWideChar;
  C1, C2: WideChar;
begin
  P1 := Str1;
  P2 := Str2;
  while True do
  begin
    if P1^ in ['a'..'z'] then
      C1 := WideChar(Word(P1^) xor $20)
    else
      C1 := P1^;

    if P2^ in ['a'..'z'] then
      C2 := WideChar(Word(P2^) xor $20)
    else
      C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then
      Exit(Ord(C1) - Ord(C2));
    Inc(P1);
    Inc(P2);
  end;
end;

{$IFNDEF NEXTGEN}
function StrLComp(const Str1, Str2: PAnsiChar; MaxLen: Cardinal): Integer;
{$IFDEF PUREPASCAL}
var
  I: Cardinal;
  P1, P2: PAnsiChar;
begin
  P1 := Str1;
  P2 := Str2;
  I := 0;
  while I < MaxLen do
  begin
    if (P1^ <> P2^) or (P1^ = #0) then
      Exit(Ord(P1^) - Ord(P2^));

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI, EDX
        MOV     ESI, EAX
        MOV     EBX, ECX
        XOR     EAX, EAX
        OR      ECX, ECX
        JE      @@1
        REPNE   SCASB
        SUB     EBX, ECX
        MOV     ECX, EBX
        MOV     EDI, EDX
        XOR     EDX, EDX
        REPE    CMPSB
        MOV     AL, [ESI-1]
        MOV     DL, [EDI-1]
        SUB     EAX, EDX
@@1:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrLComp(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
var
  I: Cardinal;
  P1, P2: PWideChar;
begin
  P1 := Str1;
  P2 := Str2;
  I := 0;
  while I < MaxLen do
  begin
    if (P1^ <> P2^) or (P1^ = #0) then
      Exit(Ord(P1^) - Ord(P2^));

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;

{$IFNDEF NEXTGEN}
function StrLIComp(const Str1, Str2: PAnsiChar; MaxLen: Cardinal): Integer;
{$IFDEF PUREPASCAL}
var
  P1, P2: PAnsiChar;
  I: Cardinal;
  C1, C2: AnsiChar;
begin
  P1 := Str1;
  P2 := Str2;
  I := 0;
  while I < MaxLen do
  begin
    if P1^ in ['a'..'z'] then
      C1 := AnsiChar(Byte(P1^) xor $20)
    else
      C1 := P1^;

    if P2^ in ['a'..'z'] then
      C2 := AnsiChar(Byte(P2^) xor $20)
    else
      C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then
      Exit(Ord(C1) - Ord(C2));

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI, EDX
        MOV     ESI, EAX
        MOV     EBX, ECX
        XOR     EAX, EAX
        OR      ECX, ECX
        JE      @@4
        REPNE   SCASB
        SUB     EBX, ECX
        MOV     ECX, EBX
        MOV     EDI, EDX
        XOR     EDX, EDX
@@1:    REPE    CMPSB
        JE      @@4
        MOV     AL, [ESI-1]
        CMP     AL, 'a'
        JB      @@2
        CMP     AL, 'z'
        JA      @@2
        SUB     AL, 20H
@@2:    MOV     DL, [EDI-1]
        CMP     DL, 'a'
        JB      @@3
        CMP     DL, 'z'
        JA      @@3
        SUB     DL, 20H
@@3:    SUB     EAX, EDX
        JE      @@1
@@4:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrLIComp(const Str1, Str2: PWideChar; MaxLen: Cardinal): Integer;
var
  P1, P2: PWideChar;
  I: Cardinal;
  C1, C2: WideChar;
begin
  P1 := Str1;
  P2 := Str2;
  I := 0;
  while I < MaxLen do
  begin
    if P1^ in ['a'..'z'] then
      C1 := WideChar(Word(P1^) xor $20)
    else
      C1 := P1^;

    if P2^ in ['a'..'z'] then
      C2 := WideChar(Word(P2^) xor $20)
    else
      C2 := P2^;

    if (C1 <> C2) or (C1 = #0) then
      Exit(Ord(C1) - Ord(C2));

    Inc(P1);
    Inc(P2);
    Inc(I);
  end;
  Result := 0;
end;

{$IFNDEF NEXTGEN}
function StrScan(const Str: PAnsiChar; Chr: AnsiChar): PAnsiChar;
begin
  Result := Str;
  while Result^ <> #0 do
  begin
    if Result^ = Chr then
      Exit;
    Inc(Result);
  end;
  if Chr <> #0 then
    Result := nil;
end;
{$ENDIF !NEXTGEN}

function StrScan(const Str: PWideChar; Chr: WideChar): PWideChar;
begin
  Result := Str;
  while Result^ <> #0 do
  begin
    if Result^ = Chr then
      Exit;
    Inc(Result);
  end;
  if Chr <> #0 then
    Result := nil;
end;

{$IFNDEF NEXTGEN}
function StrRScan(const Str: PAnsiChar; Chr: AnsiChar): PAnsiChar;
var
  MostRecentFound: PAnsiChar;
begin
  if Chr = AnsiChar(#0) then
    Result := StrEnd(Str)
  else
  begin
    Result := nil;

    MostRecentFound := Str;
    while True do
    begin
      while MostRecentFound^ <> Chr do
      begin
        if MostRecentFound^ = AnsiChar(#0) then
          Exit;
        Inc(MostRecentFound);
      end;
      Result := MostRecentFound;
      Inc(MostRecentFound);
    end;
  end;
end;
{$ENDIF !NEXTGEN}

function StrRScan(const Str: PWideChar; Chr: WideChar): PWideChar;
var
  MostRecentFound: PWideChar;
begin
  if Chr = #0 then
    Result := StrEnd(Str)
  else
  begin
    Result := nil;

    MostRecentFound := Str;
    while True do
    begin
      while MostRecentFound^ <> Chr do
      begin
        if MostRecentFound^ = #0 then
          Exit;
        Inc(MostRecentFound);
      end;
      Result := MostRecentFound;
      Inc(MostRecentFound);
    end;
  end;
end;

{$IFNDEF NEXTGEN}
function StrPos(const Str1, Str2: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
var
  MatchStart, LStr1, LStr2: PAnsiChar;
begin
  Result := nil;
  if (Str1^ = #0) or (Str2^ = #0) then
    Exit;

  MatchStart := Str1;
  while MatchStart^<> #0 do
  begin
    if MatchStart^ = Str2^ then
    begin
      LStr1 := MatchStart+1;
      LStr2 := Str2+1;
      while True do
      begin
        if LStr2^ = #0 then
          Exit(MatchStart);
        if (LStr1^ <> LStr2^) or (LStr1^ = #0) then
          Break;
        Inc(LStr1);
        Inc(LStr2);
      end;
    end;
    Inc(MatchStart);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        OR      EAX, EAX
        JE      @@2
        OR      EDX, EDX
        JE      @@2
        MOV     EBX, EAX
        MOV     EDI, EDX
        XOR     AL, AL
        MOV     ECX, 0FFFFFFFFH
        REPNE   SCASB
        NOT     ECX
        DEC     ECX
        JE      @@2
        MOV     ESI, ECX
        MOV     EDI, EBX
        MOV     ECX, 0FFFFFFFFH
        REPNE   SCASB
        NOT     ECX
        SUB     ECX, ESI
        JBE     @@2
        MOV     EDI, EBX
        LEA     EBX, [ESI-1]
@@1:    MOV     ESI, EDX
        LODSB
        REPNE   SCASB
        JNE     @@2
        MOV     EAX, ECX
        PUSH    EDI
        MOV     ECX, EBX
        REPE    CMPSB
        POP     EDI
        MOV     ECX, EAX
        JNE     @@1
        LEA     EAX, [EDI-1]
        JMP     @@3
@@2:    XOR     EAX, EAX
@@3:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrPos(const Str1, Str2: PWideChar): PWideChar;
{$IFDEF PUREPASCAL}
var
  MatchStart, LStr1, LStr2: PWideChar;
begin
  Result := nil;
  if (Str1^ = #0) or (Str2^ = #0) then
    Exit;

  MatchStart := Str1;
  while MatchStart^<> #0 do
  begin
    if MatchStart^ = Str2^ then
    begin
      LStr1 := MatchStart+1;
      LStr2 := Str2+1;
      while True do
      begin
        if LStr2^ = #0 then
          Exit(MatchStart);
        if (LStr1^ <> LStr2^) or (LStr1^ = #0) then
          Break;
        Inc(LStr1);
        Inc(LStr2);
      end;
    end;
    Inc(MatchStart);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        OR      EAX, EAX
        JE      @@2
        OR      EDX, EDX
        JE      @@2
        MOV     EBX, EAX
        MOV     EDI, EDX
        XOR     AX, AX
        MOV     ECX, 0FFFFFFFFH
        REPNE   SCASW
        NOT     ECX
        DEC     ECX
        JE      @@2
        MOV     ESI, ECX
        MOV     EDI, EBX
        MOV     ECX, 0FFFFFFFFH
        REPNE   SCASW
        NOT     ECX
        SUB     ECX, ESI
        JBE     @@2
        MOV     EDI, EBX
        LEA     EBX, [ESI-1]
@@1:    MOV     ESI, EDX
        LODSW
        REPNE   SCASW
        JNE     @@2
        MOV     EAX, ECX
        PUSH    EDI
        MOV     ECX, EBX
        REPE    CMPSW
        POP     EDI
        MOV     ECX, EAX
        JNE     @@1
        LEA     EAX, [EDI-2]
        JMP     @@3
@@2:    XOR     EAX, EAX
@@3:    POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function StrPosLen(const Str1, Str2: PWideChar; Len1, Len2: Integer): PWideChar;
var
  I: Integer;
begin
  Result := nil;
  if Len1 = 0 then
    Exit;
  if Len2 = 0 then
    Exit;
  for I := 0 to Len1 - Len2 do
  begin
    if (Str1[I] <> #0) and (StrLComp(PWideChar(PByte(Str1) + I * SizeOf(WideChar)), Str2, Len2) = 0) then
    begin
      Result := PWideChar(PByte(Str1) + I * SizeOf(WideChar));
      Exit;
    end;
  end;
end;

{$IFNDEF NEXTGEN}
function StrUpper(Str: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
begin
  Result := Str;
  while Str^ <> #0 do
  begin
    if Str^ in ['a'..'z'] then
      Dec(Str^, $20);
    Inc(Str);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    ESI
        MOV     ESI, Str
        MOV     EDX, Str
@@1:    LODSB
        OR      AL, AL
        JE      @@2
        CMP     AL, 'a'
        JB      @@1
        CMP     AL, 'z'
        JA      @@1
        SUB     AL, 20H
        MOV     [ESI-1], AL
        JMP     @@1
@@2:    XCHG    EAX, EDX
        POP     ESI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrUpper(Str: PWideChar): PWideChar;
begin
  Result := Str;
  while Str^ <> #0 do
  begin
    if Str^ in ['a'..'z'] then
      Dec(Str^, $20);
    Inc(Str);
  end;
end;

{$IFNDEF NEXTGEN}
function StrLower(Str: PAnsiChar): PAnsiChar;
{$IFDEF PUREPASCAL}
begin
  Result := Str;
  while Str^ <> #0 do
  begin
    if Str^ in ['A'..'Z'] then
      Inc(Str^, $20);
    Inc(Str);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm //StackAlignSafe
        PUSH    ESI
        MOV     ESI, Str
        MOV     EDX, Str
@@1:    LODSB
        OR      AL, AL
        JE      @@2
        CMP     AL, 'A'
        JB      @@1
        CMP     AL, 'Z'
        JA      @@1
        ADD     AL, 20H
        MOV     [ESI-1], AL
        JMP     @@1
@@2:    XCHG    EAX, EDX
        POP     ESI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function StrLower(Str: PWideChar): PWideChar;
begin
  Result := Str;
  while Str^ <> #0 do
  begin
    if Str^ in ['A'..'Z'] then
      Inc(Str^, $20);
    Inc(Str);
  end;
end;

{$IFNDEF NEXTGEN}
function StrPas(const Str: PAnsiChar): AnsiString;
begin
  Result := Str;
end;
{$ENDIF !NEXTGEN}

function StrPas(const Str: PWideChar): UnicodeString;
begin
  Result := Str;
end;

{$IFNDEF NEXTGEN}
function AnsiStrAlloc(Size: Cardinal): PAnsiChar;
begin
  Inc(Size, SizeOf(Cardinal));
  GetMem(Result, Size);
  Cardinal(Pointer(Result)^) := Size;
  Inc(Result, SizeOf(Cardinal));
end;
{$ENDIF !NEXTGEN}

function WideStrAlloc(Size: Cardinal): PWideChar;
begin
  //BJK: Size should probably be char count, not bytes; but at least 'div 2' below prevents overrun.
  Size := Size * SizeOf(WideChar);
  Inc(Size, SizeOf(Cardinal));
  GetMem(Result, Size);
  Cardinal(Pointer(Result)^) := Size;
  Inc(Result, SizeOf(Cardinal) div 2);
end;

function StrAlloc(Size: Cardinal): PChar;
begin
  Result := WideStrAlloc(Size);
end;

{$IFNDEF NEXTGEN}
function StrBufSize(const Str: PAnsiChar): Cardinal;
var
  P: PAnsiChar;
begin
  P := Str;
  Dec(P, SizeOf(Cardinal));
  Result := Cardinal(Pointer(P)^) - SizeOf(Cardinal);
end;
{$ENDIF !NEXTGEN}

function StrBufSize(const Str: PWideChar): Cardinal;
var
  P: PWideChar;
begin
  P := Str;
  Dec(P, SizeOf(Cardinal) div 2);
  Result := (Cardinal(Pointer(P)^) - SizeOf(Cardinal)) div SizeOf(WideChar);
end;

{$IFNDEF NEXTGEN}
function StrNew(const Str: PAnsiChar): PAnsiChar;
var
  Size: Cardinal;
begin
  if Str = nil then Result := nil else
  begin
    Size := StrLen(Str) + 1;
    Result := StrMove(AnsiStrAlloc(Size), Str, Size);
  end;
end;
{$ENDIF !NEXTGEN}

function StrNew(const Str: PWideChar): PWideChar;
var
  Size: Cardinal;
begin
  if Str = nil then Result := nil else
  begin
    Size := StrLen(Str) + 1;
    Result := StrMove(WideStrAlloc(Size), Str, Size);
  end;
end;

{$IFNDEF NEXTGEN}
procedure StrDispose(Str: PAnsiChar);
begin
  if Str <> nil then
  begin
    Dec(Str, SizeOf(Cardinal));
    FreeMem(Str, Cardinal(Pointer(Str)^));
  end;
end;
{$ENDIF !NEXTGEN}

procedure StrDispose(Str: PWideChar);
begin
  if Str <> nil then
  begin
    Dec(Str, SizeOf(Cardinal) div 2);
    FreeMem(Str, Cardinal(Pointer(Str)^));
  end;
end;

{ String formatting routines }

procedure FormatError(ErrorCode: Integer; Format: PChar; FmtLen: Cardinal);
const
  FormatErrorStrs: array[0..1] of PResStringRec = (
    @SInvalidFormat, @SArgumentMissing);
var
  Buffer: array[0..31] of Char;
begin
  if FmtLen > 31 then FmtLen := 31;
                                                                            
  if StrByteType(Format, FmtLen-1) = mbLeadByte then Dec(FmtLen);
  StrMove(Buffer, Format, FmtLen);
  Buffer[FmtLen] := #0;
  ConvertErrorFmt(FormatErrorStrs[ErrorCode], [PChar(@Buffer)]);
end;

procedure WideFormatError(ErrorCode: Integer; Format: PWideChar; FmtLen: Cardinal);
var
  WideFormat: UnicodeString;
  FormatText: string;
begin
  SetLength(WideFormat, FmtLen);
  SetString(WideFormat, Format, FmtLen);
  FormatText := WideFormat;
  FormatError(ErrorCode, PChar(FormatText), FmtLen);
end;

{$IFNDEF NEXTGEN}
procedure AnsiFormatError(ErrorCode: Integer; Format: PAnsiChar; FmtLen: Cardinal);
var
  FormatText: string;
begin
  FormatText := UTF8ToUnicodeString(Format);
  FormatError(ErrorCode, PChar(FormatText), FmtLen);
end;

procedure FormatVarToStr(var S: AnsiString; const V: TVarData);
begin
  if Assigned(System.VarToLStrProc) then
    System.VarToLStrProc(S, V)
  else
    System.Error(reVarInvalidOp);
end;

procedure FormatClearStr(var S: AnsiString);
begin
  S := '';
end;
{$ENDIF !NEXTGEN}

{$IFNDEF NEXTGEN}
function FormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal;
begin
  Result := FormatBuf(Buffer, BufLen, Format, FmtLen, Args, FormatSettings);
end;
{$ENDIF !NEXTGEN}

function FormatBuf(Buffer: PWideChar; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal;
begin
  Result := FormatBuf(Buffer, BufLen, Format, FmtLen, Args, FormatSettings);
end;

function FormatBuf(Buffer: PWideChar; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal;
begin
  Result := WideFormatBuf(Buffer^, BufLen, Format, FmtLen, Args, AFormatSettings);
end;

function FormatBuf(var Buffer: UnicodeString; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal;
begin
  Result := FormatBuf(Buffer, BufLen, Format, FmtLen, Args, FormatSettings);
end;

function FormatBuf(var Buffer: UnicodeString; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal;
begin
  Result := WideFormatBuf(Buffer, BufLen, Format, FmtLen, Args, AFormatSettings);
end;

{$IFNDEF NEXTGEN}
function StrFmt(Buffer, Format: PAnsiChar; const Args: array of const): PAnsiChar;
begin
  Result := StrFmt(Buffer, Format, Args, FormatSettings);
end;
{$ENDIF !NEXTGEN}

function StrFmt(Buffer, Format: PWideChar; const Args: array of const): PWideChar;
begin
  Result := StrFmt(Buffer, Format, Args, FormatSettings);
end;

{$IFNDEF NEXTGEN}
function StrFmt(Buffer, Format: PAnsiChar; const Args: array of const;
  const AFormatSettings: TFormatSettings): PAnsiChar;
begin
  if (Buffer <> nil) and (Format <> nil) then
  begin
    Buffer[FormatBuf(Buffer^, MaxInt, Format^, StrLen(Format), Args,
      AFormatSettings)] := AnsiChar(#0);
    Result := Buffer;
  end
  else
    Result := nil;
end;
{$ENDIF !NEXTGEN}

function StrFmt(Buffer, Format: PWideChar; const Args: array of const;
  const AFormatSettings: TFormatSettings): PWideChar;
begin
  if (Buffer <> nil) and (Format <> nil) then
  begin
    Buffer[WideFormatBuf(Buffer^, MaxInt, Format^, StrLen(Format), Args,
      AFormatSettings)] := #0;
    Result := Buffer;
  end
  else
    Result := nil;
end;

{$IFNDEF NEXTGEN}
function StrLFmt(Buffer: PAnsiChar; MaxBufLen: Cardinal; Format: PAnsiChar;
  const Args: array of const): PAnsiChar;
begin
  Result := StrLFmt(Buffer, MaxBufLen, Format, Args, FormatSettings);
end;
{$ENDIF !NEXTGEN}

function StrLFmt(Buffer: PWideChar; MaxBufLen: Cardinal; Format: PWideChar;
  const Args: array of const): PWideChar;
begin
  Result := StrLFmt(Buffer, MaxBufLen, Format, Args, FormatSettings);
end;

{$IFNDEF NEXTGEN}
function StrLFmt(Buffer: PAnsiChar; MaxBufLen: Cardinal; Format: PAnsiChar;
  const Args: array of const; const AFormatSettings: TFormatSettings): PAnsiChar;
begin
  if (Buffer <> nil) and (Format <> nil) then
  begin
    Buffer[FormatBuf(Buffer^, MaxBufLen, Format^, StrLen(Format), Args,
      AFormatSettings)] := AnsiChar(#0);
    Result := Buffer;
  end
  else
    Result := nil;
end;
{$ENDIF !NEXTGEN}

function StrLFmt(Buffer: PWideChar; MaxBufLen: Cardinal; Format: PWideChar;
  const Args: array of const;
  const AFormatSettings: TFormatSettings): PWideChar;
begin
  if (Buffer <> nil) and (Format <> nil) then
  begin
    Buffer[WideFormatBuf(Buffer^, MaxBufLen, Format^, StrLen(Format), Args,
      AFormatSettings)] := #0;
    Result := Buffer;
  end
  else
    Result := nil;
end;

function Format(const Format: string; const Args: array of const): string;
begin
  Result := System.SysUtils.Format(Format, Args, FormatSettings);
end;

function Format(const Format: string; const Args: array of const;
  const AFormatSettings: TFormatSettings): string;
begin
  FmtStr(Result, Format, Args, AFormatSettings);
end;

procedure FmtStr(var Result: string; const Format: string;
  const Args: array of const);
begin
  FmtStr(Result, Format, Args, FormatSettings);
end;

procedure FmtStr(var Result: string; const Format: string;
  const Args: array of const; const AFormatSettings: TFormatSettings);
var
  Len, BufLen: Integer;
  Buffer: array[0..4095] of Char;
begin
  BufLen := Length(Buffer);
  if Length(Format) < (Length(Buffer) - (Length(Buffer) div 4)) then
    Len := FormatBuf(Buffer, Length(Buffer) - 1, Pointer(Format)^, Length(Format),
      Args, AFormatSettings)
  else
  begin
    BufLen := Length(Format);
    Len := BufLen;
  end;
  if Len >= BufLen - 1 then
  begin
    while Len >= BufLen - 1 do
    begin
      Inc(BufLen, BufLen);
      Result := '';          // prevent copying of existing data, for speed
      SetLength(Result, BufLen);
{$IFDEF UNICODE}
      Len := FormatBuf(PChar(Result), BufLen - 1, Pointer(Format)^,
        Length(Format), Args, AFormatSettings);
{$ELSE}
      Len := FormatBuf(Pointer(Result)^, BufLen - 1, Pointer(Format)^,
        Length(Format), Args, AFormatSettings);
{$ENDIF}
    end;
    SetLength(Result, Len);
  end
  else
    SetString(Result, Buffer, Len);
end;

{$IFNDEF NEXTGEN}
procedure WideFormatVarToStr(var S: WideString; const V: TVarData);
begin
  if Assigned(System.VarToWStrProc) then
    System.VarToWStrProc(S, V)
  else
    System.Error(reVarInvalidOp);
end;
{$ENDIF !NEXTGEN}

function WideFloatToText(BufferArg: PWideChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer): Integer;
begin
  Result := FloatToText(BufferArg, Value, ValueType, Format, Precision, Digits);
end;

function FloatToTextEx(BufferArg: PChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): Integer;
begin
  Result := FloatToText(BufferArg, Value, ValueType, Format, Precision, Digits,
    AFormatSettings);
end;

{$IFNDEF NEXTGEN}
function AnsiFloatToTextEx(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): Integer;
begin
  Result := FloatToText(BufferArg, Value, ValueType, Format, Precision, Digits,
    AFormatSettings);
end;
{$ENDIF !NEXTGEN}

function WideFormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const): Cardinal;
begin
  Result := WideFormatBuf(Buffer, BufLen, Format, FmtLen, Args, FormatSettings);
end;

{ DEFINE LEGACY_FORMAT} // Define this to enable the old ASM code for Win32.

                                                                                                                                                                                                               
function WideFormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal;
{$IF not defined(LEGACY_FORMAT) or defined(PUREPASCAL)}
var
  BufPtr: PChar;
  FormatPtr: PChar;
  FormatStartPtr: PChar;
  FormatEndPtr: PChar;
  ArgsIndex: Integer;
  ArgsLength: Integer;
  BufMaxLen: Cardinal;
  Overwrite: Boolean;
  FormatChar: Char;
  S: string;
  StrBuf: array[0..64] of Char;
  LeftJustification: Boolean;
  Width: Integer;
  Precision: Integer;
  Len: Integer;
  FirstNumber: Integer;
  CurrentArg: TVarRec;
  FloatVal: TFloatValue;

  function ApplyWidth(NumChar, Negitive: Integer): Boolean;
  var
    I: Integer;
    Max: Integer;
  begin
    Result := False;
    if (Precision > NumChar) and (FormatChar <> 'S') then
      Max := Precision
    else
      Max := NumChar;
    if (Width <> -1) and (Width > Max + Negitive) then
    begin
      for I := Max + 1  + Negitive to Width do
      begin
        if BufMaxLen = 0 then
        begin
          Result := True;
          Break;
        end;
        BufPtr^ := ' ';
        Inc(BufPtr);
        Dec(BufMaxLen, Sizeof(Char));
      end;
    end;
  end;

  function AddBuf(const AItem: PChar; ItemLen: Integer = -1; StringLen: Integer = -1): Boolean;
  var
    NumChar: Integer;
    Len: Integer;
    I: Integer;
    Item: PChar;
    Negitive: Integer;
    BytesToCopy: Cardinal;
  begin
    Item := AItem;
    if Assigned(AItem) then
      if StringLen = -1 then
        NumChar := StrLen(Item)
      else
        NumChar := StringLen
    else
      NumChar := 0;
    if (ItemLen > -1) and (NumChar > ItemLen) then
      NumChar := ItemLen;
    Len := NumChar * Sizeof(Char);
    if (Assigned(AItem)) and (Item^ = '-') and (FormatChar <> 'S') then
    begin
      Dec(Len, Sizeof(Char));
      Dec(NumChar);
      Negitive := 1;
    end
    else
      Negitive := 0;
    if not LeftJustification then
    begin
      Result := ApplyWidth(NumChar, Negitive);
      if Result then
        Exit;
    end;
    if Negitive = 1 then
    begin
      if BufMaxLen = 0 then
      begin
        Result := True;
        Exit;
      end;
      Inc(Item);
      BufPtr^ := '-';
      Inc(BufPtr);
      Dec(BufMaxLen, Sizeof(Char));
    end;
    if (Precision <> -1) and (Precision > NumChar) and (FormatChar <> 'S') then
      for I := NumChar + 1 to Precision do
      begin
        if BufMaxLen = 0 then
        begin
          Result := True;
          Exit;
        end;
        BufPtr^ := '0';
        Inc(BufPtr);
        Dec(BufMaxLen, Sizeof(Char));
      end;
    if Assigned(AItem) then
    begin
      Result := BufMaxLen < Cardinal(Len);
      if Result then
        BytesToCopy := BufMaxLen
      else
        BytesToCopy := Len;
      Move(Item^, BufPtr^, BytesToCopy);
      BufPtr := PChar(PByte(BufPtr) + BytesToCopy);
      Dec(BufMaxLen, BytesToCopy);
    end
    else
      Result := False;
    if LeftJustification then
      Result := ApplyWidth(NumChar, Negitive);
  end;

  function VariantToUnicodeString(V: TVarData): string;
  begin
    Result := '';
    if V.VType <> varNull then
    begin
      if Assigned(System.VarToUStrProc) then
        System.VarToUStrProc(Result, V)
      else
        System.Error(reVarInvalidOp);
    end;
  end;

begin
  if (not Assigned(@Buffer)) or  (not Assigned(@Format)) then
  begin
    Result := 0;
    Exit;
  end;
  ArgsIndex := -1;
  ArgsLength := Length(Args);
  BufPtr := PChar(@Buffer);
  FormatPtr := PChar(@Format);
  if BufLen < $7FFFFFFF then
    BufMaxLen := BufLen * Sizeof(Char)
  else
    BufMaxLen := BufLen;
  FormatEndPtr := FormatPtr + FmtLen;
  while FormatPtr < FormatEndPtr do
    if FormatPtr^ = '%' then
    begin
      Inc(FormatPtr);
      if FormatPtr >= FormatEndPtr then
        Break;
      if FormatPtr^ = '%' then
      begin
        if BufMaxLen = 0 then
          FormatError(0, PChar(@Format), FmtLen);
        BufPtr^ := FormatPtr^;
        Inc(FormatPtr);
        Inc(BufPtr);
        Dec(BufMaxLen, Sizeof(Char));
        Continue;
      end;
      Width := -1;
      // Gather Index
      Inc(ArgsIndex);
      if FormatPtr^.IsNumber then
      begin
        FormatStartPtr := FormatPtr;
        while (FormatPtr < FormatEndPtr) and (FormatPtr^.IsNumber) do
          Inc(FormatPtr);
        if FormatStartPtr <> FormatPtr then
        begin
          StrLCopy(StrBuf, FormatStartPtr, Integer(FormatPtr - FormatStartPtr));
          if not TryStrToInt(StrBuf, FirstNumber) then
            FormatError(0, PChar(@Format), FmtLen);
          if FormatPtr^ = ':' then
          begin
            Inc(FormatPtr);
            ArgsIndex := FirstNumber;
          end
          else
            Width := FirstNumber;
        end;
      end
      else if FormatPtr^ = ':' then
      begin
        ArgsIndex := 0;
        Inc(FormatPtr);
      end;
      // Gather Justification
      if FormatPtr^ = '-' then
      begin
        LeftJustification := True;
        Inc(FormatPtr);
      end
      else
        LeftJustification := False;
      // Gather Width
      FormatStartPtr := FormatPtr;
      if FormatPtr^ = '*' then
      begin
        Width := -2;
        Inc(FormatPtr);
      end
      else if FormatPtr^.IsNumber then
      begin
        while (FormatPtr < FormatEndPtr) and (FormatPtr^.IsNumber) do
          Inc(FormatPtr);
        if FormatStartPtr <> FormatPtr then
        begin
          StrLCopy(StrBuf, FormatStartPtr, Integer(FormatPtr - FormatStartPtr));
          if not TryStrToInt(StrBuf, Width) then
            FormatError(0, PChar(@Format), FmtLen);
        end
      end;
      // Gather Precision
      if FormatPtr^ = '.' then
      begin
        Inc(FormatPtr);
        if (FormatPtr >= FormatEndPtr) then
          Break;
        if FormatPtr^ = '*' then
        begin
          Precision := -2;
          Inc(FormatPtr);
        end
        else
        begin
          FormatStartPtr := FormatPtr;
          while (FormatPtr < FormatEndPtr) and (FormatPtr^.IsNumber) do
            Inc(FormatPtr);
          StrLCopy(StrBuf, FormatStartPtr, Integer(FormatPtr - FormatStartPtr));
          if not TryStrToInt(StrBuf, Precision) then
            Precision := -1;
        end;
      end
      else
        Precision := -1;

      // Gather Conversion Character
      if not FormatPtr^.IsLetter then
        Break;
      case FormatPtr^ of
        'a'..'z':
          FormatChar := Char(Word(FormatPtr^) xor $0020);
      else
        FormatChar := FormatPtr^;
      end;
      Inc(FormatPtr);

      // Handle Args
      if Width = -2 then // If * width was found
      begin
        if ArgsIndex >= ArgsLength then
          FormatError(1, PChar(@Format), FmtLen);
        if Args[ArgsIndex].VType = vtInteger then
        begin
          if ArgsIndex >= ArgsLength then
            FormatError(1, PChar(@Format), FmtLen);
          Width := Args[ArgsIndex].VInteger;
          if Width < 0 then
          begin
            LeftJustification := not LeftJustification;
            Width := -Width;
          end;
          Inc(ArgsIndex);
        end
        else
          FormatError(0, PChar(@Format), FmtLen);
      end;
      if Precision = -2 then
      begin
        if ArgsIndex >= ArgsLength then
          FormatError(1, PChar(@Format), FmtLen);
        if Args[ArgsIndex].VType = vtInteger then
        begin
          if ArgsIndex >= ArgsLength then
            FormatError(1, PChar(@Format), FmtLen);
          Precision := Args[ArgsIndex].VInteger;
          Inc(ArgsIndex);
        end
        else
          FormatError(0, PChar(@Format), FmtLen);
      end;

      if ArgsIndex >= ArgsLength then
        FormatError(1, PChar(@Format), FmtLen);
      CurrentArg := Args[ArgsIndex];

      Overwrite := False;
      case CurrentArg.VType of
        vtBoolean,
        vtObject,
        vtClass,
        vtInterface: FormatError(0, PChar(@Format), FmtLen);
        vtInteger:
          begin
            if (Precision > 16) or (Precision = -1) then
              Precision := 0;
            case FormatChar of
              'D': S := IntToStr(CurrentArg.VInteger);
              'U': S := UIntToStr(Cardinal(CurrentArg.VInteger));
              'X': S := IntToHex(CurrentArg.VInteger, 0);
            else
              FormatError(0, PChar(@Format), FmtLen);
            end;
            Overwrite := AddBuf(PChar(S));
          end;
        vtWideChar,
        vtChar:
          if FormatChar = 'S' then
          begin
              if CurrentArg.VType = vtChar then
                S := Char(CurrentArg.VChar)
              else
                S := Char(CurrentArg.VWideChar);
            Overwrite := AddBuf(PChar(S), Precision);
          end
          else
            FormatError(0, PChar(@Format), FmtLen);
        vtExtended, vtCurrency:
          begin
            if CurrentArg.VType = vtExtended then
              FloatVal := fvExtended
            else
              FloatVal := fvCurrency;
            Len := 0;
            if (FormatChar = 'G') or (FormatChar = 'E') then
            begin
              if Cardinal(Precision) > 18 then
                Precision := 15;
            end
            else if Cardinal(Precision) > 18 then
            begin
              Precision := 2;
              if FormatChar = 'M' then
                Precision := AFormatSettings.CurrencyDecimals;
            end;
            case FormatChar of
              'G': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffGeneral, Precision, 3, AFormatSettings);
              'E': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffExponent, Precision, 3, AFormatSettings);
              'F': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffFixed, 18, Precision, AFormatSettings);
              'N': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffNumber, 18, Precision, AFormatSettings);
              'M': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffCurrency, 18, Precision, AFormatSettings);
            else
              FormatError(0, PChar(@Format), FmtLen);
            end;
            StrBuf[Len] := #0;
            Precision := 0;
            Overwrite := AddBuf(StrBuf);
          end;
        vtPointer:
          if FormatChar = 'P' then
          begin
            S := IntToHex(IntPtr(CurrentArg.VPointer), SizeOf(Pointer)*2);
            Overwrite := AddBuf(PChar(S));
          end
          else
            FormatError(0, PChar(@Format), FmtLen);
        vtPChar:
          if FormatChar = 'S' then
            Overwrite := AddBuf(PChar(UnicodeString(CurrentArg.VPChar)), Precision)
          else
            FormatError(0, PChar(@Format), FmtLen);
        vtPWideChar:
          if FormatChar = 'S' then
            Overwrite := AddBuf(CurrentArg.VPWideChar, Precision)
          else
            FormatError(0, PChar(@Format), FmtLen);
{$IFNDEF NEXTGEN}
        vtString:
          if FormatChar = 'S' then
            Overwrite := AddBuf(PChar(UnicodeString(PShortString(CurrentArg.VAnsiString)^)), Precision)
          else
            FormatError(0, PChar(@Format), FmtLen);
        vtAnsiString:
          if FormatChar = 'S' then
          begin
            S := UnicodeString(AnsiString(CurrentArg.VAnsiString));
            Overwrite := AddBuf(PChar(S), Precision, Length(S));
          end
          else
            FormatError(0, PChar(@Format), FmtLen);
        vtWideString:
          if FormatChar = 'S' then
            Overwrite := AddBuf(CurrentArg.VWideString, Precision,
              Length(WideString(CurrentArg.VWideString)))
          else
            FormatError(0, PChar(@Format), FmtLen);
{$ENDIF !NEXTGEN}
        vtVariant:
          if FormatChar = 'S' then
            Overwrite := AddBuf(PChar(VariantToUnicodeString(TVarData(CurrentArg.VVariant^))), Precision)
          else
            FormatError(0, PChar(@Format), FmtLen);
        vtInt64:
          begin
            if (Precision > 32) or (Precision = -1)  then
              Precision := 0;
            case FormatChar of
              'D': S := IntToStr(CurrentArg.VInt64^);
              'U': S := UIntToStr(UInt64(CurrentArg.VInt64^));
              'X': S := IntToHex(CurrentArg.VInt64^, 0);
            else
              FormatError(0, PChar(@Format), FmtLen);
            end;
            Overwrite := AddBuf(PChar(S));
          end;
        vtUnicodeString:
          if FormatChar = 'S' then
            Overwrite := AddBuf(CurrentArg.VUnicodeString, Precision,
              Length(string(CurrentArg.VUnicodeString)))
          else
            FormatError(0, PChar(@Format), FmtLen);
      end;
      if Overwrite then
      begin
        Result := BufPtr - PChar(@Buffer);
        Exit;
      end;
    end
    else
    begin
      if BufMaxLen = 0 then
      begin
        Result := BufPtr - PChar(@Buffer);
        Exit;
      end;
      BufPtr^ := FormatPtr^;
      Inc(FormatPtr);
      Inc(BufPtr);
      Dec(BufMaxLen, Sizeof(Char));
    end;
  Result := BufPtr - PChar(@Buffer);
end;
{$ELSE LEGACY_FORMAT or !PUREPASCAL}
{$IFDEF X86ASM}
var
  ArgIndex, Width, Prec: Integer;
  BufferOrg, FormatOrg, FormatPtr: PWideChar;
  JustFlag: WideChar;
  StrBuf: array[0..64] of WideChar;
  TempWideStr: WideString;
  SaveGOT: Integer;
asm
{ in: eax <-> Buffer }
{ in: edx <-> BufLen }
{ in: ecx <-> Format }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        MOV     EDI,EAX
        MOV     ESI,ECX
{$IFDEF PIC}
        CALL    GetGOT
{$ELSE !PIC}
        XOR     EAX,EAX
{$ENDIF !PIC}
        MOV     SaveGOT,EAX
        MOV     ECX,FmtLen
        LEA     ECX,[ECX*2+ESI]
        MOV     BufferOrg,EDI
        XOR     EAX,EAX
        MOV     ArgIndex,EAX
        MOV     TempWideStr,EAX

@Loop:
        OR      EDX,EDX
        JE      @Done

@NextChar:
        CMP     ESI,ECX
        JE      @Done
        LODSW
        CMP     AX,'%'
        JE      @Format

@StoreChar:
        STOSW
        DEC     EDX
        JNE     @NextChar

@Done:
        MOV     EAX,EDI
        SUB     EAX,BufferOrg
        SHR     EAX,1
        JMP     @Exit

@Format:
        CMP     ESI,ECX
        JE      @Done
        LODSW
        CMP     AX,'%'
        JE      @StoreChar
        LEA     EBX,[ESI-4]
        MOV     FormatOrg,EBX
@A0:    MOV     JustFlag,AX
        CMP     AX,'-'
        JNE     @A1
        CMP     ESI,ECX
        JE      @Done
        LODSW
@A1:    CALL    @Specifier
        CMP     AX,':'
        JNE     @A2
        MOV     ArgIndex,EBX
        CMP     ESI,ECX
        JE      @Done
        LODSW
        JMP     @A0

@A2:    OR      EBX, EBX
        JNS     @A2_3
        NEG     EBX
        CMP     JustFlag, '-'
        JE      @A2_2
        MOV     JustFlag, '-'
        JMP     @A2_3

@A2_2:  MOV     JustFlag, '*'

@A2_3:  MOV     Width,EBX
        MOV     EBX,-1
        CMP     AX,'.'
        JNE     @A3
        CMP     ESI,ECX
        JE      @Done
        LODSW
        CALL    @Specifier
@A3:    MOV     Prec,EBX
        MOV     FormatPtr,ESI
        PUSH    ECX
        PUSH    EDX
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF}
        CALL    @Convert
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF}

        POP     EDX
        MOV     EBX,Width
        SUB     EBX,ECX        //(* ECX <=> number of characters output *)
        JAE     @A4            //(*         jump -> output smaller than width *)
        XOR     EBX,EBX

@A4:    CMP     JustFlag,'-'
        JNE     @A6
        SUB     EDX,ECX
        JAE     @A5
        ADD     ECX,EDX
        XOR     EDX,EDX

@A5:    REP     MOVSW

@A6:    XCHG    EBX,ECX
        SUB     EDX,ECX
        JAE     @A7
        ADD     ECX,EDX
        XOR     EDX,EDX
@A7:    MOV     AX,' '
        REP     STOSW
        XCHG    EBX,ECX
        SUB     EDX,ECX
        JAE     @A8
        ADD     ECX,EDX
        XOR     EDX,EDX
@A8:    REP     MOVSW
        POP     ECX
        MOV     ESI,FormatPtr
        JMP     @Loop

@Specifier:
        XOR     EBX,EBX
        CMP     AX,'*'
        JE      @B3
@B1:    CMP     AX,'0'
        JB      @B5
        CMP     AX,'9'
        JA      @B5
        IMUL    EBX,EBX,10
        SUB     AX,'0'
        MOVZX   EAX,AX
        ADD     EBX,EAX
        CMP     ESI,ECX
        JE      @B2
        LODSW
        JMP     @B1
@B2:    POP     EAX
        JMP     @Done
@B3:    MOV     EAX,ArgIndex
        CMP     EAX,Args.Integer[-4]
        JG      @B4
        INC     ArgIndex
        MOV     EBX,Args
        CMP     [EBX+EAX*8].Byte[4],vtInteger
        MOV     EBX,[EBX+EAX*8]
        JE      @B4
        XOR     EBX,EBX
@B4:    CMP     ESI,ECX
        JE      @B2
        LODSW
@B5:    RET

@Convert:
        AND     AL,0DFH
        MOV     CL,AL
        MOV     EAX,1
        MOV     EBX,ArgIndex
        CMP     EBX,Args.Integer[-4]
        JG      @ErrorExit
        INC     ArgIndex
        MOV     ESI,Args
        LEA     ESI,[ESI+EBX*8]
        MOV     EAX,[ESI].Integer[0]       // TVarRec.data
        MOVZX   EDX,[ESI].Byte[4]          // TVarRec.VType
{$IFDEF PIC}
        MOV     EBX, SaveGOT
        ADD     EBX, offset @CvtVector
        MOV     EBX, [EBX+EDX*4]
        ADD     EBX, SaveGOT
        JMP     EBX
{$ELSE !PIC}
        JMP     @CvtVector.Pointer[EDX*4]
{$ENDIF !PIC}

@CvtVector:
        DD      @CvtInteger                // vtInteger
        DD      @CvtBoolean                // vtBoolean
        DD      @CvtChar                   // vtChar
        DD      @CvtExtended               // vtExtended
        DD      @CvtShortStr               // vtString
        DD      @CvtPointer                // vtPointer
        DD      @CvtPChar                  // vtPChar
        DD      @CvtObject                 // vtObject
        DD      @CvtClass                  // vtClass
        DD      @CvtWideChar               // vtWideChar
        DD      @CvtPWideChar              // vtPWideChar
        DD      @CvtAnsiStr                // vtAnsiString
        DD      @CvtCurrency               // vtCurrency
        DD      @CvtVariant                // vtVariant
        DD      @CvtInterface              // vtInterface
        DD      @CvtWideString             // vtWideString
        DD      @CvtInt64                  // vtInt64
        DD      @CvtUnicodeString          // vtUnicodeString

@CvtBoolean:
@CvtObject:
@CvtClass:
@CvtInterface:
@CvtError:
        XOR     EAX,EAX

@ErrorExit:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF}
        CALL    @ClearTmpWideStr
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF}
        MOV     EDX,FormatOrg
        MOV     ECX,FormatPtr
        SUB     ECX,EDX
        SHR     ECX,1
        MOV     EBX, SaveGOT
{$IFDEF PC_MAPPED_EXCEPTIONS}
        //  Because of all the assembly code here, we can't call a routine
        //  that throws an exception if it looks like we're still on the
        //  stack.  The static disassembler cannot give sufficient unwind
        //  frame info to unwind the confusion that is generated from the
        //  assembly code above.  So before we throw the exception, we
        //  go to some lengths to excise ourselves from the stack chain.
        //  We were passed 12 bytes of parameters on the stack, and we have
        //  to make sure that we get rid of those, too.
{$IFDEF ALIGN_STACK}
        MOV     ESP, EBP        // Ditch everthing to the frame
        POP     EBP             // Ditch the rest of the frame
{$ELSE  !ALIGN_STACK}
        MOV     ESP, EBP        // Ditch everthing to the frame
        MOV     EBP, [ESP + 4]  // Get the return addr
        MOV     [ESP + 16], EBP // Move the ret addr up in the stack
        POP     EBP             // Ditch the rest of the frame
        ADD     ESP, 12         // Ditch the space that was taken by params
{$ENDIF !ALIGN_STACK}
        JMP     WideFormatError // Off to FormatErr
{$ELSE !PC_MAPPED_EXCEPTIONS}
        CALL    WideFormatError
{$ENDIF !PC_MAPPED_EXCEPTIONS}
        // The above call raises an exception and does not return

@CvtInt64:
        // CL  <= format character
        // EAX <= address of int64
        // EBX <= TVarRec.VType

        LEA     ESI,StrBuf[64]
        MOV     EDX,Prec
        CMP     EDX, 32
        JBE     @I64_1           // zero padded field width > buffer => no padding
        XOR     EDX, EDX
@I64_1: MOV     EBX, ECX
        SUB     CL, 'D'
        JZ      CvtInt64W         // branch predict backward jump taken
        MOV     ECX,16
        CMP     BL, 'X'
        JE      CvtInt64W
        MOV     ECX, 10
        CMP     BL, 'U'
        JE      CvtInt64W
        JMP     @CvtError

@CvtInteger:
        LEA     ESI,StrBuf[32]
        MOV     EDX,Prec
        MOV     EBX, ECX
        CMP     EDX,16
        JBE     @C1             // zero padded field width > buffer => no padding
        XOR     EDX, EDX
@C1:    SUB     CL, 'D'
        JZ      CvtIntW          // branch predict backward jump taken
        MOV     ECX, 16
        CMP     BL, 'X'
        JE      CvtIntW
        MOV     ECX, 10
        CMP     BL, 'U'
        JE      CvtIntW
        JMP     @CvtError

@CvtChar:
        CMP     CL,'S'
        JNE     @CvtError
        MOV     EAX,ESI
        MOV     ECX,1
        JMP     @CvtAnsiThingLen

@CvtWideChar:
        CMP     CL,'S'
        JNE     @CvtError
        MOV     ECX,1
        JMP     @CvtWideStrLen

@CvtVariant:
        CMP     CL,'S'
        JNE     @CvtError
        CMP     [EAX].TVarData.VType,varNull
        JBE     @CvtEmptyStr
        MOV     EDX,EAX
        LEA     EAX,TempWideStr
        CALL    WideFormatVarToStr
        MOV     ESI,TempWideStr
        JMP     @CvtWideStrRef

@CvtEmptyStr:
        XOR     ECX,ECX
        RET

@CvtShortStr:
        CMP     CL,'S'
        JNE     @CvtError
        MOVZX   ECX,BYTE PTR [EAX]
        INC     EAX

@CvtAnsiThingLen:
        MOV     ESI,OFFSET System.@WStrFromPCharLen
        JMP     @CvtAnsiThing

@CvtPChar:
        MOV    ESI,OFFSET System.@WStrFromPChar
        JMP    @CvtAnsiThingTest

@CvtAnsiStr:
        MOV    ESI,OFFSET System.@WStrFromLStr

@CvtAnsiThingTest:
        CMP    CL,'S'
        JNE    @CvtError

@CvtAnsiThing:
{$IFDEF PIC}
        ADD    ESI, SaveGOT
{$ENDIF PIC}
        MOV    EDX,EAX
        LEA    EAX,TempWideStr
{$IFDEF ALIGN_STACK}
        SUB    ESP, 8
{$ENDIF}
        PUSH   EBX
        MOV    EBX, SaveGOT
        CALL   ESI
        POP    EBX
{$IFDEF ALIGN_STACK}
        ADD    ESP, 8
{$ENDIF}
        MOV    ESI,TempWideStr
        JMP    @CvtWideStrRef

@CvtUnicodeString:
        CMP     CL,'S'
        JNE     @CvtError
        MOV     ESI,EAX
        OR      ESI,ESI
        JE      @CvtEmptyStr
        MOV     ECX,[ESI-4]
        JMP     @CvtWideStrLen

@CvtWideString:
        CMP     CL,'S'
        JNE     @CvtError
        MOV     ESI,EAX

@CvtWideStrRef:
        OR      ESI,ESI
        JE      @CvtEmptyStr
        MOV     ECX,[ESI-4]
{$IFDEF MSWINDOWS}
        SHR     ECX,1
{$ENDIF}

@CvtWideStrLen:
        CMP     ECX,Prec
        JA      @E1
        RET
@E1:    MOV     ECX,Prec
        RET

@CvtPWideChar:
        CMP     CL,'S'
        JNE     @CvtError
        MOV     ESI,EAX
        PUSH    EDI
        MOV     EDI,EAX
        XOR     EAX,EAX
        MOV     ECX,Prec
        JECXZ   @F1
        REPNE   SCASW
        JNE     @F1
        DEC     EDI
        DEC     EDI
@F1:    MOV     ECX,EDI
        SUB     ECX,ESI
        SHR     ECX,1
        POP     EDI
        RET

@CvtPointer:
        CMP     CL,'P'
        JNE     @CvtError
        MOV     EDX,8
        MOV     ECX,16
        LEA     ESI,StrBuf[32]
        JMP     CvtIntW

@CvtCurrency:
        MOV     BH,fvCurrency
        JMP     @CvtFloat

@CvtExtended:
        MOV     BH,fvExtended

@CvtFloat:
        MOV     ESI,EAX
        MOV     BL,ffGeneral
        CMP     CL,'G'
        JE      @G2
        MOV     BL,ffExponent
        CMP     CL,'E'
        JE      @G2
        MOV     BL,ffFixed
        CMP     CL,'F'
        JE      @G1
        MOV     BL,ffNumber
        CMP     CL,'N'
        JE      @G1
        CMP     CL,'M'
        JNE     @CvtError
        MOV     BL,ffCurrency
@G1:    MOV     EAX,18
        MOV     EDX,Prec
        CMP     EDX,EAX
        JBE     @G3
        MOV     EDX,2
        CMP     CL,'M'
        JNE     @G3
        MOV     EDX,AFormatSettings
        MOVZX   EDX,[EDX].TFormatSettings.CurrencyDecimals
        JMP     @G3
@G2:    MOV     EAX,Prec
        MOV     EDX,3
        CMP     EAX,18
        JBE     @G3
        MOV     EAX,15
@G3:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        PUSH    EBX
        PUSH    EAX
        PUSH    EDX
        MOV     EDX,[AFormatSettings]
        PUSH    EDX
        LEA     EAX,StrBuf
        MOV     EDX,ESI
        MOVZX   ECX,BH
        MOV     EBX, SaveGOT
        CALL    FloatToTextEx
        MOV     ECX,EAX
        LEA     EDX,StrBuf
        LEA     EAX,TempWideStr
        MOV     EBX, SaveGOT
        CALL    System.@WStrFromPWCharLen
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        MOV     ESI,TempWideStr
        OR      ESI,ESI
        JE      @CvtEmptyStr
        MOV     ECX,[ESI-4]
{$IFDEF MSWINDOWS}
        SHR     ECX,1
{$ENDIF}
        RET

@ClearTmpWideStr:
        PUSH    EBX
        PUSH    EAX
        LEA     EAX,TempWideStr
        MOV     EBX, SaveGOT
{$IFDEF ALIGN_STACK}
        SUB     ESP, 4
{$ENDIF}
        CALL    System.@WStrClr
{$IFDEF ALIGN_STACK}
        ADD     ESP, 4
{$ENDIF}
        POP     EAX
        POP     EBX
        RET

@Exit:
        CALL    @ClearTmpWideStr
        POP     EDI
        POP     ESI
        POP     EBX
end;
{$ENDIF X86ASM}
{$ENDIF LEGACY_FORMAT or !PUREPASCAL}

{$IFNDEF NEXTGEN}
function FormatBuf(var Buffer; BufLen: Cardinal; const Format;
  FmtLen: Cardinal; const Args: array of const;
  const AFormatSettings: TFormatSettings): Cardinal;
{$IF not defined(LEGACY_FORMAT) or defined(PUREPASCAL)}
var
  BufPtr: PAnsiChar;
  FormatPtr: PAnsiChar;
  FormatStartPtr: PAnsiChar;
  FormatEndPtr: PAnsiChar;
  ArgsIndex: Integer;
  ArgsLength: Integer;
  BufMaxLen: Cardinal;
  Overwrite: Boolean;
  FormatChar: AnsiChar;
  S: AnsiString;
  StrBuf: array[0..64] of AnsiChar;
  LeftJustification: Boolean;
  Width: Integer;
  Precision: Integer;
  Len: Integer;
  FirstNumber: Integer;
  CurrentArg: TVarRec;
  FloatVal: TFloatValue;

  function ApplyWidth(NumChar, Negitive: Integer): Boolean;
  var
    I: Integer;
    Max: Integer;
  begin
    Result := False;
    if (Precision > NumChar) and (FormatChar <> 'S') then
      Max := Precision
    else
      Max := NumChar;
    if (Width <> 0) and (Width > Max + Negitive) then
    begin
      for I := Max + 1  + Negitive to Width do
      begin
        if BufMaxLen = 0 then
        begin
          Result := True;
          Break;
        end;
        BufPtr^ := ' ';
        Inc(BufPtr);
        Dec(BufMaxLen, Sizeof(AnsiChar));
      end;
    end;
  end;

  function AddBuf(const AItem: PAnsiChar; ItemLen: Integer = -1; StringLen: Integer = -1): Boolean;
  var
    NumChar: Integer;
    Len: Integer;
    I: Integer;
    Item: PAnsiChar;
    Negitive: Integer;
    BytesToCopy: Cardinal;
  begin
    Item := AItem;
    if Assigned(AItem) then
      if StringLen = -1 then
        NumChar := StrLen(Item)
      else
        NumChar := StringLen
    else
      NumChar := 0;
    if (ItemLen > -1) and (NumChar > ItemLen) then
      NumChar := ItemLen;
    Len := NumChar * Sizeof(AnsiChar);
    if (Assigned(AItem)) and (Item^ = '-') and (FormatChar <> 'S') then
    begin
      Dec(Len, Sizeof(AnsiChar));
      Dec(NumChar);
      Negitive := 1;
    end
    else
      Negitive := 0;
    if not LeftJustification then
    begin
      Result := ApplyWidth(NumChar, Negitive);
      if Result then
        Exit;
    end;
    if Negitive = 1 then
    begin
      if BufMaxLen = 0 then
      begin
        Result := True;
        Exit;
      end;
      Inc(Item);
      BufPtr^ := '-';
      Inc(BufPtr);
      Dec(BufMaxLen, Sizeof(AnsiChar));
    end;
    if (Precision <> -1) and (Precision > NumChar) and (FormatChar <> 'S') then
      for I := NumChar + 1 to Precision do
      begin
        if BufMaxLen = 0 then
        begin
          Result := True;
          Exit;
        end;
        BufPtr^ := '0';
        Inc(BufPtr);
        Dec(BufMaxLen, Sizeof(AnsiChar));
      end;
    if Assigned(AItem) then
    begin
      Result := BufMaxLen < Cardinal(Len);
      if Result then
        BytesToCopy := BufMaxLen
      else
        BytesToCopy := Len;
      Move(Item^, BufPtr^, BytesToCopy);
      BufPtr := PAnsiChar(PByte(BufPtr) + BytesToCopy);
      Dec(BufMaxLen, BytesToCopy);
    end
    else
      Result := False;
    if LeftJustification then
      Result := ApplyWidth(NumChar, Negitive);
  end;

  function VariantToAnsiString(V: TVarData): AnsiString;
  begin
    Result := '';
    if Assigned(System.VarToLStrProc) then
      System.VarToLStrProc(Result, V)
    else
      System.Error(reVarInvalidOp);
  end;

begin
  if (not Assigned(@Buffer)) or  (not Assigned(@Format)) then
  begin
    Result := 0;
    Exit;
  end;
  ArgsIndex := -1;
  ArgsLength := Length(Args);
  BufPtr := PAnsiChar(@Buffer);
  FormatPtr := PAnsiChar(@Format);
  if BufLen < $7FFFFFFF then
    BufMaxLen := BufLen * Sizeof(AnsiChar)
  else
    BufMaxLen := BufLen;
  FormatEndPtr := FormatPtr + FmtLen;
  while (FormatPtr < FormatEndPtr) do
    if FormatPtr^ = '%' then
    begin
      Inc(FormatPtr);
      if (FormatPtr >= FormatEndPtr) then
        Break;
      if FormatPtr^ = '%' then
      begin
        if BufMaxLen = 0 then
          AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        BufPtr^ := FormatPtr^;
        Inc(FormatPtr);
        Inc(BufPtr);
        Dec(BufMaxLen, Sizeof(AnsiChar));
        Continue;
      end;
      Width := 0;
      // Gather Index
      Inc(ArgsIndex);
      if Char(FormatPtr^).IsNumber then
      begin
        FormatStartPtr := FormatPtr;
        while (FormatPtr < FormatEndPtr) and (Char(FormatPtr^).IsNumber)  do
          Inc(FormatPtr);
        if FormatStartPtr <> FormatPtr then
        begin
          StrLCopy(StrBuf, FormatStartPtr, Integer(FormatPtr - FormatStartPtr));
          if not TryStrToInt(string(StrBuf), FirstNumber) then
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
          if FormatPtr^ = ':' then
          begin
            Inc(FormatPtr);
            ArgsIndex := FirstNumber;
          end
          else
            Width := FirstNumber;
        end;
      end
      else if FormatPtr^ = ':' then
      begin
        ArgsIndex := 0;
        Inc(FormatPtr);
      end;
      // Gather Justification
      if FormatPtr^ = '-' then
      begin
        LeftJustification := True;
        Inc(FormatPtr);
      end
      else
        LeftJustification := False;
      // Gather Width
      FormatStartPtr := FormatPtr;
      if FormatPtr^ = '*' then
      begin
        Width := -2;
        Inc(FormatPtr);
      end
      else if Char(FormatPtr^).IsNumber then
      begin
        while (FormatPtr < FormatEndPtr) and (Char(FormatPtr^).IsNumber)  do
          Inc(FormatPtr);
        if FormatStartPtr <> FormatPtr then
        begin
          StrLCopy(StrBuf, FormatStartPtr, Integer(FormatPtr - FormatStartPtr));
          if not TryStrToInt(string(StrBuf), Width) then
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        end
      end;
      // Gather Precision
      if FormatPtr^ = '.' then
      begin
        Inc(FormatPtr);
        if (FormatPtr >= FormatEndPtr) then
          Break;
        if FormatPtr^ = '*' then
        begin
          Precision := -2;
          Inc(FormatPtr);
        end
        else
        begin
          FormatStartPtr := FormatPtr;
          while (FormatPtr < FormatEndPtr) and (Char(FormatPtr^).IsNumber)  do
            Inc(FormatPtr);
          StrLCopy(StrBuf, FormatStartPtr, Integer(FormatPtr - FormatStartPtr));
          if not TryStrToInt(string(StrBuf), Precision) then
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        end;
      end
      else
        Precision := -1;

      // Gather Conversion Character
      if not Char(FormatPtr^).IsLetter then
        Break;
      case FormatPtr^ of
        'a'..'z':
          FormatChar := AnsiChar(Byte(FormatPtr^) xor $20);
      else
        FormatChar := FormatPtr^;
      end;
      Inc(FormatPtr);

      // Handle Args
      if Width = -2 then // If * width was found
      begin
        if ArgsIndex >= ArgsLength then
          AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
        if Args[ArgsIndex].VType = vtInteger then
        begin
          if ArgsIndex >= ArgsLength then
            AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
          Width := Args[ArgsIndex].VInteger;
          if Width < 0 then
          begin
            LeftJustification := not LeftJustification;
            Width := -Width;
          end;
          Inc(ArgsIndex);
        end
        else
          AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
      end;
      if Precision = -2 then
      begin
        if ArgsIndex >= ArgsLength then
          AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
        if Args[ArgsIndex].VType = vtInteger then
        begin
          if ArgsIndex >= ArgsLength then
            AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
          Precision := Args[ArgsIndex].VInteger;
          Inc(ArgsIndex);
        end
        else
          AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
      end;

      if ArgsIndex >= ArgsLength then
        AnsiFormatError(1, PAnsiChar(@Format), FmtLen);
      CurrentArg := Args[ArgsIndex];

      Overwrite := False;
      case CurrentArg.VType of
        vtBoolean,
        vtObject,
        vtClass,
        vtWideChar,
        vtPWideChar,
        vtWideString,
        vtInterface: AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtInteger:
          begin
            if (Precision > 16) or (Precision = -1) then
              Precision := 0;
            case FormatChar of
              'D': S := AnsiString(IntToStr(CurrentArg.VInteger));
              'U': S := AnsiString(UIntToStr(Cardinal(CurrentArg.VInteger)));
              'X': S := AnsiString(IntToHex(CurrentArg.VInteger, 0));
            else
              AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
            end;
            Overwrite := AddBuf(PAnsiChar(S));
          end;
        vtChar:
          if FormatChar = 'S' then
          begin
            S := AnsiChar(CurrentArg.VChar);
            Overwrite := AddBuf(PAnsiChar(S), Precision);
          end
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtExtended, vtCurrency:
          begin
            if CurrentArg.VType = vtExtended then
              FloatVal := fvExtended
            else
              FloatVal := fvCurrency;
            Len := 0;
            if (FormatChar = 'G') or (FormatChar = 'E') then
            begin
              if Cardinal(Precision) > 18 then
                Precision := 15;
            end
            else if Cardinal(Precision) > 18 then
            begin
              Precision := 2;
              if FormatChar = 'M' then
                Precision := AFormatSettings.CurrencyDecimals;
            end;
            case FormatChar of
              'G': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffGeneral, Precision, 3, AFormatSettings);
              'E': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffExponent, Precision, 3, AFormatSettings);
              'F': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffFixed, 18, Precision, AFormatSettings);
              'N': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffNumber, 18, Precision, AFormatSettings);
              'M': Len := FloatToText(StrBuf, CurrentArg.VExtended^, FloatVal, ffCurrency, 18, Precision, AFormatSettings);
            else
              AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
            end;
            StrBuf[Len] := #0;
            Precision := 0;
            Overwrite := AddBuf(StrBuf);
          end;
        vtString:
          if FormatChar = 'S' then
            Overwrite := AddBuf(PAnsiChar(AnsiString(ShortString(PShortString(CurrentArg.VAnsiString)^))), Precision)
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtUnicodeString:
          if FormatChar = 'S' then
            Overwrite := AddBuf(PAnsiChar(AnsiString(CurrentArg.VPWideChar)), Precision)
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtVariant:
          if FormatChar = 'S' then
            Overwrite := AddBuf(PAnsiChar(VariantToAnsiString(TVarData(CurrentArg.VVariant^))), Precision)
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtPointer:
          if FormatChar = 'P' then
          begin
            S := AnsiString(IntToHex(IntPtr(CurrentArg.VPointer), SizeOf(Pointer)*2));
            Overwrite := AddBuf(PAnsiChar(S));
          end
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtPChar:
          if FormatChar = 'S' then
            Overwrite := AddBuf(CurrentArg.VWideString, Precision)
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtAnsiString:
          if FormatChar = 'S' then
            Overwrite := AddBuf(CurrentArg.VAnsiString, Precision, Length(AnsiString(CurrentArg.VAnsiString)))
          else
            AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
        vtInt64:
          begin
            if (Precision > 32) or (Precision = -1)  then
              Precision := 0;
            case FormatChar of
              'D': S := AnsiString(IntToStr(CurrentArg.VInt64^));
              'U': S := AnsiString(UIntToStr(UInt64(CurrentArg.VInt64^)));
              'X': S := AnsiString(IntToHex(CurrentArg.VInt64^, 0));
            else
              AnsiFormatError(0, PAnsiChar(@Format), FmtLen);
            end;
            Overwrite := AddBuf(PAnsiChar(S));
          end;
      end;
      if Overwrite then
      begin
        Result := BufPtr - PAnsiChar(@Buffer);
        Exit;
      end;
    end
    else
    begin
      if BufMaxLen = 0 then
      begin
        Result := BufPtr - PAnsiChar(@Buffer);
        Exit;
      end;
      BufPtr^ := FormatPtr^;
      Inc(FormatPtr);
      Inc(BufPtr);
      Dec(BufMaxLen, Sizeof(AnsiChar));
    end;
  Result := BufPtr - PAnsiChar(@Buffer);
end;
{$ELSE LEGACY_FORMAT or !PUREPASCAL}
{$IFDEF X86ASM}
  function AnsiFloatToTextEx(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
    Format: TFloatFormat; Precision, Digits: Integer;
    const AFormatSettings: TFormatSettings): Integer;
  begin
    Result := FloatToText(BufferArg, Value, ValueType, Format, Precision, Digits,
      AFormatSettings);
  end;

var
  ArgIndex, Width, Prec: Integer;
  BufferOrg, FormatOrg, FormatPtr: PAnsiChar;
  JustFlag: Byte;
  StrBuf: array[0..64] of AnsiChar;
  TempAnsiStr: AnsiString;
  SaveGOT: Integer;
asm
        { -> eax     Buffer }
        {    edx     BufLen }
        {    ecx     Format }

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        MOV     EDI, EAX
        MOV     ESI, ECX
{$IFDEF PIC}
        PUSH    ECX
        CALL    GetGOT
        POP     ECX
{$ELSE !PIC}
        XOR     EAX, EAX
{$ENDIF !PIC}
        MOV     SaveGOT, EAX
        ADD     ECX, FmtLen
        MOV     BufferOrg, EDI
        XOR     EAX, EAX
        MOV     ArgIndex, EAX
        MOV     TempAnsiStr, EAX

@Loop:
        OR      EDX, EDX
        JE      @Done

@NextChar:
        CMP     ESI, ECX
        JE      @Done
        LODSB
        CMP     AL, '%'
        JE      @Format

@StoreChar:
        STOSB
        DEC     EDX
        JNE     @NextChar

@Done:
        MOV     EAX, EDI
        SUB     EAX, BufferOrg
        JMP     @Exit

@Format:
        CMP     ESI, ECX
        JE      @Done
        LODSB
        CMP     AL, '%'
        JE      @StoreChar
        LEA     EBX, [ESI-2]
        MOV     FormatOrg, EBX
@A0:    MOV     JustFlag, AL
        CMP     AL, '-'
        JNE     @A1
        CMP     ESI, ECX
        JE      @Done
        LODSB
@A1:    CALL    @Specifier
        CMP     AL, ':'
        JNE     @A2
        MOV     ArgIndex, EBX
        CMP     ESI, ECX
        JE      @Done
        LODSB
        JMP     @A0

@A2:    OR      EBX, EBX
        JNS     @A2_3
        NEG     EBX
        CMP     JustFlag, '-'
        JE      @A2_2
        MOV     JustFlag, '-'
        JMP     @A2_3

@A2_2:  MOV     JustFlag, '*'

@A2_3:  MOV     Width, EBX
        MOV     EBX, -1
        CMP     AL, '.'
        JNE     @A3
        CMP     ESI, ECX
        JE      @Done
        LODSB
        CALL    @Specifier
@A3:    MOV     Prec, EBX
        MOV     FormatPtr, ESI
        PUSH    ECX
        PUSH    EDX
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF}
        CALL    @Convert
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF}

        POP     EDX
        MOV     EBX, Width
        SUB     EBX, ECX       // ECX <=> number of characters output
        JAE     @A4            //         jump -> output smaller than width
        XOR     EBX, EBX

@A4:    CMP     JustFlag, '-'
        JNE     @A6
        SUB     EDX, ECX
        JAE     @A5
        ADD     ECX, EDX
        XOR     EDX, EDX

@A5:    REP     MOVSB

@A6:    XCHG    EBX, ECX
        SUB     EDX, ECX
        JAE     @A7
        ADD     ECX, EDX
        XOR     EDX, EDX
@A7:    MOV     AL, ' '
        REP     STOSB
        XCHG    EBX, ECX
        SUB     EDX, ECX
        JAE     @A8
        ADD     ECX, EDX
        XOR     EDX, EDX
@A8:    REP     MOVSB
        CMP     TempAnsiStr, 0
        JE      @A9
        PUSH    EDX
        LEA     EAX, TempAnsiStr
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF ALIGN_STACK}
        CALL    FormatClearStr
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF ALIGN_STACK}
        POP     EDX
@A9:    POP     ECX
        MOV     ESI,FormatPtr
        JMP     @Loop

@Specifier:
        XOR     EBX, EBX
        CMP     AL, '*'
        JE      @B3
@B1:    CMP     AL, '0'
        JB      @B5
        CMP     AL, '9'
        JA      @B5
        IMUL    EBX, EBX, 10
        SUB     AL, '0'
        MOVZX   EAX, AL
        ADD     EBX, EAX
        CMP     ESI, ECX
        JE      @B2
        LODSB
        JMP     @B1
@B2:    POP     EAX
        JMP     @Done
@B3:    MOV     EAX, ArgIndex
        CMP     EAX, Args.Integer[-4]
        JG      @B4
        INC     ArgIndex
        MOV     EBX, Args
        CMP     [EBX+EAX*8].Byte[4], vtInteger
        MOV     EBX, [EBX+EAX*8]
        JE      @B4
        XOR     EBX, EBX
@B4:    CMP     ESI, ECX
        JE      @B2
        LODSB
@B5:    RET

@Convert:
        AND     AL, 0DFH
        MOV     CL, AL
        MOV     EAX, 1
        MOV     EBX, ArgIndex
        CMP     EBX, Args.Integer[-4]
        JG      @ErrorExit
        INC     ArgIndex
        MOV     ESI, Args
        LEA     ESI, [ESI+EBX*8]
        MOV     EAX, [ESI].Integer[0]       // TVarRec.data
        MOVZX   EDX, [ESI].Byte[4]          // TVarRec.VType
{$IFDEF PIC}
        MOV     EBX, SaveGOT
        ADD     EBX, offset @CvtVector
        MOV     EBX, [EBX+EDX*4]
        ADD     EBX, SaveGOT
        JMP     EBX
{$ELSE !PIC}
        JMP     @CvtVector.Pointer[EDX*4]
{$ENDIF !PIC}

@CvtVector:
        DD      @CvtInteger                // vtInteger
        DD      @CvtBoolean                // vtBoolean
        DD      @CvtChar                   // vtChar
        DD      @CvtExtended               // vtExtended
        DD      @CvtShortStr               // vtString
        DD      @CvtPointer                // vtPointer
        DD      @CvtPChar                  // vtPChar
        DD      @CvtObject                 // vtObject
        DD      @CvtClass                  // vtClass
        DD      @CvtWideChar               // vtWideChar
        DD      @CvtPWideChar              // vtPWideChar
        DD      @CvtAnsiStr                // vtAnsiString
        DD      @CvtCurrency               // vtCurrency
        DD      @CvtVariant                // vtVariant
        DD      @CvtInterface              // vtInterface
        DD      @CvtWideString             // vtWideString
        DD      @CvtInt64                  // vtInt64
        DD      @CvtUnicodeString          // vtUnicodeString

@CvtBoolean:
@CvtObject:
@CvtClass:
@CvtWideChar:
@CvtInterface:
@CvtError:
        XOR     EAX,EAX

@ErrorExit:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF}
        CALL    @ClearTmpAnsiStr
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF}
        MOV     EDX, FormatOrg
        MOV     ECX, FormatPtr
        SUB     ECX, EDX
        MOV     EBX, SaveGOT
{$IFDEF PC_MAPPED_EXCEPTIONS}
        //  Because of all the assembly code here, we can't call a routine
        //  that throws an exception if it looks like we're still on the
        //  stack.  The static disassembler cannot give sufficient unwind
        //  frame info to unwind the confusion that is generated from the
        //  assembly code above.  So before we throw the exception, we
        //  go to some lengths to excise ourselves from the stack chain.
        //  We were passed 12 bytes of parameters on the stack, and we have
        //  to make sure that we get rid of those, too.
{$IFDEF ALIGN_STACK}
        MOV     ESP, EBP        // Ditch everthing to the frame
        POP     EBP             // Ditch the rest of the frame
{$ELSE  !ALIGN_STACK}
        MOV     ESP, EBP        // Ditch everthing to the frame
        MOV     EBP, [ESP + 4]  // Get the return addr
        MOV     [ESP + 16], EBP // Move the ret addr up in the stack
        POP     EBP             // Ditch the rest of the frame
        ADD     ESP, 12         // Ditch the space that was taken by params
{$ENDIF !ALIGN_STACK}
        JMP     FormatError     // Off to FormatErr
{$ELSE !PC_MAPPED_EXCEPTIONS}
        CALL    FormatError
{$ENDIF !PC_MAPPED_EXCEPTIONS}
        // The above call raises an exception and does not return

@CvtInt64:
        // CL  <= format character
        // EAX <= address of int64
        // EBX <= TVarRec.VType

        LEA     ESI, StrBuf[32]
        MOV     EDX, Prec
        CMP     EDX, 32
        JBE     @I64_1           // zero padded field width > buffer => no padding
        XOR     EDX, EDX
@I64_1: MOV     EBX, ECX
        SUB     CL, 'D'
        JZ      CvtInt64         // branch predict backward jump taken
        MOV     ECX, 16
        CMP     BL, 'X'
        JE      CvtInt64
        MOV     ECX, 10
        CMP     BL, 'U'
        JE      CvtInt64
        JMP     @CvtError

@CvtInteger:
        LEA     ESI, StrBuf[16]
        MOV     EDX, Prec
        MOV     EBX, ECX
        CMP     EDX, 16
        JBE     @C1             // zero padded field width > buffer => no padding
        XOR     EDX, EDX
@C1:    SUB     CL, 'D'
        JZ      CvtInt          // branch predict backward jump taken
        MOV     ECX, 16
        CMP     BL, 'X'
        JE      CvtInt
        MOV     ECX, 10
        CMP     BL, 'U'
        JE      CvtInt
        JMP     @CvtError

@CvtChar:
        CMP     CL, 'S'
        JNE     @CvtError
        MOV     ECX, 1
        JMP     @CvtStrLen

@CvtVariant:
        CMP     CL, 'S'
        JNE     @CvtError
        CMP     [EAX].TVarData.VType, varNull
        JBE     @CvtEmptyStr
        MOV     EDX, EAX
        LEA     EAX, TempAnsiStr
        CALL    FormatVarToStr
        MOV     ESI, TempAnsiStr
        JMP     @CvtStrRef

@CvtEmptyStr:
        XOR     ECX,ECX
        RET

@CvtShortStr:
        CMP     CL, 'S'
        JNE     @CvtError
        MOV     ESI, EAX
        LODSB
        MOVZX   ECX, AL
        JMP     @CvtStrLen

@CvtPWideChar:
        MOV    ESI, OFFSET System.@LStrFromPWChar
        JMP    @CvtWideThing

@CvtUnicodeString:
        MOV    ESI, OFFSET System.@LStrFromUStr
        JMP    @CvtWideThing

@CvtWideString:
        MOV    ESI, OFFSET System.@LStrFromWStr

@CvtWideThing:
{$IFDEF PIC}
        ADD    ESI, SaveGOT
{$ENDIF PIC}
        CMP    CL, 'S'
        JNE    @CvtError
        MOV    EDX, EAX
        LEA    EAX, TempAnsiStr
{$IFDEF ALIGN_STACK}
        SUB    ESP, 4
{$ENDIF}
        PUSH   EBX
        PUSH   ECX
        MOV    EBX, SaveGOT
{$IFDEF PIC}                                    // Double indirect using GOT
        MOV    ECX, [EBX].DefaultSystemCodePage
        MOV    ECX, [ECX]
{$ELSE !PIC}
        MOV    ECX, DefaultSystemCodePage
{$ENDIF}
        CALL   ESI
        POP    ECX
        POP    EBX
{$IFDEF ALIGN_STACK}
        ADD    ESP, 4
{$ENDIF}
        MOV    ESI, TempAnsiStr
        MOV    EAX, ESI
        JMP    @CvtStrRef

@CvtAnsiStr:
        CMP     CL, 'S'
        JNE     @CvtError
        MOV     ESI, EAX

@CvtStrRef:
        OR      ESI, ESI
        JE      @CvtEmptyStr
        MOV     ECX, [ESI-4]

@CvtStrLen:
        CMP     ECX, Prec
        JA      @E1
        RET
@E1:    MOV     ECX, Prec
        RET

@CvtPChar:
        CMP     CL, 'S'
        JNE     @CvtError
        MOV     ESI, EAX
        PUSH    EDI
        MOV     EDI, EAX
        XOR     AL, AL
        MOV     ECX, Prec
        JECXZ   @F1
        REPNE   SCASB
        JNE     @F1
        DEC     EDI
@F1:    MOV     ECX, EDI
        SUB     ECX, ESI
        POP     EDI
        RET

@CvtPointer:
        CMP     CL, 'P'
        JNE     @CvtError
        MOV     EDX, 8
        MOV     ECX, 16
        LEA     ESI, StrBuf[16]
        JMP     CvtInt

@CvtCurrency:
        MOV     BH, fvCurrency
        JMP     @CvtFloat

@CvtExtended:
        MOV     BH, fvExtended

@CvtFloat:
        MOV     ESI, EAX
        MOV     BL, ffGeneral
        CMP     CL, 'G'
        JE      @G2
        MOV     BL, ffExponent
        CMP     CL, 'E'
        JE      @G2
        MOV     BL, ffFixed
        CMP     CL, 'F'
        JE      @G1
        MOV     BL, ffNumber
        CMP     CL, 'N'
        JE      @G1
        CMP     CL, 'M'
        JNE     @CvtError
        MOV     BL, ffCurrency
@G1:    MOV     EAX, 18
        MOV     EDX, Prec
        CMP     EDX, EAX
        JBE     @G3
        MOV     EDX, 2
        CMP     CL, 'M'
        JNE     @G3
        MOV     EDX, AFormatSettings
        MOVZX   EDX, [EDX].TFormatSettings.CurrencyDecimals
        JMP     @G3
@G2:    MOV     EAX, Prec
        MOV     EDX, 3
        CMP     EAX, 18
        JBE     @G3
        MOV     EAX, 15
@G3:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        PUSH    EBX
        PUSH    EAX
        PUSH    EDX
        MOV     EDX, [AFormatSettings]
        PUSH    EDX
        LEA     EAX, StrBuf
        MOV     EDX, ESI
        MOVZX   ECX, BH
        MOV     EBX, SaveGOT
        CALL    AnsiFloatToTextEx
        MOV     ECX, EAX
        LEA     ESI, StrBuf
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        RET

@ClearTmpAnsiStr:
        PUSH    EBX
        PUSH    EAX
        LEA     EAX, TempAnsiStr
        MOV     EBX, SaveGOT
{$IFDEF ALIGN_STACK}
        SUB     ESP, 4
{$ENDIF}
        CALL    System.@LStrClr
{$IFDEF ALIGN_STACK}
        ADD     ESP, 4
{$ENDIF}
        POP     EAX
        POP     EBX
        RET

@Exit:
        CALL    @ClearTmpAnsiStr
        POP     EDI
        POP     ESI
        POP     EBX
end;
{$ENDIF X86ASM}
{$ENDIF LEGACY_FORMAT or !PUREPASCAL}
{$ENDIF NEXTGEN}

{$IFNDEF NEXTGEN}
procedure WideFmtStr(var Result: WideString; const Format: WideString;
  const Args: array of const); overload;
begin
  WideFmtStr(Result, Format, Args, FormatSettings);
end;

procedure WideFmtStr(var Result: WideString; const Format: WideString;
  const Args: array of const; const AFormatSettings: TFormatSettings); overload;
const
  BufSize = 2048;
var
  Len, BufLen: Integer;
  Buffer: array[0..BufSize-1] of WideChar;
begin
  if Length(Format) < (BufSize - (BufSize div 4)) then
  begin
    BufLen := BufSize;
    Len := WideFormatBuf(Buffer, BufSize - 1, Pointer(Format)^,
      Length(Format), Args, AFormatSettings);
    if Len < BufLen - 1 then
    begin
      SetString(Result, Buffer, Len);
      Exit;
    end;
  end
  else
  begin
    BufLen := Length(Format);
    Len := BufLen;
  end;

  while Len >= BufLen - 1 do
  begin
    Inc(BufLen, BufLen);
    Result := '';          // prevent copying of existing data, for speed
    SetLength(Result, BufLen);
    Len := WideFormatBuf(Pointer(Result)^, BufLen - 1, Pointer(Format)^,
      Length(Format), Args, AFormatSettings);
  end;
  SetLength(Result, Len);
end;

function WideFormat(const Format: WideString; const Args: array of const): WideString;
begin
  Result := WideFormat(Format, Args, FormatSettings);
end;

function WideFormat(const Format: WideString; const Args: array of const;
  const AFormatSettings: TFormatSettings): WideString;
begin
  WideFmtStr(Result, Format, Args, AFormatSettings);
end;
{$ENDIF !NEXTGEN}

{ Floating point conversion routines }

const
  // 1E18 as a 64-bit integer
  Const1E18Lo = $0A7640000;
  Const1E18Hi = $00DE0B6B3;
  FCon1E18: Extended = 1E18;
  DCon10: Integer = 10;

{$IFDEF X86ASM}
procedure PutExponent;
// Store exponent
// In   AL  = Exponent character ('E' or 'e')
//      AH  = Positive sign character ('+' or 0)
//      BL  = Zero indicator
//      BH  = Destination buffer type: 0=Ansi, 1=Unicode
//      ECX = Minimum number of digits (0..4)
//      EDX = Exponent
//      EDI = Destination buffer
asm //StackAlignSafe - internal method can be called unaligned
        PUSH    ESI
{$IFDEF PIC}
        PUSH    EAX
        PUSH    ECX
        CALL    GetGOT
        MOV     ESI,EAX
        POP     ECX
        POP     EAX
{$ELSE !PIC}
        XOR     ESI,ESI
{$ENDIF !PIC}
        STOSB
        CMP     BH,0
        JE      @@a
        XOR     AL,AL
        STOSB
@@a:    OR      BL,BL
        JNE     @@0
        XOR     EDX,EDX
        JMP     @@1
@@0:    OR      EDX,EDX
        JGE     @@1
        MOV     AL,'-'
        NEG     EDX
        JMP     @@2
@@1:    OR      AH,AH
        JE      @@3
        MOV     AL,AH
@@2:    STOSB
        CMP     BH,0
        JE      @@3
        XOR     AL,AL
        STOSB
@@3:    XCHG    EAX,EDX
        PUSH    EAX
        PUSH    EBX
        MOV     EBX,ESP
        SUB     EBX,8
        PUSH    EBX
@@4:    XOR     EDX,EDX
        DIV     [ESI].DCon10
        ADD     DL,'0'
        MOV     [EBX],DL
        INC     EBX
        DEC     ECX
        OR      EAX,EAX
        JNE     @@4
        OR      ECX,ECX
        JG      @@4
        POP     EDX
        POP     ECX
@@5:    DEC     EBX
        MOV     AL,[EBX]
        STOSB
        CMP     CH,0
        JE      @@6
        XOR     AL,AL
        STOSB
@@6:    CMP     EBX,EDX
        JNE     @@5
        POP     EAX
        POP     ESI
end;
{$ENDIF X86ASM}

function FloatToText(BufferArg: PWideChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer): Integer;
begin
  Result := FloatToText(BufferArg, Value, ValueType, Format, Precision,
    Digits, FormatSettings);
end;

{$IFNDEF NEXTGEN}
function FloatToText(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer): Integer;
begin
  Result := FloatToText(BufferArg, Value, ValueType, Format, Precision,
    Digits, FormatSettings);
end;
{$ENDIF !NEXTGEN}

function WideFloatToTextFmtSettings(BufferArg: PWideChar;
  const Value; ValueType: TFloatValue; Format: TFloatFormat;
  Precision, Digits: Integer; const AFormatSettings: TFormatSettings): Integer;
begin
  Result := FloatToText(BufferArg, Value, ValueType, Format, Precision,
    Digits, AFormatSettings);
end;

{ $IFDEF PUREPASCAL}
function InternalFloatToText(
  ABuffer: PByte;
  ABufferIsUnicode: Boolean;
  const AValue;
  AValueType: TFloatValue;
  AFormat: TFloatFormat;
  APrecision, ADigits: Integer;
  const AFormatSettings: TFormatSettings): Integer;
const
  CMinExtPrecision = 2;
{$IFDEF EXTENDEDIS10BYTES}
  CMaxExtPrecision = 18;
{$ELSE !EXTENDEDIS10BYTES}
  CMaxExtPrecision = 17;
{$ENDIF EXTENDEDIS10BYTES}

  CCurrPrecision = 19;
  CGenExpDigits = 9999;

  CExpChar = 'E';          // DO NOT LOCALIZE
  CMinusSign: Char = '-';  // DO NOT LOCALIZE
  CPlusSign: Char = '+';   // DO NOT LOCALIZE
  CZero: Char = '0';       // DO NOT LOCALIZE
  CSpecial: array[0 .. 1] of string = ('INF', 'NAN'); // DO NOT LOCALIZE
  CCurrencyFormats: array[0 .. 3] of string = ('$*@@@', '*$@@@', '$ *@@', '* $@@'); // DO NOT LOCALIZE
  CNegCurrencyFormats: array[0 .. 15] of string =
  (
    '($*)@', '-$*@@', '$-*@@', '$*-@@', '(*$)@', '-*$@@', // DO NOT LOCALIZE
    '*-$@@', '*$-@@', '-* $@', '-$ *@', '* $-@', // DO NOT LOCALIZE
    '$ *-@', '$ -*@', '*- $@', '($ *)', '(* $)' // DO NOT LOCALIZE
  );

var
  FloatRec: TFloatRec;

  LDigits: Integer;
  LExponent: Cardinal;
  LUseENotation: Boolean;

  LCurrentFormat: string;
  //LCurrChar: Char;
  ICurrChar: integer;
  LFloatRecDigit: Integer;
  LNextThousand: Integer;

  procedure AppendChar(const AChar: Char);
  begin
    if ABufferIsUnicode then
    begin
      PChar(ABuffer)^ := AChar;
      Inc(ABuffer, SizeOf(Char));
    end else
    begin
      PByte(ABuffer)^ := Byte(AChar);
      Inc(ABuffer, SizeOf(Byte));
    end;

    Inc(Result);
  end;

  procedure AppendString(const AStr: String);
  var
    I, L: Integer;
  begin
    L := Astr.Length;

    if L > 0 then
    begin
      if ABufferIsUnicode then
      begin
        { Unicode -- move directly }
        MoveChars(AStr[Low(string)], ABuffer^, L);
        Inc(ABuffer, L * SizeOf(Char));
      end else
      begin
        { ANSI -- loop }
        for I := Low(string) to High(AStr) do
        begin
          PByte(ABuffer)^ := Byte(AStr[I]);
          Inc(ABuffer, SizeOf(Byte));
        end;
      end;

      Inc(Result, L);
    end;
  end;

  function GetDigit: Byte;
  begin
    Result := FloatRec.Digits[LFloatRecDigit];

    if Result = Ord(#0) then
      Result := Ord('0')
    else
      Inc(LFloatRecDigit);
  end;

  procedure FormatNumber;
  var
    K: Integer;
  begin
    if ADigits > CMaxExtPrecision then
      LDigits := CMaxExtPrecision
    else
      LDigits := ADigits;

    K := FloatRec.Exponent;
    if K > 0 then
    begin
      { Find the position of the next thousand separator }
      LNextThousand := 0;
      if AFormat <> ffFixed then
        LNextThousand := ((K - 1) mod 3) + 1;

      repeat
        { Append the next digit }
        AppendChar(Char(GetDigit));

        { Update loop counters }
        Dec(K);
        Dec(LNextThousand);

        { Try to append the thousands separator and reset the counter }
        if (LNextThousand = 0) and (K > 0) then
        begin
          LNextThousand := 3;

          if AFormatSettings.ThousandSeparator <> #0 then
            AppendChar(AFormatSettings.ThousandSeparator);
        end;
      until (K = 0);

    end else
      AppendChar(CZero);

    { If there are ADigits left to fill }
    if LDigits <> 0 then
    begin
      { Put in the decimal separator if it was specified }
      if AFormatSettings.DecimalSeparator <> #0 then
        AppendChar(AFormatSettings.DecimalSeparator);

      { If there is  negative exponent }
      if K < 0 then
      begin
        { Fill with zeroes until the exponent or ADigits are exhausted}
        repeat
          AppendChar(CZero);

          Inc(K);
          Dec(LDigits);
        until (K = 0) or (LDigits = 0);
      end;

      if LDigits > 0 then
      begin
        { Exponent was filled, there are still ADigits left to fill }
        repeat
          AppendChar(Char(GetDigit));
          Dec(LDigits);
        until (LDigits <= 0);
      end;
    end;
  end;

  procedure FormatExponent;
  var
    LMinCnt, LExponent: Integer;
    LExpString: string;
    LDigitCnt: Integer;
  begin
    { Adjust digit count }
    if ADigits > 4 then
      LMinCnt := 0
    else
      LMinCnt := ADigits;

    { Get exponent }
    LExponent := FloatRec.Exponent - 1;

    { Place the E character into position }
    AppendChar(CExpChar);

    if Byte(FloatRec.Digits[0]) <> Ord(#0) then
    begin
      if LExponent < 0 then
      begin
        LExponent := -LExponent;
        AppendChar(CMinusSign);
      end
      else
      begin
        if AFormat <> ffGeneral then
          AppendChar(CPlusSign);
      end;
    end else
    begin
      if AFormat <> ffGeneral then
        AppendChar(CPlusSign);
      LExponent := 0;
    end;

    LExpString := IntToStr(LExponent);
    LDigitCnt := LExpString.Length;

    while LDigitCnt < LMinCnt do
    begin
      AppendChar(CZero);
      Inc(LDigitCnt);
    end;

    AppendString(LExpString);
  end;

begin
  LFloatRecDigit := 0;
  Result := 0;

  if AValueType = fvExtended then
  begin
    { Check min and max precisions for an Extended }
    if APrecision < CMinExtPrecision then
      APrecision := CMinExtPrecision
    else if APrecision > CMaxExtPrecision then
      APrecision := CMaxExtPrecision;
  end else
    APrecision := CCurrPrecision;

  { Check the number of ADigits to use }
  if AFormat in [ffGeneral, ffExponent] then
    LDigits := CGenExpDigits
  else
    LDigits := ADigits;

  { Decode the float }
  FloatToDecimal(FloatRec, AValue, AValueType, APrecision, LDigits);
{$IFDEF EXTENDEDIS10BYTES}
  LExponent := UInt16(FloatRec.Exponent) - $7FFF;
{$ELSE !EXTENDEDIS10BYTES}
  LExponent := UInt16(FloatRec.Exponent) - $7FF;
{$ENDIF EXTENDEDIS10BYTES}

  { Check for INF or NAN}
  if LExponent < 2 then
  begin
    { Append the sign to output buffer }
    if FloatRec.Negative then
      AppendChar(CMinusSign);

    AppendString(CSpecial[LExponent]);
    Exit;
  end;

  if (not (AFormat in [ffGeneral .. ffCurrency])) or
    ((FloatRec.Exponent > APrecision) and (AFormat <> ffExponent)) then
    AFormat := ffGeneral;

  case AFormat of
    ffGeneral:
    begin
      { Append the sign to output buffer }
      if FloatRec.Negative then
        AppendChar(CMinusSign);

      LUseENotation := False;

      { Obtain digit count and whether to use the E notation }
      LDigits := FloatRec.Exponent;
      if (LDigits > APrecision) or (LDigits < -3) then
      begin
        LDigits := 1;
        LUseENotation := True;
      end;

      if LDigits > 0 then
      begin
        { Append the ADigits that precede decimal separator }
        while LDigits > 0 do
        begin
          AppendChar(Char(GetDigit));
          Dec(LDigits);
        end;

        { Append the decimal separator and the following digit }
        if FloatRec.Digits[LFloatRecDigit] <> Ord(#0) then
        begin
          AppendChar(AFormatSettings.DecimalSeparator);

          { Append the ADigits that come after the decimal separator }
          while FloatRec.Digits[LFloatRecDigit] <> Ord(#0) do
            AppendChar(Char(GetDigit));
        end;

        if LUseENotation then
          FormatExponent();
      end else
      begin
        AppendChar(CZero);

        if FloatRec.Digits[0] <> Ord(#0) then
        begin
          AppendChar(AFormatSettings.DecimalSeparator);
          LDigits := -LDigits;

          { Append zeroes to fulfill the exponent }
          while LDigits > 0 do
          begin
            AppendChar(CZero);
            Dec(LDigits);
          end;

          { Attach all the other ADigits now }
          while FloatRec.Digits[LFloatRecDigit] <> Ord(#0) do
            AppendChar(Char(GetDigit));
        end;
      end;
    end;

    ffExponent:
    begin
      { Append the sign to output buffer }
      if FloatRec.Negative then
        AppendChar(CMinusSign);

      { Append the first digit and the decimal separator }
      AppendChar(Char(GetDigit));
      AppendChar(AFormatSettings.DecimalSeparator);

      { Append ADigits based on the APrecision requirements }
      Dec(APrecision);
      repeat
        AppendChar(Char(GetDigit));
        Dec(APrecision);
      until (APrecision = 0);

      FormatExponent();
    end;

    ffNumber, ffFixed:
    begin
      { Append the sign to output buffer }
      if FloatRec.Negative then
        AppendChar(CMinusSign);

      FormatNumber();
    end;

    ffCurrency:
    begin
      { Select the appropriate currency AFormat}
      if FloatRec.Negative then
      begin
        {  negative AFormat is used, check for bounds and select }
        if AFormatSettings.NegCurrFormat > High(CNegCurrencyFormats) then
          LCurrentFormat := CNegCurrencyFormats[High(CNegCurrencyFormats)]
        else
          LCurrentFormat := CNegCurrencyFormats[AFormatSettings.NegCurrFormat];
      end else
      begin
        {  positive AFormat is used, check for bounds and select }
        if AFormatSettings.CurrencyFormat > High(CCurrencyFormats) then
          LCurrentFormat := CCurrencyFormats[High(CCurrencyFormats)]
        else
          LCurrentFormat := CCurrencyFormats[AFormatSettings.CurrencyFormat];
      end;

      { Iterate over each charater in the AFormat string }
//      for LCurrChar in LCurrentFormat do
//        case LCurrChar of
      for ICurrChar := Low(string) to High(LCurrentFormat) do
        case LCurrentFormat[ICurrChar] of
          '@': break;
          '$':
            if AFormatSettings.CurrencyString <> EmptyStr then
              AppendString(AFormatSettings.CurrencyString);
          '*': FormatNumber();
          else
             //AppendChar(LCurrChar);
             AppendChar(LCurrentFormat[ICurrChar]);
        end;
    end;
  end;
end;
{ $ENDIF PUREPASCAL}

function FloatToText(BufferArg: PWideChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): Integer;
{$IFDEF PUREPASCAL}
begin
  { Call internal helper. Specify that we're using an Unicode buffer }
  Result := InternalFloatToText(PByte(BufferArg), True, Value, ValueType, Format, Precision, Digits, AFormatSettings);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  Buffer: Pointer;
  FloatRec: TFloatRec;
  DecimalSep: Char;
  ThousandSep: Char;
  CurrencyStr: Pointer;
  CurrFmt: Byte;
  NegCurrFmt: Byte;
  SaveGOT: Integer;
asm //StackAligned
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        MOV     Buffer,EAX
{$IFDEF PIC}
        PUSH    ECX
        CALL    GetGOT
        MOV     SaveGOT,EAX
        POP     ECX
{$ELSE !PIC}
        MOV     SaveGOT,0
{$ENDIF !PIC}
        MOV     EAX,AFormatSettings
        MOV     EAX,[EAX].TFormatSettings.CurrencyString
        MOV     CurrencyStr,EAX
        MOV     EAX,AFormatSettings
        MOV     AX,[EAX].TFormatSettings.DecimalSeparator
        MOV     DecimalSep,AX
        MOV     EAX,AFormatSettings
        MOV     AX,[EAX].TFormatSettings.ThousandSeparator
        MOV     ThousandSep,AX
        MOV     EAX,AFormatSettings
        MOV     AL,[EAX].TFormatSettings.CurrencyFormat
        MOV     CurrFmt,AL
        MOV     EAX,AFormatSettings
        MOV     AL,[EAX].TFormatSettings.NegCurrFormat
        MOV     NegCurrFmt,AL
        MOV     EAX,19
        CMP     CL,fvExtended
        JNE     @@2
        MOV     EAX,Precision
        CMP     EAX,2
        JGE     @@1
        MOV     EAX,2
@@1:    CMP     EAX,18
        JLE     @@2
        MOV     EAX,18
@@2:    MOV     Precision,EAX
        PUSH    EAX
        MOV     EAX,9999
        CMP     Format,ffFixed
        JB      @@3
        MOV     EAX,Digits
@@3:    PUSH    EAX
        LEA     EAX,FloatRec
        CALL    FloatToDecimal
        MOV     EDI,Buffer
        MOVZX   EAX,FloatRec.Exponent
        SUB     EAX,7FFFH
        CMP     EAX,2
        JAE     @@4
        MOV     ECX, EAX
        CALL    @@PutSign
        SHL     ECX,1
        LEA     ESI,@@INFNAN[ECX+ECX*2]
        ADD     ESI,SaveGOT
        MOV     ECX,3
        REP     MOVSW
        JMP     @@7
@@4:    LEA     ESI,FloatRec.Digits
        MOVZX   EBX,Format
        CMP     BL,ffExponent
        JE      @@6
        CMP     BL,ffCurrency
        JA      @@5
        MOVSX   EAX,FloatRec.Exponent
        CMP     EAX,Precision
        JLE     @@6
@@5:    MOV     BL,ffGeneral
@@6:    LEA     EBX,@@FormatVector[EBX*4]
        ADD     EBX,SaveGOT
        MOV     EBX,[EBX]
        ADD     EBX,SaveGOT
        CALL    EBX
@@7:    MOV     EAX,EDI
        SUB     EAX,Buffer
        SHR     EAX,1
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        POP     EBX
        POP     ESI
        POP     EDI
        JMP     @@Exit

@@FormatVector:
        DD      @@PutFGeneral
        DD      @@PutFExponent
        DD      @@PutFFixed
        DD      @@PutFNumber
        DD      @@PutFCurrency

@@INFNAN: DW 'I','N','F','N','A','N'

// Get digit or '0' if at end of digit string

@@GetDigit:

        LODSB
        OR      AL,AL
        JNE     @@a1
        MOV     AL,'0'
        DEC     ESI
@@a1:   XOR     AH,AH
        RET

// Store '-' if number is negative

@@PutSign:

        CMP     FloatRec.Negative,0
        JE      @@b1
        MOV     AX,'-'
        STOSW
@@b1:   RET

// Convert number using ffGeneral format

@@PutFGeneral:

        CALL    @@PutSign
        MOVSX   ECX,FloatRec.Exponent
        XOR     EDX,EDX
        CMP     ECX,Precision
        JG      @@c1
        CMP     ECX,-3
        JL      @@c1
        OR      ECX,ECX
        JG      @@c2
        MOV     AX,'0'
        STOSW
        CMP     BYTE PTR [ESI],0
        JE      @@c6
        MOV     AX,DecimalSep
        STOSW
        NEG     ECX
        MOV     AX,'0'
        REP     STOSW
        JMP     @@c3
@@c1:   MOV     ECX,1
        INC     EDX
@@c2:   LODSB
        OR      AL,AL
        JE      @@c4
        XOR     AH,AH
        STOSW
        LOOP    @@c2
        LODSB
        OR      AL,AL
        JE      @@c5
        XOR     AH,AH
        SHL     EAX,16
        MOV     AX,DecimalSep
        STOSD
@@c3:   LODSB
        OR      AL,AL
        JE      @@c5
        XOR     AH,AH
        STOSW
        JMP     @@c3
@@c4:   MOV     AX,'0'
        REP     STOSW
@@c5:   OR      EDX,EDX
        JE      @@c6
        XOR     EAX,EAX
        JMP     @@PutFloatExpWithDigits
@@c6:   RET

// Convert number using ffExponent format

@@PutFExponent:

        CALL    @@PutSign
        CALL    @@GetDigit
        STOSW
        MOV     AX,DecimalSep
        STOSW
        MOV     ECX,Precision
        DEC     ECX
@@d1:   CALL    @@GetDigit
        STOSW
        LOOP    @@d1
        MOV     AH,'+'

@@PutFloatExpWithDigits:

        MOV     ECX,Digits
        CMP     ECX,4
        JBE     @@PutFloatExp
        XOR     ECX,ECX

// Store exponent
// In   AH  = Positive sign character ('+' or 0)
//      ECX = Minimum number of digits (0..4)

@@PutFloatExp:

        MOV     AL,'E'
        MOV     BL, FloatRec.Digits.Byte
        MOV     BH,1
        MOVSX   EDX,FloatRec.Exponent
        DEC     EDX
        CALL    PutExponent  {Safe to call unaligned}
        RET

// Convert number using ffFixed or ffNumber format

@@PutFFixed:
@@PutFNumber:

        CALL    @@PutSign

// Store number in fixed point format

@@PutNumber:

        MOV     EDX,Digits
        CMP     EDX,18
        JB      @@f1
        MOV     EDX,18
@@f1:   MOVSX   ECX,FloatRec.Exponent
        OR      ECX,ECX
        JG      @@f2
        MOV     AX,'0'
        STOSW
        JMP     @@f4
@@f2:   XOR     EBX,EBX
        CMP     Format,ffFixed
        JE      @@f3
        MOV     EAX,ECX
        DEC     EAX
        MOV     BL,3
        DIV     BL
        MOV     BL,AH
        INC     EBX
@@f3:   CALL    @@GetDigit
        STOSW
        DEC     ECX
        JE      @@f4
        DEC     EBX
        JNE     @@f3
        MOV     AX,ThousandSep
        TEST    AX,AX
        JZ      @@f3
        STOSW
        MOV     BL,3
        JMP     @@f3
@@f4:   OR      EDX,EDX
        JE      @@f7
        MOV     AX,DecimalSep
        TEST    AX,AX
        JZ      @@f4b
        STOSW
@@f4b:  JECXZ   @@f6
        MOV     AX,'0'
@@f5:   STOSW
        DEC     EDX
        JE      @@f7
        INC     ECX
        JNE     @@f5
@@f6:   CALL    @@GetDigit
        STOSW
        DEC     EDX
        JNE     @@f6
@@f7:   RET

// Convert number using ffCurrency format

@@PutFCurrency:

        XOR     EBX,EBX
        MOV     BL,CurrFmt.Byte
        MOV     ECX,0003H
        CMP     FloatRec.Negative,0
        JE      @@g1
        MOV     BL,NegCurrFmt.Byte
        MOV     ECX,040FH
@@g1:   CMP     BL,CL
        JBE     @@g2
        MOV     BL,CL
@@g2:   ADD     BL,CH
        LEA     EBX,@@MoneyFormats[EBX+EBX*4]
        ADD     EBX,SaveGOT
        MOV     ECX,5
@@g10:  MOV     AL,[EBX]
        CMP     AL,'@'
        JE      @@g14
        PUSH    ECX
        PUSH    EBX
        CMP     AL,'$'
        JE      @@g11
        CMP     AL,'*'
        JE      @@g12
        XOR     AH,AH
        STOSW
        JMP     @@g13
@@g11:  CALL    @@PutCurSym
        JMP     @@g13
@@g12:  CALL    @@PutNumber
@@g13:  POP     EBX
        POP     ECX
        INC     EBX
        LOOP    @@g10
@@g14:  RET

// Store currency symbol string

@@PutCurSym:

        PUSH    ESI
        MOV     ESI,CurrencyStr
        TEST    ESI,ESI
        JE      @@h1
        MOV     ECX,[ESI-4]
        REP     MOVSW
@@h1:   POP     ESI
        RET

// Currency formatting templates

@@MoneyFormats:
        DB      '$*@@@'
        DB      '*$@@@'
        DB      '$ *@@'
        DB      '* $@@'
        DB      '($*)@'
        DB      '-$*@@'
        DB      '$-*@@'
        DB      '$*-@@'
        DB      '(*$)@'
        DB      '-*$@@'
        DB      '*-$@@'
        DB      '*$-@@'
        DB      '-* $@'
        DB      '-$ *@'
        DB      '* $-@'
        DB      '$ *-@'
        DB      '$ -*@'
        DB      '*- $@'
        DB      '($ *)'
        DB      '(* $)'

@@Exit:
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

{$IFNDEF NEXTGEN}
function FloatToText(BufferArg: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: TFloatFormat; Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): Integer;
{$IFDEF PUREPASCAL}
begin
  { Call internal helper. Specify that we're using an ANSI buffer }
  Result := InternalFloatToText(PByte(BufferArg), False, Value, ValueType, Format, Precision, Digits, AFormatSettings);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  Buffer: Pointer;
  FloatRec: TFloatRec;
  SaveGOT: Integer;
  DecimalSep: AnsiChar;
  ThousandSep: AnsiChar;
  CurrencyStr: Pointer;
  CurrFmt: Byte;
  NegCurrFmt: Byte;
  AnsiCurrencyStr: AnsiString;
asm //StackAligned
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     Buffer,EAX
{$IFDEF PIC}
        PUSH    ECX
        CALL    GetGOT
        MOV     SaveGOT,EAX
        POP     ECX
{$ELSE !PIC}
        MOV     SaveGOT,0
{$ENDIF !PIC}
{$IFDEF ALIGN_STACK}
        SUB     ESP,4
{$ENDIF ALIGN_STACK}
        PUSH    ECX
        PUSH    EDX
{$IFDEF PIC}                                    // Double indirect using GOT
        MOV     ECX, [EAX].DefaultSystemCodePage
        MOV     ECX, [ECX]
{$ELSE !PIC}
        MOV     ECX, DefaultSystemCodePage
{$ENDIF}
        LEA     EAX,AnsiCurrencyStr
        MOV     EDX,AFormatSettings
        MOV     EDX,[EDX].TFormatSettings.CurrencyString
        CALL    System.@LStrFromUStr
        MOV     EAX,AnsiCurrencyStr
        MOV     CurrencyStr,EAX
        POP     EDX
        POP     ECX
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.DecimalSeparator)
        MOV     DecimalSep,AL
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.ThousandSeparator)
        MOV     ThousandSep,AL
        MOV     EAX,AFormatSettings
        MOV     AL,[EAX].TFormatSettings.CurrencyFormat
        MOV     CurrFmt,AL
        MOV     EAX,AFormatSettings
        MOV     AL,[EAX].TFormatSettings.NegCurrFormat
        MOV     NegCurrFmt,AL

        MOV     EAX,19
        CMP     CL,fvExtended
        JNE     @@2
        MOV     EAX,Precision
        CMP     EAX,2
        JGE     @@1
        MOV     EAX,2
@@1:    CMP     EAX,18
        JLE     @@2
        MOV     EAX,18
@@2:    MOV     Precision,EAX
        PUSH    EAX
        MOV     EAX,9999
        CMP     Format,ffFixed
        JB      @@3
        MOV     EAX,Digits
@@3:    PUSH    EAX
        LEA     EAX,FloatRec
        CALL    FloatToDecimal
        MOV     EDI,Buffer
        MOVZX   EAX,FloatRec.Exponent
        SUB     EAX,7FFFH
        CMP     EAX,2
        JAE     @@4
        MOV     ECX, EAX
        CALL    @@PutSign
        LEA     ESI,@@INFNAN[ECX+ECX*2]
        ADD     ESI,SaveGOT
        MOV     ECX,3
        REP     MOVSB
        JMP     @@7
@@4:    LEA     ESI,FloatRec.Digits
        MOVZX   EBX,Format
        CMP     BL,ffExponent
        JE      @@6
        CMP     BL,ffCurrency
        JA      @@5
        MOVSX   EAX,FloatRec.Exponent
        CMP     EAX,Precision
        JLE     @@6
@@5:    MOV     BL,ffGeneral
@@6:    LEA     EBX,@@FormatVector[EBX*4]
        ADD     EBX,SaveGOT
        MOV     EBX,[EBX]
        ADD     EBX,SaveGOT
        CALL    EBX
@@7:    MOV     EAX,EDI
        SUB     EAX,Buffer
{$IFDEF ALIGN_STACK}
        ADD     ESP, 4
{$ENDIF ALIGN_STACK}
        POP     EBX
        POP     ESI
        POP     EDI
        JMP     @@Exit

@@FormatVector:
        DD      @@PutFGeneral
        DD      @@PutFExponent
        DD      @@PutFFixed
        DD      @@PutFNumber
        DD      @@PutFCurrency

@@INFNAN: DB 'INFNAN'

// Get digit or '0' if at end of digit string

@@GetDigit:

        LODSB
        OR      AL,AL
        JNE     @@a1
        MOV     AL,'0'
        DEC     ESI
@@a1:   RET

// Store '-' if number is negative

@@PutSign:

        CMP     FloatRec.Negative,0
        JE      @@b1
        MOV     AL,'-'
        STOSB
@@b1:   RET

// Convert number using ffGeneral format

@@PutFGeneral:

        CALL    @@PutSign
        MOVSX   ECX,FloatRec.Exponent
        XOR     EDX,EDX
        CMP     ECX,Precision
        JG      @@c1
        CMP     ECX,-3
        JL      @@c1
        OR      ECX,ECX
        JG      @@c2
        MOV     AL,'0'
        STOSB
        CMP     BYTE PTR [ESI],0
        JE      @@c6
        MOV     AL,DecimalSep
        STOSB
        NEG     ECX
        MOV     AL,'0'
        REP     STOSB
        JMP     @@c3
@@c1:   MOV     ECX,1
        INC     EDX
@@c2:   LODSB
        OR      AL,AL
        JE      @@c4
        STOSB
        LOOP    @@c2
        LODSB
        OR      AL,AL
        JE      @@c5
        MOV     AH,AL
        MOV     AL,DecimalSep
        STOSW
@@c3:   LODSB
        OR      AL,AL
        JE      @@c5
        STOSB
        JMP     @@c3
@@c4:   MOV     AL,'0'
        REP     STOSB
@@c5:   OR      EDX,EDX
        JE      @@c6
        XOR     EAX,EAX
        JMP     @@PutFloatExpWithDigits
@@c6:   RET

// Convert number using ffExponent format

@@PutFExponent:

        CALL    @@PutSign
        CALL    @@GetDigit
        MOV     AH,DecimalSep
        STOSW
        MOV     ECX,Precision
        DEC     ECX
@@d1:   CALL    @@GetDigit
        STOSB
        LOOP    @@d1
        MOV     AH,'+'

@@PutFloatExpWithDigits:

        MOV     ECX,Digits
        CMP     ECX,4
        JBE     @@PutFloatExp
        XOR     ECX,ECX

// Store exponent
// In   AH  = Positive sign character ('+' or 0)
//      ECX = Minimum number of digits (0..4)

@@PutFloatExp:

        MOV     AL,'E'
        MOV     BL, FloatRec.Digits.Byte
        XOR     BH,BH
        MOVSX   EDX,FloatRec.Exponent
        DEC     EDX
        CALL    PutExponent   {Safe to call unaligned}
        RET

// Convert number using ffFixed or ffNumber format

@@PutFFixed:
@@PutFNumber:

        CALL    @@PutSign

// Store number in fixed point format

@@PutNumber:

        MOV     EDX,Digits
        CMP     EDX,18
        JB      @@f1
        MOV     EDX,18
@@f1:   MOVSX   ECX,FloatRec.Exponent
        OR      ECX,ECX
        JG      @@f2
        MOV     AL,'0'
        STOSB
        JMP     @@f4
@@f2:   XOR     EBX,EBX
        CMP     Format,ffFixed
        JE      @@f3
        MOV     EAX,ECX
        DEC     EAX
        MOV     BL,3
        DIV     BL
        MOV     BL,AH
        INC     EBX
@@f3:   CALL    @@GetDigit
        STOSB
        DEC     ECX
        JE      @@f4
        DEC     EBX
        JNE     @@f3
        MOV     AL,ThousandSep
        TEST    AL,AL
        JZ      @@f3
        STOSB
        MOV     BL,3
        JMP     @@f3
@@f4:   OR      EDX,EDX
        JE      @@f7
        MOV     AL,DecimalSep
        TEST    AL,AL
        JZ      @@f4b
        STOSB
@@f4b:  JECXZ   @@f6
        MOV     AL,'0'
@@f5:   STOSB
        DEC     EDX
        JE      @@f7
        INC     ECX
        JNE     @@f5
@@f6:   CALL    @@GetDigit
        STOSB
        DEC     EDX
        JNE     @@f6
@@f7:   RET

// Convert number using ffCurrency format

@@PutFCurrency:

        XOR     EBX,EBX
        MOV     BL,CurrFmt.Byte
        MOV     ECX,0003H
        CMP     FloatRec.Negative,0
        JE      @@g1
        MOV     BL,NegCurrFmt.Byte
        MOV     ECX,040FH
@@g1:   CMP     BL,CL
        JBE     @@g2
        MOV     BL,CL
@@g2:   ADD     BL,CH
        LEA     EBX,@@MoneyFormats[EBX+EBX*4]
        ADD     EBX,SaveGOT
        MOV     ECX,5
@@g10:  MOV     AL,[EBX]
        CMP     AL,'@'
        JE      @@g14
        PUSH    ECX
        PUSH    EBX
        CMP     AL,'$'
        JE      @@g11
        CMP     AL,'*'
        JE      @@g12
        STOSB
        JMP     @@g13
@@g11:  CALL    @@PutCurSym
        JMP     @@g13
@@g12:  CALL    @@PutNumber
@@g13:  POP     EBX
        POP     ECX
        INC     EBX
        LOOP    @@g10
@@g14:  RET

// Store currency symbol string

@@PutCurSym:

        PUSH    ESI
        MOV     ESI,CurrencyStr
        TEST    ESI,ESI
        JE      @@h1
        MOV     ECX,[ESI-4]
        REP     MOVSB
@@h1:   POP     ESI
        RET

// Currency formatting templates

@@MoneyFormats:
        DB      '$*@@@'
        DB      '*$@@@'
        DB      '$ *@@'
        DB      '* $@@'
        DB      '($*)@'
        DB      '-$*@@'
        DB      '$-*@@'
        DB      '$*-@@'
        DB      '(*$)@'
        DB      '-*$@@'
        DB      '*-$@@'
        DB      '*$-@@'
        DB      '-* $@'
        DB      '-$ *@'
        DB      '* $-@'
        DB      '$ *-@'
        DB      '$ -*@'
        DB      '*- $@'
        DB      '($ *)'
        DB      '(* $)'

@@Exit:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 4
{$ENDIF ALIGN_STACK}
        PUSH    EAX
        PUSH    EBX
        LEA     EAX,AnsiCurrencyStr
        MOV     EBX,SaveGOT
        CALL    System.@LStrClr
        POP     EBX
        POP     EAX
{$IFDEF ALIGN_STACK}
        ADD     ESP, 4
{$ENDIF ALIGN_STACK}
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

{$IFDEF PUREPASCAL}
function InternalFloatToTextFmt(Buf: PByte; const Value; ValueType: TFloatValue; Format: PByte;
  const AFormatSettings: TFormatSettings; const Unicode: Boolean): Integer;
const
  CMinExtPrecision = 2;
{$IFDEF EXTENDEDIS10BYTES}
  CMaxExtPrecision = 18;
{$ELSE !EXTENDEDIS10BYTES}
  CMaxExtPrecision = 17;
{$ENDIF EXTENDEDIS10BYTES}

var
  AIndex: Integer;
  ThousandSep: Boolean;
  Section: String;
  SectionIndex: Integer;
  FloatValue: TFloatRec;
  DecimalIndex: Integer;
  FirstDigit: Integer;
  LastDigit: Integer;
  DigitCount: Integer;
  Scientific: Boolean;
  Precision: Integer;
  Digits: Integer;
  DecimalSep: Char;
  ThousandsSep: Char;
  FormatLength: Integer;

  procedure AppendChar(const AChar: Char);
  begin
    if Unicode then
    begin
      PWideChar(Buf)^ := AChar;
      Inc(Buf, SizeOf(Char));
    end else
    begin
      PByte(Buf)^ := Byte(AChar);
      Inc(Buf, SizeOf(Byte));
    end;

    Inc(Result);
  end;

  function GetLength(const ABuf: PByte): Integer;
  var
    AWide: PChar;
    AAnsi: PByte;
  begin
    Result := 0;
    if Unicode then
    begin
      AWide := PChar(ABuf);
      while AWide^ <> #0 do
      begin
        Inc(AWide);
        Inc(Result);
      end;
    end else
    begin
      AAnsi := PByte(ABuf);
      while AAnsi^ <> Ord(#0) do
      begin
        Inc(AAnsi);
        Inc(Result);
      end;
    end;
  end;

  function GetCharIndex(const ABuf: PByte; const Index: Integer): Char;
  begin
    if Unicode then
      Result := PWideChar(ABuf)[Index]
    else
      Result := Char(PByte(ABuf)[Index]);
  end;

  procedure AppendString(const AStr: String);
  var
    I, L: Integer;
  begin
    L := AStr.Length;

    if L > 0 then
    begin
      if Unicode then
      begin
        { Unicode -- move directly }
        MoveChars(AStr[Low(string)], Buf^, L);
        Inc(Buf, L * SizeOf(Char));
      end else
      begin
        { ANSI -- loop }
        for I := Low(string) to High(AStr) do
        begin
          PByte(Buf)^ := Byte(AStr[I]);
          Inc(Buf, SizeOf(Byte));
        end;
      end;

      Inc(Result, L);
    end;
  end;

  function FindSection(AIndex: Integer): Integer;
  var
    Section: Integer;
    C: Integer;
  begin
    Section := 0;
    C := 0;
    FormatLength := GetLength(Format);
    while (Section <> AIndex) and (C < FormatLength) do
    begin
      case GetCharIndex(Format, C) of
        ';': begin
          Inc(Section);
          Inc(C);
        end;

        '"': begin
          Inc(C);
          while (C < FormatLength) and (GetCharIndex(Format, C) <> '"') do
            Inc(C);
          if C < FormatLength then
            Inc(C);
        end;

        '''': begin
          Inc(C);
          while (C < FormatLength) and (GetCharIndex(Format, C) <> '''') do
            Inc(C);
          if C < FormatLength then
            Inc(C);
        end;

        else
          Inc(C);
      end;
    end;
    if (Section < AIndex) or (C = FormatLength) then
      Result := 0
    else
      Result := C;
  end;

  function ScanSection(APos: Integer): String;
  var
    C: Integer;
    AChar: Char;
    I: Integer;
  begin
    DecimalIndex := -1;
    Scientific := false;
    ThousandSep := false;
    C := APos;
    FirstDigit := 32767;
    DigitCount := 0;
    LastDigit := 0;
    while (C < FormatLength) and (GetCharIndex(Format, C) <> ';') do
    begin
      case GetCharIndex(Format, C) of
        ',': begin
          ThousandSep := true;
          Inc(C);
        end;

        '.': begin
          if DecimalIndex = -1 then
            DecimalIndex := DigitCount;
          Inc(C);
        end;

        '"': begin
          Inc(C);
          while (C < FormatLength) and (GetCharIndex(Format, C) <> '"') do
            Inc(C);
          if C < FormatLength then
            Inc(C);
        end;

        '''': begin
          Inc(C);
          while (C < FormatLength) and (GetCharIndex(Format, C) <> '''') do
            Inc(C);
          if C < FormatLength then
            Inc(C);
        end;

        'e', 'E': begin
          Inc(C);
          if C < FormatLength then
          begin
            AChar := GetCharIndex(Format, C);
            if (AChar = '-') or (AChar = '+') then begin
              Scientific := true;
              Inc(C);
              while (C < FormatLength) and (GetCharIndex(Format, C) = '0') do
                Inc(C);
            end;
          end;
        end;

        '#': begin
          Inc(DigitCount);
          Inc(C);
        end;

        '0': begin
          if DigitCount < FirstDigit then
            FirstDigit := DigitCount;

          Inc(DigitCount);
          LastDigit := DigitCount;
          Inc(C);
        end;

        else
          Inc(C);
      end;
    end;

    if DecimalIndex = -1 then
      DecimalIndex := DigitCount;
    LastDigit := DecimalIndex - LastDigit;
    if LastDigit > 0 then
      LastDigit := 0;

    FirstDigit := DecimalIndex - FirstDigit;
    if FirstDigit < 0 then
      FirstDigit := 0;
    Result := '';
    for I := APos to APos + (C - APos - 1) do
      Result := Result + GetCharIndex(Format, I);
  end;

  function DigitsLength: Integer;
  var
    C: Integer;
  begin
    Result := 0;
    C := Low(FloatValue.Digits);
    while (C <= High(FloatValue.Digits)) and (FloatValue.Digits[C] <> Ord(#0)) do
    begin
      Inc(C);
      Inc(Result);
    end;
  end;

  procedure ApplyFormat;
  var
    C: Integer;
    DigitDelta: Integer;
    DigitPlace: Integer;
    DigitsC: Integer;
    DigitsLimit: Integer;
    OldC: Char;
    Sign: Char;
    Zeros: Integer;

    procedure WriteDigit(ADigit: Char);
    begin
      if DigitPlace = 0 then
      begin
        AppendChar(DecimalSep);
        AppendChar(ADigit);
        Dec(DigitPlace);
      end
      else
      begin
        AppendChar(ADigit);
        Dec(DigitPlace);
        if ThousandSep and (DigitPlace > 1) and ((DigitPlace mod 3) = 0) then
          AppendChar(ThousandsSep);
      end;
    end;

    procedure AddDigit;
    var
      AChar: Char;
    begin
      if DigitsC <= DigitsLimit then
      begin
        AChar := Char(FloatValue.Digits[DigitsC]);
        Inc(DigitsC);
        WriteDigit(AChar);
      end
      else
      begin
        if DigitPlace <= LastDigit then
          Dec(DigitPlace)
        else
          WriteDigit('0');
      end;
    end;

    procedure PutFmtDigit;
    begin
      if DigitDelta < 0 then
      begin
        Inc(DigitDelta);
        if DigitPlace <= FirstDigit then
          WriteDigit('0')
        else
          Dec(DigitPlace);
      end
      else
      begin
        if DigitDelta = 0 then
          AddDigit
        else
        begin  // DigitDelta > 0
          while DigitDelta > 0 do
          begin
            AddDigit;
            Dec(DigitDelta);
          end;
          AddDigit;
        end;
      end;
    end;

    procedure PutExponent(EChar: Char; Sign: Char; Zeros: Integer; Exponent: Integer);
    var
      Exp: String;
      WriteSign: String;
    begin
      AppendChar(EChar);
      if (Sign = '+') and (Exponent >=0) then
        WriteSign := '+'
      else
        if Exponent < 0 then
          WriteSign := '-'
        else
          WriteSign := '';

      Exp := IntToStr(Abs(Exponent));
      AppendString(WriteSign + StringOfChar('0', Zeros - Exp.Length) + Exp);
    end;

  begin
    if (FloatValue.Negative) and (SectionIndex = 0) then
      AppendChar('-');

    if Scientific then
    begin
      DigitPlace := DecimalIndex;
      DigitDelta := 0;
    end
    else
    begin
      DigitDelta := FloatValue.Exponent - DecimalIndex;
      if DigitDelta >= 0 then
        DigitPlace := FloatValue.Exponent
      else
        DigitPlace := DecimalIndex;
    end;

    DigitsLimit := DigitsLength - 1;
    C := 0;
    DigitsC := 0;
    while C < Section.Length do
    begin
      case Section.Chars[C] of
        '0', '#': begin
          PutFmtDigit;
          Inc(C);
        end;

        '.', ',': Inc(C);

        '"', '''': begin
          OldC := Section.Chars[C];
          Inc(C);
          while (C < Section.Length-1) and (Section.Chars[C] <> OldC) do
          begin
            AppendChar(Section.Chars[C]);
            Inc(C);
          end;
          Inc(C);
        end;

        'e', 'E': begin
          OldC := Section.Chars[C];
          Inc(C);
          if C < Section.Length then
          begin
            Sign := Section.Chars[C];
            if (Sign <> '+') and (Sign <> '-') then
              AppendChar(OldC)
            else
            begin
              Zeros := 0;
              Inc(C);
              while (C < Section.Length) and (Section.Chars[C] = '0') do
              begin
                Inc(C);
                if Zeros < 4 then Inc(Zeros);
              end;
              PutExponent(OldC, Sign, Zeros, FloatValue.Exponent - DecimalIndex);
            end;
          end;
        end;

        else
        begin
          AppendChar(Section.Chars[C]);
          Inc(C);
        end;
      end;
    end;
    if Result > 0 then begin
      AppendChar(#0);
      Dec(Result);
    end;
  end;

var
  Temp: Extended;

begin
  Result := 0;
  DecimalSep := AFormatSettings.DecimalSeparator;
  ThousandsSep := AFormatSettings.ThousandSeparator;

  if ValueType = fvCurrency then
    Temp := Currency(Value)
  else
    Temp := Extended(Value);

  if Extended(Temp) > 0 then
    AIndex := 0
  else
    if Extended(Temp) < 0 then
      AIndex := 1
    else
      AIndex := 2;

  SectionIndex := FindSection(AIndex);
  Section := ScanSection(SectionIndex);
  if Section = '' then
  begin
    SectionIndex := FindSection(0);
    Section := ScanSection(SectionIndex);
  end;

  if Scientific then
  begin
    Precision := DigitCount;
    Digits := 9999;
  end
  else begin
    Precision := CMaxExtPrecision;
    Digits := DigitCount - DecimalIndex;
  end;
  FloatToDecimal(FloatValue, Value, ValueType, Precision, Digits);

  if (FormatLength = 0) or (GetCharIndex(Format, 0) = ';') or
    ((FloatValue.Exponent >= 18) and (not Scientific)) or
    (FloatValue.Exponent = $7FF) or (FloatValue.Exponent = $800) then
{$IFNDEF NEXTGEN}
    if Unicode then
      Result := FloatToText(PWideChar(Buf), Value, ValueType, ffGeneral, 15, 0)
    else
      Result := FloatToText(PAnsiChar(Buf), Value, ValueType, ffGeneral, 15, 0)
{$ELSE NEXTGEN}
    Result := FloatToText(PWideChar(Buf), Value, ValueType, ffGeneral, 15, 0)
{$ENDIF !NEXTGEN}
  else
    ApplyFormat;
end;
{$ENDIF PUREPASCAL}

{$IFNDEF NEXTGEN}
function FloatToTextFmt(Buf: PAnsiChar; const Value; ValueType: TFloatValue; Format: PAnsiChar): Integer;
begin
  Result := FloatToTextFmt(Buf, Value, ValueType, Format, FormatSettings);
end;

function FloatToTextFmt(Buf: PAnsiChar; const Value; ValueType: TFloatValue;
  Format: PAnsiChar; const AFormatSettings: TFormatSettings): Integer;
{$IFDEF PUREPASCAL}
begin
  Result := InternalFloatToTextFmt(PByte(Buf), Value, ValueType, PByte(Format), AFormatSettings, False);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  Buffer: Pointer;
  ThousandSep: Boolean;
  DecimalSep: AnsiChar;
  ThousandsSep: AnsiChar;
  Scientific: Boolean;
  Section: Integer;
  DigitCount: Integer;
  DecimalIndex: Integer;
  FirstDigit: Integer;
  LastDigit: Integer;
  DigitPlace: Integer;
  DigitDelta: Integer;
  FloatRec: TFloatRec;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     Buffer,EAX
        MOV     EDI,EDX
        MOV     EBX,ECX
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.DecimalSeparator)
        MOV     DecimalSep,AL
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.ThousandSeparator)
        MOV     ThousandsSep,AL
        MOV     ECX,2
        CMP     BL,fvExtended
        JE      @@1
        MOV     EAX,[EDI].Integer
        OR      EAX,[EDI].Integer[4]
        JE      @@2
        MOV     ECX,[EDI].Integer[4]
        SHR     ECX,31
        JMP     @@2
@@1:    MOVZX   EAX,[EDI].Word[8]
        OR      EAX,[EDI].Integer[0]
        OR      EAX,[EDI].Integer[4]
        JE      @@2
        MOVZX   ECX,[EDI].Word[8]
        SHR     ECX,15
@@2:    CALL    @@FindSection
        JE      @@5
        CALL    @@ScanSection
        MOV     EAX,DigitCount
        MOV     EDX,9999
        CMP     Scientific,0
        JNE     @@3
        SUB     EAX,DecimalIndex
        MOV     EDX,EAX
        MOV     EAX,18
@@3:    PUSH    EAX
        PUSH    EDX
        LEA     EAX,FloatRec
        MOV     EDX,EDI
        MOV     ECX,EBX
        CALL    FloatToDecimal                { Stack aligned - ESP(xxxxxxx0h) on call }
        MOV     AX,FloatRec.Exponent
        CMP     AX,8000H
        JE      @@5
        CMP     AX,7FFFH
        JE      @@5
        CMP     BL,fvExtended
        JNE     @@6
        CMP     AX,18
        JLE     @@6
        CMP     Scientific,0
        JNE     @@6
@@5:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF ALIGN_STACK}
        PUSH    ffGeneral
        PUSH    15
        PUSH    0
        MOV     EAX,[AFormatSettings]
        PUSH    EAX
        MOV     EAX,Buffer
        MOV     EDX,EDI
        MOV     ECX,EBX
        CALL    AnsiFloatToTextEx
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF ALIGN_STACK}
        JMP     @@Exit
@@6:    CMP     FloatRec.Digits.Byte,0
        JNE     @@7
        MOV     ECX,2
        CALL    @@FindSection
        JE      @@5
        CMP     ESI,Section
        JE      @@7
        CALL    @@ScanSection
@@7:    CALL    @@ApplyFormat
        JMP     @@Exit

// Find format section
// In   ECX = Section index
// Out  ESI = Section offset
//      ZF  = 1 if section is empty

@@FindSection:
        MOV     ESI,Format
        JECXZ   @@fs2
@@fs1:  LODSB
        CMP     AL,"'"
        JE      @@fs4
        CMP     AL,'"'
        JE      @@fs4
        OR      AL,AL
        JE      @@fs2
        CMP     AL,';'
        JNE     @@fs1
        LOOP    @@fs1
        MOV     AL,byte ptr [ESI]
        OR      AL,AL
        JE      @@fs2
        CMP     AL,';'
        JNE     @@fs3
@@fs2:  MOV     ESI,Format
        MOV     AL,byte ptr [ESI]
        OR      AL,AL
        JE      @@fs3
        CMP     AL,';'
@@fs3:  RET
@@fs4:  MOV     AH,AL
@@fs5:  LODSB
        CMP     AL,AH
        JE      @@fs1
        OR      AL,AL
        JNE     @@fs5
        JMP     @@fs2

// Scan format section

@@ScanSection:
        PUSH    EBX
        MOV     Section,ESI
        MOV     EBX,32767
        XOR     ECX,ECX
        XOR     EDX,EDX
        MOV     DecimalIndex,-1
        MOV     ThousandSep,DL
        MOV     Scientific,DL
@@ss1:  LODSB
@@ss2:  CMP     AL,'#'
        JE      @@ss10
        CMP     AL,'0'
        JE      @@ss11
        CMP     AL,'.'
        JE      @@ss13
        CMP     AL,','
        JE      @@ss14
        CMP     AL,"'"
        JE      @@ss15
        CMP     AL,'"'
        JE      @@ss15
        CMP     AL,'E'
        JE      @@ss20
        CMP     AL,'e'
        JE      @@ss20
        CMP     AL,';'
        JE      @@ss30
        OR      AL,AL
        JNE     @@ss1
        JMP     @@ss30
@@ss10: INC     EDX
        JMP     @@ss1
@@ss11: CMP     EDX,EBX
        JGE     @@ss12
        MOV     EBX,EDX
@@ss12: INC     EDX
        MOV     ECX,EDX
        JMP     @@ss1
@@ss13: CMP     DecimalIndex,-1
        JNE     @@ss1
        MOV     DecimalIndex,EDX
        JMP     @@ss1
@@ss14: MOV     ThousandSep,1
        JMP     @@ss1
@@ss15: MOV     AH,AL
@@ss16: LODSB
        CMP     AL,AH
        JE      @@ss1
        OR      AL,AL
        JNE     @@ss16
        JMP     @@ss30
@@ss20: LODSB
        CMP     AL,'-'
        JE      @@ss21
        CMP     AL,'+'
        JNE     @@ss2
@@ss21: MOV     Scientific,1
@@ss22: LODSB
        CMP     AL,'0'
        JE      @@ss22
        JMP     @@ss2
@@ss30: MOV     DigitCount,EDX
        CMP     DecimalIndex,-1
        JNE     @@ss31
        MOV     DecimalIndex,EDX
@@ss31: MOV     EAX,DecimalIndex
        SUB     EAX,ECX
        JLE     @@ss32
        XOR     EAX,EAX
@@ss32: MOV     LastDigit,EAX
        MOV     EAX,DecimalIndex
        SUB     EAX,EBX
        JGE     @@ss33
        XOR     EAX,EAX
@@ss33: MOV     FirstDigit,EAX
        POP     EBX
        RET

// Apply format string

@@ApplyFormat:
        CMP     Scientific,0
        JE      @@af1
        MOV     EAX,DecimalIndex
        XOR     EDX,EDX
        JMP     @@af3
@@af1:  MOVSX   EAX,FloatRec.Exponent
        CMP     EAX,DecimalIndex
        JG      @@af2
        MOV     EAX,DecimalIndex
@@af2:  MOVSX   EDX,FloatRec.Exponent
        SUB     EDX,DecimalIndex
@@af3:  MOV     DigitPlace,EAX
        MOV     DigitDelta,EDX
        MOV     ESI,Section
        MOV     EDI,Buffer
        LEA     EBX,FloatRec.Digits
        CMP     FloatRec.Negative,0
        JE      @@af10
        CMP     ESI,Format
        JNE     @@af10
        MOV     AL,'-'
        STOSB
@@af10: LODSB
        CMP     AL,'#'
        JE      @@af20
        CMP     AL,'0'
        JE      @@af20
        CMP     AL,'.'
        JE      @@af10
        CMP     AL,','
        JE      @@af10
        CMP     AL,"'"
        JE      @@af25
        CMP     AL,'"'
        JE      @@af25
        CMP     AL,'E'
        JE      @@af30
        CMP     AL,'e'
        JE      @@af30
        CMP     AL,';'
        JE      @@af40
        OR      AL,AL
        JE      @@af40
@@af11: STOSB
        JMP     @@af10
@@af20: CALL    @@PutFmtDigit
        JMP     @@af10
@@af25: MOV     AH,AL
@@af26: LODSB
        CMP     AL,AH
        JE      @@af10
        OR      AL,AL
        JE      @@af40
        STOSB
        JMP     @@af26
@@af30: MOV     AH,[ESI]
        CMP     AH,'+'
        JE      @@af31
        CMP     AH,'-'
        JNE     @@af11
        XOR     AH,AH
@@af31: MOV     ECX,-1
@@af32: INC     ECX
        INC     ESI
        CMP     [ESI].Byte,'0'
        JE      @@af32
        CMP     ECX,4
        JB      @@af33
        MOV     ECX,4
@@af33: PUSH    EBX
        MOV     BL,FloatRec.Digits.Byte
        XOR     BH,BH
        MOVSX   EDX,FloatRec.Exponent
        SUB     EDX,DecimalIndex
        CALL    PutExponent   {Safe to call unaligned}
        POP     EBX
        JMP     @@af10
@@af40: MOV     EAX,EDI
        SUB     EAX,Buffer
        RET

// Store formatted digit

@@PutFmtDigit:
        CMP     DigitDelta,0
        JE      @@fd3
        JL      @@fd2
@@fd1:  CALL    @@fd3
        DEC     DigitDelta
        JNE     @@fd1
        JMP     @@fd3
@@fd2:  INC     DigitDelta
        MOV     EAX,DigitPlace
        CMP     EAX,FirstDigit
        JLE     @@fd4
        JMP     @@fd7
@@fd3:  MOV     AL,[EBX]
        INC     EBX
        OR      AL,AL
        JNE     @@fd5
        DEC     EBX
        MOV     EAX,DigitPlace
        CMP     EAX,LastDigit
        JLE     @@fd7
@@fd4:  MOV     AL,'0'
@@fd5:  CMP     DigitPlace,0
        JNE     @@fd6
        MOV     AH,AL
        MOV     AL,DecimalSep
        STOSW
        JMP     @@fd7
@@fd6:  STOSB
        CMP     ThousandSep,0
        JE      @@fd7
        MOV     EAX,DigitPlace
        CMP     EAX,1
        JLE     @@fd7
        MOV     DL,3
        DIV     DL
        CMP     AH,1
        JNE     @@fd7
        MOV     AL,ThousandsSep
        TEST    AL,AL
        JZ      @@fd7
        STOSB
@@fd7:  DEC     DigitPlace
        RET

@@exit:
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function FloatToTextFmt(Buf: PWideChar; const Value; ValueType: TFloatValue;
  Format: PWideChar): Integer;
begin
  Result := FloatToTextFmt(Buf, Value, ValueType, Format, FormatSettings);
end;

function FloatToTextFmt(Buf: PWideChar; const Value; ValueType: TFloatValue;
  Format: PWideChar; const AFormatSettings: TFormatSettings): Integer; overload;
{$IFDEF PUREPASCAL}
begin
  Result := InternalFloatToTextFmt(PByte(Buf), Value, ValueType, PByte(Format), AFormatSettings, True);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  Buffer: Pointer;
  ThousandSep: Boolean;
  DecimalSep: Char;
  ThousandsSep: Char;
  Scientific: Boolean;
  Section: Integer;
  DigitCount: Integer;
  DecimalIndex: Integer;
  FirstDigit: Integer;
  LastDigit: Integer;
  DigitPlace: Integer;
  DigitDelta: Integer;
  FloatRec: TFloatRec;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     Buffer,EAX
        MOV     EDI,EDX
        MOV     EBX,ECX
        MOV     EAX,AFormatSettings
        MOV     AX,[EAX].TFormatSettings.DecimalSeparator
        MOV     DecimalSep,AX
        MOV     EAX,AFormatSettings
        MOV     AX,[EAX].TFormatSettings.ThousandSeparator
        MOV     ThousandsSep,AX
        MOV     ECX,2
        CMP     BL,fvExtended
        JE      @@1
        MOV     EAX,[EDI].Integer
        OR      EAX,[EDI].Integer[4]
        JE      @@2
        MOV     ECX,[EDI].Integer[4]
        SHR     ECX,31
        JMP     @@2
@@1:    MOVZX   EAX,[EDI].Word[8]
        OR      EAX,[EDI].Integer[0]
        OR      EAX,[EDI].Integer[4]
        JE      @@2
        MOVZX   ECX,[EDI].Word[8]
        SHR     ECX,15
@@2:    CALL    @@FindSection
        JE      @@5
        CALL    @@ScanSection
        MOV     EAX,DigitCount
        MOV     EDX,9999
        CMP     Scientific,0
        JNE     @@3
        SUB     EAX,DecimalIndex
        MOV     EDX,EAX
        MOV     EAX,18
@@3:    PUSH    EAX
        PUSH    EDX
        LEA     EAX,FloatRec
        MOV     EDX,EDI
        MOV     ECX,EBX
        CALL    FloatToDecimal            { Stack aligned - ESP(xxxxxxx0h) on call }
        MOV     AX,FloatRec.Exponent
        CMP     AX,8000H
        JE      @@5
        CMP     AX,7FFFH
        JE      @@5
        CMP     BL,fvExtended
        JNE     @@6
        CMP     AX,18
        JLE     @@6
        CMP     Scientific,0
        JNE     @@6
@@5:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF ALIGN_STACK}
        PUSH    ffGeneral
        PUSH    15
        PUSH    0
        MOV     EAX,[AFormatSettings]
        PUSH    EAX
        MOV     EAX,Buffer
        MOV     EDX,EDI
        MOV     ECX,EBX
        CALL    WideFloatToTextFmtSettings
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF ALIGN_STACK}
        JMP     @@Exit
@@6:    CMP     FloatRec.Digits.Byte,0
        JNE     @@7
        MOV     ECX,2
        CALL    @@FindSection
        JE      @@5
        CMP     ESI,Section
        JE      @@7
        CALL    @@ScanSection
@@7:    CALL    @@ApplyFormat
        JMP     @@Exit

// Find format section
// In   ECX = Section index
// Out  ESI = Section offset
//      ZF  = 1 if section is empty

@@FindSection:
        MOV     ESI,Format
        JECXZ   @@fs2
@@fs1:  LODSW
        CMP     AX,"'"
        JE      @@fs4
        CMP     AX,'"'
        JE      @@fs4
        OR      AX,AX
        JE      @@fs2
        CMP     AX,';'
        JNE     @@fs1
        LOOP    @@fs1
        MOV     AX,word ptr [ESI]
        OR      AX,AX
        JE      @@fs2
        CMP     AX,';'
        JNE     @@fs3
@@fs2:  MOV     ESI,Format
        MOV     AX,word ptr [ESI]
        OR      AX,AX
        JE      @@fs3
        CMP     AX,';'
@@fs3:  RET
@@fs4:  MOV     DX,AX
@@fs5:  LODSW
        CMP     AX,DX
        JE      @@fs1
        OR      AX,AX
        JNE     @@fs5
        JMP     @@fs2

// Scan format section

@@ScanSection:
        PUSH    EBX
        MOV     Section,ESI
        MOV     EBX,32767
        XOR     ECX,ECX
        XOR     EDX,EDX
        MOV     DecimalIndex,-1
        MOV     ThousandSep,DL
        MOV     Scientific,DL
@@ss1:  LODSW
@@ss2:  CMP     AX,'#'
        JE      @@ss10
        CMP     AX,'0'
        JE      @@ss11
        CMP     AX,'.'
        JE      @@ss13
        CMP     AX,','
        JE      @@ss14
        CMP     AX,"'"
        JE      @@ss15
        CMP     AX,'"'
        JE      @@ss15
        CMP     AX,'E'
        JE      @@ss20
        CMP     AX,'e'
        JE      @@ss20
        CMP     AX,';'
        JE      @@ss30
        OR      AX,AX
        JNE     @@ss1
        JMP     @@ss30
@@ss10: INC     EDX
        JMP     @@ss1
@@ss11: CMP     EDX,EBX
        JGE     @@ss12
        MOV     EBX,EDX
@@ss12: INC     EDX
        MOV     ECX,EDX
        JMP     @@ss1
@@ss13: CMP     DecimalIndex,-1
        JNE     @@ss1
        MOV     DecimalIndex,EDX
        JMP     @@ss1
@@ss14: MOV     ThousandSep,1
        JMP     @@ss1
@@ss15: PUSH    EBX
        MOV     BX,AX
@@ss16: LODSW
        CMP     AX,BX
        JNE     @@ss17
        POP     EBX
        JE      @@ss1
@@ss17: OR      AX,AX
        JNE     @@ss16
        POP     EBX
        JMP     @@ss30
@@ss20: LODSW
        CMP     AX,'-'
        JE      @@ss21
        CMP     AX,'+'
        JNE     @@ss2
@@ss21: MOV     Scientific,1
@@ss22: LODSW
        CMP     AX,'0'
        JE      @@ss22
        JMP     @@ss2
@@ss30: MOV     DigitCount,EDX
        CMP     DecimalIndex,-1
        JNE     @@ss31
        MOV     DecimalIndex,EDX
@@ss31: MOV     EAX,DecimalIndex
        SUB     EAX,ECX
        JLE     @@ss32
        XOR     EAX,EAX
@@ss32: MOV     LastDigit,EAX
        MOV     EAX,DecimalIndex
        SUB     EAX,EBX
        JGE     @@ss33
        XOR     EAX,EAX
@@ss33: MOV     FirstDigit,EAX
        POP     EBX
        RET

// Apply format string

@@ApplyFormat:
        CMP     Scientific,0
        JE      @@af1
        MOV     EAX,DecimalIndex
        XOR     EDX,EDX
        JMP     @@af3
@@af1:  MOVSX   EAX,FloatRec.Exponent
        CMP     EAX,DecimalIndex
        JG      @@af2
        MOV     EAX,DecimalIndex
@@af2:  MOVSX   EDX,FloatRec.Exponent
        SUB     EDX,DecimalIndex
@@af3:  MOV     DigitPlace,EAX
        MOV     DigitDelta,EDX
        MOV     ESI,Section
        MOV     EDI,Buffer
        LEA     EBX,FloatRec.Digits
        CMP     FloatRec.Negative,0
        JE      @@af10
        CMP     ESI,Format
        JNE     @@af10
        MOV     AX,'-'
        STOSW
@@af10: LODSW
        CMP     AX,'#'
        JE      @@af20
        CMP     AX,'0'
        JE      @@af20
        CMP     AX,'.'
        JE      @@af10
        CMP     AX,','
        JE      @@af10
        CMP     AX,"'"
        JE      @@af25
        CMP     AX,'"'
        JE      @@af25
        CMP     AX,'E'
        JE      @@af30
        CMP     AX,'e'
        JE      @@af30
        CMP     AX,';'
        JE      @@af40
        OR      AX,AX
        JE      @@af40
@@af11: STOSW
        JMP     @@af10
@@af20: CALL    @@PutFmtDigit
        JMP     @@af10
@@af25: PUSH    EBX
        MOV     BX,AX
@@af26: LODSW
        CMP     AX,BX
        JNE     @@af27
        POP     EBX
        JE      @@af10
@@af27: OR      AX,AX
        JNE     @@af28
        POP     EBX
        JMP     @@af40
@@af28: STOSW
        JMP     @@af26
@@af30: MOV     AH,[ESI]
        CMP     AH,'+'
        JE      @@af31
        CMP     AH,'-'
        JE      @@af30a
        XOR     AH,AH
        JMP     @@af11
@@af30a:XOR     AH,AH
@@af31: MOV     ECX,-1
@@af32: INC     ECX
        INC     ESI
        INC     ESI
        CMP     [ESI].Word,'0'
        JE      @@af32
        CMP     ECX,4
        JB      @@af33
        MOV     ECX,4
@@af33: PUSH    EBX
        MOV     BL,FloatRec.Digits.Byte
        MOV     BH,1
        MOVSX   EDX,FloatRec.Exponent
        SUB     EDX,DecimalIndex
        CALL    PutExponent    {Safe to call unaligned}
        POP     EBX
        JMP     @@af10
@@af40: MOV     EAX,EDI
        SUB     EAX,Buffer
        SHR     EAX,1
        RET

// Store formatted digit

@@PutFmtDigit:
        CMP     DigitDelta,0
        JE      @@fd3
        JL      @@fd2
@@fd1:  CALL    @@fd3
        DEC     DigitDelta
        JNE     @@fd1
        JMP     @@fd3
@@fd2:  INC     DigitDelta
        MOV     EAX,DigitPlace
        CMP     EAX,FirstDigit
        JLE     @@fd4
        JMP     @@fd7
@@fd3:  XOR     AH,AH
        MOV     AL,[EBX]
        INC     EBX
        OR      AL,AL
        JNE     @@fd5
        DEC     EBX
        MOV     EAX,DigitPlace
        CMP     EAX,LastDigit
        JLE     @@fd7
@@fd4:  MOV     AX,'0'
@@fd5:  CMP     DigitPlace,0
        JNE     @@fd6
        SHL     EAX,16
        MOV     AX,DecimalSep
        STOSD
        JMP     @@fd7
@@fd6:  STOSW
        CMP     ThousandSep,0
        JE      @@fd7
        MOV     EAX,DigitPlace
        CMP     EAX,1
        JLE     @@fd7
        MOV     DL,3
        DIV     DL
        CMP     AH,1
        JNE     @@fd7
        MOV     AX,ThousandsSep
        TEST    AX,AX
        JZ      @@fd7
        STOSW
@@fd7:  DEC     DigitPlace
        RET

@@exit:
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

const
// 8087/SSE status word masks
  mIE = $0001;
  mDE = $0002;
  mZE = $0004;
  mOE = $0008;
  mUE = $0010;
  mPE = $0020;
{$IFDEF CPUX86}
  mC0 = $0100;
  mC1 = $0200;
  mC2 = $0400;
  mC3 = $4000;
{$ENDIF CPUX86}

{$IFDEF CPUX86}
const
// 8087 control word
// Infinity control  = 1 Affine
// Rounding Control  = 0 Round to nearest or even
// Precision Control = 3 64 bits
// All interrupts masked
  CWNear: Word = $133F;
{$ENDIF CPUX86}
{$IFDEF CPUX64}
const
//  MXCSR control word
// Rounding Control  = 0 Round to nearest or even
// All interrupts masked
  MXCSRNear: UInt32 = $1F80;
{$ENDIF CPUX64}

procedure FloatToDecimal(var Result: TFloatRec; const Value; ValueType: TFloatValue; 
  Precision, Decimals: Integer);
{$IFDEF PUREPASCAL}
  type
    TBCDBytes = array [0..9] of Byte;

  function GetBcdBytes(val:Extended): TBcdBytes;
  var
    I: Int64;
    Ind, D: Integer;
  begin
    FillChar(Result, SizeOf(Result), 0);
    if val < 0 then Result[9] := $80;
    I := Round(Abs(val));
    Ind := 0;
    while (I > 0) and (Ind < 9) do
    begin
      D := I mod 100;
      Result[Ind] := (D mod 10) + ((D div 10) shl 4);
      I := I div 100;
      Inc(Ind);
    end;
  end;

  procedure ExtToDecimal(Value: Extended);
  var
    Exp : Integer;
    bcdBytes: TBcdBytes;
    I, J : Integer;
{$IFNDEF EXTENDEDIS10BYTES}
    N: Int64;
{$ENDIF !EXTENDEDIS10BYTES}
  begin
{$IFDEF EXTENDEDIS10BYTES}
    Exp := PWordArray(@Value)^[4];
    Result.Negative := (Exp and $8000) = $8000;
{$ELSE !EXTENDEDIS10BYTES}
    Exp := PWordArray(@Value)^[3] shr 4;
    Result.Negative := (Exp and $800) = $800;
{$ENDIF EXTENDEDIS10BYTES}

{$IFDEF EXTENDEDIS10BYTES}
    Exp := Exp and $7FFF;
    if (Exp = 0) and (PInt64(@Value)^ = 0)then
{$ELSE !EXTENDEDIS10BYTES}
    Exp := Exp and $7FF;
    if (Exp = 0) and
        ( ((PWordArray(@Value)^[3] and $000F) = $0000) and
           (PWordArray(@Value)^[2] = $0000) and
           (PWordArray(@Value)^[1] = $0000) and
           (PWordArray(@Value)^[0] = $0000) ) then
{$ENDIF EXTENDEDIS10BYTES}
    begin
      // plus/minus zero.
      Result.Exponent := 0; //
      Result.Digits[0] := Ord(#0);
      Result.Negative := False;  // to match the 32 bits behaviour
      Exit;
    end
{$IFDEF EXTENDEDIS10BYTES}
    else if Exp = $7FFF then
{$ELSE !EXTENDEDIS10BYTES}
    else if Exp = $7FF then
{$ENDIF EXTENDEDIS10BYTES}
    begin
{$IFDEF EXTENDEDIS10BYTES}
      if (PWordArray(@Value)^[3] = $8000) and
         (PWordArray(@Value)^[2] = $0000) and
         (PWordArray(@Value)^[1] = $0000) and
         (PWordArray(@Value)^[0] = $0000) then
      begin
        // plus/minus inf.
        Result.Exponent := $7FFF; // Exp;
      end
{$ELSE !EXTENDEDIS10BYTES}
      if (((PWordArray(@Value)^[3] and $000F) = $0000) and
           (PWordArray(@Value)^[2] = $0000) and
           (PWordArray(@Value)^[1] = $0000) and
           (PWordArray(@Value)^[0] = $0000) ) then
      begin
        // plus/minus inf.
        Result.Exponent := $7FF; // Exp;
      end
{$ENDIF EXTENDEDIS10BYTES}
      else
      begin
        // NaN
{$IFDEF EXTENDEDIS10BYTES}
        Result.Exponent := SmallInt($8000);
{$ELSE !EXTENDEDIS10BYTES}
        Result.Exponent := SmallInt($800);
{$ENDIF EXTENDEDIS10BYTES}
        Result.Negative := False;
      end;
      Result.Digits[0] := Ord(#0);
      Exit;
    end;

    if Result.Negative then Value := -Value;

{$IFDEF EXTENDEDIS10BYTES}
    Exp := Exp - $3FFF;
{$ELSE !EXTENDEDIS10BYTES}
    if Exp = 0 then  //denormalized number, exponent = 0 and mantissa <> 0, fix exponent
    begin
      N := PInt64(@Value)^;
      while (N and $0008000000000000) = 0 do
      begin
        Dec(Exp);
        N := N shl 1;
      end;
    end;
    Exp := Exp - $3FF;
{$ENDIF EXTENDEDIS10BYTES}
    Exp := (Exp * 19728);  // // exp10 * 2 ** 16 = exp2 * log10(2) * 2**16. Log10(2) * 2 ** 16 ~= 19728
    Exp := PSmallInt(PByte(@Exp)+2)^; // Temp = High 16 bits of result, sign extended
    Exp := Exp + 1;
    Result.Exponent := Exp;

    Value := Round(Power10(Value, 18 - Exp));
    if Value >= FCon1E18 then
    begin
      Value := Value / DCon10;
      Inc(Result.Exponent);
    end;
    bcdBytes := GetBcdBytes(Value);

    for I := 8 downto 0 do
      PWord(@Result.Digits[16-I*2])^ := $3030 +
        ((bcdBytes[I] and $0F) SHL 8) +
        ((bcdBytes[I] and $F0) SHR 4);
    Result.Digits[18] := Ord(#0);

    if Result.Exponent + Decimals < 0 then
    begin
      Result.Exponent := 0;
      Result.Negative := False;
      Result.Digits[0] := Ord(#0);
      Exit;
    end;
    J := Result.Exponent + Decimals;
    if J >= Precision then J := Precision;
    if (J >= 18) or  (Result.Digits[J] < Ord('5')) then
    begin
      if (J > 18) then J := 18;
      while true do
      begin
        Result.Digits[J] := Ord(#0);
        Dec(J);
        if J < 0 then
        begin
          Result.Negative := False;
          Exit;
        end;
        if Result.Digits[J] <> Ord('0') then
          Exit;
      end;
    end
    else
    begin
      Result.Digits[J+1] := Ord(#0);
      while true do
      begin
        Result.Digits[J] := Ord(#0);
        Dec(J);
        if J < 0 then
        begin
          Result.Digits[0] := Ord('1');
          Inc(Result.Exponent);
          Exit;
        end;

        Inc(Result.Digits[J]);
        if Result.Digits[J] <= Ord('9') then
          Exit;
      end;
    end;
  end;

  procedure CurrToDecimal(Value: Currency);
  Var
    U: UInt64;
    LChars: TArray<Char>;
    RoundUpFlag: Boolean;
    I, J: Integer;
    RoundingCh : Char;
    Exp: SmallInt;
    NegaFlag: Boolean;
  begin
    Result.Negative := False;
    Result.Exponent := 0;
    Result.Digits[0] := Ord(#0);

    U := PUInt64(@Value)^;
    if U = 0 then Exit;

    NegaFlag := False;
    if (U and $8000000000000000) <> 0 then
    begin
      NegaFlag := True;
      U := not U + 1;
    end;

    LChars := _IntToStr64(U, False).ToCharArray;

    if Decimals >= 4 then
      Decimals := 4
    else if Decimals < 0 then
      Decimals := 0;

    if Decimals < 4 then
    begin
      I := 4 - Decimals;

      if Length(LChars) < I then Exit;

      J := Length(LChars) - I;
      RoundingCh := LChars[J];
      LChars[J] := '0';
      Inc(J);

      RoundUpFlag := False;
      while J < Length(LChars) do
      begin
        if LChars[J] <> '0' then
        begin
          RoundUpFlag := True;
          LChars[J] := '0';
        end;
        Inc(J);
      end;

      if RoundingCh >= '5' then
      begin
        J := High(LChars) - I;
        if (RoundingCh > '5') or (RoundUpFlag or ((J >= 0) and (LChars[J] in ['1', '3', '5', '7', '9']))) then
        begin
          while (J >= 0) and (LChars[J] = '9') do
          begin
            LChars[J] := '0';
            Dec(J);
          end;
          if J < 0 then
          begin
            SetLength(LChars, Length(LChars)+1);
            for I:=High(LChars) downto 1 do
              LChars[I] := LChars[I-1];
            LChars[0] := '1';
          end
          else
            LChars[J] := Succ(LChars[J]);
        end;
      end
    end;

    J := Length(LChars);
    Exp := J - 4;
    Dec(J);
    while ( J >= 0) and (LChars[J] = '0') do
      Dec(J);
    if J >=0 then
    begin
      for I := 0 to J do
        Result.Digits[I] := Ord(LChars[I]);
      Result.Digits[J+1] := Ord(#0);
      Result.Exponent := Exp;
      Result.Negative := NegaFlag;
    end;
  end;

begin
  if ValueType = fvExtended then
    ExtToDecimal(Extended(Value))
  else
    CurrToDecimal(Currency(Value));
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  StatWord: Word;
  Exponent: Integer;
  Temp: Double;
  BCDValue: Extended;
  SaveGOT: Pointer;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EBX,EAX
        MOV     ESI,EDX
{$IFDEF PIC}
        PUSH    ECX
        CALL    GetGOT
        POP     ECX
        MOV     SaveGOT,EAX
{$ELSE !PIC}
        MOV     SaveGOT,0
{$ENDIF !PIC}
        CMP     CL,fvExtended
        JE      @@1
        CALL    @@CurrToDecimal
        JMP     @@Exit
@@1:    CALL    @@ExtToDecimal
        JMP     @@Exit

// Convert Extended to decimal

@@ExtToDecimal:

        MOV     AX,[ESI].Word[8]
        MOV     EDX,EAX
        AND     EAX,7FFFH
        JE      @@ed1
        CMP     EAX,7FFFH
        JNE     @@ed10
// check for special values (INF, NAN)
        TEST    [ESI].Word[6],8000H
        JZ      @@ed2
// any significand bit set = NAN
// all significand bits clear = INF
        CMP     dword ptr [ESI], 0
        JNZ     @@ed0
        CMP     dword ptr [ESI+4], 80000000H
        JZ      @@ed2
@@ed0:  INC     EAX
@@ed1:  XOR     EDX,EDX
@@ed2:  MOV     [EBX].TFloatRec.Digits.Byte,0
        JMP     @@ed31
@@ed10: FLD     TBYTE PTR [ESI]
        SUB     EAX,3FFFH
        IMUL    EAX,19728
        SAR     EAX,16
        INC     EAX
        MOV     Exponent,EAX
        MOV     EAX,18
        SUB     EAX,Exponent
        FABS
        PUSH    EBX
        MOV     EBX,SaveGOT
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        CALL    FPower10
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        POP     EBX
        FRNDINT
        MOV     EDI,SaveGOT
        FLD     [EDI].FCon1E18
        FCOMP
        FSTSW   StatWord
        FWAIT
        TEST    StatWord,mC0+mC3
        JE      @@ed11
        FIDIV   [EDI].DCon10
        INC     Exponent
@@ed11: FBSTP   BCDValue
        LEA     EDI,[EBX].TFloatRec.Digits
        MOV     EDX,9
        FWAIT
@@ed12: MOV     AL,BCDValue[EDX-1].Byte
        MOV     AH,AL
        SHR     AL,4
        AND     AH,0FH
        ADD     AX,'00'
        STOSW
        DEC     EDX
        JNE     @@ed12
        XOR     AL,AL
        STOSB
@@ed20: MOV     EDI,Exponent
        ADD     EDI,Decimals
        JNS     @@ed21
        XOR     EAX,EAX
        JMP     @@ed1
@@ed21: CMP     EDI,Precision
        JB      @@ed22
        MOV     EDI,Precision
@@ed22: CMP     EDI,18
        JAE     @@ed26
        CMP     [EBX].TFloatRec.Digits.Byte[EDI],'5'
        JB      @@ed25
@@ed23: MOV     [EBX].TFloatRec.Digits.Byte[EDI],0
        DEC     EDI
        JS      @@ed24
        INC     [EBX].TFloatRec.Digits.Byte[EDI]
        CMP     [EBX].TFloatRec.Digits.Byte[EDI],'9'
        JA      @@ed23
        JMP     @@ed30
@@ed24: MOV     [EBX].TFloatRec.Digits.Word,'1'
        INC     Exponent
        JMP     @@ed30
@@ed26: MOV     EDI,18
@@ed25: MOV     [EBX].TFloatRec.Digits.Byte[EDI],0
        DEC     EDI
        JS      @@ed32
        CMP     [EBX].TFloatRec.Digits.Byte[EDI],'0'
        JE      @@ed25
@@ed30: MOV     DX,[ESI].Word[8]
@@ed30a:
        MOV     EAX,Exponent
@@ed31: SHR     DX,15
        MOV     [EBX].TFloatRec.Exponent,AX
        MOV     [EBX].TFloatRec.Negative,DL
        RET
@@ed32: XOR     EDX,EDX
        JMP     @@ed30a

@@DecimalTable:
        DD      10
        DD      100
        DD      1000
        DD      10000

// Convert Currency to decimal

@@CurrToDecimal:

        MOV     EAX,[ESI].Integer[0]
        MOV     EDX,[ESI].Integer[4]
        MOV     ECX,EAX
        OR      ECX,EDX
        JE      @@cd20
        OR      EDX,EDX
        JNS     @@cd1
        NEG     EDX
        NEG     EAX
        SBB     EDX,0
@@cd1:  XOR     ECX,ECX
        MOV     EDI,Decimals
        OR      EDI,EDI
        JGE     @@cd2
        XOR     EDI,EDI
@@cd2:  CMP     EDI,4
        JL      @@cd4
        MOV     EDI,4
@@cd3:  INC     ECX
        SUB     EAX,Const1E18Lo
        SBB     EDX,Const1E18Hi
        JNC     @@cd3
        DEC     ECX
        ADD     EAX,Const1E18Lo
        ADC     EDX,Const1E18Hi
@@cd4:  MOV     Temp.Integer[0],EAX
        MOV     Temp.Integer[4],EDX
        FILD    Temp
        MOV     EDX,EDI
        MOV     EAX,4
        SUB     EAX,EDX
        JE      @@cd5
        MOV     EDI,SaveGOT
        FIDIV   @@DecimalTable.Integer[EDI+EAX*4-4]
@@cd5:  FBSTP   BCDValue
        LEA     EDI,[EBX].TFloatRec.Digits
        FWAIT
        OR      ECX,ECX
        JNE     @@cd11
        MOV     ECX,9
@@cd10: MOV     AL,BCDValue[ECX-1].Byte
        MOV     AH,AL
        SHR     AL,4
        JNE     @@cd13
        MOV     AL,AH
        AND     AL,0FH
        JNE     @@cd14
        DEC     ECX
        JNE     @@cd10
        JMP     @@cd20
@@cd11: MOV     AL,CL
        ADD     AL,'0'
        STOSB
        MOV     ECX,9
@@cd12: MOV     AL,BCDValue[ECX-1].Byte
        MOV     AH,AL
        SHR     AL,4
@@cd13: ADD     AL,'0'
        STOSB
        MOV     AL,AH
        AND     AL,0FH
@@cd14: ADD     AL,'0'
        STOSB
        DEC     ECX
        JNE     @@cd12
        MOV     EAX,EDI
        LEA     ECX,[EBX].TFloatRec.Digits[EDX]
        SUB     EAX,ECX
@@cd15: MOV     BYTE PTR [EDI],0
        DEC     EDI
        CMP     BYTE PTR [EDI],'0'
        JE      @@cd15
        MOV     EDX,[ESI].Integer[4]
        SHR     EDX,31
        JMP     @@cd21
@@cd20: XOR     EAX,EAX
        XOR     EDX,EDX
        MOV     [EBX].TFloatRec.Digits.Byte[0],AL
@@cd21: MOV     [EBX].TFloatRec.Exponent,AX
        MOV     [EBX].TFloatRec.Negative,DL
        RET

@@Exit:
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

{$IFDEF CPUX86}
function TestAndClearFPUExceptions(AExceptionMask: Word): Boolean;
asm
      PUSH    ECX
      MOV     CX, AX
      FSTSW   AX
      TEST    AX, CX
      JNE     @@bad
      XOR     EAX, EAX
      INC     EAX
      JMP     @@exit
@@bad:
      XOR     EAX, EAX
@@exit:
      POP     ECX
      FCLEX
      RET
end;
{$ENDIF CPUX86}
{$IFDEF CPUX64}
function TestAndClearSSEExceptions(AExceptionMask: UInt32): Boolean;
var
  MXCSR: UInt32;
begin
  MXCSR := GetMXCSR;
  Result := ((MXCSR and $003F) and AExceptionMask) = 0;
  ResetMXCSR;
end;
{$ENDIF CPUX64}

function InternalTextToExtended(
  ABuffer: PChar;
  var AValue: Extended;
  const AFormatSettings: TFormatSettings): Boolean;
const
{$IFDEF EXTENDEDIS10BYTES}
  CMaxExponent = 4999;
{$ELSE !EXTENDEDIS10BYTES}
  CMaxExponent = 1024;
{$ENDIF EXTENDEDIS10BYTES}

  CExponent = 'E'; // DO NOT LOCALIZE;
  CPlus = '+';     // DO NOT LOCALIZE;
  CMinus = '-';    // DO NOT LOCALIZE;

var
{$IFDEF NEXTGEN}
//  SavedRoundMode: Int32;
//  LSavedFlags: Word;
//  LDummyFlags: Word;
{$ELSE !NEXTGEN}
{$IFDEF CPUX86}
  LSavedCtrlWord: Word;
{$ENDIF CPUX86}
{$IFDEF CPUX64}
  LSavedMXCSR: UInt32;
{$ENDIF CPUX64}
{$ENDIF}
  LPower: Integer;
  LSign: SmallInt;
  LResult: Extended;
  LCurrChar: Char;

  procedure NextChar;
  begin
    LCurrChar := PWideChar(ABuffer)^;
    Inc(PWideChar(ABuffer));
  end;

  procedure SkipWhitespace();
  begin
    { Skip white spaces }
    while LCurrChar = ' ' do
      NextChar;
  end;

  function ReadSign(): SmallInt;
  begin
    Result := 1;
    if LCurrChar = CPlus then
      NextChar()
    else if LCurrChar = CMinus then
    begin
      NextChar();
      Result := -1;
    end;
  end;

  function ReadNumber(var AOut: Extended): Integer;
  begin
    Result := 0;
    while LCurrChar.IsDigit do
    begin
      AOut := AOut * 10;
      AOut := AOut + Ord(LCurrChar) - Ord('0');

      NextChar();
      Inc(Result);
    end;
  end;

  function ReadExponent: SmallInt;
  var
    LSign: SmallInt;
  begin
    LSign := ReadSign();
    Result := 0;
    while LCurrChar.IsDigit do
    begin
      Result := Result * 10;
      Result := Result + Ord(LCurrChar) - Ord('0');
      NextChar();
    end;

    if Result > CMaxExponent then
      Result := CMaxExponent;

    Result := Result * LSign;
  end;

begin
  { Prepare }
  Result := False;
  NextChar();

{$IFDEF NEXTGEN}
                                              
//  FEnvGetExceptFlag(LSavedFlags, fe_ALL_EXCEPT);
//  FEnvSetExceptFlag(LSavedFlags, fe_ALL_EXCEPT);
//  SavedRoundMode := FEnvGetRound;
//  FEnvSetRound(fe_TONEAREST);
{$ELSE  NEXTGEN}
{$IFDEF CPUX86}
  { Prepare the FPU }
  LSavedCtrlWord := Get8087CW();
  TestAndClearFPUExceptions(0);
  Set8087CW(CWNear);
{$ENDIF CPUX86}
{$IFDEF CPUX64}
  { Prepare the FPU }
  LSavedMXCSR := GetMXCSR;
  TestAndClearSSEExceptions(0);
  SetMXCSR(MXCSRNear);
{$ENDIF CPUX64}
{$ENDIF NEXTGEN}

  { Skip white spaces }
  SkipWhitespace();

  { Exit if nothing to do }
  if LCurrChar <> #0 then
  begin
    { Detect the sign of the number }
    LSign := ReadSign();
    if LCurrChar <> #0 then
    begin
      { De result }
      LResult := 0;

      { Read the integer and fractionary parts }
      ReadNumber(LResult);
      if LCurrChar = AFormatSettings.DecimalSeparator then
      begin
        NextChar();
        LPower := -ReadNumber(LResult);
      end else
        LPower := 0;

      { Read the exponent and adjust the power }
      if Char(Word(LCurrChar) and $FFDF) = CExponent then
      begin
        NextChar();
        Inc(LPower, ReadExponent());
      end;

      { Skip white spaces }
      SkipWhitespace();

      { Continue only if the buffer is depleted }
      if LCurrChar = #0 then
      begin
        { Calculate the final number }
      {$IFDEF NEXTGEN}
        try
          LResult := Power10(LResult, LPower) * LSign;
          AValue := LResult;
          Result := True;
        except
          Result := False;
        end;
      {$ELSE  NEXTGEN}
        LResult := Power10(LResult, LPower) * LSign;
        AValue := LResult;
      {$ENDIF NEXTGEN}


{$IFDEF NEXTGEN}
                                                        
                                                                                                                   
//        Result := True;
{$ELSE  NEXTGEN}
{$IFDEF CPUX86}
        { Final check that everything went OK }
        Result := TestAndClearFPUExceptions(mIE + mOE);
{$ENDIF CPUX86}
{$IFDEF CPUX64}
        { Final check that everything went OK }
        Result := TestAndClearSSEExceptions(mIE + mOE);
{$ENDIF CPUX64}
{$ENDIF NEXTGEN}
      end;
    end;
  end;

  { Clear Math Exceptions }
{$IFDEF NEXTGEN}
                                       
//  FEnvSetRound(SavedRoundMode);
//  FEnvSetExceptFlag(LDummyFlags, LSavedFlags);
{$ELSE  NEXTGEN}
{$IFDEF CPUX86}
  Set8087CW(LSavedCtrlWord);
{$ENDIF CPUX86}
{$IFDEF CPUX64}
  SetMXCSR(LSavedMXCSR);
{$ENDIF CPUX64}
{$ENDIF NEXTGEN}
end;

function InternalTextToCurrency(
  ABuffer: PChar;
  var AValue: Currency;
  const AFormatSettings: TFormatSettings): Boolean;
{$IFDEF EXTENDEDIS10BYTES}
const
  CMaxExponent = 4999;
  CExponent = 'E'; // DO NOT LOCALIZE;
  CPlus = '+';     // DO NOT LOCALIZE;
  CMinus = '-';    // DO NOT LOCALIZE;
var
{$IFDEF NEXTGEN}
                                              
{$ELSE !NEXTGEN}
{$IFDEF CPUX86}
  LSavedCtrlWord: Word;
{$ENDIF CPUX86}
{$ENDIF NEXTGEN}
  LPower: Integer;
  LSign: SmallInt;
  LResult: Extended;
  LCurrChar: Char;

  procedure NextChar;
  begin
    LCurrChar := ABuffer^;
    Inc(ABuffer);
  end;

  procedure SkipWhitespace();
  begin
    { Skip white spaces }
    while LCurrChar = ' ' do
      NextChar;
  end;

  function ReadSign(): SmallInt;
  begin
    Result := 1;
    if LCurrChar = CPlus then
      NextChar()
    else if LCurrChar = CMinus then
    begin
      NextChar();
      Result := -1;
    end;
  end;

  function ReadNumber(var AOut: Extended): Integer;
  begin
    Result := 0;
    while CharInSet(LCurrChar, ['0'..'9']) do
    begin
      AOut := AOut * 10;
      AOut := AOut + Ord(LCurrChar) - Ord('0');

      NextChar();
      Inc(Result);
    end;
  end;

  function ReadExponent: SmallInt;
  var
    LSign: SmallInt;
  begin
    LSign := ReadSign();
    Result := 0;
    while CharInSet(LCurrChar, ['0'..'9']) do
    begin
      Result := Result * 10;
      Result := Result + Ord(LCurrChar) - Ord('0');
      NextChar();
    end;

    if Result > CMaxExponent then
      Result := CMaxExponent;

    Result := Result * LSign;
  end;

begin
  { Prepare }
  Result := False;
  NextChar();

{$IFDEF NEXTGEN}
                                              
{$ELSE  NEXTGEN}
{$IFDEF CPUX86}
  { Prepare the FPU }
  LSavedCtrlWord := Get8087CW();
  TestAndClearFPUExceptions(0);
  Set8087CW(CWNear);
{$ENDIF CPUX86}
{$ENDIF NEXTGEN}

  { Skip white spaces }
  SkipWhitespace();

  { Exit if nothing to do }
  if LCurrChar <> #0 then
  begin
    { Detect the sign of the number }
    LSign := ReadSign();
    if LCurrChar <> #0 then
    begin
      { De result }
      LResult := 0;

      { Read the integer and fractionary parts }
      ReadNumber(LResult);
      if LCurrChar = AFormatSettings.DecimalSeparator then
      begin
        NextChar();
        LPower := -ReadNumber(LResult);
      end else
        LPower := 0;

      { Read the exponent and adjust the power }
      if Char(Word(LCurrChar) and $FFDF) = CExponent then
      begin
        NextChar();
        Inc(LPower, ReadExponent());
      end;

      { Skip white spaces }
      SkipWhitespace();

      { Continue only if the buffer is depleted }
      if LCurrChar = #0 then
      begin
        { Calculate the final number }
        LResult := Power10(LResult, LPower) * LSign;

        Currency(AValue) := LResult;

{$IFDEF NEXTGEN}
                                                        
                                                                                                                   
        Result := true;
{$ELSE  NEXTGEN}
{$IFDEF CPUX86}
        { Final check that everything went OK }
        Result := TestAndClearFPUExceptions(mIE + mOE);
{$ENDIF CPUX86}
{$ENDIF NEXTGEN}
      end;
    end;
  end;

  { Clear Math Exceptions }
{$IFDEF NEXTGEN}
                                       
{$ELSE  NEXTGEN}
{$IFDEF CPUX86}
  Set8087CW(LSavedCtrlWord);
{$ENDIF CPUX86}
{$ENDIF NEXTGEN}
end;
{$ELSE !EXTENDEDIS10BYTES}
const
  CExponent = 'E'; // DO NOT LOCALIZE;
  CPlus = '+';     // DO NOT LOCALIZE;
  CMinus = '-';    // DO NOT LOCALIZE;
  Int64MaxDiv10 = $CCCCCCCCCCCCCCC;
var
  LPower: Integer;
  LSign: SmallInt;
  LValue: UInt64;
  BufIndex: Integer;

  procedure SkipWhitespace;
  begin
    { Skip white spaces }
    while ABuffer[BufIndex] = ' ' do
      Inc(BufIndex);
  end;

  function ReadSign: SmallInt;
  begin
    Result := 1;
    if ABuffer[BufIndex] = CPlus then
      Inc(BufIndex)
    else if ABuffer[BufIndex] = CMinus then
    begin
      Inc(BufIndex);
      Result := -1;
    end;
  end;

  function ReadNumber(var aValue: UInt64): Integer;
  begin
    Result := 0;
    while ABuffer[BufIndex] in ['0'..'9'] do
    begin
      if aValue >= Int64MaxDiv10 then
      begin
        if aValue > Int64MaxDiv10 then break
        else if ABuffer[BufIndex] > '7' then break
      end;
      aValue := aValue * 10;
      aValue := aValue + Ord(ABuffer[BufIndex]) - Ord('0');
      Inc(Result);
      Inc(BufIndex);
    end;
    // Skip remaining numbers.
    while ABuffer[BufIndex] in ['0'..'9'] do
      Inc(BufIndex);
  end;

  function ReadExponent: Integer;
  var
    LSign: Integer;
  begin
    LSign := ReadSign;
    Result := 0;
    while ABuffer[BufIndex] in ['0'..'9'] do
    begin
      Result := Result * 10;
      Result := Result + Ord(ABuffer[BufIndex]) - Ord('0');
      Inc(BufIndex);
    end;
    Result := Result * LSign;
  end;

begin
  { Prepare }
  BufIndex := 0;
  Result := False;
  { Skip white spaces }
  SkipWhitespace;

  { Exit if nothing to do }
  if ABuffer[BufIndex] <> #0 then
  begin
    { Detect the sign of the number }
    LSign := ReadSign;
    if ABuffer[BufIndex] <> #0 then
    begin
      { De result }
      LValue := 0;

      { Read the integer and fractionary parts }
      ReadNumber(LValue);
      if ABuffer[BufIndex] = AFormatSettings.DecimalSeparator then
      begin
        Inc(BufIndex);
        LPower := -ReadNumber(LValue);
      end else
        LPower := 0;

      { Read the exponent and adjust the power }
      if Char(Word(ABuffer[BufIndex]) and $FFDF) = CExponent then
      begin
        Inc(BufIndex);
        Inc(LPower, ReadExponent);
      end;

      { Skip white spaces }
      SkipWhitespace();

      { Continue only if the buffer is depleted }
      if ABuffer[BufIndex] = #0 then
      begin
        { Calculate the final number }
        LPower := LPower + 4; // Add Currency's offset digit

        while LPower > 0 do
        begin
          if LValue > Int64MaxDiv10 then
            Exit(False); // overflow.
          LValue := LValue * 10;
          Dec(LPower);
        end;
        while LPower < 0 do
        begin
          LValue := LValue div 10;
          Inc(LPower);
        end;

        PUInt64(@AValue)^ := LValue;

        if LSign < 0 then
          AValue := -AValue;

        Result := True;
      end;
    end;
  end;
end;
{$ENDIF EXTENDEDIS10BYTES}

function TextToFloat(Buffer: PWideChar; var Value; ValueType: TFloatValue): Boolean;
begin
  Result := TextToFloat(Buffer, Value, ValueType, FormatSettings);
end;

function TextToFloat(Buffer: PWideChar; var Value;
  ValueType: TFloatValue; const AFormatSettings: TFormatSettings): Boolean;
{$IFDEF PUREPASCAL}
begin
  if ValueType = fvExtended then
    Result := InternalTextToExtended(Buffer, Extended(Value), AFormatSettings)
  else
    Result := InternalTextToCurrency(Buffer, Currency(Value), AFormatSettings);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  Temp: Integer;
  CtrlWord: Word;
  DecimalSep: WideChar;
  SaveGOT: Integer;
  VT: TFloatValue;
asm //StackAligned
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     VT, CL
{$IFDEF PIC}
        CALL    GetGOT
        MOV     SaveGOT,EAX
{$ELSE !PIC}
        MOV     SaveGOT,0
{$ENDIF !PIC}
        MOV     EAX,AFormatSettings
        MOV     AX,[EAX].TFormatSettings.DecimalSeparator
        MOV     DecimalSep,AX
        FSTCW   CtrlWord
        FCLEX
{$IFDEF PIC}
        MOV     EAX, SaveGOT
        FLDCW   [EAX].CWNear
{$ELSE !PIC}
        FLDCW   CWNear
{$ENDIF !PIC}
        FLDZ
        CALL    @@SkipBlanks
        MOV     BX, word ptr [ESI]
        CMP     BX,'+'
        JE      @@1
        CMP     BX,'-'
        JNE     @@2
@@1:    ADD     ESI,2
@@2:    MOV     ECX,ESI
        CALL    @@GetDigitStr
        XOR     EDX,EDX
        MOV     AX,word ptr [ESI]
        CMP     AX,DecimalSep
        JNE     @@3
        ADD     ESI,2
        CALL    @@GetDigitStr
        NEG     EDX
@@3:    CMP     ECX,ESI
        JE      @@9
        MOV     AX,word ptr [ESI]
        AND     AX,0DFH
        CMP     AX,'E'
        JNE     @@4
        ADD     ESI,2
        PUSH    EDX
        CALL    @@GetExponent
        POP     EAX
        ADD     EDX,EAX
@@4:    CALL    @@SkipBlanks
        CMP     WORD PTR [ESI],0
        JNE     @@9
        MOV     EAX,EDX
        CMP     VT,fvCurrency
        JNE     @@5
        ADD     EAX,4
@@5:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 8
{$ENDIF ALIGN_STACK}
        PUSH    EBX
        MOV     EBX,SaveGOT
        CALL    FPower10
        POP     EBX
{$IFDEF ALIGN_STACK}
        ADD     ESP, 8
{$ENDIF ALIGN_STACK}
        CMP     BX,'-'
        JNE     @@6
        FCHS
@@6:    CMP     VT,fvExtended
        JE      @@7
        FISTP   QWORD PTR [EDI]
        JMP     @@8
@@7:    FSTP    TBYTE PTR [EDI]
@@8:    FSTSW   AX
        TEST    AX,mIE+mOE
        JNE     @@10
        MOV     AL,1
        JMP     @@11
@@9:    FSTP    ST(0)
@@10:   XOR     EAX,EAX
@@11:   FCLEX
        FLDCW   CtrlWord
        FWAIT
        JMP     @@Exit

@@SkipBlanks:

@@21:   LODSW
        OR      AX,AX
        JE      @@22
        CMP     AX,' '
        JE      @@21
@@22:   SUB     ESI,2
        RET

// Process string of digits
// Out EDX = Digit count

@@GetDigitStr:

        XOR     EAX,EAX
        XOR     EDX,EDX
@@31:   LODSW
        SUB     AX,'0'+10
        ADD     AX,10
        JNC     @@32
{$IFDEF PIC}
        XCHG    SaveGOT,EBX
        FIMUL   [EBX].DCon10
        XCHG    SaveGOT,EBX
{$ELSE !PIC}
        FIMUL   DCon10
{$ENDIF !PIC}
        MOV     Temp,EAX
        FIADD   Temp
        INC     EDX
        JMP     @@31
@@32:   SUB     ESI,2
        RET

// Get exponent
// Out EDX = Exponent (-4999..4999)

@@GetExponent:

        XOR     EAX,EAX
        XOR     EDX,EDX
        MOV     CX, word ptr [ESI]
        CMP     CX,'+'
        JE      @@41
        CMP     CX,'-'
        JNE     @@42
@@41:   ADD     ESI,2
@@42:   MOV     AX, word ptr [ESI]
        SUB     AX,'0'+10
        ADD     AX,10
        JNC     @@43
        ADD     ESI,2
        IMUL    EDX,10
        ADD     EDX,EAX
        CMP     EDX,500
        JB      @@42
@@43:   CMP     CX,'-'
        JNE     @@44
        NEG     EDX
@@44:   RET

@@Exit:
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

{$IFNDEF NEXTGEN}
function TextToFloat(Buffer: PAnsiChar; var Value; ValueType: TFloatValue): Boolean;
begin
  Result := TextToFloat(Buffer, Value, ValueType, FormatSettings);
end;

function TextToFloat(Buffer: PAnsiChar; var Value;
  ValueType: TFloatValue; const AFormatSettings: TFormatSettings): Boolean;
{$IFDEF PUREPASCAL}
var
  s: string;
begin
  s := string(AnsiString(Buffer));
  if ValueType = fvExtended then
    Result := InternalTextToExtended(PWideChar(s), Extended(Value), AFormatSettings)
  else
    Result := InternalTextToCurrency(PWideChar(s), Currency(Value), AFormatSettings);
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  Temp: Integer;
  CtrlWord: Word;
  DecimalSep: AnsiChar;
  SaveGOT: Integer;
asm //StackAligned
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     ESI,EAX
        MOV     EDI,EDX
{$IFDEF PIC}
        PUSH    ECX
        CALL    GetGOT
        POP     EBX
        MOV     SaveGOT,EAX
{$ELSE !PIC}
        MOV     SaveGOT,0
        MOV     EBX,ECX
{$ENDIF !PIC}
        MOV     EAX,AFormatSettings
        MOV     AL,AnsiChar([EAX].TFormatSettings.DecimalSeparator)
        MOV     DecimalSep,AL
        FSTCW   CtrlWord
        FCLEX
{$IFDEF PIC}
        MOV     EAX, SaveGOT
        FLDCW   [EAX].CWNear
{$ELSE !PIC}
        FLDCW   CWNear
{$ENDIF !PIC}
        FLDZ
        CALL    @@SkipBlanks
        MOV     BH, byte ptr [ESI]
        CMP     BH,'+'
        JE      @@1
        CMP     BH,'-'
        JNE     @@2
@@1:    INC     ESI
@@2:    MOV     ECX,ESI
        CALL    @@GetDigitStr
        XOR     EDX,EDX
        MOV     AL,[ESI]
        CMP     AL,DecimalSep
        JNE     @@3
        INC     ESI
        CALL    @@GetDigitStr
        NEG     EDX
@@3:    CMP     ECX,ESI
        JE      @@9
        MOV     AL, byte ptr [ESI]
        AND     AL,0DFH
        CMP     AL,'E'
        JNE     @@4
        INC     ESI
        PUSH    EDX
        CALL    @@GetExponent
        POP     EAX
        ADD     EDX,EAX
@@4:    CALL    @@SkipBlanks
        CMP     BYTE PTR [ESI],0
        JNE     @@9
        MOV     EAX,EDX
        CMP     BL,fvCurrency
        JNE     @@5
        ADD     EAX,4
@@5:
{$IFDEF ALIGN_STACK}
        SUB     ESP, 12
{$ENDIF ALIGN_STACK}
        PUSH    EBX
        MOV     EBX,SaveGOT
        CALL    FPower10
        POP     EBX
{$IFDEF ALIGN_STACK}
        ADD     ESP, 12
{$ENDIF ALIGN_STACK}
        CMP     BH,'-'
        JNE     @@6
        FCHS
@@6:    CMP     BL,fvExtended
        JE      @@7
        FISTP   QWORD PTR [EDI]
        JMP     @@8
@@7:    FSTP    TBYTE PTR [EDI]
@@8:    FSTSW   AX
        TEST    AX,mIE+mOE
        JNE     @@10
        MOV     AL,1
        JMP     @@11
@@9:    FSTP    ST(0)
@@10:   XOR     EAX,EAX
@@11:   FCLEX
        FLDCW   CtrlWord
        FWAIT
        JMP     @@Exit

@@SkipBlanks:

@@21:   LODSB
        OR      AL,AL
        JE      @@22
        CMP     AL,' '
        JE      @@21
@@22:   DEC     ESI
        RET

// Process string of digits
// Out EDX = Digit count

@@GetDigitStr:

        XOR     EAX,EAX
        XOR     EDX,EDX
@@31:   LODSB
        SUB     AL,'0'+10
        ADD     AL,10
        JNC     @@32
{$IFDEF PIC}
        XCHG    SaveGOT,EBX
        FIMUL   [EBX].DCon10
        XCHG    SaveGOT,EBX
{$ELSE !PIC}
        FIMUL   DCon10
{$ENDIF !PIC}
        MOV     Temp,EAX
        FIADD   Temp
        INC     EDX
        JMP     @@31
@@32:   DEC     ESI
        RET

// Get exponent
// Out EDX = Exponent (-4999..4999)

@@GetExponent:

        XOR     EAX,EAX
        XOR     EDX,EDX
        MOV     CL, byte ptr [ESI]
        CMP     CL,'+'
        JE      @@41
        CMP     CL,'-'
        JNE     @@42
@@41:   INC     ESI
@@42:   MOV     AL, byte ptr [ESI]
        SUB     AL,'0'+10
        ADD     AL,10
        JNC     @@43
        INC     ESI
        IMUL    EDX,10
        ADD     EDX,EAX
        CMP     EDX,500
        JB      @@42
@@43:   CMP     CL,'-'
        JNE     @@44
        NEG     EDX
@@44:   RET

@@Exit:
        POP     EBX
        POP     ESI
        POP     EDI
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
{$ENDIF !NEXTGEN}

function TextToFloat(const S: string; var Value: Extended): Boolean;
begin
  Result := TextToFloat(S, Value, FormatSettings);
end;

function TextToFloat(const S: string; var Value: Extended;
  const AFormatSettings: TFormatSettings): Boolean;
begin
{$IFDEF PUREPASCAL}
  Result := InternalTextToExtended(PWideChar(S), Value, AFormatSettings);
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
  Result := TextToFloat(PWideChar(S), Value, fvExtended, AFormatSettings);
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
end;

function TextToFloat(const S: string; var Value: Double): Boolean;
begin
  Result := TextToFloat(S, Value, FormatSettings);
end;

function TextToFloat(const S: string; var Value: Double;
  const AFormatSettings: TFormatSettings): Boolean;
{$IFDEF PUREPASCAL}
var
  ExtValue: Extended;
begin
  Result := InternalTextToExtended(PWideChar(S), ExtValue, AFormatSettings);
  Value := ExtValue;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
var
  ExtValue: Extended;
begin
  Result := TextToFloat(PWideChar(S), ExtValue, fvExtended, AFormatSettings);
  Value := ExtValue;
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function TextToFloat(const S: string; var Value: Currency): Boolean;
begin
  Result := TextToFloat(S, Value, FormatSettings);
end;

function TextToFloat(const S: string; var Value: Currency;
  const AFormatSettings: TFormatSettings): Boolean;
begin
{$IFDEF PUREPASCAL}
  Result := InternalTextToCurrency(PWideChar(S), Value, AFormatSettings);
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
  Result := TextToFloat(PWideChar(S), Value, fvCurrency, AFormatSettings);
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}
end;

function FloatToStr(Value: Extended): string;
begin
  Result := FloatToStr(Value, FormatSettings);
end;

function FloatToStr(Value: Extended; const AFormatSettings: TFormatSettings): string;
var
  Buffer: array[0..63] of Char;
begin
  SetString(Result, Buffer, FloatToText(Buffer, Value, fvExtended,
    ffGeneral, 15, 0, AFormatSettings));
end;

function CurrToStr(Value: Currency): string;
begin
  Result := CurrToStr(Value, FormatSettings);
end;

function CurrToStr(Value: Currency;
  const AFormatSettings: TFormatSettings): string;
var
  Buffer: array[0..63] of Char;
begin
  SetString(Result, Buffer, FloatToText(Buffer, Value, fvCurrency,
    ffGeneral, 0, 0, AFormatSettings));
end;

function TryFloatToCurr(const Value: Extended; out AResult: Currency): Boolean;
begin
  Result := (Value >= MinCurrency) and (Value <= MaxCurrency);
  if Result then
    AResult := Value;
end;

function FloatToCurr(const Value: Extended): Currency;
begin
  if not TryFloatToCurr(Value, Result) then
    ConvertErrorFmt(@SInvalidCurrency, [FloatToStr(Value)]);
end;

function FloatToStrF(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer): string;
begin
  Result := FloatToStrF(Value, Format, Precision, Digits, FormatSettings);
end;

function FloatToStrF(Value: Extended; Format: TFloatFormat;
  Precision, Digits: Integer; const AFormatSettings: TFormatSettings): string;
var
  Buffer: array[0..63] of Char;
begin
  SetString(Result, Buffer, FloatToText(Buffer, Value, fvExtended,
    Format, Precision, Digits, AFormatSettings));
end;

function CurrToStrF(Value: Currency; Format: TFloatFormat; Digits: Integer): string;
begin
  Result := CurrToStrF(Value, Format, Digits, FormatSettings);
end;

function CurrToStrF(Value: Currency; Format: TFloatFormat;
  Digits: Integer; const AFormatSettings: TFormatSettings): string;
var
  Buffer: array[0..63] of Char;
begin
  SetString(Result, Buffer, FloatToText(Buffer, Value, fvCurrency,
    Format, 0, Digits, AFormatSettings));
end;

function FormatFloat(const Format: string; Value: Extended): string;
begin
  Result := FormatFloat(Format, Value, FormatSettings);
end;

function FormatFloat(const Format: string; Value: Extended;
  const AFormatSettings: TFormatSettings): string;
var
  Buffer: array[0..255] of Char;
begin
  if Length(Format) > Length(Buffer) - 32 then ConvertError(@SFormatTooLong);
  SetString(Result, Buffer, FloatToTextFmt(Buffer, Value, fvExtended,
    PChar(Format), AFormatSettings));
end;

function FormatCurr(const Format: string; Value: Currency): string;
begin
  Result := FormatCurr(Format, Value, FormatSettings);
end;

function FormatCurr(const Format: string; Value: Currency;
  const AFormatSettings: TFormatSettings): string;
var
  Buffer: array[0..255] of Char;
begin
  if Length(Format) > Length(Buffer) - 32 then ConvertError(@SFormatTooLong);
  SetString(Result, Buffer, FloatToTextFmt(Buffer, Value, fvCurrency,
    PChar(Format), AFormatSettings));
end;

function StrToFloat(const S: string): Extended;
begin
  Result := StrToFloat(S, FormatSettings);
end;

function StrToFloat(const S: string;
  const AFormatSettings: TFormatSettings): Extended;
begin
  if not TextToFloat(S, Result, AFormatSettings) then
    ConvertErrorFmt(@SInvalidFloat, [S]);
end;

function StrToFloatDef(const S: string; const Default: Extended): Extended;
begin
  Result := StrToFloatDef(S, Default, FormatSettings);
end;

function StrToFloatDef(const S: string; const Default: Extended;
  const AFormatSettings: TFormatSettings): Extended;
begin
  if not TextToFloat(S, Result, AFormatSettings) then
    Result := Default;
end;

function TryStrToFloat(const S: string; out Value: Extended): Boolean;
begin
  Result := TryStrToFloat(S, Value, FormatSettings);
end;

function TryStrToFloat(const S: string; out Value: Extended;
  const AFormatSettings: TFormatSettings): Boolean;
begin
  Result := TextToFloat(S, Value, AFormatSettings);
end;

function TryStrToFloat(const S: string; out Value: Double): Boolean;
begin
  Result := TryStrToFloat(S, Value, FormatSettings);
end;

function TryStrToFloat(const S: string; out Value: Double;
  const AFormatSettings: TFormatSettings): Boolean;
var
  LValue: Extended;
begin
  Result := TextToFloat(S, LValue, AFormatSettings);
  if Result then
    if (LValue < -MaxDouble) or (LValue > MaxDouble) then
      Result := False;
  if Result then
    Value := LValue;
end;

function TryStrToFloat(const S: string; out Value: Single): Boolean;
begin
  Result := TryStrToFloat(S, Value, FormatSettings);
end;

function TryStrToFloat(const S: string; out Value: Single;
  const AFormatSettings: TFormatSettings): Boolean;
var
  LValue: Extended;
begin
  Result := TextToFloat(S, LValue, AFormatSettings);
  if Result then
    if (LValue < -MaxSingle) or (LValue > MaxSingle) then
      Result := False;
  if Result then
    Value := LValue;
end;

function StrToCurr(const S: string): Currency;
begin
  Result := StrToCurr(S, FormatSettings);
end;

function StrToCurr(const S: string;
  const AFormatSettings: TFormatSettings): Currency;
begin
  if not TextToFloat(S, Result, AFormatSettings) then
    ConvertErrorFmt(@SInvalidFloat, [S]);
end;

function StrToCurrDef(const S: string; const Default: Currency): Currency;
begin
  Result := StrToCurrDef(S, Default, FormatSettings);
end;

function StrToCurrDef(const S: string; const Default: Currency;
  const AFormatSettings: TFormatSettings): Currency;
begin
  if not TextToFloat(S, Result, AFormatSettings) then
    Result := Default;
end;

function TryStrToCurr(const S: string; out Value: Currency): Boolean;
begin
  Result := TryStrToCurr(S, Value, FormatSettings);
end;

function TryStrToCurr(const S: string; out Value: Currency;
  const AFormatSettings: TFormatSettings): Boolean;
begin
  Result := TextToFloat(S, Value, AFormatSettings);
end;

{ Date/time support routines }

const
  FMSecsPerDay: Single = MSecsPerDay;
  IMSecsPerDay: Integer = MSecsPerDay;

function DateTimeToTimeStamp(DateTime: TDateTime): TTimeStamp;
{$IFDEF PUREPASCAL}
var
  LTemp, LTemp2: Int64;
begin
  LTemp := Round(DateTime * FMSecsPerDay);
  LTemp2 := (LTemp div IMSecsPerDay);
  Result.Date := DateDelta + LTemp2;
  Result.Time := Abs(LTemp) mod IMSecsPerDay;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
        PUSH    EBX
{$IFDEF PIC}
        PUSH    EAX
        CALL    GetGOT
        MOV     EBX,EAX
        POP     EAX
{$ELSE !PIC}
        XOR     EBX,EBX
{$ENDIF !PIC}
        MOV     ECX,EAX
        FLD     DateTime
        FMUL    [EBX].FMSecsPerDay
        SUB     ESP,8
        FISTP   QWORD PTR [ESP]
        FWAIT
        POP     EAX
        POP     EDX
        OR      EDX,EDX
        JNS     @@1
        NEG     EDX
        NEG     EAX
        SBB     EDX,0
        DIV     [EBX].IMSecsPerDay
        NEG     EAX
        JMP     @@2
@@1:    DIV     [EBX].IMSecsPerDay
@@2:    ADD     EAX,DateDelta
        MOV     [ECX].TTimeStamp.Time,EDX
        MOV     [ECX].TTimeStamp.Date,EAX
        POP     EBX
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

procedure ValidateTimeStamp(const TimeStamp: TTimeStamp);
begin
  if (TimeStamp.Time < 0) or (TimeStamp.Date <= 0) or
     (TimeStamp.Time >= IMSecsPerDay) then
    ConvertErrorFmt(@SInvalidTimeStamp, [TimeStamp.Date, TimeStamp.Time]);
end;

procedure ValidateMSec(const MSec: Comp);
begin
  if MSec = 0 then
    ConvertErrorFmt(@SInvalidTimeStamp, [0, 0]);
end;

function TimeStampToDateTime(const TimeStamp: TTimeStamp): TDateTime;
{$IFDEF PUREPASCAL}
var
  Temp: Int64;
begin
  ValidateTimeStamp(TimeStamp);
  Temp := TimeStamp.Date;
  Dec(Temp, DateDelta);
  Temp := Temp * IMSecsPerDay;

  if Temp >= 0 then
    Inc(Temp, TimeStamp.Time)
  else
    Dec(Temp, TimeStamp.Time);

  Result := Temp / FMSecsPerDay;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
{$IFDEF ALIGN_STACK}
        SUB    ESP, 4
{$ENDIF ALIGN_STACK}
        PUSH    EBX
{$IFDEF PIC}
        PUSH    EAX
        CALL    GetGOT
        MOV     EBX,EAX
        POP     EAX
{$ELSE !PIC}
        XOR     EBX,EBX
{$ENDIF !PIC}
        PUSH    EAX
        CALL    ValidateTimeStamp
        POP     EAX
        MOV     ECX,[EAX].TTimeStamp.Time
        MOV     EAX,[EAX].TTimeStamp.Date
        SUB     EAX,DateDelta
        IMUL    [EBX].IMSecsPerDay
        OR      EDX,EDX
        JNS     @@1
        SUB     EAX,ECX
        SBB     EDX,0
        JMP     @@2
@@1:    ADD     EAX,ECX
        ADC     EDX,0
@@2:    PUSH    EDX
        PUSH    EAX
        FILD    QWORD PTR [ESP]
        FDIV    [EBX].FMSecsPerDay
        ADD     ESP,8
        POP     EBX
{$IFDEF ALIGN_STACK}
        ADD    ESP, 4
{$ENDIF ALIGN_STACK}
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function MSecsToTimeStamp(MSecs: Comp): TTimeStamp;
{$IFDEF PUREPASCAL}
begin
  ValidateMSec(MSecs);
  { This check is required in order be compatible with ASM version }
  if MSecs < 0 then
    System.Error(reDivByZero);

  Result.Date := PUInt64(@MSecs)^ div IMSecsPerDay;
  Result.Time := PUInt64(@MSecs)^ mod IMSecsPerDay;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
        PUSH    EBX
{$IFDEF PIC}
        PUSH    EAX
        CALL    GetGOT
        MOV     EBX,EAX
        POP     EAX
{$ELSE !PIC}
        XOR     EBX,EBX
{$ENDIF !PIC}
        MOV     ECX,EAX
        MOV     EAX,MSecs.Integer[0]
        PUSH    EAX
        MOV     EAX,MSecs.Integer[4]
        PUSH    EAX
        CALL    ValidateMSec
        MOV     EAX,MSecs.Integer[0]
        MOV     EDX,MSecs.Integer[4]
        DIV     [EBX].IMSecsPerDay
        MOV     [ECX].TTimeStamp.Time,EDX
        MOV     [ECX].TTimeStamp.Date,EAX
        POP     EBX
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function TimeStampToMSecs(const TimeStamp: TTimeStamp): Comp;
{$IFDEF PUREPASCAL}
begin
  ValidateTimeStamp(TimeStamp);

  Result := TimeStamp.Date;
  Result := (Result * FMSecsPerDay) + TimeStamp.Time;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
{$IFDEF ALIGN_STACK}
        SUB    ESP, 4
{$ENDIF ALIGN_STACK}
        PUSH    EBX
{$IFDEF PIC}
        PUSH    EAX
        CALL    GetGOT
        MOV     EBX,EAX
        POP     EAX
{$ELSE !PIC}
        XOR     EBX,EBX
{$ENDIF !PIC}
        PUSH    EAX
        CALL    ValidateTimeStamp
        POP     EAX
        FILD    [EAX].TTimeStamp.Date
        FMUL    [EBX].FMSecsPerDay
        FIADD   [EAX].TTimeStamp.Time
        POP     EBX
{$IFDEF ALIGN_STACK}
        ADD    ESP, 4
{$ENDIF ALIGN_STACK}
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

{ Time encoding and decoding }

function TryEncodeTime(Hour, Min, Sec, MSec: Word; out Time: TDateTime): Boolean;
var
  TS: TTimeStamp;
begin
  Result := False;
  if (Hour < HoursPerDay) and (Min < MinsPerHour) and (Sec < SecsPerMin) and (MSec < MSecsPerSec) then
  begin
    TS.Time :=  (Hour * (MinsPerHour * SecsPerMin * MSecsPerSec))
              + (Min * SecsPerMin * MSecsPerSec)
              + (Sec * MSecsPerSec)
              +  MSec;
    TS.Date := DateDelta; // This is the "zero" day for a TTimeStamp, days between 1/1/0001 and 12/30/1899 including the latter date
    Time := TimeStampToDateTime(TS);
    Result := True;
  end;
end;

function EncodeTime(Hour, Min, Sec, MSec: Word): TDateTime;
begin
  if not TryEncodeTime(Hour, Min, Sec, MSec, Result) then
    ConvertError(@System.SysConst.STimeEncodeError);
end;

procedure DecodeTime(const DateTime: TDateTime; var Hour, Min, Sec, MSec: Word);
var
  MinCount, MSecCount: Word;
begin
  DivMod(DateTimeToTimeStamp(DateTime).Time, SecsPerMin * MSecsPerSec, MinCount, MSecCount);
  DivMod(MinCount, MinsPerHour, Hour, Min);
  DivMod(MSecCount, MSecsPerSec, Sec, MSec);
end;

{ Date encoding and decoding }

function IsLeapYear(Year: Word): Boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function TryEncodeDate(Year, Month, Day: Word; out Date: TDateTime): Boolean;
var
  I: Integer;
  DayTable: PDayTable;
begin
  Result := False;
  DayTable := @MonthDays[IsLeapYear(Year)];
  if (Year >= 1) and (Year <= 9999) and (Month >= 1) and (Month <= 12) and
    (Day >= 1) and (Day <= DayTable^[Month]) then
  begin
    for I := 1 to Month - 1 do Inc(Day, DayTable^[I]);
    I := Year - 1;
    Date := I * 365 + I div 4 - I div 100 + I div 400 + Day - DateDelta;
    Result := True;
  end;
end;

function EncodeDate(Year, Month, Day: Word): TDateTime;
begin
  if not TryEncodeDate(Year, Month, Day, Result) then
    ConvertError(@SDateEncodeError);
end;

function DecodeDateFully(const DateTime: TDateTime; var Year, Month, Day, DOW: Word): Boolean;
const
  D1 = 365;
  D4 = D1 * 4 + 1;
  D100 = D4 * 25 - 1;
  D400 = D100 * 4 + 1;
var
  Y, M, D, I: Word;
  T: Integer;
  DayTable: PDayTable;
begin
  T := DateTimeToTimeStamp(DateTime).Date;
  if T <= 0 then
  begin
    Year := 0;
    Month := 0;
    Day := 0;
    DOW := 0;
    Result := False;
  end else
  begin
    DOW := T mod 7 + 1;
    Dec(T);
    Y := 1;
    while T >= D400 do
    begin
      Dec(T, D400);
      Inc(Y, 400);
    end;
    DivMod(T, D100, I, D);
    if I = 4 then
    begin
      Dec(I);
      Inc(D, D100);
    end;
    Inc(Y, I * 100);
    DivMod(D, D4, I, D);
    Inc(Y, I * 4);
    DivMod(D, D1, I, D);
    if I = 4 then
    begin
      Dec(I);
      Inc(D, D1);
    end;
    Inc(Y, I);
    Result := IsLeapYear(Y);
    DayTable := @MonthDays[Result];
    M := 1;
    while True do
    begin
      I := DayTable^[M];
      if D < I then Break;
      Dec(D, I);
      Inc(M);
    end;
    Year := Y;
    Month := M;
    Day := D + 1;
  end;
end;

procedure DecodeDate(const DateTime: TDateTime; var Year, Month, Day: Word);
var
  Dummy: Word;
begin
  DecodeDateFully(DateTime, Year, Month, Day, Dummy);
end;

{$IFDEF MSWINDOWS}
procedure DateTimeToSystemTime(const DateTime: TDateTime; var SystemTime: TSystemTime);
begin
  DecodeDateFully(DateTime, SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay, SystemTime.wDayOfWeek);
  Dec(SystemTime.wDayOfWeek);
  DecodeTime(DateTime, SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
end;

function SystemTimeToDateTime(const SystemTime: TSystemTime): TDateTime;
begin
  Result := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay);
  if Result >= 0 then
    Result := Result + EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliSeconds)
  else
    Result := Result - EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliSeconds);
end;

function TrySystemTimeToDateTime(const SystemTime: TSystemTime; out DateTime: TDateTime): Boolean;
var
  LDateTime: TDateTime;
begin
  Result := TryEncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay, DateTime);
  if Result then
  begin
    Result := TryEncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliSeconds, LDateTime);
    if DateTime >= 0 then
      DateTime := DateTime + LDateTime
    else
      DateTime := DateTime - LDateTime;
  end;
end;

{$ENDIF MSWINDOWS}

function DayOfWeek(const DateTime: TDateTime): Word;
begin
  Result := DateTimeToTimeStamp(DateTime).Date mod 7 + 1;
end;

function Date: TDateTime;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  UT: tm;
begin
  __time(T);
  localtime_r(T, UT);
  Result := EncodeDate(UT.tm_year + 1900, UT.tm_mon + 1, UT.tm_mday);
end;
{$ENDIF POSIX}

function Time: TDateTime;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliSeconds);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  TV: timeval;
  UT: tm;
begin
  gettimeofday(TV, nil);
  T := TV.tv_sec;
  localtime_r(T, UT);
  Result := EncodeTime(UT.tm_hour, UT.tm_min, UT.tm_sec, TV.tv_usec div 1000);
end;
{$ENDIF POSIX}

function GetTime: TDateTime;
begin
  Result := Time;
end;

function Now: TDateTime;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay) +
    EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  TV: timeval;
  UT: tm;
begin
  gettimeofday(TV, nil);
  T := TV.tv_sec;
  localtime_r(T, UT);
  Result := EncodeDate(UT.tm_year + 1900, UT.tm_mon + 1, UT.tm_mday) +
    EncodeTime(UT.tm_hour, UT.tm_min, UT.tm_sec, TV.tv_usec div 1000);
end;
{$ENDIF POSIX}

function IncMonth(const DateTime: TDateTime; NumberOfMonths: Integer): TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(DateTime, Year, Month, Day);
  IncAMonth(Year, Month, Day, NumberOfMonths);
  Result := EncodeDate(Year, Month, Day);
  ReplaceTime(Result, DateTime);
end;

procedure IncAMonth(var Year, Month, Day: Word; NumberOfMonths: Integer = 1);
var
  DayTable: PDayTable;
  Sign: Integer;
begin
  if NumberOfMonths >= 0 then Sign := 1 else Sign := -1;
  Year := Year + (NumberOfMonths div 12);
  NumberOfMonths := NumberOfMonths mod 12;
  Inc(Month, NumberOfMonths);
  if Word(Month-1) > 11 then    // if Month <= 0, word(Month-1) > 11)
  begin
    Inc(Year, Sign);
    Inc(Month, -12 * Sign);
  end;
  DayTable := @MonthDays[IsLeapYear(Year)];
  if Day > DayTable^[Month] then Day := DayTable^[Month];
end;

procedure ReplaceTime(var DateTime: TDateTime; const NewTime: TDateTime);
begin
  DateTime := Trunc(DateTime);
  if DateTime >= 0 then
    DateTime := DateTime + Abs(Frac(NewTime))
  else
    DateTime := DateTime - Abs(Frac(NewTime));
end;

procedure ReplaceDate(var DateTime: TDateTime; const NewDate: TDateTime);
var
  Temp: TDateTime;
begin
  Temp := NewDate;
  ReplaceTime(Temp, DateTime);
  DateTime := Temp;
end;

function CurrentYear: Word;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := SystemTime.wYear;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  UT: tm;
begin
  __time(T);
  localtime_r(T, UT);
  Result := UT.tm_year + 1900;
end;
{$ENDIF POSIX}

{ Date/time to string conversions }

procedure DateTimeToString(var Result: string; const Format: string;
  DateTime: TDateTime);
begin
  DateTimeToString(Result, Format, DateTime, FormatSettings);
end;

procedure DateTimeToString(var Result: string; const Format: string;
  DateTime: TDateTime; const AFormatSettings: TFormatSettings);
var
  BufPos, AppendLevel: Integer;
  Buffer: array[0..255] of Char;
  DynBuffer: array of Char;
  Sb: TCharArray;

  procedure AppendChars(P: PChar; Count: Integer);
  var
    N, I: Integer;
    begin
    N := SizeOf(Buffer) div SizeOf(Char);
    N := N - BufPos;
    if Count > N then
      begin
      I := Length(DynBuffer);
      SetLength(DynBuffer, I + BufPos + Count);
      if BufPos > 0 then
      begin
        Move(Buffer[0], DynBuffer[I], BufPos * SizeOf(Char));
        Inc(I, BufPos);
      end;
      Move(P[0], DynBuffer[I], Count * SizeOf(Char));
      BufPos := 0;
    end
    else if Count > 0 then
    begin
      Move(P[0], Buffer[BufPos], Count * SizeOf(Char));
      Inc(BufPos, Count);
    end;
  end;

  procedure AppendString(const S: string);
  begin
    AppendChars(Pointer(S), Length(S));
  end;

  procedure AppendNumber(Number, Digits: Integer);
  const
    Format: array[0..3] of Char = '%.*d';
  var
    NumBuf: array[0..15] of Char;
  begin
    AppendChars(NumBuf, FormatBuf(NumBuf, Length(NumBuf), Format,
      Length(Format), [Digits, Number]));
  end;

  procedure AppendFormat(Format: PChar);
  var
    Starter, Token, LastToken: Char;
    DateDecoded, TimeDecoded, Use12HourClock,
    BetweenQuotes: Boolean;
    P: PChar;
    Count: Integer;
    Year, Month, Day, Hour, Min, Sec, MSec, H: Word;

    procedure GetCount;
    var
      P: PChar;
    begin
      P := Format;
      while Format^ = Starter do Inc(Format);
      Count := Format - P + 1;
    end;

    procedure GetDate;
    begin
      if not DateDecoded then
      begin
        DecodeDate(DateTime, Year, Month, Day);
        DateDecoded := True;
      end;
    end;

    procedure GetTime;
    begin
      if not TimeDecoded then
      begin
        DecodeTime(DateTime, Hour, Min, Sec, MSec);
        TimeDecoded := True;
      end;
    end;

{$IFDEF MSWINDOWS}
    function ConvertEraString(const Count: Integer) : string;
    var
      FormatStr: string;
      SystemTime: TSystemTime;
      Buffer: array[Byte] of Char;
      P: PChar;
    begin
      Result := '';
      SystemTime.wYear  := Year;
      SystemTime.wMonth := Month;
      SystemTime.wDay   := Day;

      FormatStr := 'gg';
      if GetDateFormat(GetThreadLocale, DATE_USE_ALT_CALENDAR, @SystemTime,
        PChar(FormatStr), Buffer, SizeOf(Buffer)) <> 0 then
      begin
        Result := Buffer;
        if Count = 1 then
        begin
          case SysLocale.PriLangID of
            LANG_JAPANESE:
              Result := Copy(Result, 1, CharToBytelen(Result, 1));
            LANG_CHINESE:
              if (SysLocale.SubLangID = SUBLANG_CHINESE_TRADITIONAL)
                and (ByteToCharLen(Result, Length(Result)) = 4) then
              begin
                P := Buffer + CharToByteIndex(Result, 3) - 1;
                SetString(Result, P, CharToByteLen(P, 2));
              end;
          end;
        end;
      end;
    end;

    function ConvertYearString(const Count: Integer): string;
    var
      FormatStr: string;
      SystemTime: TSystemTime;
      Buffer: array[Byte] of Char;
    begin
      Result := '';
      SystemTime.wYear  := Year;
      SystemTime.wMonth := Month;
      SystemTime.wDay   := Day;

      if Count <= 2 then
        FormatStr := 'yy' // avoid Win95 bug.
      else
        FormatStr := 'yyyy';

      if GetDateFormat(GetThreadLocale, DATE_USE_ALT_CALENDAR, @SystemTime,
        PChar(FormatStr), Buffer, SizeOf(Buffer)) <> 0 then
      begin
        Result := Buffer;
        if (Count = 1) and (Result[Low(string)] = '0') then
          Result := Copy(Result, 2, Length(Result)-1);
      end;
    end;
{$ENDIF MSWINDOWS}

{$IFDEF POSIX}
    {$IFNDEF MACOS}
    function FindEra(Date: Integer): Byte;
    var
      I : Byte;
    begin
      Result := 0;
      for I := 1 to EraCount do
      begin
        if (EraRanges[I].StartDate <= Date) and
           (EraRanges[I].EndDate >= Date) then
          Exit(I);
      end;
    end;
    {$ENDIF !MACOS}

    function ConvertEraString(const Count: Integer) : String;
    var
      {$IFDEF MACOS}
      Formatter: CFDateFormatterRef;
      LDate: CFGregorianDate;
      LYear, LMonth, LDay: Word;
      FormatString: TCFString;
      DefaultTZ: CFTimeZoneRef;
      Locale: CFLocaleRef;
      {$ELSE !MACOS}
      I : Byte;
      {$ENDIF MACOS}
    begin
      Result := '';
      {$IFDEF MACOS}
      Locale := nil;
      DefaultTZ := nil;
      Formatter := nil;
      FormatString.Value := nil;

      try
        Locale := CFLocaleCopyCurrent;
        DefaultTZ := CFTimeZoneCopyDefault;
        Formatter := CFDateFormatterCreate(kCFAllocatorDefault, Locale,
                        kCFDateFormatterFullStyle, kCFDateFormatterNoStyle);
        FormatString := TCFString.Create('GG');
        CFDateFormatterSetFormat(Formatter, FormatString.Value);
        DecodeDate(DateTime, LYear, LMonth, LDay);
        LDate.year := LYear; LDate.month := ShortInt(LMonth); LDate.day := ShortInt(LDay);
        LDate.hour := 0; LDate.minute := 0; LDate.second := 0;
        Result := TCFString(CFDateFormatterCreateStringWithAbsoluteTime(
                              kCFAllocatorDefault, Formatter,
                              CFGregorianDateGetAbsoluteTime(LDate, DefaultTZ))
                           ).AsString(true);
      finally
        if FormatString.Value <> nil then
          CFRelease(FormatString.Value);
        if Formatter <> nil then
          CFRelease(Formatter);
        if DefaultTZ <> nil then
          CFRelease(DefaultTZ);
        if Locale <> nil then
          CFRelease(Locale);
      end;
      {$ELSE !MACOS}
      I := FindEra(Trunc(DateTime));
      if I > 0 then
        Result := EraNames[I];
      {$ENDIF MACOS}
    end;

    function ConvertYearString(const Count: Integer) : String;
    var
      S : string;
      function GetEraOffset: integer;
      {$IFDEF MACOS}
      var
        StartEra, TargetDate, LengthEra: CFAbsoluteTime;
        LDate: CFGregorianDate;
        LYear, LMonth, LDay: Word;
        Calendar, CurrentCalendar: CFCalendarRef;
        TimeZone: CFTimeZoneRef;
      {$ENDIF MACOS}
      begin
        {$IFDEF MACOS}
        Result := 0;
        TimeZone := nil;
        CurrentCalendar := nil;
        Calendar := nil;
        try
          DecodeDate(DateTime, LYear, LMonth, LDay);
          LDate.year := LYear; LDate.month := ShortInt(LMonth); LDate.day := ShortInt(LDay);
          LDate.hour := 0; LDate.minute := 0; LDate.second := 0;
          TimeZone := CFTimeZoneCopyDefault;
          TargetDate := CFGregorianDateGetAbsoluteTime(LDate, TimeZone);
          CurrentCalendar := CFCalendarCopyCurrent;
          Calendar := CFCalendarCreateWithIdentifier(kCFAllocatorDefault,
                                  CFCalendarGetIdentifier(CurrentCalendar));
          if CFCalendarGetTimeRangeOfUnit(Calendar, kCFCalendarUnitEra,
                                          TargetDate, @StartEra, @LengthEra) then
          begin
            LDate := CFAbsoluteTimeGetGregorianDate(StartEra, TimeZone);
            Result := LDate.Year - 1;
          end;
        finally
          if CurrentCalendar <> nil then
            CFRelease(CurrentCalendar);
          if Calendar <> nil then
            CFRelease(Calendar);
          if TimeZone <> nil then
            CFRelease(TimeZone);
        end;
        {$ELSE !MACOS}
        Result := FindEra(Trunc(DateTime));
        if Result > 0 then
          Result := EraYearOffsets[Result];
        {$ENDIF MACOS}
      end;
    begin
      S := IntToStr(Year - GetEraOffset);
      while Length(S) < Count do
        S := '0' + S;
      if Length(S) > Count then
        S := Copy(S, Length(S) - (Count - 1), Count);
      Result := S;
    end;
{$ENDIF POSIX}

  begin
    if (Format <> nil) and (AppendLevel < 2) then
    begin
      Inc(AppendLevel);
      LastToken := ' ';
      DateDecoded := False;
      TimeDecoded := False;
      Use12HourClock := False;
      while Format^ <> #0 do
      begin
        Starter := Format^;
        if IsLeadChar(Starter) then
        begin
          AppendChars(Format, StrCharLength(Format) div SizeOf(Char));
          Format := StrNextChar(Format);
          LastToken := ' ';
          Continue;
        end;
        Format := StrNextChar(Format);
        Token := Starter;
        if Token in ['a'..'z'] then Dec(Token, 32);
        if Token in ['A'..'Z'] then
        begin
          if (Token = 'M') and (LastToken = 'H') then Token := 'N';
          LastToken := Token;
        end;
        case Token of
          'Y':
            begin
              GetCount;
              GetDate;
              if Count <= 2 then
                AppendNumber(Year mod 100, 2) else
                AppendNumber(Year, 4);
            end;
          'G':
            begin
              GetCount;
              GetDate;
              AppendString(ConvertEraString(Count));
            end;
          'E':
            begin
              GetCount;
              GetDate;
              AppendString(ConvertYearString(Count));
            end;
          'M':
            begin
              GetCount;
              GetDate;
              case Count of
                1, 2: AppendNumber(Month, Count);
                3: AppendString(AFormatSettings.ShortMonthNames[Month]);
              else
                AppendString(AFormatSettings.LongMonthNames[Month]);
              end;
            end;
          'D':
            begin
              GetCount;
              case Count of
                1, 2:
                  begin
                    GetDate;
                    AppendNumber(Day, Count);
                  end;
                3: AppendString(AFormatSettings.ShortDayNames[DayOfWeek(DateTime)]);
                4: AppendString(AFormatSettings.LongDayNames[DayOfWeek(DateTime)]);
                5: AppendFormat(Pointer(AFormatSettings.ShortDateFormat));
              else
                AppendFormat(Pointer(AFormatSettings.LongDateFormat));
              end;
            end;
          'H':
            begin
              GetCount;
              GetTime;
              BetweenQuotes := False;
              P := Format;
              while P^ <> #0 do
              begin
                if IsLeadChar(P^) then
                begin
                  P := StrNextChar(P);
                  Continue;
                end;
                case P^ of
                  'A', 'a':
                    if not BetweenQuotes then
                    begin
                      if ( (StrLIComp(P, 'AM/PM', 5) = 0)
                        or (StrLIComp(P, 'A/P',   3) = 0)
                        or (StrLIComp(P, 'AMPM',  4) = 0) ) then
                        Use12HourClock := True;
                      Break;
                    end;
                  'H', 'h':
                    Break;
                  '''', '"': BetweenQuotes := not BetweenQuotes;
                end;
                Inc(P);
              end;
              H := Hour;
              if Use12HourClock then
                if H = 0 then H := 12 else if H > 12 then Dec(H, 12);
              if Count > 2 then Count := 2;
              AppendNumber(H, Count);
            end;
          'N':
            begin
              GetCount;
              GetTime;
              if Count > 2 then Count := 2;
              AppendNumber(Min, Count);
            end;
          'S':
            begin
              GetCount;
              GetTime;
              if Count > 2 then Count := 2;
              AppendNumber(Sec, Count);
            end;
          'T':
            begin
              GetCount;
              if Count = 1 then
                AppendFormat(Pointer(AFormatSettings.ShortTimeFormat)) else
                AppendFormat(Pointer(AFormatSettings.LongTimeFormat));
            end;
          'Z':
            begin
              GetCount;
              GetTime;
              if Count > 3 then Count := 3;
              AppendNumber(MSec, Count);
            end;
          'A':
            begin
              GetTime;
              P := Format - 1;
              if StrLIComp(P, 'AM/PM', 5) = 0 then
              begin
                if Hour >= 12 then Inc(P, 3);
                AppendChars(P, 2);
                Inc(Format, 4);
                Use12HourClock := TRUE;
              end else
              if StrLIComp(P, 'A/P', 3) = 0 then
              begin
                if Hour >= 12 then Inc(P, 2);
                AppendChars(P, 1);
                Inc(Format, 2);
                Use12HourClock := TRUE;
              end else
              if StrLIComp(P, 'AMPM', 4) = 0 then
              begin
                if Hour < 12 then
                  AppendString(AFormatSettings.TimeAMString) else
                  AppendString(AFormatSettings.TimePMString);
                Inc(Format, 3);
                Use12HourClock := TRUE;
              end else
              if StrLIComp(P, 'AAAA', 4) = 0 then
              begin
                GetDate;
                AppendString(AFormatSettings.LongDayNames[DayOfWeek(DateTime)]);
                Inc(Format, 3);
              end else
              if StrLIComp(P, 'AAA', 3) = 0 then
              begin
                GetDate;
                AppendString(AFormatSettings.ShortDayNames[DayOfWeek(DateTime)]);
                Inc(Format, 2);
              end else
              AppendChars(@Starter, 1);
            end;
          'C':
            begin
              GetCount;
              AppendFormat(Pointer(AFormatSettings.ShortDateFormat));
              GetTime;
              if (Hour <> 0) or (Min <> 0) or (Sec <> 0) or (MSec <> 0) then
              begin
                AppendChars(' ', 1);
                AppendFormat(Pointer(AFormatSettings.LongTimeFormat));
              end;
            end;
          '/':
            if AFormatSettings.DateSeparator <> #0 then
              AppendChars(@AFormatSettings.DateSeparator, 1);
          ':':
            if AFormatSettings.TimeSeparator <> #0 then
              AppendChars(@AFormatSettings.TimeSeparator, 1);
          '''', '"':
            begin
              P := Format;
              while (Format^ <> #0) and (Format^ <> Starter) do
              begin
                if IsLeadChar(Format^) then
                  Format := StrNextChar(Format)
                else
                  Inc(Format);
              end;
              AppendChars(P, Format - P);
              if Format^ <> #0 then Inc(Format);
            end;
        else
          AppendChars(@Starter, 1);
        end;
      end;
      Dec(AppendLevel);
    end;
  end;

begin
  BufPos := 0;
  AppendLevel := 0;
  if Format <> '' then AppendFormat(Pointer(Format)) else AppendFormat('C');
  if Length(DynBuffer) > 0 then
  begin
    SetLength(Sb, Length(DynBuffer) + BufPos);
    Move(DynBuffer[0], Sb[0], Length(DynBuffer) * SizeOf(Char));
    if BufPos > 0 then
      Move(Buffer[0], Sb[Length(DynBuffer)], BufPos * SizeOf(Char));
    Result := String.Create(Sb);
  end
  else
    Result := String.Create(Buffer, 0, BufPos);
end;

function TryFloatToDateTime(const Value: Extended; out AResult: TDateTime): Boolean;
begin
  Result := not ((Value < MinDateTime) or (Value >= Int(MaxDateTime) + 1.0));
  if Result then
    AResult := Value;
end;

function FloatToDateTime(const Value: Extended): TDateTime;
begin
  if not TryFloatToDateTime(Value, Result) then
    ConvertErrorFmt(@SInvalidDateTimeFloat, [Value]);
end;

function DateToStr(const DateTime: TDateTime): string;
begin
  Result := DateToStr(DateTime, FormatSettings);
end;

function DateToStr(const DateTime: TDateTime;
  const AFormatSettings: TFormatSettings): string;
begin
  DateTimeToString(Result, AFormatSettings.ShortDateFormat, DateTime,
    AFormatSettings);
end;

function TimeToStr(const DateTime: TDateTime): string;
begin
  Result := TimeToStr(DateTime, FormatSettings);
end;

function TimeToStr(const DateTime: TDateTime;
  const AFormatSettings: TFormatSettings): string;
begin
  DateTimeToString(Result, AFormatSettings.LongTimeFormat, DateTime,
    AFormatSettings);
end;

function DateTimeToStr(const DateTime: TDateTime): string;
begin
  Result := DateTimeToStr(DateTime, FormatSettings);
end;

function DateTimeToStr(const DateTime: TDateTime;
  const AFormatSettings: TFormatSettings): string;
begin
  DateTimeToString(Result, '', DateTime, AFormatSettings);
end;

function FormatDateTime(const Format: string; DateTime: TDateTime): string;
begin
  Result := FormatDateTime(Format, DateTime, FormatSettings);
end;

function FormatDateTime(const Format: string; DateTime: TDateTime;
  const AFormatSettings: TFormatSettings): string;
begin
  DateTimeToString(Result, Format, DateTime, AFormatSettings);
end;

{ String to date/time conversions }

type
  TDateOrder = (doMDY, doDMY, doYMD);

procedure ScanBlanks(const S: string; var Pos: Integer);
var
  I: Integer;
begin
  I := Pos;
  while (I <= High(S)) and (S[I] = ' ') do Inc(I);
  Pos := I;
end;

function ScanNumber(const S: string; var Pos: Integer;
  var Number: Word; var CharCount: Byte): Boolean;
var
  I: Integer;
  N: Word;
begin
  Result := False;
  CharCount := 0;
  ScanBlanks(S, Pos);
  I := Pos;
  N := 0;
  while (I <= High(S)) and (S[I] in ['0'..'9']) and (N < 1000) do
  begin
    N := N * 10 + (Ord(S[I]) - Ord('0'));
    Inc(I);
  end;
  if I > Pos then
  begin
    CharCount := I - Pos;
    Pos := I;
    Number := N;
    Result := True;
  end;
end;

function ScanString(const S: string; var Pos: Integer;
  const Symbol: string): Boolean;
begin
  Result := False;
  if Symbol <> '' then
  begin
    ScanBlanks(S, Pos);
    if AnsiCompareText(Symbol, S.SubString(Pos - Low(string), Symbol.Length)) = 0 then
    begin
      Inc(Pos, Symbol.Length);
      Result := True;
    end;
  end;
end;

function ScanChar(const S: string; var Pos: Integer; Ch: Char): Boolean;
begin
  Result := False;
  ScanBlanks(S, Pos);
  if (Pos <= High(S)) and (S[Pos] = Ch) then
  begin
    Inc(Pos);
    Result := True;
  end;
end;

function GetDateOrder(const DateFormat: string): TDateOrder;
var
  I: Integer;
begin
  Result := doMDY;
  I := Low(string);
  while I <= High(DateFormat) do
  begin
    case Chr(Ord(DateFormat[I]) and $DF) of
      'E': Result := doYMD;
      'Y': Result := doYMD;
      'M': Result := doMDY;
      'D': Result := doDMY;
    else
      Inc(I);
      Continue;
    end;
    Exit;
  end;
end;

procedure ScanToNumber(const S: string; var Pos: Integer);
begin
  while (Pos <= High(S)) and not (S[Pos] in ['0'..'9']) do
  begin
    if IsLeadChar(S[Pos]) then
      Pos := NextCharIndex(S, Pos)
    else
      Inc(Pos);
  end;
end;

function GetEraYearOffset(const Name: string): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := Low(EraNames) to High(EraNames) do
  begin
    if EraNames[I] = '' then Break;
    if AnsiStrPos(PChar(EraNames[I]), PChar(Name)) <> nil then
    begin
      Result := EraYearOffsets[I];
      Exit;
    end;
  end;
end;

function ScanDate(const S: string; var Pos: Integer; var Date: TDateTime;
  const AFormatSettings: TFormatSettings): Boolean; overload;
var
  DateOrder: TDateOrder;
  N1, N2, N3, Y, M, D: Word;
  L1, L2, L3, YearLen: Byte;
  CenturyBase: Integer;
  EraName : string;
  EraYearOffset: Integer;

  function EraToYear(Year: Integer): Integer;
  begin
{$IFDEF MSWINDOWS}
    if SysLocale.PriLangID = LANG_KOREAN then
    begin
      if Year <= 99 then
        Inc(Year, (CurrentYear + Abs(EraYearOffset)) div 100 * 100);
      if EraYearOffset > 0 then
        EraYearOffset := -EraYearOffset;
    end
    else
      Dec(EraYearOffset);
{$ENDIF MSWINDOWS}
    Result := Year + EraYearOffset;
  end;

begin
  Y := 0;
  M := 0;
  D := 0;
  YearLen := 0;
  Result := False;
  DateOrder := GetDateOrder(AFormatSettings.ShortDateFormat);
  EraYearOffset := 0;
  if AFormatSettings.ShortDateFormat[Low(string)] = 'g' then
  begin
    ScanToNumber(S, Pos);
    EraName := S.SubString(0, Pos-1).Trim;
    EraYearOffset := GetEraYearOffset(EraName);
  end
  else
    if AnsiPos('e', AFormatSettings.ShortDateFormat) > 0 then
      EraYearOffset := EraYearOffsets[1];
  if not (ScanNumber(S, Pos, N1, L1) and ScanChar(S, Pos, AFormatSettings.DateSeparator) and
    ScanNumber(S, Pos, N2, L2)) then Exit;
  if ScanChar(S, Pos, AFormatSettings.DateSeparator) then
  begin
    if not ScanNumber(S, Pos, N3, L3) then Exit;
    case DateOrder of
      doMDY: begin Y := N3; YearLen := L3; M := N1; D := N2; end;
      doDMY: begin Y := N3; YearLen := L3; M := N2; D := N1; end;
      doYMD: begin Y := N1; YearLen := L1; M := N2; D := N3; end;
    end;
    if EraYearOffset > 0 then
      Y := EraToYear(Y)
    else
    if (YearLen <= 2) then
    begin
      CenturyBase := CurrentYear - AFormatSettings.TwoDigitYearCenturyWindow;
      Inc(Y, CenturyBase div 100 * 100);
      if (AFormatSettings.TwoDigitYearCenturyWindow > 0) and (Y < CenturyBase) then
        Inc(Y, 100);
    end;
  end else
  begin
    Y := CurrentYear;
    if DateOrder = doDMY then
    begin
      D := N1; M := N2;
    end else
    begin
      M := N1; D := N2;
    end;
  end;
  ScanChar(S, Pos, AFormatSettings.DateSeparator);
  ScanBlanks(S, Pos);
  if SysLocale.FarEast and (AFormatSettings.ShortDateFormat.Contains('dddd')) then // (System.Pos('ddd', AFormatSettings.ShortDateFormat) <> 0) then
  begin     // ignore trailing text
    if AFormatSettings.ShortTimeFormat[Low(string)] in ['0'..'9'] then  // stop at time digit
      ScanToNumber(S, Pos)
    else  // stop at time prefix
      repeat
        while (Pos <= High(S)) and (S[Pos] <> ' ') do Inc(Pos);
        ScanBlanks(S, Pos);
      until (Pos > High(S)) or
        (AnsiCompareText(AFormatSettings.TimeAMString, S.SubString(Pos - Low(string),
         AFormatSettings.TimeAMString.Length)) = 0) or
        (AnsiCompareText(AFormatSettings.TimePMString,
         S.SubString(Pos - Low(string), AFormatSettings.TimePMString.Length)) = 0);
  end;
  Result := TryEncodeDate(Y, M, D, Date);
end;

function ScanTime(const S: string; var Pos: Integer; var Time: TDateTime;
  const AFormatSettings: TFormatSettings): Boolean; overload;
var
  BaseHour: Integer;
  Hour, Min, Sec, MSec: Word;
  Junk: Byte;
begin
  Result := False;
  BaseHour := -1;
  if ScanString(S, Pos, AFormatSettings.TimeAMString) or ScanString(S, Pos, 'AM') then
    BaseHour := 0
  else if ScanString(S, Pos, AFormatSettings.TimePMString) or ScanString(S, Pos, 'PM') then
    BaseHour := 12;
  if BaseHour >= 0 then ScanBlanks(S, Pos);
  if not ScanNumber(S, Pos, Hour, Junk) then Exit;
  Min := 0;
  Sec := 0;
  MSec := 0;
  if ScanChar(S, Pos, AFormatSettings.TimeSeparator) then
  begin
    if not ScanNumber(S, Pos, Min, Junk) then Exit;
    if ScanChar(S, Pos, AFormatSettings.TimeSeparator) then
    begin
      if not ScanNumber(S, Pos, Sec, Junk) then Exit;
      if ScanChar(S, Pos, AFormatSettings.DecimalSeparator) then
        if not ScanNumber(S, Pos, MSec, Junk) then Exit;
    end;
  end;
  if BaseHour < 0 then
    if ScanString(S, Pos, AFormatSettings.TimeAMString) or ScanString(S, Pos, 'AM') then
      BaseHour := 0
    else
      if ScanString(S, Pos, AFormatSettings.TimePMString) or ScanString(S, Pos, 'PM') then
        BaseHour := 12;
  if BaseHour >= 0 then
  begin
    if (Hour = 0) or (Hour > 12) then Exit;
    if Hour = 12 then Hour := 0;
    Inc(Hour, BaseHour);
  end;
  ScanBlanks(S, Pos);
  Result := TryEncodeTime(Hour, Min, Sec, MSec, Time);
end;

function StrToDate(const S: string): TDateTime;
begin
  Result := StrToDate(S, FormatSettings);
end;

function StrToDate(const S: string;
  const AFormatSettings: TFormatSettings): TDateTime;
begin
  if not TryStrToDate(S, Result, AFormatSettings) then
    ConvertErrorFmt(@System.SysConst.SInvalidDate, [S]);
end;

function StrToDateDef(const S: string; const Default: TDateTime): TDateTime;
begin
  Result := StrToDateDef(S, Default, FormatSettings);
end;

function StrToDateDef(const S: string; const Default: TDateTime;
  const AFormatSettings: TFormatSettings): TDateTime;
begin
  if not TryStrToDate(S, Result, AFormatSettings) then
    Result := Default;
end;

function TryStrToDate(const S: string; out Value: TDateTime): Boolean;
begin
  Result := TryStrToDate(S, Value, FormatSettings);
end;

function TryStrToDate(const S: string; out Value: TDateTime;
  const AFormatSettings: TFormatSettings): Boolean;
var
  Pos: Integer;
begin
  Pos := Low(string);
  Result := ScanDate(S, Pos, Value, AFormatSettings) and (Pos > High(S));
end;

function StrToTime(const S: string): TDateTime;
begin
  Result := StrToTime(S, FormatSettings);
end;

function StrToTime(const S: string;
  const AFormatSettings: TFormatSettings): TDateTime;
begin
  if not TryStrToTime(S, Result, AFormatSettings) then
    ConvertErrorFmt(@System.SysConst.SInvalidTime, [S]);
end;

function StrToTimeDef(const S: string; const Default: TDateTime): TDateTime;
begin
  Result := StrToTimeDef(S, Default, FormatSettings);
end;

function StrToTimeDef(const S: string; const Default: TDateTime;
  const AFormatSettings: TFormatSettings): TDateTime;
begin
  if not TryStrToTime(S, Result, AFormatSettings) then
    Result := Default;
end;

function TryStrToTime(const S: string; out Value: TDateTime): Boolean;
begin
  Result := TryStrToTime(S, Value, FormatSettings);
end;

function TryStrToTime(const S: string; out Value: TDateTime;
  const AFormatSettings: TFormatSettings): Boolean;
var
  Pos: Integer;
begin
  Pos := Low(string);
  Result := ScanTime(S, Pos, Value, AFormatSettings) and (Pos > High(S));
end;

function StrToDateTime(const S: string): TDateTime;
begin
  Result := StrToDateTime(S, FormatSettings);
end;

function StrToDateTime(const S: string;
  const AFormatSettings: TFormatSettings): TDateTime;
begin
  if not TryStrToDateTime(S, Result, AFormatSettings) then
    ConvertErrorFmt(@System.SysConst.SInvalidDateTime, [S]);
end;

function StrToDateTimeDef(const S: string; const Default: TDateTime): TDateTime;
begin
  Result := StrToDateTimeDef(S, Default, FormatSettings);
end;

function StrToDateTimeDef(const S: string; const Default: TDateTime;
  const AFormatSettings: TFormatSettings): TDateTime;
begin
  if not TryStrToDateTime(S, Result, AFormatSettings) then
    Result := Default;
end;

function TryStrToDateTime(const S: string; out Value: TDateTime): Boolean;
begin
  Result := TryStrToDateTime(S, Value, FormatSettings);
end;

function TryStrToDateTime(const S: string; out Value: TDateTime;
  const AFormatSettings: TFormatSettings): Boolean;
var
  Pos: Integer;
  NumberPos: Integer;
  BlankPos, OrigBlankPos: Integer;
  LDate, LTime: TDateTime;
  Stop: Boolean;
begin
  Result := True;
  Pos := Low(string);
  LTime := 0;

  // jump over all the non-numeric characters before the date data
  ScanToNumber(S, Pos);

  // date data scanned; searched for the time data
  if ScanDate(S, Pos, LDate, AFormatSettings) then
  begin
    // search for time data; search for the first number in the time data
    NumberPos := Pos;
    ScanToNumber(S, NumberPos);

    // the first number of the time data was found
    if NumberPos < High(S) then
    begin
      // search between the end of date and the start of time for AM and PM
      // strings; if found, then ScanTime from this position where it is found
      BlankPos := Pos - 1;
      Stop := False;
      while (not Stop) and (BlankPos < NumberPos) do
      begin
        // blank was found; scan for AM/PM strings that may follow the blank
        if (BlankPos > 0) and (BlankPos < NumberPos) then
        begin
          Inc(BlankPos); // start after the blank
          OrigBlankPos := BlankPos; // keep BlankPos because ScanString modifies it
          Stop := ScanString(S, BlankPos, AFormatSettings.TimeAMString) or
                  ScanString(S, BlankPos, 'AM') or
                  ScanString(S, BlankPos, AFormatSettings.TimePMString) or
                  ScanString(S, BlankPos, 'PM');

          // ScanString jumps over the AM/PM string; if found, then it is needed
          // by ScanTime to correctly scan the time
          BlankPos := OrigBlankPos;
        end
        // no more blanks found; end the loop
        else
          Stop := True;

        // search of the next blank if no AM/PM string has been found
        if not Stop then
        begin
          while (S[BlankPos] <> ' ') and (BlankPos <= High(S)) do
            Inc(BlankPos);
          if BlankPos > High(S) then
            BlankPos := 0;
        end;
      end;

      // loop was forcely stopped; check if AM/PM has been found
      if Stop then
        // AM/PM has been found; check if it is before or after the time data
        if BlankPos > 0 then
          if BlankPos < NumberPos then // AM/PM is before the time number
            Pos := BlankPos
          else
            Pos := NumberPos // AM/PM is after the time number
        else
          Pos := NumberPos
      // the blank found is after the the first number in time data
      else
        Pos := NumberPos;

      // get the time data
      Result := ScanTime(S, Pos, LTime, AFormatSettings);

      // time data scanned with no errors
      if Result then
        if LDate >= 0 then
          Value := LDate + LTime
        else
          Value := LDate - LTime;
    end
    // no time data; return only date data
    else
      Value := LDate;
  end
  // could not scan date data; try to scan time data
  else
    Result := TryStrToTime(S, Value, AFormatSettings)
end;

{ System error messages }

function SysErrorMessage(ErrorCode: Cardinal): string;
{$IFDEF MSWINDOWS}
var
  Buffer: PChar;
  Len: Integer;
begin
  { Obtain the formatted message for the given Win32 ErrorCode
    Let the OS initialize the Buffer variable. Need to LocalFree it afterward.
  }
  Len := FormatMessage(
    FORMAT_MESSAGE_FROM_SYSTEM or
    FORMAT_MESSAGE_IGNORE_INSERTS or
    FORMAT_MESSAGE_ARGUMENT_ARRAY or
    FORMAT_MESSAGE_ALLOCATE_BUFFER, nil, ErrorCode, 0, @Buffer, 0, nil);

  try
    { Remove the undesired line breaks and '.' char }
    while (Len > 0) and (CharInSet(Buffer[Len - 1], [#0..#32, '.'])) do Dec(Len);
    { Convert to Delphi string }
    SetString(Result, Buffer, Len);
  finally
    { Free the OS allocated memory block }
    LocalFree(HLOCAL(Buffer));
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  Buffer: TBytes;
begin
  Setlength(Buffer, 256);
  if strerror_r(ErrorCode, MarshaledAString(Buffer), Length(Buffer)) = 0 then
    Result := UTF8Decode(MarshaledAString(Buffer))
  else
    Result := Format('System error: %4x',[ErrorCode]);
end;
{$ENDIF POSIX}

{ Initialization file support }

function GetLocaleStr(Locale, LocaleType: Integer; const Default: string): string;
{$IFDEF MSWINDOWS}
var
  L: Integer;
  Buffer: array[0..255] of Char;
begin
  L := GetLocaleInfo(Locale, LocaleType, Buffer, Length(Buffer));
  if L > 0 then SetString(Result, Buffer, L - 1) else Result := Default;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := Default;
end;
{$ENDIF POSIX}

function GetLocaleChar(Locale, LocaleType: Integer; Default: Char): Char;
{$IFDEF MSWINDOWS}
var
  Buffer: array[0..1] of Char;
begin
  if GetLocaleInfo(Locale, LocaleType, Buffer, 2) > 0 then
    Result := Buffer[0] else
    Result := Default;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := Default;
end;
{$ENDIF POSIX}

{$IFDEF POSIX}
function localeconv_internal(Locale: locale_t): PLConv;
begin
  if Locale <> nil then
    Result := localeconv_l(Locale)
  else
    Result := localeconv;
end;

function nl_langinfo_internal(Item: nl_item; Locale: locale_t): MarshaledAString;
begin
  if Locale <> nil then
    Result := nl_langinfo_l(Item, Locale)
  else
    Result := nl_langinfo(Item);
end;
{$ENDIF POSIX}

var
  DefShortMonthNames: array[1..12] of Pointer = (@SShortMonthNameJan,
    @SShortMonthNameFeb, @SShortMonthNameMar, @SShortMonthNameApr,
    @SShortMonthNameMay, @SShortMonthNameJun, @SShortMonthNameJul,
    @SShortMonthNameAug, @SShortMonthNameSep, @SShortMonthNameOct,
    @SShortMonthNameNov, @SShortMonthNameDec);

  DefLongMonthNames: array[1..12] of Pointer = (@SLongMonthNameJan,
    @SLongMonthNameFeb, @SLongMonthNameMar, @SLongMonthNameApr,
    @SLongMonthNameMay, @SLongMonthNameJun, @SLongMonthNameJul,
    @SLongMonthNameAug, @SLongMonthNameSep, @SLongMonthNameOct,
    @SLongMonthNameNov, @SLongMonthNameDec);

  DefShortDayNames: array[1..7] of Pointer = (@SShortDayNameSun,
    @SShortDayNameMon, @SShortDayNameTue, @SShortDayNameWed,
    @SShortDayNameThu, @SShortDayNameFri, @SShortDayNameSat);

  DefLongDayNames: array[1..7] of Pointer = (@SLongDayNameSun,
    @SLongDayNameMon, @SLongDayNameTue, @SLongDayNameWed,
    @SLongDayNameThu, @SLongDayNameFri, @SLongDayNameSat);

{$IFDEF MACOS}
const
  LOCALE_SHORTDATE = 0;
  LOCALE_LONGDATE  = 1;
  LOCALE_SHORTTIME = 2;
  LOCALE_LONGTIME  = 3;
{$ENDIF MACOS}

{ TFormatSettings }

class function TFormatSettings.Create(Locale: TLocaleID): TFormatSettings;
{$IFDEF MSWINDOWS}
var
  HourFormat, TimePrefix, TimePostfix: string;
begin
  if not IsValidLocale(Locale, LCID_INSTALLED) then
    Locale := GetThreadLocale;

  GetDayNames(Locale, Result);
  GetMonthNames(Locale, Result);
  Result.CurrencyString := GetLocaleStr(Locale, LOCALE_SCURRENCY, '');
  Result.CurrencyFormat := StrToIntDef(GetLocaleStr(Locale, LOCALE_ICURRENCY, '0'), 0);
  Result.NegCurrFormat := StrToIntDef(GetLocaleStr(Locale, LOCALE_INEGCURR, '0'), 0);
  Result.ThousandSeparator := GetLocaleChar(Locale, LOCALE_STHOUSAND, ',');
  Result.DecimalSeparator := GetLocaleChar(Locale, LOCALE_SDECIMAL, '.');
  Result.CurrencyDecimals := StrToIntDef(GetLocaleStr(Locale, LOCALE_ICURRDIGITS, '0'), 0);
  Result.DateSeparator := GetLocaleChar(Locale, LOCALE_SDATE, '/');
  Result.ShortDateFormat := TranslateDateFormat(Locale, LOCALE_SSHORTDATE, 'm/d/yy', Result.DateSeparator);
  Result.LongDateFormat := TranslateDateFormat(Locale, LOCALE_SLONGDATE, 'mmmm d, yyyy', Result.DateSeparator);
  Result.TimeSeparator := GetLocaleChar(Locale, LOCALE_STIME, ':');
  Result.TimeAMString := GetLocaleStr(Locale, LOCALE_S1159, 'am');
  Result.TimePMString := GetLocaleStr(Locale, LOCALE_S2359, 'pm');
  TimePrefix := '';
  TimePostfix := '';
  if StrToIntDef(GetLocaleStr(Locale, LOCALE_ITLZERO, '0'), 0) = 0 then
    HourFormat := 'h'
  else
    HourFormat := 'hh';
  if StrToIntDef(GetLocaleStr(Locale, LOCALE_ITIME, '0'), 0) = 0 then
    if StrToIntDef(GetLocaleStr(Locale, LOCALE_ITIMEMARKPOSN, '0'), 0) = 0 then
      TimePostfix := ' AMPM'
    else
      TimePrefix := 'AMPM ';
  Result.ShortTimeFormat := TimePrefix + HourFormat + ':mm' + TimePostfix;
  Result.LongTimeFormat := TimePrefix + HourFormat + ':mm:ss' + TimePostfix;
  Result.ListSeparator := GetLocaleChar(Locale, LOCALE_SLIST, ',');
  Result.TwoDigitYearCenturyWindow := CDefaultTwoDigitYearCenturyWindow;
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}

  procedure GetCurrencyFormats(Formatter: CFNumberFormatterRef;
    var PosFormat, NegFormat: Byte);

    function IsSpace(Ch: Char): Boolean; inline;
    begin
      Result := (Ch = #32) or (Ch = #$00A0); // Unicode non-breaking space
    end;

    function IsSign(Ch: Char): Boolean; inline;
    begin
      Result := (Ch = '-') or (Ch = #$2212); // Unicode minus sign
    end;

  const
    CPosFormats: array[Boolean, Boolean, Boolean] of Byte =
      (((0, 2), (255, 255)), ((1, 255), (3, 255)));   // 255 = unused
    CNegFormatsLeadParen: array[Boolean, Boolean, Boolean] of Byte =
      (((0, 14), (255, 255)), ((4, 255), (15, 255))); // 255 = unused
    CNegFormatsLeadMinus: array[Boolean, Boolean, Boolean] of Byte =
      (((1, 9), (255, 255)), ((5, 255), (8, 255)));   // 255 = unused
    CNegFormatsLeadCurrSym: array[Boolean, Boolean, Boolean] of Byte =
      (((3, 11), (255, 255)), ((2, 255), (12, 255))); // 255 = unused
    CNegFormatsLeadValue: array[Boolean, Boolean, Boolean] of Byte =
      (((7, 10), (255, 255)), ((6, 255), (13, 255))); // 255 = unused
  var
    NegPrefixLen, NegSuffixLen: Integer;
    PosPrefix, PosSuffix, NegPrefix, NegSuffix: string;
  begin
    PosPrefix := TCFString(CFNumberFormatterCopyProperty(Formatter,
      kCFNumberFormatterPositivePrefix)).AsString(True);
    PosSuffix := TCFString(CFNumberFormatterCopyProperty(Formatter,
      kCFNumberFormatterPositiveSuffix)).AsString(True);
    NegPrefix := TCFString(CFNumberFormatterCopyProperty(Formatter,
      kCFNumberFormatterNegativePrefix)).AsString(True);
    NegSuffix := TCFString(CFNumberFormatterCopyProperty(Formatter,
      kCFNumberFormatterNegativeSuffix)).AsString(True);

    // Convert the positive currency format from prefix + suffix into one
    // of the following Delphi currency formats:
    //
    //  0 = '$1'        1 = '1$'        2 = '$ 1'        3 = '1 $'
    //
    PosFormat := CPosFormats[PosPrefix = '', (Length(PosSuffix)> 0) and IsSpace(PosSuffix[Low(string)]),
      (Length(PosPrefix)> 0) and (IsSpace(PosPrefix[High(PosPrefix)]))];

    // Convert the negative currency format from prefix + suffix into one
    // of the following Delphi negative currency formats:
    //
    //  0 = '($1)'      4 = '(1$)'      8 = '-1 $'      12 = '$ -1'
    //  1 = '-$1'       5 = '-1$'       9 = '-$ 1'      13 = '1- $'
    //  2 = '$-1'       6 = '1-$'      10 = '1 $-'      14 = '($ 1)'
    //  3 = '$1-'       7 = '1$-'      11 = '$ 1-'      15 = '(1 $)' }
    //
    NegPrefixLen := Length(NegPrefix);
    NegSuffixLen := Length(NegSuffix);
    if (NegPrefixLen > 0) and (NegPrefix[Low(string)] = '(') then
      // Parenthesis style (format 0, 4, 14 or 15)
      NegFormat := CNegFormatsLeadParen[NegPrefixLen = 1,
        (NegSuffixLen > 0) and IsSpace(NegSuffix[Low(string)]), IsSpace(NegPrefix[High(NegPrefix)])]
    else if (NegPrefixLen > 0) then
    begin
      if IsSign(NegPrefix[Low(string)]) then
        // Leading sign (format 1, 5, 8 or 9)
        NegFormat := CNegFormatsLeadMinus[NegPrefixLen = 1,
          (NegSuffixLen > 0) and IsSpace(NegSuffix[Low(string)]), IsSpace(NegPrefix[High(NegPrefix)])]
      else
        // Leading currency string (format 2, 3, 11 or 12)
        NegFormat := CNegFormatsLeadCurrSym[NegSuffixLen = 0,
          IsSign(NegPrefix[High(NegPrefix)]) and IsSpace(NegPrefix[High(NegPrefix) - 1]),
          IsSpace(NegPrefix[High(NegPrefix)])];
    end
    else
      // Leading value (format 6, 7, 10 or 13)
      NegFormat := CNegFormatsLeadValue[IsSign(NegSuffix[Low(string)]),
        (NegSuffixLen > 1) and IsSpace(NegSuffix[Low(string) + 1]), IsSpace(NegSuffix[Low(string)])];
  end;

  procedure GetSeparator(const S: string; var Separator: Char; Default: Char);
  var
    P: PChar;
    Last: Char;
  begin
    P := PChar(S);
    Last := P^; 
    if P <> nil then
    begin
      while (P^ <> #0) and ((P^ = S[Low(string)]) or (P^.IsLetter) or ((P^ = '.') and ((Last = 'g') or (Last = 'G')))) do
      begin
        if (P^ = '.') and ((Last = 'g') or (Last = 'G')) then
          P^ := ' ';
        Last := P^;
        Inc(P);
      end
    end;
    if P <> nil then
      Separator := P^
    else
      Separator := Default;
  end;

  procedure AdjustSeparator(var Format: string; Separator, NewSeparator: Char);
  var
    P: PChar;
  begin
    P := PChar(Format);
    if P = nil then
      Exit;

    while P^ <> #0 do
  begin
      if P^ = Separator then
        P^ := NewSeparator;
      Inc(P);
    end;
  end;

var
  LLocale: TLocaleID;
  LDigits: CFNumberRef;
  DateFormatter: CFDateFormatterRef;
  NumberFormatter: CFNumberFormatterRef;
begin
  if Locale <> nil then
    LLocale := Locale
  else
    LLocale := CFLocaleCopyCurrent;

  try
    DateFormatter := CFDateFormatterCreate(kCFAllocatorDefault, LLocale,
      kCFDateFormatterShortStyle, kCFDateFormatterShortStyle);
    try
      GetDayNames(DateFormatter, Result);
      GetMonthNames(DateFormatter, Result);
      Result.CurrencyString := TCFString(CFLocaleGetValue(LLocale, kCFLocaleCurrencySymbol)).AsString;
      Result.ThousandSeparator := TCFString(CFLocaleGetValue(LLocale, kCFLocaleGroupingSeparator)).AsChar;
      Result.DecimalSeparator := TCFString(CFLocaleGetValue(LLocale, kCFLocaleDecimalSeparator)).AsChar;

      Result.ShortDateFormat := TranslateDateFormat(LLocale, LOCALE_SHORTDATE, 'm/d/y', #0); // Do not localize
      Result.LongDateFormat := TranslateDateFormat(LLocale, LOCALE_LONGDATE, Result.ShortDateFormat, #0);
      Result.ShortTimeFormat := TranslateDateFormat(LLocale, LOCALE_SHORTTIME, 'h:nn AMPM', #0); // Do not localize
      Result.LongTimeFormat := TranslateDateFormat(LLocale, LOCALE_LONGTIME, Result.ShortTimeFormat, #0);

      GetSeparator(Result.ShortDateFormat, Result.DateSeparator, '/'); // Do not localize
      GetSeparator(Result.ShortTimeFormat, Result.TimeSeparator, ':'); // Do not localize

      AdjustSeparator(Result.ShortTimeFormat, Result.DateSeparator, ':'); // Do not localize
      AdjustSeparator(Result.LongTimeFormat, Result.DateSeparator, ':'); // Do not localize

      Result.TimeAMString := TCFString(CFDateFormatterCopyProperty(DateFormatter,
        kCFDateFormatterAMSymbol)).AsString(True);
      Result.TimePMString := TCFString(CFDateFormatterCopyProperty(DateFormatter,
        kCFDateFormatterPMSymbol)).AsString(True);

      NumberFormatter := CFNumberFormatterCreate(kCFAllocatorDefault, LLocale,
        kCFNumberFormatterCurrencyStyle);
      try
        GetCurrencyFormats(NumberFormatter, Result.CurrencyFormat, Result.NegCurrFormat);
        LDigits := CFNumberRef(CFNumberFormatterCopyProperty(NumberFormatter,
          kCFNumberFormatterMinFractionDigits));
        try
          if not CFNumberGetValue(LDigits, kCFNumberSInt8Type, @Result.CurrencyDecimals) then
            Result.CurrencyDecimals := 2;
        finally
          CFRelease(LDigits);
        end;
      finally
        CFRelease(NumberFormatter);
      end;

      Result.TwoDigitYearCenturyWindow := CDefaultTwoDigitYearCenturyWindow;
      Result.ListSeparator := ',';
    finally
      CFRelease(DateFormatter);
    end;
  finally
    if Locale = nil then
      CFRelease(LLocale);
  end;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
const
  // first boolean is p_cs_precedes, second is p_sep_by_space
  // CurrencyFormats: array[boolean, boolean] of byte = ((1, 3),(0, 2));
  CurrencyFormats: array[#0..#1, #0..#1] of byte = ((1, 3),(0, 2));
  // first boolean is n_cs_precedes, second is n_sep_by_space and finally n_sign_posn
  // NegCurrFormats: array[boolean, boolean, 0..4] of byte =
  NegCurrFormats: array[#0..#1, #0..#1, #0..#4] of byte =
    (((4,5,7,6,7),(15,8,10,13,10)),((0,1,3,1,2),(14,9,11,9,12)));

  function GetFirstCharacter(const SrcString, Match: string): Char;
  var
    I, P: Integer;
  begin
    Result := Match[Low(string)];
    for I := Low(string) to High(SrcString) do
    begin
      P := Match.IndexOf(SrcString[I]);
      if P >= 0 then
      begin
        Result := Match.Chars[P];
        Break;
      end;
    end;
  end;

var
  P: PLConv;
begin
  GetDayNames(Locale, Result);
  GetMonthNames(Locale, Result);
  Result.CurrencyString := '';
  Result.CurrencyFormat := 0;
  Result.NegCurrFormat := 0;
  Result.ThousandSeparator := ',';
  Result.DecimalSeparator := '.';
  Result.CurrencyDecimals := 0;
  Result.TwoDigitYearCenturyWindow := CDefaultTwoDigitYearCenturyWindow;

  P := localeconv_internal(Locale);
  if P <> nil then
  begin
    if P^.currency_symbol <> nil then
      Result.CurrencyString := string(P^.currency_symbol);

    if (Byte(P^.p_cs_precedes) in [0..1]) and
       (Byte(P^.p_sep_by_space) in [0..1]) then
    begin
      Result.CurrencyFormat := CurrencyFormats[P^.p_cs_precedes, P^.p_sep_by_space];
      if Byte(P^.p_sign_posn) in [0..4] then
        Result.NegCurrFormat := NegCurrFormats[P^.n_cs_precedes, P^.n_sep_by_space,
          P^.n_sign_posn];
    end;

    // #0 is valid for ThousandSeparator.  Indicates no thousand separator.
    Result.ThousandSeparator := Char(AnsiChar(P^.thousands_sep^));

    // #0 is not valid for DecimalSeparator.
    if P^.decimal_point <> #0 then
      Result.DecimalSeparator := Char(AnsiChar(P^.decimal_point^));
    Result.CurrencyDecimals := Byte(P^.frac_digits);
  end;

  // DateSeparator param for TranslateDateFormat is unused for LINUX
  Result.ShortDateFormat := TranslateDateFormat(Locale, D_FMT, 'm/d/yy', #0); // Do not localize
  Result.LongDateFormat := TranslateDateFormat(Locale, D_T_FMT, Result.ShortDateFormat, #0);
  Result.ShortTimeFormat := TranslateDateFormat(Locale, T_FMT, 'hh:mm AMPM', #0); // Do not localize
  Result.LongTimeFormat := TranslateDateFormat(Locale, T_FMT_AMPM, Result.ShortTimeFormat, #0);

  Result.DateSeparator := GetFirstCharacter(Result.ShortDateFormat, '/.-'); // Do not localize
  Result.TimeSeparator := GetFirstCharacter(Result.ShortTimeFormat, ':.'); // Do not localize

  Result.TimeAMString := string(nl_langinfo_internal(AM_STR, Locale));
  Result.TimePMString := string(nl_langinfo_internal(PM_STR, Locale));
  Result.ListSeparator := ',';
end;
{$ENDIF LINUX}

class function TFormatSettings.Create(const LocaleName: string): TFormatSettings;
{$IFDEF MSWINDOWS}
var
  Locale: LCID;
begin
  if LocaleName <> '' then
  begin
    if Win32MajorVersion >= 6 then
      // Windows Vista and later support a direct API call
      Locale := LocaleNameToLCID(PChar(AdjustLocaleName(LocaleName)), 0)
    else
      // Use TLanguages for older OS versions (slower)
      Locale := Languages.LocaleID[Languages.IndexOf(AdjustLocaleName(LocaleName))];
  end
  else
    Locale := GetThreadLocale;

  Result := Create(Locale);
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
var
  S: CFStringRef;
  Locale: CFLocaleRef;
begin
  if LocaleName = '' then
    Locale := CFLocaleCopyCurrent
  else
  begin
    S := TCFString.Create(LocaleName).Value;
    try
      Locale := CFLocaleCreate(kCFAllocatorDefault, S);
    finally
      CFRelease(S);
    end;
    if Locale = nil then
      Locale := CFLocaleCopyCurrent;
  end;
  try
    Result := Create(Locale);
  finally
    CFRelease(Locale);
  end;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
var
  Locale: locale_t;
begin
  if LocaleName = '' then
    Result := Create(nil)
  else
  begin
    Locale := newlocale(LC_ALL_MASK, PAnsiChar(AnsiString(AdjustLocaleName(LocaleName))), nil);
    if Locale = nil then
      Locale := newlocale(LC_ALL_MASK, '', nil);
    try
      Result := Create(Locale);
    finally
      if Locale <> nil then
        freelocale(Locale);
    end;
  end;
end;
{$ENDIF LINUX}

class function TFormatSettings.Create: TFormatSettings;
begin
  Result := TFormatSettings.Create('');
end;

{$IF DEFINED(MSWINDOWS) OR DEFINED(LINUX)}
class function TFormatSettings.AdjustLocaleName(const LocaleName: string): string;
const
{$IFDEF MSWINDOWS}
  CLookup = '_';
  CReplace = '-';
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  CLookup = '-';
  CReplace = '_';
{$ENDIF LINUX}
var
  P: PChar;
begin
  Result := LocaleName;
  P := PChar(Result);
  while P^ <> #0 do
  begin
    if P^ = CLookup then
    begin
      P^ := CReplace;
      Break;
    end;
    Inc(P);
  end;
end;
{$ENDIF}

{$IF DEFINED(MSWINDOWS) OR DEFINED(LINUX)}
class procedure TFormatSettings.GetDayNames(Locale: TLocaleID;
  var AFormatSettings: TFormatSettings);
const
{$IFDEF MSWINDOWS}
  CShortName = LOCALE_SABBREVDAYNAME1;
  CLongName = LOCALE_SDAYNAME1;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  CShortName = ABDAY_1 - 1;
  CLongName = DAY_1 - 1;
{$ENDIF LINUX}
var
  I, Day: Integer;
begin
  for I := 1 to 7 do
  begin
{$IFDEF MSWINDOWS}
    Day := (I + 5) mod 7;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
    Day := I;
{$ENDIF LINUX}
    AFormatSettings.ShortDayNames[I] := GetString(Locale,
      CShortName + Day, I - Low(DefShortDayNames), DefShortDayNames);
    AFormatSettings.LongDayNames[I] := GetString(Locale,
      CLongName + Day, I - Low(DefLongDayNames), DefLongDayNames);
  end;
end;
{$ELSEIF DEFINED(MACOS)}
class procedure TFormatSettings.GetDayNames(Formatter: CFDateFormatterRef;
  var AFormatSettings: TFormatSettings);
var
  I: Integer;
  LNames: CFArrayRef;
begin
  LNames := CFArrayRef(CFDateFormatterCopyProperty(Formatter, kCFDateFormatterShortWeekdaySymbols));
  try
    for I := 1 to 7 do
    begin
      AFormatSettings.ShortDayNames[I] := TCFString(CFArrayGetValueAtIndex(LNames, I - 1)).AsString;
      if AFormatSettings.ShortDayNames[I] = '' then
        AFormatSettings.ShortDayNames[I] := LoadResString(DefShortDayNames[I]);
    end;
  finally
    CFRelease(LNames);
  end;

  LNames := CFArrayRef(CFDateFormatterCopyProperty(Formatter, kCFDateFormatterWeekdaySymbols));
  try
    for I := 1 to 7 do
    begin
      AFormatSettings.LongDayNames[I] := TCFString(CFArrayGetValueAtIndex(LNames, I - 1)).AsString;
      if AFormatSettings.LongDayNames[I] = '' then
        AFormatSettings.LongDayNames[I] := LoadResString(DefLongDayNames[I]);
    end;
  finally
    CFRelease(LNames);
  end;
end;
{$ENDIF}

{$IF DEFINED(MSWINDOWS) OR DEFINED(LINUX)}
class procedure TFormatSettings.GetMonthNames(Locale: TLocaleID;
  var AFormatSettings: TFormatSettings);
const
{$IFDEF MSWINDOWS}
  CShortName = LOCALE_SABBREVMONTHNAME1;
  CLongName = LOCALE_SMONTHNAME1;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  CShortName = ABMON_1;
  CLongName = MON_1;
{$ENDIF LINUX}
var
  I: Integer;
begin
  for I := 1 to 12 do
  begin
    AFormatSettings.ShortMonthNames[I] := GetString(Locale,
      CShortName + I - 1, I - Low(DefShortMonthNames), DefShortMonthNames);
    AFormatSettings.LongMonthNames[I] := GetString(Locale,
      CLongName + I - 1, I - Low(DefLongMonthNames), DefLongMonthNames);
  end;
end;
{$ELSEIF DEFINED(MACOS)}
class procedure TFormatSettings.GetMonthNames(Formatter: CFDateFormatterRef;
  var AFormatSettings: TFormatSettings);
var
  I: Integer;
  LNames: CFArrayRef;
begin
  LNames := CFArrayRef(CFDateFormatterCopyProperty(Formatter, kCFDateFormatterShortMonthSymbols));
  try
    for I := 1 to 12 do
    begin
      AFormatSettings.ShortMonthNames[I] := TCFString(CFArrayGetValueAtIndex(LNames, I - 1)).AsString;
      if AFormatSettings.ShortMonthNames[I] = '' then
        AFormatSettings.ShortMonthNames[I] := LoadResString(DefShortMonthNames[I]);
    end;
  finally
    CFRelease(LNames);
  end;

  LNames := CFArrayRef(CFDateFormatterCopyProperty(Formatter, kCFDateFormatterMonthSymbols));
  try
    for I := 1 to 12 do
    begin
      AFormatSettings.LongMonthNames[I] := TCFString(CFArrayGetValueAtIndex(LNames, I - 1)).AsString;
      if AFormatSettings.LongMonthNames[I] = '' then
        AFormatSettings.LongMonthNames[I] := LoadResString(DefLongMonthNames[I]);
    end;
  finally
    CFRelease(LNames);
  end;
end;
{$ENDIF}

{$IF DEFINED(MSWINDOWS) OR DEFINED(LINUX)}
class function TFormatSettings.GetString(Locale: TLocaleID; LocaleItem,
  DefaultIndex: Integer; const DefaultValues: array of Pointer): string;
{$IFDEF MSWINDOWS}
begin
  Result := GetLocaleStr(Locale, LocaleItem, '');
  if Result = '' then
    Result := LoadResString(DefaultValues[DefaultIndex]);
end;
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
var
  LResult: PAnsiChar;
begin
  LResult := nl_langinfo_internal(LocaleItem, Locale);
  if (LResult = nil) or (LResult^ = #0) then
    Result := LoadResString(DefaultValues[DefaultIndex])
  else
    Result := UTF8ToString(LResult);
end;
{$ENDIF LINUX}
{$ENDIF}

class function TFormatSettings.TranslateDateFormat(Locale: TLocaleID;
  LocaleType: Integer; const Default: string; const Separator: Char): string;
{$IFDEF MSWINDOWS}
var
  I: Integer;
  L: Integer;
  CalendarType: CALTYPE;
  RemoveEra: Boolean;
  LFormat: string;

  procedure FixDateSeparator(var DateFormat: string);
  var
    P: PChar;
  begin
    P := PChar(DateFormat);
    if P = nil then
      Exit;

    while P^ <> #0 do
    begin
      if P^ = Separator then
        P^ := '/';
      Inc(P);
    end;
  end;

begin
  I := Low(string);
  Result := '';
  LFormat := GetLocaleStr(Locale, LocaleType, Default);
  CalendarType := StrToIntDef(GetLocaleStr(Locale, LOCALE_ICALENDARTYPE, '1'), 1);
  if not (CalendarType in [CAL_JAPAN, CAL_TAIWAN, CAL_KOREA]) then
  begin
    RemoveEra := SysLocale.PriLangID in [LANG_JAPANESE, LANG_CHINESE, LANG_KOREAN];
    if RemoveEra then
    begin
      While I <= High(LFormat) do
      begin
        if not (LFormat[I] in ['g', 'G']) then
          Result := Result + LFormat[I];
        Inc(I);
      end;
    end
    else
      Result := LFormat;

    { Adjust the date separator accordingly }
    FixDateSeparator(Result);
    Exit;
  end;

  while I <= High(LFormat) do
  begin
    if IsLeadChar(LFormat[I]) then
    begin
      L := CharLength(LFormat, I) div SizeOf(Char);
      Result := Result + LFormat.SubString(I-Low(string), L);
      Inc(I, L);
    end else
    begin
      if string.Compare(LFormat, I - 1, 'gg', 0, 2, True) = 0 then
      begin
        Result := Result + 'ggg';
        Inc(I, 1);
      end
      else if string.Compare(LFormat, I - 1, 'yyyy', 0, 4, True) = 0 then
      begin
        Result := Result + 'eeee';
        Inc(I, 4-1);
      end
      else if string.Compare(LFormat, I - 1, 'yy', 0, 2, True) = 0 then
      begin
        Result := Result + 'ee';
        Inc(I, 2-1);
      end
      else if LFormat[I] in ['y', 'Y'] then
        Result := Result + 'e'
      else
        Result := Result + LFormat[I];
      Inc(I);
    end;
  end;

  { Adjust the date separator accordingly }
  FixDateSeparator(Result);
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}

  function CountChar(P: string; I: Integer; C: Char; MaxCount: Integer): Integer;
  begin
    Result := 0;
    while (P[I] = C) and (Result < MaxCount) do
    begin
      Inc(I);
      Inc(Result);
    end;
  end;

  function GetDateTimeFormat(Locale: CFLocaleRef; DateStyle: CFDateFormatterStyle;
    TimeStyle: CFDateFormatterStyle): string;
  var
    LDateFormatter: CFDateFormatterRef;
  begin
    LDateFormatter := CFDateFormatterCreate(kCFAllocatorDefault, Locale, DateStyle, TimeStyle);
    try
      Result := TCFString(CFDateFormatterGetFormat(LDateFormatter)).AsString;
    finally
      CFRelease(LDateFormatter);
    end;
  end;

var
  I, Len: Integer;
  LFormat: string;
  ReplaceYearsForEra: Boolean;
begin
  Result := '';
  case LocaleType of
    LOCALE_SHORTDATE:
      LFormat := GetDateTimeFormat(Locale, kCFDateFormatterShortStyle, kCFDateFormatterNoStyle);
    LOCALE_LONGDATE:
      LFormat := GetDateTimeFormat(Locale, kCFDateFormatterFullStyle, kCFDateFormatterNoStyle);
    LOCALE_SHORTTIME:
      LFormat := GetDateTimeFormat(Locale, kCFDateFormatterNoStyle, kCFDateFormatterShortStyle);
    LOCALE_LONGTIME:
      LFormat := GetDateTimeFormat(Locale, kCFDateFormatterNoStyle, kCFDateFormatterMediumStyle);
  else
    LFormat := '';
  end;

  ReplaceYearsForEra := False;
  I := Low(LFormat);
  while I <= High(LFormat) do
  begin
    if IsLeadChar(LFormat[I]) then
    begin
      Len := CharLength(LFormat, I) div SizeOf(Char);
      Result := Result + LFormat.SubString(I-Low(string), Len);
      Inc(I, Len);
    end
    else
    begin
      case LFormat[I] of
        'G': // Eras (Japanese/Taiwanese locales only)
          begin
            ReplaceYearsForEra := True;
            Len := CountChar(LFormat, I, 'G', 5);
            case Len of
              1..3, 5: Result := Result + 'g';
              4: Result := Result + 'gg';
            end;
            Inc(I, Len - 1);
          end;

        'y': // Years
          begin
            Len := CountChar(LFormat, I, 'y', Length(LFormat) - I + Low(LFormat));
            if ReplaceYearsForEra then
              case Len of
                1, 2: Result := Result + 'ee'
                else Result := Result + 'eeee';
              end
            else
              case Len of
                2: Result := Result + 'yy'
                else Result := Result + 'yyyy'
              end;
            Inc(I, Len - 1);
          end;

        'M': // Months
          begin
            Len := CountChar(LFormat, I, 'M', 5);
            case Len of
              1: Result := Result + 'm';
              2: Result := Result + 'mm';
              3, 5: Result := Result + 'mmm';
              4: Result := Result + 'mmmm';
            end;
            Inc(I, Len - 1);
          end;

        'd': // Days
          begin
            Len := CountChar(LFormat, I, 'd', 2);
            Result := Result + StringOfChar('d', Len);
            Inc(I, Len - 1);
          end;

        'E': // Weekdays
          begin
            Len := CountChar(LFormat, I, 'E', 5);
            case Len of
              1..3,5: Result := Result + 'ddd';
              4: Result := Result + 'dddd';
            end;
            Inc(I, Len - 1);
          end;

        'a': // AM or PM
          begin
            Result := Result + 'AMPM';
          end;

        'h', 'H': // Hours
          begin
            Len := CountChar(LFormat, I, LFormat[I], 2);
            Result := Result + StringOfChar('h', Len);
            Inc(I, Len - 1);
          end;

        'm': // Minutes
          begin
            Len := CountChar(LFormat, I, 'm', 2);
            Result := Result + StringOfChar('n', Len);
            Inc(I, Len - 1);
          end;

        's': // Seconds
          begin
            Len := CountChar(LFormat, I, LFormat[I], 2);
            Result := Result + StringOfChar('s', Len);
            Inc(I, Len - 1);
          end;

        #39: // Literals enclosed in single quotes
          begin
            Len := 0;
            repeat
              Result := Result + LFormat[Len + I];
              Inc(Len);
            until ((Len + I) > Length(LFormat)) or (LFormat[Len + I] = #39);
            Result := Result + LFormat[Len + I];
            Inc(I, Len);
          end;

        // unsupported format specifiers
        'Y', 'u',      // week of year; extended year
        'Q', 'q',      // quarter; stand-alone quarter
        'L',           // stand-alone month
        'w', 'W',      // week of year; week of month
        'D', 'F', 'g', // day of year; day of week in month; modified Julian day
        'e', 'c',      // local day of week; stand-alone local day of week
        'z', 'Z', 'v', // Timezone
        'K', 'k',      // hour (0-11); hour (1-24)
        'A':           // milliseconds in day
          begin
            Len := CountChar(LFormat, I, LFormat[I], LFormat.Length - I + Low(LFormat));
            Inc(I, Len - 1);
            if LFormat[I + 1] = ' ' then
              Inc(I);
          end
      else
        Result := Result + LFormat[I];
      end;
      Inc(I);
    end;
  end;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
var
  P: PAnsiChar;
begin
  Result := '';
  P := nl_langinfo_internal(LocaleType, Locale);
  while P^ <> #0 do
  begin
    if P^ = '%' then
    begin
      Inc(P);
      case P^ of
        'a': Result := Result + 'ddd';
        'A': Result := Result + 'dddd';
        'b': Result := Result + 'MMM';
        'B': Result := Result + 'MMMM';
        'c': Result := Result + 'c';
//        'C':  year / 100 not supported
        'd': Result := Result + 'dd';
        'D': Result := Result + 'MM/dd/yy';
        'e': Result := Result + 'd';
//        'E': alternate format not supported
        'g': Result := Result + 'yy';
        'G': Result := Result + 'yyyy';
        'h': Result := Result + 'MMM';
        'H': Result := Result + 'HH';
        'I': Result := Result + 'hh';
//        'j': day of year not supported
        'k': Result := Result + 'H';
        'l': Result := Result + 'h';
        'm': Result := Result + 'MM';
        'M': Result := Result + 'nn';  // minutes! not months!
        'n': Result := Result + sLineBreak;  // line break
//        'O': alternate format not supported
        'P',   // P's implied lowercasing of locale string is not supported
        'p': Result := Result + 'AMPM';
        'r': Result := Result + TranslateDateFormat(Locale, T_FMT_AMPM, '', #0);
        'R': Result := Result + 'HH:mm';
//        's': number of seconds since Epoch not supported
        'S': Result := Result + 'ss';
        't': Result := Result + #9;  // tab char
        'T': Result := Result + 'HH:mm:ss';
//        'u': day of week 1..7 not supported
//        'U': week number of the year not supported
//        'V': week number of the year not supported
//        'w': day of week 0..6 not supported
//        'W': week number of the year not supported
        'x': Result := Result + TranslateDateFormat(Locale, D_FMT, '', #0);
        'X': Result := Result + TranslateDateFormat(Locale, T_FMT, '', #0);
        'y': Result := Result + 'yy';
        'Y': Result := Result + 'yyyy';
//        'z': GMT offset is not supported
        '%': Result := Result + '%';
      end;
    end
    else
      Result := Result + string(P^);
    Inc(P);
  end;
  if Result = '' then
    Result := Default;
end;
{$ENDIF LINUX}

{$IFDEF MSWINDOWS}
function EnumEraNames(Names: PChar): Integer; stdcall;
var
  I: Integer;
begin
  Result := 0;
  I := Low(EraNames);
  while EraNames[I] <> '' do
    if (I = High(EraNames)) then
      Exit
    else Inc(I);
  EraNames[I] := Names;
  Result := 1;
end;

function EnumEraYearOffsets(YearOffsets: PChar): Integer; stdcall;
var
  I: Integer;
begin
  Result := 0;
  I := Low(EraYearOffsets);
  while EraYearOffsets[I] <> -1 do
    if (I = High(EraYearOffsets)) then
      Exit
    else Inc(I);
  EraYearOffsets[I] := StrToIntDef(YearOffsets, 0);
  Result := 1;
end;
{$ENDIF MSWINDOWS}

procedure GetEraNamesAndYearOffsets;
{$IFDEF MSWINDOWS}
var
  J: Integer;
  CalendarType: CALTYPE;
begin
  CalendarType := StrToIntDef(GetLocaleStr(GetThreadLocale,
    LOCALE_IOPTIONALCALENDAR, '1'), 1);
  if CalendarType in [CAL_JAPAN, CAL_TAIWAN, CAL_KOREA] then
  begin
    EnumCalendarInfo(@EnumEraNames, GetThreadLocale, CalendarType,
      CAL_SERASTRING);
    for J := Low(EraYearOffsets) to High(EraYearOffsets) do
      EraYearOffsets[J] := -1;
    EnumCalendarInfo(@EnumEraYearOffsets, GetThreadLocale, CalendarType,
      CAL_IYEAROFFSETRANGE);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
{$IFDEF MACOS}
  I, Discard: Integer;
  LEras: CFArrayRef;
  Locale: CFLocaleRef;
  Formatter: CFDateFormatterRef;
  EndDate: TDateTime;
  GMT_TZ: CFTimeZoneRef;
  StartEra, TargetEra, LengthEra: CFAbsoluteTime;
  LDate: CFGregorianDate;
  DefaultCalendar, Calendar: CFCalendarRef;
{$ELSE !MACOS}
var
   Count: Byte;
   I, J, Pos: Integer;
   Number: Word;
   S: string;
   Year, Month, Day: Word;
{$ENDIF MACOS}
begin
{$IFDEF MACOS}
  EraCount := 0;
  Locale := nil;
  GMT_TZ := nil;
  Formatter := nil;
  LEras := nil;
  DefaultCalendar := nil;
  Calendar := nil;
  try
    Locale := CFLocaleCopyCurrent;
    GMT_TZ := CFTimeZoneCreateWithTimeIntervalFromGMT(kCFAllocatorDefault,0);
    Formatter := CFDateFormatterCreate(kCFAllocatorDefault, Locale,
                                       kCFDateFormatterFullStyle, kCFDateFormatterNoStyle);
    LEras := CFArrayRef(CFDateFormatterCopyProperty(Formatter, kCFDateFormatterEraSymbols));
    EraCount := CFArrayGetCount(LEras);
    DefaultCalendar := CFCalendarCopyCurrent;
    Calendar := CFCalendarCreateWithIdentifier(kCFAllocatorDefault,
                                  CFCalendarGetIdentifier(DefaultCalendar));
    TargetEra := CFAbsoluteTimeGetCurrent;
    EndDate := High(Integer);
    // If we have more eras than slots, we discard the oldest eras.
    if EraCount > MaxEraCount then
      Discard := EraCount - MaxEraCount
    else
      Discard := 0;
    for I := EraCount - Discard downto 1 do
    begin
      EraNames[I] := TCFString(CFArrayGetValueAtIndex(LEras, I-1+Discard)).AsString;
      if EraNames[I] = '' then break;
      if CFCalendarGetTimeRangeOfUnit(Calendar, kCFCalendarUnitEra,
                                      TargetEra, @StartEra, @LengthEra) then
      begin
        LDate := CFAbsoluteTimeGetGregorianDate(startEra, GMT_TZ);
        if (Ldate.year < 0) then
        begin
          // We cannot Encode Dates with negative years... so we hardcode the start of the era.
          EraRanges[I].StartDate := -MaxInt;
          EraYearOffsets[I] := 0;
        end
        else begin
          EraRanges[I].StartDate := Trunc(EncodeDate(LDate.year, LDate.month, LDate.day));
          EraYearOffsets[I] := LDate.Year - 1;
        end;
        EraRanges[I].EndDate := Trunc(EndDate);
        EndDate := EraRanges[I].StartDate;
      end;
      TargetEra := StartEra - 100000; // Go back one day aprox (60*60*24 =  86400) We use "100000"
    end;
    // Clear Unused Slots
    for I := EraCount + 1 to MaxEraCount do
    begin
      EraNames[I] := '';
      EraYearOffsets[I] := -1;
      EraRanges[I].StartDate := High(EraRanges[I].StartDate);
      EraRanges[I].EndDate := High(EraRanges[I].EndDate);
      EraYearFormats[I] := '';
    end;
    EraCount := EraCount - Discard;
  finally
    if Calendar <> nil then
      CFRelease(Calendar);
    if DefaultCalendar <> nil then
      CFRelease(DefaultCalendar);
    if Formatter <> nil then
      CFRelease(Formatter);
    if LEras <> nil then
      CFRelease(LEras);
    if GMT_TZ <> nil then
      CFRelease(GMT_TZ);
    if Locale <> nil then
      CFRelease(Locale);
  end;
{$ELSE !MACOS}
  EraCount := 0;
  S := string(nl_langinfo(ERA));
  if S = '' then
    S := LoadResString(@SEraEntries);

  Pos := 1;
  for I := 1 to MaxEraCount do
  begin
    if Pos > Length(S) then Break;
    if not(ScanChar(S, Pos, '+') or ScanChar(S, Pos, '-')) then Break;
    // Eras in which year increases with negative time (eg Christian BC era)
    // are not currently supported.
//    EraRanges[I].Direction := S[Pos - 1];

    // Era offset, in years from Gregorian calendar year
    if not ScanChar(S, Pos, ':') then Break;
    if ScanChar(S, Pos, '-') then
      J := -1
    else
      J := 1;
    if not ScanNumber(S, Pos, Number, Count) then Break;
    EraYearOffsets[I] := J * Number;   // apply sign to Number

    // Era start date, in Gregorian year/month/day format
    if not ScanChar(S, Pos, ':') then Break;
    if not ScanNumber(S, Pos, Year, Count) then Break;
    if not ScanChar(S, Pos, '/') then Break;
    if not ScanNumber(S, Pos, Month, Count) then Break;
    if not ScanChar(S, Pos, '/') then Break;
    if not ScanNumber(S, Pos, Day, Count) then Break;
    EraRanges[I].StartDate := Trunc(EncodeDate(Year, Month, Day));
    EraYearOffsets[I] := Year - EraYearOffsets[I];

    // Era end date, in Gregorian year/month/day format
    if not ScanChar(S, Pos, ':') then Break;
    if ScanString(S, Pos, '+*') then       // positive infinity
      EraRanges[I].EndDate := High(EraRanges[I].EndDate)
    else if ScanString(S, Pos, '-*') then  // negative infinity
      EraRanges[I].EndDate := Low(EraRanges[I].EndDate)
    else if not ScanNumber(S, Pos, Year, Count) then
      Break
    else
    begin
      if not ScanChar(S, Pos, '/') then Break;
      if not ScanNumber(S, Pos, Month, Count) then Break;
      if not ScanChar(S, Pos, '/') then Break;
      if not ScanNumber(S, Pos, Day, Count) then Break;
      EraRanges[I].EndDate := Trunc(EncodeDate(Year, Month, Day));
    end;

    // Era name, in locale charset
    if not ScanChar(S, Pos, ':') then Break;
    J := AnsiPos(':', Copy(S, Pos, Length(S) + 1 - Pos));
    if J = 0 then Break;
    EraNames[I] := Copy(S, Pos, J - 1);
    Inc(Pos, J - 1);

    // Optional Era format string for era year, in locale charset
    if not ScanChar(S, Pos, ':') then Break;
    J := AnsiPos(';', Copy(S, Pos, Length(S) + 1 - Pos));
    if J = 0 then
      J := 1 + Length(S) + 1 - Pos;
    {if J = 0 then Break;}
    EraYearFormats[I] := Copy(S, Pos, J - 1);
    Inc(Pos, J - 1);
    Inc(EraCount);
    if not((Pos > Length(S)) or ScanChar(S, Pos, ';')) then Break;
  end;

  // Clear the rest of the era slots, including partial entry from failed parse
  for I := EraCount+1 to MaxEraCount do
  begin
    EraNames[I] := '';
    EraYearOffsets[I] := -1;
    EraRanges[I].StartDate := High(EraRanges[I].StartDate);
    EraRanges[I].EndDate := High(EraRanges[I].EndDate);
    EraYearFormats[I] := '';
  end;
{$ENDIF MACOS}
end;
{$ENDIF POSIX}

{ Exception handling routines }

var
  OutOfMemory: EOutOfMemory;
  InvalidPointer: EInvalidPointer;

{ Convert physical address to logical address }

{ Format and return an exception error message }

function ExceptionErrorMessage(ExceptObject: TObject; ExceptAddr: Pointer;
  Buffer: PChar; Size: Integer): Integer;
{$IFDEF MSWINDOWS}
  function ConvertAddr(Address: Pointer): Pointer;
  {$IFDEF PUREPASCAL}
  begin
    Result := Address;
    if Result <> nil then
      Dec(PByte(Result), $1000);
  end;
  {$ELSE !PUREPASCAL}
  {$IFDEF X86ASM}
  asm //StackAlignSafe
          TEST    EAX,EAX         { Always convert nil to nil }
          JE      @@1
          SUB     EAX, $1000      { offset from code start; code start set by linker to $1000 }
  @@1:
  end;
  {$ENDIF X86ASM}
  {$ENDIF !PUREPASCAL}

var
  MsgPtr: PChar;
  MsgEnd: PChar;
  MsgLen: Integer;
  ModuleName: array[0..MAX_PATH] of Char;
  Temp: array[0..MAX_PATH] of Char;
  Format: array[0..255] of Char;
  Info: TMemoryBasicInformation;
  ConvertedAddress: Pointer;
begin
  VirtualQuery(ExceptAddr, Info, sizeof(Info));
  if (Info.State <> MEM_COMMIT) or
    (GetModuleFilename(THandle(Info.AllocationBase), Temp, Length(Temp)) = 0) then
  begin
    GetModuleFileName(HInstance, Temp, Length(Temp));
    ConvertedAddress := ConvertAddr(ExceptAddr);
  end
  else
    IntPtr(ConvertedAddress) := IntPtr(ExceptAddr) - IntPtr(Info.AllocationBase);
  StrLCopy(ModuleName, AnsiStrRScan(Temp, '\') + 1, Length(ModuleName) - 1);
  MsgPtr := '';
  MsgEnd := '';
  if ExceptObject is Exception then
  begin
    MsgPtr := PChar(Exception(ExceptObject).Message);
    MsgLen := StrLen(MsgPtr);
    if (MsgLen <> 0) and (MsgPtr[MsgLen - 1] <> '.') then MsgEnd := '.';
  end;
  LoadString(FindResourceHInstance(HInstance),
    PResStringRec(@SException).Identifier, Format, Length(Format));
  StrLFmt(Buffer, Size, Format, [ExceptObject.ClassName, ModuleName,
    ConvertedAddress, MsgPtr, MsgEnd]);
  Result := StrLen(Buffer);
end;
{$ENDIF MSWINDOWS}
{$IF defined(LINUX) or defined(MACOS)}
const
  UnknownModuleName = '<unknown>';
var
  MsgPtr: PChar;
  MsgEnd: PChar;
  MsgLen: Integer;
  Modulename: string;
  Info: dl_info;
begin
  MsgPtr := '';
  MsgEnd := '';
  if ExceptObject is Exception then
  begin
    MsgPtr := PChar(Exception(ExceptObject).Message);
    MsgLen := StrLen(MsgPtr);
    if (MsgLen <> 0) and (MsgPtr[MsgLen - 1] <> '.') then MsgEnd := '.';
  end;
  if (dladdr(IntPtr(ExceptAddr), Info) <> 0) and (Info.dli_fname <> nil) then
  begin
    ModuleName := string(Info.dli_fname);
    ModuleName := Modulename.SubString(Modulename.LastIndexOf( PathDelim) + 1)
  end
  else
  begin
    ModuleName := UnknownModuleName;
  end;
  StrLFmt(Buffer, Size, PChar(SException), [ExceptObject.ClassName, ModuleName,
    ExceptAddr, MsgPtr, MsgEnd]);
  Result := StrLen(Buffer);
end;
{$ENDIF LINUX or MACOS}

{ Display exception message box }

                                                                                   
procedure ShowException(ExceptObject: TObject; ExceptAddr: Pointer);
{$IFDEF MSWINDOWS}
var
  Title: array[0..63] of Char;
  Buffer: array[0..1023] of Char;
  OemBuffer: array of Byte;
  BufSize, OemBufSize: Integer;
  Dummy: Cardinal;
begin
  BufSize := ExceptionErrorMessage(ExceptObject, ExceptAddr, Buffer, Length(Buffer));
  if IsConsole then
  begin
    Flush(Output);
    OemBufSize := WideCharToMultiByte(CP_OEMCP, 0, Buffer, BufSize, nil, 0, nil, nil);
    SetLength(OemBuffer, OemBufSize);
    WideCharToMultiByte(CP_OEMCP, 0, Buffer, BufSize, @OemBuffer[0], OemBufSize, nil, nil);
    WriteFile(GetStdHandle(STD_ERROR_HANDLE), OemBuffer[0], OemBufSize, Dummy, nil);
    WriteFile(GetStdHandle(STD_ERROR_HANDLE), sLineBreak, 2, Dummy, nil);
  end
  else
  begin
    LoadString(FindResourceHInstance(HInstance), PResStringRec(@SExceptTitle).Identifier,
      Title, Length(Title));
    MessageBox(0, Buffer, Title, MB_OK or MB_ICONSTOP or MB_TASKMODAL);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  LMessage: array[0..1024] of Char;
  B: TBytes;
begin
  ExceptionErrorMessage(ExceptObject, ExceptAddr, LMessage, Length(LMessage));
  if TTextRec(ErrOutput).Mode = fmOutput then
    Flush(ErrOutput);

  { Convert to UTF8 prior to sending to console }
  B := TEncoding.UTF8.GetBytes(string(LMessage));
  __write(STDERR_FILENO, PByte(B), Length(B));
end;
{$ENDIF POSIX}

{ Raise abort exception }

procedure Abort;
begin
  raise EAbort.CreateRes(@SOperationAborted) at ReturnAddress;
end;

{ Raise out of memory exception }

procedure OutOfMemoryError;
begin
  raise OutOfMemory;
end;

{ Exception class }

constructor Exception.Create(const Msg: string);
begin
  FMessage := Msg;
end;

constructor Exception.CreateFmt(const Msg: string;
  const Args: array of const);
begin
  FMessage := Format(Msg, Args);
end;

{$IFNDEF NEXTGEN}
constructor Exception.CreateRes(Ident: NativeUInt);
begin
  FMessage := LoadStr(Ident);
end;
{$ENDIF !NEXTGEN}

constructor Exception.CreateRes(ResStringRec: PResStringRec);
begin
  FMessage := LoadResString(ResStringRec);
end;

{$IFNDEF NEXTGEN}
constructor Exception.CreateResFmt(Ident: NativeUInt;
  const Args: array of const);
begin
  FMessage := Format(LoadStr(Ident), Args);
end;
{$ENDIF !NEXTGEN}

constructor Exception.CreateResFmt(ResStringRec: PResStringRec;
  const Args: array of const);
begin
  FMessage := Format(LoadResString(ResStringRec), Args);
end;

constructor Exception.CreateHelp(const Msg: string; AHelpContext: Integer);
begin
  FMessage := Msg;
  FHelpContext := AHelpContext;
end;

constructor Exception.CreateFmtHelp(const Msg: string; const Args: array of const;
  AHelpContext: Integer);
begin
  FMessage := Format(Msg, Args);
  FHelpContext := AHelpContext;
end;

{$IFNDEF NEXTGEN}
constructor Exception.CreateResHelp(Ident: NativeUInt; AHelpContext: Integer);
begin
  FMessage := LoadStr(Ident);
  FHelpContext := AHelpContext;
end;
{$ENDIF !NEXTGEN}

constructor Exception.CreateResHelp(ResStringRec: PResStringRec;
  AHelpContext: Integer);
begin
  FMessage := LoadResString(ResStringRec);
  FHelpContext := AHelpContext;
end;

{$IFNDEF NEXTGEN}
constructor Exception.CreateResFmtHelp(Ident: NativeUInt;
  const Args: array of const;
  AHelpContext: Integer);
begin
  FMessage := Format(LoadStr(Ident), Args);
  FHelpContext := AHelpContext;
end;
{$ENDIF !NEXTGEN}

constructor Exception.CreateResFmtHelp(ResStringRec: PResStringRec;
  const Args: array of const;
  AHelpContext: Integer);
begin
  FMessage := Format(LoadResString(ResStringRec), Args);
  FHelpContext := AHelpContext;
end;

destructor Exception.Destroy;
begin
  FreeAndNil(FInnerException);
  if Assigned(CleanupStackInfoProc) then
    CleanupStackInfoProc(FStackInfo);
  FStackInfo := nil;
  inherited Destroy;
end;

function Exception.GetBaseException: Exception;
begin
  Result := Self;
  while Result.InnerException <> nil do
    Result := Result.InnerException;
end;

function Exception.GetStackTrace: string;
begin
  if Assigned(GetStackInfoStringProc) then
    Result := GetStackInfoStringProc(FStackInfo)
  else
    Result := '';
end;

class procedure Exception.RaiseOuterException(E: Exception);
{$IFDEF PUREPASCAL}
begin
  if E <> nil then
    E.FAcquireInnerException := True;
  raise E;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
      TEST  EAX,EAX
      JZ    System.@RaiseExcept
      MOV   [EAX].Exception.FAcquireInnerException,1
      JMP   System.@RaiseExcept
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

class procedure Exception.ThrowOuterException(E: Exception);
{$IFDEF PUREPASCAL}
begin
  if E <> nil then
    E.FAcquireInnerException := True;
  raise E;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
      TEST  EAX,EAX
      JZ    System.@RaiseExcept
      MOV   [EAX].Exception.FAcquireInnerException,1
      JMP   System.@RaiseExcept
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

procedure Exception.RaisingException(P: PExceptionRecord);
begin
  SetInnerException;
  if Assigned(GetExceptionStackInfoProc) then
    SetStackInfo(GetExceptionStackInfoProc(P));
end;

procedure Exception.SetInnerException;
begin
  if FAcquireInnerException and (TObject(ExceptObject) is Exception) then
    FInnerException := Exception(AcquireExceptionObject);
end;

procedure Exception.SetStackInfo(AStackInfo: Pointer);
begin
  FStackInfo := AStackInfo;
end;

function Exception.ToString: string;
var
  Inner: Exception;
begin
  Inner := Self;
  Result := '';
  while Inner <> nil do
  begin
    if Result <> '' then
      Result := Result + sLineBreak + Inner.Message
    else
      Result := Inner.Message;
    Inner := Inner.InnerException;
  end;
end;

{ EHeapException class }

{$IFNDEF AUTOREFCOUNT}
procedure EHeapException.FreeInstance;
begin
  if AllowFree then
    inherited FreeInstance;
end;
{$ENDIF}

procedure EHeapException.RaisingException(P: PExceptionRecord);
begin
  SetInnerException;
  // Don't try to get a stack trace since that may involve heap operations which at this point
  // would probably be a "bad thing" to do.
end;

{ Create I/O exception }

function CreateInOutError: EInOutError;
type
  TErrorRec = record
    Code: Integer;
    Ident: string;
  end;
const
  ErrorMap: array[0..6] of TErrorRec = (
    (Code: 2; Ident: SFileNotFound),
    (Code: 3; Ident: SInvalidFilename),
    (Code: 4; Ident: STooManyOpenFiles),
    (Code: 5; Ident: SAccessDenied),
    (Code: 100; Ident: SEndOfFile),
    (Code: 101; Ident: SDiskFull),
    (Code: 106; Ident: SInvalidInput));
var
  I: Integer;
  InOutRes: Integer;
begin
  I := Low(ErrorMap);
  InOutRes := IOResult;  // resets IOResult to zero
  while (I <= High(ErrorMap)) and (ErrorMap[I].Code <> InOutRes) do Inc(I);
  if I <= High(ErrorMap) then
    Result := EInOutError.Create(ErrorMap[I].Ident) else
    Result := EInOutError.CreateResFmt(@SInOutError, [InOutRes]);
  Result.ErrorCode := InOutRes;
end;

{ RTL error handler }

procedure ErrorHandler(ErrorCode: Byte; ErrorAddr: Pointer); export;
var
  E: Exception;
begin
  case ErrorCode of
    Ord(reOutOfMemory):
      E := OutOfMemory;
    Ord(reInvalidPtr):
      E := InvalidPointer;
    Ord(reDivByZero)..Ord(High(TRuntimeError)):
      E := ExceptTypes[ExceptMap[ErrorCode].EClass].Create(ExceptMap[ErrorCode].EIdent);
  else
    E := CreateInOutError;
  end;
  if ErrorAddr <> nil then
    raise E at ErrorAddr
  else
    raise E;
end;

{ Assertion error handler }
procedure AssertErrorHandler(const Message, Filename: string;
  LineNumber: Integer; ErrorAddr: Pointer);
begin
  if Message <> '' then
    raise EAssertionFailed.CreateFmt(SAssertError,
      [Message, Filename, LineNumber]) at ErrorAddr
  else
    raise EAssertionFailed.CreateFmt(SAssertError,
      [SAssertionFailed, Filename, LineNumber]) at ErrorAddr;
end;

{ Abstract method invoke error handler }

procedure AbstractErrorHandler;
begin
  raise EAbstractError.CreateRes(@SAbstractError);
end;

{$IFDEF LINUX}
const
  TRAP_ZERODIVIDE    = 0;
  TRAP_SINGLESTEP    = 1;
  TRAP_NMI           = 2;
  TRAP_BREAKPOINT    = 3;
  TRAP_OVERFLOW      = 4;
  TRAP_BOUND         = 5;
  TRAP_INVINSTR      = 6;
  TRAP_DEVICENA      = 7;
  TRAP_DOUBLEFAULT   = 8;
  TRAP_FPOVERRUN     = 9;
  TRAP_BADTSS        = 10;
  TRAP_SEGMENTNP     = 11;
  TRAP_STACKFAULT    = 12;
  TRAP_GPFAULT       = 13;
  TRAP_PAGEFAULT     = 14;
  TRAP_RESERVED      = 15;
  TRAP_FPE           = 16;
  TRAP_ALIGNMENT     = 17;
  TRAP_MACHINECHECK  = 18;
  TRAP_CACHEFAULT    = 19;
  TRAP_UNKNOWN       = -1;

function MapFPUStatus(Status: LongWord): TRuntimeError;
begin
  if (Status and 1) = 1 then Result := System.reInvalidOp           // STACK_CHECK or INVALID_OPERATION
  else if (Status and 2) = 2 then Result := System.reInvalidOp      // DENORMAL_OPERAND
  else if (Status and 4) = 4 then Result := System.reZeroDivide     // DIVIDE_BY_ZERO
  else if (Status and 8) = 8 then Result := System.reOverflow       // OVERFLOW
  else if (Status and $10) = $10 then Result := System.reUnderflow  // UNDERFLOW
  else if (Status and $20) = $20 then Result := System.reInvalidOp  // INEXACT_RESULT
  else Result := System.reInvalidOp;
end;

function MapFPE(Context: Psigcontext_t): TRuntimeError;
begin
  case Context^.trapno of
    TRAP_ZERODIVIDE:
      Result := System.reDivByZero;
    TRAP_FPOVERRUN:
      Result := System.reInvalidOp;
    TRAP_FPE:
      Result := MapFPUStatus(Context^.fpstate^.sw);
  else
    Result := System.reInvalidOp;
  end;
end;

function MapFault(Context: Psigcontext_t): TRuntimeError;
begin
  case Context^.trapno of
    TRAP_OVERFLOW:
      Result := System.reIntOverflow;
    TRAP_BOUND:
      Result := System.reRangeError;
    TRAP_INVINSTR:
      Result := System.rePrivInstruction; // This doesn't seem right, but we don't
                                          // have an external exception to match!
    TRAP_STACKFAULT:
      Result := System.reStackOverflow;
    TRAP_SEGMENTNP,
    TRAP_GPFAULT:
      Result := System.reAccessViolation;
    TRAP_PAGEFAULT:
      Result := System.reAccessViolation;
  else
    Result := System.reAccessViolation;
  end;
end;
{$ENDIF LINUX}

{$IFDEF MSWINDOWS}
function MapException(P: PExceptionRecord): TRuntimeError;
begin
  case P.ExceptionCode of
    STATUS_INTEGER_DIVIDE_BY_ZERO:
      Result := System.reDivByZero;
    STATUS_ARRAY_BOUNDS_EXCEEDED:
      Result := System.reRangeError;
    STATUS_INTEGER_OVERFLOW:
      Result := System.reIntOverflow;
    STATUS_FLOAT_INEXACT_RESULT,
    STATUS_FLOAT_INVALID_OPERATION,
    STATUS_FLOAT_STACK_CHECK:
      Result := System.reInvalidOp;
    STATUS_FLOAT_DIVIDE_BY_ZERO:
      Result := System.reZeroDivide;
    STATUS_FLOAT_OVERFLOW:
      Result := System.reOverflow;
    STATUS_FLOAT_UNDERFLOW,
    STATUS_FLOAT_DENORMAL_OPERAND:
      Result := System.reUnderflow;
    STATUS_ACCESS_VIOLATION:
      Result := System.reAccessViolation;
    STATUS_PRIVILEGED_INSTRUCTION:
      Result := System.rePrivInstruction;
    STATUS_CONTROL_C_EXIT:
      Result := System.reControlBreak;
    STATUS_STACK_OVERFLOW:
      Result := System.reStackOverflow;
    else
      Result := System.reExternalException;
  end;
end;

function GetExceptionClass(P: PExceptionRecord): ExceptClass;
var
  ErrorCode: Byte;
begin
  ErrorCode := Byte(MapException(P));
  Result := ExceptTypes[ExceptMap[ErrorCode].EClass];
end;

function GetExceptionObject(P: PExceptionRecord): IntPtr;
var
  ErrorCode: Integer;
  E: Exception;

  function CreateAVObject: Exception;
  var
    AccessOp: string; // string ID indicating the access type READ or WRITE
    AccessAddress: Pointer;
    MemInfo: TMemoryBasicInformation;
    ModName: array[0..MAX_PATH] of Char;
  begin
    if P^.ExceptionInformation[0] = 0 then
      AccessOp := SReadAccess
    else
      AccessOp := SWriteAccess;
    AccessAddress := Pointer(P^.ExceptionInformation[1]);
    VirtualQuery(P^.ExceptionAddress, MemInfo, SizeOf(MemInfo));
    if (MemInfo.State = MEM_COMMIT) and
       (GetModuleFileName(THandle(MemInfo.AllocationBase), ModName, Length(ModName)) <> 0) then
      Result := EAccessViolation.CreateFmt(sModuleAccessViolation,
        [P^.ExceptionAddress, ExtractFileName(ModName), AccessOp, AccessAddress])
    else
      Result := EAccessViolation.CreateFmt(SAccessViolationArg3,
        [P^.ExceptionAddress, AccessOp, AccessAddress]);
  end;

begin
  ErrorCode := Byte(MapException(P));
  case ErrorCode of
    3..10, 12..21:
      E := ExceptTypes[ExceptMap[ErrorCode].EClass].Create(ExceptMap[ErrorCode].EIdent);
    11: E := CreateAVObject;
  else
    E := EExternalException.CreateFmt(SExternalException, [P.ExceptionCode]);
  end;
  if E is EExternal then EExternal(E).ExceptionRecord := P;
  E.RaisingException(P);
{$IFDEF AUTOREFCOUNT}
  E.__ObjAddRef;
{$ENDIF}
  Result := IntPtr(E);
end;

{$ENDIF MSWINDOWS}

procedure RaiseExceptObject(P: PExceptionRecord);
begin
  if TObject(P.ExceptObject) is Exception then
    Exception(P.ExceptObject).RaisingException(P);
end;

{ RTL exception handler }

procedure ExceptHandler(ExceptObject: TObject; ExceptAddr: Pointer); far;
begin
  ShowException(ExceptObject, ExceptAddr);
  Halt(1);
end;

procedure InitExceptions;
begin
  OutOfMemory := EOutOfMemory.CreateRes(@SOutOfMemory);
  InvalidPointer := EInvalidPointer.CreateRes(@SInvalidPointer);
  ErrorProc := ErrorHandler;
  ExceptProc := @ExceptHandler;
  ExceptionClass := Exception;

{$IFDEF MSWINDOWS}
  ExceptClsProc := @GetExceptionClass;
  ExceptObjProc := @GetExceptionObject;
{$ENDIF MSWINDOWS}
  RaiseExceptObjProc := @RaiseExceptObject;

  AssertErrorProc := @AssertErrorHandler;
  AbstractErrorProc := @AbstractErrorHandler;

{$IF Defined(LINUX) or Defined(MACOS)}
  if not IsLibrary then
    HookOSExceptions;
{$ENDIF LINUX or MACOS}
end;

procedure DoneExceptions;
begin
{$IFNDEF AUTOREFCOUNT}
  if Assigned(OutOfMemory) then
  begin
    OutOfMemory.AllowFree := True;
    OutOfMemory.FreeInstance;
    OutOfMemory := nil;
  end;
  if Assigned(InvalidPointer) then
  begin
    InvalidPointer.AllowFree := True;
    InvalidPointer.Free;
    InvalidPointer := nil;
  end;
{$ENDIF}
  ErrorProc := nil;
  ExceptProc := nil;
  ExceptionClass := nil;
{$IFDEF MSWINDOWS}
  ExceptClsProc := nil;
  ExceptObjProc := nil;
{$ENDIF MSWINDOWS}
  AssertErrorProc := nil;
{$IF Defined(LINUX) or Defined(MACOS)}
  if not IsLibrary then
    UnhookOSExceptions;
{$ENDIF LINUX or MACOS}
end;

class constructor Exception.Create;
begin
  InitExceptions;
end;

class destructor Exception.Destroy;
begin
  DoneExceptions;
end;

{$IFDEF MSWINDOWS}
function NewSyncWaitObj: Pointer; inline;
begin
  Result := Pointer(CreateEvent(nil, False, False, nil));
end;

procedure DeleteSyncWaitObj(P: Pointer); inline;
begin
  CloseHandle(THandle(P));
end;

procedure SignalSyncWaitObj(P: Pointer); inline;
begin
  SetEvent(THandle(P));
end;

procedure ResetSyncWaitObj(P: Pointer); inline;
begin
  ResetEvent(THandle(P));
end;

function WaitForSyncWaitObj(P: Pointer; Timeout: Cardinal): Integer;
begin
  Result := WaitForSingleObject(THandle(P), Timeout);
end;
{$ENDIF}

{$IFDEF LINUX}
function NewSyncWaitObj: Pointer; inline;
begin
  PlatformNotImplemented;
end;

procedure DeleteSyncWaitObj(P: Pointer); inline;
begin
  PlatformNotImplemented;
end;

procedure SignalSyncWaitObj(P: Pointer); inline;
begin
  PlatformNotImplemented;
end;

procedure ResetSyncWaitObj(P: Pointer); inline;
begin
  PlatformNotImplemented;
end;

function WaitForSyncWaitObj(P: Pointer; Timeout: Cardinal): Integer;
begin
  PlatformNotImplemented;
end;
{$ENDIF}

{$IFDEF MACOS}
function NewSyncWaitObj: Pointer; inline;
begin
  dispatch_semaphore_t(Result) := dispatch_semaphore_create(0);
end;

procedure DeleteSyncWaitObj(P: Pointer); inline;
begin
  if P <> nil then
    dispatch_release(dispatch_semaphore_t(P));
end;

procedure SignalSyncWaitObj(P: Pointer); inline;
begin
  dispatch_semaphore_signal(dispatch_semaphore_t(P));
end;

procedure ResetSyncWaitObj(P: Pointer); inline;
begin
  // Do Nothing
end;

function WaitForSyncWaitObj(P: Pointer; Timeout: Cardinal): Integer;
begin
  Result := dispatch_semaphore_wait(dispatch_semaphore_t(P), dispatch_time(Ord(Timeout = INFINITE) * DISPATCH_TIME_FOREVER, NSEC_PER_MSEC * Timeout));
end;
{$ENDIF}

{ This section provides the required support to the TMonitor record in System. }
type
  PEventItemHolder = ^TEventItemHolder;
  TEventItemHolder = record
    Next: PEventItemHolder;
    Event: Pointer;
  end;

  TSyncEventItem = record
    Lock: Integer;
    Event: Pointer;
  end;

// EventCache and EventItemHolders are separated by the SyncEventCache array in order to ensure that they
// don't fall within the same cache line (which are typically 64bytes). This will increase performance slightly
// by keeping parallel operations separate so that when one cache-line is locked it doesn't affect the other.
// In high load situations this can have an appreciable affect.
var
  EventCache: PEventItemHolder;
  SyncEventCache: array[0..31] of TSyncEventItem;
  EventItemHolders: PEventItemHolder;

procedure Push(var Stack: PEventItemHolder; EventItem: PEventItemHolder);
var
  LStack: PEventItemHolder;
begin
  repeat
    LStack := Stack;
    EventItem.Next := LStack;
  until AtomicCmpExchange(Pointer(Stack), EventItem, LStack) = LStack;
end;

function Pop(var Stack: PEventItemHolder): PEventItemHolder;
begin
  repeat
    Result := Stack;
    if Result = nil then
      Exit;
  until AtomicCmpExchange(Pointer(Stack), Result.Next, Result) = Result;
end;

function NewSyncObj: Pointer;
var
  I: Integer;
begin
  Result := nil;
  for I := Low(SyncEventCache) to High(SyncEventCache) do
    if SyncEventCache[I].Lock = 0 then
    begin
      if AtomicCmpExchange(SyncEventCache[I].Lock, 1, 0) <> 0 then
        Continue;
      if SyncEventCache[I].Event = nil then
        SyncEventCache[I].Event := NewSyncWaitObj;
      Result := SyncEventCache[I].Event;
      Exit;
    end;
  if Result = nil then
    Result := NewSyncWaitObj;
  ResetSyncWaitObj(Result);
end;

procedure FreeSyncObj(SyncObject: Pointer);
var
  I: Integer;
begin
  for I := Low(SyncEventCache) to High(SyncEventCache) do
    if SyncEventCache[I].Event = SyncObject then
    begin
      AtomicExchange(SyncEventCache[I].Lock, 0);
      Exit;
    end;
  DeleteSyncWaitObj(SyncObject);
end;

function NewWaitObj: Pointer;
var
  EventItem: PEventItemHolder;
begin
  EventItem := Pop(EventCache);
  if EventItem <> nil then
  begin
    Result := EventItem.Event;
    EventItem.Event := nil;
    Push(EventItemHolders, EventItem);
  end else
    Result := NewSyncWaitObj;
  ResetSyncWaitObj(Result);
end;

procedure FreeWaitObj(WaitObject: Pointer);
var
  EventItem: PEventItemHolder;
begin
  EventItem := Pop(EventItemHolders);
  if EventItem = nil then
    New(EventItem);
  EventItem.Event := WaitObject;
  Push(EventCache, EventItem);
end;

function WaitOrSignalObj(SignalObject, WaitObject: Pointer; Timeout: Cardinal): Cardinal;
begin
  if (SignalObject <> nil) and (WaitObject = nil) then
  begin
    Result := 0;
    SignalSyncWaitObj(SignalObject);
  end else if (WaitObject <> nil) and (SignalObject = nil) then
    Result := WaitForSyncWaitObj(WaitObject, Timeout)
  else Result := 1;
end;

const
  MonitorSupport: TMonitorSupport = (
    NewSyncObject: NewSyncObj;
    FreeSyncObject: FreeSyncObj;
    NewWaitObject: NewWaitObj;
    FreeWaitObject: FreeWaitObj;
    WaitOrSignalObject: WaitOrSignalObj;
  );

procedure InitMonitorSupport;
begin
  System.MonitorSupport := @MonitorSupport;
end;

procedure DoneMonitorSupport;

  procedure CleanStack(Stack: PEventItemHolder);
  var
    Walker: PEventItemHolder;
  begin
    Walker := Stack;
    while Walker <> nil do
    begin
      Stack := Walker.Next;
      if Walker.Event <> nil then
        DeleteSyncWaitObj(Walker.Event);
      Dispose(Walker);
      Walker := Stack;
    end;
  end;

  procedure CleanEventList(var EventCache: array of TSyncEventItem);
  var
    I: Integer;
  begin
    for I := Low(EventCache) to High(EventCache) do
    begin
      repeat until AtomicCmpExchange(EventCache[I].Lock, 1, 0) = 0;
      if EventCache[I].Event <> nil then
        DeleteSyncWaitObj(EventCache[I].Event);
    end;
  end;

begin
  CleanStack(AtomicExchange(Pointer(EventCache), nil));
  CleanStack(AtomicExchange(Pointer(EventItemHolders), nil));
  CleanEventList(SyncEventCache);
end;

{$IFDEF MSWINDOWS}
procedure InitPlatformId;
var
  OSVersionInfo: TOSVersionInfo;
begin
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  if GetVersionEx(OSVersionInfo) then
    begin
      Win32Platform := OSVersionInfo.dwPlatformId;
      Win32MajorVersion := OSVersionInfo.dwMajorVersion;
      Win32MinorVersion := OSVersionInfo.dwMinorVersion;
      if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
        Win32BuildNumber := OSVersionInfo.dwBuildNumber and $FFFF
      else
        Win32BuildNumber := OSVersionInfo.dwBuildNumber;
      Win32CSDVersion := OSVersionInfo.szCSDVersion;
    end;
end;

function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
begin
  Result := (Win32MajorVersion > AMajor) or
            ((Win32MajorVersion = AMajor) and
             (Win32MinorVersion >= AMinor));
end;

function GetFileVersion(const AFileName: string): Cardinal;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := Cardinal(-1);
  // GetFileVersionInfo modifies the filename parameter data while parsing.
  // Copy the string const into a local variable to create a writeable copy.
  FileName := AFileName;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
          Result:= FI.dwFileVersionMS;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;
{$ENDIF MSWINDOWS}

procedure Beep;
{$IFDEF MSWINDOWS}
begin
  MessageBeep(0);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  ch: Byte;
  FileDes: Integer;
begin
  if isatty(STDERR_FILENO) = 1 then
    FileDes := STDERR_FILENO
  else
  if isatty(STDOUT_FILENO) = 1 then
    FileDes := STDOUT_FILENO
  else
  begin
    // Neither STDERR_FILENO nor STDOUT_FILENO are open
    // terminals (TTYs). It is not possible to safely
    // write the beep character.
    Exit;
  end;

  ch := Ord(#7);
  __write(FileDes, @ch, 1);
end;
{$ENDIF POSIX}


{ MBCS functions }

function ByteTypeTest(P: PByte; Index: Integer): TMbcsByteType;
{$IFDEF MSWINDOWS}
var
  I: Integer;
begin
  Result := mbSingleByte;
  if (P = nil) or (P[Index] = Ord(#$0)) then Exit;
  if (Index = 0) then
  begin
    if IsLeadChar(P[0]) then Result := mbLeadByte;
  end
  else
  begin
    I := Index - 1;
    while (I >= 0) and IsLeadChar(Byte(P[I])) do Dec(I);
    if ((Index - I) mod 2) = 0 then Result := mbTrailByte
    else if IsLeadChar(P[Index]) then Result := mbLeadByte;
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  I, L: Integer;
begin
  Result := mbSingleByte;
  if (P = nil) or (P[Index] = Ord(#$0)) then Exit;

  I := 0;
  repeat
    if IsLeadChar(P[I]) then
{$IFNDEF NEXTGEN}
      L := StrCharLength(PAnsiChar(P + I))
{$ELSE NEXTGEN}
      L := StrCharLength(PByte(P + I))
{$ENDIF !NEXTGEN}
    else
      L := 1;
    Inc(I, L);
  until (I > Index);

  if (L <> 1) then
    if (I - L = Index) then
      Result := mbLeadByte
    else
      Result := mbTrailByte;
end;
{$ENDIF POSIX}

{$IFNDEF NEXTGEN}
function ByteType(const S: AnsiString; Index: Integer): TMbcsByteType;
begin
  Result := mbSingleByte;
  if SysLocale.FarEast then
    Result := ByteTypeTest(PByte(MarshaledAString(S)), Index-1);
end;
{$ENDIF !NEXTGEN}

function ByteType(const S: UnicodeString; Index: Integer): TMbcsByteType;
begin
  Result := mbSingleByte;
  if (Index >= Low(string)) and (Index <= High(S)) and IsLeadChar(S[Index]) then
    if (S[Index] >= #$D800) and (S[Index] <= #$DBFF) then
      Result := mbLeadByte
    else
      Result := mbTrailByte;
end;

{$IFNDEF NEXTGEN}
function StrByteType(Str: PAnsiChar; Index: Cardinal): TMbcsByteType;
begin
  Result := mbSingleByte;
  if SysLocale.FarEast then
    Result := ByteTypeTest(PByte(Str), Index);
end;
{$ENDIF !NEXTGEN}

function StrByteType(Str: PWideChar; Index: Cardinal): TMbcsByteType;
begin
  Result := mbSingleByte;
  if IsLeadChar(Str[Index - 1]) then
    if (Str[Index - 1] >= #$D800) and (Str[Index - 1] <= #$DBFF) then
      Result := mbLeadByte
    else
      Result := mbTrailByte;
end;

{$IFNDEF NEXTGEN}
function AnsiNextCharIndex(const S: AnsiString; Index: Integer): Integer;
begin
  Result := Index + 1;
  assert((Index > 0) and (Index <= Length(S)));
  if IsLeadChar(S[Index]) then
    Result := Index + StrCharLength(PAnsiChar(S) + Index - 1);
end;
{$ENDIF !NEXTGEN}

{$IFNDEF NEXTGEN}
function ElementToCharLen(const S: AnsiString; MaxLen: Integer): Integer;
begin
  if Length(S) < MaxLen then MaxLen := Length(S);
  Result := ByteToCharIndex(S, MaxLen);
end;
{$ENDIF !NEXTGEN}

function ElementToCharLen(const S: UnicodeString; MaxLen: Integer): Integer;
begin
  if Length(S) < MaxLen then MaxLen := Length(S);
  Result := ByteToCharIndex(S, MaxLen);
end;

function ByteToCharLen(const S: UnicodeString; MaxLen: Integer): Integer;
begin
  Result := ElementToCharLen(S, MaxLen);
end;

{$IFNDEF NEXTGEN}
function ByteToCharLen(const S: AnsiString; MaxLen: Integer): Integer;
begin
  Result := ElementToCharLen(S, MaxLen);
end;

function ElementToCharIndex(const S: AnsiString; Index: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  if (Index <= 0) or (Index > Length(S)) then Exit;
  Result := Index;
  if not SysLocale.FarEast then Exit;
  I := 1;
  Result := 0;
  while I <= Index do
  begin
    if IsLeadChar(S[I]) then
      I := AnsiNextCharIndex(S, I)
    else
      Inc(I);
    Inc(Result);
  end;
end;
{$ENDIF !NEXTGEN}

function ElementToCharIndex(const S: UnicodeString; Index: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  if (Index <= 0) or (Index > Length(S)) then
    Exit;
  I := 1;
  while I <= Index do
  begin
    if IsLeadChar(S[I]) then
      I := NextCharIndex(S, I)
    else
      Inc(I);
    Inc(Result);
  end;
end;

function ByteToCharIndex(const S: UnicodeString; Index: Integer): Integer;
begin
  Result := ElementToCharIndex(S, Index);
end;

{$IFNDEF NEXTGEN}
function ByteToCharIndex(const S: AnsiString; Index: Integer): Integer;
begin
  Result := ElementToCharIndex(S, Index);
end;

procedure CountChars(const S: AnsiString; MaxChars: Integer; var CharCount, ByteCount: Integer); overload;
var
  C, L, B: Integer;
begin
  L := Length(S) * SizeOf(Char);
  C := 1;
  B := 1;
  while (B < L) and (C < MaxChars) do
  begin
    Inc(C);
    if IsLeadChar(S[B]) then
      B := AnsiNextCharIndex(S, B)
    else
      Inc(B);
  end;
  if (C = MaxChars) and (B < L) and IsLeadChar(S[B]) then
    B := AnsiNextCharIndex(S, B) - 1;
  CharCount := C;
  ByteCount := B;
end;
{$ENDIF !NEXTGEN}

procedure CountChars(const S: UnicodeString; MaxChars: Integer; var CharCount, ByteCount: Integer); overload;
var
  C, L, I: Integer;
begin
  L := Length(S);
  C := 1;
  I := 1;
  while (I < L) and (C < MaxChars) do
  begin
    Inc(C);
    if IsLeadChar(S[I]) then
    begin
      Inc(I, 2); //Jump the trailing surrogate
      if I > L then
      begin
        Dec(C);
        Dec(I);
      end;
    end
    else
      Inc(I);
  end;
  if (C = MaxChars) and (I < L) and IsLeadChar(S[I]) then
    I := NextCharIndex(S, I) - 1;

  CharCount := C;
  ByteCount := I;
end;

{$IFNDEF NEXTGEN}
function CharToElementIndex(const S: AnsiString; Index: Integer): Integer;
var
  Chars: Integer;
begin
  Result := 0;
  if (Index <= 0) or (Index > Length(S)) then Exit;
  if (Index > 1) and SysLocale.FarEast then
  begin
    CountChars(S, Index-1, Chars, Result);
    if (Chars < (Index-1)) or (Result >= Length(S)) then
      Result := 0  // Char index out of range
    else
      Inc(Result);
  end
  else
    Result := Index;
end;
{$ENDIF !NEXTGEN}

function CharToElementIndex(const S: UnicodeString; Index: Integer): Integer;
var
  Chars: Integer;
begin
  Result := 0;
  if (Index <= 0) or (Index > Length(S)) then
    Exit;
  CountChars(S, Index-1, Chars, Result);
  if (Chars < (Index-1)) or ((Result >= Length(S)) and
     not ((Result = 1) and (Result <= Length(S)))) then
    Result := 0  // Char index out of range
  else if (Index > 1) then
    Inc(Result);
end;

function CharToByteIndex(const S: UnicodeString; Index: Integer): Integer;
begin
  Result := CharToElementIndex(S, Index);
end;

{$IFNDEF NEXTGEN}
function CharToByteIndex(const S: AnsiString; Index: Integer): Integer;
begin
  Result := CharToElementIndex(S, Index);
end;

function CharToElementLen(const S: AnsiString; MaxLen: Integer): Integer;
var
  Chars: Integer;
begin
  Result := 0;
  if MaxLen <= 0 then Exit;
  if MaxLen > Length(S) then MaxLen := Length(S);
  if SysLocale.FarEast then
  begin
    CountChars(S, MaxLen, Chars, Result);
    if Result > Length(S) then
      Result := Length(S);
  end
  else
    Result := MaxLen;
end;
{$ENDIF !NEXTGEN}

function CharToElementLen(const S: UnicodeString; MaxLen: Integer): Integer;
var
  Chars: Integer;
begin
  Result := 0;
  if MaxLen <= 0 then Exit;
  if MaxLen > Length(S) then MaxLen := Length(S);
  CountChars(S, MaxLen, Chars, Result);
  if Result > Length(S) * SizeOf(Char) then
    Result := Length(S) * SizeOf(Char);
end;

{$IFNDEF NEXTGEN}
function CharToByteLen(const S: AnsiString; MaxLen: Integer): Integer;
begin
  Result := CharToElementLen(S, MaxLen);
end;
{$ENDIF !NEXTGEN}

function CharToByteLen(const S: UnicodeString; MaxLen: Integer): Integer;
begin
  Result := CharToElementLen(S, MaxLen);
end;

{ MBCS Helper functions }

{$IFNDEF NEXTGEN}
function StrCharLength(const Str: MarshaledAString): Integer;
const
  chZERO: AnsiChar = #0;
{$ELSE}
function StrCharLength(const Str: PByte): Integer;
const
  chZERO: Byte = 0;
{$ENDIF !NEXTGEN}
{$IFDEF MSWINDOWS}
begin
  if SysLocale.FarEast and (Str^ <> chZERO) then
//    Result := IntPtr(CharNextA(MarshaledAString(Str))) - IntPtr(Str)
    Result := IntPtr(AnsiNext(MarshaledAString(Str))) - IntPtr(Str)
  else
    Result := 1;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := mblen(MarshaledAString(Str), MB_CUR_MAX);
  if Result <= 0 then Result := 1;
end;
{$ENDIF POSIX}

function StrCharLength(const Str: PWideChar): Integer;
begin
  if (Str^ >= #$D800) and (Str^ <= #$DBFF) and
     (Str[1] >= #$DC00) and (Str[1] <= #$DFFF) then
    Result := SizeOf(WideChar) * 2
  else
    Result := SizeOf(WideChar);
end;

{$IFNDEF NEXTGEN}
function StrNextChar(const Str: PAnsiChar): PAnsiChar;
{$IFDEF MSWINDOWS}
begin
  Result := CharNextA(Str);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := Str + StrCharLength(Str);
end;
{$ENDIF POSIX}
{$ENDIF !NEXTGEN}

function StrNextChar(const Str: PWideChar): PWideChar;
begin
  Result := Str;
  if (Result^ >= #$D800) and (Result^ <= #$DBFF) and
     (Result[1] >= #$DC00) and (Result[1] <= #$DFFF) then
    Inc(Result, 2)
  else if Result^ <> #0 then
    Inc(Result, 1);
end;

function CharLength(const S: UnicodeString; Index: Integer): Integer;
begin
  Result := SizeOf(WideChar);
  assert((Index > 0) and (Index <= Length(S)));
  if IsLeadChar(S[Index]) then
    Result := StrCharLength(PWideChar(S) + Index - 1);
end;

function NextCharIndex(const S: UnicodeString; Index: Integer): Integer;
begin
  Result := Index + 1;
  assert((Index >= Low(string)) and (Index <= High(S)));
  if IsLeadChar(S[Index]) then
    Result := Index + StrCharLength(PWideChar(S) + Index - Low(string)) div SizeOf(WideChar);
end;

function IsPathDelimiter(const S: string; Index: Integer): Boolean;
begin
  Result := (Index >= Low(string)) and (Index <= High(S)) and (S[Index] = PathDelim)
    and (ByteType(S, Index) = mbSingleByte);
end;

function IsDelimiter(const Delimiters, S: string; Index: Integer): Boolean;
begin
  Result := False;
  if (Index <= 0) or (Index > S.Length) or (ByteType(S, Index) <> mbSingleByte) then exit;
  Result := StrScan(PChar(Delimiters), S.Chars[Index-1]) <> nil;
end;

function IncludeTrailingBackslash(const S: string): string;
begin
  Result := IncludeTrailingPathDelimiter(S);
end;

function IncludeTrailingPathDelimiter(const S: string): string;
begin
  Result := S;
  if not IsPathDelimiter(Result, High(Result)) then
    Result := Result + PathDelim;
end;

function ExcludeTrailingBackslash(const S: string): string;
begin
  Result := ExcludeTrailingPathDelimiter(S);
end;

function ExcludeTrailingPathDelimiter(const S: string): string;
begin
  Result := S;
  if IsPathDelimiter(Result, High(Result)) then
    SetLength(Result, Length(Result)-1);
end;

function AnsiPos(const Substr, S: string): Integer;
var
  P: PChar;
begin
  Result := 0;
{$IFDEF UNICODE}
  P := StrPosLen(PChar(S), PChar(SubStr), Length(S), Length(SubStr));
{$ELSE}
  P := AnsiStrPos(PChar(S), PChar(SubStr));
{$ENDIF}
  if P <> nil then
    Result := (IntPtr(P) - IntPtr(PChar(S))) div SizeOf(Char) + 1;
end;

{$IFDEF MACOS}
function CompareFileSystemStrings(const LS1, LS2: string): Integer;
var
  StringRef1, StringRef2: CFStringRef;
  MutableStringRef1, MutableStringRef2: CFMutableStringRef;
  M: TMarshaller;
begin
  Result := -1;
  StringRef1 := CFStringCreateWithFileSystemRepresentation(kCFAllocatorDefault, M.AsAnsi(LS1, CP_UTF8).ToPointer);
  if StringRef1 <> nil then
  try
    MutableStringRef1 := CFStringCreateMutableCopy(kCFAllocatorDefault,
      CFStringGetLength(StringRef1), StringRef1);
    if MutableStringRef1 <> nil then
    try
      StringRef2 := CFStringCreateWithFileSystemRepresentation(kCFAllocatorDefault, M.AsAnsi(LS2, CP_UTF8).ToPointer);
      if StringRef2 <> nil then
      try
        MutableStringRef2 := CFStringCreateMutableCopy(kCFAllocatorDefault,
          CFStringGetLength(StringRef2), StringRef2);

        if MutableStringRef2 <> nil then
        try
          CFStringNormalize(MutableStringRef1, kCFStringNormalizationFormKC);
          CFStringFold(MutableStringRef1, kCFCompareLocalized, nil);
          CFStringNormalize(MutableStringRef2, kCFStringNormalizationFormKC);
          CFStringFold(MutableStringRef2, kCFCompareLocalized, nil);

          Result := CFStringCompareWithOptionsAndLocale(CFStringRef(MutableStringRef1), CFStringRef(MutableStringRef2),
            CFRangeMake(0, CFStringGetLength(CFStringRef(MutableStringRef1))), 0, UTF8CompareLocale);
        finally
          CFRelease(MutableStringRef2);
        end else
          raise ECFError.Create(SCFStringFailed);
      finally
        CFRelease(StringRef2);
      end else
        raise ECFError.Create(SCFStringFailed);
    finally
      CFRelease(MutableStringRef1);
    end else
      raise ECFError.Create(SCFStringFailed);
  finally
    CFRelease(StringRef1);
  end else
    raise ECFError.Create(SCFStringFailed);
end;
{$ENDIF}

function AnsiCompareFileName(const S1, S2: string; CheckVolumeCase: Boolean): Integer;
  function IsVolumeCaseSensitive(Path: string): Boolean;
  begin
    if Path = '' then
      Path := GetCurrentDir;
    while (Path <> '') and not DirectoryExists(Path) do
      Path := ExtractFilePath(ExcludeTrailingPathDelimiter(Path)); // Move up a directory
    if Path <> '' then
      Exit(fsCaseSensitive in FileSystemAttributes(Path));
    // Path was not found, so assume the default
{$IFDEF LINUX}
    Result := True;
{$ELSE}
    Result := False;
{$ENDIF}
  end;

var
  LS1, LS2: string;
begin
  if CheckVolumeCase then
  begin
    if IsVolumeCaseSensitive(ExtractFilePath(S1)) or
       IsVolumeCaseSensitive(ExtractFilePath(S2)) then
    begin
      LS1 := S1;
      LS2 := S2;
    end
    else
    begin
      LS1 := AnsiLowerCase(S1);
      LS2 := AnsiLowerCase(S2);
    end;
  end
  else // not CheckVolumeCase
  begin
{$IFDEF LINUX}
    LS1 := S1;
    LS2 := S2;
{$ELSE}
    LS1 := AnsiLowerCase(S1);
    LS2 := AnsiLowerCase(S2);
{$ENDIF}
  end;
{$IFNDEF MACOS}
  Result := CompareStr(LS1, LS2);
{$ELSE MACOS}
  Result := CompareFileSystemStrings(LS1, LS2);
{$ENDIF MACOS}
end;

function SameFileName(const S1, S2: string): Boolean;
begin
  Result := AnsiCompareFileName(S1, S2) = 0;
end;

function AnsiLowerCaseFileName(const S: string): string;
begin
  Result := AnsiLowerCase(S); // Use "platform" lower casing which works for all locales in unicode
end;

function AnsiUpperCaseFileName(const S: string): string;
begin
  Result := AnsiUpperCase(S);  // Use "platform" upper casing which works for all locales in unicode
end;

{$IFNDEF NEXTGEN}
function TextPos(Str, SubStr: PAnsiChar): PAnsiChar;
var
  LowerStr, LowerSubStr: PAnsiChar;
begin
  LowerSubStr := nil;
  LowerStr := StrLower(StrNew(Str));
  try
    LowerSubStr := StrLower(StrNew(SubStr));
    Result := StrPos(LowerStr, LowerSubStr);
    if Result <> nil then
      Result := PAnsiChar(PByte(Str) + (PByte(Result) - PByte(LowerStr)));
  finally
    StrDispose(LowerSubStr);
    StrDispose(LowerStr);
  end;
end;
{$ENDIF !NEXTGEN}

function TextPos(Str, SubStr: PWideChar): PWideChar;
var
  LowerStr, LowerSubStr: PWideChar;
begin
  LowerSubStr := nil;
  LowerStr := StrLower(StrNew(Str));
  try
    LowerSubStr := StrLower(StrNew(SubStr));
    Result := StrPos(LowerStr, LowerSubStr);
    if Result <> nil then
      Result := PWideChar(PByte(Str) + (PByte(Result) - PByte(LowerStr)));
  finally
    StrDispose(LowerSubStr);
    StrDispose(LowerStr);
  end;
end;

{$IFNDEF NEXTGEN}
function AnsiStrPos(Str, SubStr: PAnsiChar): PAnsiChar;
var
  L1, L2: Cardinal;
  ByteType : TMbcsByteType;
begin
  Result := nil;
  if (Str = nil) or (Str^ = #0) or (SubStr = nil) or (SubStr^ = #0) then Exit;
  L1 := StrLen(Str);
  L2 := StrLen(SubStr);
  Result := StrPos(Str, SubStr);
  while (Result <> nil) and ((L1 - Cardinal(Result - Str)) >= L2) do
  begin
    ByteType := StrByteType(Str, Integer(Result-Str));
{$IFDEF MSWINDOWS}
    if (ByteType <> mbTrailByte) and
      (CompareStringA(LOCALE_USER_DEFAULT, 0, Result, L2, SubStr, L2) = CSTR_EQUAL) then Exit;
    if (ByteType = mbLeadByte) then Inc(Result);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    if (ByteType <> mbTrailByte) and
      (strncmp(Result, SubStr, L2) = 0) then Exit;
{$ENDIF POSIX}
    Inc(Result);
    Result := StrPos(Result, SubStr);
  end;
  Result := nil;
end;
{$ENDIF !NEXTGEN}

function AnsiStrPos(Str, SubStr: PWideChar): PWideChar;
begin
  Result := StrPos(Str, SubStr);
end;

{$IFNDEF NEXTGEN}
function AnsiStrRScan(Str: PAnsiChar; Chr: AnsiChar): PAnsiChar;
begin
  Str := AnsiStrScan(Str, Chr);
  Result := Str;
  if Chr <> AnsiChar(#$0) then
  begin
    while Str <> nil do
    begin
      Result := Str;
      Inc(Str);
      Str := AnsiStrScan(Str, Chr);
    end;
  end
end;
{$ENDIF !NEXTGEN}

function AnsiStrRScan(Str: PWideChar; Chr: WideChar): PWideChar;
begin
  Result := StrRScan(Str, Chr);
end;

{$IFNDEF NEXTGEN}
function AnsiStrScan(Str: PAnsiChar; Chr: AnsiChar): PAnsiChar;
begin
  Result := StrScan(Str, Chr);
  while Result <> nil do
  begin
{$IFDEF MSWINDOWS}
    case StrByteType(Str, Integer(Result-Str)) of
      mbSingleByte: Exit;
      mbLeadByte: Inc(Result);
    end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    if StrByteType(Str, Integer(Result-Str)) = mbSingleByte then Exit;
{$ENDIF POSIX}
    Inc(Result);
    Result := StrScan(Result, Chr);
  end;
end;
{$ENDIF !NEXTGEN}

function AnsiStrScan(Str: PWideChar; Chr: WideChar): PWideChar;
begin
  Result := StrScan(Str, Chr);
end;

{$IFDEF MSWINDOWS}
function LCIDToCodePage(const ALCID: LCID): Integer;
var
  Buffer: array [0..6] of Char;
begin
  GetLocaleInfo(ALcid, LOCALE_IDEFAULTANSICODEPAGE, Buffer, Length(Buffer));
  Result:= StrToIntDef(Buffer, GetACP);
end;
{$ENDIF MSWINDOWS}

procedure InitSysLocale;
{$IFDEF MSWINDOWS}
var
  DefaultLCID: LCID;
  DefaultLangID: LANGID;
  AnsiCPInfo: TCPInfo;

  procedure InitLeadBytes;
  var
    I: Integer;
    J: Byte;
  begin
    GetCPInfo(CP_ACP, AnsiCPInfo);
    I := 0;
    while (I < MAX_LEADBYTES) and ((AnsiCPInfo.LeadByte[I] or AnsiCPInfo.LeadByte[I + 1]) <> 0) do
    begin
      for J := AnsiCPInfo.LeadByte[I] to AnsiCPInfo.LeadByte[I + 1] do
{$IFNDEF NEXTGEN}
        Include(LeadBytes, AnsiChar(J));
{$ELSE NEXTGEN}
        Include(LeadBytes, J);
{$ENDIF !NEXTGEN}
      Inc(I, 2);
    end;
  end;

begin
  { Set default to English (US). }
  SysLocale.DefaultLCID := $0409;
  SysLocale.PriLangID := LANG_ENGLISH;
  SysLocale.SubLangID := SUBLANG_ENGLISH_US;

  DefaultLCID := GetThreadLocale;
  if DefaultLCID <> 0 then SysLocale.DefaultLCID := DefaultLCID;

  DefaultLangID := Word(DefaultLCID);
  if DefaultLangID <> 0 then
  begin
    SysLocale.PriLangID := DefaultLangID and $3ff;
    SysLocale.SubLangID := DefaultLangID shr 10;
  end;

  LeadBytes := [];
  SysLocale.MiddleEast := True;

{$IF DEFINED(UNICODE)}
  SysLocale.FarEast := True;
{$ELSE}
  SysLocale.FarEast := GetSystemMetrics(SM_DBCSENABLED) <> 0;
{$ENDIF}
  if SysLocale.FarEast then
    InitLeadBytes;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  LeadBytes := [];
  SysLocale.MiddleEast := True;
  SysLocale.FarEast := True;
end;
{$ENDIF POSIX}

procedure GetFormatSettings;
begin
  InitSysLocale;
  if SysLocale.FarEast then
    GetEraNamesAndYearOffsets;
  FormatSettings := TFormatSettings.Create('');
end;

procedure GetLocaleFormatSettings(Locale: TLocaleID; var AFormatSettings: TFormatSettings);
begin
  AFormatSettings := TFormatSettings.Create(Locale);
end;


function StringReplace(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := AnsiUpperCase(S);
    Patt := AnsiUpperCase(OldPattern);
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := AnsiPos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function WrapText(const Line, BreakStr: string; const BreakChars: TSysCharSet;
  MaxCol: Integer): string;
const
  QuoteChars = ['''', '"'];
  FirstIndex = Low(string);
  StrAdjust = 1 - Low(string);
var
  Col, Pos: Integer;
  LinePos: Integer;
  BreakLen, BreakPos: Integer;
  QuoteChar, CurChar: Char;
  ExistingBreak: Boolean;
  L: Integer;
begin
  Col := FirstIndex;
  Pos := FirstIndex;
  LinePos := FirstIndex;
  BreakPos := 0;
  QuoteChar := #0;
  ExistingBreak := False;
  BreakLen := BreakStr.Length;
  Result := '';
  while Pos <= High(Line) do
  begin
    CurChar := Line[Pos];
    if IsLeadChar(CurChar) then
    begin
      L := CharLength(Line, Pos) div SizeOf(Char) - 1;
      Inc(Pos, L);
      Inc(Col, L);
    end
    else
    begin
    if CurChar in QuoteChars then
      if QuoteChar = #0 then
        QuoteChar := CurChar
      else if CurChar = QuoteChar then
        QuoteChar := #0;
    if QuoteChar = #0 then
    begin
      if CurChar = BreakStr[FirstIndex] then
      begin
        ExistingBreak := StrLComp(PChar(BreakStr), PChar(@Line[Pos]), BreakLen) = 0;
        if ExistingBreak then
        begin
          Inc(Pos, BreakLen-1);
          BreakPos := Pos;
        end;
      end;

      if not ExistingBreak then
        if CurChar in BreakChars then
          BreakPos := Pos;
      end;
    end;

    Inc(Pos);
    Inc(Col);

    if not (QuoteChar in QuoteChars) and (ExistingBreak or
      ((Col > MaxCol - StrAdjust) and (BreakPos > LinePos))) then
    begin
      Col := FirstIndex;
      Result := Result + Line.SubString(LinePos - FirstIndex, BreakPos - LinePos + 1);
      if not (CurChar in QuoteChars) then
      begin
        while Pos <= High(Line) do
        begin
          if Line[Pos] in BreakChars then
          begin
            Inc(Pos);
            ExistingBreak := False;
          end
          else
          begin
            if StrLComp(PChar(@Line[Pos]), sLineBreak, Length(sLineBreak)) = 0 then
            begin
              Inc(Pos, Length(sLineBreak));
              ExistingBreak := True;
            end
            else
              Break;
          end;
        end;
      end;
      if (Pos <= High(Line)) and not ExistingBreak then
        Result := Result + BreakStr;

      Inc(BreakPos);
      LinePos := BreakPos;
      Pos := LinePos;
      ExistingBreak := False;
    end;
  end;
  Result := Result + Line.SubString(LinePos - FirstIndex);
end;

function WrapText(const Line: string; MaxCol: Integer): string;
begin
  Result := WrapText(Line, sLineBreak, [' ', '-', #9], MaxCol); { do not localize }
end;

function FindCmdLineSwitch(const Switch: string; const Chars: TSysCharSet;
  IgnoreCase: Boolean): Boolean;
var
  I: Integer;
  S: string;
begin
  for I := 1 to ParamCount do
  begin
    S := ParamStr(I);
    if (Chars = []) or (S[1] in Chars) then
      if IgnoreCase then
      begin
        if (AnsiCompareText(Copy(S, 2, Maxint), Switch) = 0) then
        begin
          Result := True;
          Exit;
        end;
      end
      else begin
        if (AnsiCompareStr(Copy(S, 2, Maxint), Switch) = 0) then
        begin
          Result := True;
          Exit;
        end;
      end;
  end;
  Result := False;
end;

function FindCmdLineSwitch(const Switch: string): Boolean;
begin
  Result := FindCmdLineSwitch(Switch, SwitchChars, True);
end;

function FindCmdLineSwitch(const Switch: string; IgnoreCase: Boolean): Boolean;
begin
  Result := FindCmdLineSwitch(Switch, SwitchChars, IgnoreCase);
end;

function FindCmdLineSwitch(const Switch: string; var Value: string; IgnoreCase: Boolean = True;
  const SwitchTypes: TCmdLineSwitchTypes = [clstValueNextParam, clstValueAppended]): Boolean; overload;
type
  TCompareProc = function(const S1, S2: string): Boolean;
var
  Param: string;
  I, ValueOfs,
  SwitchLen, ParamLen: Integer;
  SameSwitch: TCompareProc;
begin
  Result := False;
  Value := '';
  if IgnoreCase then
    SameSwitch := SameText else
    SameSwitch := SameStr;
  SwitchLen := Switch.Length;

  for I := 1 to ParamCount do
  begin
    Param := ParamStr(I);
    if CharInSet(Param.Chars[0], SwitchChars) and SameSwitch(Param.SubString(1,SwitchLen), Switch) then
    begin
      ParamLen := Param.Length;
      // Look for an appended value if the param is longer than the switch
      if (ParamLen > SwitchLen + 1) then
      begin
        // If not looking for appended value switches then this is not a matching switch
        if not (clstValueAppended in SwitchTypes) then
          Continue;
        ValueOfs := SwitchLen + 1;
        if Param.Chars[ValueOfs] = ':' then
          Inc(ValueOfs);
        Value := Param.SubString(ValueOfs, MaxInt);
      end
      // If the next param is not a switch, then treat it as the value
      else if (clstValueNextParam in SwitchTypes) and (I < ParamCount) and
              not CharInSet(ParamStr(I+1).Chars[0], SwitchChars) then
        Value := ParamStr(I+1);
      Result := True;
      Break;
    end;
  end;
end;

{$IFNDEF NEXTGEN}
{ Package info structures }

type
  PPkgName = ^TPkgName;
  TPkgName = packed record
    HashCode: Byte;
    Name: array[0..255] of AnsiChar;
  end;

  { PackageUnitFlags:
    bit      meaning
    -----------------------------------------------------------------------------------------
    0      | main unit
    1      | package unit (dpk source)
    2      | $WEAKPACKAGEUNIT unit
    3      | original containment of $WEAKPACKAGEUNIT (package into which it was compiled)
    4      | implicitly imported
    5..7   | reserved
  }
  PUnitName = ^TUnitName;
  TUnitName = packed record
    Flags : Byte;
    HashCode: Byte;
    Name: array[0..255] of AnsiChar;
  end;

  { Package flags:
    bit     meaning
    -----------------------------------------------------------------------------------------
    0     | 1: never-build                  0: always build
    1     | 1: design-time only             0: not design-time only      on => bit 2 = off
    2     | 1: run-time only                0: not run-time only         on => bit 1 = off
    3     | 1: do not check for dup units   0: perform normal dup unit check
    4..25 | reserved
    26..27| (producer) 0: pre-V4, 1: undefined, 2: c++, 3: Pascal
    28..29| reserved
    30..31| 0: EXE, 1: Package DLL, 2: Library DLL, 3: undefined
  }
  PPackageInfoHeader = ^TPackageInfoHeader;
  TPackageInfoHeader = packed record
    Flags: Cardinal;
    RequiresCount: Integer;
    {Requires: array[0..9999] of TPkgName;
    ContainsCount: Integer;
    Contains: array[0..9999] of TUnitName;}
  end;

const
  cBucketSize = 1021; // better distribution than 1024

type
  PUnitHashEntry = ^TUnitHashEntry;
  TUnitHashEntry = record
    Next, Prev: PUnitHashEntry;
    LibModule: PLibModule;
    UnitName: PAnsiChar;
    DupsAllowed: Boolean;
    FullHash: Cardinal;
  end;
  TUnitHashArray = TArray<TUnitHashEntry>;
  TUnitHashBuckets = array[0..cBucketSize-1] of PUnitHashEntry;

  PModuleInfo = ^TModuleInfo;
  TModuleInfo = record
    Validated: Boolean;
    UnitHashArray: TUnitHashArray;
  end;

var
  SysInitHC: Cardinal;
  ValidatedUnitHashBuckets: TUnitHashBuckets;
  UnitHashBuckets: TUnitHashBuckets;

{$ENDIF !NEXTGEN}

//Rewrote using UnicodeFromLocalChars which is a wrapper for MultiByteToWideChar on Windows and emulates it on non windows
function HashNameMBCS(Name: MarshaledAString): Cardinal;
const
  BufferLen = MAX_PATH;
var
  Len, NameLen: Cardinal;
  Data: PWideChar;
  Buffer: array[0..BufferLen - 1] of WideChar;
  I: Integer;
begin
  NameLen := Length(Name);
  Len := UnicodeFromLocaleChars(CP_UTF8, 0, Name, NameLen, nil, 0);
  if Len > BufferLen then
    GetMem(Data, Len * SizeOf(Char))
  else
    Data := @Buffer[0];

  UnicodeFromLocaleChars(CP_UTF8, 0, Name, NameLen, Data, Len);
  AnsiStrUpper(Data);

  Result := 0;
  for I := 0 to Len - 1 do
  begin
    Result := (Result shl 5) or (Result shr 27); //ROL Result, 5
    Result := Result xor Cardinal(Data[I]);
  end;

  if Data <> @Buffer[0] then
    FreeMem(Data);
end;

function HashName(Name: MarshaledAString): Cardinal;
{$IFDEF PUREPASCAL}
var
  LCurr: MarshaledAString;
begin
  { ESI -> Name }
  Result := 0;
  LCurr := Name;

  while LCurr^ <> #0 do
  begin
    { Abort on a MBCS character }
    if Ord(LCurr^) > 127 then
    begin
      Result := HashNameMBCS(LCurr);
      Exit;
    end;

    { Update the hash. Lowercase the uppercased charaters in the process }
    if LCurr^ in ['A' .. 'Z'] then
      Result := Result xor (Ord(LCurr^) or $20)
    else
      Result := Result xor Ord(LCurr^);

    { Go to next }
    Inc(LCurr);

    { Update the hashed value }
    Result := (Result shr 27) or (Result shl 5);
  end;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
        PUSH  ESI
        PUSH  EBX
        MOV   ESI, Name
        XOR   EAX, EAX
        PUSH  ESI

@@loop:
        ROL   EAX, 5
        MOV   BL, [ESI]
        TEST  BL, $80   // abort if there is a multibyte character and call HashNameMBCS
        JNZ   @@MBCS
        CMP   BL, 0
        JE    @@done
        CMP   BL, 'A'
        JL    @@LowerCased
        CMP   BL, 'Z'
        JG    @@LowerCased
        OR    BL, 20H // make lower case
@@LowerCased:
        XOR   AL, BL
        INC   ESI
        JMP   @@loop
@@done:
        POP   ECX
        POP   EBX
        POP   ESI
        RET
@@MBCS:
        POP   EAX
        POP   EBX
        POP   ESI
        JMP   HashNameMBCS
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

{$IFNDEF NEXTGEN}

procedure ClearHashTables;
var
  Module: PLibModule;
begin
  Module := LibModuleList;
  while Module <> nil do
  begin
    if Module.Reserved <> 0 then
    begin
      Dispose(PModuleInfo(Module.Reserved));
      Module.Reserved := 0;
    end;
    Module := Module.Next;
  end;
end;

function FindLibModule(Module: HModule): PLibModule; inline;
begin
  Result := LibModuleList;
  while Result <> nil do
  begin
    if Result.Instance = Cardinal(Module) then Exit;
    Result := Result.Next;
  end;
end;

procedure ModuleUnloaded(Module: HINST);
var
  LibModule: PLibModule;
  ModuleInfo: PModuleInfo;
  I: Integer;
  HC: Cardinal;
  Buckets: ^TUnitHashBuckets;
begin
  LibModule := FindLibModule(Module);
  if (LibModule <> nil) and (LibModule.Reserved <> 0) then
  begin
    ModuleInfo := PModuleInfo(LibModule.Reserved);
    if ModuleInfo.Validated then
      Buckets := @ValidatedUnitHashBuckets
    else
      Buckets := @UnitHashBuckets;
    for I := Low(ModuleInfo.UnitHashArray) to High(ModuleInfo.UnitHashArray) do
    begin
      if ModuleInfo.UnitHashArray[I].Prev <> nil then
        ModuleInfo.UnitHashArray[I].Prev.Next := ModuleInfo.UnitHashArray[I].Next
      else if ModuleInfo.UnitHashArray[I].UnitName <> nil then
      begin
        HC := HashName(ModuleInfo.UnitHashArray[I].UnitName) mod cBucketSize;
        if Buckets[HC] = @ModuleInfo.UnitHashArray[I] then
          Buckets[HC] := ModuleInfo.UnitHashArray[I].Next;
      end;
      if ModuleInfo.UnitHashArray[I].Next <> nil then
        ModuleInfo.UnitHashArray[I].Next.Prev := ModuleInfo.UnitHashArray[I].Prev;
    end;
    Dispose(ModuleInfo);
    LibModule.Reserved := 0;
  end;
end;

function PackageInfoTable(Module: HMODULE): PPackageInfoHeader;
var
  ResInfo: HRSRC;
  Data: THandle;
begin
  Result := nil;
  ResInfo := FindResource(Module, 'PACKAGEINFO', RT_RCDATA);
  if ResInfo <> 0 then
  begin
    Data := LoadResource(Module, ResInfo);
    if Data <> 0 then
    try
      Result := LockResource(Data);
      UnlockResource(Data);
    finally
      FreeResource(Data);
    end;
  end;
end;

procedure CheckForDuplicateUnits(Module: HMODULE; AValidatePackage: TValidatePackageProc);
var
  ModuleFlags: Cardinal;

  function IsUnitPresent(UnitName: PAnsiChar; HashCode: Cardinal; Module: HMODULE;
    const Buckets: TUnitHashBuckets; const ModuleName: UTF8String;
    var UnitPackage: string; ModuleHashCode: Cardinal): Boolean;
  var
    HashEntry: PUnitHashEntry;
  begin
    if ((HashCode <> SysInitHC) or (StrIComp(UnitName, PAnsiChar('SysInit')) <> 0)) and
    ((HashCode <> ModuleHashCode) or (StrIComp(UnitName, PAnsiChar(ModuleName)) <> 0)) then
    begin
      HashEntry := Buckets[HashCode mod cBucketSize];
      while HashEntry <> nil do
      begin
        if (HashEntry.DupsAllowed = (ModuleFlags and pfIgnoreDupUnits <> 0)) and
        ((HashEntry.FullHash = HashCode) and (StrIComp(UnitName, HashEntry.UnitName) = 0)) then
        begin
          UnitPackage := ChangeFileExt(ExtractFileName(
            GetModuleName(HMODULE(HashEntry.LibModule.Instance))), '');
          Result := True;
          Exit;
        end;
        HashEntry := HashEntry.Next;
      end;
    end;
    Result := False;
  end;

  procedure InternalUnitCheck(Module: HModule);
  var
    I, J: Integer;
    InfoTable: PPackageInfoHeader;
    UnitPackage: string;
    ModuleName: UTF8String;
    PkgName: PPkgName;
    UName: PUnitName;
    Count: Integer;
    LibModule: PLibModule;
    Validated: Boolean;
    HC: Cardinal;
    ModuleInfo: PModuleInfo;
    Buckets: ^TUnitHashBuckets;
    ModuleHC: Cardinal;
  begin
    InfoTable := PackageInfoTable(Module);
    if (InfoTable <> nil) and (InfoTable.Flags and pfModuleTypeMask = pfPackageModule) then
    begin
      if ModuleFlags = 0 then
        ModuleFlags := InfoTable.Flags;
      LibModule := FindLibModule(Module);
      if (LibModule <> nil) and (LibModule.Reserved <> 0) then
        Exit;
      Validated := Assigned(AValidatePackage) and AValidatePackage(Module);
      ModuleName := UTF8String(ChangeFileExt(ExtractFileName(GetModuleName(Module)), ''));
      PkgName := PPkgName(PByte(InfoTable) + SizeOf(InfoTable^));
      Count := InfoTable.RequiresCount;
      for I := 0 to Count - 1 do
      begin
{$IFDEF MSWINDOWS}
        InternalUnitCheck(GetModuleHandle(PChar(ChangeFileExt(UTF8ToString(PkgName^.Name), '.bpl'))));
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
        InternalUnitCheck(GetModuleHandle(PChar(UTF8ToString(PkgName^.Name))));
{$ENDIF POSIX}
        Inc(PByte(PkgName), StrLen(PkgName.Name) + 2);
      end;
      Count := Integer(Pointer(PkgName)^);
      UName := PUnitName(PByte(PkgName) + SizeOf(Integer));
      if LibModule <> nil then
      begin
        New(ModuleInfo);
        ModuleInfo.Validated := Validated;
        if Validated then
          Buckets := @ValidatedUnitHashBuckets
        else
          Buckets := @UnitHashBuckets;
        LibModule.Reserved := IntPtr(ModuleInfo);
        // don't include SysInit;
        SetLength(ModuleInfo.UnitHashArray, Count - 1);
        J := 0;
        ModuleHC := HashName(PAnsiChar(Pointer(ModuleName)));
        for I := 0 to Count - 1 do
        begin
          HC := HashName(UName.Name);
          // Test Flags to ignore weak package units
          if ((HC <> SysInitHC) or (StrIComp(UName^.Name, PAnsiChar(AnsiString('SysInit'))) <> 0)) and
          (UName^.Flags and ufWeakPackageUnit = 0) then
          begin
            // Always check against the unvalidated packages
            if IsUnitPresent(UName^.Name, HC, Module, UnitHashBuckets, ModuleName, UnitPackage, ModuleHC) or
            // if the package is not validated also check it against the validated ones
              (not Validated and IsUnitPresent(UName^.Name, HC, Module, ValidatedUnitHashBuckets, ModuleName, UnitPackage, ModuleHC)) then
              raise EPackageError.CreateResFmt(@SDuplicatePackageUnit, [string(ModuleName), UTF8ToString(UName^.Name), UnitPackage]);
            ModuleInfo.UnitHashArray[J].UnitName := @UName.Name;
            ModuleInfo.UnitHashArray[J].LibModule := LibModule;
            ModuleInfo.UnitHashArray[J].DupsAllowed := InfoTable.Flags and pfIgnoreDupUnits <> 0;
            ModuleInfo.UnitHashArray[J].Prev := nil;
            ModuleInfo.UnitHashArray[J].FullHash := HC;
            HC := HC mod cBucketSize;
            ModuleInfo.UnitHashArray[J].Next := Buckets[HC];
            Buckets[HC] := @ModuleInfo.UnitHashArray[J];
            if ModuleInfo.UnitHashArray[J].Next <> nil then
              ModuleInfo.UnitHashArray[J].Next.Prev := Buckets[HC];
            Inc(J);
          end;
          Inc(PByte(UName), StrLen(UName.Name) + 3);
        end;
      end;
    end;
  end;

begin
  if SysInitHC = 0 then
    SysInitHC := HashName('SysInit');
  ModuleFlags := 0;
  InternalUnitCheck(Module);
end;
{$ENDIF !NEXTGEN}

{$IFDEF POSIX}
function LoadLibrary(ModuleName: PChar): HMODULE;
var
  M: TMarshaller;
begin
  Result := HMODULE(dlopen(M.AsAnsi(ModuleName, CP_UTF8).ToPointer, RTLD_LAZY));
end;

function FreeLibrary(Module: HMODULE): LongBool;
begin
  Result := LongBool(dlclose(Module));
end;

function GetProcAddress(Module: HMODULE; Proc: PChar): Pointer;
var
  Error: MarshaledAString;
{$IFDEF LINUX}
  Info: dl_info;
  ModHandle: HMODULE;
{$ENDIF LINUX}
  M: TMarshaller;
begin
  // dlsym doesn't clear the error state when the function succeeds
  dlerror;
  Result := dlsym(Module, M.AsAnsi(Proc, CP_UTF8).ToPointer);
  Error := dlerror;
  if Error <> nil then
    Result := nil
{$IFDEF LINUX}
  else if dladdr(IntPtr(Result), Info) <> 0 then
  begin
                                                    
{   In glibc 2.1.3 and earlier, dladdr returns a nil dli_fname
    for addresses in the main program file.  In glibc 2.1.91 and
    later, dladdr fills in the dli_fname for addresses in the
    main program file, but dlopen will segfault when given
    the main program file name.
    Workaround:  Check the symbol base address against the main
    program file's base address, and only call dlopen with a nil
    filename to get the module name of the main program.  }

    if Info.dli_fbase = ExeBaseAddress then
      Info.dli_fname := nil;

    ModHandle := HMODULE(dlopen(Info.dli_fname, RTLD_LAZY));
    if ModHandle <> 0 then
    begin
      dlclose(ModHandle);
      if ModHandle <> Module then
        Result := nil;
    end;
  end else Result := nil;
{$ENDIF LINUX}
end;
{$ENDIF POSIX}

{$IFDEF LINUX}
type
  plink_map = ^link_map;
  link_map = record
    l_addr: Pointer;
    l_name: PChar;
    l_ld: Pointer;
    l_next, l_prev: plink_map;
  end;

  pr_debug = ^r_debug;
  r_debug = record
    r_version: Integer;
    r_map: plink_map;
    r_brk: Pointer;
    r_state: Integer;
    r_ldbase: Pointer;
  end;

var
  _r_debug: pr_debug = nil;

function ScanLinkMap(Func: Pointer): plink_map;
var
  linkmap: plink_map;

                                                                                                
  function Eval(linkmap: plink_map; Func: Pointer): Boolean;
  asm
//        MOV    ECX,[EBP]
        PUSH   EBP
        CALL   EDX
        POP    ECX
  end;

begin
  if _r_debug = nil then
    _r_debug := dlsym(RTLD_DEFAULT, '_r_debug');
  if _r_debug = nil then
  begin
    Assert(False, 'Unable to locate ''_r_debug'' symbol'); // do not localize
    Result := nil;
    Exit;
  end;
  linkmap := _r_debug.r_map;
  while linkmap <> nil do
  begin
    if not Eval(linkmap, Func) then Break;
    linkmap := linkmap.l_next;
  end;
  Result := linkmap;
end;

function InitModule(linkmap: plink_map): HMODULE;
var
  M: TMarshaller;
begin
  if linkmap <> nil then
  begin
    Result := HMODULE(dlopen(M.AsAnsi(linkmap.l_name, CP_UTF8).ToPointer), RTLD_LAZY));
    if Result <> 0 then
      dlclose(Result);
  end else Result := 0;
end;

function GetModuleHandle(ModuleName: PChar): HMODULE;

  function CheckModuleName(linkmap: plink_map): Boolean;
  var
    BaseName: PChar;
  begin
    Result := True;
    if ((ModuleName = nil) and ((linkmap.l_name = nil) or (linkmap.l_name[0] = #0))) or
      ((ModuleName[0] = PathDelim) and (StrComp(ModuleName, linkmap.l_name) = 0)) then
    begin
      Result := False;
      Exit;
    end else
    begin
      // Locate the start of the actual filename
      BaseName := StrRScan(linkmap.l_name, PathDelim);
      if BaseName = nil then
        BaseName := linkmap.l_name
      else Inc(BaseName); // The filename is actually located at BaseName+1
      if StrComp(ModuleName, BaseName) = 0 then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;

begin
  Result := InitModule(ScanLinkMap(@CheckModuleName));
end;

function GetPackageModuleHandle(PackageName: PChar): HMODULE;
var
  PkgName: array[0..MAX_PATH] of Char;

  function CheckPackageName(linkmap: plink_map): Boolean;
  var
    BaseName: PChar;
  begin
    Result := True;
    if linkmap.l_name <> nil then
    begin
      // Locate the start of the actual filename
      BaseName := StrRScan(linkmap.l_name, PathDelim);
      if BaseName = nil then
        BaseName := linkmap.l_name  // If there is no path info, just use the whole name
      else Inc(BaseName); // The filename is actually located at BaseName+1
      Result := StrPos(BaseName, PkgName) = nil;
    end;
  end;

  procedure MakePkgName(Prefix, Name: PChar);
  begin
    StrCopy(PkgName, Prefix);
    StrLCat(PkgName, Name, Length(PkgName)-1);
    PkgName[High(PkgName)] := #0;
  end;

begin
  if (PackageName = nil) or (StrScan(PackageName, PathDelim) <> nil) then
    Result := 0
  else
  begin
    MakePkgName('bpl', PackageName); // First check the default prefix
    Result := InitModule(ScanLinkMap(@CheckPackageName));
    if Result = 0 then
    begin
      MakePkgName('dcl', PackageName); // Next check the design-time prefix
      Result := InitModule(ScanLinkMap(@CheckPackageName));
      if Result = 0 then
      begin
        MakePkgName('', PackageName);  // finally check without a prefix
        Result := InitModule(ScanLinkMap(@CheckPackageName));
      end;
    end;
  end;
end;
{$ENDIF LINUX}

{$IFDEF MACOS}
function GetModuleHandle(ModuleName: PChar): HMODULE;
var
  M: TMarshaller;
begin
  Result := HMODULE(dlopen(M.AsAnsi(ModuleName, CP_UTF8).ToPointer, RTLD_NOLOAD));
  if Result <> 0 then
    dlclose(Result);
end;

function GetPackageModuleHandle(PackageName: PChar): HMODULE;
begin
  Result := GetModuleHandle(PackageName);
end;
{$ENDIF MACOS}


{$IFDEF MSWINDOWS}
procedure Sleep; external kernel32 name 'Sleep'; stdcall;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
procedure Sleep(milliseconds: Cardinal);
begin
  usleep(milliseconds * 1000);  // usleep is in microseconds
end;
{$ENDIF POSIX}

function GetModuleName(Module: HMODULE): string;
var
  ModName: array[0..MAX_PATH] of Char;
begin
  SetString(Result, ModName, GetModuleFileName(Module, ModName, Length(ModName)));
end;

{$IFNDEF NEXTGEN}
{ InitializePackage }

procedure InitializePackage(Module: HMODULE);
begin
  InitializePackage(Module, nil);
end;

procedure InitializePackage(Module: HMODULE; AValidatePackage: TValidatePackageProc);
type
  TPackageLoad = procedure;
var
  PackageLoad: TPackageLoad;
begin
  CheckForDuplicateUnits(Module, AValidatePackage);
  @PackageLoad := GetProcAddress(Module, 'Initialize'); //Do not localize
  if Assigned(PackageLoad) then
    PackageLoad
  else
    raise EPackageError.CreateFmt(sInvalidPackageFile, [GetModuleName(Module)]);
end;

{ FinalizePackage }

procedure FinalizePackage(Module: HMODULE);
type
  TPackageUnload = procedure;
var
  PackageUnload: TPackageUnload;
begin
  @PackageUnload := GetProcAddress(Module, 'Finalize'); //Do not localize
  if Assigned(PackageUnload) then
    PackageUnload
  else
    raise EPackageError.CreateRes(@sInvalidPackageHandle);
end;

{ LoadPackage }

function LoadPackage(const Name: string): HMODULE;
begin
  Result := LoadPackage(Name, nil);
end;

function LoadPackage(const Name: string; AValidatePackage: TValidatePackageProc): HMODULE;
{$IFDEF POSIX}
var
  DLErrorMsg: string;
  M: TMarshaller;
{$ENDIF POSIX}
begin
{$IFDEF MSWINDOWS}
  Result := SafeLoadLibrary(Name);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Result := HMODULE(dlopen(M.AsAnsi(Name, CP_UTF8).ToPointer, PkgLoadingMode));
{$ENDIF POSIX}
  if Result = 0 then
  begin
{$IFDEF POSIX}
    DLErrorMsg := string(dlerror);
{$ENDIF POSIX}
    raise EPackageError.CreateResFmt(@sErrorLoadingPackage,
      [Name,
       {$IFDEF MSWINDOWS}SysErrorMessage(GetLastError){$ENDIF MSWINDOWS}
       {$IFDEF POSIX}DLErrorMsg{$ENDIF POSIX}]);
  end;
  try
    InitializePackage(Result, AValidatePackage);
  except
{$IFDEF MSWINDOWS}
    FreeLibrary(Result);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    dlclose(Result);
{$ENDIF POSIX}
    raise;
  end;
end;

{ UnloadPackage }

procedure UnloadPackage(Module: HMODULE);
begin
  FinalizePackage(Module);
{$IFDEF MSWINDOWS}
  FreeLibrary(Module);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  dlclose(Module);
  InvalidateModuleCache;
{$ENDIF POSIX}
end;

{ GetPackageInfo }

procedure GetPackageInfo(Module: HMODULE; Param: Pointer; var Flags: Integer;
  InfoProc: TPackageInfoProc);
var
  InfoTable: PPackageInfoHeader;
  I: Integer;
  PkgName: PPkgName;
  UName: PUnitName;
  Count: Integer;
begin
  InfoTable := PackageInfoTable(Module);
  if not Assigned(InfoTable) then
    raise EPackageError.CreateFmt(SCannotReadPackageInfo,
      [ExtractFileName(GetModuleName(Module))]);
  Flags := InfoTable.Flags;
  PkgName := PPkgName(PByte(InfoTable) + SizeOf(InfoTable^));
  Count := InfoTable^.RequiresCount;
  for I := 0 to Count - 1 do
  begin
    InfoProc(UTF8ToString(PkgName.Name), ntRequiresPackage, 0, Param);
    Inc(PByte(PkgName), StrLen(PkgName.Name) + 2);
  end;
  Count := Integer(Pointer(PkgName)^);
  UName := PUnitName(PByte(PkgName) + 4);
  for I := 0 to Count - 1 do
  begin
    InfoProc(UTF8ToString(UName.Name), ntContainsUnit, UName.Flags, Param);
    Inc(PByte(UName), StrLen(UName.Name) + 3);
  end;
  if InfoTable^.Flags and pfPackageModule <> 0 then
  begin
    PkgName := PPkgName(UName);
    InfoProc(UTF8ToString(PkgName.Name), ntDcpBpiName, 0, Param);
  end;
end;

function GetPackageDescription(ModuleName: PChar): string;
var
  ResModule: HMODULE;
  ResInfo: HRSRC;
  ResData: HGLOBAL;
{$IFDEF MSWINDOWS}
  NeedFreeLibrary: Boolean;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  M: TMarshaller;
{$ENDIF POSIX}
begin
  Result := '';
{$IFDEF MSWINDOWS}
  NeedFreeLibrary := True;
{$ENDIF MSWINDOWS}
  ResModule := LoadResourceModule(ModuleName);
  if ResModule = 0 then
  begin
{$IFDEF MSWINDOWS}
    ResModule := GetModuleHandle(ModuleName);
    if ResModule = 0 then
      ResModule := LoadLibraryEx(ModuleName, 0, LOAD_LIBRARY_AS_DATAFILE)
    else
      NeedFreeLibrary := False;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    ResModule := HMODULE(dlopen(M.AsAnsi(ModuleName, CP_UTF8).ToPointer, RTLD_LAZY));
{$ENDIF POSIX}
    if ResModule = 0 then
    begin
      raise EPackageError.CreateResFmt(@sErrorLoadingPackage,
        [ModuleName,
         {$IFDEF MSWINDOWS}SysErrorMessage(GetLastError){$ENDIF MSWINDOWS}
         {$IFDEF POSIX}string(dlerror){$ENDIF POSIX}]);
    end;
  end;
  try
    ResInfo := FindResource(ResModule, 'DESCRIPTION', RT_RCDATA);
    if ResInfo <> 0 then
    begin
      ResData := LoadResource(ResModule, ResInfo);
      if ResData <> 0 then
      try
        Result := PWideChar(LockResource(ResData));
        UnlockResource(ResData);
      finally
        FreeResource(ResData);
      end;
    end;
  finally
{$IFDEF MSWINDOWS}
    if NeedFreeLibrary then
      FreeLibrary(ResModule);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
    dlclose(ResModule);
{$ENDIF POSIX}
  end;
end;

function GetPackageTargets(Module: HMODULE): Word;
var
  ResInfo: HRSRC;
  ResData: HGLOBAL;
begin
  Result := 0;
  if Module = 0 then Exit;
  ResInfo := FindResource(Module, 'PLATFORMTARGETS', RT_RCDATA);
  if ResInfo <> 0 then
  begin
    ResData := LoadResource(Module, ResInfo);
    if ResData <> 0 then
    try
      Result := PWord(LockResource(ResData))^;
      UnlockResource(ResData);
    finally
      FreeResource(ResData);
    end;
  end;
end;
{$ENDIF !NEXTGEN}

procedure RaiseLastOSError;
begin
  RaiseLastOSError(GetLastError, '');
end;

procedure RaiseLastOSError(LastError: Integer);
begin
  RaiseLastOSError(LastError, '');
end;

procedure RaiseLastOSError(LastError: Integer; const AdditionalInfo: string); overload;
var
  Error: EOSError;
begin
  if LastError <> 0 then
    Error := EOSError.CreateResFmt(@SOSError, [LastError, SysErrorMessage(LastError), AdditionalInfo])
  else
    Error := EOSError.CreateRes(@SUnkOSError);
  Error.ErrorCode := LastError;
  raise Error;
end;

procedure CheckOSError(LastError: Integer);
begin
  if LastError <> 0 then
    RaiseLastOSError(LastError);
end;

{$IFDEF MSWINDOWS}
{ RaiseLastWin32Error }

procedure RaiseLastWin32Error;
begin
  RaiseLastOSError;
end;

{ Win32Check }

function Win32Check(RetVal: BOOL): BOOL;
begin
  if not RetVal then RaiseLastOSError;
  Result := RetVal;
end;
{$ENDIF MSWINDOWS}

type
  PTerminateProcInfo = ^TTerminateProcInfo;
  TTerminateProcInfo = record
    Next: PTerminateProcInfo;
    Proc: TTerminateProc;
  end;

var
  TerminateProcList: PTerminateProcInfo = nil;

procedure AddTerminateProc(TermProc: TTerminateProc);
var
  P: PTerminateProcInfo;
begin
  New(P);
  P^.Next := TerminateProcList;
  P^.Proc := TermProc;
  TerminateProcList := P;
end;

function CallTerminateProcs: Boolean;
var
  PI: PTerminateProcInfo;
begin
  Result := True;
  PI := TerminateProcList;
  while Result and (PI <> nil) do
  begin
    Result := PI^.Proc;
    PI := PI^.Next;
  end;
end;

procedure FreeTerminateProcs;
var
  PI: PTerminateProcInfo;
begin
  while TerminateProcList <> nil do
  begin
    PI := TerminateProcList;
    TerminateProcList := PI^.Next;
    Dispose(PI);
  end;
end;

function AL1(const P): LongWord;
type
  List = array[0..3] of DWORD;
begin
  Result := List(P)[0];
  Result := Result XOR List(P)[1];
  Result := Result XOR List(P)[2];
  Result := Result XOR List(P)[3];
end;

function AL2(const P): LongWord;
type
  List = array[0..3] of DWORD;
begin
  Result := List(P)[0];
  Result := (Result shr 5) or (Result shl 27);
  Result := Result XOR List(P)[1];
  Result := (Result shr 5) or (Result shl 27);
  Result := Result XOR List(P)[2];
  Result := (Result shr 5) or (Result shl 27);
  Result := Result XOR List(P)[3];
end;

const
  AL1s: array[0..3] of LongWord = ($FFFFFFF0, $FFFFEBF0, 0, $FFFFFFFF);
  AL2s: array[0..3] of LongWord = ($42C3ECEF, $20F7AEB6, $D1C2F74E, $3F6574DE);

procedure ALV;
begin
  raise Exception.CreateRes(@SNL);
end;

function ALR: Pointer;
var
  LibModule: PLibModule;
begin
  if MainInstance <> 0 then
    Result := Pointer(LoadResource(MainInstance, FindResource(MainInstance, 'DVCLAL',
      RT_RCDATA)))
  else
  begin
    Result := nil;
    LibModule := LibModuleList;
    while LibModule <> nil do
    begin
      Result := Pointer(LoadResource(LibModule^.Instance,
        FindResource(LibModule^.Instance, 'DVCLAL', RT_RCDATA)));
      if Result <> nil then Break;
      LibModule := LibModule.Next;
    end;
  end;
end;

function GDAL: LongWord;
type
  TDVCLAL = array[0..3] of LongWord;
  PDVCLAL = ^TDVCLAL;
var
  P: Pointer;
  A1, A2: LongWord;
  PAL1s, PAL2s: PDVCLAL;
  ALOK: Boolean;
begin
  P := ALR;
  if P <> nil then
  begin
    A1 := AL1(P^);
    A2 := AL2(P^);
    Result := A1;
    PAL1s := @AL1s;
    PAL2s := @AL2s;
    ALOK := ((A1 = PAL1s[0]) and (A2 = PAL2s[0])) or
            ((A1 = PAL1s[1]) and (A2 = PAL2s[1])) or
            ((A1 = PAL1s[2]) and (A2 = PAL2s[2]));
    FreeResource(HGLOBAL(P));
    if not ALOK then ALV;
  end else Result := AL1s[3];
end;

procedure RCS;
var
  P: Pointer;
  ALOK: Boolean;
begin
  P := ALR;
  if P <> nil then
  begin
    ALOK := (AL1(P^) = AL1s[2]) and (AL2(P^) = AL2s[2]);
    FreeResource(HGLOBAL(P));
  end else ALOK := False;
  if not ALOK then ALV;
end;

procedure RPR;
var
  AL: LongWord;
begin
  AL := GDAL;
  if (AL <> AL1s[1]) and (AL <> AL1s[2]) then ALV;
end;

{$IFDEF MSWINDOWS}
procedure InitDriveSpacePtr;
var
  Kernel: THandle;
begin
  Kernel := GetModuleHandle(Winapi.Windows.Kernel32);
  if Kernel <> 0 then
{$IFDEF UNICODE}
    @GetDiskFreeSpaceEx := GetProcAddress(Kernel, 'GetDiskFreeSpaceExW');
{$ELSE !UNICODE}
    @GetDiskFreeSpaceEx := GetProcAddress(Kernel, 'GetDiskFreeSpaceExA');
{$ENDIF !UNICODE}
  if not Assigned(GetDiskFreeSpaceEx) then
    GetDiskFreeSpaceEx := @BackfillGetDiskFreeSpaceEx;
end;
{$ENDIF MSWINDOWS}

{ TSimpleRWSync }

constructor TSimpleRWSync.Create;
begin
  inherited Create;
  FLock := TObject.Create;
end;

destructor TSimpleRWSync.Destroy;
begin
  FLock.Free;
  inherited Destroy;
end;

function TSimpleRWSync.BeginWrite: Boolean;
begin
  MonitorEnter(FLock);
  Result := True;
end;

procedure TSimpleRWSync.EndWrite;
begin
  MonitorExit(FLock);
end;

procedure TSimpleRWSync.BeginRead;
begin
  MonitorEnter(FLock);
end;

procedure TSimpleRWSync.EndRead;
begin
  MonitorExit(FLock);
end;

{ TThreadLocalCounter }

const
  Alive = High(Integer);

destructor TThreadLocalCounter.Destroy;
var
  P, Q: PThreadInfo;
  I: Integer;
begin
  for I := 0 to High(FHashTable) do
  begin
    P := FHashTable[I];
    FHashTable[I] := nil;
    while P <> nil do
    begin
      Q := P;
      P := P^.Next;
      FreeMem(Q);
    end;
  end;
  inherited Destroy;
end;

function TThreadLocalCounter.HashIndex: Byte;
var
  H: Word;
begin
  H := Word(GetCurrentThreadID);
  Result := (WordRec(H).Lo xor WordRec(H).Hi) and 15;
end;

procedure TThreadLocalCounter.Open(var Thread: PThreadInfo);
var
  P: PThreadInfo;
  CurThread: TThreadID;
  H: Byte;
begin
  H := HashIndex;
  CurThread := GetCurrentThreadID;

  P := FHashTable[H];
  while (P <> nil) and (P.ThreadID <> CurThread) do
    P := P.Next;

  if P = nil then
  begin
    P := Recycle;

    if P = nil then
    begin
      P := PThreadInfo(AllocMem(sizeof(TThreadInfo)));
      P.ThreadID := CurThread;
      P.Active := Alive;

      // Another thread could start traversing the list between when we set the
      // head to P and when we assign to P.Next.  Initializing P.Next to point
      // to itself will make others spin until we assign the tail to P.Next.
      P.Next := P;
      P.Next := PThreadInfo(AtomicExchange(Pointer(FHashTable[H]), Pointer(P)));
    end;
  end;
  Thread := P;
end;

procedure TThreadLocalCounter.Close(var Thread: PThreadInfo);
begin
  Thread := nil;
end;

procedure TThreadLocalCounter.Delete(var Thread: PThreadInfo);
begin
  Thread.ThreadID := 0;
  Thread.Active := 0;
end;

function TThreadLocalCounter.Recycle: PThreadInfo;
var
  Gen: Integer;
begin
  Result := FHashTable[HashIndex];
  while (Result <> nil) do
  begin
    Gen := AtomicExchange(Result.Active, Alive);
    if Gen <> Alive then
    begin
      Result.ThreadID := GetCurrentThreadID;
      Exit;
    end
    else
      Result := Result.Next;
  end;
end;

{$IFDEF MSWINDOWS}
{ TMultiReadExclusiveWriteSynchronizer }
const
  mrWriteRequest = $FFFF; // 65535 concurrent read requests (threads)
                          // 32768 concurrent write requests (threads)
                          // only one write lock at a time
                          // 2^32 lock recursions per thread (read and write combined)

constructor TMultiReadExclusiveWriteSynchronizer.Create;
begin
  inherited Create;
  FSentinel := mrWriteRequest;
  FReadSignal := CreateEvent(nil, True, True, nil);  // manual reset, start signaled
  FWriteSignal := CreateEvent(nil, False, False, nil); // auto reset, start blocked
  FWaitRecycle := INFINITE;
  tls := TThreadLocalCounter.Create;
end;

destructor TMultiReadExclusiveWriteSynchronizer.Destroy;
begin
  BeginWrite;
  inherited Destroy;
  CloseHandle(FReadSignal);
  CloseHandle(FWriteSignal);
  tls.Free;
end;

procedure TMultiReadExclusiveWriteSynchronizer.BlockReaders;
begin
  ResetEvent(FReadSignal);
end;

procedure TMultiReadExclusiveWriteSynchronizer.UnblockReaders;
begin
  SetEvent(FReadSignal);
end;

procedure TMultiReadExclusiveWriteSynchronizer.UnblockOneWriter;
begin
  SetEvent(FWriteSignal);
end;

procedure TMultiReadExclusiveWriteSynchronizer.WaitForReadSignal;
begin
  WaitForSingleObject(FReadSignal, FWaitRecycle);
end;

procedure TMultiReadExclusiveWriteSynchronizer.WaitForWriteSignal;
begin
  WaitForSingleObject(FWriteSignal, FWaitRecycle);
end;

{$IFDEF DEBUG_MREWS}
var
  x: Integer;

procedure TMultiReadExclusiveWriteSynchronizer.Debug(const Msg: string);
begin
  OutputDebugString(PChar(Format('%d %s Thread=%x Sentinel=%d, FWriterID=%x',
    [AtomicIncrement(x), Msg, GetCurrentThreadID, FSentinel, FWriterID])));
end;
{$ENDIF DEBUG_MREWS}

function TMultiReadExclusiveWriteSynchronizer.BeginWrite: Boolean;
var
  Thread: PThreadInfo;
  HasReadLock: Boolean;
  ThreadID: Cardinal;
  Test: Integer;
  OldRevisionLevel: Cardinal;

  function AtomicExchangeAdd(var Addend: Integer; Value: Integer): Integer;
  begin
    Result := AtomicIncrement(Addend, Value) - Value;
  end;
begin
  {
    States of FSentinel (roughly - during inc/dec's, the states may not be exactly what is said here):
    mrWriteRequest:         A reader or a writer can get the lock
    1 - (mrWriteRequest-1): A reader (possibly more than one) has the lock
    0:                      A writer (possibly) just got the lock, if returned from the main write While loop
    < 0, but not a multiple of mrWriteRequest: Writer(s) want the lock, but reader(s) have it.
          New readers should be blocked, but current readers should be able to call BeginRead
    < 0, but a multiple of mrWriteRequest: Writer(s) waiting for a writer to finish
  }


{$IFDEF DEBUG_MREWS}
  Debug('Write enter------------------------------------');
{$ENDIF DEBUG_MREWS}
  Result := True;
  ThreadID := GetCurrentThreadID;
  if FWriterID <> ThreadID then  // somebody or nobody has a write lock
  begin
    // Prevent new readers from entering while we wait for the existing readers
    // to exit.
    BlockReaders;

    OldRevisionLevel := FRevisionLevel;

    tls.Open(Thread);
    // We have another lock already. It must be a read lock, because if it
    // were a write lock, FWriterID would be our threadid.
    HasReadLock := Thread.RecursionCount > 0;

    if HasReadLock then    // acquiring a write lock requires releasing read locks
      AtomicIncrement(FSentinel);

{$IFDEF DEBUG_MREWS}
    Debug('Write before loop');
{$ENDIF DEBUG_MREWS}
    // InterlockedExchangeAdd returns prev value
    while AtomicExchangeAdd(FSentinel, -mrWriteRequest) <> mrWriteRequest do
    begin
{$IFDEF DEBUG_MREWS}
      Debug('Write loop');
      Sleep(1000); // sleep to force / debug race condition
      Debug('Write loop2a');
{$ENDIF DEBUG_MREWS}

      // Undo what we did, since we didn't get the lock
      Test := AtomicExchangeAdd(FSentinel, mrWriteRequest);
      // If the old value (in Test) was 0, then we may be able to
      // get the lock (because it will now be mrWriteRequest). So,
      // we continue the loop to find out. Otherwise, we go to sleep,
      // waiting for a reader or writer to signal us.

      if Test <> 0 then
      begin
        {$IFDEF DEBUG_MREWS}
        Debug('Write starting to wait');
        {$ENDIF DEBUG_MREWS}
        WaitForWriteSignal;
      end
      {$IFDEF DEBUG_MREWS}
      else
        Debug('Write continue')
      {$ENDIF DEBUG_MREWS}
    end;

    // At the EndWrite, first Writers are awoken, and then Readers are awoken.
    // If a Writer got the lock, we don't want the readers to do busy
    // waiting. This Block resets the event in case the situation happened.
    BlockReaders;

    // Put our read lock marker back before we lose track of it
    if HasReadLock then
      AtomicDecrement(FSentinel);

    FWriterID := ThreadID;

    Result := Integer(OldRevisionLevel) = (AtomicIncrement(Integer(FRevisionLevel)) - 1);
  end;

  Inc(FWriteRecursionCount);
{$IFDEF DEBUG_MREWS}
  Debug('Write lock-----------------------------------');
{$ENDIF DEBUG_MREWS}
end;

procedure TMultiReadExclusiveWriteSynchronizer.EndWrite;
var
  Thread: PThreadInfo;
begin
{$IFDEF DEBUG_MREWS}
  Debug('Write end');
{$ENDIF DEBUG_MREWS}
  assert(FWriterID = GetCurrentThreadID);
  tls.Open(Thread);
  Dec(FWriteRecursionCount);
  if FWriteRecursionCount = 0 then
  begin
    FWriterID := 0;
    AtomicIncrement(FSentinel, mrWriteRequest);
    {$IFDEF DEBUG_MREWS}
    Debug('Write about to UnblockOneWriter');
    {$ENDIF DEBUG_MREWS}
    UnblockOneWriter;
    {$IFDEF DEBUG_MREWS}
    Debug('Write about to UnblockReaders');
    {$ENDIF DEBUG_MREWS}
    UnblockReaders;
  end;
  if Thread.RecursionCount = 0 then
    tls.Delete(Thread);
{$IFDEF DEBUG_MREWS}
  Debug('Write unlock');
{$ENDIF DEBUG_MREWS}
end;

procedure TMultiReadExclusiveWriteSynchronizer.BeginRead;
var
  Thread: PThreadInfo;
  WasRecursive: Boolean;
  SentValue: Integer;
begin
{$IFDEF DEBUG_MREWS}
  Debug('Read enter');
{$ENDIF DEBUG_MREWS}

  tls.Open(Thread);
  Inc(Thread.RecursionCount);
  WasRecursive := Thread.RecursionCount > 1;

  if FWriterID <> GetCurrentThreadID then
  begin
{$IFDEF DEBUG_MREWS}
    Debug('Trying to get the ReadLock (we did not have a write lock)');
{$ENDIF DEBUG_MREWS}
    // In order to prevent recursive Reads from causing deadlock,
    // we need to always WaitForReadSignal if not recursive.
    // This prevents unnecessarily decrementing the FSentinel, and
    // then immediately incrementing it again.
    if not WasRecursive then
    begin
      // Make sure we don't starve writers. A writer will
      // always set the read signal when it is done, and it is initially on.
      WaitForReadSignal;
      while (AtomicDecrement(FSentinel) <= 0) do
      begin
  {$IFDEF DEBUG_MREWS}
        Debug('Read loop');
  {$ENDIF DEBUG_MREWS}
        // Because the InterlockedDecrement happened, it is possible that
        // other threads "think" we have the read lock,
        // even though we really don't. If we are the last reader to do this,
        // then SentValue will become mrWriteRequest
        SentValue := AtomicIncrement(FSentinel);
        // So, if we did inc it to mrWriteRequest at this point,
        // we need to signal the writer.
        if SentValue = mrWriteRequest then
          UnblockOneWriter;

        // This sleep below prevents starvation of writers
        Sleep(0);

  {$IFDEF DEBUG_MREWS}
        Debug('Read loop2 - waiting to be signaled');
  {$ENDIF DEBUG_MREWS}
        WaitForReadSignal;
  {$IFDEF DEBUG_MREWS}
        Debug('Read signaled');
  {$ENDIF DEBUG_MREWS}
      end;
    end;
  end;
{$IFDEF DEBUG_MREWS}
  Debug('Read lock');
{$ENDIF DEBUG_MREWS}
end;

procedure TMultiReadExclusiveWriteSynchronizer.EndRead;
var
  Thread: PThreadInfo;
  Test: Integer;
begin
{$IFDEF DEBUG_MREWS}
  Debug('Read end');
{$ENDIF DEBUG_MREWS}
  tls.Open(Thread);
  Dec(Thread.RecursionCount);
  if (Thread.RecursionCount = 0) then
  begin
     tls.Delete(Thread);

    // original code below commented out
    if (FWriterID <> GetCurrentThreadID) then
    begin
      Test := AtomicIncrement(FSentinel);
      // It is possible for Test to be mrWriteRequest
      // or, it can be = 0, if the write loops:
      // Test := InterlockedExchangeAdd(FSentinel, mrWriteRequest) + mrWriteRequest;
      // Did not get executed before this has called (the sleep debug makes it happen faster)
      {$IFDEF DEBUG_MREWS}
      Debug(Format('Read UnblockOneWriter may be called. Test=%d', [Test]));
      {$ENDIF}
      if Test = mrWriteRequest then
        UnblockOneWriter
      else if Test <= 0 then // We may have some writers waiting
      begin
        if (Test mod mrWriteRequest) = 0 then
          UnblockOneWriter; // No more readers left (only writers) so signal one of them
      end;
    end;
  end;
{$IFDEF DEBUG_MREWS}
  Debug('Read unlock');
{$ENDIF DEBUG_MREWS}
end;
{$ENDIF MSWINDOWS} //MSWINDOWS for TMultiReadExclusiveWriteSynchronizer

procedure FreeAndNil(var Obj);
{$IF not Defined(AUTOREFCOUNT)}
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;
{$ELSE}
begin
  TObject(Obj) := nil;
end;
{$ENDIF}

{ Interface support routines }

function Supports(const Instance: IInterface; const IID: TGUID; out Intf): Boolean;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(IID, Intf) = 0);
end;

function Supports(const Instance: TObject; const IID: TGUID; out Intf): Boolean;
var
  LUnknown: IUnknown;
begin
  Result := (Instance <> nil) and
            ((Instance.GetInterface(IUnknown, LUnknown) and Supports(LUnknown, IID, Intf)) or
             Instance.GetInterface(IID, Intf));
end;

function Supports(const Instance: IInterface; const IID: TGUID): Boolean;
var
  Temp: IInterface;
begin
  Result := Supports(Instance, IID, Temp);
end;

function Supports(const Instance: TObject; const IID: TGUID): Boolean;
var
  Temp: IInterface;
begin
  // NOTE: Calling this overload on a ref-counted object that has REFCOUNT=0
  // will result in it being freed upon exit from this routine.
  Result := Supports(Instance, IID, Temp);
end;

function Supports(const AClass: TClass; const IID: TGUID): Boolean;
begin
  Result := AClass.GetInterfaceEntry(IID) <> nil;
end;

{ TLanguages }

{$IFDEF MSWINDOWS}
threadvar
  FTempLanguages: TLanguages;

function EnumLocalesCallback(LocaleID: PChar): Integer; stdcall;
begin
  Result := FTempLanguages.LocalesCallback(LocaleID);
end;

{ Query the OS for information for a specified locale. Unicode version. Works correctly on Asian WinNT. }
function GetLocaleDataW(ID: LCID; Flag: DWORD): string;
var
  Buffer: array[0..1023] of WideChar;
begin
  Buffer[0] := #0;
  GetLocaleInfoW(ID, Flag, Buffer, Length(Buffer));
  Result := Buffer;
end;

{ Called for each supported locale. }
function TLanguages.LocalesCallback(LocaleID: PChar): Integer;
var
  AID: LCID;
  ShortLangName: string;
begin
  AID := StrToInt('$' + Copy(LocaleID, 5, 4));
  ShortLangName := GetLocaleDataW(AID, LOCALE_SABBREVLANGNAME);
  if ShortLangName <> '' then
  begin
    SetLength(FSysLangs, Length(FSysLangs) + 1);
    FSysLangs[High(FSysLangs)].FName := GetLocaleDataW(AID, LOCALE_SLANGUAGE);
    FSysLangs[High(FSysLangs)].FLCID := AID;
    FSysLangs[High(FSysLangs)].FExt := ShortLangName;
    FSysLangs[High(FSysLangs)].FLocaleName := Format('%s-%s', [GetLocaleDataW(AID, LOCALE_SISO639LANGNAME),
      GetLocaleDataW(AID, LOCALE_SISO3166CTRYNAME)]);
  end;
  Result := 1;
end;
{$ENDIF}

{$IFDEF MACOS}
procedure EnumLocalesCallback(ElemPtr: Pointer; Context: Pointer); cdecl;
var
  LLocaleIdent, LLangCode, LLangName: CFStringRef;
  LSelf: TLanguages;
  LCurrLocaleRef: CFLocaleRef;
begin
  { Cast to CF string }
  LLocaleIdent := CFStringRef(ElemPtr);
  Pointer(LSelf) := Context;

  SetLength(LSelf.FSysLangs, Length(LSelf.FSysLangs) + 1);

  { Obtain the name of the locale }
  LSelf.FSysLangs[High(LSelf.FSysLangs)].FLocaleName := TCFString(LLocaleIdent).AsString;

  { Obtain the TLocaleID }
  LSelf.FSysLangs[High(LSelf.FSysLangs)].FLCID := CFLocaleCreate(kCFAllocatorDefault, LLocaleIdent);

  { Language code }
  LLangCode := CFLocaleGetValue(LSelf.FSysLangs[High(LSelf.FSysLangs)].FLCID, kCFLocaleLanguageCode);

  if LLangCode <> nil then
  begin
    CFRetain(LLangCode);

    { Get current locale }
    LCurrLocaleRef := CFLocaleCopyCurrent();

    try
      LSelf.FSysLangs[High(LSelf.FSysLangs)].FExt := TCFString(LLangCode).AsString;

      { Language name }
      LLangName := CFLocaleCopyDisplayNameForPropertyValue(LCurrLocaleRef, kCFLocaleLanguageCode, LLangCode);

      if LLangName <> nil then
      begin
        CFRetain(LLangName);

        try
          LSelf.FSysLangs[High(LSelf.FSysLangs)].FName := TCFString(LLangName).AsString;
        finally
          CFRelease(LLangName);
        end;
      end else
        LSelf.FSysLangs[High(LSelf.FSysLangs)].FName := LSelf.FSysLangs[High(LSelf.FSysLangs)].FExt;
    finally
      CFRelease(LLangCode);
      CFRelease(LCurrLocaleRef);
    end;
  end;
  Pointer(LSelf) := nil;
end;
{$ENDIF}

{$IFDEF LINUX}
procedure TLanguages.LoadAvailablePOSIXLocales();
const
  CAliasFileName = 'locale.alias'; // DO NOT LOCALIZE
  CLCIdentFileName = 'LC_IDENTIFICATION'; // DO NOT LOCALIZE
  CLCCTypeFileName = 'LC_CTYPE'; // DO NOT LOCALIZE
  CDefaultLocales: array[0..1] of string = ('POSIX', 'C'); // DO NOT LOCALIZE
  CLocaleDirs: array[0..1] of string = ('/usr/lib/locale', '/usr/share/locale'); // DO NOT LOCALIZE

  function ReadLCIndentif(const AIdentFile: string): string;
  const
    CLanguage_Idx = 7;  { It's the 7th element in the LC file }
    CSeek = (2 + CLanguage_Idx) * SizeOf(Cardinal); // 1 - magic, 2 - number of strs, rest each str index.
    CMagic = $20031119;
  var
    LFile: Integer;
    LSize: Integer;
    LName: PAnsiChar;
    LData: TBytes;
    LIdx: PCardinal;
    LStat: _stat;
  begin
    Result := '';

    { Try to open the file }
    LFile := FileOpen(AIdentFile, fmOpenRead);
    if LFile <> -1 then
    try
      if (fstat(LFile, LStat) = 0) and (LStat.st_size > 0) then
      begin
        LSize := LStat.st_size;

        { Read file contents }
        SetLength(LData, LSize);

        if FileRead(LFile, LData, 0, LSize) = LSize then
        begin
          LIdx := Pointer(LData);
          if (LIdx^ = CMagic) and (LSize >= CSeek) then
          begin
            { Obtain the ref to the language string }
            LIdx := Ptr(PByte(Pointer(LData)) + CSeek);

            { Build up the name pointer }
            if (LSize >= Integer(LIdx^)) then
            begin
              LName := Ptr(PByte(Pointer(LData)) + LIdx^);

              { LName points to a piece of memory that is null-terminated }
              Result := UTF8ToString(LName);
            end;
          end;
        end;
      end;
    finally
      { Close file }
      FileClose(LFile);
    end;

  end;

  procedure SalvageName(const ALocaleName: string; var ADefault: string);
  var
    I: Integer;
  begin
    { Find the name of a given locale }
    for I := 0 to Length(FSysLangs) - 1 do
      if CompareText(FSysLangs[I].FLocaleName, ALocaleName) = 0 then
      begin
        ADefault := FSysLangs[I].FName;
        Exit;
      end;
  end;

  function GetExt(const ALocaleName: string): string;
  var
    L_Pos: Integer;
  begin
    L_Pos := Pos('_', ALocaleName);

    { Copy the first part of ll_CC (ll - language and CC - country) }
    if L_Pos > 0 then
      Result := Copy(ALocaleName, 1, L_Pos - 1)
    else
      Result := ALocaleName;
  end;

  procedure AddEntry(const AName, ALocaleName, AExt: string);
  begin
    SetLength(FSysLangs, Length(FSysLangs) + 1);

    FSysLangs[High(FSysLangs)].FName := AName;
    FSysLangs[High(FSysLangs)].FLocaleName := ALocaleName;
    FSysLangs[High(FSysLangs)].FExt := AExt;
    FSysLangs[High(FSysLangs)].FLCID := newlocale(LC_ALL_MASK, PAnsiChar(AnsiString(ALocaleName)), nil);
  end;

  procedure AddUniqueEntry(const AName, ALocaleName, AExt: string);
  var
    I: Integer;
  begin
    { Verify if the string is already stored. Go backwards for speed. }
    for I := Length(FSysLangs) - 1 downto 0 do
      if CompareText(FSysLangs[I].FLocaleName, ALocaleName) = 0 then
        Exit;

    AddEntry(AName, ALocaleName, AExt);
  end;

  procedure ScanDirectory(const APath: string);
  var
    LSearchRec: TSearchRec;
    LLocaleName, LName: string;
  begin
    { Scan the directory structure }
    if FindFirst(APath + PathDelim + '*.*', $FF, LSearchRec) = 0 then
    repeat
      { If the directory contains LC_CTYPE then assume it is a good locale. Some "locale" directories
        only contain translations and thus cannot be considered as proper locales. }
      if FileExists(APath + PathDelim + LSearchRec.Name + PathDelim + CLCCTypeFileName) then
      begin
        { Obtain the locale name (excluding the CODESET) }
        LLocaleName := ChangeFileExt(LSearchRec.Name, '');

        { Try to obtain the name of eth language from LC_IDENTIFICATION file }
        LName := ReadLCIndentif(APath + PathDelim + LSearchRec.Name + PathDelim + CLCIdentFileName);
        if LName = '' then
          LName := LLocaleName;

        { Add the entry }
        AddUniqueEntry(LName, LLocaleName, GetExt(LLocaleName));
      end;
    until FindNext(LSearchRec) <> 0;

    SysUtils.FindClose(LSearchRec);
  end;

  procedure ScanAliases(const AFileName: string);
  var
    LText: TextFile;
    LLine: string;
    LDelimIdx, I: Integer;
    LAlias, LLocale, LName: string;
  begin
    { Open file }
    AssignFile(LText, AFileName);

    { Exit if the file doe not exist }
    if not FileExists(AFileName) then
      Exit;

    try
      Reset(LText);
    except
      // Exit on failure
      Exit;
    end;

    try
      { Read each line }
      while not EOF(LText) do
      begin
        Readln(LText, LLine);
        LLine := TrimRight(LLine);

        { Skip empty and comment lines }
        if (Length(LLine) = 0) or (LLine[1] = '#') then
          continue;

        { Find either the space or tab characters }
        LDelimIdx := Pos(' ', LLine);
        if LDelimIdx = 0 then
          LDelimIdx := Pos(#9, LLine);

        if LDelimIdx > 0 then
        begin
          { Extract the alias and locale }
          LAlias := ChangeFileExt(Trim(Copy(LLine, 1, LDelimIdx - 1)), '');
          LLocale := ChangeFileExt(Trim(Copy(LLine, LDelimIdx + 1, Length(LLine))), '');

          LName := LLocale;
          SalvageName(LLocale, LName);
          AddUniqueEntry(LName, LAlias, GetExt(LLocale));
        end;
      end;
    finally
      { On error, release file }
      CloseFile(LText);
    end;
  end;

var
  I: Integer;

begin
  { Add default locales }
  for I := Low(CDefaultLocales) to High(CDefaultLocales) do
    AddEntry(CDefaultLocales[I], CDefaultLocales[I], '');

  { Scan UNIX locale directories }
  for I := Low(CLocaleDirs) to High(CLocaleDirs) do
  begin
    { Scan directory }
    ScanDirectory(CLocaleDirs[I]);

    { Scan alias file }
    ScanAliases(CLocaleDirs[I] + PathDelim + CAliasFileName);
  end;
end;
{$ENDIF}

constructor TLanguages.Create;
{$IFDEF MSWINDOWS}
begin
  inherited Create;

  FTempLanguages := Self;
  EnumSystemLocales(@EnumLocalesCallback, LCID_SUPPORTED);
end;
{$ENDIF}
{$IFDEF MACOS}
var
  LLocales: CFArrayRef;
begin
  inherited Create;

  { Obtain MacOSX locales }
  LLocales := CFLocaleCopyAvailableLocaleIdentifiers();
  try
    { For each available locale ... }
    CFArrayApplyFunction(LLocales, CFRangeMake(0, CFArrayGetCount(LLocales)), EnumLocalesCallback, Pointer(Self));
  finally
    { Release array}
    CFRelease(LLocales);
  end;
end;
{$ENDIF}
{$IFDEF LINUX}
begin
  { Call internal helper to load all POSIX locales on Linux }
  LoadAvailablePOSIXLocales();
end;
{$ENDIF}

destructor TLanguages.Destroy;
{$IFDEF MSWINDOWS}
begin
  { Windows does not need to destroy anything. }
  inherited
end;
{$ENDIF}
{$IFDEF MACOS}
var
  I: Integer;
begin
  // For Mac, release the CLocaleRef objects
  for I := 0 to Length(FSysLangs) - 1 do
    CFRelease(FSysLangs[I].FLCID);

  inherited;
end;
{$ENDIF}
{$IFDEF LINUX}
var
  I: Integer;
begin
  // For Linux, use freelocale to free the locale object
  for I := 0 to Length(FSysLangs) - 1 do
    freelocale(FSysLangs[I].FLCID);

  inherited;
end;
{$ENDIF}

function TLanguages.GetCount: Integer;
begin
  Result := Length(FSysLangs);
end;

function TLanguages.GetExt(Index: Integer): string;
begin
  Result := FSysLangs[Index].FExt;
end;

function TLanguages.GetID(Index: Integer): string;
{$IFDEF MSWINDOWS}
begin
  Result := HexDisplayPrefix + IntToHex(FSysLangs[Index].FLCID, 8);
end;
{$ENDIF}
{$IFDEF POSIX}
begin
  // On POSIX use the locale name as it's ID
  Result := GetLocaleName(Index);
end;
{$ENDIF}

function TLanguages.GetLocaleID(Index: Integer): TLocaleID;
begin
  Result := FSysLangs[Index].FLCID;
end;

function TLanguages.GetLocaleName(Index: Integer): string;
begin
  Result := FSysLangs[Index].FLocaleName;
end;

function TLanguages.GetName(Index: Integer): string;
begin
  Result := FSysLangs[Index].FName;
end;

function TLanguages.GetNameFromLocaleID(ID: TLocaleID): string;
var
  Index: Integer;
begin
  Result := sUnknown;
  Index := IndexOf(ID);
  if Index <> - 1 then Result := Name[Index];
  if Result = '' then Result := sUnknown;
end;

class function TLanguages.GetUserDefaultLocale: TLocaleID;
{$IFDEF MACOS}
var
  LLocale: TLocaleID;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  Result := Winapi.Windows.GetUserDefaultLCID;
{$ENDIF}
{$IFDEF MACOS}
  if FDefaultLocale = nil then
  begin
    LLocale := FDefaultLocale;
    LLocale := AtomicCmpExchange(Pointer(FDefaultLocale), Pointer(CFLocaleCopyCurrent), Pointer(LLocale));
    if LLocale <> nil then
      CFRelease(LLocale);
  end;
  Result := FDefaultLocale;
{$ENDIF}
{$IFDEF LINUX}
  if FDefaultLocale = nil then
  begin
    LLocale := FDefaultLocale;
    LLocale := AtomicCmpExchange(FDefaultLocale, newlocale(LC_ALL_MASK, '', nil), LLocale);
    if LLocale <> nil then
      freelocale(LLocale);
  end;
  Result := FDefaultLocale;
{$ENDIF}
end;

class function TLanguages.GetLocaleIDFromLocaleName(const LocaleName: string): TLocaleID;
{$IF defined(MSWINDOWS)}
begin
  if TOSVersion.Check(6, 0) then
    Result := LocaleNameToLCID(PChar(LocaleName.Replace('_', '-')), 0)
  else
    Result := Languages.LocaleIDFromName[LocaleName];
end;
{$ELSEIF defined(MACOS)}
var
  StringRef, LocaleIdent: CFStringRef;
begin
  Result := TLocaleID(0);
  LocaleIdent := CFSTR(LocaleName);
  if LocaleIdent <> nil then
  try
    StringRef := CFLocaleCreateCanonicalLocaleIdentifierFromString(nil, LocaleIdent);
    if StringRef <> nil then
      try
        Result := CFLocaleCreate(nil, LocaleIdent);

      finally
        CFRelease(StringRef);
      end
  finally
    CFRelease(LocaleIdent);
  end
end;
{$ELSE !MSWINDOWS !MACOS}
begin
  Error(rePlatformNotImplemented);
end;
{$ENDIF !MSWINDOWS !MACOS}

function TLanguages.GetNameFromLCID(const ID: string): string;
{$IFDEF MSWINDOWS}
begin
  Result := NameFromLocaleID[StrToIntDef(ID, 0)];
end;
{$ENDIF}
{$IFDEF POSIX}
var
  LIndex: Integer;
begin
  // On POSIX use the locale name as it's ID
  LIndex := IndexOf(ID);

  if LIndex <> -1 then
    Result := Name[LIndex]
  else
    Result := sUnknown;
end;
{$ENDIF}

function TLanguages.GetLocaleIDFromName(const LocaleName: string): TLocaleID;
var
  Index: Integer;
begin
{$IFDEF MSWINDOWS}
  Index := IndexOf(LocaleName.Replace('_', '-'));
{$ELSE}
  Index := IndexOf(LocaleName);
{$ENDIF}
  if Index >= 0 then
    Result := LocaleID[Index]
  else
    Result := TLocaleID(0);
end;

function TLanguages.IndexOf(ID: TLocaleID): Integer;
begin
  for Result := Low(FSysLangs) to High(FSysLangs) do
{$IFDEF MACOS}
    if CFEqual(FSysLangs[Result].FLCID, ID) then Exit;  // Compare using mac functions
{$ELSE}
    // On linux the handles will get compared. There is no "comparison function" defined.
    if FSysLangs[Result].FLCID = ID then Exit;
{$ENDIF}

  Result := -1;
end;

function TLanguages.IndexOf(const LocaleName: string): Integer;
begin
  for Result := Low(FSysLangs) to High(FSysLangs) do
    if CompareText(FSysLangs[Result].FLocaleName, LocaleName) = 0 then Exit;

  Result := -1;
end;

var
  FLanguages: TLanguages;

class destructor TLanguages.Destroy;
begin
  FreeAndNil(FLanguages);
{$IFDEF MACOS}
  if FDefaultLocale <> nil then
    CFRelease(FDefaultLocale);
{$ENDIF}
{$IFDEF LINUX}
  if FDefaultLocale <> nil then
    freelocale(FDefaultLocale);
{$ENDIF}
end;

function Languages: TLanguages;
begin
  if FLanguages = nil then
    FLanguages := TLanguages.Create;

  Result := FLanguages;
end;

                                                                                                                     
{$IFDEF MSWINDOWS}
function SafeLoadLibrary(const Filename: string; ErrorMode: UINT): HMODULE;
{$IFDEF NEXTGEN}
begin
                                              
  Result := LoadLibrary(PChar(Filename));
end;
{$ELSE  NEXTGEN}
var
  OldMode: UINT;
  {$IFDEF CPUX86}
  FPUControlWord: Word;
  {$ENDIF CPUX86}
begin
  OldMode := SetErrorMode(ErrorMode);
  try
  {$IFDEF PUREPASCAL}
  {$IFDEF CPUX86}
    FPUControlWord := Get8087CW();
    Result := LoadLibrary(PChar(Filename));
    TestAndClearFPUExceptions(0);
    Set8087CW(FPUControlWord);
  {$ENDIF CPUX86}
  {$IFDEF CPUX64}
    Result := LoadLibrary(PChar(Filename));
  {$ENDIF CPUX64}
  {$ELSE !PUREPASCAL}
  {$IFDEF X86ASM}
    asm
      FNSTCW  FPUControlWord
    end;
    try
      Result := LoadLibrary(PChar(Filename));
    finally
      asm
        FNCLEX
        FLDCW FPUControlWord
      end;
    end;
  {$ENDIF X86ASM}
  {$ENDIF !PUREPASCAL}
  finally
    SetErrorMode(OldMode);
  end;
end;
{$ENDIF NEXTGEN}
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
function SafeLoadLibrary(const FileName: string; Dummy: LongWord): HMODULE;
{$IFDEF NEXTGEN}
begin
                                              
  Result := LoadLibrary(PChar(Filename));
end;
{$ELSE  NEXTGEN}
var
  FPUControlWord: Word;
begin
  {$IFDEF PUREPASCAL}
    FPUControlWord := Get8087CW();
    Result := LoadLibrary(PChar(Filename));
    TestAndClearFPUExceptions(0);
    Set8087CW(FPUControlWord);
  {$ELSE !PUREPASCAL}
  {$IFDEF X86ASM}
  asm
    FNSTCW  FPUControlWord
  end;
  try
    Result := LoadLibrary(PChar(Filename));
  finally
    asm
      FNCLEX
      FLDCW FPUControlWord
    end;
  end;
  {$ENDIF X86ASM}
  {$ENDIF !PUREPASCAL}
end;
{$ENDIF NEXTGEN}
{$ENDIF POSIX}

function GetEnvironmentVariable(const Name: string): string;
{$IFDEF MSWINDOWS}
const
  BufSize = 1024;
var
  Len: Integer;
  Buffer: array[0..BufSize - 1] of Char;
begin
  Result := '';
  Len := GetEnvironmentVariable(PChar(Name), @Buffer, BufSize);
  if Len < BufSize then
    SetString(Result, PChar(@Buffer), Len)
  else
  begin
    SetLength(Result, Len - 1);
    GetEnvironmentVariable(PChar(Name), PChar(Result), Len);
  end;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  M: TMarshaller;
begin
  Result := string(getenv(M.AsAnsi(Name, CP_UTF8).ToPointer));
end;
{$ENDIF POSIX}

{$IFDEF LINUX}
function gnu_get_libc_version: PAnsiChar; cdecl;
  external libc name 'gnu_get_libc_version';
function strverscmp(const S1: PAnsiChar; const S2: PAnsiChar): Integer; cdecl;
  external libc name 'strverscmp';

procedure CheckLocale;
var
  P,Q: PAnsiChar;
begin
  P := gnu_get_libc_version();
  Q := getenv('LC_ALL');
  if (Q = nil) or (Q[0] = #0) then
    Q := getenv('LANG');

  //  2.1.3 <= current version < 2.1.91
  if (strverscmp('2.1.3', P) <= 0) and
     (strverscmp(P, '2.1.91') < 0) and
     ((Q = nil) or (Q[0] = #0)) then
  begin
    // GNU libc 2.1.3 will segfault in towupper() if environment variables don't
    // specify a locale.  This can happen when Apache launches CGI subprocesses.
    // Solution: set a locale if the environment variable is missing.
    // Works in 2.1.2, fixed in glibc 2.1.91 and later
    setlocale(LC_ALL, 'POSIX');
  end
  else
    // Configure the process locale settings according to
    // the system environment variables (LC_CTYPE, LC_COLLATE, etc)
    setlocale(LC_ALL, '');

  // Note:
  // POSIX/C is the default locale on many Unix systems, but its 7-bit charset
  // causes char to widechar conversions to fail on any high-ascii
  // character.  To support high-ascii charset conversions, set the
  // LC_CTYPE environment variable to something else or call setlocale to set
  // the LC_CTYPE information for this process.  It doesn't matter what
  // you set it to, as long as it's not POSIX.
//  if StrComp(nl_langinfo(_NL_CTYPE_CODESET_NAME), 'ANSI_X3.4-1968') = 0 then
  if StrComp(nl_langinfo(CODESET), 'ANSI_X3.4-1968') = 0 then
    setlocale(LC_CTYPE, 'en_US');  // selects codepage ISO-8859-1
end;
{$ENDIF LINUX}

{$IFDEF POSIX}
{
    Under Win32, SafeCallError is implemented in ComObj.  Under Linux, we
    don't have ComObj, so we've substituted a similar mechanism here.
}
procedure SafeCallError(ErrorCode: Integer; ErrorAddr: Pointer);
var
  ExcMsg: String;
begin
  ExcMsg := GetSafeCallExceptionMsg;
  SetSafeCallExceptionMsg('');
  if ExcMsg <> '' then
  begin
    raise ESafeCallException.Create(ExcMsg) at GetSafeCallExceptionAddr;
  end
  else
    raise ESafeCallException.CreateRes(@SSafecallException) at ErrorAddr;
end;
{$ENDIF POSIX}

function DelegatesEqual(A, B: Pointer): Boolean;
begin
  Result := A = B;
end;

function ByteLength(const S: string): Integer;
begin
  Result := Length(S) * SizeOf(Char);
end;

{ TStringBuilder }

function TStringBuilder.GetLength: Integer;
begin
  Result := FLength;
end;

function TStringBuilder.Append(const Value: UInt64): TStringBuilder;
begin
  Append(UIntToStr(Value));
  Result := self;
end;

function TStringBuilder.Append(const Value: TCharArray): TStringBuilder;
var
  I: Integer;
begin
  Result := self;

  for I := 0 to System.Length(Value) - 1 do
    if Value[I] = #0 then
      Break;

  Append(Value, 0, I);
end;

function TStringBuilder.Append(const Value: Single): TStringBuilder;
begin
  Append(FloatToStr(Value));
  Result := self;
end;

function TStringBuilder.Append(const Value: string): TStringBuilder;
begin
  Length := Length + System.Length(Value);
  Move(PChar(Value)^, FData[Length - System.Length(Value)], System.Length(Value) * SizeOf(Char));
  Result := self;
end;

function TStringBuilder.Append(const Value: Word): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := self;
end;

function TStringBuilder.Append(const Value: TCharArray; StartIndex,
  CharCount: Integer): TStringBuilder;
begin
  if StartIndex + CharCount > System.Length(Value) then
    raise ERangeError.CreateResFmt(@SListIndexError, [StartIndex]);
  if StartIndex < 0 then
    raise ERangeError.CreateResFmt(@SListIndexError, [StartIndex]);

  Length := Length + CharCount;
  Move(Value[StartIndex], FData[Length - CharCount], CharCount * SizeOf(Char));
  Result := self;
end;

function TStringBuilder.Append(const Value: string; StartIndex,
  Count: Integer): TStringBuilder;
begin
  if StartIndex + Count > System.Length(Value) then
    raise ERangeError.CreateResFmt(@SListIndexError, [StartIndex]);
  if StartIndex < 0 then
    raise ERangeError.CreateResFmt(@SListIndexError, [StartIndex]);

  Length := Length + Count;
  Move(Value[StartIndex + Low(string)], FData[Length - Count], Count * SizeOf(Char));
  Result := Self;
end;

{$IFNDEF NEXTGEN}
function TStringBuilder.Append(const Value: PAnsiChar): TStringBuilder;
begin
  Append(string(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: RawByteString): TStringBuilder;
begin
  Append(string(Value));
  Result := Self;
end;
{$ENDIF !NEXTGEN}

function TStringBuilder.Append(const Value: Cardinal): TStringBuilder;
begin
  Append(UIntToStr(Value));
  Result := self;
end;

function TStringBuilder.Append(const Value: Char;
  RepeatCount: Integer): TStringBuilder;
begin
  Append(System.StringOfChar(Value, RepeatCount));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Shortint): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Char): TStringBuilder;
begin
  Length := Length + 1;
  FData[Length - 1] := Value;
  Result := Self;
end;

function TStringBuilder.Append(const Value: Currency): TStringBuilder;
begin
  Append(CurrToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Boolean): TStringBuilder;
begin
  Append(BoolToStr(Value, True));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Byte): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Double): TStringBuilder;
begin
  Append(FloatToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Int64): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: TObject): TStringBuilder;
begin
{$if CompilerVersion >= 19}
  Append(Value.ToString());
{$else}
  Append(IntToStr(Integer(Value)));
{$ENDIF}
  Result := Self;
end;

function TStringBuilder.Append(const Value: Smallint): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Integer): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.AppendFormat(const Format: string; const Args: array of const): TStringBuilder;
begin
  Append(System.SysUtils.Format(Format, Args));
  Result := Self;
end;

function TStringBuilder.AppendLine: TStringBuilder;
begin
  Append(sLineBreak);
  Result := Self;
end;

function TStringBuilder.AppendLine(const Value: string): TStringBuilder;
begin
  Append(Value);
  AppendLine;
  Result := Self;
end;

procedure TStringBuilder.Clear ;
begin
  Length := 0;
  Capacity := DefaultCapacity;
end;

procedure TStringBuilder.CheckBounds(Index: Integer);
begin
  if Cardinal(Index) >= Cardinal(Length) then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);
end;

procedure TStringBuilder.CopyTo(SourceIndex: Integer;
  const Destination: TCharArray; DestinationIndex, Count: Integer);
begin
  if Count < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Count']); // DO NOT LOCALIZE
  if DestinationIndex < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['DestinationIndex']); // DO NOT LOCALIZE
  if DestinationIndex + Count > System.Length(Destination) then
    raise ERangeError.CreateResFmt(@SInputBufferExceed,
      ['DestinationIndex', DestinationIndex, 'Count', Count]);

  if Count > 0 then
  begin
    CheckBounds(SourceIndex);
    CheckBounds(SourceIndex + Count - 1);

    Move(FData[SourceIndex], Destination[DestinationIndex], Count * SizeOf(Char));
  end;
end;

constructor TStringBuilder.Create;
begin
  inherited Create;
  FMaxCapacity := MaxInt;
  Capacity := DefaultCapacity;
  FLength := 0;
end;

constructor TStringBuilder.Create(const Value: string; aCapacity: Integer);
begin
  inherited Create;
  FMaxCapacity := MaxInt;
  Capacity := aCapacity;
  FLength := 0;
  Append(Value);
end;

constructor TStringBuilder.Create(const Value: string; StartIndex, length,
  aCapacity: Integer);
begin
  //Create(Copy(Value, StartIndex + 1, length), aCapacity);
  Create(Value.Substring( StartIndex, length), aCapacity);
end;

constructor TStringBuilder.Create(aCapacity, aMaxCapacity: Integer);
begin
  Create(aCapacity);
  FMaxCapacity := aMaxCapacity;
end;

constructor TStringBuilder.Create(aCapacity: Integer);
begin
  inherited Create;
  FMaxCapacity := MaxInt;
  Capacity := aCapacity;
  FLength := 0;
end;

constructor TStringBuilder.Create(const Value: string);
begin
  Create;
  Append(Value);
end;

function TStringBuilder.EnsureCapacity(aCapacity: Integer): Integer;
begin
  if Cardinal(aCapacity) > Cardinal(MaxCapacity) then
    raise ERangeError.CreateResFmt(@SListIndexError, [aCapacity]);

  if Capacity < aCapacity then
    Capacity := aCapacity;

  Result := Capacity;
end;

function TStringBuilder.Equals(StringBuilder: TStringBuilder): Boolean;
begin
  Result := (StringBuilder <> nil) and (Length = StringBuilder.Length) and
    (MaxCapacity = StringBuilder.MaxCapacity) and
    CompareMem(@FData[0], @StringBuilder.FData[0], Length * SizeOf(Char));
end;

procedure TStringBuilder.ExpandCapacity;
var
  NewCapacity: Integer;
begin
  NewCapacity := Capacity * 2;
  if Length > NewCapacity then
    NewCapacity := Length * 2; // this line may overflow NewCapacity to a negative value
  if NewCapacity > MaxCapacity then
    NewCapacity := MaxCapacity;
  if NewCapacity < 0 then // if NewCapacity has been overflowed
    NewCapacity := Length;
  Capacity := NewCapacity;
end;

function TStringBuilder.GetCapacity: Integer;
begin
  Result := System.Length(FData);
end;

function TStringBuilder.GetChars(Index: Integer): Char;
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  CheckBounds(Index);

  Result := FData[Index];
end;

function TStringBuilder.GetMaxCapacity: Integer;
begin
  Result := FMaxCapacity;
end;

function TStringBuilder.Insert(Index: Integer; const Value: TObject): TStringBuilder;
begin
{$if CompilerVersion >= 19}
  Insert(Index, Value.ToString());
{$else}
  Insert(Index, IntToStr(Integer(Value)));
{$ENDIF}
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Int64): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Single): TStringBuilder;
begin
  Insert(Index, FloatToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: string): TStringBuilder;
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  if Index > Length then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);

  Length := Length + System.Length(Value);
  Move(FData[Index], FData[Index + System.Length(Value)], (Length - System.Length(Value) - Index) * SizeOf(Char));
  Move(Value[Low(string)], FData[Index], System.Length(Value) * SizeOf(Char));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Word): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Shortint): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer;
  const Value: TCharArray): TStringBuilder;
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  if Index > Length then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);

  Length := Length + System.Length(Value);
  Move(FData[Index], FData[Index + System.Length(Value)], System.Length(Value) * SizeOf(Char));
  Move(Value[0], FData[Index], System.Length(Value) * SizeOf(Char));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Currency): TStringBuilder;
begin
  Insert(Index, CurrToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Char): TStringBuilder;
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  if Index > Length then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);

  Length := Length + 1;
  Move(FData[Index], FData[Index + 1], (Length - Index - 1) * SizeOf(Char));
  FData[Index] := Value;
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Byte): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Double): TStringBuilder;
begin
  Insert(Index, FloatToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Integer): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Smallint): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Boolean): TStringBuilder;
begin
  Insert(Index, BoolToStr(Value, True));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: string;
  Count: Integer): TStringBuilder;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Insert(Index, Value);
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: TCharArray; StartIndex,
  CharCount: Integer): TStringBuilder;
begin
  if Index - 1 >= Length then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index])
  else if Index < 0 then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);
  if StartIndex < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
  if CharCount < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['CharCount']); // DO NOT LOCALIZE
  if StartIndex + CharCount > System.Length(Value) then
    raise ERangeError.CreateResFmt(@SInputBufferExceed,
      ['StartIndex', StartIndex, 'CharCount', CharCount]);

  Length := Length + CharCount;

  if Length - Index > 0 then
    Move(FData[Index], FData[Index + CharCount], (Length - Index) * SizeOf(Char));
  Move(Value[StartIndex], FData[Index], CharCount * SizeOf(Char));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Cardinal): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: UInt64): TStringBuilder;
begin
  Insert(Index, UIntToStr(Value));
  Result := self;
end;

procedure TStringBuilder.ReduceCapacity;
var
  NewCapacity: Integer;
begin
  if Length > Capacity div 4 then
    Exit;

  NewCapacity := Capacity div 2;
  if NewCapacity < Length then
    NewCapacity := Length;
  Capacity := NewCapacity;
end;

function TStringBuilder.Remove(StartIndex, RemLength: Integer): TStringBuilder;
begin
  if RemLength <> 0 then
  begin
    if StartIndex < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
    if RemLength < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['RemLength']); // DO NOT LOCALIZE
    CheckBounds(StartIndex);
    CheckBounds(StartIndex + RemLength - 1);

    if (Length - (StartIndex + RemLength)) > 0 then
      Move(FData[StartIndex + RemLength], FData[StartIndex], (Length - (StartIndex + RemLength)) * SizeOf(Char));
    Length := Length - RemLength;

    ReduceCapacity;
  end;
  Result := Self;
end;

function TStringBuilder.Replace(const OldValue, NewValue: string; StartIndex,
  Count: Integer): TStringBuilder;
var
  CurPtr: PChar;
  EndPtr: PChar;
  Index: Integer;
  EndIndex: Integer;
  OldLen, NewLen: Integer;
begin
  Result := Self;

  if Count <> 0 then
  begin
    if StartIndex < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
    if Count < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['Count']); // DO NOT LOCALIZE
    if StartIndex + Count > Length then
      raise ERangeError.CreateResFmt(@SInputBufferExceed,
        ['StartIndex', StartIndex, 'Count', Count]);

    OldLen := System.Length(OldValue);
    NewLen := System.Length(NewValue);
    Index := StartIndex;
    CurPtr := @FData[StartIndex];
    EndIndex := StartIndex + Count - OldLen;
    EndPtr := @FData[EndIndex];

    while CurPtr <= EndPtr do
    begin
      if CurPtr^ = OldValue[Low(string)] then
      begin
        if StrLComp(CurPtr, PChar(OldValue), OldLen) = 0 then
        begin
          if _Replace(Index, OldValue, NewValue) then
          begin
            CurPtr := @FData[Index];
            EndPtr := @FData[EndIndex];
          end;
          Inc(CurPtr, NewLen - 1);
          Inc(Index, NewLen - 1);
          Inc(EndPtr, NewLen - OldLen);
          Inc(EndIndex, NewLen - OldLen);
        end;
      end;

      Inc(CurPtr);
      Inc(Index);
    end;
  end;
end;

function TStringBuilder.Replace(const OldChar, NewChar: Char; StartIndex,
  Count: Integer): TStringBuilder;
var
  Ptr: PChar;
  EndPtr: PChar;
begin
  if Count <> 0 then
  begin
    if StartIndex < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
    if Count < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['Count']); // DO NOT LOCALIZE
    CheckBounds(StartIndex);
    CheckBounds(StartIndex + Count - 1);

    EndPtr := @FData[StartIndex + Count - 1];
    Ptr := @FData[StartIndex];
    while Ptr <= EndPtr do
    begin
      if Ptr^ = OldChar then
        Ptr^ := NewChar;
      Inc(Ptr);
    end;
  end;
  Result := Self;
end;

function TStringBuilder.Replace(const OldChar, NewChar: Char): TStringBuilder;
var
  Ptr: PChar;
  EndPtr: PChar;
begin
  EndPtr := @FData[Length - 1];
  Ptr := @FData[0];
  while Ptr <= EndPtr do
  begin
    if Ptr^ = OldChar then
      Ptr^ := NewChar;
    Inc(Ptr);
  end;
  Result := Self;
end;

function TStringBuilder.Replace(const OldValue, NewValue: string): TStringBuilder;
begin
  Result := self;
  Replace(OldValue, NewValue, 0, Length);
end;

procedure TStringBuilder.SetCapacity(Value: Integer);
begin
  if Value < Length then
    raise ERangeError.CreateResFmt(@SListCapacityError, [Value]);
  if Value > FMaxCapacity then
    raise ERangeError.CreateResFmt(@SListCapacityError, [Value]);

  System.SetLength(FData, Value);
end;

procedure TStringBuilder.SetChars(Index: Integer; Value: Char);
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  CheckBounds(Index);

  FData[Index] := Value;
end;

procedure TStringBuilder.SetLength(Value: Integer);
var
  LOldLength: Integer;
begin
  if Value < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Value']); // DO NOT LOCALIZE
  if Value > MaxCapacity then
    raise ERangeError.CreateResFmt(@SListCapacityError, [Value]);

  LOldLength := FLength;
  try
    FLength := Value;
    if FLength > Capacity then
      ExpandCapacity;
  except
    on E: EOutOfMemory do
    begin
      FLength := LOldLength;
      raise;
    end;
  end;
end;

function TStringBuilder.ToString: string;
begin
  SetString(Result, MarshaledString(FData), Length);
end;

function TStringBuilder.ToString(StartIndex, StrLength: Integer): string;
begin
  if StrLength <> 0 then
  begin
    if StartIndex < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
    if StrLength < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StrLength']); // DO NOT LOCALIZE
    CheckBounds(StartIndex);
    CheckBounds(StartIndex + StrLength - 1);

    Result := string.Create(FData, StartIndex, StrLength);
  end else
    Result := '';
end;

function TStringBuilder._Replace(Index: Integer; const Old, New: string): Boolean;
var
  OldLength: Integer;
  OldCapacity: Integer;
  SizeChange: Integer;
begin
  Result := False;
  SizeChange := System.Length(New) - System.Length(Old);

  if SizeChange = 0 then
  begin
    Move(New[Low(string)], FData[Index], System.Length(New) * SizeOf(Char));
  end
  else
  begin
    OldLength := Length;
    if SizeChange > 0 then
    begin
      OldCapacity := Capacity;
      Length := Length + SizeChange;
      if OldCapacity <> Capacity then
        Result := True;
    end;

    Move(FData[Index + System.Length(Old)], FData[Index + System.Length(New)],
      (OldLength - (System.Length(Old) + Index)) * SizeOf(Char));
    Move(New[Low(String)], FData[Index], System.Length(New) * SizeOf(Char));

    if SizeChange < 0 then
      Length := Length + SizeChange;
  end;
end;

{$ZEROBASEDSTRINGS ON}

class function TStringHelper.CharInArray(const C: Char; const InArray: array of Char): Boolean;
var
  AChar: Char;
begin
  for AChar in InArray do
    if AChar = C then Exit(True);
  Result := False;
end;

class function TStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB,
  Length: Integer): Integer;
begin
  Result := Compare(StrA, IndexA, StrB, IndexB, Length, False, SysLocale.DefaultLCID);
end;

class function TStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB,
  Length: Integer; LocaleID: TLocaleID): Integer;
begin
  Result := Compare(StrA, IndexA, StrB, IndexB, Length, False, LocaleID);
end;

class function TStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB, Length: Integer;
  IgnoreCase: Boolean): Integer;
begin
  Result := Compare(StrA, IndexA, StrB, IndexB, Length, IgnoreCase, SysLocale.DefaultLCID);
end;

class function TStringHelper.InternalCompare(const StrA: string; IndexA: Integer; const StrB: string;
  IndexB, LengthA, LengthB: Integer; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer;
{$IF defined(MSWINDOWS)}
var
  Flags: DWORD;
begin
  if IgnoreCase then
    Flags := NORM_IGNORECASE
  else
    Flags := 0;

  if (StrA = '') or (StrB = '') then
  begin
    if StrA.Length > 0 then
      Result := 1
    else
      if StrB.Length > 0 then
        Result := -1
      else
        Result := 0;
  end
  else
    Result := CompareString(LocaleID, Flags, PChar(@StrA[IndexA]), LengthA, PChar(@StrB[IndexB]), LengthB) - CSTR_EQUAL;
end;
{$ELSEIF defined(MACOS)}
var
  StringRef1: CFStringRef;
  StringRef2: CFStringRef;
  Flags: CFStringCompareFlags;
  MaxLen: Integer;
begin
  if (StrA = '') or (StrB = '') then
  begin
    if StrA.Length > 0 then
      Result := 1
    else
      if StrB.Length > 0 then
        Result := -1
      else
        Result := 0;
  end
  else
  begin
    Result := -1;
    StringRef1 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, @StrA[IndexA],
      LengthA, kCFAllocatorNull);
    if StringRef1 <> nil then
    begin
      try
        StringRef2 := CFStringCreateWithCharactersNoCopy(kCFAllocatorDefault, @StrB[IndexB],
          LengthB, kCFAllocatorNull);
        if StringRef2 <> nil then
        begin
          try
            if IgnoreCase then
              Flags := kCFCompareCaseInsensitive
            else
              Flags := 0;
            if LengthA > LengthB then
              MaxLen := LengthA
            else
              MaxLen := LengthB;
            if LocaleId = nil then
              LocaleId := UTF8CompareLocale;

            Result := CFStringCompareWithOptionsAndLocale(StringRef1, StringRef2,
              CFRangeMake(0, MaxLen), Flags, LocaleID);
          finally
            CFRelease(StringRef2);
          end;
        end
        else
          raise ECFError.Create(SCFStringFailed);
      finally
        CFRelease(StringRef1);
      end;
    end
    else
      raise ECFError.Create(SCFStringFailed);
  end;
end;
{$ELSE !MSWINDOWS !MACOS}
begin
  Error(rePlatformNotImplemented);
end;
{$ENDIF !MSWINDOWS !MACOS}

class function TStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB, Length: Integer;
  IgnoreCase: Boolean; LocaleID: TLocaleID): Integer;
begin
  Result := InternalCompare(StrA, IndexA, StrB, IndexB, Length, Length, IgnoreCase, LocaleID);
end;

class function TStringHelper.Compare(const StrA, StrB: string; IgnoreCase: Boolean): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, IgnoreCase, SysLocale.DefaultLCID);
end;

class function TStringHelper.Compare(const StrA, StrB: string; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, IgnoreCase, LocaleID);
end;

class function TStringHelper.Compare(const StrA, StrB: string): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, False, SysLocale.DefaultLCID);
end;

class function TStringHelper.Compare(const StrA, StrB: string; LocaleID: TLocaleID): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, False, LocaleID);
end;

class function TStringHelper.CompareOrdinal(const StrA, StrB: string): Integer;
var
  MaxLen: Integer;
begin
  if StrA.Length > StrB.Length then
    MaxLen := StrA.Length
  else
    MaxLen := StrB.Length;
  Result := System.SysUtils.StrLComp(PChar(@StrA[0]), PChar(@StrB[0]), MaxLen);
end;

class function TStringHelper.CompareOrdinal(const StrA: string; IndexA: Integer; const StrB: string; IndexB,
  Length: Integer): Integer;
begin
  Result := System.SysUtils.StrLComp(PChar(@StrA[IndexA]), PChar(@StrB[IndexB]), Length);
end;

class function TStringHelper.CompareText(const StrA: string; const StrB: string): Integer;
begin
  Result := System.SysUtils.CompareText(StrA, StrB);
end;

class function TStringHelper.ToBoolean(const S: string): Boolean;
begin
  Result := StrToBool(S);
end;

class function TStringHelper.ToInteger(const S: string): Integer;
begin
  Result := StrToInt(S);
end;

class function TStringHelper.ToSingle(const S: string): Single;
begin
  Result := StrToFloat(S);
end;

class function TStringHelper.ToDouble(const S: string): Double;
begin
  Result := StrToFloat(S);
end;

class function TStringHelper.ToExtended(const S: string): Extended;
begin
  Result := StrToFloat(S);
end;

class function TStringHelper.Parse(const Value: Integer): string;
begin
  Result := IntToStr(Value);
end;

class function TStringHelper.Parse(const Value: Int64): string;
begin
  Result := IntToStr(Value);
end;

class function TStringHelper.Parse(const Value: Boolean): string;
begin
  Result := BoolToStr(Value);
end;

class function TStringHelper.Parse(const Value: Extended): string;
begin
  Result := FloatToStr(Value);
end;

class function TStringHelper.LowerCase(const S: string): string;
begin
  Result := System.SysUtils.LowerCase(S);
end;

class function TStringHelper.LowerCase(const S: string; LocaleOptions: TLocaleOptions): string;
begin
  Result := System.SysUtils.LowerCase(S, LocaleOptions);
end;

class function TStringHelper.UpperCase(const S: string): string;
begin
  Result := System.SysUtils.UpperCase(S);
end;

class function TStringHelper.UpperCase(const S: string; LocaleOptions: TLocaleOptions): string;
begin
  Result := System.SysUtils.UpperCase(S, LocaleOptions);
end;

function TStringHelper.CompareTo(const strB: string): Integer;
begin
  Result := System.SysUtils.StrComp(PChar(Self), PChar(strB));
end;

function TStringHelper.Contains(const Value: string): Boolean;
begin
  Result := System.Pos(Value, Self) > 0;
end;

class function TStringHelper.Copy(const Str: string): string;
begin
  Result := System.Copy(Str, 1, Str.Length);
end;

procedure TStringHelper.CopyTo(SourceIndex: Integer; var Destination: array of Char; DestinationIndex, Count: Integer);
begin
  Move(PChar(PChar(Self)+SourceIndex)^, Destination[DestinationIndex], Count * SizeOf(Char));
end;

function TStringHelper.CountChar(const C: Char): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I:= 0 to High(Self) do
    if Self[I] = C then
      Inc(Result);
end;

class function TStringHelper.Create(C: Char; Count: Integer): string;
begin
  Result := StringOfChar(C, Count);
end;

class function TStringHelper.Create(const Value: array of Char; StartIndex, Length: Integer): string;
begin
  SetLength(Result, Length);
  Move(Value[StartIndex], PChar(PChar(Result))^, Length * SizeOf(Char));
end;

class function TStringHelper.Create(const Value: array of Char): string;
begin
  SetLength(Result, System.Length(Value));
  Move(Value[0], PChar(PChar(Result))^, System.Length(Value) * SizeOf(Char));
end;

function TStringHelper.DeQuotedString(const QuoteChar: Char): string;
var
  I:Integer;
  LastQuoted: Boolean;
  LPosDest: integer;
  LResult: array of Char;
begin
  if (self.Length >= 2) and (self[0] = QuoteChar) and (self[High(self)] = QuoteChar) then
  begin
    LastQuoted := False;
    LPosDest := 0;
    SetLength(LResult, Self.Length-2);
    For I := 1 to High(Self)-1 do
    begin
      if (Self[I] = QuoteChar) then
      begin
        if LastQuoted then
        begin
          LastQuoted := False;
          LResult[LPosDest] := Self[I];
          Inc(LPosDest);
        end
        else LastQuoted := True;
      end
      else begin
        if LastQuoted then
        begin
          LastQuoted := false;
          // The quoted char is not doubled, should we put in the resulting string?
        end;
        LResult[LPosDest] := Self[I];
        Inc(LPosDest);
      end;
    end;
    Result := string.Create(LResult, 0, LPosDest)
  end
  else
    Result := Self;
end;

function TStringHelper.DeQuotedString: string;
begin
  Result := Self.DeQuotedString('''');
end;

class function TStringHelper.EndsText(const ASubText, AText: string): Boolean;
var
  SubTextLocation: Integer;
begin
  SubTextLocation := AText.Length - ASubText.Length;
  if (SubTextLocation >= 0) and (ASubText <> '') and
     (ByteType(AText, SubTextLocation) <> mbTrailByte) then
    Result := AnsiStrIComp(PChar(ASubText), PChar(@AText[SubTextLocation])) = 0
  else
    Result := False;
end;

function TStringHelper.EndsWith(const Value: string; IgnoreCase: Boolean): Boolean;
var
  SubTextLocation: Integer;
begin
  if IgnoreCase then
      Result := EndsText(Value, Self)
  else
  begin
    SubTextLocation := Self.Length - Value.Length;
    if (SubTextLocation >= 0) and (Value <> Empty) and
       (ByteType(Self, SubTextLocation) <> mbTrailByte) then
      Result := string.Compare(Value, 0, Self, SubTextLocation, Value.Length, False) = 0
    else
	    Result := False;
  end;
end;

function TStringHelper.EndsWith(const Value: string): Boolean;
begin
  Result := EndsWith(Value, False);
end;

class function TStringHelper.Equals(const a, b: string): Boolean;
begin
  Result := a = b;
end;

function TStringHelper.Equals(const Value: string): Boolean;
begin
  Result := Self = Value;
end;

class function TStringHelper.Format(const Format: string; const args: array of const): string;
begin
  Result := System.SysUtils.Format(Format, args);
end;

function TStringHelper.GetChars(Index: Integer): Char;
begin
  Result := Self[Index];
end;

function TStringHelper.GetHashCode: Integer;
var
  LResult: UInt32;
  I: Integer;
  Temp: string;
begin
// Used HashNameMBCS function
  Temp := Self.ToUpper; // ToUpperInvariant ????

  LResult := 0;
  for I := 0 to Temp.Length - 1 do
  begin
    LResult := (LResult shl 5) or (LResult shr 27); //ROL Result, 5
    LResult := LResult xor UInt32(Temp[I]);
  end;
  Result := LResult;
end;

function TStringHelper.GetLength: Integer;
begin
  Result := System.Length(Self);
end;

function TStringHelper.IndexOf(Value: Char; StartIndex, Count: Integer): Integer;
begin
  Result := System.Pos(Value, Self, StartIndex + 1) - 1;
  if (Result + 1) > (StartIndex + Count) then
    Result := -1;
end;

function TStringHelper.IndexOf(const Value: string; StartIndex, Count: Integer): Integer;
begin
  Result := System.Pos(Value, Self, StartIndex + 1) - 1;
  if (Result + Value.Length) > (StartIndex + Count) then
    Result := -1;
end;

function TStringHelper.IndexOf(const Value: string; StartIndex: Integer): Integer;
begin
  Result := System.Pos(Value, Self, StartIndex + 1) - 1;
end;

function TStringHelper.IndexOf(const Value: string): Integer;
begin
  Result := System.Pos(Value, Self) - 1;
end;

function TStringHelper.IndexOf(value: Char): Integer;
begin
  Result := System.Pos(Value, Self) - 1;
end;

function TStringHelper.IndexOf(Value: Char; StartIndex: Integer): Integer;
begin
  Result := System.Pos(Value, Self, StartIndex + 1) - 1;
end;

function TStringHelper.IndexOfAny(const AnyOf: array of Char; StartIndex, Count: Integer): Integer;
var
  I: Integer;
  C: Char;
  Max: Integer;
begin
  if (StartIndex + Count) >= Self.Length then
    Max := Self.Length
  else
    Max := StartIndex + Count;

  I := StartIndex;
  while I < Max do
  begin
    for C in AnyOf do
      if Self[I] = C then
        Exit(I);
    Inc(I);
  end;
  Result := -1;
end;

function TStringHelper.IndexOfAny(const AnyOf: array of Char; StartIndex: Integer): Integer;
begin
  Result := IndexOfAny(AnyOf, StartIndex, Self.Length);
end;

function TStringHelper.IndexOfAny(const AnyOf: array of Char): Integer;
begin
  Result := IndexOfAny(AnyOf, 0, Self.Length);
end;

function TStringHelper.Insert(StartIndex: Integer; const Value: string): string;
begin
  System.Insert(Value, Self, StartIndex + 1);
  Result := Self;
end;

function TStringHelper.IsDelimiter(const Delimiters: string; Index: Integer): Boolean;
begin
  Result := False;
  if (Index < Low(string)) or (Index > High(Self)) or (ByteType(Self, Index) <> mbSingleByte) then exit;
  Result := StrScan(PChar(Delimiters), Self[Index]) <> nil;
end;

function TStringHelper.IsEmpty: Boolean;
begin
  Result := Self = Empty;
end;

class function TStringHelper.IsNullOrEmpty(const Value: string): Boolean;
begin
  Result := Value = Empty;
end;

class function TStringHelper.IsNullOrWhiteSpace(const Value: string): Boolean;
begin
  Result := Value.Trim.Length = 0;
end;

class function TStringHelper.Join(const Separator: string; const Values: array of string): string;
begin
  Result := Join(Separator, Values, 0, System.Length(Values));
end;

class function TStringHelper.Join(const Separator: string; const Values: IEnumerable<string>): string;
var
  eValues: IEnumerator<string>;
begin
  if Assigned(Values) then
  begin
    eValues := Values.GetEnumerator;
    Result := eValues.Current;
    while eValues.MoveNext do
      Result := Separator + eValues.Current;
  end
  else Result := '';
end;

class function TStringHelper.Join(const Separator: string; const Values: IEnumerator<string>): string;
begin
  if Assigned(Values) then
  begin
    Result := Values.Current;
    while Values.MoveNext do
      Result := Separator + Values.Current;
  end
  else Result := '';
end;

class function TStringHelper.Join(const Separator: string; const Value: array of string; StartIndex,
  Count: Integer): string;
var
  I: Integer;
  Max: Integer;
begin
  if StartIndex >= System.Length(Value) then
    raise ERangeError.Create(SRangeError);

  if (StartIndex + Count) > System.Length(Value) then
    Max := System.Length(Value)
  else
    Max := StartIndex + Count;

  Result := Value[StartIndex];
  for I:= StartIndex + 1 to Max - 1 do
    Result := Result + Separator + Value[I];
end;

class function TStringHelper.Join(const Separator: string; const values: array of const): string;
var
  I: Integer;
  len: Integer;
  function ValueToString(const val: TVarRec):string;
  begin
    case val.VType of
      vtInteger    :
        Result := IntToStr(val.VInteger);
      vtBoolean    :
        Result := BoolToStr(val.VBoolean, True);
      vtChar       :
        Result := Char(val.VChar);
      vtExtended   :
        Result := FloatToStr(val.VExtended^);
      vtPChar      :
        Result := string(val.VPChar);
      vtObject     :
        Result := TObject(val.VObject).Classname;
      vtClass      :
        Result := val.VClass.Classname;
      vtCurrency   :
        Result := CurrToStr(val.VCurrency^);
      vtInt64    :
        Result := IntToStr(PInt64(val.VInt64)^);
      vtUnicodeString :
        Result := string(val.VUnicodeString);
    else
        Result := Format('(Unknown) : %d',[val.VType]);
    end;
  end;
begin
  len := System.Length(Values);
  if len = 0 then
    Result := ''
  else begin
    Result := ValueToString(Values[0]);
    for I := 1 to len-1 do
      Result := Result + Separator + ValueToString(Values[I]);
  end;
end;

function TStringHelper.LastIndexOf(const Value: string; StartIndex: Integer): Integer;
begin
  Result := LastIndexOf(Value, StartIndex, StartIndex+1);
end;

function TStringHelper.LastIndexOf(Value: Char; StartIndex: Integer): Integer;
begin
  Result := LastIndexOf(Value, StartIndex, StartIndex+1);
end;

function TStringHelper.LastIndexOf(Value: Char): Integer;
begin
  Result := LastIndexOf(Value, Self.Length - 1, Self.Length);
end;

function TStringHelper.LastIndexOf(const Value: string): Integer;
begin
  Result := LastIndexOf(Value, Self.Length - 1, Self.Length);
end;

function TStringHelper.LastDelimiter(const Delims: string): Integer;
var
  I, J: Integer;
begin
  I := High(Self);
  while I >= Low(string) do
  begin
    for J := Low(string) to High(Delims) do
      if Self.Chars[I] = Delims.Chars[J] then
        Exit(I);
    Dec(I);
  end;
  Result := -1;
end;

function TStringHelper.LastIndexOf(const Value: string; StartIndex, Count: Integer): Integer;
var
  I: Integer;
  Min: Integer;
begin
  I := StartIndex;
  if (I - Count) < 0 then
    Min := 0
  else
    Min := I - Count;
  while I >= Min do
  begin
    if SubString(I, (StartIndex - I) + 1).Contains(Value) then
      Exit(I);
    Dec(I);
  end;
  Result := -1;
end;

function TStringHelper.LastIndexOf(Value: Char; StartIndex, Count: Integer): Integer;
var
  I: Integer;
  Min: Integer;
begin
  I := StartIndex;
  if (I - Count) < 0 then
    Min := 0
  else
    Min := I - Count;
  while I >= Min do
  begin
    if Self[I] = Value then
      Exit(I);
    Dec(I);
  end;
  Result := -1;
end;

function TStringHelper.LastIndexOfAny(const AnyOf: array of Char): Integer;
begin
  Result := LastIndexOfAny(AnyOf, Self.Length - 1, Self.Length);
end;

function TStringHelper.LastIndexOfAny(const AnyOf: array of Char; StartIndex, Count: Integer): Integer;
var
  I: Integer;
  Min: Integer;
  C: Char;
begin
  I := StartIndex;
  if (I - Count) < 0 then
    Min := 0
  else
    Min := I - Count;
  while I >= Min do
  begin
    for C in AnyOf do
      if Self.Chars[I] = C then
        Exit(I);
    Dec(I);
  end;
  Result := -1;
end;

function TStringHelper.LastIndexOfAny(const AnyOf: array of Char; StartIndex: Integer): Integer;
begin
  Result := LastIndexOfAny(AnyOf, StartIndex, Self.Length);
end;

function TStringHelper.PadLeft(TotalWidth: Integer): string;
begin
  Result := PadLeft(TotalWidth, ' ');
end;

function TStringHelper.PadLeft(TotalWidth: Integer; PaddingChar: Char): string;
begin
  TotalWidth := TotalWidth - Length;
  if TotalWidth > 0 then
    Result := System.StringOfChar(PaddingChar, TotalWidth) + Self
  else
    Result := Self;
end;

function TStringHelper.PadRight(TotalWidth: Integer): string;
begin
  Result := PadRight(TotalWidth, ' ');
end;

function TStringHelper.PadRight(TotalWidth: Integer; PaddingChar: Char): string;
begin
  TotalWidth := TotalWidth - Length;
  if TotalWidth > 0 then
    Result := Self + System.StringOfChar(PaddingChar, TotalWidth)
  else
    Result := Self;
end;

function TStringHelper.QuotedString(const QuoteChar: Char): string;
var
  I: Integer;
begin
  Result := Self.Substring(0);
  for I := Result.Length - 1 downto 0 do
    if Result.Chars[I] = QuoteChar then Result := Result.Insert(I, QuoteChar);
  Result := QuoteChar + Result + QuoteChar;
end;

function TStringHelper.QuotedString: string;
var
  I: Integer;
begin
  Result := Self.Substring(0);
  for I := Result.Length - 1 downto 0 do
    if Result.Chars[I] = '''' then Result := Result.Insert(I, '''');
  Result := '''' + Result + '''';
end;

function TStringHelper.Remove(StartIndex, Count: Integer): string;
begin
  Result := Self;
  System.Delete(Result, StartIndex + 1, Count);
end;

function TStringHelper.Remove(StartIndex: Integer): string;
begin
  Result := Self;
  System.Delete(Result, StartIndex + 1, Result.Length);
end;

function TStringHelper.Replace(OldChar, NewChar: Char): string;
begin
  Result := System.SysUtils.StringReplace(Self, OldChar, NewChar, [rfReplaceAll]);
end;

function TStringHelper.Replace(OldChar: Char; NewChar: Char; ReplaceFlags: TReplaceFlags): string;
begin
  Result := System.SysUtils.StringReplace(Self, OldChar, NewChar, ReplaceFlags);
end;

function TStringHelper.Replace(const OldValue, NewValue: string): string;
begin
  Result := System.SysUtils.StringReplace(Self, OldValue, NewValue, [rfReplaceAll]);
end;

function TStringHelper.Replace(const OldValue: string; const NewValue: string; ReplaceFlags: TReplaceFlags): string;
begin
  Result := System.SysUtils.StringReplace(Self, OldValue, NewValue, ReplaceFlags);
end;

function TStringHelper.Split(const Separator: array of Char; Options: TStringSplitOptions): TArray<string>;
begin
  Result := Split(Separator, MaxInt, Options);
end;

function TStringHelper.Split(const Separator: array of Char; Count: Integer): TArray<string>;
begin
  Result := Split(Separator, Count, None);
end;

function TStringHelper.Split(const Separator: array of Char): TArray<string>;
begin
  Result := Split(Separator, MaxInt, None);
end;

function TStringHelper.IndexOfAny(const Values: array of string; var Index: Integer): Integer;
var
  C, P: Integer;
begin
  for C := 0 to High(Values) do
  begin
    P := IndexOf(Values[C]);
    if P >= 0 then
    begin
      Index := C;
      Exit(P);
    end;
  end;
  Result := -1;
end;

function TStringHelper.Split(const Separator: array of string; Count: Integer;
  Options: TStringSplitOptions): TArray<string>;
var
  P: Integer;
  Total: Integer;
  Index: Integer;
  S, ToSplit: string;
begin
  Total := 0;
  ToSplit := Self;
  P := ToSplit.IndexOfAny(Separator, Index);
  while (P >= 0) and (Total < Count) do
  begin
    S := ToSplit.Substring(0, P);
    if (S <> Empty) or ((S = Empty) and (Options <> ExcludeEmpty)) then
    begin
      Inc(Total);
      SetLength(Result, Total);
      Result[Total - 1] := S;
    end;
    ToSplit := ToSplit.Substring(P + Separator[Index].Length);
    P := ToSplit.IndexOfAny(Separator, Index);
  end;

  if (ToSplit <> Empty) and (Total < Count) then
  begin
    Inc(Total);
    SetLength(Result, Total);
    Result[Total - 1] := ToSplit;
  end;
end;

function TStringHelper.Split(const Separator: array of Char; Count: Integer;
  Options: TStringSplitOptions): TArray<string>;
var
  P: Integer;
  Total: Integer;
  S: string;
  ToSplit: string;
begin
  Total := 0;
  ToSplit := Self;
  P := ToSplit.IndexOfAny(Separator);
  while (P >= 0) and (Total < Count) do
  begin
    S := ToSplit.Substring(0, P);
    if (S <> Empty) or ((S = Empty) and (Options <> ExcludeEmpty)) then
    begin
      Inc(Total);
      SetLength(Result, Total);
      Result[Total - 1] := S;
    end;
    ToSplit := ToSplit.Substring(P + 1);
    P := ToSplit.IndexOfAny(Separator);
  end;

  if (ToSplit <> Empty) and (Total < Count) then
  begin
    Inc(Total);
    SetLength(Result, Total);
    Result[Total - 1] := ToSplit;
  end;
end;

function TStringHelper.Split(const Separator: array of string; Options: TStringSplitOptions): TArray<string>;
begin
  Result := Split(Separator, MaxInt, Options);
end;

function TStringHelper.StartsWith(const Value: string): Boolean;
begin
  Result := StartsWith(Value, False);
end;

function TStringHelper.StartsWith(const Value: string; IgnoreCase: Boolean): Boolean;
begin
  if not IgnoreCase then
    Result := System.SysUtils.StrLComp(PChar(Self), PChar(Value), Value.Length) = 0
  else
    Result := System.SysUtils.StrLIComp(PChar(Self), PChar(Value), Value.Length) = 0;
end;

function TStringHelper.Substring(StartIndex: Integer): string;
begin
  Result := System.Copy(Self, StartIndex + 1, Self.Length);
end;

function TStringHelper.Substring(StartIndex, Length: Integer): string;
begin
  Result := System.Copy(Self, StartIndex + 1, Length);
end;

function TStringHelper.ToBoolean: Boolean;
begin
  Result := StrToBool(Self);
end;

function TStringHelper.ToInteger: Integer;
begin
  Result := StrToInt(Self);
end;

function TStringHelper.ToSingle: Single;
begin
  Result := StrToFloat(Self);
end;

function TStringHelper.ToDouble: Double;
begin
  Result := StrToFloat(Self);
end;

function TStringHelper.ToExtended: Extended;
begin
  Result := StrToFloat(Self);
end;

function TStringHelper.ToCharArray: TArray<Char>;
begin
  Result := ToCharArray(0, Self.Length);
end;

function TStringHelper.ToCharArray(StartIndex, Length: Integer): TArray<Char>;
begin
  SetLength(Result, Length);
  Move(PChar(PChar(Self) + StartIndex)^, Result[0], Length * SizeOf(Char));
end;

function TStringHelper.ToLower: string;
begin
  Result := ToLower(SysLocale.DefaultLCID);
end;

function TStringHelper.ToLower(LocaleID: TLocaleID): string;
{$IF Defined(MSWINDOWS)}
begin
  Result := Self;
  if Result <> '' then
  begin
    UniqueString(Result);

    if LCMapString(LocaleID, LCMAP_LOWERCASE or LCMAP_LINGUISTIC_CASING, PChar(Self), Self.Length,
       PChar(Result), Result.Length) = 0 then
      RaiseLastOSError;
  end;
end;
{$ELSEIF Defined(MACOS)}
var
  MutableStringRef: CFMutableStringRef;
begin
  Result := Self;
  if Result <> '' then
  begin
    UniqueString(Result);
    MutableStringRef := CFStringCreateMutableWithExternalCharactersNoCopy(kCFAllocatorDefault,
      PChar(Result), Result.Length, Result.Length, kCFAllocatorNull);
    if MutableStringRef <> nil then
    try
      if LocaleID = nil then
        LocaleID := UTF8CompareLocale;
      CFStringLowercase(MutableStringRef, LocaleID);
    finally
      CFRelease(MutableStringRef);
    end else
      raise ECFError.Create(SCFStringFailed);
  end;
end;
{$ELSE !MSWINDOWS !MACOS}
begin
  Error(rePlatformNotImplemented);
end;
{$ENDIF !MSWINDOWS !MACOS}

function TStringHelper.ToLowerInvariant: string;
begin
  Result := Char.ToLower(Self);
end;

function TStringHelper.ToUpper: string;
begin
  Result := ToUpper(SysLocale.DefaultLCID);
end;

function TStringHelper.ToUpper(LocaleID: TLocaleID): string;
{$IF Defined(MSWINDOWS)}
begin
  Result := Self;
  if Result <> '' then
  begin
    UniqueString(Result);

    if LCMapString(LocaleID, LCMAP_UPPERCASE or LCMAP_LINGUISTIC_CASING, PChar(Self), Self.Length,
       PChar(Result), Result.Length) = 0 then
      RaiseLastOSError;
  end;
end;
{$ELSEIF Defined(MACOS)}
var
  MutableStringRef: CFMutableStringRef;
begin
  Result := Self;
  if Result <> '' then
  begin
    UniqueString(Result);
    MutableStringRef := CFStringCreateMutableWithExternalCharactersNoCopy(kCFAllocatorDefault,
      PChar(Result), Result.Length, Result.Length, kCFAllocatorNull);
    if MutableStringRef <> nil then
    try
      if LocaleID = nil then
        LocaleID := UTF8CompareLocale;
      CFStringUppercase(MutableStringRef, LocaleID);
	finally
      CFRelease(MutableStringRef);
    end else
      raise ECFError.Create(SCFStringFailed);
  end;
end;
{$ELSE !MSWINDOWS !MACOS}
begin
  Error(rePlatformNotImplemented);
end;
{$ENDIF !MSWINDOWS !MACOS}

function TStringHelper.ToUpperInvariant: string;
begin
  Result := Char.ToUpper(Self);
end;

function TStringHelper.Trim: string;
var
  I, L: Integer;
begin
  L := Self.Length - 1;
  I := 0;
  if (L > -1) and (Self[I] > ' ') and (Self[L] > ' ') then Exit(Self);
  while (I <= L) and (Self[I] <= ' ') do Inc(I);
  if I > L then Exit('');
  while Self[L] <= ' ' do Dec(L);
  Result := Self.SubString(I, L - I + 1);
end;

function TStringHelper.TrimLeft: string;
var
  I, L: Integer;
begin
  L := Self.Length - 1;
  I := 0;
  while (I <= L) and (Self[I] <= ' ') do Inc(I);
  if I > 0 then
    Result := Self.SubString(I)
  else
    Result := Self;
end;

function TStringHelper.TrimRight: string;
var
  I: Integer;
begin
  I := Self.Length - 1;
  if (I >= 0) and (Self[I] > ' ') then Result := Self
  else begin
    while (I >= 0) and (Self.Chars[I] <= ' ') do Dec(I);
    Result := Self.SubString(0, I + 1);
  end;
end;

function TStringHelper.Trim(const TrimChars: array of Char): string;
var
  I, L: Integer;
begin
  L := Self.Length - 1;
  I := 0;
  if (L > 0) and (not CharInArray(Self[I], TrimChars)) and (not CharInArray(Self[L], TrimChars)) then
    Exit(Self);
  while (I <= L) and (CharInArray(Self[I], TrimChars)) do
    Inc(I);
  if I > L then Exit('');
  while CharInArray(Self[L], TrimChars) do
    Dec(L);
  Result := Self.Substring( I, L - I + 1);
end;

function TStringHelper.TrimLeft(const TrimChars: array of Char): string;
var
  I, L: Integer;
begin
  L := Self.Length;
  I := 0;
  while (I < L) and (CharInArray(Self[I], TrimChars)) do
    Inc(I);
  if I > 0 then
    Result := Self.SubString(I)
  else
    Result := Self;
end;

function TStringHelper.TrimRight(const TrimChars: array of Char): string;
var
  I: Integer;
begin
  I := Self.Length-1;
  if (I > 0) and (not CharInArray(Self[I], TrimChars)) then
    Exit(Self);
  Dec(I);
  while (I >= 0) and (CharInArray(Self[I], TrimChars)) do
    Dec(I);
  Result := Self.SubString(0, I+1);
end;

function TStringHelper.TrimEnd(const TrimChars: array of Char): string;
begin
  Result := Self.TrimRight(TrimChars);
end;

function TStringHelper.TrimStart(const TrimChars: array of Char): string;
begin
  Result := Self.TrimLeft(TrimChars);
end;
{$IFNDEF NEXTGEN}
{$ZEROBASEDSTRINGS OFF}
{$ENDIF}

{ TSingleHelper }

class function TSingleHelper.ToString(const Value: Single): string;
begin
  Result := FloatToStr(Value);
end;

class function TSingleHelper.ToString(const Value: Single; const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStr(Value, AFormatSettings);
end;

class function TSingleHelper.ToString(const Value: Single; const Format: TFloatFormat; const Precision, Digits: Integer): string;
begin
  Result := FloatToStrF(Value, Format, Precision, Digits);
end;

class function TSingleHelper.ToString(const Value: Single; const Format: TFloatFormat; const Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStrF(Value, Format, Precision, Digits, AFormatSettings);
end;

class function TSingleHelper.Parse(const S: string): Single;
var
  E: Extended;
begin
  E := StrToFloat(S);
  if (E > Single.MaxValue) or (E < Single.MinValue)  then
    raise EConvertError.CreateResFmt(@SInvalidFloat, [S])
  else
    Result := E;
end;

class function TSingleHelper.Parse(const S: string; const AFormatSettings: TFormatSettings): Single;
var
  E: Extended;
begin
  E := StrToFloat(S, AFormatSettings);
  if (E > Single.MaxValue) or (E < Single.MinValue)  then
    raise EConvertError.CreateResFmt(@SInvalidFloat, [S])
  else
    Result := E;
end;

class function TSingleHelper.TryParse(const S: string; out Value: Single): Boolean;
begin
  Result := TryStrToFloat(S, Value);
end;

class function TSingleHelper.TryParse(const S: string; out Value: Single; const AFormatSettings: TFormatSettings): Boolean;
begin
  Result := TryStrToFloat(S, Value, AFormatSettings);
end;

class function TSingleHelper.IsNan(const Value: Single): Boolean;
begin
  Result := (Value.SpecialType = TFloatSpecial.fsNan);
end;

class function TSingleHelper.IsInfinity(const Value: Single): Boolean;
var
  FloatType: TFloatSpecial;
begin
  FloatType := Value.SpecialType;
  Result := (FloatType = fsInf) or (FloatType = fsNInf);
end;

class function TSingleHelper.IsNegativeInfinity(const Value: Single): Boolean;
begin
  Result := (Value.SpecialType = TFloatSpecial.fsNInf);
end;

class function TSingleHelper.IsPositiveInfinity(const Value: Single): Boolean;
begin
  Result := (Value.SpecialType = TFloatSpecial.fsInf);
end;

class function TSingleHelper.Size: Integer;
begin
  Result := SizeOf(Single);
end;

function TSingleHelper.ToString: string;
begin
  Result := FloatToStr(Self);
end;

function TSingleHelper.ToString(const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStr(Self, AFormatSettings);
end;

function TSingleHelper.ToString(const Format: TFloatFormat; const Precision, Digits: Integer): string;
begin
  Result := FloatToStrF(Self, Format, Precision, Digits);
end;

function TSingleHelper.ToString(const Format: TFloatFormat; const Precision, Digits: Integer;
                         const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStrF(Self, Format, Precision, Digits, AFormatSettings);
end;

function TSingleHelper.IsNan: Boolean;
begin
  Result := (Self.SpecialType = TFloatSpecial.fsNan);
end;

function TSingleHelper.IsInfinity: Boolean;
var
  FloatType: TFloatSpecial;
begin
  FloatType := Self.SpecialType;
  Result := (FloatType = fsInf) or (FloatType = fsNInf);
end;

function TSingleHelper.IsNegativeInfinity: Boolean;
begin
  Result := (Self.SpecialType = TFloatSpecial.fsNInf);
end;

function TSingleHelper.IsPositiveInfinity: Boolean;
begin
  Result := (Self.SpecialType = TFloatSpecial.fsInf);
end;

procedure TSingleHelper.BuildUp(const SignFlag: Boolean; const Mantissa: UInt64;
  const Exponent: Integer);
begin
  Self := 0.0;
  Sign := SignFlag;
  Exp := Exponent + $7F;
  Frac := Mantissa and $007FFFFF;
end;

function TSingleHelper.Exponent: Integer;
var
  E, F: UInt64;
begin
  E := GetExp;
  F := GetFrac;
  if (0 < E) and (E < $FF) then
    Result := E - $7F
  else if (E = 0) and (F <> 0) then
    Result := -126 // Denormal
  else if (E = 0) and (F = 0) then
    Result := 0 // +/-Zero
  else
    Result := 0; // +/-INF, NaN
end;

function TSingleHelper.Fraction: Extended;
var
  E, F: UInt64;
begin
  E := GetExp;
  F := GetFrac;
  if E = $FF then
  begin
    if F = 0 then // +/- INF.
      Result := Extended.PositiveInfinity
    else // NaN
      Result := Extended.Nan;
  end
  else if E = 0 then
    Result := (F / $00800000)
  else
    Result := 1.0 + (F / $00800000);
end;

function TSingleHelper.Mantissa: UInt64;
var
  E, F: UInt64;
begin
  E := GetExp;
  F := GetFrac;
  Result := F;
  if (0 < E) and (E < $FF) then
    Result := Result or (UInt64(1) shl 23);
end;

function TSingleHelper.InternalGetBytes(Index: Cardinal): UInt8;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
begin
  Result := PByteArray(@Self)[Index];
end;

function TSingleHelper.InternalGetWords(Index: Cardinal): UInt16;
type
  PWordArray = ^TWordArray;
  TWordArray = array[0..16383] of Word;
begin
  Result := PWordArray(@Self)[Index];
end;

procedure TSingleHelper.InternalSetBytes(Index: Cardinal; const Value: UInt8);
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
begin
  PByteArray(@Self)[Index] := Value;
end;

procedure TSingleHelper.InternalSetWords(Index: Cardinal; const Value: UInt16);
type
  PWordArray = ^TWordArray;
  TWordArray = array[0..16383] of Word;
begin
  PWordArray(@Self)[Index] := Value;
end;

function TSingleHelper.GetBytes(Index: Cardinal): UInt8;
begin
  if Index >= 4 then System.Error(reRangeError);
  Result := InternalGetBytes(Index);
end;

function TSingleHelper.GetWords(Index: Cardinal): UInt16;
begin
  if Index >= 2 then System.Error(reRangeError);
  Result := InternalGetWords(Index);
end;

function TSingleHelper.GetExp: UInt64;
begin
  Result := (InternalGetWords(1) shr 7) and $FF;
end;

function TSingleHelper.GetFrac: UInt64;
type
  PLongWord = ^LongWord;
begin
  Result := PLongWord(@Self)^ and $007FFFFF;
end;

function TSingleHelper.GetSign: Boolean;
begin
  Result := InternalGetBytes(3) >= $80;
end;

procedure TSingleHelper.SetBytes(Index: Cardinal; const Value: UInt8);
begin
  if Index >= 4 then System.Error(reRangeError);
  InternalSetBytes(Index, Value);
end;

procedure TSingleHelper.SetWords(Index: Cardinal; const Value: UInt16);
begin
  if Index >= 2 then System.Error(reRangeError);
  InternalSetWords(Index, Value);
end;

procedure TSingleHelper.SetExp(NewExp: UInt64);
var
  W: Word;
begin
  W := InternalGetWords(1);
  W := (W and $807F) or ((NewExp and $FF) shl 7);
  InternalSetWords(1, W);
end;

procedure TSingleHelper.SetFrac(NewFrac: UInt64);
var
  LW: LongWord;
begin
  LW := PLongWord(@Self)^;
  LW := (LW and $FF800000) or (NewFrac and $007FFFFF);
  PLongWord(@Self)^ := LW;
end;

procedure TSingleHelper.SetSign(NewSign: Boolean);
var
  B: Byte;
begin
  B := InternalGetBytes(3);
  if NewSign then B := B or $80
  else            B := B and $7F;
  InternalSetBytes(3, B);
end;

function TSingleHelper.SpecialType: TFloatSpecial;
var
  I: LongWord;
  W: Word;
begin
  I := PLongWord(@self)^;
  W := InternalGetWords(1);

  if ($0080 <= W) and (W <= $7F7F) then
    Result := TFloatSpecial.fsPositive
  else if ($8080 <= W) and (W <= $FF7F) then
    Result := TFloatSpecial.fsNegative
  else if I = 0 then
    Result := TFloatSpecial.fsZero
  else if I = $80000000 then
    Result := TFloatSpecial.fsNZero
  else if w <= $007F then
    Result := TFloatSpecial.fsDenormal
  else if ($8000 <= w) and (w <= $807F) then
    Result := TFloatSpecial.fsNDenormal
  else if I = $7F800000 then
    Result := TFloatSpecial.fsInf
  else if I = $FF800000 then
    Result := TFloatSpecial.fsNInf
  else
    Result := TFloatSpecial.fsNan;
end;

{ TDoubleHelper }

class function TDoubleHelper.ToString(const Value: Double): string;
begin
  Result := FloatToStr(Value);
end;

class function TDoubleHelper.ToString(const Value: Double; const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStr(Value, AFormatSettings);
end;

class function TDoubleHelper.ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer): string;
begin
  Result := FloatToStrF(Value, Format, Precision, Digits);
end;

class function TDoubleHelper.ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStrF(Value, Format, Precision, Digits, AFormatSettings);
end;

class function TDoubleHelper.Parse(const S: string): Double;
{$IFDEF EXTENDEDIS10BYTES}
var
  E: Extended;
begin
  E := StrToFloat(S);
  if (E > Double.MaxValue) or (E < Double.MinValue)  then
    raise EConvertError.CreateResFmt(@SInvalidFloat, [S])
  else
    Result := E;
end;
{$ELSE  EXTENDEDIS10BYTES}
begin
  Result := StrToFloat(S);
end;
{$ENDIF EXTENDEDIS10BYTES}

class function TDoubleHelper.Parse(const S: string; const AFormatSettings: TFormatSettings): Double;
{$IFDEF EXTENDEDIS10BYTES}
var
  E: Extended;
begin
  E := StrToFloat(S, AFormatSettings);
  if (E > Double.MaxValue) or (E < Double.MinValue)  then
    raise EConvertError.CreateResFmt(@SInvalidFloat, [S])
  else
    Result := E;
end;
{$ELSE  EXTENDEDIS10BYTES}
begin
  Result := StrToFloat(S, AFormatSettings);
end;
{$ENDIF EXTENDEDIS10BYTES}

class function TDoubleHelper.TryParse(const S: string; out Value: Double): Boolean;
begin
  Result := TryStrToFloat(S, Value);
end;

class function TDoubleHelper.TryParse(const S: string; out Value: Double; const AFormatSettings: TFormatSettings): Boolean;
begin
  Result := TryStrToFloat(S, Value, AFormatSettings);
end;

class function TDoubleHelper.IsNan(const Value: Double): Boolean;
begin
  Result := (Value.SpecialType = TFloatSpecial.fsNan);
end;

class function TDoubleHelper.IsInfinity(const Value: Double): Boolean;
var
  FloatType: TFloatSpecial;
begin
  FloatType := Value.SpecialType;
  Result := (FloatType = fsInf) or (FloatType = fsNInf);
end;

class function TDoubleHelper.IsNegativeInfinity(const Value: Double): Boolean;
begin
  Result := (Value.SpecialType = TFloatSpecial.fsNInf);
end;

class function TDoubleHelper.IsPositiveInfinity(const Value: Double): Boolean;
begin
  Result := (Value.SpecialType = TFloatSpecial.fsInf);
end;

class function TDoubleHelper.Size: Integer;
begin
  Result := SizeOf(Double);
end;

function TDoubleHelper.ToString: string;
begin
  Result := FloatToStr(Self);
end;

function TDoubleHelper.ToString(const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStr(Self, AFormatSettings);
end;

function TDoubleHelper.ToString(const Format: TFloatFormat; const Precision, Digits: Integer): string;
begin
  Result := FloatToStrF(Self, Format, Precision, Digits);
end;

function TDoubleHelper.ToString(const Format: TFloatFormat; const Precision, Digits: Integer;
                         const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStrF(Self, Format, Precision, Digits, AFormatSettings);
end;

function TDoubleHelper.IsNan: Boolean;
begin
  Result := (Self.SpecialType = TFloatSpecial.fsNan);
end;

function TDoubleHelper.IsInfinity: Boolean;
var
  FloatType: TFloatSpecial;
begin
  FloatType := Self.SpecialType;
  Result := (FloatType = fsInf) or (FloatType = fsNInf);
end;

function TDoubleHelper.IsNegativeInfinity: Boolean;
begin
  Result := (Self.SpecialType = TFloatSpecial.fsNInf);
end;

function TDoubleHelper.IsPositiveInfinity: Boolean;
begin
  Result := (Self.SpecialType = TFloatSpecial.fsInf);
end;

procedure TDoubleHelper.BuildUp(const SignFlag: Boolean; const Mantissa: UInt64;
  const Exponent: Integer);
begin
  Self := 0.0;
  SetSign(SignFlag);
  SetExp(Exponent + $3FF);
  SetFrac(Mantissa and $000FFFFFFFFFFFFF);
end;

function TDoubleHelper.Exponent: Integer;
var
  E, F: UInt64;
begin
  E := GetExp;
  F := GetFrac;
  if (0 < E) and (E < $7FF) then
    Result := E - $3FF
  else if (E = 0) and (F <> 0) then
    Result := -1022 // Denormal
  else if (E = 0) and (F = 0) then
    Result := 0 // +/-Zero
  else
    Result := 0; // +/-INF, NaN
end;

function TDoubleHelper.Fraction: Extended;
var
  E, F: UInt64;
begin
  E := GetExp;
  F := GetFrac;
  if E = $7FF then
  begin
    if F = 0 then // +/- INF.
      Result := Extended.PositiveInfinity
    else // NaN
      Result := Extended.Nan;
  end
  else if E = 0 then
    Result := (F / $0010000000000000)
  else
    Result := 1.0 + (F / $0010000000000000);
end;

function TDoubleHelper.Mantissa: UInt64;
var
  E, F: UInt64;
begin
  E := GetExp;
  F := GetFrac;
  Result := F;
  if (0 < E) and (E < $7FF) then
    Result := Result or (UInt64(1) shl 52);
end;

function TDoubleHelper.InternalGetBytes(Index: Cardinal): UInt8;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
begin
  Result := PByteArray(@Self)[Index];
end;

function TDoubleHelper.InternalGetWords(Index: Cardinal): UInt16;
type
  PWordArray = ^TWordArray;
  TWordArray = array[0..16383] of Word;
begin
  Result := PWordArray(@Self)[Index];
end;

procedure TDoubleHelper.InternalSetBytes(Index: Cardinal; const Value: UInt8);
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
begin
  PByteArray(@Self)[Index] := Value;
end;

procedure TDoubleHelper.InternalSetWords(Index: Cardinal; const Value: UInt16);
type
  PWordArray = ^TWordArray;
  TWordArray = array[0..16383] of Word;
begin
  PWordArray(@Self)[Index] := Value;
end;

function TDoubleHelper.GetBytes(Index: Cardinal): UInt8;
begin
  if Index >= 8 then System.Error(reRangeError);
  Result := InternalGetBytes(Index);
end;

function TDoubleHelper.GetWords(Index: Cardinal): UInt16;
begin
  if Index >= 4 then System.Error(reRangeError);
  Result := InternalGetWords(Index);
end;

function TDoubleHelper.GetExp: UInt64;
begin
  Result := (InternalGetWords(3) shr 4) and $7FF;
end;

function TDoubleHelper.GetFrac: UInt64;
begin
  Result := PUInt64(@Self)^ and $000FFFFFFFFFFFFF;
end;

function TDoubleHelper.GetSign: Boolean;
begin
  Result := InternalGetBytes(7) >= $80;
end;

procedure TDoubleHelper.SetBytes(Index: Cardinal; const Value: UInt8);
begin
  if Index >= 8 then System.Error(reRangeError);
  InternalSetBytes(Index, Value);
end;

procedure TDoubleHelper.SetWords(Index: Cardinal; const Value: UInt16);
begin
  if Index >= 4 then System.Error(reRangeError);
  InternalSetWords(Index, Value);
end;

procedure TDoubleHelper.SetExp(NewExp: UInt64);
var
  W: Word;
begin
  W := InternalGetWords(3);
  W := (W and $800F) or ((NewExp and $7FF) shl 4);
  InternalSetWords(3, W);
end;

procedure TDoubleHelper.SetFrac(NewFrac: UInt64);
var
  U64: UInt64;
begin
  U64 := PUInt64(@Self)^;
  U64 := (U64 and $FFF0000000000000) or (NewFrac and $000FFFFFFFFFFFFF);
  PUInt64(@Self)^ := U64;
end;

procedure TDoubleHelper.SetSign(NewSign: Boolean);
var
  B: Byte;
begin
  B := InternalGetBytes(7);
  if NewSign then B := B or $80
  else            B := B and $7F;
  InternalSetBytes(7, B);
end;

function TDoubleHelper.SpecialType: TFloatSpecial;
var
  U64: UInt64;
  W: Word;
begin
  U64 := PUInt64(@self)^;
  W := InternalGetWOrds(3);

  if ($0010 <= W) and (W <= $7FEF) then
    Result := TFloatSpecial.fsPositive
  else if ($8010 <= W) and (W <= $FFEF) then
    Result := TFloatSpecial.fsNegative
  else if U64 = 0 then
    Result := TFloatSpecial.fsZero
  else if U64 = $8000000000000000 then
    Result := TFloatSpecial.fsNZero
  else if w <= $000F then
    Result := TFloatSpecial.fsDenormal
  else if ($8000 <= w) and (w <= $800F) then
    Result := TFloatSpecial.fsNDenormal
  else if U64 = $7FF0000000000000 then
    Result := TFloatSpecial.fsInf
  else if U64 = $FFF0000000000000 then
    Result := TFloatSpecial.fsNInf
  else
    Result := TFloatSpecial.fsNan;
end;

{ TExtendedHelper }

class function TExtendedHelper.ToString(const Value: Extended): string;
begin
  Result := FloatToStr(Value);
end;

class function TExtendedHelper.ToString(const Value: Extended; const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStr(Value, AFormatSettings);
end;

class function TExtendedHelper.ToString(const Value: Extended; const Format: TFloatFormat; const Precision, Digits: Integer): string;
begin
  Result := FloatToStrF(Value, Format, Precision, Digits);
end;

class function TExtendedHelper.ToString(const Value: Extended; const Format: TFloatFormat; const Precision, Digits: Integer;
  const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStrF(Value, Format, Precision, Digits, AFormatSettings);
end;

class function TExtendedHelper.Parse(const S: string): Extended;
begin
  Result := StrToFloat(S);
end;

class function TExtendedHelper.Parse(const S: string; const AFormatSettings: TFormatSettings): Extended;
begin
  Result := StrToFloat(S, AFormatSettings);
end;

class function TExtendedHelper.TryParse(const S: string; out Value: Extended): Boolean;
begin
  Result := TryStrToFloat(S, Value);
end;

class function TExtendedHelper.TryParse(const S: string; out Value: Extended; const AFormatSettings: TFormatSettings): Boolean;
begin
  Result := TryStrToFloat(S, Value, AFormatSettings);
end;

class function TExtendedHelper.IsNan(const Value: Extended): Boolean;
begin
  Result := (Value.SpecialType = TFloatSpecial.fsNan);
end;

class function TExtendedHelper.IsInfinity(const Value: Extended): Boolean;
var
  FloatType: TFloatSpecial;
begin
  FloatType := Value.SpecialType;
  Result := (FloatType = fsInf) or (FloatType = fsNInf);
end;

class function TExtendedHelper.IsNegativeInfinity(const Value: Extended): Boolean;
begin
  Result := (Value.SpecialType = TFloatSpecial.fsNInf);
end;

class function TExtendedHelper.IsPositiveInfinity(const Value: Extended): Boolean;
begin
  Result := (Value.SpecialType = TFloatSpecial.fsInf);
end;

class function TExtendedHelper.Size: Integer;
begin
  Result := SizeOf(Extended);
end;

function TExtendedHelper.ToString: string;
begin
  Result := FloatToStr(Self);
end;

function TExtendedHelper.ToString(const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStr(Self, AFormatSettings);
end;

function TExtendedHelper.ToString(const Format: TFloatFormat; const Precision, Digits: Integer): string;
begin
  Result := FloatToStrF(Self, Format, Precision, Digits);
end;

function TExtendedHelper.ToString(const Format: TFloatFormat; const Precision, Digits: Integer;
                         const AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStrF(Self, Format, Precision, Digits, AFormatSettings);
end;

function TExtendedHelper.IsNan: Boolean;
begin
  Result := (Self.SpecialType = TFloatSpecial.fsNan);
end;

function TExtendedHelper.IsInfinity: Boolean;
var
  FloatType: TFloatSpecial;
begin
  FloatType := Self.SpecialType;
  Result := (FloatType = fsInf) or (FloatType = fsNInf);
end;

function TExtendedHelper.IsNegativeInfinity: Boolean;
begin
  Result := (Self.SpecialType = TFloatSpecial.fsNInf);
end;

function TExtendedHelper.IsPositiveInfinity: Boolean;
begin
  Result := (Self.SpecialType = TFloatSpecial.fsInf);
end;

procedure TExtendedHelper.BuildUp(const SignFlag: Boolean; const Mantissa: UInt64;
  const Exponent: Integer);
begin
  Self := 0.0;
  SetSign(SignFlag);
{$IFDEF EXTENDEDIS10BYTES}
  SetExp(Exponent + $3FFF);
  SetFrac(Mantissa);
{$ELSE  EXTENDEDIS10BYTES}
  SetExp(Exponent + $3FF);
  SetFrac(Mantissa and $000FFFFFFFFFFFFF);
{$ENDIF EXTENDEDIS10BYTES}
end;

function TExtendedHelper.Exponent: Integer;
var
  E, F: UInt64;
begin
  E := GetExp;
  F := GetFrac;
{$IFDEF EXTENDEDIS10BYTES}
  if (0 < E) and (E < $7FFF) then
    Result := E - $3FFF
  else if (E = 0) and (F <> 0) then
    Result := -16382 // Denormal
  else if (E = 0) and (F = 0) then
    Result := 0 // +/-Zero
  else
    Result := 0; // +/-INF, NaN
{$ELSE  EXTENDEDIS10BYTES}
  if (0 < E) and (E < $7FF) then
    Result := E - $3FF
  else if (E = 0) and (F <> 0) then
    Result := -1022 // Denormal
  else if (E = 0) and (F = 0) then
    Result := 0 // +/-Zero
  else
    Result := 0; // +/-INF, NaN
{$ENDIF EXTENDEDIS10BYTES}
end;

function TExtendedHelper.Fraction: Extended;
var
  E, F: UInt64;
begin
  E := GetExp;
  F := GetFrac;
{$IFDEF EXTENDEDIS10BYTES}
  if E = $7FFF then
  begin
    if F = $8000000000000000 then // +/- INF.
      Result := Extended.PositiveInfinity
    else // NaN
      Result := Extended.Nan;
  end
  else
    Result := F / 9223372036854775808.0; // 2^63
{$ELSE  EXTENDEDIS10BYTES}
  if E = $7FF then
  begin
    if F = 0 then
    begin // +/- INF.
      if Sign then
        Result := Extended.PositiveInfinity
      else
        Result := Extended.NegativeInfinity;
    end
    else // NaN
      Result := Extended.Nan;
  end
  else if E = 0 then
    Result := (F / $0010000000000000)
  else
    Result := 1.0 + (F / $0010000000000000);
{$ENDIF EXTENDEDIS10BYTES}
end;

function TExtendedHelper.Mantissa: UInt64;
{$IFDEF EXTENDEDIS10BYTES}
begin
  Result := GetFrac;
end;
{$ELSE  EXTENDEDIS10BYTES}
var
  E, F: UInt64;
begin
  E := GetExp;
  F := GetFrac;
  Result := F;
  if (0 < E) and (E < $7FF) then
    Result := Result or (UInt64(1) shl 52);
end;
{$ENDIF EXTENDEDIS10BYTES}

function TExtendedHelper.InternalGetBytes(Index: Cardinal): UInt8;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
begin
  Result := PByteArray(@Self)[Index];
end;

function TExtendedHelper.InternalGetWords(Index: Cardinal): UInt16;
type
  PWordArray = ^TWordArray;
  TWordArray = array[0..16383] of Word;
begin
  Result := PWordArray(@Self)[Index];
end;

procedure TExtendedHelper.InternalSetBytes(Index: Cardinal; const Value: UInt8);
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
begin
  PByteArray(@Self)[Index] := Value;
end;

procedure TExtendedHelper.InternalSetWords(Index: Cardinal; const Value: UInt16);
type
  PWordArray = ^TWordArray;
  TWordArray = array[0..16383] of Word;
begin
  PWordArray(@Self)[Index] := Value;
end;

function TExtendedHelper.GetBytes(Index: Cardinal): UInt8;
begin
{$IFDEF EXTENDEDIS10BYTES}
  if Index >= 10 then System.Error(reRangeError);
{$ELSE  EXTENDEDIS10BYTES}
  if Index >= 8 then System.Error(reRangeError);
{$ENDIF EXTENDEDIS10BYTES}
  Result := InternalGetBytes(Index);
end;

function TExtendedHelper.GetWords(Index: Cardinal): UInt16;
begin
{$IFDEF EXTENDEDIS10BYTES}
  if Index >= 5 then System.Error(reRangeError);
{$ELSE  EXTENDEDIS10BYTES}
  if Index >= 4 then System.Error(reRangeError);
{$ENDIF EXTENDEDIS10BYTES}
  Result := InternalGetWords(Index);
end;

function TExtendedHelper.GetExp: UInt64;
begin
{$IFDEF EXTENDEDIS10BYTES}
  Result := InternalGetWords(4) and $7FFF;
{$ELSE  EXTENDEDIS10BYTES}
  Result := (InternalGetWords(3) shr 4) and $7FF;
{$ENDIF EXTENDEDIS10BYTES}
end;

function TExtendedHelper.GetFrac: UInt64;
begin
{$IFDEF EXTENDEDIS10BYTES}
  Result := PUInt64(@Self)^; // first 4 bytes are fraction part.
{$ELSE  EXTENDEDIS10BYTES}
  Result := PUInt64(@Self)^ and $000FFFFFFFFFFFFF;
{$ENDIF EXTENDEDIS10BYTES}
end;

function TExtendedHelper.GetSign: Boolean;
begin
{$IFDEF EXTENDEDIS10BYTES}
  Result := InternalGetBytes(9) >= $80;
{$ELSE  EXTENDEDIS10BYTES}
  Result := InternalGetBytes(7) >= $80;
{$ENDIF EXTENDEDIS10BYTES}
end;

procedure TExtendedHelper.SetBytes(Index: Cardinal; const Value: UInt8);
begin
{$IFDEF EXTENDEDIS10BYTES}
  if Index >= 10 then System.Error(reRangeError);
{$ELSE  EXTENDEDIS10BYTES}
  if Index >= 8 then System.Error(reRangeError);
{$ENDIF EXTENDEDIS10BYTES}
  InternalSetBytes(Index, Value);
end;

procedure TExtendedHelper.SetWords(Index: Cardinal; const Value: UInt16);
begin
{$IFDEF EXTENDEDIS10BYTES}
  if Index >= 5 then System.Error(reRangeError);
{$ELSE  EXTENDEDIS10BYTES}
  if Index >= 4 then System.Error(reRangeError);
{$ENDIF EXTENDEDIS10BYTES}
  InternalSetWords(Index, Value);
end;

procedure TExtendedHelper.SetExp(NewExp: UInt64);
var
  W: Word;
begin
{$IFDEF EXTENDEDIS10BYTES}
  W := InternalGetWords(4);
  W := (W and $8000) or (NewExp and $7FFF);
  InternalSetWords(4, W);
{$ELSE  EXTENDEDIS10BYTES}
  W := InternalGetWords(3);
  W := (W and $800F) or ((NewExp and $7FF) shl 4);
  InternalSetWords(3, W);
{$ENDIF EXTENDEDIS10BYTES}
end;

procedure TExtendedHelper.SetFrac(NewFrac: UInt64);
{$IFDEF EXTENDEDIS10BYTES}
begin
  PUint64(@Self)^ := NewFrac;
end;
{$ELSE  EXTENDEDIS10BYTES}
var
  U64: UInt64;
begin
  U64 := PUInt64(@Self)^;
  U64 := (U64 and $FFF0000000000000) or (NewFrac and $000FFFFFFFFFFFFF);
  PUint64(@Self)^ := U64;
end;
{$ENDIF EXTENDEDIS10BYTES}

procedure TExtendedHelper.SetSign(NewSign: Boolean);
var
  B: Byte;
begin
{$IFDEF EXTENDEDIS10BYTES}
  B := InternalGetBytes(9);
  if NewSign then B := B or $80
  else            B := B and $7F;
  InternalSetBytes(9, B);
{$ELSE  EXTENDEDIS10BYTES}
  B := InternalGetBytes(7);
  if NewSign then B := B or $80
  else            B := B and $7F;
  InternalSetBytes(7, B);
{$ENDIF EXTENDEDIS10BYTES}
end;

function TExtendedHelper.SpecialType: TFloatSpecial;
{$IFDEF EXTENDEDIS10BYTES}
var
  U64: UInt64;
  W: Word;
begin
  U64 := PUInt64(@Self)^;
  W := InternalgetWords(4);

  if ($0001 <= W) and (W <= $7FFE) then
    Result := TFloatSpecial.fsPositive
  else if ($8001 <= W) and (W <= $FFFE) then
    Result := TFloatSpecial.fsNegative
  else if (U64 = 0) and (W = 0) then
    Result := TFloatSpecial.fsZero
  else if (U64 = 0) and (W = $8000) then
    Result := TFloatSpecial.fsNZero
  else if w = $0000 then
    Result := TFloatSpecial.fsDenormal
  else if w = $8000 then
    Result := TFloatSpecial.fsNDenormal
  else if (U64 = $8000000000000000) and (W = $7FFF) then
    Result := fsInf
  else if (U64 = $8000000000000000) and (W = $FFFF)then
    Result := TFloatSpecial.fsNInf
  else
    Result := TFloatSpecial.fsNan;
end;
{$ELSE  EXTENDEDIS10BYTES}
var
  U64: UInt64;
  W: Word;
begin
  U64 := PUInt64(@self)^;
  W := InternalGetWOrds(3);

  if ($0010 <= W) and (W <= $7FEF) then
    Result := TFloatSpecial.fsPositive
  else if ($8010 <= W) and (W <= $FFEF) then
    Result := TFloatSpecial.fsNegative
  else if U64 = 0 then
    Result := TFloatSpecial.fsZero
  else if U64 = $8000000000000000 then
    Result := TFloatSpecial.fsNZero
  else if w <= $000F then
    Result := TFloatSpecial.fsDenormal
  else if ($8000 <= w) and (w <= $800F) then
    Result := TFloatSpecial.fsNDenormal
  else if U64 = $7FF0000000000000 then
    Result := TFloatSpecial.fsInf
  else if U64 = $FFF0000000000000 then
    Result := TFloatSpecial.fsNInf
  else
    Result := TFloatSpecial.fsNan;
end;
{$ENDIF EXTENDEDIS10BYTES}

{ TByteHelper }

class function TByteHelper.Size: Integer;
begin
  Result := SizeOf(Byte);
end;

class function TByteHelper.ToString(const Value: Byte): string;
begin
  Result := IntToStr(Value);
end;

class function TByteHelper.ToHexString(const Value: Byte): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TByteHelper.ToHexString(const Value: Byte; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TByteHelper.Parse(const S: string): Byte;
begin
  Result := StrToInt(S);
end;

class function TByteHelper.TryParse(const S: string; out Value: Byte): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TByteHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TByteHelper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TByteHelper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TByteHelper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TByteHelper.ToSingle: Single;
begin
  Result := Self;
end;

function TByteHelper.ToDouble: Double;
begin
  Result := Self;
end;

function TByteHelper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TShortIntHelper }

class function TShortIntHelper.Size: Integer;
begin
  Result := SizeOf(ShortInt);
end;

class function TShortIntHelper.ToString(const Value: ShortInt): string;
begin
  Result := IntToStr(Value);
end;

class function TShortIntHelper.ToHexString(const Value: ShortInt): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TShortIntHelper.ToHexString(const Value: ShortInt; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TShortIntHelper.Parse(const S: string): ShortInt;
begin
  Result := StrToInt(S);
end;

class function TShortIntHelper.TryParse(const S: string; out Value: ShortInt): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TShortIntHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TShortIntHelper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TShortIntHelper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TShortIntHelper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TShortIntHelper.ToSingle: Single;
begin
  Result := Self;
end;

function TShortIntHelper.ToDouble: Double;
begin
  Result := Self;
end;

function TShortIntHelper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TSmallIntHelper }

class function TSmallIntHelper.Size: Integer;
begin
  Result := SizeOf(SmallInt);
end;

class function TSmallIntHelper.ToString(const Value: SmallInt): string;
begin
  Result := IntToStr(Value);
end;

class function TSmallIntHelper.ToHexString(const Value: SMallInt): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TSmallIntHelper.ToHexString(const Value: SmallInt; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TSmallIntHelper.Parse(const S: string): SmallInt;
begin
  Result := StrToInt(S);
end;

class function TSmallIntHelper.TryParse(const S: string; out Value: SmallInt): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TSmallIntHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TSmallIntHelper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TSmallIntHelper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TSmallIntHelper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TSmallIntHelper.ToSingle: Single;
begin
  Result := Self;
end;

function TSmallIntHelper.ToDouble: Double;
begin
  Result := Self;
end;

function TSmallIntHelper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TWordHelper }

class function TWordHelper.Size: Integer;
begin
  Result := SizeOf(Word);
end;

class function TWordHelper.ToString(const Value: Word): string;
begin
  Result := IntToStr(Value);
end;

class function TWordHelper.ToHexString(const Value: Word): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TWordHelper.ToHexString(const Value: Word; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TWordHelper.Parse(const S: string): Word;
begin
  Result := StrToInt(S);
end;

class function TWordHelper.TryParse(const S: string; out Value: Word): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TWordHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TWordHelper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TWordHelper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TWordHelper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TWordHelper.ToSingle: Single;
begin
  Result := Self;
end;

function TWordHelper.ToDouble: Double;
begin
  Result := Self;
end;

function TWordHelper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TCardinalHelper }

class function TCardinalHelper.Size: Integer;
begin
  Result := SizeOf(Cardinal);
end;

class function TCardinalHelper.ToString(const Value: Cardinal): string;
begin
  Result := IntToStr(Value);
end;

class function TCardinalHelper.ToHexString(const Value: Cardinal): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TCardinalHelper.ToHexString(const Value: Cardinal; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TCardinalHelper.Parse(const S: string): Cardinal;
begin
  Result := StrToInt(S);
end;


class function TCardinalHelper.TryParse(const S: string; out Value: Cardinal): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TCardinalHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TCardinalHelper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TCardinalHelper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TCardinalHelper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TCardinalHelper.ToSingle: Single;
begin
  Result := Self;
end;

function TCardinalHelper.ToDouble: Double;
begin
  Result := Self;
end;

function TCardinalHelper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TIntegerHelper }

class function TIntegerHelper.Size: Integer;
begin
  Result := SizeOf(Integer);
end;

class function TIntegerHelper.ToString(const Value: Integer): string;
begin
  Result := IntToStr(Value);
end;

class function TIntegerHelper.ToHexString(const Value: Integer): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TIntegerHelper.ToHexString(const Value: Integer; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TIntegerHelper.Parse(const S: string): Integer;
begin
  Result := StrToInt(S);
end;

class function TIntegerHelper.TryParse(const S: string; out Value: Integer): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TIntegerHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TIntegerHelper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TIntegerHelper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TIntegerHelper.ToHexString(const MinDigits: Word): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TIntegerHelper.ToSingle: Single;
begin
  Result := Self;
end;

function TIntegerHelper.ToDouble: Double;
begin
  Result := Self;
end;

function TIntegerHelper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TInt64Helper }

class function TInt64Helper.Size: Integer;
begin
  Result := SizeOf(Int64);
end;

class function TInt64Helper.ToString(const Value: Int64): string;
begin
  Result := IntToStr(Value);
end;

class function TInt64Helper.ToHexString(const Value: Int64): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TInt64Helper.ToHexString(const Value: Int64; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TInt64Helper.Parse(const S: string): Int64;
begin
  Result := StrToInt(S);
end;

class function TInt64Helper.TryParse(const S: string; out Value: Int64): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TInt64Helper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TInt64Helper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TInt64Helper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TInt64Helper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TInt64Helper.ToSingle: Single;
begin
  Result := Self;
end;

function TInt64Helper.ToDouble: Double;
begin
  Result := Self;
end;

function TInt64Helper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TUInt64Helper }

class function TUInt64Helper.Size: Integer;
begin
  Result := SizeOf(UInt64);
end;

class function TUInt64Helper.ToString(const Value: UInt64): string;
begin
  Result := UIntToStr(Value);
end;

class function TUInt64Helper.ToHexString(const Value: UInt64): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TUInt64Helper.ToHexString(const Value: UInt64; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TUInt64Helper.Parse(const S: string): UInt64;
begin
  Result := StrToInt(S);
end;

class function TUInt64Helper.TryParse(const S: string; out Value: UInt64): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TUInt64Helper.ToString: string;
begin
  Result := UIntToStr(Self);
end;

function TUInt64Helper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TUInt64Helper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TUInt64Helper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TUInt64Helper.ToSingle: Single;
begin
  Result := Self;
end;

function TUInt64Helper.ToDouble: Double;
begin
  Result := Self;
end;

function TUInt64Helper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TNativeIntHelper }

class function TNativeIntHelper.Size: Integer;
begin
  Result := SizeOf(NativeInt);
end;

class function TNativeIntHelper.ToString(const Value: NativeInt): string;
begin
  Result := IntToStr(Value);
end;

class function TNativeIntHelper.ToHexString(const Value: NativeInt): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TNativeIntHelper.ToHexString(const Value: NativeInt; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TNativeIntHelper.Parse(const S: string): NativeInt;
begin
  Result := StrToInt(S);
end;

class function TNativeIntHelper.TryParse(const S: string; out Value: NativeInt): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TNativeIntHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TNativeIntHelper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TNativeIntHelper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TNativeIntHelper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TNativeIntHelper.ToSingle: Single;
begin
  Result := Self;
end;

function TNativeIntHelper.ToDouble: Double;
begin
  Result := Self;
end;

function TNativeIntHelper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TNativeUIntHelper }

class function TNativeUIntHelper.Size: Integer;
begin
  Result := SizeOf(NativeUInt);
end;

class function TNativeUIntHelper.ToString(const Value: NativeUInt): string;
begin
  Result := UIntToStr(Value);
end;

class function TNativeUIntHelper.ToHexString(const Value: NativeUInt): string;
begin
  Result := IntToHex(Value, 0);
end;

class function TNativeUIntHelper.ToHexString(const Value: NativeUInt; const MinDigits: Integer): string;
begin
  Result := IntToHex(Value, MinDigits);
end;

class function TNativeUIntHelper.Parse(const S: string): NativeUInt;
begin
  Result := StrToInt(S);
end;

class function TNativeUIntHelper.TryParse(const S: string; out Value: NativeUInt): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function TNativeUIntHelper.ToString: string;
begin
  Result := UIntToStr(Self);
end;

function TNativeUIntHelper.ToBoolean: Boolean;
begin
  Result := Self <> 0;
end;

function TNativeUIntHelper.ToHexString: string;
begin
  Result := IntToHex(Self, 0);
end;

function TNativeUIntHelper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntToHex(Self, MinDigits);
end;

function TNativeUIntHelper.ToSingle: Single;
begin
  Result := Self;
end;

function TNativeUIntHelper.ToDouble: Double;
begin
  Result := Self;
end;

function TNativeUIntHelper.ToExtended: Extended;
begin
  Result := Self;
end;

{ TBooleanHelper }

class function TBooleanHelper.Size: Integer;
begin
  Result := SizeOf(Boolean);
end;

class function TBooleanHelper.ToString(const Value: Boolean): string;
begin
  Result := BoolToStr(Value);
end;

class function TBooleanHelper.Parse(const S: string): Boolean;
begin
  Result := StrToBool(S);
end;

class function TBooleanHelper.TryToParse(const S: string; out Value: Boolean): Boolean;
begin
  Result := TryStrToBool(S, Value);
end;

function TBooleanHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

function TBooleanHelper.ToString: string;
begin
  Result := BoolToStr(Self);
end;

{ TByteBoolHelper }

class function TByteBoolHelper.Size: Integer;
begin
  Result := SizeOf(ByteBool);
end;

class function TByteBoolHelper.ToString(const Value: Boolean): string;
begin
  Result := BoolToStr(Value);
end;

class function TByteBoolHelper.Parse(const S: string): Boolean;
begin
  Result := StrToBool(S);
end;

class function TByteBoolHelper.TryToParse(const S: string; out Value: Boolean): Boolean;
begin
  Result := TryStrToBool(S, Value);
end;

function TByteBoolHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

function TByteBoolHelper.ToString: string;
begin
  Result := BoolToStr(Self);
end;

{ TWordBoolHelper }

class function TWordBoolHelper.Size: Integer;
begin
  Result := SizeOf(WordBool);
end;

class function TWordBoolHelper.ToString(const Value: Boolean): string;
begin
  Result := BoolToStr(Value);
end;

class function TWordBoolHelper.Parse(const S: string): Boolean;
begin
  Result := StrToBool(S);
end;

class function TWordBoolHelper.TryToParse(const S: string; out Value: Boolean): Boolean;
begin
  Result := TryStrToBool(S, Value);
end;

function TWordBoolHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

function TWordBoolHelper.ToString: string;
begin
  Result := BoolToStr(Self);
end;

{ TLongBoolHelper }

class function TLongBoolHelper.Size: Integer;
begin
  Result := SizeOf(LongBool);
end;

class function TLongBoolHelper.ToString(const Value: Boolean): string;
begin
  Result := BoolToStr(Value);
end;

class function TLongBoolHelper.Parse(const S: string): Boolean;
begin
  Result := StrToBool(S);
end;

class function TLongBoolHelper.TryToParse(const S: string; out Value: Boolean): Boolean;
begin
  Result := TryStrToBool(S, Value);
end;

function TLongBoolHelper.ToInteger: Integer;
begin
  Result := Integer(Self);
end;

function TLongBoolHelper.ToString: string;
begin
  Result := BoolToStr(Self);
end;

{ Cross platform helpers }

{$IFDEF POSIX}
type
  TCPInfo = record
    MaxCharSize: Cardinal; { max length (bytes) of a char }
  end;

                                                           
function GetCPInfo(CodePage: Cardinal; var lpCPInfo: TCPInfo): Boolean;
begin
  Result := True;
  case CodePage of
    // Code page identifiers understood directly by iconv_open()
    154, 367, 437, 737, 775, 819, 850, 852,
    853, 855..858, 860..866, 869, 874, 922: lpCPInfo.MaxCharSize := 1;
    932, 936, 943, 949, 950: lpCPInfo.MaxCharSize := 2;
    1046, 1124, 1125, 1129, 1133, 1161, 1162, 1163, 1250..1258: lpCPInfo.MaxCharSize := 1;
    1361: lpCPInfo.MaxCharSize := 2;
    // Code page indentifiers translated to iconv_open() encoding names (by LocaleNameFromCodePage)
    10000, 10004..10007, 10010, 10017, 10021,
    10029, 10079, 10081, 10082: lpCPInfo.MaxCharSize := 1;        // MacRoman .. MacCroatian
    12000, 12001: lpCPInfo.MaxCharSize := 4;                      // UTF-32LE, UTF-32BE
    20127, 20866: lpCPInfo.MaxCharSize := 1;                      // ASCII, KOI8-R
    20932: lpCPInfo.MaxCharSize := 3;                             // EUC-JP
    20936: lpCPInfo.MaxCharSize := 2;                             // GB2312, EUC-KR
    21866, 28591..28601, 28603..28606: lpCPInfo.MaxCharSize := 1; // KOI8-U, ISO-8859-1..ISO-8859-16
    50221: lpCPInfo.MaxCharSize := 9;                             // ISO-2022-JP
    50225: lpCPInfo.MaxCharSize := 7;                             // ISO-2022-KR
    50227: lpCPInfo.MaxCharSize := 8;                             // ISO-2022-CN
    51932: lpCPInfo.MaxCharSize := 3;                             // EUC-JP
    51936, 51949: lpCPInfo.MaxCharSize := 2;                      // GB2312, EUC-KR
    51950, 52936, 54936: lpCPInfo.MaxCharSize := 4;               // EUC-TW, HZ-GB-2312, GB18030
    65000: lpCPInfo.MaxCharSize := 6;                             // UTF-7
    65001: lpCPInfo.MaxCharSize := 4;                             // UTF-8
  else
    Result := False;
  end;
end;

type
  TCPInfoEx = record
    CodePageName: string;
  end;

function GetCPInfoEx(CodePage: Cardinal; Flags: Cardinal; var lpCPInfo: TCPInfoEx): Boolean;
{$IFDEF MACOS}
var
  LName: CFStringRef;
  LEncoding: CFStringEncoding;
begin
  Result := False;
  LEncoding := CFStringConvertWindowsCodepageToEncoding(CodePage);
  if LEncoding <> kCFStringEncodingInvalidId then
  begin
    LName := CFStringGetNameOfEncoding(LEncoding);
    lpCPInfo.CodePageName := TCFString(LName).AsString;
    Result := True;
  end;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
begin
  Result := True;
  case CodePage of
    // Special cases for codepages returned by System.GetPosixLocaleName
    437: lpCPInfo.CodePageName := 'Latin-US (DOS)';                      // Do not localize
    850: lpCPInfo.CodePageName := 'Western (DOS Latin 1)';               // Do not localize
    874: lpCPInfo.CodePageName := 'Thai (Windows, DOS)';                 // Do not localize
    932: lpCPInfo.CodePageName := 'Japanese (Windows, DOS)';             // Do not localize
    936: lpCPInfo.CodePageName := 'Simplified Chinese (Windows, DOS)';   // Do not localize
    949: lpCPInfo.CodePageName := 'Korean (Windows, DOS)';               // Do not localize
    950: lpCPInfo.CodePageName := 'Traditional Chinese (Windows, DOS)';  // Do not localize
    1200: lpCPInfo.CodePageName := 'Unicode (UTF-16)';                   // Do not localize
    1201: lpCPInfo.CodePageName := 'Unicode (UTF-16BE)';                 // Do not localize
    1250: lpCPInfo.CodePageName := 'Central European (Windows Latin 2)'; // Do not localize
    1251: lpCPInfo.CodePageName := 'Cyrillic (Windows)';                 // Do not localize
    1252: lpCPInfo.CodePageName := 'Western (Windows Latin 1)';          // Do not localize
    1253: lpCPInfo.CodePageName := 'Greek (Windows)';                    // Do not localize
    1254: lpCPInfo.CodePageName := 'Turkish (Windows Latin 5)';          // Do not localize
    1255: lpCPInfo.CodePageName := 'Hebrew (Windows)';                   // Do not localize
    1256: lpCPInfo.CodePageName := 'Arabic (Windows)';                   // Do not localize
    1257: lpCPInfo.CodePageName := 'Baltic (Windows)';                   // Do not localize
    1258: lpCPInfo.CodePageName := 'Vietnamese (Windows)';               // Do not localize
    20127: lpCPInfo.CodePageName := 'Western (ASCII)';                   // Do not localize
    CP_UTF7: lpCPInfo.CodePageName := 'Unicode (UTF-7)';                 // Do not localize
    CP_UTF8: lpCPInfo.CodePageName := 'Unicode (UTF-8)';                 // Do not localize
  else
    Result := False;
  end;
end;
{$ENDIF LINUX}
{$ENDIF POSIX}

{$IFDEF MSWINDOWS}
function GetEncodingHashIndex(Hash: Cardinal): Integer;
{$IFDEF PUREPASCAL}
var
  I: Integer;
begin
  for I := Low(EncodingHashList) to High(EncodingHashList) do
    if Hash = EncodingHashList[I] then
      Exit(I);
  Result := -1;
end;
{$ELSE !PUREPASCAL}
{$IFDEF X86ASM}
asm
        PUSH    EDI
        PUSH    ECX
        LEA     EDI,EncodingHashList
        MOV     ECX,EncodingHashCount
        REPNE   SCASD
        JNE     @@NotFound
        NOT     ECX
        ADD     ECX,EncodingHashCount  // ECX contains zero based index into data table
        MOV     EAX,ECX
        JMP     @@Done
  @@NotFound:
        MOV     EAX,$FFFFFFFF // return -1 if not found
  @@Done:
        POP     ECX
        POP     EDI
        RET
end;
{$ENDIF X86ASM}
{$ENDIF !PUREPASCAL}

function GetCodePageFromEncodingName(const Name: string; var CodePage: Cardinal): Boolean;
var
  Index, Code: Integer;
  PSearchName: MarshaledAString;
  EncodingName: string;
  M:TMarshaller;
begin
  Result := False;
  PSearchName := MarshaledAString(M.AsAnsi(Name, CP_UTF8).ToPointer);
  Index := GetEncodingHashIndex(HashName(PSearchName));
  if Index <> -1 then
  begin
    EncodingName := string(MarshaledAString(@EncodingNameList) + Word(EncodingDataList[Index]));
    Result := Name.CompareTo( EncodingName) = 0;
    if Result then
      CodePage := HiWord(EncodingDataList[Index]);
  end
  else
  begin
    // if we don't find the encoding in the pre-built list of hashed names,
    // test if it's a codepage specified in the "cp####" format.
    if Name.Substring( 0, 2) = 'cp' then // do not localize
    begin
      Val(Name.Substring( 2), CodePage, Code);
      Result := Code = 0;
    end;
  end;
end;
{$ENDIF MSWINDOWS}


{ TEncoding }

function TEncoding.Clone: TEncoding;
begin
  Result := nil; // Return nil if encoding class cannot be cloned
end;

class function TEncoding.Convert(const Source, Destination: TEncoding; const Bytes: array of Byte): TBytes;
begin
  Result := Destination.GetBytes(Source.GetChars(Bytes));
end;

class function TEncoding.Convert(const Source, Destination: TEncoding; const Bytes: TBytes): TBytes;
begin
  Result := Destination.GetBytes(Source.GetChars(Bytes));
end;

class function TEncoding.Convert(const Source, Destination: TEncoding; const Bytes: array of Byte;
  StartIndex, Count: Integer): TBytes;
begin
  Result := Destination.GetBytes(Source.GetChars(Bytes, StartIndex, Count));
end;

class function TEncoding.Convert(const Source, Destination: TEncoding; const Bytes: TBytes;
  StartIndex, Count: Integer): TBytes;
begin
  Result := Destination.GetBytes(Source.GetChars(Bytes, StartIndex, Count));
end;

class destructor TEncoding.Destroy;
begin
  FreeEncodings;
end;

class procedure TEncoding.FreeEncodings;
begin
  FreeAndNil(FANSIEncoding);
  FreeAndNil(FASCIIEncoding);
  FreeAndNil(FUTF7Encoding);
  FreeAndNil(FUTF8Encoding);
  FreeAndNil(FUnicodeEncoding);
  FreeAndNil(FBigEndianUnicodeEncoding);
end;

class function TEncoding.GetANSI: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FANSIEncoding = nil then
  begin
    LEncoding := TMBCSEncoding.Create(GetACP, 0, 0);
    if AtomicCmpExchange(Pointer(FANSIEncoding), Pointer(LEncoding), nil) <> nil then
      LEncoding.Free;
{$IFDEF AUTOREFCOUNT}
    FANSIEncoding.__ObjAddRef;
{$ENDIF AUTOREFCOUNT}
  end;
  Result := FANSIEncoding;
end;

class function TEncoding.GetASCII: TEncoding;
var
  LCPInfo: TCPInfo;
  LEncoding: TEncoding;
begin
  if FASCIIEncoding = nil then
  begin
    { Check whether the ASCII encoding is supported }
    if GetCPInfo(20127, LCPInfo) then
      LEncoding := TMBCSEncoding.Create(20127, 0, 0)
    else
      LEncoding := TMBCSEncoding.Create(437, 0, 0); // Select OEM US 437 otherwise

    if AtomicCmpExchange(Pointer(FASCIIEncoding), Pointer(LEncoding), nil) <> nil then
      LEncoding.Free;
{$IFDEF AUTOREFCOUNT}
    FASCIIEncoding.__ObjAddRef;
{$ENDIF AUTOREFCOUNT}
  end;
  Result := FASCIIEncoding;
end;

class function TEncoding.GetBigEndianUnicode: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FBigEndianUnicodeEncoding = nil then
  begin
    LEncoding := TBigEndianUnicodeEncoding.Create;

    if AtomicCmpExchange(Pointer(FBigEndianUnicodeEncoding), Pointer(LEncoding), nil) <> nil then
      LEncoding.Free;
{$IFDEF AUTOREFCOUNT}
    FBigEndianUnicodeEncoding.__ObjAddRef;
{$ENDIF AUTOREFCOUNT}
  end;
  Result := FBigEndianUnicodeEncoding;
end;

class function TEncoding.GetBufferEncoding(const Buffer: TBytes; var AEncoding: TEncoding): Integer;
begin
  Result := GetBufferEncoding(Buffer, AEncoding, Default); // Must call property getter to create Encoding
end;

class function TEncoding.GetBufferEncoding(const Buffer: TBytes; var AEncoding: TEncoding;
  ADefaultEncoding: TEncoding): Integer;

  function ContainsPreamble(const Buffer, Signature: array of Byte): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    if Length(Buffer) >= Length(Signature) then
    begin
      for I := 1 to Length(Signature) do
        if Buffer[I - 1] <> Signature [I - 1] then
        begin
          Result := False;
          Break;
        end;
    end
    else
      Result := False;
  end;

var
  Preamble: TBytes;
begin
  Result := 0;
  if AEncoding = nil then
  begin
    // Find the appropraite encoding
    if ContainsPreamble(Buffer, TEncoding.UTF8.GetPreamble) then
      AEncoding := TEncoding.UTF8
    else if ContainsPreamble(Buffer, TEncoding.Unicode.GetPreamble) then
      AEncoding := TEncoding.Unicode
    else if ContainsPreamble(Buffer, TEncoding.BigEndianUnicode.GetPreamble) then
      AEncoding := TEncoding.BigEndianUnicode
    else
    begin
      AEncoding := ADefaultEncoding;
      Exit; // Don't proceed just in case ADefaultEncoding has a Preamble
    end;
    Result := Length(AEncoding.GetPreamble);
  end
  else
  begin
    Preamble := AEncoding.GetPreamble;
    if ContainsPreamble(Buffer, Preamble) then
      Result := Length(Preamble);
  end;
end;

function TEncoding.GetByteCount(const Chars: Char): Integer;
begin
  Result := GetByteCount([Chars], 0, Length(Chars));
end;

function TEncoding.GetByteCount(const Chars: array of Char): Integer;
begin
  Result := GetByteCount(Chars, 0, Length(Chars));
end;

function TEncoding.GetByteCount(const Chars: TCharArray): Integer;
begin
  Result := GetByteCount(Chars, 0, Length(Chars));
end;

function TEncoding.GetByteCount(const Chars: array of Char; CharIndex, CharCount: Integer): Integer;
begin
  if CharIndex < 0 then
    raise EEncodingError.CreateResFmt(@SCharIndexOutOfBounds, [CharIndex]);
  if CharCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);
  if (Length(Chars) - CharIndex) < CharCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);

  Result := GetByteCount(@Chars[CharIndex], CharCount);
end;

function TEncoding.GetByteCount(const Chars: TCharArray; CharIndex, CharCount: Integer): Integer;
begin
  if CharIndex < 0 then
    raise EEncodingError.CreateResFmt(@SCharIndexOutOfBounds, [CharIndex]);
  if CharCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);
  if (Length(Chars) - CharIndex) < CharCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);

  Result := GetByteCount(@Chars[CharIndex], CharCount);
end;

function TEncoding.GetByteCount(const S: string): Integer;
begin
  Result := GetByteCount(PChar(S), Length(S));
end;

function TEncoding.GetByteCount(const S: string; CharIndex, CharCount: Integer): Integer;
begin
  if CharIndex < Low(S) then
    raise EEncodingError.CreateResFmt(@SCharIndexOutOfBounds, [CharIndex]);
  if CharCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);
  if (Length(S) - CharIndex + 1) < CharCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);

  Result := GetByteCount(PChar(@S[CharIndex]), CharCount);
end;

function TEncoding.GetBytes(const Chars: array of Char; CharIndex, CharCount: Integer): TBytes;
var
  Len: Integer;
begin
  Len := GetByteCount(Chars, CharIndex, CharCount);
  SetLength(Result, Len);
  GetBytes(Chars, CharIndex, CharCount, Result, 0);
end;

function TEncoding.GetBytes(const Chars: TCharArray; CharIndex, CharCount: Integer): TBytes;
var
  Len: Integer;
begin
  Len := GetByteCount(Chars, CharIndex, CharCount);
  SetLength(Result, Len);
  GetBytes(Chars, CharIndex, CharCount, Result, 0);
end;

function TEncoding.GetBytes(const Chars: Char): TBytes;
begin
  Result := GetBytes([Chars]);
end;

function TEncoding.GetBytes(const Chars: array of Char): TBytes;
var
  Len: Integer;
begin
  Len := GetByteCount(Chars);
  SetLength(Result, Len);
  GetBytes(Chars, 0, Length(Chars), Result, 0);
end;

function TEncoding.GetBytes(const Chars: TCharArray): TBytes;
var
  Len: Integer;
begin
  Len := GetByteCount(Chars);
  SetLength(Result, Len);
  GetBytes(Chars, 0, Length(Chars), Result, 0);
end;

function TEncoding.GetBytes(const Chars: array of Char; CharIndex, CharCount: Integer;
  const Bytes: TBytes; ByteIndex: Integer): Integer;
var
  Len: Integer;
begin
  if (Length(Chars) = 0) and (CharCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidSourceArray);
  if (Bytes = nil) and (CharCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidDestinationArray);
  if CharIndex < 0 then
    raise EEncodingError.CreateResFmt(@SCharIndexOutOfBounds, [CharIndex]);
  if CharCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);
  if (Length(Chars) - CharIndex) < CharCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);
  Len := Length(Bytes);
  if (ByteIndex < 0) or (ByteIndex > Len) then
    raise EEncodingError.CreateResFmt(@SInvalidDestinationIndex, [ByteIndex]);
  if Len - ByteIndex < GetByteCount(Chars, CharIndex, CharCount) then
    raise EEncodingError.CreateRes(@SInvalidDestinationArray);

  Result := GetBytes(@Chars[CharIndex], CharCount, @Bytes[ByteIndex], Len - ByteIndex);
end;

function TEncoding.GetBytes(const Chars: TCharArray; CharIndex, CharCount: Integer;
  const Bytes: TBytes; ByteIndex: Integer): Integer;
var
  Len: Integer;
begin
  if (Chars = nil) and (CharCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidSourceArray);
  if (Bytes = nil) and (CharCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidDestinationArray);
  if CharIndex < 0 then
    raise EEncodingError.CreateResFmt(@SCharIndexOutOfBounds, [CharIndex]);
  if CharCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);
  if (Length(Chars) - CharIndex) < CharCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);
  Len := Length(Bytes);
  if (ByteIndex < 0) or (ByteIndex > Len) then
    raise EEncodingError.CreateResFmt(@SInvalidDestinationIndex, [ByteIndex]);
  if Len - ByteIndex < GetByteCount(Chars, CharIndex, CharCount) then
    raise EEncodingError.CreateRes(@SInvalidDestinationArray);

  Result := GetBytes(@Chars[CharIndex], CharCount, @Bytes[ByteIndex], Len - ByteIndex);
end;

function TEncoding.GetBytes(const S: string): TBytes;
var
  Len: Integer;
begin
  Len := GetByteCount(S);
  SetLength(Result, Len);
  GetBytes(S, Low(S), Length(S), Result, 0);
end;

function TEncoding.GetBytes(const S: string; CharIndex, CharCount: Integer;
  const Bytes: TBytes; ByteIndex: Integer): Integer;
var
  Len: Integer;
begin
  if (Bytes = nil) and (CharCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidSourceArray);
  if CharIndex < Low(S) then
    raise EEncodingError.CreateResFmt(@SCharIndexOutOfBounds, [CharIndex]);
  if CharCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);
  if (Length(S) - CharIndex + 1) < CharCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [CharCount]);
  Len := Length(Bytes);
  if (ByteIndex < 0) or (ByteIndex > Len) then
    raise EEncodingError.CreateResFmt(@SInvalidDestinationIndex, [ByteIndex]);
  if Len - ByteIndex < GetByteCount(S, CharIndex, CharCount) then
    raise EEncodingError.CreateRes(@SInvalidDestinationArray);

  Result := GetBytes(@S[CharIndex], CharCount, @Bytes[ByteIndex], Len - ByteIndex);
end;

function TEncoding.GetCharCount(const Bytes: array of Byte): Integer;
begin
  Result := GetCharCount(Bytes, 0, Length(Bytes));
end;

function TEncoding.GetCharCount(const Bytes: TBytes): Integer;
begin
  Result := GetCharCount(Bytes, 0, Length(Bytes));
end;

function TEncoding.GetCharCount(const Bytes: array of Byte; ByteIndex, ByteCount: Integer): Integer;
begin
  if (Length(Bytes) = 0) and (ByteCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidSourceArray);
  if ByteIndex < 0 then
    raise EEncodingError.CreateResFmt(@SByteIndexOutOfBounds, [ByteIndex]);
  if ByteCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);
  if (Length(Bytes) - ByteIndex) < ByteCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);

  Result := GetCharCount(@Bytes[ByteIndex], ByteCount);
end;

function TEncoding.GetCharCount(const Bytes: TBytes; ByteIndex, ByteCount: Integer): Integer;
begin
  if (Bytes = nil) and (ByteCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidSourceArray);
  if ByteIndex < 0 then
    raise EEncodingError.CreateResFmt(@SByteIndexOutOfBounds, [ByteIndex]);
  if ByteCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);
  if (Length(Bytes) - ByteIndex) < ByteCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);

  Result := GetCharCount(@Bytes[ByteIndex], ByteCount);
end;

function TEncoding.GetChars(const Bytes: array of Byte): TCharArray;
begin
  Result := GetChars(Bytes, 0, Length(Bytes));
end;

function TEncoding.GetChars(const Bytes: TBytes): TCharArray;
begin
  Result := GetChars(Bytes, 0, Length(Bytes));
end;

function TEncoding.GetChars(const Bytes: array of Byte; ByteIndex, ByteCount: Integer): TCharArray;
var
  Len: Integer;
begin
  if (Length(Bytes) = 0) and (ByteCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidSourceArray);
  if ByteIndex < 0 then
    raise EEncodingError.CreateResFmt(@SByteIndexOutOfBounds, [ByteIndex]);
  if ByteCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);
  if (Length(Bytes) - ByteIndex) < ByteCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);

  Len := GetCharCount(Bytes, ByteIndex, ByteCount);
  SetLength(Result, Len);
  GetChars(@Bytes[ByteIndex], ByteCount, PChar(Result), Len);
end;

function TEncoding.GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer): TCharArray;
var
  Len: Integer;
begin
  if (Bytes = nil) and (ByteCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidSourceArray);
  if ByteIndex < 0 then
    raise EEncodingError.CreateResFmt(@SByteIndexOutOfBounds, [ByteIndex]);
  if ByteCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);
  if (Length(Bytes) - ByteIndex) < ByteCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);

  Len := GetCharCount(Bytes, ByteIndex, ByteCount);
  SetLength(Result, Len);
  GetChars(@Bytes[ByteIndex], ByteCount, PChar(Result), Len);
end;

function TEncoding.GetChars(const Bytes: array of Byte; ByteIndex, ByteCount: Integer;
  const Chars: array of Char; CharIndex: Integer): Integer;
var
  LCharCount: Integer;
begin
  if (Length(Bytes) = 0) and (ByteCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidSourceArray);
  if ByteIndex < 0 then
    raise EEncodingError.CreateResFmt(@SByteIndexOutOfBounds, [ByteIndex]);
  if ByteCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);
  if (Length(Bytes) - ByteIndex) < ByteCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);

  LCharCount := GetCharCount(Bytes, ByteIndex, ByteCount);
  if (CharIndex < 0) or (CharIndex > Length(Chars)) then
    raise EEncodingError.CreateResFmt(@SInvalidDestinationIndex, [CharIndex]);
  if CharIndex + LCharCount > Length(Chars) then
    raise EEncodingError.CreateRes(@SInvalidDestinationArray);

  Result := GetChars(@Bytes[ByteIndex], ByteCount, @Chars[CharIndex], LCharCount);
end;

function TEncoding.GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer;
  const Chars: TCharArray; CharIndex: Integer): Integer;
var
  LCharCount: Integer;
begin
  if (Bytes = nil) and (ByteCount <> 0) then
    raise EEncodingError.CreateRes(@SInvalidSourceArray);
  if ByteIndex < 0 then
    raise EEncodingError.CreateResFmt(@SByteIndexOutOfBounds, [ByteIndex]);
  if ByteCount < 0 then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);
  if (Length(Bytes) - ByteIndex) < ByteCount then
    raise EEncodingError.CreateResFmt(@SInvalidCharCount, [ByteCount]);

  LCharCount := GetCharCount(Bytes, ByteIndex, ByteCount);
  if (CharIndex < 0) or (CharIndex > Length(Chars)) then
    raise EEncodingError.CreateResFmt(@SInvalidDestinationIndex, [CharIndex]);
  if CharIndex + LCharCount > Length(Chars) then
    raise EEncodingError.CreateRes(@SInvalidDestinationArray);

  Result := GetChars(@Bytes[ByteIndex], ByteCount, @Chars[CharIndex], LCharCount);
end;

function TEncoding.GetCodePage: Cardinal;
begin
  Result := Cardinal(-1); // Not supported
end;

class function TEncoding.GetDefault: TEncoding;
begin
{$IFDEF MSWINDOWS}
  Result := ANSI;
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Result := UTF8;
end;
{$ENDIF POSIX}

class function TEncoding.GetEncoding(CodePage: Integer): TEncoding;
begin
  case CodePage of
    1200: Result := TUnicodeEncoding.Create;
    1201: Result := TBigEndianUnicodeEncoding.Create;
    CP_UTF7: Result := TUTF7Encoding.Create;
    CP_UTF8: Result := TUTF8Encoding.Create;
  else
    Result := TMBCSEncoding.Create(CodePage);
  end;
end;

class function TEncoding.GetEncoding(const EncodingName: string): TEncoding;
{$IFDEF MSWINDOWS}
var
  LCodePage: Cardinal;
begin
  if GetCodePageFromEncodingName(LowerCase(EncodingName), LCodePage) then
    Result := GetEncoding(LCodePage)
  else
    raise EEncodingError.CreateRes(@SInvalidEncodingName);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
begin
  Result := TCharSetEncoding.Create(EncodingName);
end;
{$ENDIF POSIX}

function TEncoding.GetEncodingName: string;
begin
  Result := '';
end;

function TEncoding.GetString(const Bytes: TBytes): string;
begin
  Result := GetString(Bytes, 0, Length(Bytes));
end;

function TEncoding.GetString(const Bytes: TBytes; ByteIndex, ByteCount: Integer): string;
var
  LChars: TCharArray;
begin
  LChars := GetChars(Bytes, ByteIndex, ByteCount);
  SetString(Result, PChar(LChars), Length(LChars));
end;

class function TEncoding.GetUnicode: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FUnicodeEncoding = nil then
  begin
    LEncoding := TUnicodeEncoding.Create;
    if AtomicCmpExchange(Pointer(FUnicodeEncoding), Pointer(LEncoding), nil) <> nil then
      LEncoding.Free;
{$IFDEF AUTOREFCOUNT}
    FUnicodeEncoding.__ObjAddRef;
{$ENDIF AUTOREFCOUNT}
  end;
  Result := FUnicodeEncoding;
end;

class function TEncoding.GetUTF7: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FUTF7Encoding = nil then
  begin
    LEncoding := TUTF7Encoding.Create;
    if AtomicCmpExchange(Pointer(FUTF7Encoding), Pointer(LEncoding), nil) <> nil then
      LEncoding.Free;
{$IFDEF AUTOREFCOUNT}
    FUTF7Encoding.__ObjAddRef;
{$ENDIF AUTOREFCOUNT}
  end;
  Result := FUTF7Encoding;
end;

class function TEncoding.GetUTF8: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FUTF8Encoding = nil then
  begin
    LEncoding := TUTF8Encoding.Create;
    if AtomicCmpExchange(Pointer(FUTF8Encoding), Pointer(LEncoding), nil) <> nil then
      LEncoding.Free;
{$IFDEF AUTOREFCOUNT}
    FUTF8Encoding.__ObjAddRef;
{$ENDIF AUTOREFCOUNT}
  end;
  Result := FUTF8Encoding;
end;

class function TEncoding.IsStandardEncoding(AEncoding: TEncoding): Boolean;
begin
  Result :=
    (AEncoding <> nil) and
    ((AEncoding = FANSIEncoding) or
    (AEncoding = FUTF8Encoding) or
    (AEncoding = FUnicodeEncoding) or
    (AEncoding = FASCIIEncoding) or
    (AEncoding = FUTF7Encoding) or
    (AEncoding = FBigEndianUnicodeEncoding));
end;

{ TMBCSEncoding }

constructor TMBCSEncoding.Create;
begin
  Create(GetACP, 0, 0);
end;

constructor TMBCSEncoding.Create(CodePage: Integer);
begin
  FCodePage := CodePage;
  Create(CodePage, 0, 0);
end;

constructor TMBCSEncoding.Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer);
var
  LCPInfo: TCPInfo;
begin
  if CodePage = CP_ACP then
    FCodePage := GetACP
  else
    FCodePage := CodePage;
  FMBToWCharFlags := MBToWCharFlags;
  FWCharToMBFlags := WCharToMBFlags;

  if not GetCPInfo(FCodePage, LCPInfo) then
    raise EEncodingError.CreateRes(@SInvalidCodePage);
  FMaxCharSize := LCPInfo.MaxCharSize;
  FIsSingleByte := FMaxCharSize = 1;
end;

function TMBCSEncoding.Clone: TEncoding;
begin
  Result := TMBCSEncoding.Create(CodePage, FMBToWCharFlags, FWCharToMBFlags);
end;

function TMBCSEncoding.GetByteCount(Chars: PChar; CharCount: Integer): Integer;
begin
  Result := LocaleCharsFromUnicode(FCodePage, FWCharToMBFlags,
    PChar(Chars), CharCount, nil, 0, nil, nil);
end;

function TMBCSEncoding.GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte;
  ByteCount: Integer): Integer;
begin
  Result := LocaleCharsFromUnicode(FCodePage, FWCharToMBFlags,
    PChar(Chars), CharCount, MarshaledAString(Bytes), ByteCount, nil, nil);
end;

function TMBCSEncoding.GetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
begin
  Result := UnicodeFromLocaleChars(FCodePage, FMBToWCharFlags,
    MarshaledAString(Bytes), ByteCount, nil, 0);
end;

function TMBCSEncoding.GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar;
  CharCount: Integer): Integer;
begin
  Result := UnicodeFromLocaleChars(FCodePage, FMBToWCharFlags,
    MarshaledAString(Bytes), ByteCount, Chars, CharCount);
end;

function TMBCSEncoding.GetCodePage: Cardinal;
begin
  Result := FCodePage;
end;

function TMBCSEncoding.GetEncodingName: string;
var
  LCPInfo: TCPInfoEx;
begin
  if GetCPInfoEx(FCodePage, 0, LCPInfo) then
    Result := LCPInfo.CodePageName
  else
    Result := '';
end;

function TMBCSEncoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * FMaxCharSize;
end;

function TMBCSEncoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount;
end;

function TMBCSEncoding.GetPreamble: TBytes;
begin
  case CodePage of
    1200: Result := TBytes.Create($FF, $FE);    // unicode
    1201: Result := TBytes.Create($FE, $FF);    // big-endian unicode
    CP_UTF8: Result := TBytes.Create($EF, $BB, $BF);
  else
    SetLength(Result, 0);
  end;
end;

{ TUTF7Encoding }

constructor TUTF7Encoding.Create;
begin
  inherited Create(CP_UTF7);
  FIsSingleByte := False;
end;

function TUTF7Encoding.Clone: TEncoding;
begin
  Result := TUTF7Encoding.Create;
end;

function TUTF7Encoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount * 3) + 2;
end;

function TUTF7Encoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount;
end;

{ TUTF8Encoding }

constructor TUTF8Encoding.Create;
begin
  inherited Create(CP_UTF8, MB_ERR_INVALID_CHARS, 0);
  FIsSingleByte := False;
end;

function TUTF8Encoding.Clone: TEncoding;
begin
  Result := TUTF8Encoding.Create;
end;

function TUTF8Encoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * 3;
end;

function TUTF8Encoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount + 1;
end;

function TUTF8Encoding.GetPreamble: TBytes;
begin
  Result := TBytes.Create($EF, $BB, $BF);
end;

{ TUnicodeEncoding }

constructor TUnicodeEncoding.Create;
begin
  FIsSingleByte := False;
  FMaxCharSize := 4;
end;

function TUnicodeEncoding.Clone: TEncoding;
begin
  Result := TUnicodeEncoding.Create;
end;

function TUnicodeEncoding.GetByteCount(Chars: PChar; CharCount: Integer): Integer;
begin
  Result := CharCount * SizeOf(Char);
end;

function TUnicodeEncoding.GetBytes(Chars: PChar; CharCount: Integer;
  Bytes: PByte; ByteCount: Integer): Integer;
begin
  Result := CharCount * SizeOf(Char);
  Move(Chars^, Bytes^, Result);
end;

function TUnicodeEncoding.GetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
begin
  Result := ByteCount div SizeOf(Char);
end;

function TUnicodeEncoding.GetChars(Bytes: PByte; ByteCount: Integer;
  Chars: PChar; CharCount: Integer): Integer;
begin
  Result := CharCount;
  Move(Bytes^, Chars^, CharCount * SizeOf(Char));
end;

function TUnicodeEncoding.GetCodePage: Cardinal;
begin
  Result := 1200; // UTF-16LE
end;

function TUnicodeEncoding.GetEncodingName: string;
begin
{$IFDEF MSWINDOWS}
  Result := '1200  (Unicode)'; // do not localize
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Result := 'Unicode (UTF-16LE)'; // do not localize
{$ENDIF POSIX}
end;

function TUnicodeEncoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * 2;
end;

function TUnicodeEncoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := (ByteCount div 2) + (ByteCount and 1) + 1;
end;

function TUnicodeEncoding.GetPreamble: TBytes;
begin
  Result := TBytes.Create($FF, $FE);
end;

{ TBigEndianUnicodeEncoding }

function TBigEndianUnicodeEncoding.Clone: TEncoding;
begin
  Result := TBigEndianUnicodeEncoding.Create;
end;

function TBigEndianUnicodeEncoding.GetBytes(Chars: PChar; CharCount: Integer;
  Bytes: PByte; ByteCount: Integer): Integer;
var
  I: Integer;
begin
  for I := 0 to CharCount - 1 do
  begin
    Bytes^ := Hi(Word(Chars^));
    Inc(Bytes);
    Bytes^ := Lo(Word(Chars^));
    Inc(Bytes);
    Inc(Chars);
  end;
  Result := CharCount * SizeOf(WideChar);
end;

{$IFDEF POSIX}
function MakeWord(A, B: Byte): Word; inline;
begin
  Result := A or B shl 8;
end;
{$ENDIF POSIX}

function TBigEndianUnicodeEncoding.GetChars(Bytes: PByte; ByteCount: Integer;
  Chars: PChar; CharCount: Integer): Integer;
var
  P: PByte;
  I: Integer;
begin
  P := Bytes;
  Inc(P);
  for I := 0 to CharCount - 1 do
  begin
    Chars^ := WideChar(MakeWord(P^, Bytes^));
    Inc(Bytes, 2);
    Inc(P, 2);
    Inc(Chars);
  end;
  Result := CharCount;
end;

function TBigEndianUnicodeEncoding.GetCodePage: Cardinal;
begin
  Result := 1201; // UTF-16BE
end;

function TBigEndianUnicodeEncoding.GetEncodingName: string;
begin
{$IFDEF MSWINDOWS}
  Result := '1201  (Unicode - Big-Endian)'; // do not localize
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Result := 'Unicode (UTF-16BE)'; // do not localize
{$ENDIF POSIX}
end;

function TBigEndianUnicodeEncoding.GetPreamble: TBytes;
begin
  Result := TBytes.Create($FE, $FF);
end;

{ TCharSetEncoding }

{$IFDEF POSIX}
constructor TCharSetEncoding.Create(const EncodingName: string);
var
  M: TMarshaller;
  LContext: iconv_t;
{$IFDEF MACOS}
  LCFEncodingName: CFStringRef;
{$ENDIF MACOS}
begin
  FCodePage := Cardinal(-1);
  FEncodingName := EncodingName;
                                                                                  
  FMaxCharSize := 9;

  LContext := iconv_open(M.AsAnsi(FEncodingName, CP_UTF8).ToPointer, 'UTF-16LE'); // do not localize
  if LContext <> iconv_t(-1) then
    iconv_close(LContext)
  else
    raise EEncodingError.CreateRes(@SInvalidEncodingName);

{$IFDEF MACOS}
  LCFEncodingName := TCFString.Create(EncodingName).Value;
  try
    FCFEncoding := CFStringConvertIANACharSetNameToEncoding(LCFEncodingName);
  finally
    CFRelease(LCFEncodingName);
  end;

  if FCFEncoding <> kCFStringEncodingInvalidId then
    FMaxCharSize := CFStringGetMaximumSizeForEncoding(1, FCFEncoding);
{$ENDIF MACOS}

  FIsSingleByte := FMaxCharSize = 1;
end;

function TCharSetEncoding.Clone: TEncoding;
begin
  Result := TCharSetEncoding.Create(string(FEncodingName));
end;

function TCharSetEncoding.GetByteCount(Chars: PChar;
  CharCount: Integer): Integer;
var
  M: TMarshaller;
begin
  Result := LocaleCharsFromUnicode(MarshaledAString(M.AsAnsi(FEncodingName, CP_UTF8).ToPointer), 0,
    PChar(Chars), CharCount, nil, 0, nil, nil);
end;

function TCharSetEncoding.GetBytes(Chars: PChar; CharCount: Integer;
  Bytes: PByte; ByteCount: Integer): Integer;
var
  M: TMarshaller;
begin
  Result := LocaleCharsFromUnicode(MarshaledAString(M.AsAnsi(FEncodingName, CP_UTF8).ToPointer), 0,
    PChar(Chars), CharCount, MarshaledAString(Bytes), ByteCount, nil, nil);
end;

function TCharSetEncoding.GetCharCount(Bytes: PByte;
  ByteCount: Integer): Integer;
var
  M: TMarshaller;
begin
  Result := UnicodeFromLocaleChars(MarshaledAString(M.AsAnsi(FEncodingName, CP_UTF8).ToPointer), 0,
    MarshaledAString(Bytes), ByteCount, nil, 0);
end;

function TCharSetEncoding.GetChars(Bytes: PByte; ByteCount: Integer;
  Chars: PChar; CharCount: Integer): Integer;
var
  M: TMarshaller;
begin
  Result := UnicodeFromLocaleChars(MarshaledAString(M.AsAnsi(FEncodingName, CP_UTF8).ToPointer), 0,
    MarshaledAString(Bytes), ByteCount, PChar(Chars), CharCount);
end;

function TCharSetEncoding.GetCodePage: Cardinal;
begin
  if FCodePage = Cardinal(-1) then
  begin
{$IFDEF MACOS}
    if FCFEncoding <> kCFStringEncodingInvalidId then
    case FCFEncoding of
      // Special case some common encodings
      kCFStringEncodingUTF16LE: Result := 1200;
      kCFStringEncodingUTF16BE: Result := 1201;
      kCFStringEncodingUTF7: Result := CP_UTF7;
      kCFStringEncodingUTF8: Result := CP_UTF8;
    else
      Result := CFStringConvertEncodingToWindowsCodepage(FCFEncoding)
    end
{$ENDIF MACOS}
{$IFDEF LINUX}
                                                                          
    Result := FCodePage;
{$ENDIF LINUX}
  else
    Result := Cardinal(-1);
  end
  else
    Result := FCodePage;
end;

function TCharSetEncoding.GetEncodingName: string;
{$IFDEF MACOS}
begin
  if FCFEncoding <> kCFStringEncodingInvalidId then
    Result := TCFString(CFStringGetNameOfEncoding(FCFEncoding)).AsString
  else
    Result := FEncodingName;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
var
  LCPInfo: TCPInfoEx;
begin
  if GetCPInfoEx(CodePage, 0, LCPInfo) then // must use property CodePage not FCodePage!
    Result := LCPInfo.CodePageName
  else
    Result := FEncodingName;
end;
{$ENDIF LINUX}

function TCharSetEncoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * FMaxCharSize;
end;

function TCharSetEncoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount;
end;

function TCharSetEncoding.GetPreamble: TBytes;
begin
  case CodePage of // must use property CodePage not FCodePage!
    1200: Result := TBytes.Create($FF, $FE);
    1201: Result := TBytes.Create($FE, $FF);
    CP_UTF8: Result := TBytes.Create($EF, $BB, $BF);
  else
    SetLength(Result, 0);
  end;
end;
{$ENDIF POSIX}

{ TBytes/string conversion routines }

{$IFNDEF NEXTGEN}
function BytesOf(const Val: RawByteString): TBytes;
var
  Len: Integer;
begin
  Len := Length(Val);
  SetLength(Result, Len);
  Move(Val[1], Result[0], Len);
end;

function BytesOf(const Val: AnsiChar): TBytes;
begin
  SetLength(Result, 1);
  Result[0] := Byte(Val);
end;

function BytesOf(const Val: WideChar): TBytes;
begin
  Result := BytesOf(UnicodeString(Val));
end;
{$ENDIF}

function BytesOf(const Val: UnicodeString): TBytes;
begin
  Result := TEncoding.Default.GetBytes(Val);
end;

function StringOf(const Bytes: TBytes): UnicodeString;
begin
  if Assigned(Bytes) then
    Result := TEncoding.Default.GetString(Bytes, Low(Bytes), High(Bytes) + 1)
  else
    Result := '';
end;

function PlatformBytesOf(const Value: string): TBytes;
begin
  Result := TEncoding.Unicode.GetBytes(Value);
end;

function PlatformStringOf(const Value: TBytes): UnicodeString;
begin
  if Assigned(Value) then
  begin
    Result := TEncoding.Unicode.GetString(Value, Low(Value), High(Value) + 1);
  end
  else
    Result := '';
end;

function WideStringOf(const Value: TBytes): UnicodeString;
begin
  if Assigned(Value) then
    Result := TEncoding.Unicode.GetString(Value, Low(Value), High(Value) + 1)
  else
    Result := '';
end;

function WideBytesOf(const Value: UnicodeString): TBytes;
begin
  Result := TEncoding.Unicode.GetBytes(Value)
end;

function BytesOf(const Val: Pointer; const Len: integer): TBytes;
begin
  SetLength(Result, Len);
  Move(PByte(Val)^, Result[0], Len);
end;

 { Marshalling }

procedure DoUnfixString(Rec: TMarshaller.PDisposeRec);
begin
  TMarshal.UnfixString(TPtrWrapper(Rec^.Arg1));
end;

function MakeUnfixString(P: TPtrWrapper): TMarshaller.TDisposeRec;
begin
  Result.Proc := @DoUnfixString;
  Result.Obj := nil;
  Result.Arg1 := NativeInt(P);
  Result.Arg2 := 0;
end;

procedure DoFreeMem(Rec: TMarshaller.PDisposeRec);
begin
  TMarshal.FreeMem(TPtrWrapper(Rec^.Arg1));
end;

function MakeFreeMem(P: TPtrWrapper): TMarshaller.TDisposeRec;
 begin
  Result.Proc := @DoFreeMem;
  Result.Obj := nil;
  Result.Arg1 := NativeInt(P);
  Result.Arg2 := 0;
end;

{ TCopyStringBack }

procedure DoCopyStringBack(Rec: TMarshaller.PDisposeRec);
var
  sb: TStringBuilder;
  src: TPtrWrapper;
  maxLen: Integer;
 begin
  sb := TStringBuilder(Rec^.Obj);
  src := TPtrWrapper(Rec^.Arg1);
  maxLen := Rec^.Arg2;
  sb.Clear;
  if maxLen < 0 then
    sb.Append(TMarshal.ReadStringAsUnicode(src, -1))
  else
    sb.Append(TMarshal.ReadStringAsUnicodeUpTo(src, maxLen));
  TMarshal.FreeMem(src);
end;

function MakeCopyStringBack(Src: TPtrWrapper; Dst: TStringBuilder;
  MaxLen: Integer): TMarshaller.TDisposeRec;
begin
  Result.Proc := @DoCopyStringBack;
  Result.Obj := Dst;
  Result.Arg1 := NativeInt(Src);
  Result.Arg2 := MaxLen;
end;

 { TMarshaller }

procedure TMarshaller.AddDispose(Rec: TDisposeRec);
begin
  if FDisposer = nil then
    FDisposer := TDisposer.Create;
  FDisposer.AddDispose(Rec);
end;

function TMarshaller.AllocMem(Size: NativeInt): TPtrWrapper;
begin
  Result := TMarshal.AllocMem(Size);
  AddDispose(MakeFreeMem(Result));
end;

function TMarshaller.AllocStringAsAnsi(const Str: string): TPtrWrapper;
begin
  Result := TMarshal.AllocStringAsAnsi(Str);
  AddDispose(MakeFreeMem(Result));
end;

function TMarshaller.AllocStringAsUtf8(const Str: string): TPtrWrapper;
begin
  Result := AllocStringAsAnsi(Str, CP_UTF8);
end;

function TMarshaller.AllocStringAsAnsi(const Str: string;
  CodePage: Word): TPtrWrapper;
begin
  Result := TMarshal.AllocStringAsAnsi(Str, CodePage);
  AddDispose(MakeFreeMem(Result));
end;

function TMarshaller.AllocStringAsUnicode(const Str: string): TPtrWrapper;
begin
  Result := TMarshal.AllocStringAsUnicode(Str);
  AddDispose(MakeFreeMem(Result));
end;

function TMarshaller.AsAnsi(const S: string; CodePage: Word): TPtrWrapper;
begin
  Result := TMarshal.AllocStringAsAnsi(S, CodePage);
  AddDispose(MakeFreeMem(Result));
end;

function TMarshaller.AsUtf8(const S: string): TPtrWrapper;
begin
  Result := AsAnsi(S, CP_UTF8);
end;

function TMarshaller.AsAnsi(S: PWideChar; CodePage: Word): TPtrWrapper;
begin
  Result := TMarshal.AllocStringAsAnsi(S, CodePage);
  AddDispose(MakeFreeMem(Result));
end;

function TMarshaller.AsAnsi(S: PWideChar): TPtrWrapper;
begin
  Result := TMarshal.AllocStringAsAnsi(S);
  AddDispose(MakeFreeMem(Result));
end;

function TMarshaller.AsUtf8(S: PWideChar): TPtrWrapper;
begin
  Result := AsAnsi(S, CP_UTF8);
end;

function TMarshaller.AsAnsi(const S: string): TPtrWrapper;
begin
  Result := TMarshal.AllocStringAsAnsi(S);
  AddDispose(MakeFreeMem(Result));
end;

function TMarshaller.FixArray<T>(Arr: TArray<T>): TPtrWrapper;
begin
  Result := TMarshal.FixArray<T>(Arr);
  AddDispose(MakeUnfixArray<T>(Result));
end;

function TMarshaller.FixString(var Str: string): TPtrWrapper;
begin
  Result := TMarshal.FixString(Str);
  AddDispose(MakeUnfixString(Result));
end;

function TMarshaller.UnsafeFixString(const Str: string): TPtrWrapper;
begin
  Result := TMarshal.UnsafeFixString(Str);
  AddDispose(MakeUnfixString(Result));
end;

procedure TMarshaller.Flush;
begin
  if FDisposer <> nil then
    FDisposer.Flush;
end;

function TMarshaller.InOutString(SB: TStringBuilder; MaxLen: Integer): TPtrWrapper;
begin
  Result := TMarshal.AllocMem((MaxLen + 1) * SizeOf(Char));
  if SB.Length > MaxLen then
    TMarshal.WriteStringAsUnicode(Result, SB.ToString, MaxLen + 1)
  else
    TMarshal.WriteStringAsUnicode(Result, SB.ToString, -1);
  AddDispose(MakeCopyStringBack(Result, SB, MaxLen));
end;

function TMarshaller.InString(SB: TStringBuilder; MaxLen: Integer): TPtrWrapper;
begin
  Result := TMarshal.AllocMem((MaxLen + 1) * SizeOf(Char));
  AddDispose(MakeCopyStringBack(Result, SB, -1));
end;

class procedure TMarshaller.DoUnfixArray<T>(Rec: TMarshaller.PDisposeRec);
begin
  TMarshal.UnfixArray<T>(TPtrWrapper(Rec.Arg1));
end;

class function TMarshaller.MakeUnfixArray<T>(Ptr: TPtrWrapper): TDisposeRec;
begin
  Result.Proc := @DoUnfixArray<T>;
  Result.Obj := nil;
  Result.Arg1 := NativeInt(Ptr);
  Result.Arg2 := 0;
end;

function TMarshaller.OutString(const S: string): TPtrWrapper;
var
  t: string;
begin
  t := S;
  Result := TMarshal.FixString(t);
  AddDispose(MakeUnfixString(Result));
end;

function TMarshaller.ReallocMem(OldPtr: TPtrWrapper;
  NewSize: NativeInt): TPtrWrapper;
begin
  Result := TMarshal.ReallocMem(OldPtr, NewSize);
  if (Pointer(Result) <> Pointer(OldPtr)) and (FDisposer <> nil) then
  begin
    if Pointer(OldPtr) <> nil then
      FDisposer.RemoveDispose(MakeFreeMem(OldPtr));
    if Pointer(Result) <> nil then
      FDisposer.AddDispose(MakeFreeMem(Result));
  end;
end;

{ TMarshaller.TDisposer }

procedure TMarshaller.TDisposer.AddDispose(Rec: TDisposeRec);
var
  c: Integer;
begin
  if FCount < Length(FInline) then
    FInline[FCount] := Rec
  else
  begin
    c := FCount - Length(FInline);
    if c = Length(FOverflow) then
    begin
      if Length(FOverflow) < 4 then
        SetLength(FOverflow, 4)
      else
        SetLength(FOverflow, Length(FOverflow) * 2);
    end;
    FOverflow[c] := Rec;
  end;

  Inc(FCount);
end;

destructor TMarshaller.TDisposer.Destroy;
begin
  Flush;
  inherited;
end;

procedure TMarshaller.TDisposer.Flush;
var
  i: Integer;
begin
  if FCount <= Length(FInline) then
  begin
    for i := 0 to FCount - 1 do
      FInline[i].Proc(@FInline[i]);
  end
  else
  begin
    for i := 0 to Length(FInline) - 1 do
      FInline[i].Proc(@FInline[i]);
    for i := 0 to FCount - Length(FInline) - 1 do
      FOverflow[i].Proc(@FOverflow[i]);
  end;
  FCount := 0;
  SetLength(FOverflow, 0);
end;

function MakeNop: TMarshaller.TDisposeRec;
begin
  Result.Proc := nil;
  Result.Obj := nil;
end;

function SameDisposeRec(const A, B: TMarshaller.TDisposeRec): Boolean;
begin
  Result := (Pointer(@A.Proc) = Pointer(@B.Proc)) and (A.Obj = B.Obj) and (A.Arg1 = B.Arg1) and (A.Arg2 = B.Arg2);
end;

procedure TMarshaller.TDisposer.RemoveDispose(Rec: TDisposeRec);
var
  i: Integer;
begin
  if FCount <= Length(FInline) then
  begin
    for i := 0 to FCount - 1 do
      if SameDisposeRec(FInline[i], Rec) then
        FInline[i] := MakeNop;
  end
  else
  begin
    for i := 0 to Length(FInline) - 1 do
      if SameDisposeRec(FInline[i], Rec) then
        FInline[i] := MakeNop();
    for i := 0 to FCount - Length(FInline) - 1 do
      if SameDisposeRec(FOverflow[i], Rec) then
        FOverflow[i] := MakeNop;
  end;
end;

{$IFDEF MSWINDOWS}
// This API should be moved into Winapi.Windows.pas
function GetUserDefaultUILanguage: LANGID; stdcall;
  external 'kernel32.dll' name 'GetUserDefaultUILanguage';

type
  TLanguageArray = TArray<string>;
var
  LanguageArray : TLanguageArray;
  DefaultFallbackLanguages: string = '';

procedure InitLanguageList;

  procedure AddNewLanguages(NewLanguages: string);
  var
    aLang: string;
    I: integer;
  begin
    NewLanguages := UpperCase(NewLanguages);
    while NewLanguages <> '' do
    begin
      I := Pos(',', NewLanguages);
      if I > 0 then
      begin
        aLang := Copy(NewLanguages, 1, I-1);
        NewLanguages := Copy(NewLanguages, I+1, MAXINT);
      end
      else
      begin
        aLang := NewLanguages;
        NewLanguages := '';
      end;
      if aLang <> '' then
      begin
        // Duplicate check.
        for I := 0 to Length(LanguageArray) - 1 do
        begin
          if LanguageArray[I] = aLang then
          begin
            aLang := '';
            break;
          end;
        end;
      end;
      if aLang <> '' then
      begin
        SetLength(LanguageArray, length(LanguageArray)+1);
        LanguageArray[length(LanguageArray)-1] := aLang;
      end;
    end;
  end;

var
  aLanguageList: string;
begin
  if Length(LanguageArray) = 0 then
  begin
    aLanguageList := GetLocaleOverride('');
    if aLanguageList = '' then
      aLanguageList := GetUILanguages(GetUserDefaultUILanguage);
    AddNewLanguages(aLanguageList);
    if DefaultFallbackLanguages <> '' then
      AddNewLanguages(DefaultFallbackLanguages);
  end;
end;

function GetDefaultFallbackLanguages: string;
begin
  Result := DefaultFallbackLanguages;
end;

procedure SetDefaultFallbackLanguages(const Languages: string);
begin
  if DefaultFallbackLanguages <> UpperCase(Languages) then
  begin
    DefaultFallbackLanguages := UpperCase(Languages);
    SetLength(LanguageArray, 0);
    InitLanguageList;
  end;
end;

function PreferredUILanguages: string;
var
  aLang, Separator: string;
begin
  InitLanguageList;

  Result := '';
  Separator := '';
  for aLang in LanguageArray do
  begin
    Result := Result + Separator + aLang;
    Separator := ',';
  end;
end;

{ TLanguageListEnumerator }

type
  TLanguageListEnumerator = class(TInterfacedObject,  ILanguageEnumerator)
  protected
    FLanguages: TLanguageArray;
    FCount: integer;
    FIndex: integer;
  public
    constructor Create(ALanguageList: TLanguageArray);
    { ILanguageEnumerator }
    function MoveNext: Boolean; inline;
    function GetCurrent: string; inline;
    property Current: string read GetCurrent;
  end;

constructor TLanguageListEnumerator.Create(ALanguageList: TLanguageArray);
begin
  inherited create;
  FLanguages := ALanguageList;
  FCount := length(FLanguages);
  FIndex := -1;
end;

function TLanguageListEnumerator.GetCurrent: String;
begin
  Result := FLanguages[FIndex];
end;

function TLanguageListEnumerator.MoveNext: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < FCount;
end;

{ TLanguageEnumerable }

type
  TLanguageEnumerable = class(TInterfacedObject, ILanguageEnumerable)
  public
    { ILanguageEnumerable }
    function GetEnumerator: ILanguageEnumerator;
  end;

function TLanguageEnumerable.GetEnumerator: ILanguageEnumerator;
begin
  Result := TLanguageListEnumerator.Create(LanguageArray);
end;

// PreferredUILanguageList
function PreferredUILanguageList: ILanguageEnumerable;
begin
  InitLanguageList;
  Result := TLanguageEnumerable.Create;
end;

Type
  TCheckProc = reference to function(const Directory: string) : boolean;

function TraverseDirectory(const Directory : string; CheckProc: TCheckProc): string;
var
  Ind: Integer;
  P: PChar;
  L, R, Language: string;
begin
  P := PChar(Directory);
  for Ind := Length(Directory) downto 1 do
  begin
    if P[Ind-1] = PathDelim then
    begin
      L := Copy(Directory, 1, Ind-1);
      R := Copy(Directory, Ind+1, MAXINT);
      for Language in PreferredUILanguageList do
      begin
        Result :=  L + PathDelim + Language + PathDelim + R;
        if CheckProc(Result) then exit;
      end;
    end;
  end;
  Result := '';
end;

function LocaleFileExists(const FileName: string): Boolean;
var
  Path, Name: string;
  TempPath: string;
begin
  TempPath := ExpandFileName(FileName);
  Path := ExtractFilePath(TempPath);
  Name := ExtractFileName(TempPath);
  Result := '' <> TraverseDirectory(IncludeTrailingPathDelimiter(Path),
    function (const Directory: string) : boolean
    begin
      Result := FileExists(Directory + Name)
    end);
  if Not Result then
    Result := FileExists(TempPath);
end;

function GetLocaleFile(const FileName: string): string;
var
  Path, Name: string;
  TempPath: string;
begin
  TempPath := ExpandFileName(FileName);
  Path := ExtractFilePath(TempPath);
  Name := ExtractFileName(TempPath);
  Result := TraverseDirectory(IncludeTrailingPathDelimiter(Path),
    function (const Directory: string) : boolean
    begin
      Result := FileExists(Directory + Name)
    end);
  if Result = '' then
    Result := TempPath
  else
    Result := Result + Name;
end;

function LocaleDirectoryExists(const Directory: string): Boolean;
var
  TempPath : string;
begin
  TempPath := IncludeTrailingPathDelimiter(ExpandFileName(Directory));
  Result := '' <> TraverseDirectory(TempPath,
    function (const Directory: string) : boolean
    begin
      Result := DirectoryExists(Directory)
    end);
  if Not Result then
    Result := DirectoryExists(TempPath);
end;

function GetLocaleDirectory(const Directory: string): String;
var
  TempPath : string;
begin
  TempPath := IncludeTrailingPathDelimiter(ExpandFileName(Directory));
  Result := TraverseDirectory(TempPath,
    function (const Directory: string) : boolean
    begin
      Result := DirectoryExists(Directory)
    end);
  if Result = '' then
    Result := TempPath;
end;
{$ENDIF MSWINDOWS}

{ TOSVersion }

class constructor TOSVersion.Create;
{$IFDEF MSWINDOWS}
const
  CArchitectures: array[Boolean] of TArchitecture = (arIntelX86, arIntelX64);
var
  SysInfo: TSystemInfo;
  VerInfo: TOSVersionInfoEx;
begin
  ZeroMemory(@VerInfo, SizeOf(VerInfo));
  VerInfo.dwOSVersionInfoSize := SizeOf(VerInfo);
  GetVersionEx(VerInfo);

  FPlatform := pfWindows;
  FMajor := VerInfo.dwMajorVersion;
  FMinor := VerInfo.dwMinorVersion;
  FBuild := VerInfo.dwBuildNumber;
  FServicePackMajor := VerInfo.wServicePackMajor;
  FServicePackMinor := VerInfo.wServicePackMinor;

  ZeroMemory(@SysInfo, SizeOf(SysInfo));
  if Check(5, 1) then // GetNativeSystemInfo not supported on Windows 2000
    GetNativeSystemInfo(SysInfo);
  FArchitecture := CArchitectures[SysInfo.wProcessorArchitecture = PROCESSOR_ARCHITECTURE_AMD64];

  FName := SWindows;
  case FMajor of
    6:  case FMinor of
          0: if VerInfo.wProductType = VER_NT_WORKSTATION then
               FName := SWindowsVista
             else
               FName := SWindowsServer2008;
          1: if VerInfo.wProductType = VER_NT_WORKSTATION then
               FName := SWindows7
             else
               FName := SWindowsServer2008R2;
          2: if VerInfo.wProductType = VER_NT_WORKSTATION then
               FName := SWindows8
             else
               FName := SWindowsServer2012;
        end;
    5:  case FMinor of
          0: FName := SWindows2000;
          1: FName := SWindowsXP;
          2:
            begin
              if (VerInfo.wProductType = VER_NT_WORKSTATION) and
                 (SysInfo.wProcessorArchitecture = PROCESSOR_ARCHITECTURE_AMD64) then
                FName := SWindowsXP
              else
              begin
                if GetSystemMetrics(SM_SERVERR2) = 0 then
                  FName := SWindowsServer2003
                else
                  FName := SWindowsServer2003R2
              end;
            end;
        end;
  end;
end;
{$ENDIF MSWINDOWS}
{$IF defined(MACOS) and NOT defined(IOS)}
const
  SCName = 'hw.optional.x86_64'; // do not localize
  PListName: string = '/System/Library/CoreServices/SystemVersion.plist'; // do not localize
var
  Lx86_64, LSize: Integer;
  LPropList: CFPropertyListRef;
  LURL: CFURLRef;
  LValue, LKey: CFStringRef;
  LData: CFDataRef;
  LCode: Integer;
  M: TMarshaller;
begin
  FPlatform := pfMacOS;
  Gestalt(gestaltSystemVersionMajor, @FMajor);
  Gestalt(gestaltSystemVersionMinor, @FMinor);
  Gestalt(gestaltSystemVersionBugFix, @FServicePackMajor);
  // Read product name from /System/Library/CoreServices/SystemVersion.plist
  FName := 'Mac OS'; // do not localize
  LURL := CFURLCreateFromFileSystemRepresentation(kCFAllocatorDefault,
    M.AsAnsi(PListName, CP_UTF8).ToPointer, Length(PListName), False);
  if LURL <> nil then
  try
    if CFURLCreateDataAndPropertiesFromResource(kCFAllocatorDefault,
       LURL, @LData, nil, nil, LCode) then
    try
      LPropList := CFPropertyListCreateFromXMLData(kCFAllocatorDefault,
        LData, kCFPropertyListImmutable, nil);
      if LPropList <> nil then
      try
        if CFGetTypeId(LPropList) = CFDictionaryGetTypeID then
        begin
          LKey := CFSTR('ProductName'); // do not localize
          LValue := CFDictionaryGetValue(LPropList, LKey);
          FName := TCFString(LValue).AsString;
        end;
      finally
        CFRelease(LPropList);
      end;
    finally
      CFRelease(LData);
    end;
  finally
    CFRelease(LURL);
  end;

  // Default to x64 since all new Macs ship with 64-bit capable CPUs
  LSize := 4;
  if (SysCtlByName(MarshaledAString(SCName), @Lx86_64, @LSize, nil, 0) = 0) and (Lx86_64 = 0) then
    FArchitecture := arIntelX86
  else
    FArchitecture := arIntelX64;
end;
{$ENDIF MACOS}
{$IF defined(IOS)}
var
  UIDevice: Pointer;
  VersionString: string;
  Numbers: TArray<string>;
begin
  UIDevice := objc_msgSend(objc_getClass('UIDevice'), sel_getUid('currentDevice'));
  if UIDevice <> nil then
  begin
    VersionString := string(MarshaledAString(objc_msgSend(objc_msgSend(UIDevice, sel_getUid('systemVersion')), sel_getUid('UTF8String'))));
    Numbers := VersionString.Split(['.']);
    if Length(Numbers) > 0 then
      TryStrToInt(Numbers[0],FMajor);
    if Length(Numbers) > 1 then
      TryStrToInt(Numbers[1],FMinor);
    if Length(Numbers) > 2 then
      TryStrToInt(Numbers[2],FServicePackMajor);
  end;
  FName := 'iOS';
  FPlatform := pfiOS;
{$IF defined(CPUARM)}
  FArchitecture := arARM32;
{$ELSE !CPUARM}
  FArchitecture := arIntelX86;
{$ENDIF}
end;
{$ENDIF IOS}

class function TOSVersion.Check(AMajor: Integer): Boolean;
begin
  Result := Major >= AMajor;
end;

class function TOSVersion.Check(AMajor, AMinor: Integer): Boolean;
begin
  Result := (Major > AMajor) or ((Major = AMajor) and (Minor >= AMinor));
end;

class function TOSVersion.Check(AMajor, AMinor, AServicePackMajor: Integer): Boolean;
begin
  Result := (Major > AMajor) or ((Major = AMajor) and (Minor > AMinor)) or
    ((Major = AMajor) and (Minor = AMinor) and (ServicePackMajor >= AServicePackMajor));
end;

class function TOSVersion.ToString: string;
{$IFDEF MSWINDOWS}
const
  CVersionStr: array[Boolean] of PResStringRec = (@SVersionStr, @SSPVersionStr);
  CEditionStr: array[Boolean] of PResStringRec = (@SVersion32, @SVersion64);
begin
  Result := Format(LoadResString(CVersionStr[ServicePackMajor <> 0]),
    [Name, Major, Minor, Build, ServicePackMajor,
    LoadResString(CEditionStr[FArchitecture = arIntelX64])]);
end;
{$ENDIF MSWINDOWS}
{$IFDEF MACOS}
const
  SVersionStrLocal : string = '%s (Version %d.%d.%d)';
begin
                                                                  
  Result := Format(SVersionStrLocal, [FName, FMajor, FMinor, FServicePackMajor]);
end;
{$ENDIF MACOS}


initialization
  if ModuleIsCpp then HexDisplayPrefix := '0x';
  InitMonitorSupport;
{$IFNDEF NEXTGEN}
  AddModuleUnloadProc(ModuleUnloaded);
{$ENDIF !NEXTGEN}

{$IF defined(LINUX) or defined(MACOS)}
  SafeCallErrorProc := @SafeCallError;
{$ENDIF LINUX or MACOS}
{$IFDEF LINUX}
  CheckLocale;
{$ENDIF LINUX}

{$IFDEF MSWINDOWS}
  InitPlatformId;
  InitDriveSpacePtr;
  DefaultFallbackLanguages := GetLocaleOverride('');
  NTQueryObject := nil;
{$ENDIF MSWINDOWS}
  GetFormatSettings; { Win implementation uses platform id }
finalization
{$IFDEF POSIX}
  if libuuidHandle <> 0 then
    dlclose(libuuidHandle);
{$ENDIF}
{$IFNDEF NEXTGEN}
  RemoveModuleUnloadProc(ModuleUnloaded);
  ClearHashTables;
{$ENDIF !NEXTGEN}
  FreeTerminateProcs;
  DoneMonitorSupport;
end.
