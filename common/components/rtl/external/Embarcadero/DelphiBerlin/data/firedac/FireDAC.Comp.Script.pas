{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC SQL script engine               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Comp.Script;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.Types, System.SysUtils, System.Classes, System.SyncObjs,
  FireDAC.Stan.Param, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Util, 
    FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys.SQLPreprocessor,
  FireDAC.Comp.UI, FireDAC.Comp.Client;

type
  IFDScriptEngineIntf = interface;
  TFDScriptCommand = class;
  TFDScriptCommandClass = class of TFDScriptCommand;
  TFDScriptParser = class;
  TFDScriptOptions = class;
  TFDSQLScript = class;
  TFDSQLScripts = class;
  TFDScript = class;

  TFDScriptEchoCommands = (ecNone, ecSQL, ecAll);
  TFDScriptSpoolOutputMode = (smNone, smOnReset, smOnAppend);
  TFDScriptStatus = (ssInactive, ssValidating, ssRunning, ssFinishWithErrors,
    ssFinishSuccess, ssAborted);
  TFDScriptTextMode = (smRead, smWriteReset, smWriteAppend);

  TFDHostCommandEvent = procedure (AEngine: TFDScript;
    const ACommand: String; var ADoDefault: Boolean) of object;
  TFDConsolePutEvent = procedure (AEngine: TFDScript;
    const AMessage: String; AKind: TFDScriptOutputKind) of object;
  TFDConsoleLockUpdate = procedure (AEngine: TFDScript; ALock: Boolean) of object;
  TFDConsoleGetEvent = procedure (AEngine: TFDScript;
    const APrompt: String; var AResult: String) of object;
  TFDGetTextEvent = procedure (AEngine: TFDScript;
    const AFileName: String; AMode: TFDScriptTextMode; out AText: TFDTextFile) of object;
  TFDPauseEvent = procedure (AEngine: TFDScript;
    const AText: String) of object;

  IFDScriptEngineIntf = interface (IUnknown)
    ['{FFD3BABC-CFAB-4A6E-9B1B-882E76791DF6}']
    // private
    function GetRDBMSKind: TFDRDBMSKind;
    function GetConnectionIntf: IFDPhysConnection;
    function GetCommandIntf: IFDPhysCommand;
    function GetTable: TFDDatSTable;

    // public
    procedure CheckCommand;
    procedure CheckCommit(AForce: Boolean);
    procedure CheckStartTransaction;
    procedure UpdateCommandSeparator;
    function ExpandString(const AValue: String): String;

    procedure CloseSpool;
    procedure UpdateSpool;

    procedure OpenConnection(const AConnectionString: String);
    procedure CloseConnection;
    procedure Disconnect(AAbortJob: Boolean = False);

    function ExecuteAll(AParser: TFDScriptParser): Boolean; overload;
    function ExecuteStep(AParser: TFDScriptParser): Boolean; overload;
    function ValidateAll(AParser: TFDScriptParser): Boolean; overload;
    function ValidateStep(AParser: TFDScriptParser): Boolean; overload;

    procedure Progress;
    procedure ConPut(const AMsg: String; AKind: TFDScriptOutputKind);
    procedure ConLockUpdate;
    procedure ConUnlockUpdate;
    procedure ConGet(const APrompt: String; var AResult: String);
    procedure ConPause(const APrompt: String);
    procedure GetText(const AFileName: String; AMode: TFDScriptTextMode;
      out AText: TFDTextFile);
    procedure ReleaseText(const AFileName: String; AMode: TFDScriptTextMode;
      var AText: TFDTextFile);
    procedure ExecuteHostCommand(const ACommand: String);

    property ConnectionIntf: IFDPhysConnection read GetConnectionIntf;
    property CommandIntf: IFDPhysCommand read GetCommandIntf;
    property RDBMSKind: TFDRDBMSKind read GetRDBMSKind;
    property Table: TFDDatSTable read GetTable;
  end;

  TFDScriptCommand = class(TObject)
  private
    FParser: TFDScriptParser;
    FEngine: TFDScript;
    FEngineIntf: IFDScriptEngineIntf;
    FPosition: TPoint;
  public
    constructor Create(AParser: TFDScriptParser; AEngine: TFDScript); virtual;
    destructor Destroy; override;
{$IFDEF FireDAC_MONITOR}
    function Dump(): String; virtual;
{$ENDIF}
    class function Help(): String; virtual;
    class procedure Keywords(AKwds: TStrings); virtual;
    function Parse(const AKwd: String): Boolean; virtual;
    procedure Execute(); virtual;
    procedure Validate(); virtual;
    procedure AbortJob(const AWait: Boolean = False); virtual;
    property Parser: TFDScriptParser read FParser;
    property Engine: TFDScript read FEngine;
    property EngineIntf: IFDScriptEngineIntf read FEngineIntf;
    property Position: TPoint read FPosition;
  end;

  TFDScriptCommandLookupRes = (ucNone, ucPartial, ucShort, ucExact);
  TFDScriptCommandRegistry = class(TObject)
  private
    FKeywords: TFDStringList;
    FCommands: TFDClassList;
    FDefaultSQLCommandClass: TFDScriptCommandClass;
    FDefaultPLSQLCommandClass: TFDScriptCommandClass;
    function GetCommand(AIndex: Integer): TFDScriptCommandClass;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddCommand(ACommand: TFDScriptCommandClass);
    function LookupCommand(const AStr: String;
      out ACommand: TFDScriptCommandClass): TFDScriptCommandLookupRes;
    property DefaultSQLCommandClass: TFDScriptCommandClass
      read FDefaultSQLCommandClass write FDefaultSQLCommandClass;
    property DefaultPLSQLCommandClass: TFDScriptCommandClass
      read FDefaultPLSQLCommandClass write FDefaultPLSQLCommandClass;
    property Count: Integer read GetCount;
    property Commands[AIndex: Integer]: TFDScriptCommandClass read GetCommand; default;
  end;

  TFDScriptParser = class(TObject)
  private
    FCh: Char;
    FBeginningOfLine: Boolean;
    FWasBeginningOfLine: Boolean;
    FFileName: String;
    FParentCommand: TFDScriptCommand;
    FLineNumber: Integer;
    FLineNumberPos: Int64;
    FTotalSize: Integer;
    FScriptOptions: TFDScriptOptions;
    FText: TFDTextFile;
    FLastKwd: String;
    FPrep: TFDPhysPreprocessor;
    function CreateScriptCommand(ACmdClass: TFDScriptCommandClass;
      AEngine: TFDScript; const AKwd: String): TFDScriptCommand;
    function CreateSQLCommand(var ABeginBmk, ALastBmk, AEndBmk: Integer;
      AEngine: TFDScript; var ACommand: TFDScriptCommand): Boolean;
    function GetPosition: TPoint;
    procedure SetPosition(const AValue: TPoint);
    function InternalGetString(AAllowQuote, AAllowDoubleQuote, ARequired,
      AIgnoreSep: Boolean; ASet: TFDCharSet): String;
    function GetEOL(AFirstCh: Char): Boolean;
  protected
    function InternalGetChar: Char;
    function InternalGetBookmark: Integer;
    procedure InternalSetBookmark(ABmk: Integer);
    function InternalExtractString(ABmk1, ABmk2: Integer): String;
  public
    constructor Create(AFileName: String; AParentCommand: TFDScriptCommand;
      AText: TFDTextFile; AOptions: TFDScriptOptions);
    // low level
    procedure GetChar;
    procedure UnGetChar;
    function GetBookmark: Integer;
    procedure SetBookmark(ABmk: Integer);
    function ExtractString(ABmk1, ABmk2: Integer): String;
    procedure SkipWS;
    procedure SkipWSLF;
    function GetUCWord: String;
    function GetString(ARequired: Boolean = False): String;
    function GetStringInFull: String;
    function GetIdentifier: String;
    function GetLine: String;
    function GetOnOfChar(ADef: Char): Integer;
    function GetOnOff: Integer;
    function GetNumber(ADef: Integer = 0): Integer;
    // high level
    procedure InvalidSyntax;
    function ExtractCommand(AEngine: TFDScript): TFDScriptCommand;
    // props
    // R/O
    property Ch: Char read FCh;
    property FileName: String read FFileName;
    property LineNumber: Integer read FLineNumber;
    property ParentCommand: TFDScriptCommand read FParentCommand;
    property WasBeginningOfLine: Boolean read FWasBeginningOfLine;
    // R/W
    property TotalSize: Integer read FTotalSize write FTotalSize;
    property ScriptOptions: TFDScriptOptions read FScriptOptions write FScriptOptions;
    property Position: TPoint read GetPosition write SetPosition;
  end;

  TFDScriptOptions = class(TPersistent)
  private
    FOwner: TPersistent;
    FCommitEachNCommands: Integer;
    FAutoPrintParams: Boolean;
    FEchoCommands: TFDScriptEchoCommands;
    FFeedbackCommands: Boolean;
    FColumnHeadings: Boolean;
    FMaxBytesToPrintLongs: Integer;
    FConsoleOutput: Boolean;
    FSpoolOutput: TFDScriptSpoolOutputMode;
    FSpoolFileName: String;
    FTiming: Boolean;
    FBreakOnError: Boolean;
    FDropNonexistObj: Boolean;
    FCommandSeparator: String;
    FParamArraySize: Integer;
    FEchoCommandTrim: Integer;
    FFeedbackScript: Boolean;
    FActualCommandSeparator: String;
    FDefaultScriptPath: String;
    FMacroExpand: Boolean;
    FTrimConsole: Boolean;
    FTrimSpool: Boolean;
    FVerify: Boolean;
    FDefaultDataPath: String;
    FPageSize: Integer;
    FLineSize: Integer;
    FFileEndOfLine: TFDTextEndOfLine;
    FFileEncoding: TFDEncoding;
    FIgnoreError: Boolean;
    FCharacterSet: String;
    FSQLDialect: Integer;
    FClientLib: String;
    FDriverID: String;
    FRaisePLSQLErrors: Boolean;
    FBlobFile: String;
    procedure SetCommandSeparator(const AValue: String);
    procedure SetDriverID(const AValue: String);
  protected
    function GetOwner: TPersistent; override;
  public
    property ActualCommandSeparator: String read FActualCommandSeparator;
  published
    constructor Create(AOwner: TPersistent);
    procedure Reset;
    procedure Assign(Source: TPersistent); override;
    property CommitEachNCommands: Integer read FCommitEachNCommands write FCommitEachNCommands default 0;
    property AutoPrintParams: Boolean read FAutoPrintParams write FAutoPrintParams default False;
    property EchoCommands: TFDScriptEchoCommands read FEchoCommands write FEchoCommands default ecSQL;
    property EchoCommandTrim: Integer read FEchoCommandTrim write FEchoCommandTrim default 50;
    property FeedbackCommands: Boolean read FFeedbackCommands write FFeedbackCommands default True;
    property FeedbackScript: Boolean read FFeedbackScript write FFeedbackScript default True;
    property ColumnHeadings: Boolean read FColumnHeadings write FColumnHeadings default True;
    property MaxStringWidth: Integer read FMaxBytesToPrintLongs write FMaxBytesToPrintLongs default 80;
    property ConsoleOutput: Boolean read FConsoleOutput write FConsoleOutput default True;
    property SpoolOutput: TFDScriptSpoolOutputMode read FSpoolOutput write FSpoolOutput default smNone;
    property SpoolFileName: String read FSpoolFileName write FSpoolFileName;
    property Timing: Boolean read FTiming write FTiming default True;
    property BreakOnError: Boolean read FBreakOnError write FBreakOnError default False;
    property IgnoreError: Boolean read FIgnoreError write FIgnoreError default False;
    property DropNonexistObj: Boolean read FDropNonexistObj write FDropNonexistObj default True;
    property CommandSeparator: String read FCommandSeparator write SetCommandSeparator;
    property ParamArraySize: Integer read FParamArraySize write FParamArraySize default 1;
    property PageSize: Integer read FPageSize write FPageSize default 24;
    property LineSize: Integer read FLineSize write FLineSize default 0;
    property DefaultScriptPath: String read FDefaultScriptPath write FDefaultScriptPath;
    property MacroExpand: Boolean read FMacroExpand write FMacroExpand default True;
    property TrimConsole: Boolean read FTrimConsole write FTrimConsole default False;
    property TrimSpool: Boolean read FTrimSpool write FTrimSpool default True;
    property Verify: Boolean read FVerify write FVerify default False;
    property DefaultDataPath: String read FDefaultDataPath write FDefaultDataPath;
    property FileEncoding: TFDEncoding read FFileEncoding write FFileEncoding default ecDefault;
    property FileEndOfLine: TFDTextEndOfLine read FFileEndOfLine write FFileEndOfLine default elDefault;
    property DriverID: String read FDriverID write SetDriverID;
    property ClientLib: String read FClientLib write FClientLib;
    property CharacterSet: String read FCharacterSet write FCharacterSet;
    property SQLDialect: Integer read FSQLDialect write FSQLDialect default 0;
    property RaisePLSQLErrors: Boolean read FRaisePLSQLErrors write FRaisePLSQLErrors default False;
    property BlobFile: String read FBlobFile write FBlobFile;
  end;

  TFDSQLScript = class(TCollectionItem)
  private
    FName: String;
    FSQL: TStrings;
    procedure SetSQL(const AValue: TStrings);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  published
    property Name: String read FName write FName;
    property SQL: TStrings read FSQL write SetSQL;
  end;

  TFDSQLScripts = class(TOwnedCollection)
  private
    function GetItems(AIndex: Integer): TFDSQLScript;
    procedure SetItems(AIndex: Integer; const AValue: TFDSQLScript);
  public
    constructor Create(AScript: TFDScript);
    function Add: TFDSQLScript;
    function FindScript(const AName: String): TFDSQLScript;
    property Items[AIndex: Integer]: TFDSQLScript read GetItems write SetItems; default;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or
    pidiOSSimulator or pidiOSDevice32 or pidiOSDevice64 or pidAndroid or
    pidLinux64)]
  TFDScript = class(TFDComponent, IFDStanOptions, IFDStanErrorHandler,
    IFDStanObject, IFDGUIxScriptDialogInfoProvider, IFDScriptEngineIntf)
  private
    FFinished: Boolean;
    FConnectionIntf: IFDPhysConnection;
    FCommandIntf: IFDPhysCommand;
    FTable: TFDDatSTable;
    FMacros: TFDMacros;
    FParams: TFDParams;
    FArguments: TStrings;
    FProcessedAfterCommit: Integer;
    FSpool: TFDTextFile;
    FLastSpoolFileName: String;
    FLock: TCriticalSection;
    FPrep: TFDPhysPreprocessor;
    FRDBMSKind: TFDRDBMSKind;

    FCurrentCommand: TFDScriptCommand;
    FCallStack: TStrings;
    FAllSpools: TStrings;
    FTotalJobSize: Integer;
    FTotalJobDone: Integer;
    FTotalPct10Done: Integer;
    FTotalErrors: Integer;
    FStatus: TFDScriptStatus;

    FOnHostCommand: TFDHostCommandEvent;
    FOnConsolePut: TFDConsolePutEvent;
    FOnConsoleLockUpdate: TFDConsoleLockUpdate;
    FOnConsoleGet: TFDConsoleGetEvent;
    FOnSpoolPut: TFDConsolePutEvent;
    FOnGetText: TFDGetTextEvent;
    FOnReleaseText: TFDGetTextEvent;
    FOnPause: TFDPauseEvent;
    FOnProgress: TNotifyEvent;
    FBeforeScript: TNotifyEvent;
    FAfterScript: TNotifyEvent;
    FAfterExecute: TNotifyEvent;
    FBeforeExecute: TNotifyEvent;
    FOnError: TFDErrorEvent;

    FScriptOptions: TFDScriptOptions;
    FScriptDialog: TFDGUIxScriptDialog;
    FScriptDialogVisible: Boolean;
    FSQLScriptFileName: String;
    FSQLScripts: TFDSQLScripts;
    FConnection: TFDCustomConnection;
    FTransaction: TFDCustomTransaction;
    FOptionsIntf: IFDStanOptions;
    FPosition: TPoint;

    function GetScriptDialogIntf(out AIntf: IFDGUIxScriptDialog): Boolean;
    procedure SetCurrentCommand(const ACommand: TFDScriptCommand);
    procedure SetScriptOptions(const AValue: TFDScriptOptions);
    procedure SetScriptDialog(const AValue: TFDGUIxScriptDialog);
    procedure RestoreArguments(AArgs: TStrings);
    function SetupArguments: TStrings;
    procedure SetArguments(const AValue: TStrings);
    procedure SetConnection(const AValue: TFDCustomConnection);
    procedure SetTransaction(const AValue: TFDCustomTransaction);
    procedure DoConnectChanged(Sender: TObject; Connecting: Boolean);
    procedure SetSQLScripts(const AValue: TFDSQLScripts);
    function GetFetchOptions: TFDFetchOptions;
    function GetFormatOptions: TFDFormatOptions;
    function GetResourceOptions: TFDResourceOptions;
    procedure SetFetchOptions(const Value: TFDFetchOptions);
    procedure SetFormatOptions(const Value: TFDFormatOptions);
    procedure SetResourceOptions(const Value: TFDResourceOptions);
    function GetEof: Boolean;
    procedure SetMacros(const AValue: TFDMacros);
    procedure SetParams(const AValue: TFDParams);
    function GetParamsOwner: TPersistent;
    function GetIsEmpty: Boolean;

  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    function InternalExecute(AParser: TFDScriptParser; ARealExecute: Boolean;
      AAll: Boolean): Boolean; overload;
    function InternalExecute(ARealExecute: Boolean; AAll: Boolean): Boolean; overload;
    procedure InternalOpenConnection(const AConnectionString: String);
    procedure InternalReleaseConnection;

    { IFDStanObject }
    function GetName: TComponentName;
    function GetParent: IFDStanObject;
    procedure BeforeReuse;
    procedure AfterReuse;
    procedure SetOwner(const AOwner: TObject; const ARole: TComponentName);
    { IFDStanOptions }
    property OptionsIntf: IFDStanOptions read FOptionsIntf implements IFDStanOptions;
    procedure GetParentOptions(var AOpts: IFDStanOptions);
    { IFDStanErrorHandler }
    procedure HandleException(const AInitiator: IFDStanObject;
      var AException: Exception); virtual;
    { IFDGUIxScriptDialogInfoProvider }
    procedure RequestStop;
    function GetCallStack: TStrings;
    function GetTotalJobSize: Integer;
    function GetTotalJobDone: Integer;
    function GetTotalPct10Done: Integer;
    function GetTotalErrors: Integer;
    function GetIsRunning: Boolean;

    { IFDScriptEngineIntf }
    function GetRDBMSKind: TFDRDBMSKind;
    function GetConnectionIntf: IFDPhysConnection;
    function GetCommandIntf: IFDPhysCommand;
    function GetTable: TFDDatSTable;

    procedure CheckCommand;
    procedure CheckCommit(AForce: Boolean);
    procedure CheckStartTransaction;
    procedure UpdateCommandSeparator;
    function ExpandString(const AValue: String): String;

    procedure CloseSpool;
    procedure UpdateSpool;

    procedure OpenConnection(const AConnectionString: String);
    procedure CloseConnection;
    procedure Disconnect(AAbortJob: Boolean = False);

    function ExecuteAll(AParser: TFDScriptParser): Boolean; overload;
    function ExecuteStep(AParser: TFDScriptParser): Boolean; overload;
    function ValidateAll(AParser: TFDScriptParser): Boolean; overload;
    function ValidateStep(AParser: TFDScriptParser): Boolean; overload;

    procedure Progress;
    procedure ConPut(const AMsg: String; AKind: TFDScriptOutputKind); virtual;
    procedure ConLockUpdate; virtual;
    procedure ConUnlockUpdate; virtual;
    procedure ConGet(const APrompt: String; var AResult: String); virtual;
    procedure ConPause(const APrompt: String); virtual;
    procedure GetText(const AFileName: String; AMode: TFDScriptTextMode;
      out AText: TFDTextFile); virtual;
    procedure ReleaseText(const AFileName: String; AMode: TFDScriptTextMode;
      var AText: TFDTextFile); virtual;
    procedure ExecuteHostCommand(const ACommand: String); virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ExecuteAll: Boolean; overload;
    function ExecuteStep: Boolean; overload;
    function ValidateAll: Boolean; overload;
    function ValidateStep: Boolean; overload;

    procedure ExecuteFile(const AFileName: String); overload;
    procedure ExecuteFile(const AFileName: String; const AArguments: array of String); overload;
    procedure ExecuteScript(const AScript: TStrings); overload;
    procedure ExecuteScript(const AScript: TStrings; const AArguments: array of String); overload;
    procedure AbortJob(const AWait: Boolean = False);

    property CallStack: TStrings read GetCallStack;
    property TotalJobSize: Integer read GetTotalJobSize;
    property TotalJobDone: Integer read GetTotalJobDone;
    property TotalPct10Done: Integer read GetTotalPct10Done;
    property TotalErrors: Integer read GetTotalErrors;
    property CurrentCommand: TFDScriptCommand read FCurrentCommand;
    property AllSpools: TStrings read FAllSpools;
    property LastSpoolFileName: String read FLastSpoolFileName;
    property Status: TFDScriptStatus read FStatus;
    property Eof: Boolean read GetEof;
    property IsEmpty: Boolean read GetIsEmpty;

    property Position: TPoint read FPosition write FPosition;
    property Finished: Boolean read FFinished write FFinished;
    property ProcessedAfterCommit: Integer read FProcessedAfterCommit write FProcessedAfterCommit;

  published
    property SQLScriptFileName: String read FSQLScriptFileName write FSQLScriptFileName;
    property SQLScripts: TFDSQLScripts read FSQLScripts write SetSQLScripts;
    property Connection: TFDCustomConnection read FConnection write SetConnection;
    property Transaction: TFDCustomTransaction read FTransaction write SetTransaction;
    property ScriptOptions: TFDScriptOptions read FScriptOptions write SetScriptOptions;
    property ScriptDialog: TFDGUIxScriptDialog read FScriptDialog write SetScriptDialog;
    property Params: TFDParams read FParams write SetParams;
    property Macros: TFDMacros read FMacros write SetMacros;
    property Arguments: TStrings read FArguments write SetArguments;
    property FormatOptions: TFDFormatOptions read GetFormatOptions write SetFormatOptions;
    property FetchOptions: TFDFetchOptions read GetFetchOptions write SetFetchOptions;
    property ResourceOptions: TFDResourceOptions read GetResourceOptions write SetResourceOptions;

    property OnHostCommand: TFDHostCommandEvent read FOnHostCommand write FOnHostCommand;
    property OnConsolePut: TFDConsolePutEvent read FOnConsolePut write FOnConsolePut;
    property OnConsoleLockUpdate: TFDConsoleLockUpdate read FOnConsoleLockUpdate write FOnConsoleLockUpdate;
    property OnConsoleGet: TFDConsoleGetEvent read FOnConsoleGet write FOnConsoleGet;
    property OnSpoolPut: TFDConsolePutEvent read FOnSpoolPut write FOnSpoolPut;
    property OnGetText: TFDGetTextEvent read FOnGetText write FOnGetText;
    property OnReleaseText: TFDGetTextEvent read FOnReleaseText write FOnReleaseText;
    property OnPause: TFDPauseEvent read FOnPause write FOnPause;
    property OnProgress: TNotifyEvent read FOnProgress write FOnProgress;
    property BeforeScript: TNotifyEvent read FBeforeScript write FBeforeScript;
    property AfterScript: TNotifyEvent read FAfterScript write FAfterScript;
    property OnError: TFDErrorEvent read FOnError write FOnError;
    property BeforeExecute: TNotifyEvent read FBeforeExecute write FBeforeExecute;
    property AfterExecute: TNotifyEvent read FAfterExecute write FAfterExecute;
  end;

