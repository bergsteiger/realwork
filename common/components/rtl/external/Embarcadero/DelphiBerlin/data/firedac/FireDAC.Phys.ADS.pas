{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{       FireDAC Advantage Database Server driver        }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$IF DEFINED(IOS) OR DEFINED(ANDROID)}
  {$HPPEMIT LINKUNIT}
{$ELSE}
  {$IFDEF WIN32}
    {$HPPEMIT '#pragma link "FireDAC.Phys.ADS.obj"'}
  {$ELSE}
    {$HPPEMIT '#pragma link "FireDAC.Phys.ADS.o"'}
  {$ENDIF}
{$ENDIF}

                          

unit FireDAC.Phys.ADS;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.ADSWrapper;

type
  TFDPhysADSDriverLink = class;
  TFDADSService = class;
  TFDADSBackupRestore = class;
  TFDADSBackup = class;
  TFDADSRestore = class;
  TFDADSUtility = class;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidLinux64)]
  TFDPhysADSDriverLink = class(TFDPhysDriverLink)
  private
    FDateFormat: String;
    FDecimals: Integer;
    FDefaultPath: String;
    FSearchPath: String;
    FShowDeleted: Boolean;
    FEpoch: Word;
    FExact: Boolean;
    function GetDateFormat: String;
    function GetDecimals: Word;
    function GetDefaultPath: String;
    function GetEpoch: Word;
    function GetExact: Boolean;
    function GetSearchPath: String;
    function GetShowDeleted: Boolean;
    procedure SetDateFormat(const AValue: String);
    procedure SetDecimals(const AValue: Word);
    procedure SetDefaultPath(const AValue: String);
    procedure SetEpoch(const AValue: Word);
    procedure SetExact(const AValue: Boolean);
    procedure SetSearchPath(const AValue: String);
    procedure SetShowDeleted(const AValue: Boolean);
    function IsDFS: Boolean;
    function IsDS: Boolean;
    function IsDPS: Boolean;
    function IsEpS: Boolean;
    function IsExS: Boolean;
    function IsSDS: Boolean;
    function IsSPS: Boolean;
  protected
    function GetBaseDriverID: String; override;
    function IsConfigured: Boolean; override;
    procedure ApplyTo(const AParams: IFDStanDefinition); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property DateFormat: String read GetDateFormat write SetDateFormat stored IsDFS;
    property Decimals: Word read GetDecimals write SetDecimals stored IsDS;
    property DefaultPath: String read GetDefaultPath write SetDefaultPath stored IsDPS;
    property SearchPath: String read GetSearchPath write SetSearchPath stored IsSPS;
    property ShowDeleted: Boolean read GetShowDeleted write SetShowDeleted stored IsSDS;
    property Epoch: Word read GetEpoch write SetEpoch stored IsEpS;
    property Exact: Boolean read GetExact write SetExact stored IsExS;
  end;

  TFDADSService = class (TFDPhysDriverService)
  private
    FPassword: String;
    FUserName: String;
    FDatabase: String;
    function GetDriverLink: TFDPhysADSDriverLink;
    procedure SetDriverLink(const AValue: TFDPhysADSDriverLink);
    procedure GetConnection(out AConn: IFDPhysConnection; out ACmd: IFDPhysCommand);
  protected
    function GetConnectionString: String; virtual;
  published
    property DriverLink: TFDPhysADSDriverLink read GetDriverLink write SetDriverLink;
    property Database: String read FDatabase write FDatabase;
    property UserName: String read FUserName write FUserName;
    property Password: String read FPassword write FPassword;
  end;

  TFDADSBackupRestore = class(TFDADSService)
  private
    FInclude: TStrings;
    FExclude: TStrings;
    FTableTypeMap: TStrings;
    FResults: TFDDatSTable;
    FArchiveFile: String;
    procedure SetInclude(const AValue: TStrings);
    procedure SetExclude(const AValue: TStrings);
    procedure SetTableTypeMap(const AValue: TStrings);
    class procedure AddOption(var AStr: String; const AName, AValue: String); static;
  protected
    function GetOptions: String; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Results: TFDDatSTable read FResults;
  published
    property Include: TStrings read FInclude write SetInclude;
    property Exclude: TStrings read FExclude write SetExclude;
    property TableTypeMap: TStrings read FTableTypeMap write SetTableTypeMap;
    property ArchiveFile: String read FArchiveFile write FArchiveFile;
  end;

  TFDADSBackupOptions = set of (boMetaOnly, boPrepareDiff, boDiff,
    boCompressArchive);
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidLinux64)]
  TFDADSBackup = class(TFDADSBackupRestore)
  private
    FBackupPath: String;
    FOptions: TFDADSBackupOptions;
  protected
    procedure InternalExecute; override;
    function GetOptions: String; override;
  public
    procedure Backup;
  published
    property BackupPath: String read FBackupPath write FBackupPath;
    property Options: TFDADSBackupOptions read FOptions write FOptions default [];
  end;

  TFDADSRestoreOptions = set of (roDontOverwrite, roMetaOnly, roNoWarnings,
    roCompressedArchive, roForceArchiveExtract);
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidLinux64)]
  TFDADSRestore = class(TFDADSBackupRestore)
  private
    FSourcePath: String;
    FSourcePassword: String;
    FDestinationPath: String;
    FDDPassword: String;
    FOptions: TFDADSRestoreOptions;
  protected
    procedure InternalExecute; override;
    function GetOptions: String; override;
  public
    procedure Restore;
  published
    property SourcePath: String read FSourcePath write FSourcePath;
    property SourcePassword: String read FSourcePassword write FSourcePassword;
    property DestinationPath: String read FDestinationPath write FDestinationPath;
    property DDPassword: String read FDDPassword write FDDPassword;
    property Options: TFDADSRestoreOptions read FOptions write FOptions default [];
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidLinux64)]
  TFDADSUtility = class(TFDADSService)
  private type
    TMode = (umEncrypt, umDecrypt, umPack, umZap, umReindex, umRecall);
  private
    FTables: TStrings;
    FMode: TMode;
    FOnProgress: TFDPhysServiceProgressEvent;
    FTableType: TADSTableType;
    FTablePassword: String;
    procedure SetTables(const AValue: TStrings);
  protected
    function GetConnectionString: String; override;
    procedure InternalExecute; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Encrypt;
    procedure Decrypt;
    procedure Pack;
    procedure Zap;
    procedure Reindex;
    procedure Recall;
  published
    property Tables: TStrings read FTables write SetTables;
    property TableType: TADSTableType read FTableType write FTableType default ttDefault;
    property TablePassword: String read FTablePassword write FTablePassword;
    property OnProgress: TFDPhysServiceProgressEvent read FOnProgress write FOnProgress;
  end;

{-------------------------------------------------------------------------------}
implementation

uses
  System.Variants, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.Error, FireDAC.Stan.Util, FireDAC.Stan.Option, 
    FireDAC.Stan.Param, FireDAC.Stan.Factory, FireDAC.Stan.ResStrs,
  FireDAC.Phys.SQLGenerator, FireDAC.Phys.ADSCli, FireDAC.Phys.ADSMeta,
    FireDAC.Phys.ADSDef;

type
  TFDPhysADSDriver = class;
  TFDPhysADSConnection = class;
  TFDPhysADSTransaction = class;
  TFDPhysADSEventAlerter = class;
  TFDPhysADSCommand = class;

  TFDPhysADSCliHandles = array [0..0] of NativeUInt;
  PFDPhysADSCliHandles = ^TFDPhysADSCliHandles;

  TFDPhysADSDriver = class(TFDPhysDriver)
  private
    FLib: TADSLib;
  protected
    class function GetBaseDriverID: String; override;
    class function GetBaseDriverDesc: String; override;
    class function GetRDBMSKind: TFDRDBMSKind; override;
    class function GetConnectionDefParamsClass: TFDConnectionDefParamsClass; override;
    procedure InternalLoad; override;
    procedure InternalUnload; override;
    function InternalCreateConnection(AConnHost: TFDPhysConnectionHost): TFDPhysConnection; override;
    function GetCliObj: Pointer; override;
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable; override;
  public
    constructor Create(AManager: TFDPhysManager; const ADriverDef: IFDStanDefinition); override;
    destructor Destroy; override;
  end;

  TFDPhysADSConnection = class (TFDPhysConnection)
  private
    FConnection: TADSConnection;
    FDictionary: TADSDictionary;
    FServerVersion: TFDVersion;
    FCliHandles: TFDPhysADSCliHandles;
    FAliasPath: String;
    FAliasTableType: String;
    FTablePasswords: TStrings;
    function BuildServerTypes(const AConnDef: IFDStanConnectionDef): Integer;
    function BuildConnectionPath(const AConnDef: IFDStanConnectionDef): String;
    function Build60Options(const AConnDef: IFDStanConnectionDef): Integer;
    function BuildADS101ConnectString(const AConnDef: IFDStanConnectionDef): String;
    procedure BaseConnect(AConn: TADSConnection; const AConnDef: IFDStanConnectionDef);
    procedure LoadPasswords;
  protected
    procedure InternalConnect; override;
    procedure InternalSetMeta; override;
    procedure InternalDisconnect; override;
    procedure InternalPing; override;
    procedure InternalChangePassword(const AUserName, AOldPassword, ANewPassword: String); override;
    function InternalCreateTransaction: TFDPhysTransaction; override;
    function InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter; override;
    function InternalCreateCommand: TFDPhysCommand; override;
    function InternalCreateMetadata: TObject; override;
    function InternalCreateCommandGenerator(const ACommand: IFDPhysCommand): TFDPhysCommandGenerator; override;
{$IFDEF FireDAC_MONITOR}
    procedure InternalTracingChanged; override;
{$ENDIF}
    procedure InternalExecuteDirect(const ASQL: String; ATransaction: TFDPhysTransaction); override;
    procedure GetItem(AIndex: Integer; out AName: String;
      out AValue: Variant; out AKind: TFDMoniAdapterItemKind); override;
    function GetItemCount: Integer; override;
    function GetMessages: EFDDBEngineException; override;
    function GetCliObj: Pointer; override;
    function InternalGetCliHandle: Pointer; override;
    function GetLastAutoGenValue(const AName: String): Variant; override;
    procedure InternalAnalyzeSession(AMessages: TStrings); override;
  public
    constructor Create(ADriverObj: TFDPhysDriver; AConnHost: TFDPhysConnectionHost); override;
    destructor Destroy; override;
  end;

  TFDPhysADSTransaction = class(TFDPhysTransaction)
  protected
    procedure InternalStartTransaction(ATxID: LongWord); override;
    procedure InternalCommit(ATxID: LongWord); override;
    procedure InternalRollback(ATxID: LongWord); override;
    procedure InternalChanged; override;
    procedure InternalCheckState(ACommandObj: TFDPhysCommand; ASuccess: Boolean); override;
    procedure InternalNotify(ANotification: TFDPhysTxNotification; ACommandObj: TFDPhysCommand); override;
  end;

  TFDPhysADSEventAlerter = class(TFDPhysEventAlerter)
  private
    FWaitThread: TThread;
    FWaitConnection: IFDPhysConnection;
    FWaitCommand: IFDPhysCommand;
    FTab: TFDDatSTable;
    procedure DoFired;
  protected
    // TFDPhysEventAlerter
    procedure InternalAllocHandle; override;
    procedure InternalRegister; override;
    procedure InternalHandle(AEventMessage: TFDPhysEventMessage); override;
    procedure InternalAbortJob; override;
    procedure InternalUnregister; override;
    procedure InternalReleaseHandle; override;
    procedure InternalSignal(const AEvent: String; const AArgument: Variant); override;
  end;

  PFDAdsParInfoRec = ^TFDAdsParInfoRec;
  PFDAdsColInfoRec = ^TFDAdsColInfoRec;

  TFDAdsParInfoRec = record
    FAdsParamIndex: Integer;
    FParamIndex: Integer;
    FOutSQLDataType: Word;
    FDestDataType: TFDDataType;
    FSrcDataType: TFDDataType;
    FOutDataType: TFDDataType;
    FSrcFieldType: TFieldType;
    FSrcSize: LongWord;
    FSrcPrec: Integer;
    FSrcScale: Integer;
    FParamType: TParamType;
  end;

  TFDAdsColInfoRec = record
    FName: String;
    FPos: Integer;
    FLen: LongWord;
    FPrec,
    FScale: Integer;
    FSrcSQLDataType,
    FSrcSQLMemoType: Word;
    FSrcDataType,
    FDestDataType: TFDDataType;
    FAttrs: TFDDataAttributes;
    FVar: TADSVariable;
    FADLen: LongWord;
    FInPK: WordBool;
  end;

  TFDPhysADSCommand = class(TFDPhysCommand)
  private
    FStmt: TADSStatement;
    FCursor: TADSCursor;
    FParInfos: array of TFDAdsParInfoRec;
    FColInfos: array of TFDAdsColInfoRec;
    FColIndex: Integer;
    FMetainfoAddonView: TFDDatSView;
    FMetaEncoder: TFDEncoder;
    FPasswordsSet: Boolean;
    function GetConnection: TFDPhysADSConnection;
    function UseExecDirect: Boolean;
    procedure SetupStatementBeforePrepare(AStmt: TADSStatement);
    procedure SetupStatementBeforeExecute(AStmt: TADSStatement);
    procedure SetupCursor(ACrs: TADSCursor);
    function FDType2SQL(AType: TFDDataType; AFixedLen: Boolean): Word;
    procedure SQL2ADColInfo(ASQLType, ASQLMemoType: Word; ASQLLen: LongWord; ASQLPrec,
      ASQLScale: Word; out AType: TFDDataType; var AAttrs: TFDDataAttributes;
      out ALen: LongWord; out APrec, AScale: Integer;
      AFmtOpts: TFDFormatOptions);
    procedure CreateParamInfos;
    procedure DestroyParamInfos;
    procedure CreateColInfos;
    procedure DestroyColInfos;
    procedure SetParamValue(AFmtOpts: TFDFormatOptions; AParam: TFDParam;
      AAdsParam: TADSVariable; ApInfo: PFDAdsParInfoRec; AParIndex: Integer);
    procedure SetParamValues(AParIndex: Integer = 0);
    procedure FetchRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
    function FetchMetaRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowNo: Integer): Boolean;
    procedure GetParamValues(AParIndex: Integer = 0);
    procedure SetupStatementDataAccess(AStmt: TADSStatement);
    procedure SetupStatementPasswords(AStmt: TADSStatement);
  protected
    procedure InternalAbort; override;
    procedure InternalClose; override;
    procedure InternalExecute(ATimes, AOffset: Integer; var ACount: TFDCounter); override;
    function InternalFetchRowSet(ATable: TFDDatSTable; AParentRow: TFDDatSRow;
      ARowsetSize: LongWord): LongWord; override;
    function InternalOpen: Boolean; override;
    function InternalNextRecordSet: Boolean; override;
    procedure InternalPrepare; override;
    function InternalUseStandardMetadata: Boolean; override;
    function InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean; override;
    function InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean; override;
    procedure InternalUnprepare; override;
    function GetCliObj: Pointer; override;
  public
    constructor Create(AConnection: TFDPhysConnection);
    destructor Destroy; override;
    property ADSConnection: TFDPhysADSConnection read GetConnection;
    property ADSStatement: TADSStatement read FStmt;
  end;

