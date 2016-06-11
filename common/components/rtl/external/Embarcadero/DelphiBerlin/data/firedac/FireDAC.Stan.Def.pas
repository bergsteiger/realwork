{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC persistent definitions             }
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
    {$HPPEMIT '#pragma link "FireDAC.Stan.Def.obj"'}
  {$ELSE}
    {$HPPEMIT '#pragma link "FireDAC.Stan.Def.o"'}
  {$ENDIF}
{$ENDIF}

unit FireDAC.Stan.Def;

interface

uses
  FireDAC.Stan.Intf;

function FDLoadConnDefGlobalFileName: String;
procedure FDSaveConnDefGlobalFileName(const AName: String);
function FDLoadDriverDefGlobalFileName: String;
procedure FDSaveDriverDefGlobalFileName(const AName: String);

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, System.IniFiles,
  FireDAC.Stan.Factory, FireDAC.Stan.Util, FireDAC.Stan.Error, FireDAC.Stan.Consts, 
    FireDAC.Stan.Option, FireDAC.Stan.ResStrs;

type
  TFDCustomDefinitionStorage = class;
  TFDFileDefinitionStorage = class;
  TFDDefinition = class;
  TFDDefinitions = class;
  TFDDefinitionClass = class of TFDDefinition;
  TFDConnectionDef = class;
  TFDConnectionDefs = class;

  TFDCustomDefinitionStorage = class (TFDObject, IFDStanDefinitionStorage)
  private
    FFileName: String;
    FGlobalFileName: String;
    FDefaultFileName: String;
  protected
    // IFDStanDefinitionStorage
    function GetFileName: String;
    procedure SetFileName(const AValue: String);
    function GetGlobalFileName: String;
    procedure SetGlobalFileName(const AValue: String);
    function GetDefaultFileName: String;
    procedure SetDefaultFileName(const AValue: String);
    function CreateIniFile: TCustomIniFile; virtual; abstract;
    function ActualFileName: String; virtual; abstract;
  end;

  TFDFileDefinitionStorage = class(TFDCustomDefinitionStorage)
  public
    function CreateIniFile: TCustomIniFile; override;
    function ActualFileName: String; override;
  end;

  TFDDefinitionFlag = (dfParentMaybeChanged, dfRefManaged, dfDeleteDisabled,
    dfModifyDisabled);
  TFDDefinitionFlags = set of TFDDefinitionFlag;

  TFDDefinition = class (TCollectionItem, IUnknown, IFDStanDefinition)
  private
{$IFNDEF AUTOREFCOUNT}
    FRefCount: Integer;
{$ENDIF}
    FOriginalName,
    FPrevName: String;
    FParams: TFDStringList;
    FState: TFDDefinitionState;
    FStyle: TFDDefinitionStyle;
    FFlags: TFDDefinitionFlags;
    FParentDefinition: IFDStanDefinition;
    FOnChanging: TNotifyEvent;
    FOnChanged: TNotifyEvent;
    FPassCode: LongWord;
    function GetDefinitionList: TFDDefinitions;
    procedure ParamsChanging(Sender: TObject);
    procedure CheckRO(AFlag: TFDDefinitionFlag);
    procedure UpdateParentDefinition;
    procedure InternalSetParentDefinition(const AValue: IFDStanDefinition);
  protected
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IFDStanDefinition
    function GetName: String;
    function GetParams: TStrings;
    function GetAsBoolean(const AName: String): LongBool;
    function GetAsInteger(const AName: String): LongInt;
    function GetAsString(const AName: String): String;
    function GetAsXString(const AName: String): String;
    function GetState: TFDDefinitionState;
    function GetStyle: TFDDefinitionStyle;
    function GetParentDefinition: IFDStanDefinition;
    function GetOnChanging: TNotifyEvent;
    function GetOnChanged: TNotifyEvent;
    function GetUpdatable: Boolean;
    procedure SetName(const AValue: string);
    procedure SetParams(const AValue: TStrings);
    procedure SetAsBoolean(const AName: String; const AValue: LongBool);
    procedure SetAsYesNo(const AName: String; const AValue: LongBool);
    procedure SetAsInteger(const AName: String; const AValue: LongInt);
    procedure SetAsString(const AName, AValue: String);
    procedure SetParentDefinition(const AValue: IFDStanDefinition);
    procedure SetOnChanging(AValue: TNotifyEvent);
    procedure SetOnChanged(AValue: TNotifyEvent);
{$IFDEF FireDAC_MONITOR}
    procedure BaseTrace(const AMonitor: IFDMoniClient);
    procedure Trace(const AMonitor: IFDMoniClient);
{$ENDIF}
    procedure Apply;
    procedure Clear;
    procedure Cancel;
    procedure Delete;
    procedure MarkPersistent; virtual;
    procedure MarkUnchanged;
    procedure OverrideBy(const ADefinition: IFDStanDefinition; AAll: Boolean);
    function ParseString(const AStr: String; AKeywords: TStrings = nil): String; overload;
    function ParseString(const AStr: String; AKeywords: TStrings; const AFmt: TFDParseFmtSettings): String; overload;
    function BuildString(AKeywords: TStrings = nil): String; overload;
    function BuildString(AKeywords: TStrings; const AFmt: TFDParseFmtSettings): String; overload;
    function HasValue(const AName: String): Boolean; overload;
    function HasValue(const AName: String; var ALevel: Integer): Boolean; overload;
    function OwnValue(const AName: String): Boolean;
    function IsSpecified(const AName: String): Boolean;
    procedure ToggleUpdates(APassCode: LongWord; ADisableDelete, ADisableModify: Boolean);
    // other
    procedure Normalize; virtual;
    procedure ParamsChanged(Sender: TObject);
    procedure ReadFrom(AReader: TCustomIniFile);
    procedure WriteTo(AWriter: TCustomIniFile; AIfModified: Boolean = True);
  public
    constructor Create(ACollection: TCollection); override;
    constructor CreateTemporary;
    destructor Destroy; override;
{$IFNDEF AUTOREFCOUNT}
    procedure AfterConstruction; override;
    class function NewInstance: TObject; override;
{$ENDIF}
    property OriginalName: String read FOriginalName;
    property DefinitionList: TFDDefinitions read GetDefinitionList;
  end;

  TFDDefinitionTemporaryFactory = class(TFDMultyInstanceFactory)
  protected
    function CreateObject(const AProvider: String): TObject; override;
  public
    constructor Create;
  end;

  TFDDefinitionsState = (dsNotLoaded, dsLoading, dsLoaded);
  TFDDefinitions = class (TFDObject, IFDStanDefinitions)
  private
    FAutoLoad: Boolean;
    FState: TFDDefinitionsState;
    FStorage: IFDStanDefinitionStorage;
    FList: TCollection;
    FLock: TMultiReadExclusiveWriteSynchronizer;
    FBeforeLoad,
    FAfterLoad: TNotifyEvent;
    FName: String;
    procedure InternalDelete(ADefinition: TFDDefinition);
    function InternalAdd: TFDDefinition;
    function InternalLoad(ARefresh: Boolean): Boolean;
    procedure CheckLoaded;
    function InternalFindDefinition(const AName: String;
      AExclude: TFDDefinition): TFDDefinition;
    function BuildUniqueName(const AName: String; AItem: TFDDefinition): String;
    function IsUniqueName(const AName: String; AItem: TFDDefinition): Boolean;
  protected
    // IFDStanDefinitions
    function GetCount: Integer;
    function GetItems(AIndex: Integer): IFDStanDefinition;
    function GetAutoLoad: Boolean;
    function GetStorage: IFDStanDefinitionStorage;
    function GetLoaded: Boolean;
    function GetBeforeLoad: TNotifyEvent;
    function GetAfterLoad: TNotifyEvent;
    function GetUpdatable: Boolean;
    function GetName: String;
    procedure SetAutoLoad(AValue: Boolean);
    procedure SetBeforeLoad(AValue: TNotifyEvent);
    procedure SetAfterLoad(AValue: TNotifyEvent);
    procedure SetName(const AValue: String);
    function Add: IFDStanDefinition;
    function AddTemporary: IFDStanDefinition;
    function FindDefinition(const AName: String): IFDStanDefinition;
    function DefinitionByName(const AName: String): IFDStanDefinition;
    procedure Cancel;
    procedure Save(AIfModified: Boolean = True);
    function Load: Boolean;
    function Refresh: Boolean;
    procedure Clear;
    procedure BeginRead;
    procedure EndRead;
    procedure BeginWrite;
    procedure EndWrite;
    // other
    function CreateIniFile: TCustomIniFile;
    function GetItemClass: TFDDefinitionClass; virtual;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TFDConnectionDef = class (TFDDefinition, IFDStanConnectionDef)
  private
    FPrevDriverID: String;
    procedure UpdateParamsObj(const ANewDriverID: String);
  protected
    // IFDStanConnectionDef
    function GetConnectionDefParams: TFDConnectionDefParams;
    procedure SetConnectionDefParams(AValue: TFDConnectionDefParams);
    procedure WriteOptions(AFormatOptions: TObject; AUpdateOptions: TObject;
      AFetchOptions: TObject; AResourceOptions: TObject);
    procedure ReadOptions(AFormatOptions: TObject; AUpdateOptions: TObject;
      AFetchOptions: TObject; AResourceOptions: TObject);
    // IFDStanDefinition
    procedure MarkPersistent; override;
    // TFDDefinition
    procedure Normalize; override;
  end;

  TFDConnectionDefTemporaryFactory = class(TFDMultyInstanceFactory)
  protected
    function CreateObject(const AProvider: String): TObject; override;
  public
    constructor Create;
  end;

  TFDConnectionDefs = class (TFDDefinitions, IFDStanConnectionDefs)
  protected
    // IFDStanConnectionDefs
    function GetConnectionDefs(AIndex: Integer): IFDStanConnectionDef;
    function AddConnectionDef: IFDStanConnectionDef;
    function FindConnectionDef(const AName: String): IFDStanConnectionDef;
    function ConnectionDefByName(const AName: String): IFDStanConnectionDef;
    // other
    function GetItemClass: TFDDefinitionClass; override;
  public
    procedure Initialize; override;
  end;

  TFDOptsComponent = class(TFDComponent)
  private
    FFetchOptions: TFDFetchOptions;
    FFormatOptions: TFDFormatOptions;
    FUpdateOptions: TFDUpdateOptions;
    FResourceOptions: TFDResourceOptions;
  published
    property FetchOptions: TFDFetchOptions read FFetchOptions write FFetchOptions;
    property FormatOptions: TFDFormatOptions read FFormatOptions write FFormatOptions;
    property UpdateOptions: TFDUpdateOptions read FUpdateOptions write FUpdateOptions;
    property ResourceOptions: TFDResourceOptions read FResourceOptions write FResourceOptions;
  end;