function FDKeywordMatch(const AStr, AMatch: String; AOptLength: Integer): Boolean;
function FDScriptCommandRegistry(): TFDScriptCommandRegistry;

implementation

uses
  FireDAC.Stan.Factory, FireDAC.Stan.Consts;

var
  FScriptCommandRegistry: TFDScriptCommandRegistry = nil;

{-------------------------------------------------------------------------------}
function FDKeywordMatch(const AStr, AMatch: String; AOptLength: Integer): Boolean;
begin
  if Length(AStr) > Length(AMatch) then
    Result := False
  else begin
    Result := StrLComp(PChar(AStr), PChar(AMatch), AOptLength) = 0;
    if Result and (Length(AStr) > AOptLength) then
      Result := StrLComp(PChar(AStr) + AOptLength, PChar(AMatch) + AOptLength,
        Length(AStr) - AOptLength) = 0;
  end;
end;

{-------------------------------------------------------------------------------}
function FDScriptCommandRegistry(): TFDScriptCommandRegistry;
begin
  if FScriptCommandRegistry = nil then
    FScriptCommandRegistry := TFDScriptCommandRegistry.Create;
  Result := FScriptCommandRegistry;
end;

{-------------------------------------------------------------------------------}
function UpperCh(const ACh: Char): Char;
begin
  if FDInSet(ACh, ['a' .. 'z']) then
    Result := Char(Word(ACh) xor $0020)
  else
    Result := ACh;