const
  S_FD_UDP = 'UDP';
  S_FD_IPX = 'IPX';
  S_FD_TCPIP = 'TCPIP';
  S_FD_TLS = 'TLS';

  S_FD_Remote = 'Remote';
  S_FD_Local = 'Local';
  S_FD_Internet = 'Internet';

  // S_FD_Internet
  S_FD_Always = 'Always';
  S_FD_Never = 'Never';

  S_FD_Default = 'Default';
  S_FD_CDX = 'CDX';
  S_FD_VFP = 'VFP';
  S_FD_ADT = 'ADT';
  S_FD_NTX = 'NTX';

  S_FD_Proprietary = 'Proprietary';
  S_FD_Compatible = 'Compatible';

  C_AdsCharTypeMap = 'ANSI;OEM';

{-------------------------------------------------------------------------------}
{ TFDPhysADSDriverLink                                                          }
{-------------------------------------------------------------------------------}
const
  C_DefDateFormat = 'MM/DD/YYYY';
  C_DefDecimals = 2;
  C_DefShowDeleted = True;
  C_DefEpoch = 1900;
  C_DefExact = False;

constructor TFDPhysADSDriverLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDateFormat := C_DefDateFormat;
  FDecimals := C_DefDecimals;
  FShowDeleted := C_DefShowDeleted;
  FEpoch := C_DefEpoch;
  FExact := C_DefExact;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.GetBaseDriverID: String;
begin
  Result := S_FD_ADSId;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriverLink.ApplyTo(const AParams: IFDStanDefinition);
begin
  inherited ApplyTo(AParams);
  if IsDFS then
    AParams.AsString[S_FD_ConnParam_ADS_DateFormat] := DateFormat;
  if IsDS then
    AParams.AsInteger[S_FD_ConnParam_ADS_Decimals] := Decimals;
  if IsDPS then
    AParams.AsString[S_FD_ConnParam_ADS_DefaultPath] := DefaultPath;
  if IsSPS then
    AParams.AsString[S_FD_ConnParam_ADS_SearchPath] := SearchPath;
  if IsSDS then
    AParams.AsString[S_FD_ConnParam_ADS_ShowDeleted] := S_FD_Bools[ShowDeleted];
  if IsEpS then
    AParams.AsInteger[S_FD_ConnParam_ADS_Epoch] := Epoch;
  if IsExS then
    AParams.AsString[S_FD_ConnParam_ADS_Exact] := S_FD_Bools[Exact];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.IsConfigured: Boolean;
begin
  Result := inherited IsConfigured or IsDFS or IsDS or IsDPS or IsSPS or
    IsSDS or IsEpS or IsExS;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.GetDateFormat: String;
begin
  if DriverState in [drsLoaded, drsActive] then
    Result := TADSLib(DriverIntf.CliObj).DateFormat
  else
    Result := FDateFormat;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriverLink.SetDateFormat(const AValue: String);
begin
  FDateFormat := AValue;
  if DriverState in [drsLoaded, drsActive] then
    TADSLib(DriverIntf.CliObj).DateFormat := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.IsDFS: Boolean;
begin
  Result := (FDateFormat <> '') and (FDateFormat <> C_DefDateFormat);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.GetDecimals: Word;
begin
  if DriverState in [drsLoaded, drsActive] then
    Result := TADSLib(DriverIntf.CliObj).Decimals
  else
    Result := FDecimals;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriverLink.SetDecimals(const AValue: Word);
begin
  FDecimals := AValue;
  if DriverState in [drsLoaded, drsActive] then
    TADSLib(DriverIntf.CliObj).Decimals := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.IsDS: Boolean;
begin
  Result := (FDecimals <> C_DefDecimals) and (FDecimals <= 30);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.GetDefaultPath: String;
begin
  if DriverState in [drsLoaded, drsActive] then
    Result := TADSLib(DriverIntf.CliObj).DefaultPath
  else
    Result := FDefaultPath;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriverLink.SetDefaultPath(const AValue: String);
begin
  FDefaultPath := AValue;
  if DriverState in [drsLoaded, drsActive] then
    TADSLib(DriverIntf.CliObj).DefaultPath := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.IsDPS: Boolean;
begin
  Result := (FDefaultPath <> '') and (CompareText(FDefaultPath, GetCurrentDir) <> 0);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.GetSearchPath: String;
begin
  if DriverState in [drsLoaded, drsActive] then
    Result := TADSLib(DriverIntf.CliObj).SearchPath
  else
    Result := FSearchPath;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriverLink.SetSearchPath(const AValue: String);
begin
  FSearchPath := AValue;
  if DriverState in [drsLoaded, drsActive] then
    TADSLib(DriverIntf.CliObj).SearchPath := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.IsSPS: Boolean;
begin
  Result := (FSearchPath <> '') and (CompareText(FSearchPath, DefaultPath) <> 0);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.GetShowDeleted: Boolean;
begin
  if DriverState in [drsLoaded, drsActive] then
    Result := TADSLib(DriverIntf.CliObj).ShowDeleted
  else
    Result := FShowDeleted;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriverLink.SetShowDeleted(const AValue: Boolean);
begin
  FShowDeleted := AValue;
  if DriverState in [drsLoaded, drsActive] then
    TADSLib(DriverIntf.CliObj).ShowDeleted := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.IsSDS: Boolean;
begin
  Result := FShowDeleted <> C_DefShowDeleted;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.GetEpoch: Word;
begin
  if DriverState in [drsLoaded, drsActive] then
    Result := TADSLib(DriverIntf.CliObj).Epoch
  else
    Result := FEpoch;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriverLink.SetEpoch(const AValue: Word);
begin
  FEpoch := AValue;
  if DriverState in [drsLoaded, drsActive] then
    TADSLib(DriverIntf.CliObj).Epoch := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.IsEpS: Boolean;
begin
  Result := FEpoch <> C_DefEpoch;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.GetExact: Boolean;
begin
  if DriverState in [drsLoaded, drsActive] then
    Result := TADSLib(DriverIntf.CliObj).Exact
  else
    Result := FExact;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriverLink.SetExact(const AValue: Boolean);
begin
  FExact := AValue;
  if DriverState in [drsLoaded, drsActive] then
    TADSLib(DriverIntf.CliObj).Exact := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriverLink.IsExS: Boolean;
begin
  Result := FExact <> C_DefExact;
end;

{-------------------------------------------------------------------------------}
{ TFDADSService                                                                 }
{-------------------------------------------------------------------------------}
function TFDADSService.GetDriverLink: TFDPhysADSDriverLink;
begin
  Result := inherited DriverLink as TFDPhysADSDriverLink;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSService.SetDriverLink(const AValue: TFDPhysADSDriverLink);
begin
  inherited DriverLink := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDADSService.GetConnectionString: String;
begin
  Result := 'DriverID=' + DriverLink.ActualDriverID + ';Database=' + Database +
    ';ServerTypes=Local|Remote';
  if UserName <> '' then
    Result := Result + ';User_Name=' + UserName;
  if Password <> '' then
    Result := Result + ';Password=' + Password;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSService.GetConnection(out AConn: IFDPhysConnection;
  out ACmd: IFDPhysCommand);
begin
  FDPhysManager().CreateConnection(GetConnectionString(), AConn);
  AConn.ErrorHandler := Self as IFDStanErrorHandler;
  AConn.Open;
  AConn.CreateCommand(ACmd);
  ACmd.Options.ResourceOptions.CmdExecMode := amBlocking;
end;

{-------------------------------------------------------------------------------}
{ TFDADSBackupRestore                                                           }
{-------------------------------------------------------------------------------}
constructor TFDADSBackupRestore.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInclude := TFDStringList.Create;
  FExclude := TFDStringList.Create;
  FTableTypeMap := TFDStringList.Create;
  FResults := TFDDatSTable.Create;
  FResults.CountRef;
end;

{-------------------------------------------------------------------------------}
destructor TFDADSBackupRestore.Destroy;
begin
  FResults.RemRef;
  FResults := nil;
  FDFreeAndNil(FInclude);
  FDFreeAndNil(FExclude);
  FDFreeAndNil(FTableTypeMap);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSBackupRestore.SetInclude(const AValue: TStrings);
begin
  FInclude.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDADSBackupRestore.SetExclude(const AValue: TStrings);
begin
  FExclude.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDADSBackupRestore.SetTableTypeMap(const AValue: TStrings);
begin
  FTableTypeMap.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
class procedure TFDADSBackupRestore.AddOption(var AStr: String; const AName, AValue: String);
begin
  if AStr <> '' then
    AStr := AStr + ';';
  AStr := AStr + AName;
  if AValue <> '' then
    AStr := AStr + '=' + AValue;
end;

{-------------------------------------------------------------------------------}
function TFDADSBackupRestore.GetOptions: String;
var
  i: Integer;
  s: String;
begin
  if Include.Count > 0 then begin
    s := '';
    for i := 0 to Include.Count - 1 do
      if Trim(Include[i]) <> '' then begin
        if s <> '' then
          s := s + ', ';
        s := s + Include[i];
      end;
    AddOption(Result, 'include', s);
  end;

  if Exclude.Count > 0 then begin
    s := '';
    for i := 0 to Exclude.Count - 1 do
      if Trim(Exclude[i]) <> '' then begin
        if s <> '' then
          s := s + ', ';
        s := s + Exclude[i];
      end;
    AddOption(Result, 'exclude', s);
  end;

  if TableTypeMap.Count > 0 then begin
    s := '';
    for i := 0 to TableTypeMap.Count - 1 do
      if Trim(Exclude[i]) <> '' then begin
        if s <> '' then
          s := s + ', ';
        s := s + TableTypeMap[i];
      end;
    AddOption(Result, 'TABLETYPEMAP', s);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDADSBackup                                                                  }
{-------------------------------------------------------------------------------}
function TFDADSBackup.GetOptions: String;
begin
  Result := inherited GetOptions;
  if boMetaOnly in Options then
    AddOption(Result, 'MetaOnly', '');
  if boPrepareDiff in Options then
    AddOption(Result, 'PrepareDiff', '');
  if boDiff in Options then
    AddOption(Result, 'Diff', '');
  if ArchiveFile <> '' then
    if boCompressArchive in Options then
      AddOption(Result, 'ArchiveFileCompressed', ArchiveFile)
    else
      AddOption(Result, 'ArchiveFile', ArchiveFile);
end;

{-------------------------------------------------------------------------------}
procedure TFDADSBackup.InternalExecute;
var
  oConn: IFDPhysConnection;
  oCmd: IFDPhysCommand;