{-------------------------------------------------------------------------------}
{ TFDCustomDefinitionStorage                                                    }
{-------------------------------------------------------------------------------}
function TFDCustomDefinitionStorage.GetDefaultFileName: String;
begin
  Result := FDefaultFileName;
end;

{-------------------------------------------------------------------------------}
function TFDCustomDefinitionStorage.GetFileName: String;
begin
  Result := FFileName;
end;

{-------------------------------------------------------------------------------}
function TFDCustomDefinitionStorage.GetGlobalFileName: String;
begin
  Result := FGlobalFileName;
end;

{-------------------------------------------------------------------------------}
procedure TFDCustomDefinitionStorage.SetDefaultFileName(const AValue: String);
begin
  FDefaultFileName := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDCustomDefinitionStorage.SetFileName(const AValue: String);
begin
  FFileName := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDCustomDefinitionStorage.SetGlobalFileName(const AValue: String);
begin
  FGlobalFileName := AValue;
end;

{-------------------------------------------------------------------------------}
{ TFDFileDefinitionStorage                                                      }
{-------------------------------------------------------------------------------}
function TFDFileDefinitionStorage.ActualFileName: String;
begin
  Result := FDGetBestPath(GetFileName, GetGlobalFileName, GetDefaultFileName);
end;

{-------------------------------------------------------------------------------}
function TFDFileDefinitionStorage.CreateIniFile: TCustomIniFile;
var
  oIni: TMemIniFile;
begin
  oIni := TMemIniFile.Create(ActualFileName);
  oIni.AutoSave := True;
  if (oIni.Encoding = nil) or (oIni.Encoding = TEncoding.Default) then
    oIni.Encoding := TEncoding.UTF8;
  Result := oIni;
end;

{-------------------------------------------------------------------------------}
{- TFDDefinitionCollection                                                     -}
{-------------------------------------------------------------------------------}
type
  TFDDefinitionCollection = class(TCollection)
  private
    FDefinitionList: TFDDefinitions;
  public
    constructor Create(AList: TFDDefinitions;
      AItemClass: TFDDefinitionClass);
  end;

{-------------------------------------------------------------------------------}
constructor TFDDefinitionCollection.Create(AList: TFDDefinitions;
  AItemClass: TFDDefinitionClass);
begin
  inherited Create(AItemClass);
  FDefinitionList := AList;
end;

{-------------------------------------------------------------------------------}
{- TFDDefinition                                                               -}
{-------------------------------------------------------------------------------}
constructor TFDDefinition.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FParams := TFDConnectionDefParams.Create(Self);
  FParams.OnChange := ParamsChanged;
  FParams.OnChanging := ParamsChanging;
  Clear;
end;

{-------------------------------------------------------------------------------}
constructor TFDDefinition.CreateTemporary;
begin
  Create(nil);
  FParams.Clear;
  FStyle := atTemporary;
  Include(FFlags, dfRefManaged);
end;

{-------------------------------------------------------------------------------}
destructor TFDDefinition.Destroy;
begin
  CheckRO(dfDeleteDisabled);
  FParentDefinition := nil;
  FDFreeAndNil(FParams);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
{$IFNDEF AUTOREFCOUNT}
procedure TFDDefinition.AfterConstruction;
begin
  AtomicDecrement(FRefCount);
