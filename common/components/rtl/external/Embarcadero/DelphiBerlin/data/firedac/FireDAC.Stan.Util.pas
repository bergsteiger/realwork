{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                   FireDAC utilities                   }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Stan.Util;

interface

uses
{$IFDEF POSIX}
  Posix.String_,
{$ENDIF}
{$IFDEF MSWINDOWS}
  Winapi.Windows, System.Win.Registry, Winapi.ShellApi, Winapi.ShlObj,
    System.Win.ComObj, Winapi.ActiveX,
{$ENDIF}
  System.IniFiles, System.SysUtils, System.Classes, System.SyncObjs,
    System.Variants, Data.FmtBCD, Data.SqlTimSt,
  FireDAC.Stan.Intf;

{$IFNDEF MSWINDOWS}
const
  LOCALE_USER_DEFAULT = 0;
{$ENDIF}
{$IFNDEF NEXTGEN}
type
  MarshaledAString = PAnsiChar;
{$ENDIF}

type
  TFDMachineType = (mtUnknown, mt32Bit, mt64Bit, mtOther);
const
  mtNative = {$IFDEF FireDAC_32} mt32Bit {$ENDIF}
             {$IFDEF FireDAC_64} mt64Bit {$ENDIF};
  C_FD_MachineTypes: array[TFDMachineType] of String =
    ('Unknown', '32Bit', '64Bit', 'Other');

type
  TFDReadSharedMemoryStream = class;
  TFDThreadMsgBase = class;
  TFDThread = class;
{$IFDEF MSWINDOWS}
  TFDMethodThunk = class;
{$ENDIF}
  TFDRefCounter = class;
  TFDBuffer = class;
  TFDEncoder = class;
  TFDTextFile = class;
  TFDLog = class;
  TFDLibrary = class;
  TFDConfigFile = class;

  TFDReadSharedMemoryStream = class(TMemoryStream)
  private
    FShared: Boolean;
  protected
    function Realloc(var NewCapacity: Longint): Pointer; override;
  public
    procedure SetData(APtr: Pointer; ASize: Longint);
  end;

  TFDThreadMsgClass = class of TFDThreadMsgBase;
  TFDThreadMsgBase = class(TObject)
  public
    constructor Create; overload; virtual;
    function Perform(AThread: TFDThread): Boolean; virtual;
  end;

  TFDThreadStartMsg = class(TFDThreadMsgBase)
  public
    function Perform(AThread: TFDThread): Boolean; override;
  end;

  TFDThreadStopMsg = class(TFDThreadStartMsg)
  end;

  TFDThreadTerminateMsg = class (TFDThreadMsgBase)
  public
    function Perform(AThread: TFDThread): Boolean; override;
  end;

  TFDThread = class(TThread)
  private
    FActive: Boolean;
    FStartupTimeout: LongWord;
    FIdleTimeout: LongWord;
    FMessages: TFDThreadObjList;
    FControlEvent: TEvent;
    FMessageEvent: TEvent;
    procedure SetActive(AValue: Boolean);
    procedure EnqueueControlMsg(AMsg: TFDThreadMsgBase);
  protected
    procedure Execute; override;
    function DoAllowTerminate: Boolean; virtual;
    procedure DoIdle; virtual;
    procedure DoTimeout; virtual;
    procedure DoActiveChanged; virtual;
    class function GetStartMsgClass: TFDThreadMsgClass; virtual;
    class function GetStopMsgClass: TFDThreadMsgClass; virtual;
    class function GetTerminateMsgClass: TFDThreadMsgClass; virtual;
    property Messages: TFDThreadObjList read FMessages;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Shutdown(AWait: Boolean = True);
    procedure Ping;
    procedure EnqueueMsg(AMsg: TFDThreadMsgBase);
    class procedure Synchronize(AMethod: TThreadMethod); overload;
    property StartupTimeout: LongWord read FStartupTimeout write FStartupTimeout;
    property IdleTimeout: LongWord read FIdleTimeout write FIdleTimeout;
    property Active: Boolean read FActive write SetActive;
  end;

{$IFDEF MSWINDOWS}
  TFDMethodThunk = class(TObject)
  private
    FCallAddress: Pointer;
    FProcPtr: Pointer;
    FSavedFlag: LongWord;
    FSelfPtr: Pointer;
    function GetCallAddress: Pointer;
  public
    constructor Create(ApSelf, ApProc: Pointer);
    destructor Destroy; override;
    procedure Clear;
    property CallAddress: Pointer read GetCallAddress;
  end;
{$ENDIF}

  TFDRefCounter = class(TObject)
  private
    FRefs: Integer;
    FOwner: TObject;
  public
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
    procedure CountRef(AInit: Integer = 1); inline;
    procedure AddRef; inline;
    procedure RemRef; inline;
    property Refs: Integer read FRefs;
  end;

  TFDBuffer = class(TObject)
  public
    FBuffer: Pointer;
    FBufferSize: LongWord;
    constructor Create;
    destructor Destroy; override;
    function Extend(ASrcDataLen: LongWord; var ADestDataLen: LongWord;
      ASrcType, ADestType: TFDDataType): Pointer;
    function Check(ALen: LongWord = 0): Pointer;
    procedure Release;
    property Ptr: Pointer read FBuffer;
    property Size: LongWord read FBufferSize;
  end;

  TFDEncoder = class(TObject)
  private
    FBuffer: TFDBuffer;
    FOwnBuffer: Boolean;
    FEncoding: TFDEncoding;
    function GetPreamble: TFDByteString;
    function Alloc(ALen: LongWord): Pointer; inline;
    procedure Release(APtr: Pointer); inline;
    class procedure SetBytes(var AStr: TFDByteString; AValue: Pointer;
      ALen, ATrailerLen: Integer);
    class procedure SetTrailerBytes(var AStr: TFDByteString; AAppend: Boolean;
      ATrailerLen: Integer);
                                                                                        
(*
    class function Utf16ToUtf8(ADest: PAnsiChar; AMaxDestBytes: Integer;
      ASource: PWideChar; ASourceChars: Integer): Integer;
    class function Utf8ToUtf16(ADest: PWideChar; AMaxDestChars: Integer;
      ASource: PAnsiChar; ASourceBytes: Integer): Integer;
*)
  public
    constructor Create(ABuffer: TFDBuffer);
    destructor Destroy; override;

    function Encode(const AStr: String; ADestEncoding: TFDEncoding = ecDefault): TFDByteString; overload;
    function Encode(const ASrc: Pointer; ASrcLen: Integer; var ADest: Pointer;
      ASrcEncoding: TFDEncoding = ecDefault; ADestEncoding: TFDEncoding = ecDefault): Integer; overload;
    function Encode(const ASrc: Pointer; ASrcLen: Integer;
      ASrcEncoding: TFDEncoding = ecDefault; ADestEncoding: TFDEncoding = ecDefault): TFDByteString; overload;
    function Decode(const ASrc: Pointer; ASrcLen: Integer; var ADest: Pointer;
      ADestEncoding: TFDEncoding = ecDefault; ASrcEncoding: TFDEncoding = ecDefault): Integer; overload;
    function Decode(const AStr: TFDByteString; ASrcEncoding: TFDEncoding = ecDefault): String; overload;
    function Decode(const ASrc: Pointer; ASrcLen: Integer = -1; ASrcEncoding: TFDEncoding = ecDefault): String; overload;
    function EncodedLength(const AStr: TFDByteString; ADestEncoding: TFDEncoding = ecDefault): Integer;

    class function Deco(const ASrc: Pointer; ASrcLen: Integer; ASrcEncoding: TFDEncoding): String; overload;
    class function Deco(const ASrc: TFDByteString; ASrcEncoding: TFDEncoding): String; overload;
    class function Enco(const AStr: String; ADestEncoding: TFDEncoding): TFDByteString; overload;
    class function EncoLength(const AStr: TFDByteString; ADestEncoding: TFDEncoding): Integer;

    property Encoding: TFDEncoding read FEncoding write FEncoding;
    property Preamble: TFDByteString read GetPreamble;
    property Buffer: TFDBuffer read FBuffer;
  end;

  TFDTextFile = class(TObject)
  private
    FStream: TStream;
    FStreamOwned: Boolean;
    FBuffer: TFDBuffer;
    FEncoder: TFDEncoder;
    FEndOfLine: TFDTextEndOfLine;
    function GetPosition: Int64;
    procedure SetPosition(AValue: Int64);
  public
    constructor Create(const AFileName: String; ARead, AAppend: Boolean;
      AEncoding: TFDEncoding; AEndOfLine: TFDTextEndOfLine); overload;
    constructor Create(AStream: TStream; AOwned, ARead, AAppend: Boolean;
      AEncoding: TFDEncoding; AEndOfLine: TFDTextEndOfLine); overload;
    destructor Destroy; override;
    procedure WriteChar(const AChar: Char);
    procedure WriteText(const AText: String);
    procedure WriteLine(const AText: String);
    function ReadChar(out AChar: Char): Boolean;
    function ReadChars(out AChar: Char; ACount: Integer): Integer;
    function ReadLine: String;
    function ExtractString(AFromPosition, AToPosition: Integer): String;
    property Stream: TStream read FStream;
    property Encoder: TFDEncoder read FEncoder;
    property EndOfLine: TFDTextEndOfLine read FEndOfLine;
    property Position: Int64 read GetPosition write SetPosition;
  end;

  TFDLog = class(TFDStringList)
  private
    FLogLevel: Integer;
  public
    procedure Value(const AName, AValue: String);
    procedure Msg(const AMsg: String);
    procedure Start(const AMsg: String);
    procedure Stop;
  end;

  TFDLibrary = class(TObject)
  private
    FDriverID: String;
    [Weak] FOwningObj: TObject;
    FProduct, FVersionName, FCopyright, FInfo: String;
    FDLLName: String;
    FFailedProcs: TStrings;
  protected
    FVersion: TFDVersion;
    FVersionStr: String;
    FhDLL: THandle;
    procedure GetLibraryInfo; virtual;
    procedure LoadLibrary(const ADLLNames: array of String; ARequired: Boolean); virtual;
    function GetProc(const AProcName: String; ARequired: Boolean = True): Pointer; virtual;
    procedure LoadEntries; virtual; abstract;
  public
    constructor Create(const ADriverID: String; AOwningObj: TObject);
    destructor Destroy; override;
    procedure Load(const ADLLNames: array of String; ARequired: Boolean);
    procedure Unload; virtual;
    property DriverID: String read FDriverID;
    property OwningObj: TObject read FOwningObj;
    property hDLL: THandle read FhDLL;
    property DLLName: String read FDLLName;
    property Version: TFDVersion read FVersion;
    property Product: String read FProduct;
    property VersionStr: String read FVersionStr;
    property VersionName: String read FVersionName;
    property Copyright: String read FCopyright;
    property Info: String read FInfo;
  end;

  TFDConfigFile = class({$IFDEF MSWINDOWS} TRegistryIniFile
                        {$ELSE}            TMemIniFile      {$ENDIF})
{$IFNDEF MSWINDOWS}
  private
    FReadOnly: Boolean;
{$ENDIF}
  public
    constructor Create(AReadOnly: Boolean);
{$IFNDEF MSWINDOWS}
    destructor Destroy; override;
{$ENDIF}
  end;