end;

{-------------------------------------------------------------------------------}
{ TFDScriptCommand                                                              }
{-------------------------------------------------------------------------------}
constructor TFDScriptCommand.Create(AParser: TFDScriptParser;
  AEngine: TFDScript);
begin
  inherited Create;
  FParser := AParser;
  FEngine := AEngine;
  FEngineIntf := AEngine as IFDScriptEngineIntf;
  if FEngine <> nil then
    FEngine.SetCurrentCommand(Self);
end;

{-------------------------------------------------------------------------------}
destructor TFDScriptCommand.Destroy;
begin
  if (FEngine <> nil) and (FEngine.CurrentCommand = Self) then
    FEngine.SetCurrentCommand(nil);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
function TFDScriptCommand.Dump(): String;
begin
  Result := '<incompleted>';
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
class function TFDScriptCommand.Help(): String;
begin
  Result := '';
end;

{-------------------------------------------------------------------------------}
class procedure TFDScriptCommand.Keywords(AKwds: TStrings);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDScriptCommand.Parse(const AKwd: String): Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptCommand.Execute;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptCommand.Validate;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptCommand.AbortJob(const AWait: Boolean);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
{ TFDScriptCommandRegistry                                                      }
{-------------------------------------------------------------------------------}
constructor TFDScriptCommandRegistry.Create;
begin
  inherited Create;
  FCommands := TFDClassList.Create;
  FKeywords := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDScriptCommandRegistry.Destroy;
begin
  FDFreeAndNil(FCommands);
  FDFreeAndNil(FKeywords);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDScriptCommandRegistry.GetCount: Integer;
begin
  Result := FCommands.Count;
end;

{-------------------------------------------------------------------------------}
function TFDScriptCommandRegistry.GetCommand(AIndex: Integer): TFDScriptCommandClass;
begin
  Result := TFDScriptCommandClass(FCommands[AIndex]);
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptCommandRegistry.AddCommand(ACommand: TFDScriptCommandClass);
var
  i: Integer;
  oKwds: TFDStringList;
begin
  FCommands.Add(ACommand);
  FKeywords.Sorted := False;
  oKwds := TFDStringList.Create;
  try
    ACommand.Keywords(oKwds);
    for i := 0 to oKwds.Count - 1 do
      FKeywords.AddPtr(oKwds[i], ACommand);
  finally
    FDFree(oKwds);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDScriptCommandRegistry.LookupCommand(const AStr: String;
  out ACommand: TFDScriptCommandClass): TFDScriptCommandLookupRes;
var
  L, H, I, C, j, iStrLen: Integer;
  sKwd: String;
begin
  FKeywords.Sorted := True;
  Result := ucNone;
  ACommand := nil;
  iStrLen := Length(AStr);
  L := 0;
  H := FKeywords.Count - 1;
  while L <= H do begin
    I := (L + H) shr 1;

    //      1     2      3      4      5      6
    // kwd: AAAA  AAAA   AAAA   AAaa   AAaa   AAaa
    // str: AA    AAAA   AAAAA  AA     AAA    AAAA
    // res: part  exact  none   short  short  exact

    sKwd := FKeywords[I];
    C := 0;
    j := 1;
    Result := ucNone;
    while j <= iStrLen do begin
      // 3
      if j > Length(sKwd) then begin
        Result := ucNone;
        Break;
      end;
      C := Ord(sKwd[j]) - Ord(AStr[j]);
      if j = iStrLen then begin
        if C = 0 then
          if j < Length(sKwd) then
            // 4
            if FDInSet(sKwd[j + 1], ['a' .. 'z']) then
              Result := ucShort
            // 1
            else begin
              Result := ucPartial;
              if not FDInSet(sKwd[j + 1], ['a' .. 'z', 'A' .. 'Z', '0' .. '9']) then
                C := 1;
            end
          // 2
          else
            Result := ucExact
        else if (C = 32) and FDInSet(sKwd[j], ['a' .. 'z']) then begin
          // 5
          if j < Length(sKwd) then
            Result := ucShort
          // 6
          else
            Result := ucExact;
          C := 0;
        end
        else
          Result := ucNone;
      end
      else
        if not ((C = 0) or (C = 32) and FDInSet(sKwd[j], ['a' .. 'z'])) then begin
          Result := ucNone;
          Break;
        end
        else
          C := 0;
      Inc(j);
    end;

    if C < 0 then
      L := I + 1
    else begin
      H := I - 1;
      if C = 0 then
        L := I;
    end;
  end;

  if Result in [ucShort, ucExact] then
    ACommand := TFDScriptCommandClass(FKeywords.Ptrs[L]);
end;

{-------------------------------------------------------------------------------}
{ TFDScriptParser                                                               }
{-------------------------------------------------------------------------------}
constructor TFDScriptParser.Create(AFileName: String; AParentCommand: TFDScriptCommand;
  AText: TFDTextFile; AOptions: TFDScriptOptions);
begin
  inherited Create;
  FFileName := AFileName;
  FParentCommand := AParentCommand;
  FText := AText;
  FBeginningOfLine := True;
  FScriptOptions := AOptions;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.InternalGetBookmark: Integer;
begin
  Result := Integer(FText.Position);
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptParser.InternalSetBookmark(ABmk: Integer);
begin
  FText.Position := ABmk;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.InternalGetChar: Char;
begin
  if not FText.ReadChar(Result) then
    Result := #0;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.InternalExtractString(ABmk1, ABmk2: Integer): String;