end;

{-------------------------------------------------------------------------------}
class function TFDDefinition.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TFDDefinition(Result).FRefCount := 1;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDDefinition._AddRef: Integer;
begin
{$IFDEF AUTOREFCOUNT}
  Result := __ObjAddRef;
{$ELSE}
  Result := AtomicIncrement(FRefCount);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDDefinition._Release: Integer;
begin
{$IFDEF AUTOREFCOUNT}
                                                   
  Result := __ObjRelease;
{$ELSE}
  Result := AtomicDecrement(FRefCount);
  if (Result = 0) and (dfRefManaged in FFlags) then
    Destroy;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetDefinitionList: TFDDefinitions;
begin
  if Collection <> nil then
    Result := TFDDefinitionCollection(Collection).FDefinitionList
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.InternalSetParentDefinition(const AValue: IFDStanDefinition);
begin
  if (AValue <> nil) and (AValue = Self as IFDStanDefinition) then
    FDException(Self, [S_FD_LStan, S_FD_LStan_PDef], er_FD_DefCircular, [GetName]);
  if FParentDefinition <> AValue then begin
    FParentDefinition := AValue;
    Normalize;
  end;
  Exclude(FFlags, dfParentMaybeChanged);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.SetParentDefinition(const AValue: IFDStanDefinition);
begin
  InternalSetParentDefinition(AValue);
  if AValue = nil then
    Include(FFlags, dfParentMaybeChanged);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.UpdateParentDefinition;
var
  s: String;
begin
  if (dfParentMaybeChanged in FFlags) and (GetDefinitionList <> nil) then begin
    Exclude(FFlags, dfParentMaybeChanged);
    s := GetAsString(S_FD_DefinitionParam_Common_Parent);
    if s = '' then
      s := GetAsString(S_FD_DefinitionParam_Common_ConnectionDef);
    if s <> '' then
      InternalSetParentDefinition(GetDefinitionList.DefinitionByName(s));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.Normalize;
var
  i, j: Integer;
  sName: String;
begin
  if FParentDefinition <> nil then begin
    FParams.BeginUpdate;
    try
      i := FParams.Count - 1;
      while i >= 0 do begin
        sName := FParams.KeyNames[i];
        if sName <> '' then begin
          j := FParams.IndexOfName(sName);
          if (j >= 0) and (j < i) then begin
            FParams.Delete(j);
            Dec(i);
          end;
          if AnsiCompareText(FParentDefinition.GetAsString(sName), FParams.Values[sName]) = 0 then
            FParams.Delete(i);
        end;
        Dec(i);
      end;
    finally
      FParams.EndUpdate;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.OverrideBy(const ADefinition: IFDStanDefinition; AAll: Boolean);
var
  i: Integer;
  sName, sValue: String;
begin
  CheckRO(dfModifyDisabled);
  if ADefinition <> nil then
    for i := 0 to ADefinition.Params.Count - 1 do begin
      sName := ADefinition.Params.KeyNames[i];
      sValue := ADefinition.Params.ValueFromIndex[i];
      if AAll or (sValue <> '') then
        SetAsString(sName, sValue);
    end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.ParseString(const AStr: String; AKeywords: TStrings): String;
begin
  Result := ParseString(AStr, AKeywords, GParseFmtSettings);
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.ParseString(const AStr: String; AKeywords: TStrings;
  const AFmt: TFDParseFmtSettings): String;
var
  i, j: Integer;
  sParam, sValue, sId, sODBCId: String;
  lFound: Boolean;