// String
function FDStrLike(const AStr, AMask: String; ANoCase: Boolean = False;
  AManyCharsMask: Char = '%'; AOneCharMask: Char = '_'; AEscapeChar: Char = '\'): Boolean;
function FDStrRPos(Str1, Str2: PChar): PChar;
function FDPadR(const AStr: String; ALength: Integer): String;
function FDPadL(const AStr: String; ALength: Integer): String;
function FDValToStr(const AValue: Variant; AQuotes: Boolean): String;
function FDIdentToStr(const AValue: Variant; var AQuotes: Boolean): String;
function FDVarToBool(const AValue: Variant): Boolean;
function FDSameVariants(const A, B: Variant): Boolean;
function FDExtractFieldName(const AStr: String; var APos: Integer): String; overload;
function FDExtractFieldName(const AStr: String; var APos: Integer; const AFmt: TFDParseFmtSettings): String; overload;
function FDMergeFieldNames(const AFieldNames1, AFieldNames2: String; AIgnoreModifiers: Boolean = False): String;
function FDCountFieldNames(const AStr: String): Integer;
function FDFieldInFieldNames(const AStr, AName: String) : Boolean;
procedure FDFieldNamesToArray(const AFieldNames: String; var AFieldNamesArray: TFDStringArray);
function FDUnquote(const AString: String; AQuoteChar: Char = '"'): String;
function FDCompareAnsiStr(const AStr1, AStr2: PFDAnsiString; ALen1, ALen2: Integer;
  ALocale: TFDLocalID; ANoCase, APartial, ANoSymbols: Boolean): Integer;
function FDCompareWideStr(const AStr1, AStr2: PWideChar; ALen1, ALen2: Integer;
  ALocale: TFDLocalID; ANoCase, APartial, ANoSymbols: Boolean): Integer;
function FDCompareByteStr(const AStr1, AStr2: PByte; ALen1, ALen2: Integer): Integer;
function FDStrReplace(const AStr: String; ASrch, ARepl: Char): String;
procedure FDBin2HexBS(APtr: Pointer; ALen: Integer; ADest: PByte);
function FDBin2Hex(APtr: Pointer; ALen: Integer): String;
function FDHex2Bin(AStr: String): TFDByteString;

// ANSI string
function FDAnsiStrLen(AStr: PFDAnsiString): Integer;

// Wide string
function FDInSet(AChar: Char; ASet: TFDCharSet): Boolean; inline;

// System & path
function FDLastSystemErrorMsg: String;
function FDGetCmdParam(const AParName: String; const ADefValue: String): String; overload;
function FDGetCmdParam(const AParName: String; ATrigger: Boolean; var AValue: String): Boolean; overload;
function FDGetSystemCfgPath: String;
function FDGetAppPath: String;
function FDGetAppCfgPath: String;
function FDGetAppDocPath: String;
function FDGetTempPath: String;
function FDGetBestPath(const ASpecifiedFileName, AGlobalFileName, ADefFileName: String): String;
function FDNormPath(const APath: String): String;
function FDExtractFileNameNoPath(const AFileName: String): String;
{$IFDEF MSWINDOWS}
function FDBrowseForFolder(AHandle: THandle; ATitle: string): string;
function FDGetVersionInfo(const AFileName: string; out AProduct,
  AVersion, AVersionName, ACopyright, AInfo: string): Boolean;
{$ENDIF}
function FDGetLibMachineType(const AFileName: string): TFDMachineType;
function FDVerStr2Int(const AVersion: String): TFDVersion;
function FDVerInt2Str(AVersion: TFDVersion): String;
function FDReadRegValue(const AName: String): String;
procedure FDWriteRegValue(const AName, AValue: String);
function FDExpandStr(const AStr: String; AVars: TStrings = nil): String;
procedure FDExpandStrs(const AStrs: TStrings; AVars: TStrings = nil);
function FDIsDesignTime: Boolean; inline;

// Date & time
// All time-interval related code is in the FireDAC.Stan.SQLTimeInt
function FDSQLTimeStamp2Time(const AValue: TSQLTimeStamp): Integer;
function FDSQLTimeStamp2Date(const AValue: TSQLTimeStamp): Integer;
function FDTime2SQLTimeStamp(const AValue: Integer): TSQLTimeStamp;
function FDDate2SQLTimeStamp(const AValue: Integer): TSQLTimeStamp;
function FDTime2DateTime(const AValue: Integer): TDateTime;
function FDDateTime2Time(const AValue: TDateTime): Integer;
function FDDate2DateTime(const AValue: Integer): TDateTime;
function FDDateTime2Date(const AValue: TDateTime): Integer;
function FDMSecs2DateTime(const AValue: Double): TDateTime; inline;
function FDDateTime2MSecs(const AValue: TDateTime): Comp; inline;

// BCD & numeric
procedure FDStr2BCD(pIn: PChar; ASize: Integer; out ABcd: TBcd; ADot: Char);
procedure FDFloatRec2BCD(const ARec: TFloatRec; out ABcd: TBcd);
procedure FDBCD2Str(pOut: PChar; out ASize: Integer; const ABcd: TBcd; ADot: Char);
procedure FDBcdGetMetrics(const ABcd: TBcd; out APrecision, AScale: Smallint);
procedure FDBCD2Double(const ABcd: TBcd; out AVal: Extended);
procedure FDDouble2BCD(const AExt: Extended; out AVal: TBcd);
procedure FDInt2Str(ASrcData: Pointer; ASrcLen: Integer; var ADestData: PChar;
  var ADestLen: Integer; ANoSign: Boolean; AScale: Integer);
procedure FDStr2Int(ASrcData: PChar; ASrcLen: Integer; ADestData: Pointer;
  ADestLen: Integer; ANoSign: Boolean = False; AScale: Integer = 0);
function FDFloat2Str(const AValue: Extended; ADot: Char = '.'; APrec: Integer = 18): String;
function FDStr2Float(const AValue: String; ADot: Char = '.'): Extended; overload;
procedure FDStr2Float(pIn: PChar; ASize: Integer; ADestData: Pointer;
  ADestLen: Integer; ADot: Char = '.'); overload;
function FDBcdIsDecimalPartEmpty(const ABCD: TBcd): Boolean;
function FDCurr2Str(const AValue: Currency; ADot: Char = '.'): String;
  overload; inline;
procedure FDCurr2Str(pOut: PChar; out ASize: Integer;
  const AValue: Currency; ADot: Char = '.'); overload;
function FDStr2Curr(const AValue: String; ADot: Char = '.'): Currency; overload;
procedure FDStr2Curr(pIn: PChar; ASize: Integer; out ACurr: Currency;
  ADot: Char = '.'); overload;
function FDRandomNumber(AMaxPrec, AMaxScale: Integer; ASign: Integer): String;
function FDDisableFPExc: NativeUInt;
procedure FDResetFPExc(AValue: NativeUInt);

// other
function FDIndexOf(AList: Pointer; ALen: Integer; AItem: Pointer): Integer;
procedure FDFree(AObj: TObject); inline;
procedure FDFreeAndNil(var AObj); inline;
function FDTimeout(AStartTicks, ATimeout: Cardinal): Boolean;
procedure FDHandleException;
procedure FDShell(const ACommand, ALayer: String);
procedure FDFileMove(const ASrcName, ADestName: String);
procedure FDSystemMessage(const ACaption, AMessage: String; AWarning: Boolean);
procedure FDSetEnv(const AName, AValue: String);
procedure FDHighRefCounter(var ACounter: Integer); inline;
function FDAlign(AValue: Integer): Integer; inline;

type
  TFDCheckGuiRunningFunc = function: Boolean;
var
  GParseFmtSettings: TFDParseFmtSettings;
  GSemicolonFmtSettings: TFDParseFmtSettings;
  GSpaceFmtSettings: TFDParseFmtSettings;
  GCheckGuiRunning: TFDCheckGuiRunningFunc;
  GIsDesignTime: Boolean;

const
  C_FD_ScaleFactor: array[1 .. 15] of Int64 = (10, 100, 1000, 10000, 100000,
    1000000, 10000000, 100000000, 1000000000, 10000000000, 100000000000,
    1000000000000, 10000000000000, 100000000000000, 1000000000000000);

implementation

uses
{$IFDEF POSIX}
  Posix.Unistd, Posix.Dlfcn, Posix.Signal, Posix.Stdlib, Posix.Stdio,
{$ENDIF}
{$IFDEF MACOS}
  Macapi.CoreServices, Macapi.Mach,
  {$IFDEF IOS}
  iOSapi.Foundation,
  {$ELSE}
  Macapi.Foundation,
  {$ENDIF}
{$ENDIF}
{$IFDEF ANDROID}
  Androidapi.IOUtils,
{$ENDIF}
  System.StrUtils, System.TypInfo, System.SysConst, System.RTLConsts,
    System.Generics.Collections, System.Types, System.IOUtils, System.Math,
{$IFNDEF NEXTGEN}
    System.AnsiStrings,
{$ENDIF}
  FireDAC.Stan.Consts, FireDAC.Stan.Error;

var
  C_Date_1_1_1: TDateTime;

threadvar
  GCachedNumFS: TFormatSettings;

{-------------------------------------------------------------------------------}
{ TFDReadSharedMemoryStream                                                     }
{-------------------------------------------------------------------------------}
function TFDReadSharedMemoryStream.Realloc(var NewCapacity: Longint): Pointer;
begin
  if not FShared then
    Result := inherited Realloc(NewCapacity)
  else begin
    NewCapacity := Longint(Size);
    Result := Memory;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDReadSharedMemoryStream.SetData(APtr: Pointer; ASize: Longint);
begin
  if not FShared then
    Capacity := 0;
  SetPointer(APtr, ASize);
  FShared := (APtr <> nil) and (ASize <> 0);
end;

{-------------------------------------------------------------------------------}
{ TFDThreadMsgBase                                                              }
{-------------------------------------------------------------------------------}
constructor TFDThreadMsgBase.Create;
begin
  inherited Create;
end;

{-------------------------------------------------------------------------------}
function TFDThreadMsgBase.Perform(AThread: TFDThread): Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
{ TFDThreadStartMsg                                                             }
{-------------------------------------------------------------------------------}
function TFDThreadStartMsg.Perform(AThread: TFDThread): Boolean;
begin
  AThread.FControlEvent.SetEvent;
  Result := True;
end;

{-------------------------------------------------------------------------------}
{ TFDThreadTerminateMsg                                                         }
{-------------------------------------------------------------------------------}
function TFDThreadTerminateMsg.Perform(AThread: TFDThread): Boolean;
begin
  AThread.Terminate;
  if AThread.FControlEvent <> nil then
    AThread.FControlEvent.SetEvent;
  Result := False;
end;

{-------------------------------------------------------------------------------}
{ TFDThread                                                                     }
{-------------------------------------------------------------------------------}
var
  FThreads: TFDThreadObjList;
  FLock: TCriticalSection;

constructor TFDThread.Create;
begin
  FThreads.Add(Self);
  inherited Create(True);
  FreeOnTerminate := True;
  FActive := False;
  FMessages := TFDThreadObjList.Create;
  FMessages.Duplicates := dupAccept;
  FMessageEvent := TEvent.Create(nil, False, False, '');
  FControlEvent := TEvent.Create(nil, False, False, '');
  FStartupTimeout := C_FD_ThreadStartupTimeout;
  FIdleTimeout := C_FD_ThreadIdleTimeout;
end;

{-------------------------------------------------------------------------------}
destructor TFDThread.Destroy;
begin
  if FThreads <> nil then
    FThreads.Remove(Self);
  Shutdown(True);
  FDFreeAndNil(FControlEvent);
  FDFreeAndNil(FMessageEvent);
  FDFreeAndNil(FMessages);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TFDThread.GetStartMsgClass: TFDThreadMsgClass;
begin
  Result := TFDThreadStartMsg;
end;

{-------------------------------------------------------------------------------}
class function TFDThread.GetStopMsgClass: TFDThreadMsgClass;
begin
  Result := TFDThreadStopMsg;
end;

{-------------------------------------------------------------------------------}
class function TFDThread.GetTerminateMsgClass: TFDThreadMsgClass;
begin
  Result := TFDThreadTerminateMsg;
end;

{-------------------------------------------------------------------------------}
procedure TFDThread.DoActiveChanged;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure TFDThread.SetActive(AValue: Boolean);
var
  oList: TFDObjList;
  i: Integer;
  oMsg: TFDThreadMsgBase;
begin
  if FActive <> AValue then begin
    FActive := AValue;
    try
      if Suspended then
        Resume;
      if FActive then
        EnqueueControlMsg(GetStartMsgClass().Create)
      else begin
        EnqueueControlMsg(GetStopMsgClass().Create);
        if TThread.CurrentThread.ThreadID = MainThreadID then
          CheckSynchronize();
        oList := FMessages.LockList;
        try
          for i := 0 to oList.Count - 1 do begin
            oMsg := TFDThreadMsgBase(oList[i]);
            oMsg.Perform(Self);
            FDFree(oMsg);
          end;
        finally
          oList.Count := 0;
          FMessages.UnlockList;
        end;
      end;
      DoActiveChanged;
    except
      FActive := False;
    end;
  end;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure TFDThread.Shutdown(AWait: Boolean);
var
{$IFDEF MSWINDOWS}
  iExitCode: LongWord;
{$ENDIF}
  iCurrTID: TThreadID;
begin
  if Suspended then
    Resume;
  Active := False;
  EnqueueControlMsg(GetTerminateMsgClass().Create);
  iCurrTID := TThread.CurrentThread.ThreadID;
  if iCurrTID <> ThreadID then
{$IFDEF MSWINDOWS}
    repeat
      if (iCurrTID = MainThreadID) and AWait then
        CheckSynchronize()
      else
        Sleep(10);
      iExitCode := 0;
    until not (AWait and GetExitCodeThread(Handle, iExitCode) and (iExitCode = STILL_ACTIVE));
{$ENDIF}
{$IFDEF POSIX}
    if AWait then
      try
        WaitFor
      except
        // hide "Thread Error: No such process"
      end
    else
      Sleep(10);
{$ENDIF}
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
procedure TFDThread.EnqueueMsg(AMsg: TFDThreadMsgBase);
begin
  FMessages.Add(AMsg);
  FMessageEvent.SetEvent;
end;

{-------------------------------------------------------------------------------}
procedure TFDThread.EnqueueControlMsg(AMsg: TFDThreadMsgBase);
var
  sEventName: String;
  i: Integer;
begin
  if (TThread.CurrentThread.ThreadID <> ThreadID) and not Finished then begin
    sEventName := LowerCase(Copy(AMsg.ClassName, 10, Length(AMsg.ClassName) - 9 - 3));
    EnqueueMsg(AMsg);
    if FThreads = nil then
      i := -1
    else begin
      i := FThreads.LockList.IndexOf(Self);
      FThreads.UnlockList;
    end;
    if i > 0 then
      case FControlEvent.WaitFor(FStartupTimeout) of
      wrTimeout:
        raise EThread.CreateFmt('Failed to %s thread [%s].'#13#10'Timeout [%d] expired',
          [sEventName, ClassName, FStartupTimeout]);
      wrError:
        raise EThread.CreateFmt('Failed to %s thread [%s].'#13#10'System error: %s',
          [sEventName, ClassName, FDLastSystemErrorMsg]);
      end;
  end
  else begin
    AMsg.Perform(Self);
    FDFree(AMsg);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDThread.Ping;
begin
  FMessageEvent.SetEvent;
end;

{-------------------------------------------------------------------------------}
function TFDThread.DoAllowTerminate: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDThread.DoIdle;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDThread.DoTimeout;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDThread.Execute;
var
  oReceivedMsgs: TFDObjList;
  i: Integer;
  oMsg: TFDThreadMsgBase;

  procedure Idle;
  begin
    if not (Terminated and DoAllowTerminate) then
      DoIdle;
  end;

begin
  while not (Terminated and DoAllowTerminate) do begin
    try
      case FMessageEvent.WaitFor(FIdleTimeout) of
      wrSignaled:
        begin
          oReceivedMsgs := FMessages.LockList;
          try
            if oReceivedMsgs.Count = 0 then
              Idle
            else
              for i := 0 to oReceivedMsgs.Count - 1 do begin
                oMsg := TFDThreadMsgBase(oReceivedMsgs[i]);
                try
                  if not oMsg.Perform(Self) then
                    Break;
                finally
                  FDFree(oMsg);
                end;
                Idle;
              end;
          finally
            oReceivedMsgs.Count := 0;
            FMessages.UnlockList;
          end;
        end;
      wrTimeout:
        if not (Terminated and DoAllowTerminate) then begin
          DoTimeout;
          Idle;
        end;
      else
        Terminate;
      end;
    except
      // no exceptions
    end;
  end;
end;

{-------------------------------------------------------------------------------}
class procedure TFDThread.Synchronize(AMethod: TThreadMethod);
begin
  TThread.Synchronize(nil, AMethod);
end;

{$IFDEF MSWINDOWS}
{-------------------------------------------------------------------------------}
{ TFDMethodThunk                                                                }
{-------------------------------------------------------------------------------}
  {$IFDEF CPUX64}
const
  ThunkCodeBlock1 : array[0..10] of byte = (
    $55,                       // PUSH RBP
    $53,                       // PUSH RBX
    $48, $83, $EC, $38,        // SUB RSP,$38
    $48, $89, $E5,             // MOV RBP,RSP
    $48, $B8 );                // MOV RAX, xxxxx
  ThunkCodeBlock2 : array[0..34] of byte = (
    $49, $89, $CA,             // MOV R10,RCX
    $49, $89, $D3,             // MOV R11,RDX
    $4C, $89, $C3,             // MOV RBX,R8
    $4C, $89, $4C, $24, $20,   // MOV [RSP+$20],R9
    $48, $8B, $4D, $70,        // MOV RCX,[RBP+$70]
    $48, $89, $4C, $24, $28,   // MOV [RSP+$28],RCX
    $48, $89, $c1,             // MOV RCX,RAX
    $4C, $89, $D2,             // MOV RDX,R10
    $4D, $89, $D8,             // MOV R8,R11
    $49, $89, $D9);            // MOV R9,RBX
                               // CALL Target
  ThunkCodeBlock3 : array[0..6] of byte = (
    $48, $8D, $65, $38,        // LEA RSP,[RBP+$38]
    $5B,                       // POP RBX
    $5D,                       // POP RBP
    $C3 );                     // RET
  {$ENDIF}

type
  PFDThunk = ^TFDThunk;
  TFDThunk = packed record
  {$IFDEF CPUX86}
    POPEDX: Byte;
    MOVEAX: Byte;
    SelfPtr: Pointer;
    PUSHEAX: Byte;
    PUSHEDX: Byte;
    JMP: Byte;
    JmpOffset: Integer;
  {$ENDIF}
  {$IFDEF CPUX64}
    CodeBlock1: array[0..sizeof(ThunkCodeBlock1)-1] of byte;
    SelfPtr: NativeUInt;
    CodeBlock2: array[0..sizeof(ThunkCodeBlock2)-1] of byte;
    CALL: Byte;
    CallOffset: Int32;
    CodeBlock3: array[0..sizeof(ThunkCodeBlock3)-1] of byte;
  {$ENDIF}
  end;

{-------------------------------------------------------------------------------}
constructor TFDMethodThunk.Create(ApSelf, ApProc: Pointer);
begin
  inherited Create;
  FCallAddress := nil;
  FSelfPtr := ApSelf;
  FProcPtr := ApProc;
end;

{-------------------------------------------------------------------------------}
destructor TFDMethodThunk.Destroy;
begin
  Clear;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDMethodThunk.Clear;
var
  SaveFlag: DWORD;
begin
  if @FCallAddress <> nil then begin
    VirtualProtect(PFDThunk(@FCallAddress), SizeOf(TFDThunk), FSavedFlag, @SaveFlag);
    VirtualFree(FCallAddress, 0, MEM_RELEASE);
    FCallAddress := nil;
    FSavedFlag := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMethodThunk.GetCallAddress: Pointer;
var
  pThunk: PFDThunk;
begin
  if FCallAddress = nil then begin
    FCallAddress := VirtualAlloc(nil, SizeOf(TFDThunk), MEM_COMMIT, PAGE_READWRITE);
    pThunk := PFDThunk(FCallAddress);
  {$IFDEF CPUX86}
    pThunk^.POPEDX := $5A;
    pThunk^.MOVEAX := $B8;
    pThunk^.SelfPtr := FSelfPtr;
    pThunk^.PUSHEAX := $50;
    pThunk^.PUSHEDX := $52;
    pThunk^.JMP := $E9;
    pThunk^.JmpOffset := NativeInt(FProcPtr) - NativeInt(@pThunk^.JMP) - 5;
  {$ENDIF}
  {$IFDEF CPUX64}
    Move(ThunkCodeBlock1, pThunk^.CodeBlock1[0], length(ThunkCodeBlock1));
    pThunk^.SelfPtr := NativeUInt(FSelfPtr);
    Move(ThunkCodeBlock2, pThunk^.CodeBlock2[0], length(ThunkCodeBlock2));
    pThunk^.CALL := $E8; // Call rel32
    pThunk^.CallOffset := NativeInt(FProcPtr) - NativeInt(@pThunk^.CodeBlock3[0]);
    Move(ThunkCodeBlock3, pThunk^.CodeBlock3[0], length(ThunkCodeBlock3));
  {$ENDIF}
    if not VirtualProtect(FCallAddress, SizeOf(TFDThunk), PAGE_EXECUTE_READ, @FSavedFlag) then
      FCallAddress := nil;
  end;
  ASSERT(FCallAddress <> nil);
  Result := FCallAddress;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{- TFDRefCounter                                                               -}
{-------------------------------------------------------------------------------}
constructor TFDRefCounter.Create(AOwner: TObject);
begin
  ASSERT(AOwner <> nil);
  inherited Create;
  FRefs := -1;
  FOwner := AOwner;
end;

{-------------------------------------------------------------------------------}
destructor TFDRefCounter.Destroy;
begin
  FRefs := -1;
  FOwner := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDRefCounter.CountRef(AInit: Integer);
begin
  ASSERT(AInit >= 0);
  if FRefs = -1 then
    FRefs := AInit;
end;

{-------------------------------------------------------------------------------}
procedure TFDRefCounter.AddRef;
begin
  if FRefs >= 0 then
    Inc(FRefs);
end;

{-------------------------------------------------------------------------------}
procedure TFDRefCounter.RemRef;
begin
  if FRefs > 0 then begin
    Dec(FRefs);
    if FRefs = 0 then
      FDFree(FOwner);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDBuffer                                                                     }
{-------------------------------------------------------------------------------}
constructor TFDBuffer.Create;
begin
  inherited Create;
  Release;
end;

{-------------------------------------------------------------------------------}
destructor TFDBuffer.Destroy;
begin
  Release;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDBuffer.Extend(ASrcDataLen: LongWord;
  var ADestDataLen: LongWord; ASrcType, ADestType: TFDDataType): Pointer;
var
  uiLen: LongWord;
begin
  ADestDataLen := ASrcDataLen;
  if ADestDataLen < ASrcDataLen then
    uiLen := ASrcDataLen
  else
    uiLen := ADestDataLen;
  if (ASrcType in C_FD_WideTypes) or (ADestType in C_FD_WideTypes) then begin
    uiLen := uiLen * SizeOf(WideChar);
    Inc(uiLen, SizeOf(WideChar));
  end;
  if (ASrcType in C_FD_AnsiTypes) or (ADestType in C_FD_AnsiTypes) then
    Inc(uiLen, SizeOf(TFDAnsiChar));
  Result := Check(uiLen);
end;

{-------------------------------------------------------------------------------}
function TFDBuffer.Check(ALen: LongWord = 0): Pointer;
var
  lAlloc: Boolean;
begin
  Inc(ALen, SizeOf(Word));
  if FBufferSize < ALen then begin
    FBufferSize := ALen;
    lAlloc := True;
  end
  else
    lAlloc := (FBuffer = nil);
  if lAlloc then
    ReallocMem(FBuffer, FBufferSize);
  Result := FBuffer;
end;

{-------------------------------------------------------------------------------}
procedure TFDBuffer.Release;
begin
  if FBuffer <> nil then begin
    FreeMem(FBuffer, FBufferSize);
    FBuffer := nil;
  end;
  FBufferSize := C_FD_MaxFixedSize;
end;

{-------------------------------------------------------------------------------}
{ TFDEncoder                                                                    }
{-------------------------------------------------------------------------------}
constructor TFDEncoder.Create(ABuffer: TFDBuffer);
begin
  inherited Create;
  FEncoding := ecANSI;
  if ABuffer <> nil then begin
    FBuffer := ABuffer;
    FOwnBuffer := False;
  end
  else begin
    FBuffer := TFDBuffer.Create;
    FOwnBuffer := True;
  end;