begin
  Result := FText.ExtractString(ABmk1, ABmk2);
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptParser.GetChar;
begin
  FCh := InternalGetChar;
  if FCh <> #0 then begin
    Inc(FTotalSize);
    if FDInSet(FCh, [#13, #10]) then
      FBeginningOfLine := True
    else if FBeginningOfLine then
      FBeginningOfLine := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptParser.UnGetChar;
begin
  SetBookmark(GetBookmark - 1);
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetBookmark: Integer;
begin
  Result := InternalGetBookmark;
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptParser.SetBookmark(ABmk: Integer);
begin
  if ABmk > 0 then begin
    Inc(FTotalSize, ABmk - 1 - InternalGetBookmark);
    InternalSetBookmark(ABmk - 1);
    GetChar;
  end
  else begin
    Inc(FTotalSize, ABmk - InternalGetBookmark);
    InternalSetBookmark(ABmk);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptParser.SkipWSLF;
begin
  while FDInSet(FCh, [' ', #9, #13, #10]) do
    GetChar;
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptParser.SkipWS;
begin
  while FDInSet(FCh, [' ', #9]) do
    GetChar;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.InternalGetString(AAllowQuote, AAllowDoubleQuote,
  ARequired, AIgnoreSep: Boolean; ASet: TFDCharSet): String;
var
  i1, i2: Integer;
  iQuoted, iSep, iLen: Integer;
  ucCS: String;
begin
  SkipWS;
  i1 := GetBookmark - 1;
  iLen := 2;
  if AAllowDoubleQuote and (FCh = '"') then begin
    iQuoted := 1;
    GetChar;
    while not FDInSet(FCh, [#0, #13, #10]) do begin
      if FCh = '"' then begin
        GetChar;
        if FCh <> '"' then
          Break;
      end;
      GetChar;
    end;
  end
  else if AAllowQuote and (FCh = '''') then begin
    iQuoted := 2;
    GetChar;
    while not FDInSet(FCh, [#0, #13, #10]) do begin
      if FCh = '''' then begin
        GetChar;
        if FCh <> '''' then
          Break;
      end;
      GetChar;
    end;
  end
  else begin
    ucCS := UpperCase(ScriptOptions.ActualCommandSeparator);
    iQuoted := 0;
    iSep := 1;
    while (FCh <> #0) and not FDInSet(FCh, ASet) do begin
      if ARequired then
        GetChar;
      if not AIgnoreSep then begin
        if UpperCh(FCh) = ucCS[iSep] then
          Inc(iSep)
        else
          iSep := 1;
        if iSep > Length(ucCS) then begin
          iLen := Length(ucCS) + 1;
          Break;
        end;
      end;
      if not ARequired then
        GetChar;
    end;
  end;
  i2 := GetBookmark - iLen;
  if iQuoted <> 0 then begin
    Inc(i1);
    Dec(i2);
  end;
  if i2 < i1 then
    Result := ''
  else
    Result := ExtractString(i1, i2);
  if iQuoted = 1 then
    Result := StringReplace(Result, '""', '"', [rfReplaceAll])
  else if iQuoted = 2 then
    Result := StringReplace(Result, '''''', '''', [rfReplaceAll]);
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetUCWord: String;
begin
  Result := InternalGetString(False, False, False, False, [#0..#255] -
    ['a'..'z', 'A'..'Z', '0'..'9', '_', '$', '#']);
  Result := UpperCase(Result);
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetIdentifier: String;
begin
  Result := InternalGetString(False, True, False, False, [#0..#255] -
    ['a'..'z', 'A'..'Z', '0'..'9', '_', ':', '.', '#', '@', '$']);
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetLine: String;
begin
  Result := InternalGetString(True, True, False, False, [#13, #10, #0]);
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetString(ARequired: Boolean = False): String;
begin
  Result := InternalGetString(True, True, ARequired, False, [' ', #9, #13, #10, #0]);
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetStringInFull: String;
begin
  Result := InternalGetString(True, True, False, True, [' ', #9, #13, #10, #0]);
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetOnOfChar(ADef: Char): Integer;
var
  ucS: String;
begin
  ucS := Trim(UpperCase(GetString()));
  if ucS = 'OFF' then
    Result := -1
  else if ucS = 'ON' then
    Result := Ord(ADef)
  else begin
    if Length(ucS) <> 1 then
      FDException(Self, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrStrSize1, []);
    if FDInSet(ucS[1], ['A'..'Z', '0'..'9', ' ', #9, #13, #10]) then
      FDException(Self, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrStrNotAlphaNum, []);
    Result := Ord(ucS[1]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetOnOff: Integer;
var
  ucS: String;
begin
  ucS := GetUCWord;
  if ucS = 'OFF' then
    Result := -1
  else if ucS = 'ON' then
    Result := 1
  else begin
    Result := 0;
    FDException(Self, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrSetArgInvalid, []);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetNumber(ADef: Integer): Integer;
var
  ucS: String;
begin
  ucS := GetUCWord;
  if ucS = 'OFF' then
    Result := -1
  else if ucS = 'ON' then
    Result := ADef
  else
    try
      Result := StrToInt(ucS);
    except
      Result := 0;
      FDException(Self, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrSetArgInvalid, []);
    end;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.ExtractString(ABmk1, ABmk2: Integer): String;
begin
  Result := InternalExtractString(ABmk1, ABmk2);
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetEOL(AFirstCh: Char): Boolean;
begin
  Result := False;
  case ScriptOptions.FileEndOfLine of
{$IFDEF MSWINDOWS}
  elDefault,
{$ENDIF}
  elWindows:
    if AFirstCh = #13 then begin
      GetChar;
      Result := FDInSet(FCh, [#10, #0]);
      if not Result then
        UnGetChar
    end
    else if AFirstCh = #10 then
      Result := True;
{$IFDEF POSIX}
  elDefault,
{$ENDIF}
  elPosix:
    if AFirstCh = #10 then
      Result := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptParser.InvalidSyntax;
begin
  FDException(nil, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrInvalidSyntax,
    [FLastKwd]);
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.CreateScriptCommand(ACmdClass: TFDScriptCommandClass;
  AEngine: TFDScript; const AKwd: String): TFDScriptCommand;
begin
  Result := ACmdClass.Create(Self, AEngine);
  try
    FLastKwd := AKwd;
    if not Result.Parse(AKwd) then
      FDFreeAndNil(Result);
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.CreateSQLCommand(var ABeginBmk, ALastBmk, AEndBmk: Integer;
  AEngine: TFDScript; var ACommand: TFDScriptCommand): Boolean;
var
  lEmpty: Boolean;
  sSQL: String;
  i: Integer;
begin
  AEndBmk := ALastBmk - 2;

  // check command is empty or not
  lEmpty := (AEndBmk = -1) or (ABeginBmk >= AEndBmk);
  if not lEmpty then begin
    sSQL := ExtractString(ABeginBmk, AEndBmk);
    lEmpty := True;
    for i := 1 to Length(sSQL) do
      if sSQL[i] > ' ' then begin
        lEmpty := False;
        Break;
      end;
  end;

  // if empty command, then continue to parse
  if lEmpty then begin
    FDFreeAndNil(ACommand);
    ABeginBmk := GetBookmark;
    AEndBmk := -1;
    Result := False;
  end
  // ... otherwise exit from loop
  else begin
    if ACommand = nil then
      ACommand := FScriptCommandRegistry.DefaultSQLCommandClass.Create(Self, AEngine);
    ACommand.Parse(ExtractString(ABeginBmk, AEndBmk));
    Result := True;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.ExtractCommand(AEngine: TFDScript): TFDScriptCommand;
var
  lInComment2, lInStr, lInStr2, lInName, lCmdSep, lAlpha: Boolean;
  iInComment1, iBraceLevel, iLastBmk, iBeginBmk, iEndBmk, i: Integer;
  ucS, ucCS, s, sPgStr2Delim: String;
  oCmdClass: TFDScriptCommandClass;
  rPos: TPoint;
begin
  iInComment1 := 0;
  lInComment2 := False;
  lInStr := False;
  lInStr2 := False;
  lInName := False;
  iBraceLevel := 0;
  iBeginBmk := GetBookmark;
  iEndBmk := -1;
  Result := nil;
  ucCS := ScriptOptions.ActualCommandSeparator;
  ASSERT(ucCS <> '');
  FPrep := AEngine.FPrep;
  rPos.X := 0;
  rPos.Y := 0;

  while True do begin
    FWasBeginningOfLine := FBeginningOfLine;
    GetChar;
    if (FCh <> #0) and (FLineNumber = 0) then begin
      FLineNumber := 1;
      FLineNumberPos := FText.Position - 1;
    end;
    if AEngine.Finished then begin
      FDFreeAndNil(Result);
      Exit;
    end;
    if (FCh > ' ') and (rPos.X = 0) and (rPos.Y = 0) then begin
      rPos := Position;
      Dec(rPos.X);
    end;
    iLastBmk := GetBookmark;
    case FCh of
    '(':
      if (iInComment1 = 0) and not lInComment2 and not lInStr and not lInStr2 and not lInName then begin
        Inc(iBraceLevel);
        Continue;
      end;
    ')':
      if (iInComment1 = 0) and not lInComment2 and not lInStr and not lInStr2 and not lInName then begin
        Dec(iBraceLevel);
        Continue;
      end;
    '/':
      if (iInComment1 = 0) and not lInComment2 and not lInStr and not lInStr2 and not lInName then begin
        GetChar;
        if FCh = '*' then begin
          Inc(iInComment1);
          Continue;
        end
        else if (ucCS = '/') or (ucCS = ';') then begin
          SetBookmark(iLastBmk);
          // if SQL or PL/SQL command, then extract it
          if FWasBeginningOfLine and
             CreateSQLCommand(iBeginBmk, iLastBmk, iEndBmk, AEngine, Result) then
            Break;
        end
        else
          SetBookmark(iLastBmk);
      end;
    #0:
      begin
        if ((Result = nil) or (Result.ClassType = FScriptCommandRegistry.DefaultSQLCommandClass) or
                              (Result.ClassType = FScriptCommandRegistry.DefaultPLSQLCommandClass)) then begin
          // if SQL or PL/SQL command, then extract it
          Inc(iLastBmk);
          CreateSQLCommand(iBeginBmk, iLastBmk, iEndBmk, AEngine, Result);
        end;
        Break;
      end;
    '*':
      begin
        GetChar;
        if not lInComment2 and not lInStr and not lInStr2 and not lInName and (FCh = '/') then begin
          if iInComment1 > 0 then
            Dec(iInComment1);
          Continue;
        end
        else
          SetBookmark(iLastBmk);
      end;
    '-':
      begin
        GetChar;
        if (iInComment1 = 0) and not lInStr and not lInStr2 and not lInName and (FCh = '-') then begin
          lInComment2 := True;
          Continue;
        end
        else
          SetBookmark(iLastBmk);
      end;
    '''':
      if (iInComment1 = 0) and not lInComment2 and not lInName and not lInStr2 then begin
        lInStr := not lInStr;
        Continue;
      end;
    '"':
      if (iInComment1 = 0) and not lInComment2 and not lInStr and not lInStr2 then begin
        lInName := not lInName;
        Continue;
      end;
    '$':
      if (iInComment1 = 0) and not lInComment2 and not lInName and not lInStr and
         (AEngine.GetRDBMSKind = TFDRDBMSKinds.PostgreSQL) then begin
        GetChar;
        if not FDInSet(FCh, ['0' .. '9']) then begin
          s := InternalGetString(False, False, False, True, ['$', #13, #10]);
          if FCh <> '$' then
            SetBookmark(iLastBmk)
          else
            if not lInStr2 then begin
              sPgStr2Delim := s;
              lInStr2 := True;
              Continue;
            end
            else if s = sPgStr2Delim then begin
              sPgStr2Delim := '';
              lInStr2 := False;
              Continue;
            end;
        end;
      end;
    #13, #10:
      if GetEOL(FCh) then begin
        Inc(FLineNumber);
        FLineNumberPos := FText.Position;
        if (iInComment1 = 0) and lInComment2 then
          lInComment2 := False;
        Continue;
      end;
    '\':
      if (iInComment1 = 0) and not lInComment2 and lInStr and
         // only MySQL and SQL Anywhere support C-style escape sequences
         // in string literals
         (AEngine.GetRDBMSKind in [TFDRDBMSKinds.MySQL, TFDRDBMSKinds.SQLAnywhere]) then begin
        GetChar;
        Continue;
      end;
    end;

    if (iInComment1 = 0) and not lInComment2 and not lInStr and not lInStr2 and not lInName and (iBraceLevel = 0) then begin

      // check for command separator:
      // 1) first char the same and
      // 2) either non alpha, either it is at start of line
      lCmdSep := False;
      if ((FCh = ucCS[1]) or FDInSet(FCh, ['a' .. 'z']) and (Chr(Ord(FCh) - 32) = ucCS[1])) and
         (not FDInSet(ucCS[1], ['A'..'Z', '0'..'9', '_']) or FWasBeginningOfLine) and (
            (Result = nil) or (ucCS <> ';') or
            (Result.ClassType <> FScriptCommandRegistry.DefaultPLSQLCommandClass) or
            (AEngine.GetRDBMSKind = TFDRDBMSKinds.PostgreSQL)) then begin
        lCmdSep := True;
        for i := 1 to Length(ucCS) do begin
          if ucCS[i] <> UpperCh(FCh) then begin
            lCmdSep := False;
            Break;
          end;
          GetChar;
        end;
        // if alpha-numeric separator, then it must end by spaces
        if FDInSet(ucCS[1], ['A'..'Z', '0'..'9', '_']) and not FDInSet(FCh, [' ', #9, #13, #10, #0]) then
          lCmdSep := False;
        // if SQL or PL/SQL command, then extract it
        if lCmdSep then begin
          if FCh <> #0 then
            UnGetChar;
          if CreateSQLCommand(iBeginBmk, iLastBmk, iEndBmk, AEngine, Result) then
            Break
        end
        else
          SetBookmark(iLastBmk);
      end;

      // check for non SQL command
      ucS := '';
      if not lCmdSep and (Result = nil) then begin
        lAlpha := FDInSet(FCh, ['A' .. 'Z', 'a' .. 'z']);
        while True do begin
          ucS := ucS + UpperCh(FCh);
          case FScriptCommandRegistry.LookupCommand(ucS, oCmdClass) of
          ucNone:
            begin
              if Length(ucS) > 1 then
                SetBookmark(iLastBmk);
              ucS := '';
              Break;
            end;
          ucPartial:
            GetChar;
          ucShort,
          ucExact:
            begin
              GetChar;
              if not lAlpha or
                 not FDInSet(FCh, ['A'..'Z', 'a'..'z', '0'..'9', '_', '$', '#', '-']) then begin
                Result := CreateScriptCommand(oCmdClass, AEngine, ucS);
                if Result = nil then
                  UnGetChar;
                Break;
              end;
            end;
          end;
        end;
        if Result <> nil then
          Break;
      end;

      // check for SQL programming language command
      if not lCmdSep and (Result = nil) and ((ucS <> '') or FDInSet(FCh, ['A'..'Z', 'a'..'z'])) then begin
        if ucS = '' then
          ucS := GetUCWord
        else
          GetChar;
        if (AEngine.GetRDBMSKind = TFDRDBMSKinds.Oracle) and ((ucS = 'BEGIN') or (ucS = 'DECLARE')) then
          Result := FScriptCommandRegistry.DefaultPLSQLCommandClass.Create(Self, AEngine)
        else if (AEngine.GetRDBMSKind = TFDRDBMSKinds.Firebird) and (ucS = 'EXECUTE') then begin
          SkipWSLF;
          ucS := GetUCWord;
          if ucS = 'BLOCK' then
            Result := FScriptCommandRegistry.DefaultPLSQLCommandClass.Create(Self, AEngine);
        end
        else if not (AEngine.GetRDBMSKind in [TFDRDBMSKinds.MSSQL, TFDRDBMSKinds.SQLAnywhere]) and
                    ((ucS = 'CREATE') or (ucS = 'RECREATE')) then begin
          SkipWSLF;
          ucS := GetUCWord;
          if (AEngine.GetRDBMSKind in [TFDRDBMSKinds.Interbase, TFDRDBMSKinds.Firebird]) and (ucS = 'DATABASE') then begin
            FScriptCommandRegistry.LookupCommand('CREATE DATABASE', oCmdClass);
            if oCmdClass <> nil then
              Result := oCmdClass.Create(Self, AEngine)
            else
              Result := FScriptCommandRegistry.DefaultSQLCommandClass.Create(Self, AEngine);
          end
          else begin
            if ucS = 'OR' then begin
              SkipWSLF;
              ucS := GetUCWord;
              if (ucS = 'REPLACE') or (ucS = 'ALTER') then begin
                SkipWSLF;
                ucS := GetUCWord;
              end;
            end;
            if (ucS = 'PROCEDURE') or (ucS = 'FUNCTION') or (ucS = 'PACKAGE') or
               (ucS = 'TYPE') or (ucS = 'TRIGGER') or (ucS = 'VARIABLE') then
              Result := FScriptCommandRegistry.DefaultPLSQLCommandClass.Create(Self, AEngine);
          end;
        end
        else
          Result := FScriptCommandRegistry.DefaultSQLCommandClass.Create(Self, AEngine);
        if not FDInSet(FCh, [' ', #9, #0]) then
          UnGetChar;
      end;
    end;
  end;

  // assign command position
  if Result <> nil then
    Result.FPosition := rPos;

  // if echo is on, then output command
  if (AEngine.Status <> ssValidating) and (
      (ScriptOptions.EchoCommands = ecAll) or
      (ScriptOptions.EchoCommands = ecSQL) and (Result <> nil) and
      ((Result.ClassType = FScriptCommandRegistry.DefaultSQLCommandClass) or
       (Result.ClassType = FScriptCommandRegistry.DefaultPLSQLCommandClass))) then begin
    s := ExtractString(iBeginBmk, GetBookmark);
    if (ScriptOptions.EchoCommandTrim > 0) and (Length(s) > ScriptOptions.EchoCommandTrim) then
      s := Copy(s, 1, ScriptOptions.EchoCommandTrim) + ' ...';
    AEngine.ConPut(s, soEcho);
  end;

  // skip stream to the next line
  GetChar;
  SkipWS;
  if FDInSet(FCh, [#13, #10]) and GetEOL(FCh) then begin
    Inc(FLineNumber);
    FLineNumberPos := FText.Position;
  end
  else if FCh <> #0 then
    UnGetChar;
end;

{-------------------------------------------------------------------------------}
function TFDScriptParser.GetPosition: TPoint;
begin
  if FLineNumber > 0 then
    Result := Point(Integer(FText.Position - FLineNumberPos), FLineNumber - 1)
  else
    Result := Point(0, 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptParser.SetPosition(const AValue: TPoint);
var
  i: Integer;
  p: TPoint;
begin
  p := Position;
  if (p.X = AValue.X) and (p.Y = AValue.Y) then
    Exit;
  FText.Position := 0;
  FLineNumber := 0;
  FLineNumberPos := 0;
  FBeginningOfLine := False;
  if AValue.Y >= 0 then begin
    i := 0;
    while i < AValue.Y do begin
      GetChar;
      if FCh = #0 then
        Break
      else begin
        if FLineNumber = 0 then begin
          FLineNumber := 1;
          FLineNumberPos := FText.Position - 1;
        end;
        if FDInSet(FCh, [#13, #10]) and GetEOL(FCh) then begin
          Inc(FLineNumber);
          FLineNumberPos := FText.Position;
          Inc(i);
        end;
      end;
    end;
    i := 0;
    while i < AValue.X do begin
      GetChar;
      if FCh = #0 then
        Break
      else begin
        if FLineNumber = 0 then begin
          FLineNumber := 1;
          FLineNumberPos := FText.Position - 1;
        end;
        if FDInSet(FCh, [#13, #10]) then begin
          UnGetChar;
          Break;
        end;
      end;
      Inc(i);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDScriptOptions                                                              }
{-------------------------------------------------------------------------------}
constructor TFDScriptOptions.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  Reset;
end;

{-------------------------------------------------------------------------------}
function TFDScriptOptions.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptOptions.Reset;
begin
  FCommitEachNCommands := 0;
  FAutoPrintParams := False;
  FEchoCommands := ecSQL;
  FEchoCommandTrim := 50;
  FFeedbackCommands := True;
  FFeedbackScript := True;
  FColumnHeadings := True;
  FMaxBytesToPrintLongs := 80;
  FConsoleOutput := True;
  FSpoolOutput := smNone;
  FTiming := True;
  FBreakOnError := False;
  FIgnoreError := False;
  FDropNonexistObj := True;
  FCommandSeparator := '';
  FParamArraySize := 1;
  FPageSize := 24;
  FDefaultScriptPath := '';
  FMacroExpand := True;
  FTrimConsole := False;
  FTrimSpool := True;
  FVerify := False;
  FDefaultDataPath := '';
  FLineSize := 0;
  FFileEncoding := ecDefault;
  FFileEndOfLine := elDefault;
  FDriverID := '';
  FClientLib := '';
  FCharacterSet := '';
  FSQLDialect := 0;
  FRaisePLSQLErrors := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptOptions.Assign(Source: TPersistent);
begin
  if Source is TFDScriptOptions then begin
    FCommitEachNCommands := TFDScriptOptions(Source).FCommitEachNCommands;
    FAutoPrintParams := TFDScriptOptions(Source).FAutoPrintParams;
    FEchoCommands := TFDScriptOptions(Source).FEchoCommands;
    FFeedbackCommands := TFDScriptOptions(Source).FFeedbackCommands;
    FFeedbackScript := TFDScriptOptions(Source).FFeedbackScript;
    FColumnHeadings := TFDScriptOptions(Source).FColumnHeadings;
    FMaxBytesToPrintLongs := TFDScriptOptions(Source).FMaxBytesToPrintLongs;
    FConsoleOutput := TFDScriptOptions(Source).FConsoleOutput;
    FSpoolOutput := TFDScriptOptions(Source).FSpoolOutput;
    FSpoolFileName := TFDScriptOptions(Source).FSpoolFileName;
    FTiming := TFDScriptOptions(Source).FTiming;
    FBreakOnError := TFDScriptOptions(Source).FBreakOnError;
    FIgnoreError := TFDScriptOptions(Source).FIgnoreError;
    FDropNonexistObj := TFDScriptOptions(Source).FDropNonexistObj;
    FCommandSeparator := TFDScriptOptions(Source).FCommandSeparator;
    FActualCommandSeparator := TFDScriptOptions(Source).FActualCommandSeparator;
    FParamArraySize := TFDScriptOptions(Source).FParamArraySize;
    FPageSize := TFDScriptOptions(Source).FPageSize;
    FEchoCommandTrim := TFDScriptOptions(Source).FEchoCommandTrim;
    FDefaultScriptPath := TFDScriptOptions(Source).FDefaultScriptPath;
    FMacroExpand := TFDScriptOptions(Source).FMacroExpand;
    FTrimConsole := TFDScriptOptions(Source).FTrimConsole;
    FTrimSpool := TFDScriptOptions(Source).FTrimSpool;
    FVerify := TFDScriptOptions(Source).FVerify;
    FDefaultDataPath := TFDScriptOptions(Source).FDefaultDataPath;
    FLineSize := TFDScriptOptions(Source).FLineSize;
    FFileEncoding := TFDScriptOptions(Source).FFileEncoding;
    FFileEndOfLine := TFDScriptOptions(Source).FFileEndOfLine;
    FDriverID := TFDScriptOptions(Source).FDriverID;
    FClientLib := TFDScriptOptions(Source).FClientLib;
    FCharacterSet := TFDScriptOptions(Source).FCharacterSet;
    FSQLDialect := TFDScriptOptions(Source).FSQLDialect;
    FRaisePLSQLErrors := TFDScriptOptions(Source).FRaisePLSQLErrors;
  end
  else
    inherited Assign(Source);
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptOptions.SetCommandSeparator(const AValue: String);
begin
  if FCommandSeparator <> AValue then begin
    FCommandSeparator := AValue;
    FActualCommandSeparator := UpperCase(Trim(AValue));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScriptOptions.SetDriverID(const AValue: String);
begin
  if FDriverID <> AValue then begin
    FDriverID := AValue;
    if (FOwner <> nil) and (FOwner is TFDScript) then
      TFDScript(FOwner).FRDBMSKind := TFDRDBMSKinds.Unknown;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDSQLScript                                                                  }
{-------------------------------------------------------------------------------}
constructor TFDSQLScript.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSQL := TFDStringList.Create;
  TFDStringList(FSQL).TrailingLineBreak := False;
end;

{-------------------------------------------------------------------------------}
destructor TFDSQLScript.Destroy;
begin
  FDFreeAndNil(FSQL);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDSQLScript.GetDisplayName: string;
begin
  if FName <> '' then
    Result := FName
  else
    Result := inherited GetDisplayName;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScript.Assign(ASource: TPersistent);
begin
  if ASource is TFDSQLScript then begin
    FName := TFDSQLScript(ASource).Name;
    FSQL.SetStrings(TFDSQLScript(ASource).SQL);
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScript.SetSQL(const AValue: TStrings);
begin
  FSQL.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
{ TFDSQLScripts                                                                 }
{-------------------------------------------------------------------------------}
constructor TFDSQLScripts.Create(AScript: TFDScript);
begin
  inherited Create(AScript, TFDSQLScript);
end;

{-------------------------------------------------------------------------------}
function TFDSQLScripts.GetItems(AIndex: Integer): TFDSQLScript;
begin
  Result := TFDSQLScript(inherited Items[AIndex]);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLScripts.SetItems(AIndex: Integer;
  const AValue: TFDSQLScript);
begin
  inherited Items[AIndex] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDSQLScripts.Add: TFDSQLScript;
begin
  Result := TFDSQLScript(inherited Add);
end;

{-------------------------------------------------------------------------------}
function TFDSQLScripts.FindScript(const AName: String): TFDSQLScript;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Items[i].Name, AName) = 0 then begin
      Result := Items[i];
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDScript                                                                     }
{-------------------------------------------------------------------------------}
constructor TFDScript.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCallStack := TFDStringList.Create;
  FScriptOptions := TFDScriptOptions.Create(Self);
  FTable := TFDDatSTable.Create;
  FParams := TFDParams.CreateRefCounted(GetParamsOwner);
  FMacros := TFDMacros.CreateRefCounted(GetParamsOwner);
  FArguments := TFDStringList.Create;
  FAllSpools := TFDStringList.Create;
  FPrep := TFDPhysPreprocessor.Create;
  FPrep.MacrosRead := FMacros;
  FPrep.Instrs := [piExpandMacros];
  FSQLScripts := TFDSQLScripts.Create(Self);
  FOptionsIntf := TFDOptionsContainer.Create(Self, TFDFetchOptions,
    TFDBottomUpdateOptions, TFDBottomResourceOptions, GetParentOptions);
  FLock := TCriticalSection.Create;
  FDScriptCommandRegistry();
  if FDIsDesigning(Self) then
    Connection := FDFindDefaultConnection(Self);
end;

{-------------------------------------------------------------------------------}
destructor TFDScript.Destroy;
begin
  CloseSpool;
  Connection := nil;
  FOptionsIntf := nil;
  FDFreeAndNil(FSQLScripts);
  FDFreeAndNil(FCallStack);
  FDFreeAndNil(FScriptOptions);
  FParams.RemRef;
  FParams := nil;
  FMacros.RemRef;
  FMacros := nil;
  FDFreeAndNil(FArguments);
  FDFreeAndNil(FTable);
  FDFreeAndNil(FAllSpools);
  FDFreeAndNil(FPrep);
  FDFreeAndNil(FLock);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetParamsOwner: TPersistent;
begin
  Result := Self;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then
    if FScriptDialog = AComponent then
      ScriptDialog := nil
    else if FConnection = AComponent then
      Connection := nil
    else if FTransaction = AComponent then
      Transaction := nil;
end;

{-------------------------------------------------------------------------------}
// IFDStanObject
function TFDScript.GetName: TComponentName;
begin
  if Name = '' then
    Result := '$' + IntToHex(Integer(Self), 8)
  else
    Result := Name;
  Result := Result + ': ' + ClassName;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetParent: IFDStanObject;
begin
  if FConnection = nil then
    Result := nil
  else
    Result := FConnection as IFDStanObject;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.AfterReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.BeforeReuse;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetOwner(const AOwner: TObject;
  const ARole: TComponentName);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
// IFDStanOptions
procedure TFDScript.GetParentOptions(var AOpts: IFDStanOptions);
begin
  if FConnection <> nil then
    AOpts := FConnection.OptionsIntf;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetFetchOptions: TFDFetchOptions;
begin
  Result := OptionsIntf.FetchOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetFetchOptions(const Value: TFDFetchOptions);
begin
  OptionsIntf.FetchOptions.Assign(Value);
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetFormatOptions: TFDFormatOptions;
begin
  Result := OptionsIntf.FormatOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetFormatOptions(const Value: TFDFormatOptions);
begin
  OptionsIntf.FormatOptions.Assign(Value);
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetResourceOptions: TFDResourceOptions;
begin
  Result := OptionsIntf.ResourceOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetResourceOptions(const Value: TFDResourceOptions);
begin
  OptionsIntf.ResourceOptions.Assign(Value);
end;

{-------------------------------------------------------------------------------}
// IFDStanErrorHandler
procedure TFDScript.HandleException(const AInitiator: IFDStanObject;
  var AException: Exception);
var
  oInit: IFDStanObject;
begin
  oInit := AInitiator;
  if Status in [ssValidating, ssRunning] then begin
    if AInitiator = nil then
      oInit := Self as IFDStanObject;
    if Assigned(FOnError) then
      FOnError(Self, oInit as TObject, AException);
  end;
  if (Connection <> nil) and (AException <> nil) then
    (Connection as IFDStanErrorHandler).HandleException(oInit, AException);
end;

{-------------------------------------------------------------------------------}
// etc
type
  __TFDCustomConnection = class(TFDCustomConnection)
  end;

procedure TFDScript.SetConnection(const AValue: TFDCustomConnection);
begin
  if FConnection <> nil then
    __TFDCustomConnection(FConnection).UnRegisterClient(Self);
  InternalReleaseConnection;
  FConnection := AValue;
  if FConnection <> nil then begin
    __TFDCustomConnection(FConnection).RegisterClient(Self, DoConnectChanged);
    FConnection.FreeNotification(Self);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetTransaction(const AValue: TFDCustomTransaction);
begin
  FTransaction := AValue;
  if FTransaction <> nil then
    FTransaction.FreeNotification(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.DoConnectChanged(Sender: TObject; Connecting: Boolean);
begin
  if not Connecting then
    InternalReleaseConnection;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetSQLScripts(const AValue: TFDSQLScripts);
begin
  FSQLScripts.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetScriptOptions(const AValue: TFDScriptOptions);
begin
  FScriptOptions.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetArguments(const AValue: TStrings);
begin
  FArguments.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetParams(const AValue: TFDParams);
begin
  FParams.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetMacros(const AValue: TFDMacros);
begin
  FMacros.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetScriptDialog(const AValue: TFDGUIxScriptDialog);
begin
  if FScriptDialog <> nil then
    FScriptDialog.RemoveFreeNotification(Self);
  FScriptDialog := AValue;
  if FScriptDialog <> nil then
    FScriptDialog.FreeNotification(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ConGet(const APrompt: String;
  var AResult: String);
var
  oDlg: IFDGUIxScriptDialog;
begin
  if Assigned(FOnConsoleGet) then
    FOnConsoleGet(Self, APrompt, AResult)
  else if GetScriptDialogIntf(oDlg) then
    oDlg.Input(APrompt, AResult);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ConPause(const APrompt: String);
var
  oDlg: IFDGUIxScriptDialog;
begin
  if Assigned(FOnPause) then
    FOnPause(Self, APrompt)
  else if GetScriptDialogIntf(oDlg) then
    oDlg.Pause(APrompt);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ConPut(const AMsg: String; AKind: TFDScriptOutputKind);
var
  sCon: String;
  sSpool: String;
  oDlg: IFDGUIxScriptDialog;
begin
  if ScriptOptions.ConsoleOutput then begin
    if ScriptOptions.TrimConsole then
      sCon := TrimRight(AMsg)
    else
      sCon := AMsg;
    if Assigned(FOnConsolePut) then
      FOnConsolePut(Self, sCon, AKind);
    if GetScriptDialogIntf(oDlg) then
      oDlg.Output(sCon, AKind);
  end;
  if ScriptOptions.SpoolOutput <> smNone then begin
    if ScriptOptions.TrimSpool then
      sSpool := TrimRight(AMsg)
    else
      sSpool := AMsg;
    if Assigned(FOnSpoolPut) then
      FOnSpoolPut(Self, sSpool, AKind);
    if FSpool <> nil then
      FSpool.WriteLine(sSpool);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ConLockUpdate;
begin
  if ScriptOptions.ConsoleOutput then
    if Assigned(FOnConsoleLockUpdate) then
      FOnConsoleLockUpdate(Self, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ConUnlockUpdate;
begin
  if ScriptOptions.ConsoleOutput then
    if Assigned(FOnConsoleLockUpdate) then
      FOnConsoleLockUpdate(Self, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.GetText(const AFileName: String; AMode: TFDScriptTextMode;
  out AText: TFDTextFile);
var
  s: String;
  oSQL: TFDSQLScript;
begin
  AText := nil;
  if Assigned(FOnGetText) then
    FOnGetText(Self, AFileName, AMode, AText);
  if AText = nil then begin
    s := ExpandString(AFileName);
    oSQL := SQLScripts.FindScript(s);
    if oSQL <> nil then
      AText := TFDTextFile.Create(TStringStream.Create(oSQL.SQL.Text,
        TEncoding.Unicode), True, True, False, ecUTF16, elWindows)
    else if AMode in [smWriteReset, smWriteAppend] then begin
      if ExtractFileExt(s) = '' then
        s := s + '.log';
      AText := TFDTextFile.Create(s, False, AMode = smWriteAppend,
        ScriptOptions.FileEncoding, ScriptOptions.FileEndOfLine);
    end
    else begin
      if not FileExists(s) and (ExtractFileExt(s) = '') then
        s := s + '.sql';
      if (ExtractFilePath(s) = '') and (ScriptOptions.DefaultScriptPath <> '') then
        s := FDNormPath(ScriptOptions.DefaultScriptPath) + s;
      AText := TFDTextFile.Create(s, True, False,
        ScriptOptions.FileEncoding, ScriptOptions.FileEndOfLine);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ReleaseText(const AFileName: String; AMode: TFDScriptTextMode;
  var AText: TFDTextFile);
var
  s: String;
  oSQL: TFDSQLScript;
begin
  if AText = nil then
    Exit;
  if AMode in [smWriteReset, smWriteAppend] then begin
    s := ExpandString(AFileName);
    oSQL := SQLScripts.FindScript(s);
    if oSQL <> nil then begin
      AText.Position := 0;
      oSQL.SQL.LoadFromStream(AText.Stream, TEncoding.Unicode);
    end;
  end;
  if Assigned(FOnReleaseText) then
    FOnReleaseText(Self, AFileName, AMode, AText);
  if AText <> nil then
    FDFreeAndNil(AText);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ExecuteHostCommand(const ACommand: String);
var
  lDefault: Boolean;
begin
  if Assigned(FOnHostCommand) then begin
    lDefault := False;
    FOnHostCommand(Self, ACommand, lDefault);
  end
  else
    lDefault := True;
  if lDefault then
    FDShell(ACommand, S_FD_LComp_PScr);
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetCallStack: TStrings;
var
  oCmd: TFDScriptCommand;
begin
  FCallStack.Clear;
  FLock.Enter;
  try
    oCmd := FCurrentCommand;
    while oCmd <> nil do begin
      FCallStack.Insert(0, Format('%s (line %d)',
        [oCmd.Parser.FileName, oCmd.Parser.LineNumber]));
      oCmd := oCmd.Parser.ParentCommand;
    end;
  finally
    FLock.Leave;
  end;
  Result := FCallStack;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetScriptDialogIntf(out AIntf: IFDGUIxScriptDialog): Boolean;
begin
  Result := FScriptDialogVisible and (FScriptDialog <> nil);
  if Result then
    AIntf := FScriptDialog as IFDGUIxScriptDialog;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetTotalErrors: Integer;
begin
  Result := FTotalErrors;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetTotalJobDone: Integer;
begin
  Result := FTotalJobDone;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetTotalJobSize: Integer;
begin
  Result := FTotalJobSize;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetTotalPct10Done: Integer;
begin
  Result := FTotalPct10Done;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetIsRunning: Boolean;
begin
  Result := FStatus in [ssValidating, ssRunning];
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.RequestStop;
begin
  AbortJob();
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.SetCurrentCommand(const ACommand: TFDScriptCommand);
var
  iPct10Done: Integer;
begin
  FLock.Enter;
  try
    if (ACommand <> nil) and (ACommand.Parser <> nil) then
      FTotalJobDone := ACommand.Parser.TotalSize
    else if (FCurrentCommand <> nil) and (FCurrentCommand.Parser <> nil) then
      FTotalJobDone := FCurrentCommand.Parser.TotalSize;
    FCurrentCommand := ACommand;
  finally
    FLock.Leave;
  end;
  if FTotalJobSize = 0 then begin
    if ACommand <> nil then begin
      Inc(FTotalPct10Done);
      Progress;
      if FTotalPct10Done >= 1000 then
        FTotalPct10Done := 0;
    end;
  end
  else begin
    iPct10Done := Integer((Int64(FTotalJobDone) * Int64(1000)) div Int64(FTotalJobSize));
    if FTotalPct10Done <> iPct10Done then begin
      FTotalPct10Done := iPct10Done;
      Progress;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.UpdateCommandSeparator;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  if ScriptOptions.CommandSeparator = '' then
    if FConnectionIntf <> nil then begin
      FConnectionIntf.CreateMetadata(oConnMeta);
      ScriptOptions.FActualCommandSeparator := UpperCase(Trim(oConnMeta.CommandSeparator));
    end
    else
      ScriptOptions.FActualCommandSeparator := ';';
end;

{-------------------------------------------------------------------------------}
{$HINTS OFF}
function TFDScript.SetupArguments: TStrings;
var
  i, iName, iCode: Integer;
  oMac: TFDMacro;
begin
  Result := TFDStringList.Create;
  i := 0;
  while i <= Macros.Count - 1 do begin
    Val(Macros[i].Name, iName, iCode);
    if iCode = 0 then begin
      Result.Add(Macros[i].Name + '=' + Macros[i].AsRaw);
      FDFree(Macros[i]);
    end
    else
      Inc(i);
  end;
  for i := 0 to Arguments.Count - 1 do begin
    oMac := Macros.Add;
    oMac.Name := IntToStr(i + 1);
    oMac.AsRaw := Arguments[i];
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.RestoreArguments(AArgs: TStrings);
var
  i, iName, iCode: Integer;
  oMac: TFDMacro;
begin
  i := 0;
  while i <= Macros.Count - 1 do begin
    Val(Macros[i].Name, iName, iCode);
    if iCode = 0 then
      FDFree(Macros[i])
    else
      Inc(i);
  end;
  for i := 0 to AArgs.Count - 1 do begin
    oMac := Macros.Add;
    oMac.Name := AArgs.KeyNames[i];
    oMac.AsRaw := AArgs.ValueFromIndex[i];
  end;
  FDFree(AArgs);
end;
{$HINTS ON}

{-------------------------------------------------------------------------------}
function TFDScript.InternalExecute(AParser: TFDScriptParser;
  ARealExecute: Boolean; AAll: Boolean): Boolean;
var
  oCmd: TFDScriptCommand;
  dwStartTime: DWORD;
  dwExecTime: DWORD;
  sFeedback: String;
  iStartErrors: Integer;
  iExecErrors: Integer;
  i: Integer;
  oPrevArgs: TStrings;
  oDlg: IFDGUIxScriptDialog;
  oSaveOpts: TFDScriptOptions;
begin
  if AAll and Assigned(FBeforeScript) then
    FBeforeScript(Self);
  if (FDScriptCommandRegistry().FCommands.Count = 0) or
     (FDScriptCommandRegistry().FDefaultSQLCommandClass = nil) or
     (FDScriptCommandRegistry().FDefaultPLSQLCommandClass = nil) then
    FDException(Self, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrNoCmds, []);
  oSaveOpts := nil;
  if AParser.ParentCommand = nil then begin
    Finished := False;
    if ARealExecute then
      FStatus := ssRunning
    else
      FStatus := ssValidating;
    if AAll and ARealExecute then begin
      FAllSpools.Clear;
      ProcessedAfterCommit := 0;
    end;
    FTotalJobDone := 0;
    if not ARealExecute then
      FTotalJobSize := 0;
    FTotalErrors := 0;
    if (Connection <> nil) and Connection.Connected then
      CheckCommand
    else
      UpdateCommandSeparator;
    FScriptDialogVisible := False;
    if AAll and (FScriptDialog <> nil) then begin
      oDlg := FScriptDialog as IFDGUIxScriptDialog;
      oDlg.Show;
      FScriptDialogVisible := True;
    end;
    if AAll then begin
      oSaveOpts := TFDScriptOptions.Create(Self);
      oSaveOpts.Assign(ScriptOptions);
    end;
  end;
  Progress;
  oPrevArgs := SetupArguments;
  if AAll and ARealExecute then
    UpdateSpool;
  if AAll and ARealExecute and ScriptOptions.FeedbackScript and (AParser.FileName <> '') then
    ConPut('Running script [' + AParser.FileName + '] ...', soScript);
  dwStartTime := TThread.GetTickCount();
  iStartErrors := FTotalErrors;
  try
    try
      while not Finished do begin
        oCmd := nil;
        try
          try
            oCmd := AParser.ExtractCommand(Self);
            if oCmd = nil then
              Break
            else if not Finished then
              if ARealExecute then
                oCmd.Execute()
              else
                oCmd.Validate();
          except
            on E: Exception do begin
              if not ScriptOptions.IgnoreError then begin
                Inc(FTotalErrors);
                if E is EFDDBEngineException then
                  for i := 0 to EFDDBEngineException(E).ErrorCount - 1 do
                    if i = 0 then
                      ConPut('ERROR: ' + EFDDBEngineException(E).Errors[i].Message, soError)
                    else
                      ConPut(EFDDBEngineException(E).Errors[i].Message, soError)
                else
                  ConPut('ERROR: ' + E.Message, soError);
                if ScriptOptions.BreakOnError then
                  Finished := True;
                if not AAll or ScriptOptions.BreakOnError then
                  raise;
              end;
            end;
          end;
        finally
          FDFree(oCmd);
        end;
        if not AAll then
          Finished := True;
      end;
    except
      if FStatus in [ssRunning, ssValidating] then
        FStatus := ssFinishWithErrors;
      raise;
    end;
  finally
    if AAll and ARealExecute then
      CheckCommit(True);
    dwExecTime := TThread.GetTickCount() - dwStartTime;
    iExecErrors := FTotalErrors - iStartErrors;
    Result := iExecErrors = 0;
    RestoreArguments(oPrevArgs);
    if AAll and ARealExecute and ScriptOptions.FeedbackScript and (AParser.FileName <> '') then begin
      sFeedback := 'Script [' + AParser.FileName + '] finished';
      if iExecErrors = 0 then
        sFeedback := sFeedback + ' without errors'
      else if iExecErrors = 1 then
        sFeedback := sFeedback + ' with [1] error'
      else
        sFeedback := sFeedback + ' with [' + IntToStr(iExecErrors) + '] errors';
      if ScriptOptions.Timing then
        sFeedback := sFeedback + Format(' [%.2d:%.2d:%.2d.%.3d]', [
          (dwExecTime div 3600000) mod 60, (dwExecTime div 60000) mod 60,
          (dwExecTime div 1000) mod 60, dwExecTime mod 1000]);
      sFeedback := sFeedback + '.';
      ConPut(sFeedback, soScript);
      ConPut('', soSeparator);
    end;
    if AParser.ParentCommand = nil then begin
      Finished := True;
      if FStatus in [ssRunning, ssValidating] then
        if FTotalErrors = 0 then
          FStatus := ssFinishSuccess
        else
          FStatus := ssFinishWithErrors;
      if not ARealExecute then begin
        FTotalJobSize := AParser.TotalSize;
        FTotalPct10Done := 1000;
      end;
      if AAll then
        CloseSpool;
      Progress;
      if GetScriptDialogIntf(oDlg) then
        oDlg.Hide;
      if AAll then begin
        ScriptOptions.Assign(oSaveOpts);
        FDFree(oSaveOpts);
      end;
      if AAll and Assigned(FAfterScript) then
        FAfterScript(Self);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDScript.InternalExecute(ARealExecute: Boolean; AAll: Boolean): Boolean;
var
  oText: TFDTextFile;
  oParser: TFDScriptParser;
  oWait: IFDGUIxWaitCursor;
  sName: String;
  lUsePosition: Boolean;
begin
  if Assigned(FBeforeExecute) then
    FBeforeExecute(Self);
  if not FDGUIxSilent then begin
    FDCreateInterface(IFDGUIxWaitCursor, oWait);
    oWait.StartWait;
  end;
  try
    if Connection = nil then
      FDException(Self, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ClntDbNotDefined, [Name]);
    FRDBMSKind := TFDRDBMSKinds.Unknown;
    lUsePosition := False;
    if SQLScriptFileName <> '' then begin
      sName := SQLScriptFileName;
      GetText(SQLScriptFileName, smRead, oText);
    end
    else if SQLScripts.Count > 0 then begin
      sName := SQLScripts[0].Name;
      GetText(sName, smRead, oText);
      lUsePosition := not AAll;
    end
    else
      FDException(Self, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrNoScript, [Name]);
    try
      oParser := TFDScriptParser.Create(sName, nil, oText, ScriptOptions);
      try
        if lUsePosition then
          oParser.Position := FPosition;
        Result := InternalExecute(oParser, ARealExecute, AAll);
      finally
        if lUsePosition then
          FPosition := oParser.Position;
        FDFree(oParser);
      end;
    finally
      ReleaseText(sName, smRead, oText);
    end;
  finally
    if not FDGUIxSilent then
      oWait.StopWait;
    if Assigned(FAfterExecute) then
      FAfterExecute(Self);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDScript.ExecuteAll: Boolean;
begin
  Result := InternalExecute(True, True);
end;

{-------------------------------------------------------------------------------}
function TFDScript.ExecuteStep: Boolean;
begin
  Result := InternalExecute(True, False);
end;

{-------------------------------------------------------------------------------}
function TFDScript.ValidateAll: Boolean;
begin
  Result := InternalExecute(False, True);
end;

{-------------------------------------------------------------------------------}
function TFDScript.ValidateStep: Boolean;
begin
  Result := InternalExecute(False, False);
end;

{-------------------------------------------------------------------------------}
function TFDScript.ExecuteAll(AParser: TFDScriptParser): Boolean;
begin
  Result := InternalExecute(AParser, True, True);
end;

{-------------------------------------------------------------------------------}
function TFDScript.ExecuteStep(AParser: TFDScriptParser): Boolean;
begin
  Result := InternalExecute(AParser, True, False);
end;

{-------------------------------------------------------------------------------}
function TFDScript.ValidateAll(AParser: TFDScriptParser): Boolean;
begin
  Result := InternalExecute(AParser, False, True);
end;

{-------------------------------------------------------------------------------}
function TFDScript.ValidateStep(AParser: TFDScriptParser): Boolean;
begin
  Result := InternalExecute(AParser, False, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ExecuteFile(const AFileName: String);
begin
  SQLScripts.Clear;
  SQLScriptFileName := AFileName;
  ValidateAll;
  if Status = ssFinishSuccess then
    ExecuteAll;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ExecuteFile(const AFileName: String; const AArguments: array of String);
var
  i: Integer;
begin
  Arguments.Clear;
  for i := Low(AArguments) to High(AArguments) do
    Arguments.Add(AArguments[i]);
  ExecuteFile(AFileName);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ExecuteScript(const AScript: TStrings);
begin
  SQLScripts.Clear;
  SQLScripts.Add.SQL := AScript;
  SQLScriptFileName := '';
  ValidateAll;
  if Status = ssFinishSuccess then
    ExecuteAll;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.ExecuteScript(const AScript: TStrings; const AArguments: array of String);
var
  i: Integer;
begin
  Arguments.Clear;
  for i := Low(AArguments) to High(AArguments) do
    Arguments.Add(AArguments[i]);
  ExecuteScript(AScript);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.AbortJob(const AWait: Boolean = False);
begin
  if FStatus in [ssValidating, ssRunning] then
    FStatus := ssAborted;
  Finished := True;
  if FCommandIntf <> nil then
    FCommandIntf.AbortJob(AWait);
  if CurrentCommand <> nil then
    CurrentCommand.AbortJob(AWait);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.Progress;
var
  oDlg: IFDGUIxScriptDialog;
begin
  if Assigned(FOnProgress) then
    FOnProgress(Self);
  if GetScriptDialogIntf(oDlg) then
    oDlg.Progress(Self as IFDGUIxScriptDialogInfoProvider);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.CloseSpool;
begin
  if ScriptOptions.SpoolOutput = smOnReset then
    ReleaseText(FLastSpoolFileName, smWriteReset, FSpool)
  else
    ReleaseText(FLastSpoolFileName, smWriteAppend, FSpool);
  FLastSpoolFileName := '';
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.UpdateSpool;
begin
  if ScriptOptions.SpoolOutput = smNone then
    CloseSpool
  else begin
    if ScriptOptions.SpoolFileName <> FLastSpoolFileName then
      CloseSpool;
    if (FSpool = nil) and (ScriptOptions.SpoolFileName <> '') then begin
      if ScriptOptions.SpoolOutput = smOnReset then
        GetText(ScriptOptions.SpoolFileName, smWriteReset, FSpool)
      else
        GetText(ScriptOptions.SpoolFileName, smWriteAppend, FSpool);
      FLastSpoolFileName := ScriptOptions.SpoolFileName;
      FAllSpools.Add(FLastSpoolFileName);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.CheckCommand;
begin
  if (FConnectionIntf = nil) or (FConnectionIntf.State <> csConnected) then
    OpenConnection('');
  if (FConnectionIntf = nil) or (FConnectionIntf.State <> csConnected) then
    FDException(Self, [S_FD_LComp, S_FD_LComp_PScr], er_FD_ScrNotLogged, []);
  ASSERT(FCommandIntf <> nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.CheckCommit(AForce: Boolean);
begin
  if ScriptOptions.CommitEachNCommands > 0 then begin
    ProcessedAfterCommit := ProcessedAfterCommit + 1;
    if AForce or (ProcessedAfterCommit >= ScriptOptions.CommitEachNCommands) then begin
      if Transaction <> nil then
        Transaction.Commit
      else
        FConnectionIntf.Transaction.Commit;
      ProcessedAfterCommit := 0;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.CheckStartTransaction;
begin
  if (ScriptOptions.CommitEachNCommands > 0) and (ProcessedAfterCommit = 0) and
     ((Transaction <> nil) and not Transaction.Active or
      (Transaction = nil) and not FConnectionIntf.Transaction.Active) then
    if Transaction <> nil then
      Transaction.StartTransaction
    else
      FConnectionIntf.Transaction.StartTransaction;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.InternalOpenConnection(const AConnectionString: String);
var
  sConnStr: String;
  oObjIntf: IFDStanObject;
  oConnMeta: IFDPhysConnectionMetadata;
  oDef: IFDStanDefinition;
begin
  if AConnectionString <> '' then begin
    sConnStr := AConnectionString;
    if ScriptOptions.DriverID <> '' then
      sConnStr := S_FD_ConnParam_Common_DriverID + '=' +
        ScriptOptions.DriverID + ';' + sConnStr;
    Connection.Close;
    Connection.ResultConnectionDef.Params.Clear;
    Connection.ResultConnectionDef.ParseString(sConnStr);
  end;
  if ScriptOptions.ClientLib <> '' then begin
    Connection.CheckConnectionDef;
                                                                                         
    oDef := FDPhysManager.DriverDefs.FindDefinition(Connection.Params.DriverID);
    if oDef = nil then begin
      oDef := FDPhysManager.DriverDefs.Add;
      oDef.Name := Connection.Params.DriverID;
    end;
    oDef.AsString[S_FD_DrvVendorLib] := ScriptOptions.ClientLib;
  end;
  if ScriptOptions.CharacterSet <> '' then
    Connection.ResultConnectionDef.AsString[S_FD_ConnParam_Common_CharacterSet] :=
      ScriptOptions.CharacterSet;
  if ScriptOptions.SQLDialect > 0 then
    Connection.ResultConnectionDef.AsInteger[S_FD_ConnParam_IB_SQLDialect] :=
      ScriptOptions.SQLDialect;
  Connection.Open;
  FConnectionIntf := FConnection.ConnectionIntf;
  FConnectionIntf.ErrorHandler := Self as IFDStanErrorHandler;
  FConnectionIntf.CreateCommand(FCommandIntf);
  if Transaction <> nil then
    FCommandIntf.Transaction := Transaction.TransactionIntf;
  FCommandIntf.Options := Self as IFDStanOptions;
  FCommandIntf.Macros := FMacros;
  FCommandIntf.ErrorHandler := Self as IFDStanErrorHandler;
  FConnectionIntf.CreateMetadata(oConnMeta);
  FPrep.ConnMetadata := oConnMeta;
  if Supports(FCommandIntf, IFDStanObject, oObjIntf) then begin
    oObjIntf.SetOwner(Self, '');
    oObjIntf := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.OpenConnection(const AConnectionString: String);
const
  C_UROWID = '_ora_UROWID';
var
  oURIMac: TFDMacro;
  oCmd: IFDPhysCommand;
begin
  InternalOpenConnection(AConnectionString);
  // This is needed for FireDAC QA scripts. Depending on Oracle version
  // in CREATE TABLE will be used either UROWID data type, either ROWID.
  if GetRDBMSKind = TFDRDBMSKinds.Oracle then begin
    oURIMac := Macros.FindMacro(C_UROWID);
    if oURIMac = nil then begin
      oURIMac := Macros.Add;
      oURIMac.Name := C_UROWID;
    end;
    try
      FConnectionIntf.CreateCommand(oCmd);
      if Transaction <> nil then
        oCmd.Transaction := Transaction.TransactionIntf;
      oCmd.Prepare('declare r urowid; begin null; end;');
      oCmd.Execute;
      oURIMac.AsRaw := 'UROWID'
    except
      oURIMac.AsRaw := 'ROWID';
    end;
  end;
  UpdateCommandSeparator;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.InternalReleaseConnection;
begin
  if FCommandIntf <> nil then begin
    FCommandIntf.AbortJob(False);
    FCommandIntf.Disconnect;
    FCommandIntf.Options := nil;
    FCommandIntf.Params := nil;
    FCommandIntf.Macros := nil;
    FCommandIntf := nil;
  end;
  if FPrep <> nil then
    FPrep.ConnMetadata := nil;
  if FConnectionIntf <> nil then
    if FConnection <> nil then
      FConnectionIntf.ErrorHandler := FConnection as IFDStanErrorHandler
    else
      FConnectionIntf.ErrorHandler := nil;
  FConnectionIntf := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.CloseConnection;
begin
  InternalReleaseConnection;
  FConnection.Close;
end;

{-------------------------------------------------------------------------------}
procedure TFDScript.Disconnect(AAbortJob: Boolean = False);
begin
  if AAbortJob then
    AbortJob(True);
  InternalReleaseConnection;
end;

{-------------------------------------------------------------------------------}
function TFDScript.ExpandString(const AValue: String): String;
begin
  if ScriptOptions.MacroExpand then begin
    FPrep.Source := AnsiQuotedStr(AValue, '''');
    FPrep.Init;
    FPrep.Execute;
    Result := AnsiDequotedStr(FPrep.Destination, '''');
  end
  else
    Result := AValue;
  Result := FDExpandStr(Result);
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetRDBMSKind: TFDRDBMSKind;
begin
  if FRDBMSKind = TFDRDBMSKinds.Unknown then begin
    if (ScriptOptions.DriverID <> '') and ((Connection = nil) or not Connection.Connected) then
      FRDBMSKind := FDManager.GetRDBMSKind(ScriptOptions.DriverID)
    else if Connection <> nil then
      FRDBMSKind := Connection.RDBMSKind;
  end;
  Result := FRDBMSKind;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetTable: TFDDatSTable;
begin
  Result := FTable;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetCommandIntf: IFDPhysCommand;
begin
  Result := FCommandIntf;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetConnectionIntf: IFDPhysConnection;
begin
  Result := FConnectionIntf;
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetEof: Boolean;
begin
  Result := (SQLScripts.Count = 0) or
    (FPosition.Y > SQLScripts[0].SQL.Count - 1) or
    (FPosition.Y = SQLScripts[0].SQL.Count - 1) and
      (FPosition.X >= Length(SQLScripts[0].SQL[FPosition.Y]));
end;

{-------------------------------------------------------------------------------}
function TFDScript.GetIsEmpty: Boolean;
begin
  Result := (SQLScripts.Count = 0) or (SQLScripts[0].SQL.Count = 0);
end;

{-------------------------------------------------------------------------------}
initialization

finalization
  FDFreeAndNil(FScriptCommandRegistry);

end.