begin
  GetConnection(oConn, oCmd);
  oCmd.CommandText := 'EXECUTE PROCEDURE sp_BackupDatabase(:p1, :p2)';
  oCmd.Params[0].AsString := BackupPath;
  oCmd.Params[1].DataType := ftMemo;
  oCmd.Params[1].Value := GetOptions;
  oCmd.Prepare();
  oCmd.Define(FResults);
  oCmd.Fetch(FResults, True, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDADSBackup.Backup;
begin
  Execute;
end;

{-------------------------------------------------------------------------------}
{ TFDADSRestore                                                                 }
{-------------------------------------------------------------------------------}
function TFDADSRestore.GetOptions: String;
begin
  Result := inherited GetOptions;
  if roDontOverwrite in Options then
    AddOption(Result, 'DontOverwrite', '');
  if roMetaOnly in Options then
    AddOption(Result, 'MetaOnly', '');
  if roNoWarnings in Options then
    AddOption(Result, 'NoWarnings', '');
  if DDPassword <> '' then
    AddOption(Result, 'DDPassword', DDPassword);
  if ArchiveFile <> '' then
    if roCompressedArchive in Options then
      AddOption(Result, 'ArchiveFileCompressed', ArchiveFile)
    else
      AddOption(Result, 'ArchiveFile', ArchiveFile);
  if roForceArchiveExtract in Options then
    AddOption(Result, 'ForceArchiveExtract', '');
end;

{-------------------------------------------------------------------------------}
procedure TFDADSRestore.InternalExecute;
var
  oConn: IFDPhysConnection;
  oCmd: IFDPhysCommand;
begin
  GetConnection(oConn, oCmd);
  oCmd.CommandText := 'EXECUTE PROCEDURE sp_RestoreDatabase(:p1, :p2, :p3, :p4)';
  oCmd.Params[0].AsString := SourcePath;
  oCmd.Params[1].AsString := SourcePassword;
  oCmd.Params[2].AsString := DestinationPath;
  oCmd.Params[3].DataType := ftMemo;
  oCmd.Params[3].Value := GetOptions;
  oCmd.Prepare();
  oCmd.Define(FResults);
  oCmd.Fetch(FResults, True, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDADSRestore.Restore;
begin
  Execute;
end;

{-------------------------------------------------------------------------------}
{ TFDADSUtility                                                                 }
{-------------------------------------------------------------------------------}
constructor TFDADSUtility.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTables := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDADSUtility.Destroy;
begin
  FDFreeAndNil(FTables);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDADSUtility.GetConnectionString: String;
var
  s: String;
begin
  Result := inherited GetConnectionString;
  case TableType of
    ttCDX: s := S_FD_CDX;
    ttVFP: s := S_FD_VFP;
    ttADT: s := S_FD_ADT;
    ttNTX: s := S_FD_NTX;
  end;
  if s <> '' then
    Result := Result + ';TableType=' + s;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSUtility.SetTables(const AValue: TStrings);
begin
  FTables.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDADSUtility.Encrypt;
begin
  FMode := umEncrypt;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSUtility.Decrypt;
begin
  FMode := umDecrypt;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSUtility.Pack;
begin
  FMode := umPack;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSUtility.Zap;
begin
  FMode := umZap;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSUtility.Recall;
begin
  FMode := umRecall;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSUtility.Reindex;
begin
  FMode := umReindex;
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDADSUtility.InternalExecute;
var
  oConn: IFDPhysConnection;
  oCmd: IFDPhysCommand;
  oMetaCmd: IFDPhysMetaInfoCommand;
  oTab: TADSTable;
  oNames: TStrings;
  i: Integer;
  oSTab: TFDDatSTable;
  oDict: TADSDictionary;
  sPath: String;
begin
  GetConnection(oConn, oCmd);
  oNames := Tables;
  try
    oDict := TADSDictionary.Create(TADSConnection(oConn.CliObj));
    try
      if not oDict.HasDictionary then
        sPath := TADSConnection(oConn.CliObj).ConnectionPath
      else
        sPath := '';
    finally
      FDFree(oDict);
    end;
    if oNames.Count = 0 then begin
      oNames := TFDStringList.Create;
      oSTab := TFDDatSTable.Create;
      try
        oConn.CreateMetaInfoCommand(oMetaCmd);
        oMetaCmd.MetaInfoKind := mkTables;
        if sPath <> '' then
          oMetaCmd.CatalogName := sPath;
        oMetaCmd.TableKinds := [tkTable];
        oMetaCmd.ObjectScopes := [osMy, osOther];
        oMetaCmd.Open(True);
        oMetaCmd.Define(oSTab);
        oMetaCmd.Fetch(oSTab, True);
        for i := 0 to oSTab.Rows.Count - 1 do
          oNames.Add(oSTab.Rows[i].AsString['TABLE_NAME']);
      finally
        FDFree(oSTab);
      end;
    end;
    oTab := TADSTable.Create(TADSConnection(oConn.CliObj), Self);
    try
      for i := 0 to oNames.Count - 1 do begin
        oTab.Close;
        oTab.Options := ADS_EXCLUSIVE;
        oTab.TableName := FDNormPath(sPath) + oNames[i];
        oTab.TableType := TableType;
        oTab.Open;
        if TablePassword <> '' then
          oTab.EnableEncryption(TablePassword);
        case FMode of
        umEncrypt: if not oTab.IsEncrypted then oTab.Encrypt;
        umDecrypt: if oTab.IsEncrypted then oTab.Decrypt;
        umPack:    oTab.Pack;
        umZap:     oTab.Zap;
        umReindex: oTab.Reindex;
        umRecall:  oTab.RecallAll;
        end;
        if Assigned(OnProgress) then
          OnProgress(Self, oTab.TableName);
      end;
    finally
      FDFree(oTab);
    end;
  finally
    if oNames <> Tables then
      FDFree(oNames);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysADSDriver                                                              }
{-------------------------------------------------------------------------------}
constructor TFDPhysADSDriver.Create(AManager: TFDPhysManager;
  const ADriverDef: IFDStanDefinition);
begin
  inherited Create(AManager, ADriverDef);
  FLib := TADSLib.Create(FDPhysManagerObj);
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysADSDriver.Destroy;
begin
  inherited Destroy;
  FDFreeAndNil(FLib);
end;

{-------------------------------------------------------------------------------}
class function TFDPhysADSDriver.GetBaseDriverID: String;
begin
  Result := S_FD_ADSId;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysADSDriver.GetBaseDriverDesc: String;
begin
  Result := 'Advantage Database Server';
end;

{-------------------------------------------------------------------------------}
class function TFDPhysADSDriver.GetRDBMSKind: TFDRDBMSKind;
begin
  Result := TFDRDBMSKinds.Advantage;
end;

{-------------------------------------------------------------------------------}
class function TFDPhysADSDriver.GetConnectionDefParamsClass: TFDConnectionDefParamsClass;
begin
  Result := TFDPhysADSConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriver.InternalLoad;
var
  sHome, sLib: String;
begin
  sHome := '';
  sLib := '';
  GetVendorParams(sHome, sLib);
  FLib.Load(sHome, sLib);
  if Params <> nil then begin
    if Params.OwnValue(S_FD_ConnParam_ADS_DateFormat) then
      FLib.DateFormat := Params.AsString[S_FD_ConnParam_ADS_DateFormat];
    if Params.OwnValue(S_FD_ConnParam_ADS_Decimals) then
      FLib.Decimals := Params.AsInteger[S_FD_ConnParam_ADS_Decimals];
    if Params.OwnValue(S_FD_ConnParam_ADS_DefaultPath) then
      FLib.DefaultPath := Params.AsString[S_FD_ConnParam_ADS_DefaultPath];
    if Params.OwnValue(S_FD_ConnParam_ADS_SearchPath) then
      FLib.SearchPath := Params.AsString[S_FD_ConnParam_ADS_SearchPath];
    if Params.OwnValue(S_FD_ConnParam_ADS_ShowDeleted) then
      FLib.ShowDeleted := Params.AsBoolean[S_FD_ConnParam_ADS_ShowDeleted];
    if Params.OwnValue(S_FD_ConnParam_ADS_Epoch) then
      FLib.Epoch := Params.AsInteger[S_FD_ConnParam_ADS_Epoch];
    if Params.OwnValue(S_FD_ConnParam_ADS_Exact) then
      FLib.Exact := Params.AsBoolean[S_FD_ConnParam_ADS_Exact];
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSDriver.InternalUnload;
begin
  FLib.Unload;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriver.InternalCreateConnection(
  AConnHost: TFDPhysConnectionHost): TFDPhysConnection;
begin
  Result := TFDPhysADSConnection.Create(Self, AConnHost);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriver.GetCliObj: Pointer;
begin
  Result := FLib;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSDriver.GetConnParams(AKeys: TStrings; AParams: TFDDatSTable): TFDDatSTable;
var
  oView: TFDDatSView;
  oList: TFDStringList;
begin
  Result := inherited GetConnParams(AKeys, AParams);
  oView := Result.Select('Name=''' + S_FD_ConnParam_Common_Database + '''');
  if oView.Rows.Count = 1 then begin
    oView.Rows[0].BeginEdit;
    oView.Rows[0].SetValues('Type', '@F:Advantage Dictionary|*.add');
    oView.Rows[0].SetValues('LoginIndex', 2);
    oView.Rows[0].EndEdit;
  end;

  Employ;
  try
    oList := TFDStringList.Create(#0, ';');
    try
      FLib.ListAliases(oList);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_ADS_Alias, oList.DelimitedText, '', S_FD_ConnParam_ADS_Alias, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_ADS_ServerTypes, S_FD_Remote + ';' + S_FD_Local + ';' + S_FD_Internet, '', S_FD_ConnParam_ADS_ServerTypes, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_ADS_Protocol, S_FD_UDP + ';' + S_FD_IPX + ';' + S_FD_TCPIP + ';' + S_FD_TLS, '', S_FD_ConnParam_ADS_Protocol, -1]);
      FLib.ListServers(oList);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Server, oList.DelimitedText, '', S_FD_ConnParam_Common_Server, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_Port, '@I', '', S_FD_ConnParam_Common_Port, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_CharacterSet, C_AdsCharTypeMap, 'ANSI', S_FD_ConnParam_Common_CharacterSet, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_ADS_Compress, S_FD_Internet + ';' + S_FD_Always + ';' + S_FD_Never, '', S_FD_ConnParam_ADS_Compress, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_ADS_TableType, S_FD_Default + ';' + S_FD_CDX + ';' + S_FD_VFP + ';' + S_FD_ADT + ';' + S_FD_NTX, S_FD_Default, S_FD_ConnParam_ADS_TableType, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_ADS_TablePassword, '@S', '', S_FD_ConnParam_ADS_TablePassword, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_ADS_Locking, S_FD_Proprietary + ';' + S_FD_Compatible, '', S_FD_ConnParam_ADS_Locking, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_ADS_ADSAdvanced, '@S', '', S_FD_ConnParam_ADS_ADSAdvanced, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaDefCatalog, '@S', '', S_FD_ConnParam_Common_MetaDefCatalog, -1]);
      Result.Rows.Add([Unassigned, S_FD_ConnParam_Common_MetaCurCatalog, '@S', '', S_FD_ConnParam_Common_MetaCurCatalog, -1]);
    finally
      FDFree(oList);
    end;
  finally
    Vacate;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysADSConnection                                                          }
{-------------------------------------------------------------------------------}
constructor TFDPhysADSConnection.Create(ADriverObj: TFDPhysDriver;
  AConnHost: TFDPhysConnectionHost);
begin
  inherited Create(ADriverObj, AConnHost);
  FTablePasswords := TFDStringList.Create(#0, ';');
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysADSConnection.Destroy;
begin
  FDFreeAndNil(FTablePasswords);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.InternalCreateTransaction: TFDPhysTransaction;
begin
  Result := TFDPhysADSTransaction.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.InternalCreateEvent(const AEventKind: String): TFDPhysEventAlerter;
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  CreateMetadata(oConnMeta);
  if (oConnMeta.ServerVersion >= caADS10) and
     (CompareText(AEventKind, S_FD_EventKind_ADS_Events) = 0) then
    Result := TFDPhysADSEventAlerter.Create(Self, AEventKind)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.InternalCreateCommand: TFDPhysCommand;
begin
  Result := TFDPhysADSCommand.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.InternalCreateCommandGenerator(
  const ACommand: IFDPhysCommand): TFDPhysCommandGenerator;
begin
  if ACommand <> nil then
    Result := TFDPhysADSCommandGenerator.Create(ACommand)
  else
    Result := TFDPhysADSCommandGenerator.Create(Self);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.InternalCreateMetadata: TObject;
begin
  Result := TFDPhysADSMetadata.Create(Self, FServerVersion,
    TFDPhysADSDriver(DriverObj).FLib.Version, not FDictionary.HasDictionary);
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_Monitor}
procedure TFDPhysADSConnection.InternalTracingChanged;
begin
  if FConnection <> nil then begin
    FConnection.Monitor := FMonitor;
    FConnection.Tracing := FTracing;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.BuildServerTypes(const AConnDef: IFDStanConnectionDef): Integer;
const
  C_PS: TFDParseFmtSettings = (FDelimiter: '|'; FQuote: #0; FQuote1: #0; FQuote2: #0);
var
  s, sType: String;
  i, iCode: Integer;
begin
  Result := 0;
  if AConnDef.HasValue(S_FD_ConnParam_ADS_ServerTypes) then begin
    s := Trim(AConnDef.AsString[S_FD_ConnParam_ADS_ServerTypes]);
    Val(s, Result, iCode);
    if iCode <> 0 then begin
      i := 1;
      while i <= Length(s) do begin
        sType := Trim(FDExtractFieldName(s, i, C_PS));
        if CompareText(sType, S_FD_Remote) = 0 then
          Result := Result or ADS_REMOTE_SERVER
        else if CompareText(sType, S_FD_Local) = 0 then
          Result := Result or ADS_LOCAL_SERVER
        else if CompareText(sType, S_FD_Internet) = 0 then
          Result := Result or ADS_AIS_SERVER;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.Build60Options(const AConnDef: IFDStanConnectionDef): Integer;
var
  s: String;
begin
  Result := 0;
  if AConnDef.HasValue(S_FD_ConnParam_ADS_Protocol) then begin
    s := AConnDef.AsString[S_FD_ConnParam_ADS_Protocol];
    if CompareText(s, S_FD_UDP) = 0 then
      Result := Result or ADS_UDP_IP_CONNECTION
    else if CompareText(s, S_FD_IPX) = 0 then
      Result := Result or ADS_IPX_CONNECTION
    else if CompareText(s, S_FD_TCPIP) = 0 then
      Result := Result or ADS_TCP_IP_CONNECTION
    else if CompareText(s, S_FD_TLS) = 0 then
      Result := Result or ADS_TLS_CONNECTION;
  end;

  if AConnDef.HasValue(S_FD_ConnParam_ADS_Compress) then begin
    s := AConnDef.AsString[S_FD_ConnParam_ADS_Compress];
    if CompareText(s, S_FD_Internet) = 0 then
      Result := Result or ADS_COMPRESS_INTERNET
    else if CompareText(s, S_FD_Always) = 0 then
      Result := Result or ADS_COMPRESS_ALWAYS
    else if CompareText(s, S_FD_Never) = 0 then
      Result := Result or ADS_COMPRESS_NEVER;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.BuildConnectionPath(const AConnDef: IFDStanConnectionDef): String;
var
  i: Integer;
  oParams: TFDPhysADSConnectionDefParams;
begin
  Result := '';
  oParams := TFDPhysADSConnectionDefParams(AConnDef.Params);
  if AConnDef.HasValue(S_FD_ConnParam_Common_Server) then begin
    Result := oParams.Server;
    if (Result <> '') and (Copy(Result, 1, 2) <> '//') and (Copy(Result, 1, 2) <> '\\') then
      Result := '//' + Result;
    if AConnDef.HasValue(S_FD_ConnParam_Common_Port) then begin
      i := Pos(':', Result);
      if i <> 0 then
        Result := Copy(Result, 1, i - 1);
      if oParams.Port <> 0 then
        Result := Result + ':' + IntToStr(oParams.Port);
    end;
  end;
  if AConnDef.HasValue(S_FD_ConnParam_Common_Database) or (FAliasPath <> '') then begin
    if (Result <> '') and (Copy(Result, Length(Result), 1) <> '/') and
       (Copy(Result, Length(Result), 1) <> '\') then
      Result := Result + '/';
    if oParams.Database <> '' then
      Result := Result + oParams.Database
    else if FAliasPath <> '' then
      Result := Result + FAliasPath;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.BuildADS101ConnectString(const AConnDef: IFDStanConnectionDef): String;

  procedure Add(const AParam, AValue: String);
  begin
    if Result <> '' then
      Result := Result + ';';
    Result := Result + AParam + '=' + AValue;
  end;

var
  oParams: TFDPhysADSConnectionDefParams;
  s: String;
begin
  Result := '';
  oParams := TFDPhysADSConnectionDefParams(AConnDef.Params);

  s := IntToStr(BuildServerTypes(AConnDef));
  if s <> '0' then
    Add('ServerType', s);

  s := '';
  if AConnDef.HasValue(S_FD_ConnParam_ADS_Protocol) then
    case oParams.Protocol of
    prUDP:   s := 'UDP_IP';
    prIPX:   s := 'IPX';
    prTCPIP: s := 'TCP_IP';
    prTLS:   s := 'TLS';
    end;
  if s <> '' then
    Add('CommType', s);

  s := BuildConnectionPath(AConnDef);
  if s <> '' then
    Add('Data Source', s);

  if AConnDef.HasValue(S_FD_ConnParam_Common_UserName) then
    Add('User ID', oParams.UserName);
  if AConnDef.HasValue(S_FD_ConnParam_Common_Password) then
    Add('Password', oParams.Password);
  if AConnDef.HasValue(S_FD_ConnParam_Common_CharacterSet) then
    Add('CharType', AConnDef.AsString[S_FD_ConnParam_Common_CharacterSet]);
  if AConnDef.HasValue(S_FD_ConnParam_ADS_Compress) then
    Add('Compression', AConnDef.AsString[S_FD_ConnParam_ADS_Compress]);
  if AConnDef.HasValue(S_FD_ConnParam_ADS_TableType) then
    Add('TableType', AConnDef.AsString[S_FD_ConnParam_ADS_TableType])
  else if FAliasTableType <> '' then
    Add('TableType', FAliasTableType);
  if AConnDef.HasValue(S_FD_ConnParam_ADS_Locking) then
    Add('LockMode', AConnDef.AsString[S_FD_ConnParam_ADS_Locking]);

  if AConnDef.HasValue(S_FD_ConnParam_ADS_ADSAdvanced) then
    Result := Result + ';' + oParams.ADSAdvanced;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.BaseConnect(AConn: TADSConnection;
  const AConnDef: IFDStanConnectionDef);
var
  oParams: TFDPhysADSConnectionDefParams;
begin
  oParams := TFDPhysADSConnectionDefParams(AConnDef.Params);
  if AConnDef.HasValue(S_FD_ConnParam_ADS_Alias) then
    AConn.Lib.ResolveAlias(oParams.Alias, FAliasPath, FAliasTableType)
  else begin
    FAliasPath := '';
    FAliasTableType := '';
  end;
  if Assigned(AConn.Lib.FAdsConnect101) then
    AConn.Connect101(BuildADS101ConnectString(AConnDef))
  else begin
    AConn.Connect60(BuildConnectionPath(AConnDef), BuildServerTypes(AConnDef),
      oParams.UserName, oParams.Password, Build60Options(AConnDef));
    if AConnDef.HasValue(S_FD_ConnParam_Common_CharacterSet) then
      AConn.Collation := AConnDef.AsString[S_FD_ConnParam_Common_CharacterSet];
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.LoadPasswords;
var
  oMetaCmd: IFDPhysMetaInfoCommand;
  oSTab: TFDDatSTable;
  i: Integer;
  sPwd: String;
  ePrevState: TFDPhysConnectionState;
begin
  FTablePasswords.DelimitedText := ConnectionDef.AsString[S_FD_ConnParam_ADS_TablePassword];
  if (FTablePasswords.Count = 1) and (FTablePasswords.ValueFromIndex[0] = '') then begin
    oSTab := TFDDatSTable.Create;
    ePrevState := FState;
    try
      FState := csConnected;
      CreateMetaInfoCommand(oMetaCmd);
      oMetaCmd.MetaInfoKind := mkTables;
      if not FDictionary.HasDictionary then
        oMetaCmd.CatalogName := FConnection.ConnectionPath;
      oMetaCmd.TableKinds := [tkTable];
      oMetaCmd.ObjectScopes := [osMy, osOther];
      oMetaCmd.Open(True);
      oMetaCmd.Define(oSTab);
      oMetaCmd.Fetch(oSTab, True);
      sPwd := FTablePasswords[0];
      FTablePasswords.Clear;
      for i := 0 to oSTab.Rows.Count - 1 do
        FTablePasswords.AddPair(FDExtractFileNameNoPath(oSTab.Rows[i].AsString['TABLE_NAME']), sPwd);
    finally
      FState := ePrevState;
      FDFree(oSTab);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.InternalConnect;
var
  pCliHandles: PFDPhysADSCliHandles;
  oParams: TFDPhysADSConnectionDefParams;
begin
  oParams := ConnectionDef.Params as TFDPhysADSConnectionDefParams;
  if InternalGetSharedCliHandle() <> nil then begin
    pCliHandles := PFDPhysADSCliHandles(InternalGetSharedCliHandle());
    FConnection := TADSConnection.CreateUsingHandle(TFDPhysADSDriver(DriverObj).FLib,
      pCliHandles^[0], Self);
  end
  else
    FConnection := TADSConnection.Create(TFDPhysADSDriver(DriverObj).FLib, Self);
{$IFDEF FireDAC_MONITOR}
  InternalTracingChanged;
{$ENDIF}

  if InternalGetSharedCliHandle() = nil then begin
    BaseConnect(FConnection, ConnectionDef);

    if oParams.NewPassword <> '' then
      InternalExecuteDirect('EXECUTE PROCEDURE sp_ModifyUserProperty(''' +
        oParams.UserName + ''', ''USER_PASSWORD'', ''' +
        oParams.NewPassword + '''', nil);
  end;

  FDictionary := TADSDictionary.Create(FConnection);
  FServerVersion := FConnection.ServerVersion;
  LoadPasswords;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.InternalSetMeta;
var
  sName: String;
begin
  inherited InternalSetMeta;
  sName := FConnection.ConnectionPath;
  if FCurrentCatalog = '' then
    FCurrentCatalog := sName;
  if FDefaultCatalog = '' then
    FDefaultCatalog := sName;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.InternalDisconnect;
begin
  FDFreeAndNil(FDictionary);
  FDFreeAndNil(FConnection);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.InternalPing;
begin
  FConnection.Ping;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.InternalChangePassword(const AUserName,
  AOldPassword, ANewPassword: String);
var
  oConnDef: IFDStanConnectionDef;
  oConn: TADSConnection;
  oStmt: TADSStatement;
begin
  FDCreateInterface(IFDStanConnectionDef, oConnDef);
  oConnDef.ParentDefinition := ConnectionDef;
  oConnDef.Params.UserName := AUserName;
  oConnDef.Params.Password := AOldPassword;
  oConn := TADSConnection.Create(TFDPhysADSDriver(DriverObj).FLib, Self);
  oStmt := TADSStatement.Create(oConn, Self);
  try
    BaseConnect(oConn, oConnDef);
    oStmt.ExecuteDirect('EXECUTE PROCEDURE sp_ModifyUserProperty(''' +
      AUserName + ''', ''USER_PASSWORD'', ''' + ANewPassword + '''');
  finally
    FDFree(oStmt);
    FDFree(oConn);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.InternalExecuteDirect(const ASQL: String;
  ATransaction: TFDPhysTransaction);
var
  oStmt: TADSStatement;
begin
  oStmt := TADSStatement.Create(FConnection, Self);
  try
    oStmt.ExecuteDirect(ASQL);
  finally
    FDFree(oStmt);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.GetLastAutoGenValue(const AName: String): Variant;
var
  iLastAutoInc: Cardinal;
begin
  if (FConnection <> nil) and (AName = '') then begin
    iLastAutoInc := FConnection.LastAutoInc;
    if iLastAutoInc = 0 then
      Result := FLastAutoGenValue
    else
      Result := iLastAutoInc
  end
  else
    Result := inherited GetLastAutoGenValue(AName);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.GetItemCount: Integer;
begin
  Result := inherited GetItemCount;
  if DriverObj.State in [drsLoaded, drsActive] then begin
    Inc(Result, 2);
    if FConnection <> nil then
      Inc(Result, 3);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.GetItem(AIndex: Integer; out AName: String;
  out AValue: Variant; out AKind: TFDMoniAdapterItemKind);
begin
  if AIndex < inherited GetItemCount then
    inherited GetItem(AIndex, AName, AValue, AKind)
  else
    case AIndex - inherited GetItemCount of
    0:
      begin
        AName := 'Client version';
        AValue := Integer(TFDPhysADSDriver(DriverObj).FLib.Version);
        AKind := ikClientInfo;
      end;
    1:
      begin
        AName := 'Client DLL name';
        AValue := TFDPhysADSDriver(DriverObj).FLib.DLLName;
        AKind := ikClientInfo;
      end;
    2:
      begin
        AName := 'Server version';
        AValue := FConnection.ServerVersionStr;
        AKind := ikSessionInfo;
      end;
    3:
      begin
        AName := 'Server collation';
        AValue := FConnection.Collation;
        AKind := ikSessionInfo;
      end;
    4:
      begin
        AName := 'Connection path';
        AValue := FConnection.ConnectionPath;
        AKind := ikSessionInfo;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.GetMessages: EFDDBEngineException;
begin
  Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.GetCliObj: Pointer;
begin
  Result := FConnection;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnection.InternalGetCliHandle: Pointer;
begin
  if FConnection <> nil then begin
    FCliHandles[0] := FConnection.Handle;
    Result := @FCliHandles;
  end
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnection.InternalAnalyzeSession(AMessages: TStrings);
var
  oConnMeta: IFDPhysConnectionMetadata;
begin
  inherited InternalAnalyzeSession(AMessages);
  CreateMetadata(oConnMeta);

  // 2. The minimal Advantage server version is 10.0
  if (oConnMeta.ServerVersion > 0) and (oConnMeta.ServerVersion < caADS10) then
    AMessages.Add(Format(S_FD_ADSWarnMinAdvantageVer, [FDVerInt2Str(oConnMeta.ServerVersion)]));

  // 3. The minimal ACE version is 10.0
  if (oConnMeta.ClientVersion > 0) and (oConnMeta.ClientVersion < caADS10) then
    AMessages.Add(Format(S_FD_ADSWarnMinACEVer, [FDVerInt2Str(oConnMeta.ClientVersion)]));
end;

{-------------------------------------------------------------------------------}
{ TFDPhysADSTransaction                                                         }
{-------------------------------------------------------------------------------}
procedure TFDPhysADSTransaction.InternalStartTransaction(ATxID: LongWord);
begin
  TFDPhysADSConnection(ConnectionObj).InternalExecuteDirect(
    'BEGIN TRANSACTION; SAVEPOINT ' + 't_' + IntToStr(ATxID), Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSTransaction.InternalCommit(ATxID: LongWord);
begin
  TFDPhysADSConnection(ConnectionObj).InternalExecuteDirect(
    'COMMIT', Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSTransaction.InternalRollback(ATxID: LongWord);
begin
  if GetNestingLevel = 1 then
    TFDPhysADSConnection(ConnectionObj).InternalExecuteDirect(
      'ROLLBACK', Self)
  else
    TFDPhysADSConnection(ConnectionObj).InternalExecuteDirect(
      'ROLLBACK TO SAVEPOINT ' + 't_' + IntToStr(ATxID), Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSTransaction.InternalChanged;
var
  s: String;
begin
  // ADS does not support transaction modes, only autocommit on/off
  if xoAutoCommit in GetOptions.Changed then begin
    if GetOptions.AutoCommit then
      s := 'ON'
    else
      s := 'OFF';
    TFDPhysADSConnection(ConnectionObj).InternalExecuteDirect(
      'SET TRANSACTION AUTOCOMMIT_' + s, nil);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSTransaction.InternalCheckState(ACommandObj: TFDPhysCommand;
  ASuccess: Boolean);
var
  oStmt: TADSStatement;
  oCrs: TADSCursor;
  iTrans, iSize: Integer;
  lActive: Boolean;
begin
  if ASuccess and (TFDPhysADSCommand(ACommandObj).GetCommandKind in
                   [skStartTransaction, skCommit, skRollback]) then begin
    oStmt := TADSStatement.Create(TFDPhysADSConnection(ConnectionObj).FConnection, Self);
    oCrs := nil;
    try
      // Local server ignores transaction control commands.
      // So, the ::conn.TransactionCount is always zero.
      oStmt.ExecuteDirect('SELECT ::conn.TransactionCount FROM system.iota');
      oCrs := oStmt.GetCursor;
      oCrs.AddColumns;
      oCrs.Columns[0].GetData(@iTrans, iSize);
      lActive := (iTrans > 0);
      if GetActive <> lActive then
        if lActive then
          TransactionStarted
        else
          TransactionFinished;
    finally
      FDFree(oCrs);
      FDFree(oStmt);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSTransaction.InternalNotify(
  ANotification: TFDPhysTxNotification; ACommandObj: TFDPhysCommand);
begin
  // ADS does not invalidate open cursors after explicit 
  // transaction control commands
  inherited InternalNotify(ANotification, ACommandObj);
end;

{-------------------------------------------------------------------------------}
{ TFDPhysADSEventThread                                                         }
{-------------------------------------------------------------------------------}
type
  TFDPhysADSEventThread = class(TThread)
  private
    [weak] FAlerter: TFDPhysADSEventAlerter;
  protected
    procedure Execute; override;
  public
    constructor Create(AAlerter: TFDPhysADSEventAlerter);
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysADSEventThread.Create(AAlerter: TFDPhysADSEventAlerter);
begin
  inherited Create(False);
  FAlerter := AAlerter;
  FreeOnTerminate := True;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysADSEventThread.Destroy;
begin
  FAlerter.FWaitThread := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSEventThread.Execute;
begin
  while not Terminated and FAlerter.IsRunning do
    try
      FAlerter.FWaitCommand.Open;
      if not Terminated then
        FAlerter.DoFired;
    except
      on E: EFDDBEngineException do
        if E.Kind <> ekCmdAborted then begin
          Terminate;
          FAlerter.AbortJob;
        end;
    end;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysADSEventMessage                                                        }
{-------------------------------------------------------------------------------}
type
  TFDPhysADSEventMessage = class(TFDPhysEventMessage)
  private
    FName: String;
    FCount: Integer;
    FMessage: String;
  public
    constructor Create(const AName: String; ACount: Integer; const AMessage: String);
  end;

{-------------------------------------------------------------------------------}
constructor TFDPhysADSEventMessage.Create(const AName: String;
  ACount: Integer; const AMessage: String);
begin
  inherited Create;
  FName := AName;
  FCount := ACount;
  FMessage := AMessage;
end;

{-------------------------------------------------------------------------------}
{ TFDPhysADSEventAlerter                                                        }
{-------------------------------------------------------------------------------}
const
  C_WakeUpEvent = C_FD_SysNamePrefix + 'WAKEUP';
  C_SignalEventProc = C_FD_SysNamePrefix + '_SIGNALEVENT';

procedure TFDPhysADSEventAlerter.InternalAllocHandle;
begin
  FWaitConnection := GetConnection.Clone;
  if FWaitConnection.State = csDisconnected then
    FWaitConnection.Open;
  FWaitConnection.CreateCommand(FWaitCommand);
  SetupCommand(FWaitCommand);
  FTab := TFDDatSTable.Create;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSEventAlerter.DoFired;
var
  i: Integer;
  oRow: TFDDatSRow;
begin
  try
    if FTab.Columns.Count = 0 then
      FWaitCommand.Define(FTab);
    FWaitCommand.Fetch(FTab);
    for i := 0 to FTab.Rows.Count - 1 do begin
      oRow := FTab.Rows[i];
      if (oRow.GetData(1) <> 0) and
         (CompareText(oRow.GetData(0), C_WakeUpEvent) <> 0) then
        FMsgThread.EnqueueMsg(TFDPhysADSEventMessage.Create(
          oRow.GetData(0), oRow.GetData(1), oRow.GetData(2)));
    end;
  finally
    FTab.Clear;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSEventAlerter.InternalHandle(
  AEventMessage: TFDPhysEventMessage);
var
  oEventMsg: TFDPhysADSEventMessage;
begin
  oEventMsg := TFDPhysADSEventMessage(AEventMessage);
  InternalHandleEvent(oEventMsg.FName, oEventMsg.FMessage);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSEventAlerter.InternalAbortJob;
begin
  if FWaitThread <> nil then begin
    FWaitThread.Terminate;
    InternalSignal(C_WakeUpEvent, Null);
    FWaitCommand.AbortJob(True);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSEventAlerter.InternalRegister;
var
  i: Integer;
begin
  FWaitCommand.CommandText := 'SELECT 1 FROM system.storedprocedures WHERE UPPER(Name) = ''' +
    C_SignalEventProc + '''';
  FWaitCommand.Open;
  FWaitCommand.Define(FTab);
  FWaitCommand.Fetch(FTab);
  if FTab.Rows.Count = 0 then begin
    FWaitCommand.Prepare('CREATE PROCEDURE ' + C_SignalEventProc +
      ' (AEvNm CHAR(200), AWFC LOGICAL, AEvDt MEMO)' +
      ' BEGIN' +
      ' DECLARE AEvNm CHAR(200), AWFC LOGICAL, AEvDt MEMO;' +
      ' AEvNm = (SELECT A.AEvNm FROM __INPUT A);' +
      ' AWFC = (SELECT A.AWFC FROM __INPUT A);' +
      ' AEvDt = (SELECT A.AEvDt FROM __INPUT A);' +
      ' EXECUTE PROCEDURE sp_SignalEvent(AEvNm, AWFC, 0, AEvDt);' +
      ' END;');
    FWaitCommand.Execute();
  end;
  FTab.Reset;

  FWaitCommand.CommandText := 'EXECUTE PROCEDURE sp_CreateEvent(:EventName, 2)';
  FWaitCommand.Params[0].DataType := ftString;
  FWaitCommand.Prepare;
  FWaitCommand.Params[0].AsString := C_WakeUpEvent;
  FWaitCommand.Execute();
  for i := 0 to GetNames.Count - 1 do begin
    FWaitCommand.Params[0].AsString := GetNames()[i];
    FWaitCommand.Execute();
  end;

  FWaitCommand.CommandText := 'SELECT * FROM (EXECUTE PROCEDURE sp_WaitForAnyEvent(-1, 0, 0)) A';
  FWaitCommand.Prepare;

  FWaitThread := TFDPhysADSEventThread.Create(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSEventAlerter.InternalUnregister;
begin
  FWaitThread := nil;

  if FWaitCommand <> nil then
  try
    FWaitCommand.Prepare('EXECUTE PROCEDURE sp_DropAllEvents(0)');
    FWaitCommand.Execute();
  except
    // hide exception
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSEventAlerter.InternalReleaseHandle;
begin
  FDFreeAndNil(FTab);
  FWaitCommand := nil;
  FWaitConnection := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSEventAlerter.InternalSignal(const AEvent: String;
  const AArgument: Variant);
var
  oCmd: IFDPhysCommand;
  sCmd: String;
begin
  sCmd := 'EXECUTE PROCEDURE ' + C_SignalEventProc + '(' + QuotedStr(AEvent) + ', true';
  if VarIsNull(AArgument) or VarIsEmpty(AArgument) then
    sCmd := sCmd + ', NULL'
  else
    sCmd := sCmd + ', ' + QuotedStr(VarToStr(AArgument));
  sCmd := sCmd + ')';
  GetConnection.CreateCommand(oCmd);
  SetupCommand(oCmd);
  oCmd.Prepare(sCmd);
  oCmd.Execute();
end;

{-------------------------------------------------------------------------------}
{ TFDPhysADSCommand                                                             }
{-------------------------------------------------------------------------------}
constructor TFDPhysADSCommand.Create(AConnection: TFDPhysConnection);
begin
  inherited Create(AConnection);
  FMetaEncoder := TFDEncoder.Create(nil);
  FMetaEncoder.Encoding := ecANSI;
end;

{-------------------------------------------------------------------------------}
destructor TFDPhysADSCommand.Destroy;
begin
  FDFreeAndNil(FMetaEncoder);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.GetConnection: TFDPhysADSConnection;
begin
  Result := TFDPhysADSConnection(FConnectionObj);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.GetCliObj: Pointer;
begin
  Result := FStmt;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.UseExecDirect: Boolean;
begin
  Result := (FOptions.ResourceOptions.DirectExecute or
             (GetCommandKind in [skSet, skSetSchema, skCreate, skDrop, skAlter, skOther,
                                 skStartTransaction, skCommit, skRollback])) and
            (GetParams.Count = 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.SetupStatementDataAccess(AStmt: TADSStatement);
var
  s: String;
begin
  if ADSConnection.ConnectionDef.HasValue(S_FD_ConnParam_ADS_TableType) or
     (ADSConnection.FAliasTableType <> '') then begin
    s := ADSConnection.ConnectionDef.AsString[S_FD_ConnParam_ADS_TableType];
    if s = '' then
      s := ADSConnection.FAliasTableType;
    if CompareText(s, S_FD_ADT) = 0 then
      AStmt.TableType := ttADT
    else if CompareText(s, S_FD_VFP) = 0 then
      AStmt.TableType := ttVFP
    else if CompareText(s, S_FD_CDX) = 0 then
      AStmt.TableType := ttCDX
    else if CompareText(s, S_FD_NTX) = 0 then
      AStmt.TableType := ttNTX;
  end;
  if ADSConnection.ConnectionDef.HasValue(S_FD_ConnParam_ADS_Locking) then begin
    s := ADSConnection.ConnectionDef.AsString[S_FD_ConnParam_ADS_Locking];
    if CompareText(s, S_FD_Proprietary) = 0 then
      AStmt.LockType := ltProprietary
    else if CompareText(s, S_FD_Compatible) = 0 then
      AStmt.LockType := ltCompatible;
  end;
  if ADSConnection.ConnectionDef.HasValue(S_FD_ConnParam_Common_CharacterSet) then
    AStmt.Collation := ADSConnection.ConnectionDef.AsString[S_FD_ConnParam_Common_CharacterSet];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.SetupStatementPasswords(AStmt: TADSStatement);
var
  oPwds: TStrings;
  i: Integer;
begin
  oPwds := ADSConnection.FTablePasswords;
  if (oPwds.Count = 1) and (oPwds.ValueFromIndex[0] = '') then begin
    if GetSourceObjectName <> '' then
      AStmt.SetTablePassword(GetSourceObjectName, oPwds[0])
    else if GetSourceRecordSetName <> '' then
      AStmt.SetTablePassword(GetSourceRecordSetName, oPwds[0]);
  end
  else
    for i := 0 to oPwds.Count - 1 do
      AStmt.SetTablePassword(oPwds.KeyNames[i], oPwds.ValueFromIndex[i]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.SetupStatementBeforePrepare(AStmt: TADSStatement);
var
  oFmtOpts: TFDFormatOptions;
begin
  oFmtOpts := FOptions.FormatOptions;
  if GetMetaInfoKind <> mkNone then begin
    AStmt.StrsTrim := True;
    AStmt.StrsEmpty2Null := True;
  end
  else begin
    AStmt.StrsTrim := oFmtOpts.StrsTrim;
    AStmt.StrsEmpty2Null := oFmtOpts.StrsEmpty2Null;
  end;
  AStmt.ReadOnly := True;

  if not Assigned(AStmt.Lib.FAdsConnect101) then
    SetupStatementDataAccess(AStmt);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.SetupStatementBeforeExecute(AStmt: TADSStatement);
var
  oResOpts: TFDResourceOptions;
  iTimeout: Cardinal;
begin
  oResOpts := FOptions.ResourceOptions;
  iTimeout := oResOpts.CmdExecTimeout;
  if (oResOpts.CmdExecMode = amBlocking) and (iTimeout <> $FFFFFFFF) then
    AStmt.Timeout := (iTimeout + 999) div 1000
  else
    AStmt.Timeout := ADS_DEFAULT_SQL_TIMEOUT;

  if (ADSConnection.FTablePasswords.Count > 0) and not FPasswordsSet then begin
    FPasswordsSet := True;
    SetupStatementPasswords(AStmt);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.SetupCursor(ACrs: TADSCursor);
var
  oFetchOpts: TFDFetchOptions;
begin
  oFetchOpts := FOptions.FetchOptions;
  ACrs.CacheRecords := oFetchOpts.RowsetSize;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.InternalPrepare;
var
  rName: TFDPhysParsedName;
  oConnMeta: IFDPhysConnectionMetadata;
begin
  // generate metadata SQL command
  if GetMetaInfoKind <> mkNone then begin
    GetSelectMetaInfoParams(rName);
    // ADS returns error for mkIndexes query to the SYSTEM catalog tables
    if (CompareText(rName.FCatalog, 'SYSTEM') = 0) and
       (GetMetaInfoKind in [mkIndexes, mkIndexFields]) then
      Exit;
    // ADS returns error for SP query to a non-dictionary connection
    if not ADSConnection.FDictionary.HasDictionary and
       (GetMetaInfoKind in [mkPackages, mkProcs, mkProcArgs, mkGenerators]) then
      Exit;

    if GetMetaInfoKind = mkIndexes then begin
      GetConnection.CreateMetadata(oConnMeta);
      FMetainfoAddonView := oConnMeta.GetTablePrimaryKey(rName.FCatalog,
        rName.FSchema, Trim(GetCommandText()));
    end;

    GenerateSelectMetaInfo(rName);
    if FDbCommandText = '' then
      Exit;
  end

  // generate stored proc call SQL command
  else if GetCommandKind in [skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs] then begin
    GetConnection.CreateMetadata(oConnMeta);
    oConnMeta.DecodeObjName(Trim(GetCommandText()), rName, Self, []);
    FDbCommandText := '';
    if fiMeta in FOptions.FetchOptions.Items then
      GenerateStoredProcParams(rName);
    // ADS does not support <catalog>.<name> as a stored procedure name
    rName.FCatalog := '';
    GenerateStoredProcCall(rName);
  end;

  // adjust SQL command
  GenerateLimitSelect();
  GenerateParamMarkers();

  FStmt := TADSStatement.Create(ADSConnection.FConnection, Self);
  SetupStatementBeforePrepare(FStmt);
  if GetParams.Count > 0 then
    CreateParamInfos;
  if not UseExecDirect then
    FStmt.Prepare(FDbCommandText);
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.FDType2SQL(AType: TFDDataType; AFixedLen: Boolean): Word;
begin
  case AType of
  dtSByte,
  dtByte,
  dtInt16,
  dtUInt16:
    Result := ADS_SHORTINT;
  dtInt32,
  dtUInt32:
    Result := ADS_INTEGER;
  dtInt64,
  dtUInt64:
    Result := ADS_LONGLONG;
  dtDouble,
  dtSingle,
  dtExtended:
    Result := ADS_DOUBLE;
  dtCurrency:
    Result := ADS_MONEY;
  dtBCD,
  dtFmtBcd:
    Result := ADS_NUMERIC;
  dtAnsiString:
    if AFixedLen then
      Result := ADS_STRING
    else
      Result := ADS_VARCHAR;
  dtWideString:
    if AFixedLen then
      Result := ADS_NCHAR
    else
      Result := ADS_NVARCHAR;
  dtMemo,
  dtHMemo:
    Result := ADS_MEMO;
  dtWideMemo,
  dtWideHMemo,
  dtXML:
    Result := ADS_NMEMO;
  dtByteString:
    Result := ADS_RAW;
  dtBlob,
  dtHBFile,
  dtHBlob:
    Result := ADS_BINARY;
  dtDate:
    Result := ADS_DATE;
  dtTime:
    Result := ADS_TIME;
  dtDateTime,
  dtDateTimeStamp:
    Result := ADS_TIMESTAMP;
  dtBoolean:
    Result := ADS_LOGICAL;
  dtGUID:
    if ADSConnection.FConnection.Lib.Version >= caADS12 then
      Result := ADS_GUID
    else
      Result := ADS_STRING;
  else
    // dtTimeIntervalFull, dtTimeIntervalYM, dtTimeIntervalDS,
    // dtCursorRef, dtRowSetRef, dtRowRef, dtArrayRef, dtParentRowRef, dtObject
    Result := ADS_TYPE_UNKNOWN;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.SQL2ADColInfo(ASQLType, ASQLMemoType: Word; ASQLLen: LongWord;
  ASQLPrec, ASQLScale: Word; out AType: TFDDataType; var AAttrs: TFDDataAttributes;
  out ALen: LongWord; out APrec, AScale: Integer; AFmtOpts: TFDFormatOptions);
begin
  AType := dtUnknown;
  ALen := 0;
  APrec := 0;
  AScale := 0;
  Exclude(AAttrs, caFixedLen);
  Exclude(AAttrs, caBlobData);
  Include(AAttrs, caSearchable);
  case ASQLType of
  ADS_SHORTINT:
    AType := dtInt16;
  ADS_INTEGER:
    AType := dtInt32;
  ADS_LONGLONG:
    AType := dtInt64;
  ADS_AUTOINC:
    begin
      AType := dtInt32;
      Include(AAttrs, caAutoInc);
      Include(AAttrs, caReadOnly);
    end;
  ADS_ROWVERSION:
    begin
      AType := dtInt64;
      Include(AAttrs, caRowVersion);
      Include(AAttrs, caReadOnly);
    end;
  ADS_DOUBLE:
    AType := dtDouble;
  ADS_CURDOUBLE,
  ADS_MONEY:
    begin
      APrec := 19;
      AScale := 4;
      AType := dtCurrency;
    end;
  ADS_NUMERIC:
    begin
      APrec := ASQLPrec;
      AScale := ASQLScale;
      if (APrec > AFmtOpts.MaxBcdPrecision) or (AScale > AFmtOpts.MaxBcdScale) then
        AType := dtFmtBCD
      else
        AType := dtBCD
    end;
  ADS_STRING,
  ADS_CISTRING,
  ADS_VARCHAR,
  ADS_VARCHAR_FOX:
    if ASQLLen <= AFmtOpts.MaxStringSize then begin
      ALen := ASQLLen;
      AType := dtAnsiString;
      if ASQLType in [ADS_STRING, ADS_CISTRING] then
        Include(AAttrs, caFixedLen);
    end
    else begin
      AType := dtMemo;
      Include(AAttrs, caBlobData);
    end;
  ADS_MEMO:
    begin
      AType := dtMemo;
      Include(AAttrs, caBlobData);
    end;
  ADS_NCHAR,
  ADS_NVARCHAR:
    if ASQLLen <= AFmtOpts.MaxStringSize then begin
      ALen := ASQLLen;
      AType := dtWideString;
      if ASQLType = ADS_NCHAR then
        Include(AAttrs, caFixedLen);
    end
    else begin
      AType := dtWideMemo;
      Include(AAttrs, caBlobData);
    end;
  ADS_NMEMO:
    begin
      AType := dtWideMemo;
      Include(AAttrs, caBlobData);
    end;
  ADS_RAW,
  ADS_VARBINARY_FOX,
  ADS_SYSTEM_FIELD:
    begin
      AType := dtByteString;
      ALen := ASQLLen;
      if ASQLType in [ADS_RAW, ADS_SYSTEM_FIELD] then
        Include(AAttrs, caFixedLen);
    end;
  ADS_BINARY,
  ADS_IMAGE,
  ADS_FOXGENERAL,
  ADS_FOXPICTURE:
    begin
      AType := dtBlob;
      Include(AAttrs, caBlobData);
    end;
  ADS_DATE,
  ADS_COMPACTDATE:
    AType := dtDate;
  ADS_TIME:
    begin
      AType := dtTime;
      AScale := 1;
    end;
  ADS_TIMESTAMP,
  ADS_MODTIME:
    begin
      AType := dtDateTimeStamp;
      AScale := 1;
    end;
  ADS_LOGICAL:
    AType := dtBoolean;
  ADS_GUID:
    AType := dtGUID;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.CreateParamInfos;
var
  i: Integer;
  oFmtOpts: TFDFormatOptions;
  oParams: TFDParams;
  oParam: TFDParam;
  iAdsParIndex, iAdsParRef: Integer;
  oAdsParam: TADSVariable;
  eDestFldType: TFieldType;
  eAttrs: TFDDataAttributes;
  iPrec, iScale: Integer;
  iLen: LongWord;
  pPar: PFDAdsParInfoRec;
  lFixedLen: Boolean;
begin
  oFmtOpts := FOptions.FormatOptions;
  oParams := GetParams;

  iAdsParIndex := 0;
  for i := 0 to oParams.Count - 1 do
    if oParams[i].ParamType in [ptUnknown, ptInput, ptInputOutput] then
      Inc(iAdsParIndex);

  FStmt.Params.Count := iAdsParIndex;
  SetLength(FParInfos, iAdsParIndex);

  iAdsParIndex := 0;
  for i := 0 to oParams.Count - 1 do begin
    oParam := oParams[i];
    if oParam.ParamType in [ptUnknown, ptInput, ptInputOutput] then begin
      pPar := @FParInfos[iAdsParIndex];
      case GetParams.BindMode of
      pbByName:   iAdsParRef := iAdsParIndex;
      pbByNumber: iAdsParRef := oParam.Position - 1;
      else        iAdsParRef := -1;
      end;
      if (iAdsParRef >= 0) and (iAdsParRef < FStmt.Params.Count) then begin
        oAdsParam := FStmt.Params[iAdsParRef];
        pPar^.FAdsParamIndex := iAdsParRef;
        pPar^.FParamIndex := i;
        pPar^.FParamType := oParam.ParamType;

        if oParam.DataType = ftUnknown then
          ParTypeUnknownError(oParam);

        pPar^.FSrcFieldType := oParam.DataType;
        oFmtOpts.ResolveFieldType('', oParam.DataTypeName, oParam.DataType,
          oParam.FDDataType, oParam.Size, oParam.Precision, oParam.NumericScale,
          eDestFldType, pPar^.FSrcSize, pPar^.FSrcPrec, pPar^.FSrcScale,
          pPar^.FSrcDataType, pPar^.FDestDataType, False);

        lFixedLen := pPar^.FSrcFieldType in [ftFixedChar, ftBytes, ftFixedWideChar];
        pPar^.FOutSQLDataType := FDType2SQL(pPar^.FDestDataType, lFixedLen);
        eAttrs := [];
        SQL2ADColInfo(pPar^.FOutSQLDataType, ADS_MEMO, pPar^.FSrcSize,
          pPar^.FSrcPrec, pPar^.FSrcScale, pPar^.FOutDataType,
          eAttrs, iLen, iPrec, iScale, oFmtOpts);

        case GetParams.BindMode of
        pbByName:   oAdsParam.Name := oParam.Name;
        pbByNumber: oAdsParam.Position := oParam.Position;
        end;
        oAdsParam.ValueType := pPar^.FOutSQLDataType;
      end;
      Inc(iAdsParIndex);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.DestroyParamInfos;
begin
  SetLength(FParInfos, 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.CreateColInfos;
var
  i: Integer;
  oDef: TADSColumnDef;
  oFmtOpts: TFDFormatOptions;
  iPrec, iScale: Integer;
  sKeyColumns: String;
  pCol: PFDAdsColInfoRec;
  oVar: TADSVariable;
begin
  oFmtOpts := FOptions.FormatOptions;
  SetLength(FColInfos, FCursor.ColumnDefsCount);
  FCursor.Columns.Count := FCursor.ColumnDefsCount;
  sKeyColumns := '';

  if (GetMetaInfoKind = mkNone) and (fiMeta in FOptions.FetchOptions.Items) then begin
    sKeyColumns := FCursor.KeyColumns;
    if sKeyColumns <> '' then
      sKeyColumns := ';' + AnsiUpperCase(sKeyColumns) + ';';
  end;

  for i := 0 to Length(FColInfos) - 1 do begin
    oDef := FCursor.ColumnDefs[i];
    try
      pCol := @FColInfos[i];
      pCol^.FName := oDef.Name;
      pCol^.FPos := i + 1;

      pCol^.FLen := oDef.Length;
      pCol^.FPrec := oDef.Precision;
      pCol^.FScale := oDef.Scale;
      pCol^.FSrcSQLDataType := oDef.FieldType;
      pCol^.FSrcSQLMemoType := oDef.MemoType;

      // ACE API does not provide more information about result set columns
      pCol^.FAttrs := [caAllowNull];
      if sKeyColumns <> '' then
        pCol^.FInPK := Pos(';' + AnsiUpperCase(pCol^.FName) + ';', sKeyColumns) > 0;

      if CompareText(pCol^.FName, 'ROWID') = 0 then begin
        Include(pCol^.FAttrs, caROWID);
        Include(pCol^.FAttrs, caAllowNull);
      end;

      SQL2ADColInfo(pCol^.FSrcSQLDataType, pCol^.FSrcSQLMemoType,
        pCol^.FLen, pCol^.FPrec, pCol^.FScale, pCol^.FSrcDataType,
        pCol^.FAttrs, pCol^.FADLen, iPrec, iScale, oFmtOpts);
      pCol^.FPrec := iPrec;
      pCol^.FScale := iScale;

      if GetMetaInfoKind = mkNone then
        oFmtOpts.ResolveDataType(pCol^.FName, '', pCol^.FSrcDataType,
          pCol^.FADLen, pCol^.FPrec, pCol^.FScale, pCol^.FDestDataType,
          pCol^.FADLen, True)
      else
        pCol^.FDestDataType := pCol^.FSrcDataType;

      if CheckFetchColumn(pCol^.FSrcDataType, pCol^.FAttrs) then begin
        oVar := FCursor.Columns[i];
        oVar.Position := pCol^.FPos;
        oVar.Name := oDef.Name;
        oVar.ValueType := oDef.FieldType;
        oVar.IsImage := oDef.MemoType = ADS_IMAGE;
        pCol^.FVar := oVar;
      end
      else
        pCol^.FVar := nil;
    finally
      FDFree(oDef);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.DestroyColInfos;
begin
  SetLength(FColInfos, 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.SetParamValue(AFmtOpts: TFDFormatOptions; AParam: TFDParam;
  AAdsParam: TADSVariable; ApInfo: PFDAdsParInfoRec; AParIndex: Integer);
var
  pData: PByte;
  iSize, iSrcSize: LongWord;
  oIntStr, oExtStr: TStream;
  lExtStream: Boolean;
begin
  pData := nil;
  iSize := 0;

  // null
  if (AParam.DataType <> ftStream) and AParam.IsNulls[AParIndex] then
    AAdsParam.SetData(nil, 0)

  // assign BLOB stream
  else if AParam.IsStreams[AParIndex] then begin
    oExtStr := AParam.AsStreams[AParIndex];
    lExtStream := (oExtStr <> nil) and
      not ((oExtStr is TADSBLOBStream) and (TADSBLOBStream(oExtStr).Obj = FStmt));
    if (AParam.DataType <> ftStream) and not lExtStream or
       (oExtStr <> nil) and (oExtStr.Size < 0) or
       not (ApInfo^.FOutDataType in C_FD_VarLenTypes) then
      UnsupParamObjError(AParam);
    oIntStr := AAdsParam.CreateBlobStream;
    try
      if lExtStream then
        oIntStr.CopyFrom(oExtStr, -1)
      else
        AParam.AsStreams[AParIndex] := oIntStr;
    finally
      if lExtStream then
        FDFree(oIntStr);
    end;
  end

  // conversion is not required
  else if ApInfo^.FSrcDataType = ApInfo^.FOutDataType then begin
    // byte string data, then optimizing - get data directly
    if ApInfo^.FOutDataType in C_FD_VarLenTypes then begin
      AParam.GetBlobRawData(iSize, pData, AParIndex);
      AAdsParam.SetData(pData, iSize);
    end
    else begin
      iSize := AParam.GetDataLength(AParIndex);
      FBuffer.Check(iSize);
      AParam.GetData(FBuffer.Ptr, AParIndex);
      AAdsParam.SetData(FBuffer.Ptr, iSize);
    end;
  end

  // conversion is required
  else begin
    // calculate buffer size to move param values
    iSrcSize := AParam.GetDataLength(AParIndex);
    FBuffer.Extend(iSrcSize, iSize, ApInfo^.FSrcDataType, ApInfo^.FOutDataType);

    // get, convert and set parameter value
    AParam.GetData(FBuffer.Ptr, AParIndex);
    AFmtOpts.ConvertRawData(ApInfo^.FSrcDataType, ApInfo^.FOutDataType,
      FBuffer.Ptr, iSrcSize, FBuffer.FBuffer, FBuffer.Size, iSize,
      ADSConnection.FConnection.Encoder);
    AAdsParam.SetData(FBuffer.Ptr, iSize);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.SetParamValues(AParIndex: Integer = 0);
var
  oFmtOpts: TFDFormatOptions;
  oParams: TFDParams;
  oParam: TFDParam;
  oAdsParam: TADSVariable;
  i: Integer;
  pParInfo: PFDAdsParInfoRec;
begin
  oParams := GetParams;
  if oParams.Count = 0 then
    Exit;

  oFmtOpts := GetOptions.FormatOptions;
  for i := 0 to Length(FParInfos) - 1 do begin
    pParInfo := @FParInfos[i];
    oParam := oParams[pParInfo^.FParamIndex];
    if (pParInfo^.FAdsParamIndex <> -1) and
       (oParam.DataType <> ftCursor) and
       (oParam.ParamType in [ptInput, ptInputOutput, ptUnknown]) then begin
      oAdsParam := FStmt.Params[pParInfo^.FAdsParamIndex];
      CheckParamMatching(oParam, pParInfo^.FSrcFieldType, pParInfo^.FParamType, 0);
      SetParamValue(oFmtOpts, oParam, oAdsParam, pParInfo, AParIndex);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.GetParamValues(AParIndex: Integer = 0);
var
  oTab: TFDDatSTable;
  i: Integer;
  oParams: TFDParams;
  oPar: TFDParam;
  ePrevState: TFDPhysCommandState;
begin
  oParams := GetParams;
  if (FCursor = nil) or (oParams.Count = 0) then
    Exit;

  SetupCursor(FCursor);
  FCursor.AddColumns;
  if FCursor.Columns.Count = 0 then
    Exit;

  CreateColInfos;

  oTab := TFDDatSTable.Create;
  oTab.Setup(FOptions);
  ePrevState := GetState;
  SetState(csOpen);
  try
    Define(oTab);
    if oTab.Columns.Count > 0 then begin
      FetchRow(oTab, nil);
      // SP parameters are binded by name
      for i := 0 to oTab.Columns.Count - 1 do begin
        oPar := oParams.FindParam(oTab.Columns[i].Name);
        if (oPar <> nil) and (oPar.ParamType in [ptOutput, ptInputOutput, ptResult]) then
          oPar.Values[AParIndex] := oTab.Rows[0].GetData(i);
      end;
    end;
  finally
    SetState(ePrevState);
    FDFree(oTab);
    DestroyColInfos;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.InternalUseStandardMetadata: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.InternalColInfoStart(var ATabInfo: TFDPhysDataTableInfo): Boolean;
begin
  Result := OpenBlocked;
  if ATabInfo.FSourceID = -1 then begin
    ATabInfo.FSourceName := GetCommandText;
    ATabInfo.FSourceID := 1;
    FColIndex := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.InternalColInfoGet(var AColInfo: TFDPhysDataColumnInfo): Boolean;
var
  pColInfo: PFDAdsColInfoRec;
begin
  if FColIndex < Length(FColInfos) then begin
    pColInfo := @FColInfos[FColIndex];

    AColInfo.FSourceName := pColInfo^.FName;
    AColInfo.FSourceID := pColInfo^.FPos;
    AColInfo.FSourceType := pColInfo^.FSrcDataType;
    AColInfo.FOriginTabName.FSchema := '';
    AColInfo.FOriginTabName.FObject := '';
    AColInfo.FOriginColName := '';
    AColInfo.FType := pColInfo^.FDestDataType;
    AColInfo.FLen := pColInfo^.FADLen;
    AColInfo.FPrec := pColInfo^.FPrec;
    AColInfo.FScale := pColInfo^.FScale;
    AColInfo.FAttrs := pColInfo^.FAttrs;
    AColInfo.FForceAddOpts := [];
    if pColInfo^.FInPK then
      Include(AColInfo.FForceAddOpts, coInKey);

    Inc(FColIndex);
    Result := True;
  end
  else
    Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.InternalExecute(ATimes, AOffset: Integer;
  var ACount: TFDCounter);
var
  i, iArraySize: Integer;
  iTimes: Integer;
  iCount: TFDCounter;
begin
  SetupStatementBeforeExecute(FStmt);
  if ATimes - AOffset > 1 then begin
    iArraySize := GetParams.ArraySize;
    if ATimes > iArraySize then
      iTimes := iArraySize
    else
      iTimes := ATimes;
    for i := AOffset to iTimes - 1 do begin
      iCount := 0;
      InternalExecute(i + 1, i, iCount);
      Inc(ACount, iCount);
    end;
  end

  else begin
    SetParamValues(AOffset);
    ADSConnection.FConnection.EnableProgress;
    try
      try
        if UseExecDirect then
          FStmt.ExecuteDirect(FDbCommandText)
        else
          FStmt.Execute;
      except
        on E: EAdsNativeException do begin
          E.Errors[0].RowIndex := AOffset;
          raise;
        end;
      end;
    finally
      ADSConnection.FConnection.DisableProgress;
      Inc(ACount, FStmt.RecordCount);
    end;
    FCursor := FStmt.GetCursor;
    if FCursor <> nil then
      try
        GetParamValues;
      finally
        InternalClose;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.InternalOpen: Boolean;
begin
  Result := False;
  if (GetMetaInfoKind <> mkNone) and (FDbCommandText = '') then
    Exit;
  SetupStatementBeforeExecute(FStmt);
  ADSConnection.FConnection.EnableProgress;
  try
    SetParamValues;
    try
      if UseExecDirect then
        FStmt.ExecuteDirect(FDbCommandText)
      else
        FStmt.Execute;
      FCursor := FStmt.GetCursor;
      if FCursor <> nil then begin
        SetupCursor(FCursor);
        CreateColInfos;
        Result := Length(FColInfos) > 0;
      end;
    except
      on E: Exception do begin
        InternalClose;
        if not ((GetMetaInfoKind <> mkNone) and
                (E is EADSNativeException) and
                (EADSNativeException(E).Kind = ekObjNotExists)) then
          raise;
      end;
    end;
  finally
    ADSConnection.FConnection.DisableProgress;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.InternalNextRecordSet: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.FetchRow(ATable: TFDDatSTable; AParentRow: TFDDatSRow);
var
  oRow: TFDDatSRow;
  oFmtOpts: TFDFormatOptions;
  pColInfo: PFDAdsColInfoRec;
  j: Integer;
  lMetadata: Boolean;
  oCol: TFDDatSColumn;

  procedure ProcessColumn(AColIndex: Integer; ARow: TFDDatSRow;
    ApInfo: PFDAdsColInfoRec);
  var
    iSize: Integer;
    iDestSize: LongWord;
    lIsVal: Boolean;
    oVar: TADSVariable;
  begin
    iSize := 0;
    oVar := ApInfo^.FVar;
    if (oVar = nil) or not CheckFetchColumn(ApInfo^.FSrcDataType, ApInfo^.FAttrs) then
      Exit

    // null
    else if oVar.IsNull then
      lIsVal := False

    // conversion is not required
    else if ApInfo^.FSrcDataType = ApInfo^.FDestDataType then begin
      if ApInfo^.FSrcDataType in C_FD_BlobTypes then
        iSize := oVar.GetDataLength
      else
        iSize := ApInfo^.FLen;
      FBuffer.Check((iSize + 1) * SizeOf(WideChar));
      lIsVal := oVar.GetData(FBuffer.FBuffer, iSize);
      if lIsVal then
        ARow.SetData(AColIndex, FBuffer.Ptr, iSize);
    end

    // conversion is required
    else begin
      if ApInfo^.FSrcDataType in C_FD_BlobTypes then
        iSize := oVar.GetDataLength
      else
        iSize := ApInfo^.FLen;
      FBuffer.Check((iSize + 1) * SizeOf(WideChar));
      lIsVal := oVar.GetData(FBuffer.FBuffer, iSize);
      if lIsVal then begin
        iDestSize := 0;
        oFmtOpts.ConvertRawData(ApInfo^.FSrcDataType, ApInfo^.FDestDataType,
          FBuffer.Ptr, iSize, FBuffer.FBuffer, FBuffer.Size, iDestSize,
          ADSConnection.FConnection.Encoder);
        ARow.SetData(AColIndex, FBuffer.Ptr, iDestSize);
      end;
    end;
    if not lIsVal then
      ARow.SetData(AColIndex, nil, 0);
  end;

  procedure ProcessMetaColumn(AColIndex: Integer; ARow: TFDDatSRow;
    ApInfo: PFDAdsColInfoRec);
  var
    iSize: Integer;
    iDestSize: Longword;
    lIsVal: Boolean;
    oVar: TADSVariable;
  begin
    iSize := 0;
    oVar := ApInfo^.FVar;
    if oVar = nil then
      Exit

    else if AColIndex = 0 then begin
      lIsVal := True;
      ARow.SetData(0, ATable.Rows.Count + 1);
    end

    else if oVar.IsNull then
      lIsVal := False

    else begin
      FBuffer.Check((ApInfo^.FLen + 1) * SizeOf(WideChar));
      lIsVal := oVar.GetData(FBuffer.FBuffer, iSize);
      if lIsVal then begin
        iDestSize := 0;
        if (ApInfo^.FDestDataType in C_FD_AnsiTypes) or
           (ApInfo^.FDestDataType in [dtInt16, dtInt32, dtDouble, dtBCD, dtFmtBCD]) then
          oFmtOpts.ConvertRawData(ApInfo^.FDestDataType, ATable.Columns[AColIndex].DataType,
            FBuffer.Ptr, iSize, FBuffer.FBuffer, FBuffer.Size, iDestSize,
            ADSConnection.FConnection.Encoder)
        else
          iDestSize := iSize;
        ARow.SetData(AColIndex, FBuffer.Ptr, iDestSize);
      end;
    end;
    if not lIsVal then
      ARow.SetData(AColIndex, nil, 0)
  end;

begin
  oFmtOpts := FOptions.FormatOptions;
  oRow := ATable.NewRow(False);
  lMetadata := GetMetaInfoKind <> mkNone;
  try
    for j := 0 to ATable.Columns.Count - 1 do begin
      oCol := ATable.Columns[j];
      if oCol.SourceID > 0 then begin
        pColInfo := @FColInfos[oCol.SourceID - 1];
        if lMetadata then
          ProcessMetaColumn(j, oRow, pColInfo)
        else
          ProcessColumn(j, oRow, pColInfo);
      end;
    end;
    if AParentRow <> nil then begin
      oRow.ParentRow := AParentRow;
      AParentRow.Fetched[ATable.Columns.ParentCol] := True;
    end;
    ATable.Rows.Add(oRow);
  except
    FDFree(oRow);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.FetchMetaRow(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow; ARowNo: Integer): Boolean;
var
  oRow: TFDDatSRow;
  iRecNo: Integer;
  lDeleteRow: Boolean;
  pData: Pointer;
  i, iSize: Integer;
  eTableKind: TFDPhysTableKind;
  eScope: TFDPhysObjectScope;
  eAttrs: TFDDataAttributes;
  {iAdsType,} iAdsSize, iAdsDec: Integer;
  iLen: LongWord;
  iPrec, iScale: Integer;
  eType: TFDDataType;
  eIndKind: TFDPhysIndexKind;
  oConnMeta: IFDPhysConnectionMetadata;
  rName: TFDPhysParsedName;
  eCascade: TFDPhysCascadeRuleKind;
  eProcKind: TFDPhysProcedureKind;
  eParType: TParamType;
  s: String;

  procedure DecodeColInfo(ASQLDataType: String; ASQLLen, ASQLScale: Integer;
    out AType: TFDDataType; var AAttrs: TFDDataAttributes; out ALen: LongWord;
    out APrec, AScale: Integer);
  begin
    AType := dtUnknown;
    ALen := 0;
    APrec := 0;
    AScale := 0;
    Exclude(AAttrs, caFixedLen);
    Exclude(AAttrs, caBlobData);
    Include(AAttrs, caSearchable);
    if (ASQLDataType = 'SHORT') or (ASQLDataType = 'SHORTINT') then
      AType := dtInt16
    else if (ASQLDataType = 'INTEGER') or (ASQLDataType = 'Integer') then
      AType := dtInt32
    else if ASQLDataType = 'LONG' then
      AType := dtInt64
    else if ASQLDataType = 'AUTOINC' then begin
      AType := dtInt32;
      AAttrs := AAttrs + [caAutoInc];
    end
    else if ASQLDataType = 'ROWVERSION' then begin
      AType := dtInt64;
      AAttrs := AAttrs + [caRowVersion, caReadOnly];
    end
    else if ASQLDataType = 'DOUBLE' then begin
      AType := dtDouble;
    end
    else if ASQLDataType = 'CURDOUBLE' then begin
      AType := dtCurrency;
      APrec := 15;
      AScale := 4;
    end
    else if (ASQLDataType = 'MONEY') or (ASQLDataType = 'Money') then begin
      AType := dtCurrency;
      APrec := 19;
      AScale := 4;
    end
    else if (ASQLDataType = 'NUMERIC') or (ASQLDataType = 'Numeric') then begin
      if (ASQLLen - 2 > 18) or (ASQLScale > 4) then
        AType := dtBCD
      else
        AType := dtFmtBCD;
      APrec := ASQLLen - 2;
      AScale := ASQLScale;
    end
    else if (ASQLDataType = 'CHAR') or (ASQLDataType = 'CHARACTER') or
            (ASQLDataType = 'CICHAR') or (ASQLDataType = 'CICHARACTER') then begin
      AType := dtAnsiString;
      AAttrs := AAttrs + [caFixedLen];
      ALen := ASQLLen;
    end
    else if (ASQLDataType = 'VARCHAR') or (ASQLDataType = 'VARCHARFOX') then begin
      AType := dtAnsiString;
      ALen := ASQLLen;
    end
    else if ASQLDataType = 'NCHAR' then begin
      AType := dtWideString;
      AAttrs := AAttrs + [caFixedLen];
      ALen := ASQLLen;
    end
    else if ASQLDataType = 'NVARCHAR' then begin
      AType := dtWideString;
      ALen := ASQLLen;
    end
    else if (ASQLDataType = 'MEMO') or (ASQLDataType = 'Memo') then begin
      AType := dtMemo;
      AAttrs := AAttrs + [caBlobData] - [caSearchable];
    end
    else if ASQLDataType = 'NMEMO' then begin
      AType := dtWideMemo;
      AAttrs := AAttrs + [caBlobData] - [caSearchable];
    end
    else if ASQLDataType = 'RAW' then begin
      AType := dtByteString;
      AAttrs := AAttrs + [caFixedLen];
      ALen := ASQLLen;
    end
    else if (ASQLDataType = 'VARBINARY') or (ASQLDataType = 'VARBINARYFOX') then begin
      AType := dtByteString;
      ALen := ASQLLen;
    end
    else if (ASQLDataType = 'BINARY') or (ASQLDataType = 'BLOB') or
            (ASQLDataType = 'IMAGE') then begin
      AType := dtBlob;
      AAttrs := AAttrs + [caBlobData] - [caSearchable];
    end
    else if (ASQLDataType = 'DATE') or
            (ASQLDataType = 'SHORTDATE') then
      AType := dtDate
    else if ASQLDataType = 'TIME' then
      AType := dtTime
    else if (ASQLDataType = 'TIMESTAMP') or
            (ASQLDataType = 'MODTIME') then
      AType := dtDateTimeStamp
    else if ASQLDataType = 'LOGICAL' then
      AType := dtBoolean
    else if ASQLDataType = 'GUID' then
      AType := dtGUID;
  end;

  function GetCrsData(ACrsIndex, ARowIndex: Integer): Boolean;
  var
    pOut: Pointer;
  begin
    iSize := 0;
    Result := FCursor.Columns[ACrsIndex].GetData(pData, iSize);
    if not Result then begin
      pOut := nil;
      iSize := 0;
    end
    else if ATable.Columns[ARowIndex].DataType in C_FD_WideTypes then begin
      pOut := nil;
      iSize := FMetaEncoder.Decode(pData, iSize, pOut, ecUTF16);
    end
    else
      pOut := pData;
    oRow.SetData(ARowIndex, pOut, iSize);
  end;

begin
  lDeleteRow := False;
  iRecNo := ATable.Rows.Count + 1;
  oRow := ATable.NewRow(False);
  pData := FBuffer.Check(1024);
  try
    FConnection.CreateMetadata(oConnMeta);
    case GetMetaInfoKind of
    mkCatalogs:
      begin
        oRow.SetData(0, iRecNo);
        GetCrsData(0, 1);
        if (GetWildcard <> '') and
           not FDStrLike(VarToStr(oRow.GetData(1, rvDefault)), GetWildcard, True) then
          lDeleteRow := True;
      end;
    mkTables:
      begin
        oRow.SetData(0, iRecNo);
        GetCrsData(0, 1);
        GetCrsData(1, 2);
        GetCrsData(2, 3);
        iSize := 0;
        eTableKind := tkTable;
        eScope := osOther;
        if FCursor.Columns[3].GetData(pData, iSize) then begin
          eScope := osMy;
          s := FMetaEncoder.Decode(pData, iSize);
          if StrLIComp(PChar(s), 'TABLE', iSize) = 0 then
            eTableKind := tkTable
          else if StrLIComp(PChar(s), 'VIEW', iSize) = 0 then
            eTableKind := tkView
          else if StrLIComp(PChar(s), 'SYSTEM TABLE', iSize) = 0 then begin
            eTableKind := tkTable;
            eScope := osSystem;
          end
          else if StrLIComp(PChar(s), 'LOCAL TEMPORARY', iSize) = 0 then
            eTableKind := tkLocalTable
        end;
        oRow.SetData(4, Smallint(eTableKind));
        oRow.SetData(5, Smallint(eScope));
        lDeleteRow := not (eTableKind in GetTableKinds) or
                      not (eScope in GetObjectScopes);
      end;
    mkTableFields:
      begin
        oRow.SetData(0, iRecNo);
        GetCrsData(0, 1);
        GetCrsData(1, 2);
        GetCrsData(2, 3);
        GetCrsData(3, 4);
        iSize := 0;
        if FCursor.Columns.Count >= 17 then begin
          if FCursor.Columns[16].GetData(pData, iSize) then
            oRow.SetData(5, PInteger(pData)^);
        end
        else
          oRow.SetData(5, iRecNo);
        eAttrs := [caBase];
        iSize := 0;
        if FCursor.Columns[5].GetData(pData, iSize) then begin
          s := FMetaEncoder.Decode(pData, iSize);
          if StrLIComp(PChar(s), 'AUTOINC', iSize) = 0 then begin
            Include(eAttrs, caAutoInc);
            Include(eAttrs, caReadOnly);
          end
          else if StrLIComp(PChar(s), 'ROWVERSION', iSize) = 0 then begin
            Include(eAttrs, caRowVersion);
            Include(eAttrs, caReadOnly);
          end;
          oRow.SetData(7, pData, iSize);
        end;
        iSize := 0;
        if FCursor.Columns.Count >= 13 then
          if FCursor.Columns[12].GetData(pData, iSize) and (iSize > 0) then begin
            s := FMetaEncoder.Decode(pData, iSize);
            if StrLIComp(PChar(s), 'NULL', iSize) <> 0 then
              Include(eAttrs, caDefault);
          end;
        iSize := 0;
        if not FCursor.Columns[10].GetData(pData, iSize) or
           (PSIGNED16(pData)^ <> 0) then
          Include(eAttrs, caAllowNull);
        iSize := 0;
        { if FCursor.Columns[4].GetData(pData, iSize) then
          iAdsType := PSIGNED16(pData)^
        else
          iAdsType := 0; }
        iSize := 0;
        if FCursor.Columns[6].GetData(pData, iSize) then
          iAdsSize := PSIGNED32(pData)^
        else
          iAdsSize := 0;
        iSize := 0;
        if FCursor.Columns[8].GetData(pData, iSize) then
          iAdsDec := PSIGNED16(pData)^
        else
          iAdsDec := 0;
        DecodeColInfo(oRow.GetData(7), iAdsSize, iAdsDec, eType, eAttrs,
          iLen, iPrec, iScale);
        oRow.SetData(6, Smallint(eType));
        oRow.SetData(8, PWord(@eAttrs)^);
        oRow.SetData(9, iPrec);
        oRow.SetData(10, iScale);
        oRow.SetData(11, iLen);
      end;
    mkIndexes:
      begin
        iSize := 0;
        if FCursor.Columns[6].GetData(pData, iSize) and
           (PSIGNED16(pData)^ = 0) then
          lDeleteRow := True
        else begin
          oRow.SetData(0, iRecNo);
          GetCrsData(0, 1);
          GetCrsData(1, 2);
          GetCrsData(2, 3);
          GetCrsData(5, 4);
          iSize := 0;
          if FCursor.Columns[3].GetData(pData, iSize) and
             (PWordBool(pData)^ = False) then
            eIndKind := ikUnique
          else
            eIndKind := ikNonUnique;
          FMetainfoAddonView.RowFilter := 'INDEX_NAME = ''' + VarToStr(oRow.GetData(4)) + '''';
          if FMetainfoAddonView.Rows.Count > 0 then begin
            eIndKind := ikPrimaryKey;
            oRow.SetData(5, FMetainfoAddonView.Rows[0].GetData(5));
          end;
          oRow.SetData(6, Smallint(eIndKind));
          FMetainfoAddonView.RowFilter := '';
          for i := 0 to ATable.Rows.Count - 1 do
            if (VarToStr(ATable.Rows[i].GetData(1, rvDefault)) = VarToStr(oRow.GetData(1, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(2, rvDefault)) = VarToStr(oRow.GetData(2, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(3, rvDefault)) = VarToStr(oRow.GetData(3, rvDefault))) and
               (VarToStr(ATable.Rows[i].GetData(4, rvDefault)) = VarToStr(oRow.GetData(4, rvDefault))) then begin
              lDeleteRow := True;
              Break;
            end;
          if not lDeleteRow and (GetWildcard <> '') and
             not FDStrLike(VarToStr(oRow.GetData(4, rvDefault)), GetWildcard, True) then
            lDeleteRow := True;
        end;
      end;
    mkIndexFields:
      begin
        iSize := 0;
        if FCursor.Columns[6].GetData(pData, iSize) and
           (PSIGNED16(pData)^ = 0) then
          lDeleteRow := True
        else begin
          oRow.SetData(0, iRecNo);
          GetCrsData(0, 1);
          GetCrsData(1, 2);
          GetCrsData(2, 3);
          GetCrsData(5, 4);
          GetCrsData(8, 5);
          iSize := 0;
          if FCursor.Columns[7].GetData(pData, iSize) then
            oRow.SetData(6, PSIGNED16(pData)^);
          GetCrsData(9, 7);
          GetCrsData(12, 8);
          oConnMeta.DecodeObjName(Trim(GetCommandText), rName, Self,
            [doNormalize, doUnquote]);
          lDeleteRow := (AnsiCompareText(rName.FObject,
            Trim(VarToStr(oRow.GetData(4, rvDefault)))) <> 0);
          if not lDeleteRow and (GetWildcard <> '') and
             not FDStrLike(VarToStr(oRow.GetData(5, rvDefault)), GetWildcard, True) then
            lDeleteRow := True;
        end;
      end;
    mkPrimaryKey:
      begin
        oRow.SetData(0, iRecNo);
        GetCrsData(0, 1);
        GetCrsData(1, 2);
        GetCrsData(2, 3);
        iSize := 0;
        if FCursor.Columns.Count >= 6 then begin
          GetCrsData(5, 4);
          GetCrsData(5, 5);
        end;
        oRow.SetData(6, Smallint(ikPrimaryKey));
        for i := 0 to ATable.Rows.Count - 1 do
          if (VarToStr(ATable.Rows[i].GetData(1, rvDefault)) = VarToStr(oRow.GetData(1, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(2, rvDefault)) = VarToStr(oRow.GetData(2, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(3, rvDefault)) = VarToStr(oRow.GetData(3, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(5, rvDefault)) = VarToStr(oRow.GetData(5, rvDefault))) then begin
            lDeleteRow := True;
            Break;
          end;
        if not lDeleteRow and (GetWildcard <> '') and
           not FDStrLike(VarToStr(oRow.GetData(4, rvDefault)), GetWildcard, True) then
          lDeleteRow := True;
      end;
    mkPrimaryKeyFields:
      begin
        oRow.SetData(0, iRecNo);
        GetCrsData(0, 1);
        GetCrsData(1, 2);
        GetCrsData(2, 3);
        if FCursor.Columns.Count >= 6 then
          GetCrsData(5, 4);
        GetCrsData(3, 5);
        iSize := 0;
        if FCursor.Columns[4].GetData(pData, iSize) then
          oRow.SetData(6, PSIGNED16(pData)^);
        oRow.SetData(7, 'A');
        if not lDeleteRow and (GetWildcard <> '') and
           not FDStrLike(VarToStr(oRow.GetData(5, rvDefault)), GetWildcard, True) then
          lDeleteRow := True;
      end;
    mkForeignKeys:
      begin
        oRow.SetData(0, iRecNo);
        GetCrsData(4, 1);
        GetCrsData(5, 2);
        GetCrsData(6, 3);
        GetCrsData(11, 4);
        GetCrsData(0, 5);
        GetCrsData(1, 6);
        GetCrsData(2, 7);
        iSize := 0;
        if FCursor.Columns[10].GetData(pData, iSize) then begin
          eCascade := ckNone;
          case PSIGNED16(pData)^ of
          0: eCascade := ckCascade;
          2: eCascade := ckSetNull;
          3: eCascade := ckRestrict;
          4: eCascade := ckSetDefault;
          end;
          oRow.SetData(8, SmallInt(eCascade));
        end;
        iSize := 0;
        if FCursor.Columns[9].GetData(pData, iSize) then begin
          eCascade := ckNone;
          case PSIGNED16(pData)^ of
          0: eCascade := ckCascade;
          2: eCascade := ckSetNull;
          3: eCascade := ckRestrict;
          4: eCascade := ckSetDefault;
          end;
          oRow.SetData(9, SmallInt(eCascade));
        end;
        for i := 0 to ATable.Rows.Count - 1 do
          if (VarToStr(ATable.Rows[i].GetData(1, rvDefault)) = VarToStr(oRow.GetData(1, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(2, rvDefault)) = VarToStr(oRow.GetData(2, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(3, rvDefault)) = VarToStr(oRow.GetData(3, rvDefault))) and
             (VarToStr(ATable.Rows[i].GetData(4, rvDefault)) = VarToStr(oRow.GetData(4, rvDefault))) then begin
            lDeleteRow := True;
            Break;
          end;
        if not lDeleteRow and (GetWildcard <> '') and
           not FDStrLike(VarToStr(oRow.GetData(4, rvDefault)), GetWildcard, True) then
          lDeleteRow := True;
      end;
    mkForeignKeyFields:
      begin
        oRow.SetData(0, iRecNo);
        GetCrsData(4, 1);
        GetCrsData(5, 2);
        GetCrsData(6, 3);
        GetCrsData(11, 4);
        GetCrsData(7, 5);
        GetCrsData(3, 6);
        GetCrsData(8, 7);
        oConnMeta.DecodeObjName(Trim(GetCommandText), rName, Self,
          [doNormalize, doUnquote]);
        lDeleteRow := (AnsiCompareText(rName.FObject,
          Trim(VarToStr(oRow.GetData(4, rvDefault)))) <> 0);
        if not lDeleteRow and (GetWildcard <> '') and
           not FDStrLike(VarToStr(oRow.GetData(5, rvDefault)), GetWildcard, True) then
          lDeleteRow := True;
      end;
    mkProcs:
      begin
        oRow.SetData(0, iRecNo);
        GetCrsData(0, 1);
        GetCrsData(1, 2);
        GetCrsData(2, 4);
        iSize := 0;
        if FCursor.Columns[7].GetData(pData, iSize) and
           (PSIGNED16(pData)^ = 2) then
          eProcKind := pkFunction
        else
          eProcKind := pkProcedure;
        oRow.SetData(6, Smallint(eProcKind));
        eScope := osMy;
        oRow.SetData(7, Smallint(eScope));
        iSize := 0;
        if FCursor.Columns[3].GetData(pData, iSize) then
          if PInteger(pData)^ = -1 then
            oRow.SetData(8, 0)
          else
            oRow.SetData(8, PInteger(pData)^);
        iSize := 0;
        if FCursor.Columns[4].GetData(pData, iSize) then
          if PInteger(pData)^ = -1 then
            oRow.SetData(9, 0)
          else
            oRow.SetData(9, PInteger(pData)^);
        lDeleteRow := not (eScope in GetObjectScopes);
        if not lDeleteRow and (GetWildcard <> '') and
           not FDStrLike(VarToStr(oRow.GetData(4, rvDefault)), GetWildcard, True) then
          lDeleteRow := True;
      end;
    mkProcArgs:
      begin
        oRow.SetData(0, iRecNo);
        GetCrsData(0, 1);
        GetCrsData(1, 2);
        GetCrsData(2, 4);
        GetCrsData(3, 6);
        oRow.SetData(7, iRecNo);
        eParType := ptUnknown;
        iSize := 0;
        if FCursor.Columns[4].GetData(pData, iSize) then
          case PSIGNED16(pData)^ of
          1:    eParType := ptInput;
          2:    eParType := ptInputOutput;
          3, 4: eParType := ptOutput;
          5:    eParType := ptResult;
          end;
        oRow.SetData(8, Smallint(eParType));
        GetCrsData(6, 10);
        eAttrs := [];
        iSize := 0;
        if not FCursor.Columns[11].GetData(pData, iSize) or
           (PSIGNED16(pData)^ <> 0) then
          Include(eAttrs, caAllowNull);
        iSize := 0;
        { if FCursor.Columns[5].GetData(pData, iSize) then
          iAdsType := PSIGNED16(pData)^
        else
          iAdsType := 0; }
        iSize := 0;
        if FCursor.Columns[7].GetData(pData, iSize) then
          iAdsSize := PInteger(pData)^
        else
          iAdsSize := 0;
        iSize := 0;
        if FCursor.Columns[9].GetData(pData, iSize) then
          iAdsDec := PSIGNED16(pData)^
        else
          iAdsDec := 0;
        DecodeColInfo(oRow.GetData(10), iAdsSize, iAdsDec, eType, eAttrs,
          iLen, iPrec, iScale);
        oRow.SetData(9, Smallint(eType));
        oRow.SetData(11, PWord(@eAttrs)^);
        oRow.SetData(12, iPrec);
        oRow.SetData(13, iScale);
        oRow.SetData(14, iLen);
      end;
    end;
    if lDeleteRow then begin
      FDFree(oRow);
      Result := False;
    end
    else begin
      ATable.Rows.Add(oRow);
      Result := True;
    end;
  except
    FDFree(oRow);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSCommand.InternalFetchRowSet(ATable: TFDDatSTable;
  AParentRow: TFDDatSRow; ARowsetSize: LongWord): LongWord;

  procedure DoLock;
  var
    iTimeout: Cardinal;
  begin
    if FOptions.UpdateOptions.LockWait then
      iTimeout := FOptions.ResourceOptions.CmdExecTimeout
    else
      iTimeout := 0;
    FCursor.Lock(0, iTimeout);
  end;

var
  i: LongWord;
begin
  Result := 0;
  if not (GetMetaInfoKind in [mkNone, mkPackages]) and
     (ADSConnection.FServerVersion < caADS10) then
    for i := 1 to ARowsetSize do begin
      if FCursor.Eof then
        Break;
      if FetchMetaRow(ATable, AParentRow, Result + 1) then
        Inc(Result);
      FCursor.Skip(1);
    end
  else
    for i := 1 to ARowsetSize do begin
      if FCursor.Eof then
        Break;
      // Advantage has incompatible navigational and SQL locking systems.
      // A lock placed by AdsLockRecord will block SQL updates to the same
      // record in the same session and transaction.
      { case GetCommandKind of
      skSelectForLock:   DoLock;
      skSelectForUnLock: FCursor.UnLock(0);
      end; }
      FetchRow(ATable, AParentRow);
      Inc(Result);
      FCursor.Skip(1);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.InternalAbort;
begin
  ADSConnection.FConnection.Abort;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.InternalClose;
begin
  if FCursor <> nil then
    FDFreeAndNil(FCursor);
  if FStmt <> nil then
    FStmt.Close;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSCommand.InternalUnprepare;
begin
  if FStmt = nil then
    Exit;
  FStmt.Unprepare;
  DestroyColInfos;
  DestroyParamInfos;
  FDFreeAndNil(FStmt);
  FMetainfoAddonView := nil;
  FPasswordsSet := False;
end;

{-------------------------------------------------------------------------------}
initialization
  FDPhysManager().RegisterDriverClass(TFDPhysADSDriver);

end.