end;

{-------------------------------------------------------------------------------}
destructor TFDEncoder.Destroy;
begin
  if FOwnBuffer then
    FDFree(FBuffer);
  FBuffer := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDEncoder.Alloc(ALen: LongWord): Pointer;
begin
  if FBuffer = nil then
    GetMem(Result, ALen)
  else
    Result := FBuffer.Check(ALen);
end;

{-------------------------------------------------------------------------------}
procedure TFDEncoder.Release(APtr: Pointer);
begin
  if FBuffer = nil then
    FreeMem(APtr);
end;

{-------------------------------------------------------------------------------}
class procedure TFDEncoder.SetBytes(var AStr: TFDByteString; AValue: Pointer;
  ALen, ATrailerLen: Integer);
begin
  SetLength(AStr, ALen + ATrailerLen);
  if ALen > 0 then
    Move(AValue^, PByte(AStr)^, ALen);
  if ATrailerLen > 0 then
    SetTrailerBytes(AStr, False, ATrailerLen);
end;

{-------------------------------------------------------------------------------}
class procedure TFDEncoder.SetTrailerBytes(var AStr: TFDByteString;
  AAppend: Boolean; ATrailerLen: Integer);
var
  iLen: Integer;
  p: PByte;
begin
  iLen := Length(AStr);
  if AAppend then
    SetLength(AStr, iLen + ATrailerLen)
  else
    Dec(iLen, ATrailerLen);
  p := PByte(AStr) + iLen;
  while ATrailerLen > 0 do begin
    p^ := 0;
    Inc(p);
    Dec(ATrailerLen);
  end;
end;

(*
{-------------------------------------------------------------------------------}
class function TFDEncoder.Utf16ToUtf8(ADest: PAnsiChar; AMaxDestBytes: Integer;
  ASource: PWideChar; ASourceChars: Integer): Integer;
var
  i, count: Integer;
  c: Cardinal;
begin
  Result := 0;
  if ASource = nil then
    Exit;
  count := 0;
  i := 0;
  if ADest <> nil then begin
    while (i < ASourceChars) and (count < AMaxDestBytes) do begin
      c := Cardinal(ASource[i]);
      Inc(i);
      if c <= $7F then begin
        ADest[count] := AnsiChar(c);
        Inc(count);
      end
      else if c > $7FF then begin
        if count + 3 > AMaxDestBytes then
          break;
        ADest[count] := AnsiChar($E0 or (c shr 12));
        ADest[count+1] := AnsiChar($80 or ((c shr 6) and $3F));
        ADest[count+2] := AnsiChar($80 or (c and $3F));
        Inc(count,3);
      end
      else begin //  $7F < ASource[i] <= $7FF
        if count + 2 > AMaxDestBytes then
          break;
        ADest[count] := AnsiChar($C0 or (c shr 6));
        ADest[count+1] := AnsiChar($80 or (c and $3F));
        Inc(count,2);
      end;
    end;
  end
  else begin
    while i < ASourceChars do begin
      c := Integer(ASource[i]);
      Inc(i);
      if c > $7F then begin
        if c > $7FF then
          Inc(count);
        Inc(count);
      end;
      Inc(count);
    end;
  end;
  Result := count;  // convert zero based index to byte count
end;

{-------------------------------------------------------------------------------}
class function TFDEncoder.Utf8ToUtf16(ADest: PWideChar; AMaxDestChars: Integer;
  ASource: PAnsiChar; ASourceBytes: Integer): Integer;
var
  i, count: Integer;
  c: Byte;
  wc: Cardinal;
begin
  Result := 0;
  if ASource = nil then
    Exit;
  count := 0;
  i := 0;
  if ADest <> nil then begin
    while (i < ASourceBytes) and (count < AMaxDestChars) do begin
      wc := Cardinal(ASource[i]);
      Inc(i);
      if (wc and $80) <> 0 then begin
        if i >= ASourceBytes then
          Exit;           // incomplete multibyte char
        wc := wc and $3F;
        if (wc and $20) <> 0 then begin
          c := Byte(ASource[i]);
          Inc(i);
          if (c and $C0) <> $80 then
            Exit;         // malformed trail byte or out of range char
          if i >= ASourceBytes then
            Exit;         // incomplete multibyte char
          wc := (wc shl 6) or (c and $3F);
        end;
        c := Byte(ASource[i]);
        Inc(i);
        if (c and $C0) <> $80 then
          Exit;           // malformed trail byte

        ADest[count] := WideChar((wc shl 6) or (c and $3F));
      end
      else
        ADest[count] := WideChar(wc);
      Inc(count);
    end;
  end
  else begin
    while (i < ASourceBytes) do begin
      c := Byte(ASource[i]);
      Inc(i);
      if (c and $80) <> 0 then begin
        if i >= ASourceBytes then
          Exit;           // incomplete multibyte char
        c := c and $3F;
        if (c and $20) <> 0 then begin
          c := Byte(ASource[i]);
          Inc(i);
          if (c and $C0) <> $80 then
            Exit;         // malformed trail byte or out of range char
          if i >= ASourceBytes then
            Exit;         // incomplete multibyte char
        end;
        c := Byte(ASource[i]);
        Inc(i);
        if (c and $C0) <> $80 then
          Exit;           // malformed trail byte
      end;
      Inc(count);
    end;
  end;
  Result := count;
end;
*)

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
function TFDEncoder.Encode(const AStr: String; ADestEncoding: TFDEncoding = ecDefault): TFDByteString;
{$IFDEF MSWINDOWS}
var
  iLen, iRes: Integer;
  pUTF8: PAnsiChar;
{$ENDIF}
begin
  SetLength(Result, 0);
  if ADestEncoding = ecDefault then
    ADestEncoding := FEncoding;
  if AStr = '' then
    Exit;
{$IFDEF MSWINDOWS}
  case ADestEncoding of
    ecANSI:
      begin
        SetLength(Result, (Length(AStr) + 1) * SizeOf(AnsiChar));
        iRes := WideCharToMultiByte(CP_ACP, 0, PWideChar(AStr),
          Length(AStr), LPSTR(PByte(Result)), Length(Result), nil, nil);
        if iRes = 0 then begin
          iRes := WideCharToMultiByte(CP_ACP, 0, PWideChar(AStr),
            Length(AStr), nil, 0, nil, nil);
          SetLength(Result, (iRes + 1) * SizeOf(AnsiChar));
          WideCharToMultiByte(CP_ACP, 0, PWideChar(AStr),
            Length(AStr), LPSTR(PByte(Result)), Length(Result), nil, nil);
        end;
        SetTrailerBytes(Result, False, SizeOf(AnsiChar));
      end;
    ecUTF8:
      begin
        pUTF8 := Alloc(Length(AStr) * C_FD_MaxUTF8Len + 1);
        iLen := WideCharToMultiByte(CP_UTF8, 0, PWideChar(AStr),
          Length(AStr), pUTF8, Length(AStr) * C_FD_MaxUTF8Len + 1, nil, nil);
        SetBytes(Result, pUTF8, iLen, 1);
        Release(pUTF8);
      end;
    ecUTF16:
      SetBytes(Result, PByte(@AStr[1]), Length(AStr) * SizeOf(WideChar), 2);
  end;
{$ENDIF}
{$IFDEF POSIX}
  Result := Enco(AStr, ADestEncoding);
{$ENDIF}
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
function TFDEncoder.Decode(const AStr: TFDByteString; ASrcEncoding: TFDEncoding = ecDefault): String;
{$IFDEF MSWINDOWS}
var
  iLen: Integer;
  pWC: PWideChar;
{$ENDIF}
begin
  Result := '';
  if ASrcEncoding = ecDefault then
    ASrcEncoding := FEncoding;
  if Length(AStr) = 0 then
    Exit;
{$IFDEF MSWINDOWS}
  case ASrcEncoding of
    ecANSI:
      begin
        SetLength(Result, Length(AStr));
        MultiByteToWideChar(CP_ACP, 0, LPCSTR(PByte(AStr)),
          Length(AStr), PWideChar(Result), Length(Result));
      end;
    ecUTF8:
      begin
        pWC := Alloc((Length(AStr) + 1) * SizeOf(WideChar));
        iLen := MultiByteToWideChar(CP_UTF8, 0, LPCSTR(PByte(AStr)),
          Length(AStr), pWC, Length(AStr));
        SetString(Result, pWC, iLen);
        Release(pWC);
      end;
    ecUTF16:
      SetString(Result, PChar(PByte(AStr)), Length(AStr) div SizeOf(Char));
  end;
{$ENDIF}
{$IFDEF POSIX}
  Result := Deco(AStr, ASrcEncoding);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDEncoder.Encode(const ASrc: Pointer; ASrcLen: Integer; var ADest: Pointer;
  ASrcEncoding: TFDEncoding = ecDefault; ADestEncoding: TFDEncoding = ecDefault): Integer;
var
  iLen: Integer;
  pWC: PWideChar;
  iMaxLen: Integer;
  lRelease: Boolean;
begin
  if ASrcEncoding = ecDefault then
    ASrcEncoding := ecUTF16;
  if ADestEncoding = ecDefault then
    ADestEncoding := FEncoding;
  ASSERT(ASrcEncoding in [ecUTF16, ecANSI]);
  Result := 0;
  if (ASrcLen = 0) or (ASrc = nil) then begin
    if (ASrcLen = 0) and (ASrc <> nil) and (ADest = nil) then
      ADest := FBuffer.Check(0);
    Exit;
  end;
  if ASrcEncoding = ecUTF16 then begin
    if ASrcLen = -1 then
      ASrcLen := StrLen(PWideChar(ASrc));
    case ADestEncoding of
      ecANSI:
        begin
          iMaxLen := ASrcLen * SizeOf(TFDAnsiChar) * 2 + 1;
          if ADest = nil then
            ADest := Alloc(iMaxLen);
          Result := LocaleCharsFromUnicode(CP_ACP, 0, PWideChar(ASrc),
            ASrcLen, MarshaledAString(ADest), iMaxLen, nil, nil);
        end;
      ecUTF8:
        begin
          iMaxLen := ASrcLen * C_FD_MaxUTF8Len + 1;
          if ADest = nil then
            ADest := Alloc(iMaxLen);
          Result := LocaleCharsFromUnicode(CP_UTF8, 0, PWideChar(ASrc),
            ASrcLen, MarshaledAString(ADest), iMaxLen, nil, nil);
        end;
      ecUTF16:
        begin
          Result := ASrcLen;
          if ADest = nil then
            ADest := ASrc
          else
            Move(ASrc^, ADest^, ASrcLen * SizeOf(WideChar));
        end;
    end;
  end
  else begin
    if ASrcLen = -1 then
      ASrcLen := FDAnsiStrLen(PFDAnsiString(ASrc));
    case ADestEncoding of
      ecANSI:
        begin
          Result := ASrcLen;
          if ADest = nil then
            ADest := ASrc
          else
            Move(ASrc^, ADest^, ASrcLen * SizeOf(TFDAnsiChar));
        end;
      ecUTF8:
        begin
          iMaxLen := ASrcLen * C_FD_MaxUTF8Len + 2;
          if ADest = nil then begin
            ADest := Alloc(iMaxLen + (ASrcLen + 1) * SizeOf(WideChar));
            pWC := PWideChar(NativeInt(ADest) + iMaxLen);
            lRelease := False;
          end
          else begin
            pWC := Alloc((ASrcLen + 1) * SizeOf(WideChar));
            lRelease := False;
          end;
          iLen := UnicodeFromLocaleChars(CP_ACP, 0, MarshaledAString(ASrc),
            ASrcLen, pWC, ASrcLen);
          Result := LocaleCharsFromUnicode(CP_UTF8, 0, pWC,
            iLen, MarshaledAString(ADest), iMaxLen, nil, nil);
          if lRelease then
            Release(pWC);
        end;
      ecUTF16:
        begin
          iMaxLen := ASrcLen + 1;
          if ADest = nil then
            ADest := Alloc(iMaxLen * SizeOf(WideChar));
          Result := UnicodeFromLocaleChars(CP_ACP, 0, MarshaledAString(ASrc),
            ASrcLen, PWideChar(ADest), iMaxLen);
        end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDEncoder.Encode(const ASrc: Pointer; ASrcLen: Integer;
  ASrcEncoding: TFDEncoding = ecDefault; ADestEncoding: TFDEncoding = ecDefault): TFDByteString;
var
  iLen: Integer;
  pDest: Pointer;
  iTrailerLen: Integer;
begin
  pDest := nil;
  iLen := Encode(ASrc, ASrcLen, pDest, ASrcEncoding, ADestEncoding);
  if ADestEncoding = ecDefault then
    ADestEncoding := FEncoding;
  case ADestEncoding of
    ecANSI,
    ecUTF8:  iTrailerLen := SizeOf(TFDAnsiChar);
    ecUTF16: iTrailerLen := SizeOf(WideChar);
    else     iTrailerLen := 0;
  end;
  SetBytes(Result, pDest, iLen, iTrailerLen);
end;

{-------------------------------------------------------------------------------}
function TFDEncoder.EncodedLength(const AStr: TFDByteString; ADestEncoding: TFDEncoding = ecDefault): Integer;
begin
  if ADestEncoding = ecDefault then
    ADestEncoding := FEncoding;
  Result := EncoLength(AStr, ADestEncoding);
end;

{-------------------------------------------------------------------------------}
function TFDEncoder.Decode(const ASrc: Pointer; ASrcLen: Integer; var ADest: Pointer;
  ADestEncoding: TFDEncoding = ecDefault; ASrcEncoding: TFDEncoding = ecDefault): Integer;
var
  iLen: Integer;
  pWC: PWideChar;
  iMaxLen: Integer;
  lRelease: Boolean;
begin
  if ADestEncoding = ecDefault then
    ADestEncoding := ecUTF16;
  if ASrcEncoding = ecDefault then
    ASrcEncoding := FEncoding;
  ASSERT(ADestEncoding in [ecUTF16, ecANSI]);
  Result := 0;
  if (ASrcLen = 0) or (ASrc = nil) then begin
    if (ASrcLen = 0) and (ASrc <> nil) and (ADest = nil) then
      ADest := FBuffer.Check(0);
    Exit;
  end;
  if ADestEncoding = ecUTF16 then
    case ASrcEncoding of
      ecANSI:
        begin
          if ASrcLen = -1 then
            ASrcLen := FDAnsiStrLen(PFDAnsiString(ASrc));
          iMaxLen := ASrcLen + 1;
          if ADest = nil then
            ADest := Alloc(iMaxLen * SizeOf(WideChar));
          Result := UnicodeFromLocaleChars(CP_ACP, 0, MarshaledAString(ASrc),
            ASrcLen, PWideChar(ADest), iMaxLen);
        end;
      ecUTF8:
        begin
          if ASrcLen = -1 then
            ASrcLen := FDAnsiStrLen(PFDAnsiString(ASrc));
          iMaxLen := ASrcLen + 1;
          if ADest = nil then
            ADest := Alloc(iMaxLen * SizeOf(WideChar));
          Result := UnicodeFromLocaleChars(CP_UTF8, 0, MarshaledAString(ASrc),
            ASrcLen, PWideChar(ADest), iMaxLen);
        end;
      ecUTF16:
        begin
          if ASrcLen = -1 then
            ASrcLen := StrLen(PWideChar(ASrc));
          Result := ASrcLen;
          if ADest = nil then
            ADest := ASrc
          else
            Move(ASrc^, ADest^, ASrcLen * SizeOf(WideChar));
        end;
    end
  else
    case ASrcEncoding of
      ecANSI:
        begin
          if ASrcLen = -1 then
            ASrcLen := FDAnsiStrLen(PFDAnsiString(ASrc));
          Result := ASrcLen;
          if ADest = nil then
            ADest := ASrc
          else
            Move(ASrc^, ADest^, ASrcLen * SizeOf(TFDAnsiChar));
        end;
      ecUTF8:
        begin
          if ASrcLen = -1 then
            ASrcLen := FDAnsiStrLen(PFDAnsiString(ASrc));
          iMaxLen := ASrcLen * SizeOf(TFDAnsiChar) * 2 + 1;
          if Odd(iMaxLen) then
            Inc(iMaxLen);
          if ADest = nil then begin
            ADest := Alloc(iMaxLen + (ASrcLen + 1) * SizeOf(WideChar));
            pWC := PWideChar(NativeInt(ADest) + iMaxLen);
            lRelease := False;
          end
          else begin
            pWC := Alloc((ASrcLen + 1) * SizeOf(WideChar));
            lRelease := True;
          end;
          iLen := UnicodeFromLocaleChars(CP_UTF8, 0, MarshaledAString(ASrc),
            ASrcLen, pWC, ASrcLen);
          Result := LocaleCharsFromUnicode(CP_ACP, 0, pWC, iLen,
            MarshaledAString(ADest), iMaxLen, nil, nil);
          if lRelease then
            Release(pWC);
        end;
      ecUTF16:
        begin
          if ASrcLen = -1 then
            ASrcLen := StrLen(PWideChar(ASrc));
          iMaxLen := ASrcLen * SizeOf(TFDAnsiChar) * 2 + 1;
          if ADest = nil then
            ADest := Alloc(iMaxLen);
          Result := LocaleCharsFromUnicode(CP_ACP, 0, PWideChar(ASrc),
            ASrcLen, MarshaledAString(ADest), iMaxLen, nil, nil);
        end;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDEncoder.Decode(const ASrc: Pointer; ASrcLen: Integer = -1;
  ASrcEncoding: TFDEncoding = ecDefault): String;
var
  iDestLen: Integer;
  pDest: Pointer;
begin
  if ASrcEncoding = ecDefault then
    ASrcEncoding := FEncoding;
  ASSERT(ASrcEncoding <> ecDefault);
  pDest := nil;
  iDestLen := Decode(ASrc, ASrcLen, pDest, ecDefault, ASrcEncoding);
  SetString(Result, PChar(pDest), iDestLen);
  Release(pDest);
end;