begin
  i := 1;
  Result := '';
  while i <= Length(AStr) do begin
    sParam := FDExtractFieldName(AStr, i, AFmt);
    j := Pos('=', sParam);
    if j <> 0 then begin
      sId := Copy(sParam, 1, j - 1);
      sValue := Copy(sParam, j + 1, Length(sParam));
    end
    else begin
      sId := S_FD_ConnParam_Common_Database;
      sValue := sParam;
    end;
    if (AKeywords <> nil) and (AKeywords.Count > 0) then begin
      lFound := False;
      for j := 0 to AKeywords.Count - 1 do begin
        sODBCId := AKeywords.ValueFromIndex[j];
        if (sODBCId <> '') and (sODBCId[Length(sODBCId)] = '*') then
          sODBCId:= Copy(sODBCId, 1, Length(sODBCId) - 1);
        if {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
           (sODBCId, sId) = 0 then begin
          sId := AKeywords.KeyNames[j];
          lFound := True;
        end
        else if {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
                (AKeywords[j], sId) = 0 then
          lFound := True;
        if lFound then
          Break;
      end;
    end
    else
      lFound := True;
    if sId <> '' then
      if lFound then begin
        if (sValue <> '') and (
            (sValue[1] = AFmt.FQuote) and (sValue[Length(sValue)] = AFmt.FQuote) or
            (sValue[1] = AFmt.FQuote1) and (sValue[Length(sValue)] = AFmt.FQuote2)
           ) then
          sValue := Copy(sValue, 2, Length(sValue) - 2);
        SetAsString(sId, sValue);
      end
      else begin
        if Result <> '' then
          Result := Result + AFmt.FDelimiter;
        Result := Result + sParam;
      end;
  end;
  Normalize;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.BuildString(AKeywords: TStrings): String;
begin
  Result := BuildString(AKeywords, GParseFmtSettings);
end;

{-------------------------------------------------------------------------------}
type
  TFDKwdValue = class(TObject)
  private
    FId, FVal: String;
    FKwdPos: Integer;
  public
    constructor Create(const AId, AVal: String; AKwdPos: Integer);
  end;

constructor TFDKwdValue.Create(const AId, AVal: String; AKwdPos: Integer);
begin
  inherited Create;
  FId := AId;
  FVal := AVal;
  FKwdPos := AKwdPos;
end;

function SortByKwdPos(AList: TStringList; AIndex1, AIndex2: Integer): Integer;
begin
  Result := TFDKwdValue(AList.Objects[AIndex1]).FKwdPos -
    TFDKwdValue(AList.Objects[AIndex2]).FKwdPos;
end;

function TFDDefinition.BuildString(AKeywords: TStrings; const AFmt: TFDParseFmtSettings): String;
var
  i, j, iParamsProcessed: Integer;
  sId, sVal: String;
  oKeywordValues: TFDStringList;
  oDef: IFDStanDefinition;
  oKwdValue: TFDKwdValue;

  procedure AddKwdValue(AKwdPos: Integer; const AID: String);
  begin
    if (sVal <> '') and (AID <> '') and (oKeywordValues.IndexOf(AID) = -1) then
      oKeywordValues.AddObject(AID, TFDKwdValue.Create(AID, sVal, AKwdPos));
  end;

  function AddParam(const AStr, AId, AValue: String): String;
  var
    lSpecialSymbol: Boolean;
    j: Integer;
    sId: String;
  begin
    lSpecialSymbol := False;
    sId := AId;
    if (sId <> '') and (sId[Length(sId)] = '*') then
      sId := Copy(sId, 1, Length(sId) - 1)
    else if not ((AValue[1] = AFmt.FQuote1) and (AValue[Length(AValue)] = AFmt.FQuote2) or
                (AValue[1] = AFmt.FQuote) and (AValue[Length(AValue)] = AFmt.FQuote)) then
      for j := 1 to Length(AValue) do
        case AValue[j] of
        '[', ']', '{', '}', '(', ')', ',', ';', '?', '*', '=', '!', '@':
          begin
            lSpecialSymbol := True;
            Break;
          end;
        end;
    if lSpecialSymbol then
      Result := Format('%s%s=%s%s%s%s', [AStr, sId, AFmt.FQuote1, AValue,
        AFmt.FQuote2, AFmt.FDelimiter])
    else
      Result := Format('%s%s=%s%s', [AStr, sId, AValue, AFmt.FDelimiter]);
  end;

begin
  oKeywordValues := TFDStringList.Create(dupIgnore, True, False);
  iParamsProcessed := 0;
  try
    oDef := Self as IFDStanDefinition;
    while oDef <> nil do begin
      for i := 0 to oDef.Params.Count - 1 do begin
        sId := oDef.Params.KeyNames[i];
        sVal := FDExpandStr(oDef.Params.ValueFromIndex[i]);
        Inc(iParamsProcessed);
        if (sVal <> '') and (AKeywords <> nil) and (AKeywords.Count > 0) then
          for j := 0 to AKeywords.Count - 1 do begin
            if {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
               (AKeywords[j], sId) = 0 then
              AddKwdValue(j, sId)
            else if {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
                    (AKeywords.KeyNames[j], sId) = 0 then
              AddKwdValue(j, AKeywords.ValueFromIndex[j]);
          end
        else
          AddKwdValue(iParamsProcessed, sId);
      end;
      oDef := oDef.ParentDefinition;
    end;

    Result := '';
    oKeywordValues.Sorted := False;
    oKeywordValues.CustomSort(SortByKwdPos);
    for i := 0 to oKeywordValues.Count - 1 do begin
      oKwdValue := TFDKwdValue(oKeywordValues.Objects[i]);
      Result := AddParam(Result, oKwdValue.FId, oKwdValue.FVal);
      FDFree(oKwdValue);
    end;
    if (Result <> '') and (Result[Length(Result)] = AFmt.FDelimiter) then
      SetLength(Result, Length(Result) - 1);

  finally
    FDFree(oKeywordValues);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.CheckRO(AFlag: TFDDefinitionFlag);
var
  s: String;
begin
  if (FPassCode <> 0) and (AFlag in FFlags) then begin
    if AFlag = dfModifyDisabled then
      s := 'change'
    else
      s := 'delete';
    FDException(Self, [S_FD_LStan, S_FD_LStan_PDef], er_FD_DefRO, [s, GetName]);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.ParamsChanging(Sender: TObject);
begin
  CheckRO(dfModifyDisabled);
  FPrevName := GetName;
  if Assigned(FOnChanging) then
    FOnChanging(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.ParamsChanged(Sender: TObject);
var
  sNewName: String;
begin
  if FState = asLoaded then
    FState := asModified;
  Include(FFlags, dfParentMaybeChanged);
  if (Collection <> nil) and (FPrevName <> '') then
    try
      sNewName := GetName;
      if (FPrevName <> sNewName) and not DefinitionList.IsUniqueName(sNewName, Self) then begin
        SetName(FPrevName);
        FDException(Self, [S_FD_LStan, S_FD_LStan_PDef], er_FD_DefDupName, [sNewName]);
      end;
    finally
      FPrevName := '';
    end;
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.Clear;
begin
  CheckRO(dfModifyDisabled);
  FParams.Clear;
  FOriginalName := '';
  FPrevName := '';
  if Collection <> nil then
    SetName(DefinitionList.BuildUniqueName(S_FD_Unnamed, Self))
  else
    SetName(S_FD_Unnamed);
  if FState <> asLoading then
    FState := asAdded;
  if FStyle <> atTemporary then begin
    FStyle := atPrivate;
    Exclude(FFlags, dfRefManaged);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.Apply;
var
  oIni: TCustomIniFile;
begin
  if (FStyle = atPersistent) and (FState <> asLoaded) then begin
    oIni := DefinitionList.CreateIniFile;
    try
      WriteTo(oIni, True);
    finally
      FDFree(oIni);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.Cancel;
var
  oIni: TCustomIniFile;
begin
  CheckRO(dfModifyDisabled);
  if (FStyle = atPrivate) or
     (FStyle = atPersistent) and (FState = asAdded) then begin
    DefinitionList.InternalDelete(Self);
    Exit;
  end
  else if (FStyle = atPersistent) and (FState <> asLoaded) then begin
    SetName(FOriginalName);
    oIni := DefinitionList.CreateIniFile;
    try
      if oIni.SectionExists(FOriginalName) then
        ReadFrom(oIni);
    finally
      FDFree(oIni);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.Delete;
begin
  CheckRO(dfDeleteDisabled);
  if (FStyle = atPrivate) or
     (FStyle = atPersistent) and (FState = asAdded) then
    Cancel
  else
    FState := asDeleted;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.MarkPersistent;
begin
  if (DefinitionList = nil) or (GetName = '') then
    FDException(Self, [S_FD_LStan, S_FD_LStan_PDef], er_FD_DefCantMakePers, []);
  FStyle := atPersistent;
  Exclude(FFlags, dfRefManaged);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.MarkUnchanged;
begin
  if FStyle = atPersistent then
    case FState of
    asAdded,
    asModified:
      begin
        FOriginalName := GetName;
        FState := asLoaded;
      end;
    asDeleted:
      DefinitionList.InternalDelete(Self);
    end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.HasValue(const AName: String): Boolean;
var
  iLevel: Integer;
begin
  iLevel := 0;
  Result := HasValue(AName, iLevel);
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.HasValue(const AName: String; var ALevel: Integer): Boolean;
var
  i: Integer;
  s: String;
begin
  Result := False;
  i := FParams.IndexOfName(AName);
  if i = -1 then begin
    if GetParentDefinition <> nil then begin
      Inc(ALevel);
      Result := GetParentDefinition.HasValue(AName, ALevel);
    end;
    if not Result then
      ALevel := $7FFFFFFF;
  end
  else begin
    s := FParams.ValueFromIndex[i];
    if (s <> '') and ((s[1] <= ' ') or (s[Length(s)] <= ' ')) then
      s := Trim(s);
    Result := (s <> '');
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.OwnValue(const AName: String): Boolean;
begin
  Result := (FParams.IndexOfName(AName) <> -1);
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.IsSpecified(const AName: String): Boolean;
var
  i, iLevel: Integer;
begin
  i := FParams.IndexOfName(AName);
  if i > -1 then
    Result := True
  else if GetParentDefinition <> nil then begin
    iLevel := 1;
    Result := GetParentDefinition.HasValue(AName, iLevel);
  end
  else
    Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.ToggleUpdates(APassCode: LongWord; ADisableDelete, ADisableModify: Boolean);

  procedure SetFlags;
  begin
    if ADisableDelete then
      Include(FFlags, dfDeleteDisabled)
    else
      Exclude(FFlags, dfDeleteDisabled);
    if ADisableModify then
      Include(FFlags, dfModifyDisabled)
    else
      Exclude(FFlags, dfModifyDisabled);
  end;

begin
  if FPassCode = 0 then begin
    if ADisableDelete or ADisableModify then begin
      FPassCode := APassCode;
      SetFlags;
    end;
  end
  else if FPassCode <> APassCode then
    FDException(Self, [S_FD_LStan, S_FD_LStan_PDef], er_FD_DefRO, ['unprotect', GetName])
  else begin
    SetFlags;
    if not ADisableDelete and not ADisableModify then
      FPassCode := 0;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetUpdatable: Boolean;
begin
  Result := FPassCode = 0;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetAsString(const AName: String): String;
var
  i: Integer;
begin
  Result := '';
  i := FParams.IndexOfName(AName);
  if i = -1 then begin
    if GetParentDefinition <> nil then
      Result := GetParentDefinition.GetAsString(AName);
  end
  else begin
    Result := FParams.ValueFromIndex[i];
    if (Result <> '') and ((Result[1] <= ' ') or (Result[Length(Result)] <= ' ')) then
      Result := Trim(Result);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetAsXString(const AName: String): String;
var
  sName: String;
  iLvlSpc, iLvlGen: Integer;
  lSpc, lGen: Boolean;
begin
  sName := AName;
{$IFDEF MSWINDOWS}
  {$IFDEF FireDAC_32}
  sName := sName + S_FD_Win32;
  {$ENDIF}
  {$IFDEF FireDAC_64}
  sName := sName + S_FD_Win64;
  {$ENDIF}
{$ENDIF}
{$IFDEF MACOS}
  {$IFDEF FireDAC_32}
  sName := sName + S_FD_OSX32;
  {$ENDIF}
  {$IFDEF FireDAC_64}
  sName := sName + S_FD_OSX64;
  {$ENDIF}
{$ENDIF}
{$IFDEF LINUX}
  {$IFDEF FireDAC_32}
  sName := sName + S_FD_UIX32;
  {$ENDIF}
  {$IFDEF FireDAC_64}
  sName := sName + S_FD_UIX64;
  {$ENDIF}
{$ENDIF}
{$IFDEF ANDROID}
  sName := sName + S_FD_ANDROID;
{$ENDIF}
  iLvlSpc := 0;
  iLvlGen := 0;
  lSpc := HasValue(sName, iLvlSpc);
  lGen := HasValue(AName, iLvlGen);
  if lSpc or lGen then
    if iLvlSpc < iLvlGen then
      Result := GetAsString(sName)
    else
      Result := GetAsString(AName);
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetAsBoolean(const AName: String): LongBool;
var
  s: String;
begin
  s := GetAsString(AName);
  Result := (Length(s) > 0) and (
    (s[1] = 'Y') or (s[1] = 'y') or (s[1] = 'T') or (s[1] = 't'));
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetAsInteger(const AName: String): LongInt;
begin
  Result := StrToIntDef(GetAsString(AName), 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.SetAsString(const AName, AValue: String);
var
  sVal: String;
  i: Integer;
begin
  CheckRO(dfModifyDisabled);
  sVal := Trim(AValue);
  if GetAsString(AName) <> sVal then begin
    FParams.BeginUpdate;
    try
      if GetParentDefinition <> nil then
        if AnsiCompareText(GetParentDefinition.GetAsString(AName), sVal) = 0 then begin
          i := FParams.IndexOfName(AName);
          if i <> -1 then
            FParams.Delete(i);
        end
        else
          FParams.Values[AName] := sVal
      else
        FParams.Values[AName] := sVal;
    finally
      FParams.EndUpdate;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.SetAsBoolean(const AName: String; const AValue: LongBool);
begin
  if not HasValue(AName) or (GetAsBoolean(AName) <> AValue) then
    if AValue then
      SetAsString(AName, S_FD_True)
    else
      SetAsString(AName, S_FD_False);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.SetAsYesNo(const AName: String; const AValue: LongBool);
begin
  if not HasValue(AName) or (GetAsBoolean(AName) <> AValue) then
    if AValue then
      SetAsString(AName, S_FD_Yes)
    else
      SetAsString(AName, S_FD_No);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.SetAsInteger(const AName: String; const AValue: LongInt);
begin
  if not HasValue(AName) or (GetAsInteger(AName) <> AValue) then
    SetAsString(AName, IntToStr(AValue));
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetName: String;
begin
  Result := GetAsString(S_FD_DefinitionParam_Common_Name);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.SetName(const AValue: string);
begin
  SetAsString(S_FD_DefinitionParam_Common_Name, AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetParams: TStrings;
begin
  Result := FParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.SetParams(const AValue: TStrings);
begin
  CheckRO(dfModifyDisabled);
  FParams.SetStrings(AValue);
  Normalize;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetParentDefinition: IFDStanDefinition;
begin
  UpdateParentDefinition;
  Result := FParentDefinition;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetState: TFDDefinitionState;
begin
  Result := FState;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetStyle: TFDDefinitionStyle;
begin
  Result := FStyle;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetOnChanged: TNotifyEvent;
begin
  Result := FOnChanged;
end;

{-------------------------------------------------------------------------------}
function TFDDefinition.GetOnChanging: TNotifyEvent;
begin
  Result := FOnChanging;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.SetOnChanged(AValue: TNotifyEvent);
begin
  FOnChanged := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.SetOnChanging(AValue: TNotifyEvent);
begin
  FOnChanging := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.ReadFrom(AReader: TCustomIniFile);
var
  sName: String;
  lLoaded: Boolean;
begin
  CheckRO(dfModifyDisabled);
  sName := GetName;
  FState := asLoading;
  lLoaded := False;
  try
    Clear;
    if AReader.SectionExists(sName) then
      try
        AReader.ReadSectionValues(sName, FParams);
        Normalize;
        FStyle := atPersistent;
        Exclude(FFlags, dfRefManaged);
        FOriginalName := sName;
        lLoaded := True;
      except
        Clear;
        raise;
      end;
  finally
    SetName(sName);
    if lLoaded then
      FState := asLoaded
    else
      FState := asAdded;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.WriteTo(AWriter: TCustomIniFile; AIfModified: Boolean = True);
var
  sName: String;
  sOrigName: String;

  procedure DeleteOldSection;
  begin
    if (sOrigName <> '') and AWriter.SectionExists(sOrigName) then
      AWriter.EraseSection(sOrigName);
  end;

  procedure WriteNewSection;
  var
    i: Integer;
  begin
    for i := 0 to FParams.Count - 1 do
      if CompareText(FParams.KeyNames[i], S_FD_DefinitionParam_Common_Name) <> 0 then
        AWriter.WriteString(sName, FParams.KeyNames[i], FParams.ValueFromIndex[i]);
  end;

begin
  if FStyle = atPersistent then begin
    sName := GetName;
    sOrigName := FOriginalName;
    case FState of
    asLoaded:
      if not AIfModified then
        WriteNewSection;
    asModified:
      begin
        DeleteOldSection;
        WriteNewSection;
        FState := asLoaded;
      end;
    asDeleted:
      begin
        DeleteOldSection;
        DefinitionList.InternalDelete(Self);
      end;
    asAdded:
      begin
        WriteNewSection;
        FState := asLoaded;
      end;
    end;
    FOriginalName := sName;
  end;
end;

{-------------------------------------------------------------------------------}
{$IFDEF FireDAC_MONITOR}
procedure TFDDefinition.BaseTrace(const AMonitor: IFDMoniClient);
var
  i: Integer;
  sName, s: String;
begin
  if GetParentDefinition <> nil then
    GetParentDefinition.BaseTrace(AMonitor);
  for i := 0 to FParams.Count - 1 do begin
    sName := FParams.KeyNames[i];
    if Pos(UpperCase(S_FD_ConnParam_Common_Password), UpperCase(sName)) <> 0 then
      s := sName + '=*****'
    else
      s := FParams[i];
    AMonitor.Notify(ekConnService, esProgress, Self, s, []);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinition.Trace(const AMonitor: IFDMoniClient);
begin
  if (AMonitor <> nil) and AMonitor.Tracing then begin
    AMonitor.Notify(ekConnService, esStart, Self, 'Definition', ['Name', GetName]);
    BaseTrace(AMonitor);
    AMonitor.Notify(ekConnService, esEnd, Self, 'Definition', ['Name', GetName]);
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TFDDefinitionTemporaryFactory                                                 }
{-------------------------------------------------------------------------------}
constructor TFDDefinitionTemporaryFactory.Create;
begin
  inherited Create(nil, IFDStanDefinition);
end;

{-------------------------------------------------------------------------------}
function TFDDefinitionTemporaryFactory.CreateObject(const AProvider: String): TObject;
begin
  Result := TFDDefinition.CreateTemporary;
end;

{-------------------------------------------------------------------------------}
{- TFDDefinitions                                                              -}
{-------------------------------------------------------------------------------}
procedure TFDDefinitions.Initialize;
begin
  inherited Initialize;
  FAutoLoad := True;
  FState := dsNotLoaded;
  FDCreateInterface(IFDStanDefinitionStorage, FStorage);
  FList := TFDDefinitionCollection.Create(Self, GetItemClass);
  FLock := TMultiReadExclusiveWriteSynchronizer.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDDefinitions.Destroy;
begin
  FState := dsNotLoaded;
  FStorage := nil;
  FDFreeAndNil(FList);
  FDFreeAndNil(FLock);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetItemClass: TFDDefinitionClass;
begin
  Result := TFDDefinition;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.CreateIniFile: TCustomIniFile;
begin
  Result := FStorage.CreateIniFile;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.CheckLoaded;
begin
  if (FState = dsNotLoaded) and FAutoLoad then
    Load;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetLoaded: Boolean;
begin
  Result := (FState = dsLoaded);
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetAutoLoad: Boolean;
begin
  Result := FAutoLoad;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.SetAutoLoad(AValue: Boolean);
begin
  FAutoLoad := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetStorage: IFDStanDefinitionStorage;
begin
  Result := FStorage;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetAfterLoad: TNotifyEvent;
begin
  Result := FAfterLoad;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetBeforeLoad: TNotifyEvent;
begin
  Result := FBeforeLoad;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetName: String;
begin
  Result := FName;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.SetAfterLoad(AValue: TNotifyEvent);
begin
  FAfterLoad := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.SetBeforeLoad(AValue: TNotifyEvent);
begin
  FBeforeLoad := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.SetName(const AValue: String);
begin
  FName := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.InternalAdd: TFDDefinition;
begin
  BeginWrite;
  try
    CheckLoaded;
    Result := TFDDefinition(FList.Add);
  finally
    EndWrite;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.Add: IFDStanDefinition;
begin
  Result := InternalAdd as IFDStanDefinition;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.AddTemporary: IFDStanDefinition;
begin
  Result := GetItemClass.CreateTemporary as IFDStanDefinition;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.InternalDelete(ADefinition: TFDDefinition);
var
  i: Integer;
  oDef: IFDStanDefinition;
begin
  BeginWrite;
  try
    oDef := ADefinition as IFDStanDefinition;
    for i := 0 to FList.Count - 1 do
      if TFDDefinition(FList.Items[i]).GetParentDefinition = oDef then
        TFDDefinition(FList.Items[i]).SetParentDefinition(nil);
    Include(ADefinition.FFlags, dfRefManaged);
    if ADefinition.FRefCount = 0 then
      FDFree(ADefinition);
  finally
    EndWrite;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.Cancel;
var
  i: Integer;
begin
  BeginWrite;
  try
    for i := FList.Count - 1 downto 0 do
      TFDDefinition(FList.Items[i]).Cancel;
  finally
    EndWrite;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.Save(AIfModified: Boolean = True);
var
  i: Integer;
  oIni: TCustomIniFile;
begin
  BeginWrite;
  try
    oIni := CreateIniFile;
    try
      if GetName <> '' then
        oIni.WriteString(GetName, 'Encoding', 'UTF8');
      for i := FList.Count - 1 downto 0 do
        TFDDefinition(FList.Items[i]).WriteTo(oIni, AIfModified);
    finally
      FDFree(oIni);
    end;
  finally
    EndWrite;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.InternalLoad(ARefresh: Boolean): Boolean;
var
  oList: TFDStringList;
  oIni: TCustomIniFile;
  i, j: Integer;
  oDef: TFDDefinition;
begin
  BeginWrite;
  try
    if not ARefresh and (FState <> dsNotLoaded) then
      FDException(Self, [S_FD_LStan, S_FD_LStan_PDef], er_FD_DefAlreadyLoaded, []);
    FState := dsLoading;
    Result := False;
    try
      if Assigned(FBeforeLoad) then
        FBeforeLoad(Self);
      oList := TFDStringList.Create;
      try
        oIni := CreateIniFile;
        try
          if FileExists(GetStorage.ActualFileName) then begin
            Result := True;
            oIni.ReadSections(oList);
            oList.Sort;
            for i := 0 to oList.Count - 1 do
              if (GetName = '') or (CompareText(oList[i], GetName) <> 0) then begin
                if ARefresh then begin
                  oDef := InternalFindDefinition(oList[i], nil);
                  if (oDef <> nil) and not oDef.GetUpdatable then
                    Continue;
                end
                else
                  oDef := nil;
                if oDef = nil then begin
                  oDef := InternalAdd;
                  oDef.SetName(oList[i]);
                end;
                oDef.ReadFrom(oIni);
              end;
            if ARefresh then
              for i := FList.Count - 1 downto 0 do begin
                oDef := TFDDefinition(FList.Items[i]);
                if not oList.Find(oDef.GetName, j) and oDef.GetUpdatable
                                                
{$IFNDEF AUTOREFCOUNT}
                   and (oDef.FRefCount = 0)
{$ENDIF}
                   then
                  FDFreeAndNil(oDef);
              end;
          end;
        finally
          FDFree(oIni);
        end;
      finally
        FDFree(oList);
      end;
    finally
      FState := dsLoaded;
      if Assigned(FAfterLoad) then
        FAfterLoad(Self);
    end;
  finally
    EndWrite;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.Load: Boolean;
begin
  Result := InternalLoad(False);
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.Refresh: Boolean;
begin
  Result := InternalLoad(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.Clear;
var
  i: Integer;
begin
  BeginWrite;
  try
    for i := 0 to FList.Count - 1 do
      TFDDefinition(FList.Items[i]).FParentDefinition := nil;
    FList.Clear;
    FState := dsNotLoaded;
  finally
    EndWrite;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.InternalFindDefinition(const AName: String;
  AExclude: TFDDefinition): TFDDefinition;
var
  i: Integer;
  oDef: TFDDefinition;
begin
  Result := nil;
  FLock.BeginRead;
  try
    CheckLoaded;
    for i := 0 to FList.Count - 1 do begin
      oDef := TFDDefinition(FList.Items[i]);
      if (oDef <> AExclude) and (
         {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
         (oDef.GetName, AName) = 0) then begin
        Result := oDef;
        Break;
      end;
    end;
  finally
    FLock.EndRead;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.FindDefinition(const AName: String): IFDStanDefinition;
begin
  Result := InternalFindDefinition(AName, nil) as IFDStanDefinition;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.DefinitionByName(const AName: String): IFDStanDefinition;
begin
  Result := FindDefinition(AName);
  if Result = nil then
    FDException(Self, [S_FD_LStan, S_FD_LStan_PDef], er_FD_DefNotExists,
      [AName, FStorage.ActualFilename]);
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.BuildUniqueName(const AName: String; AItem: TFDDefinition): String;
var
  i: Integer;
begin
  Result := AName;
  i := 0;
  FLock.BeginRead;
  try
    while InternalFindDefinition(Result, AItem) <> nil do begin
      Inc(i);
      Result := AName + '_' + IntToStr(i);
    end;
  finally
    FLock.EndRead;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.IsUniqueName(const AName: String; AItem: TFDDefinition): Boolean;
begin
  Result := InternalFindDefinition(AName, AItem) = nil;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetCount: Integer;
begin
  FLock.BeginRead;
  try
    CheckLoaded;
    Result := FList.Count;
  finally
    FLock.EndRead;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetItems(AIndex: Integer): IFDStanDefinition;
begin
  FLock.BeginRead;
  try
    CheckLoaded;
    Result := TFDDefinition(FList.Items[AIndex]) as IFDStanDefinition;
  finally
    FLock.EndRead;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.BeginRead;
begin
  FLock.BeginRead;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.EndRead;
begin
  FLock.EndRead;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.BeginWrite;
begin
  FLock.BeginWrite;
end;

{-------------------------------------------------------------------------------}
procedure TFDDefinitions.EndWrite;
begin
  FLock.EndWrite;
end;

{-------------------------------------------------------------------------------}
function TFDDefinitions.GetUpdatable: Boolean;
var
  i: Integer;
begin
  Result := True;
  BeginRead;
  try
    for i := 0 to FList.Count - 1 do
      if not TFDDefinition(FList.Items[i]).GetUpdatable then begin
        Result := False;
        Break;
      end;
  finally
    EndRead;
  end;
end;

{-------------------------------------------------------------------------------}
{- TFDConnectionDef                                                            -}
{-------------------------------------------------------------------------------}
procedure TFDConnectionDef.UpdateParamsObj(const ANewDriverID: String);
var
  oParamsIntf: IFDStanConnectionDefParams;
  oParams: TFDConnectionDefParams;
begin
  oParams := nil;
  if ANewDriverID <> '' then begin
    FDCreateInterface(IFDStanConnectionDefParams, oParamsIntf, False, ANewDriverID);
    if oParamsIntf <> nil then
      oParams := oParamsIntf.CreateParams(Self) as TFDConnectionDefParams;
  end;
  if not ((oParams = nil) and (FParams.ClassType = TFDConnectionDefParams)) then begin
    if oParams = nil then
      oParams := TFDConnectionDefParams.Create(Self);
    oParams.SetStrings(FParams);
    oParams.OnChanging := FParams.OnChanging;
    oParams.OnChange := FParams.OnChange;
    FDFreeAndNil(FParams);
    FParams := oParams;
  end;
  FPrevDriverID := ANewDriverID;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDef.GetConnectionDefParams: TFDConnectionDefParams;
var
  sNewDriverID: String;
begin
  sNewDriverID := GetAsString(S_FD_ConnParam_Common_DriverID);
  if CompareText(FPrevDriverID, sNewDriverID) <> 0 then
    UpdateParamsObj(sNewDriverID);
  Result := TFDConnectionDefParams(FParams);
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDef.SetConnectionDefParams(AValue: TFDConnectionDefParams);
begin
  FParams.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDef.MarkPersistent;
begin
  if GetAsString(S_FD_ConnParam_Common_DriverID) = '' then
    FDException(Self, [S_FD_LStan, S_FD_LStan_PDef], er_FD_DefCantMakePers, []);
  inherited MarkPersistent;
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDef.Normalize;
begin
  inherited Normalize;
  GetConnectionDefParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDef.ReadOptions(AFormatOptions: TObject;
  AUpdateOptions: TObject; AFetchOptions: TObject; AResourceOptions: TObject);
var
  oComp: TFDOptsComponent;
  oMS: TMemoryStream;
  oStr: TStringStream;
  oRdr: TReader;
  i: Integer;
  s, sName: String;
  oDef: IFDStanConnectionDef;
begin
  s := 'object TFDOptsComponent' + C_FD_EOL;
  oDef := Self as IFDStanConnectionDef;
  while oDef <> nil do begin
    for i := 0 to oDef.Params.Count - 1 do begin
      sName := LowerCase(oDef.Params.KeyNames[i]);
      if (Pos('fetchoptions.', sName) <> 0) or (Pos('formatoptions.', sName) <> 0) or
         (Pos('updateoptions.', sName) <> 0) or (Pos('resourceoptions.', sName) <> 0) then
        s := s + oDef.Params[i] + C_FD_EOL;
    end;
    oDef := oDef.ParentDefinition as IFDStanConnectionDef;
  end;
  s := s + 'end';
  oComp := TFDOptsComponent.Create(nil);
  try
    oComp.FetchOptions := AFetchOptions as TFDFetchOptions;
    oComp.UpdateOptions := AUpdateOptions as TFDUpdateOptions;
    oComp.FormatOptions := AFormatOptions as TFDFormatOptions;
    oComp.ResourceOptions := AResourceOptions as TFDResourceOptions;
    oStr := TStringStream.Create(s);
    try
      oMS := TMemoryStream.Create;
      oRdr := TReader.Create(oMS, 4096);
      try
        ObjectTextToBinary(oStr, oMS);
        oMS.Position := 0;
        oRdr.BeginReferences;
        try
          oRdr.ReadSignature;
          oRdr.ReadComponent(oComp);
        finally
          oRdr.EndReferences;
        end;
      finally
        FDFree(oRdr);
        FDFree(oMS);
      end;
    finally
      FDFree(oStr);
    end;
  finally
    FDFree(oComp);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDConnectionDef.WriteOptions(AFormatOptions: TObject;
  AUpdateOptions: TObject; AFetchOptions: TObject; AResourceOptions: TObject);
var
  oComp: TFDOptsComponent;
  oMS: TMemoryStream;
  oStr: TStringStream;
  i: Integer;
  pCh, pStart, pEnd, pWS: PChar;
  lValue, lCollection: Boolean;
  s, sName: String;
begin
  oComp := TFDOptsComponent.Create(nil);
  try
    oComp.FetchOptions := AFetchOptions as TFDFetchOptions;
    oComp.UpdateOptions := AUpdateOptions as TFDUpdateOptions;
    oComp.FormatOptions := AFormatOptions as TFDFormatOptions;
    oComp.ResourceOptions := AResourceOptions as TFDResourceOptions;
    oMS := TMemoryStream.Create;
    try
      oMS.WriteComponent(oComp);
      oStr := TStringStream.Create('');
      try
        oMS.Position := 0;
        ObjectBinaryToText(oMS, oStr);
        s := oStr.DataString;
        pCh := PChar(s);
        while pCh^ <> #13 do
          Inc(pCh);
        pEnd := PChar(s) + Length(s) - 1;
        for i := 1 to 2 do begin
          while pEnd^ <> #13 do
            Dec(pEnd);
          if i <> 2 then
            Dec(pEnd)
          else
            Inc(pEnd)
        end;
        lValue := False;
        lCollection := False;
        Inc(pCh, 2);
        pStart := pCh;
        while pCh <= pEnd do begin
          if lCollection then begin
            if pCh^ = '>' then
              lCollection := False
            else if pCh^ = #13 then begin
              pCh^ := ' ';
              (pCh + 1)^ := ' ';
            end;
            if pCh^ = ' ' then begin
              pWS := pCh;
              while pCh^ = ' ' do
                Inc(pCh);
              if pCh - pWS > 1 then begin
                Move(pCh^, (pWS + 1)^, (pEnd - pCh + 1) * SizeOf(Char));
                Dec(pEnd, pCh - pWS - 1);
                Dec(pCh, pCh - pWS - 1);
              end;
            end
            else
              Inc(pCh);
          end
          else begin
            if (pCh^ = ' ') and not lValue then begin
              Move((pCh + 1)^, pCh^, (pEnd - pCh) * SizeOf(Char));
              Dec(pEnd);
            end
            else begin
              if pCh^ = '=' then
                lValue := True
              else if pCh^ = #10 then
                lValue := False
              else if pCh^ = '<' then
                lCollection := True;
              Inc(pCh);
            end;
          end;
        end;
        if pEnd - pStart - 1 > 0 then
          SetString(s, pStart, pEnd - pStart - 1)
        else
          s := '';
        i := 0;
        while i < GetParams.Count do begin
          sName := GetParams.KeyNames[i];
          if (CompareText(sName, 'FetchOptions') = 0) or (CompareText(sName, 'FormatOptions') = 0) or
             (CompareText(sName, 'UpdateOptions') = 0) or (CompareText(sName, 'ResourceOptions') = 0) then
            GetParams.Delete(i)
          else
            Inc(i);
        end;
        if s <> '' then
          GetParams.Text := GetParams.Text + s;
      finally
        FDFree(oStr);
      end;
    finally
      FDFree(oMS);
    end;
  finally
    FDFree(oComp);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDConnectionDefTemporaryFactory                                              }
{-------------------------------------------------------------------------------}
constructor TFDConnectionDefTemporaryFactory.Create;
begin
  inherited Create(nil, IFDStanConnectionDef);
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefTemporaryFactory.CreateObject(const AProvider: String): TObject;
begin
  Result := TFDConnectionDef.CreateTemporary;
end;

{-------------------------------------------------------------------------------}
{- TFDConnectionDefs                                                           -}
{-------------------------------------------------------------------------------}
procedure TFDConnectionDefs.Initialize;
begin
  inherited Initialize;
  SetName(S_FD_DefCfgFileName);
  GetStorage.DefaultFileName := S_FD_DefCfgFileName;
  GetStorage.GlobalFileName := FDLoadConnDefGlobalFileName;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefs.GetItemClass: TFDDefinitionClass;
begin
  Result := TFDConnectionDef;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefs.AddConnectionDef: IFDStanConnectionDef;
begin
  Result := inherited Add as IFDStanConnectionDef;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefs.FindConnectionDef(const AName: String): IFDStanConnectionDef;
begin
  Result := inherited FindDefinition(AName) as IFDStanConnectionDef;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefs.ConnectionDefByName(const AName: String): IFDStanConnectionDef;
begin
  Result := inherited DefinitionByName(AName) as IFDStanConnectionDef;
end;

{-------------------------------------------------------------------------------}
function TFDConnectionDefs.GetConnectionDefs(AIndex: Integer): IFDStanConnectionDef;
begin
  Result := inherited GetItems(AIndex) as IFDStanConnectionDef;
end;

{-------------------------------------------------------------------------------}
procedure FDSaveConnDefGlobalFileName(const AName: String);
begin
  FDWriteRegValue(S_FD_CfgValName, AName);
end;

{-------------------------------------------------------------------------------}
function FDLoadConnDefGlobalFileName: String;
begin
  Result := FDReadRegValue(S_FD_CfgValName);
end;

{-------------------------------------------------------------------------------}
procedure FDSaveDriverDefGlobalFileName(const AName: String);
begin
  FDWriteRegValue(S_FD_DrvValName, AName);
end;

{-------------------------------------------------------------------------------}
function FDLoadDriverDefGlobalFileName: String;
begin
  Result := FDReadRegValue(S_FD_DrvValName);
end;

{-------------------------------------------------------------------------------}
var
  oFact1,
  oFact2,
  oFact3,
  oFact4,
  oFact5: TFDFactory;

initialization
  oFact1 := TFDMultyInstanceFactory.Create(TFDFileDefinitionStorage, IFDStanDefinitionStorage);
  oFact2 := TFDDefinitionTemporaryFactory.Create;
  oFact3 := TFDMultyInstanceFactory.Create(TFDDefinitions, IFDStanDefinitions);
  oFact4 := TFDConnectionDefTemporaryFactory.Create;
  oFact5 := TFDMultyInstanceFactory.Create(TFDConnectionDefs, IFDStanConnectionDefs);

finalization
  FDReleaseFactory(oFact1);
  FDReleaseFactory(oFact2);
  FDReleaseFactory(oFact3);
  FDReleaseFactory(oFact4);
  FDReleaseFactory(oFact5);

end.