{-------------------------------------------------------------------------------}
function TFDEncoder.GetPreamble: TFDByteString;
const
  C_UTF8: array [0 .. 2] of Byte = ($EF, $BB, $BF);
  C_UTF16: array [0 .. 1] of Byte = ($FF, $FE);
begin
  case FEncoding of
    ecANSI:  SetLength(Result, 0);
    ecUTF8:  SetBytes(Result, @C_UTF8[0], SizeOf(C_UTF8), 0);
    ecUTF16: SetBytes(Result, @C_UTF16[0], SizeOf(C_UTF16), 0);
  end;
end;

{-------------------------------------------------------------------------------}
class function TFDEncoder.Deco(const ASrc: Pointer; ASrcLen: Integer;
  ASrcEncoding: TFDEncoding): String;
var
  sb: TBytes;
begin
  ASSERT(ASrcEncoding <> ecDefault);
  if ASrcLen = -1 then
    if ASrcEncoding in [ecANSI, ecUTF8] then
      ASrcLen := FDAnsiStrLen(PFDAnsiString(ASrc))
    else
      ASrcLen := StrLen(PWideChar(ASrc));
  if ASrcLen = 0 then begin
    Result := '';
    Exit;
  end;
  if ASrcEncoding = ecUTF16 then
    ASrcLen := ASrcLen * SizeOf(WideChar);
  sb := BytesOf(ASrc, ASrcLen);
  case ASrcEncoding of
    ecANSI:  Result := TEncoding.ANSI.GetString(sb);
    ecUTF8:  Result := TEncoding.UTF8.GetString(sb);
    ecUTF16: Result := TEncoding.Unicode.GetString(sb);
  end;
end;

{-------------------------------------------------------------------------------}
class function TFDEncoder.Deco(const ASrc: TFDByteString;
  ASrcEncoding: TFDEncoding): String;
{$IFNDEF NEXTGEN}
var
  sb: TBytes;
{$ENDIF}
begin
  ASSERT(ASrcEncoding <> ecDefault);
  if Length(ASrc) = 0 then begin
    Result := '';
    Exit;
  end;
{$IFDEF NEXTGEN}
  case ASrcEncoding of
    ecANSI:  Result := TEncoding.ANSI.GetString(ASrc);
    ecUTF8:  Result := TEncoding.UTF8.GetString(ASrc);
    ecUTF16: Result := TEncoding.Unicode.GetString(ASrc);
  end;
{$ELSE}
  SetLength(sb, Length(ASrc));
  Move(PByte(ASrc)^, PByte(sb)^, Length(ASrc));
  case ASrcEncoding of
    ecANSI:  Result := TEncoding.ANSI.GetString(sb);
    ecUTF8:  Result := TEncoding.UTF8.GetString(sb);
    ecUTF16: Result := TEncoding.Unicode.GetString(sb);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
class function TFDEncoder.Enco(const AStr: String; ADestEncoding: TFDEncoding): TFDByteString;
{$IFNDEF NEXTGEN}
var
  sb: TBytes;
{$ENDIF}
begin
  ASSERT(ADestEncoding <> ecDefault);
{$IFDEF NEXTGEN}
  case ADestEncoding of
    ecANSI:
      begin
        Result := TEncoding.ANSI.GetBytes(AStr);
        SetTrailerBytes(Result, True, SizeOf(TFDAnsiChar));
      end;
    ecUTF8:
      begin
        Result := TEncoding.UTF8.GetBytes(AStr);
        SetTrailerBytes(Result, True, SizeOf(TFDAnsiChar));
      end;
    ecUTF16:
      begin
        Result := TEncoding.Unicode.GetBytes(AStr);
        SetTrailerBytes(Result, True, SizeOf(WideChar));
      end;
  end;
{$ELSE}
  case ADestEncoding of
    ecANSI:
      begin
        sb := TEncoding.ANSI.GetBytes(AStr);
        SetBytes(Result, PByte(sb), Length(sb), SizeOf(TFDAnsiChar));
      end;
    ecUTF8:
      begin
        sb := TEncoding.UTF8.GetBytes(AStr);
        SetBytes(Result, PByte(sb), Length(sb), SizeOf(TFDAnsiChar));
      end;
    ecUTF16:
      begin
        sb := TEncoding.Unicode.GetBytes(AStr);
        SetBytes(Result, PByte(sb), Length(sb), SizeOf(WideChar));
      end;
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
class function TFDEncoder.EncoLength(const AStr: TFDByteString; ADestEncoding: TFDEncoding): Integer;
var
  iTrailerLen: Integer;
begin
  case ADestEncoding of
    ecANSI,
    ecUTF8:  iTrailerLen := SizeOf(TFDAnsiChar);
    ecUTF16: iTrailerLen := SizeOf(WideChar);
    else     iTrailerLen := 0;
  end;
  Result := Length(AStr);
  if Result > 0 then
    Dec(Result, iTrailerLen);
  if ADestEncoding = ecUTF16 then
    Result := Result and not 1;
end;

{-------------------------------------------------------------------------------}
{ TFDTextFile                                                                   }
{-------------------------------------------------------------------------------}
constructor TFDTextFile.Create(const AFileName: String; ARead, AAppend: Boolean;
  AEncoding: TFDEncoding; AEndOfLine: TFDTextEndOfLine);
var
  oStream: TStream;
begin
  inherited Create;
  if not ARead then begin
    if not FileExists(AFileName) then
      FileClose(FileCreate(AFileName));
    oStream := TBufferedFileStream.Create(AFileName, fmOpenWrite or fmShareDenyWrite);
  end
  else
    oStream := TBufferedFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  Create(oStream, True, ARead, AAppend, AEncoding, AEndOfLine);
end;

{-------------------------------------------------------------------------------}
constructor TFDTextFile.Create(AStream: TStream; AOwned, ARead, AAppend: Boolean;
  AEncoding: TFDEncoding; AEndOfLine: TFDTextEndOfLine);
var
  sb1, sb2: TFDByteString;
  iLen: Integer;
begin
  inherited Create;
  FStream := AStream;
  FStreamOwned := AOwned;
  FBuffer := TFDBuffer.Create;
  FEncoder := TFDEncoder.Create(FBuffer);
  FEncoder.Encoding := AEncoding;
  FEndOfLine := AEndOfLine;
  if ARead then
    repeat
      if AEncoding = ecDefault then
        FEncoder.Encoding := Succ(FEncoder.Encoding);
      sb1 := FEncoder.Preamble;
      iLen := Length(sb1);
      if iLen <> 0 then begin
        SetLength(sb2, iLen);
        FStream.Read(PByte(sb2)^, iLen);
        if FDCompareByteStr(PByte(sb1), PByte(sb2), iLen, iLen) <> 0 then
          FStream.Position := 0
        else if AEncoding = ecDefault then
          Break;
      end;
    until (AEncoding <> ecDefault) or (FEncoder.Encoding = High(TFDEncoding))
  else begin
    if FEncoder.Encoding = ecDefault then
      FEncoder.Encoding := {$IFDEF MSWINDOWS} ecANSI {$ENDIF}
                           {$IFDEF POSIX} ecUTF8 {$ENDIF};
    if AAppend and (FStream.Size > 0) then begin
      FStream.Position := FStream.Size;
      if FStream.Position > 0 then
        WriteLine('');
    end
    else begin
      FStream.Size := 0;
      sb1 := FEncoder.Preamble;
      iLen := Length(sb1);
      if iLen <> 0 then
        FStream.Write(PByte(sb1)^, iLen);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
destructor TFDTextFile.Destroy;
begin
  if FStreamOwned then
    FDFree(FStream);
  FStream := nil;
  FDFreeAndNil(FEncoder);
  FDFreeAndNil(FBuffer);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDTextFile.GetPosition: Int64;
begin
  Result := FStream.Position;
  if FEncoder.Encoding = ecUTF16 then
    Result := Result div SizeOf(WideChar);
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFile.SetPosition(AValue: Int64);
begin
  if FEncoder.Encoding = ecUTF16 then
    AValue := AValue * SizeOf(WideChar);
  FStream.Position := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFile.WriteText(const AText: String);
var
  sb: TFDByteString;
  iLen: Integer;
begin
  if Length(AText) > 0 then begin
    sb := FEncoder.Encode(AText);
    iLen := FEncoder.EncodedLength(sb);
    FStream.Write(PByte(sb)^, iLen);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFile.WriteLine(const AText: String);
begin
  WriteText(AText);
  case EndOfLine of
  elDefault: {$IFDEF MSWINDOWS} WriteText(C_FD_WinEOL) {$ENDIF}
             {$IFDEF POSIX}     WriteText(C_FD_PosixEOL) {$ENDIF};
  elWindows: WriteText(C_FD_WinEOL);
  elPosix:   WriteText(C_FD_PosixEOL);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTextFile.WriteChar(const AChar: Char);
var
  aBuff: array [0 .. 3] of Byte;
  pByte: Pointer;
  iLen: Integer;
begin
  pByte := @aBuff[0];
  iLen := FEncoder.Encode(@AChar, 1, pByte);
  if FEncoder.Encoding = ecUTF16 then
    iLen := iLen * SizeOf(WideChar);
  FStream.Write(aBuff[0], iLen);
end;

{-------------------------------------------------------------------------------}
function TFDTextFile.ReadChars(out AChar: Char; ACount: Integer): Integer;
var
  aBuff: array [0 .. 4095] of Byte;
  pCh: Pointer;
  c: Byte;
  iBytes, iChars: Integer;
begin
  Result := 0;
  case FEncoder.Encoding of
  ecANSI:
    begin
      iChars := FStream.Read(aBuff[0], ACount * SizeOf(TFDAnsiChar)) div SizeOf(TFDAnsiChar);
      pCh := @AChar;
      Result := FEncoder.Decode(@aBuff[0], iChars, pCh);
    end;
  ecUTF8:
    begin
      iBytes := 0;
      iChars := 0;
      while (iBytes < 4095) and (iChars < ACount) do begin
        if FStream.Read(aBuff[iBytes], 1) <> 1 then
          Break;
        c := Byte(aBuff[iBytes]);
        Inc(iBytes);
        if (c and $80) <> 0 then begin
          if FStream.Read(aBuff[iBytes], 1) <> 1 then
            Break;           // incomplete multibyte char
          c := c and $3F;
          if (c and $20) <> 0 then begin
            c := Byte(aBuff[iBytes]);
            Inc(iBytes);
            if (c and $C0) <> $80 then
              Break;         // malformed trail byte or out of range char
            if FStream.Read(aBuff[iBytes], 1) <> 1 then
              Break;         // incomplete multibyte char
          end;
          c := Byte(aBuff[iBytes]);
          Inc(iBytes);
          if (c and $C0) <> $80 then
            Break;           // malformed trail byte
        end;
        Inc(iChars);
      end;
      pCh := @AChar;
      Result := FEncoder.Decode(@aBuff[0], iBytes, pCh);
    end;
  ecDefault,
  ecUTF16:
    begin
      Result := FStream.Read(AChar, ACount * SizeOf(WideChar)) div SizeOf(WideChar);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTextFile.ReadChar(out AChar: Char): Boolean;
begin
  Result := ReadChars(AChar, 1) = 1;
  if not Result then
    AChar := #0;
end;

{-------------------------------------------------------------------------------}
function TFDTextFile.ReadLine: String;
var
  aBuff: array [0 .. 8191] of Char;
  lEOF: Boolean;
  i: Integer;
begin
  i := -1;
  repeat
    Inc(i);
    lEOF := not ReadChar(aBuff[i]);
  until lEOF or (aBuff[i] = #13) or (aBuff[i] = #10) or (i = 8191);
  if lEOF and (aBuff[i] <> #0) then
    Inc(i);
  SetString(Result, aBuff, i);
  if EndOfLine in [elWindows {$IFDEF MSWINDOWS}, elDefault {$ENDIF}] then
    ReadChar(aBuff[0]);
end;

{-------------------------------------------------------------------------------}
function TFDTextFile.ExtractString(AFromPosition, AToPosition: Integer): String;
var
  aBuff: array [0 .. 8191] of Byte;
  sBuff: TFDByteString;
  pBuff: Pointer;
  iRead, iChars: Integer;
  iCurPos: Int64;
  pCh: Pointer;
begin
  iRead := AToPosition - AFromPosition + 1;
  if FEncoder.Encoding = ecUTF16 then begin
    AFromPosition := AFromPosition * SizeOf(WideChar);
    iRead := iRead * SizeOf(WideChar);
  end;
  Result := '';
  if iRead = 0 then
    Exit;
  iCurPos := FStream.Position;
  FStream.Position := AFromPosition;
  if iRead > SizeOf(aBuff) then begin
    SetLength(sBuff, iRead);
    pBuff := PByte(sBuff);
  end
  else
    pBuff := @aBuff[0];
  iRead := FStream.Read(pBuff^, iRead);
  if FEncoder.Encoding = ecUTF16 then
    iRead := iRead div SizeOf(WideChar);
  FStream.Position := iCurPos;
  pCh := nil;
  iChars := FEncoder.Decode(pBuff, iRead, pCh);
  SetString(Result, PChar(pCh), iChars);
end;

{-------------------------------------------------------------------------------}
{ TFDLog                                                                        }
{-------------------------------------------------------------------------------}
procedure TFDLog.Value(const AName, AValue: String);
begin
  Msg(Format('Variable [%s]: [%s]', [AName, AValue]));
end;

{-------------------------------------------------------------------------------}
procedure TFDLog.Msg(const AMsg: String);
begin
  Add(StringOfChar(' ', FLogLevel * 2) + AMsg);
end;

{-------------------------------------------------------------------------------}
procedure TFDLog.Start(const AMsg: String);
begin
  Msg(AMsg + ' ...');
  Inc(FLogLevel);
end;

{-------------------------------------------------------------------------------}
procedure TFDLog.Stop;
begin
  Dec(FLogLevel);
end;

{-------------------------------------------------------------------------------}
{ TFDLibrary                                                                    }
{-------------------------------------------------------------------------------}
constructor TFDLibrary.Create(const ADriverID: String; AOwningObj: TObject);
begin
  inherited Create;
  FDriverID := ADriverID;
  FOwningObj := AOwningObj;
  FFailedProcs := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
procedure TFDLibrary.Load(const ADLLNames: array of String; ARequired: Boolean);
begin
  FFailedProcs.Clear;
  LoadLibrary(ADLLNames, ARequired);
  if FhDLL <> 0 then begin
    GetLibraryInfo;
    LoadEntries;
  end;
  if FFailedProcs.Count > 0 then
    FDException(FOwningObj, [S_FD_LPhys, FDriverID], er_FD_AccCantGetLibraryEntry,
      [Trim(FFailedProcs.Text)]);
end;

{-------------------------------------------------------------------------------}
destructor TFDLibrary.Destroy;
begin
  Unload;
  FDFreeAndNil(FFailedProcs);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDLibrary.LoadLibrary(const ADLLNames: array of String; ARequired: Boolean);
var
  sLib, sLibs, sErr, sMsg: String;
  i: Integer;
{$IFDEF MSWINDOWS}
  sPath, sCurrDir: String;
{$ENDIF}
begin
  FhDLL := 0;
  FDLLName := '';
  sMsg := '';

{$IFDEF MSWINDOWS}
  SetLength(sCurrDir, MAX_PATH);
  SetLength(sCurrDir, DWORD(GetDllDirectory(MAX_PATH, PChar(sCurrDir))));
  for i := Low(ADLLNames) to High(ADLLNames) do
    if ADLLNames[i] <> '' then begin
      sPath := ExtractFilePath(ADLLNames[i]);
      // If a full library path is specified, then force Windows to load the DLL's
      // at first from this folder, then from System32 or how else. This allows
      // to avoid the chances for getting a DLL version conflict.
      if sPath <> '' then
        SetDllDirectory(PChar(sPath));
      try
        FhDLL := SafeLoadLibrary(ADLLNames[i]);
        sMsg := FDLastSystemErrorMsg;
      finally
        if sPath <> '' then
          if sCurrDir = '' then
            SetDllDirectory(nil)
          else
            SetDllDirectory(PChar(sCurrDir));
      end;
      if FhDLL <> 0 then
        Break;
    end;
{$ENDIF}

{$IFDEF POSIX}
  for i := Low(ADLLNames) to High(ADLLNames) do
    if ADLLNames[i] <> '' then begin
      FhDll := SafeLoadLibrary(ADLLNames[i]);
      if FhDLL <> 0 then begin
        FDLLName := ADLLNames[i];
        Break;
      end;
    end;
{$ENDIF}

  if (FhDLL = 0) and ARequired then begin
    sLibs := '';
    sErr := '';
    for i := Low(ADLLNames) to High(ADLLNames) do begin
      if Low(ADLLNames) <> High(ADLLNames) then
        if i = High(ADLLNames) then
          sLibs := sLibs + ' or '
        else if i > Low(ADLLNames) then
          sLibs := sLibs + ', ';
      sLibs := sLibs + ADLLNames[i];
      if FDGetLibMachineType(ADLLNames[i]) = {$IFDEF FireDAC_32} mt64Bit {$ELSE} mt32Bit {$ENDIF} then begin
        if Low(ADLLNames) = High(ADLLNames) then
          sLib := 'Library'
        else
          sLib := ADLLNames[i];
        sErr := sErr + Format('%s has unsupported architecture [%s]. Required [%s].', [sLib,
          {$IFDEF FireDAC_32} 'x64' {$ELSE} 'x86' {$ENDIF},
          {$IFDEF FireDAC_32} 'x86' {$ELSE} 'x64' {$ENDIF}]) + C_FD_EOL;
      end;
    end;
    sErr := sErr + sMsg;
    if (sErr <> '') and not FDInSet(sErr[Length(sErr)], [#13, #10, '.']) then
      sErr := sErr + C_FD_EOL;
    FDException(OwningObj, [S_FD_LPhys, FDriverID], er_FD_AccCantLoadLibrary,
      [sLibs, sErr])
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDLibrary.Unload;
begin
  if FhDLL <> 0 then begin
    FreeLibrary(FhDLL);
    FhDLL := 0;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDLibrary.GetLibraryInfo;
{$IFDEF POSIX}
var
  s: String;
{$ENDIF}
begin
  FProduct := '';
  FVersionStr := '';
  FVersionName := '';
  FCopyright := '';
  FInfo := '';
  FVersion := 0;
  if FhDLL = 0 then
    Exit;
{$IFDEF MSWINDOWS}
  SetLength(FDLLName, 255);
  SetLength(FDLLName, GetModuleFileName(FhDLL, PChar(FDLLName), 255));
  FDGetVersionInfo(FDLLName, FProduct, FVersionStr, FVersionName, FCopyright, FInfo);
  if FVersionStr <> '' then
    FVersion := FDVerStr2Int(FVersionStr)
  else
    FVersion := 0;
  if FVersion <= 100000000 then
    if FVersionName <> '' then
      FVersion := FDVerStr2Int(FVersionName)
    else
      FVersion := 0;
{$ENDIF}
{$IFDEF POSIX}
  SetLength(s, 255);
  SetLength(s, GetModuleFileName(FhDLL, PChar(s), 255) - 1);
  if s <> '' then
    FDLLName := s;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDLibrary.GetProc(const AProcName: String; ARequired: Boolean = True): Pointer;
begin
  if FhDLL <> 0 then begin
    Result := GetProcAddress(FhDLL, PChar(AProcName));
    if (Result = nil) and ARequired then
      FFailedProcs.Add(AProcName);
  end
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
{ TFDConfigFile                                                                 }
{-------------------------------------------------------------------------------}
constructor TFDConfigFile.Create(AReadOnly: Boolean);
{$IFDEF MSWINDOWS}
var
  iAccess: LongWord;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if AReadOnly then
    iAccess := KEY_READ
  else
    iAccess := KEY_WRITE;
  inherited Create('', iAccess);
  RegIniFile.OpenKey(S_FD_CfgKeyName, not AReadOnly);
{$ENDIF}
{$IFDEF POSIX}
  inherited Create(FDGetAppDocPath + S_FD_CfgFile);
  FReadOnly := AReadOnly;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
{$IFNDEF MSWINDOWS}
destructor TFDConfigFile.Destroy;
begin
  if not FReadOnly then
    try
      UpdateFile;
    except
      // none
    end;
  inherited Destroy;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ Routines                                                                      }
{-------------------------------------------------------------------------------}
function FDStrLike(const AStr, AMask: String; ANoCase: Boolean = False;
  AManyCharsMask: Char = '%'; AOneCharMask: Char = '_'; AEscapeChar: Char = '\'): Boolean;

  function InternalScan(pStr, pMask: PChar): Boolean;
  begin
    Result := True;
    while ((pStr^ = pMask^) and (pMask^ <> AManyCharsMask) or
        (pMask^ = AOneCharMask) or (pMask^ = AEscapeChar)) and
       (pStr^ <> #0) and (pMask^ <> #0) do begin
      if pMask^ = AEscapeChar then begin
        Inc(pMask);
        if pStr^ <> pMask^ then
          Break;
      end;
      Inc(pMask);
      Inc(pStr);
    end;
    if pMask^ = AManyCharsMask then begin
      while (pMask^ = AManyCharsMask) or (pMask^ = AOneCharMask) do begin
        if pMask^ = AOneCharMask then
          if pStr^ = #0 then begin
            Result := False;
            Exit;
          end
          else
            Inc(pStr);
        Inc(pMask);
      end;
      if pMask^ <> #0 then begin
        while (pStr^ <> #0) and ((pMask^ <> pStr^) or not InternalScan(pStr, pMask)) do
          Inc(pStr);
        Result := pStr^ <> #0;
      end;
    end
    else
      Result := (pMask^ = #0) and (pStr^ = #0);
  end;

begin
  if AMask = AManyCharsMask then
    Result := True
  else if (AMask = '') or (AStr = '') then
    Result := False
  else begin
    if ANoCase then
      Result := InternalScan(PChar(AnsiUpperCase(AStr)), PChar(AnsiUpperCase(AMask)))
    else
      Result := InternalScan(PChar(AStr), PChar(AMask));
  end;
end;

{-------------------------------------------------------------------------------}
function FDStrRPos(Str1, Str2: PChar): PChar;
var
  p1, p2, pBSub, pESub, pBS, pES: PChar;
begin
  Result := nil;
  if (Str1 = nil) or (Str2 = nil) then
    Exit;
  pBSub := Str2;
  pESub := Str2 + StrLen(Str2) - 1;
  pBS := Str1 + StrLen(Str2) - 1;
  pES := Str1 + StrLen(Str1) - 1;
  while pES >= pBS do begin
    if pES^ = pESub^ then begin
      p1 := pES;
      p2 := pESub;
      while (p2 >= pBSub) and (p1^ = p2^) do begin
        Dec(p1);
        Dec(p2);
      end;
      if p2 < pBSub then begin
        Result := p1 + 1;
        Exit;
      end;
    end;
    Dec(pES);
  end;
end;

{-------------------------------------------------------------------------------}
function FDPadR(const AStr: String; ALength: Integer): String;
begin
  if Length(AStr) > ALength then
    Result := Copy(AStr, 1, ALength)
  else
    Result := AStr + StringOfChar(' ', ALength - Length(AStr));
end;

{-------------------------------------------------------------------------------}
function FDPadL(const AStr: String; ALength: Integer): String;
begin
  if Length(AStr) > ALength then
    Result := Copy(AStr, 1, ALength)
  else
    Result := StringOfChar(' ', ALength - Length(AStr)) + AStr;
end;

{-------------------------------------------------------------------------------}
procedure FDBin2HexBS(APtr: Pointer; ALen: Integer; ADest: PByte);
{$IFDEF NEXTGEN}
var
  aData, aBuff: TBytes;
{$ENDIF}
begin
  if not ((APtr = nil) or (ALen = 0)) then begin
{$IFNDEF NEXTGEN}
    BinToHex(PAnsiChar(APtr), PAnsiChar(ADest), ALen);
{$ELSE}
    SetLength(aData, ALen);
    Move(APtr^, aData[0], ALen);
    SetLength(aBuff, ALen * 2);
    BinToHex(aData, 0, aBuff, 0, ALen);
    Move(PByte(aBuff)^, ADest^, Length(aBuff));
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
function FDBin2Hex(APtr: Pointer; ALen: Integer): String;
{$IFDEF NEXTGEN}
var
  aData, aBuff: TBytes;
{$ENDIF}
begin
  if (APtr = nil) or (ALen = 0) then
    Result := ''
  else begin
{$IFNDEF NEXTGEN}
    SetLength(Result, ALen * 2);
    BinToHex(PAnsiChar(APtr), PChar(Result), ALen);
{$ELSE}
    SetLength(aData, ALen);
    Move(APtr^, aData[0], ALen);
    SetLength(aBuff, ALen * 2);
    BinToHex(aData, 0, aBuff, 0, ALen);
    Result := StringOf(aBuff);
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
function FDHex2Bin(AStr: String): TFDByteString;
{$IFDEF NEXTGEN}
var
  aText: TBytes;
{$ENDIF}
begin
  if AStr = '' then
    SetLength(Result, 0)
  else begin
    SetLength(Result, Length(AStr) div 2);
{$IFNDEF NEXTGEN}
    HexToBin(PChar(AStr), PByte(Result), Length(Result));
{$ELSE}
    SetLength(aText, Length(AStr));
    Move(PChar(AStr)^, aText[0], Length(AStr));
    HexToBin(aText, 0, Result, 0, Length(Result));
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
function FDAnsiStrLen(AStr: PFDAnsiString): Integer;
var
  pStart: PFDAnsiString;
begin
  if AStr = nil then
    Result := 0
  else begin
    pStart := AStr;
    while Byte(AStr^) <> 0 do
      Inc(AStr);
    Result := AStr - pStart;
  end;
end;

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
function FDInSet(AChar: Char; ASet: TFDCharSet): Boolean;
begin
  if Ord(AChar) <= 255 then
    Result := AChar in ASet
  else
    Result := False;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
function FDValToStr(const AValue: Variant; AQuotes: Boolean): String;
begin
  case VarType(AValue) of
    varEmpty:    Result := '<unassigned>';
    varNull:     Result := '<null>';
    varByte:     Result := '$' + IntToHex(Cardinal(AValue), 2);
    varWord:     Result := '$' + IntToHex(Cardinal(AValue), 4);
    varLongWord: Result := '$' + IntToHex(Int64(AValue), 8);
    varUInt64:   Result := '$' + IntToHex(UInt64(AValue), 16);
    varUnknown:  Result := '<object>';
    varUString,
    varOleStr,
    varString:
      if AQuotes then
        Result := '"' + AValue + '"'
      else
        Result := AValue;
    else
      try
        Result := AValue;
      except
        Result := '<unknown>';
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function FDIdentToStr(const AValue: Variant; var AQuotes: Boolean): String;
begin
  AQuotes := True;
  case VarType(AValue) of
    varUString,
    varString,
    varOleStr:
      begin
        Result := AValue;
        if Result[1] = '@' then begin
          AQuotes := False;
          Result := Copy(Result, 2, Length(Result));
        end;
      end
    else
      Result := FDValToStr(AValue, True);
  end;
end;

{-------------------------------------------------------------------------------}
function FDVarToBool(const AValue: Variant): Boolean;
begin
  if VarIsNull(AValue) or VarIsEmpty(AValue) then
    Result := False
  else
    Result := AValue;
end;

{-------------------------------------------------------------------------------}
function FDSameVariants(const A, B: Variant): Boolean;
var
  ia, ib: Integer;
  pa, pb: Pointer;
  la: Integer;
begin
  ia := VarType(A);
  ib := VarType(B);
  if ia <> ib then
    Result := False
  else if ia = varEmpty then
    Result := ib = varEmpty
  else if ia = varNull then
    Result := ib = varNull
  else if ib in [varEmpty, varNull] then
    Result := False
  else if ia = varArray or varByte then begin
    la := VarArrayHighBound(A, 1);
    if la = VarArrayHighBound(B, 1) then begin
      pa := VarArrayLock(A);
      pb := VarArrayLock(B);
      try
        Result := CompareMem(pa, pb, la);
      finally
        VarArrayUnlock(A);
        VarArrayUnlock(B);
      end;
    end
    else
      Result := False;
  end
  else
    try
      Result := A = B;
    except
      Result := False;
    end;
end;

{-------------------------------------------------------------------------------}
function FDExtractFieldName(const AStr: String; var APos: Integer): String; overload;
begin
  Result := FDExtractFieldName(AStr, APos, GParseFmtSettings);
end;

{-------------------------------------------------------------------------------}
function FDExtractFieldName(const AStr: String; var APos: Integer; const AFmt: TFDParseFmtSettings): String; overload;
var
  i, iInBrackets: Integer;
  lSqueeze, lInQuotes: Boolean;
  sQuotes: String;
begin
  i := APos;
  lSqueeze := False;
  lInQuotes := False;
  iInBrackets := 0;
  while i <= Length(AStr) do begin
    if (AStr[i] = AFmt.FQuote) and (iInBrackets = 0) then begin
      if (i < Length(AStr)) and (AStr[i + 1] = AFmt.FQuote) then begin
        lSqueeze := True;
        Inc(i);
      end
      else
        lInQuotes := not lInQuotes;
    end
    else if (AStr[i] = AFmt.FQuote1) and not lInQuotes then
      Inc(iInBrackets)
    else if (AStr[i] = AFmt.FQuote2) and not lInQuotes then
      Dec(iInBrackets)
    else if (AStr[i] = AFmt.FDelimiter) and not lInQuotes and (iInBrackets = 0) then
      Break;
    Inc(i);
  end;
  Result := Trim(Copy(AStr, APos, i - APos));
  if (i <= Length(AStr)) and (AStr[i] = AFmt.FDelimiter) then
    Inc(i);
  APos := i;
  if lSqueeze then begin
    sQuotes := AFmt.FQuote + AFmt.FQuote;
    i := 0;
    while True do begin
      i := Pos(sQuotes, Result, i + 1);
      if i = 0 then
        Break;
      Delete(Result, i, 1);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function FDMergeFieldNames(const AFieldNames1, AFieldNames2: String;
  AIgnoreModifiers: Boolean = False): String;
var
  i: Integer;
  sField: String;
  sUCResult: String;
begin
  Result := AFieldNames1;
  sUCResult := ';' + UpperCase(Result) + ';';
  i := 1;
  while i <= Length(AFieldNames2) do begin
    sField := FDExtractFieldName(AFieldNames2, i);
    if sField <> '' then
      if not ((Pos(';' + UpperCase(sField) + ';', sUCResult) <> 0) or
              AIgnoreModifiers and (Pos(';' + UpperCase(sField) + ':', sUCResult) <> 0)) then begin
        if (Length(Result) > 0) and (Result[Length(Result)] <> ';') then
          Result := Result + ';';
        Result := Result + sField;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function FDCountFieldNames(const AStr: String): Integer;
var
  pCh: PChar;
begin
  if Length(AStr) = 0 then
    Result := 0
  else begin
    Result := 1;
    pCh := PChar(AStr);
    while pCh^ <> #0 do begin
      if pCh^ = ';' then
        Inc(Result);
      Inc(pCh);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function FDFieldInFieldNames(const AStr, AName: String) : Boolean;
var
  i, iNameLen, iLen: Integer;
  sUCName, sUCStr: String;
begin
  sUCName := UpperCase(AName);
  iNameLen := Length(sUCName);
  sUCStr := UpperCase(AStr);
  iLen := Length(sUCStr);
  i := 0;
  repeat
    i := Pos(sUCName, sUCStr, i + 1);
    Result := (i <> 0) and
      ((i = 1) or (sUCStr[i - 1] = ';')) and
      ((i + iNameLen > iLen) or (sUCStr[i + iNameLen] = ';'));
  until Result or (i = 0);
end;

{-------------------------------------------------------------------------------}
procedure FDFieldNamesToArray(const AFieldNames: String;
  var AFieldNamesArray: TFDStringArray);
var
  sField: String;
  i: Integer;
  iLen: Integer;
begin
  SetLength(AFieldNamesArray, 0);
  i := 1;
  while i <= Length(AFieldNames) do begin
    sField := FDExtractFieldName(AFieldNames, i);
    if sField <> '' then begin
      // collect key fields
      iLen := Length(AFieldNamesArray);
      SetLength(AFieldNamesArray, iLen + 1);
      AFieldNamesArray[iLen] := sField;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function FDUnquote(const AString: String; AQuoteChar: Char = '"'): String;
begin
  Result := AString;
  if (Result <> '') and (Result[1] = AQuoteChar) and (Result[Length(Result)] = AQuoteChar) then
    Result := Copy(Result, 2, Length(Result) - 2);
end;

{-------------------------------------------------------------------------------}
function FDCompareAnsiStr(const AStr1, AStr2: PFDAnsiString; ALen1, ALen2: Integer;
  ALocale: TFDLocalID; ANoCase, APartial, ANoSymbols: Boolean): Integer;
type
  TBuff = array [0 .. 4096] of TFDAnsiChar;
var
  iLen: Integer;
{$IFDEF MSWINDOWS}
  iFlag: Integer;
{$ENDIF}
{$IFDEF POSIX}
  aBuff1, aBuff2: TBuff;
  pBuff1, pBuff2: PFDAnsiString;

  function DupStr(const AStr: PFDAnsiString; var ABuff: TBuff; ALen: Integer): PFDAnsiString;
  begin
    if ALen < SizeOf(ABuff) then
      Result := @ABuff[0]
    else
      GetMem(Result, ALen + 1);
    Move(AStr^, Result^, ALen);
    if (Result + ALen)^ <> TFDAnsiChar(#0) then
      (Result + ALen)^ := TFDAnsiChar(#0);
  end;
{$ENDIF}
begin
  iLen := ALen1;
  if iLen > ALen2 then
    iLen := ALen2;
{$IFDEF FireDAC_NOLOCALE_DATA}
  ALocale := 0;
{$ENDIF}
{$IFDEF MSWINDOWS}
  if ALocale = 0 then
    if ANoCase then
      Result := {$IFNDEF NEXTGEN} System.AnsiStrings. {$ENDIF}
        StrLIComp(PFDAnsiString(AStr1), PFDAnsiString(AStr2), iLen)
    else
      Result := {$IFNDEF NEXTGEN} System.AnsiStrings. {$ENDIF}
        StrLComp(PFDAnsiString(AStr1), PFDAnsiString(AStr2), iLen)
  else begin
    if ANoCase then
      iFlag := NORM_IGNORECASE or SORT_STRINGSORT
    else
      iFlag := SORT_STRINGSORT;
    if ANoSymbols then
      iFlag := iFlag or NORM_IGNORESYMBOLS or NORM_IGNORENONSPACE;
    SetLastError(0);
    if APartial then
      Result := CompareStringA(ALocale, iFlag, PFDAnsiString(AStr1), iLen,
        PFDAnsiString(AStr2), ALen2) - CSTR_EQUAL
    else
      Result := CompareStringA(ALocale, iFlag, PFDAnsiString(AStr1), ALen1,
        PFDAnsiString(AStr2), ALen2) - CSTR_EQUAL;
    if GetLastError <> 0 then
      RaiseLastOSError;
  end;
{$ENDIF}
{$IFDEF POSIX}
  if ANoCase then begin
    pBuff1 := DupStr(AStr1, aBuff1, iLen);
    pBuff2 := DupStr(AStr2, aBuff2, iLen);
    try
      Result := strcasecmp(MarshaledAString(pBuff1), MarshaledAString(pBuff2));
    finally
      if pBuff1 <> @aBuff1[0] then
        FreeMem(pBuff1);
      if pBuff2 <> @aBuff2[0] then
        FreeMem(pBuff2);
    end;
  end
  else
    Result := strncmp(MarshaledAString(AStr1), MarshaledAString(AStr2), iLen);
{$ENDIF}
  if Result > 0 then
    Result := 1
  else if Result < 0 then
    Result := -1
  else
    if ALen1 < ALen2 then
      Result := -1
    else if (ALen1 > ALen2) and not APartial then
      Result := 1;
end;

{-------------------------------------------------------------------------------}
function FDCompareWideStr(const AStr1, AStr2: PWideChar; ALen1, ALen2: Integer;
  ALocale: TFDLocalID; ANoCase, APartial, ANoSymbols: Boolean): Integer;
var
  iLen: Integer;
{$IFDEF MSWINDOWS}
  iFlag: Integer;
{$ENDIF}
{$IFDEF POSIX}
  ws1, ws2: UnicodeString;
{$ENDIF}
begin
  iLen := ALen1;
  if iLen > ALen2 then
    iLen := ALen2;
{$IFDEF FireDAC_NOLOCALE_DATA}
  ALocale := 0;
{$ENDIF}
{$IFDEF MSWINDOWS}
  if ALocale = 0 then
    if ANoCase then
      Result := StrLIComp(AStr1, AStr2, iLen)
    else
      Result := StrLComp(AStr1, AStr2, iLen)
  else
  begin
    if ANoCase then
      iFlag := NORM_IGNORECASE or SORT_STRINGSORT
    else
      iFlag := SORT_STRINGSORT;
    if ANoSymbols then
      iFlag := iFlag or NORM_IGNORESYMBOLS or NORM_IGNORENONSPACE;
    SetLastError(0);
    if APartial then
      Result := CompareStringW(ALocale, iFlag, AStr1, iLen, AStr2, ALen2) - CSTR_EQUAL
    else
      Result := CompareStringW(ALocale, iFlag, AStr1, ALen1, AStr2, ALen2) - CSTR_EQUAL;
    if GetLastError <> 0 then
      RaiseLastOSError;
  end;
{$ENDIF}
{$IFDEF POSIX}
  // This is not optimal, but platform neutral.
  // Optimal will be to use wcsncoll and wcsnicoll.
  // See SVN # 874
  if APartial then begin
    SetString(ws1, AStr1, iLen);
    SetString(ws2, AStr2, iLen);
  end
  else begin
    SetString(ws1, AStr1, ALen1);
    SetString(ws2, AStr2, ALen2);
  end;
  {$IFDEF NEXTGEN}
  if ANoCase then
    Result := AnsiCompareText(ws1, ws2)
  else
    Result := AnsiCompareStr(ws1, ws2);
  {$ELSE}
  if ANoCase then
    Result := WideCompareText(ws1, ws2)
  else
    Result := WideCompareStr(ws1, ws2);
  {$ENDIF}
{$ENDIF}
  if Result > 0 then
    Result := 1
  else if Result < 0 then
    Result := -1
  else
    if ALen1 < ALen2 then
      Result := -1
    else if (ALen1 > ALen2) and not APartial then
      Result := 1;
end;

{-------------------------------------------------------------------------------}
function FDCompareByteStr(const AStr1, AStr2: PByte; ALen1, ALen2: Integer): Integer;
var
  iLen, i: Integer;
begin
  iLen := ALen1;
  if iLen > ALen2 then
    iLen := ALen2;
  Result := 0;
  for i := 0 to iLen - 1 do
    if PByte(PByte(AStr1) + i)^ > PByte(PByte(AStr2) + i)^ then begin
      Result := 1;
      Break;
    end
    else if PByte(PByte(AStr1) + i)^ < PByte(PByte(AStr2) + i)^ then begin
      Result := -1;
      Break;
    end;
  if Result = 0 then
    if ALen1 > ALen2 then
      Result := 1
    else if ALen1 < ALen2 then
      Result := -1;
end;

{-------------------------------------------------------------------------------}
function FDStrReplace(const AStr: String; ASrch, ARepl: Char): String;
var
  i: Integer;
begin
  Result := AStr;
  for i := 1 to Length(Result) do
    if Result[i] = ASrch then
      Result[i] := ARepl;
end;

{-------------------------------------------------------------------------------}
function FDLastSystemErrorMsg: String;
begin
{$IFDEF MSWINDOWS}
  Result := SysErrorMessage(GetLastError);
{$ENDIF}
{$IFDEF POSIX}
  Result := TFDEncoder.Deco(dlerror, -1, ecUTF8);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function FDSQLTimeStamp2Time(const AValue: TSQLTimeStamp): Integer;
begin
  Result := Integer(Cardinal(((AValue.Hour * 60 + AValue.Minute) * 60 +
    AValue.Second) * 1000) + AValue.Fractions);
end;

{-------------------------------------------------------------------------------}
function FDTime2SQLTimeStamp(const AValue: Integer): TSQLTimeStamp;
begin
  Result := DateTimeToSQLTimeStamp(FDTime2DateTime(AValue));
end;

{-------------------------------------------------------------------------------}
function FDSQLTimeStamp2Date(const AValue: TSQLTimeStamp): Integer;
begin
  Result := Integer(Trunc(SQLTimeStampToDateTime(AValue) - C_Date_1_1_1 + 1.0));
end;

{-------------------------------------------------------------------------------}
function FDDate2SQLTimeStamp(const AValue: Integer): TSQLTimeStamp;
begin
  Result := DateTimeToSQLTimeStamp(FDDate2DateTime(AValue));
end;

{-------------------------------------------------------------------------------}
function FDTime2DateTime(const AValue: Integer): TDateTime;
begin
  Result := AValue / (24.0 * 60.0 * 60.0 * 1000.0);
end;

{-------------------------------------------------------------------------------}
function FDDateTime2Time(const AValue: TDateTime): Integer;
var
  d: Double;
begin
  d := AValue * (24.0 * 60.0 * 60.0 * 1000.0) + 0.1;
  Result := Integer(Trunc(d));
end;

{-------------------------------------------------------------------------------}
function FDDate2DateTime(const AValue: Integer): TDateTime;
begin
  Result := AValue - 1 + C_Date_1_1_1;
end;

{-------------------------------------------------------------------------------}
function FDDateTime2Date(const AValue: TDateTime): Integer;
begin
  Result := Integer(Trunc(AValue - C_Date_1_1_1 + 1));
end;

{-------------------------------------------------------------------------------}
function FDMSecs2DateTime(const AValue: Double): TDateTime;
begin
  Result := TimeStampToDateTime(MSecsToTimeStamp(AValue));
end;

{-------------------------------------------------------------------------------}
function FDDateTime2MSecs(const AValue: TDateTime): Comp;
begin
  Result := TimeStampToMSecs(DateTimeToTimeStamp(AValue));
end;

{-------------------------------------------------------------------------------}
function FDGetSystemCfgPath: String;
begin
{$IFDEF MSWINDOWS}
  SetLength(Result, MAX_PATH);
  SetLength(Result, GetWindowsDirectory(PChar(Result), MAX_PATH));
  Result := FDNormPath(Result);
{$ENDIF}
{$IFDEF POSIX}
  {$IFDEF ANDROID}
  Result := FDGetAppCfgPath;
  {$ELSE}
    {$IFDEF IOS}
  Result := FDGetAppCfgPath;
    {$ELSE}
  Result := '/etc/';
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function FDGetAppPath: String;
begin
{$IF DEFINED(MSWINDOWS) or DEFINED(LINUX) or DEFINED(MACOS) and not DEFINED(IOS)}
  Result := FDNormPath(ExtractFileDir(ParamStr(0)));
{$ELSE}
  Result := FDNormPath(TPath.GetHomePath);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function FDGetAppCfgPath: String;
begin
{$IFDEF ANDROID}
  Result := FDGetAppDocPath;
{$ELSE}
  {$IFDEF IOS}
  Result := FDGetAppDocPath;
  {$ELSE}
  Result := FDGetAppPath;
  {$ENDIF}
{$ENDIF}
end;

{ ------------------------------------------------------------------------------}
function FDGetAppDocPath: String;
begin
  Result := FDNormPath(TPath.GetDocumentsPath);
end;

{-------------------------------------------------------------------------------}
function FDGetTempPath: String;
begin
  Result := FDNormPath(TPath.GetTempPath);
end;

{-------------------------------------------------------------------------------}
function FDGetBestPath(const ASpecifiedFileName, AGlobalFileName, ADefFileName: String): String;
var
  sSpec, sGlob, sDef: String;
begin
  sSpec := FDExpandStr(ASpecifiedFileName);
  sGlob := FDExpandStr(AGlobalFileName);
  sDef := FDExpandStr(ADefFileName);
  if sSpec = '' then begin
    Result := FDGetAppCfgPath + sDef;
    if not FileExists(Result) then
      Result := sGlob;
  end
  else begin
    if ExtractFilePath(sSpec) = '' then
      Result := FDGetAppCfgPath + sSpec
    else
      Result := sSpec;
  end;
end;

{-------------------------------------------------------------------------------}
function FDNormPath(const APath: String): String;
begin
  Result := APath;
  if (Result <> '') and (Result[Length(Result)] <> C_FD_PathDelim) then
    Result := Result + C_FD_PathDelim;
end;

{ --------------------------------------------------------------------------- }
function FDExtractFileNameNoPath(const AFileName: String): String;
begin
  Result := ChangeFileExt(ExtractFileName(AFileName), '');
end;

{ --------------------------------------------------------------------------- }
{$IFDEF MSWINDOWS}
function FDBrowseForFolder(AHandle: THandle; ATitle: string): string;
var
  browseinfo: TBrowseInfo;
  itemidlist: PItemIDList;
  image: Integer;
  displayname: PChar;
  itaskalloc: IMalloc;
  s: PChar;
begin
  Result := '';
  image := 0;
  displayname := StrAlloc(MAX_PATH);
  try
    browseinfo.hwndOwner := AHandle;
    browseinfo.pidlRoot := nil;
    browseinfo.pszDisplayName := displayname;
    browseinfo.lpszTitle := PChar(ATitle);
    browseinfo.ulFlags := BIF_RETURNONLYFSDIRS;
    browseinfo.lpfn := nil;
    browseinfo.lParam := 0;
    browseinfo.iImage := image;
    itemidList := SHBrowseForFolder(browseinfo);
    if Assigned(itemidlist) then
    try
      s := StrAlloc(MAX_PATH);
      try
        if SHGetPathFromIDList(itemidlist, s) then
          Result := s;
      finally
        StrDispose(s);
      end;
    finally
      OleCheck(SHGetMalloc(itaskalloc));
      try
        assert(itaskalloc.DidAlloc(itemidlist) = 1, 'wrong allocator');
        itaskalloc.Free(itemidlist);
      finally
        itaskalloc := nil;
      end;
    end;
  finally
    StrDispose(displayname);
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function FDVerStr2Int(const AVersion: String): TFDVersion;
var
  i, iItemNo, iDot, iFirstNonDig, iVal: Integer;
  s, sItem: String;
begin
  i := 1;
  while i <= Length(AVersion) do
    if (AVersion[i] >= '0') and (AVersion[i] <= '9') then
      Break
    else
      Inc(i);
  s := Copy(AVersion, i, Length(AVersion));
  Result := 0;
  for iItemNo := 1 to 5 do begin
    if s = '' then
      Result := Result * 100
    else begin
      iDot := Pos('.', s);
      if iDot = 0 then
        iDot := Length(s) + 1;
      sItem := Trim(Copy(s, 1, iDot - 1));
      iFirstNonDig := 1;
      while (iFirstNonDig <= Length(sItem)) and
            (sItem[iFirstNonDig] >= '0') and (sItem[iFirstNonDig] <= '9') do
        Inc(iFirstNonDig);
      iVal := StrToIntDef(Copy(sItem, 1, iFirstNonDig - 1), 0);
      if (iVal > 99) and (iItemNo > 1) then
        iVal := 99;
      Result := Result * 100 + iVal;
      s := Copy(s, iDot + 1, Length(s));
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function FDVerInt2Str(AVersion: TFDVersion): String;
var
  iVal: Integer;
begin
  Result := '';
  while AVersion > 0 do begin
    if Result <> '' then
      Result := '.' + Result;
    iVal := AVersion mod 100;
    AVersion := AVersion div 100;
    if iVal = 99 then
      iVal := 0;
    Result := IntToStr(iVal) + Result;
  end;
end;

{-------------------------------------------------------------------------------}
function FDReadRegValue(const AName: String): String;
var
  oCfg: TFDConfigFile;
begin
  oCfg := TFDConfigFile.Create(True);
  try
    Result := oCfg.ReadString(S_FD_Main, AName, '');
  finally
    FDFree(oCfg);
  end;
end;

{-------------------------------------------------------------------------------}
procedure FDWriteRegValue(const AName, AValue: String);
var
  oCfg: TFDConfigFile;
begin
  oCfg := TFDConfigFile.Create(False);
  try
    oCfg.WriteString(S_FD_Main, AName, AValue);
  finally
    FDFree(oCfg);
  end;
end;

{-------------------------------------------------------------------------------}
var
  FExpandStrCache: TFDStringList = nil;

function FDExpandStr(const AStr: String; AVars: TStrings = nil): String;

  function TrimSlash(const AStr: String): String;
  begin
    Result := AStr;
    if (Result <> '') and (Result[Length(Result)] = C_FD_PathDelim) then
      Result := Copy(Result, 1, Length(Result) - 1);
  end;

var
  i1, i2, iRes, iMax, iVal: Integer;
  sName, sVal: String;
  lNext: Boolean;
  rSR: TSearchRec;
{$IFDEF POSIX}
  i: Integer;
{$ENDIF}
begin
  Result := AStr;
  i1 := 1;
  lNext := False;
  while True do begin
    i1 := Pos('$(', Result, i1);
    if i1 = 0 then
      Break;
    i2 := Pos(')', Result, i1 + 2);
    if i2 = 0 then
      Break;
    sName := UpperCase(Copy(Result, i1 + 2, i2 - i1 - 2));
    FLock.Enter;
    if (AVars <> nil) and (AVars.IndexOfName(sName) <> -1) then
      sVal := AVars.Values[sName]
    else if FExpandStrCache.IndexOfName(sName) <> -1 then
      sVal := FExpandStrCache.Values[sName]
    else if sName = 'RAND' then
      sVal := IntToStr(Random($7FFFFFFF))
    else if sName = 'NEXT' then begin
      sVal := '*';
      lNext := True;
    end
    else if sName = 'RUN' then
      sVal := TrimSlash(ExtractFilePath(ParamStr(0)))
    else if sName = 'APP' then
      sVal := TrimSlash(FDGetAppPath)
    else if sName = 'CFG' then
      sVal := TrimSlash(FDGetAppCfgPath)
    else if sName = 'SYSCFG' then
      sVal := TrimSlash(FDGetSystemCfgPath)
    else if sName = 'DOC' then
      sVal := TrimSlash(FDGetAppDocPath)
    else if sName = 'TEMP' then
      sVal := TrimSlash(FDGetTempPath)
    else begin
      sVal := GetEnvironmentVariable(sName);
      if sVal = '' then
        sVal := FDReadRegValue(sName);
      FExpandStrCache.Add(sName + '=' + sVal);
    end;
    FLock.Leave;
    Result := Copy(Result, 1, i1 - 1) + sVal + Copy(Result, i2 + 1, Length(Result));
  end;
  if lNext then begin
    sName := ExtractFileName(Result);
    i1 := Pos('*', sName);
    iMax := 0;
    iRes := FindFirst(Result, faAnyFile, rSR);
    while iRes = 0 do begin
      iVal := StrToIntDef(Copy(rSR.Name, i1, Length(rSR.Name) - Length(sName) + 1), 0);
      if iVal > iMax then
        iMax := iVal;
      iRes := FindNext(rSR);
    end;
    FindClose(rSR);
    i1 := Pos('*', Result);
    Result := Copy(Result, 1, i1 - 1) + IntToStr(iMax + 1) + Copy(Result, i1 + 1, Length(Result));
  end;
{$IFDEF POSIX}
  for i := 1 to Length(Result) do
    if Result[i] = '\' then
      Result[i] := '/';
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure FDExpandStrs(const AStrs: TStrings; AVars: TStrings = nil);
var
  i: Integer;
begin
  AStrs.BeginUpdate;
  try
    for i := 0 to AStrs.Count - 1 do
      AStrs[i] := FDExpandStr(AStrs[i], AVars);
  finally
    AStrs.EndUpdate;
  end;
end;

{-------------------------------------------------------------------------------}
function FDIsDesignTime: Boolean;
begin
  Result := GIsDesignTime;
end;

{-------------------------------------------------------------------------------}
function FDIndexOf(AList: Pointer; ALen: Integer; AItem: Pointer): Integer;
type
  PPtr = ^Pointer;
  TPtrArray = array of Pointer;
var
  p, lastP: PPtr;
  prevLastP: Pointer;
  c: Integer;
begin
  if ALen = -1 then
    c := Length(TPtrArray(AList))
  else
    c := ALen;
  if c = 0 then
    Result := -1
  else begin
    p := PPtr(AList);
    if c > 1 then begin
      lastP := PPtr(PByte(p) + (c - 1) * SizeOf(Pointer));
      prevLastP := lastP^;
      lastP^ := AItem;
      while p^ <> AItem do
        Inc(p);
      lastP^ := prevLastP;
    end;
    if p^ = AItem then
      Result := (PByte(p) - PByte(AList)) div SizeOf(Pointer)
    else
      Result := -1;
  end;
end;

{-------------------------------------------------------------------------------}
procedure FDFree(AObj: TObject);
begin
  if AObj <> nil then
{$IFDEF AUTOREFCOUNT}
    AObj.DisposeOf;
{$ELSE}
    AObj.Destroy;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure FDFreeAndNil(var AObj);
var
  p: Pointer;
begin
  if Pointer(AObj) <> nil then begin
    p := Pointer(AObj);
    Pointer(AObj) := nil;
{$IFDEF AUTOREFCOUNT}
    if TObject(p).__ObjRelease > 0 then
      TObject(p).DisposeOf;
{$ELSE}
    TObject(p).Destroy;
{$ENDIF}
  end;
end;

{-------------------------------------------------------------------------------}
function FDGetCmdParam(const AParName: String; const ADefValue: String): String;
begin
  Result := ADefValue;
  if FDGetCmdParam(AParName, ADefValue = '', Result) then
    if (ADefValue = '') and (Result = '') then
      Result := '1';
end;

{-------------------------------------------------------------------------------}
function FDGetCmdParam(const AParName: String; ATrigger: Boolean; var AValue: String): Boolean;
var
  i, j, l: Integer;
  s: String;
begin
  Result := False;
  i := 1;
  while i <= ParamCount do begin
    s := ParamStr(i);
    if FDInSet(s[1], ['-', '/']) then begin
      j := 2;
      while (j <= Length(s)) and not FDInSet(s[j], [':', '=', ' ']) do
        Inc(j);
      l := j - 2;
      if (l = Length(AParName)) and
         (AnsiStrLIComp(PChar(s) + 1, PChar(AParName), l) = 0) then begin
        Result := True;
        if not ATrigger then
          if j <= Length(s) then
            AValue := Copy(s, j + 1, Length(s))
          else if i < ParamCount then begin
            Inc(i);
            AValue := ParamStr(i);
          end;
        Exit;
      end;
    end;
    Inc(i);
  end;
end;

{-------------------------------------------------------------------------------}
function FDTimeout(AStartTicks, ATimeout: Cardinal): Boolean;
var
  i: LongWord;
begin
  i := TThread.GetTickCount();
  if i < AStartTicks then
    Result := ($FFFFFFFF - AStartTicks + i) >= ATimeout
  else
    Result := (i - AStartTicks) >= ATimeout;
end;

{-------------------------------------------------------------------------------}
procedure FDStr2BCD(pIn: PChar; ASize: Integer; out ABcd: TBcd; ADot: Char);
var
  lNeg, lDec: Boolean;
  iDecPos: Integer;
  pTmp: PChar;
  pFrac: PByte;
  lStore: Boolean;
  iSize: Integer;
  iCell: Byte;
  c: Char;
begin
  if ASize = -1 then
    ASize := StrLen(pIn);
  FillChar(ABcd, SizeOf(ABcd), 0);
  if (pIn^ = '0') and ((ASize = 1) or ((pIn + 1)^ = #0)) or
     (pIn^ = #0) then begin
    ABcd.Precision := 8;
    ABcd.SignSpecialPlaces := 2;
    Exit;
  end;

  iDecPos := 0;
  lDec := False;
  while iDecPos < ASize do begin
    if pIn[iDecPos] = ADot then begin
      lDec := True;
      Break;
    end;
    Inc(iDecPos);
  end;
  if iDecPos = ASize then
    iDecPos := 0;

  { Strip leading whitespace }
  while ((pIn^ = ' ') or (pIn^ = '0')) and (ASize > 0) do begin
    Inc(pIn);
    Dec(ASize);
    if iDecPos > 0 then
      Dec(iDecPos);
  end;
  if ASize = 0 then
    Exit;

  { Strip trailing whitespace }
  pTmp := pIn + ASize - 1;
  while pTmp^ = ' ' do begin
    pTmp^ := #0;
    Dec(pTmp);
  end;

  { Is the number negative? }
  if pIn^ = '-' then begin
    lNeg := True;
    Inc(pIn);
    Dec(ASize);
    if iDecPos > 0 then
      Dec(iDecPos);
  end
  else begin
    lNeg := False;
    if pIn^ = '+' then begin
      Inc(pIn);
      Dec(ASize);
      if iDecPos > 0 then
        Dec(iDecPos);
    end;
  end;

  { Clear structure }
  if pIn^ = '0' then begin
    Inc(pIn);  // '0.' scenario
    Dec(ASize);
    if iDecPos > 0 then
      Dec(iDecPos);
  end;

  if ASize <= 0 then
    Exit
  else if ASize > 66 then begin
    ABcd.Precision := 8;
    ABcd.SignSpecialPlaces := 2;
    Exit;
  end;

  pFrac := @ABcd.Fraction[0];
  lStore := False;
  iSize := ASize;
  iCell := 0;
  while iSize > 0 do begin
    Dec(iSize);
    c := pIn^;
    Inc(pIn);
    if c <> ADot then
      if lStore then begin
        pFrac^ := (iCell shl 4) or (Ord(c) - Ord('0'));
        Inc(pFrac);
        lStore := False;
      end
      else begin
        iCell := Ord(c) - Ord('0');
        lStore := True;
      end;
  end;
  if lStore then
    pFrac^ := iCell shl 4;

  if lDec then begin
    ABcd.Precision := Byte(ASize - 1);
    if lNeg then
      ABcd.SignSpecialPlaces := Byte((1 shl 7) + Byte(ASize - iDecPos - 1))
    else
      ABcd.SignSpecialPlaces := Byte((0 shl 7) + Byte(ASize - iDecPos - 1));
  end
  else begin
    ABcd.Precision := Byte(ASize);
    if lNeg then
      ABcd.SignSpecialPlaces := (1 shl 7)
    else
      ABcd.SignSpecialPlaces := (0 shl 7);
  end;
end;

{-------------------------------------------------------------------------------}
procedure FDFloatRec2BCD(const ARec: TFloatRec; out ABcd: TBcd);
var
  pIn: PFDAnsiString;
  iSize, iPrecision, iExponent, iDecimal: Integer;
  pFrac: PByte;
  lStore: Boolean;
  iCell: Byte;
  c: Char;
  i: Integer;
begin
  pIn := PFDAnsiString(@ARec.Digits[0]);
  iSize := FDAnsiStrLen(pIn);
  iExponent := ARec.Exponent;

  FillChar(ABcd.Fraction, SizeOf(ABcd.Fraction), 0);

  if iSize = 0 then begin
    ABcd.Precision := 8;
    ABcd.SignSpecialPlaces := 2;
    Exit;
  end;

  pFrac := @ABcd.Fraction[0];
  lStore := False;
  iCell := 0;

  // If Exponent is negative, then prepend value by zeros
  if iExponent < 0 then begin
    i := -iExponent;
    while i > 0 do begin
      Dec(i);
      if lStore then begin
        pFrac^ := 0;
        Inc(pFrac);
        lStore := False;
      end
      else
        lStore := True;
    end;
  end;

  // Put digits
  i := iSize;
  while i > 0 do begin
    Dec(i);
    c := Char(pIn^);
    Inc(pIn);
    if lStore then begin
      pFrac^ := (iCell shl 4) or (Ord(c) - Ord('0'));
      Inc(pFrac);
      lStore := False;
    end
    else begin
      iCell := Ord(c) - Ord('0');
      lStore := True;
    end;
  end;

  // If Exponent is positive and more than length, then append value by zeros
  if (iExponent > 0) and (iExponent > iSize) then begin
    i := iExponent - iSize;
    while i > 0 do begin
      Dec(i);
      if lStore then begin
        pFrac^ := iCell shl 4;
        Inc(pFrac);
        lStore := False;
      end
      else begin
        iCell := 0;
        lStore := True;
      end;
    end;
  end;

  if lStore then
    pFrac^ := iCell shl 4;

  if iExponent > iSize then
    iPrecision := iExponent
  else if iExponent < 0 then
    iPrecision := iSize + -iExponent
  else
    iPrecision := iSize;
  ABcd.Precision := Byte(iPrecision);

  if iExponent < iSize then
    iDecimal := iSize - iExponent
  else
    iDecimal := 0;
  if ARec.Negative then
    ABcd.SignSpecialPlaces := Byte((1 shl 7) + Byte(iDecimal))
  else
    ABcd.SignSpecialPlaces := Byte((0 shl 7) + Byte(iDecimal));
end;

{-------------------------------------------------------------------------------}
procedure FDBCD2Str(pOut: PChar; out ASize: Integer; const ABcd: TBcd; ADot: Char);
var
  iLoop: Integer;
  iNumDigits: Integer;
  pStr: PChar;
  cVal: Byte;
  lWasDigit: WordBool;
begin
  pStr := pOut;

  // First, is the number negative?
  if (ABcd.SignSpecialPlaces and (1 shl 7)) <> 0 then begin
    pOut^ := '-';
    Inc(pOut);
  end;

  // Now, loop through the whole part of the bcd number
  // use lower 6 bits of iSignSpecialPlaces.
  iNumDigits := ABcd.Precision - (ABcd.SignSpecialPlaces and 63);
  if iNumDigits < 0 then
    iNumDigits := 0;
  lWasDigit := False;
  for iLoop := 0 to iNumDigits - 1 do begin
    if (iLoop mod 2) <> 0 then
      // lower 4 bits only
      cVal := Byte((ABcd.Fraction[(iLoop - 1 ) div 2] and 15) + Ord('0'))
    else
      // upper 4 bits only
      cVal := Byte((ABcd.Fraction[iLoop div 2] shr 4) + Ord('0'));

    // This little test is used to strip leading '0' chars.
    if (cVal <> Ord('0')) or lWasDigit then begin
      pOut^ := Char(cVal);
      Inc(pOut);
      lWasDigit := True;
    end;
  end;

  // If no data is stored yet, add a leading '0'.
  if not lWasDigit then begin
    pOut^ := '0';
    Inc(pOut);
  end;
  pOut^ := ADot;
  Inc(pOut);

  for iLoop := iNumDigits to ABcd.Precision - 1 do begin
    if iLoop mod 2 <> 0 then
      // lower 4 bits only
      pOut^ := Char((ABcd.Fraction[(iLoop - 1) div 2] and 15) + Ord('0'))
    else
      // upper 4 bits only
      pOut^ := Char((ABcd.Fraction[iLoop div 2] shr 4) + Ord('0'));
    Inc(pOut);
  end;

  // Right trim '0' chars
  ASize := pOut - pStr;
  while (ASize > 0) and ((pOut - 1)^ = '0') do begin
    Dec(pOut);
    Dec(ASize);
  end;
  if (ASize > 0) and ((pOut - 1)^ = ADot) then begin
    Dec(pOut);
    Dec(ASize);
  end;
  pOut^ := #0;
end;

{-------------------------------------------------------------------------------}
procedure FDBcdGetMetrics(const ABcd: TBcd; out APrecision, AScale: Smallint);
begin
  APrecision := ABcd.Precision;
  AScale := ABcd.SignSpecialPlaces AND $3F;
  // The StrToBcd always returns even precision
  if (AScale <> 0) and ((ABcd.Fraction[(APrecision + 1) div 2] AND $F) = 0) then begin
    Dec(APrecision);
    Dec(AScale);
  end;
end;

{-------------------------------------------------------------------------------}
procedure FDBCD2Double(const ABcd: TBcd; out AVal: Extended);
var
  aBuff: array [0 .. 127] of Char;
  iLen: Integer;
begin
  FDBCD2Str(aBuff, iLen, ABcd, FormatSettings.DecimalSeparator);
  TextToFloat(aBuff, AVal, fvExtended);
end;

{-------------------------------------------------------------------------------}
procedure FDDouble2BCD(const AExt: Extended; out AVal: TBcd);
var
  rFloat: TFloatRec;
begin
  // With Precision >= 16 we will get Double -> Extended conversion
  // garbage. Eg 0.07 gives 0.0700000000000001.
  FloatToDecimal(rFloat, AExt, fvExtended, 15, 9999);
  FDFloatRec2BCD(rFloat, AVal);
end;

{-------------------------------------------------------------------------------}
procedure FDInt2Str(ASrcData: Pointer; ASrcLen: Integer;
  var ADestData: PChar; var ADestLen: Integer; ANoSign: Boolean;
  AScale: Integer);
var
  lw: Cardinal;
  ui64: UInt64;
  lNeg: Boolean;
  pBuff: PChar;
  iDigs: Integer;
begin
  ASSERT((ASrcData <> nil) and (ADestData <> nil));
  iDigs := 0;
  pBuff := ADestData + ADestLen - 1;
  pBuff^ := #0;
  Dec(pBuff);
  if ASrcLen = SizeOf(Int64) then begin
    ui64 := PUInt64(ASrcData)^;
    lNeg := not ANoSign and (ui64 > $7FFFFFFFFFFFFFFF);
    if lNeg then
      ui64 := -Int64(ui64);
    repeat
      pBuff^ := Char(ui64 mod 10 + Ord('0'));
      Dec(pBuff);
      Inc(iDigs);
      if iDigs = AScale then begin
        pBuff^ := FormatSettings.DecimalSeparator;
        Dec(pBuff);
        iDigs := $FF;
      end;
      ui64 := ui64 div 10;
    until ui64 = 0;
  end
  else begin
    case ASrcLen of
    SizeOf(ShortInt):
      begin
        lw := PByte(ASrcData)^;
        lNeg := not ANoSign and (lw > $7F);
        if lNeg then
          lw := -ShortInt(lw);
      end;
    SizeOf(SmallInt):
      begin
        lw := PWord(ASrcData)^;
        lNeg := not ANoSign and (lw > $7FFF);
        if lNeg then
          lw := -SmallInt(lw);
      end;
    SizeOf(Integer):
      begin
        lw := PCardinal(ASrcData)^;
        lNeg := not ANoSign and (lw > $7FFFFFFF);
        if lNeg then
          lw := -Integer(lw);
      end;
    else
      lw := 0;
      lNeg := False;
      ASSERT(False);
    end;
    repeat
      pBuff^ := Char(lw mod 10 + Ord('0'));
      Dec(pBuff);
      Inc(iDigs);
      if iDigs = AScale then begin
        pBuff^ := FormatSettings.DecimalSeparator;
        Dec(pBuff);
        iDigs := $FF;
      end;
      lw := lw div 10;
    until lw = 0;
  end;
  while iDigs < AScale do begin
    pBuff^ := '0';
    Dec(pBuff);
    Inc(iDigs);
    if iDigs = AScale then begin
      pBuff^ := FormatSettings.DecimalSeparator;
      Dec(pBuff);
      iDigs := $FF;
    end;
  end;
  if iDigs = $FF then begin
    pBuff^ := '0';
    Dec(pBuff);
  end;
  if lNeg then begin
    pBuff^ := '-';
    Dec(pBuff);
  end;
  ADestLen := ADestLen - (pBuff - ADestData) - 2;
  ADestData := pBuff + 1;
end;

{-------------------------------------------------------------------------------}
procedure FDStr2Int(ASrcData: PChar; ASrcLen: Integer;
  ADestData: Pointer; ADestLen: Integer; ANoSign: Boolean;
  AScale: Integer);
var
  ui64: UInt64;
  ui64Max: UInt64;
  lw: Cardinal;
  lNeg: Boolean;
  pEnd: PChar;
  lHasPoint: Boolean;
  iDecs: Integer;
  pStart: PChar;

  procedure RangeError;
  var
    sVal: String;
    sType: String;
  begin
    SetString(sVal, pStart, ASrcLen);
    if ANoSign then
      case ADestLen of
      SizeOf(UInt64):   sType := 'UInt64';
      SizeOf(Cardinal): sType := 'Cardinal';
      SizeOf(Word):     sType := 'Word';
      SizeOf(Byte):     sType := 'Byte';
      end
    else
      case ADestLen of
      SizeOf(Int64):    sType := 'Int64';
      SizeOf(Integer):  sType := 'Integer';
      SizeOf(SmallInt): sType := 'SmallInt';
      SizeOf(ShortInt): sType := 'ShortInt';
      end;
    FDException(nil, [S_FD_LStan], er_FD_ValueOutOfRange, [sVal, sType]);
  end;

begin
  ASSERT((ASrcData <> nil) and (ADestData <> nil) and
         ((AScale = 0) or not ANoSign));
  pStart := ASrcData;
  pEnd := ASrcData + ASrcLen - 1;
  while (pEnd^ <= ' ') and (ASrcData <= pEnd) do
    Dec(pEnd);
  while (ASrcData^ <= ' ') and (ASrcData <= pEnd) do
    Inc(ASrcData);
  if ASrcData^ = '-' then begin
    if ANoSign then
      RangeError;
    lNeg := True;
    Inc(ASrcData);
  end
  else begin
    lNeg := False;
    if ASrcData^ = '+' then
      Inc(ASrcData);
  end;
  if AScale = 0 then begin
    if ADestLen = SizeOf(Int64) then begin
      ui64 := 0;
      if ANoSign then
        ui64Max := $FFFFFFFFFFFFFFFF div 10
      else
        ui64Max := $7FFFFFFFFFFFFFFF div 10;
      while (ASrcData <= pEnd) and (ASrcData^ <> FormatSettings.DecimalSeparator) do begin
        if ui64 > ui64Max then
          RangeError;
        ui64 := ui64 * 10 + UInt64(Ord(ASrcData^) - Ord('0'));
        Inc(ASrcData);
      end;
      if lNeg then
        Int64(ui64) := - Int64(ui64);
      PUInt64(ADestData)^ := ui64;
    end
    else begin
      lw := 0;
      while (ASrcData <= pEnd) and (ASrcData^ <> FormatSettings.DecimalSeparator) do begin
        if ANoSign and (lw > $FFFFFFFF div 10) then
          RangeError;
        lw := lw * 10 + Cardinal(Ord(ASrcData^) - Ord('0'));
        Inc(ASrcData);
      end;
      if lNeg then
        Integer(lw) := - Integer(lw);
      case ADestLen of
      SizeOf(Byte):     PByte(ADestData)^ := Byte(lw);
      SizeOf(Word):     PWord(ADestData)^ := Word(lw);
      SizeOf(Cardinal): PCardinal(ADestData)^ := Cardinal(lw);
      end;
    end;
  end
  else begin
    lHasPoint := False;
    iDecs := 0;
    if ADestLen = SizeOf(Int64) then begin
      ui64 := 0;
      while (ASrcData <= pEnd) and (iDecs < AScale) do begin
        if ASrcData^ = FormatSettings.DecimalSeparator then
          lHasPoint := True
        else begin
          if lHasPoint then
            Inc(iDecs);
          if ui64 > $7FFFFFFFFFFFFFFF div 10 then
            RangeError;
          ui64 := ui64 * 10 + UInt64(Ord(ASrcData^) - Ord('0'));
        end;
        Inc(ASrcData);
      end;
      while iDecs < AScale do begin
        if ui64 > $7FFFFFFFFFFFFFFF div 10 then
          RangeError;
        ui64 := ui64 * 10;
        Inc(iDecs);
      end;
      if lNeg then
        Int64(ui64) := - Int64(ui64);
      PUInt64(ADestData)^ := ui64;
    end
    else begin
      lw := 0;
      while (ASrcData <= pEnd) and (iDecs < AScale) do begin
        if ASrcData^ = FormatSettings.DecimalSeparator then
          lHasPoint := True
        else begin
          if lHasPoint then
            Inc(iDecs);
          if lw > $7FFFFFFF div 10 then
            RangeError;
          lw := lw * 10 + Cardinal(Ord(ASrcData^) - Ord('0'));
        end;
        Inc(ASrcData);
      end;
      while iDecs < AScale do begin
        if lw > $7FFFFFFF div 10 then
          RangeError;
        lw := lw * 10;
        Inc(iDecs);
      end;
      if lNeg then
        Integer(lw) := - Integer(lw);
      case ADestLen of
      SizeOf(Byte):     PByte(ADestData)^ := Byte(lw);
      SizeOf(Word):     PWord(ADestData)^ := Word(lw);
      SizeOf(Cardinal): PCardinal(ADestData)^ := Cardinal(lw);
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function FDFloat2Str(const AValue: Extended; ADot: Char = '.';
  APrec: Integer = 18): String;
var
  aBuff: array[0..63] of Char;
  pFS: PFDFormatSettings;
begin
  if APrec = 0 then
    APrec := 18;
  pFS := @GCachedNumFS;
  pFS^.DecimalSeparator := ADot;
  SetString(Result, aBuff, FloatToText(aBuff, AValue,
    fvExtended, ffGeneral, APrec, 0, pFS^));
end;

{------------------------------------------------------------------------------}
function FDStr2Float(const AValue: String; ADot: Char = '.'): Extended;

  procedure Error;
  begin
    raise EConvertError.CreateFmt(SInvalidFloat, [AValue]);
  end;

var
  pFS: PFDFormatSettings;
begin
  pFS := @GCachedNumFS;
  pFS^.DecimalSeparator := ADot;
  if not TextToFloat(PChar(AValue), Result, fvExtended, pFS^) then
    Error;
end;

{------------------------------------------------------------------------------}
procedure FDStr2Float(pIn: PChar; ASize: Integer; ADestData: Pointer; ADestLen: Integer; ADot: Char = '.');

  procedure Error;
  begin
    raise EConvertError.CreateFmt(SInvalidFloat, [pIn]);
  end;

var
  pFS: PFDFormatSettings;
  e: Extended;
begin
  if (pIn + ASize)^ <> #0 then
    (pIn + ASize)^ := #0;
  pFS := @GCachedNumFS;
  pFS^.DecimalSeparator := ADot;
  case ADestLen of
{$IF SizeOf(EXTENDED) = 10}
  SizeOf(Extended):
    if not TextToFloat(pIn, PExtended(ADestData)^, fvExtended, pFS^) then
      Error;
{$ENDIF}
  SizeOf(Double):
    begin
      if not TextToFloat(pIn, e, fvExtended, pFS^) then
        Error;
      PDouble(ADestData)^ := e;
    end;
  SizeOf(Single):
    begin
      if not TextToFloat(pIn, e, fvExtended, pFS^) then
        Error;
      PSingle(ADestData)^ := e;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure FDCurr2Str(pOut: PChar; out ASize: Integer;
  const AValue: Currency; ADot: Char = '.');
var
  pFS: PFDFormatSettings;
begin
  pFS := @GCachedNumFS;
  pFS^.DecimalSeparator := ADot;
  pFS^.CurrencyFormat := 0;
  pFS^.NegCurrFormat := 1;
  pFS^.ThousandSeparator := #0;
  pFS^.CurrencyString := '';
  ASize := FloatToText(pOut, AValue, fvCurrency, ffGeneral, 0, 0, pFS^);
end;

{------------------------------------------------------------------------------}
function FDCurr2Str(const AValue: Currency; ADot: Char = '.'): String;
var
  aBuff: array[0..63] of Char;
  iSize: Integer;
begin
  FDCurr2Str(aBuff, iSize, AValue, ADot);
  SetString(Result, aBuff, iSize);
end;

{------------------------------------------------------------------------------}
function FDStr2Curr(const AValue: String; ADot: Char = '.'): Currency;

  procedure Error;
  begin
    raise EConvertError.CreateFmt(SInvalidFloat, [AValue]);
  end;

var
  pFS: PFDFormatSettings;
begin
  pFS := @GCachedNumFS;
  pFS^.DecimalSeparator := ADot;
  pFS^.CurrencyFormat := 0;
  pFS^.NegCurrFormat := 1;
  pFS^.ThousandSeparator := #0;
  pFS^.CurrencyString := '';
  if not TextToFloat(PChar(AValue), Result, fvCurrency, pFS^) then
    Error;
end;

{------------------------------------------------------------------------------}
procedure FDStr2Curr(pIn: PChar; ASize: Integer; out ACurr: Currency; ADot: Char = '.');

  procedure Error;
  begin
    raise EConvertError.CreateFmt(SInvalidFloat, [pIn]);
  end;

var
  pFS: PFDFormatSettings;
begin
  if (pIn + ASize)^ <> #0 then
    (pIn + ASize)^ := #0;
  pFS := @GCachedNumFS;
  pFS^.DecimalSeparator := ADot;
  pFS^.CurrencyFormat := 0;
  pFS^.NegCurrFormat := 1;
  pFS^.ThousandSeparator := #0;
  pFS^.CurrencyString := '';
  if not TextToFloat(pIn, ACurr, fvCurrency, pFS^) then
    Error;
end;

{------------------------------------------------------------------------------}
function FDBcdIsDecimalPartEmpty(const ABCD: TBcd): Boolean;
var
  iDecPos: ShortInt;
  i: ShortInt;
  iDigit: Byte;
begin
  Result := True;
  iDecPos := ShortInt(ABCD.Precision - (ABCD.SignSpecialPlaces and 63));
  for i := iDecPos to ABCD.Precision - 1 do begin
    if i mod 2 = 0 then
      iDigit := Byte((ABcd.Fraction[i div 2]) shr 4)
    else
      iDigit := Byte(Byte((ABcd.Fraction[i div 2]) and 15));
    if iDigit <> 0 then begin
      Result := False;
      Break;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function FDRandomNumber(AMaxPrec, AMaxScale: Integer; ASign: Integer): String;
var
  iLen, iDec, i: Integer;
  lWasDigit: Boolean;
begin
  iLen := Random(AMaxPrec + 1);
  if iLen = 0 then begin
    Result := '0';
    Exit;
  end;

  if AMaxScale > iLen then
    AMaxScale := iLen;
  if AMaxScale > 0 then
    iDec := iLen - Random(AMaxScale + 1)
  else
    iDec := 0;

  if (ASign = 0) and (Random(2) = 1) then
    ASign := -1;
  if ASign < 0 then begin
    Inc(iLen);
    if iDec > 0 then
      Inc(iDec);
  end;

  if iDec > 0 then
    Inc(iLen);
  if iDec = 1 then
    Inc(iLen);
  if (iDec >= iLen) or (ASign = -1) and (iDec = iLen - 1) then begin
    Dec(iLen);
    iDec := 0;
  end;

  SetLength(Result, iLen);
  i := 1;

  if ASign = -1 then begin
    Result[i] := '-';
    Inc(iDec);
    Inc(i);
  end;

  lWasDigit := False;
  while i <= iLen do begin

    if i = iDec then begin
      if not lWasDigit then begin
        Result[i] := '0';
        Inc(i);
        lWasDigit := True;
      end;
      Result[i] := FormatSettings.DecimalSeparator;
      Inc(i);
    end;

    if lWasDigit and (i < iLen) then
      Result[i] := Chr(Ord('0') + Random(10))
    else
      Result[i] := Chr(Ord('1') + Random(9));
    Inc(i);
    lWasDigit := True;
  end;

end;

{------------------------------------------------------------------------------}
function FDDisableFPExc: NativeUInt;
begin
{$IFDEF MSWINDOWS}
  Result := NativeUInt(Get8087CW());
  Set8087CW($133F);
{$ENDIF}
{$IFDEF POSIX}
  Result := NativeUInt(signal(SIGFPE, TSignalHandler(SIG_IGN)));
{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure FDResetFPExc(AValue: NativeUInt);
begin
{$IFDEF MSWINDOWS}
  Set8087CW(Word(AValue));
{$ENDIF}
{$IFDEF POSIX}
  signal(SIGFPE, TSignalHandler(AValue));
{$ENDIF}
end;

{------------------------------------------------------------------------------}
                                                                           
                                                     
{$IFDEF MSWINDOWS}
function FDGetVersionInfo(const AFileName: string; out AProduct,
  AVersion, AVersionName, ACopyright, AInfo: string): Boolean;
type
  TTranslation = array[0 .. 1] of Word;
const
  CTrans: String = '\VarFileInfo\Translation';
  CProdName: String = '\StringFileInfo\%s\FileDescription';
  CFileVers: String = '\StringFileInfo\%s\FileVersion';
  CCopyright: String = '\StringFileInfo\%s\LegalCopyright';
  CComments: String = '\StringFileInfo\%s\Comments';
  CSlash: String = '\';
var
  iHndl, iSz, iLen: DWORD;
  pBuff: Pointer;
  pTranslation: ^TTranslation;
  sTranslation, sBeta: String;
  pStr: PChar;
  pFileInfo: ^TVSFixedFileInfo;
begin
  Result := False;
  AProduct := '';
  AVersion := '';
  AVersionName := '';
  ACopyright := '';
  AInfo := '';
  iHndl := 0;
  iLen := 0;
  pFileInfo := nil;
  pTranslation := nil;
  pStr := nil;
  iSz := GetFileVersionInfoSize(PChar(AFileName), iHndl);
  if iSz <= 0 then
    Exit;
  GetMem(pBuff, iSz);
  try
    if not GetFileVersionInfo(PChar(AFileName), iHndl, iSz, pBuff) then
      Exit;
    if VerQueryValue(pBuff, PChar(CSlash), Pointer(pFileInfo), iLen) then
      if (pFileInfo.dwFileFlags and VS_FF_PRERELEASE) <> 0 then
        sBeta := ' Beta';
    if VerQueryValue(pBuff, PChar(CTrans), Pointer(pTranslation), iLen) then
      sTranslation := IntToHex(pTranslation^[0], 4) + IntToHex(pTranslation^[1], 4)
    else
      sTranslation := '040904B0';
    if VerQueryValue(pBuff, PChar(Format(CProdName, [sTranslation])), Pointer(pStr), iLen) then
      AProduct := pStr;
    if VerQueryValue(pBuff, PChar(Format(CFileVers, [sTranslation])), Pointer(pStr), iLen) then begin
      AVersion := pStr;
      AVersionName := Format('%d.%d.%d (Build %d)%s', [pFileInfo^.dwFileVersionMS shr 16,
        pFileInfo^.dwFileVersionMS and $0000FFFF, pFileInfo^.dwFileVersionLS shr 16,
        pFileInfo^.dwFileVersionLS and $0000FFFF, sBeta]);
    end;
    if VerQueryValue(pBuff, PChar(Format(CCopyright, [sTranslation])), Pointer(pStr), iLen) then
      ACopyright := pStr;
    if VerQueryValue(pBuff, PChar(Format(CComments, [sTranslation])), Pointer(pStr), iLen) then
      AInfo := pStr;
    Result := True;
  finally
    FreeMem(pBuff, iSz);
  end;
end;
{$ENDIF}

{------------------------------------------------------------------------------}
{$IFDEF MSWINDOWS}
var
  FLastFileName: String = '';
  FLastMachineType: TFDMachineType = mtUnknown;

function FDGetLibMachineType(const AFileName: String): TFDMachineType;
var
  oFS: TFileStream;
  iPeOffset: Integer;
  iPeHead: LongWord;
  iMachineType: Word;
begin
  Result := mtUnknown;
  // http://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/pecoff_v8.doc
  // Offset to PE header is always at 0x3C.
  // PE header starts with "PE\0\0" = 0x50 0x45 0x00 0x00,
  // followed by 2-byte machine type field (see document above for enum).
  FLock.Enter;
  try
    if FLastFileName = AFileName then begin
      Result := FLastMachineType;
      Exit;
    end;
    try
      oFS := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
      try
        oFS.Seek($3C, soFromBeginning);
        oFS.Read(iPeOffset, SizeOf(iPeOffset));
        oFS.Seek(iPeOffset, soFromBeginning);
        oFS.Read(iPeHead, SizeOf(iPeHead));
        // "PE\0\0", little-endian then
        if iPeHead <> $00004550 then
          Exit;
        oFS.Read(iMachineType, SizeOf(iMachineType));
        case iMachineType of
        $8664, // AMD64
        $0200: // IA64
          Result := mt64Bit;
        $014C: // I386
          Result := mt32Bit;
        else
          Result := mtOther;
        end;
      finally
        FDFree(oFS);
      end;
    except
      // none
    end;
    FLastFileName := AFileName;
    FLastMachineType := Result;
  finally
    FLock.Leave;
  end;
end;
{$ENDIF}

{$IFDEF POSIX}
function FDGetLibMachineType(const AFileName: String): TFDMachineType;
begin
                                                       
  Result := mtNative;
end;
{$ENDIF}

{------------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure FDHandleException;
begin
  if Assigned(System.Classes.ApplicationHandleException) then
    System.Classes.ApplicationHandleException(ExceptObject);
end;
{$WARNINGS ON}

{------------------------------------------------------------------------------}
procedure FDShell(const ACommand, ALayer: String);
{$IFDEF POSIX}
var
  s: TFDByteString;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if ShellExecute(0, 'open', PChar(ACommand), nil, nil, SW_SHOW) <= 32 then
    FDException(nil, [S_FD_LComp, ALayer], er_FD_ScrCantExecHostCmd,
      [ACommand, FDLastSystemErrorMsg]);
{$ENDIF}
{$IFDEF POSIX}
  s := TFDEncoder.Enco(ACommand, ecUTF8);
  _system(MarshaledAString(PByte(s)));
{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure FDFileMove(const ASrcName, ADestName: String);
{$IFDEF POSIX}
var
  s1, s2: TFDByteString;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if not MoveFileEx(PChar(ASrcName), PChar(ADestName),
                    MOVEFILE_COPY_ALLOWED or MOVEFILE_REPLACE_EXISTING) then
{$ENDIF}
{$IFDEF POSIX}
  s1 := TFDEncoder.Enco(ASrcName, ecUTF8);
  s2 := TFDEncoder.Enco(ADestName, ecUTF8);
  unlink(MarshaledAString(PByte(s2)));
  if __rename(MarshaledAString(PByte(s1)), MarshaledAString(PByte(s2))) <> 0 then
{$ENDIF}
    FDException(nil, [S_FD_LStan], er_FD_StanStrgFileError,
      [ASrcName, ADestName, FDLastSystemErrorMsg]);
end;

{------------------------------------------------------------------------------}
procedure FDSystemMessage(const ACaption, AMessage: String; AWarning: Boolean);
var
{$IFDEF MSWINDOWS}
  iFlags: LongWord;
{$ENDIF}
{$IFDEF POSIX}
  s: TFDByteString;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  iFlags := MB_TOPMOST or MB_SERVICE_NOTIFICATION;
  if AWarning then
    iFlags := iFlags or MB_ICONWARNING;
  MessageBox(0, PChar(AMessage), PChar(ACaption), iFlags);
{$ENDIF}
{$IFDEF POSIX}
  s := TFDEncoder.Enco(AMessage, ecUTF8);
  __write(2, PByte(s), TFDEncoder.EncoLength(s, ecUTF8));
{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure FDSetEnv(const AName, AValue: String);
{$IFDEF POSIX}
var
  s1, s2: TFDByteString;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  SetEnvironmentVariable(PChar(AName), PChar(AValue));
{$ENDIF}
{$IFDEF POSIX}
  s1 := TFDEncoder.Enco(AName, ecUTF8);
  s2 := TFDEncoder.Enco(AValue, ecUTF8);
  setenv(MarshaledAString(PByte(s1)), MarshaledAString(PByte(s2)), 1);
{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure FDHighRefCounter(var ACounter: Integer);
begin
{$IFDEF AUTOREFCOUNT}
  ACounter := ACounter or $FFFFFFF;
{$ELSE}
  ACounter := $3FFFFFFF;
{$ENDIF}
end;

{------------------------------------------------------------------------------}
function FDAlign(AValue: Integer): Integer;
begin
  Result := (AValue + C_FD_Alignment - 1) and not (C_FD_Alignment - 1);
end;

{------------------------------------------------------------------------------}
initialization
  GIsDesignTime := False;
{$IFDEF MACOS}
  // MACOS: by default invalid format - ':nn' and ':'
  FormatSettings.ShortTimeFormat := 'hh:nn';
  FormatSettings.TimeSeparator := ':';
{$ENDIF}
  C_Date_1_1_1 := EncodeDate(1, 1, 1);
  FLock := TCriticalSection.Create;
  FExpandStrCache := TFDStringList.Create(dupError, True, False);

  GParseFmtSettings.FDelimiter := ';';
  GParseFmtSettings.FQuote := '"';
  GParseFmtSettings.FQuote1 := '{';
  GParseFmtSettings.FQuote2 := '}';

  GSemicolonFmtSettings.FDelimiter := ';';
  GSemicolonFmtSettings.FQuote := #0;
  GSemicolonFmtSettings.FQuote1 := #0;
  GSemicolonFmtSettings.FQuote2 := #0;

  GSpaceFmtSettings.FDelimiter := ' ';
  GSpaceFmtSettings.FQuote := #0;
  GSpaceFmtSettings.FQuote1 := #0;
  GSpaceFmtSettings.FQuote2 := #0;

  FThreads := TFDThreadObjList.Create;
  GCheckGuiRunning := nil;

finalization
  FDFreeAndNil(FExpandStrCache);
  FDFreeAndNil(FThreads);
  FDFreeAndNil(FLock);

end.
